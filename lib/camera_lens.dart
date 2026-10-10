// Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'localization.dart';

const _channel = MethodChannel('de.l9g.qr_viewer/camera');

/// Eine Zoomstufe der Rückkamera wie in der Kamera-App, z. B. 0,5× · 1× ·
/// 2× · 5×: ein Objektiv, optional mit digitalem Zoom (2× auf dem
/// 48-MP-Hauptsensor ist ein Ausschnitt der Hauptkamera).
@immutable
class ZoomStep {
  const ZoomStep(this.lens, {this.factor, this.digitalZoom = 1});

  /// Das System wählt das Objektiv (auf iPhones mit Makro-Umschaltung).
  static const auto = ZoomStep(CameraLensType.any);

  final CameraLensType lens;

  /// Vergrößerung relativ zur Hauptkamera, null wenn unbekannt.
  final double? factor;

  /// Digitaler Zoom auf dem Objektiv, 1 = keiner.
  final double digitalZoom;

  bool get isAuto => lens == CameraLensType.any;

  /// Kennung zum Speichern, z. B. "normal@2".
  String get id => isAuto ? 'auto' : '${lens.name}@${_trim(digitalZoom)}';

  /// Startwert für [MobileScannerController.initialZoom]. iOS rechnet mit
  /// einer Skala 0–1 für 1×–5×. Android nimmt Werte über 1 als Verhältnis
  /// und 0–1 linear; 0 ist das kleinste Verhältnis, bei logischen
  /// Mehrfachkameras das Ultraweitwinkel.
  double? initialZoom(TargetPlatform platform) {
    if (digitalZoom == 1) return null;
    if (platform == TargetPlatform.iOS) {
      return digitalZoom < 1 ? null : ((digitalZoom - 1) / 4).clamp(0.0, 1.0);
    }
    return digitalZoom < 1 ? 0 : digitalZoom;
  }

  @override
  bool operator ==(Object other) => other is ZoomStep && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ZoomStep($id, factor: $factor)';
}

String _trim(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();

/// Ermittelt die Zoomstufen der Rückseite. iOS liefert die Faktoren aus den
/// Umschaltpunkten der Mehrfachkamera und die Sensor-Ausschnitte (2×),
/// Android aus den Kleinbild-Brennweiten. Fehlt die native Abfrage, gelten
/// die Objektive von mobile_scanner mit üblichen Faktoren.
Future<List<ZoomStep>> detectZoomSteps() async {
  try {
    final raw = await _channel.invokeListMethod<Map<Object?, Object?>>(
      'zoomSteps',
    );
    final steps = [for (final m in raw ?? const []) ?_parse(m)];
    if (steps.isNotEmpty) return steps;
  } on Object {
    // Weiter mit mobile_scanner.
  }
  try {
    final lenses = await MobileScannerPlatform.instance.getSupportedLenses(
      facing: CameraFacing.back,
    );
    return [
      for (final lens in lenses)
        switch (lens) {
          CameraLensType.wide => const ZoomStep(
            CameraLensType.wide,
            factor: 0.5,
          ),
          CameraLensType.normal => const ZoomStep(
            CameraLensType.normal,
            factor: 1,
          ),
          CameraLensType.zoom => const ZoomStep(CameraLensType.zoom),
          CameraLensType.any => null,
        },
    ].nonNulls.toList();
  } on Object {
    return const [];
  }
}

ZoomStep? _parse(Map<Object?, Object?> m) {
  final lens = CameraLensType.fromRawValue(m['lens'] as int?);
  if (lens == CameraLensType.any) return null;
  return ZoomStep(
    lens,
    factor: (m['factor'] as num?)?.toDouble(),
    digitalZoom: (m['zoom'] as num?)?.toDouble() ?? 1,
  );
}

/// Wählbare Stufen aufsteigend nach Faktor (unbekannte Tele-Faktoren
/// zuletzt), auf Wunsch mit Automatisch vorneweg. Gleiche Faktoren
/// erscheinen nur einmal, ein eigenes Objektiv geht vor digitalem Zoom.
/// Leer, wenn es nur eine Stufe gibt.
List<ZoomStep> zoomChoices(List<ZoomStep> steps, {bool withAuto = true}) {
  final byFactor = <String, ZoomStep>{};
  for (final s in steps) {
    if (s.isAuto) continue;
    final key = s.factor?.toStringAsFixed(1) ?? s.id;
    final known = byFactor[key];
    if (known == null || (known.digitalZoom != 1 && s.digitalZoom == 1)) {
      byFactor[key] = s;
    }
  }
  final unique = byFactor.values.toList()
    ..sort((a, b) {
      final fa = a.factor ?? double.infinity;
      final fb = b.factor ?? double.infinity;
      return fa.compareTo(fb);
    });
  if (unique.length < 2) return const [];
  return [if (withAuto) ZoomStep.auto, ...unique];
}

/// Gespeicherte Stufe. Gibt es sie auf dem Gerät nicht: Automatisch, sonst
/// die Hauptkamera.
ZoomStep zoomStepFromId(String? id, List<ZoomStep> choices) {
  for (final s in choices) {
    if (s.id == id) return s;
  }
  if (choices.isEmpty || choices.contains(ZoomStep.auto)) return ZoomStep.auto;
  return choices.firstWhere(
    (s) => s.factor == 1 && s.digitalZoom == 1,
    orElse: () => choices.first,
  );
}

/// Kurzlabel wie in der Kamera-App, z. B. "0,5×", "1×", "5×", "Auto".
String zoomLabel(ZoomStep step, AppLocalizations l, String locale) {
  if (step.isAuto) return l.lensAuto;
  final factor = step.factor;
  if (factor == null) return l.lensTele;
  final format = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 1;
  return '${format.format(factor)}×';
}

/// Ausgeschriebener Name für Tooltip und Screenreader.
String zoomName(ZoomStep step, AppLocalizations l, String locale) {
  final lens = switch (step.lens) {
    CameraLensType.wide => l.lensUltraWideName,
    CameraLensType.normal => l.lensMainName,
    CameraLensType.zoom => l.lensTeleName,
    CameraLensType.any => l.lensAutoName,
  };
  if (step.isAuto || step.factor == null) return lens;
  return '$lens ${zoomLabel(step, l, locale)}';
}

/// Runde Umschalter über dem Kamerabild, wie in der Kamera-App.
class ZoomSelector extends StatelessWidget {
  const ZoomSelector({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelected,
  });

  final List<ZoomStep> choices;
  final ZoomStep selected;
  final ValueChanged<ZoomStep> onSelected;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: l.lensChoice,
      container: true,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.black54,
          shape: StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final step in choices)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: _ZoomButton(
                    label: zoomLabel(step, l, locale),
                    tooltip: zoomName(step, l, locale),
                    selected: step == selected,
                    scheme: scheme,
                    onPressed: () => onSelected(step),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.label,
    required this.tooltip,
    required this.selected,
    required this.scheme,
    required this.onPressed,
  });

  final String label;
  final String tooltip;
  final bool selected;
  final ColorScheme scheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    excludeFromSemantics: true,
    child: Semantics(
      label: tooltip,
      button: true,
      selected: selected,
      excludeSemantics: true,
      child: Material(
        color: selected ? scheme.primaryContainer : Colors.transparent,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selected ? scheme.onPrimaryContainer : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

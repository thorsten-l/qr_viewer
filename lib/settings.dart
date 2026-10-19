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

/// Einstellungen der App und die Seite dazu.
library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';

const _actionsEnabledKey = 'actions_enabled';
const _scanFromPhotoKey = 'scan_from_photo';

/// Gespeicherte Einstellungen; meldet Änderungen an die Oberfläche.
class AppSettings extends ChangeNotifier {
  /// Nur im Speicher, ohne SharedPreferences (z. B. für Tests).
  AppSettings({bool actionsEnabled = false, bool scanFromPhoto = false})
    : _prefs = null,
      _actionsEnabled = actionsEnabled, // ignore: prefer_initializing_formals
      _scanFromPhoto = scanFromPhoto; // ignore: prefer_initializing_formals

  AppSettings._(SharedPreferences this._prefs)
    : _actionsEnabled = _prefs.getBool(_actionsEnabledKey) ?? false,
      _scanFromPhoto = _prefs.getBool(_scanFromPhotoKey) ?? false;

  static Future<AppSettings> load() async =>
      AppSettings._(await SharedPreferences.getInstance());

  final SharedPreferences? _prefs;

  bool _actionsEnabled;
  bool _scanFromPhoto;

  /// Knöpfe wie Öffnen, Anrufen oder Nachschlagen auf der Ergebnisseite.
  /// Standard: aus, die App zeigt dann nur an.
  bool get actionsEnabled => _actionsEnabled;

  Future<void> setActionsEnabled(bool value) async {
    if (value == _actionsEnabled) return;
    _actionsEnabled = value;
    notifyListeners();
    await _prefs?.setBool(_actionsEnabledKey, value);
  }

  /// Foto-Knopf auf der Scanner-Seite. Standard: aus. Die Fotoauswahl des
  /// Systems braucht kein Leserecht; die App bekommt nur das gewählte Bild.
  bool get scanFromPhoto => _scanFromPhoto;

  Future<void> setScanFromPhoto(bool value) async {
    if (value == _scanFromPhoto) return;
    _scanFromPhoto = value;
    notifyListeners();
    await _prefs?.setBool(_scanFromPhotoKey, value);
  }
}

/// Stellt [AppSettings] allen Seiten darunter bereit.
class SettingsScope extends InheritedNotifier<AppSettings> {
  const SettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsScope>()?.notifier;

  /// Ohne [SettingsScope] gilt der Standard: Aktionen aus.
  static bool actionsEnabled(BuildContext context) =>
      maybeOf(context)?.actionsEnabled ?? false;
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final settings = SettingsScope.maybeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.touch_app_outlined),
            title: Text(l.enableActions),
            subtitle: Text(l.enableActionsHint),
            value: settings?.actionsEnabled ?? false,
            onChanged: settings?.setActionsEnabled,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.photo_outlined),
            title: Text(l.scanFromPhoto),
            subtitle: Text(l.scanFromPhotoHint),
            value: settings?.scanFromPhoto ?? false,
            onChanged: settings?.setScanFromPhoto,
          ),
        ],
      ),
    );
  }
}

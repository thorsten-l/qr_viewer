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

/// Bundeseinheitlicher Medikationsplan (BMP) nach der Spezifikation der KBV
/// (Anlage 3 zu § 31a SGB V, Version 2.8): Lesen des XML aus dem
/// Data-Matrix-Code. Die Schlüsseltabellen stammen aus den
/// KBV-Schlüsseltabellen S_BMP_ZWISCHENUEBERSCHRIFT V1.02,
/// S_BMP_DOSIEREINHEIT V1.01 und S_BMP_DARREICHUNGSFORM V1.03.
library;

/// Gelesener Medikationsplan; Attribute heißen wie im XML.
class MedicationPlan {
  const MedicationPlan({
    this.root = const {},
    this.patient = const {},
    this.author = const {},
    this.parameters = const {},
    this.sections = const [],
  });

  /// `MP`: Version `v`, Seite `a` von `z`.
  final Map<String, String> root;

  /// `P`: Vorname `g`, Nachname `f`, Titel `t`, Vorsatzwort `v`,
  /// Namenszusatz `z`, Geburtsdatum `b` (JJJJMMTT).
  final Map<String, String> patient;

  /// `A`: Name `n`, Straße `s`, PLZ `z`, Ort `c`, Telefon `p`, E-Mail `e`,
  /// Ausdruckdatum `t`.
  final Map<String, String> author;

  /// `O`: Allergien `ai`, schwanger `p`, stillend `b`, Gewicht `w`,
  /// Größe `h`, Kreatinin `c`, Freitext `x`.
  final Map<String, String> parameters;

  final List<PlanSection> sections;

  /// Vollständiger Name wie auf dem Plan: Titel, Vorname, Zusatz,
  /// Vorsatzwort, Nachname.
  String? get patientName => _join([
    patient['t'],
    patient['g'],
    patient['z'],
    patient['v'],
    patient['f'],
  ]);

  /// Geburtsdatum; null, wenn Monat oder Tag unbekannt (00) sind.
  DateTime? get birthDate {
    final b = patient['b'];
    if (b == null || !RegExp(r'^\d{8}$').hasMatch(b)) return null;
    final y = int.parse(b.substring(0, 4));
    final m = int.parse(b.substring(4, 6));
    final d = int.parse(b.substring(6, 8));
    if (m == 0 || d == 0) return null;
    return DateTime(y, m, d);
  }

  DateTime? get printedAt => DateTime.tryParse(author['t'] ?? '');

  /// Adresse in einer Zeile: Straße, PLZ Ort.
  String? get authorAddress => _join([
    author['s'],
    _join([author['z'], author['c']]),
  ], ', ');
}

/// Block des Plans, ggf. mit Zwischenüberschrift.
class PlanSection {
  const PlanSection({this.code, this.text, this.entries = const []});

  /// Schlüssel der Zwischenüberschrift (`S@c`), z. B. 411.
  final String? code;

  /// Freitext-Überschrift (`S@t`).
  final String? text;
  final List<PlanEntry> entries;

  /// Überschrift im Wortlaut der KBV bzw. als Freitext.
  String? get title =>
      text != null ? planText(text!) : kbvSectionTitles[code] ?? code;
}

sealed class PlanEntry {
  const PlanEntry();
}

/// Medikationseintrag (`M`) mit Wirkstoffen (`W`).
class PlanMedication extends PlanEntry {
  const PlanMedication(this.attributes, [this.ingredients = const []]);

  final Map<String, String> attributes;

  /// Wirkstoff und Stärke (`W@w`, `W@s`).
  final List<(String, String?)> ingredients;

  String? operator [](String key) => attributes[key];

  /// Handelsname, sonst die Wirkstoffe mit Stärke.
  String? get name =>
      attributes['a'] ??
      _join([
        for (final (w, s) in ingredients) _join([w, s]),
      ], ', ');

  String? get pzn => attributes['p'];

  /// Darreichungsform im Wortlaut der KBV-Tabelle oder als Freitext.
  String? get form {
    final f = attributes['f'];
    return f != null ? kbvDosageForms[f] ?? f : attributes['fd'];
  }

  /// Dosiereinheit im Wortlaut der KBV-Tabelle oder als Freitext.
  String? get unit {
    final du = attributes['du'];
    return du != null ? kbvDosageUnits[du] ?? du : attributes['dud'];
  }

  /// Viererschema „morgens-mittags-abends-nachts“ oder Freitext.
  String? get scheme {
    final t = attributes['t'];
    if (t != null) return planText(t);
    final parts = [
      for (final k in ['m', 'd', 'v', 'h']) attributes[k],
    ];
    if (parts.every((p) => p == null)) return null;
    return parts.map((p) => p ?? '0').join('-');
  }

  /// Wochentag 1 (Montag) bis 7 (Sonntag) bei wöchentlicher Gabe.
  int? get weekday {
    final w = int.tryParse(attributes['wo'] ?? '');
    return w != null && w >= 1 && w <= 7 ? w : null;
  }
}

/// Freitextzeile (`X`) oder Rezeptur (`R`).
class PlanText extends PlanEntry {
  const PlanText(this.text, {this.extra, this.recipe = false});

  final String text;

  /// Gebundene Zusatzzeile einer Rezeptur (`R@x`).
  final String? extra;
  final bool recipe;
}

/// Ein `~` steht im Plan für einen manuellen Zeilenumbruch.
String planText(String s) => s.replaceAll('~', '\n');

String? _join(List<String?> parts, [String sep = ' ']) {
  final s = parts.whereType<String>().where((p) => p.trim().isNotEmpty);
  return s.isEmpty ? null : s.join(sep);
}

final _tag = RegExp(
  r'''<(/?)([A-Za-z]+)((?:\s+[A-Za-z]+\s*=\s*(?:"[^"]*"|'[^']*'))*)\s*(/?)>''',
);
final _attr = RegExp(r'''([A-Za-z]+)\s*=\s*(?:"([^"]*)"|'([^']*)')''');

Map<String, String> _attrs(String s) => {
  for (final m in _attr.allMatches(s))
    m.group(1)!: _unescape(m.group(2) ?? m.group(3) ?? ''),
};

String _unescape(String s) => s.replaceAllMapped(
  RegExp(r'&(#x[0-9a-fA-F]+|#\d+|amp|lt|gt|quot|apos);'),
  (m) => switch (m.group(1)!) {
    'amp' => '&',
    'lt' => '<',
    'gt' => '>',
    'quot' => '"',
    'apos' => "'",
    final c when c.startsWith('#x') => String.fromCharCode(
      int.parse(c.substring(2), radix: 16),
    ),
    final c => String.fromCharCode(int.parse(c.substring(1))),
  },
);

/// Liest das XML eines Medikationsplans; null, wenn es keiner ist.
/// Einträge außerhalb eines `S`-Blocks landen in einem Block ohne
/// Überschrift.
MedicationPlan? parseMedicationPlan(String xml) {
  Map<String, String>? root;
  var patient = <String, String>{};
  var author = <String, String>{};
  var parameters = <String, String>{};
  final sections = <PlanSection>[];
  String? code;
  String? text;
  var entries = <PlanEntry>[];
  var inSection = false;
  Map<String, String>? med;
  var ingredients = <(String, String?)>[];

  void closeSection() {
    if (entries.isNotEmpty || code != null || text != null) {
      sections.add(PlanSection(code: code, text: text, entries: entries));
    }
    code = null;
    text = null;
    entries = [];
  }

  void closeMedication() {
    if (med == null) return;
    entries.add(PlanMedication(med!, ingredients));
    med = null;
    ingredients = [];
  }

  for (final m in _tag.allMatches(xml)) {
    final closing = m.group(1)!.isNotEmpty;
    final name = m.group(2)!;
    final a = _attrs(m.group(3)!);
    final selfClosing = m.group(4)!.isNotEmpty;
    switch ((name, closing)) {
      case ('MP', false):
        root = a;
      case ('P', false):
        patient = a;
      case ('A', false):
        author = a;
      case ('O', false):
        parameters = a;
      case ('S', false):
        closeMedication();
        if (!inSection) closeSection();
        code = a['c'];
        text = a['t'];
        inSection = !selfClosing;
        if (selfClosing) closeSection();
      case ('S', true):
        closeMedication();
        closeSection();
        inSection = false;
      case ('M', false):
        closeMedication();
        med = a;
        if (selfClosing) closeMedication();
      case ('M', true):
        closeMedication();
      case ('W', false):
        final w = a['w'];
        if (w != null) ingredients.add((w, a['s']));
      case ('X', false):
        closeMedication();
        final t = a['t'];
        if (t != null) entries.add(PlanText(planText(t)));
      case ('R', false):
        closeMedication();
        final t = a['t'];
        if (t != null) {
          entries.add(
            PlanText(
              planText(t),
              extra: a['x'] == null ? null : planText(a['x']!),
              recipe: true,
            ),
          );
        }
      default:
        break;
    }
  }
  if (root == null) return null;
  closeMedication();
  closeSection();
  return MedicationPlan(
    root: root,
    patient: patient,
    author: author,
    parameters: parameters,
    sections: sections,
  );
}

/// S_BMP_ZWISCHENUEBERSCHRIFT V1.02.
const kbvSectionTitles = {
  '411': 'Bedarfsmedikation',
  '412': 'Dauermedikation',
  '413': 'Intramuskuläre Anwendung',
  '414': 'Besondere Anwendung',
  '415': 'Intravenöse Anwendung',
  '416': 'Anwendung unter die Haut',
  '417': 'Fertigspritze',
  '418': 'Selbstmedikation',
  '419': 'Allergiehinweise',
  '421': 'Wichtige Hinweise',
  '422': 'Wichtige Angaben',
  '423': 'zu besonderen Zeiten anzuwendende Medikamente',
  '424': 'zeitlich befristet anzuwendende Medikamente',
  '425': 'Wöchentliche Anwendung',
};

/// S_BMP_DOSIEREINHEIT V1.01.
const kbvDosageUnits = {
  '#': 'Messlöffel',
  '0': 'Messbecher',
  '1': 'Stück',
  '2': 'Pkg.',
  '3': 'Flasche',
  '4': 'Beutel',
  '5': 'Hub',
  '6': 'Tropfen',
  '7': 'Teelöffel',
  '8': 'Esslöffel',
  '9': 'E',
  'a': 'Tasse',
  'b': 'Applikatorfüllung',
  'c': 'Augenbadewanne',
  'd': 'Dosierbriefchen',
  'e': 'Dosierpipette',
  'f': 'Dosierspritze',
  'g': 'Einzeldosis',
  'h': 'Glas',
  'i': 'Likörglas',
  'j': 'Messkappe',
  'k': 'Messschale',
  'l': 'Mio E',
  'm': 'Mio IE',
  'n': 'Pipettenteilstrich',
  'o': 'Sprühstoß',
  'p': 'IE',
  'q': 'cm',
  'r': 'l',
  's': 'ml',
  't': 'g',
  'u': 'kg',
  'v': 'mg',
};

/// S_BMP_DARREICHUNGSFORM V1.03 (gültig ab 01.04.2021).
const kbvDosageForms = {
  'AEO': 'Öl',
  'AMP': 'Amp',
  'APA': 'Amp',
  'ASN': 'Salbe',
  'ASO': 'Salbe',
  'ATO': 'Tropf',
  'ATR': 'AuTropf',
  'AUB': 'AuBad',
  'AUC': 'AuCreme',
  'AUG': 'AuGel',
  'AUS': 'AuSalbe',
  'BAD': 'Bad',
  'BAL': 'Balsam',
  'BAN': 'Bandage',
  'BEU': 'Beutel',
  'BIN': 'Binden',
  'BON': 'Bonbons',
  'BPL': 'Platte',
  'BRE': 'Brei',
  'BTA': 'BrTabl',
  'CRE': 'Creme',
  'DFL': 'Flasche',
  'DIL': 'Dilut',
  'DIS': 'DIS',
  'DKA': 'Dragees',
  'DOS': 'Spray',
  'DRA': 'Dragees',
  'DRM': 'Dragees',
  'DSC': 'Schaum',
  'DSS': 'Spray',
  'EDP': 'Pipette',
  'EIN': 'Einreib',
  'ELE': 'Elektr',
  'ELI': 'Elixier',
  'EMU': 'Emul',
  'ESS': 'Essenz',
  'ESU': 'Supp',
  'EXT': 'Extrakt',
  'FBE': 'Beutel',
  'FBW': 'Einreib',
  'FDA': 'Drag',
  'FER': 'Spritze',
  'FET': 'Salbe',
  'FLA': 'Flasche',
  'FLE': 'Flüss',
  'FLU': 'Flüss',
  'FMR': 'Tabl',
  'FOL': 'Folie',
  'FRB': 'FRB',
  'FSE': 'Seife',
  'FTA': 'Tabl',
  'GEK': 'Gran',
  'GEL': 'Gel',
  'GLI': 'GLI',
  'GLO': 'Globuli',
  'GMR': 'Gran',
  'GPA': 'Platte',
  'GRA': 'Gran',
  'GSE': 'Saft',
  'GUL': 'Lösung',
  'HAS': 'Handsch',
  'HKM': 'Kaps',
  'HKP': 'Kaps',
  'HPI': 'InhKaps',
  'HVW': 'Kaps',
  'IFA': 'Amp',
  'IFB': 'Beutel',
  'IFD': 'InfDisp',
  'IFE': 'Spritze',
  'IFF': 'Flasche',
  'IFK': 'Lösung',
  'IFL': 'Flasche',
  'IFS': 'Set',
  'IHA': 'InhAmp',
  'IHP': 'InhPulv',
  'IIE': 'Lösung',
  'IIL': 'Lösung',
  'IIM': 'Lösung',
  'IKA': 'InhKaps',
  'ILO': 'Lösung',
  'IMP': 'Impl',
  'INF': 'Lösung',
  'INH': 'Inhalat',
  'INI': 'Flasche',
  'INL': 'InhLös',
  'INS': 'Tee',
  'IST': 'Instill',
  'ISU': 'Susp',
  'IUP': 'Spirale',
  'KAN': 'Kanüle',
  'KAP': 'Kaps',
  'KAT': 'KAT',
  'KDA': 'KauDrag',
  'KEG': 'Kegel',
  'KER': 'Kerne',
  'KGU': 'Kaug',
  'KID': 'Konz',
  'KII': 'Konz',
  'KKS': 'Supp',
  'KLI': 'Klist',
  'KLT': 'KlisTbl',
  'KMP': 'Kaps',
  'KMR': 'Kaps',
  'KOD': 'Kondom',
  'KOM': 'Kompr',
  'KON': 'Konz',
  'KPG': 'KombiPg',
  'KRI': 'KRI',
  'KSS': 'Supp',
  'KSU': 'Supp',
  'KTA': 'KauTabl',
  'LAN': 'Lanz',
  'LII': 'Lösung',
  'LIQ': 'Flüss',
  'LOE': 'Lösung',
  'LOT': 'Lotion',
  'LOV': 'LOV',
  'LSE': 'Lösung',
  'LTA': 'Tabl',
  'LUP': 'LUP',
  'LUT': 'LuTabl',
  'MIL': 'Milch',
  'MIS': 'Misch',
  'MIX': 'Mixtur',
  'MRG': 'RetGran',
  'MRP': 'Pellets',
  'MTA': 'Tabl',
  'MUW': 'MUW',
  'NAG': 'NasGel',
  'NAO': 'NasÖl',
  'NAS': 'NasSpr',
  'NAW': 'NAW',
  'NDS': 'NasSpr',
  'NSA': 'NSalbe',
  'NTR': 'NTropf',
  'OCU': 'OCU',
  'OEL': 'Öl',
  'OHT': 'OTropf',
  'OVU': 'Ovula',
  'PAS': 'Pastill',
  'PEL': 'Pellets',
  'PEN': 'Pen',
  'PER': 'Perlen',
  'PFL': 'Pflast',
  'PFT': 'Pflast',
  'PHI': 'Pulver',
  'PHV': 'Pulver',
  'PIE': 'Pulver',
  'PIF': 'Lösung',
  'PII': 'Pulver',
  'PIJ': 'Pulver',
  'PIK': 'Pulver',
  'PIS': 'Pulver',
  'PIV': 'PIV',
  'PKI': 'Pulver',
  'PLE': 'Pulver',
  'PLF': 'PLF',
  'PLG': 'PLG',
  'PLH': 'PLH',
  'PLI': 'PLI',
  'PLK': 'PLK',
  'PLS': 'Pulver',
  'PLV': 'PLV',
  'PPL': 'Lösung',
  'PRS': 'PRS',
  'PSE': 'Saft',
  'PST': 'Paste',
  'PUD': 'Puder',
  'PUL': 'Pulver',
  'RED': 'RetDrag',
  'REK': 'RetKaps',
  'RET': 'RetTabl',
  'RGR': 'RetGran',
  'RKA': 'RekKaps',
  'RMS': 'Depot',
  'RSC': 'Schaum',
  'RSU': 'RekSusp',
  'RUT': 'RetTabl',
  'SAF': 'Saft',
  'SAL': 'Salbe',
  'SAM': 'Salbe',
  'SCH': 'Schaum',
  'SEI': 'Seife',
  'SHA': 'Shampoo',
  'SIR': 'Sirup',
  'SMF': 'SMF',
  'SMT': 'SMT',
  'SMU': 'Supp',
  'SPA': 'Amp',
  'SPF': 'Flasche',
  'SPL': 'Lösung',
  'SPR': 'Spray',
  'SPT': 'Spray',
  'SRI': 'Spritze',
  'SSU': 'Supp',
  'STA': 'Amp',
  'STB': 'Stäbch',
  'STI': 'Stifte',
  'STR': 'Streif',
  'SUB': 'Subst',
  'SUE': 'Susp',
  'SUL': 'SubSpr',
  'SUP': 'Supp',
  'SUS': 'Susp',
  'SUT': 'SubTabl',
  'SUV': 'Susp',
  'SWA': 'Schwamm',
  'TAB': 'Tabl',
  'TAE': 'Tafel',
  'TAM': 'Amp',
  'TEE': 'Tee',
  'TEI': 'Tropfen',
  'TES': 'Test',
  'TIN': 'Tinktur',
  'TKA': 'Tabl',
  'TLE': 'LösTabl',
  'TMR': 'Tabl',
  'TON': 'Tonikum',
  'TPN': 'Tampon',
  'TPO': 'Tamp',
  'TRA': 'TrAmp',
  'TRI': 'TRI',
  'TRO': 'Tropfen',
  'TRS': 'TRS',
  'TRT': 'TrTabl',
  'TSA': 'Saft',
  'TSD': 'TSD',
  'TSE': 'SusTabl',
  'TSS': 'TSS',
  'TST': 'Test',
  'TSY': 'TSY',
  'TTR': 'Test',
  'TUB': 'Tube',
  'TUE': 'Tücher',
  'TUP': 'Tupfer',
  'TVW': 'RetTabl',
  'UTA': 'Tabl',
  'VAL': 'VagLös',
  'VAR': 'VagRing',
  'VCR': 'VagCrem',
  'VER': 'Verband',
  'VGE': 'VagGel',
  'VKA': 'VagKaps',
  'VLI': 'Vlies',
  'VOV': 'VagOvul',
  'VST': 'VagStäb',
  'VSU': 'VagSupp',
  'VTA': 'VagTabl',
  'WAT': 'Watte',
  'WGA': 'Gaze',
  'WKA': 'Kaps',
  'WKM': 'Kaps',
  'WUE': 'Würfel',
  'XDG': 'Gel',
  'XDS': 'Spray',
  'XFE': 'Festig.',
  'XGM': 'Maske',
  'XHS': 'Spül.',
  'XNC': 'Creme',
  'XPK': 'Pflege',
  'XTC': 'Creme',
  'ZAM': 'Amp',
  'ZBU': 'Bürste',
  'ZCR': 'Zahncr.',
  'ZGE': 'Zahngel',
  'ZKA': 'ZerbKps',
  'ZPA': 'Zahnp.',
};

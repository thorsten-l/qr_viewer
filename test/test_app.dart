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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_viewer/localization.dart';
import 'package:qr_viewer/settings.dart';

/// MaterialApp mit allen Übersetzungen; Standardsprache in Tests: Deutsch.
/// Aktionen sind hier eingeschaltet, damit sie sich prüfen lassen.
Widget testApp(
  Widget home, {
  Locale locale = const Locale('de'),
  AppSettings? settings,
}) => MaterialApp(
  locale: locale,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: kSupportedLocales,
  builder: (context, child) => SettingsScope(
    settings: settings ?? AppSettings(actionsEnabled: true),
    child: child!,
  ),
  home: home,
);

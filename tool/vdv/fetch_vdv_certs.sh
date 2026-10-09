#!/usr/bin/env bash
# Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Lädt die öffentlichen VDV-CA-Schlüssel (CC0) aus dem KDE-Projekt KItinerary
# nach assets/vdv_certs/. Herkunft der Schlüssel: VDV-PKI, LDAP
# ldap://ldap-vdv-ion.telesec.de (ou=VDV KA, o=VDV Kernapplikations GmbH, c=de).
set -euo pipefail

PROJECT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="$PROJECT/assets/vdv_certs"
API="https://api.github.com/repos/KDE/kitinerary/contents/src/lib/vdv/certs"
RAW="https://raw.githubusercontent.com/KDE/kitinerary/master/src/lib/vdv/certs"

mkdir -p "$OUT"
names=$(curl -fsSL "$API" | python3 -c \
  "import json,sys; print('\n'.join(x['name'] for x in json.load(sys.stdin) if x['name'].endswith('.vdv-cert')))")
count=0
for n in $names; do
  curl -fsSL -o "$OUT/$n" "$RAW/$n"
  count=$((count + 1))
done
echo "$count Schlüssel nach $OUT geladen"

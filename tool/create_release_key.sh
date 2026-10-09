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

# Erzeugt den Android-Release-Schlüssel (Upload-Key) und android/key.properties.
# Das Passwort wird nur hier eingegeben und landet ausschließlich in key.properties.
set -euo pipefail

KEYSTORE="${KEYSTORE:-$HOME/keystores/qr_viewer-upload.jks}"
ALIAS="upload"
PROJECT="$(cd "$(dirname "$0")/.." && pwd)"
PROPS="$PROJECT/android/key.properties"

if [[ -e "$KEYSTORE" ]]; then
  echo "Schlüssel existiert bereits: $KEYSTORE (wird nicht überschrieben)" >&2
  exit 1
fi

read -rsp "Neues Passwort für den Schlüssel (mind. 8 Zeichen): " P1; echo
read -rsp "Passwort wiederholen: " P2; echo
[[ "$P1" == "$P2" ]] || { echo "Die Passwörter stimmen nicht überein." >&2; exit 1; }
[[ ${#P1} -ge 8 ]] || { echo "Das Passwort ist zu kurz." >&2; exit 1; }

mkdir -p "$(dirname "$KEYSTORE")"
chmod 700 "$(dirname "$KEYSTORE")"

KS_PASS="$P1" keytool -genkeypair -v \
  -keystore "$KEYSTORE" -storetype PKCS12 \
  -alias "$ALIAS" -keyalg RSA -keysize 4096 -validity 10000 \
  -dname "CN=Thorsten Ludewig, C=DE" \
  -storepass:env KS_PASS -keypass:env KS_PASS
chmod 600 "$KEYSTORE"

# Backslashes für das Java-Properties-Format verdoppeln
ESC="${P1//\\/\\\\}"
( umask 077
  cat > "$PROPS" <<PROPS_EOF
storePassword=$ESC
keyPassword=$ESC
keyAlias=$ALIAS
storeFile=$KEYSTORE
PROPS_EOF
)

echo
echo "Fertig."
echo "  Schlüssel:   $KEYSTORE"
echo "  Zugangsdaten: $PROPS"
echo "Sichere beide Dateien und das Passwort (z. B. im Passwort-Manager)."

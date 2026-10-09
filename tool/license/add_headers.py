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
"""Fügt allen Quelldateien den Apache-2.0-Kopf hinzu, wo er noch fehlt.

    python3 tool/license/add_headers.py          # einfügen
    python3 tool/license/add_headers.py --check  # nur prüfen, Exit 1 bei Fehlen
"""
import os
import sys

AUTHOR = "Thorsten Ludewig (t.ludewig@gmail.com)"
YEAR = "2026"
TEXT = f"""Copyright {YEAR} {AUTHOR}

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License."""

SLASH = {".dart", ".kt", ".kts", ".swift", ".java", ".h", ".m"}
HASH = {".py", ".sh"}
SKIP_DIRS = {"build", ".dart_tool", ".idea", ".gradle", "Pods", "ephemeral", ".git"}
# Von flutter gen-l10n erzeugt; der Kopf kommt dort über "header" in l10n.yaml
SKIP_PATHS = {os.path.join("lib", "l10n")}
# Von Flutter erzeugt und bei jedem Build überschrieben
SKIP_FILES = {"GeneratedPluginRegistrant.java", "GeneratedPluginRegistrant.h",
              "GeneratedPluginRegistrant.m", "flutter_export_environment.sh"}
MARK = "Licensed under the Apache License, Version 2.0"


def header(ext):
    p = "//" if ext in SLASH else "#"
    return "\n".join(f"{p} {l}".rstrip() for l in TEXT.split("\n")) + "\n"


def files(root):
    for d, dirs, names in os.walk(root):
        dirs[:] = [x for x in dirs if x not in SKIP_DIRS
                   and os.path.relpath(os.path.join(d, x), root) not in SKIP_PATHS]
        for n in names:
            ext = os.path.splitext(n)[1]
            if (ext in SLASH or ext in HASH) and n not in SKIP_FILES:
                yield os.path.join(d, n), ext


def main():
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
    check = "--check" in sys.argv
    missing = []
    for path, ext in sorted(files(root)):
        src = open(path, encoding="utf-8").read()
        if MARK in src[:1500]:
            continue
        missing.append(os.path.relpath(path, root))
        if check:
            continue
        h = header(ext)
        if src.startswith("#!"):  # Shebang bleibt in der ersten Zeile
            first, _, rest = src.partition("\n")
            new = f"{first}\n{h}\n{rest}"
        else:
            new = f"{h}\n{src}"
        open(path, "w", encoding="utf-8").write(new)
    for m in missing:
        print(("fehlt: " if check else "ergänzt: ") + m)
    if check and missing:
        sys.exit(1)


if __name__ == "__main__":
    main()

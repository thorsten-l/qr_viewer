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

"""English texts of the manual; same structure as texts.py."""

UI = dict(
    file="QR-Viewer-Manual.odt",
    language="en", country="GB",
    footer="QR Viewer – Manual · Page ",
    contents="Contents",
    platforms="For iPhone, iPad and Android",
    appendix="Appendix: All codes at a glance",
    columns=("No.", "Code", "Scan type", "Devices"),
    meta="Scan type: {mode} · Devices: {devices}",
    try_code="Example code to try out",
    shown="How QR Viewer shows it",
    what="What is it?",
    where="Where will you see it?",
    example="What is in the example?",
    app="How QR Viewer handles the code",
    do="What you can do with it",
    care="Keep in mind:",
)

TITLE = "QR Viewer"
SUBTITLE = "Scan codes safely – simply explained"
VERSION_LINE = "Manual for version 2.1.2 · October 2026"

CHAPTERS = [
    ("1 What is QR Viewer?", [
        "QR codes and barcodes are everywhere: on posters, menus, parcels, "
        "tickets, groceries and letters. A code like this can hide many "
        "things – a link to a website, a phone number, Wi-Fi credentials or "
        "a prepared bank transfer. You cannot tell what is inside just by "
        "looking at it.",
        "Many scanner apps open a link as soon as the camera recognizes the "
        "code. That is convenient, but risky: fraudsters stick fake codes on "
        "parking meters or charging stations, for example, to lure you to a "
        "fake payment page. This is called “quishing” (from “QR” and "
        "“phishing”).",
        "**QR Viewer does it differently: look first, then open.** The app "
        "first only shows you what is in the code. Nothing happens until you "
        "explicitly confirm it – for example, before a link opens in the "
        "browser. This lets you check calmly where a code really leads.",
        "In addition:",
        [
            "no user account, no sign-in",
            "no advertising and no tracking",
            "free for iPhone, iPad and Android devices",
            "available in 13 languages – the app follows the language of your "
            "device",
        ],
    ]),
    ("2 Getting started", [
        "**Install:** You will find QR Viewer in the App Store (iPhone, iPad) "
        "and on Google Play (Android). Search for “QR Viewer”.",
        "**Allow the camera:** When you start the app for the first time, "
        "your device asks whether QR Viewer may use the camera. Tap "
        "“Allow” or “While using the app”. Without the camera the app cannot "
        "read codes. The camera image is only analysed on your device – no "
        "photos are stored or sent anywhere.",
        ("note", "Did you deny camera access by mistake? Open your device's "
         "Settings, look for “QR Viewer” and turn on the camera."),
    ]),
    ("3 Scanning a code", [
        "After starting the app you see the camera image. Hold your device "
        "so that the code is clearly visible in the picture. As soon as QR "
        "Viewer recognizes it, the device vibrates briefly and the result "
        "page opens.",
        ("imgpair", "scanner.png", "scanner_menu.png", 5.2,
         "Left: the scan screen with zoom levels at the bottom. Right: the "
         "menu in the title where you choose the type of code. (The camera "
         "image is simulated.)"),
        "**Choose the scan type:** At the top left it says, for example, "
        "“Scan QR code”. Tap it to open a menu:",
        [
            "**QR code** – links, text, Wi-Fi access, contacts and much more",
            "**Barcode** – the bar codes on products, books and labels",
            "**Data Matrix** – small square codes, e.g. on postage stamps and "
            "electronic components",
            "**PDF417** – wide, stacked codes, e.g. on boarding passes",
            "**Aztec** – codes with a “bull's-eye” pattern in the middle, "
            "e.g. on train tickets",
            "**All codes** – recognizes everything your device can read",
        ],
        "QR Viewer remembers your choice. If you do not know what kind of "
        "code you have in front of you, simply choose “All codes”. Choosing a "
        "specific type has one advantage: if several codes are next to each "
        "other, the app only reads the one you want.",
        "**Zoom:** At the bottom of the camera image you find round buttons "
        "such as “0.6×”, “1×” or “2×” – just like in your device's camera "
        "app. With “2×” or more you can bring small or distant codes closer. "
        "Which levels are available depends on your device's cameras.",
        "**Flashlight:** The lamp icon at the top right turns the light on "
        "and off – handy in dark places.",
        ("note", "Tips if a code is not recognized: hold the device still "
         "and a little further away so the camera can focus. Avoid "
         "reflections on glossy paper or screens. Check that the right scan "
         "type is selected, or choose “All codes”."),
    ]),
    ("4 Understanding the result", [
        "After scanning, the result page opens. At the very top it says what "
        "the app has recognized, for example “Contact”, “Wi-Fi credentials” "
        "or “Product code”. Below that you see:",
        [
            "**Format:** which kind of code was scanned, e.g. “QR code” or "
            "“EAN-13”",
            "**Host:** for links, the address of the website the link leads "
            "to – so you can see at a glance where it goes",
            "**the data card:** the details from the code, neatly labelled, "
            "e.g. “Name”, “Phone” or “IBAN”. The copy icon next to each field "
            "copies exactly that detail.",
            "**Raw content:** below that you see the content of the code "
            "exactly as it is stored – character by character",
        ],
        ("imgpair", "qr_contact.png", "qr_contact_info.png", 5.6,
         "Left: the result for a digital business card. Right: the info "
         "button explains what kind of data this is."),
        "**The info button:** At the top right of every data card there is "
        "a small “i”. Tap it and QR Viewer explains in plain words what kind "
        "of data the code contains, that it was read only on your device, "
        "and what happens if you tap the action button.",
        "Some codes do not contain text but “binary data” – electronic "
        "tickets, for example. QR Viewer shows them as columns of numbers "
        "(hex view). Tickets following the German VDV standard, such as the "
        "Deutschlandticket, can even be decoded and shown in readable form "
        "(see appendix A.30).",
    ]),
    ("5 Actions – always with a confirmation", [
        "At the bottom of the result page you find an action button that "
        "depends on the content, for example:",
        [
            "**Open …** – opens a link in the browser",
            "**Write email…**, **Call…**, **Write SMS…**",
            "**Show on map…** – shows a place in your maps app",
            "**Add to contacts…**, **Add to calendar…** – saves a business "
            "card or an event",
            "**Open in authenticator…** – hands a 2FA key to your "
            "authenticator app",
            "**Look up online…** – searches the internet for a product or "
            "book number",
            "**Track shipment…** – opens Deutsche Post shipment tracking",
        ],
        "The three dots “…” mean: a confirmation follows. Before anything is "
        "opened, QR Viewer shows you exactly what is about to happen. Only "
        "when you tap “Open” does it continue. With “Cancel” nothing happens "
        "at all.",
        ("img", "qr_url_confirm.png", 5.0,
         "The confirmation before opening a link. The tracking add-ons "
         "(utm_…) have already been removed."),
        "**Tracking add-ons are removed:** Many links contain additions such "
        "as `utm_source=…` or `fbclid=…`. Companies use them to track where "
        "you came from. QR Viewer removes known add-ons of this kind before "
        "the link is opened. The confirmation already shows the cleaned "
        "link.",
        "**Important:** QR Viewer never calls anyone by itself and does not "
        "send emails or text messages. The app only opens the responsible "
        "app (phone, mail, messages) with the prepared details. You always "
        "send it yourself.",
    ]),
    ("6 Copying and sharing", [
        "**Copy:** The “Copy” button puts the whole content on the "
        "clipboard. From there you can paste it into any other app. Single "
        "details are copied with the copy icon next to the field in the data "
        "card.",
        "**Share:** The share icon at the top right opens your device's share "
        "menu. With it you can, for example, send the content in a message or "
        "save it in a note. You decide what you share and where – QR Viewer "
        "does not send anything on its own.",
    ]),
    ("7 The history", [
        "QR Viewer remembers the last 25 scanned codes. Open the history with "
        "the clock icon at the top of the scan screen.",
        ("img", "history.png", 5.6,
         "The history with search, export and delete at the top right."),
        [
            "**View again:** Tap an entry to open its result page again.",
            "**Copy:** The copy icon on the right copies the content "
            "directly.",
            "**Search:** The magnifying glass searches content, format and "
            "type.",
            "**Delete one entry:** Swipe an entry to the side. If you made a "
            "mistake, tap “Undo”.",
            "**Delete everything:** The bin icon clears the whole history.",
            "**Export:** The share icon passes the history on as a table "
            "(CSV) or as a file for programs (JSON).",
        ],
        ("note", "The history stays on your device. But keep in mind: it may "
         "contain confidential details such as Wi-Fi passwords. Delete such "
         "entries when you no longer need them. QR Viewer never stores secret "
         "keys for two-step sign-in (2FA)."),
    ]),
    ("8 Info and help", [
        "The “i” icon on the scan screen opens the info dialog. There you "
        "see the version of the app and the date it was built.",
        ("img", "about_crop.png", 6.0, "The info dialog."),
        [
            "**Support** opens the page for questions and bug reports in the "
            "browser (github.com/thorsten-l/qr_viewer/issues).",
            "**Licenses** shows the licences of the components used.",
            "**Manuals** opens the page in the browser where this manual can "
            "be downloaded in English and German "
            "(github.com/thorsten-l/qr_viewer/tree/main/docs).",
        ],
    ]),
    ("9 Privacy – how QR Viewer protects your data", [
        "Privacy is at the heart of QR Viewer. This chapter sums up in plain "
        "words what happens to your data – and what does not. The full "
        "privacy policy is available at "
        "github.com/thorsten-l/qr_viewer/blob/main/PRIVACY.md.",
        ("h3", "The essentials"),
        [
            "QR Viewer collects **no** personal data.",
            "There is **no user account**, **no advertising**, **no analysis "
            "of your behaviour** (tracking) and **no servers** of its own.",
            "Codes are read and analysed **only on your device**.",
            "Data goes to the internet only if you **explicitly confirm** it.",
        ],
        ("h3", "Camera"),
        "The app needs the camera to read codes. The camera image is only "
        "analysed on your device. No photos or videos are stored or "
        "transmitted. You can withdraw camera access at any time in your "
        "device settings.",
        ("h3", "What is stored on your device"),
        "Only the contents of the last 25 scans (the history) and the most "
        "recently chosen scan type and zoom level are stored. This data "
        "stays on your device. You can delete single entries or the whole "
        "history at any time. If you delete the app, all of its data is gone "
        "as well.",
        "Please note: if you back up your device (e.g. iCloud backup or "
        "Android backup), the history may be part of that backup. This is "
        "handled by your operating system, not by QR Viewer.",
        ("h3", "Particularly sensitive content"),
        [
            "**Keys for two-step sign-in (2FA)** are never stored in the "
            "history. The result page points this out.",
            "**Wi-Fi passwords** stay in the history like any other content "
            "until you delete them.",
            "**Setup codes of smart home devices** (Matter) are only "
            "displayed. The app does not set up any device and sends nothing "
            "to manufacturers or home apps. These codes also stay in the "
            "history until you delete them.",
            "**Tickets** (e.g. Deutschlandticket) are decoded only on your "
            "device. The app shows the name shortened, exactly as it is "
            "stored in the ticket (e.g. “G…e M…n”). To check that a ticket is "
            "genuine it uses publicly known keys that come with the app – no "
            "internet connection is needed for this.",
            "**Bank transfer details** (GiroCode) are only displayed. QR "
            "Viewer does not transfer money and does not pass the data on to "
            "banks.",
        ],
        ("h3", "When data leaves your device"),
        "Only when you trigger an action yourself and confirm it:",
        [
            "**Open a link:** Your browser loads the website. Like every "
            "website, it sees your internet address. QR Viewer removes known "
            "tracking add-ons beforehand.",
            "**Look up online:** A product number is sent to the search "
            "engine DuckDuckGo, a book number (ISBN) to Open Library.",
            "**Track shipment:** The tracking number goes to Deutsche Post.",
            "**Email, call, SMS, map, contacts, calendar, authenticator:** "
            "The details go to the respective app on your device. What "
            "happens to them there is decided by that app.",
            "**Copy, share, export:** Only when you tap it, and only to the "
            "app you choose.",
        ],
        "Every website or app you open has its own privacy rules. The info "
        "button in every data card tells you beforehand where the data would "
        "go.",
        ("h3", "Android only"),
        "On Android devices, QR Viewer uses a software library from Google "
        "(“ML Kit”) to recognize codes. It also works on your device; camera "
        "images are not sent to Google. However, ML Kit may send technical "
        "details to Google, such as device model, Android version, app "
        "version and speed measurements. On iPhone and iPad, Apple's "
        "built-in technology recognizes the codes without any other provider "
        "being involved.",
        ("h3", "Your rights"),
        "Since the developer receives no personal data from you, there is "
        "no data about you that could be disclosed, corrected or deleted. For questions about privacy you can write to "
        "t.ludewig@gmail.com. You also have the right to complain to a data "
        "protection supervisory authority.",
        ("h3", "Tips for safe scanning"),
        [
            "Check the **host**: does the internet address match what you "
            "expect? A city parking meter should not point to an unknown "
            "address.",
            "Look closely to see whether a code has been **covered with a "
            "sticker** – for example on parking meters, charging stations or "
            "posters.",
            "After scanning, **do not enter passwords or bank details** on a "
            "page you do not fully trust.",
            "For a **bank transfer**, check every detail before you confirm "
            "it in your banking app.",
            "Do not pass on codes with **Wi-Fi passwords** or **2FA keys**, "
            "and delete them from the history when you no longer need them.",
        ],
    ]),
    ("10 Frequently asked questions", [
        "**The app does not recognize a code.** Choose “All codes”, hold the "
        "device still and a little further away, and make sure there is "
        "enough light (flashlight). A higher zoom level helps with very small "
        "codes. Some rare kinds of code cannot be read by every device (see "
        "appendix).",
        "**I only see a black picture.** Camera access is probably missing. "
        "Allow it in your device settings under “QR Viewer”.",
        "**Nothing happens when I tap an action.** Then there is no suitable "
        "app installed on your device, for example no authenticator app. QR "
        "Viewer then shows “No app found to open this.”",
        "**How do I change the language?** QR Viewer follows the language of "
        "your device. On Android 13 and later and on iPhone you can also "
        "choose a different language just for QR Viewer in the settings.",
        "**Does the app cost anything?** No. There are no in-app purchases "
        "and no advertising either.",
    ]),
]

APPENDIX_INTRO = [
    "On the following pages you find every kind of code that QR Viewer can "
    "read – each on its own page. All example codes are real and can be "
    "scanned: simply point the camera at the code on the screen or on a "
    "printout and try it out.",
    "Each page explains what kind of code it is, where you will see it in "
    "everyday life, what the example contains, how QR Viewer shows it and "
    "what you can do with it. The picture on the right is the app's result "
    "page.",
    "The example codes contain German sample data, because QR Viewer was "
    "developed in Germany. All names, numbers and addresses are made up – "
    "with two exceptions: the location is the real town hall in "
    "Wolfenbüttel, and the first ticket (A.30) is an official sample ticket "
    "in the name of Geraldine Mustermann. The second ticket (A.31) is a "
    "self-made test ticket.",
    ("note", "Two kinds of code (Micro QR code and GS1 DataBar) can only be "
     "read by the iPhone and iPad version, because Android's recognition "
     "technology does not support them. This is noted on the respective "
     "page."),
]

ALL = "iPhone, iPad and Android"
APPLE = "iPhone and iPad only"

PAGES = {
    "qr_text": dict(
        title="QR code with text", mode="QR code or All codes", devices=ALL,
        what="The **QR code** is the well-known square with three large "
        "corner markers. It was invented in Japan in 1994 to label car parts "
        "and can store up to several thousand characters. Even if part of it "
        "is dirty or damaged, it can usually still be read. The simplest "
        "content is plain text.",
        where="On signs in museums, at sights, on packaging or as a short "
        "message on cards.",
        example="“Willkommen im Rathaus Wolfenbüttel! Die Bürgerberatung "
        "findest du im Erdgeschoss.” (German for: Welcome to Wolfenbüttel "
        "town hall! The citizens' advice desk is on the ground floor.)",
        app="QR Viewer shows the text large and easy to read. Since text "
        "cannot trigger anything, there is no data card and no action "
        "button.",
        do="Copy or share the text.",
        care="Text is harmless. But if it contains an internet address or "
        "phone number, check it before you type it in."),
    "qr_url": dict(
        title="QR code with a link", mode="QR code or All codes", devices=ALL,
        what="A **link** (also URL or web address) leads to a page on the "
        "internet. This is the most common content of QR codes.",
        where="On posters, menus, flyers, parking meters, charging stations, "
        "invoices and in magazines.",
        example="https://www.wolfenbuettel.de/?utm_source=plakat&"
        "utm_campaign=herbst – a link to the website of the town of "
        "Wolfenbüttel with two tracking add-ons (utm_…).",
        app="Under “Host” you see the address of the website "
        "(www.wolfenbuettel.de). Below it you see the full link. It is only "
        "opened via “Open …” and after a confirmation. QR Viewer removes the "
        "tracking add-ons in the process.",
        do="Open the link in the browser after confirming, copy, share.",
        care="Check the host! Fraudsters use addresses that look like real "
        "ones (e.g. “wolfenbuettel-parking.info”). If in doubt, do not open "
        "the link."),
    "qr_bookmark": dict(
        title="QR code with a bookmark (MEBKM)",
        mode="QR code or All codes", devices=ALL,
        what="A **bookmark** is a link together with a name for it. The "
        "MEBKM format comes from the Japanese mobile operator NTT Docomo, "
        "whose phones could save the link directly as a bookmark. Many "
        "scanner apps still create it today.",
        where="On posters, flyers and business cards, especially with codes "
        "from older or Japanese QR code generators.",
        example="The bookmark “Stadt Wolfenbüttel” (town of Wolfenbüttel) "
        "with the link https://www.wolfenbuettel.de/.",
        app="The “Bookmark” data card shows the name and the link, with the "
        "host above it. A bookmark without a link only shows the name; then "
        "there is no open button.",
        do="“Open …” opens the link in the browser after a confirmation, "
        "just like a normal link. You can save it as a bookmark there "
        "yourself.",
        care="The name can claim anything – what counts is the host. Check "
        "it before opening the link."),
    "qr_email": dict(
        title="QR code with an email", mode="QR code or All codes",
        devices=ALL,
        what="The code contains an **email address**, often with a subject "
        "and text already filled in. So you do not have to type anything.",
        where="On business cards, notices (“Write to us!”) or paper contact "
        "forms.",
        example="An email to info@example.com with the subject “Anfrage” "
        "(enquiry) and the text “Hallo, ich habe eine Frage.” (Hello, I have "
        "a question.)",
        app="The data card shows recipient, subject and message separately. "
        "Each detail can be copied on its own.",
        do="“Write email…” opens your mail app with all details. It is only "
        "sent when you tap “Send” yourself.",
        care="Check the recipient address before sending personal details."),
    "qr_phone": dict(
        title="QR code with a phone number", mode="QR code or All codes",
        devices=ALL,
        what="The code contains a **phone number**.",
        where="On advertising signs, company vehicles, emergency notices or "
        "business cards.",
        example="+49 30 23125456 (a German number reserved for examples).",
        app="The data card shows the phone number.",
        do="“Call…” opens the phone app with the number after a "
        "confirmation. QR Viewer never calls by itself – you start the call "
        "in the phone app.",
        care="Watch out for expensive premium-rate numbers and unknown "
        "foreign country codes."),
    "qr_sms": dict(
        title="QR code with an SMS", mode="QR code or All codes", devices=ALL,
        what="The code contains a **phone number and a prepared text "
        "message (SMS)**.",
        where="In competitions, donation campaigns or call-back requests.",
        example="An SMS to +49 30 23125456 with the text “Bitte ruf mich "
        "zurück.” (Please call me back.)",
        app="The data card shows the phone number and the message.",
        do="“Write SMS…” opens your messages app after a confirmation. The "
        "SMS is only sent when you send it yourself.",
        care="Text messages to short numbers can cost money or start a "
        "subscription. Read the text before you send it."),
    "qr_geo": dict(
        title="QR code with a location", mode="QR code or All codes",
        devices=ALL,
        what="The code contains a **place on Earth**, given as latitude and "
        "longitude – just like on a navigation device.",
        where="On invitations, hiking maps, information boards or event "
        "posters (“How to find us”).",
        example="Wolfenbüttel town hall on the Stadtmarkt square: latitude "
        "52.16271, longitude 10.53441.",
        app="The data card shows latitude, longitude and the name of the "
        "place.",
        do="“Show on map…” opens your maps app (e.g. Apple Maps or Google "
        "Maps) at exactly this point after a confirmation. From there you "
        "can get directions.",
        care="The maps app learns which place you are looking at."),
    "qr_contact": dict(
        title="QR code with a contact (business card)",
        mode="QR code or All codes", devices=ALL,
        what="A **digital business card** (technical term “vCard”). It can "
        "contain name, company, phone numbers, email, address and website. "
        "QR Viewer also understands the shorter forms MECARD and BIZCARD.",
        where="On business cards, name badges, trade fair stands and in "
        "email signatures.",
        example="Geraldine Mustermann, project manager at Beispiel GmbH, with "
        "phone, email, website and the address Stadtmarkt 3–6, 38300 "
        "Wolfenbüttel.",
        app="Each detail is shown with a label in the data card and can be "
        "copied on its own.",
        do="“Add to contacts…” hands the business card to your contacts app "
        "via the share menu. There you can check everything before saving.",
        care="Only save contacts you really want to keep."),
    "qr_event": dict(
        title="QR code with an event", mode="QR code or All codes",
        devices=ALL,
        what="An **event** with title, start, end, location and description "
        "(technical term “iCalendar”).",
        where="On invitations, event posters, doctor's or public office "
        "appointments.",
        example="“Stadtführung Wolfenbüttel” (guided town tour) on 7 November "
        "2026 from 2 pm to 4 pm, meeting point in front of the main entrance "
        "of the town hall.",
        app="The data card shows title, start, end, location and "
        "description – date and time in your usual format.",
        do="“Add to calendar…” hands the event to your calendar app via the "
        "share menu.",
        care="Check date and time before saving the event."),
    "qr_wifi": dict(
        title="QR code with Wi-Fi access", mode="QR code or All codes",
        devices=ALL,
        what="The **credentials for a Wi-Fi network**: network name, "
        "encryption and password.",
        where="In cafés, hotels, holiday flats, doctors' surgeries or on the "
        "back of your internet router.",
        example="Network “Gaeste-WLAN” (guest Wi-Fi), encryption WPA, "
        "password “Sommer-2026!”.",
        app="The data card shows network name, password and encryption. You "
        "can copy the password on its own and paste it in the Wi-Fi "
        "settings.",
        do="Copy the password, then select the network in your device "
        "settings and paste the password.",
        care="Anyone who sees this code can use the network. The code stays "
        "in the history until you delete it – delete it when you no longer "
        "need it."),
    "qr_payment": dict(
        title="QR code with a bank transfer (GiroCode)",
        mode="QR code or All codes", devices=ALL,
        what="A **GiroCode** (also EPC QR code) contains everything needed "
        "for a SEPA bank transfer: recipient, IBAN, BIC, amount and "
        "reference.",
        where="On invoices, donation appeals, reminders or membership fee "
        "requests – common in Germany, Austria and other European countries.",
        example="€12.50 to “Muster-Verein e.V.” (a sample club), IBAN DE02 "
        "1203 0000 0000 2020 51, reference “Mitgliedsbeitrag 2026” "
        "(membership fee 2026).",
        app="The data card shows recipient, IBAN, BIC, amount (with the euro "
        "sign) and reference. Each detail can be copied on its own.",
        do="QR Viewer does not transfer money. You can copy the details or "
        "scan the code directly with the scan function of your banking app.",
        care="Check every detail before paying, especially recipient and "
        "IBAN. Fraudsters send fake invoices with their own GiroCode."),
    "qr_otp": dict(
        title="QR code with a one-time password (2FA)",
        mode="QR code or All codes", devices=ALL,
        what="A **secret key for two-step sign-in** (2FA). An authenticator "
        "app uses it to create a new six-digit sign-in code every 30 "
        "seconds.",
        where="When setting up two-factor sign-in for online services, "
        "banks, email providers or company accounts.",
        example="A key for the “Beispielkonto” (sample account) of "
        "geraldine.mustermann@example.com.",
        app="The data card shows provider, account, key and the technical "
        "settings. At the top it says “2FA codes are not saved in the "
        "history.”",
        do="“Open in authenticator…” hands the key to your authenticator app "
        "after a confirmation.",
        care="This key is as secret as a password. Do not show it to anyone "
        "and do not take screenshots of it. That is why QR Viewer never "
        "stores it in the history."),
    "qr_json": dict(
        title="QR code with JSON data", mode="QR code or All codes",
        devices=ALL,
        what="**JSON** is a format computer programs use to exchange data: "
        "names and values in curly and square brackets.",
        where="On device labels, in warehouses, on admission tickets or in "
        "technical instructions.",
        example="Details of the Wolfenbüttel public library with opening "
        "days (Tue, Thu, Sat).",
        app="QR Viewer indents the data neatly so you can read it. Nothing "
        "else happens with the data.",
        do="Copy or share.",
        care="Nothing special – JSON cannot trigger anything."),
    "qr_matter": dict(
        title="QR code of a smart home device (Matter)",
        mode="QR code or All codes", devices=ALL,
        what="**Matter** is a common standard for smart home devices such "
        "as lights, plugs, thermostats or sensors – supported by Apple, "
        "Google, Amazon, Samsung and many manufacturers. The QR code always "
        "starts with “MT:” and contains everything a smart home app needs to "
        "set up the device.",
        where="On the device itself, on the packaging or on a small card in "
        "the manual of Matter-enabled smart home devices.",
        example="The example code from the Matter specification: a test "
        "device (vendor ID 0xFFF1, reserved for testing) with the setup code "
        "20202021, reachable via Bluetooth LE.",
        app="The data card shows the **manual pairing code** "
        "(3497-011-2332), the setup code (PIN), vendor and product ID, the "
        "discriminator, which connection can be used to set up the device "
        "and whether you need to press a button first, for example.",
        do="QR Viewer does not set up the device itself. Scan the code in "
        "your smart home app (e.g. Apple Home, Google Home) – or type in the "
        "manual pairing code there if scanning does not work. The copy icon "
        "next to the field lets you copy it.",
        care="Anyone with this code can pair the device while it is in setup "
        "mode. Do not show it around, and do not stick the label where "
        "others can see it."),
    "microqr": dict(
        title="Micro QR code", mode="All codes", devices=APPLE,
        what="The **Micro QR code** is the little sister of the QR code: "
        "only one corner marker instead of three. It fits on very small "
        "surfaces but stores only a few characters.",
        where="On electronic components, circuit boards, small spare parts "
        "or medical products.",
        example="WF-2026",
        app="The content is shown as text. For links, phone numbers etc. the "
        "same applies as for the normal QR code.",
        do="Copy or share.",
        care="Android cannot read this code because Google's recognition "
        "does not support it."),
    "ean13": dict(
        title="EAN-13 – product number", mode="Barcode or All codes",
        devices=ALL,
        what="The **EAN-13** is the barcode you know from almost every "
        "product in the supermarket. It contains a 13-digit item number "
        "(technical term GTIN). The last digit is a check digit that reveals "
        "reading errors.",
        where="On groceries, toiletries, electronics – it is scanned at the "
        "checkout.",
        example="4006381333931 – an item number from Germany.",
        app="The data card shows the item number, whether the check digit is "
        "correct (“valid”) and in which country the number was registered "
        "(here: Germany). The number does not reveal the product name, the "
        "price or the ingredients – those are not in the code.",
        do="“Look up online…” searches for the number with the DuckDuckGo "
        "search engine after a confirmation. Copying and sharing work too, "
        "of course.",
        care="The country only shows where the number was registered, not "
        "necessarily where the product was made. When looking it up, "
        "DuckDuckGo learns what you are searching for."),
    "ean13_isbn": dict(
        title="EAN-13 – book number (ISBN)", mode="Barcode or All codes",
        devices=ALL,
        what="Books carry an EAN-13 starting with 978 or 979: this is the "
        "**ISBN**, the international book number. Magazines have a code "
        "starting with 977, the **ISSN**.",
        where="On the back of books, magazines and sheet music.",
        example="978-3-16-148410-0 – a well-known example ISBN.",
        app="The data card shows the ISBN, the older ten-digit form "
        "(ISBN-10) and whether the check digit is correct. Title and author "
        "are not in the code.",
        do="“Look up online…” searches for the book on Open Library, a free "
        "online book catalogue, after a confirmation.",
        care="Open Library learns which book you are looking for."),
    "ean8": dict(
        title="EAN-8 – short product number", mode="Barcode or All codes",
        devices=ALL,
        what="The **EAN-8** is the short form of the EAN-13 with only 8 "
        "digits – for products with little space.",
        where="On small packages such as chewing gum, lip balm or spices.",
        example="40170725",
        app="As with the EAN-13: item number, check digit and country of "
        "registration.",
        do="Look up online (DuckDuckGo), copy, share.",
        care="As with the EAN-13."),
    "upca": dict(
        title="UPC-A – American product number",
        mode="Barcode or All codes", devices=ALL,
        what="The **UPC-A** is the American counterpart of the EAN-13 with "
        "12 digits. It is mainly used in the USA and Canada.",
        where="On products from North America, e.g. imported groceries, "
        "games or electronics.",
        example="036000291452",
        app="The data card shows the item number, whether the check digit "
        "is correct, and the country of registration (USA and Canada). On "
        "iPhone and iPad the device reports this code as an EAN-13 with a "
        "leading 0 – the content is the same.",
        do="Look up online (DuckDuckGo), copy, share.",
        care="As with the EAN-13."),
    "upce": dict(
        title="UPC-E – short American product number",
        mode="Barcode or All codes", devices=ALL,
        what="The **UPC-E** is a shortened form of the UPC-A for small "
        "packages. Left-out zeros are added back when reading.",
        where="On small products from North America, e.g. drink cans.",
        example="01234565 – written out 012345000065.",
        app="The data card shows the number and whether the check digit is "
        "correct. For this, QR Viewer internally adds the left-out zeros.",
        do="Look up online (DuckDuckGo), copy, share.",
        care="As with the EAN-13."),
    "itf14": dict(
        title="ITF-14 – shipping carton", mode="Barcode or All codes",
        devices=ALL,
        what="The **ITF-14** does not identify a single product but a carton "
        "or pallet with several items. It has 14 digits and often a thick "
        "frame.",
        where="On outer cartons and transport packaging in warehouses or "
        "drinks stores.",
        example="14006381333938 – a carton containing the product from the "
        "EAN-13 example.",
        app="The data card shows the 14-digit item number, the check digit "
        "and the country of registration.",
        do="Look up online (DuckDuckGo), copy, share.",
        care="Nothing special."),
    "code128": dict(
        title="Code 128", mode="Barcode or All codes", devices=ALL,
        what="**Code 128** is a very common barcode that can store letters, "
        "digits and symbols – compact and reliable.",
        where="On parcel labels, delivery notes, warehouse shelves, library "
        "books and prescriptions.",
        example="QRV-2026-0001 – for example a delivery note number.",
        app="The content is shown as text.",
        do="Copy or share, e.g. to pass on a shipment or order number.",
        care="Nothing special."),
    "code39": dict(
        title="Code 39", mode="Barcode or All codes", devices=ALL,
        what="**Code 39** is one of the oldest barcodes. It can store capital "
        "letters, digits and a few symbols, but needs a lot of space for "
        "that.",
        where="On staff ID cards, inventory stickers, in industry, public "
        "authorities and healthcare.",
        example="WF-RATHAUS – for example an inventory sticker.",
        app="The content is shown as text.",
        do="Copy or share.",
        care="Nothing special."),
    "code93": dict(
        title="Code 93", mode="Barcode or All codes", devices=ALL,
        what="**Code 93** is a more compact development of Code 39 with a "
        "built-in error check.",
        where="In logistics, warehouse management and on Canada Post "
        "labels.",
        example="INVENTAR 4711 (inventory 4711)",
        app="The content is shown as text.",
        do="Copy or share.",
        care="Nothing special."),
    "codabar": dict(
        title="Codabar", mode="Barcode or All codes", devices=ALL,
        what="**Codabar** is a simple, old barcode for digits. A letter "
        "(A to D) at the beginning and end serves as start and stop "
        "character.",
        where="On library cards, blood bags, laboratory samples and "
        "consignment notes.",
        example="A123456789B – for example a card number.",
        app="The content is shown as text, including start and stop "
        "characters.",
        do="Copy or share.",
        care="Nothing special."),
    "itf": dict(
        title="ITF (Interleaved 2 of 5)", mode="All codes", devices=ALL,
        what="**ITF** stores digits in interleaved pairs, which makes it "
        "very compact. The ITF-14 on shipping cartons is a fixed form of it; "
        "the general ITF can contain any number of digit pairs.",
        where="In warehouses, on pallets, cartons and in industry.",
        example="12345678",
        app="The content is shown as text. QR Viewer reads this general form "
        "only with the scan type “All codes”.",
        do="Copy or share.",
        care="Nothing special."),
    "databar": dict(
        title="GS1 DataBar", mode="All codes", devices=APPLE,
        what="**GS1 DataBar** is a narrow barcode for item numbers that can "
        "also hold extra details such as weight or best-before date.",
        where="On fruit and vegetables (stickers), fresh meat, cheese and "
        "coupons.",
        example="(01)04006381333931 – the “(01)” means: an item number "
        "follows.",
        app="The content is shown as text.",
        do="Copy or share.",
        care="Android cannot read this code because Google's recognition "
        "does not support it."),
    "datamatrix_post": dict(
        title="Data Matrix – Deutsche Post stamp",
        mode="Data Matrix or All codes", devices=ALL,
        what="**Data Matrix** is a small square or rectangular code made of "
        "dots with a solid border on two sides. It stores a lot in little "
        "space. Deutsche Post, the German postal service, prints it on "
        "postage stamps and online stamps (“Matrixcode”).",
        where="On German postage stamps and online stamps, parcel labels, "
        "medicine packs and electronic components.",
        example="A recreated stamp code with the made-up tracking number "
        "A001234567300123456C.",
        app="QR Viewer recognizes the Deutsche Post code and calculates the "
        "tracking number from it. Below it the raw data is shown as columns "
        "of numbers. Other Data Matrix codes with text are handled like QR "
        "codes.",
        do="“Track shipment…” opens Deutsche Post shipment tracking after a "
        "confirmation. (Of course it will not find the example number.)",
        care="When tracking, Deutsche Post learns the tracking number."),
    "pdf417": dict(
        title="PDF417", mode="PDF417 or All codes", devices=ALL,
        what="**PDF417** is a wide, stacked code made of many small rows of "
        "bars. It stores a lot of text and copes well with damage.",
        where="On airline boarding passes, ID cards and driving licences "
        "(USA), shipping labels and freight documents.",
        example="A made-up boarding pass for Geraldine Mustermann, flight "
        "from Hanover (HAJ) to Munich (MUC).",
        app="The content is shown as text. The abbreviations on boarding "
        "passes are standardized; QR Viewer shows them as they are in the "
        "code.",
        do="Copy or share.",
        care="Boarding passes contain personal data such as your name and "
        "booking code. Do not post photos of them."),
    "aztec_vdv": dict(
        title="Aztec – Deutschlandticket (VDV eTicket)",
        mode="Aztec or All codes", devices=ALL,
        what="You recognize the **Aztec code** by the “bull's-eye” in the "
        "middle. It needs no white margin and is therefore popular for "
        "tickets on mobile phones. Bus and train tickets in Germany follow "
        "the **VDV standard** and are digitally signed so that nobody can "
        "forge them.",
        where="On the Deutschlandticket (Germany's nationwide public "
        "transport pass) and other bus and train tickets (VDV), train "
        "tickets of other countries and plane tickets.",
        example="The official sample ticket “Deutschlandsemesterticket” "
        "(student ticket) of Geraldine Mustermann, valid from 1 September "
        "2026 to 28 February 2027.",
        app="QR Viewer decodes the ticket on your device and shows ticket "
        "number, product (as a number if the app does not know the fare by "
        "name), validity, time of issue, holder (shortened, as stored in the "
        "ticket), date of birth, class and whether the **signature is "
        "valid**. You can expand the raw data.",
        do="See what is stored in your ticket. Copying passes on the raw "
        "data as a sequence of numbers.",
        care="QR Viewer is not an inspection device: the app only shows what "
        "is in the ticket and does not replace a ticket check. Do not share "
        "screenshots of your ticket – they contain your name and date of "
        "birth."),
    "aztec_vdv_test": dict(
        title="Aztec – test ticket from an unknown issuer",
        mode="Aztec or All codes", devices=ALL,
        what="A ticket following the **VDV standard**, just like the "
        "Deutschlandticket on the previous page. This time, however, the "
        "name is stored **in full** in the ticket. The catch: the ticket "
        "data is “locked” inside the digital signature. Only someone who "
        "has the issuer's public key can get it out again – and check at the "
        "same time that nothing has been changed.",
        where="This is what it looks like when QR Viewer does not know an "
        "issuer – for example a ticket from abroad, from a new transport "
        "association or a forged ticket.",
        example="A test ticket for **Max Mustermann** (born 1 January 1990), "
        "Deutschlandticket, ticket number 123456789. It is signed with a "
        "self-made test key of the made-up certification authority "
        "“XXTEST26”, not by a real transport company.",
        app="QR Viewer recognizes the code as “VDV eTicket (signed)” but "
        "finds no public key for this issuer. The app names the identifier "
        "of the certification authority (CA 5858544553543236 = “XXTEST26”) "
        "and reports that the ticket data cannot be read. It therefore does "
        "not show the name at all – not even partly. You can expand the raw "
        "data.",
        do="View and copy the raw data. Without the matching key, nothing "
        "more is possible.",
        care="QR Viewer only reads tickets whose issuer keys are publicly "
        "known and included in the app. An unknown issuer does not "
        "automatically mean that a ticket is forged – the app just cannot "
        "check it."),
}

ORDER = [
    "qr_text", "qr_url", "qr_bookmark", "qr_email", "qr_phone", "qr_sms", "qr_geo",
    "qr_contact", "qr_event", "qr_wifi", "qr_payment", "qr_otp", "qr_json",
    "qr_matter", "microqr", "ean13", "ean13_isbn", "ean8", "upca", "upce", "itf14",
    "code128", "code39", "code93", "codabar", "itf", "databar",
    "datamatrix_post", "pdf417", "aztec_vdv", "aztec_vdv_test",
]

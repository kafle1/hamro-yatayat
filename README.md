
![Image](https://i.ibb.co/CtN97sf/logo.png)

# Hamro Yatayat

Mobile based service platform that provides Vehicles and Drivers rental service on reservation basis.

Hamro Yatayat is a company established to provide rental service for all kinds of vehicles to its customers at the lowest rate possible.

Hire any Vehicle !
## Preview

![App Screenshot](https://i.ibb.co/jDP1cL4/2.png)

## Features

- Phone number sign-in with OTP autofill
- Browse and book vehicles (bus, car, jeep, van, SUV, taxi, cruiser, micro, carrier) or a driver
- Bidding on ride/booking requests
- Price check before confirming a booking
- Booking history and detailed booking view
- PDF booking confirmation, viewable and shareable
- Push notifications for booking and app updates
- In-app feedback form
- English and Nepali (ne_NP) localization, with a Nepali date picker
- Offline-state handling screen
- User profile management

## Tech Stack

Flutter, Dart, Firebase (Auth, Firestore, Cloud Messaging)

## Getting Started

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install) and a configured Firebase project.

```bash
git clone https://github.com/kafle1/hamro-yatayat.git
cd hamro-yatayat
flutter pub get
flutter run
```

Add your own `google-services.json` under `android/app/` before running on Android, and
your own release keystore before building a signed release.

### Toolchain note

This is a 2022-era Flutter project (pubspec targets Dart `>=2.12.0 <3.0.0`) with
dependencies pinned to versions from that time, for example `cloud_firestore ^3.0.0`,
`firebase_core ^1.10.6`, and `intl ^0.17.0`. On a current toolchain (tested with
Flutter 3.32.8 / Dart 3.8.1), `flutter pub get` fails immediately:

```
Because yatayat depends on flutter_localizations from sdk which depends on intl 0.20.2,
intl 0.20.2 is required.
So, because yatayat depends on intl ^0.17.0, version solving failed.
```

`flutter_localizations` in modern Flutter SDKs pins a newer `intl` than this project
allows, and bumping `intl` alone cascades into major-version upgrades across the
Firebase plugins (whose APIs changed between those majors), which is not a bounded fix.
To actually run this app, use a Flutter SDK from around the project's `.metadata`
revision (`3595343e20a61ff16d14e8ecc25f364276bb1b8b`, Flutter 2.x/early 3.x stable), or
plan a real dependency upgrade pass rather than a quick patch.

## Security note

`keystore.jks` (the Android release signing key) and `android/app/google-services.json`
were committed to this repo. They have been removed from tracking and added to
`.gitignore`, but since this repo is public and history has not been rewritten (no force
push), both files remain visible in old commits. Treat the signing key as compromised:
generate a new release keystore and re-sign future releases with it rather than reusing
this one.

## Developer

- [@kafle1](https://www.github.com/kafle1)

## Support / Contact

For support, email kafleniraj@gmail.com, Discord: Buckwheat#2612

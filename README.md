# Diary App

A Flutter diary app built for a mobile development course.

Login, registration, diary and profile screens with Firebase authentication and Provider-based settings.

<details>
<summary>Setup & technical notes</summary>

### Implementation

- Firebase initialisation and authentication screens.
- Diary home and detail screens; the home screen includes sample in-memory entries.
- Provider-based settings and SharedPreferences support.
- Shared constants, navigation and app-bar components.

### Getting started

Use Flutter with Dart `^3.7.2`. Configure your own Firebase project and platform configuration files before running:

```bash
flutter pub get
flutter run
```

The app starts in `lib/main.dart`. Screens are in `lib/screens/`, shared widgets in `lib/widgets/`, and settings state in `lib/providers/`.

### Related project

[Diary+](https://github.com/esatkee/MOB) is a related diary application with Supabase-backed data and more modular helpers.

</details>

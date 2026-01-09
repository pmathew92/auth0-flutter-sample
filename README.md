# Auth0 Flutter Sample

A sample Flutter application demonstrating Auth0 authentication integration using the [auth0_flutter](https://pub.dev/packages/auth0_flutter) package.

## Features

- User login via Auth0 Universal Login
- User logout
- Fetch stored credentials
- Check for valid credentials
- Secure credential storage using the Credentials Manager

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.5.0 or higher)
- An [Auth0](https://auth0.com/) account
- An Auth0 application configured for your platform (iOS/Android)

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/pmathew92/auth0-flutter-sample.git
cd auth0-flutter-sample
```

### 2. Configure Auth0 credentials

Create a `.env` file in the project root with your Auth0 credentials:

```
AUTH0_DOMAIN=your-tenant.us.auth0.com
AUTH0_CLIENT_ID=your-client-id
```

### 3. Configure callback URLs in Auth0 Dashboard

Add the following callback URLs in your Auth0 application settings:

**Android:**
```
demo://YOUR_AUTH0_DOMAIN/android/YOUR_PACKAGE_NAME/callback
```

**iOS:**
```
demo://YOUR_AUTH0_DOMAIN/ios/YOUR_BUNDLE_ID/callback
```

### 4. Install dependencies

```bash
flutter pub get
```

## Running the App

### Android

```bash
flutter run -d android
```

### iOS

```bash
cd ios && pod install && cd ..
flutter run -d ios
```

### Web

```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart          # App entry point and UI
└── auth_service.dart  # Auth0 authentication service
```

## Usage

1. Launch the app
2. Tap **Login** to authenticate via Auth0
3. After successful login, two additional buttons appear:
   - **Fetch Credentials** - Retrieves stored credentials
   - **Check Has Valid Credentials** - Verifies if valid credentials exist
4. Tap **Logout** to sign out

## Resources

- [Auth0 Flutter SDK Documentation](https://github.com/auth0/auth0-flutter)
- [Auth0 Flutter Quickstart](https://auth0.com/docs/quickstart/native/flutter)
- [Flutter Documentation](https://docs.flutter.dev/)

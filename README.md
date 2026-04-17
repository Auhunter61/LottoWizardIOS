# Lotto Wizard iPhone App

This folder contains the iPhone/iPad wrapper project for Lotto Wizard.

## What It Is

This is a lightweight iPhone/iPad shell around the hosted Lotto Wizard mobile experience.

It is designed to:

- open the Lotto Wizard mobile app inside a native iPhone shell
- give you a Mac/Xcode starting point without rebuilding the whole app in Swift
- keep the same backend/API path as the desktop, web, and Android surfaces

## What To Move To The Mac

Copy the whole folder:

- `C:\Users\User\Documents\LottoWizard\ios-app`

to your Mac, then open:

- `ios-app/LottoWizardIOS.xcodeproj`

## Local Mac Testing

For the iOS Simulator on the same Mac, the debug build is already pointed at:

- `http://127.0.0.1:8080/mobile-app/?shell=1&native=ios`

That means on the Mac you can run:

```bash
python3 -m http.server 8080 -d frontend
```

and the iOS Simulator can reach that URL.

For the live backend/API you would also run the hosted/mobile stack, or point the release build to the real domain later.

## Release Setup

Before a public iPhone build, update:

- `LottoWizardIOS/LottoWizardConfig.swift`

Look for:

- `startURL`

and set it to your real hosted mobile page, for example:

- `https://lottowizard.net/mobile-app/?shell=1&native=ios`

## Important Notes

- This is a first iPhone shell, not a full native rewrite.
- Before App Store release, you should generate a proper AppIcon set in Xcode from your final brand artwork.
- The project is meant to open on a Mac in Xcode, not build on Windows.

# SnapCart Flutter 🛍️

SnapCart is a responsive Flutter e-commerce demo inspired by a modern online shopping store. It includes fashion, footwear, electronics, beauty, accessories, and home products.

## Features

- Responsive product grid for mobile, tablet, and desktop widths
- Product categories and live search
- Product details and discount labels
- Add to cart, remove items, and update quantities
- Automatic subtotal, delivery fee, and total calculation
- Wishlist / favorites
- Checkout form with validation
- Demo order confirmation
- Profile, help, and about screens
- Material 3 styling with a purple SnapCart theme

## Technology

- Flutter / Dart
- Material 3 widgets
- Local sample data (no backend required to run)

## Folder structure

```text
snapcart_flutter/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── product.dart
│   ├── state/
│   │   └── shop_state.dart
│   ├── screens/
│   │   ├── main_shell.dart
│   │   ├── home_screen.dart
│   │   ├── product_detail_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── checkout_screen.dart
│   │   ├── favorites_screen.dart
│   │   └── profile_screen.dart
│   └── widgets/
│       └── product_card.dart
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

## Requirements

Install Flutter SDK and Android Studio or VS Code with the Flutter extension. Check your setup:

```bash
flutter doctor
```

## Run on Windows

1. Extract the ZIP.
2. Open the `snapcart_flutter` folder in VS Code.
3. Open Terminal → New Terminal.
4. Run:

```powershell
flutter pub get
flutter run
```

For Chrome:

```powershell
flutter config --enable-web
flutter run -d chrome
```

If web support is not configured, run `flutter create .` from the project root, then run `flutter pub get` again.

For Android, start an emulator or connect a phone with USB debugging enabled, then run `flutter devices` and `flutter run`.

## Important notes

- This version is a complete runnable **frontend demo** with sample products.
- Cart and wishlist state are kept in memory while the app is running. Restarting the app resets them.
- Checkout simulates order placement. It does not process real payments or save orders to a server.
- Login, registration, persistent database, product admin, and real order history need a backend. These can be added as a separate phase with Django REST Framework and MySQL or Firebase.

## Publish to GitHub

Create a new empty repository on GitHub named `snapcart-flutter`. Then run these commands inside the extracted project folder:

```powershell
git init
git add .
git commit -m "Create SnapCart Flutter e-commerce app"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/snapcart-flutter.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. If `origin` already exists, use `git remote set-url origin https://github.com/YOUR-USERNAME/snapcart-flutter.git`.

## Suggested future improvements

- Firebase or Django authentication
- MySQL-backed product catalogue and order history
- Admin product management
- Real payment gateway integration
- Product images from local assets or a trusted image CDN
- Unit and widget tests

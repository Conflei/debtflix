# Debtflix - Financial Data App

## 📱 About

**Debtflix** is a Flutter app that showcases modern development practices using **MVVM architecture** with **Riverpod** for state management and **Hive** for local storage.

### 🎯 What It Does

- View and manage credit score information
- Track credit card accounts and balances
- Monitor credit utilization rates
- Manage employment information
- Visualize financial data through charts

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.9.0+)
- iOS Simulator or Android Emulator

### Setup

1. **Clone & Install**

   ```bash
   git clone <repository-url>
   cd debtflix
   flutter pub get
   ```

2. **Generate Code** (Required for AutoRoute)

   ```bash
   make gen
   ```

3. **Run App**
   ```bash
   flutter run
   ```

## 🏗️ Tech Stack

- **Flutter** - Cross-platform framework
- **Riverpod** - State management
- **Hive** - Local database
- **AutoRoute** - Navigation
- **MVVM** - Architecture pattern

## 📊 Project Structure

```
lib/
├── core/                 # Utilities & config
├── data/                 # Models & adapters
├── features/             # App features
│   ├── credit/          # Credit features
│   └── user/            # User features
└── main.dart           # Entry point
```

## 🔧 Development

```bash
make gen          # Generate AutoRoute files
make watch        # Watch for changes
make setup        # Install & generate
make rebuild      # Clean & rebuild
```

## 🧪 Testing

```bash
flutter test test/unit/utils_test.dart    # Run Utils tests
flutter test test/widget/utils_widget_test.dart  # Run Widget tests
flutter test                              # Run all tests
```

## 📱 Platform Support

- **iOS** - iPhone and iPad
- **Android** - Phones and tablets

---

_Built with ❤️ using Flutter, Riverpod, and Hive_

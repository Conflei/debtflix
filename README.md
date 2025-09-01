# Debtflix - Financial Data Showcase App

## 📱 About

**Debtflix** is a standalone Flutter application designed to showcase modern Flutter development practices and demonstrate the integration of key technologies for building robust, scalable mobile applications. This project serves as a practical example of how to implement a financial data management app using industry-standard tools and architectural patterns.

### 🎯 Purpose

This app demonstrates how to build a complete financial data management system that allows users to:

- View and manage credit score information
- Track credit card accounts and balances
- Monitor credit utilization rates
- Manage employment information
- Visualize financial data through interactive charts

### 🏗️ Architecture & Technologies

**Debtflix** is built using the **MVVM (Model-View-ViewModel)** architecture pattern, ensuring clean separation of concerns and maintainable code structure.

#### Core Technologies:

- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language for Flutter development
- **Riverpod** - State management solution for predictable data flow
- **Hive** - Lightweight NoSQL database for local data storage
- **AutoRoute** - Declarative routing solution for Flutter

#### Key Features:

- **State Management**: Riverpod provides reactive state management with dependency injection
- **Local Storage**: Hive database for persistent data storage without internet connectivity
- **Navigation**: AutoRoute for type-safe, declarative routing
- **Data Visualization**: Interactive charts and progress indicators
- **Form Validation**: Comprehensive form validation with user feedback
- **Responsive Design**: Adaptive UI that works across different screen sizes

### 🎨 Design Philosophy

This project emphasizes:

- **Clean Architecture**: MVVM pattern for maintainable code
- **Reactive Programming**: Riverpod for state management
- **Offline-First**: Local data storage with Hive
- **Type Safety**: Strong typing throughout the application
- **User Experience**: Intuitive interfaces with proper validation

## 🚀 Getting Started

### Prerequisites

Before running this project, ensure you have the following installed:

- **Flutter SDK** (version 3.9.0 or higher)
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **iOS Simulator** (for iOS development) or **Android Emulator** (for Android development)

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd debtflix
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code** (Required for AutoRoute)

   ```bash
   make gen
   ```

   _This command generates the necessary route files for AutoRoute navigation. It's essential to run this step before running the app._

4. **Run the application**
   ```bash
   flutter run
   ```

### 🎯 Platform Support

This application has been tested and optimized for:

- **iOS** - iPhone and iPad devices
- **Android** - Android phones and tablets

_Note: While Flutter supports web and desktop platforms, this project focuses on mobile development and has been tested primarily on iOS and Android._

### 🔧 Development Commands

The project includes a `Makefile` with useful development commands:

```bash
make gen          # Generate AutoRoute files
make watch        # Watch for changes and regenerate code
make setup        # Install dependencies and generate code
make rebuild      # Clean, install dependencies, and regenerate code
```

## 📊 Project Structure

```
lib/
├── core/                 # Core utilities and configurations
│   ├── hive/            # Hive database setup
│   ├── misc/            # Utilities and constants
│   └── router/          # AutoRoute configuration
├── data/                # Data layer (MVVM Model)
│   └── models/          # Data models and Hive adapters
├── features/            # Feature-based modules
│   ├── credit/          # Credit-related features
│   └── user/            # User management features
└── main.dart           # Application entry point
```

## 🎯 Key Features Demonstrated

- **State Management**: Riverpod providers and consumers
- **Local Storage**: Hive database with type adapters
- **Navigation**: AutoRoute with type-safe routing
- **Form Handling**: MVVM pattern with form validation
- **Data Visualization**: Charts and progress indicators
- **Responsive UI**: Adaptive layouts with ScreenUtil

## 🤝 Contributing

This is a showcase project designed for learning and demonstration purposes. Feel free to explore the code, experiment with modifications, and use it as a reference for your own Flutter projects.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

_Built with ❤️ using Flutter, Riverpod, and Hive_

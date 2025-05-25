# Overload Pro App 💪

A modern Flutter application designed to help fitness enthusiasts track their workout progress, apply progressive overload, manage exercises, and achieve their fitness goals effectively.

## ✨ Features

- 📊 **Exercise Tracking**: Record weights, sets, and reps for each exercise
- 📈 **Progress Monitoring**: Visualize your workout progress over time
- 📝 **Workout Notes**: Add detailed notes to your workout sessions
- 📱 **User-Friendly Interface**: Clean and intuitive design for seamless experience
- 🔄 **Workout History**: Access your complete workout history
- 🌙 **Dark Mode Support**: Comfortable viewing in any lighting condition

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── extensions/
│   ├── generated/
│   ├── l10n/
│   ├── mixins/
│   ├── router/
│   ├── theme/
│   └── widgets/
├── features/
│   ├── exercise/
│   ├── history/
│   ├── main/
│   ├── profile/
│   ├── splash/
│   └── workout/
│  
└── product/
    ├── database/
    ├── di/
    ├── init/
    └── models/
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/weight-tracker-app.git
```

2. Navigate to project directory
```bash
cd weight-tracker-app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 📦 Dependencies

- **State Management**:  
  - flutter_bloc: ^8.1.3  
  - equatable: ^2.0.5

- **Dependency Injection**:  
  - get_it: ^7.6.0

- **Local Storage**:  
  - shared_preferences: ^2.2.2  
  - sqflite: ^2.3.0  
  - path_provider: ^2.1.1  
  - path: ^1.8.3

- **Charts**:  
  - fl_chart: ^0.71.0

- **Utilities**:  
  - intl: ^0.20.2  
  - uuid: ^4.2.1  
  - logger: ^2.5.0

- **Localization**:  
  - flutter_localizations (SDK)  
  - intl  
  - flutter_intl config enabled

## 🛠️ Development

### Code Generation

To generate necessary files:
```bash
flutter pub run build_runner build
```

### Code Style

This project follows the official Dart style guide. To ensure code consistency:

```bash
flutter format .
flutter analyze
```

## 📱 Screenshots

[Coming Soon]

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- All contributors who have helped shape this project 

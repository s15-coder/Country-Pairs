# 🌍 Country Pairs

A fun and educational mobile game designed for both iOS and Android devices. **Country Pairs** is a memory-based matching game where you pair up country flags to reveal their names — perfect for learning and testing your knowledge of world flags!

---

## 📚 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Installation](#-installation)
- [Folder Structure](#-Folder-Structure)
- [Dependencies](#-dependencies)
- [How to Use](#how-to-use)
- [API Reference](#-api-reference)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📖 Overview

Country Pairs is a mobile application designed for both iOS and Android devices. It’s a **matching countries flags game** with multiple difficulty levels and modes. The game stores player scores locally on the device, allowing users to track progress over time.

---

## ✨ Features

- 🧠 **Memory-Based Gameplay** – Match pairs of country flags to reveal their names.
- 🏳️ **All Country Flags Included** – Learn to recognize every nation's flag.
- 🎯 **4 Difficulty Levels** – Easy, Medium, Hard, and Expert. Challenge yourself at your own pace!
- 🏆 **Scoring System** – The faster you finish and the fewer mistakes you make, the higher your score!
- 🧑 **Custom Player Names** – Set your player name before each game for a personalized experience.
- 📊 **Local Score Tracking** – View your scores by difficulty and track your progress over time.
- ♻️ **Reset Option** – Clear your scores anytime to start fresh.

---

## 🚀 Installation

```bash
# Clone the repo
git clone https://github.com/your-username/country-pairs.git

# Navigate to the project directory
cd country-pairs

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🗂️ Folder Structure

```bash
├── components/      # Reusable UI widgets
├── constants/       # Static values and configurations
├── main.dart        # App entry point
├── models/          # Data models
├── pages/           # App screens/pages
├── providers/       # State management
├── services/        # Data handling and utilities
```

## 📦 Dependencies:

Main

- flutter

- flutter_riverpod – State management

- audioplayers – Audio playback

- cupertino_icons – iOS-style icons

- hive – Lightweight key-value database

- hive_flutter – Hive support for Flutter

- path_provider – File storage paths

Dev:

- flutter_test – Flutter testing framework

- hive_generator – Hive model generator

- build_runner – Code generation tool

- flutter_lints – Recommended lint rules

- flutter_launcher_icons – Generate app icons

## [🛠️ How to Use](#how-to-use)

1. Launch the app on your iOS or Android device.

2. Choose a difficulty level.

3. Set your player name.

4. Start matching flag pairs!

View your score at the end and try to beat it next time!

## 🔌 API Reference

This app currently does not use external APIs. All data (flags, scores) is handled locally on the device.

🤝 Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your improvements. For major changes, open an issue first to discuss what you’d like to change.

📄 License
This project is licensed under the MIT License. See the LICENSE file for details.

# My Awesome Task List 🚀

A simple, yet powerful, To-Do List mobile application built with Flutter, demonstrating the efficient use of **Hive** as a local NoSQL key-value database for persistent data storage. This app provides a seamless experience for managing your daily tasks right on your device, even offline!

---

## ✨ Features

* **Add New Tasks:** Quickly add new tasks to your list.
* **Mark as Complete/Incomplete:** Toggle the completion status of your tasks.
* **Delete Individual Tasks:** Remove tasks you no longer need.
* **Clear All Tasks:** A handy option in the app bar's menu to delete all tasks after confirmation.
* **Persistent Data:** All your tasks are saved locally using Hive, so they remain even if you close the app.
* **Fast & Responsive UI:** Leverages Hive's high performance for quick data operations and real-time UI updates.
* **Enhanced Typography:** Utilizes the Google Fonts package for a clean and appealing look.

---

## 🛠️ Technologies Used

* **Flutter:** The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Hive:** A lightweight and blazing-fast key-value database for Flutter and Dart, ideal for local, offline data storage.
* **`google_fonts`:** Flutter package to easily use fonts from fonts.google.com.
* **`path_provider`:** Flutter plugin for finding commonly used locations on the filesystem.

---

## 📦 Getting Started

Follow these steps to get a local copy of the project up and running on your machine.

### Prerequisites

* Flutter SDK installed (version 3.x.x recommended)
* Dart SDK (comes with Flutter)
* Xcode (for iOS development)
* Android Studio / VS Code with Flutter extensions

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/visakhvannery/hive_todo_app.git](https://github.com/visakhvannery/hive_todo_app.git)
    cd hive_todo_app
    ```

2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Generate Hive Adapters:**
    Hive requires code generation for custom objects.
    ```bash
    flutter pub run build_runner build
    ```
    (You might need `flutter pub run build_runner build --delete-conflicting-outputs` if you encounter conflicts.)

4.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 📂 Project Structure

hive_todo_app/
├── lib/
│   ├── main.dart             # Main app entry point, Hive initialization
│   ├── models/
│   │   └── todo.dart         # Todo data model with Hive annotations
│   │   └── todo.g.dart       # Generated Hive adapter for Todo (don't edit manually)
│   └── screens/
│       └── home_screen.dart  # UI for the To-Do list
├── pubspec.yaml              # Project dependencies and assets
├── README.md                 # This file
└── ... (other Flutter project files)


---

## ⚙️ How Hive is Used

1.  **`todo.dart`:**
    * The `Todo` class is defined as a `HiveObject` and annotated with `@HiveType` and `@HiveField` to mark it for Hive serialization.
    * `flutter pub run build_runner build` generates `todo.g.dart`, which contains the `TodoAdapter` for efficient data handling.

2.  **`main.dart`:**
    * `Hive.init()` is called to initialize the database in the application's document directory.
    * `Hive.registerAdapter(TodoAdapter())` registers our custom adapter so Hive knows how to store and retrieve `Todo` objects.
    * `Hive.openBox<Todo>('todos')` opens a named box (similar to a table) where `Todo` objects will be stored.

3.  **`home_screen.dart`:**
    * `Hive.box<Todo>('todos')` retrieves the opened box.
    * **`todoBox.add(newTodo)`:** Used to save new tasks.
    * **`todo.save()`:** Called when a `Todo` object's properties (like `isCompleted`) are modified to persist changes.
    * **`todoBox.deleteAt(index)`:** Used to remove individual tasks.
    * **`todoBox.clear()`:** Used in the "Clear All Tasks" functionality to remove all entries from the box.
    * **`ValueListenableBuilder(valueListenable: todoBox.listenable(), ...)`:** This widget listens for changes in the `todos` box and automatically rebuilds the UI, ensuring the task list is always up-to-date without manual `setState()` calls for data changes.

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to open an issue or submit a pull request.

---

## 📄 License

This project is open-sourced under the [MIT License](LICENSE).

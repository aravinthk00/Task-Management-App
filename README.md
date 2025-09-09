Task Management App
A modern, feature-rich task management application built with Flutter that helps you organize your tasks efficiently with a clean and intuitive user interface.

Features
✅ Task Management: Create, edit, and delete tasks

🔍 Search Functionality: Real-time search through task titles and descriptions

🎯 Smart Filtering: Filter tasks by completion status

📅 Smart Sorting: Sort tasks by due date (ascending/descending)

🎨 Modern UI: Clean Material Design interface with light and dark theme support

💾 Local Storage: Data persistence using SharedPreferences

📱 Responsive Design: Works seamlessly on different screen sizes

🌓 Theme Support: Automatic light/dark theme based on system settings

Screenshots
(Note: Add actual screenshots of your app here)

Task List Screen with search and bottom controls

Add/Edit Task Screen with form validation

Dark theme variant

Filter and sort interface

Installation & Setup
Prerequisites
Flutter SDK (version 3.0.0 or higher)

Dart (version 2.17.0 or higher)

Android Studio or VS Code with Flutter extension

An Android or iOS emulator, or a physical device

Steps to Run the App
Clone the repository

bash
git clone <your-repository-url>
cd task_manager
Install dependencies

bash
flutter pub get
Run the app

bash
flutter run
Build for production (optional)

bash
flutter build apk --release  # For Android
flutter build ios --release  # For iOS (requires macOS)
Project Structure
The app follows Clean Architecture principles with the following structure:

text
lib/
├── core/
│   ├── constants/          # App constants and theme
│   ├── providers/          # Global providers
│   └── utils/              # Utility functions
├── data/
│   ├── datasources/        # Data sources (local, remote)
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business logic
└── presentation/
    ├── pages/              # Screen widgets
    ├── providers/          # UI state providers
    └── widgets/            # Reusable UI components
Key Components
State Management
The app uses the Provider package for state management, ensuring a clean separation between UI and business logic.

Data Persistence
Tasks are stored locally using SharedPreferences, ensuring your data persists between app sessions.

Theme System
The app includes a comprehensive theme system with:

Light and dark theme variants

Consistent color scheme and typography

System theme detection

Usage Guide
Adding a Task
Tap the + (plus) button in the bottom right corner

Fill in the task title (required)

Add a description (optional)

Select a due date

Tap "Add Task" to save

Editing a Task
Tap the edit (pencil) icon on any task

Modify the task details

Tap "Save Changes" to update

Completing a Task
Tap the checkbox next to any task to mark it as completed

Tap again to mark it as incomplete

Searching Tasks
Use the search bar at the top to filter tasks by title or description

The list updates in real-time as you type

Filtering and Sorting
Use the "Hide Completed" button at the bottom left to show/hide completed tasks

Use the sort button at the bottom right to toggle between ascending/descending due date order

Deleting a Task
Tap the delete (trash) icon on any task

Confirm deletion in the dialog that appears

Dependencies
The app uses the following packages:

provider: State management

shared_preferences: Local data storage

intl: Date formatting and localization

equatable: Value comparison utilities

uuid: Unique ID generation

Customization
Modifying the Theme
Edit the AppTheme class in lib/core/constants/app_theme.dart to customize colors, typography, and other visual properties.

Adding New Task Properties
Update the Task entity in lib/domain/entities/task.dart

Update the TaskModel in lib/data/models/task_model.dart

Update the UI components to handle the new property

Changing Storage Method
Replace the LocalDataSource in lib/data/datasources/local_data_source.dart with your preferred storage solution (SQLite, Firebase, etc.).

Troubleshooting
Common Issues
App won't build

Run flutter clean and then flutter pub get

Ensure you're using the correct Flutter version

Tasks not saving

Check storage permissions on the device

Verify SharedPreferences is properly configured

UI looks different on various devices

The app uses responsive design principles, but test on different screen sizes

Getting Help
If you encounter issues:

Check the Flutter documentation

Search for similar issues in the package repositories

Create an issue in the project repository with details about the problem

Future Enhancements
Potential improvements for future versions:

Task categories and tags

Notifications for due tasks

Task sharing and collaboration

Cloud synchronization

Advanced filtering options

Task templates

Productivity analytics

Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgments
Flutter team for the excellent framework

Material Design for the design guidelines

The package authors for the dependencies used

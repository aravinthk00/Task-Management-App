📌 Task Management App – Flutter

A simple Task Management App built with Flutter, as part of the Pepper Cloud Flutter Developer assignment. The app allows users to create, edit, delete, and manage tasks with a clean Material Design UI.

🚀 Features

Task List: View all tasks with title, description, due date, and status

Add Task: Create new tasks with input validation

Edit Task: Update existing tasks with pre-filled details

Delete Task: Remove tasks from the list

Mark as Completed: Toggle task status (pending/completed)

Search by Title: Quickly find tasks by typing in the search bar

Filter by Status: Show only completed or pending tasks

Sort by Due Date: Sort tasks in ascending/descending order

Local Persistence: Tasks are stored locally using SharedPreferences / SQLite

Material Design UI: Clean, responsive design following Flutter best practices

🛠️ Tech Stack

Flutter (Dart)

Local Data Persistence: SharedPreferences / SQLite

State Management: [Provider / Bloc / setState] (update based on what you used)

▶️ Getting Started
Prerequisites

Install Flutter
 SDK

Set up an Android/iOS emulator or connect a physical device

Installation

Clone the Repository

git clone <repo-link>
cd <project-folder>


Install Dependencies

flutter pub get


Run the App

flutter run

📽 Demo

[Demo Video Link]

Screenshots (optional – add if you want to show UI previews)

📂 Project Structure
lib/
│-- main.dart
│-- models/       # Task model
│-- screens/      # UI screens (Task List, Add Task, Edit Task)
│-- widgets/      # Reusable widgets
│-- services/     # Local storage / API simulation

✅ Assignment Notes

This app fulfills all the assignment requirements:

Task CRUD operations

Navigation between screens

Local data persistence

Search, filter, and sort functionality

Material Design principles applied

Optional enhancements added:

 Search by title

 Filter completed tasks

 Sort by due date

📄 License

This project is for assignment/demo purposes only.

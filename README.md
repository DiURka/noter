# NoteR

## Overview
NoteR is a mobile application for note-taking. It allows users to create, edit, and delete notes. The app is built using Flutter and Firebase for backend services.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)
3. [Screens Overview](#screens-overview)
4. [Networking/Database](#networking-database)
5. [How to Understand the Code](#how-to-understand-the-code)
6. [Demo](#demo)

## Getting Started
Follow these steps to set up and run the project on your local machine:

1. Clone the repository: `git clone https://github.com/your-username/your-repo.git`
2. Navigate to the project directory: `cd noter`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Project Structure
The project follows a structured organization. Key directories include:
- `lib`: Contains all the Dart code for the application.
- `lib/models`: Data models used in the app.
- `lib/providers`: Provider classes for state management.
- `lib/screens`: Flutter widget screens.
- `lib/services`: Services for networking and Firebase integration.
- `lib/widgets`: Reusable UI components.

## Screens Overview
### Home Screen
- Displays a list of notes.
- Provides options to create, edit and delete the note.

### Note Detail Screen
- Shows detailed information of a selected note.

### Create Note Screen
- Allows creating a new note.

### Edit Note Screen
- Allows users to edit the title and content of a note.

### Authentication Screens
- Sign-in and sign-up screens for user authentication.

## Networking/Database
The app uses Firebase for backend services. Firebase Cloud Firestore is used to store and retrieve notes data.

## How to Understand the Code
1. **State Management**: The app uses the Provider package for state management. Look into `lib/providers` for details.
2. **Screen Implementation**: Each screen is implemented in the `lib/screens` directory.
3. **Networking**: Networking and database-related code can be found in the `lib/services` directory.

## Demo
![Alt text](<bandicam 2024-02-01 21-16-26-970.gif>)
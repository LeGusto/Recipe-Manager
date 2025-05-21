# Recipe-Manager

Recipe-Manager is a cross-platform recipe management application built using **C++** and **Qt/QML**. It allows users to create, view, and manage recipes with a user-friendly interface. The app integrates with **Firebase** for authentication and database management using REST APIs.

## Features

- **User Authentication**: Sign up, log in, and log out functionality with Firebase Authentication.
- **Recipe Management**:
  - Add new recipes with ingredients, steps, and cooking time.
  - View detailed recipes.
  - Delete recipes.
- **Responsive UI**: Built with QML for a modern and responsive user interface.
- **Cross-Platform**: Runs on Linux, Windows, and macOS.

## Setup and Installation

### Prerequisites

- **Qt 6.8 or higher**: Install Qt development tools.
- **CMake**: Ensure CMake is installed.
- **Firebase Configuration**:
  - Set the following environment variables:
    - `FIREBASE_API_KEY`: Your Firebase API key.
    - `FIREBASE_BASE_URL`: Your Firebase Realtime Database URL.

### Build Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/LeGusto/Recipe-Manager
   cd Recipe-Manager

2. Configure the project with CMake:
   ```bash
   cmake -B build -S .
3. Build the project:
   ```bash
   cmake --build build
4. Set the environment variables:
    - **Windows (CMD):**
    ```bash
    set FIREBASE_API_KEY=your_token_here
    set FIREBASE_BASE_URL=your_token_here
    ```
    - **Windows (PowerShell):**
    ```bash
    $env:FIREBASE_API_KEY = "your_token_here"
    $env:FIREBASE_BASE_URL = "your_token_here"
    ```
    - **Linux/macOS:**
    ```bash
    export FIREBASE_API_KEY=your_token_here
    export FIREBASE_BASE_URL=your_token_here
    ```
5. Run the application:
   ```bash
   ./build/appRecipe-Manager


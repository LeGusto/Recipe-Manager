# Recipe-Manager

Recipe-Manager is a cross-platform recipe management application built using **C++** and **Qt/QML**. It allows users to create, view, and manage recipes with a user-friendly interface. The app integrates with **Firebase** for authentication and database management using REST APIs.

<img src="https://github.com/user-attachments/assets/0de1c507-547b-4bd9-be60-4165f100ee1f" width="300" height="auto" alt="Title">
<img src="https://github.com/user-attachments/assets/d8deade2-c867-440e-be55-1e310b9059ca" width="300" height="auto" alt="Sign up">
<img src="https://github.com/user-attachments/assets/b38045c2-1c56-424f-afb4-92335f95186a" width="300" height="auto" alt="Log in">
<img src="https://github.com/user-attachments/assets/68c44040-8a7e-47fc-90e9-f90f9aaaaa27" width="300" height="auto" alt="Recipes">
<img src="https://github.com/user-attachments/assets/5de62e67-939c-404d-892d-556093fc6c25" width="300" height="auto" alt="Detailed view">
<img src="https://github.com/user-attachments/assets/9bc16693-d99b-4a9c-9112-4d6a3ae9f750" width="300" height="auto" alt="Create recipe">

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


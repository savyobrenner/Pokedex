# 📱 Pokedex App

An iOS app built to view information about Pokémon. Developed in **SwiftUI**, using the **MVVM-C (Model-View-ViewModel-Coordinator)**.

## ✨ Features

- Display a list of Pokémon with **pagination**.
- Search Pokémon by **name**, **ID**.
- Filter Pokémon by **types**.
- Detailed view of each Pokémon, including:
  - Name, number, and sprites (front and shiny images).
  - Pokémon types, with distinct colors.
  - Statistics.

## 🧩 Design System

A **design system** with **atomic components** was implemented for consistent reuse throughout the app, providing easier maintenance:

- **PDImageView**: A component that downloads images, with support for caching and placeholders.
- **PDTextField**: A custom text field following the app's design system.

## 🔗 Dependencies

The app was developed without external libraries.

## 🎨 Code Style Best Practices

- Proper **indentation and line breaks** to ensure code readability.
- **No force unwrapping**: Ensuring code safety and preventing unexpected crashes.
- **Decoupled ViewModels and Services**: Dividing responsibilities and making the code more modular.
- **Minimum deployment target: iOS 16**: For a more stable version of SwiftUI framework.

## 🚀 How to Run the Project

1. Clone the repository to your machine:
2. Open the project in **Xcode**.
3. Select the simulator of your choice or a physical device.
4. Compile and run the project.

## 📜 Project Structure

- **Coordinators/**: Contains all the Coordinators that manage the navigation between screens.
- **Views/**: Contains all the Views, developed in SwiftUI.
- **ViewModels/**: Contains the logic and business rules associated with each View.
- **Models/**: Contains the app's data structures.
- **Services/**: Contains services for API communication and network logic.
- **Components/**: Reusable components, such as `PDImageView` and `PDTextField`.

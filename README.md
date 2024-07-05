# Gemini Chat App

Gemini Chat App is a Flutter application that integrates Gemini AI to provide an intelligent and interactive chatbot experience. This application uses the BLoC pattern for state management and allows users to send text messages as well as images.

## Features

- Interactive chat with Gemini AI
- Support for sending images
- Typing indicator for AI responses
- State management using the BLoC pattern
- Responsive and attractive UI using DashChat

## Usage

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Make sure you have an API key from Gemini. Add your API key in `lib/utils/constants.dart`:

   ```dart
   const apiKey = 'YOUR_API_KEY_HERE';

4. Run the application with the command `flutter run`

## Project Structure

-   `lib/`
-   -   `bloc/` - Contains BLoC for state management
-   -   `models/` - Contains data models
-   -   `pages/` - Contains page widgets
-   -   `utils/` - Contains utility files and constants
-   `main.dart` - Entry point of the application

## Dependencies

-   flutter_bloc:
-   equatable:
-   dash_chat_2:
-   flutter_gemini:
-   image_picker:
-   flutter_markdown:

## References

This project is inspired by and adapts several concepts from the following YouTube tutorial:
Here's the link : https://www.youtube.com/watch?v=PoZ9iRL16As&t=1042s
by Hussain Mustafa


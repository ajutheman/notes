# Flutter Firebase Notes App - README

## 📱 Project Overview
This is a beautiful and modern **Flutter Notes App** with:
- Email & Password Authentication using **Firebase Auth**
- Personal Notes Management using **Cloud Firestore**
- State management using **Bloc**
- Modular, scalable folder structure
- Responsive, colorful, and user-friendly UI design
---

## 🚀 Features
### ✅ User Authentication
- Sign Up with email and password
- Login with email and password
- Firebase secure authentication integration
- 
### ✅ Notes Management
- Create, edit, delete personal notes
- Each note contains title, content, timestamp
- Real-time sync with Firestore
- Only user-specific notes are shown

### ✅ User Profile
- Displays user email
- Shows last login time
- Logout functionality with confirmation dialog

### ✅ UI Highlights
- Gradient backgrounds and modern typography
- Smooth animations and shadows
- Custom reusable widgets: buttons, text fields, loading indicators
- Empty state visuals when no notes are present

---

## 🗂 Folder Structure Explanation

```
lib/
│── main.dart                     -> Entry point calling app.dart
│── app.dart                      -> App-wide setup with theme & routing
│── core/
│   ├── firebase_service.dart     -> Firebase initialization logic
│── data/
│   ├── models/
│   │   ├── note_model.dart       -> Note model class
│   ├── repositories/
│   │   ├── auth_repository.dart  -> Handles user authentication operations
│   │   ├── notes_repository.dart -> CRUD operations for notes
│── logic/
│   ├── blocs/
│   │   ├── auth_bloc/            -> Auth state management
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   ├── auth_state.dart
│   │   ├── notes_bloc/           -> Notes state management
│   │   │   ├── notes_bloc.dart
│   │   │   ├── notes_event.dart
│   │   │   ├── notes_state.dart
│── presentation/
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   ├── home/
│   │   │   ├── notes_list_screen.dart
│   │   │   ├── note_editor_screen.dart
│   │   │   ├── note_details_screen.dart
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│── widgets/
│   ├── custom_button.dart        -> Reusable styled button
│   ├── custom_textfield.dart     -> Reusable input textfield
│   ├── loading_indicator.dart    -> Circular loading spinner
```

---

## 🔧 Setup Instructions
1. Clone the repo:
```
git clone <your-repo-url>
cd <project-folder>
```
2. Install dependencies:
```
flutter pub get
```
3. Setup Firebase:
- Go to [Firebase Console](https://console.firebase.google.com/)
- Add Android/iOS app
- Download `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS)
- Place it in:
```
android/app/google-services.json
```
4. Update your `android/app/build.gradle`:
```
defaultConfig {
   applicationId "com.your.app.id"
   minSdkVersion 23
   targetSdkVersion 34
   ...
}
```
5. Run:
```
flutter run
```

---

## 📚 State Management Explanation
- Uses `Bloc` for state management.
- Separate blocs for authentication and notes.
- `auth_bloc` listens to authentication changes, handles login, logout, register.
- `notes_bloc` listens to real-time changes from Firestore and updates UI.

---

## ✏️ Reusable Widgets Explained
- `custom_button.dart` -> Used for buttons across auth and profile screens.
- `custom_textfield.dart` -> Clean input fields with border radius and hints.
- `loading_indicator.dart` -> Used during loading states.

---

## ✅ Best Practices Followed
- Modular folder structure
- Dependency injection through repositories
- Clean separation of logic, data, and presentation
- Bloc pattern for scalability
- Error handling and toast notifications
- Fallback defaults for missing data

---

## 🤝 Contribution
- Feel free to fork this project and submit PRs for improvement!
## 🔗 License
MIT License
## ❤️ Built with Flutter & Firebase


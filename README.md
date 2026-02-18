# Rental Property App

A modern Flutter application for managing rental properties with a clean and intuitive UI.

## 📁 Project Structure

```
rental/
├── assets/
│   └── images/                 # Image assets
├── lib/
│   ├── constants/             # App-wide constants
│   │   └── colors.dart        # Color palette and gradients
│   ├── screens/               # All app screens
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── dashboard_screen.dart
│   │   └── forgot_password/   # Forgot password flow
│   │       ├── enter_email_screen.dart
│   │       ├── enter_otp_screen.dart
│   │       └── reset_password_screen.dart
│   ├── widgets/               # Reusable widgets
│   │   ├── custom_button.dart
│   │   └── custom_textfield.dart
│   └── main.dart              # App entry point
└── pubspec.yaml              # Dependencies
```

## 🎯 Features

### ✅ Implemented (UI Only)
- **Splash Screen**: Animated splash screen with app logo and branding
- **Login Screen**: Email and password authentication UI
- **Forgot Password Flow**:
  - Enter email screen
  - OTP verification screen (6-digit code)
  - Reset password screen
  - Success notification with snackbar
- **Dashboard**: Dummy dashboard with:
  - User greeting
  - Search bar
  - Quick stats cards (Properties, Tenants, Revenue, Pending)
  - Featured property listings

### 🎨 Design Features
- Modern gradient-based color scheme (Deep Blue to Teal)
- Smooth animations and transitions
- Custom reusable components
- Form validation
- Loading states
- Responsive layout

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository or navigate to the project directory:
```bash
cd c:\Users\azlan\StudioProjects\rental
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 App Flow

1. **Splash Screen** → Displays for 3 seconds with animation
2. **Login Screen** → 
   - Enter email and password
   - Option to "Forgot Password"
   - Login button navigates to Dashboard
3. **Forgot Password Flow**:
   - **Step 1**: Enter email address
   - **Step 2**: Enter 6-digit OTP
   - **Step 3**: Enter new password and confirm
   - **Success**: Snackbar notification → Back to Login
4. **Dashboard** → Dummy dashboard with property stats and listings

## 🎨 Color Palette

- **Primary Dark**: `#1a237e` (Deep Blue)
- **Primary Light**: `#00acc1` (Teal)
- **Background**: `#F5F5F5` (Light Gray)
- **Text Primary**: `#212121` (Dark Gray)
- **Text Secondary**: `#757575` (Medium Gray)
- **Success**: `#4CAF50` (Green)
- **Error**: `#E53935` (Red)

## 🧩 Custom Widgets

### CustomButton
- Gradient background
- Outlined variant available
- Loading state support
- Customizable text and callbacks

### CustomTextField
- Consistent styling across the app
- Built-in validation support
- Supports password fields with visibility toggle
- Multiple input types (email, text, number)

## ⚠️ Important Notes

- This is **UI only** - no backend integration
- All authentication flows are simulated with delays
- OTP verification accepts any 6-digit code
- Dashboard data is hardcoded dummy data
- No actual data persistence

## 🔧 Next Steps (For Future Development)

1. **Backend Integration**:
   - Connect to authentication API
   - Implement real OTP sending/verification
   - Add user session management

2. **Database**:
   - Add local storage (SQLite/Hive)
   - Implement remote database connection

3. **Features**:
   - Property detail screens
   - Add/Edit properties
   - Tenant management
   - Payment tracking
   - Notifications

4. **Improvements**:
   - Add unit tests
   - Implement state management (Provider/Riverpod/Bloc)
   - Add error handling
   - Implement proper form validation with backend

## 📄 License

This project is a template for educational purposes.

## 👨‍💻 Development

To modify the UI:
1. Update colors in `lib/constants/colors.dart`
2. Modify screens in `lib/screens/`
3. Update reusable widgets in `lib/widgets/`
4. Run `flutter run` to see changes

---

**Note**: This is a UI-only implementation. Backend integration and actual functionality need to be implemented separately.

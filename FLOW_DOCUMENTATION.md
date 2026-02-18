# App Flow Documentation

## Screen Navigation Flow

```
┌─────────────────┐
│                 │
│ Splash Screen   │ (3 seconds with animation)
│                 │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│                 │
│  Login Screen   │ ◄────────────────────────┐
│                 │                          │
└────┬───────┬────┘                          │
     │       │                               │
     │       └──────► Forgot Password Flow   │
     │                                       │
     │       ┌────────────────────┐          │
     │       │ 1. Enter Email     │          │
     │       └──────┬─────────────┘          │
     │              │                        │
     │              ▼                        │
     │       ┌────────────────────┐          │
     │       │ 2. Enter OTP       │          │
     │       │    (6 digits)      │          │
     │       └──────┬─────────────┘          │
     │              │                        │
     │              ▼                        │
     │       ┌────────────────────┐          │
     │       │ 3. Reset Password  │          │
     │       │    (New + Confirm) │          │
     │       └──────┬─────────────┘          │
     │              │                        │
     │              │ Success Snackbar       │
     │              └────────────────────────┘
     │
     │ (Login button)
     │
     ▼
┌─────────────────┐
│                 │
│   Dashboard     │
│   (Dummy data)  │
│                 │
└─────────────────┘
```

## Screen Details

### 1. Splash Screen
- **Duration**: 3 seconds
- **Animation**: Fade + Scale
- **Elements**: 
  - House icon in rounded container
  - App name: "Rental Property"
  - Tagline: "Find Your Perfect Home"
  - Gradient background (Blue to Teal)
- **Auto-navigation**: → Login Screen

### 2. Login Screen
- **Inputs**:
  - Email (validated)
  - Password (min 6 chars, with visibility toggle)
- **Actions**:
  - Login button → Dashboard
  - Forgot Password link → Enter Email Screen
- **Features**:
  - Form validation
  - Loading state
  - Decorative property icon

### 3. Forgot Password Flow

#### 3a. Enter Email Screen
- **Input**: Email address
- **Validation**: Email format
- **Action**: Send Verification Code → OTP Screen
- **Icon**: Email icon in gradient circle
- **Back**: Returns to Login

#### 3b. Enter OTP Screen
- **Input**: 6 individual digit boxes
- **Features**:
  - Auto-focus next/previous box
  - Numeric keyboard
  - Resend OTP option
- **Action**: Verify OTP → Reset Password Screen
- **Icon**: Lock reset icon in gradient circle

#### 3c. Reset Password Screen
- **Inputs**:
  - New Password (min 6 chars, with visibility toggle)
  - Confirm Password (must match)
- **Validation**: 
  - Minimum length
  - Password match
- **Action**: Reset Password → Success Snackbar → Login Screen
- **Features**:
  - Password requirements display
  - Key icon in gradient circle

### 4. Dashboard Screen
- **Header**:
  - User greeting: "Welcome Back, John Doe"
  - Profile avatar
  - Search bar
- **Quick Stats** (4 cards):
  - Properties: 12
  - Tenants: 8
  - Revenue: $12,500
  - Pending: 3
- **Featured Properties** (2 sample cards):
  - Modern Villa
  - Luxury Apartment
- **Property Card Details**:
  - Image/Icon
  - Title & Location
  - Bedrooms & Bathrooms
  - Price per month

## Validation Rules

### Email
- Required
- Must contain '@'

### Password (Login)
- Required
- Minimum 6 characters

### Password (Reset)
- Required
- Minimum 6 characters
- Confirm password must match new password

### OTP
- Required
- Exactly 6 digits
- Numeric only

## UI/UX Features

### Animations
- Splash screen: Fade in + Scale
- Screen transitions: Slide navigation
- Button press: Ripple effect
- Loading states: Circular progress indicator

### Visual Feedback
- Form validation errors
- Success/Error snackbars
- Loading indicators
- Password visibility toggle
- Focused input highlighting

### Design Elements
- Gradient backgrounds
- Rounded corners (12-16px)
- Card shadows
- Icon containers with gradient
- Consistent spacing
- Material Design 3

## Color Scheme

### Primary Colors
- Deep Blue: #1a237e
- Teal: #00acc1
- Gradient: Deep Blue → Teal

### Neutral Colors
- Background: #F5F5F5
- Card Background: #FFFFFF
- Text Primary: #212121
- Text Secondary: #757575
- Text Hint: #9E9E9E

### Semantic Colors
- Success: #4CAF50 (Green)
- Error: #E53935 (Red)
- Warning: #FF9800 (Orange)

### Borders
- Input Border: #E0E0E0
- Focus Border: #00acc1 (Teal)

## Typography

### Headings
- H1: 32px, Bold
- H2: 28px, Bold
- H3: 20px, Bold
- H4: 18px, Bold

### Body Text
- Large: 16px
- Medium: 15px
- Small: 14px
- Extra Small: 13px

### Font Weights
- Regular: 400
- Medium: 500
- Semi-Bold: 600
- Bold: 700

## Component Reusability

### CustomButton
```dart
CustomButton(
  text: 'Button Text',
  onPressed: () {},
  isLoading: false,      // Shows loading indicator
  isOutlined: false,     // Outlined variant
)
```

### CustomTextField
```dart
CustomTextField(
  label: 'Label',
  hint: 'Hint text',
  controller: controller,
  obscureText: false,    // For passwords
  keyboardType: TextInputType.text,
  validator: (value) => null,
  suffixIcon: Icon(...),
  maxLength: null,
)
```

## Notes for Future Development

### Backend Integration Points
1. **Login**: POST /api/auth/login
2. **Send OTP**: POST /api/auth/forgot-password
3. **Verify OTP**: POST /api/auth/verify-otp
4. **Reset Password**: POST /api/auth/reset-password
5. **Get Dashboard Data**: GET /api/dashboard
6. **Get Properties**: GET /api/properties

### State Management
- Consider adding Provider, Riverpod, or Bloc
- Manage user session
- Handle authentication state
- Cache dashboard data

### Local Storage
- Store user token
- Cache user profile
- Remember login state
- Store app preferences

### Error Handling
- Network errors
- Validation errors
- API errors
- User-friendly messages

### Testing
- Unit tests for validation logic
- Widget tests for UI components
- Integration tests for flows
- E2E tests for complete scenarios

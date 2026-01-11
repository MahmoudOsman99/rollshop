# Rollshop - AI Coding Instructions

## Project Overview
Rollshop is a Flutter/Firebase application for recording chock details and managing parts by material number. The app uses clean architecture with BLoC state management and Firebase as the backend.

## Architecture Pattern

### Clean Architecture Layers
The codebase follows a feature-based clean architecture:
```
lib/features/<feature>/
  ├── cubit/          # BLoC state management
  ├── data/
  │   ├── data_source/remote/  # Firebase interactions
  │   ├── repository/          # Abstract + Implementation
  │   └── models/              # Data models
  ├── screens/        # UI screens
  └── widgets/        # Feature-specific widgets
```

**Key Features:**
- `auth/` - User authentication and registration
- `chock_feature/` - Chock types, assembly steps, bearing types
- `parts_with_material_number/` - Parts management
- `users/` - User management and approval system
- `main/` - Main screen, settings, profile

### Repository Pattern
- **Abstract repository** defines the contract (e.g., `AuthRepository`)
- **Implementation** extends/implements abstract class (e.g., `AuthRepositoryImpl`)
- Repositories use **Dartz** `Either<Failure, T>` for error handling
- Example: `Future<Either<Failure, UserModel>> currentUser({required String userId})`

### Data Flow
1. **Cubit** calls repository methods
2. **Repository** delegates to remote data source
3. **Remote data source** interacts with Firebase (Firestore/Auth/Storage)
4. Results wrapped in `Either<Failure, T>` for functional error handling
5. **Cubit** emits states consumed by UI

## Dependency Injection

Uses **GetIt** (`injection_container.dart`) for service locator pattern:
```dart
// Register in init()
sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemote: sl()));
sl.registerLazySingleton<AuthCubit>(() => AuthCubit(authRepo: sl()));

// Access in code
final sl = GetIt.instance;
sl<AuthCubit>()
```

All feature dependencies registered in `injection_container.dart` with lazy singletons.

## State Management

### BLoC/Cubit Pattern
- All features use **Cubits** (simplified BLoC without events)
- Global cubits provided in `app.dart` via `MultiBlocProvider`
- Access pattern: `context.read<FeatureCubit>()` or `BlocProvider.of<FeatureCubit>(context)`
- Custom `BlocObserver` in `BlocObserver.dart` logs all state changes

### Key Cubits
- `AppCubit` - Theme and locale management
- `AuthCubit` - Authentication flows
- `UserCubit` - User operations and approval
- `ChockCubit` - Chock management, assembly steps, image handling
- `PartsCubit` - Parts with material number CRUD

## Firebase Integration

### Collections Structure
Defined in `lib/core/helpers/collections_paths.dart`:
```dart
- "chocks-types"
- "bearing-types"
- "users"
- "parts_with_material_number"
```

### Firebase Services
- **Firestore**: Document storage and queries
- **Firebase Auth**: Email/password authentication
- **Firebase Storage**: Image uploads (chock images, assembly step images)
- Initialized in `main.dart` with `Firebase.initializeApp()`

## Error Handling

Custom failure types in `lib/core/errors/failure.dart`:
- Base: `Failure` (extends `Equatable`)
- Auth: `UserSignInFailure`, `EmailAlreadyExistsFailure`, `UserNotFoundFailure`
- Generic: `ServerFailure`, `UnexpectedError`

Pattern: Return `Either<Failure, T>` from repositories, handle in Cubit with fold/pattern matching.

## UI Conventions

### Responsive Design
- Uses **flutter_screenutil** for responsive sizing
- Design baseline: `Size(375, 812)`
- Initialize in `app.dart`: `ScreenUtilInit(designSize: Size(375, 812))`
- Use `.sp`, `.w`, `.h` extensions for scaled dimensions

### Theming
- Light/Dark themes in `lib/core/theme/theme.dart`
- Material 3 enabled (`useMaterial3: true`)
- Theme persistence via `AppCubit.loadThemeAndLocale()`
- Seed color: `ColorsManager.mainBlue`

### Localization
- Supports Arabic (`ar`) and English (`en`)
- Uses `flutter_localizations` package
- Locale managed by `AppCubit`

### Navigation
- Centralized in `lib/core/router/app_router.dart`
- Route constants in `lib/core/router/routers.dart`
- Pattern: Named routes with arguments passed via `RouteSettings`

## Models & Data

### Model Structure
- Data classes with `fromJson`/`toJson` factory methods
- Extend `Equatable` for value comparison (e.g., `UserModel`)
- Firestore document IDs passed separately: `fromJson(json, idFromFirebase: id)`

### Key Models
- `UserModel`: User data with approval status, user type (admin/user)
- `ChockTypesModel`: Chock with assembly steps, parts, bearing type
- `PartsWithMaterialNumberModel`: Parts inventory
- `AssemblyStepModel`: Individual assembly instruction with images

## Image Handling

Image operations in `lib/core/helpers/image_handler.dart`:
- Use `ImagePicker` for camera/gallery selection
- Upload to Firebase Storage
- Image compression via `flutter_image_compress`
- Display with `CachedNetworkImage` for performance

## Development Workflows

### Adding a New Feature
1. Create feature folder in `lib/features/<feature_name>/`
2. Define data models with `fromJson`/`toJson`
3. Create abstract repository interface
4. Implement repository with remote data source
5. Create Cubit with states
6. Register dependencies in `injection_container.dart`
7. Add Cubit to `MultiBlocProvider` in `app.dart`
8. Define routes in `app_router.dart`

### Running the App
```bash
flutter pub get
flutter run
```

### Firebase Setup
- Configuration in `firebase_options.dart`
- Platform-specific: `android/app/google-services.json`
- Ensure Firebase project initialized before local development

### Code Style
- Follow official Dart/Flutter conventions
- Use `const` constructors where possible
- Named parameters for clarity (especially in widgets)
- Commented-out code present in codebase - check with team before removal

## Common Patterns

### Conditional Rendering
Uses `conditional_builder_null_safety` package for clean conditional UI:
```dart
ConditionalBuilder(
  condition: state is LoadedState,
  builder: (context) => SuccessWidget(),
  fallback: (context) => LoadingWidget(),
)
```

### Internet Connectivity
`internet_connection_checker_plus` for network status checks before Firebase operations.

### User Approval Flow
Users register → stored in users collection with `isApproved: false` → Admin approves → `isApproved: true` → User can sign in.

## Important Notes

- **Portrait only**: App locked to portrait orientation in `main.dart`
- **Shared Preferences**: Used for theme/locale persistence
- **Email validation**: Uses `email_validator` package
- **Image slideshow**: `flutter_image_slideshow` for chock/assembly images
- **Photo viewing**: `photo_view` package for zoomable images
- **Navigation bar**: `animated_bottom_navigation_bar` for main navigation

## Testing
Test files in `test/` directory. Run with:
```bash
flutter test
```

---
*When modifying this codebase, respect the clean architecture boundaries, maintain the Either-based error handling, and ensure all new features follow the established repository-cubit-UI pattern.*

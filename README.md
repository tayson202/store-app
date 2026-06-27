# GymUnity

GymUnity is a modern, premium e-commerce and product comparison marketplace application built with Flutter. It utilizes Clean Architecture, GetX state management, and a highly responsive design system.

---

## Key Features

### 🎬 Product Showcases (Reels Feed)
- **Smooth Reels Feed:** Instagram/TikTok-style full-screen vertical video feed with page-based snapping.
- **Auto-Play/Pause Lifecycle:** Optimized player visibility detection, auto-playing the active video and pausing background clips.
- **Glassmorphic Product Card:** Floating premium translucent product card displaying rating, seller name, compare button, and navigation.
- **Interactive Sidebar:** Single-tap like updates, comments count with sliding bottom-sheet interactions, bookmarking, and native sharing.
- **Showcase Studio (Seller Dashboard):** Upload showcases up to 60 seconds, configure pricing/deals, track aggregate CTRs, and manage posts.

### 🛍️ E-Commerce & Checkout
- **Cart & Wishlist Lifecycle:** Live persistent updates with active state management and offline synchronization.
- **Address Management:** Comprehensive address selector with form validation and intelligent default settings.
- **Order Confirmations:** Video confirmation loops showing order status success.

### 🔐 Authentication & Onboarding
- **Onboarding flow:** Dynamic slider view featuring custom video backdrops.
- **Secure Authentication:** Persistent sign-in sessions, form validation, and dark mode theme controls.

---

## Architecture & Structure

The codebase is organized following **Clean Architecture** principles to separate concerns, ensure testability, and decouple layers (Data, Domain, and Presentation).

```
lib/
├── MODELS/                  # Shared core data models
├── controllers/             # Global application controllers (theme, cart, auth)
├── features/                # Domain-specific modules
│   ├── reels/               # Reels feature module
│   │   ├── data/            # Models, repositories, and datasources (Mock/Firebase)
│   │   ├── domain/          # Repository contracts
│   │   └── presentation/    # GetX controllers, views, and reusable widgets
│   ├── checkout/
│   ├── shippingaddress/
│   └── ...
├── view/                    # General app views (home, splash, account)
└── widgets/                 # Reusable shared UI widgets
```

---

## Technology Stack

- **Framework:** Flutter (Dart SDK >= 3.9.2)
- **State Management:** GetX (MVVM pattern)
- **Persistence:** GetStorage (Local cache & auth/cart state sessions)
- **Media Playback:** video_player
- **UI & Animations:** flutter_animate, shimmer, google_fonts

---

## Setup & Running

### Prerequisites
- Flutter SDK configured
- Developer Mode enabled on Windows (if building for Windows desktop desktop platform)

### Commands
```bash
# Fetch dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run unit and widget tests
flutter test

# Run the application (Chrome / Windows / mobile)
flutter run -d chrome
```

# 🍕 FeastFlow — Production Food Delivery Flutter Application

[![Flutter](https://img.shields.io/badge/Flutter-3.47.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.2-0175C2?logo=dart)](https://dart.dev)
[![GetX](https://img.shields.io/badge/State%20Management-GetX%204.7.3-8A2BE2)](https://pub.dev/packages/get)
[![Storage](https://img.shields.io/badge/Local%20Storage-GetStorage-FF7622)](https://pub.dev/packages/get_storage)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture%20(Feature--First)-059C6A)](#architecture--design-patterns)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> **FeastFlow** is a comprehensive, production-grade Food Delivery application crafted in Flutter and Dart, strictly adhering to **Clean Architecture**, **SOLID Principles**, and modern reactive state management with **GetX**. It features **52+ responsive screens** pixel-perfectly implemented from the [Figma Community Food Delivery UI Kit](https://www.figma.com/design/L18iufVCMSlT51JnioscaU/Food-Delivery-App--Community-), complete with 3 operational role portals (**Customer Ordering**, **Chef / Kitchen Management**, and **Rider / Courier Logistics**).

---

## 🌟 Key Highlights & Engineering Features

- **52 Complete Figma Screens**: Complete user journey including Onboarding, Authentication, Discovery, Restaurant Details, Add-on Customization, Cart, Checkout, Live GPS Tracking, Driver Chat, Voice Calling, Order History, Rating, Chef Portal, Rider Dispatch, and System Fallback States.
- **Interactive Screen Catalog (`AppRoutes.screenCatalog`)**: A built-in visual gallery enabling instant 1-tap navigation to any of the 52 screens with instant live search, category chips, and dark mode toggling.
- **Clean Architecture & SOLID**: Strict separation between `Domain` (pure enterprise business rules, entities, and repository contracts), `Data` (models, JSON serialization, and data sources), and `Presentation` (GetX controllers, reactive bindings, and custom widgets).
- **Three Unified User Roles**:
  - 🛒 **Customer Role**: Browse gourmet foods, customize ingredients/add-ons, manage multi-address books & cards, track active deliveries on animated maps, chat with drivers, and leave ratings.
  - 👨‍🍳 **Chef / Kitchen Portal**: Kitchen KPI dashboard, live incoming order pipeline, order progress manager, recipe/dish catalog, add new dishes, and earnings ledger.
  - 🛵 **Rider / Courier Portal**: Real-time dispatch feed with pickup & drop-off locations, GPS turn-by-turn route canvas painter, delivery slider workflow, and weekly earnings bar charts with instant cashout.
- **Apple-Grade Micro-Interactions & Physics**: Fluid spring physics (`iosSpring`, `iosEaseOut`), bouncing buttons (`BouncingButton` with 0.96 scale-down & haptic clicks), and iOS `BouncingScrollPhysics` across all screens.
- **Lazy Loading & Skeleton Shimmer**: Custom `AppShimmer` skeleton system covering banners, horizontal categories, restaurant cards, popular food grid items, and order listings for smooth perceived loading performance.
- **Glassmorphic Floating Pill Toasts (`AppSnackbar`)**: Universal notification system built on `BackdropFilter` 18px blur, translucent frosted backgrounds, SF glowing status glyphs, and targeted haptic feedback (`mediumImpact`, `heavyImpact`, `selectionClick`).
- **Animated Vector & Lottie Micro-Interactions**: Custom vector animations for order success checkmarks, moving delivery motorbikes, simmering cooking pots, and bouncing empty carts.
- **Design Token System**: Complete centralization in `AppColors`, `AppDimens` (spacings `space2`-`space48`, radii `radius6`-`radiusFull`), `AppDurations`, and `AppCurves`—strictly 0 hardcoded design values.
- **Zero Errors / Robust Unit Tests**: Fully analyzed with `flutter analyze` (0 errors, 0 warnings) and automated test suite verifying validators, currency formatting, cart business logic, and widget rendering.

---

## 🏛 Architecture & Design Patterns

The codebase follows the **Feature-First Clean Architecture** approach recommended for enterprise Flutter applications:

```
lib/
├── core/                         # Enterprise shared cross-cutting layer
│   ├── constants/                # AppColors, AppStrings, AppConstants
│   ├── errors/                   # Failures & Exception definitions
│   ├── services/                 # GetStorage wrapper, MockDataService
│   ├── theme/                    # AppTheme (Light & Dark), Sen Typography
│   ├── utils/                    # CurrencyFormatter, Input Validators
│   └── widgets/                  # Reusable CustomButton, CustomAppBar, RatingBadge, etc.
│
├── features/                     # Feature-First Modular Structure
│   ├── auth/                     # Onboarding, Login, Signup, OTP, Forgot/Reset Password
│   ├── home/                     # Dashboard, Categories, Banners, Search, Offers
│   ├── restaurant/               # Menus, Dishes, Food Detail, Customization Sheet, Reviews
│   ├── cart_checkout/            # Cart, Checkout, Address Book, Cards, Order Confirmation
│   ├── orders_tracking/          # Live Canvas Map, Status Timeline, Driver Chat, VoIP Call
│   ├── profile/                  # Profile Bio, Notification Center, Settings, App States
│   ├── chef/                     # Kitchen Live Pipeline, Dish Manager, Revenue Analytics
│   ├── rider/                    # Courier Dispatch, Map Route Navigation, Cashout & Trips
│   └── catalog/                  # 52-Screen Visual Directory & Route Switcher
│
├── routes/                       # GetX Route Declarations & Lazy Bindings
│   ├── app_routes.dart           # Constants for all 52 routes
│   └── app_pages.dart            # GetPage route table with custom transitions
│
└── main.dart                     # Storage init, System UI lock, GetMaterialApp
```

### Clean Architecture Invariants Preserved:
1. **Domain Layer Independence**: Pure Dart code with zero UI or framework dependencies (`get`, `flutter/material.dart`).
2. **Repository Pattern**: Domain defines abstract interfaces; data layer fulfills them with clean API/local mock implementations.
3. **Dependency Inversion**: Dependencies are injected on demand using `Bindings` and `Get.lazyPut()`, avoiding memory leaks.

---

## 📱 52 Implemented Figma Screens Directory

| # | Screen Name | Route | Module | Description |
|---|---|---|---|---|
| **1** | Splash Screen | `/splash` | Auth | Brand animated entry splash |
| **2** | Onboarding Carousel | `/onboarding` | Auth | 3-step walkthrough with illustration slides |
| **3** | Login Screen | `/login` | Auth | Email, password & social credentials |
| **4** | Sign Up Screen | `/signup` | Auth | Registration with field validation |
| **5** | Verification (OTP) | `/verification` | Auth | 4-digit OTP code verification with countdown |
| **6** | Forgot Password | `/forgot-password` | Auth | Password reset recovery instructions |
| **7** | Reset Password | `/reset-password` | Auth | New password input & confirmation |
| **8** | Location Access | `/location-access` | Auth | GPS permission prompt & manual location picker |
| **9** | Main Navigation Shell | `/main-nav` | Discovery | Persistent bottom navigation (Home, Orders, Saved, Profile) |
| **10** | Home Dashboard | `/home` | Discovery | Category carousel, promo banners & top restaurants |
| **11** | Live Search Screen | `/search` | Discovery | Instant search filter with recent search history chips |
| **12** | Filter & Sort Sheet | `/filter` | Discovery | Price range slider, rating filters, dietary options |
| **13** | Special Offers & Deals | `/offers` | Discovery | Discount vouchers, promo codes & countdown sales |
| **14** | Restaurant Directory | `/restaurants` | Restaurant | Paginated restaurant list with delivery time tags |
| **15** | Restaurant Detail | `/restaurant-detail` | Restaurant | Hero cover, operational hours, rating badge & menu |
| **16** | Food Detail Screen | `/food-detail` | Restaurant | Dish nutritional stats, calories, addons & hero image |
| **17** | Food Customization Sheet | `/food-customization` | Restaurant | Size variation, extra toppings, spicy slider & instructions |
| **18** | Restaurant Customer Reviews | `/restaurant-reviews` | Restaurant | Verified feedback list with 5-star metric breakdown |
| **19** | Favorites / Saved Dishes | `/favorites` | Restaurant | Wishlisted foods & restaurants with instant reorder |
| **20** | Shopping Cart | `/cart` | Cart | Item quantity steppers, voucher box & price breakdown |
| **21** | Empty Cart State | `/cart-empty` | Cart | Friendly empty illustration with browse CTA |
| **22** | Checkout Summary | `/checkout` | Checkout | Address picker, payment preview & order placement |
| **23** | Saved Addresses | `/addresses` | Checkout | Multi-address ledger (Home, Work, Other) with radio select |
| **24** | Add / Edit Address | `/add-address` | Checkout | Apartment, street, building & delivery notes input |
| **25** | Payment Methods | `/payment-methods` | Checkout | Credit/debit cards, Apple Pay, PayPal & COD |
| **26** | Add Credit Card | `/add-card` | Checkout | Card visualizer, expiration date & CVV formatter |
| **27** | Order Success Confirmation | `/order-success` | Checkout | Celebratory confirmation with live tracking shortcut |
| **28** | Live GPS Order Tracking | `/order-tracking` | Tracking | Simulated map route with moving courier & live ETA |
| **29** | Order Timeline | `/order-timeline` | Tracking | Step-by-step progress checklist from kitchen to door |
| **30** | Courier Driver Chat | `/driver-chat` | Tracking | Instant 2-way messaging with quick suggestion chips |
| **31** | Driver Voice Call | `/voice-call` | Tracking | Simulated VoIP call interface with mute/speaker toggle |
| **32** | Rate & Review Order | `/rate-order` | Tracking | 5-star food & courier review with driver tip selection |
| **33** | My Orders (Active & Past) | `/my-orders` | Tracking | Dual-tab order ledger with receipt viewing & reordering |
| **34** | Order Receipt & Invoice | `/order-receipt` | Tracking | Line-item invoice, tax breakdown, and PDF export CTA |
| **35** | Empty Orders State | `/orders-empty` | Tracking | Zero orders illustration with CTA |
| **36** | User Profile | `/profile` | Profile | Bio, avatar, role-switching controls & menu shortcuts |
| **37** | Edit Profile | `/edit-profile` | Profile | Form for updating name, email, phone & avatar |
| **38** | Notification Center | `/notifications` | Profile | System notifications, delivery updates & unread badges |
| **39** | Application Settings | `/settings` | Profile | Theme toggle, push notifications, language & biometric |
| **40** | Help & Support | `/help-support` | Profile | FAQ accordions, customer service chat & phone lines |
| **41** | Network & Error States | `/system-states` | Profile | No internet connection and maintenance fallback views |
| **42** | Chef Kitchen Dashboard | `/chef-dashboard` | Chef | Kitchen KPI cards (orders, revenue, customer rating) |
| **43** | Chef Incoming Orders | `/chef-orders` | Chef | Real-time order pipeline (New, Cooking, Ready) |
| **44** | Chef Order Detail | `/chef-order-detail` | Chef | Line-item cooking checklist with timer countdown |
| **45** | Chef Menu Catalog | `/chef-menu` | Chef | Restaurant dish inventory with stock toggle switches |
| **46** | Chef Add New Dish | `/chef-add-dish` | Chef | Dish creation form (pricing, description, prep time) |
| **47** | Chef Revenue Analytics | `/chef-earnings` | Chef | Gross sales charts, commission rates & payout history |
| **48** | Rider Dispatch Feed | `/rider-orders` | Rider | Online/Offline toggle with nearby pickup request cards |
| **49** | Rider Turn-by-Turn Nav | `/rider-navigation` | Rider | Simulated canvas map route with pickup & drop-off steps |
| **50** | Rider Earnings Ledger | `/rider-earnings` | Rider | Weekly earnings bar chart, trip count & instant cashout |
| **51** | Rider Order Completion | `/rider-navigation` | Rider | Delivery swipe slider to complete trip and collect earnings |
| **52** | Master Screen Catalog | `/screen-catalog` | Catalog | Interactive directory linking all 52 Figma designs |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`v3.22.0` or higher)
- [Dart SDK](https://dart.dev/get-dart) (`v3.4.0` or higher)

### Installation & Execution

1. **Clone the repository:**
   ```bash
   git clone https://github.com/jihanurrahman33/Food-Delivery-App.git
   cd Food-Delivery-App
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run unit tests:**
   ```bash
   flutter test
   ```

4. **Verify static analysis:**
   ```bash
   flutter analyze
   ```

5. **Run the application:**
   ```bash
   # Run on connected iOS Simulator, Android Emulator, or Chrome
   flutter run
   ```

---

## 🎨 Design System & Color Palette

| Token | Hex | Preview | Purpose |
|---|---|---|---|
| `AppColors.primary` | `#FF7622` | 🟧 | Primary brand accent & call-to-actions |
| `AppColors.primaryLight` | `#FFFFECE5` | 🟨 | Selected chips, pill backgrounds |
| `AppColors.secondary` | `#181C2E` | ⬛ | Dark surfaces, contrast headers |
| `AppColors.backgroundLight` | `#F6F8FA` | ⬜ | Light scaffold background |
| `AppColors.backgroundDark` | `#121223` | ⬛ | Dark mode scaffold background |
| `AppColors.success` | `#10B981` | 🟩 | Active order status, earnings |
| `AppColors.error` | `#EF4444` | 🟥 | Destructive actions, validation errors |

---

## 🧪 Testing Coverage

The project includes unit tests for critical business and calculation logic:
- `CurrencyFormatter`: Verifies currency string formatting and reverse parsing.
- `Validators`: Validates email patterns, minimum password length requirements, and non-empty field inputs.
- `CartItemEntity`: Validates additive addon calculation and quantity subtotal multipliers.

Run tests at any time with:
```bash
flutter test
```

---

## 👨‍💻 Author & Contributions

- **Repository**: [github.com/jihanurrahman33/Food-Delivery-App](https://github.com/jihanurrahman33/Food-Delivery-App)
- **Author**: Jihanur Rahman
- **Email**: jihanurrahman33@gmail.com

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

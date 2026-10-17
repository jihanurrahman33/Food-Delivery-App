import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/mock_data_service.dart';
import 'app_routes.dart';

// Auth
import '../features/auth/presentation/bindings/auth_binding.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/auth/presentation/screens/verification_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/location_access_screen.dart';

// Home & Discovery
import '../features/home/presentation/bindings/home_binding.dart';
import '../features/home/presentation/screens/main_nav_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/search_screen.dart';
import '../features/home/presentation/screens/offers_screen.dart';

// Restaurant & Menu
import '../features/restaurant/domain/entities/restaurant_entity.dart';
import '../features/restaurant/presentation/bindings/restaurant_binding.dart';
import '../features/restaurant/presentation/screens/restaurant_list_screen.dart';
import '../features/restaurant/presentation/screens/restaurant_detail_screen.dart';
import '../features/restaurant/presentation/screens/restaurant_reviews_screen.dart';
import '../features/restaurant/presentation/screens/food_detail_screen.dart';
import '../features/restaurant/presentation/screens/food_customization_sheet.dart';
import '../features/restaurant/presentation/screens/filter_screen.dart';

// Cart & Checkout
import '../features/cart_checkout/presentation/bindings/cart_binding.dart';
import '../features/cart_checkout/presentation/controllers/cart_controller.dart';
import '../features/cart_checkout/presentation/screens/cart_screen.dart';
import '../features/cart_checkout/presentation/screens/empty_cart_screen.dart';
import '../features/cart_checkout/presentation/screens/checkout_screen.dart';
import '../features/cart_checkout/presentation/screens/address_list_screen.dart';
import '../features/cart_checkout/presentation/screens/add_edit_address_screen.dart';
import '../features/cart_checkout/presentation/screens/payment_methods_screen.dart';
import '../features/cart_checkout/presentation/screens/add_card_screen.dart';
import '../features/cart_checkout/presentation/screens/order_success_screen.dart';

// Order Tracking & Communication
import '../features/orders_tracking/presentation/bindings/order_binding.dart';
import '../features/orders_tracking/presentation/screens/live_tracking_screen.dart';
import '../features/orders_tracking/presentation/screens/order_timeline_screen.dart';
import '../features/orders_tracking/presentation/screens/driver_chat_screen.dart';
import '../features/orders_tracking/presentation/screens/voice_call_screen.dart';
import '../features/orders_tracking/presentation/screens/rate_order_screen.dart';
import '../features/orders_tracking/presentation/screens/my_orders_screen.dart';
import '../features/orders_tracking/presentation/screens/order_receipt_screen.dart';
import '../features/orders_tracking/presentation/screens/empty_orders_screen.dart';

// Profile & Preferences
import '../features/profile/presentation/bindings/profile_binding.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/notifications_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
import '../features/profile/presentation/screens/help_support_screen.dart';
import '../features/profile/presentation/screens/favorites_screen.dart';
import '../features/profile/presentation/screens/system_states_screen.dart';

// Chef Portal
import '../features/chef/presentation/bindings/chef_binding.dart';
import '../features/chef/presentation/screens/chef_dashboard_screen.dart';
import '../features/chef/presentation/screens/chef_orders_screen.dart';
import '../features/chef/presentation/screens/chef_order_detail_screen.dart';
import '../features/chef/presentation/screens/chef_menu_screen.dart';
import '../features/chef/presentation/screens/chef_add_dish_screen.dart';
import '../features/chef/presentation/screens/chef_earnings_screen.dart';

// Rider Portal
import '../features/rider/presentation/bindings/rider_binding.dart';
import '../features/rider/presentation/screens/rider_orders_screen.dart';
import '../features/rider/presentation/screens/rider_navigation_screen.dart';
import '../features/rider/presentation/screens/rider_earnings_screen.dart';

// Screen Catalog
import '../features/catalog/presentation/screens/screen_catalog_screen.dart';

class AppPages {
  AppPages._();

  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    // Auth & Onboarding
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => const VerificationScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.locationAccess,
      page: () => const LocationAccessScreen(),
      transition: Transition.fadeIn,
    ),

    // Main Navigation Shell & Home
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainNavScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.restaurants,
      page: () => const RestaurantListScreen(),
      binding: RestaurantBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.restaurantDetail,
      page: () => const RestaurantDetailScreen(),
      binding: RestaurantBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.restaurantReviews,
      page: () => const RestaurantReviewsScreen(),
      binding: RestaurantBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.foodDetail,
      page: () => const FoodDetailScreen(),
      binding: RestaurantBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.foodCustomization,
      page: () {
        final food = Get.arguments as FoodItemEntity? ?? MockDataService.foods.first;
        return Scaffold(
          appBar: AppBar(title: const Text('Customize Dish')),
          body: Center(
            child: FoodCustomizationSheet(
              food: food,
              onAddToCart: (quantity, addons, notes) {
                Get.find<CartController>().addItem(
                  foodItem: food,
                  quantity: quantity,
                  selectedAddons: addons,
                  specialInstructions: notes,
                );
                Get.back();
              },
            ),
          ),
        );
      },
      binding: RestaurantBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => const FilterScreen(),
      binding: RestaurantBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.offers,
      page: () => const OffersScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),

    // Cart & Checkout
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cartEmpty,
      page: () => const EmptyCartScreen(),
      binding: CartBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressListScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddEditAddressScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodsScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addCard,
      page: () => const AddCardScreen(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessScreen(),
      binding: CartBinding(),
      transition: Transition.zoom,
    ),

    // Order Tracking & Communication
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => const LiveTrackingScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderTimeline,
      page: () => const OrderTimelineScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.driverChat,
      page: () => const DriverChatScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.voiceCall,
      page: () => const VoiceCallScreen(),
      binding: OrderBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.rateOrder,
      page: () => const RateOrderScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myOrders,
      page: () => const MyOrdersScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderReceipt,
      page: () => const OrderReceiptScreen(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ordersEmpty,
      page: () => const EmptyOrdersScreen(),
      binding: OrderBinding(),
      transition: Transition.fadeIn,
    ),

    // Profile & Preferences
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.helpSupport,
      page: () => const HelpSupportScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.systemStates,
      page: () => const SystemStatesScreen(),
      transition: Transition.fadeIn,
    ),

    // Chef Portal
    GetPage(
      name: AppRoutes.chefDashboard,
      page: () => const ChefDashboardScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chefOrders,
      page: () => const ChefOrdersScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chefOrderDetail,
      page: () => const ChefOrderDetailScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chefMenu,
      page: () => const ChefMenuScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chefAddDish,
      page: () => const ChefAddDishScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chefEarnings,
      page: () => const ChefEarningsScreen(),
      binding: ChefBinding(),
      transition: Transition.rightToLeft,
    ),

    // Rider Portal
    GetPage(
      name: AppRoutes.riderOrders,
      page: () => const RiderOrdersScreen(),
      binding: RiderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.riderNavigation,
      page: () => const RiderNavigationScreen(),
      binding: RiderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.riderEarnings,
      page: () => const RiderEarningsScreen(),
      binding: RiderBinding(),
      transition: Transition.rightToLeft,
    ),

    // Screen Catalog
    GetPage(
      name: AppRoutes.screenCatalog,
      page: () => const ScreenCatalogScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}

class AppRoutes {
  AppRoutes._();

  // Auth & Onboarding
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String verification = '/verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String locationAccess = '/location-access';

  // Navigation Shell & Home
  static const String mainNav = '/main-nav';
  static const String home = '/home';
  static const String restaurants = '/restaurants';
  static const String restaurantDetail = '/restaurant-detail';
  static const String restaurantReviews = '/restaurant-reviews';
  static const String foodDetail = '/food-detail';
  static const String foodCustomization = '/food-customization';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String offers = '/offers';
  static const String favorites = '/favorites';

  // Cart & Checkout
  static const String cart = '/cart';
  static const String cartEmpty = '/cart-empty';
  static const String checkout = '/checkout';
  static const String addresses = '/addresses';
  static const String addAddress = '/add-address';
  static const String paymentMethods = '/payment-methods';
  static const String addCard = '/add-card';
  static const String orderSuccess = '/order-success';

  // Order Tracking, Chat & Call
  static const String orderTracking = '/order-tracking';
  static const String orderTimeline = '/order-timeline';
  static const String driverChat = '/driver-chat';
  static const String voiceCall = '/voice-call';
  static const String rateOrder = '/rate-order';
  static const String myOrders = '/my-orders';
  static const String orderReceipt = '/order-receipt';
  static const String ordersEmpty = '/orders-empty';

  // Profile, Settings, Notifications & States
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String helpSupport = '/help-support';
  static const String systemStates = '/system-states';

  // Chef / Restaurant Module
  static const String chefDashboard = '/chef-dashboard';
  static const String chefOrders = '/chef-orders';
  static const String chefOrderDetail = '/chef-order-detail';
  static const String chefMenu = '/chef-menu';
  static const String chefAddDish = '/chef-add-dish';
  static const String chefEarnings = '/chef-earnings';

  // Rider Module
  static const String riderOrders = '/rider-orders';
  static const String riderNavigation = '/rider-navigation';
  static const String riderEarnings = '/rider-earnings';

  // Interactive Screen Catalog
  static const String screenCatalog = '/screen-catalog';
}

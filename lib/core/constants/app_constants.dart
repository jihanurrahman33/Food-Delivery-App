class AppConstants {
  AppConstants._();

  // Backend API URL
  static const String apiBaseUrl = 'https://food-delivery-backend-wheat.vercel.app/api/v1';

  // Storage Keys
  static const String keyIsFirstTime = 'is_first_time';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserToken = 'user_token';
  static const String keyUserData = 'user_data';
  static const String keySavedAddresses = 'saved_addresses';
  static const String keyCartItems = 'cart_items';
  static const String keyFavorites = 'favorites';
  static const String keyIsDarkMode = 'is_dark_mode';
  static const String keyUserRole = 'user_role'; // customer, chef, rider

  // Default values
  static const double defaultDeliveryFee = 2.99;
  static const double defaultTaxRate = 0.08;
  static const double freeDeliveryThreshold = 35.00;

  // Animation durations
  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 350);
  static const Duration durationLong = Duration(milliseconds: 600);
}

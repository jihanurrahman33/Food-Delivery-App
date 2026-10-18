import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../routes/app_routes.dart';

class ScreenCatalogScreen extends StatefulWidget {
  const ScreenCatalogScreen({super.key});

  @override
  State<ScreenCatalogScreen> createState() => _ScreenCatalogScreenState();
}

class _ScreenCatalogScreenState extends State<ScreenCatalogScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _catalog = [
    // 1. Auth & Onboarding
    {
      'title': 'Splash Screen',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.splash,
      'icon': Icons.flash_on_rounded,
      'desc': 'Brand animated splash entrypoint',
    },
    {
      'title': 'Onboarding Screen',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.onboarding,
      'icon': Icons.view_carousel_rounded,
      'desc': '3-step walkthrough with illustration slides',
    },
    {
      'title': 'Login Screen',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.login,
      'icon': Icons.login_rounded,
      'desc': 'Social auth, email & password credentials',
    },
    {
      'title': 'Sign Up Screen',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.signup,
      'icon': Icons.person_add_rounded,
      'desc': 'New user registration with input validation',
    },
    {
      'title': 'Verification Screen (OTP)',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.verification,
      'icon': Icons.pin_rounded,
      'desc': '4-digit OTP code verification with resend timer',
    },
    {
      'title': 'Forgot Password',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.forgotPassword,
      'icon': Icons.lock_reset_rounded,
      'desc': 'Email link recovery workflow',
    },
    {
      'title': 'Reset Password',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.resetPassword,
      'icon': Icons.password_rounded,
      'desc': 'New password creation with confirmation',
    },
    {
      'title': 'Location Access Screen',
      'category': 'Auth & Onboarding',
      'route': AppRoutes.locationAccess,
      'icon': Icons.location_on_rounded,
      'desc': 'GPS permissions prompt with manual address option',
    },

    // 2. Home & Discovery
    {
      'title': 'Main Bottom Navigation',
      'category': 'Home & Discovery',
      'route': AppRoutes.mainNav,
      'icon': Icons.space_dashboard_rounded,
      'desc': 'Persistent 4-tab shell (Home, Orders, Favorites, Profile)',
    },
    {
      'title': 'Home Screen',
      'category': 'Home & Discovery',
      'route': AppRoutes.home,
      'icon': Icons.home_rounded,
      'desc': 'Categories, promotional banners & top restaurants',
    },
    {
      'title': 'Search Screen',
      'category': 'Home & Discovery',
      'route': AppRoutes.search,
      'icon': Icons.search_rounded,
      'desc': 'Live keyword filtering with search history pills',
    },
    {
      'title': 'Filter Screen',
      'category': 'Home & Discovery',
      'route': AppRoutes.filter,
      'icon': Icons.tune_rounded,
      'desc': 'Price range, dietary restrictions & rating filters',
    },
    {
      'title': 'Offers & Promos Screen',
      'category': 'Home & Discovery',
      'route': AppRoutes.offers,
      'icon': Icons.local_offer_rounded,
      'desc': 'Coupon codes, discounts and limited-time deals',
    },

    // 3. Restaurant & Menu
    {
      'title': 'All Restaurants Screen',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.restaurants,
      'icon': Icons.storefront_rounded,
      'desc': 'Paginated restaurant catalog with delivery filters',
    },
    {
      'title': 'Restaurant Detail Screen',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.restaurantDetail,
      'icon': Icons.restaurant_menu_rounded,
      'desc': 'Hero cover, menu tabs, ratings, and operating hours',
    },
    {
      'title': 'Food Detail Screen',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.foodDetail,
      'icon': Icons.fastfood_rounded,
      'desc': 'Dish specs, calories, ingredients, and addon builder',
    },
    {
      'title': 'Food Customization Sheet',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.foodCustomization,
      'icon': Icons.add_circle_outline_rounded,
      'desc': 'Size variations, sauce selection, and extra toppings',
    },
    {
      'title': 'Restaurant Reviews',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.restaurantReviews,
      'icon': Icons.rate_review_rounded,
      'desc': 'Verified customer feedback and star rating breakdown',
    },
    {
      'title': 'Favorites / Wishlist',
      'category': 'Restaurant & Menu',
      'route': AppRoutes.favorites,
      'icon': Icons.favorite_rounded,
      'desc': 'Bookmarked foods & restaurants with instant reorder',
    },

    // 4. Cart & Checkout
    {
      'title': 'Cart Screen',
      'category': 'Cart & Checkout',
      'route': AppRoutes.cart,
      'icon': Icons.shopping_bag_rounded,
      'desc': 'Order item editor, promo code input, and subtotal',
    },
    {
      'title': 'Empty Cart State',
      'category': 'Cart & Checkout',
      'route': AppRoutes.cartEmpty,
      'icon': Icons.remove_shopping_cart_rounded,
      'desc': 'Illustration & browse dishes action',
    },
    {
      'title': 'Checkout Screen',
      'category': 'Cart & Checkout',
      'route': AppRoutes.checkout,
      'icon': Icons.payment_rounded,
      'desc': 'Address, card, delivery notes & fee calculation',
    },
    {
      'title': 'Addresses Screen',
      'category': 'Cart & Checkout',
      'route': AppRoutes.addresses,
      'icon': Icons.location_city_rounded,
      'desc': 'Saved Home, Work, and Other delivery addresses',
    },
    {
      'title': 'Add / Edit Address',
      'category': 'Cart & Checkout',
      'route': AppRoutes.addAddress,
      'icon': Icons.edit_location_alt_rounded,
      'desc': 'Address form with label tags & apartment details',
    },
    {
      'title': 'Payment Methods',
      'category': 'Cart & Checkout',
      'route': AppRoutes.paymentMethods,
      'icon': Icons.credit_card_rounded,
      'desc': 'Credit cards, Apple Pay, PayPal, and Cash on Delivery',
    },
    {
      'title': 'Add Credit Card',
      'category': 'Cart & Checkout',
      'route': AppRoutes.addCard,
      'icon': Icons.add_card_rounded,
      'desc': 'Interactive card preview with CVV & expiry input',
    },
    {
      'title': 'Order Success Screen',
      'category': 'Cart & Checkout',
      'route': AppRoutes.orderSuccess,
      'icon': Icons.check_circle_rounded,
      'desc': 'Animated celebratory confirmation with receipt CTA',
    },

    // 5. Order Tracking & Communication
    {
      'title': 'Live Order Tracking',
      'category': 'Order Tracking',
      'route': AppRoutes.orderTracking,
      'icon': Icons.directions_bike_rounded,
      'desc': 'Simulated GPS map, moving rider marker & live ETA',
    },
    {
      'title': 'Order Timeline Screen',
      'category': 'Order Tracking',
      'route': AppRoutes.orderTimeline,
      'icon': Icons.timeline_rounded,
      'desc': 'Step-by-step order journey with time markers',
    },
    {
      'title': 'Driver & Courier Chat',
      'category': 'Order Tracking',
      'route': AppRoutes.driverChat,
      'icon': Icons.chat_rounded,
      'desc': 'Real-time messaging with quick delivery responses',
    },
    {
      'title': 'Voice Call Screen',
      'category': 'Order Tracking',
      'route': AppRoutes.voiceCall,
      'icon': Icons.phone_in_talk_rounded,
      'desc': 'Simulated VoIP call interface with mute/speaker controls',
    },
    {
      'title': 'Rate & Review Order',
      'category': 'Order Tracking',
      'route': AppRoutes.rateOrder,
      'icon': Icons.star_rounded,
      'desc': '5-star food & courier rating with tip selection',
    },
    {
      'title': 'My Orders Screen',
      'category': 'Order Tracking',
      'route': AppRoutes.myOrders,
      'icon': Icons.receipt_long_rounded,
      'desc': 'Active running orders & past order history tabs',
    },
    {
      'title': 'Order Receipt & Invoice',
      'category': 'Order Tracking',
      'route': AppRoutes.orderReceipt,
      'icon': Icons.receipt_rounded,
      'desc': 'Detailed tax breakdown, payment method & download invoice',
    },
    {
      'title': 'Empty Orders State',
      'category': 'Order Tracking',
      'route': AppRoutes.ordersEmpty,
      'icon': Icons.assignment_late_rounded,
      'desc': 'Zero orders state with primary call to action',
    },

    // 6. User Profile & Preferences
    {
      'title': 'Profile Screen',
      'category': 'Profile & Preferences',
      'route': AppRoutes.profile,
      'icon': Icons.person_rounded,
      'desc': 'User bio, avatar, role switches, and shortcuts',
    },
    {
      'title': 'Edit Profile Screen',
      'category': 'Profile & Preferences',
      'route': AppRoutes.editProfile,
      'icon': Icons.badge_rounded,
      'desc': 'Name, email, phone number, and avatar picker',
    },
    {
      'title': 'Notifications Screen',
      'category': 'Profile & Preferences',
      'route': AppRoutes.notifications,
      'icon': Icons.notifications_rounded,
      'desc': 'Promotional updates, status changes & unread badges',
    },
    {
      'title': 'Settings Screen',
      'category': 'Profile & Preferences',
      'route': AppRoutes.settings,
      'icon': Icons.settings_rounded,
      'desc': 'Theme toggle, push alerts, language, and security',
    },
    {
      'title': 'Help & Support Screen',
      'category': 'Profile & Preferences',
      'route': AppRoutes.helpSupport,
      'icon': Icons.help_outline_rounded,
      'desc': 'FAQ accordion, live customer chat & ticket submission',
    },
    {
      'title': 'System & Error States',
      'category': 'Profile & Preferences',
      'route': AppRoutes.systemStates,
      'icon': Icons.signal_wifi_off_rounded,
      'desc': 'No internet connection, 404 page & server maintenance',
    },

    // 7. Chef & Kitchen Operations
    {
      'title': 'Chef Kitchen Dashboard',
      'category': 'Chef Portal',
      'route': AppRoutes.chefDashboard,
      'icon': Icons.kitchen_rounded,
      'desc': 'Kitchen live order volume, revenue & rating KPI cards',
    },
    {
      'title': 'Chef Orders Screen',
      'category': 'Chef Portal',
      'route': AppRoutes.chefOrders,
      'icon': Icons.soup_kitchen_rounded,
      'desc': 'Incoming order tickets, cooking pipeline & ready queue',
    },
    {
      'title': 'Chef Order Detail',
      'category': 'Chef Portal',
      'route': AppRoutes.chefOrderDetail,
      'icon': Icons.assignment_turned_in_rounded,
      'desc': 'Line item cooking checklist with time remaining timer',
    },
    {
      'title': 'Chef Menu & Dishes',
      'category': 'Chef Portal',
      'route': AppRoutes.chefMenu,
      'icon': Icons.menu_book_rounded,
      'desc': 'Active dish catalog with stock availability switches',
    },
    {
      'title': 'Chef Add New Dish',
      'category': 'Chef Portal',
      'route': AppRoutes.chefAddDish,
      'icon': Icons.post_add_rounded,
      'desc': 'Dish creation form with price, ingredients & category',
    },
    {
      'title': 'Chef Earnings & Analytics',
      'category': 'Chef Portal',
      'route': AppRoutes.chefEarnings,
      'icon': Icons.monetization_on_rounded,
      'desc': 'Gross revenue chart, payouts, and commission breakdown',
    },

    // 8. Rider & Courier Logistics
    {
      'title': 'Rider Orders & Dispatch',
      'category': 'Rider Portal',
      'route': AppRoutes.riderOrders,
      'icon': Icons.two_wheeler_rounded,
      'desc': 'Online/Offline toggle, nearby dispatch orders & acceptance',
    },
    {
      'title': 'Rider Turn-by-Turn Nav',
      'category': 'Rider Portal',
      'route': AppRoutes.riderNavigation,
      'icon': Icons.navigation_rounded,
      'desc': 'Interactive route map with pickup/dropoff status workflow',
    },
    {
      'title': 'Rider Earnings & Trips',
      'category': 'Rider Portal',
      'route': AppRoutes.riderEarnings,
      'icon': Icons.account_balance_wallet_rounded,
      'desc': 'Weekly bar chart, instant cashout, and trip ledger',
    },

    // 9. Master Catalog Self-reference
    {
      'title': 'Master Screen Catalog',
      'category': 'Catalog & Index',
      'route': AppRoutes.screenCatalog,
      'icon': Icons.grid_view_rounded,
      'desc': 'Complete interactive directory of all 52 Figma screens',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = ['All', 'Auth & Onboarding', 'Home & Discovery', 'Restaurant & Menu', 'Cart & Checkout', 'Order Tracking', 'Profile & Preferences', 'Chef Portal', 'Rider Portal'];

    final filteredList = _catalog.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item['category'] == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          (item['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (item['desc'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              '52 Figma Screens Catalog',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${_catalog.length} UI Screens Implemented',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () {
              Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search screens (e.g. tracking, cart, chef)...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () => setState(() => _searchQuery = ''),
                          )
                        : null,
                    filled: true,
                    fillColor: isDark ? AppColors.darkSurface : Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, idx) {
                      final cat = categories[idx];
                      final isSelected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.darkSurface : Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Screen List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 60, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        const Text('No screens match your search'),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: isDark ? AppColors.darkCard : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(item['icon'] as IconData, color: AppColors.primary, size: 24),
                          ),
                          title: Text(
                            '${index + 1}. ${item['title']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(
                                item['desc'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkSurface : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item['category'] as String,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                          onTap: () {
                            final route = item['route'] as String;
                            if (route == AppRoutes.screenCatalog) {
                              AppSnackbar.info('Already here', 'You are currently on the Screen Catalog!');
                            } else {
                              Get.toNamed(route);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  ),
          ),
        ],
      ),
    );
  }
}

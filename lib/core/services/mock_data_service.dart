import '../../features/auth/data/models/user_model.dart';
import '../../features/cart_checkout/domain/entities/address_entity.dart';
import '../../features/cart_checkout/domain/entities/cart_item_entity.dart';
import '../../features/cart_checkout/domain/entities/payment_card_entity.dart';
import '../../features/home/data/models/banner_model.dart';
import '../../features/home/data/models/category_model.dart';
import '../../features/orders_tracking/domain/entities/order_entity.dart';
import '../../features/restaurant/data/models/restaurant_model.dart';
import '../../features/restaurant/domain/entities/restaurant_entity.dart';

class MockDataService {
  MockDataService._();

  // Current User
  static UserModel defaultUser = const UserModel(
    id: 'usr_001',
    name: 'Jihanur Rahman',
    email: 'jihanurrahman33@gmail.com',
    phone: '+1 (555) 234-5678',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=80',
    role: 'customer',
    address: '76A Eighth Avenue, New York, NY 10011',
  );

  // Categories
  static List<CategoryModel> categories = const [
    CategoryModel(
      id: 'cat_all',
      name: 'All',
      icon: '🍽️',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200',
    ),
    CategoryModel(
      id: 'cat_burger',
      name: 'Burger',
      icon: '🍔',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
    ),
    CategoryModel(
      id: 'cat_pizza',
      name: 'Pizza',
      icon: '🍕',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200',
    ),
    CategoryModel(
      id: 'cat_asian',
      name: 'Asian',
      icon: '🍜',
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=200',
    ),
    CategoryModel(
      id: 'cat_mexican',
      name: 'Mexican',
      icon: '🌮',
      imageUrl: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=200',
    ),
    CategoryModel(
      id: 'cat_dessert',
      name: 'Dessert',
      icon: '🍰',
      imageUrl: 'https://images.unsplash.com/photo-1587314168485-3236d6710814?w=200',
    ),
    CategoryModel(
      id: 'cat_drinks',
      name: 'Drinks',
      icon: '🥤',
      imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=200',
    ),
  ];

  // Banners
  static List<BannerModel> banners = const [
    BannerModel(
      id: 'ban_1',
      title: 'Get Special Discount',
      subtitle: 'Up to 40% OFF on gourmet burgers',
      discountText: '40% OFF',
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&auto=format&fit=crop&q=80',
    ),
    BannerModel(
      id: 'ban_2',
      title: 'Free Delivery Weekend',
      subtitle: 'Enjoy free delivery for orders above \$25',
      discountText: 'FREE DELIVERY',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&auto=format&fit=crop&q=80',
    ),
    BannerModel(
      id: 'ban_3',
      title: 'Fresh Artisan Pizzas',
      subtitle: 'Handcrafted with organic ingredients',
      discountText: 'BUY 1 GET 1',
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&auto=format&fit=crop&q=80',
    ),
  ];

  // Common Addons
  static const List<FoodAddon> burgerAddons = [
    FoodAddon(id: 'add_1', name: 'Extra Cheddar Cheese', price: 1.50),
    FoodAddon(id: 'add_2', name: 'Crispy Smoked Bacon', price: 2.25),
    FoodAddon(id: 'add_3', name: 'Caramelized Onions', price: 0.95),
    FoodAddon(id: 'add_4', name: 'Spicy Jalapeno Peppers', price: 0.75),
    FoodAddon(id: 'add_5', name: 'Truffle Mayo Dip', price: 1.25),
  ];

  static const List<FoodAddon> pizzaAddons = [
    FoodAddon(id: 'add_6', name: 'Stuffed Garlic Crust', price: 2.50),
    FoodAddon(id: 'add_7', name: 'Extra Mozzarella', price: 1.95),
    FoodAddon(id: 'add_8', name: 'Mushrooms & Olives', price: 1.20),
    FoodAddon(id: 'add_9', name: 'Pepperoni Slices', price: 2.00),
  ];

  // Restaurants
  static List<RestaurantModel> restaurants = const [
    RestaurantModel(
      id: 'rest_1',
      name: 'Rose Garden Bakehouse',
      imageUrl:
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&auto=format&fit=crop&q=80',
      logoUrl:
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=150&auto=format&fit=crop&q=80',
      rating: 4.8,
      ratingCount: 382,
      deliveryTime: '20-25 min',
      deliveryFee: 2.50,
      distanceKm: 1.8,
      address: '42 Baker Street, West End',
      tags: ['Burger', 'American', 'Sandwiches'],
      isOpen: true,
      isFeatured: true,
      isFavorite: true,
    ),
    RestaurantModel(
      id: 'rest_2',
      name: 'Piazza Bella Napoli',
      imageUrl:
          'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?w=800&auto=format&fit=crop&q=80',
      logoUrl:
          'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?w=150&auto=format&fit=crop&q=80',
      rating: 4.9,
      ratingCount: 520,
      deliveryTime: '25-30 min',
      deliveryFee: 0.00,
      distanceKm: 2.4,
      address: '15 Little Italy Blvd, Downtown',
      tags: ['Pizza', 'Italian', 'Pasta'],
      isOpen: true,
      isFeatured: true,
      isFavorite: false,
    ),
    RestaurantModel(
      id: 'rest_3',
      name: 'Tokyo Ramen & Sushi Bar',
      imageUrl:
          'https://images.unsplash.com/photo-1552611052-33e04de081de?w=800&auto=format&fit=crop&q=80',
      logoUrl:
          'https://images.unsplash.com/photo-1552611052-33e04de081de?w=150&auto=format&fit=crop&q=80',
      rating: 4.7,
      ratingCount: 290,
      deliveryTime: '15-20 min',
      deliveryFee: 1.99,
      distanceKm: 1.2,
      address: '88 Sakura Way, Midtown',
      tags: ['Asian', 'Ramen', 'Japanese'],
      isOpen: true,
      isFeatured: false,
      isFavorite: true,
    ),
    RestaurantModel(
      id: 'rest_4',
      name: 'El Fuego Cantina',
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=80',
      logoUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=150&auto=format&fit=crop&q=80',
      rating: 4.6,
      ratingCount: 215,
      deliveryTime: '30-35 min',
      deliveryFee: 3.00,
      distanceKm: 3.5,
      address: '124 Sonora Plaza, South Bay',
      tags: ['Mexican', 'Tacos', 'Burritos'],
      isOpen: true,
      isFeatured: false,
      isFavorite: false,
    ),
  ];

  // Food Items
  static List<FoodItemModel> foods = const [
    FoodItemModel(
      id: 'food_1',
      restaurantId: 'rest_1',
      restaurantName: 'Rose Garden Bakehouse',
      name: 'Classic Smash Cheeseburger',
      description:
          'Juicy double smashed angus beef patties, melted aged cheddar, secret house aioli, caramelized onions, and crisp dill pickles on toasted brioche.',
      price: 9.99,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=80',
      rating: 4.9,
      ratingCount: 142,
      categoryId: 'cat_burger',
      calories: 620,
      prepTimeMinutes: 15,
      isPopular: true,
      isSpicy: false,
      isVegetarian: false,
      availableAddons: burgerAddons,
    ),
    FoodItemModel(
      id: 'food_2',
      restaurantId: 'rest_1',
      restaurantName: 'Rose Garden Bakehouse',
      name: 'Spicy Crispy Chicken Deluxe',
      description:
          'Golden crispy buttermilk chicken breast coated in Nashville hot spices, sweet pickled slaw, and chipotle mayo.',
      price: 11.50,
      imageUrl:
          'https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=600&auto=format&fit=crop&q=80',
      rating: 4.8,
      ratingCount: 98,
      categoryId: 'cat_burger',
      calories: 580,
      prepTimeMinutes: 18,
      isPopular: true,
      isSpicy: true,
      isVegetarian: false,
      availableAddons: burgerAddons,
    ),
    FoodItemModel(
      id: 'food_3',
      restaurantId: 'rest_2',
      restaurantName: 'Piazza Bella Napoli',
      name: 'Woodfired Margherita DOC',
      description:
          'San Marzano tomato sauce, fresh buffalo mozzarella, fragrant Genovese basil, and extra virgin olive oil.',
      price: 14.25,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&auto=format&fit=crop&q=80',
      rating: 4.9,
      ratingCount: 210,
      categoryId: 'cat_pizza',
      calories: 780,
      prepTimeMinutes: 20,
      isPopular: true,
      isSpicy: false,
      isVegetarian: true,
      availableAddons: pizzaAddons,
    ),
    FoodItemModel(
      id: 'food_4',
      restaurantId: 'rest_2',
      restaurantName: 'Piazza Bella Napoli',
      name: 'Diavola Pepperoni Crunch',
      description:
          'Zesty pepperoni slices, spicy calabrian chilis, crushed tomatoes, and smoked provolone cheese on blistered sourdough.',
      price: 16.50,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=600&auto=format&fit=crop&q=80',
      rating: 4.7,
      ratingCount: 165,
      categoryId: 'cat_pizza',
      calories: 840,
      prepTimeMinutes: 20,
      isPopular: false,
      isSpicy: true,
      isVegetarian: false,
      availableAddons: pizzaAddons,
    ),
    FoodItemModel(
      id: 'food_5',
      restaurantId: 'rest_3',
      restaurantName: 'Tokyo Ramen & Sushi Bar',
      name: 'Rich Tonkotsu Black Garlic Ramen',
      description:
          'Slow simmered 16-hour pork bone broth, springy ramen noodles, tender chashu pork belly, ajitsuke tamago egg, and fragrant black garlic oil.',
      price: 15.00,
      imageUrl:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&auto=format&fit=crop&q=80',
      rating: 4.9,
      ratingCount: 320,
      categoryId: 'cat_asian',
      calories: 650,
      prepTimeMinutes: 12,
      isPopular: true,
      isSpicy: false,
      isVegetarian: false,
    ),
    FoodItemModel(
      id: 'food_6',
      restaurantId: 'rest_4',
      restaurantName: 'El Fuego Cantina',
      name: 'Birria Beef Tacos Trio',
      description:
          'Three slow-braised beef birria tacos with melted cheese, diced onions, cilantro, and warm rich consommé for dipping.',
      price: 13.50,
      imageUrl:
          'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=600&auto=format&fit=crop&q=80',
      rating: 4.8,
      ratingCount: 180,
      categoryId: 'cat_mexican',
      calories: 710,
      prepTimeMinutes: 15,
      isPopular: true,
      isSpicy: true,
      isVegetarian: false,
    ),
  ];

  // Saved Addresses
  static List<AddressEntity> addresses = const [
    AddressEntity(
      id: 'addr_1',
      label: 'Home',
      fullAddress: '76A Eighth Avenue, New York, NY 10011',
      street: '76A Eighth Avenue',
      apartment: 'Apt 4B',
      deliveryNotes: 'Leave in lobby by door phone',
      isDefault: true,
    ),
    AddressEntity(
      id: 'addr_2',
      label: 'Office',
      fullAddress: '450 Lexington Ave, New York, NY 10017',
      street: '450 Lexington Ave',
      apartment: 'Floor 12, Tech Hub',
      deliveryNotes: 'Call upon arrival',
      isDefault: false,
    ),
    AddressEntity(
      id: 'addr_3',
      label: 'Parents',
      fullAddress: '128 Queens Blvd, Forest Hills, NY 11375',
      street: '128 Queens Blvd',
      apartment: 'House #3',
      deliveryNotes: 'Ring bell twice',
      isDefault: false,
    ),
  ];

  // Saved Payment Cards
  static List<PaymentCardEntity> paymentCards = const [
    PaymentCardEntity(
      id: 'card_1',
      cardHolderName: 'Jihanur Rahman',
      cardNumber: '•••• •••• •••• 4242',
      expiryDate: '08/28',
      brand: 'Visa',
      isDefault: true,
    ),
    PaymentCardEntity(
      id: 'card_2',
      cardHolderName: 'Jihanur Rahman',
      cardNumber: '•••• •••• •••• 8821',
      expiryDate: '11/27',
      brand: 'Mastercard',
      isDefault: false,
    ),
  ];

  // Delivery Rider
  static const DeliveryRiderEntity defaultRider = DeliveryRiderEntity(
    id: 'rider_01',
    name: 'Robert Fox',
    phone: '+1 (555) 789-0123',
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
    rating: 4.9,
    vehicleType: 'Vespa Sprint 150',
    licensePlate: 'NYC-5491',
  );

  // Active Order
  static OrderEntity activeOrder = OrderEntity(
    id: 'FD-98421',
    restaurantId: 'rest_1',
    restaurantName: 'Rose Garden Bakehouse',
    restaurantImageUrl:
        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
    items: [
      CartItemEntity(
        id: 'ci_1',
        foodItem: foods[0],
        quantity: 2,
        selectedAddons: const [
          FoodAddon(id: 'add_1', name: 'Extra Cheddar Cheese', price: 1.50),
        ],
      ),
      CartItemEntity(
        id: 'ci_2',
        foodItem: foods[1],
        quantity: 1,
      ),
    ],
    subtotal: 32.98,
    deliveryFee: 2.50,
    tax: 2.64,
    discount: 5.00,
    total: 33.12,
    status: OrderStatus.onTheWay,
    createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
    deliveryAddress: '76A Eighth Avenue, New York, NY 10011',
    paymentMethod: 'Visa •••• 4242',
    rider: defaultRider,
    estimatedDeliveryMinutes: 12,
  );

  // Initial Chat Messages with driver
  static List<ChatMessageEntity> initialChatMessages = [
    ChatMessageEntity(
      id: 'msg_1',
      text: 'Hello! I have picked up your order from Rose Garden Bakehouse.',
      isSender: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    ChatMessageEntity(
      id: 'msg_2',
      text: 'Great, thanks! Please leave it with the front desk if needed.',
      isSender: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
    ),
    ChatMessageEntity(
      id: 'msg_3',
      text: 'Sure thing, I will be there in about 10 minutes!',
      isSender: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
  ];
}

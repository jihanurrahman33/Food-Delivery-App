import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/core/utils/currency_formatter.dart';
import 'package:food_delivery_app/core/utils/validators.dart';
import 'package:food_delivery_app/core/widgets/app_shimmer.dart';
import 'package:food_delivery_app/core/widgets/bouncing_button.dart';
import 'package:food_delivery_app/features/cart_checkout/domain/entities/cart_item_entity.dart';
import 'package:food_delivery_app/features/restaurant/domain/entities/restaurant_entity.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('formats standard dollar amount correctly', () {
      expect(CurrencyFormatter.format(14.5), '\$14.50');
      expect(CurrencyFormatter.format(0), '\$0.00');
      expect(CurrencyFormatter.format(129.99), '\$129.99');
    });

    test('parses currency string back to double', () {
      expect(CurrencyFormatter.parse('\$14.50'), 14.50);
      expect(CurrencyFormatter.parse('99.90'), 99.90);
    });
  });

  group('Validators Tests', () {
    test('email validator flags invalid and accepts valid email', () {
      expect(Validators.validateEmail(''), 'Email is required');
      expect(Validators.validateEmail('invalid-email'), 'Please enter a valid email address');
      expect(Validators.validateEmail('user@test.com'), isNull);
    });

    test('password validator enforces length', () {
      expect(Validators.validatePassword(''), 'Password is required');
      expect(Validators.validatePassword('12345'), 'Password must be at least 6 characters');
      expect(Validators.validatePassword('secure123'), isNull);
    });

    test('required field validator works', () {
      expect(Validators.validateRequired('', 'Name'), 'Name is required');
      expect(Validators.validateRequired('John Doe', 'Name'), isNull);
    });
  });

  group('CartItemEntity Tests', () {
    test('calculates item total price including addons and quantity', () {
      const food = FoodItemEntity(
        id: '1',
        restaurantId: 'rest_1',
        restaurantName: 'Rose Garden Bakehouse',
        name: 'Cheeseburger',
        description: 'Juicy beef burger',
        price: 9.99,
        imageUrl: 'https://example.com/burger.jpg',
        rating: 4.8,
        ratingCount: 120,
        categoryId: 'cat_burger',
        calories: 650,
      );

      const addon = FoodAddon(
        id: 'addon_1',
        name: 'Extra Cheese',
        price: 1.50,
      );

      final cartItem = CartItemEntity(
        id: 'ci_test_1',
        foodItem: food,
        quantity: 2,
        selectedAddons: const [addon],
      );

      // (9.99 + 1.50) * 2 = 11.49 * 2 = 22.98
      expect(cartItem.totalPrice, closeTo(22.98, 0.001));
    });
  });

  group('Apple Micro-Interactions & Shimmer Tests', () {
    testWidgets('BouncingButton renders and responds to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BouncingButton(
              onTap: () => tapped = true,
              child: const Text('Apple Button'),
            ),
          ),
        ),
      );

      expect(find.text('Apple Button'), findsOneWidget);
      await tester.tap(find.text('Apple Button'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('AppShimmer renders shimmer container without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppShimmer(
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      expect(find.byType(AppShimmer), findsOneWidget);
    });
  });
}

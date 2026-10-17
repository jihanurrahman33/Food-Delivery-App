import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/services/mock_data_service.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../routes/app_routes.dart';
import '../../../orders_tracking/domain/entities/order_entity.dart';
import '../../../orders_tracking/domain/repositories/order_repository.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/payment_card_entity.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  final OrderRepository orderRepository;
  final CartController cartController;

  CheckoutController({
    required this.orderRepository,
    required this.cartController,
  });

  final RxList<AddressEntity> addresses = <AddressEntity>[].obs;
  final Rx<AddressEntity?> selectedAddress = Rx<AddressEntity?>(null);

  final RxList<PaymentCardEntity> paymentCards = <PaymentCardEntity>[].obs;
  final Rx<PaymentCardEntity?> selectedPaymentCard = Rx<PaymentCardEntity?>(null);

  final RxString selectedPaymentMethodType = 'card'.obs; // card, paypal, cash, applepay
  final RxBool isDeliverNow = true.obs;
  final RxString scheduledTime = 'Today, 7:30 PM'.obs;
  final RxBool isPlacingOrder = false.obs;

  final driverNotesController = TextEditingController();

  // New card form controllers
  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardCvvController = TextEditingController();

  // New address form controllers
  final addressLabelController = TextEditingController(text: 'Home');
  final addressStreetController = TextEditingController();
  final addressApartmentController = TextEditingController();
  final addressNotesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    addresses.assignAll(MockDataService.addresses);
    if (addresses.isNotEmpty) {
      selectedAddress.value =
          addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first);
    }

    paymentCards.assignAll(MockDataService.paymentCards);
    if (paymentCards.isNotEmpty) {
      selectedPaymentCard.value = paymentCards
          .firstWhere((c) => c.isDefault, orElse: () => paymentCards.first);
    }
  }

  void selectAddress(AddressEntity address) {
    selectedAddress.value = address;
  }

  void selectPaymentMethod(String type) {
    selectedPaymentMethodType.value = type;
  }

  void selectPaymentCard(PaymentCardEntity card) {
    selectedPaymentCard.value = card;
    selectedPaymentMethodType.value = 'card';
  }

  void addAddress() {
    final street = addressStreetController.text.trim();
    if (street.isEmpty) {
      AppSnackbar.warning('Required', 'Street address is required');
      return;
    }

    final newAddr = AddressEntity(
      id: const Uuid().v4(),
      label: addressLabelController.text.trim().isEmpty
          ? 'Other'
          : addressLabelController.text.trim(),
      fullAddress: '$street, ${addressApartmentController.text.trim()}',
      street: street,
      apartment: addressApartmentController.text.trim(),
      deliveryNotes: addressNotesController.text.trim(),
      isDefault: addresses.isEmpty,
    );

    addresses.add(newAddr);
    selectedAddress.value = newAddr;

    // Reset controllers
    addressStreetController.clear();
    addressApartmentController.clear();
    addressNotesController.clear();

    Get.back();
    AppSnackbar.success('Address Saved', 'New delivery address added successfully');
  }

  void addPaymentCard() {
    final holder = cardHolderNameController.text.trim();
    final number = cardNumberController.text.trim();
    final expiry = cardExpiryController.text.trim();

    if (holder.isEmpty || number.isEmpty || expiry.isEmpty) {
      AppSnackbar.warning('Required', 'Please fill in all card details');
      return;
    }

    final masked = number.length >= 4
        ? '•••• •••• •••• ${number.substring(number.length - 4)}'
        : '•••• •••• •••• 4242';

    final brand = number.startsWith('4') ? 'Visa' : 'Mastercard';

    final newCard = PaymentCardEntity(
      id: const Uuid().v4(),
      cardHolderName: holder,
      cardNumber: masked,
      expiryDate: expiry,
      brand: brand,
      isDefault: paymentCards.isEmpty,
    );

    paymentCards.add(newCard);
    selectedPaymentCard.value = newCard;
    selectedPaymentMethodType.value = 'card';

    // Reset
    cardHolderNameController.clear();
    cardNumberController.clear();
    cardExpiryController.clear();
    cardCvvController.clear();

    Get.back();
    AppSnackbar.success('Card Added', 'Payment card added successfully');
  }

  Future<void> placeOrder() async {
    if (cartController.items.isEmpty) {
      AppSnackbar.warning('Cart Empty', 'Your cart is empty');
      return;
    }

    if (selectedAddress.value == null) {
      AppSnackbar.warning('Address Required', 'Please select a delivery address');
      return;
    }

    try {
      isPlacingOrder.value = true;

      final newOrder = OrderEntity(
        id: 'FD-${(10000 + DateTime.now().millisecond * 89).toString()}',
        restaurantId: cartController.currentRestaurantId.value.isEmpty
            ? 'rest_1'
            : cartController.currentRestaurantId.value,
        restaurantName: cartController.currentRestaurantName.value.isEmpty
            ? 'Rose Garden Bakehouse'
            : cartController.currentRestaurantName.value,
        restaurantImageUrl:
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
        items: List.from(cartController.items),
        subtotal: cartController.subtotal,
        deliveryFee: cartController.deliveryFee,
        tax: cartController.tax,
        discount: cartController.discountAmount,
        total: cartController.total,
        status: OrderStatus.confirmed,
        createdAt: DateTime.now(),
        deliveryAddress: selectedAddress.value!.fullAddress,
        paymentMethod: selectedPaymentMethodType.value == 'card' &&
                selectedPaymentCard.value != null
            ? '${selectedPaymentCard.value!.brand} ${selectedPaymentCard.value!.cardNumber}'
            : (selectedPaymentMethodType.value == 'paypal'
                ? 'PayPal'
                : (selectedPaymentMethodType.value == 'applepay'
                    ? 'Apple Pay'
                    : 'Cash on Delivery')),
        rider: MockDataService.defaultRider,
        estimatedDeliveryMinutes: 25,
      );

      final created = await orderRepository.placeOrder(newOrder);

      // Clear cart
      cartController.clearCart();

      // Navigate to success screen
      Get.offNamed(AppRoutes.orderSuccess, arguments: created);
    } catch (e) {
      AppSnackbar.error('Order Failed', 'Could not place order: ${e.toString()}');
    } finally {
      isPlacingOrder.value = false;
    }
  }
}

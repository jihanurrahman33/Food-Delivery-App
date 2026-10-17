import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';

class RiderController extends GetxController {
  final RxBool isOnline = true.obs;
  final RxDouble todayEarnings = 128.50.obs;
  final RxInt todayTrips = 14.obs;
  final RxDouble riderRating = 4.92.obs;

  // Available deliveries waiting for pickup
  final RxList<Map<String, dynamic>> availableDeliveries = <Map<String, dynamic>>[
    {
      'id': 'DEL-441',
      'restaurantName': 'Piazza Bella Napoli',
      'pickupAddress': '15 Little Italy Blvd, Downtown',
      'deliveryAddress': '220 Central Park South, Apt 8A',
      'distance': '2.1 km',
      'payout': 9.50,
      'itemsCount': 2,
    },
    {
      'id': 'DEL-442',
      'restaurantName': 'Tokyo Ramen Bar',
      'pickupAddress': '88 Sakura Way, Midtown',
      'deliveryAddress': '54 West 55th St',
      'distance': '1.4 km',
      'payout': 7.25,
      'itemsCount': 3,
    },
  ].obs;

  // Active accepted delivery
  final Rx<Map<String, dynamic>?> activeDelivery = Rx<Map<String, dynamic>?>(null);
  final RxString deliveryStep = 'Heading to Restaurant'.obs; // 'Heading to Restaurant', 'Picked Up', 'Delivered'

  void toggleOnlineStatus(bool value) {
    isOnline.value = value;
    if (value) {
      AppSnackbar.success('Rider Status', 'You are now ONLINE and ready for requests');
    } else {
      AppSnackbar.info('Rider Status', 'You are now OFFLINE');
    }
  }

  void acceptDelivery(Map<String, dynamic> delivery) {
    activeDelivery.value = delivery;
    availableDeliveries.remove(delivery);
    deliveryStep.value = 'Heading to Restaurant';
    AppSnackbar.info('Trip Accepted', 'Navigate to ${delivery['restaurantName']} for pickup.');
  }

  void confirmPickup() {
    deliveryStep.value = 'Picked Up';
    AppSnackbar.info('Order Picked Up', 'Head over to customer destination.');
  }

  void completeDelivery() {
    if (activeDelivery.value != null) {
      final payout = (activeDelivery.value!['payout'] as num).toDouble();
      todayEarnings.value += payout;
      todayTrips.value += 1;
      activeDelivery.value = null;
      deliveryStep.value = 'Heading to Restaurant';
      AppSnackbar.success('Delivery Complete! 🎉', 'You earned \$${payout.toStringAsFixed(2)}');
    }
  }
}

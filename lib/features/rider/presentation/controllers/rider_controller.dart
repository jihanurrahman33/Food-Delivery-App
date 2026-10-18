import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/app_snackbar.dart';

class RiderController extends GetxController {
  final RxBool isOnline = true.obs;
  final RxDouble todayEarnings = 128.50.obs;
  final RxInt todayTrips = 14.obs;
  final RxDouble riderRating = 4.92.obs;

  // Available deliveries waiting for pickup
  final RxList<Map<String, dynamic>> availableDeliveries = <Map<String, dynamic>>[].obs;

  // Active accepted delivery
  final Rx<Map<String, dynamic>?> activeDelivery = Rx<Map<String, dynamic>?>(null);
  final RxString deliveryStep = 'Heading to Restaurant'.obs; // 'Heading to Restaurant', 'Picked Up', 'Delivered'

  ApiClient get apiClient => Get.find<ApiClient>();

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      final res = await apiClient.get('/rider/dashboard');
      if (res is Map<String, dynamic>) {
        isOnline.value = res['isOnline'] ?? true;
        todayEarnings.value = (res['todayEarnings'] as num?)?.toDouble() ?? 128.50;
        todayTrips.value = (res['todayTrips'] as num?)?.toInt() ?? 14;
        riderRating.value = (res['riderRating'] as num?)?.toDouble() ?? 4.92;

        final rawAvailable = res['availableDeliveries'] as List<dynamic>? ?? [];
        if (rawAvailable.isNotEmpty) {
          final mapped = rawAvailable.map((d) {
            final map = d as Map<String, dynamic>;
            return {
              'id': map['id'],
              'restaurantName': map['restaurantName'] ?? 'Bakehouse',
              'pickupAddress': '42 Baker Street, West End',
              'deliveryAddress': map['deliveryAddress'] ?? 'Downtown',
              'distance': '2.1 km',
              'payout': 9.50,
              'itemsCount': (map['items'] as List<dynamic>? ?? []).length,
            };
          }).toList();
          availableDeliveries.assignAll(mapped);
        }

        if (res['activeDelivery'] != null && res['activeDelivery'] is Map<String, dynamic>) {
          final map = res['activeDelivery'] as Map<String, dynamic>;
          activeDelivery.value = {
            'id': map['id'],
            'restaurantName': map['restaurantName'] ?? 'Bakehouse',
            'pickupAddress': '42 Baker Street, West End',
            'deliveryAddress': map['deliveryAddress'] ?? 'Downtown',
            'distance': '1.8 km',
            'payout': 9.50,
            'itemsCount': (map['items'] as List<dynamic>? ?? []).length,
          };
        }
      }
    } catch (_) {}

    if (availableDeliveries.isEmpty) {
      availableDeliveries.assignAll([
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
      ]);
    }
  }

  Future<void> toggleOnlineStatus(bool value) async {
    isOnline.value = value;
    try {
      await apiClient.post('/rider/online/toggle', body: {'isOnline': value});
    } catch (_) {}

    if (value) {
      AppSnackbar.success('Rider Status', 'You are now ONLINE and ready for requests');
    } else {
      AppSnackbar.info('Rider Status', 'You are now OFFLINE');
    }
  }

  Future<void> acceptDelivery(Map<String, dynamic> delivery) async {
    activeDelivery.value = delivery;
    availableDeliveries.remove(delivery);
    deliveryStep.value = 'Heading to Restaurant';

    final orderId = delivery['id'] as String?;
    if (orderId != null) {
      try {
        await apiClient.put('/rider/deliveries/$orderId/accept');
      } catch (_) {}
    }

    AppSnackbar.info('Trip Accepted', 'Navigate to ${delivery['restaurantName']} for pickup.');
  }

  Future<void> confirmPickup() async {
    deliveryStep.value = 'Picked Up';
    final orderId = activeDelivery.value?['id'] as String?;
    if (orderId != null) {
      try {
        await apiClient.put('/rider/deliveries/$orderId/status', body: {'status': 'onTheWay'});
      } catch (_) {}
    }
    AppSnackbar.info('Order Picked Up', 'Head over to customer destination.');
  }

  Future<void> completeDelivery() async {
    if (activeDelivery.value != null) {
      final orderId = activeDelivery.value!['id'] as String?;
      if (orderId != null) {
        try {
          await apiClient.put('/rider/deliveries/$orderId/status', body: {'status': 'delivered'});
        } catch (_) {}
      }

      final payout = (activeDelivery.value!['payout'] as num).toDouble();
      todayEarnings.value += payout;
      todayTrips.value += 1;
      activeDelivery.value = null;
      deliveryStep.value = 'Heading to Restaurant';
      AppSnackbar.success('Delivery Complete! 🎉', 'You earned \$${payout.toStringAsFixed(2)}');
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepository orderRepository;

  OrderController({required this.orderRepository});

  final RxList<OrderEntity> activeOrders = <OrderEntity>[].obs;
  final RxList<OrderEntity> orderHistory = <OrderEntity>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      isLoading.value = true;
      final active = await orderRepository.getActiveOrders();
      final history = await orderRepository.getOrderHistory();
      activeOrders.assignAll(active);
      orderHistory.assignAll(history);
    } catch (_) {
      // Gracefully handle unauthenticated or offline initial load
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    await orderRepository.cancelOrder(orderId);
    await loadOrders();
    AppSnackbar.warning('Order Cancelled', 'Your order #$orderId has been cancelled');
  }
}

class OrderTrackingController extends GetxController {
  final OrderRepository orderRepository;

  OrderTrackingController({required this.orderRepository});

  final Rx<OrderEntity?> currentOrder = Rx<OrderEntity?>(null);
  final RxDouble riderProgress = 0.65.obs; // 0.0 to 1.0
  final RxInt remainingMinutes = 12.obs;
  Timer? _progressTimer;

  // Live Chat
  final RxList<ChatMessageEntity> chatMessages = <ChatMessageEntity>[].obs;
  final chatTextController = TextEditingController();

  // Voice Call
  final RxBool isCallActive = false.obs;
  final RxBool isMuted = false.obs;
  final RxBool isSpeakerOn = false.obs;
  final RxInt callSeconds = 0.obs;
  Timer? _callTimer;

  // Rating & Review
  final RxDouble restaurantRating = 5.0.obs;
  final RxDouble riderRating = 5.0.obs;
  final RxList<String> selectedReviewTags = <String>[].obs;
  final reviewCommentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is OrderEntity) {
      currentOrder.value = args;
    }
    _startSimulatedTracking();
    _loadChatMessages();
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    _callTimer?.cancel();
    super.onClose();
  }

  void _startSimulatedTracking() {
    _progressTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (riderProgress.value < 0.95) {
        riderProgress.value += 0.05;
        if (remainingMinutes.value > 1) {
          remainingMinutes.value--;
        }
      }
    });
  }

  Future<void> _loadChatMessages() async {
    final orderId = currentOrder.value?.id ?? 'FD-98421';
    final msgs = await orderRepository.getChatMessages(orderId);
    chatMessages.assignAll(msgs);
  }

  Future<void> sendMessage([String? prefillText]) async {
    final text = prefillText ?? chatTextController.text.trim();
    if (text.isEmpty) return;

    final orderId = currentOrder.value?.id ?? 'FD-98421';
    await orderRepository.sendChatMessage(orderId, text);
    chatTextController.clear();
    await _loadChatMessages();

    // Re-fetch after short delay to capture simulated rider reply
    Future.delayed(const Duration(milliseconds: 1600), () {
      _loadChatMessages();
    });
  }

  void startVoiceCall() {
    isCallActive.value = true;
    callSeconds.value = 0;
    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callSeconds.value++;
    });
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
  }

  void toggleSpeaker() {
    isSpeakerOn.value = !isSpeakerOn.value;
  }

  void endVoiceCall() {
    _callTimer?.cancel();
    isCallActive.value = false;
    Get.back();
  }

  void toggleReviewTag(String tag) {
    if (selectedReviewTags.contains(tag)) {
      selectedReviewTags.remove(tag);
    } else {
      selectedReviewTags.add(tag);
    }
  }

  Future<void> submitReview() async {
    final orderId = currentOrder.value?.id ?? 'FD-98421';
    await orderRepository.submitOrderReview(
      orderId,
      restaurantRating.value,
      riderRating.value,
      reviewCommentController.text.trim(),
    );
    AppSnackbar.success(
      'Thank you!',
      'Your review has been successfully submitted.',
    );
    Get.back();
  }
}

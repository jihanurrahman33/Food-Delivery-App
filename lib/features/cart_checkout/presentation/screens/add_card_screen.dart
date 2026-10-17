import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/checkout_controller.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String _cardNumber = '•••• •••• •••• ••••';
  String _cardHolder = 'CARDHOLDER NAME';
  String _cardExpiry = 'MM/YY';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(title: 'Add New Card'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Interactive Card Preview
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E2337), Color(0xFF121223)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.contactless_rounded,
                                    color: Colors.white70, size: 28),
                                Text(
                                  _cardNumber.startsWith('4') ? 'VISA' : 'Mastercard',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _cardNumber,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'CARD HOLDER',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 9,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _cardHolder.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'EXPIRES',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 9,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _cardExpiry,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Cardholder Name Input
                      CustomTextField(
                        label: 'CARD HOLDER NAME',
                        hintText: 'John Doe',
                        controller: controller.cardHolderNameController,
                        onChanged: (val) {
                          setState(() {
                            _cardHolder = val.isEmpty ? 'CARDHOLDER NAME' : val;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      // Card Number Input
                      CustomTextField(
                        label: 'CARD NUMBER',
                        hintText: '4242 4242 4242 4242',
                        keyboardType: TextInputType.number,
                        controller: controller.cardNumberController,
                        prefixIcon: const Icon(Icons.credit_card_rounded,
                            color: AppColors.primary),
                        onChanged: (val) {
                          setState(() {
                            _cardNumber =
                                val.isEmpty ? '•••• •••• •••• ••••' : val;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      // Row for Expiry & CVV
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'EXPIRE DATE',
                              hintText: 'MM/YY',
                              keyboardType: TextInputType.datetime,
                              controller: controller.cardExpiryController,
                              onChanged: (val) {
                                setState(() {
                                  _cardExpiry = val.isEmpty ? 'MM/YY' : val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: 'CVV',
                              hintText: '•••',
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              controller: controller.cardCvvController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Save button
              CustomButton(
                text: 'SAVE & CONTINUE',
                onPressed: controller.addPaymentCard,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

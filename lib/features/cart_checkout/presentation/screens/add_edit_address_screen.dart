import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/checkout_controller.dart';

class AddEditAddressScreen extends GetView<CheckoutController> {
  const AddEditAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: const CustomAppBar(title: 'Add New Address'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Label chips
                      Text(
                        'LABEL AS',
                        style: AppTextStyles.caption().copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: ['Home', 'Work', 'Other'].map((lbl) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ChoiceChip(
                              label: Text(lbl),
                              selected: controller.addressLabelController.text == lbl,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: controller.addressLabelController.text == lbl
                                    ? Colors.white
                                    : (isDark ? Colors.white : Colors.black87),
                              ),
                              onSelected: (_) {
                                controller.addressLabelController.text = lbl;
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Street Address
                      CustomTextField(
                        label: 'STREET ADDRESS',
                        hintText: 'e.g. 124 Grand Avenue',
                        controller: controller.addressStreetController,
                        prefixIcon: const Icon(Icons.location_on_outlined,
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 18),

                      // Apartment / Unit
                      CustomTextField(
                        label: 'APARTMENT / SUITE / FLOOR',
                        hintText: 'e.g. Apt 4B, Floor 2',
                        controller: controller.addressApartmentController,
                        prefixIcon: const Icon(Icons.business_outlined,
                            color: AppColors.primary),
                      ),
                      const SizedBox(height: 18),

                      // Delivery Instructions
                      CustomTextField(
                        label: 'DELIVERY INSTRUCTIONS',
                        hintText: 'e.g. Leave with doorman or ring twice',
                        controller: controller.addressNotesController,
                        maxLines: 2,
                        prefixIcon: const Icon(Icons.note_alt_outlined,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),

              // Save button
              CustomButton(
                text: 'SAVE ADDRESS',
                onPressed: controller.addAddress,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

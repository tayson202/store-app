import 'dart:io';
import 'package:demo_app/controllers/product.dart';
import 'package:demo_app/features/reels/presentation/controllers/reel_upload_controller.dart';
import 'package:demo_app/features/seller/controllers/seller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ReelUploadScreen extends StatefulWidget {
  const ReelUploadScreen({super.key});

  @override
  State<ReelUploadScreen> createState() => _ReelUploadScreenState();
}

class _ReelUploadScreenState extends State<ReelUploadScreen> {
  final controller = Get.find<ReelUploadController>();
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _previewCtrl;

  // Form Field Controllers
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _oldPriceCtrl = TextEditingController();

  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    // Sync UI controllers to Rx state initially
    _titleCtrl.text = controller.productTitle.value;
    _descCtrl.text = controller.description.value;
    _priceCtrl.text = controller.price.value;
    _oldPriceCtrl.text = controller.oldPrice.value;
  }

  @override
  void dispose() {
    _previewCtrl?.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _oldPriceCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );
    if (file != null) {
      controller.setVideoPath(file.path);
      _previewCtrl?.dispose();
      _previewCtrl = VideoPlayerController.file(File(file.path))
        ..initialize().then((_) {
          setState(() {});
          _previewCtrl?.play();
          _previewCtrl?.setLooping(true);
        });
      controller.nextStep();
    }
  }

  void _onProductSelected(Product? product) {
    setState(() {
      _selectedProduct = product;
      if (product != null) {
        _titleCtrl.text = product.name;
        _descCtrl.text = product.description;
        _priceCtrl.text = product.price.toString();
        _oldPriceCtrl.text = product.oldprice?.toString() ?? '';

        controller.productTitle.value = product.name;
        controller.description.value = product.description;
        controller.price.value = product.price.toString();
        controller.oldPrice.value = product.oldprice?.toString() ?? '';
        controller.category.value = product.category;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF13131A) : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0.5,
        title: Text(
          'Upload Showcase',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isUploading.value) {
          return _buildUploadingState(context);
        }

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Theme.of(context).primaryColor,
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: controller.currentStep.value,
            onStepCancel: () {
              if (controller.currentStep.value > 0) {
                controller.prevStep();
              }
            },
            onStepContinue: () {
              if (controller.currentStep.value == 0 && controller.videoPath.isEmpty) {
                Get.snackbar('Video Required', 'Please select a showcase video to continue.');
                return;
              }
              if (controller.currentStep.value == 1 && !controller.isFormValid) {
                Get.snackbar('Missing Details', 'Please fill in product title, description, and price.');
                return;
              }
              if (controller.currentStep.value < 2) {
                controller.nextStep();
              } else {
                // Publish
                controller.uploadVideo(
                  'seller_test_id',
                  'ElectroShop Official',
                  'ElectroShop',
                );
              }
            },
            steps: [
              _buildStepVideoSelect(isDark),
              _buildStepProductInfo(isDark),
              _buildStepPreviewPublish(isDark),
            ],
          ),
        );
      }),
    );
  }

  Step _buildStepVideoSelect(bool isDark) {
    return Step(
      title: const Text('Video'),
      isActive: controller.currentStep.value >= 0,
      state: controller.currentStep.value > 0 ? StepState.complete : StepState.editing,
      content: Column(
        children: [
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _pickVideo,
            child: Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.black12,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'Upload Product Video',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Maximum duration: 60 seconds',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Step _buildStepProductInfo(bool isDark) {
    final sellerCtrl = Get.find<SellerController>();

    return Step(
      title: const Text('Details'),
      isActive: controller.currentStep.value >= 1,
      state: controller.currentStep.value > 1 ? StepState.complete : StepState.editing,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Existing Product Link Dropdown
            if (sellerCtrl.myProducts.isNotEmpty) ...[
              const Text(
                'Link to Existing Product (Optional)',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Product>(
                    value: _selectedProduct,
                    hint: const Text('Select a product to link details'),
                    dropdownColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<Product>(
                        value: null,
                        child: Text('-- Create New Product --'),
                      ),
                      ...sellerCtrl.myProducts.map((p) => DropdownMenuItem(value: p, child: Text(p.name))),
                    ],
                    onChanged: _onProductSelected,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            _buildTextField(
              label: 'Product Title *',
              hint: 'e.g. Wireless Noise-Cancelling Headphones',
              controller: _titleCtrl,
              onChanged: (val) => controller.productTitle.value = val,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Short Description *',
              hint: 'Describe your product features...',
              maxLines: 3,
              controller: _descCtrl,
              onChanged: (val) => controller.description.value = val,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: r'Price ($) *',
                    hint: '89.99',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceCtrl,
                    onChanged: (val) => controller.price.value = val,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    label: 'Old Price (Optional)',
                    hint: '129.99',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _oldPriceCtrl,
                    onChanged: (val) => controller.oldPrice.value = val,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Category Dropdown
            _buildCategoryDropdown(isDark),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Step _buildStepPreviewPublish(bool isDark) {
    final hasDiscount = controller.oldPrice.isNotEmpty;

    return Step(
      title: const Text('Publish'),
      isActive: controller.currentStep.value >= 2,
      state: StepState.editing,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Confirm Details & Publish',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Product preview row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video preview Thumbnail box
              Container(
                width: 90,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: _previewCtrl != null && _previewCtrl!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _previewCtrl!.value.aspectRatio,
                        child: VideoPlayer(_previewCtrl!),
                      )
                    : const Center(
                        child: Icon(Icons.videocam, color: Colors.white54),
                      ),
              ),
              const SizedBox(width: 16),
              // Info summary
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.productTitle.value,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.description.value,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${controller.price.value}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\$${controller.oldPrice.value}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        controller.category.value,
                        style: const TextStyle(fontSize: 11),
                      ),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    required TextEditingController controller,
    required Function(String) onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Category *',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.category.value,
              dropdownColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              isExpanded: true,
              items: ['creatine', 'protine', 'pants', 'accessories', 'vitamins']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  controller.category.value = val;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadingState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(strokeWidth: 3),
            const SizedBox(height: 24),
            const Text(
              'Uploading Product Showcase...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This may take a moment depending on file size.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: controller.uploadProgress.value,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:demo_app/controllers/authcontroller.dart';
import 'package:demo_app/view/signin.dart';
import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentpage = 0;

  final List<Onboardingitem> _item = [
    Onboardingitem(
      desc: 'explore the purest supplements',
      title: 'discover your future',
      image: 'image', // Replace with actual asset path
    ),
    Onboardingitem(
      desc: 'shop premium quality products from all brands worldwide',
      title: 'quality products',
      image: 'image',
    ),
    Onboardingitem(
      desc: 'simple and secure shopping experience',
      title: 'easy fast',
      image: 'image',
    ),
  ];

  void _handlegetstarted() {
    final Authcontroller authcontroller = Get.find<Authcontroller>();
    authcontroller.setFirstTimeDone();
    Get.off(() => Signin());
  }

  @override
  Widget build(BuildContext context) {
    final isdark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _item.length,
            onPageChanged: (index) {
              setState(() {
                _currentpage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _item[index].image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 40),

                  Text(
                    _item[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.withColor(
                      AppTextStyles.h1,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _item[index].desc,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodylarge,
                        isdark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          /// PAGE INDICATOR
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _item.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentpage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentpage == index
                        ? Theme.of(context).primaryColor
                        : (isdark ? Colors.grey[700] : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          /// BUTTONS
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _handlegetstarted,
                  child: Text(
                    'skip',
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      isdark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ),

                /// NEXT / GET STARTED BUTTON
                ElevatedButton(
                  onPressed: () {
                    if (_currentpage < _item.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handlegetstarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentpage < _item.length - 1 ? 'next' : "get started",
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonmid,
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Onboardingitem {
  final String image;
  final String title;
  final String desc;

  Onboardingitem({
    required this.desc,
    required this.title,
    required this.image,
  });
}

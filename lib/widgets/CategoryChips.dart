import 'package:demo_app/widgets/textstyle.dart';
import 'package:flutter/material.dart';

class Categorychips extends StatefulWidget {
  const Categorychips({super.key});

  @override
  State<Categorychips> createState() => _CategorychipsState();
}

class _CategorychipsState extends State<Categorychips> {
  int selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Supplements',
    'Brands',
    'Trainers',
    'Physiotherapists',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ChoiceChip(
                label: Text(
                  categories[index],
                  style: selectedIndex == index
                      ? AppTextStyles.withweight(
                          AppTextStyles.bodysmall,
                          FontWeight.w600,
                        ).copyWith(color: Colors.white)
                      : AppTextStyles.bodysmall.copyWith(
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                        ),
                ),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    selectedIndex = selected ? index : selectedIndex;
                  });
                },
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: selectedIndex == index ? 2 : 0,
                pressElevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 1,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: BorderSide(
                  color: selectedIndex == index
                      ? Colors.transparent
                      : isDark
                      ? Colors.grey[700]!
                      : Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

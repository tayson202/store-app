import 'package:flutter/material.dart';

class Sizeselector extends StatefulWidget {
  const Sizeselector({super.key});

  @override
  State<Sizeselector> createState() => _SizeselectorState();
}

class _SizeselectorState extends State<Sizeselector> {
  int selectedsize = 0;
  final sizes = ['s', 'm', 'l', 'xl'];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        sizes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(sizes[index]),
            selected: selectedsize == index,
            onSelected: (bool selected) {
              setState(() {
                selectedsize = selected ? index : selectedsize;
              });
            },
            selectedColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(
              color: selectedsize == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

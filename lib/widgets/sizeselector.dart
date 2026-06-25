import 'package:flutter/material.dart';

class Sizeselector extends StatefulWidget {
  final ValueChanged<String> onSizeSelected;
  final String initialSize;
  const Sizeselector({super.key, required this.onSizeSelected, this.initialSize = 'm'});

  @override
  State<Sizeselector> createState() => _SizeselectorState();
}

class _SizeselectorState extends State<Sizeselector> {
  late int selectedsize;
  final sizes = ['s', 'm', 'l', 'xl'];

  @override
  void initState() {
    super.initState();
    selectedsize = sizes.indexOf(widget.initialSize.toLowerCase());
    if (selectedsize == -1) selectedsize = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        sizes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(sizes[index].toUpperCase()),
            selected: selectedsize == index,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  selectedsize = index;
                });
                widget.onSizeSelected(sizes[index].toUpperCase());
              }
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

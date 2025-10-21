import 'package:demo_app/widgets/custom_button.dart';
import 'package:demo_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});
  static String id = 'update product';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update page', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hintText: 'product name'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'description'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'price'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'image'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'category'),
            SizedBox(height: 50),
            CustomButton(text: 'update'),
          ],
        ),
      ),
    );
  }
}

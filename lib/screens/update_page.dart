import 'package:demo_app/widgets/custom_button.dart';
import 'package:demo_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});
  static String id = 'update product';
  String? productname, description, image, category;
  int? price;
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
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                onChanged: (data) {
                  productname = data;
                },
                hintText: 'product name',
              ),
              SizedBox(height: 10),
              CustomTextField(
                onChanged: (data) {
                  description = data;
                },
                hintText: 'description',
              ),
              SizedBox(height: 10),
              CustomTextField(
                inputType: TextInputType.number,
                onChanged: (data) {
                  price = int.parse(data);
                },
                hintText: 'price',
              ),
              SizedBox(height: 10),
              CustomTextField(
                onChanged: (data) {
                  image = data;
                },
                hintText: 'image',
              ),
              SizedBox(height: 10),
              CustomTextField(
                onChanged: (data) {
                  category = data;
                },
                hintText: 'category',
              ),
              SizedBox(height: 50),
              CustomButton(text: 'update'),
            ],
          ),
        ),
      ),
    );
  }
}

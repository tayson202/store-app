import 'package:demo_app/widgets/custom_button.dart';
import 'package:demo_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});
  static String id = 'update product';

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String? productname, description, image, category;

  String? price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    /*ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;*/ //typeerror
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                SizedBox(height: 100),
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
                    price = data;
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
                CustomButton(
                  text: 'Update',
                  onTap: () async {
                    setState(() {
                      //isLoading = true;
                    });
                  },
                  /*isLoading = true;
                    setState(() {});
                    try {
                      updateproduct();
                      print('success');
                    } catch (e) {
                      print(e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  },*/
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void updateproduct() {
    UpdateproductService().updateProduct(
      title: productname!,
      prices: price!,
      desc: description!,
      image: image!,
      category: category!,
    );
  }*/
}

import 'dart:io';

import 'package:flojics_assignment/core/themes/app_colors.dart';
import 'package:flojics_assignment/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flojics_assignment/src/presentation/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final picker = ImagePicker();

  File? productImage;
  File get getProductImage => productImage!;

  Future pickerProductImage(BuildContext context, ImageSource source) async {
    final pickedProductImage = await picker.pickImage(source: source);
    pickedProductImage == null
        ? print('select Image')
        : productImage = File(pickedProductImage.path);
    print(productImage!.path);

    productImage != null
        ? showProductImage(context)
        : print('Image upload error');
  }

  Future selectImageOperation(BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: AppLightColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  thickness: 4,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              BouncingButton(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                onPress: () {
                  pickerProductImage(context, ImageSource.gallery).whenComplete(
                    () {
                      Navigator.pop(context);
                      showProductImage(context);
                    },
                  );
                },
                child: const Text(
                  'Select From Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BouncingButton(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                onPress: () {
                  pickerProductImage(context, ImageSource.camera).whenComplete(
                    () {
                      Navigator.pop(context);
                      showProductImage(context);
                    },
                  );
                },
                child: const Text(
                  'Select From Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showProductImage(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppLightColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  thickness: 4,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Image.file(
                  productImage!,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: BouncingButton(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      onPress: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Reselect',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: BouncingButton(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      onPress: () {
                        ManageProductsCubit.get(context)
                            .saveImage(productImage!);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:model_home_app/constant/app_color.dart';
import 'package:model_home_app/utilies/loading_utilies.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? isloading;

  const CustomButton({
       this.isloading=false,
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.8,  
      height: screenHeight * 0.07, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.zero, 
        ),
        child:isloading==true?
        LoadingUtil.buttonLoading():
         Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.textcolor,
            ),
          ),
        ),
      ),
    );
  }
}

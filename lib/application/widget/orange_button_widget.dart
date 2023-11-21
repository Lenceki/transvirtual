import 'package:flutter/material.dart';

class OrangeButtonWidget extends StatelessWidget {
  Widget? prefixWidget;
  Widget? suffixWidget;
  Widget tittleWidget;
  double cornerRadius;
  final void Function() onTap;

  OrangeButtonWidget({super.key, required this.tittleWidget, required this.onTap, this.suffixWidget, this.prefixWidget, this.cornerRadius = 18});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double marginPreFix = prefixWidget == null ? 0 : 30;
    double marginSuffix = suffixWidget == null ? 0 : 30;
    return ElevatedButton(
      key: key,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(cornerRadius)
              )
          )
      ),
      onPressed: () {
        onTap();
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            prefixWidget ?? Container(),
            SizedBox(width: marginPreFix),
            tittleWidget,
            SizedBox(width: marginSuffix),
            suffixWidget ?? Container(),
          ]),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:tisha_app/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Color? textColor;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final Function()? onPressed;
  final double? buttonPadding;
  final double? fontSize;
  final bool borderSide;
  final Color? borderColor;
  final MaterialStateProperty<OutlinedBorder?>? buttonShape;

  const CustomButton({
    super.key,
    this.label,
    this.onPressed,
    this.textColor,
    this.buttonColor,
    this.fontWeight,
    this.buttonPadding,
    this.buttonShape,
    this.fontSize,
    this.borderSide = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              side: borderSide
                  ? MaterialStatePropertyAll(
                      BorderSide(
                        color: borderColor ?? Colors.white,
                        width: 2.0,
                      ),
                    )
                  : null,
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(
                  buttonPadding ?? 15.0,
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                  buttonColor ?? CustomColors.kPrimaryColor),
              shape: buttonShape ??
                  MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
            ),
            child: label != null
                ? Text(
                    label!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: fontSize,
                          color: textColor ?? CustomColors.kWhiteTextColor,
                          fontWeight: fontWeight ?? FontWeight.bold,
                        ),
                  )
                : SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: CustomColors.kWhiteTextColor,
                      strokeWidth: 2.5,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}

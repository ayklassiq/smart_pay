import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../helpers/colors.dart';
import '../helpers/size_calculator.dart';


class PinTextInput extends StatelessWidget {
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final TextEditingController pinEditingController;
  const PinTextInput(
      {Key? key,
      required this.onChanged,
      this.onSaved,
      required this.pinEditingController, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .77,
      child: PinInputTextFormField(

        pinLength: 5,
        decoration: BoxLooseDecoration(
          strokeWidth: 1.2,
            strokeColorBuilder:
                PinListenColorBuilder(AppColors.blueColor10, AppColors.greyField),
            bgColorBuilder:
                PinListenColorBuilder(AppColors.greyField, AppColors.greyField),
            obscureStyle: ObscureStyle(
              isTextObscure: false,
              // obscureText: '-',ac
            ),
            // hintText: '****',
            hintTextStyle: TextStyle(
              color: AppColors.black,
              fontSize: sizer(true, 13, context),
              fontWeight: FontWeight.w500,
            ),
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: sizer(true, 24, context),
              fontWeight: FontWeight.w600,
            )),
        controller: pinEditingController,
        textInputAction: TextInputAction.go,
        enabled: true,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        cursor: Cursor(
          width: 2,
          color: AppColors.blueColor,
          radius: const Radius.circular(1),
          enabled: true,
        ),
      ),
    );
  }
}

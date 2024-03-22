import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../helpers/colors.dart';
import '../../helpers/size_calculator.dart';

class FullButton extends StatefulWidget {
  final Function? buttonFunction;
  final String? buttonText;
  final bool online, isTextSmall, isloading;
  final bool isIcon;
  final String? iconAsset;
  final Color? buttonOnlineColor, onlineTextColor;

  const FullButton(
      {Key? key,
      required this.buttonFunction,
      this.buttonText,
      this.isloading = false,
      this.online = true,
      this.buttonOnlineColor,
      this.onlineTextColor,
      this.isIcon = false,
      this.iconAsset,
      this.isTextSmall = false})
      : super(key: key);

  @override
  _FullButtonState createState() => _FullButtonState();
}

class _FullButtonState extends State<FullButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: widget.online
              ? widget.buttonFunction != null
                  ? () {
                      HapticFeedback.lightImpact();
                      widget.buttonFunction!();
                    }
                  : () {
                      HapticFeedback.lightImpact();
                    }
              : null,
          child: Container(
            height: sizer(false, 56, context),
            margin: const EdgeInsets.symmetric(vertical: 0.0),
            decoration: BoxDecoration(
                color: widget.online
                    ? (widget.buttonOnlineColor ?? AppColors.primary)
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(16)),
            child: Center(
                child: widget.isloading == true
                    ? CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                      )
                    : Text(widget.buttonText ?? '',
                        style: TextStyle(
                            color: widget.online
                                ? (widget.onlineTextColor ?? Colors.white)
                                : AppColors.whiteColor,
                            fontSize: widget.isTextSmall == true
                                ? sizer(true, 14, context)
                                : sizer(true, 16, context),
                            fontWeight: FontWeight.w700))),
          ),
        ));
  }
}

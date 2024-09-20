import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/utils/constants.dart';

class CustomOutlineButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final Color? textColor;
  final Color? borderColor;
  final Color? hoverColor;
  final double height;

  const CustomOutlineButton({
    super.key,
    this.width,
    this.textColor = kWhiteColor,
    this.borderColor = kWhiteColor,
    this.hoverColor = kGreen,
    this.height = 52,
    required this.text,
    required this.onTap,
  });

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  double _animatedWidth = 0.0;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
          _animatedWidth = widget.width ?? 177.w;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
          _animatedWidth = 0.0;
        });
      },
      child: Stack(
        children: [
          Container(
            height: widget.height.h,
            width: (widget.width ?? 177).w,
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor!),
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.height.h,
            width: _animatedWidth.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: widget.hoverColor,
            ),
          ),
          InkWell(
            onTap: widget.onTap,
            child: SizedBox(
              height: widget.height.h,
              width: (widget.width ?? 177).w,
              child: Center(
                child: Text(
                  widget.text.toUpperCase(),
                  style: TextStyle(
                    color: isHover ? widget.textColor : widget.textColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

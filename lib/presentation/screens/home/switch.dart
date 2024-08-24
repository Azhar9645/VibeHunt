import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:vibehunt/utils/constants.dart';

class AdvanceSwitchFlutter extends StatefulWidget {
  final double radius;
  final double thumbRadius;
  final Widget? activeChild;
  final Widget? inactiveChild;
  final Widget? thirdChild;

  const AdvanceSwitchFlutter({
    super.key,
    required this.radius,
    required this.thumbRadius,
    this.activeChild,
    this.inactiveChild,
    this.thirdChild,
  });

  @override
  State<AdvanceSwitchFlutter> createState() => _AdvanceSwitchFlutterState();
}

class _AdvanceSwitchFlutterState extends State<AdvanceSwitchFlutter> {
  final _controller00 = ValueNotifier<bool>(false);
  bool _isThirdState = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller00.value) {
          _controller00.value = false;
          _isThirdState = true;
        } else if (_isThirdState) {
          _isThirdState = false;
          _controller00.value = true;
        } else {
          _controller00.value = true;
        }
      },
      child: AdvancedSwitch(
        activeColor: kGreen,
        inactiveColor: const Color(0xFF292929),
        activeChild: const SizedBox(),
        inactiveChild: const SizedBox(),
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        width: 70,
        height: 40,
        thumb: Container(
          margin: const EdgeInsets.all(5),
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.thumbRadius)),
          child: ValueListenableBuilder<bool>(
            valueListenable: _controller00,
            builder: (_, value, __) {
              if (_isThirdState) {
                return widget.thirdChild ?? const SizedBox();
              }
              return value ? widget.activeChild! : widget.inactiveChild!;
            },
          ),
        ),
        controller: _controller00,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:vibehunt/utils/constants.dart'; // Ensure that `kGreen` and `kGrey` are defined here.

class SecondarySearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged; // Callback for text changes
  final VoidCallback onTap; // Callback for field tap

  const SecondarySearchField({
    Key? key,
    required this.controller,
    required this.onTextChanged,
    required this.onTap, // This is now required
  }) : super(key: key);

  @override
  _SecondarySearchFieldState createState() => _SecondarySearchFieldState();
}

class _SecondarySearchFieldState extends State<SecondarySearchField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      radius: 10,
      child: TextField(
        onChanged: widget.onTextChanged, // Pass text changes to the callback
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller, // Use the provided controller
        focusNode: _focusNode,
        onTap: widget.onTap, // Invoke the onTap callback when field is tapped
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
          border: InputBorder.none,
          suffixIcon: Container(
            width: 60, // Adjust width if necessary for the button
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isFocused ? kGreen : kGrey, // Changes based on focus
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white), // Search button icon
              onPressed: () {
                // Search button action can be defined here if needed.
              },
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kGreen),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;

  const PrimaryContainer({
    Key? key,
    this.radius,
    this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        color: color ?? kGrey1, // Set color without BoxShadow
      ),
      child: child,
    );
  }
}

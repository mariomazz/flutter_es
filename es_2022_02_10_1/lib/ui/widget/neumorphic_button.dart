import 'package:flutter/material.dart';

class NeumorphicButton extends StatelessWidget {
  const NeumorphicButton({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    bool _isElevated = true;
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _isElevated = !_isElevated;
          });
        },
        child: AnimatedContainer(
          height: 300,
          width: 300,
          duration: const Duration(
            milliseconds: 200,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _isElevated
                ? [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [...children],
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  const AppBody({
    Key? key,
    required this.isLoading,
    this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: child ?? const SizedBox.shrink(),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
          )
      ],
    );
  }
}

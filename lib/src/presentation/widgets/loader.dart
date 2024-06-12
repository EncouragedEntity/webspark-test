import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.value,
  });
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: CircularProgressIndicator(
        value: value,
      ),
    );
  }
}

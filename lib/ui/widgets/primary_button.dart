import 'package:flutter/material.dart';

import '../common/ui_helpers.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const PrimaryButton({
    super.key,
    this.onTap,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: screenPadding,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

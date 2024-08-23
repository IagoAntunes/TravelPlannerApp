import 'package:flutter/material.dart';

class AppStyleText {
  static TextStyle headingLg(BuildContext context) {
    return const TextStyle(
      fontSize: 24,
      letterSpacing: -0.4,
      fontWeight: FontWeight.w600, // Semibold
      height: 1.0,
    );
  }

  static TextStyle headingMd(BuildContext context) {
    return const TextStyle(
      fontSize: 20,
      letterSpacing: -0.4,
      fontWeight: FontWeight.w600, // Semibold
      height: 1.0,
    );
  }

  static TextStyle headingSm(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w600, // Semibold
      height: 1.0,
    );
  }

  static TextStyle headingXs(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      letterSpacing: -0.32,
      fontWeight: FontWeight.w500, // Medium
      height: 1.0,
    );
  }

  static TextStyle bodyLg(BuildContext context) {
    return const TextStyle(
      fontSize: 18,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w400, // Regular
      height: 1.4,
    );
  }

  static TextStyle bodyMd(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w400, // Regular
      height: 1.4,
    );
  }

  static TextStyle bodySm(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w400, // Regular
      height: 1.4,
    );
  }

  static TextStyle bodyXs(BuildContext context) {
    return const TextStyle(
      fontSize: 12,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w400, // Regular
      height: 1.4,
    );
  }

  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      letterSpacing: -0.36,
      fontWeight: FontWeight.w500, // Medium
      height: 1.0,
    );
  }
}

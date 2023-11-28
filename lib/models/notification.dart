import 'package:flutter/material.dart';

class Notifications {
  final DateTime date;
  final Widget leading;
  final String title;
  final String subtitle;

  const Notifications({
    required this.date,
    required this.leading,
    required this.title,
    required this.subtitle,
  });
}

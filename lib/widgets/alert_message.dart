import 'package:flutter/material.dart';

AlertMessage(Widget content, context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
}

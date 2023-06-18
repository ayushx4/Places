import 'package:flutter/material.dart';

AlertMessage(context,Widget content,) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
}

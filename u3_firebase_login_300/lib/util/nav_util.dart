import 'package:flutter/material.dart';

class NavUtil {
  static void navegar(BuildContext context, Widget destino, {bool replacement = false}) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => destino,
    );
    if (replacement) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
  }
}

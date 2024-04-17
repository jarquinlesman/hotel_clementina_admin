import 'package:flutter/material.dart';

class Reservar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50), // Margen de 50px en todos los lados
        child: Center(
          child: Text(
            'Pantalla de Reservar',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
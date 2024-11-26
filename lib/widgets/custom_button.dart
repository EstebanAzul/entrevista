import 'package:entrevista/models/persona_model.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.persona,
    required this.callback,
    required this.color,
    required this.icon,
    required this.onClick,
  });

  final Persona persona;
  final VoidCallback callback;
  final Color color;
  final IconData icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero, // Elimina el padding extra
        minimumSize: const Size(50, 50),
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      
      onPressed: onClick,
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

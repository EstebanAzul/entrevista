import 'package:flutter/material.dart';

class AddPersonDialog extends StatefulWidget {
  final Function(String nombre, String email, int edad) onSubmit;
  final String? initialNombre;
  final String? initialEmail;
  final int? initialEdad;

  const AddPersonDialog({
    required this.onSubmit,
    this.initialNombre,
    this.initialEmail,
    this.initialEdad,
    super.key,
  });

  @override
  State<AddPersonDialog> createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends State<AddPersonDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _emailController;
  late final TextEditingController _edadController;

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con valores iniciales si existen
    _nombreController = TextEditingController(text: widget.initialNombre ?? '');
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
    _edadController =
        TextEditingController(text: widget.initialEdad?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.grey, fontSize: 12);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
          widget.initialNombre == null ? 'Agregar Persona' : 'Editar Persona'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre', labelStyle: textStyle),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', labelStyle: textStyle),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El email es obligatorio';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _edadController,
              decoration: const InputDecoration(labelText: 'Edad', labelStyle: textStyle),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La edad es obligatoria';
                } else if (int.tryParse(value) == null) {
                  return 'Debe ser un número';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final nombre = _nombreController.text;
              final email = _emailController.text;
              final edad = int.parse(_edadController.text);
              widget.onSubmit(nombre, email, edad);
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.initialNombre == null ? 'Agregar' : 'Guardar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _edadController.dispose();
    super.dispose();
  }
}

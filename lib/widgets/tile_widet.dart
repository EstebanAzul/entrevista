import 'package:entrevista/models/persona_model.dart';
import 'package:entrevista/services/api_service.dart';
import 'package:entrevista/widgets/add_person.dart';
import 'package:entrevista/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.persona,
    required this.onDelete,
    required this.onUpdate,
  });

  final Persona persona;
  final VoidCallback onUpdate; // Callback para notificar actualización
  final VoidCallback onDelete; // Callback para notificar eliminación

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            persona.nombre,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text("Email: ${persona.email} | Edad: ${persona.edad}"),
          trailing: SizedBox(
            width: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  color: Colors.blue,
                  icon: Icons.edit,
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddPersonDialog(
                        initialNombre: persona.nombre,
                        initialEmail: persona.email,
                        initialEdad: persona.edad,
                        onSubmit: (nombre, email, edad) {
                          ApiService.updatePersona(persona.id!, {
                            'nombre': nombre,
                            'email': email,
                            'edad': edad
                          }).then((success) {
                            if (success) {
                              onUpdate(); // Notifica al widget padre
                            }
                          });
                        },
                      ),
                    );
                  },
                  persona: persona,
                  callback: onUpdate,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  color: Colors.red,
                  icon: Icons.delete,
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Eliminar Persona'),
                        content: const Text(
                            '¿Estás seguro de eliminar esta persona?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (persona.id != null) {
                                await ApiService.deletePersona(persona.id!);
                                onDelete(); // Notifica al widget padre
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                  },
                  persona: persona,
                  callback: onDelete,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.3,
        )
      ],
    );
  }
}

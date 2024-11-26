import 'package:entrevista/utils/colors.dart';
import 'package:entrevista/services/api_service.dart';
import 'package:entrevista/widgets/add_person.dart';
import 'package:entrevista/widgets/tile_widet.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> personas = [];
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    fetchPersonas();
  }

  Future<void> fetchPersonas() async {
     setState(() {
      isLoading = true; // Comienza la carga
    });

    try {
      final data = await ApiService.getPersonas();
      setState(() {
        personas = data;
        isLoading = false; // Termina la carga
      });
    } catch (e) {
      print("Error al obtener las personas: $e");
      setState(() {
        isLoading = false; // Termina la carga incluso si hay un error
      });
    }
  }

  Future<void> deletePersona(int id) async {
    final success = await ApiService.deletePersona(id);

    if (success) {
      fetchPersonas();
    } else {
      print("Error al eliminar persona");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('App ABC', style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddPersonDialog(
              onSubmit: (nombre, email, edad) {
                ApiService.addPersona(
                        {'nombre': nombre, 'email': email, 'edad': edad})
                    .then((success) {
                  if (success) {
                    fetchPersonas(); 
                  }
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: personas.isEmpty || isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: personas.length,
              itemBuilder: (BuildContext context, int index) {
                final persona = personas[index];
                return Tile(
                  persona: persona,
                  onDelete: fetchPersonas,
                  onUpdate: fetchPersonas,
                );
              },
            ),
    );
  }
}


import 'dart:convert';
import 'package:entrevista/models/persona_model.dart';
import 'package:entrevista/utils/api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Persona>> getPersonas() async {
    final response = await http.get(Uri.parse(API.getPersonas));

  if (response.statusCode == 200) {
    // Decodifica el cuerpo de la respuesta JSON
    final List<dynamic> data = jsonDecode(response.body);

    // Mapea cada elemento de la lista al modelo Persona
    return data.map((json) => Persona.fromJson(json)).toList();
  } else {
    throw Exception("Error al obtener las personas");
  }
  }

  static Future<bool> addPersona(Map<String, dynamic> persona) async {
    final response = await http.post(
      Uri.parse(API.postPersona),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(persona),
    );

    return response.statusCode == 201;
  }

  static Future<bool> updatePersona(int id, Map<String, dynamic> persona) async {
    final response = await http.put(
      Uri.parse(API.updatePersona(id)),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(persona),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deletePersona(int id) async {
    final response = await http.delete(Uri.parse(API.deletePersona(id)));

    return response.statusCode == 200;
  }
}
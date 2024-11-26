class Persona {
  final int? id;
  final String nombre;
  final String email;
  final int edad;

  // Constructor
  Persona({
    this.id,
    required this.nombre,
    required this.email,
    required this.edad,
  });

  // Método para convertir un JSON en una instancia de Persona
  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      edad: json['edad'],
    );
  }

  // Método para convertir una instancia de Persona a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'edad': edad,
    };
  }
}
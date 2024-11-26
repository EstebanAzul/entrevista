class API {
  static const String baseUrl = "https://esteban.company/entrevista/public/api";

  static const String getPersonas = "$baseUrl/personas";
  static const String postPersona = "$baseUrl/personas";
  static String updatePersona(int id) => "$baseUrl/personas/$id";
  static String deletePersona(int id) => "$baseUrl/personas/$id";
}
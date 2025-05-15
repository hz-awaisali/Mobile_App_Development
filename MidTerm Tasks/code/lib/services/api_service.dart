import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../utils/constants.dart';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Student>> fetchStudents() async {
    try {
      final response = await client.get(Uri.parse(ApiUrls.studentsEndpoint));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }
}
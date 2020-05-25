import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Eventory/podo/supplier.dart';
 
class Services {
  static const String url = 'http://192.168.56.1/mobile_eventory/login.php';
 
  static Future<List<Supplier>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Supplier> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<Supplier> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Supplier>((json) => Supplier.fromJson(json)).toList();
  }
}
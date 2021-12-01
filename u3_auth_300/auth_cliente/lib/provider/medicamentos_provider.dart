import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MedicamentosProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getMedicamentos() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? '';

    var uri = Uri.parse('$apiURL/medicamentos');
    var respuesta =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    // var respuesta = await http
    //     .get(uri, headers: {'APP_KEY': 'fnBVCwUNBOFKmArIqYXTrJ4dFwPmRB0R'});

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<bool> login(String email, String password) async {
    var uri = Uri.parse('$apiURL/login');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    var data = json.decode(respuesta.body);

    if (data['access_token'] != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', data['access_token']);
      sp.setString('nombre_usuario', data['user']['name']);
    }

    return data['access_token'] != null;

    // if (data['access_token'] != null) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}

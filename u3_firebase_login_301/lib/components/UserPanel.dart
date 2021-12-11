import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u3_firebase_login_301/constants.dart';

Container panelUserEmail() {
  return Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    color: kPrimaryColor,
    child: FutureBuilder(
        future: getEmailUsuario(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          }
          return Row(
            children: [
              Icon(
                MdiIcons.email,
                color: Colors.white,
              ),
              Text(
                ' Email: ',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                snapshot.data,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }),
  );
}

Future<String> getEmailUsuario() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getString('user_email') ?? '';
}

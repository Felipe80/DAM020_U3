import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u3_firebase_login_300/constants.dart';
import 'package:u3_firebase_login_300/pages/login_page.dart';
import 'package:u3_firebase_login_300/util/nav_util.dart';

class ProductosPage extends StatefulWidget {
  ProductosPage({Key? key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.firebase,
          color: Colors.yellow,
        ),
        title: Text('Productos Firestore'),
        actions: [
          PopupMenuButton(
            onSelected: (opcion) async {
              await FirebaseAuth.instance.signOut();
              NavUtil.navegar(context, LoginPage(), replacement: true);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Text('Salir'),
                    Spacer(),
                    Icon(
                      MdiIcons.logout,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: kPrimaryColor,
            child: FutureBuilder(
                future: this.getEmailUsuario(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text('');
                  }
                  return Row(
                    children: [
                      Icon(MdiIcons.email, color: Colors.white),
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
          ),
        ],
      ),
    );
  }

  Future<String> getEmailUsuario() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('user_email') ?? '';
  }
}

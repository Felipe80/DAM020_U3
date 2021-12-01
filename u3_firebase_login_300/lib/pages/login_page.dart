import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u3_firebase_login_300/constants.dart';
import 'package:u3_firebase_login_300/pages/productos_page.dart';
import 'package:u3_firebase_login_300/util/nav_util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.firebase,
          color: Colors.yellow,
        ),
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Iniciar Sesión'),
                  style: ElevatedButton.styleFrom(
                    primary: kSecondaryColor,
                  ),
                  onPressed: () async {
                    UserCredential? userCredential;
                    try {
                      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                      );
                      //si llegamos a esta linea la autenticacion fue correcta
                      SharedPreferences sp = await SharedPreferences.getInstance();
                      // sp.setString('user_email', emailCtrl.text.trim());
                      sp.setString('user_email', userCredential.user!.email!);

                      NavUtil.navegar(context, ProductosPage(), replacement: true);
                    } on FirebaseAuthException catch (ex) {
                      switch (ex.code) {
                        case 'user-not-found':
                          errorText = 'El usuario no existe';
                          break;
                        case 'wrong-password':
                          errorText = 'Contraseña incorrecta';
                          break;
                        case 'user-disabled':
                          errorText = 'Cuenta desactivada';
                          break;
                        default:
                          errorText = 'Error desconocido';
                      }
                      setState(() {});
                    }
                  },
                ),
              ),
              Container(
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

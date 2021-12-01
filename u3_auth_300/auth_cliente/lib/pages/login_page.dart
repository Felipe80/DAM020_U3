import 'package:auth_cliente/pages/medicamentos_page.dart';
import 'package:auth_cliente/provider/medicamentos_provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente Auth'),
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
                  onPressed: () {
                    MedicamentosProvider provider = MedicamentosProvider();
                    provider
                        .login(emailCtrl.text.trim(), passwordCtrl.text.trim())
                        .then(
                      (loginOk) {
                        if (loginOk) {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => MedicamentosPage(),
                          );
                          Navigator.pushReplacement(context, route);
                        } else {
                          //mostrar mensaje error
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

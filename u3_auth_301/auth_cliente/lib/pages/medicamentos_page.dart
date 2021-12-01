import 'package:auth_cliente/pages/login_page.dart';
import 'package:auth_cliente/provider/medicamentos_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicamentosPage extends StatefulWidget {
  MedicamentosPage({Key? key}) : super(key: key);

  @override
  _MedicamentosPageState createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  MedicamentosProvider provider = MedicamentosProvider();
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicamentos'),
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (opcion) {
              switch (opcion) {
                case 'logout':
                  logout();
                  break;
                case 'about':
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'about',
                child: Text('Acerca de'),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar Sesión'),
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
            color: Colors.blue,
            child: Row(
              children: [
                Icon(
                  MdiIcons.accountCircle,
                  color: Colors.white,
                ),
                FutureBuilder(
                    future: this.getNombreUsuario(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('...');
                      }
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(color: Colors.white),
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: provider.getMedicamentos(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var medicamento = snapshot.data[index];
                    return ListTile(
                      leading: Icon(
                        MdiIcons.pill,
                        color: Colors.purple,
                      ),
                      title: Text(medicamento['nombre']),
                      subtitle:
                          Text('\$ ${fPrecio.format(medicamento['precio'])}'),
                      trailing: Chip(
                        label: Text('Stock'),
                        avatar: CircleAvatar(
                          child: Text(medicamento['stock'].toString()),
                          backgroundColor: medicamento['stock'] < 10
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getNombreUsuario() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('nombre_usuario') ?? '';
  }

  void logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.remove('nombre_usuario');

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => LoginPage(),
    );
    Navigator.pushReplacement(context, route);
  }
}

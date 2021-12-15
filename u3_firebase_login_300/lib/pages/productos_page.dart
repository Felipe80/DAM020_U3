import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u3_firebase_login_300/components/user_panel.dart';
import 'package:u3_firebase_login_300/constants.dart';
import 'package:u3_firebase_login_300/pages/comentarios_page.dart';
import 'package:u3_firebase_login_300/pages/login_page.dart';
import 'package:u3_firebase_login_300/pages/productos_agregar_page.dart';
import 'package:u3_firebase_login_300/service/firestore_service.dart';
import 'package:u3_firebase_login_300/util/nav_util.dart';

class ProductosPage extends StatefulWidget {
  ProductosPage({Key? key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  var fPrecio = NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.firebase,
          color: Colors.yellow,
        ),
        title: Text('Productos Firestore'),
        elevation: 0,
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
          panelUserEmail(),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().productos(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var producto = snapshot.data!.docs[index];
                    return Dismissible(
                      key: ObjectKey(snapshot.data!.docs[index]),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Borrar',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              MdiIcons.trashCan,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        FirestoreService().productosBorrar(producto.id);
                      },
                      child: ListTile(
                        leading: Icon(MdiIcons.cube),
                        title: Text('${producto['marca']} ${producto['modelo']}'),
                        subtitle: Text('Stock: ${producto['stock']}'),
                        trailing: Text('\$ ${fPrecio.format(producto['precio'])}'),
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => ComentariosPage(
                                    productoId: producto.id,
                                  ));
                          Navigator.push(context, route);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavUtil.navegar(context, ProductosAgregarPage());
        },
      ),
    );
  }
}

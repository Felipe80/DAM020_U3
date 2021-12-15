import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:u3_firebase_login_301/components/UserPanel.dart';
import 'package:u3_firebase_login_301/constants.dart';
import 'package:u3_firebase_login_301/service/firestore_service.dart';

class ComentariosPage extends StatefulWidget {
  String productoId;
  ComentariosPage({Key? key, this.productoId = ''}) : super(key: key);

  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  var fFecha = DateFormat('dd-MM-yyyy kk:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          MdiIcons.firebase,
          color: Colors.yellow,
        ),
        title: Text('Comentarios Producto'),
        elevation: 0,
      ),
      body: Column(
        children: [
          panelUserEmail(),
          Container(
            color: Colors.blue.shade50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder(
                stream: FirestoreService().producto(widget.productoId),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('...');
                  }

                  var producto = snapshot.data!;
                  return Row(
                    children: [
                      Text('Marca:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(producto['marca'], style: TextStyle(fontSize: 18)),
                      Text(' Modelo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(producto['modelo'], style: TextStyle(fontSize: 18)),
                    ],
                  );
                }),
          ),
          Divider(
            thickness: 2,
            color: Colors.blue.shade100,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().comentariosProducto(widget.productoId),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var comentario = snapshot.data!.docs[index];
                    return ListTile(
                      leading: Icon(
                        MdiIcons.commentOutline,
                        color: kSecondaryColor,
                      ),
                      title: Text(comentario['texto']),
                      subtitle: Text(fFecha.format(comentario['fecha'].toDate())),
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
}

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:u3_firebase_login_300/components/user_panel.dart';
import 'package:u3_firebase_login_300/constants.dart';
import 'package:u3_firebase_login_300/service/firestore_service.dart';
import 'package:u3_firebase_login_300/util/number_util.dart';

class ProductosAgregarPage extends StatefulWidget {
  ProductosAgregarPage({Key? key}) : super(key: key);

  @override
  _ProductosAgregarPageState createState() => _ProductosAgregarPageState();
}

class _ProductosAgregarPageState extends State<ProductosAgregarPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController marcaCtrl = TextEditingController();
  TextEditingController modeloCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();
  TextEditingController stockCtrl = TextEditingController();

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
      ),
      body: ListView(
        children: [
          panelUserEmail(),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  campoMarca(),
                  campoModelo(),
                  campoPrecio(),
                  campoStock(),
                  botonAgregarProducto(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField campoMarca() {
    return TextFormField(
      controller: marcaCtrl,
      decoration: InputDecoration(labelText: 'Marca'),
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Ingrese marca';
        }
        return null;
      },
    );
  }

  TextFormField campoModelo() {
    return TextFormField(
      controller: modeloCtrl,
      decoration: InputDecoration(labelText: 'Modelo'),
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Ingrese modelo';
        }
        return null;
      },
    );
  }

  TextFormField campoPrecio() {
    return TextFormField(
      controller: precioCtrl,
      decoration: InputDecoration(labelText: 'Precio'),
      keyboardType: TextInputType.number,
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Ingrese precio';
        }
        if (!NumberUtil.isInteger(valor)) {
          return 'El precio debe ser un número entero';
        }
        int precio = int.parse(valor);
        if (precio < 0) {
          return 'El precio no puede ser un valor negativo';
        }
        return null;
      },
    );
  }

  TextFormField campoStock() {
    return TextFormField(
      controller: stockCtrl,
      decoration: InputDecoration(labelText: 'Stock'),
      keyboardType: TextInputType.number,
      validator: (valor) {
        if (valor!.isEmpty) {
          return 'Ingrese stock';
        }
        if (!NumberUtil.isInteger(valor)) {
          return 'El stock debe ser un número entero';
        }
        return null;
      },
    );
  }

  Container botonAgregarProducto() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        child: Text('Agregar Producto'),
        style: ElevatedButton.styleFrom(primary: kSecondaryColor),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            //form ok
            FirestoreService().productosAgregar(
              marcaCtrl.text.trim(),
              modeloCtrl.text.trim(),
              int.parse(precioCtrl.text.trim()),
              int.parse(stockCtrl.text.trim()),
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

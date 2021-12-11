import 'package:flutter/material.dart';
import 'package:u3_firebase_login_301/components/UserPanel.dart';
import 'package:u3_firebase_login_301/constants.dart';
import 'package:u3_firebase_login_301/service/firestore_service.dart';
import 'package:u3_firebase_login_301/util/number_util.dart';

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
        title: Text('Agregar Nuevo Producto'),
        elevation: 0,
      ),
      body: Column(
        children: [
          panelUserEmail(),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
          return 'Indique marca';
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
          return 'Indique modelo';
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
          return 'Indique precio';
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
          return 'Indique stock';
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
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Agregar Producto'),
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
        ),
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

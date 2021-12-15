import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> productos() {
    return FirebaseFirestore.instance.collection('productos').snapshots();
  }

  Future productosAgregar(String marca, String modelo, int precio, int stock) async {
    FirebaseFirestore.instance.collection('productos').doc().set({
      'marca': marca,
      'modelo': modelo,
      'precio': precio,
      'stock': stock,
    });
  }

  Future productosBorrar(String productoId) {
    return FirebaseFirestore.instance.collection('productos').doc(productoId).delete();
  }

  Stream<DocumentSnapshot> producto(String productoId) {
    return FirebaseFirestore.instance.collection('productos').doc(productoId).snapshots();
  }

  Stream<QuerySnapshot> comentariosProducto(String productoId) {
    return FirebaseFirestore.instance.collection('comentarios').where('producto_id', isEqualTo: productoId).snapshots();
  }
}

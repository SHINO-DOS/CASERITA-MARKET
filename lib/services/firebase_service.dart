import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> verificarConexion() async {
    try {
      final snapshot = await _db.collection('productos').limit(1).get();
      return snapshot.docs.isNotEmpty || snapshot.docs.isEmpty;
    } catch (e) {
      debugPrint("Error de conexión a Firestore: $e");
      return false;
    }
  }
}

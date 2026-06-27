import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  AuthController() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get isAuthenticated => _user != null;
  User? get user => _user;
  String get currentUid => _user?.uid ?? '';

  Future<String?> login(
    String email,
    String password, {
    String? rolSeleccionado,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return "Llena todos los campos.";
    }

    if (rolSeleccionado != null &&
        !['comprador', 'productor'].contains(rolSeleccionado)) {
      return "Selecciona si vas a entrar como comprador o productor.";
    }

    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (rolSeleccionado != null) {
        final doc = await _firestore
            .collection('usuarios')
            .doc(cred.user!.uid)
            .get();
        final rolUsuario = (doc.data()?['rol'] ?? 'comprador').toString();

        if (rolUsuario != rolSeleccionado) {
          await _auth.signOut();
          return rolUsuario == 'productor'
              ? 'Esta cuenta está registrada como productor. Elige la opción Productor.'
              : 'Esta cuenta está registrada como comprador. Elige la opción Comprador.';
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String?> register(
    String email,
    String password,
    String nombre,
    String rol,
  ) async {
    if (email.isEmpty || password.isEmpty || nombre.isEmpty) {
      return "Llena todos los campos.";
    }

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection('usuarios').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': email.trim(),
        'nombre': nombre.trim(),
        'rol': rol,
        'fechaRegistro': Timestamp.now(),
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

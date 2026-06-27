import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String producto;
  final double cantidad;
  final String unidad;
  final double precio;
  final String ubicacion; // Mercado / Zona
  final String ciudad;
  final String mapaEnlace; // ← NUEVO CAMPO: Enlace de Google Maps
  final DateTime fecha;
  final String? userId;

  Product({
    required this.id,
    required this.producto,
    required this.cantidad,
    required this.unidad,
    required this.precio,
    required this.ubicacion,
    required this.ciudad,
    required this.mapaEnlace,
    required this.fecha,
    this.userId,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      producto: data['producto'] ?? '',
      cantidad: (data['cantidad'] ?? 0).toDouble(),
      unidad: data['unidad'] ?? '',
      precio: (data['precio'] ?? 0).toDouble(),
      ubicacion: data['ubicacion'] ?? '',
      ciudad: data['ciudad'] ?? '',
      mapaEnlace: data['mapaEnlace'] ?? '',
      fecha: (data['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'producto': producto,
      'cantidad': cantidad,
      'unidad': unidad,
      'precio': precio,
      'ubicacion': ubicacion,
      'ciudad': ciudad,
      'mapaEnlace': mapaEnlace,
      'fecha': Timestamp.fromDate(fecha),
      'userId': userId,
    };
  }
}

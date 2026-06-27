import '../../../core/constants.dart';
import '../models/product_model.dart';

class ProductController {
  static double getPrecioReferencial(String producto) {
    String p = producto.toLowerCase();
    if (p.contains('papa')) return 50.0;
    if (p.contains('arroz')) return 8.0;
    if (p.contains('aceite')) return 13.0;
    if (p.contains('pollo')) return 15.0;
    return 20.0;
  }

  static Map<String, dynamic> calcularAlertaEspeculacion(Product producto) {
    double precioRef = getPrecioReferencial(producto.producto);
    double incremento = (producto.precio - precioRef) / precioRef;

    if (incremento >= AppConstants.thresholdDanger) {
      return {
        'color': AppConstants.statusDanger,
        'label': '🔴 ESPECULACIÓN CRÍTICA',
      };
    } else if (incremento >= AppConstants.thresholdWarning) {
      return {
        'color': AppConstants.statusWarning,
        'label': '🟡 PRECIO ELEVADO',
      };
    } else {
      return {'color': AppConstants.statusNormal, 'label': '🟢 PRECIO ESTABLE'};
    }
  }
}

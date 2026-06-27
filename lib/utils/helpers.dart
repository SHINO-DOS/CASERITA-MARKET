import 'package:intl/intl.dart';

class AppHelpers {
  static String formatarFecha(DateTime fecha) {
    return DateFormat('dd/MM/yyyy HH:mm').format(fecha);
  }
}

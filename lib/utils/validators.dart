class AppValidators {
  static String? validarTexto(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    return null;
  }

  static String? validarNumero(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido';
    }
    final num = double.tryParse(value);
    if (num == null || num <= 0) {
      return 'Número no válido';
    }
    return null;
  }
}

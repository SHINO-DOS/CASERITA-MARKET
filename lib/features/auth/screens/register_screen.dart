import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caserita_market/features/auth/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _rolSeleccionado = 'comprador';
  bool _isLoading = false;

  void _submit() async {
    setState(() => _isLoading = true);
    final authController = Provider.of<AuthController>(context, listen: false);

    final String? error = await authController.register(
      _emailController.text,
      _passwordController.text,
      _nombreController.text,
      _rolSeleccionado,
    );

    if (!mounted) {
      return;
    }
    setState(() => _isLoading = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Bienvenido a Caserita Market!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Únete a la familia'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Quién eres?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),

            // 🔥 SOLUCIÓN MATERIAL 3: Reemplaza los RadioListTile obsoletos por un hermoso SegmentedButton
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                    value: 'comprador',
                    label: Text('Comprador'),
                    icon: Icon(Icons.shopping_bag),
                  ),
                  ButtonSegment<String>(
                    value: 'productor',
                    label: Text('Caserita / Productor'),
                    icon: Icon(Icons.storefront),
                  ),
                ],
                selected: {_rolSeleccionado},
                onSelectionChanged: (Set<String> nuevaSeleccion) {
                  setState(() {
                    _rolSeleccionado = nuevaSeleccion.first;
                  });
                },
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: _rolSeleccionado == 'productor'
                      ? Colors.orange
                      : Colors.green,
                  selectedForegroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 10),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _rolSeleccionado == 'productor'
                      ? Colors.orange
                      : Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Crear mi cuenta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

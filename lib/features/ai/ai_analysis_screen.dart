import 'package:flutter/material.dart';

class AiAnalysisScreen extends StatelessWidget {
  const AiAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente IA Gemini'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.blue, size: 40),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      'Hola, soy tu asistente IA. Estoy analizando los precios del mercado en tiempo real para detectar escasez.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Alertas de Mercado Recientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Ejemplo Estático para la Demo
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 30,
                ),
                title: const Text('Posible Escasez de Tomate'),
                subtitle: const Text(
                  'El precio del tomate ha subido un 20% en el Mercado Rodríguez en las últimas 48 horas. Se recomienda a compradores buscar alternativas.',
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Ver datos'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

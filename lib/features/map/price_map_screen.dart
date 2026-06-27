import 'package:flutter/material.dart';
import '../../core/constants.dart';

class PriceMapScreen extends StatelessWidget {
  const PriceMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> zonasCriticas = [
      {
        'zona': 'Locotal (Carretera Nueva CBA-SCZ)',
        'estado': '🔴 BLOQUEO TOTAL',
        'insumo': 'Combustible y Pollo',
        'color': AppConstants.statusDanger,
      },
      {
        'zona': 'Sica Sica (Ruta Oruro-La Paz)',
        'estado': '🔴 BLOQUEO TOTAL',
        'insumo': 'Verduras y Papa',
        'color': AppConstants.statusDanger,
      },
      {
        'zona': 'Mercado Abasto (Santa Cruz)',
        'estado': '🟡 ESPECULACIÓN MODERADA',
        'insumo': 'Arroz y Aceite',
        'color': AppConstants.statusWarning,
      },
      {
        'zona': 'Mercado Rodríguez (La Paz)',
        'estado': '🟡 PRECIOS ELEVADOS',
        'insumo': 'Tomate y Papa',
        'color': AppConstants.statusWarning,
      },
      {
        'zona': 'Puente de la Amistad (Montero)',
        'estado': '🟢 TRÁNSITO LIBRE',
        'insumo': 'Abastecimiento Normal',
        'color': AppConstants.statusNormal,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa Nacional de Alertas')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.map, size: 100, color: Colors.green),
                const PositionContextWidget(
                  top: 40,
                  left: 60,
                  color: Colors.red,
                ),
                const PositionContextWidget(
                  top: 90,
                  left: 140,
                  color: Colors.orange,
                ),
                const PositionContextWidget(
                  top: 130,
                  left: 220,
                  color: Colors.red,
                ),
                const PositionContextWidget(
                  top: 150,
                  left: 100,
                  color: Colors.green,
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text(
                      'Simulación Georreferencial en Tiempo Real',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Zonas de Alto Riesgo de Especulación:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: zonasCriticas.length,
              itemBuilder: (context, index) {
                final zona = zonasCriticas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (zona['color'] as Color).withValues(
                        alpha: 0.2,
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: zona['color'],
                      ),
                    ),
                    title: Text(
                      zona['zona'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Afecta a: ${zona['insumo']}"),
                    trailing: Text(
                      zona['estado'],
                      style: TextStyle(
                        color: zona['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PositionContextWidget extends StatelessWidget {
  final double top;
  final double left;
  final Color color;
  const PositionContextWidget({
    super.key,
    required this.top,
    required this.left,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Icon(Icons.location_on, color: color, size: 32),
    );
  }
}

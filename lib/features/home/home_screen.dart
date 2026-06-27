import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// 🔥 IMPORTACIONES ABSOLUTAS: Esto evita errores de rutas no encontradas
import 'package:caserita_market/features/auth/controllers/auth_controller.dart';
import 'package:caserita_market/features/products/screens/product_list_screen.dart';
import 'package:caserita_market/features/products/screens/register_product_screen.dart';
import 'package:caserita_market/features/ai/ai_analysis_screen.dart';
import 'package:caserita_market/features/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _userRole = 'comprador'; // Por defecto

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  void _fetchUserRole() async {
    final auth = Provider.of<AuthController>(context, listen: false);
    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(auth.currentUid)
        .get();

    if (doc.exists && mounted) {
      setState(() {
        _userRole = doc.data()?['rol'] ?? 'comprador';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const ProductListScreen(), // 0. Precios
      if (_userRole == 'productor')
        const RegisterProductScreen(), // 1. Subir Producto (Solo Productor)
      const AiAnalysisScreen(), // 2. IA
      const ProfileScreen(), // 3. Perfil
    ];

    final bool isProducer = _userRole == 'productor';
    final String roleLabel = isProducer ? 'Productor' : 'Comprador';
    final String welcomeText = isProducer
        ? 'Bienvenido productor'
        : 'Bienvenido comprador';
    final String subtitle = isProducer
        ? 'Gestiona tus productos y precios.'
        : 'Revisa precios, alertas y productos del mercado.';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: BoxDecoration(
                color: isProducer
                    ? Colors.orange.shade50
                    : Colors.green.shade50,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    welcomeText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isProducer ? Colors.orange : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      roleLabel.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: screens[_currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mercado',
          ),
          if (_userRole == 'productor')
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo, color: Colors.orange),
              label: 'Vender',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Alerta IA',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi Perfil',
          ),
        ],
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';
import 'busqueda.dart';
import 'equipo.dart';
import 'mapa.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaBusqueda()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; 
        });
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaEquipo()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; 
        });
      });
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaMapa()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; 
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC0A2D),
        elevation: 0,
        title: const Text(
          'PokeTravel',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo_naranja.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/images/pokebola_logo.png', height: 140, errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, size: 140)),
              const SizedBox(height: 20),
              const Text(
                'POKETRAVEL',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5E8A),
                  letterSpacing: 1.5,
                ),
              ),
              const Text(
                'APP MÓVIL',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE9653B),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PantallaBusqueda()),
                  ).then((_) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC0A2D),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(200, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'INGRESAR',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              const Text(
                'Desarrollado por:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12),
              ),
              const SizedBox(height: 4),
              const Text(
                'Juan Camilo García\nDanna Perez\nDonoban Bermudez',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.2),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFDC0A2D),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon), label: 'Equipo'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        ],
      ),
    );
  }
}
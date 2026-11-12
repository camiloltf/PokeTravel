import 'package:material_ui/material_ui.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'busqueda.dart'; 
import 'equipo.dart';

class PantallaMapa extends StatefulWidget {
  const PantallaMapa({super.key});

  @override
  State<PantallaMapa> createState() => _PantallaMapaState();
}

class _PantallaMapaState extends State<PantallaMapa> {
  final int _selectedIndex = 3; 
  late GoogleMapController mapController;

  final Map<String, LatLng> coordenadasPaises = {
    'España': const LatLng(40.4168, -3.7038),
    'Costa Rica': const LatLng(9.9281, -84.0907),
    'Australia': const LatLng(-35.2809, 149.1300),
    'Japón': const LatLng(35.6762, 139.6503),
  };

  Set<Marker> _crearMarcadores() {
    Set<Marker> marcadores = {};
    
    for (int i = 0; i < equipoPokemon.length; i++) {
      final poke = equipoPokemon[i];
      final country = poke['country'];
      
      if (coordenadasPaises.containsKey(country)) {
        marcadores.add(
          Marker(
            markerId: MarkerId('poke_$i'),
            position: coordenadasPaises[country]!,
            infoWindow: InfoWindow(
              title: poke['name'],
              snippet: 'Hábitat: $country',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }
    return marcadores;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaBusqueda()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaEquipo()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC0A2D),
        title: const Text('Hábitats Pokémon', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(20.0, 0.0), 
          zoom: 2.0,
        ),
        markers: _crearMarcadores(),
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
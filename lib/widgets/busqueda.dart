import 'package:material_ui/material_ui.dart';
import 'package:poketravel/services/api_service.dart';
import 'card.dart';
import 'equipo.dart'; 
import 'mapa.dart';

List equipoPokemon = []; 

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});

  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final TextEditingController _controller = TextEditingController();
  
  final int _selectedIndex = 1; 

  bool _isLoading = false;
  String? _pokemonName;
  String? _pokemonImageUrl;
  String? _countryName;
  String? _capital;
  String? _errorMessage;

  Future<void> _buscarDestino(String query) async {
    final pokemonKey = query.toLowerCase().trim();
    if (pokemonKey.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _pokemonName = null;
    });

    try {
      final pokemonData = await ApiService.fetchPokemon(pokemonKey);

      if (pokemonData != null) {
        _pokemonName = pokemonData['name'];
        _pokemonImageUrl = pokemonData['imageUrl'];

        String targetCountry = 'Japan';
        if (pokemonKey.contains('charmander') || pokemonKey.contains('charizard')) {
          targetCountry = 'Spain';
        } else if (pokemonKey.contains('bulbasaur') || pokemonKey.contains('venusaur')) {
          targetCountry = 'Costa Rica';
        } else if (pokemonKey.contains('squirtle') || pokemonKey.contains('blastoise')) {
          targetCountry = 'Australia';
        }

        final countryData = await ApiService.fetchCountry(targetCountry);
        if (countryData != null) {
          _countryName = countryData['commonName'];
          _capital = countryData['capital'];
        } else {
          _countryName = targetCountry;
          _capital = 'Desconocida';
        }
      } else {
        _errorMessage = 'No se encontró el Pokémon.';
      }
    } catch (e) {
      _errorMessage = 'Error de conexión.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _atraparPokemon() {
    if (_pokemonName != null && equipoPokemon.length < 6) {
      setState(() {
        equipoPokemon.add({
          'name': _pokemonName![0].toUpperCase() + _pokemonName!.substring(1),
          'imageUrl': _pokemonImageUrl,
          'country': _countryName,
        });
        
        _pokemonName = null;
        _controller.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pokémon atrapado y añadido al equipo!'), backgroundColor: Colors.green),
      );
    } else if (equipoPokemon.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Tu equipo está lleno (Máx 6)!'), backgroundColor: Colors.redAccent),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaEquipo()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaMapa()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC0A2D), 
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFF28AAFE),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(76), blurRadius: 5)]
                    ),
                  ),
                  const SizedBox(width: 20),
                  _buildLight(Colors.red),
                  const SizedBox(width: 8),
                  _buildLight(Colors.yellow),
                  const SizedBox(width: 8),
                  _buildLight(Colors.green),
                ],
              ),
            ),
            
            const Divider(color: Colors.black, thickness: 2, height: 20),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFDEDEDE), 
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSmallDot(),
                        const SizedBox(width: 20),
                        _buildSmallDot(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232323),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text('BÚSQUEDA DE DESTINO', style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _controller,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Ej. pikachu...',
                                  hintStyle: const TextStyle(color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () => _buscarDestino(_controller.text),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                                child: const Text('BUSCAR', style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(height: 20),
                              
                              if (_isLoading) const CircularProgressIndicator(color: Colors.greenAccent),
                              if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent)),
                              if (_pokemonName != null && !_isLoading) ...[
                                DestinationCard(
                                  pokemonName: _pokemonName![0].toUpperCase() + _pokemonName!.substring(1),
                                  countryName: _countryName ?? 'Japón',
                                  capital: _capital ?? 'Tokio',
                                  pokemonImageUrl: _pokemonImageUrl ?? '',
                                  culturalInfo: 'Datos sincronizados.',
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton.icon(
                                  onPressed: _atraparPokemon,
                                  icon: const Icon(Icons.catching_pokemon, color: Colors.white),
                                  label: const Text('ATRAPAR', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.black))),
                        const Icon(Icons.menu, color: Colors.black54), 
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildLight(Color color) {
    return Container(width: 15, height: 15, decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1.5)));
  }
  Widget _buildSmallDot() {
    return Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1)));
  }
}
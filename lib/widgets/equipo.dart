import 'package:material_ui/material_ui.dart';
import 'busqueda.dart'; 
import 'mapa.dart';

class PantallaEquipo extends StatefulWidget {
  const PantallaEquipo({super.key});

  @override
  State<PantallaEquipo> createState() => _PantallaEquipoState();
}

class _PantallaEquipoState extends State<PantallaEquipo> {
  final int _selectedIndex = 2; 

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaBusqueda()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaMapa()),
      );
    }
  }

  void _liberarPokemon(int index) {
    setState(() {
      equipoPokemon.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC0A2D), 
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(color: const Color(0xFFDC0A2D)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: equipoPokemon.isEmpty
                          ? const Center(
                              child: Text(
                                'TU EQUIPO ESTÁ VACÍO.\nVE A BUSCAR.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              itemCount: equipoPokemon.length,
                              itemBuilder: (context, index) {
                                final poke = equipoPokemon[index];
                                return Card(
                                  color: Colors.black45,
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    leading: Image.network(poke['imageUrl']),
                                    title: Text(poke['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    subtitle: Text(poke['country'], style: const TextStyle(color: Colors.white70)),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () => _liberarPokemon(index), 
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 5, 
                        childAspectRatio: 1.2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(10, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF28AAFE), 
                              border: Border.all(color: Colors.black87, width: 1),
                            ),
                          );
                        }),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40, height: 25,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), border: Border.all(color: Colors.black)),
                            ),
                            Container(
                              width: 40, height: 25,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)), border: Border.all(color: Colors.black)),
                            ),
                          ],
                        ),
                        Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            color: Colors.yellow, 
                            shape: BoxShape.circle, 
                            border: Border.all(color: Colors.black, width: 1.5),
                            boxShadow: [BoxShadow(color: Colors.yellow.withAlpha(100), blurRadius: 5)],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(width: 100, height: 35, decoration: BoxDecoration(color: const Color(0xFF1E3329), borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black))),
                        Container(width: 100, height: 35, decoration: BoxDecoration(color: const Color(0xFF1E3329), borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black))),
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
}
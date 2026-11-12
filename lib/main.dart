import 'package:material_ui/material_ui.dart';
import 'widgets/home.dart';

void main() {
  runApp(const PokeTravelApp());
}

class PokeTravelApp extends StatelessWidget {
  const PokeTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PokeTravel',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

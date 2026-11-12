import 'package:material_ui/material_ui.dart';

class DestinationCard extends StatelessWidget {
  final String pokemonName;
  final String countryName;
  final String capital;
  final String pokemonImageUrl;
  final String culturalInfo;

  const DestinationCard({
    super.key,
    required this.pokemonName,
    required this.countryName,
    required this.capital,
    required this.pokemonImageUrl,
    required this.culturalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF333333),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white24, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.network(
              pokemonImageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$pokemonName\n$countryName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Capital: $capital',
                    style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    culturalInfo,
                    style: const TextStyle(
                      color: Colors.white54, 
                      fontSize: 11, 
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
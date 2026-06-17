import 'package:flutter/material.dart';
import '../Models/champion.dart';

class ChampionDetailScreen extends StatelessWidget {
  final Champion champion;

  const ChampionDetailScreen({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    final splashUrl =
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${champion.id}_0.jpg';

    return Scaffold(
      appBar: AppBar(title: Text(champion.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFC8AA6E), width: 1),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    splashUrl,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          champion.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Color(0xFFC8AA6E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          champion.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Color(0xFFC8AA6E)),
                        const SizedBox(height: 16),
                        Text(
                          champion.blurb,
                          style: const TextStyle(fontSize: 16, height: 1.6),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

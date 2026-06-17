import 'package:flutter/material.dart';
import '../Models/champion.dart';
import '../Services/api_service.dart';
import '../Services/local_database.dart';
import 'champion_detail_screen.dart';

class ChampionsScreen extends StatefulWidget {
  const ChampionsScreen({super.key});

  @override
  State<ChampionsScreen> createState() => _ChampionsScreenState();
}

class _ChampionsScreenState extends State<ChampionsScreen> {
  late Future<List<Champion>> championsFuture;

  @override
  void initState() {
    super.initState();
    championsFuture = loadChampions();
  }

  Future<List<Champion>> loadChampions() async {
    try {
      final champions = await ApiService.fetchChampions();
      await LocalDatabase.saveChampions(champions);
      return champions;
    } catch (e) {
      final localChampions = LocalDatabase.getChampions();
      if (localChampions.isEmpty) {
        throw Exception(
          'Brak połączenia z internetem i brak zapisanych danych. Spróbuj ponownie później.',
        );
      }
      return localChampions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('League of Legends API'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                championsFuture = loadChampions();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Champion>>(
        future: championsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Błąd: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }

          final champions = snapshot.data ?? [];

          return ListView.builder(
            itemCount: champions.length,
            itemBuilder: (context, index) {
              final champion = champions[index];
              return ChampionCard(
                champion: champion,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionDetailScreen(champion: champion),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChampionCard extends StatelessWidget {
  final Champion champion;
  final VoidCallback onTap;

  const ChampionCard({super.key, required this.champion, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: ClipOval(
          child: Image.network(
            champion.imageUrl,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 48,
                height: 48,
                color: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.grey),
              );
            },
          ),
        ),
        title: Text(
          champion.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(champion.title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

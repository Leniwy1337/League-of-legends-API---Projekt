import 'package:hive_ce_flutter/hive_flutter.dart';
import '../Models/champion.dart';

class LocalDatabase {
  static const String boxName = 'champions_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Future<void> saveChampions(List<Champion> champions) async {
    final box = Hive.box(boxName);
    await box.clear();

    final List<Map<String, dynamic>> dataToSave = champions
        .map((c) => c.toMap())
        .toList();
    await box.put('all_champions', dataToSave);
  }

  static List<Champion> getChampions() {
    final box = Hive.box(boxName);
    final data = box.get('all_champions');

    if (data == null) {
      return [];
    }

    final List<dynamic> rawList = data;
    final List<Champion> champions = rawList.map((item) {
      final map = item as Map<dynamic, dynamic>;
      return Champion.fromMap(map);
    }).toList();

    return champions;
  }
}

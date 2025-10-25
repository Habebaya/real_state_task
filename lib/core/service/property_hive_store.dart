// core/service/property_hive_store.dart
import 'package:hive/hive.dart';

import '../../feature/explore/data/model/property_data_model.dart';

class PropertyHiveStore {
  static const String boxName = 'property_items';

  Box get _box => Hive.box(boxName);

  Future<void> putProperty(PropertyItem item) async {
    await _box.put(item.id, Map<String, dynamic>.from(item.toJson()));
  }

  List<PropertyItem> getAll() {
    return _box.values.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return PropertyItem.fromJson(map);
    }).toList();
  }

  Future<void> deleteById(int id) async => _box.delete(id);

  Future<void> clear() async => _box.clear();
}

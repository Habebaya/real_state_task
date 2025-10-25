import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

class PropertyType {
  final int id;
  final String name;
  final int? manualRanking;

  PropertyType({required this.id, required this.name, this.manualRanking});

  factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
    id: asInt(json['id']),
    name: json['name'] as String? ?? '',
    manualRanking: asInt(json['manual_ranking']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'manual_ranking': manualRanking,
  };
}

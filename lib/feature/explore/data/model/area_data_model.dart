import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

class Area {
  final int id;
  final String name;

  Area({required this.id, required this.name});

  factory Area.fromJson(Map<String, dynamic> json) =>
      Area(id: asInt(json['id']), name: json['name'] as String? ?? '');

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

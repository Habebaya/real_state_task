import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

class Developer {
  final int id;
  final String name;
  final String slug;
  final String? logoPath;

  Developer({
    required this.id,
    required this.name,
    required this.slug,
    this.logoPath,
  });

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
    id: asInt(json['id']),
    name: json['name'] as String? ?? '',
    slug: json['slug'] as String? ?? '',
    logoPath: json['logo_path'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'logo_path': logoPath,
  };
}

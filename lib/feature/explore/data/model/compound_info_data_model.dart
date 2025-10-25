import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

class Compound {
  final int id;
  final double? lat;
  final double? long;
  final String name;
  final String slug;
  final int? sponsored;
  final int? nawyOrganizationId;

  Compound({
    required this.id,
    this.lat,
    this.long,
    required this.name,
    required this.slug,
    this.sponsored,
    this.nawyOrganizationId,
  });

  factory Compound.fromJson(Map<String, dynamic> json) => Compound(
    id: asInt(json['id']),
    lat: asDouble(json['lat']),
    long: asDouble(json['long']),
    name: json['name'] as String? ?? '',
    slug: json['slug'] as String? ?? '',
    sponsored: asInt(json['sponsored']),
    nawyOrganizationId: asInt(json['nawy_organization_id']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'lat': lat,
    'long': long,
    'name': name,
    'slug': slug,
    'sponsored': sponsored,
    'nawy_organization_id': nawyOrganizationId,
  };
}

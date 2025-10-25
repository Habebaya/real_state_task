// feature/explore/data/model/compound_data_model.dart

import 'package:nawy_real_state/feature/explore/data/model/location_data_model.dart';

class CompoundDataModel {
  final int id;
  final int areaId;
  final int developerId;
  final String name;
  final String slug;
  final DateTime? updatedAt;
  final String imagePath;
  final int nawyOrganizationId;
  final bool hasOffers;
  final LocationModel? area;

  const CompoundDataModel({
    required this.id,
    required this.areaId,
    required this.developerId,
    required this.name,
    required this.slug,
    required this.updatedAt,
    required this.imagePath,
    required this.nawyOrganizationId,
    required this.hasOffers,
    required this.area,
  });

  factory CompoundDataModel.fromJson(Map<String, dynamic> json) {
    return CompoundDataModel(
      id: (json['id'] ?? 0) as int,
      areaId: (json['area_id'] ?? 0) as int,
      developerId: (json['developer_id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      slug: (json['slug'] ?? '') as String,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      imagePath: (json['image_path'] ?? '') as String,
      nawyOrganizationId: (json['nawy_organization_id'] ?? 0) as int,
      hasOffers: (json['has_offers'] ?? false) as bool,
      area: json['area'] is Map<String, dynamic>
          ? LocationModel.fromJson(json['area'] as Map<String, dynamic>)
          : null,
    );
  }
}

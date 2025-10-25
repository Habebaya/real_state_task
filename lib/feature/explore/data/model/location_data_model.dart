class LocationModel {
  final int? id;
  final String? name;
  final String? imagePath;

  // final AllSlugs allSlugs;

  const LocationModel({
    this.id,
    this.name,
    this.imagePath = "",
    // required this.allSlugs,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      // slug: json['slug'] as String,
      // allSlugs: AllSlugs.fromJson(json['all_slugs'] as Map<String, dynamic>),
    );
  }
}

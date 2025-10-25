class SeoBacklink {
  final String name;
  final String slug;

  SeoBacklink({required this.name, required this.slug});

  factory SeoBacklink.fromJson(Map<String, dynamic> json) => SeoBacklink(
    name: json['name'] as String? ?? '',
    slug: json['slug'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {'name': name, 'slug': slug};
}

// Root response
import 'package:nawy_real_state/feature/explore/data/model/property_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_type_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/sea_back_link_data_model.dart';

class SearchResponse {
  final int totalCompounds;
  final int totalProperties;
  final int totalPropertyGroups;
  final List<PropertyType> propertyTypes;
  final List<PropertyItem> values;
  final List<SeoBacklink> seoBacklinks;

  SearchResponse({
    required this.totalCompounds,
    required this.totalProperties,
    required this.totalPropertyGroups,
    required this.propertyTypes,
    required this.values,
    required this.seoBacklinks,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      totalCompounds: asInt(json['total_compounds']),
      totalProperties: asInt(json['total_properties']),
      totalPropertyGroups: asInt(json['total_property_groups']),
      propertyTypes: (json['property_types'] as List? ?? [])
          .map((e) => PropertyType.fromJson(e as Map<String, dynamic>))
          .toList(),
      values: (json['values'] as List? ?? [])
          .map((e) => PropertyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      seoBacklinks: (json['seo_backlinks'] as List? ?? [])
          .map((e) => SeoBacklink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'total_compounds': totalCompounds,
    'total_properties': totalProperties,
    'total_property_groups': totalPropertyGroups,
    'property_types': propertyTypes.map((e) => e.toJson()).toList(),
    'values': values.map((e) => e.toJson()).toList(),
    'seo_backlinks': seoBacklinks.map((e) => e.toJson()).toList(),
  };
}

/// ----------------------
/// Helpers (type coercion)
/// ----------------------

int asInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) {
    final x = int.tryParse(v);
    if (x != null) return x;
    final d = double.tryParse(v);
    if (d != null) return d.toInt();
  }
  return 0;
}

double? asDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

bool? asBool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v != 0;
  if (v is String) {
    final s = v.toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
  }
  return null;
}

String? asString(dynamic v) {
  if (v == null) return null;
  return v.toString();
}

DateTime? asDate(dynamic v) {
  if (v == null) return null;
  final s = v.toString();
  try {
    return DateTime.parse(s); // expects "YYYY-MM-DD"
  } catch (_) {
    return null;
  }
}

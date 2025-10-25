import 'package:nawy_real_state/feature/explore/data/model/property_type_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/search_model.dart'
    show asInt, asString, asBool, asDate;

import 'area_data_model.dart';
import 'compound_info_data_model.dart';
import 'developer_data_model.dart';

class PropertyItem {
  final int id;
  final String slug;
  final String name;
  final PropertyType propertyType;
  final Compound compound;
  final Area area;
  final Developer developer;
  final String? image;
  final String? finishing;
  final int? minUnitArea;
  final int? maxUnitArea;
  final int? minPrice;
  final int? maxPrice;
  final String? currency;
  final int? maxInstallmentYears;
  final String? maxInstallmentYearsMonths; // can be "8.0"
  final int? minInstallments;
  final int? minDownPayment;
  final int? numberOfBathrooms;
  final int? numberOfBedrooms;
  final DateTime? minReadyBy; // "YYYY-MM-DD"
  final int? sponsored;
  final bool? newProperty;
  final String? company;
  final bool? resale;
  final bool? financing;
  final String? type;
  final bool? hasOffers;
  final String? offerTitle;
  final bool? limitedTimeOffer;
  final bool? isCash;
  final String? installmentType;
  final int? inQuickSearch;
  final dynamic recommended; // unknown type in sample
  final int? manualRanking;
  final int? completenessScore;
  final bool? favorite;
  final String? rankingType;
  final int? recommendedFinancing;
  final int? propertyRanking;
  final int? compoundRanking;
  final List<String> tags;

  PropertyItem({
    required this.id,
    required this.slug,
    required this.name,
    required this.propertyType,
    required this.compound,
    required this.area,
    required this.developer,
    this.image,
    this.finishing,
    this.minUnitArea,
    this.maxUnitArea,
    this.minPrice,
    this.maxPrice,
    this.currency,
    this.maxInstallmentYears,
    this.maxInstallmentYearsMonths,
    this.minInstallments,
    this.minDownPayment,
    this.numberOfBathrooms,
    this.numberOfBedrooms,
    this.minReadyBy,
    this.sponsored,
    this.newProperty,
    this.company,
    this.resale,
    this.financing,
    this.type,
    this.hasOffers,
    this.offerTitle,
    this.limitedTimeOffer,
    this.isCash,
    this.installmentType,
    this.inQuickSearch,
    this.recommended,
    this.manualRanking,
    this.completenessScore,
    this.favorite,
    this.rankingType,
    this.recommendedFinancing,
    this.propertyRanking,
    this.compoundRanking,
    required this.tags,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: asInt(json['id']),
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      propertyType: PropertyType.fromJson(json['property_type']),
      compound: Compound.fromJson(json['compound'] as Map<String, dynamic>),
      area: Area.fromJson(json['area'] as Map<String, dynamic>),
      developer: Developer.fromJson(json['developer'] as Map<String, dynamic>),
      image: json['image'] as String?,
      finishing: json['finishing'] as String?,
      minUnitArea: asInt(json['min_unit_area']),
      maxUnitArea: asInt(json['max_unit_area']),
      minPrice: asInt(json['min_price']),
      maxPrice: asInt(json['max_price']),
      currency: json['currency'] as String?,
      maxInstallmentYears: asInt(json['max_installment_years']),
      maxInstallmentYearsMonths: asString(json['max_installment_years_months']),
      minInstallments: asInt(json['min_installments']),
      minDownPayment: asInt(json['min_down_payment']),
      numberOfBathrooms: asInt(json['number_of_bathrooms']),
      numberOfBedrooms: asInt(json['number_of_bedrooms']),
      minReadyBy: asDate(json['min_ready_by']),
      sponsored: asInt(json['sponsored']),
      newProperty: asBool(json['new_property']),
      company: json['company'] as String?,
      resale: asBool(json['resale']),
      financing: asBool(json['financing']),
      type: json['type'] as String?,
      hasOffers: asBool(json['has_offers']),
      offerTitle: json['offer_title'] as String?,
      limitedTimeOffer: asBool(json['limited_time_offer']),
      isCash: asBool(json['is_cash']),
      installmentType: json['installment_type'] as String?,
      inQuickSearch: asInt(json['in_quick_search']),
      recommended: json['recommended'],
      manualRanking: asInt(json['manual_ranking']),
      completenessScore: asInt(json['completeness_score']),
      favorite: asBool(json['favorite']),
      rankingType: json['ranking_type'] as String?,
      recommendedFinancing: asInt(json['recommended_financing']),
      propertyRanking: asInt(json['property_ranking']),
      compoundRanking: asInt(json['compound_ranking']),
      tags: (json['tags'] as List? ?? []).map((e) => '$e').toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'slug': slug,
    'name': name,
    'property_type': propertyType.toJson(),
    'compound': compound.toJson(),
    'area': area.toJson(),
    'developer': developer.toJson(),
    'image': image,
    'finishing': finishing,
    'min_unit_area': minUnitArea,
    'max_unit_area': maxUnitArea,
    'min_price': minPrice,
    'max_price': maxPrice,
    'currency': currency,
    'max_installment_years': maxInstallmentYears,
    'max_installment_years_months': maxInstallmentYearsMonths,
    'min_installments': minInstallments,
    'min_down_payment': minDownPayment,
    'number_of_bathrooms': numberOfBathrooms,
    'number_of_bedrooms': numberOfBedrooms,
    'min_ready_by': minReadyBy?.toIso8601String().split('T').first,
    'sponsored': sponsored,
    'new_property': newProperty,
    'company': company,
    'resale': resale,
    'financing': financing,
    'type': type,
    'has_offers': hasOffers,
    'offer_title': offerTitle,
    'limited_time_offer': limitedTimeOffer,
    'is_cash': isCash,
    'installment_type': installmentType,
    'in_quick_search': inQuickSearch,
    'recommended': recommended,
    'manual_ranking': manualRanking,
    'completeness_score': completenessScore,
    'favorite': favorite,
    'ranking_type': rankingType,
    'recommended_financing': recommendedFinancing,
    'property_ranking': propertyRanking,
    'compound_ranking': compoundRanking,
    'tags': tags,
  };
}

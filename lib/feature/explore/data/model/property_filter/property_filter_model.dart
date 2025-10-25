class PropertyFilterModel {
  int? minBedrooms;
  int? maxBedrooms;
  List<double>? priceList;
  List<double>? minPriceList;
  List<double>? maxPriceList;

  PropertyFilterModel({
    this.minBedrooms,
    this.maxBedrooms,
    this.priceList,
    this.minPriceList,
    this.maxPriceList,
  });

  factory PropertyFilterModel.fromJson(Map<String, dynamic> json) {
    return PropertyFilterModel(
      minBedrooms: json['min_bedrooms'],
      maxBedrooms: json['max_bedrooms'],
      priceList: (json['price_list'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      minPriceList: (json['min_price_list'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      maxPriceList: (json['max_price_list'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (minBedrooms != null) data['min_bedrooms'] = minBedrooms;
    if (maxBedrooms != null) data['max_bedrooms'] = maxBedrooms;
    if (priceList != null) data['price_list'] = priceList;
    if (minPriceList != null) data['min_price_list'] = minPriceList;
    if (maxPriceList != null) data['max_price_list'] = maxPriceList;
    return data;
  }
}

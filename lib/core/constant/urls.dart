class Urls {
  Urls._();

  static const String testUrl =
      "https://hiring-tasks.github.io/mobile-app-apis";

  static String baseUrl = testUrl;

  static String get compoundEndpoint => '$baseUrl/compounds.json';

  static String get areaEndPoint => '$baseUrl/areas.json';

  static String get propertiesFilterEndpoint =>
      '$baseUrl/properties-get-filter-options.json';

  static String get propertiesSearchEndpoint =>
      '$baseUrl/properties-search.json';
}

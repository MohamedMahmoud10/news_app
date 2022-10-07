import 'package:news_app/data_layer/api_services/api_services.dart';
import 'package:news_app/models/news_models.dart';

class Repositry {
  final ApiServices apiServices;

  Repositry(this.apiServices);

  Future<List<Articles>> getNewsData() async {
    var result = await apiServices.getNewsData('v2/top-headlines', {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'c4f871156b52488ca8244eeaeabe7160',
    });
    List<Articles> mappingData =
        result.map((news) => Articles.fromJson(news)).toList();
    return mappingData;
  }

  Future<List<Articles>> getNewsSportData() async {
    var result = await apiServices.getNewsData('v2/top-headlines', {
      'country': 'eg',
      'category': 'sport',
      'apiKey': 'c4f871156b52488ca8244eeaeabe7160',
    });
    List<Articles> mappingData =
        result.map((news) => Articles.fromJson(news)).toList();
    return mappingData;
  }

  Future<List<Articles>> getNewsScienceData() async {
    var result = await apiServices.getNewsData('v2/top-headlines', {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'c4f871156b52488ca8244eeaeabe7160',
    });
    List<Articles> mappingData =
        result.map((news) => Articles.fromJson(news)).toList();
    return mappingData;
  }

  Future<List<Articles>> getNewsSearchData(String value) async {
    var result = await apiServices.getNewsData('v2/top-headlines', {
      'q': '${value}',
      'apiKey': 'c4f871156b52488ca8244eeaeabe7160',
    });
    List<Articles> mappingData =
        result.map((news) => Articles.fromJson(news)).toList();
    return mappingData;
  }
}

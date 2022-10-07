import 'package:news_app/models/news_models.dart';

abstract class NewsStates {}

class NewsInitial extends NewsStates {}

class NewsLoadingData extends NewsStates {}

class NewsLoadingDataSuccess extends NewsStates {
  final List<Articles> articlesList;

  NewsLoadingDataSuccess(this.articlesList);
}

class NewsLoadingDataFailure extends NewsStates {}

class NewsLoadingSportData extends NewsStates {}

class NewsLoadingSportDataSuccess extends NewsStates {
  final List<Articles> articlesList;

  NewsLoadingSportDataSuccess(this.articlesList);
}

class NewsLoadingSportDataFailure extends NewsStates {}

class NewsLoadingScienceData extends NewsStates {}

class NewsLoadingScienceDataSuccess extends NewsStates {
  final List<Articles> articlesList;

  NewsLoadingScienceDataSuccess(this.articlesList);
}

class NewsLoadingScienceDataFailure extends NewsStates {}

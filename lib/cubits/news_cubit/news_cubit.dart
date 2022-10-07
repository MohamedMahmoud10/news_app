import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/news_cubit/news_state.dart';
import 'package:news_app/data_layer/repositry/repositry.dart';

import '../../models/news_models.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit(this.repositry) : super(NewsInitial());
  final Repositry repositry;

  static NewsCubit get(context) => BlocProvider.of(context);
  List<Articles> articlesList = [];
  Future<void> getAllArticles() async {
    emit(NewsLoadingData());
    try {
      articlesList = await repositry.getNewsData();
      emit(NewsLoadingDataSuccess(articlesList));
    } on Exception catch (e) {
      log(e.toString());
      emit(NewsLoadingDataFailure());
    }
  }

  List<Articles> sportArticlesList = [];

  List<Articles> getAllSportArticles() {
    emit(NewsLoadingSportData());
    try {
      repositry.getNewsSportData().then((sports) {
        emit(NewsLoadingSportDataSuccess(sports));
        sportArticlesList = sports;
      });
      return sportArticlesList;
    } on Exception catch (e) {
      log(e.toString());
      emit(NewsLoadingSportDataFailure());
      return sportArticlesList;
    }
  }

  List<Articles> scienceArticlesList = [];

  List<Articles> getAllScienceArticles() {
    emit(NewsLoadingScienceData());
    try {
      repositry.getNewsScienceData().then((science) {
        emit(NewsLoadingScienceDataSuccess(science));
        scienceArticlesList = science;
      });
      return scienceArticlesList;
    } on Exception catch (e) {
      log(e.toString());
      emit(NewsLoadingScienceDataFailure());
      return scienceArticlesList;
    }
  }
}

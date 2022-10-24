import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/bottom_nav_bar/bottom_nav_bar_states.dart';

import '../../data_layer/api_services/api_services.dart';
import '../../data_layer/repositry/repositry.dart';
import '../../presntion_layer/screens/business_screen/business_screen.dart';
import '../../presntion_layer/screens/science_screen/science_screen.dart';
import '../../presntion_layer/screens/settings_screen/settings_screen.dart';
import '../../presntion_layer/screens/sports_screen/sports_screen.dart';
import '../news_cubit/news_cubit.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit() : super(BottomNavBarInitial());
  int curentIndex = 0;
  static BottomNavBarCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center_rounded), label: 'Business'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_soccer_rounded), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];
  void changeNavBarItems(int index) {
    curentIndex = index;
    if (index == 1) {
      NewsCubit(Repositry(ApiServices())).getAllSportArticles();
    }
    if (index == 2) {
      NewsCubit(Repositry(ApiServices())).getAllScienceArticles();
    }
    emit(BottomNavBarChangeState());
  }
}

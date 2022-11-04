import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/theme_toggle/theme_toggle .dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());

  static DarkModeCubit get(context) => BlocProvider.of(context);

  bool isDarkMode = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(DarkModeSuccessState());
    } else {
      isDarkMode = !isDarkMode;
      ThemeToggle.putBoolean(key: 'isDarkMode', value: isDarkMode)
          .then((value) {
        emit(DarkModeSuccessState());
      });
    }
  }
}

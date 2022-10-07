import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/theme_toggle/theme_toggle .dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());
  bool isDark = false;

  static DarkModeCubit get(context) => BlocProvider.of(context);

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(DarkModeSuccessState());
    } else {
      ThemeToggle.setBool(key: 'isDark', value: isDark).then((value) {
        isDark = !isDark;
        emit(DarkModeSuccessState());
      });
    }
  }
}

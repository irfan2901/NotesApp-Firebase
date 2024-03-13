import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeLoadedState> {
  ThemeCubit() : super(ThemeLoadedState(false)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeLoadedState(isDark));
  }

  toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = !state.isDark;
    await prefs.setBool('isDark', isDark);
    emit(ThemeLoadedState(isDark));
  }
}

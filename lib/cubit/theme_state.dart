part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class ThemeLoadedState {
  final bool isDark;

  ThemeLoadedState(this.isDark);
}

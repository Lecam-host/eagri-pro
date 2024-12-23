import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/theme_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeTheme>((event, emit) async {
      ThemeService.setTheme(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark);
      emit(ThemeState(
          useDeviceTheme: event.useDeviceTheme, isDark: event.isDark));
    });
  }
}

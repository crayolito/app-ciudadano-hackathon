import 'package:app_hackaton/config/constant/data.const.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<OnChangedViewInfo>((event, emit) {
      emit(state.copyWith(viewWindowInfo: !state.viewWindowInfo));
    });

    on<OnChangedServicioPublico>((event, emit) {
      emit(state.copyWith(servicioPublico: event.servicioPublico));
    });

    on<OnCleanBlocAuth>((event, emit) {
      emit(state.copyWith(
        viewWindowInfo: false,
      ));
    });
  }
}

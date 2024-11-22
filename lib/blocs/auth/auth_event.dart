part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnChangedViewInfo extends AuthEvent {
  const OnChangedViewInfo();
}

class OnChangedServicioPublico extends AuthEvent {
  final ServicioPublico servicioPublico;

  const OnChangedServicioPublico(this.servicioPublico);
}

class OnCleanBlocAuth extends AuthEvent {
  const OnCleanBlocAuth();
}

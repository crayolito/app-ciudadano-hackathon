part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool viewWindowInfo;
  final ServicioPublico? servicioPublico;

  const AuthState({
    this.viewWindowInfo = false,
    this.servicioPublico,
  });

  AuthState copyWith({
    bool? viewWindowInfo,
    ServicioPublico? servicioPublico,
  }) {
    return AuthState(
      viewWindowInfo: viewWindowInfo ?? this.viewWindowInfo,
      servicioPublico: servicioPublico ?? this.servicioPublico,
    );
  }

  @override
  List<Object?> get props => [
        viewWindowInfo,
        servicioPublico,
      ];
}

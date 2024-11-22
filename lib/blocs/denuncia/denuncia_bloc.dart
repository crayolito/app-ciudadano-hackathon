import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'denuncia_event.dart';
part 'denuncia_state.dart';

class DenunciaBloc extends Bloc<DenunciaEvent, DenunciaState> {
  DenunciaBloc() : super(DenunciaInitial()) {
    on<DenunciaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

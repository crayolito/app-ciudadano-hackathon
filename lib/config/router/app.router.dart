import 'package:app_hackaton/features/auth/presentation/screens/auth.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/alerta/detalle-alerta.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/alerta/generar-alerta.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/alerta/lista-alertas.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/audio-text.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/dashboard.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/denuncia/detalle-denuncia.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/denuncia/generar-denuncia.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/denuncia/lista-denuncias.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/informacion/lista-informativos.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/mapa/map-google.screen.dart';
import 'package:app_hackaton/features/mapbox/presentation/screens/map-box.screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => const AuthScreen()),
  GoRoute(
      path: '/dashboard', builder: (context, state) => const DashBoardScreen()),
  GoRoute(
      path: '/generar-denuncia',
      builder: (context, state) => const GenerarDenunciaScreen()),
  GoRoute(
      path: '/lista-denuncias',
      builder: (context, state) => const DenunciasScreen()),
  GoRoute(
      path: '/perfil', builder: (context, state) => const DenunciasScreen()),
  GoRoute(
      path: '/detalle-denuncia',
      builder: (context, state) => const DetalleDenunciaScreen()),
  GoRoute(
      path: '/mapGoogle', builder: (context, state) => const MapGoogleScreen()),
  GoRoute(path: '/mapBox', builder: (context, state) => const MapBoxCustom()),
  GoRoute(
      path: '/generar-alerta',
      builder: (context, state) => const GenerarAlertaScreen()),
  GoRoute(
      path: '/lista-alertas',
      builder: (context, state) => const ListaAlertasScreen()),
  GoRoute(
      path: '/detalle-alerta',
      builder: (context, state) => const DetalleAlertaScreen()),
  GoRoute(
    path: '/audio-to-text',
    builder: (context, state) => const AudioToTextScreen(),
  ),
  GoRoute(
    path: '/lista-informativos',
    builder: (context, state) => const ListaInformativoScreen(),
  ),
  // GoRoute(
  //     path: '/provincional', builder: (context, state) => const GuidoMamon()),
]);

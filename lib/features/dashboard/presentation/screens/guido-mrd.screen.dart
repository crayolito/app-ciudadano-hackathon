import 'package:app_hackaton/blocs/permissions/permissions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa el paquete para usar el portapapeles
import 'package:flutter_bloc/flutter_bloc.dart';

class GuidoMamon extends StatefulWidget {
  const GuidoMamon({super.key});

  @override
  State<GuidoMamon> createState() => _GuidoMamonState();
}

class _GuidoMamonState extends State<GuidoMamon> {
  String token = "Presiona el botón";

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final permissionsBloc = BlocProvider.of<PermissionsBloc>(context);
    await permissionsBloc.askGpsAccess();
    await permissionsBloc.requestPermissions();
    final newToken = await permissionsBloc.getFCMTokenProvisional();
    setState(() {
      token = newToken ?? "No se pudo obtener el token";
    });
  }

  @override
  Widget build(BuildContext context) {
    final permissionBloc = BlocProvider.of<PermissionsBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tu token móvil de notificaciones"),
            Text(token),
            IconButton.filled(
              onPressed: () async {
                await _copyToClipboard();
              },
              icon: const Icon(Icons.insert_drive_file_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: token));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Token copiado al portapapeles')),
    );
  }
}

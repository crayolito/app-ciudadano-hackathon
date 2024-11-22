import 'package:app_hackaton/config/constant/original.const.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class GenerarAlertaScreen extends StatefulWidget {
  const GenerarAlertaScreen({super.key});

  @override
  State<GenerarAlertaScreen> createState() => _GenerarAlertaScreenState();
}

class _GenerarAlertaScreenState extends State<GenerarAlertaScreen> {
  TextEditingController? _controller = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String? _typeDenuncia;
  String _text = 'Presiona el botón y habla...';
  final List<String> _denuncias = [
    "Incendios",
    "Fallos de Alumbrado Público",
    "Incidentes en Vía Pública",
    "Falencias en Servicios Públicos",
    "Que tipo de alerta?"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
    _typeDenuncia = _denuncias[4];
  }

  void _initSpeech() async {
    // Solicitar permiso de micrófono
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print('Permiso de micrófono denegado');
      return;
    }

    var speechEnabled = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (!speechEnabled) {
      print('Speech no está disponible en este dispositivo');
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('status: $status'),
        onError: (errorNotification) => print('error: $errorNotification'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords;
            _controller!.text = _text;
          }),
          localeId: 'es_ES', // Para español
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://estaticos-noticias.unitel.bo/binrepository/1024x577/0c0/1024d512/none/125450566/PSTO/imagen-863d972f-1667-48fd-883a-06985a340832_101-7532206_20231117164959.jpg"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  top: size.height * 0.038,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.01,
                    ),
                    height: size.height * 0.06,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.016,
                                vertical: size.height * 0.005),
                            height: size.height * 0.06,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kTerciaryColor.withOpacity(0.4)),
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.13,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSecondaryColor.withOpacity(0.9)),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: kPrimaryColor,
                                size: size.width * 0.07,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.016,
                                vertical: size.height * 0.005),
                            height: size.height * 0.06,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kTerciaryColor.withOpacity(0.4)),
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.13,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kSecondaryColor.withOpacity(0.9)),
                              child: Icon(
                                Icons.list_rounded,
                                color: kPrimaryColor,
                                size: size.width * 0.07,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  top: size.height * 0.35,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.015,
                    ),
                    height: size.height * 0.65,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: kPrimaryColor,
                          width: size.width * 0.02,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.08),
                        topRight: Radius.circular(size.width * 0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Generar Alerta",
                          style: letterStyle.letra1GD,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02),
                            border: Border.all(
                                color: kPrimaryColor,
                                width: size.width * 0.006),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                offset: const Offset(0, 5),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.23),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.025),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _typeDenuncia,
                              items: _denuncias
                                  .map((denuncia) => DropdownMenuItem<String>(
                                        value: denuncia,
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   border: Border(
                                          //     bottom: BorderSide(
                                          //       color: kTerciaryColor
                                          //           .withOpacity(0.5),
                                          //       width: size.width * 0.005,
                                          //     ),
                                          //   ),
                                          // ),
                                          padding: EdgeInsets.only(
                                              bottom: size.height * 0.001),
                                          child: Text(
                                            denuncia,
                                            style: letterStyle.letra2GD,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _typeDenuncia = value;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kTerciaryColor,
                                size: size.width * 0.08,
                              ),
                              dropdownColor: Colors.white,
                              isExpanded: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          "Detalles",
                          style: letterStyle.letra1GD,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.025,
                              vertical: size.height * 0.01),
                          height: size.height * 0.29,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.02),
                            border: Border.all(
                                color: kPrimaryColor,
                                width: size.width * 0.006),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                offset: const Offset(0, 5),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.23),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _controller,
                            maxLines: 5,
                            style: letterStyle.letra2GD,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText:
                                  "Escribe aquí los detalles de la denuncia",
                              hintStyle: letterStyle.letra2GD,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: Icon(Icons.camera_alt_rounded,
                                      color: kSecondaryColor,
                                      size: size.width * 0.08),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: Icon(Icons.photo_library,
                                      color: kSecondaryColor,
                                      size: size.width * 0.08),
                                ),
                              ),
                              GestureDetector(
                                onTap: _listen,
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: _isListening
                                        ? kCuartoColor
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: Icon(
                                      _isListening ? Icons.mic_off : Icons.mic,
                                      color: _isListening
                                          ? kPrimaryColor
                                          : kSecondaryColor,
                                      size: size.width * 0.08),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: Icon(Icons.save_outlined,
                                      color: kSecondaryColor,
                                      size: size.width * 0.08),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _controller!.clear();
                                  setState(() {
                                    _typeDenuncia = _denuncias[4];
                                  });
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: Icon(Icons.clear,
                                      color: kSecondaryColor,
                                      size: size.width * 0.08),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

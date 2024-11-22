import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AudioToTextScreen extends StatefulWidget {
  const AudioToTextScreen({super.key});

  @override
  State<AudioToTextScreen> createState() => _AudioToTextScreenState();
}

class _AudioToTextScreenState extends State<AudioToTextScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Presiona el botón y habla...';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
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
            if (result.hasConfidenceRating && result.confidence > 0) {
              _confidence = result.confidence;
            }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Audio a Texto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Nivel de confianza: ${(_confidence * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _listen,
              icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
              label: Text(_isListening ? 'Detener' : 'Escuchar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isListening ? Colors.red : Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

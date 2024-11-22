import 'package:animate_do/animate_do.dart';
import 'package:app_hackaton/blocs/permissions/permissions_bloc.dart';
import 'package:app_hackaton/config/constant/original.const.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool viewFormInit = true;

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final permissionsBloc = BlocProvider.of<PermissionsBloc>(context);
    await permissionsBloc.requestPermissions();
    await permissionsBloc.askGpsAccess();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(size.width * 0.07),
        bottomRight: Radius.circular(size.width * 0.07),
      ),
      image: const DecorationImage(
        image: AssetImage("assets/fondo1.jpg"),
        fit: BoxFit.cover,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.3),
          offset: Offset(0, 19),
          blurRadius: 38,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.22),
          offset: Offset(0, 15),
          blurRadius: 12,
        ),
      ],
    );

    final decoration2 = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(size.width * 0.04)),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          offset: Offset(0, 4),
          blurRadius: 2,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          offset: Offset(0, 8),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          offset: Offset(0, 16),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          offset: Offset(0, 32),
          blurRadius: 20,
        ),
      ],
    );

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Stack(
          children: [
            // READ : FONDO DE PANTALLA
            Container(
              height: size.height * 0.65,
              width: size.width,
              decoration: decoration,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(size.width * 0.07),
                        bottomRight: Radius.circular(size.width * 0.07),
                      ),
                      color: Colors.black.withOpacity(0.4))),
            ),
            Positioned(
                top: size.height * 0.09,
                child: Container(
                  width: size.width,
                  height: size.height * 0.15,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/SantaCruz-logo2.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            // READ : TITULO
            // Positioned(
            //     top: size.height * 0.11,
            //     child: SizedBox(
            //       width: size.width,
            //       child: Text(
            //         "SANTA CRUZ DE LA SIERRA",
            //         maxLines: 2,
            //         textAlign: TextAlign.center,
            //         style: letterStyle.titulo,
            //       ),
            //     )),
            Positioned(
                top: size.height * 0.28,
                left: size.width * 0.04,
                right: size.width * 0.04,
                child: SizedBox(
                  width: size.width,
                  child: Text(
                    "Innovando para un futuro urbano sostenible.",
                    textAlign: TextAlign.center,
                    style: letterStyle.titulo2,
                  ),
                )),
            Positioned(
                top: size.height * 0.45,
                left: size.width * 0.04,
                right: size.width * 0.04,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.01),
                  height: size.height * 0.5,
                  width: size.width,
                  decoration: decoration2,
                  child: viewFormInit
                      ? FormCustomInit(
                          onTap: () {
                            setState(() {
                              viewFormInit = !viewFormInit;
                            });
                          },
                        )
                      : FormCustomRegistre(
                          onTap: () {
                            setState(() {
                              viewFormInit = !viewFormInit;
                            });
                          },
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class FormCustomRegistre extends StatelessWidget {
  const FormCustomRegistre({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeIn(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          Text(
            "Regístrate",
            style: letterStyle.tituloAuthInit,
          ),
          SizedBox(height: size.height * 0.01),
          TextFormFieldAuth(
              placeholder: "Carnet Identidad",
              icon: Icons.account_box,
              color: kPrimaryColor,
              keyboardType: TextInputType.number,
              onChanged: (String value) {}),
          SizedBox(height: size.height * 0.02),
          TextFormFieldAuth(
              placeholder: "Contraseña",
              icon: Icons.password,
              color: kPrimaryColor,
              keyboardType: TextInputType.number,
              onChanged: (String value) {}),
          SizedBox(height: size.height * 0.02),
          TextFormFieldAuth(
              placeholder: "Telefono",
              icon: Icons.phone,
              color: kPrimaryColor,
              keyboardType: TextInputType.number,
              onChanged: (String value) {}),
          SizedBox(height: size.height * 0.02),
          GestureDetector(
              onTap: () {},
              child: IntrinsicWidth(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.012,
                    horizontal: size.width * 0.035,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(size.width * 0.015),
                  ),
                  child: Text(
                    "Guardar",
                    style: letterStyle.letraButtonForm,
                  ),
                ),
              )),
          SizedBox(height: size.height * 0.04),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "¿Ya tienes una cuenta?\n",
                  style: letterStyle.letraMessageForm,
                ),
                TextSpan(
                  text: "¡Inicia sesión aquí!",
                  style: letterStyle.letraMessageForm2,
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormCustomInit extends StatelessWidget {
  const FormCustomInit({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            "Iniciar Sesión",
            style: letterStyle.tituloAuthInit,
          ),
          SizedBox(height: size.height * 0.03),
          TextFormFieldAuth(
              placeholder: "Carnet Identidad",
              icon: Icons.account_box,
              color: kPrimaryColor,
              keyboardType: TextInputType.number,
              onChanged: (String value) {}),
          SizedBox(height: size.height * 0.03),
          TextFormFieldAuth(
              placeholder: "Contraseña",
              icon: Icons.password,
              color: kPrimaryColor,
              keyboardType: TextInputType.number,
              onChanged: (String value) {}),
          SizedBox(height: size.height * 0.03),
          GestureDetector(
            onTap: () {
              context.push("/dashboard");
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.012,
                  horizontal: size.width * 0.035),
              width: size.width * 0.36,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(size.width * 0.015)),
              child: Text(
                "Ingresar",
                style: letterStyle.letraButtonForm,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.075),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "¿Estás registrado?\n",
                  style: letterStyle.letraMessageForm,
                ),
                TextSpan(
                  text: "¡Puedes registrarte aquí!",
                  style: letterStyle.letraMessageForm2,
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormFieldAuth extends StatelessWidget {
  const TextFormFieldAuth({
    super.key,
    required this.placeholder,
    required this.icon,
    required this.color,
    required this.keyboardType,
    required this.onChanged,
    this.obscureText = false,
  });

  final bool? obscureText;
  final String placeholder;
  final IconData icon;
  final Color color;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final decoration = InputDecoration(
        labelText: placeholder,
        labelStyle: letterStyle.placeholderInputAuth,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: kTerciaryColor.withOpacity(0.2), width: 2),
          borderRadius: BorderRadius.circular(size.width * 0.016),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.5),
          borderRadius: BorderRadius.circular(size.width * 0.016),
        ),
        focusColor: kPrimaryColor,
        prefixIcon: Icon(
          color: color,
          icon,
          size: size.width * 0.065,
        ),
        isDense: true);

    return TextFormField(
      obscureText: obscureText!,
      cursorColor: kSecondaryColor,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: letterStyle.placeholderInputAuth,
      decoration: decoration,
    );
  }
}

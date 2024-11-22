import 'package:animate_do/animate_do.dart';
import 'package:app_hackaton/config/constant/estilosLetras.constant.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:app_hackaton/features/common/interafaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DenunciasScreen extends StatelessWidget {
  const DenunciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
                top: size.height * 0.16,
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.84,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: size.height * 0.045,
                      ),
                      itemCount: denuncias.length,
                      itemBuilder: (context, index) {
                        Denuncia denuncia = denuncias[index];

                        return FadeIn(
                          animate: true,
                          duration: const Duration(milliseconds: 500),
                          child: GestureDetector(
                            onTap: () {
                              context.push("/detalle-denuncia");
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: size.width * 0.02,
                              ),
                              width: size.width,
                              height: size.height * 0.15,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.01,
                                      vertical: size.height * 0.01,
                                    ),
                                    width: size.width * 0.18,
                                    height: size.height * 0.12,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    denuncia.iconUrl),
                                                fit: BoxFit.contain))),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.015,
                                      bottom: size.height * 0.015,
                                      right: size.height * 0.015,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                    ),
                                    width: size.width * 0.77,
                                    height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: kTerciaryColor.withOpacity(0.2),
                                        width: size.width * 0.005,
                                      ),
                                    )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          denuncia.descripcion,
                                          style: LetterStyle(context).letra3DS,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(denuncia.fecha,
                                            style: LetterStyle(context).letra4DS,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        Text(
                                            "Paso a ${denuncia.distancia} de ti",
                                            style: LetterStyle(context).letra5DS,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )),
            Positioned(
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.025,
                  ),
                  width: size.width,
                  height: size.height * 0.16,
                  color: kTerciaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: kPrimaryColor,
                          size: size.width * 0.08,
                        ),
                      ),
                      Text(
                        "ALERTA SOCIAL",
                        style: LetterStyle(context).letra1DS,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/generar-denuncia");
                        },
                        child: Icon(
                          FontAwesomeIcons.bullhorn,
                          color: kPrimaryColor,
                          size: size.width * 0.08,
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: size.height * 0.12,
                right: size.width * 0.05,
                left: size.width * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      // border: Border.all(
                      //     color: kPrimaryColor, width: size.width * 0.005),
                      borderRadius: BorderRadius.circular(size.width * 0.015),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.19),
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.23),
                          offset: Offset(0, 6),
                          blurRadius: 6,
                        ),
                      ]),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: kPrimaryColor,
                        size: size.width * 0.07,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.01),
                        width: size.width * 0.69,
                        child: TextFormField(
                          controller: _controller,
                          style: LetterStyle(context).letra2DS,
                          decoration: InputDecoration(
                            hintText: "Buscar ...",
                            hintStyle: LetterStyle(context).letra2DS,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.clear,
                        color: kPrimaryColor,
                        size: size.width * 0.07,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

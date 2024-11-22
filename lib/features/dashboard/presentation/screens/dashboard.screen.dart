import 'package:animate_do/animate_do.dart';
import 'package:app_hackaton/blocs/mapGoogle/map_google_bloc.dart';
import 'package:app_hackaton/config/constant/original.const.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:app_hackaton/features/common/interafaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.34,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/fondo2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              )),
            ),
            Positioned(
                top: size.height * 0.05,
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.4,
                        height: size.width * 0.2,
                        decoration: const BoxDecoration(
                            // color: Colors.white,
                            ),
                        child: const DecoratedBox(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/SantaCruz-logo2.png"),
                              fit: BoxFit.contain),
                        )),
                      ),
                      Text(
                        "Secretaria DPTAL. de Seguridad Ciudadana SCZ.",
                        style: letterStyle.letraSCZ,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )),
            Positioned(
              top: size.height * 0.29,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.transparent],
                    stops: [0.95, 1],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width,
                  height: size.height * 0.71,
                  color: Colors.white,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: categoriesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 1),
                    itemBuilder: (context, index) {
                      final category = categoriesList[index];
                      return FadeInLeft(
                          child: ItemCategory(category: category));
                    },
                  ),
                ),
              ),
            ),
            Positioned(
                top: size.height * 0.28,
                left: size.width * 0.25,
                right: size.width * 0.25,
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: kPrimaryColor, width: size.width * 0.0075),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.02)),
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
                      ]),
                  child: Text("OPCIONES",
                      style: letterStyle.letraSCZ2,
                      textAlign: TextAlign.center),
                )),
          ],
        ),
      ),
    );
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.category});

  final OptionDashboard category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context);
    BoxDecoration decoration = BoxDecoration(
      color: kSecondaryColor,
      borderRadius: BorderRadius.circular(size.width * 0.04),
      border: Border.all(color: kPrimaryColor, width: size.width * 0.009),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(50, 50, 93, 0.25),
          offset: Offset(0, 13),
          blurRadius: 27,
          spreadRadius: -5,
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.3),
          offset: Offset(0, 8),
          blurRadius: 16,
          spreadRadius: -8,
        ),
      ],
    );

    return GestureDetector(
        onTap: () {
          if (category.title == "Radar Vecinal") {
            mapGoogleBloc
                .add(const OnChangedWorkMapType(WorkMapType.denuncias));
          }
          if (category.title == "Mapa Información") {
            mapGoogleBloc
                .add(const OnChangedWorkMapType(WorkMapType.informativo));
          }
          context.push(category.route);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.07, vertical: size.height * 0.02),
          padding: const EdgeInsets.all(10),
          decoration: decoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: size.width * 0.2,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(category.iconUrl)),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.008,
              // ),
              Text(
                textAlign: TextAlign.center,
                category.title,
                style: letterStyle.letraSCZ3,
                // maxLines: 2,
              )
            ],
          ),
        ));
  }
}

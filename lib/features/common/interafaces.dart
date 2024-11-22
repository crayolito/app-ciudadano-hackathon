class OptionDashboard {
  final String title;
  final String iconUrl;
  final String route;

  OptionDashboard({
    required this.title,
    required this.iconUrl,
    required this.route,
  });
}

List<OptionDashboard> categoriesList = [
  OptionDashboard(
      title: "Alerta Social",
      iconUrl: "assets/denuncia.png",
      route: "/lista-denuncias"),
  OptionDashboard(
      title: "Radar Vecinal",
      iconUrl: "assets/mapa-denuncias.png",
      route: "/mapGoogle"),
  OptionDashboard(
      title: "Perfil", iconUrl: "assets/perfil.png", route: "/perfil"),
  OptionDashboard(
      title: "Mapa Información",
      iconUrl: "assets/mapa-informacion.png",
      route: "/mapGoogle"),
  OptionDashboard(
      title: "Alerta Gubernamental",
      iconUrl: "assets/alerta-notificaciones.png",
      route: "/lista-alertas"),
  OptionDashboard(
      title: "Mapa Contaminación",
      iconUrl: "assets/mapa-contaminacion.png",
      route: "/mapBox"),
];

class Denuncia {
  final String title;
  final String iconUrl;
  final String latitud;
  final String longitud;
  final String descripcion;
  final String fecha;
  final String distancia;
  final String telefono;
  final String ubicacion;
  final String tipo;

  Denuncia(
      {required this.title,
      required this.iconUrl,
      required this.latitud,
      required this.longitud,
      required this.descripcion,
      required this.fecha,
      required this.distancia,
      required this.telefono,
      required this.ubicacion,
      required this.tipo});
}

List<Denuncia> denuncias = [
  Denuncia(
    title: "Denuncia 1",
    iconUrl: "assets/atraco.png",
    latitud: "-17.764913389416822",
    longitud: "-63.17345314430209",
    descripcion:
        "Un hombre fue asaltado en la calle principal mientras caminaba hacia su casa. Los asaltantes, armados, lo amenazaron y le robaron sus pertenencias personales, incluyendo su celular y billetera.",
    fecha: "2024-10-15 12:30",
    distancia: "200m",
    telefono: "789456123",
    ubicacion: "Avenida Principal, Zona Sur",
    tipo: "Atraco",
  ),
  Denuncia(
    title: "Denuncia 2",
    iconUrl: "assets/robo-auto.png",
    latitud: "-17.776589417024745",
    longitud: "-63.1518872337851",
    descripcion:
        "Un vehículo fue robado mientras estaba estacionado fuera de un supermercado. El dueño reportó que el automóvil fue forzado a través de la cerradura y no había señales de alarma activada.",
    fecha: "2024-10-12 15:45",
    distancia: "1.5km",
    telefono: "751234567",
    ubicacion: "Supermercado Zona Este",
    tipo: "Vehículos",
  ),
  Denuncia(
    title: "Denuncia 3",
    iconUrl: "assets/robo-tienda.png",
    latitud: "-17.757260852109383",
    longitud: "-63.19424361547684",
    descripcion:
        "Una vivienda fue violentada durante la madrugada. Los delincuentes ingresaron por una ventana rota y robaron varios objetos de valor, incluidos electrodomésticos y dinero en efectivo.",
    fecha: "2024-10-10 03:00",
    distancia: "3km",
    telefono: "798765432",
    ubicacion: "Calle 5, Zona Norte",
    tipo: "Vivienda o Local",
  ),
  Denuncia(
    title: "Denuncia 4",
    iconUrl: "assets/secuestro.png",
    latitud: "-17.811896547526594",
    longitud: "-63.20401023606552",
    descripcion:
        "Una persona fue secuestrada a plena luz del día mientras salía de su trabajo. Los secuestradores exigieron un rescate por su liberación, pero la víctima fue liberada horas después gracias a la intervención policial.",
    fecha: "2024-10-09 14:00",
    distancia: "5km",
    telefono: "777123456",
    ubicacion: "Centro Empresarial, Zona Oeste",
    tipo: "Secuestro",
  ),
  Denuncia(
    title: "Denuncia 5",
    iconUrl: "assets/atraco.png",
    latitud: "-17.79114803663972",
    longitud: "-63.20801545066745",
    descripcion:
        "Un atraco ocurrió en un cajero automático cuando la víctima intentaba retirar dinero. Los delincuentes lo abordaron y, tras amenazas, lograron robarle todo el efectivo que acababa de retirar.",
    fecha: "2024-10-08 18:30",
    distancia: "300m",
    telefono: "799654321",
    ubicacion: "Cajero Automático, Zona Sur",
    tipo: "Atraco",
  ),
  Denuncia(
    title: "Denuncia 6",
    iconUrl: "assets/robo-auto.png",
    latitud: "-17.78470977166598",
    longitud: "-63.19974988338305",
    descripcion:
        "Un auto fue robado en un estacionamiento privado. A pesar de la vigilancia, los ladrones lograron burlar las cámaras de seguridad y escapar con el vehículo sin ser detectados.",
    fecha: "2024-10-07 10:00",
    distancia: "1km",
    telefono: "781234567",
    ubicacion: "Estacionamiento Zona Central",
    tipo: "Vehículos",
  ),
  Denuncia(
    title: "Denuncia 7",
    iconUrl: "assets/robo-tienda.png",
    latitud: "-17.782325339509214",
    longitud: "-63.18973205486203",
    descripcion:
        "Una tienda local fue asaltada durante la noche. Los delincuentes rompieron la cerradura de la puerta principal y se llevaron mercancía por un valor de varios miles de bolivianos.",
    fecha: "2024-10-06 23:00",
    distancia: "500m",
    telefono: "752341678",
    ubicacion: "Tienda Comercial, Zona Este",
    tipo: "Vivienda o Local",
  ),
  Denuncia(
    title: "Denuncia 8",
    iconUrl: "assets/secuestro.png",
    latitud: "-17.77970031007184",
    longitud: "-63.18697685174495",
    descripcion:
        "Un joven fue secuestrado al salir de un evento en la ciudad. Los captores exigieron un alto rescate, pero gracias a la acción rápida de la policía, la víctima fue rescatada sin mayor daño.",
    fecha: "2024-10-05 21:00",
    distancia: "4km",
    telefono: "783456789",
    ubicacion: "Zona Centro",
    tipo: "Secuestro",
  ),
  Denuncia(
    title: "Denuncia 9",
    iconUrl: "assets/robo-tienda.png",
    latitud: "-17.790433388344667",
    longitud: "-63.18171762214761",
    descripcion:
        "Un hombre fue asaltado en su casa. Los ladrones lo sorprendieron mientras dormía, y tras reducirlo, lograron escapar con varios de sus bienes personales.",
    fecha: "2024-10-04 05:00",
    distancia: "700m",
    telefono: "787123654",
    ubicacion: "Residencial Zona Norte",
    tipo: "Vivienda o Local",
  ),
  Denuncia(
    title: "Denuncia 10",
    iconUrl: "assets/robo-auto.png",
    latitud: "-17.806171348333102",
    longitud: "-63.15842161551926",
    descripcion:
        "Un automóvil fue robado de una zona comercial. A pesar de los testigos, los delincuentes lograron huir sin ser identificados.",
    fecha: "2024-10-03 13:30",
    distancia: "2km",
    telefono: "741258963",
    ubicacion: "Zona Comercial",
    tipo: "Vehículos",
  ),
  Denuncia(
    title: "Denuncia 11",
    iconUrl: "assets/atraco.png",
    latitud: "-17.779224540039245",
    longitud: "-63.17545690599582",
    descripcion:
        "Una víctima fue asaltada a la salida de una tienda. Los agresores lo golpearon y le quitaron todas sus pertenencias de valor, dejándolo herido.",
    fecha: "2024-10-02 17:00",
    distancia: "800m",
    telefono: "785321987",
    ubicacion: "Zona Centro-Sur",
    tipo: "Atraco",
  ),
  Denuncia(
    title: "Denuncia 12",
    iconUrl: "assets/robo-auto.png",
    latitud: "-17.782798942585423",
    longitud: "-63.16618152363655",
    descripcion:
        "Un vehículo fue robado de una gasolinera mientras el dueño estaba en la tienda. Los delincuentes aprovecharon el descuido del propietario.",
    fecha: "2024-10-01 09:00",
    distancia: "600m",
    telefono: "789654123",
    ubicacion: "Gasolinera, Zona Este",
    tipo: "Vehículos",
  ),
  Denuncia(
    title: "Denuncia 13",
    iconUrl: "assets/robo-tienda.png",
    latitud: "-17.778971180332825",
    longitud: "-63.134337113169344",
    descripcion:
        "Un asalto ocurrió en una tienda de electrodomésticos, donde los criminales amenazaron al dueño y robaron productos por un alto valor.",
    fecha: "2024-09-30 20:00",
    distancia: "1km",
    telefono: "787654321",
    ubicacion: "Tienda de Electrodomésticos",
    tipo: "Vivienda o Local",
  ),
];

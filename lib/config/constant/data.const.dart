import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactoEmergencia {
  final String institucion;
  final String telefono;
  final String direccion;

  ContactoEmergencia({
    required this.institucion,
    required this.telefono,
    required this.direccion,
  });

  factory ContactoEmergencia.fromJson(Map<String, dynamic> json) {
    return ContactoEmergencia(
      institucion: json['institucion'],
      telefono: json['telefono'],
      direccion: json['direccion'],
    );
  }

  Map<String, dynamic> toJson() => {
        'institucion': institucion,
        'telefono': telefono,
        'direccion': direccion,
      };
}

class Vigencia {
  final String fechaInicio;
  final String fechaFin;

  Vigencia({
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Vigencia.fromJson(Map<String, dynamic> json) {
    return Vigencia(
      fechaInicio: json['fechaInicio'],
      fechaFin: json['fechaFin'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fechaInicio': fechaInicio,
        'fechaFin': fechaFin,
      };
}

class Coordenadas {
  final double latitude;
  final double longitude;
  final double radio;

  Coordenadas({
    required this.latitude,
    required this.longitude,
    required this.radio,
  });

  factory Coordenadas.fromJson(Map<String, dynamic> json) {
    return Coordenadas(
      latitude: json['latitude'],
      longitude: json['longitude'],
      radio: json['radio'],
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'radio': radio,
      };
}

class Alerta {
  final String id;
  final String nivelAlerta;
  final String tipoEvento;
  final String descripcion;
  final List<String> zonasAfectadas;
  final List<String> recomendaciones;
  final String institucionEmisora;
  final List<ContactoEmergencia> contactosEmergencia;
  final Vigencia vigencia;
  final Coordenadas coordenadas;

  Alerta({
    required this.id,
    required this.nivelAlerta,
    required this.tipoEvento,
    required this.descripcion,
    required this.zonasAfectadas,
    required this.recomendaciones,
    required this.institucionEmisora,
    required this.contactosEmergencia,
    required this.vigencia,
    required this.coordenadas,
  });

  factory Alerta.fromJson(Map<String, dynamic> json) {
    return Alerta(
      id: json['id'],
      nivelAlerta: json['nivelAlerta'],
      tipoEvento: json['tipoEvento'],
      descripcion: json['descripcion'],
      zonasAfectadas: List<String>.from(json['zonasAfectadas']),
      recomendaciones: List<String>.from(json['recomendaciones']),
      institucionEmisora: json['institucionEmisora'],
      contactosEmergencia: (json['contactosEmergencia'] as List)
          .map((i) => ContactoEmergencia.fromJson(i))
          .toList(),
      vigencia: Vigencia.fromJson(json['vigencia']),
      coordenadas: Coordenadas.fromJson(json['coordenadas']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nivelAlerta': nivelAlerta,
        'tipoEvento': tipoEvento,
        'descripcion': descripcion,
        'zonasAfectadas': zonasAfectadas,
        'recomendaciones': recomendaciones,
        'institucionEmisora': institucionEmisora,
        'contactosEmergencia':
            contactosEmergencia.map((e) => e.toJson()).toList(),
        'vigencia': vigencia.toJson(),
        'coordenadas': coordenadas.toJson(),
      };
}

final List<LatLng> coordinates1 = [
  const LatLng(-17.780213993761766, -63.195469172463085),
  const LatLng(-17.779968779578837, -63.198108527729715),
  const LatLng(-17.77745543929053, -63.20055468934591),
  const LatLng(-17.781215103607384, -63.20351613470397),
  const LatLng(-17.778354312832274, -63.20583352281192),
  const LatLng(-17.773164197084384, -63.20574739044009),
  const LatLng(-17.768934722026113, -63.19770072177353),
  const LatLng(-17.770939005570263, -63.189324002235686),
  const LatLng(-17.776067811367152, -63.18664148567195),
];

// Segunda lista de coordenadas
final List<LatLng> coordinates2 = [
  const LatLng(-17.78425106558498, -63.20047715190169),
  const LatLng(-17.785854869082556, -63.19792529301892),
  const LatLng(-17.7822584000232, -63.20440696174968),
  const LatLng(-17.779099310717072, -63.2078773042515),
  const LatLng(-17.775162737290906, -63.20889776492993),
  const LatLng(-17.777738865897664, -63.199405224730384),
  const LatLng(-17.78036298334281, -63.186084757335415),
  const LatLng(-17.777641480408366, -63.18664631475629),
  const LatLng(-17.77229541724041, -63.18338033308766),
  const LatLng(-17.768889271401058, -63.18339403870937),
  const LatLng(-17.767097858132217, -63.18818869554693),
  const LatLng(-17.761665195889318, -63.19450045420487),
];

// final Map<LatLng, Map<String, dynamic>> serviciosSantaCruz = {
//   const LatLng(-17.81431701622836, -63.18590261529407): {
//     "nombre": "CRE - Sede Central",
//     "tipo": "Servicio Eléctrico",
//     "direccion": "Av. Santos Dumont, 3er Anillo Interno",
//     "horario": "Lunes a Viernes: 7:30 - 17:30, Sábado: 8:00 - 12:00",
//     "servicios": [
//       "Atención al cliente",
//       "Pago de facturas",
//       "Nuevas conexiones",
//       "Reclamos",
//       "Servicios técnicos"
//     ],
//     "telefono": "176",
//     "imagen": "assets/cre_central.jpg",
//     "descripcion":
//         "Sede principal de la Cooperativa Rural de Electrificación (CRE), responsable del suministro eléctrico en Santa Cruz"
//   },
//   const LatLng(-17.82055369197659, -63.16428959142617): {
//     "nombre": "SAGUAPAC - Oficina Central",
//     "tipo": "Servicio de Agua",
//     "direccion": "Av. Irala entre 2do y 3er Anillo",
//     "horario": "Lunes a Viernes: 7:30 - 16:30, Sábado: 8:00 - 12:00",
//     "servicios": [
//       "Atención al usuario",
//       "Pago de servicios",
//       "Conexiones nuevas",
//       "Reportes de fugas",
//       "Calidad del agua"
//     ],
//     "telefono": "346-9999",
//     "imagen": "assets/saguapac_central.jpg",
//     "descripcion":
//         "Cooperativa principal de servicios de agua potable y alcantarillado sanitario de Santa Cruz"
//   },
//   const LatLng(-17.802973550268295, -63.132727830765724): {
//     "nombre": "Gobierno Autónomo Municipal - GAMSC",
//     "tipo": "Institución Municipal",
//     "direccion": "2do Anillo y Av. Brasil",
//     "horario": "Lunes a Viernes: 7:30 - 16:00",
//     "servicios": [
//       "Trámites municipales",
//       "Licencias de funcionamiento",
//       "Impuestos municipales",
//       "Planificación urbana",
//       "Servicios sociales"
//     ],
//     "telefono": "371-1000",
//     "imagen": "assets/gamsc.jpg",
//     "descripcion":
//         "Sede principal del Gobierno Autónomo Municipal de Santa Cruz de la Sierra"
//   },
//   const LatLng(-17.784479433317223, -63.13273723760046): {
//     "nombre": "Secretaría de Obras Públicas",
//     "tipo": "Institución Municipal",
//     "direccion": "3er Anillo Interno",
//     "horario": "Lunes a Viernes: 8:00 - 16:00",
//     "servicios": [
//       "Permisos de construcción",
//       "Planificación urbana",
//       "Mantenimiento vial",
//       "Proyectos de infraestructura",
//       "Supervisión de obras"
//     ],
//     "telefono": "371-1500",
//     "imagen": "assets/obras_publicas.jpg",
//     "descripcion":
//         "Oficina encargada de la planificación y ejecución de obras públicas municipales"
//   },
//   const LatLng(-17.8013749024425, -63.20144408254316): {
//     "nombre": "CRE - Oficina Distrital Oeste",
//     "tipo": "Servicio Eléctrico",
//     "direccion": "Av. Mutualista, 4to Anillo",
//     "horario": "Lunes a Viernes: 8:00 - 16:30",
//     "servicios": [
//       "Atención al cliente",
//       "Pago de facturas",
//       "Reclamos",
//       "Servicios técnicos básicos"
//     ],
//     "telefono": "176",
//     "imagen": "assets/cre_oeste.jpg",
//     "descripcion":
//         "Oficina distrital de CRE para atención en la zona oeste de la ciudad"
//   },
//   const LatLng(-17.786119408840708, -63.208606386149384): {
//     "nombre": "SAGUAPAC - Oficina Distrital Norte",
//     "tipo": "Servicio de Agua",
//     "direccion": "Av. Banzer, 4to Anillo",
//     "horario": "Lunes a Viernes: 7:30 - 16:00",
//     "servicios": [
//       "Atención al usuario",
//       "Pago de servicios",
//       "Reportes de emergencias",
//       "Consultas técnicas"
//     ],
//     "telefono": "346-9999",
//     "imagen": "assets/saguapac_norte.jpg",
//     "descripcion":
//         "Oficina distrital de SAGUAPAC para atención en la zona norte"
//   },
//   const LatLng(-17.787735273285424, -63.1859082801581): {
//     "nombre": "Dirección de Recaudaciones",
//     "tipo": "Institución Municipal",
//     "direccion": "3er Anillo Interno",
//     "horario": "Lunes a Viernes: 7:30 - 16:00",
//     "servicios": [
//       "Pago de impuestos",
//       "Trámites tributarios",
//       "Registro de propiedades",
//       "Consultas fiscales"
//     ],
//     "telefono": "371-1200",
//     "imagen": "assets/recaudaciones.jpg",
//     "descripcion":
//         "Oficina municipal encargada de la recaudación de impuestos y tasas"
//   },
//   const LatLng(-17.79512705234846, -63.16162763205684): {
//     "nombre": "Guardia Municipal",
//     "tipo": "Institución Municipal",
//     "direccion": "2do Anillo y Av. Irala",
//     "horario": "24 horas",
//     "servicios": [
//       "Seguridad ciudadana",
//       "Control urbano",
//       "Atención de emergencias",
//       "Ordenamiento vial"
//     ],
//     "telefono": "156",
//     "imagen": "assets/guardia_municipal.jpg",
//     "descripcion": "Central de operaciones de la Guardia Municipal"
//   },
//   const LatLng(-17.785178799078615, -63.139411541506945): {
//     "nombre": "Oficina de Defensa al Consumidor",
//     "tipo": "Institución Municipal",
//     "direccion": "Av. Cañoto, 2do Anillo",
//     "horario": "Lunes a Viernes: 8:00 - 16:00",
//     "servicios": [
//       "Atención de denuncias",
//       "Protección al consumidor",
//       "Mediación de conflictos",
//       "Asesoría legal"
//     ],
//     "telefono": "371-1300",
//     "imagen": "assets/defensa_consumidor.jpg",
//     "descripcion":
//         "Oficina de protección y defensa de los derechos del consumidor"
//   },
//   const LatLng(-17.773385983102692, -63.14026338219026): {
//     "nombre": "CRE - Oficina Distrital Este",
//     "tipo": "Servicio Eléctrico",
//     "direccion": "Av. Virgen de Cotoca",
//     "horario": "Lunes a Viernes: 8:00 - 16:30",
//     "servicios": [
//       "Atención al cliente",
//       "Pago de facturas",
//       "Reclamos",
//       "Servicios técnicos básicos"
//     ],
//     "telefono": "176",
//     "imagen": "assets/cre_este.jpg",
//     "descripcion": "Oficina distrital de CRE para atención en la zona este"
//   },
//   const LatLng(-17.75442810626452, -63.14027232538696): {
//     "nombre": "SAGUAPAC - Oficina Plan 3000",
//     "tipo": "Servicio de Agua",
//     "direccion": "Av. Principal Plan 3000",
//     "horario": "Lunes a Viernes: 7:30 - 16:00",
//     "servicios": [
//       "Atención al usuario",
//       "Pago de servicios",
//       "Reportes de emergencias",
//       "Consultas técnicas"
//     ],
//     "telefono": "346-9999",
//     "imagen": "assets/saguapac_plan3000.jpg",
//     "descripcion": "Oficina de SAGUAPAC para atención en la zona del Plan 3000"
//   },
//   const LatLng(-17.744969163593566, -63.18446006013539): {
//     "nombre": "Secretaría de Parques y Jardines",
//     "tipo": "Institución Municipal",
//     "direccion": "4to Anillo, zona Norte",
//     "horario": "Lunes a Viernes: 7:30 - 15:30",
//     "servicios": [
//       "Mantenimiento de áreas verdes",
//       "Planificación de parques",
//       "Conservación ambiental",
//       "Proyectos de arborización"
//     ],
//     "telefono": "371-1400",
//     "imagen": "assets/parques_jardines.jpg",
//     "descripcion":
//         "Oficina encargada del mantenimiento y desarrollo de áreas verdes"
//   },
//   const LatLng(-17.75699385368541, -63.19635182923047): {
//     "nombre": "Oficina de Desarrollo Urbano",
//     "tipo": "Institución Municipal",
//     "direccion": "3er Anillo Externo",
//     "horario": "Lunes a Viernes: 8:00 - 16:00",
//     "servicios": [
//       "Planificación urbana",
//       "Aprobación de planos",
//       "Líneas municipales",
//       "Uso de suelos"
//     ],
//     "telefono": "371-1600",
//     "imagen": "assets/desarrollo_urbano.jpg",
//     "descripcion": "Oficina de planificación y desarrollo urbano municipal"
//   },
//   const LatLng(-17.812625514878654, -63.11008822803407): {
//     "nombre": "Centro Municipal de Servicios",
//     "tipo": "Institución Municipal",
//     "direccion": "Av. El Trompillo",
//     "horario": "Lunes a Viernes: 7:30 - 16:00",
//     "servicios": [
//       "Trámites municipales",
//       "Atención ciudadana",
//       "Servicios sociales",
//       "Programas comunitarios"
//     ],
//     "telefono": "371-1700",
//     "imagen": "assets/centro_servicios.jpg",
//     "descripcion": "Centro integral de servicios municipales para la ciudadanía"
//   },
// };

class ServicioPublico {
  final String nombre;
  final String tipo;
  final String direccion;
  final String horario;
  final List<String> servicios;
  final String telefono;
  final String imagen;
  final String descripcion;
  final LatLng ubicacion;

  const ServicioPublico({
    required this.nombre,
    required this.tipo,
    required this.direccion,
    required this.horario,
    required this.servicios,
    required this.telefono,
    required this.imagen,
    required this.descripcion,
    required this.ubicacion,
  });
}

const List<ServicioPublico> serviciosSantaCruz = [
  ServicioPublico(
    nombre: "CRE - Sede Central",
    tipo: "Servicio Eléctrico",
    direccion: "Av. Santos Dumont y 3er Anillo Interno, Nº 710",
    horario: "Lunes a Viernes: 7:30 - 17:30\nSábados: 8:00 - 12:00",
    servicios: [
      "Atención preferencial adultos mayores y personas con discapacidad",
      "Pago de facturas y planes de pago",
      "Nuevas instalaciones y cambios de medidor",
      "Reclamos y consultas técnicas",
      "Servicios para grandes consumidores",
      "Certificaciones y presupuestos",
      "Modificaciones de instalación",
      "Reporte de averías 24/7"
    ],
    telefono: "176 | 800-10-0123",
    imagen: "assets/logo-official-CRE.png",
    descripcion:
        "Sede principal de la Cooperativa Rural de Electrificación (CRE). Centro de operaciones y atención integral que gestiona el suministro eléctrico para más de 700,000 usuarios en Santa Cruz. Cuenta con personal especializado, laboratorio de medidores y centro de control de distribución.",
    ubicacion: const LatLng(-17.81431701622836, -63.18590261529407),
  ),
  ServicioPublico(
    nombre: "CRE - Oficina Distrital Oeste",
    tipo: "Servicio Eléctrico",
    direccion: "Av. Mutualista y 4to Anillo, Centro Comercial Mutualista",
    horario: "Lunes a Viernes: 8:00 - 16:30\nSábados: 8:00 - 11:30",
    servicios: [
      "Atención al cliente personalizada",
      "Pago de facturas y planes de pago",
      "Reclamos y consultas",
      "Cambios de titularidad",
      "Servicios técnicos básicos",
      "Actualización de datos",
      "Solicitudes de inspección",
      "Consultas sobre consumo"
    ],
    telefono: "176 | 352-6677",
    imagen: "assets/logo-official-CRE.png",
    descripcion:
        "Oficina distrital estratégicamente ubicada para atender a los habitantes de la zona oeste de la ciudad. Brinda servicios completos de atención al cliente y soporte técnico, con personal capacitado para resolver consultas y problemas relacionados con el servicio eléctrico.",
    ubicacion: const LatLng(-17.8013749024425, -63.20144408254316),
  ),
  ServicioPublico(
    nombre: "CRE - Oficina Distrital Este",
    tipo: "Servicio Eléctrico",
    direccion: "Av. Virgen de Cotoca y 4to Anillo, Edificio CRE Este",
    horario: "Lunes a Viernes: 8:00 - 16:30\nSábados: 8:00 - 11:30",
    servicios: [
      "Atención al cliente y consultas",
      "Pago de facturas y convenios",
      "Reclamos técnicos y comerciales",
      "Nuevas conexiones residenciales",
      "Cambios de medidor",
      "Verificación de consumo",
      "Actualización de datos",
      "Asesoría energética"
    ],
    telefono: "176 | 347-8899",
    imagen: "assets/logo-official-CRE.png",
    descripcion:
        "Moderna oficina distrital que atiende el sector este de Santa Cruz. Equipada con tecnología de punta para brindar atención eficiente. Cuenta con personal especializado en atención al cliente y técnicos calificados para resolver problemas eléctricos de la zona.",
    ubicacion: const LatLng(-17.773385983102692, -63.14026338219026),
  ),
  ServicioPublico(
    nombre: "CRE - Centro Técnico y de Emergencias",
    tipo: "Servicio Eléctrico",
    direccion: "Av. Paraguá y 4to Anillo, Base de Operaciones CRE",
    horario: "24 horas, todos los días",
    servicios: [
      "Atención de emergencias eléctricas",
      "Reparación de líneas y transformadores",
      "Mantenimiento preventivo",
      "Inspecciones técnicas",
      "Control de calidad del servicio",
      "Gestión de cortes programados",
      "Soporte técnico especializado",
      "Coordinación de cuadrillas"
    ],
    telefono: "176 | 800-10-0176",
    imagen: "assets/logo-official-CRE.png",
    descripcion:
        "Centro de operaciones técnicas y respuesta a emergencias de CRE. Base principal para las cuadrillas de mantenimiento y reparación. Cuenta con equipo especializado y personal técnico disponible las 24 horas para atender emergencias eléctricas en toda la ciudad.",
    ubicacion: const LatLng(-17.776543, -63.175632),
  ),
  ServicioPublico(
    nombre: "CRE - Centro de Atención Norte",
    tipo: "Servicio Eléctrico",
    direccion: "Av. Banzer y 6to Anillo, Mall Ventura",
    horario: "Lunes a Sábado: 9:00 - 20:00\nDomingos: 9:00 - 13:00",
    servicios: [
      "Atención al cliente en centro comercial",
      "Pago de facturas y servicios",
      "Consultas y reclamos",
      "Nuevas conexiones",
      "Actualización de datos",
      "Planes de pago",
      "Asesoría comercial",
      "Servicios digitales"
    ],
    telefono: "176 | 355-9900",
    imagen: "assets/logo-official-CRE.png",
    descripcion:
        "Moderna oficina ubicada en el Mall Ventura, diseñada para brindar comodidad y accesibilidad a los usuarios del norte de la ciudad. Ofrece todos los servicios comerciales de CRE en un ambiente confortable y con horario extendido, incluyendo fines de semana.",
    ubicacion: const LatLng(-17.745632, -63.182345),
  ),
  ServicioPublico(
    nombre: "SAGUAPAC - Oficina Central",
    tipo: "Servicio de Agua",
    direccion: "Av. Irala entre 2do y 3er Anillo, Edificio SAGUAPAC",
    horario: "Lunes a Viernes: 7:30 - 16:30\nSábados: 8:00 - 12:00",
    servicios: [
      "Atención integral al usuario",
      "Nuevas conexiones de agua y alcantarillado",
      "Facturación y planes de pago",
      "Reportes de fugas y emergencias",
      "Análisis de calidad del agua",
      "Servicios técnicos especializados",
      "Certificaciones y constancias",
      "Gestión de reclamos"
    ],
    telefono: "346-9999 | 800-10-6999",
    imagen: "assets/logo-official-Saguapac.png",
    descripcion:
        "Sede principal de la Cooperativa de Servicios de Agua Potable y Alcantarillado Sanitario (SAGUAPAC). Centro administrativo y operativo que gestiona el servicio de agua potable para más de 1.5 millones de habitantes. Cuenta con laboratorios certificados y centro de control operacional.",
    ubicacion: const LatLng(-17.82055369197659, -63.16428959142617),
  ),
  ServicioPublico(
    nombre: "SAGUAPAC - Oficina Distrital Norte",
    tipo: "Servicio de Agua",
    direccion: "Av. Banzer y 4to Anillo, Centro Empresarial Norte",
    horario: "Lunes a Viernes: 7:30 - 16:00\nSábados: 8:00 - 11:30",
    servicios: [
      "Atención al usuario",
      "Pago de servicios y convenios",
      "Reportes de emergencias 24/7",
      "Inspecciones técnicas",
      "Consultas de consumo",
      "Actualización de datos",
      "Reclamos y sugerencias",
      "Servicios comerciales"
    ],
    telefono: "346-9999 | 355-7777",
    imagen: "assets/logo-official-Saguapac.png",
    descripcion:
        "Moderna oficina distrital que atiende el sector norte de la ciudad. Equipada con tecnología de punta para atención eficiente y seguimiento de reclamos. Personal capacitado para resolver consultas técnicas y comerciales relacionadas con el servicio de agua potable.",
    ubicacion: const LatLng(-17.786119408840708, -63.208606386149384),
  ),
  ServicioPublico(
    nombre: "SAGUAPAC - Oficina Plan 3000",
    tipo: "Servicio de Agua",
    direccion: "Av. Principal Plan 3000, Barrio Toro Toro",
    horario: "Lunes a Viernes: 7:30 - 16:00\nSábados: 8:00 - 11:30",
    servicios: [
      "Atención personalizada",
      "Pago de servicios",
      "Reportes de emergencias",
      "Consultas técnicas",
      "Nuevas conexiones",
      "Convenios de pago",
      "Actualizaciones catastrales",
      "Reclamos comerciales"
    ],
    telefono: "346-9999 | 348-8888",
    imagen: "assets/logo-official-Saguapac.png",
    descripcion:
        "Oficina estratégicamente ubicada para atender a los habitantes del Plan 3000 y zonas aledañas. Brinda atención integral y soluciones rápidas a problemas relacionados con el servicio de agua potable y alcantarillado sanitario.",
    ubicacion: const LatLng(-17.75442810626452, -63.14027232538696),
  ),
  ServicioPublico(
    nombre: "SAGUAPAC - Centro de Operaciones Técnicas",
    tipo: "Servicio de Agua",
    direccion: "Av. El Trompillo y 3er Anillo, Base Operativa",
    horario: "24 horas, todos los días",
    servicios: [
      "Atención de emergencias",
      "Reparación de redes",
      "Mantenimiento preventivo",
      "Control de calidad",
      "Monitoreo de presión",
      "Gestión de plantas de tratamiento",
      "Coordinación operativa",
      "Soporte técnico especializado"
    ],
    telefono: "346-9999 | 800-10-6999",
    imagen: "assets/logo-official-Saguapac.png",
    descripcion:
        "Centro neurálgico de operaciones técnicas de SAGUAPAC. Base principal para equipos de mantenimiento y reparación. Cuenta con sistema SCADA para monitoreo en tiempo real de la red de agua potable y alcantarillado sanitario.",
    ubicacion: const LatLng(-17.795432, -63.157890),
  ),
  ServicioPublico(
    nombre: "Gobierno Autónomo Municipal - GAMSC",
    tipo: "Institución Municipal",
    direccion: "2do Anillo y Av. Brasil, Palacio Municipal",
    horario: "Lunes a Viernes: 7:30 - 16:00",
    servicios: [
      "Atención ciudadana centralizada",
      "Trámites municipales generales",
      "Licencias de funcionamiento",
      "Impuestos y tasas municipales",
      "Planificación urbana",
      "Servicios sociales",
      "Ventanilla única empresarial",
      "Certificaciones municipales"
    ],
    telefono: "371-1000 | 800-12-1234",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Sede principal del Gobierno Autónomo Municipal de Santa Cruz de la Sierra. Centro administrativo que coordina todos los servicios municipales. Cuenta con ventanillas especializadas por área y sistema de gestión digital para agilizar trámites.",
    ubicacion: const LatLng(-17.802973550268295, -63.132727830765724),
  ),
  ServicioPublico(
    nombre: "Secretaría de Obras Públicas",
    tipo: "Institución Municipal",
    direccion: "3er Anillo Interno, Torre Ejecutiva Municipal",
    horario: "Lunes a Viernes: 8:00 - 16:00",
    servicios: [
      "Aprobación de planos",
      "Permisos de construcción",
      "Supervisión de obras",
      "Planificación urbana",
      "Mantenimiento vial",
      "Proyectos de infraestructura",
      "Inspecciones técnicas",
      "Certificaciones de obra"
    ],
    telefono: "371-1500 | 371-1501",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Oficina técnica encargada de la planificación y ejecución de obras públicas municipales. Gestiona proyectos de infraestructura urbana y supervisa construcciones privadas para garantizar el cumplimiento de normativas municipales.",
    ubicacion: const LatLng(-17.784479433317223, -63.13273723760046),
  ),
  ServicioPublico(
    nombre: "Dirección de Recaudaciones",
    tipo: "Institución Municipal",
    direccion: "3er Anillo Interno, Centro Administrativo Municipal",
    horario: "Lunes a Viernes: 7:30 - 16:00",
    servicios: [
      "Cobro de impuestos municipales",
      "Planes de pago y descuentos",
      "Registro de propiedades",
      "Actualización catastral",
      "Certificaciones tributarias",
      "Asesoría fiscal municipal",
      "Trámites de inmuebles",
      "Gestión de patentes"
    ],
    telefono: "371-1200 | 371-1201",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Centro especializado en la gestión y recaudación de tributos municipales. Ofrece atención personalizada y sistemas digitales para facilitar el pago de impuestos y la realización de trámites relacionados con propiedades y actividades comerciales.",
    ubicacion: const LatLng(-17.787735273285424, -63.1859082801581),
  ),
  ServicioPublico(
    nombre: "Guardia Municipal",
    tipo: "Institución Municipal",
    direccion: "2do Anillo y Av. Irala, Edificio de Seguridad Ciudadana",
    horario: "24 horas, todos los días",
    servicios: [
      "Seguridad ciudadana preventiva",
      "Control del espacio público",
      "Atención de emergencias",
      "Ordenamiento vial",
      "Protección de bienes municipales",
      "Control de vendedores",
      "Apoyo en eventos públicos",
      "Patrullaje preventivo"
    ],
    telefono: "156 | 800-14-0156",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Central de operaciones de la Guardia Municipal, encargada de la seguridad ciudadana y el orden público. Cuenta con personal capacitado, sistema de videovigilancia y unidades móviles para respuesta rápida a emergencias.",
    ubicacion: const LatLng(-17.79512705234846, -63.16162763205684),
  ),
  ServicioPublico(
    nombre: "Oficina de Defensa al Consumidor",
    tipo: "Institución Municipal",
    direccion: "Av. Cañoto y 2do Anillo, Centro de Atención Ciudadana",
    horario: "Lunes a Viernes: 8:00 - 16:00",
    servicios: [
      "Atención de denuncias comerciales",
      "Protección al consumidor",
      "Mediación de conflictos",
      "Asesoría legal gratuita",
      "Control de precios",
      "Inspecciones comerciales",
      "Educación al consumidor",
      "Conciliación comercial"
    ],
    telefono: "371-1300 | 800-13-1300",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Entidad dedicada a la protección y defensa de los derechos del consumidor. Ofrece servicios gratuitos de mediación, asesoría legal y control de actividades comerciales para garantizar prácticas comerciales justas.",
    ubicacion: const LatLng(-17.785178799078615, -63.139411541506945),
  ),
  ServicioPublico(
    nombre: "Secretaría de Parques y Jardines",
    tipo: "Institución Municipal",
    direccion: "4to Anillo, zona Norte, Vivero Municipal",
    horario: "Lunes a Viernes: 7:30 - 15:30",
    servicios: [
      "Mantenimiento de áreas verdes",
      "Diseño de espacios públicos",
      "Conservación ambiental",
      "Arborización urbana",
      "Gestión de viveros municipales",
      "Educación ambiental",
      "Proyectos paisajísticos",
      "Control fitosanitario"
    ],
    telefono: "371-1400 | 371-1402",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Centro de gestión y mantenimiento de áreas verdes de la ciudad. Cuenta con vivero municipal, equipo especializado y personal técnico para el cuidado y desarrollo de espacios verdes urbanos.",
    ubicacion: const LatLng(-17.744969163593566, -63.18446006013539),
  ),
  ServicioPublico(
    nombre: "Oficina de Desarrollo Urbano",
    tipo: "Institución Municipal",
    direccion: "3er Anillo Externo, Edificio Técnico Municipal",
    horario: "Lunes a Viernes: 8:00 - 16:00",
    servicios: [
      "Planificación urbana",
      "Aprobación de planos",
      "Gestión de uso de suelos",
      "Líneas municipales",
      "Regularización de construcciones",
      "Certificaciones urbanísticas",
      "Gestión territorial",
      "Consultas técnicas"
    ],
    telefono: "371-1600 | 371-1601",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Oficina técnica especializada en planificación y desarrollo urbano. Gestiona el crecimiento ordenado de la ciudad mediante la aplicación de normativas urbanísticas y el control de construcciones.",
    ubicacion: const LatLng(-17.75699385368541, -63.19635182923047),
  ),
  ServicioPublico(
    nombre: "Centro Municipal de Servicios",
    tipo: "Institución Municipal",
    direccion: "Av. El Trompillo, Centro Integrado de Servicios",
    horario: "Lunes a Viernes: 7:30 - 16:00",
    servicios: [
      "Ventanilla única municipal",
      "Atención ciudadana integral",
      "Servicios sociales",
      "Programas comunitarios",
      "Gestión de trámites",
      "Información municipal",
      "Asesoría general",
      "Registro ciudadano"
    ],
    telefono: "371-1700 | 371-1701",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Centro integral de servicios municipales diseñado para facilitar el acceso de los ciudadanos a todos los trámites y servicios municipales en un solo lugar. Cuenta con personal capacitado y sistemas modernos de gestión.",
    ubicacion: const LatLng(-17.812625514878654, -63.11008822803407),
  ),
  ServicioPublico(
    nombre: "Dirección de Tráfico y Transporte",
    tipo: "Institución Municipal",
    direccion: "Av. Cañoto y 3er Anillo, Terminal Bimodal",
    horario: "Lunes a Viernes: 7:30 - 16:00",
    servicios: [
      "Control de tráfico urbano",
      "Gestión de transporte público",
      "Licencias de conducir",
      "Registro de vehículos",
      "Señalización vial",
      "Educación vial",
      "Inspección vehicular",
      "Planificación de rutas"
    ],
    telefono: "371-1800 | 800-14-1800",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Entidad responsable de la gestión y control del tráfico y transporte en la ciudad. Coordina el ordenamiento vial y supervisa el funcionamiento del transporte público.",
    ubicacion: const LatLng(-17.798765, -63.167890),
  ),
  ServicioPublico(
    nombre: "Oficina de Deportes y Recreación",
    tipo: "Institución Municipal",
    direccion: "Av. Santos Dumont, Polideportivo Municipal",
    horario: "Lunes a Domingo: 6:00 - 22:00",
    servicios: [
      "Programas deportivos",
      "Escuelas municipales deportivas",
      "Gestión de infraestructura deportiva",
      "Eventos recreativos",
      "Actividades comunitarias",
      "Torneos municipales",
      "Promoción deportiva",
      "Mantenimiento de canchas"
    ],
    telefono: "371-1900 | 371-1901",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Centro de coordinación de actividades deportivas y recreativas municipales. Gestiona programas deportivos, mantiene instalaciones y promueve la actividad física en la ciudad.",
    ubicacion: const LatLng(-17.776543, -63.154321),
  ),
  ServicioPublico(
    nombre: "Centro de Atención Social",
    tipo: "Institución Municipal",
    direccion: "Av. Busch, 2do Anillo",
    horario: "Lunes a Viernes: 8:00 - 16:00",
    servicios: [
      "Asistencia social",
      "Programas de ayuda",
      "Atención a grupos vulnerables",
      "Servicios psicológicos",
      "Apoyo familiar",
      "Programas juveniles",
      "Atención al adulto mayor",
      "Desarrollo comunitario"
    ],
    telefono: "371-2000 | 800-14-2000",
    imagen: "assets/logo-official-SCZ.png",
    descripcion:
        "Centro especializado en la atención y desarrollo social de la comunidad. Ofrece programas de apoyo y servicios sociales para mejorar la calidad de vida de los ciudadanos.",
    ubicacion: const LatLng(-17.789012, -63.145678),
  ),
];

class MicroRoute {
  final String id;
  final String numero;
  final String nombre;
  final String color;
  final String horario;
  final String tarifa;
  final List<String> ruta;
  final List<String> puntosReferencia;
  final String frecuencia;

  const MicroRoute({
    required this.id,
    required this.numero,
    required this.nombre,
    required this.color,
    required this.horario,
    required this.tarifa,
    required this.ruta,
    required this.puntosReferencia,
    required this.frecuencia,
  });
}

final List<MicroRoute> microRoutes = [
  const MicroRoute(
      id: "1",
      numero: "1",
      nombre: "Villa 1ro de Mayo - Centro",
      color: "Rojo",
      horario: "05:30 - 22:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Villa 1ro de Mayo",
        "Av. Virgen de Cotoca",
        "3er Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Los Pozos",
        "Hospital Japonés",
        "Terminal Bimodal",
        "Plaza Principal",
      ],
      frecuencia: "Cada 10-15 minutos"),
  const MicroRoute(
      id: "2",
      numero: "5",
      nombre: "Plan 3000 - Centro",
      color: "Verde",
      horario: "05:00 - 23:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Plan 3000",
        "Av. Santos Dumont",
        "4to Anillo",
        "3er Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Abasto",
        "Hospital Municipal Plan 3000",
        "Universidad Gabriel René Moreno",
        "Catedral",
      ],
      frecuencia: "Cada 8-12 minutos"),
  const MicroRoute(
      id: "3",
      numero: "8",
      nombre: "Pampa de la Isla - Centro",
      color: "Amarillo",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Pampa de la Isla",
        "Av. Paraguá",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado La Ramada",
        "Hospital San Juan de Dios",
        "Parque Urbano",
        "Casco Viejo",
      ],
      frecuencia: "Cada 12-15 minutos"),
  const MicroRoute(
      id: "4",
      numero: "10",
      nombre: "La Cuchilla - Centro",
      color: "Azul",
      horario: "05:30 - 22:30",
      tarifa: "2.00 Bs",
      ruta: [
        "La Cuchilla",
        "Av. Cañoto",
        "3er Anillo",
        "1er Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Mutualista",
        "Stadium Tahuichi",
        "Plaza 24 de Septiembre",
        "Manzana Uno",
      ],
      frecuencia: "Cada 10-12 minutos"),
  const MicroRoute(
      id: "5",
      numero: "11",
      nombre: "UV-23 - Centro",
      color: "Naranja",
      horario: "06:00 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "UV-23",
        "Av. Busch",
        "3er Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Siete Calles",
        "Clínica Incor",
        "Ventura Mall",
        "Macro Fidalga",
      ],
      frecuencia: "Cada 15-20 minutos"),
  const MicroRoute(
      id: "6",
      numero: "16",
      nombre: "Villa Olímpica - Centro",
      color: "Blanco",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Villa Olímpica",
        "Av. Roca y Coronado",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "City Mall",
        "Plaza Blacutt",
        "Terminal de Buses",
        "Parque El Arenal",
      ],
      frecuencia: "Cada 12-15 minutos"),
  const MicroRoute(
      id: "7",
      numero: "17",
      nombre: "Cambodromo - Centro",
      color: "Celeste",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Cambodromo",
        "Av. Alemana",
        "3er Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Cambodromo",
        "Hospital de Niños",
        "Mercado La Ramada",
        "Plaza Principal",
      ],
      frecuencia: "Cada 15-18 minutos"),
  const MicroRoute(
      id: "8",
      numero: "18",
      nombre: "Guapilo - Centro",
      color: "Marrón",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Guapilo",
        "Av. Piraí",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Hospital Municipal",
        "Universidad NUR",
        "Cine Center",
        "Catedral",
      ],
      frecuencia: "Cada 10-15 minutos"),
  const MicroRoute(
      id: "9",
      numero: "21",
      nombre: "Los Lotes - Centro",
      color: "Verde Oscuro",
      horario: "05:00 - 22:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Los Lotes",
        "Av. Panorámica Norte",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Los Lotes",
        "Hospital Francés",
        "Mall Las Brisas",
        "Plaza 24 de Septiembre",
      ],
      frecuencia: "Cada 12-15 minutos"),
  const MicroRoute(
      id: "10",
      numero: "23",
      nombre: "Satélite Norte - Centro",
      color: "Rojo y Blanco",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Satélite Norte",
        "Av. El Trompillo",
        "3er Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Satélite Norte",
        "Clínica Niño Jesús",
        "Parque Lincoln",
        "Manzana Uno",
      ],
      frecuencia: "Cada 15-20 minutos"),
  const MicroRoute(
      id: "11",
      numero: "24",
      nombre: "Villa San Andrés - Centro",
      color: "Amarillo y Negro",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Villa San Andrés",
        "Av. Banzer",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado San Andrés",
        "Hospital de la Mujer",
        "Ventura Mall",
        "Plaza Principal",
      ],
      frecuencia: "Cada 12-18 minutos"),
  const MicroRoute(
      id: "12",
      numero: "27",
      nombre: "El Bajío - Centro",
      color: "Verde y Blanco",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "El Bajío",
        "Av. Cristo Redentor",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado El Bajío",
        "Hospital Municipal Norte",
        "Mall Ventura",
        "Catedral",
      ],
      frecuencia: "Cada 15-20 minutos"),
  const MicroRoute(
      id: "13",
      numero: "29",
      nombre: "Urbarí - Centro",
      color: "Azul y Blanco",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Urbarí",
        "Av. Santos Dumont",
        "3er Anillo",
        "1er Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Urbarí",
        "Clínica Foianini",
        "Stadium Tahuichi",
        "Plaza 24 de Septiembre",
      ],
      frecuencia: "Cada 12-15 minutos"),
  const MicroRoute(
      id: "14",
      numero: "32",
      nombre: "Los Chacos - Centro",
      color: "Naranja y Negro",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Los Chacos",
        "Av. Tres Pasos al Frente",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Los Chacos",
        "Hospital Oncológico",
        "Mall Las Brisas",
        "Plaza Principal",
      ],
      frecuencia: "Cada 15-18 minutos"),
  const MicroRoute(
      id: "15",
      numero: "35",
      nombre: "Bastión - Centro",
      color: "Rojo y Negro",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Bastión",
        "Av. Radial 13",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Bastión",
        "Hospital Municipal",
        "Universidad UPSA",
        "Catedral",
      ],
      frecuencia: "Cada 15-20 minutos"),
  const MicroRoute(
      id: "16",
      numero: "37",
      nombre: "Los Pozos - Centro",
      color: "Verde y Amarillo",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Los Pozos",
        "Av. Grigotá",
        "3er Anillo",
        "1er Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Los Pozos",
        "Hospital Japonés",
        "Terminal Bimodal",
        "Plaza 24 de Septiembre",
      ],
      frecuencia: "Cada 10-15 minutos"),
  const MicroRoute(
      id: "17",
      numero: "39",
      nombre: "Palmasola - Centro",
      color: "Azul y Amarillo",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "Palmasola",
        "Av. Santos Dumont",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Cárcel de Palmasola",
        "Hospital Municipal",
        "Mercado Mutualista",
        "Plaza Principal",
      ],
      frecuencia: "Cada 15-20 minutos"),
  const MicroRoute(
      id: "18",
      numero: "41",
      nombre: "Villa Victoria - Centro",
      color: "Blanco y Verde",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Villa Victoria",
        "Av. Mutualista",
        "3er Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Villa Victoria",
        "Clínica Cristo Rey",
        "Parque Urbano",
        "Catedral",
      ],
      frecuencia: "Cada 12-15 minutos"),
  const MicroRoute(
      id: "19",
      numero: "43",
      nombre: "El Quior - Centro",
      color: "Naranja y Blanco",
      horario: "06:00 - 21:30",
      tarifa: "2.00 Bs",
      ruta: [
        "El Quior",
        "Av. Paraguá",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado El Quior",
        "Hospital Municipal Este",
        "Ventura Mall",
        "Plaza 24 de Septiembre",
      ],
      frecuencia: "Cada 15-18 minutos"),
  const MicroRoute(
      id: "20",
      numero: "45",
      nombre: "Nueva Esperanza - Centro",
      color: "Verde y Negro",
      horario: "05:30 - 22:00",
      tarifa: "2.00 Bs",
      ruta: [
        "Nueva Esperanza",
        "Av. Virgen de Cotoca",
        "4to Anillo",
        "2do Anillo",
        "Centro",
      ],
      puntosReferencia: [
        "Mercado Nueva Esperanza",
        "Hospital San Juan de Dios",
        "Terminal Bimodal",
        "Manzana Uno",
      ],
      frecuencia: "Cada 12-15 minutos"),
];

final List<Map<String, dynamic>> microRoutess = [
  {
    "id": "1",
    "numero": "1",
    "nombre": "Villa 1ro de Mayo - Centro",
    "color": "Rojo",
    "horario": "05:30 - 22:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Villa 1ro de Mayo",
      "Av. Virgen de Cotoca",
      "3er Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Los Pozos",
      "Hospital Japonés",
      "Terminal Bimodal",
      "Plaza Principal",
    ],
    "frecuencia": "Cada 10-15 minutos"
  },
  {
    "id": "2",
    "numero": "5",
    "nombre": "Plan 3000 - Centro",
    "color": "Verde",
    "horario": "05:00 - 23:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Plan 3000",
      "Av. Santos Dumont",
      "4to Anillo",
      "3er Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Abasto",
      "Hospital Municipal Plan 3000",
      "Universidad Gabriel René Moreno",
      "Catedral",
    ],
    "frecuencia": "Cada 8-12 minutos"
  },
  {
    "id": "3",
    "numero": "8",
    "nombre": "Pampa de la Isla - Centro",
    "color": "Amarillo",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Pampa de la Isla",
      "Av. Paraguá",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado La Ramada",
      "Hospital San Juan de Dios",
      "Parque Urbano",
      "Casco Viejo",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
  {
    "id": "4",
    "numero": "10",
    "nombre": "La Cuchilla - Centro",
    "color": "Azul",
    "horario": "05:30 - 22:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "La Cuchilla",
      "Av. Cañoto",
      "3er Anillo",
      "1er Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Mutualista",
      "Stadium Tahuichi",
      "Plaza 24 de Septiembre",
      "Manzana Uno",
    ],
    "frecuencia": "Cada 10-12 minutos"
  },
  {
    "id": "5",
    "numero": "11",
    "nombre": "UV-23 - Centro",
    "color": "Naranja",
    "horario": "06:00 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "UV-23",
      "Av. Busch",
      "3er Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Siete Calles",
      "Clínica Incor",
      "Ventura Mall",
      "Macro Fidalga",
    ],
    "frecuencia": "Cada 15-20 minutos"
  },
  {
    "id": "6",
    "numero": "16",
    "nombre": "Villa Olímpica - Centro",
    "color": "Blanco",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Villa Olímpica",
      "Av. Roca y Coronado",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "City Mall",
      "Plaza Blacutt",
      "Terminal de Buses",
      "Parque El Arenal",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
  {
    "id": "7",
    "numero": "17",
    "nombre": "Cambodromo - Centro",
    "color": "Celeste",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Cambodromo",
      "Av. Alemana",
      "3er Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Cambodromo",
      "Hospital de Niños",
      "Mercado La Ramada",
      "Plaza Principal",
    ],
    "frecuencia": "Cada 15-18 minutos"
  },
  {
    "id": "8",
    "numero": "18",
    "nombre": "Guapilo - Centro",
    "color": "Marrón",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Guapilo",
      "Av. Piraí",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Hospital Municipal",
      "Universidad NUR",
      "Cine Center",
      "Catedral",
    ],
    "frecuencia": "Cada 10-15 minutos"
  },
  {
    "id": "9",
    "numero": "21",
    "nombre": "Los Lotes - Centro",
    "color": "Verde Oscuro",
    "horario": "05:00 - 22:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Los Lotes",
      "Av. Panorámica Norte",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Los Lotes",
      "Hospital Francés",
      "Mall Las Brisas",
      "Plaza 24 de Septiembre",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
  {
    "id": "10",
    "numero": "23",
    "nombre": "Satélite Norte - Centro",
    "color": "Rojo y Blanco",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Satélite Norte",
      "Av. El Trompillo",
      "3er Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Satélite Norte",
      "Clínica Niño Jesús",
      "Parque Lincoln",
      "Manzana Uno",
    ],
    "frecuencia": "Cada 15-20 minutos"
  },
  {
    "id": "11",
    "numero": "24",
    "nombre": "Villa San Andrés - Centro",
    "color": "Amarillo y Negro",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Villa San Andrés",
      "Av. Banzer",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado San Andrés",
      "Hospital de la Mujer",
      "Ventura Mall",
      "Plaza Principal",
    ],
    "frecuencia": "Cada 12-18 minutos"
  },
  {
    "id": "12",
    "numero": "27",
    "nombre": "El Bajío - Centro",
    "color": "Verde y Blanco",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "El Bajío",
      "Av. Cristo Redentor",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado El Bajío",
      "Hospital Municipal Norte",
      "Mall Ventura",
      "Catedral",
    ],
    "frecuencia": "Cada 15-20 minutos"
  },
  {
    "id": "13",
    "numero": "29",
    "nombre": "Urbarí - Centro",
    "color": "Azul y Blanco",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Urbarí",
      "Av. Santos Dumont",
      "3er Anillo",
      "1er Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Urbarí",
      "Clínica Foianini",
      "Stadium Tahuichi",
      "Plaza 24 de Septiembre",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
  {
    "id": "14",
    "numero": "32",
    "nombre": "Los Chacos - Centro",
    "color": "Naranja y Negro",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Los Chacos",
      "Av. Tres Pasos al Frente",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Los Chacos",
      "Hospital Oncológico",
      "Mall Las Brisas",
      "Plaza Principal",
    ],
    "frecuencia": "Cada 15-18 minutos"
  },
  {
    "id": "15",
    "numero": "35",
    "nombre": "Bastión - Centro",
    "color": "Rojo y Negro",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Bastión",
      "Av. Radial 13",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Bastión",
      "Hospital Municipal",
      "Universidad UPSA",
      "Catedral",
    ],
    "frecuencia": "Cada 15-20 minutos"
  },
  {
    "id": "16",
    "numero": "37",
    "nombre": "Los Pozos - Centro",
    "color": "Verde y Amarillo",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Los Pozos",
      "Av. Grigotá",
      "3er Anillo",
      "1er Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Los Pozos",
      "Hospital Japonés",
      "Terminal Bimodal",
      "Plaza 24 de Septiembre",
    ],
    "frecuencia": "Cada 10-15 minutos"
  },
  {
    "id": "17",
    "numero": "39",
    "nombre": "Palmasola - Centro",
    "color": "Azul y Amarillo",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Palmasola",
      "Av. Santos Dumont",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Cárcel de Palmasola",
      "Hospital Municipal",
      "Mercado Mutualista",
      "Plaza Principal",
    ],
    "frecuencia": "Cada 15-20 minutos"
  },
  {
    "id": "18",
    "numero": "41",
    "nombre": "Villa Victoria - Centro",
    "color": "Blanco y Verde",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Villa Victoria",
      "Av. Mutualista",
      "3er Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Villa Victoria",
      "Clínica Cristo Rey",
      "Parque Urbano",
      "Catedral",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
  {
    "id": "19",
    "numero": "43",
    "nombre": "El Quior - Centro",
    "color": "Naranja y Blanco",
    "horario": "06:00 - 21:30",
    "tarifa": "2.00 Bs",
    "ruta": [
      "El Quior",
      "Av. Paraguá",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado El Quior",
      "Hospital Municipal Este",
      "Ventura Mall",
      "Plaza 24 de Septiembre",
    ],
    "frecuencia": "Cada 15-18 minutos"
  },
  {
    "id": "20",
    "numero": "45",
    "nombre": "Nueva Esperanza - Centro",
    "color": "Verde y Negro",
    "horario": "05:30 - 22:00",
    "tarifa": "2.00 Bs",
    "ruta": [
      "Nueva Esperanza",
      "Av. Virgen de Cotoca",
      "4to Anillo",
      "2do Anillo",
      "Centro",
    ],
    "puntos_referencia": [
      "Mercado Nueva Esperanza",
      "Hospital San Juan de Dios",
      "Terminal Bimodal",
      "Manzana Uno",
    ],
    "frecuencia": "Cada 12-15 minutos"
  },
];

final List<LatLng> rutalinea81 = [
  LatLng(-17.928370676169152, -63.110304802136476),
  LatLng(-17.90900578815279, -63.12820428194578),
  LatLng(-17.888444684502254, -63.14764818667128),
  LatLng(-17.885694310938472, -63.15102016721046),
  LatLng(-17.884227428281662, -63.153524989333214),
  LatLng(-17.880468417204224, -63.15689679007888),
  LatLng(-17.867630062041165, -63.16702425751937),
  LatLng(-17.8505121789887, -63.18306563879149),
  LatLng(-17.841913378200747, -63.18028234930177),
  LatLng(-17.840675347447128, -63.18018602387721),
  LatLng(-17.83957488002819, -63.18076406151719),
  LatLng(-17.83347599421865, -63.185292034666176),
  LatLng(-17.832421295678234, -63.18558106536905),
  LatLng(-17.822883077353506, -63.18432871542829),
  LatLng(-17.814418366873273, -63.183222718005936),
  LatLng(-17.812385913071033, -63.18222462061826),
  LatLng(-17.810261162723794, -63.1814521747651),
  LatLng(-17.807972968464785, -63.180293503045604),
  LatLng(-17.807074041904805, -63.1800789548485),
  LatLng(-17.806624580708416, -63.180036055491875),
  LatLng(-17.79992354572974, -63.18025085566398),
  LatLng(-17.792486650327376, -63.18149530173112),
  LatLng(-17.789158740532226, -63.18198904342772),
  LatLng(-17.787094756729225, -63.18230631119178),
  LatLng(-17.786776882361355, -63.180182117380234),
  LatLng(-17.786531243917818, -63.17890759695198),
  LatLng(-17.786328944065776, -63.177815145397595),
  LatLng(-17.78599661316842, -63.176874423043124),
  LatLng(-17.78588959842604, -63.176236633444205),
  LatLng(-17.785759558079764, -63.17540212754181),
  LatLng(-17.785802881505408, -63.174370368400396),
  LatLng(-17.785629449357245, -63.17221580076621),
  LatLng(-17.78566826587009, -63.171899595860815),
  LatLng(-17.785650041471374, -63.171711403063426),
  LatLng(-17.785464768569458, -63.17166355843604),
  LatLng(-17.78533416731349, -63.17180709588884),
  LatLng(-17.783157130029842, -63.172099235659196),
  LatLng(-17.78294258871415, -63.172013407426775),
  LatLng(-17.782748482599406, -63.17215288477653),
  LatLng(-17.778360310672163, -63.17292506142065),
  LatLng(-17.77813314881943, -63.172849800303304),
  LatLng(-17.777735265203923, -63.171919949306165),
  LatLng(-17.77644654433052, -63.1704042919789),
  LatLng(-17.775707784305688, -63.16905104062186),
  LatLng(-17.774814253199406, -63.16749928731322),
  LatLng(-17.77445334252889, -63.16558662281703),
];

final List<LatLng> zonasAlertas = [
  LatLng(-17.888444684502254, -63.14764818667128),
  LatLng(-17.841913378200747, -63.18028234930177),
  LatLng(-17.814418366873273, -63.183222718005936),
  LatLng(-17.786776882361355, -63.180182117380234),
  LatLng(-17.774814253199406, -63.16749928731322),
];

final List<LatLng> alumbradoPublico = [
  LatLng(-17.89202404689537, -63.155663986820386),
  LatLng(-17.879593134281055, -63.169954146006084),
  LatLng(-17.859970418831125, -63.15730111410751),
  LatLng(-17.836068289112728, -63.16954664956988),
  LatLng(-17.82770984857272, -63.18138425275707),
  LatLng(-17.804000729219858, -63.18465330694975),
  LatLng(-17.793308938531847, -63.17628437202668),
  LatLng(-17.788449357360804, -63.17322328451252),
  LatLng(-17.787966562498198, -63.166240291377605),
  LatLng(-17.77943373590599, -63.156318042285854),
  LatLng(-17.77916001891839, -63.16653013879147),
  LatLng(-17.837510022964622, -63.184528111649996),
  LatLng(-17.84247796324735, -63.17451326949357),
];

final List<Alerta> alertasBolivia = [
  Alerta(
      id: "ALT-2024-001",
      nivelAlerta: "ALTA",
      tipoEvento: "Inundación",
      descripcion:
          "Desborde del Río Mamoré afectando comunidades ribereñas. Nivel del río 2 metros por encima de lo normal con tendencia a aumentar.",
      zonasAfectadas: [
        "Trinidad",
        "San Javier",
        "Loreto",
        "San Ignacio de Moxos",
        "San Andrés"
      ],
      recomendaciones: [
        "Evacuar hacia zonas altas",
        "Asegurar documentos y objetos de valor",
        "No intentar cruzar ríos o quebradas",
        "Mantener comunicación con autoridades locales",
        "Preparar kit de emergencia"
      ],
      institucionEmisora: "SENAMHI Bolivia",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Beni",
            telefono: "3-4628105",
            direccion: "Av. 6 de Agosto, Trinidad"),
        ContactoEmergencia(
            institucion: "Defensa Civil Beni",
            telefono: "3-4622850",
            direccion: "Calle Cipriano Barace, Trinidad")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-20T08:00:00", fechaFin: "2024-01-25T20:00:00"),
      coordenadas:
          Coordenadas(latitude: -14.8333, longitude: -64.9000, radio: 100.0)),
  Alerta(
      id: "ALT-2024-002",
      nivelAlerta: "ALTA",
      tipoEvento: "Deslizamiento",
      descripcion:
          "Deslizamiento masivo en la zona de Cotahuma tras intensas lluvias. Varias viviendas en riesgo de colapso.",
      zonasAfectadas: [
        "Cotahuma",
        "Bajo Llojeta",
        "Tacagua",
        "Villa El Carmen",
        "Bella Vista"
      ],
      recomendaciones: [
        "Evacuar inmediatamente las zonas de riesgo",
        "No regresar a viviendas en riesgo",
        "Reportar grietas o hundimientos",
        "Seguir rutas de evacuación señalizadas",
        "Acudir a albergues temporales"
      ],
      institucionEmisora: "GAMEA",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COE La Paz",
            telefono: "2-2650000",
            direccion: "Calle Junín, La Paz")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-21T06:00:00", fechaFin: "2024-01-23T06:00:00"),
      coordenadas:
          Coordenadas(latitude: -16.5000, longitude: -68.1500, radio: 5.0)),
  Alerta(
      id: "ALT-2024-003",
      nivelAlerta: "ALTA",
      tipoEvento: "Incendio Forestal",
      descripcion:
          "Incendio forestal de gran magnitud en la Chiquitania, afectando el Parque Nacional Noel Kempff Mercado. Condiciones secas y vientos fuertes complican control.",
      zonasAfectadas: [
        "San Ignacio de Velasco",
        "San José de Chiquitos",
        "Roboré",
        "San Rafael",
        "San Miguel"
      ],
      recomendaciones: [
        "Evacuar áreas amenazadas",
        "Seguir instrucciones de bomberos forestales",
        "Reportar nuevos focos de incendio",
        "Evitar actividades que puedan generar chispas",
        "Tener lista documentación importante"
      ],
      institucionEmisora: "ABT Bolivia",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Santa Cruz",
            telefono: "3-3636590",
            direccion: "Av. Omar Chávez, Santa Cruz")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-15T00:00:00", fechaFin: "2024-01-30T23:59:59"),
      coordenadas:
          Coordenadas(latitude: -16.3667, longitude: -60.9500, radio: 150.0)),
  Alerta(
      id: "ALT-2024-004",
      nivelAlerta: "MEDIA",
      tipoEvento: "Sequía",
      descripcion:
          "Severa sequía afecta al Chaco boliviano. Pérdidas significativas en agricultura y ganadería. Restricciones en suministro de agua.",
      zonasAfectadas: [
        "Yacuiba",
        "Villamontes",
        "Caraparí",
        "Macharetí",
        "Charagua"
      ],
      recomendaciones: [
        "Racionar el consumo de agua",
        "Almacenar agua de forma segura",
        "Reportar casos de emergencia por deshidratación",
        "Proteger cultivos prioritarios",
        "Seguir recomendaciones de distribución de agua"
      ],
      institucionEmisora: "SENAMHI Bolivia",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Tarija",
            telefono: "4-6642266",
            direccion: "Av. La Paz, Tarija")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-01T00:00:00", fechaFin: "2024-03-31T23:59:59"),
      coordenadas:
          Coordenadas(latitude: -21.5167, longitude: -63.6333, radio: 200.0)),
  Alerta(
      id: "ALT-2024-005",
      nivelAlerta: "ALTA",
      tipoEvento: "Granizada",
      descripcion:
          "Granizada severa con alta probabilidad de afectar El Alto y zonas altas de La Paz. Se esperan piedras de hasta 3 cm de diámetro.",
      zonasAfectadas: [
        "Ciudad Satélite",
        "Río Seco",
        "Villa Adela",
        "16 de Julio",
        "Senkata"
      ],
      recomendaciones: [
        "Buscar refugio sólido",
        "Proteger vehículos",
        "Asegurar techos livianos",
        "Mantener animales bajo techo",
        "Evitar desplazamientos innecesarios"
      ],
      institucionEmisora: "SENAMHI Bolivia",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COE El Alto",
            telefono: "2-2141700",
            direccion: "Av. Jorge Carrasco, El Alto")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-22T14:00:00", fechaFin: "2024-01-22T20:00:00"),
      coordenadas:
          Coordenadas(latitude: -16.5167, longitude: -68.2000, radio: 15.0)),
  Alerta(
      id: "ALT-2024-006",
      nivelAlerta: "ALTA",
      tipoEvento: "Actividad Volcánica",
      descripcion:
          "Incremento en actividad del volcán Uturuncu. Se registran temblores volcánicos y emisiones de gases.",
      zonasAfectadas: [
        "Quetena Chico",
        "Quetena Grande",
        "San Pablo de Lípez",
        "San Antonio de Lípez"
      ],
      recomendaciones: [
        "Mantenerse alejado del volcán",
        "Estar atento a avisos oficiales",
        "Preparar plan de evacuación",
        "Usar mascarilla en caso de ceniza",
        "Almacenar agua potable"
      ],
      institucionEmisora: "Observatorio San Calixto",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Potosí",
            telefono: "4-6222790",
            direccion: "Plaza 10 de Noviembre, Potosí")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-20T00:00:00", fechaFin: "2024-01-27T23:59:59"),
      coordenadas:
          Coordenadas(latitude: -22.2667, longitude: -67.1833, radio: 50.0)),
  Alerta(
      id: "ALT-2024-007",
      nivelAlerta: "MEDIA",
      tipoEvento: "Contaminación Ambiental",
      descripcion:
          "Niveles críticos de contaminación del aire en Cochabamba. Índice de calidad del aire supera los 150 puntos.",
      zonasAfectadas: [
        "Cercado",
        "Sacaba",
        "Quillacollo",
        "Vinto",
        "Tiquipaya"
      ],
      recomendaciones: [
        "Evitar actividades al aire libre",
        "Usar mascarilla al salir",
        "Mantener ventanas cerradas",
        "Proteger a niños y adultos mayores",
        "Hidratarse constantemente"
      ],
      institucionEmisora: "Red MoniCA",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Cochabamba",
            telefono: "4-4255264",
            direccion: "Av. Ballivián, Cochabamba")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-21T12:00:00", fechaFin: "2024-01-23T12:00:00"),
      coordenadas:
          Coordenadas(latitude: -17.3895, longitude: -66.1568, radio: 30.0)),
  Alerta(
      id: "ALT-2024-008",
      nivelAlerta: "ALTA",
      tipoEvento: "Helada",
      descripcion:
          "Helada severa pronosticada para el Altiplano con temperaturas por debajo de -10°C. Alto riesgo para agricultura y ganadería.",
      zonasAfectadas: [
        "Oruro",
        "Challapata",
        "Huari",
        "Salinas de Garci Mendoza",
        "Andamarca"
      ],
      recomendaciones: [
        "Proteger cultivos con cobertores",
        "Resguardar ganado en establos",
        "Evitar exposición prolongada al frío",
        "Mantener calefacción en hogares",
        "Revisar instalaciones de agua"
      ],
      institucionEmisora: "SENAMHI Bolivia",
      contactosEmergencia: [
        ContactoEmergencia(
            institucion: "COED Oruro",
            telefono: "2-5250770",
            direccion: "Calle Junín, Oruro")
      ],
      vigencia: Vigencia(
          fechaInicio: "2024-01-23T00:00:00", fechaFin: "2024-01-25T12:00:00"),
      coordenadas:
          Coordenadas(latitude: -17.9833, longitude: -67.1500, radio: 100.0)),
];

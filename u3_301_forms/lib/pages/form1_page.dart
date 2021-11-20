import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Form1Page extends StatefulWidget {
  Form1Page({Key? key}) : super(key: key);

  @override
  _Form1PageState createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  DateTime fechaSeleccionada = DateTime.now();
  int carreraSeleccionada = 0;
  String jornadaSeleccionada = 'd';
  bool estudiaGratuidad = false;
  var fFecha = DateFormat('dd-MM-yyyy');
  final emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final carreras = [
    {'id': 1, 'nombre': 'Técnico Universitario en Informática'},
    {'id': 2, 'nombre': 'Técnico Universitario en Electricidad'},
    {'id': 3, 'nombre': 'Técnico Universitario en Electrónica'},
    {'id': 4, 'nombre': 'Técnico Universitario en Telecomunicaciones'},
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms'),
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Text(
                'Ejemplo de Formulario',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    campoNombres(),
                    campoApellidoPaterno(),
                    campoApellidoMaterno(),
                    campoFechaNacimiento(),
                    campoEmail(),
                    campoCarrera(),
                    campoJornada(),
                    campoGratuidad(),
                    botonMatricular(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField campoNombres() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombres',
      ),
      validator: (nombres) {
        if (nombres!.isEmpty) {
          return 'Indique nombres';
        }
        return null;
      },
    );
  }

  TextFormField campoApellidoPaterno() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Apellido Paterno',
      ),
      validator: (apellidoPaterno) {
        if (apellidoPaterno!.isEmpty) {
          return 'Indique Apellido Paterno';
        }
        return null;
      },
    );
  }

  TextFormField campoApellidoMaterno() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Apellido Materno',
      ),
      validator: (apellidoMaterno) {
        if (apellidoMaterno!.isEmpty) {
          return 'Indique Apellido Materno';
        }
        return null;
      },
    );
  }

  Widget campoFechaNacimiento() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            'Fecha de Nacimiento: ',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            fFecha.format(fechaSeleccionada),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          TextButton(
            child: Icon(MdiIcons.calendar),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                locale: Locale('es', 'ES'),
              ).then((fecha) {
                setState(() {
                  fechaSeleccionada = fecha == null ? fechaSeleccionada : fecha;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  TextFormField campoEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
      validator: (email) {
        if (email!.isEmpty) {
          return 'Indique Dirección de Correo Electrónico';
        }
        if (!RegExp(emailRegex).hasMatch(email)) {
          return 'Email no válido';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField campoCarrera() {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(labelText: 'Carrera'),
      items: carreras.map((carrera) {
        return DropdownMenuItem(
          child: Text(carrera['nombre'].toString()),
          value: carrera['id'],
        );
      }).toList(),
      onChanged: (carrera) {
        setState(() {
          carreraSeleccionada = carrera;
        });
      },
    );
  }

  Widget campoJornada() {
    return Column(
      children: [
        RadioListTile<String>(
          title: Text('Jornada Diurna'),
          value: 'd',
          groupValue: jornadaSeleccionada,
          onChanged: (jornada) {
            setState(() {
              jornadaSeleccionada = jornada!;
            });
          },
        ),
        RadioListTile<String>(
          title: Text('Jornada Vespertina'),
          value: 'v',
          groupValue: jornadaSeleccionada,
          onChanged: (jornada) {
            setState(() {
              jornadaSeleccionada = jornada!;
            });
          },
        ),
      ],
    );
  }

  SwitchListTile campoGratuidad() {
    return SwitchListTile(
      title: Text('Estudia con beca gratuidad'),
      value: estudiaGratuidad,
      onChanged: (gratuidad) {
        setState(() {
          estudiaGratuidad = gratuidad;
        });
      },
    );
  }

  Widget botonMatricular() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Matricular'),
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            //form ok, continuar
            showSnackBar('Formulario ok');
          }
        },
      ),
    );
  }

  void showSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2),
    ));
  }
}

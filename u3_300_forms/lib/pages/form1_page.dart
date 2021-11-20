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
  String jornadaSeleccionada = 'd';
  bool estudiaGratuidad = false;
  var fFecha = DateFormat('dd-MM-yyyy');
  final emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
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
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                'Ejemplo de Formulario',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  // padding: EdgeInsets.all(5),
                  children: [
                    campoNombres(),
                    campoApellidoPaterno(),
                    campoApellidoMaterno(),
                    campoFechaNacimiento(),
                    campoEmail(),
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
    return Row(
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
          return 'Indique Email';
        }
        if (!RegExp(emailRegex).hasMatch(email)) {
          return 'Formato de email no válido';
        }
        return null;
      },
    );
  }

  Widget campoJornada() {
    return Column(
      children: [
        RadioListTile<String>(
          groupValue: jornadaSeleccionada,
          title: Text('Jornada Diurna'),
          value: 'd',
          onChanged: (jornada) {
            setState(() {
              jornadaSeleccionada = jornada!;
            });
          },
        ),
        RadioListTile<String>(
          groupValue: jornadaSeleccionada,
          title: Text('Jornada Vespertina'),
          value: 'v',
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
      onChanged: ((gratuidad) {
        setState(() {
          estudiaGratuidad = gratuidad;
        });
      }),
    );
  }

  Widget botonMatricular() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Matricular'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            //form ok
            showSnackBar('Formulario OK');
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

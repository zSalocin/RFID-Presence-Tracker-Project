import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'components.dart';
import 'excel_services.dart';
import 'dart:io';

class RFID extends StatefulWidget {
  final Sheet? sheet;
  final String? selectedItem;
  final String? espIP;
  final String? nameColumn;
  final String? rfidColumn;
  final String? idColumn;
  final String? filePath;
  final Excel? excel;

  const RFID({
    super.key,
    required this.excel,
    required this.sheet,
    required this.filePath,
    required this.selectedItem,
    required this.espIP,
    required this.nameColumn,
    required this.rfidColumn,
    required this.idColumn,
  });

  @override
  State<RFID> createState() => _RFIDState();
}

class _RFIDState extends State<RFID> {
  final formKey = GlobalKey<FormState>();
  String id = '';
  String reg = '';

  @override
  void initState() {
    super.initState();
    iniciarConexaoComESP();
  }

  void iniciarConexaoComESP() async {
    try {
      var socket = await Socket.connect(widget.espIP,
          80); // IP do ESP8266 e porta do servidor algo como 192.168.4.1 (final sempre 1)
      print('Conectado ao ESP8266');

      socket.listen(
        (data) {
          print('Dados recebidos: ${String.fromCharCodes(data)}');
          // Aqui você pode adicionar a lógica para processar os dados recebidos do ESP8266
        },
        onError: (error) {
          print('Erro: $error');
          socket.destroy();
        },
        onDone: () {
          print('Conexão encerrada pelo servidor');
          socket.destroy();
        },
      );
    } catch (e) {
      print('Erro ao conectar com o ESP8266: $e');
    }
  }

  Future<void> handleSerialData(String data) async {
    if (registerPresence(
          sheet: widget.sheet,
          id: data,
          columnID: widget.rfidColumn,
          columnPresence: widget.selectedItem,
          value: 'presente',
        ) !=
        '-1') {
      registerWithRFID(context, widget.sheet, data, widget.nameColumn,
          widget.rfidColumn, widget.idColumn);
    } else {
      dialogBox(context, 'Notification', 'Presença Registrada');
    }
    saveExcel(widget.excel, widget.filePath, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/circuit.jpg', // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                heightFactor: 0.4,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ID',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a ID';
                                  }
                                  return null;
                                },
                                onSaved: (value) => id = value!,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  reg = registerPresence(
                                    sheet: widget.sheet,
                                    id: id,
                                    columnID: widget.idColumn,
                                    columnPresence: widget.selectedItem,
                                    value: 'presente',
                                    columnName: widget.nameColumn,
                                  );
                                  if (reg != '-1') {
                                    dialogBox(context, 'Notification',
                                        '$reg registrado com sucesso');
                                  } else {
                                    dialogBox(context, 'Notification',
                                        'Falha ao registrar');
                                  }
                                  saveExcel(
                                      widget.excel, widget.filePath, context);
                                }
                              },
                              child: const Text('Insert'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

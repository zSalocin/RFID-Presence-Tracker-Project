import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:rfid/test.dart';
import 'components.dart';
import 'excel_services.dart';

class RFID extends StatefulWidget {
  final Sheet? sheet;
  final String? selectedItem;
  final String? comPort;
  final String? name;
  final String? rfid;
  final String? idColumn;
  final String? filePath;
  final Excel? excel;

  const RFID({
    super.key,
    required this.excel,
    required this.sheet,
    required this.filePath,
    required this.selectedItem,
    required this.comPort,
    required this.name,
    required this.rfid,
    required this.idColumn,
  });

  @override
  State<RFID> createState() => _RFIDState();
}

class _RFIDState extends State<RFID> {
  final formKey = GlobalKey<FormState>();
  String id = '';
  late SerialListener serialListener;

  @override
  void initState() {
    super.initState();
    serialListener = SerialListener(onDataReceived: onDataReceived);
    serialListener.startListening();
  }

  void onDataReceived(String data) {
    // Faça o que quiser com os dados recebidos, por exemplo, atualize o estado ou chame uma função de callback.
    print('Received data: $data');
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
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  dialogBox(
                                      context,
                                      'Notification',
                                      registerPresenceByID(
                                        sheet: widget.sheet,
                                        id: id,
                                        columnID: widget.idColumn,
                                        columnPresence: widget.selectedItem,
                                        value: 'presente',
                                      ));
                                  saveExcel(widget.excel, widget.filePath);
                                }
                              },
                              child: const Text('Insert'),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            register(context);
                          },
                          icon: const Icon(Icons.add),
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

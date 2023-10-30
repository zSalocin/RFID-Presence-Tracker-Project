import 'dart:async';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'excel_services.dart';

void dialogBox(BuildContext context, String tittle, String text,
    {int autoCloseSeconds = 3}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      if (autoCloseSeconds > 0) {
        Timer(Duration(seconds: autoCloseSeconds), () {
          Navigator.of(context)
              .pop(); // Automatically close the dialog after autoCloseSeconds
        });
      }

      return AlertDialog(
        title: Text(tittle),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> register(BuildContext context, Sheet? sheet, String? nameColumn,
    String? rfidColumn, String? idColumn) async {
  // ignore: unused_local_variable
  String name = "";
  String id = "";
  final formKey = GlobalKey<FormState>();
  bool isDialogOpen = false;
  if (!isDialogOpen) {
    isDialogOpen = true;
    () => isDialogOpen = false;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register'),
          actions: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => name = value!,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextFormField(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    //TODO put to pick the RFID
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.pop(context);
                          dialogBox(
                              context,
                              'tittle',
                              addNewRecord(
                                  sheet: sheet,
                                  name: name,
                                  id: id,
                                  rfid: '0',
                                  columnName: nameColumn,
                                  columnID: idColumn,
                                  columnRFID: rfidColumn));
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

Future<void> registerWithRFID(BuildContext context, Sheet? sheet, String rfid,
    String? nameColumn, String? rfidColumn, String? idColumn) async {
  String name = "";
  String id = "";
  final formKey = GlobalKey<FormState>();
  bool isDialogOpen = false;
  if (!isDialogOpen) {
    isDialogOpen = true;
    () => isDialogOpen = false;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register'),
          actions: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => name = value!,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextFormField(
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
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.pop(context);
                          dialogBox(
                              context,
                              'tittle',
                              addNewRecord(
                                  sheet: sheet,
                                  name: name,
                                  id: id,
                                  rfid: rfid,
                                  columnName: nameColumn,
                                  columnID: idColumn,
                                  columnRFID: rfidColumn));
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

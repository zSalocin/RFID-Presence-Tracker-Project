import 'dart:async';

import 'package:flutter/material.dart';

void dialogBox(BuildContext context, String tittle, String text,
    {int autoCloseSeconds = 5}) {
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

Future<void> register(BuildContext context) async {
  // ignore: unused_local_variable
  String name = "";
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
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Navigator.pop(context);
                          dialogBox(context, 'Notification',
                              'await firebaseService.setBlock(blockName)');
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

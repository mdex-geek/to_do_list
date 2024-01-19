// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_list/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
                focusedBorder: OutlineInputBorder(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //cancel
                MyButton(name: 'cancel', onPressed: onCancel),

                const SizedBox(
                  width: 20,
                ),

                //button ->save and cancel
                MyButton(name: 'save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}

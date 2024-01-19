// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

@immutable
class ToDoTile extends StatelessWidget {
  final String title;
  Function(BuildContext) deleteFunction;
  final bool taskComplete;
  Function(bool?)? onChanged;

  ToDoTile({
    Key? key,
    required this.title,
    required this.taskComplete,
    required this.onChanged,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade900,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: CheckboxListTile.adaptive(
          contentPadding: const EdgeInsets.all(12),
          title: Text(
            title,
            style: TextStyle(
              decoration: taskComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          value: taskComplete,
          onChanged: onChanged,
          activeColor: Colors.black,
          checkColor: Colors.white,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}

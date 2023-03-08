import 'package:crud_biasa/model_person.dart';
import 'package:flutter/material.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;
  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog<Person>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create a Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: 'Enter name here...'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter age here...'),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                //Have existing person
                if (existingPerson != null) {
                  final newPerson = existingPerson.updated(
                    name,
                    age,
                  );
                  Navigator.pop(context, newPerson);
                } else {
                  //no existing person
                  Navigator.pop(
                    context,
                    Person(
                      name: name!,
                      age: age!,
                    ),
                  );
                }
              } else {
                //no name or age. both
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

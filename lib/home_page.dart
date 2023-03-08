import 'package:crud_biasa/changenotifier_model.dart';
import 'package:crud_biasa/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: Text(
                  person.displayName,
                  style: TextStyle(fontSize: 10 + person.age.toDouble()),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final updatePerson =
                            await createOrUpdatePersonDialog(context, person);
                        if (updatePerson != null) {
                          dataModel.update(updatePerson);
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        dataModel.remove(person);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                subtitle: Text(
                  person.uuid,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final dataMOdel = ref.watch(peopleProvider);
            dataMOdel.add(person);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:local_database/models/note_model.dart';
import 'package:local_database/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  const NoteScreen({
    Key? key,
    this.note
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final weightController = TextEditingController();

    if(note != null){
      nameController.text = note!.name;
      weightController.text = note!.weight;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text( note == null
            ? 'Add a note'
            : 'Edit note'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: nameController,
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(
                  labelText: 'Weight(in kg)',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 1,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = nameController.value.text;
                      final description = weightController.value.text;

                      if (title.isEmpty || description.isEmpty) {
                        return;
                      }

                      final Note model = Note(name: title, weight: description, id: note?.id);
                      if(note == null){
                        await DatabaseHelper.addNote(model);
                      }else{
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text( note == null
                      ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

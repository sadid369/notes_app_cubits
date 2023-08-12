import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_cubit/constant.dart';
import 'package:notes_app_cubit/cubit/cubit_state.dart';
import 'package:notes_app_cubit/cubit/notes_cubit.dart';

class NoteAddPage extends StatelessWidget {
  const NoteAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();
    var _descController = TextEditingController();
    Future<bool> addNotes(String title, String desc) async {
      bool isCreated = await context.read<NotesCubit>().addNotes(title, desc);

      return isCreated;
    }

    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 60,
                bottom: 20,
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Constants.tabColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Constants.tabColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_titleController.text.isNotEmpty &&
                            _descController.text.isNotEmpty) {
                          var isCreatd = await addNotes(
                              _titleController.text.toString(),
                              _descController.text.toString());

                          if (isCreatd) {
                            _titleController.clear();
                            _descController.clear();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Constants.backGroundColor,
                                  content: const Text(
                                    'Note Added',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Constants.backGroundColor,
                                content: Text(
                                  _titleController.text.isEmpty &&
                                          _descController.text.isEmpty
                                      ? 'Please Add Note Title & Description'
                                      : _titleController.text.isEmpty
                                          ? 'Please Add Note Title'
                                          : "Please Add Note Description",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              cursorColor: Constants.textColor,
              cursorWidth: 4,
              style: const TextStyle(
                fontSize: 35,
                color: Constants.textColor,
              ),
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Constants.textColor,
                  fontSize: 35,
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 5,
              cursorColor: Constants.textColor,
              cursorWidth: 4,
              style: const TextStyle(
                fontSize: 35,
                color: Constants.textColor,
              ),
              controller: _descController,
              decoration: const InputDecoration(
                hintText: "Type Something....",
                hintStyle: TextStyle(
                  color: Constants.textColor,
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

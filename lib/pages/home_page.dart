import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_cubit/Widgets/gridTile.dart';
import 'package:notes_app_cubit/constant.dart';
import 'package:notes_app_cubit/cubit/cubit_state.dart';
import 'package:notes_app_cubit/cubit/notes_cubit.dart';
import 'package:notes_app_cubit/pages/note_add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   getAllNotes();
  // }

  // void getAllNotes() async {
  //   await BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.backGroundColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const NoteAddPage();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return state.notes.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 60,
                          bottom: 20,
                        ),
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Constants.tabColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.custom(
                          gridDelegate: SliverStairedGridDelegate(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            // startCrossAxisDirectionReversed: true,
                            pattern: [
                              StairedGridTile(0.5, 1),
                              StairedGridTile(0.5, 1),
                              StairedGridTile(1.0, 10 / 4),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            childCount: state.notes!.length,
                            (context, index) => MyGridTile(
                              notes: state.notes![index],
                              index: index,
                              callbackAction: () {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: const Text('No Notes'),
                );
        },
      ),
    );
  }
}

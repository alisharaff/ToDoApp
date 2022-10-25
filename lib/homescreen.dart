import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/shared/cubit/cuibt.dart';
import 'package:to_do_list/shared/cubit/states.dart';

class homeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(
      //text: 'hello',
      );
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) => AppCubit()..openOurDatabase()),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is TodoInsertTaskState) {
              Navigator.pop(context);

              titleController.clear();
              timeController.text = '';
              dateController.clear();
            }

            if (state is TodoUpdateTaskState) {
              Navigator.pop(context);

              titleController.clear();
              timeController.text = '';
              dateController.clear();
            }

            if (state is TodoBottomSheetUpdateState) {
              openBottomSheet(
                context: context,
                task: state.task,
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  AppCubit.get(context)
                      .title[AppCubit.get(context).currentIndex],
                ),
              ),
              body: AppCubit.get(context)
                  .myScreen[AppCubit.get(context).currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  openBottomSheet(
                    context: context,
                  );
                },
                child: Icon(
                  AppCubit.get(context).isBottomShown ? Icons.close : Icons.add,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color.fromARGB(47, 158, 158, 158),
                selectedItemColor: Color.fromARGB(255, 11, 85, 67),
                unselectedItemColor: Colors.teal,
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (int index) {
                  AppCubit.get(context).changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'New Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle),
                    label: 'Done Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archived Tasks',
                  ),
                ],
              ),
            );
          },
        ));
  }

  void openBottomSheet({
    context,
    task,
  }) {
    if (AppCubit.get(context).isBottomShown) {
      Navigator.pop(context);
      AppCubit.get(context).changeBottomVisibility(false);
    } else {
      if (task != null) {
        titleController..text = task['title'];
        timeController..text = task['time'];
        dateController..text = task['date'];
      }

      scaffoldKey.currentState!
          .showBottomSheet(
            (context) => Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 40.0,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          labelText: 'Task title',
                          prefixIcon: Icon(
                            Icons.label,
                          ),
                          // suffixIcon: Icon(
                          //   Icons.phone,
                          // ),
                        ),
                        validator: (String? text) {
                          if (text == null) return 'title can not be empty';

                          return null;
                        },
                        onChanged: (String text) {
                          //print(text);
                        },
                        onFieldSubmitted: (String text) {
                          //print(text);
                        },
                        //enabled: false,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: timeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          labelText: 'Task time',
                        prefixIcon: Icon(
                            Icons.alarm
                          ),
                          // suffixIcon: Icon(
                          //   Icons.phone,
                          // ),
                        ),
                        validator: (String? text) {
                          if (text == null) return 'time can not be empty';

                          return null;
                        },
                        onChanged: (String text) {
                          //print(text);
                        },
                        onFieldSubmitted: (String text) {
                          //print(text);
                        },
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text =
                                value!.format(context).toString();
                          });
                        },
                        //enabled: false,
                        keyboardType: TextInputType.datetime,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          labelText: 'Task date',
                          prefixIcon: Icon(
                            Icons.date_range
                          ),
                          // suffixIcon: Icon(
                          //   Icons.phone,
                          // ),
                        ),
                        validator: (String? text) {
                          if (text!.isEmpty) return 'date can not be empty';

                          return null;
                        },
                        onChanged: (String text) {
                          //print(text);
                        },
                        onFieldSubmitted: (String text) {
                          //print(text);
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2021-07-02'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                        //enabled: false,
                        keyboardType: TextInputType.datetime,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.teal,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (task != null) {
                                AppCubit.get(context).updateTask(
                                  time: timeController.text,
                                  title: titleController.text,
                                  date: dateController.text,
                                  id: task['id'],
                                );
                              } else {
                                AppCubit.get(context).insertTask(
                                  time: timeController.text,
                                  title: titleController.text,
                                  date: dateController.text,
                                );
                              }
                            }
                          },
                          child: Text(
                            task != null
                                ? 'update task'.toUpperCase()
                                : 'Add Task'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .closed
          .then((value) {
        AppCubit.get(context).changeBottomVisibility(false);
      });

      AppCubit.get(context).changeBottomVisibility(true);
    }
  }
}

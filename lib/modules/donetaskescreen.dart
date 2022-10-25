import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/shared/cubit/cuibt.dart';
import 'package:to_do_list/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.get(context).doneTasks.length > 0
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/photo3.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildTaskItem(
                      AppCubit.get(context).doneTasks[index], context),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[300],
                    thickness: 1.0,
                  ),
                  itemCount: AppCubit.get(context).doneTasks.length,
                ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'Not Tasks Yet, Please Add Some Tasks',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget buildTaskItem(task, context) => GestureDetector(
      onTap: () {
        AppCubit.get(context).openBottomSheetUpdate(task);
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          AppCubit.get(context).deleteTask(task['id']);
        },
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(123, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  child: Text(
                    task['time'].toString(),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['title'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        task['date'],
                      )
                    ],
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     AppCubit.get(context).updateTaskStatus(
                //       id: task['id'],
                //       status: 'done',
                //     );
                //   },
                //   icon: Icon(
                //     Icons.check_box,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).updateTaskStatus(
                      id: task['id'],
                      status: 'archived',
                    );
                  },
                  icon: Icon(
                    Icons.archive,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
}

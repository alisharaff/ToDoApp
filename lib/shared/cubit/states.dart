abstract class AppStates {}

class initiaState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}
/////

class TodoChangeBottomBarState extends AppStates {}

class TodoOpenDatabaseState extends AppStates {}

class TodoGetTasksState extends AppStates {}

class TodoUpdateTaskStatusState extends AppStates {}

class TodoUpdateTaskState extends AppStates {}

class TodoInsertTaskState extends AppStates {}

class TodoDeleteTaskState extends AppStates {}

class TodoBottomSheetState extends AppStates {}

class TodoBottomSheetUpdateState extends AppStates {
  dynamic task;

  TodoBottomSheetUpdateState({this.task});
}

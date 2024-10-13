import 'package:hive/hive.dart';
import 'package:taskatie/core/model/task_model.dart';

class AppLocalStorage {
  static late Box
      userBox; // dh el object (eky no3o Box) ely halef beh fe el app
  // late : showaya w h pass value

  static late Box<TaskModel> tasksBox;
  static init() {
    userBox = Hive.box('userBox');
    tasksBox = Hive.box<TaskModel>('tasksBox');
  }

  static cacheData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getCacheData(String key) {
    return userBox.get(key);
  }

  static cacheTaskData(String key, TaskModel value) {
    tasksBox.put(key, value);
  }

  static TaskModel? getCacheTaskData(String key) {
    return tasksBox.get(key);
  }
}

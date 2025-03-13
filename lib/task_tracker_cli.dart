import 'dart:convert';
import 'dart:io';

const String fileDb = "Db.json";

void createDatabase() {
  final File jsonDbFile = File(fileDb);

  if (!jsonDbFile.existsSync()) {
    jsonDbFile.createSync();
  }
}

bool jsonHasData() {
  final File jsonDbFile = File(fileDb);
  final String jsonData = jsonDbFile.readAsStringSync();

  return jsonData != '';
}

String readDatabase() {
  final File jsonDbFile = File(fileDb);

  return jsonDbFile.readAsStringSync();
}

void writeData(List<Map<String, dynamic>> jsonDb) {
  final File jsonDbFile = File(fileDb);
  final String newjsondb = jsonEncode(jsonDb);
  jsonDbFile.writeAsStringSync(newjsondb);
}

int createTask(String task) {
  int id = 1;
  List<Map<String, dynamic>> jsonDb = [];

  if (jsonHasData()) {
    jsonDb = List.from(jsonDecode(readDatabase()));
    id = jsonDb.last["id"] + 1;
  }

  final Map<String, dynamic> newtask = {
    "id": id,
    "discription": task,
    "status": "TODO",
    "createdAt": DateTime.now().toIso8601String(),
    "updatedAt": DateTime.now().toIso8601String(),
  };
  jsonDb.add(newtask);

  writeData(jsonDb);
  return id;
}

void deleteTask(int taskid) {
  List<Map<String, dynamic>> jsonDb = List.from(jsonDecode(readDatabase()));

  List<Map<String, dynamic>> newJsonDb =
      jsonDb.where((task) => task["id"] != taskid).toList();

  writeData(newJsonDb);
}

List<Map<String, dynamic>> listByStatus(String filter) {
  List<Map<String, dynamic>> jsonDb = List.from(jsonDecode(readDatabase()));

  List<Map<String, dynamic>> newJsonDb =
      jsonDb.where((task) => task["status"] == filter).toList();

  return newJsonDb;
}

void updateTask(int taskid, String? status, String? discription) {
  List<Map<String, dynamic>> jsonDb = List.from(jsonDecode(readDatabase()));
  List<Map<String, dynamic>> newJsonDb = [];
  for (final task in jsonDb) {
    if (task["id"] == taskid) {
      if (status != null) {
        task["status"] = status;
      } else if (discription != null) {
        task["discription"] = discription;
      }
      task["updatedAt"] = DateTime.now().toIso8601String();
    }
    newJsonDb.add(task);
  }
  writeData(newJsonDb);
}

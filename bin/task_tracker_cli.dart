import 'dart:convert';
import 'dart:io';

import 'package:task_tracker_cli/task_tracker_cli.dart';

void main(List<String> arguments) {
  createDatabase();
  while (true) {
    stdout.write("task-cli ");
    String userInput = stdin.readLineSync()!;

    while (userInput.trim() == '') {
      stdout.writeln("\n Invalid input! \n");
      stdout.write("task-cli ");
      userInput = stdin.readLineSync()!;
    }
    if (userInput == "exit") exit(0);
    final RegExp pattern = RegExp('\\s(?=(?:[^\'"]|\'[^\']*\'|"[^"]*")*\$)');
    final List<String> splitUserInput = userInput.split(pattern);
    final String cmd = splitUserInput[0];

    switch (cmd) {
      case 'add':
        final String taskDiscription = splitUserInput.sublist(1).join(' ');

        if (splitUserInput[1].length == 1) {
          print("\n provide valid discription\n");
        } else if (!taskDiscription.contains('"')) {
          print("\n invalid task valid format");
        } else {
          int id = createTask(taskDiscription);

          print('\ntask created and id is $id\n');
        }
        break;
      case 'delete':
        try {
          final int taskid = int.parse(splitUserInput[1]);
          deleteTask(taskid);
          print("\n task is deleted succesfully\n");
        } catch (e) {
          stdout.writeln("\n enter the valid Id\n");
        }
        break;

      case 'list':
        if (!jsonHasData()) {
          print("\nno task yet\n");
        } else {
          if (splitUserInput.length == 1) {
            final List<Map<String, dynamic>> allDb =
                List.from(jsonDecode(readDatabase()));
            if (allDb.isEmpty) {
              print("\n No Task Yet\n");
            } else {
              print("===========");
              print("\nListing all element\n");
              print("===========");
              for (final elem in allDb) {
                print("id: ${elem["id"]}");
                print("description: ${elem["discription"]}");
                print("status: ${elem["status"]}");
                print("createdAt: ${elem["createdAt"]}");
                print("updatedAt: ${elem["updatedAt"]}");
                print("=================\n");
              }
            }
          } else {
            final String filter = splitUserInput[1];
            final List<Map<String, dynamic>> filteredData =
                listByStatus(filter);
            if (filteredData.isEmpty) {
              print("\n no $filter task");
            } else {
              print("===========");
              print("\nListing all element\n");
              print("===========");
              for (final elem in filteredData) {
                print("id: ${elem["id"]}");
                print("description: ${elem["discription"]}");
                print("status: ${elem["status"]}");
                print("createdAt: ${elem["createdAt"]}");
                print("updatedAt: ${elem["updatedAt"]}");
                print("=================\n");
              }
            }
          }
        }
        break;
      case 'mark-done':
        try {
          final int taskId = int.parse(splitUserInput[1]);
          updateTask(taskId, 'done', null);
          print("\ntask mark update\n");
        } catch (e) {
          print("\n task id must be valid\n");
        }
        break;

      case 'mark-in-progress':
        try {
          final int taskId = int.parse(splitUserInput[1]);
          updateTask(taskId, 'progress', null);
          print("\ntask mark progess\n");
        } catch (e) {
          print("\n task id must be valid\n");
        }
        break;

      case 'update':
        if (splitUserInput.isNotEmpty && splitUserInput.length < 3) {
          print("\nNo task ID provided or new description\n");
        } else {
          try {
            final String taskDiscription = splitUserInput.last;
            final int taskId = int.parse(splitUserInput[1]);

            if (!taskDiscription.contains('"')) {
              print("invalid format");
            } else {
              updateTask(taskId, null, taskDiscription.replaceAll("", ''));
              print('\ntask update\n');
            }
          } catch (e) {
            print("\nTask ID must be a valid number\n");
          }
        }
        break;

      default:
        print("\ninvalid cmd\n");
    }
  }
}



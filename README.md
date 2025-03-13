Task Tracker CLI [https://roadmap.sh/projects/task-tracker]
Task Tracker CLI is an application that helps you to manage your tasks efficiently.

Installation
First of all, make sure you have Dart installed. If you don't, go to Dart site and follow the steps listed there or you can install it also from Flutter site following the instructions for your OS.

Once you've installed Dart, just clone this repo and go to the directory to run the .dart file in /bin directory.
```
$ cd task_tracker
$ dart run bin/task_tracker_cli.dart
```
And that's it! You can use now the application.

Usage
When you run the application, you'll see in the terminal the next prompt:

task-cli 
use any of these commands:
```
add
list
list todo
list done
list in-progress
update
delete
mark-done
mark-in-progress
exit
add:
```
Adds a new task to the database. The name of the task must be in double quotes.

task-cli add "Test task"
list
This command shows you all the tasks that you have in the database but, you can also filter by task status.

task-cli list
list todo
Shows all the tasks that have a todo status.

task-cli list todo
list done
Shows all the tasks that have a done status.

task-cli list done
list in-progress
Shows all the tasks that have an in-progress status.

task-cli list in-progress
update
Updates the specified task description. You must specify the id of the task that you want to update followed by the new description.

task-cli update 2 "Modified description"
delete
Deletes the desired task from the database. You must specify the id of the task that you want to delete.

task-cli delete 2
mark-done
Sets a task status as done. You must specify the id of the task that you want to mark.

task-cli mark-done 3
mark-in-progress
Sets a task status as in-progress. You must specify the id of the task that you want to mark.

task-cli mark-in-progress 1
exit
Finishes the application.

task-cli exit

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/model/task_model.dart';

class DatabaseService {
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection("tasks");
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addTaskItem(String title, String description) async {
    return await taskCollection.add({
      "uid": user!.uid,
      "title": title,
      "description": description,
      "completed": false,
      //"createAt": FieldValue.serverTimestamp()
    });
  }

  Future<void> updateTask(String id, String title, String description) async {
    final updatetaskcollection = FirebaseFirestore.instance.collection("tasks").doc(id);
    return await updatetaskcollection.update({
      "title": title,
      "description": description
    });
  }

  Future<void> updateTaskStatus(String id, bool completed) async {
    return await taskCollection.doc(id).update({"completed": completed});
  }

  Future<void> deleteTask(String id) async {
    return await taskCollection.doc(id).delete();
  }

  Stream<List<Task>> get tasks {
    return taskCollection
        .where("uid", isEqualTo: user!.uid)
        .where("completed", isEqualTo: false)
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  Stream<List<Task>> get completedtasks {
    return taskCollection
        .where("uid", isEqualTo: user!.uid)
        .where("completed", isEqualTo: true)
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        id: doc.id,
        title: doc["title"] ?? "",
        description: doc["description"] ?? "",
        completed: doc["completed"] ?? false,
        //timestamp: doc["createAt"] ?? Timestamp.now(),
      );
    }).toList();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class FirebaseService {

  Future<void> addTask(String title, String description) async {

      await firebaseFirestore.collection('tasks').add({
        'title': title,
        'description': description,
        'created_at': FieldValue.serverTimestamp(),
      }).catchError((e) {
        // print(e.toString());
        throw e;
      }).whenComplete(() {
        // print('Task added successfully');
      });
    }

    Future<void> deleteTask(String taskId) async {
      await firebaseFirestore.collection('tasks').doc(taskId).delete().catchError((e) {
        // print(e.toString());
        throw e;
      }).whenComplete(() {
        // print('Task deleted successfully');
      });
    }

  }

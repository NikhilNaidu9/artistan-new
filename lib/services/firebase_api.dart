import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password protected is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

signOut() {
  FirebaseAuth.instance.signOut();
}

Future<bool> addArtistUserData(Map<String, dynamic> data?) {
  String uid = FirebaseAuth.instance.currentUser.uid;
  try {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('artist')
        .doc(uid)
        .collection('data')
        .doc('profile');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set(data);
        print('qw');
        return true;
      }
      transaction.update(documentReference, data);
      print('qw');
      return true;
    });
  } catch (e) {
    print(e);
  }
}

Future<bool> addClientUserData(Map<String, dynamic> data?) {
  String uid = FirebaseAuth.instance.currentUser.uid;
  try {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('client')
        .doc(uid)
        .collection('data')
        .doc('profile');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set(data);
        print('qw');
        return true;
      }
      transaction.update(documentReference, data);
      print('qw');
      return true;
    });
  } catch (e) {
    print(e);
  }
}

// Fetch User Data


Future<bool> addOngoingJob(String id?, Map<String, dynamic> data?) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference ongoingJobReference = FirebaseFirestore.instance
        .collection('client')
        .doc(uid)
        .collection('jobs')
        .doc('ongoing')
        .collection('ongoing')
        .doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(ongoingJobReference);
      if (!snapshot.exists) {
        print('1');
        ongoingJobReference.set(data);
        return true;
      }
      transaction.update(ongoingJobReference, {'job_category': id});
      return true;
    });



  } catch (e) {
    return false;
  }
}

Future<bool> addAllJob(String id?, Map<String, dynamic> data?) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference allJobsReference = FirebaseFirestore.instance
        .collection('jobs')
        .doc();

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot _snapshot = await transaction.get(allJobsReference);
      if (!_snapshot.exists) {
        print('1');
        allJobsReference.set(data);
        return true;
      }
      transaction.update(allJobsReference, {'job_category': id});
      return true;
    });
  } catch (e) {
    return false;
  }
}

Future<bool> removeJob(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance
      .collection('client')
      .doc(uid)
      .collection('jobs')
      .doc('ongoing')
      .collection('ongoing')
      .doc(id)
      .delete();
  return true;
}

Future<bool> completeJob(String id, Map<String, dynamic> data) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  try {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('client')
        .doc(uid)
        .collection('jobs')
        .doc('completed')
        .collection('completed')
        .doc();

    print('Data 2: $data');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set(data);
        print('done');
        return true;
      }
      transaction.update(documentReference, data);
      return true;
    });
  } catch (e) {
    print(e);
  }
  return true;
}

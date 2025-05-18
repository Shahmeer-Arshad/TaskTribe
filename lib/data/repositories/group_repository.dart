import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/group_model.dart';

class GroupRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GroupRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // 🔹 Get groups from Firestore
  Future<List<GroupModel>> getGroups() async {
    try {
      final snapshot = await _firestore.collection('groups').get();
      return snapshot.docs.map((doc) => GroupModel.fromFirestore(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // 🔹 Create new group (if needed later)
  Future<void> createGroup(GroupModel group) async {
    try {
      await _firestore.collection('groups').add(group.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // 🔹 Optionally get current user
  User? get currentUser => _auth.currentUser;
}

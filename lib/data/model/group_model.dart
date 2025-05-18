import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String name;
  final String subject;
  final String description;
  final String createdBy; // ✅ new field
  final Timestamp createdAt; // ✅ new field (Firestore Timestamp)

  GroupModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel(
      id: doc.id,
      name: data['name'] ?? '',
      subject: data['subject'] ?? '',
      description: data['description'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subject': subject,
      'description': description,
      'createdBy': createdBy, // ✅ added to map
      'createdAt': createdAt, // ✅ added to map
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String name;
  final String subject;
  final String description;

  GroupModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.description,
  });

  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel(
      id: doc.id,
      name: data['name'] ?? '',
      subject: data['subject'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subject': subject,
      'description': description,
    };
  }
}

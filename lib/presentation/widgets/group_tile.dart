import 'package:flutter/material.dart';
import 'package:gtk_flutter/data/model/group_model.dart';

class GroupTile extends StatelessWidget {
  final GroupModel group;

  const GroupTile({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.subject),
      onTap: () {
        // TODO: Navigate to chat screen later
      },
    );
  }
}

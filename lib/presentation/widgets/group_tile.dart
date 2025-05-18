import 'package:flutter/material.dart';
import 'package:gtk_flutter/data/model/group_model.dart';
import 'package:intl/intl.dart'; // For date formatting

class GroupTile extends StatelessWidget {
  final GroupModel group;

  const GroupTile({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // Format timestamp if available
    String createdAtText =
        group.createdAt != null
            ? DateFormat.yMMMd().add_jm().format(group.createdAt!.toDate())
            : 'Unknown time';

    return ListTile(
      title: Text(group.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subject: ${group.subject}'),
          Text('Created by: ${group.createdBy}'),
          Text('Created at: $createdAtText'),
        ],
      ),
      isThreeLine: true,
      onTap: () {
        // TODO: Navigate to chat screen later
      },
    );
  }
}

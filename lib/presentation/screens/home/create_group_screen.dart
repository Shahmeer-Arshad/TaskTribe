import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtk_flutter/logic/blocs/group/group_bloc.dart';
import 'package:gtk_flutter/logic/blocs/group/group_event.dart';
import 'package:gtk_flutter/logic/blocs/group/group_state.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  void _submitGroup() {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final subject = subjectController.text.trim();
      final description = descriptionController.text.trim();

      context.read<GroupBloc>().add(
        CreateGroup(name: name, subject: subject, description: description),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
      body: BlocListener<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupCreated) {
            Navigator.pop(context); // Close the screen on success
          } else if (state is GroupError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Group Name'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter group name'
                              : null,
                ),
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter subject'
                              : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter description'
                              : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitGroup,
                  child: const Text('Create Group'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

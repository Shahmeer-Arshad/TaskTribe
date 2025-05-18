import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtk_flutter/data/repositories/group_repository.dart';
import 'package:gtk_flutter/logic/blocs/group/group_bloc.dart';
import 'package:gtk_flutter/logic/blocs/group/group_event.dart';
import 'package:gtk_flutter/logic/blocs/group/group_state.dart';
import 'package:gtk_flutter/presentation/widgets/group_tile.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupBloc(groupRepository: GroupRepository())..add(LoadGroups()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Study Groups")),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is GroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupLoaded) {
              if (state.groups.isEmpty) {
                return const Center(child: Text("No groups found."));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<GroupBloc>().add(LoadGroups());
                },
                child: ListView.builder(
                  itemCount: state.groups.length,
                  itemBuilder: (context, index) {
                    final group = state.groups[index];
                    return GroupTile(group: group);
                  },
                ),
              );
            } else if (state is GroupError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

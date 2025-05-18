import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtk_flutter/data/repositories/group_repository.dart';
import 'group_event.dart';
import 'group_state.dart';
import 'package:gtk_flutter/data/model/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc({required this.groupRepository}) : super(GroupInitial()) {
    on<LoadGroups>((event, emit) async {
      emit(GroupLoading());
      try {
        final groups = await groupRepository.getGroups();
        emit(GroupLoaded(groups));
      } catch (e) {
        emit(GroupError('Failed to load groups: $e'));
      }
    });

    on<CreateGroup>((event, emit) async {
      try {
        final user = groupRepository.currentUser;
        if (user == null) {
          emit(GroupError('User not logged in'));
          return;
        }

        final group = GroupModel(
          id: '',
          name: event.name,
          subject: event.subject,
          description: event.description,
          createdBy: user.uid,
          createdAt: Timestamp.now(),
        );

        await groupRepository.createGroup(group);

        emit(GroupCreated()); // A new state indicating success
      } catch (e) {
        emit(GroupError('Failed to create group: $e'));
      }
    });
  }
}

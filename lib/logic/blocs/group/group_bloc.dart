import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gtk_flutter/data/repositories/group_repository.dart';

import 'group_event.dart';
import 'group_state.dart';

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
  }
}

import 'package:gtk_flutter/data/model/group_model.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupModel> groups;

  GroupLoaded(this.groups);
}

class GroupCreated
    extends GroupState {} // ✅ Add this state for success after creation

class GroupError extends GroupState {
  final String message;

  GroupError(this.message);
}

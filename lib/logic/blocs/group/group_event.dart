// group_event.dart
abstract class GroupEvent {}

class LoadGroups extends GroupEvent {}

class CreateGroup extends GroupEvent {
  final String name;
  final String subject;
  final String description;

  CreateGroup({
    required this.name,
    required this.subject,
    required this.description,
  });
}

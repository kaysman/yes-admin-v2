import 'package:equatable/equatable.dart';

class CurrentPage with EquatableMixin {
  final int firstId;
  final int lastId;

  CurrentPage({
    required this.firstId,
    required this.lastId,
  });

  @override
  List<Object?> get props => [firstId, lastId];
}

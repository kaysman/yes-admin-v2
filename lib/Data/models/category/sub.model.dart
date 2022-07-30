import 'package:equatable/equatable.dart';

class SubItem with EquatableMixin {
  final int id;
  final String? name;
  final String? parentName;

  SubItem(this.id, this.name, this.parentName);

  @override
  List<Object?> get props => [this.id];
}



import 'package:equatable/equatable.dart';

class Actor extends Equatable{
  final String name;
  final String profileUrl;

  const Actor({required this.name,required this.profileUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
import 'package:equatable/equatable.dart';
import '../../../models/post_model.dart';
import '../../../models/todo_model.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object?> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final List<Post> posts;
  final List<Todo> todos;

  const UserDetailsLoaded({required this.posts, required this.todos});

  @override
  List<Object?> get props => [posts, todos];
}

class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import '../../../models/user_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool hasMore;
  final int skip;

  const UserListLoaded({
    required this.users,
    required this.hasMore,
    required this.skip,
  });

  @override
  List<Object?> get props => [users, hasMore, skip];
}

class UserListError extends UserListState {
  final String message;

  const UserListError(this.message);

  @override
  List<Object?> get props => [message];
}

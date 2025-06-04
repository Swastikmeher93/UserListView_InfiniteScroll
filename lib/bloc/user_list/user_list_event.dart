import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserListEvent {
  const FetchUsers();
}

class LoadMoreUsers extends UserListEvent {
  const LoadMoreUsers();
}

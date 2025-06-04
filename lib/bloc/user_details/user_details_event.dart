import 'package:equatable/equatable.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserDetails extends UserDetailsEvent {
  final int userId;

  const FetchUserDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../models/user_model.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final int limit = 30;
  int skip = 0;
  List<User> users = [];
  bool hasMore = true;

  UserListBloc() : super(UserListInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
  }

  Future<void> _onFetchUsers(
      FetchUsers event, Emitter<UserListState> emit) async {
    emit(UserListLoading());
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/users?skip=0&limit=$limit'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['users'];
        final int total = data['total'];
        users = usersJson.map((json) => User.fromJson(json)).toList();
        skip = limit;
        hasMore = skip < total;
        emit(UserListLoaded(users: users, hasMore: hasMore, skip: skip));
      } else {
        emit(const UserListError('Failed to load users'));
      }
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<UserListState> emit) async {
    if (!hasMore || state is UserListLoading) return;
    emit(UserListLoading());
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/users?skip=$skip&limit=$limit'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['users'];
        final int total = data['total'];
        users.addAll(usersJson.map((json) => User.fromJson(json)));
        skip += limit;
        hasMore = skip < total;
        emit(UserListLoaded(
            users: List.from(users), hasMore: hasMore, skip: skip));
      } else {
        emit(const UserListError('Failed to load more users'));
      }
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }
}

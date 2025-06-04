import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../models/post_model.dart';
import '../../../models/todo_model.dart';
import 'user_details_event.dart';
import 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<UserDetailsState> emit) async {
    emit(UserDetailsLoading());
    try {
      final postsResponse = await http.get(
        Uri.parse('https://dummyjson.com/posts?userId=${event.userId}'),
      );
      final todosResponse = await http.get(
        Uri.parse('https://dummyjson.com/todos?userId=${event.userId}'),
      );

      if (postsResponse.statusCode == 200 && todosResponse.statusCode == 200) {
        final postsData = jsonDecode(postsResponse.body);
        final todosData = jsonDecode(todosResponse.body);
        final List<dynamic> postsJson = postsData['posts'];
        final List<dynamic> todosJson = todosData['todos'];
        final posts = postsJson.map((json) => Post.fromJson(json)).toList();
        final todos = todosJson.map((json) => Todo.fromJson(json)).toList();
        emit(UserDetailsLoaded(posts: posts, todos: todos));
      } else {
        emit(const UserDetailsError('Failed to load user details'));
      }
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}

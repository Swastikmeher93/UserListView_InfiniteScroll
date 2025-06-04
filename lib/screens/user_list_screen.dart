import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_list/user_list_bloc.dart';
import '../bloc/user_list/user_list_event.dart';
import '../bloc/user_list/user_list_state.dart';
import '../models/user_model.dart';
import 'user_details_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserListBloc>().add(const FetchUsers());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<UserListBloc>().add(const LoadMoreUsers());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListInitial ||
              (state is UserListLoading && state is! UserListLoaded)) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserListError) {
            return Center(child: Text(state.message));
          }
          if (state is UserListLoaded) {
            final users = state.users;
            final hasMore = state.hasMore;
            return ListView.builder(
              controller: _scrollController,
              itemCount: users.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == users.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.image),
                    backgroundColor: Colors.grey[300],
                    child: user.image.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text('Email: ${user.email}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(user: user),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

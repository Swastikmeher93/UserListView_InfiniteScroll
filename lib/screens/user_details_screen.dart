import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_details/user_details_bloc.dart';
import '../bloc/user_details/user_details_event.dart';
import '../bloc/user_details/user_details_state.dart';
import '../models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsBloc()..add(FetchUserDetails(user.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.firstName} ${user.lastName}'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        user.image.isNotEmpty ? NetworkImage(user.image) : null,
                    backgroundColor: Colors.grey[300],
                    child: user.image.isEmpty
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Email: ${user.email}',
                    style: const TextStyle(fontSize: 16)),
                Text('Phone: ${user.phone}',
                    style: const TextStyle(fontSize: 16)),
                Text('Age: ${user.age}', style: const TextStyle(fontSize: 16)),
                Text('Gender: ${user.gender}',
                    style: const TextStyle(fontSize: 16)),
                if (user.maidenName != null && user.maidenName!.isNotEmpty)
                  Text('Maiden Name: ${user.maidenName}',
                      style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text('Posts',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                BlocBuilder<UserDetailsBloc, UserDetailsState>(
                  builder: (context, state) {
                    if (state is UserDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is UserDetailsError) {
                      return Text(state.message);
                    }
                    if (state is UserDetailsLoaded) {
                      final posts = state.posts;
                      return posts.isEmpty
                          ? const Text('No posts available')
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Likes: ${post.reactions.likes}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Views: ${post.views}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20),
                const Text('Todos',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                BlocBuilder<UserDetailsBloc, UserDetailsState>(
                  builder: (context, state) {
                    if (state is UserDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is UserDetailsError) {
                      return Text(state.message);
                    }
                    if (state is UserDetailsLoaded) {
                      final todos = state.todos;
                      return todos.isEmpty
                          ? const Text('No todos available')
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                final todo = todos[index];
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            todo.todo,
                                            style:
                                                const TextStyle(fontSize: 14),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Checkbox(
                                          value: todo.completed,
                                          onChanged: null,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

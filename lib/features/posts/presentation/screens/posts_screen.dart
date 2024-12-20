import 'package:clean_architecture_flutter/features/authentication/presentation/state/auth_state_notifier.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/states/posts_state.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/states/tags_state.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/widgets/posts_list_item.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/widgets/posts_search_bar.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/widgets/tags_tap_item.dart';
import 'package:clean_architecture_flutter/shared/widget/app_errors.dart';
import 'package:clean_architecture_flutter/shared/widget/app_loading.dart';
import 'package:clean_architecture_flutter/shared/widget/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
 
  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsNotifierProvider);
    final tagsState = ref.watch(tagsNotifierProvider);

    final authState = ref.watch(authStateNotifierProvider);
    final user = authState.user;
    final prefix = user?.gender != null && user!.gender.contains('female')
        ? 'Mrs.'
        : 'Mr.';

    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        title: !_isSearching
            ? Text(
                user != null ? "Hello $prefix${user.firstName}" : "Hello Guest",
                style: const TextStyle(fontSize: 20, fontFamily: 'Prompt'),
              )
            : PostsSearchBar(
                textController: _searchController,
                onSearchChanged: (value) {
                  if (value.isEmpty) {
                    ref.read(postsNotifierProvider.notifier).fetchPosts();
                  } else {
                    ref.read(postsNotifierProvider.notifier).filterPosts(value);
                  }
                }),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  ref.read(postsNotifierProvider.notifier).fetchPosts();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.centerLeft, // ชิดขวา
              child: Text("Popular Tags",style: TextStyle(fontFamily: 'Prompt'),),
            ),
          ),
          tagsState.when(
            data: (tags) {
              final tagsNotifier = ref.watch(tagsNotifierProvider.notifier);
              final posts = postsState.value;

              if (posts != null) {
                tagsNotifier.calculateMostUsedTags(posts, topN: 10);
              }

              final mostUsedTags = tagsNotifier.mostUsedTags;

              return SizedBox(
                height: 100, // กำหนดความสูงของ ListView ในแนวนอน
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // กำหนดให้เลื่อนในแนวนอน
                  itemCount: mostUsedTags.length, // จำนวน item ใน List
                  itemBuilder: (context, index) {
                    final tag = mostUsedTags[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TagsTapItem(tag_item: tag),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) => AppErrorsDisplay(error),
            loading: () => const AppLoading(),
          ),
          postsState.when(
            data: (posts) {
              return Expanded(
                child: posts.isNotEmpty
                    ? ListView(
                        children: posts.map((post) {
                          return PostItem(post);
                        }).toList(),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                          "Post search results not found",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
              );
            },
            loading: () => const AppLoading(),
            error: (error, stackTrace) => AppErrorsDisplay(error),
          ),
        ],
      ), 
      // UI =>  State <=> Provider <=> Repository => Data Source => Data
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 1));
          ref.read(postsNotifierProvider.notifier).fetchPosts();
          print("refresh posts");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

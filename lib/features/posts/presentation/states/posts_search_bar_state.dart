import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsSearchState {
  final String query;
  final bool isSearching;

  PostsSearchState({required this.query, required this.isSearching});
}

class PostsSearchNotifier extends StateNotifier<PostsSearchState> {
  PostsSearchNotifier() : super(PostsSearchState(query: '', isSearching: false));

  void setSearchQuery(String query) {
    state = PostsSearchState(query: query, isSearching: true);
  }

    void toggleSearch() {
    state = PostsSearchState(isSearching: !state.isSearching, query: state.query);
  }
  void clearSearch() {
    state = PostsSearchState(query: '', isSearching: false);
  }
}

final postsSearchProvider = StateNotifierProvider<PostsSearchNotifier, PostsSearchState>((ref) {
  return PostsSearchNotifier();
});



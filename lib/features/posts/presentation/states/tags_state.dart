import 'package:clean_architecture_flutter/features/posts/domain/providers/tags_provider.dart';
import 'package:clean_architecture_flutter/features/posts/domain/repositories/tags_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/posts.dart';
import 'package:clean_architecture_flutter/shared/data/models/tags.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsNotifier extends StateNotifier<AsyncValue<List<Tags>>> {
  final TagsRepository tagsRepository;
  List<Tags> mostUsedTags = []; // เก็บผลลัพธ์ที่คำนวณไว้ล่าสุด

  TagsNotifier(this.tagsRepository) : super(const AsyncValue.loading()) {
    getPostTags();
  }

  Future<void> getPostTags() async {
    try {
      final tags = await tagsRepository.getPostTags();
      state = AsyncValue.data(tags);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print('Error fetching tags: $e');
      print('Stack Trace: $stackTrace');
    }
  }

  void calculateMostUsedTags(List<Posts> posts, {required int topN}) {
    if (state is! AsyncData) return;

    final tags = (state as AsyncData<List<Tags>>).value;
    final tagCountMap = <String, int>{};

    // นับจำนวนการใช้ tags ในโพสต์
    for (var post in posts) {
      for (var tag in post.tags) {
        tagCountMap[tag] = (tagCountMap[tag] ?? 0) + 1;
      }
    }

    // เรียง tags ตามการใช้งาน และเลือก topN
    final sortedTags = tagCountMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final mostUsedTagNames = sortedTags.take(topN).map((e) => e.key).toList();

    // กรอง tags ที่ตรงกับ topN
    mostUsedTags = tags.where((tag) => mostUsedTagNames.contains(tag.tag)).toList();
  }
}

final tagsNotifierProvider = StateNotifierProvider<TagsNotifier, AsyncValue<List<Tags>>>(
  (ref) {
    final tagsRepository = ref.watch(tagsRepositoryProvider);
    return TagsNotifier(tagsRepository);
  },
);

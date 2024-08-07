import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intern_dictionary/src/core/service/api_service.dart';
import 'package:intern_dictionary/src/core/model/word_model.dart';


final fetchWordsRepositoryProvider =
    Provider((ref) => FetchWordsRepositoryServiceImpl(Client()));

final synoProvider = StateProvider<String>((ref) => "");
final antoProvider = StateProvider<String>((ref) => "");

final wordProvider = StateProvider<String>((ref) => "");


final dicitonaryProvider = FutureProvider<List<Word>>((ref) async{
  final word = ref.watch(wordProvider);
  final data = await ref.watch(fetchWordsRepositoryProvider).fetchMeaning(word);
  return data;
});



final synoDicitonaryProvider = FutureProvider<List<Word>>((ref) async{
  final word = ref.watch(synoProvider);
  final data = await ref.watch(fetchWordsRepositoryProvider).fetchMeaning(word);
  return data;
});




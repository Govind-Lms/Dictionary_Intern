import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../model/word_model.dart';


abstract class FetchWordsRepositoryService {
  Future fetchMeaning(String word);
}

class FetchWordsRepositoryServiceImpl implements FetchWordsRepositoryService {
  final Client client;
  FetchWordsRepositoryServiceImpl(this.client);

  @override
  Future<List<Word>> fetchMeaning(String word) async {
    try{
      final response = await client.get(Uri.https(
        'api.dictionaryapi.dev', 'api/v2/entries/en/$word'));
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body) as List<dynamic>;
          
          return data.map((e)=> Word.fromJson(e)).toList();

        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw WordNotFoundException();
        default:
          throw UnknownException();
      }
      }
      on SocketException catch (_) {
      throw UnknownException();
    } 
    
  }
}

class InvalidApiKeyException implements Exception {
  final String message;
  InvalidApiKeyException({this.message = 'Invalid Api Key'});

  @override
  String toString() => 'Invalid Api: $message';
}

class UnknownException implements Exception {
  final String message;
  UnknownException({this.message = 'Unknown Exception'});

  @override
  String toString() => 'Unkown Error Exception: $message';
}

class WordNotFoundException implements Exception {
  final String message;
  WordNotFoundException({this.message = 'Requested word was not found.'});

  @override
  String toString() => 'WordNotFoundException: $message';
}

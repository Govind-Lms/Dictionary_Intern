import 'dart:convert';

import 'package:hive/hive.dart';
part "word_model.g.dart";

List<Word> wordFromJson(String str) =>
    List<Word>.from(json.decode(str).map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



@HiveType(typeId: 1)
class Word extends HiveObject{

  @HiveField(4)
  bool? isFav = false;
  
  @HiveField(0)
  String? word;
  
  @HiveField(1)
  String? phonetic;
  
  @HiveField(2)
  List<Phonetic>? phonetics;

  @HiveField(3)
  List<Meaning>? meanings;

  Word({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: List<Phonetic>.from(
            json["phonetics"].map((x) => Phonetic.fromJson(x))),
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": List<dynamic>.from(phonetics!.map((x) => x.toJson())),
        "meanings": List<dynamic>.from(meanings!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 2)
class Meaning extends HiveObject{

  @HiveField(0)
  String? partOfSpeech;
  @HiveField(1)
  List<Definition>? definitions;
  @HiveField(2)
  List<String>? synonyms;
  @HiveField(3)
  List<dynamic>? antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "synonyms": List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms!.map((x) => x)),
      };
}
@HiveType(typeId: 3)
class Definition extends HiveObject{

  @HiveField(0)
  String? definition;
  @HiveField(1)
  List<String>? synonyms;
  @HiveField(2)
  List<dynamic>? antonyms;
  @HiveField(3)
  String? example;

  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
        example: json["example"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms": List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms!.map((x) => x)),
        "example": example,
      };
}
@HiveType(typeId: 4)
class Phonetic extends HiveObject{
  @HiveField(0)
  String? text;
  @HiveField(1)
  String? audio;

  Phonetic({
    required this.text,
    required this.audio,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "audio": audio,
      };
}

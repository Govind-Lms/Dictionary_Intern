// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 1;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      word: fields[0] as String?,
      phonetic: fields[1] as String?,
      phonetics: (fields[2] as List?)?.cast<Phonetic>(),
      meanings: (fields[3] as List?)?.cast<Meaning>(),
    )..isFav = fields[4] as bool?;
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.isFav)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.phonetic)
      ..writeByte(2)
      ..write(obj.phonetics)
      ..writeByte(3)
      ..write(obj.meanings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeaningAdapter extends TypeAdapter<Meaning> {
  @override
  final int typeId = 2;

  @override
  Meaning read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meaning(
      partOfSpeech: fields[0] as String?,
      definitions: (fields[1] as List?)?.cast<Definition>(),
      synonyms: (fields[2] as List?)?.cast<String>(),
      antonyms: (fields[3] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Meaning obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.partOfSpeech)
      ..writeByte(1)
      ..write(obj.definitions)
      ..writeByte(2)
      ..write(obj.synonyms)
      ..writeByte(3)
      ..write(obj.antonyms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeaningAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DefinitionAdapter extends TypeAdapter<Definition> {
  @override
  final int typeId = 3;

  @override
  Definition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Definition(
      definition: fields[0] as String?,
      synonyms: (fields[1] as List?)?.cast<String>(),
      antonyms: (fields[2] as List?)?.cast<dynamic>(),
      example: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Definition obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.definition)
      ..writeByte(1)
      ..write(obj.synonyms)
      ..writeByte(2)
      ..write(obj.antonyms)
      ..writeByte(3)
      ..write(obj.example);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefinitionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhoneticAdapter extends TypeAdapter<Phonetic> {
  @override
  final int typeId = 4;

  @override
  Phonetic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phonetic(
      text: fields[0] as String?,
      audio: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Phonetic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.audio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

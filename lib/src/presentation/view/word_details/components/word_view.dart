import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/const/constant.dart';
import 'package:intern_dictionary/src/presentation/widget/translate_widget.dart';

import '../../../../core/model/word_model.dart';
import '../../../../const/style.dart';

class WordView extends ConsumerWidget {
  final String? phonetic;
  final String? word;
  final List<Meaning?>? meanings;
  const WordView(
      {required this.word,
      required this.phonetic,
      required this.meanings,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            isTranslated == false ?  Text("$word",
                style: Style.wordStyle.copyWith(color: theme.primaryColor)) : TranslateWidget(toTranslate: '$word'),
            const SizedBox(width: 20.0),
            CircleAvatar(
              radius: 20,
              backgroundColor: theme.primaryColor.withOpacity(.3),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.volume_up_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            
            const SizedBox(width: 20.0),
          ],
        ),
        Row(
          children: [
            Text(phonetic ?? 'Empty ',
                style: Style.phoneticStyle.copyWith(color: theme.primaryColor)),
            Text(meanings![0]?.partOfSpeech ?? "Empty",
                style: Style.partOfSpeechStyle
                    .copyWith(color: theme.primaryColor)),
          ],
        ),
      ],
    );
  }
}

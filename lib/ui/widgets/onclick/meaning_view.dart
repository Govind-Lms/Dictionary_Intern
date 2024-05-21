import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/word_model.dart';
import '../../../theme/style.dart';

class MeaningView extends ConsumerWidget {
  final List<Meaning> meanings;
  const MeaningView( {required this.meanings, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 400.0,
      child: Expanded(
        child: Scrollbar(
          controller: PageController(),
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: meanings[0].definitions!.length,
            itemBuilder: (BuildContext context, int index) {
              final defination = meanings[0].definitions![index];
              return ExpandableNotifier(
                child: Expandable(
                  collapsed: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpandableButton(
                      child: Row(
                        children: [
                          Text(
                            "↠ Defination ${index + 1}",
                            textAlign: TextAlign.justify,
                            style: Style.partOfSpeechStyle
                                .copyWith(color: theme.primaryColor),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  expanded: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableButton(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_drop_up_sharp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          'Defination',
                          style: Style.wordStyle.copyWith(
                              color: theme.primaryColor, fontSize: 18.0),
                        ),
                        Text(
                          "${defination.definition} ",
                          textAlign: TextAlign.justify,
                          style: Style.partOfSpeechStyle
                              .copyWith(color: theme.primaryColor),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Example',
                          style: Style.wordStyle.copyWith(
                              color: theme.primaryColor, fontSize: 18.0),
                        ),
                        Text(
                          defination.example ?? "No Example available",
                          textAlign: TextAlign.justify,
                          style: Style.partOfSpeechStyle
                              .copyWith(color: theme.primaryColor),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Synonyms',
                          style: Style.wordStyle.copyWith(
                              color: theme.primaryColor, fontSize: 18.0),
                        ),
                        Text(
                          "${defination.synonyms!.map((e) => e.toString())}",
                          textAlign: TextAlign.justify,
                          style: Style.partOfSpeechStyle
                              .copyWith(color: theme.primaryColor),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Antonyms',
                          style: Style.wordStyle.copyWith(
                              color: theme.primaryColor, fontSize: 18.0),
                        ),
                        Text(
                          "${defination.antonyms!.map((e) => e.toString())}",
                          textAlign: TextAlign.justify,
                          style: Style.partOfSpeechStyle
                              .copyWith(color: theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

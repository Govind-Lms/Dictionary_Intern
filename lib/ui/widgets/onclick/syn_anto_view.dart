import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/model/word_model.dart';

import '../../../theme/style.dart';

class SynonymsView extends ConsumerWidget {
  final List<Meaning>? meanings;
  const SynonymsView({super.key, required this.meanings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Synonyms',
            style: Style.synonymsStyle.copyWith(color: theme.primaryColor)),
        meanings![0].synonyms!.isNotEmpty
            ? Wrap(
                alignment: WrapAlignment.start,
                children: meanings![0].synonyms!.map(
                  (data) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: theme.primaryColor.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(data,
                          style: Style.definationStyle
                              .copyWith(color: theme.scaffoldBackgroundColor)),
                    );
                  },
                ).toList(),
              )
            : Text(
                "\"No Synonyms to show\"",
                style: Style.definationStyle.copyWith(
                  color: theme.primaryColor,
                ),
              ),
        const SizedBox(
          height: 10.0,
        ),
        Text('Antonyms',
            style: Style.synonymsStyle.copyWith(color: theme.primaryColor)),
        meanings![0].antonyms!.isNotEmpty
            ? Wrap(
                alignment: WrapAlignment.start,
                children: meanings![0].antonyms!.map(
                  (data) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: theme.primaryColor.withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(data,
                          style: Style.definationStyle
                              .copyWith(color: theme.scaffoldBackgroundColor)),
                    );
                  },
                ).toList(),
              )
            : Text(
                "\"No Antonyms to show\"",
                style: Style.definationStyle.copyWith(
                  color: theme.primaryColor,
                ),
              ),
      ],
    );
  }
}

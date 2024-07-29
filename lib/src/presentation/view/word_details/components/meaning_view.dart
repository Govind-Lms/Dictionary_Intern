import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intern_dictionary/src/const/constant.dart';
import 'package:intern_dictionary/src/presentation/widget/translate_widget.dart';

import '../../../../core/model/word_model.dart';
import '../../../../const/style.dart';

class MeaningView extends ConsumerStatefulWidget {
  final List<Meaning> meanings;
  const MeaningView({super.key, required this.meanings});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MeaningViewState();
}

class _MeaningViewState extends ConsumerState<MeaningView> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 350,
      child: ListView.builder(
        itemCount: widget.meanings[0].definitions!.length,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 1,
        //   childAspectRatio: 4 / 1,
        // ),
        itemBuilder: (BuildContext context, int index) {
          final defination = widget.meanings[0].definitions![index];
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
                      isTranslated == false
                          ? Text(
                              "↠ Defination ${index + 1}",
                              textAlign: TextAlign.justify,
                              style: Style.partOfSpeechStyle
                                  .copyWith(color: theme.primaryColor),
                            )
                          : Text(
                              "↠ အဓိပ္ပာယ် ${index + 1}",
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
                      ),
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
                      child: Row(
                        children: [
                          Text(
                            isTranslated == false
                                ? "↠ Defination ${index + 1}"
                                : "↠ အဓိပ္ပာယ် ${index + 1}",
                            textAlign: TextAlign.justify,
                            style: Style.partOfSpeechStyle
                                .copyWith(color: theme.primaryColor),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_drop_up_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Gap(10),
                    Text(
                      isTranslated == false
                          ? 'Defination'
                          : 'အဓိပ္ပာယ်ဖွင့်ဆိုချက်',
                      style: Style.wordStyle
                          .copyWith(color: theme.primaryColor, fontSize: 18.0),
                    ),
                    isTranslated == false
                        ? Text(
                            "${defination.definition} ",
                            textAlign: TextAlign.justify,
                            style: Style.partOfSpeechStyle
                                .copyWith(color: theme.primaryColor),
                          )
                        : TranslateWidgetInData(
                            toTranslate: defination.definition!),
                    const Gap(10.0),
                    Text(
                      isTranslated == false ? 'Example' : 'ဥပမာ',
                      style: Style.wordStyle
                          .copyWith(color: theme.primaryColor, fontSize: 18.0),
                    ),
                    isTranslated == false
                        ? Text(
                            defination.example ??
                                "There is no example to show.",
                            textAlign: TextAlign.justify,
                            style: Style.partOfSpeechStyle
                                .copyWith(color: theme.primaryColor),
                          )
                        : TranslateWidgetInData(
                            toTranslate: defination.example ??
                                "There is no example to show."),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      isTranslated == false ? 'Synonyms' : 'အဓိပ္ပာယ်တူစကား',
                      style: Style.wordStyle
                          .copyWith(color: theme.primaryColor, fontSize: 18.0),
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
                      isTranslated == false ? 'Antonyms' : 'ဆန့်ကျင်ဘက် စကား',
                      style: Style.wordStyle
                          .copyWith(color: theme.primaryColor, fontSize: 18.0),
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
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/ui/view/favorite.dart';
import '../../../model/word_model.dart';
import '../../../theme/style.dart';

class OnClickFav extends ConsumerStatefulWidget {
  final Word word;
  const OnClickFav({
    super.key,
    required this.word,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DataViewState();
}

class DataViewState extends ConsumerState<OnClickFav> {


  @override
  Widget build(BuildContext context) {
    final word = widget.word;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: theme.backgroundColor,
      ),
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(word.word.toString(),
                      style:
                          Style.wordStyle.copyWith(color: theme.primaryColor)),
                  const SizedBox(width: 20.0),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.primaryColor.withOpacity(.3),
                    child: IconButton(
                      onPressed: () async {
                        // await player.play();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FavoriteScreen()));
                      },
                      icon: Icon(
                        Icons.volume_up_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(word.phonetic ?? 'Empty',
                      style: Style.phoneticStyle
                          .copyWith(color: theme.primaryColor)),
                  Text("  ${word.meanings![0].partOfSpeech!}",
                      style: Style.partOfSpeechStyle
                          .copyWith(color: theme.primaryColor)),
                ],
              ),
              SizedBox(
                height: 400.0,
                child: Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: word.meanings![0].definitions!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final defination =
                            word.meanings![0].definitions![index];
                        return ExpandableNotifier(
                          child: Expandable(
                            collapsed: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0,
                                    color: Theme.of(context).primaryColor),
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
                                    Spacer(),
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
                                    width: 1.0,
                                    color: Theme.of(context).primaryColor),
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
                                        color: theme.primaryColor,
                                        fontSize: 18.0),
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
                                        color: theme.primaryColor,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    defination.example ??
                                        "No Example available",
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
                                        color: theme.primaryColor,
                                        fontSize: 18.0),
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
                                        color: theme.primaryColor,
                                        fontSize: 18.0),
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
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('Synonyms',
                  style:
                      Style.synonymsStyle.copyWith(color: theme.primaryColor)),
              word.meanings![0].synonyms!.isNotEmpty
                  ? Wrap(
                      alignment: WrapAlignment.start,
                      children: word.meanings![0].synonyms!.map(
                        (data) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: theme.primaryColor.withOpacity(0.5),
                            ),
                            margin: const EdgeInsets.only(
                                right: 10.0, bottom: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(data,
                                style: Style.definationStyle
                                    .copyWith(color: theme.backgroundColor)),
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
                  style:
                      Style.synonymsStyle.copyWith(color: theme.primaryColor)),
              word.meanings![0].antonyms!.isNotEmpty
                  ? Wrap(
                      alignment: WrapAlignment.start,
                      children: word.meanings![0].antonyms!.map(
                        (data) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: theme.primaryColor.withOpacity(0.5),
                            ),
                            margin: const EdgeInsets.only(
                                right: 10.0, bottom: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(data,
                                style: Style.definationStyle
                                    .copyWith(color: theme.backgroundColor)),
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
          ),
        ),
      ),
    );
  }
}

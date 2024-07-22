import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/core/provider/dict_provider.dart';
import 'package:intern_dictionary/src/const/style.dart';
import 'package:intern_dictionary/src/presentation/view/word_details/data_view.dart';
class SearchedWord extends ConsumerStatefulWidget {
  const SearchedWord({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedWordState();
}

class _SearchedWordState extends ConsumerState<SearchedWord> {
  String translatedText = '';
  late String chooseLanguage = "";
  String to = 'my';


  @override
  Widget build(BuildContext context) {
    final wordData = ref.watch(dicitonaryProvider);
    return Expanded(
      child: wordData.when(
        data: (wordData) {
          
          return ListView.builder(
            itemCount: wordData.length,
            itemBuilder: (BuildContext context, int index) {
              var word = wordData[index];

              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DataView(word: word)));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.white,
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              word.word ?? 'Empty Word',
                              style: Style.wordStyle.copyWith(
                                  fontSize: 16.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              word.phonetic ?? '/.../',
                              style: Style.phoneticStyle.copyWith(
                                  fontSize: 14.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          word.meanings![0].partOfSpeech ?? 'Empty POS',
                          style: Style.partOfSpeechStyle.copyWith(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => DataView(word: word)));
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            iconSize: 20.0,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )),
              );
            },
          );
        },
        error: (error, stackTrace) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Sorry. You have to make sure that the provided word is valid.',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Style.definationStyle,
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

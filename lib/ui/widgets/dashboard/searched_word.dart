import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/provider/dict_provider.dart';
import 'package:intern_dictionary/theme/style.dart';
import 'package:intern_dictionary/ui/view/onclick/data_view.dart';

class SearchedWord extends ConsumerStatefulWidget {
  const SearchedWord({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedWordState();
}

class _SearchedWordState extends ConsumerState<SearchedWord> {
  @override
  Widget build(BuildContext context) {
    final wordData = ref.watch(dicitonaryProvider);
    return Expanded(
      child: wordData.when(
        data: (wordData) {
          return ListView.builder(
            itemCount: wordData.length,
            itemBuilder: (BuildContext context, int index) {
              final word = wordData[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // color: Colors.white,
                  border: Border.all(width: 1.0,color: Theme.of(context).primaryColor),
                ),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                child: InkWell(
                  onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DataView(word: word)));
                },
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(word.word ?? 'Empty Word',style: Style.wordStyle.copyWith(fontSize: 16.0,color: Theme.of(context).primaryColor),),
                          Text(word.phonetic ?? '/.../',style: Style.phoneticStyle.copyWith(fontSize: 14.0,color: Theme.of(context).primaryColor),),
                        ],
                      ),
                      const Spacer(),
                      Text(word.meanings![0].partOfSpeech ?? 'Empty POS',style: Style.partOfSpeechStyle.copyWith(fontSize: 16.0,color: Theme.of(context).primaryColor),),
                      const Spacer(),
                      IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DataView(word: word)));
                      }, icon: const Icon(Icons.arrow_forward_ios_rounded),iconSize: 20.0,color: Theme.of(context).primaryColor),
                      const SizedBox(width: 10.0,),
                    ],
                  ),
                )
              );
            },
          );
          // return ListView.builder(
          //   itemCount: wordData.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container(
          //       margin: const EdgeInsets.all(10.0),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.0),
          //         color: Colors.white,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             padding: const EdgeInsets.all(10.0),
          //             width: MediaQuery.of(context).size.width/2,
          //             height: 40.0,
          //             decoration: BoxDecoration(
          //               borderRadius: const BorderRadius.only(
          //                 topLeft: Radius.circular(10.0),
          //                 bottomRight: Radius.circular(50.0),
          //               ),
          //               color: Colors.grey[400],
          //             ),
          //             child: Text("${wordData[index].meanings![0].partOfSpeech?.toUpperCase()}"),
          //           ),
          //           Row(
          //             children: [
          //               const SizedBox(width: 20.0,),
          //               Column(
          //                 children: [
          //                   Container(
          //                     margin: const EdgeInsets.only(top:10.0),
          //                     width: 2.0,
          //                     height: 20.0,
          //                     color: Colors.black,
          //                   ),
          //                   Icon(Icons.circle_outlined,size: 20,),
          //                   Container(
          //                     margin: const EdgeInsets.only(bottom:10.0),
          //                     width: 2.0,
          //                     height: 20.0,
          //                     color: Colors.black,
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(width: 10.0,),
          //               Column(
          //                 children: [
          //                   Text("${wordData[index].word?.toUpperCase()}"),
          //                   Text("${wordData[index].phonetic?.toUpperCase()}"),
          //                 ],
          //               ),
          //             ],
          //           ),
                    
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

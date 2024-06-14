import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/provider/dict_provider.dart';
import 'package:intern_dictionary/theme/style.dart';
import 'package:intern_dictionary/ui/view/onclick/data_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetView extends ConsumerStatefulWidget {
  const BottomSheetView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetViewState();
}

class _BottomSheetViewState extends ConsumerState<BottomSheetView> {
  @override
  Widget build(BuildContext context) {
    final wordData = ref.watch(synoDicitonaryProvider);
    return wordData.when(
      data: (data) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 50.0,),
              Container(width: 100.0,height: 5.0,color: Colors.black,),
              const OnClickSynoWord(),
            ],
          ),
        );
      },
      // ignore: prefer_const_constructors
      error: (error, stackTrace) {
        
        return SizedBox(height: MediaQuery.of(context).size.height/2,child: Text("No Data Available"),);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



class OnClickSynoWord extends ConsumerStatefulWidget {
  const OnClickSynoWord({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnClickSynoWordState();
}

class _OnClickSynoWordState extends ConsumerState<OnClickSynoWord> {
  @override
  Widget build(BuildContext context) {
    final wordData = ref.watch(synoDicitonaryProvider);
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
                    showMaterialModalBottomSheet(
                      
                      context: context, builder: (context){
                      return DataView(word: word);
                    });
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
                        // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DataView(word: word)));
                      }, icon: const Icon(Icons.arrow_forward_ios_rounded),iconSize: 20.0,color: Theme.of(context).primaryColor),
                      const SizedBox(width: 10.0,),
                    ],
                  ),
                )
              );
            },
          );
          
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

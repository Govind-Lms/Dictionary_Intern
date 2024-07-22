import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_dictionary/src/const/constant.dart';
import '../../../core/model/word_model.dart';
import 'components/components.dart';

class DataView extends ConsumerStatefulWidget {
  final Word word;
  const DataView({
    super.key,
    required this.word,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DataViewState();
}

class DataViewState extends ConsumerState<DataView> {
  late bool isFavorite = false;


  String myBoxName = "favoriteBox";
  final scrollController = ScrollController();

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
        actions: [
          TextButton(
            onPressed: () {
                    setState(() {
                      isTranslated = !isTranslated;
                    });
                  },
            child: Row(
              children: [
                isTranslated ==false ? CountryFlag.fromLanguageCode(
                  'en',
                  width: 25,
                  shape: const RoundedRectangle(100),
                  height: 25,
                ): CountryFlag.fromCountryCode(
                  'mm',
                  width: 25,
                  shape: const RoundedRectangle(100),
                  height: 25,
                ),
                const SizedBox(width: 10,),
            
                Text( isTranslated==true ?  "Burmese" : "English"),
                Icon(Icons.language,color: Theme.of(context).primaryColor),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await Hive.openBox(myBoxName);
              final favBox = Hive.box(myBoxName);
              var key = favBox.values.toString();
              if(word.isFav ==false){
                favBox.add(word);
                final snackBar = SnackBar(
                  content: const Text(
                    "Added Successfully",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  word.isFav = true;
                  debugPrint(key);
                });
              }

              else{
                setState(() {
                });
              }

            },
            icon: word.isFav == true ? Container(): const Icon(Icons.favorite_outline),
            
            color: Theme.of(context).primaryColor,
          ),
        ],
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0,),
              WordView(phonetic: word.phonetic, meanings: word.meanings, word: word.word,),
              MeaningView(meanings: word.meanings!),
              SynonymsView(meanings: word.meanings!)
            ],
          ),
        ),
      ),
    );
  }
}

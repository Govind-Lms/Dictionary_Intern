import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_dictionary/ui/widgets/onclick/meaning_view.dart';
import 'package:intern_dictionary/ui/widgets/onclick/syn_anto_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/word_model.dart';
import 'word_view.dart';

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

  _getPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final getFav = prefs.getBool("isFavorite");
    setState(() {
      isFavorite = getFav ?? true;
    });
    return isFavorite;
  }

  _setPreference() async {
    setState(() {
      isFavorite = !isFavorite;
    });
    final prefs = await SharedPreferences.getInstance();
    final setFav = await prefs.setBool("isFavorite", true);
    return setFav;
  }

  @override
  void initState() {
    super.initState();
    _getPreference();
  }

  String myBoxName = "favoriteBox";

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
                  print(key);
                });
              }

              else{
                setState(() {
                });
              }

            },
            icon: word.isFav == true ? Container(): const Icon(Icons.favorite_outline),
            // icon: Icon(
            //   word.isFav == true ? Icons.remove : Icons.favorite_outline,
            // ),
            color: Theme.of(context).primaryColor,
          ),
        ],
        backgroundColor: theme.backgroundColor,
      ),
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              WordView(phonetic: word.phonetic, meanings: word.meanings,word: word.word,),
              MeaningView(meanings: word.meanings!),
              SynonymsView(meanings: word.meanings!)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_dictionary/src/presentation/view/favorite/onclick_fav.dart';

import '../../../core/model/word_model.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  String myBoxName = "favoriteBox";

  Widget empty() {
    return const Center(
      child: Text('Nth Store In Local DB'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Favorite',style: TextStyle(color: theme.primaryColor),),
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          color: Theme.of(context).primaryColor,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ValueListenableBuilder(
        valueListenable: Hive.box(myBoxName).listenable(),
        builder: (context, data, _) {
          final keys = data.keys.cast<int>().toList();
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final Word word = data.get(keys[index]);
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => OnClickFav(word: word)));
                },
                leading: CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(.1),
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
                title: Text(
                  "${word.word}",
                  style: TextStyle(color: theme.primaryColor),
                ),
                subtitle: Text(
                  word.meanings![0].partOfSpeech!,
                  style: TextStyle(color: theme.primaryColor),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    const snackBar = SnackBar(
                      content: Text(
                        "Deleted Successfully",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    await Hive.box(myBoxName)
                        .delete(keys[index])
                        .whenComplete(() {
                          setState(() {
                            word.isFav = false;
                          });
                      debugPrint("Deleted");
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

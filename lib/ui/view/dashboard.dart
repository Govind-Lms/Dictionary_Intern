import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_dictionary/provider/dict_provider.dart';
import 'package:intern_dictionary/ui/view/favorite.dart';
import 'package:intern_dictionary/ui/view/word_search.dart';
import 'package:intern_dictionary/ui/widgets/dashboard/word_empty_screen.dart';

import '../widgets/dashboard/searched_word.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40.0),
            color: Theme.of(context).backgroundColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10.0,),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.abc,
                      ),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    const Spacer(),
                    Center(
                      child: Text(
                        'Dictionary',
                        style: GoogleFonts.archivoNarrow().copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const FavoriteScreen()));
                      },
                      icon: const Icon(
                        Icons.favorite,
                      ),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10.0,),
                  ],
                ),
      
               const WordSearch(),
              ],
            ),
          ),
          word.isNotEmpty ?const SearchedWord() : const WordEmpty(),
        ],
      ),
    );
  }
}
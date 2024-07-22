import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/core/provider/dict_provider.dart';
import 'package:intern_dictionary/src/const/style.dart';


class WordSearch extends ConsumerStatefulWidget {
  const WordSearch({super.key});
  @override
  ConsumerState<WordSearch> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends ConsumerState<WordSearch> {
  static const _radius = 10.0;

  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(wordProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // circular radius
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: SizedBox(
        height: _radius * 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.bottom,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                decoration:  InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search for words',
                  alignLabelWithHint: true,
                  hintStyle: Style.partOfSpeechStyle,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    autofocus: false,
                    color: Colors.black,
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      ref.read(wordProvider.notifier).state = _searchController.text;
                    },
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                
                onSubmitted: (value) =>
                    ref.read(wordProvider.notifier).state = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

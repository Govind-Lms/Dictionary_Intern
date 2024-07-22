import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/const/style.dart';
import 'package:shimmer/shimmer.dart';

class WordEmpty extends ConsumerWidget {
  const WordEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).scaffoldBackgroundColor,
            child:  Text(
              'Search For...',
              style: Style.searchStyle.copyWith(
            color: Theme.of(context).primaryColor,
          ),
            ),
          ),
          
        ],
      ),
    );
  }
}

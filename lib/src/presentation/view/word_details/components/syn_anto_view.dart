import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/const/constant.dart';
import 'package:intern_dictionary/src/core/model/word_model.dart';
import 'package:intern_dictionary/src/presentation/view/word_details/bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/provider/dict_provider.dart';
import '../../../../const/style.dart';

class SynonymsView extends ConsumerWidget {
  final List<Meaning>? meanings;
  const SynonymsView({super.key, required this.meanings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(isTranslated == false ? 'Synonyms' : 'အဓိပ္ပာယ်တူစကား',
            style: Style.synonymsStyle.copyWith(color: theme.primaryColor)),
        meanings![0].synonyms!.isNotEmpty
            ? Wrap(
                alignment: WrapAlignment.start,
                children: meanings![0].synonyms!.map(
                  (data) {
                    return InkWell(
                      onTap: (){
                        ref.read(synoProvider.notifier).state = data;
                        showMaterialModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          builder: (context){
                            return const BottomSheetView();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: theme.primaryColor.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(data,
                            style: Style.definationStyle
                                .copyWith(color: theme.scaffoldBackgroundColor)),
                      ),
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
        Text( isTranslated == false ? 'Antonyms' : 'ဆန့်ကျင်ဘက် စကား',
            style: Style.synonymsStyle.copyWith(color: theme.primaryColor)),
        meanings![0].antonyms!.isNotEmpty
            ? Wrap(
                alignment: WrapAlignment.start,
                children: meanings![0].antonyms!.map(
                  (data) {
                    return InkWell(
                      onTap: (){
                        ref.read(synoProvider.notifier).state = data;
                        showMaterialModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          builder: (context){
                            return const BottomSheetView();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: theme.primaryColor.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(data,
                            style: Style.definationStyle
                                .copyWith(color: theme.scaffoldBackgroundColor)),
                      ),
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
    );
  }
}

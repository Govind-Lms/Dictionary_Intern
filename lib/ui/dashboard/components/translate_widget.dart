import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/provider/dict_provider.dart';
import 'package:intern_dictionary/theme/style.dart';
import 'package:translator/translator.dart';

class TranslateWidget extends ConsumerStatefulWidget {
  final String toTranslate;
  const TranslateWidget({super.key, required this.toTranslate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TranslateWidgetState();
}

class _TranslateWidgetState extends ConsumerState<TranslateWidget> {
  String translatedText = '';
  late String chooseLanguage = "";
  String to = 'my';
  translateToMyanmar() async {
    final translatedString = await widget.toTranslate.translate(
      from: 'auto',
      to: to,
    );
    translatedText = translatedString.text;
    ref.read(translatedWordProvider.notifier).state = translatedText;
    setState(() {
      translatedText = translatedString.text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateToMyanmar();
  }

  @override
  Widget build(BuildContext context) {
    return Text(translatedText, style: Style.wordStyle.copyWith(color: Theme.of(context).primaryColor));
    return Container();
  }
}

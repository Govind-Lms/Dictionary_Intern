import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_dictionary/src/const/style.dart';
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
  translateToMyanmar() async {
    final translatedString = await widget.toTranslate.translate(
      from: 'auto',
      to: 'my',
    );
    translatedText = translatedString.text;
    if(!mounted) return;
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
    return Text(translatedText,
        style: Style.wordStyle.copyWith(color: Theme.of(context).primaryColor,fontSize: 16));
  }
}



class TranslateWidgetInData extends ConsumerStatefulWidget {
  final String toTranslate;
  const TranslateWidgetInData({super.key,required this.toTranslate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TranslateWidgetInDataState();
}

class _TranslateWidgetInDataState extends ConsumerState<TranslateWidgetInData> {
  String translatedText = '';
  translateToMyanmar() async {
    final translated =await widget.toTranslate.translate(
      from: 'auto',
      to: 'my',
    );
    translatedText= translated.text;
    if (!mounted) return; 
    setState(() {
      translatedText= translated.text;
    });

    

   
  }
 
  


  @override
  Widget build(BuildContext context) {
    translateToMyanmar();
    return Text(
      translatedText,
      textAlign: TextAlign.justify,
      style: Style.partOfSpeechStyle
          .copyWith(color: Theme.of(context).primaryColor,fontSize: 14),
    );
  }
}

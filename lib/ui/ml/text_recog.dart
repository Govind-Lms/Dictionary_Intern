import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class TextRecogFromImage extends ConsumerStatefulWidget {
  const TextRecogFromImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextRecogFromImageState();
}

class _TextRecogFromImageState extends ConsumerState<TextRecogFromImage> {
  File? image;
  String stringList = '';
  String translatedText = '';
  late TranslateLanguage sourceLanguage = TranslateLanguage.english;
  late TranslateLanguage targetLanguage;
  late String chooseLanguage = "";
  String to = '';

  setTargetLanguage() {
    switch (chooseLanguage) {
      case "english":
        setState(() {
          to = "en";
          targetLanguage = TranslateLanguage.english;
        });
      case "myanmar":
        setState(() {
          to = "my";
          targetLanguage = TranslateLanguage.english;
        });
      case "spanish":
        setState(() {
          to = "es";
          targetLanguage = TranslateLanguage.spanish;
        });
      case "russia":
        setState(() {
          to = "ru";
          targetLanguage = TranslateLanguage.russian;
        });
      default: setState(() {
        to = 'my';
        targetLanguage = TranslateLanguage.malay;
      });
    }
  }

  Future<void> translteText() async {
    setTargetLanguage();
    final onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
    final response = await onDeviceTranslator.translateText(stringList);
    setState(() {
      translatedText = response;
    });
    // log("translatedText : $translatedText");
    onDeviceTranslator.close();
  }

  Future<void> uploadImage() async {
    final uploadedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (uploadedImage != null) {
      setState(() {
        image = File(uploadedImage.path);
      });
      processImage();
    }
  }

  

  Future<void> processImage() async {    
    final inputImage = InputImage.fromFilePath(image!.path);
    final textrecognizer = TextRecognizer();
    final recognizedText = await textrecognizer.processImage(inputImage);
    debugPrint("recognizedText.blocks ${recognizedText.blocks.map((e) => Text(e.text))}");
    setState(() {
      stringList = recognizedText.text;
    });
  }
  
  newTranslate() async{
    setTargetLanguage();
    final newString = await stringList.translate(
      from: 'auto',
      to: to,
    );
    translatedText = newString.text;
    setState(() {
      translatedText = newString.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Upload Image'),
          actions: [
            IconButton(
                onPressed: () {
                  showPlatformDialog(
                    context: context,
                    builder: (context) => BasicDialogAlert(
                      title: const Text('Choose Language'),
                      content: Wrap(children: [
                        TextButton(
                          child: const Text('Spanish'),
                          onPressed: () {
                            setState(() {
                              chooseLanguage = "spanish";
                            });
                            log("choose language : $chooseLanguage");
                            Navigator.of(context).pop(true);
                          },
                        ),
                        TextButton(
                          child: const Text('Russia'),
                          onPressed: () {
                            setState(() {
                              chooseLanguage = "russia";
                            });
                            log("choose language : $chooseLanguage");
                            Navigator.of(context).pop(true);
                          },
                        ),
                        TextButton(
                          child: const Text('Myanmar'),
                          onPressed: () {
                            setState(() {
                              chooseLanguage = "myanmar";
                            });
                            log("Choose language : $chooseLanguage");
                            Navigator.of(context).pop(true);
                          },
                        ),
                        TextButton(
                          child: const Text('English'),
                          onPressed: () {
                            setState(() {
                              chooseLanguage = "English";
                            });
                            log("Choose language : $chooseLanguage");
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ]),
                      actions: <Widget>[
                        BasicDialogAction(
                          title: const Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.language))
          ],
        ),
        body: image == null
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Upload Your Image'),
                ),
                ElevatedButton(
                    onPressed: uploadImage, child: const Text('Upload Image')),
              ])
            : Container(
                margin: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    ElevatedButton(
                        onPressed: uploadImage,
                        child: const Text('Upload New Image')),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        // height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: Text(stringList)
                        // child: Text(block.map((e) => "$e") ),
                      ),
                    ElevatedButton(
                        // onPressed: translteText,
                        onPressed: newTranslate,
                        child: const Text('Translate'),),
                    translatedText.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            // height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Text(translatedText))
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                  ],
                ),
              ));
  }
}

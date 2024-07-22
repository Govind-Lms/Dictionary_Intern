import 'dart:developer';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intern_dictionary/src/const/style.dart';
import 'package:translator/translator.dart';

class TextRecogFromImage extends ConsumerStatefulWidget {
  const TextRecogFromImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextRecogFromImageState();
}

class _TextRecogFromImageState extends ConsumerState<TextRecogFromImage> {
  File? image;
  bool? isSelected;
  String stringList = '';
  String translatedText = '';
  late String chooseLanguage = "";
  String to = '';

  setTargetLanguage() {
    switch (chooseLanguage) {
      case "english":
        setState(() {
          to = "en";
        });
      case "myanmar":
        setState(() {
          to = "my";
        });
      case "spanish":
        setState(() {
          to = "es";
        });
      case "russia":
        setState(() {
          to = "ru";
        });
      default:
        setState(() {
          to = 'my';
        });
    }
  }

  Future<void> openImageFile(BuildContext context) async {
    // #docregion SingleOpen
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images'
      // extensions: <String>['jpg', 'png'],
    );

    final file =await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file == null) return;
    
    final String fileName = file.name;
    final String filePath = file.path;

    if (context.mounted) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => ImageDisplay(fileName, filePath),
      );
    }
  }

  Future<void> uploadImage({required ImageSource source}) async {
    final uploadedImage = await ImagePicker().pickImage(source: source);
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
    debugPrint(
        "recognizedText.blocks ${recognizedText.blocks.map((e) => e.text)}");
    setState(() {
      stringList = recognizedText.text;
    });
  }

  newTranslate() async {
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
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Center(
                child: Text('Upload Your Image'),
              ),
              ElevatedButton(
                  onPressed: () => showPlatformDialog(
                      context: context,
                      builder: (_) {
                        return BasicDialogAlert(
                          title: Text(
                            "Options",
                            style: Style.partOfSpeechStyle,
                          ),
                          actions: [
                            Material(
                              child: ListTile(
                                onTap: () {
                                  Platform.isMacOS == false
                                      ? uploadImage(source: ImageSource.camera)
                                      : openImageFile(context);
                                  Navigator.of(context).pop(true);
                                },
                                leading: const Icon(Iconsax.camera, size: 24),
                                title: Text(
                                  "via Camera",
                                  style: Style.definationStyle,
                                ),
                              ),
                            ),
                            Material(
                              child: ListTile(
                                onTap: () {
                                  Platform.isMacOS == false
                                      ? uploadImage(source: ImageSource.gallery)
                                      : openImageFile(context);
                                  Navigator.of(context).pop(true);
                                },
                                leading: const Icon(Iconsax.gallery, size: 24),
                                title: Text(
                                  "via Gallery",
                                  style: Style.definationStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  child: const Text('Upload Image')),
            ])
          : Container(
              margin: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => showPlatformDialog(
                            context: context,
                            builder: (_) {
                              return BasicDialogAlert(
                                title: Text(
                                  "Options",
                                  style: Style.partOfSpeechStyle,
                                ),
                                actions: [
                                  Material(
                                    child: ListTile(
                                      onTap: () {
                                        Platform.isMacOS == false
                                            ? uploadImage(
                                                source: ImageSource.camera)
                                            : openImageFile(context);
                                        Navigator.of(context).pop(true);
                                      },
                                      leading:
                                          const Icon(Iconsax.camera, size: 24),
                                      title: Text(
                                        "via Camera",
                                        style: Style.definationStyle,
                                      ),
                                    ),
                                  ),
                                  Material(
                                    child: ListTile(
                                      onTap: () {
                                        Platform.isMacOS == false
                                            ? uploadImage(
                                                source: ImageSource.gallery)
                                            : openImageFile(context);
                                        Navigator.of(context).pop(true);
                                      },
                                      leading:
                                          const Icon(Iconsax.gallery, size: 24),
                                      title: Text(
                                        "via Gallery",
                                        style: Style.definationStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                        child: Text(
                          'Upload New Image',
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        )),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      // height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: SelectableText(stringList),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: newTranslate,
                        child: Text(
                          'Translate',
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        )),
                    translatedText.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            // height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: SelectableText(translatedText))
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ImageDisplay extends StatelessWidget {
  /// Default Constructor
  const ImageDisplay(this.fileName, this.filePath, {super.key});

  /// Image's name
  final String fileName;

  /// Image's path
  final String filePath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Translation is not supported on macos"),
      // On web the filePath is a blob url
      // while on other platforms it is a system path.
      content: kIsWeb ? Image.network(filePath) : Image.file(File(filePath)),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

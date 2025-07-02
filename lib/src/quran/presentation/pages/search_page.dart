import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafek_mumen/core/compants/text_fleid.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/presentation/pages/surah_page.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

import '../../../../utils/functions/route.dart';
import '../../../../utils/services/nofications_serivce.dart';
import '../../data/models/quran_model.dart';
import '../functions/functions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.surahs}) : super(key: key);
  final List<Surah> surahs;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ValueNotifier<List<Ayah>> _filteredAyahs = ValueNotifier<List<Ayah>>(
    [],
  );
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // _filteredAyahs = [];
    super.initState();
  }

  void filterAyahs(String text, List<Surah> surahs) async {
    log("text: $text");
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_filterIsolate, receivePort.sendPort);

    final SendPort sendPort = await receivePort.first;

    List<Ayah> filteredList = <Ayah>[];
    var ayahs = await _compute(sendPort, text, surahs);
    if (ayahs.length != 0) {
      filteredList = ayahs;
    }

    _filteredAyahs.value = filteredList;
  }

  static _filterIsolate(SendPort sendPort) async {
    final ReceivePort receivePort = ReceivePort();

    sendPort.send(receivePort.sendPort);

    await for (var message in receivePort) {
      final SendPort sender = message[0];
      final String text = message[1];
      final List<Surah> surahs = message[2];

      final List<Ayah> filteredList = <Ayah>[];

      String searchText = text.trim();
      if (searchText.isEnglishWithoutNumbersAndSymbols()) {
        sender.send([]);
        continue;
      }
      final normalizedSearchText = removeSpecialArabicChar(searchText);

      searchLoop:
      for (var surah in surahs) {
        for (var ayah in surah.ayahs) {
          final normalizedAyahText = removeSpecialArabicChar(ayah.text);
          if (normalizedAyahText.contains(normalizedSearchText)) {
            filteredList.add(ayah);
            if (filteredList.length == 8) {
              sender.send(filteredList);
              break searchLoop; // Break out of both loops
            }
          }
        }
      }

      sender.send(filteredList);
    }
  }

  Future<dynamic> _compute(SendPort sendPort, String text, List<Surah> surahs) {
    final ReceivePort receivePort = ReceivePort();

    sendPort.send([receivePort.sendPort, text, surahs]);

    return receivePort.first;
  }

  Surah? getSurah(Ayah ayah, List<Surah> surahs) {
    for (var surah in surahs) {
      for (var ayah2 in surah.ayahs) {
        if (ayah2.text == ayah.text) {
          return surah;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'البحث',
          style: getTextTheme(context, 20)?.copyWith(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              NotificationsService.createScheduleNotification(
                id: 2000119,
                title: "lsknfldk",
                body: "lfkdsnlk",
                dateTime: DateTime.now(),
                isTest: true,
              );
            },
            child: const Text("push"),
          ),
          ElevatedButton(
            onPressed: () async {
              NotificationsService.createScheduleNotification2(
                id: 2000112,
                title: "working",
                body: "background service",
                dateTime: DateTime.now(),
                isTest: true,
              );
            },
            child: const Text("background"),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: MyTextField(
              autofocus: true,
              controller: searchController,
              hintText: "البحث عن طريق نص الآية",
              suffixIcon: const Icon(Icons.clear),
              onPressedSuffixIcon: () => _filteredAyahs.value = [],
              prefixIcon: CupertinoIcons.search,
              onChanged: (value) {
                if (value.isEmpty) {
                  log("text value: $value");

                  _filteredAyahs.value = [];

                  return;
                }
                filterAyahs(value, widget.surahs);
              },
            ),
          ),
          ValueListenableBuilder<List<Ayah>>(
            valueListenable: _filteredAyahs,
            builder: (BuildContext context, ayahs, child) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: ayahs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Surah? surah = getSurah(ayahs[index], widget.surahs);
                          if (surah == null) return;
                          go(
                            SurahPage(
                              surah: surah,
                              pageOfAyah: ayahs[index].page,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(ayahs[index].text),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

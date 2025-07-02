import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafek_mumen/core/compants/text_fleid.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/presentation/blocs/quran_bloc.dart';
import 'package:rafek_mumen/src/quran/presentation/pages/search_page.dart';
import 'package:rafek_mumen/utils/functions/route.dart';

import '../../../../core/genarics/bloc_state.dart';
import '../../../../utils/theme/app_theme.dart';
import '../../data/models/quran_model.dart';
import '../functions/functions.dart';
import '../widgets/surah_card.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late QuranBloc quranBloc;
  // late List<Ayah> filteredAyahs;
  ValueNotifier<List<Ayah>> filteredAyahs = ValueNotifier<List<Ayah>>([]);

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    quranBloc = context.read<QuranBloc>();
    quranBloc.add(const GetQuranSurahsEvent());
    filteredAyahs.value = [];
    super.initState();
  }

  void filterAyahs(String text, List<Surah> surahs) {
    String searchText = text.trim();
    if (!searchText.isEnglishWithoutNumbersAndSymbols()) {
      return;
    }
    final normalizedSearchText = removeSpecialArabicChar(searchText);
    setState(() {
      filteredAyahs.value = [];
      searchLoop:
      for (var surah in surahs) {
        for (var ayah in surah.ayahs) {
          final normalizedAyahText = removeSpecialArabicChar(ayah.text);
          if (normalizedAyahText.contains(normalizedSearchText)) {
            filteredAyahs.value.add(ayah);
            if (filteredAyahs.value.length == 8) {
              break searchLoop; // Break out of both loops
            }
          }
        }
      }
    });
  }

  Surah getSurah(Ayah ayah, List<Surah> surahs) {
    for (var surah in surahs) {
      if (surah.ayahs.contains(ayah)) {
        return surah;
      }
    }
    throw Exception('Surah not found for the Ayah');
  }

  @override
  Widget build(BuildContext context) {
    // String chars =
    //     """!"#\$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz}|{~¡¢£¤¥¦§¨©ª»¬®¯°±²³´µ""";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'القران الكريم',
          style: getTextTheme(context, 20)?.copyWith(color: Colors.white),
        ),
        // actions: [
        //   ElevatedButton(
        //       onPressed: () async {
        //         NotificationsService.createScheduleNotification(
        //             id: 2000119,
        //             title: "lsknfldk",
        //             body: "lfkdsnlk",
        //             dateTime: DateTime.now(),
        //             isTest: true);
        //         // String localTimeZone =
        //         //     await AwesomeNotifications().getLocalTimeZoneIdentifier();
        //         // NotificationsService.createScheduleNotification(
        //         //   id: 1232,
        //         //   title: "الاذان",
        //         //   body: "حان الان موعد اذان",
        //         //   timeZone: localTimeZone,
        //         //   dateTime: DateTime.now().add(const Duration(seconds: 5)),
        //         // );
        //       },
        //       child: const Text("push"))
        // ],
      ),
      body: BlocBuilder<QuranBloc, BlocState<QuranModel>>(
        bloc: quranBloc,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (quranModel) => Column(
              children: [
                Container(
                  color: Colors.white,
                  child: MyTextField(
                    readOnly: true,
                    controller: searchController,
                    hintText: "البحث عن طريق نص الآية",
                    suffixIcon: const Icon(Icons.clear),
                    onPressedSuffixIcon: () => filteredAyahs.value = [],
                    prefixIcon: CupertinoIcons.search,
                    onTap: () {
                      go(SearchPage(surahs: quranModel.surahs));
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: quranModel.surahs.length,
                    itemBuilder: (context, index) {
                      return SurahCard(surah: quranModel.surahs[index]);
                    },
                  ),
                ),
              ],
            ),
            failure: (error) => Center(child: SelectableText(error.msg)),
          );
        },
      ),
    );
  }
}

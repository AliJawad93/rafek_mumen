import 'package:rafek_mumen/core/functions/extension.dart';

import '../../data/models/quran_model.dart';

String removeSpecialArabicChar(String input) => input
    .replaceAll('\u0610', '') //arabic sign sallallahou alayhe wa sallam
    .replaceAll('\u0611', '') //arabic sign alayhe assallam
    .replaceAll('\u0612', '') //arabic sign rahmatullah alayhe
    .replaceAll('\u0613', '') //arabic sign radi allahou anhu
    .replaceAll('\u0614', '') //arabic sign takhallus
    //remove koranic anotation
    .replaceAll('\u0615', '') //arabic small high tah
    .replaceAll(
      '\u0616',
      '',
    ) //arabic small high ligature alef with lam with yeh
    .replaceAll('\u0617', '') //arabic small high zain
    .replaceAll('\u0618', '') //arabic small fatha
    .replaceAll('\u0619', '') //arabic small damma
    .replaceAll('\u061a', '') //arabic small kasra
    .replaceAll(
      '\u06d6',
      '',
    ) //arabic small high ligature sad with lam with alef maksura
    .replaceAll(
      '\u06d7',
      '',
    ) //arabic small high ligature qaf with lam with alef maksura
    .replaceAll('\u06d8', '') //arabic small high meem initial form
    .replaceAll('\u06d9', '') //arabic small high lam alef
    .replaceAll('\u06da', '') //arabic small high jeem
    .replaceAll('\u06db', '') //arabic small high three dots
    .replaceAll('\u06dc', '') //arabic small high seen
    .replaceAll('\u06dd', '') //arabic end of ayah
    .replaceAll('\u06de', '') //arabic start of rub el hizb
    .replaceAll('\u06df', '') //arabic small high rounded zero
    .replaceAll('\u06e0', '') //arabic small high upright rectangular zero
    .replaceAll('\u06e1', '') //arabic small high dotless head of khah
    .replaceAll('\u06e2', '') //arabic small high meem isolated form
    .replaceAll('\u06e3', '') //arabic small low seen
    .replaceAll('\u06e4', '') //arabic small high madda
    .replaceAll('\u06e5', '') //arabic small waw
    .replaceAll('\u06e6', '') //arabic small yeh
    .replaceAll('\u06e7', '') //arabic small high yeh
    .replaceAll('\u06e8', '') //arabic small high noon
    .replaceAll('\u06e9', '') //arabic place of sajdah
    .replaceAll('\u06ea', '') //arabic empty centre low stop
    .replaceAll('\u06eb', '') //arabic empty centre high stop
    .replaceAll('\u06ec', '') //arabic rounded high stop with filled centre
    .replaceAll('\u06ed', '') //arabic small low meem
    //remove tatweel
    .replaceAll('\u0640', '')
    //remove tashkeel
    .replaceAll('\u064b', '') //arabic fathatan
    .replaceAll('\u064c', '') //arabic dammatan
    .replaceAll('\u064d', '') //arabic kasratan
    .replaceAll('\u064e', '') //arabic fatha
    .replaceAll('\u064f', '') //arabic damma
    .replaceAll('\u0650', '') //arabic kasra
    .replaceAll('\u0651', '') //arabic shadda
    .replaceAll('\u0652', '') //arabic sukun
    .replaceAll('\u0653', '') //arabic maddah above
    .replaceAll('\u0654', '') //arabic hamza above
    .replaceAll('\u0655', '') //arabic hamza below
    .replaceAll('\u0656', '') //arabic subscript alef
    .replaceAll('\u0657', '') //arabic inverted damma
    .replaceAll('\u0658', '') //arabic mark noon ghunna
    .replaceAll('\u0659', '') //arabic zwarakay
    .replaceAll('\u065a', '') //arabic vowel sign small v above
    .replaceAll('\u065b', '') //arabic vowel sign inverted small v above
    .replaceAll('\u065c', '') //arabic vowel sign dot below
    .replaceAll('\u065d', '') //arabic reversed damma
    .replaceAll('\u065e', '') //arabic fatha with two dots
    .replaceAll('\u065f', '') //arabic wavy hamza below
    .replaceAll('\u0670', '') //arabic letter superscript alef
    //replace waw hamza above by waw
    .replaceAll('\u0624', '\u0648')
    //replace ta marbuta by ha
    .replaceAll('\u0629', '\u0647')
    //replace ya
    // and ya hamza above by alif maksura
    .replaceAll('\u064a', '\u0649')
    .replaceAll('\u0626', '\u0649')
    // replace alifs with hamza above/below
    // and with madda above by alif
    .replaceAll('\u0622', '\u0627')
    .replaceAll('\u0623', '\u0627')
    .replaceAll('\u0625', '\u0627');
// .replaceAll('َ', '')
// .replaceAll('ُ', '')
// .replaceAll('ِ', '')
// .replaceAll('ّ', '')
// .replaceAll('ً', '')
// .replaceAll('ٌ', '')
// .replaceAll('ٌ', '')
// .replaceAll('ٍ', '')
// .replaceAll('ـ', '')
// .replaceAll('ٖ', '')
// .replaceAll('ٗ', '')
// .replaceAll('ٙ', '')
// .replaceAll('ٟ', '')
// .replaceAll('ٴ', '')
// .replaceAll('ٚ', '')
// .replaceAll('٠', '')
// .replaceAll('ٵ', 'ا')
// .replaceAll('ٛ', '')
// .replaceAll('ٱ', 'ا')
// .replaceAll('ٶ', 'و')
// .replaceAll('ٜ', '')
// .replaceAll('ٱ', 'ا')
// .replaceAll('ٷ', 'و')
// .replaceAll('ٝ', '')
// .replaceAll('ٲ', 'ا')
// .replaceAll('ٞ', '')
// .replaceAll('ٳ', 'ا');

Map<int, (String, int)> groupAyahsByPage(List<Ayah> ayahs) {
  Map<int, (String, int)> groupedAyahs = {};
  for (var ayah in ayahs) {
    if (!groupedAyahs.containsKey(ayah.page)) {
      groupedAyahs[ayah.page] = ('', 0);
    }
    groupedAyahs[ayah.page] = (
      "${groupedAyahs[ayah.page]!.$1} ${ayah.text} ${ayah.numberInSurah.toArabic()}",
      ayah.juz,
    );
  }
  return groupedAyahs;
}

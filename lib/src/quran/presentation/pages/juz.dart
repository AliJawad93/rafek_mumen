// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../blocs/quran_bloc.dart';
// import '../widgets/surah_card.dart';

// class JuzPage extends StatefulWidget {
//   const JuzPage({super.key});

//   @override
//   State<JuzPage> createState() => _JuzPageState();
// }

// class _JuzPageState extends State<JuzPage> {
//   late QuranBloc quranBloc;
//   @override
//   void initState() {
//     quranBloc = context.read<QuranBloc>();
//     quranBloc.add(const GetQuranSurahsEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('القران الكريم'),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.golf_course))
//         ],
//       ),
//       body: BlocBuilder<QuranBloc, QuranState>(
//         bloc: quranBloc,
//         builder: (context, state) {
//           return state.when(
//               initial: () => const SizedBox(),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               data: (quranModel) => ListView.builder(
//                     itemCount: quranModel.surahs.length,
//                     itemBuilder: (context, index) {
//                       return SurahCard(
//                         surah: quranModel.surahs[index],
//                       );
//                     },
//                   ),
//               failure: (error) => Center(child: Text(error.msg)));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafek_mumen/core/genarics/data_state.dart';
import 'package:rafek_mumen/src/quran/data/data_source/data_source.dart';
import 'package:rafek_mumen/src/quran/data/models/quran_model.dart';

import '../../../../core/genarics/bloc_state.dart';

part 'quran_bloc.freezed.dart';
part 'quran_event.dart';
// part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, BlocState<QuranModel>> {
  QuranBloc() : super(const BlocState.initial()) {
    on<QuranEvent>((events, emit) async {
      await events.map(
        getQuranSurahs: (event) async => await _getQuranSurahs(event, emit),
      );
    });
  }

  _getQuranSurahs(event, Emitter<BlocState<QuranModel>> emit) async {
    emit(const BlocState<QuranModel>.loading());
    DataState<QuranModel> quranModel = await QuranDataSource.getQuranSurahs();

    if (quranModel is DataFailed) {
      emit(BlocState<QuranModel>.failure(quranModel.error!));

      return;
    }
    emit(BlocState<QuranModel>.data(quranModel.data!));
  }
}

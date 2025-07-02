import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafek_mumen/core/genarics/bloc_state.dart';
import 'package:rafek_mumen/src/home/data/data_source/data_source.dart';

import '../../../../core/genarics/data_state.dart';
import '../../data/models/pray_day_work_model.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, BlocState<PrayDayWorkModel>> {
  HomeBloc() : super(const BlocState.initial()) {
    on<HomeEvent>((events, emit) async {
      await events.map(
        getPrayDayWork: (event) async => await _getPrayDayWork(event, emit),
      );
    });
  }

  _getPrayDayWork(event, Emitter<BlocState<PrayDayWorkModel>> emit) async {
    emit(const BlocState<PrayDayWorkModel>.loading());
    DateTime date = DateTime.now();

    // Find the day of the week

    String dayFileName = getDayFileName(date.weekday);
    DataState<PrayDayWorkModel> prayDayWorkModel =
        await HomeDataSource.getPrayDayWork(dayFileName);

    if (prayDayWorkModel is DataFailed) {
      emit(BlocState<PrayDayWorkModel>.failure(prayDayWorkModel.error!));

      return;
    }
    emit(BlocState<PrayDayWorkModel>.data(prayDayWorkModel.data!));
  }

  String getDayFileName(int index) {
    switch (index) {
      case 1:
        return 'mon.json';
      case 2:
        return 'tue.json';
      case 3:
        return 'wed.json';
      case 4:
        return 'thu.json';
      case 5:
        return 'fri.json';
      case 6:
        return 'sat.json';
      case 7:
        return 'sun.json';
      default:
        throw Exception('Invalid day index');
    }
  }
}

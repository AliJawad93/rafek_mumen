part of 'quran_bloc.dart';

@freezed
class QuranEvent with _$QuranEvent {
  const factory QuranEvent.getQuranSurahs() = GetQuranSurahsEvent;
}
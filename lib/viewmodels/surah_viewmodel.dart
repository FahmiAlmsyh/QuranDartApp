import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/repositories/quran_repo.dart';

class SurahViewModel {
  final QuranRepository _repository = QuranRepository();

  Future<List<Surah>> getListSurah() async => await _repository.getListSurah();
}

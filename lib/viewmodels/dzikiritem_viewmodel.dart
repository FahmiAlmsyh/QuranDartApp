import 'package:quran_app/models/dzikirtab_model.dart';
import 'package:quran_app/repositories/quran_repo.dart';

class DzikirTabItemViewModel {
  final QuranRepository _repository = QuranRepository();

  Future<DzikirTab> getListDzikirTab(String id_dzikir) async =>
      await _repository.getListDzikirTab(id_dzikir);
}
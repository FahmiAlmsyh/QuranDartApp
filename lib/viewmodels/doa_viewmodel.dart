import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/repositories/quran_repo.dart';

class DoaViewModel {
  final QuranRepository _repository = QuranRepository();

  Future<List<Doa>> getListDoaTab() async => await _repository.getListDoaTab();
}
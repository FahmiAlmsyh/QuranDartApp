import 'package:quran_app/models/abangku_model.dart';
import 'package:quran_app/repositories/quran_repo.dart';

class AbangkuViewModel {
  final QuranRepository _repository = QuranRepository();

  Future<List<Abangku>> getListAbangku() async => await _repository.getListAbangku();
}
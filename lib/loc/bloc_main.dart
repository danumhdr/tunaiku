import 'package:tunaiku/model/model_main.dart';
import 'package:tunaiku/repo/repo_main.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  final MainRepository _repository = MainRepository();
  final BehaviorSubject<MainModel> _subject = BehaviorSubject<MainModel>();

  getUser() async {
    MainModel response = await _repository.getUser();
    _subject.sink.add(response);
  }

  step1() async {
    MainModel response = await _repository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MainModel> get subject => _subject;
}

final bloc = MainBloc();

import 'package:tunaiku/model/model_main.dart';
import 'package:tunaiku/provider/provider_main.dart';

class MainRepository {
  ProviderMain _apiProvider = ProviderMain();

  Future<MainModel> getUser() {
    return _apiProvider.getUser();
  }
}

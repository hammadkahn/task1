import 'package:get_it/get_it.dart';
import 'package:task1/services/global_service.dart';

final locator = GetIt.instance;
void setup_locator() {
  locator.registerLazySingleton(() => GlobalService());
}

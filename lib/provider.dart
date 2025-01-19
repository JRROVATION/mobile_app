import 'package:get_it/get_it.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AdviseViewModel>(() => AdviseViewModel());
  // locator.registerSingleton<AdviseViewModel>(AdviseViewModel());
}

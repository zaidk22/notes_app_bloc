

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app_bloc/injection.config.dart';

final GetIt getIt = GetIt.instance;
@InjectableInit()
void configureInjection(String env) => getIt.init(
      environment: env,
    );
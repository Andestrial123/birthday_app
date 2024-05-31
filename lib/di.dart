import 'package:birthday_app/feature/auth/domain/auth_cubit.dart';
import 'package:birthday_app/feature/auth/domain/services/auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.asNewInstance();

void setup() {
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt.get()));
}

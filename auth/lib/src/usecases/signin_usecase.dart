import 'package:async/async.dart';
import '../domain/auth_service_contract.dart';
import '../domain/token.dart';

class SigninUsecase {
  final IAuthService _authService;
  SigninUsecase(this._authService);

  Future<Result<Token>> execute() async {
    return await _authService.signIn();
  }
}

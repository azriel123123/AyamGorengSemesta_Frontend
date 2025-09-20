import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_system/data/datasource/auth_remote_datasource.dart';
import 'package:pos_system/data/model/response/auth_response_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDatasource;

  LoginBloc(this.authRemoteDatasource) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      final response = await authRemoteDatasource.login(event.email, event.password);

      response.fold(
            (l) => emit(LoginFailure(message: l)),
            (r) => emit(LoginSuccess(authResponseModel: r)),
      );
    });
  }
}
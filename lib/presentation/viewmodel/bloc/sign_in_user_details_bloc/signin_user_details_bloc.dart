import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/sign_in_details.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'signin_user_details_event.dart';
part 'signin_user_details_state.dart';

class SigninUserDetailsBloc
    extends Bloc<SigninUserDetailsEvent, SigninUserDetailsState> {
  SigninUserDetailsBloc() : super(SigninUserDetailsInitial()) {
    on<OnSigninUserDataFetchEvent>((event, emit) async {
      emit(SigninUserDetailsDataFetchLoadingState());
      final response = await UserRepo.fetchLoggedInUserDetails();
      if (response != null && response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final SignInUserModel model = SignInUserModel.fromJson(responseBody);
        return emit(SigninUserDetailsDataFetchSuccesState(userModel: model));
      } else {
        return emit(SigninUserDetailsDataFetchErrorState());
      }
    });
  }
}

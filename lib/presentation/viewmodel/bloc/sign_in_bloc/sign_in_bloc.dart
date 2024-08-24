import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/auth.dart';
import 'package:vibehunt/utils/funtions.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonClickEvent>((event, emit) async{
      emit(SignInLoadingState());
      final response =
          await AuthenticationRepo.userLogin(event.email, event.password);
      if (response != null && response.statusCode == 200) {
      
        return emit(SignInSuccesState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);

        return emit(SignInErrorState(error: responseData["message"]));
      } else {
        return emit(SignInErrorState(error: 'something went wrong'));
      }
    });

    on<OnGoogleSignInButtonClickedEvent>((event, emit) async {
      emit(GoogleAuthLoadingstate());
      var response = await siginWithGoogle();
      if (response != null &&
          response.user != null &&
          response.user!.email != null) {
        var email = response.user!.email;
        print(email);
        Response? finalResponse = await AuthenticationRepo.googleLogin(email!);
        if (finalResponse != null && finalResponse.statusCode == 200) {
          return emit(SignInSuccesState());
        } else if (finalResponse != null) {
          final errorMessage = jsonDecode(finalResponse.body);

          emit(SignInErrorState(error: errorMessage["message"]));
        } else {
          return emit(SignInErrorState(error: 'Something went wrong'));
        }
      } else {
        emit(SignInErrorState(error: 'account not found'));
      }
    });
  }
}

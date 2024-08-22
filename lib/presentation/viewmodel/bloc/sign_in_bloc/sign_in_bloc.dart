import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/auth.dart';

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
  }
}

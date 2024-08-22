import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/user_model.dart';
import 'package:vibehunt/data/repositories/auth.dart';
import 'package:http/http.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignupButtonClicked>((event, emit) async {
      if (kDebugMode) {
        print("loading...............");
      }
      emit(SignUpLoadingSate());

      UserModel finalDatas = UserModel(
        userName: event.userName,
        password: event.password,
        phoneNumber: event.phoneNumber,
        emailId: event.email,
      );

      Response? response = await AuthenticationRepo().sentOtp(finalDatas);
      if (response != null && response.statusCode == 200) {
        return emit(SignUpSuccesState());
      } else if (response != null) {
        if (response.body != null && response.body.isNotEmpty) {
          try {
            final responseData = jsonDecode(response.body);
            return emit(SignUpErrorState(error: responseData["message"]));
          } catch (e) {
            print("Failed to decode JSON: $e");
            return emit(SignUpErrorState(error: "Invalid response format"));
          }
        } else {
          return emit(SignUpErrorState(error: "Empty response from server"));
        }
      } else {
        return emit(SignUpErrorState(error: "something went wrong"));
      }
    });
  }
}

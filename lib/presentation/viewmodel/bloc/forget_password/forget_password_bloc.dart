import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:vibehunt/data/repositories/auth.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<OnForgetButtonClicked>((event, emit) async {
      emit(ForgetPasswordLoadingState());
      var response = await AuthenticationRepo.resetPasswordSendOtp(event.email);
      if (kDebugMode) {
        print('error in debug mode');
      }
      if (response != null && response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 200) {
          return emit(ForgetPasswordSuccessState());
        } else {
          return emit(ForgetPasswordErrorState(error: responseBody['message']));
        }
      } else {
        return emit(ForgetPasswordErrorState(error: 'something is missing'));
      }
    });
    on<OnVerifyButtonClickedEvent>((event, emit) async {
      emit(OtpverifiedLoadingState());
      var response = await AuthenticationRepo.verifyOtpPasswordReset(
          event.email, event.otp);
      if (response != null && response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody["status"]) {
          return emit(OtpverifiedSuccessState());
        } else {
          if (kDebugMode) {
            print(responseBody);
          }
          return emit(OtpverifiedErrorState(error: 'invalid OTP'));
        }
      } else {
        return emit(OtpverifiedErrorState(error: 'something is missing'));
      }
    });
    on<OnResetPasswordButtonClickedEvent>((event, emit) async {
      emit(ResetPasswordSuccessState());
      var response =
          await AuthenticationRepo.updatePassword(event.email, event.password);
      if (response != null && response.statusCode == 200) {
        return emit(ResetPasswordSuccessState());
      } else if (response != null) {
        var finalResponse = jsonDecode(response.body);
        return emit(ResetPasswordErrorState(error: finalResponse["message"]));
      } else {
        return emit(ResetPasswordErrorState(error: 'Something went wrong'));
      }
    });
  }
}

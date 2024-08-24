import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/auth.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OnOtpVerifyButtonClicked>((event, emit) async {
      emit(OtpLoadingState());
      var response = await AuthenticationRepo.verifyOtp(event.email, event.otp);
      if (response != null && response.statusCode == 200) {
        return emit(OtpSuccesState());
      } else if (response != null) {
        final responseData = jsonDecode(response.body);

        return emit(OtpErrrorState(error: responseData["message"]));
      } else {
        return emit(OtpErrrorState(error: "something went wrong"));
      }
    });
  }
}

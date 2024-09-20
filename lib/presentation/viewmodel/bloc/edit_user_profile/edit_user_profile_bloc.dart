import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc
    extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(EditUserProfileInitial()) {
    on<EditUserProfileEvent>((event, emit) {});
    on<OnEditProfileButtonClickedEvent>((event, emit) async {
      emit(EditUserProfileLoadingState());
      final Response result = await UserRepo.editProfile(
          image: event.image,
          name: event.name,
          bio: event.bio,
          imageUrl: event.imageUrl,
          bgImage: event.bgImage,
          bgImageUrl: event.bgImageUrl);
      final responseBody = jsonDecode(result.body);
      if (result.statusCode == 200) {
        return emit(EditUserProfileSuccesState());
      } else if (responseBody['status'] == 401) {
        return emit(
            EditUserProfileErrorState(error: 'server busy try again later'));
      } else if (responseBody['message'] ==
          'Something went wrong while updating the post') {
        return emit(EditUserProfileErrorState(
            error: 'Something went wrong while updating the post'));
      } else {
        return emit(EditUserProfileErrorState(
            error:
                'something went wrong check your interet connection and try again'));
      }
    });
  }
}

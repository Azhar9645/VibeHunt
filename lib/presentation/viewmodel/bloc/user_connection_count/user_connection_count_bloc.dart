import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'user_connection_count_event.dart';
part 'user_connection_count_state.dart';

class UserConnectionCountBloc extends Bloc<UserConnectionCountEvent, UserConnectionCountState> {
  UserConnectionCountBloc() : super(UserConnectionCountInitial()) {
    on<UserConnectionCountEvent>((event, emit) {});
    on<UserConnectionsInitilFetchEvent>(userconnectionsInitilFetchEvent);

  }

  FutureOr<void> userconnectionsInitilFetchEvent(UserConnectionsInitilFetchEvent event,
      Emitter<UserConnectionCountState> emit) async {
    emit(UserConnectionCountLoadingState());
    final Response response =
        await UserRepo.getUserConnections(userId: event.userId);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final int followersCount = responseBody['followersCount'];
      final int followingCount = responseBody['followingCount'];
      emit(UserConnectionCountSuccessState(
          followersCount: followersCount, followingsCount: followingCount));
    } else {
      emit(UserConnectionCountErrorState());
    }
  }
}

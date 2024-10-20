import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/get_all_users_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'get_all_users_event.dart';
part 'get_all_users_state.dart';

class GetAllUsersBloc extends Bloc<GetAllUsersEvent, GetAllUsersState> {
  GetAllUsersBloc() : super(GetAllUsersInitial()) {
    on<GetAllUsersEvent>((event, emit) async {
      emit(GetAllUsersLoadingState());
      final Response response = await UserRepo.getAllUsers();
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> usersJson = jsonDecode(response.body)['users'];
        final List<GetAllUsersModel> users = usersJson
            .map((userJson) => GetAllUsersModel.fromJson(userJson))
            .toList();
        emit(GetAllUsersSuccessState(users: users));
      } else {
        emit(GetAllUsersErrorState());
      }
    });
  }
}

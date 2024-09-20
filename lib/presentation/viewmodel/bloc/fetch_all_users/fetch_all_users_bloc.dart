import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'fetch_all_users_event.dart';
part 'fetch_all_users_state.dart';

class FetchAllUsersBloc extends Bloc<FetchAllUsersEvent, FetchAllUsersState> {
  FetchAllUsersBloc() : super(FetchAllUsersInitial()) {
    on<OnFetchAllUserEvent>((event, emit) async {
      emit(FetchAllUsersLoadingState());

      try {
        // Fetch users from the repository, handle pagination if needed
        final http.Response? result =
            await UserRepo.fetchAllUser(event.page, event.limit);

        if (result != null && result.statusCode == 200) {
          final Map<String, dynamic> responseBody = jsonDecode(result.body);

          // Assuming response contains "data" for users and "total" for total count
          final List<dynamic> usersData = responseBody['data'];
          final List<AllUser> allUsers =
              usersData.map((userJson) => AllUser.fromJson(userJson)).toList();

          emit(FetchAllUsersSuccessState(
              users: allUsers, total: responseBody['total'], page: event.page));
        } else {
          emit(FetchAllUsersErrorState(error: 'Failed to fetch users.'));
        }
      } catch (e) {
        emit(FetchAllUsersErrorState(error: 'Something went wrong.'));
      }
    });
  }
}

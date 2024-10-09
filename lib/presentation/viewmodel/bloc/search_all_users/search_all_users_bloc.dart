import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'search_all_users_event.dart';
part 'search_all_users_state.dart';

class SearchAllUsersBloc extends Bloc<SearchAllUsersEvent, SearchAllUsersState> {
  SearchAllUsersBloc() : super(SearchAllUsersInitial()) {
    on<OnSearchAllUsersEvent>((event, emit) async{
      emit(SearchAllUsersLoadingState());
      final Response response=await UserRepo.searchAllUsers(query: event.query);
      if(response.statusCode ==200){
        List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<UserIdSearchModel> users=jsonResponse.map((user)=>UserIdSearchModel.fromJson(user)).toList();
        emit(SearchAllUsersSuccessState(users: users));
      }else{
        emit(SearchAllUsersErrorState());
      }
    });

    // // Handle fetching all users
    // on<OnFetchAllUsersEvent>((event, emit) async {
    //   emit(SearchAllUsersLoadingState());
    //   final Response response = await UserRepo.fetchAllUsers(); // Create this method in your UserRepo
    //   if (response.statusCode == 200) {
    //     List<dynamic> jsonResponse = jsonDecode(response.body);
    //     final List<UserIdSearchModel> users = jsonResponse.map((user) => UserIdSearchModel.fromJson(user)).toList();
    //     emit(SearchAllUsersSuccessState(users: users));
    //   } else {
    //     emit(SearchAllUsersErrorState());
    //   }
    // });
  }
}

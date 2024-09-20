import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/followers_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'fetchfollowers_event.dart';
part 'fetchfollowers_state.dart';

class FetchfollowersBloc extends Bloc<FetchfollowersEvent, FetchfollowersState> {
  FetchfollowersBloc() : super(FetchfollowersInitial()) {
    on<OnfetchAllFollowersEvent>((event, emit) async{
      emit(FetchfollowersLoadingState());
      final Response result = await UserRepo.fetchFollowers();
      final responseBody =jsonDecode(result.body);
      if(result.statusCode ==200){
        final FollowersModel followersModel=FollowersModel.fromJson(responseBody);
        return emit(FetchfollowersSuccessState(followersModel: followersModel));  
      }else{
        return emit(FetchfollowersErrorState());
      }
    
    });
  }
}

import 'package:flutter/material.dart';
import 'package:vibehunt/data/models/followers_model.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_screen.dart';
import 'package:vibehunt/utils/constants.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key, required this.model});
  final FollowersModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers', style: j24),
        centerTitle: true,
      ),
      body: model.followers.isNotEmpty
          ? ListView.builder(
              itemCount: model.followers.length,
              itemBuilder: (context, index) {
                final follower = model.followers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(follower.profilePic),
                  ),
                  title: Text(follower.userName),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                              userId: model.followers[index].id,
                              user: UserIdSearchModel(
                                  bio: model.followers[index].bio ?? '',
                                  id: model.followers[index].id,
                                  userName: model.followers[index].userName,
                                  email: model.followers[index].userName,
                                  profilePic: model.followers[index].profilePic,
                                  online: model.followers[index].online,
                                  blocked: model.followers[index].blocked,
                                  verified: model.followers[index].verified,
                                  role: model.followers[index].role,
                                  isPrivate: model.followers[index].isPrivate,
                                  backGroundImage:
                                      model.followers[index].backGroundImage,
                                  createdAt: model.followers[index].createdAt,
                                  updatedAt: model.followers[index].updatedAt,
                                  v: model.followers[index].v)),
                        ),
                      );
                  },
                );
              },
            )
          : Center(
              child: Text('No followers', style: j20),
            ),
    );
  }
}

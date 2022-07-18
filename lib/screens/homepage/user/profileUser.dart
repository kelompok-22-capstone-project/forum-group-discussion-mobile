import 'package:flutter/material.dart';
import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:moot/models/provider/navigation_provider.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/models/provider/user_provider.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';
import 'package:moot/screens/homepage/user/threadDetail.dart';
import 'package:provider/provider.dart';

class ProfileUser extends StatefulWidget {
  final String username;
  const ProfileUser({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUser();
}

class _ProfileUser extends State<ProfileUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<UserProvider>(context, listen: false);
      await provider.getOwnProfile();
      String? username = provider.userData?.data?.username;
      if (username != widget.username) {
        await provider.getUserByUsername(widget.username);
        await provider.getThreadByUsername(widget.username, 1, 10);
        await provider.changeIsFriend(true);
      } else {
        await provider.getThreadByUsername("$username", 1, 10);
        await provider.changeIsFriend(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                if (!Provider.of<UserProvider>(context, listen: false).isFriend) {
                  context.read<AuthProvider>().logoutUser();
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  context.read<NavigationProvider>().setBottomNavItem(0);
                }
              },
              icon: const Icon(Icons.logout),
              color: Provider.of<UserProvider>(context, listen: true).isFriend ? Colors.transparent : Color(0xFFFF7262),
            )
          ],
          title: Text(
            Provider.of<UserProvider>(context, listen: true).isFriend ? 'Friends Profile' : 'Your Profile',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
        ),
        body: Consumer<UserProvider>(builder: (context, value, _) {
          final isLoading = value.state == UserProviderState.loading;
          final isError = value.state == UserProviderState.error;

          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      foregroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/exampleAvatar.png'),
                    ),
                    Text(
                      "${value.isFriend ? value.userFriendData?.data?.name : value.userData?.data?.name}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '@${value.isFriend ? value.userFriendData?.data?.username : value.userData?.data?.username}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Thread',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${value.isFriend ? value.userFriendData?.data?.totalThread : value.userData?.data?.totalThread}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${value.isFriend ? value.userFriendData?.data?.totalFollower : value.userData?.data?.totalFollower}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${value.isFriend ? value.userFriendData?.data?.totalFollowing : value.userData?.data?.totalFollowing}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    value.isFriend
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4C74D9)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  )),
                              child: Text(
                                'Follow',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () async {
                                await value.putFollowUser("${value.userFriendData?.data?.username}");
                                await value.getUserByUsername(widget.username);
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: value.thread?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ThreadDetail(index: index)));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${value.thread?[index].title}",
                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(left: 0),
                                      leading: CircleAvatar(
                                        foregroundColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          'assets/images/exampleAvatar.png',
                                          scale: 0.5,
                                        ),
                                      ),
                                      title: Text(
                                        "${value.thread?[index].creatorName}",
                                      ),
                                      subtitle: Text(
                                        "${value.thread?[index].creatorUsername}",
                                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                      ),
                                      trailing: CategoryButtonWidget(
                                          buttonText: "${value.thread?[index].categoryName}",
                                          onpressed: () {},
                                          color: 0xffA5B9EA),
                                    ),
                                    Text(
                                      "${value.thread?[index].description}",
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButtonWidget(
                                          buttonText: "${value.thread?[index].totalLike}",
                                          onpressed: () async {
                                            await Provider.of<ThreadProvider>(context, listen: false)
                                                .putLikeThread("${value.thread?[index].iD}");
                                            await Provider.of<ThreadProvider>(context, listen: false)
                                                .getAllThread(1, 10, '');
                                          },
                                          index: index,
                                          asset: 'assets/images/icons/thumbs.svg',
                                          color:
                                              Provider.of<ThreadProvider>(context, listen: true).thread![index].isLiked!
                                                  ? const Color(0xFFED4C5C)
                                                  : const Color(0xffB3B3B3),
                                        ),
                                        TextButtonWidget(
                                          buttonText: "${value.thread?[index].totalFollower}",
                                          onpressed: () async {
                                            await Provider.of<ThreadProvider>(context, listen: false)
                                                .putFollowThread("${value.thread?[index].iD}");
                                            await Provider.of<ThreadProvider>(context, listen: false)
                                                .getAllThread(1, 10, '');
                                          },
                                          index: index,
                                          asset: 'assets/images/icons/favorite.svg',
                                          color: Provider.of<ThreadProvider>(context, listen: true)
                                                  .thread![index]
                                                  .isFollowed!
                                              ? const Color(0xFFED4C5C)
                                              : const Color(0xffB3B3B3),
                                        ),
                                        TextButtonWidget(
                                          buttonText: "${value.thread?[index].totalComment}",
                                          onpressed: () {},
                                          index: index,
                                          asset: 'assets/images/icons/comment.svg',
                                          color: const Color(0xffB3B3B3),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar:
            Provider.of<UserProvider>(context, listen: true).isFriend ? null : NavigationBottomWidget(),
      );
}

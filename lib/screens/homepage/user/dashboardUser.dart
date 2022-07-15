import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';
import 'package:moot/components/RoundedButton.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';
import 'package:moot/screens/homepage/user/threadDetail.dart';
import 'package:provider/provider.dart';

class DashboardUser extends StatefulWidget {
  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, '');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          title: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Image.asset('assets/images/logo.png', height: 70, width: 70)),
          backgroundColor: Colors.white,
          elevation: 0.3,
        ),
        body: Consumer<ThreadProvider>(builder: (context, value, _) {
          final isLoading = value.state == ThreadProviderState.loading;
          final isError = value.state == ThreadProviderState.error;

          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: value.thread?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThreadDetail(index: index)));
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
                              "@${value.thread?[index].creatorUsername}",
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
                                  await value.putLikeThread("${value.thread?[index].iD}");
                                  await value.getAllThread(1, 10, '');
                                },
                                index: index,
                                asset: 'assets/images/icons/thumbs.svg',
                                color: Provider.of<ThreadProvider>(context, listen: true).thread![index].isLiked!
                                    ? const Color(0xFFED4C5C)
                                    : const Color(0xffB3B3B3),
                              ),
                              TextButtonWidget(
                                buttonText: "${value.thread?[index].totalFollower}",
                                onpressed: () async {
                                  await value.putFollowThread("${value.thread?[index].iD}");
                                  await value.getAllThread(1, 10, '');
                                },
                                index: index,
                                asset: 'assets/images/icons/favorite.svg',
                                color: Provider.of<ThreadProvider>(context, listen: true).thread![index].isFollowed!
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
          );
        }),
        bottomNavigationBar: const NavigationBottomWidget(),
      );
}

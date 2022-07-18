import 'package:flutter/material.dart';

import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';

import 'package:moot/components/theme.dart';

import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/models/provider/user_provider.dart';

import 'package:moot/screens/homepage/user/empty_result.dart';
import 'package:moot/screens/homepage/user/profileUser.dart';
import 'package:moot/screens/homepage/user/threadDetail.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SearchDetail extends StatefulWidget {
  const SearchDetail({Key? key}) : super(key: key);

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, "");
      Provider.of<UserProvider>(context, listen: false).getAllUsers(1, 20, "ranking", "active", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ThreadProvider>();
    final providerUser = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              provider.setSearchText(false, "");
              provider.changeTabIndex(0);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
              borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            onFieldSubmitted: (value) async {
              await provider.setSearchText(true, value);
              await provider.getAllThread(1, 10, value);
              await providerUser.getAllUsers(1, 20, "ranking", "active", value);
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                size: 25,
              ),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 17),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Username';
              }
              return null;
            },
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<ThreadProvider>(builder: (context, provider, _) {
        final isLoading = provider.state == ThreadProviderState.loading;
        final isError = provider.state == ThreadProviderState.error;

        if (isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (!provider.searchBool) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 6, right: 10, top: 10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.thread?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ThreadDetail(index: index)));
                          },
                          child: ListTile(
                            leading: const Icon(Icons.search),
                            title: Text(provider.thread![index].title!),
                            trailing: const Icon(Icons.north_west),
                          ),
                        );
                      }),
                ),
                const Divider(
                  height: 25,
                  thickness: 2,
                  indent: 17,
                  endIndent: 15,
                ),
                Consumer<UserProvider>(builder: (context, value, _) {
                  final isLoading = value.state == UserProviderState.loading;
                  final isError = value.state == UserProviderState.error;

                  if (isLoading) {
                    return CircularProgressIndicator();
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.users?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            enabled: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileUser(username: "${value.users?[index].username}")));
                            },
                            leading: CircleAvatar(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/exampleAvatar.png',
                                scale: 0.5,
                              ),
                            ),
                            title: Text("${value.users?[index].name}"),
                            subtitle: Text("@${value.users?[index].username}"),
                          );
                        }),
                  );
                }),
              ],
            ),
          );
        } else {
          return _buildSearched(context);
        }
      }),
    );
  }

  Widget _buildSearched(BuildContext context) {
    return Consumer<ThreadProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      child: TabBar(
                        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                        indicatorWeight: 1,
                        onTap: (value) async {
                          await provider.changeTabIndex(value);
                        },
                        tabs: [
                          Tab(
                            text: "Top",
                          ),
                          Tab(
                            text: "Latest",
                          ),
                          Tab(
                            text: "People",
                          ),
                        ],
                        labelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: MaterialIndicator(
                          height: 6,
                          topLeftRadius: 0,
                          topRightRadius: 0,
                          bottomLeftRadius: 5,
                          bottomRightRadius: 5,
                          tabPosition: TabPosition.top,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: _buildTabHome(context, provider.tabIndex))
        ],
      );
    });
  }

  Widget _buildTabHome(BuildContext context, int index) {
    if (index == 0) {
      return _buildTabContentHome(context);
    } else if (index == 1) {
      return _buildTabContentLatest(context);
    } else if (index == 2) {
      return _buildTabContentPeople(context);
    }
    return _buildTabContentHome(context);
  }

  Widget _buildTabContentHome(BuildContext context) {
    return Consumer<ThreadProvider>(builder: (context, value, _) {
      final isLoading = value.state == ThreadProviderState.loading;
      final isError = value.state == ThreadProviderState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (isError) {
        return EmptyResult();
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * 0.835,
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
                            buttonText: "${value.thread?[index].categoryName}", onpressed: () {}, color: 0xffA5B9EA),
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
                              await Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, '');
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
    });
  }

  Widget _buildTabContentLatest(BuildContext context) {
    return Consumer<ThreadProvider>(builder: (context, value, _) {
      final isLoading = value.state == ThreadProviderState.loading;
      final isError = value.state == ThreadProviderState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (isError) {
        return EmptyResult();
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * 0.835,
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
                            buttonText: "${value.thread?[index].categoryName}", onpressed: () {}, color: 0xffA5B9EA),
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
    });
  }

  Widget _buildTabContentPeople(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, _) {
      final isLoading = value.state == UserProviderState.loading;
      final isError = value.state == UserProviderState.error;

      if (isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (isError) {
        return EmptyResult();
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * 0.835,
        child: ListView.builder(
          itemCount: value.users?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 0),
                        leading: CircleAvatar(
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            "assets/images/exampleAvatar.png",
                            scale: 0.5,
                          ),
                        ),
                        title: Text("${value.users?[index].name}"),
                        subtitle: Text(
                          "${value.users?[index].username}",
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

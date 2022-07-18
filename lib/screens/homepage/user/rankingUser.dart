import 'package:flutter/material.dart';

import 'package:moot/components/RankingCard.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/user_provider.dart';

import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';
import 'package:provider/provider.dart';

class RankingUser extends StatefulWidget {
  @override
  State<RankingUser> createState() => _RankingUserState();
}

class _RankingUserState extends State<RankingUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers(1, 20, "ranking", "active", "");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ranking',
            style: TextStyle(color: Colors.black),
          ),
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
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: TextFormField(
                    onFieldSubmitted: (v) async {
                      await value.getAllUsers(1, 20, "ranking", "active", v);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Keyword';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                    itemCount: value.users?.length,
                    itemBuilder: (context, index) {
                      return RangkingCard(
                        context: context,
                        index: index,
                        picture: 'assets/images/exampleAvatar.png',
                        name: '${value.users?[index].name}',
                        subName: '${value.users?[index].username}',
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: const NavigationBottomWidget(),
      );
}

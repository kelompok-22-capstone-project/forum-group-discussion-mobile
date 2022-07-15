import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/categorie_provider.dart';

import 'package:moot/screens/homepage/user/category_detail.dart';
import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';
import 'package:moot/screens/homepage/user/seach_detail.dart';
import 'package:provider/provider.dart';

class SearchUser extends StatefulWidget {
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategorieProvider>(context, listen: false).getAllCategorie();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDetail()));
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 19),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/images/banner.png'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Categories',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
              ),
              Consumer<CategorieProvider>(builder: (context, provider, _) {
                final isLoading = provider.state == CategorieProviderState.loading;
                final isError = provider.state == CategorieProviderState.error;

                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height * provider.heightCategory,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2.5,
                        children: List.generate(provider.categorie!.length, (index) {
                          return TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff4C74D9)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                )),
                            child: Text(
                              '${provider.categorie?[index].name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryDetail(
                                            id: "${provider.categorie?[index].iD}",
                                            desc: "${provider.categorie?[index].description}",
                                            categoryName: "${provider.categorie?[index].name}",
                                          )));
                            },
                          );
                        }),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          provider.changeHeight();
                          print(provider.heightCategory);
                        },
                        child: Text(
                          provider.heightCategory == 0.3 ? 'Show More' : 'Show Less',
                          style: TextStyle(color: Color(0xff4C74D9), fontSize: 18),
                        ))
                  ],
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: const NavigationBottomWidget(),
      );
}

import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/categorie_provider.dart';
import 'package:moot/screens/homepage/admin/categoryDetailAdmin.dart';
import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';
import 'package:moot/screens/homepage/user/category_detail.dart';
import 'package:provider/provider.dart';

class CategoryAdmin extends StatefulWidget {
  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategorieProvider>(context, listen: false).getAllCategorie();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'User',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add',
                      style: TextStyle(color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.only(left: 10, top: 6),
                    child: TextFormField(
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
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: createMaterialColor(Color.fromARGB(87, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      "assets/images/icons/filter.png",
                      height: 50,
                      width: 50,
                    ),
                  )
                ],
              ),
              Consumer<CategorieProvider>(builder: (context, value, _) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10),
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: ListView.builder(
                    itemCount: value.categorie?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryDetailAdmin(
                                            id: "${value.categorie?[index].iD}",
                                            desc: "${value.categorie?[index].description}",
                                            categoryName: "${value.categorie?[index].name}",
                                            date: "${value.categorie?[index].createdOn}",
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * 0.57,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${value.categorie?[index].name}",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                          title: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xffED4C5C),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBottomWidgetAdmin(),
      );
}

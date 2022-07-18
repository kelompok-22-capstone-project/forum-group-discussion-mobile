import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/categorie_provider.dart';
import 'package:moot/screens/homepage/admin/categoryAddForm.dart';
import 'package:moot/screens/homepage/admin/categoryDetailAdmin.dart';
import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';
import 'package:moot/screens/homepage/user/empty_result.dart';
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
            'Category',
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryAddForm(id: null, desc: null, categoryName: null)));
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Consumer<CategorieProvider>(builder: (context, value, _) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: TextFormField(
                    onFieldSubmitted: (v) {
                      value.search(v);
                    },
                    keyboardType: TextInputType.text,
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
                Consumer<CategorieProvider>(builder: (context, value, _) {
                  final isLoading = value.state == CategorieProviderState.loading;
                  final isError = value.state == CategorieProviderState.error;

                  if (isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (isError) {
                    return EmptyResult();
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 15, right: 10),
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: ListView.builder(
                      // ignore: unrelated_type_equality_checks
                      itemCount: value.baru!.isEmpty ? value.categorie?.length : value.baru!.length,
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
                                      id: "${value.baru!.isEmpty ? value.categorie![index].iD : value.baru![index].iD}",
                                      desc:
                                          "${value.baru!.isEmpty ? value.categorie![index].description : value.baru![index].description}",
                                      categoryName:
                                          "${value.baru!.isEmpty ? value.categorie![index].name : value.baru![index].name}",
                                      date:
                                          "${value.baru!.isEmpty ? value.categorie![index].createdOn : value.baru![index].createdOn}",
                                    ),
                                  ),
                                );
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
                                      "${value.baru!.isEmpty ? value.categorie![index].name : value.baru![index].name}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                            title: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryAddForm(
                                            id: value.baru!.isEmpty
                                                ? value.categorie![index].iD
                                                : value.baru![index].iD,
                                            desc: value.baru!.isEmpty
                                                ? value.categorie![index].description
                                                : value.baru![index].description,
                                            categoryName: value.baru!.isEmpty
                                                ? value.categorie![index].name
                                                : value.baru![index].name)));
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xffED4C5C),
                              ),
                              onPressed: () {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  text: 'Do you want to delete this category ?',
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  confirmBtnColor: Colors.green,
                                  onConfirmBtnTap: () async {
                                    Navigator.pop(context);
                                    await value.deleteCategorie(
                                        "${value.baru!.isEmpty ? value.categorie![index].iD : value.baru![index].iD}");

                                    await value.getAllCategorie();
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            );
          }),
        ),
        bottomNavigationBar: NavigationBottomWidgetAdmin(),
      );
}

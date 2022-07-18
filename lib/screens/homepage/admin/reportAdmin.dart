import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/admin_provider.dart';

import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';
import 'package:moot/screens/homepage/admin/reportDetailAdmin.dart';

import 'package:provider/provider.dart';

class ReportAdmin extends StatefulWidget {
  @override
  State<ReportAdmin> createState() => _ReportAdminState();
}

class _ReportAdminState extends State<ReportAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminProvider>(context, listen: false).getAllReport("review", 1, 20);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thread Report',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
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
              Consumer<AdminProvider>(builder: (context, value, _) {
                final isLoading = value.state == AdminProviderState.loading;
                final isError = value.state == AdminProviderState.error;

                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10),
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: ListView.builder(
                    itemCount: value.report?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          enabled: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportDetailAdmin(
                                          index: index,
                                        )));
                          },
                          leading: CircleAvatar(
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              'assets/images/exampleAvatar.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          title: Text(
                            "${value.report?[index].name}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "@${value.report?[index].username}",
                            style: TextStyle(fontSize: 15),
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

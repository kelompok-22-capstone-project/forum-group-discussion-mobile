import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';

import 'package:moot/models/provider/thread_provider.dart';

import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';
import 'package:moot/screens/homepage/admin/threadDetailAdmin.dart';

import 'package:moot/screens/homepage/user/empty_result.dart';
import 'package:provider/provider.dart';

class ThreadAdmin extends StatefulWidget {
  @override
  State<ThreadAdmin> createState() => _ThreadAdminState();
}

class _ThreadAdminState extends State<ThreadAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, "");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thread',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Consumer<ThreadProvider>(builder: (context, value, _) {
            final isLoading = value.state == ThreadProviderState.loading;
            final isError = value.state == ThreadProviderState.error;

            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

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
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (v) async {
                      await value.getAllThread(1, 10, v);
                    },
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
                !isError
                    ? Container(
                        margin: const EdgeInsets.only(top: 15, right: 10),
                        height: MediaQuery.of(context).size.height * 0.73,
                        child: ListView.builder(
                          itemCount: value.thread?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                enabled: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ThreadDetailAdmin(
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
                                  "${value.thread?[index].title}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "@${value.thread?[index].creatorUsername}",
                                  style: TextStyle(fontSize: 15),
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
                                      text: 'Do you want to delete this thread ?',
                                      confirmBtnText: 'Yes',
                                      cancelBtnText: 'No',
                                      confirmBtnColor: Colors.green,
                                      onConfirmBtnTap: () async {
                                        Navigator.pop(context);
                                        await value.deleteThread("${value.thread?[index].iD}");

                                        await value.getAllThread(1, 10, "");
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : EmptyResult(),
              ],
            );
          }),
        ),
        bottomNavigationBar: NavigationBottomWidgetAdmin(),
      );
}

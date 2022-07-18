import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:moot/models/provider/admin_provider.dart';

import 'package:provider/provider.dart';

class ReportDetailAdmin extends StatefulWidget {
  final int index;

  const ReportDetailAdmin({Key? key, required this.index}) : super(key: key);

  @override
  State<ReportDetailAdmin> createState() => _ReportDetailAdminState();
}

class _ReportDetailAdminState extends State<ReportDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Report Details', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  text: 'Do you want to ban this user ?',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () {
                    final provider = Provider.of<AdminProvider>(context, listen: false);
                    provider.putBanUser("${provider.report?[widget.index].username}");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    CoolAlert.show(context: context, type: CoolAlertType.success);
                    provider.getAllReport("review", 1, 20);
                  },
                );
              },
              child: Text(
                "Ban",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ))
        ],
      ),
      body: Consumer<AdminProvider>(builder: (context, value, _) {
        final isLoading = value.state == AdminProviderState.loading;
        final isError = value.state == AdminProviderState.error;
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      foregroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/exampleAvatar.png'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${value.report?[widget.index].name}",
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        Text("${value.report?[widget.index].username}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Title",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.report?[widget.index].threadTitle}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Report Reason",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.report?[widget.index].reason}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Report By",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "@${value.report?[widget.index].moderatorUsername}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.report?[widget.index].reportedOn}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Report Source",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.report?[widget.index].comment}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

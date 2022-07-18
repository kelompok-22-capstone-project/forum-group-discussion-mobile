import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:moot/models/provider/thread_provider.dart';

import 'package:provider/provider.dart';

class ThreadDetailAdmin extends StatefulWidget {
  final int index;

  const ThreadDetailAdmin({Key? key, required this.index}) : super(key: key);

  @override
  State<ThreadDetailAdmin> createState() => _ThreadDetailAdminState();
}

class _ThreadDetailAdminState extends State<ThreadDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Thread Details', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  text: 'Do you want to delete this thread ?',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () async {
                    var provider = Provider.of<ThreadProvider>(context, listen: false);
                    await provider.deleteThread("${provider.thread?[widget.index].iD}");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    CoolAlert.show(context: context, type: CoolAlertType.success);
                    await provider.getAllThread(1, 10, "");
                  },
                );
              },
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ))
        ],
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
                        Text("${value.thread?[widget.index].creatorName}",
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        Text("${value.thread?[widget.index].creatorUsername}",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Title",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.thread?[widget.index].title}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Category",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.thread?[widget.index].categoryName}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.thread?[widget.index].publishedOn}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Thread",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        "${value.thread?[widget.index].description}",
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

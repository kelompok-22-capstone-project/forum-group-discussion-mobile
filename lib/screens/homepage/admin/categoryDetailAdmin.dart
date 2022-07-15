import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';
import 'package:moot/models/provider/categorie_provider.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/screens/homepage/user/empty_result.dart';
import 'package:moot/screens/homepage/user/threadDetail.dart';
import 'package:provider/provider.dart';

class CategoryDetailAdmin extends StatefulWidget {
  final String id;
  final String desc;
  final String categoryName;
  final String date;
  const CategoryDetailAdmin(
      {Key? key, required this.id, required this.desc, required this.categoryName, required this.date})
      : super(key: key);

  @override
  State<CategoryDetailAdmin> createState() => _CategoryDetailAdminState();
}

class _CategoryDetailAdminState extends State<CategoryDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Category Details', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Consumer<CategorieProvider>(builder: (context, value, _) {
        final isLoading = value.state == CategorieProviderState.loading;
        final isError = value.state == CategorieProviderState.error;
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
                        Text("Welcome Admin", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                        Text("Kelompok 22", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400))
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
                        "Category Name",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        widget.categoryName,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        widget.desc,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Data",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xff4C74D9)),
                      ),
                      subtitle: Text(
                        widget.date,
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

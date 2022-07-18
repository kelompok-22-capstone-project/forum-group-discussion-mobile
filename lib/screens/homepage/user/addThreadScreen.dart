import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moot/components/RoundedButton.dart';
import 'package:moot/models/provider/categorie_provider.dart';
import 'package:moot/models/provider/thread_provider.dart';

import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:provider/provider.dart';

class AddThreadScreen extends StatefulWidget {
  @override
  State<AddThreadScreen> createState() => _AddThreadScreenState();
}

class _AddThreadScreenState extends State<AddThreadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String id = '';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CategorieProvider>(context, listen: false);
      provider.getAllCategorie();
      provider.getOwnProfile();
      print(context.read<CategorieProvider>().dropDownItemList);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Text(
              'Create Thread',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            Consumer<ThreadProvider>(builder: (context, value, _) {
              return Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8, right: 15),
                child: RoundedButtonWidget(
                    buttonText: 'Post',
                    width: 50,
                    onpressed: () async {
                      var user =
                          await value.postThreadUser(_titleController.text.trim(), _descController.text.trim(), id);

                      String? errorMessage = value.errorMessage;
                      if (value.postThread != null) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${value.postThread?.message}")),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("$errorMessage")),
                        );
                      }
                      _titleController.clear();
                      _descController.clear();
                    },
                    color: 0xff4C74D9),
              );
            })
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Consumer<CategorieProvider>(builder: (context, value, _) {
          final isLoading = value.state == CategorieProviderState.loading;
          final isError = value.state == CategorieProviderState.error;

          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Form(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            foregroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/images/exampleAvatar.png'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${value.userData?.data?.name}",
                                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                              Text("${value.userData?.data?.username}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300))
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _titleController,
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Tiltle Thread",
                          hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.grey)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Title';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: CoolDropdown(
                        placeholder: 'Category',
                        placeholderTS: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.grey),
                        dropdownList: value.dropDownItemList,
                        onChange: (selectedItem) {
                          print(selectedItem['value']);
                          id = selectedItem['value'];
                        },
                        gap: 10,
                        dropdownAlign: 'center',
                        resultBD: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        resultIcon: Container(
                          width: 10,
                          height: 10,
                          child: SvgPicture.asset(
                            'assets/images/icons/dropdown-arrow.svg',
                            semanticsLabel: 'Acme Logo',
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 30),
                      child: TextFormField(
                        controller: _descController,
                        maxLines: 25,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration.collapsed(
                            hintText: "Write your thread",
                            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: const NavigationBottomWidget(),
      );
}

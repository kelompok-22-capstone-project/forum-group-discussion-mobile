import 'package:flutter/material.dart';

import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/categorie_provider.dart';

import 'package:provider/provider.dart';

class CategoryAddForm extends StatefulWidget {
  final String? id;
  final String? desc;
  final String? categoryName;
  const CategoryAddForm({Key? key, required this.id, required this.desc, required this.categoryName}) : super(key: key);

  @override
  State<CategoryAddForm> createState() => _CategoryAddFormState();
}

class _CategoryAddFormState extends State<CategoryAddForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.categoryName != null) {
      _categoryController.text = widget.categoryName!;
      _descController.text = widget.desc!;
    }
  }

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
          Consumer<CategorieProvider>(
            builder: (context, value, _) {
              return TextButton(
                child: Text(
                  widget.categoryName != null ? "Update" : "Add",
                  style: TextStyle(fontSize: 18, color: Color(0xff4C74D9)),
                ),
                onPressed: value.enableButton
                    ? () async {
                        if (widget.categoryName != null) {
                          await value.putUpdateCategorie(
                              widget.id!, _categoryController.text.trim(), _descController.text.trim());
                          await value.getAllCategorie();
                        } else {
                          await value.postCategory(_categoryController.text.trim(), _descController.text.trim());
                          String? message = value.postThread?.message;
                          String? errorMessage = value.errorMessage;
                          await value.getAllCategorie();

                          if (value.postThread != null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("$message")),
                            );
                            Navigator.pop(context);
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("$errorMessage")),
                            );
                          }
                        }
                      }
                    : null,
              );
            },
          )
        ],
      ),
      body: Consumer<CategorieProvider>(builder: (context, value, _) {
        final isLoading = value.state == CategorieProviderState.loading;
        final isError = value.state == CategorieProviderState.error;
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xff4C74D9)),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                      color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _categoryController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.categoryName ?? "e.g Sport, Programming",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Username';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xff4C74D9)),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                      color: createMaterialColor(const Color.fromARGB(41, 179, 179, 179)),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                  child: TextFormField(
                    enabled: true,
                    onChanged: (v) {
                      value.changeButton(true);
                    },
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    controller: _descController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.categoryName ?? "e.g Programming have may language like dart, java, kotlin",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please Enter Your Username';
                      }
                      value.changeButton(true);
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

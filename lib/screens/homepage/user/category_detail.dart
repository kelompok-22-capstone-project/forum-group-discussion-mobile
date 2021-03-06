import 'package:flutter/material.dart';

import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';
import 'package:moot/models/provider/categorie_provider.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/screens/homepage/user/empty_result.dart';
import 'package:moot/screens/homepage/user/threadDetail.dart';
import 'package:provider/provider.dart';

class CategoryDetail extends StatefulWidget {
  final String id;
  final String desc;
  final String categoryName;
  const CategoryDetail({Key? key, required this.id, required this.desc, required this.categoryName}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<CategorieProvider>(context, listen: false);
      provider.getThreadByCategoryId(widget.id, 1, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Category', style: TextStyle(color: Colors.black)),
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

        if (isError) {
          return EmptyResult();
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Card(
                  child: ListTile(
                    title: Text(
                      widget.categoryName,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                    ),
                    subtitle: Text(
                      widget.desc,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.62,
                child: ListView.builder(
                  itemCount: value.thread?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ThreadDetail(index: index)));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${value.thread?[index].title}",
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(left: 0),
                                leading: CircleAvatar(
                                  foregroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/exampleAvatar.png',
                                    scale: 0.5,
                                  ),
                                ),
                                title: Text(
                                  "${value.thread?[index].creatorName}",
                                ),
                                subtitle: Text(
                                  "@${value.thread?[index].creatorUsername}",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                                trailing: CategoryButtonWidget(
                                    buttonText: "${value.thread?[index].categoryName}",
                                    onpressed: () {},
                                    color: 0xffA5B9EA),
                              ),
                              Text(
                                "${value.thread?[index].description}",
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButtonWidget(
                                    buttonText: "${value.thread?[index].totalLike}",
                                    onpressed: () async {
                                      await Provider.of<ThreadProvider>(context, listen: false)
                                          .putLikeThread("${value.thread?[index].iD}");
                                      await Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, '');
                                    },
                                    index: index,
                                    asset: 'assets/images/icons/thumbs.svg',
                                    color: Provider.of<ThreadProvider>(context, listen: true).thread![index].isLiked!
                                        ? const Color(0xFFED4C5C)
                                        : const Color(0xffB3B3B3),
                                  ),
                                  TextButtonWidget(
                                    buttonText: "${value.thread?[index].totalFollower}",
                                    onpressed: () async {
                                      await Provider.of<ThreadProvider>(context, listen: false)
                                          .putFollowThread("${value.thread?[index].iD}");
                                      await Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, '');
                                    },
                                    index: index,
                                    asset: 'assets/images/icons/favorite.svg',
                                    color: Provider.of<ThreadProvider>(context, listen: true).thread![index].isFollowed!
                                        ? const Color(0xFFED4C5C)
                                        : const Color(0xffB3B3B3),
                                  ),
                                  TextButtonWidget(
                                    buttonText: "${value.thread?[index].totalComment}",
                                    onpressed: () {},
                                    index: index,
                                    asset: 'assets/images/icons/comment.svg',
                                    color: const Color(0xffB3B3B3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

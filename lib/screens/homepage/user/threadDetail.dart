import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moot/components/CategoryButton.dart';
import 'package:moot/components/ContentTextButton.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:provider/provider.dart';

class ThreadDetail extends StatefulWidget {
  final int index;
  const ThreadDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<ThreadDetail> createState() => _ThreadDetailState();
}

class _ThreadDetailState extends State<ThreadDetail> {
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
      var provider = Provider.of<ThreadProvider>(context, listen: false);
      final String? id = provider.thread?[widget.index].iD;
      provider.getCommentThreadById(id!, 1, 20);
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
        title: const Text('Thread', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
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
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${value.thread?[widget.index].title}",
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
                        title: Text("${value.thread?[widget.index].creatorName}"),
                        subtitle: Text(
                          "@${value.thread?[widget.index].creatorUsername}",
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        trailing: CategoryButtonWidget(
                            buttonText: "${value.thread?[widget.index].categoryName}",
                            onpressed: () {},
                            color: 0xffA5B9EA),
                      ),
                      Text(
                        "${value.thread?[widget.index].description}",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButtonWidget(
                            buttonText: "${value.thread?[widget.index].totalLike}",
                            onpressed: () async {
                              await Provider.of<ThreadProvider>(context, listen: false)
                                  .putLikeThread("${value.thread?[widget.index].iD}");
                              await Provider.of<ThreadProvider>(context, listen: false).getAllThread(1, 10, '');
                            },
                            index: widget.index,
                            asset: 'assets/images/icons/thumbs.svg',
                            color: Provider.of<ThreadProvider>(context, listen: true).thread![widget.index].isLiked!
                                ? const Color(0xFFED4C5C)
                                : const Color(0xffB3B3B3),
                          ),
                          TextButtonWidget(
                            buttonText: "${value.thread?[widget.index].totalFollower}",
                            onpressed: () async {
                              await value.putFollowThread("${value.thread?[widget.index].iD}");
                              await value.getAllThread(1, 10, '');
                            },
                            index: widget.index,
                            asset: 'assets/images/icons/favorite.svg',
                            color: Provider.of<ThreadProvider>(context, listen: true).thread![widget.index].isFollowed!
                                ? const Color(0xFFED4C5C)
                                : const Color(0xffB3B3B3),
                          ),
                          TextButtonWidget(
                            buttonText: "${value.thread?[widget.index].totalComment}",
                            onpressed: () {},
                            index: widget.index,
                            asset: 'assets/images/icons/comment.svg',
                            color: const Color(0xffB3B3B3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(color: Colors.blue),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                onPressed: () => {},
                icon: SvgPicture.asset(
                  "assets/images/icons/comment.svg",
                  height: 15,
                  width: 15,
                ),
                label: Text(
                  "${value.thread?[widget.index].totalComment} Comments",
                  style: TextStyle(color: Color(0xffB3B3B3), fontSize: 16),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: ListView.builder(
                    itemCount: value.comment?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    title: RichText(
                                      text: TextSpan(
                                        text: '${value.comment?[index].name} to ',
                                        style: const TextStyle(color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "@${value.thread?[widget.index].creatorUsername}",
                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                      '@${value.comment?[index].username}',
                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                    ),
                                    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))),
                                Text(
                                  '${value.comment?[index].comment}',
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Consumer<ThreadProvider>(builder: (context, value, _) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          height: 70,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0),
              leading: CircleAvatar(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/exampleAvatar.png',
                  scale: 1,
                ),
              ),
              title: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(15),
                  ),
                ),
                child: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a comment',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your password';
                    }
                  },
                ),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    var user = await value.postComment(value.thread![widget.index].iD!, _commentController.text.trim());
                    _commentController.clear();
                    await value.getAllThread(1, 10, '');
                  },
                  icon: const Icon(
                    Icons.send,
                    color: const Color(0xff4C74D9),
                  )),
            ),
          ),
        );
      }),
    );
  }
}

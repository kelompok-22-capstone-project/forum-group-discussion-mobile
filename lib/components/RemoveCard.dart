import 'package:flutter/material.dart';

import 'package:moot/models/provider/thread_provider.dart';
import 'package:moot/screens/homepage/user/profileUser.dart';
import 'package:provider/provider.dart';

class RemoveCard extends StatelessWidget {
  final int index;
  final String id;
  final String picture;
  final BuildContext context;

  final String name;
  final String subName;

  RemoveCard(
      {required this.index,
      required this.id,
      required this.picture,
      required this.context,
      required this.name,
      required this.subName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser(username: subName)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 15, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0),
                leading: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    picture,
                    scale: 0.5,
                  ),
                ),
                title: Text(name),
                subtitle: Text(
                  "@$subName",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                trailing: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 199, 13, 13)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Remove',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    var provider = Provider.of<ThreadProvider>(context, listen: false);
                    await Provider.of<ThreadProvider>(context, listen: false).putModeratorRemove(subName, id);
                    Navigator.pop(context);
                    await provider.getModeratorByIdThread(id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

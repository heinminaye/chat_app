import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool currentUser = true;
  FocusNode focusNode = FocusNode();
  String hintText = 'Aa';

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = 'Type a message ...';
      } else {
        hintText = 'Aa';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 35,
                child: TextField(
                  focusNode: focusNode,
                  controller: messageController,
                  style: const TextStyle(
                      fontSize: 14.0, height: 1.5, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('chat_app')
                      .add({'sender': "scroll@gmail.com", 'message': "Hello"});
                },
                icon: Icon(Icons.send_rounded, color: Colors.blueAccent))
          ]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "How was the concert?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

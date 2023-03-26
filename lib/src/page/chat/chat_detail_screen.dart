import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/chat/room_chat.dart';
import '../../repositpries/cloud_firestore_service.dart';
import '../../repositpries/firebase_storage.dart';
import '../../utils/utils.dart';
import 'mesage_tile.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key, required this.roomChat}) : super(key: key);
  final RoomChat roomChat;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot>? chats;
  final ScrollController _controller = ScrollController();
  File? imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getChat();
  }

  getChat() async {
    await CloudFirestoreService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getChats(widget.roomChat.roomID)
        .then((value) {
      if (mounted) {
        setState(() {
          chats = value;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(12)),
      child: FutureBuilder(
          future:
              CloudFirestoreService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getChats(widget.roomChat.roomID),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error!.toString(),
                      style: AppStyle.errorStyle,
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    chats = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 54,
                          decoration: BoxDecoration(
                              color: AppStyle.appColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          child: Center(
                            child: Text(
                              widget.roomChat.receiverName,
                              style: AppStyle.h2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: chatMessage(),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width,
                            // color: mainColor,
                            child: Row(children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      var data = await image.readAsBytes();
                                      String fileName =
                                          '${widget.roomChat.roomID}_${Utils.createFile()}';
                                      String? filePath =
                                          await FirebaseStorageService()
                                              .uploadFileChat(data, fileName);
                                      if (filePath != null) {
                                        await sendImage(filePath);
                                      }
                                    } else {}
                                  } catch (e) {
                                    MyDialog.showSnackBar(
                                        context, e.toString());
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppStyle.appColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: TextField(
                                controller: messageController,
                                style: const TextStyle(color: Colors.black),
                                onSubmitted: (_) {
                                  sendMessage();
                                },
                                decoration: const InputDecoration(
                                  hintText: "nhắn tin",
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                              )),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  sendMessage();
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppStyle.appColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Lỗi hệ thống',
                        style: AppStyle.errorStyle,
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      'Lỗi hệ thống',
                      style: AppStyle.errorStyle,
                    ),
                  );
                }
            }
          }),
    );
  }

  chatMessage() {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_controller.hasClients) {
                _controller.jumpTo(_controller.position.maxScrollExtent);
              }
            });
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: const EdgeInsets.only(top: 10),
              controller: _controller,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MessageTile(
                  message: snapshot.data.docs[index]['message'],
                  sender: snapshot.data.docs[index]['sender'],
                  time: snapshot.data.docs[index]['time'],
                  isImage: snapshot.data.docs[index]['isImage'],
                  sentByMe: FirebaseAuth.instance.currentUser!.uid ==
                      snapshot.data.docs[index]['sender'],
                  showTime: (
                    int height,
                  ) {
                    if (_controller.hasClients) {
                      _controller.jumpTo(_controller.offset + height);
                    }
                  },
                );
              },
            );
          } else {
            return Container();
          }
        });
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "time": formattedDate,
        "isImage": false,
      };
      await CloudFirestoreService(uid: FirebaseAuth.instance.currentUser!.uid)
          .sendMessage(widget.roomChat.roomID, chatMessageMap)
          .then((value) {
        if (mounted) {
          setState(() {
            messageController.clear();
          });
        }
      }).catchError((e) {
        if (mounted) {
          MyDialog.showSnackBar(context, e.toString());
        }
      });
    }
  }

  sendImage(String filePath) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    Map<String, dynamic> chatMessageMap = {
      "message": filePath,
      "sender": FirebaseAuth.instance.currentUser!.uid,
      "time": formattedDate,
      "isImage": true,
    };
    await CloudFirestoreService(uid: FirebaseAuth.instance.currentUser!.uid)
        .sendMessage(widget.roomChat.roomID, chatMessageMap)
        .then((value) {
      imageFile = null;
    }).catchError((e) {
      if (mounted) {
        MyDialog.showSnackBar(context, e.toString());
      }
    });
  }
}

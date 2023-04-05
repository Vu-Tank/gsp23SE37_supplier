import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/chat/chat_cubit.dart';
import 'package:gsp23se37_supplier/src/page/chat/chat_detail_screen.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/shop/shop_bloc.dart';
import '../model/chat/room_chat.dart';
import '../model/store.dart';
import '../model/user.dart';
import '../repositpries/cloud_firestore_service.dart';
import '../utils/utils.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Store store;
  late User user;
  bool _isLoading = false;
  Stream? rooms;
  RoomChat? _roomChat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      user = authState.user;
      if (user.storeID != -1) {
        ShopState shopState = context.read<ShopBloc>().state;
        if (shopState is ShopCreated) {
          if (shopState.store.store_Status.item_StatusID == 1) {
            store = shopState.store;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CloudFirestoreService(uid: store.firebaseID)
                  .getRoomsStream()
                  .then((value) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                    rooms = value;
                  });
                }
              }).catchError((e) {
                MyDialog.showSnackBar(context, e.toString());
              });
            });
          } else {
            GoRouter.of(context).pushReplacementNamed('/');
          }
        } else {
          GoRouter.of(context).pushReplacementNamed('/');
        }
      } else {
        GoRouter.of(context).pushReplacementNamed('/');
      }
    } else {
      GoRouter.of(context).pushReplacementNamed('/');
    }
    ChatState chatState = context.read<ChatCubit>().state;
    if (chatState is ChatSuccess) {
      _roomChat = chatState.roomChat;
      context.read<ChatCubit>().reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ElevatedButton(
            //     onPressed: () async {
            //       await CloudFirestoreService(uid: store.firebaseID)
            //           .createUserCloud(
            //               userName: store.storeName, imageUrl: store.image.path)
            //           .then((value) {
            //         MyDialog.showSnackBar(context, 'thành công');
            //       }).catchError((e) {
            //         MyDialog.showSnackBar(context, e.toString());
            //       });
            //     },
            //     child: const Text('tạo user')),
            Expanded(child: _listRoom()),
            if (_roomChat != null)
              Expanded(
                  child: ChatDetailScreen(
                roomChat: _roomChat!,
              )),
          ],
        ),
      ),
    );
  }

  Widget _listRoom() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: rooms,
            builder: (context, AsyncSnapshot snapshot) {
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
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        List<Stream<RoomChat>> listRoom =
                            snapshot.data as List<Stream<RoomChat>>;
                        return ListView.builder(
                          itemCount: listRoom.length + 1,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < listRoom.length) {
                              return StreamBuilder(
                                  stream: listRoom[index],
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      default:
                                        if (snapshot.hasError) {
                                          return Text(
                                            snapshot.error.toString(),
                                            style: AppStyle.errorStyle,
                                          );
                                        } else {
                                          if (snapshot.hasData) {
                                            if (snapshot.data != null) {
                                              final room = snapshot.data!;
                                              return _chatRoom(room);
                                            } else {
                                              return Text(
                                                'Không thể tải romchat này',
                                                style: AppStyle.errorStyle,
                                              );
                                            }
                                          } else {
                                            return Text(
                                              'Không thể tải romchat này',
                                              style: AppStyle.errorStyle,
                                            );
                                          }
                                        }
                                    }
                                  });
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Center(
                                  child:
                                      Text('Có ${listRoom.length} kết quả'),
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return noRoom();
                      }
                    } else {
                      return noRoom();
                    }
                  }
              }
            },
          );
  }

  _chatRoom(RoomChat roomChat) {
    return InkWell(
      child: Card(
        color: (_roomChat != null && roomChat.roomID == _roomChat!.roomID)
            ? AppStyle.appColor
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(30),
                  child: Image.network(roomChat.receiverImageUrl,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      roomChat.receiverName,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: AppStyle.h2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${(roomChat.recentMessageSender == store.firebaseID) ? 'Bạn: ' : ''}${(roomChat.isImage) ? 'Hình ảnh' : roomChat.recentMessage}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.h2,
                          ),
                        ),
                        Text(Utils.getTime(roomChat.time)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _roomChat = roomChat;
        });
      },
    );
  }

  noRoom() {
    return Center(
      child: Text(
        'Chưa có cuộc hội thoại',
        style: AppStyle.h2,
      ),
    );
  }
}

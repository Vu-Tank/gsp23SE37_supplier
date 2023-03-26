import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsp23se37_supplier/src/model/chat/room_chat.dart';
import 'package:gsp23se37_supplier/src/repositpries/cloud_firestore_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  chat({required String userFirebaseID}) async {
    if (isClosed) return;
    emit(ChatLoading());
    try {
      RoomChat? roomChat = await CloudFirestoreService(
              uid: FirebaseAuth.instance.currentUser!.uid)
          .checkExistRoom(userFirebaseID);
      if (roomChat != null) {
        if (isClosed) return;
        emit(ChatSuccess(roomChat));
      } else {
        roomChat = await CloudFirestoreService(
                uid: FirebaseAuth.instance.currentUser!.uid)
            .createRoom(otherUid: userFirebaseID);
        if (roomChat != null) {
          if (isClosed) return;
          emit(ChatSuccess(roomChat));
        } else {
          if (isClosed) return;
          emit(const ChatFailed('Lỗi Không thể liên hệ với khách hàng này'));
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(ChatFailed(e.toString()));
    }
  }

  reset() {
    if (isClosed) return;
    emit(ChatInitial());
  }
}

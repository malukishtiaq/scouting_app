// // lib/core/providers/message_service_provider.dart
// 
// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:scouting_app/features/chat/domain/entity/data_conversation_entity.dart';
// import 'package:scouting_app/features/chat/domain/entity/conversation_message_entity.dart';
// import '../../features/chat/presentation/state_m/chat/chat_bloc.dart';
// import '../services/message_polling_service.dart';
// 
// @singleton
// class MessageServiceProvider extends ChangeNotifier {
//   final MessagePollingService _pollingService;
//   StreamSubscription? _conversationsSubscription;
//   StreamSubscription? _chatMessagesSubscription;
// 
//   List<DataConversationEntity> conversations = [];
//   List<ConversationMessageEntity> chatMessages = [];
// 
//   MessageServiceProvider(this._pollingService);
// 
//   bool get isRunning => _pollingService.isRunning;
// 
//   // For main chat list screen
//   void startConversationsPolling(ChatBloc chatBloc) {
//     stopCurrentPolling();
//     _pollingService.startPollingConversations();
//     _conversationsSubscription =
//         _pollingService.conversationsStream.listen((_) {
//       chatBloc.add(RefreshChatListEvent());
//     });
//   }
// 
//   // For individual chat screen
//   void startChatPolling(int userId) {
//     stopCurrentPolling();
//     _pollingService.startPollingChat(userId);
//     _chatMessagesSubscription = _pollingService.chatMessagesStream.listen((_) {
//       // chatDetailsBloc.add(RefreshChatMessagesEvent());
//     });
//   }
// 
//   void stopCurrentPolling() {
//     _pollingService.stopPolling();
//     _conversationsSubscription?.cancel();
//     _chatMessagesSubscription?.cancel();
//   }
// 
//   @override
//   void dispose() {
//     stopCurrentPolling();
//     _pollingService.dispose();
//     super.dispose();
//   }
// }

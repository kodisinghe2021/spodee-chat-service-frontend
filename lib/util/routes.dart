String BASE_URL = "https://cecb-124-43-78-217.ngrok-free.app";
String WS_URL = "ws://cecb-124-43-78-217.ngrok-free.app/ws";
String wsSubscribe(String chatRoomId) =>
    "/topic/" + chatRoomId + ".public.messages";
String CREATE_CHAT_ROOM = "/api/chatroom";
String ADD_MEMBER_TO_CHAT = "/api/chatroom/participant";
String SEND_MESSAGE = "/api/messages";
String GET_MESSAGES = "/api/messages";

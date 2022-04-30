import 'package:flutter/material.dart';
import 'package:petswala/themes/colors.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Channel channel = ModalRoute.of(context).settings.arguments;
    print(channel == null ? "yessss":"nooooo");
    return StreamChannel(
      channel: channel,
      child: Scaffold(
        appBar: StreamChannelHeader(
            onBackPressed: () =>
                Navigator.of(context, rootNavigator: true).pop()),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamMessageListView(),
            ),
            StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}

class StandAloneChannelPage extends StatelessWidget {
  const StandAloneChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatArgs args = ModalRoute.of(context).settings.arguments as ChatArgs;
    Channel channel = args.channel;
    StreamChatClient client = args.client;
    print(channel == null ? "yessss":"nooooo");
    return StreamChat(
      client: client,
      streamChatThemeData: StreamChatThemeData(
      ownMessageTheme: StreamMessageThemeData(
      messageTextStyle: TextStyle(
          fontWeight:FontWeight.bold,
          color: AppColor.primary, fontSize: 20),
      avatarTheme: StreamAvatarThemeData(
          constraints: BoxConstraints(maxHeight:80, maxWidth:80),
          borderRadius: BorderRadius.circular(20)))),
                                                  
      child:StreamChannel(
      channel: channel,
      child: Scaffold(
        appBar: StreamChannelHeader(
            onBackPressed: () =>
                Navigator.of(context).pop()),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamMessageListView(),
            ),
            StreamMessageInput(),
          ],
        ),
      ),
    ));
  }
}


class ChatArgs{
  final Channel channel;
  final StreamChatClient client;
  ChatArgs({this.channel, this.client});
}
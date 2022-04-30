import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/spacingAndBorders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'channel_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChatNavigator extends StatefulWidget {
  final StreamChatClient client;
  const ChatNavigator({ Key key, this.client}) : super(key: key);

  @override
  State<ChatNavigator> createState() => _ChatNavigatorState();
}

class _ChatNavigatorState extends State<ChatNavigator> {

  
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    RouteSettings passedSettings = ModalRoute.of(context).settings;
    // print(passedSettings.name);
    // print(settings.name);
    return StreamChat(
      client: widget.client,
      streamChatThemeData: StreamChatThemeData(
      ownMessageTheme: StreamMessageThemeData(
      messageTextStyle: TextStyle(
          fontWeight:FontWeight.bold,
          color: AppColor.primary, fontSize: 20),
      avatarTheme: StreamAvatarThemeData(
          constraints: BoxConstraints(maxHeight:80, maxWidth:80),
          borderRadius: BorderRadius.circular(20)))),
                                                  
      child: Navigator(
          initialRoute: passedSettings.name,
           onGenerateRoute: (settings) {
              Widget page;
              print(settings.arguments == null ? "bilyesss":"bilnoooo");
              print(passedSettings.arguments == null ? "yesss":"noooo");
              switch (settings.name){
                case '/': page = UsersListPage();break;
                case '/channel': 
                page = ChannelPage();
                break;
    
              }
              return CupertinoPageRoute(builder: (context) => page, 
                    settings:settings.arguments == null ? passedSettings:settings);
            },
          ),
    );
  }
}

class UsersListPage extends StatefulWidget {
  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  // List<User> _usersList = [];
  // bool _loadingData = true;
  ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: StreamChannelListView(
  //       filter: {
  //         'members': {
  //           '\$in': [StreamChat.of(context).user.id],
  //         }
  //       },
  //       sort: [SortOption('last_message_at')],
  //       pagination: PaginationParams(
  //         limit: 20,
  //       ),
  //       channelWidget: ChannelPage(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Logo(color: AppColor.primary),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context, rootNavigator: true).pop(),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: AppBorderRadius.all_20),
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColor.white,
                    size: 30,
                  )),
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
      bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
      body: SafeArea(
          // ignore: deprecated_member_use
          child: ChannelsBloc(
            // ignore: deprecated_member_use
            child: ChannelListView(
              padding: EdgeInsets.all(16),
              filter: StreamChat.of(context).currentUser != null ? Filter.in_('members',[StreamChat.of(context).currentUser.id]):null,
              sort: const [SortOption('last_message_at')],
              limit: 20,
              onChannelTap: (Channel channel, Widget channelWidget){
                Navigator.of(context).pushNamed('/channel', arguments: channel);
              },
            ),
          ),
        ),
    );
  }

  // _fetchUsers() async {
  //   setState(() {
  //     _loadingData = true;
  //   });

  //   StreamChat.of(context).client.queryUsers(
  //       filter: Filter.notEqual('id', StreamChat.of(context).currentUser.id),
  //       sort: [SortOption('last_message_at')]).then((value) {
  //     setState(() {
  //       if (value.users.length > 0) {
  //         _usersList = value.users.where((element) {
  //           return element.id != StreamChat.of(context).currentUser.id;
  //         }).toList();
  //       }
  //       _loadingData = false;
  //     });
  //   }).catchError((error) {
  //     setState(() {
  //       _loadingData = false;
  //     });
  //     print(error);
  //     // Could not fetch users
  //   });
  // }

}


Future<StreamChatClient> getChatClient() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    StreamChatClient client;
    String userID = prefs.getString('name');
    Map<String, String> body = {
      'userId': userID
    };
    NetworkHandler nw = NetworkHandler();
    var tokenResponse = await nw.post(
        'streamClient/token', body);
    var userToken = jsonDecode(
        tokenResponse.body)['token'];
    client = StreamChatClient('pz93j7x2ygtm', logLevel: Level.INFO);
    print('dsds');
    await client.connectUser(User(id: userID), userToken);
    return client;
  }
  Future<Channel> navigateToChannel(StreamChatClient client , String currUserId, String userId) async {

    Channel channel;
    await client.channel("messaging", extraData: {
          "members": [currUserId, userId]}).create().then((response) {
          channel = Channel.fromState(client, response);
          channel.watch();
        })
        .catchError((error) {
          print(error);
        });
    return channel;
  }
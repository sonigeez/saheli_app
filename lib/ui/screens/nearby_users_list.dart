import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/model/nearme_user.dart';
import 'package:saheli_app/router/app_router.gr.dart';
import 'package:saheli_app/services/location_services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class NearbyUsersList extends StatefulWidget {
  const NearbyUsersList({super.key});

  @override
  State<NearbyUsersList> createState() => _NearbyUsersListState();
}

class _NearbyUsersListState extends State<NearbyUsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      body: FutureBuilder(
        future: LocationServices.getNearMe(),
        builder: (context, AsyncSnapshot<List<NearmeUser>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error while getting results"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return UserWidget(user: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
  });
  final NearmeUser user;

  Future<void> _createChannel(BuildContext context) async {
    final u = User(id: user.id, name: user.firstname);
    var c = context.streamChatClient.channel("messaging", extraData: {
      "members": [
        context.currentUser!.id,
        u.id,
      ],
    });
    await c.watch();
    // ignore: use_build_context_synchronously
    context.pushRoute(ChatScreenRoute(channel: c));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _createChannel(context);
      },
      // child: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   margin: const EdgeInsets.all(8),
      //   height: 100,
      //   width: double.infinity,
      //   padding: const EdgeInsets.all(8),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Text(
      //         user.firstname + user.lastname,
      //         maxLines: 1,
      //         overflow: TextOverflow.ellipsis,
      //         style: Theme.of(context).textTheme.bodyMedium,
      //       ),
      //       // short note
      //       Text(
      //         user.shortDesc,
      //         maxLines: 3,
      //         overflow: TextOverflow.ellipsis,
      //         style: Theme.of(context).textTheme.bodySmall,
      //       ),
      //       // distance
      //       Text(
      //         "Distance: ${user.distance} Km",
      //         style: Theme.of(context).textTheme.bodySmall,
      //       ),
      //     ],
      //   ),
      // ),
      child: Column(
        children: [
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            ),
            title: Text(
              user.firstname + user.lastname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              user.shortDesc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              "Distance: ${user.distance.substring(0, 4)} Km",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

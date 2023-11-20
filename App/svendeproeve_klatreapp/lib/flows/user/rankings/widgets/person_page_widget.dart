import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/reusable_graph_widget.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class PersonPageWidget extends StatefulWidget {
  final String email;
  final String userUID;
  final bool following;
  const PersonPageWidget(
      {super.key,
      required this.email,
      required this.userUID,
      required this.following});

  @override
  State<PersonPageWidget> createState() => _PersonPageWidgetState(
      email: email, userUID: userUID, following: following);
}

class _PersonPageWidgetState extends State<PersonPageWidget> {
  final String email;
  final String userUID;
  bool following;
  final User user = FirebaseAuth.instance.currentUser!;
  final APIService _apiService = APIService();

  _PersonPageWidgetState(
      {required this.email, required this.userUID, required this.following});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(flex: 2, child: _TopPortionWidget()),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userUID != user.uid
                        ? FloatingActionButton.extended(
                            onPressed: () async {
                              var response = following == false
                                  ? await _apiService.updateFollow(
                                      user.uid, userUID)
                                  : await _apiService.removeFollow(
                                      user.uid, userUID);
                              setState(() {
                                following = response;
                              });
                            },
                            heroTag: following == false ? "follow" : "unfollow",
                            elevation: 0,
                            label: Text(
                                following == false ? "Follow" : "Unfollow"),
                            icon: const Icon(Icons.person_add_alt_1),
                          )
                        : Container(),
                    const SizedBox(width: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      heroTag: 'back',
                      elevation: 0,
                      backgroundColor: Colors.red,
                      label: const Text("Back"),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Reusable_Graph_Widget(
                  userUID: userUID,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ]),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.brown[50],
  //       appBar: reusableAppBar(),
  //       drawer: const Sidebar(),
  //       body: Column(
  //         children: [
  //           const Text("Person Page"),
  //           Text(email),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text("Back"))
  //         ],
  //       ));
  // }
}

Uint8List bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAAsTAAALEwEAmpwYAAAFa0lEQVR4nO2dW4hVVRjHf83UjN3Q0smIMtIouknEYI0FBvkqET4EJsUQNNjtocJqzB6MyBIKg+imwlj0UnYRukhBQQg+BF3MLqSFkpXJOJVWM91WLFsHhq9vn2k6+7L2Wd8PFohnzv7++7/22Wvt9a21NhiGYRiGYRhGJzAfWAFsAnYAB4DfQvH//jh8Ngj0weHvGDlzOrAG2Au4SRb/nYeAWVYrrTMTWBeuftdi8cd4Cuixivl/XAuM5FARsgwDS61S/jtdwIYmhvp2YgjoB3qBGcBRofSE//OfbQx/m3Wcp8N3jCYcC2zJMPBDYAnQPQkH/d9eA2zPOOYbIaaR8cvYopj2AzAAdLTgmu9pLQN+zKgU+6UobFDM+gCYnePleybwUcbtyxANuBPlXWBqAS5NA7Yq8fytzQhd2wPKL2Nqge74jsCXSu/LusThOUO2GXNKuFQvAA6K2E+QOKcBY8KUG0qMf5Py8OhHBZJljdK17SgxfmcY+xqvYTWJ0qmMTS2pQMdSoeHrki+KaJivPIF3V6BjSmi3xmu5mARZIUwYqlDLs0LLXSTIi8KE/gq1XC+0vECC7BAm9FaoZZ7Q4se+kmNYmDCjQi09Qst+EkQ+f3RVqKVbaBklQeRYUtXEpofUDXCR6SF1A1xkekjdABeZHlI3wEWmh9QNcJHpIXUDXGR6SN0AF5keUjfARaaH1A1wkekhdQNcZHpI3QAXmZ7SGRUGTKlQy9FCyy8kyD5hwswKtZwitHxDgmyPKI/dJ7T46abJ8ZwwYVmFWm4WWnyOPTmWCxOer1DLJqHlDhJkrjDhEHBMBTqOC434eC1+mmmS7BJG3BjB7WonCTMozNhVcm69S5kFn+ScrAYnKDPQB0uMv1LE/hmYTuLcpzyUzS0h7oXAryL2qhLiRo9vyHcrt67pBcb0c8C+EjF3V9SpiJLLgT+EQe8XtKLppLDsYXysP4GFBcSqNSuVAb7PgPNyjHE+8LkS554cY7QNRwBPKmYdCsuiW2UgNNpOWcbmYxsKHcqaw7yGw7Vjrkt1cc5kubuECvExjBYMbJXkE1CxGehSzwi2irMKiQtnFRIXziokLpxVSFw4q5C4cFYhceGsQuLhCmXbjVaRO5xelsMxk9iQ5hYlcbQ5h2O/Jo75U9jJzgYWFfwA3yIlT9HIVfiJbK2yAPhLOf7W8JkRMnQDIe/hlOINvC1Hp+7NiOPLe2Grpio3MKiMk0MufX8Tg0aAqwqIfV1GXqRR9oaR4CQmO/js33pl5ru8RQ0Bpxao4yzg5SYaGjNQHgfOpg3x+erXM+7hjTIWKqKMGScNLgVeChdBli6v+dV2ybn7ruU7E1yJfrfptWFDzKqYHfZalDvLybItdD5qxznAWxOc3M7QxfVza2OauLcc2DOB9rfrMv/X95oemOB9H76buTjyXPaRwNXhF5F1Hr8DDwPHEyl+is0nTU7gFeAS6kdf6ABktX9fABcRGf1NupJvhi306k5veJOCdo6jYRZ9FNzZpD/vhybajUXKjPlGeTC2idKNsj7me2tObeVjGee+tqrxsVsVMQcTe7/T4oyucplLKg4zT9nEciSnQcC64Zc1fK+MNiwss6++R8lXRNfTKJFzlXX335b1PpJHlaGFK8sIXMMlFX4srFBmKQ99/uHI+IfVysPjGZT4vg/foJ1YZMCaMU15fdMjRaZXvxPB7i8qWI1ZJTzaF4ZicmeB0r3zwyXGvxt46VMhKWKZ/vRLwwwdmZL23uXOZhHkmSKCtAkblYHV3PlUBMlz8kG7cbvwyr8rJXeKeJV2KmW4iArJ4yXzqZaxIiqk6pNyNS9WIbR5hRiGYRiGYRiGYZADfwPiUpbSrzVklwAAAABJRU5ErkJggg==');

class _TopPortionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: MemoryImage(bytes)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

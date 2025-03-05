import 'package:flutter/material.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({
    super.key,
    this.hasInternet = true,
    this.isGuest = true,
  });

  final bool hasInternet;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return isGuest
        ? Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Você está como convidado",
                      style: TextStyle(fontSize: 24, color: Colors.black45),
                    ),
                    Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {},
                    child: const Text("Sair de convidado"),
                  ),
                ),
              )
            ],
          )
        : const Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Você está offline",
                        style: TextStyle(fontSize: 24, color: Colors.black45),
                      ),
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4_rounded,
                        size: 70,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

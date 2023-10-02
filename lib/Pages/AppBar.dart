//make a AppBar that I can call to other pages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      title: const Text(
        "Tableau de bord",
        style: TextStyle(
          fontFamily: "futura",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 27 / 20,
        ),
      ),
      backgroundColor: Colors.black,
      leadingWidth: 100,
      leading: IconButton(
        icon: Image.asset("assets/images/logo.png"),
        onPressed: () {},
      ),
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 25, bottom: 12),
            child: PopupMenuButton(
                position: PopupMenuPosition.under,
                child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/champion.png",
                      ),
                    )),
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      value: 'Paramètres',
                      child: Text("Paramètres",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: "Futura",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
                            height: 19 / 14,
                          )),
                    ),
                    PopupMenuItem(
                      value: 'Statistiques',
                      child: Text("Statistiques",
                          style: TextStyle(
                            fontFamily: "Futura",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
                            height: 19 / 14,
                          )),
                    ),
                    PopupMenuItem(
                      value: 'retour',
                      child: Text("Déconnexion",
                          style: TextStyle(
                            fontFamily: "Futura",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
                            height: 19 / 14,
                          )),
                    )
                  ];
                },
                onSelected: (value) {
                  if (value == 'retour') {
                    FirebaseAuth.instance.signOut();
                  }
                }))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}


import 'package:test_fire_base/main.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController IDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(200, 140)),
              child: Image.asset("assets/images/logo.png"),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: const Text(
                          'ID Utilisateur',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'futura',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 20 / 15,
                          ),
                        ),
                      ),
                      Container(
                        width: 215,
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                            //only digit accepted
                            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            //keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontFamily: 'futura',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '21052002',
                            ),
                            controller: IDController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mail';
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: const Text(
                          'Mot de passe',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'futura',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 20 / 15,
                          ),
                        ),
                      ),
                      Container(
                        width: 215,
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: TextFormField(
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                              fontFamily: 'futura',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              constraints: BoxConstraints(minHeight: 20),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              hintText: 'elieLePlusBo',
                              filled: true,
                              fillColor: Colors.white,
                            )),
                      ),
                    ],
                  )),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.only(left: 30, right: 30)),
              onPressed: signIn,
              child: const Text(
                'Se connecter',
                style: TextStyle(
                  fontFamily: 'Futura',
                ),
              ),
            ),
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {},
            child: const Text('Se connecter en invité',
                style: TextStyle(
                  fontFamily: 'Futura',
                  decoration: TextDecoration.underline,
                )),
          ),
        ));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: IDController.text, password: passwordController.text);
    } catch (e) {
      print(e);
    }
  }
}

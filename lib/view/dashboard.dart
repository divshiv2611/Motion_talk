import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controller/translate.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  TranslaterController controller = Get.find<TranslaterController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  alignment: Alignment.bottomCenter,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xff006491),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Motion Talk',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Text/Speech to ISL',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(.1),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.chat,
                                size: 28,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(.1),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.logout,
                                size: 28,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // FirebaseAuth.instance.signOut().then((value) {
                                //   print("Signed Out");
                                //   Navigator.pushNamed(context, 'login');
                                //   Fluttertoast.showToast(msg: 'User logged out successfully');
                                // });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 8, top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * .025,
                              ),
                              Card(
                                child: TextFormField(
                                  controller: controller.textt,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                    border: InputBorder.none,
                                  ),
                                  onFieldSubmitted: (value) {
                                    controller.WrittenMessage();
                                  },
                                ),
                              ),
                              Text(
                                "Type above or press the mic and start speaking",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .25,
                        child: Obx(() => AvatarGlow(
                          endRadius: 45,
                          animate:
                          controller.isListerning.value == 0 ? false : true,
                          showTwoGlows: true,
                          repeatPauseDuration: Duration(milliseconds: 100),
                          glowColor: Colors.deepPurple.shade300,
                          duration: Duration(milliseconds: 2000),
                          child: FloatingActionButton.small(
                            shape: CircleBorder(),
                            onPressed: () {},
                            child: GestureDetector(
                              onTapDown: (details) {
                                controller.ListernToUser();
                              },
                              onTapUp: (details) {
                                controller.stopListerning();
                              },
                              child: CircleAvatar(
                                child: Icon(
                                  controller.isListerning.value == 1
                                      ? Icons.mic
                                      : Icons.mic_none,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Container(
                    height: size.height * .65,
                    child: SingleChildScrollView(
                      child: GetBuilder<TranslaterController>(
                        builder: (Tc) {
                          return Wrap(
                            spacing: 0,
                            runSpacing: 8,
                            children: Tc.showsigns.map((sign) {
                              return Image.asset(
                                sign.values.first,
                                height: 100,
                                width: 100,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ))
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.WrittenMessage();
        },
        child: Icon(Icons.translate),
      ),
    );
  }
}

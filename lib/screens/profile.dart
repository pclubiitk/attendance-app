import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var bannerHeight = height / 4 - height / 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PROFILE"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF407BFE),
                Color.fromARGB(255, 123, 160, 253),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          // alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(stops: [
                  0.3,
                  0.98
                ], colors: [
                  Color(0xFF407BFE),
                  Color.fromARGB(255, 123, 160, 253)
                ])),
              ),
            ),

            // Positioned(
            //     top: 0,
            //     left: 10,
            //     child: CircleAvatar(
            //       radius: 21,
            //       backgroundColor: Colors.white,
            //       child: CircleAvatar(
            //         radius: 20,
            //         backgroundColor: Color(0xFF407BFE),
            //         child: IconButton(
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             color: Colors.white,
            //             icon: Icon(LineAwesomeIcons.arrow_left_solid)),
            //       ),
            //     )),

            // Positioned(
            //     top: bannerHeight / 2.6,
            //     child: Text("Profile",
            //         style: GoogleFonts.lora(
            //             textStyle: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 26,
            //                 fontWeight: FontWeight.w700)))),

            // Container(
            //   width: double.infinity,
            //   height: bannerHeight,
            //   decoration: const BoxDecoration(
            //     color: Color.fromARGB(115, 0, 108, 255),
            //     // borderRadius: BorderRadius.only(
            //     //   bottomLeft: Radius.circular(100),
            //     //   bottomRight: Radius.circular(100),
            //     // ),
            //   ),
            //   // child: Image.asset(
            //   //   "assets/Police car-rafiki.png",
            //   //   fit: BoxFit.cover,
            //   // ),

            // ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: .1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(137, 117, 117, 117),
                          spreadRadius: 1,
                          blurRadius: 15)
                    ]),
                child: Column(
                  children: [
                    SizedBox(height: bannerHeight / 2.5),
                    Positioned(
                      top: bannerHeight * 0.8,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 7, 114, 254),
                        radius: bannerHeight / 2.5 + 3,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: bannerHeight / 2.5,
                          backgroundImage: const AssetImage("assets/profileimg.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 38),
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   // border: Border.all(
                        //   //   width: .1,
                        //   //   color:Colors.grey
                        //   //   ),
                        //   borderRadius: BorderRadius.circular(10),
                        //   // boxShadow: [
                        //   //   BoxShadow(
                        //   //       color: const Color.fromARGB(68, 117, 117, 117),
                        //   //       spreadRadius: 1,
                        //   //       blurRadius: 15)
                        //   // ]
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align children to the start
                          children: [
                            const Text("Employee ID",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    letterSpacing: 1.5)),
                            // const SizedBox(
                            //   height: 3,
                            // ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.black12,
                                // ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'SI-1998-9456UP',
                                    hintStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    )
                                    // contentPadding: EdgeInsets.all(),
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  letterSpacing: 1.5),
                            ),
                            // const SizedBox(
                            //   height: 6,
                            // ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.black12,
                                // ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'RAM KRISHNA',
                                    hintStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    )
                                    // contentPadding: EdgeInsets.all(10),
                                    ),
                              ),
                            ),
                            // const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Age",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              letterSpacing: 1.5),
                                        ),
                                        // const SizedBox(
                                        //   height: 6,
                                        // ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            // border: Border.all(
                                            //   color: Colors.black12,
                                            // ),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: const TextField(
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: '45',
                                                hintStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                )
                                                // contentPadding:
                                                //     EdgeInsets.all(10),
                                                ),
                                          ),
                                        ),
                                      ]),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Position",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              letterSpacing: 1.5),
                                        ),
                                        // const SizedBox(
                                        //   height: 6,
                                        // ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            // border: Border.all(
                                            //   color: Colors.black12,
                                            // ),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: const TextField(
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'SUB INSPECTOR',
                                                hintStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                )
                                                // contentPadding:
                                                //     EdgeInsets.all(10),
                                                ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: bannerHeight / 8),
      ),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.75;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height / 2);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

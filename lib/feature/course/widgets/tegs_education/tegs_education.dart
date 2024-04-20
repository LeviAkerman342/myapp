import 'package:flutter/material.dart';

class TegsEducation extends StatefulWidget {
  const TegsEducation({super.key});

  @override
  State<StatefulWidget> createState() => _TegsEducation();
}

class _TegsEducation extends State<TegsEducation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: 343,
        height: 71,
        child: Stack(
          children: [
            Positioned(
              left: 198,
              top: 38,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Java',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0x79ffffff), fontFamily: 'SFProDisplay-Medium', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              width: 99,
              top: 38,
              child: Container(
                width: 99,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Game dev',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0x79ffffff), fontFamily: 'SFProDisplay-Medium', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 90,
              width: 93,
              top: 0,
              child: Container(
                width: 93,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Python',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0x79ffffff), fontFamily: 'SFProDisplay-Medium', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 104,
              width: 89,
              top: 38,
              child: Container(
                width: 89,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Coding',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0x79ffffff), fontFamily: 'SFProDisplay-Medium', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 188,
              width: 117,
              top: 0,
              child: Container(
                width: 117,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Marketing',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0x79ffffff), fontFamily: 'SFProDisplay-Medium', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              width: 85,
              top: 0,
              child: Container(
                width: 85,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6c6c6c), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'UX/UI',
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14, color: Color(0xff414141), fontFamily: 'SFProDisplay-Semibold', fontWeight: FontWeight.normal),
                            maxLines: 9999,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

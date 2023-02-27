import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gigivet22firebase/widgets/widgets.dart';



class Test1Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Color(0xff392850),
      child: Column(
          
          children: <Widget>[
            SizedBox(
              height: 110,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Johny s Family",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white, //white
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Home",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Color(0xffa29aac),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: Image.asset(
                      "assets/notification.png",
                      width: 24,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
           GridDashboard()
          ],
        ),
    );


    
    
    // Center(
    //     child: Text('Hola Mundo'),
    //  );
  }
}
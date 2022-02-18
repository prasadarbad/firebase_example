import 'package:flutter/material.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 400,
              child: Image(image: AssetImage("assets/images/farrmer.png")
                ,
              fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 15.0),
            RichText(text: TextSpan(
              text: 'Welcome To ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Kheti app', style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)

                ),
              ]
            ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               ElevatedButton(

                 onPressed: (){} , child: Text('Login',style: TextStyle(
                 fontSize: 20, fontWeight: FontWeight.bold,
                 color: Colors.white,
               ),

               ),
                   style: ButtonStyle(
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                           RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10.0),
                               side: BorderSide(color: Colors.orange)
                           ),
                       ),
                   ),
               ),
                ElevatedButton(onPressed: (){} , child: Text('Register',style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.orange)
                        ),
                      ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

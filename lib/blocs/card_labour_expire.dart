import 'package:flutter/material.dart';
import 'package:rnb/expire_popup.dart';

class CardLabourExp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) => ExpirePop());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 0,child: CircleAvatar(radius:40,backgroundImage: AssetImage('images/person.png',),)),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Radheshyam Singh', textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                          ),
                            maxLines: 2,),
                          Text('Meghalaya', textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                          ),
                            maxLines: 2,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: new BoxDecoration(
                          color: Color(0xff282121),
                          borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          )
                      ),
                      child: Center(
                        child: Text('DUE\n25 june', textAlign: TextAlign.left, style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.350000023841858
                        ),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

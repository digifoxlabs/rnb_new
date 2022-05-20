import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ExpirePop extends StatefulWidget {
  const ExpirePop({Key? key}) : super(key: key);

  @override
  _ExpirePopState createState() => _ExpirePopState();
}

class _ExpirePopState extends State<ExpirePop> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }
}

contentBox(context){
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'images/person.png',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Radheshyam Singh',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Place: Meghalaya',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Flexible(
              child: Text('Expering On:', textAlign: TextAlign.left, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  height: 1.0800000190734864
              ),),
            ),
            Flexible(
              child: Text('25 June', textAlign: TextAlign.left, style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.0800000190734864
              ),),
            )
          ],),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            ),onPressed: (){
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 1, 1),
                  maxTime: DateTime(2100, 1, 1), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.en);

            }, child: Text('UPDATE', textAlign: TextAlign.center, style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.350000023841858
            ),)),
          ),
          SizedBox(height: 10,),
          Row(children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TextButton(style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('CONFIRM', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.350000023841858
                ),)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TextButton(style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('CANCEL', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.350000023841858
                ),)),
              ),
            ),
          ],),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );


}

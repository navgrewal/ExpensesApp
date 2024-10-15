import 'package:flutter/material.dart';


class Chartbar extends StatelessWidget {
  var amount;
  String day;
  double pct;
  Chartbar(this.day,this.amount,this.pct);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(children: <Widget>[
      Container(height: 15,child: FittedBox(child: Text("Rs:${amount}"))),
      SizedBox(height: 2,),
      Container(height: constraints.maxHeight *0.7,width: 10,child:Stack(children: <Widget>[
          Container(width: 10, decoration: BoxDecoration(border: Border.all(color:Color(0xffdee6f1),width: 1),color: Color.fromRGBO(220, 220, 220, 1),borderRadius: BorderRadius.circular(5)),),
          FractionallySizedBox(heightFactor: pct,child: Container(height: 100,decoration: BoxDecoration(color:Color(0xff818aab),borderRadius: BorderRadius.circular(5)),),)
        ],),),
      
      SizedBox(height: 2,),
      Text(day)
    ],
      
    );
    });
    
  }
}
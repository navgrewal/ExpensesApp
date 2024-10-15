import 'dart:io';
import 'package:expenses/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './transactions.dart';
import './showTransactions.dart';
void main(){runApp(MyApp());
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(primarySwatch: Colors.blue),
       
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final amountcon=TextEditingController();
  final titlecon=TextEditingController();
  
  DateTime selecteddate;
   List<Transactions> trans=[Transactions(DateTime.now(),"Shoes",1000,DateTime.now()),Transactions(DateTime.now(),"Shirt",1000,DateTime.now())];
  List<Transactions> get recenttrans{
    return trans.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }
  void deletetrans(String id){
    setState(() {
    trans.removeWhere((tx){return tx.id==id;});  
    });
    
  }
  addTx(){
    var enteredtitle=titlecon.text;
    var enteredprice=int.parse(amountcon.text);
    
    if (enteredtitle.isEmpty || enteredprice <= 0 || selecteddate==null ){
      return;
    }
    setState(() {
      trans.add(Transactions(DateTime.now(), enteredtitle,enteredprice, selecteddate));
      amountcon.clear();
      titlecon.clear();
    });
    Navigator.of(context).pop();
    selecteddate=null;
    print(trans);
  }
  datepicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((sdate){
      setState(() {
        selecteddate=sdate;});
      }); 
  }
  void showAdd(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_){
      return SingleChildScrollView(
              child: Container(color: Colors.grey,padding: EdgeInsets.only(top:3,left: 3,right: 3,bottom: MediaQuery.of(context).viewInsets.bottom+3),child: Column(children: <Widget>[
              TextField(controller: titlecon,decoration: InputDecoration(labelText:"Title")),
              TextField(controller: amountcon,decoration: InputDecoration(labelText:"Amount"),keyboardType: TextInputType.number, onSubmitted: (val)=>addTx(),)
              ,Container(height:30,child: Row(children: <Widget>[
                Expanded(child: Text(selecteddate==null ? "No Date Choosen" :"Choosen Date:${DateFormat.yMd().format(selecteddate)}")),FlatButton(onPressed:datepicker, child: Text("Choose Date",style:TextStyle(color: Colors.blue) ,))
              ],),)
              ,Container(alignment:AlignmentDirectional(1, 0),child: RaisedButton(color: Colors.blue,textColor: Colors.white,child: Text("Add"),onPressed:addTx ))
            ],),),
      );
  });
  }
  
  @override
  Widget build(BuildContext context) {
    
    final PreferredSizeWidget appBar=Platform.isIOS ? CupertinoNavigationBar(middle: Text("Expenses App"),trailing: GestureDetector(onTap:(){showAdd(context);} ,child: Icon(CupertinoIcons.add),),)  
    :AppBar(backgroundColor: Color.fromRGBO(90, 90, 90, 1)
    ,title:Text("Expenses App"),actions: <Widget>[IconButton(icon: Icon(Icons.add),onPressed: (){showAdd(context);},)],);
    final pagebody= SafeArea(child:Column(children: <Widget>[
          Container(height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.35,child: Chart(recenttrans)),
          
          Container(height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.65,child: ShowTransaction(trans,deletetrans)),
        ],));
    return Platform.isIOS ? CupertinoPageScaffold(child: pagebody,navigationBar: appBar,backgroundColor: Colors.grey,) :Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1),//Color(0xfff4f9fd),
      appBar:appBar,
      body:pagebody,
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.blueGrey,child:Icon(Icons.add),onPressed: (){showAdd(context);}),
    );
  }
}
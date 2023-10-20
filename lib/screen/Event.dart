import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/screen/Eventsave.dart';
import 'package:untitled/utils/constadate.dart';

import '../localstore/localstore.dart';

class Eventspage extends StatefulWidget {
  const Eventspage({Key? key}) : super(key: key);

  @override
  State<Eventspage> createState() => _EventspageState();
}

class _EventspageState extends State<Eventspage> {
  var selectedyear='2016';
  var selectedmonth='jan';
  // var selectedday='1';
  List<Map<String, dynamic>> _journals = [];
  Timer? timer;



  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) =>  _refreshJournals());

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
          centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet<void>(

                            // isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context)
                            {
                              // Returning SizedBox instead of a Container
                              return Container(

                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                    children: [
                                      Container(

                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(child: Text('Year')),
                                        )),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          // scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:  year.length,
                                            itemBuilder: (context,index){
                                              return InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    selectedyear=year[index];
                                                    print(selectedyear);
                                                    print(year[index]);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(

                                                      child: Center(child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Center(child: Text(year[index].toString(),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 19),)),
                                                      )),
                                                    ),
                                                    Divider(

                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),]
                                ),
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(selectedyear.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 19),)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet<void>(

                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context)
                            {
                              // Returning SizedBox instead of a Container
                              return Container(

                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                    children: [
                                      Container(

                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(child: Text('Month')),
                                        )),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:  month.length,
                                            itemBuilder: (context,index){
                                              return InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    selectedmonth=month[index];
                                                    print(selectedmonth);
                                                    print(month[index]);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(

                                                      child: Center(child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Center(child: Text(month[index].toString(),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 19),)),
                                                      )),
                                                    ),
                                                    Divider(

                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),]
                                ),
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(selectedmonth.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 19),)),
                        ),
                      ),
                    ),
                  ),

                ]
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              
                shrinkWrap: true,

                itemCount:30,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Eventdetails(year:selectedyear,month:selectedmonth,date:date[index])));



                      },
                      child: Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(date[index].toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),),
                                  Text(selectedmonth,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19)),

                                ],
                              ),
                            ),
                            // Text("|") ,
                            Divider(),
                            SizedBox(
                              width: 40,
                            ),
                            for(var i=0;i<_journals.length;i++)...[
                              "${date[index].toString()}${selectedmonth.toString()}${selectedyear.toString()}"==_journals[i]['date']?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Align(
                                      alignment:Alignment.topLeft,
                                      child: Text(_journals[i]['datetime']+" "+_journals[i]['date'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19))),
                                  Align(
                                      alignment:Alignment.topLeft,
                                      child: Text(_journals[i]['title'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16))),
                                ],
                              ):Text('')
                            ],

                            Divider()
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

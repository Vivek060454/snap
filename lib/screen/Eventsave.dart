import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../localstore/localstore.dart';

class Eventdetails extends StatefulWidget {
  final year;
  final month;
     final date;
   Eventdetails({Key? key,  this.year, this.month, this.date}) : super(key: key);

  @override
  State<Eventdetails> createState() => _EventdetailsState();
}

class _EventdetailsState extends State<Eventdetails> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController datetime = TextEditingController();
    final TextEditingController title = TextEditingController();
    final TextEditingController description = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    List<Map<String, dynamic>> _journals1 = [];

    bool _isLooading1 = true;

    List<Map<String, dynamic>> _journals = [];


    void _refreshJournals() async {
      final data = await SQLHelper.getItems();
      setState(() {
        _journals = data;
        _isLooading1 = false;
      });
    }

    Future<void> _addItem() async {
      await SQLHelper.createItem(
        widget.date.toString()+widget.month.toString()+widget.year.toString(),
          title.text,
      description.text,
      datetime.text
      );
      _refreshJournals();
    }



    @override
    void initState() {
      super.initState();
      _refreshJournals();
      _addItem();
    }

    void _showForm(int? id) async {
      if (id != null) {
        final existingJournal =
        _journals.firstWhere((element) => element['id'] == id);
       //  widget.date = existingJournal['date'];
       //  title.text = existingJournal['title'];
       // description.text = existingJournal['description'];
       // datetime.text= existingJournal['datetime'];

      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },

            child: Center(child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('Back',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
            ))),
      ),
      bottomNavigationBar:InkWell(
        onTap: (){
          if(title.text==''||datetime.text==''||description==""){
Fluttertoast.showToast(msg: 'Please enter details');
          }
          else{
            _addItem();
            Navigator.pop(context);
          }

        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('SAVE',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 19),)),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 0,left: 8,right:8 ),
                      child: Center(child: Text('Date & Time',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: datetime,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          datetime.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.fromLTRB(
                                20, 15, 20, 15),
                            hintText: "HH:MM",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                        validator: (datetime) {
                          if (datetime!.isEmpty) {
                            return ("Please enter date");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 0,left: 8,right:8 ),
                      child: Center(child: Text('${widget.date}-${widget.month}-${widget.year}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),)),
                    ),
                  ]
                )
              ],
            ),
            Table(
columnWidths: {
  0:FlexColumnWidth(2),
  1:FlexColumnWidth(6)
},
              children: [
                TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 0,left: 8,right:8 ),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Title',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: title,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            title.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.fromLTRB(
                                  20, 15, 20, 15),
                              // hintText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          validator: (title) {
                            if (title!.isEmpty) {
                              return ("Please enter date");
                            }
                          },
                        ),
                      ),

                    ]
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 0,left: 8,right:8 ),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Description',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,),)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: false,
                maxLines: 5,
                controller: description,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  description.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.fromLTRB(
                        20, 15, 20, 15),
                    hintText: "HH:MM",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (description) {
                  if (description!.isEmpty) {
                    return ("Please enter date");
                  }
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}

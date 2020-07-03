import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutshell/bottomNav.dart';

class About extends StatefulWidget
{
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        bottomNavigationBar: bottomBar(context, 2),
        appBar: AppBar(
          title: Text("About US",style: TextStyle(color: Colors.black),),
          backgroundColor:Colors.orange[300],
          leading: new IconButton(
          icon: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      tooltip: 'back',
                      onPressed: () {
                        Navigator.pushNamed(context,"/account");
                    
          },
        ),
        ),
        body:WillPopScope(
          onWillPop: (){
            Navigator.pushNamed(context, '/account');
          },
        child: Center(child:  SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          height:MediaQuery.of(context).size.height*1,
          child:  ListView(
            children: <Widget>[
              Text("\nWe make General Knowledge exciting!\nNutshell brings a new, innovative approach to general knowledge for school students. All of us appreciate the importance of GK in our lives, but usually students are starved of quality content which they can be excited about! \nNutshell Paperbacks provide students with engaging, relatable general knowledge content through bi-monthly (once every 2 months) periodicals that not only enhance their knowledge but also makes them curious to learn more! \nLet's see what makes Nutshell a great learning companion.\nNutshell brings refreshing activities and topics As new Nutshell Paperbacks are created every two months, we ensure that each of them have new, creative topics which pique students' curiosity. \nInnovative games, stories, detailed answers make it a captivating experience We make learning fun by including hands-on activities and games which students can play with each other while they learn exciting new information. \nNutshell keeps students updated about current and important events We present current affairs in a manner that is relevant to students and helps them understand things better.\nEvery two months, a beautiful paperback becomes a student's prized possession The paperbacks are bright, colourful and beautifully designed. The quality of each Nutshell shows that we put effort into creating each one of them.\nWhy do students need general knowledge?\nYou might wonder, Well, I have the internet! I can find any information I want with a few clicks. Then, why do I need to brush up my GK? Here's why!\nHelps in getting better grades! We aren't saying it; research supports it.\nMotivates you to read more and hence, improves reading skills.\nGK is always beneficial in life. It helps students excel at college, job interviews and competitive exams"),
            ]
        )// child:Wi       // Text("\n\n\n No Abouts till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ,),
       )
      
        ),
        
    
    );
  }
}
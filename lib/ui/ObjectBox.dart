import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ObjectBox extends StatelessWidget {

  final String assetPath;
  final String title;

  const ObjectBox({Key? key, required  this.assetPath,required  this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            child: Card(
              
              elevation: 10,
              //color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              
              child: InkWell(
              onTap: () {
                
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
               // width: 260,
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Container(
                       height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.cover,image: AssetImage(assetPath), ),
                         borderRadius: BorderRadius.circular(15),
                        ),

                        child:  Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                          padding: const EdgeInsets.only(left:20.0,bottom: 15),
                          child: AutoSizeText(title,maxLines: 1,minFontSize: 16,overflow: TextOverflow.ellipsis,
                          style:  TextStyle(color: Colors.white,fontSize: 19,fontFamily: 'Sfpro',fontWeight: FontWeight.bold),),
                                              ),
                        ),
                        ),
                     
                      
                  ],
                ),
              ),
            ),
          )
         ) ;
  }
}
/*




import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ObjectBox extends StatelessWidget {

  final String assetPath;
  final String title;

  ObjectBox({Key? key, required  this.assetPath,required  this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20,right: 10,bottom: 20),
          child: Card(
            elevation: 10,
            color: Colors.redAccent.withOpacity(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              width: 220,
              // height: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.contain,image: AssetImage(assetPath)),
                        ),),),
                    Padding(
                      padding: const EdgeInsets.only(left:11.0,bottom: 10),
                      child: AutoSizeText(title,maxLines: 1,minFontSize: 16,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                    ),
                   
                ],
              ),
            ),
          )
        );
  }
}*/
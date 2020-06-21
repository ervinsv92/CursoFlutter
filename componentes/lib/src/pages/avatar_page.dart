import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  
  static final pageName = 'avatar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: <Widget>[

          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://ep01.epimg.net/elpais/imagenes/2019/07/10/mamas_papas/1562754072_613931_1562756504_noticia_normal.jpg'),
              radius: 25.0,
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('ES'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage('https://www.eltiempo.com/files/article_content/uploads/2018/12/20/5c1c33e4dd213.jpeg'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
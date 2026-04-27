import 'package:flutter/material.dart';
class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001F3F),
      appBar: AppBar(
      backgroundColor: Color(0xFF2E5B8B),
      title: Center(child: Text('Locais de Missões',style:TextStyle(color:Colors.black )))

      ),
      body: ListView(
        children: [
          Image.network('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%2Fid%2FOIP.h2bP6MInkwUe2reekgKyhAHaEo%3Fpid%3DApi&f=1&ipt=3b4b74f9644ec077f43072bf21429090501c9b371ad23ca5272b7908a941cbda&ipo=images',
          width: 300, height: 250, fit: BoxFit.contain,),
          Text('Floresta das Fadas ',style: TextStyle(fontSize:40 ,color: Colors.white),
          textAlign: TextAlign.center,
          ),
          Image.network('https://i.pinimg.com/originals/0a/8a/83/0a8a83e22587bbe6ec62aab5034f406d.jpg',
          width:200, height: 200, fit: BoxFit.contain,),
          Text('Monte Fenrir',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.network('https://thumbs.dreamstime.com/b/sol-de-ard%C3%AAncia-atrav%C3%A9s-do-deserto-3278743.jpg',
          width:200, height: 300, fit: BoxFit.contain,),
          Text('Deserto solar',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.network('https://pt.quizur.com/_image?href=https%3A%2F%2Fimg.quizur.com%2Ff%2Fimg64e4293cca4308.53145671.png%3FlastEdited%3D1692674367&w=400&h=400&f=webp',
          width:200, height: 300, fit: BoxFit.contain,),
          Text('Ilhas dos Monstro',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.network('https://img.wattpad.com/b67ecfb0ee65d5c3cbf8f80465e3cf952d031891/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f3661613874334b6b6764434758413d3d2d3830333539343734332e313564353936643134373266376430343432323839323433373533392e6a7067',
          width:200, height: 300, fit: BoxFit.contain,),
          Text('BerTonia',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

}

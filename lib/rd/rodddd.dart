import 'package:flutter/material.dart';
class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override

  State<Mapa> createState() => _MapaState();
}
class _MapaState extends State<Mapa> {
  bool floresta = false;
  bool monte = false;
  bool deserto = false;
  bool ilhas = false;
  bool bertonia = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF2E5B8B),
      title: Center(child: Text('Locais de Missões',style:TextStyle(color:Colors.black )))
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz4act6WAt1IBqYVCXoZtB2XWRd8rzMcTwN-HtCNCduQ&s'
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
        children: [
          Image.network('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%2Fid%2FOIP.h2bP6MInkwUe2reekgKyhAHaEo%3Fpid%3DApi&f=1&ipt=3b4b74f9644ec077f43072bf21429090501c9b371ad23ca5272b7908a941cbda&ipo=images',
          width: 300, height: 257, fit: BoxFit.contain,),
          Text('Floresta das Fadas ',style: TextStyle(fontSize:40 ,color: Colors.white),
          textAlign: TextAlign.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {floresta = !floresta;});
                },
                icon: Icon(floresta ? Icons.star : Icons.location_on, size: 40,), color: floresta ? Colors.yellowAccent : Colors.red,
              )
            ],
          ),
          Image.network('https://i.pinimg.com/originals/0a/8a/83/0a8a83e22587bbe6ec62aab5034f406d.jpg',
          width:200, height: 200, fit: BoxFit.contain,),
          Text('Monte Fenrir',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {monte = !monte;});
                },
                icon: Icon(monte ? Icons.star : Icons.location_on, size: 40,), color: monte ? Colors.yellowAccent : Colors.red,
              )
            ],
          ),
          Image.network('https://thumbs.dreamstime.com/b/sol-de-ard%C3%AAncia-atrav%C3%A9s-do-deserto-3278743.jpg',
          width:200, height: 300, fit: BoxFit.contain,),
          Text('Deserto solar',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {deserto = !deserto;});
                },
                icon: Icon(deserto ? Icons.star : Icons.location_on, size: 40,), color: deserto ? Colors.yellowAccent : Colors.red,
              )
            ],
          ),
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsiavzQbBMa7XN4Bq4LXLCV_ZXD0XrzFnq9g&s',
          width:200, height: 340, fit: BoxFit.contain,),
          Text('Ilhas dos Monstro',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {ilhas = !ilhas;});
                },
                icon: Icon(ilhas ? Icons.star : Icons.location_on, size: 40,), color: ilhas ? Colors.yellowAccent : Colors.red,
              )
            ],
          ),
          Image.network('https://img.wattpad.com/b67ecfb0ee65d5c3cbf8f80465e3cf952d031891/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f3661613874334b6b6764434758413d3d2d3830333539343734332e313564353936643134373266376430343432323839323433373533392e6a7067',
          width:200, height: 300, fit: BoxFit.contain,),
          Text('BerTonia',style: TextStyle(fontSize:40 ,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  setState(() {bertonia = !bertonia;});
                },
                icon: Icon(bertonia ? Icons.star : Icons.location_on, size: 40,), color: bertonia ? Colors.yellowAccent : Colors.red,
              )
            ],
          ),
        ],
      ),
      ),
    );
  }
}

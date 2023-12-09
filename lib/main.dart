import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Isometric Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<AnimationController> animationController = [];
  List<Animation<double>> rotation = [];
  List<Animation<double>> rotateY = [];
  List<Animation<double>> rotateX = [];
  List<Animation<double>> scale = [];
  List<Animation<double>> offset = [];
  List<Animation<double>> widht = [];
  List<CardItem> list = [
    CardItem(fromColor: const Color.fromRGBO(55, 49, 44, 1), toColor: const Color.fromRGBO(29, 27, 25, 1)),
    CardItem(fromColor: const Color.fromRGBO(0, 57, 148, 1), toColor: const Color.fromRGBO(64, 44, 152, 1)),
    CardItem(fromColor: const Color.fromRGBO(15, 128, 106, 1), toColor: const Color.fromRGBO(4, 121, 98, 1))
  ].reversed.toList();

  int selected = 4;
  late double height = 0.0;

  @override
  void initState() {
    for (var index = 0; index < list.length; index++) {
      animationController.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 400)));
      rotation.add(Tween<double>(begin: 0.0, end: -.2).animate(animationController[index]));
      rotateY.add(Tween<double>(begin: 0.0, end: 1).animate(animationController[index]));
      rotateX.add(Tween<double>(begin: 0.0, end: 1.4).animate(animationController[index]));
      scale.add(Tween<double>(begin: 1, end: .7).animate(animationController[index]));
      offset.add(Tween<double>(begin: 0, end: -130).animate(animationController[index]));
      widht.add(Tween<double>(begin: 20, end: 0).animate(animationController[index]));
      animationController[index].forward();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height * .75;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 31, 27, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        titleSpacing: 1,
        title: const Row(children: [
          Text('Hello,'),
          Text(
            ' Osmanali',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: const Color.fromRGBO(23, 19, 16, 1), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select your bank card',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Financial Analysis',
                          style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 14),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(color: const Color(0xFF2d2726), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.arrow_outward,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: MediaQuery.of(context).size.height * .74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                clipBehavior: Clip.none,
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'YOUR CARDS',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .69,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (animationController.isNotEmpty)
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: list.length,
                                  reverse: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return AnimatedContainer(
                                      clipBehavior: Clip.none,
                                      duration: const Duration(milliseconds: 300),
                                      height: (selected == index) ? (height / 7) * 4 : (height / 7) * 1.1,
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              selected = (animationController[index].isCompleted) ? index : list.length + 1;
                                            },
                                          );
                                          animationController[index].reverse();
                                          if (selected != index) animationController[index].forward();
                                          for (var i = 0; i < list.length; i++) {
                                            if (selected != i) animationController[i].forward();
                                          }
                                        },
                                        child: AnimatedBuilder(
                                          animation: animationController[index],
                                          builder: (context, child) {
                                            return SingleChildScrollView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              clipBehavior: Clip.none,
                                              child: Transform.translate(
                                                offset: Offset(0, offset[index].value),
                                                child: Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.skewX(0)
                                                    ..setRotationX(rotation[index].value)
                                                    ..rotateY(rotateY[index].value)
                                                    ..rotateX(rotateX[index].value)
                                                    ..scale(scale[index].value),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * widht[index].value,
                                                    height: MediaQuery.of(context).size.height * .42,
                                                    padding: const EdgeInsets.all(20),
                                                    margin: EdgeInsets.only(top: 20, bottom: 20, left: widht[index].value, right: widht[index].value),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(26),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          list[index].fromColor,
                                                          list[index].toColor,
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'AKBANK',
                                                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                                            ),
                                                            SvgPicture.string(
                                                              '<svg xmlns="http://www.w3.org/2000/svg" width="20.003" height="6.13" viewBox="0 0 20.003 6.13"><path id="visa-svgrepo-com" d="M16.539,9.186a4.155,4.155,0,0,0-1.451-.251c-1.6,0-2.73.806-2.738,1.963-.01.85.8,1.329,1.418,1.613.631.292.842.476.84.737,0,.4-.5.577-.969.577a3.423,3.423,0,0,1-1.525-.312l-.2-.093-.227,1.332a5.47,5.47,0,0,0,1.814.313c1.7,0,2.813-.8,2.826-2.032.014-.679-.426-1.192-1.352-1.616-.563-.275-.912-.459-.912-.738,0-.247.3-.511.924-.511A2.95,2.95,0,0,1,16.2,10.4l.15.067.227-1.287-.039.009Zm4.152-.143h-1.25a.811.811,0,0,0-.852.493l-2.4,5.446h1.7l.34-.893,2.076,0c.049.209.2.891.2.891H22l-1.31-5.939Zm-10.642-.05H11.67l-1.014,5.942H9.037l1.012-5.944v0ZM5.934,12.268l.168.825,1.584-4.05H9.4L6.852,14.974H5.139l-1.4-5.022a.339.339,0,0,0-.149-.2A6.948,6.948,0,0,0,2,9.164l.022-.125H4.629a.675.675,0,0,1,.734.5l.57,2.729v0Zm12.757.606.646-1.662c-.008.018.133-.343.215-.566l.111.513.375,1.714H18.691Z" transform="translate(-1.998 -8.935)"/></svg>',
                                                              height: 16,
                                                              color: Colors.white.withOpacity(.6),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'OSMANALİ',
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(.8), fontSize: 24, fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              'MOLLA',
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(.8), fontSize: 24, fontWeight: FontWeight.bold),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '1234',
                                                                  style: TextStyle(
                                                                      color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold, fontSize: 20),
                                                                ),
                                                                Text(
                                                                  '2345',
                                                                  style: TextStyle(
                                                                      color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold, fontSize: 20),
                                                                ),
                                                                Text(
                                                                  '3456',
                                                                  style: TextStyle(
                                                                      color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold, fontSize: 20),
                                                                ),
                                                                Text(
                                                                  '4567',
                                                                  style: TextStyle(
                                                                      color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold, fontSize: 20),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  '02/20',
                                                                  style: TextStyle(
                                                                      color: Colors.white.withOpacity(.8), fontWeight: FontWeight.bold, fontSize: 20),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardItem {
  late Color fromColor;
  late Color toColor;

  CardItem({required this.fromColor, required this.toColor});
}

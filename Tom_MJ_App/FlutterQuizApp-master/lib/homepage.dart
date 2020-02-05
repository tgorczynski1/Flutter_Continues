import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
//this is kind of like a constructor 
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );

    _animation = Tween(begin: 0.0, end: 500.0).animate(_animationController);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }else if (status == AnimationStatus.dismissed){
        _animationController.forward();
      }
    });

    _animationController.forward();
  }
// this is the content of the page
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(
        animation: _animation,
      ),
    );
  }
//data leaks are bad
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _sizeAnim = Tween<double>(begin: 0.0, end: 500.0);
  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.scale(
      scale: _sizeAnim.evaluate(animation),
      child: FlutterLogo(),
    );
  }
}

//TODO: Add a button that navigates you to the "main.dart" page 
// after that we bascially done GG WP Fk ya bud 
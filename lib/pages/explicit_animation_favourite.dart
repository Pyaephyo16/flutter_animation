import 'package:flutter/material.dart';

  const Duration kAnimationDurationForFavouriteIcon = const Duration(milliseconds: 1000);

class ExplicitAnimationFavourite extends StatefulWidget {

  @override
  State<ExplicitAnimationFavourite> createState() => _ExplicitAnimationFavouriteState();
}

class _ExplicitAnimationFavouriteState extends State<ExplicitAnimationFavourite> with TickerProviderStateMixin{

  bool isFavourite = false;

  late AnimationController _controller;
  late Animation<Color?> animationColor;
  late Animation<double> animationRotate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: kAnimationDurationForFavouriteIcon,
      vsync: this,
      );

      animationColor = ColorTween(begin: Colors.white,end: Colors.red).animate(_controller.view);
      animationRotate = Tween<double>(begin: 0,end: 1).animate(_controller.view);


    _controller.addStatusListener((status) {
        isFavourite = (status == AnimationStatus.completed);
    });

  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
      animation: _controller.view,
        builder: (context,_) => RotationTransition(
          turns: animationRotate,
          child: IconButton(
                    onPressed: (){
                     (isFavourite) ? _controller.reverse() : _controller.forward();
                  },
                   icon: Icon(Icons.favorite,size: 32,color: animationColor.value,),
             ),
        ),  
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
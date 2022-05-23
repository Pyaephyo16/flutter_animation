import 'package:fashion_shop/pages/detail_page.dart';
import 'package:fashion_shop/resources/colors.dart';
import 'package:flutter/material.dart';

const Duration kAnimationDurationForDescriptionIcon = const Duration(milliseconds: 1000);

class ExplicitAnimationDescription extends StatefulWidget {

  final Function(bool) resultHideOrShow;

  ExplicitAnimationDescription({
    required this.resultHideOrShow,
  });

  @override
  State<ExplicitAnimationDescription> createState() => _ExplicitAnimationDescriptionState();
}

class _ExplicitAnimationDescriptionState extends State<ExplicitAnimationDescription> with TickerProviderStateMixin{

  bool isHideDescription = false;

  late AnimationController _controller;
  late Animation<double> animationRotate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: kAnimationDurationForDescriptionIcon,
      vsync: this,
      );

      animationRotate = Tween<double>(begin: 0,end: 0.5).animate(_controller.view);

    _controller.addStatusListener((status) {
        isHideDescription = (status == AnimationStatus.completed);
        print("add listener =================> $isHideDescription");
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
                  (isHideDescription) ? widget.resultHideOrShow(false) : widget.resultHideOrShow(true);
                    (isHideDescription) ? _controller.reverse() : _controller.forward();
                  },
                   icon: Icon(Icons.arrow_drop_down,size: 32,color: DETAIL_PAGE_DESCRIPTION_COLOR,),
             ),
        ),  
    );
  }
}
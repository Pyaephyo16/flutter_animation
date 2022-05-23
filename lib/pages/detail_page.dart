import 'package:dots_indicator/dots_indicator.dart';
import 'package:fashion_shop/pages/explicit_animation_description.dart';
import 'package:fashion_shop/pages/explicit_animation_favourite.dart';
import 'package:fashion_shop/pages/home_page.dart';
import 'package:fashion_shop/resources/colors.dart';
import 'package:fashion_shop/resources/constants.dart';
import 'package:fashion_shop/resources/dimens.dart';
import 'package:fashion_shop/vos/size_vo.dart';
import 'package:flutter/material.dart';

const Duration kAnimationDurationForDescriptionText = const Duration(milliseconds: 1000);

class DetailPage extends StatefulWidget {

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

   //bool isHideDescription = false;
   List<SizeVO> sizes = [
     SizeVO(
       size: "S",
       isSelect: false,
     ),
     SizeVO(
       size: "M",
       isSelect: false,
     ),
     SizeVO(
       size: "L",
       isSelect: false,
     ),
     SizeVO(
       size: "XL",
       isSelect: false,
     ),
     SizeVO(
       size: "XXL",
       isSelect: false,
     ),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBarView(),
            SliverList(
              delegate: SliverChildListDelegate([
                  OutfitIdeasView(),
                  SizedBox(height: MARGIN_MEDIUM,),
                  DescriptionView(),
                  //ExplicitAnimationDescription(),
                  SizedBox(height: MARGIN_MEDIUM,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL_1),
                    child: Column(
                      children: [
                        DetailPageSizeTitleView(),
                        SizedBox(height: MARGIN_MEDIUM_1X,),
                        Container(
                          width: double.infinity,
                          height: SIZES_LIST_VIEW_CONTAINER_HEIGHT,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sizes.length,
                            itemBuilder: (context,index){
                              return SizeView(
                                index: index,
                                size: sizes[index].size ?? "",
                                 select: (userSelectIndex){
                                   if(sizes[userSelectIndex].isSelect == false){
                                     sizes[userSelectIndex].isSelect = true;
                                   }else{
                                     sizes[userSelectIndex].isSelect = false;
                                   }
                                   setState(() {});
                                 }, 
                                  isChooseSize: sizes[index].isSelect ?? false,
                                  );
                            }
                            ),
                        ),
                      ],
                    ),
                  )
              ]),
              )
          ],
        ),
      ),
    );
  }
}

class SizeView extends StatelessWidget {

  final String size;
  final Function(int) select;
  final bool isChooseSize;
  final int index;

  SizeView({
    required this.size,
    required this.index,
    required this.select,
    required this.isChooseSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        select(index);
      },
      child: AnimatedContainer(
        duration: kAnimationDurationForProfile,
        margin: EdgeInsets.only(left: MARGIN_SMALL_1,right: MARGIN_MEDIUM_1),
        width: SIZES_LIST_VIEW_CONTAINER_WIDTH,
        decoration: BoxDecoration(
          border: (isChooseSize) ? null : Border.all(color: Colors.black,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_2)),
          color: (isChooseSize) ? PRIMARY_COLOR : Colors.white,
        ),
        child: Center(
          child: Text("$size",
          style: TextStyle(
            fontSize: TEXT_MEDIUM_1,
            fontWeight: FontWeight.w500,
            color: (isChooseSize) ? Colors.white : Colors.black,
          ),
          ),
        ),
      ),
    );
  }
}

class DetailPageSizeTitleView extends StatelessWidget {
  const DetailPageSizeTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL_1),
      child: Row(
        children: [
              Text(SIZE_YOUR_SIZE_TEXT,
                         style: TextStyle(
                       color: Colors.black,
                   fontSize: TEXT_MEDIUM_1,
                  fontWeight: FontWeight.bold,
                       ),
                         ),
                        Spacer(),
                        Text(SIZE_GUIDE_TEXT,
                         style: TextStyle(
                       color: PRIMARY_COLOR,
                   fontSize: TEXT_REGULAR_1,
                  fontWeight: FontWeight.w500,
                       ),
                         ),
        ],
      ),
    );
  }
}

class DescriptionView extends StatefulWidget {

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
   bool resultHideOrShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ItemSectionTitleView(
          title: DESCRIPTION_TEXT,
           isDarkTheme: false,
            isHomePage: false,
            icon: ExplicitAnimationDescription(
              resultHideOrShow: (hideOrShowResult){
                  resultHideOrShow = hideOrShowResult;
                  setState(() {});
              },
            ),
            //  icon: IconButton(
            //    onPressed:(){
            //       showOrHideDescription();
            //    },
            //   icon: Icon( (isHideDescription) ? Icons.arrow_drop_down : Icons.arrow_drop_up ,size: 44,color: DETAIL_PAGE_DESCRIPTION_COLOR),
            //    ),
             ),
          SizedBox(height: MARGIN_SMALL_2,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
            child: AnimatedSize(
              duration: kAnimationDurationForDescriptionText,
              child: Container(
                width: double.infinity,
                height: (resultHideOrShow) ? 0.0 : null,
                child: Text(DESCRIPTION_CONTENT_TEXT,
                  style: TextStyle(
                    color: DETAIL_PAGE_DESCRIPTION_COLOR,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class OutfitIdeasView extends StatelessWidget {
  const OutfitIdeasView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(OUTFIT_IDEAS_TEXT,
        style: TextStyle(
          fontSize: TEXT_MEDIUM_1,
          fontWeight: FontWeight.w400,
          color: PROFILE_TITLE_COLOR,
        ),
        ),
        SizedBox(height: MARGIN_SMALL_2,),
        Text(MODERN_BLUE_JACKET_TEXT,
        style: TextStyle(
          fontSize: TEXT_MEDIUM_2,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
        SizedBox(height: MARGIN_SMALL_2,),
        Text(PRICE_TEXT,
        style: TextStyle(
          fontSize: TEXT_MEDIUM_1,
          fontWeight: FontWeight.bold,
          color: PRIMARY_COLOR,
        ),
        ),
      ],
    );
  }
}

class SliverAppBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: MediaQuery.of(context).size.height / 3,
        flexibleSpace: Stack(
          clipBehavior: Clip.none,
          children: [
      Positioned.fill(
        child: Image.asset("./asset/fashion_trending_image.webp",
        fit: BoxFit.cover,
        ),
        ),

        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            children: [
              IconButton(
                onPressed: (){
                Navigator.pop(context);
              },
               icon: Icon(Icons.chevron_left,size: MARGIN_MEDIUM_3X,color: Colors.white,),
               ),
               Spacer(),
              ExplicitAnimationFavourite(),
               SizedBox(width: MARGIN_SMALL_1,),
               IconButton(
                onPressed: (){
              },
               icon: Icon(Icons.share,size: MARGIN_MEDIUM_3,color: Colors.white,),
               ),
            ],
          )
          ),

          Positioned(
            bottom: 30,
            left: 22,
            right: 22,
            child: DotsIndicator(
              dotsCount: 3,
              decorator: DotsDecorator(
                activeColor: Colors.white,
          size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              )
            ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: SLIVER_APP_BAR_CURVE_CONTAINER_HEIGHT,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MARGIN_MEDIUM_1X),
                topRight: Radius.circular(MARGIN_MEDIUM_1X),
              )
            ),
          ),
        )
          ],
        ),
        );
  }
}


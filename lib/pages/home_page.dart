import 'package:badges/badges.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fashion_shop/pages/detail_page.dart';
import 'package:fashion_shop/resources/colors.dart';
import 'package:fashion_shop/resources/constants.dart';
import 'package:fashion_shop/resources/dimens.dart';
import 'package:flutter/material.dart';

const Duration kAnimationDurationForProfile = const Duration(milliseconds: 1000);

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage = 0;
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: kAnimationDurationForProfile,
              color: (isDarkTheme) ? Colors.black : Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    child: TweenAnimationBuilder(
                    duration: kAnimationDurationForProfile,
                    tween: Tween<double>(begin: 0,end: 1),
                    child: ProfileView(
                      isDarkTheme: isDarkTheme,
                      changeToDark: (){
                        isDarkTheme = !isDarkTheme;
                        setState(() {});
                      },
                    ),
                    builder: (context,double _value,child) => Padding(
                      padding: EdgeInsets.only(top: _value * 64,left: MARGIN_MEDIUM,right: MARGIN_MEDIUM),
                      child: Opacity(
                        opacity: _value,
                        child: child),
                      ),
                    ),
                    ),
                   
                   Positioned(
                     child:  Padding(
                       padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                       child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: MARGIN_FOR_TRENDING_HEIGHT,),
                          ItemSectionTitleView(
                            isDarkTheme: isDarkTheme,
                            title: TRENDING_FOR_YOU_TEXT,
                            isHomePage: true,
                           icon: IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
                          ),
                          SizedBox(height: MARGIN_MEDIUM_1X,),
                          TweenAnimationBuilder(
                            duration: kAnimationDurationForProfile,
                            tween: Tween<double>(begin: 0,end: 1),
                            child: TrendingForYouImageView(
                              onClick: (){
                                navigateToNextScreen(context,DetailPage());
                              },
                            ),
                            builder:(context,double value,child) => 
                            Padding(
                              padding: EdgeInsets.only(left: value * MARGIN_MEDIUM,right: MARGIN_MEDIUM),
                              child: Opacity(
                                opacity: value,
                                child: child,
                                ),
                              )
                            ),
                        ],
                    ),
                     )
                     ),

                     Positioned(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           SizedBox(height: MARGIN_FOR_RECOMMANDED_HEIGHT,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                              child: ItemSectionTitleView(
                          isDarkTheme: isDarkTheme,
                          title: RECOMMANDED_TEXT,
                          isHomePage: true,
                          icon: IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
                        ),
                            ),
                         SizedBox(height: MARGIN_MEDIUM_1X,),
                         TweenAnimationBuilder(
                           duration: kAnimationDurationForProfile,
                           tween: Tween<double>(begin: 0,end: 1),
                           child: Container(
                             width: double.infinity,
                             height: RECOMMANDED_ITEM_CONTAINER_HEIGHT,
                            child: GridView.builder(
                               padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 childAspectRatio: 1.1
                               ),
                               itemCount: 2,
                               itemBuilder: (context,index){
                                 return RecommandedItemView(
                                    index: index,
                                 );
                               },
                             ),
                           ),
                           builder: (context,double value,child) => Padding(
                             padding: EdgeInsets.only(bottom: value * MARGIN_MEDIUM_1X),
                             child: Opacity(
                               opacity: value,
                               child: child),
                             ),
                         ),
                         ],
                       )
                     ),
                ],
              ),
            ),
            ),

        
        
          
           Positioned(
             bottom: 32,
             left: 26,
             right: 26,
             child: Container(
                width: MediaQuery.of(context).size.width * 0.66,
                height: TABBAR_CONTAINER_HEIGHT,
                      decoration: BoxDecoration(
                 color: (isDarkTheme) ? Colors.black : Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(MARGIN_LARGE_1)),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black54,
                     offset: Offset(10,10),
                     blurRadius: 4,
                   ),
                 ],
               ),
               child: DefaultTabController(
                 length: 5,
                child: TabBar(
                  unselectedLabelColor: TAB_UNSELECTED_COLOR,
                 labelColor: PRIMARY_COLOR,
                 indicatorColor: Colors.transparent,
                 onTap: (index){
                    currentPage = index;
                    setState(() {});
                 },
                 tabs: [
                   Tab(child:  Icon(Icons.home,size: MARGIN_HOME_ICON_SIZE),),
                   Tab(child:  Icon(Icons.search,size: MARGIN_SEARCH_ICON_SIZE),),
                   Tab(child:   Badge(
                       badgeColor: BADGE_NOTI_COLOR,
                       badgeContent: Text(BADGE_NOTI_IN_TAB_BAR_ICON),
                       child: Icon(Icons.calendar_today_sharp,size: MARGIN_MEDIUM_2X,),
                     )),
                   Tab(child: Icon(Icons.note_add,size: MARGIN_HOME_ICON_SIZE),),
                   Tab(child: Container(
                       width: TABBAR_IMAGE_CONTAINER_WIDTH,
                       height: TABBAR_IMAGE_CONTAINER_HEIGHT,
                       clipBehavior: Clip.antiAlias,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(MARGIN_FOR_CIRCLE)),
                       ),
                       //child: Image.network("http://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
                       child: Image.asset("./asset/fashion_profile_image.jpg",
                       fit: BoxFit.cover,
                       ),
                     )),
                 ],
                  ),
               ),
             ),
           ),

             //  Positioned(
          //    bottom: 32,
          //    left: 12,
          //    right: 12,
          //    child: Container(
          //      width: MediaQuery.of(context).size.width * 0.66,
          //      height: 72,
          //      decoration: BoxDecoration(
          //        color: Colors.white,
          //        borderRadius: BorderRadius.all(Radius.circular(42)),
          //        boxShadow: [
          //          BoxShadow(
          //            color: Colors.black54,
          //            offset: Offset(10,10),
          //            blurRadius: 4,
          //          ),
          //        ],
          //      ),
          //      child: Row(
          //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //        children: [
          //          Icon(Icons.home,size: 30,color: PRIMARY_COLOR),
          //          Icon(Icons.search,size: 34,color: TAB_UNSELECTED_COLOR,),
          //          Badge(
          //            badgeColor: BADGE_NOTI_COLOR,
          //            badgeContent: Text("3"),
          //            child: Icon(Icons.calendar_today_sharp,size: 28,color: TAB_UNSELECTED_COLOR,),
          //          ),
          //          Icon(Icons.note_add,size: 30,color: TAB_UNSELECTED_COLOR,),
          //          Container(
          //            width: 30,
          //            height: 30,
          //            clipBehavior: Clip.antiAlias,
          //            decoration: BoxDecoration(
          //              borderRadius: BorderRadius.all(Radius.circular(15)),
          //            ),
          //            child: Image.network("http://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
          //            fit: BoxFit.cover,
          //            ),
          //          )
          //        ],
          //      ),
          //    ),
          //  ),
        ],
      ),
    );
  }

  Future<dynamic> navigateToNextScreen(BuildContext context,Widget page) {
    return Navigator.push(
           context,
          MaterialPageRoute(builder: (context) => page),
       );
  }
}

class RecommandedItemView extends StatelessWidget {

  final int index;

  RecommandedItemView({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
         width: 60,
         height: 60,
        margin: (index == 0) ? EdgeInsets.only(right: 6) : EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
       color: (index == 0) ? RECOMMANDED_ITEM_1_BG_COLOR : RECOMMANDED_ITEM_2_BG_COLOR,
       borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
      child:Center(
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: RECOMMANDED_ITEM_VIEW_CONTAINER_WIDTH,
              height: RECOMMANDED_ITEM_VIEW_CONTAINER_HEIGHT,
              child:  Image.asset((index == 0) ? "./asset/fashion_item_shoe.png" : "./asset/fashion_item_hat.png",
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: MARGIN_SMALL_1,),
            Text( (index == 0) ? "Shoe" : "Hat",
            style: TextStyle(
              color: (index == 0) ? RECOMMANDED_ITEM_1_TEXT_COLOR : RECOMMANDED_ITEM_2_TEXT_COLOR,
              fontSize: TEXT_MEDIUM,
            ),
            ),
          ],
        ),
      ),
     );
  }
}

class TrendingForYouImageView extends StatelessWidget {
  
  final Function onClick;

  TrendingForYouImageView({
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: TRENDING_FOR_YOU_IMAGE_CONTAINER_HEIGHT,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: TRENDING_FOR_YOU_IMAGE_CONTAINER_HEIGHT,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MARGIN_MEDIUM_1X),
                ),
               //child: Image.network("https://previews.123rf.com/images/vyshniakova/vyshniakova1508/vyshniakova150800012/43881747-.jpg",
               child: Image.asset("./asset/fashion_trending_image.webp",
                fit: BoxFit.cover,
                )
              ),
            ),
    
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(NEW_2020_TEXT,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BADGE_NOTI_COLOR,
                  ),
                  ),
                  SizedBox(height: MARGIN_SMALL_2,),
                  Text(MODERN_OUTFIT_COLLECTION_TEXT,
                  style: TextStyle(
                    fontSize: TEXT_MEDIUM_1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(height: MARGIN_SMALL_2,),
                  Row(
                    children: [
                       Container(
                           width: TABBAR_IMAGE_CONTAINER_WIDTH,
                           height: TABBAR_IMAGE_CONTAINER_HEIGHT,
                           clipBehavior: Clip.antiAlias,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(MARGIN_FOR_CIRCLE)),
                           ),
                           //child: Image.network("http://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
                           child: Image.asset("./asset/fashion_profile_image.jpg",
                           fit: BoxFit.cover,
                           ),
                         ),
                         SizedBox(width: MARGIN_SMALL_2,),
                   Text(FIRNA_SURAPT_TEXT,
                      style: TextStyle(
                        color: BADGE_NOTI_COLOR,
                        fontSize: TEXT_REGULAR_1,
                      ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemSectionTitleView extends StatelessWidget {

 final String title;
 final bool isDarkTheme;
 final bool isHomePage;
 final Widget icon;

 ItemSectionTitleView({
   required this.title,
   required this.isDarkTheme,
   required this.isHomePage,
   required this.icon,
 });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Row(
        children: [
          Text(title,
         style: TextStyle(
        color: (isDarkTheme) ? Colors.white : PROFILE_SUBTITLE_COLOR,
      fontSize: TEXT_MEDIUM_1,
       fontWeight: FontWeight.bold,
            ),
          ),
        Spacer(),
        (isHomePage) ? DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: PRIMARY_COLOR,
            spacing: EdgeInsets.only(left: MARGIN_SMALL),
          ),
          ) 
          :
          Container(
            width: 50,
            height: 50,
            child: Center(child: icon),
            ),
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  
  final Function changeToDark;
  final bool isDarkTheme;

  ProfileView({
    required this.isDarkTheme,
    required this.changeToDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: PROFILE_VIEW_CONTAINER_WIDTH,
        height: PROFILE_VIEW_CONTAINER_HEIGHT,
         clipBehavior: Clip.antiAlias,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(MARGIN_HOME_ICON_SIZE)),
       ),
        child: Image.network("http://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
        fit: BoxFit.cover,
        ),
      ),
      title: Text(HOWDY_TEXT,
      style: TextStyle(
        fontSize: TEXT_MEDIUM_1,
        color: (isDarkTheme) ? Colors.white : PROFILE_TITLE_COLOR,
        fontWeight: FontWeight.w400,
      ),
      ),
      subtitle: Text(CHRISTINA_YOTA_TEXT,
      style: TextStyle(
        color: (isDarkTheme) ? Colors.white : PROFILE_SUBTITLE_COLOR,
        fontSize: TEXT_MEDIUM_1X,
        fontWeight: FontWeight.bold,
      ),
      ),
      trailing: IconButton(
        onPressed: (){
          changeToDark();
        },
         icon: Badge(
           badgeColor: BADGE_NOTI_COLOR,
           child: Icon(Icons.notifications_active,size: MARGIN_MEDIUM_3,color: TAB_UNSELECTED_COLOR,),
         ),
         ),
    );
  }
}
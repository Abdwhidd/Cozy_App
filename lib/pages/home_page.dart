import 'package:cozy/model/city.dart';
import 'package:cozy/model/space.dart';
import 'package:cozy/model/tips.dart';
import 'package:cozy/provider/space_provider.dart';
import 'package:cozy/theme.dart';
import 'package:cozy/widgets/bottom_navbar_item.dart';
import 'package:cozy/widgets/city_card.dart';
import 'package:cozy/widgets/space_card.dart';
import 'package:cozy/widgets/tips_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var spaceProvider = Provider.of<SpaceProvider>(context);
    spaceProvider.getRecommendedSpace();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(height: edge,),
            // NOTE : TITLE / HEADER
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text('Explore Now',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: medium,
                ),
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text('Mencari kosan yang cozy',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              // NOTE : POPULER CITIES
              padding: EdgeInsets.only(left: edge),
              child: Text('Popular Cities',
                style: blackTextStyle.copyWith(
                  fontWeight: normal,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 1,
                      name: 'Jakarta',
                      imageUrl: 'assets/city1.png',
                    ),
                  ),
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 2,
                      name: 'Bandung',
                      imageUrl: 'assets/city2.png',
                      isPopuler: true,
                    ),
                  ),
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 3,
                      name: 'Surabaya',
                      imageUrl: 'assets/city3.png',
                    ),
                  ),
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 4,
                      name: 'Palembang',
                      imageUrl: 'assets/city4.png',
                    ),
                  ),
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 5,
                      name: 'Aceh',
                      imageUrl: 'assets/city5.png',
                      isPopuler: true,
                    ),
                  ),
                  SizedBox(width: 20,),
                  CityCard(
                    City(
                      id: 6,
                      name: 'Bogor',
                      imageUrl: 'assets/city6.png',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            // NOTE : RECOMMENDED SPACE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text('Recommended Space',
                style: blackTextStyle.copyWith(
                  fontWeight: normal,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child:
                  FutureBuilder(
                    future: spaceProvider.getRecommendedSpace(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {

                        List<Space> data = snapshot.data as List<Space>;

                        int index = 0;

                        return Column(
                          children: data.map((item){
                            index++;
                            return Container(
                              margin: EdgeInsets.only(top: index == 1 ? 0 : 30),
                              child: SpaceCard(item),
                            );
                          }).toList(),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
            ),
            // NOTE : TIPS & GUIDANCE
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text('Tips & Guidance',
                style: blackTextStyle.copyWith(
                  fontWeight: normal,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child: Column(
                children: [
                  TipsCard(
                    Tips(
                        id: 1,
                        title: 'City Guidelines',
                        imageUrl: 'assets/tips1.png',
                        updateAt: '20 Apr',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TipsCard(
                    Tips(
                      id: 2,
                      title: 'Jakarta Fairship',
                      imageUrl: 'assets/tips2.png',
                      updateAt: '11 Dec',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70 + edge,),
            // NOTES : BOTTOM NAVIGATION BAR
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 65,
        width: MediaQuery.of(context).size.width - (2 * edge),
        margin: EdgeInsets.symmetric(horizontal: edge),
        padding: EdgeInsets.symmetric(horizontal: edge),
        decoration: BoxDecoration(
          color: Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavbarItem(
              imageUrl: 'assets/icon_home.png',
              isActive: true,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_email.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_card.png',
              isActive: false,
            ),
            BottomNavbarItem(
              imageUrl: 'assets/icon_love.png',
              isActive: false,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

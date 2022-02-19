import 'package:cozy/pages/error_page.dart';
import 'package:cozy/theme.dart';
import 'package:cozy/widgets/fasility_item.dart';
import 'package:cozy/widgets/rating_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/space.dart';


class DetailPage extends StatefulWidget {

  final Space space;
  DetailPage(this.space);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {

    _launchURL() async {
      final url = widget.space.mapUrl;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ErrorPage()),
        );
      }
    }

    _launchURLTel() async {
      final url = "tel:${widget.space.phone}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> showConfirmation() async {
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Konfirmasi',
                style: purpleTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Apakah kamu ingin mengubungi pemilik kos?',
                      style: greyTextStyle.copyWith(
                        fontWeight: normal,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Batal',
                      style: purpleTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Hubungi',
                    style: purpleTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _launchURLTel();
                  },
                ),
              ],
            );
          }
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(widget.space.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),

            ListView(
              children: [
                SizedBox(height: 328,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(23),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start ,
                              children: [
                                Text(widget.space.name,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22,
                                    fontWeight: medium,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: '\$${widget.space.price}',
                                    style: purpleTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' / month',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: light,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index){
                                return Container(
                                  width: 20,
                                  margin: EdgeInsets.only(
                                    left: 2,
                                  ),
                                  child: RatingItem(
                                      index: index,
                                      rating: widget.space.rating,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Main Facilities',
                          style: blackTextStyle.copyWith(
                            fontWeight: normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FasilityItem(
                                name: 'kitchen',
                                imageUrl: 'assets/icon_kitchen.png',
                                total: widget.space.numberOfKitchens,
                            ),
                            FasilityItem(
                              name: 'bedroom',
                              imageUrl: 'assets/icon_bedroom.png',
                              total: widget.space.numberOfBedrooms,
                            ),
                            FasilityItem(
                              name: 'cupboard',
                              imageUrl: 'assets/icon_cupboard.png',
                              total: widget.space.numberOfCupboards,
                            ),
                          ],
                        ),
                      ),
                      // NOTE : PHOTO
                      SizedBox(height: 30,),
                      Padding(
                        // NOTE : POPULER CITIES
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Photos',
                          style: blackTextStyle.copyWith(
                            fontWeight: normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        height: 88,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.space.photos.map((item){
                            return Container(
                              margin: EdgeInsets.only(
                                left: 24,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item,
                                  width: 110,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 30,),
                      // NOTE : LOCATION
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Location',
                          style: blackTextStyle.copyWith(
                            fontWeight: normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.space.address}\n${widget.space.city}',
                              style: greyTextStyle.copyWith(),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL();
                              },
                              child: Image.asset('assets/btn_map.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: edge),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: RaisedButton(
                            onPressed: () async {
                              showConfirmation();
                            },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          color: purpleColor,
                          child: Text('Book Now',
                            style: whiteTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: edge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Image.asset('assets/btn_back.png',
                      width: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    child: Image.asset(
                       isClicked ? 'assets/btn_wishlist_active.png' : 'assets/btn_wishlist.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

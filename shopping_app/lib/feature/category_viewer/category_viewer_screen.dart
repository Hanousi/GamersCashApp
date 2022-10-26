import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/resources/R.dart';
import 'package:shopping_app/route/route_constants.dart';

class CategoryViewerScreen extends StatefulWidget {
  final String categoryName;
  final HomeScreenState home;
  final List<String> reCollect = ['PS4', 'PS5', 'PS5 CD'];
  final Map<String, List<dynamic>> categoryKey = {
    'PlayStation': [
      ['PS4', R.icon.ps4],
      ['PS5', R.icon.ps5],
      ['PlayStation Repair', R.icon.psrepair]
    ],
    'PS4': [
      ['Accessories PS4', R.icon.psaccessories],
      ['Consoles PS4', R.icon.ps4],
      ['Controller Covers PS4', R.icon.pscovers],
      ['PS4 Controllers', R.icon.pscontroller],
      ['Grips PS4', R.icon.psgrips],
      ['Stickers PS4', R.icon.psskin]
    ],
    'PS5': [
      ['PS5 Consoles', R.icon.ps5],
      ['PS5 Controllers', R.icon.pscontroller],
      ['PS5 Accessories', R.icon.ps5acc],
      ['PS5 CD', R.icon.pscd]
    ],
    'PS5 CD': [
      ['New PS5 CD', R.icon.newCds],
      ['Used PS5 CD', R.icon.usedCds]
    ],
    'Headsets': [
      ['USB Headsets', R.icon.usb],
      ['AUX Headsets', R.icon.aux],
      ['Wireless Headsets', R.icon.wireless],
      ['Headset Stands', R.icon.headstand],
      ['Bluetooth Earbuds', R.icon.bluetooth],
      ['Earphones', R.icon.earbud]
    ],
    'Keyboards': [
      ['Mechanical Keyboards', R.icon.mechanical],
      ['Non-Mechanical Keyboards', R.icon.regular],
      ['Office Keyboards', R.icon.office],
      ['Wireless Keyboards', R.icon.wirelesskeyboard],
      ['Combos', R.icon.combo],
      ['One Handed Keyboards', R.icon.onehand]
    ],
    'Mouses': [
      ['Gaming Mouses', R.icon.gamingmouse],
      ['Wireless Mouses', R.icon.wirelessmouse],
      ['Combos', R.icon.combo],
      ['Mouse Bungees', R.icon.bungee]
    ],
    'Recording & Streaming': [
      ['Ring Lights', R.icon.ringlight],
      ['Stands Tripods', R.icon.tripod],
      ['WebCam', R.icon.webcam],
      ['Microphones', R.icon.mic],
      ['Sound Cards', R.icon.soundcard],
      ['Capture Cards', R.icon.capture],
      ['Backdrops', R.icon.backdrop]
    ],
    'Mobile': [
      ['Smart Watch', R.icon.smartwatch],
      ['VR Box', R.icon.vr],
      ['Power Bank', R.icon.powerbank],
      ['Power Ports', R.icon.port],
      ['Game Pads', R.icon.controller],
      ['Mouse Keyboard Adapters', R.icon.adaptor],
      ['Gaming Finger Covers', R.icon.gloves],
      ['Mobile Adapters', R.icon.mobileadapter],
      ['Phone Holder', R.icon.phoneholder],
      ['Wireless Chargers', R.icon.wirelesscharging],
      ['Cooling Fans Clip', R.icon.clips],
      ['Charging Cables', R.icon.cable],
      ['Car Chargers', R.icon.charger],
      ['PUBG', R.icon.pubg]
    ],
    'Computer': [
      ['Mouse Pads', R.icon.mousepad],
      ['PC RGB Fans', R.icon.fan],
      ['Components', R.icon.ram],
      ['Gaming Monitors', R.icon.monitor],
      ['Dongles', R.icon.dongle],
      ['Combos', R.icon.combo],
      ['Empty Gaming PC Case', R.icon.computercase],
      ['Laptops Stands', R.icon.stand],
      ['RAM', R.icon.ram],
      ['Cables', R.icon.cable],
      ['Storage Units', R.icon.storage],
      ['VR', R.icon.vr],
      ['Game Pads', R.icon.controller],
      ['Computers', R.icon.computer],
      ['Laptop', R.icon.laptop],
      ['Hardware & Software', R.icon.software]
    ],
    'XBOX': [
      ['XBOX One', R.icon.xboxone],
      ['XBOX Series X/S', R.icon.xboxseries]
    ],
    'Nintendo': [
      ['Nintendo Consoles', R.icon.nintendoconsole],
      ['Nintendo Controllers', R.icon.nintendocontroller],
      ['Nintendo Games', R.icon.mushroom],
      ['Nintendo Accessories', R.icon.nintendotext]
    ],
    'Room Design': [
      ['Action Figures', R.icon.actionfigure],
      ['RGB LED Strips', R.icon.rgb],
      ['Carpets', R.icon.carpet],
      ['Wall Decorations', R.icon.decoration],
      ['Gaming Chairs', R.icon.chair],
      ['Gaming Desks', R.icon.desk],
      ['Desk Decorations', R.icon.deskdecor],
      ['Steering Wheels', R.icon.steeringwheel],
      ['Retro Consoles', R.icon.joystick],
      ['Clouds', R.icon.cloud]
    ],
    'Speakers': [
      ['Bluetooth Speakers', R.icon.bluespeaker],
      ['Desktop Speakers', R.icon.deskspeaker]
    ],
    'Toys & Wearables': [
      ['Backpacks', R.icon.backpack],
      ['Plush Toys', R.icon.plushtoy],
      ['Pencil Case', R.icon.pencilcase],
      ['Necklaces & Bracelets', R.icon.necklace],
      ['Kids Tents', R.icon.tent],
      ['Keychain', R.icon.keychain],
      ['Educational Toys', R.icon.abc],
      ['Cosplay', R.icon.cosplay],
      ['Cap Hat', R.icon.cap],
      ['Board Games', R.icon.boardgame],
      ['Puzzles', R.icon.puzzle],
      ['Remote Control Toys', R.icon.car],
      ['Trendy Toys', R.icon.trending],
      ['Wallets', R.icon.wallet],
      ['Guns', R.icon.toygun],
    ],
  };

  CategoryViewerScreen({this.categoryName, this.home});

  @override
  _CategoryViewerScreenState createState() => _CategoryViewerScreenState();
}

class _CategoryViewerScreenState extends State<CategoryViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 28, right: 28, bottom: 16),
              child: Text(
                '${widget.categoryName}',
                style: Theme.of(context).textTheme.headline2,
              )),
          Expanded(
            child: _buildList(widget.categoryKey[widget.categoryName]),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<dynamic> categories) {
    return GridView.builder(
      itemCount: categories.length ?? 0,
      padding: EdgeInsets.only(right: 12),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        var product = categories[index][0];
        var image = categories[index][1];
        return _buildCategoryCard(product, image);
      },
    );
  }

  Widget _buildCategoryCard(String category, String image) {
    var reCollect = false;
    if (widget.reCollect.indexOf(category) > -1) {
      reCollect = true;
    }

    print(category);

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context,
              reCollect
                  ? RouteConstant.categoryViewer
                  : RouteConstant.productCategory,
              arguments: {
                "listProduct": <Product>[],
                "categoryName": category,
                "home": widget.home
              });
        },
        child: Padding(
            padding: EdgeInsets.only(left: 15, bottom: 8),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        image,
                        height: 130,
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3, left: 2, right: 2),
                    child: Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )));
  }
}

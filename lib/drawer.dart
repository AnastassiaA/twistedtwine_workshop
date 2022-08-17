import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twistedtwine_workshop/drawer_contents/settings.dart';
import 'package:twistedtwine_workshop/drawer_contents/miscInfo.dart';
import 'package:twistedtwine_workshop/drawer_contents/product.dart';
import 'package:twistedtwine_workshop/drawer_contents/orderHome.dart';
import 'package:twistedtwine_workshop/drawer_contents/timer.dart';
import 'package:twistedtwine_workshop/drawer_contents/crochetHook_tab.dart';
import 'package:twistedtwine_workshop/drawer_contents/crochetthread_tab.dart';
import 'package:twistedtwine_workshop/drawer_contents/knittingneedles_tab.dart';
import 'package:twistedtwine_workshop/drawer_contents/yarn_tab.dart';

import 'drawer_contents/accounting_dashboard.dart';
import 'drawer_contents/projects.dart';
import 'home page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/ttc_image.jpg"), fit: BoxFit.cover),
            ),
            child: Text(
              'TTC Workshop',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.houseUser),
            title: Text('Home'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.stopwatch),
            title: Text('Timer'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemTimer()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.receipt),
            title: Text('Orders'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHome()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.receipt),
            title: Text('Projects'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectHome()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.yarn),
            title: Text('Yarn'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YarnTab()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.yarn),
            title: Text('Crochet Thread'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrochetThreadTab()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.yarn),
            title: Text('Knitting Needles'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KnittingNeedleTab()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.yarn),
            title: Text('Crochet Hooks'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrochetHookTab()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.receipt),
            title: Text('Other Fibers'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHome()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.hammer),
            title: Text('Tools List'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidQuestionCircle),
            title: Text('Miscellaneous'),
            //Brands, Sellers
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MiscInfo()),
              );
            },
          ),

          //Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
            title: Text('Accounting'),
            //Expense, Revenue, all the fancy stuff
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountingDashboard()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidImages),
            title: Text('Product Catalogue'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Product()),
              );
            },
          ),
          //Divider(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.hashtag),
            title: Text('Insta Profile'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.hashtag),
            title: Text('Insta Profile'),
            tileColor: const Color(0xffE9DCE5),
            onTap: () {},
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.screwdriver),
            title: Text('Settings'),
            //Brands, Sellers
            tileColor: const Color(0xffE9DCE5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          //TDDO: make drawer auto adjust to different sized devices
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet/constants/images.dart';
import 'package:pet/constants/sizes.dart';

import '../../../constants/colors.dart';
import '../communityscreens/communityscreen.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 170,
      width: 350,
      decoration: BoxDecoration(
        color: logoPurple,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Join Our Amazing \n',
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Community',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Sizes.defaultPadding,),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, PageRouteBuilder(
                      pageBuilder:(BuildContext,animation,secondaryAnimation)=>const communityscreen() ,
                      transitionsBuilder:(BuildContext,animation,secondaryAnimation,child){
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.bounceIn;
                        var tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ));
                    // For join now
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text('Join Now',),
                  ),
                ),

              ],
            ),
            const Expanded(
              child: Image(
                image: AssetImage(community),
                width: 100,
                height: 100,
              ),
            ),
          ],
        )
      ),
    );
  }
}

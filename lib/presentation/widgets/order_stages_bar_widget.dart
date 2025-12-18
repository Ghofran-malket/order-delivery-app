import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/chat_screen.dart';
import 'package:algenie/presentation/screens/genie_screens/report_a_problem_screen.dart';
import 'package:algenie/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderStagesBarWidget extends StatelessWidget {
  final Order order;
  Stream chatMessagesStream = Stream.empty();
  OrderStagesBarWidget({super.key, required this.order});

  void handleClick(String value, context) {
    switch (value) {
      case "Report a problem":
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ReportAProblemScreen(order: order,),
          ),
        );
        break;

      case "View customer profile":
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ProfileScreen(userId: order.customerId, order: order,),
          ),
        );
        break;
      default:
        print("Default");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(17),
          left: ScreenUtil().setWidth(17),
          top: ScreenUtil().setHeight(30),
          bottom: ScreenUtil().setHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                order.customerId,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            InkWell(
              onTap: () {
                //Chats
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => ChatScreen(
                      order: order
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  SizedBox(
                      width: ScreenUtil().setWidth(20),
                      child: AspectRatio(
                        aspectRatio: 0.7,
                        child: SvgPicture.string(
                          '<svg viewBox="0.0 0.0 25.3 23.2" ><path transform="translate(-4546.38, -2004.67)" d="M 4561.4228515625 2004.6689453125 C 4556.939453125 2004.7255859375 4552.994140625 2007.3564453125 4551.65234375 2011.232177734375 C 4550.3720703125 2014.929443359375 4551.7158203125 2019.023193359375 4555.07861328125 2021.380615234375 C 4558.14892578125 2023.53271484375 4561.5078125 2023.9736328125 4565.0556640625 2022.75439453125 C 4565.580078125 2022.57421875 4565.998046875 2022.58203125 4566.48779296875 2022.823974609375 C 4567.373046875 2023.260498046875 4568.28369140625 2023.646484375 4569.19384765625 2024.0302734375 C 4569.91845703125 2024.3359375 4570.333984375 2024.0087890625 4570.1962890625 2023.23486328125 C 4570.02783203125 2022.28662109375 4569.79541015625 2021.3486328125 4569.646484375 2020.3974609375 C 4569.60009765625 2020.09912109375 4569.6298828125 2019.690185546875 4569.8017578125 2019.470703125 C 4573.39111328125 2014.888916015625 4571.8095703125 2008.0615234375 4565.580078125 2005.5068359375 C 4564.95947265625 2005.252197265625 4564.30224609375 2005.061279296875 4563.64404296875 2004.932373046875 C 4562.9140625 2004.78955078125 4562.1640625 2004.752197265625 4561.4228515625 2004.6689453125 Z M 4555.998046875 2014.53125 C 4555.9921875 2013.898193359375 4556.54443359375 2013.328857421875 4557.181640625 2013.311767578125 C 4557.8447265625 2013.2939453125 4558.43603515625 2013.883056640625 4558.42041015625 2014.54541015625 C 4558.4052734375 2015.18212890625 4557.83642578125 2015.737548828125 4557.20263671875 2015.733154296875 C 4556.5693359375 2015.728515625 4556.00390625 2015.16455078125 4555.998046875 2014.53125 Z M 4564.466796875 2014.485595703125 C 4564.48486328125 2013.825439453125 4565.0234375 2013.3017578125 4565.673828125 2013.31201171875 C 4566.35107421875 2013.322265625 4566.880859375 2013.90087890625 4566.84521484375 2014.5908203125 C 4566.81201171875 2015.238037109375 4566.240234375 2015.762939453125 4565.60400390625 2015.730712890625 C 4564.95166015625 2015.69775390625 4564.44873046875 2015.14697265625 4564.466796875 2014.485595703125 Z M 4561.4599609375 2015.73095703125 C 4560.82421875 2015.74755859375 4560.2529296875 2015.20751953125 4560.2265625 2014.564697265625 C 4560.2001953125 2013.927490234375 4560.72900390625 2013.349609375 4561.37109375 2013.31298828125 C 4562.03564453125 2013.275390625 4562.63037109375 2013.839111328125 4562.63525390625 2014.511962890625 C 4562.64013671875 2015.154541015625 4562.1005859375 2015.71435546875 4561.4599609375 2015.73095703125 Z" fill="#203b4c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(-4606.54, -2037.18)" d="M 4610.927734375 2042.718017578125 C 4610.74365234375 2042.807861328125 4610.63916015625 2042.84619140625 4610.5478515625 2042.90478515625 C 4606.36279296875 2045.581298828125 4605.24560546875 2051.403076171875 4608.17626953125 2055.41357421875 C 4608.537109375 2055.9072265625 4608.67236328125 2056.330078125 4608.51220703125 2056.92822265625 C 4608.2880859375 2057.76318359375 4608.138671875 2058.62158203125 4608.017578125 2059.478271484375 C 4607.9794921875 2059.74755859375 4608.0458984375 2060.1630859375 4608.22509765625 2060.29541015625 C 4608.4111328125 2060.432861328125 4608.82177734375 2060.38720703125 4609.0791015625 2060.284423828125 C 4609.99609375 2059.919921875 4610.90087890625 2059.52197265625 4611.78466796875 2059.08544921875 C 4612.2314453125 2058.864501953125 4612.60888671875 2058.870361328125 4613.07861328125 2059.031005859375 C 4616.6181640625 2060.23974609375 4619.95361328125 2059.811279296875 4623.056640625 2057.70068359375 C 4623.2685546875 2057.55615234375 4623.4609375 2057.38232421875 4623.7939453125 2057.116943359375 C 4619.52783203125 2057.645263671875 4615.859375 2056.691650390625 4612.9716796875 2053.63720703125 C 4610.013671875 2050.508056640625 4609.4189453125 2046.830322265625 4610.927734375 2042.718017578125 Z" fill="#203b4c" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                        ),
                      )),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Badge(
                      backgroundColor: Color(0xFFAB2929),
                      label: StreamBuilder(
                        stream: chatMessagesStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              '0',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            );
                          }
                          return Text(
                            snapshot.data.docs.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (val) => handleClick(val, context),
              color: Colors.white,
              itemBuilder: (BuildContext context) {
                return {"Report a problem", "View customer profile"}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ));
  }
}

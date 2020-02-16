import 'package:animacoes_complexas/screens/home/widgets/list_data.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView({@required this.listSlidePosition});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListData(
          title: "Estudar flutter",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 0,
        ),
        ListData(
          title: "Estudar flutter 2",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Estudar flutter 2",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 2,
        ),
        ListData(
          title: "Estudar flutter 2",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 3,
        ),
        ListData(
          title: "Estudar flutter 2",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 4,
        ),
        ListData(
          title: "Estudar flutter 2",
          subTitle: "Com curso daniel ciofi",
          image: AssetImage("images/background.jpg"),
          margin: listSlidePosition.value * 5,
        )
      ],
    );
  }
}

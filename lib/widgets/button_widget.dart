import 'package:flutter/material.dart';

abstract class _Constants {
  static const double badgeSize = 30;
}

class ButtonWidget extends StatelessWidget {
  final String imageString, eventType, way;

  const ButtonWidget(this.imageString, this.eventType, this.way, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _Constants.badgeSize / 2,
              right: _Constants.badgeSize / 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 130,
                          child: IconButton(
                            icon: Image.asset(
                              imageString,
                              height: 60,
                              width: 72,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                way,
                                arguments: eventType,
                              );
                            },
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // Opacity(
                        //   opacity: 1,
                        //   child: Text(
                        //     eventType,
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

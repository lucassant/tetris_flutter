import 'package:flutter/material.dart';
import 'package:tetromi/tetris_page.dart';
import 'package:tetromi/util/colors_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tetris',
                style: TextStyle(
                    color: COR_BACKGROUND,
                    fontSize: 60,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 60,
                child: ElevatedButton(
                  child: Text(
                    'NEW GAME',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: COR_BACKGROUND,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TetrisPage(),
                            fullscreenDialog: true));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kemet/screens/homepage.dart';

class CongratsPoP extends StatelessWidget {
  const CongratsPoP({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Image(
                image: AssetImage('images/congrats.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Congratulations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Color(0xffB68B25)),
                  minimumSize: WidgetStatePropertyAll(Size(340, 50)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  )),
                ),
                child: const Text(
                  'Lets Start',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,color: Colors.white),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomPopupCongrats(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CongratsPoP();
    },
  );
}

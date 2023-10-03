import 'package:flutter/material.dart';

class MyCliipPath extends StatelessWidget {
  const MyCliipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.44,
        color: const Color(0xFF004595),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/maroc.png',
                width: 80,
              ),
              const SizedBox(height: 4),
              const Text('المملكة المغربية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 211, 192, 132),
                    fontSize: 22,
                    height: 0.9,
                  )),
              const Text('Royaume du maroc',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 211, 192, 132),
                    fontSize: 16,
                    height: 0,
                  )),
              const SizedBox(height: 40),
              const Text(
                'وزارة إعداد التراب الوطني والتعمير والإسكان وسياسة المدينة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 211, 192, 132),
                  fontSize: 20,
                  height: 1,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Ministère de l'Aménagement du territoire national, de l'Urbanisme, de l'Habitat et de la Politique de la ville",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 211, 192, 132),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.lineTo(0, h - 70);
    path.quadraticBezierTo(
      w * 0.5,
      h,
      w,
      h - 70,
    );
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

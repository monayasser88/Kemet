import 'package:flutter/material.dart';
import 'package:kemet/components2/custom_appbar2.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 55,
              ),
              CustomAppBar2(
                title: 'About Kemet',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Uncover the mysteries of Ancient Egypt with Kemet',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  //color: Colors.black
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Definition',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  //color: Colors.black
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Experience the magic of Ancient Egypt in a whole new way.'
                'Plan your perfect Egyptian vacation with ease.'
                "Learn about Egypt's rich history and culture in an interactive format."
                'Book trips and tickets efficiently with secure online payment options.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  //color: Colors.black
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Augmented Reality (AR) Models:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Tap the camera icon in the navigation bar to activate AR mode. Then, point your camera at a picture of an ancient Egyptian figure to see it come alive in Augmented Reality!                                     '
                'Interact with the models: Watch them come alive with animations and listen to them speak about their lives and times.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Interactive Map:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Tap the map icon in the navigation bar to activate Map.'
                'Discover hidden gems and popular tourist destinations across Egypt.'
                'Search for specific landmarks, museums, or historical sites.'
                'Explore detailed information about each location, including photos, descriptions, and historical significance.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Legends and Places of Interest:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Delve into the rich tapestry of Egyptian mythology and folklore.'
                'Learn about fascinating historical figures and iconic landmarks.'
                'Explore curated lists of legends and places of interest, categorized for easy browsing.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Trip Planning and Booking:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Plan your dream Egyptian adventure!'
                'Discover exciting tours and exclusive offers tailored to your interests.'
                'Book your trip seamlessly within the app.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Ticket Reservations and Online Payment:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Secure your tickets for tours, museums, or events directly through Kemet.'
                'Choose the quantity of tickets you need for your travel group.'
                'Pay for your bookings conveniently through integrated secure online payment methods.'
                'Alternatively, opt for cash on delivery for select options.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'About Us:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'We are Kemet, a team of six students in our final year of college. Our shared fascination with Ancient Egypt fueled the creation of this app to be our Graduation Project.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Why Kemet:',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Kemet, the ancient Egyptian name for their land, signifies "black land," reflecting the fertile soil along the Nile River.  We chose this name to honor the historical context of the civilization we aim to explore.'
                "We believe that Ancient Egypt's rich history and captivating culture hold valuable lessons for the world. Through Kemet, we strive to:"
                'Make Egyptology accessible: By combining Augmented Reality and interactive elements, we aim to create an engaging learning experience for all ages.'
                'Promote cultural understanding: We believe in showcasing the unique aspects of Ancient Egypt while acknowledging its intricate connections to the broader African continent.'
                'Foster a love for history: We hope to ignite curiosity and inspire further exploration of this remarkable civilization.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "While Kemet offers educational and entertainment value, our core motivation lies in sharing our passion for Ancient Egypt. We hope this app serves as a bridge between the past and present, fostering a deeper appreciation for one of humanity's greatest civilizations.",
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

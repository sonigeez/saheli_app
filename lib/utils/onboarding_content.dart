class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    image: "assets/images/on_board3.jpeg",
    title: "Find Your Saheli",
    desc:
        "Connect with women traveling in the same direction for a safer journey together.",
  ),
  OnboardingContents(
    title: "Get to know your Saheli",
    image: "assets/images/on_board21.jpeg",
    desc:
        "Chat with your Saheli and get to know each other before you meet in person and discuss your travel plans.",
  ),
  OnboardingContents(
    image: "assets/images/on_board1.png",
    title: "Meet your Saheli",
    desc: "Meet your Saheli at safe public locations and travel together.",
  ),
];

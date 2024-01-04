class Greetings {
  static var hour = DateTime.now().toLocal().hour;
  static String showGreet() {
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour == 12 || (hour > 12 && hour < 18)) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

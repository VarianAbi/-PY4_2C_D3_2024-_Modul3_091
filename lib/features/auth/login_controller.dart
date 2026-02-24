// login_controller.dart
class LoginController {
  final Map<String, String> _users = {
    "admin": "123",
    "user1": "password1",
    "user2": "password2",
  };

  bool login(String username, String password) {
    if (_users.containsKey(username) && _users[username] == password) {
      return true;
    }
    return false;
  }
}

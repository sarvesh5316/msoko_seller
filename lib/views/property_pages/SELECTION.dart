// ignore_for_file: file_names
// This file is used to store data, which will be displayed on app
// Storing / Modifying data here, will make changes reflect in whole app. 

class SELECTION {
  static List<String> servicesList = ['Service 1','Service 2','Service 3'];
  static List<List<String>> banksList = [
    ['Bank1', 'Available'],
    ['Bank2', 'Available'],
    ['Bank3', 'Unavailable'],
  ];

  static List<String> fetchServicesList() {
    return List.from(servicesList);
  }
  static List<List<String>> fetchBanksList() {
    return List.from(banksList);
  }
}
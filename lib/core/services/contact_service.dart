import 'package:flutter_contacts/flutter_contacts.dart';

class UserContact {
  final String firstName;
  final String lastName;
  final String userDisplayName;
  final String phoneNumber;

  UserContact({
    required this.firstName,
    required this.lastName,
    required this.userDisplayName,
    required this.phoneNumber,
  });
}

class ContactService {
  static Future<List<UserContact>> getAllContacts() async {
    try {
      // Request contact permission
      final hasPermission = await FlutterContacts.requestPermission();
      if (!hasPermission) {
        throw Exception('Contact permission denied');
      }

      // Get all contacts with their properties
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        sorted: true,
      );

      final phoneContactsList = <UserContact>[];
      final addedPhoneNumbers = <String>{}; // To track duplicates

      for (var contact in contacts) {
        try {
          // Load full contact details if needed
          final fullContact = await FlutterContacts.getContact(contact.id);
          if (fullContact == null || fullContact.phones.isEmpty) continue;

          final name = contact.displayName;
          final phoneNumber = fullContact.phones.first.number;

          // Split name into first and last name
          final firstName = contact.name.first;
          final lastName = contact.name.last;

          // Format phone number
          final formattedPhone = phoneNumber
              .replaceAll('+', '00')
              .replaceAll('-', '')
              .replaceAll(' ', '');

          // Check for duplicates
          if (!addedPhoneNumbers.contains(formattedPhone)) {
            addedPhoneNumbers.add(formattedPhone);

            phoneContactsList.add(UserContact(
              firstName: firstName,
              lastName: lastName,
              userDisplayName: name,
              phoneNumber: formattedPhone,
            ));
          }
        } catch (e) {
          print('Error processing contact: $e');
          continue;
        }
      }

      return phoneContactsList;
    } catch (e) {
      print('Error getting contacts: $e');
      rethrow;
    }
  }
}

import 'package:encrypt/encrypt.dart';

class Encrypt {
  static final key = Key.fromLength(16);
  static final iv = IV.fromLength(8);

  static Encrypter get encrypter => Encrypter(AES(key));

  static Encrypted encrypted(String value) => encrypter.encrypt(value, iv: iv);

  static String? decrypted(String? value) {
    value = value ?? '';
    if (value.isEmpty) return null;
    return encrypter.decrypt64(value, iv: iv);
  }
}

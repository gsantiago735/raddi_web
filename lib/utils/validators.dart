class Validators {
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty || value.replaceAll('\n', '').isEmpty) {
      return 'Por favor ingrese una dirección de correo electrónico.';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value.trim())) {
      return 'Dirección de correo electrónico incorrecta.';
    }
    return null;
  }

  static String? loginPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una contraseña.';
    } else if (value.length < 6) {
      return "La contraseña debe contener al menos 6 caracteres.";
    }
    return null;
  }

  static String? fullNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre completo.';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.split(' ').length < 2) {
      return 'Debe contener al menos nombre y apellido.';
    }

    final regex = RegExp(r'^[a-zA-ZÀ-ÿ]+(?:\s[a-zA-ZÀ-ÿ]+)+$');
    if (!regex.hasMatch(trimmedValue)) {
      return 'El formato ingresado no es válido'; //solo letras y espacios
    }

    return null;
  }

  static String? registerPasswordValidation(
      String? value, String password, String cPassword) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una contraseña.';
    } else if (value.length < 6) {
      return "La contraseña debe contener al menos 6 caracteres.";
    } else if (password != cPassword) {
      return "Las contraseñas deben coincidir.";
    }
    return null;
  }
}

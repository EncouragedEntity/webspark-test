class TextInputValidators {
  static String? urlFormatter(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL cannot be empty';
    }

    final RegExp urlPattern = RegExp(
      r'^(https?:\/\/)?'
      r'(([a-zA-Z0-9$-_@.&+!*"(),]|[0-9a-zA-Z]|[-])+\.)+'
      r'([a-zA-Z]{2,4})'
      r'(:[0-9]{1,5})?'
      r'(\/.*)?$',
    );

    if (!urlPattern.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }
}

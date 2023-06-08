class Name {
  final String firstName;
  final String lastName;
  final String middleName;

  const Name({
    required this.firstName,
    required this.lastName,
    this.middleName = '',
  });
}

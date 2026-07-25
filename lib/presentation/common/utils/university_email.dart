const String universityEmailDomainError =
    'The email must contain either "innopolis.university" or "innopolis.ru"';

String? validateUniversityEmail(String email) =>
    (email.contains('@innopolis.university') || email.contains('@innopolis.ru'))
    ? null
    : universityEmailDomainError;

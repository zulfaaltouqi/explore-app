const userRoles = <String, String>{
  'admin': 'Admin',
  'business_owner': 'Local Business Owner',
  'tourist': 'Tourist',
};

const defaultUserRole = 'tourist';

String roleLabel(String role) {
  return userRoles[role] ?? userRoles[defaultUserRole]!;
}

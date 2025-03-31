class UserRole {
  static const String COLLECTOR = "Collector";
  static const String INSPECTOR = "Inspector";
  static const String HOD = "Head of Department";

  static const List<String> roles = [
    COLLECTOR,
    INSPECTOR,
    HOD,
  ];
}

class Department {
  static const String REVENUE = "Revenue Department";
  static const String RURAL_DEVELOPMENT = "Rural Development Department";
  static const String AGRICULTURE = "Agriculture Department";
  static const String EDUCATION = "Education Department";
  static const String HEALTH = "Health Department";
  static const String PUBLIC_WORKS = "Public Works Department";
  static const String FOREST = "Forest Department";
  static const String WATER_RESOURCES = "Water Resources Department";
  static const String DISASTER_MANAGEMENT = "Disaster Management Department";
  static const String INDUSTRIAL = "Industrial Development Department";
  static const String FOOD_SUPPLY = "Food & Civil Supplies Department";
  static const String POLICE = "Police Department";
  static const String SOCIAL_WELFARE = "Social Welfare Department";
  static const String URBAN_DEVELOPMENT = "Urban Development Department";
  static const String ENERGY = "Energy Department";
  static const String ENVIRONMENT = "Environment & Climate Change Department";
  static const String TRIBAL_WELFARE = "Tribal Welfare Department";
  static const String MINING = "Mining Department";
  static const String TRANSPORT = "Transport Department";
  static const String TOURISM = "Tourism Department";

  static const List<String> departments = [
    REVENUE,
    RURAL_DEVELOPMENT,
    AGRICULTURE,
    EDUCATION,
    HEALTH,
    PUBLIC_WORKS,
    FOREST,
    WATER_RESOURCES,
    DISASTER_MANAGEMENT,
    INDUSTRIAL,
    FOOD_SUPPLY,
    POLICE,
    SOCIAL_WELFARE,
    URBAN_DEVELOPMENT,
    ENERGY,
    ENVIRONMENT,
    TRIBAL_WELFARE,
    MINING,
    TRANSPORT,
    TOURISM,
  ];
}

class UserDemographics {
  final String? name;
  final String? contactNumber;
  final String? department;
  final String? state;

  UserDemographics({
    this.name,
    this.contactNumber,
    this.department,
    this.state,
  });
}

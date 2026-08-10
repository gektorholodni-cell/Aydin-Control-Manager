class EnterpriseCompanyProfile {
  const EnterpriseCompanyProfile({
    required this.logoText,
    required this.companyName,
    required this.bin,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.workingHours,
    required this.timezone,
    required this.language,
    required this.currency,
    required this.measurementSystem,
    required this.isSuspended,
    required this.isArchived,
  });

  final String logoText;
  final String companyName;
  final String bin;
  final String phone;
  final String email;
  final String website;
  final String address;
  final String workingHours;
  final String timezone;
  final String language;
  final String currency;
  final String measurementSystem;
  final bool isSuspended;
  final bool isArchived;

  EnterpriseCompanyProfile copyWith({
    String? logoText,
    String? companyName,
    String? bin,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? workingHours,
    String? timezone,
    String? language,
    String? currency,
    String? measurementSystem,
    bool? isSuspended,
    bool? isArchived,
  }) {
    return EnterpriseCompanyProfile(
      logoText: logoText ?? this.logoText,
      companyName: companyName ?? this.companyName,
      bin: bin ?? this.bin,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      workingHours: workingHours ?? this.workingHours,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      measurementSystem: measurementSystem ?? this.measurementSystem,
      isSuspended: isSuspended ?? this.isSuspended,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

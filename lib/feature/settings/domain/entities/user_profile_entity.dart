import '../../../../core/entities/base_entity.dart';

/// User profile entity for profile management in settings
class UserProfileEntity extends BaseEntity {
  final String id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? avatar;
  final String? cover;
  final String? about;
  final String? website;
  final String? address;
  final String? working;
  final String? workingLink;
  final String? school;
  final String? gender;
  final String? birthday;
  final String? countryId;
  final String? city;
  final String? state;
  final String? zip;
  final String? skills;
  final String? languages;
  final String? currentlyWorking;
  final String? openToWorkData;
  final String? providingService;
  final bool isVerified;
  final bool isOpenToWork;
  final bool isProvidingService;

  // Social Links
  final String? facebook;
  final String? google;
  final String? twitter;
  final String? linkedin;
  final String? youtube;
  final String? vk;
  final String? instagram;
  final String? qq;
  final String? wechat;
  final String? discord;
  final String? mailru;
  final String? okru;

  UserProfileEntity({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.cover,
    this.about,
    this.website,
    this.address,
    this.working,
    this.workingLink,
    this.school,
    this.gender,
    this.birthday,
    this.countryId,
    this.city,
    this.state,
    this.zip,
    this.skills,
    this.languages,
    this.currentlyWorking,
    this.openToWorkData,
    this.providingService,
    this.isVerified = false,
    this.isOpenToWork = false,
    this.isProvidingService = false,
    this.facebook,
    this.google,
    this.twitter,
    this.linkedin,
    this.youtube,
    this.vk,
    this.instagram,
    this.qq,
    this.wechat,
    this.discord,
    this.mailru,
    this.okru,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        firstName,
        lastName,
        email,
        phoneNumber,
        avatar,
        cover,
        about,
        website,
        address,
        working,
        workingLink,
        school,
        gender,
        birthday,
        countryId,
        city,
        state,
        zip,
        skills,
        languages,
        currentlyWorking,
        openToWorkData,
        providingService,
        isVerified,
        isOpenToWork,
        isProvidingService,
        facebook,
        google,
        twitter,
        linkedin,
        youtube,
        vk,
        instagram,
        qq,
        wechat,
        discord,
        mailru,
        okru,
      ];

  UserProfileEntity copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? avatar,
    String? cover,
    String? about,
    String? website,
    String? address,
    String? working,
    String? workingLink,
    String? school,
    String? gender,
    String? birthday,
    String? countryId,
    String? city,
    String? state,
    String? zip,
    String? skills,
    String? languages,
    String? currentlyWorking,
    String? openToWorkData,
    String? providingService,
    bool? isVerified,
    bool? isOpenToWork,
    bool? isProvidingService,
    String? facebook,
    String? google,
    String? twitter,
    String? linkedin,
    String? youtube,
    String? vk,
    String? instagram,
    String? qq,
    String? wechat,
    String? discord,
    String? mailru,
    String? okru,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      about: about ?? this.about,
      website: website ?? this.website,
      address: address ?? this.address,
      working: working ?? this.working,
      workingLink: workingLink ?? this.workingLink,
      school: school ?? this.school,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      countryId: countryId ?? this.countryId,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      openToWorkData: openToWorkData ?? this.openToWorkData,
      providingService: providingService ?? this.providingService,
      isVerified: isVerified ?? this.isVerified,
      isOpenToWork: isOpenToWork ?? this.isOpenToWork,
      isProvidingService: isProvidingService ?? this.isProvidingService,
      facebook: facebook ?? this.facebook,
      google: google ?? this.google,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      youtube: youtube ?? this.youtube,
      vk: vk ?? this.vk,
      instagram: instagram ?? this.instagram,
      qq: qq ?? this.qq,
      wechat: wechat ?? this.wechat,
      discord: discord ?? this.discord,
      mailru: mailru ?? this.mailru,
      okru: okru ?? this.okru,
    );
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username;
  }

  String get displayName => fullName;

  List<String> get socialLinks {
    final links = <String>[];
    if (facebook?.isNotEmpty == true) links.add('Facebook: $facebook');
    if (twitter?.isNotEmpty == true) links.add('Twitter: $twitter');
    if (instagram?.isNotEmpty == true) links.add('Instagram: $instagram');
    if (linkedin?.isNotEmpty == true) links.add('LinkedIn: $linkedin');
    if (youtube?.isNotEmpty == true) links.add('YouTube: $youtube');
    if (website?.isNotEmpty == true) links.add('Website: $website');
    return links;
  }
}

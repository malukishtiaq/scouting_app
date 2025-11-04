import 'package:scouting_app/feature/account/data/request/model/aff_payment_model.dart';
import 'package:scouting_app/feature/account/data/request/model/block_model.dart';
import 'package:scouting_app/feature/account/data/request/model/like_model.dart';
import 'package:scouting_app/feature/account/data/request/model/media_file.dart';
import 'package:scouting_app/feature/account/data/request/model/payment_model.dart';
import 'package:scouting_app/feature/account/data/request/model/report_model.dart';
import 'package:scouting_app/feature/account/data/request/model/visit_model.dart';

import '../../../../../core/common/type_validators.dart';
import '../../../../../core/models/base_model.dart';
import '../../../domain/entity/user_info_object.dart';

class UserInfoModel extends BaseModel<UserInfoEntity> {
  final int id;
  final bool verifiedFinal;
  final String fullName;
  final String countryTxt;
  final String fullPhoneNumber;
  final String webToken;
  final String password;
  final String age;
  final String profileCompletion;
  final List<String> profileCompletionMissing;
  final String avater;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String gender;
  final String genderTxt;
  final String facebook;
  final String google;
  final String twitter;
  final String linkedin;
  final String website;
  final String instagram;
  final String webDeviceId;
  final String language;
  final String languageTxt;
  final String emailCode;
  final String src;
  final String ipAddress;
  final String type;
  final String phoneNumber;
  final String timezone;
  final String lat;
  final String lng;
  final String about;
  final String birthday;
  final String country;
  final String registered;
  final String lastseen;
  final String smscode;
  final String proTime;
  final String lastLocationUpdate;
  final String balance;
  final String verified;
  final String status;
  final String active;
  final String admin;
  final String startUp;
  final String isPro;
  final String proType;
  final String socialLogin;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String mobileDeviceId;
  final String mobileToken;
  final String height;
  final String heightTxt;
  final String hairColor;
  final String hairColorTxt;
  final String webTokenCreatedAt;
  final String mobileTokenCreatedAt;
  final String mobileDevice;
  final String interest;
  final String location;
  final String relationship;
  final String relationshipTxt;
  final String workStatus;
  final String workStatusTxt;
  final String education;
  final String educationTxt;
  final String ethnicity;
  final String ethnicityTxt;
  final String body;
  final String bodyTxt;
  final String character;
  final String characterTxt;
  final String children;
  final String childrenTxt;
  final String friends;
  final String friendsTxt;
  final String pets;
  final String petsTxt;
  final String liveWith;
  final String liveWithTxt;
  final String car;
  final String carTxt;
  final String religion;
  final String religionTxt;
  final String smoke;
  final String smokeTxt;
  final String drink;
  final String drinkTxt;
  final String travel;
  final String travelTxt;
  final String music;
  final String dish;
  final String song;
  final String hobby;
  final String city;
  final String sport;
  final String book;
  final String movie;
  final String colour;
  final String tv;
  final String privacyShowProfileOnGoogle;
  final String privacyShowProfileRandomUsers;
  final String privacyShowProfileMatchProfiles;
  final String emailOnProfileView;
  final String emailOnNewMessage;
  final String emailOnProfileLike;
  final String emailOnPurchaseNotifications;
  final String emailOnSpecialOffers;
  final String emailOnAnnouncements;
  final String phoneVerified;
  final String online;
  final String isBoosted;
  final String boostedTime;
  final String isBuyStickers;
  final String userBuyXvisits;
  final String xvisitsCreatedAt;
  final String userBuyXmatches;
  final String xmatchesCreatedAt;
  final String userBuyXlikes;
  final String xlikesCreatedAt;
  final String showMeTo;
  final String emailOnGetGift;
  final String emailOnGotNewMatch;
  final String emailOnChatRequest;
  final String lastEmailSent;
  final String approvedAt;
  final String snapshot;
  final String hotCount;
  final String spamWarning;
  final String activationRequestCount;
  final String lastActivationRequest;
  final String twoFactor;
  final String twoFactorVerified;
  final String twoFactorEmailCode;
  final String newEmail;
  final String newPhone;
  final String permission;
  final String referrer;
  final String affBalance;
  final String paypalEmail;
  final String confirmFollowers;
  final String lastseenTxt;
  final String lastseenDate;
  final List<MediaFileModel> mediafiles;
  final bool isFriendRequest;
  final bool isFriend;
  final List<LikeModel> likes;
  final List<BlockModel> blocks;
  final List<PaymentModel> payments;
  final List<ReportModel> reports;
  final List<VisitModel> visits;
  final List<UserInfoModel> referrals;
  final List<AffPaymentModel> affPayments;
  final bool isOwner;
  final bool isLiked;
  final bool isBlocked;
  final bool isFavorite;
  final int likesCount;
  final int visitsCount;
  final String rewardDailyCredit;
  final String lockProVideo;
  final String lockPrivatePhoto;
  final String okru;
  final String mailru;
  final String discord;
  final String wechat;
  final String qq;
  final String ccPhoneNumber;
  final int zip;
  final String state;
  final String conversationId;
  final String infoFile;
  final String paystackRef;
  final int securionpayKey;
  final String coinbaseHash;
  final String coinbaseCode;
  final String yoomoneyHash;
  final String coinpaymentsTxnId;
  final String fortumoHash;
  final String ngeniusRef;
  final String aamarpayTranId;
  final String proIcon;
  UserInfoModel({
    required this.id,
    required this.verifiedFinal,
    required this.fullName,
    required this.countryTxt,
    required this.fullPhoneNumber,
    required this.webToken,
    required this.password,
    required this.age,
    required this.profileCompletion,
    required this.profileCompletionMissing,
    required this.avater,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.gender,
    required this.genderTxt,
    required this.facebook,
    required this.google,
    required this.twitter,
    required this.linkedin,
    required this.website,
    required this.instagram,
    required this.webDeviceId,
    required this.language,
    required this.languageTxt,
    required this.emailCode,
    required this.src,
    required this.ipAddress,
    required this.type,
    required this.phoneNumber,
    required this.timezone,
    required this.lat,
    required this.lng,
    required this.about,
    required this.birthday,
    required this.country,
    required this.registered,
    required this.lastseen,
    required this.smscode,
    required this.proTime,
    required this.lastLocationUpdate,
    required this.balance,
    required this.verified,
    required this.status,
    required this.active,
    required this.admin,
    required this.startUp,
    required this.isPro,
    required this.proType,
    required this.socialLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.mobileDeviceId,
    required this.mobileToken,
    required this.height,
    required this.heightTxt,
    required this.hairColor,
    required this.hairColorTxt,
    required this.webTokenCreatedAt,
    required this.mobileTokenCreatedAt,
    required this.mobileDevice,
    required this.interest,
    required this.location,
    required this.relationship,
    required this.relationshipTxt,
    required this.workStatus,
    required this.workStatusTxt,
    required this.education,
    required this.educationTxt,
    required this.ethnicity,
    required this.ethnicityTxt,
    required this.body,
    required this.bodyTxt,
    required this.character,
    required this.characterTxt,
    required this.children,
    required this.childrenTxt,
    required this.friends,
    required this.friendsTxt,
    required this.pets,
    required this.petsTxt,
    required this.liveWith,
    required this.liveWithTxt,
    required this.car,
    required this.carTxt,
    required this.religion,
    required this.religionTxt,
    required this.smoke,
    required this.smokeTxt,
    required this.drink,
    required this.drinkTxt,
    required this.travel,
    required this.travelTxt,
    required this.music,
    required this.dish,
    required this.song,
    required this.hobby,
    required this.city,
    required this.sport,
    required this.book,
    required this.movie,
    required this.colour,
    required this.tv,
    required this.privacyShowProfileOnGoogle,
    required this.privacyShowProfileRandomUsers,
    required this.privacyShowProfileMatchProfiles,
    required this.emailOnProfileView,
    required this.emailOnNewMessage,
    required this.emailOnProfileLike,
    required this.emailOnPurchaseNotifications,
    required this.emailOnSpecialOffers,
    required this.emailOnAnnouncements,
    required this.phoneVerified,
    required this.online,
    required this.isBoosted,
    required this.boostedTime,
    required this.isBuyStickers,
    required this.userBuyXvisits,
    required this.xvisitsCreatedAt,
    required this.userBuyXmatches,
    required this.xmatchesCreatedAt,
    required this.userBuyXlikes,
    required this.xlikesCreatedAt,
    required this.showMeTo,
    required this.emailOnGetGift,
    required this.emailOnGotNewMatch,
    required this.emailOnChatRequest,
    required this.lastEmailSent,
    required this.approvedAt,
    required this.snapshot,
    required this.hotCount,
    required this.spamWarning,
    required this.activationRequestCount,
    required this.lastActivationRequest,
    required this.twoFactor,
    required this.twoFactorVerified,
    required this.twoFactorEmailCode,
    required this.newEmail,
    required this.newPhone,
    required this.permission,
    required this.referrer,
    required this.affBalance,
    required this.paypalEmail,
    required this.confirmFollowers,
    required this.lastseenTxt,
    required this.lastseenDate,
    required this.mediafiles,
    required this.isFriendRequest,
    required this.isFriend,
    required this.likes,
    required this.blocks,
    required this.payments,
    required this.reports,
    required this.visits,
    required this.referrals,
    required this.affPayments,
    required this.isOwner,
    required this.isLiked,
    required this.isBlocked,
    required this.isFavorite,
    required this.likesCount,
    required this.visitsCount,
    required this.rewardDailyCredit,
    required this.lockProVideo,
    required this.lockPrivatePhoto,
    required this.okru,
    required this.mailru,
    required this.discord,
    required this.wechat,
    required this.qq,
    required this.ccPhoneNumber,
    required this.zip,
    required this.state,
    required this.conversationId,
    required this.infoFile,
    required this.paystackRef,
    required this.securionpayKey,
    required this.coinbaseHash,
    required this.coinbaseCode,
    required this.yoomoneyHash,
    required this.coinpaymentsTxnId,
    required this.fortumoHash,
    required this.ngeniusRef,
    required this.aamarpayTranId,
    required this.proIcon,
  });

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      id: numV(map['id']) ?? 0,
      verifiedFinal: boolV(map['verified_final']),
      fullName: stringV(map['full_name']),
      countryTxt: stringV(map['country_txt']),
      fullPhoneNumber: stringV(map['full_phone_number']),
      webToken: stringV(map['web_token']),
      password: stringV(map['password']),
      age: stringV(map['age']),
      profileCompletion: stringV(map['profile_completion']),
      profileCompletionMissing: map['profile_completion_missing'] is! List
          ? []
          : List<String>.from((map['profile_completion_missing'] as List)),
      avater: stringV(map['avater']),
      username: stringV(map['username']),
      email: stringV(map['email']),
      firstName: stringV(map['first_name']),
      lastName: stringV(map['last_name']),
      address: stringV(map['address']),
      gender: stringV(map['gender']),
      genderTxt: stringV(map['gender_txt']),
      facebook: stringV(map['facebook']),
      google: stringV(map['google']),
      twitter: stringV(map['twitter']),
      linkedin: stringV(map['linkedin']),
      website: stringV(map['website']),
      instagram: stringV(map['instagram']),
      webDeviceId: stringV(map['web_device_id']),
      language: stringV(map['language']),
      languageTxt: stringV(map['language_txt']),
      emailCode: stringV(map['email_code']),
      src: stringV(map['src']),
      ipAddress: stringV(map['ip_address']),
      type: stringV(map['type']),
      phoneNumber: stringV(map['phone_number']),
      timezone: stringV(map['timezone']),
      lat: stringV(map['lat']),
      lng: stringV(map['lng']),
      about: stringV(map['about']),
      birthday: stringV(map['birthday']),
      country: stringV(map['country']),
      registered: stringV(map['registered']),
      lastseen: stringV(map['lastseen']),
      smscode: stringV(map['smscode']),
      proTime: stringV(map['pro_time']),
      lastLocationUpdate: stringV(map['last_location_update']),
      balance: stringV(map['balance']),
      verified: stringV(map['verified']),
      status: stringV(map['status']),
      active: stringV(map['active']),
      admin: stringV(map['admin']),
      startUp: stringV(map['start_up']),
      isPro: stringV(map['is_pro']),
      proType: stringV(map['pro_type']),
      socialLogin: stringV(map['social_login']),
      createdAt: stringV(map['created_at']),
      updatedAt: stringV(map['updated_at']),
      deletedAt: stringV(map['deleted_at']),
      mobileDeviceId: stringV(map['mobile_device_id']),
      mobileToken: stringV(map['mobile_token']),
      height: stringV(map['height']),
      heightTxt: stringV(map['height_txt']),
      hairColor: stringV(map['hair_color']),
      hairColorTxt: stringV(map['hair_color_txt']),
      webTokenCreatedAt: stringV(map['web_token_created_at']),
      mobileTokenCreatedAt: stringV(map['mobile_token_created_at']),
      mobileDevice: stringV(map['mobile_device']),
      interest: stringV(map['interest']),
      location: stringV(map['location']),
      relationship: stringV(map['relationship']),
      relationshipTxt: stringV(map['relationship_txt']),
      workStatus: stringV(map['work_status']),
      workStatusTxt: stringV(map['work_status_txt']),
      education: stringV(map['education']),
      educationTxt: stringV(map['education_txt']),
      ethnicity: stringV(map['ethnicity']),
      ethnicityTxt: stringV(map['ethnicity_txt']),
      body: stringV(map['body']),
      bodyTxt: stringV(map['body_txt']),
      character: stringV(map['character']),
      characterTxt: stringV(map['character_txt']),
      children: stringV(map['children']),
      childrenTxt: stringV(map['children_txt']),
      friends: stringV(map['friends']),
      friendsTxt: stringV(map['friends_txt']),
      pets: stringV(map['pets']),
      petsTxt: stringV(map['pets_txt']),
      liveWith: stringV(map['live_with']),
      liveWithTxt: stringV(map['live_with_txt']),
      car: stringV(map['car']),
      carTxt: stringV(map['car_txt']),
      religion: stringV(map['religion']),
      religionTxt: stringV(map['religion_txt']),
      smoke: stringV(map['smoke']),
      smokeTxt: stringV(map['smoke_txt']),
      drink: stringV(map['drink']),
      drinkTxt: stringV(map['drink_txt']),
      travel: stringV(map['travel']),
      travelTxt: stringV(map['travel_txt']),
      music: stringV(map['music']),
      dish: stringV(map['dish']),
      song: stringV(map['song']),
      hobby: stringV(map['hobby']),
      city: stringV(map['city']),
      sport: stringV(map['sport']),
      book: stringV(map['book']),
      movie: stringV(map['movie']),
      colour: stringV(map['colour']),
      tv: stringV(map['tv']),
      privacyShowProfileOnGoogle:
          stringV(map['privacy_show_profile_on_google']),
      privacyShowProfileRandomUsers:
          stringV(map['privacy_show_profile_random_users']),
      privacyShowProfileMatchProfiles:
          stringV(map['privacy_show_profile_match_profiles']),
      emailOnProfileView: stringV(map['email_on_profile_view']),
      emailOnNewMessage: stringV(map['email_on_new_message']),
      emailOnProfileLike: stringV(map['email_on_profile_like']),
      emailOnPurchaseNotifications:
          stringV(map['email_on_purchase_notifications']),
      emailOnSpecialOffers: stringV(map['email_on_special_offers']),
      emailOnAnnouncements: stringV(map['email_on_announcements']),
      phoneVerified: stringV(map['phone_verified']),
      online: stringV(map['online']),
      isBoosted: stringV(map['is_boosted']),
      boostedTime: stringV(map['boosted_time']),
      isBuyStickers: stringV(map['is_buy_stickers']),
      userBuyXvisits: stringV(map['user_buy_xvisits']),
      xvisitsCreatedAt: stringV(map['xvisits_created_at']),
      userBuyXmatches: stringV(map['user_buy_xmatches']),
      xmatchesCreatedAt: stringV(map['xmatches_created_at']),
      userBuyXlikes: stringV(map['user_buy_xlikes']),
      xlikesCreatedAt: stringV(map['xlikes_created_at']),
      showMeTo: stringV(map['show_me_to']),
      emailOnGetGift: stringV(map['email_on_get_gift']),
      emailOnGotNewMatch: stringV(map['email_on_got_new_match']),
      emailOnChatRequest: stringV(map['email_on_chat_request']),
      lastEmailSent: stringV(map['last_email_sent']),
      approvedAt: stringV(map['approved_at']),
      snapshot: stringV(map['snapshot']),
      hotCount: stringV(map['hot_count']),
      spamWarning: stringV(map['spam_warning']),
      activationRequestCount: stringV(map['activation_request_count']),
      lastActivationRequest: stringV(map['last_activation_request']),
      twoFactor: stringV(map['two_factor']),
      twoFactorVerified: stringV(map['two_factor_verified']),
      twoFactorEmailCode: stringV(map['two_factor_email_code']),
      newEmail: stringV(map['new_email']),
      newPhone: stringV(map['new_phone']),
      permission: stringV(map['permission']),
      referrer: stringV(map['referrer']),
      affBalance: stringV(map['aff_balance']),
      paypalEmail: stringV(map['paypal_email']),
      confirmFollowers: stringV(map['confirm_followers']),
      lastseenTxt: stringV(map['lastseen_txt']),
      lastseenDate: stringV(map['lastseen_date']),
      mediafiles: map['mediafiles'] is! List
          ? []
          : List<MediaFileModel>.from(
              (map['mediafiles'] as List).map<MediaFileModel>(
                (x) => MediaFileModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      isFriendRequest: boolV(map['is_friend_request']),
      isFriend: boolV(map['is_friend']),
      likes: map['likes'] is! List
          ? []
          : List<LikeModel>.from(
              (map['likes'] as List).map<LikeModel>(
                (x) => LikeModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      blocks: map['blocks'] is! List
          ? []
          : List<BlockModel>.from(
              (map['blocks'] as List).map<BlockModel>(
                (x) => BlockModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      payments: map['payments'] is! List
          ? []
          : List<PaymentModel>.from(
              (map['payments'] as List).map<PaymentModel>(
                (x) => PaymentModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      reports: map['reports'] is! List
          ? []
          : List<ReportModel>.from(
              (map['reports'] as List).map<ReportModel>(
                (x) => ReportModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      visits: map['visits'] is! List
          ? []
          : List<VisitModel>.from(
              (map['visits'] as List).map<VisitModel>(
                (x) => VisitModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      referrals: map['referrals'] is! List
          ? []
          : List<UserInfoModel>.from(
              (map['referrals'] as List).map<UserInfoModel>(
                (x) => UserInfoModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      affPayments: map['aff_payments'] is! List
          ? []
          : List<AffPaymentModel>.from(
              (map['aff_payments'] as List).map<AffPaymentModel>(
                (x) => AffPaymentModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      isOwner: boolV(map['is_owner']),
      isLiked: boolV(map['is_liked']),
      isBlocked: boolV(map['is_blocked']),
      isFavorite: boolV(map['is_favorite']),
      likesCount: numV(map['likes_count']) ?? 0,
      visitsCount: numV(map['visits_count']) ?? 0,
      rewardDailyCredit: stringV(map['reward_daily_credit']),
      lockProVideo: stringV(map['lock_pro_video']),
      lockPrivatePhoto: stringV(map['lock_private_photo']),
      okru: stringV(map['okru']),
      mailru: stringV(map['mailru']),
      discord: stringV(map['discord']),
      wechat: stringV(map['wechat']),
      qq: stringV(map['qq']),
      ccPhoneNumber: stringV(map['cc_phone_number']),
      zip: numV(map['zip']) ?? 0,
      state: stringV(map['state']),
      conversationId: stringV(map['conversation_id']),
      infoFile: stringV(map['info_file']),
      paystackRef: stringV(map['paystack_ref']),
      securionpayKey: numV(map['securionpay_key']) ?? 0,
      coinbaseHash: stringV(map['coinbase_hash']),
      coinbaseCode: stringV(map['coinbase_code']),
      yoomoneyHash: stringV(map['yoomoney_hash']),
      coinpaymentsTxnId: stringV(map['coinpayments_txn_id']),
      fortumoHash: stringV(map['fortumo_hash']),
      ngeniusRef: stringV(map['ngenius_ref']),
      aamarpayTranId: stringV(map['aamarpay_tran_id']),
      proIcon: stringV(map['pro_icon']),
    );
  }

  factory UserInfoModel.empty() {
    return UserInfoModel(
      id: 0,
      verifiedFinal: false,
      fullName: '',
      countryTxt: '',
      fullPhoneNumber: '',
      webToken: '',
      password: '',
      age: '',
      profileCompletion: '',
      profileCompletionMissing: [],
      avater: '',
      username: '',
      email: '',
      firstName: '',
      lastName: '',
      address: '',
      gender: '',
      genderTxt: '',
      facebook: '',
      google: '',
      twitter: '',
      linkedin: '',
      website: '',
      instagram: '',
      webDeviceId: '',
      language: '',
      languageTxt: '',
      emailCode: '',
      src: '',
      ipAddress: '',
      type: '',
      phoneNumber: '',
      timezone: '',
      lat: '',
      lng: '',
      about: '',
      birthday: '',
      country: '',
      registered: '',
      lastseen: '',
      smscode: '',
      proTime: '',
      lastLocationUpdate: '',
      balance: '',
      verified: '',
      status: '',
      active: '',
      admin: '',
      startUp: '',
      isPro: '',
      proType: '',
      socialLogin: '',
      createdAt: '',
      updatedAt: '',
      deletedAt: '',
      mobileDeviceId: '',
      mobileToken: '',
      height: '',
      heightTxt: '',
      hairColor: '',
      hairColorTxt: '',
      webTokenCreatedAt: '',
      mobileTokenCreatedAt: '',
      mobileDevice: '',
      interest: '',
      location: '',
      relationship: '',
      relationshipTxt: '',
      workStatus: '',
      workStatusTxt: '',
      education: '',
      educationTxt: '',
      ethnicity: '',
      ethnicityTxt: '',
      body: '',
      bodyTxt: '',
      character: '',
      characterTxt: '',
      children: '',
      childrenTxt: '',
      friends: '',
      friendsTxt: '',
      pets: '',
      petsTxt: '',
      liveWith: '',
      liveWithTxt: '',
      car: '',
      carTxt: '',
      religion: '',
      religionTxt: '',
      smoke: '',
      smokeTxt: '',
      drink: '',
      drinkTxt: '',
      travel: '',
      travelTxt: '',
      music: '',
      dish: '',
      song: '',
      hobby: '',
      city: '',
      sport: '',
      book: '',
      movie: '',
      colour: '',
      tv: '',
      privacyShowProfileOnGoogle: '',
      privacyShowProfileRandomUsers: '',
      privacyShowProfileMatchProfiles: '',
      emailOnProfileView: '',
      emailOnNewMessage: '',
      emailOnProfileLike: '',
      emailOnPurchaseNotifications: '',
      emailOnSpecialOffers: '',
      emailOnAnnouncements: '',
      phoneVerified: '',
      online: '',
      isBoosted: '',
      boostedTime: '',
      isBuyStickers: '',
      userBuyXvisits: '',
      xvisitsCreatedAt: '',
      userBuyXmatches: '',
      xmatchesCreatedAt: '',
      userBuyXlikes: '',
      xlikesCreatedAt: '',
      showMeTo: '',
      emailOnGetGift: '',
      emailOnGotNewMatch: '',
      emailOnChatRequest: '',
      lastEmailSent: '',
      approvedAt: '',
      snapshot: '',
      hotCount: '',
      spamWarning: '',
      activationRequestCount: '',
      lastActivationRequest: '',
      twoFactor: '',
      twoFactorVerified: '',
      twoFactorEmailCode: '',
      newEmail: '',
      newPhone: '',
      permission: '',
      referrer: '',
      affBalance: '',
      paypalEmail: '',
      confirmFollowers: '',
      lastseenTxt: '',
      lastseenDate: '',
      mediafiles: [],
      isFriendRequest: false,
      isFriend: false,
      likes: [],
      blocks: [],
      payments: [],
      reports: [],
      visits: [],
      referrals: [],
      affPayments: [],
      isOwner: false,
      isLiked: false,
      isBlocked: false,
      isFavorite: false,
      likesCount: 0,
      visitsCount: 0,
      rewardDailyCredit: '',
      lockProVideo: '',
      lockPrivatePhoto: '',
      okru: '',
      mailru: '',
      discord: '',
      wechat: '',
      qq: '',
      ccPhoneNumber: '',
      zip: 0,
      state: '',
      conversationId: '',
      infoFile: '',
      paystackRef: '',
      securionpayKey: 0,
      coinbaseHash: '',
      coinbaseCode: '',
      yoomoneyHash: '',
      coinpaymentsTxnId: '',
      fortumoHash: '',
      ngeniusRef: '',
      aamarpayTranId: '',
      proIcon: '',
    );
  }

  @override
  UserInfoEntity toEntity() {
    return UserInfoEntity(
      id: id,
      verifiedFinal: verifiedFinal,
      fullName: fullName,
      countryTxt: countryTxt,
      fullPhoneNumber: fullPhoneNumber,
      webToken: webToken,
      password: password,
      age: age,
      profileCompletion: profileCompletion,
      profileCompletionMissing: profileCompletionMissing,
      avater: avater,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      address: address,
      gender: gender,
      genderTxt: genderTxt,
      facebook: facebook,
      google: google,
      twitter: twitter,
      linkedin: linkedin,
      website: website,
      instagram: instagram,
      webDeviceId: webDeviceId,
      language: language,
      languageTxt: languageTxt,
      emailCode: emailCode,
      src: src,
      ipAddress: ipAddress,
      type: type,
      phoneNumber: phoneNumber,
      timezone: timezone,
      lat: lat,
      lng: lng,
      about: about,
      birthday: birthday,
      country: country,
      registered: registered,
      lastseen: lastseen,
      smscode: smscode,
      proTime: proTime,
      lastLocationUpdate: lastLocationUpdate,
      balance: balance,
      verified: verified,
      status: status,
      active: active,
      admin: admin,
      startUp: startUp,
      isPro: isPro,
      proType: proType,
      socialLogin: socialLogin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      mobileDeviceId: mobileDeviceId,
      mobileToken: mobileToken,
      height: height,
      heightTxt: heightTxt,
      hairColor: hairColor,
      hairColorTxt: hairColorTxt,
      webTokenCreatedAt: webTokenCreatedAt,
      mobileTokenCreatedAt: mobileTokenCreatedAt,
      mobileDevice: mobileDevice,
      interest: interest,
      location: location,
      relationship: relationship,
      relationshipTxt: relationshipTxt,
      workStatus: workStatus,
      workStatusTxt: workStatusTxt,
      education: education,
      educationTxt: educationTxt,
      ethnicity: ethnicity,
      ethnicityTxt: ethnicityTxt,
      body: body,
      bodyTxt: bodyTxt,
      character: character,
      characterTxt: characterTxt,
      children: children,
      childrenTxt: childrenTxt,
      friends: friends,
      friendsTxt: friendsTxt,
      pets: pets,
      petsTxt: petsTxt,
      liveWith: liveWith,
      liveWithTxt: liveWithTxt,
      car: car,
      carTxt: carTxt,
      religion: religion,
      religionTxt: religionTxt,
      smoke: smoke,
      smokeTxt: smokeTxt,
      drink: drink,
      drinkTxt: drinkTxt,
      travel: travel,
      travelTxt: travelTxt,
      music: music,
      dish: dish,
      song: song,
      hobby: hobby,
      city: city,
      sport: sport,
      book: book,
      movie: movie,
      colour: colour,
      tv: tv,
      privacyShowProfileOnGoogle: privacyShowProfileOnGoogle,
      privacyShowProfileRandomUsers: privacyShowProfileRandomUsers,
      privacyShowProfileMatchProfiles: privacyShowProfileMatchProfiles,
      emailOnProfileView: emailOnProfileView,
      emailOnNewMessage: emailOnNewMessage,
      emailOnProfileLike: emailOnProfileLike,
      emailOnPurchaseNotifications: emailOnPurchaseNotifications,
      emailOnSpecialOffers: emailOnSpecialOffers,
      emailOnAnnouncements: emailOnAnnouncements,
      phoneVerified: phoneVerified,
      online: online,
      isBoosted: isBoosted,
      boostedTime: boostedTime,
      isBuyStickers: isBuyStickers,
      userBuyXvisits: userBuyXvisits,
      xvisitsCreatedAt: xvisitsCreatedAt,
      userBuyXmatches: userBuyXmatches,
      xmatchesCreatedAt: xmatchesCreatedAt,
      userBuyXlikes: userBuyXlikes,
      xlikesCreatedAt: xlikesCreatedAt,
      showMeTo: showMeTo,
      emailOnGetGift: emailOnGetGift,
      emailOnGotNewMatch: emailOnGotNewMatch,
      emailOnChatRequest: emailOnChatRequest,
      lastEmailSent: lastEmailSent,
      approvedAt: approvedAt,
      snapshot: snapshot,
      hotCount: hotCount,
      spamWarning: spamWarning,
      activationRequestCount: activationRequestCount,
      lastActivationRequest: lastActivationRequest,
      twoFactor: twoFactor,
      twoFactorVerified: twoFactorVerified,
      twoFactorEmailCode: twoFactorEmailCode,
      newEmail: newEmail,
      newPhone: newPhone,
      permission: permission,
      referrer: referrer,
      affBalance: affBalance,
      paypalEmail: paypalEmail,
      confirmFollowers: confirmFollowers,
      lastseenTxt: lastseenTxt,
      lastseenDate: lastseenDate,
      mediafiles: mediafiles.map((e) => e.toEntity()).toList(),
      isFriendRequest: isFriendRequest,
      isFriend: isFriend,
      likes: likes.isNotEmpty
          ? likes.map((e) => e.toEntity()).toList()
          : List.empty(),
      blocks: blocks.isNotEmpty
          ? blocks.map((e) => e.toEntity()).toList()
          : List.empty(),
      payments: payments.isNotEmpty
          ? payments.map((e) => e.toEntity()).toList()
          : List.empty(),
      reports: reports.isNotEmpty
          ? reports.map((e) => e.toEntity()).toList()
          : List.empty(),
      visits: visits.isNotEmpty
          ? visits.map((e) => e.toEntity()).toList()
          : List.empty(),
      referrals: referrals.isNotEmpty
          ? referrals.map((e) => e.toEntity()).toList()
          : List.empty(),
      affPayments: affPayments.isNotEmpty
          ? affPayments.map((e) => e.toEntity()).toList()
          : List.empty(),
      isOwner: isOwner,
      isLiked: isLiked,
      isBlocked: isBlocked,
      isFavorite: isFavorite,
      likesCount: likesCount,
      visitsCount: visitsCount,
      rewardDailyCredit: rewardDailyCredit,
      lockProVideo: lockProVideo,
      lockPrivatePhoto: lockPrivatePhoto,
      okru: okru,
      mailru: mailru,
      discord: discord,
      wechat: wechat,
      qq: qq,
      ccPhoneNumber: ccPhoneNumber,
      zip: zip,
      state: state,
      conversationId: conversationId,
      infoFile: infoFile,
      paystackRef: paystackRef,
      securionpayKey: securionpayKey,
      coinbaseHash: coinbaseHash,
      coinbaseCode: coinbaseCode,
      yoomoneyHash: yoomoneyHash,
      coinpaymentsTxnId: coinpaymentsTxnId,
      fortumoHash: fortumoHash,
      ngeniusRef: ngeniusRef,
      aamarpayTranId: aamarpayTranId,
      proIcon: proIcon,
    );
  }
}

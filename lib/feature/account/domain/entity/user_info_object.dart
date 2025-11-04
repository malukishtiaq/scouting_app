// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/entities/base_entity.dart';

import '../../../../core/common/type_validators.dart';
import 'aff_payment_entity.dart';
import 'block_entity.dart';
import 'like_entity.dart';
import 'media_file_entity.dart';
import 'payment_entity.dart';
import 'report_entity.dart';
import 'visit_entity.dart';

class UserInfoEntity extends BaseEntity {
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
  final List<MediaFileEntity> mediafiles;
  final bool isFriendRequest;
  final bool isFriend;
  final List<LikeEntity> likes;
  final List<BlockEntity> blocks;
  final List<PaymentEntity> payments;
  final List<ReportEntity> reports;
  final List<VisitEntity> visits;
  final List<UserInfoEntity> referrals;
  final List<AffPaymentEntity> affPayments;
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
  UserInfoEntity({
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

  UserInfoEntity copyWith({
    int? id,
    bool? verifiedFinal,
    String? fullName,
    String? countryTxt,
    String? fullPhoneNumber,
    String? webToken,
    String? password,
    String? age,
    String? profileCompletion,
    List<String>? profileCompletionMissing,
    String? avater,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? address,
    String? gender,
    String? genderTxt,
    String? facebook,
    String? google,
    String? twitter,
    String? linkedin,
    String? website,
    String? instagram,
    String? webDeviceId,
    String? language,
    String? languageTxt,
    String? emailCode,
    String? src,
    String? ipAddress,
    String? type,
    String? phoneNumber,
    String? timezone,
    String? lat,
    String? lng,
    String? about,
    String? birthday,
    String? country,
    String? registered,
    String? lastseen,
    String? smscode,
    String? proTime,
    String? lastLocationUpdate,
    String? balance,
    String? verified,
    String? status,
    String? active,
    String? admin,
    String? startUp,
    String? isPro,
    String? proType,
    String? socialLogin,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? mobileDeviceId,
    String? mobileToken,
    String? height,
    String? heightTxt,
    String? hairColor,
    String? hairColorTxt,
    String? webTokenCreatedAt,
    String? mobileTokenCreatedAt,
    String? mobileDevice,
    String? interest,
    String? location,
    String? relationship,
    String? relationshipTxt,
    String? workStatus,
    String? workStatusTxt,
    String? education,
    String? educationTxt,
    String? ethnicity,
    String? ethnicityTxt,
    String? body,
    String? bodyTxt,
    String? character,
    String? characterTxt,
    String? children,
    String? childrenTxt,
    String? friends,
    String? friendsTxt,
    String? pets,
    String? petsTxt,
    String? liveWith,
    String? liveWithTxt,
    String? car,
    String? carTxt,
    String? religion,
    String? religionTxt,
    String? smoke,
    String? smokeTxt,
    String? drink,
    String? drinkTxt,
    String? travel,
    String? travelTxt,
    String? music,
    String? dish,
    String? song,
    String? hobby,
    String? city,
    String? sport,
    String? book,
    String? movie,
    String? colour,
    String? tv,
    String? privacyShowProfileOnGoogle,
    String? privacyShowProfileRandomUsers,
    String? privacyShowProfileMatchProfiles,
    String? emailOnProfileView,
    String? emailOnNewMessage,
    String? emailOnProfileLike,
    String? emailOnPurchaseNotifications,
    String? emailOnSpecialOffers,
    String? emailOnAnnouncements,
    String? phoneVerified,
    String? online,
    String? isBoosted,
    String? boostedTime,
    String? isBuyStickers,
    String? userBuyXvisits,
    String? xvisitsCreatedAt,
    String? userBuyXmatches,
    String? xmatchesCreatedAt,
    String? userBuyXlikes,
    String? xlikesCreatedAt,
    String? showMeTo,
    String? emailOnGetGift,
    String? emailOnGotNewMatch,
    String? emailOnChatRequest,
    String? lastEmailSent,
    String? approvedAt,
    String? snapshot,
    String? hotCount,
    String? spamWarning,
    String? activationRequestCount,
    String? lastActivationRequest,
    String? twoFactor,
    String? twoFactorVerified,
    String? twoFactorEmailCode,
    String? newEmail,
    String? newPhone,
    String? permission,
    String? referrer,
    String? affBalance,
    String? paypalEmail,
    String? confirmFollowers,
    String? lastseenTxt,
    String? lastseenDate,
    List<MediaFileEntity>? mediafiles,
    bool? isFriendRequest,
    bool? isFriend,
    List<LikeEntity>? likes,
    List<BlockEntity>? blocks,
    List<PaymentEntity>? payments,
    List<ReportEntity>? reports,
    List<VisitEntity>? visits,
    List<UserInfoEntity>? referrals,
    List<AffPaymentEntity>? affPayments,
    bool? isOwner,
    bool? isLiked,
    bool? isBlocked,
    bool? isFavorite,
    int? likesCount,
    int? visitsCount,
    String? rewardDailyCredit,
    String? lockProVideo,
    String? lockPrivatePhoto,
    String? okru,
    String? mailru,
    String? discord,
    String? wechat,
    String? qq,
    String? ccPhoneNumber,
    int? zip,
    String? state,
    String? conversationId,
    String? infoFile,
    String? paystackRef,
    int? securionpayKey,
    String? coinbaseHash,
    String? coinbaseCode,
    String? yoomoneyHash,
    String? coinpaymentsTxnId,
    String? fortumoHash,
    String? ngeniusRef,
    String? aamarpayTranId,
    String? proIcon,
  }) {
    return UserInfoEntity(
      id: id ?? this.id,
      verifiedFinal: verifiedFinal ?? this.verifiedFinal,
      fullName: fullName ?? this.fullName,
      countryTxt: countryTxt ?? this.countryTxt,
      fullPhoneNumber: fullPhoneNumber ?? this.fullPhoneNumber,
      webToken: webToken ?? this.webToken,
      password: password ?? this.password,
      age: age ?? this.age,
      profileCompletion: profileCompletion ?? this.profileCompletion,
      profileCompletionMissing:
          profileCompletionMissing ?? this.profileCompletionMissing,
      avater: avater ?? this.avater,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      genderTxt: genderTxt ?? this.genderTxt,
      facebook: facebook ?? this.facebook,
      google: google ?? this.google,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
      instagram: instagram ?? this.instagram,
      webDeviceId: webDeviceId ?? this.webDeviceId,
      language: language ?? this.language,
      languageTxt: languageTxt ?? this.languageTxt,
      emailCode: emailCode ?? this.emailCode,
      src: src ?? this.src,
      ipAddress: ipAddress ?? this.ipAddress,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      timezone: timezone ?? this.timezone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      about: about ?? this.about,
      birthday: birthday ?? this.birthday,
      country: country ?? this.country,
      registered: registered ?? this.registered,
      lastseen: lastseen ?? this.lastseen,
      smscode: smscode ?? this.smscode,
      proTime: proTime ?? this.proTime,
      lastLocationUpdate: lastLocationUpdate ?? this.lastLocationUpdate,
      balance: balance ?? this.balance,
      verified: verified ?? this.verified,
      status: status ?? this.status,
      active: active ?? this.active,
      admin: admin ?? this.admin,
      startUp: startUp ?? this.startUp,
      isPro: isPro ?? this.isPro,
      proType: proType ?? this.proType,
      socialLogin: socialLogin ?? this.socialLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      mobileDeviceId: mobileDeviceId ?? this.mobileDeviceId,
      mobileToken: mobileToken ?? this.mobileToken,
      height: height ?? this.height,
      heightTxt: heightTxt ?? this.heightTxt,
      hairColor: hairColor ?? this.hairColor,
      hairColorTxt: hairColorTxt ?? this.hairColorTxt,
      webTokenCreatedAt: webTokenCreatedAt ?? this.webTokenCreatedAt,
      mobileTokenCreatedAt: mobileTokenCreatedAt ?? this.mobileTokenCreatedAt,
      mobileDevice: mobileDevice ?? this.mobileDevice,
      interest: interest ?? this.interest,
      location: location ?? this.location,
      relationship: relationship ?? this.relationship,
      relationshipTxt: relationshipTxt ?? this.relationshipTxt,
      workStatus: workStatus ?? this.workStatus,
      workStatusTxt: workStatusTxt ?? this.workStatusTxt,
      education: education ?? this.education,
      educationTxt: educationTxt ?? this.educationTxt,
      ethnicity: ethnicity ?? this.ethnicity,
      ethnicityTxt: ethnicityTxt ?? this.ethnicityTxt,
      body: body ?? this.body,
      bodyTxt: bodyTxt ?? this.bodyTxt,
      character: character ?? this.character,
      characterTxt: characterTxt ?? this.characterTxt,
      children: children ?? this.children,
      childrenTxt: childrenTxt ?? this.childrenTxt,
      friends: friends ?? this.friends,
      friendsTxt: friendsTxt ?? this.friendsTxt,
      pets: pets ?? this.pets,
      petsTxt: petsTxt ?? this.petsTxt,
      liveWith: liveWith ?? this.liveWith,
      liveWithTxt: liveWithTxt ?? this.liveWithTxt,
      car: car ?? this.car,
      carTxt: carTxt ?? this.carTxt,
      religion: religion ?? this.religion,
      religionTxt: religionTxt ?? this.religionTxt,
      smoke: smoke ?? this.smoke,
      smokeTxt: smokeTxt ?? this.smokeTxt,
      drink: drink ?? this.drink,
      drinkTxt: drinkTxt ?? this.drinkTxt,
      travel: travel ?? this.travel,
      travelTxt: travelTxt ?? this.travelTxt,
      music: music ?? this.music,
      dish: dish ?? this.dish,
      song: song ?? this.song,
      hobby: hobby ?? this.hobby,
      city: city ?? this.city,
      sport: sport ?? this.sport,
      book: book ?? this.book,
      movie: movie ?? this.movie,
      colour: colour ?? this.colour,
      tv: tv ?? this.tv,
      privacyShowProfileOnGoogle:
          privacyShowProfileOnGoogle ?? this.privacyShowProfileOnGoogle,
      privacyShowProfileRandomUsers:
          privacyShowProfileRandomUsers ?? this.privacyShowProfileRandomUsers,
      privacyShowProfileMatchProfiles: privacyShowProfileMatchProfiles ??
          this.privacyShowProfileMatchProfiles,
      emailOnProfileView: emailOnProfileView ?? this.emailOnProfileView,
      emailOnNewMessage: emailOnNewMessage ?? this.emailOnNewMessage,
      emailOnProfileLike: emailOnProfileLike ?? this.emailOnProfileLike,
      emailOnPurchaseNotifications:
          emailOnPurchaseNotifications ?? this.emailOnPurchaseNotifications,
      emailOnSpecialOffers: emailOnSpecialOffers ?? this.emailOnSpecialOffers,
      emailOnAnnouncements: emailOnAnnouncements ?? this.emailOnAnnouncements,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      online: online ?? this.online,
      isBoosted: isBoosted ?? this.isBoosted,
      boostedTime: boostedTime ?? this.boostedTime,
      isBuyStickers: isBuyStickers ?? this.isBuyStickers,
      userBuyXvisits: userBuyXvisits ?? this.userBuyXvisits,
      xvisitsCreatedAt: xvisitsCreatedAt ?? this.xvisitsCreatedAt,
      userBuyXmatches: userBuyXmatches ?? this.userBuyXmatches,
      xmatchesCreatedAt: xmatchesCreatedAt ?? this.xmatchesCreatedAt,
      userBuyXlikes: userBuyXlikes ?? this.userBuyXlikes,
      xlikesCreatedAt: xlikesCreatedAt ?? this.xlikesCreatedAt,
      showMeTo: showMeTo ?? this.showMeTo,
      emailOnGetGift: emailOnGetGift ?? this.emailOnGetGift,
      emailOnGotNewMatch: emailOnGotNewMatch ?? this.emailOnGotNewMatch,
      emailOnChatRequest: emailOnChatRequest ?? this.emailOnChatRequest,
      lastEmailSent: lastEmailSent ?? this.lastEmailSent,
      approvedAt: approvedAt ?? this.approvedAt,
      snapshot: snapshot ?? this.snapshot,
      hotCount: hotCount ?? this.hotCount,
      spamWarning: spamWarning ?? this.spamWarning,
      activationRequestCount:
          activationRequestCount ?? this.activationRequestCount,
      lastActivationRequest:
          lastActivationRequest ?? this.lastActivationRequest,
      twoFactor: twoFactor ?? this.twoFactor,
      twoFactorVerified: twoFactorVerified ?? this.twoFactorVerified,
      twoFactorEmailCode: twoFactorEmailCode ?? this.twoFactorEmailCode,
      newEmail: newEmail ?? this.newEmail,
      newPhone: newPhone ?? this.newPhone,
      permission: permission ?? this.permission,
      referrer: referrer ?? this.referrer,
      affBalance: affBalance ?? this.affBalance,
      paypalEmail: paypalEmail ?? this.paypalEmail,
      confirmFollowers: confirmFollowers ?? this.confirmFollowers,
      lastseenTxt: lastseenTxt ?? this.lastseenTxt,
      lastseenDate: lastseenDate ?? this.lastseenDate,
      mediafiles: mediafiles ?? this.mediafiles,
      isFriendRequest: isFriendRequest ?? this.isFriendRequest,
      isFriend: isFriend ?? this.isFriend,
      likes: likes ?? this.likes,
      blocks: blocks ?? this.blocks,
      payments: payments ?? this.payments,
      reports: reports ?? this.reports,
      visits: visits ?? this.visits,
      referrals: referrals ?? this.referrals,
      affPayments: affPayments ?? this.affPayments,
      isOwner: isOwner ?? this.isOwner,
      isLiked: isLiked ?? this.isLiked,
      isBlocked: isBlocked ?? this.isBlocked,
      isFavorite: isFavorite ?? this.isFavorite,
      likesCount: likesCount ?? this.likesCount,
      visitsCount: visitsCount ?? this.visitsCount,
      rewardDailyCredit: rewardDailyCredit ?? this.rewardDailyCredit,
      lockProVideo: lockProVideo ?? this.lockProVideo,
      lockPrivatePhoto: lockPrivatePhoto ?? this.lockPrivatePhoto,
      okru: okru ?? this.okru,
      mailru: mailru ?? this.mailru,
      discord: discord ?? this.discord,
      wechat: wechat ?? this.wechat,
      qq: qq ?? this.qq,
      ccPhoneNumber: ccPhoneNumber ?? this.ccPhoneNumber,
      zip: zip ?? this.zip,
      state: state ?? this.state,
      conversationId: conversationId ?? this.conversationId,
      infoFile: infoFile ?? this.infoFile,
      paystackRef: paystackRef ?? this.paystackRef,
      securionpayKey: securionpayKey ?? this.securionpayKey,
      coinbaseHash: coinbaseHash ?? this.coinbaseHash,
      coinbaseCode: coinbaseCode ?? this.coinbaseCode,
      yoomoneyHash: yoomoneyHash ?? this.yoomoneyHash,
      coinpaymentsTxnId: coinpaymentsTxnId ?? this.coinpaymentsTxnId,
      fortumoHash: fortumoHash ?? this.fortumoHash,
      ngeniusRef: ngeniusRef ?? this.ngeniusRef,
      aamarpayTranId: aamarpayTranId ?? this.aamarpayTranId,
      proIcon: proIcon ?? this.proIcon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        verifiedFinal,
        fullName,
        countryTxt,
        fullPhoneNumber,
        webToken,
        password,
        age,
        profileCompletion,
        profileCompletionMissing,
        avater,
        username,
        email,
        firstName,
        lastName,
        address
      ];

  factory UserInfoEntity.empty() {
    return UserInfoEntity(
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
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'verifiedFinal': verifiedFinal,
      'fullName': fullName,
      'countryTxt': countryTxt,
      'fullPhoneNumber': fullPhoneNumber,
      'webToken': webToken,
      'password': password,
      'age': age,
      'profileCompletion': profileCompletion,
      'profileCompletionMissing': profileCompletionMissing,
      'avater': avater,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'gender': gender,
      'genderTxt': genderTxt,
      'facebook': facebook,
      'google': google,
      'twitter': twitter,
      'linkedin': linkedin,
      'website': website,
      'instagram': instagram,
      'webDeviceId': webDeviceId,
      'language': language,
      'languageTxt': languageTxt,
      'emailCode': emailCode,
      'src': src,
      'ipAddress': ipAddress,
      'type': type,
      'phoneNumber': phoneNumber,
      'timezone': timezone,
      'lat': lat,
      'lng': lng,
      'about': about,
      'birthday': birthday,
      'country': country,
      'registered': registered,
      'lastseen': lastseen,
      'smscode': smscode,
      'proTime': proTime,
      'lastLocationUpdate': lastLocationUpdate,
      'balance': balance,
      'verified': verified,
      'status': status,
      'active': active,
      'admin': admin,
      'startUp': startUp,
      'isPro': isPro,
      'proType': proType,
      'socialLogin': socialLogin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'mobileDeviceId': mobileDeviceId,
      'mobileToken': mobileToken,
      'height': height,
      'heightTxt': heightTxt,
      'hairColor': hairColor,
      'hairColorTxt': hairColorTxt,
      'webTokenCreatedAt': webTokenCreatedAt,
      'mobileTokenCreatedAt': mobileTokenCreatedAt,
      'mobileDevice': mobileDevice,
      'interest': interest,
      'location': location,
      'relationship': relationship,
      'relationshipTxt': relationshipTxt,
      'workStatus': workStatus,
      'workStatusTxt': workStatusTxt,
      'education': education,
      'educationTxt': educationTxt,
      'ethnicity': ethnicity,
      'ethnicityTxt': ethnicityTxt,
      'body': body,
      'bodyTxt': bodyTxt,
      'character': character,
      'characterTxt': characterTxt,
      'children': children,
      'childrenTxt': childrenTxt,
      'friends': friends,
      'friendsTxt': friendsTxt,
      'pets': pets,
      'petsTxt': petsTxt,
      'liveWith': liveWith,
      'liveWithTxt': liveWithTxt,
      'car': car,
      'carTxt': carTxt,
      'religion': religion,
      'religionTxt': religionTxt,
      'smoke': smoke,
      'smokeTxt': smokeTxt,
      'drink': drink,
      'drinkTxt': drinkTxt,
      'travel': travel,
      'travelTxt': travelTxt,
      'music': music,
      'dish': dish,
      'song': song,
      'hobby': hobby,
      'city': city,
      'sport': sport,
      'book': book,
      'movie': movie,
      'colour': colour,
      'tv': tv,
      'privacyShowProfileOnGoogle': privacyShowProfileOnGoogle,
      'privacyShowProfileRandomUsers': privacyShowProfileRandomUsers,
      'privacyShowProfileMatchProfiles': privacyShowProfileMatchProfiles,
      'emailOnProfileView': emailOnProfileView,
      'emailOnNewMessage': emailOnNewMessage,
      'emailOnProfileLike': emailOnProfileLike,
      'emailOnPurchaseNotifications': emailOnPurchaseNotifications,
      'emailOnSpecialOffers': emailOnSpecialOffers,
      'emailOnAnnouncements': emailOnAnnouncements,
      'phoneVerified': phoneVerified,
      'online': online,
      'isBoosted': isBoosted,
      'boostedTime': boostedTime,
      'isBuyStickers': isBuyStickers,
      'userBuyXvisits': userBuyXvisits,
      'xvisitsCreatedAt': xvisitsCreatedAt,
      'userBuyXmatches': userBuyXmatches,
      'xmatchesCreatedAt': xmatchesCreatedAt,
      'userBuyXlikes': userBuyXlikes,
      'xlikesCreatedAt': xlikesCreatedAt,
      'showMeTo': showMeTo,
      'emailOnGetGift': emailOnGetGift,
      'emailOnGotNewMatch': emailOnGotNewMatch,
      'emailOnChatRequest': emailOnChatRequest,
      'lastEmailSent': lastEmailSent,
      'approvedAt': approvedAt,
      'snapshot': snapshot,
      'hotCount': hotCount,
      'spamWarning': spamWarning,
      'activationRequestCount': activationRequestCount,
      'lastActivationRequest': lastActivationRequest,
      'twoFactor': twoFactor,
      'twoFactorVerified': twoFactorVerified,
      'twoFactorEmailCode': twoFactorEmailCode,
      'newEmail': newEmail,
      'newPhone': newPhone,
      'permission': permission,
      'referrer': referrer,
      'affBalance': affBalance,
      'paypalEmail': paypalEmail,
      'confirmFollowers': confirmFollowers,
      'lastseenTxt': lastseenTxt,
      'lastseenDate': lastseenDate,
      'mediafiles': mediafiles.map((x) => x.toMap()).toList(),
      'isFriendRequest': isFriendRequest,
      'isFriend': isFriend,
      'likes': likes.map((x) => x.toMap()).toList(),
      'blocks': blocks.map((x) => x.toMap()).toList(),
      'payments': payments.map((x) => x.toMap()).toList(),
      'reports': reports.map((x) => x.toMap()).toList(),
      'visits': visits.map((x) => x.toMap()).toList(),
      'referrals': referrals.map((x) => x.toMap()).toList(),
      'affPayments': affPayments.map((x) => x.toMap()).toList(),
      'isOwner': isOwner,
      'isLiked': isLiked,
      'isBlocked': isBlocked,
      'isFavorite': isFavorite,
      'likesCount': likesCount,
      'visitsCount': visitsCount,
      'rewardDailyCredit': rewardDailyCredit,
      'lockProVideo': lockProVideo,
      'lockPrivatePhoto': lockPrivatePhoto,
      'okru': okru,
      'mailru': mailru,
      'discord': discord,
      'wechat': wechat,
      'qq': qq,
      'ccPhoneNumber': ccPhoneNumber,
      'zip': zip,
      'state': state,
      'conversationId': conversationId,
      'infoFile': infoFile,
      'paystackRef': paystackRef,
      'securionpayKey': securionpayKey,
      'coinbaseHash': coinbaseHash,
      'coinbaseCode': coinbaseCode,
      'yoomoneyHash': yoomoneyHash,
      'coinpaymentsTxnId': coinpaymentsTxnId,
      'fortumoHash': fortumoHash,
      'ngeniusRef': ngeniusRef,
      'aamarpayTranId': aamarpayTranId,
      'proIcon': proIcon,
    };
  }

  factory UserInfoEntity.fromMap(Map<String, dynamic> map) {
    return UserInfoEntity(
      id: numV(map['id']) ?? 0,
      verifiedFinal: boolV(map['verified_final']),
      fullName: stringV(map['full_name']),
      countryTxt: stringV(map['country_txt']),
      fullPhoneNumber: stringV(map['full_phone_number']),
      webToken: stringV(map['web_token']),
      password: stringV(map['password']),
      age: stringV(map['age']),
      profileCompletion: stringV(map['profile_completion']),
      profileCompletionMissing: List<String>.from(
        (map['profileCompletionMissing'] as List),
      ),
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
          : List<MediaFileEntity>.from(
              (map['mediafiles'] as List).map<MediaFileEntity>(
                (x) => MediaFileEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      isFriendRequest: boolV(map['is_friend_request']),
      isFriend: boolV(map['is_friend']),
      likes: map['likes'] is! List
          ? []
          : List<LikeEntity>.from(
              (map['likes'] as List).map<LikeEntity>(
                (x) => LikeEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      blocks: map['blocks'] is! List
          ? []
          : List<BlockEntity>.from(
              (map['blocks'] as List).map<BlockEntity>(
                (x) => BlockEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      payments: map['payments'] is! List
          ? []
          : List<PaymentEntity>.from(
              (map['payments'] as List).map<PaymentEntity>(
                (x) => PaymentEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      reports: map['reports'] is! List
          ? []
          : List<ReportEntity>.from(
              (map['reports'] as List).map<ReportEntity>(
                (x) => ReportEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      visits: map['visits'] is! List
          ? []
          : List<VisitEntity>.from(
              (map['visits'] as List).map<VisitEntity>(
                (x) => VisitEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      referrals: map['referrals'] is! List
          ? []
          : List<UserInfoEntity>.from(
              (map['referrals'] as List).map<UserInfoEntity>(
                (x) => UserInfoEntity.fromMap(x as Map<String, dynamic>),
              ),
            ),
      affPayments: map['aff_payments'] is! List
          ? []
          : List<AffPaymentEntity>.from(
              (map['aff_payments'] as List).map<AffPaymentEntity>(
                (x) => AffPaymentEntity.fromMap(x as Map<String, dynamic>),
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

  String toJson() => json.encode(toMap());

  factory UserInfoEntity.fromJson(String source) =>
      UserInfoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserInfoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.verifiedFinal == verifiedFinal &&
        other.fullName == fullName &&
        other.countryTxt == countryTxt &&
        other.fullPhoneNumber == fullPhoneNumber &&
        other.webToken == webToken &&
        other.password == password &&
        other.age == age &&
        other.profileCompletion == profileCompletion &&
        listEquals(other.profileCompletionMissing, profileCompletionMissing) &&
        other.avater == avater &&
        other.username == username &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.address == address &&
        other.gender == gender &&
        other.genderTxt == genderTxt &&
        other.facebook == facebook &&
        other.google == google &&
        other.twitter == twitter &&
        other.linkedin == linkedin &&
        other.website == website &&
        other.instagram == instagram &&
        other.webDeviceId == webDeviceId &&
        other.language == language &&
        other.languageTxt == languageTxt &&
        other.emailCode == emailCode &&
        other.src == src &&
        other.ipAddress == ipAddress &&
        other.type == type &&
        other.phoneNumber == phoneNumber &&
        other.timezone == timezone &&
        other.lat == lat &&
        other.lng == lng &&
        other.about == about &&
        other.birthday == birthday &&
        other.country == country &&
        other.registered == registered &&
        other.lastseen == lastseen &&
        other.smscode == smscode &&
        other.proTime == proTime &&
        other.lastLocationUpdate == lastLocationUpdate &&
        other.balance == balance &&
        other.verified == verified &&
        other.status == status &&
        other.active == active &&
        other.admin == admin &&
        other.startUp == startUp &&
        other.isPro == isPro &&
        other.proType == proType &&
        other.socialLogin == socialLogin &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.mobileDeviceId == mobileDeviceId &&
        other.mobileToken == mobileToken &&
        other.height == height &&
        other.heightTxt == heightTxt &&
        other.hairColor == hairColor &&
        other.hairColorTxt == hairColorTxt &&
        other.webTokenCreatedAt == webTokenCreatedAt &&
        other.mobileTokenCreatedAt == mobileTokenCreatedAt &&
        other.mobileDevice == mobileDevice &&
        other.interest == interest &&
        other.location == location &&
        other.relationship == relationship &&
        other.relationshipTxt == relationshipTxt &&
        other.workStatus == workStatus &&
        other.workStatusTxt == workStatusTxt &&
        other.education == education &&
        other.educationTxt == educationTxt &&
        other.ethnicity == ethnicity &&
        other.ethnicityTxt == ethnicityTxt &&
        other.body == body &&
        other.bodyTxt == bodyTxt &&
        other.character == character &&
        other.characterTxt == characterTxt &&
        other.children == children &&
        other.childrenTxt == childrenTxt &&
        other.friends == friends &&
        other.friendsTxt == friendsTxt &&
        other.pets == pets &&
        other.petsTxt == petsTxt &&
        other.liveWith == liveWith &&
        other.liveWithTxt == liveWithTxt &&
        other.car == car &&
        other.carTxt == carTxt &&
        other.religion == religion &&
        other.religionTxt == religionTxt &&
        other.smoke == smoke &&
        other.smokeTxt == smokeTxt &&
        other.drink == drink &&
        other.drinkTxt == drinkTxt &&
        other.travel == travel &&
        other.travelTxt == travelTxt &&
        other.music == music &&
        other.dish == dish &&
        other.song == song &&
        other.hobby == hobby &&
        other.city == city &&
        other.sport == sport &&
        other.book == book &&
        other.movie == movie &&
        other.colour == colour &&
        other.tv == tv &&
        other.privacyShowProfileOnGoogle == privacyShowProfileOnGoogle &&
        other.privacyShowProfileRandomUsers == privacyShowProfileRandomUsers &&
        other.privacyShowProfileMatchProfiles ==
            privacyShowProfileMatchProfiles &&
        other.emailOnProfileView == emailOnProfileView &&
        other.emailOnNewMessage == emailOnNewMessage &&
        other.emailOnProfileLike == emailOnProfileLike &&
        other.emailOnPurchaseNotifications == emailOnPurchaseNotifications &&
        other.emailOnSpecialOffers == emailOnSpecialOffers &&
        other.emailOnAnnouncements == emailOnAnnouncements &&
        other.phoneVerified == phoneVerified &&
        other.online == online &&
        other.isBoosted == isBoosted &&
        other.boostedTime == boostedTime &&
        other.isBuyStickers == isBuyStickers &&
        other.userBuyXvisits == userBuyXvisits &&
        other.xvisitsCreatedAt == xvisitsCreatedAt &&
        other.userBuyXmatches == userBuyXmatches &&
        other.xmatchesCreatedAt == xmatchesCreatedAt &&
        other.userBuyXlikes == userBuyXlikes &&
        other.xlikesCreatedAt == xlikesCreatedAt &&
        other.showMeTo == showMeTo &&
        other.emailOnGetGift == emailOnGetGift &&
        other.emailOnGotNewMatch == emailOnGotNewMatch &&
        other.emailOnChatRequest == emailOnChatRequest &&
        other.lastEmailSent == lastEmailSent &&
        other.approvedAt == approvedAt &&
        other.snapshot == snapshot &&
        other.hotCount == hotCount &&
        other.spamWarning == spamWarning &&
        other.activationRequestCount == activationRequestCount &&
        other.lastActivationRequest == lastActivationRequest &&
        other.twoFactor == twoFactor &&
        other.twoFactorVerified == twoFactorVerified &&
        other.twoFactorEmailCode == twoFactorEmailCode &&
        other.newEmail == newEmail &&
        other.newPhone == newPhone &&
        other.permission == permission &&
        other.referrer == referrer &&
        other.affBalance == affBalance &&
        other.paypalEmail == paypalEmail &&
        other.confirmFollowers == confirmFollowers &&
        other.lastseenTxt == lastseenTxt &&
        other.lastseenDate == lastseenDate &&
        listEquals(other.mediafiles, mediafiles) &&
        other.isFriendRequest == isFriendRequest &&
        other.isFriend == isFriend &&
        listEquals(other.likes, likes) &&
        listEquals(other.blocks, blocks) &&
        listEquals(other.payments, payments) &&
        listEquals(other.reports, reports) &&
        listEquals(other.visits, visits) &&
        listEquals(other.referrals, referrals) &&
        listEquals(other.affPayments, affPayments) &&
        other.isOwner == isOwner &&
        other.isLiked == isLiked &&
        other.isBlocked == isBlocked &&
        other.isFavorite == isFavorite &&
        other.likesCount == likesCount &&
        other.visitsCount == visitsCount &&
        other.rewardDailyCredit == rewardDailyCredit &&
        other.lockProVideo == lockProVideo &&
        other.lockPrivatePhoto == lockPrivatePhoto &&
        other.okru == okru &&
        other.mailru == mailru &&
        other.discord == discord &&
        other.wechat == wechat &&
        other.qq == qq &&
        other.ccPhoneNumber == ccPhoneNumber &&
        other.zip == zip &&
        other.state == state &&
        other.conversationId == conversationId &&
        other.infoFile == infoFile &&
        other.paystackRef == paystackRef &&
        other.securionpayKey == securionpayKey &&
        other.coinbaseHash == coinbaseHash &&
        other.coinbaseCode == coinbaseCode &&
        other.yoomoneyHash == yoomoneyHash &&
        other.coinpaymentsTxnId == coinpaymentsTxnId &&
        other.fortumoHash == fortumoHash &&
        other.ngeniusRef == ngeniusRef &&
        other.aamarpayTranId == aamarpayTranId &&
        other.proIcon == proIcon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        verifiedFinal.hashCode ^
        fullName.hashCode ^
        countryTxt.hashCode ^
        fullPhoneNumber.hashCode ^
        webToken.hashCode ^
        password.hashCode ^
        age.hashCode ^
        profileCompletion.hashCode ^
        profileCompletionMissing.hashCode ^
        avater.hashCode ^
        username.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        address.hashCode ^
        gender.hashCode ^
        genderTxt.hashCode ^
        facebook.hashCode ^
        google.hashCode ^
        twitter.hashCode ^
        linkedin.hashCode ^
        website.hashCode ^
        instagram.hashCode ^
        webDeviceId.hashCode ^
        language.hashCode ^
        languageTxt.hashCode ^
        emailCode.hashCode ^
        src.hashCode ^
        ipAddress.hashCode ^
        type.hashCode ^
        phoneNumber.hashCode ^
        timezone.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        about.hashCode ^
        birthday.hashCode ^
        country.hashCode ^
        registered.hashCode ^
        lastseen.hashCode ^
        smscode.hashCode ^
        proTime.hashCode ^
        lastLocationUpdate.hashCode ^
        balance.hashCode ^
        verified.hashCode ^
        status.hashCode ^
        active.hashCode ^
        admin.hashCode ^
        startUp.hashCode ^
        isPro.hashCode ^
        proType.hashCode ^
        socialLogin.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        mobileDeviceId.hashCode ^
        mobileToken.hashCode ^
        height.hashCode ^
        heightTxt.hashCode ^
        hairColor.hashCode ^
        hairColorTxt.hashCode ^
        webTokenCreatedAt.hashCode ^
        mobileTokenCreatedAt.hashCode ^
        mobileDevice.hashCode ^
        interest.hashCode ^
        location.hashCode ^
        relationship.hashCode ^
        relationshipTxt.hashCode ^
        workStatus.hashCode ^
        workStatusTxt.hashCode ^
        education.hashCode ^
        educationTxt.hashCode ^
        ethnicity.hashCode ^
        ethnicityTxt.hashCode ^
        body.hashCode ^
        bodyTxt.hashCode ^
        character.hashCode ^
        characterTxt.hashCode ^
        children.hashCode ^
        childrenTxt.hashCode ^
        friends.hashCode ^
        friendsTxt.hashCode ^
        pets.hashCode ^
        petsTxt.hashCode ^
        liveWith.hashCode ^
        liveWithTxt.hashCode ^
        car.hashCode ^
        carTxt.hashCode ^
        religion.hashCode ^
        religionTxt.hashCode ^
        smoke.hashCode ^
        smokeTxt.hashCode ^
        drink.hashCode ^
        drinkTxt.hashCode ^
        travel.hashCode ^
        travelTxt.hashCode ^
        music.hashCode ^
        dish.hashCode ^
        song.hashCode ^
        hobby.hashCode ^
        city.hashCode ^
        sport.hashCode ^
        book.hashCode ^
        movie.hashCode ^
        colour.hashCode ^
        tv.hashCode ^
        privacyShowProfileOnGoogle.hashCode ^
        privacyShowProfileRandomUsers.hashCode ^
        privacyShowProfileMatchProfiles.hashCode ^
        emailOnProfileView.hashCode ^
        emailOnNewMessage.hashCode ^
        emailOnProfileLike.hashCode ^
        emailOnPurchaseNotifications.hashCode ^
        emailOnSpecialOffers.hashCode ^
        emailOnAnnouncements.hashCode ^
        phoneVerified.hashCode ^
        online.hashCode ^
        isBoosted.hashCode ^
        boostedTime.hashCode ^
        isBuyStickers.hashCode ^
        userBuyXvisits.hashCode ^
        xvisitsCreatedAt.hashCode ^
        userBuyXmatches.hashCode ^
        xmatchesCreatedAt.hashCode ^
        userBuyXlikes.hashCode ^
        xlikesCreatedAt.hashCode ^
        showMeTo.hashCode ^
        emailOnGetGift.hashCode ^
        emailOnGotNewMatch.hashCode ^
        emailOnChatRequest.hashCode ^
        lastEmailSent.hashCode ^
        approvedAt.hashCode ^
        snapshot.hashCode ^
        hotCount.hashCode ^
        spamWarning.hashCode ^
        activationRequestCount.hashCode ^
        lastActivationRequest.hashCode ^
        twoFactor.hashCode ^
        twoFactorVerified.hashCode ^
        twoFactorEmailCode.hashCode ^
        newEmail.hashCode ^
        newPhone.hashCode ^
        permission.hashCode ^
        referrer.hashCode ^
        affBalance.hashCode ^
        paypalEmail.hashCode ^
        confirmFollowers.hashCode ^
        lastseenTxt.hashCode ^
        lastseenDate.hashCode ^
        mediafiles.hashCode ^
        isFriendRequest.hashCode ^
        isFriend.hashCode ^
        likes.hashCode ^
        blocks.hashCode ^
        payments.hashCode ^
        reports.hashCode ^
        visits.hashCode ^
        referrals.hashCode ^
        affPayments.hashCode ^
        isOwner.hashCode ^
        isLiked.hashCode ^
        isBlocked.hashCode ^
        isFavorite.hashCode ^
        likesCount.hashCode ^
        visitsCount.hashCode ^
        rewardDailyCredit.hashCode ^
        lockProVideo.hashCode ^
        lockPrivatePhoto.hashCode ^
        okru.hashCode ^
        mailru.hashCode ^
        discord.hashCode ^
        wechat.hashCode ^
        qq.hashCode ^
        ccPhoneNumber.hashCode ^
        zip.hashCode ^
        state.hashCode ^
        conversationId.hashCode ^
        infoFile.hashCode ^
        paystackRef.hashCode ^
        securionpayKey.hashCode ^
        coinbaseHash.hashCode ^
        coinbaseCode.hashCode ^
        yoomoneyHash.hashCode ^
        coinpaymentsTxnId.hashCode ^
        fortumoHash.hashCode ^
        ngeniusRef.hashCode ^
        aamarpayTranId.hashCode ^
        proIcon.hashCode;
  }
}

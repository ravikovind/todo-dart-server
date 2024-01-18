import 'package:client/core/environments/environment.dart';

/*
Core Application
*/
const kAppName = 'client';
const kUser = 'kUser';
const kPassword = 'kPassword';
const kToken = 'kToken-client-X';

/*
API & HTTP
*/
const kURL = '$kHTTPScheme://$kBaseURL$kAPIPath$kAPIVersion';
const kUserPath = '/user';

/*
Community
*/
const kCommunityPath = '/community';
const kCommunityCreatePath = '/create';
const kCommunityUpdatePath = '/update';
const kCommunityJoinPath = '/join';
const kCommunityAcceptPath = '/accept';
const kCommunityRejectPath = '/reject';
const kCommunityLeavePath = '/leave';
const kCommunitiesPath = '/communities';
const kNearByCommunitiesPath = '/near-by';
const kRequestsFromPath = '/requests-from';
const kRequestsToPath = '/requests-to';
const kRequestToJoinPath = '/request';
const kRequestToJoinAcceptPath = '/accept-request';
const kRequestToJoinRejectPath = '/reject-request';

/*
Route
*/

const kRoutePath = '/route';

const kRouteCreatePath = '/create';
const kRouteUpdatePath = '/update';

const kRoutesPath = '/routes';
const kUpcomingPath = '/upcoming';
const kOngoingPath = '/ongoing';
const kCompletedPath = '/completed';

const kNearByPath = '/near-by';
const kRoutesByQueryPath = '/routes-by-query';

const kInvitesPath = '/invites';
const kAcceptPath = '/accept';
const kRejectPath = '/reject';

const kStartPath = '/start';
const kCompletePath = '/complete';
const kCancelPath = '/cancel';
const kRemoveMemberPath = '/remove';

const kRatingsPath = '/ratings';
const kRatePath = '/rate';

/*
Auth
*/
const kSignUpPath = '/sign-up';
const kSignInPath = '/sign-in';
const kAuthPath = '/auth';

/*
Contacts & Users
*/
const kContactsPath = '/contacts';
const kContactRequestsPath = '$kContactsPath/requests';
const kAddContactPath = '$kContactsPath/add';
const kRemoveContactPath = '$kContactsPath/remove';
const kSearchPath = '/search';
const kNotificationsPath = '/notifications';
const kReadNotificationsPath = '/read-notifications';
const kUpdatePath = '/update';
const kDevicePath = '/device';

const days = <String>[
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday',
  'sunday',
];

const weekDays = <String>[
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
];

const weekendDays = <String>[
  'saturday',
  'sunday',
];

const daysVsType = <String, List<String>>{
  'Daily': days,
  'Weekdays': weekDays,
  'Weekends': weekendDays,
};

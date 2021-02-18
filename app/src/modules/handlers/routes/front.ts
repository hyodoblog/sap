export default class {
  top = '/'

  // room
  rooms = '/rooms'
  roomNew = '/rooms/new'
  roomDashboard = (roomUid: string) => `/rooms/${roomUid}/dashboard`
  roomDashboardMatching = (roomUid: string) => `/rooms/${roomUid}/dashboard/matching`
  roomDashboardVoting = (roomUid: string) => `/rooms/${roomUid}/dashboard/voting`
  roomVoting = (roomUid: string) => `/rooms/${roomUid}/voting`
  roomMatching = (roomUid: string) => `/rooms/${roomUid}/matching`
  roomEdit = (roomUid: string) => `/rooms/${roomUid}/edit`

  // auth
  signin = '/auth/signin'
  signup = '/auth/signup'
  verifyEmail = '/auth/verify-email'
  forgotPassword = '/auth/forgot-password'
  resetPassword = '/auth/reset-password'
}

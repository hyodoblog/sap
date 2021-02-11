export default class {
  top = '/'

  // room
  rooms = '/rooms'
  roomNew = '/rooms/new'
  room = (roomUid: string) => `/rooms/${roomUid}/dashboard`
  roomVoting = (roomUid: string) => `/rooms/${roomUid}/voting`
  roomEdit = (roomUid: string) => `/rooms/${roomUid}/edit`

  // auth
  signin = '/auth/signin'
  signup = '/auth/signup'
  verifyEmail = '/auth/verify-email'
  forgotPassword = '/auth/forgot-password'
  resetPassword = '/auth/reset-password'
}

export default class {
  top = '/'

  // dashboard
  rooms = '/rooms'
  room = (roomUid: string) => `/rooms/${roomUid}`
  roomNew = '/rooms/new'

  // auth
  signin = '/auth/signin'
  signup = '/auth/signup'
  verifyEmail = '/auth/verify-email'
  forgotPassword = '/auth/forgot-password'
  resetPassword = '/auth/reset-password'
}

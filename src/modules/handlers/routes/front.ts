export default class {
  top = '/'

  // dashboard
  sapApps = '/sap-apps'
  sapApp = (sapUid: string) => `/sap-apps/${sapUid}`
  sapAppNew = '/sap-apps/new'

  // auth
  signin = '/auth/signin'
  signup = '/auth/signup'
  verifyEmail = '/auth/verify-email'
  forgotPassword = '/auth/forgot-password'
  resetPassword = '/auth/reset-password'
}

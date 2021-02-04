// *******************
// cookie

import { SapApp } from './models'

export interface ApiCreateCookieReqParams {
  token: string
}

export interface ApiCreateCookieResParams {
  token: string
}

export interface ApiVerifyCookieReqParams {
  sessionCookie: string
}

export interface ApiCreateSapAppReqParams {
  sapAppUid: string
  sapAppItem: SapApp
}

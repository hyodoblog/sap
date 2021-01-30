// *******************
// cookie

export interface ApiCreateCookieReqParams {
  token: string
}

export interface ApiCreateCookieResParams {
  token: string
}

export interface ApiVerifyCookieReqParams {
  sessionCookie: string
}

// export interface ApiVerifyCookieResParams {
//   config: PublicConfig
// }

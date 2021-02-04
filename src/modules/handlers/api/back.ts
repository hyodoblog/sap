import { NuxtAxiosInstance } from '@nuxtjs/axios'
import BackRoutesHandler from '../routes/back'
import { AxiosApi } from './axios'
import { ApiCreateCookieReqParams, ApiCreateCookieResParams, ApiVerifyCookieReqParams } from '~/modules/types/api'

export class BackApi extends AxiosApi {
  private backRoutes: BackRoutesHandler

  constructor(axios: NuxtAxiosInstance) {
    super(axios)
    this.backRoutes = new BackRoutesHandler()
  }

  // cookie

  public async createCookie(params: ApiCreateCookieReqParams, headers: any): Promise<ApiCreateCookieResParams> {
    const res = await this.axios.post(this.backRoutes.createCookie, params, { headers })
    const resData = res.data as ApiCreateCookieResParams
    return resData
  }

  public async verifyCookie(params: ApiVerifyCookieReqParams): Promise<void> {
    await this.axios.post(this.backRoutes.verifyCookie, params)
  }
}
import { NuxtAxiosInstance } from '@nuxtjs/axios'
import BackRoutesHandler from '../routes/back'
import { AxiosApi } from './axios'
import {
  ApiCreateCookieReqParams,
  ApiCreateCookieResParams,
  ApiCreateRoomReqParams,
  ApiDeleteRoomReqParams,
  ApiUpdateRoomReqParams,
  ApiVerifyCookieReqParams,
  ApiVerifyCookieResParams,
} from '~/modules/types/api'

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

  public async verifyCookie(params: ApiVerifyCookieReqParams): Promise<ApiVerifyCookieResParams> {
    const res = await this.axios.post(this.backRoutes.verifyCookie, params)
    const resData = res.data as ApiVerifyCookieResParams
    if (!resData.user) throw Error
    return resData
  }

  // room

  public async createRoom(params: ApiCreateRoomReqParams, headers: any) {
    await this.axios.post(this.backRoutes.createRoom, params, { headers })
  }

  public async updateRoom(params: ApiUpdateRoomReqParams, headers: any) {
    await this.axios.post(this.backRoutes.updateRoom, params, { headers })
  }

  public async deleteRoom(params: ApiDeleteRoomReqParams, headers: any) {
    await this.axios.delete(this.backRoutes.deleteRoom, { headers, params })
  }
}

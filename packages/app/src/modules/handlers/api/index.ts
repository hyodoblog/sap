import { NuxtAxiosInstance } from '@nuxtjs/axios'
import { BackApi } from './back'

export class ApiHandlers {
  public readonly back: BackApi

  constructor(axios: NuxtAxiosInstance) {
    this.back = new BackApi(axios)
  }
}

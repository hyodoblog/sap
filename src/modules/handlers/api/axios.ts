import { NuxtAxiosInstance } from '@nuxtjs/axios'

export class AxiosApi {
  public axios: NuxtAxiosInstance

  constructor(axios: NuxtAxiosInstance) {
    this.axios = axios
  }
}

import { NuxtAxiosInstance } from '@nuxtjs/axios'
import { BackApi } from '~/modules/handlers/api/back'

export interface ApiApi {
  back: BackApi
}

export default function ({ $axios }: { $axios: NuxtAxiosInstance }, inject: (arg0: string, arg1: ApiApi) => void) {
  const apis: ApiApi = {
    back: new BackApi($axios),
  }

  inject('api', apis)
}

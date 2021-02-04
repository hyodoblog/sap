import { UrlUtil } from '~/modules/handlers/utils/url'

export interface UtilsApi {
  url: UrlUtil
}

export default function (_: any, inject: (arg0: string, arg1: UtilsApi) => void) {
  const utils: UtilsApi = {
    url: new UrlUtil(),
  }

  inject('utils', utils)
}

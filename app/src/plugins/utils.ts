import { UrlUtil } from 'app/src/modules/handlers/utils/url'
import { UtilityUtil } from 'app/src/modules/handlers/utils/utility'

export interface UtilsApi {
  url: UrlUtil
  utility: UtilityUtil
}

export default function (_: any, inject: (arg0: string, arg1: UtilsApi) => void) {
  const utils: UtilsApi = {
    url: new UrlUtil(),
    utility: new UtilityUtil(),
  }

  inject('utils', utils)
}

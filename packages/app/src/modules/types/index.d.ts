import { ApiApi } from '~/plugins/api'
import { FirebaseApi } from '~/plugins/firebase'
import { FormRulesApi } from '~/plugins/form-rules'
import { RoutesApi } from '~/plugins/routes'
import { UtilsApi } from '~/plugins/utils'

declare module 'vue/types/vue' {
  interface Vue {
    readonly $api: ApiApi
    readonly $fire: FirebaseApi
    readonly $formRules: FormRulesApi
    readonly $routes: RoutesApi
    readonly $utils: UtilsApi
  }
}

declare module '@nuxt/types' {
  interface NuxtAppOptions {
    $api: ApiApi
    $fire: FirebaseApi
    $formRules: FormRulesApi
    $routes: RoutesApi
    $utils: UtilsApi
  }
}

declare module 'vuex' {
  /* eslint no-unused-vars: 0 */
  /* eslint @typescript-eslint/no-unused-vars: 0 */
  interface Store<S> {
    $api: ApiApi
    $fire: FirebaseApi
    $formRules: FormRulesApi
    $routes: RoutesApi
    $utils: UtilsApi
  }
}

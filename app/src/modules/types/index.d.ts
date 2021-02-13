import { ApiApi } from 'app/src/plugins/api'
import { FirebaseApi } from 'app/src/plugins/firebase'
import { FormRulesApi } from 'app/src/plugins/form-rules'
import { RoutesApi } from 'app/src/plugins/routes'
import { UtilsApi } from 'app/src/plugins/utils'

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
  /* eslint @typescript-eslint/no-unused-vars: 0 */
  /* eslint no-unused-vars: 0 */
  interface Store<S> {
    $api: ApiApi
    $fire: FirebaseApi
    $formRules: FormRulesApi
    $routes: RoutesApi
    $utils: UtilsApi
  }
}

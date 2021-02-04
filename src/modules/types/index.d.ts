import { ApiApi } from '~/plugins/api'
import { FirebaseApi } from '~/plugins/firebase'
import { RoutesApi } from '~/plugins/routes'
import { UtilsApi } from '~/plugins/utils'

declare module 'vue/types/vue' {
  interface Vue {
    readonly $api: ApiApi
    readonly $fire: FirebaseApi
    readonly $routes: RoutesApi
    readonly $utils: UtilsApi
  }
}

declare module '@nuxt/types' {
  interface NuxtAppOptions {
    $api: ApiApi
    $fire: FirebaseApi
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
    $routes: RoutesApi
    $utils: UtilsApi
  }
}

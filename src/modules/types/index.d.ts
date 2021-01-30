import { FirebaseApi } from '~/plugins/firebase'
import { RoutesApi } from '~/plugins/routes'

declare module 'vue/types/vue' {
  interface Vue {
    readonly $fire: FirebaseApi
    readonly $routes: RoutesApi
  }
}

declare module '@nuxt/types' {
  interface NuxtAppOptions {
    $fire: FirebaseApi
    $routes: RoutesApi
  }
}

declare module 'vuex' {
  /* eslint @typescript-eslint/no-unused-vars: 0 */
  /* eslint no-unused-vars: 0 */
  interface Store<S> {
    $fire: FirebaseApi
    $routes: RoutesApi
  }
}

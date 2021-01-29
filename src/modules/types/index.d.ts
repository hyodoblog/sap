import { FirebaseApi } from '~/plugins/firebase'

declare module 'vue/types/vue' {
  interface Vue {
    readonly $fire: FirebaseApi
  }
}

declare module '@nuxt/types' {
  interface NuxtAppOptions {
    $fire: FirebaseApi
  }
}

declare module 'vuex' {
  /* eslint @typescript-eslint/no-unused-vars: 0 */
  /* eslint no-unused-vars: 0 */
  interface Store<S> {
    $fire: FirebaseApi
  }
}

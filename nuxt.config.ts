import { NuxtConfig } from '@nuxt/types'

const config: NuxtConfig = {
  srcDir: 'src/',
  head: {
    titleTemplate: '%s - 研究室マッチングシステム',
    title: '研究室マッチングシステム',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },
  css: ['~/assets/styles/common.scss'],
  plugins: [],
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/vuetify'],
  modules: ['@nuxtjs/axios'],
  axios: {},
  vuetify: {
    customVariables: ['~/assets/styles/variables.scss'],
    treeShake: true,
  },
  build: {},
}

export default config

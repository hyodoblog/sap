import { NuxtConfig } from '@nuxt/types'
import * as dotenv from 'dotenv'
dotenv.config()

const port = 3040

const isDev = process.env.NODE_ENV === 'development'

const config: NuxtConfig = {
  srcDir: 'src/',
  head: {
    titleTemplate: '%s - 研究室マッチングシステム',
    title: '研究室マッチングシステム',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      {
        hid: 'description',
        name: 'description',
        content:
          '多くの大学では、大学3年次の末に研究室への配属が行われます。この研究室配属において、学生と研究室の満足度を高める目的で開発されたシステムが当サービス、「研究室マッチングシステム」です。',
      },
      { hid: 'og:site_name', property: 'og:site_name', content: '研究室マッチングシステム' },
      { hid: 'og:type', property: 'og:type', content: 'website' },
      { hid: 'og:url', property: 'og:url', content: 'https://sap.hyodoblog.com/ogp.jpg' },
      { hid: 'og:title', property: 'og:title', content: '研究室マッチングシステム' },
      {
        hid: 'og:description',
        property: 'og:description',
        content:
          '多くの大学では、大学3年次の末に研究室への配属が行われます。この研究室配属において、学生と研究室の満足度を高める目的で開発されたシステムが当サービス、「研究室マッチングシステム」です。',
      },
      { hid: 'og:image', property: 'og:image', content: 'https://sap.hyodoblog.com/ogp.jpg' },
      { hid: 'twitter:card', property: 'twitter:card', content: 'summary_large_image' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },
  css: ['~/assets/styles/theme.scss', '~/assets/styles/common.scss'],
  env: {
    FIREBASE_API_KEY: process.env.FIREBASE_API_KEY as string,
    FIREBASE_AUTH_DOMAIN: process.env.FIREBASE_AUTH_DOMAIN as string,
    FIREBASE_PROJECT_ID: process.env.FIREBASE_PROJECT_ID as string,
    FIREBASE_STORAGE_BUCKET: process.env.FIREBASE_STORAGE_BUCKET as string,
    FIREBASE_MESSAGING_SENDER_ID: process.env.FIREBASE_MESSAGING_SENDER_ID as string,
    FIREBASE_APP_ID: process.env.FIREBASE_APP_ID as string,
    FIREBASE_STORE_ROOT_COLLECTION: process.env.FIREBASE_STORE_ROOT_COLLECTION as string,
    BASE_URL: isDev ? `http://localhost:${port}` : (process.env.BASE_URL as string),
  },
  server: {
    port: isDev ? port : process.env.PORT,
  },
  serverMiddleware: [{ path: '/api', handler: '~/server' }],
  plugins: [
    '~/plugins/api',
    '~/plugins/firebase',
    '~/plugins/routes',
    '~/plugins/form-rules',
    '~/plugins/utils',

    // components
    { src: '~/plugins/components/vue-js-modal', mode: 'client' },
  ],
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/vuetify'],
  modules: [
    '@nuxtjs/axios',
    'cookie-universal-nuxt',
    [
      '@nuxtjs/google-adsense',
      {
        id: process.env.GA_ADSENSE_ID,
        pageLevelAds: true,
        analyticsUacct: process.env.GA_TRACKING_ID,
        analyticsDomainName: 'sap.hyodoblog.com',
      },
    ],
  ],
  axios: {
    baseURL: isDev ? `http://localhost:${port}/api` : `${process.env.BASE_URL}/api`,
  },
  vuetify: {
    customVariables: ['~/assets/styles/vuetify/variables/_index.scss'],
    treeShake: true,
  },
  build: {},
}

export default config

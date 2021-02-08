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
      { hid: 'description', name: 'description', content: '' },
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
  plugins: ['~/plugins/api', '~/plugins/firebase', '~/plugins/routes', '~/plugins/form-rules', '~/plugins/utils'],
  buildModules: ['@nuxt/typescript-build', '@nuxtjs/vuetify'],
  modules: ['@nuxtjs/axios', 'cookie-universal-nuxt'],
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

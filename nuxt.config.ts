import { NuxtConfig } from '@nuxt/types'
import * as dotenv from 'dotenv'
dotenv.config()

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
  env: {
    FIREBASE_API_KEY: process.env.FIREBASE_API_KEY as string,
    FIREBASE_AUTH_DOMAIN: process.env.FIREBASE_AUTH_DOMAIN as string,
    FIREBASE_PROJECT_ID: process.env.FIREBASE_PROJECT_ID as string,
    FIREBASE_STORAGE_BUCKET: process.env.FIREBASE_STORAGE_BUCKET as string,
    FIREBASE_MESSAGING_SENDER_ID: process.env.FIREBASE_MESSAGING_SENDER_ID as string,
    FIREBASE_APP_ID: process.env.FIREBASE_APP_ID as string,
  },
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

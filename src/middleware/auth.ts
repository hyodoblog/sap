import { Middleware } from '@nuxt/types'

const authMiddleware: Middleware = ({ app, redirect, store }) => {
  if (store.getters['auth/isAuthenticated']) {
    redirect(app.$routes.front.dashboard)
  }
}

export default authMiddleware

import { Middleware } from '@nuxt/types'

const authMiddleware: Middleware = ({ app, redirect, store }) => {
  if (store.getters['user/isAuthenticated']) {
    redirect(app.$routes.front.rooms)
  }
}

export default authMiddleware

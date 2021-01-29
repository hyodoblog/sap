import { Middleware } from '@nuxt/types'

const protectedMiddleware: Middleware = ({ app, redirect, store }) => {
  if (!store.getters['auth/isAuthenticated']) {
    redirect(app.$routes.front.signin)
  }
}

export default protectedMiddleware

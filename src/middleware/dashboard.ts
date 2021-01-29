import { Middleware } from '@nuxt/types'

const dashboardMiddleware: Middleware = ({ app, redirect, store }) => {
  if (!store.getters['dashboard/isAuthenticated']) {
    redirect(app.$routes.front.signin)
  }
}

export default dashboardMiddleware

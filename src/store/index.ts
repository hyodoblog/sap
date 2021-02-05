import { ActionTree, GetterTree, MutationTree } from 'vuex'
import jwtDecode from 'jwt-decode'
import { IndexState, RootState } from '~/modules/types/state'
const cookieparser = require('cookieparser')

interface CookieData {
  admin: boolean
  user_id: string
  email: string
}

export const state = () => Object.assign({}, new IndexState())

export const getters: GetterTree<IndexState, RootState> = {
  drawer: (state) => state.drawer,
}

export const mutations: MutationTree<IndexState> = {
  RESET(state) {
    Object.assign(state, new IndexState())
  },

  SET_DRAWER(state, drawer) {
    state.drawer = drawer
  },
}

export const actions: ActionTree<RootState, RootState> = {
  async nuxtServerInit(_, { req }) {
    const sessionCookie = getSessionCookie(req)
    if (sessionCookie) {
      const cookieData = getUserFromCookie(sessionCookie)
      if (cookieData && !this.getters['auth/isAuthenticated']) {
        try {
          const userUid = cookieData.user_id
          const { user } = await this.$api.back.verifyCookie({ sessionCookie, userUid })

          this.commit('auth/SET_USER_UID', userUid)
          this.commit('auth/SET_USER', user)
          // this.commit('config/public/SET', config)
        } catch {}
      }
    }
  },
}

const getSessionCookie = (req: any): string | null => {
  if (process.server && process.static) return null
  if (!req.headers.cookie) return null

  const parsed = cookieparser.parse(req.headers.cookie)
  const token = parsed.session

  if (token) {
    return token
  } else {
    return null
  }
}

const getUserFromCookie = (sessionCookie: string): CookieData | null => {
  const decodedToken = jwtDecode(sessionCookie)
  if (!decodedToken) return null

  return decodedToken as CookieData
}

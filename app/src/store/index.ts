import { ActionTree, MutationTree } from 'vuex'
import jwtDecode from 'jwt-decode'
import { IndexState, RootState } from 'app/src/modules/types/state'
const cookieparser = require('cookieparser')

interface CookieData {
  admin: boolean
  user_id: string
  email: string
}

export const state = () => Object.assign({}, new IndexState())

export const mutations: MutationTree<IndexState> = {
  RESET(state) {
    Object.assign(state, new IndexState())
  },

  SET_DRAWER(state, drawer) {
    state.drawer = drawer
  },

  SET_PUBLIC_DRAWER(state, publicDrawer) {
    state.publicDrawer = publicDrawer
  },
}

export const actions: ActionTree<RootState, RootState> = {
  async nuxtServerInit(_, { req }) {
    try {
      const sessionCookie = getSessionCookie(req)
      if (sessionCookie) {
        const cookieData = getUserFromCookie(sessionCookie)
        if (cookieData && !this.getters['user/isAuthenticated']) {
          const userUid = cookieData.user_id
          const email = cookieData.email
          const { user } = await this.$api.back.verifyCookie({ sessionCookie, userUid, email })

          this.commit('user/SET_UID', userUid)
          this.commit('user/SET_ITEM', user)
        }
      }
    } catch {}
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

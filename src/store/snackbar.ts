import { ActionTree, GetterTree, MutationTree } from 'vuex'
import { RootState, SnackbarState } from '~/modules/types/state'

export const state = () => Object.assign({}, new SnackbarState())

export const getters: GetterTree<SnackbarState, RootState> = {
  isSnackbar: (state) => !!state.text && !!state.color,
}

export const mutations: MutationTree<SnackbarState> = {
  RESET(state) {
    Object.assign(state, new SnackbarState())
  },

  SET(state, { text, color }) {
    state.text = text
    state.color = color
  },
}

export const actions: ActionTree<SnackbarState, RootState> = {
  success({ commit }, text: string) {
    commit('SET', { text, color: 'success' })
  },

  error({ commit }, text: string) {
    commit('SET', { text, color: 'error' })
  },
}

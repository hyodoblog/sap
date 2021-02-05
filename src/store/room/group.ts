import { ActionTree, MutationTree } from 'vuex'
import { Group } from '~/modules/types/models'
import { RoomGroupState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new RoomGroupState())

export const mutations: MutationTree<RoomGroupState> = {
  RESET(state) {
    Object.assign(state, new RoomGroupState())
  },

  SET(state, items: Group[]) {
    state.items = items
  },
}

export const actions: ActionTree<RoomGroupState, RootState> = {
  async init({ commit }, roomUid: string) {
    try {
      const items = await this.$fire.store.group.getItems(roomUid)
      commit('SET', items)
    } catch {
      this.dispatch('snackbar/error', '部屋のグループ情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}

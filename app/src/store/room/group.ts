import { ActionTree, GetterTree, MutationTree } from 'vuex'
import { RoomGroup } from '~/modules/types/models'
import { RoomGroupState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new RoomGroupState())

export const getters: GetterTree<RoomGroupState, RootState> = {
  getIsEmailNum: (state) => state.items.filter((item) => !!item.email).length,
}

export const mutations: MutationTree<RoomGroupState> = {
  RESET(state) {
    Object.assign(state, new RoomGroupState())
  },

  SET(state, items: RoomGroup[]) {
    state.items = items
  },
}

export const actions: ActionTree<RoomGroupState, RootState> = {
  async init({ commit }, roomUid: string) {
    try {
      commit('RESET')
      const items = await this.$fire.store.roomGroup.getItems(roomUid)
      commit('SET', items)
    } catch {
      this.dispatch('snackbar/error', '部屋のグループ情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}

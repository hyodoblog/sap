import { ActionTree, MutationTree } from 'vuex'
import { ParticipateUser } from '~/modules/types/models'
import { RoomParticipateUserState, RootState } from '~/modules/types/state'

export const state = () => Object.assign({}, new RoomParticipateUserState())

export const mutations: MutationTree<RoomParticipateUserState> = {
  RESET(state) {
    Object.assign(state, new RoomParticipateUserState())
  },

  SET(state, items: ParticipateUser[]) {
    state.items = items
  },
}

export const actions: ActionTree<RoomParticipateUserState, RootState> = {
  async init({ commit }, roomUid: string) {
    try {
      const items = await this.$fire.store.participateUser.getItems(roomUid)
      commit('SET', items)
    } catch {
      this.dispatch('snackbar/error', '部屋のグループ情報の初期化に失敗しました。')
      commit('RESET')
    }
  },
}

<template lang="pug">
  v-app
    CorePublicNavigation(:drawerValue.sync="navDrawer")
    v-main.mx-auto(style="width:600px")
      AppBar(:drawerValue.sync="navDrawer")
      nuxt
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { InvitationState } from '~/modules/types/state'

@Component({
  components: {
    AppBar: () => import('~/components/pages/rooms/voting/AppBar.vue'),
    CorePublicNavigation: () => import('~/components/core/PublicNavigation.vue'),
    Snackbar: () => import('~/components/Snackbar.vue'),
  },
})
export default class PublicLayout extends Vue {
  navDrawer = null

  // 招待メールの処理
  async mounted() {
    try {
      const { roomInvitationType, roomUid, loginToken, roomGroupUid, roomParticipateUserUid } = this.$route.query
      if (typeof roomInvitationType === 'string' && typeof roomUid === 'string' && typeof loginToken === 'string') {
        if (roomInvitationType === 'group' && typeof roomGroupUid === 'string') {
          await this.initGroup(roomUid, roomGroupUid, loginToken)
        } else if (roomInvitationType === 'participateUser' && typeof roomParticipateUserUid === 'string') {
          await this.initParticipateUser(roomUid, roomParticipateUserUid, loginToken)
        } else throw Error
      } else throw Error
    } catch {
      this.$nuxt.error({
        statusCode: 404,
      })
    }
  }

  async initGroup(roomUid: string, roomGroupUid: string, loginToken: string) {
    const authItem = await this.$fire.store.roomGroup.getItemToLoginToken(roomUid, roomGroupUid, loginToken)
    this.$store.commit('invitation/SET_AUTH_ITEM', { type: 'group', authItem } as InvitationState)
    await this.$store.dispatch('invitation/initRoom', roomUid)
  }

  async initParticipateUser(roomUid: string, roomParticipateUserUid: string, loginToken: string) {
    const authItem = await this.$fire.store.roomParticipateUser.getItemToLoginToken(
      roomUid,
      roomParticipateUserUid,
      loginToken
    )
    this.$store.commit('invitation/SET_AUTH_ITEM', { type: 'participateUser', authItem } as InvitationState)
    await this.$store.dispatch('invitation/initRoom', roomUid)
  }
}
</script>

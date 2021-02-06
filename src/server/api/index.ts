import { Router } from 'express'
import BackRoutes from '../../modules/handlers/routes/back'

// *******************:
// router

// cookie
import createCookieRouter from './routes/cookie/create'
import verifyCookieRouter from './routes/cookie/verify'

// room
import createRoomRouter from './routes/room/create'
import updateRoomRouter from './routes/room/update'
import deleteRoomRouter from './routes/room/delete'

// invitation
import groupAllInvitationRouter from './routes/invitation/group/all'
import participateUserAllInvitationRouter from './routes/invitation/participate-user/all'
import allInvitationRouter from './routes/invitation/all'

// *******************:

const router = Router()
const backRoutes = new BackRoutes()

// cookie
router.post(backRoutes.createCookie, createCookieRouter)
router.post(backRoutes.verifyCookie, verifyCookieRouter)

// room
router.post(backRoutes.createRoom, createRoomRouter)
router.post(backRoutes.updateRoom, updateRoomRouter)
router.delete(backRoutes.deleteRoom, deleteRoomRouter)

// invitation
router.post(backRoutes.groupAllInvitation, groupAllInvitationRouter)
router.post(backRoutes.participateUserAllInvitation, participateUserAllInvitationRouter)
router.post(backRoutes.allInvitation, allInvitationRouter)

export default router

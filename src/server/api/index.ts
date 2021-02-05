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

// *******************:

const router = Router()
const backRoutes = new BackRoutes()

// cookie
router.post(backRoutes.createCookie, createCookieRouter)
router.post(backRoutes.verifyCookie, verifyCookieRouter)

// room
router.post(backRoutes.createRoom, createRoomRouter)
router.post(backRoutes.updateRoom, updateRoomRouter)

export default router

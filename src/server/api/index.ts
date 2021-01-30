import { Router } from 'express'
import BackRoutes from '../../modules/handlers/routes/back'

// *******************:
// router

// admin
import createCookieRouter from './routes/cookie/create'
import verifyCookieRouter from './routes/cookie/verify'

// *******************:

const router = Router()
const backRoutes = new BackRoutes()

router.post(backRoutes.createCookie, createCookieRouter)
router.post(backRoutes.verifyCookie, verifyCookieRouter)

export default router

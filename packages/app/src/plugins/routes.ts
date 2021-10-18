import FrontHandler from '~/modules/handlers/routes/front'

export interface RoutesApi {
  front: FrontHandler
}

export default function (_: any, inject: (arg0: string, arg1: RoutesApi) => void) {
  const routes: RoutesApi = {
    front: new FrontHandler(),
  }

  inject('routes', routes)
}

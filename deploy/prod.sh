# 環境変数をexport
cp .env.prod ./packages/app/.env
cp .env.prod ./packages/functions/.env

IFS=$'\n'
for env in `cat .env.prod`; do
  export $env
done

# *******************
# functions

cloudFunctions () {
  firebase use sap-app-df10e
  cd packages/functions
  firebase deploy --only functions
}

# *******************
# cloud run

cloudRun () {
  gcloud config set project sap-app-df10e
  docker build --platform linux/amd64 -t sap-app-df10e-prod ./packages/app
  docker tag sap-app-df10e-prod gcr.io/sap-app-df10e/prod
  docker push gcr.io/sap-app-df10e/prod
  gcloud beta run deploy prod \
    --image gcr.io/sap-app-df10e/prod \
    --max-instances 2 \
    --region asia-northeast1 \
    --platform managed \
    --memory 1G \
    --service-account ${GCLOUD_CLIENT_EMAIL} \
    --allow-unauthenticated
}

cloudFunctions & cloudRun
# cloudFunctions
# cloudRun

# 環境変数をexport
cp .env.staging ./app/.env
while read env
do
  export $env
done < .env

cp ./key/development.json ./functions/key/development.json
cp ./key/development.json ./app/key/development.json

# *******************
# functions

cloudFunctions () {
  firebase functions:config:set store.env=${FIREBASE_STORE_ROOT_COLLECTION}
  firebase functions:config:set gcp.service.account.id=${GCLOUD_SERVICE_ACCOUNT_ID}
  firebase deploy --only functions
}

# *******************
# cloud run

cloudRun () {
  gcloud config set project ${FIREBASE_PROJECT_ID}
  docker build -t ${FIREBASE_PROJECT_ID}-staging ./app
  docker tag ${FIREBASE_PROJECT_ID}-staging gcr.io/${FIREBASE_PROJECT_ID}/staging
  docker push gcr.io/${FIREBASE_PROJECT_ID}/staging
  gcloud beta run deploy staging \
    --image gcr.io/${FIREBASE_PROJECT_ID}/staging \
    --max-instances 2 \
    --region asia-northeast1 \
    --platform managed \
    --memory 1G \
    --service-account ${GCLOUD_SERVICE_ACCOUNT_ID} \
    --allow-unauthenticated
}

cloudFunctions & cloudRun
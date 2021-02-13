# 環境変数をexport
cp .env.prod ./app/.env
while read env
do
  export $env
done < .env

cp ./key/production.json ./functions/key/production.json
cp ./key/production.json ./app/key/production.json

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
  docker build -t ${FIREBASE_PROJECT_ID}-prod ./app
  docker tag ${FIREBASE_PROJECT_ID}-prod gcr.io/${FIREBASE_PROJECT_ID}/prod
  docker push gcr.io/${FIREBASE_PROJECT_ID}/prod
  gcloud beta run deploy prod \
    --image gcr.io/${FIREBASE_PROJECT_ID}/prod \
    --max-instances 2 \
    --region asia-northeast1 \
    --platform managed \
    --memory 1G \
    --service-account ${GCLOUD_SERVICE_ACCOUNT_ID} \
    --allow-unauthenticated
}

cloudFunctions & cloudRun

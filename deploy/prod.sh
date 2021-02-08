# 環境変数をexport
cp .env.prod .env
while read env
do
  export $env
done < .env

gcloud config set project ${FIREBASE_PROJECT_ID}
docker build -t ${FIREBASE_PROJECT_ID}-prod .
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

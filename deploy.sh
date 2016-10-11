echo "stopping running application"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker stop dodsv'
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker rm dodsv'

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker pull xarorsa/grafana:latest'

echo "starting the new version"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker run -d --restart=always --name dodsv -p 80:3000 xarorsa/grafana:latest'

echo "success!"

exit 0
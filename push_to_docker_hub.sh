_grafana_tag=$1

if [ -z "${_grafana_tag}" ]; then
	source GRAFANA_VERSION
	_grafana_tag=$GRAFANA_VERSION
	docker push xarorsa/grafana:${_grafana_tag}
	docker push xarorsa/grafana:latest
else
	docker push xarorsa/grafana:${_grafana_tag}
fi

echo "stopping running application"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker stop dodsv'
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker rm dodsv'

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker pull xarorsa/grafana:latest'

echo "starting the new version"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker run -d --restart=always --name dodsv -p 80:3000 xarorsa/grafana:latest'

echo "success!"
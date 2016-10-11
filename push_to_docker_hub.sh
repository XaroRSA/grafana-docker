_grafana_tag=$1

if [ -z "${_grafana_tag}" ]; then
	source GRAFANA_VERSION
	_grafana_tag=$GRAFANA_VERSION
	docker push xarorsa/grafana:${_grafana_tag}
	docker push xarorsa/grafana:latest
else
	docker push xarorsa/grafana:${_grafana_tag}
fi
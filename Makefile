.DEFAULT_GOAL := up

.PHONY: up
up: down
	docker compose -f dev.compose.yaml up --build --detach

.PHONY: down
down:
	docker compose -f dev.compose.yaml down --remove-orphans

.PHONY: query
query:
	docker compose -f dev.compose.yaml exec app mix run -e RemoteAssessment.UserPointsUpdater.query_user_points

.PHONY: test
test:
	docker compose -f test.compose.yaml down --remove-orphans
	docker compose -f test.compose.yaml up -d database

	docker compose -f test.compose.yaml build app
	docker compose -f test.compose.yaml run app mix test --cover || true
	docker compose -f test.compose.yaml down --remove-orphans


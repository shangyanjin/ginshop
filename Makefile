#Basic makefile

default: build

build: clean vet
	@echo "Building application"
	@go build -o goweb-go

doc:
	@godoc -http=:6060 -index

lint:
	@golint ./...

debug_server: 
	@fresh
debug_assets:
	@npm run watch

#run 'make -j2 debug' to launch both servers in parallel
debug: clean debug_server debug_assets 

run: build
	./goweb-go

test:
	@go test ./...

vet:
	@go vet ./...

clean:
	@echo "Cleaning binary"
	@rm -f ./goweb-go

stop: 
	@echo "Stopping goweb_go service"
	@sudo systemctl stop goweb_go

start:
	@echo "Starting goweb_go service"
	@sudo systemctl start goweb_go

pull:
	@echo "Pulling origin"
	@git pull origin master

pull_restart: stop pull clean build start
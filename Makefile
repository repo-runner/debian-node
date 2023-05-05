KORVIKE_VERSION:=v0.7.1

jenkins: build_latest
jenkins: build_20
jenkins: build_18
jenkins: build_16

build_%: korvike
	./korvike \
		-i Dockerfile \
		-o Dockerfile.build \
		-v ver=$*
	docker build \
		-t reporunner/debian-node:$* \
		-f Dockerfile.build .
	docker push \
		reporunner/debian-node:$*

korvike:
	curl -sSfL "https://github.com/Luzifer/korvike/releases/download/$(KORVIKE_VERSION)/korvike_linux_amd64.tar.gz" | tar -xz
	mv korvike_linux_amd64 korvike

# Makefile в вашем сервисе (my-app)
#
# --- Настройки ---
# Название Go-модуля с прото-файлами (Ваш пакет)
PROTOS_MODULE := github.com/WorldzTech/EASProtos

# 1. Получаем путь к модулю в GOPATH/pkg/mod
PROTOS_DIR := $(shell go list -m -f '{{.Dir}}' $(PROTOS_MODULE))

# 2. Список файлов для генерации
# Используем команду find для поиска всех файлов .proto в папке proto внутри модуля
PROTO_FILES := $(shell find $(PROTOS_DIR)/proto -name "*.proto")

# 3. Опции для плагинов
PROTOC_GEN_GO_OPTS := --go_out=. --go_opt=paths=source_relative
PROTOC_GEN_GRPC_OPTS := --go-grpc_out=. --go-grpc_opt=paths=source_relative
# -----------------

.PHONY: generate

generate:
	@echo "-> Generating Protobuf code from $(PROTOS_DIR)"
	
	protoc \
		-I$(PROTOS_DIR) \
		$(PROTOC_GEN_GO_OPTS) \
		$(PROTOC_GEN_GRPC_OPTS) \
		$(PROTO_FILES) # <--- Генерируем все найденные файлы

	@echo "-> Generation complete. Code placed in local directories."
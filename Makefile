.PHONY: build run clean

build:
	@echo "Derleniyor: KAYRA Sistem Cekirdegi (ZIG)..."
	@zig build-exe src/kayra_engine.zig -O ReleaseFast --name kayra_core
	@echo "Derleme Tamamlandi!"

run: build
	@echo "KAYRA Engine Calistiriliyor:"
	@./kayra_core

clean:
	@rm -f kayra_core kayra_core.o

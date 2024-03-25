SRC_DIR := ./scss
OUT_DIR := ./css

SCSS_FILES := $(wildcard $(SRC_DIR)/*.scss)

CSS_FILES := $(patsubst $(SRC_DIR)/%.scss,$(OUT_DIR)/%.css,$(SCSS_FILES))

all: $(CSS_FILES)

$(OUT_DIR)/%.css: $(SRC_DIR)/%.scss
	@echo "compiling: $< -> $@"
	@sass $< $@

clean:
	@echo "delete *.css"
	@rm -f $(OUT_DIR)/*.css

.PHONY: watch

watch:
	@echo "Watching for changes in SCSS files"
	@while inotifywait -qre close_write --exclude '.*\.css' $(SRC_DIR); do \
		make; \
	done
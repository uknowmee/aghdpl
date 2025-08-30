ifeq ($(FEW), true)
	SRC1 := $(wildcard $(INPUT_DIR)/*.md)
	SRC2 := $(wildcard $(INPUT_DIR)/../*.md)
	SRC := $(SRC1) $(SRC2)
else
	SRC := $(wildcard $(INPUT_DIR)/*.md)
endif

PDF := ${OUTPUT_DIR}/${TYPE}-${OUTPUT_FILE_SUFFIX}.pdf

ifeq ($(findstring aghdpl,$(TYPE)),aghdpl)
	PANDOC_FLAGS := --top-level-division=chapter --template=src/${TYPE}/template.latex
else
	PANDOC_FLAGS :=
endif

${PDF}: $(SRC)

	-@cd src/${TYPE} && latexmk -C || echo "Warning: latexmk clean failed"
	-@rm src/${TYPE}/output.* || echo "Warning: failed to remove output.*"
	-@rm src/${TYPE}/*.bib || echo "Warning: failed to remove .bib files"
	-@rm src/${TYPE}/*.pdf || echo "Warning: failed to remove .pdf files"
	-@rm -rf src/${TYPE}/assets/* || echo "Warning: failed to remove assets"

	pandoc -N --standalone \
		--lua-filter src/diagram-generator.lua \
		--lua-filter src/doi2cite.lua \
		-F pandoc-crossref \
		$(SRC) \
		-o src/${TYPE}/output.tex \
		--biblatex \
		$(PANDOC_FLAGS)
	
	-@mv from-doi.bib src/${TYPE}/ || (touch src/${TYPE}/from-doi.bib && echo "Warning: from-doi.bib not found or failed to move, created empty file")
	
	mkdir -p src/${TYPE}/assets
	@if [ "$(FEW)" = "true" ]; then \
		cp ${INPUT_DIR}/../bibliografia.bib src/${TYPE}/ || (touch src/${TYPE}/bibliografia.bib && echo "Warning: failed to copy .bib files, created empty bibliografia.bib"); \
		cp -r ${INPUT_DIR}/assets/* src/${TYPE}/assets/ || echo "Warning: failed to copy assets"; \
		cp -r ${INPUT_DIR}/../assets/* src/${TYPE}/assets/ || echo "Warning: failed to copy assets"; \
	else \
		cp ${INPUT_DIR}/*.bib src/${TYPE}/ || (touch src/${TYPE}/bibliografia.bib && echo "Warning: failed to copy .bib files, created empty bibliografia.bib"); \
		cp -r ${INPUT_DIR}/assets/* src/${TYPE}/assets/ || echo "Warning: failed to copy assets"; \
	fi
	
	cd src/${TYPE} && latexmk -pdf output.tex

	mv src/${TYPE}/output.pdf ${PDF}
	cp ${PDF} ${OUTPUT_DIR}/${TYPE}.pdf

	-@cd src/${TYPE} && latexmk -C || echo "Warning: latexmk clean failed"
	-@rm src/${TYPE}/output.* || echo "Warning: failed to remove output.*"
	-@rm src/${TYPE}/*.bib || echo "Warning: failed to remove .bib files"
	-@rm src/${TYPE}/*.pdf || echo "Warning: failed to remove .pdf files"
	-@rm -rf src/${TYPE}/assets/* || echo "Warning: failed to remove assets"

pdf: ${PDF}

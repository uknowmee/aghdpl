SRC := $(wildcard $(INPUT_DIR)/*.md)
PDF := ${OUTPUT_DIR}/${TYPE}-${OUTPUT_FILE_SUFFIX}.pdf

ifeq ($(TYPE), thesis)
PANDOC_FLAGS := --top-level-division=chapter --template=src/${TYPE}/template.latex
else
PANDOC_FLAGS :=
endif

${PDF}: $(SRC)

	pandoc -N --standalone \
		--lua-filter src/diagram-generator.lua \
		--lua-filter src/doi2cite.lua \
		-F pandoc-crossref \
		$(SRC) \
		-o src/${TYPE}/output.tex \
		--biblatex \
		$(PANDOC_FLAGS)
	
	mv from-doi.bib src/${TYPE}/
	cp ${INPUT_DIR}/*.bib src/${TYPE}/
	
	mkdir -p src/${TYPE}/assets
	-@cp -r ${INPUT_DIR}/assets/* src/${TYPE}/assets/ || echo "Warning: failed to copy assets"
	
	cd src/${TYPE} && latexmk -pdf output.tex

	mv src/${TYPE}/output.pdf ${PDF}
	cp ${PDF} ${OUTPUT_DIR}/${TYPE}.pdf

	-@cd src/${TYPE} && latexmk -C || echo "Warning: latexmk clean failed"
	-@rm src/${TYPE}/output.* || echo "Warning: failed to remove output.*"
	-@rm src/${TYPE}/*.bib || echo "Warning: failed to remove .bib files"
	-@rm src/${TYPE}/*.pdf || echo "Warning: failed to remove .pdf files"
	-@rm src/${TYPE}/assets/* || echo "Warning: failed to remove assets"

pdf: ${PDF}

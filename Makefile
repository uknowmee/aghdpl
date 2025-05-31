SRC := $(wildcard $(INPUT_DIR)/*.md)
PDF := ${OUTPUT_DIR}/${TYPE}-${OUTPUT_FILE_SUFFIX}.pdf

${PDF}: $(SRC) src/${TYPE}/template.latex src/diagram-generator.lua src/doi2cite.lua
	pandoc --lua-filter src/diagram-generator.lua --lua-filter src/doi2cite.lua -F pandoc-crossref $(SRC) -o src/${TYPE}/output.tex --top-level-division=chapter --template=src/${TYPE}/template.latex --biblatex
	
	mv from-doi.bib src/${TYPE}/
	cp ${INPUT_DIR}/*.bib src/${TYPE}/
	
	cd src/${TYPE} && latexmk -pdf output.tex

	mv src/${TYPE}/output.pdf ${PDF}
	cp ${PDF} ${OUTPUT_DIR}/${TYPE}.pdf

	-@cd src/${TYPE} && latexmk -C || echo "Warning: latexmk clean failed"
	-@rm src/${TYPE}/output.* || echo "Warning: failed to remove output.*"
	-@rm src/${TYPE}/*.bib || echo "Warning: failed to remove .bib files"
	-@rm src/${TYPE}/*.pdf || echo "Warning: failed to remove .pdf files"

pdf: ${PDF}

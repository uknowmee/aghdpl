SRC := $(wildcard $(INPUT_DIR)/*.md)
PDF := ${OUTPUT_DIR}/${TYPE}-${OUTPUT_FILE_SUFFIX}.pdf

${PDF}: $(SRC) src/${TYPE}/template.latex src/diagram-generator.lua src/doi2cite.lua
	pandoc --lua-filter src/diagram-generator.lua --lua-filter src/doi2cite.lua -F pandoc-crossref $(SRC) -o src/${TYPE}/output.tex --top-level-division=chapter --template=src/${TYPE}/template.latex --biblatex
	
	mv from-doi.bib src/${TYPE}/
	cp ${INPUT_DIR}/*.bib src/${TYPE}/
	
	cd src/${TYPE} && latexmk -pdf output.tex

	mv src/${TYPE}/output.pdf ${PDF}
	cp ${PDF} ${OUTPUT_DIR}/${TYPE}.pdf

	cd src/${TYPE} && latexmk -C
	rm src/${TYPE}/output.*
	rm src/${TYPE}/*.bib
	rm src/${TYPE}/*.pdf

pdf: ${PDF}

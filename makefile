FILE=prez

$(FILE).pdf: $(FILE).tex ./img/sequence-diagram.svg
	arara $(FILE).tex
	# pdflatex $(FILE).tex

clean:
	find .  -maxdepth 1 -type f -regex '\(.*\.pdf\|.*\.pdf_tex\|.*\.aux\|.*\.log\|.*\.nav\|.*\.out\|.*\.snm\|.*\.toc\)' -delete
	find img  -maxdepth 1 -type f -regex '\(.*\.pdf\|.*\.pdf_tex\)' -delete

refresh: $(FILE).pdf
	pkill -SIGHUP mupdf

upload: $(FILE).pdf
	scp prez.pdf root@martinfranc.eu:/var/www/martinfranc.eu/bp/

./img/sequence-diagram.svg: sequence-diagram.msc ./node_modules/mscgenjs-cli/package.json
	./node_modules/mscgenjs-cli/bin/mscgen_js -i sequence-diagram.msc -o img/sequence-diagram.svg -T svg -s ' .mscgen_js-svg-__svg .bglayer {fill: none;} .mscgen_js-svg-__svg .arrow-style{stroke-width:4;}'

./node_modules/mscgenjs-cli/package.json:
	npm install
	
FILE=prez

$(FILE).pdf: $(FILE).tex
	xelatex -shell-escape -halt-on-error $(FILE).tex
	xelatex -shell-escape -halt-on-error $(FILE).tex

run: $(FILE).pdf
	xdg-open $(FILE).pdf

clean:
	find . -maxdepth 1 -type f -regex '\(.*\.pdf\|.*\.pdf_tex\|.*\.aux\|.*\.log\|.*\.nav\|.*\.out\|.*\.snm\|.*\.toc\)' -delete
	# find img -maxdepth 1 -type f -regex '\(.*\.pdf\|.*\.pdf_tex\)' -delete

refresh: $(FILE).pdf
	pkill -SIGHUP mupdf
	
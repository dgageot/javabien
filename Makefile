server:
	docker build -t dgageot/hugo .
	docker run --rm -it -v $(CURDIR):/sources -p 8080:1313 dgageot/hugo hugo server --disableFastRender --bind="0.0.0.0"

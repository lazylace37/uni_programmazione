## Generate PDF from Markdown

```shell
docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` pandoc/latex appunti_esame.md -o appunti_esame.pdf -V geometry:a4paper,margin=1cm
```

# MD to PDF with LaTeX templates

Repozystorium zawiera szablony do tworzenia dokumentów w formacie PDF z wykorzystaniem `pandoc` i `latexmk`. W szczególności zawiera szablony dla prac dyplomowych i naukowych.

# AGHDPL

- Autor: [Piotr Sokołowski](https://github.com/sokoloowski).
- [Oryginalny szablon](http://home.agh.edu.pl/~mszpyrka/doku.php?id=lectures:latex:aghdpl) autorstwa: [prof. dr hab. Marcin Szpyrka](mailto:mszpyrka@agh.edu.pl), prof. dr hab. inż. Grzegorz J. Nalepa i dr inż. Paweł Kłeczek.
- Pomysłodawca [dr inż. Sebastiana Ernsta](mailto:ernst@agh.edu.pl)

Niniejsze opracowanie ma na celu umożliwienie napisania pracy dyplomowej w [Markdown](https://daringfireball.net/projects/markdown/) i wyeksportowanie jej do formatu PDF za pośrednictwem [`pandoc`](https://pandoc.org) oraz [`latexmk`](https://mg.readthedocs.io/latexmk.html).

Napisana praca jest najpierw generowana w formacie `latex`, ponieważ `pandoc` nie obsługuje użytego w szablonie `biblatex`. Następnie tworzony jest dokument PDF, domyślnie `out/praca-dyplomowa-latest.pdf`.

# PPRAI

- Autor: [Piotr Sokołowski](https://github.com/sokoloowski).

# Wymagania

- `make`
- `latexmk`
- `pandoc` (tested versions: 3.6.4 and 2.17.1.1)
- `pandoc-crossref`

## Ubuntu (`amd64`)

```bash
apt install make texlive-full pandoc

# find version compatible with your pandoc to avoid warnings!
wget https://github.com/lierdakil/pandoc-crossref/releases/download/latest/pandoc-crossref-Linux.tar.xz
tar -xf pandoc-crossref-Linux.tar.xz
mv pandoc-crossref /usr/local/bin
```

## macOS

```zsh
brew install make mactex pandoc pandoc-crossref
```

# Sposób użycia

W katalogach [md/beng](md/beng), [md/eng](md/meng), [md/pprai](md/pprai) znajdują się pliki źródłowe dokumentów. Są one załączane do pliku wynikowego w kolejności alfabetycznej, stąd sugestia, by stosować nazwy `XX-description.md`, gdzie `XX` to wartość liczbowa, zaczynając od `00`.

Plik `00-headers.md` zawiera niezbędne nagłówki w formacie YAML (tzw. YAML front matter), gdzie można dostosować informacje o pracy: tytuł, dane autora, promotora, bibliografię. Dobrą praktyką jest nie wpisywać treści pracy w tym pliku, jednak nie jest to błędem.

Plik [Makefile](Makefile) zawiera w sobie polecenia tworzące końcowy plik PDF. Jako źródło brane są wszystkie pliki z rozszerzeniem `.md` znajdujące się w katalogu `md/${TYPE}`.

Skrypt [build.sh](build.sh) zawiera przykładowe argumenty dla `pandoc` i `latexmk`, które są używane w poleceniu `make pdf`.

## Dostosowanie ustawień

Można zmienić domyślne zachowanie polecenia `make` dostosowując kolejne argumenty skryptu [build.sh](build.sh)

- `TYPE` - typ szablonu latex, znajdujący się w katalogu `src/TYPE`
- `INPUT_DIR` - katalog z plikami źródłowymi
- `OUTPUT_FILE_SUFFIX` - przyrostek pliku wynikowego, domyślnie `-latest`
- `OUTPUT_DIR_SUFFIX` - przyrostek katalogu wynikowego, domyślnie `INPUT_DIR`

## Użycie 

Przykładowa komenda do wykonania, ustalajaca szablon [template.tex](src/thesis/template.latex) w stylu [thesis](src/thesis) dla plikow zrodlowych z katalogu [md/meng](md/meng), tworząca [thesis-latest.pdf](pdf/meng/thesis-latest.pdf) w katalogu [pdf/meng](pdf/meng):

```bash
./build.sh thesis md/meng
```

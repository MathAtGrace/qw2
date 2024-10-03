# Quantitative Wisdom

Repository for a Quantitative Wisdom textbook

The website for this project is mathatgrace.github.io/qw2.

## Compilation instructions

This text is written in [PreTeXt](https://pretextbook.org), so the primary source files can be found in the `source` directory. These can be compiled into HTML or PDF files (as well as some other formats) using the following directions.

### Preliminaries

The easiest way to build output formats from the source is to use the PreTeXt-CLI. To get this set up, follow the instructions in the [PreTeXt guide](https://pretextbook.org/doc/guide/html/quickstart-getting-pretext.html). You will need Python, LaTeX, and `pdf2svg` (if you wish to compile the html version; this requires an [extra step](https://pretextbook.org/doc/guide/html/section-installing-pdf2svg.html) on Windows).

Open up a terminal and in your preferred directory, clone `qw2` repositories:

`git clone https://github.com/MathAtGrace/qw2.git`

(If you had previously done this, you will likely want to get the most recent versions of the repository by entering `git pull` from the discrete-book folder.)

Then change to the `qw2` folder:

`cd qw2`

### Compiling

If everything has been set up properly above, you can now execute the following commands to build the book. To create a PDF, you can enter:

`pretext build print`

To make the HTML version:

`pretext build web`

## Contributing

Any and all suggestions to improve the text are welcome. Thanks to those who have already pointed out typos/issues they have found. If you would like to make a more substantial contribution, please contact me so we can discuss how best to proceed.
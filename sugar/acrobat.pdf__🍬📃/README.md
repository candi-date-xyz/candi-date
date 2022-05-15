
# generate pdf from markdown

// TODO: auto generate PDF, etc. 
# https://github.com/cetra3/mdcollate
 mdcollate data/test.md | pulldown-cmark > test.html && wkhtmltopdf test.html test.pdf


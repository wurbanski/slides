#!/usr/bin/env python

from jinja2 import Environment, PackageLoader, select_autoescape
from glob import glob
import frontmatter
import sys
import os


if __name__ == '__main__':
    if len(sys.argv) > 1:
        slides_dir = sys.argv[1]
    else:
        print("Not enough arguments. Exiting...")
        exit(1)
    
    env = Environment(
        loader=PackageLoader('generate_index', 'templates'),
        autoescape=select_autoescape(['html', 'xml'])
    )
    
    index = env.get_template('index.html')
    
    for slides in glob(os.path.join(slides_dir, '*.md')):
        slideset = frontmatter.load(slides)
    
    with open('index.html', 'w') as index_file:
        index_file.write(index.render())
    
    print("Written index.html.")

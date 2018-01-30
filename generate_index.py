#!/usr/bin/env python

from jinja2 import Environment, PackageLoader, select_autoescape
from glob import glob
import frontmatter
import os

env = Environment(
    loader=PackageLoader('generate_index', 'templates'),
    autoescape=select_autoescape(['html', 'xml'])
)

index = env.get_template('index.html')

for slides in glob('slides/*.md'):
    slideset = frontmatter.load(slides)

with open('_out/index.html', 'w') as index_file:
    index_file.write(index.render())



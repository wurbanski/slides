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

    slidesets = []
    for slides in glob(os.path.join(slides_dir, '*.md')):
        identifier = os.path.splitext(os.path.basename(slides))[0]
        md_file = frontmatter.load(slides)
        slidesets.append(dict(identifier=identifier,
                              metadata=md_file.metadata))

    with open('index.html', 'w') as index_file:
        index_file.write(index.render(slidesets=slidesets))

    print("Written index.html.")

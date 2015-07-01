README.md



# apt-get install

- psysh

- memcached

- bpython
- imagemagick


# wkhtmltopdf

- wkhtmltopdf
- xvfb
- x11vnc



    #!/bin/bash

    xvfb-run -a -s "-screen 0 640x480x16" /usr/bin/wkhtmltopdf "$@"



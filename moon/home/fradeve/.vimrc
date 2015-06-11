let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

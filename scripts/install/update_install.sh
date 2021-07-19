#!/usr/bin/env bash
pip3 uninstall -y easy_tools
pip3 install /easy_ai/package/easy_tools-0.2-py2.py3-none-any.whl
chmod +x /usr/local/lib/python3.6/dist-packages/easy_tools/train_scripts/*

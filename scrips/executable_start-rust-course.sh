#!/bin/bash
cd ~/rust_work/rust-course/
git pull
firefox 'http://localhost:3000' &
mdbook serve 2>/dev/null &

#!/bin/bash
cd ~/rust_work/rust-by-practice
git pull
firefox 'http://localhost:3000' &
mdbook serve zh-CN/ 2>/dev/null &

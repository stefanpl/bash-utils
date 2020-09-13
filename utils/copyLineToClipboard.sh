copyLineToClipboard() {
  echo ${*} | perl -p -e 's/\n//' | xclip -selection c
}

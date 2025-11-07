# Clear the terminal on exit for the final shell in the stack.
if [[ ${SHLVL:-0} -le 1 ]]; then
  clear >/dev/null 2>&1
fi

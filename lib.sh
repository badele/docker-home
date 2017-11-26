replaceVariablesInFile()
{
    srcfile=$1
    dstfile=$2

    # source: https://stackoverflow.com/a/40167919/2015612
    local line lineEscaped
    cat $srcfile | while IFS= read -r line || [[ -n $line ]]; do  # the `||` clause ensures that the last line is read even if it doesn't end with \n
        # Escape ALL chars. that could trigger an expansion..
        IFS= read -r -d '' lineEscaped < <(printf %s "$line" | tr '`([$' '\1\2\3\4')
        # ... then selectively reenable ${ references
        lineEscaped=${lineEscaped//$'\4'{/\${}
        # Finally, escape embedded double quotes to preserve them.
        lineEscaped=${lineEscaped//\"/\\\"}
        eval "printf '%s\n' \"$lineEscaped\"" | tr '\1\2\3\4' '`([$'
    done > /tmp/replaceVariablesInFile.txt

    cat /tmp/replaceVariablesInFile.txt > $dstfile
}

# Source: https://stackoverflow.com/questions/5799303/print-a-character-repeatedly-in-bash
printf_new() {
 str=$1
 num=$2
 v=$(printf "%-${num}s" "$str")
 echo "${v// /$str}"
}

print_title()
{
  mess="# $1 #"
  mlen=${#mess}

  printf_new "#" ${mlen}
  echo "${mess}"
  printf_new "#" ${mlen}
}

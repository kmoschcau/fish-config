function from_hex --description 'Convert a hex color to the nearest 0 to 255 color index'
  # first parse the argument in either 3 digits or 6 digits format
  set hex_numbers (string match --regex '[[:xdigit:]]{6}|[[:xdigit:]]{3}' $argv[1])

  # parse the hexadecimal digits to decimal numbers
  if test (string length $hex_numbers) -eq 3
    # first get the shorthand digits
    set --local red_digit   (string sub --start 1 --length 1 $hex_numbers)
    set --local green_digit (string sub --start 2 --length 1 $hex_numbers)
    set --local blue_digit  (string sub --start 3 --length 1 $hex_numbers)

    # then parse them as duplicated
    set red   (printf '%d' 0x$red_digit$red_digit)
    set green (printf '%d' 0x$green_digit$green_digit)
    set blue  (printf '%d' 0x$blue_digit$blue_digit)
  else
    set red   (printf '%d' 0x(string sub --start 1 --length 2 $hex_numbers))
    set green (printf '%d' 0x(string sub --start 3 --length 2 $hex_numbers))
    set blue  (printf '%d' 0x(string sub --start 5 --length 2 $hex_numbers))
  end

  # calculate the red part
  if test $red -lt 75
    set red 0
  else
    set red (math (math $red-35)/40)
  end
  set red (math -- "$red*6*6")

  # calculate the green part
  if test $green -lt 75
    set green 0
  else
    set green (math (math $green-35)/40)
  end
  set green (math -- "$green*6")

  # calculate the blue part
  if test $blue -lt 75
    set blue 0
  else
    set blue (math (math $blue-35)/40)
  end

  # calculate the final result
  echo (math $red+$green+$blue+16)
end

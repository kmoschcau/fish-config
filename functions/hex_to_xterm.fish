function hex_to_xterm \
    --description 'Convert passed hex color codes to xterm color codes'
    function value_to_cube_quantifier
        if test "$argv[1]" -lt 48
            echo 0
        else
            if test "$argv[1]" -lt 114
                echo 1
            else
                echo (math "($argv[1] - 35) / 40")
            end
        end
    end

    function color_index
        echo (math "36 * $argv[1] + 6 * $argv[2] + $argv[3]")
    end

    function value_to_gray_index
        if test "$argv[1]" -gt 238
            echo 23
        else
            echo (math "($argv[1] - 3) / 10")
        end
    end

    function cube_quantifier_to_value
        set --local values 0 0x5f 0x87 0xaf 0xd7 0xff
        echo (printf '%d' $values[(math "$argv[1] + 1")])
    end

    function square_distance
        echo (math "($argv[1] - $argv[4])^2 + ($argv[2] - $argv[5])^2 + ($argv[3] - $argv[6])^2")
    end

    # first, parse the input
    if string match --quiet --regex '^[[:xdigit:]]{6}$' $argv[1]
        # parse six digit hex number and split to channel values
        set --local parts (string match --regex '(..)(..)(..)' $argv[1])
        set red (printf '%d' "0x$parts[2]")
        set green (printf '%d' "0x$parts[3]")
        set blue (printf '%d' "0x$parts[4]")
    else if string match --quiet --regex '^[[:xdigit:]]{3}$' $argv[1]
        # parse three digit hex number and split to channel values
        set --local parts (string match --regex '(.)(.)(.)' $argv[1])
        set red (printf '%d' "0x$parts[2]$parts[2]")
        set green (printf '%d' "0x$parts[3]$parts[3]")
        set blue (printf '%d' "0x$parts[4]$parts[4]")
    else
        echo 'Invalid hex code syntax.'
        return 1
    end

    # calculate color cube quantifiers
    set quant_red (value_to_cube_quantifier $red)
    set quant_green (value_to_cube_quantifier $green)
    set quant_blue (value_to_cube_quantifier $blue)

    # calculate the quantifier values
    set chan_red (cube_quantifier_to_value $quant_red)
    set chan_green (cube_quantifier_to_value $quant_green)
    set chan_blue (cube_quantifier_to_value $quant_blue)

    # shortcut for when input and channel values are the same
    if test "$chan_red" -eq "$red" -a \
            "$chan_green" -eq "$green" -a \
            "$chan_blue" -eq "$blue"
        echo (math "16 + "(color_index $quant_red $quant_green $quant_blue))
        return 0
    end

    # calculate the gray index
    set gray_index (value_to_gray_index (math "($red + $green + $blue) / 3"))

    # calculate the gray index value
    set gray_val (math "8 + 10 * $gray_index")

    # calculate both distances
    set dist_color (square_distance $chan_red $chan_green $chan_blue $red $green $blue)
    set dist_gray (square_distance $gray_val $gray_val $gray_val $red $green $blue)

    # calculate return value
    if test "$dist_gray" -lt "$dist_color"
        set ret_val (math "232 + $gray_index")
    else
        set ret_val (math "16 + "(color_index $quant_red $quant_green $quant_blue))
    end

    # delete private functions to not pollute global scope
    functions -e value_to_cube_quantifier color_index value_to_gray_index \
        cube_quantifier_to_value square_distance

    echo $ret_val
    return 0
end

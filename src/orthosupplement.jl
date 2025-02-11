function syllablecount(s)
    length(syllabify(s))
end
"""True if character is a vowel.
$(SIGNATURES)
"""
function vowel(c)
    c in "aeiouyAEIOUY"
end


"""True if character is not a vowel.
$(SIGNATURES)
"""
function consonant(c)
    ! vowel(c)
end

function syllabify(raw)

    diphthongs = ["ae", "oe", "au", "eu", "ei", "ui"]  # Common diphthongs
    syllables = []
    
    s = lowercase(raw)
    i = 1

    current = ""
    while i <= length(s)
        @debug("Look at $(s[i]) ($(i))")
        if i < length(s) && s[i:i+1] in diphthongs
            @debug("Diphthong with following $(s[i:i+1])")
            if ! isempty(current)
                push!(syllables, current)
            end
            current = s[i:i+1]
            i = i + 2



        elseif vowel(s[i])
            @debug("IT'S A VWEL")
            if ! isempty(current)
                push!(syllables, current)
                @debug("SYllables now $(syllables)")    
            end
            current = string(s[i])
            @debug("Current now $(current)")
            i = i + 1
        else
            
            current = current * s[i]
            @debug("current now $(current)")
            i = i + 1
        end
        #=
        # Detect diphthongs
        if i < length(s) && s[i:i+1] in diphthongs
            syllable = s[i:i+1]
            i += 2
        elseif vowel(s[i]) # Single vowel
            syllable = string(s[i])
            i += 1
        else
            syllable = string(s[i]) # Assume consonant start
            i += 1
        end

        # Gather following consonants
        while i <= length(s) && consonant(s[i])
            syllable *= s[i]
            i += 1
        end

        push!(syllables, syllable)
        =#
        
    end
    if ! isempty(current)
        push!(syllables, current)
    end
#=

    # Adjust syllable boundaries based on Latin rules
    adjusted_syllables = String[]
    buffer = ""

    for (j, syl) in enumerate(syllables)
        buffer *= syl
        @debug("Adjust $(buffer)")
        if j == length(syllables) || vowel(first(syllables[j+1]))
            push!(adjusted_syllables, buffer)
            buffer = ""
        end
    end

    adjusted_syllables
    =#
    syllables
end

#= Test cases
println(split_into_syllables("amicus"))  # Expected: ["a", "mi", "cus"]
println(split_into_syllables("fortuna")) # Expected: ["for", "tu", "na"]
println(split_into_syllables("magister")) # Expected: ["ma", "gis", "ter"]
println(split_into_syllables("puella")) # Expected: ["pu", "el", "la"]
println(split_into_syllables("sanctus")) # Expected: ["sanc", "tus"]
=#


"""True if neuter noun has istem pattern.
$(SIGNATURES)
"""
function istemneuter(n::LSNoun)
    if ! (n.gender == "neuter")
        false

    else
        endswith(n.nomsg, "e") ||
        endswith(n.nomsg, "al") ||
        endswith(n.nomsg, "r")
    end
end



"""True if two Latin strings have the same number of syllables
$(SIGNATURES)
"""
function parisyllabic(s1, s2)
    syllablecount(s1) == syllablecount(s2)
end


"""True if nominative and genitive singular have the same number of syllables
$(SIGNATURES)
"""
function parisyllabic(n::LSNoun)
    parisyllabic(n.nomsg, n.gensg)
end

"""True if noun has a stem with final consonant cluster of i-stem.
Example: gens, gentis
$(SIGNATURES)
"""
function istemconscluster(n::LSNoun)
    genstem = replace(n.gensg, r"is" => "")
    @debug("Look at $(genstem) from $(n)")
    goodending = endswith(n.nomsg, "x") || endswith(n.nomsg, "s")

    if goodending
        trailer = []
        i = length(genstem)
        done = false
        while  ! done
            if i == 0
                done = true
                @debug("Done at $(i)")
            elseif vowel(genstem[i])
                done = true
                @debug("Done at $(i): $(genstem[1:i])")
            else 
                push!(trailer, genstem[i])
            end
            
            i = i - 1
        end        
        @debug("Look at trailer $(trailer)")
        
        length(trailer) > 1
    else
        false
    end
end


"""True if noun is an istem.
$(SIGNATURES)
"""
function istem(n::LSNoun)
    if n.declension != 3
        false

    elseif n.gender == "neuter"
        istemneuter(n)

    else
        parisyllabic(n) || istemconscluster(n)
    end
end

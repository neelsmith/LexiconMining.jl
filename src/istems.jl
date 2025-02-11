

"""True if neuter noun has istem pattern.
$(SIGNATURES)
"""
function istemneuter(n::LSNoun)
    if ! n.gender == "neuter"
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
function parisyllabic(s1, s2, ortho = latin24())
    syllablecount(s1) == syllablecount(s2)
end


"""True if nominative and genitive singular have the same number of syllables
$(SIGNATURES)
"""
function parisyllabic(n::LSNoun, ortho = latin24())
    #parisyllabic(n.nomsg, n.gensg, ortho = ortho)
    false
end

"""True if noun has a stem with final consonant cluster of i-stem.
Example: gens, gentis
$(SIGNATURES)
"""
function istemconscluster(n::LSNoun)
    false
end


"""True if noun is an istem.
$(SIGNATURES)
"""
function istem(n::LSNoun)
    if n.gender == "neuter"
        istemneuter(n)

    else
        parisyllabic(n) || istemconscluster(n)
    end
end

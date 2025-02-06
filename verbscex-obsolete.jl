



"""Compose a vector of CEX lines for a verb stem.
$(SIGNATURES)
"""
function verb_cexlines(id, lexentity, stem, conj, note, stemsuffix = ""; commonortho = true, divider = "|")        
    @info("VERB LINES FOR $(id), $(lexentity), $(stem), $(conj) $(stem) and suffix $(stemsuffix) ; using common ortho? $(commonortho)")
    #@info("Conj is $(conj)")


    #THIS LOGIC IS WRONG
    if commonortho
        #@info("COMMON STEM $(stem)")
        [join(["latcommon.verb$(id)", lexentity, stem, conj, note], divider)]
    else
       @info("Stem needs ortho-specific lines")
        l23 = join(["lat23.verb$(id)$(stemsuffix)", lexentity, lat23(stem), conj, note], divider)
        l24 = join(["lat24.verb$(id)$(stemsuffix)", lexentity, lat24(stem),  conj, note], divider)
        l25 = join(["lat25.verb$(id)$(stemsuffix)", lexentity, stem,  conj, note], divider)
        stemlines = [l23, l24, l25]
        #@info("Returnging $(stemlines)")
        stemlines
    end
end


"""Compose CEX lines for verb with irregular principal parts.
$(SIGNATURES)
"""
function principalparts_cex(verb; divider = "|")
    #@info("PRINCPARTS FOR $(verb)")
    #@info("Its tabulae class is $(tabulaeclass(verb))")
    cexlines = []

    if iscommon(verb.pp1)
        #push!(cexlines, pres_stem_cex(verb; divider = divider))
        @info("Generate PP1 for latcommon stem $(verb.pp1)")
    else
        @info("Need distinct orthos for pres stem of $(verb)")
        #=
        l23stem = lat23(verb.pp1)
        l23cex =  pres_stem_cex(l23stem, verb; divider = divider)
        #@info("Pushing L23 $(l23cex)")
        push!(cexlines,l23cex)

        l24stem = lat24(verb.pp1)
        l24cex = pres_stem_cex(l24stem, verb; divider = divider)
        #@info("Pushing L24 $(l24cex)")
        push!(cexlines, l24cex)


        l25cex = pres_stem_cex(verb; divider = divider)
        #@info("Pushing L25 $(l25cex)")
        push!(cexlines, l25cex)
        =#
    end


    if iscommon(verb.pp3)
        push!(cexlines, pftactstem_cex(verb; divider = divider))

    else
 
        l23stem = lat23(verb.pp3)
        push!(cexlines, pftactstem_cex(l23stem, verb; divider = divider))

        l24stem = lat24(verb.pp3)
        push!(cexlines, pftactstem_cex(l24stem, verb; divider = divider))

        l25stem = verb.pp3
        push!(cexlines, pftactstem_cex(l25stem, verb; divider = divider))
    end


    if iscommon(verb.pp4)
        push!(cexlines, pftpass_stem_cex(verb; divider = divider))

    else
        l23stem = lat23(verb.pp4)
        push!(cexlines, pftpass_stem_cex(l23stem, verb; divider = divider))

        l24stem = lat24(verb.pp4)
        push!(cexlines, pftpass_stem_cex(l24stem, verb; divider = divider))

        l25stem = verb.pp4
        push!(cexlines, pftpass_stem_cex(l25stem, verb; divider = divider))
    end
  
    filter(ln -> ! isempty(ln), cexlines)
end


"""Compose CEX line for present stem of a given verb.
$(SIGNATURES)
"""
function pres_stem_cex(verb; divider = "|")
    @info("Pass along to pres_stem_cex with 2 params")
    pres_stem_cex(verb.pp1, verb; divider = divider)
end


"""Compose CEX for the present stem of a given verb, using the supplied form for the first principal part.
$(SIGNATURES)
"""
function pres_stem_cex(pp1, vrb; divider = "|")
    @info("Use presnt stem $(pp1) for verb $(vrb)")
    if pp1 == "–" || pp1 == "-"
        "" 
    else
        iclass = tabulaeclass(vrb)
        lexentity = string("lsx.", vrb.lsid)
        stem = present_stem(vrb.conjugation, pp1)

        if isempty(stem)
            #@warn("Empty present stem $(vrb.lsid)")
            "" #[]
        else
            @info("Generate lines for $(stem), common ortho? $(iscommon(vrb.pp1))")
            verb_cexlines(vrb.lsid, lexentity, stem, iclass, "Automatically generated","a";
            divider = divider,
            commonortho = iscommon(stem))
#=
 
 
 
    actualpresentcex = LexiconMining.verb_cexlines(obliviscor.lsid, lexentity, stem, iclass, "Automatically generated")
            =#
        end

        #=
        #@info("Formed stem $(stem)")
        #@info("Using pres stem $(stem) for $(verb)")
        
            #conj = presentconj(verb)
            note = "Automatically generated"
            @info("Check LSID $(verb.lsid)")

            
            @info("Verblines using $(verb.lsid), $(lexentity), $(stem), $(iclass)")
            finalcex = verb_cexlines(verb.lsid, lexentity, stem, iclass, note; 
            divider = divider)[1] #|> Iterators.flatten |> collect

            @info("So cex is $(finalcex)")
            finalcex
        end =#
    end
end



"""Compose CEX line for perfect active stem.
$(SIGNATURES)
"""
function pftactstem_cex(pp3, verb; divider = "|")
    #@info("Form 3rd part for $(verb) with $(pp3)")
    if pp3 == "–" || pp3 == "-"  || isdeponent(verb)
        []
    else
        lexentity = string("lsx.", verb.lsid)
        stem = replace(pp3, r"i$" => "") |> 
        suareznorm
        if isempty(stem) 
            #@warn("Empty perfect active stem $(verb.lsid)")
            []
        else
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, "pftact", note, "b"; 
            divider = divider,   commonortho = iscommon(stem))[1]
        end
    end
end

function pftpass_stem_cex(verb; divider = "|")
    pftpass_stem_cex(verb.pp4, verb; divider = divider)
end

"""Compose CEX line for perfect passive stem.
$(SIGNATURES)
"""
function pftpass_stem_cex(pp4, verb; divider = "|")
    
    if pp4 == "–" || pp4 == "-"
        []
    else
        lexentity = string("lsx.", verb.lsid)
        stem = replace(pp4, r"tu[ms]$" => "t") |> suareznorm
        if isempty(stem)
            #@warn("EMPTY PERFECT PASSIVE STEM $(verb.lsid)")
            []
        else
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, "pftpass", note, "c"; 
            divider = divider,   commonortho = iscommon(stem))[1]
        end
    end
end




function isregular(iclass)
    iclass in regular_conjugations
end

function isregular(verb::LSVerb)
    tabulaeclass(verb) |> isregular
end






function conj3_cex(verb; divider = "|")
    lexentity = string("lsx.", verb.lsid)
    stem = replace(verb.pp1, r"ior?$" => "") |> suareznorm
    if isempty(stem)
        @warn("Empty present stem $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjugations 
            #@info("Call verb_cexlines with $(iclass)")
            verb_cexlines(verb.lsid, lexentity, stem, iclass, note; 
            divider = divider,
            commonortho = iscommon(stem))

        else
            #@info("C3: Not regular")
            principalparts_cex(verb)
        end
    end
end

function conj4_cex(verb; divider = "|")
    lexentity = string("lsx.", verb.lsid)
    stem = replace(verb.pp1, r"ior?$" => "") |> suareznorm
    if isempty(stem)
        @warn("Empty present stem $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjugations 
            #@info("regular")
            conj = endswith(stem, "or") ? "conj4dep" : "conj4"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider,
            commonortho = iscommon(stem))

        else
            #@info("Not regular")
            principalparts_cex(verb)
        end
    end
end


function conj2_cex(verb; divider = "|")
    lexentity = string("lsx.", verb.lsid)
    stem = replace(verb.pp1, r"eor?$" => "") |> suareznorm
    if isempty(stem)
        @warn("Empty present stem $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjugations 
            #@info("regular")
            conj = endswith(stem, "or") ? "conj2dep" : "conj2"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider, 
            commonortho = iscommon(stem))

        else
           # @info("Not regular")
            principalparts_cex(verb)
        end
    end
end


"""Create CEX for a regular 1st-conjugation verb.
$(SIGNATURES)
"""
function conj1_cex(verb; divider = "|")
    #@info("Get CEX for conj1 verb $(verb)")
    lexentity = string("lsx.", verb.lsid)
    stem = replace(verb.pp1, r"or?$" => "") |> suareznorm
    if isempty(stem)
        @warn("Empty present stem $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjugations 
            #@info("IT'S REGULAR")
            conj = endswith(stem, "or") ? "conj1dep" : "conj1"
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider,
            commonortho = iscommon(stem)
            )
        else
            #@info("$(iclass) not in list of regular conjugations")
            principalparts_cex(verb; divider = divider)
        end
        
    end
end
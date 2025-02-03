
"""True if a principal part is explicitly marked as missing.
$(SIGNATURES)
"""
function missingpart(verb::LSVerb)
    verb.pp1 == "–" || verb.pp1 == "-" ||
    verb.pp2 == "–" || verb.pp2 == "-" ||
    verb.pp3 == "–" || verb.pp3 == "-" ||
    verb.pp4 == "–" || verb.pp4 == "-" 

end


"""Compose a vector of CEX lines for a verb stem.
$(SIGNATURES)
"""
function verb_cexlines(id, lexentity, stem, conj, note; divider = "|")        
    #@info("VERB LINES FOR $(conj) $(stem)")
    if iscommon(stem)
        [join(["latcommon.verb$(id)", lexentity, stem, conj, note], divider)]
    else
        #@info("Stem needs ortho-specific lines")
        l23 = join(["lat23.verb$(id)", lexentity, lat23(stem), conj, note], divider)
        l24 = join(["lat24.verb$(id)", lexentity, lat24(stem),  conj, note], divider)
        l25 = join(["lat25.verb$(id)", lexentity, stem,  conj, note], divider)
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
    cexlines = []

    if iscommon(verb.pp1)
        push!(cexlines, presstem_cex(verb; divider = divider))
    else
        l23stem = lat23(verb.pp1)
        push!(cexlines, presstem_cex(l23stem, verb; divider = divider))

        l24stem = lat24(verb.pp1)
        push!(cexlines, presstem_cex(l24stem, verb; divider = divider))

        push!(cexlines, presstem_cex(verb; divider = divider))
    end


    if iscommon(verb.pp3)
        push!(cexlines, pftactstem_cex(verb; divider = divider))

    else
        l23stem = lat23(verb.pp3)
        push!(cexlines, pftactstem_cex(l23stem, verb; divider = divider))

        l24stem = lat24(verb.pp1)
        push!(cexlines, presstem_cex(l24stem, verb; divider = divider))

        l25stem = lat25(verb.pp1)
        push!(cexlines, presstem_cex(l25stem, verb; divider = divider))
    end


    if iscommon(verb.pp4)
        push!(cexlines, pftpass_stem_cex(verb; divider = divider))

    else
        l23stem = lat23(verb.pp4)
        push!(cexlines, pftpass_stem_cex(l23stem, verb; divider = divider))

        l24stem = lat24(verb.pp4)
        push!(cexlines, pftpass_stem_cex(l24stem, verb; divider = divider))

        l25stem = lat25(verb.pp4)
        push!(cexlines, pftpass_stem_cex(l25stem, verb; divider = divider))
    end
  
    filter(ln -> ! isempty(ln), cexlines)
end


"""Compose CEX line for present stem of a given verb.
$(SIGNATURES)
"""
function presstem_cex(verb; divider = "|")
    presstem_cex(verb.pp1, verb; divider = divider)
end

"""Compose CEX line for present stem of a given, using the supplied form for the first principal part.
$(SIGNATURES)
"""
function presstem_cex(pp1, verb; divider = "|")
    #@info("Use presnt stem $(pp1) for verb $(verb)")
    if pp1 == "–" || pp1 == "-"
        "" #[]
    else
        iclass = tabulaeclass(verb)
        lexentity = string("lsx.", verb.lsid)

        stem = presentstem(verb.conjugation, pp1)
        #@info("Formed stem $(stem)")
        #@info("Using pres stem $(stem) for $(verb)")
        if isempty(stem)
            @warn("EMPTY PRESENT STEM $(verb.lsid)")
            "" #[]
        else
            conj = presentconj(verb)
            note = "Automatically generated"
            finalcex = verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider)[1] #|> Iterators.flatten |> collect

            #@info("So cex is $(finalcex)")
            finalcex
        end
    end
end

function presentstem(conj::Int, present)
    if conj == 1
        replace(present, r"or?$" => "") |> suareznorm
    elseif conj == 2
        replace(present, r"[ĕe]or?$" => "") |> suareznorm
    elseif conj == 4
        replace(present, r"ior?$" => "") |> suareznorm
    elseif conj == 3
        replace(present, r"i?or?$" => "") |> suareznorm
    end 
end

function presentstem(verb::LSVerb)
    presentstem(verb.conjugation, verb.pp1)
end

function pftactstem_cex(verb; divider = "|")
    pftactstem_cex(verb.pp3, verb; divider = divider)
end

"""Compose CEX line for perfect active stem.
$(SIGNATURES)
"""
function pftactstem_cex(pp3, verb; divider = "|")
    
    if pp3 == "–" || pp3 == "-"  || isdeponent(verb)
        []
    else
        lexentity = string("lsx.", verb.lsid)
        stem = replace(pp3, r"i$" => "") |> 
        suareznorm
        if isempty(stem) 
            @warn("EMPTY PERFECT ACTIVE STEM $(verb.lsid)")
            []
        else
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, "pftact", note; 
            divider = divider)[1]
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
            @warn("EMPTY PERFECT PASSIVE STEM $(verb.lsid)")
            []
        else
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, "pftpass", note; 
            divider = divider)[1]
        end
    end
end


regular_conjungations = [
    "conj1", "conj1dep",
    "conj2", "conj2dep",
    "conj3", "conj3dep",
    "conj3io", "conj3iodep",
    "conj4", "conj4dep"
]

deponent_classes = [
        "conj1dep", "c1presdep",
        "conj2dep",  "c2presdep",
        "conj3dep",  "c3presdep",
        "conj3iodep",  "c3iopresdep",
        "conj4dep",  "c4presdep",
]

"""True if verb's inflectional class is deponent.
$(SIGNATURES)
"""
function isdeponent(verb::LSVerb)
    tabulaeclass(verb) in deponent_classes 
end

function conj3_cex(verb; divider = "|")
    lexentity = string("lsx.", verb.lsid)
    stem = replace(verb.pp1, r"ior?$" => "") |> suareznorm
    if isempty(stem)
        @warn("EMPTY PRESENT STEM $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjungations 
            conj = if endswith(stem, "ior")
                "conj3iodep"
            elseif endswith(stem, "io")
                "conj3io"
            elseif endswith(stem, "or")
                "conj3dep"
            else
                "conj3"
            end
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider)

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
        @warn("EMPTY PRESENT STEM $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjungations 
            #@info("regular")
            conj = endswith(stem, "or") ? "conj4dep" : "conj4"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider)

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
        @warn("EMPTY PRESENT STEM $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjungations 
            #@info("regular")
            conj = endswith(stem, "or") ? "conj2dep" : "conj2"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider)

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
        @warn("EMPTY PRESENT STEM $(verb.lsid)")
        []
    else
        note = "Automatically generated"

        iclass = tabulaeclass(verb)
        #@info("$(iclass)?")
        if iclass in regular_conjungations 
            #@info("IT'S REGULAR")
            conj = endswith(stem, "or") ? "conj1dep" : "conj1"
            note = "Automatically generated"
            verb_cexlines(verb.lsid, lexentity, stem, conj, note; 
            divider = divider)
        else
            #@info("$(iclass) not in list of regular conjugations")
            principalparts_cex(verb; divider = divider)
        end
        
    end
end
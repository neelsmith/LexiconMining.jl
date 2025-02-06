
"""Compose CEX content for a verb. Despite the function name,
this produces a vector of lines, not a single line.
$(SIGNATURES)
"""
function cexline(vrb::LSVerb; divider = "|")    
    
    iclass = tabulaeclass(vrb)
    
    @info("Start from tabulaeclass for $(vrb): $(iclass)")
    @info("Is it regular? $(iclass in regular_conjugations)")
    if isregular(vrb)
        @info("Work thorugh all conjugations")
        []
    else
        @info("Work through all princ parts")
        presstem_cex(vrb; divider = divider)
    end
end

"""Compose CEX line for present stem of a given verb.
$(SIGNATURES)
"""
function presstem_cex(vrb; divider = "|")
    @info("Create cex for pres stem")
    #presstem_cex(verb.pp1, verb; divider = divider)
    
    stem = presentstem(vrb.conjugation, vrb.pp1)
    iclass = tabulaeclass(vrb)
    @info("Check stem for orthos: $(stem) is common? $(iscommon(stem))")
    if iscommon(stem)
        @info("Generate latcommon for pp1")
        []
    else
        cexlines = []
        @info("Generate all orthos for pp1. Here's alt23")
     
        lat23line = join(["lat23.verb$(vrb.lsid)a", "lsx.$(vrb.lsid)", lat23(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat23line)

        lat24line = join(["lat24.verb$(vrb.lsid)a", "lsx.$(vrb.lsid)", lat24(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat24line)

        lat25line = join(["lat25.verb$(vrb.lsid)a", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat25line)
        

    end
end




function verb_cexlines(id, lexentity, stem, conj, note, stemsuffix = ""; commonortho = true, divider = "|")  
end











function cextable(verblist::Vector{LSVerb}, ortho = "latcommon"; divider = "|")
    hdr = join(
        ["StemUrn", "LexicalEntity", "Stem", "InflClass", "Notes"], 
        divider)
        
    cexlines = cexline.(verblist; divider = divider) |> Iterators.flatten |> collect
    
    ortholines = filter(ln -> occursin(ortho, ln), cexlines)
    string(
        hdr,
        "\n",
        join(ortholines, "\n")
    )
end
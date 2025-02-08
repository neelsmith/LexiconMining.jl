
"""Compose CEX content for a verb. Despite the function name,
this produces a vector of lines, not a single line.
$(SIGNATURES)
"""
function cexline(vrb::LSVerb; divider = "|")    
    
    iclass = tabulaeclass(vrb)
    
    #@info("Start from tabulaeclass for $(vrb): $(iclass)")
    #@info("Is it regular? $(iclass in regular_conjugations)")
    if isregular(vrb)
        #@info("Work thorugh all conjugations")
        pres_stem_cex(vrb; divider = divider)
        
        
    else
        @debug("Work through all princ parts")
        cexlines = pres_stem_cex(vrb; divider = divider)
        if ! isempty(vrb.pp3)
            for ln in pftact_stem_cex(vrb; divider = divider)
                push!(cexlines, ln)
            end
        end
        @debug("Look at pp4: $(vrb.pp4)")
        if ! isempty(vrb.pp4)
            
            for ln in pftpass_stem_cex(vrb; divider = divider)
                push!(cexlines, ln)
            end
        end
        cexlines
    end
end

"""Compose CEX line for present stem of a given verb.
$(SIGNATURES)
"""
function pres_stem_cex(vrb::LSVerb; divider = "|")
    #@info("Create cex for pres stem")
    
    suffix = isregular(vrb) ? "" : "a"
    
    stem = present_stem(vrb.conjugation, vrb.pp1)
    iclass = tabulaeclass(vrb)
    #@info("Check stem for orthos: $(stem) is common? $(iscommon(stem))")
    if iscommon(stem)
        #@info("Generate latcommon for pp1")
        commonline = join(["latcommon.verb$(vrb.lsid)$(suffix)", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
        [commonline]
    else
        cexlines = []
        #@info("Generate all orthos for pp1. Here's alt23")
     
        lat23line = join(["lat23.verb$(vrb.lsid)$(suffix)", "lsx.$(vrb.lsid)", lat23(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat23line)

        lat24line = join(["lat24.verb$(vrb.lsid)$(suffix)", "lsx.$(vrb.lsid)", lat24(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat24line)

        lat25line = join(["lat25.verb$(vrb.lsid)$(suffix)", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat25line)
        

    end
end

function pftact_stem_cex(vrb::LSVerb; divider = "|")
    
    stem = pftact_stem(vrb)
    #@info("Create cex for perfect active stem $(stem) from $(vrb)")
    if isempty(stem)
        []
    else
        iclass = "pftact"
        #@info("Check stem for orthos: $(stem) is common? $(iscommon(stem))")
        if iscommon(stem)
            #@info("Generate latcommon for pp3")
            delimited = join(["latcommon.verb$(vrb.lsid)b", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
            [delimited]
        else
            cexlines = []
            #@info("Generate all orthos for pp3. Here's alt23")
     
            lat23line = join(["lat23.verb$(vrb.lsid)b", "lsx.$(vrb.lsid)", lat23(stem) ,  iclass, "Automatically generated"], divider)
            push!(cexlines, lat23line)

            lat24line = join(["lat24.verb$(vrb.lsid)b", "lsx.$(vrb.lsid)", lat24(stem) ,  iclass, "Automatically generated"], divider)
            push!(cexlines, lat24line)

            lat25line = join(["lat25.verb$(vrb.lsid)b", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
            push!(cexlines, lat25line)
            cexlines
        end
    end
end

function pftpass_stem_cex(vrb::LSVerb; divider = "|")
    @debug("Create cex for perfect passive stem")
    #pres_stem_cex(verb.pp1, verb; divider = divider)
    
    stem = pftpass_stem(vrb) |> suareznorm
    @debug("USe stem value $(stem)")
    iclass = "pftpass"
    #@info("Check stem for orthos: $(stem) is common? $(iscommon(stem))")
    if iscommon(stem)
        #@info("Generate latcommon for pp4")
        delimited = join(["latcommon.verb$(vrb.lsid)c", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
        [delimited]
    else
        cexlines = []
        #@info("Generate all orthos for pp4. Here's alt23")
     
        lat23line = join(["lat23.verb$(vrb.lsid)c", "lsx.$(vrb.lsid)", lat23(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat23line)

        lat24line = join(["lat24.verb$(vrb.lsid)c", "lsx.$(vrb.lsid)", lat24(stem) ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat24line)

        lat25line = join(["lat25.verb$(vrb.lsid)c", "lsx.$(vrb.lsid)", stem ,  iclass, "Automatically generated"], divider)
        push!(cexlines, lat25line)
        cexlines
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
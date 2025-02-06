@testset "Test forming CEX lines for verbs with varied principal parts" begin
    obliviscor = "31712|urn:cite2:hmt:ls.markdown:n31709|oblīviscor|to forget|verb |3, oblīviscor, oblīviscī, oblītus" |> LexiconMining.readdataline |> verb

    @test obliviscor isa LSVerb
    divider = "|"
    defaultpres = LexiconMining.presstem_cex(obliviscor; divider = divider)
    


    #cex = cexline(obliviscor)

end

#9319|urn:cite2:hmt:ls.markdown:n9318|com-mĕmĭni |, to recollect or remember | verb  |3, -, -, commemini, -

@testset "Test CEX lines for verbs with varied principal parts and orthographies " begin
    summary = "31712|urn:cite2:hmt:ls.markdown:n31709|oblīviscor|to forget|verb |3, oblīviscor, oblīviscī, oblītus"

    obliviscor = summary |> LexiconMining.readdataline |> verb
    l23pp1 = LexiconMining.lat23(obliviscor.pp1)
    @test l23pp1 == "obliuiscor"
    l23stem = LexiconMining.presentstem(3, l23pp1)
    @test l23stem == "obliuisc"


    actualpresent = LexiconMining.presstem_cex(obliviscor)
    expectedpresent = [
        "lat23.verbn31709|lsx.n31709|obliuisc|c3presdep|Automatically generated",
        "lat24.verbn31709|lsx.n31709|oblivisc|c3presdep|Automatically generated",
        "lat25.verbn31709|lsx.n31709|oblivisc|c3presdep|Automatically generated"]


    @test_broken  actualpresent == expectedpresent
#=
    iclass = tabulaeclass(obliviscor)
    lexentity = string("lsx.", obliviscor.lsid)
    stem = LexiconMining.presentstem(obliviscor.conjugation, obliviscor.pp1)
    actualpresentcex = LexiconMining.verb_cexlines(obliviscor.lsid, lexentity, stem, iclass, "Automatically generated")
    
    @test actualpresentcex == expectedpresentcex
    
    
    presentcex = LexiconMining.presstem_cex(l23stem, obliviscor; divider = "|")
    expected = "lat23.verbn31709a|lsx.n31709|obliuisc|c3presdep|Automatically generated"

    @test_broken presentcex == expected

    cex = LexiconMining.principalparts_cex(obliviscor)

    =#
    #verbcex = verb_cexlines(id, lexentity, stem, conj, note; divider = "|")        

    #=
    "
 "lat23.verbn31709|lsx.n31709|obliuisc|c4presdep|Automatically generated"
 "lat23.verbn31709|lsx.n31709|obliuisc|c4presdep|Automatically generated
    =#
end
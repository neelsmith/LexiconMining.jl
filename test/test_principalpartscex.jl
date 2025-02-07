@testset "Test forming stems of principal parts" begin
    summary = "31712|urn:cite2:hmt:ls.markdown:n31709|oblīviscor|to forget|verb |3, oblīviscor, oblīviscī, oblītus"

    obliviscor = summary |> LexiconMining.readdataline |> verb
    @test LexiconMining.present_stem(obliviscor) == "oblivisc"
    @test LexiconMining.pftact_stem(obliviscor) |> isempty
    @test LexiconMining.pftpass_stem(obliviscor) == "oblit"
end


#9319|urn:cite2:hmt:ls.markdown:n9318|com-mĕmĭni |, to recollect or remember | verb  |3, -, -, commemini, -

@testset "Test CEX lines for verbs with varied principal parts and orthographies " begin
    summary = "31712|urn:cite2:hmt:ls.markdown:n31709|oblīviscor|to forget|verb |3, oblīviscor, oblīviscī, oblītus"

    obliviscor = summary |> LexiconMining.readdataline |> verb
    l23pp1 = LexiconMining.lat23(obliviscor.pp1)
    @test l23pp1 == "obliuiscor"
    l23stem = LexiconMining.present_stem(3, l23pp1)
    @test l23stem == "obliuisc"


    actualpresent = LexiconMining.pres_stem_cex(obliviscor)
    expectedpresent = [
        "lat23.verbn31709a|lsx.n31709|obliuisc|c3presdep|Automatically generated",
        "lat24.verbn31709a|lsx.n31709|oblivisc|c3presdep|Automatically generated",
        "lat25.verbn31709a|lsx.n31709|oblivisc|c3presdep|Automatically generated"]
    @test  actualpresent == expectedpresent

    actualpftact = LexiconMining.pftact_stem_cex(obliviscor)
    @test isempty(actualpftact)

    actualpftpass = LexiconMining.pftpass_stem_cex(obliviscor)
    expectedpftpass = ["latcommon.verbn31709c|lsx.n31709|oblit|pp4|Automatically generated"]
    @test actualpftpass == expectedpftpass

    
end

@testset "Test CEX lines for regular verbs with common orthography " begin
     summary = "15|urn:cite2:hmt:ls.markdown:n14|ăb-aestŭo |to hang down richly |verb  |1, ab-aestuo, -āvi, -ātum"

    abaestuo = summary |> LexiconMining.readdataline |> verb
    expected = ["latcommon.verbn14|lsx.n14|abaestu|conj1|Automatically generated"] 
    @test cexline(abaestuo) == expected


    venor = "50448|urn:cite2:hmt:ls.markdown:n50445|vēnor | to hunt, chase | verb  | 1, vēnor, vēnārī, vēnātus" |> LexiconMining.readdataline |> verb

    venorexpected =  ["lat23.verbn50445a|lsx.n50445|uen|conj1dep|Automatically generated",
        "lat24.verbn50445a|lsx.n50445|ven|conj1dep|Automatically generated",
        "lat25.verbn50445a|lsx.n50445|ven|conj1dep|Automatically generated"
    ]
    @test cexline(venor) == venorexpected


end
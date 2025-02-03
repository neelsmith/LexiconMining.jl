@testset "Test forming CEX lines for verbs with varied principal parts" begin
    obliviscor = "31712|urn:cite2:hmt:ls.markdown:n31709|oblīviscor|to forget|verb |3, oblīviscor, oblīviscī, oblītus" |> LexiconMining.readdataline |> verb

    @test obliviscor isa LSVerb
    divider = "|"
    defaultpres = LexiconMining.presstem_cex(obliviscor; divider = divider)
    


    #cex = cexline(obliviscor)

end

#9319|urn:cite2:hmt:ls.markdown:n9318|com-mĕmĭni |, to recollect or remember | verb  |3, -, -, commemini, -
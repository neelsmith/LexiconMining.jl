#

@testset "Test parsing ChatGPT summaries for adjectives" begin
    summary = "13650|urn:cite2:hmt:ls.markdown:n13648|dexter|on the right, favorable|adjective|dexter, dextera, dexterum"
    dexter = LexiconMining.readdataline(summary) |> adjective

    expected = "latcommon.adjn13648|lsx.n13648|dexter|er_era_erum"
    @test cexline(dexter) == [expected]
end
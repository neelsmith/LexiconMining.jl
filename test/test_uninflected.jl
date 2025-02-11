@testset "Test parsing of ChatGPT summaries for uninflected forms" begin
    summary = "25453|urn:cite2:hmt:ls.markdown:n25450b|juxtā|near to, nigh|preposition|accusative"

    juxta = summary |> LexiconMining.readdataline |> preposition

    expectedcex = [
    "lat23.prepn25450b|lsx.n25450b|iuxta|preposition",
    "lat24.prepn25450b|lsx.n25450b|iuxta|preposition",
    "lat25.prepn25450b|lsx.n25450b|juxta|preposition"
    ]

    cex = cexline(juxta)
    @test length(cex) == 3

    for prep in cex
        @test prep in expectedcex
    end
end

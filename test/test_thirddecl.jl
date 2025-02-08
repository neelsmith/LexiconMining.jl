@testset "Test parsing summaries of third declension nouns" begin
    summary = "10099|urn:cite2:hmt:ls.markdown:n10098|confessio | confession, acknowledgement | noun | confessio, confessionis, feminine"

    confessio = summary |> LexiconMining.readdataline |> noun
end
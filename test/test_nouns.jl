
#

@testset "Test reading ChatGPT summaries for nouns" begin
    summary = "51037|urn:cite2:hmt:ls.markdown:n51034|vĭr|a male person, man|noun|vir, viri, m"  
    
    
    vir = summary |> LexiconMining.readdataline |> noun

end
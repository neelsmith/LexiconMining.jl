
#

@testset "Test reading ChatGPT summaries for nouns" begin
    summary = "51037|urn:cite2:hmt:ls.markdown:n51034|vĭr|a male person, man|noun|vir, viri, m"  
    
    
    vir = summary |> LexiconMining.readdataline |> noun
    

    expectedvir = [
        "lat23.nounn51034|lsx.n51034|uir|masculine|0_i",
        "lat24.nounn51034|lsx.n51034|vir|masculine|0_i",
        "lat25.nounn51034|lsx.n51034|vir|masculine|0_i"
    ]
    vircex = cexline(vir)
    @test length(vircex) == 3
    for n in vircex
        @test n in expectedvir
    end

end

#n19461
@testset "Test istems" begin
    
    gens = "19464|urn:cite2:hmt:ls.markdown:n19461|gens | race, clan, or nation | noun | gens, gentis, feminine" |> LexiconMining.readdataline |> noun

    @test LexiconMining.istem(gens)
end

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

    @test cexline(gens) == ["latcommon.nounn19461|lsx.n19461|gent|feminine|i_s_tis"]


    nox = "31312|urn:cite2:hmt:ls.markdown:n31309|nox|night; darkness, obscurity, sleep, death|noun|nox, noctis, feminine"  |> LexiconMining.readdataline |> noun



    visualia = "51143|urn:cite2:hmt:ls.markdown:n51140x|vīsŭālĭa|the power of vision|noun|vīsŭālĭa, vīsŭālĭōrum, neuter " |> LexiconMining.readdataline |> noun

    expectedvisualia = ["lat23.nounn51140x|lsx.n51140x|uisuali|neuter|us_i_pl",
    "lat24.nounn51140x|lsx.n51140x|visuali|neuter|us_i_pl",
    "lat25.nounn51140x|lsx.n51140x|visuali|neuter|us_i_pl"]

    visualiacex = cexline(visualia)
    @test length(visualiacex) == 3
    for ln in visualiacex
        @test ln in expectedvisualia
    end

end
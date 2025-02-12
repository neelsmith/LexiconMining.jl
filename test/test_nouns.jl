
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

    @test cexline(gens) == ["latcommon.nounn19461|lsx.n19461|gen|feminine|i_s_tis"]


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


    xerampelinae = "51481|urn:cite2:hmt:ls.markdown:n51478|xērampĕlĭnae|dark-red or dark-colored clothes|noun|xērampĕlĭnae,xērampĕlĭnārum,feminine"  |> LexiconMining.readdataline |> noun
    
    expectedxerampelinae = ["latcommon.nounn51478|lsx.n51478|xerampelin|feminine|a_ae_pl"]
    @test cexline(xerampelinae) == expectedxerampelinae


    venter = "50450|urn:cite2:hmt:ls.markdown:n50447|venter | belly, paunch, maw, womb | noun | venter, ventris, masculine" |> LexiconMining.readdataline |> noun

    expectedventer = [
        "is it an istem or not?"
    ]

    ventercex =  cexline(venter)
    @test length(ventercex) == 3
    for ln in ventercex
        @test_broken lon in expectedventer
    end



    magudaris = "27656|urn:cite2:hmt:ls.markdown:n27653|măgŭdăris or magudĕris| the stalk/root/juice of a plant | noun | măgŭdăris, măgŭdăris , feminine" |> LexiconMining.readdataline |> noun


    requies = "41286|urn:cite2:hmt:ls.markdown:n41283|rĕ-quĭes|rest, repose|noun|requies, requietis, feminine" |> LexiconMining.readdataline |> noun
end
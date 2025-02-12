@testset "Test parsing summaries of third declension nouns" begin
    summary = "10099|urn:cite2:hmt:ls.markdown:n10098|confessio | confession, acknowledgement | noun | confessio, confessionis, feminine"

    confessio = summary |> LexiconMining.readdataline |> noun
    confessiocex = ["latcommon.nounn10098|lsx.n10098|confessi|feminine|o_onis"]
    @test cexline(confessio) == confessiocex


    similitudo = "44309|urn:cite2:hmt:ls.markdown:n44306|sĭmĭlĭtūdo|likeness, resemblance|noun|similitudo, similitudinis, feminine" |>  LexiconMining.readdataline |> noun
    similitudocex  =  ["latcommon.nounn44306|lsx.n44306|similitud|feminine|o_inis"]
    @test cexline(similitudo) == similitudocex


    pondus = "37010|urn:cite2:hmt:ls.markdown:n37007|pondus |a weight or burden |noun |pondus, ponderis, neuter" |>  LexiconMining.readdataline |> noun
    ponduscex = ["latcommon.nounn37007|lsx.n37007|pond|neuter|us_eris"] 
    @test cexline(pondus) == ponduscex


    gens = "19464|urn:cite2:hmt:ls.markdown:n19461|gens | race, clan, or nation | noun | gens, gentis, feminine" |>  LexiconMining.readdataline |> noun
    genscex = ["latcommon.nounn19461|lsx.n19461|gen|feminine|i_s_tis"]
    @test cexline(gens) == genscex


    codex = "7170|urn:cite2:hmt:ls.markdown:n7169|caudex|trunk of a tree, block of wood, book, ledger|noun|caudex,caudicis,m" |> LexiconMining.readdataline |> noun
    codexcex = ["latcommon.nounn7169|lsx.n7169|caud|masculine|ex_icis"]
    @test cexline(codex) == codexcex


    pestis = "35787|urn:cite2:hmt:ls.markdown:n35784|pestis|a plague, pestilence, or destruction|noun|pestis,pestis,f" |> LexiconMining.readdataline |> noun
    pestiscex = ["latcommon.nounn35784|lsx.n35784|pest|feminine|i_is_is"]
    @test cexline(pestis) == pestiscex

end
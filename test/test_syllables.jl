@testset "Test syllabification" begin
     # LexiconMining.syllabify("amicus")
    @test LexiconMining.syllablecount("amicus") == 3
    

    gens = "19464|urn:cite2:hmt:ls.markdown:n19461|gens | race, clan, or nation | noun | gens, gentis, feminine" |> LexiconMining.readdataline |> noun
    #=
    println(split_into_syllables("amicus"))  # Expected: 
println(split_into_syllables("fortuna")) # Expected: ["for", "tu", "na"]
println(split_into_syllables("magister")) # Expected: ["ma", "gis", "ter"]
println(split_into_syllables("puella")) # Expected: ["pu", "el", "la"]
println(split_into_syllables("sanctus")) # Expected: ["sanc", "tus"]
=#
end
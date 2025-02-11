@testset "Test syllabification" begin
     # LexiconMining.syllabify("amicus")
    @test LexiconMining.syllablecount("amicus") == 3
    

    #=
    println(split_into_syllables("amicus"))  # Expected: 
println(split_into_syllables("fortuna")) # Expected: ["for", "tu", "na"]
println(split_into_syllables("magister")) # Expected: ["ma", "gis", "ter"]
println(split_into_syllables("puella")) # Expected: ["pu", "el", "la"]
println(split_into_syllables("sanctus")) # Expected: ["sanc", "tus"]
=#
end
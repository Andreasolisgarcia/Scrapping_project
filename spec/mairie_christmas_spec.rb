require_relative '../lib/mairie_christmas'

describe "the mairie method" do
   it "Give the name of the town" do
     expect(get_townhall_name("http://annuaire-des-mairies.com/95/aincourt.html")).to eq("Aincourt")
   end
end
describe "the mairie method" do
   it "Give the email of the town" do
     expect(get_townhall_email("http://annuaire-des-mairies.com/95/aincourt.html")).to eq("mairie.aincourt@wanadoo.fr")
   end
end

describe "the mairie method" do
    it "should return the name for the 2 first elements" do
        expect(perform[0].keys[0]).to eq("Ableiges")
        expect(perform[1].keys[0]).to eq("Aincourt")
    end
end
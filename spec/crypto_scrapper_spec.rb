require_relative '../lib/crypto_scraper'

describe "scraper method" do
    it "should return an array of hashes" do
    expect(scraper.class).to eq(Array)
    end
    it "should return a value for the first 3 symbols" do
        expect(scraper[0].keys[0]).to eq("BTC")
        expect(scraper[1].keys[0]).to eq("ETH")
        expect(scraper[2].keys[0]).to eq("USDT")
    end

    it "should return a value for the first values symbols" do
        expect(scraper[0].values[0]).to_not be_nil
        expect(scraper[1].values[0]).to_not be_nil
        expect(scraper[2].values[0]).to_not be_nil
    end
end


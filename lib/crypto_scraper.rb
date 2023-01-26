require 'nokogiri'
require 'open-uri'

def scraper
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))  
    #puts page.class   # => Nokogiri::HTML::Document
    
    name_currency_array  = page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]').collect(&:text)

    # .collect(&:text) equivaut à ça :
    currency_price = page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]')
    
    currency_price_array = []
        currency_price.each do |element|
             currency_price_array << element.text.delete('$,').to_f
         end

    name_price_hash = Hash[name_currency_array.zip(currency_price_array)]

    array_of_hashes_crypto = []
    name_price_hash.each do |key, value|
        array_of_hashes_crypto << {key => value}
    end
    return  array_of_hashes_crypto
end

puts scraper

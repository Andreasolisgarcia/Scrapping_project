require 'nokogiri'
require 'open-uri'

def get_townhall_urls
    page_valdoise = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))  
        #puts page_valdoise.class   => Nokogiri::HTML::Document  (test: regarder que on a bien accès au site web)

        # qui récupère l’e-mail d'une mairie à partir de l'URL de mairies, par exemple celle d'Avernes
    cities_url_incompleate = page_valdoise.xpath('//a[@class="lientxt"]/@href')

        # On obtien ce type de resultat : "./95/ableiges.html" et on cherche plutôt "http://annuaire-des-mairies.com/95/ableiges.html"
        # Donc "http://annuaire-des-mairies.com/" + 95/ableiges.html" (sans le . au debut de "./95....)
    townhalls_url = cities_url_incompleate.map {|last_part_url| "https://www.annuaire-des-mairies.com" + last_part_url.text[1..-1]}
    return townhalls_url
end

# Methode pour obtenir le mail
def get_townhall_email(townhall_url)
    url= Nokogiri::HTML(URI.open(townhall_url))
    mail = url.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    return mail
end

# Methode pour obtenir le nom
def get_townhall_name(townhall_url)
    url = Nokogiri::HTML(URI.open(townhall_url))
    name = url.xpath('//div/main/section[1]/div/div/div/h1').text
    return name[0..-9].downcase.capitalize
end

def hash_to_array_of_hashes(hash)
    array_of_hashes=[]
    hash.each do |key, value|
        array_of_hashes << {key => value}
    end
    return array_of_hashes
end

def perform
    townhalls_urls = get_townhall_urls          #récupérer townhall_url dans la methodeget-townhall_urls
                                               
    mails_array = []                            #créer un array vide pour la boucle each 
    names_array = []                            
    townhalls_urls.each do |url|                #Appliquer la foction get_townhall_email/name dans la même boucle a chaque url
        mails_array << get_townhall_email(url)  #ajouter le email dans l'araay mails_array 
        names_array << get_townhall_name(url) 
    end

    names_mails_hash = Hash[names_array.zip(mails_array)] 

    array_of_hashes_cities_and_mails = hash_to_array_of_hashes(names_mails_hash)
    return array_of_hashes_cities_and_mails
end

puts perform

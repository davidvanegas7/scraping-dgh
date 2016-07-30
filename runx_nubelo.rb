require 'ruby-progressbar'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


def main 
    titles = Array[]
    citys = Array[]
    datas = Array[]
    emails = Array[]
    sites = Array[]
    address = Array[]
    phones = Array[]
    phones2 = Array[]

    begin

        puts "Begining the scraping" 
        (1..3).each do |number|
            
            puts number

            composed_url = "http://www.nubelo.com/proyectos-freelance/?projecttype=freelance&page=#{number}"
            html = open(composed_url)
            doc = Nokogiri::HTML(html, nil, 'UTF-8')
            title = doc.css('[class="dcell dcell-xl dcell-project-title t-fix-width-search"]')

            #puts (title[0].text)[41..-1]
            puts "--------------------------------------------------------"

            title.each do |element|
				puts (element.text)[41..-1]
            	puts element.html('[href="dcell dcell-xl dcell-project-title t-fix-width-search"]')
                #titles.push(element.css('[class="ttl_colapsable"]').text)
                #citys.push(element.css('[class="sttl_colapsable"]')[0].text  )
                #datas.push(element.css('[class="sttl_colapsable"]')[1].text  )
			    #index_correo = element.css('[class="cntr_vermas_info01"]').text.index("Correo electrónico")
                #if index_correo   
                #    emails.push( element.css('[class="cntr_vermas_info01"]').text[index_correo+20, 50])
                #else
                #    emails.push("")
                #end
            
                #if emails.last == ""
                #    titles.pop
                #    citys.pop
                #    datas.pop
                #    emails.pop
                #    sites.pop
                #    address.pop
                #    phones.pop
                #    phones2.pop
                #end

            end
        end
        

            CSV.open("file_name2.csv", "w") do |csv|
                    csv << [
                        "Empresa", "Ciudad","Informacion", "Email",
                        "Sitio", "Direccion", "Telefono", "Telefono2"
                    ]
                    titles.each_with_index do |course, indexx|
                        csv << [
                            titles[indexx],
                            citys[indexx],
                            datas[indexx],
                            emails[indexx],
                            sites[indexx],
                            address[indexx],
                            phones[indexx],
                            phones2[indexx]
                        ]
                    end
                end

    rescue Exception => e
        puts "An error has ocurred: #{e.message}"
    end
end

main    
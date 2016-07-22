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
        (2..551).each do |number|
            
            puts number

            composed_url = "http://www.directoriogestionhumana.com/directorioResultados.aspx?PagActual=#{number}"
            html = open(composed_url)
            doc = Nokogiri::HTML(html, nil, 'UTF-8')
            title = doc.css('[class="ctnr_modulos_new"]')

            title.each do |element|

                titles.push(element.css('[class="ttl_colapsable"]').text)
                citys.push(element.css('[class="sttl_colapsable"]')[0].text  )
                datas.push(element.css('[class="sttl_colapsable"]')[1].text  )

                #puts "data:"
                #puts element.css('[class="cntr_vermas_info01"]').text
                #puts "Correo electronico:"
                index_correo = element.css('[class="cntr_vermas_info01"]').text.index("Correo electrónico")
                if index_correo   
                    emails.push( element.css('[class="cntr_vermas_info01"]').text[index_correo+20, 50])
                else
                    emails.push("")
                end
                #puts "Sitio:"
                index_sitio = element.css('[class="cntr_vermas_info01"]').text.index("Sitio web")
                if index_sitio   
                    sites.push(  element.css('[class="cntr_vermas_info01"]').text[index_sitio+10, 60] )
                else
                    sites.push("")
                end
                #puts "dirección:"
                index_direccion = element.css('[class="cntr_vermas_info01"]').text.index("Dirección")
                if index_direccion   
                    address.push( element.css('[class="cntr_vermas_info01"]').text[index_direccion+11, 55] )
                else
                    address.push("")
                end
                #puts "telefono:"
                index_telefono = element.css('[class="cntr_vermas_info01"]').text.index("Teléfono")
                if index_telefono   
                    phones.push( element.css('[class="cntr_vermas_info01"]').text[index_telefono+10, 15] )
                else
                    phones.push("")
                end
                #puts "telefono 2:"
                index_telefono2 = element.css('[class="cntr_vermas_info01"]').text.index("Teléfono 2")
                if index_telefono2   
                    phones2.push( element.css('[class="cntr_vermas_info01"]').text[index_telefono2+12, 15])
                else
                    phones2.push("")
                end

                if emails.last == ""
                    titles.pop
                    citys.pop
                    datas.pop
                    emails.pop
                    sites.pop
                    address.pop
                    phones.pop
                    phones2.pop
                end

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
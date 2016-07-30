require 'ruby-progressbar'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


def main 
    titles = Array[]
    links = Array[]
    publications = Array[]
    times = Array[]
    works = Array[]
	ubications = Array[]
    budgets = Array[]
	experiences = Array[]
    countries = Array[]
    clients = Array[]
    messages = Array[]
    contents = Array[]




    begin

        puts "Begining the scraping" 
        (1..55).each do |number|
            
            puts number

            composed_url = "http://www.nubelo.com/proyectos-freelance/?projecttype=freelance&page=#{number}"
            html = open(composed_url)
            doc = Nokogiri::HTML(html, nil, 'UTF-8')
            title = doc.css('[class="dcell dcell-xl dcell-project-title t-fix-width-search"]')

            #puts (title[0].text)[41..-1]
            puts "--------------------------------------------------------"

            title.each do |element|

            	other_link = element.css('a').map { |link| link['href'] }
				html2 = open(other_link[0])
				#puts other_link[0]
            	doc2 = Nokogiri::HTML(html2, nil, 'UTF-8')
   	            details = doc2.css('[class="detailjob__list"]')

   	            elementdetails1 = details[0]
   	            elementdetails2 = details[1]

   	            #puts elementdetails1.text.index("Publicación:")
   	            index_publication = elementdetails1.text.index("Publicación")
	            if index_publication   
	                publications.push( elementdetails1.text[index_publication+20, 30])
	            else
	                publications.push("")
	            end

	            index_time = elementdetails1.text.index("Tiempo restante")
	            if index_time   
	                times.push( elementdetails1.text[index_time+17, 30])
	            else
	                times.push("")
	            end

	            index_work = elementdetails1.text.index("Tipo de trabajo")
	            if index_work   
	                works.push( elementdetails1.text[index_work+17, 30])
	            else
	                works.push("")
	            end

	            index_ubication = elementdetails1.text.index("Ubicación")
	            if index_ubication   
	                ubications.push( elementdetails1.text[index_ubication+11, 30])
	            else
	                ubications.push("")
	            end

	            index_budget = elementdetails2.text.index("Presupuesto")
	            if index_budget   
	                budgets.push( elementdetails2.text[index_budget+13, 30])
	            else
	                budgets.push("")
	            end

	            index_experience = elementdetails2.text.index("Experiencia requerida")
	            if index_experience   
	                experiences.push( elementdetails2.text[index_experience+23, 40])
	            else
	                experiences.push("")
	            end

				client = doc2.css('[class="client-profile-name"]')            
   	            clients.push( client.text[1..-1] )

   	            country = doc2.css('[class="client-profile-field client-profile-country"]')            
   	            countries.push( country.text[14..-1] )
   	            
				content = doc2.css('[class="project-desc-content"]')            
   	            contents.push( content.text )

				message = doc2.css('[class="make-proposal--rclmn-paragraph first"]')            
   	            messages.push( message.text )

           		titles.push(  (element.text)[41..-1]  )
            	links.push(  other_link[0]  )

            end
        end
        

            CSV.open("nubelo_works.csv", "w") do |csv|
                    csv << [
                        "Titulo", "Link","Publicación", "Tiempo Restante",
                        "Tipo de trabajo", "Ubicación", "Presupuesto", "Experiencia Requerida",
                        "Cliente","Pais","Contenido", "Mensaje"
                    ]
                    titles.each_with_index do |course, indexx|
                        csv << [
                            titles[indexx],
                            links[indexx],
							publications[indexx],
							times[indexx],
							works[indexx],
							ubications[indexx],
							budgets[indexx],
							experiences[indexx],
							clients[indexx],
							countries[indexx],
							contents[indexx],
							messages[indexx]

                        ]
                    end
                end

    rescue Exception => e
        puts "An error has ocurred: #{e.message}"
    end
end

main    
#http://compra.avianca.com/NBAmadeus/InicioAmadeus.aspx?cco=CLO&ccd=BAQ&fi=06AUG&fr=06AUG&na=1&nn=0&ni=0&lan=ES&tt=4&Pais=CO&ccorp=0&hvi=0&hvr=0&tarifa=0&VInt=no&SistemaOrigen=AH&Cabina=0&FFl=true&FriendlyID=&FriendlyIDNegoF=&tv=false&MPD=8621&IvaMPD=1379&WS=null
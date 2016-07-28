require 'ruby-progressbar'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'


def main 

   column1 = Array[]
   emails = Array[]

   csv_text = File.read('google.csv', 2)
   #csv_text = CSV.read('google.csv', 'UTF-8')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      (0..29).each do |index|
          puts index
          #if /@/.match(row[index])
            #puts index
            #column1.push( (row[index]) )
            #puts "index: #{index} y row #{row[index]}"
          #end
      end
   
    end

#    CSV.open("all_all_data.csv", "w") do |csv|
#                    csv << [
#                        "Empresa", "Ciudad","Informacion", "Email",
#                        "Sitio", "Direccion", "Telefono", "Telefono2"
#                    ]
#                    titles.each_with_index do |course, indexx|
#                        csv << [
#                            titles[indexx],
#                            citys[indexx],
#                            datas[indexx],
#                            emails[indexx],
#                            sites[indexx],
#                            address[indexx],
#                            phones[indexx],
#                            phones2[indexx]
#                        ]
#                    end
#                end
end

main    
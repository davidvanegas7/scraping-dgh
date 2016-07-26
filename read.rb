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

   csv_text = File.read('all_all_data.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      #puts (row[0])[49,(row[0]).length-49]
      #puts (row[1])[49,(row[1]).length-49]
      titles.push( (row[0]) )
      citys.push( (row[1]) )
      datas.push( (row[2])[49,(row[2]).length-49] )
      emails.push( (row[3]) )
      sites.push( (row[4]) )
      address.push( (row[5]) )
      phones.push( (row[6]) )
      phones2.push( (row[7]) )
      #Moulding.create!(row.to_hash)
    end

    CSV.open("all_all_data.csv", "w") do |csv|
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
end

main    
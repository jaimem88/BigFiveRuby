#!/usr/bin/ruby -w

class BigFiveResultsTextSerializer
    attr_reader :text

    def initialize(text)
        @text = text
    end

    def hash()
        hash = {}
        hash['NAME'] = 'Jaime Martinez'
        section_regex = /^[A-Z ]+\.+\d{2}/
        score_regex = /^\.{2}[\w -]+\.+\d{2}/

        section_name =""
        overall_score=0
        facets ={}
        counter = 0
        self.text.each_line do |line|
            
            # facets ={}
            if line =~ section_regex
                tmp = line.split(/\./)
                # puts tmp
                section_name = tmp[0]
                overall_score = tmp[tmp.length - 1].to_i
                
                # hash[section_name]={}
            
            elsif line =~ score_regex
                tmp = line.split(/\./)
                name = tmp[2]
                this_score =  tmp[tmp.length - 1].to_i
                
                facets[name]= this_score
                # Every section has 6 attritbutes
                counter+=1
                if counter == 6
                    hash[section_name]={'Overall Score'=> overall_score,'Facets'=> facets}
                    facets ={}
                    counter=0
                end
            end
        end
        return hash
    end
end
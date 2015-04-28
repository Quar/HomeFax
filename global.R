library(jsonlite)
library(tm)
library(wordcloud)
library(memoise)
library(ggmap)

getNeighourhood_byAddress <- function (address) {
    # TODO: add check to ensure ended with , Winnipeg
    return(revgeocode(as.numeric(geocode(address)), output="more")$neighborhood)
    #need to handle exception
}

getNeighourhood_Info <- function(neighborhood, tableKey) {
    link = paste0("http://data.winnipeg.ca/resource/", tableKey, ".json?boundary_type=Neighbourhood&boundary_name=", neighborhood)
    qry = url( URLencode(link) )
    return(fromJSON(qry))
}

getFax <- function(neighborhood) {
    print("neighborhood info get start")
    tb = getNeighourhood_Info(neighborhood, "8xwc-nv6i")
    print("neighborhood info get end")
    tb2 = as.numeric(tb)
    tb = tb[!is.na(tb2)]
    return(tb)
}


formattedNames <- function(name) {
    name = gsub("_", " ", names(name))
    return(name)
}


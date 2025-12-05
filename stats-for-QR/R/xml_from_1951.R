#XML going back to 1951.  Not currently used.
hurs <- read_xml("https://www.nhc.noaa.gov/TCR_StormReportsIndex.xml")

#The following code works as long as each row has excaly one of these:
hur_df <- data.frame(
  StormNames = xml_text(xml_find_all(hurs, '//StormName')),
  StormReportURL = xml_text(xml_find_all(hurs, '//StormReportURL')),
  Year = xml_text(xml_find_all(hurs, '//Year')),
  Basin = xml_text(xml_find_all(hurs, '//Basin'))
)

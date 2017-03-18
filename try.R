u <- "http://www.zameen.com/search/results.html?tab_city=&developer_id=&tab_cat_id=&property_type=&tab_type=9%2C8%2C21%2C22%2C20%2C24%2C25&development_id=&tab_beds=&sb_price_from=No+Min&sb_price_to=No+Max&tab_price=&tab_sqft_unit=Marla&sb_sel_area=3&tab_sqft_input1=No+Min&tab_sqft_input2=No+Max&tab_sqft_custom=1&tab_sqft_conv_unit=3&tab_sqft=&tab=1&tab_purpose=1&tab_search=1"
kk <- getURL(u)

curl = getCurlHandle()
options(agent = "Chrome 55.0.2883.87 (32-bit)")

library(httr)
u <- "/v3/index.php?t=ajax&c=ajax_load_mac_box&file=multiple_agent_contact_cache_400748b307710216099f7e31d11d7d01_en.php"
POST(url = u, config = list( add_headers(Host = www.zameen.com,
                                         Connection = keep-alive,
                                         Content-Length = 1177,
                                         Accept = */*,
                                         Origin = http://www.zameen.com,
                                         X-Requested-With = XMLHttpRequest,
                                         User-Agent = Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36,
                                         Content-Type = application/x-www-form-urlencoded; charset=UTF-8,
                                         Referer = http:/www.zameen.com/search/results.html?tab_city=&developer_id=&tab_cat_id=&property_type=&tab_type=9%2C8%2C21%2C22%2C20%2C24%2C25&development_id=&tab_beds=&sb_price_from=No+Min&sb_price_to=No+Max&tab_price=&tab_sqft_unit=Marla&sb_sel_area=3&tab_sqft_input1=No+Min&tab_sqft_input2=No+Max&tab_sqft_custom=1&tab_sqft_conv_unit=3&tab_sqft=&tab=1&tab_purpose=1&tab_search=1,
                                         Accept-Encoding = gzip, deflate,
                                         Accept-Language = en-US,en;q=0.8)), body = list(page=1,     
                                                                             tab_type = "9,8,21,22,20,24,25"
                                                                             tab_purpose =1,
                                                                             tab_sqft_unit ="Marla",
                                                                             tab_sqft_conv_unit = 3,
                                                                             tab_sqft_custom = 1,
                                                                             tab_search = 1,
                                                                             property_type = "9,8,21,22,20,24,25",
                                                                             rd_purpose = 1,
                                                                             tab_city = 0,
                                                                             filter_city = 0,
                                                                             wantedfor = "Buy",
                                                                             tab_sqft_input1 = 0,
                                                                             sqft_input1 = 0,
                                                                             sqft_input2 = 0,
                                                                             sqft_unit = "Marla",
                                                                             sqft_conv_unit = 3,
                                                                             sqft_custom = 1,
                                                                             allowed_mac_cat_lvl = "false",
                                                                             ea_alert_pop_json = "%7B%22rd_purpose%22%3A%221%22%2C%22property_type%22%3A%229%2C8%2C21%2C22%2C20%2C24%2C25%22%2C%22wantedfor%22%3A%22Buy%22%2C%22sqft_conv_unit%22%3A3%2C%22sqft_unit%22%3A%22Marla%22%2C%22sqft_custom%22%3A%221%22%2C%22page%22%3A1%2C%22tab_type%22%3A%229%2C8%2C21%2C22%2C20%2C24%2C25%22%2C%22tab_purpose%22%3A%221%22%2C%22tab_sqft_unit%22%3A%22Marla%22%2C%22tab_sqft_conv_unit%22%3A3%2C%22tab_sqft_custom%22%3A%221%22%2C%22tab_search%22%3A%221%22%2C%22cat_id%22%3Anull%7D"),encode = "form") 

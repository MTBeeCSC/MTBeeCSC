# mikebee's key: 53106010-C556-32C6-877F-1C9355E9FA5C
#      paste('https://quickstats.nass.usda.gov/api/api_GET/?key=53106010-C556-32C6-877F-1C9355E9FA5C'
#           ,'commodity_desc=COTTON'
#           ,'year__GE=1975'
#           ,'state_alpha=VA'
#           ,'format=JSON'
#           ,sep='&'
#           )
#                   ^
#                   |
# 1. flesh this out-+
# 2. create get_api_key.R/put_api_key.R
# 3. see if there's a better data frame to excel option...
library(httr)
library(jsonlite)
# Define the API endpoint URL
api_url <- paste(paste('https://quickstats.nass.usda.gov/api/api_GET/?key'
                       ,'53106010-C556-32C6-877F-1C9355E9FA5C'
                       ,sep='=')
                 ,'commodity_desc=cotton'
                 ,'year__GE=1975'
                 ,'state_alpha=VA'
                 ,'format=JSON'
                 ,sep='&')
# Make the GET request
# Define the API endpoint URL with your specific parameters
# api_url <- "https://quickstats.nass.usda.gov/api/api_GET/?key=BE61E5EA-226F-3F83-8B86-557E7028662F&commodity_desc=CORN&year__GE=2012&state_alpha=VA&format=JSON"
# Make the GET request
print('api_url')
response <- GET(url = api_url)
# Check the HTTP status code
status <- http_status(response)$category
if (status == "Success") {
  # Parse and process the API response
  data <- fromJSON(content(response, as = "text"))
  # Convert the data to a data frame (assuming it's a list of records)
  df <- as.data.frame(data)
  # Specify the file path for saving the CSV file
  csv_file <- "C:/Users/Public/Projects/ERS/_XLS/usda_data_table4_cotton.csv"
  
  # Save the data frame to a CSV file without row names
  write.csv(df, file = csv_file, row.names = FALSE)
  
  # Print a message indicating that the data has been saved
  cat("Data has been saved to", csv_file, "\n")
} else {
  cat("API request failed. Check your API key and parameters.")
}

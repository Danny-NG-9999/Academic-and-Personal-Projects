# Name: Daniel (Viet) Nguyen
# StudentID: 740095294

# Check R version
R.version.string

# Table of Contents ============
# 1. Load Required Libraries
# 2. Load and Clean Data
# 3. Time Series Transformation
# 4. Stationarity Testing
# 5. Model Estimation
# 6. Forecasting
# 7. Visualization
# 8. Conclusion
# R script: Ctrl+Shift+O
# R markdown: https://bookdown.org/yihui/rmarkdown/html-document.html

# List of useful packages for time series and econometric analysis --------------------------------------
packages <- c(
  "AER",        # Tools and datasets for applied econometrics
  "readxl",     # To read Excel (.xlsx) files into R
  "xts",        # To work with time series data (especially financial)
  "zoo",        # To handle ordered time series data (both regular and irregular)
  "dynlm",      # To run regression models with time lags (dynamic linear models)
  "stargazer",  # To nicely format regression results for reports (LaTeX, HTML, or text)
  "urca",       # To test for unit roots and cointegration in time series
  "orcutt",     # To correct autocorrelation in regression models (Cochrane-Orcutt method)
  "fGarch",     # To estimate volatility models like GARCH
  "plm",        # To conduct panel data analysis
  "quantmod")    # To get and model financial and economic data (quantitative modeling)

## Loop through the list and install any packages that are not already installed
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {install.packages(pkg)}}

## Load and install packages useful for regime-switching models or Markov switching models
if (!require("tsDyn")) install.packages("tsDyn") # tsDyn: Threshold autoregression and Markov switching models
if (!require("TSA")) install.packages("TSA") # TSA: Time Series Analysis functions
if (!require("markovchain")) install.packages("markovchain") # markovchain: Create and simulate Markov chains
if (!require("MSwM")) install.packages("MSwM") # MSwM: Markov Switching Models for linear regression

## Load and install packages useful for cleaning, wrangling, and visualizing data
if (!require("janitor")) install.packages("janitor") # janitor: Quickly clean column names and inspect data frames
if (!require("dplyr")) install.packages("dplyr") # dplyr: Core grammar of data manipulation (part of tidyverse)
if (!require("tidyverse")) install.packages("tidyverse") # tidyverse: A collection of packages for data science (includes dplyr, ggplot2, etc.)
if (!require("tidyquant")) install.packages("tidyquant") # tidyquant: Brings financial analysis and modeling tools to the tidyverse

## Additional packages for geocoding and mapping
extra_packages <- c("tidygeocoder",  # Geocode place names to lat/lon
                    "ggplot2",       # Data visualization
                    "maps")          # Map outlines and data

## Install any missing extra packages
for (pkg in extra_packages) {
  if (!require(pkg, character.only = TRUE)) {install.packages(pkg)}}

## Load all required libraries in one line
lapply(c("AER", "readxl", "xts", "zoo", "dynlm", "stargazer", "urca", "orcutt", "fGarch", "plm", "quantmod",
         "tidyr", "dplyr", "janitor", "tidyverse", "tidyquant", "ggplot2", "scales", "tidygeocoder", "maps", "tibble",
         "TSA", "MSwM", "markovchain"), library, character.only = TRUE)

library(ggrepel)     # For better placement of text labels
library(randomcoloR) # for more than 12 colors

## Install writexl if not already installed
if (!require(writexl)) install.packages("writexl") # For exporting data frames to Excel files

## Load the library
library(writexl)
library(lubridate) # For date and time manipulation, including the year() function to extract years from dates.

install.packages("gt") # For creating publication-quality tables with customizable formatting and styling for data presentation
library(gt)
library(webshot2) # For saving as image

# ==== Section 1: Data Importing and Cleaning ====
## Set the working directory to where the Excel files are located
setwd("C:/Users/danie/Downloads/Dissertation")

## Section 1.1: Air transport movement by Aircraft Configuration data -----------------------------------
### Import data on air transport movement data by aircraft configuration and UK airport region
### This allows us to examine movement patterns and compare traffic across different aircraft types and regions
air_movement <- read_excel(path = "Combined Air Transport Movements data.xlsx")
head(air_movement) # Preview the top rows to inspect structure

### Cleaned dataset: remove NAs and "N/A" from region, and filter years 1998–2023
air_movement_clean <- air_movement %>%
  filter(
    !is.na(reporting_region_name),                # Remove rows where the region name is missing
    reporting_region_name != "N/A",               # Remove rows where the region is labeled "N/A"
    this_period >= 1998, this_period <= 2023) %>% # Keep only data from 1998 to 2023
  rename(report_period = this_period,             # Rename 'this_period' to 'report_period' to standardize
         atms_pax_aircraft_report_period = atms_pax_aircraft_this_period,
         atms_cargo_aircraft_report_period = atms_cargo_aircraft_this_period) 

#### Total movement by passenger aircraft across all regions per year
summary_by_year_pax_movement <- air_movement_clean %>%
  group_by(report_period) %>%
  summarise(total_pax_aircraft_movement = sum(atms_pax_aircraft_report_period, na.rm = TRUE), .groups = "drop") # Drop the grouping structure

#### Total movement by passenger aircraft across all regions per year
summary_by_year_cargo_movement <- air_movement_clean %>%
  group_by(report_period) %>%
  summarise(total_cargo_aircraft_movement = sum(atms_cargo_aircraft_report_period, na.rm = TRUE), .groups = "drop") # Drop the grouping structure

## ==== Section 1.2: Freight (Cargo) data ====
### Import data on freight volumes by aircraft configuration, grouped by UK airport regions
freights <- read_excel(path = "Combined Cargo data.xlsx")
head(freights) # Preview the top rows to inspect structure

### Clean and filter the freight data
freights_clean <- freights %>%
  filter(
    !is.na(reporting_region_name),                # Remove rows where the region name is missing
    reporting_region_name != "N/A",               # Remove rows where the region is labeled "N/A"
    this_period >= 1998, this_period <= 2023) %>% # Keep only data from 1998 to 2023
  rename(report_period = this_period,             # Rename 'this_period' to 'report_period' to standardize
         total_freight_pax_aircraft_report_period = total_freight_passenger_aircraft_this_period,
         total_freight_cargo_aircraft_report_period = total_freight_cargo_aircraft_this_period)

str(freights_clean)

### ==== ✈️ Section 1.2.1. Freight volume unloaded by passenger aircraft ====
freights_pax_aircraft <- freights_clean %>%
  group_by(reporting_region_name, report_period) %>%  ### Group by both region and year
  mutate(
    ### Calculate the total freight volume for the entire region for a specific year
    region_total_freight_pax_aircraft = sum(total_freight_pax_aircraft_report_period, na.rm = TRUE),  
    ### Calculate each airport's freight share within its region for that year.
    freight_pax_airport_share = round((total_freight_pax_aircraft_report_period / region_total_freight_pax_aircraft), 2)) %>%
  ### Remove grouping structure to allow further operations across all rows
  ungroup() %>% ### Remove grouping for clean processing
  ### Sort: First by year, then by region, then descending airport freight share
  arrange(report_period, reporting_region_name, desc(freight_pax_airport_share)) %>%
  ### Select relevant columns for downstream processing or analysis
  dplyr::select(report_period, airport_name, iata_code,
         reporting_region_name, total_freight_pax_aircraft_report_period,
         region_total_freight_pax_aircraft, freight_pax_airport_share)

### View result
view(freights_pax_aircraft)

### Join freights_pax_aircraft data with air_movement_clean data (left join)
freight_pax_aircraft_movement_combined <- left_join(
  freights_pax_aircraft,         # Left table
  air_movement_clean,            # Right table
  by = c("report_period", "airport_name", "iata_code", "reporting_region_name")  # Join keys
) %>% select(report_period, airport_name, iata_code, 
             icao_code, reporting_region_name,
             atms_pax_aircraft_report_period,          # Air traffic movement by passenger aircraft
             total_freight_pax_aircraft_report_period, # Total freight unloaded from passenger aircraft
             region_total_freight_pax_aircraft, freight_pax_airport_share) %>% 
  ### Remove rows with more than 2 NAs across selected share-related columns
  filter(rowSums(is.na(across(c(region_total_freight_pax_aircraft, freight_pax_airport_share)))) < 2) # Keep rows with 2 or fewer NAs

### Identify airports still active in 2023 based on freight_cargo_aircraft_movement_combined data
operating_freight_pax_airports_2023 <- freight_pax_aircraft_movement_combined %>%
  filter(report_period == 2023) %>%         # Filter year 2023
  filter(freight_pax_airport_share > 0) %>% # Keep only airports that contributed positively to regional freight
  pull(iata_code) %>%                       # Extract IATA codes
  unique()                                  # Ensure no duplicates

#### ==== ✈ Generate Summary Table: Regional Freight Metrics from Passenger Aircraft (2023) ====
freight_pax_aircraft_summary_2023 <- freight_pax_aircraft_movement_combined %>%
  filter(report_period == 2023) %>%                               # Keep only data from the year 2023
  filter(iata_code %in% operating_freight_pax_airports_2023) %>%  # Keep only airports identified as operating in 2023
  select(report_period, airport_name, iata_code,
    reporting_region_name, atms_pax_aircraft_report_period, 
    total_freight_pax_aircraft_report_period,
    region_total_freight_pax_aircraft, freight_pax_airport_share) %>%
  filter(!is.na(total_freight_pax_aircraft_report_period)) %>%    # Remove rows with missing freight values
  filter(freight_pax_airport_share > 0) %>%                       # Keep only airports that contributed positively to regional freight
  mutate(freight_pax_airport_share = round(freight_pax_airport_share * 100, 2)) %>%  # Convert share to percentage and round to 2 decimal places
  group_by(reporting_region_name, airport_name, iata_code,        # Group data by specified variables for summarization
    total_freight_pax_aircraft_report_period, 
    region_total_freight_pax_aircraft, freight_pax_airport_share,
    atms_pax_aircraft_report_period) %>%
  summarise(region_total_freight_pax_aircraft = sum(total_freight_pax_aircraft_report_period, na.rm = TRUE), .groups = "drop") # Calculate total regional freight by summing freight values, dropping grouping structure

#### Generate a styled static table (GT)
freight_pax_table <- freight_pax_aircraft_summary_2023 %>%
  select(reporting_region_name, iata_code,
         total_freight_pax_aircraft_report_period,
         region_total_freight_pax_aircraft,
         freight_pax_airport_share,
         atms_pax_aircraft_report_period) %>%
  gt() %>%                                                        # Convert data frame to a gt table for formatting
  tab_header(                                                     # Add table title and subtitle
    title = md("**Freight Handled by Passenger Aircraft (2023)**"), # Set bold title using Markdown
    subtitle = "By Airport Across UK ITL1 Regions") %>%             # Add subtitle for context
  cols_label(                                                     # Rename columns for better readability
    reporting_region_name = "Region",
    iata_code = "IATA",
    total_freight_pax_aircraft_report_period = "Freight Volume (Tonnes)",
    region_total_freight_pax_aircraft = "Total Regional Freight (Tonnes)",
    freight_pax_airport_share = "Percentage of Regional Freight (%)",
    atms_pax_aircraft_report_period = "Passenger Aircraft Movements (ATMs)") %>%
  fmt_number(                                                     # Format numeric columns
    columns = c(total_freight_pax_aircraft_report_period,
      region_total_freight_pax_aircraft,
      atms_pax_aircraft_report_period,
      freight_pax_airport_share),
    decimals = 2, use_seps = TRUE, sep_mark = ",") %>%            # Set 2 decimal places and add thousand separators
  cols_align(align = "center", columns = everything()) %>%        # Center-align all columns
  tab_style(                                                      # Make column headers bold
    style = cell_text(weight = "bold"),
    locations = cells_column_labels()) %>%
  tab_options(                                                    # Set table styling options
    table.font.size = px(12),                                     # Set font size to 12 pixels
    column_labels.font.weight = "bold",                           # Bold the column labels
    column_labels.background.color = "#f2f2f2")                   # Set light gray background for column headers

#### Export the static table as a PNG image
gtsave(freight_pax_table,
  filename = "freight_pax_table_2023_wide.png",
  expand = 10,         # Adds padding around the table (higher value = more space)
  vwidth = 1600,       # Set width for better column fitting
  vheight = 1800)      # Set height to prevent row clipping

#### Print the GT table to RStudio Viewer
print(freight_pax_table)
#### Save table as PDF document
gtsave(freight_pax_table, "airport_freight_2023.pdf")
#### Export underlying data to CSV for future analysis
write.csv(freight_pax_table, "airport_freight_2023.csv", row.names = FALSE)

#### Load packages for interactive HTML table
if(!require(DT)) install.packages("DT")
if(!require(htmlwidgets)) install.packages("htmlwidgets")
library(DT)
library(htmlwidgets)
library(htmltools)

#### Create an interactive, downloadable HTML table with export buttons
interactive_freight_pax_table <- datatable(
  freight_pax_aircraft_summary_2023 %>%
    select(
      Region = reporting_region_name, 
      `IATA Code` = iata_code,
      `Freight Volume (Tonnes)` = total_freight_pax_aircraft_report_period,
      `Total Regional Freight (Tonnes)` = region_total_freight_pax_aircraft,
      `Percentage of Regional Freight (%)` = freight_pax_airport_share,
      `Passenger Aircraft Movements (ATMs)` = atms_pax_aircraft_report_period
    ) %>%
    mutate(across(where(is.numeric), ~ format(round(., 2), big.mark = ",", nsmall = 2))), # Format numbers with thousands separators and 2 decimal places
  extensions = 'Buttons',                                                                 # Enable button extensions for export options
  options = list(
    dom = 'Bfrtip',                                                                       # Define table control elements (Buttons, filter, table, info, pagination)
    buttons = c('copy', 'csv', 'excel', 'pdf'),                                           # Add export buttons                                          
    pageLength = 10,                                                                      # Default page length set to 10
    lengthMenu = list(c(20, 50, 100), c("20", "50", "100")),                              # Customize page length options
    autoWidth = TRUE,                                                                     # Allow automatic column width adjustment
    columnDefs = list(list(className = 'dt-center', targets = '_all')),                   # Center-align all column contents
    #### Add custom centered header with title and subtitle, inserted only once 
    headerCallback = JS(
      "function(thead, data, start, end, display) {",
      "  var tableContainer = $(thead).closest('div.dataTables_wrapper');",
      "  var headerDiv = tableContainer.prev('div.custom-header');",
      "  if (!headerDiv.length) {",  # Only insert if it doesn't already exist
      "    tableContainer.before('<div class=\"custom-header\" style=\"text-align: center; width: 100%; margin-bottom: 20px;\"><h3 style=\"font-weight: bold; margin-bottom: 5px;\">Freight Handled by Passenger Aircraft (2023)</h3><h4 style=\"margin-top: 0; color: #666;\">By Airport Across UK ITL1 Regions</h4></div>');",
      "  }",
      "}")),
  rownames = FALSE,                                                                       # Disable row names
  filter = 'top',                                                                         # Add filters at the top of each column
  class = 'display',                                                                      # Ensure proper DataTables styling
  escape = FALSE)                                                                         # Allow HTML/CSS to render properly
#### Save the interactive table with a specific title and optimized display
saveWidget(
  interactive_freight_pax_table,
  file = "airport_freight_pax_2023_interactive.html",                                         # File output name
  title = "Freight Handled by Passenger Aircraft (2023) - By Airport Across UK ITL1 Regions",
  selfcontained = TRUE)


### Top 3 airports by total freight carried by passenger aircraft over the entire period
top3_pax_freight_airports_by_region <- freight_pax_aircraft_movement_combined %>%
  ### Keep only airports that contributed positively to regional freight
  filter(freight_pax_airport_share > 0) %>% 
  group_by(reporting_region_name, airport_name, iata_code) %>%
  ### Total freight handled by passenger aircraft for each airport over the entire period
  summarise(total_freight_pax_aircraft = sum(total_freight_pax_aircraft_report_period, na.rm = TRUE),
            ### Total pax_aircraft movements for each airport over the entire period
            total_atms_pax_aircraft = sum(atms_pax_aircraft_report_period, na.rm = TRUE), .groups = "drop") %>%
  ### Remove airports that handled 0 freight during the entire period
  filter(total_freight_pax_aircraft > 0) %>%
  ### Keep only airports still in operation in 2023
  filter(iata_code %in% operating_freight_pax_airports_2023) %>%
  ### Group by region to compute regional totals and each airport’s share
  group_by(reporting_region_name) %>%
  ### Add new columns: regional total freight and the share of freight for each airport within the region
  mutate(region_total_freight = sum(total_freight_pax_aircraft, na.rm = TRUE),
         pax_freight_share = round(total_freight_pax_aircraft / region_total_freight, 4)) %>%
  ### Sort airports by freight in descending order within each region
  arrange(reporting_region_name, desc(total_freight_pax_aircraft)) %>%
  ### Rank airports within its region based on freight volume
  mutate(rank = row_number()) %>%
  ### Keep only the top 3 airports in each region based on the assigned rank
  filter(rank <= 3) %>%
  ### Select and reorder the final columns for clarity and relevance
  select(reporting_region_name, airport_name, iata_code, total_atms_pax_aircraft, total_freight_pax_aircraft, region_total_freight, pax_freight_share)

### View the result
View(top3_pax_freight_airports_by_region)

#### ==== 📊 Plot 1: Horizontal Bar Chart of Top 3 airports by total freight carried by passenger aircraft over the entire period ====
#### Define a color-blind-friendly and visually distinct palette for UK regions
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")
#### Plot the horizontal bar chart
ggplot(top3_pax_freight_airports_by_region, aes(
  x = reorder(iata_code, pax_freight_share),     #### Reorder airport names (iata_code) by pax_freight_share) (ascending)
  y = pax_freight_share,                         #### Use pax_freight_share as the bar height
  fill = reporting_region_name)) +               #### Fill bars by region with different color to differentiate groups
  #### Create the bars with height equal to pax_freight_share
  geom_bar(stat = "identity") +
  #### Add percentage labels (2 decimal places) to the end of each bar
  geom_text(
    aes(label = sprintf("%.2f%%", pax_freight_share * 100)),  #### Convert share to percentage format
    hjust = -0.1,                                             #### Slightly offset text to the right of the bar
    size = 3.0) +                                             #### Set text size
  #### Flip coordinates to make the bars horizontal
  coord_flip() +
  #### Add title and axis labels
  labs(
    title = "Freight Transported via Passenger Aircraft \n Top 3 Regional Airports (2023)",                 #### Chart title
    x = "Airport Code",                                                                                   #### Label for y-axis (after flip)
    y = "Freight Share (%)") +                                                                            #### Label for x-axis (after flip)
  #### Format y-axis (now horizontal axis) to fixed breaks: 0%, 50%, 100%
  scale_y_continuous(
    labels = function(x) sprintf("%.2f%%", x * 100),  #### Convert from proportion to % label (e.g., 0.456 → "45.60%")
    breaks = c(0, 0.25, 0.5, 0.75, 1.0),              #### Tick marks at 0%, 25%, 50%, 75%, 100%
    limits = c(0, max(top3_pax_freight_airports_by_region$pax_freight_share) * 1.1)) +   #### Add space to the right of bars for label visibility
  #### Apply a color palette for region fill
  # scale_fill_brewer(palette = "Set3") +
  scale_fill_manual(values = region_colors) +  ### ✅ CUSTOM COLORS APPLIED HERE
  #### Use a clean, minimal theme and adjust font styling
  theme_minimal(base_size = 12) +
  theme(
    axis.text.y    = element_text(size = 10),                   #### Increase size of airport names
    axis.title     = element_text(face = "bold"),               #### Make axis titles bold
    plot.title     = element_text(face = "bold", hjust = 0.5, size = 13),  #### Center and bold the title
    legend.title   = element_blank(),                           #### Remove legend title for simplicity
    legend.position = "bottom")                                 #### Move legend to the right of chart

#### ==== 📊 Plot 2: Faceted Bar Chart by Region ====
top3_pax_freight_airports_by_region <- top3_pax_freight_airports_by_region %>%
  group_by(reporting_region_name) %>%                           #### Group by region
  arrange(desc(pax_freight_share), .by_group = TRUE) %>%        #### Sort by descending passenger share
  mutate(color_group = as.character(row_number())) %>%          #### Assign ranks 1, 2, 3 as character (for color use)
  ungroup()

#### Plot the bar chart
ggplot(top3_pax_freight_airports_by_region, aes(
  x = reorder(iata_code, -pax_freight_share),                   #### Order airports (iata_code) by descending share
  y = pax_freight_share,                                        #### Use pax_freight_share for bar height
  fill = color_group)) +                                        #### Color bars by rank group
  geom_bar(stat = "identity", width = 0.6) +                    #### Create bars with fixed width
  geom_text(
    aes(label = sprintf("%.2f%%", pax_freight_share * 100)),    #### Format labels with 2 decimal places and % sign
    vjust = -0.4,                                               #### Position labels slightly above bars
    size = 2.5,                                                 #### Smaller text size for labels
    position = position_dodge(width = 0.6)) +                   #### Align labels with bars
  facet_wrap(~ reporting_region_name,                           #### Create separate subplots for each region
             scales = "free_x",                                 #### Allow x-axis to scale independently per facet
             ncol = 3) +                                        #### Set number of columns to 3 for layout
  
  labs(title = "Freight Transported via Passenger Aircraft \n Top 3 Regional Airports (2023)",
       x = "Airport Code",                                              #### X-axis label
       y = "Freight Share (%)") +                                       #### Y-axis label
  #### Manually assign fill colors based on rank (1st = dark navy blue, 2nd = medium steel blue, 3rd = light sky blue)
  scale_fill_manual(values = c("1" = "#0D3B66", "2" = "#1D6996", "3" = "#A6CEE3")) +
  #### Format y-axis as percentage and add space above bars for text visibility
  scale_y_continuous(
    labels = scales::percent,                                          #### Show axis ticks as percentages
    expand = expansion(mult = c(0, 0.2))) +                            #### Add 20% space above the tallest bar
  #### Apply clean visual styling
  theme_minimal(base_size = 10) +                                      #### Minimal base theme with smaller text
  theme(
    legend.position = "none",                                          #### Hide the legend
    axis.text.x = element_text(angle = 45, hjust = 1,                  #### Rotate x-axis labels for readability
                               size = 6),                              #### Reduce airport name label size
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.text.y = element_text(margin = margin(r = 8)),                #### Add margin to right of y-axis labels
    strip.text = element_text(face = "bold"),                          #### Bold region titles in facet headers
    plot.title = element_text(hjust = 0.5, face = "bold", size = 12))  #### Center and bold the main title


#### ==== 🗺️ Plot 3: Map of Top 3 airports by total freight carried by passenger aircraft ====
#### Extract IATA codes from the top3 dataset
iata_code_top3_pax_freight_airports_by_region <- top3_pax_freight_airports_by_region %>%
  pull(iata_code) %>%
  unique()
#### Filter relevant columns for selected airports from the master freight_pax_aircraft_movement_combined dataset
filtered_pax_freight_airports <- freight_pax_aircraft_movement_combined %>%
  filter(iata_code %in% iata_code_top3_pax_freight_airports_by_region) %>%  
  select(airport_name, reporting_region_name, iata_code, icao_code) %>%  # Select relevant columns
  distinct()                                                             # Remove any duplicate rows

#### Construct a geocoding-friendly address string for each airport
filtered_pax_freight_airports <- filtered_pax_freight_airports %>%
  mutate(address = paste(iata_code, "UK", sep = ", "))

#### Geocode airport locations using OpenStreetMap (OSM) and add latitude and longitude
pax_freight_airports_geo <- filtered_pax_freight_airports %>%
  geocode(address = address, method = "osm", lat = latitude, long = longitude)
#### Manually fix incorrect or missing coordinates for known problematic airports
pax_freight_airports_geo <- pax_freight_airports_geo %>%
  mutate(
    latitude = case_when(
      iata_code == "MAN" ~ 53.365, iata_code == "ESH" ~ 50.835,
      iata_code == "ISC" ~ 49.914, iata_code == "DSA" ~ 53.475,
      iata_code == "EMA" ~ 52.831, iata_code == "PZE" ~ 50.129,
      TRUE ~ latitude),
    longitude = case_when(
      iata_code == "MAN" ~ -2.273, iata_code == "ESH" ~ -0.297,
      iata_code == "ISC" ~ -6.291, iata_code == "DSA" ~ -1.005,
      iata_code == "EMA" ~ -1.332, iata_code == "PZE" ~ -5.529,
      TRUE ~ longitude))
#### Filter out any airports with missing coordinates
pax_freight_airports_geo <- pax_freight_airports_geo %>% filter(!is.na(latitude), !is.na(longitude))

view(pax_freight_airports_geo)
#### Load UK map data from built-in "world" map and filter to just "UK"
uk_map <- map_data("world") %>% filter(region == "UK")
#### #### Define a color-blind-friendly and visually distinct palette for UK regions
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")
#### Plot the final map with ggplot2
ggplot() +
  #### Draw UK base map polygons with light grey land and white borders between land segments
  geom_polygon(data = uk_map, aes(x = long, y = lat, group = group),
               fill = "grey95", color = "white") +
  #### Plot airport locations as black-edged filled circles, colored by region
  geom_point(data = pax_freight_airports_geo,
             aes(x = longitude, y = latitude, fill = reporting_region_name),
             shape = 21, color = "black", size = 4, stroke = 0.5) +
  #### Add airport IATA labels with colored backgrounds and connector lines
  geom_label_repel(
    data = pax_freight_airports_geo,
    aes(x = longitude, y = latitude, label = iata_code, fill = reporting_region_name),
    color = "black", size = 3, box.padding = 0.6, label.size = 0.3,
    segment.color = "grey40", alpha = 0.9, max.overlaps = 100,
    show.legend = FALSE) +
  #### Set fixed zoom level over the UK and control axis tick spacing
  coord_fixed(xlim = c(-10, 4), ylim = c(49.5, 60.5), ratio = 1.5) + # Map bounds and aspect ratio
  scale_x_continuous(breaks = seq(-10, 4, by = 2.5)) +               # Set x-axis ticks at 2.5 intervals
  scale_y_continuous(breaks = seq(50, 60, by = 2.5)) +               # Ensure y-axis increments stay at 2.5
  #### Add plot title and axis labels
  labs(title = "Top 3 Airports by Share of Freight Transported via Passenger Aircraft",
       x = "Longitude", y = "Latitude", fill = "Region") + # X-axis and Y-axis label and legend title
  #### Manually apply region colors and customize legend aesthetics
  scale_fill_manual(values = region_colors,
                    guide = guide_legend(override.aes = list(shape = 21, size = 5, color = "black", stroke = 0.8))) +
  #### Use clean minimal theme and customize text styles
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.box = "horizontal",
    legend.text = element_text(size = 8))

#### Save the plot as a PNG image with balanced size and high resolution
ggsave("Top_3_Pax_Freight_Airports_Map_UK.png", width = 10, height = 8, dpi = 300)


### ==== 📦 Section 1.2.2. Freight volume unloaded by cargo aircraft ====
freights_cargo_aircraft <- freights_clean %>%
  group_by(reporting_region_name, report_period) %>%  ### Group by both region and year
  mutate(
    ### Calculate the total freight volume for the entire region for a specific year
    region_total_freight_cargo_aircraft = sum(total_freight_cargo_aircraft_report_period, na.rm = TRUE),  
    ### Calculate each airport's freight share within its region for that year.
    freight_cargo_airport_share = round((total_freight_cargo_aircraft_report_period / region_total_freight_cargo_aircraft), 2)) %>%
  ### Remove grouping structure to allow further operations across all rows
  ungroup() %>% ### Remove grouping for clean processing
  ### Sort: First by year, then by region, then descending airport freight share
  arrange(report_period, reporting_region_name, desc(freight_cargo_airport_share)) %>%
  ### Select relevant columns for downstream processing or analysis
  dplyr::select(report_period, airport_name, iata_code,
         reporting_region_name, total_freight_cargo_aircraft_report_period,
         region_total_freight_cargo_aircraft, freight_cargo_airport_share)

### Join freights_cargo_aircraft data with air_movement_clean data (left join)
freight_cargo_aircraft_movement_combined <- left_join(
  freights_cargo_aircraft,         # Left table
  air_movement_clean,              # Right table
  by = c("report_period", "airport_name", "iata_code", "reporting_region_name")) %>%  # Join keys
  dplyr::select(report_period, airport_name, iata_code,
             icao_code, reporting_region_name,
             atms_cargo_aircraft_report_period,               # Air traffic movement by cargo aircraft
             total_freight_cargo_aircraft_report_period,      # Total freight unloaded from cargo aircraft
             region_total_freight_cargo_aircraft, freight_cargo_airport_share) %>% 
  ### Remove rows with more than 2 NAs across selected share-related columns
  filter(rowSums(is.na(across(c(region_total_freight_cargo_aircraft, freight_cargo_airport_share)))) < 2) # Keep rows with 2 or fewer NAs

view(freight_cargo_aircraft_movement_combined)
### Identify airports still active in 2023 based on freight_cargo_aircraft_movement_combined data
operating_freight_cargo_airports_2023 <- freight_cargo_aircraft_movement_combined %>%
  filter(report_period == 2023) %>%           # Filter year 2023
  filter(freight_cargo_airport_share > 0) %>% # Keep only airports that contributed positively to regional freight
  pull(iata_code) %>%                         # Extract IATA codes
  unique()                                    # Ensure no duplicates

#### ==== 📮 Generate Summary Table: Regional Freight Metrics from Cargo Aircraft (2023) ====
freight_cargo_aircraft_summary_2023 <- freight_cargo_aircraft_movement_combined %>%
  filter(report_period == 2023) %>%                               # Keep only data from the year 2023
  filter(iata_code %in% operating_freight_cargo_airports_2023) %>%  # Keep only airports identified as operating in 2023
  dplyr::select(report_period, airport_name, iata_code,
         reporting_region_name, atms_cargo_aircraft_report_period, 
         total_freight_cargo_aircraft_report_period,
         region_total_freight_cargo_aircraft, freight_cargo_airport_share) %>%
  filter(!is.na(total_freight_cargo_aircraft_report_period)) %>%    # Remove rows with missing freight values
  filter(freight_cargo_airport_share > 0) %>%                       # Keep only airports that contributed positively to regional freight
  mutate(freight_cargo_airport_share = round(freight_cargo_airport_share * 100, 2)) %>%  # Convert share to percentage and round to 2 decimal places
  group_by(reporting_region_name, airport_name, iata_code,        # Group data by specified variables for summarization
           total_freight_cargo_aircraft_report_period, 
           region_total_freight_cargo_aircraft, freight_cargo_airport_share,
           atms_cargo_aircraft_report_period) %>%
  summarise(region_total_freight_cargo_aircraft = sum(total_freight_cargo_aircraft_report_period, na.rm = TRUE), .groups = "drop") # Calculate total regional freight by summing freight values, dropping grouping structure

#### Generate a styled static table (GT)
freight_cargo_table <- freight_cargo_aircraft_summary_2023 %>%
  dplyr::select(reporting_region_name, iata_code,
         total_freight_cargo_aircraft_report_period,
         region_total_freight_cargo_aircraft,
         freight_cargo_airport_share,
         atms_cargo_aircraft_report_period) %>%
  gt() %>%                                                        # Convert data frame to a gt table for formatting
  tab_header(                                                     # Add table title and subtitle
    title = md("**Freight Handled by Cargo Aircraft in 2023 (Tonnes)**"), # Set bold title using Markdown
    subtitle = "By Airport Across UK ITL1 Regions") %>%             # Add subtitle for context
  cols_label(                                                     # Rename columns for better readability
    reporting_region_name = "Region",
    iata_code = "IATA",
    total_freight_cargo_aircraft_report_period = "Freight Volume (Tonnes)",
    region_total_freight_cargo_aircraft = "Total Regional Freight (Tonnes)",
    freight_cargo_airport_share = "Percentage of Regional Freight (%)",
    atms_cargo_aircraft_report_period = "Cargo Aircraft Movements (ATMs)") %>%
  fmt_number(                                                     # Format numeric columns
    columns = c(total_freight_cargo_aircraft_report_period,
                region_total_freight_cargo_aircraft,
                atms_cargo_aircraft_report_period,
                freight_cargo_airport_share),
    decimals = 2, use_seps = TRUE, sep_mark = ",") %>%            # Set 2 decimal places and add thousand separators
  cols_align(align = "center", columns = everything()) %>%        # Center-align all columns
  tab_style(                                                      # Make column headers bold
    style = cell_text(weight = "bold"),
    locations = cells_column_labels()) %>%
  tab_options(                                                    # Set table styling options
    table.font.size = px(12),                                     # Set font size to 12 pixels
    column_labels.font.weight = "bold",                           # Bold the column labels
    column_labels.background.color = "#f2f2f2")                   # Set light gray background for column headers

#### Export the static table as a PNG image
gtsave(freight_cargo_table,
       filename = "freight_cargo_table_2023_wide.png",
       expand = 10,         # Adds padding around the table (higher value = more space)
       vwidth = 1600,       # Set width for better column fitting
       vheight = 1800)      # Set height to prevent row clipping
#### Print the GT table to RStudio Viewer
print(freight_cargo_table)

#### Load packages for interactive HTML table
if(!require(DT)) install.packages("DT")
if(!require(htmlwidgets)) install.packages("htmlwidgets")
library(DT)
library(htmlwidgets)
library(htmltools)

#### Create an interactive, downloadable HTML table with export buttons
interactive_freight_cargo_table <- datatable(
  freight_cargo_aircraft_summary_2023 %>%
    dplyr::select(
      Region = reporting_region_name, 
      `IATA Code` = iata_code,
      `Freight Volume (Tonnes)` = total_freight_cargo_aircraft_report_period,
      `Total Regional Freight (Tonnes)` = region_total_freight_cargo_aircraft,
      `Percentage of Regional Freight (%)` = freight_cargo_airport_share,
      `Cargo Aircraft Movements (ATMs)` = atms_cargo_aircraft_report_period
    ) %>%
    mutate(across(where(is.numeric), ~ format(round(., 2), big.mark = ",", nsmall = 2))), # Format numbers with thousands separators and 2 decimal places
  extensions = 'Buttons',                                                                 # Enable button extensions for export options
  options = list(
    dom = 'Bfrtip',                                                                       # Define table control elements (Buttons, filter, table, info, pagination)
    buttons = c('copy', 'csv', 'excel', 'pdf'),                                           # Add export buttons                                          
    pageLength = 10,                                                                      # Default page length set to 10
    lengthMenu = list(c(20, 50, 100), c("20", "50", "100")),                              # Customize page length options
    autoWidth = TRUE,                                                                     # Allow automatic column width adjustment
    columnDefs = list(list(className = 'dt-center', targets = '_all')),                   # Center-align all column contents
    #### Add custom centered header with title and subtitle, inserted only once 
    headerCallback = JS(
      "function(thead, data, start, end, display) {",
      "  var tableContainer = $(thead).closest('div.dataTables_wrapper');",
      "  var headerDiv = tableContainer.prev('div.custom-header');",
      "  if (!headerDiv.length) {",  # Only insert if it doesn't already exist
      "    tableContainer.before('<div class=\"custom-header\" style=\"text-align: center; width: 100%; margin-bottom: 20px;\"><h3 style=\"font-weight: bold; margin-bottom: 5px;\">Freight Handled by Cargo Aircraft (2023)</h3><h4 style=\"margin-top: 0; color: #666;\">By Airport Across UK ITL1 Regions</h4></div>');",
      "  }",
      "}")),
  rownames = FALSE,                                                                       # Disable row names
  filter = 'top',                                                                         # Add filters at the top of each column
  class = 'display',                                                                      # Ensure proper DataTables styling
  escape = FALSE)                                                                         # Allow HTML/CSS to render properly
#### Save the interactive table with a specific title and optimized display
saveWidget(
  interactive_freight_cargo_table,
  file = "airport_freight_cargo_2023_interactive.html",                                         # File output name
  title = "Freight Handled by Cargo Aircraft (2023) - By Airport Across UK ITL1 Regions",
  selfcontained = TRUE)

### Top 3 airports by total freight carried by cargo aircraft over the entire period
top3_cargo_freight_airports_by_region <- freight_cargo_aircraft_movement_combined %>%
  group_by(reporting_region_name, airport_name, iata_code) %>%
  ### Total freight handled by passenger aircraft for each airport over the entire period
  summarise(total_freight_cargo_aircraft = sum(total_freight_cargo_aircraft_report_period, na.rm = TRUE),
            ### Total cargo_aircraft movements for each airport over the entire period
            total_atms_cargo_aircraft = sum(atms_cargo_aircraft_report_period, na.rm = TRUE), .groups = "drop") %>%
  ### Remove airports that handled 0 freight during the entire period
  filter(total_freight_cargo_aircraft > 0) %>%
  ### Keep only airports still in operation in 2023
  filter(iata_code %in% operating_freight_cargo_airports_2023) %>%
  ### Group by region to compute regional totals and each airport’s share
  group_by(reporting_region_name) %>%
  ### Add new columns: regional total freight and the share of freight for each airport within the region
  mutate(region_total_freight = sum(total_freight_cargo_aircraft, na.rm = TRUE),
         cargo_freight_share = round(total_freight_cargo_aircraft / region_total_freight, 4)) %>%
  ### Sort airports by freight in descending order within each region
  arrange(reporting_region_name, desc(total_freight_cargo_aircraft)) %>%
  ### Rank airports within its region based on freight volume
  mutate(rank = row_number()) %>%
  ### Keep only the top 3 airports in each region based on the assigned rank
  filter(rank <= 3) %>%
  #### Exclude airports with 0.1% cargo_freight_share
  filter(cargo_freight_share > 0.0001) %>%
  ### Select and reorder the final columns for clarity and relevance
  dplyr::select(reporting_region_name, airport_name, iata_code, total_atms_cargo_aircraft, total_freight_cargo_aircraft, region_total_freight, cargo_freight_share)

### View the result
View(top3_cargo_freight_airports_by_region)

### Save to a CSV file
write.csv(top3_cargo_freight_airports_by_region, file = "top3_cargo_freight_airports_by_region.csv", row.names = FALSE)
### Export the cleaned and filtered table to an Excel file
write_xlsx(top3_pax_freight_airports_by_region, path = "top3_pax_freight_airports_by_region.xlsx")


#### ==== 📊 Plot 1: Horizontal Bar Chart of Top 3 airports by total freight carried by cargo aircraft over the entire period ====
#### Define a color-blind-friendly and visually distinct palette for UK regions
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")
#### Plot the horizontal bar chart
ggplot(top3_cargo_freight_airports_by_region, aes(
  x = reorder(iata_code, cargo_freight_share),     #### Reorder airport names (iata_code) by cargo_freight_share) (ascending)
  y = cargo_freight_share,                         #### Use cargo_freight_share as the bar height
  fill = reporting_region_name)) +                 #### Fill bars by region with different color to differentiate groups
  #### Create the bars with height equal to cargo_freight_share
  geom_bar(stat = "identity") +
  #### Add percentage labels (2 decimal places) to the end of each bar
  geom_text(
    aes(label = sprintf("%.2f%%", cargo_freight_share * 100)),  #### Convert share to percentage format
    hjust = -0.1,                                               #### Slightly offset text to the right of the bar
    size = 3.0) +                                               #### Set text size
  #### Flip coordinates to make the bars horizontal
  coord_flip() +
  #### Add title and axis labels
  labs( 
    title = "Freight Transported via Cargo Aircraft \n Top 3 Regional Airports (1998-2023)",                              #### Chart title
    x = "Airport code",                                                                               #### Label for y-axis (after flip)
    y = "Freight Share (%)") +                                                                 #### Label for x-axis (after flip)
  #### Format y-axis (now horizontal axis) to fixed breaks: 0%, 50%, 100%
  scale_y_continuous(
    labels = function(x) sprintf("%.2f%%", x * 100),  #### Convert from proportion to % label (e.g., 0.456 → "45.60%")
    breaks = c(0, 0.25, 0.5, 0.75, 1.0),              #### Tick marks at 0%, 25%, 50%, 75%, 100%
    limits = c(0, max(top3_cargo_freight_airports_by_region$cargo_freight_share) * 1.1)) +   #### Add space to the right of bars for label visibility
  #### Apply a color palette for region fill
  # scale_fill_brewer(palette = "Set3") +
  scale_fill_manual(values = region_colors) +  ### ✅ CUSTOM COLORS APPLIED HERE
  #### Use a clean, minimal theme and adjust font styling
  theme_minimal(base_size = 12) +
  theme(
    axis.text.y    = element_text(size = 10),                   #### Increase size of airport names
    axis.title     = element_text(face = "bold"),               #### Make axis titles bold
    plot.title     = element_text(face = "bold", hjust = 0.5),  #### Center and bold the title
    legend.title   = element_blank(),                           #### Remove legend title for simplicity
    legend.position = "bottom")                                  #### Move legend to the right of chart


#### ==== 📊 Plot 2: Faceted Bar Chart by Region ====
top3_cargo_freight_airports_by_region <- top3_cargo_freight_airports_by_region %>%
  group_by(reporting_region_name) %>%                           #### Group by region
  arrange(desc(cargo_freight_share), .by_group = TRUE) %>%      #### Sort by descending cargo share
  mutate(color_group = as.character(row_number())) %>%          #### Assign ranks 1, 2, 3 as character (for color use)
  ungroup()

#### Plot the bar chart
ggplot(top3_cargo_freight_airports_by_region, aes(
  x = reorder(iata_code, -cargo_freight_share),                   #### Order airports (iata_code) by descending share
  y = cargo_freight_share,                                        #### Use cargo_freight_share for bar height
  fill = color_group)) +                                          #### Color bars by rank group
  geom_bar(stat = "identity", width = 0.6) +                      #### Create bars with fixed width
  geom_text(
    aes(label = sprintf("%.2f%%", cargo_freight_share * 100)),    #### Format labels with 2 decimal places and % sign
    vjust = -0.4,                                                 #### Position labels slightly above bars
    size = 2.5,                                                   #### Smaller text size for labels
    position = position_dodge(width = 0.6)) +                     #### Align labels with bars
  facet_wrap(~ reporting_region_name,                             #### Create separate subplots for each region
             scales = "free_x",                                   #### Allow x-axis to scale independently per facet
             ncol = 3) +                                          #### Set number of columns to 3 for layout
  
  labs(title = "Freight Transported via Cargo Aircraft \n Top 3 Regional Airports (2023)",
       x = "Airport Name",                                                #### X-axis label
       y = "Cargo Share (%)") +                                           #### Y-axis label
  #### Manually assign fill colors based on rank (1st = dark navy blue, 2nd = medium steel blue, 3rd = light sky blue)
  scale_fill_manual(values = c("1" = "#0D3B66", "2" = "#1D6996", "3" = "#A6CEE3")) +
  #### Format y-axis as percentage and add space above bars for text visibility
  scale_y_continuous(
    labels = scales::percent,                                          #### Show axis ticks as percentages
    expand = expansion(mult = c(0, 0.2))) +                            #### Add 20% space above the tallest bar
  #### Apply clean visual styling
  theme_minimal(base_size = 10) +                                      #### Minimal base theme with smaller text
  theme(
    legend.position = "none",                                          #### Hide the legend
    axis.text.x = element_text(angle = 45, hjust = 1,                  #### Rotate x-axis labels for readability
                               size = 6),                              #### Reduce airport name label size
    axis.text.y = element_text(margin = margin(r = 8)),                #### Add margin to right of y-axis labels
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),                          #### Bold region titles in facet headers
    plot.title = element_text(hjust = 0.5, face = "bold", size = 12))  #### Center and bold the main title


#### ==== 🗺️ Plot 3: Map of Top 3 airports by total freight carried by Cargo aircraft ====
#### Extract IATA codes from the top3 dataset
iata_code_top3_cargo_freight_airports_by_region <- top3_cargo_freight_airports_by_region %>%
  pull(iata_code) %>%
  unique()
#### Filter relevant columns for selected airports from the master freight_cargo_aircraft_movement_combined dataset
filtered_cargo_freight_airports <- freight_cargo_aircraft_movement_combined %>%
  filter(iata_code %in% iata_code_top3_cargo_freight_airports_by_region) %>%  
  dplyr::select(airport_name, reporting_region_name, iata_code, icao_code) %>%  # Select relevant columns
  distinct()                                                             # Remove any duplicate rows

#### Construct a geocoding-friendly address string for each airport
filtered_cargo_freight_airports <- filtered_cargo_freight_airports %>%
  mutate(address = paste(iata_code, "UK", sep = ", "))

#### Geocode airport locations using OpenStreetMap (OSM) and add latitude and longitude
cargo_freight_airports_geo <- filtered_cargo_freight_airports %>%
  geocode(address = address, method = "osm", lat = latitude, long = longitude)
#### Manually fix incorrect or missing coordinates for known problematic airports
cargo_freight_airports_geo <- cargo_freight_airports_geo %>%
  mutate(
    latitude = case_when(
      iata_code == "MAN" ~ 53.365, iata_code == "ESH" ~ 50.835,
      iata_code == "ISC" ~ 49.914, iata_code == "DSA" ~ 53.475,
      iata_code == "EMA" ~ 52.831, iata_code == "PZE" ~ 50.129,
      TRUE ~ latitude),
    longitude = case_when(
      iata_code == "MAN" ~ -2.273, iata_code == "ESH" ~ -0.297,
      iata_code == "ISC" ~ -6.291, iata_code == "DSA" ~ -1.005,
      iata_code == "EMA" ~ -1.332, iata_code == "PZE" ~ -5.529,
      TRUE ~ longitude))
#### Filter out any airports with missing coordinates
cargo_freight_airports_geo <- cargo_freight_airports_geo %>% filter(!is.na(latitude), !is.na(longitude))

view(cargo_freight_airports_geo)
#### Load UK map data from built-in "world" map and filter to just "UK"
uk_map <- map_data("world") %>% filter(region == "UK")
#### #### Define a color-blind-friendly and visually distinct palette for UK regions
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")
#### Plot the final map with ggplot2
ggplot() +
  #### Draw UK base map polygons with light grey land and white borders between land segments
  geom_polygon(data = uk_map, aes(x = long, y = lat, group = group),
               fill = "grey95", color = "white") +
  #### Plot airport locations as black-edged filled circles, colored by region
  geom_point(data = cargo_freight_airports_geo,
             aes(x = longitude, y = latitude, fill = reporting_region_name),
             shape = 21, color = "black", size = 4, stroke = 0.5) +
  #### Add airport IATA labels with colored backgrounds and connector lines
  geom_label_repel(
    data = cargo_freight_airports_geo,
    aes(x = longitude, y = latitude, label = iata_code, fill = reporting_region_name),
    color = "black", size = 3, box.padding = 0.6, label.size = 0.3,
    segment.color = "grey40", alpha = 0.9, max.overlaps = 100,
    show.legend = FALSE) +
  #### Set fixed zoom level over the UK and control axis tick spacing
  coord_fixed(xlim = c(-10, 4), ylim = c(49.5, 60.5), ratio = 1.5) + # Map bounds and aspect ratio
  scale_x_continuous(breaks = seq(-10, 4, by = 2.5)) +               # Set x-axis ticks at 2.5 intervals
  scale_y_continuous(breaks = seq(50, 60, by = 2.5)) +               # Ensure y-axis increments stay at 2.5
  #### Add plot title and axis labels
  labs(title = "Top 3 Airports by Share of Freight Transported via Cargo Aircraft",
       x = "Longitude", y = "Latitude", fill = "Region") + # X-axis and Y-axis label and legend title
  #### Manually apply region colors and customize legend aesthetics
  scale_fill_manual(values = region_colors,
                    guide = guide_legend(override.aes = list(shape = 21, size = 5, color = "black", stroke = 0.8))) +
  #### Use clean minimal theme and customize text styles
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.box = "horizontal",
    legend.text = element_text(size = 8))

#### Save the plot as a PNG image with balanced size and high resolution
ggsave("Top_3_Cargo_Freight_Airports_Map_UK.png", width = 10, height = 8, dpi = 300)


#### ==== 📍 Top 3 airports by total freight carried by cargo aircraft annually over the entire period (1998-2023) ====
top3_cargo_freight_airports_by_region_year <- freight_cargo_aircraft_movement_combined %>%
  #### Keep only airports still in operation in 2023
  filter(iata_code %in% operating_freight_cargo_airports_2023) %>%
  #### Group by year and region only (no airport-level breakdown)
  group_by(report_period, reporting_region_name) %>%
  #### Aggregate freight volume carried by cargo aircraft and ATMs by region and year
  summarise(
    region_total_freight = sum(total_freight_cargo_aircraft_report_period, na.rm = TRUE),
    region_total_atms_freight_aircraft = sum(atms_cargo_aircraft_report_period, na.rm = TRUE),
    .groups = "drop") %>%
  #### Arrange by region and year for neatness
  arrange(report_period,reporting_region_name)

#### View the final result
view(top3_cargo_freight_airports_by_region_year)

## ==== Section 1.3: Air passenger data ====
### Import data on air passenger data categorized by travel type and airline nationality, grouped by UK airport regions
passengers <- read_excel(path = "Combined Passenger data.xlsx")
head(passengers) # Preview the top rows to inspect structure

### ==== 🔎 Section 1.3.1. Clean and filter the air passengers data ====
passengers_clean <- passengers %>%
  filter(
    !is.na(reporting_region_name),                  ### Exclude rows where the region name is missing (NA)
    reporting_region_name != "N/A",                 ### Exclude rows where region is marked as "N/A" (invalid entry)
    report_period >= 1998, report_period <= 2023)   ### Keep only data from 1998 to 2023

### Create aggregate columns for Passenger Volumes
#passengers_clean <- passengers_clean %>%
#  mutate(
#    ### Calculate total terminal passengers by summing all columns that contain "pax_terminal"
#    total_terminal_pax = rowSums(select(., contains("pax_terminal")), na.rm = TRUE),      # can also substitute with start_with
#    ### Calculate total transit passengers by summing all columns that contain "pax_transit"
#    total_transit_pax  = rowSums(select(., contains("pax_transit")),  na.rm = TRUE)) %>%  # can also substitute with start_with
  ### Keep only the necessary columns for further analysis
#  dplyr::select(report_period, airport_name, reporting_region_name, 
#         iata_code, icao_code, total_pax,
#         total_terminal_pax, total_transit_pax)

### Create aggregate columns for Passenger Volumes
passengers_clean <- passengers %>%
  filter(
    !is.na(reporting_region_name),
    reporting_region_name != "N/A",
    report_period >= 1998, report_period <= 2023) %>%
  mutate(
    ### Calculate total terminal passengers by summing all columns that contain "pax_terminal"
    total_terminal_pax = rowSums(pick(contains("pax_terminal")), na.rm = TRUE),
    ### Calculate total transit passengers by summing all columns that contain "pax_transit"
    total_transit_pax  = rowSums(pick(contains("pax_transit")), na.rm = TRUE)) %>%
  dplyr::select(report_period, airport_name, reporting_region_name,
                iata_code, icao_code, total_terminal_pax, total_transit_pax)

### Create a DataFrame summarising airport's terminal passenger volumes and their share within regions
passengers_terminal_volume <- passengers_clean %>%
  group_by(reporting_region_name, report_period) %>%  ### Group by both region and year
  mutate(
    ### Calculate the total passengers volume for the entire region for a specific year
    region_terminal_passengers_volume = sum(total_terminal_pax, na.rm = TRUE),
    ### Calculate each airport's contribution within its region for that year
    terminal_passengers_volume_airport_share = round((total_terminal_pax / region_terminal_passengers_volume), 2)) %>%
  ### Remove grouping structure to allow further operations across all rows
  ungroup() %>%
  ### Sort: First by year, then by region, then descending airport freight share
  arrange(report_period, reporting_region_name, desc(terminal_passengers_volume_airport_share)) %>%
  ### Select relevant columns for downstream processing or analysis
  dplyr::select(report_period, airport_name,iata_code,
         reporting_region_name, total_terminal_pax,
         region_terminal_passengers_volume, terminal_passengers_volume_airport_share)

str(passengers_terminal_volume)
view(passengers_terminal_volume)

### ==== 🔗 Section 1.3.2. Join passengers_terminal_volume data with air_movement_clean data (left join) ====
passengers_volume_aircraft_movements_combined <- left_join(
  passengers_terminal_volume,             # Left table
  air_movement_clean,                     # Right table
  by = c("report_period", "airport_name", "iata_code", "reporting_region_name")) %>%
  dplyr::select(report_period, airport_name, iata_code,
         icao_code, reporting_region_name, atms_pax_aircraft_report_period,
         total_terminal_pax, region_terminal_passengers_volume, 
         terminal_passengers_volume_airport_share) %>%
  ### Remove rows with more than 2 NAs across selected share-related columns
  filter(rowSums(is.na(across(c(region_terminal_passengers_volume, terminal_passengers_volume_airport_share)))) < 2) # Keep rows with 2 or fewer NAs

### Identify airports still active in 2023 based on passengers_volume_aircraft_movements_combined data
operating_pax_airports_2023 <- passengers_volume_aircraft_movements_combined %>%
  filter(report_period == 2023) %>%                        # Filter year 2023
  filter(terminal_passengers_volume_airport_share > 0) %>% # Keep only airports that contributed positively to regional freight
  pull(iata_code) %>%                                      # Extract IATA codes
  unique()                                                 # Ensure no duplicates

#### ==== 📍 Generate Summary Table: Terminal Passengers Volume by Region for 2023 ====
passengers_volume_aircraft_movements_summary_2023 <- passengers_volume_aircraft_movements_combined %>%
  filter(report_period == 2023) %>%                               # Keep only data from the year 2023
  filter(iata_code %in% operating_pax_airports_2023) %>%          # Keep only airports identified as operating in 2023
  dplyr::select(report_period, airport_name, iata_code,
         reporting_region_name, atms_pax_aircraft_report_period, 
         total_terminal_pax, region_terminal_passengers_volume,
         terminal_passengers_volume_airport_share) %>%
  filter(!is.na(total_terminal_pax)) %>%                          # Remove rows with missing values
  filter(terminal_passengers_volume_airport_share > 0) %>%        # Keep only airports that contributed positively to regional pax volume
  mutate(terminal_passengers_volume_airport_share = round(terminal_passengers_volume_airport_share * 100, 2)) %>%  # Convert share to percentage and round to 2 decimal places
  group_by(reporting_region_name, airport_name, iata_code,        # Group data by specified variables for summarization
           total_terminal_pax, region_terminal_passengers_volume,
           terminal_passengers_volume_airport_share,
           atms_pax_aircraft_report_period) %>%
  summarise(region_terminal_passengers_volume = sum(region_terminal_passengers_volume, na.rm = TRUE), .groups = "drop") # Calculate total terminal pax, dropping grouping structure

#### Generate a styled static table (GT)
passengers_volume_aircraft_movements_table <- passengers_volume_aircraft_movements_summary_2023 %>%
  dplyr::select(reporting_region_name, iata_code,
         total_terminal_pax, region_terminal_passengers_volume,
         terminal_passengers_volume_airport_share,
         atms_pax_aircraft_report_period) %>%
  gt() %>%                                                         # Convert data frame to a gt table for formatting
  tab_header(                                                      # Add table title and subtitle
    title = md("**Terminal Passengers Handled and Associated Aircraft Movements in 2023**"), # Set bold title using Markdown
    subtitle = "By Airport Across UK ITL1 Regions") %>%            # Add subtitle for context
  cols_label(                                                      # Rename columns for better readability
    reporting_region_name = "Region",
    iata_code = "IATA",
    total_terminal_pax = "Terminal Passengers",
    region_terminal_passengers_volume = "Regional Total Terminal Passengers",
    terminal_passengers_volume_airport_share = "Airport Share of Regional Volume (%)",
    atms_pax_aircraft_report_period = "Passenger Aircraft Movements (ATMs)") %>%
  fmt_number(                                                     # Format numeric columns
    columns = c(total_terminal_pax,
                region_terminal_passengers_volume,
                terminal_passengers_volume_airport_share,
                atms_pax_aircraft_report_period),
    decimals = 2, use_seps = TRUE, sep_mark = ",") %>%            # Set 2 decimal places and add thousand separators
  cols_align(align = "center", columns = everything()) %>%        # Center-align all columns
  tab_style(                                                      # Make column headers bold
    style = cell_text(weight = "bold"),
    locations = cells_column_labels()) %>%
  tab_options(                                                    # Set table styling options
    table.font.size = px(12),                                     # Set font size to 12 pixels
    column_labels.font.weight = "bold",                           # Bold the column labels
    column_labels.background.color = "#f2f2f2")                   # Set light gray background for column headers

#### Print the GT table to RStudio Viewer
print(passengers_volume_aircraft_movements_table)
#### Export the static table as a PNG image
gtsave(passengers_volume_aircraft_movements_table,
       filename = "freight_cargo_table_2023_wide.png",
       expand = 10,         # Adds padding around the table (higher value = more space)
       vwidth = 1600,       # Set width for better column fitting
       vheight = 1800)      # Set height to prevent row clipping

### Top 3 airports by passengers volume over the entire period
top3_pax_volume_airports_by_region <- passengers_volume_aircraft_movements_combined %>%
  group_by(reporting_region_name, airport_name, iata_code) %>%
  summarise(
    ### Total passengers volume for each airport over the entire period
    total_terminal_pax_volume_airport = sum(total_terminal_pax, na.rm = TRUE),
    ### Total passenger aircraft movements for each airport over the entire period
    total_atms_pax_aircraft = sum(atms_pax_aircraft_report_period, na.rm = TRUE), .groups = "drop") %>%
  ### Remove airports that handled no passengers during the entire period
  filter(total_terminal_pax_volume_airport > 0) %>%
  ### Keep only airports still in operation in 2023
  filter(iata_code %in% operating_pax_airports_2023) %>%
  ### Group by region to compute regional totals and each airport’s share
  group_by(reporting_region_name) %>%
  ### Add new columns: region_terminal_passengers_volume and the passengers_volume_airport_share
  mutate(region_terminal_passengers_volume = sum(total_terminal_pax_volume_airport, na.rm = TRUE),
         passengers_volume_airport_share = round((total_terminal_pax_volume_airport  / region_terminal_passengers_volume), 4)) %>%
  ### Sort airports by passengers volume in descending order within each region
  arrange(reporting_region_name, desc(total_terminal_pax_volume_airport)) %>%
  ### Assign a rank to each airport within its region based on its share of passengers volume
  #### If multiple airports have the same share, they'll get the same rank
  mutate(pax_volume_rank = min_rank(desc(passengers_volume_airport_share))) %>%
  ### Within each region, keep only 3 airports with the highest passenger volume
  slice_max(order_by = total_terminal_pax_volume_airport, n = 3, with_ties = FALSE) %>%
  ### Keep only the top 3 airports in each region based on the assigned rank
  filter(pax_volume_rank <= 3) %>%
  ### Select and reorder the final columns for clarity and relevance
  dplyr::select(reporting_region_name, airport_name, iata_code, total_atms_pax_aircraft,
         total_terminal_pax_volume_airport, region_terminal_passengers_volume, passengers_volume_airport_share, pax_volume_rank)

view(top3_pax_volume_airports_by_region)

### Total air transport GVA across all regions by year
summary_by_year_pax_volume_region <- top3_pax_volume_airports_by_region  %>%
  group_by(reporting_region_name) %>%
  summarise(total_atms_pax_aircraft = sum(total_atms_pax_aircraft, na.rm = TRUE),
            total_terminal_pax_volume_airport = sum(total_terminal_pax_volume_airport, na.rm = TRUE),.groups = "drop") %>%
  ### Rename column
  rename(`Reporting Region` = reporting_region_name, `Air Transport Movements` = total_atms_pax_aircraft, `Terminal Passenger Volume` = total_terminal_pax_volume_airport)

view(summary_by_year_pax_volume_region)

#### ==== 📊 Plot 1: Horizontal Bar Chart of Top 3 Airports by Passenger Volume Share (1998–2023) ====
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")

ggplot(top3_pax_volume_airports_by_region, aes(
  x = reorder(iata_code, passengers_volume_airport_share),     #### Reorder airport names (iata_code) by passengers_volume_airport_share) (ascending)
  y = passengers_volume_airport_share,                         #### Use passengers_volume_airport_share as the bar height
  fill = reporting_region_name)) +                             #### Fill bars by region with different color to differentiate groups
  #### Create the bars with height equal to passengers_volume_airport_share
  geom_bar(stat = "identity") +
  #### Add percentage labels (2 decimal places) to the end of each bar
  geom_text(
    aes(label = sprintf("%.2f%%", passengers_volume_airport_share * 100)),  #### Convert share to percentage format
    hjust = -0.1,                                                           #### Slightly offset text to the right of the bar
    size = 3.0) +                                                           #### Set text size
  #### Flip coordinates to make the bars horizontal
  coord_flip() +
  #### Add title and axis labels
  labs(
    title = "Terminal Passenger Volume \n Top 3 Regional Airports (1998-2023)",      #### Chart title
    x = "Airport code",                                                                 #### Label for y-axis (after flip)
    y = "Passenger Volume Share (%)") +                                               #### Label for x-axis (after flip)
  #### Format y-axis (now horizontal axis) to fixed breaks: 0%, 50%, 100%
  scale_y_continuous(
    labels = function(x) sprintf("%.2f%%", x * 100),  #### Convert from proportion to % label (e.g., 0.456 → "45.60%")
    breaks = c(0, 0.25, 0.5, 0.75, 1.0),              #### Tick marks at 0%, 25%, 50%, 75%, 100%
    limits = c(0, max(top3_pax_volume_airports_by_region$passengers_volume_airport_share) * 1.1)) +   #### Add space to the right of bars for label visibility
  #### Apply a color palette for region fill
  scale_fill_manual(values = region_colors) +  ### ✅ CUSTOM COLORS APPLIED HERE
  #### Use a clean, minimal theme and adjust font styling
  theme_minimal(base_size = 12) +
  theme(
    axis.text.y    = element_text(size = 10),                   #### Increase size of airport names
    axis.title     = element_text(face = "bold"),               #### Make axis titles bold
    plot.title     = element_text(face = "bold", hjust = 0.5),  #### Center and bold the title
    legend.title   = element_blank(),                           #### Remove legend title for simplicity
    legend.position = "bottom")                                  #### Move legend to the right of chart

#### ==== 📊 Plot 2: Faceted Bar Chart by Region ====
top3_pax_volume_airports_by_region <- top3_pax_volume_airports_by_region %>%
  group_by(reporting_region_name) %>%                                   #### Group by region
  arrange(desc(passengers_volume_airport_share), .by_group = TRUE) %>%  #### Sort descending within each region
  mutate(color_group = as.character(row_number())) %>%                  #### Assign rank 1, 2, 3 for fill color
  ungroup()

#### Plot the bar chart
ggplot(top3_pax_volume_airports_by_region, aes(
  x = reorder(iata_code, -passengers_volume_airport_share),     #### Order airports (iata_code) by descending share
  y = passengers_volume_airport_share,                          #### Bar height = passenger share
  fill = color_group)) +                                        #### Fill color based on rank
  geom_bar(stat = "identity", width = 0.6) +                    #### Bar chart, fixed width
  geom_text(
    aes(label = sprintf("%.2f%%", passengers_volume_airport_share * 100)),  #### Label as percentage
    vjust = -0.4,                                               #### Position labels slightly above bars
    size = 2.5,                                                 #### Smaller text size for labels
    position = position_dodge(width = 0.6)) +                   #### Align label with bar
  facet_wrap(~ reporting_region_name,
             scales = "free_x",                                 #### Let x-axis scale freely
             ncol = 3) +                                        #### Arrange 3 columns of facets
  
  labs(title = "Top 3 Airports by Share of Regional Passenger Volume (1998–2023)",
       x = "Airport Code", y = "Passenger Volume share per Region (%)") +
  #### Manually assign fill colors based on rank (1st = dark navy blue, 2nd = medium steel blue, 3rd = light sky blue)
  scale_fill_manual(values = c("1" = "#0D3B66", "2" = "#1D6996", "3" = "#A6CEE3")) +
  scale_y_continuous(
    labels = scales::percent,                #### Format axis labels as %
    expand = expansion(mult = c(0, 0.2))) +  #### Add space above bars for label visibility
  theme_minimal(base_size = 10) +            #### Clean minimal theme
  theme(
    legend.position = "none",                                        #### Hide the legend
    axis.text.x = element_text(angle = 45, hjust = 1, size = 6),     #### Rotate x labels
    axis.text.y = element_text(margin = margin(r = 8)),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),                        #### Bold region titles in facet headers
    plot.title = element_text(hjust = 0.5, face = "bold", size = 12)) #### Center and bold the main title


#### ==== 🗺️ Plot 3: Map of Top 3 airports by passengers volume ====
#### Extract IATA codes from the top3 dataset
iata_code_top3_pax_volume_airports_by_region <- top3_pax_volume_airports_by_region %>%
  pull(iata_code) %>%
  unique()

#### Filter relevant columns for selected airports from the master passengers_volume_aircraft_movements_combined  dataset
filtered_pax_volume_airports <- passengers_volume_aircraft_movements_combined  %>%
  filter(iata_code %in% iata_code_top3_pax_volume_airports_by_region) %>%  
  dplyr::select(airport_name, reporting_region_name, iata_code, icao_code) %>%  # Select relevant columns
  distinct()                                                             # Remove any duplicate rows

#### Construct a geocoding-friendly address string for each airport
filtered_pax_volume_airports <- filtered_pax_volume_airports %>%
  mutate(address = paste(iata_code, "UK", sep = ", "))

#### Geocode airport locations using OpenStreetMap (OSM) and add latitude and longitude
pax_volume_airports_geo <- filtered_pax_volume_airports %>%
  geocode(address = address, method = "osm", lat = latitude, long = longitude)
#### Manually fix incorrect or missing coordinates for known problematic airports
pax_volume_airports_geo <- pax_volume_airports_geo %>%
  mutate(
    latitude = case_when(
      iata_code == "MAN" ~ 53.365, iata_code == "ESH" ~ 50.835,
      iata_code == "ISC" ~ 49.914, iata_code == "DSA" ~ 53.475,
      iata_code == "EMA" ~ 52.831, iata_code == "PZE" ~ 50.129,
      TRUE ~ latitude),
    longitude = case_when(
      iata_code == "MAN" ~ -2.273, iata_code == "ESH" ~ -0.297,
      iata_code == "ISC" ~ -6.291, iata_code == "DSA" ~ -1.005,
      iata_code == "EMA" ~ -1.332, iata_code == "PZE" ~ -5.529,
      TRUE ~ longitude))
#### Filter out any airports with missing coordinates
pax_volume_airports_geo <- pax_volume_airports_geo %>% filter(!is.na(latitude), !is.na(longitude))
view(pax_volume_airports_geo)

#### Load UK map data from built-in "world" map and filter to just "UK"
uk_map <- map_data("world") %>% filter(region == "UK")
#### #### Define a color-blind-friendly and visually distinct palette for UK regions
region_colors <- c(
  "East" = "#1b9e77", "East Midlands" = "#d95f02", "London" = "#49C3D3",
  "North East" = "#e7298a", "North West" = "#F6C545", "Northern Ireland" = "#e6ab02",
  "Scotland" = "#a6761d", "South East" = "#66a61e", "South West" = "#b2df8a",
  "Wales" = "#D6DA3F", "West Midlands" = "#fb9a99", "Yorkshire and The Humber" = "#cab2d6")
#### Plot the final map with ggplot2
ggplot() +
  #### Draw UK base map polygons with light grey land and white borders between land segments
  geom_polygon(data = uk_map, aes(x = long, y = lat, group = group),
               fill = "grey95", color = "white") +
  #### Plot airport locations as black-edged filled circles, colored by region
  geom_point(data = pax_volume_airports_geo,
             aes(x = longitude, y = latitude, fill = reporting_region_name),
             shape = 21, color = "black", size = 4, stroke = 0.5) +
  #### Add airport IATA labels with colored backgrounds and connector lines
  geom_label_repel(
    data = pax_volume_airports_geo,
    aes(x = longitude, y = latitude, label = iata_code, fill = reporting_region_name),
    color = "black", size = 3, box.padding = 0.6, label.size = 0.3,
    segment.color = "grey40", alpha = 0.9, max.overlaps = 100,
    show.legend = FALSE) +
  #### Set fixed zoom level over the UK and control axis tick spacing
  coord_fixed(xlim = c(-10, 4), ylim = c(49.5, 60.5), ratio = 1.5) + # Map bounds and aspect ratio
  scale_x_continuous(breaks = seq(-10, 4, by = 2.5)) +               # Set x-axis ticks at 2.5 intervals
  scale_y_continuous(breaks = seq(50, 60, by = 2.5)) +               # Ensure y-axis increments stay at 2.5
  #### Add plot title and axis labels
  labs(title = "Top 3 Airports by Share of Regional Passenger Volume",
       x = "Longitude (°E)", y = "atitude (°N)", fill = "Region") + # X-axis and Y-axis label and legend title
  #### Manually apply region colors and customize legend aesthetics
  scale_fill_manual(values = region_colors,
                    guide = guide_legend(override.aes = list(shape = 21, size = 5, color = "black", stroke = 0.8))) +
  #### Use clean minimal theme and customize text styles
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.box = "horizontal",
    legend.text = element_text(size = 8))

#### Save the plot as a PNG image with balanced size and high resolution
ggsave("Top_3_Airports_by_Passenger_volume_per_region_Map_UK.png", width = 10, height = 8, dpi = 300)

#### ==== 📍 Top 3 airports by passengers volume annually over the entire period (1998-2023) ====
top3_pax_volume_airports_by_region_year <- passengers_volume_aircraft_movements_combined %>%
  #### Keep only airports that were still in operation in 2023
  filter(iata_code %in% operating_pax_airports_2023) %>%
  #### Group by year and region only (no airport-level breakdown)
  group_by(report_period, reporting_region_name) %>%
  #### Aggregate total passenger volume and ATMs by region and year
  summarise(
    region_total_terminal_pax_volume = sum(total_terminal_pax, na.rm = TRUE),
    region_total_atms_pax_aircraft = sum(atms_pax_aircraft_report_period, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  #### Arrange by region and year for neatness
  arrange(report_period,reporting_region_name)

#### View the final result
view(top3_pax_volume_airports_by_region_year)

### ==== 🔄 Section 1.3.3. Reshape the Data (Pivot) — Total Passengers by Region during the Period ====
#passengers_terminal_pax_pivot <- passengers_volume_aircraft_movements_combined %>%
#  filter(report_period >= 1998, report_period <= 2019) %>% ### keep only 1998–2019
#  dplyr::select(report_period, iata_code, reporting_region_name, total_terminal_pax) %>%
#  pivot_wider(
#    names_from = reporting_region_name, ### Each region becomes a new column
#    values_from = total_terminal_pax,   ### Fill each cell with total passengers for that region
#    values_fill = 0)                    ### Replace NA values with 0 instead of leaving them as missing

### Reshape into Panel Data: Region x IATA x Year
passengers_terminal_pax_panel <- passengers_volume_aircraft_movements_combined %>%
  dplyr::select(report_period, iata_code, reporting_region_name, atms_pax_aircraft_report_period,
         total_terminal_pax, region_terminal_passengers_volume, 
         terminal_passengers_volume_airport_share) %>%
  group_by(report_period, iata_code, reporting_region_name, atms_pax_aircraft_report_period,
           total_terminal_pax, region_terminal_passengers_volume, 
           terminal_passengers_volume_airport_share) %>%
  summarise(total_terminal_pax = sum(total_terminal_pax, na.rm = TRUE), .groups = "drop") %>%
  arrange(reporting_region_name, iata_code, report_period)

view(passengers_terminal_pax_panel)

## ==== Section 1.4: Regional Gross Domestic Product (GDP) data for UK regions (ITL1 level) - manual ====
gdp_region = read_excel(path = "regionalgrossdomesticproductgdpbyallinternationalterritoriallevelitlregions.xlsx", sheet = "Table 5")
head(gdp_region) # Preview the top rows to inspect structure

### ==== 🔎 Section 1.4.1. Clean and filter the GDP data for ITL1 region ====
### Extract the first row of the dataset to use it as the new header (column names)
header_row <- gdp_region[1, ]  ### This pulls out the first row of the data frame (row 1), assuming it contains the actual column names
colnames(gdp_region) <- as.character(unlist(header_row))  ### Convert the header row into character strings and assign it as the new column names
gdp_region <- gdp_region[-c(1:1), ]  ### Remove the now redundant header row
### Clean column names to ensure consistent formatting (e.g., no spaces or special characters)
gdp_region <- gdp_region %>% clean_names()  # This will convert "ITL" to "itl" and "ITL code" to "itl_code"
### Filter the data to include only rows where the ITL classification is "ITL1"
gdp_region_itl1 <- gdp_region %>% filter(itl == "ITL1")

### Identify the columns that represent years (they start with "x" followed by 4 digits)
year_cols_gdp <- grep("^x\\d{4}$", names(gdp_region_itl1), value = TRUE)
### ^x\\d{4}$ = regular expression to match column names like "x1998", "x2023"
### grep(..., value = TRUE) returns the actual matching column names
### Clean the year column names by removing the 'x' prefix
names(gdp_region_itl1)[names(gdp_region_itl1) %in% year_cols_gdp] <- gsub("^x", "", year_cols_gdp)
### gsub("^x", "", ...) removes the "x" from the beginning of each matched year column name

### Convert year columns to numeric (just in case they were read as character)
gdp_region_itl1 <- gdp_region_itl1 %>% mutate(across(all_of(gsub("^x", "", year_cols_gdp)), as.numeric))
### gsub("^x", "", year_cols_gdp) gives the cleaned column names like "1998", "1999", etc.
### mutate(across(...)) applies as.numeric() to each of these year columns

### View the filtered dataset with ITL1-level regions and corresponding yearly GDP data
view(gdp_region_itl1)

### ==== 🔄 Section 1.4.2. Reshape the Data (Pivot) — Yearly GDP by Region ====
### Convert wide format (years as columns) to long format
gdp_region_ilt1_pivot_panel <- gdp_region_itl1 %>%
  pivot_longer(
    cols = -c(itl, itl_code, region_name),      ### Keep identifying columns fixed
    names_to = "year",                          ### Move the year column names into a new column called 'year'
    values_to = "gdp_value"                     ### Store GDP values from each year in a single column called 'gdp_value'
  ) %>%
  mutate(
    year = as.numeric(year),                    ### Convert year from character to numeric (e.g., "1998" becomes 1998)
    gdp_value = as.numeric(gdp_value)* 1e6) %>% ### Ensure GDP values are numeric (e.g., remove any accidental text formatting)
  arrange(year, region_name)                    ### Sort the data first by year, then alphabetically by region

view(gdp_region_ilt1_pivot_panel)

### Total GDP across all regions by year
summary_by_year_GDP_region <- gdp_region_ilt1_pivot_panel %>%
  group_by(year) %>%
  summarise(gdp_value = sum(gdp_value, na.rm = TRUE), .groups = "drop") %>%
  ### Rename column
  rename(Years = year, `Total GDP (£ million)` = gdp_value)

### Export the cleaned and filtered table to an Excel file
write_xlsx(summary_by_year_GDP_region, path = "UK_GDP_by_Year_(1998-2023).xlsx")

## ==== Section 1.5: Regional Gross Value Added (GVA) at current basic prices for UK regions (ITL1 level) - automatic ====
gva_region = read_excel(path = "regionalgrossdomesticproductgdpbyallinternationalterritoriallevelitlregions.xlsx", sheet = "Table 1")
head(gva_region)  # Preview the top rows to inspect structure

### ==== 🔎 Section 1.5.1. Clean and filter the GVA data for ITL1 region ====
### Promote the first row of the dataset to become the column headers
gva_region <- gva_region %>% row_to_names(row_number = 1)
gva_region # Cleaned gva_region dataset with correct headers
gva_region <- gva_region %>% clean_names() ### Clean column names to ensure consistent formatting (e.g., no spaces or special characters)

### Define valid ITL1 codes
ITL1_codes <- c("TLC", "TLD", "TLE", "TLF", "TLG", "TLH", "TLI", "TLJ", "TLK", "TLL", "TLM", "TLN")

### Filter the gva_region dataset for matching ITL1 region codes
gva_region_itl1 <- gva_region %>%
  filter(itl_code %in% ITL1_codes)

### ==== 🔄 Section 1.5.2. Reshape the Data (Pivot) — Yearly Air Transport GVA by Region ====
gva_region_itl1 <- gva_region_itl1 %>%
  pivot_longer(
    cols = matches("^x\\d{4}$"), ### Selects only columns with names like x1998, x2005, x2023, etc.
    names_to = "report_period",  ### Store the original column names (e.g. 'x1998') into a new column called 'year'
    values_to = "gva_value") %>% ### Store the corresponding cell values into a new column called 'gva_value'
  mutate(
    report_period = as.numeric(gsub("^x", "", report_period)),   ### Remove the 'x' prefix (e.g., 'x1998' → '1998'), then convert to numeric type
    gva_value = as.numeric(gva_value)* 1e6) %>%                       ### Convert GVA values to numeric in case they were imported as character strings
  rename(reporting_region_name = region_name) %>%                ### Rename column from region_name to reporting_region_name
  arrange(report_period, reporting_region_name)                  ### Sort the data first by year, then alphabetically by region

view(gva_region_itl1)

## ==== Section 1.6: Total resident population numbers for UK regions (ITL1 level) - automatic ====
resident_region = read_excel(path = "regionalgrossdomesticproductgdpbyallinternationalterritoriallevelitlregions.xlsx", sheet = "Table 6")
head(resident_region)  # Preview the top rows to inspect structure

### ==== 🔎 Section 1.6.1. Clean and filter the total resident population numbers data for ITL1 region ====
### Promote the first row of the dataset to become the column headers
resident_region <- resident_region %>% row_to_names(row_number = 1)
resident_region # Cleaned resident_region dataset with correct headers
resident_region <- resident_region %>% clean_names() ### Clean column names to ensure consistent formatting (e.g., no spaces or special characters)

### Define valid ITL1 codes
ITL1_codes <- c("TLC", "TLD", "TLE", "TLF", "TLG", "TLH", "TLI", "TLJ", "TLK", "TLL", "TLM", "TLN")

### Filter the resident_region dataset for matching ITL1 region codes
resident_region_itl1 <- resident_region %>%
  filter(itl_code %in% ITL1_codes)

### ==== 🔄 Section 1.6.2. Reshape the Data (Pivot) — Yearly resident population numbers by Region ====
resident_region_itl1 <- resident_region_itl1 %>%
  pivot_longer(
    cols = matches("^x\\d{4}$"), ### Selects only columns with names like x1998, x2005, x2023, etc.
    names_to = "report_period",  ### Store the original column names (e.g. 'x1998') into a new column called 'year'
    values_to = "resident_number") %>% ### Store the corresponding cell values into a new column called 'resident population number'
  mutate(
    report_period = as.numeric(gsub("^x", "", report_period)),   ### Remove the 'x' prefix (e.g., 'x1998' → '1998'), then convert to numeric type
    resident_number = as.numeric(resident_number)) %>%           ### Convert resident_number to numeric in case they were imported as character strings
  rename(reporting_region_name = region_name) %>%                ### Rename column from region_name to reporting_region_name
  arrange(report_period, reporting_region_name)                  ### Sort the data first by year, then alphabetically by region

view(resident_region_itl1)

### ITL1 region-area lookup (km²)
region_area_itl1 <- tribble(
  ~reporting_region_name, ~region_area_km2,
  "East", 19120,
  "East Midlands", 15610,
  "London", 1572,
  "North East", 8592,
  "North West", 14165,
  "Northern Ireland", 14130,
  "Scotland", 77933,
  "South East", 19070,
  "South West", 23829,
  "Wales", 20779,
  "West Midlands", 13000,
  "Yorkshire and The Humber", 15420)

view(region_area_itl1)

### Join area to the resident table (adds the new column)
resident_region_itl1 <- resident_region_itl1 %>%
  left_join(region_area_itl1, by = "reporting_region_name") %>%
  arrange(report_period, reporting_region_name)

resident_region_itl1 <- resident_region_itl1 %>% 
  mutate(population_density = resident_number / region_area_km2)

### Inspect
view(resident_region_itl1)

## ==== Section 2: Descriptive Analysis ====
if (!require(plm)) install.packages("plm")
if (!require(pgmm)) install.packages("pgmm")
if (!require(panelvar)) install.packages("panelvar")
if (!require(vars)) install.packages("vars")
library(plm)
library(pgmm)
library(panelvar)
library(vars)
### ==== ✈️ Section 2.1. Passengers volume ====
### Combine panel data for top3_pax_volume_airports_by_region_year and gva_region_itl1 dataset
passengers_volume_gva_panel <- left_join(
  top3_pax_volume_airports_by_region_year,
  gva_region_itl1,
  by = c("report_period", "reporting_region_name")) %>% ### join keys: same year + same ITL1 region
  ### Select only the variables needed for analysis (drop other columns)
  dplyr::select(report_period, reporting_region_name,
         region_total_atms_pax_aircraft,
         region_total_terminal_pax_volume, gva_value) %>%
  filter(report_period >= 1998, report_period <= 2023)   ### 🔥 Keep only within chosen time period

### Merge the passengers_volume_gva_panel with resident_region_itl1 dataset to add demographic and area-based controls.
passengers_volume_gva_panel <- left_join(
  passengers_volume_gva_panel,
  resident_region_itl1,
  by = c("report_period", "reporting_region_name")) %>% ### join keys: same year + same ITL1 region
  ### Select relevant variables for the final panel
  dplyr::select(report_period, reporting_region_name,
         region_total_atms_pax_aircraft,
         region_total_terminal_pax_volume, gva_value,
         resident_number, region_area_km2, population_density) %>%
  filter(report_period >= 1998, report_period <= 2023)   ### 🔥 Keep only within chosen time period

### Calculate GVA per head (per-capita GVA) by dividing total GVA by total resident population
passengers_volume_gva_panel <- passengers_volume_gva_panel %>%
  mutate(gva_per_head = gva_value/resident_number)

### Inspect the merged dataset to confirm variables and structure
print(passengers_volume_gva_panel, n=10)

### Log-transform selected variables for econometric modelling
passengers_volume_gva_panel <- passengers_volume_gva_panel %>%
  mutate(
    ### Log-transform aircraft movements for passengers
    ln_region_total_atms_pax_aircraft = log(region_total_atms_pax_aircraft),
    ### Log-transform passenger volume
    ln_region_total_terminal_pax_volume = log(region_total_terminal_pax_volume),
    ### Log-transform GVA
    ln_gva_per_head = log(gva_per_head),
    ### Log-transform population density
    ln_population_density = log(population_density)) %>%
    ### Remove the original (non-log) variables
  dplyr::select(-region_total_atms_pax_aircraft,
         -region_total_terminal_pax_volume,
         -gva_value, -gva_per_head,
         -resident_number, -region_area_km2,
         -population_density)

### Inspect the merged dataset to confirm variables and structure
print(passengers_volume_gva_panel, n=10)

#### ==== 🔎 Section 2.1.1. Inspect and clean passengers_volume panel data before panel regression ====
#### Display the structure of the passengers_volume dataset: variables, types, and preview of values
str(passengers_volume_gva_panel)
#### For each column, count how many values are NOT finite (i.e., NA, NaN, Inf, -Inf)
sapply(passengers_volume_gva_panel, function(x) sum(!is.finite(x)))

#### Convert region names (labels) into numeric integer codes
passengers_volume_gva_panel$reporting_region_name = as.integer(as.factor(passengers_volume_gva_panel$reporting_region_name))

#### Handle infinite values caused by log transformations
#### Replace -Inf and Inf with NA
passengers_volume_gva_panel <- passengers_volume_gva_panel %>%
  mutate(across(starts_with("ln_"), ~ ifelse(is.infinite(.), NA, .))) %>%
  drop_na()
#### As an extra safeguard: remove any rows where ANY variable has NA/NaN/Inf
passengers_volume_gva_panel <- passengers_volume_gva_panel %>%
  filter(if_all(everything(), ~ is.finite(.)))

#### Recheck the dataset: count remaining non-finite values in each column (should all be zero now)
sapply(passengers_volume_gva_panel, function(x) sum(!is.finite(x)))
#### Inspect the cleaned passengers dataset visually
print(passengers_volume_gva_panel, n=10)

#### Convert cleaned passengers dataset into a pdata.frame (specialised panel structure for plm)
passengers_panel_data <- pdata.frame(passengers_volume_gva_panel,
                                  index = c("reporting_region_name", "report_period")) # panel index: region (individual) × year (time)
#### Inspect the panel data object
view(passengers_panel_data)

#### Check whether the panel is balanced (each region has data for every year)
is.pbalanced(passengers_panel_data)
#### Get panel dimensions: number of individuals, time periods, total observations
pdim(passengers_panel_data)
#### Force the panel to be balanced by keeping only shared individuals with complete time series
passengers_panel_data <- make.pbalanced(passengers_panel_data, balance.type = "shared.individuals") # ensure same regions appear across all years

#### ==== 📻 Section 2.1.2. VAR Lag Selection and Stationarity Testing ====
#### Select endogenous variables (main system variables)
passengers_vars <- passengers_panel_data[, c("ln_gva_per_head", "ln_region_total_terminal_pax_volume")]
#### Define exogenous control variable as a data.frame (same row length)
exog_vars <- passengers_panel_data[, c("ln_population_density", "ln_region_total_atms_pax_aircraft")]

#### Make sure ln_population_density still exists in this dataset
pax_vars_needed <- c("ln_gva_per_head", "ln_region_total_terminal_pax_volume", "ln_population_density", "ln_region_total_atms_pax_aircraft")

#### Subset only these variables and drop rows with NA in any of them
data_for_var_1 <- na.omit(passengers_panel_data[, pax_vars_needed])

### Split into endogenous and exogenous sets (same rows!)
passengers_vars <- data_for_var_1[, c("ln_gva_per_head", "ln_region_total_terminal_pax_volume")]
exog_vars       <- data_for_var_1[, c("ln_population_density", "ln_region_total_atms_pax_aircraft"), drop = FALSE]

#### Run lag length selection for VAR model
#### VARselect evaluates different lag structures using criteria (AIC, BIC, HQ, FPE)
lag_selection <- VARselect(
  passengers_vars,          # endogenous variables
  lag.max = 3,              # maximum number of lags to test
  type = "const",           # include constant in the VAR specification
  exogen = exog_vars)       # include population density as an exogenous control
#### View lag length selection results
print(lag_selection, digits = 2)

##### Determine optimal lag from VARselect
optimal_lag_pax <- lag_selection$selection["SC(n)"]

#### Panel Unit Root Tests (IPS Test)
#### Test stationarity of passengers activity variable
print(purtest(ln_region_total_terminal_pax_volume ~ 1,     # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = passengers_panel_data, 
        test = "ips", lags = optimal_lag_pax), digits = 6) # Im-Pesaran-Shin panel unit root test
# -> Null hypothesis: variable contains unit root (non-stationary)
# -> Alternative: variable is stationary

#### Test stationarity of productivity variable
print(purtest(ln_gva_per_head ~ 1,                     # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = passengers_panel_data, 
        test = "ips", lags = optimal_lag_pax), digits = 6)

#### Test stationarity of population density control
print(purtest(ln_population_density ~ 1,               # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = passengers_panel_data, 
        test = "ips", lags = optimal_lag_pax), digits = 6)

#### Test stationarity of ATMs for passengers aircraft
print(purtest(ln_region_total_atms_pax_aircraft ~ 1,    # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = passengers_panel_data, 
        test = "ips", lags = optimal_lag_pax), digits = 6)


# Load required packages
library(plm)
library(officer)
library(flextable)

#### Im-Pesaran-Shin (IPS) panel unit root test
# -> Null hypothesis: variable contains unit root (non-stationary)
# -> Alternative: variable is stationary
#### Test stationarity of passengers activity variable
ips_ter_pax   <- purtest(ln_region_total_terminal_pax_volume ~ 1, 
                         data = passengers_panel_data, test = "ips", lags = optimal_lag_pax) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of productivity variable
ips_gva_pax   <- purtest(ln_gva_per_head ~ 1, 
                         data = passengers_panel_data, test = "ips", lags = optimal_lag_pax) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of population density control
ips_pop_pax   <- purtest(ln_population_density ~ 1, 
                         data = passengers_panel_data, test = "ips", lags = optimal_lag_pax) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of ATMs for passengers aircraft
ips_atms_pax  <- purtest(ln_region_total_atms_pax_aircraft ~ 1, 
                         data = passengers_panel_data, test = "ips", lags = optimal_lag_pax) # Regress the variable on just a constant (intercept), without any explanatory variables.

#### Function to safely extract IPS results 
extract_ips <- function(test_obj, var_name){
  # Extract the test statistic and p-value
  stat <- as.numeric(test_obj$statistic$statistic)
  pval <- as.numeric(test_obj$statistic$p.value)
  # Return as a data frame
  data.frame(
    Variable = var_name,
    Statistic = round(stat, 4),
    P_Value = round(pval, 4),
    Decision = ifelse(pval < 0.05, "Stationary", "Non-stationary"))}
  
#### Combine all test results
pax_results <- rbind(
  extract_ips(ips_ter_pax,  "Passengers Volume"),
  extract_ips(ips_gva_pax,  "Productivity (GVA)"),
  extract_ips(ips_pop_pax,  "Population Density"),
  extract_ips(ips_atms_pax , "Passenger ATMs"))

# Format into Word with flextable
ft_pax <- flextable(pax_results) %>%
  set_header_labels(
    Variable  = "Variable",
    Statistic = "IPS Statistic",
    P_value   = "P-Value",
    Decision  = "Stationarity Decision") %>%
  autofit() %>%
  theme_vanilla() %>%
  bold(part = "header") %>%
  align(align = "center", part = "all") %>%
  color(color = "white", part = "header") %>%
  bg(bg = "#2E75B6", part = "header") %>%   # blue header
  bg(bg = "#F2F2F2", part = "body")   # light grey rows


####Export to Word 
doc_pax <- read_docx() %>%
  body_add_par("IPS Panel Unit Root Test Results", style = "heading 1") %>%
  body_add_par("Table 1: Results of the Im-Pesaran-Shin panel unit root tests for key variables.", style = "Normal") %>%
  body_add_flextable(ft_pax)
print(doc_pax, target = "IPS_Test_Results.docx")

#### Endogenous: ln_gva_per_head (productivity), ln_region_total_passengers (passengers activity)
#### Exogenous control: ln_population_density
#### Index: reporting_region_name (id), report_period (time)
#### If variables are non-stationary, apply first differences to achieve stationary (e.g., mutate(log_inv_diff = diff(log_inv)))
#### First difference of log GVA per head (Δ productivity)
passengers_panel_data$diff_ln_gva_per_head <- diff(passengers_panel_data$ln_gva_per_head)
#### First difference of log population density (Δ density)
passengers_panel_data$diff_ln_population_density <- diff(passengers_panel_data$ln_population_density)
#### First difference of log ATMS (Δ ATMs)
passengers_panel_data$diff_ln_region_total_atms_pax_aircraft <- diff(passengers_panel_data$ln_region_total_atms_pax_aircraft)

#### Inspect updated panel dataset after adding differenced variables
view(passengers_panel_data)

#### ==== ✈️ Section 2.1.3. Panel VAR Implementation ====
#### Panel VAR with System-GMM (pvargmm)
pax_pvar <- panelvar::pvargmm(
  dependent_vars   = c("diff_ln_gva_per_head", "ln_region_total_terminal_pax_volume"), 
  lags             = optimal_lag_pax,
  exog_vars        = c("diff_ln_population_density", "diff_ln_region_total_atms_pax_aircraft"),
  transformation   = "fod",    # ✅ use forward orthogonal deviations (no extra differencing)
  data             = passengers_panel_data,
  panel_identifier = c("reporting_region_name", "report_period"),
  steps            = c("twostep"),      # Robust two-step GMM
  system_instruments = TRUE,            # Use Blundell-Bond System-GMM (instruments in levels and differences).
  #max_instr_dependent_vars = 99,
  #min_instr_dependent_vars = 2L,
  collapse         = TRUE)              # Collapse instrument matrix to avoid instrument proliferation (too many instruments relative to sample size)

#### Inspect model results (coefficients and diagnostics)
summary(pax_pvar)


#### Convert pdata.frame to data.frame first
pax_df <- as.data.frame(passengers_panel_data)
#### Inspect updated panel dataset
view(pax_df)

#### Make sure all variables are numeric
pax_df <- pax_df %>%
  mutate(
    diff_ln_gva_per_head = as.numeric(diff_ln_gva_per_head),
    ln_region_total_terminal_pax_volume = as.numeric(ln_region_total_terminal_pax_volume),
    diff_ln_population_density = as.numeric(diff_ln_population_density),
    diff_ln_region_total_atms_freight_aircraft = as.numeric(diff_ln_region_total_atms_pax_aircraft))

#### Name change for output visualization
pax_df <- pax_df %>%
  mutate(
    "GVA per head (differenced)" = as.numeric(diff_ln_gva_per_head),
    "Regional Passengers Volume (log)" = as.numeric(ln_region_total_terminal_pax_volume),
    "Population density (differenced)" = as.numeric(diff_ln_population_density),
    "ATMs (Passenger aircraft, differenced)" = as.numeric(diff_ln_region_total_atms_pax_aircraft))

#### Estimate FE-OLS PVAR
pax_pvar_fe <- panelvar::pvarfeols(
  dependent_vars   = c("GVA per head (differenced)", "Regional Passengers Volume (log)"),
  lags             = 2,
  exog_vars        = c("Population density (differenced)", "ATMs (Passenger aircraft, differenced)"),
  transformation   = "demean",  # within transformation for fixed effects
  data             = pax_df,
  panel_identifier = c("reporting_region_name", "report_period"))

#### Show summary
summary(pax_pvar_fe)

# Dummy variable

# Within estimator
# within = plm("GVA per head (differenced)" ~ "Regional Passengers Volume (log)" + factor(report_period), index = reporting_region_name, model = "within")

#### Model selection criteria (Andrews-Lu MMSC)
Andrews_Lu_MMSC(pax_pvar)
# -> Provides model selection diagnostics (Modified Schwarz, AIC, HQIC) adapted for GMM estimation.
# -> Helps validate whether chosen lag length is optimal.

#### Compute Generalized Impulse Response Functions (GIRFs) for the estimated GMM-PVAR model
girf_pax <- girf(
  pax_pvar_fe,
  n.ahead = 5,          # Forecast horizon for impulse responses (chosen periods ahead).
  ma_approx_steps = 20) # Number of approximation steps for moving-average representation of the VAR system.
  # -> Needed because GIRFs in GMM-PVAR are simulated, not exact like OLS.

#### Plot GIRFs
plot(girf_pax)
# -> Visualizes the GIRFs: response functions across horizons with bootstrapped confidence intervals.
# -> Used to assess short- and long-run dynamic effects and system stability.

#### Bootstrapped GIRFs (single core, Windows safe)
girf_pax_bs <- bootstrap_irf(
  pax_pvar_fe,
  typeof_irf   = c("GIRF"),
  n.ahead      = 5,
  nof_Nstar_draws = 100,   # number of bootstrap replications
  confidence.band = 0.95,
  mc.cores     = 1)        # ✅ force single core on Windows

#### Plot GIRFs
plot(girf_pax_bs)

#### ==== 🔗 Section 2.1.4. Panel Granger Causality Tests (Dumitrescu–Hurlin) ====
#### 1) Test whether passengers Granger-causes productivity (Panel Granger-causality (Dumitrescu–Hurlin) on differences series)
gc_pax_to_gva <- plm::pgrangertest(
  diff_ln_gva_per_head ~ ln_region_total_terminal_pax_volume,   # Y = productivity, X = passengers
  data  = passengers_panel_data,
  order = as.integer(2))                      # use the lag length chosen earlier

#### Show test results
print(gc_pax_to_gva)

#### 2) Test whether productivity Granger-causes passengers volume
gc_gva_to_pax <- plm::pgrangertest(
  ln_region_total_terminal_pax_volume ~ diff_ln_gva_per_head,   # Y = passengers, X = productivity
  data  = passengers_panel_data,
  order = as.integer(2))

#### Show test results
print(gc_gva_to_pax)

#### ==== 🔗 Section 2.1.5. Fixed Effects (FE) Model: Passenger Activity → Productivity ====
# Dependent variable: ln_gva_per_head (regional productivity)
# Key regressor: ln_region_total_terminal_pax_volume (passenger volume)
# Controls: ln_region_total_atms_pax_aircraft (aircraft movements), ln_population_density
fe_passenger_model <- plm(
  ln_gva_per_head ~ ln_region_total_terminal_pax_volume +
    ln_region_total_atms_pax_aircraft +
    ln_population_density,
  data  = passengers_panel_data,
  index = c("reporting_region_name", "report_period"),
  model = "within")   # "within" = Fixed Effects estimator

#### Inspect result
summary(fe_passenger_model)

library(sandwich)


#### Check whether error terms are autocorrelated or heteroskedastic:
#### Serial Correlation Test (Panel Breusch–Godfrey)
# H0: No serial correlation
# H1: Presence of serial correlation
pbgtest(fe_passenger_model)

#### Heteroskedasticity Test (Breusch–Pagan)
# H0: Homoskedastic errors
# H1: Heteroskedastic errors
# For panel models, use a formula interface with variables
bptest(fe_passenger_model, studentize = TRUE)

#### Optional: robust standard errors (clustered by region)
coeftest(fe_passenger_model, vcov = vcovHC(fe_passenger_model, type = "HC1", cluster = "group"))

#### Driscoll–Kraay SEs (robust to heteroskedasticity, serial correlation, and cross-sectional dependence)
coeftest(fe_passenger_model,
         vcov = vcovSCC(fe_passenger_model, type = "HC1", maxlag = optimal_lag_pax))

### ==== 📦 Secction 2.2. Freight volume ====
### Combine panel data for top3_cargo_freight_airports_by_region_year and gva_region_itl1 dataset
freight_volume_gva_panel <- left_join(
  top3_cargo_freight_airports_by_region_year,
  gva_region_itl1,
  by = c("report_period", "reporting_region_name")) %>% ### join keys: same year + same ITL1 region
  ### Select only the variables needed for analysis (drop other columns)
  dplyr::select(report_period, reporting_region_name,
         region_total_atms_freight_aircraft,
         region_total_freight, gva_value) %>%
  filter(report_period >= 1998, report_period <= 2023)   ### 🔥 Keep only chosen period

### Merge the freight_volume_gva_panel with resident_region_itl1 dataset to add demographic and area-based controls.
freight_volume_gva_panel <- left_join(
  freight_volume_gva_panel,
  resident_region_itl1,
  by = c("report_period", "reporting_region_name")) %>% ### join keys: same year + same ITL1 region
  ### Select relevant variables for the final panel
  dplyr::select(report_period, reporting_region_name,
         region_total_atms_freight_aircraft,
         region_total_freight, gva_value,
         resident_number, region_area_km2, population_density) %>%
  filter(report_period >= 1998, report_period <= 2023)   ### 🔥 Keep only chosen period

# Calculate GVA per head (per-capita GVA) by dividing total GVA by total resident population
freight_volume_gva_panel <- freight_volume_gva_panel %>%
  mutate(gva_per_head = gva_value/resident_number)

### Inspect the merged dataset to confirm variables and structure
print(freight_volume_gva_panel, n=10)

### Log-transform selected variables for econometric modelling
freight_volume_gva_panel <- freight_volume_gva_panel %>%
  mutate(
    ### Log-transform aircraft movements for freight
    ln_region_total_atms_freight_aircraft = log(region_total_atms_freight_aircraft + 1),
    ### Log-transform freight volume
    ln_region_total_freight = log(region_total_freight + 1),
    ### Log-transform GVA
    ln_gva_per_head = log(gva_per_head + 1),
    ### Log-transform population density
    ln_population_density = log(population_density + 1)) %>%
  dplyr::select(-region_total_atms_freight_aircraft,
         -region_total_freight,
         -gva_value, -gva_per_head,
         -resident_number, -region_area_km2,
         -population_density)

### Inspect the dataset again to confirm only log-transformed variables remain
view(freight_volume_gva_panel)

#### ==== 🔎 Section 2.2.1. Inspect and clean freight panel data before panel regression ====
#### Display the structure of the freight dataset: variables, types, and preview of values
str(freight_volume_gva_panel)
#### For each column, count how many values are NOT finite (i.e., NA, NaN, Inf, -Inf)
sapply(freight_volume_gva_panel, function(x) sum(!is.finite(x)))

# Force panel to be balanced by filling in missing years for each region
freight_volume_gva_panel<- freight_volume_gva_panel %>%
  group_by(reporting_region_name) %>%
  complete(report_period = full_seq(report_period, 1)) %>%   # fill all missing years
  arrange(reporting_region_name, report_period) %>%
  mutate(across(everything(), ~ zoo::na.locf(.x, na.rm = FALSE))) %>%  # fill forward
  ungroup()

#### Convert region names (labels) into numeric integer codes
freight_volume_gva_panel$reporting_region_name = as.integer(as.factor(freight_volume_gva_panel$reporting_region_name))

library(plm)
library(dplyr)
library(tidyr)
library(zoo)   # for na.locf


#### Handle infinite values caused by log transformations
#### Replace -Inf and Inf with NA
freight_volume_gva_panel <- freight_volume_gva_panel %>%
  mutate(across(starts_with("ln_"), ~ ifelse(is.infinite(.), NA, .))) %>%
  drop_na()
#### As an extra safeguard: remove any rows where ANY variable has NA/NaN/Inf
freight_volume_gva_panel <- freight_volume_gva_panel %>%
  filter(if_all(everything(), ~ is.finite(.)))

#### Recheck the dataset: count remaining non-finite values in each column (should all be zero now)
sapply(freight_volume_gva_panel, function(x) sum(!is.finite(x)))
#### Inspect the cleaned freight dataset visually
print(freight_volume_gva_panel, n=10)

#### Convert cleaned freight dataset into a pdata.frame (specialised panel structure for plm)
freight_panel_data <- pdata.frame(freight_volume_gva_panel,
                                  index = c("reporting_region_name", "report_period")) # panel index: region (individual) × year (time)
#### Inspect the panel data object
#view(freight_panel_data)

#### Check whether the panel is balanced (each region has data for every year)
is.pbalanced(freight_panel_data)
#### Get panel dimensions: number of individuals, time periods, total observations
pdim(freight_panel_data)
#### Force the panel to be balanced by keeping only shared individuals with complete time series
freight_panel_data <- make.pbalanced(freight_panel_data, balance.type = "shared.individuals") # ensure same regions appear across all years

#### ==== 📻 Section 2.2.2. VAR Lag Selection and Stationarity Testing ====
#### Select endogenous variables (main system variables)
freight_vars <- freight_panel_data [, c("ln_gva_per_head", "ln_region_total_freight")]
#### Define exogenous control variable as a data.frame (same row length)
exog_vars <- freight_panel_data [, c("ln_population_density", "ln_region_total_atms_freight_aircraft")]

#### Make sure ln_population_density still exists in this dataset
freight_vars_needed <- c("ln_gva_per_head", "ln_region_total_freight", "ln_population_density", "ln_region_total_atms_freight_aircraft")

#### Subset only these variables and drop rows with NA in any of them
data_for_var_2 <- na.omit(freight_panel_data[, freight_vars_needed])

### Split into endogenous and exogenous sets (same rows!)
freight_vars <- data_for_var_2[, c("ln_gva_per_head", "ln_region_total_freight")]
exog_vars    <- data_for_var_2[, c("ln_population_density", "ln_region_total_atms_freight_aircraft"), drop = FALSE]

#### Run lag length selection for VAR model
#### VARselect evaluates different lag structures using criteria (AIC, BIC, HQ, FPE)
lag_selection <- VARselect(
  freight_vars,             # endogenous variables
  lag.max = 3,              # maximum number of lags to test
  type = "const",           # include constant in the VAR specification
  exogen = exog_vars)       # include population density as an exogenous control
#### View lag length selection results
print(lag_selection, digits = 3)

# Determine optimal lag from VARselect
optimal_lag_freight <- lag_selection$selection["SC(n)"]

#### Panel Unit Root Tests (IPS Test)
#### Test stationarity of freight activity variable
print(purtest(ln_region_total_freight ~ 1,                # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = freight_panel_data, 
        test = "ips", lags = optimal_lag_freight), digits = 6)   # Im-Pesaran-Shin panel unit root test
# -> Null hypothesis: variable contains unit root (non-stationary)
# -> Alternative: variable is stationary

#### Test stationarity of productivity variable
print(purtest(ln_gva_per_head ~ 1,                        # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = freight_panel_data, 
        test = "ips", lags = optimal_lag_freight), digits = 6)

#### Test stationarity of population density control
print(purtest(ln_population_density ~ 1,                  # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = freight_panel_data, 
        test = "ips", lags = optimal_lag_freight), digits = 6)

#### Test stationarity of ATMs
print(purtest(ln_region_total_atms_freight_aircraft ~ 1,  # Regress the variable on just a constant (intercept), without any explanatory variables.
        data = freight_panel_data, 
        test = "ips", lags = optimal_lag_freight), digits = 6)


#### Im-Pesaran-Shin (IPS) panel unit root test
# -> Null hypothesis: variable contains unit root (non-stationary)
# -> Alternative: variable is stationary
#### Test stationarity of freight activity variable
ips_freight <- purtest(ln_region_total_freight ~ 1, 
                       data = freight_panel_data, test = "ips", lags = optimal_lag_freight) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of productivity variable
ips_gva_freight <- purtest(ln_gva_per_head ~ 1, 
                       data = freight_panel_data, test = "ips", lags = optimal_lag_freight) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of population density control
ips_pop_freight <- purtest(ln_population_density ~ 1, 
                       data = freight_panel_data, test = "ips", lags = optimal_lag_freight) # Regress the variable on just a constant (intercept), without any explanatory variables.
#### Test stationarity of ATMs
ips_atms_freight <- purtest(ln_region_total_atms_freight_aircraft ~ 1, 
                       data = freight_panel_data, test = "ips", lags = optimal_lag_freight) # Regress the variable on just a constant (intercept), without any explanatory variables.

#### Combine all test results for freight panel
freight_results <- rbind(
  extract_ips(ips_freight,      "Freight Volume"),
  extract_ips(ips_gva_freight,  "Productivity (GVA)"),
  extract_ips(ips_pop_freight,  "Population Density"),
  extract_ips(ips_atms_freight, "Freight ATMs"))

# Format into Word with flextable
ft_freight <- flextable(freight_results) %>%
  set_header_labels(
    Variable  = "Variable",
    Statistic = "IPS Statistic",
    P_value   = "P-Value",
    Decision  = "Stationarity Decision") %>%
  autofit() %>%
  theme_vanilla() %>%
  bold(part = "header") %>%
  align(align = "center", part = "all") %>%
  color(color = "white", part = "header") %>%
  bg(bg = "#2E75B6", part = "header") %>%   # blue header
  bg(bg = "#F2F2F2", part = "body")         # light grey rows

#### Export to Word 
doc_freight <- read_docx() %>%
  body_add_par("IPS Panel Unit Root Test Results", style = "heading 1") %>%
  body_add_par("Table 2: Results of the Im-Pesaran-Shin panel unit root tests for freight-related variables.", style = "Normal") %>%
  body_add_flextable(ft_freight)

print(doc_freight, target = "IPS_Freight_Test_Results.docx")

#### Endogenous: ln_gva_per_head (productivity), ln_region_total_freight (freight activity)
#### Exogenous control: ln_population_density
#### Index: reporting_region_name (id), report_period (time)
#### If variables are non-stationary, apply first differences to achieve stationary (e.g., mutate(log_inv_diff = diff(log_inv)))
#### First difference of log GVA per head (Δ productivity)
freight_panel_data$diff_ln_gva_per_head <- diff(freight_panel_data$ln_gva_per_head)
#### First difference of log population density (Δ density)
freight_panel_data$diff_ln_population_density <- diff(freight_panel_data$ln_population_density)
#### First difference of log ATMS (Δ ATMs)
freight_panel_data$diff_ln_region_total_atms_freight_aircraft <- diff(freight_panel_data$ln_region_total_atms_freight_aircraft)

#### Inspect updated panel dataset after adding differenced variables
view(freight_panel_data)

#### ==== 🚧 Section 2.2.3. Panel VAR Implementation ====
freight_pvar_gmm <- panelvar::pvargmm(
  dependent_vars   = c("diff_ln_gva_per_head", "ln_region_total_freight"), 
  lags             = optimal_lag_freight,
  exog_vars        = c("diff_ln_population_density", "diff_ln_region_total_atms_freight_aircraft"),
  transformation   = "fod",             # Use forward orthogonal deviations (no extra differencing)
  data             = freight_panel_data,
  panel_identifier = c("reporting_region_name", "report_period"),
  steps            = c("twostep"),      # robust two-step GMM
  system_instruments = FALSE,            # use Blundell–Bond style system instruments
  #max_instr_dependent_vars = 99,
  #min_instr_dependent_vars = 2L,
  collapse         = TRUE)              # collapse instruments to avoid proliferation


#### Inspect model results (coefficients and diagnostics)
summary(freight_pvar_gmm)

str(freight_panel_data)
#### Check what functions are exported from panelvar
ls("package:panelvar")
#### Or check if the function exists
exists("pvarfeols", where = "package:panelvar")

library(dplyr)
library(panelvar)

#### Convert pdata.frame to data.frame first
freight_df <- as.data.frame(freight_panel_data)

view(freight_df)

#### Make sure all variables are numeric
freight_df <- freight_df %>%
  mutate(
    diff_ln_gva_per_head = as.numeric(diff_ln_gva_per_head),
    ln_region_total_freight = as.numeric(ln_region_total_freight),
    diff_ln_population_density = as.numeric(diff_ln_population_density),
    diff_ln_region_total_atms_freight_aircraft = as.numeric(diff_ln_region_total_atms_freight_aircraft))

#### Name change for output visualization
freight_df <- freight_df %>%
  mutate(
    "GVA per head (differenced)" = as.numeric(diff_ln_gva_per_head),
    "Regional Freight (log)" = as.numeric(ln_region_total_freight),
    "Population density (differenced)" = as.numeric(diff_ln_population_density),
    "ATMs (Freight aircraft, differenced)" = as.numeric(diff_ln_region_total_atms_freight_aircraft))

#### Estimate FE-OLS PVAR
freight_pvar_fe <- panelvar::pvarfeols(
  dependent_vars   = c("GVA per head (differenced)", "Regional Freight (log)"),
  lags             = 2,
  exog_vars        = c("Population density (differenced)", "ATMs (Freight aircraft, differenced)"),
  transformation   = "demean",  # within transformation for fixed effects
  data             = freight_df,
  panel_identifier = c("reporting_region_name", "report_period"))

#### Show summary
summary(freight_pvar_fe)

#### Model selection criteria (Andrews-Lu MMSC)
Andrews_Lu_MMSC(freight_pvar_fe)
# -> Provides model selection diagnostics (Modified Schwarz, AIC, HQIC) adapted for GMM estimation.
# -> Helps validate whether chosen lag length is optimal.

#### Compute Impulse Response Functions (IRFs): How a shock in one variable affects others over time
#### Example: Shock to passenger volume, response in productivity
#### Calculate the IRFs. `n.ahead` specifies the number of periods to look ahead.
#### Compute Generalized Impulse Response Functions (GIRFs) for the estimated GMM-PVAR model
girf_freight <- girf(
  freight_pvar_fe,
  n.ahead = 5,         # Forecast horizon for impulse responses (10 periods ahead).
  ma_approx_steps = 20) # Number of approximation steps for moving-average representation of the VAR system.
# -> Needed because GIRFs in GMM-PVAR are simulated, not exact like OLS.

#### Plot GIRFs
plot(girf_freight)
# -> Visualizes the GIRFs: response functions across horizons with bootstrapped confidence intervals.
# -> Used to assess short- and long-run dynamic effects and system stability.

# Bootstrapped GIRFs (single core, Windows safe)
girf_freight_bs <- bootstrap_irf(
  freight_pvar_fe,
  typeof_irf   = c("GIRF"),
  n.ahead      = 10,
  nof_Nstar_draws = 100,   # number of bootstrap replications
  confidence.band = 0.95,
  mc.cores     = 1)        # ✅ force single core on Windows

#### Plot GIRF bootstrap
plot(girf_freight_bs)

#### ==== 🔗 Section 2.2.4. Panel Granger Causality Tests (Dumitrescu–Hurlin) ====
#### 1) Test whether freight Granger-causes productivity (Panel Granger-causality (Dumitrescu–Hurlin) on differences series)
gc_freight_to_gva <- plm::pgrangertest(
  diff_ln_gva_per_head ~ ln_region_total_freight,   # Y = productivity, X = freight
  data  = freight_panel_data,
  order = as.integer(2))          # use the lag length chosen earlier

#### Show test results
print(gc_freight_to_gva)

#### 2) Test whether productivity Granger-causes freight
gc_gva_to_freight <- plm::pgrangertest(
  ln_region_total_freight ~ diff_ln_gva_per_head,   # Y = freight, X = productivity
  data  = freight_panel_data,
  order = as.integer(2))

#### Show test results
print(gc_gva_to_freight)

#### ==== 🔗 Section 2.2.5.Fixed Effects (FE) Model: Freight Activity → Productivity ====
# Dependent variable: ln_gva_per_head (regional productivity)
# Key regressor: ln_region_total_freight (freight volume)
# Controls: ln_region_total_atms_freight_aircraft (ATMs), ln_population_density
fe_freight_model <- plm(
  ln_gva_per_head ~ ln_region_total_freight +
    ln_region_total_atms_freight_aircraft +
    ln_population_density,
  data  = freight_panel_data,
  index = c("reporting_region_name", "report_period"), # panel identifiers
  model = "within")   # FE estimator (within transformation)

#### Inspect standard FE results
summary(fe_freight_model)


#### Check whether error terms are autocorrelated or heteroskedastic:
#### Serial Correlation Test (Panel Breusch–Godfrey)
# H0: No serial correlation
# H1: Presence of serial correlation
pbgtest(fe_freight_model)

#### Heteroskedasticity Test (Breusch–Pagan)
# H0: Homoskedastic errors
# H1: Heteroskedastic errors
# For panel models, use a formula interface with variables
bptest(fe_freight_model, studentize = TRUE)

#### Optional: robust standard errors (clustered by region)
coeftest(fe_freight_model, vcov = vcovHC(fe_passenger_model, type = "HC1", cluster = "group"))

#### Driscoll–Kraay SEs (robust to heteroskedasticity, serial correlation, and cross-sectional dependence)
coeftest(fe_freight_model,vcov = vcovSCC(fe_passenger_model, type = "HC1", maxlag = optimal_lag_freight))

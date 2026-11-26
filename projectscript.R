library(readr)
library(arm)
library(ggplot2)
library(ggrepel)
library(car)
library(dplyr)

data <- read_excel("DatiAfrica.FINALI.xlsx")
View(data)
df <- read_csv("final_reshaped_FAOSTAT.csv")
df$PoU <- as.numeric(df$PoU)
View(df)
str(df)

#descriptive statistics
summary(df$PoU, na.rm = TRUE)
summary(df$pol, na.rm = TRUE)

attach(df)

#histograms
mean_pou <- mean(PoU, na.rm = TRUE)
median_pou <- median(PoU, na.rm = TRUE)
mean_pol <- mean(pol, na.rm = TRUE)
median_pol <- median(pol, na.rm = TRUE)
par(mfrow=c(1,2))
hist(PoU, xlim = c(0,60), freq = F, xlab = "Prevalence of Undernourishment", col = "light blue")
abline(v=mean_pou, col = "dark red", lwd=2, lty=2)
abline(v=median_pou, col = "dark blue", lwd=2, lty=3)
hist(pol, xlim = c(-3,3), freq = F, xlab = "Political Stability", col = "light blue")
abline(v=mean_pol, col = "dark red", lwd=2, lty=2)
abline(v=median_pol, col = "dark blue", lwd=2, lty=3)

#map 
ggplot(df, aes(pol, PoU, label = Area)) +
  geom_point(aes(color = Area), size = 3) +
  geom_text_repel(aes(label = Area), size = 3) +
  geom_smooth(method = "lm", se = FALSE, col = "dark red") +
  labs(title = "Relationship between Political Stability and Prevalnce of Undernourishment",
       x = "Political Stability",
       y = "Prevalence of Undernourishment") +
  theme_light() +
  theme(legend.position = "none")

#checking "worse" situations
lowest_pou <- head(sort(PoU, decreasing = TRUE))
lowest_pol <- head(sort(pol, decreasing = FALSE))
lowest_pou
lowest_pol

# Get the indices of the top 6 highest PoU values
indices_pou <- which(df$PoU %in% lowest_pou)

# Get the indices of the bottom 6 political stability values
indices_pol <- which(df$pol %in% lowest_pol)

# Extract the corresponding rows
rows_pou <- df[indices_pou, ]
rows_pol <- df[indices_pol, ]

# Print the results
print("Countries with highest PoU:")
print(rows_pou)

print("Countries with lowest political stability:")
print(rows_pol)

#Time series analysis
cases <- read_csv("cases.csv")

#turning the three years averages into 4 digit numbers
cases$Year_clean <- ifelse(
  grepl("-", cases$Year),  # Check if it's a range
  as.numeric(substr(cases$Year, 1, 4)) + 1,  # Extract first year and add 1
  as.numeric(cases$Year)  # Otherwise, keep as numeric
)
cases[,-1]
View(cases)

# Pivoting the data so that each 'Item' becomes a column
cases_clean <- cases%>%
  select(Area, Item, Value, Year_clean) %>%
  pivot_wider(names_from = Item, values_from = Value)

# Renaming long column names to short, analysis-friendly labels
cases_final <- cases_clean %>%
  rename(
    PoU   = "Prevalence of undernourishment (percent) (3-year average)",
    pol = "Political stability and absence of violence/terrorism (index)")
View(cases_final)

#Somalia
#political stability
unit_data <- cases_final %>% filter(Area == "Somalia")
par(mfrow=c(1,2))
ggplot(unit_data, aes(x=Year_clean, y=pol)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="springgreen") +
  labs(title="Trend of the political stability \n over time for Somalia",
       x="Year", y="political stability") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  ) +
  theme_light()
#PoU
ggplot(unit_data, aes(x=Year_clean, y= PoU)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="cyan3") +
  labs(title="Trend of the prevalence of undernourishment \n over time for Somalia",
       x="Year", y="prevalence of undernourishment") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  )+
  theme_light()

#Madagascar
#political stability
unit_data <- cases_final %>% filter(Area == "Madagascar")
par(mfrow=c(1,2))
ggplot(unit_data, aes(x=Year_clean, y=pol)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="springgreen") +
  labs(title="Trend of the political stability \n over time for Madagascar",
       x="Year", y="political stability") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  )+
  theme_light()
#PoU
ggplot(unit_data, aes(x=Year_clean, y= PoU)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="cyan3") +
  labs(title="Trend of the prevalence of undernourishment \n over time for Madagascar",
       x="Year", y="prevalence of undernourishment") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  )+
  theme_light()

#Mali
#political stability
unit_data <- cases_final %>% filter(Area == "Mali")
par(mfrow=c(1,2))
ggplot(unit_data, aes(x=Year_clean, y=pol)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="springgreen") +
  labs(title="Trend of the political stability \n over time for Mali",
       x="Year", y="political stability") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  )+
  theme_light()
#PoU
ggplot(unit_data, aes(x=Year_clean, y= PoU)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="cyan3") +
  labs(title="Trend of the prevalence of undernourishment \n over time for Mali",
       x="Year", y="prevalence of undernourishment") +
  scale_x_continuous(
    limits = c(2013, 2022),
    breaks = seq(2013, 2022, by = 1)  # show every year
  )+
  theme_light()

library(ismev)

#load the data
data = read.csv2(file = "./Data/lausanne.csv", header = T, sep = ";", stringsAsFactors = F, )
summary(data)
str(data)
data$tre200nx = as.numeric(data$tre200nx)
data$time = as.Date(as.character(data$time), "%Y%m%d")

summary(data)
plot(data$time, data$tre200nx)

#convert to yearly data maximum

year_vec = lubridate::year(data$time)
yearly_data =aggregate(data$tre200nx, list(year_vec), max, na.rm =T)
colnames(yearly_data) = c("year", "obs")

plot(yearly_data$year, yearly_data$obs)

?ismev
fit_gev=gev.fit(yearly_data$obs)
gev.diag(fit_gev)
fit_gev$mle
#comment/ negative shape param

mod_1 =gev.fit(xdat = yearly_data$obs,ydat = matrix(yearly_data$year, ncol = 1 ),  mul = 1)
mod_2 =gev.fit(xdat = yearly_data$obs,ydat = matrix(yearly_data$year, ncol = 1 ),  shl  = 1)
mod_3 =gev.fit(xdat = yearly_data$obs,ydat = matrix(yearly_data$year, ncol = 1 ),  sigl  = 1)

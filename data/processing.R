# use rstudioapi package to get file directory
library(rstudioapi)

# set working directory to match this file's directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

d <- read.csv("filtered_data.csv", header=TRUE)
d$player.treatment<-factor(d$player.treatment, levels = c(0:1), labels = c("No time pressure","Time pressure"))
d$metric.queries_pm <- d$player.queries_issued / (d$player.total_task_time / 60)
d$metric.documents_viewed_pm <- d$player.documents_viewed / (d$player.total_task_time / 60)
d$metric.documents_relevant_pm <- d$player.marked_as_relevant / (d$player.total_task_time / 60)
d$metric.serps_viewed_pm <- d$player.serps_viewed / (d$player.total_task_time / 60)
d$metric.documents_viewed_pq <- d$player.documents_viewed / d$player.queries_issued
d$metric.documents_time <- d$player.document_view_time / d$player.documents_viewed
d$metric.serps_time <- d$player.serp_view_time / d$player.queries_issued
# d$metric.view_depth

#ntp <- d[d$player.treatment == "No time pressure"]
#tp <- d[d$player.treatment == "Time pressure"]

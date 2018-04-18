# use rstudioapi package to get file directory
library(rstudioapi)
# Package includes Levene's test 
library(car)

# set working directory to match this file's directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# column wise standard deviation
colSd <- function (x, na.rm=FALSE) apply(X=x, MARGIN=2, FUN=sd, na.rm=na.rm)

# read data
d <- read.csv("filtered_data.csv", header=TRUE)

# system metrics
d$player.treatment<-factor(d$player.treatment, levels = c(0:1), labels = c("No time pressure","Time pressure"))
d$metric.queries_pm <- d$player.queries_issued / (d$player.total_task_time / 60)
d$metric.documents_viewed_pm <- d$player.documents_viewed / (d$player.total_task_time / 60)
d$metric.documents_relevant_pm <- d$player.marked_as_relevant / (d$player.total_task_time / 60)
d$metric.serps_viewed_pq <- d$player.serps_viewed / d$player.queries_issued
d$metric.documents_viewed_pq <- d$player.documents_viewed / d$player.queries_issued
d$metric.view_depth_pq <- (d$player.hover_depth + d$player.current_hover_depth) / d$player.queries_issued
d$metric.documents_time <- d$player.document_view_time / d$player.documents_viewed
d$metric.serps_time <- d$player.serp_view_time / d$player.queries_issued
d$metric.total_task_time_m <- d$player.total_task_time / 60
d$metric.time_pressure <- rowMeans(d[,c('player.feel_hurried_rushed','player.feel_time_pressure','player.need_work_fast')])

d$metric.documents_time[is.nan(d$metric.documents_time)] <- 0

# time pressure and no time pressure
tp <- subset(d, d$player.treatment == "Time pressure")
ntp <- subset(d, d$player.treatment == "No time pressure")

# user reports
sprintf("Felt time pressure: ntp %s(%s), tp %s(%s)", mean(ntp$player.feel_time_pressure), sd(ntp$player.feel_time_pressure), mean(tp$player.feel_time_pressure), sd(tp$player.feel_time_pressure))
sprintf("Needed to work fast: ntp %s(%s), tp %s(%s)", mean(ntp$player.need_work_fast), sd(ntp$player.need_work_fast), mean(tp$player.need_work_fast), sd(tp$player.need_work_fast))
sprintf("Felt hurried or rushed: ntp %s(%s), tp %s(%s)", mean(ntp$player.feel_hurried_rushed), sd(ntp$player.feel_hurried_rushed), mean(tp$player.feel_hurried_rushed), sd(tp$player.feel_hurried_rushed))
sprintf("Task difficult: ntp %s(%s), tp %s(%s)", mean(ntp$player.difficult), sd(ntp$player.difficult), mean(tp$player.difficult), sd(tp$player.difficult))	
sprintf("Performed well: ntp %s(%s), tp %s(%s)", mean(ntp$player.performed_well), sd(ntp$player.performed_well), mean(tp$player.performed_well), sd(tp$player.performed_well))	
sprintf("Task interesting: ntp %s(%s), tp %s(%s)", mean(ntp$player.interesting), sd(ntp$player.interesting), mean(tp$player.interesting), sd(tp$player.interesting))	

# other
sprintf("Total task time: ntp %s(%s), tp %s(%s)", mean(ntp$metric.total_task_time_m), sd(ntp$metric.total_task_time_m), mean(tp$metric.total_task_time_m), sd(tp$metric.total_task_time_m))
# system metrics
sprintf("Queries per minute: ntp %s(%s), tp %s(%s)", mean(ntp$metric.queries_pm), sd(ntp$metric.queries_pm), mean(tp$metric.queries_pm), sd(tp$metric.queries_pm))
sprintf("Documents viewed per minute: ntp %s(%s), tp %s(%s)", mean(ntp$metric.documents_viewed_pm), sd(ntp$metric.documents_viewed_pm), mean(tp$metric.documents_viewed_pm), sd(tp$metric.documents_viewed_pm))
sprintf("Documents marked as relevant per minute: ntp %s(%s), tp %s(%s)", mean(ntp$metric.documents_relevant_pm), sd(ntp$metric.documents_relevant_pm), mean(tp$metric.documents_relevant_pm), sd(tp$metric.documents_relevant_pm))
sprintf("SERPs viewed per query: ntp %s(%s), tp %s(%s)", mean(ntp$metric.serps_viewed_pq), sd(ntp$metric.serps_viewed_pq), mean(tp$metric.serps_viewed_pq), sd(tp$metric.serps_viewed_pq))
sprintf("Documents viewed per query: ntp %s(%s), tp %s(%s)", mean(ntp$metric.documents_viewed_pq), sd(ntp$metric.documents_viewed_pq), mean(tp$metric.documents_viewed_pq), sd(tp$metric.documents_viewed_pq))
sprintf("View depth: ntp %s(%s), tp %s(%s)", mean(ntp$metric.view_depth), sd(ntp$metric.view_depth), mean(tp$metric.view_depth), sd(tp$metric.view_depth))
sprintf("Total time per document: ntp %s(%s), tp %s(%s)", mean(ntp$metric.documents_time), sd(ntp$metric.documents_time), mean(tp$metric.documents_time), sd(tp$metric.documents_time))
sprintf("Time on SERPs per query: ntp %s(%s), tp %s(%s)", mean(ntp$metric.serps_time), sd(ntp$metric.serps_time), mean(tp$metric.serps_time), sd(tp$metric.serps_time))

############ LEVENE'S TEST ##################

leveneTest(d$player.feel_time_pressure, d$player.treatment, center = median)


############ USER REPORTS ##################

# felt time pressure
model0 <- lm(player.feel_time_pressure ~ 1, data = d)
model1 <- lm(player.feel_time_pressure ~ player.treatment, data = d)
anova(model0,model1)

# needed to work fast
model0 <- lm(player.need_work_fast ~ 1, data = d)
model1 <- lm(player.need_work_fast ~ player.treatment, data = d)
anova(model0,model1)

# felt hurried or rushed
model0 <- lm(player.feel_hurried_rushed ~ 1, data = d)
model1 <- lm(player.feel_hurried_rushed ~ player.treatment, data = d)
anova(model0,model1)

# search task difficult
model0 <- lm(player.difficult ~ 1, data = d)
model1 <- lm(player.difficult ~ player.treatment, data = d)
anova(model0,model1)

# performed well on search task
model0 <- lm(player.performed_well ~ 1, data = d)
model1 <- lm(player.performed_well ~ player.treatment, data = d)
anova(model0,model1)

# interesting search topic
model0 <- lm(player.interesting ~ 1, data = d)
model1 <- lm(player.interesting ~ player.treatment, data = d)
anova(model0,model1)

############ SYSTEM METRICS ##################

# total task time
model0 <- lm(metric.total_task_time_m ~ 1, data = d)
model1 <- lm(metric.total_task_time_m ~ player.treatment, data = d)
anova(model0,model1)

# queries per minute
model0 <- lm(metric.queries_pm ~ 1, data = d)
model1 <- lm(metric.queries_pm ~ player.treatment, data = d)
anova(model0,model1)

# documents viewed per minute
model0 <- lm(metric.documents_viewed_pm ~ 1, data = d)
model1 <- lm(metric.documents_viewed_pm ~ player.treatment, data = d)
anova(model0,model1)

# documents marked as relevant per minute
model0 <- lm(metric.documents_relevant_pm ~ 1, data = d)
model1 <- lm(metric.documents_relevant_pm ~ player.treatment, data = d)
anova(model0,model1)

# serps viewed per query
model0 <- lm(metric.serps_viewed_pq ~ 1, data = d)
model1 <- lm(metric.serps_viewed_pq ~ player.treatment, data = d)
anova(model0,model1)

# documents viewed per query
model0 <- lm(metric.documents_viewed_pq ~ 1, data = d)
model1 <- lm(metric.documents_viewed_pq ~ player.treatment, data = d)
anova(model0,model1)

# view depth per serp
model0 <- lm(metric.view_depth ~ 1, data = d)
model1 <- lm(metric.view_depth ~ player.treatment, data = d)
anova(model0,model1)

# total time per document
model0 <- lm(metric.documents_time ~ 1, data = d)
model1 <- lm(metric.documents_time ~ player.treatment, data = d)
anova(model0,model1)

# serp view time per query
model0 <- lm(metric.serps_time ~ 1, data = d)
model1 <- lm(metric.serps_time ~ player.treatment, data = d)
anova(model0,model1)

############ HYPOTHESES ##################

# H1: queries per minute
model0 <- lm(metric.queries_pm ~ 1, data = d)
model1 <- lm(metric.queries_pm ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.queries_pm, d$metric.time_pressure)

# H1: documents viewed per minute
model0 <- lm(metric.documents_viewed_pm ~ 1, data = d)
model1 <- lm(metric.documents_viewed_pm ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.documents_viewed_pm, d$metric.time_pressure)

# H1: documents marked as relevant per minute
model0 <- lm(metric.documents_relevant_pm ~ 1, data = d)
model1 <- lm(metric.documents_relevant_pm ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.documents_relevant_pm, d$metric.time_pressure)

# H2: serps viewed per query
model0 <- lm(metric.serps_viewed_pq ~ 1, data = d)
model1 <- lm(metric.serps_viewed_pq ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.serps_viewed_pq, d$metric.time_pressure)

# H2: documents viewed per query
model0 <- lm(metric.documents_viewed_pq ~ 1, data = d)
model1 <- lm(metric.documents_viewed_pq ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.documents_viewed_pq, d$metric.time_pressure)

# H2: view depth per query
model0 <- lm(metric.view_depth_pq ~ 1, data = d)
model1 <- lm(metric.view_depth_pq ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.view_depth_pq, d$metric.time_pressure)

# H3: total time per document
model0 <- lm(metric.documents_time ~ 1, data = d)
model1 <- lm(metric.documents_time ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.documents_time, d$metric.time_pressure)

# H3: serp view time per query
model0 <- lm(metric.serps_time ~ 1, data = d)
model1 <- lm(metric.serps_time ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.serps_time, d$metric.time_pressure)

# H3: total task time
model0 <- lm(metric.total_task_time_m ~ 1, data = d)
model1 <- lm(metric.total_task_time_m ~ metric.time_pressure, data = d)
anova(model0,model1)
cor(d$metric.total_task_time_m, d$metric.time_pressure)

############ TOPICS ##################

table_columns <- c('player.difficult','player.performed_well','player.interesting')

# journalist risk
s <- subset(d, d$player.topicname == "Journalist Risk")[,table_columns]
colMeans(s)
colSd(s)

# piracy
s <- subset(d, d$player.topicname == "Piracy")[,table_columns]
colMeans(s)
colSd(s)

# population growth
s <- subset(d, d$player.topicname == "Population Growth")[,table_columns]
colMeans(s)
colSd(s)

# wildlife extinction
s <- subset(d, d$player.topicname == "Wildlife Extinction")[,table_columns]
colMeans(s)
colSd(s)

# search task difficult
model0 <- lm(player.difficult ~ 1, data = d)
model1 <- lm(player.difficult ~ player.topicname, data = d)
anova(model0,model1)

# performed well on search task
model0 <- lm(player.performed_well ~ 1, data = d)
model1 <- lm(player.performed_well ~ player.topicname, data = d)
anova(model0,model1)

# interesting search topic
model0 <- lm(player.interesting ~ 1, data = d)
model1 <- lm(player.interesting ~ player.topicname, data = d)
anova(model0,model1)

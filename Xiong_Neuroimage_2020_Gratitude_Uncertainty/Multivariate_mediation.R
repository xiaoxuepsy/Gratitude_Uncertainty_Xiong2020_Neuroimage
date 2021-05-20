library(ggplot2)

library(lavaan)


setwd("Z:/XiongWei/behavior")
reg_data = read.table("correlation.txt", header = TRUE)


#### Recale data within subject ####
out <-data.frame()
for(i in unique(reg_data$sub) ){
  sub_dat <- reg_data[reg_data$sub==i,]
  out<-rbind(out,scale(sub_dat,center = T,scale=T))
}


SEM_data = data.frame(cbind(scale(out$uncertainty),scale(out$agent),scale(out$gra),scale(out$money),scale(out$intention),scale(out$predictionerror)))
names(SEM_data)=c('uncertainty','agent','gratitude','money','intention','predictionerror')


###### Condition - Expectation violation - Intention ########
model1 <- ' # outcome model
intention ~ c11*uncertainty+c12*agent+c13*uncertainty:agent + b1*predictionerror

# mediator
predictionerror ~ a11*uncertainty + a12*agent+ a13*uncertainty:agent

# indirect effect (a*b)
uncertaintypredictionerror := a11*b1
agentpredictionerror  := a12*b1
intpredictionerror := a13*b1


ab := (a11+a12+a13)*b1

# total effect
totaluncertaintypredictionerror := c11 + a11*b1 
totalagentpredictionerror := c12 + a12*b1 
totalintpredictionerror := c13 + a13*b1 


plusuncertaintypredictionerror := c11
plusagentpredictionerror := c12 
plusintpredictionerror := c13

total:= (c11+c12+c13) + (a11+a12+a13)*b1 
plustotal:= (c11+c12+c13)
'
fit1 <- sem(model1, data = SEM_data)
summary(fit1)



###### Condition - Intention - Gratitude ########

model2 <- ' # outcome model
gratitude ~ c11*uncertainty+c12*agent+c13*uncertainty:agent + b1*intention

# mediator
intention ~ a11*uncertainty+ a12*agent+ a13*uncertainty:agent

# indirect effect (a*b)
uncertaintyintention := a11*b1
agentintention  := a12*b1
intintention := a13*b1


ab := (a11+a12+a13)*b1

# total effect
totaluncertaintyintention := c11 + a11*b1 
totalagentintention := c12 + a12*b1 
totalintintention := c13 + a13*b1 


plusuncertaintyintention := c11
plusagentintention := c12 
plusintintention := c13

total:= (c11+c12+c13) + (a11+a12+a13)*b1 
plustotal:= (c11+c12+c13)
'
fit2 <- sem(model2, data = SEM_data)
summary(fit2)



###### Condition - Gratitude - Allocation ########

model3 <- ' # outcome model
money ~ c11*uncertainty+c12*agent+c13*uncertainty:agent + b1*gratitude

# mediator
gratitude ~ a11*uncertainty+ a12*agent+ a13*uncertainty:agent

# indirect effect (a*b)
uncertaintygratitude := a11*b1
agentgratitude  := a12*b1
intgratitude := a13*b1


ab := (a11+a12+a13)*b1

# total effect
totaluncertaintygratitude := c11 + a11*b1 
totalagentgratitude := c12 + a12*b1 
totalintgratitude := c13 + a13*b1 


plusuncertaintygratitude := c11
plusagentgratitude := c12 
plusintgratitude := c13

total:= (c11+c12+c13) + (a11+a12+a13)*b1 
plustotal:= (c11+c12+c13)
'
fit3 <- sem(model3, data = SEM_data)
summary(fit3)





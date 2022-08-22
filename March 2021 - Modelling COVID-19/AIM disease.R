library(tidyverse)
library(deSolve)

# ds/dt = -beta * S * I / N
# dI/dt =  beta * S * I / N - sigma * I
# dR/dt = sigma * I

#first need a function
#difine initial state
#create parameters and times for which to simulate
#

SIR = function(t, state, parameters){
  with(as.list(c(state, parameters)),{
    N = S + I + R
    
    dS = -beta * S * I / N + u*N - u*S      #Beta is Infection rate
    dI = beta * S * I / N - sigma * I - u*S
    dR = sigma * I - u*R
      
    return(list(c(dS,dI,dR)))
  })
}

t = 0
state = c(S=9999, I=1, R=0)
parameters = c(beta=0.1, sigma=0.3, u=0.0142)

#S=suseptible,Rrrate
#test
SIR(t, state, parameters)

#adding in time
#make sequence of numbers
times = seq(0, 100, by=0.1)
#             parameter=var
epidemic = ode(y = state, times = times, func = SIR, parms = parameters)

plot(epidemic[,'time'], epidemic[,'I'], type = 'l')
#for pretty graphs gtplot needs dataframe
epidemic = data.frame(ode(y = state, times = times, func = SIR, parms = parameters))

ggplot(epidemic, aes(x=time, y=I)) +
  geom_line()

ggplot(epidemic, aes(x=time)) +
  geom_line(aes(y=S, col='S')) +
  geom_line(aes(y=I, col='I')) +
  geom_line(aes(y=R, col='R'))

# convert to long format
epidemic = epidemic %>%
  gather(state, n, S:R) %>% #columns from s to r appended
  mutate(state = factor(state))

#now graph is alot similar in this dataframe
ggplot(epidemic, aes(x=time, y=n, col=state))+
  geom_line()

ggplot(epidemic, aes(x=time, y=n, col=state))+
  geom_line()+
  facet_wrap(~state, scales = 'free_y')

#Task 1 t=42.3 i=936
subsetI = subset(epidemic, epidemic$state=='I') #make subset
max(subsetI$n)                                  #find max
x = which(subsetI$n==max(subsetI$n))            #find index of max
subsetI$time[x]                                 #find time with index
#epidemic$time[epidemic$I==max(epidemic$I)]

#Task 2 3243 susceptible at the end
subsetS = subset(epidemic, epidemic$state=='S')
x = nrow(subsetS)
proportion = subsetS$n[x]/(state[1]+state[2])

#Task 3
x <- seq(0, 3*pi, by=0.1)
y <- numeric(length(x))
for(i in 1:length(x)){
  y[i] = abs(sin(x[i]))
}
plot(x, y, type='l')
points(x, y, pch=20, col='red', cex=0.5)

#Solutions
#Task 1
sir <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    N <- S+I+R
    dS <- - beta*I*S/N
    dI <- beta*I*S/N - sigma*I
    dR <- sigma*I
    return(list(c(dS,dI,dR)))
  })
}
init <- c(S=9999, I=1, R=0)
parameters <- c(beta = 0.5, sigma=0.3)
times <- seq(0, 100, by = 0.1)
epidemic <- data.frame(ode(y = init, times = times, func = sir, parms = parameters))
peakT <- epidemic$time[epidemic$I==max(epidemic$I)]
ggplot(epidemic, aes(x = times)) +
  geom_line(aes(y = S, col='S')) +
  geom_line(aes(y = I, col='I')) +
  geom_line(aes(y = R, col='R')) +
  geom_vline(xintercept = peakT)


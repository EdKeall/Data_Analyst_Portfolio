
## Assignment 3
#### Assignment 3 ####
getwd()
gannets<-read.table("gannets.txt",header=TRUE)

weightislandm = lm(hatchlingweight.g~islands, data = gannets)
par(mfrow=c(2,2))
plot(weightislandm) #diagnostic plots
summary(weightislandm)
anova(weightislandm)

#3
par(mfrow=c(1,1))
boxplot(hatchlingweight.g~islands,data=gannets, xlab = 'Island', ylab = 'Hatchling Weight at Birth (g)')
    
#part 2
    
#1
boxplot(hatchlingweight.g~islands,data=gannets, xlab = 'Island', ylab = 'Hatchling Weight at Birth (g)')
boxplot(hatchlingweight.g~adultweight.kg,data=gannets, xlab = 'Island', ylab = 'Hatchling Weight at Birth (g)')
    
gannetm<-lm(hatchlingweight.g~adultweight.kg*islands,data=gannets) #*interaction
summary(gannetm)
par(mfrow=c(2,2))
plot(gannetm)
    
anova(gannetm) # no interaction
gannetm2<-lm(hatchlingweight.g~adultweight.kg+islands,data=gannets)   #+addative
anova(gannetm,gannetm2)
anova(gannetm2)
gannetm3<-lm(hatchlingweight.g~islands,data=gannets)                   #Removing adultweight
anova(gannetm2,gannetm3)                                           #significantly difference between combined and without aadult weight
gannetm4<-lm(hatchlingweight.g~adultweight.kg,data=gannets)   #Removing island
anova(gannetm2,gannetm4)                                          #significantly different between combined and without islands
    
summary(gannetm2) # adjusted r2 higher 
summary(gannetm3)
summary(gannetm4)
anova(gannetm3)
    
predict(gannetm2, data.frame(adultweight.kg=3.2,islands='grassholm'))
    
    
    
    
#Part 3
    
par(mfrow=c(1,1))
boxplot(hatchlingweight.g~islands,data=gannets, xlab = 'Island', ylab = 'Hatchling Weight at Birth (g)')
boxplot(hatchlingweight.g~sex,data=gannets, xlab = 'Sex', ylab = 'Hatchling Weight at Birth (g)')
boxplot(hatchlingweight.g~sex*islands,data=gannets, xlab = 'Sex and Island'
        , ylab = 'Hatchling Weight at Birth (g)',cex.axis = 1)
    
gannetm5<-lm(islands~hatchlingweight.g*sex,data=gannets) #*interaction
gannetm5<-lm(hatchlingweight.g~sex*islands,data=gannets) #*interaction
summary(gannetm5) #Interaction between grassholm+sexM
par(mfrow=c(2,2))
plot(gannetm5)
anova(gannetm5) #significant interaxtiion sex:islands
  
gannetm6<-lm(hatchlingweight.g~sex+islands,data=gannets)   #+addative
summary(gannetm6) #r2 lower
anova(gannetm5,gannetm6) # significant difference in models
anova(gannetm6)
gannetm7<-lm(hatchlingweight.g~islands,data=gannets)#Removing sex
anova(gannetm6,gannetm7)                            #no significant difference between combined and without sex
gannetm8<-lm(hatchlingweight.g~sex,data=gannets)   #Removing island
anova(gannetm6,gannetm8)   #no sf diff
    
    
    
    
    
require(tidyverse)
library(latex2exp)
require(deSolve)
require(ggplot2)

# SIRsq

SIRsq <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    N1 <- S1 + I1 + R1 + D1
    N2 <- S2 + I2 + R2 + D2
    dS1 <- - S1 * (b11 * I1/N1 + b12 * I2/N2) + i1 * R1
    dI1 <- S1 * (b11 * I1/N1 + b12 * I2/N2) - (d1 + s1) * I1
    dR1 <- s1 * I1 - i1 * R1
    dD1 <- d1 * I1
    dS2 <- - S2 * (b21 * I1/N1 + b22 * I2/N2) + i2 * R2
    dI2 <- S2 * (b21 * I1/N1 + b22 * I2/N2) - (d2 + s2) * I2
    dR2 <- s2 * I2 - i2 * R2
    dD2 <- d2 * I2
    return(list(c(dS1, dI1, dR1, dD1,
                  dS2, dI2, dR2, dD2)))
  })
}

R0 <- 1.6
tY <- 7.6
tO <- 11.2

t <- 0
state <- c(S1=94.9, I1=1, R1=0, D1 = 0,
           S2 = 5.1, I2 = 0, R2 = 0, D2 = 0)
paramaters <- c(b11 = (R0/tY), b12 = (0.5*(R0/tY + R0/tO)), b21 = (0.5*(R0/tY + R0/tO)), b22 = R0/tO,
                s1 = 1/tY, s2 = 1/tO,
                d1 = 0.001, d2 = 0.05, # from Ed's Source
                i1 = 1/0.01, i2 = 1/0.01
)

SIRsq(t, state, paramaters)

times <- seq(0, 500, by=0.1)

epidemic <- data.frame(ode(y=state, times=times, func = SIRsq, parms = paramaters))

# ggplot(epidemic, aes(x=time)) +
# geom_line(aes(y=S1, col='S1')) +
# geom_line(aes(y=I1, col='I1')) +
# geom_line(aes(y=R1, col='R1')) +
# geom_line(aes(y=D1, col='D1'))

p <- ggplot(epidemic, aes(x=time)) +
  geom_line(aes(y=S2, col='S2'), size=1) +
  geom_line(aes(y=I2, col='I2'), size=1) +
  geom_line(aes(y=R2, col='R2'), size=1) +
  geom_line(aes(y=D2, col='D2'), size=1) +
  ggtitle(TeX("SIRD Model for Older Population, with $i_2 = 1/150$")) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab("Percentage of population")

p + labs(color = "States") +
  labs(caption = paste0("R_0 = ", R0), size = 3)

# epidemic <- epidemic %>%
# gather(state, n, S:R) %>%
# mutate(state = factor(state))
#
# ggplot(epidemic, aes(x = time, y = n, col=state)) +
# geom_line() +
# facet_wrap(~state,scales = 'free_y') +
# theme(legend.position = '') +
# labs(y = 'number of individuals')


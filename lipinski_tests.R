wilcox.test(lrrk2_stat_data$MW~lrrk2_stat_data$bio_class)

wilcox.test(lrrk2_stat_data$LogP~lrrk2_stat_data$bio_class)

wilcox.test(lrrk2_stat_data$hDon~lrrk2_stat_data$bio_class)

wilcox.test(lrrk2_stat_data$hAcc~lrrk2_stat_data$bio_class)


lrrk2_stat_data$bio_class = ifelse(lrrk2_stat_data$bio_class=="inactive",0,1)

m1 = glm(lrrk2_stat_data$bio_class~lrrk2_stat_data$MW+lrrk2_stat_data$LogP+
           lrrk2_stat_data$hDon+lrrk2_stat_data$hAcc, 
            family="binomial"("logit"))

summary(m1)
y_pred = m1$fitted.values
y_pred = ifelse(y_pred<0.5,0,1)

y_exp = lrrk2_stat_data$bio_class
c1 = table(y_pred,y_exp)

ACC1 = sum(diag(c1))/sum(c1)
ACC1

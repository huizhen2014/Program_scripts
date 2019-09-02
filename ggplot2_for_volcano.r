##get the table of edgeR $count
table_43vsLAC_4 <- lrt_0.04_43vsLAC_4$table
##distribute the color according to the logFC and PValue from table_43vsLAC_4
New_table_43vsLAC_4 <- within(table_43vsLAC_4,{
  color <- NA
  color[logFC < -1 & PValue < 0.01 ] <- "green"
  color[logFC > 1 & PValue < 0.01 ] <- "red"
  color[logFC > -1 & logFC < 1 ] <- "black"
  color[PValue > 0.01 ] <- "grey"
})
##添加名称列，可对应显示名称信息,对应将需要显示的名称添加到新列Name，其他为NA即可
##geom_text(aes(label=Name), size=4)
colours <- c(red="red",green="green",black="black",grey="grey")
ggplot(New_table_43vsLAC_4,aes(logFC,-log10(PValue)))+geom_point(aes(color=color))+
  scale_color_manual(values=colours)+labs(title="43 vs LAC_4",x="logFC",y="-log10(PValue")+
  geom_hline(yintercept = range(-log10(0.01),-log10(0.001)),color=c("blue","red"),linetype="dotted")+
  geom_vline(xintercept=range(-1,1),color="yellow",linetype="solid")
##save the pic
ggsave("43_vs_LAC_4_valcono.png",with=5,height=5)

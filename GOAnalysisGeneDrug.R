cat("\014")
library(gProfileR)
library(stringr)
communitiesGenes<-as.matrix(read.table(file="gene-drug-IDCommunitiesProfile.txt",header=FALSE))
for(i in 1:length(communitiesGenes)){
  listGenes<-unlist(strsplit(communitiesGenes[i],","))
  print(i)
  nameFile<-str_c("GProfilerGeneDrug",i,".txt")
  results<-gprofiler(listGenes, organism="hsapiens", ordered_query=F, significant=T,
            exclude_iea=F, region_query=F, max_p_value=1, max_set_size=0,
            correction_method="analytical", include_graph=T,png_fn=T)
  if(length(results$query.number)>=1){
    resultsFormatCytoscape<-matrix(c(results$term.id,results$term.name,results$p.value,results$p.value,results$query.number,results$intersection),length(results$query.number))
    colnames(resultsFormatCytoscape)<-c("GO.ID","Description","p.Val","FDR","Phenotype","Genes")
    write.table(resultsFormatCytoscape,nameFile,sep="\t",quote=FALSE,row.names=FALSE)
  }
}

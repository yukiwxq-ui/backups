# install.packages(c("camtrapR", "taxize", "overlap"))
library(camtrapR)

imageRename(
  inDir = "/home/user/Documents/EEFS/subset_04",
  outDir = "/home/user/Documents/EEFS/output",
  keepCameraSubfolders = FALSE,
  hasCameraFolders = FALSE,
  copyImages = TRUE
)

checkSpeciesNames(speciesNames = "Capreolus capreolus", searchtype = "scientific")
checkSpeciesNames(speciesNames = "Muntiacus reevesi", searchtype = "scientific")
checkSpeciesNames(speciesNames = "Columba palumbus", searchtype = "scientific")
checkSpeciesNames(speciesNames = "Sciurus carolinensis", searchtype = "scientific")
checkSpeciesNames(speciesNames = "Homo sapiens", searchtype = "scientific")

sp_table = recordTable(
  inDir = "/home/user/Documents/EEFS/output",
  IDfrom = "directory",
  minDeltaTime = 30,
  deltaTimeComparedTo = "lastIndependentRecord"
)

write.csv(
  sp_table,
  "/home/user/Documents/EEFS/output/sp_table_camera_05_16_2025.csv",
  row.names = FALSE
)


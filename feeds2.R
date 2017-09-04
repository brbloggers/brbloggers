fls <- dir("R/blogs", full.names = TRUE)
for(i in fls){
  source(i)
}

feeds <- list(
  "analise-real"               = `analise-real`,
  "cantinho-do-r"              = `cantinho-do-r`,
  "curso-r"                    = `curso-r`,
  "d-van"                      = `d-van`,
  "dfalbel"                    = `dfalbel`,
  "IBPAD"                      = `ibpad`,
  "italocegatta"               = `italocegatta`,
  "jose-guilherme-lopes"       = `jose-guilherme_lopes`,
  "lurodrigo"                  = `lurodrigo`,
  "mind-and-iron"              = `mind-and-iron`,
  "NMEC"                       = `NMEC`,
  "paixao-por-dados"           = `paixao-por-dados`,
  "r-python-e-redes"           = `r-python-e-redes`
)












IMPORT OS
IMPORT UTIL

SCHEMA ds

CONSTANT cs_LanguageType STRING = "0"

FUNCTION adzp050zip_CompressToZIP(p_FileName,p_ModuleName)
DEFINE
  p_FileName    STRING,
  p_ModuleName STRING
DEFINE
  ls_ZIPName         STRING,
  ls_ZIPPath         STRING,
  ls_ZIPString       STRING,
  ls_FileName        STRING,
  ls_ModuleEnv       STRING,
  ls_ModuleName      STRING, 
  ls_DIR_PID         STRING,
  ls_SRC_Path        STRING,
  ls_DST_Path        STRING,
  li_CHDIR           INTEGER,
  li_MKDIR           INTEGER

  LET ls_FileName   = p_FileName
  LET ls_ModuleEnv  = p_ModuleName.toUpperCase()
  LET ls_ModuleName = p_ModuleName.toLowerCase()

  LET ls_ZIPPath = FGL_GETENV("TEMPDIR")
  LET ls_ZIPName = ls_FileName,".tzp"
  LET ls_DIR_PID = ls_ZIPPath,"/",ls_FileName

  CALL os.Path.mkdir(ls_DIR_PID) RETURNING li_MKDIR
  RUN "rm "||ls_DIR_PID||"/*"

  CALL adzp050zip_GetDEVList("",ls_FileName,ls_ModuleEnv,ls_DIR_PID)

  LET ls_SRC_Path  = FGL_GETENV(ls_ModuleEnv)
  LET ls_DST_Path  = ls_DIR_PID

  LET ls_SRC_Path = FGL_GETENV("ERP")
  RUN "cp "||ls_SRC_Path||"/cfg/4ad/tiptop_0.4ad "||ls_DST_Path

  CALL os.Path.chdir(ls_DIR_PID) RETURNING li_CHDIR
  LET ls_ZIPString = "zip "||ls_ZIPName||" *"
  RUN ls_ZIPString  
  
END FUNCTION

FUNCTION adzp050zip_CompressToDesignerZIP(p_FileName,p_ModuleName)
DEFINE
  p_FileName    STRING,
  p_ModuleName STRING
DEFINE
  ls_ZIPName         STRING,
  ls_ZIPPath         STRING,
  ls_ZIPString       STRING,
  ls_FileName        STRING,
  ls_ModuleEnv       STRING,
  ls_ModuleName      STRING, 
  ls_DIR_PID         STRING,
  ls_SRC_Path        STRING,
  ls_DST_Path        STRING,
  ls_RandomPath      STRING,
  ls_ModulePath      STRING,
  ls_MTA_Path        STRING,
  ls_4tb_Path        STRING,
  ls_RETURN          STRING,
  ls_MuduleZIPList   STRING,
  li_CHDIR           INTEGER,
  li_MKDIR           INTEGER

  LET ls_FileName   = p_FileName
  LET ls_ModuleEnv  = p_ModuleName.toUpperCase()
  LET ls_ModuleName = p_ModuleName.toLowerCase()

  LET ls_RandomPath = ""
  LET ls_ModulePath = ""
  LET ls_MTA_Path   = ""
  LET ls_4tb_Path   = ""

  LET ls_ZIPPath = FGL_GETENV("TEMPDIR")
  LET ls_ZIPName = "TT.zip"
  
  CALL adzp050zip_GenRandomName() RETURNING ls_RandomPath

  LET ls_DIR_PID = ls_ZIPPath,"/",ls_RandomPath
  CALL os.Path.mkdir(ls_DIR_PID) RETURNING li_MKDIR
  RUN "rm "||ls_DIR_PID||"/*"

  CALL adzp050zip_MakeModuleDirectory(ls_DIR_PID) RETURNING ls_MuduleZIPList
  
  LET ls_MTA_Path = ls_DIR_PID||"/mta"  
  CALL os.Path.mkdir(ls_MTA_Path) RETURNING li_MKDIR

  LET ls_4tb_Path = ls_DIR_PID||"/4tb"
  CALL os.Path.mkdir(ls_4tb_Path) RETURNING li_MKDIR

  LET ls_DST_Path  = ls_DIR_PID

  LET ls_SRC_Path = FGL_GETENV("COM")
  RUN "cp "||ls_SRC_Path||"/mta/checks.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/datatypes.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/items.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/libraries.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/messages.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/prog_rel.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/subroutines.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/tables.xml "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/mta/zooms.xml "||ls_MTA_Path
   
  LET ls_SRC_Path = FGL_GETENV("GSTDIR")
  RUN "cp "||ls_SRC_Path||"/gst/conf/mod-fd.spec "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/gst/conf/core-br.spec "||ls_MTA_Path
  RUN "cp "||ls_SRC_Path||"/gst/conf/lexerproperties/4gl.xml "||ls_MTA_Path

  LET ls_SRC_Path = FGL_GETENV("ERP")
  RUN "cp "||ls_SRC_Path||"/cfg/4tb/toolbar*.4tb "||ls_4tb_Path
  ##RUN "cp "||ls_SRC_Path||"/cfg/4ad/0/"||ls_ModuleName||"/"||ls_FileName||".4ad "||ls_DST_Path

  CALL os.Path.chdir(ls_DIR_PID) RETURNING li_CHDIR
  #壓縮 4tb 及 mta 資料
  LET ls_ZIPString = "zip "||ls_ZIPName||" 4tb/* mta/*"
  RUN ls_ZIPString  
  #壓縮各模組 tbl 資料
  LET ls_ZIPString = "zip "||ls_ZIPName||" "||ls_MuduleZIPList
  RUN ls_ZIPString    
  
  LET ls_RETURN = ls_DIR_PID||"/"

  RETURN ls_RETURN
  
END FUNCTION

FUNCTION adzp050zip_GetDEVList(p_Type,p_FileName,p_ModuleName,p_Path)
DEFINE 
  p_Type       STRING,
  p_FileName   STRING,
  p_ModuleName STRING,
  p_Path       STRING
DEFINE
  ls_Type        STRING,
  ls_FileName    STRING,
  ls_ModuleName  STRING,
  ls_Path        STRING,
  ls_SQL         STRING,
  ls_TypeList    STRING,
  ls_DEVList     STRING,
  ls_DEVFiles    STRING, 
  ls_FullPath    STRING,
  ls_ListPath    STRING,
  ls_ModulePath  STRING,
  ls_DEVFileName STRING,
  ls_SRC_FILE    STRING,
  ls_DST_FILE    STRING,
  li_CopyResult  INTEGER,
  lsb_StrBuf     base.StringBuffer,
  lchannel_write base.Channel,
  lo_ZIPDocuments RECORD
                    DOCUMENTS   VARCHAR(90),
                    LANG_TYPE   VARCHAR(90),
                    DESIGN_ROOT VARCHAR(90)
                  END RECORD
DEFINE
  ls_Return STRING  

  LET ls_Type        = p_Type
  LET ls_FileName    = p_FileName
  LET ls_ModuleName  = p_ModuleName.toUpperCase()
  LET ls_Path        = p_Path

  LET ls_ModulePath  = FGL_GETENV(ls_ModuleName)
  LET ls_ListPath    = ls_Path
  LET ls_DEVFileName = ls_ListPath,"/","_files"

  LET lsb_StrBuf = base.StringBuffer.create()
  CALL lsb_StrBuf.clear()

  IF ls_Type IS NULL THEN
    LET ls_TypeList = "'ADZP050_DEV_SPEC_LIST','ADZP050_DEV_PROG_LIST'"
  ELSE
    LET ls_TypeList = "'",ls_Type,"'" 
  END IF
  
  LET ls_SQL = "SELECT EJ.DZEJ003 DOCUMENTS,           ",
               "       EJ.DZEJ005 LangType,            ",
               "       EJ.DZEJ006 DesignRoot           ",
               "  FROM DZEJ_T EJ                       ",
               " WHERE EJ.DZEJ001 IN (",ls_TypeList,") ", 
               " ORDER BY EJ.DZEJ001,EJ.DZEJ002        " 
 
  PREPARE lpre_DEVList FROM ls_SQL
  DECLARE lcur_DEVList SCROLL CURSOR FOR lpre_DEVList

  LET ls_DEVList = ""
  OPEN lcur_DEVList
  FOREACH lcur_DEVList INTO lo_ZIPDocuments.*  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    IF lo_ZIPDocuments.DESIGN_ROOT IS NOT NULL THEN
      LET ls_FullPath = lo_ZIPDocuments.DESIGN_ROOT,"/",lo_ZIPDocuments.DOCUMENTS
    ELSE
      LET ls_FullPath = lo_ZIPDocuments.DOCUMENTS
    END IF

    IF lo_ZIPDocuments.LANG_TYPE IS NOT NULL THEN
      LET ls_FullPath = ls_FullPath,"/",lo_ZIPDocuments.LANG_TYPE
    ELSE
      LET ls_FullPath = ls_FullPath
    END IF

    LET ls_SRC_FILE = ls_ModulePath,"/",ls_FullPath,"/",ls_FileName,".",lo_ZIPDocuments.DOCUMENTS
    LET ls_DST_FILE = ls_Path,"/",ls_FileName,".",lo_ZIPDocuments.DOCUMENTS

    CALL os.Path.copy(ls_SRC_FILE,ls_DST_FILE) RETURNING li_CopyResult
    
    #LET ls_DEVFiles = ls_FileName,".",lo_ZIPDocuments.DOCUMENTS,"\n"
    #CALL lsb_StrBuf.append(ls_DEVFiles)
    
  END FOREACH
  CLOSE lcur_DEVList

  FREE lcur_DEVList
  FREE lpre_DEVList

  {
  #開檔寫入及關檔
  CALL lsb_StrBuf.append("mod-fd.spec"||"\n")
  CALL lsb_StrBuf.append("core-br.spec"||"\n")
  LET lchannel_write = base.Channel.create()
  CALL lchannel_write.setDelimiter("")
  CALL lchannel_write.openFile(ls_DEVFileName, "w" )
  CALL lchannel_write.write(lsb_StrBuf.toString())
  CALL lchannel_write.close()
  }
  
  LET ls_Return = ls_DEVList

END FUNCTION

FUNCTION adzp050zip_MakeModuleDirectory(p_DIR_PID)
DEFINE 
  p_DIR_PID STRING
DEFINE
  ls_DIR_PID     STRING,
  ls_SQL         STRING,
  ls_ModuleList  STRING,
  ls_ModulePath  STRING,
  ls_ModuleName  VARCHAR(30),
  ls_ModuleEnv   STRING,
  ls_SRC_Path    STRING,
  li_MKDIR       INTEGER
DEFINE
  ls_Return STRING  

  LET ls_ModuleList = ""
  LET ls_DIR_PID = p_DIR_PID
  
  LET ls_SQL = "SELECT DZEA003 MODULE_NAME ", 
               "  FROM DZEA_T              ",
               " GROUP BY DZEA003          ",
               " ORDER BY DZEA003          " 
 
  PREPARE lpre_ModuleList FROM ls_SQL
  DECLARE lcur_ModuleList CURSOR FOR lpre_ModuleList
  
  OPEN lcur_ModuleList
  FOREACH lcur_ModuleList INTO ls_ModuleName  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_ModuleEnv = ls_ModuleName

    #建立模組目錄
    LET ls_ModulePath = ls_DIR_PID||"/"||ls_ModuleEnv.toLowerCase()
    CALL os.Path.mkdir(ls_ModulePath) RETURNING li_MKDIR
    LET ls_ModulePath = ls_ModulePath||"/tbl"
    CALL os.Path.mkdir(ls_ModulePath) RETURNING li_MKDIR

    #複製模組相關Table資料到 Temp Dir
    LET ls_SRC_Path = FGL_GETENV(ls_ModuleEnv.toUpperCase())
    RUN "cp "||ls_SRC_Path||"/dzx/tbl/*.tbl "||ls_ModulePath
    
    LET ls_ModuleList = ls_ModuleList,ls_ModuleEnv.toLowerCase(),"/tbl/* "
    
  END FOREACH
  CLOSE lcur_ModuleList

  FREE lcur_ModuleList
  FREE lpre_ModuleList

  LET ls_Return = ls_ModuleList

  RETURN ls_Return

END FUNCTION

FUNCTION adzp050zip_DownloadZIP(p_FileName,p_ModuleName,p_SourcePath,p_DestinationPath)
DEFINE
  p_FileName        STRING,
  p_ModuleName      STRING,
  p_SourcePath      STRING,
  p_DestinationPath STRING
DEFINE
  ls_FileName        STRING,
  ls_ModuleName      STRING,
  ls_SourcePath      STRING,
  ls_DestinationPath STRING,
  ls_SourceFile      STRING,
  ls_DestinationFile STRING,
  ls_CompressExtName STRING

  LET ls_FileName        = p_FileName
  LET ls_ModuleName      = p_ModuleName
  LET ls_SourcePath      = p_SourcePath        
  LET ls_DestinationPath = p_DestinationPath

  LET ls_CompressExtName = "tzp"  

  LET ls_SourceFile      = ls_SourcePath,ls_FileName,".",ls_CompressExtName
  LET ls_DestinationFile = ls_DestinationPath,ls_FileName,".",ls_CompressExtName

  TRY
    CALL FGL_PUTFILE(ls_SourceFile,ls_DestinationFile)
    DISPLAY "Download TZP file "||ls_FileName||"."||ls_CompressExtName||" success ! "
    #CALL FGL_WINMESSAGE("Success", "Download TZP file "||ls_FileName||" success ! ", "information")
  CATCH
    DISPLAY "Download TZP file "||ls_FileName||"."||ls_CompressExtName||" File Error ! "
    #CALL FGL_WINMESSAGE("ERROR", "Download TZP"||ls_FileName||" File Error ! ", "stop")
  END TRY  

END FUNCTION

FUNCTION adzp050zip_DownloadDesignerZIP(p_FileName,p_ModuleName,p_SourcePath,p_DestinationPath)
DEFINE
  p_FileName        STRING,
  p_ModuleName      STRING,
  p_SourcePath      STRING,
  p_DestinationPath STRING
DEFINE
  ls_FileName        STRING,
  ls_ModuleName      STRING,
  ls_SourcePath      STRING,
  ls_DestinationPath STRING,
  ls_SourceFile      STRING,
  ls_DestinationFile STRING,
  ls_CompressExtName STRING

  LET ls_FileName        = p_FileName
  LET ls_ModuleName      = p_ModuleName
  LET ls_SourcePath      = p_SourcePath        
  LET ls_DestinationPath = p_DestinationPath

  LET ls_CompressExtName = "zip"  

  LET ls_SourceFile      = ls_SourcePath,ls_FileName,".",ls_CompressExtName
  LET ls_DestinationFile = ls_DestinationPath,ls_FileName,".",ls_CompressExtName

  TRY
    CALL FGL_PUTFILE(ls_SourceFile,ls_DestinationFile)
    DISPLAY "Download Designer ZIP file "||ls_FileName||"."||ls_CompressExtName||" success ! "
    #CALL FGL_WINMESSAGE("Success", "Download TZP file "||ls_FileName||" success ! ", "information")
  CATCH
    DISPLAY "Download Designer ZIP file "||ls_FileName||"."||ls_CompressExtName||" File Error ! "
    #CALL FGL_WINMESSAGE("ERROR", "Download TZP"||ls_FileName||" File Error ! ", "stop")
  END TRY  

END FUNCTION

#以亂數產出副檔名
FUNCTION adzp050zip_GenRandomName()
DEFINE
  lr_RandomName RECORD
    Segment1 STRING,
    Segment2 STRING,
    Segment3 STRING,
    Segment4 STRING
  END RECORD
DEFINE 
  li_RandomValue  INTEGER,
  li_MaxRandomNum INTEGER,
  ls_FinalName    STRING,
  ls_UsingFormat  STRING
DEFINE  
  ls_return       STRING

  LET li_MaxRandomNum = 9999
  LET ls_UsingFormat  = "&&&&"
  
  CALL util.math.rand(li_MaxRandomNum) RETURNING li_RandomValue
  LET lr_RandomName.Segment1 = li_RandomValue USING ls_UsingFormat
  CALL util.math.rand(li_MaxRandomNum) RETURNING li_RandomValue
  LET lr_RandomName.Segment2 = li_RandomValue USING ls_UsingFormat
  CALL util.math.rand(li_MaxRandomNum) RETURNING li_RandomValue
  LET lr_RandomName.Segment3 = li_RandomValue USING ls_UsingFormat
  CALL util.math.rand(li_MaxRandomNum) RETURNING li_RandomValue
  LET lr_RandomName.Segment4 = li_RandomValue USING ls_UsingFormat
  
  LET ls_FinalName = lr_RandomName.Segment1,".",
                     lr_RandomName.Segment2,".",
                     lr_RandomName.Segment3,".",
                     lr_RandomName.Segment4

  LET ls_return = ls_FinalName
  
  RETURN ls_return                     
  
END FUNCTION




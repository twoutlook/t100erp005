IMPORT os
DATABASE ds

DEFINE lc_dzld DYNAMIC ARRAY OF RECORD LIKE dzld_t.*
DEFINE lc_dzlm DYNAMIC ARRAY OF RECORD LIKE dzlm_t.*
DEFINE lc_dzlt DYNAMIC ARRAY OF RECORD LIKE dzlt_t.*
DEFINE lc_dzldid  LIKE dzld_t.dzld001
DEFINE lc_dzlmid  LIKE dzlm_t.dzlm001
DEFINE lc_dzltid  LIKE dzlt_t.dzlt001
DEFINE li_dzldmax INT
DEFINE li_dzlmmax INT
DEFINE li_dzltmax INT
DEFINE lc_dzld011 LIKE dzld_t.dzld011
DEFINE lc_dzld014 LIKE dzld_t.dzld014

MAIN
  DEFINE ls_erp  STRING
  DEFINE ls_arg  STRING

  IF arg_val(1) is null then display 'parameter null' exit program end if

  CALL lc_dzld.clear()
  LET ls_arg = ARG_VAL(1)
  LET ls_arg = DOWNSHIFT(ls_arg.trim())

  CASE 
     WHEN ls_arg = "core"
        CALL get_exists_data_dzld("lib")
        LET ls_erp = "/u1/t10prd/com"
        CALL showDir(os.Path.join(os.Path.join(ls_erp,"lib"),"4gl"),FALSE)
        LET ls_erp = "/u1/t10prd/erp"
        CALL showDir(os.Path.join(os.Path.join(ls_erp,"azz"),"4gl"),TRUE)

     WHEN ls_arg.getLength() = 3
        CALL get_exists_data_dzld(ls_arg)
        IF ls_arg = "lib" THEN
           LET ls_erp = "/u1/t10prd/com"
        ELSE
           LET ls_erp = "/u1/t10prd/erp"
        END IF
        display os.Path.join(os.Path.join(ls_erp,ls_arg),"4gl")
        CALL showDir(os.Path.join(os.Path.join(ls_erp,ls_arg),"4gl"),FALSE)
     OTHERWISE
display ls_arg.getLength()
  END CASE
END MAIN

FUNCTION get_number(lc_module)
   DEFINE lc_module VARCHAR(3)
   LET lc_dzld011 = "160314-00010"
display lc_module
   CASE
      WHEN lc_module = "lib" LET lc_dzld014 = "1"
      WHEN lc_module = "azz" LET lc_dzld014 = "2"
      WHEN lc_module = "agl" LET lc_dzld014 = "3"
      WHEN lc_module = "afa" LET lc_dzld014 = "4"
      WHEN lc_module = "anm" LET lc_dzld014 = "5"
      WHEN lc_module = "afm" LET lc_dzld014 = "6"
      WHEN lc_module = "adz" LET lc_dzld014 = "9"
      OTHERWISE
         RETURN FALSE
   END CASE
   RETURN TRUE
END FUNCTION

# dzlm放 表格
# dzlt放 工具(adz,lib包才會有,先把4gl寫入)
FUNCTION get_exists_data_dzld(lc_module)
   DEFINE ls_sql  STRING
   DEFINE li_cnt  INT
   DEFINE lc_module VARCHAR(3)

display lc_module

   LET ls_sql = "SELECT * FROM dzld_t WHERE dzld011 = ? AND dzld014 = ? "
   PREPARE dzld_pre FROM ls_sql
   DECLARE dzld_cur CURSOR FOR dzld_pre

   LET ls_sql = "SELECT * FROM dzlt_t WHERE dzlt011 = ? AND dzlt014 = ? "
   PREPARE dzlt_pre FROM ls_sql
   DECLARE dzlt_cur CURSOR FOR dzlt_pre

   LET ls_sql = "SELECT * FROM dzlm_t WHERE dzlm012 = ? AND dzlm015 = ? AND dzlm001 = 'T' "
   PREPARE dzlm_pre FROM ls_sql
   DECLARE dzlm_cur CURSOR FOR dzlm_pre

   IF NOT get_number(lc_module) THEN RETURN END IF

   LET li_cnt = 1
   #取出現存的
   FOREACH dzld_cur USING lc_dzld011,lc_dzld014 INTO lc_dzld[li_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      IF lc_dzld[li_cnt].dzld002 > li_dzldmax THEN
         LET li_dzldmax = lc_dzld[li_cnt].dzld002
         LET lc_dzldid = lc_dzld[li_cnt].dzld001
      END IF
      LET li_cnt = li_cnt+1
   END FOREACH
   CALL lc_dzld.deleteElement(li_cnt)

   LET li_cnt = 1
   FOREACH dzlt_cur USING lc_dzld011,lc_dzld014 INTO lc_dzlt[li_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      IF lc_dzlt[li_cnt].dzlt002 > li_dzltmax THEN
         LET li_dzltmax = lc_dzlt[li_cnt].dzlt002
         LET lc_dzltid = lc_dzlt[li_cnt].dzlt001
      END IF
      LET li_cnt = li_cnt+1
   END FOREACH
   CALL lc_dzlt.deleteElement(li_cnt)

   LET li_cnt = 1
   FOREACH dzlm_cur USING lc_dzld011,lc_dzld014 INTO lc_dzlm[li_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      IF lc_dzlm[li_cnt].dzlm002 > li_dzlmmax THEN
         LET li_dzlmmax = lc_dzlm[li_cnt].dzlm002
         LET lc_dzlmid = lc_dzlm[li_cnt].dzlm001
      END IF
      LET li_cnt = li_cnt+1
   END FOREACH
   CALL lc_dzlm.deleteElement(li_cnt)

   FREE dzld_cur
   FREE dzlm_cur
   FREE dzlt_cur

END FUNCTION

FUNCTION showDir(path,li_tableonly)
  DEFINE path STRING
  DEFINE child STRING
  DEFINE fullname STRING
  DEFINE h INTEGER
  DEFINE li_type INT
  DEFINE li_tableonly INT

  IF NOT os.Path.exists(path) THEN
     display 'error:',path
     RETURN
  END IF

  CALL os.Path.dirsort("name", 1)
  LET h = os.Path.diropen(path)
  WHILE h > 0
     LET fullname = os.Path.dirnext(h)
     IF fullname IS NULL THEN EXIT WHILE END IF
     IF fullname == "." OR fullname == ".." THEN CONTINUE WHILE END IF
     IF os.Path.extension(fullname) = "4gl" THEN
        LET child = os.Path.rootname(fullname)
        IF child.substring(1,1) = "a" AND NOT child.getIndexOf("_",3) THEN
           LET li_type = 1  #main program
        ELSE
           LET li_type = 2  #child-program
        END IF
        IF NOT li_tableonly THEN
           CALL chk_dzld(child,li_type)
        END IF

        #檢查使用表格
        CALL chk_dzlm(os.Path.join(path,fullname))

     END IF
  END WHILE
  CALL os.Path.dirclose(h)
END FUNCTION

# dzld放 900,901,910,design_data
FUNCTION chk_dzld(lc_file,li_type)
   DEFINE li_cnt  INT
   DEFINE lc_file VARCHAR(20)
   DEFINE li_type INT
   DEFINE lc_exist VARCHAR(5)

   LET lc_exist = "NNNNN"
   FOR li_cnt = 1 TO lc_dzld.getLength()
      IF lc_dzld[li_cnt].dzld006 = lc_file THEN
         #檢查一: type=1 主程式:azzi900
         #        type=2 子程式:azzi901
         IF li_type = 1 AND lc_dzld[li_cnt].dzld005 = "azzi900" THEN
            LET lc_exist = "Y",lc_exist[2,5]
         END IF
         IF li_type = 2 AND lc_dzld[li_cnt].dzld005 = "azzi901" THEN
            LET lc_exist = "Y",lc_exist[2,5]
         END IF
         #檢查二: azzi910
         IF li_type = 1 AND lc_dzld[li_cnt].dzld005 = "azzi910" THEN
            LET lc_exist = lc_exist[1,1],"Y",lc_exist[3,5]
         END IF
         #檢查三: design_data
         IF lc_dzld[li_cnt].dzld005 = "design_data" THEN
            LET lc_exist = lc_exist[1,2],"Y",lc_exist[4,5]
         END IF
      END IF
   END FOR

   #寫入
   IF lc_exist[1,1] = "N" THEN
      LET li_dzldmax = li_dzldmax + 1
      IF li_type = 1 THEN
         DISPLAY "補上:SN:",li_dzldmax,'--ID-',lc_dzldid,'--FILE-',lc_file,'-TYPE-',"azzi900"
      ELSE
         DISPLAY "補上:SN:",li_dzldmax,'--ID-',lc_dzldid,'--FILE-',lc_file,'-TYPE-',"azzi901"
      END IF
   END IF

   IF li_type = 1 AND lc_exist[2,2] = "N" THEN
      LET li_dzldmax = li_dzldmax + 1
      DISPLAY "補上:SN:",li_dzldmax,'--ID-',lc_dzldid,'--FILE-',lc_file,'-TYPE-',"azzi910"
   END IF

   IF lc_exist[3,3] = "N" THEN
      LET li_dzldmax = li_dzldmax + 1
      DISPLAY "補上:SN:",li_dzldmax,'--ID-',lc_dzldid,'--FILE-',lc_file,'-TYPE-',"design_data"
   END IF

END FUNCTION


# dzlm放 表格
# dzlt放 工具(adz,lib包才會有,先把4gl寫入)

PRIVATE FUNCTION chk_dzlm(filepath) 
   DEFINE filepath STRING
   DEFINE lchannel_read        base.Channel
   DEFINE ls_readline          STRING
   DEFINE ls_tabid  STRING
   DEFINE li_cnt INT

   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")
   CALL lchannel_read.openFile(filepath,"r")
   
   WHILE TRUE
      LET ls_readline = lchannel_read.readLine()
     
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF
      IF ls_readline.getIndexOf("#",1) THEN
         LET ls_readline = ls_readline.subString(1,ls_readline.getIndexOf("#",1)-1)
      END IF
      IF ls_readline.getIndexOf("--",1) THEN
         LET ls_readline = ls_readline.subString(1,ls_readline.getIndexOf("--",1)-1)
      END IF
      LET ls_readline = ls_readline.trim()      
      LET ls_readline = ls_readline.toLowerCase()

      IF ls_readline.getIndexOf("_t",1) THEN
         LET ls_tabid = ls_readline.subString(1,ls_readline.getIndexOf("_t",1)+1)
         IF ls_tabid.getIndexOf("like",1) OR ls_tabid.getIndexOf("from",1) THEN
            IF ls_tabid.getIndexOf("like",1) THEN
               LET ls_tabid = ls_tabid.subString(ls_tabid.getIndexOf("like",1)+4,ls_tabid.getLength()) 
            ELSE
               LET ls_tabid = ls_tabid.subString(ls_tabid.getIndexOf("from",1)+4,ls_tabid.getLength()) 
            END IF
         ELSE
            CONTINUE WHILE
         END IF 
      ELSE
         CONTINUE WHILE
      END IF 
      LET ls_tabid = ls_tabid.trim()
      IF ls_tabid.getIndexOf(".",1) THEN LET ls_tabid = ls_tabid.subString(ls_tabid.getIndexOf(".",1)+1,ls_tabid.getLength()) END IF
      IF ls_tabid.getIndexOf("formonly",1) THEN LET ls_tabid = ls_tabid.subString(ls_tabid.getIndexOf("formonly",1)+8,ls_tabid.getLength()) END IF
      IF NOT ls_tabid.subString(1,1) MATCHES '[a-z]' OR ls_tabid = "all_t" OR ls_tabid = "user_t" OR ls_tabid = "lc_t" OR
             ls_tabid = "dba_t" THEN
         CONTINUE WHILE
      END IF
      IF ls_tabid.getLength() < 5 OR ls_tabid.getLength() > 7 THEN
         CONTINUE WHILE
      END IF

      #檢查表格
      FOR li_cnt = 1 TO lc_dzlm.getLength()
         IF lc_dzlm[li_cnt].dzlm002 = ls_tabid THEN
            CONTINUE WHILE
         END IF
      END FOR

      #不存在的時候, 先顯示,在寫回去陣列
      display ls_tabid,' ---->',filepath

      LET li_cnt = lc_dzlm.getLength() + 1
      LET lc_dzlm[li_cnt].dzlm002 = ls_tabid.trim()

  END WHILE 
  CALL lchannel_read.close()
      
END FUNCTION

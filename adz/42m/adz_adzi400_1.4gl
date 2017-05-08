#+ Version....: T6-ERP-1.00.00 Build-000005
#+
#+ Filename...: adzi400_1
#+ Buildtype..: 應用t01樣板自動產生
#+ Memo.......:

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

#生成chm文件-准备
FUNCTION adzi400_1()
  DEFINE l_sql        STRING
  DEFINE l_dzda       RECORD LIKE dzda_t.*   #主档
  DEFINE l_dzdb       RECORD LIKE dzdb_t.*   #参数档
  DEFINE l_dzdc       RECORD LIKE dzdc_t.*   #关键字档
  DEFINE l_dzdd       RECORD LIKE dzdd_t.*   #前置元件档
  DEFINE l_dzdh       RECORD LIKE dzdh_t.*   #维度档
  DEFINE l_dzdi       RECORD LIKE dzdi_t.*   #多语言档
  DEFINE ls_chmdir    STRING
  DEFINE ls_str       STRING
  DEFINE ls_dzda001   STRING
  DEFINE l_dzdi005    LIKE dzdi_t.dzdi005
  DEFINE lc_channel   base.Channel

   LET ls_chmdir = FGL_GETENV("HOME")
   LET ls_chmdir = os.Path.join(ls_chmdir.trim(),"chm")

   IF NOT os.Path.exists(ls_chmdir.trim()) THEN
      IF os.Path.mkdir(ls_chmdir.trim()) THEN
      END IF

      IF os.Path.separator() = "/" THEN
         IF os.Path.chrwx(ls_chmdir.trim(),511) THEN #chmod 777 => 7*8^2 +7*8^1 +7*8^
         END IF
      END IF
   END IF

  DECLARE chm_cs1 CURSOR FOR 
   SELECT * FROM dzda_t
  
  LET l_sql = "SELECT dzdi005 FROM dzdi_t WHERE dzdi001 = ? AND dzdi002 = ? AND dzdi003 = ? AND dzdi004 = ?"
  PREPARE chm_p1 FROM l_sql
  DECLARE chm_dzdi_cs CURSOR FOR chm_p1

  LET l_sql = "SELECT * FROM dzdb_t WHERE dzdb001 = ? AND dzdb002 = ? ORDER BY dzdi003 "
  PREPARE chm_p2 FROM l_sql
  DECLARE chm_dzdb_cs CURSOR FOR chm_p2

  FOREACH chm_cs1 INTO l_dzda.*

     LET ls_dzda001 = l_dzda.dzda001
     LET lc_channel = base.Channel.create()
     LET ls_str = os.Path.join(ls_chmdir,ls_dzda001.trim()||".txt")
  
     #IF NOT os.Path.exists(ls_str.trim()) THEN
     #   LET li_result = TRUE
     #   CALL lc_channel.openFile(ls_str,"w")
     #ELSE
     #   CALL lc_channel.openFile(ls_str,"a")
     #END IF
     CALL lc_channel.openFile(ls_str,"w")
     CALL lc_channel.setDelimiter("")

     LET ls_str = "应用元件代号:",l_dzda.dzda001 CLIPPED
     CALL lc_channel.write(ls_str)
     
     EXECUTE chm_dzdi_cs INTO l_dzdi005 USING 'dzda_t','dzda001',l_dzda.dzda001,'zh_CN'   
     LET ls_str = "简中  说明:",l_dzdi005
     CALL lc_channel.write(ls_str)
   
     EXECUTE chm_dzdi_cs INTO l_dzdi005 USING 'dzda_t','dzda001',l_dzda.dzda001,'zh_TW'   
     LET ls_str = "繁中  说明:",l_dzdi005
     CALL lc_channel.write(ls_str)

     CALL lc_channel.close()

  END FOREACH

END FUNCTION






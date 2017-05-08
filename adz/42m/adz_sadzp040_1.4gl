#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/01/24

#
#+ 程式代碼......: sadzp040_1
#+ 設計人員......: madey
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp040_1.4gl
# Description    : 建立元件規格檔(csd)
# Memo           :
# Modify         : 2014/01/07 by madey : 參考sadzp030_gen.4gl建立程式
#                : 2014/05/13 by madey : 1.因應二次開發增加欄位:規格標示(PK)、客戶代號
#                                        2.root增加class、type、identity屬性
#                                        3.檢查權限由cl_chk_competence_check_alm改為呼叫端自行檢查
#                                        4.sadzp040_1_gen_csd()增加參數p_identity
#                                        5.停用dzdn_t簡化關係:由dzdp->dzdn->dzdb三層關係改為dzdp->dzdb兩層關係
#                                        6.csd檔booking屬性直接給Y;csd.read檔booking給N
#                                        7.產生規格樹改由呼叫段call sadzp060_2_after_check_out_for_download
#                                        7.產生規格樹改由呼叫段call sadzp060_2_after_check_out_for_download

#測試請用r.r adzp041 s_num SUB 3
#        r.d adzp041 xxx s_num SUB 3  (多一個空參數)
 
import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gs_env      LIKE dzaa_t.dzaa006 #辨識目前所在的環境:s.標準,c.客製
DEFINE gd_date     DATETIME YEAR TO SECOND
DEFINE gs_revision LIKE dzaf_t.dzaf003 #規格版次
DEFINE gs_erpver   STRING,#ERP大版版號
       gs_zone     STRING #執行區域
DEFINE gs_sys      STRING,
       gs_prog     LIKE dzaf_t.dzaf001
DEFINE gs_dzdi003  LIKE dzdi_t.dzdi003   #元件多語言檔
DEFINE gs_cust     LIKE dzaf_t.dzaf009   #客戶代號
DEFINE gs_type     LIKE dzaf_t.dzaf005   #類型
DEFINE gs_identity LIKE dzaf_t.dzaf010   #規格標示(s/c) from dzaf_t.dzaf010
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : void
# Date & Author   : 2014/01/11 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_init_var()
   LET gs_env = FGL_GETENV("DGENV") CLIPPED
   LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
   LET gs_zone = FGL_GETENV("ZONE") CLIPPED
   LET gd_date = cl_get_current()
   LET gs_cust = FGL_GETENV("CUST") CLIPPED 
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 產生SD元件規格設計檔(程式名稱.csd)
# Input parameter : p_code 規格代號
#                 : p_sys 模組
#                 : p_revision 規格版次
#                 : p_type 類型
#                 : p_identity 識別標示(s/c)  from dzaf_t.dzaf010
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/11 by madey
##########################################################################
#PUBLIC FUNCTION sadzp040_1_gen_csd(p_code, p_sys, p_revision)
PUBLIC FUNCTION sadzp040_1_gen_csd(p_code, p_sys, p_revision, p_type, p_identity)
   DEFINE p_code STRING,
          p_sys STRING,
          p_revision STRING,
          p_type STRING,
          p_identity STRING
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING
   DEFINE ls_module_dir STRING #模組目錄
   DEFINE li_cnt SMALLINT,
          li_revision SMALLINT,
          ls_old_revision STRING,
          ls_dept STRING 
   DEFINE ls_csd STRING
   DEFINE ldoc_csd xml.DomDocument,
          lnode_csd xml.DomNode,
          lnode_comp xml.DomNode
   DEFINE ls_str STRING, #多語言檔路徑:str,4ad
          lnode_str xml.DomNode
   DEFINE lb_alm_result BOOLEAN,
          ls_err_msg STRING
   DEFINE lr_dzda  RECORD LIKE dzda_t.*,
          la_dzdp DYNAMIC ARRAY OF RECORD LIKE dzdp_t.*,
          li_idx SMALLINT

   LET gs_prog = p_code.trim()
   LET gs_sys = p_sys.toUpperCase()
   LET gs_revision = p_revision.trim()
   LET gs_type = p_type.trim()
   LET gs_identity = p_identity.trim()
   DISPLAY "sadzp040_1_gen_csd : receive param= ",gs_prog,",",gs_sys,",",gs_revision,",",gs_type,",",gs_identity

   CALL sadzp040_1_init_var()

   TRY
    ###2014/05/26 by Hiko : 整段改在sadzp060_2_after_check_out_for_download呼叫
    ##{
    ##LET ls_trigger = "sadzp040_1_gen_csd : check dzdp_t current ver data count"
    ###判斷樹-元件規格與元件版次對應表(dzdp_t)是否存在目前正要下載的版本 : 沒有就要建立.
    ###建立規則, 取max規格版次(dzdp002),有找到-> 以舊的版本當作基底建立規格樹(dzdp_t)
    ###                               沒有找到-> 表示是全新的規格,此時不須建立
    ##LET ls_sql = "SELECT count(*)",
    ##              " FROM dzdp_t",
    ##             " WHERE dzdp001='",gs_prog,"' AND dzdp002='",gs_revision,"'" #這裡不能加上dzaastus='Y'的條件,要不然底下就有可能出現重複插入資料的問題.
    ##PREPARE dzdp_prep0 FROM ls_sql
    ##EXECUTE dzdp_prep0 INTO li_cnt
    ##FREE dzdp_prep0
    ##IF li_cnt=0 THEN #資料不存在.
    ##   #要以舊的版本當作基底建立規格樹.但若沒有任一舊版本表示是全新規格,就不須自動產生
    ##   LET ls_sql = "SELECT MAX(DISTINCT(dzdp002))",
    ##                 " FROM dzdp_t",
    ##                " WHERE dzdp001='",gs_prog,"'"
    ##   PREPARE dzdp_prep5 FROM ls_sql
    ##   EXECUTE dzdp_prep5 INTO li_revision
    ##   IF li_revision > 0  THEN
    ##      #重要:要產生的新版次竟然比要更新的版次還要大,這不合理.
    ##      #     例如要更新第5版次的規格,然後找不到,再看看目前設計資料的最大版次是多少,結果查詢出來是6,這表示中間有設計資料被搞亂,或是上傳的規格版次被亂改.
    ##      IF (li_revision > gs_revision) THEN 
    ##         CALL cl_err_msg(ls_trigger, "adz-00199", gs_revision||"|"||li_revision, 1)
    ##         RETURN FALSE
    ##      END IF
    ##      LET ls_old_revision = li_revision
    ##      LET ls_old_revision = ls_old_revision.trim()
    ##      LET ls_dept = g_dept CLIPPED
    ##      LET ls_trigger = "sadzp040_1_gen_csd : insert new ver dzdp_t"
    ##      LET ls_sql = "INSERT INTO dzdp_t(dzdp001,dzdp002,dzdp003,dzdp004,dzdp005,dzdp006,dzdp007,",
    ##                                      "dzdpcrtdt,dzdpcrtdp,dzdpowndp,dzdpownid,dzdpstus,dzdpcrtid)",
    ##                              " SELECT dzdp001,'",gs_revision,"',dzdp003,dzdp004,dzdp005,dzdp006,dzdp007,",
    ##                                      "?,'",ls_dept,"','",ls_dept,"','",g_user,"',dzdpstus,'",g_user,"'",
    ##                                " FROM dzdp_t",
    ##                               " WHERE dzdp001='",gs_prog,"' AND dzdp002='",ls_old_revision,"' AND dzdpstus='Y'"
    ##      PREPARE dzdp_prep1 FROM ls_sql
    ##      EXECUTE dzdp_prep1 USING gd_date
    ##      FREE dzdp_prep1
    ##   END IF
    ##   FREE dzdp_prep5
    ##END IF 
    ##}

      LET ls_module_dir = FGL_GETENV(gs_sys) CLIPPED
      #產生csd檔根節點.
      LET ls_trigger = "sadzp040_1_gen_csd : gen csd"
      LET ls_csd = os.path.join(os.path.join(os.path.join(ls_module_dir, "dzx"), "tsd"), gs_prog||".csd")
      LET ldoc_csd = xml.domDocument.createDocument("components")
      LET lnode_csd = ldoc_csd.getDocumentElement()
      CALL lnode_csd.setAttribute("prog", gs_prog)
      CALL lnode_csd.setAttribute("std_prog", gs_prog) ##這是為了設計器固定格式而增加,並非行業別
      CALL lnode_csd.setAttribute("erpver", gs_erpver) #todo:ERP大版
      CALL lnode_csd.setAttribute("ver", gs_revision)      
      CALL lnode_csd.setAttribute("module", gs_sys)      
      CALL lnode_csd.setAttribute("type", gs_type) #類型    
      CALL lnode_csd.setAttribute("booking", "Y") #以流程來看:會呼叫sadzp040_1_gen_csd()的時候就是有權限,所以不需要再檢查
      CALL lnode_csd.setAttribute("env", gs_env)      
      CALL lnode_csd.setAttribute("zone", gs_zone)      
      CALL lnode_csd.setAttribute("identity", gs_identity) #規格標示

      #dzdp_t(元件規格與元件版次對應表)
      LET ls_sql = "SELECT *",
                    " FROM dzdp_t",
                   " WHERE dzdp001='",gs_prog,
                    "' AND dzdp002='",gs_revision,
                    "' AND dzdp006='",gs_identity,
                    "' AND dzdpstus='Y'",
                   " ORDER BY dzdp003"
      PREPARE dzdp_prep  FROM ls_sql
      DECLARE dzdp_curs CURSOR FOR dzdp_prep
      LET li_idx = 1
      FOREACH dzdp_curs INTO la_dzdp[li_idx].*
         #建立<comp>
         LET ls_trigger = "sadzp040_1_gen_csd : gen comp"
         LET ls_sql = "SELECT dzda_t.*",
                       " FROM dzdp_t",
                      " INNER JOIN dzda_t ON dzda001=dzdp003 AND dzda003=dzdp001",
                      " WHERE dzdp001='",gs_prog,
                       "' AND dzdp002='",gs_revision,
                       "' AND dzdp003='",la_dzdp[li_idx].dzdp003,
                       "' AND dzdp006='",gs_identity,
                       "' AND dzdpstus='Y'"
         PREPARE dzda_prep  FROM ls_sql
         INITIALIZE lr_dzda.* TO NULL
         EXECUTE dzda_prep INTO lr_dzda.*
         FREE dzda_prep

         LET lnode_comp = lnode_csd.appendChildElement("comp")
         CALL lnode_comp.setAttribute("id",la_dzdp[li_idx].dzdp003 CLIPPED)
         CALL lnode_comp.setAttribute("ver",la_dzdp[li_idx].dzdp004)
         #LET gs_dzdi003 = s_chr_trim(la_dzdp[li_idx].dzdp003) #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdp[li_idx].dzdp003 CLIPPED
         CALL lnode_comp.setAttribute("desc",sadz_get_name("dzda_t", "dzda001",gs_dzdi003))
         CALL lnode_comp.setAttribute("for_db",lr_dzda.dzda005 CLIPPED)
         #LET gs_dzdi003 = s_chr_trim(la_dzdp[li_idx].dzdp003) ,",purpose" #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdp[li_idx].dzdp003 CLIPPED ,",purpose"
         CALL lnode_comp.setAttribute("purpose",sadz_get_name("dzda_t", "dzda001",gs_dzdi003))
         CALL lnode_comp.setAttribute("status",'') #status是用來與設計器溝通的屬性,不須帶值
         DISPLAY "sadzp040_1_gen_csd : gen comp ",la_dzdp[li_idx].dzdp003," start!"

         #建立<param_rtn>參數及回傳值
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_param_rtn"
         IF NOT sadzp040_1_gen_param_rtn(lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_param_rtn finish!"
         
         #建立<key_word>關鍵詞
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_key_word"
         IF NOT sadzp040_1_gen_key_word(lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_key_word finish!"

         #建立<front_comp>前置元件
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_front_comp"
         IF NOT sadzp040_1_gen_front_comp(lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_front_comp finish!"

         #建立<test>測試記錄
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_test"
         IF NOT sadzp040_1_gen_test(lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_test finish!"

         #建立<dimension>維度分類表
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_dimension"
         IF NOT sadzp040_1_gen_dimension(lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_dimension finish!"

         #建立<spec>規格設計表
         LET ls_trigger = "sadzp040_1_gen_csd : call sadzp040_1_gen_spec"
         IF NOT sadzp040_1_gen_spec(ldoc_csd, lnode_comp, la_dzdp[li_idx].dzdp003 ,la_dzdp[li_idx].dzdp004) THEN
            RETURN FALSE
         END IF
         DISPLAY "call sadzp040_1_gen_spec finish!"

         DISPLAY "sadzp040_1_gen_csd : gen comp ",la_dzdp[li_idx].dzdp003," finish!"
         DISPLAY "-----------------------------------------------"
         LET li_idx = li_idx + 1
      END FOREACH
       
      #產生檔案 
      LET ls_trigger = "sadzp040_1_gen_csd : save csd"
      IF NOT sadzp040_1_save_csd(ldoc_csd, ls_csd) THEN
         RETURN FALSE
      END IF
      DISPLAY "gen csd success : ",ls_csd

      LET ls_trigger = "sadzp030_tsd_gen_tsd : save tsd.read"
      LET ls_csd = ls_csd,".read"
      CALL lnode_csd.setAttribute("booking", "N")
      IF NOT sadzp040_1_save_csd(ldoc_csd, ls_csd) THEN
         RETURN FALSE
      END IF
      DISPLAY "gen csd success : ",ls_csd

      RETURN TRUE
   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : none
# Date & Author   : 2014/01/12 by madey
##########################################################################
PUBLIC FUNCTION sadzp040_1_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00001"
      LET g_errparam.extend = p_trigger
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_sql
      CALL cl_err()
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00001"
      LET g_errparam.extend = p_trigger
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  NULL
      CALL cl_err()
   END IF
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<param_rtn>參數及回傳值
# Input parameter : parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_param_rtn(p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdb DYNAMIC ARRAY OF RECORD LIKE dzdb_t.*,
          li_idx SMALLINT,
          lnode_param_rtn xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_param_rtn : get param_rtn"

      #dzdb_t(元件参数檔)  (1對多)
      LET ls_sql = "SELECT dzdb_t.*",
                    " FROM dzdb_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdb001 AND dzdp004=dzdb006 AND dzdp008=dzdb008",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzdbstus='Y'",
                   " ORDER BY dzdb002,dzdb003"
      PREPARE dzdb_prep FROM ls_sql
      DECLARE dzdb_curs CURSOR FOR dzdb_prep

      LET li_idx = 1
      FOREACH dzdb_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdb[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_param_rtn = p_node_csd.appendChildElement("param_rtn")
            CALL lnode_param_rtn.setAttribute("ver", la_dzdb[li_idx].dzdb006)         
            CALL lnode_param_rtn.setAttribute("src", la_dzdb[li_idx].dzdb008 CLIPPED) #使用標示
            CALL lnode_param_rtn.setAttribute("cite_std", 'N') #行業別
            CALL lnode_param_rtn.setAttribute("status", '')
         END IF

         IF la_dzdb[li_idx].dzdb002='P' THEN  
            LET lnode_child = lnode_param_rtn.appendChildElement("input")
         ELSE 
            LET lnode_child = lnode_param_rtn.appendChildElement("output")
         END IF
         CALL lnode_child.setAttribute("order",la_dzdb[li_idx].dzdb003 CLIPPED)
         CALL lnode_child.setAttribute("name", la_dzdb[li_idx].dzdb005 CLIPPED)
         CALL lnode_child.setAttribute("type", la_dzdb[li_idx].dzdb007 CLIPPED)
         #LET gs_dzdi003 = s_chr_trim(la_dzdb[li_idx].dzdb001), ',', s_chr_trim(la_dzdb[li_idx].dzdb002), ',', s_chr_trim(la_dzdb[li_idx].dzdb003), ',', s_chr_trim(la_dzdb[li_idx].dzdb005) #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdb[li_idx].dzdb001 CLIPPED, ',', la_dzdb[li_idx].dzdb002 CLIPPED, ',', la_dzdb[li_idx].dzdb003 CLIPPED, ',', la_dzdb[li_idx].dzdb005 CLIPPED
         CALL lnode_child.setAttribute("desc", sadz_get_name("dzdb_t","dzdb005",gs_dzdi003))
         #LET gs_dzdi003 = s_chr_trim(la_dzdb[li_idx].dzdb001), ',', s_chr_trim(la_dzdb[li_idx].dzdb002), ',', s_chr_trim(la_dzdb[li_idx].dzdb003), ',', s_chr_trim(la_dzdb[li_idx].dzdb005), ",purpose" #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdb[li_idx].dzdb001 CLIPPED, ',', la_dzdb[li_idx].dzdb002 CLIPPED, ',', la_dzdb[li_idx].dzdb003 CLIPPED, ',', la_dzdb[li_idx].dzdb005 CLIPPED, ",purpose"
         CALL lnode_child.setAttribute("purpose", sadz_get_name("dzdb_t","dzdb005",gs_dzdi003))
         LET li_idx = li_idx + 1
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<key_word>關鍵詞
# Input parameter : parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_key_word(p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdc DYNAMIC ARRAY OF RECORD LIKE dzdc_t.*,
          li_idx SMALLINT,
          lnode_key_word xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_key_word : get key_word"

      #dzdc_t(元件關鍵詞檔)  (1對多)
      LET ls_sql = "SELECT dzdc_t.*",
                    " FROM dzdc_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdc001 AND dzdp004=dzdc003 AND dzdp008=dzdc004",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzdcstus='Y'",
                   " ORDER BY dzdc002"
      PREPARE dzdc_prep FROM ls_sql
      DECLARE dzdc_curs CURSOR FOR dzdc_prep

      LET li_idx = 1
      FOREACH dzdc_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdc[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_key_word = p_node_csd.appendChildElement("key_word")
            CALL lnode_key_word.setAttribute("ver", la_dzdc[li_idx].dzdc003)
            CALL lnode_key_word.setAttribute("src", la_dzdc[li_idx].dzdc004 CLIPPED) #使用標示
            CALL lnode_key_word.setAttribute("cite_std", "N") #行業別
            CALL lnode_key_word.setAttribute("status", '')
         END IF

         LET lnode_child = lnode_key_word.appendChildElement("key")
         CALL lnode_child.setAttribute("order",la_dzdc[li_idx].dzdc002 CLIPPED)
         #LET gs_dzdi003 = s_chr_trim(la_dzdc[li_idx].dzdc001), ',', s_chr_trim(la_dzdc[li_idx].dzdc002) #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdc[li_idx].dzdc001 CLIPPED, ',', la_dzdc[li_idx].dzdc002 CLIPPED
         CALL lnode_child.setAttribute("string", sadz_get_name("dzdc_t","dzdc002",gs_dzdi003))
       #20140211 marked by madey --start--
       #關鍵詞 : 多語言應該是[關鍵詞]本身, 所以建議不需要額外的說明, 此欄位不需要了
       # LET gs_dzdi003 = s_chr_trim(la_dzdc[li_idx].dzdc001), ',', s_chr_trim(la_dzdc[li_idx].dzdc002), ",desc"
       # CALL lnode_child.setAttribute("desc", sadz_get_name("dzdc_t","dzdc003",gs_dzdi003))
       #20140211 marked by madey --end--

         LET li_idx = li_idx + 1
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<front_comp>前置元件
# Input parameter : parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_front_comp(p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdd DYNAMIC ARRAY OF RECORD LIKE dzdd_t.*,
          li_idx SMALLINT,
          lnode_front_comp xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_front_comp : get front_comp"

      #dzdd_t(元件前置檔)  (1對多)
      LET ls_sql = "SELECT dzdd_t.*",
                    " FROM dzdd_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdd001 AND dzdp004=dzdd003 AND dzdp008=dzdd005",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzddstus='Y'",
                   " ORDER BY dzdd002"
      PREPARE dzdd_prep FROM ls_sql
      DECLARE dzdd_curs CURSOR FOR dzdd_prep

      LET li_idx = 1
      FOREACH dzdd_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdd[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_front_comp = p_node_csd.appendChildElement("front_comp")
            CALL lnode_front_comp.setAttribute("ver", la_dzdd[li_idx].dzdd003)
            CALL lnode_front_comp.setAttribute("src", la_dzdd[li_idx].dzdd005 CLIPPED) #使用標示
            CALL lnode_front_comp.setAttribute("cite_std", 'N') #行業別
            CALL lnode_front_comp.setAttribute("status", '')
         END IF

         LET lnode_child = lnode_front_comp.appendChildElement("fcomp")
         CALL lnode_child.setAttribute("order",la_dzdd[li_idx].dzdd002 CLIPPED)
         CALL lnode_child.setAttribute("id",la_dzdd[li_idx].dzdd004 CLIPPED)
       #20140211 marked by madey --end--
       #前置元件的說明由手動輸入改由帶出此元件的名稱並唯讀,此欄位不需要了
       # LET gs_dzdi003 = s_chr_trim(la_dzdd[li_idx].dzdd001), ',', s_chr_trim(la_dzdd[li_idx].dzdd002), ',', s_chr_trim(la_dzdd[li_idx].dzdd004)
       # CALL lnode_child.setAttribute("desc", sadz_get_name("dzdd_t","dzdd004",gs_dzdi003))
       #20140211 marked by madey --end--

         LET li_idx = li_idx + 1
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<test>測試記錄
# Input parameter : parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_test(p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdm DYNAMIC ARRAY OF RECORD LIKE dzdm_t.*,
          li_idx SMALLINT,
          lnode_test xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_test : get test"

      #dzdm_t(測試記錄)  (1對多)
      LET ls_sql = "SELECT dzdm_t.*",
                    " FROM dzdm_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdm001 AND dzdp004=dzdm010 AND dzdp008=dzdm011",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzdmstus='Y'",
                   " ORDER BY dzdm002"
      PREPARE dzdm_prep FROM ls_sql
      DECLARE dzdm_curs CURSOR FOR dzdm_prep

      LET li_idx = 1
      FOREACH dzdm_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdm[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_test = p_node_csd.appendChildElement("test")
            CALL lnode_test.setAttribute("ver", la_dzdm[li_idx].dzdm010)
            CALL lnode_test.setAttribute("src", la_dzdm[li_idx].dzdm011 CLIPPED) #使用標示
            CALL lnode_test.setAttribute("cite_std", 'N') #行業別
            CALL lnode_test.setAttribute("status", '')
         END IF

         LET lnode_child = lnode_test.appendChildElement("scenario")
         CALL lnode_child.setAttribute("order",la_dzdm[li_idx].dzdm002 CLIPPED)
         CALL lnode_child.setAttribute("desc",la_dzdm[li_idx].dzdm003 CLIPPED)
         CALL lnode_child.setAttribute("input",la_dzdm[li_idx].dzdm004 CLIPPED)
         CALL lnode_child.setAttribute("output",la_dzdm[li_idx].dzdm005 CLIPPED)
         CALL lnode_child.setAttribute("pos_neg",la_dzdm[li_idx].dzdm006 CLIPPED)
         CALL lnode_child.setAttribute("err_code",la_dzdm[li_idx].dzdm007 CLIPPED)
        #CALL lnode_child.setAttribute("err_desc",la_dzdm[li_idx].dzdm008 CLIPPED) #由設計器自行取得
         CALL lnode_child.setAttribute("memo",la_dzdm[li_idx].dzdm009 CLIPPED)
         LET li_idx = li_idx + 1
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<dimension>維度分類表
# Input parameter : parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_dimension(p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdh DYNAMIC ARRAY OF RECORD LIKE dzdh_t.*,
          li_idx SMALLINT,
          lnode_dimension xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_dimension : get  dimension"

      #dzdh_t(維度分類表)  (1對多)
      LET ls_sql = "SELECT dzdh_t.*",
                    " FROM dzdh_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdh003 AND dzdp004=dzdh004 AND dzdp008=dzdh005",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzdhstus='Y'",
                   " ORDER BY dzdh001"
      PREPARE dzdh_prep FROM ls_sql
      DECLARE dzdh_curs CURSOR FOR dzdh_prep

      LET li_idx = 1
      FOREACH dzdh_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdh[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_dimension = p_node_csd.appendChildElement("dimension")
            CALL lnode_dimension.setAttribute("ver", la_dzdh[li_idx].dzdh004)
            CALL lnode_dimension.setAttribute("src", la_dzdh[li_idx].dzdh005 CLIPPED) #使用標示
            CALL lnode_dimension.setAttribute("cite_std", 'N') #行業別
            CALL lnode_dimension.setAttribute("status", '')
         END IF

         LET lnode_child = lnode_dimension.appendChildElement("dimen")       #有些欄位在adzi400與分鏡檔長得不太一樣
         CALL lnode_child.setAttribute("no",la_dzdh[li_idx].dzdh001 CLIPPED)
         #LET gs_dzdi003 = s_chr_trim(la_dzdh[li_idx].dzdh001) #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdh[li_idx].dzdh001 CLIPPED
         CALL lnode_child.setAttribute("desc", sadz_get_name("dzdg_t","dzdg001",gs_dzdi003))
         CALL lnode_child.setAttribute("class",la_dzdh[li_idx].dzdh002 CLIPPED)
         #LET gs_dzdi003 = s_chr_trim(la_dzdh[li_idx].dzdh001), ',', s_chr_trim(la_dzdh[li_idx].dzdh002) #2015/11/26 by Hiko
         LET gs_dzdi003 = la_dzdh[li_idx].dzdh001 CLIPPED, ',', la_dzdh[li_idx].dzdh002 CLIPPED
         CALL lnode_child.setAttribute("class_value", sadz_get_name("dzdg_t","dzdg002",gs_dzdi003))
         LET li_idx = li_idx + 1
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 建立<spec>規格設計表
# Input parameter : document
#                   parent node
#                   p_comp_id 元件代號
#                   p_comp_ver 元件版本
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/16 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_1_gen_spec(p_doc_csd, p_node_csd,p_comp_id,p_comp_ver)
   DEFINE p_doc_csd xml.DomDocument,
          p_node_csd xml.DomNode,
          p_comp_id  LIKE dzdp_t.dzdp003,
          p_comp_ver LIKE dzdp_t.dzdp004
   DEFINE ls_trigger STRING,
          ls_sql STRING,
          la_dzdo DYNAMIC ARRAY OF RECORD LIKE dzdo_t.*,
          li_idx SMALLINT,
          lnode_spec xml.DomNode,
          lnode_child xml.DomNode

   TRY
      LET ls_trigger = "sadzp040_1_gen_spec : get spec"

      #dzdo_t(規格設計表)  (1對多)
      LET ls_sql = "SELECT dzdo_t.*",
                    " FROM dzdo_t",
                   " INNER JOIN dzdp_t ON dzdp003=dzdo001 AND dzdp004=dzdo002 AND dzdp008=dzdo003",
                   " WHERE dzdp001=?
                       AND dzdp002=?
                       AND dzdp003=?
                       AND dzdp006=?
                       AND dzdp004=?
                       AND dzdostus='Y'"
      PREPARE dzdo_prep FROM ls_sql
      DECLARE dzdo_curs CURSOR FOR dzdo_prep

      LOCATE la_dzdo[1].dzdo099 IN FILE #在真正取得資料前,先設定陣列第一筆clob資料的LOCATE.
      LET li_idx = 1
      FOREACH dzdo_curs USING gs_prog,gs_revision,p_comp_id,gs_identity,p_comp_ver
                        INTO la_dzdo[li_idx].* 
         #版次只需要設定一次.
         IF li_idx=1 THEN
            LET lnode_spec = p_node_csd.appendChildElement("spec")
            CALL lnode_spec.setAttribute("ver", la_dzdo[li_idx].dzdo002)
            CALL lnode_spec.setAttribute("src", la_dzdo[li_idx].dzdo003 CLIPPED) #使用標示
            CALL lnode_spec.setAttribute("cite_std", 'N') #行業別
            CALL lnode_spec.setAttribute("status", '')
         END IF
         
         LET lnode_child = p_doc_csd.createCDATASection(la_dzdo[li_idx].dzdo099)
         CALL lnode_spec.appendChild(lnode_child)
         FREE la_dzdo[li_idx].dzdo099 #釋放LOCATE.

         LET li_idx = li_idx + 1
         LOCATE la_dzdo[li_idx].dzdo099 IN FILE #設定陣列第二筆以後clob資料的LOCATE.
      END FOREACH
      RETURN TRUE

   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 完成規格離線檔的建立.
# Input parameter : p_doc_csd <csd> doc
#                 : p_csd_path csd檔路徑
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 
##########################################################################
PRIVATE FUNCTION sadzp040_1_save_csd(p_doc_csd, p_csd_path)
   DEFINE p_doc_csd XML.DomDocument,
          p_csd_path STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING

   TRY
      #將csd更名
      LET ls_trigger = "sadzp040_1_save_csd : csd rename"
      IF os.Path.EXISTS(p_csd_path) THEN
         IF NOT os.Path.RENAME(p_csd_path, p_csd_path||".bak") THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00174"
            LET g_errparam.extend = ls_trigger
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  "rename"
            LET g_errparam.replace[2] = gs_prog
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      
      CALL p_doc_csd.setFeature("format-pretty-print", "TRUE")
      CALL p_doc_csd.save(p_csd_path)

      #最後變成777, 這樣在運行過程中會比較保險.
      IF NOT os.Path.chrwx(p_csd_path, 511) THEN
         DISPLAY "CALL sadzp040_1_save_csd : ",p_csd_path," change rwx ERROR!"
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00174"
         LET g_errparam.extend = ls_trigger
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  "chmod"
         LET g_errparam.replace[2] = gs_prog
         CALL cl_err()
         RETURN FALSE
      END IF
      RETURN TRUE
   CATCH 
      CALL sadzp040_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION





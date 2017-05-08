#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/10/12
#
#+ 程式代碼......: sadzp040_2
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp040_2.4gl
# Description    : 更新元件規格檔資料
# Modify         : 2014/01/07 by madey : 參考sadzp060_1.4gl建立程式
#                : 2014/03/18 by madey : 處理dzdb_t等第3層資料在同一個規格版次下多次修改,第1次3筆資料,第2次小於3筆時的情況
#                : 2014/04/29 by madey : 修正dzdo099的update方式
#                : 2014/05/13 by madey : 1.因應二次開發增加欄位:規格標示(PK)、客戶代號
#                                        2.sadzp040_2_update_csd()增加參數p_identity
#                                        3.停用dzdn_t簡化關係:由dzdp->dzdn->dzdb三層關係改為dzdp->dzdb兩層關係
#                : 2014/05/26 by Hiko : 1.將sadzp040_2_chk_permission註解,上傳判斷權限改為呼叫sadzp060_2_chk_permission                                       
#                : 2014/09/22 by madey: 因應版次欄物型態改變而調整(varchar -> number)

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gs_env LIKE dzaa_t.dzaa006      #辨識目前所在的環境:s.產中環境,c.客製環境
DEFINE gd_date DATETIME YEAR TO SECOND
#DEFINE gs_revision     LIKE dzaa_t.dzaa002 #規格版次/程式版次 #20140922 mark
DEFINE gs_revision      STRING                                 #20140922 edit
DEFINE gs_revision_col  LIKE dzaa_t.dzaa002 #規格版次/程式版次 #20140922 add
#因為g_dept是char 10,就算設定為NULL,進入資料庫前還是得CLIPPED才不會變成一個空白,所以STRING來承接.
DEFINE gs_dept STRING 
DEFINE gs_erpver STRING                #ERP大版版號
DEFINE gs_prog LIKE dzaa_t.dzaa001
DEFINE gs_sys  STRING
DEFINE gs_cust LIKE dzaf_t.dzaf009     #客戶代號
DEFINE gs_identity LIKE dzaf_t.dzaf010 #規格標示(s/c):由呼叫端傳來
DEFINE ga_sr DYNAMIC ARRAY OF RECORD
             sr STRING,
             table STRING,
             insert STRING,
             delete STRING,
             append STRING,
             cascade STRING,
             kind STRING,
             status STRING
             END RECORD

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : void
# Date & Author   : 2014/02/07 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_init_var()
   DEFINE ls_trigger STRING

   TRY
      LET ls_trigger = "sadzp040_2_init_var"
      LET gs_env = FGL_GETENV("DGENV") CLIPPED
      LET gd_date = cl_get_current()
      LET gs_dept = g_dept CLIPPED
      LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
      LET gs_cust = FGL_GETENV("CUST") CLIPPED
      DISPLAY "call sadzp040_2_init_var finish"
      RETURN TRUE

   CATCH
      CALL sadzp040_2_err_catch(ls_trigger, NULL)
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 更新csd檔對應的資料表
# Input parameter : p_prog 程式代號
#                 : p_sys 模組別
#                 : p_identity 識別標示(s/c)  from dzaf_t.dzaf010
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PUBLIC FUNCTION sadzp040_2_update_csd(p_prog, p_sys)
PUBLIC FUNCTION sadzp040_2_update_csd(p_prog, p_sys,p_identity)
   DEFINE p_prog STRING,
          p_sys STRING,
          p_identity STRING
   DEFINE ls_module_dir STRING #模組目錄
   DEFINE ls_sql STRING,
          ls_where STRING
   DEFINE ls_trigger STRING 
   DEFINE ls_csd STRING, #csd檔路徑
          ldoc_csd xml.DomDocument,
          lnode_csd xml.DomNode,
          lnode_child xml.DomNode, 
          lnode_comp xml.DomNode, 
          ls_tag_name STRING,
          ls_comp_status STRING,
          ls_status STRING,
          ls_comp_id STRING,       #元件代號
          ls_comp_revision  STRING #元件版次
   DEFINE lnode_field xml.DomNode, 
          lb_result BOOLEAN

   LET gs_prog     = p_prog.trim()
   LET gs_sys      = p_sys.toUpperCase()
   LET gs_identity = p_identity         #識別標示

   IF NOT sadzp040_2_init_var() THEN
      RETURN FALSE
   END IF

   LET lb_result = TRUE
   TRY
      DISPLAY "call sadzp040_2_update_csd start!"

      #取得csd檔.
      LET ls_module_dir = FGL_GETENV(gs_sys) CLIPPED
      LET ls_csd = os.path.join(os.path.join(os.path.join(ls_module_dir, "dzx"), "tsd"), gs_prog||".csd")
      LET ldoc_csd = xml.domDocument.create()
      LET ls_trigger = "sadzp040_2_update_csd : load csd=",ls_csd
      IF NOT os.Path.exists(ls_csd) THEN
         #CALL cl_err_msg("", "adz-00175", gs_prog||".csd", 0)
         DISPLAY "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00175", g_lang), gs_prog||".csd")
         RETURN FALSE
      END IF
      CALL ldoc_csd.load(ls_csd)
      LET lnode_csd = ldoc_csd.getDocumentElement()
      #權限改在chk_permission檢查,並且在上傳解包後馬上呼叫.
      LET gs_revision = lnode_csd.getAttribute("ver") CLIPPED #規格版次
      LET gs_revision = gs_revision.trim()   #20140922 add
      LET gs_revision_col = gs_revision      #20140922 add

      BEGIN WORK
      LET lnode_comp = lnode_csd.getFirstChildElement() #取得第一個<comp>節點
      WHILE (lnode_comp IS NOT NULL)
         LET ls_tag_name = lnode_comp.getLocalName()
         IF ls_tag_name.equals("comp") THEN
            LET ls_comp_id = lnode_comp.getAttribute("id")      #元件代號
            LET ls_comp_id = ls_comp_id.trim()
            LET ls_comp_revision=lnode_comp.getAttribute("ver") #元件版次 

            LET ls_comp_status = lnode_comp.getAttribute("status")
            CASE ls_comp_status
               WHEN "u"
                  #更新元件基本檔(dzda_t)
                  IF NOT sadzp040_2_update_dzda_t(lnode_comp,ls_comp_id) THEN
                     ROLLBACK WORK
                     DISPLAY "call sadzp040_2_update_csd fail!"
                     RETURN FALSE
                  END IF

               WHEN "d"
                  #表示此元件被設計器delete，將元件狀態設為失效
                  #此處異動dzdp_t而不是異動dzda_t的原因,是因為其他版本的規格可能還是有該元件
                  LET ls_where = " WHERE dzdp001='",gs_prog,"' AND dzdp002='",gs_revision,"' AND dzdp003='",ls_comp_id,"'"
                  IF NOT sadzp040_2_disable_status("dzdp_t", ls_where, "") THEN 
                     ROLLBACK WORK 
                     DISPLAY "call sadzp040_2_update_csd fail!"
                     RETURN FALSE
                  END IF
                  LET lnode_comp = lnode_comp.getNextSiblingElement() #取得下一個<comp>節點
                  CONTINUE WHILE

            END CASE
          
            IF ls_comp_status = "u"  THEN #當元件的status為u時就upate其內容,不管異動了哪一塊tag
               #以原本dzdp為基礎,copy一份該元件所有table的資料(dzdb/dzdc/dzdd/dzdm/dzdh/dzdo)
               #並將識別碼版次set=規格版次,使用標示set=gs_env, 狀態先set=disable
               IF NOT sadzp040_2_copy_body(ls_comp_id) THEN
                  ROLLBACK WORK
                  DISPLAY "call sadzp040_2_update_csd fail!"
                  RETURN FALSE
               END IF
               
               #更新dzdp_t此元件規格中,將此元件代號的元件版次set =規格版次
               IF NOT sadzp040_2_update_dzdp_t(ls_comp_id) THEN
                  ROLLBACK WORK
                  DISPLAY "call sadzp040_2_update_csd fail!"
                  RETURN FALSE
               END IF

               LET lnode_child = lnode_comp.getFirstChildElement() #取得<comp>節點的第一個子節點
               WHILE (lnode_child IS NOT NULL)
                  LET ls_tag_name = lnode_child.getLocalName()
                  IF (ls_tag_name.equals("param_rtn") OR 
                      ls_tag_name.equals("key_word") OR 
                      ls_tag_name.equals("front_comp") OR 
                      ls_tag_name.equals("test") OR 
                      ls_tag_name.equals("dimension") OR 
                      ls_tag_name.equals("spec"))
                  THEN 
                   ##LET ls_status = lnode_child.getAttribute("status")
                   #madey:配合dzdn_t停用,改成不管status有沒有被異動,只要是做上傳表示要異動,所以全部table都更新版次
                   ##IF NOT cl_null(ls_status) THEN #status =u/d 
                        CASE ls_tag_name
                           WHEN "param_rtn"
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdb_t"
                              CALL sadzp040_2_update_dzdb_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdb_t finish"
                           WHEN "key_word" 
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdc_t"
                              CALL sadzp040_2_update_dzdc_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdc_t finish"
                           WHEN "front_comp"
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdd_t"
                              CALL sadzp040_2_update_dzdd_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdd_t finish"
                           WHEN "test"
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdm_t"
                              CALL sadzp040_2_update_dzdm_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdm_t finish"
                           WHEN "dimension"
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdh_t"
                              CALL sadzp040_2_update_dzdh_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdh_t finish"
                           WHEN "spec"
                              LET ls_trigger = "sadzp040_2_update_csd : sadzp040_2_update_dzdo_t"
                              CALL sadzp040_2_update_dzdo_t(lnode_child,ls_comp_id) RETURNING lb_result
                              DISPLAY "call sadzp040_2_update_dzdo_t finish"
                        END CASE
               
                        IF NOT lb_result THEN
                           ROLLBACK WORK
                           DISPLAY "call sadzp040_2_update_csd fail!"
                           RETURN FALSE
                        END IF
                   ##END IF 
                  END IF #IF ls_tag_name.equals("comp")
                  LET lnode_child = lnode_child.getNextSiblingElement() #取得<comp>節點的下一個子節點
               END WHILE #WHILE (lnode_child IS NOT NULL)
            END IF  #IF ls_comp_status = "u"  THEN #當元件的status為u時就upate其內容,不管異動了哪一塊tag
         END IF

         LET lnode_comp = lnode_comp.getNextSiblingElement() #取得下一個<comp>節點
      END WHILE #WHILE (lnode_comp IS NOT NULL)#

      COMMIT WORK 
      DISPLAY "call sadzp040_2_update_csd finish!"
      RETURN lb_result

   CATCH 
      ROLLBACK WORK 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<param_rtn>屬性資料,更新dzdb_t.
# Input parameter : p_node_param_rtn <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdb_t(p_node_param_rtn,p_comp_id)
   DEFINE p_node_param_rtn xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_tag_name STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE ls_flag STRING,
          ls_order STRING,
          ls_name STRING,
          ls_type STRING,
          ls_desc STRING,
          ls_purpose STRING,
          ls_dzdi003 STRING
   DEFINE lb_have_item BOOLEAN #是否有資料

   TRY

     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容逐筆更新,
     ##這樣做可解決第1次有3筆有效資料,第2次只剩2筆/1筆/甚至無資料的情況
     ##如此一來，下面lb_have_item的做法可mark掉了
     #LET ls_where = " WHERE dzdb001='",p_comp_id,"' AND dzdb006='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdb_t", ls_where, "dzdb008") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--
      
     #LET lb_have_item = FALSE  #20140318 madey marked
      LET lnode_item = p_node_param_rtn.getFirstChildElement()
      WHILE lnode_item IS NOT NULL
         LET ls_tag_name = lnode_item.getLocalName()
         IF ls_tag_name.equals("input") OR ls_tag_name.equals("output") THEN
           #LET lb_have_item = TRUE #有資料   #20140318 madey marked
            IF ls_tag_name.equals("input") THEN LET ls_flag='P' ELSE LET ls_flag='R'
            END IF
            LET ls_order= lnode_item.getAttribute("order")CLIPPED
            LET ls_name = lnode_item.getAttribute("name") CLIPPED
            LET ls_type = lnode_item.getAttribute("type") CLIPPED
            LET ls_desc = lnode_item.getAttribute("desc") CLIPPED
            LET ls_purpose = lnode_item.getAttribute("purpose") CLIPPED
               
            #執行dzdb_t的異動.
            LET ls_where = " WHERE dzdb001='",p_comp_id,
                            "' AND dzdb002='",ls_flag,
                            "' AND dzdb003='",ls_order,
                            "' AND dzdb006='",gs_revision,
                            "' AND dzdb008='",gs_env,"'"
            LET ls_trigger = "sadzp040_2_update_dzdb_t : check new version data count"
            LET ls_sql = "SELECT count(*) FROM dzdb_t",ls_where
            PREPARE dzdb_prep3 FROM ls_sql
            EXECUTE dzdb_prep3 INTO li_cnt
            FREE dzdb_prep3

            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp040_2_update_dzdb_t : update dzdb_t data"
               LET ls_sql = "UPDATE dzdb_t",
                              " SET dzdb005='",ls_name,"',",
                                   "dzdb007='",ls_type,"',",
                                   "dzdb009='",gs_cust,"',",
                                   "dzdbstus='Y',", 
                                   "dzdbmoddt=?,",
                                   "dzdbmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp040_2_update_dzdb_t : insert dzdb_t data"
               LET ls_sql = "INSERT INTO dzdb_t(dzdb001,dzdb002,dzdb003,dzdb005,",
                                               "dzdb007,dzdb006,dzdb008,dzdb009,",
                                               "dzdbcrtdt,dzdbcrtdp,dzdbowndp,dzdbownid,dzdbstus,dzdbcrtid)",
                                 " VALUES('",p_comp_id,"','",ls_flag,"','",ls_order,"','",ls_name,"',",
                                         "'",ls_type,"','",gs_revision,"','",gs_env,"','",gs_cust,"',", 
                                         "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzdb_prep4 FROM ls_sql
            EXECUTE dzdb_prep4 USING gd_date 
            FREE dzdb_prep4

          #更新元件多語言檔(dzdi_t) --start--
            #<desc>
            LET ls_dzdi003 = p_comp_id, ',', ls_flag, ',', ls_order, ',', ls_name
            IF NOT sadzp040_2_update_dzdi_t("dzdb_t","dzdb005",ls_dzdi003,ls_desc) THEN
               RETURN FALSE
            END IF
            #<purpose>
            LET ls_dzdi003 = p_comp_id, ',', ls_flag, ',', ls_order, ',', ls_name, ',purpose'
            IF NOT sadzp040_2_update_dzdi_t("dzdb_t","dzdb005",ls_dzdi003,ls_purpose) THEN
               RETURN FALSE
            END IF
          #更新元件多語言檔(dzdi_t) --end--
         END IF

         LET lnode_item = lnode_item.getNextSiblingElement()
      END WHILE
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION

 
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<key_word>屬性資料,更新dzdc_t.
# Input parameter : p_node_key_word <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdc_t(p_node_key_word,p_comp_id)
   DEFINE p_node_key_word xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_tag_name STRING,
          ls_old_revision STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE ls_order STRING,
          ls_string STRING,
          ls_dzdi003 STRING
   DEFINE lb_have_item BOOLEAN #是否有資料

   TRY
     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容逐筆更新,
     ##這樣做可解決第1次有3筆有效資料,第2次只剩2筆/1筆/甚至無資料的情況
     ##如此一來，下面lb_have_item的做法可mark掉了
     #LET ls_where = " WHERE dzdc001='",p_comp_id,"' AND dzdc003='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdc_t", ls_where, "dzdc004") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--

      LET lnode_item = p_node_key_word.getFirstChildElement()
      WHILE lnode_item IS NOT NULL
         LET ls_tag_name = lnode_item.getLocalName()
         IF ls_tag_name.equals("key") THEN
           #LET lb_have_item = TRUE #有資料 #20140318 madey marked
            LET ls_order= lnode_item.getAttribute("order") CLIPPED
            LET ls_string = lnode_item.getAttribute("string") CLIPPED
               
            #執行dzdc_t的異動.
            LET ls_where = " WHERE dzdc001='",p_comp_id,
                            "' AND dzdc002='",ls_order,
                            "' AND dzdc003='",gs_revision,
                            "' AND dzdc004='",gs_env,"'"
            LET ls_trigger = "sadzp040_2_update_dzdc_t : check new version data count"
            LET ls_sql = "SELECT count(*) FROM dzdc_t",ls_where
            PREPARE dzdc_prep3 FROM ls_sql
            EXECUTE dzdc_prep3 INTO li_cnt
            FREE dzdc_prep3

            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp040_2_update_dzdc_t : update dzdc_t data"
               LET ls_sql = "UPDATE dzdc_t",
                              " SET dzdcstus='Y',",
                                   "dzdc005='",gs_cust,"',",
                                   "dzdcmoddt=?,",
                                   "dzdcmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp040_2_update_dzdc_t : insert dzdc_t data"
               LET ls_sql = "INSERT INTO dzdc_t(dzdc001,dzdc002,dzdc003,dzdc004,dzdc005,",
                                               "dzdccrtdt,dzdccrtdp,dzdcowndp,dzdcownid,dzdcstus,dzdccrtid)",
                                  " VALUES('",p_comp_id,"','",ls_order,"','",gs_revision,"','",gs_env,"','",gs_cust,"',",
                                           "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzdc_prep4 FROM ls_sql
            EXECUTE dzdc_prep4 USING gd_date 
            FREE dzdc_prep4

          #更新元件多語言檔(dzdi_t) --start--
            #<string>
            LET ls_dzdi003 = p_comp_id, ',', ls_order
            IF NOT sadzp040_2_update_dzdi_t("dzdc_t","dzdc002",ls_dzdi003,ls_string) THEN
               RETURN FALSE
            END IF
          #更新元件多語言檔(dzdi_t) --end--
         END IF

         LET lnode_item = lnode_item.getNextSiblingElement()
      END WHILE
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<front_comp>屬性資料,更新dzdd_t.
# Input parameter : p_node_front_comp <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdd_t(p_node_front_comp,p_comp_id)
   DEFINE p_node_front_comp xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_tag_name STRING,
          ls_old_revision STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE ls_order STRING,
          ls_id STRING
   DEFINE lb_have_item BOOLEAN #是否有資料

   TRY
     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容逐筆更新,
     ##這樣做可解決第1次有3筆有效資料,第2次只剩2筆/1筆/甚至無資料的情況
     ##如此一來，下面lb_have_item的做法可mark掉了
     #LET ls_where = " WHERE dzdd001='",p_comp_id,"' AND dzdd003='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdd_t", ls_where, "dzdd005") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--

      LET lnode_item = p_node_front_comp.getFirstChildElement()
      WHILE lnode_item IS NOT NULL
         LET ls_tag_name = lnode_item.getLocalName()
         IF ls_tag_name.equals("fcomp") THEN
           #LET lb_have_item = TRUE #有資料 20140318 madey marked
            LET ls_order= lnode_item.getAttribute("order") CLIPPED
            LET ls_id = lnode_item.getAttribute("id") CLIPPED
               
            #執行dzdd_t的異動.
            LET ls_where = " WHERE dzdd001='",p_comp_id,
                            "' AND dzdd002='",ls_order,
                            "' AND dzdd003='",gs_revision,
                            "' AND dzdd005='",gs_env,"'"
            LET ls_trigger = "sadzp040_2_update_dzdd_t : check new version data count"
            LET ls_sql = "SELECT count(*) FROM dzdd_t",ls_where
            PREPARE dzdd_prep3 FROM ls_sql
            EXECUTE dzdd_prep3 INTO li_cnt
            FREE dzdd_prep3

            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp040_2_update_dzdd_t : update dzdd_t data"
               LET ls_sql = "UPDATE dzdd_t",
                              " SET dzdd004='",ls_id,"',",
                                   "dzddstus='Y',",
                                   "dzdd006='",gs_cust,"',",
                                   "dzddmoddt=?,",
                                   "dzddmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp040_2_update_dzdd_t : insert dzdd_t data"
               LET ls_sql = "INSERT INTO dzdd_t(dzdd001,dzdd002,dzdd003,dzdd004,dzdd005,dzdd006,",
                                               "dzddcrtdt,dzddcrtdp,dzddowndp,dzddownid,dzddstus,dzddcrtid)",
                                  " VALUES('",p_comp_id,"','",ls_order,"','",gs_revision,"','",ls_id,"','",gs_env,"','",gs_cust,"',", 
                                           "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzdd_prep4 FROM ls_sql
            EXECUTE dzdd_prep4 USING gd_date 
            FREE dzdd_prep4
         END IF

         LET lnode_item = lnode_item.getNextSiblingElement()
      END WHILE
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<test>屬性資料,更新dzdm_t.
# Input parameter : p_node_test <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdm_t(p_node_test,p_comp_id)
   DEFINE p_node_test xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_tag_name STRING,
          ls_old_revision STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE ls_pos_neg STRING,
          ls_order STRING,
          ls_input STRING,
          ls_output STRING,
          ls_desc STRING,
          ls_err_code STRING,
          ls_memo STRING
   DEFINE lb_have_item BOOLEAN #是否有資料

   TRY
     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容逐筆更新,
     ##這樣做可解決第1次有3筆有效資料,第2次只剩2筆/1筆/甚至無資料的情況
     ##如此一來，下面lb_have_item的做法可mark掉了
     #LET ls_where = " WHERE dzdm001='",p_comp_id,"' AND dzdm010='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdm_t", ls_where, "dzdm011") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--

      LET lnode_item = p_node_test.getFirstChildElement()
      WHILE lnode_item IS NOT NULL
         LET ls_tag_name = lnode_item.getLocalName()
         IF ls_tag_name.equals("scenario") THEN
           #LET lb_have_item = TRUE #有資料  #20140318 madey marked
            LET ls_order= lnode_item.getAttribute("order")CLIPPED
            LET ls_desc = lnode_item.getAttribute("desc") CLIPPED
            LET ls_input= lnode_item.getAttribute("input")CLIPPED
            LET ls_output= lnode_item.getAttribute("output")CLIPPED
            LET ls_pos_neg = lnode_item.getAttribute("pos_neg") CLIPPED
            LET ls_err_code = lnode_item.getAttribute("err_code") CLIPPED
            LET ls_memo = lnode_item.getAttribute("memo") CLIPPED
               
            #執行dzdm_t的異動.
            LET ls_where = " WHERE dzdm001='",p_comp_id,
                           "' AND dzdm002='",ls_order,
                           "' AND dzdm010='",gs_revision,
                           "' AND dzdm011='",gs_env,"'"
            LET ls_trigger = "sadzp040_2_update_dzdm_t : check new version data count"
            LET ls_sql = "SELECT count(*) FROM dzdm_t",ls_where
            PREPARE dzdm_prep3 FROM ls_sql
            EXECUTE dzdm_prep3 INTO li_cnt
            FREE dzdm_prep3

            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp040_2_update_dzdm_t : update dzdm_t data"
               LET ls_sql = "UPDATE dzdm_t",
                              " SET dzdm003='",ls_desc,"',",
                                   "dzdm004='",ls_input,"',",
                                   "dzdm005='",ls_output,"',",
                                   "dzdm006='",ls_pos_neg,"',",
                                   "dzdm007='",ls_err_code,"',",
                                   "dzdm009='",ls_memo,"',",
                                   "dzdm008='",gs_cust,"',",
                                   "dzdmstus='Y',", 
                                   "dzdmmoddt=?,",
                                   "dzdmmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp040_2_update_dzdm_t : insert dzdm_t data"
               LET ls_sql = "INSERT INTO dzdm_t(dzdm001,dzdm002,dzdm003,dzdm004,dzdm005,",
                                               "dzdm006,dzdm007,dzdm009,dzdm010,dzdm011,dzdm008,",
                                               "dzdmcrtdt,dzdmcrtdp,dzdmowndp,dzdmownid,dzdmstus,dzdmcrtid)",
                                  " VALUES('",p_comp_id,"','",ls_order,"','",ls_desc,"','",ls_input,"','",ls_output,"',",
                                          "'",ls_pos_neg,"','",ls_err_code,"','",ls_memo,"','",gs_revision,"','",gs_env,"','",gs_cust,"',",
                                           "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzdm_prep4 FROM ls_sql
            EXECUTE dzdm_prep4 USING gd_date 
            FREE dzdm_prep4
         END IF

         LET lnode_item = lnode_item.getNextSiblingElement()
      END WHILE
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<dimension>屬性資料,更新dzdh_t.
# Input parameter : p_node_dimension <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdh_t(p_node_dimension,p_comp_id)
   DEFINE p_node_dimension xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_tag_name STRING,
          ls_old_revision STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE ls_no STRING,
          ls_class STRING
   DEFINE lb_have_item BOOLEAN #是否有資料

   TRY
     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容逐筆更新,
     ##這樣做可解決第1次有3筆有效資料,第2次只剩2筆/1筆/甚至無資料的情況
     ##如此一來，下面lb_have_item的做法可mark掉了
     #LET ls_where = " WHERE dzd3001='",p_comp_id,"' AND dzdh004='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdh_t", ls_where, "dzdh005") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--

      LET lnode_item = p_node_dimension.getFirstChildElement()
      WHILE lnode_item IS NOT NULL
         LET ls_tag_name = lnode_item.getLocalName()
         IF ls_tag_name.equals("dimen") THEN
           #LET lb_have_item = TRUE #有資料 #20140318 madey marked
            LET ls_no= lnode_item.getAttribute("no") CLIPPED
            LET ls_class = lnode_item.getAttribute("class") CLIPPED
            #desc及class_value不抓的原因是這兩個值應該由adzi490維護,此處僅需要儲存代碼
            #LET ls_desc = lnode_item.getAttribute("desc") CLIPPED
            #LET ls_class_value = lnode_item.getAttribute("class_value") CLIPPED
               
            #執行dzdh_t的異動.
            LET ls_where = " WHERE dzdh003='",p_comp_id,
                            "' AND dzdh001='",ls_no,
                            "' AND dzdh002='",ls_class,
                            "' AND dzdh004='",gs_revision,
                            "' AND dzdh005='",gs_env,"'"
            LET ls_trigger = "sadzp040_2_update_dzdh_t : check new version data count"
            LET ls_sql = "SELECT count(*) FROM dzdh_t",ls_where
            PREPARE dzdh_prep3 FROM ls_sql
            EXECUTE dzdh_prep3 INTO li_cnt
            FREE dzdh_prep3

            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp040_2_update_dzdh_t : update dzdh_t data"
               LET ls_sql = "UPDATE dzdh_t",
                              " SET dzdhstus='Y',",
                                   "dzdh006='",gs_cust,"',",
                                   "dzdhmoddt=?,",
                                   "dzdhmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp040_2_update_dzdh_t : insert dzdh_t data"
               LET ls_sql = "INSERT INTO dzdh_t(dzdh001,dzdh002,dzdh003,dzdh004,dzdh005,dzdh006,",
                                               "dzdhcrtdt,dzdhcrtdp,dzdhowndp,dzdhownid,dzdhstus,dzdhcrtid)",
                                  " VALUES('",ls_no,"','",ls_class,"','",p_comp_id,"','",gs_revision,"','",gs_env,"','",gs_cust,"',",
                                           "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzdh_prep4 FROM ls_sql
            EXECUTE dzdh_prep4 USING gd_date 
            FREE dzdh_prep4
         END IF

         LET lnode_item = lnode_item.getNextSiblingElement()
      END WHILE
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<spec>屬性資料,更新dzdo_t.
# Input parameter : p_node_spec <table> node
#                   p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdo_t(p_node_spec,p_comp_id)
   DEFINE p_node_spec xml.DomNode,	  
          p_comp_id STRING
   DEFINE lnode_item xml.DomNode,
          ls_old_revision STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING
   DEFINE l_cdata LIKE dzab_t.dzab099,
          l_dzdo001 LIKE dzdo_t.dzdo001

   TRY
     ##20140318 madey add  --start--
     ##先將識別碼版次=規格版次,且使用標示=gs_env的資料狀態都設為disable,下面在依csd內容更新,
     #LET ls_where = " WHERE dzdo001='",p_comp_id,"' AND dzdo002='",gs_revision
     #IF NOT sadzp040_2_disable_status("dzdo_t", ls_where, "dzdo003") THEN 
     #   RETURN FALSE
     #END IF
     ##20140318 madey add --end--
 
      #取得clob欄位資料
      LOCATE l_cdata IN FILE
      LET l_cdata = sadzp040_2_get_cdata(p_node_spec)
      IF NOT cl_null(l_cdata) THEN  #判斷是否有資料
         #執行dzdo_t的異動.
         LET ls_where = " WHERE dzdo001='",p_comp_id,
                         "' AND dzdo002='",gs_revision,
                         "' AND dzdo003='",gs_env,"'"
         LET ls_trigger = "sadzp040_2_update_dzdo_t :  check new version data count"
         LET ls_sql = "SELECT count(*) FROM dzdo_t",ls_where
         PREPARE dzdo_prep3 FROM ls_sql
         EXECUTE dzdo_prep3 INTO li_cnt
         FREE dzdo_prep3
         
         IF li_cnt>0 THEN #資料已存在.
            LET ls_trigger = "sadzp040_2_update_dzdo_t : update dzdo_t data"
            LET ls_sql = "UPDATE dzdo_t",
                           " SET dzdostus='Y',", 
                                "dzdo004='",gs_cust,"',",
                                "dzdomoddt=?,",
                                "dzdomodid='",g_user,"' ",ls_where
         ELSE
            LET ls_trigger = "sadzp040_2_update_dzdo_t : insert dzdo_t data"
            LET ls_sql = "INSERT INTO dzdo_t(dzdo001,dzdo002,dzdo003,dzdo004,",
                                            "dzdocrtdt,dzdocrtdp,dzdoowndp,dzdoownid,dzdostus,dzdocrtid)",
                               " VALUES('",p_comp_id,"','",gs_revision,"','",gs_env,"','",gs_cust,"',", 
                                        "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
         END IF
         PREPARE dzdo_prep4 FROM ls_sql
         EXECUTE dzdo_prep4 USING gd_date 
         FREE dzdo_prep4

         #20140429:madey  -start-
         LET l_dzdo001 = p_comp_id
         UPDATE dzdo_t 
            SET dzdo099 = l_cdata
         #WHERE dzdo001=l_dzdo001 AND dzdo002=gs_revision AND dzdo003=gs_env      #20140922 mark
          WHERE dzdo001=l_dzdo001 AND dzdo002=gs_revision_col AND dzdo003=gs_env  #20140922 add
         #20140429:madey  -end-
      END IF
      FREE l_cdata
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzda_t 元件基本檔
# Input parameter : p_node_comp   node
#                 : p_comp_id     元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzda_t(p_node_comp,p_comp_id)
   DEFINE p_node_comp xml.DomNode,
          p_comp_id STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   DEFINE ls_desc    STRING,#元件名稱
          ls_for_db  STRING,#資料庫
          ls_purpose STRING,
          ls_dzdi003 STRING #元件多語言
   TRY
      LET ls_desc = p_node_comp.getAttribute("desc") CLIPPED
      LET ls_for_db = p_node_comp.getAttribute("for_db") CLIPPED
      LET ls_purpose = p_node_comp.getAttribute("purpose") CLIPPED

      LET ls_trigger = "sadzp040_2_update_dzda_t : check dzda_t data count"
      LET ls_sql = "SELECT count(*) FROM dzda_t",
                   " WHERE dzda001='",p_comp_id,
                    "' AND dzda003='",gs_prog,"'"
      PREPARE dzda_prep1 FROM ls_sql
      EXECUTE dzda_prep1 INTO li_cnt
      FREE dzda_prep1

      #判斷是否存在:存在就更新,不存在就新增
      IF li_cnt>0 THEN 
         LET ls_trigger = "sadzp040_2_update_dzda_t : update dzda_t data"
         LET ls_where = " WHERE dzda001='",p_comp_id,"' AND dzda003='",gs_prog,"'"
         LET ls_sql = "UPDATE dzda_t",
                        " SET dzda005='",ls_for_db,"',",
                             "dzda009='",gs_cust,"',",
                             "dzdastus='Y',",
                             "dzdamoddt=?,",
                             "dzdamodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp040_2_update_dzda_t : insert dzda_t"
         LET ls_sql = "INSERT INTO dzda_t(dzda001,dzda003,dzda005,dzda009,",
                                         "dzdacrtdt,dzdacrtdp,dzdaowndp,dzdaownid,dzdastus,dzdacrtid)",
                            " VALUES('",p_comp_id,"','",gs_prog,"','",ls_for_db,"','",gs_cust,"',",
                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzda_prep2 FROM ls_sql
      EXECUTE dzda_prep2 USING gd_date
      FREE dzda_prep2

    #更新元件多語言檔(dzdi_t) --start--
      #<desc>
      LET ls_dzdi003 = p_comp_id
      IF NOT sadzp040_2_update_dzdi_t("dzda_t","dzda001",ls_dzdi003,ls_desc) THEN
         RETURN FALSE
      END IF
      #<purpose>
      LET ls_dzdi003 = p_comp_id, ',purpose'
      IF NOT sadzp040_2_update_dzdi_t("dzda_t","dzda001",ls_dzdi003,ls_purpose) THEN
         RETURN FALSE
      END IF
    #更新元件多語言檔(dzdi_t) --end--
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzdp_t的元件版次
#                   適用於元件有異動時,須將該筆dzdp_t的元件版次set=規格版次
# Input parameter : p_comp_id       元件代號
#                   p_identify 識別碼 (PARAM_RTN / KEY_WORD ...)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdp_t(p_comp_id)
   DEFINE p_comp_id STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET ls_trigger = "sadzp040_2_update_dzdp_t : check dzdp_t new ver data count"
      LET ls_sql = "SELECT count(*) FROM dzdp_t"
      LET ls_where = " WHERE dzdp001='",gs_prog,
                         "' AND dzdp002='",gs_revision,
                         "' AND dzdp003='",p_comp_id,
                         "' AND dzdp006='",gs_identity,"'"
      LET ls_sql = ls_sql, ls_where
      PREPARE dzdp_prep1 FROM ls_sql
      EXECUTE dzdp_prep1 INTO li_cnt
      FREE dzdp_prep1

      #判斷是否存在新版資料:存在就更新,不存在就新增
      IF li_cnt>0 THEN 
         LET ls_trigger = "sadzp040_2_update_dzdp_t : update dzdp_t data"
         LET ls_sql = "UPDATE dzdp_t",
                        " SET dzdp004='",gs_revision,"',",
                             "dzdp005='",gs_erpver,"',",
                             "dzdp007='",gs_cust,"',",
                             "dzdp008='",gs_env,"',",
                             "dzdpstus='Y',",
                             "dzdpmoddt=?,",
                             "dzdpmodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp040_2_update_dzdp_t : insert new ver dzdp_t"
         LET ls_sql = "INSERT INTO dzdp_t(dzdp001,dzdp002,dzdp003,dzdp004,dzdp005,dzdp006,dzdp007,dzdp008,",
                             "dzdpcrtdt,dzdpcrtdp,dzdpowndp,dzdpownid,dzdpstus,dzdpcrtid)",
                            " VALUES('",gs_prog,"','",gs_revision,"','",p_comp_id,"','",gs_revision,"','",gs_erpver,"','",gs_env,"','",gs_cust,"','",gs_env,"',",
                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
      END IF
      PREPARE dzdp_prep2 FROM ls_sql
      EXECUTE dzdp_prep2 USING gd_date
      FREE dzdp_prep2
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新元件多語言檔dzdi_t
# INPUT parameter : p_dzdi001 檔案代碼
#                   p_dzdi002 欄位代碼
#                   p_dzdi003 KEY 值序列
#                   p_dzdi005 多語言內容
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_update_dzdi_t(p_dzdi001,p_dzdi002,p_dzdi003,p_dzdi005)
   DEFINE p_dzdi001 STRING,
          p_dzdi002 STRING,
          p_dzdi003 STRING,
          p_dzdi005 STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET ls_trigger = "sadzp040_2_update_dzdi_t : check dzdi_t data count"
      LET ls_sql = "SELECT count(*) FROM dzdi_t",
                   " WHERE dzdi001='",p_dzdi001,
                    "' AND dzdi002='",p_dzdi002,
                    "' AND dzdi003='",p_dzdi003,
                    "' AND dzdi004='",g_lang,"'" 
      PREPARE dzdi_prep1 FROM ls_sql
      EXECUTE dzdi_prep1 INTO li_cnt
      FREE dzdi_prep1

      #判斷是否存在新版資料:存在就更新,不存在就新增
      IF li_cnt>0 THEN 
         LET ls_trigger = "sadzp040_2_update_dzdi_t : update dzdi_t data"
         LET ls_where = " WHERE dzdi001='",p_dzdi001,
                         "' AND dzdi002='",p_dzdi002,
                         "' AND dzdi003='",p_dzdi003,
                         "' AND dzdi004='",g_lang,"'"
         LET ls_sql = "UPDATE dzdi_t",
                        " SET dzdi005='",p_dzdi005,"',",
                             "dzdimoddt=?,",
                             "dzdimodid='",g_user,"' ",ls_where
      ELSE
         LET ls_trigger = "sadzp040_2_update_dzdi_t : insert dzdi_t"
         LET ls_sql = "INSERT INTO dzdi_t(dzdi001,dzdi002,dzdi003,dzdi004,dzdi005,",
                                         "dzdicrtdt,dzdicrtdp,dzdiowndp,dzdiownid,dzdicrtid)",
                            " VALUES('",p_dzdi001,"','",p_dzdi002,"','",p_dzdi003,"','",g_lang,"','",p_dzdi005,"',",
                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','",g_user,"')"
      END IF
      PREPARE dzdi_prep2 FROM ls_sql
      EXECUTE dzdi_prep2 USING gd_date
      FREE dzdi_prep2
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製元件所有單身table(dzdb/dzdc/dzdd/dzdm/dzdh/dzdo)
# Input parameter : p_comp_id 元件代號
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/05/27 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_copy_body(p_comp_id)
   DEFINE p_comp_id STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   DEFINE l_dzdp004 LIKE dzdp_t.dzdp004, #元件版次
          l_dzdp008 LIKE dzdp_t.dzdp008  #元件使用標示

   #因為有異動,需要以當下的識別碼版次為基底(樹頭),複製一組dzdb/dzdc/dzdd/dzdm/dzdh/dzdo資料(樹身),
   #並將識別碼版次set=規格版次,使用標示set=gs_env, 狀態先set=disable
   #注意:樹頭在一開始簽出並下載時就已經產生了,樹身則是真的有異動時才需要產生一版新的

   TRY
      LET ls_trigger = "sadzp040_2_copy_body : copy all body table data"
      LET ls_sql = "SELECT dzdp004,dzdp008 FROM dzdp_t",
                   " WHERE dzdp001='",gs_prog,
                    "' AND dzdp002='",gs_revision,
                    "' AND dzdp003='",p_comp_id,
                    "' AND dzdp006='",gs_identity,"'"
      PREPARE dzdp_prep3 FROM ls_sql
      EXECUTE dzdp_prep3 INTO l_dzdp004,l_dzdp008
      IF SQLCA.sqlcode =0 THEN 

         IF NOT sadzp040_2_copy_dzdb_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF

         IF NOT sadzp040_2_copy_dzdc_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF

         IF NOT sadzp040_2_copy_dzdd_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF

         IF NOT sadzp040_2_copy_dzdm_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF

         IF NOT sadzp040_2_copy_dzdh_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF

         IF NOT sadzp040_2_copy_dzdo_t(p_comp_id,l_dzdp004,l_dzdp008) THEN
            RETURN FALSE
         END IF
         
      END IF
      FREE dzdp_prep3

      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY


END FUNCTION
 
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdb_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdb_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdb_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004, #20140922 mark
          p_old_revision  STRING,              #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add

      LET ls_trigger = "sadzp040_2_copy_dzdb_t : check dzdb_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdb_t"
      LET ls_where = " WHERE dzdb001='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdb006='",gs_revision,"'"
      LET ls_env_wc = " AND dzdb008='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdb_prep1 FROM ls_sql
      EXECUTE dzdb_prep1 INTO li_cnt
      FREE dzdb_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdb_t : check dzdb_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdb006='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdb008='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdb_prep2 FROM ls_sql
         EXECUTE dzdb_prep2 INTO li_cnt
         FREE dzdb_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdb_t : check dzdb_t data count:new ver=",gs_revision,",env=s"
          ##LET ls_revision_wc = " AND dzdb006='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdb008='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdb_prep5 FROM ls_sql
          ##EXECUTE dzdb_prep5 INTO li_cnt
          ##FREE dzdb_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdb006)為新版,來源(dzdb008)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdb_t : insert dzdb_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdb_t(dzdb001,dzdb002,dzdb003,dzdb004,dzdb005,",
          ##                             "dzdb006,dzdb007,dzdb008,dzdb009,",
          ##                             "dzdbcrtdt,dzdbcrtdp,dzdbowndp,dzdbownid,dzdbstus,dzdbcrtid)",
          ##                     " SELECT dzdb001,dzdb002,dzdb003,dzdb004,dzdb005,'",
          ##                              gs_revision,"',dzdb007,'c','",gs_cust,"',",
          ##                             "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                       " FROM dzdb_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdbstus='Y'"
          ##   PREPARE dzdb_prep6 FROM ls_sql
          ##   EXECUTE dzdb_prep6 USING gd_date
          ##   FREE dzdb_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdb006)為舊版,來源(dzdb008)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdb_t : insert dzdb_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdb_t(dzdb001,dzdb002,dzdb003,dzdb004,dzdb005,",
                                      "dzdb006,dzdb007,dzdb008,dzdb009,",
                                      "dzdbcrtdt,dzdbcrtdp,dzdbowndp,dzdbownid,dzdbstus,dzdbcrtid)",
                              " SELECT dzdb001,dzdb002,dzdb003,dzdb004,dzdb005,'",
                                       gs_revision,"',dzdb007,'",gs_env,"','",gs_cust,"',",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                " FROM dzdb_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdbstus='Y'"
            PREPARE dzdb_prep7 FROM ls_sql
            EXECUTE dzdb_prep7 USING gd_date
            FREE dzdb_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdb_t : update dzdb_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdb_t",
                        " SET dzdbstus='N',", 
                             "dzdbmoddt=?,", 
                             "dzdbmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdb_prep8 FROM ls_sql
         EXECUTE dzdb_prep8 USING gd_date 
         FREE dzdb_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION

 
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdc_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdc_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdc_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004, #20140922 mark
          p_old_revision  STRING,              #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add

      LET ls_trigger = "sadzp040_2_copy_dzdc_t : check dzdc_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdc_t"
      LET ls_where = " WHERE dzdc001='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdc003='",gs_revision,"'"
      LET ls_env_wc = " AND dzdc004='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdc_prep1 FROM ls_sql
      EXECUTE dzdc_prep1 INTO li_cnt
      FREE dzdc_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdc_t : check dzdc_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdc003='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdc004='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdc_prep2 FROM ls_sql
         EXECUTE dzdc_prep2 INTO li_cnt
         FREE dzdc_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdc_t : check dzdc_t data count:new ver=",gs_revision,",old env="
          ##LET ls_revision_wc = " AND dzdc003='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdc004='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdc_prep5 FROM ls_sql
          ##EXECUTE dzdc_prep5 INTO li_cnt
          ##FREE dzdc_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdc003)為新版,來源(dzdc004)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdc_t : insert dzdc_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdc_t(dzdc001,dzdc002,dzdc003,dzdc004,dzdc005,",
          ##                                   "dzdccrtdt,dzdccrtdp,dzdcowndp,dzdcownid,dzdcstus,dzdccrtid)",
          ##                           " SELECT dzdc001,dzdc002,'", gs_revision,"','c','",gs_cust,"',",
          ##                                   "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                           " FROM dzdc_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdcstus='Y'"
          ##   PREPARE dzdc_prep6 FROM ls_sql
          ##   EXECUTE dzdc_prep6 USING gd_date
          ##   FREE dzdc_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdc003)為舊版,來源(dzdc004)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdb_t : insert dzdb_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdc_t(dzdc001,dzdc002,dzdc003,dzdc004,dzdc005,",
                                            "dzdccrtdt,dzdccrtdp,dzdcowndp,dzdcownid,dzdcstus,dzdccrtid)",
                                    " SELECT dzdc001,dzdc002,'", gs_revision,"','",gs_env,"','",gs_cust,"',",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                    " FROM dzdc_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdcstus='Y'"
            PREPARE dzdc_prep7 FROM ls_sql
            EXECUTE dzdc_prep7 USING gd_date
            FREE dzdc_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdc_t : update dzdc_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdc_t",
                        " SET dzdcstus='N',", 
                             "dzdcmoddt=?,", 
                             "dzdcmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdc_prep8 FROM ls_sql
         EXECUTE dzdc_prep8 USING gd_date 
         FREE dzdc_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdd_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdd_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdd_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004, #20140922 mark
          p_old_revision  STRING,              #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add

      LET ls_trigger = "sadzp040_2_copy_dzdd_t : check dzdd_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdd_t"
      LET ls_where = " WHERE dzdd001='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdd003='",gs_revision,"'"
      LET ls_env_wc = " AND dzdd005='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdd_prep1 FROM ls_sql
      EXECUTE dzdd_prep1 INTO li_cnt
      FREE dzdd_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdd_t : check dzdd_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdd003='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdd005='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdd_prep2 FROM ls_sql
         EXECUTE dzdd_prep2 INTO li_cnt
         FREE dzdd_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdd_t : check dzdd_t data count:new ver=",gs_revision,",env=s"
          ##LET ls_revision_wc = " AND dzdd003='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdd005='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdd_prep5 FROM ls_sql
          ##EXECUTE dzdd_prep5 INTO li_cnt
          ##FREE dzdd_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdd003)為新版,來源(dzdd005)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdd_t : insert dzdd_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdd_t(dzdd001,dzdd002,dzdd003,dzdd004,dzdd005,dzdd006,",
          ##                             "dzddcrtdt,dzddcrtdp,dzddowndp,dzddownid,dzddstus,dzddcrtid)",
          ##                     " SELECT dzdd001,dzdd002,'",gs_revision,"',dzdd004,'c','",gs_cust,"',",
          ##                             "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                     " FROM dzdd_t",ls_where,ls_revision_wc,ls_env_wc," AND dzddstus='Y'"
          ##   PREPARE dzdd_prep6 FROM ls_sql
          ##   EXECUTE dzdd_prep6 USING gd_date
          ##   FREE dzdd_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdd003)為舊版,來源(dzdd005)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdd_t : insert dzdd_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdd_t(dzdd001,dzdd002,dzdd003,dzdd004,dzdd005,dzdd006,",
                                      "dzddcrtdt,dzddcrtdp,dzddowndp,dzddownid,dzddstus,dzddcrtid)",
                              " SELECT dzdd001,dzdd002,'",gs_revision,"',dzdd004,'",gs_env,"','",gs_cust,"',",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                              " FROM dzdd_t",ls_where,ls_revision_wc,ls_env_wc," AND dzddstus='Y'"
            PREPARE dzdd_prep7 FROM ls_sql
            EXECUTE dzdd_prep7 USING gd_date
            FREE dzdd_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdd_t : update dzdd_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdd_t",
                        " SET dzddstus='N',", 
                             "dzddmoddt=?,", 
                             "dzddmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdd_prep8 FROM ls_sql
         EXECUTE dzdd_prep8 USING gd_date 
         FREE dzdd_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION
 

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdm_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdm_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdm_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004,  #20140922 mark
          p_old_revision  STRING,               #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add

      LET ls_trigger = "sadzp040_2_copy_dzdm_t : check dzdm_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdm_t"
      LET ls_where = " WHERE dzdm001='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdm010='",gs_revision,"'"
      LET ls_env_wc = " AND dzdm011='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdm_prep1 FROM ls_sql
      EXECUTE dzdm_prep1 INTO li_cnt
      FREE dzdm_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdm_t : check dzdm_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdm010='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdm011='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdm_prep2 FROM ls_sql
         EXECUTE dzdm_prep2 INTO li_cnt
         FREE dzdm_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdm_t : check dzdm_t data count:new ver=",gs_revision,",env=s"
          ##LET ls_revision_wc = " AND dzdm010='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdm011='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdm_prep5 FROM ls_sql
          ##EXECUTE dzdm_prep5 INTO li_cnt
          ##FREE dzdm_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdm010)為新版,來源(dzdm011)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdm_t : insert dzdm_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdm_t(dzdm001,dzdm002,dzdm003,dzdm004,dzdm005,",
          ##                             "dzdm006,dzdm007,dzdm009,dzdm010,dzdm011,dzdm008,",
          ##                             "dzdmcrtdt,dzdmcrtdp,dzdmowndp,dzdmownid,dzdmstus,dzdmcrtid)",
          ##                     " SELECT dzdm001,dzdm002,dzdm003,dzdm004,dzdm005,",
          ##                             "dzdm006,dzdm007,dzdm009,'", gs_revision,"','c','",gs_cust,"',",
          ##                             "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                       " FROM dzdm_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdmstus='Y'"
          ##   PREPARE dzdm_prep6 FROM ls_sql
          ##   EXECUTE dzdm_prep6 USING gd_date
          ##   FREE dzdm_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdm010)為舊版,來源(dzdm011)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdb_t : insert dzdb_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdm_t(dzdm001,dzdm002,dzdm003,dzdm004,dzdm005,",
                                      "dzdm006,dzdm007,dzdm009,dzdm010,dzdm011,dzdm008,",
                                      "dzdmcrtdt,dzdmcrtdp,dzdmowndp,dzdmownid,dzdmstus,dzdmcrtid)",
                              " SELECT dzdm001,dzdm002,dzdm003,dzdm004,dzdm005,",
                                      "dzdm006,dzdm007,dzdm009,'", gs_revision,"','",gs_env,"','",gs_cust,"',",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                " FROM dzdm_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdmstus='Y'"
            PREPARE dzdm_prep7 FROM ls_sql
            EXECUTE dzdm_prep7 USING gd_date
            FREE dzdm_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdm_t : update dzdm_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdm_t",
                        " SET dzdmstus='N',", 
                             "dzdmmoddt=?,", 
                             "dzdmmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdm_prep8 FROM ls_sql
         EXECUTE dzdm_prep8 USING gd_date 
         FREE dzdm_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION
 

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdh_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdh_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdh_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004,  #20140922 mark
          p_old_revision  STRING,               #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add
      
      LET ls_trigger = "sadzp040_2_copy_dzdh_t : check dzdh_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdh_t"
      LET ls_where = " WHERE dzdh003='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdh004='",gs_revision,"'"
      LET ls_env_wc = " AND dzdh005='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdh_prep1 FROM ls_sql
      EXECUTE dzdh_prep1 INTO li_cnt
      FREE dzdh_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdh_t : check dzdh_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdh004='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdh005='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdh_prep2 FROM ls_sql
         EXECUTE dzdh_prep2 INTO li_cnt
         FREE dzdh_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdh_t : check dzdh_t data count:new ver=",gs_revision,",env=s"
          ##LET ls_revision_wc = " AND dzdh004='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdh005='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdh_prep5 FROM ls_sql
          ##EXECUTE dzdh_prep5 INTO li_cnt
          ##FREE dzdh_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdh004)為新版,來源(dzdh005)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdh_t : insert dzdh_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdh_t(dzdh001,dzdh002,dzdh003,dzdh004,dzdh005,dzdh006,",
          ##                             "dzdhcrtdt,dzdhcrtdp,dzdhowndp,dzdhownid,dzdhstus,dzdhcrtid)",
          ##                     " SELECT dzdh001,dzdh002,dzdh003,'",gs_revision,"','c','",gs_cust,"',",
          ##                             "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                       " FROM dzdh_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdhstus='Y'"
          ##   PREPARE dzdh_prep6 FROM ls_sql
          ##   EXECUTE dzdh_prep6 USING gd_date
          ##   FREE dzdh_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdh004)為舊版,來源(dzdh005)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdh_t : insert dzdh_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdh_t(dzdh001,dzdh002,dzdh003,dzdh004,dzdh005,dzdh006,",
                                      "dzdhcrtdt,dzdhcrtdp,dzdhowndp,dzdhownid,dzdhstus,dzdhcrtid)",
                              " SELECT dzdh001,dzdh002,dzdh003,'",gs_revision,"','",gs_env,"','",gs_cust,"',",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                " FROM dzdh_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdhstus='Y'"
            PREPARE dzdh_prep7 FROM ls_sql
            EXECUTE dzdh_prep7 USING gd_date
            FREE dzdh_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdh_t : update dzdh_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdh_t",
                        " SET dzdhstus='N',", 
                             "dzdhmoddt=?,", 
                             "dzdhmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdh_prep8 FROM ls_sql
         EXECUTE dzdh_prep8 USING gd_date 
         FREE dzdh_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzdo_t
# Input parameter : p_comp_id      元件代號
#                   p_old_revision 元件版次 
#                   p_old_env      元件使用標示
# Return code     : BOOLEAN        執行成功:TRUE,執行失敗:FALSE
# Date & Author   : 2014/02/08 by madey
##########################################################################
#PRIVATE FUNCTION sadzp040_2_copy_dzdo_t(p_comp_id,p_old_revision)
PRIVATE FUNCTION sadzp040_2_copy_dzdo_t(p_comp_id,p_old_revision,p_old_env)
   DEFINE p_comp_id       LIKE dzdp_t.dzdp003,
         #p_old_revision  LIKE dzdp_t.dzdp004,   #20140922 mark
          p_old_revision  STRING,                #20140922 add
          p_old_env       LIKE dzdp_t.dzdp008
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   TRY
      LET p_old_revision = p_old_revision.trim() #20140922 add

      LET ls_trigger = "sadzp040_2_copy_dzdo_t : check dzdo_t data count:new ver=",gs_revision,",env=",gs_env
      LET ls_sel = "SELECT count(*) FROM dzdo_t"
      LET ls_where = " WHERE dzdo001='",p_comp_id,"'"
      LET ls_revision_wc = " AND dzdo002='",gs_revision,"'"
      LET ls_env_wc = " AND dzdo003='",gs_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzdo_prep1 FROM ls_sql
      EXECUTE dzdo_prep1 INTO li_cnt
      FREE dzdo_prep1

      #判斷是否存在資料,不存在就複製有效的資料.存在就將status先設為N,統一於update資料時在回寫為Y
      IF li_cnt=0 THEN 
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp040_2_copy_dzdo_t : check dzdo_t data count:old ver=",p_old_revision,",old env=",p_old_env
         LET ls_revision_wc = " AND dzdo002='",p_old_revision,"'"
         LET ls_env_wc = " AND dzdo003='",p_old_env,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdo_prep2 FROM ls_sql
         EXECUTE dzdo_prep2 INTO li_cnt
         FREE dzdo_prep2
         IF li_cnt=0 THEN
          ###再找不到,則找新版次屬於標準(s)的資料:這段是為了客製所做的判斷
          ##LET ls_trigger = "sadzp040_2_copy_dzdo_t : check dzdo_t data count:new ver=",gs_revision,",env=s"
          ##LET ls_revision_wc = " AND dzdo002='",gs_revision,"'"
          ##LET ls_env_wc = " AND dzdo003='s'"
          ##LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
          ##PREPARE dzdo_prep5 FROM ls_sql
          ##EXECUTE dzdo_prep5 INTO li_cnt
          ##FREE dzdo_prep5
          ##IF li_cnt>0 THEN
          ##   #找到標準新版就複製為客製新版,且全部為失效:版次(dzdo002)為新版,來源(dzdo003)為標準 #這段新增和下面雷同
          ##   LET ls_trigger = "sadzp040_2_copy_dzdo_t : insert dzdo_t:new ver=",gs_revision,",env:s to c"
          ##   LET ls_sql = "INSERT INTO dzdo_t(dzdo001,dzdo002,dzdo003,dzdo099,dzdo004,",
          ##                             "dzdocrtdt,dzdocrtdp,dzdoowndp,dzdoownid,dzdostus,dzdocrtid)",
          ##                     " SELECT dzdo001,'",gs_revision,"','c',dzdo099,'",gs_cust,"',",
          ##                             "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
          ##                       " FROM dzdo_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdostus='Y'"
          ##   PREPARE dzdo_prep6 FROM ls_sql
          ##   EXECUTE dzdo_prep6 USING gd_date
          ##   FREE dzdo_prep6
          ##ELSE #再找不到新版標準,後續update段會處理
          ##END IF
         ELSE
            #找到舊版就複製為新版,且全部為失效:版次(dzdo002)為舊版,來源(dzdo003)和gs_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp040_2_copy_dzdb_t : insert dzdb_t:old ver=",p_old_revision," to new ver=",gs_revision
            LET ls_sql = "INSERT INTO dzdo_t(dzdo001,dzdo002,dzdo003,dzdo099,dzdo004,",
                                      "dzdocrtdt,dzdocrtdp,dzdoowndp,dzdoownid,dzdostus,dzdocrtid)",
                              " SELECT dzdo001,'",gs_revision,"','",gs_env,"',dzdo099,'",gs_cust,"',",
                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                " FROM dzdo_t",ls_where,ls_revision_wc,ls_env_wc," AND dzdostus='Y'"
            PREPARE dzdo_prep7 FROM ls_sql
            EXECUTE dzdo_prep7 USING gd_date
            FREE dzdo_prep7
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp040_2_copy_dzdo_t : update dzdo_t status='N':new ver=",gs_revision,",env=",gs_env
         LET ls_sql = "UPDATE dzdo_t",
                        " SET dzdostus='N',", 
                             "dzdomoddt=?,", 
                             "dzdomodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzdo_prep8 FROM ls_sql
         EXECUTE dzdo_prep8 USING gd_date 
         FREE dzdo_prep8
      END IF
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE

   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得節點的CDATA資料.
# Input parameter : pnode_target 目標節點
# Return code     : CDATA資料
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_get_cdata(pnode_target)
   DEFINE pnode_target xml.DomNode
   DEFINE lnode_cdata xml.DomNode,
          ls_value STRING
  
   LET ls_value =''
   LET lnode_cdata = pnode_target.getFirstChild() 
   WHILE (lnode_cdata IS NOT NULL)
      IF lnode_cdata.getNodeType() == "CDATA_SECTION_NODE" THEN
         LET ls_value = lnode_cdata.getNodeValue()
         RETURN ls_value
      END IF   
      LET lnode_cdata = lnode_cdata.getNextSibling()
   END WHILE
   RETURN ls_value
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : none
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
  #Begin:
  #IF SQLCA.SQLCODE THEN
  #   CALL cl_err_msg(p_trigger, "adz-00002", p_sql, 0)
  #ELSE
  #   CALL cl_err_msg(p_trigger, "adz-00002", NULL, 0)
  #END IF
  #End:
END FUNCTION

 
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新設計資料為失效.
# Input parameter : p_table 要更新的Table
#                   p_where WHERE條件
#                   p_env_col 使用標示欄位 (不給值代表該table沒有使用標示欄位)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/08 by madey
##########################################################################
PRIVATE FUNCTION sadzp040_2_disable_status(p_table, p_where, p_env_col)
   DEFINE p_table STRING,
          p_where STRING,
          p_env_col STRING
   DEFINE ls_col_pre STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 

   TRY
      LET ls_trigger = "sadzp040_2_disable_status : check ",p_table," data count"
      LET ls_sql = "SELECT count(*) FROM ",p_table,p_where
      PREPARE chk_prep1 FROM ls_sql
      EXECUTE chk_prep1 INTO li_cnt
      FREE chk_prep1

      IF li_cnt>0 THEN #資料存在就更新為失效
         LET ls_trigger = "sadzp040_2_disable_status : update ",p_table," data status"
         LET ls_col_pre = p_table.subString(1, p_table.getLength()-2)
         IF not cl_null(p_env_col) THEN 
            LET ls_sql = "UPDATE ",p_table,
                           " SET ",p_env_col,"='",gs_env,"',",
                                   ls_col_pre,"stus='N',",
                                   ls_col_pre,"moddt=?,",
                                   ls_col_pre,"modid='",g_user,"' ",p_where
         ELSE
            LET ls_sql = "UPDATE ",p_table,
                           " SET ",ls_col_pre,"stus='N',",
                                   ls_col_pre,"moddt=?,",
                                   ls_col_pre,"modid='",g_user,"' ",p_where
         END IF
         PREPARE upd_prep2 FROM ls_sql
         EXECUTE upd_prep2 USING gd_date
         FREE upd_prep2
      END IF   
      RETURN TRUE

   CATCH 
      CALL sadzp040_2_err_catch(ls_trigger, ls_sql)
      RETURN FALSE

   END TRY
END FUNCTION


############################################################################
### Access Modifier : PRIVATE
### Descriptions    : 取得目前最大版次
### Input parameter : p_table 要讀取的Table
###                   p_col   版次欄位
###                   p_where WHERE條件
### Return code     : STRING (執行成功:,執行失敗:FALSE)
###                   STRING (版次   執行成功: 有抓到資料:目前最大版次
###                                            沒有抓到資料:規格版次
###                                  執行失敗: null )
### Date & Author   : 2014/02/24 by madey
############################################################################
##PRIVATE FUNCTION sadzp040_2_get_current_reversion(p_table, p_col, p_where)
##   DEFINE p_table STRING,
##          p_col STRING,
##          p_where STRING 
##   DEFINE ls_col_pre STRING
##   DEFINE ls_sql STRING,
##          ls_trigger STRING,
##          ls_max_reversion  LIKE dzaa_t.dzaa002
##          
##
##   TRY
##      #此處where條件不帶使用標示,至於是s或c有copy_xxxx_t用統一規則抓取,
##      #若原本有1s,1c ,g_revision=2時,不管現在環境是s或c,max正確為1
##      #若原本有1s,1c,2s ,g_revision=2時,環境是s,max正確為2;環境是c,max正確為1
##      LET ls_max_reversion =''
##      LET ls_trigger = "sadzp040_2_get_current_reversion : get ",p_table," max revision"
##      LET ls_sql = "SELECT MAX(",p_col,") FROM ",p_table,p_where
##      PREPARE chk_prep2 FROM ls_sql
##      EXECUTE chk_prep2 INTO ls_max_reversion
##      FREE chk_prep2
##
##      IF NOT cl_null(ls_max_reversion) THEN #資料存在就回傳最大值,不存在就回傳gs_revision
##         RETURN  ls_max_reversion
##      ELSE 
##         RETURN  gs_revision
##      END IF
##
##   CATCH 
##      CALL sadzp040_2_err_catch(ls_trigger, ls_sql)
##      RETURN  ''
##
##   END TRY
##END FUNCTION






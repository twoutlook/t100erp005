#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/10/12
#
#+ 程式代碼......: sadzp060_1
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp060_1.4gl
# Description    : 更新規格檔,多語言檔,add point,元件等資料
# Memo           : 1.設計資料(dzab_t,dzac_t,dzad_t,dzae_t,dzai_t,dzaj_t,dzak_t,dzal_t)不需要設定失效,這是類似resource pool,只是給人取用而已.
#                : 2.設計資料樹(dzaa_t,dzag_t,dzfs_t,dzff_t,dzba_t)會有失效狀態,這可避免以後上Patch比對的問題,例如客戶已經決定不用某個欄位,結果我們又幫客戶補上此欄位.
#                : 2013/12/31前的更新紀錄刪除...
#                : 2014/01/06 by Hiko : 因應行業別調整:1.dzaa_t增加dzaa007,dzaa008.
#                                                      2.資源池的Table移除'引用'的相關欄位.
#                                                      3.tsd內cite_std改成更新dzaa007,並移除cite_ver.
#                                                      4.排除設定(dzam_t)與Table設定(dzag_t)不能引用,行業別自己儲存一份,以免出現其他問題.
#                                                      5.dzff008改成PK,<tree>的src和status改在頭的tag,且dzaa003改成tree name(不為固定"TREE").
#                : 2014/01/15 by Hiko : 將設計資料回寫adzi150,包含欄位規格,程式串查(dzep_t),欄位參考(dzef_t),資料多語言(dzer_t)
#                : 2014/01/21 by Hiko : 因應UI關聯進階設定調整 
#                : 2014/01/23 by Hiko : 調整還原預設設計資料出現錯誤時,不影響上傳流程.
#                : 2014/02/10 by Hiko : 增加程式串查型態(dzal007)
#                : 2014/02/12 by Hiko : 新增<other>(dzax_t)
#                : 2014/02/13 by Hiko : 新增<section>(dzbc_t,dzbd_t)
#                : 2014/02/24 by Hiko : 增加dzax004(是否要產生程式)的更新
#                : 2014/03/06 by Hiko : 1.修改助記碼(dzak_t)
#                                       2.防呆措施
#                : 2014/03/11 by Hiko : 為了提升執行效能,將getFirstChild改成getFirstChildElement,getNextSibling改成getNextSiblingElement,並移除tag name的判斷
#                : 2014/03/12 by Hiko : 若為FreeStyle或是排除控件,則不用防呆.#因為有可能要自己加工,所以防呆功能全部先移除.
#                : 2014/03/14 by Hiko : 修改程式串查(dzal_t)的格式
#                : 2014/03/17 by Hiko : 助記碼(dzak_t),程式串查(dzal_t)的版次一定和欄位規格(dzac_t)相同
#                : 2014/03/19 by Hiko : 修正排除設定更新的問題
#                : 2014/03/20 by Hiko : 修正TABLE設定更新的問題
#                : 2014/03/24 by Hiko : 更新tsd後要重新產生多語言檔
#                : 2014/03/25 by Hiko : 修正EXCLUDE與TABLE的問題
#                : 2014/03/26 by Hiko : 修正SECTION更新的問題
#                : 2014/04/03 by Hiko : 移除comment的更新(因為和text相同作法)
#                : 2014/04/10 by Hiko : 1.上傳不檢查程式是否失效,因為沒有關係.
#                                       2.增加更新報表元件規格(rsd)的程式段
#                : 2014/04/11 by Hiko : 1.增加報表樣版(4RP)上傳的檢查.
#                                       2.調整SECTION的修改:若為產中修改,則使用標示為'm';若為客製修改,則使用標示為'c'.
#                : 2014/04/17 by Hiko : 調整GCODE的權限檢查
#                : 2014/04/23 by Hiko : 行業別引用改採用類似複製的動作(產生行業別程式會處理),所以這裡只要是'u'就更新即可.
#                : 2014/04/28 by Hiko : 行業別引用標準時,還是要重新取得對應的標準內容來覆蓋,可避免被Client端對應的舊標準規格/程式上傳後又覆蓋為舊的資料.
#                : 2014/04/30 by Hiko : 1.只要SECTION有m的,則樣版調整後,整個程式都不會更新,因此有可能tgl會比add point多,此時設計器會幫忙建立此多出來的SECTION,並給m,上傳時就要新增.
#                                       2.增加dzad007(產生標準程式)
#                : 2014/05/06 by Hiko : 行業別有可能斷開後又引用,因此要再度取得標準內容,這是因為有可能標準會同步到行業主機,而當下Local端的標準是舊的,此時當設定為引用時,會以Local端的內容更新到Server,這就造成錯誤了.
#                : 2014/05/22 by Hiko : 行業別取得標準最大版次修改
#                : 2014/05/27 by Hiko : 1.因應二次開發調整:dzaa009(PK),dzba010(PK),dzbc007(PK)
#                                       2.所有Table都加上'客戶代號'
#                                       3.<other>(dzax_t)改在tap更新
#                                       4.更新資料最後要重建.read檔
#                : 2014/05/29 by Hiko : 1.因應PK調整:dzag006,dzfs005,dzam005,並增加dzag012,dzfs012,dzam002的賦值設定
#                                       2.dzag_t,dzfs_t,dzam_t取得舊版次的方式改成呼叫sadzp060_1_get_spec_element_curr_revision()
#                                       3.dzbc_t取得舊版次的方式改成呼叫sadzp060_1_get_section_curr_revision()
#                : 2014/06/06 by Hiko : 調整sadzp060_1_get_spec_element_curr_revision的取得方式,不需要識別碼類型當作條件.
#                : 2014/06/10 by Hiko : dzax_t增加dzax006(PK)
#                : 2014/06/13 by Hiko : 下載時,不論是否簽出都是重產,因此上傳的時候就不用重做,可以避免各情境同步的問題.
#                : 2014/07/02 by madey: <other>(dzax_t)在tsd也更新
#                : 2014/07/09 by Hiko : 程式串查單頭的控制在設計器是和依附控件分開的,dzal_t異動,不見得dzac_t也會異動,所以更新dzal_t時,要連dzac_t一起更新;
#                                       但刪除dzal_t的時候不需要也刪除dzac_t.
#                : 2014/08/05 by Hiko : 同一個版次的status要完整呈現u和d
#                : 2014/08/25 by Hiko : 1.行業程式的更新一率以設計資料為主,這樣才不會雞同鴨講;標準改了是透過另外的工具同步.
#                                       2.將設計資料回寫adzi150,包含欄位規格,程式串查(dzep_t),欄位參考(dzef_t),資料多語言(dzer_t)的功能移除
#                                       3.dzac006(欄位屬性),dzac007(資料型態)不再更新,改以r.t的設定為主,這樣Patch就不會有問題了.
#                : 2014/09/01 by Hiko : 不需要重產42s,r.f會做
#                : 2014/09/15 by Hiko : 1.dzaastus的失效也需要新增(因為要保留本版次的修改歷程).
#                                       2.dzax004要更新
#                : 2014/09/22 by Hiko : 1.先做d,再做u,這樣才不會出錯
#                                       2.因應版次型態改變而調整
#                                       3.還原4/30新增SECTION的程式段,SECTION不可能可以透過設計器產生,所以一定是過程出了問題
#                : 2014/09/30 by Hiko : SECTION會新增,但只局限於標準變客製的情況(s-->m or s-->c)
#                : 2014/10/03 by Hiko : 增加dzax007(接收參數起始順序)
#                : 2014/10/24 by Hiko : 上傳還是需要要重產42s,因為想要規格上傳馬上就看結果
#                : 2014/12/05 by Hiko : 將dzac015(最大值)拆解成dzac020+dzac015,dzac016(最小值)拆解成dzac021+dzac016.
#                : 2014/12/16 by Hiko : 將gs_upd_ver還原成g_revision.
#                : 2014/12/22 by Hiko : topstd可以簽出c1的規格,程式則不限版次:
#                                       1.客製標示的資料不能異動.
#                                       2.更新版次就以離線檔內的ver為主;若為新增,則版次固定為1.
#                                       3.客製標示固定s.
#                                       4.移除gb_industry的程式段,這樣比較乾淨.
#                                       5.移除更新adzp150(dzep_t,dzef_t,dzer_t,dzet_t)的程式段,這樣比較乾淨.
#                                       6.移除重產.read的程式段,這樣比較乾淨.
#                                       7.更新dzac_t要同時複製dzak_t/dzal_t.
#                                       8.更新dzak_t/dzal_t不需要同時異動dzac_t的情況.
#                                       9.dzak_t/dzal_t不需要處理d的情況,因為dzac_t一定是d.
#                : 2014/12/29 by Hiko : dzag_t增加三個欄位:dzag013,dzag014,dzag015
#                : 2014/12/30 by Hiko : 更正update_dzal_t的bug
#                : 2015/01/14 by Hiko : 避免ROLLBACK出錯,所以增加lb_trans來當作判斷依據
#                : 2015/03/12 by Hiko : 修改更新字串的的錯誤
#                : 2015/04/10 by Hiko : 還原'9.dzak_t/dzal_t不需要處理d的情況,因為dzac_t一定是d'的段落,因為有可能真的只是刪除單頭的程式串查.
#                : 2015/07/03 by Hiko : 上傳要重產.read檔,讓未簽出的人可以取得最新檔.
#                : 2015/08/03 by Hiko : 1.修正dzam_t在topstd才設定排除的問題.
#                                       2.就算是topstd也以同樣的邏輯來更新.(不長版次指的是規格不長版次, 識別碼版次就回歸正常方式處理即可.)
#                : 2015/11/11 by Hiko : 1.topstd版次賦予調整:若找到舊版次,則以舊版次為主;若找不到,則以當下版次為主(和正常賦予方式相同)
#                                       2.copy dzag_t增加條件
#                : 2015/11/09 by Hiko : 上傳規格要將程式重產flag(dzay005)更新為Y.
#                : 2015/12/21 by Hiko : 更新dzax_t時,也要將程式重產flag(dzay005)更新為Y.
#                : 20161215 161215-00053 by Hiko : menu.output/menu.after_output在標準環境要同步到menu.quickprint/menu.after_quickprint.

import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE g_env LIKE dzaa_t.dzaa009 #辨識目前所在的環境:s.產中環境,c.客製環境
DEFINE GS_DGENV STRING #2015/11/11 by Hiko
DEFINE g_date DATETIME YEAR TO SECOND
DEFINE g_revision LIKE dzaf_t.dzaf002 #規格異動版次/程式異動版次
DEFINE g_head_ver LIKE dzaf_t.dzaf002 #規格樹頭版次/程式樹頭版次 #2014/12/22 by Hiko:for topstd
#因為g_dept是char 10,就算設定為NULL,進入資料庫前還是得CLIPPED才不會變成一個空白,所以STRING來承接.
DEFINE gs_dept STRING, 
       gs_erpver STRING, #ERP大版版號
       gs_module STRING,
       gs_identity STRING, #2014/05/27 by Hiko:gs_identity是外部傳入的,有可能和DGENV不同.
       gs_customer STRING  #2014/05/27 by Hiko
DEFINE gs_prog LIKE dzaa_t.dzaa001
#Begin:2014/01/21 by Hiko
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
#End:2014/01/21 by Hiko
#Begin:2014/04/28 by Hiko
DEFINE gb_industry BOOLEAN,
       gs_std_prog STRING,
       ga_std_dzaa DYNAMIC ARRAY OF RECORD LIKE dzaa_t.*,
       ga_std_dzba DYNAMIC ARRAY OF RECORD LIKE dzba_t.*
#End:2014/04/28 by Hiko
#DEFINE glst_field XML.DomNodeList #2014/07/09 by Hiko #2014/12/22 by Hiko

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 初始化變數.
# Input parameter : none
# Return code     : void
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_init_var()
   DEFINE ls_trigger STRING

   TRY
      LET ls_trigger = "sadzp060_1_init_var"
      #Begin:2015/11/11 by Hiko
      #LET g_env = FGL_GETENV("DGENV") CLIPPED
      LET GS_DGENV = FGL_GETENV("DGENV") CLIPPED
      LET g_env = GS_DGENV
      #End:2015/11/11 by Hiko
      LET g_date = cl_get_current()
      LET gs_dept = g_dept CLIPPED
      LET gs_erpver = FGL_GETENV("ERPVER") CLIPPED
      LET gs_customer = FGL_GETENV("CUST") CLIPPED
      
     #DISPLAY "Hiko:g_user=",g_user,"<<"
     #DISPLAY "Hiko:g_account=",g_account,"<<"
     #DISPLAY "Hiko:g_lang=",g_lang,"<<"

      DISPLAY "call sadzp060_1_init_var finish"

      RETURN TRUE
   CATCH
      CALL sadzp060_1_err_catch(ls_trigger, NULL)
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 更新tsd檔對應的資料表
# Input parameter : p_prog 程式代號
#                 : p_module 模組別
#                 : p_identity 識別標示(s/c)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_1_update_tsd(p_prog, p_module, p_identity)
   DEFINE p_prog STRING,
          p_module STRING,
          p_identity STRING
   DEFINE ls_module_dir STRING #模組目錄
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING 
   DEFINE ls_tsd STRING, #tsd檔路徑
          ldoc_tsd xml.DomDocument,
          lnode_tsd xml.DomNode,
          lnode_child xml.DomNode, 
          ls_tag_name STRING,
          ls_status STRING 
   DEFINE lnode_field xml.DomNode, 
          lb_result BOOLEAN
   #Begin:2014/03/12 by Hiko
   DEFINE lst_node xml.DomNodeList,
          li_i SMALLINT,
          ls_code_template STRING,
          ls_normal_style STRING
   #End:2014/03/12 by Hiko
   #Begin:2014/03/24 by Hiko 重新產生多語言檔
   DEFINE ls_run_cmd STRING,
          lb_run_result BOOLEAN,
          ls_err_msg STRING,
          lb_result2 BOOLEAN,
          lb_trans   BOOLEAN #2015/01/14 by Hiko
   #End:2014/03/24 by Hiko
   DEFINE ls_std_revision STRING, #2014/04/28 by Hiko
          ls_std_identity STRING  #2014/05/15 by Hiko
   DEFINE lst_other XML.DomNodeList, #20140702 by madey
          lnode_other XML.DomNode    #20140702 by madey

   LET gs_prog = p_prog.trim()
   LET gs_module = p_module.toUpperCase()
   LET gs_identity = p_identity.trim()

   IF NOT sadzp060_1_init_var() THEN
      RETURN FALSE
   END IF

   LET lb_result = TRUE
   LET lb_result2 = TRUE

   TRY
      DISPLAY "call sadzp060_1_update_tsd start!"

      #取得tsd檔.
      LET ls_module_dir = FGL_GETENV(gs_module) CLIPPED
      LET ls_tsd = os.path.join(os.path.join(os.path.join(ls_module_dir, "dzx"), "tsd"), gs_prog||".tsd")
      LET ldoc_tsd = xml.domDocument.create()
      LET ls_trigger = "sadzp060_1_update_tsd : load tsd=",ls_tsd
      IF NOT os.Path.exists(ls_tsd) THEN
         DISPLAY "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00175", g_lang), gs_prog||".tsd")
         RETURN FALSE
      END IF
      CALL ldoc_tsd.load(ls_tsd)
      LET lnode_tsd = ldoc_tsd.getDocumentElement()

      #Begin:2015/07/03 by Hiko
      LET ls_tsd = ls_tsd,".read"
      CALL lnode_tsd.setAttribute("booking", "N")
      IF NOT sadzp010_1_create_read_file(ldoc_tsd, ls_tsd) THEN
         RETURN FALSE
      END IF
      #End:2015/07/03 by Hiko

      #LET glst_field = ldoc_tsd.getElementsByTagName("field") #2014/07/09 by Hiko:在更新程式串查時可以使用 #2014/12/22 by Hiko

      #Begin:2014/03/12 by Hiko
      LET lb_trans = FALSE
      BEGIN WORK #非常重要.
      LET lb_trans = TRUE

      LET g_revision = lnode_tsd.getAttribute("ver") CLIPPED
      LET g_head_ver = g_revision #2014/12/22 by Hiko
  
      CALL sadzp060_2_set_regen(gs_prog, 'Y') #2015/11/09 by Hiko

      #20140702 by madey :更新<other>
      LET lst_other = lnode_tsd.getElementsByTagName("other")
      LET lnode_other = lst_other.getItem(1) #目前只有一個other
      DISPLAY "sadzp060_1_update_tsd : sadzp060_1_update_dzax_t"
      CALL sadzp060_1_update_dzax_t(lnode_other) RETURNING lb_result 
      IF NOT lb_result THEN
         ROLLBACK WORK #非常重要.
         RETURN FALSE
      END IF
      DISPLAY "call sadzp060_1_update_dzax_t finish"

      LET lst_node = lnode_tsd.getElementsByTagName("exclude")
      LET lnode_child = lst_node.getItem(1) #目前只有一個exclude
      LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzam_t"
      CALL sadzp060_1_update_dzam_t(lnode_child) RETURNING lb_result
      IF NOT lb_result THEN
         ROLLBACK WORK #非常重要.
         RETURN FALSE
      END IF
      DISPLAY "call sadzp060_1_update_dzam_t finish"
      #End:2014/03/12 by Hiko

      #2014/09/22 by Hiko:先做d
      LET lnode_child = lnode_tsd.getFirstChildElement()
      WHILE (lnode_child IS NOT NULL)
         LET ls_tag_name = lnode_child.getLocalName()
         LET ls_status = lnode_child.getAttribute("status")
         IF ls_status.equals("d") THEN #2014/09/22 by Hiko
            CASE ls_tag_name
               #2014/09/22 by Hiko : all,mi_all,db_all,di_all不會有d的情況,所以這邊就不多做了.
               WHEN "field"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzac_t"
                  CALL sadzp060_1_update_dzac_t(lnode_child, "d") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzac_t finish"
               WHEN "act"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzad_t"
                  CALL sadzp060_1_update_dzad_t(lnode_child, "d") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzad_t finish"
               WHEN "tree" 
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzff_t"
                  CALL sadzp060_1_update_dzff_t(lnode_child, "d") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzff_t finish"
            END CASE
         END IF #IF NOT cl_null(ls_status)

         #底下tag因為都有子節點,所以另外判斷.
         CASE ls_tag_name 
            #2014/09/22 by Hiko : table和strings不會和其他控件衝突,所以只需要在第一次的迴圈做完即可.
            WHEN "table" 
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzag_t"
               CALL sadzp060_1_update_dzag_t(lnode_child) RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzag_t finish"
            WHEN "ref_field" 
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzai_t"
               CALL sadzp060_1_update_dzai_t(lnode_child, "d") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzai_t finish"
            WHEN "multi_lang" 
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzaj_t"
               CALL sadzp060_1_update_dzaj_t(lnode_child, "d") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzaj_t finish"
            #Begin:2014/12/22 by Hiko #2015/04/10 by Hiko:還原此段
            WHEN "help_code" #依據正常情況,dzac_t有異動,應該要順便異動dzak_t,但設計器會同時設定狀態,所以就分開處理,也是達到相同目的.
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzak_t"
               CALL sadzp060_1_update_dzak_t(lnode_child, "d") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzak_t finish"
            WHEN "prog_rel" #與dzac_t的關係同dzak_t
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzal_t"
               CALL sadzp060_1_update_dzal_t(lnode_child, "d") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzal_t finish"
            #End:2014/12/22 by Hiko
            WHEN "strings"
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_str"
               CALL sadzp060_1_update_str(lnode_child) RETURNING lb_result2 #2014/03/24 by Hiko:多語言更新失敗對於產生程式沒有影響
               DISPLAY "call sadzp060_1_update_str finish"
         END CASE

         IF NOT lb_result THEN
            ROLLBACK WORK #非常重要.
            RETURN FALSE
         END IF

         LET lnode_child = lnode_child.getNextSiblingElement() #取得tsd檔下一個子節點
      END WHILE

      #Begin:2014/09/22 by Hiko:再做u
      LET lnode_child = lnode_tsd.getFirstChildElement()
      WHILE (lnode_child IS NOT NULL)
         LET ls_tag_name = lnode_child.getLocalName()
         LET ls_status = lnode_child.getAttribute("status")
         #IF NOT cl_null(ls_status) THEN
         IF ls_status.equals("u") THEN #2014/09/22 by Hiko
            CASE ls_tag_name
               WHEN "all"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzab_t"
                  CALL sadzp060_1_update_dzab_t(lnode_child, "u", "ALL") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzab_t finish"
               WHEN "mi_all" 
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzab_t"
                  CALL sadzp060_1_update_dzab_t(lnode_child, "u", "MI_ALL") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzab_t finish"
               WHEN "db_all"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzab_t"
                  CALL sadzp060_1_update_dzab_t(lnode_child, "u", "DB_ALL") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzab_t finish"
               WHEN "di_all"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzab_t"
                  CALL sadzp060_1_update_dzab_t(lnode_child, "u", "DI_ALL") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzab_t finish"
               WHEN "field"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzac_t"
                  CALL sadzp060_1_update_dzac_t(lnode_child, "u") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzac_t finish"
               WHEN "act"
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzad_t"
                  CALL sadzp060_1_update_dzad_t(lnode_child, "u") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzad_t finish"
               WHEN "tree" 
                  LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzff_t"
                  CALL sadzp060_1_update_dzff_t(lnode_child, "u") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzff_t finish"
            END CASE
         END IF #IF NOT cl_null(ls_status)

         #底下tag因為都有子節點,所以另外判斷.
         CASE ls_tag_name 
            #2014/09/22 by Hiko : table和strings不會和其他控件衝突,所以只需要在第一次的迴圈做完即可.
            WHEN "ref_field" 
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzai_t"
               CALL sadzp060_1_update_dzai_t(lnode_child, "u") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzai_t finish"
            WHEN "multi_lang" 
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzaj_t"
               CALL sadzp060_1_update_dzaj_t(lnode_child, "u") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzaj_t finish"
            WHEN "help_code" #依據正常情況,dzac_t有異動,應該要順便異動dzak_t,但設計器會同時設定狀態,所以就分開處理,也是達到相同目的.
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzak_t"
               CALL sadzp060_1_update_dzak_t(lnode_child, "u") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzak_t finish"
            WHEN "prog_rel" #與dzac_t的關係同dzak_t
               LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzal_t"
               CALL sadzp060_1_update_dzal_t(lnode_child, "u") RETURNING lb_result
               DISPLAY "call sadzp060_1_update_dzal_t finish"
         END CASE

         IF NOT lb_result THEN
            ROLLBACK WORK #非常重要.
            RETURN FALSE
         END IF

         LET lnode_child = lnode_child.getNextSiblingElement() #取得tsd檔下一個子節點
      END WHILE
      #End:2014/09/22 by Hiko:再做d

      #Begin:2014/09/01 by Hiko:不需要重產42s,r.f會做
      #Begin:2014/03/24 by Hiko 重新產生多語言檔
      #Begin:2014/10/24 by Hiko:還是得做
      IF lb_result2 THEN
         LET ls_run_cmd = "r.r azzp191 ",gs_prog," ",g_lang
         LET ls_trigger = "sadzp060_1_update_tsd : ",ls_run_cmd
         CALL cl_cmdrun_openpipe("r.r azzp191", ls_run_cmd, FALSE) RETURNING lb_run_result,ls_err_msg
         LET ls_trigger = "sadzp060_1_update_tsd : call azzp191 finish!"
      END IF
      #End:2014/10/24 by Hiko
      #End:2014/03/24 by Hiko
      #End:2014/09/01 by Hiko

      COMMIT WORK #非常重要.
      DISPLAY "call sadzp060_1_update_tsd finish!"

      RETURN lb_result
   CATCH 
      IF lb_trans THEN
         ROLLBACK WORK #非常重要.
      END IF
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC 
# Descriptions    : 更新rsd檔對應的資料表
# Input parameter : p_prog 程式代號
#                 : p_module 模組別
#                 : p_identity 識別標示(s/c)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/04/10 by Hiko
##########################################################################
PUBLIC FUNCTION sadzp060_1_update_rsd(p_prog, p_module, p_identity)
   DEFINE p_prog STRING,
          p_module STRING,
          p_identity STRING
   DEFINE ls_module_dir STRING #模組目錄
   DEFINE ls_sql STRING,
          ls_trigger STRING 
   DEFINE ls_rsd STRING, #rsd檔路徑
          ldoc_rsd xml.DomDocument,
          lnode_rsd xml.DomNode,
          lnode_child xml.DomNode, 
          ls_tag_name STRING,
          ls_status STRING, 
          lb_result BOOLEAN,
          lb_trans  BOOLEAN #2015/01/14 by Hiko

   #整大段都和update_tsd的前半段雷同.
   LET gs_prog = p_prog.trim()
   LET gs_module = p_module.toUpperCase()
   LET gs_identity = p_identity.trim()

   IF NOT sadzp060_1_init_var() THEN
      RETURN FALSE
   END IF

   LET lb_result = TRUE

   TRY
      DISPLAY "call sadzp060_1_update_rsd start!"

      #取得rsd檔.
      LET ls_module_dir = FGL_GETENV(gs_module) CLIPPED
      LET ls_rsd = os.path.join(os.path.join(os.path.join(ls_module_dir, "dzx"), "tsd"), gs_prog||".rsd")
      LET ldoc_rsd = xml.domDocument.create()
      LET ls_trigger = "sadzp060_1_update_rsd : load rsd=",ls_rsd
      IF NOT os.Path.exists(ls_rsd) THEN
         DISPLAY "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00175", g_lang), gs_prog||".rsd")
         RETURN FALSE
      END IF

      CALL ldoc_rsd.load(ls_rsd)
      LET lnode_rsd = ldoc_rsd.getDocumentElement()

      #Begin:2015/07/03 by Hiko
      LET ls_rsd = ls_rsd,".read"
      CALL lnode_rsd.setAttribute("booking", "N")
      IF NOT sadzp010_1_create_read_file(ldoc_rsd, ls_rsd) THEN
         RETURN FALSE
      END IF
      #End:2015/07/03 by Hiko

      LET lb_trans = FALSE
      BEGIN WORK #非常重要.
      LET lb_trans = TRUE

      LET g_revision = lnode_rsd.getAttribute("ver") CLIPPED
      LET g_head_ver = g_revision #2014/12/22 by Hiko

      LET lnode_child = lnode_rsd.getFirstChildElement()
      WHILE (lnode_child IS NOT NULL)
         LET ls_tag_name = lnode_child.getLocalName()
         LET ls_status = lnode_child.getAttribute("status")
         IF NOT cl_null(ls_status) THEN
            CASE ls_tag_name
               WHEN "all"
                  LET ls_trigger = "sadzp060_1_update_rsd : sadzp060_1_update_dzab_t"
                  CALL sadzp060_1_update_dzab_t(lnode_child, ls_status, "ALL") RETURNING lb_result
                  DISPLAY "call sadzp060_1_update_dzab_t finish"
            END CASE
         END IF

         IF NOT lb_result THEN
            ROLLBACK WORK #非常重要.
            RETURN FALSE
         END IF

         LET lnode_child = lnode_child.getNextSiblingElement() #取得rsd檔下一個子節點
      END WHILE

      COMMIT WORK #非常重要.
      DISPLAY "call sadzp060_1_update_rsd finish!"

      RETURN lb_result
   CATCH 
      IF lb_trans THEN
         ROLLBACK WORK #非常重要.
      END IF
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<other>屬性資料,更新dzax_t.
# Input parameter : p_node_other <other> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/12 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzax_t(p_node_other)
   DEFINE p_node_other xml.DomNode
   DEFINE lnode_child xml.DomNode,
          ls_tag_name STRING,
          ls_status STRING,
          ls_value STRING
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   TRY
      #Begin:2014/12/22 by Hiko:topstd不能更新客製程式的dzax_t,以免造成誤解.
      IF g_account="topstd" THEN
         IF gs_identity="c" THEN
            DISPLAY "[INFO]sadzp060_1_update_dzax_t : We can't update the type of dzax006='c' data for topstd!"
            RETURN TRUE
         END IF
      END IF
      #End:2014/12/22 by Hiko

      LET lnode_child = p_node_other.getFirstChildElement()
      WHILE lnode_child IS NOT NULL
         LET ls_tag_name = lnode_child.getLocalName() CLIPPED
         LET ls_status = lnode_child.getAttribute("status") CLIPPED
         LET ls_where = " WHERE dzax001='",gs_prog,"' AND dzax006='",gs_identity,"'"
         LET ls_trigger = "sadzp060_1_update_dzax_t : check dzax_t data count"
         LET ls_sql = "SELECT count(*) FROM dzax_t",ls_where
         PREPARE dzax_prep1 FROM ls_sql
         EXECUTE dzax_prep1 INTO li_cnt
         FREE dzax_prep1

         LET ls_value = lnode_child.getAttribute("value") CLIPPED
         CASE ls_tag_name
            WHEN "code_template"
               IF ls_status.equals("u") THEN
                  IF li_cnt>0 THEN #資料已存在.
                     LET ls_trigger = "sadzp060_1_update_dzax_t : update dzax_t data"
                     LET ls_sql = "UPDATE dzax_t",
                                    " SET dzax002='",ls_value,"',",
                                         "dzax004='Y',", #2014/09/15 by Hiko
                                         "dzax005='",gs_customer,"',", 
                                         "dzaxstus='Y',", 
                                         "dzaxmoddt=?,", 
                                         "dzaxmodid='",g_user,"' ",ls_where
                  ELSE
                     LET ls_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                                     "dzaxcrtdt,dzaxcrtdp,dzaxowndp,dzaxownid,dzaxstus,dzaxcrtid)",
                                             " VALUES('",gs_prog,"','",ls_value,"','','Y','",gs_customer,"','",gs_identity,"','',",
                                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
                  END IF
                  
                  PREPARE dzax_prep2 FROM ls_sql
                  EXECUTE dzax_prep2 USING g_date 
                  FREE dzax_prep2

                  CALL sadzp060_2_set_regen(gs_prog, 'Y') #2015/12/21 by Hiko
               END IF
            WHEN "free_style"
               IF ls_status.equals("u") THEN
                  IF li_cnt>0 THEN #資料已存在.
                     LET ls_trigger = "sadzp060_1_update_dzax_t : update dzax_t data"
                     LET ls_sql = "UPDATE dzax_t",
                                    " SET dzax003='",ls_value,"',",
                                         "dzax004='Y',", #2014/09/15 by Hiko
                                         "dzax005='",gs_customer,"',", 
                                         "dzaxstus='Y',", 
                                         "dzaxmoddt=?,", 
                                         "dzaxmodid='",g_user,"' ",ls_where
                  ELSE
                     LET ls_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                                     "dzaxcrtdt,dzaxcrtdp,dzaxowndp,dzaxownid,dzaxstus,dzaxcrtid)",
                                             " VALUES('",gs_prog,"','','",ls_value,"','Y','",gs_customer,"','",gs_identity,"','',",
                                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
                  END IF
                  
                  PREPARE dzax_prep3 FROM ls_sql
                  EXECUTE dzax_prep3 USING g_date 
                  FREE dzax_prep3

                  CALL sadzp060_2_set_regen(gs_prog, 'Y') #2015/12/21 by Hiko
               END IF
            #Begin:2014/10/03 by Hiko
            WHEN "start_arg"
               IF ls_status.equals("u") THEN
                  IF li_cnt>0 THEN #資料已存在.
                     LET ls_trigger = "sadzp060_1_update_dzax_t : update dzax_t data"
                     LET ls_sql = "UPDATE dzax_t",
                                    " SET dzax007='",ls_value,"',",
                                         "dzax004='Y',", 
                                         "dzax005='",gs_customer,"',", 
                                         "dzaxstus='Y',", 
                                         "dzaxmoddt=?,", 
                                         "dzaxmodid='",g_user,"' ",ls_where
                  ELSE
                     LET ls_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                                     "dzaxcrtdt,dzaxcrtdp,dzaxowndp,dzaxownid,dzaxstus,dzaxcrtid)",
                                             " VALUES('",gs_prog,"','','','Y','",gs_customer,"','",gs_identity,"','",ls_value,"',",
                                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
                  END IF
                  
                  PREPARE dzax_prep4 FROM ls_sql
                  EXECUTE dzax_prep4 USING g_date 
                  FREE dzax_prep4

                  CALL sadzp060_2_set_regen(gs_prog, 'Y') #2015/12/21 by Hiko
               END IF
            #End:2014/10/03 by Hiko
         END CASE

         LET lnode_child = lnode_child.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_2_set_regen(gs_prog, 'Y') #2015/12/21 by Hiko:這是為了避免漏網之魚.
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<table>屬性資料,更新dzag_t.
# Input parameter : p_node_table <table> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/07/06 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzag_t(p_node_table)
   DEFINE p_node_table xml.DomNode
   DEFINE lnode_tbl xml.DomNode,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lb_been_copied BOOLEAN, #複製只需要做一次即可.
	  ls_table_name STRING,
	  ls_parent STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING,
          li_sr_idx SMALLINT,
          ls_main STRING,
          ls_head STRING

   #dzag_t(Table)與dzfs_t(ScreenRecord)沒有引用
   #因為<tbl>與<sr>的結構關係比較複雜,所以先處理<tbl>/<sr>為'd'的資料,再處理'u'的資料;
   TRY
      #先更新狀態為'd'的異動.
      LET lb_been_copied = FALSE
      CALL ga_sr.CLEAR()

      CALL sadzp060_1_get_spec_element_curr_revision("TABLE") RETURNING lb_result,l_dzaa004,l_dzaa006 #2014/05/29 by Hiko
      IF NOT lb_result THEN
         RETURN FALSE
      END IF

      #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
      IF g_account="topstd" THEN
         LET g_revision = g_head_ver
         IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
            LET g_revision = l_dzaa004  
         END IF
         
         LET g_env = GS_DGENV
         IF NOT cl_null(l_dzaa006) THEN
            LET g_env = l_dzaa006
         END IF
      END IF
      #End:2015/11/11 by Hiko

      LET lnode_tbl = p_node_table.getFirstChildElement()
      WHILE lnode_tbl IS NOT NULL
         LET ls_table_name = lnode_tbl.getAttribute("name") CLIPPED
         LET ls_parent = lnode_tbl.getAttribute("parent") CLIPPED
         LET ls_status = lnode_tbl.getAttribute("status")
         IF NOT cl_null(ls_status) THEN
            IF NOT lb_been_copied THEN
               IF g_account<>"topstd" THEN #2015/11/11 by Hiko:一定會有Table的舊資料,因此直接異動即可.
                  #只要有異動,不論u,d,也不論幾個Table,都需要複製前版次為基底.
                  IF NOT sadzp060_1_copy_dzag_t(l_dzaa004, l_dzaa006) THEN #dzaa_t是在此FUNCTION內異動.
                     RETURN FALSE
                  END IF
               END IF

               LET lb_been_copied = TRUE
            END IF
            
            LET ls_where = " WHERE dzag001='",gs_prog,"' AND dzag002='",ls_table_name,"' AND dzag003=",g_revision
            IF ls_status.equals("d") THEN #整塊資料的就改為失效.
               IF NOT sadzp060_1_disable_status("dzag_t", ls_where, "dzag006", "dzag011") THEN 
                  RETURN FALSE
               END IF
            END IF
         END IF #ls_status=u or d
         #不論tbl是否需要更新,都要找其下階(sr).
         CALL sadzp060_1_collect_sr(lnode_tbl)

         LET lnode_tbl = lnode_tbl.getNextSiblingElement()
      END WHILE

      IF lb_been_copied THEN #表示前面已經做完了複製dzag_t/dzfs_t的動作,若前面沒有做過,則此段就不用執行了.
         #再更新狀態為'u'的異動.
         LET lnode_tbl = p_node_table.getFirstChildElement()
         WHILE lnode_tbl IS NOT NULL
            LET ls_table_name = lnode_tbl.getAttribute("name") CLIPPED
            LET ls_parent = lnode_tbl.getAttribute("parent") CLIPPED
            LET ls_status = lnode_tbl.getAttribute("status")
               
            #執行dzag_t的異動.
            LET ls_where = " WHERE dzag001='",gs_prog,"' AND dzag002='",ls_table_name,"' AND dzag003=",g_revision," AND dzag006='",g_env,"'"
            IF ls_status.equals("u") THEN
               #Begin:2014/03/06 by Hiko
               LET ls_main = lnode_tbl.getAttribute("main") CLIPPED
               IF cl_null(ls_main) THEN
                  LET ls_main = "N" #有異動的Table一定不是主Table,所以預設為N
               END IF
               #End:2014/03/06 by Hiko
               #Begin:2014/01/21 by Hiko
               LET ls_head = lnode_tbl.getAttribute("head") CLIPPED
               IF cl_null(ls_head) THEN
                  LET ls_head = "N"
               END IF
               #End:2014/01/21 by Hiko
               LET ls_trigger = "sadzp060_1_update_dzag_t : check dzag_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzag_t",ls_where
               PREPARE dzag_prep2 FROM ls_sql
               EXECUTE dzag_prep2 INTO li_cnt
               FREE dzag_prep2
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzag_t : update dzag_t data"
                  LET ls_sql = "UPDATE dzag_t",
                                 " SET dzag004='",ls_parent,"',",
                                      "dzag005='",ls_main,"',",
                                      "dzag006='",g_env,"',",
                                      #Begin:2014/01/21 by Hiko
                                      "dzag007='",ls_head,"',",
                                      "dzag008='",lnode_tbl.getAttribute("pk") CLIPPED,"',",
                                      "dzag009='",lnode_tbl.getAttribute("fk_detail") CLIPPED,"',",
                                      "dzag010='",lnode_tbl.getAttribute("fk_master") CLIPPED,"',",
                                      #End:2014/01/21 by Hiko
                                      "dzag011='",gs_customer,"',",
                                      "dzag012='",g_env,"',",
                                      #Begin:2014/12/29 by Hiko
                                      "dzag013='",lnode_tbl.getAttribute("upper_table") CLIPPED,"',", #三層二顯之上階Table
                                      "dzag014='",lnode_tbl.getAttribute("upper_key") CLIPPED,"',",   #三層二顯之上階Key值設定
                                      "dzag015='",lnode_tbl.getAttribute("this_key") CLIPPED,"',",    #三層二顯之本階對應Key值設定
                                      #End:2014/12/29 by Hiko
                                      "dzagstus='Y',", 
                                      "dzagmoddt=?,",
                                      "dzagmodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzag_t : insert dzag_t data"
                  LET ls_sql = "INSERT INTO dzag_t(dzag001,dzag002,dzag003,dzag004,dzag005,dzag006,",
                                                  "dzag007,dzag008,dzag009,dzag010,dzag011,dzag012,", #2014/01/21 by Hiko
                                                  "dzag013,dzag014,dzag015,", #2014/12/29 by Hiko
                                                  "dzagcrtdt,dzagcrtdp,dzagowndp,dzagownid,dzagstus,dzagcrtid)",
                                          " VALUES('",gs_prog,"','",ls_table_name,"',",g_revision,",'",ls_parent,"','",ls_main,"','",g_env,"',",
                                                  "'",ls_head,"','",lnode_tbl.getAttribute("pk") CLIPPED,"','",lnode_tbl.getAttribute("fk_detail") CLIPPED,"','",lnode_tbl.getAttribute("fk_master") CLIPPED,"','",gs_customer,"','",g_env,"',", 
                                                  "'",lnode_tbl.getAttribute("upper_table") CLIPPED,"','",lnode_tbl.getAttribute("upper_key") CLIPPED,"','",lnode_tbl.getAttribute("this_key") CLIPPED,"',", #2014/12/29 by Hiko 
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               
               PREPARE dzag_prep3 FROM ls_sql
               EXECUTE dzag_prep3 USING g_date 
               FREE dzag_prep3
            END IF #IF ls_status.equals("u")
         
            LET lnode_tbl = lnode_tbl.getNextSiblingElement()
         END WHILE
      END IF #IF lb_been_copied

      #更新ScreenRecord資訊.
      IF NOT sadzp060_1_update_dzfs_t(l_dzaa004, l_dzaa006) THEN
         RETURN FALSE
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzag_t(包含dzfs_t).
# Input parameter : p_old_revision Server上TABLE對應的版次
#                 : p_old_use_flag Server上TABLE對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/20 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_dzag_t(p_old_revision, p_old_use_flag)
   DEFINE p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   #dzag_t和dzam雷同.
   TRY
      LET ls_trigger = "sadzp060_1_copy_dzag_t : check dzag_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzag_t"
      LET ls_where = " WHERE dzag001='",gs_prog,"'"
      LET ls_revision_wc = " AND dzag003=",g_revision," AND dzag006='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc
      PREPARE dzag_prep0 FROM ls_sql
      EXECUTE dzag_prep0 INTO li_cnt
      FREE dzag_prep0
      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_dzag_t : check dzag_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzag003='",p_old_revision,"' AND dzag006='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc
         PREPARE dzag_prep1 FROM ls_sql
         EXECUTE dzag_prep1 INTO li_cnt
         FREE dzag_prep1
         IF li_cnt>0 THEN
            #找到舊版就複製為新版,狀態碼不變:版次(dzag003)為舊版.
            LET ls_trigger = "sadzp060_1_copy_dzag_t : insert dzag_t:old ver=",p_old_revision,",old use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzag_t(dzag001,dzag002,dzag003,dzag004,dzag005,",
                                            "dzag006,dzag007,dzag008,dzag009,dzag010,dzag011,dzag012,",
                                            "dzag013,dzag014,dzag015,", #2014/12/29 by Hiko
                                            "dzagcrtdt,dzagcrtdp,dzagowndp,dzagownid,dzagstus,dzagcrtid)",
                                    " SELECT dzag001,dzag002,",g_revision,",dzag004,dzag005,",
                                            "'",g_env,"',dzag007,dzag008,dzag009,dzag010,'",gs_customer,"',dzag012,",
                                            "dzag013,dzag014,dzag015,", #2014/12/29 by Hiko
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"',dzagstus,'",g_user,"'",
                                      " FROM dzag_t",ls_where,ls_revision_wc," AND dzagstus='Y'"
            PREPARE dzag_prep8 FROM ls_sql
            EXECUTE dzag_prep8 USING g_date
            FREE dzag_prep8
         END IF
      END IF
	  
      #dzfs_t一起處理.
      LET ls_trigger = "sadzp060_1_copy_dzfs_t : check dzfs_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzfs_t"
      LET ls_where = " WHERE dzfs002='",gs_prog,"'"
      LET ls_revision_wc = " AND dzfs001=",g_revision," AND dzfs005='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc
      PREPARE dzfs_prep0 FROM ls_sql
      EXECUTE dzfs_prep0 INTO li_cnt
      FREE dzfs_prep0
      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_dzfs_t : check dzfs_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzfs001='",p_old_revision,"' AND dzfs005='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc
         PREPARE dzfs_prep1 FROM ls_sql
         EXECUTE dzfs_prep1 INTO li_cnt
         FREE dzfs_prep1
         IF li_cnt>0 THEN
            #找到舊版就複製為新版,狀態碼不變:版次(dzfs003)為舊版.
            LET ls_trigger = "sadzp060_1_copy_dzag_t : insert dzfs_t:old ver=",p_old_revision,",old use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzfs_t(dzfs001,dzfs002,dzfs003,dzfs004,dzfs005,",
                                            "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,dzfs011,dzfs012,",
                                            "dzfscrtdt,dzfscrtdp,dzfsowndp,dzfsownid,dzfsstus,dzfscrtid)",
                                    " SELECT ",g_revision,",dzfs002,dzfs003,dzfs004,'",g_env,"',",
                                            "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,'",gs_customer,"',dzfs012,",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"',dzfsstus,'",g_user,"'",
                                      " FROM dzfs_t",ls_where,ls_revision_wc," AND dzfsstus='Y'"
            PREPARE dzfs_prep8 FROM ls_sql
            EXECUTE dzfs_prep8 USING g_date
            FREE dzfs_prep8
         END IF
      END IF

      #TABLE設定不會引用,且有異動就是"Y".
      RETURN sadzp060_1_update_dzaa_t("TABLE", "4", "u", "N") #2014/03/25 by Hiko
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 蒐集<sr>資料.
# Input parameter : p_sr_arr <sr> array
# Return code     : none
# Date & Author   : 2013/07/18 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_collect_sr(p_node_tbl)
   DEFINE p_node_tbl xml.DomNode
   DEFINE lnode_sr xml.DomNode,
          ls_table_name STRING,
          li_sr_idx SMALLINT,
          ls_status STRING
   #Begin:2014/03/06 by Hiko
   DEFINE ls_insert STRING,
          ls_delete STRING,
          ls_append STRING,
          ls_cascade STRING,
          ls_kind STRING
   #End:2014/03/06 by Hiko
   
   LET ls_table_name = p_node_tbl.getAttribute("name") CLIPPED
   LET li_sr_idx = ga_sr.getLength()
   LET lnode_sr = p_node_tbl.getFirstChildElement()
   WHILE lnode_sr IS NOT NULL
      LET ls_status = lnode_sr.getAttribute("status") CLIPPED
      IF NOT cl_null(ls_status) THEN
         LET li_sr_idx = li_sr_idx + 1
         LET ga_sr[li_sr_idx].sr = lnode_sr.getAttribute("name") CLIPPED
         LET ga_sr[li_sr_idx].table = ls_table_name
         #Begin:2014/03/06 by Hiko
         LET ls_insert = lnode_sr.getAttribute("insert") CLIPPED
         IF cl_null(ls_insert) THEN
            LET ls_insert = "Y"
         END IF
         LET ls_delete = lnode_sr.getAttribute("delete") CLIPPED
         IF cl_null(ls_delete) THEN
            LET ls_delete = "Y"
         END IF
         LET ls_append = lnode_sr.getAttribute("append") CLIPPED
         IF cl_null(ls_append) THEN
            LET ls_append = "Y"
         END IF
         LET ls_cascade = lnode_sr.getAttribute("cascade") CLIPPED
         IF cl_null(ls_cascade) THEN
            LET ls_cascade = "Y"
         END IF
         LET ls_kind = lnode_sr.getAttribute("kind") CLIPPED
         IF cl_null(ls_kind) THEN
            LET ls_kind = "Table"
         END IF
         #End:2014/03/06 by Hiko
         LET ga_sr[li_sr_idx].insert = ls_insert
         LET ga_sr[li_sr_idx].delete = ls_delete
         LET ga_sr[li_sr_idx].append = ls_append
         #Begin:2014/01/21 by Hiko
         LET ga_sr[li_sr_idx].cascade = ls_cascade
         LET ga_sr[li_sr_idx].kind = ls_kind
         #End:2014/01/21 by Hiko
         LET ga_sr[li_sr_idx].status = ls_status
      END IF

      LET lnode_sr = lnode_sr.getNextSiblingElement()
   END WHILE
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzfs_t.
# Input parameter : p_old_revision Server上TABLE對應的版次
#                 : p_old_use_flag Server上TABLE對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/07/18 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzfs_t(p_old_revision, p_old_use_flag)
   DEFINE p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE li_sr_idx SMALLINT,
          ls_status STRING,
          ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT,
          ls_where STRING,
          ls_wc STRING

   TRY
      #只要有異動,不論u,d,也不論幾個Table,都需要複製前版次為基底.
      #這裡也需要此判斷的原因 : dzag_t和dzfs_t是一體的, dzag_t有異動, 則dzfs_t就會異動; dzag_t沒異動, dzfs_t還是有可能異動.
      #Begin:2014/03/20 by Hiko:這邊先判斷是否要複製會比較單純
      IF ga_sr.getLength()>0 THEN
         IF NOT sadzp060_1_copy_dzag_t(p_old_revision, p_old_use_flag) THEN #dzaa_t是在此FUNCTION內異動.
            RETURN FALSE
         END IF
      END IF
      #End:2014/03/20 by Hiko
      LET ls_wc = " WHERE dzfs002='",gs_prog,"' AND dzfs001=",g_revision," AND dzfs005='",g_env,"'"
      #先更新狀態為'd'的異動.
      FOR li_sr_idx=1 TO ga_sr.getLength()
         LET ls_status = ga_sr[li_sr_idx].status
         
         LET ls_where = ls_wc," AND dzfs003='",ga_sr[li_sr_idx].sr,"'"
         IF ls_status.equals("d") THEN #整塊資料的就改為失效.
            IF NOT sadzp060_1_disable_status("dzfs_t", ls_where, "dzfs005", "dzfs011") THEN 
               RETURN FALSE
            END IF
         END IF
      END FOR

      #再更新狀態為'u'的異動.
      FOR li_sr_idx=1 TO ga_sr.getLength()
         LET ls_status = ga_sr[li_sr_idx].status
         
	 LET ls_where = ls_wc," AND dzfs003='",ga_sr[li_sr_idx].sr,"'"
         IF ls_status.equals("u") THEN
            LET ls_trigger = "sadzp060_1_update_dzfs_t : check dzfs_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzfs_t",ls_where
            PREPARE dzfs_prep2 FROM ls_sql
            EXECUTE dzfs_prep2 INTO li_cnt
            FREE dzfs_prep2
         
            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp060_1_update_dzfs_t : update dzfs_t data"
               LET ls_sql = "UPDATE dzfs_t",
                              " SET dzfs004='",ga_sr[li_sr_idx].table,"',",
                                   "dzfs005='",g_env,"',",
                                   "dzfs006='",ga_sr[li_sr_idx].insert,"',",
                                   "dzfs007='",ga_sr[li_sr_idx].delete,"',",
                                   "dzfs008='",ga_sr[li_sr_idx].append,"',",
                                   #Begin:2014/01/21 by Hiko
                                   "dzfs009='",ga_sr[li_sr_idx].cascade,"',",
                                   "dzfs010='",ga_sr[li_sr_idx].kind,"',",
                                   #End:2014/01/21 by Hiko
                                   "dzfs011='",gs_customer,"',",
                                   "dzfs012='",g_env,"',",
                                   "dzfsstus='Y',", 
                                   "dzfsmoddt=?,",
                                   "dzfsmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_1_update_dzag_t : insert dzfs_t data"
               LET ls_sql = "INSERT INTO dzfs_t(dzfs001,dzfs002,dzfs003,dzfs004,dzfs005,",
                                               "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,dzfs011,dzfs012,", #2014/01/21 by Hiko : 增加dzfs009,dzfs010
                                               "dzfscrtdt,dzfscrtdp,dzfsowndp,dzfsownid,dzfsstus,dzfscrtid)",
                                       " VALUES(",g_revision,",'",gs_prog,"','",ga_sr[li_sr_idx].sr,"','",ga_sr[li_sr_idx].table,"','",g_env,"',",
                                               "'",ga_sr[li_sr_idx].insert,"','",ga_sr[li_sr_idx].delete,"','",ga_sr[li_sr_idx].append,"','",ga_sr[li_sr_idx].cascade,"','",ga_sr[li_sr_idx].kind,"','",gs_customer,"','",g_env,"',", 
                                                "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
         
            PREPARE dzfs_prep3 FROM ls_sql
            EXECUTE dzfs_prep3 USING g_date
            FREE dzfs_prep3
         END IF
      END FOR
	  
      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<tree>屬性資料,更新dzff_t.
# Input parameter : p_node_tree <tree> node
#                   p_status 更新狀態
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/01/06 by Hiko
# Modify          : 2014/03/19 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzff_t(p_node_tree, p_status)
   DEFINE p_node_tree xml.DomNode,
          p_status STRING
   DEFINE lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          l_name LIKE dzff_t.dzff003,
          lnode_att xml.DomNode,
          ls_status STRING,
          ls_trigger STRING,
          ls_sql STRING,
          ls_where STRING,
          li_cnt SMALLINT
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          la_dzff DYNAMIC ARRAY OF RECORD LIKE dzff_t.*,
          li_i SMALLINT
   #End:2014/05/06 by Hiko

   #dzff_t的更新方式和dzal_t雷同,差異在於dzff_t並沒有失效問題,只有相關設定有沒有內容而已.
   TRY
      LET p_status = p_status.trim()
      IF NOT cl_null(p_status) THEN
         CALL la_dzff.CLEAR()

         LET l_name = p_node_tree.getAttribute("name") CLIPPED

         #Begin:2014/12/22 by Hiko:為了topstd和複製才拉出來.
         CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         IF g_account="topstd" THEN
            IF l_dzaa006 CLIPPED="c" THEN
               DISPLAY "[INFO]sadzp060_1_update_dzff_t : We can't update the type of src='c' data:",l_name," for topstd!"
               RETURN TRUE
            END IF

            #Begin:2015/08/03 by Hiko
            ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
            #LET g_revision = l_dzaa004
            #IF cl_null(g_revision) OR g_revision=0 THEN
            #   LET g_revision = 1 #表示新增
            #END IF
            #End:2015/08/03 by Hiko

            #Begin:2015/11/11 by Hiko:有來源資料就要覆寫,這樣才會正確.
            LET g_revision = g_head_ver
            IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
               LET g_revision = l_dzaa004  
            END IF

            LET g_env = GS_DGENV
            IF NOT cl_null(l_dzaa006) THEN
               LET g_env = l_dzaa006
            END IF
            #End:2015/11/11 by Hiko
         END IF
         #End:2014/12/22 by Hiko

         LET ls_cite_std = p_node_tree.getAttribute("cite_std") CLIPPED
         IF cl_null(ls_cite_std) THEN 
            LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
         END IF

         IF p_status.equals("u") THEN
            #Begin:2014/12/22 by Hiko
            #CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006 #2014/05/29 by Hiko
            #IF NOT lb_result THEN
            #   RETURN FALSE
            #END IF
            #End:2014/12/22 by Hiko

            IF g_account<>"topstd" THEN #2014/12/22 by Hiko:topstd不需要做複製舊版的動作,直接異動即可.
               #複製前版次為基底.
               IF NOT sadzp060_1_copy_dzff_t(l_name, l_dzaa004, l_dzaa006) THEN #dzaa_t是在此FUNCTION內異動.
                  RETURN FALSE
               END IF
            END IF

            #先收集資料再一起更新.
            LET lnode_att = p_node_tree.getFirstChildElement()
            LET li_i = 1
            WHILE lnode_att IS NOT NULL
               LET la_dzff[li_i].dzff004 = lnode_att.getAttribute("no") CLIPPED
               IF cl_null(la_dzff[li_i].dzff004) THEN
                  LET la_dzff[li_i].dzff004 = 0
               END IF
               LET la_dzff[li_i].dzff005 = lnode_att.getLocalName()
               LET la_dzff[li_i].dzff006 = lnode_att.getAttribute("table") CLIPPED
               LET la_dzff[li_i].dzff007 = lnode_att.getAttribute("col") CLIPPED

               LET lnode_att = lnode_att.getNextSiblingElement()
               LET li_i = li_i + 1
            END WHILE

            LET li_i = 0 #變數初始化
            FOR li_i=1 TO la_dzff.getLength()
               LET ls_trigger = "sadzp060_1_update_dzff_t : check dzff_t new ver data count"
               #2014/03/17 by Hiko:WHERE條件增加g_env,這樣才會是正確的.
               LET ls_where = " WHERE dzff001='",gs_prog,"' AND dzff002=",g_revision," AND dzff003='",l_name,"' AND dzff005='",la_dzff[li_i].dzff005,"' AND dzff008='",g_env,"'"
               LET ls_sql = "SELECT count(*) FROM dzff_t",ls_where
               PREPARE dzff_prep3 FROM ls_sql
               EXECUTE dzff_prep3 INTO li_cnt
               FREE dzff_prep3
               
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzff_t : update dzff_t data : ",la_dzff[li_i].dzff005
                  LET ls_sql = "UPDATE dzff_t", 
                                 " SET dzff004=",la_dzff[li_i].dzff004 CLIPPED,",",
                                      "dzff006='",la_dzff[li_i].dzff006 CLIPPED,"',",
                                      "dzff007='",la_dzff[li_i].dzff007 CLIPPED,"',",
                                      "dzff009='",gs_customer,"',",
                                      "dzffstus='Y',", 
                                      "dzffmoddt=?,",
                                      "dzffmodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzff_t : insert dzff_t data"
                  LET ls_sql = "INSERT INTO dzff_t(dzff001,dzff002,dzff003,dzff004,dzff005,",
                                                  "dzff006,dzff007,dzff008,dzff009,",
                                                  "dzffcrtdt,dzffcrtdp,dzffowndp,dzffownid,dzffstus,dzffcrtid)",
                                          " VALUES('",gs_prog,"',",g_revision,",'",l_name,"',",la_dzff[li_i].dzff004 CLIPPED,",'",la_dzff[li_i].dzff005 CLIPPED,"',",
                                                  "'",la_dzff[li_i].dzff006 CLIPPED,"','",la_dzff[li_i].dzff007 CLIPPED,"','",g_env,"','",gs_customer,"',",
                                                   "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
            
               PREPARE dzff_prep4 FROM ls_sql
               EXECUTE dzff_prep4 USING g_date
               FREE dzff_prep4
            END FOR
         END IF 

         #更新dzaa_t.
         RETURN sadzp060_1_update_dzaa_t(l_name, "5", p_status, ls_cite_std)
      END IF #IF NOT cl_null(p_status)

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzff_t.
# Input parameter : p_name TREE的控件名稱
#                 : p_old_revision Server上TREE的控件名稱對應的版次
#                 : p_old_use_flag Server上TREE的控件名稱對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/19 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_dzff_t(p_name, p_old_revision, p_old_use_flag)
   DEFINE p_name STRING,
          p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   #dzff_t和dzal_t雷同.
   LET p_name = p_name.trim()

   TRY
      LET ls_trigger = "sadzp060_1_copy_dzff_t : check dzff_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzff_t"
      LET ls_where = " WHERE dzff001='",gs_prog,"' AND dzff003='",p_name,"'"
      LET ls_revision_wc = " AND dzff002=",g_revision
      LET ls_env_wc = " AND dzff008='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzff_prep0 FROM ls_sql
      EXECUTE dzff_prep0 INTO li_cnt
      FREE dzff_prep0
      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_dzff_t : check dzff_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzff002='",p_old_revision,"'"
         LET ls_env_wc = " AND dzff008='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzff_prep1 FROM ls_sql
         EXECUTE dzff_prep1 INTO li_cnt
         FREE dzff_prep1
        IF li_cnt>0 THEN
            #找到舊版就複製為新版,且全部為失效:版次(dzff003)為舊版,來源(dzff004)和g_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp060_1_copy_dzff_t : insert dzff_t:old ver=",p_old_revision,",old use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzff_t(dzff001,dzff002,dzff003,dzff004,dzff005,",
                                            "dzff006,dzff007,dzff008,",
                                            "dzffcrtdt,dzffcrtdp,dzffowndp,dzffownid,dzffstus,dzffcrtid)",
                                    " SELECT dzff001,",g_revision,",dzff003,dzff004,dzff005,",
                                            "dzff006,dzff007,'",g_env,"',",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                      " FROM dzff_t",ls_where,ls_revision_wc,ls_env_wc," AND dzffstus='Y'" 
            PREPARE dzff_prep8 FROM ls_sql
            EXECUTE dzff_prep8 USING g_date
            FREE dzff_prep8
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp060_1_copy_dzff_t : update dzff_t status='N':new ver=",g_revision,",new use flag=",g_env
         LET ls_sql = "UPDATE dzff_t",
                        " SET dzffstus='N',", 
                             "dzffmoddt=?,", 
                             "dzffmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         
         PREPARE dzax_prep9 FROM ls_sql
         EXECUTE dzax_prep9 USING g_date 
         FREE dzax_prep9
      END IF
	  
      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新設計資料為失效.
# Input parameter : p_table 要更新的Table
#                   p_where WHERE條件
#                   p_env_col 使用標示欄位
#                   p_cust_col 客戶代號欄位
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/04/12 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_disable_status(p_table, p_where, p_env_col, p_cust_col)
   DEFINE p_table STRING,
          p_where STRING,
          p_env_col STRING,
          p_cust_col STRING #2014/05/27 by Hiko
   DEFINE ls_col_pre STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 

   TRY
      LET ls_trigger = "sadzp060_1_disable_status : check ",p_table," data count"
      LET ls_sql = "SELECT count(*) FROM ",p_table,p_where
      PREPARE chk_prep FROM ls_sql
      EXECUTE chk_prep INTO li_cnt
      FREE chk_prep
      IF li_cnt>0 THEN #資料存在就更新為失效:這塊程式比較固定,所以拉出來一個FUNCTION處理.
         LET ls_trigger = "sadzp060_1_disable_status : update ",p_table," data status"
         LET ls_col_pre = p_table.subString(1, p_table.getLength()-2)
         LET ls_sql = "UPDATE ",p_table,
                        " SET ",p_env_col,"='",g_env,"',",
                                p_cust_col,"='",gs_customer,"',",
                                ls_col_pre,"stus='N',",
                                ls_col_pre,"moddt=?,",
                                ls_col_pre,"modid='",g_user,"' ",p_where
         PREPARE upd_prep FROM ls_sql
         EXECUTE upd_prep USING g_date
         FREE upd_prep
      END IF   

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql)
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : none
# Date & Author   : 2013/04/12 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<all>屬性資料,更新dzab_t.
# Input parameter : p_node_all <all>,<mi_all>,<db_all>,<di_all> node
#                   p_status 更新狀態
#                   p_name 規格種類
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzab_t(p_node_all, p_status, p_name)
   DEFINE p_node_all xml.DomNode,
          p_status STRING, 
          p_name LIKE dzab_t.dzab004 #規格類型:ALL,MI_ALL,DI_ALL,DB_ALL
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzab RECORD LIKE dzab_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET p_status = p_status CLIPPED
      IF NOT cl_null(p_status) THEN
         LET p_name = p_name CLIPPED

         #Begin:2014/12/22 by Hiko
         CALL sadzp060_1_get_spec_element_curr_revision(p_name) RETURNING lb_result,l_dzaa004,l_dzaa006
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         IF g_account="topstd" THEN
            IF l_dzaa006 CLIPPED="c" THEN
               DISPLAY "[INFO]sadzp060_1_update_dzab_t : We can't update the type of src='c' data:",p_name," for topstd!"
               RETURN TRUE
            END IF

            #Begin:2015/08/03 by Hiko
            ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
            #LET g_revision = l_dzaa004
            #IF cl_null(g_revision) OR g_revision=0 THEN
            #   LET g_revision = 1 #表示新增
            #END IF
            #End:2015/08/03 by Hiko

            #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
            LET g_revision = g_head_ver
            IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
               LET g_revision = l_dzaa004  
            END IF
            
            LET g_env = GS_DGENV
            IF NOT cl_null(l_dzaa006) THEN
               LET g_env = l_dzaa006
            END IF
            #End:2015/11/11 by Hiko
         END IF
         #End:2014/12/22 by Hiko

         LET ls_cite_std = p_node_all.getAttribute("cite_std") CLIPPED
         IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
            LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
         END IF
         IF p_status.equals("u") THEN
            LOCATE lr_dzab.dzab099 IN FILE

            LET lr_dzab.dzab099 = sadzp060_1_get_cdata(p_node_all)
         
            LET ls_where = " WHERE dzab001='",gs_prog,"' AND dzab002=",g_revision," AND dzab003='",g_env,"' AND dzab004='",p_name,"'"
            LET ls_trigger = "sadzp060_1_update_dzab_t : check dzab_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzab_t",ls_where
            PREPARE dzab_prep1 FROM ls_sql
            EXECUTE dzab_prep1 INTO li_cnt
            FREE dzab_prep1
            
            IF li_cnt>0 THEN 
               LET ls_trigger = "sadzp060_1_update_dzab_t : update dzab_t data"
               LET ls_sql = "UPDATE dzab_t",
                              " SET dzab005='",gs_customer,"',",
                                   "dzab006='',",
                                   "dzabstus='Y',", 
                                   "dzabmoddt=?,", #PREPARE時,日期格式若沒有用USING來處理,則必須依據DB的專用Function來設定,例如to_date.
                                   "dzabmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_1_update_dzab_t : insert dzab_t data"
               LET ls_sql = "INSERT INTO dzab_t(dzab001,dzab002,dzab003,dzab004,dzab005,dzab006,",
                                               "dzabcrtdt,dzabcrtdp,dzabowndp,dzabownid,dzabstus,dzabcrtid)",
                                       " VALUES('",gs_prog,"',",g_revision,",'",g_env,"','",p_name,"','",gs_customer,"','',",
                                               "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            
            PREPARE dzab_prep2 FROM ls_sql
            EXECUTE dzab_prep2 USING g_date
            FREE dzab_prep2
         
            #更新規格整體描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
            LET ls_trigger = "sadzp060_1_update_dzab_t : update dzab_t data"
            UPDATE dzab_t 
               SET dzab099=lr_dzab.dzab099
             WHERE dzab001=gs_prog AND
                   dzab002=g_revision AND
                   dzab003=g_env AND
                   dzab004=p_name 
            FREE lr_dzab.dzab099
         END IF      

         #更新dzaa_t.
         RETURN sadzp060_1_update_dzaa_t(p_name, "3", p_status, ls_cite_std) 
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得節點的CDATA資料.
# Input parameter : pnode_target 目標節點
# Return code     : CDATA資料
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_get_cdata(pnode_target)
   DEFINE pnode_target xml.DomNode
   DEFINE lnode_text xml.DomNode,
          lnode_cdata xml.DomNode,
          ls_value STRING

   #CDATA不能採用getFirstChildElement的方式,要不然取不到資料.
   #以createCDATASection()建立CDATA的格式,一定要取得第二個子節點才可取得到CDATA的資料. 
   LET lnode_text = pnode_target.getFirstChild() 
   IF lnode_text IS NOT NULL THEN
      LET lnode_cdata = lnode_text.getNextSibling() 
      IF lnode_cdata IS NOT NULL THEN
         LET ls_value = lnode_cdata.getNodeValue()
      END IF   
   END IF

   RETURN ls_value
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<field>屬性資料,更新dzac_t.
# Input parameter : p_node_field <field> node
#                   p_status 更新狀態
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzac_t(p_node_field, p_status)
   DEFINE p_node_field xml.DomNode,
          p_status STRING 
   DEFINE l_name LIKE dzac_t.dzac003
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzac RECORD LIKE dzac_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET p_status = p_status CLIPPED
      IF NOT cl_null(p_status) THEN
         LET l_name = p_node_field.getAttribute("name") CLIPPED

         #Begin:2014/12/22 by Hiko:為了topstd和複製原本dzac_t對應的dzak_t/dzal_t.
         CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         IF g_account="topstd" THEN
            IF l_dzaa006 CLIPPED="c" THEN
               DISPLAY "[INFO]sadzp060_1_update_dzac_t : We can't update the type of src='c' data:",l_name," for topstd!"
               RETURN TRUE
            END IF

            #Begin:2015/08/03 by Hiko
            ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
            #LET g_revision = l_dzaa004
            #IF cl_null(g_revision) OR g_revision=0 THEN
            #   LET g_revision = 1 #表示新增
            #END IF
            #End:2015/08/03 by Hiko

            #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
            LET g_revision = g_head_ver
            IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
               LET g_revision = l_dzaa004  
            END IF
            
            LET g_env = GS_DGENV
            IF NOT cl_null(l_dzaa006) THEN
               LET g_env = l_dzaa006
            END IF
            #End:2015/11/11 by Hiko
         END IF
         #End:2014/12/22 by Hiko

         LET ls_cite_std = p_node_field.getAttribute("cite_std") CLIPPED
         IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
            LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
         END IF
         
         #行業別更新差異只在於引用的時候內容和斷開的內容不同,其餘都和平常更新相同.
         IF p_status.equals("u") THEN
            LOCATE lr_dzac.dzac099 IN FILE
            LET lr_dzac.dzac002 = p_node_field.getAttribute("column") CLIPPED
            LET lr_dzac.dzac005 = p_node_field.getAttribute("table") CLIPPED
            #Begin:2014/08/25 by Hiko
            #LET lr_dzac.dzac006 = p_node_field.getAttribute("attribute") CLIPPED
            #LET lr_dzac.dzac007 = p_node_field.getAttribute("type") CLIPPED
            LET lr_dzac.dzac006 = ""
            LET lr_dzac.dzac007 = ""
            #End:2014/08/25 by Hiko
            LET lr_dzac.dzac008 = p_node_field.getAttribute("req") CLIPPED
            IF cl_null(lr_dzac.dzac008) THEN
               LET lr_dzac.dzac008 = "N"
            END IF
            LET lr_dzac.dzac009 = p_node_field.getAttribute("i_zoom") CLIPPED
            LET lr_dzac.dzac010 = p_node_field.getAttribute("c_zoom") CLIPPED
            LET lr_dzac.dzac011 = p_node_field.getAttribute("chk_ref") CLIPPED
            LET lr_dzac.dzac013 = ""
            LET lr_dzac.dzac014 = p_node_field.getAttribute("default") CLIPPED
            LET lr_dzac.dzac015 = p_node_field.getAttribute("max") CLIPPED
            LET lr_dzac.dzac016 = p_node_field.getAttribute("min") CLIPPED
            LET lr_dzac.dzac017 = p_node_field.getAttribute("can_edit") CLIPPED
            IF cl_null(lr_dzac.dzac017) THEN
               LET lr_dzac.dzac017 = "Y"
            END IF
            LET lr_dzac.dzac018 = p_node_field.getAttribute("can_query") CLIPPED
            IF cl_null(lr_dzac.dzac018) THEN
               LET lr_dzac.dzac018 = "Y"
            END IF
            LET lr_dzac.dzac019 = p_node_field.getAttribute("widget") CLIPPED
            LET lr_dzac.dzac020 = p_node_field.getAttribute("max_compare") CLIPPED #2014/12/05 by Hiko
            LET lr_dzac.dzac021 = p_node_field.getAttribute("min_compare") CLIPPED #2014/12/05 by Hiko
         
            LET lr_dzac.dzac099 = sadzp060_1_get_cdata(p_node_field)
         
            LET ls_trigger = "sadzp060_1_update_dzac_t : check dzac_t new ver data count"
            LET ls_where = " WHERE dzac001='",gs_prog,"' AND dzac003='",l_name,"' AND dzac004=",g_revision," AND dzac012='",g_env,"'"
            LET ls_sql = "SELECT count(*) FROM dzac_t",ls_where
            PREPARE dzac_prep1 FROM ls_sql
            EXECUTE dzac_prep1 INTO li_cnt
            FREE dzac_prep1
            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp060_1_update_dzac_t : update dzac_t data"
               LET ls_sql = "UPDATE dzac_t",
                              " SET dzac002='",lr_dzac.dzac002 CLIPPED,"',",
                                   "dzac005='",lr_dzac.dzac005 CLIPPED,"',",
                                   "dzac006='",lr_dzac.dzac006 CLIPPED,"',",
                                   "dzac007='",lr_dzac.dzac007 CLIPPED,"',",
                                   "dzac008='",lr_dzac.dzac008 CLIPPED,"',",
                                   "dzac009='",lr_dzac.dzac009 CLIPPED,"',",
                                   "dzac010='",lr_dzac.dzac010 CLIPPED,"',",
                                   "dzac011='",lr_dzac.dzac011 CLIPPED,"',",
                                   "dzac013='",gs_customer,"',",
                                   "dzac014=?,", #2015/03/12 by Hiko:改成USING
                                   "dzac015='",lr_dzac.dzac015 CLIPPED,"',",
                                   "dzac016='",lr_dzac.dzac016 CLIPPED,"',",
                                   "dzac017='",lr_dzac.dzac017 CLIPPED,"',",
                                   "dzac018='",lr_dzac.dzac018 CLIPPED,"',",
                                   "dzac019='",lr_dzac.dzac019 CLIPPED,"',",
                                   "dzac020='",lr_dzac.dzac020 CLIPPED,"',",
                                   "dzac021='",lr_dzac.dzac021 CLIPPED,"',",
                                   "dzacstus='Y',", 
                                   "dzacmoddt=?,",
                                   "dzacmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_1_update_dzac_t : insert dzac_t data"
               LET ls_sql = "INSERT INTO dzac_t(dzac001,dzac002,dzac003,dzac004,dzac005,",
                                               "dzac006,dzac007,dzac008,dzac009,dzac010,",
                                               "dzac011,dzac012,dzac013,dzac014,dzac015,",
                                               "dzac016,dzac017,dzac018,dzac019,dzac020,",
                                               "dzac021,",
                                               "dzaccrtdt,dzaccrtdp,dzacowndp,dzacownid,dzacstus,dzaccrtid)",
                                       " VALUES('",gs_prog,"','",lr_dzac.dzac002 CLIPPED,"','",l_name,"',",g_revision,",'",lr_dzac.dzac005 CLIPPED,"',",
                                               "'",lr_dzac.dzac006 CLIPPED,"','",lr_dzac.dzac007 CLIPPED,"','",lr_dzac.dzac008 CLIPPED,"','",lr_dzac.dzac009 CLIPPED,"','",lr_dzac.dzac010 CLIPPED,"',", 
                                               "'",lr_dzac.dzac011 CLIPPED,"','",g_env,"','",gs_customer,"',?,'",lr_dzac.dzac015 CLIPPED,"',", 
                                               "'",lr_dzac.dzac016 CLIPPED,"','",lr_dzac.dzac017 CLIPPED,"','",lr_dzac.dzac018 CLIPPED,"','",lr_dzac.dzac019 CLIPPED,"','",lr_dzac.dzac020 CLIPPED,"',", 
                                               "'",lr_dzac.dzac021 CLIPPED,"',", 
                                               "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            
            PREPARE dzac_prep2 FROM ls_sql
            EXECUTE dzac_prep2 USING lr_dzac.dzac014,g_date
            FREE dzac_prep2
            
            #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
            LET ls_trigger = "sadzp060_1_update_dzac_t : update dzac_t data : dzac099"
            UPDATE dzac_t 
               SET dzac099=lr_dzac.dzac099
             WHERE dzac001=gs_prog AND
                   dzac003=l_name AND
                   dzac004=g_revision AND
                   dzac012=g_env 
            FREE lr_dzac.dzac099
         
            #Begin:2014/12/22 by Hiko
            #dzac_t與dzak_t/dzal_t就類似單頭與單身的關係:
            #1.dzac_t為'u',則dzak_t/dzal_t不一定為u.(有可能沒有設定)
            #2.dzac_t為'd',則dzak_t/dzal_t一定為d.(更新dzak_t/dzal_t就不需要特別處理d的情況,因為在dzac_t就做完了)
            #相反情況:
            #3.dzak_t/dzal_t為'u',則dzac_t一定為'u'.
            #4.dzak_t/dzal_t為'd',則dzac_t一定為'd'.(因為是刪除dzac_t控件所造成,同2)
            #結論:
            #5.因為dzak_t/dzal_t有自己的狀態,所以這裡不需要做同步;
            #6.dzak_t/dzal_t有異動也不需要同步dzac_t,因為dzac_t一定是u.
            #  但dzak_t與dzal_t異動是獨立事件,所以dzac_t異動的時候就得同步dzak_t與dzal_t,避免遺漏.
            IF g_account<>"topstd" THEN
              IF NOT sadzp060_1_copy_old_dzak_t(l_name, l_dzaa004, l_dzaa006) THEN
                 RETURN FALSE
              END IF
              IF NOT sadzp060_1_copy_old_dzal_t(l_name, l_dzaa004, l_dzaa006) THEN
                 RETURN FALSE
              END IF
            END IF
            #End:2014/12/22 by Hiko
         END IF

         #更新dzaa_t.
         RETURN sadzp060_1_update_dzaa_t(l_name, "1", p_status, ls_cite_std)
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzaa_t.
# Input parameter : p_name 規格設計點
#                   p_type 規格設計點型態
#                   p_status 更新狀態
#                   p_cite_std 是否引用(Y/N)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzaa_t(p_name, p_type, p_status, p_cite_std)
   DEFINE p_name LIKE dzaa_t.dzaa003, #規格設計點
          p_type LIKE dzaa_t.dzaa005, #規格設計點型態
          p_status STRING,
          p_cite_std STRING #2014/01/06 by Hiko
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 
   DEFINE ls_stus STRING #2014/09/15 by Hiko

   LET p_name = p_name CLIPPED
   LET p_type = p_type CLIPPED
   LET p_status = p_status CLIPPED

   TRY
      #將dzaa005(識別碼類型)條件移除,原因是因為:
      #在設計器移除某個控件(例如資料多語言,型態為7),上傳後,dzaa_t會將此筆資料變成失效.
      #當重新又新建一個同名的控件(例如欄位,型態為1),則上傳時就會出現PK重複的問題.
      IF NOT cl_null(p_status) THEN
         #Begin:2014/09/15 by Hiko
         LET ls_stus = ""
         IF p_status.equals("u") THEN
            LET ls_stus = "Y"
         ELSE
            LET ls_stus = "N"
         END IF
         #End:2014/09/15 by Hiko
         
         LET ls_trigger = "sadzp060_1_update_dzaa_t : check dzaa_t new ver data count"
         LET ls_where = " WHERE dzaa001='",gs_prog,"' AND dzaa002=",g_head_ver," AND dzaa003='",p_name,"' AND dzaa009='",gs_identity,"'"
         LET ls_sql = "SELECT count(*) FROM dzaa_t",ls_where
         PREPARE dzaa_prep1 FROM ls_sql
         EXECUTE dzaa_prep1 INTO li_cnt
         FREE dzaa_prep1
         IF li_cnt>0 THEN #原本dzaa_t不用UPDATE,但因為有使用標示(可能標準變成客製),所以補上UPDAT段.
            LET ls_trigger = "sadzp060_1_update_dzaa_t : update dzaa_t data"
            LET ls_sql = "UPDATE dzaa_t",
                           " SET dzaa004=",g_revision,",",
                                "dzaa005='",p_type,"',",
                                "dzaa006='",g_env,"',",
                                "dzaa007='",p_cite_std,"',",
                                "dzaa008='",gs_erpver,"',",
                                "dzaa010='",gs_customer,"',",
                                "dzaastus='",ls_stus,"',", 
                                "dzaamoddt=?,", 
                                "dzaamodid='",g_user,"' ",ls_where
         ELSE
            LET ls_trigger = "sadzp060_1_update_dzaa_t : insert dzaa_t data"
            LET ls_sql = "INSERT INTO dzaa_t(dzaa001,dzaa002,dzaa003,dzaa004,dzaa005,",
                                            "dzaa006,dzaa007,dzaa008,dzaa009,dzaa010,", #2014/05/27 by Hiko
                                            "dzaacrtdt,dzaacrtdp,dzaaowndp,dzaaownid,dzaastus,dzaacrtid)",
                                    " VALUES('",gs_prog,"',",g_head_ver,",'",p_name,"',",g_revision,",'",p_type,"',",                  
                                            "'",g_env,"','",p_cite_std,"','",gs_erpver,"','",gs_identity,"','",gs_customer,"',", #2014/04/28 by Hiko
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','",ls_stus,"','",g_user,"')"
         END IF
         
         PREPARE dzaa_prep2 FROM ls_sql
         EXECUTE dzaa_prep2 USING g_date
         FREE dzaa_prep2
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<ref_field>屬性資料,更新dzai_t.
# Input parameter : p_node_ref_field <ref_field> node
#                 : p_status_flag 更新標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/04/10 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzai_t(p_node_ref_field, p_status_flag)
   DEFINE p_node_ref_field xml.DomNode,
          p_status_flag STRING #2014/09/22 by Hiko
   DEFINE lnode_field xml.DomNode,
          ls_status STRING,
          l_name LIKE dzai_t.dzai002
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzai RECORD LIKE dzai_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET lnode_field = p_node_ref_field.getFirstChildElement()
      WHILE lnode_field IS NOT NULL
         LET ls_status = lnode_field.getAttribute("status") CLIPPED
         IF NOT cl_null(ls_status) THEN
            LET l_name = lnode_field.getAttribute("name") CLIPPED

            #Begin:2014/12/22 by Hiko
            CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006
            IF NOT lb_result THEN
               RETURN FALSE
            END IF

            IF g_account="topstd" THEN
               IF l_dzaa006 CLIPPED="c" THEN
                  DISPLAY "[INFO]sadzp060_1_update_dzai_t : We can't update the type of src='c' data:",l_name," for topstd!"
                  RETURN TRUE
               END IF
               
               #Begin:2015/08/03 by Hiko
               ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
               #LET g_revision = l_dzaa004
               #IF cl_null(g_revision) OR g_revision=0 THEN
               #   LET g_revision = 1 #表示新增
               #END IF
               #End:2015/08/03 by Hiko

               #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
               LET g_revision = g_head_ver
               IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
                  LET g_revision = l_dzaa004  
               END IF
               
               LET g_env = GS_DGENV
               IF NOT cl_null(l_dzaa006) THEN
                  LET g_env = l_dzaa006
               END IF
               #End:2015/11/11 by Hiko
            END IF
            #End:2014/12/22 by Hiko

            LET ls_cite_std = lnode_field.getAttribute("cite_std") CLIPPED
            IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
               LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
            END IF
            IF p_status_flag.equals("u") AND ls_status.equals("u") THEN
               LET lr_dzai.dzai005 = lnode_field.getAttribute("depend_field") CLIPPED
               LET lr_dzai.dzai007 = lnode_field.getAttribute("correspon_key") CLIPPED
               LET lr_dzai.dzai008 = lnode_field.getAttribute("ref_table") CLIPPED
               LET lr_dzai.dzai009 = lnode_field.getAttribute("ref_fk") CLIPPED
               LET lr_dzai.dzai010 = lnode_field.getAttribute("ref_dlang") CLIPPED #沒有設定也沒關係
               LET lr_dzai.dzai011 = lnode_field.getAttribute("ref_rtn") CLIPPED
               
               LET ls_where = " WHERE dzai001='",gs_prog,"' AND dzai002='",l_name,"' AND dzai003=",g_revision," AND dzai004='",g_env,"'"
               LET ls_trigger = "sadzp060_1_update_dzai_t : check dzai_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzai_t",ls_where
               PREPARE dzai_prep1 FROM ls_sql
               EXECUTE dzai_prep1 INTO li_cnt
               FREE dzai_prep1
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzai_t : update dzai_t data"
                  LET ls_sql = "UPDATE dzai_t", #沒有dzai006
                                 " SET dzai005='",lr_dzai.dzai005 CLIPPED,"',",
                                      "dzai007=?,",
                                      "dzai008='",lr_dzai.dzai008 CLIPPED,"',",
                                      "dzai009='",lr_dzai.dzai009 CLIPPED,"',",
                                      "dzai010='",lr_dzai.dzai010 CLIPPED,"',",
                                      "dzai011='",lr_dzai.dzai011 CLIPPED,"',",
                                      "dzai012='",gs_customer,"',",
                                      "dzaistus='Y',", 
                                      "dzaimoddt=?,", 
                                      "dzaimodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzai_t : insert dzai_t data"
                  LET ls_sql = "INSERT INTO dzai_t(dzai001,dzai002,dzai003,dzai004,dzai005,",
                                                  "dzai007,dzai008,dzai009,dzai010,dzai011,dzai012,",
                                                  "dzaicrtdt,dzaicrtdp,dzaiowndp,dzaiownid,dzaistus,dzaicrtid)",
                                          " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"','",lr_dzai.dzai005 CLIPPED,"',",
                                                  "?,'",lr_dzai.dzai008 CLIPPED,"','",lr_dzai.dzai009 CLIPPED,"','",lr_dzai.dzai010 CLIPPED,"','",lr_dzai.dzai011 CLIPPED,"','",gs_customer,"',",
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               
               PREPARE dzai_prep2 FROM ls_sql
               EXECUTE dzai_prep2 USING lr_dzai.dzai007,g_date 
               FREE dzai_prep2
            END IF
            
            #更新dzaa_t.
            #依據更新標示(p_status_flag)來當作更新順序(先做d,再做u)
            IF (p_status_flag.equals("u") AND ls_status.equals("u")) OR
               (p_status_flag.equals("d") AND ls_status.equals("d")) THEN
               IF NOT sadzp060_1_update_dzaa_t(l_name, "6", ls_status, ls_cite_std) THEN
                  RETURN FALSE #就不在EXIT WHILE後才判斷了..
               END IF
            END IF
         END IF #NOT cl_null(ls_status)

         #CALL sadzp060_1_update_dzef_t(lnode_field) #2014/01/23 by Hiko #2014/08/25 by Hiko

         LET lnode_field = lnode_field.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<multi_lang>屬性資料,更新dzaj_t.
# Input parameter : p_node_multi_lang <multi_lang> node
#                 : p_status_flag 更新標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/04/10 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzaj_t(p_node_multi_lang, p_status_flag)
   DEFINE p_node_multi_lang xml.DomNode,
          p_status_flag STRING #2014/09/22 by Hiko
   DEFINE lnode_field xml.DomNode,
          ls_status STRING,
          l_name LIKE dzaj_t.dzaj002
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   #Begin:2014/01/15 by Hiko
   DEFINE ls_table STRING,
          ls_column STRING
   #End:2014/01/15 by Hiko
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzaj RECORD LIKE dzaj_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET lnode_field = p_node_multi_lang.getFirstChildElement()
      WHILE lnode_field IS NOT NULL
         LET ls_status = lnode_field.getAttribute("status") CLIPPED
         IF NOT cl_null(ls_status) THEN
            LET l_name = lnode_field.getAttribute("name") CLIPPED

            #Begin:2014/12/22 by Hiko
            CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006
            IF NOT lb_result THEN
               RETURN FALSE
            END IF

            IF g_account="topstd" THEN
               IF l_dzaa006 CLIPPED="c" THEN
                  DISPLAY "[INFO]sadzp060_1_update_dzaj_t : We can't update the type of src='c' data:",l_name," for topstd!"
                  RETURN TRUE
               END IF
               
               #Begin:2015/08/03 by Hiko
               ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
               #LET g_revision = l_dzaa004
               #IF cl_null(g_revision) OR g_revision=0 THEN
               #   LET g_revision = 1 #表示新增
               #END IF
               #End:2015/08/03 by Hiko

               #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
               LET g_revision = g_head_ver
               IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
                  LET g_revision = l_dzaa004  
               END IF
               
               LET g_env = GS_DGENV
               IF NOT cl_null(l_dzaa006) THEN
                  LET g_env = l_dzaa006
               END IF
               #End:2015/11/11 by Hiko
            END IF
            #End:2014/12/22 by Hiko

            LET ls_cite_std = lnode_field.getAttribute("cite_std") CLIPPED
            IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
               LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
            END IF
            IF p_status_flag.equals("u") AND ls_status.equals("u") THEN
               LOCATE lr_dzaj.dzaj099 IN FILE
               LET lr_dzaj.dzaj005 = lnode_field.getAttribute("depend_field") CLIPPED
               LET lr_dzaj.dzaj007 = lnode_field.getAttribute("correspon_key") CLIPPED
               LET lr_dzaj.dzaj008 = lnode_field.getAttribute("lang_table") CLIPPED
               LET lr_dzaj.dzaj009 = lnode_field.getAttribute("lang_fk") CLIPPED
               LET lr_dzaj.dzaj010 = lnode_field.getAttribute("lang_dlang") CLIPPED #沒有設定也沒關係
               LET lr_dzaj.dzaj011 = lnode_field.getAttribute("lang_rtn") CLIPPED
               LET lr_dzaj.dzaj099 = sadzp060_1_get_cdata(lnode_field)

               LET ls_where = " WHERE dzaj001='",gs_prog,"' AND dzaj002='",l_name,"' AND dzaj003=",g_revision," AND dzaj004='",g_env,"'"
               LET ls_trigger = "sadzp060_1_update_dzaj_t : check dz aj_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzaj_t",ls_where   
               PREPARE dzaj_prep1 FROM ls_sql                        
               EXECUTE dzaj_prep1 INTO li_cnt                        
               FREE dzaj_prep1                                       
               IF li_cnt>0 THEN #資料已存在.                         
                  LET ls_trigger = "sadzp060_1_update_dzaj_t : updat e dzaj_t data"
                  LET ls_sql = "UPDATE dzaj_t", #沒有dzaj006         
                                 " SET dzaj005='",lr_dzaj.dzaj005 CLIPPED,"',",
                                      "dzaj007=?,",
                                      "dzaj008='",lr_dzaj.dzaj008 CLIPPED,"',",
                                      "dzaj009='",lr_dzaj.dzaj009 CLIPPED,"',",
                                      "dzaj010='",lr_dzaj.dzaj010 CLIPPED,"',",
                                      "dzaj011='",lr_dzaj.dzaj011 CLIPPED,"',",
                                      "dzaj012='",gs_customer,"',",
                                      "dzajstus='Y',", 
                                      "dzajmoddt=?,", 
                                      "dzajmodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzaj_t : insert dzaj_t data"
                  LET ls_sql = "INSERT INTO dzaj_t(dzaj001,dzaj002,dzaj003,dzaj004,dzaj005,",
                                                  "dzaj007,dzaj008,dzaj009,dzaj010,dzaj011,dzaj012,",
                                                  "dzajcrtdt,dzajcrtdp,dzajowndp,dzajownid,dzajstus,dzajcrtid)",
                                          " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"','",lr_dzaj.dzaj005 CLIPPED,"',",
                                                  "?,'",lr_dzaj.dzaj008 CLIPPED,"','",lr_dzaj.dzaj009 CLIPPED,"','",lr_dzaj.dzaj010 CLIPPED,"','",lr_dzaj.dzaj011 CLIPPED,"','",gs_customer,"',",
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               
               PREPARE dzaj_prep2 FROM ls_sql
               EXECUTE dzaj_prep2 USING lr_dzaj.dzaj007,g_date 
               FREE dzaj_prep2
               
               #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
               LET ls_trigger = "sadzp060_1_update_dzaj_t : update dzaj_t data : dzaj099"
               UPDATE dzaj_t 
                  SET dzaj099=lr_dzaj.dzaj099
                WHERE dzaj001=gs_prog AND
                      dzaj002=l_name AND
                      dzaj003=g_revision AND
                      dzaj004=g_env 
               FREE lr_dzaj.dzaj099
            END IF
            
            #更新dzaa_t.
            #依據更新標示(p_status_flag)來當作更新順序(先做d,再做u)
            IF (p_status_flag.equals("u") AND ls_status.equals("u")) OR
               (p_status_flag.equals("d") AND ls_status.equals("d")) THEN
               IF NOT sadzp060_1_update_dzaa_t(l_name, "7", ls_status, ls_cite_std) THEN
                  RETURN FALSE #就不再EXIT WHILE後才判斷了..
               END IF
            END IF
         END IF #NOT cl_null(ls_status)

         #CALL sadzp060_1_update_dzer_t(lnode_field) #2014/01/23 by Hiko #2014/08/25 by Hiko

         LET lnode_field = lnode_field.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<help_code>屬性資料,更新dzak_t.
# Input parameter : p_node_help_code <help_code> node
#                 : p_status_flag 更新標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/06 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzak_t(p_node_help_code, p_status_flag)
   DEFINE p_node_help_code xml.DomNode,
          p_status_flag STRING #2014/09/22 by Hiko
   DEFINE lnode_field xml.DomNode,
          ls_status STRING,
          l_name LIKE dzak_t.dzak002
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzak RECORD LIKE dzak_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET lnode_field = p_node_help_code.getFirstChildElement()
      WHILE lnode_field IS NOT NULL
         LET ls_status = lnode_field.getAttribute("status") CLIPPED
         IF NOT cl_null(ls_status) THEN
            LET l_name = lnode_field.getAttribute("name") CLIPPED

            #Begin:2014/12/22 by Hiko
            CALL sadzp060_1_get_spec_element_curr_revision(l_name) RETURNING lb_result,l_dzaa004,l_dzaa006
            IF NOT lb_result THEN
               RETURN FALSE
            END IF

            IF g_account="topstd" THEN
               IF l_dzaa006 CLIPPED="c" THEN
                  DISPLAY "[INFO]sadzp060_1_update_dzak_t : We can't update the type of src='c' data:",l_name," for topstd!"
                  RETURN TRUE
               END IF
               
               #Begin:2015/08/03 by Hiko
               ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
               #LET g_revision = l_dzaa004
               #IF cl_null(g_revision) OR g_revision=0 THEN
               #   LET g_revision = 1 #表示新增
               #END IF
               #End:2015/08/03 by Hiko

               #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
               LET g_revision = g_head_ver
               IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
                  LET g_revision = l_dzaa004  
               END IF
               
               LET g_env = GS_DGENV
               IF NOT cl_null(l_dzaa006) THEN
                  LET g_env = l_dzaa006
               END IF
               #End:2015/11/11 by Hiko
            END IF
            #End:2014/12/22 by Hiko

            LET ls_cite_std = lnode_field.getAttribute("cite_std") CLIPPED
            IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
               LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
            END IF
            IF p_status_flag.equals("u") AND ls_status.equals("u") THEN
               LET lr_dzak.dzak005 = lnode_field.getAttribute("help_wc") CLIPPED
               LET lr_dzak.dzak007 = lnode_field.getAttribute("help_find") CLIPPED
               LET lr_dzak.dzak008 = lnode_field.getAttribute("help_table") CLIPPED
               LET lr_dzak.dzak009 = lnode_field.getAttribute("help_field") CLIPPED
               LET lr_dzak.dzak010 = lnode_field.getAttribute("help_dlang") CLIPPED #沒有設定也沒關係
               LET lr_dzak.dzak011 = lnode_field.getAttribute("mapping_widget") CLIPPED

               #hfield為u,則field就為u; field為u,hfield不一定為u ==>所以這裡只處理field為u的動作.
               #hfield為d,field不一定為d; field為d,hfield一定為d
               #原本要增加複製dzac_t的動作,這是為了防呆,但因為dzac_t非常有可能是在dzak_t更新前就執行更新,
               #但因為還沒COMMIT,所以有可能會在複製過程當中出現Key值重複的問題,因此作罷.
               LET ls_where = " WHERE dzak001='",gs_prog,"' AND dzak002='",l_name,"' AND dzak003=",g_revision," AND dzak004='",g_env,"'"
               LET ls_trigger = "sadzp060_1_update_dzak_t : check dzak_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzak_t",ls_where
               PREPARE dzak_prep1 FROM ls_sql
               EXECUTE dzak_prep1 INTO li_cnt
               FREE dzak_prep1
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzak_t : update dzak_t data"
                  LET ls_sql = "UPDATE dzak_t", #沒有dzak006,也不需要depend_field.
                                 " SET dzak005=?,",
                                      "dzak007='",lr_dzak.dzak007 CLIPPED,"',",
                                      "dzak008='",lr_dzak.dzak008 CLIPPED,"',",
                                      "dzak009='",lr_dzak.dzak009 CLIPPED,"',",
                                      "dzak010='",lr_dzak.dzak010 CLIPPED,"',",
                                      "dzak011='",lr_dzak.dzak011 CLIPPED,"',",
                                      "dzak012='",gs_customer,"',",
                                      "dzakstus='Y',", 
                                      "dzakmoddt=?,", 
                                      "dzakmodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzak_t : insert dzak_t data"
                  LET ls_sql = "INSERT INTO dzak_t(dzak001,dzak002,dzak003,dzak004,dzak005,",
                                                  "dzak007,dzak008,dzak009,dzak010,dzak011,dzak012,",
                                                  "dzakcrtdt,dzakcrtdp,dzakowndp,dzakownid,dzakstus,dzakcrtid)",
                                          " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"',?,",
                                                  "'",lr_dzak.dzak007 CLIPPED,"','",lr_dzak.dzak008 CLIPPED,"','",lr_dzak.dzak009 CLIPPED,"','",lr_dzak.dzak010 CLIPPED,"','",lr_dzak.dzak011 CLIPPED,"','",gs_customer,"',",
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               
               PREPARE dzak_prep2 FROM ls_sql
               EXECUTE dzak_prep2 USING lr_dzak.dzak005,g_date 
               FREE dzak_prep2
            END IF
            #助記碼是跟著dzac_t,所以不用更新dzaa_t.
         END IF #NOT cl_null(ls_status)

         LET lnode_field = lnode_field.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<prog_rel>屬性資料,更新dzal_t.
# Input parameter : p_node_prog_rel <prog_rel> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
#                 : p_status_flag 更新標示
# Date & Author   : 2013/04/10 by Hiko
# Modify          : 2014/03/14 by Hiko 修改prog_rel的格式
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzal_t(p_node_prog_rel, p_status_flag)
   DEFINE p_node_prog_rel xml.DomNode,
          p_status_flag STRING #2014/09/22 by Hiko
   DEFINE lnode_field xml.DomNode,
          lnode_program xml.DomNode,
          ls_status STRING,
          l_name LIKE dzal_t.dzal002
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING, #dzal_t的更新用不到引用
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          la_dzal DYNAMIC ARRAY OF RECORD LIKE dzal_t.*,
          li_i SMALLINT
   #End:2014/05/06 by Hiko
   DEFINE ls_depend_field STRING, #2014/07/09 by Hiko
          lnode_dzac xml.DomNode

   TRY
      LET lnode_field = p_node_prog_rel.getFirstChildElement() #<pfield>
      WHILE lnode_field IS NOT NULL
         LET ls_status = lnode_field.getAttribute("status") CLIPPED
         IF NOT cl_null(ls_status) THEN
            LET l_name = lnode_field.getAttribute("name") CLIPPED

            CALL sadzp060_1_get_spec_element_curr_revision(lnode_field.getAttribute("depend_field") CLIPPED) RETURNING lb_result,l_dzaa004,l_dzaa006 #2014/05/29 by Hiko
            IF NOT lb_result THEN
               RETURN FALSE
            END IF

            IF p_status_flag.equals("u") AND ls_status.equals("u") THEN
               #Begin:2014/12/22 by Hiko
               IF g_account="topstd" THEN
                  IF l_dzaa006 CLIPPED="c" THEN
                     DISPLAY "[INFO]sadzp060_1_update_dzal_t : We can't update the type of src='c' data:EXCLUDE for topstd!"
                     RETURN TRUE
                  END IF
                  
                  #Begin:2015/08/03 by Hiko
                  ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
                  #LET g_revision = l_dzaa004
                  #IF cl_null(g_revision) OR g_revision=0 THEN
                  #   LET g_revision = 1 #表示新增
                  #END IF
                  #End:2015/08/03 by Hiko

                  #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
                  LET g_revision = g_head_ver
                  IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
                     LET g_revision = l_dzaa004  
                  END IF
                  
                  LET g_env = GS_DGENV
                  IF NOT cl_null(l_dzaa006) THEN
                     LET g_env = l_dzaa006
                  END IF
                  #End:2015/11/11 by Hiko
               END IF
               #End:2014/12/22 by Hiko

               #將符合條件的所有dzal_t變成d,在逐一變成u.(類似ScreenRecord作法)
               IF NOT sadzp060_1_copy_dzal_t(l_name, l_dzaa004, l_dzaa006) THEN #此FUNCTION不需要異動dzaa_t.
                  RETURN FALSE
               END IF

               LET lnode_program = lnode_field.getFirstChildElement()
               LET li_i = 1
               CALL la_dzal.CLEAR()
               WHILE lnode_program IS NOT NULL
                  LET la_dzal[li_i].dzal005 = lnode_field.getAttribute("depend_field") CLIPPED
                  LET la_dzal[li_i].dzal006 = lnode_program.getAttribute("name") CLIPPED
                  LET la_dzal[li_i].dzal007 = lnode_program.getAttribute("type") CLIPPED
                  IF cl_null(la_dzal[li_i].dzal007) THEN
                     LET la_dzal[li_i].dzal007 = "1"
                  END IF
                  LET la_dzal[li_i].dzal008 = lnode_program.getAttribute("order") CLIPPED

                  #Begin:2014/12/30 by Hiko:本段更新是從下面搬過來的
                  LET ls_where = " WHERE dzal001='",gs_prog,"' AND dzal002='",l_name,"' AND dzal003=",g_revision," AND dzal004='",g_env,"' AND dzal008=",la_dzal[li_i].dzal008
                  LET ls_trigger = "sadzp060_1_update_dzal_t : check dzal_t new ver data count"
                  LET ls_sql = "SELECT count(*) FROM dzal_t",ls_where
                  PREPARE dzal_prep3 FROM ls_sql
                  EXECUTE dzal_prep3 INTO li_cnt
                  FREE dzal_prep3
                  IF li_cnt>0 THEN #資料已存在.
                     LET ls_trigger = "sadzp060_1_update_dzal_t : update dzal_t data"
                     LET ls_sql = "UPDATE dzal_t", 
                                    " SET dzal005='",la_dzal[li_i].dzal005 CLIPPED,"',",
                                         "dzal006='",la_dzal[li_i].dzal006 CLIPPED,"',",
                                         "dzal007='",la_dzal[li_i].dzal007 CLIPPED,"',", 
                                         "dzal009='",gs_customer,"',", 
                                         "dzalstus='Y',", 
                                         "dzalmoddt=?,", 
                                         "dzalmodid='",g_user,"' ",ls_where
                  ELSE
                     LET ls_trigger = "sadzp060_1_update_dzal_t : insert dzal_t data"
                     LET ls_sql = "INSERT INTO dzal_t(dzal001,dzal002,dzal003,dzal004,dzal005,",
                                                     "dzal006,dzal007,dzal008,dzal009,",
                                                     "dzalcrtdt,dzalcrtdp,dzalowndp,dzalownid,dzalstus,dzalcrtid)",
                                             " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"','",la_dzal[li_i].dzal005 CLIPPED,"',",
                                                     "'",la_dzal[li_i].dzal006 CLIPPED,"','",la_dzal[li_i].dzal007 CLIPPED,"',",la_dzal[li_i].dzal008 CLIPPED,",'",gs_customer,"',",
                                                     "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
                  END IF
                  
                  PREPARE dzal_prep4 FROM ls_sql
                  EXECUTE dzal_prep4 USING g_date 
                  FREE dzal_prep4
                  #Emd:2014/12/30 by Hiko

                  LET lnode_program = lnode_program.getNextSiblingElement()
                  LET li_i = li_i + 1
               END WHILE

               #Begin:2014/12/30 by Hiko:不需要分兩段處理
               ##收集資料再一起更新.
               #LET li_i = 0 #變數初始化
               #FOR li_i=1 TO la_dzal.getLength()
               #   LET ls_where = " WHERE dzal001='",gs_prog,"' AND dzal002='",l_name,"' AND dzal003=",g_revision," AND dzal004='",g_env,"' AND dzal008=",la_dzal[li_i].dzal008
               #   LET ls_trigger = "sadzp060_1_update_dzal_t : check dzal_t new ver data count"
               #   LET ls_sql = "SELECT count(*) FROM dzal_t",ls_where
               #   PREPARE dzal_prep3 FROM ls_sql
               #   EXECUTE dzal_prep3 INTO li_cnt
               #   FREE dzal_prep3
               #   IF li_cnt>0 THEN #資料已存在.
               #      LET ls_trigger = "sadzp060_1_update_dzal_t : update dzal_t data"
               #      LET ls_sql = "UPDATE dzal_t", 
               #                     " SET dzal005='",la_dzal[li_i].dzal005 CLIPPED,"',",
               #                          "dzal006='",la_dzal[li_i].dzal006 CLIPPED,"',",
               #                          "dzal007='",la_dzal[li_i].dzal007 CLIPPED,"',", 
               #                          "dzal009='",gs_customer,"',", 
               #                          "dzalstus='Y',", 
               #                          "dzalmoddt=?,", 
               #                          "dzalmodid='",g_user,"' ",ls_where
               #   ELSE
               #      LET ls_trigger = "sadzp060_1_update_dzal_t : insert dzal_t data"
               #      LET ls_sql = "INSERT INTO dzal_t(dzal001,dzal002,dzal003,dzal004,dzal005,",
               #                                      "dzal006,dzal007,dzal008,dzal009,",
               #                                      "dzalcrtdt,dzalcrtdp,dzalowndp,dzalownid,dzalstus,dzalcrtid)",
               #                              " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"','",la_dzal[li_i].dzal005 CLIPPED,"',",
               #                                      "'",la_dzal[li_i].dzal006 CLIPPED,"','",la_dzal[li_i].dzal007 CLIPPED,"',",la_dzal[li_i].dzal008 CLIPPED,",'",gs_customer,"',",
               #                                      "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               #   END IF
               #   
               #   PREPARE dzal_prep4 FROM ls_sql
               #   EXECUTE dzal_prep4 USING g_date 
               #   FREE dzal_prep4
               #END FOR
               #End:2014/12/30 by Hiko

               #Begin:2014/12/22 by Hiko
               #Begin:2014/07/09 by Hiko:u的時候要強制同步異動<field>,d的時候不用:這段可避免只更新dzal_t但沒有更新dzac_t的情況發生.
               #LET li_i = 0 #變數初始化
               #LET ls_depend_field = lnode_field.getAttribute("depend_field")
               #FOR li_i=1 TO glst_field.getCount()
               #   LET lnode_dzac = glst_field.getItem(li_i)
               #   IF lnode_dzac.getAttribute("name")=ls_depend_field THEN #找到程式串查的依附控件欄位
               #      LET ls_trigger = "sadzp060_1_update_tsd : sadzp060_1_update_dzac_t by prog_rel"
               #      CALL sadzp060_1_update_dzac_t(lnode_dzac, "u") RETURNING lb_result
               #      DISPLAY "call sadzp060_1_update_dzac_t by prog_rel finish"
               #      EXIT FOR
               #   END IF
               #END FOR
               #
               #IF NOT lb_result THEN
               #   RETURN FALSE
               #END IF
               #End:2014/07/09 by Hiko
               #End:2014/12/22 by Hiko
            ELSE #d #2014/12/22 by Hiko:這段已經不需要,但由呼叫端決定即可.
               IF p_status_flag.equals("d") AND ls_status.equals("d") THEN
                  #有可能是刪除原本引用的控件,所以'd'的時候有可能也是'引用',所以就不判斷ls_cite_std.equals("N").
                  #有找到就整批更新為失效,沒找到就無所謂.
                  LET ls_where = " WHERE dzal001='",gs_prog,"' AND dzal002='",l_name,"' AND dzal003=",g_revision," AND dzal004='",g_env,"'"
                  IF NOT sadzp060_1_disable_status("dzal_t", ls_where, "dzal004", "dzal009") THEN 
                     RETURN FALSE
                  END IF
               END IF
            END IF
            
            #程式串查是跟著dzac_t,所以不用更新dzaa_t.
         END IF #NOT cl_null(ls_status)

         LET lnode_field = lnode_field.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<act>屬性資料,更新dzad_t.
# Input parameter : p_node_act <act> node
#                   p_status 更新狀態
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzad_t(p_node_act, p_status)
   DEFINE p_node_act xml.DomNode,
          p_status STRING 
   DEFINE l_id LIKE dzad_t.dzad002
   DEFINE ls_sql STRING,
          ls_where STRING,
          ls_trigger STRING,
          li_cnt SMALLINT 
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lr_dzad RECORD LIKE dzad_t.*
   #End:2014/05/06 by Hiko

   TRY
      LET p_status = p_status CLIPPED
      IF NOT cl_null(p_status) THEN
         LET l_id = p_node_act.getAttribute("id") CLIPPED

         #Begin:2014/12/22 by Hiko
         CALL sadzp060_1_get_spec_element_curr_revision(l_id) RETURNING lb_result,l_dzaa004,l_dzaa006
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         IF g_account="topstd" THEN
            IF l_dzaa006 CLIPPED="c" THEN
               DISPLAY "[INFO]sadzp060_1_update_dzad_t : We can't update the type of src='c' data:",l_id," for topstd!"
               RETURN TRUE
            END IF

            #Begin:2015/08/03 by Hiko
            ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
            #LET g_revision = l_dzaa004
            #IF cl_null(g_revision) OR g_revision=0 THEN
            #   LET g_revision = 1 #表示新增
            #END IF
            #End:2015/08/03 by Hiko

            #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
            LET g_revision = g_head_ver
            IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
               LET g_revision = l_dzaa004  
            END IF
            
            LET g_env = GS_DGENV
            IF NOT cl_null(l_dzaa006) THEN
               LET g_env = l_dzaa006
            END IF
            #End:2015/11/11 by Hiko
         END IF
         #End:2014/12/22 by Hiko

         LET ls_cite_std = p_node_act.getAttribute("cite_std") CLIPPED
         IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
            LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
         END IF
         IF p_status.equals("u") THEN
            LOCATE lr_dzad.dzad099 IN FILE
            LET lr_dzad.dzad006 = p_node_act.getAttribute("type") CLIPPED
            IF cl_null(lr_dzad.dzad006) THEN
               LET lr_dzad.dzad006 = "all"
            END IF
            LET lr_dzad.dzad007 = p_node_act.getAttribute("gen_code") CLIPPED
            IF cl_null(lr_dzad.dzad007) THEN
               LET lr_dzad.dzad007 = "Y"
            END IF
            LET lr_dzad.dzad099 = sadzp060_1_get_cdata(p_node_act)
         
            LET ls_where = " WHERE dzad001='",gs_prog,"' AND dzad002='",l_id,"' AND dzad003=",g_revision," AND dzad005='",g_env,"'"
            LET ls_trigger = "sadzp060_1_update_dzad_t : check dzad_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzad_t",ls_where
            PREPARE dzad_prep1 FROM ls_sql
            EXECUTE dzad_prep1 INTO li_cnt
            FREE dzad_prep1
            IF li_cnt>0 THEN #資料已存在.
               #Action改放在4tm,且是透過設定,所以不需要群組資訊.
               LET ls_trigger = "sadzp060_1_update_dzad_t : update dzad_t data"
               LET ls_sql = "UPDATE dzad_t",
                              " SET dzad006='",lr_dzad.dzad006 CLIPPED,"',",
                                   "dzad007='",lr_dzad.dzad007 CLIPPED,"',", #2014/04/30 by Hiko
                                   "dzad008='",gs_customer,"',",
                                   "dzadstus='Y',", 
                                   "dzadmoddt=?,", 
                                   "dzadmodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_1_update_dzad_t : insert dzad_t data"
               LET ls_sql = "INSERT INTO dzad_t(dzad001,dzad002,dzad003,dzad005,dzad006,dzad007,dzad008,",
                                               "dzadcrtdt,dzadcrtdp,dzadowndp,dzadownid,dzadstus,dzadcrtid)",
                                       " VALUES('",gs_prog,"','",l_id,"',",g_revision,",'",g_env,"','",lr_dzad.dzad006 CLIPPED,"','",lr_dzad.dzad007 CLIPPED,"','",gs_customer,"',",
                                               "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
            END IF
            PREPARE dzad_prep2 FROM ls_sql
            EXECUTE dzad_prep2 USING g_date 
            FREE dzad_prep2
         
            #更新規格描述資料:上面就算是INSERT的動作,執行到此也是UPDATE.
            LET ls_trigger = "sadzp060_1_update_dzad_t : update dzad_t data : dzad099"
            UPDATE dzad_t 
               SET dzad099=lr_dzad.dzad099
             WHERE dzad001=gs_prog AND
                   dzad002=l_id AND
                   dzad003=g_revision AND
                   dzad005=g_env 
            FREE lr_dzad.dzad099
         END IF
         
         #更新dzaa_t.
         RETURN sadzp060_1_update_dzaa_t(l_id, "2", p_status, ls_cite_std)
      END IF

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新畫面多語言檔.
# Input parameter : p_node_str <str> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_str(p_node_str)
   DEFINE p_node_str xml.DomNode
   DEFINE lnode_child xml.DomNode,
          ls_tag_name STRING,
          ls_lstr STRING,
          ls_name STRING,
          ls_text STRING,
          ls_comment STRING 
   DEFINE lb_result BOOLEAN,
          lb_result2 BOOLEAN,
          ls_trigger STRING

   LET lb_result = TRUE 
   LET lb_result2 = FALSE #這是為了判斷是否需要重新產生42s的依據 

   LET lnode_child = p_node_str.getFirstChildElement()
   WHILE (lnode_child IS NOT NULL)
      LET ls_tag_name = lnode_child.getLocalName() CLIPPED
      LET ls_lstr = lnode_child.getAttribute("lstr") CLIPPED
      IF NOT cl_null(ls_lstr) THEN
         IF ls_lstr.equals("u") THEN
            IF NOT lb_result2 THEN
               LET lb_result2 = TRUE
            END IF
            LET ls_name = lnode_child.getAttribute("name") CLIPPED
            LET ls_text = lnode_child.getAttribute("text") CLIPPED
            CASE ls_tag_name
               WHEN "sfield" 
                  CALL s_azzi902_ins_gzzd(gs_prog, ls_name, ls_text, '') RETURNING lb_result #2014/04/03 by Hiko
               WHEN "sact"
                  CALL s_azzi903_ins_gzzq(gs_prog, ls_name, ls_text, '') RETURNING lb_result #2014/04/03 by Hiko
            END CASE
         END IF
      END IF

      IF NOT lb_result THEN
         EXIT WHILE
      END IF

      LET lnode_child = lnode_child.getNextSiblingElement() #取得下一個兄弟節點.
   END WHILE

   IF lb_result AND lb_result2 THEN #2014/03/24 by Hiko
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得<exclude>屬性資料,更新dzam_t.
# Input parameter : p_node_exclude <table> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/09/26 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzam_t(p_node_exclude)
   DEFINE p_node_exclude xml.DomNode	  
   DEFINE lnode_widget xml.DomNode,
          lb_result BOOLEAN,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006,
          lb_been_copied BOOLEAN, #複製只需要做一次即可.
	  ls_widget_name STRING,
          ls_status STRING,
	  ls_sql STRING,
	  ls_trigger STRING,
	  li_cnt SMALLINT,
	  ls_where STRING

   #dzam_t(排除設定)沒有引用.
   TRY
      LET lb_been_copied = FALSE
      LET lnode_widget = p_node_exclude.getFirstChildElement()
      WHILE lnode_widget IS NOT NULL
         LET ls_widget_name = lnode_widget.getAttribute("name") CLIPPED
         LET ls_status = lnode_widget.getAttribute("status")
         IF NOT cl_null(ls_status) THEN
            IF NOT lb_been_copied THEN #這裡只做一次而已.
               #Begin:2014/12/22 by Hiko
               CALL sadzp060_1_get_spec_element_curr_revision("EXCLUDE") RETURNING lb_result,l_dzaa004,l_dzaa006
               IF NOT lb_result THEN
                  RETURN FALSE
               END IF
               
               IF g_account="topstd" THEN
                  IF l_dzaa006 CLIPPED="c" THEN
                     DISPLAY "[INFO]sadzp060_1_update_dzam_t : We can't update the type of src='c' data:EXCLUDE for topstd!"
                     RETURN TRUE
                  END IF
                  
                  #Begin:2015/08/03 by Hiko
                  ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
                  #LET g_revision = l_dzaa004
                  #IF cl_null(g_revision) OR g_revision=0 THEN
                  #   LET g_revision = 1 #表示新增
                  #END IF
               #End:2014/12/22 by Hiko

                  #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
                  LET g_revision = g_head_ver
                  IF NOT cl_null(l_dzaa004) AND l_dzaa004<>0 THEN
                     LET g_revision = l_dzaa004  
                  END IF
                  
                  LET g_env = GS_DGENV
                  IF NOT cl_null(l_dzaa006) THEN
                     LET g_env = l_dzaa006
                  END IF
                  #End:2015/11/11 by Hiko

                  #topstd不需要做複製舊版的動作,直接異動即可.

                  CALL sadzp060_1_update_dzaa_t("EXCLUDE", "a", "u", "N") RETURNING lb_result #sadzp060_1_copy_dzam_t內有異動dzaa_t, 這邊算補做.
                  IF NOT lb_result THEN
                     RETURN FALSE
                  END IF
                  #End:2015/08/03 by Hiko
               ELSE
                  #只要有異動,不論u,d,都需要複製前版次為基底.
                  IF NOT sadzp060_1_copy_dzam_t(l_dzaa004, l_dzaa006) THEN #dzaa_t是在此FUNCTION內異動.
                     RETURN FALSE
                  END IF
               END IF
               
               LET lb_been_copied = TRUE
            END IF
            
            #執行dzam_t的異動.
            LET ls_where = " WHERE dzam001='",gs_prog,"' AND dzam003='",ls_widget_name,"' AND dzam004=",g_revision," AND dzam005='",g_env,"'"
            IF ls_status.equals("u") THEN
               LET ls_trigger = "sadzp060_1_update_dzam_t : check dzam_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzam_t",ls_where
               PREPARE dzam_prep2 FROM ls_sql
               EXECUTE dzam_prep2 INTO li_cnt
               FREE dzam_prep2
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzam_t : update dzam_t data"
                  LET ls_sql = "UPDATE dzam_t",
                                 " SET dzam002='",g_env,"',",
                                      "dzam005='",g_env,"',",
                                      "dzam006='",gs_customer,"',",
                                      "dzamstus='Y',", 
                                      "dzammoddt=?,",
                                      "dzammodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzam_t : insert dzam_t data"
                  LET ls_sql = "INSERT INTO dzam_t(dzam001,dzam002,dzam003,dzam004,dzam005,dzam006,",
                                                  "dzamcrtdt,dzamcrtdp,dzamowndp,dzamownid,dzamstus,dzamcrtid)",
                                          " VALUES('",gs_prog,"','",g_env,"','",ls_widget_name,"',",g_revision,",'",g_env,"','",gs_customer,"',",
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               
               PREPARE dzam_prep3 FROM ls_sql
               EXECUTE dzam_prep3 USING g_date 
               FREE dzam_prep3
            ELSE #'d'
               IF NOT sadzp060_1_disable_status("dzam_t", ls_where, "dzam005", "dzam006") THEN 
                  RETURN FALSE
               END IF
            END IF
         END IF #IF NOT cl_null(ls_status)

         LET lnode_widget = lnode_widget.getNextSiblingElement()
      END WHILE

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzam_t.
# Input parameter : p_old_revision Server上EXCLUDE對應的版次
#                 : p_old_use_flag Server上EXCLUDE對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/09/26 by Hiko
# Modify          : 2014/03/19 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_dzam_t(p_old_revision, p_old_use_flag)
   DEFINE p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   TRY
      #dzam_t和dzff_t不同的地方在於條件不需要g_env,所以也沒有客製新增的處理段落.
      LET ls_trigger = "sadzp060_1_copy_dzam_t : check dzam_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzam_t"
      LET ls_where = " WHERE dzam001='",gs_prog,"'"
      LET ls_revision_wc = " AND dzam004=",g_revision," AND dzam005='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc
      PREPARE dzam_prep0 FROM ls_sql
      EXECUTE dzam_prep0 INTO li_cnt
      FREE dzam_prep0
      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_dzam_t : check dzam_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzam004='",p_old_revision,"' AND dzam005='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc
         PREPARE dzam_prep1 FROM ls_sql
         EXECUTE dzam_prep1 INTO li_cnt
         FREE dzam_prep1
         IF li_cnt>0 THEN
            #找到舊版就複製為新版,狀態碼不變:版次(dzam004)為舊版.
            LET ls_trigger = "sadzp060_1_copy_dzam_t : insert dzam_t:old ver=",p_old_revision,",old use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzam_t(dzam001,dzam002,dzam003,dzam004,dzam005,",
                                            "dzamcrtdt,dzamcrtdp,dzamowndp,dzamownid,dzamstus,dzamcrtid)",
                                    " SELECT dzam001,dzam002,dzam003,",g_revision,",'",g_env,"',",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"',dzamstus,'",g_user,"'",
                                      " FROM dzam_t",ls_where,ls_revision_wc," AND dzamstus='Y'"
            PREPARE dzam_prep8 FROM ls_sql
            EXECUTE dzam_prep8 USING g_date
            FREE dzam_prep8
         END IF
      END IF
	  
      #排除設定不會引用,且有異動就是"Y".
      RETURN sadzp060_1_update_dzaa_t("EXCLUDE", "a", "u", "N") #2014/03/25 by Hiko
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製舊版dzak_t為新版(dzac_t同步使用).
# Input parameter : p_name 程式串查的控件名稱
#                 : p_old_revision Server上程式串查的控件名稱對應的版次
#                 : p_old_use_flag Server上程式串查的控件名稱對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/12/22 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_old_dzak_t(p_name, p_old_revision, p_old_use_flag)
   DEFINE p_name STRING,
          p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   LET p_name = p_name.trim()

   TRY
      LET ls_trigger = "sadzp060_1_copy_old_dzak_t : check dzak_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzak_t"
      LET ls_where = " WHERE dzak001='",gs_prog,"' AND dzak002='",p_name,"'"
      LET ls_revision_wc = " AND dzak003=",g_revision
      LET ls_env_wc = " AND dzak004='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzak_prep10 FROM ls_sql
      EXECUTE dzak_prep10 INTO li_cnt
      FREE dzak_prep10
      IF li_cnt=0 THEN #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_old_dzak_t : check dzak_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzak003=",p_old_revision
         LET ls_env_wc = " AND dzak004='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzak_prep11 FROM ls_sql
         EXECUTE dzak_prep11 INTO li_cnt
         FREE dzak_prep11
         IF li_cnt>0 THEN #找到舊版就複製有效的資料為新版. 
            LET ls_trigger = "sadzp060_1_copy_old_dzak_t : insert dzak_t:old ver=",p_old_revision,",new use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzak_t(dzak001,dzak002,dzak003,dzak004,dzak005,",
                                            "dzak007,dzak008,dzak009,dzak010,",
                                            "dzak011,dzak012,",
                                            "dzakcrtdt,dzakcrtdp,dzakowndp,dzakownid,dzakstus,dzakcrtid)",
                                    " SELECT dzak001,dzak002,",g_revision,",'",g_env,"',dzak005,",
                                            "dzak007,dzak008,dzak009,dzak010,",
                                            "dzak011,dzak012,",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"'",
                                      " FROM dzak_t",ls_where,ls_revision_wc,ls_env_wc," AND dzakstus='Y'"
            PREPARE dzak_prep12 FROM ls_sql
            EXECUTE dzak_prep12 USING g_date
            FREE dzak_prep12
         END IF
      END IF
	  
      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製舊版dzal_t為新版(dzac_t同步使用).
# Input parameter : p_name 程式串查的控件名稱
#                 : p_old_revision Server上程式串查的控件名稱對應的版次
#                 : p_old_use_flag Server上程式串查的控件名稱對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/12/22 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_old_dzal_t(p_name, p_old_revision, p_old_use_flag)
   DEFINE p_name STRING,
          p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT

   LET p_name = p_name.trim()

   TRY
      LET ls_trigger = "sadzp060_1_copy_old_dzal_t : check dzal_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzal_t"
      LET ls_where = " WHERE dzal001='",gs_prog,"' AND dzal005='",p_name,"'" #依附控件
      LET ls_revision_wc = " AND dzal003=",g_revision
      LET ls_env_wc = " AND dzal004='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzal_prep10 FROM ls_sql
      EXECUTE dzal_prep10 INTO li_cnt
      FREE dzal_prep10
      IF li_cnt=0 THEN #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_old_dzal_t : check dzal_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzal003=",p_old_revision
         LET ls_env_wc = " AND dzal004='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzal_prep11 FROM ls_sql
         EXECUTE dzal_prep11 INTO li_cnt
         FREE dzal_prep11
         IF li_cnt>0 THEN #找到舊版就複製有效的資料為新版. 
            LET ls_trigger = "sadzp060_1_copy_old_dzal_t : insert dzal_t:old ver=",p_old_revision,",new use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzal_t(dzal001,dzal002,dzal003,dzal004,dzal005,",
                                            "dzal006,dzal007,dzal008,dzal009,",
                                            "dzalcrtdt,dzalcrtdp,dzalowndp,dzalownid,dzalstus,dzalcrtid)",
                                    " SELECT dzal001,dzal002,",g_revision,",'",g_env,"',dzal005,",
                                            "dzal006,dzal007,dzal008,dzal009,",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"'",
                                      " FROM dzal_t",ls_where,ls_revision_wc,ls_env_wc," AND dzalstus='Y'"
            PREPARE dzal_prep12 FROM ls_sql
            EXECUTE dzal_prep12 USING g_date
            FREE dzal_prep12
         END IF
      END IF
	  
      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 複製dzal_t.
# Input parameter : p_name 程式串查的控件名稱
#                 : p_old_revision Server上程式串查的控件名稱對應的版次
#                 : p_old_use_flag Server上程式串查的控件名稱對應的使用標示
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/03/14 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_copy_dzal_t(p_name, p_old_revision, p_old_use_flag)
   DEFINE p_name STRING,
          p_old_revision LIKE dzaa_t.dzaa004,
          p_old_use_flag LIKE dzaa_t.dzaa006
   DEFINE ls_sql STRING,
          ls_sel STRING,
          ls_where STRING,
          ls_revision_wc STRING,
          ls_env_wc STRING,
          ls_trigger STRING,
          li_cnt SMALLINT,
          l_dzalstus LIKE dzal_t.dzalstus

   #dzff_t和dzal_t雷同.
   LET p_name = p_name.trim()

   TRY
      LET ls_trigger = "sadzp060_1_copy_dzal_t : check dzal_t data count:new ver=",g_revision,",new use flag=",g_env
      LET ls_sel = "SELECT count(*) FROM dzal_t"
      LET ls_where = " WHERE dzal001='",gs_prog,"' AND dzal002='",p_name,"'"
      LET ls_revision_wc = " AND dzal003=",g_revision
      LET ls_env_wc = " AND dzal004='",g_env,"'"
      LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
      PREPARE dzal_prep0 FROM ls_sql
      EXECUTE dzal_prep0 INTO li_cnt
      FREE dzal_prep0
      IF li_cnt=0 THEN
         #不存在就繼續找舊版的資料.
         LET ls_trigger = "sadzp060_1_copy_dzal_t : check dzal_t data count:old ver=",p_old_revision,",old use flag=",p_old_use_flag
         LET ls_revision_wc = " AND dzal003=",p_old_revision
         LET ls_env_wc = " AND dzal004='",p_old_use_flag,"'"
         LET ls_sql = ls_sel,ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzal_prep1 FROM ls_sql
         EXECUTE dzal_prep1 INTO li_cnt
         FREE dzal_prep1
         IF li_cnt>0 THEN
            #找到舊版就複製為新版,且全部為失效:版次(dzal003)為舊版,來源(dzal004)和g_env相同 #這段新增和上面雷同
            LET ls_trigger = "sadzp060_1_copy_dzal_t : insert dzal_t:old ver=",p_old_revision,",new use flag=",p_old_use_flag," to new ver=",g_revision
            LET ls_sql = "INSERT INTO dzal_t(dzal001,dzal002,dzal003,dzal004,dzal005,",
                                            "dzal006,dzal007,dzal008,",
                                            "dzalcrtdt,dzalcrtdp,dzalowndp,dzalownid,dzalstus,dzalcrtid)",
                                    " SELECT dzal001,dzal002,",g_revision,",'",g_env,"',dzal005,",
                                            "dzal006,dzal007,dzal008,",
                                            "?,'",gs_dept,"','",gs_dept,"','",g_user,"','N','",g_user,"'",
                                      " FROM dzal_t",ls_where,ls_revision_wc,ls_env_wc," AND dzalstus='Y'"
            PREPARE dzal_prep8 FROM ls_sql
            EXECUTE dzal_prep8 USING g_date
            FREE dzal_prep8
         END IF
      ELSE
         #找到同一版次且同一使用標示的資料,都是要變成失效.
         LET ls_trigger = "sadzp060_1_copy_dzal_t : update dzal_t status='N':new ver=",g_revision,",new use flag=",g_env
         LET ls_sql = "UPDATE dzal_t",
                        " SET dzalstus='N',", 
                             "dzalmoddt=?,", 
                             "dzalmodid='",g_user,"' ",ls_where,ls_revision_wc,ls_env_wc
         PREPARE dzal_prep9 FROM ls_sql
         EXECUTE dzal_prep9 USING g_date 
         FREE dzal_prep9
      END IF
	  
      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 更新tap檔對應的資料表.
# Input parameter : p_prog 程式代號
#                 : p_module 模組別
#                 : p_identity 識別標示(s/c)
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
# Modify          : 2013/09/04 by Hiko : 結構調整
##########################################################################
PUBLIC FUNCTION sadzp060_1_update_tap(p_prog, p_module, p_identity)
   DEFINE p_prog STRING,
          p_module STRING, 
          p_identity STRING
   DEFINE ls_modidle_dir STRING #模組目錄
   DEFINE ls_tap STRING,
          ldoc_tap xml.domDocument,
          lnode_tap xml.DomNode
   DEFINE lst_other XML.DomNodeList,
          lnode_other XML.DomNode
   DEFINE llist_node xml.DomNodeList,
          lnode_point xml.DomNode,
          lnode_section xml.DomNode #2014/02/13 by Hiko
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          li_i SMALLINT,
          ls_err_msg STRING,
          lb_trans BOOLEAN #2015/01/14 by Hiko
   #Begin:2014/05/06 by Hiko
   DEFINE lb_result BOOLEAN,
          ls_std_revision STRING,
          ls_std_identity STRING #2014/05/15 by Hiko
   #End:2014/05/06 by Hiko

   LET gs_prog = p_prog.trim()
   LET gs_module = p_module.toUpperCase()
   LET gs_identity = p_identity.trim()

   IF NOT sadzp060_1_init_var() THEN
      RETURN FALSE
   END IF

   TRY
      DISPLAY "call sadzp060_1_update_tap start!"
      #取得tap檔.
      LET ls_modidle_dir = FGL_GETENV(gs_module) CLIPPED
      LET ls_tap = os.path.join(os.path.join(os.path.join(ls_modidle_dir, "dzx"), "tap"), gs_prog||".tap")
      #產生tap檔根節點.
      LET ldoc_tap = xml.domDocument.create()
      LET ls_trigger = "sadzp060_1_update_tap : load tap=",ls_tap
      IF NOT os.Path.exists(ls_tap) THEN
         DISPLAY "ERROR : ",cl_replace_err_msg(cl_getmsg("adz-00175", g_lang), gs_prog||".tap")
         RETURN FALSE
      END IF
      CALL ldoc_tap.load(ls_tap)
      LET lnode_tap = ldoc_tap.getDocumentElement()

      #Begin:2015/07/03 by Hiko
      LET ls_tap = ls_tap,".read"
      CALL lnode_tap.setAttribute("booking", "N")
      IF NOT sadzp010_1_create_read_file(ldoc_tap, ls_tap) THEN
         RETURN FALSE
      END IF
      #End:2015/07/03 by Hiko

      LET lb_trans = FALSE
      BEGIN WORK #非常重要.
      LET lb_trans = TRUE

      LET g_revision = lnode_tap.getAttribute("ver") CLIPPED
      LET g_head_ver = g_revision #2014/12/22 by Hiko

      LET lst_other = lnode_tap.getElementsByTagName("other")
      LET lnode_other = lst_other.getItem(1) #目前只有一個other
      LET ls_trigger = "sadzp060_1_update_tap : sadzp060_1_update_dzax_t"
      CALL sadzp060_1_update_dzax_t(lnode_other) RETURNING lb_result 
      IF NOT lb_result THEN
         ROLLBACK WORK #非常重要.
         RETURN FALSE
      END IF
      DISPLAY "call sadzp060_1_update_dzax_t finish"

      #取得<point>屬性資料,更新dzbb_t.
      LET llist_node = ldoc_tap.getElementsByTagName("point")   
      FOR li_i=1 TO llist_node.getCount()
         LET lnode_point = llist_node.getItem(li_i)
         IF NOT sadzp060_1_update_dzbb_t(lnode_point) THEN
            ROLLBACK WORK #非常重要.
            RETURN FALSE
         END IF
      END FOR

      #Begin:2014/02/13 by Hiko : 取得<point>屬性資料,更新dzbb_t.
      LET llist_node = ldoc_tap.getElementsByTagName("section")   
      FOR li_i=1 TO llist_node.getCount()
         LET lnode_section = llist_node.getItem(li_i)
         IF NOT sadzp060_1_update_dzbd_t(lnode_section) THEN
            ROLLBACK WORK #非常重要.
            RETURN FALSE
         END IF
      END FOR
      #End:2014/02/13 by Hiko

      COMMIT WORK #非常重要.
      DISPLAY "call sadzp060_1_update_tap finish!"

      RETURN TRUE
   CATCH 
      IF lb_trans THEN
         ROLLBACK WORK #非常重要.
      END IF
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzbb_t.
# Input parameter : p_node_point <point> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2013/01/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzbb_t(p_node_point)
   DEFINE p_node_point xml.DomNode
   DEFINE l_name LIKE dzbb_t.dzbb002,
          ls_name STRING #這是為了刪除function.
   DEFINE ls_sql STRING
   DEFINE ls_trigger STRING,
          ls_status STRING,
          ls_where STRING,
          li_cnt SMALLINT,
          ls_order STRING 
   #Begin:2014/05/06 by Hiko
   DEFINE ls_cite_std STRING,
          lb_result BOOLEAN,
          l_dzba004 LIKE dzba_t.dzba004,
          l_dzba005 LIKE dzba_t.dzba005,
          lr_dzbb RECORD LIKE dzbb_t.*
   #End:2014/05/06 by Hiko
   DEFINE ls_stus STRING #2014/09/15 by Hiko
   #Begin:161215-00053
   DEFINE li_r            INTEGER,
          l_quick_name    LIKE dzbb_t.dzbb002,
          l_temp_name     LIKE dzbb_t.dzbb002,
          l_quick_dzba004 LIKE dzba_t.dzba004,
          l_quick_dzba005 LIKE dzba_t.dzba005
   #End:161215-00053

   TRY
      LET ls_status = p_node_point.getAttribute("status") CLIPPED
      IF NOT cl_null(ls_status) THEN
         LET l_name = p_node_point.getAttribute("name") CLIPPED

         #Begin:2014/12/22 by Hiko:若是topstd,則
         CALL sadzp060_1_get_adp_curr_revision(l_name) RETURNING lb_result,l_dzba004,l_dzba005
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         IF g_account="topstd" THEN
            IF l_dzba005 CLIPPED="c" THEN
               DISPLAY "[INFO]sadzp060_1_update_dzbb_t : We can't update the type of src='c' data:",l_name," for topstd!"
               RETURN TRUE
            END IF

            #Begin:2015/08/03 by Hiko
            ##g_revision的版次預設和g_head_ver相同,這邊就關注可能不同的情況即可.
            #LET g_revision = l_dzba004
            #IF cl_null(g_revision) OR g_revision=0 THEN
            #   LET g_revision = 1 #表示新增
            #END IF
            #End:2015/08/03 by Hiko

            #Begin:2015/11/11 by Hiko:topstd時,有來源資料就要覆寫,這樣才會正確.
            LET g_revision = g_head_ver
            IF NOT cl_null(l_dzba004) AND l_dzba004<>0 THEN
               LET g_revision = l_dzba004  
            END IF
            
            LET g_env = GS_DGENV
            IF NOT cl_null(l_dzba005) THEN
               LET g_env = l_dzba005
            END IF
            #End:2015/11/11 by Hiko
         END IF
         #End:2014/12/22 by Hiko

         LET ls_cite_std = p_node_point.getAttribute("cite_std") CLIPPED
         IF cl_null(ls_cite_std) THEN #2014/03/06 by Hiko
            LET ls_cite_std = "N" #既然要更新,表示有異動(斷開),所以行業別也預設為N
         END IF

         IF ls_status.equals("u") THEN
            LOCATE lr_dzbb.dzbb098 IN FILE
            LET lr_dzbb.dzbb098 = sadzp060_1_get_cdata(p_node_point)

            FOR li_r=1 TO 2 #161215-00053:標準環境要同步quick print的程式內容,所以預設跑兩次,條件不符合才跳開迴圈.
               LET ls_where = " WHERE dzbb001='",gs_prog,"' AND dzbb002='",l_name,"' AND dzbb003=",g_revision," AND dzbb004='",g_env,"'"
               LET ls_trigger = "sadzp060_1_update_dzbb_t : check dzbb_t new ver data count"
               LET ls_sql = "SELECT count(*) FROM dzbb_t",ls_where
               PREPARE dzbb_prep1 FROM ls_sql
               EXECUTE dzbb_prep1 INTO li_cnt
               FREE dzbb_prep1
               
               IF li_cnt>0 THEN #資料已存在.
                  LET ls_trigger = "sadzp060_1_update_dzbb_t : update dzbb_t data ",l_name
                  #更新dzbb005
                  LET ls_sql = "UPDATE dzbb_t",
                                 " SET dzbb005='",gs_customer,"',", 
                                      "dzbbstus='Y',", #dzbb005,dzbb006,dzbb007都改成no use
                                      "dzbbmoddt=?,", 
                                      "dzbbmodid='",g_user,"' ",ls_where
               ELSE
                  LET ls_trigger = "sadzp060_1_update_dzbb_t : insert dzbb_t data ",l_name
                  LET ls_sql = "INSERT INTO dzbb_t(dzbb001,dzbb002,dzbb003,dzbb004,dzbb005,dzbb006,dzbb007,",
                                                  "dzbbcrtdt,dzbbcrtdp,dzbbowndp,dzbbownid,dzbbstus,dzbbcrtid)",
                                          " VALUES('",gs_prog,"','",l_name,"',",g_revision,",'",g_env,"','",gs_customer,"','','',", 
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
               END IF
               PREPARE dzbb_prep2 FROM ls_sql
               EXECUTE dzbb_prep2 USING g_date
               FREE dzbb_prep2
               
               #更新程式代碼資料:上面就算是INSERT的動作,執行到此也是UPDATE.
               UPDATE dzbb_t 
                  SET dzbb098=lr_dzbb.dzbb098
                WHERE dzbb001=gs_prog AND
                      dzbb002=l_name AND
                      dzbb003=g_revision AND
                      dzbb004=g_env 

               #Begin:161215-00053
               IF (l_name="menu.output" OR l_name="menu.after_output") AND g_env="s" THEN
                  IF cl_null(l_temp_name) THEN #避免第2次進來.
                     #quick print內容若為客製則跳開.
                     IF l_name="menu.output" THEN
                        LET l_quick_name = "menu.quickprint"
                     ELSE
                        LET l_quick_name = "menu.after_quickprint"
                     END IF
                  
                     CALL sadzp060_1_get_adp_curr_revision(l_quick_name) RETURNING lb_result,l_quick_dzba004,l_quick_dzba005
                     IF lb_result THEN
                        IF l_quick_dzba005 CLIPPED="c" THEN
                           LET l_quick_name = ""
                           EXIT FOR
                        END IF
                        #同步的關係,版次就相同即可.
                        LET l_temp_name = l_name #更新dzba_t前要還原l_name.
                        LET l_name = l_quick_name
                     END IF
                  END IF
               ELSE
                  EXIT FOR
               END IF
            END FOR #161215-00053

            FREE lr_dzbb.dzbb098
         END IF
         
         #Begin:161215-00053
         IF NOT cl_null(l_quick_name) THEN #l_quick_name有資料, 表示符合要同步的條件, 先還原原本的l_name.
            LET l_name = l_temp_name
         END IF
         #End:161215-00053

         #更新dzba_t
         #Begin:2014/09/15 by Hiko
         LET ls_stus = ""
         IF ls_status.equals("u") THEN
            LET ls_stus = "Y"
         ELSE #前面已經判斷not null才可以進來,所以這邊就是失效,但為了防呆,還是判斷一下比較保險.
            IF ls_status.equals("d") THEN
               LET ls_stus = "N"
            END IF
         END IF
         #End:2014/09/15 by Hiko

         #dzbb_t不會有失效情況,add point頂多是空白或是註解,但一定是生效的.
         #dzba_t會有失效情況的一定是'function',且只在function沒有release情況下才有機會刪除(失效).
         LET ls_order = p_node_point.getAttribute("order") CLIPPED 

         FOR li_r=1 TO 2 #161215-00053:標準環境要同步quick print的程式內容,所以預設跑兩次,條件不符合才跳開迴圈.
            LET ls_where = " WHERE dzba001='",gs_prog,"' AND dzba002=",g_head_ver," AND dzba003='",l_name,"' AND dzba010='",gs_identity,"'"
            LET ls_trigger = "sadzp060_1_update_dzbb_t : check dzba_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzba_t",ls_where
            PREPARE dzba_prep1 FROM ls_sql
            EXECUTE dzba_prep1 INTO li_cnt
            FREE dzba_prep1
            
            IF li_cnt>0 THEN
               LET ls_trigger = "sadzp060_1_update_dzbb_t : update dzba_t data ",l_name
               LET ls_sql = "UPDATE dzba_t",
                              " SET dzba004=",g_revision,",",
                                   "dzba005='",g_env,"',",
                                   "dzba006='",ls_order,"',",
                                   "dzba007='",ls_cite_std,"',",
                                   "dzba008='",gs_erpver,"',",
                                   "dzba009='",p_node_point.getAttribute("mark_hard") CLIPPED,"',",
                                   "dzba011='",gs_customer,"',",
                                   "dzbastus='",ls_stus,"',",
                                   "dzbamoddt=?,", 
                                   "dzbamodid='",g_user,"' ",ls_where
            ELSE
               LET ls_trigger = "sadzp060_1_update_dzbb_t : insert dzba_t data"
               LET ls_sql = "INSERT INTO dzba_t(dzba001,dzba002,dzba003,dzba004,dzba005,",
                                               "dzba006,dzba007,dzba008,dzba009,dzba010,dzba011,", #2014/05/27 by Hiko
                                               "dzbacrtdt,dzbacrtdp,dzbaowndp,dzbaownid,dzbastus,dzbacrtid)",
                                       " VALUES('",gs_prog,"',",g_head_ver,",'",l_name,"',",g_revision,",'",g_env,"',",                  
                                               "'",ls_order,"','",ls_cite_std,"','",gs_erpver,"','",p_node_point.getAttribute("mark_hard") CLIPPED,"','",gs_identity,"','",gs_customer,"',",
                                               "?,'",gs_dept,"','",gs_dept,"','",g_user,"','",ls_stus,"','",g_user,"')"
            END IF
            
            PREPARE dzba_prep2 FROM ls_sql
            EXECUTE dzba_prep2 USING g_date
            FREE dzba_prep2

            #Begin:161215-00053
            IF NOT cl_null(l_quick_name) THEN #l_quick_name有資料, 表示符合要同步的條件, 替換l_name.
               LET l_name = l_quick_name
               LET l_quick_name = "" #防呆:避免第2次進來.
            ELSE
               EXIT FOR
            END IF
            #End:161215-00053
         END FOR #161215-00053
      END IF #IF NOT cl_null(ls_status)

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 更新dzbd_t.
# Input parameter : p_node_section <section> node
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2014/02/13 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_update_dzbd_t(p_node_section)
   DEFINE p_node_section xml.DomNode
   DEFINE l_id LIKE dzbd_t.dzbd002,
          ls_sql STRING,
          ls_trigger STRING,
          ls_status STRING,
          l_cdata LIKE dzbd_t.dzbd098,
          ls_where STRING,
          li_cnt SMALLINT,
          l_ver LIKE dzbd_t.dzbd003,   #2014/03/26 by Hiko
          l_flag LIKE dzbd_t.dzbd004,  #2014/04/11 by Hiko
          l_flag2 LIKE dzbd_t.dzbd004, #2014/09/30 by Hiko  
          lb_result BOOLEAN

   TRY
      LET ls_status = p_node_section.getAttribute("status") CLIPPED
      IF NOT cl_null(ls_status) THEN
         #SECTION不能異動dzbc004(section版次),因為這是產生器會處理的,這和add point的處理方式不同.
         LET l_id = p_node_section.getAttribute("id") CLIPPED

         CALL sadzp060_1_get_section_curr_revision(l_id) RETURNING lb_result,l_ver,l_flag #2014/05/29 by Hiko
         IF NOT lb_result THEN
            RETURN FALSE
         END IF

         #Begin:2014/12/22 by Hiko
         IF g_account="topstd" THEN
            IF l_flag CLIPPED="c" THEN #這段是防呆.
               DISPLAY "[INFO]sadzp060_1_update_dzbd_t : We can't update the type of src='c' data:",l_id," for topstd!"
               RETURN TRUE
            END IF

            #因為section的處理方式和其他都不同,因此不需要針對topstd時要覆寫版次與使用標示.
         END IF
         #End:2014/12/22 by Hiko

         #Begin:2014/04/11 by Hiko:SECTION的[識別碼使用標示]和add point不同,若為產中修改,則使用標示為'm';若為客製修改,則使用標示為'c'.
         IF g_env="s" THEN
            LET l_flag = "m"
         ELSE #c
            LET l_flag = "c"
         END IF

         LET ls_where = " WHERE dzbd001='",gs_prog,"' AND dzbd002='",l_id,"' AND dzbd003=",l_ver,""
         #End:2014/04/11 by Hiko

         IF ls_status.equals("u") THEN
            #SECTION沒有'引用'概念.
            LET ls_trigger = "sadzp060_1_update_dzbd_t : check dzbd_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzbd_t",ls_where," AND dzbd004='",l_flag,"'"
            PREPARE dzbd_prep1 FROM ls_sql
            EXECUTE dzbd_prep1 INTO li_cnt
            FREE dzbd_prep1
            
            IF li_cnt>0 THEN #資料已存在.
               LET ls_trigger = "sadzp060_1_update_dzbd_t : update dzbd_t data ",l_id
               LET ls_sql = "UPDATE dzbd_t",
                              " SET dzbd005='",gs_customer,"',",
                                   "dzbdstus='Y',", 
                                   "dzbdmoddt=?,", 
                                   "dzbdmodid='",g_user,"' ",ls_where," AND dzbd004='",l_flag,"'" #2014/12/29 by Hiko:增加dzbd004的條件
            
               PREPARE dzbd_prep2 FROM ls_sql
               EXECUTE dzbd_prep2 USING g_date
               FREE dzbd_prep2
            ELSE #Begin:2014/09/30 by Hiko:只有s-->m or s-->c才可以新增資源池,但section樹頭不可能透過設計器新增,頂多更新.
               LET ls_trigger = "sadzp060_1_update_dzbd_t : insert dzbd_t data ",l_id
               LET l_flag2 = "s"
               LET ls_sql = "SELECT count(*) FROM dzbd_t",ls_where," AND dzbd004='",l_flag2,"'" #先找s來源
               PREPARE dzbd_prep5 FROM ls_sql
               EXECUTE dzbd_prep5 INTO li_cnt
               FREE dzbd_prep5
               
               IF li_cnt=0 THEN
                  IF g_env="c" THEN #客製環境還要多找一個m來源
                     LET l_flag2 = "m"
                     LET ls_sql = "SELECT count(*) FROM dzbd_t",ls_where," AND dzbd004='",l_flag2,"'" #再找m來源
                     PREPARE dzbd_prep6 FROM ls_sql
                     EXECUTE dzbd_prep6 INTO li_cnt
                     FREE dzbd_prep6
                  END IF
               END IF
 
               IF li_cnt>0 THEN 
                  LET ls_sql = "INSERT INTO dzbd_t(dzbd001,dzbd002,dzbd003,dzbd004,dzbd005,",
                                                  "dzbdcrtdt,dzbdcrtdp,dzbdowndp,dzbdownid,dzbdstus,dzbdcrtid)",
                                          " SELECT dzbd001,dzbd002,dzbd003,'",l_flag,"','",gs_customer,"',",
                                                  "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"'",
                                            " FROM dzbd_t",ls_where," AND dzbd004='",l_flag2,"'" #標準的來源只會有s,但客製的來源會有s或m
                  PREPARE dzbd_prep7 FROM ls_sql
                  EXECUTE dzbd_prep7 USING g_date
                  FREE dzbd_prep7
               ELSE #到了這裡還錯誤,就是真的有問題了.
                  DISPLAY "ERROR : section ",l_id," not found!" 
                  RETURN FALSE
               END IF
            #End:2014/09/30 by Hiko
            END IF
            
            #更新程式代碼資料:上面就算是INSERT的動作,執行到此也是UPDATE.
            LOCATE l_cdata IN FILE
            LET l_cdata = sadzp060_1_get_cdata(p_node_section)
            
            UPDATE dzbd_t 
               SET dzbd098=l_cdata
             WHERE dzbd001=gs_prog AND
                   dzbd002=l_id AND
                   #dzbd003=g_revision AND
                   dzbd003=l_ver AND #2014/03/26 by Hiko
                   dzbd004=l_flag #2014/04/11 by Hiko 
            FREE l_cdata
         END IF
         
         #更新dzbc_t:同dzbd_t的更新方式
         LET ls_where = " WHERE dzbc001='",gs_prog,"' AND dzbc002=",g_head_ver," AND dzbc003='",l_id,"' AND dzbc007='",gs_identity,"'" #這個代碼版次的條件是對的
         IF ls_status.equals("u") THEN
            LET ls_trigger = "sadzp060_1_update_dzbd_t : check dzbc_t new ver data count"
            LET ls_sql = "SELECT count(*) FROM dzbc_t",ls_where
            PREPARE dzbc_prep1 FROM ls_sql
            EXECUTE dzbc_prep1 INTO li_cnt
            FREE dzbc_prep1
         
            IF li_cnt>0 THEN
               LET ls_trigger = "sadzp060_1_update_dzbd_t : update dzbc_t data ",l_id
               LET ls_sql = "UPDATE dzbc_t",
                              " SET dzbc004='",l_ver,"',", #2014/03/26 by Hiko
                                   "dzbc005='",l_flag,"',", #2014/04/11 by Hiko
                                   "dzbc006='",gs_erpver,"',",
                                   "dzbc008='",gs_customer,"',",
                                   "dzbc009='Y',", #2014/08/05 by Hiko
                                   "dzbcstus='Y',", 
                                   "dzbcmoddt=?,", 
                                   "dzbcmodid='",g_user,"' ",ls_where
               PREPARE dzbc_prep2 FROM ls_sql
               EXECUTE dzbc_prep2 USING g_date
               FREE dzbc_prep2
            ELSE 
                #Begin:2014/09/22 by Hiko:SECTION不可能透過設計器新增
                ##Begin:2014/04/30 by Hiko:SECTION可能新增
                #LET ls_trigger = "sadzp060_1_update_dzbd_t : insert dzbc_t data : ",l_id
                #LET ls_sql = "INSERT INTO dzbc_t(dzbc001,dzbc002,dzbc003,dzbc004,dzbc005,",
                #                                "dzbc006,dzbc007,dzbc008,dzbc009,",
                #                                "dzbccrtdt,dzbccrtdp,dzbcowndp,dzbcownid,dzbcstus,dzbccrtid)",
                #                        " VALUES('",gs_prog,"',",g_revision,",'",l_id,"','",l_ver,"','",l_flag,"',",                 
                #                                "'",gs_erpver,"','",gs_identity,"','",gs_customer,"','Y',",
                #                                "?,'",gs_dept,"','",gs_dept,"','",g_user,"','Y','",g_user,"')"
                ##End:2014/04/30 by Hiko
                #End:2014/09/22 by Hiko:SECTION不可能透過設計器新增
                DISPLAY "sadzp060_1_update_dzbd_t : The section id:",l_id,"(ver=",l_ver,") can't be found in dzac_t"
            END IF

            #和dzbb_t不同的是,dzbd_t沒有function,因此dzbd_t不會有失效情況,add section頂多是空白或是註解,但一定是生效的.
         END IF
      END IF #IF NOT cl_null(ls_status)

      RETURN TRUE
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN FALSE
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 依據控件代號取得Table和Column
# Input parameter : p_name 控件代號
# Return code     : STRING Table Name
#                 : STRING Column Name
# Date & Author   : 2013/01/15 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_get_tbl_col(p_name)
   DEFINE p_name STRING
   DEFINE l_dzac002 LIKE dzac_t.dzac002,
          l_dzac005 LIKE dzac_t.dzac005
   DEFINE ls_sql STRING,
          ls_trigger STRING 
   
   TRY
      LET p_name = p_name.trim()

      LET ls_trigger = "sadzp060_1_get_tbl_col : get dzac005,dzac002"
      LET ls_sql = "SELECT dzac005,dzac002",
                    " FROM dzac_t",
                   " WHERE dzac001='",gs_prog,"' AND dzac003='",p_name,"'"
      DECLARE dzac_curs9 SCROLL CURSOR FROM ls_sql
      OPEN dzac_curs9
      FETCH FIRST dzac_curs9 INTO l_dzac002,l_dzac005
      CLOSE dzac_curs9

      RETURN l_dzac002 CLIPPED,l_dzac005 CLIPPED
   CATCH
      CALL sadzp060_1_err_catch(ls_trigger, ls_sql) 
      RETURN NULL,NULL
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得規格識別碼的當下版次資料
# Input parameter : p_id 識別碼
# Return code     : BOOLEAN TRUE:執行成功;FALSE:執行失敗
#                 : NUMBER 版次
#                 : STRING 使用標示
# Date & Author   : 2014/05/29 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_get_spec_element_curr_revision(p_id)
   DEFINE p_id STRING,
          p_id_type STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          ls_err_msg STRING,
          l_dzaa004 LIKE dzaa_t.dzaa004,
          l_dzaa006 LIKE dzaa_t.dzaa006

   #因為在簽出時會將舊版次dzaa_t複製為新版次的dzaa_t,但內容不變,且我們的更新流程是先更新資源池,再更新dzaa_t,所以我們在取得舊版次的資料,就直接抓取即可.
   TRY
      LET ls_trigger = "sadzp060_1_get_spec_element_curr_revision : id=",p_id
      LET ls_sql = "SELECT dzaa004,dzaa006 FROM dzaa_t",
                   " WHERE dzaa001='",gs_prog,"' AND dzaa002=",g_head_ver," AND dzaa003='",p_id,"' AND dzaa009='",gs_identity,"' AND dzaastus='Y'"
      PREPARE dzaa_prep9 FROM ls_sql
      EXECUTE dzaa_prep9 INTO l_dzaa004,l_dzaa006
      FREE dzaa_prep9

      #若是透過設計器增加的,SERVER上本來就不會有資料,找不到資料很正常.
      RETURN TRUE,l_dzaa004 CLIPPED,l_dzaa006 CLIPPED
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, NULL) 
      LET ls_err_msg = "ERROR : sadzp060_1_get_spec_element_curr_revision : get dzaa_t failure!"
      RETURN FALSE,"0",ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得程式add point識別碼的當下版次資料
# Input parameter : p_id 識別碼
# Return code     : BOOLEAN TRUE:執行成功;FALSE:執行失敗
#                 : NUMBER 版次
#                 : STRING 使用標示
# Date & Author   : 2014/12/22 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_get_adp_curr_revision(p_id)
   DEFINE p_id STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          ls_err_msg STRING,
          l_dzba004 LIKE dzba_t.dzba004,
          l_dzba005 LIKE dzba_t.dzba005

   #因為在簽出時會將舊版次dzba_t複製為新版次的dzba_t,但內容不變,且我們的更新流程是先更新資源池,再更新dzba_t,所以我們在取得舊版次的資料,就直接抓取即可.
   TRY
      LET ls_trigger = "sadzp060_1_get_adp_curr_revision : ",p_id
      LET ls_sql = "SELECT dzba004,dzba005 FROM dzba_t",
                   " WHERE dzba001='",gs_prog,"' AND dzba002=",g_head_ver," AND dzba003='",p_id,"' AND dzba010='",gs_identity,"' AND dzbastus='Y'"
      PREPARE dzba_prep9 FROM ls_sql
      EXECUTE dzba_prep9 INTO l_dzba004,l_dzba005
      FREE dzba_prep9

      #找不到資料很正常,因為是透過設計器增加的,SERVER上本來就不會有資料.
      RETURN TRUE,l_dzba004 CLIPPED,l_dzba005 CLIPPED
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, NULL) 
      LET ls_err_msg = "ERROR : sadzp060_1_get_adp_curr_revision : get dzba_t failure!"
      RETURN FALSE,"0",ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得程式SECTION識別碼的當下版次資料
# Input parameter : p_id 識別碼
# Return code     : BOOLEAN TRUE:執行成功;FALSE:執行失敗
#                 : NUMBER 版次
#                 : STRING 使用標示
# Date & Author   : 2014/05/29 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp060_1_get_section_curr_revision(p_id)
   DEFINE p_id STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING,
          ls_err_msg STRING,
          l_dzbc004 LIKE dzbc_t.dzbc004,
          l_dzbc005 LIKE dzbc_t.dzbc005

   #因為在簽出時會將舊版次dzbc_t複製為新版次的dzbc_t,但內容不變,且我們的更新流程是先更新資源池,再更新dzbc_t,所以我們在取得舊版次的資料,就直接抓取即可.
   TRY
      LET ls_trigger = "sadzp060_1_get_section_curr_revision : ",p_id
      LET ls_sql = "SELECT dzbc004,dzbc005 FROM dzbc_t",
                   " WHERE dzbc001='",gs_prog,"' AND dzbc002=",g_head_ver," AND dzbc003='",p_id,"' AND dzbc007='",gs_identity,"' AND dzbcstus='Y'"
      PREPARE dzbc_prep9 FROM ls_sql
      EXECUTE dzbc_prep9 INTO l_dzbc004,l_dzbc005
      FREE dzbc_prep9

      #找不到資料很正常,因為是透過設計器增加的,SERVER上本來就不會有資料.
      RETURN TRUE,l_dzbc004 CLIPPED,l_dzbc005 CLIPPED
   CATCH 
      CALL sadzp060_1_err_catch(ls_trigger, NULL) 
      LET ls_err_msg = "ERROR : sadzp060_1_get_section_curr_revision : get dzbc_t failure!"
      RETURN FALSE,"0",ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE 
# Descriptions    : 建立新的離線read檔.
# Input parameter : p_doc_file doc檔
#                 : p_file_path 離線檔路徑
# Return code     : BOOLEAN(執行成功:TRUE,執行失敗:FALSE)
# Date & Author   : 2015/07/03 by Hiko
##########################################################################
PRIVATE FUNCTION sadzp010_1_create_read_file(p_doc_file, p_file_path)
   DEFINE p_doc_file xml.DomDocument,
          p_file_path STRING
   DEFINE ls_sql STRING,
          ls_trigger STRING

   TRY
      #將file更名
      LET ls_trigger = "sadzp010_1_create_read_file : file rename"
      IF os.Path.exists(p_file_path) THEN
         IF NOT os.Path.rename(p_file_path, p_file_path||".bak") THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00174"
            LET g_errparam.extend = ls_trigger
            LET g_errparam.popup = FALSE
            LET g_errparam.replace[1] =  "rename"
            LET g_errparam.replace[2] = gs_prog
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      
      CALL p_doc_file.setFeature("format-pretty-print", "TRUE")
      CALL p_doc_file.save(p_file_path)
      #最後變成777, 這樣在運行過程中會比較保險.
      IF NOT os.Path.chrwx(p_file_path, 511) THEN
         DISPLAY "CALL sadzp010_1_create_read_file : ",p_file_path," change rwx ERROR!"
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00174"
         LET g_errparam.extend = ls_trigger
         LET g_errparam.popup = FALSE
         LET g_errparam.replace[1] =  "chmod"
         LET g_errparam.replace[2] = gs_prog
         CALL cl_err()
         RETURN FALSE
      END IF

      RETURN TRUE
   CATCH 
      DISPLAY "ERROR : sadzp010_1_create_read_file failure : ",p_file_path
      RETURN FALSE
   END TRY
END FUNCTION

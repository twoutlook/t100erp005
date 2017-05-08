#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi552_01.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000020
#+ 
#+ Filename...: azzi552_01
#+ Description: 選擇目錄上現存文件
#+ Creator....: 00845(2015-08-07 16:45:27)
#+ Modifier...: 00845(2015-08-07 17:02:13) -SD/PR- 00845
 
{</section>}
 
{<section id="azzi552_01.global" >}
#應用 c02b 樣板自動產生(Version:5)

 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzzy_d        RECORD
       gzzy001 LIKE gzzy_t.gzzy001, 
   l_filename LIKE type_t.chr500
       END RECORD
 
 
DEFINE g_gzzy_d          DYNAMIC ARRAY OF type_g_gzzy_d
DEFINE g_gzzy_d_t        type_g_gzzy_d
 
 
DEFINE g_gzzy001_t   LIKE gzzy_t.gzzy001    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_detail_cnt LIKE type_t.num10
#end add-point
    
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
    
#add-point:傳入參數說明(global.argv)

#end add-point    
 
{</section>}
 
{<section id="azzi552_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzi552_01(--)
   #add-point:input段變數傳入
   lc_gzte001,lc_gzte002
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define
   DEFINE lc_gzte001      LIKE gzte_t.gzte001
   DEFINE lc_gzte002      LIKE gzte_t.gzte002

   #end add-point
   #add-point:input段define

   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi552_01 WITH FORM cl_ap_formpath("azz","azzi552_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理
   CALL cl_set_combo_lang("gzzy001")
   CALL azzi552_01_b_fill(lc_gzte001,lc_gzte002)
   LET g_detail_cnt = g_gzzy_d.getLength()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

 

 

 
 
 

 

 

 

     
      #add-point:自定義input
      DISPLAY ARRAY g_gzzy_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
         ON ACTION modify_detail
            DISPLAY "DOWNLOAD!"
      END DISPLAY
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel

         #end add-point
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_azzi552_01 
   
   #add-point:input段after input 

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi552_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_01_b_fill(lc_gzte001,lc_gzte002)
   DEFINE ls_sql   STRING
   DEFINE l_ac     LIKE type_t.num5
   DEFINE ls_orig  STRING
   DEFINE lc_gzte001 LIKE gzte_t.gzte001
   DEFINE lc_gzte002 LIKE gzte_t.gzte002
   DEFINE ls_path  STRING

   LET ls_sql = "select gzzy001,'' FROM gzzy_t WHERE gzzystus = 'Y'"
   PREPARE azzi552_01_pb FROM ls_sql
   DECLARE b_fill_curs CURSOR FOR azzi552_01_pb
   
   DISPLAY lc_gzte001 TO l_gzte001
   OPEN b_fill_curs
   CALL g_gzzy_d.clear()
   
   LET ls_orig = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
   LET ls_orig = os.Path.join(ls_orig.trim(),"erp")
   LET ls_orig = os.Path.join(ls_orig.trim(),DOWNSHIFT(lc_gzte002 CLIPPED))
   LET l_ac = 1

   FOREACH b_fill_curs INTO g_gzzy_d[l_ac].gzzy001,g_gzzy_d[l_ac].l_filename
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET ls_path = os.Path.join(ls_orig,g_gzzy_d[l_ac].gzzy001)
      LET g_gzzy_d[l_ac].l_filename = azzi552_01_findfile(ls_path,lc_gzte001)
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_gzzy_d.deleteElement(g_gzzy_d.getLength()) 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_01_findfile(ls_path,ls_partfilename)
   DEFINE ls_path     STRING #搜尋路徑
   DEFINE ls_partfilename STRING #部分檔案編號
   DEFINE ls_filename STRING #回傳的檔案名稱
   DEFINE li_h        LIKE type_t.num5
   DEFINE ls_child    STRING

   LET ls_filename = ""
   CALL os.Path.dirsort("name", 1)
   LET li_h = os.Path.diropen(ls_path)

   WHILE li_h > 0
      LET ls_child = os.Path.dirnext(li_h)
      IF ls_child IS NULL THEN EXIT WHILE END IF
      IF ls_child == "." OR ls_child == ".." THEN CONTINUE WHILE END IF
      IF ls_child.getIndexOf(ls_partfilename,1) THEN
        LET ls_filename = ls_child
      END IF
   END WHILE

   CALL os.Path.dirclose(li_h)
   IF ls_filename IS NULL THEN
      LET ls_filename = "file_not_found"
   END IF

   RETURN ls_filename
END FUNCTION

 
{</section>}
 

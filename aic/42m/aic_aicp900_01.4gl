#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp900_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-01-15 17:42:40), PR版次:0002(2016-04-19 11:14:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: aicp900_01
#+ Description: 多角流程編號設定
#+ Creator....: 04543(2016-01-15 14:58:36)
#+ Modifier...: 04543 -SD/PR- 07673
 
{</section>}
 
{<section id="aicp900_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#14 2016/04/18 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdk_d        RECORD
       l_site LIKE type_t.chr500, 
   l_site_desc LIKE type_t.chr500, 
   l_site_from LIKE type_t.chr500, 
   l_site_from_desc LIKE type_t.chr500, 
   l_aic_way LIKE type_t.chr500, 
   l_aic_way_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmdk2_d RECORD
       l_client LIKE type_t.chr10, 
   l_client_desc LIKE type_t.chr500, 
   l_docno LIKE type_t.chr20, 
   l_docdt LIKE type_t.dat
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql             STRING
DEFINE g_xmdk_d_o        type_g_xmdk_d
DEFINE g_int_flag        LIKE type_t.num5
#end add-point
 
DEFINE g_xmdk_d          DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t        type_g_xmdk_d
DEFINE g_xmdk2_d   DYNAMIC ARRAY OF type_g_xmdk2_d
DEFINE g_xmdk2_d_t type_g_xmdk2_d
 
 
DEFINE g_xmdkdocno_t   LIKE xmdk_t.xmdkdocno    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="aicp900_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aicp900_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_type          LIKE type_t.chr1        #1.aicp900 2.aicp950
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aicp900_01 WITH FORM cl_ap_formpath("aic","aicp900_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   CALL aicp900_01_window_show(p_type)
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdk_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #單頭
            CALL aicp900_01_b_fill(p_type)
            DISPLAY g_xmdk_d.getLength() TO FORMONLY.cnt
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_aic_way
            
            #add-point:AFTER FIELD l_aic_way name="input.a.page1.l_aic_way"
            CALL s_desc_get_icaa001_desc(g_xmdk_d[l_ac].l_aic_way)
            RETURNING g_xmdk_d[l_ac].l_aic_way_desc
            
            IF NOT cl_null(g_xmdk_d[l_ac].l_aic_way) THEN
               IF g_xmdk_d[l_ac].l_aic_way <> g_xmdk_d_o.l_aic_way OR cl_null(g_xmdk_d_o.l_aic_way) THEN
                  IF NOT aicp900_01_way_chk(p_type) THEN
                     LET g_xmdk_d[l_ac].l_aic_way = g_xmdk_d_o.l_aic_way
                     CALL s_desc_get_icaa001_desc(g_xmdk_d[l_ac].l_aic_way)
                     RETURNING g_xmdk_d[l_ac].l_aic_way_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_aic_way
            #add-point:BEFORE FIELD l_aic_way name="input.b.page1.l_aic_way"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_aic_way
            #add-point:ON CHANGE l_aic_way name="input.g.page1.l_aic_way"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.l_aic_way
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_aic_way
            #add-point:ON ACTION controlp INFIELD l_aic_way name="input.c.page1.l_aic_way"
            CALL aicp900_01_way_infield(p_type)
            RETURNING g_xmdk_d[l_ac].l_aic_way
            
            DISPLAY g_xmdk_d[l_ac].l_aic_way TO l_aic_way
                     
            CALL s_desc_get_icaa001_desc(g_xmdk_d[l_ac].l_aic_way)
            RETURNING g_xmdk_d[l_ac].l_aic_way_desc
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         BEFORE ROW
            #單頭
            CALL aicp900_01_b_fill(p_type)
            DISPLAY g_xmdk_d.getLength() TO FORMONLY.cnt
            
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            DISPLAY l_ac TO FORMONLY.idx
            
            LET g_xmdk_d_t.* = g_xmdk_d[l_ac].*
            LET g_xmdk_d_o.* = g_xmdk_d[l_ac].*
            
            #單身
            CALL aicp900_01_b_fill2(p_type,g_xmdk_d[l_ac].l_site,g_xmdk_d[l_ac].l_site_from,g_xmdk_d[l_ac].l_aic_way)
            
         ON ROW CHANGE
            IF NOT aicp900_01_update(p_type,g_xmdk_d[l_ac].l_site,g_xmdk_d[l_ac].l_site_from,g_xmdk_d[l_ac].l_aic_way,g_xmdk_d_t.l_aic_way) THEN
               LET INT_FLAG = TRUE 
               EXIT DIALOG
            END IF
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
            
      DISPLAY ARRAY g_xmdk2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
         
         BEFORE ROW
         
         BEFORE DISPLAY
         
      END DISPLAY

      BEFORE DIALOG
         CALL s_transaction_begin()
         LET g_int_flag = INT_FLAG
         LET INT_FLAG = FALSE
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   IF INT_FLAG THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   
   LET INT_FLAG = g_int_flag
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aicp900_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aicp900_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aicp900_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭顯示
# Memo...........:
# Usage..........: CALL aicp900_01_b_fill(p_type)
#                  
# Input parameter: p_type  #1.aicp900 2.aicp950
#                : 
# Return code....: 
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_b_fill(p_type)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   
   IF p_type = '1' THEN  #aicp900
      LET g_sql = "SELECT DISTINCT xmdksite,'',",
                  "                xmdasite,'',",
                  "                xmdk044,''",
                  "  FROM aicp900_tmp"
   ELSE                  #aicp950
      LET g_sql = "SELECT DISTINCT pmdssite,'',",
                  "                pmdlsite,'',",
                  "                pmds053,''",
                  "  FROM aicp950_tmp"
   END IF
   
   PREPARE aicp900_01_pre FROM g_sql
   DECLARE aicp900_01_cs CURSOR FOR aicp900_01_pre
   
   CALL g_xmdk_d.clear()
   LET l_ac = 1
   
   FOREACH aicp900_01_cs INTO g_xmdk_d[l_ac].l_site,g_xmdk_d[l_ac].l_site_desc,
                              g_xmdk_d[l_ac].l_site_from,g_xmdk_d[l_ac].l_site_from_desc,
                              g_xmdk_d[l_ac].l_aic_way,g_xmdk_d[l_ac].l_aic_way_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aicp900_01_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_desc_get_department_desc(g_xmdk_d[l_ac].l_site)
           RETURNING g_xmdk_d[l_ac].l_site_desc
      CALL s_desc_get_department_desc(g_xmdk_d[l_ac].l_site_from)
           RETURNING g_xmdk_d[l_ac].l_site_from_desc
      CALL s_desc_get_icaa001_desc(g_xmdk_d[l_ac].l_aic_way)
           RETURNING g_xmdk_d[l_ac].l_aic_way_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 單身顯示
# Memo...........:
# Usage..........: CALL aicp900_01_b_fill2(p_type,p_site,p_site_from,p_aic_way)
#                  
# Input parameter: p_type       #1.aicp900 2.aicp950
#                : p_site       #營運據點
#                : p_site_from  #來源據點
#                : p_aic_way    #多角流程代碼
# Return code....: 
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_b_fill2(p_type,p_site,p_site_from,p_aic_way)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   DEFINE p_site       LIKE xmdk_t.xmdksite
   DEFINE p_site_from  LIKE xmda_t.xmdasite
   DEFINE p_aic_way    LIKE xmdk_t.xmdk044
   DEFINE li_ac        LIKE type_t.num10
   
   LET li_ac = l_ac
   
   IF p_type = '1' THEN  #aicp900
      LET g_sql = "SELECT DISTINCT xmdk007,'',",
                  "                xmdkdocno,xmdkdocdt",
                  "  FROM aicp900_tmp",
                  " WHERE COALESCE(xmdksite,' ') = COALESCE('",p_site,"',' ')",
                  "   AND COALESCE(xmdasite,' ') = COALESCE('",p_site_from,"',' ')",
                  "   AND COALESCE(xmdk044,' ')  = COALESCE('",p_aic_way,"',' ')"
   ELSE                  #aicp950
      LET g_sql = "SELECT DISTINCT pmds007,'',",
                  "                pmdsdocno,pmdsdocdt",
                  "  FROM aicp950_tmp",
                  " WHERE COALESCE(pmdssite,' ') = COALESCE('",p_site,"',' ')",
                  "   AND COALESCE(pmdlsite,' ') = COALESCE('",p_site_from,"',' ')",
                  "   AND COALESCE(pmds053,' ')  = COALESCE('",p_aic_way,"',' ')"
   END IF
   
   PREPARE aicp900_01_pre2 FROM g_sql
   DECLARE aicp900_01_cs2 CURSOR FOR aicp900_01_pre2
   
   CALL g_xmdk2_d.clear()
   LET l_ac = 1
   
   FOREACH aicp900_01_cs2 INTO g_xmdk2_d[l_ac].l_client,g_xmdk2_d[l_ac].l_client_desc,
                               g_xmdk2_d[l_ac].l_docno,g_xmdk2_d[l_ac].l_docdt
                              
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:aicp900_01_cs2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_desc_get_trading_partner_abbr_desc(g_xmdk2_d[l_ac].l_client)
           RETURNING g_xmdk2_d[l_ac].l_client_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_xmdk2_d.deleteElement(g_xmdk2_d.getLength())
   
   LET l_ac = li_ac
END FUNCTION

################################################################################
# Descriptions...: TEMP TABLE更新
# Memo...........:
# Usage..........: CALL aicp900_01_update(p_type,p_site,p_site_from,p_aic_way,p_aic_way_t)
#                  RETURNING 回传参数
# Input parameter: p_type       #1.aicp900 2.aicp950
#                : p_site       #營運據點
#                : p_site_from  #來源據點
#                : p_aic_way    #多角流程代碼
#                : p_aic_way_t  #多角流程代碼(舊值)
# Return code....: r_success
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_update(p_type,p_site,p_site_from,p_aic_way,p_aic_way_t)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   DEFINE p_site       LIKE xmdk_t.xmdksite
   DEFINE p_site_from  LIKE xmda_t.xmdasite
   DEFINE p_aic_way    LIKE xmdk_t.xmdk044
   DEFINE p_aic_way_t  LIKE xmdk_t.xmdk044
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF p_type = '1' THEN  #aicp900
      UPDATE aicp900_tmp
         SET xmdk044 = g_xmdk_d[l_ac].l_aic_way
       WHERE COALESCE(xmdksite,' ') = COALESCE(p_site,' ')
         AND COALESCE(xmdasite,' ') = COALESCE(p_site_from,' ')
         AND COALESCE(xmdk044,' ')  = COALESCE(p_aic_way_t,' ')
   ELSE                  #aicp950
      UPDATE aicp950_tmp
         SET pmds053 = g_xmdk_d[l_ac].l_aic_way
       WHERE COALESCE(pmdssite,' ') = COALESCE(p_site,' ')
         AND COALESCE(pmdlsite,' ') = COALESCE(p_site_from,' ')
         AND COALESCE(pmds053,' ')  = COALESCE(p_aic_way_t,' ')
   END IF
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE aicp900_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
         
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 多角流程代碼開窗
# Memo...........:
# Usage..........: CALL aicp900_01_way_infield(p_type)
#                  RETURNING r_aic_way
# Input parameter: p_type       #1.aicp900 2.aicp950
#                : 
# Return code....: r_aic_way    #多角流程代碼
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_way_infield(p_type)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   DEFINE r_aic_way    LIKE xmdk_t.xmdk044
   
   LET r_aic_way = ''
   
   IF p_type = '1' THEN
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
      LET g_qryparam.default1 = g_xmdk_d[l_ac].l_aic_way
      LET g_qryparam.arg1 = '1'
      LET g_qryparam.arg2 = '2'
      LET g_qryparam.arg3 = 'N'
      LET g_qryparam.arg4 = g_xmdk_d[l_ac].l_site_from
      LET g_qryparam.arg5 = g_xmdk_d[l_ac].l_site
      CALL q_icaa001_2()
      LET r_aic_way = g_qryparam.return1
   ELSE
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
      LET g_qryparam.reqry = FALSE
      LET g_qryparam.default1 = g_xmdk_d[l_ac].l_aic_way
      LET g_qryparam.arg1 = '2'
      LET g_qryparam.arg2 = '2'
      LET g_qryparam.arg3 = 'N'
      LET g_qryparam.arg4 = g_xmdk_d[l_ac].l_site_from
      LET g_qryparam.arg5 = g_xmdk_d[l_ac].l_site
      CALL q_icaa001_2()
      LET r_aic_way = g_qryparam.return1
   END IF
   
   RETURN r_aic_way
END FUNCTION

################################################################################
# Descriptions...: 多角流程代碼檢查
# Memo...........:
# Usage..........: CALL aicp900_01_way_chk(p_type)
#                  RETURNING r_success
# Input parameter: p_type       #1.aicp900 2.aicp950
#                : 
# Return code....: r_success
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_way_chk(p_type)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004
   
   LET r_success = TRUE
   
   IF p_type = '1' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdk_d[l_ac].l_aic_way
      LET g_chkparam.arg2 = g_xmdk_d[l_ac].l_site_from
      LET g_chkparam.arg3 = g_xmdk_d[l_ac].l_site
      LET g_chkparam.arg4 = '1'
      
      LET l_gzcbl004 = ''
      SELECT gzcbl004 INTO l_gzcbl004
        FROM gzcbl_t
       WHERE gzcbl001 = '2501'
         AND gzcbl002 = '1'
         AND gzcbl003 = g_dlang
      LET l_gzcbl004 = g_chkparam.arg4,".",l_gzcbl004
      LET g_chkparam.err_str[1] = "aic-00084|",l_gzcbl004
      LET g_errshow = TRUE   #160318-00025#14
      LET g_chkparam.err_str[1] = "aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"    #160318-00025#14   
      IF NOT cl_chk_exist("v_icaa001_2") THEN
         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_xmdk_d[l_ac].l_aic_way
      LET g_chkparam.arg2 = g_xmdk_d[l_ac].l_site_from
      LET g_chkparam.arg3 = g_xmdk_d[l_ac].l_site
      LET g_chkparam.arg4 = '2'
      
      LET l_gzcbl004 = ''
      SELECT gzcbl004 INTO l_gzcbl004
        FROM gzcbl_t
       WHERE gzcbl001 = '2501'
         AND gzcbl002 = '2'
         AND gzcbl003 = g_dlang
      LET l_gzcbl004 = g_chkparam.arg4,".",l_gzcbl004
      LET g_chkparam.err_str[1] = "aic-00084|",l_gzcbl004
      LET g_errshow = TRUE   #160318-00025#14
      LET g_chkparam.err_str[1] = "aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"    #160318-00025#14   
      IF NOT cl_chk_exist("v_icaa001_2") THEN
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 畫面顯示調整
# Memo...........:
# Usage..........: aicp900_01_window_show(p_type)
#                  
# Input parameter: p_type       #1.aicp900 2.aicp950
#                : 
# Return code....: 
#                : 
# Date & Author..: 160118 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp900_01_window_show(p_type)
   DEFINE p_type       LIKE type_t.chr1        #1.aicp900 2.aicp950
   DEFINE l_gzze003    LIKE gzze_t.gzze003
   
   IF p_type = '1' THEN  #aicp900
      #出貨單號
      CALL cl_getmsg('axm-00732',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_docno',l_gzze003)
      
      #出貨日期
      CALL cl_getmsg('aic-00216',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_docdt',l_gzze003)
      
   ELSE                  #aicp950
      #收貨據點
      CALL cl_getmsg('aic-00217',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_site',l_gzze003)
         
      #送貨供應商
      CALL cl_getmsg('aic-00218',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_client',l_gzze003)
      
      #供應商名稱
      CALL cl_getmsg('aic-00219',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_client_desc',l_gzze003)
      
      #入庫單號
      CALL cl_getmsg('apm-00501',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_docno',l_gzze003)
      
      #入庫日期
      CALL cl_getmsg('apm-00502',g_dlang) RETURNING l_gzze003
      CALL cl_set_comp_att_text('l_docdt',l_gzze003)
      
   END IF
   
END FUNCTION

 
{</section>}
 

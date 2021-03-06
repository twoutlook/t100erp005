#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq930.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-08-15 10:05:56), PR版次:0004(2016-11-08 17:35:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: anmq930
#+ Description: 帳戶日結查詢
#+ Creator....: 02291(2014-08-14 00:00:00)
#+ Modifier...: 02291 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq930.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150730-00008#1 2015/08/03 by yangtt 拿掉【內部】相關字眼，程序里不設定為內部銀行(ooab002= '0')
#160323-00005#1 2016/03/29 By 02599  修正nmbc002存储的是交易账户,应关联nmas_t表
#161108-00019#2 2016/11/08 By 07900  g_browser_cnt 改为num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       #tree自定義欄位
       b_ooed001       LIKE ooed_t.ooed001,
       b_ooed002       LIKE ooed_t.ooed002,
       b_ooed003       LIKE ooed_t.ooed003,
       b_ooed004       LIKE ooed_t.ooed004,
       b_ooed005       LIKE ooed_t.ooed005
       END RECORD
DEFINE g_ooed002             LIKE ooed_t.ooed002
DEFINE g_ooed002_desc        LIKE type_t.chr80
DEFINE g_ooed006             LIKE ooed_t.ooed006
DEFINE g_ooed002_t           LIKE ooed_t.ooed002
DEFINE g_ooed006_t           LIKE ooed_t.ooed006
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10      
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10      #161108-00019#2  mod type_t.num5 -> type_t.num10   
DEFINE l_ac                  LIKE type_t.num10      #161108-00019#2  mod type_t.num5 -> type_t.num10 
DEFINE g_browser_cnt         LIKE type_t.num10      #161108-00019#2  mod type_t.num5 -> type_t.num10
DEFINE g_browser_root        DYNAMIC ARRAY OF INTEGER
DEFINE g_current_row         LIKE type_t.num10         #Browser所在筆數     #161108-00019#2  mod type_t.num5 -> type_t.num10
DEFINE g_current_sw          LIKE type_t.num5         #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 TYPE type_g_nmaa_d RECORD
   nmaastus LIKE nmaa_t.nmaastus,
   nmaa001 LIKE nmaa_t.nmaa001, 
   nmaa001_desc LIKE type_t.chr500, 
   nmaa007 LIKE nmaa_t.nmaa007, 
   nmbc100 LIKE nmbc_t.nmbc100, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6
       END RECORD
DEFINE g_nmaa_d          DYNAMIC ARRAY OF type_g_nmaa_d
DEFINE g_nmaa_d_t        type_g_nmaa_d
DEFINE g_error_show         LIKE type_t.num5
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="anmq930.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT ooed001,ooed002,ooed003,ooed004,ooed006,ooed005 FROM ooed_t WHERE ooedent= ? AND ooed001=? AND ooed002=? AND ooed003=? AND ooed004=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE anmq930_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq930 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmq930_init()
 
      #進入選單 Menu (='N')
      CALL anmq930_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_anmq930
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="anmq930.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#+ 初始化
PRIVATE FUNCTION anmq930_init()
   
   
END FUNCTION
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq930_ui_dialog()
DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業

   IF NOT cl_null(g_wc) AND g_wc != " 1=1" THEN
      CALL anmq930_browser_fill()
   ELSE
      CALL anmq930_query()
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #左側瀏覽頁簽
      DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
      
         
         BEFORE DISPLAY
            LET l_ac = DIALOG.getCurrentRow("s_browse")
            
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            CALL cl_show_fld_cont() 
            CALL DIALOG.setCurrentRow("s_browse",g_current_row)
 
            CALL anmq930_fetch("")  #當每次點任一筆資料都會需要用到
               
      END DISPLAY
      
      #右側單身頁簽
      DISPLAY ARRAY g_nmaa_d TO s_detail2.* ATTRIBUTE(COUNT=g_rec_b)
      
         BEFORE ROW
         
         BEFORE DISPLAY
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
               
      END DISPLAY
      
      BEFORE DIALOG
 	   
     	AFTER DIALOG 
 
      ON ACTION query
         LET g_action_choice="query"
         IF cl_auth_chk_act("query") THEN
            CALL anmq930_query()
         END IF
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_nmaa_d)
            LET g_export_id[1]   = "s_detail2"
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
          
      ON ACTION exit
         LET g_action_choice="exit"
         LET INT_FLAG = FALSE
         LET li_exit = TRUE
         EXIT DIALOG 
      
      ON ACTION close
         LET li_exit = TRUE
         EXIT DIALOG
         
      &include "main_menu.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
      
   END DIALOG 
END FUNCTION
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmq930_query()
   DEFINE ls_wc STRING

   LET INT_FLAG = 0
   LET ls_wc = g_wc
 
   CALL anmq930_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      DISPLAY "1" TO ooed001
      DISPLAY g_today TO ooed006
      CALL g_browser.clear()
      RETURN
   ELSE
      CALL g_browser.clear()
   END IF

   CALL anmq930_browser_fill()

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-100'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
END FUNCTION
#+ QBE資料查詢
PRIVATE FUNCTION anmq930_construct()
   DEFINE l_n     LIKE type_t.num5
   #清除畫面
   CLEAR FORM 
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_ooed002,g_ooed006 FROM ooed002,ooed006
         BEFORE INPUT
            LET g_ooed006 = g_today
            DISPLAY g_ooed006 TO ooed006
            
         AFTER FIELD ooed002
            CALL anmq930_ooed002_desc()
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooed_t
             WHERE ooedent = g_enterprise AND ooed002 = g_ooed002
            IF l_n = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00201'
               LET g_errparam.extend = g_ooed002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooed_t
             WHERE ooedent = g_enterprise AND ooed002 = g_ooed002 AND ooed001 <> '6'
            IF l_n = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00238'
               LET g_errparam.extend = g_ooed002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            
            CALL anmq930_ooed002_desc()
            
         ON ACTION controlp INFIELD ooed002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooed002
            LET g_qryparam.where = " ooed001 = '6'"
            CALL q_ooed002()                           #呼叫開窗
            LET g_ooed002 = g_qryparam.return1 
            CALL anmq930_ooed002_desc()
            DISPLAY g_ooed002 TO ooed002  #顯示到畫面上
            LET g_qryparam.where = " "
            NEXT FIELD ooed002                     #返回原欄位
         
      END INPUT

      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
         
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
  
   END DIALOG
   
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION
#+ 樹顯示
PRIVATE FUNCTION anmq930_browser_fill()
DEFINE l_n        LIKE type_t.num10    #161108-00019#2  mod type_t.num5 -> type_t.num10 
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE l_sql      STRING
DEFINE l_n2       LIKE type_t.num10   #161108-00019#2  mod type_t.num5 -> type_t.num10 
DEFINE l_ooej003  LIKE ooej_t.ooej003
DEFINE l_wc       STRING

   CALL g_browser.clear()
   LET g_cnt = 1
   LET l_n = 1
   
   #2015/04/15--by--02599--add--str--
   #获取版本号
   #1.抓取当前组织版本号
   LET l_ooej003 = ''
   SELECT UNIQUE ooej003 INTO l_ooej003 FROM ooej_t
    WHERE ooejent = g_enterprise AND ooej001 = '6'
      AND ooej002 = g_ooed002
      AND ooej006 <= g_ooed006
      AND (ooej007 IS NULL OR ooej007 >= g_ooed006 )
   #2.如果没有抓取到当前组织版本号，则抓取满足查询条件的组织的最大版本号
   IF cl_null(l_ooej003) THEN
      SELECT MAX(ooed003) INTO l_ooej003 FROM ooed_t
       WHERE ooedent = g_enterprise AND ooed001 = '6'
         AND ooed002 = g_ooed002
         AND ooed006 <= g_ooed006
         AND (ooed007 IS NULL OR ooed007 >= g_ooed006 )
   END IF
   #3.版本号组成查询条件
   IF NOT cl_null(l_ooej003) THEN
      LET l_wc = " ooed003 = '",l_ooej003,"'"
   ELSE
      LET l_wc = ' 1=1'
   END IF
   #2015/04/15--by--02599--add--end
   
   #第一層的資料
   LET l_sql = " SELECT UNIQUE ooed002,ooed003 FROM ooed_t ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '6' AND ooed002 = '",g_ooed002,"'",
               "    AND ooed006 <= '",g_ooed006,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_ooed006,"' ) ",
               "    AND ",l_wc,    #2015/04/15 by 02599 add
               "  ORDER BY ooed002 "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = " SELECT UNIQUE ooed004,ooed003 FROM ooed_t ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '6' AND ooed002 = '",g_ooed002,"'",
               "    AND ooed006 <= '",g_ooed006,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_ooed006,"' ) ",
               "    AND ooed002 = ? ",
               "    AND ooed003 = ? ",
               "    AND ooed002 = ooed005 ",
               "    AND ooed004 <> ooed005 ",
               "  ORDER BY ooed004 "
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1

   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1
   FOREACH master_typecur_0 INTO g_browser[l_ac].b_ooed002,g_browser[l_ac].b_ooed003
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_ooed002 = g_browser[l_ac].b_ooed002
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      LET g_browser[l_ac].b_isExp = TRUE
      #2015/04/15--by--02599--add--str--
      #第一层root
      LET g_browser[l_ac].b_ooed004 = g_browser[l_ac].b_ooed002
      LET g_browser[l_ac].b_ooed005 = g_browser[l_ac].b_ooed002
      #2015/04/15--by--02599--add--end
      #第一層節點編號
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1
      LET g_cnt = l_ac
      FOREACH master_typecur_1 USING g_browser[l_ac-1].b_ooed002,g_browser[l_ac-1].b_ooed003 INTO g_browser[g_cnt].b_ooed004,g_browser[g_cnt].b_ooed003
         LET g_browser[g_cnt].b_ooed002 = g_browser[l_ac-1].b_ooed002
         LET g_browser[g_cnt].b_ooed004 = g_browser[g_cnt].b_ooed004
         LET g_browser[g_cnt].b_ooed005 = g_browser[l_ac-1].b_ooed004
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = TRUE
         LET g_browser[g_cnt].b_hasC = anmq930_chk_hasC(g_cnt)
         IF g_browser[g_cnt].b_hasC = 1 THEN
            CALL anmq930_browser_expand(g_cnt)
            LET g_cnt = g_browser.getLength()
         END IF
         LET g_cnt = g_cnt +1
      END FOREACH
      LET l_ac = g_browser.getLength()
   END FOREACH
   LET l_ac = l_ac - 1
   CALL g_browser.deleteElement(l_ac+1)
   FOR l_ac = 1 TO g_browser.getLength()
       CALL anmq930_desc_show(l_ac)
   END FOR

   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()

   FREE master_type_0
   FREE master_type_1
   
   FOR l_n2 = 1 TO g_browser.getLength()
       IF g_browser[l_n2].b_isExp is null THEN
         CALL anmq930_browser_expand(l_n2)
      END IF
   END FOR
END FUNCTION
#+ 檢查是否有下節
PRIVATE FUNCTION anmq930_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER


   LET g_sql = "SELECT COUNT(*) FROM ooed_t ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed001 = '6' AND ooed002 = '",g_ooed002,"'",
               "   AND ooed006 <= '",g_ooed006,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_ooed006,"' ) ", 
               "   AND ooed005 = ? ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? "
   PREPARE anmq930_master_chk1 FROM g_sql 
   EXECUTE anmq930_master_chk1 USING g_browser[pi_id].b_ooed004,g_browser[pi_id].b_ooed002,g_browser[pi_id].b_ooed003 INTO li_cnt
   FREE anmq930_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION
#+ Tree子節點展開
PRIVATE FUNCTION anmq930_browser_expand(p_id)
DEFINE p_id          LIKE type_t.num10
DEFINE l_id          LIKE type_t.num10
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_keyvalue    LIKE type_t.chr50
DEFINE l_typevalue   LIKE type_t.chr50
DEFINE l_type        LIKE type_t.chr50
DEFINE l_sql         LIKE type_t.chr500
DEFINE ls_source     LIKE type_t.chr500
DEFINE ls_exp_code   LIKE type_t.chr500
DEFINE l_return      LIKE type_t.num5

   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET g_browser[p_id].b_isExp = 1 
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[p_id].b_ooed004
   
         
   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005",
               "   AND ooed001 = '6' AND ooed002 = '",g_ooed002,"'", 
               "   AND ooed006 <= '",g_ooed006,"' ",
               "   AND ooed002 = '",g_browser[p_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_browser[p_id].b_ooed003,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_ooed006,"' ) ",
               " ORDER BY ooed004"
   
   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
  
   LET l_id = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_browser[l_id].b_ooed004,g_browser[l_id].b_ooed003
      IF cl_null(g_browser[l_id].b_ooed004) THEN
         EXIT FOREACH
      END IF
      #pid=父節點id
      LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id  = g_browser[p_id].b_id||"."||l_cnt
      LET g_browser[l_id].b_exp = TRUE
      LET g_browser[l_id].b_ooed005 = g_browser[p_id].b_ooed004
      LET g_browser[l_id].b_ooed002 = g_browser[p_id].b_ooed002
      #hasC=確認該節點是否有子孫
      CALL anmq930_desc_show(l_id)
      LET g_browser[l_id].b_hasC = anmq930_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   LET l_cnt = l_cnt -1
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
END FUNCTION
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION anmq930_desc_show(pi_ac)
DEFINE pi_ac          LIKE type_t.num10  #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE li_tmp         LIKE type_t.num10  #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE l_ooed004_desc LIKE type_t.chr80 
DEFINE ls_msg         STRING

   LET li_tmp = l_ac
   LET l_ac = pi_ac
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   
   IF cl_null(g_browser[l_ac].b_ooed004) AND cl_null(g_browser[l_ac].b_ooed005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET ls_msg = cl_getmsg("aoo-00232",g_lang)
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed002,' (',l_ooed004_desc,')','(',ls_msg,g_browser[l_ac].b_ooed003,')'
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed004,' (',l_ooed004_desc,')'
   END IF
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
PRIVATE FUNCTION anmq930_ooed002_desc()

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_ooed002_desc = g_rtn_fields[1]
      DISPLAY g_ooed002_desc TO ooed002_desc

END FUNCTION

################################################################################
# Descriptions...: 右邊單身資料填充
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
PRIVATE FUNCTION anmq930_b_fill()
DEFINE ls_wc           STRING
   #add-point:b_fill段define
   DEFINE l_nmbc103_1     LIKE nmbc_t.nmbc103
   DEFINE l_nmbc103_2     LIKE nmbc_t.nmbc103
   DEFINE l_nmbc113_1     LIKE nmbc_t.nmbc113
   DEFINE l_nmbc113_2     LIKE nmbc_t.nmbc113
   DEFINE l_nmbc123_1     LIKE nmbc_t.nmbc123
   DEFINE l_nmbc123_2     LIKE nmbc_t.nmbc123
   DEFINE l_nmbc133_1     LIKE nmbc_t.nmbc133
   DEFINE l_nmbc133_2     LIKE nmbc_t.nmbc133
   #end add-point
 
   #160323-00005#1--mod--str--
#   LET g_sql = "SELECT  UNIQUE nmaastus,nmaa001,'',nmaa007,nmbc100,0,0,0,0 FROM nmab_t,nmaa_t",
#               " LEFT OUTER JOIN nmbc_t ON nmaaent = nmbcent AND nmbc002 = nmaa001 AND nmbccomp = nmaa002",
#               " WHERE nmaaent = nmabent  ",
#               "   AND nmaa004 = nmab001 ",
#              #"   AND nmab002 = '0' AND nmaaent= ? ",  #150730-00008#1 mark
#               "   AND nmaaent= ? ",  #150730-00008#1 add
#               "   AND nmaa002 = '",g_browser[g_current_idx].b_ooed004,"'"              
   LET g_sql = "SELECT  UNIQUE nmaastus,nmaa001,'',nmaa007,nmbc100,0,0,0,0 ",
               "  FROM nmab_t,nmaa_t,nmas_t",
               "  LEFT OUTER JOIN nmbc_t ON nmasent = nmbcent AND nmbc002 = nmas002 ",
               " WHERE nmaaent = nmabent  ",
               "   AND nmaa004 = nmab001 ",
               "   AND nmaaent = nmasent AND nmaa001=nmas001 ",
               "   AND nmbccomp = nmaa002 ",
               "   AND nmaaent= ? ",  
               "   AND nmaa002 = '",g_browser[g_current_idx].b_ooed004,"'" 
   #160323-00005#1--mod--end
   
   PREPARE anmq930_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq930_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmaa_d.clear()  
 
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_nmaa_d[l_ac].nmaastus,g_nmaa_d[l_ac].nmaa001,g_nmaa_d[l_ac].nmaa001_desc,g_nmaa_d[l_ac].nmaa007,
                            g_nmaa_d[l_ac].nmbc100,g_nmaa_d[l_ac].amt1,g_nmaa_d[l_ac].amt2,g_nmaa_d[l_ac].amt3,g_nmaa_d[l_ac].amt4
                           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL anmq930_nmaa001_desc()
      #原幣存入,本幣存入,本位幣2存入,本位幣3存入
      SELECT SUM(nmbc103),SUM(nmbc113),SUM(nmbc123),SUM(nmbc133) 
        INTO l_nmbc103_1,l_nmbc113_1,l_nmbc123_1,l_nmbc133_1
        FROM nmbc_t
#       WHERE nmbcent = g_enterprise AND nmbc002 = g_nmaa_d[l_ac].nmaa001 #160323-00005#1 mark
     #160323-00005#1--add--str--
       WHERE nmbcent = g_enterprise
         AND nmbc002 IN (SELECT nmas002 FROM nmas_t 
                          WHERE nmasent=g_enterprise AND nmas001=g_nmaa_d[l_ac].nmaa001
                         )
     #160323-00005#1--add--end
         AND nmbc100 = g_nmaa_d[l_ac].nmbc100 AND nmbc006 = '1'
         AND nmbccomp = g_browser[g_current_idx].b_ooed004
         AND nmbc005 <= g_ooed006
         
       #原幣提出,本幣提出,本位幣2提出,本位幣3提出
      SELECT SUM(nmbc103),SUM(nmbc113),SUM(nmbc123),SUM(nmbc133) 
        INTO l_nmbc103_2,l_nmbc113_2,l_nmbc123_2,l_nmbc133_2
        FROM nmbc_t
#       WHERE nmbcent = g_enterprise AND nmbc002 = g_nmaa_d[l_ac].nmaa001 #160323-00005#1 mark
      #160323-00005#1--add--str--
       WHERE nmbcent = g_enterprise
         AND nmbc002 IN (SELECT nmas002 FROM nmas_t 
                          WHERE nmasent=g_enterprise AND nmas001=g_nmaa_d[l_ac].nmaa001
                         )
     #160323-00005#1--add--end  
         AND nmbc100 = g_nmaa_d[l_ac].nmbc100 AND nmbc006 = '2'  
         AND nmbccomp = g_browser[g_current_idx].b_ooed004
         AND nmbc005 <= g_ooed006
      
      #2015/04/15--by--02599--add--str--
      IF cl_null(l_nmbc103_1) THEN LET l_nmbc103_1 = 0 END IF
      IF cl_null(l_nmbc113_1) THEN LET l_nmbc113_1 = 0 END IF
      IF cl_null(l_nmbc123_1) THEN LET l_nmbc123_1 = 0 END IF
      IF cl_null(l_nmbc133_1) THEN LET l_nmbc133_1 = 0 END IF
      IF cl_null(l_nmbc103_2) THEN LET l_nmbc103_2 = 0 END IF
      IF cl_null(l_nmbc113_2) THEN LET l_nmbc113_2 = 0 END IF
      IF cl_null(l_nmbc123_2) THEN LET l_nmbc123_2 = 0 END IF
      IF cl_null(l_nmbc133_2) THEN LET l_nmbc133_2 = 0 END IF
      #2015/04/15--by--02599--add--end
      
      LET g_nmaa_d[l_ac].amt1 = l_nmbc103_1 - l_nmbc103_2 
      LET g_nmaa_d[l_ac].amt2 = l_nmbc113_1 - l_nmbc113_2
      LET g_nmaa_d[l_ac].amt3 = l_nmbc123_1 - l_nmbc123_2
      LET g_nmaa_d[l_ac].amt4 = l_nmbc133_1 - l_nmbc133_2 
      #end add-point
       
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
 
   
   CALL g_nmaa_d.deleteElement(g_nmaa_d.getLength())   
 
    
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq930_pb
   
   LET l_ac = 1
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
PRIVATE FUNCTION anmq930_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10  #161108-00019#2 mod type_t.num5 -> type_t.num10
 
   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
 
   IF p_flag = "/" THEN
      IF (NOT g_no_ask) THEN      
         CALL cl_getmsg("fetch",g_lang) RETURNING ls_msg
         LET INT_FLAG = 0
 
         PROMPT ls_msg CLIPPED,": " FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl" 
         END PROMPT
 
         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE  
         END IF           
      END IF
   END IF    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   IF NOT cl_null(g_browser[g_current_idx].b_ooed004) AND NOT cl_null(g_browser[g_current_idx].b_ooed005) THEN 
      CALL anmq930_b_fill()
   END IF

   #保存單頭舊值
   LET g_ooed002_t = g_ooed002
   
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
#   DISPLAY g_browser.getLength() TO FORMONLY.h_count
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
PRIVATE FUNCTION anmq930_nmaa001_desc()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmaa_d[l_ac].nmaa001
      CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_nmaa_d[l_ac].nmaa001_desc = g_rtn_fields[1]
      DISPLAY g_nmaa_d[l_ac].nmaa001_desc TO nmaa001_desc
END FUNCTION

#end add-point
 
{</section>}
 

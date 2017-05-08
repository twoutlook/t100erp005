#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi429_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2013-09-18 00:00:00), PR版次:0003(2015-07-06 17:12:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000136
#+ Filename...: aooi429_01
#+ Description: 整批產生製造組別行事歷資料
#+ Creator....: 02482(2013-09-17 11:56:44)
#+ Modifier...: 02669 -SD/PR- 02295
 
{</section>}
 
{<section id="aooi429_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_oogg_m        RECORD
       year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   oogc003 LIKE type_t.chr500, 
   oogg003 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_str          STRING
#end add-point
 
DEFINE g_oogg_m        type_g_oogg_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi429_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi429_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_oogg001
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_ooef008       LIKE ooef_t.ooef008
   DEFINE l_ooef009       LIKE ooef_t.ooef009
   DEFINE p_oogg001       LIKE oogg_t.oogg001
   DEFINE l_year_str      STRING
   DEFINE l_year          STRING
   DEFINE l_month         STRING
   DEFINE l_date1         LIKE type_t.dat
   DEFINE l_date2         LIKE type_t.dat
   DEFINE l_oogc_str      STRING
   DEFINE l_len           LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi429_01 WITH FORM cl_ap_formpath("aoo","aooi429_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   INITIALIZE g_oogg_m.* TO NULL
   SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009
     FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   WHENEVER ERROR CALL cl_err_msg_log
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_oogg_m.year,g_oogg_m.month,g_oogg_m.oogc003,g_oogg_m.oogg003 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc003
            #add-point:BEFORE FIELD oogc003 name="input.b.oogc003"
            IF cl_null(g_oogg_m.year) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00174'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD year
            END IF
            IF cl_null(g_oogg_m.month) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00174'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD month
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc003
            
            #add-point:AFTER FIELD oogc003 name="input.a.oogc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc003
            #add-point:ON CHANGE oogc003 name="input.g.oogc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogg003
            #add-point:BEFORE FIELD oogg003 name="input.b.oogg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogg003
            
            #add-point:AFTER FIELD oogg003 name="input.a.oogg003"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogg003
            #add-point:ON CHANGE oogg003 name="input.g.oogg003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.oogc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc003
            #add-point:ON ACTION controlp INFIELD oogc003 name="input.c.oogc003"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.arg1 = l_ooef008
            LET g_qryparam.arg2 = l_ooef009
            LET l_year = g_oogg_m.year USING "&&&&"
            LET l_month = g_oogg_m.month USING "&&"
            LET l_year_str = l_year,l_month,'01'
            LET l_date1 = l_year_str
            CALL s_date_get_last_date(l_date1) RETURNING l_date2
            LET g_qryparam.where = " oogc003 >= '",l_date1,"' AND oogc003 <= '",l_date2,"'"
            CALL q_oogc003()
            LET g_oogg_m.oogc003 = g_qryparam.return1 
            LET l_str =g_qryparam.return1
            LET l_oogc_str = g_oogg_m.oogc003
            LET l_len = l_oogc_str.getlength()
            IF l_len >= 80 THEN
               LET g_oogg_m.oogc003[78]="."
               LET g_oogg_m.oogc003[79]="."
               LET g_oogg_m.oogc003[80]="."
            END IF
            DISPLAY  g_oogg_m.oogc003 TO oogc003
            #END add-point
 
 
         #Ctrlp:input.c.oogg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogg003
            #add-point:ON ACTION controlp INFIELD oogg003 name="input.c.oogg003"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            CALL q_oogd001()
            LET g_oogg_m.oogg003 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO oogg003
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            CALL aooi429_01_ins(p_oogg001)
            IF NOT cl_ask_confirm('aoo-00172') THEN
               LET INT_FLAG = FALSE   #xianghui-20150706-add
               EXIT DIALOG
               CLOSE WINDOW w_aooi429_01
            ELSE
               INITIALIZE g_oogg_m.* TO NULL
               ACCEPT DIALOG
            END IF

            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
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
   LET INT_FLAG = FALSE   #xianghui-20150706-add
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aooi429_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi429_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi429_01.other_function" readonly="Y" >}
#ins oogg_t
PRIVATE FUNCTION aooi429_01_ins(p_oogg001)
DEFINE p_oogg001            LIKE oogg_t.oogg001
DEFINE l_year_str           STRING
DEFINE l_year               STRING
DEFINE l_month              STRING
DEFINE l_date1              LIKE type_t.dat
DEFINE l_date2              LIKE type_t.dat
DEFINE l_sql                STRING
DEFINE l_time               LIKE oogg_t.ooggmoddt
DEFINE l_wc                 STRING

   LET l_year = g_oogg_m.year USING "&&&&"
   LET l_month = g_oogg_m.month USING "&&"
   LET l_year_str = l_year,l_month,'01'
   LET l_date1 = l_year_str
   CALL s_date_get_last_date(l_date1) RETURNING l_date2
   LET l_wc = " oogc003 >= '",l_date1,"' AND oogc003 <= '",l_date2,"'"
   LET l_time = cl_get_current()
   LET l_str = "'",cl_replace_str(l_str,"|","','"),"'"
   LET l_sql = " INSERT INTO oogg_t(ooggent,ooggsite,oogg001,oogg002,ooggstus,oogg003,ooggmodid,ooggmoddt,ooggownid,ooggowndp,ooggcrtid,ooggcrtdp,ooggcrtdt)",
               " SELECT DISTINCT '",g_enterprise,"','",g_site,"','",p_oogg001,"',oogc003,'Y','",g_oogg_m.oogg003,"','','','",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',TO_DATE('",l_time,"','YYYY-MM-DD HH24:MI:SS') ",   ##xianghui-20150706-mod
               "   FROM oogc_t ",
               "  WHERE oogc003 IN (",l_str,")",
               "    AND oogcent = '",g_enterprise,"'",
               "    AND oogc003 NOT IN( SELECT oogg002 FROM oogg_t WHERE oogg001 = '",p_oogg001,"' AND ooggent = '",g_enterprise,"' AND ooggsite = '",g_site,"')",
               "    AND ",l_wc CLIPPED
   PREPARE ins_oogg_pre FROM l_sql
   EXECUTE ins_oogg_pre
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins_oogg"
       LET g_errparam.popup = TRUE
       CALL cl_err()
   END IF
 
END FUNCTION

 
{</section>}
 

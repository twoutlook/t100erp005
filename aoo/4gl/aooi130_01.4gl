#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi130_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-12-15 10:20:16), PR版次:0004(2016-04-25 14:32:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000149
#+ Filename...: aooi130_01
#+ Description: 員工銀行帳號設定
#+ Creator....: 01258(2013-08-16 10:41:56)
#+ Modifier...: 04441 -SD/PR- 07900
 
{</section>}
 
{<section id="aooi130_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#24  2016/04/25  BY 07900   校验代码重复错误讯息的修改
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
PRIVATE TYPE type_g_ooag_d        RECORD
       ooag001 LIKE ooag_t.ooag001, 
   ooag011 LIKE ooag_t.ooag011, 
   ooag006 LIKE ooag_t.ooag006, 
   ooag007 LIKE ooag_t.ooag007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
DEFINE g_ooag_d          DYNAMIC ARRAY OF type_g_ooag_d
DEFINE g_ooag_d_t        type_g_ooag_d
 
 
DEFINE g_ooag001_t   LIKE ooag_t.ooag001    #Key值備份
 
 
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
 
{<section id="aooi130_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi130_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooag001
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
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE p_ooag001       LIKE ooag_t.ooag001
   DEFINE l_forupd_sql    STRING
   DEFINE l_ooef006       LIKE ooef_t.ooef006 #dorislai-20151023-add
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi130_01 WITH FORM cl_ap_formpath("aoo","aooi130_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   
   CALL aooi130_01_b_fill(p_ooag001)
   
   LET l_ac = 1
   LET l_forupd_sql = "SELECT ooag001,ooag011,ooag006,ooag007 FROM ooag_t WHERE ooagent = ? AND ooag001 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE aooi130_01_bcl CURSOR FROM l_forupd_sql
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_ooag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            #dorislai-20151023-add----(S)
            SELECT ooef006 INTO l_ooef006 FROM ooef_t 
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            #dorislai-20151023-add----(E)
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            LET l_lock_sw = 'N'
            CALL s_transaction_begin()
            OPEN aooi130_01_bcl USING g_enterprise,p_ooag001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "aooi130_bcl"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_lock_sw='Y'
            ELSE
               FETCH aooi130_01_bcl INTO g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag006,g_ooag_d[l_ac].ooag007
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = g_ooag_d[l_ac].ooag001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw = "Y"
               END IF
               DISPLAY BY NAME g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag006,g_ooag_d[l_ac].ooag007
            END IF
            
          ON ROW CHANGE
             CALL s_transaction_begin()
             UPDATE ooag_t SET (ooag006,ooag007,ooagmodid,ooagmoddt) = (g_ooag_d[l_ac].ooag006,g_ooag_d[l_ac].ooag007,g_user,g_today)
               WHERE ooagent = g_enterprise AND ooag001 = g_ooag_d[l_ac].ooag001
             IF SQLCA.SQLcode  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ooag_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                CALL s_transaction_end('N','0')
             ELSE
                CALL s_transaction_end('Y','0')
             END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag006
            #add-point:BEFORE FIELD ooag006 name="input.b.page1.ooag006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag006
            
            #add-point:AFTER FIELD ooag006 name="input.a.page1.ooag006"
            #dorislai-20151023-add----(S)
            IF NOT cl_null(g_ooag_d[l_ac].ooag006) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_ooag_d[l_ac].ooag006
               LET g_chkparam.where = " nmab008 = '",l_ooef006,"'"
               #160318-00025#24  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
               #160318-00025#24  by 07900 --add-end
               IF cl_chk_exist("v_nmab001") THEN
                  SELECT ooag007 INTO g_ooag_d[l_ac].ooag007 FROM ooag_t 
                   WHERE ooagent = g_enterprise AND ooag001 = p_ooag001 
               ELSE
                  LET g_ooag_d[l_ac].ooag006 = g_ooag_d_t.ooag006
                  NEXT FIELD CURRENT
               END IF
            END IF
            DISPLAY BY NAME g_ooag_d[l_ac].ooag006,g_ooag_d[l_ac].ooag007
            #dorislai-20151023-add----(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag006
            #add-point:ON CHANGE ooag006 name="input.g.page1.ooag006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag007
            #add-point:BEFORE FIELD ooag007 name="input.b.page1.ooag007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag007
            
            #add-point:AFTER FIELD ooag007 name="input.a.page1.ooag007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag007
            #add-point:ON CHANGE ooag007 name="input.g.page1.ooag007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.ooag006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag006
            #add-point:ON ACTION controlp INFIELD ooag006 name="input.c.page1.ooag006"
            #dorislai-20151023-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag006
            LET g_qryparam.where = " nmab008 = '",l_ooef006,"'"
            CALL q_nmab001()
            LET g_ooag_d[l_ac].ooag006 = g_qryparam.return1
            DISPLAY BY NAME g_ooag_d[l_ac].ooag006
            NEXT FIELD ooag006
            #dorislai-20151023-add----(E)
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag007
            #add-point:ON ACTION controlp INFIELD ooag007 name="input.c.page1.ooag007"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
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
   LET INT_FLAG = FALSE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aooi130_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi130_01.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aooi130_01_b_fill(p_ooag001)
DEFINE l_sql        STRING
DEFINE p_ooag001    LIKE ooag_t.ooag001
DEFINE l_ac1        LIKE type_t.num5

   LET l_sql = " SELECT ooag001,ooag011,ooag006,ooag007 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = '",p_ooag001,"' "
   PREPARE aooi130_01_b_fill_pb FROM l_sql
   DECLARE aooi130_01_b_fill_cs CURSOR FOR aooi130_01_b_fill_pb

   CALL g_ooag_d.clear()
   LET l_ac = 1
   FOREACH aooi130_01_b_fill_cs INTO g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag006,g_ooag_d[l_ac].ooag007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_ooag_d.deleteElement(g_ooag_d.getLength())
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE aooi130_01_b_fill_cs
   FREE aooi130_01_b_fill_pb
END FUNCTION

 
{</section>}
 

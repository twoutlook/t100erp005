#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt521_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-25 18:31:42), PR版次:0001(2016-01-12 11:05:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: aglt521_01
#+ Description: 計算未實現損益
#+ Creator....: 04152(2015-11-25 18:27:18)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aglt521_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160111         2016/01/11 By Reanna 規格調整內部交易成本算法
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
PRIVATE type type_g_gldc_m        RECORD
       gldc004 LIKE gldc_t.gldc004
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gldu         RECORD
                         gldu005   LIKE gldu_t.gldu005,
                         gldu006   LIKE gldu_t.gldu006,
                         gldu007   LIKE gldu_t.gldu007,
                         gldu009   LIKE gldu_t.gldu009,
                         gldu018   LIKE gldu_t.gldu018,
                         gldu019   LIKE gldu_t.gldu019,
                         gldu020   LIKE gldu_t.gldu020,
                         gldu021   LIKE gldu_t.gldu021,  #160111 add
                         gldu022   LIKE gldu_t.gldu022,  #160111 add
                         gldu023   LIKE gldu_t.gldu023,  #160111 add
                         gldu024   LIKE gldu_t.gldu024,
                         gldu025   LIKE gldu_t.gldu025,
                         gldu026   LIKE gldu_t.gldu026,
                         gldu027   LIKE gldu_t.gldu027,
                         gldu028   LIKE gldu_t.gldu028,
                         gldu029   LIKE gldu_t.gldu029
                      END RECORD
#end add-point
 
DEFINE g_gldc_m        type_g_gldc_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt521_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt521_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glduld,p_gldu001,p_gldu002,p_gldu003,p_gldu004
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
   DEFINE p_glduld        LIKE gldu_t.glduld
   DEFINE p_gldu001       LIKE gldu_t.gldu001
   DEFINE p_gldu002       LIKE gldu_t.gldu002
   DEFINE p_gldu003       LIKE gldu_t.gldu003
   DEFINE p_gldu004       LIKE gldu_t.gldu004
   DEFINE l_sql           STRING
   DEFINE r_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt521_01 WITH FORM cl_ap_formpath("agl","aglt521_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_success = TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_gldc_m.gldc004 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldc004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldc_m.gldc004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD gldc004
            END IF 
 
 
 
            #add-point:AFTER FIELD gldc004 name="input.a.gldc004"
            IF NOT cl_null(g_gldc_m.gldc004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldc004
            #add-point:BEFORE FIELD gldc004 name="input.b.gldc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldc004
            #add-point:ON CHANGE gldc004 name="input.g.gldc004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gldc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldc004
            #add-point:ON ACTION controlp INFIELD gldc004 name="input.c.gldc004"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aglt521_01 
   
   #add-point:input段after input name="input.post_input"
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      IF NOT cl_null(g_gldc_m.gldc004)THEN
         #160111 add gldu021,gldu022,gldu023
         LET l_sql = "SELECT gldu005,gldu006,gldu007,gldu009,gldu018,",
                     "       gldu019,gldu020,gldu021,gldu022,gldu023",
                     "  FROM gldu_t",
                     " WHERE glduent = ",g_enterprise,
                     "   AND glduld = '",p_glduld,"'",
                     "   AND gldu001 = '",p_gldu001,"'",
                     "   AND gldu002 = '",p_gldu002,"'",
                     "   AND gldu003 = ",p_gldu003,
                     "   AND gldu004 = ",p_gldu004
         PREPARE sel_gldu_p FROM l_sql
         DECLARE sel_gldu_c CURSOR FOR sel_gldu_p
         #160111 add gldu021,gldu022,gldu023
         FOREACH sel_gldu_c INTO g_gldu.gldu005,g_gldu.gldu006,g_gldu.gldu007,g_gldu.gldu009,g_gldu.gldu018,
                                 g_gldu.gldu019,g_gldu.gldu020,g_gldu.gldu021,g_gldu.gldu022,g_gldu.gldu023
            IF cl_null(g_gldu.gldu018) THEN LET g_gldu.gldu018 = 0 END IF
            IF cl_null(g_gldu.gldu019) THEN LET g_gldu.gldu019 = 0 END IF
            IF cl_null(g_gldu.gldu020) THEN LET g_gldu.gldu020 = 0 END IF
            IF cl_null(g_gldu.gldu021) THEN LET g_gldu.gldu021 = 0 END IF  #160111 add
            IF cl_null(g_gldu.gldu022) THEN LET g_gldu.gldu022 = 0 END IF  #160111 add
            IF cl_null(g_gldu.gldu023) THEN LET g_gldu.gldu023 = 0 END IF  #160111 add
            #記帳幣計算：
            #自動計算未實現損益(記帳幣) gldu027 = 內部交易收入(記帳幣) gldu018 * g_rate/100
            LET g_gldu.gldu027 = g_gldu.gldu018 * g_gldc_m.gldc004 / 100
            IF cl_null(g_gldu.gldu027) THEN LET g_gldu.gldu027 = 0 END IF
            CALL s_curr_round_ld('1',p_glduld,g_gldu.gldu005,g_gldu.gldu027,2) RETURNING g_sub_success,g_errno,g_gldu.gldu027
            #內部交易成本(記帳幣) gldu024 = 內部交易收入(記帳幣) gldu018 - 自動計算未實現損益(記帳幣) gldu027
            #內部交易成本(記帳幣) gudu024 = gldu018 -gldu027(4-1-1算完的結果) - gldu021  #160111 fix
            #LET g_gldu.gldu024 = g_gldu.gldu018 - g_gldu.gldu027                     #160111 mark
            LET g_gldu.gldu024 = g_gldu.gldu018 - g_gldu.gldu027 - g_gldu.gldu021     #160111 fix
            
            #功能幣計算：
            #自動計算未實現損益(功能幣) gldu028 = 內部交易收入(記帳幣) gldu019 * g_rate/100
            LET g_gldu.gldu028 = g_gldu.gldu019 * g_gldc_m.gldc004 / 100
            IF cl_null(g_gldu.gldu028) THEN LET g_gldu.gldu028 = 0 END IF
            CALL s_curr_round_ld('1',p_glduld,g_gldu.gldu006,g_gldu.gldu028,2) RETURNING g_sub_success,g_errno,g_gldu.gldu028
            #內部交易成本(報告幣) gldu025 = 內部交易收入(記帳幣) gldu019 - 自動計算未實現損益(記帳幣) gldu028
            #內部交易成本(報告幣) gudu025 = gldu019 - gldu028(4-2-1算完的結果) - gldu022 #160111 fix
            LET g_gldu.gldu025 = g_gldu.gldu019 - g_gldu.gldu028                      #160111 mark
            LET g_gldu.gldu025 = g_gldu.gldu019 - g_gldu.gldu028 - g_gldu.gldu022     #160111 fix
            
            #報告幣計算：
            #自動計算未實現損益(報告幣) gldu029 = 內部交易收入(記帳幣) gldu020 * g_rate/100
            LET g_gldu.gldu029 = g_gldu.gldu020 * g_gldc_m.gldc004 / 100
            IF cl_null(g_gldu.gldu029) THEN LET g_gldu.gldu029 = 0 END IF
            CALL s_curr_round_ld('1',p_glduld,g_gldu.gldu007,g_gldu.gldu029,2) RETURNING g_sub_success,g_errno,g_gldu.gldu029
            #內部交易成本(報告幣) gldu026 = 內部交易收入(記帳幣) gldu020 - 自動計算未實現損益(記帳幣) gldu029
            #內部交易成本(報告幣) gldu026 = gldu020 - gldu029(4-3-1算完的結果) - gldu023 #160111 fix
            LET g_gldu.gldu026 = g_gldu.gldu020 - g_gldu.gldu029                      #160111 mark
            LET g_gldu.gldu026 = g_gldu.gldu020 - g_gldu.gldu029 - g_gldu.gldu023     #160111 fix
            
            UPDATE gldu_t SET gldu024 = g_gldu.gldu024,
                              gldu025 = g_gldu.gldu025,
                              gldu026 = g_gldu.gldu026,
                              gldu027 = g_gldu.gldu027,
                              gldu028 = g_gldu.gldu028,
                              gldu029 = g_gldu.gldu029
             WHERE glduent = g_enterprise
               AND glduld =  p_glduld
               AND gldu001 = p_gldu001
               AND gldu002 = p_gldu002
               AND gldu003 = p_gldu003
               AND gldu004 = p_gldu004
               AND gldu009 = g_gldu.gldu009
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "gldu_t"
                  LET g_errparam.code   = "std-00009"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "gldu_t"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
               OTHERWISE
            END CASE
         END FOREACH
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt521_01.other_function" readonly="Y" >}

 
{</section>}
 

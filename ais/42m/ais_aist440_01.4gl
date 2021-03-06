#該程式未解開Section, 採用最新樣板產出!
{<section id="aist440_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-12-17 17:46:28), PR版次:0001(2015-12-29 12:44:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aist440_01
#+ Description: 兼營營業人營業稅額調整整批產生
#+ Creator....: 04152(2015-12-17 17:27:13)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aist440_01.global" >}
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
PRIVATE type type_g_isaa_m        RECORD
       isaa001 LIKE isaa_t.isaa001, 
   isaa001_desc LIKE type_t.chr80, 
   isaa012 LIKE isaa_t.isaa012, 
   isaa013 LIKE isaa_t.isaa013, 
   l_isaa013_2 LIKE type_t.num5
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_isaa012_t           LIKE isaa_t.isaa012
DEFINE l_cnt                 LIKE type_t.num10
#end add-point
 
DEFINE g_isaa_m        type_g_isaa_m
 
   DEFINE g_isaa001_t LIKE isaa_t.isaa001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aist440_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aist440_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE r_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aist440_01 WITH FORM cl_ap_formpath("ais","aist440_01")
 
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
      INPUT BY NAME g_isaa_m.isaa001,g_isaa_m.isaa012,g_isaa_m.isaa013,g_isaa_m.l_isaa013_2 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #取該g_site的法人
            SELECT ooef017 INTO g_isaa_m.isaa001
              FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_site
            CALL s_desc_get_department_desc(g_isaa_m.isaa001) RETURNING g_isaa_m.isaa001_desc
            DISPLAY BY NAME g_isaa_m.isaa001_desc
            #預設:已申報年度
            SELECT isaa012 INTO g_isaa_m.isaa012
              FROM isaa_t
             WHERE isaaent = g_enterprise AND isaa001 = g_isaa_m.isaa001
            LET g_isaa_m.isaa013 = 1
            LET g_isaa_m.l_isaa013_2 = 12
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa001
            
            #add-point:AFTER FIELD isaa001 name="input.a.isaa001"
            #申報單位
            IF NOT cl_null(g_isaa_m.isaa001) THEN
               #申報單位須存在aisi010裡面
               SELECT COUNT(*) INTO l_cnt
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_isaa_m.isaa001
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00193'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isaa_m.isaa001) RETURNING g_isaa_m.isaa001_desc
            DISPLAY BY NAME g_isaa_m.isaa001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_isaa_m.isaa012,"0","0","2099","1","azz-00087",1) THEN
               NEXT FIELD isaa012
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa012 name="input.a.isaa012"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa012
            #add-point:BEFORE FIELD isaa012 name="input.b.isaa012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa012
            #add-point:ON CHANGE isaa012 name="input.g.isaa012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_isaa_m.isaa013,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD isaa013
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa013 name="input.a.isaa013"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa013
            #add-point:BEFORE FIELD isaa013 name="input.b.isaa013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa013
            #add-point:ON CHANGE isaa013 name="input.g.isaa013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaa013_2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_isaa_m.l_isaa013_2,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD l_isaa013_2
            END IF 
 
 
 
            #add-point:AFTER FIELD l_isaa013_2 name="input.a.l_isaa013_2"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaa013_2
            #add-point:BEFORE FIELD l_isaa013_2 name="input.b.l_isaa013_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaa013_2
            #add-point:ON CHANGE l_isaa013_2 name="input.g.l_isaa013_2"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa001
            #add-point:ON ACTION controlp INFIELD isaa001 name="input.c.isaa001"
            #i開窗-申報單位代碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isaa_m.isaa001
            LET g_qryparam.where = "isaastus = 'Y' "
            CALL q_isaa001()
            LET g_isaa_m.isaa001 = g_qryparam.return1
            DISPLAY BY NAME g_isaa_m.isaa001
            NEXT FIELD isaa001
            #END add-point
 
 
         #Ctrlp:input.c.isaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa012
            #add-point:ON ACTION controlp INFIELD isaa012 name="input.c.isaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa013
            #add-point:ON ACTION controlp INFIELD isaa013 name="input.c.isaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isaa013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaa013_2
            #add-point:ON ACTION controlp INFIELD l_isaa013_2 name="input.c.l_isaa013_2"
            
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
   CLOSE WINDOW w_aist440_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   END IF
   
   RETURN r_success,g_isaa_m.isaa001,g_isaa_m.isaa012,g_isaa_m.isaa013,g_isaa_m.l_isaa013_2
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aist440_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aist440_01.other_function" readonly="Y" >}

 
{</section>}
 

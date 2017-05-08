#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt410_09.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-10-13 18:43:55), PR版次:0001(2014-10-15 14:01:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: aapt410_09
#+ Description: 差異金額處理
#+ Creator....: 03538(2014-10-13 16:15:55)
#+ Modifier...: 03538 -SD/PR- 03538
 
{</section>}
 
{<section id="aapt410_09.global" >}
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
PRIVATE type type_g_apea_m        RECORD
       apeadocno LIKE apea_t.apeadocno, 
   apeald LIKE apea_t.apeald, 
   exit LIKE type_t.chr1, 
   a LIKE type_t.chr1, 
   b LIKE type_t.chr1
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_balance_apee119 LIKE type_t.num20_6
DEFINE l_nouse           LIKE type_t.num20_6
#end add-point
 
DEFINE g_apea_m        type_g_apea_m
 
   DEFINE g_apeadocno_t LIKE apea_t.apeadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt410_09.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt410_09(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_apeald,
   p_apeadocno
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
   DEFINE r_redo_diff       LIKE type_t.num5        #不離開作業(繼續作差異)
   DEFINE p_apeald          LIKE apea_t.apeald
   DEFINE p_apeadocno       LIKE apea_t.apeadocno

   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt410_09 WITH FORM cl_ap_formpath("aap","aapt410_09")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET r_redo_diff        = TRUE     #預設下次要再做
   LET g_apea_m.apeadocno = p_apeadocno
   LET g_apea_m.apeald    = p_apeald
   LET g_balance_apee119 = NULL


   CALL s_aapt410_balance_chk(g_apea_m.apeald,g_apea_m.apeadocno,'aapt410')
      RETURNING g_sub_success,g_errno,g_balance_apee119
   #差異處理                              
   #判斷是否需要處理差異 不需要就跳出
   IF g_balance_apee119 = 0 THEN
      LET r_redo_diff = FALSE
      CLOSE WINDOW w_aapt410_09 
      RETURN r_redo_diff
   END IF 
   #本幣平就不處理其他類別
   CALL aapt410_09_init()
   CALL aapt410_09_set_entry()
   CALL aapt410_09_set_no_entry()
   LET g_apea_m.exit = 'ESC'
   LET g_apea_m.a = ''   
   LET g_apea_m.b = '' 
   DISPLAY BY NAME g_apea_m.exit,g_apea_m.a,g_apea_m.b
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apea_m.apeadocno,g_apea_m.apeald,g_apea_m.exit,g_apea_m.a,g_apea_m.b ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeadocno
            #add-point:BEFORE FIELD apeadocno name="input.b.apeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeadocno
            
            #add-point:AFTER FIELD apeadocno name="input.a.apeadocno"
            #此段落由子樣板a05產生




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeadocno
            #add-point:ON CHANGE apeadocno name="input.g.apeadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeald
            #add-point:BEFORE FIELD apeald name="input.b.apeald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeald
            
            #add-point:AFTER FIELD apeald name="input.a.apeald"




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeald
            #add-point:ON CHANGE apeald name="input.g.apeald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD exit
            #add-point:BEFORE FIELD exit name="input.b.exit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD exit
            
            #add-point:AFTER FIELD exit name="input.a.exit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE exit
            #add-point:ON CHANGE exit name="input.g.exit"
            IF NOT cl_null(g_apea_m.exit)THEN
               LET g_apea_m.a = ''
               LET g_apea_m.b = ''
               DISPLAY BY NAME g_apea_m.a,g_apea_m.b
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            #entry no entry 沒用所以改這個寫法
            IF g_balance_apee119 > 0 THEN
               NEXT FIELD b
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            #此段落由子樣板a05產生




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            IF NOT cl_null(g_apea_m.a)THEN
               LET g_apea_m.exit= ''
               DISPLAY BY NAME g_apea_m.exit
            END IF             
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            #entry no entry 沒用所以改這個寫法
            IF g_balance_apee119 < 0 THEN
               NEXT FIELD a
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            IF NOT cl_null(g_apea_m.b)THEN
               LET g_apea_m.exit= ''
               DISPLAY BY NAME g_apea_m.exit
            END IF             
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apeadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeadocno
            #add-point:ON ACTION controlp INFIELD apeadocno name="input.c.apeadocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.apeald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeald
            #add-point:ON ACTION controlp INFIELD apeald name="input.c.apeald"
            
            #END add-point
 
 
         #Ctrlp:input.c.exit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD exit
            #add-point:ON ACTION controlp INFIELD exit name="input.c.exit"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF cl_null(g_apea_m.a) AND cl_null(g_apea_m.b)
               AND cl_null(g_apea_m.exit)THEN
               NEXT FIELD exit
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
   CALL aapt410_09_set_entry()  
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt410_09 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG OR NOT cl_null(g_apea_m.exit) THEN
      LET INT_FLAG = 0 
      LET r_redo_diff = FALSE  
      RETURN r_redo_diff
   END IF
   
   CASE
      WHEN g_apea_m.a = '12' OR g_apea_m.b = '11'
         CALL aapt410_01_apee_diff(g_apea_m.apeadocno,g_apea_m.apeald,'12','11') 
         
      OTHERWISE
         IF cl_null(g_apea_m.a) THEN LET g_apea_m.a = g_apea_m.b END IF
         IF cl_null(g_apea_m.b) THEN LET g_apea_m.b = g_apea_m.a END IF
         CALL aapt410_01_apee_diff(g_apea_m.apeadocno,g_apea_m.apeald,g_apea_m.a,g_apea_m.b) 
   END CASE

   RETURN r_redo_diff
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410_09.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt410_09.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 子程式畫面預設
# Memo...........:
# Usage..........: CALL aapt410_09_init()
# Input parameter: 
# Return code....: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt410_09_init()
   DEFINE l_gzze001   LIKE type_t.chr1000
   DEFINE l_str       STRING
   LET INT_FLAG = FALSE 
   LET l_gzze001 = cl_getmsg('aap-00056',g_dlang)

   LET l_str = '12,14,15,19,22'
   CALL cl_set_combo_scc_part('a','8506',l_str)


   LET l_str = '11,19,20,21'
   CALL cl_set_combo_scc_part('b','8506',l_str) 
   
   CALL cl_set_combo_items('exit','ESC',l_gzze001)
END FUNCTION

################################################################################
# Descriptions...: 欄位可輸入
# Memo...........:
# Usage..........: CALL aapt410_09_set_entry()
# Input parameter: 
# Return code....: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt410_09_set_entry()
   CALL cl_set_comp_entry("exit,a,b",TRUE)
   CALL cl_set_comp_visible("aapt410_09_group2,group3",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 欄位不可輸入
# Memo...........:
# Usage..........: CALL aapt410_09_set_no_entry()
# Input parameter: 
# Return code....: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt410_09_set_no_entry()
   CASE 
      #付款<帳款
      WHEN g_balance_apee119 < 0 
         CALL cl_set_comp_entry("b",FALSE)
         CALL cl_set_comp_visible("group3",FALSE)
      #付款>帳款
      WHEN g_balance_apee119 > 0
         CALL cl_set_comp_entry("a",FALSE)
         CALL cl_set_comp_visible("aapt410_09_group2",FALSE)
      WHEN g_balance_apee119 = 0 
   END CASE
END FUNCTION

 
{</section>}
 

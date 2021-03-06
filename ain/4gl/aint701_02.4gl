#該程式未解開Section, 採用最新樣板產出!
{<section id="aint701_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-09-09 13:38:20), PR版次:0005(2017-02-02 15:43:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000012
#+ Filename...: aint701_02
#+ Description: 裝箱單封箱子程式
#+ Creator....: 06814(2016-09-09 10:41:08)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="aint701_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161012-00020#1   2016/10/13 by 06137  調整直接列印時原CALL aint701_01改為ainr701
#170119-00027#1   2017/01/20 By 06814  aint701打印优化:若直接列印裝箱清單為Y，則直接呼叫報表元件預覽
#170202-00026#1   2017/02/02 By 06814  修正WHERE 條件沒下ent
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util    #161012-00020#1 Add By Ken 161013
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_inbn_m        RECORD
       inbndocno LIKE inbn_t.inbndocno, 
   l_choise LIKE type_t.chr1, 
   inbn001 LIKE inbn_t.inbn001, 
   l_flag LIKE type_t.chr1
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_inbmdocno     LIKE inbm_t.inbmdocno
DEFINE g_inbn001       LIKE inbn_t.inbn001
DEFINE g_inbn002       LIKE inbn_t.inbn002
DEFINE g_inbm003       LIKE inbm_t.inbm003  #161129-00027#6 add by yany 2016/12/23
#end add-point
 
DEFINE g_inbn_m        type_g_inbn_m
 
   DEFINE g_inbndocno_t LIKE inbn_t.inbndocno
DEFINE g_inbn001_t LIKE inbn_t.inbn001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aint701_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aint701_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_inbmdocno,
   p_inbn001
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
   DEFINE p_inbmdocno     LIKE inbm_t.inbmdocno
   DEFINE p_inbn001       LIKE inbn_t.inbn001
   #161012-00020#1 Add By Ken 161013(S)
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD   
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用 
   DEFINE l_wc       STRING   
   #161012-00020#1 Add By Ken 161013(E)
   DEFINE l_print_wc STRING          #170119-00027#1 20170120 add by beckxie
   DEFINE l_action_choice_o STRING   #170119-00027#1 20170120 add by beckxie
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint701_02 WITH FORM cl_ap_formpath("ain","aint701_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_inbmdocno = p_inbmdocno
   LET g_inbn001 = p_inbn001
   SELECT inbn002 INTO g_inbn002
     FROM inbn_t
    WHERE inbnent = g_enterprise
      AND inbndocno = g_inbmdocno
      AND inbn001 = g_inbn001
   
   #161129-00027#6 add by yany 2016/12/23 --str
   SELECT inbm003 INTO g_inbm003 FROM inbm_t
    #WHERE inbmdocno = g_inbmdocno                             #170202-00026#1 20170202 mark by beckxie
    WHERE inbment = g_enterprise AND inbmdocno = g_inbmdocno   #170202-00026#1 20170202 add by beckxie
   #161129-00027#6 add by yany 2016/12/23 --end
   CALL cl_set_combo_scc('l_choise','6970') 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_inbn_m.inbndocno,g_inbn_m.l_choise,g_inbn_m.inbn001,g_inbn_m.l_flag ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbndocno
            #add-point:BEFORE FIELD inbndocno name="input.b.inbndocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbndocno
            
            #add-point:AFTER FIELD inbndocno name="input.a.inbndocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_inbn_m.inbndocno) AND NOT cl_null(g_inbn_m.inbn001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbn_m.inbndocno != g_inbndocno_t  OR g_inbn_m.inbn001 != g_inbn001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbn_t WHERE "||"inbnent = " ||g_enterprise|| " AND "||"inbndocno = '"||g_inbn_m.inbndocno ||"' AND "|| "inbn001 = '"||g_inbn_m.inbn001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbndocno
            #add-point:ON CHANGE inbndocno name="input.g.inbndocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_choise
            #add-point:BEFORE FIELD l_choise name="input.b.l_choise"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_choise
            
            #add-point:AFTER FIELD l_choise name="input.a.l_choise"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_choise
            #add-point:ON CHANGE l_choise name="input.g.l_choise"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbn001
            #add-point:BEFORE FIELD inbn001 name="input.b.inbn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbn001
            
            #add-point:AFTER FIELD inbn001 name="input.a.inbn001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_inbn_m.inbndocno) AND NOT cl_null(g_inbn_m.inbn001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbn_m.inbndocno != g_inbndocno_t  OR g_inbn_m.inbn001 != g_inbn001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbn_t WHERE "||"inbnent = " ||g_enterprise|| " AND "||"inbndocno = '"||g_inbn_m.inbndocno ||"' AND "|| "inbn001 = '"||g_inbn_m.inbn001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbn001
            #add-point:ON CHANGE inbn001 name="input.g.inbn001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_flag
            #add-point:BEFORE FIELD l_flag name="input.b.l_flag"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_flag
            
            #add-point:AFTER FIELD l_flag name="input.a.l_flag"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_flag
            #add-point:ON CHANGE l_flag name="input.g.l_flag"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inbndocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbndocno
            #add-point:ON ACTION controlp INFIELD inbndocno name="input.c.inbndocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_choise
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_choise
            #add-point:ON ACTION controlp INFIELD l_choise name="input.c.l_choise"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbn001
            #add-point:ON ACTION controlp INFIELD inbn001 name="input.c.inbn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_flag
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_flag
            #add-point:ON ACTION controlp INFIELD l_flag name="input.c.l_flag"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      BEFORE DIALOG
         CALL cl_set_act_visible("accept",FALSE)
         CALL cl_set_act_visible("cancel",FALSE)        
         
         #IF 當前箱狀態為1.未封箱 then 箱狀態默認1.封箱 ELSE 默認2.開箱
         CASE g_inbn002
            WHEN '1'
               LET g_inbn_m.l_choise = '1'
               #161129-00027#6 add by yany 2016/12/23 --str
               #若是委外采购收货，则默认不勾选直接打印装箱清单
               IF g_inbm003 = '5' THEN
                  LET g_inbn_m.l_flag = 'N'
               ELSE
               #161129-00027#6 add by yany 2016/12/23 --end
                  LET g_inbn_m.l_flag = 'Y'   #20160920 add by beckxie SA:若為開箱默認不勾
               END IF
            WHEN '2'
               LET g_inbn_m.l_choise = '2'
               LET g_inbn_m.l_flag = 'N'   #20160920 add by beckxie SA:若為開箱默認不勾
         END CASE
         LET g_inbn_m.inbndocno = g_inbmdocno
         LET g_inbn_m.inbn001 = g_inbn001
         
         DISPLAY BY NAME g_inbn_m.inbndocno,g_inbn_m.l_choise,g_inbn_m.inbn001,g_inbn_m.l_flag
         
         
      ON ACTION confirm
         IF NOT cl_null(g_inbn_m.inbndocno) AND NOT cl_null(g_inbn_m.inbn001) THEN
            UPDATE inbn_t SET inbn002 = CASE WHEN g_inbn_m.l_choise = '1' THEN '2' ELSE '1' END  
             WHERE inbnent = g_enterprise
               AND inbndocno = g_inbn_m.inbndocno
               AND inbn001 = g_inbn_m.inbn001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd_inbn"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
         END IF
         IF g_inbn_m.l_flag = 'Y' THEN
            #CALL aint701_01(g_inbn_m.inbndocno,g_inbn_m.inbn001)
            #161012-00020#1 Add By Ken 161013(S)
            IF s_transaction_chk('Y',0) THEN
               CALL s_transaction_end('Y','0')
               CALL s_transaction_begin()               
            END IF
               
            
            IF NOT cl_null(g_inbn_m.inbndocno) THEN
               #170119-00027#1 20170120 mark by beckxie---S
               #LET la_param.prog = 'ainr701'
               #LET la_param.param[1] = g_inbn_m.inbndocno
               #LET la_param.param[2] = g_inbn_m.inbn001
               #LET ls_js = util.JSON.stringify(la_param)
               #CALL cl_cmdrun_wait(ls_js)
               #170119-00027#1 20170120 mark by beckxie---E
               #170119-00027#1 20170120 add by beckxie---S
               LET l_action_choice_o = g_action_choice   #備份目前的g_action_choice
               LET g_action_choice="quickprint"
               LET l_print_wc = " inbment ="|| g_enterprise ||" AND inbmdocno ='"|| g_inbn_m.inbndocno||"' AND inbn001 ='"||g_inbn_m.inbn001||"' "
               CALL aint701_g01(l_print_wc)
               LET g_action_choice = l_action_choice_o   #還原目前的g_action_choice
               #170119-00027#1 20170120 add by beckxie---E
            END IF 
            #161012-00020#1 Add By Ken 161013(E)
         END IF
         ACCEPT DIALOG
      ON ACTION cancel1
         LET INT_FLAG = TRUE 
         EXIT DIALOG
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
   CLOSE WINDOW w_aint701_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aint701_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint701_02.other_function" readonly="Y" >}

 
{</section>}
 

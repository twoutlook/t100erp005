#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt110_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-06-02 00:33:37), PR版次:0001(2015-06-18 16:47:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: aapt110_05
#+ Description: 產生對帳明細--流通
#+ Creator....: 02114(2015-06-01 14:50:02)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="aapt110_05.global" >}
#應用 c01c 樣板自動產生(Version:10)
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_l_type              LIKE type_t.num5    #使用哪種方式產生
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="aapt110_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt110_05(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_apbb004,p_apbb002,p_apbb012,p_apbb014,p_apbb050,p_wc_apbaorga
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_apbb004       LIKE apbb_t.apbb004     #帳務中心
   DEFINE p_apbb002       LIKE apbb_t.apbb002     #交易對象
   DEFINE p_apbb012       LIKE apbb_t.apbb012     #稅別
   DEFINE p_apbb014       LIKE apbb_t.apbb014     #幣別
   DEFINE p_apbb050       LIKE apbb_t.apbb050     #發票性質
   DEFINE p_wc_apbaorga   STRING                  #帳務組織條件
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt110_05 WITH FORM cl_ap_formpath("aap","aapt110_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   CALL cl_set_combo_scc('l_type','9963')
   LET g_l_type = "1"
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON stbedocno,stbd001,stbd002,stbd021,stbd022 
      
            #add-point:自定義action name="construct.action"
            #結算單
            ON ACTION controlp INFIELD stbedocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #IF p_apbb050 = "2" THEN #紅字發票只開倉退單
               #   LET g_qryparam.arg3 = "('7','14','15')"
               #ELSE #入庫單+倉退單
               #   LET g_qryparam.arg3 = "('3','4','6','7','12','13','14','15')"
               #END IF
               LET g_qryparam.where    = "     ooef212 = 'Y' AND ooef001 IN (",p_wc_apbaorga CLIPPED,")",
                                         " AND stbd002 = '",p_apbb002,"'",
                                         " AND stbe025 = 'Y' ",
                                         " AND stbe026 = 'Y' "
               CALL q_stbddocno_1()
               DISPLAY g_qryparam.return1 TO stbedocno
               NEXT FIELD stbedocno
               
            #收貨人員
            ON ACTION controlp INFIELD stbd001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_stan001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stbd001  #顯示到畫面上
               NEXT FIELD stbd001                     #返回原欄位
            
            #供應商
            ON ACTION controlp INFIELD stbd002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_10()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stbd002  #顯示到畫面上
               NEXT FIELD stbd002                     #返回原欄位
               
            #人員
            ON ACTION controlp INFIELD stbd021
               #add-point:ON ACTION controlp INFIELD stbd021
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stbd021  #顯示到畫面上
               NEXT FIELD stbd021                     #返回原欄位
               
            #業務部門
            ON ACTION controlp INFIELD stbd022
               #add-point:ON ACTION controlp INFIELD stbd022
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_4()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stbd022  #顯示到畫面上
               NEXT FIELD stbd022    
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            IF g_l_type = "1" THEN
               LET g_wc = " 1=1 "
               NEXT FIELD l_type 
            END IF
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"

      INPUT g_l_type FROM l_type ATTRIBUTE(WITHOUT DEFAULTS)
         
         ON CHANGE l_type
            CLEAR FORM
      END INPUT

      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   IF INT_FLAG THEN
      LET g_wc = " 1=2 "
      LET INT_FLAG = 0
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_aapt110_05 
   
   #add-point:construct段after construct name="construct.post_construct"
   RETURN g_wc
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt110_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt110_05.other_function" readonly="Y" >}

 
{</section>}
 

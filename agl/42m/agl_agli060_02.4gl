#該程式未解開Section, 採用最新樣板產出!
{<section id="agli060_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-08-28 15:07:27), PR版次:0003(2016-08-26 16:33:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000163
#+ Filename...: agli060_02
#+ Description: 整批刪除
#+ Creator....: 02295(2013-08-27 14:09:55)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="agli060_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160811-00039#6   2016/08/25 By 02599   删除有权限的账套对应资料
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

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="agli060_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli060_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   
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
   DEFINE l_ld_str        STRING   #160811-00039#6
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli060_02 WITH FORM cl_ap_formpath("agl","agli060_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_qryparam.state = "c"
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON glakld,glak003,glak004 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      ON ACTION controlp 
         CASE
            WHEN INFIELD(glakld)
               LET g_qryparam.reqry = FALSE
               #160811-00039#6--add--str--
               CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
               LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glakld")
               LET g_qryparam.where = l_ld_str
               #160811-00039#6--add--end
               CALL q_glakld()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO glakld  #顯示到畫面上
               NEXT FIELD glakld                     #返回原欄位
               LET g_qryparam.where = NULL #160811-00039#6 add
            WHEN INFIELD(glak003)
               LET g_qryparam.reqry = FALSE
               CALL q_glak003()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO glak003  #顯示到畫面上
               NEXT FIELD glak003                     #返回原欄位            
            WHEN INFIELD(glak004) 
               LET g_qryparam.reqry = FALSE
               CALL q_glak004()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO glak004  #顯示到畫面上
               NEXT FIELD glak004                     #返回原欄位            
         END CASE      
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
   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_agli060_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF NOT INT_FLAG THEN 
      CALL agli060_02_del()
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli060_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli060_02.other_function" readonly="Y" >}
#+ 整批刪除glak_t資料
PRIVATE FUNCTION agli060_02_del()
DEFINE l_sql   STRING 
DEFINE l_ld_str          STRING   #160811-00039#6

   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glakld")
   IF cl_null(g_wc) THEN 
      LET g_wc = l_ld_str
   ELSE
      LET g_wc = g_wc," AND ",l_ld_str
   END IF
   #160811-00039#6--add--end
   CALL s_transaction_begin()
   LET l_sql = "DELETE FROM glak_t WHERE glakent=",g_enterprise," AND ",g_wc
   PREPARE glak_del FROM l_sql 
   EXECUTE glak_del
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glak_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      CALL s_transaction_end('N','0')                    
   ELSE
      CALL s_transaction_end('Y','0')    
   END IF   

END FUNCTION

 
{</section>}
 

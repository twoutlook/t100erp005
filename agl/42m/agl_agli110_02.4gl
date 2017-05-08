#該程式未解開Section, 採用最新樣板產出!
{<section id="agli110_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-08-26 17:08:05), PR版次:0003(2016-08-26 17:13:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000131
#+ Filename...: agli110_02
#+ Description: 整批刪除
#+ Creator....: 02114(2013-10-24 13:51:20)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="agli110_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160811-00039#6   2016/08/25 By 02599    抓取有权限的账套进行删除操作
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
DEFINE g_glaw_2       RECORD
       glaw002 LIKE glaw_t.glaw002 
       END RECORD
DEFINE g_glaw_3       RECORD
       glaw003 LIKE glaw_t.glaw003 
       END RECORD
DEFINE g_glaw_4       RECORD
       glaw004 LIKE glaw_t.glaw004
       END RECORD
DEFINE g_wc2          STRING
DEFINE g_wc3          STRING
DEFINE g_wc4          STRING
DEFINE g_sql          STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="agli110_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli110_02(--)
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
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli110_02 WITH FORM cl_ap_formpath("agl","agli110_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON glaw001 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            ON ACTION controlp INFIELD glaw001
	           INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160811-00039#6--add--str--
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld() 
               #160811-00039#6--add--end
#               CALL q_glaa001_2()                           #呼叫開窗 #160811-00039#6 mark
               DISPLAY g_qryparam.return1 TO glaw001  #顯示到畫面上

               NEXT FIELD glaw001                     #返回原欄位
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      CONSTRUCT BY NAME g_wc2 ON glaw002 
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理
            ON ACTION controlp INFIELD glaw002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
               #給予arg
               LET g_wc = cl_replace_str(g_wc,"glaw001","gladld")
               LET g_qryparam.where = g_wc
               CALL q_glad001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO glaw002  #顯示到畫面上

               NEXT FIELD glaw002                     #返回原欄位
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
       
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc3 ON glaw003 
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理
            ON ACTION controlp INFIELD glaw003
	           INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160811-00039#6--add--str--
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld() 
               #160811-00039#6--add--end
#               CALL q_glaa001_2()                           #呼叫開窗 #160811-00039#6 mark
               DISPLAY g_qryparam.return1 TO glaw003  #顯示到畫面上

               NEXT FIELD glaw003                     #返回原欄位
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
       
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc4 ON glaw004 
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理
            ON ACTION controlp INFIELD glaw004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
               #給予arg
               LET g_wc3 = cl_replace_str(g_wc3,"glaw003","gladld")
               LET g_qryparam.where = g_wc3
               CALL q_glad001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO glaw004  #顯示到畫面上

               NEXT FIELD glaw004                     #返回原欄位
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
       
      END CONSTRUCT
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
   CLOSE WINDOW w_agli110_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF INT_FLAG THEN
      LET g_success = ''
      RETURN g_success
   END IF
   
   CALL agli110_02_glaw_del()
   RETURN g_success
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli110_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli110_02.other_function" readonly="Y" >}
#+ 整批刪除glaw資料
PRIVATE FUNCTION agli110_02_glaw_del()
   DEFINE l_ld_str       STRING   #160811-00039#6
   
   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glaw001")
   LET g_wc = g_wc," AND ",l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaw001","glaw003")
   LET g_wc3 = g_wc3," AND ",l_ld_str
   #160811-00039#6--add--end
   
   LET g_sql = "DELETE FROM glaw_t",
               " WHERE ",g_wc,
               "   AND ",g_wc2,
               "   AND ",g_wc3,
               "   AND ",g_wc4
   PREPARE agli110_02_pre FROM g_sql   
   EXECUTE agli110_02_pre
            
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "g_glaw"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET g_success = 'N'                 
   ELSE
      LET g_success = 'Y'           
   END IF
END FUNCTION

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp510_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-08-24 15:29:38), PR版次:0002(2015-09-10 15:08:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: azzp510_02
#+ Description: 步驟二選定表格
#+ Creator....: 00845(2015-08-20 13:20:50)
#+ Modifier...: 02667 -SD/PR- 02667
 
{</section>}
 
{<section id="azzp510_02.global" >}
#應用 c03c 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../azz/4gl/azzp510.inc"
#end add-point
 
DEFINE g_rec_b            LIKE type_t.num10  
DEFINE g_wc_m             STRING
DEFINE g_wc               STRING 
DEFINE g_ref_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
    
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point       
 
{</section>}
 
{<section id="azzp510_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzp510_02(--)
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
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzp510_02 WITH FORM cl_ap_formpath("azz","azzp510_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc_m ON l_dzea001 
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.head.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.head.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #輸入開始
      CONSTRUCT g_wc ON l_chk2,dzea001,gzza001,gzde001 
           FROM s_detail2[1].l_chk2,s_detail2[1].dzea001,s_detail2[1].gzza001,s_detail2[1].gzde001 
         
         #自訂ACTION
         #add-point:自訂ACTION name="construct.action"
         
         #end add-point
         
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.body.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.body.after_construct"
            
            #end add-point
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
           
            
      END CONSTRUCT
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_azzp510_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzp510_02.other_dialog" readonly="Y" >}

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
DIALOG azzp510_02_construct()
   
   CONSTRUCT gs_step2_wc ON dzea001 FROM l_dzea001
   
      ON ACTION controlp INFIELD l_dzea001
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_dzea001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO l_dzea001  #顯示到畫面上
         NEXT FIELD l_dzea001 
   
   END CONSTRUCT
END DIALOG

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
DIALOG azzp510_02_display_array()
   INPUT ARRAY g_step02 FROM s_detail2.*
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="azzp510_02.other_function" readonly="Y" >}

 
{</section>}
 

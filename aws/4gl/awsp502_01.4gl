#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp502_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-06-07 17:31:11), PR版次:0001(2016-06-14 15:43:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: awsp502_01
#+ Description: 料件圖文檔列表
#+ Creator....: 07556(2016-06-02 17:39:18)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsp502_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_imaa_d        RECORD
       sel LIKE type_t.chr1, 
   flag LIKE type_t.chr1, 
   imaa001 LIKE type_t.chr500, 
   itemversion LIKE type_t.chr10, 
   classname LIKE type_t.chr500, 
   classification LIKE type_t.chr500, 
   id LIKE type_t.chr500, 
   version LIKE type_t.chr10, 
   status LIKE type_t.chr10, 
   name LIKE type_t.chr500, 
   filename LIKE type_t.chr500, 
   filepath LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_imaa_d          DYNAMIC ARRAY OF type_g_imaa_d
DEFINE g_imaa_d_t        type_g_imaa_d
 
 
DEFINE g_imaa001_t   LIKE imaa_t.imaa001    #Key值備份
 
 
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
 
{<section id="awsp502_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION awsp502_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   ls_js
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
   DEFINE ls_js           STRING
   DEFINE lc_param        RECORD
		    item            LIKE type_t.num10,
		    itemCode        STRING,      #料件品號
		    itemVersion     STRING,      #料件版本
		    end2classname   STRING,      #關聯圖文檔對象的類名
		    classification  STRING,      #分類
		    id              STRING,      #編號
		    version         STRING,      #版本
		    status          STRING,      #狀態
		    name            STRING,      #名稱
		    filename        STRING,      #文件名
		    filepath        STRING       #文件路径
                          END RECORD 
   DEFINE li_arr_curr     INTEGER
   DEFINE li_index        INTEGER
   DEFINE li_cnt          INTEGER
   DEFINE l_filename	     STRING
   DEFINE l_filepath		  STRING
   DEFINE l_dstf		     STRING
   DEFINE lo_curr_window  ui.Window
   DEFINE lo_curr_form    ui.Form
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_awsp502_01 WITH FORM cl_ap_formpath("aws","awsp502_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   #CALL cl_set_act_visible("btn_download", TRUE)
   #CALL cl_set_act_visible("btn_open", FALSE)
   CALL awsp502_01_b_fill(ls_js)
   
   
   LET lo_curr_window = ui.Window.getCurrent()
   LET lo_curr_form   = lo_curr_window.getForm()
   
   CALL lo_curr_form.setElementHidden("accept",TRUE)
   CALL lo_curr_form.setElementHidden("cancel",TRUE)
   
   CALL cl_set_act_visible("btn_download", TRUE)
   CALL cl_set_act_visible("btn_open", TRUE)   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_imaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(detail_input)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_open
            LET g_action_choice="btn_open"
            IF cl_auth_chk_act("btn_open") THEN
               
               #add-point:ON ACTION btn_open name="input.detail_input.page1.btn_open"
               #計算是否有選取資料    
               LET li_cnt = 0
               FOR li_index =1 TO g_imaa_d.getLength()
                  IF g_imaa_d[li_index].flag = 'Y' THEN
                     LET li_cnt = li_cnt + 1
                  END IF
               END FOR
               IF li_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00343'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()  
                  CONTINUE DIALOG
               ELSE
                  LET li_arr_curr = ARR_CURR()                
                  LET l_filename = g_imaa_d[li_arr_curr].filename
                  LET l_filepath = g_imaa_d[li_arr_curr].filepath  
                  LET l_dstf = "C:\\windows\\temp\\tiptop"
                  CALL s_aws_plm_figure_open(l_filename,l_dstf)
               END IF
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_download
            LET g_action_choice="btn_download"
            IF cl_auth_chk_act("btn_download") THEN
               
               #add-point:ON ACTION btn_download name="input.detail_input.page1.btn_download"
               #計算是否有選取資料    
               LET li_cnt = 0
               FOR li_index =1 TO g_imaa_d.getLength()
                  IF g_imaa_d[li_index].sel = 'Y' THEN
                     LET li_cnt = li_cnt + 1
                  END IF
               END FOR
               IF li_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00343'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()  
                  CONTINUE DIALOG
               ELSE
                  LET li_arr_curr = ARR_CURR()                
                  LET l_filename = g_imaa_d[li_arr_curr].filename
                  LET l_filepath = g_imaa_d[li_arr_curr].filepath
                  LET g_imaa_d[li_arr_curr].flag = 'Y'
                  
                  CALL cl_set_act_visible("btn_download", FALSE)
                  CALL cl_set_act_visible("btn_open", TRUE)
                  LET l_dstf = "C:\\windows\\temp\\tiptop"
                  CALL s_aws_plm_figure_download(l_filename,l_filepath,l_dstf)
                  CALL s_aws_plm_figure_open(l_filename,l_dstf)
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            LET li_arr_curr = ARR_CURR()        
            IF g_imaa_d[li_arr_curr].flag = 'Y' THEN
               CALL cl_set_act_visible("btn_download", FALSE)
               CALL cl_set_act_visible("btn_open", TRUE)
            ELSE
               CALL cl_set_act_visible("btn_download", TRUE)
               CALL cl_set_act_visible("btn_open", FALSE)
            END IF           
            FOR li_index = 1 TO g_imaa_d.getLength()        
               IF (li_index <> li_arr_curr) THEN
                 LET g_imaa_d[li_index].sel = "N"
               END IF 
            END FOR    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         ON ROW CHANGE
            LET li_arr_curr = ARR_CURR()            
            IF g_imaa_d[li_arr_curr].flag = 'Y' THEN
               CALL cl_set_act_visible("btn_download", FALSE)
               CALL cl_set_act_visible("btn_open", TRUE)
            ELSE
               CALL cl_set_act_visible("btn_download", TRUE)
               CALL cl_set_act_visible("btn_open", FALSE)
            END IF
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
 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_awsp502_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="awsp502_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="awsp502_01.other_function" readonly="Y" >}

# 料件圖文檔列表
PRIVATE FUNCTION awsp502_01_b_fill(ls_js)
  
   DEFINE ls_js           STRING
   DEFINE lc_param        DYNAMIC ARRAY OF RECORD
		    itemCode        STRING,      #料件品號
		    itemVersion     STRING,      #料件版本
		    end2classname   STRING,      #關聯圖文檔對象的類名
		    classification  STRING,      #分類
		    id              STRING,      #編號
		    version         STRING,      #版本
		    status          STRING,      #狀態
		    name            STRING,      #名稱
		    filename        STRING,      #文件名
		    filepath        STRING,      #文件路径
		    url             STRING       #URL路径
                          END RECORD 
   DEFINE l_sql           STRING
   DEFINE l_ac            LIKE type_t.num5   
   DEFINE l_i             LIKE type_t.num5
      
   CALL g_imaa_d.clear()
   LET l_ac = 1
   CALL util.JSON.parse(ls_js,lc_param)
   
   FOR l_i = 1 TO lc_param.getLength()
       LET g_imaa_d[l_i].flag            = 'N'
       LET g_imaa_d[l_i].imaa001         = lc_param[l_i].itemCode
       LET g_imaa_d[l_i].itemversion     = lc_param[l_i].itemVersion  
       LET g_imaa_d[l_i].classname       = lc_param[l_i].end2classname
       LET g_imaa_d[l_i].classification  = lc_param[l_i].classification
       LET g_imaa_d[l_i].id              = lc_param[l_i].id
       LET g_imaa_d[l_i].version         = lc_param[l_i].version
       LET g_imaa_d[l_i].status          = lc_param[l_i].status
       LET g_imaa_d[l_i].name            = lc_param[l_i].name
       LET g_imaa_d[l_i].filename        = lc_param[l_i].filename          
       LET g_imaa_d[l_i].filepath        = lc_param[l_i].filepath   #filepath 回傳不一定有此tag或為空值
              
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOR
      END IF
   END FOR   
 
   #CALL g_imaa_d.deleteElement(g_imaa_d.getLength())  #刪除一行
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   
END FUNCTION

 
{</section>}
 

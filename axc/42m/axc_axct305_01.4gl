#該程式已解開Section, 不再透過樣板產出!
{<section id="axct305_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000007
#+ 
#+ Filename...: axct305_01
#+ Description: axct306匯出格式
#+ Creator....: 00537(2014/09/10)
#+ Modifier...: 00537(2014/09/10) -SD/PR- 00537
#+ Buildtype..: 應用 i02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axct305_01.global" >}

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xcdb_d RECORD
       xcdbent LIKE xcdb_t.xcdbent, 
   xcdbcomp LIKE xcdb_t.xcdbcomp, 
   xcdbld LIKE xcdb_t.xcdbld,  
   xcdb004 LIKE xcdb_t.xcdb004, 
   xcdb005 LIKE xcdb_t.xcdb005, 
   xcdb003 LIKE xcdb_t.xcdb003, 
   xcdb006 LIKE xcdb_t.xcdb006,   
   xcdb007 LIKE xcdb_t.xcdb007, 
   xcdb008 LIKE xcdb_t.xcdb008,
   xcdb009 LIKE xcdb_t.xcdb009,
   xcdb011 LIKE xcdb_t.xcdb011,   
   xcdb010 LIKE xcdb_t.xcdb010, 
   xcdb002 LIKE xcdb_t.xcdb002, 
   xcdb101 LIKE xcdb_t.xcdb101, 
   xcdb102 LIKE xcdb_t.xcdb102,
   xcdb102_2 LIKE xcdb_t.xcdb102,
   xcdb102_3 LIKE xcdb_t.xcdb102
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_xcdb_d          DYNAMIC ARRAY OF type_g_xcdb_d #單身變數
DEFINE g_xcdb_d_t        type_g_xcdb_d                  #單身備份
DEFINE g_xcdb_d_o        type_g_xcdb_d                  #單身備份
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_master             RECORD 
                            name    LIKE type_t.chr100,
                            dir     LIKE type_t.chr1000
                            END RECORD
DEFINE  g_hidden        DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_ifchar        DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_mask          DYNAMIC ARRAY OF LIKE type_t.chr1,
        g_quote         STRING
DEFINE xls_name        STRING 
DEFINE  l_channel       base.Channel,
        l_str           STRING,
        l_cmd           STRING,
        l_field_name    STRING,
        cnt_table       LIKE type_t.num10
DEFINE  g_sheet         STRING 
DEFINE  ms_codeset      STRING
DEFINE  ms_locale       STRING
DEFINE  tsconv_cmd      STRING
DEFINE  l_win_name      STRING,              
        cnt_header      LIKE type_t.num10
DEFINE  g_sort          RECORD
         column         LIKE type_t.num5,    #sortColumn
         type           STRING,                 #sortType:排序方式:asc/desc
         name           STRING                  #欄位代號
                        END RECORD
DEFINE g_bufstr         base.StringBuffer      

DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axct305_01.main" >}
#+ 此段落由子樣板a27產生
#+ 資料輸入
PUBLIC FUNCTION axct305_01(--)
   #add-point:main段變數傳入
   
   #end add-point
   )
   #add-point:main段define
   
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcdbent,xcdbcomp,xcdbld,xcdb001,xcdb004,xcdb005,xcdb003,xcdb006,xcdj007, 
       xcdj008,xcdj013,xcdj009,xcdb010,xcdb007,xcdb008,xcdj016,xcdj017,xcdb009,xcdj020,xcdb002,xcdb101, 
       xcdb102 FROM xcdb_t WHERE xcdbent=? AND xcdbld=? AND xcdb001=? AND xcdb002=? AND xcdb003=? AND  
       xcdb004=? AND xcdb005=? AND xcdb006=? AND xcdj007=? AND xcdj008=? AND xcdj009=? AND xcdb010=?  
       FOR UPDATE"
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct305_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct305_01 WITH FORM cl_ap_formpath("axc","axct305_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL axct305_01_init()   
 
   #進入選單 Menu (="N")
   CALL axct305_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_axct305_01
 
   
   
 
   #add-point:離開前
   LET INT_FLAG = FALSE
   LET g_action_choice= ''
   #end add-point
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct305_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axct305_01_init()
   #add-point:init段define
   
   #end add-point   
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   CALL axct305_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axct305_01_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE ls_str          STRING
   DEFINE l_chr           LIKE type_t.chr1   
   DEFINE l_chr1          LIKE type_t.chr1  
   DEFINE l_num           LIKE type_t.num5
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      CALL axct305_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xcdb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
   CALL axct305_01_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array
         #輸入開始
         INPUT BY NAME g_master.name,g_master.dir
            BEFORE INPUT
              
         
         
            AFTER INPUT
               
         
         END INPUT
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before

            #end add-point
            NEXT FIELD CURRENT
      
         
         #+ 此段落由子樣板a43產生
         ON ACTION off
            LET g_action_choice="off"
            IF cl_auth_chk_act("off") THEN
               
               #add-point:ON ACTION off
               LET INT_FLAG=FALSE         
               LET g_action_choice="exit"
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION produce
            LET g_action_choice="produce"
            IF cl_auth_chk_act("produce") THEN
               
               #add-point:ON ACTION produce
               LET w = ui.Window.getCurrent()
               LET f = w.getForm()
               LET page = f.FindNode("Page","page_1")
               CALL axct305_01_excelexample(page,base.TypeInfo.create(g_xcdb_d),'Y')
               ACCEPT DIALOG 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION browser1
            LET g_action_choice="browser1"
            IF cl_auth_chk_act("browser1") THEN
               
               #add-point:ON ACTION browser1
               CALL cl_client_browse_dir() RETURNING g_master.dir
               LET ls_str = g_master.dir
               #抓取目录斜杆
               LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
               LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
               LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
               IF l_chr <> l_chr1  THEN         
                  LET g_master.dir = g_master.dir||l_chr 
               ELSE
                  LET g_master.dir = g_master.dir 
               END IF 
               DISPLAY BY NAME g_master.dir
               #END add-point
#               EXIT DIALOG
            END IF
 
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
            
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axct305_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct305_01_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct305_01_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct305_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
#   LET INT_FLAG = 0
#   CLEAR FORM
#   CALL g_xcdb_d.clear()
#   
#   LET g_qryparam.state = "c"
#   
#   #wc備份
#   LET ls_wc = g_wc2
#   
#   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
# 
#      CONSTRUCT g_wc2 ON xcdbent,xcdbcomp,xcdbld,xcdb001,xcdb004,xcdb005,xcdb003,xcdb006,xcdj007,xcdj008, 
#          xcdj013,xcdj009,xcdb010,xcdb007,xcdb008,xcdj016,xcdj017,xcdb009,xcdj020,xcdb002,xcdb101,xcdb102  
#
# 
#         FROM s_detail1[1].xcdbent,s_detail1[1].xcdbcomp,s_detail1[1].xcdbld,s_detail1[1].xcdb001,s_detail1[1].xcdb004, 
#             s_detail1[1].xcdb005,s_detail1[1].xcdb003,s_detail1[1].xcdb006,s_detail1[1].xcdj007,s_detail1[1].xcdj008, 
#             s_detail1[1].xcdj013,s_detail1[1].xcdj009,s_detail1[1].xcdb010,s_detail1[1].xcdb007,s_detail1[1].xcdb008, 
#             s_detail1[1].xcdj016,s_detail1[1].xcdj017,s_detail1[1].xcdb009,s_detail1[1].xcdj020,s_detail1[1].xcdb002, 
#             s_detail1[1].xcdb101,s_detail1[1].xcdb102 
#      
#         
#      
#                  #此段落由子樣板a01產生
#         BEFORE FIELD xcdbent
#            #add-point:BEFORE FIELD xcdbent

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbent
#            
#            #add-point:AFTER FIELD xcdbent

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdbent
#         ON ACTION controlp INFIELD xcdbent
#            #add-point:ON ACTION controlp INFIELD xcdbent

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdbcomp
#            #add-point:BEFORE FIELD xcdbcomp

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbcomp
#            
#            #add-point:AFTER FIELD xcdbcomp

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdbcomp
#         ON ACTION controlp INFIELD xcdbcomp
#            #add-point:ON ACTION controlp INFIELD xcdbcomp

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdbld
#            #add-point:BEFORE FIELD xcdbld

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbld
#            
#            #add-point:AFTER FIELD xcdbld

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdbld
#         ON ACTION controlp INFIELD xcdbld
#            #add-point:ON ACTION controlp INFIELD xcdbld

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb001
#            #add-point:BEFORE FIELD xcdb001

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb001
#            
#            #add-point:AFTER FIELD xcdb001

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb001
#         ON ACTION controlp INFIELD xcdb001
#            #add-point:ON ACTION controlp INFIELD xcdb001

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb004
#            #add-point:BEFORE FIELD xcdb004

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb004
#            
#            #add-point:AFTER FIELD xcdb004

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb004
#         ON ACTION controlp INFIELD xcdb004
#            #add-point:ON ACTION controlp INFIELD xcdb004

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb005
#            #add-point:BEFORE FIELD xcdb005

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb005
#            
#            #add-point:AFTER FIELD xcdb005

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb005
#         ON ACTION controlp INFIELD xcdb005
#            #add-point:ON ACTION controlp INFIELD xcdb005

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb003
#            #add-point:BEFORE FIELD xcdb003

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb003
#            
#            #add-point:AFTER FIELD xcdb003

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb003
#         ON ACTION controlp INFIELD xcdb003
#            #add-point:ON ACTION controlp INFIELD xcdb003

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb006
#            #add-point:BEFORE FIELD xcdb006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb006
#            
#            #add-point:AFTER FIELD xcdb006

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb006
#         ON ACTION controlp INFIELD xcdb006
#            #add-point:ON ACTION controlp INFIELD xcdb006

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj007
#            #add-point:BEFORE FIELD xcdj007

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj007
#            
#            #add-point:AFTER FIELD xcdj007

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdj007
#         ON ACTION controlp INFIELD xcdj007
#            #add-point:ON ACTION controlp INFIELD xcdj007

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj008
#            #add-point:BEFORE FIELD xcdj008

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj008
#            
#            #add-point:AFTER FIELD xcdj008

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdj008
#         ON ACTION controlp INFIELD xcdj008
#            #add-point:ON ACTION controlp INFIELD xcdj008

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj013
#            #add-point:BEFORE FIELD xcdj013

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj013
#            
#            #add-point:AFTER FIELD xcdj013

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdj013
#         ON ACTION controlp INFIELD xcdj013
#            #add-point:ON ACTION controlp INFIELD xcdj013

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj009
#            #add-point:BEFORE FIELD xcdj009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj009
#            
#            #add-point:AFTER FIELD xcdj009

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdj009
#         ON ACTION controlp INFIELD xcdj009
#            #add-point:ON ACTION controlp INFIELD xcdj009

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb010
#            #add-point:BEFORE FIELD xcdb010

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb010
#            
#            #add-point:AFTER FIELD xcdb010

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb010
#         ON ACTION controlp INFIELD xcdb010
#            #add-point:ON ACTION controlp INFIELD xcdb010

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb007
#            #add-point:BEFORE FIELD xcdb007

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb007
#            
#            #add-point:AFTER FIELD xcdb007

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb007
#         ON ACTION controlp INFIELD xcdb007
#            #add-point:ON ACTION controlp INFIELD xcdb007

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb008
#            #add-point:BEFORE FIELD xcdb008

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb008
#            
#            #add-point:AFTER FIELD xcdb008

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb008
#         ON ACTION controlp INFIELD xcdb008
#            #add-point:ON ACTION controlp INFIELD xcdb008

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj016
#            #add-point:BEFORE FIELD xcdj016

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj016
#            
#            #add-point:AFTER FIELD xcdj016

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdj016
##         ON ACTION controlp INFIELD xcdj016
##            #add-point:ON ACTION controlp INFIELD xcdj016

##            #END add-point
## 
##         #此段落由子樣板a01產生
##         BEFORE FIELD xcdj017
##            #add-point:BEFORE FIELD xcdj017

##            #END add-point
## 
##         #此段落由子樣板a02產生
##         AFTER FIELD xcdj017
##            
##            #add-point:AFTER FIELD xcdj017

##            #END add-point
##            
## 
##         #Ctrlp:query.c.page1.xcdj017
##         ON ACTION controlp INFIELD xcdj017
#            #add-point:ON ACTION controlp INFIELD xcdj017

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb009
#            #add-point:BEFORE FIELD xcdb009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb009
#            
#            #add-point:AFTER FIELD xcdb009

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb009
#         ON ACTION controlp INFIELD xcdb009
#            #add-point:ON ACTION controlp INFIELD xcdb009

#            #END add-point
# 
#         #此段落由子樣板a01產生
##         BEFORE FIELD xcdj020
##            #add-point:BEFORE FIELD xcdj020

##            #END add-point
## 
##         #此段落由子樣板a02產生
##         AFTER FIELD xcdj020
##            
##            #add-point:AFTER FIELD xcdj020

##            #END add-point
##            
## 
##         #Ctrlp:query.c.page1.xcdj020
##         ON ACTION controlp INFIELD xcdj020
##            #add-point:ON ACTION controlp INFIELD xcdj020

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb002
#            #add-point:BEFORE FIELD xcdb002

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb002
#            
#            #add-point:AFTER FIELD xcdb002

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb002
#         ON ACTION controlp INFIELD xcdb002
#            #add-point:ON ACTION controlp INFIELD xcdb002

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb101
#            #add-point:BEFORE FIELD xcdb101

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb101
#            
#            #add-point:AFTER FIELD xcdb101

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb101
#         ON ACTION controlp INFIELD xcdb101
#            #add-point:ON ACTION controlp INFIELD xcdb101

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb102
#            #add-point:BEFORE FIELD xcdb102

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb102
#            
#            #add-point:AFTER FIELD xcdb102

#            #END add-point
#            
# 
#         #Ctrlp:query.c.page1.xcdb102
#         ON ACTION controlp INFIELD xcdb102
#            #add-point:ON ACTION controlp INFIELD xcdb102

#            #END add-point
# 
#  
#         
# 
#      
#         BEFORE CONSTRUCT
#            #add-point:cs段more_construct

#            #end add-point 
#      
#      END CONSTRUCT
  
      #add-point:query段more_construct

      #end add-point 
  
#      BEFORE DIALOG 
#         CALL cl_qbe_init()
#         #add-point:query段before_dialog

#         #end add-point 
#      
#      ON ACTION qbe_select
#         LET ls_wc = ""
#         CALL cl_qbe_list("c") RETURNING ls_wc
#      
#      ON ACTION qbe_save
#         CALL cl_qbe_save()
#      
#      ON ACTION accept
#         ACCEPT DIALOG
#         
#      ON ACTION cancel
#         LET INT_FLAG = 1
#         EXIT DIALOG
#      
#      #交談指令共用ACTION
#      &include "common_action.4gl"
#      CONTINUE DIALOG 
#   END DIALOG
# 
#   #add-point:query段after_construct

#   #end add-point
# 
#   IF INT_FLAG THEN
#      LET INT_FLAG = 0
#      #還原
#      LET g_wc2 = ls_wc
#   ELSE
#      LET g_error_show = 1
#      LET g_detail_idx = 1
#   END IF
#    
#   CALL axct305_01_b_fill(g_wc2)
#   
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = -100 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#   END IF
#   
#   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct305_01_insert()
   #add-point:delete段define
   
   #end add-point                
    
   #add-point:單身新增前
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL axct305_01_modify()
            
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct305_01_modify()
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num5
   DEFINE  l_i                    LIKE type_t.num5
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num5
   DEFINE  li_reproduce_target    LIKE type_t.num5
   DEFINE  lb_reproduce           BOOLEAN
   #add-point:modify段define

   #end add-point 
   
#   LET g_action_choice = ""
#   
#   LET g_qryparam.state = "i"
# 
#   LET l_allow_insert = cl_auth_detail_input("insert")
#   LET l_allow_delete = cl_auth_detail_input("delete")
#   
#   #add-point:modify開始前

#   #end add-point
#   
#   LET INT_FLAG = FALSE
#   LET lb_reproduce = FALSE
# 
#   #add-point:modify段修改前

#   #end add-point
# 
#   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
# 
#      #Page1 預設值產生於此處
#      INPUT ARRAY g_xcdb_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
#                  INSERT ROW = l_allow_insert, 
#                  DELETE ROW = l_allow_delete,
#                  APPEND ROW = l_allow_insert)
# 
#         #自訂ACTION(detail_input,page_1)
#         
#         
#         BEFORE INPUT
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_xcdb_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL axct305_01_b_fill(g_wc2)
#            LET g_detail_cnt = g_xcdb_d.getLength()
#         
#         BEFORE ROW
#            #add-point:modify段before row
#
#            #end add-point  
#            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#            LET l_cmd = ''
#            LET l_ac = g_detail_idx
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#            DISPLAY g_xcdb_d.getLength() TO FORMONLY.cnt
#         
#            CALL s_transaction_begin()
#            LET g_detail_cnt = g_xcdb_d.getLength()
#            
#            IF g_detail_cnt >= l_ac 
#               AND g_xcdb_d[l_ac].xcdbld IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb001 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb002 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb003 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb004 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb005 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb006 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdj007 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdj008 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdj009 IS NOT NULL
#               AND g_xcdb_d[l_ac].xcdb010 IS NOT NULL
# 
#            THEN
#               LET l_cmd='u'
#               LET g_xcdb_d_t.* = g_xcdb_d[l_ac].*  #BACKUP
#               LET g_xcdb_d_o.* = g_xcdb_d[l_ac].*  #BACKUP
#               IF NOT axct305_01_lock_b("xcdb_t") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH axct305_01_bcl INTO g_xcdb_d[l_ac].xcdbent,g_xcdb_d[l_ac].xcdbcomp,g_xcdb_d[l_ac].xcdbld, 
#                      g_xcdb_d[l_ac].xcdb001,g_xcdb_d[l_ac].xcdb004,g_xcdb_d[l_ac].xcdb005,g_xcdb_d[l_ac].xcdb003, 
#                      g_xcdb_d[l_ac].xcdb006,g_xcdb_d[l_ac].xcdj007,g_xcdb_d[l_ac].xcdj008,g_xcdb_d[l_ac].xcdj013, 
#                      g_xcdb_d[l_ac].xcdj009,g_xcdb_d[l_ac].xcdb010,g_xcdb_d[l_ac].xcdb007,g_xcdb_d[l_ac].xcdb008, 
#                      g_xcdb_d[l_ac].xcdj016,g_xcdb_d[l_ac].xcdj017,g_xcdb_d[l_ac].xcdb009,g_xcdb_d[l_ac].xcdj020, 
#                      g_xcdb_d[l_ac].xcdb002,g_xcdb_d[l_ac].xcdb101,g_xcdb_d[l_ac].xcdb102
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_xcdb_d_t.xcdbld 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  CALL axct305_01_detail_show()
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            #add-point:modify段before row
#
#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            
#            #其他table進行lock
#            
#        
#         BEFORE INSERT
#            
#            CALL s_transaction_begin()
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_xcdb_d_t.* TO NULL
#            INITIALIZE g_xcdb_d_o.* TO NULL
#            INITIALIZE g_xcdb_d[l_ac].* TO NULL 
#            #公用欄位給值(單身)
#            
#            #自定義預設值(單身1)
#            
#            #add-point:modify段before備份
#
#            #end add-point
#            LET g_xcdb_d_t.* = g_xcdb_d[l_ac].*     #新輸入資料
#            LET g_xcdb_d_o.* = g_xcdb_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL axct305_01_set_entry_b("a")
#            CALL axct305_01_set_no_entry_b("a")
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_xcdb_d[li_reproduce_target].* = g_xcdb_d[li_reproduce].*
# 
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdbld = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb001 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb002 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb003 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb004 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb005 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb006 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdj007 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdj008 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdj009 = NULL
#               LET g_xcdb_d[g_xcdb_d.getLength()].xcdb010 = NULL
# 
#            END IF
            
            #add-point:modify段before insert

            #end add-point  
  
#         AFTER INSERT
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM xcdb_t 
#             WHERE xcdbent = g_enterprise AND xcdbld = g_xcdb_d[l_ac].xcdbld
#                                       AND xcdb001 = g_xcdb_d[l_ac].xcdb001
#                                       AND xcdb002 = g_xcdb_d[l_ac].xcdb002
#                                       AND xcdb003 = g_xcdb_d[l_ac].xcdb003
#                                       AND xcdb004 = g_xcdb_d[l_ac].xcdb004
#                                       AND xcdb005 = g_xcdb_d[l_ac].xcdb005
#                                       AND xcdb006 = g_xcdb_d[l_ac].xcdb006
#                                       AND xcdj007 = g_xcdb_d[l_ac].xcdj007
#                                       AND xcdj008 = g_xcdb_d[l_ac].xcdj008
#                                       AND xcdj009 = g_xcdb_d[l_ac].xcdj009
#                                       AND xcdb010 = g_xcdb_d[l_ac].xcdb010
# 
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身新增前

#               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xcdb_d[g_detail_idx].xcdbld
#               LET gs_keys[2] = g_xcdb_d[g_detail_idx].xcdb001
#               LET gs_keys[3] = g_xcdb_d[g_detail_idx].xcdb002
#               LET gs_keys[4] = g_xcdb_d[g_detail_idx].xcdb003
#               LET gs_keys[5] = g_xcdb_d[g_detail_idx].xcdb004
#               LET gs_keys[6] = g_xcdb_d[g_detail_idx].xcdb005
#               LET gs_keys[7] = g_xcdb_d[g_detail_idx].xcdb006
#               LET gs_keys[8] = g_xcdb_d[g_detail_idx].xcdj007
#               LET gs_keys[9] = g_xcdb_d[g_detail_idx].xcdj008
#               LET gs_keys[10] = g_xcdb_d[g_detail_idx].xcdj009
#               LET gs_keys[11] = g_xcdb_d[g_detail_idx].xcdb010
#               CALL axct305_01_insert_b('xcdb_t',gs_keys,"'1'")
#                           
#               #add-point:單身新增後

#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               INITIALIZE g_xcdb_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcdb_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL axct305_01_b_fill(g_wc2)
#               #資料多語言用-增/改
#               
#               #add-point:input段-after_insert

#               #end add-point
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_detail_cnt = g_detail_cnt + 1
#               
#               LET g_wc2 = g_wc2, " OR (xcdbld = '", g_xcdb_d[l_ac].xcdbld, "' "
#                                  ," AND xcdb001 = '", g_xcdb_d[l_ac].xcdb001, "' "
#                                  ," AND xcdb002 = '", g_xcdb_d[l_ac].xcdb002, "' "
#                                  ," AND xcdb003 = '", g_xcdb_d[l_ac].xcdb003, "' "
#                                  ," AND xcdb004 = '", g_xcdb_d[l_ac].xcdb004, "' "
#                                  ," AND xcdb005 = '", g_xcdb_d[l_ac].xcdb005, "' "
#                                  ," AND xcdb006 = '", g_xcdb_d[l_ac].xcdb006, "' "
#                                  ," AND xcdj007 = '", g_xcdb_d[l_ac].xcdj007, "' "
#                                  ," AND xcdj008 = '", g_xcdb_d[l_ac].xcdj008, "' "
#                                  ," AND xcdj009 = '", g_xcdb_d[l_ac].xcdj009, "' "
#                                  ," AND xcdb010 = '", g_xcdb_d[l_ac].xcdb010, "' "
# 
#                                  ,")"
#            END IF                
#              
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               #add-point:單身刪除ask前

#               #end add-point   
#               
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身刪除前

#               #end add-point   
#               
#               DELETE FROM xcdb_t
#                WHERE xcdbent = g_enterprise AND 
#                      xcdbld = g_xcdb_d_t.xcdbld
#                      AND xcdb001 = g_xcdb_d_t.xcdb001
#                      AND xcdb002 = g_xcdb_d_t.xcdb002
#                      AND xcdb003 = g_xcdb_d_t.xcdb003
#                      AND xcdb004 = g_xcdb_d_t.xcdb004
#                      AND xcdb005 = g_xcdb_d_t.xcdb005
#                      AND xcdb006 = g_xcdb_d_t.xcdb006
#                      AND xcdj007 = g_xcdb_d_t.xcdj007
#                      AND xcdj008 = g_xcdb_d_t.xcdj008
#                      AND xcdj009 = g_xcdb_d_t.xcdj009
#                      AND xcdb010 = g_xcdb_d_t.xcdb010
# 
#                      
#               #add-point:單身刪除中

#               #end add-point  
#                      
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "xcdb_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_detail_cnt = g_detail_cnt-1
#                  
#                  #add-point:單身刪除後

#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE axct305_01_bcl
#               LET l_count = g_xcdb_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xcdb_d[g_detail_idx].xcdbld
#               LET gs_keys[2] = g_xcdb_d[g_detail_idx].xcdb001
#               LET gs_keys[3] = g_xcdb_d[g_detail_idx].xcdb002
#               LET gs_keys[4] = g_xcdb_d[g_detail_idx].xcdb003
#               LET gs_keys[5] = g_xcdb_d[g_detail_idx].xcdb004
#               LET gs_keys[6] = g_xcdb_d[g_detail_idx].xcdb005
#               LET gs_keys[7] = g_xcdb_d[g_detail_idx].xcdb006
#               LET gs_keys[8] = g_xcdb_d[g_detail_idx].xcdj007
#               LET gs_keys[9] = g_xcdb_d[g_detail_idx].xcdj008
#               LET gs_keys[10] = g_xcdb_d[g_detail_idx].xcdj009
#               LET gs_keys[11] = g_xcdb_d[g_detail_idx].xcdb010
# 
#               #+ 此段落由子樣板a47產生
#      #刪除相關文件
#      CALL axct305_01_set_pk_array()
#      #add-point:相關文件刪除前

#      #end add-point   
#      CALL cl_doc_remove()  
# 
# 
#            END IF 
#              
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身刪除後2

#               #end add-point
#                              CALL axct305_01_delete_b('xcdb_t',gs_keys,"'1'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_xcdb_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
#                  #此段落由子樣板a01產生
#         BEFORE FIELD xcdbent
#            #add-point:BEFORE FIELD xcdbent

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbent
#            
#            #add-point:AFTER FIELD xcdbent

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdbent
#            #add-point:ON CHANGE xcdbent

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdbcomp
#            #add-point:BEFORE FIELD xcdbcomp

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbcomp
#            
#            #add-point:AFTER FIELD xcdbcomp

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdbcomp
#            #add-point:ON CHANGE xcdbcomp

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdbld
#            #add-point:BEFORE FIELD xcdbld

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdbld
#            
#            #add-point:AFTER FIELD xcdbld
            #此段落由子樣板a05產生



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdbld
#            #add-point:ON CHANGE xcdbld

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb001
#            #add-point:BEFORE FIELD xcdb001

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb001
#            
#            #add-point:AFTER FIELD xcdb001
            #此段落由子樣板a05產生
            #確認資料無重複



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb001
#            #add-point:ON CHANGE xcdb001

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb004
#            #add-point:BEFORE FIELD xcdb004

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb004
#            
#            #add-point:AFTER FIELD xcdb004
            #此段落由子樣板a05產生
            #確認資料無重複


#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb004
#            #add-point:ON CHANGE xcdb004

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb005
#            #add-point:BEFORE FIELD xcdb005

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb005
#            
#            #add-point:AFTER FIELD xcdb005
            #此段落由子樣板a05產生
            #確認資料無重複



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb005
#            #add-point:ON CHANGE xcdb005

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb003
#            #add-point:BEFORE FIELD xcdb003

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb003
#            
#            #add-point:AFTER FIELD xcdb003
            #此段落由子樣板a05產生



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb003
#            #add-point:ON CHANGE xcdb003

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb006
#            #add-point:BEFORE FIELD xcdb006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb006
#            
#            #add-point:AFTER FIELD xcdb006
            #此段落由子樣板a05產生


#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb006
#            #add-point:ON CHANGE xcdb006

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj007
#            #add-point:BEFORE FIELD xcdj007

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj007
            
            #add-point:AFTER FIELD xcdj007

            #END add-point
            
 
         #此段落由子樣板a04產生
#         ON CHANGE xcdj007
#            #add-point:ON CHANGE xcdj007

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj008
#            #add-point:BEFORE FIELD xcdj008

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj008
#            
#            #add-point:AFTER FIELD xcdj008

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdj008
#            #add-point:ON CHANGE xcdj008

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj013
#            #add-point:BEFORE FIELD xcdj013

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj013
#            
#            #add-point:AFTER FIELD xcdj013

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdj013
#            #add-point:ON CHANGE xcdj013

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj009
#            #add-point:BEFORE FIELD xcdj009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj009
#            
#            #add-point:AFTER FIELD xcdj009

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdj009
#            #add-point:ON CHANGE xcdj009

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb010
#            #add-point:BEFORE FIELD xcdb010

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb010
#            
#            #add-point:AFTER FIELD xcdb010
            #此段落由子樣板a05產生
            #確認資料無重複



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb010
#            #add-point:ON CHANGE xcdb010

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb007
#            #add-point:BEFORE FIELD xcdb007

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb007
#            
#            #add-point:AFTER FIELD xcdb007

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb007
#            #add-point:ON CHANGE xcdb007

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb008
#            #add-point:BEFORE FIELD xcdb008

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb008
#            
#            #add-point:AFTER FIELD xcdb008

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb008
#            #add-point:ON CHANGE xcdb008

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj016
#            #add-point:BEFORE FIELD xcdj016

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj016
#            
#            #add-point:AFTER FIELD xcdj016

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdj016
#            #add-point:ON CHANGE xcdj016

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj017
#            #add-point:BEFORE FIELD xcdj017

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj017
#            
#            #add-point:AFTER FIELD xcdj017

#            #END add-point
#            
 
         #此段落由子樣板a04產生
#         ON CHANGE xcdj017
#            #add-point:ON CHANGE xcdj017

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb009
#            #add-point:BEFORE FIELD xcdb009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb009
#            
#            #add-point:AFTER FIELD xcdb009

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb009
#            #add-point:ON CHANGE xcdb009

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdj020
#            #add-point:BEFORE FIELD xcdj020

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdj020
#            
#            #add-point:AFTER FIELD xcdj020

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdj020
#            #add-point:ON CHANGE xcdj020

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb002
#            #add-point:BEFORE FIELD xcdb002

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb002
#            
#            #add-point:AFTER FIELD xcdb002
            #此段落由子樣板a05產生



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb002
#            #add-point:ON CHANGE xcdb002

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb101
#            #add-point:BEFORE FIELD xcdb101

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb101
#            
#            #add-point:AFTER FIELD xcdb101

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb101
#            #add-point:ON CHANGE xcdb101

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcdb102
#            #add-point:BEFORE FIELD xcdb102

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcdb102
#            
#            #add-point:AFTER FIELD xcdb102

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcdb102
#            #add-point:ON CHANGE xcdb102

#            #END add-point
# 
# 
#                  #Ctrlp:input.c.page1.xcdbent
#         ON ACTION controlp INFIELD xcdbent
#            #add-point:ON ACTION controlp INFIELD xcdbent

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdbcomp
#         ON ACTION controlp INFIELD xcdbcomp
#            #add-point:ON ACTION controlp INFIELD xcdbcomp

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdbld
#         ON ACTION controlp INFIELD xcdbld
#            #add-point:ON ACTION controlp INFIELD xcdbld

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb001
#         ON ACTION controlp INFIELD xcdb001
#            #add-point:ON ACTION controlp INFIELD xcdb001

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb004
#         ON ACTION controlp INFIELD xcdb004
#            #add-point:ON ACTION controlp INFIELD xcdb004

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb005
#         ON ACTION controlp INFIELD xcdb005
#            #add-point:ON ACTION controlp INFIELD xcdb005

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb003
#         ON ACTION controlp INFIELD xcdb003
#            #add-point:ON ACTION controlp INFIELD xcdb003

            #END add-point
 
         #Ctrlp:input.c.page1.xcdb006
#         ON ACTION controlp INFIELD xcdb006
#            #add-point:ON ACTION controlp INFIELD xcdb006

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj007
#         ON ACTION controlp INFIELD xcdj007
#            #add-point:ON ACTION controlp INFIELD xcdj007

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj008
#         ON ACTION controlp INFIELD xcdj008
#            #add-point:ON ACTION controlp INFIELD xcdj008

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj013
#         ON ACTION controlp INFIELD xcdj013
#            #add-point:ON ACTION controlp INFIELD xcdj013

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj009
#         ON ACTION controlp INFIELD xcdj009
#            #add-point:ON ACTION controlp INFIELD xcdj009

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb010
#         ON ACTION controlp INFIELD xcdb010
#            #add-point:ON ACTION controlp INFIELD xcdb010

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb007
#         ON ACTION controlp INFIELD xcdb007
#            #add-point:ON ACTION controlp INFIELD xcdb007

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb008
#         ON ACTION controlp INFIELD xcdb008
#            #add-point:ON ACTION controlp INFIELD xcdb008

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj016
#         ON ACTION controlp INFIELD xcdj016
#            #add-point:ON ACTION controlp INFIELD xcdj016

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj017
#         ON ACTION controlp INFIELD xcdj017
#            #add-point:ON ACTION controlp INFIELD xcdj017

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb009
#         ON ACTION controlp INFIELD xcdb009
#            #add-point:ON ACTION controlp INFIELD xcdb009

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdj020
#         ON ACTION controlp INFIELD xcdj020
#            #add-point:ON ACTION controlp INFIELD xcdj020

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb002
#         ON ACTION controlp INFIELD xcdb002
#            #add-point:ON ACTION controlp INFIELD xcdb002

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb101
#         ON ACTION controlp INFIELD xcdb101
#            #add-point:ON ACTION controlp INFIELD xcdb101

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcdb102
#         ON ACTION controlp INFIELD xcdb102
#            #add-point:ON ACTION controlp INFIELD xcdb102

#            #END add-point
# 
# 
# 
#         ON ROW CHANGE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               LET g_xcdb_d[l_ac].* = g_xcdb_d_t.*
#               CLOSE axct305_01_bcl
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_xcdb_d[l_ac].xcdbld 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               LET g_xcdb_d[l_ac].* = g_xcdb_d_t.*
#            ELSE
#               
#               #寫入修改者/修改日期資訊(單身)
#               
#            
#               #add-point:單身修改前

#               #end add-point
#               
#               UPDATE xcdb_t SET (xcdbent,xcdbcomp,xcdbld,xcdb001,xcdb004,xcdb005,xcdb003,xcdb006,xcdj007, 
#                   xcdj008,xcdj013,xcdj009,xcdb010,xcdb007,xcdb008,xcdj016,xcdj017,xcdb009,xcdj020,xcdb002, 
#                   xcdb101,xcdb102) = (g_xcdb_d[l_ac].xcdbent,g_xcdb_d[l_ac].xcdbcomp,g_xcdb_d[l_ac].xcdbld, 
#                   g_xcdb_d[l_ac].xcdb001,g_xcdb_d[l_ac].xcdb004,g_xcdb_d[l_ac].xcdb005,g_xcdb_d[l_ac].xcdb003, 
#                   g_xcdb_d[l_ac].xcdb006,g_xcdb_d[l_ac].xcdj007,g_xcdb_d[l_ac].xcdj008,g_xcdb_d[l_ac].xcdj013, 
#                   g_xcdb_d[l_ac].xcdj009,g_xcdb_d[l_ac].xcdb010,g_xcdb_d[l_ac].xcdb007,g_xcdb_d[l_ac].xcdb008, 
#                   g_xcdb_d[l_ac].xcdj016,g_xcdb_d[l_ac].xcdj017,g_xcdb_d[l_ac].xcdb009,g_xcdb_d[l_ac].xcdj020, 
#                   g_xcdb_d[l_ac].xcdb002,g_xcdb_d[l_ac].xcdb101,g_xcdb_d[l_ac].xcdb102)
#                WHERE xcdbent = g_enterprise AND
#                  xcdbld = g_xcdb_d_t.xcdbld #項次   
#                  AND xcdb001 = g_xcdb_d_t.xcdb001  
#                  AND xcdb002 = g_xcdb_d_t.xcdb002  
#                  AND xcdb003 = g_xcdb_d_t.xcdb003  
#                  AND xcdb004 = g_xcdb_d_t.xcdb004  
#                  AND xcdb005 = g_xcdb_d_t.xcdb005  
#                  AND xcdb006 = g_xcdb_d_t.xcdb006  
#                  AND xcdj007 = g_xcdb_d_t.xcdj007  
#                  AND xcdj008 = g_xcdb_d_t.xcdj008  
#                  AND xcdj009 = g_xcdb_d_t.xcdj009  
#                  AND xcdb010 = g_xcdb_d_t.xcdb010  
# 
#                  
#               #add-point:單身修改中

#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcdb_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                    WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcdb_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xcdb_d[g_detail_idx].xcdbld
#               LET gs_keys_bak[1] = g_xcdb_d_t.xcdbld
#               LET gs_keys[2] = g_xcdb_d[g_detail_idx].xcdb001
#               LET gs_keys_bak[2] = g_xcdb_d_t.xcdb001
#               LET gs_keys[3] = g_xcdb_d[g_detail_idx].xcdb002
#               LET gs_keys_bak[3] = g_xcdb_d_t.xcdb002
#               LET gs_keys[4] = g_xcdb_d[g_detail_idx].xcdb003
#               LET gs_keys_bak[4] = g_xcdb_d_t.xcdb003
#               LET gs_keys[5] = g_xcdb_d[g_detail_idx].xcdb004
#               LET gs_keys_bak[5] = g_xcdb_d_t.xcdb004
#               LET gs_keys[6] = g_xcdb_d[g_detail_idx].xcdb005
#               LET gs_keys_bak[6] = g_xcdb_d_t.xcdb005
#               LET gs_keys[7] = g_xcdb_d[g_detail_idx].xcdb006
#               LET gs_keys_bak[7] = g_xcdb_d_t.xcdb006
#               LET gs_keys[8] = g_xcdb_d[g_detail_idx].xcdj007
#               LET gs_keys_bak[8] = g_xcdb_d_t.xcdj007
#               LET gs_keys[9] = g_xcdb_d[g_detail_idx].xcdj008
#               LET gs_keys_bak[9] = g_xcdb_d_t.xcdj008
#               LET gs_keys[10] = g_xcdb_d[g_detail_idx].xcdj009
#               LET gs_keys_bak[10] = g_xcdb_d_t.xcdj009
#               LET gs_keys[11] = g_xcdb_d[g_detail_idx].xcdb010
#               LET gs_keys_bak[11] = g_xcdb_d_t.xcdb010
#               CALL axct305_01_update_b('xcdb_t',gs_keys,gs_keys_bak,"'1'")
#                     #資料多語言用-增/改
#                     
#                     LET g_log1 = util.JSON.stringify(g_xcdb_d_t)
#                     LET g_log2 = util.JSON.stringify(g_xcdb_d[l_ac])
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                        CALL s_transaction_end('N','0')
#                     END IF
#               END CASE
#               
#               #add-point:單身修改後

#               #end add-point
# 
#            END IF
#            
#         AFTER ROW
#            CALL axct305_01_unlock_b("xcdb_t")
#            CALL s_transaction_end('Y','0')
#            #其他table進行unlock
#            
#             #add-point:單身after row

#            #end add-point
#            
#         AFTER INPUT
#            #add-point:單身input後

#            #end add-point
#            #錯誤訊息統整顯示
#            #CALL cl_err_collect_show()
#            #CALL cl_showmsg()
#            
#         ON ACTION controlo   
#            CALL FGL_SET_ARR_CURR(g_xcdb_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_xcdb_d.getLength()+1
#            
#      END INPUT
      
 
      
 
      
      #add-point:before_more_input

      #end add-point
      
#      BEFORE DIALOG
#         #CALL cl_err_collect_init()      
#         IF g_temp_idx > 0 THEN
#            LET l_ac = g_temp_idx
#            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
#            LET g_temp_idx = 1
#         END IF
#         LET g_curr_diag = ui.DIALOG.getCurrent()
#         #add-point:before_dialog

#         #end add-point
#         CASE g_aw
#            WHEN "s_detail1"
#               NEXT FIELD xcdbent
# 
#         END CASE
#   
#      ON ACTION accept
#         ACCEPT DIALOG
#      
#      ON ACTION cancel
#         LET INT_FLAG = TRUE 
#         EXIT DIALOG
# 
#      ON ACTION controlr
#         CALL cl_show_req_fields()
# 
#      ON ACTION controlf
#         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
#              RETURNING g_fld_name,g_frm_name 
#         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
#           
#      #交談指令共用ACTION
#      &include "common_action.4gl"
#         CONTINUE DIALOG
#   
#   END DIALOG 
#   
#   #add-point:modify段修改後

#   #end add-point
# 
#   CLOSE axct305_01_bcl
#   CALL s_transaction_end('Y','0')
#   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct305_01_delete()
   DEFINE li_idx          LIKE type_t.num5
   DEFINE li_ac_t         LIKE type_t.num5
   DEFINE li_detail_tmp   LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point 
   
   #add-point:單身刪除前

   #end add-point
   
#   CALL s_transaction_begin()
#   
#   LET li_ac_t = l_ac
#   
#   LET li_detail_tmp = g_detail_idx
#    
#   #lock所有所選資料
#   FOR li_idx = 1 TO g_xcdb_d.getLength()
#      LET g_detail_idx = li_idx
#      #已選擇的資料
#      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
#         #確定是否有被鎖定
#         IF NOT axct305_01_lock_b("xcdb_t") THEN
#            #已被他人鎖定
#            CALL s_transaction_end('N','0')
#            RETURN
#         END IF
#      END IF
#   END FOR
#   
#   #add-point:單身刪除詢問前

#   #end add-point  
#   
#   #詢問是否確定刪除所選資料
#   IF NOT cl_ask_del_detail() THEN
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#   
#   FOR li_idx = 1 TO g_xcdb_d.getLength()
#      IF g_xcdb_d[li_idx].xcdbld IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb001 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb002 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb003 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb004 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb005 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb006 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdj007 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdj008 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdj009 IS NOT NULL
#         AND g_xcdb_d[li_idx].xcdb010 IS NOT NULL
# 
#         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
#         
#         #add-point:單身刪除前

#         #end add-point   
#         
#         DELETE FROM xcdb_t
#          WHERE xcdbent = g_enterprise AND 
#                xcdbld = g_xcdb_d[li_idx].xcdbld
#                AND xcdb001 = g_xcdb_d[li_idx].xcdb001
#                AND xcdb002 = g_xcdb_d[li_idx].xcdb002
#                AND xcdb003 = g_xcdb_d[li_idx].xcdb003
#                AND xcdb004 = g_xcdb_d[li_idx].xcdb004
#                AND xcdb005 = g_xcdb_d[li_idx].xcdb005
#                AND xcdb006 = g_xcdb_d[li_idx].xcdb006
#                AND xcdj007 = g_xcdb_d[li_idx].xcdj007
#                AND xcdj008 = g_xcdb_d[li_idx].xcdj008
#                AND xcdj009 = g_xcdb_d[li_idx].xcdj009
#                AND xcdb010 = g_xcdb_d[li_idx].xcdb010
# 
#         #add-point:單身刪除中

#         #end add-point  
#                
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcdb_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#            RETURN
#         ELSE
#            LET g_detail_cnt = g_detail_cnt-1
#            LET l_ac = li_idx
#            
# 
#            
# 
#            #add-point:單身同步刪除前(同層table)

#            #end add-point
#            LET g_detail_idx = li_idx
#                           INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xcdb_d[g_detail_idx].xcdbld
#               LET gs_keys[2] = g_xcdb_d[g_detail_idx].xcdb001
#               LET gs_keys[3] = g_xcdb_d[g_detail_idx].xcdb002
#               LET gs_keys[4] = g_xcdb_d[g_detail_idx].xcdb003
#               LET gs_keys[5] = g_xcdb_d[g_detail_idx].xcdb004
#               LET gs_keys[6] = g_xcdb_d[g_detail_idx].xcdb005
#               LET gs_keys[7] = g_xcdb_d[g_detail_idx].xcdb006
#               LET gs_keys[8] = g_xcdb_d[g_detail_idx].xcdj007
#               LET gs_keys[9] = g_xcdb_d[g_detail_idx].xcdj008
#               LET gs_keys[10] = g_xcdb_d[g_detail_idx].xcdj009
#               LET gs_keys[11] = g_xcdb_d[g_detail_idx].xcdb010
# 
#            #add-point:單身同步刪除中(同層table)

#            #end add-point
#                           CALL axct305_01_delete_b('xcdb_t',gs_keys,"'1'")
#            #add-point:單身同步刪除後(同層table)

#            #end add-point
#         END IF 
#      END IF 
#    
#   END FOR
#   CALL s_transaction_end('Y','0')
#   
#   LET g_detail_idx = li_detail_tmp
#            
#   #add-point:單身刪除後

#   #end add-point  
#   
#   LET l_ac = li_ac_t
#   
#   #刷新資料
#   CALL axct305_01_b_fill(g_wc2)
#            
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct305_01_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2    STRING
   #add-point:b_fill段define

   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前

   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.xcdbent,t0.xcdbcomp,t0.xcdbld,t0.xcdb001,t0.xcdb004,t0.xcdb005,t0.xcdb003, 
       t0.xcdb006,t0.xcdj007,t0.xcdj008,t0.xcdj013,t0.xcdj009,t0.xcdb010,t0.xcdb007,t0.xcdb008,t0.xcdj016, 
       t0.xcdj017,t0.xcdb009,t0.xcdj020,t0.xcdb002,t0.xcdb101,t0.xcdb102  FROM xcdb_t t0",
               "",
               
               " WHERE t0.xcdbent= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc

   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("xcdb_t"),
                      " ORDER BY t0.xcdbld,t0.xcdb001,t0.xcdb002,t0.xcdb003,t0.xcdb004,t0.xcdb005,t0.xcdb006,t0.xcdj007,t0.xcdj008,t0.xcdj009,t0.xcdb010"
   
   #add-point:b_fill段sql之後

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcdb_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axct305_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axct305_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xcdb_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
#   FOREACH b_fill_curs INTO g_xcdb_d[l_ac].xcdbent,g_xcdb_d[l_ac].xcdbcomp,g_xcdb_d[l_ac].xcdbld,g_xcdb_d[l_ac].xcdb001, 
#       g_xcdb_d[l_ac].xcdb004,g_xcdb_d[l_ac].xcdb005,g_xcdb_d[l_ac].xcdb003,g_xcdb_d[l_ac].xcdb006,g_xcdb_d[l_ac].xcdj007, 
#       g_xcdb_d[l_ac].xcdj008,g_xcdb_d[l_ac].xcdj013,g_xcdb_d[l_ac].xcdj009,g_xcdb_d[l_ac].xcdb010,g_xcdb_d[l_ac].xcdb007, 
#       g_xcdb_d[l_ac].xcdb008,g_xcdb_d[l_ac].xcdj016,g_xcdb_d[l_ac].xcdj017,g_xcdb_d[l_ac].xcdb009,g_xcdb_d[l_ac].xcdj020, 
#       g_xcdb_d[l_ac].xcdb002,g_xcdb_d[l_ac].xcdb101,g_xcdb_d[l_ac].xcdb102
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
  
      #add-point:b_fill段資料填充

      #end add-point
      
#      CALL axct305_01_detail_show()      
# 
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = l_ac
#            LET g_errparam.code   = 9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#         END IF
#         EXIT FOREACH
#      END IF
# 
#      LET l_ac = l_ac + 1
#      
#   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_xcdb_d.deleteElement(g_xcdb_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_xcdb_d.getLength()
 
   END FOR
   
   IF g_cnt > g_xcdb_d.getLength() THEN
      LET l_ac = g_xcdb_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_xcdb_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE axct305_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axct305_01_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct305_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="axct305_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct305_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point  
 
   #add-point:set_no_entry_b段control
   
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="axct305_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct305_01_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcdbld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcdb004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xcdb005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xcdb006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " xcdj007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " xcdj008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET ls_wc = ls_wc, " xcdj009 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET ls_wc = ls_wc, " xcdb010 = '", g_argv[11], "' AND "
   END IF
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct305_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define

   #end add-point     
 
   #判斷是否是同一群組的table
#   LET ls_group = "xcdb_t,"
#   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> 'xcdb_t' THEN
#   
#      #add-point:delete_b段刪除前

#      #end add-point     
#   
#      DELETE FROM xcdb_t
#       WHERE xcdbent = g_enterprise AND
#         xcdbld = ps_keys_bak[1] AND xcdb001 = ps_keys_bak[2] AND xcdb002 = ps_keys_bak[3] AND xcdb003 = ps_keys_bak[4] AND xcdb004 = ps_keys_bak[5] AND xcdb005 = ps_keys_bak[6] AND xcdb006 = ps_keys_bak[7] AND xcdj007 = ps_keys_bak[8] AND xcdj008 = ps_keys_bak[9] AND xcdj009 = ps_keys_bak[10] AND xcdb010 = ps_keys_bak[11]
# 
#      #add-point:delete_b段刪除中

#      #end add-point  
#         
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#      END IF
      
      #add-point:delete_b段刪除後

      #end add-point
      
#      RETURN
#   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct305_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define

   #end add-point     
 
   #判斷是否是同一群組的table
#   LET ls_group = "xcdb_t,"
#   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
#      
#      #add-point:insert_b段新增前

#      #end add-point    
#      INSERT INTO xcdb_t
#                  (xcdbent,
#                   xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdj007,xcdj008,xcdj009,xcdb010
#                   ,xcdbent,xcdbcomp,xcdj013,xcdb007,xcdb008,xcdj016,xcdj017,xcdb009,xcdj020,xcdb101,xcdb102) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#                   ,g_xcdb_d[l_ac].xcdbent,g_xcdb_d[l_ac].xcdbcomp,g_xcdb_d[l_ac].xcdj013,g_xcdb_d[l_ac].xcdb007, 
#                       g_xcdb_d[l_ac].xcdb008,g_xcdb_d[l_ac].xcdj016,g_xcdb_d[l_ac].xcdj017,g_xcdb_d[l_ac].xcdb009, 
#                       g_xcdb_d[l_ac].xcdj020,g_xcdb_d[l_ac].xcdb101,g_xcdb_d[l_ac].xcdb102)
#      #add-point:insert_b段新增中

#      #end add-point    
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcdb_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#      END IF
      #add-point:insert_b段新增後

      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct305_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point     
   
   #比對新舊值, 判斷key是否有改變
#   LET lb_chk = TRUE
#   FOR li_idx = 1 TO ps_keys.getLength()
#      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
#         LET lb_chk = FALSE
#         EXIT FOR
#      END IF
#   END FOR
#   
#   #若key無變動, 不需要做處理
#   IF lb_chk THEN
#      RETURN
#   END IF
#    
#   #若key有變動, 則連動其他table的資料   
#   #判斷是否是同一群組的table
#   LET ls_group = "xcdb_t,"
#   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "xcdb_t" THEN
#      #add-point:update_b段修改前

#      #end add-point     
#      UPDATE xcdb_t 
#         SET (xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdj007,xcdj008,xcdj009,xcdb010
#              ,xcdbent,xcdbcomp,xcdj013,xcdb007,xcdb008,xcdj016,xcdj017,xcdb009,xcdj020,xcdb101,xcdb102) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#              ,g_xcdb_d[l_ac].xcdbent,g_xcdb_d[l_ac].xcdbcomp,g_xcdb_d[l_ac].xcdj013,g_xcdb_d[l_ac].xcdb007, 
#                  g_xcdb_d[l_ac].xcdb008,g_xcdb_d[l_ac].xcdj016,g_xcdb_d[l_ac].xcdj017,g_xcdb_d[l_ac].xcdb009, 
#                  g_xcdb_d[l_ac].xcdj020,g_xcdb_d[l_ac].xcdb101,g_xcdb_d[l_ac].xcdb102) 
#         WHERE xcdbld = ps_keys_bak[1] AND xcdb001 = ps_keys_bak[2] AND xcdb002 = ps_keys_bak[3] AND xcdb003 = ps_keys_bak[4] AND xcdb004 = ps_keys_bak[5] AND xcdb005 = ps_keys_bak[6] AND xcdb006 = ps_keys_bak[7] AND xcdj007 = ps_keys_bak[8] AND xcdj008 = ps_keys_bak[9] AND xcdj009 = ps_keys_bak[10] AND xcdb010 = ps_keys_bak[11]
#      #add-point:update_b段修改中

#      #end add-point 
#      CASE
#         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcdb_t" 
#            LET g_errparam.code   = "std-00009" 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#         WHEN SQLCA.sqlcode #其他錯誤
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcdb_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#         OTHERWISE
#            
#      END CASE
#      #add-point:update_b段修改後

#      #end add-point 
#      RETURN
#   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct305_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL axct305_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
#   LET ls_group = "xcdb_t"
#   
#   IF ls_group.getIndexOf(ps_table,1) THEN
#   
#      OPEN axct305_01_bcl USING g_enterprise,
#                                       g_xcdb_d[g_detail_idx].xcdbld,g_xcdb_d[g_detail_idx].xcdb001, 
#                                           g_xcdb_d[g_detail_idx].xcdb002,g_xcdb_d[g_detail_idx].xcdb003, 
#                                           g_xcdb_d[g_detail_idx].xcdb004,g_xcdb_d[g_detail_idx].xcdb005, 
#                                           g_xcdb_d[g_detail_idx].xcdb006,g_xcdb_d[g_detail_idx].xcdj007, 
#                                           g_xcdb_d[g_detail_idx].xcdj008,g_xcdb_d[g_detail_idx].xcdj009, 
#                                           g_xcdb_d[g_detail_idx].xcdb010
#                                       
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "axct305_01_bcl" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         RETURN FALSE
#      END IF
#   
#   END IF
#                                    
# 
#   
#   RETURN TRUE
# 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct305_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE axct305_01_bcl
   #END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION axct305_01_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xcdbent"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_01.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axct305_01_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
#   
#   CALL g_pk_array.clear()
#   LET g_pk_array[1].values = g_xcdb_d[l_ac].xcdbld
#   LET g_pk_array[1].column = 'xcdbld'
#   LET g_pk_array[2].values = g_xcdb_d[l_ac].xcdb001
#   LET g_pk_array[2].column = 'xcdb001'
#   LET g_pk_array[3].values = g_xcdb_d[l_ac].xcdb002
#   LET g_pk_array[3].column = 'xcdb002'
#   LET g_pk_array[4].values = g_xcdb_d[l_ac].xcdb003
#   LET g_pk_array[4].column = 'xcdb003'
#   LET g_pk_array[5].values = g_xcdb_d[l_ac].xcdb004
#   LET g_pk_array[5].column = 'xcdb004'
#   LET g_pk_array[6].values = g_xcdb_d[l_ac].xcdb005
#   LET g_pk_array[6].column = 'xcdb005'
#   LET g_pk_array[7].values = g_xcdb_d[l_ac].xcdb006
#   LET g_pk_array[7].column = 'xcdb006'
#   LET g_pk_array[8].values = g_xcdb_d[l_ac].xcdj007
#   LET g_pk_array[8].column = 'xcdj007'
#   LET g_pk_array[9].values = g_xcdb_d[l_ac].xcdj008
#   LET g_pk_array[9].column = 'xcdj008'
#   LET g_pk_array[10].values = g_xcdb_d[l_ac].xcdj009
#   LET g_pk_array[10].column = 'xcdj009'
#   LET g_pk_array[11].values = g_xcdb_d[l_ac].xcdb010
#   LET g_pk_array[11].column = 'xcdb010'
#   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct305_01.state_change" >}
   
 
{</section>}
 
{<section id="axct305_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct305_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct305_01_excelexample(n,t,p_show_hidden)
DEFINE  t,t1,t2,n1_text,n3_text         om.DomNode,
        n,n2,n_child                    om.DomNode,
        p_show_hidden                   LIKE type_t.chr1,    #隱藏欄位是否顯示
        n1,n_table,n3                   om.NodeList,
        i,res,p,q,k                     LIKE type_t.num10,
        h                               LIKE type_t.num10,
        cnt_combo_data,cnt_combo_tot    LIKE type_t.num10,
        cells,values,j,l,sheet,cc       STRING,
        table_name,l_length             STRING,
        l_table_name                    LIKE type_t.chr20,
        l_datatype                      LIKE type_t.chr20,
        l_bufstr                        base.StringBuffer,
        lwin_curr                       ui.Window,
        l_show                          LIKE type_t.chr1,
        l_time                          LIKE type_t.chr8

 DEFINE  combo_arr        DYNAMIC ARRAY OF RECORD
           sheet          LIKE type_t.num10,
           seq            LIKE type_t.num10,
           name           LIKE type_t.chr2,
           text           LIKE type_t.chr50
                          END RECORD
 DEFINE  customize_table  LIKE type_t.chr1
 DEFINE  l_str            STRING
 DEFINE  l_i              LIKE type_t.num5
 DEFINE  buf              base.StringBuffer
 DEFINE  l_dec_point      STRING,
         l_qry_name       LIKE type_t.chr20,
         l_cust           LIKE type_t.chr1
 DEFINE  l_tabIndex       LIKE type_t.num10
 DEFINE  l_seq            DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_seq2           DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_j              LIKE type_t.num5
 DEFINE  bFound           LIKE type_t.num5
 DEFINE  l_dbname         STRING
 DEFINE  l_zal09          LIKE type_t.chr1
 DEFINE  l_desc           STRING


   
   WHENEVER ERROR CALL cl_err_msg_log

   LET cnt_table = 1

   LET l_bufstr = base.StringBuffer.create()
#   WHENEVER ERROR CALL cl_err_msg_log
   LET lwin_curr = ui.window.getCurrent()

   LET l_channel = base.Channel.create()
   LET l_time = TIME(CURRENT)
  #LET xls_name = g_prog CLIPPED,l_time CLIPPED,".xls"
   LET xls_name = g_master.name CLIPPED,".xls"

   LET buf = base.StringBuffer.create()
   CALL buf.append(xls_name)
   CALL buf.replace( ":","-", 0)
   LET xls_name = buf.toString()

   # 個資會記錄使用者的行為模式，在此說明excel的檔名及匯出excel的方式
   LET l_desc = xls_name CLIPPED," Using HTML to export the Table to excel."

   IF os.Path.delete(xls_name CLIPPED) THEN END IF
   CALL l_channel.openFile( xls_name CLIPPED, "a" )
   CALL l_channel.setDelimiter("")

   IF ms_codeset.getIndexOf("BIG5", 1) OR
      ( ms_codeset.getIndexOf("GB2312", 1) OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) ) THEN
      IF ms_locale = "ZH_TW" AND g_lang = '2' THEN
         LET tsconv_cmd = "big5_to_gb2312"
         LET ms_codeset = "GB2312"
      END IF
      IF ms_locale = "ZH_CN" AND g_lang = '0' THEN
         LET tsconv_cmd = "gb2312_to_big5"
         LET ms_codeset = "BIG5"
      END IF
   END IF

   LET l_str = "<html xmlns:o=",g_quote,"urn:schemas-microsoft-com:office:office",g_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "<meta http-equiv=Content-Type content=",g_quote,"text/html; charset=",ms_codeset,g_quote,">"
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns:x=",g_quote,"urn:schemas-microsoft-com:office:excel",g_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns=",g_quote,"http://www.w3.org/TR/REC-html40",g_quote,">"
   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("<head><style><!--")

   IF not ms_codeset.getIndexOf("UTF-8", 1) THEN
      IF g_lang = "0" THEN  #繁體中文
         CALL l_channel.write("td  {font-family:細明體, serif;}")
      ELSE
         IF g_lang = "2" THEN  #簡體中文
            CALL l_channel.write("td  {font-family:新宋体, serif;}")
         ELSE
            CALL l_channel.write("td  {font-family:細明體, serif;}")
         END IF
      END IF
   ELSE
      CALL l_channel.write("td  {font-family:Courier New, serif;}")
   END IF

   LET l_str = ".xl24  {mso-number-format:",g_quote,"\@",g_quote,";}",
               ".xl30 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
               ".xl31 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
               ".xl32 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
               ".xl33 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
               ".xl34 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
               ".xl35 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
               ".xl36 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
               ".xl37 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
               ".xl38 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
               ".xl39 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
               ".xl40 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "
   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("--></style>")
   CALL l_channel.write("<!--[if gte mso 9]><xml>")
   CALL l_channel.write("<x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>")
   CALL l_channel.write("<x:DefaultRowHeight>330</x:DefaultRowHeight>")
   CALL l_channel.write("</xml><![endif]--></head>")
   CALL l_channel.write("<body><table border=1 cellpadding=0 cellspacing=0 width=432 style='border-collapse: collapse;table-layout:fixed;width:324pt'>")
   CALL l_channel.write("<tr height=22>")

   LET l_win_name = NULL
   LET l_win_name = n.getAttribute("name")

   LET n_table = n.selectByTagName("Table")
   CALL combo_arr.clear()
   FOR h=1 to cnt_table
      CALL g_hidden.clear()
      CALL g_ifchar.clear()
      CALL g_mask.clear()
      LET n2 = n_table.item(h)

      IF l_win_name = "p_dbqry_table" THEN
         LET n1 = n2.selectByPath("//TableColumn[@hidden=\"0\"]")
      ELSE
         LET n1 = n2.selectByTagName("TableColumn")
      END IF

      #抓取 table 是否有進行欄位排序
      INITIALIZE g_sort.* TO NULL
      LET g_sort.column = n2.getAttribute("sortColumn")
      IF g_sort.column >=0 AND g_sort.column IS NOT NULL  THEN
         LET g_sort.column = g_sort.column + 1    #屬性 sortColumn 為 0 開始
         LET g_sort.type = n2.getAttribute("sortType")
      END IF

      LET cnt_header = n1.getLength()
      LET l = h
      LET sheet=g_sheet  CLIPPED,l
      LET k = 0

      CALL l_seq.clear()
      CALL l_seq2.clear()

     #循環Table中的每一個列
     FOR i=1 TO cnt_header
       #得到對應的DomNode節點
       LET n1_text = n1.item(i)
       #得到該列的TabIndex屬性
       LET l_tabIndex = n1_text.getAttribute("tabIndex")

       #如果TabIndex屬性不為空
       IF NOT cl_null(l_tabIndex) THEN
          #初始化一個標志變量（表明是否在數組中找到比當前TabIndex更大的節點）
          LET bFound = FALSE
          #開始在已有的數組中定位比當前tabIndex大的成員
          FOR l_j=1 TO l_seq2.getLength()
              #如果有找到
              IF l_seq2[l_j] > l_tabIndex THEN
                 #設置標志變量
                 LET bFound = TRUE
                 #退出搜尋過程（此時下標j保存的該成員變量的位置）
                 EXIT FOR
              END IF
          END FOR
          #如果始終沒有找到（比如數組根本就是空的）那麼j里面保存的就是當前數組最大下標+1
          #判斷有沒有找到
          IF bFound THEN
             #如果找到則向該數組中插入一個元素（在這個tabIndex比它大的元素前面插入)
             CALL l_seq2.InsertElement(l_j)
             CALL l_seq.InsertElement(l_j)
          END IF
          #把當前的下標（列的位置）和tabIndex填充到這個位置上
          #如果沒有找到，則填充的位置會是整個數組的末尾
          LET l_seq[l_j] = i
          LET l_seq2[l_j] = l_tabIndex
       END IF
     END FOR

      FOR i=1 to cnt_header
         LET n1_text = n1.item(l_seq[i])
         LET k = k + 1
         LET j = k
         LET cells = "R1C" CLIPPED,j
         LET l_field_name = NULL
         LET l_show = n1_text.getAttribute("hidden")
         IF ((p_show_hidden = 'N' OR p_show_hidden IS NULL) AND (l_show = "0" OR l_show IS NULL)) OR p_show_hidden = 'Y' THEN
            LET l_field_name = n1_text.getAttribute("name")
            IF l_field_name = 'xcdb_t.xcdbent' OR l_field_name = 'xcdb_t.xcdbld' OR
               l_field_name = 'xcdb_t.xcdbcomp' OR 
               l_field_name = 'xcdb_t.xcdb004' OR l_field_name = 'xcdb_t.xcdb005' OR
               l_field_name = 'xcdb_t.xcdb003' OR l_field_name = 'xcdb_t.xcdb006' OR
               l_field_name = 'xcdb_t.xcdb007' OR l_field_name = 'xcdb_t.xcdb008' OR
               l_field_name = 'xcdb_t.xcdb009' OR l_field_name = 'xcdb_t.xcdb011' OR
               l_field_name = 'xcdb_t.xcdb010' OR l_field_name = 'xcdb_t.xcdb002' OR 
               l_field_name = 'xcdb_t.xcdb101' OR l_field_name = 'xcdb_t.xcdb102' OR
               l_field_name = 'formonly.xcdb102_2' OR l_field_name = 'formonly.xcdb102_3' 
               THEN
               LET values = n1_text.getAttribute("text")
               LET l_str = "<td>",axct305_01_add_span(values),"</td>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         ELSE
            LET g_hidden[i] = "1"
            LET k = k -1
         END IF
      END FOR
      IF h=1 THEN CALL axct305_01_get_boday(h,cnt_header,t,combo_arr,l_seq) END IF

   END FOR

   # 使用者的行為模式改到前面判斷，在此僅將前面判斷的結果說明傳至syslog中做紀錄
   IF cl_log_sys_operation("A","G",l_desc) THEN
   END IF
END FUNCTION

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
PRIVATE FUNCTION axct305_01_add_span(p_str)
DEFINE p_str    STRING
DEFINE l_str    STRING


   LET p_str = p_str.trimRight()

   #若字串有空白就必須加上 <span> 屬性，並將空白轉換為 &nbsp;
   IF p_str.getIndexOf(" ",1) > 0 THEN
      LET g_bufstr = base.StringBuffer.create()              
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace(" ","&nbsp;",0)
      CALL g_bufstr.replace("<","&lt;",0)    
      LET l_str = g_bufstr.tostring()
      LET l_str = "<span style='mso-spacerun:yes'>", l_str, "</span>"
   ELSE
      LET g_bufstr = base.StringBuffer.create()
      CALL g_bufstr.clear()
      CALL g_bufstr.append(p_str)
      CALL g_bufstr.replace("<","&lt;",0)
      LET l_str = g_bufstr.tostring()
      #LET l_str = p_str    

   END IF

   RETURN l_str
END FUNCTION

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
PRIVATE FUNCTION axct305_01_get_boday(p_h,p_cnt_header,s,s_combo_arr,p_seq)
DEFINE  s,n1_text                          om.DomNode,
        n1                                 om.NodeList,
        i,m,k,cnt_body,res,p               LIKE type_t.num10,
        l_hidden_cnt,n,l_last_hidden       LIKE type_t.num10,
        p_h,p_cnt_header,arr_len           LIKE type_t.num10,
        p_null                             LIKE type_t.num10,
        cells,values,j,l,sheet             STRING,
        l_bufstr                           base.StringBuffer

 DEFINE  s_combo_arr    DYNAMIC ARRAY OF RECORD
          sheet         LIKE type_t.num10,       #sheet
          seq           LIKE type_t.num10,       #項次
          name          LIKE type_t.chr2,        #代號
          text          LIKE type_t.chr50        #說明
                        END RECORD
 DEFINE  p_seq          DYNAMIC ARRAY OF LIKE type_t.num10
 DEFINE  l_item         LIKE type_t.num10

 DEFINE  unix_path      STRING,
         window_path    STRING
 DEFINE  l_dom_doc      om.DomDocument,
         r,n_node       om.DomNode
 DEFINE  l_status       LIKE type_t.num5

   LET l_hidden_cnt = 0
   LET l = p_h
   LET sheet=g_sheet CLIPPED,l
   LET l_bufstr = base.StringBuffer.create()
   LET l = 0
   LET i = 0
   LET m = 0

   CALL l_channel.write("</tr></table></body></html>")
   CALL l_channel.close()
  #CALL cl_prt_convert(xls_name)

   LET unix_path = os.Path.join(FGL_GETENV("TEMPDIR"),xls_name CLIPPED)

  #LET window_path = "c:\\TT\\",xls_name CLIPPED
   LET window_path = g_master.dir,"\\",xls_name CLIPPED
   LET status = cl_client_download_file(unix_path, window_path)
   IF status then
      DISPLAY "Download OK!!"
   ELSE
      DISPLAY "Download fail!!"
   END IF

   LET status = cl_client_open_prog("excel",window_path)
   IF status then
      DISPLAY "Open OK!!"
   ELSE
      DISPLAY "Open fail!!"
   END IF
END FUNCTION

 
{</section>}
 

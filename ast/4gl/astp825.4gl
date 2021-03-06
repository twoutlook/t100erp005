#該程式未解開Section, 採用最新樣板產出!
{<section id="astp825.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-08-18 11:41:14), PR版次:0007(2017-02-15 17:15:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: astp825
#+ Description: 鋪位貨款明細批量處理作業
#+ Creator....: 02749(2016-05-06 14:43:08)
#+ Modifier...: 07142 -SD/PR- 08171
 
{</section>}
 
{<section id="astp825.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#170109-00037#16 170111 By 08171 批次LOCK處理:1.UI勾選LOCK檢查
#                                            2.資料處理LOCK
#                                            3.指標或筆數統計變數型態調整為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
       
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel              LIKE type_t.chr1,
        b_rtjasite         LIKE rtja_t.rtjasite,
        b_rtjasite_desc    LIKE ooefl_t.ooefl003,
        b_rtjadocdt        LIKE rtja_t.rtjadocdt, 
        b_rtjadocno        LIKE rtja_t.rtjadocno,           
        b_rtja101          LIKE rtja_t.rtja101,
        b_rtja101_desc     LIKE mhbel_t.mhbel003,
        b_rtja102          LIKE rtja_t.rtja102,
        b_rtja102_desc     LIKE pmaal_t.pmaal004,
        #160513-00037#26 Add By Ken 160603(S)
        b_rtja106          LIKE rtja_t.rtja106,
        l_rtjc003_sum      LIKE rtjc_t.rtjc003,
        #160513-00037#26 Add By Ken 160603(E)
        b_rtja049          LIKE rtja_t.rtja049,   #160513-00037#26 Modify By Ken 160603  031->049
        l_rtjf003_sum      LIKE rtjf_t.rtjf003,
        l_rtja031_diff     LIKE rtjf_t.rtjf003,
        b_rtja103          LIKE rtja_t.rtja103,
        b_rtja104          LIKE rtja_t.rtja104
                     END RECORD
                     
DEFINE g_master RECORD
       l_start_date    LIKE type_t.chr500, 
       l_end_date      LIKE type_t.chr500,   
       #160513-00037#26 Add By Ken 160603(S)       
       #l_stus          STRING,  
       l_rtja048       LIKE rtja_t.rtja048,
       l_rtjf104       LIKE rtjf_t.rtjf104,
       #160513-00037#26 Add By Ken 160603(E)
       #l_sour_type_1   STRING,
       #l_sour_type_2   STRING,
       #l_sour_type_3   STRING,
       wc              STRING
                 END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF RECORD
        l_rtjasite           LIKE rtja_t.rtjasite,
        l_rtjasite_desc      LIKE ooefl_t.ooefl003,
        l_rtjadocdt          LIKE rtja_t.rtjadocdt,
        l_rtja101            LIKE rtja_t.rtja101,
        l_rtja101_desc       LIKE mhbel_t.mhbel003,
        l_rtja102            LIKE rtja_t.rtja102,
        l_rtja102_desc       LIKE pmaal_t.pmaal004,
        #160513-00037#26 Add By Ken 160603(S)
        l_rtja106          LIKE rtja_t.rtja106,
        l_rtjc003_sum_1      LIKE rtjc_t.rtjc003,
        #160513-00037#26 Add By Ken 160603(E)        
        l_rtja049            LIKE rtja_t.rtja049,   #160513-00037#26 Modify By Ken 160603  031->049
        l_rtjf003_sum_1      LIKE rtjf_t.rtjf003,
        l_rtja031_diff_1     LIKE rtjf_t.rtjf003
                   END RECORD
                   
DEFINE g_detail3_d  DYNAMIC ARRAY OF RECORD
        b_rtjf025            LIKE rtjf_t.rtjf025,
        b_rtjf103            LIKE rtjf_t.rtjf103,
        b_rtjf002            LIKE rtjf_t.rtjf002,
        b_rtjf002_desc       LIKE ooail_t.ooail003,
        b_rtjf003            LIKE rtjf_t.rtjf003,
        #160513-00037#26 Add By Ken 160603(S)
        b_rtjf104            LIKE rtjf_t.rtjf104,
        b_rtjf105            LIKE rtjf_t.rtjf105,
        #160513-00037#26 Add By Ken 160603(E)    
        #add by zhangnan --str
        b_rtjf106            LIKE rtjf_t.rtjf106,
        b_rtjf107            LIKE rtjf_t.rtjf107,
        b_rtjf108            LIKE rtjf_t.rtjf108
        #add by zhangnan  --end 
                   END RECORD
                   
#160513-00037#26 Add By Ken 160603(S)
#折價資訊
DEFINE g_detail4_d  DYNAMIC ARRAY OF RECORD
        b_rtjcseq            LIKE rtjc_t.rtjcseq,
        b_rtjcseq1           LIKE rtjc_t.rtjcseq1,
        l_rtjb004            LIKE rtjb_t.rtjb004,
        l_rtjb004_desc       LIKE imaal_t.imaal003,
        l_rtjb004_desc_1     LIKE imaal_t.imaal004,
        b_rtjc002            LIKE rtjc_t.rtjc002,
        b_rtjc003            LIKE rtjc_t.rtjc003,
        b_rtjc013            LIKE rtjc_t.rtjc013
                   END RECORD
#160513-00037#26 Add By Ken 160603(E)
                   
                   
DEFINE g_detail2_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)   
DEFINE g_detail3_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail4_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)  #160513-00037#26 Add By Ken 160603
DEFINE g_rtax004             LIKE rtax_t.rtax004
#170109-00037#16 170111 By 08171 --s mark
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5
#170109-00037#16 170111 By 08171 --e mark
#170109-00037#16 170111 By 08171 --s add
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10
#170109-00037#16 170111 By 08171 --e add
DEFINE g_txn_type            LIKE gzcb_t.gzcb002
DEFINE g_wc3                 STRING   #160604-00009#17 20160607 add by Ken
DEFINE g_select_1            LIKE type_t.chr10
DEFINE g_select_2            LIKE type_t.chr10
DEFINE g_select_3            LIKE type_t.chr10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="astp825.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5  
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_settle_create_tmp() RETURNING l_success
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp825 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astp825_init()   
 
      #進入選單 Menu (="N")
      CALL astp825_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp825
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp825.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astp825_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("l_sour_type_1","6930")
   CALL cl_set_combo_scc("l_sour_type_2","6930")
   CALL cl_set_combo_scc("l_sour_type_3","6930")
   CALL cl_set_combo_scc("b_rtjc002","6708")
   CALL cl_get_para(g_enterprise,g_site,'S-CIR-2030') RETURNING g_txn_type  #160604-00009#16 Add By ken 160607
   CALL cl_set_comp_entry("rtjasite",TRUE)   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp825.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp825_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_type          LIKE type_t.chr1
   DEFINE l_where           STRING   
   DEFINE l_rtjadocno     LIKE rtja_t.rtjadocno #170109-00037#16 170111 By 08171
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where
   #170109-00037#16 170111 By 08171 --s add
   LET g_sql = "SELECT rtjadocno FROM rtja_t ",
               " WHERE rtjaent = ",g_enterprise,
               "   AND rtjadocno = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE astp825_chk_lock_rtja FROM g_sql
   #170109-00037#16 170111 By 08171 --e add
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astp825_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #INPUT BY NAME g_master.l_start_date , g_master.l_end_date ,
         #              #160513-00037#26 Modify By Ken 160603(S) 
         #              #g_master.l_rtax001,     g_master.l_stus ,    
         #              #g_master.l_rtax001,     g_master.l_rtja048,    g_master.l_rtjf104,
         #              g_master.l_rtja048,    g_master.l_rtjf104,
         #              #160513-00037#26 Modify By Ken 160603(E)                       
         #              g_master.l_sour_type_1 ,    
         #              g_master.l_sour_type_2 ,    
         #              g_master.l_sour_type_3  ATTRIBUTE(WITHOUT DEFAULTS)
         INPUT g_master.l_start_date , g_master.l_end_date ,
               g_master.l_rtja048,     g_master.l_rtjf104,                     
               g_select_1 ,    
               g_select_2 ,    
               g_select_3  
          FROM l_start_date,l_end_date,l_rtja048,l_rtjf104,
               l_sour_type_1,l_sour_type_2,l_sour_type_3
             
             AFTER FIELD l_start_date 
             AFTER FIELD l_end_date  
             #AFTER FIELD l_rtax001 
             #160513-00037#26 Modify By Ken 160603(S)              
             #AFTER FIELD g_master.l_stus    
             AFTER FIELD l_rtja048
             AFTER FIELD l_rtjf104
             #160513-00037#26 Modify By Ken 160603(E) 
             AFTER FIELD l_sour_type_1 
             AFTER FIELD l_sour_type_2 
             AFTER FIELD l_sour_type_3
         
                          
  
         END INPUT         
         
         CONSTRUCT BY NAME g_master.wc ON rtjasite,rtja101,rtja102
            
            BEFORE CONSTRUCT
            CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where
            
            ON ACTION controlp INFIELD rtjasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
               
               CALL q_ooef001_24()      
               
               DISPLAY g_qryparam.return1 TO rtjasite 
               NEXT FIELD rtjasite              
              
            ON ACTION controlp INFIELD rtja101
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               
               CALL q_mhbe001()                
               
               DISPLAY g_qryparam.return1 TO rtja101 
               NEXT FIELD rtja101  
            
            ON ACTION controlp INFIELD rtja102
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '5'
               
               CALL q_pmaa001_27()         
               
               DISPLAY g_qryparam.return1 TO rtja102 
               NEXT FIELD rtja102             
         END CONSTRUCT
         
         #160604-00009#17 Add By Ken 160608(S)
         #CONSTRUCT BY NAME g_wc3 ON l_rtax001,l_sour_1,l_sour_2,l_sour_3   #160604-00009#156 Mark By Ken 160722
         CONSTRUCT BY NAME g_wc3 ON l_rtax001,l_stje019,l_stje020,l_stje021,l_sour_1,l_sour_2,l_sour_3    #160604-00009#156 Add By ken 160722 加l_stje019,l_stje020,l_stje021
            ON ACTION controlp INFIELD l_rtax001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = cl_get_para(g_enterprise,'','E-CIR-0001')
               CALL q_rtax001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_rtax001  #顯示到畫面上
               NEXT FIELD l_rtax001                        #返回原欄位
               
            #160604-00009#156 Add By Ken 160722(S)
            ON ACTION controlp INFIELD l_stje019
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_stje019  #顯示到畫面上
               NEXT FIELD l_stje019                     #返回原欄位
               
            ON ACTION controlp INFIELD l_stje020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhab002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_stje020  #顯示到畫面上
               NEXT FIELD l_stje020                     #返回原欄位  

            ON ACTION controlp INFIELD l_stje021
               #add-point:ON ACTION controlp INFIELD stje021 name="construct.c.stje021"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhac003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_stje021  #顯示到畫面上
               NEXT FIELD l_stje021                     #返回原欄位

             #160604-00009#156 Add By Ken 160722(E)
               
             ON ACTION controlp INFIELD l_sour_1 
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
               
                #160513-00037#26 Modify By Ken 160603(S)
                CASE g_select_1
                #CASE g_master.l_sour_type_1 
                #160513-00037#26 Modify By Ken 160603(E)
                   WHEN '1'   #品牌
                      CALL q_oocq002_2002()
                      
                   WHEN '2'   #來源單號
                      CALL q_rtjf102()
                   
                   WHEN '3'   #交款單號
                      CALL q_rtjf103()
                   #160513-00037#26 Add By Ken 160603(S) 
                   WHEN '4'   #租賃合約
                      CALL q_stje001()
                   #160513-00037#26 Add By Ken 160603(E) 
                END CASE
                
                DISPLAY g_qryparam.return1 TO l_sour_1
                NEXT FIELD l_sour_1  
                
             ON ACTION controlp INFIELD l_sour_2 
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
               
                #160513-00037#26 Modify By Ken 160603(S)
                CASE g_select_2
                #CASE g_master.l_sour_type_2 
                #160513-00037#26 Modify By Ken 160603(E)
                   WHEN '1'   #品牌
                      CALL q_oocq002_2002()
                      
                   WHEN '2'   #來源單號
                      CALL q_rtjf102()
                      
                   WHEN '3'   #交款單號
                      CALL q_rtjf103()
                   #160513-00037#26 Add By Ken 160603(S) 
                   WHEN '4'   #租賃合約
                      CALL q_stje001()
                   #160513-00037#26 Add By Ken 160603(E)                       
                END CASE
                
                DISPLAY g_qryparam.return1 TO l_sour_2 
                NEXT FIELD l_sour_2  
                
             ON ACTION controlp INFIELD l_sour_3 
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
               
                #160513-00037#26 Modify By Ken 160603(S)
                CASE g_select_3
                #CASE g_master.l_sour_type_3
                #160513-00037#26 Modify By Ken 160603(E)
                   WHEN '1'   #品牌
                      CALL q_oocq002_2002()
                      
                   WHEN '2'   #來源單號
                      CALL q_rtjf102()
                   
                   WHEN '3'   #交款單號
                      CALL q_rtjf103()
                   #160513-00037#26 Add By Ken 160603(S) 
                   WHEN '4'   #租賃合約
                      CALL q_stje001()
                   #160513-00037#26 Add By Ken 160603(E)                       
                END CASE
                
                DISPLAY g_qryparam.return1 TO l_sour_3
                NEXT FIELD l_sour_3                     
         END CONSTRUCT
         #160604-00009#17 Add By Ken 160608(E)         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
           
           BEFORE INPUT
               CALL cl_set_act_visible("filter",FALSE)
               CALL astp825_set_entry_b()
               CALL astp825_set_no_entry_b()               

           BEFORE ROW
                #確定當下選擇的筆數

                LET l_ac = DIALOG.getCurrentRow("s_detail1")
                LET g_detail_idx = l_ac
                 LET l_ac = g_detail_idx
                 DISPLAY g_detail_idx TO FORMONLY.h_index
                 DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
                 LET g_master_idx = l_ac
                
                CALL astp825_fetch()        
            #170109-00037#16 170111 By 08171 --s add
            ON CHANGE sel
               #UI勾選LOCK檢查
               IF g_detail_d[l_ac].sel = "Y" THEN
                  CALL cl_err_collect_init() 
                  CALL s_transaction_begin()
                  CALL astp825_lock_chk()
                  CALL s_transaction_end('Y',0)
                  CALL cl_err_collect_show()
               END IF
            #170109-00037#16 170111 By 08171 --e add
         END INPUT
         

         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT = g_detail_cnt) 
         #  BEFORE ROW
         #      #顯示單身筆數
         #      #CALL astt203_idx_chk()
         #      #確定當下選擇的筆數
         #      LET l_ac = DIALOG.getCurrentRow("s_detail1")
         #      LET g_detail_idx = l_ac
         #      
         #      #add-point:page1, before row動作
         #      CALL astp825_fetch()
         #      #end add-point
         #
         #
         #END DISPLAY
         
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT = g_detail2_cnt)
          BEFORE ROW
         LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
         LET l_ac = g_detail_idx2
         DISPLAY g_detail_idx2 TO FORMONLY.idx
         DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt               
         END DISPLAY
         
         #160513-00037#26 Add By Ken 160603(S)
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT = g_detail3_cnt)
          BEFORE ROW
         LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
         LET l_ac = g_detail_idx2
         DISPLAY g_detail_idx2 TO FORMONLY.idx
         DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt         
         END DISPLAY
        
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTES(COUNT = g_detail4_cnt)
        BEFORE ROW
         LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
         LET l_ac = g_detail_idx2
         DISPLAY g_detail_idx2 TO FORMONLY.idx
         DISPLAY g_detail4_d.getLength() TO FORMONLY.cnt         
         END DISPLAY
         #160513-00037#26 Add By Ken 160603(E)
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #160513-00037#26 Modify By Ken 160603(S) 
            #LET g_master.l_stus = '0'
            LET g_master.l_rtja048 = '0'
            LET g_master.l_rtjf104 = '0'
            #160513-00037#26 Modify By Ken 160603(E) 
            LET g_select_1 = '1'
            LET g_select_2 = '2'
            LET g_select_3 = '3'
            
            #160513-00037#26 Modify By Ken 160603(S)
            #DISPLAY BY NAME g_master.l_stus,g_master.l_sour_type_1,g_master.l_sour_type_2,g_master.l_sour_type_3
            DISPLAY g_master.l_rtja048 TO l_rtja048
            DISPLAY g_master.l_rtjf104 TO l_rtjf104
            DISPLAY g_select_1 TO l_sour_type_1
            DISPLAY g_select_2 TO l_sour_type_2
            DISPLAY g_select_3 TO l_sour_type_3
            #160513-00037#26 Modify By Ken 160603(E)
            NEXT FIELD rtjasite
            
            AFTER DIALOG
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init() #170109-00037#16 170111 By 08171 add 
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #170109-00037#16 170111 By 08171 add --s
               CALL s_transaction_begin()
               LET l_ac = li_idx
               CALL astp825_lock_chk()
               CALL s_transaction_end('Y',0)
               #170109-00037#16 170111 By 08171 add --e
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show() #170109-00037#16 170111 By 08171 add
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #170109-00037#15 170112 By 08171 --s add
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL s_transaction_begin()
                  LET l_ac = li_idx
                  CALL astp825_lock_chk()
                  CALL s_transaction_end('Y',0)
               END IF
            END FOR
            CALL cl_err_collect_show()
            #170109-00037#15 170112 By 08171 --e add
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astp825_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            #LET g_master.l_sour_1 = cl_str_replace(g_master.l_sour_1,"|","','")
            #IF NOT cl_null(g_master.l_sour_1) THEN  #20160529 sakura add
            #   LET g_master.l_sour_1 = " '",g_master.l_sour_1,"' "
            #END IF  #20160529 sakura add
            #LET g_master.l_sour_2 = cl_str_replace(g_master.l_sour_2,"|","','")
            #IF NOT cl_null(g_master.l_sour_2) THEN  #20160529 sakura add
            #   LET g_master.l_sour_2 = " '",g_master.l_sour_2,"' "
            #END IF  #20160529 sakura add
            #LET g_master.l_sour_3 = cl_str_replace(g_master.l_sour_1,"|","','")
            #IF NOT cl_null(g_master.l_sour_3) THEN  #20160529 sakura add
            #   LET g_master.l_sour_3 = " '",g_master.l_sour_3,"' "
            #END IF  #20160529 sakura add
            #DISPLAY "l_rtja048:",g_master.l_rtja048
#            IF cl_null(GET_FLDBUF(rtjasite)) THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'acr-00015'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#               NEXT FIELD rtjasite
#            END IF
            IF cl_null(g_master.wc) THEN
               LET g_master.wc =l_where
            ELSE               
               LET g_master.wc = g_master.wc," AND ",l_where
            END IF                
            CALL DIALOG.setCurrentRow("s_detail1",1)
            #end add-point
            CALL astp825_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL astp825_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION confirm_batch
            CALL cl_err_collect_init()  #170109-00037#16 170111 By 08171 add
            CALL s_transaction_begin()  #170109-00037#16 170111 By 08171 add
            IF NOT astp825_get_process_data() THEN
               CALL cl_err_collect_show() #170109-00037#16 170111 By 08171 add
               CONTINUE DIALOG
            END IF
                        
            IF NOT s_settle_stbc_batch_ins_tmp('', '', '', '', g_master.l_start_date,
                                  g_master.l_end_date,g_txn_type,"") THEN
               CONTINUE DIALOG
            END IF            
                                 
            #CALL cl_err_collect_init()  #170109-00037#16 170111 By 08171 mark
            #CALL s_transaction_begin()  #170109-00037#16 170111 By 08171 mark
            
            IF NOT astp825_process('Y') THEN
               CALL s_transaction_end('N',1)
            ELSE
               CALL s_transaction_end('Y',1)            
            END IF
            CALL cl_err_collect_show()
            #CALL astp825_b_fill()
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac
            CALL astp825_fetch()            
            
         ON ACTION unconfirm_batch
            CALL cl_err_collect_init()  #170109-00037#16 170111 By 08171 add
            CALL s_transaction_begin()  #170109-00037#16 170111 By 08171 add
            IF NOT astp825_get_process_data() THEN
               CALL cl_err_collect_show() #170109-00037#16 170111 By 08171 add
               CONTINUE DIALOG
            END IF
                                 
            IF NOT s_settle_stbc_batch_ins_tmp('', '', '', '', g_master.l_start_date,
                                  g_master.l_end_date,g_txn_type,"") THEN
               CONTINUE DIALOG
            END IF             
            
            #CALL cl_err_collect_init() #170109-00037#16 170111 By 08171 mark
            #CALL s_transaction_begin() #170109-00037#16 170111 By 08171 mark
            
            IF NOT astp825_process('N') THEN
               CALL s_transaction_end('N',1)
            ELSE
               CALL s_transaction_end('Y',1)            
            END IF
            CALL cl_err_collect_show()
            #CALL astp825_b_fill()
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac
            CALL astp825_fetch()               
            
         
         ON ACTION gen_stbc_ins
            CALL cl_err_collect_init() #170109-00037#16 170111 By 08171 add
            CALL s_transaction_begin() #170109-00037#16 170111 By 08171 add
            IF NOT astp825_get_process_data() THEN
               CALL cl_err_collect_show() #170109-00037#16 170111 By 08171 add
               CONTINUE DIALOG
            END IF
                                               
            IF NOT s_settle_stbc_batch_ins_tmp('', '', '', '', g_master.l_start_date,
                                  g_master.l_end_date,g_txn_type,"") THEN
               CONTINUE DIALOG
            END IF              
            
            #CALL cl_err_collect_init() #170109-00037#16 170111 By 08171 mark
            #CALL s_transaction_begin() #170109-00037#16 170111 By 08171 mark
            
            IF NOT astp825_process('F') THEN
               CALL s_transaction_end('N',1)
            ELSE
               CALL s_transaction_end('Y',1)            
            END IF
            CALL cl_err_collect_show()
            #CALL astp825_b_fill()
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac
            CALL astp825_fetch()               
            
         
         ON ACTION gen_stbc_del
            CALL cl_err_collect_init()  #170109-00037#16 170111 By 08171 add
            CALL s_transaction_begin()  #170109-00037#16 170111 By 08171 add
            IF NOT astp825_get_process_data() THEN
               CALL cl_err_collect_show() #170109-00037#16 170111 By 08171 add
               CONTINUE DIALOG
            END IF
                       
            IF NOT s_settle_stbc_batch_ins_tmp('', '', '', '', g_master.l_start_date,
                                  g_master.l_end_date,g_txn_type,"") THEN
               CONTINUE DIALOG
            END IF               
            
            #CALL cl_err_collect_init() #170109-00037#16 170111 By 08171 mark
            #CALL s_transaction_begin() #170109-00037#16 170111 By 08171 mark
            
            IF NOT astp825_process('NF') THEN
               CALL s_transaction_end('N',1)
            ELSE
               CALL s_transaction_end('Y',1)            
            END IF
            CALL cl_err_collect_show()
            #CALL astp825_b_fill()
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            LET g_detail_idx = l_ac
            CALL astp825_fetch()               
         
         #160604-00009#156 Add By Ken 160722(S)
         #excel匯出功能          
         ON ACTION toexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #非browser
               LET g_export_node[1] = base.typeInfo.create(g_detail_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2_d)
               LET g_export_id[2]   = "s_detail2"                                           
               LET g_export_node[3] = base.typeInfo.create(g_detail3_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_detail4_d)
               LET g_export_id[4]   = "s_detail4"              
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF         
         #160604-00009#156 Add By Ken 160722(E)  
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="astp825.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astp825_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL astp825_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp825.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astp825_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_imaa126_sql   STRING
   DEFINE l_rtjf103_sql   STRING
   DEFINE l_rtjf104_sql   STRING
   DEFINE l_wd1           LIKE gzcb_t.gzcb003
   DEFINE l_wd2           LIKE gzcb_t.gzcb003   
   DEFINE l_wd3           LIKE gzcb_t.gzcb003     
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_sql = "SELECT gzcb003 FROM gzcb_t 
                WHERE gzcb001 = '6930' 
                  AND gzcb002 = ? "
   PREPARE astp825_sel_gzcb FROM l_sql

   LET l_wd1 = ''
   LET l_wd2 = ''
   LET l_wd3 = ''
   
   EXECUTE astp825_sel_gzcb USING g_select_1 INTO l_wd1
   EXECUTE astp825_sel_gzcb USING g_select_2 INTO l_wd2
   EXECUTE astp825_sel_gzcb USING g_select_3 INTO l_wd3   
   
   LET g_wc3 = cl_replace_str(g_wc3, 'l_sour_1',l_wd1)
   LET g_wc3 = cl_replace_str(g_wc3, 'l_sour_2',l_wd2)  
   LET g_wc3 = cl_replace_str(g_wc3, 'l_sour_3',l_wd3)     
   LET g_wc3 = cl_replace_str(g_wc3, 'l_rtax001','stje028')
   #160604-00009#156 Add By Ken 160722(S)
   LET g_wc3 = cl_replace_str(g_wc3, 'l_stje019','stje019')
   LET g_wc3 = cl_replace_str(g_wc3, 'l_stje020','stje020')
   LET g_wc3 = cl_replace_str(g_wc3, 'l_stje021','stje021')
   #160604-00009#156 Add By Ken 160722(E)
   
   LET g_sql = "SELECT 'N' sel ,rtjasite ,rtjadocdt ,rtjadocno ,rtja101 , ",
               "       rtja102 ,rtja049  ,rtja103   ,rtja104   , ",    #160513-00037#26 Modify By Ken 160603  031->049
               "       (SELECT ooefl003 FROM ooefl_t ",
               "         WHERE ooeflent = rtjaent AND ooefl001 = rtjasite AND ooefl002 = '",g_dlang,"') rtjasite_desc, ",
               "       (SELECT mhbel003 FROM mhbel_t ",
               "         WHERE mhbelent = rtjaent AND mhbel001 = rtja101 AND mhbel002 = '",g_dlang,"') rtja101_desc , ",
               "       (SELECT pmaal004 FROM pmaal_t ",
               "         WHERE pmaalent = rtjaent AND pmaal001 = rtja102 AND pmaal002 = '",g_dlang,"') rtja102_desc , ", 
               #160513-00037#26 Add By Ken 160603 加上銷售合約金額(S)
               "       rtja106 , ",     
               "       (SELECT SUM(rtjc013) FROM rtjc_t ",
               "         WHERE rtjcent = rtjaent AND rtjcdocno = rtjadocno) rtjc013_sum, ", 
               #160513-00037#26 Add By Ken 160603 加上銷售合約金額(E)                 
               "       (SELECT SUM(rtjf003) FROM rtjf_t ",
               "         WHERE rtjfent = rtjaent AND rtjfdocno = rtjadocno) rtjf003_sum ", 
               "  FROM rtja_t ",
               "  LEFT JOIN stje_t ON rtjaent = stjeent AND rtja105 = stje001 ",
               "  LEFT JOIN rtjf_t ON rtjaent = rtjfent AND rtjadocno = rtjfdocno ",
               " WHERE rtjaent = ? ",
               "   AND rtja101 IS NOT NULL "               

   IF NOT cl_null(g_master.l_start_date) THEN 
      #160604-00009#147 Modify By Ken 160715(S)
      #LET g_sql = g_sql, " AND rtjadocdt >= '",g_master.l_start_date,"' "
      LET g_sql = g_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
      #160604-00009#147 Modify By Ken 160715(E)
   END IF
   
   IF NOT cl_null(g_master.l_end_date) THEN 
      #160604-00009#147 Modify By Ken 160715(S)
      #LET g_sql = g_sql, " AND rtjadocdt <= '",g_master.l_end_date,"' "
      LET g_sql = g_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
      #160604-00009#147 Modify By Ken 160715(E)
   END IF
   
   #160513-00037#26 Add By Ken 160603(S)
   IF g_master.l_rtja048 != '0' THEN
      LET g_sql = g_sql, " AND rtja048 = '",g_master.l_rtja048,"' "
   END IF  
   
   IF g_master.l_rtjf104 != '0' THEN
      LET g_sql = g_sql, " AND rtjf104 = '",g_master.l_rtjf104,"' "
      #LET g_sql = g_sql, " AND EXISTS (SELECT 1 FROM rtjf_t ",
      #                   "                        WHERE rtjfent = rtjaent ",
      #                   "                          AND rtjfdocno = rtjadocno ",
      #                   "                          AND rtjf104 = '",g_master.l_rtjf104,"') "
   END IF
   #160513-00037#26 Add By Ken 160603(E)
   
   ##管理品類
   #IF g_wc3 != " 1=1" THEN
   #   LET g_wc3 = cl_replace_str(g_wc3,"l_rtax001","stje028")
   #   #IF cl_null(g_rtax004) THEN
   #      #LET g_rtax004 = cl_get_para(g_enterprise,'','E-CIR-0001')
   #   #END IF
   #   
   #   LET g_sql = g_sql, " AND EXISTS(SELECT 1 FROM stje_t ",
   #                      "             WHERE rtjaent = stjeent ",
   #                      "               AND rtja105 = stje001 ",
   #                      "               AND ",g_wc3, ")"
   #   
   #   #LET g_sql = g_sql, " AND EXISTS(SELECT 1 FROM rtjb_t, ",
   #   #                   "                          imaa_t LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 ",
   #   #                   "             WHERE rtjbent = rtjaent AND rtjbdocno = rtjadocno ",
   #   #                   "               AND rtjbent = imaaent AND rtjb004 = imaa001 ",
   #   #                   "               AND rtaw003 = '",g_rtax004,"' ",
   #   #                   "               AND ",g_wc3,")"
   #   #                   #"               AND rtaw003 IN ( '",g_master.l_rtax001,"' ))"
   #END IF
   
   #160513-00037#26 Mark By Ken 160603(S)
   ##拋轉狀態
   #IF NOT cl_null(g_master.l_stus) AND g_master.l_stus <> '0' THEN
   #   LET g_sql = g_sql, " AND rtja104 = '",g_master.l_stus,"' "
   #END IF
   #160513-00037#26 Mark By Ken 160603(E)
   
   ##品牌
   # IF g_master.l_sour_type_1 = '1' OR g_master.l_sour_type_2 = '1' OR g_master.l_sour_type_3 = '1' THEN
   #   LET l_imaa126_sql = "AND EXISTS(SELECT 1 FROM rtjb_t, imaa_t ",
   #                       "            WHERE rtjbent = rtjaent AND rtjbdocno = rtjadocno ",
   #                       "              AND rtjbent = imaaent AND rtjb004 = imaa001 ",
   #                       "              AND imaa126 IN ( ? ))"
   #                       
   #   IF NOT cl_null(g_master.l_sour_1) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_imaa126_sql,"?",g_master.l_sour_1)
   #   END IF    
   #
   #   IF NOT cl_null(g_master.l_sour_2) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_imaa126_sql,"?",g_master.l_sour_2)
   #   END IF   
   #   
   #   IF NOT cl_null(g_master.l_sour_3) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_imaa126_sql,"?",g_master.l_sour_3)
   #   END IF         
   #END IF  
   #
   ##來源單號
   # IF g_master.l_sour_type_1 = '2' OR g_master.l_sour_type_2 = '2' OR g_master.l_sour_type_3 = '2' THEN
   #   LET l_rtjf104_sql = " AND EXISTS(SELECT 1 FROM rtjf_t ",
   #                       "             WHERE rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
   #                       "               AND rtjf104 IN (?) )"
   #
   #   IF NOT cl_null(g_master.l_sour_1) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf104_sql,"?",g_master.l_sour_1)
   #   END IF    
   #
   #   IF NOT cl_null(g_master.l_sour_2) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf104_sql,"?",g_master.l_sour_2)
   #   END IF   
   #   
   #   IF NOT cl_null(g_master.l_sour_3) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf104_sql,"?",g_master.l_sour_3)
   #   END IF  
   #END IF
   #
   ##交款單號
   # IF g_master.l_sour_type_1 = '3' OR g_master.l_sour_type_2 = '3' OR g_master.l_sour_type_3 = '3' THEN
   #   LET l_rtjf103_sql = " AND EXISTS(SELECT 1 FROM rtjf_t ",
   #                       "             WHERE rtjfent = rtjaent AND rtjfdocno = rtjadocno ",
   #                       "               AND rtjf103 IN (?) )"
   #
   #   IF NOT cl_null(g_master.l_sour_1) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf103_sql,"?",g_master.l_sour_1)
   #   END IF    
   #
   #   IF NOT cl_null(g_master.l_sour_2) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf103_sql,"?",g_master.l_sour_2)
   #   END IF   
   #   
   #   IF NOT cl_null(g_master.l_sour_3) THEN
   #      LET g_sql = g_sql, cl_str_replace(l_rtjf103_sql,"?",g_master.l_sour_3)
   #   END IF  
   #END IF  
   
   #QBE
   IF NOT cl_null(g_master.wc) THEN
      LET g_sql = g_sql, " AND ",g_master.wc 
   END IF 
   IF g_wc3 != " 1=1" THEN
      LET g_sql = g_sql, " AND ",g_wc3
   END IF 

   #
   LET g_sql = "SELECT UNIQUE sel          ,rtjasite     ,rtjasite_desc, ",
               "       rtjadocdt    ,rtjadocno    ,rtja101      , ",
               "       rtja101_desc ,rtja102      ,rtja102_desc , ",
               "       rtja106      ,rtjc013_sum  ,",                     #160513-00037#26 Add By Ken 160603
               "       rtja049      ,rtjf003_sum  ,(rtja049-rtjf003_sum) rtjf003_diff , ",   #160513-00037#26 Modify By Ken 160603  031->049
               "       rtja103      ,rtja104                      ",  
               "  FROM (",g_sql,")",  #20160529 sakura modify
               " ORDER BY rtjasite,rtjadocdt,rtjadocno "
   #end add-point
 
   PREPARE astp825_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astp825_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
        g_detail_d[l_ac].sel            ,g_detail_d[l_ac].b_rtjasite     ,g_detail_d[l_ac].b_rtjasite_desc, 
        g_detail_d[l_ac].b_rtjadocdt    ,g_detail_d[l_ac].b_rtjadocno    ,g_detail_d[l_ac].b_rtja101      , 
        g_detail_d[l_ac].b_rtja101_desc ,g_detail_d[l_ac].b_rtja102      ,g_detail_d[l_ac].b_rtja102_desc , 
        g_detail_d[l_ac].b_rtja106      ,g_detail_d[l_ac].l_rtjc003_sum  ,      #160513-00037#26 Add By Ken 160603
        g_detail_d[l_ac].b_rtja049      ,g_detail_d[l_ac].l_rtjf003_sum  ,g_detail_d[l_ac].l_rtja031_diff ,   #160513-00037#26 Modify By Ken 160603  031->049
        g_detail_d[l_ac].b_rtja103      ,g_detail_d[l_ac].b_rtja104      
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      
      #end add-point
      
      CALL astp825_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())    
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astp825_sel
   
   LET l_ac = 1
   CALL astp825_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   LET l_sql = "SELECT rtjasite , rtjasite_desc , rtjadocdt ,   rtja101          , rtja101_desc , ", 
               "       rtja102  , rtja102_desc  , ",
               "       SUM(rtja106), SUM(rtjc013_sum) , ",         #160513-00037#26 Add By Ken 160603
               "       SUM(rtja049), SUM(rtjf003_sum) , SUM(rtja049-rtjf003_sum) ",   #160513-00037#26 Modify By Ken 160603  031->049
               "  FROM ( ", g_sql," ) ",
               " GROUP BY rtjasite , rtjasite_desc , rtjadocdt , rtja101 , rtja101_desc ,",
               "          rtja102  , rtja102_desc  , rtja049 ",    #160513-00037#26 Modify By Ken 160603  031->049
               " ORDER BY rtjasite , rtjadocdt,    rtja101 "
   LET l_sql = cl_sql_add_mask(l_sql)        
   PREPARE astp825_sel2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR astp825_sel2
   
   CALL g_detail2_d.clear()
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 USING g_enterprise INTO 
        g_detail2_d[l_ac].l_rtjasite       ,g_detail2_d[l_ac].l_rtjasite_desc ,g_detail2_d[l_ac].l_rtjadocdt     ,
        g_detail2_d[l_ac].l_rtja101        ,g_detail2_d[l_ac].l_rtja101_desc  ,g_detail2_d[l_ac].l_rtja102       ,
        g_detail2_d[l_ac].l_rtja102_desc   ,
        g_detail2_d[l_ac].l_rtja106        ,g_detail2_d[l_ac].l_rtjc003_sum_1 ,    #160513-00037#26 Add By Ken 160603
        g_detail2_d[l_ac].l_rtja049        ,g_detail2_d[l_ac].l_rtjf003_sum_1 ,    #160513-00037#26 Modify By Ken 160603  031->049
        g_detail2_d[l_ac].l_rtja031_diff_1 
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fill_curs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength()) 
   #LET g_detail2_cnt = l_ac - 1 
   #DISPLAY g_detail2_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs2
   FREE astp825_sel

   LET l_ac = 1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astp825.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astp825_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_rtjadocno     LIKE rtja_t.rtjadocno
   DEFINE l_sql           STRING
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   #160513-00037#26 Add By Ken 160604(S)
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   #160513-00037#26 Add By Ken 160604(E)

   #LET g_detail_idx = l_ac   
   
   IF l_ac > 0 THEN
      LET l_rtjadocno = g_detail_d[l_ac].b_rtjadocno
   ELSE
      RETURN
   END IF
   
   LET l_sql = "SELECT rtjf025, rtjf103, rtjf002, ",    
               "       (SELECT ooial003 FROM ooial_t ",
               "         WHERE ooialent = rtjfent AND ooial001 = rtjf002 AND ooial002 = '",g_dlang,"') rtjf002_desc, ",
               "       rtjf003, ",
               #160513-00037#26 Add By Ken 160603(S)
               "       rtjf104, rtjf105,rtjf106,rtjf107,rtjf108  ",  #add rtjf106,rtjf107,rtjf108 by zhangnan         
               "  FROM rtjf_t ",
               #160513-00037#26 Add By Ken 160603(E)
               " WHERE rtjfent = ",g_enterprise,
               "   AND rtjfdocno =  '",l_rtjadocno,"' "
   IF NOT cl_null(g_master.l_start_date) THEN 
      LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
   END IF
   
   IF NOT cl_null(g_master.l_end_date) THEN 
      LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
   END IF        
   LET l_sql = l_sql," ORDER BY rtjf025,rtjf103,rtjf002 "
   PREPARE astp825_fetch_pre FROM l_sql
   DECLARE b_fetch_curs CURSOR FOR astp825_fetch_pre
   #DISPLAY "l_sql:",l_sql   
                             
   LET l_ac = 1
   FOREACH b_fetch_curs INTO g_detail3_d[l_ac].b_rtjf025,      g_detail3_d[l_ac].b_rtjf103,g_detail3_d[l_ac].b_rtjf002,     
                             g_detail3_d[l_ac].b_rtjf002_desc, g_detail3_d[l_ac].b_rtjf003,
                             g_detail3_d[l_ac].b_rtjf104,      g_detail3_d[l_ac].b_rtjf105,   #160513-00037#26 Add By Ken 160603
                             g_detail3_d[l_ac].b_rtjf106,      g_detail3_d[l_ac].b_rtjf107,  g_detail3_d[l_ac].b_rtjf108  #add by zhangnan                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fetch_curs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF   
      
      #160513-00037#26 Add By Ken 160603(S)
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF   
      #160513-00037#26 Add By Ken 160603(E)      
   END FOREACH    

   CALL g_detail3_d.deleteElement(g_detail3_d.getLength()) 
   #LET g_detail3_cnt = l_ac - 1 
   #DISPLAY g_detail3_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fetch_curs
   FREE astp825_fetch_pre
   
   #160513-00037#26 Add By Ken 160603(S)   
   #折價資訊
   LET l_sql = "SELECT rtjcseq,rtjcseq1,rtjb004,imaal003,imaal004, ",
               "       rtjc002,rtjc003, rtjc013 ",
               "  FROM rtjb_t ",
               "  LEFT JOIN imaal_t ON rtjbent = imaalent AND rtjb004 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "       ,rtjc_t ",
               " WHERE rtjbent = rtjcent ",
               "   AND rtjbdocno = rtjcdocno ",
               "   AND rtjbseq = rtjcseq ",
               "   AND rtjcent = ",g_enterprise,
               "   AND rtjcdocno =  '",l_rtjadocno,"' "               
   PREPARE astp825_fetch_pre1 FROM l_sql
   DECLARE b_fetch_curs1 CURSOR FOR astp825_fetch_pre1   
                             
   LET l_ac = 1
   FOREACH b_fetch_curs1 INTO g_detail4_d[l_ac].b_rtjcseq,      g_detail4_d[l_ac].b_rtjcseq1,g_detail4_d[l_ac].l_rtjb004,     
                              g_detail4_d[l_ac].l_rtjb004_desc, g_detail4_d[l_ac].l_rtjb004_desc_1,
                              g_detail4_d[l_ac].b_rtjc002,      g_detail4_d[l_ac].b_rtjc003,  g_detail4_d[l_ac].b_rtjc013 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fetch_curs1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF   
      

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF       
   END FOREACH    

   CALL g_detail4_d.deleteElement(g_detail4_d.getLength()) 
   #LET g_detail4_cnt = l_ac - 1 
   #DISPLAY g_detail4_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fetch_curs1
   FREE astp825_fetch_pre1   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="astp825.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astp825_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astp825.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astp825_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL astp825_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="astp825.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astp825_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="astp825.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astp825_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = astp825_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astp825.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 取得要處理的資料並存入暫存檔
# Memo...........:
# Usage..........: CALL astp825_get_process_data()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/05/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp825_get_process_data()
   #DEFINE li_idx    LIKE type_t.num5  #170109-00037#16 170111 By 08171 mark
   DEFINE r_success LIKE type_t.num5   #160604-00009#17 Add By ken 160607
   #DEFINE l_cnt     LIKE type_t.num5   #160604-00009#17 Add By ken 160607 #170109-00037#16 170111 By 08171 mark
   DEFINE l_rtjadocno LIKE rtja_t.rtjadocno
   #170109-00037#16 170111 By 08171 add --s 
   DEFINE l_count_o     LIKE type_t.num10 #計算有選取的筆數
   DEFINE l_count       LIKE type_t.num10 #計算有選取但是被LOCK住的筆數
   DEFINE li_idx        LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   #170109-00037#16 170111 By 08171 add --e
   
   LET r_success = TRUE                #160604-00009#17 Add By ken 160607
   #170109-00037#16 170111 By 08171 add --s
   LET l_count_o = 0 
   LET l_count = 0 
   #170109-00037#16 170111 By 08171 add --e
   
   CREATE TEMP TABLE astp825_tmp(
      rtjadocno   LIKE rtja_t.rtjadocno)  #20160529 sakura modify
   
   DELETE FROM astp825_tmp
      
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = 'Y' THEN
         #170109-00037#16 170111 By 08171 --s add  
         LET l_count_o = l_count_o+1 #有選取的筆數
         EXECUTE astp825_chk_lock_rtja USING g_detail_d[li_idx].b_rtjadocno
                                       INTO l_rtjadocno
         IF cl_null(l_rtjadocno) THEN
            LET g_detail_d[li_idx].sel = 'N'
            LET l_count = l_count+1 #有選取但是被LOCK住的筆數
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ast-00868'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_detail_d[l_ac].b_rtjadocno
            CALL cl_err()
         ELSE         
            INSERT INTO astp825_tmp(rtjadocno) VALUES (g_detail_d[li_idx].b_rtjadocno)
         END IF
         #170109-00037#16 170111 By 08171 --e add
         #INSERT INTO astp825_tmp(rtjadocno) VALUES (g_detail_d[li_idx].b_rtjadocno) #170109-00037#15 170112 By 08171 mark
      END IF      
   END FOR
   
   #160604-00009#17 Add By ken 160607(S)
   SELECT COUNT(*) INTO l_cnt
     FROM astp825_tmp
   #170109-00037#15 170112 By 08171 --s add
   IF  l_cnt = 0 THEN 
      INITIALIZE g_errparam TO NULL
      IF l_count = l_count_o THEN     
         LET g_errparam.code = "ast-00867" #目前選取的資料,均已被鎖定,請重新操作 
      ELSE
         LET g_errparam.code = "ast-00806" #請先選取資料，再操作!
      END IF
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET r_success = FALSE
   END IF
   #170109-00037#15 170112 By 08171 --e add
   #170109-00037#15 170112 By 08171 --e mark
   #IF l_cnt = 0 THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = "ast-00806"
   #   LET g_errparam.extend = ""
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()   
   #   LET r_success = FALSE
   #END IF
   #170109-00037#15 170112 By 08171 --e mark
   #160604-00009#17 Add By ken 160607(E)
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 銷售資料與結算底搞更新
# Memo...........:
# Usage..........: CALL astp825_process(p_type)
#                  RETURNING r_success
# Input parameter: 1.p_type      處理狀態 Y:整批確認 N:整批取消 F:整批拋轉結算底搞 NF:整批取消結算底搞
# Return code....: 1.r_success   處理結果
# Date & Author..: 2016/06/03 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astp825_process(p_type)
   DEFINE p_type          LIKE type_t.chr10
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_rtjadocno     LIKE rtja_t.rtjadocno   #單號
   DEFINE l_rtjasite      LIKE rtja_t.rtjasite    #營運組織
   DEFINE l_rtja101       LIKE rtja_t.rtja101     #鋪位
   DEFINE l_rtja102       LIKE rtja_t.rtja102     #商戶
   DEFINE l_rtja105       LIKE rtja_t.rtja105     #合約   
   DEFINE l_rtjadocdt     LIKE rtja_t.rtjadocdt   #單據日期
   DEFINE l_rtjfseq       LIKE rtjf_t.rtjfseq     #項次
   DEFINE l_rtjf003       LIKE rtjf_t.rtjf003     #交款金額
   DEFINE l_txn_type      LIKE gzcb_t.gzcb002     #轉入方式
   #170109-00037#16 170111 By 08171 mark --s
   #DEFINE l_succ_cnt      LIKE type_t.num5 #沒有使用到
   #DEFINE l_err_cnt       LIKE type_t.num5 #沒有使用到
   #DEFINE l_cnt_1         LIKE type_t.num5 #改成num10
   #DEFINE l_cnt_2         LIKE type_t.num5 #改成num10
   #170109-00037#16 170111 By 08171 mark --e 
   #170109-00037#16 170111 By 08171 add  --s
   DEFINE l_cnt_1         LIKE type_t.num10
   DEFINE l_cnt_2         LIKE type_t.num10
   #170109-00037#16 170111 By 08171 add  --e
   DEFINE l_stbc004       LIKE stbc_t.stbc004
   DEFINE l_stbc005       LIKE stbc_t.stbc005
   DEFINE l_rtjf105       LIKE rtjf_t.rtjf105
   DEFINE l_rtjfdocno     LIKE rtjf_t.rtjfdocno
   
   LET r_success = TRUE
   
   
   
   CASE p_type
      WHEN 'Y'   #整批確認 
         LET l_sql = " UPDATE rtjf_t ",
                     "    SET rtjf104 = 'Y',rtjf106 = '",g_user,"', rtjf107 = TO_DATE('",cl_get_current(),"','yyyy-mm-dd hh24:mi:ss') ",
                     "  WHERE rtjfent = ", g_enterprise,
                     "    AND (rtjf104 = 'N' OR rtjf104 IS NULL) ",
                     "    AND EXISTS(SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) "
         IF NOT cl_null(g_master.l_start_date) THEN 
            LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
         END IF
         
         IF NOT cl_null(g_master.l_end_date) THEN 
            LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
         END IF  
         PREPARE astp825_rtjf_y FROM l_sql
         EXECUTE astp825_rtjf_y 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "UPDATE rtjf_t Error!"
            LET g_errparam.code =  SQLCA.sqlcode    
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE 
         END IF     
         IF SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code =  'ast-00812'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE 
         END IF           
         #迴圈報錯
         
      WHEN 'N'   #整批取消 
         LET l_sql = " UPDATE rtjf_t ",
                     "    SET rtjf104 = 'N',rtjf106 ='', rtjf107='' ",
                     "  WHERE rtjfent = ",g_enterprise,
                     "    AND rtjf104 = 'Y' ",
                     "    AND EXISTS(SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) "
         IF NOT cl_null(g_master.l_start_date) THEN 
            LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
         END IF
         
         IF NOT cl_null(g_master.l_end_date) THEN 
            LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
         END IF  
         PREPARE astp825_rtjf_n FROM l_sql
         EXECUTE astp825_rtjf_n                      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "UPDATE rtjf_t Error!"
            LET g_errparam.code =  SQLCA.sqlcode    
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE 
         END IF     
         IF SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code =  'ast-00813'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE 
         END IF            
         #迴圈報錯   
         
      WHEN 'F'   #整批拋轉結算底搞
         IF NOT s_aooi500_tmp_chk() THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET l_txn_type = g_txn_type
        
         CALL s_settle_stbc_batch('', '', '', '', g_master.l_start_date,
                                  g_master.l_end_date,l_txn_type,"")
            RETURNING l_cnt_1,l_cnt_2         
        
        #IF l_cnt_1 > 0 THEN            
        #    UPDATE rtjf_t 
        #       SET rtjf104 = 'F',rtjf105 = l_rtjadocno
        #     WHERE rtjfent = g_enterprise
        #       AND rtjfdocno = l_rtjadocno
        #       AND rtjfseq = l_rtjfseq
        #       AND rtjf104 = 'Y'
        #    IF SQLCA.sqlcode THEN
        #       INITIALIZE g_errparam TO NULL
        #       LET g_errparam.extend = "UPDATE rtjf_t:"
        #       LET g_errparam.code =  SQLCA.sqlcode    
        #       LET g_errparam.popup = TRUE
        #       CALL cl_err()
        #       
        #       LET l_err_cnt = l_err_cnt + l_cnt_2                     
        #    ELSE
        #       LET l_succ_cnt = l_succ_cnt + l_cnt_1                
        #    END IF  
        #                    
        # END IF
        
         IF l_cnt_2 > 0 THEN
            LET r_success = FALSE
         END IF

      WHEN 'NF'  #整批取消結算底搞
        #160513-00037#26 Add By Ken 160604(S)
        IF g_txn_type != '1' THEN
           LET l_sql = "SELECT COUNT(*) ",
                       "  FROM rtjf_t ",
                       " WHERE rtjfent = ",g_enterprise,
                       "   AND rtjf105 = ? "
           IF NOT cl_null(g_master.l_start_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
           END IF
           
           IF NOT cl_null(g_master.l_end_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
           END IF                         
           PREPARE astp825_rtjf_cnt FROM l_sql
          
           LET l_sql = "SELECT COUNT(*) ",
                       "  FROM rtjf_t ",
                       " WHERE rtjfent = ",g_enterprise,
                       "   AND rtjf105 = ? ",
                       "   AND EXISTS (SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) "
           IF NOT cl_null(g_master.l_start_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
           END IF
           
           IF NOT cl_null(g_master.l_end_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
           END IF                         
           PREPARE astp825_rtjf_cnt1 FROM l_sql
           
           LET l_sql = "SELECT UNIQUE rtjfdocno ",
                       "  FROM rtjf_t ",
                       " WHERE rtjfent = ",g_enterprise,
                       "   AND rtjf105 = ? ",
                       "   AND NOT EXISTS (SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) "
           IF NOT cl_null(g_master.l_start_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
           END IF
           
           IF NOT cl_null(g_master.l_end_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
           END IF                         
           PREPARE astp825_rtjf_err FROM l_sql  
           DECLARE astp825_rtjf_err_cur CURSOR FOR astp825_rtjf_err           
           
           #選取單號中未結算的底稿單號
           LET l_sql = "SELECT UNIQUE rtjf105 ",
                       "  FROM rtjf_t ",
                       " WHERE rtjfent =", g_enterprise,
                       "   AND EXISTS (SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) ",
                       "   AND EXISTS (SELECT 1 FROM stbc_t ",
                       "                WHERE rtjfent = stbcent ",
                       "                  AND rtjf105 = stbc004 ",
                       "                  AND stbc005 = '0' ",
                       "                  AND stbcstus = '1' ",
                       "                  AND stbc003 IN ('4','5')) "
           IF NOT cl_null(g_master.l_start_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
           END IF
           
           IF NOT cl_null(g_master.l_end_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
           END IF                         
           PREPARE astp825_sel_rtjf_pre FROM l_sql
           DECLARE astp825_sel_rtjf_cur CURSOR FOR astp825_sel_rtjf_pre
           FOREACH astp825_sel_rtjf_cur INTO l_rtjf105
              #全部交款單(同底稿單號)數量
              EXECUTE astp825_rtjf_cnt USING l_rtjf105 INTO l_cnt_1
              #有選取的交款單(同底稿單號)數量
              EXECUTE astp825_rtjf_cnt1 USING l_rtjf105 INTO l_cnt_2
              IF l_cnt_1 != l_cnt_2 THEN
                 FOREACH astp825_rtjf_err_cur USING l_rtjf105 INTO l_rtjfdocno
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ""
                    LET g_errparam.code =  'ast-00810'    
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = l_rtjf105
                    LET g_errparam.replace[2] = l_rtjfdocno
                    CALL cl_err() 
                    LET r_success = FALSE
                 END FOREACH
              ELSE
                 #刪除選取的結算底稿
                 DELETE FROM stbc_t 
                  WHERE stbcent = g_enterprise
                    AND stbc004 = l_rtjf105
                    AND stbc005 = 0
                    AND stbc003 IN ('4','5')
                    AND stbcstus = '1'
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = "Delete stbc_t:"
                    LET g_errparam.code =  SQLCA.sqlcode    
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET r_success = FALSE 
                 END IF
                 IF SQLCA.sqlerrd[3] >0 THEN
                    #更新交款狀態
                    UPDATE rtjf_t 
                       SET rtjf104 = 'Y',rtjf105 = ''            
                     WHERE rtjfent = g_enterprise
                       AND rtjf104 = 'F'
                       AND rtjf105 = l_rtjf105
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "UPDATE rtjf_t:"
                       LET g_errparam.code =  SQLCA.sqlcode    
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET r_success = FALSE            
                    END IF 
                 END IF                    
              END IF
           END FOREACH
           
           #選取單號中已結算的底稿單號
           LET l_sql = "SELECT UNIQUE rtjf105 ",
                       "  FROM rtjf_t ",
                       " WHERE rtjfent =", g_enterprise,
                       "   AND EXISTS (SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno) ",
                       "   AND EXISTS (SELECT 1 FROM stbc_t ",
                       "                WHERE rtjfent = stbcent ",
                       "                  AND rtjf105 = stbc004 ",
                       "                  AND stbc005 = '0' ",
                       "                  AND stbcstus != '1' ",
                       "                  AND stbc003 IN ('4','5')) "
           IF NOT cl_null(g_master.l_start_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 >= '",g_master.l_start_date,"' "
           END IF
           
           IF NOT cl_null(g_master.l_end_date) THEN 
              LET l_sql = l_sql, " AND rtjf025 <= '",g_master.l_end_date,"' "
           END IF                         
           PREPARE astp825_sel_rtjf_pre1 FROM l_sql
           DECLARE astp825_sel_rtjf_cur1 CURSOR FOR astp825_sel_rtjf_pre1
           FOREACH astp825_sel_rtjf_cur1 INTO l_rtjf105 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = ""
              LET g_errparam.code =  'ast-00801'    
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_rtjf105
              LET g_errparam.replace[2] = '0'
              LET r_success = FALSE
              CALL cl_err()              
           END FOREACH
        ELSE
           #刪除選取的結算底稿
           DELETE FROM stbc_t 
            WHERE stbcent = g_enterprise
              AND EXISTS(SELECT 1 FROM astp825_tmp WHERE rtjadocno = stbc004)         
              AND stbc003 IN ('4','5')
              AND stbcstus = '1'
              AND EXISTS(SELECT 1 FROM rtjf_t 
                          WHERE rtjfent = stbcent
                            AND rtjfdocno = stbc004
                            AND rtjfseq1 = stbc005
                            AND rtjf104 = 'F'
                            AND (rtjf105 != '' OR rtjf105 IS NOT NULL))
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "Delete stbc_t:"
               LET g_errparam.code =  SQLCA.sqlcode    
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE 
            END IF
            
            IF SQLCA.sqlerrd[3] >0 THEN
               #更新交款狀態
               UPDATE rtjf_t 
                  SET rtjf104 = 'Y',rtjf105 = ''            
                WHERE rtjfent = g_enterprise
                  AND rtjf104 = 'F'
                  AND (rtjf105 != '' OR rtjf105 IS NOT NULL)
                  AND EXISTS(SELECT 1 FROM astp825_tmp WHERE rtjadocno = rtjfdocno)      
                  AND NOT EXISTS(SELECT 1 FROM stbc_t 
                              WHERE stbcent = g_enterprise
                                AND stbc003 IN ('4','5')
                                AND stbc004 = rtjfdocno
                                AND stbc005 = rtjfseq1   
                                AND stbcstus != '1')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "UPDATE rtjf_t:"
                  LET g_errparam.code =  SQLCA.sqlcode    
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE            
               END IF              
           END IF
                                        
           LET l_sql = " SELECT stbc004,stbc005 ",
                       "   FROM stbc_t ",
                       "  WHERE stbcent = ",g_enterprise,
                       "    AND EXISTS(SELECT 1 FROM astp825_tmp WHERE rtjadocno = stbc004) ",
                       "    AND stbcstus != '1' ",
                       "    AND stbc003 IN ('4','5') " 
           PREPARE astp825_sel_stbc_pre FROM l_sql
           DECLARE astp825_sel_stbc_cur CURSOR FOR astp825_sel_stbc_pre
           FOREACH astp825_sel_stbc_cur INTO l_stbc004,l_stbc005
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = ""
              LET g_errparam.code =  'ast-00801'    
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_stbc004
              LET g_errparam.replace[2] = l_stbc005
              LET r_success = FALSE
              CALL cl_err()                 
           END FOREACH
        END IF                  
        #迴圈報錯 
        #160513-00037#26 Add By Ken 160604(S)        
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身欄位開啟
# Memo...........:
# Usage..........: CALL astp825_set_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/06/11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp825_set_entry_b()
      CALL cl_set_comp_entry("b_rtjasite",TRUE)      #營運據點
      CALL cl_set_comp_entry("b_rtjadocdt",TRUE)     #單據日期
      CALL cl_set_comp_entry("b_rtjadocno",TRUE)     #單據編號
      CALL cl_set_comp_entry("b_rtja101",TRUE)       #鋪位編號(租賃)
      CALL cl_set_comp_entry("b_rtja102",TRUE)       #商戶編號(租賃)
      CALL cl_set_comp_entry("b_rtja106",TRUE)       #銷售合約金額(租賃)
      CALL cl_set_comp_entry("l_rtjc013_sum",TRUE)   #折讓金額      
      CALL cl_set_comp_entry("b_rtja049",TRUE)       #本幣含稅應收金額
      CALL cl_set_comp_entry("l_rtjf003_sum",TRUE)   #本次結算金額  
      CALL cl_set_comp_entry("l_rtja031_diff",TRUE)  #含稅應收金額      
END FUNCTION

################################################################################
# Descriptions...: 單身欄位開啟
# Memo...........:
# Usage..........: CALL astp825_set_no_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/06/11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp825_set_no_entry_b()
      CALL cl_set_comp_entry("b_rtjasite",FALSE)      #營運據點
      CALL cl_set_comp_entry("b_rtjadocdt",FALSE)     #單據日期
      CALL cl_set_comp_entry("b_rtjadocno",FALSE)     #單據編號
      CALL cl_set_comp_entry("b_rtja101",FALSE)       #鋪位編號(租賃)
      CALL cl_set_comp_entry("b_rtja102",FALSE)       #商戶編號(租賃)
      CALL cl_set_comp_entry("b_rtja106",FALSE)       #銷售合約金額(租賃)
      CALL cl_set_comp_entry("l_rtjc013_sum",FALSE)   #折讓金額      
      CALL cl_set_comp_entry("b_rtja049",FALSE)       #本幣含稅應收金額
      CALL cl_set_comp_entry("l_rtjf003_sum",FALSE)   #本次結算金額  
      CALL cl_set_comp_entry("l_rtja031_diff",FALSE)  #含稅應收金額       
END FUNCTION

################################################################################
# Descriptions...: 檢查該筆是否被lock
# Memo...........: #170109-00037#16
# Usage..........: CALL astp825_lock_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2017/01/12  By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION astp825_lock_chk()
DEFINE l_rtjadocno LIKE rtja_t.rtjadocno
       
   EXECUTE astp825_chk_lock_rtja USING g_detail_d[l_ac].b_rtjadocno
                                 INTO l_rtjadocno
   IF cl_null(l_rtjadocno) THEN
      LET g_detail_d[l_ac].sel = 'N'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00868'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_detail_d[l_ac].b_rtjadocno
      CALL cl_err()
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 

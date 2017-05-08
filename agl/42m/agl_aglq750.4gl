#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq750.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000065
#+ 
#+ Filename...: aglq750
#+ Description: 總分類帳(核算項)查詢作業
#+ Creator....: 02599(2014/03/27)
#+ Modifier...: 02599(2014/03/28)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq750.global" >}
#151204-00013#5    2016/01/12   By 02599   当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#160302-00006#1    2016/03/02   By 07675   原本单身为可查询作业，增加二次筛选功能 
#160503-00037#5    2016/05/09   By 07900   本年累计数不应含期初第0期的数据
#160511-00006#2    2016/05/11   By 02599   期初只显示余额，借方金额、贷方金额不显示；本年累计的余额=本年累计+年初余额
#160824-00004#2    2016/08/31   By 02599   排除XC凭证时限定科目费用类别glac010<>N.非费用科目
#160913-00017#3    2016/09/21   By 07900   AGL模组调整交易客商开窗
#160824-00004#4    2016/09/23   By 02599   排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161011-00018#1    2016/10/14   By 02599   去除 first next last jump previous 这些action的权限检核
#161021-00037#2    2016/10/24   By 06821   組織類型與職能開窗調整
#161027-00022#1    2016/10/27   By 02599   含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型。
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar012 LIKE glar_t.glar012, 
   glar012_desc LIKE type_t.chr500, 
   glar013 LIKE glar_t.glar013, 
   glar013_desc LIKE type_t.chr500, 
   glar014 LIKE glar_t.glar014, 
   glar014_desc LIKE type_t.chr500, 
   glar015 LIKE glar_t.glar015, 
   glar015_desc LIKE type_t.chr500, 
   glar016 LIKE glar_t.glar016, 
   glar016_desc LIKE type_t.chr500, 
   glar017 LIKE glar_t.glar017, 
   glar017_desc LIKE type_t.chr500, 
   glar018 LIKE glar_t.glar018, 
   glar018_desc LIKE type_t.chr500, 
   glar019 LIKE glar_t.glar019, 
   glar019_desc LIKE type_t.chr500,
   glar051 LIKE glar_t.glar051, 
   glar052 LIKE glar_t.glar052, 
   glar052_desc LIKE type_t.chr500,
   glar053 LIKE glar_t.glar053, 
   glar053_desc LIKE type_t.chr500,   
   glar020 LIKE glar_t.glar020, 
   glar020_desc LIKE type_t.chr500,  
   glar022 LIKE glar_t.glar022, 
   glar022_desc LIKE type_t.chr500,
   glar023 LIKE glar_t.glar023, 
   glar023_desc LIKE type_t.chr500,
   glar024 LIKE glar_t.glar024, 
   glar024_desc LIKE type_t.chr500, 
   glar025 LIKE glar_t.glar025,
   glar025_desc LIKE type_t.chr500,
   glar026 LIKE glar_t.glar026,
   glar026_desc LIKE type_t.chr500,
   glar027 LIKE glar_t.glar027, 
   glar027_desc LIKE type_t.chr500, 
   glar028 LIKE glar_t.glar028,
   glar028_desc LIKE type_t.chr500,
   glar029 LIKE glar_t.glar029,
   glar029_desc LIKE type_t.chr500,
   glar030 LIKE glar_t.glar030, 
   glar030_desc LIKE type_t.chr500, 
   glar031 LIKE glar_t.glar031,
   glar031_desc LIKE type_t.chr500,
   glar032 LIKE glar_t.glar032,
   glar032_desc LIKE type_t.chr500,
   glar033 LIKE glar_t.glar033,
   glar033_desc LIKE type_t.chr500,
   glar003 LIKE type_t.chr80, 
   style LIKE type_t.chr80, 
   glar005 LIKE glar_t.glar005, 
   glar006 LIKE glar_t.glar006, 
   glar034 LIKE glar_t.glar034, 
   glar035 LIKE glar_t.glar035, 
   glar036 LIKE glar_t.glar036, 
   glar037 LIKE glar_t.glar037, 
   state LIKE type_t.chr80, 
   amt1 LIKE glaq_t.glaq003, 
   amt2 LIKE glaq_t.glaq003, 
   amt3 LIKE glaq_t.glaq003 
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       year            LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       eperiod         LIKE glap_t.glap004,    #截止期別
       acc_p           LIKE type_t.chr1,       #按科目分頁
       ctype           LIKE type_t.chr1,       #多本位幣
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad        LIKE type_t.chr1,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1,
       comp            LIKE type_t.chr1,
       glad007         LIKE type_t.chr1,
       glad008         LIKE type_t.chr1,
       glad009         LIKE type_t.chr1,
       glad010         LIKE type_t.chr1,
       glad027         LIKE type_t.chr1,
       glad011         LIKE type_t.chr1,
       glad012         LIKE type_t.chr1,
       glad031         LIKE type_t.chr1,
       glad032         LIKE type_t.chr1,
       glad033         LIKE type_t.chr1,
       glad013         LIKE type_t.chr1,
       glad015         LIKE type_t.chr1,
       glad016         LIKE type_t.chr1,
       glad017         LIKE type_t.chr1,
       glad018         LIKE type_t.chr1,
       glad019         LIKE type_t.chr1,
       glad020         LIKE type_t.chr1,
       glad021         LIKE type_t.chr1,
       glad022         LIKE type_t.chr1,
       glad023         LIKE type_t.chr1,
       glad024         LIKE type_t.chr1,
       glad025         LIKE type_t.chr1,
       glad026         LIKE type_t.chr1
       END RECORD
DEFINE g_glar001       LIKE glar_t.glar001
DEFINE g_glar_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glar001         LIKE glar_t.glar001
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_max_period    LIKE glap_t.glap004
DEFINE g_wc_glar001    STRING
DEFINE g_argv_flag     LIKE type_t.num5    #標示是否是串查
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq750.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aglq750_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq750_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq750 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq750_init()   
 
      #進入選單 Menu (="N")
      CALL aglq750_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq750
      
   END IF 
   
   CLOSE aglq750_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq750_tmp
   DROP TABLE aglq750_tmp_xg
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq750.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq750_init()
   #add-point:init段define
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('state','9926')
   CALL cl_set_combo_scc('style','9927')
   #抓取傳參
   CALL aglq750_default_search()
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq750_glaald_desc(g_glaald)
   
   IF cl_null(g_argv[01]) THEN
      LET g_argv_flag = FALSE
      CALL aglq750_set_default_value()
   ELSE
      LET g_argv_flag = TRUE
   END IF
   #建立临时表
   CALL aglq750_create_temp_table()
   CALL cl_set_combo_scc('b_glar051','6013')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq750.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq750_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define

   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   CALL aglq750_query()
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glar_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aglq750_fetch()
               #add-point:input段before row
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glar_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段define

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            #上下筆按鈕顯示否設置
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE) 
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE) 
                  CALL cl_set_act_visible("jump,next,last", TRUE) 
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE) 
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE) 
                     CALL cl_set_act_visible("next,last", FALSE) 
                  END IF
               END IF
            END IF
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
            NEXT FIELD sel
      
         
 
         ON ACTION last
 
            LET g_action_choice="fetch" #161011-00018#1 mod last-->fetch
#            IF cl_auth_chk_act("last") THEN  #161011-00018#1 mark
               #add-point:ON ACTION last
               CALL aglq750_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION jump
 
            LET g_action_choice="fetch" #161011-00018#1 mod jump-->fetch
#            IF cl_auth_chk_act("jump") THEN #161011-00018#1 mark
               #add-point:ON ACTION jump
               CALL aglq750_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               CALL aglq750_output()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION exchange_ld
 
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN 
               #add-point:ON ACTION exchange_ld
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glar_s.clear()
                  CALL g_glar_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq750_glaald_desc(g_glaald)
               CALL aglq750_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION previous
 
            LET g_action_choice="fetch" #161011-00018#1 mod previous-->fetch
#            IF cl_auth_chk_act("previous") THEN  #161011-00018#1 mark
               #add-point:ON ACTION previous
               CALL aglq750_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq750_query()
               #add-point:ON ACTION query
               EXIT DIALOG
               #END add-point
            END IF
 
 
         ON ACTION next
 
            LET g_action_choice="fetch" #161011-00018#1 mod next-->fetch
#            IF cl_auth_chk_act("next") THEN  #161011-00018#1 mark 
               #add-point:ON ACTION next
               CALL aglq750_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION first
 
            LET g_action_choice="fetch" #161011-00018#1 mod first-->fetch
#            IF cl_auth_chk_act("first") THEN  #161011-00018#1 mark
               #add-point:ON ACTION first
               CALL aglq750_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
      
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq750_glaald_desc(g_glaald)
            CALL aglq750_set_default_value()
            CALL aglq750_query()
            EXIT DIALOG
            
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  CALL aglq750_cmdrun() #串查aglq770明細分類帳(核算项)資料                   
               END IF
               EXIT DIALOG
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq750_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aglq750_b_fill()
            CALL aglq750_fetch()
            
          ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF             
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq750_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5    
   
   #建立临时表
   CALL aglq750_create_temp_table()
   
   #從aglq720串查資料
   IF g_argv_flag = TRUE THEN 
      LET g_argv_flag = FALSE
      CALL aglq750_visible()
      CALL cl_set_comp_visible('group3',FALSE)
      CALL aglq750_show()   
      CALL aglq750_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq750_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq750_set_page()
      CALL aglq750_fetch1('F')      
      RETURN
   END IF
   
   LET l_flag=TRUE
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019, 
          glar051,glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,glar027,glar028,glar029,
          glar030,glar031,glar032,glar033
           FROM s_detail1[1].b_glar012,s_detail1[1].b_glar013,s_detail1[1].b_glar014, 
               s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017,s_detail1[1].b_glar018, 
               s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,s_detail1[1].b_glar053,
               s_detail1[1].b_glar020,s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].b_glar024,
               s_detail1[1].b_glar025,s_detail1[1].b_glar026,s_detail1[1].b_glar027,s_detail1[1].b_glar028,
               s_detail1[1].b_glar029,s_detail1[1].b_glar030,s_detail1[1].b_glar031,s_detail1[1].b_glar032,
               s_detail1[1].b_glar033
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
 
 

 

         #----<<b_glar012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar012
            #add-point:BEFORE FIELD b_glar012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar012
            
            #add-point:AFTER FIELD b_glar012

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glar012
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            NEXT FIELD b_glar012
            #END add-point
 
         #----<<b_glar013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar013
            #add-point:BEFORE FIELD b_glar013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar013
            
            #add-point:AFTER FIELD b_glar013

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glar013
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

            NEXT FIELD b_glar013 
            #END add-point
 
         #----<<b_glar014>>----
         #Ctrlp:construct.c.page1.b_glar014
         ON ACTION controlp INFIELD b_glar014
            #add-point:ON ACTION controlp INFIELD b_glar014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar014  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

            NEXT FIELD b_glar014                #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar014
            #add-point:BEFORE FIELD b_glar014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar014
            
            #add-point:AFTER FIELD b_glar014

            #END add-point
            
 
         #----<<b_glar015>>----
         #Ctrlp:construct.c.page1.b_glar015
         ON ACTION controlp INFIELD b_glar015
            #add-point:ON ACTION controlp INFIELD b_glar015
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar015  #顯示到畫面上
            NEXT FIELD b_glar015                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar015
            #add-point:BEFORE FIELD b_glar015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar015
            
            #add-point:AFTER FIELD b_glar015

            #END add-point
            
 
         #----<<b_glar016>>----
         #Ctrlp:construct.c.page1.b_glar016
         ON ACTION controlp INFIELD b_glar016
            #add-point:ON ACTION controlp INFIELD b_glar016
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar016  #顯示到畫面上
            NEXT FIELD b_glar016                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar016
            #add-point:BEFORE FIELD b_glar016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar016
            
            #add-point:AFTER FIELD b_glar016

            #END add-point
            
 
         #----<<b_glar017>>----
         #Ctrlp:construct.c.page1.b_glar017
         ON ACTION controlp INFIELD b_glar017
            #add-point:ON ACTION controlp INFIELD b_glar017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar017  #顯示到畫面上
            NEXT FIELD b_glar017                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar017
            #add-point:BEFORE FIELD b_glar017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar017
            
            #add-point:AFTER FIELD b_glar017

            #END add-point
            
 
         #----<<b_glar018>>----
         #Ctrlp:construct.c.page1.b_glar018
         ON ACTION controlp INFIELD b_glar018
            #add-point:ON ACTION controlp INFIELD b_glar018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar018  #顯示到畫面上
            NEXT FIELD b_glar018                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar018
            #add-point:BEFORE FIELD b_glar018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar018
            
            #add-point:AFTER FIELD b_glar018

            #END add-point
            
 
         #----<<b_glar019>>----
         #Ctrlp:construct.c.page1.b_glar019
         ON ACTION controlp INFIELD b_glar019
            #add-point:ON ACTION controlp INFIELD b_glar019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar019  #顯示到畫面上
            NEXT FIELD b_glar019                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar019
            #add-point:BEFORE FIELD b_glar019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar019
            
            #add-point:AFTER FIELD b_glar019

            #END add-point
            
 
         #----<<b_glar020>>----
         #Ctrlp:construct.c.page1.b_glar020
         ON ACTION controlp INFIELD b_glar020
            #add-point:ON ACTION controlp INFIELD b_glar020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar020  #顯示到畫面上
            NEXT FIELD b_glar020                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar020
            #add-point:BEFORE FIELD b_glar020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar020
            
            #add-point:AFTER FIELD b_glar020

            #END add-point
            
 
         #----<<b_glar052>>----
         #Ctrlp:construct.c.page1.b_glar052
         ON ACTION controlp INFIELD b_glar052
            #add-point:ON ACTION controlp INFIELD b_glar052
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar052  #顯示到畫面上
            NEXT FIELD b_glar052                     #返回原欄位
    
         ON ACTION controlp INFIELD b_glar053
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar053  #顯示到畫面上
            NEXT FIELD b_glar053    
            
        ON ACTION controlp INFIELD b_glar022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022     #顯示到畫面上
            NEXT FIELD b_glar022                     #返回原欄位
        
       ON ACTION controlp INFIELD b_glar023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上

            NEXT FIELD b_glar023   
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar052
            #add-point:BEFORE FIELD b_glar052

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar052
            
            #add-point:AFTER FIELD b_glar052

            #END add-point
            
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      CONSTRUCT g_wc_glar001 ON glar001 FROM s_detail1[1].b_glar001
         BEFORE CONSTRUCT
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001

            #END add-point
      END CONSTRUCT
      INPUT BY NAME tm.year,tm.speriod,tm.eperiod,tm.acc_p,tm.ctype,tm.show_acc,tm.glac005,tm.stus,
                    tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,tm.comp,tm.glad007,tm.glad008,tm.glad009,
                    tm.glad010,tm.glad027,tm.glad011,tm.glad012,tm.glad031,tm.glad032,tm.glad033,
                    tm.glad013,tm.glad015,tm.glad016,tm.glad017,tm.glad018,tm.glad019,tm.glad020,
                    tm.glad021,tm.glad022,tm.glad023,tm.glad024,tm.glad025,tm.glad026
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD year
            IF not cl_null(tm.year) THEN
               #獲取現行會計週期最大期別
               SELECT MAX(glav006) INTO g_max_period FROM glav_t 
               WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.year
            END IF
            
         AFTER FIELD speriod
            IF NOT cl_ap_chk_Range(tm.speriod,"0","1",g_max_period,"1","azz-00087",1) THEN
               NEXT FIELD speriod
            END IF
            IF NOT cl_null(tm.speriod) AND NOT cl_null(tm.eperiod) AND (tm.speriod>tm.eperiod) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00227'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD speriod
            END IF
            
         AFTER FIELD eperiod
            IF NOT cl_ap_chk_Range(tm.eperiod,"0","1",g_max_period,"1","azz-00087",1) THEN
               NEXT FIELD eperiod
            END IF
            IF NOT cl_null(tm.speriod) AND NOT cl_null(tm.eperiod) AND (tm.speriod>tm.eperiod) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00228'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD eperiod
            END IF
         
         AFTER FIELD acc_p
            IF tm.acc_p NOT MATCHES '[yYnN]' THEN
               NEXT FIELD acc_p
            END IF
            
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq750_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         AFTER FIELD show_acc
            IF tm.show_acc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_acc
            END IF
         
         AFTER FIELD glac005
            IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         AFTER FIELD glac009
            IF tm.glac009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
          
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
            
         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
         ON CHANGE comp
            IF tm.comp NOT MATCHES '[yYnN]' THEN
               NEXT FIELD comp
            END IF
            IF tm.comp='Y' THEN
               CALL cl_set_comp_visible("b_glar012,b_glar012_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar012,b_glar012_desc",FALSE)
            END IF
            
         ON CHANGE glad007
            IF tm.glad007 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad007
            END IF
            IF tm.glad007='Y' THEN
               CALL cl_set_comp_visible("b_glar013,b_glar013_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar013,b_glar013_desc",FALSE)
            END IF
            
         ON CHANGE glad008
            IF tm.glad008 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad008
            END IF
            IF tm.glad008='Y' THEN
               CALL cl_set_comp_visible("b_glar014,b_glar014_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar014,b_glar014_desc",FALSE)
            END IF
            
         ON CHANGE glad009
            IF tm.glad009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad009
            END IF
            IF tm.glad009='Y' THEN
               CALL cl_set_comp_visible("b_glar015,b_glar015_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar015,b_glar015_desc",FALSE)
            END IF
         
         ON CHANGE glad010
            IF tm.glad010 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad010
            END IF
            IF tm.glad010='Y' THEN
               CALL cl_set_comp_visible("b_glar016,b_glar016_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar016,b_glar016_desc",FALSE)
            END IF
            
         ON CHANGE glad027
            IF tm.glad027 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad027
            END IF
            IF tm.glad027='Y' THEN
               CALL cl_set_comp_visible("b_glar017,b_glar017_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar017,b_glar017_desc",FALSE)
            END IF
            
         ON CHANGE glad011
            IF tm.glad011 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad011
            END IF
            IF tm.glad011='Y' THEN
               CALL cl_set_comp_visible("b_glar018,b_glar018_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar018,b_glar018_desc",FALSE)
            END IF
            
         ON CHANGE glad012
            IF tm.glad012 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad012
            END IF
            IF tm.glad012='Y' THEN
               CALL cl_set_comp_visible("b_glar019,b_glar019_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar019,b_glar019_desc",FALSE)
            END IF
         
         #經營方式
         ON CHANGE glad031
            IF tm.glad031 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad031
            END IF
            IF tm.glad031='Y' THEN
               CALL cl_set_comp_visible("b_glar051",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar051",FALSE)
            END IF
            
         #渠道
         ON CHANGE glad032
            IF tm.glad032 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad032
            END IF
            IF tm.glad032='Y' THEN
               CALL cl_set_comp_visible("b_glar052,b_glar052_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar052,b_glar052_desc",FALSE)
            END IF
            
         #品牌
         ON CHANGE glad033
            IF tm.glad033 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad033
            END IF
            IF tm.glad033='Y' THEN
               CALL cl_set_comp_visible("b_glar053,b_glar053_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar053,b_glar053_desc",FALSE)
            END IF
            
         ON CHANGE glad013
            IF tm.glad013 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad013
            END IF
            IF tm.glad013='Y' THEN
               CALL cl_set_comp_visible("b_glar020,b_glar020_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar020,b_glar020_desc",FALSE)
            END IF 
         
#         ON CHANGE glad014
#            IF tm.glad014 NOT MATCHES '[yYnN]' THEN
#               NEXT FIELD glad014
#            END IF
#            IF tm.glad014='Y' THEN
#               CALL cl_set_comp_visible("b_glar021,b_glar021_desc",TRUE)
#            ELSE
#               CALL cl_set_comp_visible("b_glar021,b_glar021_desc",FALSE)
#            END IF

         ON CHANGE glad015
            IF tm.glad015 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad015
            END IF
            IF tm.glad015='Y' THEN
               CALL cl_set_comp_visible("b_glar022,b_glar022_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar022,b_glar022_desc",FALSE)
            END IF
            
         ON CHANGE glad016
            IF tm.glad016 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad016
            END IF
            IF tm.glad016='Y' THEN
               CALL cl_set_comp_visible("b_glar023,b_glar023_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar023,b_glar023_desc",FALSE)
            END IF
            
         ON CHANGE glad017
            IF tm.glad017 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad017
            END IF
            IF tm.glad017='Y' THEN
               CALL cl_set_comp_visible("b_glar024,b_glar024_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar024,b_glar024_desc",FALSE)
            END IF
            
         ON CHANGE glad018
            IF tm.glad018 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad018
            END IF
            IF tm.glad018='Y' THEN
               CALL cl_set_comp_visible("b_glar025,b_glar025_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar025,b_glar025_desc",FALSE)
            END IF
            
         ON CHANGE glad019
            IF tm.glad019 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad019
            END IF
            IF tm.glad019='Y' THEN
               CALL cl_set_comp_visible("b_glar026,b_glar026_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar026,b_glar026_desc",FALSE)
            END IF
            
         ON CHANGE glad020
            IF tm.glad020 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad020
            END IF
            IF tm.glad020='Y' THEN
               CALL cl_set_comp_visible("b_glar027,b_glar027_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar027,b_glar027_desc",FALSE)
            END IF
            
         ON CHANGE glad021
            IF tm.glad021 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad021
            END IF
            IF tm.glad021='Y' THEN
               CALL cl_set_comp_visible("b_glar028,b_glar028_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar028,b_glar028_desc",FALSE)
            END IF
            
         ON CHANGE glad022
            IF tm.glad022 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad022
            END IF
            IF tm.glad022='Y' THEN
               CALL cl_set_comp_visible("b_glar029,b_glar029_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar029,b_glar029_desc",FALSE)
            END IF
            
         ON CHANGE glad023
            IF tm.glad023 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad023
            END IF
            IF tm.glad023='Y' THEN
               CALL cl_set_comp_visible("b_glar030,b_glar030_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar030,b_glar030_desc",FALSE)
            END IF
            
         ON CHANGE glad024
            IF tm.glad024 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad024
            END IF
            IF tm.glad024='Y' THEN
               CALL cl_set_comp_visible("b_glar031,b_glar031_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar031,b_glar031_desc",FALSE)
            END IF
            
         ON CHANGE glad025
            IF tm.glad025 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad025
            END IF
            IF tm.glad025='Y' THEN
               CALL cl_set_comp_visible("b_glar032,b_glar032_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar032,b_glar032_desc",FALSE)
            END IF
            
         ON CHANGE glad026
            IF tm.glad026 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad026
            END IF
            IF tm.glad026='Y' THEN
               CALL cl_set_comp_visible("b_glar033,b_glar033_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glar033,b_glar033_desc",FALSE)
            END IF
            
         AFTER INPUT 
            IF NOT cl_null(tm.speriod) AND NOT cl_ap_chk_Range(tm.speriod,"0","1",g_max_period,"1","azz-00087",1) THEN
               NEXT FIELD speriod
            END IF
            
            IF NOT cl_null(tm.eperiod) AND NOT cl_ap_chk_Range(tm.eperiod,"0","1",g_max_period,"1","azz-00087",1) THEN
               NEXT FIELD eperiod
            END IF
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL cl_set_comp_visible('group3',TRUE)
        CALL aglq750_show()
        
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         CALL aglq750_glaald_desc(g_glaald)
         CALL aglq750_set_default_value()
         CALL cl_set_comp_visible('group3',TRUE)
         CALL aglq750_show()
      #end add-point 
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET l_flag=FALSE
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   IF l_flag=TRUE THEN
      CALL cl_set_comp_visible('group3',FALSE)
      CALL aglq750_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq750_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq750_set_page()
      CALL aglq750_fetch1('F')
   ELSE
      CALL aglq750_b_fill1()
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
      DISPLAY g_detail_idx TO FORMONLY.idx
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aglq750_b_fill()
   LET l_ac = g_master_idx
   CALL aglq750_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq750.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq750_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   RETURN
   #end add-point
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET g_sql = "SELECT  UNIQUE glar001,'',glar012,'',glar013,'',glar014,'',glar015,'',glar016,'',glar017, 
       '',glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,glar023,'','','','','','','','','','', 
       '','' FROM glar_t",
 
 
               "",
               " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
  
   #add-point:b_fill段sql_after

   #end add-point
  
   PREPARE aglq750_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq750_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar012, 
       g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,g_glar_d[l_ac].glar014, 
       g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,g_glar_d[l_ac].glar016, 
       g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,g_glar_d[l_ac].glar018, 
       g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,g_glar_d[l_ac].glar051,
       g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc,
       g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,g_glar_d[l_ac].glar022, 
       g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar003,g_glar_d[l_ac].style,g_glar_d[l_ac].glar005,g_glar_d[l_ac].glar006, 
       g_glar_d[l_ac].glar034,g_glar_d[l_ac].glar035,g_glar_d[l_ac].glar036,g_glar_d[l_ac].glar037,g_glar_d[l_ac].state, 
       g_glar_d[l_ac].amt1,g_glar_d[l_ac].amt2,g_glar_d[l_ac].amt3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_glar_d[l_ac].sel = "N"
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL aglq750_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq750_pb
   
   LET l_ac = 1
   CALL aglq750_fetch()
   
      CALL aglq750_filter_show('glar001','b_glar001')
   CALL aglq750_filter_show('glar012','b_glar012')
   CALL aglq750_filter_show('glar013','b_glar013')
   CALL aglq750_filter_show('glar014','b_glar014')
   CALL aglq750_filter_show('glar015','b_glar015')
   CALL aglq750_filter_show('glar016','b_glar016')
   CALL aglq750_filter_show('glar017','b_glar017')
   CALL aglq750_filter_show('glar018','b_glar018')
   CALL aglq750_filter_show('glar019','b_glar019')
   CALL aglq750_filter_show('glar051','b_glar051')
   CALL aglq750_filter_show('glar052','b_glar052')
   CALL aglq750_filter_show('glar053','b_glar053')
   CALL aglq750_filter_show('glar020','b_glar020')
   CALL aglq750_filter_show('glar022','b_glar022')
   CALL aglq750_filter_show('glar023','b_glar023')
   CALL aglq750_filter_show('glar003','b_glar023')
   CALL aglq750_filter_show('glar005','b_glar023')
   CALL aglq750_filter_show('glar006','b_glar023')
   CALL aglq750_filter_show('glar034','b_glar023')
   CALL aglq750_filter_show('glar035','b_glar023')
   CALL aglq750_filter_show('glar036','b_glar023')
   CALL aglq750_filter_show('glar037','b_glar023')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq750.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq750_fetch()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:fetch段define
   RETURN
   #end add-point
   
 
   
   LET li_ac = l_ac 
   
 
   
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #add-point:單身填充後
   
   #end add-point 
   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq750.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq750_detail_show()
   #add-point:show段define
   DEFINE l_glad0171     LIKE glad_t.glad0171
   DEFINE l_glad0181     LIKE glad_t.glad0181
   DEFINE l_glad0191     LIKE glad_t.glad0191
   DEFINE l_glad0201     LIKE glad_t.glad0201
   DEFINE l_glad0211     LIKE glad_t.glad0211
   DEFINE l_glad0221     LIKE glad_t.glad0221
   DEFINE l_glad0231     LIKE glad_t.glad0231
   DEFINE l_glad0241     LIKE glad_t.glad0241
   DEFINE l_glad0251     LIKE glad_t.glad0251
   DEFINE l_glad0261     LIKE glad_t.glad0261
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
    #科目編號
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glar_d[l_ac].glar001
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glar_d[l_ac].glar001_desc=g_rtn_fields[1]
   #營運據點
   IF tm.comp='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glar_d[l_ac].glar012
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar012_desc=g_rtn_fields[1]
   END IF
   #部門
   IF tm.glad007='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glar_d[l_ac].glar013
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar013_desc=g_rtn_fields[1]
   END IF
   #成本中心
   IF tm.glad008='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glar_d[l_ac].glar014
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar014_desc=g_rtn_fields[1]
   END IF
   #區域
   IF tm.glad009='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = g_glar_d[l_ac].glar015
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar015_desc=g_rtn_fields[1] 
   END IF
   #交易客戶
   IF tm.glad010='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glar_d[l_ac].glar016
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar016_desc=g_rtn_fields[1]
   END IF
   #帳款客戶
   IF tm.glad027='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glar_d[l_ac].glar017
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar017_desc=g_rtn_fields[1]
   END IF
   #客群   
   IF tm.glad011='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = g_glar_d[l_ac].glar018
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar018_desc=g_rtn_fields[1] 
   END IF
   #產品類別
   IF tm.glad012='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glar_d[l_ac].glar019
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar019_desc=g_rtn_fields[1]
   END IF
   #人員編號
   IF tm.glad013='Y' THEN
      SELECT ooag011 INTO g_glar_d[l_ac].glar020_desc FROM ooag_t 
      WHERE ooagent = g_enterprise AND ooag001 = g_glar_d[l_ac].glar020
   END IF
#   #預算編號
#   IF tm.glad014='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_glar_d[l_ac].glar021
#      CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar021_desc=g_rtn_fields[1]
#   END IF
   #渠道
   IF tm.glad032='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glar_d[l_ac].glar052
      CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar052_desc=g_rtn_fields[1]
   END IF
   #品牌
   IF tm.glad033='Y' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '2002'
      LET g_ref_fields[2] = g_glar_d[l_ac].glar053
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glar_d[l_ac].glar053_desc=g_rtn_fields[1] 
   END IF
   #專案
   IF tm.glad015='Y' THEN
      CALL s_desc_get_project_desc(g_glar_d[l_ac].glar022) RETURNING g_glar_d[l_ac].glar022_desc
   END IF
   
   #WBS
   IF tm.glad016='Y' THEN
      CALL s_desc_get_wbs_desc(g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar023) RETURNING g_glar_d[l_ac].glar023_desc
   END IF
   
   #自由核算項
   SELECT glad0171,glad0181,glad0191,glad0201,glad0211,glad0221,
          glad0231,glad0221,glad0251,glad0261
    INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,l_glad0221,
          l_glad0231,l_glad0241,l_glad0251,l_glad0261
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_glaald
      AND glad001 = g_glar_d[l_ac].glar001
   IF tm.glad017='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0171,g_glar_d[l_ac].glar024) RETURNING g_glar_d[l_ac].glar024_desc
   END IF
   IF tm.glad018='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0181,g_glar_d[l_ac].glar025) RETURNING g_glar_d[l_ac].glar025_desc
   END IF
   IF tm.glad019='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0191,g_glar_d[l_ac].glar026) RETURNING g_glar_d[l_ac].glar026_desc
   END IF
   IF tm.glad020='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0201,g_glar_d[l_ac].glar027) RETURNING g_glar_d[l_ac].glar027_desc
   END IF
   IF tm.glad021='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0211,g_glar_d[l_ac].glar028) RETURNING g_glar_d[l_ac].glar028_desc
   END IF
   IF tm.glad022='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0221,g_glar_d[l_ac].glar029) RETURNING g_glar_d[l_ac].glar029_desc
   END IF
   IF tm.glad023='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0231,g_glar_d[l_ac].glar030) RETURNING g_glar_d[l_ac].glar030_desc
   END IF
   IF tm.glad024='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0241,g_glar_d[l_ac].glar031) RETURNING g_glar_d[l_ac].glar031_desc
   END IF
   IF tm.glad025='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0251,g_glar_d[l_ac].glar032) RETURNING g_glar_d[l_ac].glar032_desc
   END IF
   IF tm.glad026='Y' THEN 
      CALL s_voucher_free_account_desc(l_glad0261,g_glar_d[l_ac].glar033) RETURNING g_glar_d[l_ac].glar033_desc
   END IF
   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq750_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point    
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
#      CONSTRUCT g_wc_filter ON glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019, 
#          glar051,glar052,glar053,glar020,glar022,glar023,glar003,glar005,glar006,glar034,glar035,
#          glar036,glar037
#                              
#                          FROM s_detail1[1].b_glar001,s_detail1[1].b_glar012,s_detail1[1].b_glar013, 
#                              s_detail1[1].b_glar014,s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017, 
#                              s_detail1[1].b_glar018,s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,
#                              s_detail1[1].b_glar053,s_detail1[1].b_glar020, 
#                              s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].b_glar023,s_detail1[1].b_glar023, 
#                              s_detail1[1].b_glar023,s_detail1[1].b_glar023,s_detail1[1].b_glar023,s_detail1[1].b_glar023, 
#                              s_detail1[1].b_glar023
                               
      CONSTRUCT g_wc_filter ON glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019, 
          glar051,glar052,glar053,glar020,glar022,glar023,glar034,glar035,
          glar036,glar037
                            FROM s_detail1[1].b_glar001,s_detail1[1].b_glar012,s_detail1[1].b_glar013, 
                                 s_detail1[1].b_glar014,s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017, 
                                 s_detail1[1].b_glar018,s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,
                                 s_detail1[1].b_glar053,s_detail1[1].b_glar020, 
                                 s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].glar034,s_detail1[1].glar035,
                                 s_detail1[1].glar036, s_detail1[1].glar037
 
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            DISPLAY aglq750_filter_parser('glar001') TO s_detail1[1].b_glar001
            DISPLAY aglq750_filter_parser('glar012') TO s_detail1[1].b_glar012
            DISPLAY aglq750_filter_parser('glar013') TO s_detail1[1].b_glar013
            DISPLAY aglq750_filter_parser('glar014') TO s_detail1[1].b_glar014
            DISPLAY aglq750_filter_parser('glar015') TO s_detail1[1].b_glar015
            DISPLAY aglq750_filter_parser('glar016') TO s_detail1[1].b_glar016
            DISPLAY aglq750_filter_parser('glar017') TO s_detail1[1].b_glar017
            DISPLAY aglq750_filter_parser('glar018') TO s_detail1[1].b_glar018
            DISPLAY aglq750_filter_parser('glar019') TO s_detail1[1].b_glar019
            DISPLAY aglq750_filter_parser('glar051') TO s_detail1[1].b_glar051
            DISPLAY aglq750_filter_parser('glar052') TO s_detail1[1].b_glar052
            DISPLAY aglq750_filter_parser('glar053') TO s_detail1[1].b_glar053
            DISPLAY aglq750_filter_parser('glar020') TO s_detail1[1].b_glar020
            DISPLAY aglq750_filter_parser('glar022') TO s_detail1[1].b_glar022
            DISPLAY aglq750_filter_parser('glar023') TO s_detail1[1].b_glar023
            #160302-00006#1  2016/03/02 modify By 07675 -str 
#            DISPLAY aglq750_filter_parser('glar003') TO s_detail1[1].glar003
#            DISPLAY aglq750_filter_parser('glar005') TO s_detail1[1].glar005
#            DISPLAY aglq750_filter_parser('glar006') TO s_detail1[1].glar006
            DISPLAY aglq750_filter_parser('glar034') TO s_detail1[1].glar034
            DISPLAY aglq750_filter_parser('glar035') TO s_detail1[1].glar035
            DISPLAY aglq750_filter_parser('glar036') TO s_detail1[1].glar036
            DISPLAY aglq750_filter_parser('glar037') TO s_detail1[1].glar037
            #160302-00006#1 2016/03/02 By 07675  -end
            
           ##160302-00006#1  2016/03/02 ADD By 07675 -STR
         #此段落由子樣板a01產生
           #Ctrlp:construct.c.page1.b_glar001
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    
 
            #END add-point
 
      
 
         #Ctrlp:construct.c.page1.b_glar012
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            NEXT FIELD b_glar012
            #END add-point
 
         
 
         #Ctrlp:construct.c.page1.b_glar013
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 
 
            NEXT FIELD b_glar013 
            #END add-point
 
         #----<<b_glar014>>----
         #Ctrlp:construct.c.page1.b_glar014
         ON ACTION controlp INFIELD b_glar014
            #add-point:ON ACTION controlp INFIELD b_glar014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar014  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 
 
            NEXT FIELD b_glar014                #返回原欄位
    
 
 
            #END add-point
 
 
         #----<<b_glar015>>----
         #Ctrlp:construct.c.page1.b_glar015
         ON ACTION controlp INFIELD b_glar015
            #add-point:ON ACTION controlp INFIELD b_glar015
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar015  #顯示到畫面上
            NEXT FIELD b_glar015                     #返回原欄位
    
 
 
            #END add-point
 
     
 
         #----<<b_glar016>>----
         #Ctrlp:construct.c.page1.b_glar016
         ON ACTION controlp INFIELD b_glar016
            #add-point:ON ACTION controlp INFIELD b_glar016
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add section 异动过
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar016  #顯示到畫面上
            NEXT FIELD b_glar016                     #返回原欄位
    
 
 
            #END add-point
 
         
 
         #----<<b_glar017>>----
         #Ctrlp:construct.c.page1.b_glar017
         ON ACTION controlp INFIELD b_glar017
            #add-point:ON ACTION controlp INFIELD b_glar017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add   section 异动过
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar017  #顯示到畫面上
            NEXT FIELD b_glar017                     #返回原欄位
    
 
 
            #END add-point
 
            
 
         #----<<b_glar018>>----
         #Ctrlp:construct.c.page1.b_glar018
         ON ACTION controlp INFIELD b_glar018
            #add-point:ON ACTION controlp INFIELD b_glar018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar018  #顯示到畫面上
            NEXT FIELD b_glar018                     #返回原欄位
    
 
 
            #END add-point
 
 
         #----<<b_glar019>>----
         #Ctrlp:construct.c.page1.b_glar019
         ON ACTION controlp INFIELD b_glar019
            #add-point:ON ACTION controlp INFIELD b_glar019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar019  #顯示到畫面上
            NEXT FIELD b_glar019                     #返回原欄位
    
 
 
            #END add-point
 
            
 
         #----<<b_glar020>>----
         #Ctrlp:construct.c.page1.b_glar020
         ON ACTION controlp INFIELD b_glar020
            #add-point:ON ACTION controlp INFIELD b_glar020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar020  #顯示到畫面上
            NEXT FIELD b_glar020                     #返回原欄位
    
 
 
            #END add-point
 
       
            
 
         #----<<b_glar052>>----
         #Ctrlp:construct.c.page1.b_glar052
         ON ACTION controlp INFIELD b_glar052
            #add-point:ON ACTION controlp INFIELD b_glar052
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar052  #顯示到畫面上
            NEXT FIELD b_glar052                     #返回原欄位
    
         ON ACTION controlp INFIELD b_glar053
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar053  #顯示到畫面上
            NEXT FIELD b_glar053    
            
        ON ACTION controlp INFIELD b_glar022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022     #顯示到畫面上
            NEXT FIELD b_glar022                     #返回原欄位
        
       ON ACTION controlp INFIELD b_glar023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上
 
            NEXT FIELD b_glar023   
            #END add-point
 
       
 
            #160302-00006#1  2016/03/02 ADD By 07675  END
            
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL aglq750_filter_show('glar001','b_glar001')
   CALL aglq750_filter_show('glar012','b_glar012')
   CALL aglq750_filter_show('glar013','b_glar013')
   CALL aglq750_filter_show('glar014','b_glar014')
   CALL aglq750_filter_show('glar015','b_glar015')
   CALL aglq750_filter_show('glar016','b_glar016')
   CALL aglq750_filter_show('glar017','b_glar017')
   CALL aglq750_filter_show('glar018','b_glar018')
   CALL aglq750_filter_show('glar019','b_glar019')
   CALL aglq750_filter_show('glar051','b_glar051')
   CALL aglq750_filter_show('glar052','b_glar052')
   CALL aglq750_filter_show('glar053','b_glar053')
   CALL aglq750_filter_show('glar020','b_glar020')
   CALL aglq750_filter_show('glar022','b_glar022')
   CALL aglq750_filter_show('glar023','b_glar023')
   #160302-00006#1 2016/03/02   modify-str
#    CALL aglq750_filter_show('glar003','glar003')
#   CALL aglq750_filter_show('glar005','glar005')
#   CALL aglq750_filter_show('glar006','glar006')
   CALL aglq750_filter_show('glar034','glar034')
   CALL aglq750_filter_show('glar035','glar035')
   CALL aglq750_filter_show('glar036','glar036')
   CALL aglq750_filter_show('glar037','glar037')
#   CALL aglq750_filter_show('glar003','b_glar023')
#   CALL aglq750_filter_show('glar005','b_glar023')
#   CALL aglq750_filter_show('glar006','b_glar023')
#   CALL aglq750_filter_show('glar034','b_glar023')
#   CALL aglq750_filter_show('glar035','b_glar023')
#   CALL aglq750_filter_show('glar036','b_glar023')
#   CALL aglq750_filter_show('glar037','b_glar023')
#  #160302-00006#1  2016/03/02 By 07675  -end
 
    CALL aglq750_b_fill1() #160302-00006#1  2016/03/02 By 07675  
  # CALL aglq750_b_fill()
  # CALL aglq750_fetch()
    
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq750_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="aglq750.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq750_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq750_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.insert" >}
#+ insert
PRIVATE FUNCTION aglq750_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq750.modify" >}
#+ modify
PRIVATE FUNCTION aglq750_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq750_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.delete" >}
#+ delete
PRIVATE FUNCTION aglq750_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq750.other_function" >}

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL aglq750_create_temp_table()
# Date & Author..: 2014/03/27 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_create_temp_table()
   DROP TABLE aglq750_tmp
   CREATE TEMP TABLE aglq750_tmp(
   seq           INTEGER,
   glar001       VARCHAR(24),
   glar012       VARCHAR(10),
   glar013       VARCHAR(10),
   glar014       VARCHAR(10),
   glar015       VARCHAR(10),
   glar016       VARCHAR(10),
   glar017       VARCHAR(10),
   glar018       VARCHAR(10),
   glar019       VARCHAR(10),
   glar051       VARCHAR(10),
   glar052       VARCHAR(10),
   glar053       VARCHAR(10),
   glar020       VARCHAR(20),
   glar022       VARCHAR(20),
   glar023       VARCHAR(30),
   glar024       VARCHAR(30),
   glar025       VARCHAR(30),
   glar026       VARCHAR(30),
   glar027       VARCHAR(30),
   glar028       VARCHAR(30),
   glar029       VARCHAR(30),
   glar030       VARCHAR(30),
   glar031       VARCHAR(30),
   glar032       VARCHAR(30),
   glar033       VARCHAR(30),
   glar003       SMALLINT,
   style         VARCHAR(80), 
   glar005       DECIMAL(20,6), 
   glar006       DECIMAL(20,6), 
   glar034       DECIMAL(20,6), 
   glar035       DECIMAL(20,6), 
   glar036       DECIMAL(20,6), 
   glar037       DECIMAL(20,6), 
   state         VARCHAR(1), 
   amt1          DECIMAL(20,6),
   amt2          DECIMAL(20,6),
   amt3          DECIMAL(20,6))
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq750_set_curr_show()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("glar034,glar035,amt2",TRUE)
   ELSE
      CALL cl_set_comp_visible("glar034,glar035,amt2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("glar036,glar037,amt3",TRUE)
   ELSE
      CALL cl_set_comp_visible("glar036,glar037,amt3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("glar034,glar035,glar036,glar037,amt2,amt3",TRUE)
      CALL cl_set_comp_visible("glar034,glar035,glar036,glar037,amt2,amt3",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq750_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
#   CALL cl_set_comp_visible("ctype",TRUE)
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
#         CALL cl_set_comp_visible("ctype",FALSE)
#         LET tm.ctype=''
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
#         LET tm.ctype='1'
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
#         LET tm.ctype='2'  
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
#         LET tm.ctype='3'
   END CASE
   LET tm.ctype='0'
   CALL aglq750_set_curr_show() #顯示本位幣二、本位幣三
   
END FUNCTION

################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq750_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/3/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_glar_s.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_glar_s.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_glar_s.getLength() THEN
      LET g_current_idx = g_glar_s.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_glar001 = g_glar_s[g_current_idx].glar001
   CALL aglq750_b_fill1() 
END FUNCTION

################################################################################
# Descriptions...: 抓取數據
# Memo...........:
# Usage..........: CALL aglq750_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_get_data()
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4,l_sql5  STRING
   DEFINE l_wc                  STRING 
   DEFINE l_glar001        LIKE glar_t.glar001
   DEFINE l_glar012        LIKE glar_t.glar012
   DEFINE l_glar013        LIKE glar_t.glar013
   DEFINE l_glar014        LIKE glar_t.glar014
   DEFINE l_glar015        LIKE glar_t.glar015
   DEFINE l_glar016        LIKE glar_t.glar016
   DEFINE l_glar017        LIKE glar_t.glar017
   DEFINE l_glar018        LIKE glar_t.glar018
   DEFINE l_glar019        LIKE glar_t.glar019
   DEFINE l_glar051        LIKE glar_t.glar051
   DEFINE l_glar052        LIKE glar_t.glar052
   DEFINE l_glar053        LIKE glar_t.glar053
   DEFINE l_glar020        LIKE glar_t.glar020
   DEFINE l_glar022        LIKE glar_t.glar022
   DEFINE l_glar023        LIKE glar_t.glar023
   DEFINE l_glar024        LIKE glar_t.glar024 
   DEFINE l_glar025        LIKE glar_t.glar025
   DEFINE l_glar026        LIKE glar_t.glar026
   DEFINE l_glar027        LIKE glar_t.glar027 
   DEFINE l_glar028        LIKE glar_t.glar028
   DEFINE l_glar029        LIKE glar_t.glar029
   DEFINE l_glar030        LIKE glar_t.glar030 
   DEFINE l_glar031        LIKE glar_t.glar031
   DEFINE l_glar032        LIKE glar_t.glar032
   DEFINE l_glar033        LIKE glar_t.glar033
   DEFINE l_glar003        LIKE glar_t.glar003
   DEFINE l_desc           LIKE type_t.num5
   DEFINE l_glar005        LIKE glar_t.glar005
   DEFINE l_glar006        LIKE glar_t.glar006
   DEFINE l_glar034        LIKE glar_t.glar034
   DEFINE l_glar035        LIKE glar_t.glar035
   DEFINE l_glar036        LIKE glar_t.glar036
   DEFINE l_glar037        LIKE glar_t.glar037
   DEFINE l_state          LIKE type_t.num5
   DEFINE l_amt1           LIKE type_t.num20_6 
   DEFINE l_amt2           LIKE type_t.num20_6 
   DEFINE l_amt3           LIKE type_t.num20_6 
   DEFINE l_amt4           LIKE type_t.num20_6 
   DEFINE l_amt5           LIKE type_t.num20_6 
   DEFINE l_amt6           LIKE type_t.num20_6 
   DEFINE l_sum1           LIKE type_t.num20_6 
   DEFINE l_sum2           LIKE type_t.num20_6
   DEFINE l_sum3           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2,l_str3,l_str4  STRING
   DEFINE l_seq            LIKE type_t.num10
   DEFINE l_glar           DYNAMIC ARRAY OF RECORD
          glar001          LIKE glar_t.glar001,
          glac003          LIKE glac_t.glac003, #160824-00004#4 add
          glar012          LIKE glar_t.glar012,
          glar013          LIKE glar_t.glar013,
          glar014          LIKE glar_t.glar014,
          glar015          LIKE glar_t.glar015,
          glar016          LIKE glar_t.glar016,
          glar017          LIKE glar_t.glar017,
          glar018          LIKE glar_t.glar018,
          glar019          LIKE glar_t.glar019,
          glar051          LIKE glar_t.glar051,
          glar052          LIKE glar_t.glar052,
          glar053          LIKE glar_t.glar053,
          glar020          LIKE glar_t.glar020,
          glar022          LIKE glar_t.glar022,
          glar023          LIKE glar_t.glar023,
          glar024          LIKE glar_t.glar024,
          glar025          LIKE glar_t.glar025,
          glar026          LIKE glar_t.glar026,
          glar027          LIKE glar_t.glar027,
          glar028          LIKE glar_t.glar028,
          glar029          LIKE glar_t.glar029,
          glar030          LIKE glar_t.glar030,
          glar031          LIKE glar_t.glar031,
          glar032          LIKE glar_t.glar032,
          glar033          LIKE glar_t.glar033
          END RECORD
   DEFINE l_i              LIKE type_t.num10
   DEFINE l_glaq003        LIKE glaq_t.glaq003
   DEFINE l_glaq004        LIKE glaq_t.glaq004
   DEFINE l_glaq040        LIKE glaq_t.glaq040
   DEFINE l_glaq041        LIKE glaq_t.glaq041
   DEFINE l_glaq043        LIKE glaq_t.glaq043
   DEFINE l_glaq044        LIKE glaq_t.glaq044
   DEFINE l_stus_str       STRING #凭证状态
   DEFINE l_wc_glar001     STRING
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_flag_amt       LIKE type_t.num5  #表示是否有期初後者期末金額
   DEFINE l_glaq002        STRING
   DEFINE l_glac002_str    STRING              #151204-00013#5 add
   DEFINE l_state_f        LIKE type_t.num5#160503-00037#4 add by 02599
   #160511-00006#2--add--str--
   DEFINE l_year_sum       LIKE type_t.num20_6
   DEFINE l_year_sum2      LIKE type_t.num20_6
   DEFINE l_year_sum3      LIKE type_t.num20_6
   #160511-00006#2--add--end
   DEFINE l_xcea002        LIKE xcea_t.xcea002  #160824-00004#4 add
   DEFINE l_glac003        LIKE glac_t.glac003  #160824-00004#4 add
   
   #刪除臨時表中資料
   DELETE FROM aglq750_tmp

   #核算項條件篩選
   LET l_wc_glar001=cl_replace_str(g_wc_glar001,'glar001','glaq002')
   LET l_wc=cl_replace_str(g_wc,'glar012','glaq017')
   LET l_wc=cl_replace_str(l_wc,'glar013','glaq018')
   LET l_wc=cl_replace_str(l_wc,'glar014','glaq019')
   LET l_wc=cl_replace_str(l_wc,'glar015','glaq020')
   LET l_wc=cl_replace_str(l_wc,'glar016','glaq021')
   LET l_wc=cl_replace_str(l_wc,'glar017','glaq022')
   LET l_wc=cl_replace_str(l_wc,'glar018','glaq023')
   LET l_wc=cl_replace_str(l_wc,'glar019','glaq024')
   LET l_wc=cl_replace_str(l_wc,'glar051','glaq051')
   LET l_wc=cl_replace_str(l_wc,'glar052','glaq052')
   LET l_wc=cl_replace_str(l_wc,'glar053','glaq053')
   LET l_wc=cl_replace_str(l_wc,'glar020','glaq025')
   LET l_wc=cl_replace_str(l_wc,'glar022','glaq027')
   LET l_wc=cl_replace_str(l_wc,'glar023','glaq028')
   #自由核算項
   LET l_wc=cl_replace_str(l_wc,'glar024','glaq029')
   LET l_wc=cl_replace_str(l_wc,'glar025','glaq030')
   LET l_wc=cl_replace_str(l_wc,'glar026','glaq031')
   LET l_wc=cl_replace_str(l_wc,'glar027','glaq032')
   LET l_wc=cl_replace_str(l_wc,'glar028','glaq033')
   LET l_wc=cl_replace_str(l_wc,'glar029','glaq034')
   LET l_wc=cl_replace_str(l_wc,'glar030','glaq035')
   LET l_wc=cl_replace_str(l_wc,'glar031','glaq036')
   LET l_wc=cl_replace_str(l_wc,'glar032','glaq037')
   LET l_wc=cl_replace_str(l_wc,'glar033','glaq038')
   
   IF cl_null(l_wc_glar001) THEN LET l_wc_glar001 = " 1=1" END IF
   LET l_wc_glar001=cl_replace_str(g_wc_glar001,'glar001','glac002')
   
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql1=l_sql1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql1=l_sql1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y' "
   END IF
#151204-00013#5--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#5--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'YE'"
      ELSE
         LET l_sql3="'YE'" 
      END IF
   END IF
   #150827-00036#2--add--str--
   #顯示AD審計調整傳票否
   IF tm.show_ad<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'AD' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'AD'"
      ELSE
         LET l_sql3="'AD'" 
      END IF
   END IF
   #150827-00036#2--add--end
   IF NOT cl_null(l_sql3) THEN
      LET l_sql3=" AND glap007 IN (",l_sql3,")"
   END IF   
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_stus_str=" AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('Y') "
         LET l_stus_str=" AND glapstus IN ('Y','S') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('Y','N') "
         LET l_stus_str=" AND glapstus IN ('N','Y','S') "
   END CASE
   #核算項
   CALL aglq750_fix_acc_get_sql() RETURNING l_str,l_str1,l_str2,l_str3,l_str4
   
   #抓出所有符合條件的會計科目
   LET g_sql="SELECT DISTINCT glac002,glac003 FROM glac_t",  #160824-00004#4 add glac003
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' AND ",l_wc_glar001,l_sql1,
             " ORDER BY glac002"
   PREPARE aglq750_sel_glac_pr FROM g_sql
   DECLARE aglq750_sel_glac_cs CURSOR FOR aglq750_sel_glac_pr
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_i=1
   CALL l_glar.clear()
   #科目遍歷
   FOREACH aglq750_sel_glac_cs INTO l_glac002,l_glac003 #160824-00004#4 add l_glac003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq750_sel_glac_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #抓取科目对应的明细科目或者独立科目
      LET l_glaq002='' #160824-00004#4 add
      IF l_glac003='1' THEN #160824-00004#4 add
      CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
      END IF #160824-00004#4 add
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002 ='",l_glac002,"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF
      
      #當勾選了顯示核算項等條件后，依勾選條件遍歷查詢資料
      IF NOT cl_null(l_str) THEN
         LET l_sql5="(SELECT DISTINCT ",l_str,
                   "   FROM glar_t",
                   "   LEFT OUTER JOIN glac_t ON glacent=glarent AND glac002=glar001 AND glac001='",g_glaa004,"'",
                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "    AND glar001='",l_glac002,"'",
                   "    AND glar002=",tm.year,
                   "    AND glar003 <= ",tm.eperiod,
                   l_sql1,l_str3," AND ",g_wc," )"
         #單據狀態      
         IF tm.stus MATCHES '[23]' THEN
            LET l_sql5=l_sql5,
                      " UNION ALL ",
                      "(SELECT DISTINCT ",l_str2,
                      "   FROM glaq_t",
                      "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      "   LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                      "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      l_glaq002,
                      "    AND glap002 =",tm.year,
                      "    AND glap004 <= ",tm.eperiod,
                      l_sql4,l_sql1,l_sql2,l_str4," AND ",l_wc," )"
         END IF
         LET l_sql5="SELECT DISTINCT ",l_str,
                    "  FROM (",l_sql5,")",
                    " ORDER BY ",l_str
         
         PREPARE aglq750_sel_pr FROM l_sql5
         DECLARE aglq750_sel_cr CURSOR FOR aglq750_sel_pr
         
         #原幣及核算項遍歷
         FOREACH aglq750_sel_cr INTO l_glar[l_i].glar001,l_glar[l_i].glar012,l_glar[l_i].glar013,
                                     l_glar[l_i].glar014,l_glar[l_i].glar015,l_glar[l_i].glar016,
                                     l_glar[l_i].glar017,l_glar[l_i].glar018,l_glar[l_i].glar019,
                                     l_glar[l_i].glar051,l_glar[l_i].glar052,l_glar[l_i].glar053,
                                     l_glar[l_i].glar020,l_glar[l_i].glar022,l_glar[l_i].glar023,
                                     l_glar[l_i].glar024,l_glar[l_i].glar025,l_glar[l_i].glar026,
                                     l_glar[l_i].glar027,l_glar[l_i].glar028,l_glar[l_i].glar029,
                                     l_glar[l_i].glar030,l_glar[l_i].glar031,l_glar[l_i].glar032,
                                     l_glar[l_i].glar033
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq750_sel_cr'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_glar[l_i].glar001 = l_glac002
            LET l_glar[l_i].glac003 = l_glac003  #160824-00004#4 add
            LET l_i=l_i+1
         END FOREACH
      END IF
   END FOREACH
   
   LET l_i=l_i-1
   CALL l_glar.deleteElement(l_glar.getLength()) 
   LET l_seq=1
   
   FOR l_i=1 TO l_glar.getLength()
      LET l_flag_amt = FALSE
      LET l_glar001=l_glar[l_i].glar001
      LET l_glar012=l_glar[l_i].glar012
      LET l_glar013=l_glar[l_i].glar013
      LET l_glar014=l_glar[l_i].glar014
      LET l_glar015=l_glar[l_i].glar015
      LET l_glar016=l_glar[l_i].glar016
      LET l_glar017=l_glar[l_i].glar017
      LET l_glar018=l_glar[l_i].glar018
      LET l_glar019=l_glar[l_i].glar019
      LET l_glar051=l_glar[l_i].glar051
      LET l_glar052=l_glar[l_i].glar052
      LET l_glar053=l_glar[l_i].glar053
      LET l_glar020=l_glar[l_i].glar020
      LET l_glar022=l_glar[l_i].glar022
      LET l_glar023=l_glar[l_i].glar023
      LET l_glar024=l_glar[l_i].glar024
      LET l_glar025=l_glar[l_i].glar025
      LET l_glar026=l_glar[l_i].glar026
      LET l_glar027=l_glar[l_i].glar027
      LET l_glar028=l_glar[l_i].glar028
      LET l_glar029=l_glar[l_i].glar029
      LET l_glar030=l_glar[l_i].glar030
      LET l_glar031=l_glar[l_i].glar031
      LET l_glar032=l_glar[l_i].glar032
      LET l_glar033=l_glar[l_i].glar033
      
      #抓取科目对应的明细科目或者独立科目
      LET l_glaq002='' #160824-00004#4
      IF l_glar[l_i].glac003 = '1' THEN #160824-00004#4 ad
      CALL s_voucher_get_glac_str(g_glaa004,l_glar001) RETURNING l_glaq002
      END IF #160824-00004#4 add
      
      #160824-00004#4--add--str--
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = "'",l_glar001,"'"
      END IF
      #160824-00004#4--add--end
      
      #151204-00013#5--add--str--
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      #151204-00013#5--add--end
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002 ='",l_glar001,"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF
      
      #核算项
      CALL aglq750_fix_acc_sql(l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                               l_glar018,l_glar019,l_glar020,l_glar022,l_glar023,l_glar051,
                               l_glar052,l_glar053,l_glar024,l_glar025,l_glar026,l_glar027,
                               l_glar028,l_glar029,l_glar030,l_glar031,l_glar032,l_glar033)
      RETURNING l_str,l_str1
      
      #期初餘額
      LET l_sql="SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=",tm.year," AND glar003<=? ",
                l_str
      PREPARE aglq750_sel_pr1 FROM l_sql
      #160503-00037#5 by 07900 --add-str
      #本年累計
      LET l_sql="SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=",tm.year," AND glar003<=? AND glar003<>0 ",
                l_str
      PREPARE aglq750_sel_pr01 FROM l_sql     
      #160503-00037#5 by 07900 --add-end    
      
      #160511-00006#2--add--str--
      #年初余额
      LET l_sql="SELECT SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=",tm.year," AND glar003=0 ",
                l_str
      PREPARE aglq750_year_sum_pr FROM l_sql
      #160511-00006#2--add--end

      #本期合計
      LET l_sql="(SELECT SUM(glar005) glar005,SUM(glar006) glar006,SUM(glar034) glar034,",
                "        SUM(glar035) glar035,SUM(glar036) glar036,SUM(glar037) glar037",
                "   FROM glar_t",
                "   LEFT OUTER JOIN glac_t ON glacent=glarent AND glac002=glar001 AND glac001='",g_glaa004,"'",
                "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "    AND glar001=? ",
                "    AND glar002=",tm.year,
                "    AND glar003=? ",l_str,
                l_sql1," AND ",g_wc," )"  
      #單據狀態      
      IF tm.stus MATCHES '[23]' THEN
         LET l_sql=l_sql,
                   " UNION ALL ",
                   "(SELECT SUM(glaq003) glar005,SUM(glaq004) glar006,SUM(glaq040) glar034,",
                   "        SUM(glaq041) glar035,SUM(glaq043) glar036,SUM(glaq044) glar037",
                   "   FROM glaq_t",
                   "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "   LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                   "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   l_glaq002,
                   "    AND glap002=",tm.year,
                   "    AND glap004=? ",l_sql4,l_str1,
                   l_sql1,l_sql2," AND ",l_wc," )"
      END IF
      LET l_sql="SELECT SUM(glar005),SUM(glar006),SUM(glar034),SUM(glar035),",
                "       SUM(glar036),SUM(glar037)",
                "  FROM (",l_sql,")"
      PREPARE aglq750_sel_pr5 FROM l_sql
      
      LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                l_glaq002,
                "   AND glap002=",tm.year,
                "   AND glap004<=?",l_str1,
                "   AND ",l_wc,l_sql2,l_sql4
      PREPARE aglq750_sel_pr2 FROM l_sql
      #抓取YE或AD傳票金額
      LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                l_glaq002,
                "   AND glap002=",tm.year,
                "   AND glapstus='S'",
                "   AND glap004<=?",l_str1,
                "   AND ",l_wc,l_sql3
      PREPARE aglq750_sel_pr3 FROM l_sql
      #抓取YE或AD傳票金額
      LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                l_glaq002,
                "   AND glap002=",tm.year,
                "   AND glapstus='S'",
                "   AND glap004=?",l_str1,
                "   AND ",l_wc,l_sql3       
      PREPARE aglq750_sel_pr4 FROM l_sql
      
      #151204-00013#5--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   "       SUM(glaq043),SUM(glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   l_glaq002,
                   "   AND glap002=",tm.year,
                   "   AND glap004<=?",l_str1,
                   "   AND ",l_wc,l_stus_str,
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                   "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                   #160824-00004#4--add--str--
                   "                                     )",
#                   "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                   "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                   "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                   "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                   "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                   "                                               AND xcea004=",tm.year," AND xcea005<=? ",
                   "                                     )",
                   "        )",
                   #160824-00004#4--add--end
                   "       )"
         PREPARE aglq750_sel_pr3_1 FROM l_sql
         
         LET l_sql="SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   "       SUM(glaq043),SUM(glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   l_glaq002,
                   "   AND glap002=",tm.year,
                   "   AND glap004=?",l_str1,
                   "   AND ",l_wc,l_stus_str,
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' ",l_glac002_str,"))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                   "                                         AND glac007='5' ",l_glac002_str,#"))",  #160824-00004#4 mark '))'
                   #160824-00004#4--add--str--
                   "                                     )",
#                   "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                   "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                   "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                   "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                   "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                   "                                               AND xcea004=",tm.year," AND xcea005=? ",
                   "                                     )",
                   "        )",
                   #160824-00004#4--add--end
                   "       )"                   
         PREPARE aglq750_sel_pr4_1 FROM l_sql
      END IF
      #151204-00013#5--add--end
      
      LET l_amt1=0
      LET l_amt2=0
      LET l_amt3=0      
      LET l_state=NULL
      #期初餘額
      LET l_period=tm.speriod-1
      EXECUTE aglq750_sel_pr1 USING l_glar001,l_period 
                               INTO l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','aglq750_sel_pr1','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'aglq750_sel_pr1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
      IF cl_null(l_glar005) THEN LET l_glar005=0 END IF
      IF cl_null(l_glar006) THEN LET l_glar006=0 END IF
      IF cl_null(l_glar034) THEN LET l_glar034=0 END IF
      IF cl_null(l_glar035) THEN LET l_glar035=0 END IF
      IF cl_null(l_glar036) THEN LET l_glar036=0 END IF
      IF cl_null(l_glar037) THEN LET l_glar037=0 END IF
      IF tm.stus MATCHES '[23]' THEN
         EXECUTE aglq750_sel_pr2 USING l_period 
                                  INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq750_sel_pr2','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq750_sel_pr2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
         IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
         IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
         IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
         IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
         IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
         LET l_glar005 = l_glar005 + l_glaq003
         LET l_glar006 = l_glar006 + l_glaq004
         LET l_glar034 = l_glar034 + l_glaq040
         LET l_glar035 = l_glar035 + l_glaq041
         LET l_glar036 = l_glar036 + l_glaq043
         LET l_glar037 = l_glar037 + l_glaq044
      END IF
      #當不包含YE或AD傳票時，減去YE或AD傳票金額
#      IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#5 mark
      IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#5 add
         EXECUTE aglq750_sel_pr3 USING l_period 
                                  INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq750_sel_pr3','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq750_sel_pr3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
         IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
         IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
         IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
         IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
         IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
         LET l_glar005=l_glar005-l_glaq003
         LET l_glar006=l_glar006-l_glaq004
         LET l_glar034=l_glar034-l_glaq040
         LET l_glar035=l_glar035-l_glaq041
         LET l_glar036=l_glar036-l_glaq043
         LET l_glar037=l_glar037-l_glaq044
      END IF
      
      #151204-00013#5--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         LET l_glaq003=0
         LET l_glaq004=0
         LET l_glaq040=0
         LET l_glaq041=0
         LET l_glaq043=0
         LET l_glaq044=0
         EXECUTE aglq750_sel_pr3_1 USING l_period,l_period #160824-00004#4 add 'l_period' 
                                  INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq750_sel_pr3_1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
         IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
         IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
         IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
         IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
         IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
         LET l_glar005=l_glar005-l_glaq003
         LET l_glar006=l_glar006-l_glaq004
         LET l_glar034=l_glar034-l_glaq040
         LET l_glar035=l_glar035-l_glaq041
         LET l_glar036=l_glar036-l_glaq043
         LET l_glar037=l_glar037-l_glaq044
      END IF
      #151204-00013#5--add--end
      
      LET l_amt1 = l_glar005 - l_glar006
      LET l_amt2 = l_glar034 - l_glar035
      LET l_amt3 = l_glar036 - l_glar037
      #借貸平否
      CASE
         WHEN l_amt1>0 
            LET l_state='1'
         WHEN l_amt1<0
            LET l_state='2'
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         WHEN l_amt1=0
            LET l_state='3'
      END CASE
      
      #判斷是否有期初金額，如果有標示為TRUE
      IF l_state <> '3' THEN LET l_flag_amt = TRUE END IF
      
      INSERT INTO aglq750_tmp
      VALUES(l_seq,l_glar001,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
             l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
             l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
             l_glar031,l_glar032,l_glar033,NULL,'1',
             l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037,
             l_state,l_amt1,l_amt2,l_amt3)
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
      LET l_seq=l_seq+1
      
      #记录期初状态
      LET l_state_f = l_state #160503-00037#4 add by 02599
      FOR l_glar003=tm.speriod TO tm.eperiod   
         #本期合計
         IF tm.stus MATCHES '[23]' THEN
            EXECUTE aglq750_sel_pr5 USING l_glar001,l_glar003,l_glar003
                                     INTO l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
         ELSE
            EXECUTE aglq750_sel_pr5 USING l_glar001,l_glar003
                                     INTO l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
         END IF
         IF cl_null(l_glar005) THEN LET l_glar005=0 END IF
         IF cl_null(l_glar006) THEN LET l_glar006=0 END IF
         IF cl_null(l_glar034) THEN LET l_glar034=0 END IF
         IF cl_null(l_glar035) THEN LET l_glar035=0 END IF
         IF cl_null(l_glar036) THEN LET l_glar036=0 END IF
         IF cl_null(l_glar037) THEN LET l_glar037=0 END IF
         #當不包含YE或AD傳票時，減去YE或AD傳票金額
#         IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#5 mark
         IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  #151204-00013#5 add
            EXECUTE aglq750_sel_pr4 USING l_glar003 
                                     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq750_sel_pr4','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq750_sel_pr4'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            LET l_glar005=l_glar005-l_glaq003
            LET l_glar006=l_glar006-l_glaq004
            LET l_glar034=l_glar034-l_glaq040
            LET l_glar035=l_glar035-l_glaq041
            LET l_glar036=l_glar036-l_glaq043
            LET l_glar037=l_glar037-l_glaq044
         END IF
         
         #151204-00013#5--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_glaq003=0
            LET l_glaq004=0
            LET l_glaq040=0
            LET l_glaq041=0
            LET l_glaq043=0
            LET l_glaq044=0
            EXECUTE aglq750_sel_pr4_1 USING l_glar003,l_glar003 #160824-00004#4 add 'l_glar003'  
                                     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq750_sel_pr4_1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            LET l_glar005=l_glar005-l_glaq003
            LET l_glar006=l_glar006-l_glaq004
            LET l_glar034=l_glar034-l_glaq040
            LET l_glar035=l_glar035-l_glaq041
            LET l_glar036=l_glar036-l_glaq043
            LET l_glar037=l_glar037-l_glaq044
         END IF
         #151204-00013#5--add--end
         
         LET l_sum1=l_glar005-l_glar006
	      LET l_sum2=l_glar034-l_glar035
	      LET l_sum3=l_glar036-l_glar037
	      
	      #借餘
#         IF l_state='1' THEN #160503-00037#4 mark by 02599
         IF l_state_f='1' THEN  #160503-00037#4 add by 02599
            LET l_sum1=l_sum1+l_amt1
            LET l_sum2=l_sum2+l_amt2
            LET l_sum3=l_sum3+l_amt3
         END IF
         #貸餘
#         IF l_state='2' THEN #160503-00037#4 mark by 02599
         IF l_state_f='2' THEN  #160503-00037#4 add by 02599
            LET l_sum1=l_sum1-l_amt1
            LET l_sum2=l_sum2-l_amt2
            LET l_sum3=l_sum3-l_amt3
         END IF
         #借貸平否
         CASE
            WHEN l_sum1>0 
               LET l_state='1'
            WHEN l_sum1<0
               LET l_state='2'
               LET l_sum1=(-1)*l_sum1
               LET l_sum2=(-1)*l_sum2
               LET l_sum3=(-1)*l_sum3
            WHEN l_sum1=0
               LET l_state='3'
         END CASE
         
         #判斷是否有期間異動金額，如果有標示為TRUE
         IF l_state <> '3' THEN LET l_flag_amt = TRUE END IF
         
         INSERT INTO aglq750_tmp
         VALUES(l_seq,l_glar001,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                l_glar031,l_glar032,l_glar033,l_glar003,'2',
                l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037,
                l_state,l_sum1,l_sum2,l_sum3)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_state_f = l_state #160503-00037#4 add by 02599
         LET l_amt1=l_sum1
         LET l_amt2=l_sum2
         LET l_amt3=l_sum3
         LET l_seq=l_seq+1
      
         #本年累計
         EXECUTE aglq750_sel_pr01 USING l_glar001,l_glar003     #160503-00037#5  by 07900 -mod  "aglq750_sel_pr1"-->"aglq750_sel_pr01"
                                  INTO l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq750_sel_pr1','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq750_sel_pr01'    #160503-00037#5  by 07900 -mod  "aglq750_sel_pr1"-->"aglq750_sel_pr01"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glar005) THEN LET l_glar005=0 END IF
         IF cl_null(l_glar006) THEN LET l_glar006=0 END IF
         IF cl_null(l_glar034) THEN LET l_glar034=0 END IF
         IF cl_null(l_glar035) THEN LET l_glar035=0 END IF
         IF cl_null(l_glar036) THEN LET l_glar036=0 END IF
         IF cl_null(l_glar037) THEN LET l_glar037=0 END IF
         IF tm.stus MATCHES '[23]' THEN
            EXECUTE aglq750_sel_pr2 USING l_glar003 
                                     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq750_sel_pr2','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq750_sel_pr2'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            LET l_glar005 = l_glar005 + l_glaq003
            LET l_glar006 = l_glar006 + l_glaq004
            LET l_glar034 = l_glar034 + l_glaq040
            LET l_glar035 = l_glar035 + l_glaq041
            LET l_glar036 = l_glar036 + l_glaq043
            LET l_glar037 = l_glar037 + l_glaq044
         END IF
         #當不包含YE或AD傳票時，減去YE或AD傳票金額
#         IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#5 mark
         IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#5 add
            EXECUTE aglq750_sel_pr3 USING l_glar003
                                     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq750_sel_pr3','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq750_sel_pr3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            LET l_glar005 = l_glar005 - l_glaq003
            LET l_glar006 = l_glar006 - l_glaq004
            LET l_glar034 = l_glar034 - l_glaq040
            LET l_glar035 = l_glar035 - l_glaq041
            LET l_glar036 = l_glar036 - l_glaq043
            LET l_glar037 = l_glar037 - l_glaq044
         END IF
         
         #151204-00013#5--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_glaq003=0
            LET l_glaq004=0
            LET l_glaq040=0
            LET l_glaq041=0
            LET l_glaq043=0
            LET l_glaq044=0
            EXECUTE aglq750_sel_pr3_1 USING l_glar003,l_glar003 #160824-00004#4 add 'l_glar003' 
                                     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq750_sel_pr3_1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            LET l_glar005 = l_glar005 - l_glaq003
            LET l_glar006 = l_glar006 - l_glaq004
            LET l_glar034 = l_glar034 - l_glaq040
            LET l_glar035 = l_glar035 - l_glaq041
            LET l_glar036 = l_glar036 - l_glaq043
            LET l_glar037 = l_glar037 - l_glaq044
         END IF
         #151204-00013#5--add--end
         
         #160511-00006#2--add--str--
         #本年累计的余额包括年初金额
         LET l_year_sum=0
         LET l_year_sum2=0
         LET l_year_sum3=0
         EXECUTE aglq750_year_sum_pr USING l_glar001        
                                  INTO l_year_sum,l_year_sum2,l_year_sum3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq750_year_sum_pr'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_year_sum) THEN LET l_year_sum = 0 END IF
         IF cl_null(l_year_sum2) THEN LET l_year_sum2 = 0 END IF
         IF cl_null(l_year_sum3) THEN LET l_year_sum3 = 0 END IF
         #160511-00006#2--add--end
         
         LET l_amt4 = l_glar005 - l_glar006
         LET l_amt5 = l_glar034 - l_glar035
         LET l_amt6 = l_glar036 - l_glar037
         
         #160511-00006#2--add--str--
         #本年累计余额=本年累计金额+年初余额
         LET l_amt4 = l_amt4 + l_year_sum
         LET l_amt5 = l_amt5 + l_year_sum2
         LET l_amt6 = l_amt6 + l_year_sum3
         #160511-00006#2--add--end
         
         #借貸平否
         CASE
            WHEN l_amt4>0 
               LET l_state='1'
            WHEN l_amt4<0
               LET l_state='2'
               LET l_amt4=(-1)*l_amt4
               LET l_amt5=(-1)*l_amt5
               LET l_amt6=(-1)*l_amt6
            WHEN l_amt4=0
               LET l_state='3'
         END CASE
         INSERT INTO aglq750_tmp
         VALUES(l_seq,l_glar001,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                l_glar031,l_glar032,l_glar033,NULL,'3',
                l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037,
                l_state,l_amt4,l_amt5,l_amt6)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_seq=l_seq+1
      END FOR
      #當该科目沒有期初金額和期間異動時不用查詢出來
      IF l_flag_amt = FALSE THEN
         LET l_sql="DELETE FROM aglq750_tmp ",
                   " WHERE glar001 = '",l_glar001,"'"
         IF tm.comp='Y' THEN
            LET l_sql=l_sql," AND glar012 = '",l_glar012,"' "
         END IF
         IF tm.glad007='Y' THEN
            LET l_sql=l_sql," AND glar013 = '",l_glar013,"' "
         END IF
         IF tm.glad008='Y' THEN
            LET l_sql=l_sql," AND glar014 = '",l_glar014,"' "
         END IF
         IF tm.glad009='Y' THEN
            LET l_sql=l_sql," AND glar015 = '",l_glar015,"' "
         END IF
         IF tm.glad010='Y' THEN
            LET l_sql=l_sql," AND glar016 = '",l_glar016,"' "
         END IF
         IF tm.glad027='Y' THEN
            LET l_sql=l_sql," AND glar017 = '",l_glar017,"' "
         END IF
         IF tm.glad011='Y' THEN
            LET l_sql=l_sql," AND glar018 = '",l_glar018,"' "
         END IF
         IF tm.glad012='Y' THEN
            LET l_sql=l_sql," AND glar019 = '",l_glar019,"' "
         END IF
         IF tm.glad031='Y' THEN
            LET l_sql=l_sql," AND glar051 = '",l_glar051,"' "
         END IF
         IF tm.glad032='Y' THEN
            LET l_sql=l_sql," AND glar052 = '",l_glar052,"' "
         END IF
         IF tm.glad033='Y' THEN
            LET l_sql=l_sql," AND glar053 = '",l_glar053,"' "
         END IF
         IF tm.glad013='Y' THEN
            LET l_sql=l_sql," AND glar020 = '",l_glar020,"' "
         END IF
         IF tm.glad015='Y' THEN
            LET l_sql=l_sql," AND glar022 = '",l_glar022,"' "
         END IF
         IF tm.glad016='Y' THEN
            LET l_sql=l_sql," AND glar023 = '",l_glar023,"' "
         END IF
         IF tm.glad017='Y' THEN
            LET l_sql=l_sql," AND glar024 = '",l_glar024,"' "
         END IF
         IF tm.glad018='Y' THEN
            LET l_sql=l_sql," AND glar025 = '",l_glar025,"' "
         END IF
         IF tm.glad019='Y' THEN
            LET l_sql=l_sql," AND glar026 = '",l_glar026,"' "
         END IF
         IF tm.glad020='Y' THEN
            LET l_sql=l_sql," AND glar027 = '",l_glar027,"' "
         END IF
         IF tm.glad021='Y' THEN
            LET l_sql=l_sql," AND glar028 = '",l_glar028,"' "
         END IF
         IF tm.glad022='Y' THEN
            LET l_sql=l_sql," AND glar029 = '",l_glar029,"' "
         END IF
         IF tm.glad023='Y' THEN
            LET l_sql=l_sql," AND glar030 = '",l_glar030,"' "
         END IF
         IF tm.glad024='Y' THEN
            LET l_sql=l_sql," AND glar031 = '",l_glar031,"' "
         END IF
         IF tm.glad025='Y' THEN
            LET l_sql=l_sql," AND glar032 = '",l_glar032,"' "
         END IF
         IF tm.glad026='Y' THEN
            LET l_sql=l_sql," AND glar033 = '",l_glar033,"' "
         END IF
         PREPARE aglq750_del_temp_table FROM l_sql
         EXECUTE aglq750_del_temp_table
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'delete'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END IF
   END FOR
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq750_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq750_b_fill1()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_b_fill1()
   DEFINE l_seq      LIKE type_t.num10
   
   LET g_sql="SELECT UNIQUE seq,glar001,'',glar012,'',glar013,'',glar014,'',glar015,'',glar016,'',glar017,'',",
             "       glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,glar023,",
             "       glar024,glar025,glar026,glar027,glar028,glar029,glar030,glar031,glar032,glar033,",
             "       glar003,style,glar005,glar006,glar034,glar035,glar036,glar037,",
             "       state,amt1,amt2,amt3 ",
             "  FROM aglq750_tmp ",
              " WHERE 1=1 "#160302-00006#1 ADD by 07675
   #是否按照幣別分頁
   
   IF NOT cl_null(g_glar001) THEN
      LET g_sql=g_sql,"AND glar001='",g_glar001,"'"#160302-00006#1 by 07675  WHERE 改 AND
   END IF
   LET g_sql = g_sql, " AND ",g_wc_filter #160302-00006#1 ADD by 07675
   LET g_sql=g_sql," ORDER BY glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,",
                   "          glar019,glar051,glar052,glar053,glar020,glar022,glar023,glar024,",
                   "          glar025,glar026,glar027,glar028,glar029,glar030,glar031,glar032,",
                   "          glar033,seq "
  
   PREPARE aglq750_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq750_pb1
   OPEN b_fill_curs1
   
   CALL g_glar_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!"
   
   FOREACH b_fill_curs1 INTO l_seq,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar012, 
       g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,g_glar_d[l_ac].glar014, 
       g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,g_glar_d[l_ac].glar016, 
       g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,g_glar_d[l_ac].glar018, 
       g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,g_glar_d[l_ac].glar051,
       g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc, 
       g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,g_glar_d[l_ac].glar022, 
       g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar024,g_glar_d[l_ac].glar025,g_glar_d[l_ac].glar026,
       g_glar_d[l_ac].glar027,g_glar_d[l_ac].glar028,g_glar_d[l_ac].glar029,g_glar_d[l_ac].glar030,
       g_glar_d[l_ac].glar031,g_glar_d[l_ac].glar032,g_glar_d[l_ac].glar033,
       g_glar_d[l_ac].glar003,g_glar_d[l_ac].style,g_glar_d[l_ac].glar005,g_glar_d[l_ac].glar006, 
       g_glar_d[l_ac].glar034,g_glar_d[l_ac].glar035,g_glar_d[l_ac].glar036,g_glar_d[l_ac].glar037,g_glar_d[l_ac].state, 
       g_glar_d[l_ac].amt1,g_glar_d[l_ac].amt2,g_glar_d[l_ac].amt3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #160511-00006#2--add--str--
      #期初：只显示余额，借贷方金额不显示
      IF g_glar_d[l_ac].style = '1' THEN
         LET g_glar_d[l_ac].glar005 = NULL
         LET g_glar_d[l_ac].glar006 = NULL
         LET g_glar_d[l_ac].glar034 = NULL
         LET g_glar_d[l_ac].glar035 = NULL
         LET g_glar_d[l_ac].glar036 = NULL
         LET g_glar_d[l_ac].glar037 = NULL
      END IF
      #160511-00006#2--add--end
      
      CALL aglq750_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE aglq750_pb1
   
   LET l_ac = 1
   
   CALL aglq750_filter_show('glar001','b_glar001')
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq750_set_default_value()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.year=l_glav002
   LET tm.speriod=l_glav006
   LET tm.eperiod=l_glav006
   #獲取現行會計週期最大期別
   SELECT MAX(glav006) INTO g_max_period FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.year

   #按科目分頁
   LET tm.acc_p='N'
   #統制科目
   LET tm.show_acc='N'
   #科目層級
   LET tm.glac005=99
   #單據狀態
   LET tm.stus='1'
   #含內部管理科目
   LET tm.glac009='Y'
   #150827-00036#2--add--str--
   #含審計調整傳票
   LET tm.show_ad='Y'
   #150827-00036#2--add--end
   #含月結傳票
   LET tm.show_ce='Y'
   #含年結傳票
   LET tm.show_ye='Y'
   #核算項
   LET tm.comp='Y'
   LET tm.glad007='N'
   LET tm.glad008='N'
   LET tm.glad009='N'
   LET tm.glad010='N'
   LET tm.glad027='N'
   LET tm.glad011='N'
   LET tm.glad012='N'
   LET tm.glad031='N'
   LET tm.glad032='N'
   LET tm.glad033='N'
   LET tm.glad013='N'
   LET tm.glad015='N'
   LET tm.glad016='N'
   LET tm.glad017='N'
   LET tm.glad018='N'
   LET tm.glad019='N'
   LET tm.glad020='N'
   LET tm.glad021='N'
   LET tm.glad022='N'
   LET tm.glad023='N'
   LET tm.glad024='N'
   LET tm.glad025='N'
   LET tm.glad026='N'
   CALL cl_set_comp_visible("b_glar013,b_glar013_desc,b_glar014,b_glar014_desc,b_glar015,b_glar015_desc,b_glar016,b_glar016_desc,b_glar017,b_glar017_desc,b_glar018,b_glar018_desc",FALSE)
   CALL cl_set_comp_visible("b_glar019,b_glar019_desc,b_glar051,b_glar052,b_glar052_desc,b_glar053,b_glar053_desc,b_glar020,b_glar020_desc,b_glar022,b_glar022_desc",FALSE)
   CALL cl_set_comp_visible("b_glar023,b_glar023_desc,b_glar024,b_glar024_desc,b_glar025,b_glar025_desc,b_glar026,b_glar026_desc,",FALSE)
   CALL cl_set_comp_visible("b_glar027,b_glar027_desc,b_glar028,b_glar028_desc,b_glar029,b_glar029_desc,b_glar030,b_glar030_desc,",FALSE)
   CALL cl_set_comp_visible("b_glar031,b_glar031_desc,b_glar032,b_glar032_desc,b_glar033,b_glar033_desc",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq750_set_page()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glar_s.clear()
   IF tm.acc_p <>'Y' THEN
      LET g_glar_s[1].glar001=''
      LET g_header_cnt = 1
      LET g_rec_b = 1
   ELSE      
      LET l_sql="SELECT DISTINCT glar001 FROM aglq750_tmp ORDER BY glar001 "
      PREPARE aglq750_sel_s_pr FROM l_sql
      DECLARE aglq750_sel_s_cr CURSOR FOR aglq750_sel_s_pr
      LET l_idx=1
      FOREACH aglq750_sel_s_cr INTO g_glar_s[l_idx].glar001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq750_sel_s_cr'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx=l_idx+1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_glar_s.deleteElement(l_idx)
      LET g_header_cnt = g_glar_s.getLength()
      LET g_rec_b = l_idx - 1
   END IF
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq750_show()
# Date & Author..:  2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_show()
   DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.year,tm.speriod,tm.eperiod,tm.acc_p,tm.ctype,
           tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,
           tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,tm.glad011,
           tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,tm.glad015,tm.glad016,
           tm.glad017,tm.glad018,tm.glad019,tm.glad020,tm.glad021,tm.glad022,
           tm.glad023,tm.glad024,tm.glad025,tm.glad026
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           year,speriod,eperiod,acc_p,ctype,
           show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye,
           comp,glad007,glad008,glad009,glad010,glad027,glad011,
           glad012,glad031,glad032,glad033,glad013,glad015,glad016,
           glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq750_fix_acc_sql(p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053)
#                  RETURNING r_sql,r_sql1
# Input parameter: p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053  14組固定核算項   传入参数变量说明1
# Return code....: r_sql，r_sql1 組合SQL語句
# Date & Author..: 2014/03/25 By 02599
# Modify.........: 加10個核算項
################################################################################
PRIVATE FUNCTION aglq750_fix_acc_sql(p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053,p_glar024,p_glar025,p_glar026,p_glar027,p_glar028,p_glar029,p_glar030,p_glar031,p_glar032,p_glar033)
   DEFINE p_glar012            LIKE glar_t.glar012
   DEFINE p_glar013            LIKE glar_t.glar013
   DEFINE p_glar014            LIKE glar_t.glar014
   DEFINE p_glar015            LIKE glar_t.glar015
   DEFINE p_glar016            LIKE glar_t.glar016
   DEFINE p_glar017            LIKE glar_t.glar017
   DEFINE p_glar018            LIKE glar_t.glar018
   DEFINE p_glar019            LIKE glar_t.glar019
   DEFINE p_glar051            LIKE glar_t.glar051
   DEFINE p_glar052            LIKE glar_t.glar052
   DEFINE p_glar053            LIKE glar_t.glar053
   DEFINE p_glar020            LIKE glar_t.glar020
   DEFINE p_glar022            LIKE glar_t.glar022
   DEFINE p_glar023            LIKE glar_t.glar023
   #10個自由核算項
   DEFINE p_glar024            LIKE glar_t.glar024
   DEFINE p_glar025            LIKE glar_t.glar025
   DEFINE p_glar026            LIKE glar_t.glar026
   DEFINE p_glar027            LIKE glar_t.glar027
   DEFINE p_glar028            LIKE glar_t.glar028
   DEFINE p_glar029            LIKE glar_t.glar029
   DEFINE p_glar030            LIKE glar_t.glar030
   DEFINE p_glar031            LIKE glar_t.glar031
   DEFINE p_glar032            LIKE glar_t.glar033
   DEFINE p_glar033            LIKE glar_t.glar031
   DEFINE r_sql,r_sql1         STRING
   
   LET r_sql=''
   LET r_sql1=''
   IF tm.comp='Y' THEN
      LET r_sql=r_sql," AND glar012='",p_glar012,"'"
      LET r_sql1=r_sql1," AND glaq017='",p_glar012,"'"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql=r_sql," AND glar013='",p_glar013,"'"
      LET r_sql1=r_sql1," AND glaq018='",p_glar013,"'"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql=r_sql," AND glar014='",p_glar014,"'"
      LET r_sql1=r_sql1," AND glaq019='",p_glar014,"'"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql=r_sql," AND glar015='",p_glar015,"'"
      LET r_sql1=r_sql1," AND glaq020='",p_glar015,"'"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql=r_sql," AND glar016='",p_glar016,"'"
      LET r_sql1=r_sql1," AND glaq021='",p_glar016,"'"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql=r_sql," AND glar017='",p_glar017,"'"
      LET r_sql1=r_sql1," AND glaq022='",p_glar017,"'"
   END IF
      
   IF tm.glad011='Y' THEN
      LET r_sql=r_sql," AND glar018='",p_glar018,"'"
      LET r_sql1=r_sql1," AND glaq023='",p_glar018,"'"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql=r_sql," AND glar019='",p_glar019,"'"
      LET r_sql1=r_sql1," AND glaq024='",p_glar019,"'"
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql=r_sql," AND glar051='",p_glar051,"'"
      LET r_sql1=r_sql1," AND glaq051='",p_glar051,"'"
   END IF
   
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql=r_sql," AND glar052='",p_glar052,"'"
      LET r_sql1=r_sql1," AND glaq052='",p_glar052,"'"
   END IF
   
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql=r_sql," AND glar053='",p_glar053,"'"
      LET r_sql1=r_sql1," AND glaq053='",p_glar053,"'"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql=r_sql," AND glar020='",p_glar020,"'"
      LET r_sql1=r_sql1," AND glaq025='",p_glar020,"'"
   END IF
   
#   IF tm.glad014='Y' THEN
#      IF p_glar021 IS NULL THEN
#         LET r_sql=r_sql," AND glar021 IS NULL "
#         LET r_sql1=r_sql1," AND glaq026 IS NULL "
#      ELSE
#         LET r_sql=r_sql," AND glar021='",p_glar021,"'"
#         LET r_sql1=r_sql1," AND glaq026='",p_glar021,"'"
#      END IF
#   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql=r_sql," AND glar022='",p_glar022,"'"
      LET r_sql1=r_sql1," AND glaq027='",p_glar022,"'"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql=r_sql," AND glar023='",p_glar023,"'"
      LET r_sql1=r_sql1," AND glaq028='",p_glar023,"'"
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql=r_sql," AND glar024='",p_glar024,"'"
      LET r_sql1=r_sql1," AND glaq029='",p_glar024,"'"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql=r_sql," AND glar025='",p_glar025,"'"
      LET r_sql1=r_sql1," AND glaq030='",p_glar025,"'"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql=r_sql," AND glar026='",p_glar026,"'"
      LET r_sql1=r_sql1," AND glaq031='",p_glar026,"'"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql=r_sql," AND glar027='",p_glar027,"'"
      LET r_sql1=r_sql1," AND glaq032='",p_glar027,"'"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql=r_sql," AND glar028='",p_glar028,"'"
      LET r_sql1=r_sql1," AND glaq033='",p_glar028,"'"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql=r_sql," AND glar029='",p_glar029,"'"
      LET r_sql1=r_sql1," AND glaq034='",p_glar029,"'"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql=r_sql," AND glar030='",p_glar030,"'"
      LET r_sql1=r_sql1," AND glaq035='",p_glar030,"'"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql=r_sql," AND glar031='",p_glar031,"'"
      LET r_sql1=r_sql1," AND glaq036='",p_glar031,"'"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql=r_sql," AND glar032='",p_glar032,"'"
      LET r_sql1=r_sql1," AND glaq037='",p_glar032,"'"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql=r_sql," AND glar033='",p_glar033,"'"
      LET r_sql1=r_sql1," AND glaq038='",p_glar033,"'"
   END IF
   RETURN r_sql,r_sql1
END FUNCTION

################################################################################
# Descriptions...: 根據核算項勾選組SQL語句
# Memo...........:
# Usage..........: CALL aglq750_fix_acc_get_sql()
#                  RETURNING r_sql,r_sql1
# Return code....: r_sql    關於glar_t的SQL語句
#                : r_sql1   關於glaq_t的SQL語句
# Date & Author..: 2014/03/24 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_fix_acc_get_sql()
   DEFINE r_sql,r_sql1,r_sql2,r_sql3,r_sql4   STRING 
   
   LET r_sql= "''"
   LET r_sql1="''"
   LET r_sql2="''"
   LET r_sql3=''
   LET r_sql4=''
   IF tm.comp='Y' THEN
      LET r_sql =r_sql,",glar012"
      LET r_sql1=r_sql1,",glaq017"
      LET r_sql2=r_sql2,",glaq017 glar012"
      LET r_sql3=r_sql3," glar012 <> ' '"
      LET r_sql4=r_sql4," glaq017 <> ' '"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql =r_sql,",glar013"
      LET r_sql1=r_sql1,",glaq018"
      LET r_sql2=r_sql2,",glaq018 glar013"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar013 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar013 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq018 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq018 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql =r_sql,",glar014"
      LET r_sql1=r_sql1,",glaq019"
      LET r_sql2=r_sql2,",glaq019 glar014"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar014 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar014 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq019 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq019 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql =r_sql,",glar015"
      LET r_sql1=r_sql1,",glaq020"
      LET r_sql2=r_sql2,",glaq020 glar015"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar015 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar015 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq020 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq020 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql =r_sql,",glar016"
      LET r_sql1=r_sql1,",glaq021"
      LET r_sql2=r_sql2,",glaq021 glar016"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar016 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar016 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq021 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq021 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql =r_sql,",glar017"
      LET r_sql1=r_sql1,",glaq022"
      LET r_sql2=r_sql2,",glaq022 glar017"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar017 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar017 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq022 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq022 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad011='Y' THEN
      LET r_sql =r_sql,",glar018"
      LET r_sql1=r_sql1,",glaq023"
      LET r_sql2=r_sql2,",glaq023 glar018"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar018 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar018 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq023 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq023 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql =r_sql,",glar019"
      LET r_sql1=r_sql1,",glaq024"
      LET r_sql2=r_sql2,",glaq024 glar019"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar019 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar019 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq024 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq024 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql =r_sql,",glar051"
      LET r_sql1=r_sql1,",glaq051"
      LET r_sql2=r_sql2,",glaq051 glar051"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar051 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar051 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq051 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq051 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql =r_sql,",glar052"
      LET r_sql1=r_sql1,",glaq052"
      LET r_sql2=r_sql2,",glaq052 glar052"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar052 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar052 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq052 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq052 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql =r_sql,",glar053"
      LET r_sql1=r_sql1,",glaq053"
      LET r_sql2=r_sql2,",glaq053 glar053"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar053 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar053 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq053 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq053 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql =r_sql,",glar020"
      LET r_sql1=r_sql1,",glaq025"
      LET r_sql2=r_sql2,",glaq025 glar020"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar020 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar020 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq025 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq025 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
#   IF tm.glad014='Y' THEN
#      LET r_sql =r_sql,",glar021"
#      LET r_sql1=r_sql1,",glaq026"
#      LET r_sql2=r_sql2,",glaq026 glar021"
#   ELSE
#      LET r_sql =r_sql,",''"
#      LET r_sql1=r_sql1,",''"
#      LET r_sql2=r_sql2,",''"
#   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql =r_sql,",glar022"
      LET r_sql1=r_sql1,",glaq027"
      LET r_sql2=r_sql2,",glaq027 glar022"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar022 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar022 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq027 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq027 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql =r_sql,",glar023"
      LET r_sql1=r_sql1,",glaq028"
      LET r_sql2=r_sql2,",glaq028 glar023"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar023 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar023 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq028 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq028 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql =r_sql,",glar024"
      LET r_sql1=r_sql1,",glaq029"
      LET r_sql2=r_sql2,",glaq029 glar024"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql =r_sql,",glar025"
      LET r_sql1=r_sql1,",glaq030"
      LET r_sql2=r_sql2,",glaq030 glar025"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql =r_sql,",glar026"
      LET r_sql1=r_sql1,",glaq031"
      LET r_sql2=r_sql2,",glaq031 glar026"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql =r_sql,",glar027"
      LET r_sql1=r_sql1,",glaq032"
      LET r_sql2=r_sql2,",glaq032 glar027"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql =r_sql,",glar028"
      LET r_sql1=r_sql1,",glaq033"
      LET r_sql2=r_sql2,",glaq033 glar028"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql =r_sql,",glar029"
      LET r_sql1=r_sql1,",glaq034"
      LET r_sql2=r_sql2,",glaq034 glar029"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql =r_sql,",glar030"
      LET r_sql1=r_sql1,",glaq035"
      LET r_sql2=r_sql2,",glaq035 glar030"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql =r_sql,",glar031"
      LET r_sql1=r_sql1,",glaq036"
      LET r_sql2=r_sql2,",glaq036 glar031"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql =r_sql,",glar032"
      LET r_sql1=r_sql1,",glaq037"
      LET r_sql2=r_sql2,",glaq037 glar032"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql =r_sql,",glar033"
      LET r_sql1=r_sql1,",glaq038"
      LET r_sql2=r_sql2,",glaq038 glar033"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   IF NOT cl_null(r_sql3) THEN
      LET r_sql3=" AND ( ",r_sql3," )"
   END IF
   IF NOT cl_null(r_sql4) THEN
      LET r_sql4=" AND ( ",r_sql4," )"
   END IF
   RETURN r_sql,r_sql1,r_sql2,r_sql3,r_sql4
END FUNCTION

################################################################################
# Descriptions...: 接受传参
# Memo...........:
# Usage..........: CALL aglq750_default_search()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_default_search()
   #帳別
   IF NOT cl_null(g_argv[01]) THEN
      LET g_glaald = g_argv[01]
   END IF
   #年度
   IF NOT cl_null(g_argv[02]) THEN
      LET tm.year = g_argv[02]
   END IF
   #起始期別
   IF NOT cl_null(g_argv[03]) THEN
      LET tm.speriod = g_argv[03]
   END IF
   #截止期別
   IF NOT cl_null(g_argv[04]) THEN
      LET tm.eperiod = g_argv[04]
   END IF
   #按科目分頁
   IF NOT cl_null(g_argv[05]) THEN
      LET tm.acc_p = g_argv[05]
   END IF
   #多本位幣顯示
   IF NOT cl_null(g_argv[06]) THEN
      LET tm.ctype = g_argv[06]
   END IF
   #統制科目
   IF NOT cl_null(g_argv[07]) THEN
      LET tm.show_acc = g_argv[07]
   END IF
   #科目層級
   IF NOT cl_null(g_argv[08]) THEN
      LET tm.glac005 = g_argv[08]
   END IF
   #單據狀態
   IF NOT cl_null(g_argv[09]) THEN
      LET tm.stus = g_argv[09]
   END IF
   #含內部管理科目
   IF NOT cl_null(g_argv[10]) THEN
      LET tm.glac009 = g_argv[10]
   END IF
   #含月結傳票
   IF NOT cl_null(g_argv[11]) THEN
      LET tm.show_ce = g_argv[11]
   END IF
   #含年結傳票
   IF NOT cl_null(g_argv[12]) THEN
      LET tm.show_ye = g_argv[12]
   END IF
   #营运据点
   IF NOT cl_null(g_argv[13]) THEN
      LET tm.comp = g_argv[13]
   END IF
   #部门管理
   IF NOT cl_null(g_argv[14]) THEN
      LET tm.glad007 = g_argv[14]
   END IF
   #利润成本
   IF NOT cl_null(g_argv[15]) THEN
      LET tm.glad008 = g_argv[15]
   END IF
   #区域管理
   IF NOT cl_null(g_argv[16]) THEN
      LET tm.glad009 = g_argv[16]
   END IF
   #交易客商
   IF NOT cl_null(g_argv[17]) THEN
      LET tm.glad010 = g_argv[17]
   END IF
   #账款客商
   IF NOT cl_null(g_argv[18]) THEN
      LET tm.glad027 = g_argv[18]
   END IF
   #客群
   IF NOT cl_null(g_argv[19]) THEN
      LET tm.glad011 = g_argv[19]
   END IF
   #产品类别
   IF NOT cl_null(g_argv[20]) THEN
      LET tm.glad012 = g_argv[20]
   END IF
   #经营方式
   IF NOT cl_null(g_argv[21]) THEN
      LET tm.glad031 = g_argv[21]
   END IF
   #渠道
   IF NOT cl_null(g_argv[22]) THEN
      LET tm.glad032 = g_argv[22]
   END IF
   #品牌
   IF NOT cl_null(g_argv[23]) THEN
      LET tm.glad033 = g_argv[23]
   END IF
   #人员
   IF NOT cl_null(g_argv[24]) THEN
      LET tm.glad013 = g_argv[24]
   END IF
   #专案
   IF NOT cl_null(g_argv[25]) THEN
      LET tm.glad015 = g_argv[25]
   END IF
   #WBS
   IF NOT cl_null(g_argv[26]) THEN
      LET tm.glad016 = g_argv[26]
   END IF
   #自由核算项一
   IF NOT cl_null(g_argv[27]) THEN
      LET tm.glad017 = g_argv[27]
   END IF
   #自由核算项二
   IF NOT cl_null(g_argv[28]) THEN
      LET tm.glad018 = g_argv[28]
   END IF
   #自由核算项三
   IF NOT cl_null(g_argv[29]) THEN
      LET tm.glad019 = g_argv[29]
   END IF
   #自由核算项四
   IF NOT cl_null(g_argv[30]) THEN
      LET tm.glad020 = g_argv[30]
   END IF
   #自由核算项五
   IF NOT cl_null(g_argv[31]) THEN
      LET tm.glad021 = g_argv[31]
   END IF
   #自由核算项六
   IF NOT cl_null(g_argv[32]) THEN
      LET tm.glad022 = g_argv[32]
   END IF
   #自由核算项七
   IF NOT cl_null(g_argv[33]) THEN
      LET tm.glad023 = g_argv[33]
   END IF
   #自由核算项八
   IF NOT cl_null(g_argv[34]) THEN
      LET tm.glad024 = g_argv[34]
   END IF
   #自由核算项九
   IF NOT cl_null(g_argv[35]) THEN
      LET tm.glad025 = g_argv[35]
   END IF
   #自由核算项十
   IF NOT cl_null(g_argv[36]) THEN
      LET tm.glad026 = g_argv[36]
   END IF
   #科目
   IF NOT cl_null(g_argv[37]) THEN
      IF g_argv[37]='*' THEN
         LET g_wc_glar001 = " glar001 LIKE '%'"
      ELSE
         LET g_wc_glar001 = " glar001 = '",g_argv[37],"'"
      END IF
   END IF
   #营运据点
   IF NOT cl_null(g_argv[38]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar012 = '",g_argv[38],"'"
      ELSE
         LET g_wc = g_wc," AND glar012 = '",g_argv[38],"'"
      END IF
   END IF
   #部门管理
   IF NOT cl_null(g_argv[39]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar013 = '",g_argv[39],"'"
      ELSE
         LET g_wc = g_wc," AND glar013 = '",g_argv[39],"'"
      END IF
   END IF
   #利润成本
   IF NOT cl_null(g_argv[40]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar014 = '",g_argv[40],"'"
      ELSE
         LET g_wc = g_wc," AND glar014 = '",g_argv[40],"'"
      END IF
   END IF
   #区域管理
   IF NOT cl_null(g_argv[41]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar015 = '",g_argv[41],"'"
      ELSE
         LET g_wc = g_wc," AND glar015 = '",g_argv[41],"'"
      END IF
   END IF
   #交易客商
   IF NOT cl_null(g_argv[42]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar016 = '",g_argv[42],"'"
      ELSE
         LET g_wc = g_wc," AND glar016 = '",g_argv[42],"'"
      END IF
   END IF
   #账款客商
   IF NOT cl_null(g_argv[43]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar017 = '",g_argv[43],"'"
      ELSE
         LET g_wc = g_wc," AND glar017 = '",g_argv[43],"'"
      END IF
   END IF
   #客群
   IF NOT cl_null(g_argv[44]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar018 = '",g_argv[44],"'"
      ELSE
         LET g_wc = g_wc," AND glar018 = '",g_argv[44],"'"
      END IF
   END IF
   #产品类别
   IF NOT cl_null(g_argv[45]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar019 = '",g_argv[45],"'"
      ELSE
         LET g_wc = g_wc," AND glar019 = '",g_argv[45],"'"
      END IF
   END IF
   #经营方式
   IF NOT cl_null(g_argv[46]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar051 = '",g_argv[46],"'"
      ELSE
         LET g_wc = g_wc," AND glar051 = '",g_argv[46],"'"
      END IF
   END IF
   #渠道
   IF NOT cl_null(g_argv[47]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar052 = '",g_argv[47],"'"
      ELSE
         LET g_wc = g_wc," AND glar052 = '",g_argv[47],"'"
      END IF
   END IF
   #品牌
   IF NOT cl_null(g_argv[48]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar053 = '",g_argv[48],"'"
      ELSE
         LET g_wc = g_wc," AND glar053 = '",g_argv[48],"'"
      END IF
   END IF
   #人员
   IF NOT cl_null(g_argv[49]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar020 = '",g_argv[49],"'"
      ELSE
         LET g_wc = g_wc," AND glar020 = '",g_argv[49],"'"
      END IF
   END IF
   #专案
   IF NOT cl_null(g_argv[50]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar022 = '",g_argv[50],"'"
      ELSE
         LET g_wc = g_wc," AND glar022 = '",g_argv[50],"'"
      END IF
   END IF
   #WBS
   IF NOT cl_null(g_argv[51]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar023 = '",g_argv[51],"'"
      ELSE
         LET g_wc = g_wc," AND glar023 = '",g_argv[51],"'"
      END IF
   END IF
   #自由核算项一
   IF NOT cl_null(g_argv[52]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar024 = '",g_argv[52],"'"
      ELSE
         LET g_wc = g_wc," AND glar024 = '",g_argv[52],"'"
      END IF
   END IF
   #自由核算项二
   IF NOT cl_null(g_argv[53]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar025 = '",g_argv[53],"'"
      ELSE
         LET g_wc = g_wc," AND glar025 = '",g_argv[53],"'"
      END IF
   END IF
   #自由核算项三
   IF NOT cl_null(g_argv[54]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar026 = '",g_argv[54],"'"
      ELSE
         LET g_wc = g_wc," AND glar026 = '",g_argv[54],"'"
      END IF
   END IF
   #自由核算项四
   IF NOT cl_null(g_argv[55]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar027 = '",g_argv[55],"'"
      ELSE
         LET g_wc = g_wc," AND glar027 = '",g_argv[55],"'"
      END IF
   END IF
   #自由核算项五
   IF NOT cl_null(g_argv[56]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar028 = '",g_argv[56],"'"
      ELSE
         LET g_wc = g_wc," AND glar028 = '",g_argv[56],"'"
      END IF
   END IF
   #自由核算项六
   IF NOT cl_null(g_argv[57]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar029 = '",g_argv[57],"'"
      ELSE
         LET g_wc = g_wc," AND glar029 = '",g_argv[57],"'"
      END IF
   END IF
   #自由核算项七
   IF NOT cl_null(g_argv[58]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar030 = '",g_argv[58],"'"
      ELSE
         LET g_wc = g_wc," AND glar030 = '",g_argv[58],"'"
      END IF
   END IF
   #自由核算项八
   IF NOT cl_null(g_argv[59]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar031 = '",g_argv[59],"'"
      ELSE
         LET g_wc = g_wc," AND glar031 = '",g_argv[59],"'"
      END IF
   END IF
   #自由核算项九
   IF NOT cl_null(g_argv[60]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar032 = '",g_argv[60],"'"
      ELSE
         LET g_wc = g_wc," AND glar032 = '",g_argv[60],"'"
      END IF
   END IF
   #自由核算项十
   IF NOT cl_null(g_argv[61]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glar033 = '",g_argv[61],"'"
      ELSE
         LET g_wc = g_wc," AND glar033 = '",g_argv[61],"'"
      END IF
   END IF
   #150827-00036#2--add--str--
   #含審計調整傳票否
   IF NOT cl_null(g_argv[62]) THEN
      LET tm.show_ad = g_argv[62],"'"
   END IF
   #150827-00036#2--add--end
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
END FUNCTION

################################################################################
# Descriptions...: 设置单身核算项栏位显示
# Memo...........:
# Usage..........: CALL aglq750_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_visible()
   IF tm.comp='Y' THEN
      CALL cl_set_comp_visible("b_glar012,b_glar012_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar012,b_glar012_desc",FALSE)
   END IF

   IF tm.glad007='Y' THEN
      CALL cl_set_comp_visible("b_glar013,b_glar013_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar013,b_glar013_desc",FALSE)
   END IF

   IF tm.glad008='Y' THEN
      CALL cl_set_comp_visible("b_glar014,b_glar014_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar014,b_glar014_desc",FALSE)
   END IF

   IF tm.glad009='Y' THEN
      CALL cl_set_comp_visible("b_glar015,b_glar015_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar015,b_glar015_desc",FALSE)
   END IF

   IF tm.glad010='Y' THEN
      CALL cl_set_comp_visible("b_glar016,b_glar016_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar016,b_glar016_desc",FALSE)
   END IF

   IF tm.glad027='Y' THEN
      CALL cl_set_comp_visible("b_glar017,b_glar017_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar017,b_glar017_desc",FALSE)
   END IF

   IF tm.glad011='Y' THEN
      CALL cl_set_comp_visible("b_glar018,b_glar018_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar018,b_glar018_desc",FALSE)
   END IF

   IF tm.glad012='Y' THEN
      CALL cl_set_comp_visible("b_glar019,b_glar019_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar019,b_glar019_desc",FALSE)
   END IF

   IF tm.glad031='Y' THEN
      CALL cl_set_comp_visible("b_glar051",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar051",FALSE)
   END IF

   IF tm.glad032='Y' THEN
      CALL cl_set_comp_visible("b_glar052,b_glar052_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar052,b_glar052_desc",FALSE)
   END IF

   IF tm.glad033='Y' THEN
      CALL cl_set_comp_visible("b_glar053,b_glar053_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar053,b_glar053_desc",FALSE)
   END IF

   IF tm.glad013='Y' THEN
      CALL cl_set_comp_visible("b_glar020,b_glar020_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar020,b_glar020_desc",FALSE)
   END IF 

   IF tm.glad015='Y' THEN
      CALL cl_set_comp_visible("b_glar022,b_glar022_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar022,b_glar022_desc",FALSE)
   END IF

   IF tm.glad016='Y' THEN
      CALL cl_set_comp_visible("b_glar023,b_glar023_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar023,b_glar023_desc",FALSE)
   END IF

   IF tm.glad017='Y' THEN
      CALL cl_set_comp_visible("b_glar024,b_glar024_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar024,b_glar024_desc",FALSE)
   END IF

   IF tm.glad018='Y' THEN
      CALL cl_set_comp_visible("b_glar025,b_glar025_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar025,b_glar025_desc",FALSE)
   END IF

   IF tm.glad019='Y' THEN
      CALL cl_set_comp_visible("b_glar026,b_glar026_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar026,b_glar026_desc",FALSE)
   END IF

   IF tm.glad020='Y' THEN
      CALL cl_set_comp_visible("b_glar027,b_glar027_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar027,b_glar027_desc",FALSE)
   END IF

   IF tm.glad021='Y' THEN
      CALL cl_set_comp_visible("b_glar028,b_glar028_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar028,b_glar028_desc",FALSE)
   END IF

   IF tm.glad022='Y' THEN
      CALL cl_set_comp_visible("b_glar029,b_glar029_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar029,b_glar029_desc",FALSE)
   END IF

   IF tm.glad023='Y' THEN
      CALL cl_set_comp_visible("b_glar030,b_glar030_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar030,b_glar030_desc",FALSE)
   END IF

   IF tm.glad024='Y' THEN
      CALL cl_set_comp_visible("b_glar031,b_glar031_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar031,b_glar031_desc",FALSE)
   END IF

   IF tm.glad025='Y' THEN
      CALL cl_set_comp_visible("b_glar032,b_glar032_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar032,b_glar032_desc",FALSE)
   END IF

   IF tm.glad026='Y' THEN
      CALL cl_set_comp_visible("b_glar033,b_glar033_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glar033,b_glar033_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 串查aglq770明细核算项查询
# Memo...........:
# Usage..........: CALL aglq750_cmdrun()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   
   INITIALIZE la_param.* TO NULL
   LET la_param.prog = 'aglq770'
   LET la_param.param[1] = g_glaald    #帳別
   LET la_param.param[2] = tm.year    #年度
   CASE g_glar_d[g_detail_idx].style
      WHEN '1' #期初
         LET la_param.param[3] = g_glar_d[g_detail_idx+1].glar003  #起始期別
         LET la_param.param[4] = g_glar_d[g_detail_idx+1].glar003  #截止期別
      WHEN '2' #本期
         LET la_param.param[3] = g_glar_d[g_detail_idx].glar003  #起始期別
         LET la_param.param[4] = g_glar_d[g_detail_idx].glar003  #截止期別
      WHEN '3' #本年
         LET la_param.param[3] = g_glar_d[g_detail_idx-1].glar003  #起始期別
         LET la_param.param[4] = g_glar_d[g_detail_idx-1].glar003  #截止期別
   END CASE
   LET la_param.param[5] = tm.ctype    #多本位幣顯示
   LET la_param.param[6] = 'N'         #顯示原幣
   LET la_param.param[7] = 'N'         #按幣別分頁
   LET la_param.param[8] = tm.acc_p    #按科目分頁
   LET la_param.param[9] = tm.show_acc #顯示統制科目
   LET la_param.param[10] = tm.glac005  #科目層級
   LET la_param.param[11] = tm.stus     #單據狀態
   LET la_param.param[12] = tm.glac009 #含內部管理
   LET la_param.param[13] = tm.show_ce #含月結
   LET la_param.param[14] = tm.show_ye #含年結
   LET la_param.param[15] = tm.comp    #营运据点
   LET la_param.param[16] = tm.glad007 #部门管理
   LET la_param.param[17] = tm.glad008 #利润成本
   LET la_param.param[18] = tm.glad009 #区域管理
   LET la_param.param[19] = tm.glad010 #交易客商
   LET la_param.param[20] = tm.glad027 #账款客商
   LET la_param.param[21] = tm.glad011 #客群
   LET la_param.param[22] = tm.glad012 #产品类别
   LET la_param.param[23] = tm.glad031 #经营方式
   LET la_param.param[24] = tm.glad032 #渠道
   LET la_param.param[25] = tm.glad033 #品牌
   LET la_param.param[26] = tm.glad013 #人员
   LET la_param.param[27] = tm.glad015 #专案
   LET la_param.param[28] = tm.glad016 #WBS
   LET la_param.param[29] = tm.glad017 #自由核算项一
   LET la_param.param[30] = tm.glad018 #自由核算项二
   LET la_param.param[31] = tm.glad019 #自由核算项三
   LET la_param.param[32] = tm.glad020 #自由核算项四
   LET la_param.param[33] = tm.glad021 #自由核算项五
   LET la_param.param[34] = tm.glad022 #自由核算项六
   LET la_param.param[35] = tm.glad023 #自由核算项七
   LET la_param.param[36] = tm.glad024 #自由核算项八
   LET la_param.param[37] = tm.glad025 #自由核算项九
   LET la_param.param[38] = tm.glad026 #自由核算项十
   LET la_param.param[39] = g_glar_d[g_detail_idx].glar001 #科目編號
   LET la_param.param[40] = g_glar_d[g_detail_idx].glar012 #营运据点
   LET la_param.param[41] = g_glar_d[g_detail_idx].glar013 #部门管理
   LET la_param.param[42] = g_glar_d[g_detail_idx].glar014 #利润成本
   LET la_param.param[43] = g_glar_d[g_detail_idx].glar015 #区域管理
   LET la_param.param[44] = g_glar_d[g_detail_idx].glar016 #交易客商
   LET la_param.param[45] = g_glar_d[g_detail_idx].glar017 #账款客商
   LET la_param.param[46] = g_glar_d[g_detail_idx].glar018 #客群
   LET la_param.param[47] = g_glar_d[g_detail_idx].glar019 #产品类别
   LET la_param.param[48] = g_glar_d[g_detail_idx].glar051 #经营方式
   LET la_param.param[49] = g_glar_d[g_detail_idx].glar052 #渠道
   LET la_param.param[50] = g_glar_d[g_detail_idx].glar053 #品牌
   LET la_param.param[51] = g_glar_d[g_detail_idx].glar020 #人员
   LET la_param.param[52] = g_glar_d[g_detail_idx].glar022 #专案
   LET la_param.param[53] = g_glar_d[g_detail_idx].glar023 #WBS
   LET la_param.param[54] = g_glar_d[g_detail_idx].glar024 #自由核算项一
   LET la_param.param[55] = g_glar_d[g_detail_idx].glar025 #自由核算项二
   LET la_param.param[56] = g_glar_d[g_detail_idx].glar026 #自由核算项三
   LET la_param.param[57] = g_glar_d[g_detail_idx].glar027 #自由核算项四
   LET la_param.param[58] = g_glar_d[g_detail_idx].glar028 #自由核算项五
   LET la_param.param[59] = g_glar_d[g_detail_idx].glar029 #自由核算项六
   LET la_param.param[60] = g_glar_d[g_detail_idx].glar030 #自由核算项七
   LET la_param.param[61] = g_glar_d[g_detail_idx].glar031 #自由核算项八
   LET la_param.param[62] = g_glar_d[g_detail_idx].glar032 #自由核算项九
   LET la_param.param[63] = g_glar_d[g_detail_idx].glar033 #自由核算项十 
   LET la_param.param[64] = tm.show_ad  #含審計調整傳票 #150827-00036#2 add
   LET ls_js = util.JSON.stringify( la_param ) 
   CALL cl_cmdrun(ls_js)
END FUNCTION

################################################################################
# Descriptions...: XG报表使用的临时表
# Memo...........:
# Usage..........: CALL aglq750_create_temp_table_xg()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/21 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_create_temp_table_xg()
   DROP TABLE aglq750_tmp_xg
   CREATE TEMP TABLE aglq750_tmp_xg(
   seq            INTEGER,
   glarld         VARCHAR(5),
   glarld_desc    VARCHAR(500),
   glarcomp       VARCHAR(10),
   glarcomp_desc  VARCHAR(500),
   glar002        SMALLINT,
   period         VARCHAR(200),
   glar001        VARCHAR(24), 
   glar001_desc   VARCHAR(500), 
   glar012        VARCHAR(10), 
   glar012_desc   VARCHAR(500), 
   glar013        VARCHAR(10), 
   glar013_desc   VARCHAR(500), 
   glar014        VARCHAR(10), 
   glar014_desc   VARCHAR(500), 
   glar015        VARCHAR(10), 
   glar015_desc   VARCHAR(500), 
   glar016        VARCHAR(10), 
   glar016_desc   VARCHAR(500), 
   glar017        VARCHAR(10), 
   glar017_desc   VARCHAR(500), 
   glar018        VARCHAR(10), 
   glar018_desc   VARCHAR(500), 
   glar019        VARCHAR(10), 
   glar019_desc   VARCHAR(500),
   glar051        VARCHAR(10), 
   glar051_desc   VARCHAR(200),
   glar052        VARCHAR(10), 
   glar052_desc   VARCHAR(500),
   glar053        VARCHAR(10), 
   glar053_desc   VARCHAR(500),   
   glar020        VARCHAR(20), 
   glar020_desc   VARCHAR(500),  
   glar022        VARCHAR(20), 
   glar022_desc   VARCHAR(500),
   glar023        VARCHAR(30), 
   glar023_desc   VARCHAR(500),
   glar024        VARCHAR(30), 
   glar024_desc   VARCHAR(500), 
   glar025        VARCHAR(30),
   glar025_desc   VARCHAR(500),
   glar026        VARCHAR(30),
   glar026_desc   VARCHAR(500),
   glar027        VARCHAR(30), 
   glar027_desc   VARCHAR(500), 
   glar028        VARCHAR(30),
   glar028_desc   VARCHAR(500),
   glar029        VARCHAR(30),
   glar029_desc   VARCHAR(500),
   glar030        VARCHAR(30), 
   glar030_desc   VARCHAR(500), 
   glar031        VARCHAR(30),
   glar031_desc   VARCHAR(500),
   glar032        VARCHAR(30),
   glar032_desc   VARCHAR(500),
   glar033        VARCHAR(30),
   glar033_desc   VARCHAR(500),
   glar003        VARCHAR(80), 
   style          VARCHAR(200), 
   glar005        DECIMAL(20,6), 
   glar006        DECIMAL(20,6), 
   glar034        DECIMAL(20,6), 
   glar035        DECIMAL(20,6), 
   glar036        DECIMAL(20,6), 
   glar037        DECIMAL(20,6), 
   state          VARCHAR(200), 
   amt1           DECIMAL(20,6), 
   amt2           DECIMAL(20,6), 
   amt3           DECIMAL(20,6),
   glarent        SMALLINT)
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL aglq750_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/21 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq750_output()
   DEFINE l_glarld_desc    LIKE type_t.chr500
   DEFINE l_glarcomp_desc  LIKE type_t.chr500
   DEFINE l_period         LIKE type_t.chr200
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_str            STRING
   DEFINE l_glar051_desc   LIKE type_t.chr500
   DEFINE l_style          LIKE type_t.chr200
   DEFINE l_state          LIKE type_t.chr200
   
   CALL aglq750_create_temp_table_xg()
   DELETE FROM aglq750_tmp_xg
   
   LET l_glarld_desc = g_glaald,"  ",g_glaald_desc
   LET l_glarcomp_desc = g_glaacomp,"  ",g_glaacomp_desc
   LET l_period = tm.speriod USING '<<'," ~ ",tm.eperiod USING '<<'
   FOR l_i=1 TO g_glar_d.getLength()
       IF NOT cl_null(g_glar_d[l_i].glar051) THEN
          LET l_glar051_desc=g_glar_d[l_i].glar051,":",s_desc_gzcbl004_desc('6013',g_glar_d[l_i].glar051)
       END IF
       LET l_style=g_glar_d[l_i].style,":",s_desc_gzcbl004_desc('9927',g_glar_d[l_i].style)
       LET l_state=g_glar_d[l_i].state,":",s_desc_gzcbl004_desc('9926',g_glar_d[l_i].state)
       INSERT INTO aglq750_tmp_xg(seq,glarld,glarld_desc,glarcomp,glarcomp_desc,glar002,period,
                                  glar001,glar001_desc,
                                  glar012,glar012_desc,glar013,glar013_desc,
                                  glar014,glar014_desc,glar015,glar015_desc,
                                  glar016,glar016_desc,glar017,glar017_desc,
                                  glar018,glar018_desc,glar019,glar019_desc,
                                  glar051,glar051_desc,glar052,glar052_desc,
                                  glar053,glar053_desc,glar020,glar020_desc,
                                  glar022,glar022_desc,glar023,glar023_desc,
                                  glar024,glar024_desc,glar025,glar025_desc,
                                  glar026,glar026_desc,glar027,glar027_desc,
                                  glar028,glar028_desc,glar029,glar029_desc,
                                  glar030,glar030_desc,glar031,glar031_desc,
                                  glar032,glar032_desc,glar033,glar033_desc,
                                  glar003,style,glar005,glar006,
                                  glar034,glar035,glar036,glar037,
                                  state,amt1,amt2,amt3,glarent)
       VALUES(l_i,g_glaald,l_glarld_desc,g_glaacomp,l_glarcomp_desc,tm.year,l_period,
              g_glar_d[l_i].glar001,g_glar_d[l_i].glar001_desc, 
              g_glar_d[l_i].glar012,g_glar_d[l_i].glar012_desc,g_glar_d[l_i].glar013,g_glar_d[l_i].glar013_desc, 
              g_glar_d[l_i].glar014,g_glar_d[l_i].glar014_desc,g_glar_d[l_i].glar015,g_glar_d[l_i].glar015_desc, 
              g_glar_d[l_i].glar016,g_glar_d[l_i].glar016_desc,g_glar_d[l_i].glar017,g_glar_d[l_i].glar017_desc, 
              g_glar_d[l_i].glar018,g_glar_d[l_i].glar018_desc,g_glar_d[l_i].glar019,g_glar_d[l_i].glar019_desc,
              g_glar_d[l_i].glar051,l_glar051_desc,g_glar_d[l_i].glar052,g_glar_d[l_i].glar052_desc,
              g_glar_d[l_i].glar053,g_glar_d[l_i].glar053_desc,g_glar_d[l_i].glar020,g_glar_d[l_i].glar020_desc,
              g_glar_d[l_i].glar022,g_glar_d[l_i].glar022_desc,g_glar_d[l_i].glar023,g_glar_d[l_i].glar023_desc,
              g_glar_d[l_i].glar024,g_glar_d[l_i].glar024_desc,g_glar_d[l_i].glar025,g_glar_d[l_i].glar025_desc,
              g_glar_d[l_i].glar026,g_glar_d[l_i].glar026_desc,g_glar_d[l_i].glar027,g_glar_d[l_i].glar027_desc,
              g_glar_d[l_i].glar028,g_glar_d[l_i].glar028_desc,g_glar_d[l_i].glar029,g_glar_d[l_i].glar029_desc,
              g_glar_d[l_i].glar030,g_glar_d[l_i].glar030_desc,g_glar_d[l_i].glar031,g_glar_d[l_i].glar031_desc,
              g_glar_d[l_i].glar032,g_glar_d[l_i].glar032_desc,g_glar_d[l_i].glar033,g_glar_d[l_i].glar033_desc,
              g_glar_d[l_i].glar003,l_style,g_glar_d[l_i].glar005,g_glar_d[l_i].glar006, 
              g_glar_d[l_i].glar034,g_glar_d[l_i].glar035,g_glar_d[l_i].glar036,g_glar_d[l_i].glar037,
              l_state,g_glar_d[l_i].amt1,g_glar_d[l_i].amt2,g_glar_d[l_i].amt3,g_enterprise)
   END FOR
   
   LET l_str="glarent"
   CASE tm.ctype
      WHEN '0' LET l_str=l_str,"|glar034|glar035|glar036|glar037|l_amt2|l_amt3"
      WHEN '1' LET l_str=l_str,"|glar036|glar037|l_amt3"
      WHEN '2' LET l_str=l_str,"|glar034|glar035|l_amt2"
   END CASE
   IF tm.comp<>'Y' THEN
      LET l_str=l_str,"|glar012|l_glar012_desc"
   END IF

   IF tm.glad007<>'Y' THEN
      LET l_str=l_str,"|glar013|l_glar013_desc"
   END IF

   IF tm.glad008<>'Y' THEN
      LET l_str=l_str,"|glar014|l_glar014_desc"
   END IF

   IF tm.glad009<>'Y' THEN
      LET l_str=l_str,"|glar015|l_glar015_desc"
   END IF

   IF tm.glad010<>'Y' THEN
      LET l_str=l_str,"|glar016|l_glar016_desc"
   END IF

   IF tm.glad027<>'Y' THEN
      LET l_str=l_str,"|glar017|l_glar017_desc"
   END IF

   IF tm.glad011<>'Y' THEN
      LET l_str=l_str,"|glar018|l_glar018_desc"
   END IF

   IF tm.glad012<>'Y' THEN
      LET l_str=l_str,"|glar019|l_glar019_desc"
   END IF

   IF tm.glad031<>'Y' THEN
      LET l_str=l_str,"|l_glar051_desc"
   END IF

   IF tm.glad032<>'Y' THEN
      LET l_str=l_str,"|glar052|l_glar052_desc"
   END IF

   IF tm.glad033<>'Y' THEN
      LET l_str=l_str,"|glar053|l_glar053_desc"
   END IF

   IF tm.glad013<>'Y' THEN
      LET l_str=l_str,"|glar020|l_glar020_desc"
   END IF 

   IF tm.glad015<>'Y' THEN
      LET l_str=l_str,"|glar022|l_glar022_desc"
   END IF

   IF tm.glad016<>'Y' THEN
      LET l_str=l_str,"|glar023|l_glar023_desc"
   END IF

   IF tm.glad017<>'Y' THEN
      LET l_str=l_str,"|glar024|l_glar024_desc"
   END IF

   IF tm.glad018<>'Y' THEN
      LET l_str=l_str,"|glar025|l_glar025_desc"
   END IF

   IF tm.glad019<>'Y' THEN
      LET l_str=l_str,"|glar026|l_glar026_desc"
   END IF

   IF tm.glad020<>'Y' THEN
      LET l_str=l_str,"|glar027|l_glar027_desc"
   END IF

   IF tm.glad021<>'Y' THEN
      LET l_str=l_str,"|glar028|l_glar028_desc"
   END IF

   IF tm.glad022<>'Y' THEN
      LET l_str=l_str,"|glar029|l_glar029_desc"
   END IF

   IF tm.glad023<>'Y' THEN
      LET l_str=l_str,"|glar030|l_glar030_desc"
   END IF

   IF tm.glad024<>'Y' THEN
      LET l_str=l_str,"|glar031|l_glar031_desc"
   END IF

   IF tm.glad025<>'Y' THEN
      LET l_str=l_str,"|glar032|l_glar032_desc"
   END IF

   IF tm.glad026<>'Y' THEN
      LET l_str=l_str,"|glar033|l_glar033_desc"
   END IF
   
   CALL aglq750_x01(' 1=1','aglq750_tmp_xg',l_str)
   
   
END FUNCTION

 
{</section>}
 

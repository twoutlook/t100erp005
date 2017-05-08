#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq301.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000027
#+ 
#+ Filename...: axcq301
#+ Description: 成本計算后勾稽查詢
#+ Creator....: 00768(2014/09/08)
#+ Modifier...: 00768(2014/09/09) -SD/PR- 02111
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq301.global" >}
#                 150212 by 00768      xcbz增加成本库判断
#                                      MFG判断时，增加成本计算类型判断xcat005
#                                      MFG判断时，增加考虑特性判断
#                                      xccg和xccd勾稽时，若xccg中没资料就不用勾稽，因为：
#                                          当入库单类型只有为1.一般的时候 不插入到xccg中
#                                          当入库单类型中只要有2联产品、3多产出主件、5副产品的是偶，会连1一般的一起插入到xccg中
#                 150215 by 00768      现在不是所有入库都写xccg了，所以xccg现在一定会少资料
#                 150216 by 00768      1.修改patter复制的架构，查询状态点X不需继续查询
#                                      2.效能优化
#                 150225 by 00768      效能优化
#                 150324 by wangxin    报表
#                 151109 by 00768      如果前段异动资料里面有料+成本阶，允许成本阶只设置料件的，不一定要明细到特性，算成本的时候，如果料件+特征的成本阶获取不到，就获取料件的成本阶
#160318-00025#8   160421 By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160520-00004#1   160523 By 02040      效能優化
#160701-00011#1   160701 By 02040      調整axc-00428檢核條件
#160801-00050#1   160801 By 07024      ADJUST 特殊字元料號請排除不做axc-00461的檢查
#160813-00001#2   160822 By 02040      增加檢核：在製轉金出額與存貨工單入庫金額不符
#160912-00053#1   160913 By Ann_Huang  聯產品檢核需納入委外入庫一併計算。
#160802-00020#7   161006 By shiun      增加帳套權限管控、法人權限管控
#160811-00045#1   161011 By 02295      指定的资料无法查询到时修改不再报错，提示处理完毕。
#161007-00011#1   161011 By 02040      工單號一張會由多個成本域領料，因此拿掉工單單頭的成本域對單身的成本域的條件 
#161121-00007#1   161124 By shiun      優化程式
#161124-00048#13  161229 By 08734      星号整批调整
#161124-00008#1   170106 By charles4m  拆件式工單無xccd_t，在判斷資料異常檢核時，會報錯「工單不存在工單維護作業中」
#170106-00047#1   170109 By 08993      1.抓取xcbb_t時，不再串產品特徵。 2.調整制转出金额与存货工单入库金额不符，工单成本域是否正确
#161004-00007#1   170111 By 02040      檢查是否有設定成本分群時，要排除無效料
#170116-00021#1   170116 By zhujing    1.相同料號，即使有不同產品特徵，其成本階都是一樣的
#                                      2.出現「在制转出金额-1172.740000与存货工单入库金额0.000000不符，请检查工单成本域是否正确！」，因xccc_t串xccd_t時，沒把key值串進去，導致xccd_t資料抓錯
#160921-00010#1   170120 By xujing     切换据点自动预设画面栏位
#170218-00022#1   170218 By 02040      效能改善
#170220-00006#3   170220 By 02040      在製轉出(元件)金額為負值(axc-00462)應排除為副產品的料號
#170221-00028#1   170221 By 07024      效能改善(將SQL中subquery中的nvl、where段金額相比的部分拿掉，移至後面補0，以及金額比對)
#170321-00102#1   170324 By 02111      axc-00431 增加判斷是否有 xcce_t，若有xccd_t 沒有 xcce_t 則顯示 axc-00829。
#170331-00037#1   170331 By 02111      axc-00428 主 SQL 與子句條件不足，導致資料誤判。
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc006_desc LIKE type_t.chr500, 
   docno LIKE type_t.chr80, 
   info LIKE type_t.chr1000
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xccc_d
DEFINE g_master_t                   type_g_xccc_d
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
 
      
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
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5               #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
TYPE type_tm         RECORD
                     xccccomp   LIKE xccc_t.xccccomp,  #法人組織
                     xccccomp_desc LIKE type_t.chr80,  #
                     xccc004    LIKE xccc_t.xccc004 ,  #年度
                     xccc005    LIKE xccc_t.xccc005 ,  #期別
                     xcccld     LIKE xccc_t.xcccld  ,  #帳別編號
                     xcccld_desc   LIKE type_t.chr80,  #
                     xccc003    LIKE xccc_t.xccc003 ,  #成本計算類型 
                     xccc003_desc  LIKE type_t.chr80,  
                     c1        LIKE type_t.chr5,       #160523-00041#2                     
                     c2        LIKE type_t.chr5,       #160523-00041#2                     
                     c3        LIKE type_t.chr5,       #160523-00041#2                     
                     c4        LIKE type_t.chr5        #160523-00041#2                     
                     END RECORD
DEFINE tm            type_tm
DEFINE g_fetch       LIKE type_t.chr1

DEFINE g_page_cnt        LIKE type_t.num10  #總页數    #160520-00004#1 mod num10
DEFINE g_page_idx        LIKE type_t.num10  #当页笔数  #160520-00004#1 mod num10
#DEFINE g_detail_idx         LIKE type_t.num5   #当行
#DEFINE g_detail_cnt         LIKE type_t.num5   #总行

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5

DEFINE g_glaa003    LIKE glaa_t.glaa003 #会计周期参照表号
DEFINE g_bdate      LIKE glav_t.glav004 #年度+期別對應的起始截止日期
DEFINE g_edate      LIKE glav_t.glav004

# TYPE type_g_xccc_d RECORD
#       xccc006      LIKE xccc_t.xccc006, #料件编号
#       xccc007      LIKE xccc_t.xccc007, #料件特性
#       xccc006_desc LIKE type_t.chr500,  #料件品名
#       docno        LIKE type_t.chr80,   #单据编号
#       info         STRING               #错误说明 
#       END RECORD
#DEFINE g_xccc_d         DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_yy       LIKE xccc_t.xccc004  #年度 上一年度期别
DEFINE g_mm       LIKE xccc_t.xccc005  #期别 上一年度期别
DEFINE g_sys_6001 LIKE ooab_t.ooab002  #add 160517 系统参数[S-FIN-6001]:採用成本域否
DEFINE g_sys_6002 LIKE ooab_t.ooab002  #add 160517 系统参数[S-FIN-6002]:成本域類型
DEFINE g_sys_6004 LIKE ooab_t.ooab002  #add 141203 系统参数[S-FIN-6004]:雜項發料的取價方式
DEFINE g_sys_6016 LIKE ooab_t.ooab002  #add 150215 系统参数[S-FIN-6016]:当站下线是否影响成本

DEFINE g_qty_t    LIKE inag_t.inag008
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150123

DEFINE g_xcat005  LIKE xcat_t.xcat005  #add 150212 计价方式='3'批次成本判断
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
#add-point:傳入參數說明
#wangxina 15/03/24 add   start
DEFINE g_browser   DYNAMIC ARRAY OF RECORD
                  xccccomp LIKE xccc_t.xccccomp,
                  xccc004 LIKE xccc_t.xccc004,
                  xccc005 LIKE xccc_t.xccc005,
                  xcccld  LIKE xccc_t.xcccld,
                  xccc003 LIKE xccc_t.xccc003
                  END RECORD
DEFINE g_sql_tmp             STRING
TYPE type_g_xccc_e RECORD
       v          STRING
       END RECORD
DEFINE g_param     type_g_xccc_e
#wangxina 15/03/24 add   end
#end add-point
 
{</section>}
 
{<section id="axcq301.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success   LIKE type_t.num5   #add 150225
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   CALL axcq301_create_temp() RETURNING l_success   #add 150225
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq301_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axcq301_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq301_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq301 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq301_init()   
 
      #進入選單 Menu (="N")
      CALL axcq301_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq301
      
   END IF 
   
   CLOSE axcq301_cl
   
   
 
   #add-point:作業離開前
   CALL axcq301_drop_temp()  #add 150225
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq301.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq301_init()
   #add-point:init段define
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   #CALL cl_set_act_visible_toolbaritem("output,filter",FALSE)  #wangxina 150315 mark
   CALL cl_set_act_visible_toolbaritem("filter",FALSE)  #wangxina 150315 add
   CALL cl_set_act_visible_toolbaritem("qbe_select,qbe_save",FALSE)
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
 
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end
   #160523-00041#1-s-add   
   LET tm.c1 = 'Y'  
   LET tm.c2 = 'Y'  
   LET tm.c3 = 'Y'  
   LET tm.c4 = 'Y'  
   #160523-00041#1-e-add
   #end add-point
 
   CALL axcq301_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq301.default_search" >}
PRIVATE FUNCTION axcq301_default_search()
   #add-point:default_search段define
   
   #end add-point
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcccld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xccc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xccc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xccc003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xccc004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xccc005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xccc006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xccc007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xccc008 = '", g_argv[09], "' AND "
   END IF
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段開始後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq301_ui_dialog()
   DEFINE ls_wc    STRING
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 
   LET g_wc = ''   #只有input条件
   #end add-point
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=1" THEN
      LET g_detail_idx = 1
      CALL axcq301_b_fill()
   ELSE
      CALL axcq301_query()
   END IF
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xccc_d.getLength() TO FORMONLY.h_count
               CALL axcq301_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array
         
         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
#wangxina 15/03/24 add---start    
              IF g_xccc_d.getLength()>0 THEN
                 CALL axcq301_create_temp_table()  
                 CALL axcq301_ins_temp()               
                 LET g_param.v = "axcq301_tmp"
                 CALL axcq301_x01('1=1',g_param.v)  #临时mark for 过单
              END IF
#wangxina 15/03/24 add---end
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq301_query()
               #add-point:ON ACTION query
               NEXT FIELD b_xccc006
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq301_filter()
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
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axcq301_b_fill()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
 
         
         
 
         #add-point:ui_dialog段自定義action
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
               LET g_export_id[1]   = "s_detail1"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
         #end add-point
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前
         
         #end add-point
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq301_b_fill()
            END IF
      
      #  ON ACTION qbeclear   # 條件清除
      #     CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq301_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   CALL axcq301_query2()
   RETURN
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xccc_d.clear()
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
      CONSTRUCT g_wc_table ON xccc006
           FROM s_detail1[1].b_xccc006
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xccc006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccc006
            #add-point:BEFORE FIELD b_xccc006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccc006
            
            #add-point:AFTER FIELD b_xccc006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccc006
         ON ACTION controlp INFIELD b_xccc006
            #add-point:ON ACTION controlp INFIELD b_xccc006
            
            #END add-point
 
         #----<<b_xccc007>>----
         #----<<b_xccc006_desc>>----
         #----<<b_docno>>----
         #----<<b_info>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      
      #end add-point 
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前
      
      #end add-point 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
      #add-point:query段查詢方案相關ACTION設定後
      
      #end add-point 
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   
   #end add-point
        
   LET g_error_show = 1
   CALL axcq301_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axcq301.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq301_b_fill()
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end  
   #CALL axcq301_b_fill2()
   #CALL axcq301_b_fill3()   #160520-00004#1 mark
   CALL axcq301_b_fill4()    #160520-00004#1 add
   RETURN
   #end add-point
 
   #add-point:b_fill段sql_before
   
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
   
   LET g_sql = "SELECT  UNIQUE xccc006,xccc007,'','','' FROM xccc_t",
 
 
               "",
               " WHERE xcccent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("xccc_t")
    
   LET g_sql = g_sql, cl_sql_add_filter("xccc_t"),
                      " ORDER BY xccc_t.xcccld,xccc_t.xccc001,xccc_t.xccc002,xccc_t.xccc003,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
  
   #add-point:b_fill段sql_after
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq301_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xccc_d.clear()
 
   #add-point:陣列清空
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc006_desc, 
       g_xccc_d[l_ac].docno,g_xccc_d[l_ac].info
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xccc_d[l_ac].statepic = cl_get_actipic(g_xccc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL axcq301_detail_show("'1'")      
 
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
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xccc_d.deleteElement(g_xccc_d.getLength())   
 
   #add-point:陣列長度調整
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = g_xccc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axcq301_pb
   
   LET l_ac = 1
   IF g_xccc_d.getLength() > 0 THEN
      CALL axcq301_fetch()
   END IF
   
      CALL axcq301_filter_show('xccc006','b_xccc006')
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq301.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq301_fetch()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
 
   #add-point:陣列清空
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後
   
   #end add-point 
   
 
   #add-point:陣列筆數調整
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq301.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq301_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq301_filter()
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
      CONSTRUCT g_wc_filter ON xccc006
                          FROM s_detail1[1].b_xccc006
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
                     DISPLAY axcq301_filter_parser('xccc006') TO s_detail1[1].b_xccc006
 
 
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
   
      CALL axcq301_filter_show('xccc006','b_xccc006')
 
    
   CALL axcq301_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq301_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="axcq301.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq301_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq301_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.insert" >}
#+ insert
PRIVATE FUNCTION axcq301_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq301.modify" >}
#+ modify
PRIVATE FUNCTION axcq301_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq301_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.delete" >}
#+ delete
PRIVATE FUNCTION axcq301_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq301.other_function" >}

#查询，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq301_query2()
   DEFINE ls_wc       LIKE type_t.chr500
   DEFINE l_success   LIKE type_t.num5
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xccc_d.clear()
   LET g_wc_filter = " 1=1"
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET g_master_idx = l_ac
 
   IF cl_null(tm.xccccomp) THEN
      CALL axcq301_default()  #查询前预设
   END IF
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #單身根據table分拆construct
      #CONSTRUCT g_wc_table ON xccccomp,xccc004,xccc005,xcccld,xccc003
      #     FROM b_xccccomp,b_xccc004,b_xccc005,b_xcccld,b_xccc003,
      #                
      #   BEFORE CONSTRUCT
      #      #add-point:cs段more_construct
      #      DISPLAY tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc003
      #           TO b_xccccomp,b_xcccld,b_xccc004,b_xccc005,b_xccc003
      #      #end add-point 
      #      
      #END CONSTRUCT
 
      INPUT tm.xccccomp,tm.xccc004,tm.xccc005,tm.xcccld ,tm.xccc003,tm.c1,tm.c2,tm.c3,tm.c4
         FROM b_xccccomp,b_xccc004,b_xccc005,b_xcccld ,b_xccc003,b_c1,b_c2,b_c3,b_c4
         ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
            #160921-00010#1 add(s)
            CALL axcq301_default()
            #160921-00010#1 add(e)
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc   #法人組織
            DISPLAY tm.xcccld_desc TO b_xcccld_desc     #帳別編號
            DISPLAY tm.xccc003_desc  TO b_xccc003_desc    #成本計算類型
            
         AFTER FIELD b_xccccomp
            CALL axcq301_chk_column('b_xccccomp') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc
         
         AFTER FIELD b_xcccld
            CALL axcq301_chk_column('b_xcccld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
            DISPLAY tm.xcccld_desc TO b_xcccld_desc
         
         AFTER FIELD b_xccc003
            CALL axcq301_chk_column('b_xccc003') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = tm.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY tm.xccc003_desc TO b_xccc003_desc
         
         AFTER INPUT
            CALL axcq301_chk_column('b_xccccomp+b_xcccld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD b_xccccomp
            END IF
      
         ON ACTION controlp INFIELD b_xccccomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_ooef001_2()                      #呼叫開窗
            LET tm.xccccomp = g_qryparam.return1
            DISPLAY tm.xccccomp TO b_xccccomp  #顯示到畫面上
            
            CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
            DISPLAY tm.xccccomp_desc TO b_xccccomp_desc
            
            NEXT FIELD b_xccccomp                     #返回原欄位

         ON ACTION controlp INFIELD b_xcccld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_authorised_ld()                #呼叫開窗
            LET tm.xcccld = g_qryparam.return1
            DISPLAY tm.xcccld TO b_xcccld  #顯示到畫面上
            
            CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
            DISPLAY tm.xcccld_desc TO b_xcccld_desc
            
            NEXT FIELD b_xcccld                     #返回原欄位
 
         ON ACTION controlp INFIELD b_xccc003   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            LET tm.xccc003 = g_qryparam.return1
            DISPLAY tm.xccc003 TO b_xccc003  #顯示到畫面上
            
            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = tm.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET tm.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY tm.xccc003_desc TO b_xccc003_desc
            
            NEXT FIELD b_xccc003                     #返回原欄位

      END INPUT
 
      ON ACTION accept
         #160523-00041#2-s-add
         IF tm.c1 = 'N' AND tm.c2 = 'N' AND tm.c3 = 'N' AND tm.c4 = 'N' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  'axc-00741'  #請至少勾選一筆查詢選項！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()                       
            NEXT FIELD b_c1
         END IF
         #160523-00041#2-e-add
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
      #add-point:query段查詢方案相關ACTION設定後
         INITIALIZE tm.* TO NULL
      #end add-point 
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
      RETURN  #mod 150216 
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL axcq301_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      #LET g_errparam.code   = -100          #160811-00045#1 mark
      LET g_errparam.code   = "axc-00792"    #160811-00045#1 add
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION

#查询前预设
PRIVATE FUNCTION axcq301_default()

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING tm.xccccomp,tm.xcccld,tm.xccc004,tm.xccc005,tm.xccc003
   #fengmy 150123----begin
   #根據參數顯示隱藏料件特性
   IF cl_null(tm.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xccc007',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xccc007',FALSE)                
   END IF 
   #fengmy 150123----end    
   #说明栏位
   CALL s_desc_get_department_desc(tm.xccccomp) RETURNING tm.xccccomp_desc #法人組織
   CALL s_desc_get_ld_desc(tm.xcccld) RETURNING tm.xcccld_desc #帳別編號
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xccc003_desc = '', g_rtn_fields[1] , ''

END FUNCTION

#检查栏位
PRIVATE FUNCTION axcq301_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr20
   DEFINE r_success     LIKE type_t.num5
   

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'b_xccccomp'  #法人
           IF NOT cl_null(tm.xccccomp) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xccccomp
              #add--160802-00020#7 By shiun--(S)
              #增加帳套權限控制
              IF NOT cl_null(g_wc_cs_comp) THEN
                 LET g_chkparam.where = " ooef001 IN ",g_wc_cs_comp
              END IF
              #add--160802-00020#7 By shiun--(E)
              IF NOT cl_chk_exist("v_ooef001_1") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xcccld'    #帐套
           IF NOT cl_null(tm.xcccld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xcccld
              #160318-00025#8--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              #add--160802-00020#7 By shiun--(S)
              #增加帳套權限控制
              IF NOT cl_null(g_wc_cs_ld) THEN
                 LET g_chkparam.where = " glaald IN ",g_wc_cs_ld
              END IF
              #add--160802-00020#7 By shiun--(E)
              #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_glaald") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xccc003'   #成本计算类型
           IF NOT cl_null(tm.xccc003) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xccc003
              #160318-00025#8--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
              #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_xcat001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'b_xccccomp+b_xcccld'  #法人+帐套
           IF NOT cl_null(tm.xccccomp) AND NOT cl_null(tm.xcccld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = tm.xcccld
              LET g_chkparam.arg2 = tm.xccccomp
              #160318-00025#8--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_glaald_5") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
   END CASE
   RETURN r_success
   
END FUNCTION

#cursor定义
PRIVATE FUNCTION axcq301_cursor()
   DEFINE r_success         LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET g_sql = "SELECT SUM(xcce202),SUM(xcce206),SUM(xcce208),SUM(xcce210),SUM(xcce308) ",
               "  FROM axcq301_xcce ",
               " WHERE xcceent = ",g_enterprise,
               "   AND xccecomp= '",tm.xccccomp,"' ",  #法人组织
               "   AND xcceld  = '",tm.xcccld,"' ",    #帐别
               "   AND xcce001 = ? ",  #帳套本位幣順序
               "   AND xcce002 = ? ",  #成本域
               "   AND xcce003 = '",tm.xccc003,"' ",  #成本计算类别
               "   AND xcce004 = ",tm.xccc004,  #年度
               "   AND xcce005 = ",tm.xccc005,  #期别
               "   AND xcce007 = ? ",  #元件料号
               "   AND xcce008 = ? ",  #元件特性
               "   AND xcce009 = ? "  #批號
   PREPARE axcq301_b_fill_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p1"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c1 CURSOR WITH HOLD FOR axcq301_b_fill_p1

   LET g_sql = "SELECT SUM(xcci302a),SUM(xcci302b),SUM(xcci302c),SUM(xcci302d),SUM(xcci302e),SUM(xcci302f),SUM(xcci302g),SUM(xcci302h), ",
               "       SUM(xcci304a),SUM(xcci304b),SUM(xcci304c),SUM(xcci304d),SUM(xcci304e),SUM(xcci304f),SUM(xcci304g),SUM(xcci304h), ",
               "       SUM(xcci202),SUM(xcci302) ",
               "  FROM xcci_t ",
               " WHERE xccient = ",g_enterprise,
               "   AND xccicomp= '",tm.xccccomp,"' ",  #法人组织
               "   AND xccild  = '",tm.xcccld,"' ",    #帐别
               "   AND xcci001 = ? ",  #帳套本位幣順序
               "   AND xcci002 = ? ",  #成本域
               "   AND xcci003 = '",tm.xccc003,"' ",  #成本计算类别
               "   AND xcci004 = ",tm.xccc004,  #年度
               "   AND xcci005 = ",tm.xccc005,  #期别
               "   AND xcci007 = ? ", #聯產品料號
               "   AND xcci008 = ? ", #特性
               "   AND xcci009 = ? "  #批號
   PREPARE axcq301_b_fill_p2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p2"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c2 CURSOR WITH HOLD FOR axcq301_b_fill_p2

   IF g_sys_6016 = 'N' THEN
      LET g_sql = "SELECT SUM(xcck202*xcck009*-1) ",  #本期本階投入金額
                  "  FROM axcq301_xcck  ",  #xcck_t
                  " WHERE ", #xcck020 IN ('115','302','303','501','107','114') AND xcck047 IS NOT NULL ", #mod当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
                  "    xcckent  = ",g_enterprise,
                  "   AND xcckcomp = '",tm.xccccomp,"' ",  #法人组织
                  "   AND xcckld   = '",tm.xcccld,"' ",    #帐别
                  "   AND xcck001  = ? ",   #帳套本位幣順序
                  "   AND xcck002  = ? ",   #成本域
                  "   AND xcck003  = '",tm.xccc003,"' ",   #成本计算类型
                  "   AND xcck004  = ",tm.xccc004,   #年度
                  "   AND xcck005  = ",tm.xccc005,   #期别
                  "   AND xcck010  = ? ",   #料件
                  "   AND xcck011  = ? ",   #特性
                  "   AND xcck017  = ? "    #批號
   ELSE
      LET g_sql = "SELECT SUM(xcck202*xcck009*-1) ",  #本期本階投入金額
                  "  FROM axcq301_xcck ",   #xcck_t
                  " WHERE ",  #xcck020 IN ('302','303','501','107','114') AND xcck047 IS NOT NULL ", #生产发料,生产退料,盘点,委外回收入库,回收入库
                  "    xcckent  = ",g_enterprise,
                  "   AND xcckcomp = '",tm.xccccomp,"' ",  #法人组织
                  "   AND xcckld   = '",tm.xcccld,"' ",    #帐别
                  "   AND xcck001  = ? ",   #帳套本位幣順序
                  "   AND xcck002  = ? ",   #成本域
                  "   AND xcck003  = '",tm.xccc003,"' ",   #成本计算类型
                  "   AND xcck004  = ",tm.xccc004,   #年度
                  "   AND xcck005  = ",tm.xccc005,   #期别
                  "   AND xcck010  = ? ",   #料件
                  "   AND xcck011  = ? ",   #特性
                  "   AND xcck017  = ? "    #批號
   END IF
   PREPARE axcq301_b_fill_p3 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p3"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c3 CURSOR WITH HOLD FOR axcq301_b_fill_p3

   LET g_sql = "SELECT SUM(xcca102a+xcca102b+xcca102c+xcca102d+xcca102e+xcca102f+xcca102g+xcca102h) ",
               "  FROM xcca_t ",  #期初开帐资料
               " WHERE xccaent = ",g_enterprise,
               "   AND xccald  = '",tm.xcccld,"' ",
               "   AND xcca001 = ? ",
               "   AND xcca002 = ? ",
               "   AND xcca003 = '",tm.xccc003,"' ",
               "   AND xcca004 = ",g_yy,
               "   AND xcca005 = ",g_mm,
               "   AND xcca006 = ? ",
               "   AND xcca007 = ? ",
               "   AND xcca008 = ? ",
               "   AND (xcca101<>0 OR xcca102<>0) "  #开账的那支作业还有另一个用途，补单价
   PREPARE axcq301_b_fill_p4 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p4"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c4 CURSOR WITH HOLD FOR axcq301_b_fill_p4

   LET g_sql = "SELECT xccc902 ",   #本月结存金额
               "  FROM xccc_t ",
               " WHERE xcccent = ",g_enterprise,
               "   AND xcccld  = '",tm.xcccld,"' ",
               "   AND xccc001 = ? ",
               "   AND xccc002 = ? ",
               "   AND xccc003 = '",tm.xccc003,"' ",
               "   AND xccc004 = ",g_yy,
               "   AND xccc005 = ",g_mm,
               "   AND xccc006 = ? ",
               "   AND xccc007 = ? ",
               "   AND xccc008 = ? "
   PREPARE axcq301_b_fill_p5 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p5"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c5 CURSOR WITH HOLD FOR axcq301_b_fill_p5

   LET g_sql = "SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h) ",
               "  FROM xccg_t ",
               " WHERE xccgent = ",g_enterprise,
               "   AND xccgcomp= '",tm.xccccomp,"' ",  #法人组织 #add 141203
               "   AND xccgld  = '",tm.xcccld,"' ",    #帐别
               "   AND xccg001 = ? ",  #帳套本位幣順序
               "   AND xccg002 = ? ",  #成本域
               "   AND xccg003 = '",tm.xccc003,"' ",  #成本计算类别
               "   AND xccg004 = ",tm.xccc004,  #年度
               "   AND xccg005 = ",tm.xccc005,  #期别
              #"   AND xccg006 = ? ",  #工单
               "   AND xccg007 = ? ", #聯產品料號
               "   AND xccg008 = ? ", #特性
               "   AND xccg009 = ? "  #批號
   PREPARE axcq301_b_fill_p6 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p6"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c6 CURSOR WITH HOLD FOR axcq301_b_fill_p6


   LET g_sql = "SELECT xcbb010 FROM xcbb_t ",                                                                  
               " WHERE xcbbent  = ",g_enterprise,  #企業代碼
               "   AND xcbbcomp = '",tm.xccccomp,"' ", #法人組織
               "   AND xcbb001  = ",tm.xccc004,  #年度
               "   AND xcbb002  = ",tm.xccc005,  #期別
               "   AND xcbb003  = ? "  #料號
               #"   AND xcbb004  = ? " #特性  #mark 151109
   PREPARE axcq301_b_fill_p7 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p7"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c7 CURSOR WITH HOLD FOR axcq301_b_fill_p7

   LET g_sql = "SELECT UNIQUE xcbi201,xcbi202,xcbi203,xcbi204 ", #實際工時，實際幾時，標準工時，標準幾時
               "  FROM xcbi_t,xcbh_t ",  #在制報工和統計單身\单头檔
               " WHERE xcbient = xcbhent AND xcbidocno = xcbhdocno ",
               "   AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",  #单据日期
               "   AND xcbi002 = ? "  #工单编号
   PREPARE axcq301_b_fill_p8 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p8"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c8 CURSOR WITH HOLD FOR axcq301_b_fill_p8

   #有无工单资料
   LET g_sql = "SELECT COUNT(*) FROM axcq301_xcce ",
               " WHERE xcceent = ",g_enterprise,
               "   AND xccecomp= '",tm.xccccomp,"' ",  #法人组织
               "   AND xcceld  = '",tm.xcccld,"' ",    #帐别
               "   AND xcce003 = '",tm.xccc003,"' ",   #成本计算类别
               "   AND xcce004 = ",tm.xccc004,
               "   AND xcce005 = ",tm.xccc005, #年度 期别
               "   AND xcce006 = ? ", #工单单号
               "   AND xcce007 = 'DL+OH+SUB' "   #元件料号
   PREPARE axcq301_b_fill_p9 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p9"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c9 CURSOR WITH HOLD FOR axcq301_b_fill_p9

   #是否已结案
   LET g_sql = "SELECT sfaa048 ",  #成本结案日
               "  FROM sfaa_t ",
               " WHERE sfaaent  = ",g_enterprise,
               "   AND sfaadocno= ? "
   PREPARE axcq301_b_fill_p10 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p10"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c10 CURSOR WITH HOLD FOR axcq301_b_fill_p10
   
   LET g_sql = "SELECT xccd902 FROM xccd_t ",  #上月结存金额
               " WHERE xccdent = ",g_enterprise,
               "   AND xccdld  = '",tm.xcccld,"' ",
               "   AND xccd001 = ? ",  #帳套本位幣順序
               "   AND xccd002 = ? ",  #成本域
               "   AND xccd003 = '",tm.xccc003,"'",  #成本計算類型
               "   AND xccd004 = ",g_yy,
               "   AND xccd005 = ",g_mm,
               "   AND xccd006 = ? "  #工單編號
   PREPARE axcq301_b_fill_p11 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p11"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c11 CURSOR WITH HOLD FOR axcq301_b_fill_p11
   
   LET g_sql = "SELECT SUM(xccb102) FROM xccb_t ",  #期初开帐资料
               " WHERE xccbent = ",g_enterprise,
               "   AND xccbld  = '",tm.xcccld,"' ",
               "   AND xccb001 = ? ",  #帳套本位幣順序
               "   AND xccb002 = ? ",  #成本域
               "   AND xccb003 = '",tm.xccc003,"'",  #成本計算類型
               "   AND xccb004 = ",g_yy,
               "   AND xccb005 = ",g_mm,
               "   AND xccb006 = ? "  #工單編號
   PREPARE axcq301_b_fill_p12 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p12"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c12 CURSOR WITH HOLD FOR axcq301_b_fill_p12
   
   
   
   LET g_sql = "SELECT SUM(xcce202),SUM(xcce302),SUM(xcce102),SUM(xcce902),SUM(xcce304), ",
               "       SUM(xcce206),SUM(xcce208),SUM(xcce210) ",
               "  FROM axcq301_xcce ",
               " WHERE xcceent = ",g_enterprise,
               "   AND xccecomp= '",tm.xccccomp,"' ",  #法人组织
               "   AND xcceld  = '",tm.xcccld,"' ",    #帐别
               "   AND xcce001 = ? ",  #帳套本位幣順序
               "   AND xcce002 = ? ",  #成本域
               "   AND xcce003 = '",tm.xccc003,"'",  #成本计算类别
               "   AND xcce004 = ",tm.xccc004,  #年度
               "   AND xcce005 = ",tm.xccc005,  #期别
               "   AND xcce006 = ? "  #工单
   PREPARE axcq301_b_fill_p13 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p13"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c13 CURSOR WITH HOLD FOR axcq301_b_fill_p13
   
   
   LET g_sql = "SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h) ",
               "  FROM xccg_t ",
               " WHERE xccgent = ",g_enterprise,
               "   AND xccgld  = '",tm.xcccld,"' ",    #帐别
               "   AND xccg001 = ? ",  #帳套本位幣順序
               "   AND xccg002 = ? ",  #成本域
               "   AND xccg003 = '",tm.xccc003,"'",  #成本计算类别
               "   AND xccg004 = ",tm.xccc004,  #年度
               "   AND xccg005 = ",tm.xccc005,  #期别
               "   AND xccg006 = ? "  #工单
   PREPARE axcq301_b_fill_p14 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p14"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c14 CURSOR WITH HOLD FOR axcq301_b_fill_p14
   
   LET g_sql = "SELECT xcce901,xcce902 FROM xcce_t ",
               " WHERE xcceent = ",g_enterprise,
               "   AND xcceld  = '",tm.xcccld,"' ",
               "   AND xcce001 = ? ",  #帳套本位幣順序
               "   AND xcce002 = ? ",  #成本域
               "   AND xcce003 = '",tm.xccc003,"'",
               "   AND xcce004 = ",g_yy,
               "   AND xcce005 = ",g_mm,
               "   AND xcce006 = ? ",  #工單編號
               "   AND xcce007 = ? ",  #元件編號
               "   AND xcce008 = ? ",  #特性
               "   AND xcce009 = ? "   #批號
   PREPARE axcq301_b_fill_p15 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p15"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c15 CURSOR WITH HOLD FOR axcq301_b_fill_p15
   
   
   LET g_sql = "SELECT SUM(xccb101),SUM(xccb102) FROM xccb_t ",
               " WHERE xccbent = ",g_enterprise,
               "   AND xccbld  = '",tm.xcccld,"' ",
               "   AND xccb001 = ? ",  #帳套本位幣順序
               "   AND xccb002 = ? ",  #成本域
               "   AND xccb003 = '",tm.xccc003,"'",  #成本計算類型
               "   AND xccb004 = ",g_yy,
               "   AND xccb005 = ",g_mm,
               "   AND xccb006 = ? ",  #工單編號
               "   AND xccb007 = ? ",  #元件編號
               "   AND xccb008 = ? ",  #特性
               "   AND xccb009 = ? "   #批號
   PREPARE axcq301_b_fill_p16 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p16"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_b_fill_c16 CURSOR WITH HOLD FOR axcq301_b_fill_p16
   
   #成本阶检查
   #                          工单    主件     特性     成本阶数     月份    元件    特性    成本阶数   重工否
   LET g_sql = "SELECT UNIQUE xccd006,xccd007,xccd008,aa.xcbb006,xcce005,xcce007,xcce008,bb.xcbb006,sfaa042 ",
               "  FROM (SELECT UNIQUE xccd006,xccd005,xccd007,xccd008,xcbb006 ",
               "          FROM xccd_t,xcbb_t ",
               "         WHERE xccdent = xcbbent AND xccdcomp = xcbbcomp ",
               "           AND xccd004 = xcbb001 AND xccd005  = xcbb002 ", #年度 期别
               #170106-00047#1-s mod   相同料號，即使有不同產品特徵，其成本階都是一樣的
#               "           AND xcce007 = xcbb003 AND xcce008  = xcbb004 ", #料号 特性   #170106-00047#1  mark
               "           AND xccd007 = xcbb003 ",                         #料号 
               #170106-00047#1-e mod
               "           AND xccdent = ",g_enterprise,
               "           AND xccdcomp='",tm.xccccomp,"' ",
               "           AND xccdld  ='",tm.xcccld,"' ",
               "           AND xccd004 = ",tm.xccc004," AND xccd005 = ",tm.xccc005,
               "           AND xccd003='",tm.xccc003,"' ",   #成本計算類型
               "           AND xccd007 = ? AND xccd008 = ?) aa, ",  #料号 特性
               "       (SELECT UNIQUE xcce006,xcce005,xcce007,xcce008,xcbb006 ",
               "          FROM axcq301_xcce,xcbb_t ",
               "         WHERE xcceent = xcbbent AND xccecomp = xcbbcomp ",
               "           AND xcce004 = xcbb001 AND xcce005  = xcbb002 ", #年度 期别
               #170106-00047#1-s mod   相同料號，即使有不同產品特徵，其成本階都是一樣的
#               "           AND xcce007 = xcbb003 AND xcce008  = xcbb004 ", #料号 特性   #170106-00047#1  mark
               "           AND xcce007 = xcbb003 ",                         #料号 
               #170106-00047#1-e mod
               "           AND xcceent = ",g_enterprise,
               "           AND xccecomp='",tm.xccccomp,"' ",
               "           AND xcceld  ='",tm.xcccld,"' ",
               "           AND xcce004 = ",tm.xccc004," AND xcce005 = ",tm.xccc005,
               "           AND xcce003='",tm.xccc003,"') bb, ",  #成本計算類型
               "       sfaa_t  ",
               " WHERE aa.xccd006=bb.xcce006 AND aa.xcbb006>bb.xcbb006 ", #同工单 主件成本阶>元件成本阶
               "   AND sfaadocno = aa.xccd006 ",
               "   AND sfaaent   = ",g_enterprise,
               "   AND (sfaa042 IS NULL OR sfaa042 = ' ' OR sfaa042 = 'N')", #非重工工单
               " ORDER BY xccd007,xccd008,xcce007,xcce008"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_sfaa042_p FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "prepare:axcq301_b_fill_p1"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DECLARE axcq301_sfaa042_c CURSOR WITH HOLD FOR axcq301_sfaa042_p
   
   RETURN r_success
END FUNCTION

#
PRIVATE FUNCTION axcq301_b_fill2()
{
DEFINE l_glaa003   LIKE glaa_t.glaa003
DEFINE ls_msg      STRING
DEFINE l_sfdc001   LIKE sfdc_t.sfdc001  #工单编号
DEFINE l_xccc      RECORD LIKE xccc_t.*  #在制库存
DEFINE l_xccd      RECORD LIKE xccd_t.*  #在制主件
DEFINE l_xcce      RECORD LIKE xcce_t.*  #在制元件
DEFINE l_xcck      RECORD LIKE xcck_t.*  #料件明细
DEFINE l_xccg      RECORD LIKE xccg_t.*  #联产品
#DEFINE l_imaa      RECORD LIKE imaa_t.*
DEFINE l_imaa006   LIKE imaa_t.imaa006  #基础单位
DEFINE l_imaa009   LIKE imaa_t.imaa009  #产品分类
DEFINE l_imaal003  LIKE imaal_t.imaal003
DEFINE l_imaal003_2  LIKE imaal_t.imaal003
DEFINE l_xcce202   LIKE xcce_t.xcce202
DEFINE l_xcce206   LIKE xcce_t.xcce206 #add 141203
DEFINE l_xcce208   LIKE xcce_t.xcce208 #add 141203
DEFINE l_xcce210   LIKE xcce_t.xcce210 #add 141203
DEFINE l_xcce308   LIKE xcce_t.xcce308 #add 141203
DEFINE l_xcck202   LIKE xcck_t.xcck202
DEFINE l_tot       LIKE xccc_t.xccc302  #工单领出金额
DEFINE l_success   LIKE type_t.num5
DEFINE l_xccc902   LIKE xccc_t.xccc902
DEFINE l_inat015   LIKE inat_t.inat015
DEFINE l_sfaa048   LIKE sfaa_t.sfaa048
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_diff      LIKE xccd_t.xccd902
DEFINE l_xcbb010   LIKE xcbb_t.xcbb010  #成本分群
DEFINE l_xccd_xcce RECORD
                   xccd006    LIKE xccd_t.xccd006, #工单
                   xccd007    LIKE xccd_t.xccd007, #主件
                   xccd008    LIKE xccd_t.xccd008, #特性
                   xcbb006a   LIKE xcbb_t.xcbb006, #成本阶数 
                   xcce005    LIKE xcce_t.xcce005, #月份
                   xcce007    LIKE xcce_t.xcce007, #元件
                   xcce008    LIKE xcce_t.xcce008, #特性
                   xcbb006b   LIKE xcbb_t.xcbb006, #成本阶数
                   sfaa042    LIKE sfaa_t.sfaa042  #重工否
                   END RECORD
DEFINE l_xcbi201   LIKE xcbi_t.xcbi201
DEFINE l_xcbi202   LIKE xcbi_t.xcbi202
DEFINE l_xcbi203   LIKE xcbi_t.xcbi203
DEFINE l_xcbi204   LIKE xcbi_t.xcbi204
DEFINE l_xccd902   LIKE xccd_t.xccd902
DEFINE l_xcce902   LIKE xcce_t.xcce902
DEFINE l_xcce901   LIKE xcce_t.xcce901
DEFINE l_xcce102   LIKE xcce_t.xcce102
DEFINE l_xcce302   LIKE xcce_t.xcce302
DEFINE l_xcce304   LIKE xcce_t.xcce304
DEFINE l_xccb101   LIKE xccb_t.xccb101
DEFINE l_xccb102   LIKE xccb_t.xccb102
DEFINE l_xccg302   LIKE xccg_t.xccg302
DEFINE l_xccg302a  LIKE xccg_t.xccg302a
DEFINE l_xccg302b  LIKE xccg_t.xccg302b
DEFINE l_xccg302c  LIKE xccg_t.xccg302c
DEFINE l_xccg302d  LIKE xccg_t.xccg302d
DEFINE l_xccg302e  LIKE xccg_t.xccg302e
DEFINE l_xccg302f  LIKE xccg_t.xccg302f
DEFINE l_xccg302g  LIKE xccg_t.xccg302g
DEFINE l_xccg302h  LIKE xccg_t.xccg302h
DEFINE l_xcci302a  LIKE xcci_t.xcci302a
DEFINE l_xcci302b  LIKE xcci_t.xcci302b
DEFINE l_xcci302c  LIKE xcci_t.xcci302c
DEFINE l_xcci302d  LIKE xcci_t.xcci302d
DEFINE l_xcci302e  LIKE xcci_t.xcci302e
DEFINE l_xcci302f  LIKE xcci_t.xcci302f
DEFINE l_xcci302g  LIKE xcci_t.xcci302g
DEFINE l_xcci302h  LIKE xcci_t.xcci302h
DEFINE l_xcci304a  LIKE xcci_t.xcci304a
DEFINE l_xcci304b  LIKE xcci_t.xcci304b
DEFINE l_xcci304c  LIKE xcci_t.xcci304c
DEFINE l_xcci304d  LIKE xcci_t.xcci304d
DEFINE l_xcci304e  LIKE xcci_t.xcci304e
DEFINE l_xcci304f  LIKE xcci_t.xcci304f
DEFINE l_xcci304g  LIKE xcci_t.xcci304g
DEFINE l_xcci304h  LIKE xcci_t.xcci304h
DEFINE l_xcci302   LIKE xcci_t.xcci302
DEFINE l_xcci202   LIKE xcci_t.xcci202
DEFINE l_xcca102   LIKE xcca_t.xcca102  #期初库存成本开账
DEFINE l_amt1,l_amt2      LIKE xccc_t.xccc102
DEFINE l_qty1,l_qty2      LIKE xccc_t.xccc101
DEFINE l_str1,l_str2,l_str3,l_str      STRING
DEFINE l_xcbz009    LIKE xcbz_t.xcbz009
DEFINE l_xcbz901    LIKE xcbz_t.xcbz901
DEFINE l_xccc006_7        STRING         #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_t      STRING         #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_f LIKE type_t.chr1    #是否第一次执行这个料件+特性 150216 add

   #计算起止日期
   SELECT glaa003 INTO l_glaa003  #會計週期參照表號
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaa014 = 'Y'  #主帐套
      AND glaacomp = tm.xccccomp
   CALL s_fin_date_get_period_range(l_glaa003,tm.xccc004,tm.xccc005)
       RETURNING g_bdate,g_edate
   #取上期的年度/期别
   CALL s_fin_date_get_last_period(l_glaa003,tm.xcccld,tm.xccc004,tm.xccc005)
        RETURNING l_success,g_yy,g_mm
   IF NOT l_success THEN
      RETURN
   END IF

   #add 150212
   #根据成本计算类型抓取计价方式 主要用于判断g_xcat005='3'否
   SELECT xcat005 INTO g_xcat005 FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = tm.xccc003 #成本计算类型
   #add 150212
   
   #初始化
   CALL g_xccc_d.clear()  #g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].docno,g_xccc_d[l_ac].info
   LET l_ac = 0   
   
   LET g_sys_6004 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6004') #add 141203
   LET g_sys_6016 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6016') #add 150215
   
   #add 150225
   #缩小xcck范围，提高效能
   CALL axcq301_delete_temp()
   #xcck 将下面判断中需要用到的资料插入到临时表中
   IF g_sys_6016 = 'N' THEN
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('115','302','303','501','107','114')  #異動類型:当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
   ELSE
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('302','303','501','107','114')  #異動類型:生产发料,生产退料,盘点,委外回收入库,回收入库
   END IF
   #xcce 将下面判断中需要用到的资料插入到临时表中
   INSERT INTO axcq301_xcce
      SELECT * FROM xcce_t
       WHERE xcceent  = g_enterprise
         AND xccecomp = tm.xccccomp #法人组织
         AND xcceld   = tm.xcccld   #帐别
         AND xcce003  = tm.xccc003  #成本计算类型
         AND xcce004  = tm.xccc004  #年度
         AND xcce005  = tm.xccc005  #期别
         
   #161121-00007#1-add-s
   
   #161121-00007#1-add-e
   CREATE INDEX axcq301_xcce_i01 ON axcq301_xcce(xcce001,xcce002,xcce006,xcce007,xcce008);
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE UNIQUE INDEX axcq301_xcce_i01"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   IF cl_db_generate_analyze("axcq301_xcce") THEN END IF
   #xcbz
   INSERT INTO axcq301_xcbz
      SELECT * FROM xcbz_t
       WHERE xcbzent  = g_enterprise
         AND xcbzcomp = tm.xccccomp #法人组织
         AND xcbzld   = tm.xcccld   #帐别
         AND xcbz001  = tm.xccc004  #年度
         AND xcbz002  = tm.xccc005  #期别
         AND EXISTS (select 1 from inaa_t   #成本库否
                      where inaaent =xcbzent
                        and inaasite=xcbzsite
                        and inaa001 = xcbz006
                        and inaa010 = 'Y')
   #add 150225 end
   
   #定义游标
   CALL axcq301_cursor() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   #定义游标   
   #对在制工单做检查
   LET g_sql = " SELECT * FROM xccd_t  ",
               "  WHERE xccdent = ",g_enterprise,
               "    AND xccdcomp='",tm.xccccomp,"' ", #法人组织
               "    AND xccdld  ='",tm.xcccld,"' ",  #帐别
               "    AND xccd003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xccd004 = ",tm.xccc004," AND xccd005 = ",tm.xccc005, #年度 期别
               "    AND xccd007 = ? AND xccd008 = ? "   #主件料号 特性
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_xccd_p FROM g_sql
   DECLARE axcq301_xccd_c CURSOR FOR axcq301_xccd_p

   #在制工单元件检查
   LET g_sql = " SELECT axcq301_xcce.*,imaal003 ",
               "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xcce007 AND imaal002='"||g_dlang||"' ",
               "  WHERE xcceent = ",g_enterprise,
               "    AND xccecomp='",tm.xccccomp,"' ", #法人组织
               "    AND xcceld  ='",tm.xcccld,"' ",  #帐别
               "    AND xcce003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xcce004 = ",tm.xccc004," AND xcce005 = ",tm.xccc005, #年度 期别
               "    AND xcce001 = ? ",  #帳套本位幣順序
               "    AND xcce002 = ? ",  #成本域 
               "    AND xcce006 = ? "   #工单
               #"    AND (xcce901 < 0   OR xcce902a < 0 OR xcce902b < 0 ", #本月结存数量 本月结存材料金额 本月结存人工金额
               #"     OR xcce902d < 0 OR xcce902e < 0 OR xcce902f < 0 OR xcce902g < 0 OR xcce902h < 0  ",  #本月结存制费金额
               #"     OR  xcce902c < 0 OR xcce902 < 0   ", #本月结存加工金额 本月结存金额
               #"     OR ((xcce101+xcce201)=0 AND (xcce102+xcce202)!=0))" #上月结存数量+本月投入数量 上月结存金额+本月投入金额
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_xcce_p FROM g_sql
   DECLARE axcq301_xcce_c CURSOR FOR axcq301_xcce_p
   
   #-------------------------------------------
   #检查发料单中工单不存在于工单维护作业中
   LET g_sql = " SELECT UNIQUE sfdc001 FROM sfdc_t,sfda_t ",
               "  WHERE sfdcent = sfdaent AND sfdcdocno = sfdadocno ",
               "    AND sfdastus != 'X' ",
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = sfdcent and sfaadocno=sfdc001) ",
               "    AND sfda002 NOT IN ('16','26') ",
               "    AND sfdasite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')",
               " UNION ",
               " SELECT UNIQUE sfdb001 FROM sfdb_t,sfda_t ",
               "  WHERE sfdbent = sfdaent AND sfdbdocno = sfdadocno ",
               "    AND sfdastus != 'X' ",
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = sfdbent and sfaadocno=sfdb001) ",
               "    AND sfda002 IN ('15','25') ",
               "    AND sfdasite IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
               "    AND ooefstus ='Y' AND ooef017 ='",tm.xccccomp,"')"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_sfdc_p FROM g_sql
   DECLARE axcq301_sfdc_c CURSOR FOR axcq301_sfdc_p
   FOREACH axcq301_sfdc_c INTO l_sfdc001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:axcq301_sfdc_c" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      CALL cl_getmsg('axc-00401',g_lang) RETURNING ls_msg  #工單不存在工單維護作業中
      LET g_xccc_d[l_ac].xccc006      = ''  #料号
      LET g_xccc_d[l_ac].xccc007      = ''  #特征
      LET g_xccc_d[l_ac].xccc006_desc = ''  #品名
      LET g_xccc_d[l_ac].docno        = l_sfdc001  #单据编号
      LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
   END FOREACH
   CLOSE axcq301_sfdc_c
   FREE axcq301_sfdc_p

   #判断xccc_t：料件庫存成本期異動統計檔
   LET g_sql = "SELECT UNIQUE xccc_t.*,imaa_t.imaa006,imaa_t.imaa009,imaal003 ",
               "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
               "              LEFT JOIN imaa_t ON imaaent='"||g_enterprise||"' AND imaa001=xccc006 ",
               " WHERE xcccent  = ",g_enterprise,
               "   AND xccccomp ='",tm.xccccomp,"' ", #法人组织
               "   AND xcccld   ='",tm.xcccld,"' ",  #帐别
               "   AND xccc003  ='",tm.xccc003,"' ", #成本计算类型
               "   AND xccc004  = ",tm.xccc004,  #年度
               "   AND xccc005  = ",tm.xccc005,  #期别
               " ORDER BY xccc006,xccc007 "  #add 150216
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   LET g_sql_tmp = g_sql  #wangxina 15/03/24 add
   PREPARE axcq301_xccc_p FROM g_sql
   DECLARE axcq301_xccc_c CURSOR FOR axcq301_xccc_p
   FOREACH axcq301_xccc_c INTO l_xccc.*,l_imaa006,l_imaa009,l_imaal003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add 150216
      LET l_xccc006_7 = l_xccc.xccc006,'+',l_xccc.xccc007,'end'  #当笔料件+特性
      IF cl_null(l_xccc006_7_t) OR l_xccc006_7_t!=l_xccc006_7 THEN
         LET l_xccc006_7_t = l_xccc.xccc006,'+',l_xccc.xccc007,'end'
         LET l_xccc006_7_f = 'Y'  #下面需要执行USING xccc006+xccc007的
      ELSE
         LET l_xccc006_7_f = 'N'  #下面不需执行USING xccc006+xccc007的 重复的不用再判断
      END IF
      #add 150216 end
      
      #--检查采购单价是否为0
      #IF l_xccc.xccc280 = 0 THEN  #本期平均单价 #mark 141203
      IF l_xccc.xccc201!=0 AND l_xccc.xccc202=0 THEN  #采购入库数量  采购入库金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00402',g_lang) RETURNING ls_msg  #采购单价为0
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      ELSE
         IF l_xccc.xccc280 = 0 THEN  #本期平均单价 #add 141203
            #期初.期末數量=0及各項數量=0時，不要印出"無單位成本資料請輸入調整資料(axct002)"的訊息
            IF l_xccc.xccc101 = 0 AND l_xccc.xccc201 = 0 AND l_xccc.xccc203 = 0 AND #上期結存數量 本期採購入庫 本期委外入庫
               l_xccc.xccc205 = 0 AND l_xccc.xccc207 = 0 AND l_xccc.xccc209 = 0 AND #本期工單入庫 本期重工領出 本期重工入庫
               l_xccc.xccc211 = 0 AND l_xccc.xccc213 = 0 AND l_xccc.xccc215 = 0 AND #本期雜項入庫 本期調整入庫 本期銷退入庫
               l_xccc.xccc217 = 0 AND l_xccc.xccc301 = 0 AND l_xccc.xccc303 = 0 AND #本期調撥入庫 本期工單領用 本期銷貨數量
               l_xccc.xccc305 = 0 AND l_xccc.xccc307 = 0 AND l_xccc.xccc309 = 0 AND #本期銷退數量 本期銷售費用 本期雜發數量
               l_xccc.xccc311 = 0 AND l_xccc.xccc313 = 0 AND l_xccc.xccc901 = 0     #本期盤盈虧   本期調撥出庫 期末結存數量
            THEN
            ELSE
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00403',g_lang) RETURNING ls_msg  #無單位成本資料請輸入調整資料 
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = ''      #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
         END IF #add 141203
      END IF
      #END IF #mark 141203

      #--检查料件編號無產品分類
      IF cl_null(l_imaa009) THEN #產品分類
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00404',g_lang) RETURNING ls_msg  #料件編號無產品分類
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #检查投入与发料
      LET l_tot = (l_xccc.xccc302+l_xccc.xccc208) * -1   #本期工單領用金額 + 本期重工領出金額
      #LET l_tot = (l_xccc.xccc302+l_xccc.xccc208)   #本期工單領用金額 + 本期重工領出金額 mod 141216
      LET l_xcce202 = 0 LET l_xcck202 = 0
      LET l_xcce206 = 0 LET l_xcce208 = 0 LET l_xcce210 = 0 LET l_xcce308= 0 #add 141203
      #检查投入与发料--投入与发料不符合xccc_t
      #mod 141203
      ##SELECT SUM(xcce202) INTO l_xcce202   #本期本階投入金額 from 在制元件成本期異動統計檔 
      #SELECT SUM(xcce202),SUM(xcce206),SUM(xcce208),SUM(xcce210),SUM(xcce308)
      #  INTO l_xcce202,l_xcce206,l_xcce208,l_xcce210,l_xcce308
      ##mod 141203 --end
      #  FROM axcq301_xcce
      # WHERE xcceent = g_enterprise
      #   AND xccecomp= l_xccc.xccccomp  #法人组织
      #   AND xcceld  = l_xccc.xcccld    #帐别
      #   AND xcce001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xcce002 = l_xccc.xccc002  #成本域
      #   AND xcce003 = l_xccc.xccc003  #成本计算类别
      #   AND xcce004 = tm.xccc004  #年度
      #   AND xcce005 = tm.xccc005  #期别 
      #   AND xcce007 = l_xccc.xccc006  #元件料号 
      #   AND xcce008 = l_xccc.xccc007  #元件特性
      #   AND xcce009 = l_xccc.xccc008  #批號
      OPEN axcq301_b_fill_c1 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c1 INTO l_xcce202,l_xcce206,l_xcce208,l_xcce210,l_xcce308
      CLOSE axcq301_b_fill_c1
      IF l_xcce202 IS NULL THEN LET l_xcce202 = 0 END IF
      IF l_xcce206 IS NULL THEN LET l_xcce206 = 0 END IF  #add 141203
      IF l_xcce208 IS NULL THEN LET l_xcce208 = 0 END IF  #add 141203
      IF l_xcce210 IS NULL THEN LET l_xcce210 = 0 END IF  #add 141203
      IF l_xcce308 IS NULL THEN LET l_xcce308 = 0 END IF  #add 141203
      #LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210 + l_xcce308  #add 141203
      ##LET l_xcce202 = l_xcce202 - l_xcce206 + l_xcce208 + l_xcce210 + l_xcce308  #mod 141216
      LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210  #add 150112
      
      
      #add 141203 拆件式 转出金额和差异转出 和下面xccg共用
      LET l_xcci302a=0 LET l_xcci302b=0 LET l_xcci302c=0
      LET l_xcci302d=0 LET l_xcci302e=0 LET l_xcci302f=0
      LET l_xcci302g=0 LET l_xcci302h=0
      LET l_xcci304a=0 LET l_xcci304b=0 LET l_xcci304c=0
      LET l_xcci304d=0 LET l_xcci304e=0 LET l_xcci304f=0
      LET l_xcci304g=0 LET l_xcci304h=0
      LET l_xcci202 =0 LET l_xcci302 =0
      #SELECT SUM(xcci302a),SUM(xcci302b),SUM(xcci302c),SUM(xcci302d),SUM(xcci302e),SUM(xcci302f),SUM(xcci302g),SUM(xcci302h),
      #       SUM(xcci304a),SUM(xcci304b),SUM(xcci304c),SUM(xcci304d),SUM(xcci304e),SUM(xcci304f),SUM(xcci304g),SUM(xcci304h),
      #       SUM(xcci202),SUM(xcci302)
      #  INTO l_xcci302a,l_xcci302b,l_xcci302c,l_xcci302d,l_xcci302e,l_xcci302f,l_xcci302g,l_xcci302h,  #本期轉出金額
      #       l_xcci304a,l_xcci304b,l_xcci304c,l_xcci304d,l_xcci304e,l_xcci304f,l_xcci304g,l_xcci304h,  #本期差异转出金額
      #       l_xcci202,l_xcci302
      #  FROM xcci_t
      # WHERE xccient = l_xccc.xcccent
      #   AND xccicomp= l_xccc.xccccomp  #法人组织
      #   AND xccild  = l_xccc.xcccld    #帐别
      #   AND xcci001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xcci002 = l_xccc.xccc002  #成本域
      #   AND xcci003 = l_xccc.xccc003  #成本计算类别
      #   AND xcci004 = tm.xccc004  #年度
      #   AND xcci005 = tm.xccc005  #期别 
      #   AND xcci007 = l_xccc.xccc006 #聯產品料號
      #   AND xcci008 = l_xccc.xccc007 #特性
      #   AND xcci009 = l_xccc.xccc008 #批號
      OPEN axcq301_b_fill_c2 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c2 INTO l_xcci302a,l_xcci302b,l_xcci302c,l_xcci302d,l_xcci302e,l_xcci302f,l_xcci302g,l_xcci302h,  #本期轉出金額
                                   l_xcci304a,l_xcci304b,l_xcci304c,l_xcci304d,l_xcci304e,l_xcci304f,l_xcci304g,l_xcci304h,  #本期差异转出金額
                                   l_xcci202,l_xcci302
      CLOSE axcq301_b_fill_c2
      IF cl_null(l_xcci302a) THEN LET l_xcci302a = 0 END IF
      IF cl_null(l_xcci302b) THEN LET l_xcci302b = 0 END IF
      IF cl_null(l_xcci302c) THEN LET l_xcci302c = 0 END IF
      IF cl_null(l_xcci302d) THEN LET l_xcci302d = 0 END IF
      IF cl_null(l_xcci302e) THEN LET l_xcci302e = 0 END IF
      IF cl_null(l_xcci302f) THEN LET l_xcci302f = 0 END IF
      IF cl_null(l_xcci302g) THEN LET l_xcci302g = 0 END IF
      IF cl_null(l_xcci302h) THEN LET l_xcci302h = 0 END IF
      IF cl_null(l_xcci304a) THEN LET l_xcci304a = 0 END IF
      IF cl_null(l_xcci304b) THEN LET l_xcci304b = 0 END IF
      IF cl_null(l_xcci304c) THEN LET l_xcci304c = 0 END IF
      IF cl_null(l_xcci304d) THEN LET l_xcci304d = 0 END IF
      IF cl_null(l_xcci304e) THEN LET l_xcci304e = 0 END IF
      IF cl_null(l_xcci304f) THEN LET l_xcci304f = 0 END IF
      IF cl_null(l_xcci304g) THEN LET l_xcci304g = 0 END IF
      IF cl_null(l_xcci304h) THEN LET l_xcci304h = 0 END IF
      IF cl_null(l_xcci202) THEN LET l_xcci202=0 END IF
      IF cl_null(l_xcci302) THEN LET l_xcci302=0 END IF
      #add 141203--end
      
      #IF l_xcce202 != l_tot AND (l_xcce202-l_tot > 1 OR l_tot-l_xcce202 > 1) THEN
      #IF l_xcce202+l_xcci202 != l_tot AND (l_xcce202+l_xcci202-l_tot > 1 OR l_tot-l_xcce202-l_xcci202 > 1) THEN #mod 141203
      IF l_xcce202+l_xcci202+l_xcci302 != l_tot AND (l_xcce202+l_xcci202+l_xcci302-l_tot > 1 OR l_tot-l_xcce202-l_xcci202-l_xcci302 > 1) THEN #mod 150108
         LET l_ac = l_ac + 1
         #CALL cl_getmsg('axc-00405',g_lang) RETURNING ls_msg  #投入%1与发料%2不符合（xcce_t&xcci_t与xccc_t）
         LET l_str1 = l_xcce202+l_xcci202+l_xcci302
         LET l_str2 = l_tot
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00405',g_lang,l_str) RETURNING ls_msg #投入与发料不符合（xcce_t&xcci_t与xccc_t）
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      #检查投入与发料--投入与发料不符合xcck_t
      #mark 150215
      ##SELECT SUM(xcck202) INTO l_xcck202  #本期本階投入金額
      #SELECT SUM(xcck202*xcck009*-1) INTO l_xcck202  #本期本階投入金額
      ##SELECT SUM(xcck202*xcck009) INTO l_xcck202  #本期本階投入金額 #mod 141216
      #  FROM xcck_t,inaj_t   #工单单号,特性,本期異動金額 from 本期料件明細進去成本檔
      # WHERE xcckent = inajent AND xccksite = inajsite
      #   AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003   #单号 项次 项序
      #   AND xcck009 = inaj004   # 出入库码
      #   AND inaj022 BETWEEN g_bdate AND g_edate   #單據扣帳日期
      #   #AND (  (inaj015 in ('aint330','aint340','aint350','aint360') 
      #   #        AND inaj036 in ('103','104','105','106','107','110','111','112','113','114','115','302','303') )   #异动单据性质=调拨 库存异动类型is工单
      #   #     OR ( inaj036='401' AND inaj015 MATCHES 'asft*' )   #库存异动类型=调拨 异动单据性质is工单
      #   #     )
      #   #AND inaj035 NOT MATCHES 'asft340*'   #異動作業代號 去除工單完工入退庫者
      #   #AND EXISTS (select 1 from inaa_t    #库位
      #   #             where inaaent = inajent
      #   #               and inaasite = inajsite 
      #   #               and inaa001 = inaj008 
      #   #               and inaa010 = 'Y')  #成本库否
      #   AND xcck020 IN ('115','302','303','501','107','114') AND xcck047 IS NOT NULL  #mod当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
      #   AND xcckent  = g_enterprise
      #   AND xcckcomp = l_xccc.xccccomp  #法人组织
      #   AND xcckld   = l_xccc.xcccld    #帐别
      #   AND xcck001  = l_xccc.xccc001   #帳套本位幣順序
      #   AND xcck002  = l_xccc.xccc002   #成本域
      #   AND xcck003  = l_xccc.xccc003   #成本计算类型
      #   AND xcck004  = tm.xccc004   #年度
      #   AND xcck005  = tm.xccc005   #期别
      #   AND xcck010  = l_xccc.xccc006   #料件
      #   AND xcck011  = l_xccc.xccc007   #特性
      #   AND xcck017  = l_xccc.xccc008   #批號
      #mark 150215 end
      #add 150215 當站下線是否影響成本  差距在xcck020条件中的115
      #IF g_sys_6016 = 'N' THEN  #mod Y->N 影响成本，则不会放在发料中,发料不影响成本(同s_axcp500中)
      #   SELECT SUM(xcck202*xcck009*-1) INTO l_xcck202  #本期本階投入金額
      #     FROM axcq301_xcck   #xcck_t#,inaj_t   #工单单号,特性,本期異動金額 from 本期料件明細進去成本檔
      #    WHERE #xcckent = inajent AND xccksite = inajsite
      #      #AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003   #单号 项次 项序
      #      #AND xcck009 = inaj004   # 出入库码
      #      #AND inaj022 BETWEEN g_bdate AND g_edate   #單據扣帳日期
      #      #AND  #mark 150216 去除inaj_t的关联，xcck004\xcck005条件即是inaj022的条件
      #      #xcck020 IN ('115','302','303','501','107','114') AND xcck047 IS NOT NULL  #mod当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
      #      xcckent  = g_enterprise
      #      AND xcckcomp = l_xccc.xccccomp  #法人组织
      #      AND xcckld   = l_xccc.xcccld    #帐别
      #      AND xcck001  = l_xccc.xccc001   #帳套本位幣順序
      #      AND xcck002  = l_xccc.xccc002   #成本域
      #      AND xcck003  = l_xccc.xccc003   #成本计算类型
      #      AND xcck004  = tm.xccc004   #年度
      #      AND xcck005  = tm.xccc005   #期别
      #      AND xcck010  = l_xccc.xccc006   #料件
      #      AND xcck011  = l_xccc.xccc007   #特性
      #      AND xcck017  = l_xccc.xccc008   #批號
      #ELSE
      #   SELECT SUM(xcck202*xcck009*-1) INTO l_xcck202  #本期本階投入金額
      #     FROM axcq301_xcck  #xcck_t#,inaj_t   #工单单号,特性,本期異動金額 from 本期料件明細進去成本檔
      #    WHERE #xcckent = inajent AND xccksite = inajsite
      #      #AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003   #单号 项次 项序
      #      #AND xcck009 = inaj004   # 出入库码
      #      #AND inaj022 BETWEEN g_bdate AND g_edate   #單據扣帳日期
      #      #AND   #mark 150216 去除inaj_t的关联，xcck004\xcck005条件即是inaj022的条件
      #      #xcck020 IN ('302','303','501','107','114') AND xcck047 IS NOT NULL  #生产发料,生产退料,盘点,委外回收入库,回收入库
      #      xcckent  = g_enterprise
      #      AND xcckcomp = l_xccc.xccccomp  #法人组织
      #      AND xcckld   = l_xccc.xcccld    #帐别
      #      AND xcck001  = l_xccc.xccc001   #帳套本位幣順序
      #      AND xcck002  = l_xccc.xccc002   #成本域
      #      AND xcck003  = l_xccc.xccc003   #成本计算类型
      #      AND xcck004  = tm.xccc004   #年度
      #      AND xcck005  = tm.xccc005   #期别
      #      AND xcck010  = l_xccc.xccc006   #料件
      #      AND xcck011  = l_xccc.xccc007   #特性
      #      AND xcck017  = l_xccc.xccc008   #批號
      #END IF
      OPEN axcq301_b_fill_c3 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c3 INTO l_xcck202
      CLOSE axcq301_b_fill_c3
      #add 150215 end
      IF l_xcck202 IS NULL THEN LET l_xcck202 = 0 END IF 
      #IF l_xcce202 != l_xcck202 THEN
      IF l_xcce202+l_xcci202 != l_xcck202 THEN  #mod 141203
         LET l_ac = l_ac + 1
         #CALL cl_getmsg('axc-00406',g_lang) RETURNING ls_msg  #投入与发料不符合xcck_t
         LET l_str1 = l_xcce202 + l_xcci202
         LET l_str2 = l_xcck202
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00406',g_lang,l_str) RETURNING ls_msg #投入%1与发料%2不符合xcck_t
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查销货有数量，无金额
      IF (l_xccc.xccc303 != 0 AND l_xccc.xccc304 = 0 AND l_xccc.xccc280 != 0)      #销货数量 销货成本 成本单价
      OR (l_xccc.xccc307 != 0 AND l_xccc.xccc308 = 0 AND l_xccc.xccc280 != 0) THEN #销售数量 销售成本 成本单价
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00407',g_lang) RETURNING ls_msg  #本月銷貨有數量，但無金額請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查销货有金额，无数量
      IF (l_xccc.xccc303 = 0 AND l_xccc.xccc304 != 0)      #销货数量 销货成本
      OR (l_xccc.xccc307 = 0 AND l_xccc.xccc308 != 0) THEN #销售数量 销售成本
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00408',g_lang) RETURNING ls_msg  #本月銷貨有金額，但無數量請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
 
      #--检查发料单有数量无金额
      IF l_xccc.xccc301 != 0 AND l_xccc.xccc302 = 0 AND  l_xccc.xccc280 != 0 THEN #工单领用数量 工单领用金额 成本单价
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00409',g_lang) RETURNING ls_msg  #本月發料單有數量但無金額請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查发料单有金额没数量
      IF l_xccc.xccc301 = 0 AND l_xccc.xccc302 != 0 THEN #工单领用数量 工单领用金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00410',g_lang) RETURNING ls_msg  #本月發料單有金額但無數量請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查重工领出有数量无金额
      IF (l_xccc.xccc207 > 0 OR l_xccc.xccc207 < 0 ) AND (l_xccc.xccc208a = 0 OR l_xccc.xccc208 = 0) THEN #重工领出数量 重工领出材料金额 重工领出金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00411',g_lang) RETURNING ls_msg  #本月重工領出有數量但無金額請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查杂项领用有数量无金额
      #add 141203
      CASE g_sys_6004
         WHEN '1'  #系统设定
      #add 141203--end
              IF l_xccc.xccc211 !=0 AND l_xccc.xccc212 = 0 AND  l_xccc.xccc280 != 0 THEN
                 LET l_ac = l_ac + 1
                 CALL cl_getmsg('axc-00412',g_lang) RETURNING ls_msg  #本月雜項領用有数量但無金額請做調整
                 LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
                 LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
                 LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
                 LET g_xccc_d[l_ac].docno        = ''      #单据编号
                 LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
              END IF
      #add 141203
         WHEN '2'  #人工设定 
              IF l_xccc.xccc211 !=0 AND l_xccc.xccc212 = 0 THEN
                 LET l_ac = l_ac + 1
                 CALL cl_getmsg('axc-00412',g_lang) RETURNING ls_msg  #本月雜項領用有数量但無金額請做調整
                 LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
                 LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
                 LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
                 LET g_xccc_d[l_ac].docno        = ''      #单据编号
                 LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
              END IF
      END CASE
      #add 141203--end

      #--检查杂项领用有金额无数量
      IF l_xccc.xccc211 = 0 AND l_xccc.xccc212 != 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00413',g_lang) RETURNING ls_msg  #本月雜項領用有金額但無数量請做調整
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF

      #--检查本月结存有金额无数量
      IF l_xccc.xccc901 = 0 and l_xccc.xccc902 != 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00414',g_lang) RETURNING ls_msg  #本月結存數量为零但結存金額有值
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存数量为负
      IF l_xccc.xccc901 < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00415',g_lang) RETURNING ls_msg  #本月結存數量為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存合计金额为负
      IF l_xccc.xccc902 < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00416',g_lang) RETURNING ls_msg  #本月結存合計金額為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存材料金额为负
      IF l_xccc.xccc902a < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00417',g_lang) RETURNING ls_msg  #本月結存材料金額為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存人工成本为负
      IF l_xccc.xccc902b < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00418',g_lang) RETURNING ls_msg  #本月結存人工成本為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存制费成本为负
      IF l_xccc.xccc902d < 0 OR l_xccc.xccc902e < 0 OR l_xccc.xccc902f < 0 OR l_xccc.xccc902g < 0 OR l_xccc.xccc902h < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00419',g_lang) RETURNING ls_msg  #本月結存製費成本為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月结存加工成本为负
      IF l_xccc.xccc902c < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00420',g_lang) RETURNING ls_msg  #本月結存加工成本為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF

      LET l_xccc902 = 0
      #--本月期初金額<>上月期末金額
      LET l_xcca102 = NULL
      #SELECT SUM(xcca102a+xcca102b+xcca102c+xcca102d+xcca102e+xcca102f+xcca102g+xcca102h) INTO l_xcca102 FROM xcca_t  #期初开帐资料
      # WHERE xccaent = l_xccc.xcccent
      #   AND xccald  = l_xccc.xcccld 
      #   AND xcca001 = l_xccc.xccc001
      #   AND xcca002 = l_xccc.xccc002
      #   AND xcca003 = l_xccc.xccc003
      #   AND xcca004 = g_yy
      #   AND xcca005 = g_mm
      #   AND xcca006 = l_xccc.xccc006
      #   AND xcca007 = l_xccc.xccc007
      #   AND xcca008 = l_xccc.xccc008
      OPEN axcq301_b_fill_c4 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c4 INTO l_xcca102
      CLOSE axcq301_b_fill_c4
      IF NOT cl_null(l_xcca102) THEN
         LET l_xccc902 = l_xcca102
      ELSE
         #SELECT xccc902 INTO l_xccc902   #本月结存金额
         #  FROM xccc_t
         # WHERE xcccent = l_xccc.xcccent
         #   AND xcccld  = l_xccc.xcccld 
         #   AND xccc001 = l_xccc.xccc001
         #   AND xccc002 = l_xccc.xccc002
         #   AND xccc003 = l_xccc.xccc003
         #   AND xccc004 = g_yy
         #   AND xccc005 = g_mm
         #   AND xccc006 = l_xccc.xccc006
         #   AND xccc007 = l_xccc.xccc007
         #   AND xccc008 = l_xccc.xccc008
         OPEN axcq301_b_fill_c5 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
         FETCH axcq301_b_fill_c5 INTO l_xccc902
         CLOSE axcq301_b_fill_c5
         IF cl_null(l_xccc902) THEN LET l_xccc902 = 0 END IF
      END IF

      IF l_xccc.xccc102 <> l_xccc902 THEN
         LET l_ac = l_ac + 1
         LET l_str1 = l_xccc.xccc102
         LET l_str2 = l_xccc902
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00421',g_lang,l_str) RETURNING ls_msg  #“本期期初金额”%1不等于 “上期期末金额”%2
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--本月結存數量與MFG之期末數量不合
      #mod 150108
      #SELECT SUM(inat015) INTO l_inat015 #期末數量
      #  FROM inat_t,inag_t
      # WHERE inatent = inagent AND inatsite = inagsite
      #   AND inat001 = inag001 AND inat002 = inag002
      #   AND inat003 = inag003 AND inat004 = inag004
      #   AND inat005 = inag005 AND inag006 = inag006
      #   AND inat007 = inag007
      #   AND inatent = l_xccc.xcccent
      #   AND inat001 = l_xccc.xccc006  #料件編號 
      #   AND inat002 = l_xccc.xccc007  #产品特征
      #   #AND inat003 =#庫存管理特徵
      #   #mark 141203
      #   #AND EXISTS (select 1 from inaa_t   #库位編號
      #   #             where inaaent = inatent and inaasite = inatsite and inaa001 = inat004
      #   #               and inaa010 = 'Y')  #成本库否
      #   #mark 141203--end
      #   #AND inat005 =#儲位編號
      #   AND inat006 = l_xccc.xccc008 #批號
      #   #AND inat007 =#庫存單位
      #   AND inat008 = tm.xccc004 #年度
      #   AND inat009 = tm.xccc005 #期别
      LET g_sql = "SELECT xcbz009,SUM(xcbz901) ", #單位,期末数量
                  #"  FROM xcbz_t ",
                  #"  FROM axcq301_xcbz LEFT JOIN inaa_t ON inaaent = xcbzent AND inaasite = xcbzsite AND inaa001=xcbz006 ", #Mod 150212
                  "  FROM axcq301_xcbz ", #mod 150225 效能优化
                  " WHERE xcbzent = ",l_xccc.xcccent,
                  "   AND xcbzld  ='",l_xccc.xcccld,"' ", #帳套
                      #AND xcbzsite#營運據點
                  "   AND xcbz001 = ",tm.xccc004, #年度
                  "   AND xcbz002 = ",tm.xccc005, #期別
                  "   AND xcbz003 ='",l_xccc.xccc006,"' "  #料件編號
                      #AND xcbz005 #庫存管理特徵
                      #AND xcbz006 #倉庫編碼
                      #AND xcbz007 #儲位編號
                  #"   AND inaa010 = 'Y' "  #成本库否 add 150212 #mark 150225
      IF g_para_data1 = 'Y' THEN #采用特性 add 150212
         LET g_sql = g_sql CLIPPED," AND xcbz004 ='",l_xccc.xccc007,"' "  #特性
      END IF #add 150212
      IF g_xcat005 = '3' THEN #批次成本 add 150212
         LET g_sql = g_sql CLIPPED," AND xcbz008 ='",l_xccc.xccc008,"' "  #批號
      END IF #add 150212
      LET g_sql = g_sql CLIPPED," GROUP BY xcbz009 "
      PREPARE axcq301_xcbz_p FROM g_sql
      DECLARE axcq301_xcbz_c CURSOR FOR axcq301_xcbz_p
      LET l_inat015 = 0
      FOREACH axcq301_xcbz_c INTO l_xcbz009,l_xcbz901  #單位,期末数量
         IF cl_null(l_xcbz901) THEN LET l_xcbz901 = 0 END IF
         IF l_xcbz009 = l_imaa006 THEN
            LET l_inat015 = l_inat015 + l_xcbz901
         ELSE
            CALL s_aooi250_convert_qty(l_xccc.xccc006,l_xcbz009,l_imaa006,l_xcbz901)
               RETURNING l_success,g_qty_t
            IF l_success THEN
               LET l_xcbz901 = g_qty_t
            END IF
            LET l_inat015 = l_inat015 + l_xcbz901
         END IF
      END FOREACH
      #mod 150108 end
      IF l_xccc.xccc901 <> l_inat015 THEN
         LET l_ac = l_ac + 1
         LET l_str1 = l_xccc.xccc901
         LET l_str2 = l_inat015
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00422',g_lang,l_str) RETURNING ls_msg  #本月结存数量%1与MFG之期末数量不合%2
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月平均單價
      IF l_xccc.xccc901 != 0 THEN #期末結存數量
         #--检查本月平均單價為零
         IF l_xccc.xccc280 = 0 AND   (l_xccc.xccc205 !=0 OR l_xccc.xccc209!=0) THEN #本期平均單價 本期工單入庫數量 本期重工入庫數量
            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00423',g_lang) RETURNING ls_msg  #本月平均單價為零
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''      #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
         END IF
      END IF
         
      #--检查本月材料平均單價為負
      IF l_xccc.xccc280a < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00424',g_lang) RETURNING ls_msg  #本月材料平均單價為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月人工平均單價為負
      IF l_xccc.xccc280b < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00425',g_lang) RETURNING ls_msg  #本月人工平均單價為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月製費平均單價為負
      IF l_xccc.xccc280d<0 OR l_xccc.xccc280e<0 OR l_xccc.xccc280f<0 OR l_xccc.xccc280g<0 OR l_xccc.xccc280h<0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00426',g_lang) RETURNING ls_msg  #本月製費平均單價為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #--检查本月加工平均單價為負
      IF l_xccc.xccc280c < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00427',g_lang) RETURNING ls_msg  #本月加工平均單價為負
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
      
      #---------以下对在制工单的检查begin
      IF l_xccc006_7_f = 'Y' THEN  #add 150216
         FOREACH axcq301_xccd_c USING l_xccc.xccc006,l_xccc.xccc007 INTO l_xccd.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:axcq301_xccd_c" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #--检查本月有工時,但無工單資料或已結案
            LET l_xcbi201 = 0
            LET l_xcbi202 = 0
            LET l_xcbi203 = 0
            LET l_xcbi204 = 0
            #SELECT UNIQUE xcbi201,xcbi202,xcbi203,xcbi204 #實際工時，實際幾時，標準工時，標準幾時
            #  INTO l_xcbi201,l_xcbi202,l_xcbi203,l_xcbi204
            #  FROM xcbi_t,xcbh_t  #在制報工和統計單身\单头檔
            # WHERE xcbient = xcbhent AND xcbidocno = xcbhdocno
            #   AND xcbh001 BETWEEN g_bdate AND g_edate  #单据日期
            #   AND xcbi002 = l_xccd.xccd006  #工单编号
            OPEN axcq301_b_fill_c8 USING l_xccd.xccd006  #工单编号
            FETCH axcq301_b_fill_c8 INTO l_xcbi201,l_xcbi202,l_xcbi203,l_xcbi204
            CLOSE axcq301_b_fill_c8
            IF (l_xcbi201 IS NOT NULL AND l_xcbi201 <> 0) OR (l_xcbi202 IS NOT NULL AND l_xcbi202 <> 0)
            OR (l_xcbi203 IS NOT NULL AND l_xcbi203 <> 0) OR (l_xcbi204 IS NOT NULL AND l_xcbi204 <> 0) THEN 
               #有无工单资料
               #SELECT COUNT(*) INTO l_cnt FROM axcq301_xcce
               # WHERE xcceent = g_enterprise
               #   AND xccecomp= tm.xccccomp  #法人组织
               #   AND xcceld  = tm.xcccld    #帐别
               #   AND xcce003 = tm.xccc003   #成本计算类别
               #   AND xcce004 = tm.xccc004 AND xcce005 = tm.xccc005 #年度 期别
               #   AND xcce006 = l_xccd.xccd006 #工单单号
               #   AND xcce007 = 'DL+OH+SUB'    #元件料号
               OPEN axcq301_b_fill_c9 USING l_xccd.xccd006  #工单编号
               FETCH axcq301_b_fill_c9 INTO l_cnt
               CLOSE axcq301_b_fill_c9
               #是否已结案
               #SELECT sfaa048 INTO l_sfaa048 #成本结案日 
               #  FROM sfaa_t
               # WHERE sfaaent  = g_enterprise
               #   AND sfaadocno= l_xccd.xccd006
               OPEN axcq301_b_fill_c10 USING l_xccd.xccd006  #工单编号
               FETCH axcq301_b_fill_c10 INTO l_sfaa048
               CLOSE axcq301_b_fill_c10
               IF (l_xccd.xccd102+l_xccd.xccd202+l_xccd.xccd204) = 0  #上期結存金額+本期本階投入金額+本期下階投入金額
               OR l_cnt = 0  #无工单资料
               OR (l_sfaa048 IS NOT NULL AND l_sfaa048 < g_bdate)  #已结案
               THEN
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00428',g_lang) RETURNING ls_msg  #本月有工時，但無工單DL+OH+SUB資料或工單已結案
                  LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
               END IF
            END IF
         
            #####-----检查主件-----#####begin
            #--检查主件 本月轉出>上月結存+本月投入
            IF l_xccd.xccd301 > (l_xccd.xccd101 + l_xccd.xccd201) THEN #本月转出数量>上月结存数量+本月投入数量
               LET l_ac = l_ac + 1
               LET l_str1 = l_xccd.xccd301
               LET l_str2 = l_xccd.xccd101 + l_xccd.xccd201
               LET l_str = l_str1.trim(),'|',l_str2.trim()
               CALL cl_getmsg_parm('axc-00429',g_lang,l_str) RETURNING ls_msg  #本月轉出%1 > 上月結存 + 本月投入%2
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末數量為零，金額不為零
            IF l_xccd.xccd901 = 0 AND l_xccd.xccd902 != 0 THEN  #期末結存數量 金额
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00430',g_lang) RETURNING ls_msg  #在製成本(主件)期末數量為零，金額不為零
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末金額為零，數量不為零
            IF l_xccd.xccd901 != 0 AND l_xccd.xccd902 = 0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00431',g_lang) RETURNING ls_msg  #在製成本(主件)期末金額為零，數量不為零
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末金額為負
            IF l_xccd.xccd902 < 0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00432',g_lang) RETURNING ls_msg  #在製成本(主件)期末金額為負
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末材料金額為負
            IF l_xccd.xccd902a < 0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00433',g_lang) RETURNING ls_msg  #在製成本(主件)期末材料金額為負
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末人工金額為負
            IF l_xccd.xccd902b < 0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00434',g_lang) RETURNING ls_msg  #在製成本(主件)期末人工金額為負
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末製費金額為負
            IF l_xccd.xccd902d<0 OR l_xccd.xccd902e<0 OR l_xccd.xccd902f<0 OR l_xccd.xccd902g<0 OR l_xccd.xccd902h<0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00435',g_lang) RETURNING ls_msg  #在製成本(主件)期末製費金額為負
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製成本(主件)期末加工金額為負
            IF l_xccd.xccd902c < 0 THEN
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00436',g_lang) RETURNING ls_msg  #在製成本(主件)期末加工金額為負
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 主件(期初+投入)量=0,但(期初+投入)金額<>0
            IF (l_xccd.xccd101+l_xccd.xccd201) = 0 AND (l_xccd.xccd102+l_xccd.xccd202+l_xccd.xccd204) <> 0 THEN #上月结存数量+本月投入数量 上月结存金额+本月投入金额
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00437',g_lang) RETURNING ls_msg  #主件(期初+投入)量為0，但(期初+投入)金額不為0
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製轉出(主件)金額為負值
            IF l_xccd.xccd302 > 0 THEN #本期轉出金額
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00438',g_lang) RETURNING ls_msg  #在製轉出(主件)金額為負值
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
            END IF
            
            #--检查主件 在製主件期初不等于上月期末，差异为***
            LET l_xccd902 = NULL
            #SELECT xccd902 INTO l_xccd902 FROM xccd_t #上月结存金额
            # WHERE xccdent = l_xccd.xccdent
            #   AND xccdld  = l_xccd.xccdld 
            #   AND xccd001 = l_xccd.xccd001
            #   AND xccd002 = l_xccd.xccd002
            #   AND xccd003 = l_xccd.xccd003
            #   AND xccd004 = g_yy
            #   AND xccd005 = g_mm
            #   AND xccd006 = l_xccd.xccd006
            OPEN axcq301_b_fill_c11 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
            FETCH axcq301_b_fill_c11 INTO l_xccd902
            CLOSE axcq301_b_fill_c11
            IF cl_null(l_xccd902) THEN LET l_xccd902 = 0 END IF
            
            LET l_xccb102 = NULL
            #SELECT SUM(xccb102) INTO l_xccb102 FROM xccb_t  #期初开帐资料
            # WHERE xccbent = l_xccd.xccdent
            #   AND xccbld  = l_xccd.xccdld 
            #   AND xccb001 = l_xccd.xccd001  #帳套本位幣順序
            #   AND xccb002 = l_xccd.xccd002  #成本域
            #   AND xccb003 = l_xccd.xccd003  #成本計算類型
            #   AND xccb004 = g_yy
            #   AND xccb005 = g_mm
            #   AND xccb006 = l_xccd.xccd006  #工單編號
            OPEN axcq301_b_fill_c12 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
            FETCH axcq301_b_fill_c12 INTO l_xccb102
            CLOSE axcq301_b_fill_c12
            IF NOT cl_null(l_xccb102) THEN LET l_xccd902 = l_xccb102 END IF
            
            IF l_xccd902 != l_xccd.xccd102 THEN
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd102 - l_xccd902
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00439',g_lang) RETURNING ls_msg  #在製主件期初不等於上月期末，差异为:
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            
            #--检查主件 
            LET l_xcce202 = 0 LET l_xcce302 = 0
            LET l_xcce102 = 0 LET l_xcce902 = 0
            LET l_xcce304 = 0
            LET l_xcce206 = 0 LET l_xcce208 = 0 LET l_xcce210 = 0 #add 141203
            #SELECT SUM(xcce202),SUM(xcce302),SUM(xcce102),SUM(xcce902),SUM(xcce304),
            #       SUM(xcce206),SUM(xcce208),SUM(xcce210)  #add 141203
            #  INTO l_xcce202,l_xcce302,l_xcce102,l_xcce902,l_xcce304,
            #       l_xcce206,l_xcce208,l_xcce210 #add 141203
            #  FROM axcq301_xccd_c
            # WHERE xcceent = g_enterprise
            #   AND xccecomp= l_xccd.xccdcomp  #法人组织
            #   AND xcceld  = l_xccd.xccdld    #帐别
            #   AND xcce001 = l_xccd.xccd001  #帳套本位幣順序
            #   AND xcce002 = l_xccd.xccd002  #成本域
            #   AND xcce003 = l_xccd.xccd003  #成本计算类别
            #   AND xcce004 = tm.xccc004  #年度
            #   AND xcce005 = tm.xccc005  #期别 
            #   AND xcce006 = l_xccd.xccd006  #工单
            OPEN axcq301_b_fill_c13 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
            FETCH axcq301_b_fill_c13 INTO l_xcce202,l_xcce302,l_xcce102,l_xcce902,l_xcce304,
                                          l_xcce206,l_xcce208,l_xcce210 #add 141203
            CLOSE axcq301_b_fill_c13
            IF cl_null(l_xcce202) THEN LET l_xcce202 = 0 END IF #本期本階投入金額
            IF cl_null(l_xcce302) THEN LET l_xcce302 = 0 END IF #本期轉出金額
            IF cl_null(l_xcce102) THEN LET l_xcce102 = 0 END IF #上期結存金額
            IF cl_null(l_xcce902) THEN LET l_xcce902 = 0 END IF #期末結存金額
            IF cl_null(l_xcce304) THEN LET l_xcce304 = 0 END IF #差異轉出金額
            IF cl_null(l_xcce206) THEN LET l_xcce206 = 0 END IF #add 141203
            IF cl_null(l_xcce208) THEN LET l_xcce208 = 0 END IF #add 141203
            IF cl_null(l_xcce210) THEN LET l_xcce210 = 0 END IF #add 141203
            LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210 #add 141203
            #--检查主件 在製投入(主件)金額不等于在製投入(元件)金額，差异为**
            IF l_xccd.xccd202 + l_xccd.xccd204 <> l_xcce202 THEN #本期本階投入金額+本期下階投入金額 != 元件投入金额
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd202 + l_xccd.xccd204 - l_xcce202 
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00440',g_lang) RETURNING ls_msg  #在製投入(主件)金額不等於在製投入(元件)金額，差异为：
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            
            #--检查主件 在製转出(主件)金額不等于在製转出(元件)金額，差异为**
            IF l_xccd.xccd302 <> l_xcce302 THEN #元件转出金额
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd302 - l_xcce302 
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00441',g_lang) RETURNING ls_msg  #在製转出(主件)金額不等於在製转出(元件)金額，差异为：
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            
            #--检查主件 在製期初(主件)金額不等于在製期初(元件)金額，差异为**
            IF l_xccd.xccd102 <> l_xcce102 THEN #元件期初金额
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd102 - l_xcce102 
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00442',g_lang) RETURNING ls_msg  #在製期初(主件)金額不等於在製期初(元件)金額，差异为：
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            
            #--检查主件 在製期未(主件)金額不等于在製期未(元件)金額，差异为**
            IF l_xccd.xccd902 <> l_xcce902 THEN  #元件期未金额
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd902 - l_xcce902 
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00443',g_lang) RETURNING ls_msg  #在製期未(主件)金額不等於在製期未(元件)金額，差异为：
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            
            #--检查主件 在製差异(主件)金額不等于在製差异(元件)金額，差异为**
            IF l_xccd.xccd304 <> l_xcce304 THEN  #元件差异金额
               LET l_ac = l_ac + 1
               LET l_diff = l_xccd.xccd304 - l_xcce304 
               IF l_diff < 0 THEN
                  LET l_diff = l_diff * -1
               END IF
               CALL cl_getmsg('axc-00444',g_lang) RETURNING ls_msg  #在製差异(主件)金額不等於在製差异(元件)金額，差异为：
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
            END IF
            #####-----检查主件-----#####end
            
            #####-----检查元件-----#####begin
            FOREACH axcq301_xcce_c USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序 成本域 工单
               INTO l_xcce.*,l_imaal003_2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "FOREACH:axcq301_xcce_c" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT FOREACH
               END IF
               
               IF l_xcce.xcce902 < 0 THEN  #本月结存金额
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00455',g_lang) RETURNING ls_msg  #在制成本(元件)期末金额为负
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce902a < 0 THEN  #本月结存材料金额
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00456',g_lang) RETURNING ls_msg  #在製成本(元件)期末材料金額為負
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce902b < 0 THEN  #本月结存人工金额
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00457',g_lang) RETURNING ls_msg  #在製成本(元件)期末人工金額為負
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce902d < 0 OR l_xcce.xcce902e < 0 OR l_xcce.xcce902f < 0 OR l_xcce.xcce902g < 0 OR l_xcce.xcce902h < 0 THEN  #本月结存制费金额
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00458',g_lang) RETURNING ls_msg  #在製成本(元件)期末製費金額為負
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce902c < 0 THEN  #本月结存加工金额 
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00459',g_lang) RETURNING ls_msg  #在製成本(元件)期末加工金額為負
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce901 < 0 THEN  #本月结存数量 
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00460',g_lang) RETURNING ls_msg  #在製成本(元件)期末數量為負
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               IF l_xcce.xcce101+l_xcce.xcce201=0 AND l_xcce.xcce102+l_xcce.xcce202 !=0 AND l_xcce.xcce007!='DL+OH+SUB' THEN #上月结存数量+本月投入数量 上月结存金额+本月投入金额
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00461',g_lang) RETURNING ls_msg  #元件(期初+投入)量為0，但(期初+投入)金額不為0
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
         
               IF l_xcce.xcce302 > 0 THEN #本期转出金额(后台存储为负值)
                  LET l_ac = l_ac + 1
                  CALL cl_getmsg('axc-00462',g_lang) RETURNING ls_msg  #在製轉出(元件)金額為負值
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF            
         
               LET l_xcce901 = 0 LET l_xcce902 = 0  #本月结存数量　本月结存金额
               #SELECT xcce901,xcce902 INTO l_xcce901,l_xcce902 FROM xcce_t
               # WHERE xcceent = l_xcce.xcceent
               #   AND xcceld  = l_xcce.xcceld 
               #   AND xcce001 = l_xcce.xcce001
               #   AND xcce002 = l_xcce.xcce002
               #   AND xcce003 = l_xcce.xcce003
               #   AND xcce004 = g_yy
               #   AND xcce005 = g_mm
               #   AND xcce006 = l_xcce.xcce006
               #   AND xcce007 = l_xcce.xcce007
               #   AND xcce008 = l_xcce.xcce008
               #   AND xcce009 = l_xcce.xcce009
               OPEN axcq301_b_fill_c15 USING l_xcce.xcce001,l_xcce.xcce002,l_xcce.xcce006,l_xcce.xcce007,l_xcce.xcce008,l_xcce.xcce009
               FETCH axcq301_b_fill_c15 INTO l_xcce901,l_xcce902
               CLOSE axcq301_b_fill_c15
               IF l_xcce901 IS NULL THEN LET l_xcce901 = 0 END IF 
               IF l_xcce902 IS NULL THEN LET l_xcce902 = 0 END IF 
         
               LET l_xccb101 = NULL  LET l_xccb102 = NULL
               #SELECT SUM(xccb101),SUM(xccb102) INTO l_xccb101,l_xccb102 FROM xccb_t
               # WHERE xccbent = l_xcce.xcceent
               #   AND xccbld  = l_xcce.xcceld 
               #   AND xccb001 = l_xcce.xcce001  #帳套本位幣順序
               #   AND xccb002 = l_xcce.xcce002  #成本域
               #   AND xccb003 = l_xcce.xcce003  #成本計算類型
               #   AND xccb004 = g_yy
               #   AND xccb005 = g_mm
               #   AND xccb006 = l_xcce.xcce006  #工單編號
               #   AND xccb007 = l_xcce.xcce007  #元件編號
               #   AND xccb008 = l_xcce.xcce008  #特性
               #   AND xccb009 = l_xcce.xcce009  #批號
               OPEN axcq301_b_fill_c16 USING l_xcce.xcce001,l_xcce.xcce002,l_xcce.xcce006,l_xcce.xcce007,l_xcce.xcce008,l_xcce.xcce009
               FETCH axcq301_b_fill_c16 INTO l_xccb101,l_xccb102
               CLOSE axcq301_b_fill_c16
               IF NOT cl_null(l_xccb101) THEN LET l_xcce901 = l_xccb101 END IF
               IF NOT cl_null(l_xccb102) THEN LET l_xcce902 = l_xccb102 END IF
         
               IF l_xcce901 != l_xcce.xcce101 THEN  #上期期末結存數量 上期結存數量
                  LET l_ac = l_ac + 1
                  LET l_diff = l_xcce901 - l_xcce.xcce101 
                  IF l_diff < 0 THEN
                     LET l_diff = l_diff * -1
                  END IF
                  CALL cl_getmsg('axc-00463',g_lang) RETURNING ls_msg  #在製元件期初數量不等於上期期末數量，差異為：
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
               END IF 
         
               IF l_xcce902 != l_xcce.xcce102 THEN  #上期期末結存金额 上期結存金额
                  LET l_ac = l_ac + 1
                  LET l_diff = l_xcce902 - l_xcce.xcce102 
                  IF l_diff < 0 THEN
                     LET l_diff = l_diff * -1
                  END IF
                  CALL cl_getmsg('axc-00464',g_lang) RETURNING ls_msg  #在製元件期初金額不等於上期期末金額，差異為：
                  LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
                  LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
                  LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg,l_diff  #错误信息
               END IF
            END FOREACH  #xcce(foreach for xcce end)
            #####-----检查元件-----#####end
           
            #####-----检查联产品-----#####begin 与在制的检查
            LET l_xccg302a=0 LET l_xccg302b=0 LET l_xccg302c=0
            LET l_xccg302d=0 LET l_xccg302e=0 LET l_xccg302f=0
            LET l_xccg302g=0 LET l_xccg302h=0
            #SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h)
            #  INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
            #  FROM xccg_t
            # WHERE xccgent = l_xccd.xccdent
            #   AND xccgld  = l_xccd.xccdld    #帐别
            #   AND xccg001 = l_xccd.xccd001  #帳套本位幣順序
            #   AND xccg002 = l_xccd.xccd002  #成本域
            #   AND xccg003 = l_xccd.xccd003  #成本计算类别
            #   AND xccg004 = tm.xccc004  #年度
            #   AND xccg005 = tm.xccc005  #期别 
            #   AND xccg006 = l_xccd.xccd006  #工单
            #   #AND xccg007 = #聯產品料號
            #   #AND xccg008 = #特性
            #   #AND xccg009 = #批號
            OPEN axcq301_b_fill_c14 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
            FETCH axcq301_b_fill_c14 INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
            CLOSE axcq301_b_fill_c14
            IF NOT cl_null(l_xccg302a) OR NOT cl_null(l_xccg302b) OR NOT cl_null(l_xccg302c)
            OR NOT cl_null(l_xccg302d) OR NOT cl_null(l_xccg302e) OR NOT cl_null(l_xccg302f)
            OR NOT cl_null(l_xccg302g) OR NOT cl_null(l_xccg302h) 
            THEN #add 150212 无资料就不需勾稽联产品
               IF cl_null(l_xccg302a) THEN LET l_xccg302a = 0 END IF
               IF cl_null(l_xccg302b) THEN LET l_xccg302b = 0 END IF
               IF cl_null(l_xccg302c) THEN LET l_xccg302c = 0 END IF
               IF cl_null(l_xccg302d) THEN LET l_xccg302d = 0 END IF
               IF cl_null(l_xccg302e) THEN LET l_xccg302e = 0 END IF
               IF cl_null(l_xccg302f) THEN LET l_xccg302f = 0 END IF
               IF cl_null(l_xccg302g) THEN LET l_xccg302g = 0 END IF
               IF cl_null(l_xccg302h) THEN LET l_xccg302h = 0 END IF
               LET l_xccg302a = l_xccg302a * -1
               LET l_xccg302b = l_xccg302b * -1
               LET l_xccg302c = l_xccg302c * -1
               LET l_xccg302d = l_xccg302d * -1
               LET l_xccg302e = l_xccg302e * -1
               LET l_xccg302f = l_xccg302f * -1
               LET l_xccg302g = l_xccg302g * -1
               LET l_xccg302h = l_xccg302h * -1
               #IF l_xccg302a !=  l_xccd.xccd302a+l_xccd.xccd304a THEN #mod 141203 add xccd304
               IF l_xccg302a !=  l_xccd.xccd302a THEN #mod 141203 add xccd304 #mod 150112
                  LET l_ac = l_ac + 1
                  LET l_str1 = l_xccg302a
                  LET l_str2 = l_xccd.xccd302a
                  LET l_str = l_str1.trim(),'|',l_str2.trim()
                  CALL cl_getmsg_parm('axc-00445',g_lang,l_str) RETURNING ls_msg  ##工單聯產品材料轉出合計%1 不等於 工單材料轉出%2
                  LET g_xccc_d[l_ac].xccc006      = '' #料号
                  LET g_xccc_d[l_ac].xccc007      = '' #特征
                  LET g_xccc_d[l_ac].xccc006_desc = '' #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               #IF l_xccg302b !=  l_xccd.xccd302b+l_xccd.xccd304b THEN #mod 141203 add xccd304
               IF l_xccg302b !=  l_xccd.xccd302b THEN #mod 141203 add xccd304 #mod 150112
                  LET l_ac = l_ac + 1
                  LET l_str1 = l_xccg302b
                  LET l_str2 = l_xccd.xccd302b
                  LET l_str = l_str1.trim(),'|',l_str2.trim()
                  CALL cl_getmsg_parm('axc-00446',g_lang,l_str) RETURNING ls_msg  #工單聯產品人工轉出合計%1 不等於 工單人工轉出%2
                  LET g_xccc_d[l_ac].xccc006      = '' #料号
                  LET g_xccc_d[l_ac].xccc007      = '' #特征
                  LET g_xccc_d[l_ac].xccc006_desc = '' #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               #IF l_xccg302d != l_xccd.xccd302d+l_xccd.xccd304d OR l_xccg302e != l_xccd.xccd302e+l_xccd.xccd304e
               #OR l_xccg302f != l_xccd.xccd302f+l_xccd.xccd304f OR l_xccg302g != l_xccd.xccd302g+l_xccd.xccd304g
               #OR l_xccg302h != l_xccd.xccd302h+l_xccd.xccd304h THEN #mod 141203 add xccd304
               IF l_xccg302d != l_xccd.xccd302d OR l_xccg302e != l_xccd.xccd302e
               OR l_xccg302f != l_xccd.xccd302f OR l_xccg302g != l_xccd.xccd302g
               OR l_xccg302h != l_xccd.xccd302h THEN #mod 141203 add xccd304 #mod 150112 拿掉xccd304
                  LET l_ac = l_ac + 1
                  CASE
                     WHEN l_xccg302d != l_xccd.xccd302d
                          LET l_str1 = l_xccg302d
                          LET l_str2 = l_xccd.xccd302d
                     WHEN l_xccg302e != l_xccd.xccd302e
                          LET l_str1 = l_xccg302e
                          LET l_str2 = l_xccd.xccd302e
                     WHEN l_xccg302f != l_xccd.xccd302f
                          LET l_str1 = l_xccg302f
                          LET l_str2 = l_xccd.xccd302f
                     WHEN l_xccg302g != l_xccd.xccd302g
                          LET l_str1 = l_xccg302g
                          LET l_str2 = l_xccd.xccd302g
                     WHEN l_xccg302h != l_xccd.xccd302h
                          LET l_str1 = l_xccg302h
                          LET l_str2 = l_xccd.xccd302h
                  END CASE
                  LET l_str = l_str1.trim(),'|',l_str2.trim()
                  CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING ls_msg  #工單聯產品制费轉出合計%1 不等於 工單制费轉出%2
                  LET g_xccc_d[l_ac].xccc006      = '' #料号
                  LET g_xccc_d[l_ac].xccc007      = '' #特征
                  LET g_xccc_d[l_ac].xccc006_desc = '' #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
               
               #IF l_xccg302c !=  l_xccd.xccd302c+l_xccd.xccd304c THEN #mod 141203 add xccd304
               IF l_xccg302c !=  l_xccd.xccd302c THEN #mod 141203 add xccd304 #mod 150112
                  LET l_ac = l_ac + 1
                  LET l_str1 = l_xccg302c
                  LET l_str2 = l_xccd.xccd302c
                  LET l_str = l_str1.trim(),'|',l_str2.trim()
                  CALL cl_getmsg_parm('axc-00448',g_lang,l_str) RETURNING ls_msg  #工單聯產品加工轉出合計%1 不等於 工單加工轉出%2
                  LET g_xccc_d[l_ac].xccc006      = '' #料号
                  LET g_xccc_d[l_ac].xccc007      = '' #特征
                  LET g_xccc_d[l_ac].xccc006_desc = '' #品名
                  LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
                  LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
               END IF
            END IF #add 150212 end
            #####-----检查联产品-----#####end 与在制的检查
         END FOREACH  #xccd(foreach for xccd end)
      END IF  #add 150216
      #在制工单的检查----------end 

      #####-----检查联产品+拆件品-----#####end 与xccc库存的检查
      LET l_xccg302a=0 LET l_xccg302b=0 LET l_xccg302c=0
      LET l_xccg302d=0 LET l_xccg302e=0 LET l_xccg302f=0
      LET l_xccg302g=0 LET l_xccg302h=0
      #SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h)
      #  INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      #  FROM xccg_t
      # WHERE xccgent = l_xccc.xcccent
      #   AND xccgcomp= l_xccc.xccccomp  #法人组织 #add 141203
      #   AND xccgld  = l_xccc.xcccld    #帐别
      #   AND xccg001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xccg002 = l_xccc.xccc002  #成本域
      #   AND xccg003 = l_xccc.xccc003  #成本计算类别
      #   AND xccg004 = tm.xccc004  #年度
      #   AND xccg005 = tm.xccc005  #期别 
      #   #AND xccg006 = l_xccd.xccd006  #工单
      #   AND xccg007 = l_xccc.xccc006 #聯產品料號
      #   AND xccg008 = l_xccc.xccc007 #特性
      #   AND xccg009 = l_xccc.xccc008 #批號
      OPEN axcq301_b_fill_c6 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c6 INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      CLOSE axcq301_b_fill_c6
      IF NOT cl_null(l_xccg302a) OR NOT cl_null(l_xccg302b) OR NOT cl_null(l_xccg302c)
      OR NOT cl_null(l_xccg302d) OR NOT cl_null(l_xccg302e) OR NOT cl_null(l_xccg302f)
      OR NOT cl_null(l_xccg302g) OR NOT cl_null(l_xccg302h) 
      THEN #add 150212 无资料就不需勾稽联产品
         IF cl_null(l_xccg302a) THEN LET l_xccg302a = 0 END IF
         IF cl_null(l_xccg302b) THEN LET l_xccg302b = 0 END IF
         IF cl_null(l_xccg302c) THEN LET l_xccg302c = 0 END IF
         IF cl_null(l_xccg302d) THEN LET l_xccg302d = 0 END IF
         IF cl_null(l_xccg302e) THEN LET l_xccg302e = 0 END IF
         IF cl_null(l_xccg302f) THEN LET l_xccg302f = 0 END IF
         IF cl_null(l_xccg302g) THEN LET l_xccg302g = 0 END IF
         IF cl_null(l_xccg302h) THEN LET l_xccg302h = 0 END IF
         
         #IF l_xccg302a != l_xccc.xccc202a + l_xccc.xccc210a THEN
         #IF l_xccg302a != l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a THEN #本月转出金额  委外入库+重工入库+工单入库
         #IF l_xccg302a-l_xcci302a != l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a THEN #本月转出金额  委外入库+重工入库+工单入库 #mod 141203
         #mod 150113
         #IF (l_xccg302a-l_xcci302a)-(l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a) > 0.1 #mod 141204
         #OR (l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a)-(l_xccg302a-l_xcci302a) > 0.1
         #IF (l_xccg302a)-(l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a) > 0.1 #mod 141204 #mark 150425
         IF (l_xccg302a)-(l_xccc.xccc210a + l_xccc.xccc206a) > 0.1 #add 150425
         #OR (l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a)-(l_xccg302a) > 0.1 #mark 150215
         #mod 150113 end
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302a
            LET l_str2 = l_xccc.xccc210a + l_xccc.xccc206a
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00449',g_lang,l_str) RETURNING ls_msg  #聯產品材料合計%1 不等於 材料入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      
         #IF l_xccg302b != l_xccc.xccc202b + l_xccc.xccc210b THEN
         #IF l_xccg302b != l_xccc.xccc204b + l_xccc.xccc210b + l_xccc.xccc206b THEN #本月转出金额  委外入库+重工入库+工单入库
         #IF l_xccg302b-l_xcci302b != l_xccc.xccc204b + l_xccc.xccc210b + l_xccc.xccc206b THEN #本月转出金额  委外入库+重工入库+工单入库 #mod 141203
         #IF (l_xccg302b-l_xcci302b)-(l_xccc.xccc204b + l_xccc.xccc210b + l_xccc.xccc206b) > 0.1 #mod 141204  #mark 150425
         IF (l_xccg302b)-(l_xccc.xccc210b + l_xccc.xccc206b) > 0.1 #add 150425
         #OR (l_xccc.xccc204b + l_xccc.xccc210b + l_xccc.xccc206b)-(l_xccg302b-l_xcci302b) > 0.1 #mark 150215
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302b
            LET l_str2 = l_xccc.xccc210b + l_xccc.xccc206b
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00450',g_lang,l_str) RETURNING ls_msg  #聯產品人工合計%1 不等於 人工入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      
         #IF l_xccg302d != l_xccc.xccc202d + l_xccc.xccc210d 
         #OR l_xccg302e != l_xccc.xccc202e + l_xccc.xccc210e
         #OR l_xccg302f != l_xccc.xccc202f + l_xccc.xccc210f
         #OR l_xccg302g != l_xccc.xccc202g + l_xccc.xccc210g
         #OR l_xccg302h != l_xccc.xccc202h + l_xccc.xccc210h THEN
         #IF l_xccg302d != l_xccc.xccc204d + l_xccc.xccc210d + l_xccc.xccc206d      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302e != l_xccc.xccc204e + l_xccc.xccc210e + l_xccc.xccc206e      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302f != l_xccc.xccc204f + l_xccc.xccc210f + l_xccc.xccc206f      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302g != l_xccc.xccc204g + l_xccc.xccc210g + l_xccc.xccc206g      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302h != l_xccc.xccc204h + l_xccc.xccc210h + l_xccc.xccc206h THEN #本月转出金额  委外入库+重工入库+工单入库
         #IF l_xccg302d-l_xcci302d != l_xccc.xccc204d + l_xccc.xccc210d + l_xccc.xccc206d      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302e-l_xcci302e != l_xccc.xccc204e + l_xccc.xccc210e + l_xccc.xccc206e      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302f-l_xcci302f != l_xccc.xccc204f + l_xccc.xccc210f + l_xccc.xccc206f      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302g-l_xcci302g != l_xccc.xccc204g + l_xccc.xccc210g + l_xccc.xccc206g      #本月转出金额  委外入库+重工入库+工单入库
         #OR l_xccg302h-l_xcci302h != l_xccc.xccc204h + l_xccc.xccc210h + l_xccc.xccc206h THEN #本月转出金额  委外入库+重工入库+工单入库 #mod 141203
         #IF (l_xccg302d-l_xcci302d)-(l_xccc.xccc204d + l_xccc.xccc210d + l_xccc.xccc206d) > 0.1 #mod 141204 #mark 150425
         IF (l_xccg302d)-(l_xccc.xccc210d + l_xccc.xccc206d) > 0.1 #add 150425
         #OR (l_xccc.xccc204d + l_xccc.xccc210d + l_xccc.xccc206d)-(l_xccg302d-l_xcci302d) > 0.1  #mark 150215
         #OR (l_xccg302e-l_xcci302e)-(l_xccc.xccc204e + l_xccc.xccc210e + l_xccc.xccc206e) > 0.1 #mark 150425
         OR (l_xccg302e)-(l_xccc.xccc210e + l_xccc.xccc206e) > 0.1 #add 150425
         #OR (l_xccc.xccc204e + l_xccc.xccc210e + l_xccc.xccc206e)-(l_xccg302e-l_xcci302e) > 0.1  #mark 150215
         #OR (l_xccg302f-l_xcci302f)-(l_xccc.xccc204f + l_xccc.xccc210f + l_xccc.xccc206f) > 0.1 #mark 150425
         OR (l_xccg302f)-(l_xccc.xccc210f + l_xccc.xccc206f) > 0.1 #add 150425
         #OR (l_xccc.xccc204f + l_xccc.xccc210f + l_xccc.xccc206f)-(l_xccg302f-l_xcci302f) > 0.1  #mark 150215
         #OR (l_xccg302g-l_xcci302g)-(l_xccc.xccc204g + l_xccc.xccc210g + l_xccc.xccc206g) > 0.1 #mark 150425
         OR (l_xccg302g)-(l_xccc.xccc210g + l_xccc.xccc206g) > 0.1 #add 150425
         #OR (l_xccc.xccc204g + l_xccc.xccc210g + l_xccc.xccc206g)-(l_xccg302g-l_xcci302g) > 0.1  #mark 150215
         #OR (l_xccg302h-l_xcci302h)-(l_xccc.xccc204h + l_xccc.xccc210h + l_xccc.xccc206h) > 0.1 #mark 150425
         OR (l_xccg302h)-(l_xccc.xccc210h + l_xccc.xccc206h) > 0.1 #add 150425
         #OR (l_xccc.xccc204h + l_xccc.xccc210h + l_xccc.xccc206h)-(l_xccg302h-l_xcci302h) > 0.1  #mark 150215
         THEN
            LET l_ac = l_ac + 1
            CASE
               WHEN (l_xccg302d)-(l_xccc.xccc210d + l_xccc.xccc206d) > 0.1
                 OR (l_xccc.xccc210d + l_xccc.xccc206d)-(l_xccg302d) > 0.1
                    LET l_str1 = l_xccg302d
                    LET l_str2 = l_xccc.xccc210d + l_xccc.xccc206d
               WHEN (l_xccg302e)-(l_xccc.xccc210e + l_xccc.xccc206e) > 0.1
                 OR (l_xccc.xccc210e + l_xccc.xccc206e)-(l_xccg302e) > 0.1
                    LET l_str1 = l_xccg302e
                    LET l_str2 = l_xccc.xccc210e + l_xccc.xccc206e
               WHEN (l_xccg302f)-(l_xccc.xccc210f + l_xccc.xccc206f) > 0.1
                 OR (l_xccc.xccc210f + l_xccc.xccc206f)-(l_xccg302f) > 0.1
                    LET l_str1 = l_xccg302f
                    LET l_str2 = l_xccc.xccc210f + l_xccc.xccc206f
               WHEN (l_xccg302g)-(l_xccc.xccc210g + l_xccc.xccc206g) > 0.1
                 OR (l_xccc.xccc210g + l_xccc.xccc206g)-(l_xccg302g) > 0.1
                    LET l_str1 = l_xccg302g
                    LET l_str2 = l_xccc.xccc210g + l_xccc.xccc206g
               WHEN (l_xccg302h)-(l_xccc.xccc210h + l_xccc.xccc206h) > 0.1
                 OR (l_xccc.xccc210h + l_xccc.xccc206h)-(l_xccg302h) > 0.1
                    LET l_str1 = l_xccg302h
                    LET l_str2 = l_xccc.xccc210h + l_xccc.xccc206h
            END CASE
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING ls_msg  #聯產品制费合計%1 不等於 制费入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      
         #IF l_xccg302c != l_xccc.xccc202c + l_xccc.xccc210c THEN
         #IF l_xccg302c != l_xccc.xccc204c + l_xccc.xccc210c + l_xccc.xccc206c THEN #本月转出金额  委外入库+重工入库+工单入库
         #IF l_xccg302c-l_xcci302c != l_xccc.xccc204c + l_xccc.xccc210c + l_xccc.xccc206c THEN #本月转出金额  委外入库+重工入库+工单入库 #mod 141203
         #IF (l_xccg302c-l_xcci302c)-(l_xccc.xccc204c + l_xccc.xccc210c + l_xccc.xccc206c) > 0.1 #mod 141204 #mark 150425
         IF (l_xccg302c)-(l_xccc.xccc210c + l_xccc.xccc206c) > 0.1 #add 150425
         #OR (l_xccc.xccc204c + l_xccc.xccc210c + l_xccc.xccc206c)-(l_xccg302c-l_xcci302c) > 0.1  #mark 150215
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302c
            LET l_str2 = l_xccc.xccc210c + l_xccc.xccc206c
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00452',g_lang,l_str) RETURNING ls_msg  #聯產品加工合計%1 不等於 加工入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      END IF #add 150212 end
      #####-----检查联产品-----#####end 与xccc库存的检查


      #检查成本分群xcbb010
      LET l_xcbb010 = NULL
      #SELECT xcbb010 INTO l_xcbb010 FROM xcbb_t
      # WHERE xcbbent  = l_xccc.xcccent  #企業代碼
      #   AND xcbbcomp = l_xccc.xccccomp #法人組織
      #   AND xcbb001  = l_xccc.xccc004  #年度
      #   AND xcbb002  = l_xccc.xccc005  #期別
      #   AND xcbb003  = l_xccc.xccc006  #料號
      #   AND xcbb004  = l_xccc.xccc007 #特性
      OPEN axcq301_b_fill_c7 USING l_xccc.xccc006 #,l_xccc.xccc007  #帳套本位幣順序,成本域,元件料号,特性,批號 #mark zhangllc 151109
      FETCH axcq301_b_fill_c7 INTO l_xcbb010
      CLOSE axcq301_b_fill_c7
      IF cl_null(l_xcbb010) THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00453',g_lang) RETURNING ls_msg  #料號未設定成本分群
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''   #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
      END IF
      
      #检查成本阶
      IF l_xccc006_7_f = 'Y' THEN  #add 150216
         FOREACH axcq301_sfaa042_c USING l_xccc.xccc006,l_xccc.xccc007 INTO l_xccd_xcce.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:axcq301_sfaa042_c" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00454',g_lang) RETURNING ls_msg  #成本階錯誤
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = l_xccd_xcce.xccd006   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END FOREACH
      END IF  #add 150216
      
   END FOREACH  #xccc(foreach for xccc end)
   CLOSE axcq301_xccc_c
   FREE axcq301_xccc_p
      
   LET g_detail_cnt = g_xccc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   }
END FUNCTION

#建立临时表
#150225 add 效能优化
PRIVATE FUNCTION axcq301_create_temp()
   DEFINE r_success         LIKE type_t.num5
   DEFINE ls_sql        STRING
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CALL axcq301_drop_temp()

   #LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq301_xcck AS ",
   #             "SELECT * FROM xcck_t "
   #PREPARE repro_tbl FROM ls_sql
   #EXECUTE repro_tbl
   SELECT * FROM xcck_t WHERE xcckent=82094 AND xcckld='kiow8rjgi'  
       INTO TEMP axcq301_xcck
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xcck'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #FREE repro_tbl
   CREATE INDEX axcq301_xcck_01 on axcq301_xcck (xcckent,xcckcomp,xcckld,xcck001,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index axcq301_xcck'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   #LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq301_xcce AS ",
   #             "SELECT * FROM xcce_t "
   #PREPARE repro_tbl2 FROM ls_sql
   #EXECUTE repro_tbl2
   SELECT * FROM xcce_t WHERE xcceent=82094 AND xcceld='kiow8rjgi'
       INTO TEMP axcq301_xcce
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xcce'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #FREE repro_tbl2
   CREATE INDEX axcq301_xcce_01 on axcq301_xcce (xcceent,xccecomp,xcceld,xcce001,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008,xcce009)
   CREATE INDEX axcq301_xcce_02 ON axcq301_xcce (xcceent,xccecomp,xcce004,xcce005,xcce007,xcce008,xcceld,xcce003)   #160520-00004#1 add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index axcq301_xcce'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #CREATE INDEX axcq301_xcce_02 on axcq301_xcce (xcceent,xccecomp,xcceld,xcce003,xcce004,xcce005)  

   SELECT * FROM xcbz_t WHERE xcbzent=82094 AND xcbzld='kiow8rjgi'
       INTO TEMP axcq301_xcbz
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xcbz'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE INDEX axcq301_xcbz_01 on axcq301_xcbz(xcbzent,xcbzld,xcbz001,xcbz002,xcbz003)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index axcq301_xcbz'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

  
  #160520-00004#1-s-add
  
   SELECT * FROM sfaa_t WHERE sfaaent=82094 AND sfaadocno='kiow8rjgi'
       INTO TEMP axcq301_sfaa
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_sfaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE INDEX axcq301_sfaa_01 on axcq301_sfaa (sfaaent,sfaadocno)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index axcq301_sfaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   CREATE TEMP TABLE axcq301_xccb(
      xccbent        SMALLINT, 
      xccbld         VARCHAR(5), 
      xccb001        VARCHAR(1),
      xccb002        VARCHAR(30),
      xccb003        VARCHAR(10),
      xccb006        VARCHAR(20),
      xccb007        VARCHAR(40),
      xccb008        VARCHAR(256),
      xccb009        VARCHAR(30),
      xccb101        DECIMAL(20,6),
      xccb102        DECIMAL(20,6)
      );  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'create axcq301_xccb'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
  
   CREATE TEMP TABLE axcq301_xcbb_01(
      xccd006   VARCHAR(20),
      xccd007   VARCHAR(40),
      xccd008   VARCHAR(256),
      xcbb006   SMALLINT
   );  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xcbb_01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   CREATE TEMP TABLE axcq301_xcbb_02(
      xcce006   VARCHAR(20),
      xcbb006   SMALLINT
   );  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xcbb_02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
  
   CREATE TEMP TABLE axcq301_xccc(
     xcccent   SMALLINT,
     xccccomp  VARCHAR(10),
     xcccld    VARCHAR(5),
     xccc001   VARCHAR(1),
     xccc002   VARCHAR(30),
     xccc003   VARCHAR(10),
     xccc004   SMALLINT,
     xccc005   SMALLINT,
     xccc006   VARCHAR(40),
     xccc007   VARCHAR(256),
     xccc008   VARCHAR(30),
     tot       DECIMAL(20,6),     
     xcce202   DECIMAL(20,6),
     xcci202   DECIMAL(20,6),
     xcci302   DECIMAL(20,6),
     xcck202   DECIMAL(20,6)
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_xccc'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   CREATE INDEX axcq301_xccc_01 on axcq301_xccc (xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index axcq301_sfaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
  #160520-00004#1-e-add
  
  #170218-00022#1-s-add
   CREATE TEMP TABLE axcq301_cost(
      xccd007    VARCHAR(40),
      xccd008    VARCHAR(256),
      imaal003   VARCHAR(255),
      xccd006    VARCHAR(20),
      cost       DECIMAL(20,6),
      cost2      DECIMAL(20,6),
      info       VARCHAR(255)
    );  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq301_cost'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
  #170218-00022#1-e-add
   RETURN r_success
END FUNCTION

#删除临时表
#150225 add 效能优化
PRIVATE FUNCTION axcq301_drop_temp()
   WHENEVER ERROR CONTINUE

   DROP TABLE axcq301_xcck
   DROP TABLE axcq301_xcce
   DROP TABLE axcq301_xcbz   
  #160520-00004#1-s-add
   DROP TABLE axcq301_sfaa
   DROP TABLE axcq301_xccb
   DROP TABLE axcq301_xccc
   DROP TABLE axcq301_xcbb_01
   DROP TABLE axcq301_xcbb_02
  #160520-00004#1-e-add  
   DROP TABLE axcq301_cost    #170218-00022#1 add
END FUNCTION

#删除临时表资料
#150225 add 效能优化
PRIVATE FUNCTION axcq301_delete_temp()
   WHENEVER ERROR CONTINUE

   DELETE FROM axcq301_xcck
   DELETE FROM axcq301_xcce
   DELETE FROM axcq301_xcbz   
  #160520-00004#1-s-add
   DELETE FROM axcq301_sfaa
   DELETE FROM axcq301_xccc
  #160520-00004#1-e-add  
END FUNCTION

#_b_fill2()的效能优化
PRIVATE FUNCTION axcq301_b_fill3()

DEFINE l_glaa003   LIKE glaa_t.glaa003
DEFINE ls_msg      STRING
DEFINE l_sfdc001   LIKE sfdc_t.sfdc001  #工单编号
#DEFINE l_xccc      RECORD LIKE xccc_t.*  #在制库存   #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccc RECORD  #料件庫存成本期異動統計檔
       xcccent LIKE xccc_t.xcccent, #企业编号
       xccccomp LIKE xccc_t.xccccomp, #法人组织
       xcccld LIKE xccc_t.xcccld, #账套
       xccc001 LIKE xccc_t.xccc001, #账套本位币顺序
       xccc002 LIKE xccc_t.xccc002, #成本域
       xccc003 LIKE xccc_t.xccc003, #成本计算类型
       xccc004 LIKE xccc_t.xccc004, #年度
       xccc005 LIKE xccc_t.xccc005, #期别
       xccc006 LIKE xccc_t.xccc006, #料号
       xccc007 LIKE xccc_t.xccc007, #特性码
       xccc008 LIKE xccc_t.xccc008, #批号
       xccc010 LIKE xccc_t.xccc010, #核算币种
       xccc101 LIKE xccc_t.xccc101, #上期结存数量
       xccc102 LIKE xccc_t.xccc102, #上期结存金额
       xccc201 LIKE xccc_t.xccc201, #本期采购入库数量
       xccc202 LIKE xccc_t.xccc202, #本期采购入库金额
       xccc203 LIKE xccc_t.xccc203, #本期委外入库数量
       xccc204 LIKE xccc_t.xccc204, #本期委外入库金额
       xccc205 LIKE xccc_t.xccc205, #本期工单入库数量
       xccc206 LIKE xccc_t.xccc206, #本期工单入库金额
       xccc206a LIKE xccc_t.xccc206a,
       xccc206b LIKE xccc_t.xccc206b,
       xccc206c LIKE xccc_t.xccc206c,
       xccc206d LIKE xccc_t.xccc206d,
       xccc206e LIKE xccc_t.xccc206e,
       xccc206f LIKE xccc_t.xccc206f,
       xccc206g LIKE xccc_t.xccc206g,
       xccc206h LIKE xccc_t.xccc206h,
       xccc207 LIKE xccc_t.xccc207, #本期返工领出数量
       xccc208 LIKE xccc_t.xccc208, #本期返工领出金额
       xccc208a LIKE xccc_t.xccc208a,
       xccc208b LIKE xccc_t.xccc208b,
       xccc208c LIKE xccc_t.xccc208c,
       xccc208d LIKE xccc_t.xccc208d,
       xccc208e LIKE xccc_t.xccc208e,
       xccc208f LIKE xccc_t.xccc208f,
       xccc208g LIKE xccc_t.xccc208g,
       xccc208h LIKE xccc_t.xccc208h,
       xccc209 LIKE xccc_t.xccc209, #本期返工入库数量
       xccc210 LIKE xccc_t.xccc210, #本期返工入库金额
       xccc210a LIKE xccc_t.xccc210a,
       xccc210b LIKE xccc_t.xccc210b,
       xccc210c LIKE xccc_t.xccc210c,
       xccc210d LIKE xccc_t.xccc210d,
       xccc210e LIKE xccc_t.xccc210e,
       xccc210f LIKE xccc_t.xccc210f,
       xccc210g LIKE xccc_t.xccc210g,
       xccc210h LIKE xccc_t.xccc210h,
       xccc211 LIKE xccc_t.xccc211, #本期杂项入库数量
       xccc212 LIKE xccc_t.xccc212, #本期杂项入库金额
       xccc213 LIKE xccc_t.xccc213, #本期调整入库数量
       xccc214 LIKE xccc_t.xccc214, #本期调整入库金额
       xccc215 LIKE xccc_t.xccc215, #本期销退入库数量
       xccc216 LIKE xccc_t.xccc216, #本期销退入库金额
       xccc217 LIKE xccc_t.xccc217, #本期调拨入库数量
       xccc218 LIKE xccc_t.xccc218, #本期调拨入库金额
       xccc280 LIKE xccc_t.xccc280, #本期平均单价
       xccc280a LIKE xccc_t.xccc280a,
       xccc280b LIKE xccc_t.xccc280b,
       xccc280c LIKE xccc_t.xccc280c,
       xccc280d LIKE xccc_t.xccc280d,
       xccc280e LIKE xccc_t.xccc280e,
       xccc280f LIKE xccc_t.xccc280f,
       xccc280g LIKE xccc_t.xccc280g,
       xccc280h LIKE xccc_t.xccc280h,
       xccc301 LIKE xccc_t.xccc301, #本期工单领用数量
       xccc302 LIKE xccc_t.xccc302, #本期工单领用金额
       xccc303 LIKE xccc_t.xccc303, #本期销货数量
       xccc304 LIKE xccc_t.xccc304, #本期销货成本
       xccc305 LIKE xccc_t.xccc305, #本期销退数量
       xccc306 LIKE xccc_t.xccc306, #本期销退成本
       xccc307 LIKE xccc_t.xccc307, #本期销售费用数量
       xccc308 LIKE xccc_t.xccc308, #本期销售费用成本
       xccc309 LIKE xccc_t.xccc309, #本期杂发数量
       xccc310 LIKE xccc_t.xccc310, #本期杂发金额
       xccc311 LIKE xccc_t.xccc311, #本期盘盈亏数量
       xccc312 LIKE xccc_t.xccc312, #本期盘盈亏金额
       xccc313 LIKE xccc_t.xccc313, #本期调拨出库数量
       xccc314 LIKE xccc_t.xccc314, #本期调拨出库金额
       xccc401 LIKE xccc_t.xccc401, #本期销货收入金额
       xccc402 LIKE xccc_t.xccc402, #本期销退金额
       xccc901 LIKE xccc_t.xccc901, #期末结存数量
       xccc902 LIKE xccc_t.xccc902, #期末结存金额
       xccc902a LIKE xccc_t.xccc902a,
       xccc902b LIKE xccc_t.xccc902b,
       xccc902c LIKE xccc_t.xccc902c,
       xccc902d LIKE xccc_t.xccc902d,
       xccc902e LIKE xccc_t.xccc902e,
       xccc902f LIKE xccc_t.xccc902f,
       xccc902g LIKE xccc_t.xccc902g,
       xccc902h LIKE xccc_t.xccc902h,
       xccc903 LIKE xccc_t.xccc903 #期末结存调整金额
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#DEFINE l_xccd      RECORD LIKE xccd_t.*  #在制主件  #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccd RECORD  #在製主件成本期異動統計檔
       xccdent LIKE xccd_t.xccdent, #企业编号
       xccdcomp LIKE xccd_t.xccdcomp, #法人组织
       xccdld LIKE xccd_t.xccdld, #账套
       xccd001 LIKE xccd_t.xccd001, #账套本位币顺序
       xccd002 LIKE xccd_t.xccd002, #成本域
       xccd003 LIKE xccd_t.xccd003, #成本计算类型
       xccd004 LIKE xccd_t.xccd004, #年度
       xccd005 LIKE xccd_t.xccd005, #期别
       xccd006 LIKE xccd_t.xccd006, #工单编号
       xccd007 LIKE xccd_t.xccd007, #主件料号
       xccd008 LIKE xccd_t.xccd008, #特性
       xccd009 LIKE xccd_t.xccd009, #批号
       xccd010 LIKE xccd_t.xccd010, #项目号
       xccd011 LIKE xccd_t.xccd011, #核算币种
       xccd012 LIKE xccd_t.xccd012, #重复性成产否
       xccd013 LIKE xccd_t.xccd013, #成产计划号
       xccd014 LIKE xccd_t.xccd014, #BOM特性
       xccd101 LIKE xccd_t.xccd101, #上期结存数量
       xccd102 LIKE xccd_t.xccd102, #上期结存金额
       xccd200 LIKE xccd_t.xccd200, #本期投入工时
       xccd201 LIKE xccd_t.xccd201, #本期投入数量
       xccd202 LIKE xccd_t.xccd202, #本期本阶投入金额
       xccd204 LIKE xccd_t.xccd204, #本期下阶投入金额
       xccd301 LIKE xccd_t.xccd301, #本期转出数量
       xccd302 LIKE xccd_t.xccd302, #本期转出金额
       xccd302a LIKE xccd_t.xccd302a,
       xccd302b LIKE xccd_t.xccd302b,
       xccd302c LIKE xccd_t.xccd302c,
       xccd302d LIKE xccd_t.xccd302d,
       xccd302e LIKE xccd_t.xccd302e,
       xccd302f LIKE xccd_t.xccd302f,
       xccd302g LIKE xccd_t.xccd302g,
       xccd302h LIKE xccd_t.xccd302h,
       xccd303 LIKE xccd_t.xccd303, #差异转出数量
       xccd304 LIKE xccd_t.xccd304, #差异转出金额
       xccd901 LIKE xccd_t.xccd901, #期末结存数量
       xccd902 LIKE xccd_t.xccd902, #期末结存金额
       xccd902a LIKE xccd_t.xccd902a,
       xccd902b LIKE xccd_t.xccd902b,
       xccd902c LIKE xccd_t.xccd902c,
       xccd902d LIKE xccd_t.xccd902d,
       xccd902e LIKE xccd_t.xccd902e,
       xccd902f LIKE xccd_t.xccd902f,
       xccd902g LIKE xccd_t.xccd902g,
       xccd902h LIKE xccd_t.xccd902h
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#DEFINE l_xcce      RECORD LIKE xcce_t.*  #在制元件  #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xcce RECORD  #在製元件成本期異動統計檔
       xcceent LIKE xcce_t.xcceent, #企业编号
       xccecomp LIKE xcce_t.xccecomp, #法人组织
       xcceld LIKE xcce_t.xcceld, #账套
       xcce001 LIKE xcce_t.xcce001, #账套本位币顺序
       xcce002 LIKE xcce_t.xcce002, #成本域
       xcce003 LIKE xcce_t.xcce003, #成本计算类型
       xcce004 LIKE xcce_t.xcce004, #年度
       xcce005 LIKE xcce_t.xcce005, #期别
       xcce006 LIKE xcce_t.xcce006, #工单编号
       xcce007 LIKE xcce_t.xcce007, #元件编号
       xcce008 LIKE xcce_t.xcce008, #特性
       xcce009 LIKE xcce_t.xcce009, #批号
       xcce010 LIKE xcce_t.xcce010, #核算币种
       xcce101 LIKE xcce_t.xcce101, #上期结存数量
       xcce102 LIKE xcce_t.xcce102, #上期结存金额
       xcce201 LIKE xcce_t.xcce201, #本期投入数量
       xcce202 LIKE xcce_t.xcce202, #本期本阶投入金额
       xcce205 LIKE xcce_t.xcce205, #本期当站下线数量
       xcce206 LIKE xcce_t.xcce206, #本期当站下线成本
       xcce206a LIKE xcce_t.xcce206a, #本期当站下线成本-材料
       xcce206b LIKE xcce_t.xcce206b, #本期当站下线成本-人工
       xcce206c LIKE xcce_t.xcce206c, #本期当站下线成本-加工
       xcce206d LIKE xcce_t.xcce206d, #本期当站下线成本-制费一
       xcce206e LIKE xcce_t.xcce206e, #本期当站下线成本-制费二
       xcce206f LIKE xcce_t.xcce206f, #本期当站下线成本-制费三
       xcce206g LIKE xcce_t.xcce206g, #本期当站下线成本-制费四
       xcce206h LIKE xcce_t.xcce206h, #本期当站下线成本-制费五
       xcce207 LIKE xcce_t.xcce207, #本期一般退料数量
       xcce208 LIKE xcce_t.xcce208, #本期一般退料成本
       xcce208a LIKE xcce_t.xcce208a, #本期一般退料成本-材料
       xcce208b LIKE xcce_t.xcce208b, #本期一般退料成本-人工
       xcce208c LIKE xcce_t.xcce208c, #本期一般退料成本-加工
       xcce208d LIKE xcce_t.xcce208d, #本期一般退料成本-制费一
       xcce208e LIKE xcce_t.xcce208e, #本期一般退料成本-制费二
       xcce208f LIKE xcce_t.xcce208f, #本期一般退料成本-制费三
       xcce208g LIKE xcce_t.xcce208g, #本期一般退料成本-制费四
       xcce208h LIKE xcce_t.xcce208h, #本期一般退料成本-制费五
       xcce209 LIKE xcce_t.xcce209, #本期超领退数量
       xcce210 LIKE xcce_t.xcce210, #本期超领退金额
       xcce210a LIKE xcce_t.xcce210a, #本期超领退金额-材料
       xcce210b LIKE xcce_t.xcce210b, #本期超领退金额-人工
       xcce210c LIKE xcce_t.xcce210c, #本期超领退金额-加工
       xcce210d LIKE xcce_t.xcce210d, #本期超领退金额-制费一
       xcce210e LIKE xcce_t.xcce210e, #本期超领退金额-制费二
       xcce210f LIKE xcce_t.xcce210f, #本期超领退金额-制费三
       xcce210g LIKE xcce_t.xcce210g, #本期超领退金额-制费四
       xcce210h LIKE xcce_t.xcce210h, #本期超领退金额-制费五
       xcce301 LIKE xcce_t.xcce301, #本期转出数量
       xcce302 LIKE xcce_t.xcce302, #本期转出金额
       xcce303 LIKE xcce_t.xcce303, #差异转出数量
       xcce304 LIKE xcce_t.xcce304, #差异转出金额
       xcce307 LIKE xcce_t.xcce307, #盘差数量
       xcce308 LIKE xcce_t.xcce308, #盘差金额
       xcce901 LIKE xcce_t.xcce901, #期末结存数量
       xcce902 LIKE xcce_t.xcce902, #期末结存金额
       xcce902a LIKE xcce_t.xcce902a,
       xcce902b LIKE xcce_t.xcce902b,
       xcce902c LIKE xcce_t.xcce902c,
       xcce902d LIKE xcce_t.xcce902d,
       xcce902e LIKE xcce_t.xcce902e,
       xcce902f LIKE xcce_t.xcce902f,
       xcce902g LIKE xcce_t.xcce902g,
       xcce902h LIKE xcce_t.xcce902h
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#DEFINE l_xcck      RECORD LIKE xcck_t.*  #料件明细  #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xcck RECORD  #本期料件明細進出成本檔
       xcckent LIKE xcck_t.xcckent, #企业编号
       xccksite LIKE xcck_t.xccksite, #site组织
       xcckcomp LIKE xcck_t.xcckcomp, #法人组织
       xcckld LIKE xcck_t.xcckld, #账套
       xcck001 LIKE xcck_t.xcck001, #账套本位币顺序
       xcck002 LIKE xcck_t.xcck002, #成本域
       xcck003 LIKE xcck_t.xcck003, #成本计算类型
       xcck004 LIKE xcck_t.xcck004, #年度
       xcck005 LIKE xcck_t.xcck005, #期别
       xcck006 LIKE xcck_t.xcck006, #参考单号
       xcck007 LIKE xcck_t.xcck007, #项次
       xcck008 LIKE xcck_t.xcck008, #项序
       xcck009 LIKE xcck_t.xcck009, #出入库码
       xcck010 LIKE xcck_t.xcck010, #料号
       xcck011 LIKE xcck_t.xcck011, #特性
       xcck012 LIKE xcck_t.xcck012, #单据类型
       xcck013 LIKE xcck_t.xcck013, #单据日期
       xcck014 LIKE xcck_t.xcck014, #时间
       xcck015 LIKE xcck_t.xcck015, #仓库编号
       xcck016 LIKE xcck_t.xcck016, #储位编号
       xcck017 LIKE xcck_t.xcck017, #批号
       xcck020 LIKE xcck_t.xcck020, #异动类型
       xcck021 LIKE xcck_t.xcck021, #原因码
       xcck022 LIKE xcck_t.xcck022, #交易对象
       xcck023 LIKE xcck_t.xcck023, #客群
       xcck024 LIKE xcck_t.xcck024, #区域
       xcck025 LIKE xcck_t.xcck025, #成本中心
       xcck026 LIKE xcck_t.xcck026, #经营类别
       xcck027 LIKE xcck_t.xcck027, #渠道
       xcck028 LIKE xcck_t.xcck028, #品类
       xcck029 LIKE xcck_t.xcck029, #品牌
       xcck030 LIKE xcck_t.xcck030, #项目号
       xcck031 LIKE xcck_t.xcck031, #WBS
       xcck032 LIKE xcck_t.xcck032, #存货科目
       xcck033 LIKE xcck_t.xcck033, #费用成本科目
       xcck034 LIKE xcck_t.xcck034, #收入科目
       xcck040 LIKE xcck_t.xcck040, #交易币种
       xcck041 LIKE xcck_t.xcck041, #本位币种
       xcck042 LIKE xcck_t.xcck042, #汇率
       xcck043 LIKE xcck_t.xcck043, #交易单位
       xcck044 LIKE xcck_t.xcck044, #成本单位
       xcck045 LIKE xcck_t.xcck045, #换算率
       xcck046 LIKE xcck_t.xcck046, #交易数量
       xcck047 LIKE xcck_t.xcck047, #工单号码
       xcck048 LIKE xcck_t.xcck048, #重复性生产-计划编号
       xcck049 LIKE xcck_t.xcck049, #重复性生产-生产料号
       xcck050 LIKE xcck_t.xcck050, #重复性生产-生产料号BOM特性
       xcck051 LIKE xcck_t.xcck051, #重复性生产-生产料号产品特征
       xcck055 LIKE xcck_t.xcck055, #xccc类型
       xcck201 LIKE xcck_t.xcck201, #本期异动数量
       xcck202 LIKE xcck_t.xcck202, #本期异动金额
       xcck282 LIKE xcck_t.xcck282, #本期异动单价
       xcck301 LIKE xcck_t.xcck301, #已耗数量
       xcck302 LIKE xcck_t.xcck302, #已耗金额
       xcck901 LIKE xcck_t.xcck901, #结存数量
       xcck902 LIKE xcck_t.xcck902, #结存金额
       xcck980 LIKE xcck_t.xcck980, #结存单位成本
       xcck903 LIKE xcck_t.xcck903, #结存调整金额
       xcckownid LIKE xcck_t.xcckownid, #资料所有者
       xcckowndp LIKE xcck_t.xcckowndp, #资料所有部门
       xcckcrtid LIKE xcck_t.xcckcrtid, #资料录入者
       xcckcrtdp LIKE xcck_t.xcckcrtdp, #资料录入部门
       xcckcrtdt LIKE xcck_t.xcckcrtdt, #资料创建日
       xcckmodid LIKE xcck_t.xcckmodid, #资料更改者
       xcckmoddt LIKE xcck_t.xcckmoddt, #最近更改日
       xcckstus LIKE xcck_t.xcckstus, #状态码
       xcck056 LIKE xcck_t.xcck056 #成本代销单号
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#DEFINE l_xccg      RECORD LIKE xccg_t.*  #联产品  #161124-00048#13  16/12/29 By 08734 mark
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccg RECORD  #聯產品成本期異動統計檔
       xccgent LIKE xccg_t.xccgent, #企业编号
       xccgcomp LIKE xccg_t.xccgcomp, #法人组织
       xccgld LIKE xccg_t.xccgld, #账套
       xccg001 LIKE xccg_t.xccg001, #账套本位币顺序
       xccg002 LIKE xccg_t.xccg002, #成本域
       xccg003 LIKE xccg_t.xccg003, #成本计算类型
       xccg004 LIKE xccg_t.xccg004, #年度
       xccg005 LIKE xccg_t.xccg005, #期别
       xccg006 LIKE xccg_t.xccg006, #工单编号
       xccg007 LIKE xccg_t.xccg007, #联产品料号
       xccg008 LIKE xccg_t.xccg008, #特性
       xccg009 LIKE xccg_t.xccg009, #批号
       xccg010 LIKE xccg_t.xccg010, #核算币种
       xccg101 LIKE xccg_t.xccg101, #上期结存数量
       xccg102 LIKE xccg_t.xccg102, #上期结存金额
       xccg301 LIKE xccg_t.xccg301, #本期转出数量
       xccg302 LIKE xccg_t.xccg302, #本期转出金额
       xccg901 LIKE xccg_t.xccg901, #期末结存数量
       xccg902 LIKE xccg_t.xccg902 #期末结存金额
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
DEFINE l_imaa006   LIKE imaa_t.imaa006  #基础单位
DEFINE l_imaa009   LIKE imaa_t.imaa009  #产品分类
DEFINE l_imaal003  LIKE imaal_t.imaal003
DEFINE l_imaal003_2  LIKE imaal_t.imaal003
DEFINE l_xcce202   LIKE xcce_t.xcce202
DEFINE l_xcce206   LIKE xcce_t.xcce206 #add 141203
DEFINE l_xcce208   LIKE xcce_t.xcce208 #add 141203
DEFINE l_xcce210   LIKE xcce_t.xcce210 #add 141203
DEFINE l_xcce308   LIKE xcce_t.xcce308 #add 141203
DEFINE l_xcck202   LIKE xcck_t.xcck202
DEFINE l_tot       LIKE xccc_t.xccc302  #工单领出金额
DEFINE l_success   LIKE type_t.num5
DEFINE l_xccc902   LIKE xccc_t.xccc902
DEFINE l_inat015   LIKE inat_t.inat015
DEFINE l_sfaa048   LIKE sfaa_t.sfaa048
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_diff      LIKE xccd_t.xccd902
DEFINE l_xcbb010   LIKE xcbb_t.xcbb010  #成本分群
DEFINE l_xccd_xcce RECORD
                   xccd006    LIKE xccd_t.xccd006, #工单
                   xccd007    LIKE xccd_t.xccd007, #主件
                   xccd008    LIKE xccd_t.xccd008, #特性
                   xcbb006a   LIKE xcbb_t.xcbb006, #成本阶数
                   xcce005    LIKE xcce_t.xcce005, #月份
                   xcce007    LIKE xcce_t.xcce007, #元件
                   xcce008    LIKE xcce_t.xcce008, #特性
                   xcbb006b   LIKE xcbb_t.xcbb006, #成本阶数
                   sfaa042    LIKE sfaa_t.sfaa042  #重工否
                   END RECORD
DEFINE l_xcbi201   LIKE xcbi_t.xcbi201
DEFINE l_xcbi202   LIKE xcbi_t.xcbi202
DEFINE l_xcbi203   LIKE xcbi_t.xcbi203
DEFINE l_xcbi204   LIKE xcbi_t.xcbi204
DEFINE l_xccd902   LIKE xccd_t.xccd902
DEFINE l_xcce902   LIKE xcce_t.xcce902
DEFINE l_xcce901   LIKE xcce_t.xcce901
DEFINE l_xcce102   LIKE xcce_t.xcce102
DEFINE l_xcce302   LIKE xcce_t.xcce302
DEFINE l_xcce304   LIKE xcce_t.xcce304
DEFINE l_xccb101   LIKE xccb_t.xccb101
DEFINE l_xccb102   LIKE xccb_t.xccb102
DEFINE l_xccg302   LIKE xccg_t.xccg302
DEFINE l_xccg302a  LIKE xccg_t.xccg302a
DEFINE l_xccg302b  LIKE xccg_t.xccg302b
DEFINE l_xccg302c  LIKE xccg_t.xccg302c
DEFINE l_xccg302d  LIKE xccg_t.xccg302d
DEFINE l_xccg302e  LIKE xccg_t.xccg302e
DEFINE l_xccg302f  LIKE xccg_t.xccg302f
DEFINE l_xccg302g  LIKE xccg_t.xccg302g
DEFINE l_xccg302h  LIKE xccg_t.xccg302h
DEFINE l_xcci302a  LIKE xcci_t.xcci302a
DEFINE l_xcci302b  LIKE xcci_t.xcci302b
DEFINE l_xcci302c  LIKE xcci_t.xcci302c
DEFINE l_xcci302d  LIKE xcci_t.xcci302d
DEFINE l_xcci302e  LIKE xcci_t.xcci302e
DEFINE l_xcci302f  LIKE xcci_t.xcci302f
DEFINE l_xcci302g  LIKE xcci_t.xcci302g
DEFINE l_xcci302h  LIKE xcci_t.xcci302h
DEFINE l_xcci304a  LIKE xcci_t.xcci304a
DEFINE l_xcci304b  LIKE xcci_t.xcci304b
DEFINE l_xcci304c  LIKE xcci_t.xcci304c
DEFINE l_xcci304d  LIKE xcci_t.xcci304d
DEFINE l_xcci304e  LIKE xcci_t.xcci304e
DEFINE l_xcci304f  LIKE xcci_t.xcci304f
DEFINE l_xcci304g  LIKE xcci_t.xcci304g
DEFINE l_xcci304h  LIKE xcci_t.xcci304h
DEFINE l_xcci302   LIKE xcci_t.xcci302
DEFINE l_xcci202   LIKE xcci_t.xcci202
DEFINE l_xcca102   LIKE xcca_t.xcca102  #期初库存成本开账
DEFINE l_amt1,l_amt2      LIKE xccc_t.xccc102
DEFINE l_qty1,l_qty2      LIKE xccc_t.xccc101
DEFINE l_str1,l_str2,l_str3,l_str      STRING
DEFINE l_xcbz009    LIKE xcbz_t.xcbz009
DEFINE l_xcbz901    LIKE xcbz_t.xcbz901
DEFINE l_xccc006_7        STRING          #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_t      STRING          #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_f LIKE type_t.chr1     #是否第一次执行这个料件+特性 150216 add

  
   #计算起止日期
   SELECT glaa003 INTO l_glaa003  #會計週期參照表號
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaa014 = 'Y'  #主帐套
      AND glaacomp = tm.xccccomp
   CALL s_fin_date_get_period_range(l_glaa003,tm.xccc004,tm.xccc005)
       RETURNING g_bdate,g_edate
   #取上期的年度/期别
   CALL s_fin_date_get_last_period(l_glaa003,tm.xcccld,tm.xccc004,tm.xccc005)
        RETURNING l_success,g_yy,g_mm
   IF NOT l_success THEN
      RETURN
   END IF
   
   #add 150212
   #根据成本计算类型抓取计价方式 主要用于判断g_xcat005='3'否
   SELECT xcat005 INTO g_xcat005 FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = tm.xccc003 #成本计算类型
   #add 150212

   #初始化
   CALL g_xccc_d.clear()  #g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].docno,g_xccc_d[l_ac].info
   LET l_ac = 0
   
   #add 160517 --s
   LET g_sys_6001 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001')   #系统参数[S-FIN-6001]:採用成本域否
   LET g_sys_6002 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6002')   #系统参数[S-FIN-6002]:成本域類型
   IF g_sys_6001 = 'N' THEN
      LET g_sys_6002 = ''
   END IF
   #add 160517 --e
   LET g_sys_6004 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6004') #add 141203
   LET g_sys_6016 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6016') #add 150215
   

   #缩小xcck范围，提高效能
   BEGIN WORK #效能考虑添加
   CALL axcq301_delete_temp()
   #xcck 将下面判断中需要用到的资料插入到临时表中
   IF g_sys_6016 = 'N' THEN
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('115','302','303','501','107','114')  #異動類型:当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
   ELSE
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('302','303','501','107','114')  #異動類型：生产发料,生产退料,盘点,委外回收入库,回收入库
   END IF
   #xcce  将下面判断中需要用到的资料插入到临时表中
   INSERT INTO axcq301_xcce
      SELECT * FROM xcce_t
       WHERE xcceent  = g_enterprise
         AND xccecomp = tm.xccccomp #法人组织
         AND xcceld   = tm.xcccld   #帐别
         AND xcce003  = tm.xccc003  #成本计算类型
         AND xcce004  = tm.xccc004  #年度
         AND xcce005  = tm.xccc005  #期别
   #xcbz
   INSERT INTO axcq301_xcbz
      SELECT * FROM xcbz_t
       WHERE xcbzent  = g_enterprise
         AND xcbzcomp = tm.xccccomp #法人组织
         AND xcbzld   = tm.xcccld   #帐别
         AND xcbz001  = tm.xccc004  #年度
         AND xcbz002  = tm.xccc005  #期别
         AND EXISTS (select 1 from inaa_t   #成本库否
                      where inaaent =xcbzent
                        and inaasite=xcbzsite
                        and inaa001 = xcbz006
                        and inaa010 = 'Y')
   COMMIT WORK #效能考虑

   #定义游标
   CALL axcq301_cursor() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   #-------------------------------------------
   #检查发料单中工单不存在于工单维护作业中
   LET g_sql = " SELECT UNIQUE xccd006 FROM xccd_t ",                                                       
               "  WHERE xccdent = ",g_enterprise,
               "    AND xccdcomp='",tm.xccccomp,"' ", #法人组织
               "    AND xccdld  ='",tm.xcccld,"' ",  #帐别
               "    AND xccd003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xccd004 = ",tm.xccc004," AND xccd005 = ",tm.xccc005, #年度 期别
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = xccdent and sfaadocno=xccd006) ",
               " UNION ",
               " SELECT UNIQUE xcce006 FROM xcce_t ",                                           
               "  WHERE xcceent = ",g_enterprise,
               "    AND xccecomp='",tm.xccccomp,"' ", #法人组织
               "    AND xcceld  ='",tm.xcccld,"' ",  #帐别
               "    AND xcce003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xcce004 = ",tm.xccc004," AND xcce005 = ",tm.xccc005, #年度 期别
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = xcceent and sfaadocno=xcce006) ",
               " UNION ",
               " SELECT UNIQUE xcch006 FROM xcch_t ",                       
               "  WHERE xcchent = ",g_enterprise,
               "    AND xcchcomp='",tm.xccccomp,"' ", #法人组织
               "    AND xcchld  ='",tm.xcccld,"' ",  #帐别
               "    AND xcch003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xcch004 = ",tm.xccc004," AND xcch005 = ",tm.xccc005, #年度 期别
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = xcchent and sfaadocno=xcch006) ",
               " UNION ",
               " SELECT UNIQUE xcci006 FROM xcci_t ",                        
               "  WHERE xccient = ",g_enterprise,
               "    AND xccicomp='",tm.xccccomp,"' ", #法人组织
               "    AND xccild  ='",tm.xcccld,"' ",  #帐别
               "    AND xcci003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xcci004 = ",tm.xccc004," AND xcci005 = ",tm.xccc005, #年度 期别
               "    AND NOT EXISTS ( SELECT 1 FROM sfaa_t WHERE sfaaent = xccient and sfaadocno=xcci006) "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_sfdc_p FROM g_sql
   DECLARE axcq301_sfdc_c CURSOR FOR axcq301_sfdc_p
   FOREACH axcq301_sfdc_c INTO l_sfdc001                             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:axcq301_sfdc_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      CALL cl_getmsg('axc-00401',g_lang) RETURNING ls_msg  #工單不存在工單維護作業中  
      LET g_xccc_d[l_ac].xccc006      = ''  #料号
      LET g_xccc_d[l_ac].xccc007      = ''  #特征
      LET g_xccc_d[l_ac].xccc006_desc = ''  #品名
      LET g_xccc_d[l_ac].docno        = l_sfdc001     #单据编号
      LET g_xccc_d[l_ac].info         = ls_msg        #错误信息 
      
   END FOREACH
   CLOSE axcq301_sfdc_c
   FREE axcq301_sfdc_p

   #---------------判断xccc_t：料件庫存成本期異動統計檔---------------------------
   #LET g_sql = "SELECT UNIQUE xccc_t.*,imaa_t.*,imaal003 ",

   #LET g_sql = "SELECT UNIQUE xccc_t.*,imaa_t.imaa006,imaa_t.imaa009,imaal003  ", #mod  #161124-00048#13  16/12/29 By 08734 mark
   LET g_sql = "SELECT UNIQUE xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008,xccc010,",
               "xccc206g,xccc206h,xccc207,xccc208,xccc208a,xccc208b,xccc208c,xccc208d,xccc208e,xccc208f,xccc208g,xccc208h,xccc209,",
               "xccc210,xccc210a,xccc210b,xccc210c,xccc210d,xccc210e,xccc210f,xccc210g,xccc210h,xccc211,xccc212,xccc101,xccc102,xccc201,",
               "xccc202,xccc203,xccc204,xccc205,xccc206,xccc206a,xccc206b,xccc206c,xccc206d,xccc206e,xccc206f,xccc213,xccc214,xccc215,xccc216,",
               "xccc217,xccc218,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc303,xccc304,",
               "xccc305,xccc306,xccc307,xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc401,xccc402,xccc901,xccc902,xccc902a,xccc902b,",
               "xccc902c,xccc902d,xccc902e,xccc902f,xccc902g,xccc902h,xccc903,imaa_t.imaa006,imaa_t.imaa009,imaal003  ", #mod  #161124-00048#13  16/12/29 By 08734 add
               "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
               "              LEFT JOIN imaa_t ON imaaent='"||g_enterprise||"' AND imaa001=xccc006 ",           
               " WHERE xcccent  = ",g_enterprise,
               "   AND xccccomp ='",tm.xccccomp,"' ", #法人组织
               "   AND xcccld   ='",tm.xcccld,"' ",  #帐别
               "   AND xccc003  ='",tm.xccc003,"' ", #成本计算类型
               "   AND xccc004  = ",tm.xccc004,  #年度
               "   AND xccc005  = ",tm.xccc005,  #期别
               " ORDER BY xccc006,xccc007 "  #add 150216
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_xccc_p FROM g_sql
   DECLARE axcq301_xccc_c CURSOR FOR axcq301_xccc_p
   FOREACH axcq301_xccc_c INTO l_xccc.*,l_imaa006,l_imaa009,l_imaal003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #add 150216
      LET l_xccc006_7 = l_xccc.xccc006,'+',l_xccc.xccc007,'end'  #当笔料件+特性
      IF cl_null(l_xccc006_7_t) OR l_xccc006_7_t!=l_xccc006_7 THEN
         LET l_xccc006_7_t = l_xccc.xccc006,'+',l_xccc.xccc007,'end'
         LET l_xccc006_7_f = 'Y'  #下面需要执行USING xccc006+xccc007的
      ELSE
         LET l_xccc006_7_f = 'N'  #下面不需执行USING xccc006+xccc007的
      END IF
      #add 150216 end

      #--检查采购单价是否为0
      #IF l_xccc.xccc280 = 0 THEN  #本期平均单价 #mark 141203
      IF l_xccc.xccc201!=0 AND l_xccc.xccc202=0 THEN  #采购入库数量  采购入库金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00402',g_lang) RETURNING ls_msg  #采购单价为0 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''             #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg         #错误信息  

      ELSE
         IF l_xccc.xccc280 = 0 THEN  #本期平均单价 #add 141203
            #期初.期末數量=0及各項數量=0時，不要印出"無單位成本資料請輸入調整資料(axct002)"的訊息
            IF l_xccc.xccc101 = 0 AND l_xccc.xccc201 = 0 AND l_xccc.xccc203 = 0 AND #上期結存數量 本期採購入庫 本期委外入庫
               l_xccc.xccc205 = 0 AND l_xccc.xccc207 = 0 AND l_xccc.xccc209 = 0 AND #本期工單入庫 本期重工領出 本期重工入庫
               l_xccc.xccc211 = 0 AND l_xccc.xccc213 = 0 AND l_xccc.xccc215 = 0 AND #本期雜項入庫 本期調整入庫 本期銷退入庫
               l_xccc.xccc217 = 0 AND l_xccc.xccc301 = 0 AND l_xccc.xccc303 = 0 AND #本期調撥入庫 本期工單領用 本期銷貨數量
               l_xccc.xccc305 = 0 AND l_xccc.xccc307 = 0 AND l_xccc.xccc309 = 0 AND #本期銷退數量 本期銷售費用 本期雜發數量
               l_xccc.xccc311 = 0 AND l_xccc.xccc313 = 0 AND l_xccc.xccc901 = 0     #本期盤盈虧   本期調撥出庫 期末結存數量
            THEN
            ELSE
               LET l_ac = l_ac + 1
               CALL cl_getmsg('axc-00403',g_lang) RETURNING ls_msg  #無單位成本資料請輸入調整資料 
               LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
               LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
               LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
               LET g_xccc_d[l_ac].docno        = ''      #单据编号
               LET g_xccc_d[l_ac].info         = ls_msg        #错误信息 
            END IF
         END IF #add 141203
      END IF
      #END IF #mark 141203

      #--检查料件編號無產品分類
      IF cl_null(l_imaa009) THEN #產品分類
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00404',g_lang) RETURNING ls_msg  #料件編號無產品分類 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''             #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg         #错误信息 
      END IF

      #检查投入与发料
      LET l_tot = (l_xccc.xccc302+l_xccc.xccc208) * -1   #本期工單領用金額 + 本期重工領出金額
      #LET l_tot = (l_xccc.xccc302+l_xccc.xccc208)   #本期工單領用金額 + 本期重工領出金額 mod 141216
      LET l_xcce202 = 0 LET l_xcck202 = 0
      LET l_xcce206 = 0 LET l_xcce208 = 0 LET l_xcce210 = 0 LET l_xcce308= 0 #add 141203
      #检查投入与发料--投入与发料不符合xccc_t
      #SELECT SUM(xcce202),SUM(xcce206),SUM(xcce208),SUM(xcce210),SUM(xcce308)
      #  INTO l_xcce202,l_xcce206,l_xcce208,l_xcce210,l_xcce308
      #  FROM axcq301_xcce
      # WHERE xcceent = g_enterprise
      #   AND xccecomp= l_xccc.xccccomp  #法人组织
      #   AND xcceld  = l_xccc.xcccld    #帐别
      #   AND xcce001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xcce002 = l_xccc.xccc002  #成本域
      #   AND xcce003 = l_xccc.xccc003  #成本计算类别
      #   AND xcce004 = tm.xccc004  #年度
      #   AND xcce005 = tm.xccc005  #期别
      #   AND xcce007 = l_xccc.xccc006  #元件料号
      #   AND xcce008 = l_xccc.xccc007  #元件特性
      #   AND xcce009 = l_xccc.xccc008  #批號
      OPEN axcq301_b_fill_c1 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c1 INTO l_xcce202,l_xcce206,l_xcce208,l_xcce210,l_xcce308
      CLOSE axcq301_b_fill_c1
      IF l_xcce202 IS NULL THEN LET l_xcce202 = 0 END IF
      IF l_xcce206 IS NULL THEN LET l_xcce206 = 0 END IF  #add 141203
      IF l_xcce208 IS NULL THEN LET l_xcce208 = 0 END IF  #add 141203
      IF l_xcce210 IS NULL THEN LET l_xcce210 = 0 END IF  #add 141203
      IF l_xcce308 IS NULL THEN LET l_xcce308 = 0 END IF  #add 141203
      #LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210 + l_xcce308  #add 141203
      ##LET l_xcce202 = l_xcce202 - l_xcce206 + l_xcce208 + l_xcce210 + l_xcce308  #mod 141216
      LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210  #add 150112


      #add 141203 拆件式 转出金额和差异转出 和下面xccg共用
      LET l_xcci302a=0 LET l_xcci302b=0 LET l_xcci302c=0
      LET l_xcci302d=0 LET l_xcci302e=0 LET l_xcci302f=0
      LET l_xcci302g=0 LET l_xcci302h=0
      LET l_xcci304a=0 LET l_xcci304b=0 LET l_xcci304c=0
      LET l_xcci304d=0 LET l_xcci304e=0 LET l_xcci304f=0
      LET l_xcci304g=0 LET l_xcci304h=0
      LET l_xcci202 =0 LET l_xcci302 =0
      #SELECT SUM(xcci302a),SUM(xcci302b),SUM(xcci302c),SUM(xcci302d),SUM(xcci302e),SUM(xcci302f),SUM(xcci302g),SUM(xcci302h),
      #       SUM(xcci304a),SUM(xcci304b),SUM(xcci304c),SUM(xcci304d),SUM(xcci304e),SUM(xcci304f),SUM(xcci304g),SUM(xcci304h),
      #       SUM(xcci202),SUM(xcci302)
      #  INTO l_xcci302a,l_xcci302b,l_xcci302c,l_xcci302d,l_xcci302e,l_xcci302f,l_xcci302g,l_xcci302h,  #本期轉出金額
      #       l_xcci304a,l_xcci304b,l_xcci304c,l_xcci304d,l_xcci304e,l_xcci304f,l_xcci304g,l_xcci304h,  #本期差异转出金額
      #       l_xcci202,l_xcci302
      #  FROM xcci_t
      # WHERE xccient = l_xccc.xcccent
      #   AND xccicomp= l_xccc.xccccomp  #法人组织
      #   AND xccild  = l_xccc.xcccld    #帐别
      #   AND xcci001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xcci002 = l_xccc.xccc002  #成本域
      #   AND xcci003 = l_xccc.xccc003  #成本计算类别
      #   AND xcci004 = tm.xccc004  #年度
      #   AND xcci005 = tm.xccc005  #期别
      #   AND xcci007 = l_xccc.xccc006 #聯產品料號
      #   AND xcci008 = l_xccc.xccc007 #特性
      #   AND xcci009 = l_xccc.xccc008 #批號
      OPEN axcq301_b_fill_c2 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c2 INTO l_xcci302a,l_xcci302b,l_xcci302c,l_xcci302d,l_xcci302e,l_xcci302f,l_xcci302g,l_xcci302h,  #本期轉出金額
                                   l_xcci304a,l_xcci304b,l_xcci304c,l_xcci304d,l_xcci304e,l_xcci304f,l_xcci304g,l_xcci304h,  #本期差异转出金額
                                   l_xcci202,l_xcci302
      CLOSE axcq301_b_fill_c2
      IF cl_null(l_xcci302a) THEN LET l_xcci302a = 0 END IF
      IF cl_null(l_xcci302b) THEN LET l_xcci302b = 0 END IF
      IF cl_null(l_xcci302c) THEN LET l_xcci302c = 0 END IF
      IF cl_null(l_xcci302d) THEN LET l_xcci302d = 0 END IF
      IF cl_null(l_xcci302e) THEN LET l_xcci302e = 0 END IF
      IF cl_null(l_xcci302f) THEN LET l_xcci302f = 0 END IF
      IF cl_null(l_xcci302g) THEN LET l_xcci302g = 0 END IF
      IF cl_null(l_xcci302h) THEN LET l_xcci302h = 0 END IF
      IF cl_null(l_xcci304a) THEN LET l_xcci304a = 0 END IF
      IF cl_null(l_xcci304b) THEN LET l_xcci304b = 0 END IF
      IF cl_null(l_xcci304c) THEN LET l_xcci304c = 0 END IF
      IF cl_null(l_xcci304d) THEN LET l_xcci304d = 0 END IF
      IF cl_null(l_xcci304e) THEN LET l_xcci304e = 0 END IF
      IF cl_null(l_xcci304f) THEN LET l_xcci304f = 0 END IF
      IF cl_null(l_xcci304g) THEN LET l_xcci304g = 0 END IF
      IF cl_null(l_xcci304h) THEN LET l_xcci304h = 0 END IF
      IF cl_null(l_xcci202) THEN LET l_xcci202=0 END IF
      IF cl_null(l_xcci302) THEN LET l_xcci302=0 END IF
      #add 141203--end

      IF l_xcce202+l_xcci202+l_xcci302 != l_tot AND (l_xcce202+l_xcci202+l_xcci302-l_tot > 1 OR l_tot-l_xcce202-l_xcci202-l_xcci302 > 1) THEN #mod 150108
         LET l_ac = l_ac + 1
         LET l_str1 = l_xcce202+l_xcci202+l_xcci302
         LET l_str2 = l_tot
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00405',g_lang,l_str) RETURNING ls_msg #投入与发料不符合（xcce_t&xcci_t与xccc_t） 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息        
      END IF

      #IF g_sys_6016 = 'N' THEN
      #   SELECT SUM(xcck202*xcck009*-1) INTO l_xcck202  #本期本階投入金額
      #     FROM axcq301_xcck    #xcck_t
      #    WHERE #xcck020 IN ('115','302','303','501','107','114') AND xcck047 IS NOT NULL  #mod当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
      #       xcckent  = g_enterprise
      #      AND xcckcomp = l_xccc.xccccomp  #法人组织
      #      AND xcckld   = l_xccc.xcccld    #帐别
      #      AND xcck001  = l_xccc.xccc001   #帳套本位幣順序
      #      AND xcck002  = l_xccc.xccc002   #成本域
      #      AND xcck003  = l_xccc.xccc003   #成本计算类型
      #      AND xcck004  = tm.xccc004   #年度
      #      AND xcck005  = tm.xccc005   #期别
      #      AND xcck010  = l_xccc.xccc006   #料件
      #      AND xcck011  = l_xccc.xccc007   #特性
      #      AND xcck017  = l_xccc.xccc008   #批號
      #ELSE
      #   SELECT SUM(xcck202*xcck009*-1) INTO l_xcck202  #本期本階投入金額
      #     FROM axcq301_xcck   #xcck_t
      #    WHERE #xcck020 IN ('302','303','501','107','114') AND xcck047 IS NOT NULL  #生产发料,生产退料,盘点,委外回收入库,回收入库
      #       xcckent  = g_enterprise
      #      AND xcckcomp = l_xccc.xccccomp  #法人组织
      #      AND xcckld   = l_xccc.xcccld    #帐别
      #      AND xcck001  = l_xccc.xccc001   #帳套本位幣順序
      #      AND xcck002  = l_xccc.xccc002   #成本域
      #      AND xcck003  = l_xccc.xccc003   #成本计算类型
      #      AND xcck004  = tm.xccc004   #年度
      #      AND xcck005  = tm.xccc005   #期别
      #      AND xcck010  = l_xccc.xccc006   #料件
      #      AND xcck011  = l_xccc.xccc007   #特性
      #      AND xcck017  = l_xccc.xccc008   #批號
      #END IF
      OPEN axcq301_b_fill_c3 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c3 INTO l_xcck202
      CLOSE axcq301_b_fill_c3
      #add 150215 end
      IF l_xcck202 IS NULL THEN LET l_xcck202 = 0 END IF
      #IF l_xcce202 != l_xcck202 THEN
      IF l_xcce202+l_xcci202 != l_xcck202 THEN  #mod 141203
         LET l_ac = l_ac + 1
         LET l_str1 = l_xcce202 + l_xcci202
         LET l_str2 = l_xcck202
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00406',g_lang,l_str) RETURNING ls_msg #投入%1与发料%2不符合xcck_t
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF

      #--检查销货有数量，无金额
      IF (l_xccc.xccc303 != 0 AND l_xccc.xccc304 = 0 AND l_xccc.xccc280 != 0)      #销货数量 销货成本 成本单价
      OR (l_xccc.xccc307 != 0 AND l_xccc.xccc308 = 0 AND l_xccc.xccc280 != 0) THEN #销售数量 销售成本 成本单价
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00407',g_lang) RETURNING ls_msg  #本月銷貨有數量，但無金額請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''            #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息  
         
      END IF

      #--检查销货有金额，无数量
      IF (l_xccc.xccc303 = 0 AND l_xccc.xccc304 != 0)      #销货数量 销货成本
      OR (l_xccc.xccc307 = 0 AND l_xccc.xccc308 != 0) THEN #销售数量 销售成本
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00408',g_lang) RETURNING ls_msg  #本月銷貨有金額，但無數量請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查发料单有数量无金额
      IF l_xccc.xccc301 != 0 AND l_xccc.xccc302 = 0 AND  l_xccc.xccc280 != 0 THEN #工单领用数量 工单领用金额 成本单价
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00409',g_lang) RETURNING ls_msg  #本月發料單有數量但無金額請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查发料单有金额没数量
      IF l_xccc.xccc301 = 0 AND l_xccc.xccc302 != 0 THEN #工单领用数量 工单领用金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00410',g_lang) RETURNING ls_msg  #本月發料單有金額但無數量請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息     
      END IF

      #--检查重工领出有数量无金额
      IF (l_xccc.xccc207 > 0 OR l_xccc.xccc207 < 0 ) AND (l_xccc.xccc208a = 0 OR l_xccc.xccc208 = 0) THEN #重工领出数量 重工领出材料金额 重工领出金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00411',g_lang) RETURNING ls_msg  #本月重工領出有數量但無金額請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息     
      END IF

      #--检查杂项领用有数量无金额
      #add 141203
      CASE g_sys_6004
         WHEN '1'  #系统设定
      #add 141203--end
              IF l_xccc.xccc211 !=0 AND l_xccc.xccc212 = 0 AND  l_xccc.xccc280 != 0 THEN
                 LET l_ac = l_ac + 1
                 CALL cl_getmsg('axc-00412',g_lang) RETURNING ls_msg  #本月雜項領用有数量但無金額請做調整 
                 LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
                 LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
                 LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
                 LET g_xccc_d[l_ac].docno        = ''      #单据编号
                 LET g_xccc_d[l_ac].info         = ls_msg        #错误信息 
              END IF
      #add 141203
         WHEN '2'  #人工设定
              IF l_xccc.xccc211 !=0 AND l_xccc.xccc212 = 0 THEN
                 LET l_ac = l_ac + 1
                 CALL cl_getmsg('axc-00412',g_lang) RETURNING ls_msg  #本月雜項領用有数量但無金額請做調整 
                 LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
                 LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
                 LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
                 LET g_xccc_d[l_ac].docno        = ''      #单据编号
                 LET g_xccc_d[l_ac].info         = ls_msg        #错误信息                  
              END IF
      END CASE
      #add 141203--end

      #--检查杂项领用有金额无数量
      IF l_xccc.xccc211 = 0 AND l_xccc.xccc212 != 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00413',g_lang) RETURNING ls_msg  #本月雜項領用有金額但無数量請做調整 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月结存有金额无数量
      IF l_xccc.xccc901 = 0 and l_xccc.xccc902 != 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00414',g_lang) RETURNING ls_msg  #本月結存數量为零但結存金額有值 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息         
      END IF

      #--检查本月结存数量为负
      IF l_xccc.xccc901 < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00415',g_lang) RETURNING ls_msg  #本月結存數量為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月结存合计金额为负
      IF l_xccc.xccc902 < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00416',g_lang) RETURNING ls_msg  #本月結存合計金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息          
      END IF

      #--检查本月结存材料金额为负
      IF l_xccc.xccc902a < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00417',g_lang) RETURNING ls_msg  #本月結存材料金額為負  
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月结存人工成本为负
      IF l_xccc.xccc902b < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00418',g_lang) RETURNING ls_msg  #本月結存人工成本為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息          
      END IF

      #--检查本月结存制费成本为负
      IF l_xccc.xccc902d < 0 OR l_xccc.xccc902e < 0 OR l_xccc.xccc902f < 0 OR l_xccc.xccc902g < 0 OR l_xccc.xccc902h < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00419',g_lang) RETURNING ls_msg  #本月結存製費成本為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月结存加工成本为负
      IF l_xccc.xccc902c < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00420',g_lang) RETURNING ls_msg  #本月結存加工成本為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF
      
      LET l_xccc902 = 0
      #--本月期初金額<>上月期末金額 
      #先取开账资料
      LET l_xcca102 = NULL
      #SELECT SUM(xcca102a+xcca102b+xcca102c+xcca102d+xcca102e+xcca102f+xcca102g+xcca102h) INTO l_xcca102
      #  FROM xcca_t  #期初开帐资料
      # WHERE xccaent = l_xccc.xcccent
      #   AND xccald  = l_xccc.xcccld
      #   AND xcca001 = l_xccc.xccc001
      #   AND xcca002 = l_xccc.xccc002
      #   AND xcca003 = l_xccc.xccc003
      #   AND xcca004 = g_yy
      #   AND xcca005 = g_mm
      #   AND xcca006 = l_xccc.xccc006
      #   AND xcca007 = l_xccc.xccc007
      #   AND xcca008 = l_xccc.xccc008
      OPEN axcq301_b_fill_c4 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c4 INTO l_xcca102
      CLOSE axcq301_b_fill_c4
      IF NOT cl_null(l_xcca102) THEN
         LET l_xccc902 = l_xcca102
      ELSE
         #SELECT xccc902 INTO l_xccc902   #本月结存金额
         #  FROM xccc_t
         # WHERE xcccent = l_xccc.xcccent
         #   AND xcccld  = l_xccc.xcccld
         #   AND xccc001 = l_xccc.xccc001
         #   AND xccc002 = l_xccc.xccc002
         #   AND xccc003 = l_xccc.xccc003
         #   AND xccc004 = g_yy
         #   AND xccc005 = g_mm
         #   AND xccc006 = l_xccc.xccc006
         #   AND xccc007 = l_xccc.xccc007
         #   AND xccc008 = l_xccc.xccc008
         OPEN axcq301_b_fill_c5 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
         FETCH axcq301_b_fill_c5 INTO l_xccc902
         CLOSE axcq301_b_fill_c5
         IF cl_null(l_xccc902) THEN LET l_xccc902 = 0 END IF
      END IF
      
      IF l_xccc.xccc102 <> l_xccc902 THEN
         LET l_ac = l_ac + 1
         LET l_str1 = l_xccc.xccc102
         LET l_str2 = l_xccc902
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00421',g_lang,l_str) RETURNING ls_msg  #“本期期初金额”%1不等于 “上期期末金额”%2
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF
  
      #--本月結存數量與MFG之期末數量不合
      LET g_sql = "SELECT xcbz009,SUM(xcbz901) ", #單位,期末数量
                  "  FROM axcq301_xcbz ",
                  #"  FROM xcbz_t LEFT JOIN inaa_t ON inaaent = xcbzent AND inaasite = xcbzsite AND inaa001=xcbz006 ", #Mod 150212
                  " WHERE xcbzent = ",l_xccc.xcccent,
                  "   AND xcbzld  ='",l_xccc.xcccld,"' ", #帳套
                      #AND xcbzsite#營運據點
                  "   AND xcbz001 = ",tm.xccc004, #年度
                  "   AND xcbz002 = ",tm.xccc005, #期別
                  "   AND xcbz003 ='",l_xccc.xccc006,"' " #料件編號
                      #AND xcbz005 #庫存管理特徵
                      #AND xcbz006 #倉庫編碼
                      #AND xcbz007 #儲位編號
                  #"   AND inaa010 = 'Y' "  #成本库否 add 150212
      IF g_para_data1 = 'Y' THEN #采用特性 add 150212
         LET g_sql = g_sql CLIPPED," AND xcbz004 ='",l_xccc.xccc007,"' "  #特性
      END IF #add 150212
      IF g_xcat005 = '3' THEN #批次成本 add 150212
         LET g_sql = g_sql CLIPPED," AND xcbz008 ='",l_xccc.xccc008,"' "  #批號
      END IF #add 150212
      #add 160517 -s
      CASE g_sys_6002
         WHEN '1'   #组织型
              LET g_sql = g_sql CLIPPED,
                          " AND xcbzsite IN (",    #据点组织
                          "                  SELECT xcbf002 FROM xcbf_t ",
                          "                   WHERE xcbfent = ",l_xccc.xcccent,
                          "                     AND xcbfcomp ='",l_xccc.xccccomp,"' ",
                          "                     AND xcbf001  ='",l_xccc.xccc002,"' ",  #成本域
                          "                  ) "
         WHEN '2'   #仓库型
              LET g_sql = g_sql CLIPPED,
                          " AND xcbz006 IN (",    #据点组织
                          "                  SELECT xcbf002 FROM xcbf_t ",
                          "                   WHERE xcbfent = ",l_xccc.xcccent,
                          "                     AND xcbfcomp ='",l_xccc.xccccomp,"' ",
                          "                     AND xcbf001  ='",l_xccc.xccc002,"' ",  #成本域
                          "                  ) "
         WHEN '3'   #库存管理特征
              LET g_sql = g_sql CLIPPED," AND xcbz005 = '",l_xccc.xccc002,"' " #庫存管理特徵
      END CASE
      #add 160517 -e
      LET g_sql = g_sql CLIPPED," GROUP BY xcbz009 "
      PREPARE axcq301_xcbz_p FROM g_sql
      DECLARE axcq301_xcbz_c CURSOR FOR axcq301_xcbz_p
      LET l_inat015 = 0
      FOREACH axcq301_xcbz_c INTO l_xcbz009,l_xcbz901  #單位,期末数量
         IF cl_null(l_xcbz901) THEN LET l_xcbz901 = 0 END IF
         IF l_xcbz009 = l_imaa006 THEN
            LET l_inat015 = l_inat015 + l_xcbz901
         ELSE
            CALL s_aooi250_convert_qty(l_xccc.xccc006,l_xcbz009,l_imaa006,l_xcbz901)
               RETURNING l_success,g_qty_t
            IF l_success THEN
               LET l_xcbz901 = g_qty_t
            END IF
            LET l_inat015 = l_inat015 + l_xcbz901
         END IF
      END FOREACH
      #mod 150108 end

      IF l_xccc.xccc901 <> l_inat015 THEN
         LET l_ac = l_ac + 1
         LET l_str1 = l_xccc.xccc901
         LET l_str2 = l_inat015
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00422',g_lang,l_str) RETURNING ls_msg  #本月结存数量%1与MFG之期末数量不合%2
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF

      #--检查本月平均單價
      IF l_xccc.xccc901 != 0 THEN #期末結存數量
         #--检查本月平均單價為零
         IF l_xccc.xccc280 = 0 AND   (l_xccc.xccc205 !=0 OR l_xccc.xccc209!=0) THEN #本期平均單價 本期工單入庫數量 本期重工入庫數量
            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00423',g_lang) RETURNING ls_msg  #本月平均單價為零 
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''      #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg        #错误信息              
         END IF
      END IF

      #--检查本月材料平均單價為負
      IF l_xccc.xccc280a < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00424',g_lang) RETURNING ls_msg  #本月材料平均單價為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月人工平均單價為負
      IF l_xccc.xccc280b < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00425',g_lang) RETURNING ls_msg  #本月人工平均單價為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月製費平均單價為負
      IF l_xccc.xccc280d<0 OR l_xccc.xccc280e<0 OR l_xccc.xccc280f<0 OR l_xccc.xccc280g<0 OR l_xccc.xccc280h<0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00426',g_lang) RETURNING ls_msg  #本月製費平均單價為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #--检查本月加工平均單價為負
      IF l_xccc.xccc280c < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00427',g_lang) RETURNING ls_msg  #本月加工平均單價為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = ''      #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      #####-----检查联产品+拆件品-----#####end 与xccc库存的检查
      LET l_xccg302a=0 LET l_xccg302b=0 LET l_xccg302c=0
      LET l_xccg302d=0 LET l_xccg302e=0 LET l_xccg302f=0
      LET l_xccg302g=0 LET l_xccg302h=0
      #SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h)
      #  INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      #  FROM xccg_t
      # WHERE xccgent = l_xccc.xcccent
      #   AND xccgcomp= l_xccc.xccccomp  #法人组织 #add 141203
      #   AND xccgld  = l_xccc.xcccld    #帐别
      #   AND xccg001 = l_xccc.xccc001  #帳套本位幣順序
      #   AND xccg002 = l_xccc.xccc002  #成本域
      #   AND xccg003 = l_xccc.xccc003  #成本计算类别
      #   AND xccg004 = tm.xccc004  #年度
      #   AND xccg005 = tm.xccc005  #期别
      #   #AND xccg006 = l_xccd.xccd006  #工单
      #   AND xccg007 = l_xccc.xccc006 #聯產品料號
      #   AND xccg008 = l_xccc.xccc007 #特性
      #   AND xccg009 = l_xccc.xccc008 #批號
      OPEN axcq301_b_fill_c6 USING l_xccc.xccc001,l_xccc.xccc002,l_xccc.xccc006,l_xccc.xccc007,l_xccc.xccc008  #帳套本位幣順序,成本域,元件料号,特性,批號
      FETCH axcq301_b_fill_c6 INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      CLOSE axcq301_b_fill_c6

      IF NOT cl_null(l_xccg302a) OR NOT cl_null(l_xccg302b) OR NOT cl_null(l_xccg302c)
      OR NOT cl_null(l_xccg302d) OR NOT cl_null(l_xccg302e) OR NOT cl_null(l_xccg302f)
      OR NOT cl_null(l_xccg302g) OR NOT cl_null(l_xccg302h)
      THEN #add 150212 无资料就不需勾稽联产品
         IF cl_null(l_xccg302a) THEN LET l_xccg302a = 0 END IF
         IF cl_null(l_xccg302b) THEN LET l_xccg302b = 0 END IF
         IF cl_null(l_xccg302c) THEN LET l_xccg302c = 0 END IF
         IF cl_null(l_xccg302d) THEN LET l_xccg302d = 0 END IF
         IF cl_null(l_xccg302e) THEN LET l_xccg302e = 0 END IF
         IF cl_null(l_xccg302f) THEN LET l_xccg302f = 0 END IF
         IF cl_null(l_xccg302g) THEN LET l_xccg302g = 0 END IF
         IF cl_null(l_xccg302h) THEN LET l_xccg302h = 0 END IF

         #IF (l_xccg302a)-(l_xccc.xccc204a + l_xccc.xccc210a + l_xccc.xccc206a) > 0.1 #mod 141204
         IF (l_xccg302a)-(l_xccc.xccc210a + l_xccc.xccc206a) > 0.1 #mod 141204 #mod 150425
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302a
            LET l_str2 = l_xccc.xccc210a + l_xccc.xccc206a
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00449',g_lang,l_str) RETURNING ls_msg  #聯產品材料合計%1 不等於 材料入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         #IF (l_xccg302b-l_xcci302b)-(l_xccc.xccc204b + l_xccc.xccc210b + l_xccc.xccc206b) > 0.1 #mod 141204
         IF (l_xccg302b)-(l_xccc.xccc210b + l_xccc.xccc206b) > 0.1 #mod 141204 #mod 150425
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302b
            LET l_str2 = l_xccc.xccc210b + l_xccc.xccc206b
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00450',g_lang,l_str) RETURNING ls_msg  #聯產品人工合計%1 不等於 人工入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         #IF (l_xccg302d-l_xcci302d)-(l_xccc.xccc204d + l_xccc.xccc210d + l_xccc.xccc206d) > 0.1 #mod 141204
         #OR (l_xccg302e-l_xcci302e)-(l_xccc.xccc204e + l_xccc.xccc210e + l_xccc.xccc206e) > 0.1
         #OR (l_xccg302f-l_xcci302f)-(l_xccc.xccc204f + l_xccc.xccc210f + l_xccc.xccc206f) > 0.1
         #OR (l_xccg302g-l_xcci302g)-(l_xccc.xccc204g + l_xccc.xccc210g + l_xccc.xccc206g) > 0.1
         #OR (l_xccg302h-l_xcci302h)-(l_xccc.xccc204h + l_xccc.xccc210h + l_xccc.xccc206h) > 0.1
         IF (l_xccg302d)-(l_xccc.xccc210d + l_xccc.xccc206d) > 0.1 #mod 141204 #mod 150425
         OR (l_xccg302e)-(l_xccc.xccc210e + l_xccc.xccc206e) > 0.1
         OR (l_xccg302f)-(l_xccc.xccc210f + l_xccc.xccc206f) > 0.1
         OR (l_xccg302g)-(l_xccc.xccc210g + l_xccc.xccc206g) > 0.1
         OR (l_xccg302h)-(l_xccc.xccc210h + l_xccc.xccc206h) > 0.1
         THEN
            LET l_ac = l_ac + 1
            CASE
               WHEN (l_xccg302d)-(l_xccc.xccc210d + l_xccc.xccc206d) > 0.1
                 OR (l_xccc.xccc210d + l_xccc.xccc206d)-(l_xccg302d) > 0.1
                    LET l_str1 = l_xccg302d
                    LET l_str2 = l_xccc.xccc210d + l_xccc.xccc206d
               WHEN (l_xccg302e)-(l_xccc.xccc210e + l_xccc.xccc206e) > 0.1
                 OR (l_xccc.xccc210e + l_xccc.xccc206e)-(l_xccg302e) > 0.1
                    LET l_str1 = l_xccg302e
                    LET l_str2 = l_xccc.xccc210e + l_xccc.xccc206e
               WHEN (l_xccg302f)-(l_xccc.xccc210f + l_xccc.xccc206f) > 0.1
                 OR (l_xccc.xccc210f + l_xccc.xccc206f)-(l_xccg302f) > 0.1
                    LET l_str1 = l_xccg302f
                    LET l_str2 = l_xccc.xccc210f + l_xccc.xccc206f
               WHEN (l_xccg302g)-(l_xccc.xccc210g + l_xccc.xccc206g) > 0.1
                 OR (l_xccc.xccc210g + l_xccc.xccc206g)-(l_xccg302g) > 0.1
                    LET l_str1 = l_xccg302g
                    LET l_str2 = l_xccc.xccc210g + l_xccc.xccc206g
               WHEN (l_xccg302h)-(l_xccc.xccc210h + l_xccc.xccc206h) > 0.1
                 OR (l_xccc.xccc210h + l_xccc.xccc206h)-(l_xccg302h) > 0.1
                    LET l_str1 = l_xccg302h
                    LET l_str2 = l_xccc.xccc210h + l_xccc.xccc206h
            END CASE
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING ls_msg  #聯產品制费合計%1 不等於 制费入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         #IF (l_xccg302c-l_xcci302c)-(l_xccc.xccc204c + l_xccc.xccc210c + l_xccc.xccc206c) > 0.1 #mod 141204
         IF (l_xccg302c)-(l_xccc.xccc210c + l_xccc.xccc206c) > 0.1 #mod 141204 #mod 150425
         THEN
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302c
            LET l_str2 = l_xccc.xccc210c + l_xccc.xccc206c
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00452',g_lang,l_str) RETURNING ls_msg  #聯產品加工合計%1 不等於 加工入庫%2
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = ''   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      END IF #add 150212 end
      #####-----检查联产品-----#####end 与xccc库存的检查



      IF l_xccc006_7_f = 'Y' THEN  #add 150216
         #检查成本分群xcbb010
         LET l_xcbb010 = NULL
         #SELECT xcbb010 INTO l_xcbb010 FROM xcbb_t
         # WHERE xcbbent  = g_enterprise  #企業代碼
         #   AND xcbbcomp = tm.xccccomp #法人組織
         #   AND xcbb001  = tm.xccc004  #年度
         #   AND xcbb002  = tm.xccc005  #期別
         #   AND xcbb003  = l_xccc.xccc006  #料號
         #   AND xcbb004  = l_xccc.xccc007 #特性
         OPEN axcq301_b_fill_c7 USING l_xccc.xccc006 #,l_xccc.xccc007  #帳套本位幣順序,成本域,元件料号,特性,批號 #mark zhangllc 151109
         FETCH axcq301_b_fill_c7 INTO l_xcbb010                  
         CLOSE axcq301_b_fill_c7
         IF cl_null(l_xcbb010) THEN
            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00453',g_lang) RETURNING ls_msg  #料號未設定成本分群  
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
            LET g_xccc_d[l_ac].docno        = ''                 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg             #错误信息              
         END IF

         #检查成本阶
         FOREACH axcq301_sfaa042_c USING l_xccc.xccc006,l_xccc.xccc007 INTO l_xccd_xcce.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:axcq301_sfaa042_c"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF

            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00454',g_lang) RETURNING ls_msg  #成本階錯誤  
            LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = l_xccd_xcce.xccd006   #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg             #错误信息             
         END FOREACH
      END IF  #add 150216
   END FOREACH  #xccc(foreach for xccc end)
   CLOSE axcq301_xccc_c
   FREE axcq301_xccc_p

   #---------以下对在制工单的检查begin
  #对在制工单做检查
   #LET g_sql = " SELECT xccd_t.*,imaal003 FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccd007 AND imaal002='"||g_dlang||"' ",  #161124-00048#13  16/12/29 By 08734 mark
   LET g_sql = " SELECT xccdent,xccdcomp,xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006,xccd007,xccd008,xccd009,",
               "xccd010,xccd011,xccd012,xccd013,xccd014,xccd101,xccd102,xccd200,xccd201,xccd202,xccd204,xccd301,xccd302,xccd302a,xccd302b,xccd302c,xccd302d,xccd302e,xccd302f,xccd302g,xccd302h,",
               "xccd303,xccd304,xccd901,xccd902,xccd902a,xccd902b,xccd902c,xccd902d,xccd902e,xccd902f,xccd902g,xccd902h,imaal003 FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccd007 AND imaal002='"||g_dlang||"' ",  #161124-00048#13  16/12/29 By 08734 add   
               "  WHERE xccdent = ",g_enterprise,
               "    AND xccdcomp='",tm.xccccomp,"' ", #法人组织
               "    AND xccdld  ='",tm.xcccld,"' ",  #帐别
               "    AND xccd003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xccd004 = ",tm.xccc004," AND xccd005 = ",tm.xccc005 #年度 期别
               #"    AND xccd007 = ? AND xccd008 = ? "   #主件料号 特性
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_xccd_p FROM g_sql
   DECLARE axcq301_xccd_c CURSOR FOR axcq301_xccd_p
   FOREACH axcq301_xccd_c INTO l_xccd.*,l_imaal003  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:axcq301_xccd_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #--检查本月有工時,但無工單資料或已結案
      LET l_xcbi201 = 0
      LET l_xcbi202 = 0
      LET l_xcbi203 = 0
      LET l_xcbi204 = 0
      #SELECT UNIQUE xcbi201,xcbi202,xcbi203,xcbi204 #實際工時，實際幾時，標準工時，標準幾時
      #  INTO l_xcbi201,l_xcbi202,l_xcbi203,l_xcbi204
      #  FROM xcbi_t,xcbh_t  #在制報工和統計單身\单头檔
      # WHERE xcbient = xcbhent AND xcbidocno = xcbhdocno
      #   AND xcbh001 BETWEEN g_bdate AND g_edate  #单据日期
      #   AND xcbi002 = l_xccd.xccd006  #工单编号
      OPEN axcq301_b_fill_c8 USING l_xccd.xccd006  #工单编号
      FETCH axcq301_b_fill_c8 INTO l_xcbi201,l_xcbi202,l_xcbi203,l_xcbi204
      CLOSE axcq301_b_fill_c8
      IF (l_xcbi201 IS NOT NULL AND l_xcbi201 <> 0) OR (l_xcbi202 IS NOT NULL AND l_xcbi202 <> 0)
      OR (l_xcbi203 IS NOT NULL AND l_xcbi203 <> 0) OR (l_xcbi204 IS NOT NULL AND l_xcbi204 <> 0) THEN
         #有无工单资料
         #SELECT COUNT(*) INTO l_cnt FROM axcq301_xcce
         # WHERE xcceent = g_enterprise
         #   AND xccecomp= tm.xccccomp  #法人组织
         #   AND xcceld  = tm.xcccld    #帐别
         #   AND xcce003 = tm.xccc003   #成本计算类别
         #   AND xcce004 = tm.xccc004 AND xcce005 = tm.xccc005 #年度 期别
         #   AND xcce006 = l_xccd.xccd006 #工单单号
         #   AND xcce007 = 'DL+OH+SUB'    #元件料号
         OPEN axcq301_b_fill_c9 USING l_xccd.xccd006  #工单编号
         FETCH axcq301_b_fill_c9 INTO l_cnt
         CLOSE axcq301_b_fill_c9
         #是否已结案
         #SELECT sfaa048 INTO l_sfaa048 #成本结案日
         #  FROM s a_t
         # WHERE sfaaent  = g_enterprise
         #   AND sfaadocno= l_xccd.xccd006
         OPEN axcq301_b_fill_c10 USING l_xccd.xccd006  #工单编号
         FETCH axcq301_b_fill_c10 INTO l_sfaa048
         CLOSE axcq301_b_fill_c10
         IF (l_xccd.xccd102+l_xccd.xccd202+l_xccd.xccd204) = 0  #上期結存金額+本期本階投入金額+本期下階投入金額
         OR l_cnt = 0  #无工单资料
         OR (l_sfaa048 IS NOT NULL AND l_sfaa048 < g_bdate)  #已结案
         THEN
            LET l_ac = l_ac + 1
            CALL cl_getmsg('axc-00428',g_lang) RETURNING ls_msg  #本月有工時，但無工單DL+OH+SUB資料或工單已結案 
            LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
            LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
            LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
            LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg             #错误信息              
         END IF
      END IF

      #####-----检查主件-----#####begin
      #--检查主件 本月轉出>上月結存+本月投入
      IF l_xccd.xccd301 > (l_xccd.xccd101 + l_xccd.xccd201) THEN #本月转出数量>上月结存数量+本月投入数量
         LET l_ac = l_ac + 1
         LET l_str1 = l_xccd.xccd301
         LET l_str2 = l_xccd.xccd101 + l_xccd.xccd201
         LET l_str = l_str1.trim(),'|',l_str2.trim()
         CALL cl_getmsg_parm('axc-00429',g_lang,l_str) RETURNING ls_msg  #本月轉出%1 > 上月結存 + 本月投入%2
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg  #错误信息
      END IF

      #--检查主件 在製成本(主件)期末數量為零，金額不為零
      IF l_xccd.xccd901 = 0 AND l_xccd.xccd902 != 0 THEN  #期末結存數量 金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00430',g_lang) RETURNING ls_msg  #在製成本(主件)期末數量為零，金額不為零 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 在製成本(主件)期末金額為零，數量不為零
      IF l_xccd.xccd901 != 0 AND l_xccd.xccd902 = 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00431',g_lang) RETURNING ls_msg  #在製成本(主件)期末金額為零，數量不為零 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息          
      END IF

      #--检查主件 在製成本(主件)期末金額為負
      IF l_xccd.xccd902 < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00432',g_lang) RETURNING ls_msg  #在製成本(主件)期末金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 在製成本(主件)期末材料金額為負
      IF l_xccd.xccd902a < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00433',g_lang) RETURNING ls_msg  #在製成本(主件)期末材料金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 在製成本(主件)期末人工金額為負
      IF l_xccd.xccd902b < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00434',g_lang) RETURNING ls_msg  #在製成本(主件)期末人工金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 在製成本(主件)期末製費金額為負
      IF l_xccd.xccd902d<0 OR l_xccd.xccd902e<0 OR l_xccd.xccd902f<0 OR l_xccd.xccd902g<0 OR l_xccd.xccd902h<0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00435',g_lang) RETURNING ls_msg  #在製成本(主件)期末製費金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 在製成本(主件)期末加工金額為負
      IF l_xccd.xccd902c < 0 THEN
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00436',g_lang) RETURNING ls_msg  #在製成本(主件)期末加工金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息           
      END IF

      #--检查主件 主件(期初+投入)量=0,但(期初+投入)金額<>0
      IF (l_xccd.xccd101+l_xccd.xccd201) = 0 AND (l_xccd.xccd102+l_xccd.xccd202+l_xccd.xccd204) <> 0 THEN #上月结存数量+本月投入数量 上月结存金额+本月投入金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00437',g_lang) RETURNING ls_msg  #主件(期初+投入)量為0，但(期初+投入)金額不為0  
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息          
      END IF

      #--检查主件 在製轉出(主件)金額為負值
      IF l_xccd.xccd302 > 0 THEN #本期轉出金額
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00438',g_lang) RETURNING ls_msg  #在製轉出(主件)金額為負值
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg             #错误信息          
      END IF

      #--检查主件 在製主件期初不等于上月期末，差异为***
      LET l_xccd902 = NULL
      #SELECT xccd902 INTO l_xccd902 FROM xccd_t #上月结存金额
      # WHERE xccdent = l_xccd.xccdent
      #   AND xccdld  = l_xccd.xccdld
      #   AND xccd001 = l_xccd.xccd001  #帳套本位幣順序
      #   AND xccd002 = l_xccd.xccd002  #成本域
      #   AND xccd003 = l_xccd.xccd003  #成本計算類型
      #   AND xccd004 = g_yy
      #   AND xccd005 = g_mm
      #   AND xccd006 = l_xccd.xccd006  #工單編號
      OPEN axcq301_b_fill_c11 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
      FETCH axcq301_b_fill_c11 INTO l_xccd902
      CLOSE axcq301_b_fill_c11
      IF cl_null(l_xccd902) THEN LET l_xccd902 = 0 END IF

      LET l_xccb102 = NULL
      #SELECT SUM(xccb102) INTO l_xccb102 FROM xccb_t  #期初开帐资料
      # WHERE xccbent = l_xccd.xccdent
      #   AND xccbld  = l_xccd.xccdld
      #   AND xccb001 = l_xccd.xccd001  #帳套本位幣順序
      #   AND xccb002 = l_xccd.xccd002  #成本域
      #   AND xccb003 = l_xccd.xccd003  #成本計算類型
      #   AND xccb004 = g_yy
      #   AND xccb005 = g_mm
      #   AND xccb006 = l_xccd.xccd006  #工單編號
      OPEN axcq301_b_fill_c12 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
      FETCH axcq301_b_fill_c12 INTO l_xccb102 
      CLOSE axcq301_b_fill_c12
      IF NOT cl_null(l_xccb102) THEN LET l_xccd902 = l_xccb102 END IF

      IF l_xccd902 != l_xccd.xccd102 THEN
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd102 - l_xccd902
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00439',g_lang) RETURNING ls_msg  #在製主件期初不等於上月期末，差异为: 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF

      #--检查主件
      LET l_xcce202 = 0 LET l_xcce302 = 0
      LET l_xcce102 = 0 LET l_xcce902 = 0
      LET l_xcce304 = 0
      LET l_xcce206 = 0 LET l_xcce208 = 0 LET l_xcce210 = 0 #add 141203
      #SELECT SUM(xcce202),SUM(xcce302),SUM(xcce102),SUM(xcce902),SUM(xcce304),
      #       SUM(xcce206),SUM(xcce208),SUM(xcce210)  #add 141203
      #  INTO l_xcce202,l_xcce302,l_xcce102,l_xcce902,l_xcce304,
      #       l_xcce206,l_xcce208,l_xcce210 #add 141203
      #  FROM axcq301_xcce
      # WHERE xcceent = g_enterprise
      #   AND xccecomp= l_xccd.xccdcomp  #法人组织
      #   AND xcceld  = l_xccd.xccdld    #帐别
      #   AND xcce001 = l_xccd.xccd001  #帳套本位幣順序
      #   AND xcce002 = l_xccd.xccd002  #成本域
      #   AND xcce003 = l_xccd.xccd003  #成本计算类别
      #   AND xcce004 = tm.xccc004  #年度
      #   AND xcce005 = tm.xccc005  #期别
      #   AND xcce006 = l_xccd.xccd006  #工单
      OPEN axcq301_b_fill_c13 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
      FETCH axcq301_b_fill_c13 INTO l_xcce202,l_xcce302,l_xcce102,l_xcce902,l_xcce304,
                                    l_xcce206,l_xcce208,l_xcce210 #add 141203 
      CLOSE axcq301_b_fill_c13
      IF cl_null(l_xcce202) THEN LET l_xcce202 = 0 END IF #本期本階投入金額
      IF cl_null(l_xcce302) THEN LET l_xcce302 = 0 END IF #本期轉出金額
      IF cl_null(l_xcce102) THEN LET l_xcce102 = 0 END IF #上期結存金額
      IF cl_null(l_xcce902) THEN LET l_xcce902 = 0 END IF #期末結存金額
      IF cl_null(l_xcce304) THEN LET l_xcce304 = 0 END IF #差異轉出金額
      IF cl_null(l_xcce206) THEN LET l_xcce206 = 0 END IF #add 141203
      IF cl_null(l_xcce208) THEN LET l_xcce208 = 0 END IF #add 141203
      IF cl_null(l_xcce210) THEN LET l_xcce210 = 0 END IF #add 141203
      LET l_xcce202 = l_xcce202 + l_xcce206 + l_xcce208 + l_xcce210 #add 141203
      #--检查主件 在製投入(主件)金額不等于在製投入(元件)金額，差异为**
      IF l_xccd.xccd202 + l_xccd.xccd204 <> l_xcce202 THEN #本期本階投入金額+本期下階投入金額 != 元件投入金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd202 + l_xccd.xccd204 - l_xcce202
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00440',g_lang) RETURNING ls_msg  #在製投入(主件)金額不等於在製投入(元件)金額，差异为： 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF

      #--检查主件 在製转出(主件)金額不等于在製转出(元件)金額，差异为**
      IF l_xccd.xccd302 <> l_xcce302 THEN #元件转出金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd302 - l_xcce302
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00441',g_lang) RETURNING ls_msg  #在製转出(主件)金額不等於在製转出(元件)金額，差异为：
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息          
      END IF

      #--检查主件 在製期初(主件)金額不等于在製期初(元件)金額，差异为**
      IF l_xccd.xccd102 <> l_xcce102 THEN #元件期初金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd102 - l_xcce102
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00442',g_lang) RETURNING ls_msg  #在製期初(主件)金額不等於在製期初(元件)金額，差异为： 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息          
      END IF

      #--检查主件 在製期未(主件)金額不等于在製期未(元件)金額，差异为**
      IF l_xccd.xccd902 <> l_xcce902 THEN  #元件期未金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd902 - l_xcce902
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00443',g_lang) RETURNING ls_msg  #在製期未(主件)金額不等於在製期未(元件)金額，差异为： 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF

      #--检查主件 在製差异(主件)金額不等于在製差异(元件)金額，差异为**
      IF l_xccd.xccd304 <> l_xcce304 THEN  #元件差异金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xccd.xccd304 - l_xcce304
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00444',g_lang) RETURNING ls_msg  #在製差异(主件)金額不等於在製差异(元件)金額，差异为： 
         LET g_xccc_d[l_ac].xccc006      = l_xccd.xccd007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xccd.xccd008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
         LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF
      #####-----检查主件-----#####end

      #####-----检查联产品-----#####begin 与在制的检查
      LET l_xccg302a=0 LET l_xccg302b=0 LET l_xccg302c=0
      LET l_xccg302d=0 LET l_xccg302e=0 LET l_xccg302f=0
      LET l_xccg302g=0 LET l_xccg302h=0
      #SELECT SUM(xccg302a),SUM(xccg302b),SUM(xccg302c),SUM(xccg302d),SUM(xccg302e),SUM(xccg302f),SUM(xccg302g),SUM(xccg302h)
      #  INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      #  FROM xccg_t
      # WHERE xccgent = l_xccd.xccdent
      #   AND xccgld  = l_xccd.xccdld    #帐别
      #   AND xccg001 = l_xccd.xccd001  #帳套本位幣順序
      #   AND xccg002 = l_xccd.xccd002  #成本域
      #   AND xccg003 = l_xccd.xccd003  #成本计算类别
      #   AND xccg004 = tm.xccc004  #年度
      #   AND xccg005 = tm.xccc005  #期别
      #   AND xccg006 = l_xccd.xccd006  #工单
      #   #AND xccg007 = #聯產品料號
      #   #AND xccg008 = #特性
      #   #AND xccg009 = #批號
      OPEN axcq301_b_fill_c14 USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序,成本域,工单编号
      FETCH axcq301_b_fill_c14 INTO l_xccg302a,l_xccg302b,l_xccg302c,l_xccg302d,l_xccg302e,l_xccg302f,l_xccg302g,l_xccg302h  #本期轉出金額
      CLOSE axcq301_b_fill_c14
      IF NOT cl_null(l_xccg302a) OR NOT cl_null(l_xccg302b) OR NOT cl_null(l_xccg302c)
      OR NOT cl_null(l_xccg302d) OR NOT cl_null(l_xccg302e) OR NOT cl_null(l_xccg302f)
      OR NOT cl_null(l_xccg302g) OR NOT cl_null(l_xccg302h)
      THEN #add 150212 无资料就不需勾稽联产品
         IF cl_null(l_xccg302a) THEN LET l_xccg302a = 0 END IF
         IF cl_null(l_xccg302b) THEN LET l_xccg302b = 0 END IF
         IF cl_null(l_xccg302c) THEN LET l_xccg302c = 0 END IF
         IF cl_null(l_xccg302d) THEN LET l_xccg302d = 0 END IF
         IF cl_null(l_xccg302e) THEN LET l_xccg302e = 0 END IF
         IF cl_null(l_xccg302f) THEN LET l_xccg302f = 0 END IF
         IF cl_null(l_xccg302g) THEN LET l_xccg302g = 0 END IF
         IF cl_null(l_xccg302h) THEN LET l_xccg302h = 0 END IF
         LET l_xccg302a = l_xccg302a * -1
         LET l_xccg302b = l_xccg302b * -1
         LET l_xccg302c = l_xccg302c * -1
         LET l_xccg302d = l_xccg302d * -1
         LET l_xccg302e = l_xccg302e * -1
         LET l_xccg302f = l_xccg302f * -1
         LET l_xccg302g = l_xccg302g * -1
         LET l_xccg302h = l_xccg302h * -1
         #IF l_xccg302a !=  l_xccd.xccd302a+l_xccd.xccd304a THEN #mod 141203 add xccd304
         IF l_xccg302a !=  l_xccd.xccd302a THEN #mod 141203 add xccd304 #mod 150112
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302a
            LET l_str2 = l_xccd.xccd302a
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00445',g_lang,l_str) RETURNING ls_msg  ##工單聯產品材料轉出合計%1 不等於 工單材料轉出%2
            LET g_xccc_d[l_ac].xccc006      = '' #料号
            LET g_xccc_d[l_ac].xccc007      = '' #特征
            LET g_xccc_d[l_ac].xccc006_desc = '' #品名
            LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         IF l_xccg302b !=  l_xccd.xccd302b THEN #mod 141203 add xccd304 #mod 150112
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302b
            LET l_str2 = l_xccd.xccd302b
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00446',g_lang,l_str) RETURNING ls_msg  #工單聯產品人工轉出合計%1 不等於 工單人工轉出%2
            LET g_xccc_d[l_ac].xccc006      = '' #料号
            LET g_xccc_d[l_ac].xccc007      = '' #特征
            LET g_xccc_d[l_ac].xccc006_desc = '' #品名
            LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         #IF l_xccg302d != l_xccd.xccd302d+l_xccd.xccd304d OR l_xccg302e != l_xccd.xccd302e+l_xccd.xccd304e
         #OR l_xccg302f != l_xccd.xccd302f+l_xccd.xccd304f OR l_xccg302g != l_xccd.xccd302g+l_xccd.xccd304g
         #OR l_xccg302h != l_xccd.xccd302h+l_xccd.xccd304h THEN #mod 141203 add xccd304
         IF l_xccg302d != l_xccd.xccd302d OR l_xccg302e != l_xccd.xccd302e
         OR l_xccg302f != l_xccd.xccd302f OR l_xccg302g != l_xccd.xccd302g
         OR l_xccg302h != l_xccd.xccd302h THEN #mod 141203 add xccd304 #mod 150112 拿掉xccd304
            LET l_ac = l_ac + 1
            CASE
               WHEN l_xccg302d != l_xccd.xccd302d
                    LET l_str1 = l_xccg302d
                    LET l_str2 = l_xccd.xccd302d
               WHEN l_xccg302e != l_xccd.xccd302e
                    LET l_str1 = l_xccg302e
                    LET l_str2 = l_xccd.xccd302e
               WHEN l_xccg302f != l_xccd.xccd302f
                    LET l_str1 = l_xccg302f
                    LET l_str2 = l_xccd.xccd302f
               WHEN l_xccg302g != l_xccd.xccd302g
                    LET l_str1 = l_xccg302g
                    LET l_str2 = l_xccd.xccd302g
               WHEN l_xccg302h != l_xccd.xccd302h
                    LET l_str1 = l_xccg302h
                    LET l_str2 = l_xccd.xccd302h
            END CASE
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING ls_msg  #工單聯產品制费轉出合計%1 不等於 工單制费轉出%2
            LET g_xccc_d[l_ac].xccc006      = '' #料号
            LET g_xccc_d[l_ac].xccc007      = '' #特征
            LET g_xccc_d[l_ac].xccc006_desc = '' #品名
            LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF

         #IF l_xccg302c !=  l_xccd.xccd302c+l_xccd.xccd304c THEN #mod 141203 add xccd304
         IF l_xccg302c !=  l_xccd.xccd302c THEN #mod 141203 add xccd304 #mod 150112
            LET l_ac = l_ac + 1
            LET l_str1 = l_xccg302c
            LET l_str2 = l_xccd.xccd302c
            LET l_str = l_str1.trim(),'|',l_str2.trim()
            CALL cl_getmsg_parm('axc-00448',g_lang,l_str) RETURNING ls_msg  #工單聯產品加工轉出合計%1 不等於 工單加工轉出%2
            LET g_xccc_d[l_ac].xccc006      = '' #料号
            LET g_xccc_d[l_ac].xccc007      = '' #特征
            LET g_xccc_d[l_ac].xccc006_desc = '' #品名
            LET g_xccc_d[l_ac].docno        = l_xccd.xccd006 #单据编号
            LET g_xccc_d[l_ac].info         = ls_msg         #错误信息
         END IF
      END IF #add 150212 end
      #####-----检查联产品-----#####end 与在制的检查
   END FOREACH  #xccd(foreach for xccd end)
   
   #####-----检查元件-----#####begin
  #在制工单元件检查

   LET g_sql = " SELECT axcq301_xcce.*,imaal003 ",
               "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xcce007 AND imaal002='"||g_dlang||"' ",                       
               "  WHERE xcceent = ",g_enterprise,
               "    AND xccecomp='",tm.xccccomp,"' ", #法人组织
               "    AND xcceld  ='",tm.xcccld,"' ",  #帐别
               "    AND xcce003 ='",tm.xccc003,"'",  #成本计算类别
               "    AND xcce004 = ",tm.xccc004," AND xcce005 = ",tm.xccc005  #年度 期别
              #"    AND xcce001 = ? ",  #帳套本位幣順序
              #"    AND xcce002 = ? ",  #成本域
              #"    AND xcce006 = ? "   #工单
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq301_xcce_p FROM g_sql
   DECLARE axcq301_xcce_c CURSOR FOR axcq301_xcce_p
   FOREACH axcq301_xcce_c #USING l_xccd.xccd001,l_xccd.xccd002,l_xccd.xccd006  #帳套本位幣順序 成本域 工单
      INTO l_xcce.*,l_imaal003_2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:axcq301_xcce_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF l_xcce.xcce902 < 0 THEN  #本月结存金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00455',g_lang) RETURNING ls_msg  #在制成本(元件)期末金额为负 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      IF l_xcce.xcce902a < 0 THEN  #本月结存材料金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00456',g_lang) RETURNING ls_msg  #在製成本(元件)期末材料金額為負
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息          
      END IF

      IF l_xcce.xcce902b < 0 THEN  #本月结存人工金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00457',g_lang) RETURNING ls_msg  #在製成本(元件)期末人工金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      IF l_xcce.xcce902d < 0 OR l_xcce.xcce902e < 0 OR l_xcce.xcce902f < 0 OR l_xcce.xcce902g < 0 OR l_xcce.xcce902h < 0 THEN  #本月结存制费金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00458',g_lang) RETURNING ls_msg  #在製成本(元件)期末製費金額為負 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      IF l_xcce.xcce902c < 0 THEN  #本月结存加工金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00459',g_lang) RETURNING ls_msg  #在製成本(元件)期末加工金額為負
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      IF l_xcce.xcce901 < 0 THEN  #本月结存数量
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00460',g_lang) RETURNING ls_msg  #在製成本(元件)期末數量為負 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      IF l_xcce.xcce101+l_xcce.xcce201=0 AND l_xcce.xcce102+l_xcce.xcce202 !=0 AND l_xcce.xcce007!='DL+OH+SUB' THEN #上月结存数量+本月投入数量 上月结存金额+本月投入金额
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00461',g_lang) RETURNING ls_msg  #元件(期初+投入)量為0，但(期初+投入)金額不為0 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息          
      END IF

      IF l_xcce.xcce302 > 0 THEN #本期转出金额(后台存储为负值)
         LET l_ac = l_ac + 1
         CALL cl_getmsg('axc-00462',g_lang) RETURNING ls_msg  #在製轉出(元件)金額為負值
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg        #错误信息           
      END IF

      LET l_xcce901 = 0 LET l_xcce902 = 0  #本月结存数量　本月结存金额
      #SELECT xcce901,xcce902 INTO l_xcce901,l_xcce902 FROM xcce_t
      # WHERE xcceent = l_xcce.xcceent
      #   AND xcceld  = l_xcce.xcceld
      #   AND xcce001 = l_xcce.xcce001  #帳套本位幣順序
      #   AND xcce002 = l_xcce.xcce002  #成本域
      #   AND xcce003 = l_xcce.xcce003
      #   AND xcce004 = g_yy
      #   AND xcce005 = g_mm
      #   AND xcce006 = l_xcce.xcce006  #工單編號
      #   AND xcce007 = l_xcce.xcce007  #元件編號
      #   AND xcce008 = l_xcce.xcce008  #特性
      #   AND xcce009 = l_xcce.xcce009  #批號
      OPEN axcq301_b_fill_c15 USING l_xcce.xcce001,l_xcce.xcce002,l_xcce.xcce006,l_xcce.xcce007,l_xcce.xcce008,l_xcce.xcce009
      FETCH axcq301_b_fill_c15 INTO l_xcce901,l_xcce902
      CLOSE axcq301_b_fill_c15
      IF l_xcce901 IS NULL THEN LET l_xcce901 = 0 END IF
      IF l_xcce902 IS NULL THEN LET l_xcce902 = 0 END IF

      LET l_xccb101 = NULL  LET l_xccb102 = NULL
      #SELECT SUM(xccb101),SUM(xccb102) INTO l_xccb101,l_xccb102 FROM xccb_t
      # WHERE xccbent = l_xcce.xcceent
      #   AND xccbld  = l_xcce.xcceld
      #   AND xccb001 = l_xcce.xcce001  #帳套本位幣順序
      #   AND xccb002 = l_xcce.xcce002  #成本域
      #   AND xccb003 = l_xcce.xcce003  #成本計算類型
      #   AND xccb004 = g_yy
      #   AND xccb005 = g_mm
      #   AND xccb006 = l_xcce.xcce006  #工單編號
      #   AND xccb007 = l_xcce.xcce007  #元件編號
      #   AND xccb008 = l_xcce.xcce008  #特性
      #   AND xccb009 = l_xcce.xcce009  #批號
      OPEN axcq301_b_fill_c16 USING l_xcce.xcce001,l_xcce.xcce002,l_xcce.xcce006,l_xcce.xcce007,l_xcce.xcce008,l_xcce.xcce009
      FETCH axcq301_b_fill_c16 INTO l_xccb101,l_xccb102
      CLOSE axcq301_b_fill_c16
      IF NOT cl_null(l_xccb101) THEN LET l_xcce901 = l_xccb101 END IF
      IF NOT cl_null(l_xccb102) THEN LET l_xcce902 = l_xccb102 END IF

      IF l_xcce901 != l_xcce.xcce101 THEN  #上期期末結存數量 上期結存數量
         LET l_ac = l_ac + 1
         LET l_diff = l_xcce901 - l_xcce.xcce101
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00463',g_lang) RETURNING ls_msg  #在製元件期初數量不等於上期期末數量，差異為
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF

      IF l_xcce902 != l_xcce.xcce102 THEN  #上期期末結存金额 上期結存金额
         LET l_ac = l_ac + 1
         LET l_diff = l_xcce902 - l_xcce.xcce102
         IF l_diff < 0 THEN
            LET l_diff = l_diff * -1
         END IF
         CALL cl_getmsg('axc-00464',g_lang) RETURNING ls_msg  #在製元件期初金額不等於上期期末金額，差異為： 
         LET g_xccc_d[l_ac].xccc006      = l_xcce.xcce007 #料号
         LET g_xccc_d[l_ac].xccc007      = l_xcce.xcce008 #特征
         LET g_xccc_d[l_ac].xccc006_desc = l_imaal003_2   #品名
         LET g_xccc_d[l_ac].docno        = l_xcce.xcce006 #单据编号
         LET g_xccc_d[l_ac].info         = ls_msg,l_diff        #错误信息           
      END IF
   END FOREACH  #xcce(foreach for xcce end)
   #####-----检查元件-----#####end
   #在制工单的检查----------end

   LET g_detail_cnt = g_xccc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Date & Author..: 2015/3/20 By wangxina
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq301_create_temp_table()
DROP TABLE axcq301_tmp;
   CREATE TEMP TABLE axcq301_tmp(
   xccc006         VARCHAR(40), 
   xccc007         VARCHAR(256), 
   xccc006_desc    VARCHAR(100),
   docno           VARCHAR(100), 
   info            VARCHAR(100),
   xccccomp        VARCHAR(10),
   xccccomp_desc   VARCHAR(100),     
   xcccld          VARCHAR(5),
   xcccld_desc     VARCHAR(100),
   xccc004         SMALLINT,
   xccc005         SMALLINT,
   xccc003         VARCHAR(10),
   xccc003_desc    VARCHAR(100),
   l_key           VARCHAR(100)
   );
END FUNCTION

################################################################################
# Descriptions...: 临时表插入数据
# Memo...........:
# Date & Author..: 15/03/23 By wangxina
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq301_ins_temp()
DEFINE sr           RECORD
   xccc006        LIKE xccc_t.xccc006, 
   xccc007        LIKE xccc_t.xccc007, 
   xccc006_desc   LIKE type_t.chr100,
   docno          LIKE type_t.chr100, 
   info           LIKE type_t.chr100,
   xccccomp       LIKE xccc_t.xccccomp,
   xccccomp_desc  LIKE type_t.chr100,     
   xcccld         LIKE xccc_t.xcccld,
   xcccld_desc    LIKE type_t.chr100,
   xccc004        LIKE xccc_t.xccc004,
   xccc005        LIKE xccc_t.xccc005,
   xccc003        LIKE xccc_t.xccc003,
   xccc003_desc   LIKE type_t.chr100,
   l_key          LIKE type_t.chr100
       END RECORD
DEFINE l_i           LIKE type_t.num5
DEFINE l_xccc005     LIKE type_t.chr100
DEFINE l_xccc004     LIKE type_t.chr100
DEFINE l_success     LIKE type_t.num5
 
 LET l_success = TRUE
 
    LET sr.xccccomp=tm.xccccomp
    LET sr.xcccld=tm.xcccld
    LET sr.xccc004=tm.xccc004
    LET sr.xccc005=tm.xccc005
    LET sr.xccc003=tm.xccc003
        
    LET l_xccc005=sr.xccc005
    LET l_xccc004=sr.xccc004
    LET sr.l_key=sr.xccccomp,"-",sr.xcccld CLIPPED,"-" CLIPPED,l_xccc004 CLIPPED,"-" CLIPPED,l_xccc005,"-",sr.xccc003 CLIPPED

    #法人，账套，成本计算类型    
    INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xccccomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xccccomp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xccccomp_desc 
    INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xcccld
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xcccld_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xcccld_desc 
     
    INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xccc003
      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xccc003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xccc003_desc
       
       FOR l_i=1 TO g_xccc_d.getLength()
       #IF g_xccc_d[l_i].xcccent=g_enterprise AND g_xccc_d[l_i].xcccld=sr.xcccld AND g_xccc_d[l_i].xccc004=sr.xccc004 AND g_xccc_d[l_i].xccc005=sr.xccc005 AND g_xccc_d[l_i].xccc003=sr.xccc003 THEN
       INSERT INTO axcq301_tmp (xccc006,xccc007,xccc006_desc,docno,info,xccccomp,xccccomp_desc,xcccld,xcccld_desc,xccc004,xccc005,xccc003,xccc003_desc,l_key)
                  VALUES (g_xccc_d[l_i].xccc006,g_xccc_d[l_i].xccc007,g_xccc_d[l_i].xccc006_desc,g_xccc_d[l_i].docno,g_xccc_d[l_i].info,sr.xccccomp,sr.xccccomp_desc,sr.xcccld,sr.xcccld_desc,
                          sr.xccc004,sr.xccc005,sr.xccc003,sr.xccc003_desc,sr.l_key)
      IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'insert tmp'
          LET g_errparam.code = SQLCA.SQLCODE
          LET g_errparam.popup = TRUE
          CALL cl_err()
           LET l_success = FALSE
       END IF
   
       #END IF
       
       END FOR
        
       CALL cl_err_collect_show()
       IF l_success = FALSE THEN
          DELETE FROM axcq301_tmp
       END IF
 

END FUNCTION

################################################################################
# Descriptions...: b_fill3效能優化
# Memo...........:
# Usage..........: CALL axcq301_b_fill4()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 160523 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq301_b_fill4()

DEFINE l_glaa003   LIKE glaa_t.glaa003
DEFINE ls_msg      STRING
DEFINE l_sfdc001   LIKE sfdc_t.sfdc001   #工单编号
#161124-00048#13  16/12/29 By 08734 mark(S)
#DEFINE l_xccc      RECORD LIKE xccc_t.*  #在制库存 
#DEFINE l_xccd      RECORD LIKE xccd_t.*  #在制主件
#DEFINE l_xcce      RECORD LIKE xcce_t.*  #在制元件
#DEFINE l_xcck      RECORD LIKE xcck_t.*  #料件明细
#DEFINE l_xccg      RECORD LIKE xccg_t.*  #联产品
#161124-00048#13  16/12/29 By 08734 mark(S)
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccc RECORD  #料件庫存成本期異動統計檔
       xcccent LIKE xccc_t.xcccent, #企业编号
       xccccomp LIKE xccc_t.xccccomp, #法人组织
       xcccld LIKE xccc_t.xcccld, #账套
       xccc001 LIKE xccc_t.xccc001, #账套本位币顺序
       xccc002 LIKE xccc_t.xccc002, #成本域
       xccc003 LIKE xccc_t.xccc003, #成本计算类型
       xccc004 LIKE xccc_t.xccc004, #年度
       xccc005 LIKE xccc_t.xccc005, #期别
       xccc006 LIKE xccc_t.xccc006, #料号
       xccc007 LIKE xccc_t.xccc007, #特性码
       xccc008 LIKE xccc_t.xccc008, #批号
       xccc010 LIKE xccc_t.xccc010, #核算币种
       xccc101 LIKE xccc_t.xccc101, #上期结存数量
       xccc102 LIKE xccc_t.xccc102, #上期结存金额
       xccc201 LIKE xccc_t.xccc201, #本期采购入库数量
       xccc202 LIKE xccc_t.xccc202, #本期采购入库金额
       xccc203 LIKE xccc_t.xccc203, #本期委外入库数量
       xccc204 LIKE xccc_t.xccc204, #本期委外入库金额
       xccc205 LIKE xccc_t.xccc205, #本期工单入库数量
       xccc206 LIKE xccc_t.xccc206, #本期工单入库金额
       xccc206a LIKE xccc_t.xccc206a,
       xccc206b LIKE xccc_t.xccc206b,
       xccc206c LIKE xccc_t.xccc206c,
       xccc206d LIKE xccc_t.xccc206d,
       xccc206e LIKE xccc_t.xccc206e,
       xccc206f LIKE xccc_t.xccc206f,
       xccc206g LIKE xccc_t.xccc206g,
       xccc206h LIKE xccc_t.xccc206h,
       xccc207 LIKE xccc_t.xccc207, #本期返工领出数量
       xccc208 LIKE xccc_t.xccc208, #本期返工领出金额
       xccc208a LIKE xccc_t.xccc208a,
       xccc208b LIKE xccc_t.xccc208b,
       xccc208c LIKE xccc_t.xccc208c,
       xccc208d LIKE xccc_t.xccc208d,
       xccc208e LIKE xccc_t.xccc208e,
       xccc208f LIKE xccc_t.xccc208f,
       xccc208g LIKE xccc_t.xccc208g,
       xccc208h LIKE xccc_t.xccc208h,
       xccc209 LIKE xccc_t.xccc209, #本期返工入库数量
       xccc210 LIKE xccc_t.xccc210, #本期返工入库金额
       xccc210a LIKE xccc_t.xccc210a,
       xccc210b LIKE xccc_t.xccc210b,
       xccc210c LIKE xccc_t.xccc210c,
       xccc210d LIKE xccc_t.xccc210d,
       xccc210e LIKE xccc_t.xccc210e,
       xccc210f LIKE xccc_t.xccc210f,
       xccc210g LIKE xccc_t.xccc210g,
       xccc210h LIKE xccc_t.xccc210h,
       xccc211 LIKE xccc_t.xccc211, #本期杂项入库数量
       xccc212 LIKE xccc_t.xccc212, #本期杂项入库金额
       xccc213 LIKE xccc_t.xccc213, #本期调整入库数量
       xccc214 LIKE xccc_t.xccc214, #本期调整入库金额
       xccc215 LIKE xccc_t.xccc215, #本期销退入库数量
       xccc216 LIKE xccc_t.xccc216, #本期销退入库金额
       xccc217 LIKE xccc_t.xccc217, #本期调拨入库数量
       xccc218 LIKE xccc_t.xccc218, #本期调拨入库金额
       xccc280 LIKE xccc_t.xccc280, #本期平均单价
       xccc280a LIKE xccc_t.xccc280a,
       xccc280b LIKE xccc_t.xccc280b,
       xccc280c LIKE xccc_t.xccc280c,
       xccc280d LIKE xccc_t.xccc280d,
       xccc280e LIKE xccc_t.xccc280e,
       xccc280f LIKE xccc_t.xccc280f,
       xccc280g LIKE xccc_t.xccc280g,
       xccc280h LIKE xccc_t.xccc280h,
       xccc301 LIKE xccc_t.xccc301, #本期工单领用数量
       xccc302 LIKE xccc_t.xccc302, #本期工单领用金额
       xccc303 LIKE xccc_t.xccc303, #本期销货数量
       xccc304 LIKE xccc_t.xccc304, #本期销货成本
       xccc305 LIKE xccc_t.xccc305, #本期销退数量
       xccc306 LIKE xccc_t.xccc306, #本期销退成本
       xccc307 LIKE xccc_t.xccc307, #本期销售费用数量
       xccc308 LIKE xccc_t.xccc308, #本期销售费用成本
       xccc309 LIKE xccc_t.xccc309, #本期杂发数量
       xccc310 LIKE xccc_t.xccc310, #本期杂发金额
       xccc311 LIKE xccc_t.xccc311, #本期盘盈亏数量
       xccc312 LIKE xccc_t.xccc312, #本期盘盈亏金额
       xccc313 LIKE xccc_t.xccc313, #本期调拨出库数量
       xccc314 LIKE xccc_t.xccc314, #本期调拨出库金额
       xccc401 LIKE xccc_t.xccc401, #本期销货收入金额
       xccc402 LIKE xccc_t.xccc402, #本期销退金额
       xccc901 LIKE xccc_t.xccc901, #期末结存数量
       xccc902 LIKE xccc_t.xccc902, #期末结存金额
       xccc902a LIKE xccc_t.xccc902a,
       xccc902b LIKE xccc_t.xccc902b,
       xccc902c LIKE xccc_t.xccc902c,
       xccc902d LIKE xccc_t.xccc902d,
       xccc902e LIKE xccc_t.xccc902e,
       xccc902f LIKE xccc_t.xccc902f,
       xccc902g LIKE xccc_t.xccc902g,
       xccc902h LIKE xccc_t.xccc902h,
       xccc903 LIKE xccc_t.xccc903 #期末结存调整金额
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccd RECORD  #在製主件成本期異動統計檔
       xccdent LIKE xccd_t.xccdent, #企业编号
       xccdcomp LIKE xccd_t.xccdcomp, #法人组织
       xccdld LIKE xccd_t.xccdld, #账套
       xccd001 LIKE xccd_t.xccd001, #账套本位币顺序
       xccd002 LIKE xccd_t.xccd002, #成本域
       xccd003 LIKE xccd_t.xccd003, #成本计算类型
       xccd004 LIKE xccd_t.xccd004, #年度
       xccd005 LIKE xccd_t.xccd005, #期别
       xccd006 LIKE xccd_t.xccd006, #工单编号
       xccd007 LIKE xccd_t.xccd007, #主件料号
       xccd008 LIKE xccd_t.xccd008, #特性
       xccd009 LIKE xccd_t.xccd009, #批号
       xccd010 LIKE xccd_t.xccd010, #项目号
       xccd011 LIKE xccd_t.xccd011, #核算币种
       xccd012 LIKE xccd_t.xccd012, #重复性成产否
       xccd013 LIKE xccd_t.xccd013, #成产计划号
       xccd014 LIKE xccd_t.xccd014, #BOM特性
       xccd101 LIKE xccd_t.xccd101, #上期结存数量
       xccd102 LIKE xccd_t.xccd102, #上期结存金额
       xccd200 LIKE xccd_t.xccd200, #本期投入工时
       xccd201 LIKE xccd_t.xccd201, #本期投入数量
       xccd202 LIKE xccd_t.xccd202, #本期本阶投入金额
       xccd204 LIKE xccd_t.xccd204, #本期下阶投入金额
       xccd301 LIKE xccd_t.xccd301, #本期转出数量
       xccd302 LIKE xccd_t.xccd302, #本期转出金额
       xccd302a LIKE xccd_t.xccd302a,
       xccd302b LIKE xccd_t.xccd302b,
       xccd302c LIKE xccd_t.xccd302c,
       xccd302d LIKE xccd_t.xccd302d,
       xccd302e LIKE xccd_t.xccd302e,
       xccd302f LIKE xccd_t.xccd302f,
       xccd302g LIKE xccd_t.xccd302g,
       xccd302h LIKE xccd_t.xccd302h,
       xccd303 LIKE xccd_t.xccd303, #差异转出数量
       xccd304 LIKE xccd_t.xccd304, #差异转出金额
       xccd901 LIKE xccd_t.xccd901, #期末结存数量
       xccd902 LIKE xccd_t.xccd902, #期末结存金额
       xccd902a LIKE xccd_t.xccd902a,
       xccd902b LIKE xccd_t.xccd902b,
       xccd902c LIKE xccd_t.xccd902c,
       xccd902d LIKE xccd_t.xccd902d,
       xccd902e LIKE xccd_t.xccd902e,
       xccd902f LIKE xccd_t.xccd902f,
       xccd902g LIKE xccd_t.xccd902g,
       xccd902h LIKE xccd_t.xccd902h
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xcce RECORD  #在製元件成本期異動統計檔
       xcceent LIKE xcce_t.xcceent, #企业编号
       xccecomp LIKE xcce_t.xccecomp, #法人组织
       xcceld LIKE xcce_t.xcceld, #账套
       xcce001 LIKE xcce_t.xcce001, #账套本位币顺序
       xcce002 LIKE xcce_t.xcce002, #成本域
       xcce003 LIKE xcce_t.xcce003, #成本计算类型
       xcce004 LIKE xcce_t.xcce004, #年度
       xcce005 LIKE xcce_t.xcce005, #期别
       xcce006 LIKE xcce_t.xcce006, #工单编号
       xcce007 LIKE xcce_t.xcce007, #元件编号
       xcce008 LIKE xcce_t.xcce008, #特性
       xcce009 LIKE xcce_t.xcce009, #批号
       xcce010 LIKE xcce_t.xcce010, #核算币种
       xcce101 LIKE xcce_t.xcce101, #上期结存数量
       xcce102 LIKE xcce_t.xcce102, #上期结存金额
       xcce201 LIKE xcce_t.xcce201, #本期投入数量
       xcce202 LIKE xcce_t.xcce202, #本期本阶投入金额
       xcce205 LIKE xcce_t.xcce205, #本期当站下线数量
       xcce206 LIKE xcce_t.xcce206, #本期当站下线成本
       xcce206a LIKE xcce_t.xcce206a, #本期当站下线成本-材料
       xcce206b LIKE xcce_t.xcce206b, #本期当站下线成本-人工
       xcce206c LIKE xcce_t.xcce206c, #本期当站下线成本-加工
       xcce206d LIKE xcce_t.xcce206d, #本期当站下线成本-制费一
       xcce206e LIKE xcce_t.xcce206e, #本期当站下线成本-制费二
       xcce206f LIKE xcce_t.xcce206f, #本期当站下线成本-制费三
       xcce206g LIKE xcce_t.xcce206g, #本期当站下线成本-制费四
       xcce206h LIKE xcce_t.xcce206h, #本期当站下线成本-制费五
       xcce207 LIKE xcce_t.xcce207, #本期一般退料数量
       xcce208 LIKE xcce_t.xcce208, #本期一般退料成本
       xcce208a LIKE xcce_t.xcce208a, #本期一般退料成本-材料
       xcce208b LIKE xcce_t.xcce208b, #本期一般退料成本-人工
       xcce208c LIKE xcce_t.xcce208c, #本期一般退料成本-加工
       xcce208d LIKE xcce_t.xcce208d, #本期一般退料成本-制费一
       xcce208e LIKE xcce_t.xcce208e, #本期一般退料成本-制费二
       xcce208f LIKE xcce_t.xcce208f, #本期一般退料成本-制费三
       xcce208g LIKE xcce_t.xcce208g, #本期一般退料成本-制费四
       xcce208h LIKE xcce_t.xcce208h, #本期一般退料成本-制费五
       xcce209 LIKE xcce_t.xcce209, #本期超领退数量
       xcce210 LIKE xcce_t.xcce210, #本期超领退金额
       xcce210a LIKE xcce_t.xcce210a, #本期超领退金额-材料
       xcce210b LIKE xcce_t.xcce210b, #本期超领退金额-人工
       xcce210c LIKE xcce_t.xcce210c, #本期超领退金额-加工
       xcce210d LIKE xcce_t.xcce210d, #本期超领退金额-制费一
       xcce210e LIKE xcce_t.xcce210e, #本期超领退金额-制费二
       xcce210f LIKE xcce_t.xcce210f, #本期超领退金额-制费三
       xcce210g LIKE xcce_t.xcce210g, #本期超领退金额-制费四
       xcce210h LIKE xcce_t.xcce210h, #本期超领退金额-制费五
       xcce301 LIKE xcce_t.xcce301, #本期转出数量
       xcce302 LIKE xcce_t.xcce302, #本期转出金额
       xcce303 LIKE xcce_t.xcce303, #差异转出数量
       xcce304 LIKE xcce_t.xcce304, #差异转出金额
       xcce307 LIKE xcce_t.xcce307, #盘差数量
       xcce308 LIKE xcce_t.xcce308, #盘差金额
       xcce901 LIKE xcce_t.xcce901, #期末结存数量
       xcce902 LIKE xcce_t.xcce902, #期末结存金额
       xcce902a LIKE xcce_t.xcce902a,
       xcce902b LIKE xcce_t.xcce902b,
       xcce902c LIKE xcce_t.xcce902c,
       xcce902d LIKE xcce_t.xcce902d,
       xcce902e LIKE xcce_t.xcce902e,
       xcce902f LIKE xcce_t.xcce902f,
       xcce902g LIKE xcce_t.xcce902g,
       xcce902h LIKE xcce_t.xcce902h
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xcck RECORD  #本期料件明細進出成本檔
       xcckent LIKE xcck_t.xcckent, #企业编号
       xccksite LIKE xcck_t.xccksite, #site组织
       xcckcomp LIKE xcck_t.xcckcomp, #法人组织
       xcckld LIKE xcck_t.xcckld, #账套
       xcck001 LIKE xcck_t.xcck001, #账套本位币顺序
       xcck002 LIKE xcck_t.xcck002, #成本域
       xcck003 LIKE xcck_t.xcck003, #成本计算类型
       xcck004 LIKE xcck_t.xcck004, #年度
       xcck005 LIKE xcck_t.xcck005, #期别
       xcck006 LIKE xcck_t.xcck006, #参考单号
       xcck007 LIKE xcck_t.xcck007, #项次
       xcck008 LIKE xcck_t.xcck008, #项序
       xcck009 LIKE xcck_t.xcck009, #出入库码
       xcck010 LIKE xcck_t.xcck010, #料号
       xcck011 LIKE xcck_t.xcck011, #特性
       xcck012 LIKE xcck_t.xcck012, #单据类型
       xcck013 LIKE xcck_t.xcck013, #单据日期
       xcck014 LIKE xcck_t.xcck014, #时间
       xcck015 LIKE xcck_t.xcck015, #仓库编号
       xcck016 LIKE xcck_t.xcck016, #储位编号
       xcck017 LIKE xcck_t.xcck017, #批号
       xcck020 LIKE xcck_t.xcck020, #异动类型
       xcck021 LIKE xcck_t.xcck021, #原因码
       xcck022 LIKE xcck_t.xcck022, #交易对象
       xcck023 LIKE xcck_t.xcck023, #客群
       xcck024 LIKE xcck_t.xcck024, #区域
       xcck025 LIKE xcck_t.xcck025, #成本中心
       xcck026 LIKE xcck_t.xcck026, #经营类别
       xcck027 LIKE xcck_t.xcck027, #渠道
       xcck028 LIKE xcck_t.xcck028, #品类
       xcck029 LIKE xcck_t.xcck029, #品牌
       xcck030 LIKE xcck_t.xcck030, #项目号
       xcck031 LIKE xcck_t.xcck031, #WBS
       xcck032 LIKE xcck_t.xcck032, #存货科目
       xcck033 LIKE xcck_t.xcck033, #费用成本科目
       xcck034 LIKE xcck_t.xcck034, #收入科目
       xcck040 LIKE xcck_t.xcck040, #交易币种
       xcck041 LIKE xcck_t.xcck041, #本位币种
       xcck042 LIKE xcck_t.xcck042, #汇率
       xcck043 LIKE xcck_t.xcck043, #交易单位
       xcck044 LIKE xcck_t.xcck044, #成本单位
       xcck045 LIKE xcck_t.xcck045, #换算率
       xcck046 LIKE xcck_t.xcck046, #交易数量
       xcck047 LIKE xcck_t.xcck047, #工单号码
       xcck048 LIKE xcck_t.xcck048, #重复性生产-计划编号
       xcck049 LIKE xcck_t.xcck049, #重复性生产-生产料号
       xcck050 LIKE xcck_t.xcck050, #重复性生产-生产料号BOM特性
       xcck051 LIKE xcck_t.xcck051, #重复性生产-生产料号产品特征
       xcck055 LIKE xcck_t.xcck055, #xccc类型
       xcck201 LIKE xcck_t.xcck201, #本期异动数量
       xcck202 LIKE xcck_t.xcck202, #本期异动金额
       xcck282 LIKE xcck_t.xcck282, #本期异动单价
       xcck301 LIKE xcck_t.xcck301, #已耗数量
       xcck302 LIKE xcck_t.xcck302, #已耗金额
       xcck901 LIKE xcck_t.xcck901, #结存数量
       xcck902 LIKE xcck_t.xcck902, #结存金额
       xcck980 LIKE xcck_t.xcck980, #结存单位成本
       xcck903 LIKE xcck_t.xcck903, #结存调整金额
       xcckownid LIKE xcck_t.xcckownid, #资料所有者
       xcckowndp LIKE xcck_t.xcckowndp, #资料所有部门
       xcckcrtid LIKE xcck_t.xcckcrtid, #资料录入者
       xcckcrtdp LIKE xcck_t.xcckcrtdp, #资料录入部门
       xcckcrtdt LIKE xcck_t.xcckcrtdt, #资料创建日
       xcckmodid LIKE xcck_t.xcckmodid, #资料更改者
       xcckmoddt LIKE xcck_t.xcckmoddt, #最近更改日
       xcckstus LIKE xcck_t.xcckstus, #状态码
       xcck056 LIKE xcck_t.xcck056 #成本代销单号
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
#161124-00048#13  16/12/29 By 08734 add(S)
DEFINE l_xccg RECORD  #聯產品成本期異動統計檔
       xccgent LIKE xccg_t.xccgent, #企业编号
       xccgcomp LIKE xccg_t.xccgcomp, #法人组织
       xccgld LIKE xccg_t.xccgld, #账套
       xccg001 LIKE xccg_t.xccg001, #账套本位币顺序
       xccg002 LIKE xccg_t.xccg002, #成本域
       xccg003 LIKE xccg_t.xccg003, #成本计算类型
       xccg004 LIKE xccg_t.xccg004, #年度
       xccg005 LIKE xccg_t.xccg005, #期别
       xccg006 LIKE xccg_t.xccg006, #工单编号
       xccg007 LIKE xccg_t.xccg007, #联产品料号
       xccg008 LIKE xccg_t.xccg008, #特性
       xccg009 LIKE xccg_t.xccg009, #批号
       xccg010 LIKE xccg_t.xccg010, #核算币种
       xccg101 LIKE xccg_t.xccg101, #上期结存数量
       xccg102 LIKE xccg_t.xccg102, #上期结存金额
       xccg301 LIKE xccg_t.xccg301, #本期转出数量
       xccg302 LIKE xccg_t.xccg302, #本期转出金额
       xccg901 LIKE xccg_t.xccg901, #期末结存数量
       xccg902 LIKE xccg_t.xccg902 #期末结存金额
END RECORD
#161124-00048#13  16/12/29 By 08734 add(E)
DEFINE l_imaa006   LIKE imaa_t.imaa006   #基础单位
DEFINE l_imaa009   LIKE imaa_t.imaa009   #产品分类
DEFINE l_imaal003  LIKE imaal_t.imaal003
DEFINE l_imaal003_2  LIKE imaal_t.imaal003
DEFINE l_xcce202   LIKE xcce_t.xcce202
DEFINE l_xcce206   LIKE xcce_t.xcce206 
DEFINE l_xcce208   LIKE xcce_t.xcce208 
DEFINE l_xcce210   LIKE xcce_t.xcce210 
DEFINE l_xcce308   LIKE xcce_t.xcce308 
DEFINE l_xcck202   LIKE xcck_t.xcck202
DEFINE l_tot       LIKE xccc_t.xccc302  #工单领出金额
DEFINE l_success   LIKE type_t.num5
DEFINE l_xccc902   LIKE xccc_t.xccc902
DEFINE l_inat015   LIKE inat_t.inat015
DEFINE l_sfaa048   LIKE sfaa_t.sfaa048
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_diff      LIKE xccd_t.xccd902
DEFINE l_xcbb010   LIKE xcbb_t.xcbb010  #成本分群
DEFINE l_xccd_xcce RECORD
                   xccd006    LIKE xccd_t.xccd006, #工单
                   xccd007    LIKE xccd_t.xccd007, #主件
                   xccd008    LIKE xccd_t.xccd008, #特性
                   xcbb006a   LIKE xcbb_t.xcbb006, #成本阶数
                   xcce005    LIKE xcce_t.xcce005, #月份
                   xcce007    LIKE xcce_t.xcce007, #元件
                   xcce008    LIKE xcce_t.xcce008, #特性
                   xcbb006b   LIKE xcbb_t.xcbb006, #成本阶数
                   sfaa042    LIKE sfaa_t.sfaa042  #重工否
                   END RECORD
DEFINE l_xcbi201   LIKE xcbi_t.xcbi201
DEFINE l_xcbi202   LIKE xcbi_t.xcbi202
DEFINE l_xcbi203   LIKE xcbi_t.xcbi203
DEFINE l_xcbi204   LIKE xcbi_t.xcbi204
DEFINE l_xccd902   LIKE xccd_t.xccd902
DEFINE l_xcce902   LIKE xcce_t.xcce902
DEFINE l_xcce901   LIKE xcce_t.xcce901
DEFINE l_xcce102   LIKE xcce_t.xcce102
DEFINE l_xcce302   LIKE xcce_t.xcce302
DEFINE l_xcce304   LIKE xcce_t.xcce304
DEFINE l_xccb101   LIKE xccb_t.xccb101
DEFINE l_xccb102   LIKE xccb_t.xccb102
DEFINE l_xccg302   LIKE xccg_t.xccg302
DEFINE l_xccg302a  LIKE xccg_t.xccg302a
DEFINE l_xccg302b  LIKE xccg_t.xccg302b
DEFINE l_xccg302c  LIKE xccg_t.xccg302c
DEFINE l_xccg302d  LIKE xccg_t.xccg302d
DEFINE l_xccg302e  LIKE xccg_t.xccg302e
DEFINE l_xccg302f  LIKE xccg_t.xccg302f
DEFINE l_xccg302g  LIKE xccg_t.xccg302g
DEFINE l_xccg302h  LIKE xccg_t.xccg302h
DEFINE l_xcci302a  LIKE xcci_t.xcci302a
DEFINE l_xcci302b  LIKE xcci_t.xcci302b
DEFINE l_xcci302c  LIKE xcci_t.xcci302c
DEFINE l_xcci302d  LIKE xcci_t.xcci302d
DEFINE l_xcci302e  LIKE xcci_t.xcci302e
DEFINE l_xcci302f  LIKE xcci_t.xcci302f
DEFINE l_xcci302g  LIKE xcci_t.xcci302g
DEFINE l_xcci302h  LIKE xcci_t.xcci302h
DEFINE l_xcci304a  LIKE xcci_t.xcci304a
DEFINE l_xcci304b  LIKE xcci_t.xcci304b
DEFINE l_xcci304c  LIKE xcci_t.xcci304c
DEFINE l_xcci304d  LIKE xcci_t.xcci304d
DEFINE l_xcci304e  LIKE xcci_t.xcci304e
DEFINE l_xcci304f  LIKE xcci_t.xcci304f
DEFINE l_xcci304g  LIKE xcci_t.xcci304g
DEFINE l_xcci304h  LIKE xcci_t.xcci304h
DEFINE l_xcci302   LIKE xcci_t.xcci302
DEFINE l_xcci202   LIKE xcci_t.xcci202
DEFINE l_xcca102   LIKE xcca_t.xcca102  #期初库存成本开账
DEFINE l_amt1,l_amt2      LIKE xccc_t.xccc102
DEFINE l_qty1,l_qty2      LIKE xccc_t.xccc101
DEFINE l_str1,l_str2,l_str3,l_str      STRING
DEFINE l_xcbz009    LIKE xcbz_t.xcbz009
DEFINE l_xcbz901    LIKE xcbz_t.xcbz901
DEFINE l_xccc006_7        STRING          #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_t      STRING          #料号+特性码 150216 add 判断是不是已经计算过了
DEFINE l_xccc006_7_f LIKE type_t.chr1     #是否第一次执行这个料件+特性 150216 add
DEFINE l_sql STRING
DEFINE l_err LIKE type_t.chr1000
DEFINE l_xcbz003 LIKE xcbz_t.xcbz003
DEFINE l_xcbz004 LIKE xcbz_t.xcbz004
       
   #计算起止日期
   SELECT glaa003 INTO l_glaa003  #會計週期參照表號
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaa014 = 'Y'           #主帐套
      AND glaacomp = tm.xccccomp
   CALL s_fin_date_get_period_range(l_glaa003,tm.xccc004,tm.xccc005)
       RETURNING g_bdate,g_edate
   #取上期的年度/期别
   CALL s_fin_date_get_last_period(l_glaa003,tm.xcccld,tm.xccc004,tm.xccc005)
        RETURNING l_success,g_yy,g_mm
   IF NOT l_success THEN
      RETURN
   END IF
   
   #根据成本计算类型抓取计价方式 主要用于判断g_xcat005='3'否
   SELECT xcat005 INTO g_xcat005 FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = tm.xccc003 #成本计算类型


   #初始化
   CALL g_xccc_d.clear()  
   LET l_ac = 0
   
   
   LET g_sys_6001 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6001')   #[S-FIN-6001]:採用成本域否
   LET g_sys_6002 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6002')   #[S-FIN-6002]:成本域類型
   IF g_sys_6001 = 'N' THEN
      LET g_sys_6002 = ''
   END IF
   
   LET g_sys_6004 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6004')  #[S-FIN-6004]:雜項發料的取價方式
   LET g_sys_6016 = cl_get_para(g_enterprise,tm.xccccomp,'S-FIN-6016')  #[S-FIN-6016]:當站下線是否影響成本
   

   #缩小xcck范围，提高效能
   BEGIN WORK #效能考虑添加
   CALL axcq301_delete_temp()
   #xcck 将下面判断中需要用到的资料插入到临时表中
   IF g_sys_6016 = 'N' THEN
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('115','302','303','501','107','114')  #異動類型:当站下线,生产发料,生产退料,盘点,委外回收入库,回收入库
   ELSE
      INSERT INTO axcq301_xcck
         SELECT * FROM xcck_t
          WHERE xcckent  = g_enterprise
            AND xcckcomp = tm.xccccomp #法人组织
            AND xcckld   = tm.xcccld   #帐别
            AND xcck003  = tm.xccc003  #成本计算类型
            AND xcck004  = tm.xccc004  #年度
            AND xcck005  = tm.xccc005  #期别
            AND xcck047 IS NOT NULL    #工單號碼
            AND xcck020 IN ('302','303','501','107','114')  #異動類型：生产发料,生产退料,盘点,委外回收入库,回收入库
   END IF
   
   INSERT INTO axcq301_xcbz
      SELECT * FROM xcbz_t
       WHERE xcbzent  = g_enterprise
         AND xcbzcomp = tm.xccccomp #法人组织
         AND xcbzld   = tm.xcccld   #帐别
         AND xcbz001  = tm.xccc004  #年度
         AND xcbz002  = tm.xccc005  #期别
         AND EXISTS (SELECT 1 from inaa_t   #成本库否
                      WHERE inaaent = xcbzent
                        AND inaasite = xcbzsite
                        AND inaa001 = xcbz006
                        AND inaa010 = 'Y')
                        
   #xcce  将下面判断中需要用到的资料插入到临时表中
   INSERT INTO axcq301_xcce
      SELECT * FROM xcce_t
       WHERE xcceent  = g_enterprise
         AND xccecomp = tm.xccccomp #法人组织
         AND xcceld   = tm.xcccld   #帐别
         AND xcce003  = tm.xccc003  #成本计算类型
         AND xcce004  = tm.xccc004  #年度
         AND xcce005  = tm.xccc005  #期别
   
  #160520-00004#1-s-add
   CREATE INDEX xccd_i01 ON xccd_t(xccdent,xccd006)  
   EXECUTE IMMEDIATE "analyze table xccd_t estimate statistics"
  
  INSERT INTO axcq301_sfaa
     SELECT sfaa_t.* FROM xccd_t,sfaa_t  
      WHERE xccdent = sfaaent AND xccd006 = sfaadocno
        AND xccdent  = g_enterprise
        AND xccdcomp = tm.xccccomp    #法人组织
        AND xccdld   = tm.xcccld      #帐别
        AND xccd003  = tm.xccc003     #成本计算类型
        AND xccd004  = tm.xccc004     #年度
        AND xccd005  = tm.xccc005     #期别  
  #160520-00004#1-e-add
  
  #161124-00008#1 ---add (s)---
   INSERT INTO axcq301_sfaa
   SELECT sfaa_t.* FROM xcch_t,sfaa_t
    WHERE xcchent = sfaaent AND xcch006 = sfaadocno
      AND xcchent  = g_enterprise
      AND xcchcomp = tm.xccccomp    #法人组织
      AND xcchld   = tm.xcccld      #帐别
      AND xcch003  = tm.xccc003     #成本计算类型
      AND xcch004  = tm.xccc004     #年度
      AND xcch005  = tm.xccc005     #期别
  #161124-00008#1 ---add (e)---
   
   COMMIT WORK #效能考虑
      
   IF tm.c1 = 'Y' THEN   #基礎資料異常檢核            #160523-00041#2
      #(axc-00401)(axc-00402)(axc-00403)(axc-00404 )(axc-00453)(axc-00454)
      #工單不存在工單維護作業中(axc-00401)
      LET g_sql = " SELECT UNIQUE xccd006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
                  "   FROM xccd_t ",                                                       
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ",
                  "    AND xccdld  ='",tm.xcccld,"' ",  
                  "    AND xccd003 ='",tm.xccc003,"'",  
                  "    AND xccd004 = ",tm.xccc004," AND xccd005 = ",tm.xccc005, 
                  "    AND NOT EXISTS ( SELECT 1 FROM axcq301_sfaa WHERE sfaaent = xccdent and sfaadocno=xccd006) ",
                  " UNION ",
                  " SELECT UNIQUE xcce006,",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
                  "   FROM xcce_t ",                                           
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ", 
                  "    AND xcceld  ='",tm.xcccld,"' ",  
                  "    AND xcce003 ='",tm.xccc003,"'",  
                  "    AND xcce004 = ",tm.xccc004," AND xcce005 = ",tm.xccc005, 
                  "    AND NOT EXISTS ( SELECT 1 FROM axcq301_sfaa WHERE sfaaent = xcceent and sfaadocno=xcce006) ",
                  " UNION ",
                  " SELECT UNIQUE xcch006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
                  "   FROM xcch_t ",                       
                  "  WHERE xcchent = ",g_enterprise,
                  "    AND xcchcomp='",tm.xccccomp,"' ",
                  "    AND xcchld  ='",tm.xcccld,"' ", 
                  "    AND xcch003 ='",tm.xccc003,"'", 
                  "    AND xcch004 = ",tm.xccc004," AND xcch005 = ",tm.xccc005, 
                  "    AND NOT EXISTS ( SELECT 1 FROM axcq301_sfaa WHERE sfaaent = xcchent and sfaadocno=xcch006) ",
                  " UNION ",
                  " SELECT UNIQUE xcci006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00401' AND gzze002='",g_lang,"') info",
                  "   FROM xcci_t ",                        
                  "  WHERE xccient = ",g_enterprise,
                  "    AND xccicomp='",tm.xccccomp,"' ", 
                  "    AND xccild  ='",tm.xcccld,"' ",   
                  "    AND xcci003 ='",tm.xccc003,"'",   
                  "    AND xcci004 = ",tm.xccc004," AND xcci005 = ",tm.xccc005, 
                  "    AND NOT EXISTS ( SELECT 1 FROM axcq301_sfaa WHERE sfaaent = xccient and sfaadocno=xcci006) "
      LET g_sql = cl_sql_add_mask(g_sql)              
      PREPARE axcq301_401_p FROM g_sql
      DECLARE axcq301_401_c CURSOR FOR axcq301_401_p
      FOREACH axcq301_401_c INTO l_sfdc001,l_err                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:axcq301_sfdc_c"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_ac = l_ac + 1
         LET g_xccc_d[l_ac].xccc006      = ''  #料号
         LET g_xccc_d[l_ac].xccc007      = ''  #特征
         LET g_xccc_d[l_ac].xccc006_desc = ''  #品名
         LET g_xccc_d[l_ac].docno        = l_sfdc001     #单据编号
         LET g_xccc_d[l_ac].info         = l_err
      END FOREACH
      CLOSE axcq301_401_c
      FREE axcq301_401_p 

      #检查采购单价是否为0(axc-00402)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "       (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00402' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ", #法人组织
                  "   AND xcccld   ='",tm.xcccld,"' ",   #帐别
                  "   AND xccc003  ='",tm.xccc003,"' ",  #成本计算类型
                  "   AND xccc004  = ",tm.xccc004,       #年度
                  "   AND xccc005  = ",tm.xccc005,       #期别
                  "   AND xccc201 != 0 ",
                  "   AND xccc202 = 0 "
      PREPARE axcq301_00402_p FROM g_sql    
      DECLARE axcq301_00402_c CURSOR FOR axcq301_00402_p
      FOREACH axcq301_00402_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00402_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #单据编号
          LET g_xccc_d[l_ac].info         = l_err  
      END FOREACH     
      
      #無單位成本資料請輸入調整資料(axc-00403)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "       (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00403' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ", #法人组织
                  "   AND xcccld   ='",tm.xcccld,"' ",   #帐别
                  "   AND xccc003  ='",tm.xccc003,"' ",  #成本计算类型
                  "   AND xccc004  = ",tm.xccc004,       #年度
                  "   AND xccc005  = ",tm.xccc005,       #期别
                  "   AND xccc280 = 0 ",
                  "   AND (xccc101 != 0 OR xccc201 != 0 OR xccc203 != 0 OR ",
                  "        xccc205 != 0 OR xccc207 != 0 OR xccc209 != 0 OR ", #本期工單入庫 本期重工領出 本期重工入庫
                  "        xccc211 != 0 OR xccc213 != 0 OR xccc215 != 0 OR ", #本期雜項入庫 本期調整入庫 本期銷退入庫
                  "        xccc217 != 0 OR xccc301 != 0 OR xccc303 != 0 OR ", #本期調撥入庫 本期工單領用 本期銷貨數量
                  "        xccc305 != 0 OR xccc307 != 0 OR xccc309 != 0 OR ", #本期銷退數量 本期銷售費用 本期雜發數量
                  "        xccc311 != 0 OR xccc313 != 0 OR xccc901 != 0 )  "  #本期盤盈虧   本期調撥出庫 期末結存數量     
      PREPARE axcq301_00403_p FROM g_sql    
      DECLARE axcq301_00403_c CURSOR FOR axcq301_00403_p
      FOREACH axcq301_00403_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00403_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #单据编号
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH  

      #料件編號無產品分類(axc-00404 )
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00404' AND gzze002='",g_lang,"') info",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent ='"||g_enterprise||"' AND imaal001 = xccc006 AND imaal002='"||g_dlang||"' ",
                  "              LEFT JOIN imaa_t ON imaaent ='"||g_enterprise||"' AND imaa001 = xccc006 ",  
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp = '",tm.xccccomp,"' ", #法人组织
                  "   AND xcccld   = '",tm.xcccld,"' ",   #帐别
                  "   AND xccc003  = '",tm.xccc003,"' ",  #成本计算类型
                  "   AND xccc004  = ",tm.xccc004,        #年度
                  "   AND xccc005  = ",tm.xccc005,        #期别
                  "   AND imaa009 IS NULL "               #產品分類
      
      PREPARE axcq301_00404_p FROM g_sql    
      DECLARE axcq301_00404_c CURSOR FOR axcq301_00404_p
      FOREACH axcq301_00404_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00403_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #单据编号
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH      

      #料號未設定成本分群(axc-00453)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,info ",
                  "  FROM ( ",
                  "SELECT xccc006,xccc007,imaal003,xcbb010, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00453' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent="||g_enterprise||" AND imaal001 = xccc006 AND imaal002='"||g_dlang||"' ",
                  #170106-00047#1-s mod   出現「在制转出金额-1172.740000与存货工单入库金额0.000000不符，请检查工单成本域是否正确！」，因xccc_t串xccd_t時，沒把key值串進去，導致xccd_t資料抓錯
#                 "              LEFT JOIN xcbb_t ON xcbbent = "||g_enterprise||" AND xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006 AND xcbb004 = xccc007 ",   #170106-00047#1 mark
                 #"              LEFT JOIN xcbb_t ON xcbbent = "||g_enterprise||" AND xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006 ",                         #161004-00007#1 mark
                  "              LEFT JOIN xcbb_t ON xcbbent = "||g_enterprise||" AND xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006 AND xcbbstus = 'Y' ",      #161004-00007#1 add
                  #170106-00047#1-e mod
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "        ) ",
                  " WHERE xcbb010 IS NULL "               
      
      PREPARE axcq301_00453_p FROM g_sql    
       
      DECLARE axcq301_00453_c CURSOR FOR axcq301_00453_p
      FOREACH axcq301_00453_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00453_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
      #成本階錯誤(axc-00454)
      DELETE FROM axcq301_xcbb_01
      INSERT INTO axcq301_xcbb_01 (xccd006,xccd007,xccd008,xcbb006)
        SELECT DISTINCT xccd006,xccd007,xccd008,xcbb006  FROM xccd_t, xcbb_t 
         WHERE xccdent = xcbbent AND xccdcomp = xcbbcomp 
           AND xccd004 = xcbb001 AND xccd005  = xcbb002              #年度 期别
           #170106-00047#1-s mod 相同料號，即使有不同產品特徵，其成本階都是一樣的
#           AND xccd007 = xcbb003 AND xccd008  = xcbb004              #料号 特性   #170106-00047#1 mark
           AND xccd007 = xcbb003                                      #料号 
           #170106-00047#1-e mod
           AND xccdent = g_enterprise
           AND xccdcomp = tm.xccccomp
           AND xccdld  = tm.xcccld
           AND xccd004 = tm.xccc004  AND xccd005 = tm.xccc005
           AND xccd003 =tm.xccc003                              #成本計算類型                 
      DELETE FROM axcq301_xcbb_02
      INSERT INTO axcq301_xcbb_02 (xcce006,xcbb006)
        SELECT DISTINCT xcce006,xcbb006 FROM axcq301_xcce,xcbb_t
         WHERE xcceent = xcbbent AND xccecomp = xcbbcomp
           AND xcce004 = xcbb001 AND xcce005  = xcbb002             #年度 期别
           #170106-00047#1-s mod 相同料號，即使有不同產品特徵，其成本階都是一樣的
#           AND xcce007 = xcbb003 AND xcce008  = xcbb004             #料号 特性   #170106-00047#1 mark
           AND xcce007 = xcbb003                                     #料号 
           #170106-00047#1-e mod
           AND xcceent = g_enterprise
           AND xccecomp = tm.xccccomp
           AND xcceld  = tm.xcccld
           AND xcce004 = tm.xccc004 AND xcce005 = tm.xccc005
           AND xcce003 = tm.xccc003  #成本計算類型     
      
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccd006, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00454' AND gzze002='",g_lang,"') info",  
                  "  FROM ( ",
                  "SELECT UNIQUE xccd006,xccd007,xccd008 ",
                  "  FROM (SELECT * FROM axcq301_xcbb_01) aa,",
                  "       (SELECT * FROM axcq301_xcbb_02) bb, ",
                  "       axcq301_sfaa ",
                  " WHERE aa.xccd006=bb.xcce006 AND aa.xcbb006>bb.xcbb006 ", #同工单 主件成本阶>元件成本阶
                  "   AND sfaadocno = aa.xccd006 ",
                  "   AND sfaaent   = ",g_enterprise,
                  "   AND (sfaa042 IS NULL OR sfaa042 = ' ' OR sfaa042 = 'N')", #非重工工单
                  "       ),xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE  xccc006 = xccd007 AND xccc007 = xccd008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005            #期別     
      
      PREPARE axcq301_00454_p FROM g_sql    
       
      DECLARE axcq301_00454_c CURSOR FOR axcq301_00454_p
      FOREACH axcq301_00454_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd_xcce.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00454_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006         #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007         #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003             #品名
          LET g_xccc_d[l_ac].docno        = l_xccd_xcce.xccd006    #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
    END IF                             #160523-00041#2 add              
    IF tm.c2 = 'Y' THEN                #160523-00041#2 add 
      #計算後的結存量及金額異常檢核
      #(axc-00407)(axc-00408)(axc-00409)(axc-00410)(axc-00411)(axc-00412)(axc-00413)(axc-00414)
      #(axc-00415)(axc-00416)(axc-00417)(axc-00418)(axc-00419)(axc-00420)(axc-00421)(axc-00422)
      #(axc-00423)(axc-00424)(axc-00425) (axc-00426)(axc-00427)
      
      #本月銷貨有數量，但無金額請做調整(axc-00407)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00407' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",                           #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",                             #??
                  "   AND xccc003  ='",tm.xccc003,"' ",                            #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,                                 #年度
                  "   AND xccc005  = ",tm.xccc005,                                 #期?
                  "   AND ((xccc303 != 0 AND xccc304 = 0 AND xccc280 != 0) OR ",   #???量 ??成本 成本?价
                  "        (xccc307 != 0 AND xccc308 = 0 AND xccc280 != 0) ) "     #?售?量 ?售成本 成本?价
   
      PREPARE axcq301_00407_p FROM g_sql    
       
      DECLARE axcq301_00407_c CURSOR FOR axcq301_00407_p
      FOREACH axcq301_00407_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00407_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料件
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特微
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH       
     
      #本月銷貨有金額，但無數量請做調整(axc-00408)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00408' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",          #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",            #??
                  "   AND xccc003  ='",tm.xccc003,"' ",           #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,                #年度
                  "   AND xccc005  = ",tm.xccc005,                #期?
                  "   AND ((xccc303 = 0 AND xccc304 != 0) OR ",   #???量 ??成本
                  "        (xccc307 = 0 AND xccc308 != 0) ) "     #???量 ??成本
   
      PREPARE axcq301_00408_p FROM g_sql    
       
      DECLARE axcq301_00408_c CURSOR FOR axcq301_00408_p
      FOREACH axcq301_00408_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00403_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH      
      
      #本月發料單有數量但無金額請做調整(axc-00409) 
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00409' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",                      #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",                        #??
                  "   AND xccc003  ='",tm.xccc003,"' ",                       #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,                            #年度
                  "   AND xccc005  = ",tm.xccc005,                            #期?
                  "   AND xccc301 != 0 AND xccc302 = 0 AND xccc280 != 0 "     #工??用?量 工??用金? 成本?价
   
      PREPARE axcq301_00409_p FROM g_sql    
       
      DECLARE axcq301_00409_c CURSOR FOR axcq301_00409_p
      FOREACH axcq301_00409_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00409_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH   
      
      #本月發料單有金額但無數量請做調整(axc-00410)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00410' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc301 = 0 AND xccc302 != 0 "     
   
      PREPARE axcq301_00410_p FROM g_sql    
       
      DECLARE axcq301_00410_c CURSOR FOR axcq301_00410_p
      FOREACH axcq301_00410_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00403_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH      
      
      #本月重工領出有數量但無金額請做調整(axc-00411)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00411' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                 #"   AND (xccc207 > 0 OR xccc207 < 0 ) AND (xccc208a = 0 OR xccc208 = 0) "      #160523-00041#2 mark
                  "   AND (xccc207 <> 0 AND xccc208 = 0) "                                       #160523-00041#2 add
   
      PREPARE axcq301_00411_p FROM g_sql    
       
      DECLARE axcq301_00411_c CURSOR FOR axcq301_00411_p
      FOREACH axcq301_00411_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00411_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
      #本月雜項領用有?量但無金額請做調整(axc-00412)
      CASE g_sys_6004
        WHEN '1'  #系??定
   
          LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                      "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00412' AND gzze002='",g_lang,"') info",   
                      "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                      " WHERE xcccent  = ",g_enterprise,
                      "   AND xccccomp ='",tm.xccccomp,"' ",                      #法人??
                      "   AND xcccld   ='",tm.xcccld,"' ",                        #??
                      "   AND xccc003  ='",tm.xccc003,"' ",                       #成本?算?型
                      "   AND xccc004  = ",tm.xccc004,                            #年度
                      "   AND xccc005  = ",tm.xccc005,                            #期?
                      "   AND xccc211 != 0 AND xccc212 = 0 AND xccc280 != 0 "     
             
          PREPARE axcq301_00412_p FROM g_sql    
              
          DECLARE axcq301_00412_c CURSOR FOR axcq301_00412_p
          FOREACH axcq301_00412_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.extend = "PREPARE axcq301_00412_p"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 RETURN 
              END IF 
              LET l_ac = l_ac + 1
              LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
              LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
              LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
              LET g_xccc_d[l_ac].docno        = ''             #?据??
              LET g_xccc_d[l_ac].info         = l_err    
          END FOREACH   
        WHEN '2'  #人工設定
          LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                      "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00412' AND gzze002='",g_lang,"') info",   
                      "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                      " WHERE xcccent  = ",g_enterprise,
                      "   AND xccccomp ='",tm.xccccomp,"' ",                      #法人??
                      "   AND xcccld   ='",tm.xcccld,"' ",                        #??
                      "   AND xccc003  ='",tm.xccc003,"' ",                       #成本?算?型
                      "   AND xccc004  = ",tm.xccc004,                            #年度
                      "   AND xccc005  = ",tm.xccc005,                            #期?
                      "   AND xccc211 != 0 AND xccc212 = 0 "     
              
          PREPARE axcq301_00412_p2 FROM g_sql    
             
          DECLARE axcq301_00412_c2 CURSOR FOR axcq301_00412_p2
          FOREACH axcq301_00412_c2 INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.extend = "PREPARE axcq301_00412_p2"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 RETURN 
              END IF 
              LET l_ac = l_ac + 1
              LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
              LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
              LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
              LET g_xccc_d[l_ac].docno        = ''             #?据??
              LET g_xccc_d[l_ac].info         = l_err    
          END FOREACH          
      END CASE   
     #本月雜項領用有金額但無?量請做調整(axc-00413)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00413' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc211 = 0 AND xccc212 != 0 "     
   
      PREPARE axcq301_00413_p FROM g_sql    
       
      DECLARE axcq301_00413_c CURSOR FOR axcq301_00413_p
      FOREACH axcq301_00413_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00413_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
       
     #本月結存數量为零但結存金額有值(axc-00414)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00414' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc901 = 0 AND xccc902 != 0 "     
   
      PREPARE axcq301_00414_p FROM g_sql    
       
      DECLARE axcq301_00414_c CURSOR FOR axcq301_00414_p
      FOREACH axcq301_00414_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00414_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH   
      
     #本月結存數量為負(axc-00415)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00415' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc901 < 0 "     
   
      PREPARE axcq301_00415_p FROM g_sql    
       
      DECLARE axcq301_00415_c CURSOR FOR axcq301_00415_p
      FOREACH axcq301_00415_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00415_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH
     
     #本月結存合計金額為負(axc-00416)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00416' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc902 < 0 "     
   
      PREPARE axcq301_00416_p FROM g_sql    
       
      DECLARE axcq301_00416_c CURSOR FOR axcq301_00416_p
      FOREACH axcq301_00416_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00416_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
     #本月結存材料金額為負(axc-00417) 
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00417' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc902a < 0 "     
   
      PREPARE axcq301_00417_p FROM g_sql    
       
      DECLARE axcq301_00417_c CURSOR FOR axcq301_00417_p
      FOREACH axcq301_00417_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00417_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
      
     #本月結存人工成本為負(axc-00418)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00418' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人??
                  "   AND xcccld   ='",tm.xcccld,"' ",       #??
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本?算?型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期?
                  "   AND xccc902b < 0 "     
   
      PREPARE axcq301_00418_p FROM g_sql    
       
      DECLARE axcq301_00418_c CURSOR FOR axcq301_00418_p
      FOREACH axcq301_00418_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00418_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料?
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #?据??
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
     #本月結存製費成本為負(axc-00419)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00419' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND (xccc902d < 0 OR xccc902e < 0 OR xccc902f < 0 OR xccc902g < 0 OR xccc902h < 0) "     
   
      PREPARE axcq301_00419_p FROM g_sql    
       
      DECLARE axcq301_00419_c CURSOR FOR axcq301_00419_p
      FOREACH axcq301_00419_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00419_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     
     #本月結存加工成本為負(axc-00420)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00420' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc902c < 0 "     
   
      PREPARE axcq301_00420_p FROM g_sql    
       
      DECLARE axcq301_00420_c CURSOR FOR axcq301_00420_p
      FOREACH axcq301_00420_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00420_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH
     
     #本期期初金额”%1不等于 “上期期末金额”%2 (axc-00421)
      DELETE FROM axcq301_xccb
      LET g_sql = " INSERT INTO axcq301_xccb (xccbent,xccbld,xccb001,xccb002,xccb003,xccb007,xccb008,xccb009,xccb102) ",
                  "     SELECT a.xcccent,a.xcccld,a.xccc001,a.xccc002,a.xccc003,a.xccc006,a.xccc007,a.xccc008,nvl(b.xccc902,0) ",
                  "       FROM xccc_t a LEFT JOIN xccc_t b ON a.xcccent = b.xcccent AND a.xccccomp = b.xccccomp AND a.xcccld = b.xcccld AND ",
                  "                                           a.xccc001 = b.xccc001 AND a.xccc002 = b.xccc002 AND a.xccc003 = b.xccc003 AND ",
                  "                                           a.xccc006 = b.xccc006 AND a.xccc007 = b.xccc007 AND a.xccc008 = b.xccc008 AND ",
                  "                                           b.xccc004 = ",g_yy," AND b.xccc005 = ", g_mm,
                  "      WHERE a.xcccent  = ",g_enterprise,
                  "        AND a.xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "        AND a.xcccld   ='",tm.xcccld,"' ",       #帳別
                  "        AND a.xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "        AND a.xccc004  = ",tm.xccc004,           #年度
                  "        AND a.xccc005  = ",tm.xccc005            #期別                    
      PREPARE axcq301_xccc_ins_p FROM g_sql    
       
      EXECUTE axcq301_xccc_ins_p 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xccc_ins_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      LET g_sql = " MERGE INTO axcq301_xccb a ",
                  "      USING (SELECT xccaent,xccald,xcca001,xcca002,xcca003,xcca006,xcca007,xcca008, ",
                  "                    SUM(xcca102a+xcca102b+xcca102c+xcca102d+xcca102e+xcca102f+xcca102g+xcca102h) xcca102 ",
                  "               FROM xcca_t WHERE xcca004 = ",g_yy," AND xcca005 = ",g_mm,
                  "              GROUP BY xccaent,xccald,xcca001,xcca002,xcca003,xcca006,xcca007,xcca008 ) b ",
                  "         ON (a.xccbent = b.xccaent AND a.xccbld = b.xccald   AND a.xccb001 = b.xcca001 AND a.xccb002 = b.xcca002 AND ",
                  "             a.xccb003 = b.xcca003 AND a.xccb007 = b.xcca006 AND a.xccb008 = b.xcca007 AND a.xccb009 = b.xcca008 AND ",
                  "             b.xcca102 IS NOT NULL ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xccb102 = b.xcca102 "
      PREPARE axcq301_xcca_upd_p FROM g_sql 
      EXECUTE axcq301_xcca_upd_p 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xcca_upd_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF    
   
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc102,xccb102 ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,axcq301_xccb ",
                  " WHERE xcccent = xccbent AND xcccld = xccbld AND xccc001 = xccb001 AND xccc002 = xccb002 ",
                  "   AND xccc003 = xccb003 AND xccc006 = xccb007 AND xccc007 = xccb008 AND xccc008 = xccb009 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc102 <> xccb102 "  
   
      PREPARE axcq301_00421_p FROM g_sql    
       
      DECLARE axcq301_00421_c CURSOR FOR axcq301_00421_p
      FOREACH axcq301_00421_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc102,l_xccc902
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00421_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccc.xccc102
          LET l_str2 = l_xccc902
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00421',g_lang,l_str) RETURNING l_err 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''      #單據
          LET g_xccc_d[l_ac].info         = l_err  #錯誤信息
      END FOREACH 
     
      #本月结存数量%1与MFG之期末数量不合%2(axc-00422)
      LET l_sql = "SELECT COALESCE(SUM(xcbz901),0) FROM axcq301_xcbz,xccc_t b ",
                  " WHERE a.xcccent = xcbzent AND a.xccccomp = xcbzcomp AND a.xcccld = xcbzld ",
                  "   AND a.xccc004 = xcbz001 AND a.xccc005 = xcbz002 AND a.xccc006 = xcbz003 ",
                  "   AND a.xcccent = b.xcccent AND a.xcccld = b.xcccld AND a.xccc001 = b.xccc001 ",
                  "   AND a.xccc002 = b.xccc002  AND a.xccc003 = b.xccc003 AND a.xccc004 = b.xccc004 ",
                  "   AND a.xccc005 = b.xccc005 AND a.xccc006 = b.xccc006 AND a.xccc007 = b.xccc007 AND a.xccc008 = b.xccc008"
      IF g_para_data1 = 'Y' THEN   #采用特性
         LET l_sql = l_sql CLIPPED," AND a.xccc007 = xcbz004 " #特性
      END IF
      IF g_xcat005 = '3' THEN      #批次成本 
         LET l_sql = l_sql CLIPPED," AND a.xccc008 = xcbz008 " #批號
      END IF  
      CASE g_sys_6002
         WHEN '1'  #組織型
           LET l_sql = l_sql CLIPPED,
              " AND xcbzsite IN (",                                    #組織據點
              "                  SELECT xcbf002 FROM xcbf_t ",
              "                   WHERE xcbfent = b.xcccent ",
              "                     AND xcbfcomp = b.xccccomp ",
              "                     AND xcbf001  = b.xccc002 ",          #成本域
              "                  ) "
         WHEN '2'  #倉庫型
           LET l_sql = l_sql CLIPPED,
               " AND xcbz006 IN (",                                         #組織據點
               "                  SELECT xcbf002 FROM xcbf_t ",
               "                   WHERE xcbfent = b.xcccent ",
               "                     AND xcbfcomp = b.xccccomp ",
               "                     AND xcbf001  = b.xccc002 ",                    #成本域
               "                  ) "
         WHEN '3'  #庫存管理特征
           LET l_sql = l_sql CLIPPED," AND xcbz005 = b.xccc002 "                #庫存管理特徵
      END CASE         
      LET l_sql = l_sql CLIPPED," AND EXISTS (SELECT 1 FROM inaa_t ",      #成本?否
                  " WHERE inaaent = xcbzent AND inaasite= xcbzsite ",
                  "   AND inaa001 = xcbz006 AND inaa010 = 'Y') "      
            
      
      LET g_sql = "SELECT xccc006,xccc007,imaal003,xccc901,xcbz901 ",
                  "  FROM ( ",
                  "  SELECT UNIQUE a.xccc006,a.xccc007,imaal003,a.xccc901, ",
                  "(",l_sql,") xcbz901 ",
                  "  FROM xccc_t a LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=a.xccc006 AND imaal002='"||g_dlang||"' ",  
                  " WHERE a.xcccent  = ",g_enterprise,
                  "   AND a.xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND a.xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND a.xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND a.xccc004  = ",tm.xccc004,           #年度
                  "   AND a.xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  "  WHERE xccc901 <> xcbz901 "  
      PREPARE axcq301_00422_p FROM g_sql  
       
      DECLARE axcq301_00422_c CURSOR FOR axcq301_00422_p
      FOREACH axcq301_00422_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc901,l_inat015
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00422_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccc.xccc901
          LET l_str2 = l_inat015
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00422',g_lang,l_str) RETURNING l_err 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err   
      END FOREACH      
     #本月平均單價為零(axc-00423)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00423' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc901 != 0 AND (xccc280 = 0 AND (xccc205 !=0 OR xccc209!=0))  "     
   
      PREPARE axcq301_00423_p FROM g_sql    
       
      DECLARE axcq301_00423_c CURSOR FOR axcq301_00423_p
      FOREACH axcq301_00423_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00423_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
     #本月材料平均單價為負(axc-00424)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00424' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc280a < 0 "     
   
      PREPARE axcq301_00424_p FROM g_sql    
       
      DECLARE axcq301_00424_c CURSOR FOR axcq301_00424_p
      FOREACH axcq301_00424_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00424_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
    #本月人工平均單價為負(axc-00425) 
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00425' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc280b < 0 "     
   
      PREPARE axcq301_00425_p FROM g_sql    
       
      DECLARE axcq301_00425_c CURSOR FOR axcq301_00425_p
      FOREACH axcq301_00425_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00425_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH  
   
      #本月製費平均單價為負(axc-00426)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00426' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND (xccc280d < 0 OR xccc280e < 0 OR xccc280f < 0 OR xccc280g < 0 OR xccc280h < 0) "     
   
      PREPARE axcq301_00426_p FROM g_sql    
       
      DECLARE axcq301_00426_c CURSOR FOR axcq301_00426_p
      FOREACH axcq301_00426_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00426_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #單據編號
          LET g_xccc_d[l_ac].info         = l_err    
      END FOREACH 
      #本月加工平均單價為負(axc-00427)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003, ",
                  "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00427' AND gzze002='",g_lang,"') info",   
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "   AND xccc280c < 0 "     
   
      PREPARE axcq301_00427_p FROM g_sql    
        
       DECLARE axcq301_00427_c CURSOR FOR axcq301_00427_p
       FOREACH axcq301_00427_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00427_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
           LET g_xccc_d[l_ac].docno        = ''             #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH            
     END IF                      #160523-00041#2 add 
       
     IF tm.c3 = 'Y'  THEN        #160523-00041#2 add
       #在制工单的異常检核
       #在制工单的检查(axc-00428)(axc-00429)(axc-00430)(axc-00431)(axc-00432)(axc-00433)(axc-00434)(axc-00435)
       #             (axc-00436)(axc-00437)(axc-00438)(axc-00439)
       #检查主件(axc-00440)(axc-00441)(axc-00442)(axc-00443)(axc-00444)(axc-00405)(axc-00406)
       #在制工单元件检查-检查元件(axc-00455)(axc-00456)(axc-00457)(axc-00458)(axc-00459)(axc-00460)(axc-00461)
       #                       (axc-00462)(axc-00463)(axc-00464) 
       #==在制工单的检查==
       #本月有工時，但無工單DL+OH+SUB資料或工單已結案(axc-00428)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,  ",
                   "      (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00428' AND gzze002='",g_lang,"') info",  
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd006 IN (  ",
                   "        SELECT UNIQUE xcbi002 ",
                   "          FROM xcbi_t,xcbh_t ",
                   "         WHERE xcbient = xcbhent AND xcbidocno = xcbhdocno ",
                   "           AND xccdent = xcbhent ", #170331-00037#1 add                   
                   "           AND xcbh001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                   "           AND ( (xcbi201 IS NOT NULL AND xcbi201 <> 0) OR ",
                   "                 (xcbi202 IS NOT NULL AND xcbi202 <> 0) OR ",
                   "                 (xcbi203 IS NOT NULL AND xcbi203 <> 0) OR ",
                   "                 (xcbi204 IS NOT NULL AND xcbi204 <> 0) ) ",
                   "                    ) ",  
                   "    AND (   (xccd102+xccd202+xccd204 = 0 )  ",
                   "         OR (NOT EXISTS (SELECT 1 FROM xcce_t ",
                   "                        WHERE xcceent = xccdent AND xccecomp = xccdcomp ",
                   "                          AND xcceld = xccdld AND xcce003= xccd003 AND xcce004 = xccd004 ",
                   "                          AND xcce005 = xccd005 AND xcce006 = xccd006 AND xcce007 = 'DL+OH+SUB')) ",
                   "         OR (EXISTS (SELECT 1 FROM sfaa_t ",
                   "                    WHERE sfaaent = xccdent AND sfaadocno = xccd006 ",
                  #"                      AND (sfaa048 IS NOT NULL AND sfaa048 > '",g_bdate,"') )) ",  #160701-00011#1 mark
                   "                      AND (sfaa048 IS NOT NULL AND sfaa048 < '",g_bdate,"') )) ",  #160701-00011#1 add                   
                   "         )"               
       PREPARE axcq301_00428_p FROM g_sql    
        
       DECLARE axcq301_00428_c CURSOR FOR axcq301_00428_p
       FOREACH axcq301_00428_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd_xcce.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00428_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006         #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007         #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003             #品名
           LET g_xccc_d[l_ac].docno        = l_xccd_xcce.xccd006    #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH
      
      
       #本月轉出%1 > 上月結存 + 本月投入%2(axc-00429)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        nvl(xccd301,0),(nvl(xccd101,0) + nvl(xccd201,0)) ",      
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND nvl(xccd301,0) > (nvl(xccd101,0) + nvl(xccd201,0)) "
                   
       PREPARE axcq301_00429_p FROM g_sql    
        
       DECLARE axcq301_00429_c CURSOR FOR axcq301_00429_p
       FOREACH axcq301_00429_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd301,l_xccd.xccd101
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00429_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET l_str1 = l_xccd.xccd301
           LET l_str2 = l_xccd.xccd101
           LET l_str = l_str1.trim(),'|',l_str2.trim()   
           CALL cl_getmsg_parm('axc-00429',g_lang,l_str) RETURNING l_err       
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號      
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH      
       #在製成本(主件)期末數量為零，金額不為零(axc-00430)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00430' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd901 = 0 AND xccd902 != 0 "
                   
       PREPARE axcq301_00430_p FROM g_sql    
        
       DECLARE axcq301_00430_c CURSOR FOR axcq301_00430_p
       FOREACH axcq301_00430_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00430_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH            
      #在製成本(主件)期末金額為零，數量不為零(axc-00431)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00431' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd901 != 0 AND xccd902 = 0 "
                   #170321-00102#1 add start -----
                  ,"    AND EXISTS (SELECT 1 FROM xcce_t WHERE xccdent = xcceent AND xccdld  = xcceld  ",
                   "                                       AND xccd001 = xcce001 AND xccd002 = xcce002 ",
                   "                                       AND xccd003 = xcce003 AND xccd004 = xcce004 ",
                   "                                       AND xccd005 = xcce005 AND xccd006 = xcce006)"
                   #170321-00102#1 add end   -----                   
                   
       PREPARE axcq301_00431_p FROM g_sql    
        
       DECLARE axcq301_00431_c CURSOR FOR axcq301_00431_p
       FOREACH axcq301_00431_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00431_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH 

       #170321-00102#1 add start -----
       #在製成本(主件)期末金額為零，數量不為零(無在製成本元件資料)(axc-00829)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00829' AND gzze002='",g_lang,"') info",
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd901 != 0 AND xccd902 = 0 ",
                   "    AND NOT EXISTS (SELECT 1 FROM xcce_t WHERE xccdent = xcceent AND xccdld  = xcceld  ",
                   "                                       AND xccd001 = xcce001 AND xccd002 = xcce002 ",
                   "                                       AND xccd003 = xcce003 AND xccd004 = xcce004 ",
                   "                                       AND xccd005 = xcce005 AND xccd006 = xcce006)"

       PREPARE axcq301_00829_p FROM g_sql

       DECLARE axcq301_00829_c CURSOR FOR axcq301_00829_p
       FOREACH axcq301_00829_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00829_c"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN
           END IF
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err
       END FOREACH
       #170321-00102#1 add end   -----
       
      #在製成本(主件)期末金額為負(axc-00432)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00432' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd902 < 0 "
                   
       PREPARE axcq301_00432_p FROM g_sql    
        
       DECLARE axcq301_00432_c CURSOR FOR axcq301_00432_p
       FOREACH axcq301_00432_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00432_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH   
      #在製成本(主件)期末材料金額為負(axc-00433)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00433' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd902a < 0 "
                   
       PREPARE axcq301_00433_p FROM g_sql    
        
       DECLARE axcq301_00433_c CURSOR FOR axcq301_00433_p
       FOREACH axcq301_00433_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00433_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH   
      
      #在製成本(主件)期末人工金額為負(axc-00434)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00434' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd902b < 0 "
                   
       PREPARE axcq301_00434_p FROM g_sql    
        
       DECLARE axcq301_00434_c CURSOR FOR axcq301_00434_p
       FOREACH axcq301_00434_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00434_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH 
       #在製成本(主件)期末製費金額為負(axc-00435)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00435' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND (xccd902d < 0 OR xccd902e < 0 OR xccd902f < 0 OR xccd902g < 0 OR xccd902h < 0) "
                   
       PREPARE axcq301_00435_p FROM g_sql    
        
       DECLARE axcq301_00435_c CURSOR FOR axcq301_00435_p
       FOREACH axcq301_00435_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00435_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH 
      #在製成本(主件)期末加工金額為負(axc-00436)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00436' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd902c < 0 "
                   
       PREPARE axcq301_00436_p FROM g_sql    
        
       DECLARE axcq301_00436_c CURSOR FOR axcq301_00436_p
       FOREACH axcq301_00436_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00436_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH    
      #主件(期初+投入)量為0，但(期初+投入)金額不為0(axc-00437)
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00437' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND (nvl(xccd101,0)+nvl(xccd201,0)) = 0 ",
                   "    AND (nvl(xccd102,0) + nvl(xccd202,0) + nvl(xccd204,0)) <> 0 "
                   
       PREPARE axcq301_00437_p FROM g_sql    
        
       DECLARE axcq301_00437_c CURSOR FOR axcq301_00437_p
       FOREACH axcq301_00437_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00437_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH
      #在製轉出(主件)金額為負值(axc-00438)   
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00438' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                   "  WHERE xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd302 > 0 "
                   
       PREPARE axcq301_00438_p FROM g_sql    
        
       DECLARE axcq301_00438_c CURSOR FOR axcq301_00438_p
       FOREACH axcq301_00438_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00438_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err    
       END FOREACH    
      #在製主件期初不等於上月期末，差异为:(axc-00439)
       #抓取期未OR開帳資料
       DELETE FROM axcq301_xccb
       LET g_sql = " INSERT INTO axcq301_xccb (xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb102) ",
                   "     SELECT a.xccdent,a.xccdld,a.xccd001,a.xccd002,a.xccd003,a.xccd006,nvl(b.xccd902,0) ",
                   "       FROM xccd_t a LEFT JOIN xccd_t b ON a.xccdent = b.xccdent AND a.xccdcomp = b.xccdcomp AND ",
                   "                                           a.xccdld = b.xccdld AND a.xccd001 = b.xccd001 AND ",
                   "                                           a.xccd002 = b.xccd002 AND a.xccd003 = b.xccd003 AND ",
                   "                                           b.xccd004 = ",g_yy," AND b.xccd005 = ", g_mm ,
                   "      WHERE a.xccdent = ",g_enterprise,
                   "        AND a.xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "        AND a.xccdld  ='",tm.xcccld,"' ",   #帳別
                   "        AND a.xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "        AND a.xccd004 = ",tm.xccc004,       #年度
                   "        AND a.xccd005 = ",tm.xccc005,       #期別 
                   "        AND a.xccd006 = b.xccd006 "
                   
       PREPARE axcq301_xccd_ins_p FROM g_sql    
        
       EXECUTE axcq301_xccd_ins_p 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.extend = "PREPARE axcq301_xccd_ins_p"
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          RETURN 
       END IF  
       
       LET g_sql = " MERGE INTO axcq301_xccb a ",
                   "      USING (SELECT xccbent,xccbld,xccb001,xccb002,xccb003,xccb006, ",
                   "                    SUM(xccb102) xccb102 FROM xccb_t WHERE xccb004 = ",g_yy," AND xccb005 = ",g_mm,
                   "              GROUP BY xccbent,xccbld,xccb001,xccb002,xccb003,xccb006) b ",
                   "         ON (a.xccbent = b.xccbent AND a.xccbld = b.xccbld   AND a.xccb001 = b.xccb001 AND a.xccb002 = b.xccb002 AND ",
                   "             a.xccb003 = b.xccb003 AND a.xccb006 = b.xccb006 AND b.xccb102 IS NOT NULL ) ",
                   "  WHEN MATCHED THEN ",
                   "       UPDATE SET a.xccb102 = b.xccb102 "
       PREPARE axcq301_xccb_upd_p FROM g_sql 
       EXECUTE axcq301_xccb_upd_p 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.extend = "PREPARE axcq301_xccb_upd_p"
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          RETURN 
       END IF    
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd102,xccb102, ",                  #170218-00022#1 mark
       LET g_sql = " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add       
                   " SELECT xccd007,xccd008,imaal003,xccd006,xccd102,xccb102, ",
                   "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00439' AND gzze002='",g_lang,"') info",   
                   "   FROM xccd_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ", 
                   "        ,axcq301_xccb ",           
                   "  WHERE xccdent = xccbent AND xccdld = xccbld AND xccd001 = xccb001 AND xccd002 = xccb002 AND xccd003 = xccb003 AND xccd006 = xccb006 ",
                   "    AND xccdent = ",g_enterprise,
                   "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                   "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                   "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                   "    AND xccd004 = ",tm.xccc004,       #年度
                   "    AND xccd005 = ",tm.xccc005,       #期別
                   "    AND xccd102 <> xccb102 "
       #170218-00022#1-s-add 
       PREPARE axcq301_cost_ins_p1 FROM g_sql    
       
       DELETE FROM axcq301_cost       #清除tmptable
       
       EXECUTE axcq301_cost_ins_p1 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.extend = "PREPARE axcq301_cost_ins_p1"
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          RETURN 
       END IF  
       
       LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost"

      #170218-00022#1-e-add           
                   
       PREPARE axcq301_00439_p FROM g_sql    
        
       DECLARE axcq301_00439_c CURSOR FOR axcq301_00439_p
       FOREACH axcq301_00439_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd102,l_xccd902,l_err
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.extend = "PREPARE axcq301_00439_p"
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF 
           LET l_ac = l_ac + 1
           LET l_diff = l_xccd.xccd102 - l_xccd902
           IF l_diff < 0 THEN
              LET l_diff = l_diff * -1
           END IF      
           LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
           LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
           LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
           LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
           LET g_xccc_d[l_ac].info         = l_err,l_diff     
       END FOREACH
    
    #==检查主件==
     ##在製投入(主件)金額不等於在製投入(元件)金額，差异为：(axc-00440)
     #LET g_sql =  " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd202,xcce202,info ",              #170218-00022#1 mark
     LET g_sql =  " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add  
     #             " SELECT xccd007,xccd008,imaal003,xccd006,xccd202,xcce202,info ",                     #170218-00022#1 add  #170221-00028#1-mark
     #             "   FROM ( ",  #170221-00028#1-mark
                  " SELECT xccd007,xccd008,imaal003,xccd006,nvl(xccd202,0)+ nvl(xccd204,0) xccd202, ",
                  #"        (SELECT nvl(SUM(xcce202),0) + nvl(SUM(xcce206),0) + nvl(SUM(xcce208),0) + nvl(SUM(xcce210),0) ",  #170221-00028#1-mark
                  "        (SELECT SUM(xcce202) + SUM(xcce206) + SUM(xcce208) + SUM(xcce210) ",  #170221-00028#1-add 拿掉nvl
                 #"           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND xcce002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xcce003 = xccd003 AND xcce004 = xccd004 AND xcce005 = xccd005  AND xcce006 = xccd006 ) xcce202, ",               
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00440' AND gzze002='",g_lang,"') info",   
                  "   FROM xccd_t LEFT JOIN imaal_t ON imaalent= "||g_enterprise||" AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005#,       #期別  #170221-00028#1-mark ,
                  #"       )", #170221-00028#1-mark
      #            " WHERE xccd202 != xcce202 " #170221-00028#1-mark
      #170218-00022#1-s-add 
      PREPARE axcq301_cost_ins_p2 FROM g_sql    
      
      DELETE FROM axcq301_cost      #清除tmptable
      
      EXECUTE axcq301_cost_ins_p2 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_cost_ins_p2"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      #170221-00028#1-s-add
      UPDATE axcq301_cost SET cost2 = 0 WHERE cost2 IS NULL  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE axcq301_cost"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      #170221-00028#1-e-add
      #170221-00028#1-s-mod
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost" 
      LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info ",
                  "   FROM axcq301_cost WHERE cost != cost2"  
      #170221-00028#1-es-mod

     #170218-00022#1-e-add                   
      PREPARE axcq301_00440_p FROM g_sql    
       
      DECLARE axcq301_00440_c CURSOR FOR axcq301_00440_p
      FOREACH axcq301_00440_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd202,l_xcce202,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00440_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xccd.xccd202 - l_xcce202
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff
      END FOREACH  
     #在製转出(主件)金額不等於在製转出(元件)金額，差异为：(axc-00441)
    #LET g_sql =  " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd302,xcce302,info ",              #170218-00022#1 mark 
     LET g_sql =  " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add    
                  #" SELECT xccd007,xccd008,imaal003,xccd006,xccd302,xcce302,info ",                    #170218-00022#1 add  #170221-00028#1-mark
                  #"   FROM ( ",  #170221-00028#1-mark
                  " SELECT xccd007,xccd008,imaal003,xccd006,nvl(xccd302,0) xccd302, ",
                  #"        (SELECT nvl(SUM(xcce302),0) ",  #170221-00028#1-mark
                  "        (SELECT SUM(xcce302) ",  #170221-00028#1-add 拿掉nvl
                 #"           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND xcce002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xcce003 = xccd003 AND xcce004 = xccd004 AND xcce005 = xccd005  AND xcce006 = xccd006 ) xcce302, ",               
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00441' AND gzze002='",g_lang,"') info",   
                  "   FROM xccd_t LEFT JOIN imaal_t ON imaalent= "||g_enterprise||" AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005#,       #期別 #170221-00028#1-mark ,
                  #"       )", #170221-00028#1-mark
                  #" WHERE xccd302 != xcce302 " #170221-00028#1-mark
      #170218-00022#1-s-add 
      PREPARE axcq301_cost_ins_p3 FROM g_sql    
      
      DELETE FROM axcq301_cost      #清除tmptable
      
      EXECUTE axcq301_cost_ins_p3 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_cost_ins_p3"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      #170221-00028#1-s-add
      UPDATE axcq301_cost SET cost2 = 0 WHERE cost2 IS NULL  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE axcq301_cost"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      #170221-00028#1-e-add
      #170221-00028#1-s-mod
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost"
      LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info ",
                  "  FROM axcq301_cost WHERE cost != cost2"
      #170221-00028#1-e-mod

     #170218-00022#1-e-add                    
      PREPARE axcq301_00441_p FROM g_sql    
       
      DECLARE axcq301_00441_c CURSOR FOR axcq301_00441_p
      FOREACH axcq301_00441_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd302,l_xcce302,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00441_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xccd.xccd302 - l_xcce302
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff
      END FOREACH    
     #  #在製期初(主件)金額不等於在製期初(元件)金額，差异为：(axc-00442)
    #LET g_sql =  " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd102,xcce102,info ",              #170218-00022#1 mark
     LET g_sql =  " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add    
                  #" SELECT xccd007,xccd008,imaal003,xccd006,xccd102,xcce102,info ",                     #170218-00022#1 add  #170221-00028#1-mark
                  #"   FROM ( ", #170221-00028#1-mark
                  " SELECT xccd007,xccd008,imaal003,xccd006,nvl(xccd102,0) xccd102, ",
                  #"        (SELECT nvl(SUM(xcce102),0) ", #170221-00028#1-mark
                  "        (SELECT SUM(xcce102) ", #170221-00028#1-add  拿掉nvl
                 #"           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND xcce002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xcce003 = xccd003 AND xcce004 = xccd004 AND xcce005 = xccd005  AND xcce006 = xccd006 ) xcce102, ",               
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00442' AND gzze002='",g_lang,"') info",   
                  "   FROM xccd_t LEFT JOIN imaal_t ON imaalent= "||g_enterprise||" AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005#,       #期別 #170221-00028#1-mark ,
                  #"       )", #170221-00028#1-mark
                  #" WHERE xccd102 != xcce102 "  #170221-00028#1-mark
      #170218-00022#1-s-add 
      PREPARE axcq301_cost_ins_p4 FROM g_sql    
      
      DELETE FROM axcq301_cost      #清除tmptable
      
      EXECUTE axcq301_cost_ins_p4 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_cost_ins_p4"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      #170221-00028#1-s-add
      UPDATE axcq301_cost SET cost2 = 0 WHERE cost2 IS NULL  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE axcq301_cost"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      #170221-00028#1-e-add
      #170221-00028#1-s-mod
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost"
      LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info ",
                  "   FROM axcq301_cost WHERE cost != cost2 "
      #170221-00028#1-e-mod
      #170218-00022#1-e-add                   
      PREPARE axcq301_00442_p FROM g_sql    
       
      DECLARE axcq301_00442_c CURSOR FOR axcq301_00442_p
      FOREACH axcq301_00442_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd102,l_xcce102,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00442_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xccd.xccd102 - l_xcce102
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff
      END FOREACH  
    #在製期未(主件)金額不等於在製期未(元件)金額，差异为：(axc-00443)

    #LET g_sql =  " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd902,xcce902,info ",              #170218-00022#1 mark
     LET g_sql =  " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add
                  #" SELECT xccd007,xccd008,imaal003,xccd006,xccd902,xcce902,info ",                     #170218-00022#1 add  #170221-00028#1-mark
                  #"   FROM ( ",  #170221-00028#1-mark
                  " SELECT xccd007,xccd008,imaal003,xccd006,nvl(xccd902,0) xccd902, ",
                  #"        (SELECT nvl(SUM(xcce902),0) ", #170221-00028#1-mark
                  "        (SELECT SUM(xcce902) ", #170221-00028#1-add 拿掉nvl
                 #"           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND xcce002 = xccd002 AND ", #161007-00011#1 add
                  "           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND ",                       #161007-00011#1 mark
                  "                             xcce003 = xccd003 AND xcce004 = xccd004 AND xcce005 = xccd005  AND xcce006 = xccd006 ) xcce902, ",               
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00443' AND gzze002='",g_lang,"') info",   
                  "   FROM xccd_t LEFT JOIN imaal_t ON imaalent= "||g_enterprise||" AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005#,       #期別 #170221-00028#1-mark ,
                  #"       )", #170221-00028#1-mark
                  #" WHERE xccd902 != xcce902 "  #170221-00028#1-mark
      #170218-00022#1-s-add 
      PREPARE axcq301_cost_ins_p5 FROM g_sql    
      
      DELETE FROM axcq301_cost      
      EXECUTE axcq301_cost_ins_p5 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_cost_ins_p5"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      #170221-00028#1-s-add
      UPDATE axcq301_cost SET cost2 = 0 WHERE cost2 IS NULL  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE axcq301_cost"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      #170221-00028#1-e-add
      #170221-00028#1-s-mod
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost"
      LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info ",
                  "   FROM axcq301_cost WHERE cost != cost2"
      #170221-00028#1-e-mod
      #170218-00022#1-e-add

      PREPARE axcq301_00443_p FROM g_sql    
       
      DECLARE axcq301_00443_c CURSOR FOR axcq301_00443_p
      FOREACH axcq301_00443_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd902,l_xcce902,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00443_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xccd.xccd902 - l_xcce902
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff
      END FOREACH   
      #在製差异(主件)金額不等於在製差异(元件)金額，差异为：(axc-00444)
     #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,xccd304,xcce304,info ",              #170218-00022#1 mark
      LET g_sql = " INSERT INTO axcq301_cost(xccd007,xccd008,imaal003,xccd006,cost,cost2,info) ",       #170218-00022#1 add     
                  #" SELECT xccd007,xccd008,imaal003,xccd006,xccd304,xcce304,info ",                     #170218-00022#1 add #170221-00028#1-mark
                  #170221-00028#1"   FROM ( ", #170221-00028#1-mark
                  " SELECT xccd007,xccd008,imaal003,xccd006,nvl(xccd304,0) xccd304, ",
                  #"        (SELECT nvl(SUM(xcce304),0) ",#170221-00028#1 mark
                  "        (SELECT SUM(xcce304) ",#170221-00028#1 add
                 #"           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND xcce002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xcce_t WHERE xcceent = xccdent AND xccecomp = xccdcomp AND xcceld  = xccdld AND xcce001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xcce003 = xccd003 AND xcce004 = xccd004 AND xcce005 = xccd005  AND xcce006 = xccd006 ) xcce304, ",               
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00444' AND gzze002='",g_lang,"') info",   
                  "   FROM xccd_t LEFT JOIN imaal_t ON imaalent= "||g_enterprise||" AND imaal001 = xccd007 AND imaal002 = '"||g_dlang||"' ",           
                  "  WHERE xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005#,       #期別  #170221-00028#1-mark ,
                  #"       )",  #170221-00028#1-mark
                  #" WHERE xccd304 != xcce304 " #170221-00028#1-mark
       #170218-00022#1-s-add 
      PREPARE axcq301_cost_ins_p6 FROM g_sql    
      
      DELETE FROM axcq301_cost      #清除tmptable
      
      EXECUTE axcq301_cost_ins_p6 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_cost_ins_p6"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      #170221-00028#1-s-add
      UPDATE axcq301_cost SET cost2 = 0 WHERE cost2 IS NULL  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE axcq301_cost"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      #170221-00028#1-e-add
      #170221-00028#1-s-mod
      #LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info FROM axcq301_cost"
      LET g_sql = " SELECT UNIQUE xccd007,xccd008,imaal003,xccd006,cost,cost2,info ",
                  "   FROM axcq301_cost WHERE cost != cost2"
      #170221-00028#1-e-mod

     #170218-00022#1-e-add                  
      PREPARE axcq301_00444_p FROM g_sql    
       
      DECLARE axcq301_00444_c CURSOR FOR axcq301_00444_p
      FOREACH axcq301_00444_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xccd.xccd304,l_xcce304,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00444_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xccd.xccd304 - l_xcce304
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff
      END FOREACH  
      #投入与发料不符合（xcce_t&xcci_t与xccc_t）(axc-00405)
      INSERT INTO axcq301_xccc(xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,
                               xccc004,xccc005,xccc006,xccc007,xccc008,tot,
                               xcce202,xcci202,xcci302,xcck202)
        SELECT xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,
               xccc008,nvl((xccc302 + xccc208) * -1,0),0,0,0,0
          FROM xccc_t
         WHERE xcccent  = g_enterprise
           AND xccccomp = tm.xccccomp                           #法人组织
           AND xcccld   = tm.xcccld                             #帐别
           AND xccc003  = tm.xccc003                            #成本计算类型
           AND xccc004  = tm.xccc004                            #年度
           AND xccc005  = tm.xccc005                            #期别          
   
      LET g_sql = " MERGE INTO axcq301_xccc a ",
                  "      USING (SELECT xcceent,xcceld,xccecomp,xcce001,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008, ",
                  "                    xcce009,SUM(nvl(xcce202,0) + nvl(xcce206,0) + nvl(xcce208,0) + nvl(xcce210,0) ) xcce202 FROM xcce_t ",
                  "              GROUP BY xcceent,xcceld,xccecomp,xcce001,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008,xcce009 ) b ",
                  "         ON (a.xcccent = b.xcceent AND a.xcccld = b.xcceld   AND a.xccccomp = b.xccecomp AND a.xccc001 = b.xcce001 AND ",
                  "             a.xccc002 = b.xcce002 AND a.xccc003 = b.xcce003 AND a.xccc004 = b.xcce004 AND a.xccc005 = b.xcce005 AND ",
                  "             a.xccc006 = b.xcce007 AND a.xccc007 = b.xcce008 AND a.xccc008 = b.xcce009 ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xcce202 = b.xcce202 "
      PREPARE axcq301_xcce_upd_p FROM g_sql 
      EXECUTE axcq301_xcce_upd_p 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xcce_upd_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF 
   
      LET g_sql = " MERGE INTO axcq301_xccc a ",
                  "      USING (SELECT xccient,xccild,xccicomp,xcci001,xcci002,xcci003,xcci004,xcci005,xcci007,xcci008, ",
                  "                    xcci009,SUM(nvl(xcci202,0))xcci202,SUM(nvl(xcci302,0))xcci302 FROM xcci_t ",
                  "              GROUP BY xccient,xccild,xccicomp,xcci001,xcci002,xcci003,xcci004,xcci005,xcci007,xcci008,xcci009 ) b ",
                  "         ON (a.xcccent = b.xccient AND a.xcccld = b.xccild   AND a.xccccomp = b.xccicomp AND a.xccc001 = b.xcci001 AND ",
                  "             a.xccc002 = b.xcci002 AND a.xccc003 = b.xcci003 AND a.xccc004 = b.xcci004 AND a.xccc005 = b.xcci005 AND ",
                  "             a.xccc006 = b.xcci007 AND a.xccc007 = b.xcci008 AND a.xccc008 = b.xcci009 ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xcci202 = b.xcci202 ,",
                  "                  a.xcci302 = b.xcci302 "
      PREPARE axcq301_xcci_upd_p2 FROM g_sql 
      EXECUTE axcq301_xcci_upd_p2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xcci_upd_p2"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF    
      
      LET g_sql = " MERGE INTO axcq301_xccc a ",
                  "      USING (SELECT xcckent,xcckld,xcckcomp,xcck001,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011, ",
                  "                    xcck017,SUM(nvl(xcck202*xcck009*-1,0))xcck202 FROM axcq301_xcck ",
                  "              GROUP BY xcckent,xcckld,xcckcomp,xcck001,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 ) b ",
                  "         ON (a.xcccent = b.xcckent AND a.xcccld = b.xcckld   AND a.xccccomp = b.xcckcomp AND a.xccc001 = b.xcck001 AND ",
                  "             a.xccc002 = b.xcck002 AND a.xccc003 = b.xcck003 AND a.xccc004 = b.xcck004 AND a.xccc005 = b.xcck005 AND ",
                  "             a.xccc006 = b.xcck010 AND a.xccc007 = b.xcck011 AND a.xccc008 = b.xcck017 ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xcck202 = b.xcck202 "
      PREPARE axcq301_xcck_upd_p FROM g_sql 
      EXECUTE axcq301_xcck_upd_p
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xcck_upd_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,tot,xcce202,xcci202,xcci302 ",  
                  "  FROM axcq301_xccc LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE (xcce202+xcci202+xcci302 != tot AND (xcce202+xcci202+xcci302-tot > 1 OR tot-xcce202-xcci202-xcci302 > 1))"
   
      PREPARE axcq301_00405_p FROM g_sql    
       
      DECLARE axcq301_00405_c CURSOR FOR axcq301_00405_p
      FOREACH axcq301_00405_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_tot,l_xcce202,l_xcci202,l_xcci302
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00405_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xcce202+l_xcci202+l_xcci302
          LET l_str2 = l_tot
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00405',g_lang,l_str) RETURNING l_err 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #单据编号
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH 
      
      #投入%1与发料%2不符合xcck_t(axc-00406)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xcce202,xcci202,xcck202 ",  
                  "  FROM axcq301_xccc LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccc006 AND imaal002='"||g_dlang||"' ",
                  " WHERE xcce202+xcci202 != xcck202 "
   
      PREPARE axcq301_00406_p FROM g_sql    
       
      DECLARE axcq301_00406_c CURSOR FOR axcq301_00406_p
      FOREACH axcq301_00406_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xcce202,l_xcci202,l_xcck202
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00406_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xcce202 + l_xcci202
          LET l_str2 = l_xcck202
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00406',g_lang,l_str) RETURNING l_err 
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006 #料号
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007 #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003     #品名
          LET g_xccc_d[l_ac].docno        = ''             #单据编号
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH 
      
    #==在制工单元件检查-检查元件== 
      #在制成本(元件)期末金额为负(axc-00455)
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00455' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期?
                  "    AND xcce902 < 0 "
      PREPARE axcq301_00455_p FROM g_sql    
       
      DECLARE axcq301_00455_c CURSOR FOR axcq301_00455_p
      FOREACH axcq301_00455_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00455_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
      
     #在製成本(元件)期末材料金額為負(axc-00456)
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00456' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND xcce902a < 0 "
      PREPARE axcq301_00456_p FROM g_sql    
       
      DECLARE axcq301_00456_c CURSOR FOR axcq301_00456_p
      FOREACH axcq301_00456_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00456_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
     #在製成本(元件)期末人工金額為負(axc-00457) 
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00457' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND xcce902b < 0 "
      PREPARE axcq301_00457_p FROM g_sql    
       
      DECLARE axcq301_00457_c CURSOR FOR axcq301_00457_p
      FOREACH axcq301_00457_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00457_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
     #在製成本(元件)期末製費金額為負(axc-00458) 
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00458' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND (xcce902d < 0 OR xcce902e < 0 OR xcce902f < 0 OR xcce902g < 0 OR xcce902h < 0) "
      PREPARE axcq301_00458_p FROM g_sql    
       
      DECLARE axcq301_00458_c CURSOR FOR axcq301_00458_p
      FOREACH axcq301_00458_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00458_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
     #在製成本(元件)期末加工金額為負(axc-00459)
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00459' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND xcce902c < 0 "
      PREPARE axcq301_00459_p FROM g_sql    
       
      DECLARE axcq301_00459_c CURSOR FOR axcq301_00459_p
      FOREACH axcq301_00459_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00459_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH   
     #在製成本(元件)期末數量為負(axc-00460) 
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00460' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND xcce901 < 0 "
      PREPARE axcq301_00460_p FROM g_sql    
       
      DECLARE axcq301_00460_c CURSOR FOR axcq301_00460_p
      FOREACH axcq301_00460_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00460_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
     #元件(期初+投入)量為0，但(期初+投入)金額不為0(axc-00461) 
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00461' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND nvl(xcce101,0)+nvl(xcce201,0) = 0 ",
                  "    AND nvl(xcce102,0)+nvl(xcce202,0) !=0 ",
#                  "    AND xcce007 != 'DL+OH+SUB'  "                #160801-00050#1-mod-(S)
                  "    AND xcce007 NOT IN ('DL+OH+SUB','ADJUST') "   #160801-00050#1-mod-(E)
      PREPARE axcq301_00461_p FROM g_sql    
       
      DECLARE axcq301_00461_c CURSOR FOR axcq301_00461_p
      FOREACH axcq301_00461_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00461_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
     #在製轉出(元件)金額為負值(axc-00462) 
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00462' AND gzze002='",g_lang,"') info",   
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",                       
                  "  WHERE xcceent = ",g_enterprise,
                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
                  "    AND xcce004 = ",tm.xccc004,        #年度
                  "    AND xcce005 = ",tm.xccc005,        #期別
                  "    AND NOT EXISTS ( SELECT 1 FROM sfac_t WHERE sfacent = xccent AND sfacdocno = xcce006 AND sfac002 = '5' ) ",   #170220-00006#3 add
                  "    AND xcce302 > 0 "
      PREPARE axcq301_00462_p FROM g_sql    
       
      DECLARE axcq301_00462_c CURSOR FOR axcq301_00462_p
      FOREACH axcq301_00462_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00462_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err      
      END FOREACH 
      
      #抓取期未OR開帳資料
      DELETE FROM axcq301_xccb
      LET g_sql = " INSERT INTO axcq301_xccb (xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb007,xccb008,xccb009,xccb101,xccb102) ",
                  "     SELECT a.xcceent,a.xcceld,a.xcce001,a.xcce002,a.xcce003,a.xcce006,a.xcce007,a.xcce008,a.xcce009,nvl(b.xcce901,0),nvl(b.xcce902,0) ",
                  "       FROM axcq301_xcce a LEFT JOIN xcce_t b ON a.xcceent = b.xcceent AND a.xccecomp = b.xccecomp AND a.xcceld = b.xcceld AND ",
                  "                                                 a.xcce001 = b.xcce001 AND a.xcce002 = b.xcce002 AND a.xcce003 = b.xcce003 AND ",
                  "                                                 a.xcce006 = b.xcce006 AND a.xcce007 = b.xcce007 AND a.xcce008 = b.xcce008 AND ",
                  "                                                 a.xcce009 = b.xcce009 AND b.xcce004 = ",g_yy," AND b.xcce005 = ", g_mm     
      PREPARE axcq301_xcce_ins_p FROM g_sql    
       
      EXECUTE axcq301_xcce_ins_p 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xcce_ins_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF  
      
      LET g_sql = " MERGE INTO axcq301_xccb a ",
                  "      USING (SELECT xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb007,xccb008,xccb009, ",
                  "                    SUM(xccb101) xccb101 FROM xccb_t WHERE xccb004 = ",g_yy," AND xccb005 = ",g_mm,
                  "              GROUP BY xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb007,xccb008,xccb009 ) b ",
                  "         ON (a.xccbent = b.xccbent AND a.xccbld = b.xccbld   AND a.xccb001 = b.xccb001 AND a.xccb002 = b.xccb002 AND ",
                  "             a.xccb003 = b.xccb003 AND a.xccb006 = b.xccb006 AND a.xccb007 = b.xccb007 AND a.xccb008 = b.xccb008 AND ",
                  "             a.xccb009 = b.xccb009 AND b.xccb101 IS NOT NULL ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xccb101 = b.xccb101 "
      PREPARE axcq301_xccb_upd_p1 FROM g_sql 
      EXECUTE axcq301_xccb_upd_p1 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xccb_upd_p1"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF   
      
      LET g_sql = " MERGE INTO axcq301_xccb a ",
                  "      USING (SELECT xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb007,xccb008,xccb009, ",
                  "                    SUM(xccb102) xccb102 FROM xccb_t WHERE xccb004 = ",g_yy," AND xccb005 = ",g_mm,
                  "              GROUP BY xccbent,xccbld,xccb001,xccb002,xccb003,xccb006,xccb007,xccb008,xccb009 ) b ",
                  "         ON (a.xccbent = b.xccbent AND a.xccbld = b.xccbld   AND a.xccb001 = b.xccb001 AND a.xccb002 = b.xccb002 AND ",
                  "             a.xccb003 = b.xccb003 AND a.xccb006 = b.xccb006 AND a.xccb007 = b.xccb007 AND a.xccb008 = b.xccb008 AND ",
                  "             a.xccb009 = b.xccb009 AND b.xccb102 IS NOT NULL ) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET a.xccb102 = b.xccb102 "
      PREPARE axcq301_xccb_upd_p2 FROM g_sql 
      EXECUTE axcq301_xccb_upd_p2 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq301_xccb_upd_p2"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN 
      END IF   
      
      #161121-00007#1-add-s
      DROP INDEX axcq301_xccb_i01 
      CREATE INDEX axcq301_xccb_i01 ON axcq301_xccb(xccb001,xccb002,xccb006,xccb007,xccb008);
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE UNIQUE INDEX axcq301_xccb_i01"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      IF cl_db_generate_analyze("axcq301_xccb") THEN END IF
      #161121-00007#1-add-e
      #在製元件期初數量不等於上期期末數量，差異為：(axc-00463)
      #161121-00007#1-mod-s
      #
#      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce101,xccb101, ",
#                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00463' AND gzze002='",g_lang,"') info",   
#                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",    
#                  "        ,axcq301_xccb ",                   
#                  "  WHERE xcceent = xccbent AND xcceld = xccbld AND xcce001 = xccb001 AND xcce002 = xccb002 AND xcce003 = xccb003 AND xcce006 = xccb006 ",
#                  "    AND xcce007 = xccb007 AND xcce008 = xccb008 ",
#                  "    AND xcceent = ",g_enterprise,
#                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
#                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
#                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
#                  "    AND xcce004 = ",tm.xccc004,        #年度
#                  "    AND xcce005 = ",tm.xccc005,        #期別
#                  "    AND xccb101 <> xcce101  "
      #以上條件，tmp表已過濾，不需重複寫
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce101,xccb101,info FROM (",
                  " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce101,xccb101, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00463' AND gzze002='",g_lang,"') info,xccb101,xcce101 ",
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",
                  "        ,axcq301_xccb ",
                  "  WHERE xcce001 = xccb001 AND xcce002 = xccb002 AND xcce006 = xccb006 ",
                  "    AND xcce007 = xccb007 AND xcce008 = xccb008 )",
                  "  WHERE xccb101 <> xcce101  "
      #161121-00007#1-mod-e
      PREPARE axcq301_00463_p FROM g_sql    
       
      DECLARE axcq301_00463_c CURSOR FOR axcq301_00463_p
      FOREACH axcq301_00463_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xcce.xcce101,l_xcce901,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00463_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xcce901 - l_xcce.xcce101
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF       
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff      
      END FOREACH 
      
      #在製元件期初金額不等於上期期末金額，差異為：(axc-00464)
      #161121-00007#1-mod-s
#      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce102,xccb102, ",
#                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00464' AND gzze002='",g_lang,"') info",   
#                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",    
#                  "        ,axcq301_xccb ",                   
#                  "  WHERE xcceent = xccbent AND xcceld = xccbld AND xcce001 = xccb001 AND xcce002 = xccb002 AND xcce003 = xccb003 AND xcce006 = xccb006 ",
#                  "    AND xcce007 = xccb007 AND xcce008 = xccb008 ",
#                  "    AND xcceent = ",g_enterprise,
#                  "    AND xccecomp='",tm.xccccomp,"' ",  #法人組織
#                  "    AND xcceld  ='",tm.xcccld,"' ",    #帳別
#                  "    AND xcce003 ='",tm.xccc003,"'",    #成本計算類型
#                  "    AND xcce004 = ",tm.xccc004,        #年度
#                  "    AND xcce005 = ",tm.xccc005,        #期別
#                  "    AND xccb102 <> xcce102  "
      #以上條件，tmp表已過濾，不需重複寫
      LET g_sql = " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce102,xccb102,info FROM (",
                  " SELECT UNIQUE xcce007,xcce008,imaal003,xcce006,xcce101,xccb101, ",
                  "        (SELECT gzze003 FROM gzze_t WHERE gzze001='axc-00464' AND gzze002='",g_lang,"') info,xccb102,xcce102 ",
                  "   FROM axcq301_xcce LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xcce007 AND imaal002 = '"||g_dlang||"' ",
                  "        ,axcq301_xccb ",
                  "  WHERE xcce001 = xccb001 AND xcce002 = xccb002 AND xcce006 = xccb006 ",
                  "    AND xcce007 = xccb007 AND xcce008 = xccb008 )",
                  "  WHERE xccb102 <> xcce102  "
      #161121-00007#1-mod-e
      PREPARE axcq301_00464_p FROM g_sql    
       
      DECLARE axcq301_00464_c CURSOR FOR axcq301_00464_p
      FOREACH axcq301_00464_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccd.xccd006,l_xcce.xcce102,l_xcce902,l_err
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00464_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_diff = l_xcce902 - l_xcce.xcce102
          IF l_diff < 0 THEN
             LET l_diff = l_diff * -1
          END IF       
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006  #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007  #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003      #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err,l_diff      
      END FOREACH 
     #160813-00001#2-s-add
     #在製轉出金額%1與存貨工單入庫金額%2不符(axc-00465)
      #161121-00007#1-add-s
      DROP TABLE axcq301_xccc1
      LET g_sql = " SELECT * FROM xccc_t ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別  
                  "   INTO TEMP axcq301_xccc1"

      PREPARE axcq301_xccc_p1 FROM g_sql
      EXECUTE axcq301_xccc_p1

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE axcq301_xccc1"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      #161121-00007#1-add-e
      #161121-00007#1-mod-s
      #170116-00021#1 mod-S
      #170106-00047#1-s mod   出現「在制转出金额-1172.740000与存货工单入库金额0.000000不符，请检查工单成本域是否正确！」，因xccc_t串xccd_t時，沒把key值串進去，導致xccd_t資料抓錯
      #170106-00047#1-s mark
#      LET g_sql = " SELECT XCCC006,XCCC007,imaal003, (XCCC204 + XCCC206 + XCCC210) tot,(SELECT SUM(XCCD302)  FROM XCCD_T WHERE XCCD007 = XCCC006 AND XCCD008 = XCCC007) xccd302 ",
#                  "   FROM axcq301_xccc1 LEFT OUTER JOIN imaal_t ON imaalent=9 AND imaal001 = xccc006 AND imaal002 ='",g_dlang,"'",
#                  "  WHERE XCCC204 + XCCC206 + XCCC210 <>  (SELECT SUM(XCCD302) FROM XCCD_T  WHERE XCCD007 = XCCC006  AND XCCD008 = XCCC007) * -1"
      #170106-00047#1-e mark
      #170116-00021#1 mark-S
#      LET g_sql = " SELECT XCCC006,XCCC007,imaal003, (XCCC204 + XCCC206 + XCCC210) tot,(SELECT SUM(XCCD302)  FROM XCCD_T WHERE xccdent = xcccent and xccdld = xcccld and xccd001 = xccc001 and xccd002 = xccc002 and xccd003 = xccc003 and xccd004 = xccc004 and xccd005 = xccc005 and XCCD007 = XCCC006 AND NVL(XCCD008,' ') = XCCC007) xccd302 ",
#                  "   FROM axcq301_xccc1 LEFT OUTER JOIN imaal_t ON imaalent=9 AND imaal001 = xccc006 AND imaal002 ='",g_dlang,"'",
#                  "  WHERE XCCC204 + XCCC206 + XCCC210 <>  (SELECT SUM(XCCD302) FROM XCCD_T  WHERE xccdent = xcccent and xccdld = xcccld and xccd001 = xccc001 and xccd002 = xccc002 and xccd003 = xccc003 and xccd004 = xccc004 and xccd005 = xccc005 and XCCD007 = XCCC006  AND NVL(XCCD008,' ') = XCCC007) * -1"      
#      #170106-00047#1-e mod
      #170116-00021#1 mark-E  xccd008不存產品特徵，只用料號做比對資料
      LET g_sql = " SELECT XCCC006,'',imaal003, tot,(SELECT SUM(XCCD302)  FROM XCCD_T WHERE xccdent = xcccent and xccdld = xcccld and xccd001 = xccc001 and xccd002 = xccc002 and xccd003 = xccc003 and xccd004 = xccc004 and xccd005 = xccc005 and XCCD007 = XCCC006 ) xccd302 ",
                  "   FROM (SELECT xcccent,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,SUM(xccc204+xccc206+xccc210) tot FROM axcq301_xcccl ",
                  "          GROUP BY xcccent,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006) ",
                  "   LEFT OUTER JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccc006 AND imaal002 ='",g_dlang,"'",
                  "  WHERE tot <>  (SELECT SUM(XCCD302) FROM XCCD_T  WHERE xccdent = xcccent and xccdld = xcccld and xccd001 = xccc001 and xccd002 = xccc002 and xccd003 = xccc003 and xccd004 = xccc004 and xccd005 = xccc005 and XCCD007 = XCCC006 ) * -1"      
      #170116-00021#1 mod-E
#      LET g_sql = "SELECT xccc006,xccc007,imaal003,tot,xccd302 ",
#                  " FROM( ",
#                  "SELECT xccc006, xccc007,imaal003, ", 
#                  "      (SELECT SUM(xccc210+xccc204+xccc206) FROM xccc_t b ", 
#                  "        WHERE a.xcccent = b.xcccent AND a.xccccomp = b.xccccomp AND a.xcccld = b.xcccld AND ",
#                  "              a.xccc001 = b.xccc001 AND a.xccc002 = b.xccc002 AND a.xccc003 = b.xccc003 AND a.xccc004 = b.xccc004 AND ",
#                  "              a.xccc005 = b.xccc005 AND a.xccc006 = b.xccc006 AND a.xccc007 = b.xccc007 AND a.xccc008 = b.xccc008) tot, ",
#                  "      (SELECT SUM(xccd302) FROM xccd_t ",
#                  "        WHERE xccdent = a.xcccent AND xccdcomp = a.xccccomp AND xccdld = a.xcccld AND ",
#                  "              xccd001 = a.xccc001 AND xccd002 = a.xccc002 AND xccd003 = a.xccc003 AND ",
#                  "              xccd004 = a.xccc004 AND xccd005 = a.xccc005 AND xccd007 = a.xccc006 AND ",
#                  "              xccd008 = a.xccc007 AND xccd009 = a.xccc008) xccd302 ",
#                  "  FROM xccc_t a LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001 = xccc006 AND imaal002 ='"||g_dlang||"' ",
#                  " WHERE a.xcccent  = ",g_enterprise,
#                  "   AND a.xccccomp ='",tm.xccccomp,"' ",     #法人組織
#                  "   AND a.xcccld   ='",tm.xcccld,"' ",       #帳別
#                  "   AND a.xccc003  ='",tm.xccc003,"' ",      #成本計算類型
#                  "   AND a.xccc004  = ",tm.xccc004,           #年度
#                  "   AND a.xccc005  = ",tm.xccc005,           #期別  
#                  "     ) ",
#                  " WHERE tot + xccd302 <> 0 "   
      #161121-00007#1-mod-e
      PREPARE axcq301_00465_p FROM g_sql    
       
      DECLARE axcq301_00465_c CURSOR FOR axcq301_00465_p
      FOREACH axcq301_00465_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_tot,l_xccd.xccd302
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00465_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccd.xccd302
          LET l_str2 = l_tot
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00465',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err   
      END FOREACH                   
      #160813-00001#2-e-add      
    END IF                 #160523-00041#2 add 


    IF tm.c4 = 'Y'  THEN   #160523-00041#2 add
      #161121-00007#1-add-s
      DROP TABLE axcq301_xccc2
      LET g_sql = " SELECT * FROM xccc_t ",
                  " WHERE xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別  
                  "   INTO TEMP axcq301_xccc2"

      PREPARE axcq301_xccc_p2 FROM g_sql
      EXECUTE axcq301_xccc_p2

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE axcq301_xccc2"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      #161121-00007#1-add-e
      #聯產品異常檢核
      #(axc-00449)(axc-00450)(axc-00451)(axc-00452)(axc-00445)(axc-00446)(axc-00447)(axc-00448)
      #聯產品材料合計%1 不等於 材料入庫%2(axc-00449)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210a,xccg302a ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210a,0)+nvl(xccc206a,0) xccc210a, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210a,0)+nvl(xccc206a,0)+nvl(xccc204a,0) xccc210a, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302a),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302a ",
                  #161121-00007#1-mod-s
#                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "  FROM axcq301_xccc2 LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  #161121-00007#1-add-e
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302a - xccc210a > 0.1  "
   
      PREPARE axcq301_00449_p FROM g_sql    
       
      DECLARE axcq301_00449_c CURSOR FOR axcq301_00449_p
      FOREACH axcq301_00449_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210a,l_xccg302a
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00449_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302a
          LET l_str2 = l_xccc.xccc210a
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00449',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH    
      #聯產品人工合計%1 不等於 人工入庫%2(axc-00450)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210b,xccg302b ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210b,0)+nvl(xccc206b,0) xccc210b, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210b,0)+nvl(xccc206b,0)+nvl(xccc204b,0) xccc210b, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302b),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302b ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302b - xccc210b > 0.1  "
   
      PREPARE axcq301_00450_p FROM g_sql    
       
      DECLARE axcq301_00450_c CURSOR FOR axcq301_00450_p
      FOREACH axcq301_00450_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210b,l_xccg302b
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00450_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302b
          LET l_str2 = l_xccc.xccc210b
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00450',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
      #聯產品制?合計%1 不等於 制?入庫%2(axc-00451)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210d,xccg302d ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210d,0)+nvl(xccc206d,0) xccc210d, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210d,0)+nvl(xccc206d,0)+nvl(xccc204d,0) xccc210d, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302d),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302d ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302d - xccc210d > 0.1  "
   
      PREPARE axcq301_00451_p FROM g_sql    
       
      DECLARE axcq301_00451_c CURSOR FOR axcq301_00451_p
      FOREACH axcq301_00451_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210d,l_xccg302d
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00451_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302d
          LET l_str2 = l_xccc.xccc210d
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210e,xccg302e ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210e,0)+nvl(xccc206e,0) xccc210e, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210e,0)+nvl(xccc206e,0)+nvl(xccc204e,0) xccc210e, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302e),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302e ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302e - xccc210e > 0.1  "
   
      PREPARE axcq301_00451_1_p FROM g_sql    
       
      DECLARE axcq301_00451_1_c CURSOR FOR axcq301_00451_1_p
      FOREACH axcq301_00451_1_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210e,l_xccg302e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00451_1_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302e
          LET l_str2 = l_xccc.xccc210e
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210f,xccg302f ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210f,0)+nvl(xccc206f,0) xccc210f, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210f,0)+nvl(xccc206f,0)+nvl(xccc204f,0) xccc210f, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302f),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302f ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302f - xccc210f > 0.1  "
   
      PREPARE axcq301_00451_2_p FROM g_sql    
       
      DECLARE axcq301_00451_2_c CURSOR FOR axcq301_00451_2_p
      FOREACH axcq301_00451_2_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210f,l_xccg302f
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00451_2_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302f
          LET l_str2 = l_xccc.xccc210f
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210g,xccg302g ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210g,0)+nvl(xccc206g,0) xccc210g, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210g,0)+nvl(xccc206g,0)+nvl(xccc204g,0) xccc210g, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302g),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302g ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302g - xccc210g > 0.1  "
   
      PREPARE axcq301_00451_3_p FROM g_sql    
       
      DECLARE axcq301_00451_3_c CURSOR FOR axcq301_00451_3_p
      FOREACH axcq301_00451_3_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210g,l_xccg302g
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00451_3_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302g
          LET l_str2 = l_xccc.xccc210g
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210h,xccg302h ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210h,0)+nvl(xccc206h,0) xccc210h, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210h,0)+nvl(xccc206h,0)+nvl(xccc204h,0) xccc210h, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302h),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302h ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302h - xccc210h > 0.1  "
   
      PREPARE axcq301_00451_4_p FROM g_sql    
       
      DECLARE axcq301_00451_4_c CURSOR FOR axcq301_00451_4_p
      FOREACH axcq301_00451_4_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210h,l_xccg302h
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00451_4_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302h
          LET l_str2 = l_xccc.xccc210h
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00451',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
      #聯產品加工合計%1 不等於 加工入庫%2(axc-00452)
      LET g_sql = "SELECT UNIQUE xccc006,xccc007,imaal003,xccc210c,xccg302c ",
                  "  FROM ( ",
                 #"SELECT xccc006,xccc007,imaal003,nvl(xccc210c,0)+nvl(xccc206c,0) xccc210c, ",                   #160912-00053#1 mark
                  "SELECT xccc006,xccc007,imaal003,nvl(xccc210c,0)+nvl(xccc206c,0)+nvl(xccc204c,0) xccc210c, ",   #160912-00053#1 add
                  "       (SELECT nvl(SUM(xccg302c),0) FROM xccg_t ",
                  "         WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001  ",
                  "           AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005  ",
                  "           AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008) xccg302c ",
                  "  FROM xccc_t LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ",
                  "       ,xccg_t ",
                  " WHERE xccgent = xcccent AND xccgcomp = xccccomp AND xccgld  = xcccld  AND xccg001 = xccc001 ",
                  "   AND xccg002 = xccc002 AND xccg003 = xccc003  AND xccg004 = xccc004 AND xccg005 = xccc005 ",
                  "   AND xccg007 = xccc006 AND xccg008 = xccc007 AND xccg009 = xccc008 ",
                  "   AND xcccent  = ",g_enterprise,
                  "   AND xccccomp ='",tm.xccccomp,"' ",     #法人組織
                  "   AND xcccld   ='",tm.xcccld,"' ",       #帳別
                  "   AND xccc003  ='",tm.xccc003,"' ",      #成本計算類型
                  "   AND xccc004  = ",tm.xccc004,           #年度
                  "   AND xccc005  = ",tm.xccc005,           #期別
                  "       ) ",
                  " WHERE xccg302c - xccc210c > 0.1  "
   
      PREPARE axcq301_00452_p FROM g_sql    
       
      DECLARE axcq301_00452_c CURSOR FOR axcq301_00452_p
      FOREACH axcq301_00452_c INTO l_xccc.xccc006,l_xccc.xccc007,l_imaal003,l_xccc.xccc210c,l_xccg302c
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00452_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302c
          LET l_str2 = l_xccc.xccc210c
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00452',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = l_xccc.xccc006     #料號
          LET g_xccc_d[l_ac].xccc007      = l_xccc.xccc007     #特征
          LET g_xccc_d[l_ac].xccc006_desc = l_imaal003         #品名
          LET g_xccc_d[l_ac].docno        = ''                 #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
     #工單聯產品材料轉出合計%1 不等於 工單材料轉出%2(axc-00445)
     LET g_sql =  " SELECT UNIQUE xccd006,xccd302a,xccg302a ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302a,0) xccd302a, ",
                  "        (SELECT nvl(SUM(xccg302a),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302a ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",   #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                         #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302a != xccg302a "      #160813-00001#2 mark
                  " WHERE xccd302a + xccg302a <> 0 "  #160813-00001#2 add
                  
      PREPARE axcq301_00445_p FROM g_sql    
       
      DECLARE axcq301_00445_c CURSOR FOR axcq301_00445_p
      FOREACH axcq301_00445_c INTO l_xccd.xccd006,l_xccd.xccd302a,l_xccg302a
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00445_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302a
          LET l_str2 = l_xccd.xccd302a
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00445',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
     #工單聯產品人工轉出合計%1 不等於 工單人工轉出%2(axc-00446)
      LET g_sql = " SELECT UNIQUE xccd006,xccd302b,xccg302b ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302b,0) xccd302b, ",
                  "        (SELECT nvl(SUM(xccg302b),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302b ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ", #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                       #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302b != xccg302b "         #160813-00001#2 mark
                  " WHERE xccd302b + xccg302b <> 0 "     #160813-00001#2 add
                  
      PREPARE axcq301_00446_p FROM g_sql    
       
      DECLARE axcq301_00446_c CURSOR FOR axcq301_00446_p
      FOREACH axcq301_00446_c INTO l_xccd.xccd006,l_xccd.xccd302b,l_xccg302b
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00446_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302b
          LET l_str2 = l_xccd.xccd302b
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00446',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
     #工單聯產品制费轉出合計%1不等於工單制费轉出%2(axc-00447)
      LET g_sql = " SELECT UNIQUE xccd006,xccd302d,xccg302d ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302d,0) xccd302d, ",
                  "        (SELECT nvl(SUM(xccg302d),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302d ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",  #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                        #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302d != xccg302d "       #160813-00001#2 mark
                  " WHERE xccd302d + xccg302d <> 0 "   #160813-00001#2 add
                  
      PREPARE axcq301_00447_p FROM g_sql    
       
      DECLARE axcq301_00447_c CURSOR FOR axcq301_00447_p
      FOREACH axcq301_00447_c INTO l_xccd.xccd006,l_xccd.xccd302d,l_xccg302d
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00447_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302d
          LET l_str2 = l_xccd.xccd302d
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH    
      LET g_sql = " SELECT UNIQUE xccd006,xccd302e,xccg302e ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302e,0) xccd302e, ",
                  "        (SELECT nvl(SUM(xccg302e),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302e ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",  #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                        #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302e != xccg302e "      #160813-00001#2 mark
                  " WHERE xccd302e + xccg302e <> 0 "  #160813-00001#2 add
                  
      PREPARE axcq301_00447_1_p FROM g_sql    
       
      DECLARE axcq301_00447_1_c CURSOR FOR axcq301_00447_1_p
      FOREACH axcq301_00447_1_c INTO l_xccd.xccd006,l_xccd.xccd302e,l_xccg302e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00447_1_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302e
          LET l_str2 = l_xccd.xccd302e
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = " SELECT UNIQUE xccd006,xccd302f,xccg302f ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302f,0) xccd302f, ",
                  "        (SELECT nvl(SUM(xccg302f),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302f ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ", #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                       #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302f != xccg302f "      #160813-00001#2 mark
                  " WHERE xccd302f + xccg302f <> 0"   #160813-00001#2 add
                  
      PREPARE axcq301_00447_2_p FROM g_sql    
       
      DECLARE axcq301_00447_2_c CURSOR FOR axcq301_00447_2_p
      FOREACH axcq301_00447_2_c INTO l_xccd.xccd006,l_xccd.xccd302f,l_xccg302f
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00447_2_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302f
          LET l_str2 = l_xccd.xccd302f
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = " SELECT UNIQUE xccd006,xccd302g,xccg302g ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302g,0) xccd302g, ",
                  "        (SELECT nvl(SUM(xccg302g),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302g ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",  #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                        #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302g != xccg302g "       #160813-00001#2 mark
                  " WHERE xccd302g + xccg302g <> 0 "   #160813-00001#2 add
                  
      PREPARE axcq301_00447_3_p FROM g_sql    
       
      DECLARE axcq301_00447_3_c CURSOR FOR axcq301_00447_3_p
      FOREACH axcq301_00447_3_c INTO l_xccd.xccd006,l_xccd.xccd302g,l_xccg302g
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00447_3_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302g
          LET l_str2 = l_xccd.xccd302g
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH  
      LET g_sql = " SELECT UNIQUE xccd006,xccd302h,xccg302h ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302h,0) xccd302h, ",
                  "        (SELECT nvl(SUM(xccg302h),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ",  #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                        #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302h ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",  #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                        #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302h != xccg302h "      #160813-00001#2 mark
                  " WHERE xccd302h + xccg302h <> 0 "  #160813-00001#2 add
                  
      PREPARE axcq301_00447_4_p FROM g_sql    
       
      DECLARE axcq301_00447_4_c CURSOR FOR axcq301_00447_4_p
      FOREACH axcq301_00447_4_c INTO l_xccd.xccd006,l_xccd.xccd302h,l_xccg302h
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00447_4_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302h
          LET l_str2 = l_xccd.xccd302h
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00447',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH     
     #工單聯產品加工轉出合計%1 不等於 工單加工轉出%2(axc-00448)
      LET g_sql = " SELECT UNIQUE xccd006,xccd302c,xccg302c ",
                  "   FROM ( ",
                  " SELECT xccd006,nvl(xccd302c,0) xccd302c, ",
                  "        (SELECT nvl(SUM(xccg302c),0) ",
                 #"           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 AND ", #161007-00011#1 mark
                  "           FROM xccg_t WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND ",                       #161007-00011#1 add
                  "                             xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ) xccg302c ",               
                  "   FROM xccd_t,xccg_t ",
                 #"  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 AND xccg002 = xccd002 ",  #161007-00011#1 mark
                  "  WHERE xccgent = xccdent AND xccgcomp = xccdcomp AND xccgld  = xccdld AND xccg001 = xccd001 ",                        #161007-00011#1 add
                  "    AND xccg003 = xccd003 AND xccg004 = xccd004 AND xccg005 = xccd005  AND xccg006 = xccd006 ",
                  "    AND xccdent = ",g_enterprise,
                  "    AND xccdcomp='",tm.xccccomp,"' ", #法人組織
                  "    AND xccdld  ='",tm.xcccld,"' ",   #帳別
                  "    AND xccd003 ='",tm.xccc003,"'",   #成本計算類別
                  "    AND xccd004 = ",tm.xccc004,       #年度
                  "    AND xccd005 = ",tm.xccc005,       #期別
                  "       )",
                 #" WHERE xccd302c != xccg302c "      #160813-00001#2 mark
                  " WHERE xccd302c + xccg302c <> 0 "  #160813-00001#2 add
                  
      PREPARE axcq301_00448_p FROM g_sql    
       
      DECLARE axcq301_00448_c CURSOR FOR axcq301_00448_p
      FOREACH axcq301_00448_c INTO l_xccd.xccd006,l_xccd.xccd302c,l_xccg302c
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.extend = "PREPARE axcq301_00448_p"
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN 
          END IF 
          LET l_ac = l_ac + 1
          LET l_str1 = l_xccg302c
          LET l_str2 = l_xccd.xccd302c
          LET l_str = l_str1.trim(),'|',l_str2.trim()
          CALL cl_getmsg_parm('axc-00448',g_lang,l_str) RETURNING l_err
          LET g_xccc_d[l_ac].xccc006      = ''              #料號
          LET g_xccc_d[l_ac].xccc007      = ''              #特征
          LET g_xccc_d[l_ac].xccc006_desc = ''              #品名
          LET g_xccc_d[l_ac].docno        = l_xccd.xccd006  #單據編號
          LET g_xccc_d[l_ac].info         = l_err
      END FOREACH         
    END IF             #160523-00041#2 add
  

 LET g_detail_cnt = g_xccc_d.getLength() 
 DISPLAY g_detail_cnt TO FORMONLY.h_count 


END FUNCTION

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="aslp201.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-10-03 09:08:40), PR版次:0005(2017-01-09 14:54:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000005
#+ Filename...: aslp201
#+ Description: 訂貨會訂貨明細整批轉出作業
#+ Creator....: 06137(2016-09-29 14:02:33)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="aslp201.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161128-00017#1 2016/11/28 by 08172  单身铺货库位赋值
#161219-00001#1 2016/12/19 by geza   aslp201生成的分销订单中，
#                                    1、单身资料缺失：参考单位、参考数量
#                                    2、单身资料信息错误：现标准售价、交易价格均是吊牌价，应当是出售给加盟商的实际价格；
#                                    3、单身含税金额、税前金额、税额都是0，应按单据原标准赋值方式赋值
#                                    4、aslp201生成的铺货单中，单身字段未赋值：没有给pmcp015赋值，应赋值为imaa116吊牌价
#170104-00068#2 2017/01/05 by 06814  一、數據有效性檢查:1.如对象是[客户]，且送货地址为空，则不可生成。
#                                                  2.如对象是[内部组织]，且入库成本仓库位为空，则不可生成apmt832。
#                                                  3.生成apmt832时库位按照入货成本仓赋值，详见分镜。
#                                    二、狀態等於2.已審核才可以轉出
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
   xmjd001             LIKE xmjd_t.xmjd001,
   xmjd002             LIKE xmjd_t.xmjd002,
   xmjd003             LIKE xmjd_t.xmjd003,
   xmjd004             LIKE xmjd_t.xmjd004,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
   sel                  LIKE type_t.chr1,         #選擇   
   xmjd001              LIKE xmjd_t.xmjd001,
   xmjd002              LIKE xmjd_t.xmjd002,   
   xmjd003              LIKE xmjd_t.xmjd003,   
   xmjd004              LIKE xmjd_t.xmjd004,   
   xmjd005              LIKE xmjd_t.xmjd005,   
   xmjd007              LIKE xmjd_t.xmjd007,   
   xmjd008              LIKE xmjd_t.xmjd008,                           
   xmjd008_desc         LIKE imaal_t.imaal003,
   xmjd020              LIKE xmjd_t.xmjd020,
   xmjd021              LIKE xmjd_t.xmjd021,   
   xmjd022              LIKE xmjd_t.xmjd022,   
   xmjd023              LIKE xmjd_t.xmjd023,   
   xmjd024              LIKE xmjd_t.xmjd024,   
   xmjd025              LIKE xmjd_t.xmjd025,   
   xmjd026              LIKE xmjd_t.xmjd026,
   xmjd027              LIKE xmjd_t.xmjd027,
   xmjd028              LIKE xmjd_t.xmjd028,   
   xmjd029              LIKE xmjd_t.xmjd029,   
   xmjd030              LIKE xmjd_t.xmjd030,   
   xmjd031              LIKE xmjd_t.xmjd031,                           
   xmjd010              LIKE xmjd_t.xmjd010,   
   xmjd011              LIKE xmjd_t.xmjd011,   
   xmjd012              LIKE xmjd_t.xmjd012,   
   xmjd013              LIKE xmjd_t.xmjd013,   
   xmjd014              LIKE xmjd_t.xmjd014,   
   xmjd015              LIKE xmjd_t.xmjd015,   
   xmjd016              LIKE xmjd_t.xmjd016,   
   xmjd017              LIKE xmjd_t.xmjd017    
                        END RECORD   
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_d_t     type_g_detail_d
DEFINE g_detail_d_o     type_g_detail_d
DEFINE g_qbe            RECORD
       xmjd001          LIKE xmjd_t.xmjd001,     #年份
       xmjd002          LIKE xmjd_t.xmjd002,     #訂貨季
       xmjd003          LIKE xmjd_t.xmjd003,     #對象類型
       xmjd004          LIKE xmjd_t.xmjd004      #對象編號
                        END RECORD
#end add-point
 
{</section>}
 
{<section id="aslp201.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslp201 WITH FORM cl_ap_formpath("asl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aslp201_init()   
 
      #進入選單 Menu (="N")
      CALL aslp201_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aslp201
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL aslp201_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aslp201.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aslp201_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_session_id    LIKE type_t.num20
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('xmjd002','6940','1,2')
   CALL cl_set_combo_scc_part('b_xmjd002','6940','1,2')
   CALL cl_set_combo_scc('xmjd003','6960') 
   CALL cl_set_combo_scc('b_xmjd003','6960') 
   CALL cl_set_combo_scc('b_xmjd017','6961') 
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "-----------------------------------"
   DISPLAY "SessionId: ",l_session_id   
   DISPLAY "-----------------------------------"
   CALL aslp201_create_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aslp201.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslp201_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_cnt     LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aslp201_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmjd004
                   
            ON ACTION controlp INFIELD xmjd004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF g_qbe.xmjd003 = '1' THEN
                  CALL q_ooef001_34()                                           
               END IF
               IF g_qbe.xmjd003 = '2' THEN
                  CALL q_pmaa001_13()                                            
               END IF
                                        
               DISPLAY g_qryparam.return1  TO xmjd004   
               LET g_qbe.xmjd004 = g_qryparam.return1  #161215-00086#1  add by yany 2016/12/16               
               NEXT FIELD xmjd004                          #返回原欄位

            #161215-00086#1  add by yany 2016/12/16 --str
            AFTER FIELD xmjd004
               LET g_qbe.xmjd004 = GET_FLDBUF(xmjd004)
            #161215-00086#1  add by yany 2016/12/16 --end
            
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_qbe.xmjd001,g_qbe.xmjd002,g_qbe.xmjd003
            
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)                      
                     
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               LET g_detail_d_o.* = g_detail_d[l_ac].*
               DISPLAY l_ac TO FORMONLY.h_index
               
         END DISPLAY                     
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
            LET g_qbe.xmjd002 = '1'
            LET g_qbe.xmjd003 = '0'
            CALL aslp201_set_entry_b()
            CALL aslp201_set_no_entry_b()
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
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
            CALL aslp201_filter()
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
            IF cl_null(g_qbe.xmjd001) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'asl-00030'
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               NEXT FIELD xmjd001                            
            END IF
            IF cl_null(g_qbe.xmjd002) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'asl-00031'
               LET g_errparam.popup  = FALSE
               CALL cl_err()               
               NEXT FIELD xmjd002
            END IF
            IF cl_null(g_qbe.xmjd003) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'asl-00032'
               LET g_errparam.popup  = FALSE
               CALL cl_err()                  
               NEXT FIELD xmjd003
            END IF            
            #end add-point
            CALL aslp201_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            LET g_qbe.xmjd001 = ''
            LET g_qbe.xmjd002 = ''
            LET g_qbe.xmjd003 = ''
            LET g_qbe.xmjd004 = ''
            DISPLAY g_qbe.xmjd001 TO xmjd001
            DISPLAY g_qbe.xmjd002 TO xmjd002
            DISPLAY g_qbe.xmjd003 TO xmjd003
            DISPLAY g_qbe.xmjd004 TO xmjd004
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aslp201_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL cl_err_collect_init()            
            IF NOT aslp201_xmjd017_chk() THEN
               CALL cl_err_collect_show()                
               CONTINUE DIALOG               
            END IF
            IF NOT aslp201_xmjdsite_chk() THEN
               CALL cl_err_collect_show()                
               CONTINUE DIALOG
            END IF
            
            #170104-00068#2 20170105 add by beckxie---S
            #檢核:當對象類型為[1.內部組織]時,對應的收貨成本倉(ooef123)不可為空
            IF NOT aslp201_ooef123_chk() THEN
               CALL cl_err_collect_show()                
               CONTINUE DIALOG
            END IF
            #檢核:當對象類型為[2.客戶]時,對應的送貨地址(oofb019)不可為空
            IF NOT aslp201_oofb019_chk() THEN
               CALL cl_err_collect_show()                
               CONTINUE DIALOG
            END IF
            #170104-00068#2 20170105 add by beckxie---E
            
            CALL s_transaction_begin()
            #當對象類型有 1.內部組織時  才產生鋪貨單
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
              FROM aslp201_tmp01
             WHERE xmjd003 = '1'
            IF l_cnt > 0 THEN             
               IF NOT aslp201_gen_pmco_po() THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG                  
               END IF
            END IF
            
            #當對象類型有 2.客戶時  才產生訂單
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
              FROM aslp201_tmp01
             WHERE xmjd003 = '2'
            IF l_cnt > 0 THEN             
               IF NOT aslp201_gen_xmda_po() THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG                   
               END IF
            END IF   

            CALL s_transaction_end('Y','1')
            CALL cl_err_collect_show() 
            CALL aslp201_b_fill()            
            
           

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
 
{<section id="aslp201.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aslp201_query()
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
   CALL aslp201_b_fill()
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
 
{<section id="aslp201.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aslp201_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql           STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET l_sql = "DELETE FROM aslp201_tmp01 "
   PREPARE aslp201_tmp_del FROM l_sql
   EXECUTE aslp201_tmp_del
   
   LET l_sql = "INSERT INTO aslp201_tmp01 ",
               "SELECT xmjdent , xmjdsite , xmjd001 , xmjd002 , xmjd003 , ",
               "       xmjd004 , xmjd005 ,  xmjd006 , xmjd007 , xmjd008 , ",
               "       xmjd009 , xmjd010 ,  xmjd011 , xmjd012 , xmjd013 , ",
               "       xmjd014 , xmjd015 ,  xmjd016 , xmjd017 , xmjd018 , ",
               "       xmjd019 , xmjd020 ,  xmjd021 , xmjd022 , xmjd023 , ",
               "       xmjd024 , xmjd025 ,  xmjd026 , xmjd027 , xmjd028 , ",
               "       xmjd029 , xmjd030 ,  xmjd031 ",
               "  FROM xmjd_t ",
               " WHERE xmjdent = ",g_enterprise,              
               "   AND ",g_wc CLIPPED,
               "   AND xmjd001 = '",g_qbe.xmjd001,"'"
   IF NOT cl_null(g_qbe.xmjd002) THEN   
      LET l_sql = l_sql ," AND xmjd002 = '",g_qbe.xmjd002,"'"
   END IF
   IF NOT cl_null(g_qbe.xmjd003) AND g_qbe.xmjd003 != 0 THEN
      LET l_sql = l_sql ," AND xmjd003 = '",g_qbe.xmjd003,"'"
   END IF 
   #LET l_sql = l_sql ,"   AND xmjd017 <> '3' "   #170104-00068#2 20170109 mark by beckxie
   LET l_sql = l_sql ,"   AND xmjd017 = '2' "     #170104-00068#2 20170109 add by beckxie
   PREPARE aslp201_tmp_ins FROM l_sql
   EXECUTE aslp201_tmp_ins
   
   LET g_sql = "SELECT 'Y',        ",
               "       xmjd001 ,   xmjd002 ,   xmjd003 ,   xmjd004 ,   xmjd005 , ",   
               "       xmjd007 ,   xmjd008 ,   imaal003,   xmjd020 ,   xmjd021 ,   xmjd022 , ",
               "       xmjd023 ,   xmjd024 ,   xmjd025 ,   xmjd026 ,   xmjd027 , ",
               "       xmjd028 ,   xmjd029 ,   xmjd030 ,   xmjd031 ,   xmjd010 , ",
               "       xmjd011 ,   xmjd012 ,   xmjd013 ,   xmjd014 ,   xmjd015 , ",
               "       xmjd016 ,   xmjd017  ",
               "  FROM aslp201_tmp01 ",
               "  LEFT JOIN imaal_t ON xmjdent = imaalent AND xmjd008 = imaal001 AND imaal002 = '",g_dlang,"' "  , 
               " WHERE xmjdent = ? "
               
   
   DISPLAY "---------------------------------"
   DISPLAY "g_sql:",g_sql
   DISPLAY "---------------------------------"
   #end add-point
 
   PREPARE aslp201_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aslp201_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel ,
      g_detail_d[l_ac].xmjd001 ,   g_detail_d[l_ac].xmjd002 ,   g_detail_d[l_ac].xmjd003 ,    g_detail_d[l_ac].xmjd004 ,   g_detail_d[l_ac].xmjd005 ,    
      g_detail_d[l_ac].xmjd007 ,   g_detail_d[l_ac].xmjd008 ,   g_detail_d[l_ac].xmjd008_desc,g_detail_d[l_ac].xmjd020 ,   g_detail_d[l_ac].xmjd021 ,   g_detail_d[l_ac].xmjd022 , 
      g_detail_d[l_ac].xmjd023 ,   g_detail_d[l_ac].xmjd024 ,   g_detail_d[l_ac].xmjd025 ,    g_detail_d[l_ac].xmjd026 ,   g_detail_d[l_ac].xmjd027 , 
      g_detail_d[l_ac].xmjd028 ,   g_detail_d[l_ac].xmjd029 ,   g_detail_d[l_ac].xmjd030 ,    g_detail_d[l_ac].xmjd031 ,   g_detail_d[l_ac].xmjd010 , 
      g_detail_d[l_ac].xmjd011 ,   g_detail_d[l_ac].xmjd012 ,   g_detail_d[l_ac].xmjd013 ,    g_detail_d[l_ac].xmjd014 ,   g_detail_d[l_ac].xmjd015 , 
      g_detail_d[l_ac].xmjd016 ,   g_detail_d[l_ac].xmjd017    
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
      
      CALL aslp201_detail_show()      
 
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
   #刪除空白行
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aslp201_sel
   
   LET l_ac = 1
   CALL aslp201_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslp201.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aslp201_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   DISPLAY li_ac TO FORMONLY.h_index
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aslp201.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aslp201_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslp201.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aslp201_filter()
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
   
   CALL aslp201_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aslp201.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aslp201_filter_parser(ps_field)
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
 
{<section id="aslp201.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aslp201_filter_show(ps_field,ps_object)
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
   LET ls_condition = aslp201_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aslp201.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 單身欄位開啟
# Memo...........:
# Usage..........: CALL aslp201_set_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/09/29 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_set_entry_b()
   CALL cl_set_comp_entry("b_xmjd001",TRUE)             
   CALL cl_set_comp_entry("b_xmjd002",TRUE)              
   CALL cl_set_comp_entry("b_xmjd003",TRUE)              
   CALL cl_set_comp_entry("b_xmjd004",TRUE)              
   CALL cl_set_comp_entry("b_xmjd005",TRUE)              
   CALL cl_set_comp_entry("b_xmjd007",TRUE)              
   CALL cl_set_comp_entry("b_xmjd008",TRUE)                                      
   CALL cl_set_comp_entry("b_xmjd020",TRUE)             
   CALL cl_set_comp_entry("b_xmjd021",TRUE)              
   CALL cl_set_comp_entry("b_xmjd022",TRUE)              
   CALL cl_set_comp_entry("b_xmjd023",TRUE)              
   CALL cl_set_comp_entry("b_xmjd024",TRUE)              
   CALL cl_set_comp_entry("b_xmjd025",TRUE)              
   CALL cl_set_comp_entry("b_xmjd026",TRUE)             
   CALL cl_set_comp_entry("b_xmjd027",TRUE)             
   CALL cl_set_comp_entry("b_xmjd028",TRUE)              
   CALL cl_set_comp_entry("b_xmjd029",TRUE)              
   CALL cl_set_comp_entry("b_xmjd030",TRUE)              
   CALL cl_set_comp_entry("b_xmjd031",TRUE)                                      
   CALL cl_set_comp_entry("b_xmjd010",TRUE)              
   CALL cl_set_comp_entry("b_xmjd011",TRUE)              
   CALL cl_set_comp_entry("b_xmjd012",TRUE)              
   CALL cl_set_comp_entry("b_xmjd013",TRUE)              
   CALL cl_set_comp_entry("b_xmjd014",TRUE)              
   CALL cl_set_comp_entry("b_xmjd015",TRUE)              
   CALL cl_set_comp_entry("b_xmjd016",TRUE)              
   CALL cl_set_comp_entry("b_xmjd017",TRUE)  
END FUNCTION

################################################################################
# Descriptions...: 單身欄位關閉
# Memo...........:
# Usage..........: CALL aslp201_set_no_entry_b()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/09/29 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_set_no_entry_b()
   CALL cl_set_comp_entry("b_xmjd001",FALSE)             
   CALL cl_set_comp_entry("b_xmjd002",FALSE)              
   CALL cl_set_comp_entry("b_xmjd003",FALSE)              
   CALL cl_set_comp_entry("b_xmjd004",FALSE)              
   CALL cl_set_comp_entry("b_xmjd005",FALSE)              
   CALL cl_set_comp_entry("b_xmjd007",FALSE)              
   CALL cl_set_comp_entry("b_xmjd008",FALSE)                                      
   CALL cl_set_comp_entry("b_xmjd020",FALSE)             
   CALL cl_set_comp_entry("b_xmjd021",FALSE)              
   CALL cl_set_comp_entry("b_xmjd022",FALSE)              
   CALL cl_set_comp_entry("b_xmjd023",FALSE)              
   CALL cl_set_comp_entry("b_xmjd024",FALSE)              
   CALL cl_set_comp_entry("b_xmjd025",FALSE)              
   CALL cl_set_comp_entry("b_xmjd026",FALSE)             
   CALL cl_set_comp_entry("b_xmjd027",FALSE)             
   CALL cl_set_comp_entry("b_xmjd028",FALSE)              
   CALL cl_set_comp_entry("b_xmjd029",FALSE)              
   CALL cl_set_comp_entry("b_xmjd030",FALSE)              
   CALL cl_set_comp_entry("b_xmjd031",FALSE)                                      
   CALL cl_set_comp_entry("b_xmjd010",FALSE)              
   CALL cl_set_comp_entry("b_xmjd011",FALSE)              
   CALL cl_set_comp_entry("b_xmjd012",FALSE)              
   CALL cl_set_comp_entry("b_xmjd013",FALSE)              
   CALL cl_set_comp_entry("b_xmjd014",FALSE)              
   CALL cl_set_comp_entry("b_xmjd015",FALSE)              
   CALL cl_set_comp_entry("b_xmjd016",FALSE)              
   CALL cl_set_comp_entry("b_xmjd017",FALSE)               
END FUNCTION

################################################################################
# Descriptions...: 檢查處理狀態是否有未審核的資料
# Memo...........:
# Usage..........: CALL aslp201_xmjd017_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2016/09/29 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_xmjd017_chk()
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_sql_tmp        STRING
DEFINE l_xmjd004        LIKE xmjd_t.xmjd004
DEFINE l_err_cnt        LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET l_err_cnt = 0
   LET r_success = TRUE
   
   LET l_sql = " SELECT COUNT(1) FROM aslp201_tmp01 WHERE xmjd017 = '1' "
   PREPARE aslp201_xmjd017_count FROM l_sql
   EXECUTE aslp201_xmjd017_count INTO l_cnt
   
   IF l_cnt > 0 THEN
      LET l_sql = " SELECT xmjd004 FROM aslp201_tmp01 ",
                  "  WHERE xmjd017 = '1' ",
                  "  GROUP BY xmjd004 "
      PREPARE aslp201_xmjd017_pre FROM l_sql
      DECLARE aslp201_xmjd017_cur CURSOR FOR aslp201_xmjd017_pre
      FOREACH aslp201_xmjd017_cur INTO l_xmjd004
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "asl-00026"
         LET g_errparam.replace[1] = l_xmjd004
         LET g_errparam.popup  = TRUE
         CALL cl_err()         
         LET l_err_cnt = l_err_cnt + 1   
      END FOREACH
   END IF
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查銷售組xmjdsite在不存在于销售范围维护里
# Memo...........:
# Usage..........: CALL aslp201_xmjdsite_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success         TURE/FALSE
# Date & Author..: 2016/9/30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_xmjdsite_chk()
DEFINE l_sql            STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_xmjdsite       LIKE xmjd_t.xmjdsite
DEFINE l_err_cnt        LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET l_sql = ''
   LET r_success = TRUE
   LET l_err_cnt = 0   
   
   LET l_sql = " SELECT COUNT(1) ",
               "   FROM dbbc_t ",
               "  WHERE dbbcent = ",g_enterprise,
               "    AND dbbc002 = ? "
   PREPARE aslp201_dbbc_cnt FROM l_sql              
   
   LET l_sql = " SELECT xmjdsite ",
               "   FROM aslp201_tmp01 ",
               "  WHERE (xmjdsite <>'' OR xmjdsite IS NOT NULL) ",
               "  GROUP BY xmjdsite "
   PREPARE aslp201_xmjdsite_chk FROM l_sql
   DECLARE aslp201_xmjdsite_cur CURSOR FOR aslp201_xmjdsite_chk 
   FOREACH aslp201_xmjdsite_cur INTO l_xmjdsite 
      LET l_cnt = 0
      EXECUTE aslp201_dbbc_cnt USING l_xmjdsite INTO l_cnt
      IF l_cnt = 0 THEN      
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "asl-00027"
         LET g_errparam.replace[1] = l_xmjdsite
         LET g_errparam.popup  = TRUE
         CALL cl_err()         
         LET l_err_cnt = l_err_cnt + 1       
      END IF
   END FOREACH
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢核:當對象類型為[1.內部組織]時,對應的收貨成本倉(ooef123)不可為空
# Memo...........:
# Usage..........: CALL aslp201_ooef123_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: #170104-00068#2 20170105 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_ooef123_chk()
   DEFINE l_xmjdsite       LIKE xmjd_t.xmjdsite
   DEFINE l_ooef123        LIKE ooef_t.ooef123
   DEFINE l_ooefstus       LIKE ooef_t.ooefstus
   DEFINE l_sql            STRING
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_sql = " SELECT DISTINCT xmjdsite ",
               "   FROM aslp201_tmp01 ",
               "  WHERE xmjd003 = '1' ",
               "    AND (xmjdsite <>'' OR xmjdsite IS NOT NULL) "
               
   PREPARE aslp201_ooef123_chk FROM l_sql
   DECLARE aslp201_ooef123_cur CURSOR FOR aslp201_ooef123_chk 
   
   LET l_err_cnt = 0
   LET l_xmjdsite = ''
   
   FOREACH aslp201_ooef123_cur INTO l_xmjdsite
      
      LET l_ooef123 = ''
      LET l_ooefstus = ''
   
      SELECT ooef123,ooefstus INTO l_ooef123,l_ooefstus
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_xmjdsite
         
      IF cl_null(l_ooef123) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "asl-00038"   #門店: %1 對應的收貨成本倉為空，不可繼續！
         LET g_errparam.replace[1] = l_xmjdsite
         LET g_errparam.popup  = TRUE
         CALL cl_err()         
         LET l_err_cnt = l_err_cnt + 1       
      ELSE
         IF l_ooefstus != 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "asl-00040"   #門店: %1 無效，不可繼續！
            LET g_errparam.replace[1] = l_xmjdsite
            LET g_errparam.popup  = TRUE
            CALL cl_err()         
            LET l_err_cnt = l_err_cnt + 1       
         END IF
      END IF
      
      LET l_xmjdsite = ''
   END FOREACH
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF   
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 檢核:當對象類型為[2.客戶]時,對應的送貨地址(oodb019)不可為空
# Memo...........:
# Usage..........: CALL aslp201_oofb019_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: #170104-00068#2 20170105 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_oofb019_chk()
   DEFINE l_xmjd004        LIKE xmjd_t.xmjd004
   DEFINE l_oofb019        LIKE oofb_t.oofb019
   DEFINE l_oofbstus       LIKE oofb_t.oofbstus
   DEFINE l_sql            STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_sql = "SELECT DISTINCT xmjd004 ",
               "  FROM aslp201_tmp01 ",
               " WHERE xmjd003 = '2' ",
               "   AND xmjd004 IS NOT NULL "
               
   PREPARE aslp201_oofb019_chk FROM l_sql
   DECLARE aslp201_oofb019_cur CURSOR FOR aslp201_oofb019_chk 
   
   LET l_err_cnt = 0
   LET l_xmjd004 = ''
   
   FOREACH aslp201_oofb019_cur INTO l_xmjd004
      
      LET l_oofb019 = ''
      LET l_oofbstus = ''
      
      SELECT oofb019,oofbstus INTO l_oofb019,l_oofbstus
        FROM pmaa_t LEFT JOIN oofb_t ON oofbent = pmaaent AND oofb002 = pmaa027 AND oofb008 = '3' 
       WHERE pmaaent = g_enterprise
         AND pmaa001 = l_xmjd004
         AND pmaastus = 'Y'
         
      IF cl_null(l_oofb019) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "asl-00039"   #客戶: %1 對應的送貨地址為空，不可繼續！
         LET g_errparam.replace[1] = l_xmjd004
         LET g_errparam.popup  = TRUE
         CALL cl_err()         
         LET l_err_cnt = l_err_cnt + 1
      ELSE
         IF l_oofbstus != 'Y' THEN
            #若有存在其他有效的送貨地址就不報錯
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt 
              FROM pmaa_t 
                   LEFT JOIN oofb_t ON oofbent = pmaaent AND oofb002 = pmaa027 and oofb008 = '3'  
             WHERE pmaaent = g_enterprise 
               AND pmaa001 = l_xmjd004 
               AND oofbstus = 'Y'
            IF l_cnt = 0 THEN   
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "asl-00041"   #客戶: %1 的送貨地址無效，不可繼續！
               LET g_errparam.replace[1] = l_xmjd004
               LET g_errparam.popup  = TRUE
               CALL cl_err()         
               LET l_err_cnt = l_err_cnt + 1
            END IF
         END IF
      END IF
      LET l_xmjd004 = ''
   END FOREACH
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生鋪貨單單頭
# Memo...........:
# Usage..........: CALL aslp201_gen_pmco_po()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success        TRUE/FALSE
# Date & Author..: 2016/9/30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_gen_pmco_po()
DEFINE l_xmjdsite      LIKE xmjd_t.xmjdsite
DEFINE l_docno         LIKE rtai_t.rtai004       #批次拋轉預設單別
DEFINE l_pmco   RECORD   
       pmcoent        LIKE   pmco_t.pmcoent,          #企業編號
       pmcostus       LIKE   pmco_t.pmcostus,         #狀態碼
       pmcosite       LIKE   pmco_t.pmcosite,         #營運據點
       pmco001        LIKE   pmco_t.pmco001,          #申請人員
       pmco002        LIKE   pmco_t.pmco002,          #申請部門
       pmco003        LIKE   pmco_t.pmco003,          #執行日期
       pmco004        LIKE   pmco_t.pmco004,          #到貨日期
       pmco005        LIKE   pmco_t.pmco005,          #備註
       pmcocrtid      LIKE   pmco_t.pmcocrtid,        #資料建立者       
       pmcoownid      LIKE   pmco_t.pmcoownid,        #資料所有者
       pmcoowndp      LIKE   pmco_t.pmcoowndp,        #資料所屬部門
       pmcocnfdt      LIKE   pmco_t.pmcocnfdt,        #資料確認日
       pmcocnfid      LIKE   pmco_t.pmcocnfid,        #資料確認者
       pmcocrtdp      LIKE   pmco_t.pmcocrtdp,        #資料建立部門
       pmcocrtdt      LIKE   pmco_t.pmcocrtdt,        #資料創建日
       pmcounit       LIKE   pmco_t.pmcounit,         #應用組織
       pmcodocdt      LIKE   pmco_t.pmcodocdt,        #單據日期
       pmcodocno      LIKE   pmco_t.pmcodocno,        #鋪貨單號
       pmcomoddt      LIKE   pmco_t.pmcomoddt,        #最近修改日
       pmcomodid      LIKE   pmco_t.pmcomodid         #資料修改者       
                         END RECORD
DEFINE l_sql          STRING
DEFINE l_err_cnt      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_errno        LIKE type_t.chr10
DEFINE r_success      LIKE type_t.num5

   LET r_success = TRUE
   LET l_success = TRUE
   LET l_err_cnt = 0

   LET l_sql = " SELECT xmjdsite ",
               "   FROM aslp201_tmp01 ",
               "  WHERE (xmjdsite <>'' OR xmjdsite IS NOT NULL) ",
               "    AND xmjd003 = '1' ",
               "  GROUP BY xmjdsite "
   PREPARE aslp201_gen_pmco_pre FROM l_sql
   DECLARE aslp201_gen_pmco_cur CURSOR FOR aslp201_gen_pmco_pre
   FOREACH aslp201_gen_pmco_cur INTO l_xmjdsite
       INITIALIZE l_pmco.* TO NULL
       LET l_pmco.pmcoent        = g_enterprise       #企業編號
       LET l_pmco.pmcostus       = 'N'                #狀態碼
       LET l_pmco.pmcosite       = l_xmjdsite         #營運據點
       LET l_pmco.pmcounit       = l_xmjdsite         #應用組織
       LET l_pmco.pmcodocdt      = g_today            #單據日期

       #取單別
       LET l_success = ''
       CALL s_arti200_get_def_doc_type(l_xmjdsite,'apmt832','2')
          RETURNING l_success,l_docno
       IF l_success = FALSE THEN          
          LET l_err_cnt = l_err_cnt + 1
          CONTINUE FOREACH
       END IF
       
       #產生單號
       LET l_success = ''
       CALL s_aooi200_gen_docno(l_xmjdsite,l_docno,l_pmco.pmcodocdt,'apmt832')
          RETURNING l_success,l_pmco.pmcodocno
       IF l_success = FALSE THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00003'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_err_cnt = l_err_cnt + 1
          CONTINUE FOREACH
       END IF       
       
       LET l_pmco.pmco001        = g_user             #申請人員
       LET l_pmco.pmco002        = g_dept             #申請部門
       LET l_pmco.pmco003        = g_today            #執行日期
       LET l_pmco.pmcocrtid      = g_user             #資料建立者       
       LET l_pmco.pmcoownid      = g_user             #資料所有者
       LET l_pmco.pmcoowndp      = g_dept             #資料所屬部門
       LET l_pmco.pmcocrtdp      = g_dept             #資料建立部門
       LET l_pmco.pmcocrtdt      = cl_get_current()   #資料創建日
   
       INSERT INTO pmco_t(pmcoent ,   pmcocrtid , pmcostus ,  pmcosite ,  pmcoownid ,   #企業編號 , 資料建立者 , 狀態碼 , 營運據點 , 資料所有者 
                          pmcoowndp , pmcocrtdp , pmcocrtdt , pmcodocdt , pmcodocno ,   #資料所屬部門 ,資料建立部門 , 資料創建日, 單據日期 , 鋪貨單號 
                          pmcomoddt , pmcomodid , pmco001 ,   pmco002 ,   pmco003 ,     #最近修改日 , 資料修改者, 申請人員 , 申請部門 , 執行日期
                          #pmco004 ,   pmco005,    pmcounit )                                         #到貨日期 , 備註
                          pmco005,    pmcounit )                                         #到貨日期 , 備註
       VALUES  (l_pmco.pmcoent ,  l_pmco.pmcocrtid , l_pmco.pmcostus , l_pmco.pmcosite ,  l_pmco.pmcoownid , 
                l_pmco.pmcoowndp ,l_pmco.pmcocrtdp , l_pmco.pmcocrtdt ,l_pmco.pmcodocdt , l_pmco.pmcodocno , 
                l_pmco.pmcomoddt ,l_pmco.pmcomodid , l_pmco.pmco001 ,  l_pmco.pmco002 ,   l_pmco.pmco003 ,   
                #l_pmco.pmco004 ,  l_pmco.pmco005,    l_pmco.pmcounit ) 
                l_pmco.pmco005,    l_pmco.pmcounit ) 
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Insert pmco_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_err_cnt = l_err_cnt + 1
          CONTINUE FOREACH
       END IF   
       
       #產生明細
       IF NOT aslp201_gen_pmco_detail(l_pmco.pmcodocno,l_pmco.pmcosite,l_pmco.pmcounit) THEN
          LET l_err_cnt = l_err_cnt + 1
          CONTINUE FOREACH       
       END IF
       
       #狀態審核
       CALL s_apmt832_conf_chk(l_pmco.pmcodocno) RETURNING l_success,l_errno
       IF l_success THEN
          CALL s_apmt832_conf_upd(l_pmco.pmcodocno) RETURNING l_success
          IF NOT l_success THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = l_pmco.pmcodocno
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET l_err_cnt = l_err_cnt + 1
             CONTINUE FOREACH   
          END IF
       ELSE
          IF NOT cl_null(l_errno) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = l_pmco.pmcodocno
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET l_err_cnt = l_err_cnt + 1
             CONTINUE FOREACH                
          END IF            
       END IF        
   
   END FOREACH
   
   IF NOT aslp201_xmjd017_upd('1') THEN
      LET l_err_cnt = l_err_cnt + 1   
   END IF
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL aslp201_create_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/9/30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_create_tmp()
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE   
   LET r_success = TRUE
   
   CALL aslp201_drop_tmp()
  
   CREATE TEMP TABLE aslp201_tmp01(  
   xmjdent        LIKE   xmjd_t.xmjdent,        #企業代碼
   xmjdsite       LIKE   xmjd_t.xmjdsite,       #營運據點
   xmjd001        LIKE   xmjd_t.xmjd001,        #年份
   xmjd002        LIKE   xmjd_t.xmjd002,        #訂貨季
   xmjd003        LIKE   xmjd_t.xmjd003,        #對象類型
   xmjd004        LIKE   xmjd_t.xmjd004,        #對象編號
   xmjd005        LIKE   xmjd_t.xmjd005,        #對象說明
   xmjd006        LIKE   xmjd_t.xmjd006,        #訂單單號
   xmjd007        LIKE   xmjd_t.xmjd007,        #訂單序號
   xmjd008        LIKE   xmjd_t.xmjd008,        #款號
   xmjd009        LIKE   xmjd_t.xmjd009,        #吊牌價
   xmjd010        LIKE   xmjd_t.xmjd010,        #顏色編號
   xmjd011        LIKE   xmjd_t.xmjd011,        #顏色說明
   xmjd012        LIKE   xmjd_t.xmjd012,        #尺寸編號
   xmjd013        LIKE   xmjd_t.xmjd013,        #尺寸說明
   xmjd014        LIKE   xmjd_t.xmjd014,        #轉入量
   xmjd015        LIKE   xmjd_t.xmjd015,        #調整量
   xmjd016        LIKE   xmjd_t.xmjd016,        #吊牌金額
   xmjd017        LIKE   xmjd_t.xmjd017,        #處理狀態
   xmjd018        LIKE   xmjd_t.xmjd018,        #區域
   xmjd019        LIKE   xmjd_t.xmjd019,        #代理
   xmjd020        LIKE   xmjd_t.xmjd020,        #品牌
   xmjd021        LIKE   xmjd_t.xmjd021,        #系列
   xmjd022        LIKE   xmjd_t.xmjd022,        #年齡段
   xmjd023        LIKE   xmjd_t.xmjd023,        #季節
   xmjd024        LIKE   xmjd_t.xmjd024,        #波段
   xmjd025        LIKE   xmjd_t.xmjd025,        #性別
   xmjd026        LIKE   xmjd_t.xmjd026,        #上下裝
   xmjd027        LIKE   xmjd_t.xmjd027,        #類別
   xmjd028        LIKE   xmjd_t.xmjd028,        #小類
   xmjd029        LIKE   xmjd_t.xmjd029,        #款式屬性
   xmjd030        LIKE   xmjd_t.xmjd030,        #價格帶
   xmjd031        LIKE   xmjd_t.xmjd031)        #面料 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create aslp201_tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL aslp201_drop_tmp()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/9/30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_drop_tmp()
   DEFINE l_success LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE   
   
   DROP TABLE aslp201_tmp01 
END FUNCTION

################################################################################
# Descriptions...: 產生鋪貨單明細
# Memo...........:
# Usage..........: CALL aslp201_gen_pmco_detail(p_pmcodocno,p_pmcosite,p_pmcounit)
#                  RETURNING r_success
# Input parameter: p_pmcodocno      鋪貨單號
#                : p_pmcosite       營運組織
#                : p_pmcounit       應用組織
# Return code....: r_success        TRUE/FALSE
# Date & Author..: 2016/9/30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_gen_pmco_detail(p_pmcodocno,p_pmcosite,p_pmcounit)
DEFINE p_pmcodocno          LIKE pmco_t.pmcodocno
DEFINE p_pmcosite           LIKE pmco_t.pmcosite
DEFINE p_pmcounit           LIKE pmco_t.pmcounit
DEFINE l_sql                STRING
DEFINE l_pmcpseq            LIKE pmcp_t.pmcpseq
DEFINE l_xmjd004            LIKE xmjd_t.xmjd004
DEFINE l_xmjd008            LIKE xmjd_t.xmjd008
DEFINE l_xmjd010            LIKE xmjd_t.xmjd010
DEFINE l_xmjd012            LIKE xmjd_t.xmjd012
DEFINE l_xmjd015            LIKE xmjd_t.xmjd015
DEFINE l_err_cnt            LIKE type_t.num5
DEFINE l_pmcp   RECORD   
       pmcpent        LIKE   pmcp_t.pmcpent,        #企業編號
       pmcpunit       LIKE   pmcp_t.pmcpunit,       #應用組織
       pmcpsite       LIKE   pmcp_t.pmcpsite,       #營運據點
       pmcpseq        LIKE   pmcp_t.pmcpseq,        #項次
       pmcpdocno      LIKE   pmcp_t.pmcpdocno,      #鋪貨單號
       pmcp001        LIKE   pmcp_t.pmcp001,        #商品編號
       pmcp002        LIKE   pmcp_t.pmcp002,        #商品條碼
       pmcp003        LIKE   pmcp_t.pmcp003,        #產品特徵
       pmcp004        LIKE   pmcp_t.pmcp004,        #鋪貨數量
       pmcp005        LIKE   pmcp_t.pmcp005,        #鋪貨單位
       pmcp006        LIKE   pmcp_t.pmcp006,        #鋪貨庫位
       pmcp007        LIKE   pmcp_t.pmcp007,        #需求日期
       pmcp008        LIKE   pmcp_t.pmcp008,        #需求時段
       pmcp009        LIKE   pmcp_t.pmcp009,        #包裝單位
       pmcp010        LIKE   pmcp_t.pmcp010,        #件裝數
       pmcp011        LIKE   pmcp_t.pmcp011,        #鋪貨件數
       pmcp012        LIKE   pmcp_t.pmcp012,        #供應商編號
       pmcp013        LIKE   pmcp_t.pmcp013,        #採購類型
       pmcp014        LIKE   pmcp_t.pmcp014,        #備註
       pmcp015        LIKE   pmcp_t.pmcp015         #参考单价 #add by geza 20161219 #161219-00001#1
                         END RECORD
DEFINE l_success            LIKE type_t.num5
DEFINE r_success            LIKE type_t.num5

  
   LET l_sql = ""
   LET r_success = TRUE
   LET l_pmcpseq = 0
   LET l_err_cnt = 0   
   
   #取鋪貨單位、需求日期語法
   LET l_sql = " SELECT imaa006,imaa158 ",
               "   FROM imaa_t ",
               "  WHERE imaaent = ",g_enterprise,
               "    AND imaa001 = ? "
   PREPARE aslp201_imaa_sel FROM l_sql              
   
   #取包裝單位、件裝數語法
   LET l_sql = " SELECT imay004,imay005 ",
               "   FROM imay_t ",
               "  WHERE imayent = ",g_enterprise,
               "    AND imay001 = ? ",
               "    AND imay019 = ? "
   PREPARE aslp201_imay_sel FROM l_sql
   
   #取供應商
   LET l_sql = " SELECT imaf153 ",
               "   FROM imaf_t ",
               "  WHERE imafent = ", g_enterprise,
               "    AND imafsite =  ? ",
               "    AND imaf001 =   ? "
   PREPARE aslp201_imaf_sel FROM l_sql               
   
   
   #取採購方式
   LET l_sql = " SELECT rtdx027  ",
               "   FROM rtdx_t ",
               "  WHERE rtdxent = ", g_enterprise ,
               "    AND rtdxsite =  ? ", 
               "    AND rtdx001 =  ? "
   PREPARE aslp201_rtdx_sel FROM l_sql
   
   LET l_sql = " SELECT xmjd004,xmjd008,xmjd010,xmjd012,xmjd015 ",
               "   FROM aslp201_tmp01 ",
               "  WHERE xmjdent = ",g_enterprise,
               "    AND xmjdsite = '",p_pmcosite,"'" ,              
               "    AND xmjd003 = '1' "
   PREPARE aslp201_pmcp_ins FROM l_sql
   DECLARE aslp201_pmcp_cur CURSOR FOR aslp201_pmcp_ins
   FOREACH aslp201_pmcp_cur INTO l_xmjd004,l_xmjd008,l_xmjd010,l_xmjd012,l_xmjd015 
       INITIALIZE l_pmcp.* TO NULL
       LET l_pmcp.pmcpent        = g_enterprise      #企業編號
       LET l_pmcp.pmcpunit       = p_pmcounit        #應用組織
       LET l_pmcp.pmcpsite       = l_xmjd004         #鋪貨組織
       LET l_pmcpseq = l_pmcpseq + 1
       LET l_pmcp.pmcpseq        = l_pmcpseq         #項次
       LET l_pmcp.pmcpdocno      = p_pmcodocno       #鋪貨單號
       LET l_pmcp.pmcp001        = l_xmjd008         #商品編號
       LET l_pmcp.pmcp002        = ''                #商品條碼
       LET l_pmcp.pmcp003        = l_xmjd010,'_',l_xmjd012      #產品特徵
       LET l_pmcp.pmcp004        = l_xmjd015         #鋪貨數量
       EXECUTE aslp201_imaa_sel USING l_xmjd008 INTO l_pmcp.pmcp005,l_pmcp.pmcp007                  #鋪貨單位,需求日期
       EXECUTE aslp201_imay_sel USING l_xmjd008,l_pmcp.pmcp003 INTO l_pmcp.pmcp009,l_pmcp.pmcp010   #包裝單位,件裝數
       #換算鋪貨件數      
       IF NOT cl_null(l_pmcp.pmcp005) AND NOT cl_null(l_pmcp.pmcp004) THEN 
          CALL s_aooi250_convert_qty(l_pmcp.pmcp001,l_pmcp.pmcp005,l_pmcp.pmcp009,l_pmcp.pmcp004)
              RETURNING l_success,l_pmcp.pmcp011
       END IF
       EXECUTE aslp201_imaf_sel USING l_pmcp.pmcpsite,l_pmcp.pmcp001 INTO l_pmcp.pmcp012   #供應商編號
       EXECUTE aslp201_rtdx_sel USING l_pmcp.pmcpsite,l_pmcp.pmcp001 INTO l_pmcp.pmcp013   #採購類型  
       LET l_pmcp.pmcp014        =  ''     #備註 
       #161128-00017#1 -s by 08172
       #取铺货库位
       SELECT ooef123 INTO l_pmcp.pmcp006
         FROM ooef_t
        WHERE ooefent = g_enterprise
          AND ooef001 = l_pmcp.pmcpsite 
          AND ooefstus = 'Y'
       #161128-00017#1 -s by 08172
       
       SELECT imaa116 INTO l_pmcp.pmcp015 #add by geza 20161219 #161219-00001#1
         FROM imaa_t
        WHERE imaaent = g_enterprise
          AND imaa001 = l_pmcp.pmcp001
       INSERT INTO pmcp_t(pmcpent , pmcpunit , pmcpsite , pmcpseq , pmcpdocno ,    #企業編號 , 應用組織 , 營運據點 , 項次 , 鋪貨單號
                          pmcp001 , pmcp002 , pmcp003 , pmcp004 , pmcp005 ,    #商品編號 , 商品條碼 , 產品特徵 , 鋪貨數量 , 鋪貨單位
                          pmcp006 , pmcp007 , pmcp008 , pmcp009 , pmcp010 ,    #鋪貨庫位 , 需求日期 , 需求時段 , 包裝單位 , 件裝數
                          pmcp011 , pmcp012 , pmcp013 , pmcp014 , pmcp015) #add by geza 20161219 #161219-00001#1 pmcp015
       VALUES  (l_pmcp.pmcpent , l_pmcp.pmcpunit ,l_pmcp.pmcpsite ,l_pmcp.pmcpseq , l_pmcp.pmcpdocno , 
                l_pmcp.pmcp001 , l_pmcp.pmcp002 , l_pmcp.pmcp003 , l_pmcp.pmcp004 , l_pmcp.pmcp005 , 
                l_pmcp.pmcp006 , l_pmcp.pmcp007 , l_pmcp.pmcp008 , l_pmcp.pmcp009 , l_pmcp.pmcp010 ,
                l_pmcp.pmcp011 , l_pmcp.pmcp012 , l_pmcp.pmcp013 , l_pmcp.pmcp014 , l_pmcp.pmcp015 ) #add by geza 20161219 #161219-00001#1 pmcp015
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Insert pmco_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_err_cnt = l_err_cnt + 1
       END IF                 
   
   END FOREACH

   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新xmjd017處理狀態為3已轉出
# Memo...........:
# Usage..........: CALL aslp201_xmjd017_upd(p_xmjd003)
#                  RETURNING r_success
# Input parameter: p_xmjd003      對象類型         
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/10/1 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_xmjd017_upd(p_xmjd003)
DEFINE p_xmjd003         LIKE xmjd_t.xmjd003
DEFINE l_sql             STRING
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_sql = " UPDATE xmjd_t SET xmjd017 = '3' ",
               "  WHERE xmjdent = ",g_enterprise,
               "    AND EXISTS(SELECT 1 FROM aslp201_tmp01 t1 ",
               "                WHERE xmjdent = t1.xmjdent ",
               "                  AND xmjdsite = t1.xmjdsite ",
               "                  AND xmjd001 = t1.xmjd001 ",
               "                  AND xmjd002 = t1.xmjd002 ",
               "                  AND xmjd003 = t1.xmjd003 ",
               "                  AND xmjd004 = t1.xmjd004 ",
               "                  AND xmjd008 = t1.xmjd008 ",
               "                  AND xmjd010 = t1.xmjd010 ",
               "                  AND xmjd012 = t1.xmjd012 ",
               "                  AND t1.xmjd003 = '",p_xmjd003,"' )",
               "    AND xmjd003 = '",p_xmjd003,"' "
   
   #161215-00086#1  add by yany 2016/12/16 --str
   IF NOT cl_null(g_qbe.xmjd001) THEN
      LET l_sql = l_sql CLIPPED," AND xmjd001 = ",g_qbe.xmjd001
   END IF
   IF NOT cl_null(g_qbe.xmjd002) THEN
      LET l_sql = l_sql CLIPPED," AND xmjd002 = '",g_qbe.xmjd002,"'"
   END IF
   IF NOT cl_null(g_qbe.xmjd004) THEN
      LET l_sql = l_sql CLIPPED," AND xmjd004 = '",g_qbe.xmjd004,"'"
   END IF
   #161215-00086#1  add by yany 2016/12/16 --end
   
   PREPARE aslp201_xmjd017_upd FROM l_sql
   EXECUTE aslp201_xmjd017_upd
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Insert pmco_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF      
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生訂單單頭資料
# Memo...........:
# Usage..........: CALL aslp201_gen_xmda_po()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2016/10/1 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_gen_xmda_po()
DEFINE l_xmjdsite      LIKE xmjd_t.xmjdsite
DEFINE l_xmjd004       LIKE xmjd_t.xmjd004
DEFINE l_docno         LIKE rtai_t.rtai004       #批次拋轉預設單別
DEFINE l_dbbc003       LIKE dbbc_t.dbbc003       #通路編號
DEFINE l_dbbc005       LIKE dbbc_t.dbbc005       #辦事處編號
DEFINE l_hold          LIKE type_t.num5
DEFINE l_oodbl004      LIKE oodbl_t.oodbl004     #稅別名稱
DEFINE l_oodb005       LIKE oodb_t.oodb005       #含稅否
DEFINE l_oodb006       LIKE oodb_t.oodb006       #稅率 
DEFINE l_oodb011       LIKE oodb_t.oodb011       #取得稅別類型1:正常稅率2:依料件設定 
DEFINE l_oofb022       LIKE oofb_t.oofb022
DEFINE l_pmaa004       LIKE pmaa_t.pmaa004 
DEFINE  l_xrcd113      LIKE xrcd_t.xrcd113
DEFINE  l_xrcd114      LIKE xrcd_t.xrcd114
DEFINE  l_xrcd115      LIKE xrcd_t.xrcd115 
DEFINE   l_xmda   RECORD   
xmdaent        LIKE   xmda_t.xmdaent,        #企業編號
xmdasite       LIKE   xmda_t.xmdasite,       #營運據點
xmdaunit       LIKE   xmda_t.xmdaunit,       #發貨組織
xmdadocdt      LIKE   xmda_t.xmdadocdt,      #訂單日期
xmdadocno      LIKE   xmda_t.xmdadocno,      #訂單單號
xmda001        LIKE   xmda_t.xmda001,        #版次
xmda002        LIKE   xmda_t.xmda002,        #業務人員
xmda003        LIKE   xmda_t.xmda003,        #業務部門
xmda004        LIKE   xmda_t.xmda004,        #客戶編號
xmda005        LIKE   xmda_t.xmda005,        #訂單性質
xmda006        LIKE   xmda_t.xmda006,        #多角性質
xmda007        LIKE   xmda_t.xmda007,        #資料來源
xmda008        LIKE   xmda_t.xmda008,        #來源單號
xmda009        LIKE   xmda_t.xmda009,        #收款條件
xmda010        LIKE   xmda_t.xmda010,        #交易條件
xmda011        LIKE   xmda_t.xmda011,        #稅別
xmda012        LIKE   xmda_t.xmda012,        #稅率
xmda013        LIKE   xmda_t.xmda013,        #單價含稅否
xmda015        LIKE   xmda_t.xmda015,        #幣別
xmda016        LIKE   xmda_t.xmda016,        #匯率
xmda017        LIKE   xmda_t.xmda017,        #取價方式
xmda018        LIKE   xmda_t.xmda018,        #收款優惠條件
xmda019        LIKE   xmda_t.xmda019,        #納入 MPS/MRP計算
xmda020        LIKE   xmda_t.xmda020,        #運送方式
xmda021        LIKE   xmda_t.xmda021,        #帳款客戶
xmda022        LIKE   xmda_t.xmda022,        #收貨客戶
xmda023        LIKE   xmda_t.xmda023,        #銷售通路
xmda024        LIKE   xmda_t.xmda024,        #銷售分類二
xmda025        LIKE   xmda_t.xmda025,        #出貨地址
xmda026        LIKE   xmda_t.xmda026,        #帳款地址
xmda027        LIKE   xmda_t.xmda027,        #客戶連絡人
xmda028        LIKE   xmda_t.xmda028,        #一次性交易對象識別碼
xmda029        LIKE   xmda_t.xmda029,        #出貨部門
xmda030        LIKE   xmda_t.xmda030,        #多角貿易已拋轉
xmda031        LIKE   xmda_t.xmda031,        #多角序號
xmda032        LIKE   xmda_t.xmda032,        #留置原因
xmda033        LIKE   xmda_t.xmda033,        #客戶訂購單號
xmda034        LIKE   xmda_t.xmda034,        #最終客戶
xmda035        LIKE   xmda_t.xmda035,        #發票類型
xmda036        LIKE   xmda_t.xmda036,        #送貨供應商
xmda037        LIKE   xmda_t.xmda037,        #起運點
xmda038        LIKE   xmda_t.xmda038,        #目的地
xmda039        LIKE   xmda_t.xmda039,        #預收款發票開立方式
xmda041        LIKE   xmda_t.xmda041,        #訂單總未稅金額
xmda042        LIKE   xmda_t.xmda042,        #訂單總含稅金額
xmda043        LIKE   xmda_t.xmda043,        #訂單總稅額
xmda044        LIKE   xmda_t.xmda044,        #嘜頭編號
xmda045        LIKE   xmda_t.xmda045,        #物流結案
xmda046        LIKE   xmda_t.xmda046,        #帳流結案
xmda047        LIKE   xmda_t.xmda047,        #金流結案
xmda048        LIKE   xmda_t.xmda048,        #內外銷
xmda049        LIKE   xmda_t.xmda049,        #匯率計算基準
xmda050        LIKE   xmda_t.xmda050,        #多角流程代碼
xmda051        LIKE   xmda_t.xmda051,        #多角最終站
xmda071        LIKE   xmda_t.xmda071,        #備註
xmda200        LIKE   xmda_t.xmda200,        #調貨經銷商編號
xmda201        LIKE   xmda_t.xmda201,        #代送商編號
xmda202        LIKE   xmda_t.xmda202,        #銷售辦事處
xmda203        LIKE   xmda_t.xmda203,        #發票客戶
xmda204        LIKE   xmda_t.xmda204,        #促銷方案編號
xmda205        LIKE   xmda_t.xmda205,        #整單折扣
xmda206        LIKE   xmda_t.xmda206,        #送貨站點編號
xmda207        LIKE   xmda_t.xmda207,        #運輸路線編號
xmda208        LIKE   xmda_t.xmda208,        #地區編號
xmda209        LIKE   xmda_t.xmda209,        #縣市編號
xmda210        LIKE   xmda_t.xmda210,        #省區編號
xmda211        LIKE   xmda_t.xmda211,        #區域編號
xmda212        LIKE   xmda_t.xmda212,        #本幣含稅總金額
xmda213        LIKE   xmda_t.xmda213,         #收款完成否
xmdastus       LIKE   xmda_t.xmdastus,        #狀態碼
xmdacrtdp      LIKE   xmda_t.xmdacrtdp,        #資料建立部門
xmdacrtdt      LIKE   xmda_t.xmdacrtdt,        #資料創建日
xmdacrtid      LIKE   xmda_t.xmdacrtid,        #資料建立者
xmdaowndp      LIKE   xmda_t.xmdaowndp,        #資料所屬部門
xmdaownid      LIKE   xmda_t.xmdaownid,        #資料所有者
xmdamodid      LIKE　 xmda_t.xmdamodid,
xmdamoddt      LIKE   xmda_t.xmdamoddt
                         END RECORD
DEFINE l_sql          STRING
DEFINE l_err_cnt      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_errno        LIKE type_t.chr10
DEFINE r_success      LIKE type_t.num5

   LET r_success = TRUE
   LET l_success = TRUE
   LET l_err_cnt = 0
   
   #取銷售通路、辦事處資料
   LET l_sql = " SELECT dbbc003,dbbc005 ",
               "   FROM dbbc_t ",
               "  WHERE dbbcent = ",g_enterprise,
               "    AND dbbc002 = ? ",
               "  ORDER BY dbbc001 "
   PREPARE aslp201_dbcc_pre1 FROM l_sql  
   DECLARE aslp201_dbcc_cur1 SCROLL CURSOR FOR aslp201_dbcc_pre1  
  
   #取客戶資料
   LET l_sql = " SELECT pmab087,pmab103,pmab084,pmab083,pmab104, ",  #收款條件,交易條件,稅別,幣別,取價方式
               "        pmab090,pmab089,pmab087,pmab106  ",          #運送方式,銷售分類二,收款優惠條件,發票類型                              
               "   FROM pmab_t ",
               "  WHERE pmabent = ",g_enterprise ,
               "    AND pmabsite = 'ALL' ",
               "    AND pmab001 = ? "
   PREPARE aslp201_pmab_pre1 FROM l_sql 
   
   LET l_sql = " SELECT pmaa241,pmaa242,pmaa243,pmaa244,pmaa231,pmaa004 ",     #區域編號,省區編號,縣市編號,地區編號,銷售通路,法人類型 
               "   FROM pmaa_t ",
               "  WHERE pmaaent = ", g_enterprise,
               "    AND pmaa001 = ? "
   PREPARE aslp201_pmaa_pre1 FROM l_sql     

   #取客戶聯絡人
   LET l_sql = " SELECT pmaj002 ",
               "   FROM pmaj_t ",
               "  WHERE pmajent = ",g_enterprise, 
               "    AND pmaj001 = ? ",
               "    AND pmajstus = 'Y' AND pmaj004 = 'Y' "
   PREPARE aslp201_pmaj_pre1 FROM l_sql   

   
   LET l_sql = " SELECT xmjdsite,xmjd004 ",
               "   FROM aslp201_tmp01 ",
               "  WHERE (xmjdsite <>'' OR xmjdsite IS NOT NULL) ",
               "    AND xmjd003 = '2' ",
               "  GROUP BY xmjdsite,xmjd004 ",
               "  ORDER BY xmjdsite,xmjd004 "
   PREPARE aslp201_gen_xmda_pre FROM l_sql
   DECLARE aslp201_gen_xmda_cur CURSOR FOR aslp201_gen_xmda_pre
   FOREACH aslp201_gen_xmda_cur INTO l_xmjdsite,l_xmjd004  
      INITIALIZE l_xmda.* TO NULL
      LET l_xmda.xmdaent        = g_enterprise      #企業編號
      LET l_xmda.xmdasite       = l_xmjdsite        #營運據點
      LET l_xmda.xmdaunit       = ''                #發貨組織
      LET l_xmda.xmdadocdt      = g_today           #訂單日期
      
      #取單別
      LET l_success = ''
      CALL s_arti200_get_def_doc_type(l_xmjdsite,'adbt500','2')
         RETURNING l_success,l_docno
      IF l_success = FALSE THEN          
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF
      
      #產生單號
      LET l_success = ''
      CALL s_aooi200_gen_docno(l_xmjdsite,l_docno,l_xmda.xmdadocdt,'adbt500')
         RETURNING l_success,l_xmda.xmdadocno      #訂單單號
      IF l_success = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF         
        
      LET l_xmda.xmda001        = 0                 #版次
      LET l_xmda.xmda002        = g_user            #業務人員
      LET l_xmda.xmda003        = g_dept            #業務部門
      LET l_xmda.xmda004        = l_xmjd004         #客戶編號
      LET l_xmda.xmda048        = '1'               #內外銷
      LET l_xmda.xmda049        = '1'               #匯率計算基準      
      
      #取客戶相關資料
      EXECUTE aslp201_pmab_pre1 USING l_xmda.xmda004
         INTO l_xmda.xmda009,l_xmda.xmda010,l_xmda.xmda011,l_xmda.xmda015,l_xmda.xmda017,  #收款條件,交易條件,稅別,幣別,取價方式
              l_xmda.xmda020,l_xmda.xmda024,l_xmda.xmda018,l_xmda.xmda035                  #運送方式,銷售分類二,收款優惠條件,發票類型
      
      EXECUTE aslp201_pmaa_pre1 USING l_xmda.xmda004 
         INTO l_xmda.xmda211,l_xmda.xmda210,l_xmda.xmda209,l_xmda.xmda208,l_xmda.xmda023,l_pmaa004   #區域編號,省區編號,縣市編號,地區編號,銷售通路,法人類型

      #取稅率、單價含稅否
      IF NOT cl_null(l_xmda.xmda011) THEN
         CALL s_tax_chk(l_xmda.xmdasite,l_xmda.xmda011)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         IF l_success THEN
            LET l_xmda.xmda012 = l_oodb006   #稅率
            LET l_xmda.xmda013 = l_oodb005   #單價含稅否              
         END IF         
      END IF
      IF cl_null(l_xmda.xmda012) THEN
         LET l_xmda.xmda012 = 0
      END IF
      IF cl_null(l_xmda.xmda013) THEN
         LET l_xmda.xmda013 = 'N'
      END IF
      
      #取匯率
      IF NOT cl_null(l_xmda.xmda015) THEN
         CALL s_adb_get_exchange(l_xmda.xmdasite,l_xmda.xmda048,l_xmda.xmda015) RETURNING l_errno,l_xmda.xmda016
      END IF 
      IF cl_null(l_xmda.xmda016) THEN
         LET l_xmda.xmda016 = 0
      END IF
      
      LET l_xmda.xmda005        = '1'               #訂單性質
      LET l_xmda.xmda006        = '1'               #多角性質
      LET l_xmda.xmda007        = '10'              #資料來源
      #取銷售通路,銷售辦事處
      OPEN aslp201_dbcc_cur1 USING l_xmjdsite
      FETCH FIRST aslp201_dbcc_cur1 INTO l_xmda.xmda023,l_xmda.xmda202  #銷售通路,銷售辦事處
      LET l_xmda.xmda034        = l_xmjd004         #最終客戶  
      LET l_xmda.xmda039        = '1'               #預收款發票開立方式       
      LET l_xmda.xmda008        = ''                #來源單號
      LET l_xmda.xmda019        = 'Y'               #納入 MPS/MRP計算      
      CALL s_adb_get_pmac002(l_xmda.xmda004,'1','') RETURNING l_xmda.xmda021   #帳款客戶       
      CALL s_adb_get_pmac002(l_xmda.xmda004,'2','') RETURNING l_xmda.xmda022   #收貨客戶       
      CALL s_adb_address_default('3',l_xmda.xmda022) RETURNING l_xmda.xmda025,l_xmda.xmda206,l_xmda.xmda207   #出貨地址,送貨站點編號,運輸路線編號      
      CALL s_adb_main_address('5',l_xmda.xmda021) RETURNING l_xmda.xmda026,l_oofb022    #帳款地址     
      EXECUTE aslp201_pmaj_pre1 USING l_xmda.xmda004 INTO l_xmda.xmda027       #客戶連絡人     
      #一次性交易對象識別碼
      IF l_pmaa004 = '2' THEN   #一次性交易對象
         CALL apmi004_01('1','',l_xmda.xmda004,l_xmda.xmdadocno) RETURNING l_xmda.xmda028
      END IF
      IF l_pmaa004 = '4' THEN   #內部員工
         CALL apmi004_01('2','',l_xmda.xmda004,l_xmda.xmdadocno) RETURNING l_xmda.xmda028
      END IF              
      LET l_xmda.xmda029        = ''                #出貨部門
      LET l_xmda.xmda030        = 'N'               #多角貿易已拋轉
      LET l_xmda.xmda031        = ''                #多角序號
      LET l_xmda.xmda032        = ''                #留置原因
      LET l_xmda.xmda033        = ''                #客戶訂購單號
      LET l_xmda.xmda036        = ''                #送貨供應商
      LET l_xmda.xmda037        = ''                #起運點
      LET l_xmda.xmda038        = ''                #目的地
      LET l_xmda.xmda041        = 0                 #訂單總未稅金額
      LET l_xmda.xmda042        = 0                 #訂單總含稅金額
      LET l_xmda.xmda043        = 0                 #訂單總稅額
      LET l_xmda.xmda044        = ''                #嘜頭編號
      LET l_xmda.xmda045        = 'N'               #物流結案
      LET l_xmda.xmda046        = 'N'               #帳流結案
      LET l_xmda.xmda047        = 'N'               #金流結案
      LET l_xmda.xmda050        = ''                #多角流程代碼
      LET l_xmda.xmda051        = ''                #多角最終站
      LET l_xmda.xmda071        = ''                #備註
      LET l_xmda.xmda200        = ''                #調貨經銷商編號
      LET l_xmda.xmda201        = ''                #代送商編號
      CALL s_adb_get_pmac002(l_xmda.xmda004,'3','') RETURNING l_xmda.xmda203   #發票客戶    
      LET l_xmda.xmda204        = ''                #促銷方案編號
      LET l_xmda.xmda205        = 100               #整單折扣
      LET l_xmda.xmda212        = 0                 #本幣含稅總金額
      LET l_xmda.xmda213        = "N"               #收款完成否               
      LET l_xmda.xmdaownid      = g_user            #資料所有者
      LET l_xmda.xmdaowndp      = g_dept            #資料所屬部門
      LET l_xmda.xmdacrtid      = g_user            #資料建立者
      LET l_xmda.xmdacrtdp      = g_dept            #資料建立部門
      LET l_xmda.xmdacrtdt      = cl_get_current()  #資料創建日
      LET l_xmda.xmdamodid      = g_user
      LET l_xmda.xmdamoddt      = cl_get_current()
      LET l_xmda.xmdastus       = 'N'                #狀態碼      
      
      INSERT INTO xmda_t(
      xmdaent , xmdaunit , xmdacrtdp , xmdacrtdt , xmdacrtid , xmdadocdt ,    #企業編號 , 發貨組織 , 資料建立部門 , 資料創建日 , 資料建立者 , 訂單日期
      xmdadocno , xmdamoddt , xmdamodid , xmdaowndp ,    #訂單單號 , 最近修改日 , 資料修改者 , 資料所屬部門
      xmdaownid , xmdasite , xmdastus ,    #資料所有者 , 營運據點 , 狀態碼
      xmda001 , xmda002 , xmda003 , xmda004 , xmda005 ,    #版次 , 業務人員 , 業務部門 , 客戶編號 , 訂單性質
      xmda006 , xmda007 , xmda008 , xmda009 , xmda010 ,    #多角性質 , 資料來源 , 來源單號 , 收款條件 , 交易條件
      xmda011 , xmda012 , xmda013 , xmda015 , xmda016 ,    #稅別 , 稅率 , 單價含稅否 , 幣別 , 匯率
      xmda017 , xmda018 , xmda019 , xmda020 , xmda021 ,    #取價方式 , 收款優惠條件 , 納入 MPS/MRP計算 , 運送方式 , 帳款客戶
      xmda022 , xmda023 , xmda024 , xmda025 , xmda026 ,    #收貨客戶 , 銷售通路 , 銷售分類二 , 出貨地址 , 帳款地址
      xmda027 , xmda028 , xmda029 , xmda030 , xmda031 ,    #客戶連絡人 , 一次性交易對象識別碼 , 出貨部門 , 多角貿易已拋轉 , 多角序號
      xmda032 , xmda033 , xmda034 , xmda035 , xmda036 ,    #留置原因 , 客戶訂購單號 , 最終客戶 , 發票類型 , 送貨供應商
      xmda037 , xmda038 , xmda039 , xmda041 , xmda042 ,    #起運點 , 目的地 , 預收款發票開立方式 , 訂單總未稅金額 , 訂單總含稅金額
      xmda043 , xmda044 , xmda045 , xmda046 , xmda047 ,    #訂單總稅額 , 嘜頭編號 , 物流結案 , 帳流結案 , 金流結案
      xmda048 , xmda049 , xmda050 , xmda051 , xmda071 ,    #內外銷 , 匯率計算基準 , 多角流程代碼 , 多角最終站 , 備註
      xmda200 , xmda201 , xmda202 , xmda203 , xmda204 ,    #調貨經銷商編號 , 代送商編號 , 銷售辦事處 , 發票客戶 , 促銷方案編號
      xmda205 , xmda206 , xmda207 , xmda208 , xmda209 ,    #整單折扣 , 送貨站點編號 , 運輸路線編號 , 地區編號 , 縣市編號
      xmda210 , xmda211 )                                  #省區編號 , 區域編號
      VALUES  (
      l_xmda.xmdaent ,   l_xmda.xmdaunit ,  l_xmda.xmdacrtdp , l_xmda.xmdacrtdt , l_xmda.xmdacrtid , l_xmda.xmdadocdt , 
      l_xmda.xmdadocno , l_xmda.xmdamoddt , l_xmda.xmdamodid , l_xmda.xmdaowndp ,        
      l_xmda.xmdaownid , l_xmda.xmdasite ,  l_xmda.xmdastus ,                            
      l_xmda.xmda001 ,   l_xmda.xmda002 ,   l_xmda.xmda003 ,   l_xmda.xmda004 ,   l_xmda.xmda005 , 
      l_xmda.xmda006 ,   l_xmda.xmda007 ,   l_xmda.xmda008 ,   l_xmda.xmda009 ,   l_xmda.xmda010 , 
      l_xmda.xmda011 ,   l_xmda.xmda012 ,   l_xmda.xmda013 ,   l_xmda.xmda015 ,   l_xmda.xmda016 , 
      l_xmda.xmda017 ,   l_xmda.xmda018 ,   l_xmda.xmda019 ,   l_xmda.xmda020 ,   l_xmda.xmda021 , 
      l_xmda.xmda022 ,   l_xmda.xmda023 ,   l_xmda.xmda024 ,   l_xmda.xmda025 ,   l_xmda.xmda026 , 
      l_xmda.xmda027 ,   l_xmda.xmda028 ,   l_xmda.xmda029 ,   l_xmda.xmda030 ,   l_xmda.xmda031 , 
      l_xmda.xmda032 ,   l_xmda.xmda033 ,   l_xmda.xmda034 ,   l_xmda.xmda035 ,   l_xmda.xmda036 , 
      l_xmda.xmda037 ,   l_xmda.xmda038 ,   l_xmda.xmda039 ,   l_xmda.xmda041 ,   l_xmda.xmda042 , 
      l_xmda.xmda043 ,   l_xmda.xmda044 ,   l_xmda.xmda045 ,   l_xmda.xmda046 ,   l_xmda.xmda047 , 
      l_xmda.xmda048 ,   l_xmda.xmda049 ,   l_xmda.xmda050 ,   l_xmda.xmda051 ,   l_xmda.xmda071 , 
      l_xmda.xmda200 ,   l_xmda.xmda201 ,   l_xmda.xmda202 ,   l_xmda.xmda203 ,   l_xmda.xmda204 , 
      l_xmda.xmda205 ,   l_xmda.xmda206 ,   l_xmda.xmda207 ,   l_xmda.xmda208 ,   l_xmda.xmda209 ,
      l_xmda.xmda210 ,   l_xmda.xmda211 )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert xmda_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF  
      
      #產生明細
      IF NOT aslp201_gen_xmda_detail(l_xmda.xmdadocno,l_xmda.xmdasite,l_xmda.xmdaunit) THEN
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH      
      END IF
      
      #計算單頭相關金額
      CALL s_tax_recount(l_xmda.xmdadocno)
        RETURNING l_xmda.xmda041,l_xmda.xmda043,l_xmda.xmda042,l_xrcd113,l_xrcd114,l_xrcd115
      IF cl_null(l_xmda.xmda041) THEN
         LET l_xmda.xmda041 = 0
      END IF
      IF cl_null(l_xmda.xmda042) THEN
         LET l_xmda.xmda042 = 0
      END IF
      IF cl_null(l_xmda.xmda043) THEN
         LET l_xmda.xmda043 = 0
      END IF
      UPDATE xmda_t SET xmda041 = l_xmda.xmda041,
                        xmda042 = l_xmda.xmda042,
                        xmda043 = l_xmda.xmda043
        WHERE xmdaent = g_enterprise AND xmdadocno = l_xmda.xmdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmda_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH 
      END IF      
      
      #審核前檢查
      CALL s_adbt500_conf_chk(l_xmda.xmdadocno) RETURNING l_success
      IF NOT l_success THEN
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH 
      ELSE
         CALL s_adbt500_conf_upd(l_xmda.xmdadocno) RETURNING l_success,l_hold   
         IF NOT l_success THEN
            LET l_err_cnt = l_err_cnt + 1
            CONTINUE FOREACH 
         END IF
      END IF                                                 
 
   END FOREACH
   
   IF NOT aslp201_xmjd017_upd('2') THEN
      LET l_err_cnt = l_err_cnt + 1   
   END IF
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生訂單明細資料
# Memo...........:
# Usage..........: CALL aslp201_gen_xmda_detail(p_xmdadocno,p_xmdasite,p_xmdaunit)
#                  RETURNING r_success
# Input parameter: p_xmdadocno    訂單單號
#                : p_xmdasite     營運組織
#                : p_xmdaunit     發貨組織
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/10/1 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aslp201_gen_xmda_detail(p_xmdadocno,p_xmdasite,p_xmdaunit)
DEFINE p_xmdadocno          LIKE xmda_t.xmdadocno
DEFINE p_xmdasite           LIKE xmda_t.xmdasite
DEFINE p_xmdaunit           LIKE xmda_t.xmdaunit
DEFINE l_xmdadocdt          LIKE xmda_t.xmdadocdt
DEFINE l_xmda004            LIKE xmda_t.xmda004
DEFINE l_xmda011            LIKE xmda_t.xmda011
DEFINE l_xmda012            LIKE xmda_t.xmda012
DEFINE l_xmda015            LIKE xmda_t.xmda015
DEFINE l_xmda016            LIKE xmda_t.xmda016
DEFINE l_xmda024            LIKE xmda_t.xmda024
DEFINE l_xmda022            LIKE xmda_t.xmda022
DEFINE l_xmda025            LIKE xmda_t.xmda025
DEFINE l_xmda201            LIKE xmda_t.xmda201
DEFINE l_xmda208            LIKE xmda_t.xmda208     #地區編號
DEFINE l_xmda209            LIKE xmda_t.xmda209     #縣市編號
DEFINE l_xmda210            LIKE xmda_t.xmda210     #省區編號
DEFINE l_xmda211            LIKE xmda_t.xmda211     #區域編號
DEFINE l_xmda023            LIKE xmda_t.xmda023
DEFINE l_xmda206            LIKE xmda_t.xmda206
DEFINE l_xmjd006            LIKE xmjd_t.xmjd006
DEFINE l_xmjd007            LIKE xmjd_t.xmjd007
DEFINE l_xmjd008            LIKE xmjd_t.xmjd008
DEFINE l_xmjd009            LIKE xmjd_t.xmjd009
DEFINE l_xmjd010            LIKE xmjd_t.xmjd010
DEFINE l_xmjd012            LIKE xmjd_t.xmjd012
DEFINE l_xmjd015            LIKE xmjd_t.xmjd015
DEFINE l_xmjd016            LIKE xmjd_t.xmjd016
DEFINE l_xmjd031            LIKE xmjd_t.xmjd031
DEFINE l_xmjaseq            LIKE xmja_t.xmjaseq
DEFINE l_xrcd103            LIKE xrcd_t.xrcd103
DEFINE l_xrcd104            LIKE xrcd_t.xrcd104
DEFINE l_xrcd105            LIKE xrcd_t.xrcd105
DEFINE l_xrcd113            LIKE xrcd_t.xrcd113
DEFINE l_xrcd114            LIKE xrcd_t.xrcd114
DEFINE l_xrcd115            LIKE xrcd_t.xrcd115
DEFINE l_xrcd123            LIKE xrcd_t.xrcd113
DEFINE l_xrcd124            LIKE xrcd_t.xrcd114
DEFINE l_xrcd125            LIKE xrcd_t.xrcd115
DEFINE l_xrcd133            LIKE xrcd_t.xrcd113
DEFINE l_xrcd134            LIKE xrcd_t.xrcd114
DEFINE l_xrcd135            LIKE xrcd_t.xrcd115
DEFINE l_oodbl004           LIKE oodbl_t.oodbl004  #稅別名稱
DEFINE l_oodb005            LIKE oodb_t.oodb005    #含稅否
DEFINE l_oodb006            LIKE oodb_t.oodb006    #稅率 
DEFINE l_oodb011            LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定 
DEFINE l_sql                STRING
DEFINE   l_xmja   RECORD   
xmjaent        LIKE   xmja_t.xmjaent,        #企業編號
xmjaunit       LIKE   xmja_t.xmjaunit,        #應用組織
xmjasite       LIKE   xmja_t.xmjasite,        #營運據點
xmjaseq        LIKE   xmja_t.xmjaseq,        #項次
xmjadocno      LIKE   xmja_t.xmjadocno,        #單據編號
xmja001        LIKE   xmja_t.xmja001,        #交易類型
xmja002        LIKE   xmja_t.xmja002,        #商品條碼
xmja003        LIKE   xmja_t.xmja003,        #商品編號
xmja004        LIKE   xmja_t.xmja004,        #產品特徵
xmja005        LIKE   xmja_t.xmja005,        #促銷方案
xmja006        LIKE   xmja_t.xmja006,        #稅別編號
xmja007        LIKE   xmja_t.xmja007,        #稅率
xmja008        LIKE   xmja_t.xmja008,        #標準售價
xmja009        LIKE   xmja_t.xmja009,        #促銷價
xmja010        LIKE   xmja_t.xmja010,        #交易價
xmja011        LIKE   xmja_t.xmja011,        #包裝單位
xmja012        LIKE   xmja_t.xmja012,        #包裝數量
xmja013        LIKE   xmja_t.xmja013,        #銷售單位
xmja014        LIKE   xmja_t.xmja014,        #銷售數量
xmja015        LIKE   xmja_t.xmja015,        #參考單位
xmja016        LIKE   xmja_t.xmja016,        #參考數量
xmja017        LIKE   xmja_t.xmja017,        #計價單位
xmja018        LIKE   xmja_t.xmja018,        #計價數量
xmja019        LIKE   xmja_t.xmja019,        #未稅金額
xmja020        LIKE   xmja_t.xmja020,        #稅額
xmja021        LIKE   xmja_t.xmja021,        #含稅金額
xmja022        LIKE   xmja_t.xmja022,        #折價金額
xmja024        LIKE   xmja_t.xmja024,        #收貨網點
xmja025        LIKE   xmja_t.xmja025,        #送貨客戶
xmja026        LIKE   xmja_t.xmja026,        #送貨地址碼
xmja027        LIKE   xmja_t.xmja027,        #送貨站點
xmja028        LIKE   xmja_t.xmja028,        #主合約編號
xmja029        LIKE   xmja_t.xmja029,        #協議編號
xmja030        LIKE   xmja_t.xmja030,        #多交期
xmja031        LIKE   xmja_t.xmja031,        #約定交貨日
xmja032        LIKE   xmja_t.xmja032,        #約定簽收日
xmja033        LIKE   xmja_t.xmja033,        #客戶料號
xmja034        LIKE   xmja_t.xmja034,        #備註
xmja035        LIKE   xmja_t.xmja035,        #來源促銷分配單號
xmja036        LIKE   xmja_t.xmja036,        #來源促銷分配項次
xmja037        LIKE   xmja_t.xmja037,        #地區編號
xmja038        LIKE   xmja_t.xmja038,        #縣市編號
xmja039        LIKE   xmja_t.xmja039,        #省區編號
xmja040        LIKE   xmja_t.xmja040         #區域編號
                         END RECORD
DEFINE l_err_cnt            LIKE type_t.num5
DEFINE l_success            LIKE type_t.num5
DEFINE r_success            LIKE type_t.num5
   LET l_err_cnt = 0
   LET r_success = TRUE
   LET l_xmjaseq = 0
   
   SELECT xmda004,xmda024,xmdadocdt,xmda015,
          xmda022,xmda025,xmda206,  xmda011,
          xmda012,xmda016,xmda201,  xmda023,
          xmda208,xmda209,xmda210,  xmda211
     INTO l_xmda004,l_xmda024,l_xmdadocdt,l_xmda015,
          l_xmda022,l_xmda025,l_xmda206  ,l_xmda011,
          l_xmda012,l_xmda016,l_xmda201  ,l_xmda023,
          l_xmda208,l_xmda209,l_xmda210  ,l_xmda211
     FROM xmda_t
    WHERE xmdaent = g_enterprise
      AND xmdadocno = p_xmdadocno
      
      
   #取鋪貨單位、需求日期語法,銷售計價單位,商品絛碼
   LET l_sql = " SELECT imaa006,imaa158,imaa106,imaa014 ",
               "   FROM imaa_t ",
               "  WHERE imaaent = ",g_enterprise,
               "    AND imaa001 = ? "
   PREPARE aslp201_imaa_sel1 FROM l_sql  
  
   #取包裝單位
   LET l_sql = " SELECT imay004 ",
               "   FROM imay_t ",
               "  WHERE imayent = ", g_enterprise,
               "    AND imay003 = ? "
   PREPARE aslp201_imay_sel1 FROM l_sql
   
   LET l_sql = " SELECT xmjd006,xmjd007,xmjd008,xmjd009,xmjd010, ",
               "        xmjd012,xmjd015,xmjd016,xmjd031 ",
               "   FROM aslp201_tmp01 ",
               "  WHERE xmjdent = ",g_enterprise,
               "    AND xmjdsite = '",p_xmdasite,"'" ,
               "    AND xmjd004 = '",l_xmda004,"'",               
               "    AND xmjd003 = '2' "
   PREPARE aslp201_xmja_ins FROM l_sql  
   DECLARE aslp201_xmja_cur CURSOR FOR aslp201_xmja_ins
   FOREACH aslp201_xmja_cur INTO l_xmjd006,l_xmjd007,l_xmjd008,l_xmjd009,l_xmjd010,
                                 l_xmjd012,l_xmjd015,l_xmjd016,l_xmjd031
      INITIALIZE l_xmja.* TO NULL
      LET l_xmja.xmjaent        = g_enterprise      #企業編號
      LET l_xmja.xmjaunit       = p_xmdasite        #應用組織
      LET l_xmja.xmjasite       = p_xmdasite        #營運據點
      LET l_xmjaseq = l_xmjaseq + 1      
      LET l_xmja.xmjaseq        = l_xmjaseq         #項次
      LET l_xmja.xmjadocno      = p_xmdadocno       #單據編號
      LET l_xmja.xmja001        = '1'               #交易類型
      LET l_xmja.xmja003        = l_xmjd008         #商品編號
      LET l_xmja.xmja004        = l_xmjd010,'_',l_xmjd012     #產品特徵
      
      LET l_xmja.xmja005        = ''                #促銷方案
      #mark by geza 20161219 #161219-00001#1(S)
#      LET l_xmja.xmja008        = l_xmjd009         #標準售價
#      LET l_xmja.xmja009        = l_xmjd009         #促銷價
#      LET l_xmja.xmja010        = l_xmjd009         #交易價
      #mark by geza 20161219 #161219-00001#1(E)
      #銷售單位,約定交貨日,計價單位,商品條碼
      EXECUTE aslp201_imaa_sel1 USING l_xmjd008 INTO l_xmja.xmja013,l_xmja.xmja031,l_xmja.xmja017,l_xmja.xmja002 
      #包裝單位      
      EXECUTE aslp201_imay_sel1 USING l_xmja.xmja002 INTO l_xmja.xmja011  
      LET l_xmja.xmja014        = l_xmjd015         #銷售數量
      #LET l_xmja.xmja015        = ''     #參考單位  #mark by geza 20161219 #161219-00001#1
      
      #從銷售數量推算 包裝數量,參考數量,計價數量
      #包裝數量
      IF NOT cl_null(l_xmja.xmja011) THEN
         CALL s_aooi250_convert_qty(l_xmja.xmja003,l_xmja.xmja013,l_xmja.xmja011,l_xmja.xmja014)
            RETURNING l_success,l_xmja.xmja012
      ELSE 
         LET l_xmja.xmja012 = 0
      END IF
      #mark by geza 20161219 #161219-00001#1(S)
      #參考數量
#      IF NOT cl_null(l_xmja.xmja015) THEN
#         CALL s_aooi250_convert_qty(l_xmja.xmja003,l_xmja.xmja013,l_xmja.xmja015,l_xmja.xmja014)
#            RETURNING l_success,l_xmja.xmja016
#      ELSE 
#         LET l_xmja.xmja016 = 0            
#      END IF
      #mark by geza 20161219 #161219-00001#1(E)
      #参考单位与参考数量赋值同销售单位与销售数量
      LET l_xmja.xmja015  = l_xmja.xmja013    #參考單位 #add by geza 20161219 #161219-00001#1     
      LET l_xmja.xmja016  = l_xmja.xmja014    #參考單位 #add by geza 20161219 #161219-00001#1   
      #計價數量
      IF NOT cl_null(l_xmja.xmja017) THEN
         CALL s_aooi250_convert_qty(l_xmja.xmja003,l_xmja.xmja013,l_xmja.xmja017,l_xmja.xmja014)
            RETURNING l_success,l_xmja.xmja018
      ELSE 
         LET l_xmja.xmja018 = 0             
      END IF      
     
      #mark by geza 20161219 #161219-00001#1(S)
#      LET l_xmja.xmja019        = 0                 #未稅金額
#      LET l_xmja.xmja020        = 0                 #稅額
#      LET l_xmja.xmja021        = 0                 #含稅金額
#      LET l_xmja.xmja022        = 0                 #折價金額
      #mark by geza 20161219 #161219-00001#1(E)
      LET l_xmja.xmja024        = ''                #收貨網點
      LET l_xmja.xmja025        = l_xmda022         #送貨客戶
      LET l_xmja.xmja026        = l_xmda025         #送貨地址碼
      LET l_xmja.xmja027        = l_xmda206         #送貨站點
      LET l_xmja.xmja028        = ''                #主合約編號
      LET l_xmja.xmja029        = ''                #協議編號
      LET l_xmja.xmja030        = 'N'               #多交期
      LET l_xmja.xmja032        = l_xmja.xmja031    #約定簽收日
      LET l_xmja.xmja033        = ''                #客戶料號
      LET l_xmja.xmja034        = ''                #備註
      LET l_xmja.xmja035        = l_xmjd006         #來源促銷分配單號
      LET l_xmja.xmja036        = l_xmjd007         #來源促銷分配項次
      LET l_xmja.xmja037        = l_xmda208         #地區編號
      LET l_xmja.xmja038        = l_xmda209         #縣市編號
      LET l_xmja.xmja039        = l_xmda210         #省區編號
      LET l_xmja.xmja040        = l_xmda211         #區域編號
     
        
      #單頭有稅別的話依單頭給值
      IF cl_null(l_xmda011) THEN
         #取稅別         
         CALL s_tax_chktype(p_xmdasite,l_xmda004,l_xmja.xmja003,'1',l_xmda024)
         RETURNING l_success,l_xmja.xmja006,l_xmja.xmja007
         #帶出單身稅率
         LET l_oodb006 = ''         
         CALL s_tax_chk(p_xmdasite,l_xmja.xmja006)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011     
         IF l_success THEN
            LET l_xmja.xmja007 = l_oodb006
         END IF            
      ELSE
         LET l_xmja.xmja006 = l_xmda011
         LET l_xmja.xmja007 = l_xmda012
      END IF 
      #單身金額計算          
      IF NOT cl_null(l_xmja.xmja006) AND NOT cl_null(l_xmja.xmja018) AND NOT cl_null(l_xmja.xmja010) 
         AND l_xmja.xmja018 <> 0 AND l_xmja.xmja010 <> 0 THEN
         CALL s_tax_ins(p_xmdadocno,l_xmja.xmjaseq,0,p_xmdasite,l_xmja.xmja021,
                        l_xmja.xmja006,l_xmja.xmja018,l_xmda015,l_xmda016,' ',' ',' ')
           RETURNING l_xrcd103,l_xrcd104, l_xrcd105,l_xrcd113,l_xrcd114,l_xrcd115,
                     l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
         IF cl_null(l_xrcd103) THEN LET l_xrcd103 = 0 END IF
         IF cl_null(l_xrcd104) THEN LET l_xrcd104 = 0 END IF
         IF cl_null(l_xrcd105) THEN LET l_xrcd105 = 0 END IF           
         LET l_xmja.xmja019 = l_xrcd103 
         LET l_xmja.xmja020 = l_xrcd104 
         LET l_xmja.xmja021 = l_xrcd105 
      END IF 
      #add by geza 20161219 #161219-00001#1(S) 
      #分銷取价   
      CALL s_get_price_adb('1',p_xmdadocno,l_xmdadocdt,l_xmja.xmjaseq,l_xmda004,l_xmja.xmja003,l_xmja.xmja017,l_xmja.xmja018,l_xmda015,l_xmja.xmja006,'1')
        RETURNING l_success,l_xmja.xmja008,l_xmja.xmja009,l_xmja.xmja010,l_xmja.xmja022
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
      #取得未稅金額、含稅金額、稅額
      CALL s_adbt500_get_amounts(p_xmdadocno,l_xmja.xmjaseq,p_xmdasite,l_xmda015,l_xmda016,l_xmja.xmja006,l_xmja.xmja010*l_xmja.xmja018,l_xmja.xmja018)
         RETURNING l_xmja.xmja019,l_xmja.xmja020,l_xmja.xmja021
      #add by geza 20161219 #161219-00001#1(E) 
      
      INSERT INTO xmja_t(
      xmjaent , xmjaunit , xmjasite , xmjaseq , xmjadocno ,    #企業編號 , 應用組織 , 營運據點 , 項次 , 單據編號
      xmja001 , xmja002 , xmja003 , xmja004 , xmja005 ,    #交易類型 , 商品條碼 , 商品編號 , 產品特徵 , 促銷方案
      xmja006 , xmja007 , xmja008 , xmja009 , xmja010 ,    #稅別編號 , 稅率 , 標準售價 , 促銷價 , 交易價
      xmja011 , xmja012 , xmja013 , xmja014 , xmja015 ,    #包裝單位 , 包裝數量 , 銷售單位 , 銷售數量 , 參考單位
      xmja016 , xmja017 , xmja018 , xmja019 , xmja020 ,    #參考數量 , 計價單位 , 計價數量 , 未稅金額 , 稅額
      xmja021 , xmja022 , xmja024 , xmja025 , xmja026 ,    #含稅金額 , 折價金額 , 收貨網點 , 送貨客戶 , 送貨地址碼
      xmja027 , xmja028 , xmja029 , xmja030 , xmja031 ,    #送貨站點 , 主合約編號 , 協議編號 , 多交期 , 約定交貨日
      xmja032 , xmja033 , xmja034 , xmja035 , xmja036 ,    #約定簽收日 , 客戶料號 , 備註 , 來源促銷分配單號 , 來源促銷分配項次
      xmja037 , xmja038 , xmja039 , xmja040 )              #地區編號 , 縣市編號 , 省區編號 , 區域編號     
      VALUES  (
      l_xmja.xmjaent , l_xmja.xmjaunit , l_xmja.xmjasite , l_xmja.xmjaseq , l_xmja.xmjadocno , 
      l_xmja.xmja001 , l_xmja.xmja002 ,  l_xmja.xmja003 ,  l_xmja.xmja004 , l_xmja.xmja005 , 
      l_xmja.xmja006 , l_xmja.xmja007 ,  l_xmja.xmja008 ,  l_xmja.xmja009 , l_xmja.xmja010 , 
      l_xmja.xmja011 , l_xmja.xmja012 ,  l_xmja.xmja013 ,  l_xmja.xmja014 , l_xmja.xmja015 , 
      l_xmja.xmja016 , l_xmja.xmja017 ,  l_xmja.xmja018 ,  l_xmja.xmja019 , l_xmja.xmja020 , 
      l_xmja.xmja021 , l_xmja.xmja022 ,  l_xmja.xmja024 ,  l_xmja.xmja025 , l_xmja.xmja026 , 
      l_xmja.xmja027 , l_xmja.xmja028 ,  l_xmja.xmja029 ,  l_xmja.xmja030 , l_xmja.xmja031 , 
      l_xmja.xmja032 , l_xmja.xmja033 ,  l_xmja.xmja034 ,  l_xmja.xmja035 , l_xmja.xmja036 ,
      l_xmja.xmja037 , l_xmja.xmja038 ,  l_xmja.xmja039 ,  l_xmja.xmja040 ) 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert xmja_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF        
   
      #產生订单单身档
      CALL s_adbt500_gen_xmdc(p_xmdadocno,l_xmja.xmjaseq) RETURNING l_success 
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF
       
      #產生分销订单单交期汇总档
      CALL s_adbt500_gen_xmdf(1, l_xmja.xmjaseq, -1,l_xmja.xmjasite,
                           l_xmja.xmja003, l_xmja.xmja004, l_xmja.xmja014,
                           l_xmja.xmja018, l_xmja.xmja025, l_xmja.xmja030,
                           l_xmja.xmja031, l_xmja.xmja032, l_xmja.xmja037,
                           l_xmja.xmja038, l_xmja.xmja039, l_xmja.xmja040,
                           p_xmdadocno,p_xmdaunit,l_xmda201,l_xmda023) RETURNING l_success  
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF       
       
      #產生分销订单单交期明细档
      CALL s_adbt500_gen_xmdd(p_xmdadocno,l_xmja.xmjaseq) RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmdd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF   
   
   END FOREACH
   
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 

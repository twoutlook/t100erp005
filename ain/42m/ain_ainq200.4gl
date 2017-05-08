#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-11-17 15:50:48), PR版次:0006(2016-02-24 15:55:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000109
#+ Filename...: ainq200
#+ Description: 製造批序號追蹤查詢作業
#+ Creator....: 02295(2014-07-08 14:45:26)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="ainq200.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160224-00001#1   2016/02/24 By xianghui 程序阶层抓取调整
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
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_master RECORD
   inal006 LIKE inal_t.inal006, 
   inal007 LIKE inal_t.inal007, 
   inal008 LIKE inal_t.inal008, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013
       END RECORD
 TYPE type_g_master2 RECORD
   inal006 LIKE inal_t.inal006, 
   inal007 LIKE inal_t.inal007, 
   inal008 LIKE inal_t.inal008, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013
       END RECORD       

 TYPE type_g_inal_d RECORD
   name LIKE type_t.chr500, 
   pid LIKE type_t.chr500, 
   id LIKE type_t.chr500, 
   exp LIKE type_t.chr500, 
   isnode LIKE type_t.chr500, 
   isExp LIKE type_t.chr500, 
   expcode LIKE type_t.chr500,
   inal015 LIKE inal_t.inal015,
   inal001_desc LIKE type_t.chr500,   
   inal001 LIKE inal_t.inal001, 
   inal002 LIKE inal_t.inal002,
   inal017 LIKE inal_t.inal017,    
   inal006 LIKE inal_t.inal006, 
   inal009 LIKE inal_t.inal009, 
   inal010 LIKE inal_t.inal010, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013, 
   inaj036 LIKE inaj_t.inaj036,
   inal007 LIKE inal_t.inal007,
   inal007_desc LIKE type_t.chr500,   
   inal008 LIKE inal_t.inal008,
   inaj044 LIKE inaj_t.inaj044,
   inaj018 LIKE inaj_t.inaj018   
       END RECORD
 TYPE type_g_inal2_d RECORD
   name2 LIKE type_t.chr80, 
   pid2 LIKE type_t.chr80, 
   id2 LIKE type_t.chr80, 
   exp2 LIKE type_t.chr80, 
   isnode2 LIKE type_t.chr80, 
   isExp2 LIKE type_t.chr80, 
   expcode2 LIKE type_t.chr80, 
   inal015 LIKE inal_t.inal015,
   inal001_desc LIKE type_t.chr500,    
   inal001 LIKE inal_t.inal001, 
   inal002 LIKE inal_t.inal002,
   inal017 LIKE inal_t.inal017,    
   inal006 LIKE inal_t.inal006, 
   inal009 LIKE inal_t.inal009, 
   inal010 LIKE inal_t.inal010, 
   inal011 LIKE inal_t.inal011, 
   inal012 LIKE inal_t.inal012, 
   inal013 LIKE inal_t.inal013, 
   inaj036 LIKE inaj_t.inaj036,
   inal007 LIKE inal_t.inal007,
   inal007_desc LIKE type_t.chr500,   
   inal008 LIKE inal_t.inal008,
   inaj044 LIKE inaj_t.inaj044,
   inaj018 LIKE inaj_t.inaj018 
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_master          type_g_master
DEFINE g_master_t        type_g_master
DEFINE g_master2         type_g_master2
DEFINE g_master2_t       type_g_master2
DEFINE g_inal_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE g_inal_d_t        type_g_inal_d
DEFINE g_inal2_d         DYNAMIC ARRAY OF type_g_inal2_d
DEFINE g_inal2_d_t       type_g_inal2_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc2_t              STRING
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
DEFINE li_idx               LIKE type_t.num5 
DEFINE l_type               LIKE type_t.chr500
DEFINE l_type_202           LIKE type_t.chr500
DEFINE l_type_201_301       LIKE type_t.chr500
DEFINE l_type_like1         LIKE type_t.chr500
DEFINE l_type_302           LIKE type_t.chr500
DEFINE g_idx                LIKE type_t.num5
DEFINE g_back               LIKE type_t.num5          #160224-00001#1
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="ainq200.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = " "
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE ainq200_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq200 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainq200_init()
 
      #進入選單 Menu (='N')
      CALL ainq200_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_ainq200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="ainq200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ainq200_init()
   #add-point:init段define

   #end add-point

   LET g_error_show  = 1

   #add-point:畫面資料初始化

   #end add-point

END FUNCTION

PRIVATE FUNCTION ainq200_ui_dialog()
   {<Local define>}

   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE  l_cmd      STRING
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING   
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)

   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         DISPLAY ARRAY g_inal_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_inal_d.getLength() TO FORMONLY.h_count
               CALL ainq200_b2_display()
 
            ON ACTION open_pro1
               IF g_detail_idx > 0 THEN 
                  IF NOT cl_null(g_inal_d[g_detail_idx].inal001) AND NOT cl_null(g_inal_d[g_detail_idx].inal015) THEN 
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = g_inal_d[g_detail_idx].inal015
                     LET la_param.param[1] = g_inal_d[g_detail_idx].inal001
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)                  
                  END IF
               END IF
                                
         END DISPLAY

         DISPLAY ARRAY g_inal2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_inal2_d.getLength() TO FORMONLY.h_count
               
            ON ACTION open_pro2
               IF g_detail_idx > 0 THEN
                  IF NOT cl_null(g_inal2_d[g_detail_idx].inal001) AND NOT cl_null(g_inal2_d[g_detail_idx].inal015) THEN 
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = g_inal2_d[g_detail_idx].inal015
                     LET la_param.param[1] = g_inal2_d[g_detail_idx].inal001
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)                  
                  END IF
               END IF               
         END DISPLAY

         BEFORE DIALOG
            #CALL DIALOG.setSelectionMode("s_detail1", 1)


         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN         
               CALL ainq200_query()
            END IF
            
         #+ 此段落由子樣板a43產生
         ON ACTION btn_ft
            LET g_action_choice="btn_ft"
            IF cl_auth_chk_act("btn_ft") THEN
               CALl ainq200_b2_fill()
               #EXIT DIALOG
            END IF


         #+ 此段落由子樣板a43產生
         ON ACTION btn_bt
            LET g_action_choice="btn_bt"
            IF cl_auth_chk_act("btn_bt") THEN
               CALl ainq200_b_fill()
               EXIT DIALOG
            END IF          

         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               EXIT DIALOG
            END IF

         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN

               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION qbeclear   # 條件清除
            CLEAR FORM

         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL ainq200_b_fill()

         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()



         #add-point:ui_dialog段自定義action
          ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()

               LET g_main_hidden = 0  #xj add
               LET g_export_node[1] = base.typeInfo.create(g_inal_d)
               LET g_export_id[1]   = "s_detail1"
            
               #add-point:ON ACTION exporttoexcel
               LET g_export_node[2] = base.typeInfo.create(g_inal2_d)
               LET g_export_id[2]   = "s_detail2"
               
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
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION ainq200_query()
   
   #清空畫面&資料初始化
   CLEAR FORM
   CALL g_inal_d.clear()
   CALL g_inal2_d.clear()
   INITIALIZE g_wc TO NULL
 
   LET g_qryparam.state = "c"
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc ON inal006,inal007,inal008,inal011,inal012,inal013
           FROM FORMONLY.l_inal006,FORMONLY.l_inal007,FORMONLY.l_inal008,
                FORMONLY.l_inal011,FORMONLY.l_inal012,FORMONLY.l_inal013
      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD l_inal006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal006  #顯示到畫面上
            NEXT FIELD l_inal006                     #返回原欄位

         ON ACTION controlp INFIELD l_inal007
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal007()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal007  #顯示到畫面上
            NEXT FIELD l_inal007                     #返回原欄位
            
         ON ACTION controlp INFIELD l_inal008
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal008()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal008  #顯示到畫面上
            NEXT FIELD l_inal008                     #返回原欄位            

         ON ACTION controlp INFIELD l_inal011
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal011()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal011  #顯示到畫面上
            NEXT FIELD l_inal011                     #返回原欄位 

         ON ACTION controlp INFIELD l_inal012
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal012()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal012  #顯示到畫面上
            NEXT FIELD l_inal012                     #返回原欄位 
            
         ON ACTION controlp INFIELD l_inal013
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inal013()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inal013  #顯示到畫面上
            NEXT FIELD l_inal013                     #返回原欄位 
            
      END CONSTRUCT 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         
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
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = " 1=1"
   END IF   
END FUNCTION

PRIVATE FUNCTION ainq200_define_cursor()

   ##抓去符合條件的料號、庫位、儲位、批號、製造批號、製造序號
   LET g_sql = "SELECT DISTINCT '','','','','','','','','','','','',inal006,inal009,inal010,inal011,inal012,inal013,",
               "        '','','','','','' FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? AND ",g_wc,
               " ORDER BY inal006,inal009,inal010,inal011,inal012,inal013"

   PREPARE ainq200_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq200_pb
   

   ##銷退資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='202'的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,'',inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? ",
               "   AND inaj036 = '202' ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR ainq200_pb2 

   ##出貨資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,'',inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? AND (inaj036 = '201' OR inaj036 = '301') AND inal005 = -1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR ainq200_pb3   

   ##採購/入庫資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='1開頭'且[C.出入庫碼]="1"的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,'',inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? ",
               "   AND inaj036 LIKE '1%' AND inal005 = 1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR ainq200_pb4 

   ##依發料單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='302'的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,'',inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent = sfdcent AND inal001 = sfdcdocno ",
               "   AND inalent= ? AND inalsite= ? ",
               "   AND inaj036= '302' ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               "   AND sfdc001=? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_pb7 FROM g_sql
   DECLARE b_fill_curs7 CURSOR FOR ainq200_pb7 
 
   ##依發料單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='302'的資料
   #依工单单号抓取所有发料单号
   LET g_sql = "SELECT DISTINCT '','','','','',  ",
               #160224-00001#1
               #"                '','','','',inal001,inal002,",
               #"                '',inal006,inal009,inal010,inal011,",
               #"                inal012,inal013,'','','',",
               #"                '','',''",
               "                '','',inal015,'',inal001,inal002,",
               "                inal017,inal006,inal009,inal010,inal011,",
               "                inal012,inal013,inaj036,inal007,'',inal008,inaj044,inaj018",
               "                ",     
               #160224-00001#1             
               "  FROM inal_t,inaj_t,sfdc_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent = sfdcent AND inal001 = sfdcdocno ",
               "   AND inalent= ? AND inalsite= ? ",
               "   AND inaj036= '302' ",
               "   AND sfdc001=? ",
               #" ORDER BY inal015,inal001,inal002,inal017"
               " ORDER BY inal001,inal002"     #160224-00001#1 
   PREPARE ainq200_pb8 FROM g_sql
   DECLARE b_fill_curs8 CURSOR FOR ainq200_pb8 
END FUNCTION

PRIVATE FUNCTION ainq200_b_fill()


   CALL g_inal_d.clear()


   CALL ainq200_define_cursor()
   
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
   OPEN b_fill_curs USING g_enterprise, g_site

   LET l_type = "0"
   LET li_idx = 1
   LET g_idx = 1
   ##抓去符合條件的料號、庫位、儲位、批號、製造批號、製造序號
   FOREACH b_fill_curs INTO g_inal_d[li_idx].*
      LET g_inal_d[li_idx].pid     = 0
      LET g_inal_d[li_idx].id      = "0.", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].expcode = 1
      LET g_inal_d[li_idx].isExp = TRUE
      LET l_type = g_inal_d[li_idx].id
      CALL ainq200_detail_show(li_idx,'1')
      LET g_idx = li_idx
      LET g_back = FALSE      #160224-00001#1
      CALL ainq200_202()
      CALL ainq200_201_301()
      ##160224-00001#1--mod--b
      IF NOT g_back THEN 
         CALL ainq200_like1()
      END IF   
      #160224-00001#1--mod--e
      LET li_idx = li_idx +1
      
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   LET li_idx = li_idx -1
   CALL g_inal_d.deleteElement(g_inal_d.getLength())
   
#   LET g_browser_cnt = g_inal_d.getLength()

   #瀏覽頁筆數顯示
#   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
#   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數

   FREE ainq200_pb

END FUNCTION

PRIVATE FUNCTION ainq200_201_301()
   --------------------------------------------------------------------------------------------------
   ##出貨資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
   OPEN b_fill_curs3 USING g_enterprise,g_site,
                          g_inal_d[g_idx].inal006,g_inal_d[g_idx].inal009,g_inal_d[g_idx].inal010,
                          g_inal_d[g_idx].inal011,g_inal_d[g_idx].inal012,g_inal_d[g_idx].inal013
   LET li_idx = li_idx + 1
   FOREACH b_fill_curs3 INTO g_inal_d[li_idx].*
      LET g_back = TRUE
      LET g_inal_d[li_idx].pid     = l_type
      LET g_inal_d[li_idx].id      = l_type , ".", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      LET g_inal_d[li_idx].expcode = 3
      LET l_type_201_301 = g_inal_d[li_idx].id
      CALL ainq200_detail_show(li_idx,'3')
            
      CALL ainq200_like1()    #160224-00001#1
        
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF         
   END FOREACH 
   LET li_idx = li_idx -1
   CALL g_inal_d.deleteElement(g_inal_d.getLength())
      
END FUNCTION

PRIVATE FUNCTION ainq200_like1()

   ##採購/入庫資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='1開頭'且[C.出入庫碼]="1"的資料
   #160224-00001#1--mod--b
   IF NOT g_back THEN 
      OPEN b_fill_curs4 USING g_enterprise,g_site,
                             g_inal_d[g_idx].inal006,g_inal_d[g_idx].inal009,g_inal_d[g_idx].inal010,
                             g_inal_d[g_idx].inal011,g_inal_d[g_idx].inal012,g_inal_d[g_idx].inal013
   ELSE
      OPEN b_fill_curs4 USING g_enterprise,g_site,
                             g_inal_d[li_idx].inal006,g_inal_d[li_idx].inal009,g_inal_d[li_idx].inal010,
                             g_inal_d[li_idx].inal011,g_inal_d[li_idx].inal012,g_inal_d[li_idx].inal013
   END IF
   #160224-00001#1--mod--e   
   LET li_idx = li_idx + 1
   FOREACH b_fill_curs4 INTO g_inal_d[li_idx].*
      IF SQLCA.sqlcode THEN
        #INITIALIZE g_errparam TO NULL
        #LET g_errparam.code = SQLCA.sqlcode
        #LET g_errparam.extend = 'foreach:'
        #LET g_errparam.popup = TRUE
        #CALL cl_err()

         EXIT FOREACH
      END IF
      #160224-00001#1--mod--b 
      IF NOT g_back THEN
         LET g_inal_d[li_idx].pid     = l_type
         LET g_inal_d[li_idx].id      = l_type CLIPPED, ".", li_idx USING "<<<"
      ELSE
         LET g_inal_d[li_idx].pid     = l_type_201_301 
         LET g_inal_d[li_idx].id      = l_type_201_301 CLIPPED, ".", li_idx USING "<<<"
      END IF 
      #160224-00001#1--mod--e       
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      LET g_inal_d[li_idx].expcode = 4
      LET l_type_like1 = g_inal_d[li_idx].id
      CALL ainq200_detail_show(li_idx,'3')
      -------------------------------------------------------------------------------------------------- 
      IF g_inal_d[li_idx].inaj036 = '110' OR g_inal_d[li_idx].inaj036 = '111' 
         OR g_inal_d[li_idx].inaj036 = '112' OR g_inal_d[li_idx].inaj036 = '113' 
         OR g_inal_d[li_idx].inaj036 = '114' THEN 
         ##[C.庫存異動類型]='110','111','112','113','114'，依[C.單據編號]串至[T.完工入庫明細檔(sfec_t)]抓取[C.工單單號]
         LET g_sql = "SELECT DISTINCT '','','','','','','','asft300','',sfaadocno,'',sfaadocdt,'','','','','','',",
                     "        '','','','','' FROM sfaa_t,sfec_t",
                     " WHERE sfaaent = sfecent AND sfaasite = sfecsite AND sfaadocno = sfec001 ",
                     "   AND sfecent= ? AND sfecsite= ? ",
                     "   AND sfecdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt"
         PREPARE ainq200_pb5 FROM g_sql
         DECLARE b_fill_curs5 CURSOR FOR ainq200_pb5 
         OPEN b_fill_curs5 USING g_enterprise,g_site,g_inal_d[li_idx].inal001
         LET li_idx = li_idx + 1
         FOREACH b_fill_curs5 INTO g_inal_d[li_idx].*
            IF SQLCA.sqlcode THEN
              #INITIALIZE g_errparam TO NULL
              #LET g_errparam.code = SQLCA.sqlcode
              #LET g_errparam.extend = 'foreach:'
              #LET g_errparam.popup = TRUE
              #CALL cl_err()
          
               EXIT FOREACH
            END IF         
            LET g_inal_d[li_idx].pid     = l_type_like1
            LET g_inal_d[li_idx].id      = l_type_like1 CLIPPED, ".", li_idx USING "<<<"
            LET g_inal_d[li_idx].exp     = TRUE
            LET g_inal_d[li_idx].isExp   = TRUE
            LET g_inal_d[li_idx].expcode = 5
            LET l_type_302 = g_inal_d[li_idx].id 
            CALL ainq200_detail_show(li_idx,'3')

            CALL ainq200_302()

            LET li_idx = li_idx + 1
            IF li_idx > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
               EXIT FOREACH
            END IF         
         END FOREACH                      
      END IF
      IF g_inal_d[li_idx].inaj036 = '103' OR g_inal_d[li_idx].inaj036 = '104' 
         OR g_inal_d[li_idx].inaj036 = '105' OR g_inal_d[li_idx].inaj036 = '106' 
         OR g_inal_d[li_idx].inaj036 = '107' THEN 
         LET g_sql = "SELECT DISTINCT '','','','','','','','asft300',''sfaadocno,'',sfaadocdt,'','','','','','',",
                     "        '','','','','' FROM sfaa_t,pmdv_t",
                     " WHERE sfaaent = pmdvent AND sfaasite = pmdvsite AND sfaadocno = pmdv014 ",
                     "   AND pmdvent= ? AND pmdvsite= ? ",
                     "   AND pmdvdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt"
         PREPARE ainq200_pb6 FROM g_sql
         DECLARE b_fill_curs6 CURSOR FOR ainq200_pb6 
         OPEN b_fill_curs6 USING g_enterprise,g_site,g_inal_d[li_idx].inal001
         LET li_idx = li_idx + 1
         FOREACH b_fill_curs6 INTO g_inal_d[li_idx].*
            IF SQLCA.sqlcode THEN
              #INITIALIZE g_errparam TO NULL
              #LET g_errparam.code = SQLCA.sqlcode
              #LET g_errparam.extend = 'foreach:'
              #LET g_errparam.popup = TRUE
              #CALL cl_err()
           
               EXIT FOREACH
            END IF         
            LET g_inal_d[li_idx].pid     = l_type_like1
            LET g_inal_d[li_idx].id      = l_type_like1 CLIPPED, ".", li_idx USING "<<<"
            LET g_inal_d[li_idx].exp     = TRUE
            LET g_inal_d[li_idx].isExp   = TRUE
            LET g_inal_d[li_idx].expcode = 5
            LET l_type_302 = g_inal_d[li_idx].id
            CALL ainq200_detail_show(li_idx,'3') 

            CALL ainq200_302()
             
            LET li_idx = li_idx + 1
            IF li_idx > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
               EXIT FOREACH
            END IF         
         END FOREACH  
      END IF               
      -------------------------------------------------------------------------------------------------- 
      #160224-00001#1
      IF g_inal_d[li_idx].inaj036 = '101' OR g_inal_d[li_idx].inaj036 = '102' 
         OR g_inal_d[li_idx].inaj036 = '115' THEN 
         LET li_idx = li_idx + 1
      END IF
      #160224-00001#1      
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
         EXIT FOREACH
      END IF         
   END FOREACH 
   LET li_idx = li_idx -1    #160224-00001#1
   CALL g_inal_d.deleteElement(g_inal_d.getLength())
   #LET li_idx = li_idx -1    #160224-00001#1--mark   
END FUNCTION

PRIVATE FUNCTION ainq200_302()
DEFINE l_type_sfdc LIKE type_t.chr500   
   
   OPEN b_fill_curs8 USING g_enterprise,g_site,
#                          g_inal_d[li_idx].inal006,g_inal_d[li_idx].inal009,g_inal_d[li_idx].inal010,
#                          g_inal_d[li_idx].inal011,g_inal_d[li_idx].inal012,g_inal_d[li_idx].inal013,
                          g_inal_d[li_idx].inal001
   LET li_idx = li_idx + 1
   FOREACH b_fill_curs8 INTO g_inal_d[li_idx].*
      LET g_inal_d[li_idx].pid     = l_type_302
      LET g_inal_d[li_idx].id      = l_type_302 CLIPPED, ".", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      LET g_inal_d[li_idx].expcode = 4
      CALL ainq200_detail_show(li_idx,'4')   #160224-00001#1
      #CALL ainq200_detail_show(li_idx,'3')   #160224-00001#1  mark
      LET l_type_sfdc = g_inal_d[li_idx].id
      
      CALL ainq200_circle(g_inal_d[li_idx].id)
      
#      LET g_idx = li_idx
#      OPEN b_fill_curs7 USING g_enterprise,g_site,
#                             g_inal_d[g_idx].inal006,g_inal_d[g_idx].inal009,g_inal_d[g_idx].inal010,
#                             g_inal_d[g_idx].inal011,g_inal_d[g_idx].inal012,g_inal_d[g_idx].inal013,
#                             g_inal_d[g_idx].inal001
#      LET li_idx = li_idx + 1
#      FOREACH b_fill_curs7 INTO g_inal_d[li_idx].*
#         LET g_inal_d[li_idx].pid     = l_type_sfdc
#         LET g_inal_d[li_idx].id      = l_type_sfdc CLIPPED, ".", li_idx USING "<<<"
#         LET g_inal_d[li_idx].exp     = TRUE
#         LET g_inal_d[li_idx].isExp   = TRUE
#         LET g_inal_d[li_idx].expcode = 4
#         CALL ainq200_detail_show(li_idx,'3')
#         
#         
#         
#         LET li_idx = li_idx + 1
#         IF li_idx > g_max_rec AND g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code =  9035
#            LET g_errparam.extend =  ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF         
#      END FOREACH
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF         
   END FOREACH
   LET li_idx = li_idx -1   
   CALL g_inal_d.deleteElement(g_inal_d.getLength())  
END FUNCTION

PRIVATE FUNCTION ainq200_b2_display()
   LET g_master2.inal006 = g_inal_d[l_ac].inal006 
   LET g_master2.inal007 = g_inal_d[l_ac].inal007 
   LET g_master2.inal008 = g_inal_d[l_ac].inal008 
   LET g_master2.inal011 = g_inal_d[l_ac].inal011 
   LET g_master2.inal012 = g_inal_d[l_ac].inal012 
   LET g_master2.inal013 = g_inal_d[l_ac].inal013
   DISPLAY g_master2.inal006 TO c_inal006
   DISPLAY g_master2.inal007 TO c_inal007
   DISPLAY g_master2.inal008 TO c_inal008
   DISPLAY g_master2.inal011 TO c_inal011
   DISPLAY g_master2.inal012 TO c_inal012
   DISPLAY g_master2.inal013 TO c_inal013
           
END FUNCTION

PRIVATE FUNCTION ainq200_define_cursor2()
   ##抓去符合條件的料號、庫位、儲位、批號、製造批號、製造序號
   LET g_sql = "SELECT DISTINCT '','','','','','','','','','','','',inal006,inal009,inal010,inal011,inal012,inal013,",
               "        '','','','','' FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? ",
               "   AND inal006= ? AND inal007= ? AND inal008= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal006,inal009,inal010,inal011,inal012,inal013"

   PREPARE ainq200_2pb FROM g_sql
   DECLARE b2_fill_curs CURSOR FOR ainq200_2pb
   
   ##採購資料：依2步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='101','102''115'且[C.出入庫碼]="1"的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? AND (inaj036 = '101' OR inaj036 = '102' OR inaj036 = '115') AND inal005 = 1 ",
               "   AND inal006= ? AND inal007= ? AND inal008= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_2pb2 FROM g_sql
   DECLARE b2_fill_curs2 CURSOR FOR ainq200_2pb2   

   #發料資料：依2步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='302'的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? AND inaj036 = '302' ",
               "   AND inal006= ? AND inal007= ? AND inal008= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               #" ORDER BY inal015,inal001,inal002,inal017"     #160224-00001#1  mark
               " ORDER BY inal015,inal001,inal002,inal017,inal012"   #160224-00001#1

   PREPARE ainq200_2pb7 FROM g_sql
   DECLARE b2_fill_curs7 CURSOR FOR ainq200_2pb7

   ##[C.庫存異動類型]='110','111','112','113','114'，依[C.單據編號]串至[T.完工入庫明細檔(sfec_t)]抓取[C.工單單號]
   LET g_sql = "SELECT DISTINCT '','','','','','','','asft300','',sfaadocno,'',sfaadocdt,'','','','','','',",
               "        '','','','','' FROM sfaa_t,sfdb_t",
               " WHERE sfaaent = sfdbent AND sfaasite = sfdbsite AND sfaadocno = sfdb001 ",
               "   AND sfdbent= ? AND sfdbsite= ? ",
               "   AND sfdbdocno = ? ",
               " ORDER BY sfaadocno,sfaadocdt"
   PREPARE ainq200_2pb3 FROM g_sql
   DECLARE b2_fill_curs3 CURSOR FOR ainq200_2pb3 

   ##依入庫單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='103','104','105','106','107''110','111','112','113','114'的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,inal008,inaj044,inaj018 FROM inal_t,inaj_t,sfec_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent = sfecent AND inal001 = sfecdocno ",
               "   AND inalent= ? AND inalsite= ? AND (inaj036 = '103' OR inaj036 = '104' OR inaj036 = '105' OR inaj036 = '106' ",
               "        OR inaj036 = '107' OR inaj036 = '110' OR inaj036 = '111' OR inaj036 = '112' OR inaj036 = '113' OR inaj036 = '114')  ",
               "   AND sfec001 = ?",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",               
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_2pb4 FROM g_sql
   DECLARE b2_fill_curs4 CURSOR FOR ainq200_2pb4
   
   ##出貨資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,inal008,inaj044,inaj018 FROM inal_t,inaj_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent= ? AND inalsite= ? AND (inaj036 = '201' OR inaj036 = '301') AND inal005 = -1 ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_2pb5 FROM g_sql
   DECLARE b2_fill_curs5 CURSOR FOR ainq200_2pb5 
   
   
   ##銷退資料：依2-4步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='202'的資料
   LET g_sql = "SELECT DISTINCT '','','','','','','',inal015,'',inal001,inal002,inal017,inal006,inal009,inal010,inal011,inal012,inal013,",
               "        inaj036,inal007,inal008,inaj044,inaj018 FROM inal_t,inaj_t,xmdl_t",
               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "   AND inalent = xmdlent AND inal001 = xmdldocno ",
               "   AND inalent= ? AND inalsite= ? AND inaj036 = '202' ",
               "   AND inal006= ? AND inal009= ? AND inal010= ?",
               "   AND inal011= ? AND inal012= ? AND inal013= ? ",
               "   AND xmdl001 = ? ",
               " ORDER BY inal015,inal001,inal002,inal017"

   PREPARE ainq200_2pb6 FROM g_sql
   DECLARE b2_fill_curs6 CURSOR FOR ainq200_2pb6    
   
END FUNCTION

PRIVATE FUNCTION ainq200_b2_fill()
DEFINE l_idx   LIKE type_t.chr500     #160224-00001#1


   CALL g_inal2_d.clear()
   CALL ainq200_define_cursor2()

   OPEN b2_fill_curs USING g_enterprise, g_site,
                           g_master2.inal006,
                           g_master2.inal007,
                           g_master2.inal008,
                           g_master2.inal011,
                           g_master2.inal012,
                           g_master2.inal013
   LET li_idx = 1
   LET g_idx = 1
   ##抓取[T.製造批序號庫存交易明細檔(inal_t)]符合條件的料號、庫位、儲位、批號、製造批號、製造序號為起始階
   FOREACH b2_fill_curs INTO g_inal2_d[li_idx].*
      LET g_inal2_d[li_idx].pid2     = 0
      LET g_inal2_d[li_idx].id2      = "0.", li_idx USING "<<<"
      LET g_inal2_d[li_idx].exp2     = TRUE
      LET g_inal2_d[li_idx].expcode2 = 1
      LET g_inal2_d[li_idx].isExp2 = TRUE
      CALL ainq200_detail_show2(li_idx,'1')
      
      --------------------------------------------------------------------------------------
      ##採購資料：依2步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='101','102''115'且[C.出入庫碼]="1"的資料
      OPEN b2_fill_curs2 USING g_enterprise,g_site,
                               g_master2.inal006,
                               g_master2.inal007,
                               g_master2.inal008,
                               g_master2.inal011,
                               g_master2.inal012,
                               g_master2.inal013
      LET li_idx = li_idx + 1
      FOREACH b2_fill_curs2 INTO g_inal2_d[li_idx].*
         LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
         LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED , ".", li_idx USING "<<<"
         LET g_inal2_d[li_idx].exp2     = TRUE
         LET g_inal2_d[li_idx].isExp2   = TRUE
         LET g_inal2_d[li_idx].expcode2 = 2
         CALL ainq200_detail_show2(li_idx,'2')
         LET li_idx = li_idx + 1
         IF li_idx > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            EXIT FOREACH
         END IF         
      END FOREACH          
         
      -----------------------------------------------------------------------------------------
      #發料資料：依2步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='302'的資料      
      OPEN b2_fill_curs7 USING g_enterprise,g_site,
                               g_master2.inal006,
                               g_master2.inal007,
                               g_master2.inal008,
                               g_master2.inal011,
                               g_master2.inal012,
                               g_master2.inal013
      #LET li_idx = li_idx + 1
      FOREACH b2_fill_curs7 INTO g_inal2_d[li_idx].*
         LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
         LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED, ".", li_idx USING "<<<"
         LET g_inal2_d[li_idx].exp2     = TRUE
         LET g_inal2_d[li_idx].isExp2   = TRUE
         LET g_inal2_d[li_idx].expcode2 = 3
         CALL ainq200_detail_show2(li_idx,'3')
         LET g_idx = li_idx
         ---------------------------------------------------------------------------
         #工單資料：依[C.工單單號]抓取[T.工單單頭檔(sfaa_t)]相關資料
         OPEN b2_fill_curs3 USING g_enterprise,g_site,
                                  g_inal2_d[g_idx].inal001
         LET li_idx = li_idx + 1
         FOREACH b2_fill_curs3 INTO g_inal2_d[li_idx].*
            LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
            LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED, ".", li_idx USING "<<<"
            LET g_inal2_d[li_idx].exp2     = TRUE
            LET g_inal2_d[li_idx].isExp2   = TRUE
            LET g_inal2_d[li_idx].expcode2 = 3
            CALL ainq200_detail_show2(li_idx,'3')
            LET g_idx = li_idx
            LET l_idx = g_inal2_d[li_idx].id2   #160224-00001#1
            ------------------------------------------------------------------------------------------------
            ##依入庫單號分別抓取該單之[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='103','104','105','106','107''110','111','112','113','114'的資料
            OPEN b2_fill_curs4 USING g_enterprise,g_site,g_inal2_d[g_idx].inal001             
            LET li_idx = li_idx + 1
            FOREACH b2_fill_curs4 INTO g_inal2_d[li_idx].*
               #160224-00001#1---mod---b
               LET g_inal2_d[li_idx].pid2     = l_idx   
               LET g_inal2_d[li_idx].id2      = l_idx CLIPPED, ".", li_idx USING "<<<"            
               #LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
               #LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED, ".", li_idx USING "<<<"
               #160224-00001#1---mod---e
               LET g_inal2_d[li_idx].exp2     = TRUE
               LET g_inal2_d[li_idx].isExp2   = TRUE
               LET g_inal2_d[li_idx].expcode2 = 4
               CALL ainq200_detail_show2(li_idx,'4')
               LET g_idx = li_idx
               
               -----------------------------------------------------------------------------
               #出貨資料：依2-4步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='201','301'且[C.出入庫碼]="-1"的資料
               OPEN b2_fill_curs5 USING g_enterprise,g_site,
                          g_inal2_d[g_idx].inal006,g_inal2_d[g_idx].inal009,g_inal2_d[g_idx].inal010,
                          g_inal2_d[g_idx].inal011,g_inal2_d[g_idx].inal012,g_inal2_d[g_idx].inal013                                        
               LET li_idx = li_idx + 1
               FOREACH b2_fill_curs5 INTO g_inal2_d[li_idx].*
                  LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
                  LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED, ".", li_idx USING "<<<"
                  LET g_inal2_d[li_idx].exp2     = TRUE
                  LET g_inal2_d[li_idx].isExp2   = TRUE
                  LET g_inal2_d[li_idx].expcode2 = 4
                  CALL ainq200_detail_show2(li_idx,'4')
                  LET li_idx = li_idx + 1
                  IF li_idx > g_max_rec AND g_error_show = 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  9035
                     LET g_errparam.extend =  ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
            
                     EXIT FOREACH
                  END IF         
               END FOREACH            
               ------------------------------------------------------------------------------
               #銷退資料：依2-4步驟資料，抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='202'的資料
               OPEN b2_fill_curs6 USING g_enterprise,g_site,
                          g_inal2_d[g_idx].inal006,g_inal2_d[g_idx].inal009,g_inal2_d[g_idx].inal010,
                          g_inal2_d[g_idx].inal011,g_inal2_d[g_idx].inal012,g_inal2_d[g_idx].inal013,
                          g_inal2_d[g_idx].inal001                                
               #LET li_idx = li_idx + 1
               FOREACH b2_fill_curs6 INTO g_inal2_d[li_idx].*
                  LET g_inal2_d[li_idx].pid2     = g_inal2_d[li_idx-1].id2
                  LET g_inal2_d[li_idx].id2      = g_inal2_d[li_idx-1].id2 CLIPPED, ".", li_idx USING "<<<"
                  LET g_inal2_d[li_idx].exp2     = TRUE
                  LET g_inal2_d[li_idx].isExp2   = TRUE
                  LET g_inal2_d[li_idx].expcode2 = 4
                  CALL ainq200_detail_show2(li_idx,'4')

                  LET li_idx = li_idx + 1
                  IF li_idx > g_max_rec AND g_error_show = 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  9035
                     LET g_errparam.extend =  ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
             
                     EXIT FOREACH
                  END IF         
               END FOREACH
               IF li_idx > g_max_rec AND g_error_show = 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  9035
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
         
                  EXIT FOREACH
               END IF         
            END FOREACH 
            IF li_idx > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF          
         END FOREACH
         IF li_idx > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF       
   END FOREACH
   LET g_error_show = 0

   CALL g_inal2_d.deleteElement(g_inal2_d.getLength())
   LET li_idx = li_idx - 1 
END FUNCTION

PRIVATE FUNCTION ainq200_detail_show(pi_ac,pi_type)
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE li_tmp  LIKE type_t.num5
   DEFINE pi_type LIKE type_t.chr1

   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   IF pi_type = '1' THEN 
      LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].inal006
      IF NOT cl_null(g_inal_d[g_cnt].inal009) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal009 
      END IF
      IF NOT cl_null(g_inal_d[g_cnt].inal010) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal010 
      END IF
      IF NOT cl_null(g_inal_d[g_cnt].inal011) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal011 
      END IF
      IF NOT cl_null(g_inal_d[g_cnt].inal012) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal012 
      END IF
      IF NOT cl_null(g_inal_d[g_cnt].inal013) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal013 
      END IF
   ELSE
      LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].inal015
      IF NOT cl_null(g_inal_d[g_cnt].inal001) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal001 
      END IF
      IF NOT cl_null(g_inal_d[g_cnt].inal017) THEN 
         LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal017 
      END IF 
      #160224-00001#1--add---b
      IF pi_type = '4' THEN 
         LET g_inal_d[g_cnt].name =g_inal_d[g_cnt].name," - ", g_inal_d[g_cnt].inal006
         IF NOT cl_null(g_inal_d[g_cnt].inal009) THEN
            LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal009
         END IF
         IF NOT cl_null(g_inal_d[g_cnt].inal010) THEN
            LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal010
         END IF
         IF NOT cl_null(g_inal_d[g_cnt].inal011) THEN
            LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal011
         END IF
         IF NOT cl_null(g_inal_d[g_cnt].inal012) THEN
            LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal012
         END IF
         IF NOT cl_null(g_inal_d[g_cnt].inal013) THEN
            LET g_inal_d[g_cnt].name = g_inal_d[g_cnt].name," - ",g_inal_d[g_cnt].inal013
         END IF
      END IF
      #160224-00001#1--add---e      
      CALL s_aooi200_get_slip_desc(g_inal_d[g_cnt].inal001) RETURNING g_inal_d[g_cnt].inal001_desc         
   END IF

   LET g_cnt = li_tmp

END FUNCTION

PRIVATE FUNCTION ainq200_detail_show2(pi_ac,pi_type)
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE li_tmp  LIKE type_t.num5
   DEFINE pi_type LIKE type_t.chr1

   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   IF pi_type = '1' THEN 
      LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].inal006
      IF NOT cl_null(g_inal2_d[g_cnt].inal009) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal009 
      END IF
      IF NOT cl_null(g_inal2_d[g_cnt].inal010) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal010 
      END IF
      IF NOT cl_null(g_inal2_d[g_cnt].inal011) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal011 
      END IF
      IF NOT cl_null(g_inal2_d[g_cnt].inal012) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal012 
      END IF
      IF NOT cl_null(g_inal2_d[g_cnt].inal013) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal013 
      END IF
   ELSE
      LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].inal015
      IF NOT cl_null(g_inal2_d[g_cnt].inal001) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal001 
      END IF
      IF NOT cl_null(g_inal2_d[g_cnt].inal017) THEN 
         LET g_inal2_d[g_cnt].name2 = g_inal2_d[g_cnt].name2," - ",g_inal2_d[g_cnt].inal017 
      END IF
      CALL s_aooi200_get_slip_desc(g_inal2_d[g_cnt].inal001) RETURNING g_inal2_d[g_cnt].inal001_desc            
   END IF

   LET g_cnt = li_tmp
END FUNCTION

PRIVATE FUNCTION ainq200_202()
   --------------------------------------------------------------------------------------
   ##銷退資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='202'的資料
   OPEN b_fill_curs2 USING g_enterprise,g_site,
                          g_inal_d[g_idx].inal006,g_inal_d[g_idx].inal009,g_inal_d[g_idx].inal010,
                          g_inal_d[g_idx].inal011,g_inal_d[g_idx].inal012,g_inal_d[g_idx].inal013
   LET li_idx = li_idx + 1
   FOREACH b_fill_curs2 INTO g_inal_d[li_idx].*
      LET g_inal_d[li_idx].pid     = l_type
      LET g_inal_d[li_idx].id      = l_type CLIPPED , ".", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      LET g_inal_d[li_idx].expcode = 2
      LET l_type_202 = g_inal_d[li_idx].id
      CALL ainq200_detail_show(li_idx,'2')
              
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF          
   END FOREACH
   CALL g_inal_d.deleteElement(g_inal_d.getLength())
   LET li_idx = li_idx -1      
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
PRIVATE FUNCTION ainq200_circle(p_type)
DEFINE p_type  LIKE type_t.chr500
DEFINE l_inal_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE l_inal2_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE l_inal3_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE l_i LIKE type_t.num5
DEFINE l_n LIKE type_t.num5
DEFINE l_i2 LIKE type_t.num5
DEFINE l_n2 LIKE type_t.num5
DEFINE l_i3 LIKE type_t.num5
DEFINE l_n3 LIKE type_t.num5

   ##採購/入庫資料：抓取[T.製造批序號庫存交易明細檔(inal_t)].[C.庫存異動類型]='1開頭'且[C.出入庫碼]="1"的資料
   OPEN b_fill_curs4 USING g_enterprise,g_site,
                           g_inal_d[li_idx].inal006,g_inal_d[li_idx].inal009,g_inal_d[li_idx].inal010,
                           g_inal_d[li_idx].inal011,g_inal_d[li_idx].inal012,g_inal_d[li_idx].inal013
   LET l_n = 1
   FOREACH b_fill_curs4 INTO l_inal_d[l_n].*
      LET l_n = l_n + 1
      IF l_n > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF    
   END FOREACH
   
   LET l_n = l_n - 1
   FOR l_i = 1 TO l_n 
      LET li_idx = li_idx + l_i
      LET g_inal_d[li_idx].* = l_inal_d[l_i].*
      LET g_inal_d[li_idx].pid     = p_type
      LET g_inal_d[li_idx].id      = p_type CLIPPED, ".", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      #LET g_inal_d[li_idx].expcode = 4
      LET l_type_like1 = g_inal_d[li_idx].id
      CALL ainq200_detail_show(li_idx,'3')      
   
   
      IF g_inal_d[li_idx].inaj036 = '110' OR g_inal_d[li_idx].inaj036 = '111' 
         OR g_inal_d[li_idx].inaj036 = '112' OR g_inal_d[li_idx].inaj036 = '113' 
         OR g_inal_d[li_idx].inaj036 = '114' THEN 
         ##[C.庫存異動類型]='110','111','112','113','114'，依[C.單據編號]串至[T.完工入庫明細檔(sfec_t)]抓取[C.工單單號]
         LET g_sql = "SELECT DISTINCT '','','','','','','','','',sfaadocno,'',sfaadocdt,'','','','','','',",
                     "        '','','','','' FROM sfaa_t,sfec_t",
                     " WHERE sfaaent = sfecent AND sfaasite = sfecsite AND sfaadocno = sfec001 ",
                     "   AND sfecent= ? AND sfecsite= ? ",
                     "   AND sfecdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt"
         PREPARE ainq200_pb52 FROM g_sql
         DECLARE b_fill_curs52 CURSOR FOR ainq200_pb52 
         OPEN b_fill_curs5 USING g_enterprise,g_site,g_inal_d[li_idx].inal001
         LET l_n2 = 1
         FOREACH b_fill_curs52 INTO l_inal2_d[l_n2].*
            LET l_n2 = l_n2 + 1
            IF l_n2 > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF          
         END FOREACH
         LET l_n2 = l_n2 - 1
         FOR l_i2=1 TO l_n2
            LET li_idx = li_idx + l_i2
            LET g_inal_d[li_idx].* = l_inal2_d[l_i2].*            
            LET g_inal_d[li_idx].pid     = l_type_like1
            LET g_inal_d[li_idx].id      = l_type_like1 CLIPPED, ".", li_idx USING "<<<"
            LET g_inal_d[li_idx].exp     = TRUE
            LET g_inal_d[li_idx].isExp   = TRUE
            #LET g_inal_d[li_idx].expcode = 5
            LET l_type_302 = g_inal_d[li_idx].id 
            CALL ainq200_detail_show(li_idx,'3')

            CALL ainq200_circle_302()
         END FOR    
      END IF
      IF g_inal_d[li_idx].inaj036 = '103' OR g_inal_d[li_idx].inaj036 = '104' 
         OR g_inal_d[li_idx].inaj036 = '105' OR g_inal_d[li_idx].inaj036 = '106' 
         OR g_inal_d[li_idx].inaj036 = '107' THEN 
         LET g_sql = "SELECT DISTINCT '','','','','','','','asft300','',sfaadocno,'',sfaadocdt,'','','','','','',",
                     "        '','','','','' FROM sfaa_t,pmdv_t",
                     " WHERE sfaaent = pmdvent AND sfaasite = pmdvsite AND sfaadocno = pmdv014 ",
                     "   AND pmdvent= ? AND pmdvsite= ? ",
                     "   AND pmdvdocno = ? ",
                     " ORDER BY sfaadocno,sfaadocdt"
         PREPARE ainq200_pb62 FROM g_sql
         DECLARE b_fill_curs62 CURSOR FOR ainq200_pb62 
         OPEN b_fill_curs6 USING g_enterprise,g_site,g_inal_d[li_idx].inal001
         LET l_n3 = 1
         FOREACH b_fill_curs62 INTO l_inal3_d[l_n3].*
            LET l_n3 = l_n3 + 1
            IF l_n3 > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF          
         END FOREACH
         LET l_n3 = l_n3 - 1
         FOR l_i3 = 1 TO l_n3
            LET li_idx = li_idx + l_i3
            LET g_inal_d[li_idx].* = l_inal3_d[l_i3].*
            LET g_inal_d[li_idx].pid     = l_type_like1
            LET g_inal_d[li_idx].id      = l_type_like1 CLIPPED, ".", li_idx USING "<<<"
            LET g_inal_d[li_idx].exp     = TRUE
            LET g_inal_d[li_idx].isExp   = TRUE
            #LET g_inal_d[li_idx].expcode = 5
            LET l_type_302 = g_inal_d[li_idx].id
            CALL ainq200_detail_show(li_idx,'3') 

            CALL ainq200_circle_302()
         END FOR    
      END IF     
   END FOR
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
PRIVATE FUNCTION ainq200_circle_302()
DEFINE l_type_sfdc LIKE type_t.chr500   
DEFINE l_inal_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE l_inal2_d          DYNAMIC ARRAY OF type_g_inal_d
DEFINE l_i LIKE type_t.num5
DEFINE l_n LIKE type_t.num5
DEFINE l_i2 LIKE type_t.num5
DEFINE l_n2 LIKE type_t.num5

   OPEN b_fill_curs8 USING g_enterprise,g_site,
                          g_inal_d[li_idx].inal001
   LET l_n = 1
   FOREACH b_fill_curs8 INTO l_inal_d[l_n].*
      LET l_n = l_n + 1
      IF l_n > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF     
   END FOREACH
   LET l_n = l_n -1
   FOR l_i  = 1 TO l_n
      LET li_idx = li_idx+1
      LET g_inal_d[li_idx].* = l_inal_d[l_n].*
      LET g_inal_d[li_idx].pid     = l_type_302
      LET g_inal_d[li_idx].id      = l_type_302 CLIPPED, ".", li_idx USING "<<<"
      LET g_inal_d[li_idx].exp     = TRUE
      LET g_inal_d[li_idx].isExp   = TRUE
      LET g_inal_d[li_idx].expcode = 4
      CALL ainq200_detail_show(li_idx,'4')  #160224-00001#1--mark
      #CALL ainq200_detail_show(li_idx,'3')  #160224-00001#1--mark
      LET l_type_sfdc = g_inal_d[li_idx].id
      
      
   


      
      OPEN b_fill_curs7 USING g_enterprise,g_site,
                             g_inal_d[g_idx].inal006,g_inal_d[g_idx].inal009,g_inal_d[g_idx].inal010,
                             g_inal_d[g_idx].inal011,g_inal_d[g_idx].inal012,g_inal_d[g_idx].inal013,
                             g_inal_d[g_idx].inal001
      LET l_n2 = 1
      FOREACH b_fill_curs7 INTO l_inal2_d[l_n2].*
         LET l_n = l_n + 1
         IF l_n > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF       
      END FOREACH
      LET l_n2 = l_n2-1
      FOR l_i2 = 1 TO l_n2
         LET li_idx = li_idx + l_i2
         LET g_inal_d[li_idx].* = l_inal2_d[l_i2].*
         LET g_inal_d[li_idx].pid     = l_type_sfdc
         LET g_inal_d[li_idx].id      = l_type_sfdc CLIPPED, ".", li_idx USING "<<<"
         LET g_inal_d[li_idx].exp     = TRUE
         LET g_inal_d[li_idx].isExp   = TRUE
         LET g_inal_d[li_idx].expcode = 4
         CALL ainq200_detail_show(li_idx,'3')
         LET li_idx = li_idx + 1
      END FOR
   END FOR  
END FUNCTION

#end add-point
 
{</section>}
 

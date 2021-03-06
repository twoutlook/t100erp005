#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp880.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-05-10 18:06:09), PR版次:0012(2016-12-09 14:14:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: ainp880
#+ Description: 盤點過帳作業
#+ Creator....: 01534(2014-10-24 15:56:41)
#+ Modifier...: 01534 -SD/PR- 08734
 
{</section>}
 
{<section id="ainp880.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160317-00023#1  2016/03/17  By lixh  20160317
#160504-00019#3  2016/05/09  By lixh  1.現有庫存處理時，參考單位盤點量有差異者，也需要處理
#.....................................2.畫面增加顯示各參考單位數量資料
#.....................................3.增加雜收雜發理由碼欄位
#160517-00016#1  2016/05/17  By lixh      更新inpd003
#160517-00029#4  2016/05/31  By earl      增加條碼盤點過帳
#160115-00012#1  2016/06/02  By 02097     修改s_inventory_ins_inaj的传入参数
#160612-00001#1  2016/06/14  By lixh      ainp880过账还原时，还原一张盘点单上某一项次，整张盘点单的inaj全部被删除(删除时考虑项次)
#160816-00001#3  2016/08/16  By 08742     抓取理由碼改CALL sub
#161124-00048#4  2016/12/09  By 08734     星号整批调整
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
            sel                    LIKE type_t.chr1, 
            inpddocno              LIKE inpd_t.inpddocno,
            inpdseq                LIKE inpd_t.inpdseq,
            inpd001                LIKE inpd_t.inpd001,
            inpd001_desc           LIKE type_t.chr500,
            inpd001_desc_desc      LIKE type_t.chr500,
            inpd005                LIKE inpd_t.inpd005,
            inpd005_desc           LIKE type_t.chr500,
            inpd006                LIKE inpd_t.inpd006,
            inpd006_desc           LIKE type_t.chr500,
            inpd007                LIKE inpd_t.inpd007,
            inpd002                LIKE inpd_t.inpd002,
            inpd002_desc           LIKE type_t.chr500,
            inpd010                LIKE inpd_t.inpd010,
            inpd010_desc           LIKE type_t.chr500, 
            inpd011                LIKE inpd_t.inpd011,
            inpd036                LIKE inpd_t.inpd036,
            inpd056                LIKE inpd_t.inpd056,
            inpd003                LIKE inpd_t.inpd003,
            inpd015                LIKE inpd_t.inpd015,
            inpd012                LIKE inpd_t.inpd012,    
            inpd012_desc           LIKE type_t.chr500,      #160504-00019#3
            inpd013                LIKE inpd_t.inpd013,     #160504-00019#3 
            inpd008                LIKE inpd_t.inpd008,
            inpdstus               LIKE inpd_t.inpdstus,
            inpdpstdt              LIKE inpd_t.inpdpstdt,
            inpd030                LIKE inpd_t.inpd030,
            inpd050                LIKE inpd_t.inpd050,
            inpd034                LIKE inpd_t.inpd034,
            inpd040                LIKE inpd_t.inpd040,
            inpd054                LIKE inpd_t.inpd054,
            inpd060                LIKE inpd_t.inpd060,
            inpd037                LIKE inpd_t.inpd037,     #160504-00019#3
            inpd057                LIKE inpd_t.inpd057,     #160504-00019#3
            inpd031                LIKE inpd_t.inpd031,     #160504-00019#3
            inpd051                LIKE inpd_t.inpd051      #160504-00019#3
            
                     END RECORD
                     
TYPE type_g_inpf_d RECORD
            sel01                  LIKE type_t.chr1,
            inpfdocno              LIKE inpf_t.inpfdocno,
            inpfseq                LIKE inpf_t.inpfseq,
            inpf001                LIKE inpf_t.inpf001,
            inpf003                LIKE inpf_t.inpf003,
            inpf003_desc           LIKE type_t.chr500,
            inpf003_desc_desc      LIKE type_t.chr500,
            inpf002                LIKE inpf_t.inpf002,
            inpf002_desc           LIKE type_t.chr500,
            inpf006                LIKE inpf_t.inpf006,
            inpf006_desc           LIKE type_t.chr500,   
            inpf007                LIKE inpf_t.inpf007,
            inpf004                LIKE inpf_t.inpf004,
            inpfpstdt              LIKE inpf_t.inpfpstdt            
                   END RECORD
                   
TYPE type_g_inpg_d RECORD
            inpgseq1               LIKE inpg_t.inpgseq1,
            inpgseq2               LIKE inpg_t.inpgseq2,            
            inpg001                LIKE inpg_t.inpg001,
            inpg001_desc           LIKE type_t.chr500,
            inpg001_desc_desc      LIKE type_t.chr500,
            inpg010                LIKE inpg_t.inpg010,
            inpg007                LIKE inpg_t.inpg007,
            inpg007_desc           LIKE type_t.chr500,
            inpg012                LIKE inpg_t.inpg012,
            inpg033                LIKE inpg_t.inpg033,
            inpg053                LIKE inpg_t.inpg053,
            inpg003                LIKE inpg_t.inpg003,
            inpg013                LIKE inpg_t.inpg013,
            inpg030                LIKE inpg_t.inpg030,
            inpg050                LIKE inpg_t.inpg050,
            inpg031                LIKE inpg_t.inpg031,
            inpg034                LIKE inpg_t.inpg034,
            inpg051                LIKE inpg_t.inpg051,
            inpg054                LIKE inpg_t.inpg054            
                   END RECORD          

DEFINE g_inpf_d  DYNAMIC ARRAY OF type_g_inpf_d
DEFINE g_inpg_d  DYNAMIC ARRAY OF type_g_inpg_d
DEFINE g_date    LIKE inpd_t.inpd017
DEFINE g_invent  LIKE type_t.chr1
DEFINE g_work    LIKE type_t.chr1
DEFINE g_post    LIKE type_t.chr1
DEFINE g_diff    LIKE type_t.chr1
DEFINE g_wc_inpd034  STRING
DEFINE g_wc_inpd032  STRING
DEFINE g_wc_inpd005  STRING
DEFINE g_wc_inpd008  STRING
DEFINE g_wc_inpd033  STRING
DEFINE g_sql1        STRING
DEFINE g_sql2        STRING
DEFINE g_inpd033     LIKE inpd_t.inpd033
DEFINE g_detail_cnt2         LIKE type_t.num5 
DEFINE g_detail_cnt3         LIKE type_t.num5 
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_detail_idx3         LIKE type_t.num5
DEFINE l_ac2                 LIKE type_t.num5
DEFINE l_ac3                 LIKE type_t.num5 
DEFINE g_cnt2                LIKE type_t.num5
DEFINE g_stage               LIKE type_t.num5
DEFINE g_inbb016             LIKE inbb_t.inbb016   #160504-00019#3
DEFINE g_inbb016_2           LIKE inbb_t.inbb016   #160504-00019#3
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp880.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp880 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp880_init()   
 
      #進入選單 Menu (="N")
      CALL ainp880_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp880
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp880.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp880_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_invent = 'Y'
   LET g_work = 'N'
   LET g_post = 'Y'
   LET g_diff = 'N'
   LET g_date = g_today
   
   #160504-00019#3  #參考單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN   
      CALL cl_set_comp_visible("b_inpd012,b_inpd012_desc,b_inpd013,inpd031,inpd037,inpd051,inpd057",FALSE)
   END IF
   #160504-00019#3   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp880.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp880_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE li_idx01     LIKE type_t.num5
   DEFINE i            LIKE type_t.num5 
   DEFINE j            LIKE type_t.num5 
   DEFINE m            LIKE type_t.num5 
   DEFINE n            LIKE type_t.num5 
   DEFINE g_acc302     LIKE gzcb_t.gzcb007  
   DEFINE g_acc301     LIKE gzcb_t.gzcb007   
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
         CALL ainp880_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON inpd008,inpddocno
                     
                      
            BEFORE CONSTRUCT
                                                      
            ON ACTION controlp INFIELD inpd008 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inpadocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd008  #顯示到畫面上
               NEXT FIELD inpd008                     #返回原欄位

            ON ACTION controlp INFIELD inpddocno      #产品分类
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inpddocno()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpddocno   #顯示到畫面上
               NEXT FIELD inpddocno                      #返回原欄位   


         END CONSTRUCT  

         CONSTRUCT BY NAME g_wc_inpd034 ON inpd034
	   
            BEFORE CONSTRUCT    

            ON ACTION controlp INFIELD inpd034 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd034  #顯示到畫面上
               NEXT FIELD inpd034  

            AFTER CONSTRUCT
            
         END CONSTRUCT      
         
         CONSTRUCT BY NAME g_wc_inpd032 ON inpd032
            BEFORE CONSTRUCT    

            ON ACTION controlp INFIELD inpd032 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd032  #顯示到畫面上
               NEXT FIELD inpd032  
               
            AFTER CONSTRUCT
            
         END CONSTRUCT      

         CONSTRUCT BY NAME g_wc_inpd033 ON inpd033
            BEFORE CONSTRUCT    
 
            AFTER FIELD inpd033
               LET g_inpd033 = GET_FLDBUF(inpd033)
               
            AFTER CONSTRUCT
            
         END CONSTRUCT  
                  
         
         CONSTRUCT BY NAME g_wc_inpd005 ON inpd005,inpd006
            BEFORE CONSTRUCT    
            
            ON ACTION controlp INFIELD inpd005 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa001_12()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd005  #顯示到畫面上
               NEXT FIELD inpd005      

            ON ACTION controlp INFIELD inpd006 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inab002_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd006  #顯示到畫面上
               NEXT FIELD inpd006 
               
         END CONSTRUCT           
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_invent,g_work,g_post,g_inbb016,g_inbb016_2,g_date,g_diff 
          FROM invent,work,post,inbb016,inbb016_2,date,diff        #160504-00019#3 add inbb016,inbb016_2
            BEFORE INPUT
               LET g_acc302 = ''
               LET g_acc301 = ''
               #SELECT gzcb004 INTO g_acc302 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint302'      #160816-00001#3   mark
               #SELECT gzcb004 INTO g_acc301 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint301'      #160816-00001#3   mark
               LET g_acc302 = s_fin_get_scc_value('24','aint302','2')  #160816-00001#3  Add
               LET g_acc301 = s_fin_get_scc_value('24','aint301','2')  #160816-00001#3  Add
               
               
               ON ACTION controlp INFIELD inbb016

		  	         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
		  	         LET g_qryparam.reqry = FALSE
		  	         LET g_qryparam.where = "1=1 "
#                  LET l_sql1 = ''
#                  CALL s_control_get_doc_sql("oocq002",g_inba_m.inbadocno,'8') RETURNING l_success,l_sql1
#                  IF l_success THEN
#                     LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
#                  END IF
             
                  LET g_qryparam.default1 = g_inbb016             #給予default值
             
                  #給予arg
                  LET g_qryparam.arg1 = g_acc302 #
             
                  CALL q_oocq002()                                #呼叫開窗
                  LET g_qryparam.where = " "
             
                  LET g_inbb016 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
                  DISPLAY g_inbb016 TO inbb016              #顯示到畫面上
                  #CALL aint302_inba007_ref(g_inba_m.inba007) RETURNING g_inba_m.inba007_desc
                  #DISPLAY BY NAME g_inba_m.inba007_desc
             
                  NEXT FIELD inbb016                          #返回原欄位  
                  
               ON ACTION controlp INFIELD inbb016_2

		  	         INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
		  	         LET g_qryparam.reqry = FALSE
		  	         LET g_qryparam.where = "1=1 "
#                  LET l_sql1 = ''
#                  CALL s_control_get_doc_sql("oocq002",g_inba_m.inbadocno,'8') RETURNING l_success,l_sql1
#                  IF l_success THEN
#                     LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
#                  END IF
             
                  LET g_qryparam.default1 = g_inbb016_2             #給予default值
             
                  #給予arg
                  LET g_qryparam.arg1 = g_acc301 #
             
                  CALL q_oocq002()                                #呼叫開窗
                  LET g_qryparam.where = " "
             
                  LET g_inbb016_2 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
                  DISPLAY g_inbb016_2 TO inbb016_2              #顯示到畫面上
                  #CALL aint302_inba007_ref(g_inba_m.inba007) RETURNING g_inba_m.inba007_desc
                  #DISPLAY BY NAME g_inba_m.inba007_desc
             
                  NEXT FIELD inbb016_2                          #返回原欄位                  
                  
               AFTER FIELD inbb016
                  IF NOT cl_null(g_inbb016) THEN
                     #1.抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
                     IF NOT s_azzi650_chk_exist(g_acc302,g_inbb016) THEN
                        NEXT FIELD inbb016
                     END IF     
                  END IF
                  
               AFTER FIELD inbb016_2
                  IF NOT cl_null(g_inbb016_2) THEN
                     #1.抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
                     IF NOT s_azzi650_chk_exist(g_acc301,g_inbb016_2) THEN
                        NEXT FIELD inbb016_2
                     END IF     
                  END IF
                  
            AFTER INPUT  
            
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               CALL ainp880_b_fill()
               LET g_detail_cnt = g_detail_d.getLength()
               IF g_detail_d.getLength() > 0 THEN
                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               ELSE
                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
               END IF   
               CALL cl_set_comp_visible("sel",TRUE)               
            BEFORE ROW

               LET l_ac = ARR_CURR()
            
               LET g_detail_cnt = g_detail_d.getLength()

         
            AFTER FIELD sel
               IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                  IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  NEXT FIELD sel
               END IF
                  
            AFTER ROW
                  
            AFTER INPUT
    
         END INPUT  
 
         INPUT ARRAY g_inpf_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_detail_cnt2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               CALL ainp880_b_fill_inpf()
               LET g_detail_cnt2 = g_inpf_d.getLength()
               IF g_inpf_d.getLength() > 0 THEN
                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               ELSE
                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
               END IF   
               CALL cl_set_comp_visible("sel01",TRUE)   
               
            BEFORE ROW

               LET l_ac2 = ARR_CURR()
            
               LET g_detail_cnt2 = g_inpf_d.getLength()

               CALL ainp880_b_fill_inpg() 
               
            AFTER FIELD sel01
               IF l_ac2 <> 0 THEN 
                  IF NOT cl_null(g_inpf_d[l_ac2].sel01) THEN
                     IF g_inpf_d[l_ac2].sel01 NOT MATCHES '[YN]' THEN
                        NEXT FIELD sel01
                     END IF
                  END IF
               END IF   

            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  NEXT FIELD sel01
               END IF
                  
            AFTER ROW
                  
            AFTER INPUT
    
         END INPUT   
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
#         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
#            BEFORE DISPLAY
#            
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
#         END DISPLAY
         
#         DISPLAY ARRAY g_inpf_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
#            BEFORE DISPLAY
#            
#            BEFORE ROW
#               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
#               LET l_ac2 = g_detail_idx2
#               DISPLAY g_detail_idx2 TO FORMONLY.h_index
#               DISPLAY g_inpf_d.getLength() TO FORMONLY.h_count 
#               CALL ainp880_b_fill_inpg()
#         END DISPLAY   

         DISPLAY ARRAY g_inpg_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3)
            BEFORE DISPLAY
            
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac3 = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.h_index
               DISPLAY g_inpg_d.getLength() TO FORMONLY.h_count  
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
 
            IF cl_null(g_invent) THEN LET g_invent = 'Y' END IF
            IF cl_null(g_work) THEN LET g_work = 'N' END IF
            IF cl_null(g_post) THEN LET g_post = 'Y' END IF
            IF cl_null(g_diff) THEN LET g_diff = 'N' END IF  
            IF cl_null(g_date) THEN LET g_date = g_today END IF            
            DISPLAY g_invent TO invent
            DISPLAY g_work TO work
            DISPLAY g_post TO post
            DISPLAY g_diff TO diff
            DISPLAY g_date TO date
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
            FOR li_idx01 = 1 TO g_inpf_d.getLength()
                LET g_inpf_d[li_idx01].sel01 = "Y"
            END FOR           
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
            FOR li_idx01 = 1 TO g_inpf_d.getLength()
                LET g_inpf_d[li_idx01].sel01 = "N"
            END FOR  
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx01 = 1 TO g_inpf_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx01) THEN
                  LET g_inpf_d[li_idx01].sel01 = "Y"
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx01 = 1 TO g_inpf_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx01) THEN
                  LET g_inpf_d[li_idx01].sel01 = "N"
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainp880_filter()
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
            
            #end add-point
            CALL ainp880_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL ainp880_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
#         ON ACTION all
#            FOR i = 1 TO g_detail_cnt 
#                LET g_detail_d[i].sel = "Y"            
#            END FOR
#            FOR j = 1 TO g_inpf_d.getLength()
#                LET g_inpf_d[j].sel01 = "Y"
#            END FOR 
#            IF i > 1 THEN
#               LET i = i - 1
#            END IF
#            IF j > 1 THEN
#               LET j = j - 1
#            END IF            
#         ON ACTION notall
#            FOR m = 1 TO g_detail_cnt  
#               LET g_detail_d[m].sel = "N"                    
#            END FOR     
#            FOR n = 1 TO g_inpf_d.getLength()
#                LET g_inpf_d[n].sel01 = "N"
#            END FOR
#            IF m > 1 THEN
#               LET m = m - 1
#            END IF
#            IF n > 1 THEN
#               LET n = n - 1
#            END IF            
         ON ACTION batch_execute
         
            IF g_post = 'Y' THEN
               IF NOT ainp880_post_upd() THEN
                  #過賬失敗
               END IF
            END IF  
            IF g_post = 'N' THEN
               IF NOT ainp880_unpost_upd() THEN
               #過賬還原失敗
               END IF
            END IF              
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
 
{<section id="ainp880.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp880_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_error_show = 1
   CALL ainp880_b_fill()
   LET l_ac = g_master_idx
   CALL ainp880_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG AND g_invent = 'Y'THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = -100 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err() 
#   END IF
   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL ainp880_b_fill()
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
 
{<section id="ainp880.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp880_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_wc            STRING
   DEFINE l_wc2           STRING
   DEFINE l_wc3           STRING
   DEFINE l_wc4           STRING
   DEFINE l_wc5           STRING
   DEFINE l_wc6           STRING
   DEFINE l_wc7           STRING
   DEFINE l_wc8           STRING
   DEFINE l_wc9           STRING
   DEFINE l_inpd008_t     LIKE inpd_t.inpd008   
   DEFINE l_inpa009       LIKE inpa_t.inpa009
   DEFINE l_inpa010       LIKE inpa_t.inpa009
   DEFINE l_inpa011       LIKE inpa_t.inpa009
   DEFINE l_inpa012       LIKE inpa_t.inpa009
   DEFINE l_inpd030       LIKE inpd_t.inpd030
   DEFINE l_inpd050       LIKE inpd_t.inpd050  
   DEFINE l_inpa008       LIKE inpa_t.inpa008   
   DEFINE l_yes           LIKE inpa_t.inpa009
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1"  END IF
   IF g_invent = 'Y' THEN  #現有庫存
      LET g_sql = " SELECT DISTINCT 'N',inpddocno,inpdseq,inpd001,'','',inpd005,'',inpd006,'',inpd007,inpd002,'',inpd010,'',inpd011,inpd036,inpd056,inpd003,inpd015,inpd012,'',inpd013,inpd008,inpdstus,inpdpstdt,inpd030,inpd050,inpd034,inpd040,inpd054,inpd060, ",
                  "                 inpd037,inpd057,inpd031,inpd051 FROM inpd_t ",  #160504-00019#3   add inpd013,inpd037,inpd057,inpd031,inpd051
                  "   LEFT OUTER JOIN inpa_t ON inpaent = inpdent AND inpasite = inpdsite AND inpadocno = inpd008",
#                  "   LEFT OUTER JOIN inpb_t ON inpaent = inpbent AND inpasite = inpbsite AND inpbdocno = inpadocno ",
                  "  WHERE inpdent = ? ",
                  "    AND inpdsite = '",g_site,"'",
#                  "    AND (inpb001 = '6' OR inpb001 = '10')",
                  "    AND ",g_wc
                  
      IF NOT cl_null(g_wc_inpd034) THEN
         LET l_wc = cl_replace_str(g_wc_inpd034,'inpd034','inpd040')
         LET l_wc2 = cl_replace_str(g_wc_inpd034,'inpd034','inpd054')
         LET l_wc3 = cl_replace_str(g_wc_inpd034,'inpd034','inpd060')
         LET g_sql = g_sql," AND (",l_wc," OR ",g_wc_inpd034," OR ",l_wc2," OR ",l_wc3,")"
      END IF
      IF NOT cl_null(g_wc_inpd032) THEN      
         LET l_wc4 = cl_replace_str(g_wc_inpd032,'inpd032','inpd038')
         LET l_wc5 = cl_replace_str(g_wc_inpd032,'inpd032','inpd052')
         LET l_wc6 = cl_replace_str(g_wc_inpd032,'inpd032','inpd058')
         LET g_sql = g_sql," AND (",l_wc4," OR ",g_wc_inpd032," OR ",l_wc5," OR ",l_wc6,")"
      END IF   
      IF NOT cl_null(g_wc_inpd033) THEN      
         LET l_wc7 = cl_replace_str(g_wc_inpd033,'inpd033','inpd039')
         LET l_wc8 = cl_replace_str(g_wc_inpd033,'inpd033','inpd053')
         LET l_wc9 = cl_replace_str(g_wc_inpd033,'inpd033','inpd059')
         LET g_sql = g_sql," AND (",l_wc3," OR ",g_wc_inpd033," OR ",l_wc8," OR ",l_wc9,")"
      END IF        
      IF NOT cl_null(g_wc_inpd005) THEN
         LET g_sql = g_sql," AND ",g_wc_inpd005
      END IF                       
      IF g_post = 'Y' THEN   #過賬
           
      END IF
            
      IF g_post = 'N' THEN   #過賬還原
         LET g_sql = g_sql," AND inpdstus = 'S' "
      END IF   
      IF g_diff = 'Y' THEN

      END IF
      LET g_sql = g_sql," ORDER BY inpd008,inpddocno,inpdseq"
   END IF
   #end add-point
 
   PREPARE ainp880_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp880_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"

   LET l_inpd008_t = ''   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
                             g_detail_d[l_ac].sel,g_detail_d[l_ac].inpddocno,g_detail_d[l_ac].inpdseq,g_detail_d[l_ac].inpd001,g_detail_d[l_ac].inpd001_desc,g_detail_d[l_ac].inpd001_desc_desc,
                             g_detail_d[l_ac].inpd005,g_detail_d[l_ac].inpd005_desc,g_detail_d[l_ac].inpd006,g_detail_d[l_ac].inpd006_desc,g_detail_d[l_ac].inpd007,g_detail_d[l_ac].inpd002,
                             g_detail_d[l_ac].inpd002_desc,g_detail_d[l_ac].inpd010,g_detail_d[l_ac].inpd010_desc,g_detail_d[l_ac].inpd011,g_detail_d[l_ac].inpd036,g_detail_d[l_ac].inpd056,
                             g_detail_d[l_ac].inpd003,g_detail_d[l_ac].inpd015,g_detail_d[l_ac].inpd012,g_detail_d[l_ac].inpd012_desc,g_detail_d[l_ac].inpd013,g_detail_d[l_ac].inpd008,g_detail_d[l_ac].inpdstus,
                             g_detail_d[l_ac].inpdpstdt,g_detail_d[l_ac].inpd030,g_detail_d[l_ac].inpd050,g_detail_d[l_ac].inpd034,g_detail_d[l_ac].inpd040,g_detail_d[l_ac].inpd054,g_detail_d[l_ac].inpd060,
                             g_detail_d[l_ac].inpd037,g_detail_d[l_ac].inpd057,g_detail_d[l_ac].inpd031,g_detail_d[l_ac].inpd051   #160504-00019#3
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
      #現有庫存
      IF cl_null(g_detail_d[l_ac].inpd011) THEN
         LET g_detail_d[l_ac].inpd011 = 0
      END IF
      #160504-00019#3
      IF cl_null(g_detail_d[l_ac].inpd013) THEN
         LET g_detail_d[l_ac].inpd013 = 0
      END IF  
      #160504-00019#3      
#      IF l_inpd008 <> l_inpd008_t OR l_inpd008_t IS NULL THEN  
      SELECT inpa009,inpa010,inpa011,inpa012,inpa008 INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012,l_inpa008 FROM inpa_t
       WHERE inpaent = g_enterprise
         AND inpasite = g_site
         AND inpadocno = g_detail_d[l_ac].inpd008


      IF l_inpa012 = 'Y' OR l_inpa011 = 'Y' THEN   #復盤
         IF g_post = 'Y' THEN
            IF g_detail_d[l_ac].inpdstus <> '6' THEN
               INITIALIZE g_detail_d[l_ac].* TO NULL 
               CONTINUE FOREACH
            END IF
         END IF
         #add by lixh 20150401
         IF l_inpa008 = '1' THEN #全盘
            IF cl_null(g_detail_d[l_ac].inpd056) THEN
               LET g_detail_d[l_ac].inpd056 = g_detail_d[l_ac].inpd050 
            END IF
         ELSE
            IF cl_null(g_detail_d[l_ac].inpd060) THEN   
               IF NOT cl_null(g_detail_d[l_ac].inpd054) THEN
                 LET g_detail_d[l_ac].inpd056 = g_detail_d[l_ac].inpd050 
               ELSE
                 LET g_detail_d[l_ac].inpd056 = ''                
               END IF
            END IF            
         END IF
         #add by lixh 20150401     

         #160504-00019#3
         IF l_inpa008 = '1' THEN #全盘
            IF cl_null(g_detail_d[l_ac].inpd057) THEN
               LET g_detail_d[l_ac].inpd057 = g_detail_d[l_ac].inpd051
            END IF
         ELSE
            IF cl_null(g_detail_d[l_ac].inpd060) THEN   
               IF NOT cl_null(g_detail_d[l_ac].inpd054) THEN
                 LET g_detail_d[l_ac].inpd057 = g_detail_d[l_ac].inpd051 
               ELSE
                 LET g_detail_d[l_ac].inpd057 = ''                
               END IF
            END IF            
         END IF        
         #160504-00019#3
         
#         IF g_diff = 'Y' THEN  #僅處理有盤點差異的資料
#            IF NOT cl_null(g_detail_d[l_ac].inpd056) AND g_detail_d[l_ac].inpd011 = g_detail_d[l_ac].inpd056 THEN  #無差異不呈現
#               CONTINUE FOREACH
#            END IF
#         END IF     
         
      ELSE
      #初盤
         IF g_post = 'Y' THEN
            IF g_detail_d[l_ac].inpdstus <> '5' THEN
               INITIALIZE g_detail_d[l_ac].* TO NULL 
               CONTINUE FOREACH
            END IF
         END IF
         #add by lixh 20150401
         IF l_inpa008 = '1' THEN #全盘
            IF cl_null(g_detail_d[l_ac].inpd036) THEN
               LET g_detail_d[l_ac].inpd036 = g_detail_d[l_ac].inpd030 
            END IF
         ELSE
            IF cl_null(g_detail_d[l_ac].inpd040) THEN   
               IF NOT cl_null(g_detail_d[l_ac].inpd034) THEN
                  LET g_detail_d[l_ac].inpd036 = g_detail_d[l_ac].inpd030 
               ELSE
                  LET g_detail_d[l_ac].inpd036 = ''                
               END IF
            END IF            
         END IF
         #add by lixh 20150401  

         #160504-00019#3         
         IF l_inpa008 = '1' THEN #全盘
            IF cl_null(g_detail_d[l_ac].inpd037) THEN
               LET g_detail_d[l_ac].inpd037 = g_detail_d[l_ac].inpd031 
            END IF
         ELSE
            IF cl_null(g_detail_d[l_ac].inpd040) THEN   
               IF NOT cl_null(g_detail_d[l_ac].inpd034) THEN
                  LET g_detail_d[l_ac].inpd037 = g_detail_d[l_ac].inpd031 
               ELSE
                  LET g_detail_d[l_ac].inpd037 = ''                
               END IF
            END IF            
         END IF         
         #160504-00019#3
         
#         IF l_inpa010 = 'N' AND l_inpa009 = 'Y' THEN
#            LET g_detail_d[l_ac].inpd036 = l_inpd030
#         END IF   
#         IF g_diff = 'Y' THEN  #僅處理有盤點差異的資料
#            IF NOT cl_null(g_detail_d[l_ac].inpd036) AND g_detail_d[l_ac].inpd011 = g_detail_d[l_ac].inpd036 THEN  #無差異不呈現
#               CONTINUE FOREACH
#            END IF
#         END IF             
      END IF
         #add by lixh 20150401
#         IF l_inpa008 = '1' THEN #全盘
#            IF NOT cl_null(g_detail_d[l_ac].inpd030) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd030
#            END IF
#            IF NOT cl_null(g_detail_d[l_ac].inpd036) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd036
#            END IF 
#            LET             
#            IF NOT cl_null(g_detail_d[l_ac].inpd050) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd050
#            END IF   
#            IF NOT cl_null(g_detail_d[l_ac].inpd056) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd056
#            END IF 
#            LET g_detail_d[l_ac].inpd056 = l_pd_num           
#         ELSE #盤差輸入
#            IF NOT cl_null(g_detail_d[l_ac].inpd034) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd030
#            END IF  
#            IF NOT cl_null(g_detail_d[l_ac].inpd040) THEN
#               LET l_pd_num = g_detail_d[l_ac].inpd036
#            END IF              
#         END IF   
         #add by lixh 20150401
      IF g_diff = 'Y' THEN  #僅處理有盤點差異的資料
                  
         #160504-00019#3 mark 
#         IF NOT cl_null(g_detail_d[l_ac].inpd056) AND g_detail_d[l_ac].inpd011 = g_detail_d[l_ac].inpd056 THEN  #無差異不呈現
#            CONTINUE FOREACH
#         END IF
#         IF cl_null(g_detail_d[l_ac].inpd056) AND (g_detail_d[l_ac].inpd011 = g_detail_d[l_ac].inpd036 OR cl_null(g_detail_d[l_ac].inpd036)) THEN
#            CONTINUE FOREACH
#         END IF
        #160504-00019#3 mark 
        
         #160504-00019#3
         LET l_yes = 'N'
         IF NOT cl_null(g_detail_d[l_ac].inpd056) OR NOT cl_null(g_detail_d[l_ac].inpd057) THEN
            IF NOT cl_null(g_detail_d[l_ac].inpd056) AND g_detail_d[l_ac].inpd011 <> g_detail_d[l_ac].inpd056 THEN  #無差異不呈現
               LET l_yes = 'Y' 
            END IF
            IF NOT cl_null(g_detail_d[l_ac].inpd057) AND g_detail_d[l_ac].inpd013 <> g_detail_d[l_ac].inpd057 THEN  #無差異不呈現
               LET l_yes = 'Y' 
            END IF 
            IF l_yes = 'N' THEN
               INITIALIZE g_detail_d[l_ac].* TO NULL 
               CONTINUE FOREACH
            END IF            
         END IF   
         IF cl_null(g_detail_d[l_ac].inpd056) AND cl_null(g_detail_d[l_ac].inpd057) THEN        
            IF cl_null(g_detail_d[l_ac].inpd056) AND g_detail_d[l_ac].inpd011 <> g_detail_d[l_ac].inpd036 THEN
               LET l_yes = 'Y'
            END IF  
            IF cl_null(g_detail_d[l_ac].inpd057) AND g_detail_d[l_ac].inpd013 <> g_detail_d[l_ac].inpd037 THEN
               LET l_yes = 'Y'
            END IF   
            IF l_yes = 'N' THEN
               INITIALIZE g_detail_d[l_ac].* TO NULL 
               CONTINUE FOREACH
            END IF             
         END IF
         #160504-00019#3
         
      END IF
      
      #end add-point
      
      CALL ainp880_detail_show()      
 
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
   FREE ainp880_sel
   
   LET l_ac = 1
   CALL ainp880_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   IF g_work = 'Y' THEN  #在製工單
      CALL ainp880_b_fill_inpf()
   END IF       
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp880.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp880_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="ainp880.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp880_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   CALL s_desc_get_item_desc(g_detail_d[l_ac].inpd001) RETURNING g_detail_d[l_ac].inpd001_desc,g_detail_d[l_ac].inpd001_desc_desc
   CALL s_desc_get_stock_desc(g_site,g_detail_d[l_ac].inpd005) RETURNING g_detail_d[l_ac].inpd005_desc
   CALL s_desc_get_locator_desc(g_site,g_detail_d[l_ac].inpd005,g_detail_d[l_ac].inpd006) RETURNING g_detail_d[l_ac].inpd006_desc
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].inpd010) RETURNING g_detail_d[l_ac].inpd010_desc
   CALL s_desc_get_unit_desc(g_detail_d[l_ac].inpd012) RETURNING g_detail_d[l_ac].inpd012_desc   #160504-00019#3
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp880.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ainp880_filter()
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
   
   CALL ainp880_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp880.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ainp880_filter_parser(ps_field)
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
 
{<section id="ainp880.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ainp880_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainp880_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp880.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 在製工單查詢
# Memo...........:
# Usage..........: CALL ainp880_b_fill_inpg()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_b_fill_inpg()
   DEFINE li_ac           LIKE type_t.num5  
   DEFINE l_inpa009       LIKE inpa_t.inpa009
   DEFINE l_inpa010       LIKE inpa_t.inpa010
   DEFINE l_inpa011       LIKE inpa_t.inpa011 
   DEFINE l_inpa012       LIKE inpa_t.inpa012 
   DEFINE l_inpa013       LIKE inpa_t.inpa009
   DEFINE l_inpa014       LIKE inpa_t.inpa010
   DEFINE l_inpa015       LIKE inpa_t.inpa011 
   DEFINE l_inpa016       LIKE inpa_t.inpa012   
   DEFINE l_inpg030       LIKE inpg_t.inpg030
   DEFINE l_inpg050       LIKE inpg_t.inpg050
   DEFINE l_inpa008       LIKE inpa_t.inpa008
   DEFINE l_flag          LIKE type_t.chr1   
   DEFINE g_acc           LIKE gzcb_t.gzcb004   
   DEFINE p_inpf004       LIKE inpf_t.inpf004
   
   LET li_ac = l_ac2

   CALL g_inpg_d.clear()
   IF l_ac2 = 0 THEN
      RETURN
   END IF
   LET g_sql = "SELECT  UNIQUE inpgseq1,inpgseq2,inpg001,'','',inpg010,inpg007,'',inpg012,inpg033,inpg053,inpg003,inpg013,inpg030,inpg050,inpg031,inpg034,inpg051,inpg054 ",
               "  FROM inpg_t ",
               " WHERE inpgent=? AND inpgsite=? AND inpgdocno=? AND inpgseq=?"
 
   LET g_sql = g_sql, " ORDER BY inpg_t.inpgseq1,inpg_t.inpgseq2"  
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   PREPARE ainp880_pb2_inpg FROM g_sql
   DECLARE b_fill_curs2_inpg CURSOR FOR ainp880_pb2_inpg
 
   OPEN b_fill_curs2_inpg USING g_enterprise, g_site,g_inpf_d[l_ac2].inpfdocno,
                                g_inpf_d[l_ac2].inpfseq
 
  
   LET l_ac3 = 1
   LET l_flag = 'N' 
   
   FOREACH b_fill_curs2_inpg INTO g_inpg_d[l_ac3].inpgseq1,g_inpg_d[l_ac3].inpgseq2,g_inpg_d[l_ac3].inpg001,g_inpg_d[l_ac3].inpg001_desc,
                                  g_inpg_d[l_ac3].inpg001_desc_desc,g_inpg_d[l_ac3].inpg010,g_inpg_d[l_ac3].inpg007,g_inpg_d[l_ac3].inpg007_desc,
                                  g_inpg_d[l_ac3].inpg012,g_inpg_d[l_ac3].inpg033,g_inpg_d[l_ac3].inpg053,
                                  g_inpg_d[l_ac3].inpg003,g_inpg_d[l_ac3].inpg013,g_inpg_d[l_ac3].inpg030,g_inpg_d[l_ac3].inpg050,
                                  g_inpg_d[l_ac3].inpg031,g_inpg_d[l_ac3].inpg034,g_inpg_d[l_ac3].inpg051,g_inpg_d[l_ac3].inpg054
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #160317-00023#1
      SELECT inpf004 INTO p_inpf004 FROM inpf_t
       WHERE inpfent = g_enterprise
         AND inpfsite = g_site
         AND inpfdocno = g_inpf_d[l_ac2].inpfdocno
         AND inpfseq = g_inpf_d[l_ac2].inpfseq
      #160317-00023#1
      
      SELECT inpa013,inpa014,inpa015,inpa016,inpa008 INTO l_inpa013,l_inpa014,l_inpa015,l_inpa016,l_inpa008 FROM inpa_t
       WHERE inpaent = g_enterprise
         AND inpasite = g_site
         AND inpadocno = p_inpf004
         
      #add by lixh 20150401
      IF l_inpa015 = 'Y' OR l_inpa016 = 'Y' THEN
         IF l_inpa008 = '1' THEN   #全輸入
            IF cl_null(g_inpg_d[l_ac3].inpg053) THEN
               IF NOT cl_null(g_inpg_d[l_ac3].inpg050) THEN
                  LET g_inpg_d[l_ac3].inpg053 = g_inpg_d[l_ac3].inpg050
               ELSE
                  LET g_inpg_d[l_ac3].inpg053 = ''            
               END IF
            ELSE
               IF cl_null(g_inpg_d[l_ac3].inpg054) THEN
                  IF NOT cl_null(g_inpg_d[l_ac3].inpg051) THEN
                     LET g_inpg_d[l_ac3].inpg053 = g_inpg_d[l_ac3].inpg050
                  ELSE
                     LET g_inpg_d[l_ac3].inpg053 = ''                 
                  END IF
               END IF            
            END IF
         #160317-00023#1   
         ELSE
            IF cl_null(g_inpg_d[l_ac3].inpg053) THEN
               IF NOT cl_null(g_inpg_d[l_ac3].inpg050) THEN 
                  LET g_inpg_d[l_ac3].inpg053 = g_inpg_d[l_ac3].inpg050
               END IF
            END IF
         #160317-00023#1
         END IF
      END IF
      IF l_inpa013 = 'Y' OR l_inpa014 = 'Y' THEN
         IF l_inpa008 = '1' THEN   #全輸入
            IF cl_null(g_inpg_d[l_ac3].inpg033) THEN
               IF NOT cl_null(g_inpg_d[l_ac3].inpg030) THEN
                  LET g_inpg_d[l_ac3].inpg033 = g_inpg_d[l_ac3].inpg030
               ELSE
                  LET g_inpg_d[l_ac3].inpg033 = ''            
               END IF
            ELSE
               IF cl_null(g_inpg_d[l_ac3].inpg034) THEN
                  IF NOT cl_null(g_inpg_d[l_ac3].inpg031) THEN
                     LET g_inpg_d[l_ac3].inpg033 = g_inpg_d[l_ac3].inpg030
                  ELSE
                     LET g_inpg_d[l_ac3].inpg033 = ''                 
                  END IF
               END IF            
            END IF
         #160317-00023#1   
         ELSE
            IF cl_null(g_inpg_d[l_ac3].inpg033) THEN
               IF NOT cl_null(g_inpg_d[l_ac3].inpg030) THEN 
                  LET g_inpg_d[l_ac3].inpg033 = g_inpg_d[l_ac3].inpg030
               END IF
            END IF
         #160317-00023#1            
         END IF
      END IF      
      #add by lixh 20150401   
      
      IF g_diff = 'Y' THEN    #僅處理有盤點差異的資料
#         IF cl_null(g_inpg_d[l_ac3].inpg033) THEN LET g_inpg_d[l_ac3].inpg033 = 0 END IF
#         IF cl_null(g_inpg_d[l_ac3].inpg053) THEN LET g_inpg_d[l_ac3].inpg053 = 0 END IF 
#         IF cl_null(l_inpg030) THEN LET l_inpg030 = 0 END IF          
#         IF cl_null(l_inpg050) THEN LET l_inpg050 = 0 END IF 
#         IF (g_inpg_d[l_ac3].inpg033 = l_inpg030) AND (l_inpa013 = 'Y' OR l_inpa014 = 'Y') THEN
#            CONTINUE FOREACH
#         END IF
#         IF (g_inpg_d[l_ac3].inpg053 = l_inpg050) AND (l_inpa014 = 'Y' OR l_inpa015 = 'Y') THEN
#            CONTINUE FOREACH
#         END IF 
          IF NOT cl_null(g_inpg_d[l_ac3].inpg053) AND g_inpg_d[l_ac3].inpg053 = g_inpg_d[l_ac3].inpg012 THEN
             CONTINUE FOREACH
          END IF
          IF cl_null(g_inpg_d[l_ac3].inpg053) AND (g_inpg_d[l_ac3].inpg033 = g_inpg_d[l_ac3].inpg012 OR cl_null(g_inpg_d[l_ac3].inpg033)) THEN
             CONTINUE FOREACH
          END IF          
      END IF
               
#      IF l_inpa013 = 'Y' AND l_inpa014 = 'N' THEN 
#         LET g_inpg_d[l_ac3].inpg033 = l_inpg030
#      END IF
#      
#      IF l_inpa015 = 'Y' AND l_inpa016= 'N' THEN 
#         LET g_inpg_d[l_ac3].inpg053 = l_inpg050
#      END IF      

      CALL ainp880_inpg_desc()
      
      
 
      IF l_ac3 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac3= l_ac3 + 1  
   
   END FOREACH
   CALL g_inpg_d.deleteElement(g_inpg_d.getLength())
 

   LET li_ac = g_inpg_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx3 = 1
   DISPLAY g_detail_idx3 TO FORMONLY.idx   
END FUNCTION

################################################################################
# Descriptions...: 在製工單單頭顯示
# Memo...........:
# Usage..........: CALL ainp880_b_fill_inpf()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_b_fill_inpf()
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING   
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE l_wc            STRING
   DEFINE l_wc2           STRING
   DEFINE l_wc3           STRING
   DEFINE l_wc4           STRING  
   DEFINE l_wc5           STRING
   DEFINE l_wc6           STRING
   DEFINE l_wc7           STRING  
   DEFINE l_wc8           STRING
   DEFINE l_wc9           STRING   
   DEFINE l_wc10          STRING
   DEFINE l_wc11          STRING
   DEFINE l_wc12          STRING   
   DEFINE l_inpfstus      LIKE inpf_t.inpfstus  
   DEFINE l_inpa013       LIKE inpa_t.inpa013   
   DEFINE l_inpa014       LIKE inpa_t.inpa014  
   DEFINE l_inpa015       LIKE inpa_t.inpa015
   DEFINE l_inpa016       LIKE inpa_t.inpa016
   
   LET g_detail_idx2  = 1
   LET g_detail_idx3 = 1
   
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
 
   CALL g_inpf_d.clear()
 
   LET g_cnt2 = l_ac2
   IF g_cnt2 = 0 THEN
      LET g_cnt2 = 1
   END IF   
   LET l_ac2 = 1
   ERROR "Searching!" 
   LET ls_wc2 = cl_replace_str(ls_wc,'inpd008','inpf004') 
   LET ls_wc2 = cl_replace_str(ls_wc2,'inpddocno','inpfdocno')      
      
   IF cl_null(g_wc) THEN LET g_wc = " 1=1"  END IF
   IF g_work = 'Y' THEN  #在製工單
      LET g_sql = " SELECT DISTINCT 'N',inpfdocno,inpfseq,inpf001,inpf003,'','',inpf002,'',inpf006,'',inpf007,inpf004,inpfpstdt,inpfstus FROM inpf_t",
                  " LEFT JOIN inpg_t ON inpgent = inpfent AND inpgsite = inpfsite AND inpgdocno = inpfdocno AND inpgseq = inpfseq ",
#                  " LEFT JOIN inpb_t ON inpbent = inpfent AND inpbsite = inpfsite AND inpbdocno = inpf004 ",
                  " LEFT JOIN inpa_t ON inpaent = inpfent AND inpasite = inpfsite AND inpadocno = inpf004 ",        
                  "  WHERE inpfent = ? ",
                  "    AND inpfsite = '",g_site,"'",
#                  "    AND (inpb001 = '7' OR inpb001 = '11')",
                  "    AND ",ls_wc2      

      IF NOT cl_null(g_wc_inpd032) THEN      
         LET l_wc = cl_replace_str(g_wc_inpd032,'inpd032','inpf020')
         LET l_wc2 = cl_replace_str(g_wc_inpd032,'inpd032','inpf022')
         LET l_wc3 = cl_replace_str(g_wc_inpd032,'inpd032','inpf024')
         LET l_wc4 = cl_replace_str(g_wc_inpd032,'inpd032','inpf026')         
         LET g_sql = g_sql," AND (",l_wc2," OR ",l_wc," OR ",l_wc3," OR ",l_wc4,")"
      END IF   
      IF NOT cl_null(g_wc_inpd033) THEN      
         LET l_wc5 = cl_replace_str(g_wc_inpd033,'inpd033','inpf021')
         LET l_wc6 = cl_replace_str(g_wc_inpd033,'inpd033','inpf023')
         LET l_wc7 = cl_replace_str(g_wc_inpd033,'inpd033','inpf025')
         LET l_wc8 = cl_replace_str(g_wc_inpd033,'inpd033','inpf027')         
         LET g_sql = g_sql," AND (",l_wc5," OR ",l_wc6," OR ",l_wc7," OR ",l_wc8,")"
      END IF 
      IF NOT cl_null(g_wc_inpd034) THEN  
         LET l_wc9 = cl_replace_str(g_wc_inpd034,'inpd034','inpg031')
         LET l_wc10 = cl_replace_str(g_wc_inpd034,'inpd034','inpg034')
         LET l_wc11 = cl_replace_str(g_wc_inpd034,'inpd034','inpg051')
         LET l_wc12 = cl_replace_str(g_wc_inpd034,'inpd034','inpg054')         
         LET g_sql = g_sql," AND (",l_wc9," OR ",l_wc10," OR ",l_wc11," OR ",l_wc12,")"      
      END IF
      
      IF g_post = 'N' THEN
         LET g_sql = g_sql," AND inpfstus = 'S' "
      END IF 
      
      LET g_sql = g_sql, cl_sql_add_filter("inpf_t"),
                         " ORDER BY inpf_t.inpf004,inpf_t.inpfdocno,inpf_t.inpfseq"   #160517-00016#1 add inpf004
      

      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      
      
      PREPARE ainp880_pb_inpf FROM g_sql
      DECLARE b_fill_curs_inpf CURSOR FOR ainp880_pb_inpf
      
      OPEN b_fill_curs_inpf USING g_enterprise
      
      FOREACH b_fill_curs_inpf INTO g_inpf_d[l_ac2].sel01,g_inpf_d[l_ac2].inpfdocno,g_inpf_d[l_ac2].inpfseq,g_inpf_d[l_ac2].inpf001,
                                    g_inpf_d[l_ac2].inpf003,g_inpf_d[l_ac2].inpf003_desc,g_inpf_d[l_ac2].inpf003_desc_desc,g_inpf_d[l_ac2].inpf002,g_inpf_d[l_ac2].inpf002_desc,
                                    g_inpf_d[l_ac2].inpf006,g_inpf_d[l_ac2].inpf006_desc,g_inpf_d[l_ac2].inpf007,g_inpf_d[l_ac2].inpf004,g_inpf_d[l_ac2].inpfpstdt,l_inpfstus
                                    
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            EXIT FOREACH
         END IF   
         
         SELECT inpa013,inpa014,inpa015,inpa016 INTO l_inpa013,l_inpa014,l_inpa015,l_inpa016 FROM inpa_t
          WHERE inpaent = g_enterprise
            AND inpasite = g_site
            AND inpadocno = g_inpf_d[l_ac2].inpf004
         IF l_inpa015 = 'Y' OR l_inpa016 = 'Y' THEN   #復盤
            IF g_post = 'Y' THEN
               IF l_inpfstus <> '6' THEN
                  CONTINUE FOREACH
               END IF
            END IF            
         ELSE
            #初盤
            IF g_post = 'Y' THEN
               IF l_inpfstus <> '5' THEN
                  CONTINUE FOREACH
               END IF
            END IF             
         END IF      
      
         CALL ainp880_inpf_desc()
         
         IF l_ac2 > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   =  9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
      
            END IF
            EXIT FOREACH
         END IF
         LET l_ac2 = l_ac2 + 1                                 
      END FOREACH    
      
      CALL g_inpf_d.deleteElement(l_ac2)
      LET l_ac2 = l_ac2 - 1
      
      LET g_error_show = 0
      
      LET g_detail_cnt2 = g_inpf_d.getLength()
      DISPLAY g_detail_cnt2 TO FORMONLY.h_count
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.h_index
      LET l_ac2 = g_cnt2
      LET g_cnt2 = 0

      CLOSE b_fill_curs_inpf
      FREE ainp880_pb_inpf 
#      LET l_ac2 = 1
      CALL ainp880_b_fill_inpg()     
      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp880_inpf_desc()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_inpf_desc()
    CALL s_desc_get_item_desc(g_inpf_d[l_ac2].inpf003) RETURNING g_inpf_d[l_ac2].inpf003_desc,g_inpf_d[l_ac2].inpf003_desc_desc
    CALL s_desc_get_acc_desc('221',g_inpf_d[l_ac2].inpf002) RETURNING g_inpf_d[l_ac2].inpf002_desc
    CALL s_desc_get_department_desc(g_inpf_d[l_ac2].inpf006) RETURNING g_inpf_d[l_ac2].inpf006_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp880_inpg_desc()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_inpg_desc()
   CALL s_desc_get_item_desc(g_inpg_d[l_ac3].inpg001) RETURNING g_inpg_d[l_ac3].inpg001_desc,g_inpg_d[l_ac3].inpg001_desc_desc
   CALL s_desc_get_unit_desc(g_inpg_d[l_ac3].inpg007) RETURNING g_inpg_d[l_ac3].inpg007_desc
END FUNCTION

################################################################################
# Descriptions...: 庫存過賬
# Memo...........:
# Usage..........: CALL ainp880_post_upd()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_post_upd()
DEFINE  i            LIKE type_t.num5 
DEFINE  j            LIKE type_t.num5 
DEFINE  l_cnt        LIKE type_t.num5
DEFINE  m            LIKE type_t.num5 
DEFINE  n            LIKE type_t.num5 
DEFINE  l_inag008    LIKE inag_t.inag008
DEFINE  l_type       LIKE inaj_t.inaj004
DEFINE  l_more       LIKE inpd_t.inpd036
DEFINE  l_success    LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_inpeseq2   LIKE inpe_t.inpeseq2
DEFINE  l_inpa009    LIKE inpa_t.inpa009
DEFINE  l_inpa010    LIKE inpa_t.inpa010
DEFINE  l_inpa011    LIKE inpa_t.inpa011 
DEFINE  l_inpa012    LIKE inpa_t.inpa012 
DEFINE  l_inpa013    LIKE inpa_t.inpa013
DEFINE  l_inpa014    LIKE inpa_t.inpa014
DEFINE  l_inpa015    LIKE inpa_t.inpa015
DEFINE  l_inpa016    LIKE inpa_t.inpa016
DEFINE  l_inpa050    LIKE inpa_t.inpa050
DEFINE  l_inpa051    LIKE inpa_t.inpa051
DEFINE  l_inpa052    LIKE inpa_t.inpa052
DEFINE  l_inpa053    LIKE inpa_t.inpa053
DEFINE  l_inpa054    LIKE inpa_t.inpa054
DEFINE  l_sfba018    LIKE sfba_t.sfba018
DEFINE  l_sfba018_1  LIKE sfba_t.sfba018
#DEFINE  l_sfda       RECORD LIKE sfda_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfda RECORD  #發退料單頭檔
       sfdaent LIKE sfda_t.sfdaent, #企业编号
       sfdasite LIKE sfda_t.sfdasite, #营运据点
       sfdadocno LIKE sfda_t.sfdadocno, #发退料单号
       sfdadocdt LIKE sfda_t.sfdadocdt, #单据日期
       sfda001 LIKE sfda_t.sfda001, #过账日期
       sfda002 LIKE sfda_t.sfda002, #发退料类别
       sfda003 LIKE sfda_t.sfda003, #生产部门
       sfda004 LIKE sfda_t.sfda004, #申请人
       sfda005 LIKE sfda_t.sfda005, #PBI编号
       sfda006 LIKE sfda_t.sfda006, #生产料号
       sfda007 LIKE sfda_t.sfda007, #BOM特性
       sfda008 LIKE sfda_t.sfda008, #产品特征
       sfda009 LIKE sfda_t.sfda009, #生产控制组
       sfda010 LIKE sfda_t.sfda010, #作业编号
       sfda011 LIKE sfda_t.sfda011, #作业序
       sfda012 LIKE sfda_t.sfda012, #库位
       sfda013 LIKE sfda_t.sfda013, #套数
       sfda014 LIKE sfda_t.sfda014, #来源单号
       sfda015 LIKE sfda_t.sfda015, #来源类型
       sfdaownid LIKE sfda_t.sfdaownid, #资料所有者
       sfdaowndp LIKE sfda_t.sfdaowndp, #资料所有部门
       sfdacrtid LIKE sfda_t.sfdacrtid, #资料录入者
       sfdacrtdp LIKE sfda_t.sfdacrtdp, #资料录入部门
       sfdacrtdt LIKE sfda_t.sfdacrtdt, #资料创建日
       sfdamodid LIKE sfda_t.sfdamodid, #资料更改者
       sfdamoddt LIKE sfda_t.sfdamoddt, #最近更改日
       sfdacnfid LIKE sfda_t.sfdacnfid, #资料审核者
       sfdacnfdt LIKE sfda_t.sfdacnfdt, #数据审核日
       sfdapstid LIKE sfda_t.sfdapstid, #资料过账者
       sfdapstdt LIKE sfda_t.sfdapstdt, #资料过账日
       sfdastus LIKE sfda_t.sfdastus #状态码
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
#DEFINE  l_sfdd       RECORD LIKE sfdd_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfdd RECORD  #發退料明細檔
       sfddent LIKE sfdd_t.sfddent, #企业编号
       sfddsite LIKE sfdd_t.sfddsite, #营运据点
       sfdddocno LIKE sfdd_t.sfdddocno, #发退料单号
       sfddseq LIKE sfdd_t.sfddseq, #项次
       sfddseq1 LIKE sfdd_t.sfddseq1, #项序
       sfdd001 LIKE sfdd_t.sfdd001, #发退料料号
       sfdd002 LIKE sfdd_t.sfdd002, #替代率
       sfdd003 LIKE sfdd_t.sfdd003, #库位
       sfdd004 LIKE sfdd_t.sfdd004, #储位
       sfdd005 LIKE sfdd_t.sfdd005, #批号
       sfdd006 LIKE sfdd_t.sfdd006, #单位
       sfdd007 LIKE sfdd_t.sfdd007, #数量
       sfdd008 LIKE sfdd_t.sfdd008, #参考单位
       sfdd009 LIKE sfdd_t.sfdd009, #参考单位数量
       sfdd010 LIKE sfdd_t.sfdd010, #库存管理特征
       sfdd011 LIKE sfdd_t.sfdd011, #包装容器
       sfdd012 LIKE sfdd_t.sfdd012, #正负
       sfdd013 LIKE sfdd_t.sfdd013, #产品特征
       sfdd014 LIKE sfdd_t.sfdd014, #备置量
       sfdd015 LIKE sfdd_t.sfdd015 #在拣量
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
#DEFINE  l_inba       RECORD LIKE inba_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_inba RECORD  #雜項庫存異動單頭檔
       inbaent LIKE inba_t.inbaent, #企业编号
       inbasite LIKE inba_t.inbasite, #营运据点
       inbadocno LIKE inba_t.inbadocno, #单据编号
       inbadocdt LIKE inba_t.inbadocdt, #录入日期
       inba001 LIKE inba_t.inba001, #单据类别
       inba002 LIKE inba_t.inba002, #扣账日期
       inba003 LIKE inba_t.inba003, #申请人员
       inba004 LIKE inba_t.inba004, #申请部门
       inba005 LIKE inba_t.inba005, #来源数据类型
       inba006 LIKE inba_t.inba006, #来源单号
       inba007 LIKE inba_t.inba007, #理由码
       inba008 LIKE inba_t.inba008, #备注
       inba009 LIKE inba_t.inba009, #保税异动原因
       inba010 LIKE inba_t.inba010, #保税进口报单
       inba011 LIKE inba_t.inba011, #保税进口报单日期
       inbaownid LIKE inba_t.inbaownid, #资料所有者
       inbaowndp LIKE inba_t.inbaowndp, #资料所有部门
       inbacrtid LIKE inba_t.inbacrtid, #资料录入者
       inbacrtdp LIKE inba_t.inbacrtdp, #资料录入部门
       inbacrtdt LIKE inba_t.inbacrtdt, #资料创建日
       inbamodid LIKE inba_t.inbamodid, #资料更改者
       inbamoddt LIKE inba_t.inbamoddt, #最近更改日
       inbacnfid LIKE inba_t.inbacnfid, #资料审核者
       inbacnfdt LIKE inba_t.inbacnfdt, #数据审核日
       inbapstid LIKE inba_t.inbapstid, #资料过账者
       inbapstdt LIKE inba_t.inbapstdt, #资料过账日
       inbastus LIKE inba_t.inbastus, #状态码
       inbaunit LIKE inba_t.inbaunit, #应用组织
       inba012 LIKE inba_t.inba012, #领用类型
       inba013 LIKE inba_t.inba013, #费用对象
       inba014 LIKE inba_t.inba014, #直接交款否
       inba015 LIKE inba_t.inba015, #库位
       inba200 LIKE inba_t.inba200, #冲减方式
       inba201 LIKE inba_t.inba201, #管理品类
       inba202 LIKE inba_t.inba202, #来源作业
       inba203 LIKE inba_t.inba203, #管理品类
       inba204 LIKE inba_t.inba204, #供应商编号
       inba205 LIKE inba_t.inba205, #领用部门
       inba206 LIKE inba_t.inba206, #转入库位
       inba207 LIKE inba_t.inba207, #转入管理品类
       inba208 LIKE inba_t.inba208 #返回
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
#DEFINE  l_inbb       RECORD LIKE inbb_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_inbb RECORD  #雜項庫存異動申請明細檔
       inbbent LIKE inbb_t.inbbent, #企业编号
       inbbsite LIKE inbb_t.inbbsite, #营运据点
       inbbdocno LIKE inbb_t.inbbdocno, #单据编号
       inbbseq LIKE inbb_t.inbbseq, #项次
       inbb001 LIKE inbb_t.inbb001, #料件编号
       inbb002 LIKE inbb_t.inbb002, #产品特征
       inbb003 LIKE inbb_t.inbb003, #库存管理特征
       inbb004 LIKE inbb_t.inbb004, #包装容器编号
       inbb007 LIKE inbb_t.inbb007, #库位
       inbb008 LIKE inbb_t.inbb008, #限定储位
       inbb009 LIKE inbb_t.inbb009, #限定批号
       inbb010 LIKE inbb_t.inbb010, #交易单位
       inbb011 LIKE inbb_t.inbb011, #申请数量
       inbb012 LIKE inbb_t.inbb012, #实际异动数量
       inbb013 LIKE inbb_t.inbb013, #参考单位
       inbb014 LIKE inbb_t.inbb014, #参考单位申请数量
       inbb015 LIKE inbb_t.inbb015, #参考单位实际数量
       inbb016 LIKE inbb_t.inbb016, #理由码
       inbb017 LIKE inbb_t.inbb017, #来源单号
       inbb018 LIKE inbb_t.inbb018, #检验否
       inbb019 LIKE inbb_t.inbb019, #检验合格量
       inbb020 LIKE inbb_t.inbb020, #单据备注
       inbb021 LIKE inbb_t.inbb021, #存货备注
       inbb022 LIKE inbb_t.inbb022, #有效日期
       inbb200 LIKE inbb_t.inbb200, #商品条码
       inbb201 LIKE inbb_t.inbb201, #包装单位
       inbb202 LIKE inbb_t.inbb202, #申请包装数量
       inbb203 LIKE inbb_t.inbb203, #实际包装数量
       inbbunit LIKE inbb_t.inbbunit, #应用组织
       inbb204 LIKE inbb_t.inbb204, #制造日期
       inbb023 LIKE inbb_t.inbb023, #项目编号
       inbb024 LIKE inbb_t.inbb024, #WBS
       inbb025 LIKE inbb_t.inbb025, #活动编号
       inbb205 LIKE inbb_t.inbb205, #领用/退回单价
       inbb206 LIKE inbb_t.inbb206, #领用/退回金额
       inbb207 LIKE inbb_t.inbb207, #成本单价
       inbb208 LIKE inbb_t.inbb208, #成本金额
       inbb209 LIKE inbb_t.inbb209, #费用编号
       inbb210 LIKE inbb_t.inbb210, #进价
       inbb211 LIKE inbb_t.inbb211, #来源单据项次
       inbb212 LIKE inbb_t.inbb212, #来源单据项序
       inbb213 LIKE inbb_t.inbb213, #转入商品条码
       inbb214 LIKE inbb_t.inbb214, #转入商品编号
       inbb215 LIKE inbb_t.inbb215, #转入产品特征
       inbb216 LIKE inbb_t.inbb216, #转入单位
       inbb217 LIKE inbb_t.inbb217, #转入数量
       inbb218 LIKE inbb_t.inbb218, #转入包装单位
       inbb219 LIKE inbb_t.inbb219, #转入包装数量
       inbb220 LIKE inbb_t.inbb220, #转入库位
       inbb221 LIKE inbb_t.inbb221, #转入储位
       inbb222 LIKE inbb_t.inbb222, #转入批号
       inbb223 LIKE inbb_t.inbb223, #转入进价
       inbb224 LIKE inbb_t.inbb224, #计价单位
       inbb225 LIKE inbb_t.inbb225 #计价数量
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE  l_inaj027    LIKE inaj_t.inaj027
DEFINE  l_inpg006    LIKE inpg_t.inpg006
DEFINE  l_inpg008    LIKE inpg_t.inpg008
DEFINE  l_sfdc007    LIKE sfdc_t.sfdc007
#DEFINE  l_sfdc       RECORD LIKE sfdc_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企业编号
       sfdcsite LIKE sfdc_t.sfdcsite, #营运据点
       sfdcdocno LIKE sfdc_t.sfdcdocno, #发退料单号
       sfdcseq LIKE sfdc_t.sfdcseq, #项次
       sfdc001 LIKE sfdc_t.sfdc001, #工单单号
       sfdc002 LIKE sfdc_t.sfdc002, #工单项次
       sfdc003 LIKE sfdc_t.sfdc003, #工单项序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料号
       sfdc005 LIKE sfdc_t.sfdc005, #产品特征
       sfdc006 LIKE sfdc_t.sfdc006, #单位
       sfdc007 LIKE sfdc_t.sfdc007, #申请数量
       sfdc008 LIKE sfdc_t.sfdc008, #实际数量
       sfdc009 LIKE sfdc_t.sfdc009, #参考单位
       sfdc010 LIKE sfdc_t.sfdc010, #参考单位需求数量
       sfdc011 LIKE sfdc_t.sfdc011, #参考单位实际数量
       sfdc012 LIKE sfdc_t.sfdc012, #指定库位
       sfdc013 LIKE sfdc_t.sfdc013, #指定储位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批号
       sfdc015 LIKE sfdc_t.sfdc015, #理由码
       sfdc016 LIKE sfdc_t.sfdc016, #库存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017, #正负
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定义字段(文本)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定义字段(文本)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定义字段(文本)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定义字段(文本)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定义字段(文本)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定义字段(文本)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定义字段(文本)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定义字段(文本)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定义字段(文本)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定义字段(文本)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定义字段(数字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定义字段(数字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定义字段(数字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定义字段(数字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定义字段(数字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定义字段(数字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定义字段(数字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定义字段(数字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定义字段(数字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定义字段(数字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定义字段(日期时间)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定义字段(日期时间)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定义字段(日期时间)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定义字段(日期时间)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定义字段(日期时间)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定义字段(日期时间)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定义字段(日期时间)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定义字段(日期时间)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定义字段(日期时间)029
       sfdcud030 LIKE sfdc_t.sfdcud030 #自定义字段(日期时间)030
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
#DEFINE  l_sfdb       RECORD LIKE sfdb_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdbent LIKE sfdb_t.sfdbent, #企业编号
       sfdbsite LIKE sfdb_t.sfdbsite, #营运据点
       sfdbdocno LIKE sfdb_t.sfdbdocno, #发退料单号
       sfdb001 LIKE sfdb_t.sfdb001, #工单单号
       sfdb002 LIKE sfdb_t.sfdb002, #Run Card
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作业
       sfdb005 LIKE sfdb_t.sfdb005, #作业序
       sfdb006 LIKE sfdb_t.sfdb006, #预计套数
       sfdb007 LIKE sfdb_t.sfdb007, #实际套数
       sfdb008 LIKE sfdb_t.sfdb008 #正负
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE  l_cl_num     LIKE sfdc_t.sfdc007
#DEFINE  l_inpe       RECORD LIKE inpe_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_inpe RECORD  #盤點單製造批序號明細檔
       inpeent LIKE inpe_t.inpeent, #企业编号
       inpesite LIKE inpe_t.inpesite, #营运据点
       inpedocno LIKE inpe_t.inpedocno, #盘点编号
       inpeseq LIKE inpe_t.inpeseq, #项次
       inpeseq2 LIKE inpe_t.inpeseq2, #序号
       inpe001 LIKE inpe_t.inpe001, #料件编号
       inpe002 LIKE inpe_t.inpe002, #产品特征
       inpe003 LIKE inpe_t.inpe003, #库存管理特征
       inpe004 LIKE inpe_t.inpe004, #包装容器编号
       inpe005 LIKE inpe_t.inpe005, #库位
       inpe006 LIKE inpe_t.inpe006, #储位
       inpe007 LIKE inpe_t.inpe007, #批号
       inpe008 LIKE inpe_t.inpe008, #制造批号
       inpe009 LIKE inpe_t.inpe009, #制造序号
       inpe010 LIKE inpe_t.inpe010, #制造日期
       inpe011 LIKE inpe_t.inpe011, #有效日期
       inpe012 LIKE inpe_t.inpe012, #现有库存量
       inpe030 LIKE inpe_t.inpe030, #盘点数量-初盘(一)
       inpe031 LIKE inpe_t.inpe031, #录入人员-初盘(一)
       inpe032 LIKE inpe_t.inpe032, #录入日期-初盘(一)
       inpe033 LIKE inpe_t.inpe033, #盘点人员-初盘(一)
       inpe034 LIKE inpe_t.inpe034, #盘点日期-初盘(一)
       inpe035 LIKE inpe_t.inpe035, #盘点数量-初盘(二)
       inpe036 LIKE inpe_t.inpe036, #录入人员-初盘(二)
       inpe037 LIKE inpe_t.inpe037, #录入日期-初盘(二)
       inpe038 LIKE inpe_t.inpe038, #盘点人员-初盘(二)
       inpe039 LIKE inpe_t.inpe039, #盘点日期-初盘(二)
       inpe050 LIKE inpe_t.inpe050, #盘点数量-复盘(一)
       inpe051 LIKE inpe_t.inpe051, #录入人员-复盘(一)
       inpe052 LIKE inpe_t.inpe052, #录入日期-复盘(一)
       inpe053 LIKE inpe_t.inpe053, #盘点人员-复盘(一)
       inpe054 LIKE inpe_t.inpe054, #盘点日期-复盘(一)
       inpe055 LIKE inpe_t.inpe055, #盘点数量-复盘(二)
       inpe056 LIKE inpe_t.inpe056, #录入人员-复盘(二)
       inpe057 LIKE inpe_t.inpe057, #录入日期-复盘(二)
       inpe058 LIKE inpe_t.inpe058, #盘点人员-复盘(二)
       inpe059 LIKE inpe_t.inpe059 #盘点日期-复盘(二)
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE  l_xh_type    LIKE type_t.chr1
DEFINE  l_xh_more    LIKE inpe_t.inpe055
DEFINE  l_inpe055    LIKE inpe_t.inpe055
DEFINE  l_count      LIKE type_t.num5
DEFINE  l_sql        STRING
DEFINE  l_tl_sfdadocno LIKE sfda_t.sfdadocno
DEFINE  l_fl_sfdadocno LIKE sfda_t.sfdadocno
DEFINE  l_cl_sfdadocno LIKE sfda_t.sfdadocno
DEFINE  l_zf_inbadocno LIKE inba_t.inbadocno
DEFINE  l_zs_inbadocno LIKE inba_t.inbadocno
DEFINE  l_inbc016      LIKE inbc_t.inbc016
DEFINE  l_imaf032      LIKE imaf_t.imaf032
DEFINE  l_inpa008      LIKE inpa_t.inpa008
#DEFINE  l_inao         RECORD LIKE inao_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025 #已退品量
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE  l_inpa042      LIKE inpa_t.inpa042
DEFINE  l_inpa043      LIKE inpa_t.inpa043
DEFINE  l_ck_more      LIKE inpd_t.inpd036 #160504-00019#3

   CALL cl_err_collect_init()
   LET r_success = TRUE
   LET l_count = 0    
    
   IF g_invent = 'Y' THEN   #現有庫存
      CALL s_transaction_begin()
      FOR i = 1 TO g_detail_d.getLength()
#         SELECT COUNT(*) INTO l_cnt FROM inag_t 
#          WHERE inagent = g_enterprise
#            AND inagsite = g_site
#            AND inag001 = g_detail_d[i].inpd001
#            AND inag002 = g_detail_d[i].inpd002
#            AND inag003 = g_detail_d[i].inpd003
#            AND inag004 = g_detail_d[i].inpd005
#            AND inag005 = g_detail_d[i].inpd006
#            AND inag006 = g_detail_d[i].inpd007
#            AND inag007 = g_detail_d[i].inpd010
#         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
#         IF l_cnt = 0 THEN  #新增
            IF g_detail_d[i].sel = 'N' OR g_detail_d[i].inpdstus = 'S' THEN
               CONTINUE FOR
            END IF
            #160512-00004#1 by whitney modify start
            #CALL s_inventory_ins_inag_collect(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,g_detail_d[i].inpd006,
            #                                  g_detail_d[i].inpd007,g_today,g_detail_d[i].inpd015,g_date,g_detail_d[i].inpd010,g_site)
            #                                 料件编号               产品特征              库存管理特征           库位
            CALL s_inventory_ins_inag_collect(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,
            #                                 储位                  批号                  单位                   备注
                                              g_detail_d[i].inpd006,g_detail_d[i].inpd007,g_detail_d[i].inpd010,g_detail_d[i].inpd015,
            #                                 第一次入库日期         製造日期               有效日期               營運據點
                                              g_date               ,''                   ,''                   ,g_site)
            #160512-00004#1 by whitney modify end
                                                                                  
            
#         END IF
      END FOR
      CALL s_inventory_ins_inag(g_site) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CALL s_transaction_end('N','0')
      END IF  
      CALL s_transaction_end('Y','0')
     #現有庫存數量更新
      FOR i = 1 TO g_detail_d.getLength()
         IF g_detail_d[i].sel = 'N' OR g_detail_d[i].inpdstus = 'S' THEN
            CONTINUE FOR
         END IF  
         LET r_success = TRUE         
         CALL s_transaction_begin()
         SELECT inpa009,inpa010,inpa011,inpa012,inpa008,inpa042,inpa042 INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012,l_inpa008,l_inpa042,l_inpa043 FROM inpa_t
          WHERE inpaent = g_enterprise
            AND inpasite = g_site
            AND inpadocno = g_detail_d[i].inpd008
         
#         IF (l_inpa012 = 'Y' OR l_inpa011 = 'Y') THEN
#            LET l_more = g_detail_d[i].inpd056 - g_detail_d[i].inpd011
#         ELSE
#            LET l_more = g_detail_d[i].inpd036 - g_detail_d[i].inpd011            
#         END IF
         #20150929 DSC.liquor mod------------------
         #原來寫的mark
         #IF NOT cl_null(g_detail_d[i].inpd056) THEN
         #   LET l_more = g_detail_d[i].inpd056 - g_detail_d[i].inpd011
         #ELSE
         #   IF NOT cl_null(g_detail_d[i].inpd036) THEN
         #      LET l_more = g_detail_d[i].inpd036 - g_detail_d[i].inpd011
         #   ELSE
         #      LET l_more = 0            
         #   END IF               
         #END IF
         #重寫
         IF NOT cl_null(g_detail_d[i].inpd056) THEN
            LET l_more = g_detail_d[i].inpd056 - g_detail_d[i].inpd011
         ELSE
            IF NOT cl_null(g_detail_d[i].inpd050) THEN
               LET l_more = g_detail_d[i].inpd050 - g_detail_d[i].inpd011
            ELSE
               IF NOT cl_null(g_detail_d[i].inpd036) THEN
                  LET l_more = g_detail_d[i].inpd036 - g_detail_d[i].inpd011
               ELSE
                  IF NOT cl_null(g_detail_d[i].inpd030) THEN
                     LET l_more = g_detail_d[i].inpd030 - g_detail_d[i].inpd011
                  ELSE
                     LET l_more = 0
                  END IF
               END IF            
            END IF               
         END IF
         #重寫
         #20150929 add end------------------------------------
         #160504-00019#3 参考单位数量是否异动
         IF NOT cl_null(g_detail_d[i].inpd057) THEN
            LET l_ck_more = g_detail_d[i].inpd057 - g_detail_d[i].inpd013
         ELSE
            IF NOT cl_null(g_detail_d[i].inpd037) THEN
               LET l_ck_more = g_detail_d[i].inpd037 - g_detail_d[i].inpd013
            ELSE
               LET l_ck_more = 0            
            END IF               
         END IF     
         
         #160517-00029#4   2016/05/31 By earl add s
         IF NOT s_barcode_01_inventory('1',g_prog,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq) THEN
            LET r_success = FALSE
            CALL s_transaction_end('N','0')
            CONTINUE FOR
         END IF
         #160517-00029#4   2016/05/31 By earl add e
         
         
         #160504-00019#3 
            #LET l_sql = " SELECT * FROM inpe_t ",  #161124-00048#4  16/12/09 By 08734 mark
            LET l_sql = " SELECT inpeent,inpesite,inpedocno,inpeseq,inpeseq2,inpe001,inpe002,inpe003,inpe004,inpe005,inpe006,inpe007,inpe008,inpe009,inpe010,inpe011,inpe012,inpe030,inpe031,inpe032,inpe033,inpe034,inpe035,inpe036,inpe037,inpe038,inpe039,inpe050,inpe051,inpe052,inpe053,inpe054,inpe055,inpe056,inpe057,inpe058,inpe059 FROM inpe_t ",  #161124-00048#4  16/12/09 By 08734 add
                        "  WHERE inpeent = '",g_enterprise,"'",
                        "    AND inpesite = '",g_site,"'",
                        "    AND inpedocno = '",g_detail_d[i].inpddocno,"'",
                        "    AND inpeseq = '",g_detail_d[i].inpdseq,"'"
            PREPARE ainp880_inai_sel FROM l_sql
            DECLARE ainp880_inai_cur CURSOR FOR ainp880_inai_sel  
            
            FOREACH ainp880_inai_cur INTO l_inpe.*
#               IF l_inpa012 = 'Y' OR l_inpa011 = 'Y' THEN 
#                  IF l_inpa012 = 'Y' THEN
#                     LET l_inpe055 = l_inpe.inpe055
#                  ELSE
#                     LET l_inpe055 = l_inpe.inpe050
#                  END IF    
#               ELSE
#                  IF l_inpa010 = 'Y' THEN
#                     LET l_inpe055 = l_inpe.inpe035
#                  ELSE
#                     LET l_inpe055 = l_inpe.inpe030              
#                  END IF
#               END IF 
            #add by lixh 20150402
               IF l_inpa008 = '1' THEN
                  IF NOT cl_null(l_inpe.inpe030) THEN 
                     LET l_inpe055 = l_inpe.inpe030
                  END IF
                  IF NOT cl_null(l_inpe.inpe035) THEN 
                     LET l_inpe055 = l_inpe.inpe035
                  END IF       
                  IF NOT cl_null(l_inpe.inpe050) THEN 
                     LET l_inpe055 = l_inpe.inpe050
                  END IF  
                  IF NOT cl_null(l_inpe.inpe055) THEN 
                     LET l_inpe055 = l_inpe.inpe055
                  END IF      
               ELSE
                  #盘差输入
                  #IF NOT cl_null(l_inpe.inpe033) THEN  #160317-00023#1
                  IF NOT cl_null(l_inpe.inpe030) THEN #160317-00023#1
                     LET l_inpe055 = l_inpe.inpe030
                  END IF
                  #IF NOT cl_null(l_inpe.inpe038) THEN 
                  IF NOT cl_null(l_inpe.inpe035) THEN #160317-00023#1
                     LET l_inpe055 = l_inpe.inpe035
                  END IF       
                  #IF NOT cl_null(l_inpe.inpe053) THEN 
                  IF NOT cl_null(l_inpe.inpe050) THEN #160317-00023#1
                     LET l_inpe055 = l_inpe.inpe050
                  END IF  
                  #IF NOT cl_null(l_inpe.inpe058) THEN 
                  IF NOT cl_null(l_inpe.inpe055) THEN  #160317-00023#1
                     LET l_inpe055 = l_inpe.inpe055
                  END IF                                         
               END IF               
            #add by lixh 20150402
               LET l_xh_more = l_inpe055 - l_inpe.inpe012
            #add by lixh 20150402
               LET l_inao.inaoent = g_enterprise
               LET l_inao.inaosite = g_site
               LET l_inao.inaodocno = l_inpe.inpedocno
               LET l_inao.inaoseq = l_inpe.inpeseq
               LET l_inao.inaoseq1 = 0
               LET l_inao.inaoseq2 = l_inpe.inpeseq2
               LET l_inao.inao000 = '2'
               LET l_inao.inao001 = l_inpe.inpe001
               LET l_inao.inao002 = l_inpe.inpe002
               LET l_inao.inao003 = l_inpe.inpe003
               LET l_inao.inao004 = l_inpe.inpe004
               LET l_inao.inao005 = l_inpe.inpe005
               LET l_inao.inao006 = l_inpe.inpe006
               LET l_inao.inao007 = l_inpe.inpe007
               LET l_inao.inao008 = l_inpe.inpe008
               LET l_inao.inao009 = l_inpe.inpe009
               LET l_inao.inao010 = l_inpe.inpe010
               LET l_inao.inao011 = l_inpe.inpe011
               LET l_inao.inao012 = l_xh_more
               LET l_inao.inao013 = '1'  #统一给值‘1’
               LET l_inao.inao014 = g_detail_d[i].inpd010 
               INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,
                                   inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014)
                           VALUES (l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,
                                   l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                                   l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014)
               IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert into inao_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  CALL s_transaction_end('N','0')
                  CONTINUE FOR
               END IF                                    
            #add by lixh 20150402
               #更新制造批序号库存明细数量 
               #製造批序號交易檔(inal_t)  
               #在新增庫存交易明細檔時就一併新增製造批序號交易檔
                
            END FOREACH
            
         IF l_more <> 0 OR l_ck_more <> 0 THEN
#            IF l_more > 0 THEN
#               LET l_type = '1'
#            ELSE
#               LET l_type = '-1'
#               LET l_more = l_more * -1
#            END IF        
            #更新庫存明細數量      
            CALL s_inventory_upd_inag(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,g_detail_d[i].inpd006,g_detail_d[i].inpd007,
#                                      l_type,l_more,g_date,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0,g_detail_d[i].inpd010,'','1',g_site)
                                      '2',l_more,g_date,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0,g_detail_d[i].inpd010,l_ck_more,'1',g_site)   #add l_ck_more #160504-00019#3
                 RETURNING l_success 
            IF NOT l_success THEN
               LET r_success = FALSE
               CALL s_transaction_end('N','0')
#               RETURN r_success
               CONTINUE FOR
            END IF   
            IF NOT cl_null(g_detail_d[i].inpd012) THEN       
               CALL s_inventory_upd_inah(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,g_detail_d[i].inpd006,g_detail_d[i].inpd007,
#                                         g_detail_d[i].inpd012,'1',l_type,l_more,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0)
                                         g_detail_d[i].inpd012,'1','2',l_more,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0)
                    RETURNING l_success
               IF NOT l_success THEN
                  LET r_success = FALSE
                  CALL s_transaction_end('N','0')
                  CONTINUE FOR
               END IF     
            END IF 
                     
            CALL ainp880_get_values()
            
            LET g_inaj.inajent = g_enterprise
            LET g_inaj.inajsite = g_site
            LET g_inaj.inaj001 = g_detail_d[i].inpddocno
            LET g_inaj.inaj002 = g_detail_d[i].inpdseq
            LET g_inaj.inaj003 = 0
           # LET g_inaj.inaj004 = l_type  #mark by lixh 20150402
            LET g_inaj.inaj004 = 1        #add by lixh 20150402
            LET g_inaj.inaj005 = g_detail_d[i].inpd001
            LET g_inaj.inaj006 = g_detail_d[i].inpd002
            LET g_inaj.inaj007 = g_detail_d[i].inpd003
            LET g_inaj.inaj008 = g_detail_d[i].inpd005
            LET g_inaj.inaj009 = g_detail_d[i].inpd006
            LET g_inaj.inaj010 = g_detail_d[i].inpd007  
            LET g_inaj.inaj011 = l_more
            LET g_inaj.inaj012 = g_detail_d[i].inpd010  
            LET g_inaj.inaj017 = g_dept
            LET g_inaj.inaj022 = g_date
            LET g_inaj.inaj023 = g_date  
            #160504-00019#3
            LET g_inaj.inaj026 = g_detail_d[i].inpd012
            LET g_inaj.inaj027 = l_ck_more    
            #160504-00019#3            
            LET g_inaj.inajud011 = 0
            LET g_inaj.inajud012 = 0
            LET g_inaj.inajud013 = 0
            LET g_inaj.inajud014 = 0
            LET g_inaj.inajud015 = 0
            LET g_inaj.inajud016 = 0
            LET g_inaj.inajud017 = 0
            LET g_inaj.inajud018 = 0
            LET g_inaj.inajud019 = 0
            LET g_inaj.inajud020 = 0
            CALL s_inventory_ins_inaj(g_site) RETURNING l_success
            
            IF NOT l_success THEN
               LET r_success = FALSE
               CALL s_transaction_end('N','0')
#               RETURN r_success
               CONTINUE FOR
            END IF         
            
         #add by lixh 20150608  
            #實時成本計算邏輯
            CALL s_cost_realtime_cal() RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
               CALL s_transaction_end('N','0')    
               CONTINUE FOR               
            END IF         
         #add by lixh 20150608
         END IF   #add by lixh 20150122
         #更新[T:庫存明細檔].{C:最近一次盤點日期] = 畫面上的過帳日期
         UPDATE inag_t SET inag014 = g_date
          WHERE inagent = g_enterprise
            AND inagsite = g_site
            AND inag001 = g_detail_d[i].inpd001
            AND inag002 = g_detail_d[i].inpd002
            AND inag003 = g_detail_d[i].inpd003
            AND inag004 = g_detail_d[i].inpd005
            AND inag005 = g_detail_d[i].inpd006
            AND inag006 = g_detail_d[i].inpd007
            AND inag007 = g_detail_d[i].inpd010
         UPDATE inpd_t SET inpdstus = 'S',
                           inpdpstid = g_user,  
                           inpdpstdt = g_today                         
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpddocno = g_detail_d[i].inpddocno
            AND inpdseq = g_detail_d[i].inpdseq     
         CALL s_transaction_end('Y','0')       
         LET l_count = l_count + 1         
      END FOR      
      
   END IF   
   
   IF g_work = 'Y' THEN   #在製工單             
      LET l_sfda.sfdadocno = '' 
      LET l_inba.inbadocno = ''
      LET l_zf_inbadocno = ''
      LET l_zs_inbadocno = ''      
      LET l_tl_sfdadocno = ''
      LET l_fl_sfdadocno = '' 
      LET l_cl_sfdadocno = ''   
#      LET r_success = TRUE    #mark by lixh 20150205   
      FOR i = 1 TO g_inpf_d.getLength()       
         IF g_inpf_d[i].sel01 = 'N' THEN
            CONTINUE FOR
         END IF   
      #add by lixh 20150205
         CALL s_transaction_begin()
         LET r_success = TRUE
         IF NOT cl_null(l_zf_inbadocno) THEN
            IF NOT s_aint302_conf(l_zf_inbadocno) THEN
               LET r_success = FALSE
            END IF   
#            IF NOT s_aint302_conf_upd(l_zf_inbadocno) THEN
#               LET r_success = FALSE
#            END IF               
         END IF
         IF NOT cl_null(l_zs_inbadocno) THEN              
            IF NOT s_aint302_conf(l_zs_inbadocno) THEN
               LET r_success = FALSE
            END IF 
#            IF NOT s_aint302_conf_upd(l_zs_inbadocno) THEN
#               LET r_success = FALSE
#            END IF             
         END IF  
         IF NOT cl_null(l_fl_sfdadocno) THEN
            IF NOT s_asft310_confirm_chk(l_fl_sfdadocno) THEN
               LET r_success = FALSE
            END IF
            IF NOT s_asft310_confirm_upd(l_fl_sfdadocno) THEN
               LET r_success = FALSE
            END IF            
         END IF
         IF NOT cl_null(l_cl_sfdadocno) THEN
            IF NOT s_asft310_confirm_chk(l_cl_sfdadocno) THEN
               LET r_success = FALSE
            END IF  
            IF NOT s_asft310_confirm_upd(l_cl_sfdadocno) THEN
               LET r_success = FALSE
            END IF            
         END IF
         IF NOT cl_null(l_tl_sfdadocno) THEN      
            IF NOT s_asft310_confirm_chk(l_tl_sfdadocno) THEN
               LET r_success = FALSE
            END IF 
            IF NOT s_asft310_confirm_upd(l_tl_sfdadocno) THEN
               LET r_success = FALSE
            END IF             
         END IF    
         IF NOT r_success THEN
            CALL s_transaction_end('N','0') 
         ELSE
            CALL s_transaction_end('Y','0')       
         END IF 
      #add by lixh 20150205
         LET l_sfda.sfdadocno = ''  
         LET l_inba.inbadocno = '' 
         LET l_tl_sfdadocno = ''
         LET l_fl_sfdadocno = '' 
         LET l_cl_sfdadocno = ''   
         LET l_zf_inbadocno = ''
         LET l_zs_inbadocno = ''          
         SELECT inpa013,inpa014,inpa015,inpa016,inpa050,inpa051,inpa052,inpa053,inpa054,inpa042,inpa043 
           INTO l_inpa013,l_inpa014,l_inpa015,l_inpa016,l_inpa050,l_inpa051,l_inpa052,l_inpa053,l_inpa054,l_inpa042,l_inpa043 FROM inpa_t
          WHERE inpaent = g_enterprise
            AND inpasite = g_site
            AND inpadocno = g_inpf_d[i].inpf004
         LET r_success = TRUE   
         CALL s_transaction_begin()
         FOR j = 1 TO g_inpg_d.getLength()  
            #盤盈虧數量         
#            IF l_inpa014 = 'Y' OR l_inpa015 = 'Y' THEN #復盤
#               LET l_sfba018 = g_inpg_d[j].inpg053 - g_inpg_d[j].inpg012
#            ELSE
#               LET l_sfba018 = g_inpg_d[j].inpg033 - g_inpg_d[j].inpg012            
#            END IF
            #add by lixh 20150402
            IF NOT cl_null(g_inpg_d[j].inpg053) THEN
               LET l_sfba018 = g_inpg_d[j].inpg053 - g_inpg_d[j].inpg012
            ELSE  
               IF NOT cl_null(g_inpg_d[j].inpg033) THEN
                  LET l_sfba018 = g_inpg_d[j].inpg033 - g_inpg_d[j].inpg012   
               END IF               
            END IF
            IF cl_null(l_sfba018) THEN
               LET l_sfba018 = 0
            END IF
            #add by lixh 20150402
            IF l_sfba018 < 0 THEN  #盤虧
               LET l_sfba018_1 = l_sfba018 * -1
               UPDATE sfba_t SET sfba018 = l_sfba018_1
                WHERE sfbaent = g_enterprise
                  AND sfbasite = g_site
                  AND sfbadocno = g_inpf_d[i].inpf001
                  AND sfbaseq = g_inpg_d[j].inpgseq1
                  AND sfbaseq1 = g_inpg_d[j].inpgseq2
                  
               #新增一筆退料單，並呼叫確認過帳
               #自动编号
               IF cl_null(l_tl_sfdadocno) AND NOT cl_null(l_inpa053) AND l_sfba018 <> 0 THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa053,g_date,'asft320')
                       RETURNING l_success,l_tl_sfdadocno
                  LET l_sfda.sfdadocno = l_tl_sfdadocno    
                  LET l_sfda.sfdadocdt = g_date     
                  LET l_sfda.sfda001 = g_date                     
                  LET l_sfda.sfda002 = '23'
                  LET l_sfda.sfda015 = '03'
                  LET l_sfda.sfda014 = g_inpf_d[i].inpfdocno
                  LET l_sfda.sfda003 = g_dept
                  LET l_sfda.sfda004 = g_user
                  LET l_sfda.sfdaownid = g_user
                  LET l_sfda.sfdaowndp = g_dept
                  LET l_sfda.sfdacrtid = g_user
                  LET l_sfda.sfdacrtdp = g_dept
                  LET l_sfda.sfdacrtdt = cl_get_current()
                  LET l_sfda.sfdamodid = ""
                  LET l_sfda.sfdamoddt = ""   
                  LET l_sfda.sfdastus = 'N'                   
                  #新增退料單單頭 
                  INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
                                      sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
                              VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
                                      l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
                                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus)   
                                      
               END IF                    
               #新增退料单身
               LET l_sfdb.sfdbent = g_enterprise
               LET l_sfdb.sfdbsite = g_site
               LET l_sfdb.sfdbdocno = l_sfda.sfdadocno
               LET l_sfdb.sfdb001 = g_inpf_d[i].inpf001
               LET l_sfdb.sfdb002 = 0
               LET l_sfdb.sfdb003 = ' '
               LET l_sfdb.sfdb004 = g_inpf_d[i].inpf002
               LET l_sfdb.sfdb005 = g_inpg_d[j].inpg003
               LET l_sfdb.sfdb006 = ' '
               LET l_sfdb.sfdb007 = ' '
               LET l_sfdb.sfdb008 = 1
#               INSERT INTO sfdb_t (sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,sfdb008)
#                           VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,l_sfdb.sfdb003,
#                                   l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,l_sfdb.sfdb008)
               #新增退料需求檔   
               LET l_sfdc.sfdcdocno = l_sfda.sfdadocno
               SELECT MAX(sfdcseq)+1 INTO l_sfdc.sfdcseq FROM sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcsite = g_site
                  AND sfdcdocno = l_sfdc.sfdcdocno
               IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
               LET l_sfdc.sfdc001 = g_inpf_d[i].inpf001
               LET l_sfdc.sfdc002 = g_inpg_d[j].inpgseq1  
               LET l_sfdc.sfdc003 = g_inpg_d[j].inpgseq2
               LET l_sfdc.sfdc004 = g_inpg_d[j].inpg001
               LET l_sfdc.sfdc006 = g_inpg_d[j].inpg007
               LET l_sfdc.sfdc007 = l_sfba018
               LET l_sfdc.sfdc008 = l_sfba018
               IF l_sfdc.sfdc007 < 0 THEN
                  LET l_sfdc.sfdc007 = l_sfdc.sfdc007 * -1
               END IF
               IF l_sfdc.sfdc008 < 0 THEN
                  LET l_sfdc.sfdc008 = l_sfdc.sfdc008 * -1
               END IF   
               SELECT sfba019,sfba020,sfba021,sfba029 INTO l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc005,l_sfdc.sfdc014 FROM sfba_t
                WHERE sfbaent = g_enterprise
                  AND sfbasite = g_site
                  AND sfbadocno = g_inpf_d[i].inpf001
                  AND sfbaseq = g_inpg_d[j].inpgseq1 
                  AND sfbaseq1 = g_inpg_d[j].inpgseq2     
#               IF cl_null(l_sfdc.sfdc012) THEN 
#                  SELECT imae103,imae104 INTO l_sfdc.sfdc012,l_sfdc.sfdc013 FROM imae_t
#                    WHERE imaeent = g_enterprise
#                      AND imaesite = g_site
#                      AND imae001 = l_sfdc.sfdc004
#               END IF
               LET l_sfdc.sfdc012 = l_inpa042
               LET l_sfdc.sfdc013 = l_inpa043
               LET l_sfdc.sfdc015 = g_inpg_d[j].inpg013
               LET l_sfdc.sfdc016 = g_inpg_d[j].inpg010
               LET l_sfdc.sfdc017 = 1
               SELECT imaf015 INTO l_sfdc.sfdc009      #参考单位
                 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imafsite= g_site
                  AND imaf001 = l_sfdc.sfdc004
               IF cl_null(l_sfdc.sfdc009) THEN
                  LET l_sfdc.sfdc010 = 0       #参考单位需求数量
                  LET l_sfdc.sfdc011 = 0       #参考单位实际数量
               ELSE   
                  CALL s_aooi250_convert_qty(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
                     RETURNING l_success,l_sfdc.sfdc010
                  IF NOT l_success THEN
                     LET l_sfdc.sfdc010 = l_sfdc.sfdc007
                  END IF
                  LET l_sfdc.sfdc011 = l_sfdc.sfdc010       #参考单位实际数量
               END IF               
               IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
               IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
               IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
               IF cl_null(l_sfdc.sfdc016) THEN LET l_sfdc.sfdc016 = ' ' END IF
               IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
               IF cl_null(l_sfdc.sfdc009) THEN LET l_sfdc.sfdc009 = ' ' END IF 
               IF cl_null(l_sfdc.sfdc015) THEN LET l_sfdc.sfdc015 = ' ' END IF
               IF cl_null(l_sfdc.sfdc010) THEN LET l_sfdc.sfdc010 = 0 END IF
               IF cl_null(l_sfdc.sfdc011) THEN LET l_sfdc.sfdc011 = 0 END IF                
               INSERT INTO sfdc_t
                           (sfdcent,sfdcsite,sfdcdocno,sfdcseq,
                            sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,
                            sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017)
                     VALUES(g_enterprise,g_site,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,
                            l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,
                            l_sfdc.sfdc011,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,l_sfdc.sfdc017)                                  
               IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert into sfdc_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  CALL s_transaction_end('N','0')
                  RETURN 
               END IF 
               #匯總資料
               #将有指定库位的资料产生到需求页签
               #LET g_sql = "SELECT * FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",  #161124-00048#4  16/12/09 By 08734 mark
               LET g_sql = "SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,sfdcud030 ", #161124-00048#4  16/12/09 By 08734 add
                           " FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",
                           "   AND sfdc012 IS NOT NULL AND sfdc012 != ' ' "  #库位为空的不产生出来
               PREPARE ainp880_gen_p FROM g_sql
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'prepare ainp880_gen_c err'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  FREE ainp880_gen_p
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
               DECLARE ainp880_gen_c CURSOR FOR ainp880_gen_p
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'declare ainp880_gen_c err'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  FREE ainp880_gen_p
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
               FOREACH ainp880_gen_c INTO l_sfdc.*
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'foreach ainp880_gen_c err'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     EXIT FOREACH
                  END IF                  
#                  CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc016,l_sfdc.sfdc015,l_sfdc.sfdc007,l_sfdc.sfdc005)               
                  CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdcseq)
               END FOREACH
               FREE ainp880_gen_p

#               #過賬
#               IF NOT s_asft310_post_upd(l_sfdc.sfdcdocno,l_sfda.sfda001) THEN
#                  LET r_success = FALSE
#               END IF
               #新增一筆雜發單，並呼叫確認過帳
               IF cl_null(l_zf_inbadocno) AND NOT cl_null(l_inpa051) THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa051,g_date,'aint301')
                       RETURNING l_success,l_zf_inbadocno
                  LET l_inba.inbadocno = l_zf_inbadocno     
                  LET l_inba.inba001 = '1'     
                  LET l_inba.inbadocdt = g_date     
                  LET l_inba.inba002 = g_date   
                  LET l_inba.inba003 = g_user
                  LET l_inba.inba004 = g_dept  
                  LET l_inba.inba005 = '2'
                  LET l_inba.inba006 = g_inpf_d[i].inpfdocno
                  LET l_inba.inba007 = g_inbb016_2    #160504-00019#3
                  #理由碼是否需要檢核，待定
                  LET l_inba.inbaownid = g_user
                  LET l_inba.inbaowndp = g_dept
                  LET l_inba.inbacrtid = g_user
                  LET l_inba.inbacrtdp = g_dept 
                  LET l_inba.inbacrtdt = cl_get_current()
                  LET l_inba.inbamodid = ''
                  LET l_inba.inbamoddt = ''
                  LET l_inba.inbastus = 'N'   
                  INSERT INTO inba_t (inbaent,inbasite,inbadocno,inbadocdt,inba001,inba002,inba003,inba004,inba005,inba006,
                                      inbaownid,inbaowndp,inbacrtid,inbacrtdp,inbacrtdt,inbamodid,inbamoddt,inbastus) 
                              VALUES (g_enterprise,g_site,l_inba.inbadocno,l_inba.inbadocdt,l_inba.inba001,l_inba.inba002,
                                      l_inba.inba003,l_inba.inba004,l_inba.inba005,l_inba.inba006,l_inba.inbaownid,l_inba.inbaowndp,
                                      l_inba.inbacrtid,l_inba.inbacrtdp,l_inba.inbacrtdt,l_inba.inbamodid,l_inba.inbamoddt,
                                      l_inba.inbastus)                                      
#               END IF   
               #新增單身    
               #單身 inbb_t
               LET l_inbb.inbbdocno = l_inba.inbadocno
               SELECT MAX(inbbseq+1) INTO l_inbb.inbbseq FROM inbb_t
                WHERE inbbent = g_enterprise
                  AND inbbsite = g_site
                  AND inbbdocno = l_inbb.inbbdocno
               IF cl_null(l_inbb.inbbseq) THEN LET l_inbb.inbbseq = 1 END IF   
               LET l_inbb.inbb001 = g_inpg_d[j].inpg001
               LET l_inbb.inbb003 = g_inpg_d[j].inpg010
#               SELECT imaf091,imaf092 INTO l_inbb.inbb007,l_inbb.inbb008 FROM imaf_t
#                WHERE imafent = g_enterprise
#                  AND imafsite = g_site
#                  AND imaf001 = l_inbb.inbb001
               
               #add by lixh 20150929
#               SELECT imae101,imae102 INTO l_inbb.inbb007,l_inbb.inbb008 FROM imae_t
#                WHERE imaeent = g_enterprise
#                  AND imaesite = g_site
#                  AND imae001 = l_inbb.inbb001
               LET l_inbb.inbb007 = l_inpa042
               LET l_inbb.inbb008 = l_inpa043
               #add by lixh 20150929
               
               LET l_inbb.inbb009 = ' '
               LET l_inbb.inbb010 = g_inpg_d[j].inpg007  
               LET l_inbb.inbb011 = l_sfba018   #盤盈數量
               IF l_inbb.inbb011 < 0 THEN
                  LET l_inbb.inbb011 = l_inbb.inbb011 * -1
               END IF
               LET l_inbb.inbb012 = 0
               LET l_inbb.inbb017 = g_inpf_d[i].inpfdocno
               LET l_inbb.inbb018 = 'N'
               LET l_inbb.inbb019 = l_inbb.inbb011
               LET l_inbb.inbb016 = g_inbb016_2  #add by lixh 20160317
               INSERT INTO inbb_t (inbbent,inbbsite,inbbdocno,inbbseq,inbb001,inbb003,inbb010,inbb011,inbb012,inbb017,inbb018,inbb019,inbb007,inbb008,inbb016)  #160125-00017#1  add by lixh 20160126 inbb016
                            VALUES (g_enterprise,g_site,l_inbb.inbbdocno,l_inbb.inbbseq,l_inbb.inbb001,l_inbb.inbb003,
                                    l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb017,l_inbb.inbb018,l_inbb.inbb019,l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb016)  #160125-00017#1  add by lixh 20160126 inbb016
               LET l_inbc016 = g_today
            
               SELECT imaf032 INTO l_imaf032 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = 'ALL' 
                  AND imaf001 = l_inbb.inbb001
               IF NOT cl_null(l_imaf032) THEN
                  LET l_inbc016 = l_inbc016 + l_imaf032
               END IF 
               INSERT INTO inbc_t (inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc003,inbc005,inbc006,inbc007,inbc009,inbc010,inbc016)               
                           VALUES (g_enterprise,g_site,l_inbb.inbbdocno,l_inbb.inbbseq,1,l_inbb.inbb001,l_inbb.inbb003,
                                   l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbc016) 
               END IF   #add by lixh 20150209                                   
            END IF
            
            #並列
            
            IF l_sfba018 > 0 THEN  #盤盈            
               SELECT inpg006,inpg008 INTO l_inpg006,l_inpg008 FROM inpg_t
                WHERE inpgent = g_enterprise
                  AND inpgsite = g_site
                  AND inpgdocno = g_inpf_d[i].inpfdocno
                  AND inpgseq = g_inpf_d[i].inpfseq
                  AND inpgseq1 = g_inpg_d[j].inpgseq1
                  AND inpgseq2 = g_inpg_d[j].inpgseq2
                  
               IF l_sfba018 > l_inpg006-l_inpg008 THEN  
                  #發料數量
                  LET l_sfdc007 = l_inpg006-l_inpg008
                  #超領數量
                  LET l_cl_num = l_sfba018 - l_sfdc007
               ELSE
                  #發料數量
                  #LET l_sfdc007 = l_inpg006-l_inpg008   #160125-00017#1  mark by lixh 20160126 
                  LET l_sfdc007 = l_sfba018              #160125-00017#1  add by lixh 20160126 
                  #超領數量 
                  LET l_cl_num = 0                      
               END IF    
               #新增發料單
               IF cl_null(l_fl_sfdadocno) AND NOT cl_null(l_inpa052) AND l_sfdc007 > 0 THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa052,g_date,'asft310')
                       RETURNING l_success,l_fl_sfdadocno
                  LET l_sfda.sfdadocno = l_fl_sfdadocno          
                  LET l_sfda.sfdadocdt = g_date     
                  LET l_sfda.sfda001 = g_date                     
                  LET l_sfda.sfda002 = '11'
                  LET l_sfda.sfda015 = '03'
                  LET l_sfda.sfda014 = g_inpf_d[i].inpfdocno
                  LET l_sfda.sfda003 = g_dept
                  LET l_sfda.sfda004 = g_user
                  LET l_sfda.sfdaownid = g_user
                  LET l_sfda.sfdaowndp = g_dept
                  LET l_sfda.sfdacrtid = g_user
                  LET l_sfda.sfdacrtdp = g_dept
                  LET l_sfda.sfdacrtdt = cl_get_current()
                  LET l_sfda.sfdamodid = ""
                  LET l_sfda.sfdamoddt = ""   
                  LET l_sfda.sfdastus = 'N'                   
                  #新增發料單單頭 
                  INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
                                      sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
                              VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
                                      l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
                                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus)   
                                      
#               END IF                    
                   #新增發料单身
                   LET l_sfdb.sfdbent = g_enterprise
                   LET l_sfdb.sfdbsite = g_site
                   LET l_sfdb.sfdbdocno = l_sfda.sfdadocno
                   LET l_sfdb.sfdb001 = g_inpf_d[i].inpf001
                   LET l_sfdb.sfdb002 = 0
                   LET l_sfdb.sfdb003 = ' '
                   LET l_sfdb.sfdb004 = g_inpf_d[i].inpf002
                   LET l_sfdb.sfdb005 = g_inpg_d[j].inpg003
                   LET l_sfdb.sfdb006 = 0  #預計套數
                   LET l_sfdb.sfdb007 = 0  #實際套數
                   LET l_sfdb.sfdb008 = 1
                   #發料確認時需檢查單身是否有資料
                   INSERT INTO sfdb_t (sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,sfdb008)
                               VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,l_sfdb.sfdb003,
                                       l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,l_sfdb.sfdb008)
                   #新增發料需求檔   
                   LET l_sfdc.sfdcdocno = l_sfda.sfdadocno
                   SELECT MAX(sfdcseq)+1 INTO l_sfdc.sfdcseq FROM sfdc_t
                    WHERE sfdcent = g_enterprise
                      AND sfdcsite = g_site
                      AND sfdcdocno = l_sfdc.sfdcdocno
                   IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
                   LET l_sfdc.sfdc001 = g_inpf_d[i].inpf001
                   LET l_sfdc.sfdc002 = g_inpg_d[j].inpgseq1  
                   LET l_sfdc.sfdc003 = g_inpg_d[j].inpgseq2
                   LET l_sfdc.sfdc004 = g_inpg_d[j].inpg001
                   LET l_sfdc.sfdc006 = g_inpg_d[j].inpg007
                   LET l_sfdc.sfdc007 = l_sfdc007
                   LET l_sfdc.sfdc008 = l_sfdc007
                 
                   SELECT sfba019,sfba020,sfba021,sfba029 INTO l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc005,l_sfdc.sfdc014 FROM sfba_t
                    WHERE sfbaent = g_enterprise
                      AND sfbasite = g_site
                      AND sfbadocno = g_inpf_d[i].inpf001
                      AND sfbaseq = g_inpg_d[j].inpgseq1 
                      AND sfbaseq1 = g_inpg_d[j].inpgseq2    
#                   IF cl_null(l_sfdc.sfdc012) THEN 
#                      SELECT imae101,imae102 INTO l_sfdc.sfdc012,l_sfdc.sfdc013 FROM imae_t
#                        WHERE imaeent = g_enterprise
#                          AND imaesite = g_site
#                          AND imae001 = l_sfdc.sfdc004
#                   END IF   
                   LET l_sfdc.sfdc012 = l_inpa042
                   LET l_sfdc.sfdc013 = l_inpa043
                   LET l_sfdc.sfdc015 = g_inpg_d[j].inpg013
                   LET l_sfdc.sfdc016 = g_inpg_d[j].inpg010
                   LET l_sfdc.sfdc017 = -1
                   SELECT imaf015 INTO l_sfdc.sfdc009      #参考单位
                     FROM imaf_t
                    WHERE imafent = g_enterprise
                      AND imafsite= g_site
                      AND imaf001 = l_sfdc.sfdc004
                   IF cl_null(l_sfdc.sfdc009) THEN
                      LET l_sfdc.sfdc010 = 0       #参考单位需求数量
                      LET l_sfdc.sfdc011 = 0       #参考单位实际数量
                   ELSE   
                      CALL s_aooi250_convert_qty(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
                         RETURNING l_success,l_sfdc.sfdc010
                      IF NOT l_success THEN
                         LET l_sfdc.sfdc010 = l_sfdc.sfdc007
                      END IF
                      LET l_sfdc.sfdc011 = l_sfdc.sfdc010       #参考单位实际数量
                   END IF                   
                   IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
                   IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
                   IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
                   IF cl_null(l_sfdc.sfdc016) THEN LET l_sfdc.sfdc016 = ' ' END IF  
                   IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
                   IF cl_null(l_sfdc.sfdc009) THEN LET l_sfdc.sfdc009 = ' ' END IF 
                   IF cl_null(l_sfdc.sfdc015) THEN LET l_sfdc.sfdc015 = ' ' END IF
                   IF cl_null(l_sfdc.sfdc010) THEN LET l_sfdc.sfdc010 = 0 END IF
                   IF cl_null(l_sfdc.sfdc011) THEN LET l_sfdc.sfdc011 = 0 END IF  
                   
                   INSERT INTO sfdc_t
                               (sfdcent,sfdcsite,sfdcdocno,sfdcseq,
                                sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,
                                sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017)
                         VALUES(g_enterprise,g_site,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,
                                l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,
                                l_sfdc.sfdc011,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,l_sfdc.sfdc017)                                  
                   IF SQLCA.sqlerrd[3] = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'insert into sfdc_t'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      CALL s_transaction_end('N','0')
                      RETURN
                   END IF  
                   #匯總資料
                   #将有指定库位的资料产生到需求页签
                   #LET g_sql = "SELECT * FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",  #161124-00048#4  16/12/09 By 08734 mark
                   LET g_sql = "SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,sfdcud030 ", #161124-00048#4  16/12/09 By 08734 add
                           " FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",
                               "   AND sfdc012 IS NOT NULL AND sfdc012 != ' ' "  #库位为空的不产生出来
                   PREPARE ainp880_gen_p2 FROM g_sql
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'prepare ainp880_gen_c2 err'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      FREE ainp880_gen_p2
                      CALL s_transaction_end('N','0')
                      RETURN
                   END IF
                   DECLARE ainp880_gen_c2 CURSOR FOR ainp880_gen_p2
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'declare ainp880_gen_c2 err'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      FREE ainp880_gen_p2
                      CALL s_transaction_end('N','0')
                      RETURN
                   END IF
                   FOREACH ainp880_gen_c2 INTO l_sfdc.*
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = SQLCA.sqlcode
                         LET g_errparam.extend = 'foreach ainp880_gen_c2 err'
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET r_success = FALSE
                         EXIT FOREACH
                      END IF                  
#                      CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc016,l_sfdc.sfdc015,l_sfdc.sfdc007,l_sfdc.sfdc005)               
                      CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdcseq)
                   END FOREACH
               END IF   #add by lixh 20150209
               FREE ainp880_gen_p2 
               #超領單
               IF cl_null(l_cl_sfdadocno) AND NOT cl_null(l_inpa054) AND l_cl_num > 0 THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa054,g_date,'asft312')
                       RETURNING l_success,l_cl_sfdadocno
                  LET l_sfda.sfdadocno = l_cl_sfdadocno     
                  LET l_sfda.sfdadocdt = g_date     
                  LET l_sfda.sfda001 = g_date                     
                  LET l_sfda.sfda002 = '12'
                  LET l_sfda.sfda015 = '03'
                  LET l_sfda.sfda014 = g_inpf_d[i].inpfdocno
                  LET l_sfda.sfda003 = g_dept
                  LET l_sfda.sfda004 = g_user
                  LET l_sfda.sfdaownid = g_user
                  LET l_sfda.sfdaowndp = g_dept
                  LET l_sfda.sfdacrtid = g_user
                  LET l_sfda.sfdacrtdp = g_dept
                  LET l_sfda.sfdacrtdt = cl_get_current()
                  LET l_sfda.sfdamodid = ""
                  LET l_sfda.sfdamoddt = ""   
                  LET l_sfda.sfdastus = 'N'                   
                  #新增超領單單頭 
                  INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
                                      sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
                              VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
                                      l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
                                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus)   
                                      
               END IF                    
               #新增超領单身
               IF l_cl_num <> 0 AND NOT cl_null(l_sfda.sfdadocno) THEN  #add by lixh 20150128
                  LET l_sfdb.sfdbent = g_enterprise
                  LET l_sfdb.sfdbsite = g_site
                  LET l_sfdb.sfdbdocno = l_sfda.sfdadocno
                  LET l_sfdb.sfdb001 = g_inpf_d[i].inpf001
                  LET l_sfdb.sfdb002 = 0
                  LET l_sfdb.sfdb003 = ' '
                  LET l_sfdb.sfdb004 = g_inpf_d[i].inpf002
                  LET l_sfdb.sfdb005 = g_inpg_d[j].inpg003
                  LET l_sfdb.sfdb006 = ' '
                  LET l_sfdb.sfdb007 = ' '
                  LET l_sfdb.sfdb008 = 1
#                  INSERT INTO sfdb_t (sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,sfdb008)
#                              VALUES (l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,l_sfdb.sfdb003,
#                                      l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,l_sfdb.sfdb008)
                  #新增退料需求檔   
                  LET l_sfdc.sfdcdocno = l_sfda.sfdadocno
                  SELECT MAX(sfdcseq)+1 INTO l_sfdc.sfdcseq FROM sfdc_t
                   WHERE sfdcent = g_enterprise
                     AND sfdcsite = g_site
                     AND sfdcdocno = l_sfdc.sfdcdocno
                  IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
                  LET l_sfdc.sfdc001 = g_inpf_d[i].inpf001
                  LET l_sfdc.sfdc002 = g_inpg_d[j].inpgseq1  
                  LET l_sfdc.sfdc003 = g_inpg_d[j].inpgseq2
                  LET l_sfdc.sfdc004 = g_inpg_d[j].inpg001
                  LET l_sfdc.sfdc006 = g_inpg_d[j].inpg007
                  LET l_sfdc.sfdc007 = l_cl_num
                  LET l_sfdc.sfdc008 = l_cl_num
                  
                  SELECT sfba019,sfba020,sfba021,sfba029 INTO l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc005,l_sfdc.sfdc014 FROM sfba_t
                   WHERE sfbaent = g_enterprise
                     AND sfbasite = g_site
                     AND sfbadocno = g_inpf_d[i].inpf001
                     AND sfbaseq = g_inpg_d[j].inpgseq1 
                     AND sfbaseq1 = g_inpg_d[j].inpgseq2    
#                  IF cl_null(l_sfdc.sfdc012) THEN 
#                     SELECT imae101,imae102 INTO l_sfdc.sfdc012,l_sfdc.sfdc013 FROM imae_t
#                       WHERE imaeent = g_enterprise
#                         AND imaesite = g_site
#                         AND imae001 = l_sfdc.sfdc004
#                  END IF                    
                  LET l_sfdc.sfdc012 = l_inpa042
                  LET l_sfdc.sfdc013 = l_inpa043
                  LET l_sfdc.sfdc015 = g_inpg_d[j].inpg013
                  LET l_sfdc.sfdc016 = g_inpg_d[j].inpg010
                  LET l_sfdc.sfdc017 = -1    
                  SELECT imaf015 INTO l_sfdc.sfdc009      #参考单位
                    FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite= g_site
                     AND imaf001 = l_sfdc.sfdc004
                  IF cl_null(l_sfdc.sfdc009) THEN
                     LET l_sfdc.sfdc010 = 0       #参考单位需求数量
                     LET l_sfdc.sfdc011 = 0       #参考单位实际数量
                  ELSE   
                     CALL s_aooi250_convert_qty(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
                        RETURNING l_success,l_sfdc.sfdc010
                     IF NOT l_success THEN
                        LET l_sfdc.sfdc010 = l_sfdc.sfdc007
                     END IF
                     LET l_sfdc.sfdc011 = l_sfdc.sfdc010       #参考单位实际数量
                  END IF                 
                  IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
                  IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
                  IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
                  IF cl_null(l_sfdc.sfdc016) THEN LET l_sfdc.sfdc016 = ' ' END IF   
                  IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
                  IF cl_null(l_sfdc.sfdc009) THEN LET l_sfdc.sfdc009 = ' ' END IF 
                  IF cl_null(l_sfdc.sfdc015) THEN LET l_sfdc.sfdc015 = ' ' END IF
                  IF cl_null(l_sfdc.sfdc010) THEN LET l_sfdc.sfdc010 = 0 END IF
                  IF cl_null(l_sfdc.sfdc011) THEN LET l_sfdc.sfdc011 = 0 END IF                
                  INSERT INTO sfdc_t
                              (sfdcent,sfdcsite,sfdcdocno,sfdcseq,
                               sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,
                               sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017)
                        VALUES(g_enterprise,g_site,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,
                               l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,
                               l_sfdc.sfdc011,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,l_sfdc.sfdc017)                                  
                  IF SQLCA.sqlerrd[3] = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'insert into sfdc_t'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF  
                  #匯總資料
                  #将有指定库位的资料产生到需求页签
                  #LET g_sql = "SELECT * FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",  #161124-00048#4  16/12/09 By 08734 mark
                  LET g_sql = "SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,sfdcud030 ", #161124-00048#4  16/12/09 By 08734 add
                           " FROM sfdc_t WHERE sfdcent = '",g_enterprise,"' AND sfdcsite = '",g_site,"' AND sfdcdocno = '",l_sfdc.sfdcdocno,"'",
                              "   AND sfdc012 IS NOT NULL AND sfdc012 != ' ' "  #库位为空的不产生出来
                  PREPARE ainp880_gen_p3 FROM g_sql
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'prepare ainp880_gen_c3 err'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     FREE ainp880_gen_p3
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
                  DECLARE ainp880_gen_c3 CURSOR FOR ainp880_gen_p3
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'declare ainp880_gen_c3 err'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     FREE ainp880_gen_p3
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
                  FOREACH ainp880_gen_c3 INTO l_sfdc.*
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = 'foreach ainp880_gen_c3 err'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET r_success = FALSE
                        EXIT FOREACH
                     END IF                  
#                     CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc016,l_sfdc.sfdc015,l_sfdc.sfdc007,l_sfdc.sfdc005)               
                     CALL ainp880_ins_sfdd_sfde(l_sfdc.sfdcdocno,l_sfdc.sfdcseq)
                  END FOREACH
                  FREE ainp880_gen_p3               
               END IF  #add by lixh 20150128
               #新增一筆雜收單，並呼叫確認過帳
               IF cl_null(l_zs_inbadocno) AND NOT cl_null(l_inpa050) AND l_sfba018 <> 0 THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa050,g_date,'aint302')
                       RETURNING l_success,l_zs_inbadocno     
                  LET l_inba.inbadocno = l_zs_inbadocno     
                  LET l_inba.inba001 = '2'     
                  LET l_inba.inbadocdt = g_date     
                  LET l_inba.inba002 = g_date   
                  LET l_inba.inba003 = g_user
                  LET l_inba.inba004 = g_dept  
                  LET l_inba.inba005 = '2'
                  LET l_inba.inba006 = g_inpf_d[i].inpfdocno
                  LET l_inba.inba007 = g_inbb016    #160504-00019#3
                  LET l_inba.inbaownid = g_user
                  LET l_inba.inbaowndp = g_dept
                  LET l_inba.inbacrtid = g_user
                  LET l_inba.inbacrtdp = g_dept 
                  LET l_inba.inbacrtdt = cl_get_current()
                  LET l_inba.inbamodid = ''
                  LET l_inba.inbamoddt = ''
                  LET l_inba.inbastus = 'N'   
                  INSERT INTO inba_t (inbaent,inbasite,inbadocno,inbadocdt,inba001,inba002,inba003,inba004,inba005,inba006,
                                      inbaownid,inbaowndp,inbacrtid,inbacrtdp,inbacrtdt,inbamodid,inbamoddt,inbastus) 
                              VALUES (g_enterprise,g_site,l_inba.inbadocno,l_inba.inbadocdt,l_inba.inba001,l_inba.inba002,
                                      l_inba.inba003,l_inba.inba004,l_inba.inba005,l_inba.inba006,l_inba.inbaownid,l_inba.inbaowndp,
                                      l_inba.inbacrtid,l_inba.inbacrtdp,l_inba.inbacrtdt,l_inba.inbamodid,l_inba.inbamoddt,
                                      l_inba.inbastus)                
               END IF   #remark by lixh 20150914
               
               #雜收單身 inbb_t
               IF NOT cl_null(l_zs_inbadocno) THEN   #add by lixh 20150914
                  LET l_inbb.inbbdocno = l_zs_inbadocno
                  SELECT MAX(inbbseq+1) INTO l_inbb.inbbseq FROM inbb_t
                   WHERE inbbent = g_enterprise
                     AND inbbsite = g_site
                     AND inbbdocno = l_inbb.inbbdocno
                  IF cl_null(l_inbb.inbbseq) THEN LET l_inbb.inbbseq = 1 END IF   
                  LET l_inbb.inbb001 = g_inpg_d[j].inpg001
                  LET l_inbb.inbb003 = g_inpg_d[j].inpg010
#                  SELECT imaf091,imaf092 INTO l_inbb.inbb007,l_inbb.inbb008 FROM imaf_t
#                   WHERE imafent = g_enterprise
#                     AND imafsite = g_site
#                     AND imaf001 = l_inbb.inbb001

#                  #add by lixh 20150929
#                  SELECT imae101,imae102 INTO l_inbb.inbb007,l_inbb.inbb008 FROM imae_t
#                   WHERE imaeent = g_enterprise
#                     AND imaesite = g_site
#                     AND imae001 = l_inbb.inbb001
#                  #add by lixh 20150929
                  LET l_inbb.inbb007 = l_inpa042
                  LET l_inbb.inbb008 = l_inpa043
                  LET l_inbb.inbb009 = ' '
                  LET l_inbb.inbb010 = g_inpg_d[j].inpg007  
                  LET l_inbb.inbb011 = l_sfba018   #盤盈數量
                  IF l_inbb.inbb011 < 0 THEN
                     LET l_inbb.inbb011 = l_inbb.inbb011 * -1
                  END IF
                  LET l_inbb.inbb012 = 0
                  LET l_inbb.inbb017 = g_inpf_d[i].inpfdocno
                  LET l_inbb.inbb018 = 'N'
                  LET l_inbb.inbb019 = l_inbb.inbb011
                  LET l_inbb.inbb016 = g_inbb016  #add by lixh 20160317
                  INSERT INTO inbb_t (inbbent,inbbsite,inbbdocno,inbbseq,inbb001,inbb003,inbb010,inbb011,inbb012,inbb017,inbb018,inbb019,inbb007,inbb008,inbb016)      #160125-00017#1  add by lixh 20160126 inbb016
                               VALUES (g_enterprise,g_site,l_inbb.inbbdocno,l_inbb.inbbseq,l_inbb.inbb001,l_inbb.inbb003,
                                       l_inbb.inbb010,l_inbb.inbb011,l_inbb.inbb012,l_inbb.inbb017,l_inbb.inbb018,l_inbb.inbb019,l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb016) #160125-00017#1  add by lixh 20160126 inbb016
                  LET l_inbc016 = g_today
               
                  SELECT imaf032 INTO l_imaf032 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = 'ALL' 
                     AND imaf001 = l_inbb.inbb001
                  IF NOT cl_null(l_imaf032) THEN
                     LET l_inbc016 = l_inbc016 + l_imaf032
                  END IF 
                  INSERT INTO inbc_t (inbcent,inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc003,inbc005,inbc006,inbc007,inbc009,inbc010,inbc016)               
                              VALUES (g_enterprise,g_site,l_inbb.inbbdocno,l_inbb.inbbseq,1,l_inbb.inbb001,l_inbb.inbb003,
                                      l_inbb.inbb007,l_inbb.inbb008,l_inbb.inbb009,l_inbb.inbb010,l_inbb.inbb011,l_inbc016)         
               END IF
               #自动编号
               #sfda002: 11.成套發料,12.超領,13.欠料補料,14.倒扣領料,15.委外發料,16.重覆性生產發料,21.成套退料,22.超領退料,23.一般退料,24.倒扣退料
#               IF cl_null(l_fl_sfdadocno) AND NOT cl_null(l_inpa052) THEN
#                  CALL s_aooi200_gen_docno(g_site,l_inpa052,g_date,'asft310')
#                       RETURNING l_success,l_fl_sfdadocno
#                  LET l_sfda.sfdadocno = l_fl_sfdadocno     
#                  LET l_sfda.sfdadocdt = g_date     
#                  LET l_sfda.sfda001 = g_date                     
#                  LET l_sfda.sfda002 = '11'
#                  LET l_sfda.sfda015 = '03'
#                  LET l_sfda.sfda014 = g_inpf_d[i].inpfdocno
#                  LET l_sfda.sfda003 = g_dept
#                  LET l_sfda.sfda004 = g_user
#                  LET l_sfda.sfdaownid = g_user
#                  LET l_sfda.sfdaowndp = g_dept
#                  LET l_sfda.sfdacrtid = g_user
#                  LET l_sfda.sfdacrtdp = g_dept
#                  LET l_sfda.sfdacrtdt = cl_get_current()
#                  LET l_sfda.sfdamodid = ""
#                  LET l_sfda.sfdamoddt = ""   
#                  LET l_sfda.sfdastus = 'N'                   
#                  #新增發料單單頭 
#                  INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
#                                      sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
#                              VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
#                                      l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
#                                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus)  
#               END IF
#               #新增一筆超領單，並呼叫確認過帳
#               IF cl_null(l_cl_sfdadocno) AND NOT cl_null(l_inpa054) AND l_cl_num > 0 THEN
#                  CALL s_aooi200_gen_docno(g_site,l_inpa054,g_date,'asft312')
#                       RETURNING l_success,l_cl_sfdadocno
#                  LET l_sfda.sfdadocno = l_cl_sfdadocno   #add by lixh 20150205     
#                  LET l_sfda.sfdadocdt = g_date     
#                  LET l_sfda.sfda001 = g_date                     
#                  LET l_sfda.sfda002 = '12'
#                  LET l_sfda.sfda015 = '03'
#                  LET l_sfda.sfda014 = g_inpf_d[i].inpfdocno
#                  LET l_sfda.sfda003 = g_dept
#                  LET l_sfda.sfda004 = g_user
#                  LET l_sfda.sfdaownid = g_user
#                  LET l_sfda.sfdaowndp = g_dept
#                  LET l_sfda.sfdacrtid = g_user
#                  LET l_sfda.sfdacrtdp = g_dept
#                  LET l_sfda.sfdacrtdt = cl_get_current()
#                  LET l_sfda.sfdamodid = ""
#                  LET l_sfda.sfdamoddt = ""   
#                  LET l_sfda.sfdastus = 'N'                   
#                  #新增超領單單頭 
#                  INSERT INTO sfda_t (sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,sfda002,sfda003,sfda004,sfda014,sfda015,
#                                      sfdaownid,sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,sfdastus)   
#                              VALUES (g_enterprise,g_site,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,l_sfda.sfda002,l_sfda.sfda003,
#                                      l_sfda.sfda004,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,l_sfda.sfdaowndp,l_sfda.sfdacrtid,
#                                      l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,l_sfda.sfdastus)         
#                                      
#               END IF               
            END IF
            
         END FOR   
         
         
         #更新單據狀態
         UPDATE inpf_t SET inpfstus = 'S',
                           inpfpstid = g_user,
                           inpfpstdt = g_date
          WHERE inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpfdocno = g_inpf_d[i].inpfdocno
            AND inpfseq = g_inpf_d[i].inpfseq
          IF NOT r_success THEN  
             CALL s_transaction_end('N','0')
          ELSE
             CALL s_transaction_end('Y','0')
             LET l_count = l_count + 1
          END IF          
      END FOR
      CALL s_transaction_begin() 
      LET r_success = TRUE       
      IF NOT cl_null(l_zf_inbadocno) THEN
         IF NOT s_aint302_conf(l_zf_inbadocno) THEN
            LET r_success = FALSE 
         END IF   
#         IF NOT s_aint302_conf_upd(l_zf_inbadocno) THEN
#            LET r_success = FALSE 
#         END IF           
      END IF
      IF NOT cl_null(l_zs_inbadocno) THEN   
         IF NOT s_aint302_conf(l_zs_inbadocno) THEN
            LET r_success = FALSE 
         END IF 
#         IF NOT s_aint302_conf_upd(l_zs_inbadocno) THEN
#            LET r_success = FALSE 
#         END IF          
      END IF  
      IF NOT cl_null(l_fl_sfdadocno) THEN
         IF NOT s_asft310_confirm_chk(l_fl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF
         IF NOT s_asft310_confirm_upd(l_fl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF         
      END IF
      IF NOT cl_null(l_cl_sfdadocno) THEN
         IF NOT s_asft310_confirm_chk(l_cl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF  
         IF NOT s_asft310_confirm_upd(l_cl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF           
      END IF
      IF NOT cl_null(l_tl_sfdadocno) THEN      
         IF NOT s_asft310_confirm_chk(l_tl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF 
         IF NOT s_asft310_confirm_upd(l_tl_sfdadocno) THEN
            LET r_success = FALSE 
         END IF          
      END IF  
      IF NOT r_success THEN
         CALL s_transaction_end('N','0') 
      ELSE
         CALL s_transaction_end('Y','0')       
      END IF      
   END IF
   CALL cl_err_collect_show()    #add by lixh 20150916 
   #過帳成功後 現有庫存&在製工單都已經過賬
   CALL ainp880_upd_inpb() #160517-00016#1 
   
#160517-00016#1 mark
#   UPDATE inpb_t SET inpb002 = 'Y',
#                     inpb003 = 100,
#                     inpb006 = g_user,
#                     inpb007 = g_date
#    WHERE inpbent = g_enterprise
#      #AND inpbsite = g_site
#      AND inpb001 = '15'
#160517-00016#1 mark

   #资料拋转成功！（拋转笔数：%1笔）
   IF l_count > 0 THEN
       CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00394'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_count
      CALL cl_err()
   ELSE
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00395'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF       
   LET g_stage = 100
   DISPLAY g_stage TO stagecomplete
   CALL ainp880_b_fill()   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 新增庫存交易檔
# Memo...........:
# Usage..........: CALL ainp880_get_values()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_get_values()
#DEFINE  l_type   LIKE inaj_t.inaj004        
#   LET g_inaj.inajent = g_enterprise
#   LET g_inaj.inajsite = g_site
#   LET g_inaj.inaj001 = g_detail_d[i].inpddocno
#   LET g_inaj.inaj002 = g_detail_d[i].inpdseq
#   LET g_inaj.inaj003 = 0
#   LET g_inaj.inaj004 = l_type
#   LET g_inaj.inaj005 = g_detail_d[i].inpd001
#   LET g_inaj.inaj006 = g_detail_d[i].inpd002
#   LET g_inaj.inaj007 = g_detail_d[i].inpd003
#   LET g_inaj.inaj008 = g_detail_d[i].inpd005
#   LET g_inaj.inaj009 = g_detail_d[i].inpd006
#   LET g_inaj.inaj010 = g_detail_d[i].inpd007  
#   LET g_inaj.inaj011 = l_more
#   LET g_inaj.inaj012 = g_detail_d[i].inpd010  
#   LET g_inaj.inaj022 = g_date
#   LET g_inaj.inaj023 = g_date  
   
END FUNCTION

################################################################################
# Descriptions...: 過賬還原
# Memo...........:
# Usage..........: CALL ainp880_unpost_upd()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_unpost_upd()
DEFINE  i            LIKE type_t.num5 
DEFINE  j            LIKE type_t.num5
DEFINE  l_cnt        LIKE type_t.num5
DEFINE  l_more       LIKE inpd_t.inpd036
DEFINE  l_success    LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_stus       LIKE inpd_t.inpdstus
DEFINE  l_inpa009    LIKE inpa_t.inpa009
DEFINE  l_inpa010    LIKE inpa_t.inpa010
DEFINE  l_inpa011    LIKE inpa_t.inpa011 
DEFINE  l_inpa012    LIKE inpa_t.inpa012 
DEFINE  l_inpa013    LIKE inpa_t.inpa009
DEFINE  l_inpa014    LIKE inpa_t.inpa010
DEFINE  l_inpa015    LIKE inpa_t.inpa011 
DEFINE  l_inpa016    LIKE inpa_t.inpa012
DEFINE  l_type       LIKE inaj_t.inaj004
DEFINE  l_type_t     LIKE inaj_t.inaj004
DEFINE  l_inaj011    LIKE inaj_t.inaj011
DEFINE  l_inaj012    LIKE inaj_t.inaj012
DEFINE  l_inaj027    LIKE inaj_t.inaj027
DEFINE  l_sfdadocno  LIKE sfda_t.sfdadocno
DEFINE  l_inbadocno  LIKE inba_t.inbadocno
DEFINE  l_inbastus   LIKE inba_t.inbastus
DEFINE  l_sfdastus   LIKE sfda_t.sfdastus
#DEFINE  l_inpe       RECORD LIKE inpe_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_inpe RECORD  #盤點單製造批序號明細檔
       inpeent LIKE inpe_t.inpeent, #企业编号
       inpesite LIKE inpe_t.inpesite, #营运据点
       inpedocno LIKE inpe_t.inpedocno, #盘点编号
       inpeseq LIKE inpe_t.inpeseq, #项次
       inpeseq2 LIKE inpe_t.inpeseq2, #序号
       inpe001 LIKE inpe_t.inpe001, #料件编号
       inpe002 LIKE inpe_t.inpe002, #产品特征
       inpe003 LIKE inpe_t.inpe003, #库存管理特征
       inpe004 LIKE inpe_t.inpe004, #包装容器编号
       inpe005 LIKE inpe_t.inpe005, #库位
       inpe006 LIKE inpe_t.inpe006, #储位
       inpe007 LIKE inpe_t.inpe007, #批号
       inpe008 LIKE inpe_t.inpe008, #制造批号
       inpe009 LIKE inpe_t.inpe009, #制造序号
       inpe010 LIKE inpe_t.inpe010, #制造日期
       inpe011 LIKE inpe_t.inpe011, #有效日期
       inpe012 LIKE inpe_t.inpe012, #现有库存量
       inpe030 LIKE inpe_t.inpe030, #盘点数量-初盘(一)
       inpe031 LIKE inpe_t.inpe031, #录入人员-初盘(一)
       inpe032 LIKE inpe_t.inpe032, #录入日期-初盘(一)
       inpe033 LIKE inpe_t.inpe033, #盘点人员-初盘(一)
       inpe034 LIKE inpe_t.inpe034, #盘点日期-初盘(一)
       inpe035 LIKE inpe_t.inpe035, #盘点数量-初盘(二)
       inpe036 LIKE inpe_t.inpe036, #录入人员-初盘(二)
       inpe037 LIKE inpe_t.inpe037, #录入日期-初盘(二)
       inpe038 LIKE inpe_t.inpe038, #盘点人员-初盘(二)
       inpe039 LIKE inpe_t.inpe039, #盘点日期-初盘(二)
       inpe050 LIKE inpe_t.inpe050, #盘点数量-复盘(一)
       inpe051 LIKE inpe_t.inpe051, #录入人员-复盘(一)
       inpe052 LIKE inpe_t.inpe052, #录入日期-复盘(一)
       inpe053 LIKE inpe_t.inpe053, #盘点人员-复盘(一)
       inpe054 LIKE inpe_t.inpe054, #盘点日期-复盘(一)
       inpe055 LIKE inpe_t.inpe055, #盘点数量-复盘(二)
       inpe056 LIKE inpe_t.inpe056, #录入人员-复盘(二)
       inpe057 LIKE inpe_t.inpe057, #录入日期-复盘(二)
       inpe058 LIKE inpe_t.inpe058, #盘点人员-复盘(二)
       inpe059 LIKE inpe_t.inpe059 #盘点日期-复盘(二)
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE  l_xh_type    LIKE type_t.chr1
DEFINE  l_xh_more    LIKE inpe_t.inpe055
DEFINE  l_inpe055    LIKE inpe_t.inpe055
DEFINE  l_count      LIKE type_t.num5
DEFINE  l_inpf004    LIKE inpf_t.inpf004
DEFINE  l_para_data  LIKE inpd_t.inpdpstdt
DEFINE  l_sql        STRING
  
   LET r_success = TRUE

   CALL cl_err_collect_init() 
   IF g_invent = 'Y' THEN   #現有庫存
      LET l_sql = " SELECT inpeseq2 FROM inpe_t ",
                  "  WHERE inpeent = '",g_enterprise,"'",
                  "    AND inpesite = '",g_site,"'",
                  "    AND inpedocno = ? ",
                  "    AND inpeseq = ? "
      PREPARE ainp880_inai_sel_no FROM l_sql
      DECLARE ainp880_inai_cur_no CURSOR FOR ainp880_inai_sel_no
      LET l_count = 0
      FOR i = 1 TO g_detail_d.getLength()
      
         IF g_detail_d[i].sel = 'N' THEN
            CONTINUE FOR
         END IF
         IF g_detail_d[i].inpdstus <> 'S' THEN
            RETURN TRUE
         END IF
         #add by lixh 20150608
         CALL s_cost_realtime_chk_unpost(g_site) RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE        
            RETURN r_success
         END IF
         #add by lixh 20150608
         
         #add by lixh 20150212 
         #過賬日期小於成本關帳日則不允許過帳還原，錯誤訊息「過賬日期小於關帳日期，不可過帳還原]
         CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
         IF g_detail_d[i].inpdpstdt <= l_para_data OR cl_null(g_detail_d[i].inpdpstdt) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00352'   #簽收日期小於關帳日期，請重新輸入！
            LET g_errparam.extend = g_detail_d[i].inpdpstdt
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE FOR
         END IF          
         CALL s_transaction_begin()  
      #初盤OR復盤
         SELECT inpa009,inpa010,inpa011,inpa012 INTO l_inpa009,l_inpa010,l_inpa011,l_inpa012 FROM inpa_t
          WHERE inpaent = g_enterprise
            AND inpasite = g_site
            AND inpadocno = g_detail_d[i].inpd008
            
        #20151006 Sarah mod -----(S)
        #原來寫的mark
        IF l_inpa012 = 'Y' OR l_inpa011 = 'Y' THEN
           LET l_stus = '6'
        #   LET l_inaj011 = g_detail_d[i].inpd056 - g_detail_d[i].inpd011
        ELSE
           LET l_stus = '5'
        #   LET l_inaj011 = g_detail_d[i].inpd036 - g_detail_d[i].inpd011
        END IF
         #參考ainp880_post_upd()段重寫
         IF NOT cl_null(g_detail_d[i].inpd056) THEN
            LET l_inaj011 = g_detail_d[i].inpd056 - g_detail_d[i].inpd011
         ELSE
            IF NOT cl_null(g_detail_d[i].inpd050) THEN
               LET l_inaj011 = g_detail_d[i].inpd050 - g_detail_d[i].inpd011
            ELSE
               IF NOT cl_null(g_detail_d[i].inpd036) THEN
                  LET l_inaj011 = g_detail_d[i].inpd036 - g_detail_d[i].inpd011
               ELSE
                  IF NOT cl_null(g_detail_d[i].inpd030) THEN
                     LET l_inaj011 = g_detail_d[i].inpd030 - g_detail_d[i].inpd011
                  ELSE
                     LET l_inaj011 = 0
                  END IF
               END IF            
            END IF               
         END IF
        #20151006 Sarah mod -----(E)         
         IF l_inaj011 < 0 THEN
#            LET l_inaj011 = l_inaj011 * -1  #20150929 DSC.liquor mod不用管是不是負數，過帳還原都要*-1
            LET l_type = 1
         ELSE
            LET l_type = -1         
         END IF
         #不用管數量是不是負的，只要是過帳還原，應該都要把數量*-1
         #20150929 DSC.liquor mod----
         LET l_inaj011 = l_inaj011 * -1
         #20150929 DSC.liquor mod
         
         UPDATE inpd_t SET inpdstus = l_stus,
                           inpdpstid = '',  
                           inpdpstdt = ''                         
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpddocno = g_detail_d[i].inpddocno
            AND inpdseq = g_detail_d[i].inpdseq   
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd inpd_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            CALL s_transaction_end('N','0')
#            RETURN r_success
            CONTINUE FOR
         END IF     
         IF l_inaj011 <> 0 THEN       #add by lixh 20150122   
            IF l_type = 1 THEN
               LET l_type_t = -1 
            ELSE
               LET l_type_t = 1          
            END IF         
            #SELECT inaj011,inaj012,inaj027 INTO l_inaj011,l_inaj012,l_inaj027 FROM inaj_t
            SELECT inaj011*inaj004,inaj012,inaj027 INTO l_inaj011,l_inaj012,l_inaj027 FROM inaj_t  #20150929 DSC.liquor add 加上*inaj004，把正負數弄對
             WHERE inajent = g_enterprise
               AND inajsite = g_site
               AND inaj001 = g_detail_d[i].inpddocno
               AND inaj002 = g_detail_d[i].inpdseq
               AND inaj003 = 0
               #AND inaj004 = l_type_t  #20150929 DSC.liquor mark
           IF cl_null(l_inaj027) THEN
              LET l_inaj027 = 0
           END IF
            LET l_inaj011 = l_inaj011 * -1  #20150929 DSC.liquor add 只要是過帳還原，數量都*-1
            LET l_inaj027 = l_inaj027 * -1  #20150929 DSC.liquor add 只要是過帳還原，數量都*-1
            CALL s_inventory_upd_inag(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,g_detail_d[i].inpd006,
            #                          g_detail_d[i].inpd007,l_type,l_inaj011,g_date,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0,g_detail_d[i].inpd010,  #add by lixh 20150323
                                      g_detail_d[i].inpd007,'2',l_inaj011,g_date,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0,g_detail_d[i].inpd010,
                                      l_inaj027,'2',g_site)
                 RETURNING l_success
            IF NOT l_success THEN      
               LET r_success = FALSE
               CALL s_transaction_end('N','0')
#               RETURN r_success            
               CONTINUE FOR
            END IF
            IF NOT cl_null(g_detail_d[i].inpd012) THEN
               CALL s_inventory_upd_inah(g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,g_detail_d[i].inpd005,g_detail_d[i].inpd006,
               #                          g_detail_d[i].inpd007,g_detail_d[i].inpd012,'1',l_type,l_inaj011,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0)
                                        g_detail_d[i].inpd007,g_detail_d[i].inpd012,'1','2',l_inaj011,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,0)
                    RETURNING l_success                                
               IF NOT l_success THEN      
                  LET r_success = FALSE
                  CALL s_transaction_end('N','0')
#                  RETURN r_success            
                  CONTINUE FOR
               END IF  
            END IF      
            
            #160517-00029#4   2016/05/31 By earl add s
            IF NOT s_barcode_01_inventory('2',g_prog,g_detail_d[i].inpddocno,g_detail_d[i].inpdseq) THEN
               LET r_success = FALSE
               CALL s_transaction_end('N','0')
               CONTINUE FOR
            END IF
            #160517-00029#4   2016/05/31 By earl add e
            
            FOREACH ainp880_inai_cur_no USING g_detail_d[i].inpddocno,g_detail_d[i].inpdseq INTO l_inpe.* 
               IF l_inpa012 = 'Y' OR l_inpa011 = 'Y' THEN 
                  IF l_inpa012 = 'Y' THEN
                     LET l_inpe055 = l_inpe.inpe055
                  ELSE
                     LET l_inpe055 = l_inpe.inpe050
                  END IF    
               ELSE
                  IF l_inpa010 = 'Y' THEN
                     LET l_inpe055 = l_inpe.inpe035
                  ELSE
                     LET l_inpe055 = l_inpe.inpe030              
                  END IF
               END IF 
               LET l_xh_more = l_inpe055 - l_inpe.inpe012
               IF l_xh_more > 0 THEN
                  LET l_xh_type = -1
               ELSE
                  LET l_xh_type = 1
               END IF 
#               CALL s_inventory_upd_inai(g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,l_inpe.inpeseq2,l_xh_type,g_detail_d[i].inpd001,g_detail_d[i].inpd002,g_detail_d[i].inpd003,
#                                         g_detail_d[i].inpd005,g_detail_d[i].inpd006,g_detail_d[i].inpd007,g_detail_d[i].inpd010)
#                    RETURNING l_success    
#               IF NOT l_success THEN      
#                  LET r_success = FALSE
#                  CALL s_transaction_end('N','0')
##                  RETURN r_success            
#                  CONTINUE FOR
#               END IF 
            END FOREACH        
            #CALL s_inventory_del_inaj(g_detail_d[i].inpddocno,g_site) RETURNING l_success                     #160612-00001#1 mark
            CALL ainp880_del_inaj(g_detail_d[i].inpddocno,g_detail_d[i].inpdseq,g_site) RETURNING l_success    #160612-00001#1 add
            IF NOT l_success THEN      
               LET r_success = FALSE
               CALL s_transaction_end('N','0')
#               RETURN r_success            
               CONTINUE FOR
            END IF  
            #mark by lixh 20150828 (移到s_inventory_del_inaj()去做）
            #刪除批序號交易明細  
#            DELETE FROM inal_t WHERE inalent = g_enterprise
#                                 AND inalsite = g_site
#                                 AND inal001 = g_detail_d[i].inpddocno   #單據編號
#                                 AND inal002 = g_detail_d[i].inpdseq     #項次 
            #mark by lixh 20150828 (移到s_inventory_del_inaj()去做）                                 
         END IF                              
         CALL s_transaction_end('Y','0')
         LET l_count = l_count + 1
      END FOR
   END IF   

   IF g_work = 'Y' THEN   #在制工單
      FOR j = 1 TO g_inpf_d.getLength()
         IF g_inpf_d[j].sel01 = 'N' THEN
            CONTINUE FOR
         END IF
         #add by lixh 20150212 
         #過賬日期小於成本關帳日則不允許過帳還原，錯誤訊息「過賬日期小於關帳日期，不可過帳還原]
         CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
         IF g_inpf_d[j].inpfpstdt <= l_para_data OR cl_null(g_inpf_d[j].inpfpstdt) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00352'   #簽收日期小於關帳日期，請重新輸入！
            LET g_errparam.extend = g_inpf_d[j].inpfpstdt
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CONTINUE FOR
         END IF            
         LET r_success = TRUE
         CALL s_transaction_begin()
         #雜收雜發
         SELECT inbadocno,inbastus INTO l_inbadocno,l_inbastus FROM inba_t
          WHERE inbaent = g_enterprise AND inbasite = g_site AND inba006 = g_inpf_d[j].inpfdocno
       
         IF NOT cl_null(l_inbadocno) AND l_inbastus = 'S' THEN
            #過賬還原
            IF NOT s_aint302_unposted(l_inbadocno) THEN
               LET r_success = FALSE
            END IF
#            IF NOT s_aint302_unposted_upd(l_inbadocno) THEN
#               LET r_success = FALSE
#            END IF            
            #取消確認
            IF NOT s_aint302_unconf(l_inbadocno) THEN
               LET r_success = FALSE
            END IF
#            IF NOT s_aint302_unconf_upd(l_inbadocno) THEN
#               LET r_success = FALSE
#            END IF            
         END IF
         IF NOT cl_null(l_inbadocno) AND l_inbastus = 'Y' THEN
            #取消確認
            IF NOT s_aint302_unconf(l_inbadocno) THEN
               LET r_success = FALSE
            END IF   
#            IF NOT s_aint302_unconf_upd(l_inbadocno) THEN
#               LET r_success = FALSE
#            END IF             
         END IF
         DELETE FROM inbb_t WHERE inbbent = g_enterprise AND inbbsite = g_site AND inbb017 = g_inpf_d[j].inpfdocno
         DELETE FROM inbc_t WHERE inbcent = g_enterprise AND inbcsite = g_site 
                              AND inbcdocno IN (SELECT inbadocno FROM inba_t WHERE inbaent = g_enterprise AND inbasite = g_site 
                              AND inba006 = g_inpf_d[j].inpfdocno)
         DELETE FROM inba_t WHERE inbaent = g_enterprise AND inbasite = g_site AND inba006 = g_inpf_d[j].inpfdocno  
       
         #過賬還原之後再進行刪除
         DECLARE ainp800_inpf_unpost CURSOR FOR SELECT sfdadocno,sfdastus FROM sfda_t WHERE sfdaent = g_enterprise
                                                                               AND sfdasite = g_site
                                                                               AND sfda014 = g_inpf_d[j].inpfdocno
         FOREACH ainp800_inpf_unpost INTO l_sfdadocno,l_sfdastus 
                  
            IF NOT cl_null(l_sfdadocno) AND l_sfdastus = 'S' THEN
               IF NOT s_asft310_unpost_chk(l_sfdadocno) THEN
                  LET r_success = FALSE
               END IF
               IF NOT s_asft310_unpost_upd(l_sfdadocno) THEN
                  LET r_success = FALSE
               END IF               
               IF NOT s_asft310_unconfirm_chk(l_sfdadocno) THEN
                  LET r_success = FALSE
               ELSE
                  IF NOT s_asft310_unconfirm_upd(l_sfdadocno) THEN   
                     LET r_success = FALSE 
                  END IF                 
               END IF           
            END IF
            IF NOT cl_null(l_sfdadocno) AND l_sfdastus = 'Y' THEN
               IF NOT s_asft310_unconfirm_chk(l_sfdadocno) THEN   
                  LET r_success = FALSE 
               END IF  
               IF NOT s_asft310_unconfirm_upd(l_sfdadocno) THEN   
                  LET r_success = FALSE 
               END IF               
            END IF
            DELETE FROM sfdb_t WHERE sfdbent = g_enterprise AND sfdbsite = g_site AND sfdbdocno = l_sfdadocno
            DELETE FROM sfdc_t WHERE sfdcent = g_enterprise AND sfdcsite = g_site AND sfdcdocno = l_sfdadocno 
            DELETE FROM sfdd_t WHERE sfddent = g_enterprise AND sfddsite = g_site AND sfdddocno = l_sfdadocno
            DELETE FROM sfde_t WHERE sfdeent = g_enterprise AND sfdesite = g_site AND sfdedocno = l_sfdadocno
            DELETE FROM sfdf_t WHERE sfdfent = g_enterprise AND sfdfsite = g_site AND sfdfdocno = l_sfdadocno
         END FOREACH 
         DELETE FROM sfda_t WHERE sfdaent = g_enterprise AND sfdasite = g_site AND sfda014 = g_inpf_d[j].inpfdocno 
         SELECT inpf004 INTO l_inpf004 FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpfdocno = g_inpf_d[j].inpfdocno
            AND inpfseq = g_inpf_d[j].inpfseq
            
         SELECT inpa013,inpa014,inpa015,inpa016 INTO l_inpa013,l_inpa014,l_inpa015,l_inpa016 FROM inpa_t
          WHERE inpaent = g_enterprise
            AND inpasite = g_site
            AND inpadocno = l_inpf004
         IF l_inpa016 = 'Y' OR l_inpa015 = 'Y' THEN
            LET l_stus = '6'
         ELSE
            LET l_stus = '5'
         END IF
         UPDATE inpf_t SET inpfstus = l_stus
          WHERE inpfent = g_enterprise 
            AND inpfsite = g_site
            AND inpfdocno = g_inpf_d[j].inpfdocno
            AND inpfseq = g_inpf_d[j].inpfseq
         IF NOT r_success THEN
            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
            LET l_count = l_count + 1  
         END IF         
      END FOR
      LET j = j - 1
   END IF
   CALL cl_err_collect_show()    #add by lixh 20150916   
   #過帳還原成功後 現有庫存&在製工單都已經過賬
##160517-00016#1 mark   
#   UPDATE inpb_t SET inpb002 = 'N',
#                     inpb003 = '',
#                     inpb006 = '',
#                     inpb007 = ''
#    WHERE inpbent = g_enterprise
#      #AND inpbsite = g_site
#      AND inpb001 = '15'  
##160517-00016#1 mark
   CALL ainp880_upd_inpb() #160517-00016#1 
      
   CALL s_transaction_end('Y','0')
   #资料拋转成功！（拋转笔数：%1笔）
   IF l_count > 0 THEN
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00394'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_count
      CALL cl_err()
   ELSE
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00395'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF       
   LET g_stage = 100
   DISPLAY g_stage TO stagecomplete   
   CALL ainp880_b_fill()   
   RETURN r_success      
END FUNCTION
################################################################################
# Descriptions...: 新增sfdd_t/sfde_t
# Memo...........:
# Usage..........: CALL ainp880_ins_sfdd_sfde(p_sfdcdocno,p_sfdcseq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_ins_sfdd_sfde(p_sfdcdocno,p_sfdcseq)
DEFINE p_sfdcdocno   LIKE sfdc_t.sfdcdocno   #目的表sfdc_t 或 ainp880_sfdc_t
DEFINE p_sfdcseq     LIKE sfdc_t.sfdcseq
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企业编号
       sfdcsite LIKE sfdc_t.sfdcsite, #营运据点
       sfdcdocno LIKE sfdc_t.sfdcdocno, #发退料单号
       sfdcseq LIKE sfdc_t.sfdcseq, #项次
       sfdc001 LIKE sfdc_t.sfdc001, #工单单号
       sfdc002 LIKE sfdc_t.sfdc002, #工单项次
       sfdc003 LIKE sfdc_t.sfdc003, #工单项序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料号
       sfdc005 LIKE sfdc_t.sfdc005, #产品特征
       sfdc006 LIKE sfdc_t.sfdc006, #单位
       sfdc007 LIKE sfdc_t.sfdc007, #申请数量
       sfdc008 LIKE sfdc_t.sfdc008, #实际数量
       sfdc009 LIKE sfdc_t.sfdc009, #参考单位
       sfdc010 LIKE sfdc_t.sfdc010, #参考单位需求数量
       sfdc011 LIKE sfdc_t.sfdc011, #参考单位实际数量
       sfdc012 LIKE sfdc_t.sfdc012, #指定库位
       sfdc013 LIKE sfdc_t.sfdc013, #指定储位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批号
       sfdc015 LIKE sfdc_t.sfdc015, #理由码
       sfdc016 LIKE sfdc_t.sfdc016, #库存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017, #正负
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定义字段(文本)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定义字段(文本)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定义字段(文本)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定义字段(文本)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定义字段(文本)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定义字段(文本)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定义字段(文本)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定义字段(文本)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定义字段(文本)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定义字段(文本)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定义字段(数字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定义字段(数字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定义字段(数字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定义字段(数字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定义字段(数字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定义字段(数字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定义字段(数字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定义字段(数字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定义字段(数字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定义字段(数字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定义字段(日期时间)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定义字段(日期时间)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定义字段(日期时间)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定义字段(日期时间)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定义字段(日期时间)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定义字段(日期时间)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定义字段(日期时间)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定义字段(日期时间)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定义字段(日期时间)029
       sfdcud030 LIKE sfdc_t.sfdcud030 #自定义字段(日期时间)030
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
#DEFINE l_sfdc_t      RECORD LIKE sfdc_t.*  #161124-00048#4  16/12/09 By 08734 mark
#161124-00048#4  16/12/09 By 08734 add(S)
DEFINE l_sfdc_t RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企业编号
       sfdcsite LIKE sfdc_t.sfdcsite, #营运据点
       sfdcdocno LIKE sfdc_t.sfdcdocno, #发退料单号
       sfdcseq LIKE sfdc_t.sfdcseq, #项次
       sfdc001 LIKE sfdc_t.sfdc001, #工单单号
       sfdc002 LIKE sfdc_t.sfdc002, #工单项次
       sfdc003 LIKE sfdc_t.sfdc003, #工单项序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料号
       sfdc005 LIKE sfdc_t.sfdc005, #产品特征
       sfdc006 LIKE sfdc_t.sfdc006, #单位
       sfdc007 LIKE sfdc_t.sfdc007, #申请数量
       sfdc008 LIKE sfdc_t.sfdc008, #实际数量
       sfdc009 LIKE sfdc_t.sfdc009, #参考单位
       sfdc010 LIKE sfdc_t.sfdc010, #参考单位需求数量
       sfdc011 LIKE sfdc_t.sfdc011, #参考单位实际数量
       sfdc012 LIKE sfdc_t.sfdc012, #指定库位
       sfdc013 LIKE sfdc_t.sfdc013, #指定储位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批号
       sfdc015 LIKE sfdc_t.sfdc015, #理由码
       sfdc016 LIKE sfdc_t.sfdc016, #库存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017, #正负
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定义字段(文本)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定义字段(文本)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定义字段(文本)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定义字段(文本)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定义字段(文本)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定义字段(文本)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定义字段(文本)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定义字段(文本)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定义字段(文本)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定义字段(文本)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定义字段(数字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定义字段(数字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定义字段(数字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定义字段(数字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定义字段(数字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定义字段(数字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定义字段(数字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定义字段(数字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定义字段(数字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定义字段(数字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定义字段(日期时间)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定义字段(日期时间)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定义字段(日期时间)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定义字段(日期时间)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定义字段(日期时间)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定义字段(日期时间)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定义字段(日期时间)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定义字段(日期时间)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定义字段(日期时间)029
       sfdcud030 LIKE sfdc_t.sfdcud030 #自定义字段(日期时间)030
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq   #临时表key值
DEFINE l_cnt         LIKE type_t.num5
DEFINE l_rate        LIKE inaj_t.inaj014   #单位换算率
DEFINE l_sfdc004     LIKE sfdc_t.sfdc004   #需求料号
DEFINE l_sfdc005     LIKE sfdc_t.sfdc005   #特征
DEFINE l_sfdc006     LIKE sfdc_t.sfdc006   #单位
DEFINE l_sfdc009     LIKE sfdc_t.sfdc009   #参考单位
DEFINE l_sfdc010     LIKE sfdc_t.sfdc010   #参考单位数量
DEFINE l_sfba028     LIKE sfba_t.sfba028
DEFINE l_sfba006     LIKE sfba_t.sfba006
DEFINE l_sfba021     LIKE sfba_t.sfba021
DEFINE l_sfba014     LIKE sfba_t.sfba014
DEFINE l_success     LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
DEFINE g_count       LIKE type_t.num5
DEFINE l_sfda002     LIKE sfda_t.sfda002

#   IF cl_null(p_sfdc007) OR p_sfdc007 = 0 THEN
#      RETURN
#   END IF
#   LET r_success = TRUE
#   IF cl_null(p_sfdc012) THEN LET p_sfdc012 = ' ' END IF
#   IF cl_null(p_sfdc013) THEN LET p_sfdc013 = ' ' END IF
#   IF cl_null(p_sfdc014) THEN LET p_sfdc014 = ' ' END IF
#   IF cl_null(p_sfdc016) THEN LET p_sfdc016 = ' ' END IF
   
#   #检查单身是否已存在相同发料资料，若有则叠加，若无则新增
#   LET g_sql = "SELECT sfdcseq,sfdc004,sfdc005,sfdc006,sfdc009 ",
#               "  FROM sfdc_t ",
#               " WHERE sfdcent  = ",g_enterprise,
#               "   AND sfdcdocno= '",p_sfdadocno,"' ",
#               "   AND sfdc001  = '",p_sfbadocno,"' ",   #工单单号
#               "   AND sfdc002  = ",p_sfbaseq,           #工单项次
#               "   AND sfdc003  = ",p_sfbaseq1,          #工单项序
#               "   AND sfdc012  = '",p_sfdc012,"' ",    #指定库位
#               "   AND sfdc013  = '",p_sfdc013,"' ",    #指定储位
#               "   AND sfdc014  = '",p_sfdc014,"' ",    #指定批号
#               "   AND sfdc016  = '",p_sfdc016,"' "     #库存管理特征
#   IF NOT cl_null(p_inag002) THEN
#      LET g_sql = g_sql CLIPPED," AND sfdc005  = '",p_inag002,"' "  #产品特征 add 141208 若工单不指定在发料单指定时需要判别
#   END IF
##   IF cl_null(p_sfdc015) THEN   #mark by lixh 20150204
#   IF p_sfdc015 IS NULL THEN     #add by lixh 20150204
#      LET g_sql = g_sql CLIPPED," AND sfdc015 IS NULL "     #理由码
#   ELSE
#      LET g_sql = g_sql CLIPPED," AND sfdc015  = '",p_sfdc015,"' "     #理由码
#   END IF
#   DECLARE ainp880_ins_sfdc_c1 SCROLL CURSOR FROM g_sql
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'declare ainp880_ins_sfdc_c1 err'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN
#   END IF
#   OPEN ainp880_ins_sfdc_c1
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'open ainp880_ins_sfdc_c1 err'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET r_success = FALSE
#      RETURN
#   END IF
#   FETCH FIRST ainp880_ins_sfdc_c1 INTO l_sfdcseq,l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009 
#   CLOSE ainp880_ins_sfdc_c1
#   SELECT sfba028,sfba006,sfba021,sfba014 INTO l_sfba028,l_sfba006,l_sfba021,l_sfba014 FROM sfba_t
#    WHERE sfbaent = g_enterprise
#      AND sfbasite = g_site
#      AND sfbadocno = p_sfbadocno
#      AND sfbaseq = p_sfbaseq
#      AND sfbaseq1 = p_sfbaseq1
#   IF NOT cl_null(l_sfdcseq) AND l_sfdcseq > 0 THEN
#      IF NOT cl_null(l_sfdc009) THEN
#         CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,p_sfdc007) RETURNING l_success,l_sfdc010
#         IF NOT l_success THEN
#            LET l_sfdc010 = p_sfdc007
#         END IF
#      ELSE
#         LET l_sfdc010 = 0
#      END IF
#
#      LET g_sql = "UPDATE sfdc_t",
#                  "   SET sfdc007 = sfdc007 + ",p_sfdc007,",",  #申请数量
#                  "       sfdc010 = sfdc010 + ",l_sfdc010,      #参考单位需求数量
#                  " WHERE sfdcent  = ",g_enterprise,
#                  "   AND sfdcdocno= '",p_sfdadocno,"' ",
#                  "   AND sfdcseq  = ",l_sfdcseq
#      PREPARE ainp880_ins_sfdc_p3 FROM g_sql
#      EXECUTE ainp880_ins_sfdc_p3
#      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'update sfdc'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET r_success = FALSE
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
#      FREE ainp880_ins_sfdc_p3
#      LET g_count = g_count + 1  #add 141226
#      
#      #如果是实体表的需同步sfde。另因sfdc只更新了需求申请数量，不涉及实际发料数量的变化，故sfdd、sfdf不做变化
#         #发料单：将发料需求单身相同的需求料号+特征+单位+参考单位+客供料汇总到同一笔资料
#         #退料单：将退料需求单身相同的需求料号+特征+单位+参考单位汇总到同一笔数据
#         LET g_sql = " UPDATE sfde_t SET sfde004 = sfde004 + ",p_sfdc007,",",  #申請數量
#                     "                   sfde007 = sfde007 + ",l_sfdc010,      #參考單位申請數量
#                     " WHERE sfdeent  = ",g_enterprise,
#                     "   AND sfdedocno= '",p_sfdadocno,"' ",
#                     "   AND sfde001  = '",l_sfdc004,"' ",  #需求料号
#                     "   AND sfde002  = '",l_sfdc005,"' ",  #特征
#                     "   AND sfde003  = '",l_sfdc006,"' "   #单位
#                     #"   AND sfde006  = '",l_sfdc009,"' "   #参考单位
#
#         IF l_sfdc009 IS NULL THEN
#            LET g_sql = g_sql CLIPPED," AND sfde006 IS NULL "
#         ELSE
#            LET g_sql = g_sql CLIPPED," AND sfde006 = '",l_sfdc009,"' "
#         END IF 
#         IF g_prog[1,6] = 'asft31' THEN  #退料不记录客供料
#            IF l_sfba028 IS NULL THEN
#               LET g_sql = g_sql CLIPPED," AND sfde009 IS NULL "
#            ELSE
#               LET g_sql = g_sql CLIPPED," AND sfde009  = '",l_sfba028,"' "  #客供料
#            END IF
#         END IF
#         PREPARE ainp880_ins_sfdc_p4 FROM g_sql
#         EXECUTE ainp880_ins_sfdc_p4
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = 'update sfde'
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            LET r_success = FALSE
#            CALL s_transaction_end('N','0')
#            RETURN
#         END IF
#         FREE ainp880_ins_sfdc_p4
#   ELSE
#      LET l_sfdc.sfdcent   = g_enterprise
#      LET l_sfdc.sfdcsite  = g_site
#      LET l_sfdc.sfdcdocno = p_sfdadocno    #发料单号
#      
#      LET g_sql = "SELECT MAX(sfdcseq)+1 ",  #临时表项次
#                  "  FROM sfdc_t ",
#                  " WHERE sfdcent  = ",g_enterprise,
#                  "   AND sfdcdocno= '",p_sfdadocno,"' "
#      PREPARE ainp880_ins_sfdc_p2 FROM g_sql
#      EXECUTE ainp880_ins_sfdc_p2 INTO l_sfdc.sfdcseq
#      IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
#      FREE ainp880_ins_sfdc_p2
#      
#      LET l_sfdc.sfdc001 = p_sfbadocno  #工单单号
#      LET l_sfdc.sfdc002 = p_sfbaseq    #工单项次
#      LET l_sfdc.sfdc003 = p_sfbaseq1   #工单项序
#      LET l_sfdc.sfdc004 = l_sfba006    #需求料号
#      IF NOT cl_null(p_inag002) THEN
#         LET l_sfdc.sfdc005 = p_inag002    #特征
#      ELSE
#         LET l_sfdc.sfdc005 = l_sfba021    #特征
#      END IF
#      IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
#      LET l_sfdc.sfdc006 = l_sfba014    #单位
#      LET l_sfdc.sfdc007 = p_sfdc007          #申请数量
#      LET l_sfdc.sfdc008 = l_sfdc.sfdc007     #实际数量
#      SELECT imaf015 INTO l_sfdc.sfdc009      #参考单位
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite= g_site
#         AND imaf001 = l_sfdc.sfdc004
#      IF cl_null(l_sfdc.sfdc009) THEN
#         LET l_sfdc.sfdc010 = 0       #参考单位需求数量
#         LET l_sfdc.sfdc011 = 0       #参考单位实际数量
#      ELSE
#         #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
#         #mark 150101
#         #CALL s_aimi190_get_convert(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009) RETURNING l_success,l_rate
#         #IF NOT l_success THEN
#         #   LET l_rate = 1
#         #END IF
#         #LET l_sfdc.sfdc010 = l_sfdc.sfdc007 * l_rate
#         #mark 150101 end
#         #add 150101
#         CALL s_aooi250_convert_qty(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
#            RETURNING l_success,l_sfdc.sfdc010
#         IF NOT l_success THEN
#            LET l_sfdc.sfdc010 = l_sfdc.sfdc007
#         END IF
#         #add 150101 end
#         LET l_sfdc.sfdc011 = l_sfdc.sfdc010       #参考单位实际数量
#      END IF
#      LET l_sfdc.sfdc012 = p_sfdc012         #指定库位
#      LET l_sfdc.sfdc013 = p_sfdc013         #指定储位
#      LET l_sfdc.sfdc014 = p_sfdc014         #指定批号
#      LET l_sfdc.sfdc015 = p_sfdc015         #理由码
#      LET l_sfdc.sfdc016 = p_sfdc016         #库存管理特征
#      IF g_prog[1,6]='asft31' THEN
#         LET l_sfdc.sfdc017 = -1                #正负 发料为-1
#      END IF
#      IF g_prog[1,6]='asft32' THEN
#         LET l_sfdc.sfdc017 =  1                #正负 退料为1
#      END IF
#      SELECT sfda002 INTO l_sfda002 FROM sfda_t 
#       WHERE sfdaent = g_enterprise
#         AND sfdasite = g_site
#         AND sfdadocno = p_sfdadocno
#      #add 141211 发料单若没有库位，则产生到申请页签时实际数量为0
#      IF cl_null(p_sfdc012) AND l_sfda002[1,1]='1' THEN
#         LET l_sfdc.sfdc008 = 0
#         LET l_sfdc.sfdc011 = 0
#      END IF

      #同步新增sfdd
      CALL s_asft310_chg_sfdd_f_sfdc_ins(p_sfdcdocno,p_sfdcseq) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #新增或更新sfde('Y'代表新增或更新sfdf) 
      CALL s_asft310_chg_sfde_f_sfdc_ins(p_sfdcdocno,p_sfdcseq,'Y') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
#   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ainp880_upd_inpb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_upd_inpb()
DEFINE  l_n1    LIKE type_t.num10
DEFINE  l_n2    LIKE type_t.num10
DEFINE  l_n3    LIKE type_t.num10
DEFINE  l_n4    LIKE type_t.num10
DEFINE  j       LIKE type_t.num10
DEFINE  m       LIKE type_t.num10
DEFINE  l_inpd008_t   LIKE inpd_t.inpd008
DEFINE  l_inpf004_t   LIKE inpf_t.inpf004
DEFINE  l_inpb003     LIKE inpb_t.inpb003

   LET l_inpd008_t = ''
   LET j = 0
   LET l_n1 = 0
   LET l_n2 = 0
   LET l_n3 = 0
   LET l_n4 = 0
   FOR j = 1 TO g_detail_d.getLength()
      IF g_detail_d[j].sel = 'N' THEN
         CONTINUE FOR
      END IF
      IF l_inpd008_t IS NULL OR l_inpd008_t <> g_detail_d[j].inpd008 THEN
         LET l_inpd008_t = g_detail_d[j].inpd008
         LET l_n1 = 0
         SELECT COUNT(*) INTO l_n1 FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpd008 = g_detail_d[j].inpd008
            AND inpdstus = 'S'
         IF cl_null(l_n1) THEN LET l_n1 = 0 END IF 
         
         LET l_n2 = 0
         SELECT COUNT(*) INTO l_n2 FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpd008 = g_detail_d[j].inpd008
         IF cl_null(l_n2) THEN LET l_n2 = 0 END IF
                
         LET l_n3 = 0
         SELECT COUNT(*) INTO l_n3 FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpf004 = g_detail_d[j].inpd008
            AND inpfstus = 'S'
         IF cl_null(l_n3) THEN LET l_n3 = 0 END IF     
        
         LET l_n4 = 0
         SELECT COUNT(*) INTO l_n4 FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpf004 = g_detail_d[j].inpd008
        
         IF cl_null(l_n4) THEN LET l_n4 = 0 END IF  
         
         LET l_inpb003 = ((l_n1+l_n3)/(l_n2+l_n4))*100
         
         UPDATE inpb_t SET inpb002 = 'Y',
                           inpb003 = l_inpb003,
                           inpb006 = g_user,
                           inpb007 = g_date
          WHERE inpbent = g_enterprise
            AND inpbdocno = g_detail_d[j].inpd008
            AND inpb001 = '15'           
      END IF
   END FOR
   
   CALL g_detail_d.deleteElement(j)
   LET j = j - 1
   
   #在製工單盤點，為防止兩頁簽的盤點計劃單號不一致，故做2次更新
   LET l_inpf004_t = ''
   FOR m = 1 TO g_inpf_d.getLength()
      IF g_detail_d[m].sel = 'N' THEN
         CONTINUE FOR
      END IF
      IF l_inpf004_t IS NULL OR l_inpf004_t <> g_inpf_d[m].inpf004 THEN
         LET l_inpf004_t = g_inpf_d[m].inpf004
         LET l_n1 = 0
         SELECT COUNT(*) INTO l_n1 FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpd008 = g_inpf_d[m].inpf004
            AND inpdstus = 'S'
         IF cl_null(l_n1) THEN LET l_n1 = 0 END IF 
         
         LET l_n2 = 0
         SELECT COUNT(*) INTO l_n2 FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpd008 = g_inpf_d[m].inpf004
         IF cl_null(l_n2) THEN LET l_n2 = 0 END IF
                
         LET l_n3 = 0
         SELECT COUNT(*) INTO l_n3 FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpf004 = g_inpf_d[m].inpf004
            AND inpfstus = 'S'
         IF cl_null(l_n3) THEN LET l_n3 = 0 END IF     
        
         LET l_n4 = 0
         SELECT COUNT(*) INTO l_n4 FROM inpf_t
          WHERE inpfent = g_enterprise
            AND inpf004 = g_inpf_d[m].inpf004
        
         IF cl_null(l_n4) THEN LET l_n4 = 0 END IF  
         
         LET l_inpb003 = ((l_n1+l_n3)/(l_n2+l_n4))*100
         
         UPDATE inpb_t SET inpb002 = 'Y',
                           inpb003 = l_inpb003,
                           inpb006 = g_user,
                           inpb007 = g_date
          WHERE inpbent = g_enterprise
            AND inpbdocno = g_inpf_d[m].inpf004
            AND inpb001 = '15'           
      END IF
   END FOR   
   CALL g_inpf_d.deleteElement(j)
   LET m = m - 1
   
END FUNCTION

################################################################################
# Descriptions...: 删除库存盘点产生的inaj_t(精确到项次)
# Memo...........:
# Usage..........: CALL ainp880_del_inaj(p_docno,p_seq,p_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp880_del_inaj(p_docno,p_seq,p_site)
DEFINE   p_docno      LIKE inaj_t.inaj001
DEFINE   p_seq        LIKE inaj_t.inaj002
DEFINE   p_site       LIKE inaj_t.inajsite
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_inaj033    LIKE inaj_t.inaj033
DEFINE   l_inbamoddt  LIKE inba_t.inbamoddt


   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   #檢查傳入的單據編號是否有值，若沒有則顯示錯誤訊息並不允許往下執行，並回傳失敗
   IF cl_null(p_docno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228' 
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(p_seq) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228' 
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_site) THEN
      LET p_site = g_site
   END IF

   #若傳入的單據編號對應的inaj_t中有對應的VMI結算資料時即inaj030='1:VMI位結算'時，
   #針對所有對應的雜收發單據的狀態更新為作廢
   LET l_inbamoddt = cl_get_current()
   LET l_inaj033 = ''
   DECLARE s_inventory_del_inaj_cur CURSOR FOR
      SELECT inaj033 FROM inaj_t
       WHERE inajent  = g_enterprise
         AND inajsite = p_site
         AND inaj001  = p_docno
         AND inaj002  = p_seq
   FOREACH s_inventory_del_inaj_cur INTO l_inaj033
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sel inaj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   
      UPDATE inba_t
         SET inbamodid = g_user,
             inbamoddt = l_inbamoddt,
             inbacnfid = '',
             inbacnfdt = '',
             inbastus  = 'X' 
       WHERE inbaent = g_enterprise
         AND inbadocno = l_inaj033
         
      DELETE FROM inaj_t
       WHERE inajent  = g_enterprise
         AND inajsite = p_site
         AND inaj001  = l_inaj033

      #刪除inaj_t資料的同時刪除對應的inal_t
      DELETE FROM inal_t
       WHERE inalent = g_enterprise
         AND inalsite = p_site
         AND inal001 = l_inaj033

      LET l_inaj033 = ''
   END FOREACH

   #刪除庫存交易明細資料
   DELETE FROM inaj_t
    WHERE inajent  = g_enterprise
      AND inajsite = p_site
      AND inaj001  = p_docno
      AND inaj002  = p_seq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del inaj_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   #刪除inaj_t資料的同時刪除對應的inal_t
   DELETE FROM inal_t
    WHERE inalent = g_enterprise
      AND inalsite = p_site
      AND inal001 = p_docno
      AND inal002 = p_seq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del inal_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF      

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 

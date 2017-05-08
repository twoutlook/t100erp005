#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:22(2016-10-04 17:22:08), PR版次:0022(2017-02-16 17:44:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000082
#+ Filename...: aqcq100
#+ Description: 品質檢驗看板
#+ Creator....: 01534(2014-08-18 09:14:38)
#+ Modifier...: 07025 -SD/PR- 08734
 
{</section>}
 
{<section id="aqcq100.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160307-00017#1    2016/03/22    By lixh  转OQC检验单时，栏位qcba031没有给值
#160412-00007#1    2016/04/21    By lixh  产品特征不用带值
#160315-00022#1    2016/04/22    By lixh  查询不到部分检验的杂发单
#160321-00004#1    2016/04/22    By lixh  两阶段跨组织调拨，拨入方检验时，无法查询到调入单号
#160321-00008#1    2016/04/22    By lixh  无法查询到工单资料
#160314-00022#1    2016/04/22    By lixh  无法查询到未检验的出货通知单
#160526-00028#1    2016/06/13    By lixh  畫面上加上qcba029(RUNCARD)及相關BUG修正
#160601-00010#1    2016/08/09    By 00768 增加管控，如果apmt520在产生qc单时，此处也去产生会发生重复产生现象
#                                         另，取qcam_t时缺少ent条件
#160601-00031#1    2016/08/18    By lixh  输入料件编号查询条件后，双击单身记录带出QC单号以后，料件编号的查询条件会被清空
#160905-00007#13   2016/09/05 by geza sql加上ent条件
#160926-00032#1    2016/10/04 by catmoon 原手動刷新(refresh)為系統保留字，導致無法正常維護。新增項目(manu_refresh)取代手動刷新
#161115-00022#1    2016/11/15    By ywtsai 已作廢QC單，來源單據可重開QC單
#161130-00015#1    2016/12/02    By ywtsai 抽驗數量改抓取qcac007
#161220-00022#1    2016/12/20    By 00768  修正apmt521的单据显示不出来的问题
#161228-00047#1    2016/12/28    By ywtsai 修正產生QC單時，檢驗員與檢驗單位資料須依照品質資料設定的品管員(imae112)與檢驗單位(imae113)帶入
#170120-00008#1    2017/01/20    By dujuan 抽驗數量取值需要和s_aqct300一样的取法
#170203-00021#1    2017/02/08    By fionchen 抽樣計畫為6:自訂義公式,允收數和拒絕數問題
#170207-00003#1    2017/02/09    By 06948  產生QC單時，增加檢驗類型(qcba031)預設值為2:雜項收料單
#170207-00018#3    2017/02/10    By 08734  ROWNUM整批调整
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
 
#單身 type 宣告
PRIVATE TYPE type_g_qcba_d RECORD
       #statepic       LIKE type_t.chr1,
       
       l_type LIKE type_t.chr10, 
   sel LIKE type_t.chr1, 
   qcbasite LIKE qcba_t.qcbasite, 
   qcba021 LIKE qcba_t.qcba021, 
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcbadocdt LIKE qcba_t.qcbadocdt, 
   qcba001 LIKE qcba_t.qcba001, 
   qcba002 LIKE qcba_t.qcba002, 
   qcba029 LIKE qcba_t.qcba029, 
   qcba006 LIKE qcba_t.qcba006, 
   qcba006_desc LIKE type_t.chr500, 
   qcba005 LIKE qcba_t.qcba005, 
   qcba005_desc LIKE type_t.chr500, 
   qcba010 LIKE qcba_t.qcba010, 
   qcba010_desc LIKE type_t.chr500, 
   qcba010_desc_desc LIKE type_t.chr500, 
   qcba012 LIKE qcba_t.qcba012, 
   qcba017 LIKE qcba_t.qcba017, 
   qcba016 LIKE qcba_t.qcba016, 
   qcba016_desc LIKE type_t.chr500, 
   qcba031 LIKE type_t.chr10 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE    g_type           LIKE type_t.chr1
DEFINE    g_freqy          LIKE indd_t.inddseq
DEFINE    g_auto           LIKE type_t.chr1
DEFINE    g_ooba002        LIKE ooba_t.ooba002
DEFINE    g_ooba002_t      LIKE ooba_t.ooba002
DEFINE    g_ooba002_desc   LIKE type_t.chr500
DEFINE    g_head_wc        STRING 
#DEFINE    l_qcba           RECORD LIKE qcba_t.*    #161124-00048#10 mark
#161124-00048#10 add(s)
DEFINE l_qcba RECORD  #品質檢驗單頭檔
       qcbaent LIKE qcba_t.qcbaent, #企业编号
       qcbasite LIKE qcba_t.qcbasite, #营运据点
       qcbadocno LIKE qcba_t.qcbadocno, #单号
       qcbadocdt LIKE qcba_t.qcbadocdt, #单据日期
       qcba000 LIKE qcba_t.qcba000, #检验类型
       qcba001 LIKE qcba_t.qcba001, #来源单号
       qcba002 LIKE qcba_t.qcba002, #来源单项次
       qcba003 LIKE qcba_t.qcba003, #参考单号
       qcba004 LIKE qcba_t.qcba004, #参考单项次
       qcba005 LIKE qcba_t.qcba005, #交易对象编号
       qcba006 LIKE qcba_t.qcba006, #作业编号
       qcba007 LIKE qcba_t.qcba007, #加工序
       qcba008 LIKE qcba_t.qcba008, #来源数量
       qcba009 LIKE qcba_t.qcba009, #单位
       qcba010 LIKE qcba_t.qcba010, #料件编号
       qcba011 LIKE qcba_t.qcba011, #版本
       qcba012 LIKE qcba_t.qcba012, #产品特征
       qcba013 LIKE qcba_t.qcba013, #品管分群
       qcba014 LIKE qcba_t.qcba014, #检验日期
       qcba015 LIKE qcba_t.qcba015, #检验时间
       qcba016 LIKE qcba_t.qcba016, #检验单位
       qcba017 LIKE qcba_t.qcba017, #送验量
       qcba018 LIKE qcba_t.qcba018, #检验程度
       qcba019 LIKE qcba_t.qcba019, #检验级数
       qcba020 LIKE qcba_t.qcba020, #承认文号
       qcba021 LIKE qcba_t.qcba021, #紧急度
       qcba022 LIKE qcba_t.qcba022, #判定结果
       qcba023 LIKE qcba_t.qcba023, #合格量
       qcba024 LIKE qcba_t.qcba024, #检验员
       qcba030 LIKE qcba_t.qcba030, #检验项目识别码
       qcba900 LIKE qcba_t.qcba900, #开单人员
       qcba901 LIKE qcba_t.qcba901, #开单部门
       qcbaownid LIKE qcba_t.qcbaownid, #资料所有者
       qcbaowndp LIKE qcba_t.qcbaowndp, #资料所有部门
       qcbacrtid LIKE qcba_t.qcbacrtid, #资料录入者
       qcbacrtdp LIKE qcba_t.qcbacrtdp, #资料录入部门
       qcbacrtdt LIKE qcba_t.qcbacrtdt, #资料创建日
       qcbamodid LIKE qcba_t.qcbamodid, #资料更改者
       qcbamoddt LIKE qcba_t.qcbamoddt, #最近更改日
       qcbacnfid LIKE qcba_t.qcbacnfid, #资料审核者
       qcbacnfdt LIKE qcba_t.qcbacnfdt, #数据审核日
       qcbapstid LIKE qcba_t.qcbapstid, #资料过账者
       qcbapstdt LIKE qcba_t.qcbapstdt, #资料过账日
       qcbastus LIKE qcba_t.qcbastus, #状态码
       qcba025 LIKE qcba_t.qcba025, #完成检验时间
       qcba026 LIKE qcba_t.qcba026, #检验时间
       qcba027 LIKE qcba_t.qcba027, #不良数
       qcba028 LIKE qcba_t.qcba028, #完成检验日期
       qcba031 LIKE qcba_t.qcba031, #类型分类
       qcba029 LIKE qcba_t.qcba029, #RunCard
       qcba032 LIKE qcba_t.qcba032, #质量异常申请单号
       qcba033 LIKE qcba_t.qcba033  #电子质检单号
END RECORD
#161124-00048#10 add(e)
DEFINE    g_qcaz001        LIKE qcaz_t.qcaz001 
DEFINE    g_auto_flag      LIKE type_t.num5
DEFINE    g_seconds        LIKE type_t.num10
DEFINE    g_time1          DATETIME YEAR TO SECOND
DEFINE    g_time2          STRING
DEFINE    g_time3          STRING
DEFINE    l_hhmmss         STRING
DEFINE    g_msg            STRING
DEFINE    g_total          LIKE type_t.num10
DEFINE    g_imae116        LIKE imae_t.imae116   #170120-00008#1-----add  
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_qcba_d
DEFINE g_master_t                   type_g_qcba_d
DEFINE g_qcba_d          DYNAMIC ARRAY OF type_g_qcba_d
DEFINE g_qcba_d_t        type_g_qcba_d
 
      
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
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aqcq100.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aqc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqcq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aqcq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqcq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcq100 WITH FORM cl_ap_formpath("aqc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aqcq100_init()   
 
      #進入選單 Menu (="N")
      CALL aqcq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aqcq100
      
   END IF 
   
   CLOSE aqcq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aqcq100.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aqcq100_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_qcba021','5074') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('type','5056','1,2,3,4,5')
   LET g_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')  
   CALL cl_set_combo_scc('qcba031','5060')  #160314-00022#1   
   LET g_type = '1'  
   LET g_auto = 'N'     
   LET g_freqy = 1
   LET g_total = g_freqy * 60 
   #end add-point
 
   CALL aqcq100_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.default_search" >}
PRIVATE FUNCTION aqcq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " qcbadocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aqcq100_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_ooef004   LIKE ooef_t.ooef004
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF NOT cl_null(g_head_wc) AND g_head_wc != " 1=1" THEN
      CALL aqcq100_b_fill()
   ELSE
      CALL aqcq100_query()
   END IF
   LET g_errshow = 1  
   LET g_auto_flag = TRUE   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aqcq100_b_fill()
   ELSE
      CALL aqcq100_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_qcba_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aqcq100_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aqcq100_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aqcq100_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT g_type,g_auto,g_freqy FROM type,auto,freqy
               ATTRIBUTE(WITHOUT DEFAULTS)   
               
            BEFORE INPUT
            
            AFTER FIELD freqy
               IF NOT cl_null(g_freqy) THEN
                  Let g_total = g_freqy * 60 
               END IF
                           
#            AFTER FIELD ooba002
#               IF NOT cl_null(g_ooba002) THEN
#                  CALL s_aooi200_get_slip_desc(g_ooba002) RETURNING g_ooba002_desc
#                  IF NOT s_aooi200_chk_slip(g_site,'',g_ooba002,'aqct300') THEN
#                     LET g_ooba002 = g_ooba002_t
#                     CALL s_aooi200_get_slip_desc(g_ooba002) RETURNING g_ooba002_desc
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
             
#            ON CHANGE auto
#               IF g_auto = 'Y' THEN
#                  LET g_seconds = g_freqy*60
#                  LET g_seconds = 5
#
#                  DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
#                  
#                     BEFORE DISPLAY 
#                        LET g_current_page = 1
#                  
#                     BEFORE ROW
#                        LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#                        LET l_ac = g_detail_idx
#                        DISPLAY g_detail_idx TO FORMONLY.h_index
#                        DISPLAY g_qcba_d.getLength() TO FORMONLY.h_count
#                        CALL aqcq100_fetch()
#                        LET g_master_idx = l_ac
#                        
#                     ON ACTION cancel
#                        LET INT_FLAG = 0
#                        EXIT DISPLAY
#                        
#                     
#                    ON idle g_seconds
#                       CALL aqcq100_b_fill()
#                       
#                    DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
#                    
#                       BEFORE DISPLAY 
#                       EXIT DISPLAY
#                    END  DISPLAY                        
#                        
#                  END DISPLAY
  
            ON idle  1 
               IF g_auto_flag = 1 AND g_auto = 'Y'  THEN      
                  IF g_time1 IS NULL THEN
                     LET g_time1 = cl_get_current()
                  END IF
                  #去掉“-”，“：”和空格，得到2个数字做大小比较，不要求得到准确的秒数差
                  LET g_time2 = g_time1
                  LET g_time2 = s_chr_minus(g_time2,'-',0)
                  LET g_time2 = s_chr_minus(g_time2,':',0)
                  LET g_time2 = s_chr_atrim(g_time2)
                  LET l_hhmmss = g_time2.substring(9,10)*3600+g_time2.substring(11,12)*60+g_time2.substring(13,14)
                  LET g_time2 = g_time2.substring(1,8),l_hhmmss
                  LET g_time3 = cl_get_current()
                  LET g_time3 = s_chr_minus(g_time3,'-',0)
                  LET g_time3 = s_chr_minus(g_time3,':',0)
                  LET g_time3 = s_chr_atrim(g_time3)
                  LET l_hhmmss = g_time3.substring(9,10)*3600+g_time3.substring(11,12)*60+g_time3.substring(13,14)
                  LET g_time3 = g_time3.substring(1,8),l_hhmmss
                  #DISPLAY 'g_time2 =',g_time2         预埋调试用，可放开看时间调试
                  #DISPLAY 'g_time3 =',g_time3
                  #display '3-2 =',g_time3 - g_time2    
                  #这个2是容许误差2秒，2秒内的误差都不会触发重计倒计时，这是因为服务器有时候会很卡、停顿，尤其是网络的延迟，这些都会造成误差，如果特别卡，可以适当放大秒数误差，但是会造成必须操作X秒以上才会触发重计的现象
                  IF g_time3 - g_time2 < 2 THEN
                     IF g_seconds = g_total THEN    #自动刷新设为60秒
                        CALL aqcq100_b_fill()
                        LET g_seconds = 0
                     END IF
                     LET g_time1 = cl_get_current()
                     LET g_msg       = cl_getmsg_parm('asf-00127',g_dlang,g_total-g_seconds)
                    #CALL cl_set_comp_att_text('refresh',g_msg)       #160926-00032#1 mark
                     CALL cl_set_comp_att_text('manu_refresh',g_msg)  #160926-00032#1 add
                     LET g_seconds = g_seconds + 1
                  ELSE 
                  #DISPLAY 'cl_get_current()           =',cl_get_current()    预埋调试用，可放开看时间调试
                  #DISPLAY 'g_time1                    =',g_time1
                  #DISPLAY 'cl_get_current() - g_time1 =',cl_get_current() - g_time1         
#                     LET g_seconds = 0
                     LET g_time1 = cl_get_current()            
                  END IF
               END IF
        


            ON ACTION cancel
               LET INT_FLAG = 1
               EXIT DIALOG
         
#            ON ACTION controlp INFIELD ooba002  
#               #開窗i段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#               LET g_qryparam.reqry = FALSE
#
#               LET g_qryparam.default1 = g_ooba002             #給予default值
#
#               #給予arg
#               SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#               LET g_qryparam.arg1 = l_ooef004 #參照表號
#               LET g_qryparam.arg2 = "aqct300" #對應作業編號
#
#               CALL q_ooba002_1()                                #呼叫開窗
#
#               LET g_ooba002 = g_qryparam.return1              #將開窗取得的值回傳到變數
#
#               DISPLAY g_ooba002 TO ooba002              #顯示到畫面上
               
            AFTER INPUT 
               CALL aqcq100_b_fill()
         END INPUT  
         
         CONSTRUCT BY NAME g_head_wc ON qcba010,qcba013,qcba001  #160616-00002#4 
            BEFORE CONSTRUCT
            ON ACTION controlp INFIELD qcba010

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO qcba010  #顯示到畫面上
            
               NEXT FIELD qcba010                     #返回原欄位        

             ON ACTION controlp INFIELD qcba013
             
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = "205"
                CALL q_oocq002()                       #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcba013  #顯示到畫面上
             
                NEXT FIELD qcba013                     #返回原欄位 
                
             #160616-00002#4-s 
            ON ACTION controlp INFIELD qcba001
               
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF g_type = '1' THEN  #IQC
                  CALL q_pmdsdocno_10()   #呼叫開窗
               END IF        
               IF g_type = '2' THEN  #FQC
                  CALL q_sfeadocno_4()   #呼叫開窗   
               END IF      
               IF g_type = '3' THEN  #PQC
                  CALL q_sfcadocno()   #呼叫開窗   
               END IF     
               IF g_type = '4' THEN  #QQC
                  CALL q_xmdkdocno_17()   #呼叫開窗     
               END IF         
               IF g_type = '5' THEN  #QC
                  CALL q_indcdocno_8()   #呼叫開窗     
               END IF                 
               DISPLAY g_qryparam.return1 TO qcba001  #顯示到畫面上
            
               NEXT FIELD qcba001                    #返回原欄位              
             #160616-00002#4-e 
             
             AFTER CONSTRUCT
                CALL aqcq100_b_fill()
          END CONSTRUCT
          
          INPUT g_ooba002 FROM ooba002
                ATTRIBUTE(WITHOUT DEFAULTS) 
            BEFORE INPUT 
            
            AFTER FIELD ooba002
               IF NOT cl_null(g_ooba002) THEN
                  CALL s_aooi200_get_slip_desc(g_ooba002) RETURNING g_ooba002_desc
                  IF NOT s_aooi200_chk_slip(g_site,'',g_ooba002,'aqct300') THEN
                     LET g_ooba002 = g_ooba002_t
                     CALL s_aooi200_get_slip_desc(g_ooba002) RETURNING g_ooba002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ON ACTION controlp INFIELD ooba002  
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.default1 = g_ooba002             #給予default值

               #給予arg
               SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
               LET g_qryparam.arg1 = l_ooef004 #參照表號
               LET g_qryparam.arg2 = "aqct300" #對應作業編號

               CALL q_ooba002_1()                                #呼叫開窗

               LET g_ooba002 = g_qryparam.return1              #將開窗取得的值回傳到變數

               DISPLAY g_ooba002 TO ooba002              #顯示到畫面上               
          END INPUT
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aqcq100_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_freqy) THEN
               LET g_freqy = 1
               LET g_total = g_freqy * 60 
               DISPLAY g_freqy TO g_freqy
            END IF

         AFTER DIALOG
            CALL aqcq100_b_fill()
          

         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_head_wc = " 1=1"
            END IF
            CALL aqcq100_b_fill()
#               IF g_auto = 'Y' THEN
#                  WHILE g_auto_flag 
#                     SLEEP 5
#                     CALL aqcq100_b_fill()
#                  END WHILE    
#               END IF            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION manu_refresh
            LET g_action_choice="manu_refresh"
               
               #add-point:ON ACTION manu_refresh name="menu.manu_refresh"
               CALL aqcq100_b_fill()  #160926-00032#1 add
               #END add-point
               
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aqcq100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_refresh
            LET g_action_choice="auto_refresh"
            IF cl_auth_chk_act("auto_refresh") THEN
               
               #add-point:ON ACTION auto_refresh name="menu.auto_refresh"
   
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aqcq100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aqcq100_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL aqcq100_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_qcba_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL aqcq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aqcq100_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aqcq100_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aqcq100_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_qcba_d.getLength()
               LET g_qcba_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_qcba_d.getLength()
               LET g_qcba_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_qcba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_qcba_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_qcba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_qcba_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
#         ON idle 5 
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail   #雙擊單身
            LET g_action_choice="modify_detail"
            
            IF cl_auth_chk_act("modify_detail") THEN   
               IF cl_null(g_qcba_d[l_ac].qcbadocno) THEN           
                  IF cl_null(g_ooba002) THEN 
                     NEXT FIELD ooba002
                  ELSE        
                     CALL aqcq100_gene_qcba() 
                     CAll aqcq100_b_fill()
                  END IF   
                  #20151026 by xujing add  --begin--
               ELSE
                  LET la_param.prog = "aqct300"
                  LET la_param.param[1] = g_qcba_d[l_ac].qcbadocno
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               #20151026 by xujing add  --end--
               END IF
               #EXIT DIALOG  #160601-00031
            END IF   
            
         ON ACTION about
            CALL cl_about()
        
         ON ACTION help
            CALL cl_help_prog_url()
        
         ON ACTION controlg
            CALL cl_cmdask()            
#            IF g_auto = 'Y' THEN
#               WHILE g_auto_flag 
##                  SLEEP 5
##                  CALL aqcq100_b_fill()
#                  
#                  DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
#                  
#                     BEFORE DISPLAY 
#                        LET g_current_page = 1
#                  
#                     BEFORE ROW
#                        LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#                        LET l_ac = g_detail_idx
#                        DISPLAY g_detail_idx TO FORMONLY.h_index
#                        DISPLAY g_qcba_d.getLength() TO FORMONLY.h_count
#                        CALL aqcq100_fetch()
#                        LET g_master_idx = l_ac
#                        
#                     ON ACTION cancel
#                        EXIT WHILE
#                     
##                     ON idle 5 
##                        CALL aqcq100_b_fill()
#                        
#                  END DISPLAY
#         
#               END WHILE    
#            END IF
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         {
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         }
         
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aqcq100_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_qcba_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON qcbasite
           FROM s_detail1[1].b_qcbasite
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_type>>----
         #----<<sel>>----
         #----<<b_qcbasite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_qcbasite
            #add-point:BEFORE FIELD b_qcbasite name="construct.b.page1.b_qcbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_qcbasite
            
            #add-point:AFTER FIELD b_qcbasite name="construct.a.page1.b_qcbasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_qcbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_qcbasite
            #add-point:ON ACTION controlp INFIELD b_qcbasite name="construct.c.page1.b_qcbasite"
            
            #END add-point
 
 
         #----<<b_qcba021>>----
         #----<<b_qcbadocno>>----
         #----<<b_qcbadocdt>>----
         #----<<b_qcba001>>----
         #----<<b_qcba002>>----
         #----<<b_qcba029>>----
         #----<<b_qcba006>>----
         #----<<b_qcba006_desc>>----
         #----<<b_qcba005>>----
         #----<<b_qcba005_desc>>----
         #----<<b_qcba010>>----
         #----<<b_qcba010_desc>>----
         #----<<b_qcba010_desc_desc>>----
         #----<<b_qcba012>>----
         #----<<b_qcba017>>----
         #----<<b_qcba016>>----
         #----<<b_qcba016_desc>>----
         #----<<qcba031>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL aqcq100_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aqcq100_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql3          STRING
   DEFINE l_sql           STRING   
   DEFINE l_wc            STRING
   DEFINE l_wc_1          STRING
   DEFINE l_wc_2          STRING
   DEFINE l_wc_3          STRING   
   DEFINE l_sql4          STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_head_wc) THEN
      LET g_head_wc = " 1=1"
   END IF  
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','',qcbasite,qcba021,qcbadocno,qcbadocdt,qcba001,qcba002,qcba029, 
       qcba006,'',qcba005,'',qcba010,'','',qcba012,qcba017,qcba016,'',''  ,DENSE_RANK() OVER( ORDER BY qcba_t.qcbadocno) AS RANK FROM qcba_t", 
 
 
 
                     "",
                     " WHERE qcbaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("qcba_t"),
                     " ORDER BY qcba_t.qcbadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','',qcbasite,qcba021,qcbadocno,qcbadocdt,qcba001,qcba002,qcba029,qcba006,'', 
       qcba005,'',qcba010,'','',qcba012,qcba017,qcba016,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

      LET g_sql  = " SELECT UNIQUE '','N',qcbasite,qcba021,qcbadocno,qcbadocdt,qcba001,qcba002,qcba029,qcba006,'',qcba005,'',qcba010,'','',qcba012,qcba017,qcba016,'',qcba031 FROM qcba_t  ",   #160526-00028#1 add qcba029
                   "  WHERE qcbaent = ? ",
                   "    AND qcbasite = '",g_site,"'",
                   "    AND qcba022 = '0' ",
                   "    AND qcba000 = '",g_type,"'",
                   "    AND qcbastus <> 'X'",
                   "    AND ",g_head_wc                   
                 
      IF g_type = '1' THEN   #IQC apmt520/apmt522
         LET l_wc = cl_replace_str(g_head_wc,'qcba010','pmdt006')
         LET l_wc = cl_replace_str(l_wc,'qcba013','imae011')
         LET l_wc = cl_replace_str(l_wc,'qcba001','pmdtdocno')     #160616-00002#4     
         LET l_sql  = " SELECT UNIQUE '1','N',pmdssite,pmdt025,'','',pmdtdocno,pmdtseq,'',pmdt009,'',pmds007,'',pmdt006,'','',pmdt007,pmdt020,pmdt019,'','' FROM pmds_t,pmdt_t,imae_t ",  #160526-00028#1 add  ''
                      "  WHERE pmdsent = pmdtent  ",
                      "    AND pmdsent = imaeent ",
                      "    AND pmdssite = pmdtsite ",
                      "    AND pmdssite = imaesite ",
                      "    AND pmdsdocno = pmdtdocno ",
                      "    AND pmdsent = '",g_enterprise,"'",
                      "    AND pmdssite = '",g_site,"'",
                      "    AND pmdt006 = imae001 ",
                      "    AND pmdsstus = 'Y' ",
                      "    AND pmdt026 = 'Y' ",
                      "    AND pmds000 IN ('1','2','8') ",   #add by lixh 20151113 #161220-00022#1 mod add '8'
                      "    AND ",l_wc
         LET l_sql = l_sql, " ORDER BY pmdtdocno,pmdtseq"   
                                                                              
      END IF 
     

      IF g_type = '2' THEN     #FQC
         LET l_sql = " SELECT UNIQUE '2','N',sfebsite,'','','',sfebdocno,sfebseq,'','','',sfaa009,'',sfeb004,'','',sfeb005,sfeb008,sfeb007,'','' FROM sfeb_t ",   #160526-00028#1 add  ''
                     "   LEFT JOIN sfea_t ON sfeadocno = sfebdocno AND sfeaent = sfebent LEFT JOIN sfaa_t ON sfaadocno = sfeb001 AND sfeaent = '",g_enterprise,"' AND sfeasite = '",g_site,"'",
                     "  WHERE sfebent = '",g_enterprise,"'",
                     "    AND sfebsite = '",g_site,"'",
                     "    AND sfeastus = 'Y' ",
                     "    AND sfeb002 = 'Y' ",
                     "    AND sfea006 IS NULL "
                     
         LET l_sql = l_sql, " ORDER BY sfebdocno,sfebseq"  
                
      END IF
      
      IF g_type = '3' THEN     #PQC
         #LET l_sql = " SELECT UNIQUE '','N',sfcbsite,'','','',sfcbdocno,sfcb002,sfcb003,'',sfaa017,'',sfaa010,'','',sfaa011,0,sfcb020,'' FROM sfcb_t ",
         LET l_sql = " SELECT UNIQUE '3','N',sfcbsite,'','','',sfcbdocno,sfcb002,sfcb001,sfcb003,'',sfaa017,'',sfaa010,'','','',0,sfcb020,'','' FROM sfcb_t ",  #160412-00007#1  #160526-00028#1 add  sfcb001
                     "   LEFT JOIN sfca_t ON sfcadocno = sfcbdocno AND sfcaent = sfcbent  AND sfca001 = sfcb001 ",
                     "   LEFT JOIN sfaa_t ON sfaadocno = sfcbdocno AND sfaaent = '",g_enterprise,"' AND sfaasite = '",g_site,"' AND sfaastus = 'F' ", #160526-00028#1 add sfaastus
                     "  WHERE sfcbent = '",g_enterprise,"'",
                     "    AND sfcbsite = '",g_site,"'",
                     #"    AND sfaastus = 'Y' ",   #160321-00008#1
                     #"    AND sfaastus = 'F' ",    #160321-00008#1    #160526-00028#1 mark
                     "     AND sfcb050  > 0 ",  #160526-00028#1 add
                     "    AND sfcb017 = 'Y' "
         LET l_sql = l_sql, " ORDER BY sfcbdocno,sfcb002"  
        
      END IF      
      
      IF g_type = '4' THEN    #OQC
         LET l_wc = cl_replace_str(g_head_wc,'qcba010','xmdl008')
         LET l_wc = cl_replace_str(l_wc,'qcba013','imae011')  
         LET l_wc = cl_replace_str(l_wc,'qcba001','xmdldocno')  #160616-00002#4           
         LET l_sql = " SELECT UNIQUE '4','N',xmdksite,'','','',xmdldocno,xmdlseq,'',xmdl011,'',xmdk007,'',xmdl008,'','',xmdl009,xmdl018,xmdl017,'','2' FROM xmdk_t,xmdl_t,imae_t ", #160526-00028#1 add  ''
                     "  WHERE xmdkent = xmdlent ",
                     "    AND xmdkdocno = xmdldocno ",
                     "    AND xmdkent = imaeent ",
                     "    AND xmdksite = imaesite ",
                     "    AND xmdkent = '",g_enterprise,"'",
                     "    AND xmdksite = '",g_site,"'",
                     "    AND xmdl008 = imae001 ",   
                     "    AND xmdkstus = 'Y' ",
                     "    AND xmdl023 = 'Y' ",
                     "    AND xmdk000 = '1' ",   #add by lixh 21051113
                     "    AND ",l_wc   

         #160314-00022#1
         LET l_wc_3 = cl_replace_str(g_head_wc,'qcba010','xmdh006')
         LET l_wc_3 = cl_replace_str(l_wc_3,'qcba013','imae011')  
         LET l_wc_3 = cl_replace_str(l_wc_3,'qcba001','xmdhdocno')  #160616-00002#4
         LET l_sql4 = " SELECT UNIQUE '4','N',xmdhsite,'','','',xmdhdocno,xmdhseq,'','','',xmdg005,'',xmdh006,'','',xmdh007,xmdh016,xmdh015,'','1' FROM xmdg_t,xmdh_t,imae_t ", #160526-00028#1 add xmdg005,''
                      "  WHERE xmdgent = xmdhent ",
                      "    AND xmdgdocno = xmdhdocno ",
                      "    AND xmdhent = imaeent ",
                      "    AND xmdh006 = imae001 ",
                      "    AND xmdhent = ",g_enterprise,
                      "    AND xmdhsite = '",g_site,"'",
                      "    AND xmdgstus = 'Y' ",
                      "    AND xmdh022 = 'Y' ",
                      "    AND ",l_wc_3            
         #160314-00022#1
         
         LET l_sql = l_sql, " UNION ",l_sql4
         LET l_sql = l_sql, " ORDER BY xmdldocno,xmdlseq"        
                     
      END IF   
            
      IF g_type = '5' THEN    #5:Inventory QC
         #雜收發
         LET l_wc = cl_replace_str(g_head_wc,'qcba010','inbb001')
         LET l_wc = cl_replace_str(l_wc,'qcba013','imae011') 
         LET l_wc = cl_replace_str(l_wc,'qcba001','inbbdocno') #160616-00002#4
         #LET l_sql = " SELECT UNIQUE '1','N',inbbsite,'','','',inbbdocno,inbbseq,'','','','',inbb001,'','',inbb002,inbb012,inbb010,'' FROM inba_t,inbb_t,imae_t ",
         LET l_sql = " SELECT UNIQUE '51','N',inbbsite,'','','',inbbdocno,inbbseq,'','','','','',inbb001,'','',inbb002,inbb011,inbb010,'','' FROM inba_t,inbb_t,imae_t ",   #160315-00022#1  #160526-00028#1 add / '' '1'=>'51'
                     "  WHERE inbaent = inbbent ",
                     "    AND inbadocno = inbbdocno ",
                     "    AND inbbent = imaeent ",
                     "    AND inbbsite = imaesite ",
                     "    AND inbb001 = imae001 ",                      
                     "    AND inbbent = '",g_enterprise,"'",
                     "    AND inbbsite = '",g_site,"'",
                     "    AND inbastus = 'Y' ",
                     "    AND inbb018 = 'Y' ",
                     "    AND ",l_wc
         LET l_sql = l_sql, " ORDER BY inbbdocno,inbbseq"                
         #調撥
         LET l_wc_1 = cl_replace_str(g_head_wc,'qcba010','indd002')
         LET l_wc_1 = cl_replace_str(l_wc_1,'qcba013','imae011') 
         LET l_wc_1 = cl_replace_str(l_wc_1,'qcba001','indddocno') #160616-00002#4
         LET l_sql2 = " SELECT UNIQUE '52','N',inddsite,'','','',indddocno,inddseq,'','','',indc006,'',indd002,'','',indd004,indd103,indd006,'','' FROM indc_t,indd_t,imae_t ",  #160526-00028#1 add  ''
                      "  WHERE indcent = inddent ",
                      "    AND indcdocno = indddocno ",
                      "    AND indcent = imaeent ",
                      "    AND inddsite = imaesite ",
                      "    AND indd002 = imae001 ",
                      "    AND inddent = '",g_enterprise,"'",
                      "    AND inddsite = '",g_site,"'",                         
#                      "    AND indcstus = 'O' ",   #160321-00004#1
#                      "    AND indc102 = '2' ",    #160321-00004#1
                      "    AND ((indcstus = 'O' AND indc102 = '2') OR (indcstus = 'P' AND indc102 = '3')) ",  #160321-00004#1
                      "    AND indd040 <> 'Y' ",
                      "    AND ",l_wc_1                        
         LET l_sql2 = l_sql2, " ORDER BY indddocno,inddseq" 
         PREPARE aqcq100_pb_02 FROM l_sql2
         DECLARE b_fill_curs_02 CURSOR FOR aqcq100_pb_02
         
         #報廢申請         
         LET l_wc_2 = cl_replace_str(g_head_wc,'qcba010','inbj001')
         LET l_wc_2 = cl_replace_str(l_wc_2,'qcba013','imae011') 
         LET l_wc_2 = cl_replace_str(l_wc_2,'qcba001','inbjdocno') #160616-00002#4
         LET l_sql3 = " SELECT UNIQUE '53','N',inbjsite,'','','',inbjdocno,inbjseq,'','','','','',inbj001,'','',inbj002,inbj009,inbj008,'','' FROM inbi_t,inbj_t,imae_t ",  #160526-00028#1 add  ''
                      "  WHERE inbient = inbjent ",
                      "    AND inbidocno = inbjdocno ",
                      "    AND inbient = imaeent ",
                      "    AND inbjsite = imaesite ",
                      "    AND inbj001 = imae001 ", 
                      "    AND inbient = '",g_enterprise,"'",
                      "    AND inbisite = '",g_site,"'",     
                      "    AND inbistus = 'O' ",
                      "    AND inbi004 = 'Y' ",
                      "    AND ",l_wc
         LET l_sql3 = l_sql3, " ORDER BY inbjdocno,inbjseq" 
         PREPARE aqcq100_pb_03 FROM l_sql3
         DECLARE b_fill_curs_03 CURSOR FOR aqcq100_pb_03         
                  
      END IF
      
      PREPARE aqcq100_pb_01 FROM l_sql
      DECLARE b_fill_curs_01 CURSOR FOR aqcq100_pb_01    
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aqcq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aqcq100_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_qcba_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_qcba_d[l_ac].l_type,g_qcba_d[l_ac].sel,g_qcba_d[l_ac].qcbasite,g_qcba_d[l_ac].qcba021, 
       g_qcba_d[l_ac].qcbadocno,g_qcba_d[l_ac].qcbadocdt,g_qcba_d[l_ac].qcba001,g_qcba_d[l_ac].qcba002, 
       g_qcba_d[l_ac].qcba029,g_qcba_d[l_ac].qcba006,g_qcba_d[l_ac].qcba006_desc,g_qcba_d[l_ac].qcba005, 
       g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].qcba010,g_qcba_d[l_ac].qcba010_desc,g_qcba_d[l_ac].qcba010_desc_desc, 
       g_qcba_d[l_ac].qcba012,g_qcba_d[l_ac].qcba017,g_qcba_d[l_ac].qcba016,g_qcba_d[l_ac].qcba016_desc, 
       g_qcba_d[l_ac].qcba031
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_qcba_d[l_ac].statepic = cl_get_actipic(g_qcba_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aqcq100_detail_show("'1'")      
 
      CALL aqcq100_qcba_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   IF NOT cl_null(g_type) THEN
      FOREACH b_fill_curs_01 INTO g_qcba_d[l_ac].l_type,g_qcba_d[l_ac].sel,g_qcba_d[l_ac].qcbasite,g_qcba_d[l_ac].qcba021,g_qcba_d[l_ac].qcbadocno, 
          g_qcba_d[l_ac].qcbadocdt,g_qcba_d[l_ac].qcba001,g_qcba_d[l_ac].qcba002,g_qcba_d[l_ac].qcba029,g_qcba_d[l_ac].qcba006,    #160526-00028#1 add qcba029
          g_qcba_d[l_ac].qcba006_desc,g_qcba_d[l_ac].qcba005,g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].qcba010, 
          g_qcba_d[l_ac].qcba010_desc,g_qcba_d[l_ac].qcba010_desc_desc,g_qcba_d[l_ac].qcba012,g_qcba_d[l_ac].qcba017, 
          g_qcba_d[l_ac].qcba016,g_qcba_d[l_ac].qcba016_desc,g_qcba_d[l_ac].qcba031    #160314-00022#1 add g_qcba_d[l_ac].qcba031
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
         #160314-00022#1
         IF g_qcba_d[l_ac].l_type = '4' THEN
            IF NOT aqcq100_oqc_chk(g_qcba_d[l_ac].qcba001,g_qcba_d[l_ac].qcba002,g_qcba_d[l_ac].qcba031) THEN
               CONTINUE FOREACH
            END IF
         END IF
         #160314-00022#1
         
         CALL aqcq100_get_qcba017(g_qcba_d[l_ac].l_type) RETURNING g_qcba_d[l_ac].qcba017   
         IF g_qcba_d[l_ac].qcba017 < = 0 THEN   #已全部送檢
            CONTINUE FOREACH
         END IF      
      
         CALL aqcq100_detail_show("'1'")      
      
      
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
   END IF
#   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())  
   
   IF g_type = '5' THEN
      FOREACH b_fill_curs_02 INTO g_qcba_d[l_ac].l_type,g_qcba_d[l_ac].sel,g_qcba_d[l_ac].qcbasite,g_qcba_d[l_ac].qcba021,g_qcba_d[l_ac].qcbadocno, 
          g_qcba_d[l_ac].qcbadocdt,g_qcba_d[l_ac].qcba001,g_qcba_d[l_ac].qcba002,g_qcba_d[l_ac].qcba029,g_qcba_d[l_ac].qcba006,   #160526-00028#1 add qcba029
          g_qcba_d[l_ac].qcba006_desc,g_qcba_d[l_ac].qcba005,g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].qcba010, 
          g_qcba_d[l_ac].qcba010_desc,g_qcba_d[l_ac].qcba010_desc_desc,g_qcba_d[l_ac].qcba012,g_qcba_d[l_ac].qcba017, 
          g_qcba_d[l_ac].qcba016,g_qcba_d[l_ac].qcba016_desc,g_qcba_d[l_ac].qcba031
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
         CALL aqcq100_get_qcba017(g_qcba_d[l_ac].l_type) RETURNING g_qcba_d[l_ac].qcba017   
         IF g_qcba_d[l_ac].qcba017 < = 0 THEN   #已全部送檢
            CONTINUE FOREACH
         END IF      
      
         CALL aqcq100_detail_show("'1'")      
      
      
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

      FOREACH b_fill_curs_03 INTO g_qcba_d[l_ac].l_type,g_qcba_d[l_ac].sel,g_qcba_d[l_ac].qcbasite,g_qcba_d[l_ac].qcba021,g_qcba_d[l_ac].qcbadocno, 
          g_qcba_d[l_ac].qcbadocdt,g_qcba_d[l_ac].qcba001,g_qcba_d[l_ac].qcba002,g_qcba_d[l_ac].qcba029,g_qcba_d[l_ac].qcba006,   #160526-00028#1 add qcba029
          g_qcba_d[l_ac].qcba006_desc,g_qcba_d[l_ac].qcba005,g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].qcba010, 
          g_qcba_d[l_ac].qcba010_desc,g_qcba_d[l_ac].qcba010_desc_desc,g_qcba_d[l_ac].qcba012,g_qcba_d[l_ac].qcba017, 
          g_qcba_d[l_ac].qcba016,g_qcba_d[l_ac].qcba016_desc,g_qcba_d[l_ac].qcba031
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            EXIT FOREACH
         END IF
         
         CALL aqcq100_get_qcba017(g_qcba_d[l_ac].l_type) RETURNING g_qcba_d[l_ac].qcba017   
         IF g_qcba_d[l_ac].qcba017 < = 0 THEN   #已全部送檢
            CONTINUE FOREACH
         END IF      
      
         CALL aqcq100_detail_show("'1'")      
      
      
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
#      CALL g_qcba_d.deleteElement(g_qcba_d.getLength())  
   END IF
   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())  
   LET g_tot_cnt = g_qcba_d.getLength()  #160302-00024#1
   DISPLAY g_tot_cnt TO h_count          #160302-00024#1
   #end add-point
 
   LET g_detail_cnt = g_qcba_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aqcq100_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aqcq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aqcq100_detail_action_trans()
 
   IF g_qcba_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aqcq100_fetch()
   END IF
   
      CALL aqcq100_filter_show('qcbasite','b_qcbasite')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aqcq100_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aqcq100_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba006
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221'  AND oocql002 = ? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_qcba_d[l_ac].qcba006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba006_desc
            DISPLAY g_qcba_d[l_ac].qcba006_desc TO b_qcba006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba005
            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_qcba_d[l_ac].qcba005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba010
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_qcba_d[l_ac].qcba010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba010
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_qcba_d[l_ac].qcba010_desc_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba010_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba016
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_qcba_d[l_ac].qcba016_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba016_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aqcq100_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
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
      CONSTRUCT g_wc_filter ON qcbasite
                          FROM s_detail1[1].b_qcbasite
 
         BEFORE CONSTRUCT
                     DISPLAY aqcq100_filter_parser('qcbasite') TO s_detail1[1].b_qcbasite
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<l_type>>----
         #----<<sel>>----
         #----<<b_qcbasite>>----
         #Ctrlp:construct.c.filter.page1.b_qcbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_qcbasite
            #add-point:ON ACTION controlp INFIELD b_qcbasite name="construct.c.filter.page1.b_qcbasite"
            
            #END add-point
 
 
         #----<<b_qcba021>>----
         #----<<b_qcbadocno>>----
         #----<<b_qcbadocdt>>----
         #----<<b_qcba001>>----
         #----<<b_qcba002>>----
         #----<<b_qcba029>>----
         #----<<b_qcba006>>----
         #----<<b_qcba006_desc>>----
         #----<<b_qcba005>>----
         #----<<b_qcba005_desc>>----
         #----<<b_qcba010>>----
         #----<<b_qcba010_desc>>----
         #----<<b_qcba010_desc_desc>>----
         #----<<b_qcba012>>----
         #----<<b_qcba017>>----
         #----<<b_qcba016>>----
         #----<<b_qcba016_desc>>----
         #----<<qcba031>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL aqcq100_filter_show('qcbasite','b_qcbasite')
 
    
   CALL aqcq100_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aqcq100_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="aqcq100.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aqcq100_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aqcq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.insert" >}
#+ insert
PRIVATE FUNCTION aqcq100_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.modify" >}
#+ modify
PRIVATE FUNCTION aqcq100_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aqcq100_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.delete" >}
#+ delete
PRIVATE FUNCTION aqcq100_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aqcq100_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aqcq100_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_qcba_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_qcba_d.getLength() AND g_qcba_d.getLength() > 0
            LET g_detail_idx = g_qcba_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_qcba_d.getLength() THEN
               LET g_detail_idx = g_qcba_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq100.mask_functions" >}
 &include "erp/aqc/aqcq100_mask.4gl"
 
{</section>}
 
{<section id="aqcq100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 待檢驗數量
# Memo...........:
# Usage..........: CALL aqcq100_get_qcba017(p_type)
# Input parameter: p_type         检验类型
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_get_qcba017(p_type)
DEFINE p_type          LIKE type_t.chr1      #160526-00028#1
DEFINE l_sql           STRING                #160526-00028#1
#DEFINE l_qcba          RECORD LIKE qcba_t.*  #161124-00048#10
#161124-00048#10 add(s)
DEFINE l_qcba RECORD  #品質檢驗單頭檔
       qcbaent LIKE qcba_t.qcbaent, #企业编号
       qcbasite LIKE qcba_t.qcbasite, #营运据点
       qcbadocno LIKE qcba_t.qcbadocno, #单号
       qcbadocdt LIKE qcba_t.qcbadocdt, #单据日期
       qcba000 LIKE qcba_t.qcba000, #检验类型
       qcba001 LIKE qcba_t.qcba001, #来源单号
       qcba002 LIKE qcba_t.qcba002, #来源单项次
       qcba003 LIKE qcba_t.qcba003, #参考单号
       qcba004 LIKE qcba_t.qcba004, #参考单项次
       qcba005 LIKE qcba_t.qcba005, #交易对象编号
       qcba006 LIKE qcba_t.qcba006, #作业编号
       qcba007 LIKE qcba_t.qcba007, #加工序
       qcba008 LIKE qcba_t.qcba008, #来源数量
       qcba009 LIKE qcba_t.qcba009, #单位
       qcba010 LIKE qcba_t.qcba010, #料件编号
       qcba011 LIKE qcba_t.qcba011, #版本
       qcba012 LIKE qcba_t.qcba012, #产品特征
       qcba013 LIKE qcba_t.qcba013, #品管分群
       qcba014 LIKE qcba_t.qcba014, #检验日期
       qcba015 LIKE qcba_t.qcba015, #检验时间
       qcba016 LIKE qcba_t.qcba016, #检验单位
       qcba017 LIKE qcba_t.qcba017, #送验量
       qcba018 LIKE qcba_t.qcba018, #检验程度
       qcba019 LIKE qcba_t.qcba019, #检验级数
       qcba020 LIKE qcba_t.qcba020, #承认文号
       qcba021 LIKE qcba_t.qcba021, #紧急度
       qcba022 LIKE qcba_t.qcba022, #判定结果
       qcba023 LIKE qcba_t.qcba023, #合格量
       qcba024 LIKE qcba_t.qcba024, #检验员
       qcba030 LIKE qcba_t.qcba030, #检验项目识别码
       qcba900 LIKE qcba_t.qcba900, #开单人员
       qcba901 LIKE qcba_t.qcba901, #开单部门
       qcbaownid LIKE qcba_t.qcbaownid, #资料所有者
       qcbaowndp LIKE qcba_t.qcbaowndp, #资料所有部门
       qcbacrtid LIKE qcba_t.qcbacrtid, #资料录入者
       qcbacrtdp LIKE qcba_t.qcbacrtdp, #资料录入部门
       qcbacrtdt LIKE qcba_t.qcbacrtdt, #资料创建日
       qcbamodid LIKE qcba_t.qcbamodid, #资料更改者
       qcbamoddt LIKE qcba_t.qcbamoddt, #最近更改日
       qcbacnfid LIKE qcba_t.qcbacnfid, #资料审核者
       qcbacnfdt LIKE qcba_t.qcbacnfdt, #数据审核日
       qcbapstid LIKE qcba_t.qcbapstid, #资料过账者
       qcbapstdt LIKE qcba_t.qcbapstdt, #资料过账日
       qcbastus LIKE qcba_t.qcbastus, #状态码
       qcba025 LIKE qcba_t.qcba025, #完成检验时间
       qcba026 LIKE qcba_t.qcba026, #检验时间
       qcba027 LIKE qcba_t.qcba027, #不良数
       qcba028 LIKE qcba_t.qcba028, #完成检验日期
       qcba031 LIKE qcba_t.qcba031, #类型分类
       qcba029 LIKE qcba_t.qcba029, #RunCard
       qcba032 LIKE qcba_t.qcba032, #质量异常申请单号
       qcba033 LIKE qcba_t.qcba033 #电子质检单号
END RECORD
#161124-00048#10 add(e)
DEFINE l_rate_qcba017  LIKE qcba_t.qcba017
DEFINE l_qcba017       LIKE qcba_t.qcba017
DEFINE l_rate          LIKE type_t.num20_6
DEFINE l_success       LIKE type_t.num5
DEFINE r_qcba017       LIKE qcba_t.qcba017
DEFINE l_flag          LIKE type_t.chr1

   #160526-00028#1-s mark
#   DECLARE sel_qcba_cur CURSOR FOR 
#    SELECT * FROM qcba_t WHERE qcbaent = g_enterprise
#       AND qcba001 = g_qcba_d[l_ac].qcba001
#       AND qcba002 = g_qcba_d[l_ac].qcba002
#       AND qcbastus <> 'X'
   #160526-00028#1-e mark

   #160526-00028#1-s 
#   LET l_sql = " SELECT * FROM qcba_t WHERE qcbaent = ",g_enterprise,  #161124-00048#10 mark
   #161124-00048#10 add(s)
   LET l_sql = " SELECT qcbaent,qcbasite,qcbadocno,qcbadocdt,qcba000,qcba001,qcba002,qcba003,qcba004,",
               "        qcba005,qcba006,qcba007,qcba008,qcba009,qcba010,qcba011,qcba012,qcba013,qcba014,",
               "        qcba015,qcba016,qcba017,qcba018,qcba019,qcba020,qcba021,qcba022,qcba023,qcba024,",
               "        qcba030,qcba900,qcba901,qcbaownid,qcbaowndp,qcbacrtid,qcbacrtdp,qcbacrtdt,qcbamodid,",
               "        qcbamoddt,qcbacnfid,qcbacnfdt,qcbapstid,qcbapstdt,qcbastus,qcba025,qcba026,qcba027,",
               "        qcba028,qcba031,qcba029,qcba032,qcba033 FROM qcba_t WHERE qcbaent = ",g_enterprise,
   #161124-00048#10 add(e)
               "    AND qcba001 = '",g_qcba_d[l_ac].qcba001,"'",
               "    AND qcba002 = '",g_qcba_d[l_ac].qcba002,"'",
               "    AND qcbastus <> 'X' "
   IF p_type = '3' THEN   #PQC
#      LET l_sql = " SELECT * FROM qcba_t ",  #161124-00048#10 mark
                #161124-00048#10 add(s)
      LET l_sql = " SELECT qcbaent,qcbasite,qcbadocno,qcbadocdt,qcba000,qcba001,qcba002,qcba003,qcba004,",
                  "        qcba005,qcba006,qcba007,qcba008,qcba009,qcba010,qcba011,qcba012,qcba013,qcba014,",
                  "        qcba015,qcba016,qcba017,qcba018,qcba019,qcba020,qcba021,qcba022,qcba023,qcba024,",
                  "        qcba030,qcba900,qcba901,qcbaownid,qcbaowndp,qcbacrtid,qcbacrtdp,qcbacrtdt,qcbamodid,",
                  "        qcbamoddt,qcbacnfid,qcbacnfdt,qcbapstid,qcbapstdt,qcbastus,qcba025,qcba026,qcba027,",
                  "        qcba028,qcba031,qcba029,qcba032,qcba033 FROM qcba_t ",
                #161124-00048#10 add(e)
                  "   LEFT JOIN sfcb_t ON qcbaent = sfcbent AND qcba001 = sfcbdocno AND qcba002 = sfcb002 AND qcba029 = sfcb001 ",
                  "  WHERE qcbaent = ",g_enterprise,
                  "    AND qcba001 = '",g_qcba_d[l_ac].qcba001,"'",
                  "    AND qcba002 = '",g_qcba_d[l_ac].qcba002,"'",
                  "    AND qcbastus <> 'X' "      
   END IF    
            
   PREPARE sel_qcba_pre FROM l_sql
   DECLARE sel_qcba_cur CURSOR FOR sel_qcba_pre
   #160526-00028#1-e
   
   LET l_qcba017 = 0
   LET l_flag = 'N'
   FOREACH sel_qcba_cur INTO l_qcba.* 
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_flag = 'Y'
      LET l_rate_qcba017 = 0
      IF l_qcba.qcba009 != l_qcba.qcba016 THEN
#         CALL s_aimi190_get_convert(l_qcba.qcba010,l_qcba.qcba009,l_qcba.qcba016) RETURNING l_success,l_rate  #xj mod
         CALL s_aooi250_convert_qty(l_qcba.qcba010,l_qcba.qcba009,l_qcba.qcba016,l_qcba.qcba017) RETURNING l_success,l_rate_qcba017 
         IF l_success  THEN
#            LET l_rate_qcba017  = l_qcba.qcba017 * l_rate   #換算後的數量 #xj mod
            LET l_qcba.qcba017 = 0
         END IF
      END IF   
      LET l_qcba017 = l_qcba017  + l_qcba.qcba017 + l_rate_qcba017
   END FOREACH 
   IF l_flag = 'Y' THEN
      LET r_qcba017 = g_qcba_d[l_ac].qcba017 - l_qcba017
   ELSE
      LET r_qcba017 = g_qcba_d[l_ac].qcba017   
   END IF   
   RETURN r_qcba017
END FUNCTION

################################################################################
# Descriptions...: 產生qc資料
# Memo...........:
# Usage..........: CALL aqcq100_gene_qcba()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_gene_qcba()
DEFINE   l_success  LIKE type_t.num5
DEFINE   l_indc000  LIKE indc_t.indc000
DEFINE   l_inba001  LIKE inba_t.inba001
DEFINE   l_qcap003  LIKE qcap_t.qcap003
DEFINE   l_qcap004  LIKE qcap_t.qcap004
DEFINE   l_cnt      LIKE type_t.num5     #160601-00010#1 add

   CALL s_transaction_begin() 
   INITIALIZE l_qcba.* TO NULL
   
   IF g_type = '1' AND NOT cl_null(g_ooba002) THEN   #產生IQC資料
      
      CALL s_aooi200_gen_docno(g_site,g_ooba002,g_today,'aqct300') RETURNING l_success,l_qcba.qcbadocno
      LET l_qcba.qcbadocdt = g_today
      LET l_qcba.qcba900 = g_user
      LET l_qcba.qcba901 = g_dept
      LET l_qcba.qcba000 = '1'
      LET l_qcba.qcbasite = g_site
      LET l_qcba.qcbastus = 'N'
      LET l_qcba.qcba001 = g_qcba_d[l_ac].qcba001
      LET l_qcba.qcba002 = g_qcba_d[l_ac].qcba002
      LET l_qcba.qcba006 = g_qcba_d[l_ac].qcba006
      LET l_qcba.qcba010 = g_qcba_d[l_ac].qcba010
      LET l_qcba.qcba012 = g_qcba_d[l_ac].qcba012
      
      SELECT pmdt001,pmdt002,pmds007,pmdt020,pmdt019,pmdt006,pmdt007 
        INTO l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba005,l_qcba.qcba008,l_qcba.qcba009,l_qcba.qcba010,l_qcba.qcba012
        FROM pmds_t,pmdt_t
       WHERE pmdtent = g_enterprise AND pmdtdocno = l_qcba.qcba001
         AND pmdtseq = l_qcba.qcba002 AND pmdtent = pmdsent AND pmdtdocno = pmdsdocno

      SELECT imaa002 INTO l_qcba.qcba011 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_qcba.qcba010
      
      #SELECT imae111 INTO l_qcba.qcba013       #161228-00047#1 mark
      SELECT imae111,imae112,imae113 INTO l_qcba.qcba013,l_qcba.qcba024,l_qcba.qcba016    #161228-00047#1 add
        FROM imae_t 
       WHERE imaesite = l_qcba.qcbasite AND imaeent = g_enterprise AND imae001 = l_qcba.qcba010 
      #add by lixh 20160112
      LET l_qcap003 = l_qcba.qcba006
      LET l_qcap004 = l_qcba.qcba007      
      IF cl_null(l_qcap003) THEN
         LET l_qcap003 = 'ALL'
      END IF
      
      IF cl_null(l_qcap004) THEN
         LET l_qcap004 = 0
      END IF  
      #add by lixh 20160112   
      SELECT qcap007,qcap009 INTO l_qcba.qcba018,l_qcba.qcba019 FROM qcap_t
          WHERE qcapent = g_enterprise AND qcapsite = l_qcba.qcbasite
            AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
            #AND qcap003 = l_qcba.qcba006 AND qcap004 = l_qcba.qcba007
            #AND qcap005 = l_qcba.qcba012            
            AND qcap003 = l_qcap003 AND qcap004 = l_qcap004    #add by lixh 20160112   
            AND (qcap005 = l_qcba.qcba012 OR qcap005 = 'ALL')  #add by lixh 20160112   
            
      IF cl_null(l_qcba.qcba018) OR cl_null(l_qcba.qcba019) THEN
         SELECT imae115,imae117 INTO l_qcba.qcba018,l_qcba.qcba019 FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite =l_qcba.qcbasite 
            AND imae001 = l_qcba.qcba010
      END IF 
   END IF
   IF (g_type = '3' OR g_type = '2') AND NOT cl_null(g_ooba002) THEN
      CALL s_aooi200_gen_docno(g_site,g_ooba002,g_today,'aqct300') RETURNING l_success,l_qcba.qcbadocno
      LET l_qcba.qcbadocdt = g_today
      LET l_qcba.qcba900 = g_user
      LET l_qcba.qcba901 = g_dept
      IF g_type = '3' THEN
         LET l_qcba.qcba000 = '3'
      END IF
      IF g_type = '2' THEN
         LET l_qcba.qcba000 = '2'
      END IF      
      LET l_qcba.qcbasite = g_site
      LET l_qcba.qcbastus = 'N'
      LET l_qcba.qcba001 = g_qcba_d[l_ac].qcba001
      LET l_qcba.qcba002 = g_qcba_d[l_ac].qcba002
      LET l_qcba.qcba006 = g_qcba_d[l_ac].qcba006   
      LET l_qcba.qcba010 = g_qcba_d[l_ac].qcba010
      LET l_qcba.qcba012 = g_qcba_d[l_ac].qcba012
      
      IF l_qcba.qcba000 = '2' THEN    #FQC
         SELECT UNIQUE sfaadocno,0,sfaa009,sfeb008,sfeb010    
           INTO l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba005,l_qcba.qcba008,l_qcba.qcba009
           FROM sfeb_t 
           LEFT OUTER JOIN sfea_t ON sfeadocno = sfebdocno AND sfeaent = sfebent LEFT OUTER JOIN sfaa_t ON sfaadocno = sfeb001 
            AND sfeaent = g_enterprise AND sfeasite = g_site
          WHERE sfebent = g_enterprise
            AND sfebsite = g_site
            AND sfeastus = 'Y'
            AND sfebdocno = g_qcba_d[l_ac].qcba001
            AND sfebseq = g_qcba_d[l_ac].qcba002          
      END IF  
      IF l_qcba.qcba000 = '3' THEN  #PQC 
         SELECT UNIQUE sfcadocno,0,sfaa009,sfcb003,sfcb004,sfcb027,sfcb052 FROM sfcb_t
           LEFT OUTER JOIN sfca_t ON sfeaent = sfebent AND sfeadocno = sfebdocno LEFT OUTER JOIN sfaa_t ON sfaadocno = sfeadocno
            AND sfeaent = sfaaent  
          WHERE sfcbent = g_enterprise
            AND sfcbsite = g_site
            AND sfcastus = 'Y'
            AND sfcbdocno = g_qcba_d[l_ac].qcba001
            AND sfcbseq = g_qcba_d[l_ac].qcba002   
      END IF
      SELECT imaa002 INTO l_qcba.qcba011 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_qcba.qcba010
      
      #SELECT imae111 INTO l_qcba.qcba013      #161228-00047#1 mark
      SELECT imae111,imae112,imae113 INTO l_qcba.qcba013,l_qcba.qcba024,l_qcba.qcba016   #161228-00047#1 add
        FROM imae_t 
       WHERE imaesite = l_qcba.qcbasite AND imaeent = g_enterprise AND imae001 = l_qcba.qcba010 
      #add by lixh 20160112
      LET l_qcap003 = l_qcba.qcba006
      LET l_qcap004 = l_qcba.qcba007      
      IF cl_null(l_qcap003) THEN
         LET l_qcap003 = 'ALL'
      END IF
      
      IF cl_null(l_qcap004) THEN
         LET l_qcap004 = 0
      END IF  
      #add by lixh 20160112       
      SELECT qcap007,qcap009 INTO l_qcba.qcba018,l_qcba.qcba019 FROM qcap_t
          WHERE qcapent = g_enterprise AND qcapsite = l_qcba.qcbasite
            AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
#            AND qcap003 = l_qcba.qcba006 AND qcap004 = l_qcba.qcba007
#            AND qcap005 = l_qcba.qcba012
            AND qcap003 = l_qcap003 AND qcap004 = l_qcap004    #add by lixh 20160112   
            AND (qcap005 = l_qcba.qcba012 OR qcap005 = 'ALL')  #add by lixh 20160112  
            
      IF cl_null(l_qcba.qcba018) OR cl_null(l_qcba.qcba019) THEN
         SELECT imae115,imae117 INTO l_qcba.qcba018,l_qcba.qcba019 FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite =l_qcba.qcbasite 
            AND imae001 = l_qcba.qcba010
      END IF          
   END IF
   IF g_type = '4' AND NOT cl_null(g_ooba002) THEN
      CALL s_aooi200_gen_docno(g_site,g_ooba002,g_today,'aqct300') RETURNING l_success,l_qcba.qcbadocno
      LET l_qcba.qcbadocdt = g_today
      LET l_qcba.qcba900 = g_user
      LET l_qcba.qcba901 = g_dept
      LET l_qcba.qcba000 = '4'
      LET l_qcba.qcbasite = g_site
      LET l_qcba.qcbastus = 'N'
      LET l_qcba.qcba001 = g_qcba_d[l_ac].qcba001
      LET l_qcba.qcba002 = g_qcba_d[l_ac].qcba002
      LET l_qcba.qcba006 = g_qcba_d[l_ac].qcba006   
      LET l_qcba.qcba010 = g_qcba_d[l_ac].qcba010
      LET l_qcba.qcba012 = g_qcba_d[l_ac].qcba012
      #LET l_qcba.qcba031 = '2'     #160307-00017#1
      LET l_qcba.qcba031 = g_qcba_d[l_ac].qcba031   #160314-00022#1 
      IF l_qcba.qcba031 = '2' THEN   #160314-00022#1
         SELECT UNIQUE xmdl003,xmdl004,xmdk007,xmdl018,xmdl017,xmdl008,xmdl009  
           INTO l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba005,l_qcba.qcba008,l_qcba.qcba009,l_qcba.qcba010,l_qcba.qcba012
           FROM xmdk_t,xmdl_t
          WHERE xmdkent = xmdlent
            AND xmdkdocno = xmdldocno
            AND xmdkent = g_enterprise
            AND xmdksite = g_site
            AND xmdkstus = 'Y'  
            AND xmdldocno = g_qcba_d[l_ac].qcba001
            AND xmdlseq = g_qcba_d[l_ac].qcba002
      END IF    #160314-00022#1
      
      #160314-00022#1
      IF l_qcba.qcba031 = '1' THEN  #出通单
         SELECT UNIQUE xmdh001,xmdh002,xmdg005,xmdh016,xmdh015,xmdh006,xmdh007 
           INTO l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba005,l_qcba.qcba008,l_qcba.qcba009,l_qcba.qcba010,l_qcba.qcba012
           FROM xmdg_t,xmdh_t
          WHERE xmdgent = xmdhent
            AND xmdgdocno = xmdhdocno
            AND xmdgent = g_enterprise
            AND xmdgsite = g_site
            AND xmdgstus = 'Y'  
            AND xmdhdocno = g_qcba_d[l_ac].qcba001
            AND xmdhseq = g_qcba_d[l_ac].qcba002
      END IF
      #160314-00022#1  
      
      SELECT imaa002 INTO l_qcba.qcba011 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_qcba.qcba010
      
      #SELECT imae111 INTO l_qcba.qcba013      #161228-00047#1 mark
      SELECT imae111,imae112,imae113 INTO l_qcba.qcba013,l_qcba.qcba024,l_qcba.qcba016   #161228-00047#1 add
        FROM imae_t 
       WHERE imaesite = l_qcba.qcbasite AND imaeent = g_enterprise AND imae001 = l_qcba.qcba010 
#      IF l_qcba.qcba005 IS NULL THEN LET l_qcba.qcba005 = ' ' END IF
#      IF l_qcba.qcba006 IS NULL THEN LET l_qcba.qcba006 = ' ' END IF
#      IF l_qcba.qcba007 IS NULL THEN LET l_qcba.qcba007 = ' ' END IF  
      #add by lixh 20160112
      LET l_qcap003 = l_qcba.qcba006
      LET l_qcap004 = l_qcba.qcba007      
      IF cl_null(l_qcap003) THEN
         LET l_qcap003 = 'ALL'
      END IF
      
      IF cl_null(l_qcap004) THEN
         LET l_qcap004 = 0
      END IF  
      #add by lixh 20160112 
      SELECT qcap007,qcap009 INTO l_qcba.qcba018,l_qcba.qcba019 FROM qcap_t
          WHERE qcapent = g_enterprise AND qcapsite = l_qcba.qcbasite
            AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
#            AND qcap003 = l_qcba.qcba006 AND qcap004 = l_qcba.qcba007
#            AND qcap005 = l_qcba.qcba012
            AND qcap003 = l_qcap003 AND qcap004 = l_qcap004    #add by lixh 20160112   
            AND (qcap005 = l_qcba.qcba012 OR qcap005 = 'ALL')  #add by lixh 20160112 
            
      IF cl_null(l_qcba.qcba018) OR cl_null(l_qcba.qcba019) THEN
         SELECT imae115,imae117 INTO l_qcba.qcba018,l_qcba.qcba019 FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite =l_qcba.qcbasite 
            AND imae001 = l_qcba.qcba010
      END IF          
   END IF   
   IF g_type = '5' AND NOT cl_null(g_ooba002) THEN
      CALL s_aooi200_gen_docno(g_site,g_ooba002,g_today,'aqct300') RETURNING l_success,l_qcba.qcbadocno  
      LET l_qcba.qcbadocdt = g_today
      LET l_qcba.qcba900 = g_user
      LET l_qcba.qcba901 = g_dept
      LET l_qcba.qcba000 = '5'
      LET l_qcba.qcba031 = '2'     #170207-00003#1 add
      LET l_qcba.qcbasite = g_site
      LET l_qcba.qcbastus = 'N'
      LET l_qcba.qcba001 = g_qcba_d[l_ac].qcba001
      LET l_qcba.qcba002 = g_qcba_d[l_ac].qcba002
      LET l_qcba.qcba006 = g_qcba_d[l_ac].qcba006  
      LET l_qcba.qcba010 = g_qcba_d[l_ac].qcba010
      LET l_qcba.qcba012 = g_qcba_d[l_ac].qcba012
      
      #雜收發    
      IF g_qcba_d[l_ac].l_type = '1' THEN
         SELECT inba001 INTO l_inba001 FROM inba_t  #來源單號
          WHERE inbaent = g_enterprise
            AND inbadocno = l_qcba.qcba001
         IF l_inba001 = '1' THEN
            LET l_qcba.qcba031 = '1' 
         END IF
         IF l_inba001 = '2' THEN
            LET l_qcba.qcba031 = '2' 
         END IF         
            
         SELECT inba006,inbb001,inbb002,inbb010,inbb012
           INTO l_qcba.qcba003,l_qcba.qcba010,l_qcba.qcba012,l_qcba.qcba009,l_qcba.qcba008
           FROM inba_t,inbb_t
          WHERE inbaent = inbbent 
            AND inbadocno = inbbdocno
            AND inbastus = 'Y'
            AND inbaent = g_enterprise
            AND inbasite = g_site
            AND inbbdocno = g_qcba_d[l_ac].qcba001
            AND inbbseq = g_qcba_d[l_ac].qcba002
       END IF  
       
      #調撥
       IF g_qcba_d[l_ac].l_type = '2' THEN
          
          SELECT indc000,indc006,indd101,indd001,indd103,indd006 
            INTO l_indc000,l_qcba.qcba005,l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba008,l_qcba.qcba009
            FROM indc_t,indd_t
           WHERE indcent = inddent
             AND indcdocno = indddocno
             AND inddent = g_enterprise
             AND inddsite = g_site
             AND indddocno = g_qcba_d[l_ac].qcba001
             AND inddseq = g_qcba_d[l_ac].qcba002   
           IF l_indc000 = '1' THEN
              LET l_qcba.qcba031 = '3'  
           END IF  
           IF l_indc000 = '2' THEN
              LET l_qcba.qcba031 = '4'  
           END IF            
       END IF
       
      #申請報廢
       IF g_qcba_d[l_ac].l_type = '3' THEN
          LET l_qcba.qcba031 = '5'  
          SELECT inbj001,inbj009,inbj008 INTO l_qcba.qcba010,l_qcba.qcba008,l_qcba.qcba009 FROM inbj_t
           WHERE inbjent = g_enterprise
             AND inbjsite = g_site
             AND inbjdocno = g_qcba_d[l_ac].qcba001
             AND inbjseq = g_qcba_d[l_ac].qcba002
       
       END IF      
      
      SELECT imaa002 INTO l_qcba.qcba011 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_qcba.qcba010
      
      #SELECT imae111 INTO l_qcba.qcba013       #161228-00047#1 mark
      SELECT imae111,imae112,imae113 INTO l_qcba.qcba013,l_qcba.qcba024,l_qcba.qcba016    #161228-00047#1 add
        FROM imae_t 
       WHERE imaesite = l_qcba.qcbasite AND imaeent = g_enterprise AND imae001 = l_qcba.qcba010 

#      IF l_qcba.qcba005 IS NULL THEN LET l_qcba.qcba005 = ' ' END IF
#      IF l_qcba.qcba006 IS NULL THEN LET l_qcba.qcba006 = ' ' END IF
#      IF l_qcba.qcba007 IS NULL THEN LET l_qcba.qcba007 = ' ' END IF
      #add by lixh 20160112
      LET l_qcap003 = l_qcba.qcba006
      LET l_qcap004 = l_qcba.qcba007      
      IF cl_null(l_qcap003) THEN
         LET l_qcap003 = 'ALL'
      END IF
      
      IF cl_null(l_qcap004) THEN
         LET l_qcap004 = 0
      END IF  
      #add by lixh 20160112       
      SELECT qcap007,qcap009 INTO l_qcba.qcba018,l_qcba.qcba019 FROM qcap_t
          WHERE qcapent = g_enterprise AND qcapsite = l_qcba.qcbasite
            AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
#            AND qcap003 = l_qcba.qcba006 AND qcap004 = l_qcba.qcba007
#            AND qcap005 = l_qcba.qcba012
            AND qcap003 = l_qcap003 AND qcap004 = l_qcap004    #add by lixh 20160112   
            AND (qcap005 = l_qcba.qcba012 OR qcap005 = 'ALL')  #add by lixh 20160112 
            
      IF cl_null(l_qcba.qcba018) OR cl_null(l_qcba.qcba019) THEN
         SELECT imae115,imae117 INTO l_qcba.qcba018,l_qcba.qcba019 FROM imae_t
          WHERE imaeent = g_enterprise AND imaesite =l_qcba.qcbasite 
            AND imae001 = l_qcba.qcba010
      END IF 
      
   END IF
      #LET l_qcba.qcba016 = l_qcba.qcba009            #161228-00047#1 mark
      #161228-00047#1 add---start---
      IF cl_null(l_qcba.qcba016) THEN
         LET l_qcba.qcba016 = l_qcba.qcba009
      END IF
      IF cl_null(l_qcba.qcba024) THEN
         LET l_qcba.qcba024 = g_user
      END IF
      #161228-00047#1 add---end---
      LET l_qcba.qcba017 = g_qcba_d[l_ac].qcba017
      LET l_qcba.qcba014 = g_today
      LET l_qcba.qcba015 = TIME
      LET l_qcba.qcba025 = TIME
      #LET l_qcba.qcba024 = g_user      #161228-00047#1 mark  
      LET l_qcba.qcba022 = '0'
      LET l_qcba.qcba027 = 0      
      LET l_qcba.qcba021 = "C"
      LET l_qcba.qcba023 = "0" 
      LET l_qcba.qcba025 = ''     
      LET l_qcba.qcba028 = '' 
      LET l_qcba.qcba029 = g_qcba_d[l_ac].qcba029 #160526-00028#1
      LET l_qcba.qcbaownid = g_user
      LET l_qcba.qcbaowndp = g_dept
      LET l_qcba.qcbacrtid = g_user
      LET l_qcba.qcbacrtdp = g_dept 
      LET l_qcba.qcbacrtdt = cl_get_current()
      LET l_qcba.qcbamodid = ""
      LET l_qcba.qcbamoddt = ""  
      
      #170207-00018#3    2017/02/10   By 08734 mark(S)
      #SELECT qcam010 INTO l_qcba.qcba030 FROM qcam_t 
      #WHERE qcam001 = g_qcaz001
      #  AND (qcam002 = l_qcba.qcba013 OR qcam002 = 'ALL')
      #  AND (qcam003 = l_qcba.qcba010 OR qcam003 = 'ALL')
      #  AND (qcam004 = l_qcba.qcba012 OR qcam004 = 'ALL')
      #  AND (qcam005 = l_qcba.qcba006 OR qcam005 = 'ALL')
      #  AND (qcam006 = l_qcba.qcba007 OR qcam006 = 0)
      #  AND (qcam008 = l_qcba.qcba005 OR qcam008 = 'ALL')
      #  AND (qcam009 = l_qcba.qcba000 OR qcam009 = '0') 
      #  AND qcamstus = 'Y'
      #  AND qcament  = g_enterprise   #160601-00010#1 add
      #  AND ROWNUM = 1 ORDER BY qcam010 
        #170207-00018#3    2017/02/10   By 08734 mark(E)
        #170207-00018#3    2017/02/10   By 08734 add(S)   
        SELECT A.qcam010 INTO l_qcba.qcba030 FROM(SELECT qcam010  FROM qcam_t 
        WHERE qcam001 = g_qcaz001
          AND (qcam002 = l_qcba.qcba013 OR qcam002 = 'ALL')
          AND (qcam003 = l_qcba.qcba010 OR qcam003 = 'ALL')
          AND (qcam004 = l_qcba.qcba012 OR qcam004 = 'ALL')
          AND (qcam005 = l_qcba.qcba006 OR qcam005 = 'ALL')
          AND (qcam006 = l_qcba.qcba007 OR qcam006 = 0)
          AND (qcam008 = l_qcba.qcba005 OR qcam008 = 'ALL')
          AND (qcam009 = l_qcba.qcba000 OR qcam009 = '0') 
          AND qcamstus = 'Y'
          AND qcament  = g_enterprise   
          ORDER BY qcam010) A 
        WHERE ROWNUM = 1
        #170207-00018#3    2017/02/10   By 08734 add(E)
      
      #160601-00010#1 add--s  #防止多人同时操作产生多张QC单
      SELECT COUNT(*) INTO l_cnt FROM qcba_t
       WHERE qcbaent = g_enterprise
         AND qcbasite = l_qcba.qcbasite
         AND qcba001 = l_qcba.qcba001
         AND qcba002 = l_qcba.qcba002
         AND qcbastus <> 'X'                 #161115-00022#1 add
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_qcba.qcba001
         LET g_errparam.code   = "afa-00038"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160601-00010#1 add--e
      
      INSERT INTO qcba_t (qcbaent,qcbadocno,qcbadocdt,qcba900,qcba000,qcba901,qcbasite,qcbastus, 
          qcba001,qcba002,qcba003,qcba004,qcba005,qcba006,qcba007,qcba008,qcba009,qcba010,qcba011, 
          qcba012,qcba013,qcba018,qcba019,qcba020,qcba021,qcba030,qcba014,qcba015,qcba016,qcba017, 
          qcba024,qcba027,qcba028,qcba022,qcba025,qcba023,qcba026,qcba031,qcbaownid,qcbaowndp,qcbacrtid, 
          qcbacrtdp,qcbacrtdt,qcbacnfid,qcbacnfdt)
      VALUES (g_enterprise,l_qcba.qcbadocno,l_qcba.qcbadocdt,l_qcba.qcba900,l_qcba.qcba000, 
          l_qcba.qcba901,l_qcba.qcbasite,l_qcba.qcbastus,l_qcba.qcba001,l_qcba.qcba002, 
          l_qcba.qcba003,l_qcba.qcba004,l_qcba.qcba005,l_qcba.qcba006,l_qcba.qcba007, 
          l_qcba.qcba008,l_qcba.qcba009,l_qcba.qcba010,l_qcba.qcba011,l_qcba.qcba012, 
          l_qcba.qcba013,l_qcba.qcba018,l_qcba.qcba019,l_qcba.qcba020,l_qcba.qcba021, 
          l_qcba.qcba030,l_qcba.qcba014,l_qcba.qcba015,l_qcba.qcba016,l_qcba.qcba017, 
          l_qcba.qcba024,l_qcba.qcba027,l_qcba.qcba028,l_qcba.qcba022,l_qcba.qcba025, 
          l_qcba.qcba023,l_qcba.qcba026,l_qcba.qcba031,l_qcba.qcbaownid,l_qcba.qcbaowndp,l_qcba.qcbacrtid, 
          l_qcba.qcbacrtdp,l_qcba.qcbacrtdt,l_qcba.qcbacnfid,l_qcba.qcbacnfdt) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "l_qcba" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN 
      ELSE
         #产生制造批序号资料
         #160415-00012#1
         IF s_lot_batch_number_1n3(l_qcba.qcba010,g_site) THEN
            IF NOT s_aqct300_ins_inao(l_qcba.qcbadocno,1,'N') THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            IF NOT s_aqct300_upd_inao024(l_qcba.qcbadocno,1) THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
         #160415-00012#1
         #170120-00008#1---add---str
         #檢驗水準
         LET g_imae116 = ''
         SELECT qcap008 INTO g_imae116 FROM qcap_t
          WHERE qcapent  = g_enterprise 
            AND qcap001 = l_qcba.qcba010       #161024-00007#1 add
            AND qcap002 = l_qcba.qcba005       #161024-00007#1 add
            AND qcap003  = 'ALL' 
            AND qcap004  = 0
            AND qcap005  = 'ALL'
         IF cl_null(g_imae116) THEN
            SELECT imae116 INTO g_imae116 FROM imae_t
             WHERE imaeent  = g_enterprise 
               AND imae001  = l_qcba.qcba010
         END IF   
         #170120-00008#1---add---end
         IF NOT aqcq100_gene_qcbd() THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF         
      END IF    
      CALL s_transaction_end('Y','0')
#   END IF 
END FUNCTION

################################################################################
# Descriptions...: 產生qcbd_t的資料
# Memo...........:
# Usage..........: CALL aqcq100_gene_qcbd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_gene_qcbd()
DEFINE l_sql     STRING
DEFINE l_n       LIKE type_t.num5
#DEFINE l_qcan    RECORD LIKE qcan_t.*  #161124-00048#10 mark
#161124-00048#10 add(s)
DEFINE l_qcan RECORD  #品質檢驗項目單身檔
       qcanent LIKE qcan_t.qcanent, #企业编号
       qcan001 LIKE qcan_t.qcan001, #参照表号
       qcan002 LIKE qcan_t.qcan002, #品管分群
       qcan003 LIKE qcan_t.qcan003, #料件编号
       qcan004 LIKE qcan_t.qcan004, #产品特征
       qcan005 LIKE qcan_t.qcan005, #作业编号
       qcan006 LIKE qcan_t.qcan006, #加工序
       qcan007 LIKE qcan_t.qcan007, #交易对象编号
       qcan008 LIKE qcan_t.qcan008, #检验类型
       qcan009 LIKE qcan_t.qcan009, #项次
       qcan010 LIKE qcan_t.qcan010, #检验项目
       qcan011 LIKE qcan_t.qcan011, #检验位置
       qcan012 LIKE qcan_t.qcan012, #缺点等级
       qcan013 LIKE qcan_t.qcan013, #抽样计划
       qcan014 LIKE qcan_t.qcan014, #AQL
       qcan015 LIKE qcan_t.qcan015, #测量值控制方式
       qcan016 LIKE qcan_t.qcan016, #检验方式
       qcan017 LIKE qcan_t.qcan017, #资源类型
       qcan018 LIKE qcan_t.qcan018, #指定仪器
       qcan019 LIKE qcan_t.qcan019, #规范上限
       qcan020 LIKE qcan_t.qcan020, #检验上限
       qcan021 LIKE qcan_t.qcan021, #检验标准值
       qcan022 LIKE qcan_t.qcan022, #检验下限
       qcan023 LIKE qcan_t.qcan023, #规范下限
       qcan024 LIKE qcan_t.qcan024, #计量单位
       qcan025 LIKE qcan_t.qcan025, #检验规格说明
       qcan026 LIKE qcan_t.qcan026  #备注
END RECORD
#161124-00048#10 add(e)
DEFINE l_qcbd    RECORD 
                 qcbdent    LIKE qcbd_t.qcbdent,
                 qcbdsite   LIKE qcbd_t.qcbdsite,
                 qcbddocno  LIKE qcbd_t.qcbddocno,
                 qcbdseq    LIKE qcbd_t.qcbdseq,
                 qcbd001    LIKE qcbd_t.qcbd001, 
                 qcbd002    LIKE qcbd_t.qcbd002, 
                 qcbd003    LIKE qcbd_t.qcbd003, 
                 qcbd004    LIKE qcbd_t.qcbd004, 
                 qcbd005    LIKE qcbd_t.qcbd005, 
                 qcbd006    LIKE qcbd_t.qcbd006, 
                 qcbd007    LIKE qcbd_t.qcbd007, 
                 qcbd008    LIKE qcbd_t.qcbd008, 
                 qcbd009    LIKE qcbd_t.qcbd009, 
                 qcbd010    LIKE qcbd_t.qcbd010, 
                 qcbd011    LIKE qcbd_t.qcbd011,
                 qcbd012    LIKE qcbd_t.qcbd012,
                 qcbd013    LIKE qcbd_t.qcbd013,
                 qcbd014    LIKE qcbd_t.qcbd014,
                 qcbd015    LIKE qcbd_t.qcbd015,
                 qcbd016    LIKE qcbd_t.qcbd016,
                 qcbd017    LIKE qcbd_t.qcbd017,
                 qcbd018    LIKE qcbd_t.qcbd018,
                 qcbd019    LIKE qcbd_t.qcbd019,
                 qcbd020    LIKE qcbd_t.qcbd020,
                 qcbd021    LIKE qcbd_t.qcbd021
             END RECORD
        
#   LET l_sql = " SELECT * FROM qcan_t,qcam_t WHERE  qcan001 = '",g_qcaz001,"'",  #161124-00048#10 mark
   #161124-00048#10 add(s)
   LET l_sql = " SELECT qcanent,qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,",
               "        qcan007,qcan008,qcan009,qcan010,qcan011,qcan012,qcan013,",
               "        qcan014,qcan015,qcan016,qcan017,qcan018,qcan019,qcan020,",
               "        qcan021,qcan022,qcan023,qcan024,qcan025,qcan026 ",
               "   FROM qcan_t,qcam_t WHERE  qcan001 = '",g_qcaz001,"'",
   #161124-00048#10 add(e)
               "    AND qcanent = qcament  AND qcam001 = qcan001 ",
               "    AND qcan002 = qcam002  AND qcan003 = qcam003 ",
               "    AND qcan004 = qcam004  AND qcan005 = qcam005 ",
               "    AND qcan006 = qcam006  AND qcan007 = qcam008 ",
               "    AND qcan008 = qcam009 ",
               "    AND qcam010 = '",l_qcba.qcba030,"'",
               "    AND qcament = ",g_enterprise,  #160601-00010#1 add
               "   ORDER BY qcan009" 
   PREPARE qcbd_ins_pre1 FROM l_sql
   DECLARE qcbd_ins_cur1 CURSOR FOR qcbd_ins_pre1
   FOREACH qcbd_ins_cur1 INTO l_qcan.*
      IF SQLCA.SQLCODE THEN
         RETURN FALSE
      END IF
  
      LET l_qcbd.qcbdent = g_enterprise           LET l_qcbd.qcbdsite = l_qcba.qcbasite
      LET l_qcbd.qcbddocno = l_qcba.qcbadocno     LET l_qcbd.qcbdseq = l_qcan.qcan009
      LET l_qcbd.qcbd001 = l_qcan.qcan010         LET l_qcbd.qcbd002 = l_qcan.qcan011
      LET l_qcbd.qcbd003 = l_qcan.qcan012         LET l_qcbd.qcbd004 = l_qcan.qcan014
      CALL aqcq100_qcbd005_qcbd006_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING l_qcbd.qcbd005,l_qcbd.qcbd006      
      CALL aqcq100_qcbd007_qcbd008_result(l_qcan.qcan013)  RETURNING l_qcbd.qcbd007,l_qcbd.qcbd008
      CALL aqcq100_qcbd009_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING l_qcbd.qcbd009
      LET l_qcbd.qcbd010 = 0                      LET l_qcbd.qcbd011 = '1'
      LET l_qcbd.qcbd012 = l_qcan.qcan019         LET l_qcbd.qcbd013 = l_qcan.qcan020
      LET l_qcbd.qcbd014 = l_qcan.qcan021         LET l_qcbd.qcbd015 = l_qcan.qcan022
      LET l_qcbd.qcbd016 = l_qcan.qcan023         LET l_qcbd.qcbd017 = l_qcan.qcan024
      LET l_qcbd.qcbd018 = l_qcan.qcan025         LET l_qcbd.qcbd019 = l_qcan.qcan026
      LET l_qcbd.qcbd020 = l_qcan.qcan013         LET l_qcbd.qcbd021 = 0
      INSERT INTO qcbd_t(qcbdent,qcbdsite,qcbddocno,qcbdseq,qcbd001,qcbd002,qcbd003,qcbd004,
                         qcbd005,qcbd006,qcbd007,qcbd008,qcbd009,qcbd010,qcbd011,qcbd012,
                         qcbd013,qcbd014,qcbd015,qcbd016,qcbd017,qcbd018,qcbd019,qcbd020,qcbd021) 
                  VALUES(l_qcbd.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         RETURN FALSE
      END IF
   END FOREACH
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aqcq100_qcbd005_qcbd006_result(p_qcan013,p_qcan014)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_qcbd005_qcbd006_result(p_qcan013,p_qcan014)
DEFINE p_qcan013   LIKE qcan_t.qcan013
DEFINE p_qcan014   LIKE qcan_t.qcan014
DEFINE r_qcbd005   LIKE qcbd_t.qcbd005
DEFINE r_qcbd006   LIKE qcbd_t.qcbd006
DEFINE l_n         LIKE type_t.num5   
DEFINE l_qcaa004   LIKE qcaa_t.qcaa004
DEFINE l_imae116   LIKE imae_t.imae116
DEFINE l_qcaz001   LIKE qcaz_t.qcaz001  #add by lixh 20160111 151221-00008/1

   LET l_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')  #add by lixh 20160111 151221-00008/1
   SELECT qcap008 INTO l_imae116 FROM qcap_t
    WHERE qcapent = g_enterprise AND qcapsite = l_qcba.qcbasite
      AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
      AND qcap003 = 'ALL' AND qcap004 = 0
      AND qcap005 = 'ALL'         
         
   IF cl_null(l_imae116) THEN
      SELECT imae116 INTO l_imae116 FROM imae_t 
       WHERE imaesite = l_qcba.qcbasite AND imaeent = g_enterprise AND imae001 = l_qcba.qcba010 
   END IF 

   IF p_qcan013 = '1' THEN
      IF l_qcba.qcba017 = 1 THEN
         LET r_qcbd005 = 0 LET r_qcbd006 = 1
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imae_t WHERE imaeent = g_enterprise 
         AND imaesite = g_site AND imae001 = l_qcba.qcba010
      IF l_n = 0 THEN
         LET r_qcbd005 = 0 LET r_qcbd006 = 0
      END IF  
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM qcap_t WHERE qcapent = g_enterprise
         AND qcap001 = l_qcba.qcba010 AND qcap002 = l_qcba.qcba005
      IF l_n = 0 THEN
         LET r_qcbd005 = 0 LET r_qcbd006 = 0
      END IF
      
      IF l_imae116 = '1' THEN
         SELECT qcaa004 INTO l_qcaa004 FROM qcaa_t 
          WHERE qcaa003 = l_qcba.qcba019 AND (l_qcba.qcba017 BETWEEN qcaa001 AND qcaa002)
            AND qcaaent = g_enterprise #add by geza 20160905 #160905-00007#13
         IF l_n = 0 THEN
            LET r_qcbd005 = 0 LET r_qcbd006 = 0
         END IF
      END IF
      
      IF l_imae116 = '2' THEN
         SELECT qcab004 INTO l_qcaa004 FROM qcab_t 
          WHERE qcab003 = l_qcba.qcba019 AND (l_qcba.qcba017 BETWEEN qcab001 AND qcab002)
            AND qcabent = g_enterprise #add by geza 20160905 #160905-00007#13
         IF l_n = 0 THEN
            LET r_qcbd005 = 0 LET r_qcbd006 = 0
         END IF
      END IF
      
      IF l_imae116 MATCHES '[12]' AND NOT cl_null(l_qcaa004) THEN
         SELECT qcac005,qcac006 INTO r_qcbd005,r_qcbd006 FROM qcac_t
          WHERE qcacent = g_enterprise AND qcac001 = l_qcba.qcba018
            AND qcac002 = p_qcan014 AND qcac003 = l_qcaa004
      END IF
   END IF
   
  # IF p_qcan013 MATCHES '[23567]' THEN   #mark by lixh 20160111 151221-00008/1
   IF p_qcan013 MATCHES '[2357]' THEN     #add by lixh 20160111 151221-00008/1
      LET r_qcbd005 = 0   LET r_qcbd006 = 1
   END IF
   
   #add by lixh 20160111 151221-00008/1
   IF p_qcan013 = '6' THEN   #自定义公式
       SELECT qcah007 INTO r_qcbd005
        FROM qcah_t
       WHERE qcahent = g_enterprise
         AND (l_qcba.qcba017 BETWEEN qcah004 AND qcah005)
         AND qcah001 = l_qcaz001
         AND qcah002 = p_qcan014
         AND qcah003 = l_qcba.qcba018
       IF cl_null(r_qcbd005) THEN LET r_qcbd005 = 0 END IF
      #LET r_qcbd006 = 1                      #170203-00021#1 mark
       LET r_qcbd006 = r_qcbd005 + 1          #170203-00021#1 add
   END IF   
   #add by lixh 20160111 151221-00008/1
   
   IF p_qcan013 = '4' THEN
      LET r_qcbd005 = ''  LET r_qcbd006 = ''
   END IF
   IF r_qcbd005 > l_qcba.qcba017 THEN
      LET r_qcbd005 = l_qcba.qcba017 - 1
   END IF
   
   IF r_qcbd006 > l_qcba.qcba017 THEN
      LET r_qcbd006 = l_qcba.qcba017
   END IF
   RETURN r_qcbd005,r_qcbd006
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aqcq100_qcbd007_qcbd008_result(p_qcan013)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_qcbd007_qcbd008_result(p_qcan013)
DEFINE p_qcan013   LIKE qcan_t.qcan013
DEFINE r_qcbd007   LIKE qcbd_t.qcbd007
DEFINE r_qcbd008   LIKE qcbd_t.qcbd008
DEFINE l_qcad002   LIKE qcad_t.qcad002

   IF p_qcan013 MATCHES '[123567]' THEN
      LET r_qcbd007 = ''  LET r_qcbd008 = ''
   END IF
   
   IF p_qcan013 = '4' THEN
      SELECT qcad002 INTO l_qcad002 FROM qcad_t WHERE qcadent = g_enterprise 
         AND qcad001 = l_qcba.qcba019 AND (l_qcba.qcba017 BETWEEN qcad003 AND qcad004) 
         
      SELECT qcae005,qcae006 INTO r_qcbd007,r_qcbd008 FROM qcae_t
       WHERE qcaeent = g_enterprise AND qcae001 = '4' AND qcae002 = l_qcba.qcba019
         AND qcae003 = l_qcad002
   END IF
   RETURN r_qcbd007,r_qcbd008
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aqcq100_qcbd009_result(p_qcan013,p_qcan014)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_qcbd009_result(p_qcan013,p_qcan014)
DEFINE p_qcan013   LIKE qcan_t.qcan013
DEFINE l_qcac004   LIKE qcac_t.qcac004
DEFINE p_qcan014   LIKE qcan_t.qcan014
DEFINE p_qcan012   LIKE qcan_t.qcan012
DEFINE l_qcaa005   LIKE qcaa_t.qcaa005
DEFINE l_qcaa006   LIKE qcaa_t.qcaa006
DEFINE l_qcaa007   LIKE qcaa_t.qcaa007
DEFINE l_qcab005   LIKE qcab_t.qcab005
DEFINE l_qcab006   LIKE qcab_t.qcab006
DEFINE l_qcab007   LIKE qcab_t.qcab007
DEFINE r_qcbd009   LIKE qcbd_t.qcbd009
DEFINE l_qcad001   LIKE qcad_t.qcad001
DEFINE l_qcad002   LIKE qcad_t.qcad002
DEFINE l_qcaz001   LIKE qcaz_t.qcaz001    #add by xujing 20151026
DEFINE l_qcac007   LIKE qcac_t.qcac007    #161130-00015#1 add
DEFINE l_qcac003   LIKE qcac_t.qcac003    #170120-00008#1----add

#170120-00008#1----add-----str----
  IF p_qcan013 = '1' THEN
     CASE g_imae116
        WHEN '1'
            SELECT DISTINCT qcaa004 INTO l_qcac003 FROM qcaa_t
             WHERE qcaaent = g_enterprise
               AND qcaa003 = p_qcba.qcba019
               AND (p_qcba.qcba017 BETWEEN qcaa001 AND qcaa002)
        WHEN '2'
             SELECT DISTINCT qcab004 INTO l_qcac003 FROM qcab_t
              WHERE qcabent = g_enterprise
                AND qcab003 = p_qcba.qcba019
                AND (p_qcba.qcba017 BETWEEN qcab001 AND qcab002)       
     END CASE
     IF g_imae116 MATCHES '[12]' THEN
        SELECT qcac007 INTO r_qcbd009 FROM qcac_t
          WHERE qcacent = g_enterprise
            AND qcac001 = p_qcba.qcba018
            AND qcac002 = p_qcan014
            AND qcac003 = l_qcac003
     END IF
   END IF
   
   IF p_qcan013 = '2' THEN            #C=0 时抓 aqci007
      SELECT qcag005 INTO r_qcbd009
        FROM qcag_t
       WHERE qcagent = g_enterprise
         AND (p_qcba.qcba017 BETWEEN qcag001 AND qcag002)
         AND qcag003 = p_qcan014
         AND qcag004 = p_qcba.qcba019
      IF cl_null(r_qcbd009) THEN LET r_qcbd009 = 0 END IF
   END IF
#170120-00008#1----add-----end----   
#170120-00008#1----mark-----str----
#   IF p_qcan013 MATCHES '[12]' THEN
#      #SELECT qcac004 INTO l_qcac004 FROM qcaa_t,qcac_t                    #161130-00015#1 mark
#      SELECT qcac004,qcac007 INTO l_qcac004,l_qcac007 FROM qcaa_t,qcac_t   #161130-00015#1 add
#       WHERE (l_qcba.qcba017 BETWEEN qcaa001 AND qcaa002)
#         AND qcac002 = p_qcan014
#         AND qcaa004 = qcac003
#         AND qcaa003 = l_qcba.qcba019	
#         AND qcac001 = l_qcba.qcba018
#         AND qcaaent = g_enterprise
#         AND qcaaent = qcacent
#      IF p_qcan013 = '1' THEN
#         #161130-00015#1 mark---start---
#         #SELECT DISTINCT qcaa005,qcaa006,qcaa007 INTO l_qcaa005,l_qcaa006,l_qcaa007
#         #  FROM qcaa_t WHERE qcaaent = g_enterprise
#         #   AND qcaa003 = l_qcba.qcba019
#         #   AND qcaa004 = l_qcac004
#         #   AND rownum = 1 ORDER BY qcaa004,qcaa003
#         #
#         #CASE l_qcba.qcba018
#         #   WHEN 'N' LET r_qcbd009 = l_qcaa005
#         #   WHEN 'T' LET r_qcbd009 = l_qcaa006
#         #   WHEN 'R' LET r_qcbd009 = l_qcaa007
#         #END CASE
#         #161130-00015#1 mark---end---
#         #161130-00015#1 add---start---
#         IF cl_null(l_qcac007) THEN
#            LET l_qcac007 = 0
#         END IF
#         LET r_qcbd009 = l_qcac007
#         #161130-00015#1 add---end---
#      END IF
#      IF p_qcan013 = '2' THEN
#         SELECT DISTINCT qcab005,qcab006,qcab007 INTO l_qcab005,l_qcab006,l_qcab007
#           FROM qcab_t WHERE qcabent = g_enterprise
#            AND qcab003 = l_qcba.qcba019
#            AND qcab004 = l_qcac004 
#            AND rownum = 1 ORDER BY qcab004,qcab003
#         CASE l_qcba.qcba018
#            WHEN 'N' LET r_qcbd009 = l_qcab005
#            WHEN 'T' LET r_qcbd009 = l_qcab006
#            WHEN 'R' LET r_qcbd009 = l_qcab007
#         END CASE
#      END IF
#   END IF
#170120-00008#1----mark-----end----  

   IF p_qcan013 MATCHES '[34]' THEN
      LET l_qcad001 = l_qcba.qcba019
      CASE l_qcba.qcba018 
         WHEN 'T' 
            IF (l_qcba.qcba019 + 1) = 8 THEN
               LET l_qcad001 = 'T'
            END IF
         WHEN 'R' 
            IF (l_qcba.qcba019 - 1) = 0 THEN
               LET l_qcad001 = 'R'
            END IF
      END CASE
      
      SELECT qcad002 INTO l_qcad002 FROM qcad_t
       WHERE qcadent = g_enterprise
         AND (l_qcba.qcba017 BETWEEN qcad003 AND qcad004)
         AND qcad001 = l_qcad001
         
      SELECT qcae004 INTO r_qcbd009 FROM qcae_t
       WHERE qcaeent = g_enterprise
         AND qcae001 = p_qcan013
         AND qcae002 = l_qcba.qcba019
         AND qcae003 = l_qcad002
   END IF
   
   #20151026 by xujing  add  --begin--
   LET l_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')
   IF p_qcan013 = '5' THEN #ç¾åæ¯
      LET r_qcbd009 = l_qcba.qcba017 * (p_qcan014 * 0.01)
   END IF

   IF p_qcan013 = '6' THEN  #èªå®ç¾©å¬å¼
      SELECT qcah006 INTO r_qcbd009
        FROM qcah_t
       WHERE qcahent = g_enterprise
         AND (l_qcba.qcba017 BETWEEN qcah004 AND qcah005)
         AND qcah001 = l_qcaz001
         AND qcah002 = p_qcan014
         AND qcah003 = l_qcba.qcba018
   END IF

   IF p_qcan013 = '7' THEN
      LET r_qcbd009 = l_qcba.qcba017
   END IF
  #20151026 by xujing  add  --end--
   
   IF r_qcbd009 > l_qcba.qcba017 THEN
      LET r_qcbd009 = l_qcba.qcba017
   END IF
   RETURN r_qcbd009
END FUNCTION

################################################################################
# Descriptions...: 出通单检验OR出货单检验
# Memo...........:
# Usage..........: CALL aqcq100_oqc_chk(p_qcba001,p_qcba002,p_qcba031)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcq100_oqc_chk(p_qcba001,p_qcba002,p_qcba031)
DEFINE p_qcba001  LIKE qcba_t.qcba001
DEFINE p_qcba002  LIKE qcba_t.qcba002
DEFINE p_qcba031  LIKE qcba_t.qcba031
DEFINE l_slip  STRING
DEFINE l_docno  LIKE xmdh_t.xmdh001
DEFINE l_para   LIKE type_t.chr1
DEFINE l_para2  LIKE type_t.chr1
DEFINE l_xmdk000 LIKE xmdk_t.xmdk000 #檢查是否為無訂單出貨   
DEFINE l_success LIKE type_t.num5

   IF p_qcba031 = '1' THEN
      SELECT xmdh001 INTO l_docno FROM xmdh_t
       WHERE xmdhent = g_enterprise AND xmdhdocno = p_qcba001
         AND xmdhseq = p_qcba002
      CALL s_aooi200_get_slip(l_docno) RETURNING l_success,l_slip
      IF l_success THEN
         LET l_para = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094')
      ELSE
         RETURN FALSE
      END IF
      IF l_para = '2' THEN
         RETURN FALSE
      END IF
   ELSE
     
      SELECT xmdk000 INTO l_xmdk000 FROM xmdk_t
      WHERE xmdkent = g_enterprise      
         AND xmdkdocno = p_qcba001     
      IF cl_null(l_xmdk000) THEN LET l_xmdk000 = ' ' END IF      

      IF l_xmdk000 <> '2' THEN    #非無訂單出貨  
         SELECT xmdl003 INTO l_docno FROM xmdl_t
          WHERE xmdlent = g_enterprise AND xmdldocno = p_qcba001
            AND xmdlseq = p_qcba002
           CALL s_aooi200_get_slip(l_docno) RETURNING l_success,l_slip
         IF l_success THEN
            LET l_para = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0077')
         ELSE
            RETURN FALSE
         END IF   
         IF l_para = 'Y' THEN
            LET l_para2 = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094')
            IF l_para2 = '1' THEN
               RETURN FALSE
            END IF
         END IF
      END IF   
   END IF
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 

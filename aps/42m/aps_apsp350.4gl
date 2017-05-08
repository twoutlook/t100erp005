#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-09-07 10:55:46), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000077
#+ Filename...: apsp350
#+ Description: APS轉採購預測作業
#+ Creator....: 01588(2014-07-18 16:12:27)
#+ Modifier...: 07024 -SD/PR- 00000
 
{</section>}
 
{<section id="apsp350.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#51 2016/04/27 By 07673     將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#15 2016/08/03 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                        Mod   apsp350_period_tmp -->apsp350_tmp01
#160819-00015#2  2016/08/27 By dorislai  1.MAX(psoz002)改抓MAX(psea002)   
#                                        2.(1)採購數量psoz_t，改用psph_t抓取，並過濾psph016='I','P','NP' (2)psib011只有'P','NP'的值
#                                        3.以供給單號對應pspc062，抓取保稅否的值
#                                        4.供應商邏輯修改(1)供應商百分比，原抓pmao_t，換抓pmat_t。  
#                                                          若抓不到，原本為跳錯誤訊息，改成則新增一筆供應商="NONE"的資料
#                                                       (2)psph016='P'，直接抓取採購單or收貨單的供應商
#                                        5.超過psja002設定期數之後的數量，全部加總至N+1期
#                                        6.多寫入psic_t的資料，抓pspa_t (1)pspa020='I','P0','P1','P2','P4'。 ('P2','P4'需分供應商)
#                                                                      (2)若有與psph_t抓出的資料不相同的料號，也要一併寫入apst350中
#                                        7.修正版本超過9，MAX會錯誤的情況(因型態是文字)
#                                        8.預測編號+預測起始日期+供應商+計畫員+最大版本，有未確認的單，詢問，"是否要刪除，併重新產生"
#                                        9.供應商NULL的部分，換成→NONE  10.第一期日期之前的數量，需算在第一期中
#                                        11.調整起始日期~截止日期的算法  12.刪除沒有單身的單頭(apst350) 13.多加一check box"無需求資料是否顯示"
#                                        14.psic_t，類型為'P2','P4'抓取供應商，若沒供應商，補"NOTDEFINED"
#161109-00085#16 2016/11/15 By 08993     整批調整系統星號寫法
#161109-00085#61 2016/11/25 By 08171     整批調整系統星號寫法

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       imaa009 LIKE imaa_t.imaa009, 
   imaf141 LIKE imaf_t.imaf141, 
   imae012 LIKE imae_t.imae012, 
   psja001 LIKE psja_t.psja001, 
   psja001_desc LIKE type_t.chr80, 
   psoz004 LIKE psoz_t.psoz004, 
   l_chk LIKE type_t.chr1, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#mod--161109-00085#16 By 08993--(s)
#DEFINE g_psja           RECORD LIKE psja_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE g_psja           RECORD  #採購預測策略檔
       psjaent LIKE psja_t.psjaent, #企業編號
       psjasite LIKE psja_t.psjasite, #營運據點
       psja001 LIKE psja_t.psja001, #預測編號
       psja002 LIKE psja_t.psja002, #預測期數
       psja003 LIKE psja_t.psja003, #預測起始日
       psja004 LIKE psja_t.psja004, #APS版本
       psja005 LIKE psja_t.psja005, #依計畫員預測
       psja006 LIKE psja_t.psja006, #供應商分配方式
       psja007 LIKE psja_t.psja007, #指定供應商
       psja008 LIKE psja_t.psja008, #分配限量
       psjaownid LIKE psja_t.psjaownid, #資料所有者
       psjaowndp LIKE psja_t.psjaowndp, #資料所屬部門
       psjacrtid LIKE psja_t.psjacrtid, #資料建立者
       psjacrtdp LIKE psja_t.psjacrtdp, #資料建立部門
       psjacrtdt LIKE psja_t.psjacrtdt, #資料創建日
       psjamodid LIKE psja_t.psjamodid, #資料修改者
       psjamoddt LIKE psja_t.psjamoddt, #最近修改日
       psjastus LIKE psja_t.psjastus, #狀態碼
       #161109-00085#61 --s add
       psjaud001 LIKE psja_t.psjaud001, #自定義欄位(文字)001
       psjaud002 LIKE psja_t.psjaud002, #自定義欄位(文字)002
       psjaud003 LIKE psja_t.psjaud003, #自定義欄位(文字)003
       psjaud004 LIKE psja_t.psjaud004, #自定義欄位(文字)004
       psjaud005 LIKE psja_t.psjaud005, #自定義欄位(文字)005
       psjaud006 LIKE psja_t.psjaud006, #自定義欄位(文字)006
       psjaud007 LIKE psja_t.psjaud007, #自定義欄位(文字)007
       psjaud008 LIKE psja_t.psjaud008, #自定義欄位(文字)008
       psjaud009 LIKE psja_t.psjaud009, #自定義欄位(文字)009
       psjaud010 LIKE psja_t.psjaud010, #自定義欄位(文字)010
       psjaud011 LIKE psja_t.psjaud011, #自定義欄位(數字)011
       psjaud012 LIKE psja_t.psjaud012, #自定義欄位(數字)012
       psjaud013 LIKE psja_t.psjaud013, #自定義欄位(數字)013
       psjaud014 LIKE psja_t.psjaud014, #自定義欄位(數字)014
       psjaud015 LIKE psja_t.psjaud015, #自定義欄位(數字)015
       psjaud016 LIKE psja_t.psjaud016, #自定義欄位(數字)016
       psjaud017 LIKE psja_t.psjaud017, #自定義欄位(數字)017
       psjaud018 LIKE psja_t.psjaud018, #自定義欄位(數字)018
       psjaud019 LIKE psja_t.psjaud019, #自定義欄位(數字)019
       psjaud020 LIKE psja_t.psjaud020, #自定義欄位(數字)020
       psjaud021 LIKE psja_t.psjaud021, #自定義欄位(日期時間)021
       psjaud022 LIKE psja_t.psjaud022, #自定義欄位(日期時間)022
       psjaud023 LIKE psja_t.psjaud023, #自定義欄位(日期時間)023
       psjaud024 LIKE psja_t.psjaud024, #自定義欄位(日期時間)024
       psjaud025 LIKE psja_t.psjaud025, #自定義欄位(日期時間)025
       psjaud026 LIKE psja_t.psjaud026, #自定義欄位(日期時間)026
       psjaud027 LIKE psja_t.psjaud027, #自定義欄位(日期時間)027
       psjaud028 LIKE psja_t.psjaud028, #自定義欄位(日期時間)028
       psjaud029 LIKE psja_t.psjaud029, #自定義欄位(日期時間)029
       psjaud030 LIKE psja_t.psjaud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psja009 LIKE psja_t.psja009  #預測起始日指定方式
          END RECORD
#mod--161109-00085#16 By 08993--(e)

DEFINE g_ooef008        LIKE ooef_t.ooef008
DEFINE g_ooef009        LIKE ooef_t.ooef009
DEFINE g_psib           DYNAMIC ARRAY OF RECORD
         psib006        LIKE psib_t.psib006,   #料件編號
         psib007        LIKE psib_t.psib007,   #產品特徵
         psib008        LIKE psib_t.psib008,   #期別
         psib009        LIKE psib_t.psib009,   #起始日期
         psib010        LIKE psib_t.psib010,   #截止日期
         psib011        LIKE psib_t.psib011,   #數量
         #160819-00015#2-s-add
         psib013        LIKE psib_t.psib013,   #保稅否          
         psib003        LIKE psib_t.psib003,   #供應商   
         psib011_i      LIKE psib_t.psib011,   #供給類型="I"的數量
         #psib011_np     LIKE psib_t.psib011,   #供給類型="NP"的數量
         l_doc          LIKE type_t.num5,      #為於哪張單
         #160819-00015#2-e-add
         psib012        LIKE psib_t.psib012    #單位
         
                        END RECORD
DEFINE l_ac             LIKE type_t.num5
DEFINE g_psib004        LIKE psib_t.psib004
DEFINE g_ref_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#160819-00015#2-s-add
DEFINE g_psoz002        LIKE psoz_t.psoz002  #執行日期時間   
DEFINE g_purchase_sum   LIKE type_t.num20_6  #加總psph016="NP"的數量
DEFINE g_purchase_sum_1 LIKE type_t.num20_6  #加總pspa020="P01"的數量
DEFINE g_purchase_diff  LIKE type_t.num20_6  #為採購量的差額，pspa020-psph016
#160819-00015#2-e-add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp350.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apsp350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp350 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp350_init()
 
      #進入選單 Menu (="N")
      CALL apsp350_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp350
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp350.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp350_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   INITIALIZE g_master.* TO NULL
   LET g_master.l_chk = 'N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp350_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_psja003      LIKE psja_t.psja003
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.psja001,g_master.psoz004,g_master.l_chk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psja001
            
            #add-point:AFTER FIELD psja001 name="input.a.psja001"
            DISPLAY '' TO psja001_desc
            
            IF NOT cl_null(g_master.psja001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.psja001
               LET g_errshow = TRUE   #160318-00025#51
               LET g_chkparam.err_str[1] = "aps-00111:sub-01302|apsi350|",cl_get_progname("apsi350",g_lang,"2"),"|:EXEPROGapsi350"    #160318-00025#51   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_psja001") THEN
                  #檢查成功時後續處理
                  LET l_psja003 = ''
                  SELECT psja003 INTO l_psja003 FROM psja_t
                   WHERE psjaent = g_enterprise
                     AND psjasite= g_site
                     AND psja001 = g_master.psja001
                  IF cl_null(l_psja003) OR l_psja003 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aps-00113'
                     LET g_errparam.extend = g_master.psja001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
                  
                  #160819-00015#2-s-mod
#                  IF NOT cl_null(g_master.psoz004) THEN
#                    LET g_master.psoz004 = MDY(MONTH(g_master.psoz004),l_psja003,YEAR(g_master.psoz004))
#                    DISPLAY BY NAME g_master.psoz004
#                  END IF
                  IF NOT apsp350_psoz004_chk() THEN
                     NEXT FIELD psoz004
                  END IF
                  #160819-00015#2-e-mod
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            CALL apsp350_psja001_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psja001
            #add-point:BEFORE FIELD psja001 name="input.b.psja001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psja001
            #add-point:ON CHANGE psja001 name="input.g.psja001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psoz004
            #add-point:BEFORE FIELD psoz004 name="input.b.psoz004"
            IF cl_null(l_psja003) OR l_psja003 <= 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aps-00112'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               
               NEXT FIELD psja001
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psoz004
            
            #add-point:AFTER FIELD psoz004 name="input.a.psoz004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psoz004
            #add-point:ON CHANGE psoz004 name="input.g.psoz004"
            #160819-00015#2-s-mod
#            IF NOT cl_null(g_master.psoz004) THEN
#               LET g_master.psoz004 = MDY(MONTH(g_master.psoz004),l_psja003,YEAR(g_master.psoz004))
#               DISPLAY BY NAME g_master.psoz004
#            END IF
            IF NOT apsp350_psoz004_chk() THEN
               NEXT FIELD psoz004
            END IF
            #160819-00015#2-e-mod
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk
            #add-point:BEFORE FIELD l_chk name="input.b.l_chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk
            
            #add-point:AFTER FIELD l_chk name="input.a.l_chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk
            #add-point:ON CHANGE l_chk name="input.g.l_chk"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.psja001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psja001
            #add-point:ON ACTION controlp INFIELD psja001 name="input.c.psja001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.psja001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_psja001()                                #呼叫開窗

            LET g_master.psja001 = g_qryparam.return1              

            DISPLAY g_master.psja001 TO psja001              #
            
            CALL apsp350_psja001_ref()

            NEXT FIELD psja001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.psoz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psoz004
            #add-point:ON ACTION controlp INFIELD psoz004 name="input.c.psoz004"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk
            #add-point:ON ACTION controlp INFIELD l_chk name="input.c.l_chk"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa009,imaf141,imae012
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="construct.c.imaf141"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '203'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="construct.b.imaf141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="construct.a.imaf141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="construct.c.imae012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
            NEXT FIELD imae012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="construct.b.imae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="construct.a.imae012"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apsp350_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apsp350_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL apsp350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp350_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apsp350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp350_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apsp350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp350_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_msg       STRING
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_success = TRUE
   
   #抓取採購預測策略檔(psja_t)資料
   INITIALIZE g_psja.* TO NULL
   #mod--161109-00085#16 By 08993--(s)
#   SELECT * INTO g_psja.* FROM psja_t   #mark--161109-00085#16 By 08993--(s)
   #161109-00085#61 --s mark
   #SELECT psjaent,psjasite,psja001,psja002,psja003,psja004,psja005,psja006,psja007,
   #       psja008,psjaownid,psjaowndp,psjacrtid,psjacrtdp,psjacrtdt,psjamodid,psjamoddt,psjastus,psja009 
   # INTO g_psja.psjaent,g_psja.psjasite,g_psja.psja001,g_psja.psja002,g_psja.psja003,g_psja.psja004,g_psja.psja005,
   #      g_psja.psja006,g_psja.psja007,g_psja.psja008,g_psja.psjaownid,g_psja.psjaowndp,g_psja.psjacrtid,g_psja.psjacrtdp,
   #      g_psja.psjacrtdt,g_psja.psjamodid,g_psja.psjamoddt,g_psja.psjastus,g_psja.psja009 
   #161109-00085#61 --e mark
   #161109-00085#61 --s add
  SELECT psjaent,psjasite,psja001,psja002,psja003,
         psja004,psja005,psja006,psja007,psja008,
         psjaownid,psjaowndp,psjacrtid,psjacrtdp,psjacrtdt,
         psjamodid,psjamoddt,psjastus,psjaud001,psjaud002,
         psjaud003,psjaud004,psjaud005,psjaud006,psjaud007,
         psjaud008,psjaud009,psjaud010,psjaud011,psjaud012,
         psjaud013,psjaud014,psjaud015,psjaud016,psjaud017,
         psjaud018,psjaud019,psjaud020,psjaud021,psjaud022,
         psjaud023,psjaud024,psjaud025,psjaud026,psjaud027,
         psjaud028,psjaud029,psjaud030,psja009
    INTO g_psja.psjaent,g_psja.psjasite,g_psja.psja001,g_psja.psja002,g_psja.psja003,
         g_psja.psja004,g_psja.psja005,g_psja.psja006,g_psja.psja007,g_psja.psja008,
         g_psja.psjaownid,g_psja.psjaowndp,g_psja.psjacrtid,g_psja.psjacrtdp,g_psja.psjacrtdt,
         g_psja.psjamodid,g_psja.psjamoddt,g_psja.psjastus,g_psja.psjaud001,g_psja.psjaud002,
         g_psja.psjaud003,g_psja.psjaud004,g_psja.psjaud005,g_psja.psjaud006,g_psja.psjaud007,
         g_psja.psjaud008,g_psja.psjaud009,g_psja.psjaud010,g_psja.psjaud011,g_psja.psjaud012,
         g_psja.psjaud013,g_psja.psjaud014,g_psja.psjaud015,g_psja.psjaud016,g_psja.psjaud017,
         g_psja.psjaud018,g_psja.psjaud019,g_psja.psjaud020,g_psja.psjaud021,g_psja.psjaud022,
         g_psja.psjaud023,g_psja.psjaud024,g_psja.psjaud025,g_psja.psjaud026,g_psja.psjaud027,
         g_psja.psjaud028,g_psja.psjaud029,g_psja.psjaud030,g_psja.psja009
   #161109-00085#61 --e add
    FROM psja_t
   #mod--161109-00085#16 By 08993--(e)
    WHERE psjaent = g_enterprise
      AND psjasite= g_site
      AND psja001 = g_master.psja001
      AND psjastus= 'Y'   #確認資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00110'
      LET g_errparam.extend = g_master.psja001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF
   #160819-00015#2-s-add  
   #若沒設定供應商，給"NONE"
   IF cl_null(g_psja.psja007) THEN
      LET g_psja.psja007 = "NONE"
   END IF
   #160819-00015#2-e-add
   
   #取得該營運據點的行事曆參照表號、製造行事曆對應類別
   LET g_ooef008 = NULL
   LET g_ooef009 = NULL
   SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   #Create Temp Table
   CALL apsp350_create_temptable() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   #抓取欲處理的資料(psoz_t)
   CALL cl_err_collect_init()
   CALL apsp350_get_data() RETURNING l_success
   CALL cl_err_collect_show()
   IF NOT l_success THEN
      RETURN
   END IF
   
   IF cl_null(l_ac) OR l_ac <= 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = l_ac + 1
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsp350_process_cs CURSOR FROM ls_sql
#  FOREACH apsp350_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   FOR l_ac = 1 TO g_psib.getLength()
      #計畫員
      LET g_psib004 = NULL
      IF g_psja.psja005 = 'Y' THEN
         SELECT imae012 INTO g_psib004 FROM imae_t
          WHERE imaeent = g_enterprise
            AND imaesite= g_site
            AND imae001 = g_psib[l_ac].psib006
      END IF
      IF cl_null(g_psib004) THEN
         LET g_psib004 = ' '
      END IF
      
      #依採購預測編號設定的供應商分配方式分配各供應商
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg_parm('aps-00115',g_dlang,g_psib[l_ac].psib006||'|'||g_psib[l_ac].psib007||'|'||g_psib[l_ac].psib008)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      #160819-00015#2-s-mod
      #CALL apsp350_apportion() RETURNING l_success
      IF g_psib[l_ac].l_doc MATCHES '[23]' THEN  
         INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
            VALUES (g_psib[l_ac].psib003,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
                    g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
                    g_psib[l_ac].psib011_i)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apsp350_tmp'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE  
         END IF
      ELSE
         CALL apsp350_apportion() RETURNING l_success
      END IF
      #160819-00015#2-e-mod
      
      IF NOT l_success THEN
         EXIT FOR
      END IF
   END FOR
   #160819-00015#2-s-add  
   IF l_success THEN
      CALL apsp350_get_pspa() RETURNING l_success
   END IF
   #160819-00015#2-e-add 
   IF l_success THEN
      #將資料新增到採購預測單頭檔(psia_t)及採購預測單身檔(psib_t)
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00118',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL apsp350_ins_data() RETURNING l_success
   END IF
   
   CALL cl_err_collect_show()
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apsp350_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp350.get_buffer" >}
PRIVATE FUNCTION apsp350_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.psja001 = p_dialog.getFieldBuffer('psja001')
   LET g_master.psoz004 = p_dialog.getFieldBuffer('psoz004')
   LET g_master.l_chk = p_dialog.getFieldBuffer('l_chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsp350.msgcentre_notify" >}
PRIVATE FUNCTION apsp350_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL apsp350_create_temptable()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_create_temptable()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE apsp350_tmp
   CREATE TEMP TABLE apsp350_tmp(
      psib003         VARCHAR(10),
      psib004         VARCHAR(20),
      psib006         VARCHAR(40),
      psib007         VARCHAR(256),
      psib008         SMALLINT,
      psib009         DATE,
      psib010         DATE,
      psib011         DECIMAL(20,6),
      psib012         VARCHAR(10),
      psib013         VARCHAR(1),        #160819-00015#2-add
      psib011_i       DECIMAL(20,6)     #160819-00015#2-add
      #psib011_np     LIKE psib_t.psib011   #160819-00015#2-add
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsp350_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE apsp350_tmp01            #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
   CREATE TEMP TABLE apsp350_tmp01(    #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
      period          SMALLINT,
      bdate           DATE,
      edate           DATE
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsp350_tmp01'       #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160819-00015#2-s-add
   #暫存psic_t
   DROP TABLE apsp350_tmp02
   CREATE TEMP TABLE apsp350_tmp02(
      psic001   VARCHAR(10),      #預測編號
      psic002   DATE,      #預測起始日期
      psic003   VARCHAR(10),      #供應商
      psic004   VARCHAR(20),      #計畫員
      psic005   VARCHAR(10),      #版本
      psic006   VARCHAR(40),      #料件編號
      psic007   VARCHAR(256),      #產品特徵
      psic008   VARCHAR(1),      #保稅否
      psic009   DECIMAL(20,6),      #庫存量
      psic010   DECIMAL(20,6),      #請購量
      psic011   DECIMAL(20,6),      #採購未收量
      psic012   DECIMAL(20,6),      #採購在驗量
      psic013   DECIMAL(20,6)     #未分配計劃採購量
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsp350_tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #暫存庫存量(供給類型='I')
   DROP TABLE apsp350_tmp03
   CREATE TEMP TABLE apsp350_tmp03(
      psic001   VARCHAR(10),      #預測編號
      psic002   DATE,      #預測起始日
      psic006   VARCHAR(40),      #料件編號
      psic007   VARCHAR(256),      #產品特徵
      inaa015   VARCHAR(1),      #保稅否
      psic009   DECIMAL(20,6)     #庫存量
      
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsp350_tmp03'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #160819-00015#2-e-add
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取欲處理的資料
# Memo...........:
# Usage..........: CALL apsp350_get_data()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_get_data()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_psoz002         LIKE psoz_t.psoz002
DEFINE l_psoz038         LIKE psoz_t.psoz038
DEFINE l_psoz039         LIKE psoz_t.psoz039
DEFINE l_bdate           LIKE type_t.dat
DEFINE l_edate           LIKE type_t.dat
DEFINE l_psjb002         LIKE psjb_t.psjb002
DEFINE l_psjb003         LIKE psjb_t.psjb003
DEFINE l_qty             LIKE psib_t.psib011
DEFINE l_imaa006         LIKE imaa_t.imaa006
DEFINE l_imaf143         LIKE imaf_t.imaf143
#160819-00015#2-s-add
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_sql1            STRING
DEFINE l_from            STRING
DEFINE l_where           STRING
DEFINE l_group           STRING
DEFINE l_chk             LIKE type_t.num5
DEFINE l_bdate_1         LIKE type_t.dat    
DEFINE l_bdate_before    LIKE type_t.dat
DEFINE l_psph010         LIKE psph_t.psph010
DEFINE l_psph019         LIKE psph_t.psph019
DEFINE l_psph038         LIKE psph_t.psph038
DEFINE l_psph039         LIKE psph_t.psph039
DEFINE l_psph016         LIKE psph_t.psph016
DEFINE l_psph024         LIKE psph_t.psph024
DEFINE l_psph026         LIKE psph_t.psph026
DEFINE l_psib013         LIKE psib_t.psib013  #保稅否
#160819-00015#2-e-add

   LET r_success = TRUE
   
   DELETE FROM apsp350_tmp01         #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
   
   #抓取同一ENT+SITE+APS版本存在於psoz_t近的執行日期時間
   #160819-00015#2-s-mod 執行日期時間換抓取psea002
#   LET l_psoz002 = ''
#   SELECT MAX(psoz002) INTO l_psoz002 FROM psoz_t
#    WHERE psozent = g_enterprise
#      AND psozsite= g_site
#      AND psoz001 = g_psja.psja004
   SELECT MAX(psea002) INTO g_psoz002 FROM psea_t
    WHERE pseaent = g_enterprise
      AND pseasite= g_site
      AND psea001 = g_psja.psja004
   #160819-00015#2-e-mod
   IF cl_null(g_psoz002) THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00114'
      LET g_errparam.extend = g_psja.psja004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   #抓取apsi350設定的各期別資料
   LET l_sql = "SELECT psjb002,psjb003 FROM psjb_t ",
               " WHERE psjbent = ",g_enterprise,
               "   AND psjbsite='",g_site,"'",
               "   AND psjb001 ='",g_master.psja001,"'",
               " ORDER BY psjb002 "
   PREPARE apsp350_psjb_pre FROM l_sql
   DECLARE apsp350_psjb_cs CURSOR FOR apsp350_psjb_pre
   
   #160823 改用psph_t 要寫tmp
   #抓取MRP結果檔(psoz_t)
   #160819-00015#2-s-mod
#   LET l_sql = "SELECT SUM(COALESCE(psoz005,0)+COALESCE(psoz006,0)+COALESCE(psoz007,0)+COALESCE(psoz012,0)+COALESCE(psoz014,0)), ",
#               "       psoz038,psoz039,imaa006,imaf143 ",
#               "  FROM psoz_t ",
#               "       LEFT OUTER JOIN imaa_t ON imaaent = psozent AND imaa001 = psoz038 ",
#               "       LEFT OUTER JOIN imaf_t ON imafent = psozent AND imafsite = psozsite AND imaf001 = psoz038 ",
#               "       LEFT OUTER JOIN imae_t ON imaeent = psozent AND imaesite = psozsite AND imae001 = psoz038 ",
#               " WHERE psozent = ",g_enterprise,
#               "   AND psozsite = '",g_site,"'",
#               "   AND psoz001 = '",g_psja.psja004,"'",
#               "   AND psoz002 = '",l_psoz002,"'",
#               "   AND imaf013 IN ('1','4') ",   #採購件
#               "   AND psoz004 BETWEEN ? AND ? ",
#               "   AND ",g_master.wc CLIPPED,
#               " GROUP BY psoz038,psoz039,imaa006,imaf143 ",
#               " ORDER BY psoz038,psoz039 "
#   PREPARE apsp350_psoz_pre FROM l_sql
#   DECLARE apsp350_psoz_cs CURSOR FOR apsp350_psoz_pre
   LET l_sql = "SELECT psph010,psph019,psph017,COALESCE(psph039,' '),psph016,SUM(psph026),psph024,imaf143 "          
   LET l_from = "  FROM psph_t ",
                "  LEFT OUTER JOIN imaa_t ON imaaent = psphent AND imaa001 = psph017 ",
                "  LEFT OUTER JOIN imaf_t ON imafent = psphent AND imafsite = psphsite AND imaf001 = psph017 ",
                "  LEFT OUTER JOIN imae_t ON imaeent = psphent AND imaesite = psphsite AND imae001 = psph017 "
   LET l_where = " WHERE psphent = '",g_enterprise,"'",
                 "   AND psphsite = '",g_site,"'",
                 "   AND psph001 = '",g_psja.psja004,"'",
                 "   AND psph002 = '",g_psoz002,"'",
                 "   AND imaf013 <> '2' ",  #除了自製件，其他都算採購件
                 "   AND psph016 IN ('I','NP','P') ",               
                 "   AND ",g_master.wc CLIPPED             
   LET l_group = " GROUP BY psph010,psph019,psph017,psph039,psph016,psph024,imaf143 ",
                 " ORDER BY psph017,psph039,psph019,psph016 "   
   #期別
   LET l_sql1 = l_sql CLIPPED,l_from CLIPPED,l_where CLIPPED,"   AND psph019 BETWEEN ? AND ? ",l_group
   PREPARE apsp350_psoz_pre FROM l_sql1
   DECLARE apsp350_psoz_cs CURSOR FOR apsp350_psoz_pre
   #超過期別
   LET l_sql1 = l_sql CLIPPED,l_from CLIPPED,l_where CLIPPED,"   AND psph019 > ? ",l_group
   PREPARE apsp350_psph_pre FROM l_sql1
   DECLARE apsp350_psph_cs CURSOR FOR apsp350_psph_pre

   #160819-00015#2-e-mod
   
   #160819-00015#2-s-add
   #選出最小的日期，後面要把第一期之前日期的數量，需算在第一期中
   LET l_bdate_before = ''
   LET l_sql = " SELECT MIN(psph019) "
   LET l_sql1 = l_sql CLIPPED,l_from CLIPPED,l_where 
   PREPARE apsp350_psph_pre1 FROM l_sql1
   EXECUTE apsp350_psph_pre1 INTO l_bdate_before
   FREE apsp350_psph_pre1
   LET l_chk = TRUE
   #160819-00015#2-e-add
   
   LET l_bdate = g_master.psoz004
   LET l_ac = 1
   FOREACH apsp350_psjb_cs INTO l_psjb002,l_psjb003
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_psjb_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      #取得截止日期
      CALL apsp350_get_edate(l_bdate,l_psjb003)
           RETURNING l_edate
      
      #記錄每期的起始、截止日期
      INSERT INTO apsp350_tmp01(period,bdate,edate)          #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
         VALUES(l_psjb002,l_bdate,l_edate)
      
      #160819-00015#2-s-add 
      #第一期日期之前的數量，需算在第一期中
      LET l_bdate_1 = l_bdate
      IF l_chk THEN
         IF l_bdate_before < l_bdate THEN
            LET l_bdate = l_bdate_before
         END IF
         LET l_chk = FALSE
      END IF
      #160819-00015#2-e-add
      
      #160819-00015#2-s-mod
      #FOREACH apsp350_psoz_cs USING l_bdate,l_edate INTO l_qty,l_psoz038,l_psoz039,l_imaa006,l_imaf143
      #   IF SQLCA.sqlcode THEN
      #      LET r_success = FALSE
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "FOREACH:apsp350_psoz_cs"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #
      #      EXIT FOREACH
      #   END IF
      #   
      #   IF cl_null(l_qty) THEN
      #      LET l_qty = 0
      #   END IF
      #   
      #   #將基礎單位換算成採購單位
      #   IF cl_null(l_imaf143) THEN
      #      LET r_success = FALSE
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = "aic-00022"
      #      LET g_errparam.extend = l_psoz038
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      
      #      CONTINUE FOREACH
      #   ELSE
      #      CALL s_aooi250_convert_qty(l_psoz038,l_imaa006,l_imaf143,l_qty)
      #           RETURNING r_success,l_qty
      #   END IF
      #   
      #   INITIALIZE g_psib[l_ac].* TO NULL
      #   LET g_psib[l_ac].psib006 = l_psoz038
      #   LET g_psib[l_ac].psib007 = l_psoz039
      #   LET g_psib[l_ac].psib008 = l_psjb002
      #   LET g_psib[l_ac].psib009 = l_bdate
      #   LET g_psib[l_ac].psib010 = l_edate
      #   LET g_psib[l_ac].psib011 = l_qty
      #   LET g_psib[l_ac].psib012 = l_imaf143
      #   
      #   LET l_ac = l_ac + 1
      #END FOREACH     
      FOREACH apsp350_psoz_cs USING l_bdate,l_edate INTO l_psph010,l_psph019,l_psph038,l_psph039,l_psph016,l_psph026,
                                                         l_psph024,l_imaf143                                                     
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:apsp350_psoz_cs"
            LET g_errparam.popup = TRUE
            CALL cl_err()
   
            EXIT FOREACH
         END IF
         
         #可供給量
         IF cl_null(l_psph026) THEN
            LET l_psph026 = 0
         END IF
         
         #從採購結果檔，抓取保稅否
         LET l_psib013 = apsp350_get_psib013(l_psph016,l_psph010,l_psph038,l_psph039,l_psph024)

         INITIALIZE g_psib[l_ac].* TO NULL
         LET g_psib[l_ac].psib006 = l_psph038
         LET g_psib[l_ac].psib007 = l_psph039
         LET g_psib[l_ac].psib008 = l_psjb002
         LET g_psib[l_ac].psib009 = l_bdate_1
         LET g_psib[l_ac].psib010 = l_edate
         LET g_psib[l_ac].psib012 = l_imaf143
         LET g_psib[l_ac].psib013 = l_psib013
         LET g_psib[l_ac].psib011 = l_psph026
         #供給類型='P'，需判斷可供給量，是請購單 or 採購單 or 收貨單，除請購單外，再抓取其供應商
         IF l_psph016 = 'P' THEN  
            CALL apsp350_get_doc('2','',l_psph010) RETURNING g_psib[l_ac].l_doc,g_psib[l_ac].psib003  
         END IF
         #供給類型='I'
         IF l_psph016 = 'I' THEN
            LET g_psib[l_ac].psib011_i = l_psph026
            LET g_psib[l_ac].psib011 = 0
         ELSE
            LET g_psib[l_ac].psib011_i = 0
         END IF
         ##供給類型='NP'
         #IF l_psph016 = 'NP' THEN
         #   LET g_psib[l_ac].psib011_np = l_psph026
         #ELSE
         #   LET g_psib[l_ac].psib011_np = 0
         #END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      #160819-00015#2-e-mod
      
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      LET l_bdate = l_edate + 1   
   END FOREACH
   #160819-00015#2-s-add 抓取超過版本設定的期別部分
   IF l_ac > 2 THEN
      LET l_bdate_1 = l_bdate                    #起始日期
      LET l_psjb002 = g_psib[l_ac-1].psib008  +1 #期別
      FOREACH apsp350_psph_cs USING g_psib[l_ac-1].psib010
         INTO l_psph010,l_psph019,l_psph038,l_psph039,l_psph016,l_psph026,l_psph024,l_imaf143  
         #從採購結果檔，抓取保稅否
         LET l_psib013 = apsp350_get_psib013(l_psph016,l_psph010,l_psph038,l_psph039,l_psph024)
         INITIALIZE g_psib[l_ac].* TO NULL
         LET g_psib[l_ac].psib006 = l_psph038
         LET g_psib[l_ac].psib007 = l_psph039
         LET g_psib[l_ac].psib008 = l_psjb002   #期數，N+1
         LET g_psib[l_ac].psib009 = l_bdate_1
         #LET g_psib[l_ac].psib010 = l_edate
         LET g_psib[l_ac].psib012 = l_imaf143
         LET g_psib[l_ac].psib013 = l_psib013
         LET g_psib[l_ac].psib011 = l_psph026
         #供給類型='P'，需判斷可供給量，是請購單 or 採購單 or 收貨單，除請購單外，再抓取其供應商
         IF l_psph016 = 'P' THEN  
            CALL apsp350_get_doc('2','',l_psph010) RETURNING g_psib[l_ac].l_doc,g_psib[l_ac].psib003  
         END IF
         #供給類型='I'
         IF l_psph016 = 'I' THEN
            LET g_psib[l_ac].psib011_i = l_psph026
            LET g_psib[l_ac].psib011 = 0
         ELSE
            LET g_psib[l_ac].psib011_i = 0
         END IF
         ##供給類型='NP'
         #IF l_psph016 = 'NP' THEN
         #   LET g_psib[l_ac].psib011_np = l_psph026
         #ELSE
         #   LET g_psib[l_ac].psib011_np = 0
         #END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      #LET l_ac = l_ac + 1
   END IF
   #160819-00015#2-e-add 
   LET l_ac = l_ac - 1
   
   IF l_ac > 0 THEN
      IF cl_null(g_psib[g_psib.getLength()].psib006) THEN
         CALL g_psib.deleteElement(g_psib.getLength())
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得截止日期
# Memo...........:
# Usage..........: CALL apsp350_get_edate(p_bdate,p_psjb003)
#                  RETURNING r_edate
# Input parameter: p_bdate        起始日期
#                : p_psjb003      預測週期
# Return code....: r_edate        截止日期
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_get_edate(p_bdate,p_psjb003)
DEFINE p_bdate           LIKE type_t.dat
DEFINE p_psjb003         LIKE psjb_t.psjb003
DEFINE r_edate           LIKE type_t.dat
DEFINE l_oogc008         LIKE oogc_t.oogc008
DEFINE l_oogc015         LIKE oogc_t.oogc015
DEFINE l_day             LIKE type_t.num5
#160819-00015#2-s-add
DEFINE l_year            LIKE type_t.num5   
DEFINE l_month           LIKE type_t.num5   
#160819-00015#2-e-add

   LET r_edate = NULL
   #160819-00015#2-s-mod
   #CASE p_psjb003
   #   WHEN '1'   #週
   #        #取得起始日期的週別
   #        LET l_oogc008 = NULL
   #        LET l_oogc015 = NULL
   #        SELECT oogc008,oogc015 INTO l_oogc008,l_oogc015
   #          FROM oogc_t
   #         WHERE oogcent = g_enterprise
   #           AND oogc001 = g_ooef008
   #           AND oogc002 = g_ooef009
   #           AND oogc003 = p_bdate
   #        #取得該週的最後一天
   #        SELECT MAX(oogc003) INTO r_edate
   #          FROM oogc_t
   #         WHERE oogcent = g_enterprise
   #           AND oogc001 = g_ooef008
   #           AND oogc002 = g_ooef009
   #           AND oogc008 = l_oogc008
   #           AND oogc015 = l_oogc015
   #   WHEN '2'   #旬
   #        #取出日
   #        LET l_day = DAY(p_bdate)
   #        #依起始的日決定截止日期
   #        CASE 
   #           WHEN l_day >= 1 AND l_day <= 10
   #                LET r_edate = MDY(MONTH(p_bdate),10,YEAR(p_bdate))
   #           WHEN l_day >=11 AND l_day <= 20
   #                LET r_edate = MDY(MONTH(p_bdate),20,YEAR(p_bdate))
   #           WHEN l_day >=21
   #                LET r_edate = MDY(MONTH(p_bdate)+1,1,YEAR(p_bdate)) - 1
   #        END CASE
   #   WHEN '3'   #月
   #        LET r_edate = MDY(MONTH(p_bdate)+1,1,YEAR(p_bdate)) - 1
   #END CASE
   
   CASE p_psjb003
      WHEN '0'   #日
         LET r_edate = p_bdate
      WHEN '1'   #週(7天）
         LET r_edate = p_bdate + 6
      WHEN '2'   #旬(10天)
         LET r_edate = p_bdate + 9
      WHEN '3'   #月
         LET l_year  = YEAR(p_bdate)
         LET l_month = MONTH(p_bdate)
         LET l_day   = DAY(p_bdate)
         IF l_month MOD 12 = 0 THEN
           LET l_year = l_year + 1
           LET l_month = 1
         ELSE
           LET l_month = l_month + 1
         END IF
         LET r_edate = MDY(l_month,l_day,l_year)
   END CASE
   #160819-00015#2-e-mod
   RETURN r_edate
END FUNCTION

################################################################################
# Descriptions...: 依供應商分配方式分配各供應商
# Memo...........:
# Usage..........: CALL apsp350_apportion()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_apportion()
DEFINE r_success         LIKE type_t.num5
DEFINE l_imaf152         LIKE imaf_t.imaf152
DEFINE l_imaf154         LIKE imaf_t.imaf154

   LET r_success = TRUE
   
   CASE g_psja.psja006
      WHEN '1'   #依料件主檔設定
           LET l_imaf152 = NULL
           LET l_imaf154 = NULL
           SELECT imaf152,imaf154 INTO l_imaf152,l_imaf154
             FROM imaf_t
            WHERE imafent = g_enterprise
              AND imafsite= g_site
              AND imaf001 = g_psib[l_ac].psib006
           
           #若imaf152為null，則預設0.主要供應商，無限量
           IF cl_null(l_imaf152) THEN
              LET l_imaf152 = '0'
           END IF
           
           CASE l_imaf152
              WHEN '0'   #主要供應商，無限量
                   CALL apsp350_apportion_0() RETURNING r_success
              WHEN '1'   #依廠商分配
                   CALL apsp350_apportion_1() RETURNING r_success
              WHEN '2'   #主要供應商分配優先，餘量分配
                   CALL apsp350_apportion_2(l_imaf154) RETURNING r_success
              WHEN '3'   #指定單一供應商
                   CALL apsp350_apportion_3() RETURNING r_success
           END CASE
      WHEN '2'   #主要供應商，無限量
           CALL apsp350_apportion_0() RETURNING r_success
      WHEN '3'   #依廠商分配
           CALL apsp350_apportion_1() RETURNING r_success
      WHEN '4'   #主要供應商分配優先，餘量分配
           CALL apsp350_apportion_2(g_psja.psja008) RETURNING r_success
      WHEN '5'   #指定單一供應商
           CALL apsp350_apportion_3() RETURNING r_success
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 主要供應商，無限量
# Memo...........:
# Usage..........: CALL apsp350_apportion_0()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........: 
################################################################################
PRIVATE FUNCTION apsp350_apportion_0()
DEFINE p_soucrce         LIKE type_t.num5    #160819-00015#2-add
DEFINE r_success         LIKE type_t.num5
DEFINE l_psib003         LIKE psib_t.psib003

   LET r_success = TRUE
   
   
   #抓取料件據點進銷存檔的主要供應商(imaf153)
   SELECT imaf153 INTO l_psib003 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = g_psib[l_ac].psib006
   IF SQLCA.sqlcode OR cl_null(l_psib003) THEN
      #160819-00015#2-s-mod  
      #LET r_success = FALSE
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'aps-00116'
      #LET g_errparam.extend = g_psib[l_ac].psib006
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #
      #RETURN r_success
      LET l_psib003 = "NONE"
      #160819-00015#2-e-mod  
   END IF
   
   #160819-00015#2-s-mark
   ##考慮採購批量、最小採購量
   #CALL apsp350_cal_psib011(g_psib[l_ac].psib006,g_psib[l_ac].psib011,g_psib[l_ac].psib012)
   #     RETURNING r_success,g_psib[l_ac].psib011
   #IF NOT r_success THEN
   #   RETURN r_success
   #END IF
   ##160819-00015#2-e-mark
   
   #160819-00015#2-s-mod 多psib013、psib011_i
   #INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012)
   #   VALUES (l_psib003,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
   #           g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012)
   INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
      VALUES (l_psib003,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
              g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
              g_psib[l_ac].psib011_i)
   #160819-00015#2-e-mod
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apsp350_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依廠商分配
# Memo...........:
# Usage..........: CALL apsp350_apportion_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_apportion_1()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_pmao008_sum     LIKE pmao_t.pmao008
DEFINE l_pmao001         LIKE pmao_t.pmao001
DEFINE l_pmao008         LIKE pmao_t.pmao008
DEFINE l_psib011         LIKE psib_t.psib011
DEFINE l_tot_qty         LIKE psib_t.psib011
#DEFINE l_cal_tolerance   LIKE psib_t.psib011

   LET r_success = TRUE
   
   #160819-00015#2-s-mark
   ##seiichi S
   #LET g_psib[l_ac].psib006 = 'YS01'
   #LET g_psib[l_ac].psib007 = '1_S'
   #LET g_psib[l_ac].psib011 = 80
   ##seiichi E
   #160819-00015#2-e-mark

   #先算出該料的總比率
   LET l_pmao008_sum = 0
   
   #160819-00015#2-s-mod  pmao_t換抓pmat_t
   #SELECT SUM(pmao008) INTO l_pmao008_sum FROM pmao_t,pmaa_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = g_psib[l_ac].psib006
   #   AND NVL(pmao003,' ') = NVL(g_psib[l_ac].psib007,' ')
   #   AND pmaaent = pmaoent
   #   AND pmaa001 = pmao001
   #   AND pmaa002 IN ('1','3')
   #IF cl_null(l_pmao008_sum) OR l_pmao008_sum = 0 THEN
   #   LET r_success = FALSE
   #   INITIALIZE g_errparam TO NULL
   #   #LET g_errparam.code = 'aps-00117'  #160819-00015#2-s-mod
   #   LET g_errparam.code = 'aps-00195'   #160819-00015#2-e-mod
   #   LET g_errparam.extend = g_psib[l_ac].psib006,'+',g_psib[l_ac].psib007
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   
   #   RETURN r_success
   #END IF
   
   #依各供應商的分配比率進行分配
   #LET l_sql = "SELECT pmao001,pmao008 FROM pmao_t,pmaa_t ",
   #            " WHERE pmaoent = ",g_enterprise,
   #            "   AND pmao002 = '",g_psib[l_ac].psib006,"'",
   #            "   AND NVL(pmao003,' ') = NVL('",g_psib[l_ac].psib007,"',' ')",
   #            "   AND pmaaent = pmaoent ",
   #            "   AND pmaa001 = pmao001 ",
   #            "   AND pmaa002 IN ('1','3') ",
   #            " ORDER BY pmao008 DESC"
   SELECT SUM(pmat004) INTO l_pmao008_sum FROM pmat_t,pmaa_t
    WHERE pmatent = g_enterprise
      AND pmatsite = g_site
      AND pmat002 = g_psib[l_ac].psib006
      AND COALESCE(pmat003,' ') = COALESCE(g_psib[l_ac].psib007,' ')
      AND pmatent = pmaaent
      AND pmat001 = pmaa001
      AND pmaa002 IN ('1','3')
      AND pmatstus = 'Y'
   IF cl_null(l_pmao008_sum) OR l_pmao008_sum = 0 THEN
      #沒有比率的直接給一個虛擬的供應商
      LET l_pmao001 = 'NONE'
      INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
         VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
                 g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
                 g_psib[l_ac].psib011_i)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apsp350_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success  
      END IF
      
      RETURN r_success
   END IF
   
   #依各供應商的分配比率進行分配
   LET l_sql = "SELECT pmat001,pmat004 FROM pmat_t,pmaa_t ",
               " WHERE pmatent = '",g_enterprise,"'",
               "   AND pmatsite = '",g_site,"'",
               "   AND pmat002 = '",g_psib[l_ac].psib006,"'",
               "   AND COALESCE(pmat003,' ') = COALESCE('",g_psib[l_ac].psib007,"',' ') ",
               "   AND pmatent = pmaaent ",
               "   AND pmat001 = pmaa001 ",
               "   AND pmaa002 IN ('1','3') ",
               "   AND pmatstus = 'Y' ",
               " ORDER BY pmat004 DESC "
   #160819-00015#2-e-mod
   PREPARE apsp350_pmao_pre FROM l_sql
   DECLARE apsp350_pmao_cs CURSOR FOR apsp350_pmao_pre
   
   LET l_tot_qty = 0
   FOREACH apsp350_pmao_cs INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_pmao_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #依比率分配
      LET l_psib011 = g_psib[l_ac].psib011 * l_pmao008 / l_pmao008_sum
      
      #若剩餘數量小於分配數量，則採購量=剩餘數量
      IF (g_psib[l_ac].psib011 - l_tot_qty) < l_psib011 THEN 
         LET l_psib011 = g_psib[l_ac].psib011 - l_tot_qty
      END IF
      
      #160819-00015#2-s-mark
      ##考慮採購批量、最小採購量
      #CALL apsp350_cal_psib011(g_psib[l_ac].psib006,l_psib011,g_psib[l_ac].psib012)
      #     RETURNING r_success,l_psib011
      #IF NOT r_success THEN
      #   EXIT FOREACH
      #END IF
      #160819-00015#2-e-mark
      
      LET l_tot_qty = l_tot_qty + l_psib011
      
      #160819-00015#2-s-mod 多psib013
      #INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012)
      #   VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
      #           g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012)
      INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
         VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
                 g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
                 g_psib[l_ac].psib011_i)
      #160819-00015#2-e-mod
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apsp350_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      #總採購數量 >= 原採購數量，則不用再分配
      IF l_tot_qty >= g_psib[l_ac].psib011 THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
#   #尾差，歸屬最後一筆供應商
#   LET l_cal_tolerance = l_tot_qty - g_psib[l_ac].psib011
#   IF l_cal_tolerance  != 0 THEN
#      LET l_psib011 = l_psib011 - l_cal_tolerance
#      IF l_psib011 > 0 THEN
#         CALL apsp350_cal_psib011(g_psib[l_ac].psib006,l_psib011,g_psib[l_ac].psib012)
#              RETURNING r_success,l_psib011
#         IF NOT r_success THEN
#            RETURN r_success
#         END IF
#      END IF
#      
#      UPDATE apsp350_tmp SET psib011 = psib011 - l_psib011
#       WHERE psib003 = l_pmao001 
#         AND psib004 = g_psib004
#         AND psib006 = g_psib[l_ac].psib006
#         AND psib007 = g_psib[l_ac].psib007
#         AND psib008 = g_psib[l_ac].psib008
#         AND psib009 = g_psib[l_ac].psib009
#         AND psib010 = g_psib[l_ac].psib010
#         AND psib012 = g_psib[l_ac].psib012
#      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#         LET r_success = FALSE
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'upd apsp350_tmp'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#  
#      END IF
#   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 主要供應商分配優先，餘量分配
# Memo...........:
# Usage..........: CALL apsp350_apportion_2(p_qty)
#                  RETURNING r_success
# Input parameter: p_qty          主供應商分配限量
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_apportion_2(p_qty)
DEFINE p_qty             LIKE psib_t.psib011
DEFINE r_success         LIKE type_t.num5
DEFINE l_psib003         LIKE psib_t.psib003
DEFINE l_margin          LIKE psib_t.psib011
DEFINE l_psib011         LIKE psib_t.psib011
DEFINE l_sql             STRING
DEFINE l_pmao008_sum     LIKE pmao_t.pmao008
DEFINE l_pmao001         LIKE pmao_t.pmao001
DEFINE l_pmao008         LIKE pmao_t.pmao008
DEFINE l_tot_qty         LIKE psib_t.psib011
#DEFINE l_cal_tolerance   LIKE psib_t.psib011

   LET r_success = TRUE
  
   IF g_psib[l_ac].psib011 > p_qty THEN
      LET l_psib011 = p_qty
   ELSE
      LET l_psib011 = g_psib[l_ac].psib011 
   END IF
   
   LET l_psib003 = NULL
   SELECT imaf153 INTO l_psib003 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = g_psib[l_ac].psib006
   IF SQLCA.sqlcode OR cl_null(l_psib003) THEN
      #160819-00015#2-s-mod
      #LET r_success = FALSE
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'aps-00116'
      #LET g_errparam.extend = g_psib[l_ac].psib006
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      
      #RETURN r_success
      LET l_psib003 = "NONE"
      #160819-00015#2-e-mod
   END IF
   
   #160819-00015#2-s-mark
   ##考慮採購批量、最小採購量
   #CALL apsp350_cal_psib011(g_psib[l_ac].psib006,l_psib011,g_psib[l_ac].psib012)
   #     RETURNING r_success,l_psib011
   #IF NOT r_success THEN
   #   RETURN r_success
   #END IF
   #160819-00015#2-e-mark 
   
   #160819-00015#2-s-mod 多psib013
   #INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012)
   #   VALUES (l_psib003,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
   #           g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012)
   INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
      VALUES (l_psib003,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
              g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
              g_psib[l_ac].psib011_i)
   #160819-00015#2-e-mod
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apsp350_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET l_margin = g_psib[l_ac].psib011 - l_psib011
   IF l_margin <= 0 THEN
      RETURN r_success
   END IF
   
   #先算出該料的總比率
   LET l_pmao008_sum = 0
   
   #160819-00015#2-s-mod  pmao_t換抓pmat_t
   #SELECT SUM(pmao008) INTO l_pmao008_sum FROM pmao_t,pmaa_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = g_psib[l_ac].psib006
   #   AND NVL(pmao003,' ') = NVL(g_psib[l_ac].psib007,' ')
   #   AND pmaaent = pmaoent
   #   AND pmaa001 = pmao001
   #   AND pmaa002 IN ('1','3')
   #IF cl_null(l_pmao008_sum) OR l_pmao008_sum = 0 THEN
   #   LET r_success = FALSE
   #   INITIALIZE g_errparam TO NULL
   #   #LET g_errparam.code = 'aps-00117'  #160819-00015#2-s-mod
   #   LET g_errparam.code = 'aps-00195'   #160819-00015#2-e-mod
   #   LET g_errparam.extend = g_psib[l_ac].psib006,'+',g_psib[l_ac].psib007
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   
   #   RETURN r_success
   #END IF
   
   #依各供應商的分配比率進行分配
   #LET l_sql = "SELECT pmao001,pmao008 FROM pmao_t,pmaa_t ",
   #            " WHERE pmaoent = ",g_enterprise,
   #            "   AND pmao002 = '",g_psib[l_ac].psib006,"'",
   #            "   AND NVL(pmao003,' ') = NVL('",g_psib[l_ac].psib007,"',' ')",
   #            "   AND pmaaent = pmaoent ",
   #            "   AND pmaa001 = pmao001 ",
   #            "   AND pmaa002 IN ('1','3') ",
   #            " ORDER BY pmao008 DESC"
   SELECT SUM(pmat004) INTO l_pmao008_sum FROM pmat_t,pmaa_t
    WHERE pmatent = g_enterprise
      AND pmatsite = g_site
      AND pmat002 = g_psib[l_ac].psib006
      AND COALESCE(pmat003,' ') = COALESCE(g_psib[l_ac].psib007,' ')
      AND pmatent = pmaaent
      AND pmat001 = pmaa001
      AND pmaa002 IN ('1','3')
      AND pmatstus = 'Y'

   IF cl_null(l_pmao008_sum) OR l_pmao008_sum = 0 THEN
      #沒有比率的直接給一個虛擬的供應商
      LET l_pmao001 = 'NONE'
      INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
         VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
                 g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_margin,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
                 g_psib[l_ac].psib011_i)
                 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apsp350_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success 
      END IF
      RETURN r_success
   END IF
   
   #依各供應商的分配比率進行分配
   LET l_sql = "SELECT pmat001,pmat004 FROM pmat_t,pmaa_t ",
               " WHERE pmatent = '",g_enterprise,"'",
               "   AND pmatsite = '",g_site,"'",
               "   AND pmat002 = '",g_psib[l_ac].psib006,"'",
               "   AND COALESCE(pmat003,' ') = COALESCE('",g_psib[l_ac].psib007,"',' ') ",
               "   AND pmatent = pmaaent ",
               "   AND pmat001 = pmaa001 ",
               "   AND pmaa002 IN ('1','3') ",
               "   AND pmatstus = 'Y' ",
               " ORDER BY pmat004 DESC "
   #160819-00015#2-e-mod
   PREPARE apsp350_pmao_pre1 FROM l_sql
   DECLARE apsp350_pmao_cs1 CURSOR FOR apsp350_pmao_pre1
   
   LET l_tot_qty = 0
   FOREACH apsp350_pmao_cs1 INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_pmao_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #依比率分配
      LET l_psib011 = l_margin * l_pmao008 / l_pmao008_sum
      
      #若剩餘數量小於分配數量，則採購量=剩餘數量
      IF (l_margin - l_tot_qty) < l_psib011 THEN 
         LET l_psib011 = l_margin - l_tot_qty
      END IF
      
      #160819-00015#2-s-mark
      ##考慮採購批量、最小採購量
      #CALL apsp350_cal_psib011(g_psib[l_ac].psib006,l_psib011,g_psib[l_ac].psib012)
      #     RETURNING r_success,l_psib011
      #IF NOT r_success THEN
      #   EXIT FOREACH
      #END IF
      #160819-00015#2-e-mark
      LET l_tot_qty = l_tot_qty + l_psib011
      
      #160819-00015#2-s-add  多psib013
      #INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012)
      #   VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
      #           g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012)
      INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
         VALUES (l_pmao001,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
                 g_psib[l_ac].psib009,g_psib[l_ac].psib010,l_psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
                 g_psib[l_ac].psib011_i)
      #160819-00015#2-e-add
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apsp350_tmp'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      #總採購數量 >= 原採購數量，則不用再分配
      IF l_tot_qty >= l_margin THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
#   #尾差，歸屬最後一筆供應商
#   LET l_cal_tolerance = l_tot_qty - g_psib[l_ac].psib011
#   IF l_cal_tolerance  != 0 THEN
#      LET l_psib011 = l_psib011 - l_cal_tolerance
#      IF l_psib011 > 0 THEN
#         CALL apsp350_cal_psib011(g_psib[l_ac].psib006,l_psib011,g_psib[l_ac].psib012)
#              RETURNING r_success,l_psib011
#         IF NOT r_success THEN
#            RETURN r_success
#         END IF
#      END IF
#      
#      UPDATE apsp350_tmp SET psib011 = psib011 - l_psib011
#       WHERE psib003 = l_pmao001 
#         AND psib004 = g_psib004
#         AND psib006 = g_psib[l_ac].psib006
#         AND psib007 = g_psib[l_ac].psib007
#         AND psib008 = g_psib[l_ac].psib008
#         AND psib009 = g_psib[l_ac].psib009
#         AND psib010 = g_psib[l_ac].psib010
#         AND psib012 = g_psib[l_ac].psib012
#      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#         LET r_success = FALSE
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'upd apsp350_tmp'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#  
#      END IF
#   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 指定單一供應商
# Memo...........:
# Usage..........: CALL apsp350_apportion_3()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_apportion_3()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   #160819-00015#2-s-mark
   ##考慮採購批量、最小採購量
   #CALL apsp350_cal_psib011(g_psib[l_ac].psib006,g_psib[l_ac].psib011,g_psib[l_ac].psib012)
   #     RETURNING r_success,g_psib[l_ac].psib011
   #IF NOT r_success THEN
   #   RETURN r_success
   #END IF
   ##160819-00015#2-e-mark
   
   #160819-00015#2-s-mod 多psib013
   #INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012)
   #   VALUES (g_psja.psja007,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
   #           g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012)
   INSERT INTO apsp350_tmp(psib003,psib004,psib006,psib007,psib008,psib009,psib010,psib011,psib012,psib013,psib011_i)
      VALUES (g_psja.psja007,g_psib004,g_psib[l_ac].psib006,g_psib[l_ac].psib007,g_psib[l_ac].psib008,
              g_psib[l_ac].psib009,g_psib[l_ac].psib010,g_psib[l_ac].psib011,g_psib[l_ac].psib012,g_psib[l_ac].psib013,
              g_psib[l_ac].psib011_i)
   #160819-00015#2-e-mod           
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apsp350_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增採購預測資料
# Memo...........:
# Usage..........: CALL apsp350_ins_data()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/07/22 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_ins_data()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_psia003         LIKE psia_t.psia003
DEFINE l_psia004         LIKE psia_t.psia004
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psia            RECORD LIKE psia_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psia            RECORD  #採購預測單頭檔
       psiaent LIKE psia_t.psiaent, #企業編號
       psiasite LIKE psia_t.psiasite, #營運據點
       psia001 LIKE psia_t.psia001, #預測編號
       psia002 LIKE psia_t.psia002, #預測起始日期
       psia003 LIKE psia_t.psia003, #供應商
       psia004 LIKE psia_t.psia004, #計畫員
       psia005 LIKE psia_t.psia005, #版本
       psiaownid LIKE psia_t.psiaownid, #資料所有者
       psiaowndp LIKE psia_t.psiaowndp, #資料所屬部門
       psiacrtid LIKE psia_t.psiacrtid, #資料建立者
       psiacrtdp LIKE psia_t.psiacrtdp, #資料建立部門
       psiacrtdt LIKE psia_t.psiacrtdt, #資料創建日
       psiamodid LIKE psia_t.psiamodid, #資料修改者
       psiamoddt LIKE psia_t.psiamoddt, #最近修改日
       psiacnfid LIKE psia_t.psiacnfid, #資料確認者
       psiacnfdt LIKE psia_t.psiacnfdt, #資料確認日
      #psiastus LIKE psia_t.psiastus  #狀態碼 #161109-00085#61 mark
       #161109-00085#61 --s add
       psiastus LIKE psia_t.psiastus, #狀態碼
       psiaud001 LIKE psia_t.psiaud001, #自定義欄位(文字)001
       psiaud002 LIKE psia_t.psiaud002, #自定義欄位(文字)002
       psiaud003 LIKE psia_t.psiaud003, #自定義欄位(文字)003
       psiaud004 LIKE psia_t.psiaud004, #自定義欄位(文字)004
       psiaud005 LIKE psia_t.psiaud005, #自定義欄位(文字)005
       psiaud006 LIKE psia_t.psiaud006, #自定義欄位(文字)006
       psiaud007 LIKE psia_t.psiaud007, #自定義欄位(文字)007
       psiaud008 LIKE psia_t.psiaud008, #自定義欄位(文字)008
       psiaud009 LIKE psia_t.psiaud009, #自定義欄位(文字)009
       psiaud010 LIKE psia_t.psiaud010, #自定義欄位(文字)010
       psiaud011 LIKE psia_t.psiaud011, #自定義欄位(數字)011
       psiaud012 LIKE psia_t.psiaud012, #自定義欄位(數字)012
       psiaud013 LIKE psia_t.psiaud013, #自定義欄位(數字)013
       psiaud014 LIKE psia_t.psiaud014, #自定義欄位(數字)014
       psiaud015 LIKE psia_t.psiaud015, #自定義欄位(數字)015
       psiaud016 LIKE psia_t.psiaud016, #自定義欄位(數字)016
       psiaud017 LIKE psia_t.psiaud017, #自定義欄位(數字)017
       psiaud018 LIKE psia_t.psiaud018, #自定義欄位(數字)018
       psiaud019 LIKE psia_t.psiaud019, #自定義欄位(數字)019
       psiaud020 LIKE psia_t.psiaud020, #自定義欄位(數字)020
       psiaud021 LIKE psia_t.psiaud021, #自定義欄位(日期時間)021
       psiaud022 LIKE psia_t.psiaud022, #自定義欄位(日期時間)022
       psiaud023 LIKE psia_t.psiaud023, #自定義欄位(日期時間)023
       psiaud024 LIKE psia_t.psiaud024, #自定義欄位(日期時間)024
       psiaud025 LIKE psia_t.psiaud025, #自定義欄位(日期時間)025
       psiaud026 LIKE psia_t.psiaud026, #自定義欄位(日期時間)026
       psiaud027 LIKE psia_t.psiaud027, #自定義欄位(日期時間)027
       psiaud028 LIKE psia_t.psiaud028, #自定義欄位(日期時間)028
       psiaud029 LIKE psia_t.psiaud029, #自定義欄位(日期時間)029
       psiaud030 LIKE psia_t.psiaud030  #自定義欄位(日期時間)030
       #161109-00085#61 --e add
          END RECORD
#mod--161109-00085#16 By 08993--(e)

#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psib            RECORD LIKE psib_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psib            RECORD  #採購預測單身檔
       psibent LIKE psib_t.psibent, #企業編號
       psibsite LIKE psib_t.psibsite, #營運據點
       psib001 LIKE psib_t.psib001, #預測編號
       psib002 LIKE psib_t.psib002, #預測起始日期
       psib003 LIKE psib_t.psib003, #供應商
       psib004 LIKE psib_t.psib004, #計畫員
       psib005 LIKE psib_t.psib005, #版本
       psib006 LIKE psib_t.psib006, #料件編號
       psib007 LIKE psib_t.psib007, #產品特徵
       psib008 LIKE psib_t.psib008, #期別
       psib009 LIKE psib_t.psib009, #起始日期
       psib010 LIKE psib_t.psib010, #截止日期
       psib011 LIKE psib_t.psib011, #數量
       psib012 LIKE psib_t.psib012, #單位
       #161109-00085#61 --s add
       psibud001 LIKE psib_t.psibud001, #自定義欄位(文字)001
       psibud002 LIKE psib_t.psibud002, #自定義欄位(文字)002
       psibud003 LIKE psib_t.psibud003, #自定義欄位(文字)003
       psibud004 LIKE psib_t.psibud004, #自定義欄位(文字)004
       psibud005 LIKE psib_t.psibud005, #自定義欄位(文字)005
       psibud006 LIKE psib_t.psibud006, #自定義欄位(文字)006
       psibud007 LIKE psib_t.psibud007, #自定義欄位(文字)007
       psibud008 LIKE psib_t.psibud008, #自定義欄位(文字)008
       psibud009 LIKE psib_t.psibud009, #自定義欄位(文字)009
       psibud010 LIKE psib_t.psibud010, #自定義欄位(文字)010
       psibud011 LIKE psib_t.psibud011, #自定義欄位(數字)011
       psibud012 LIKE psib_t.psibud012, #自定義欄位(數字)012
       psibud013 LIKE psib_t.psibud013, #自定義欄位(數字)013
       psibud014 LIKE psib_t.psibud014, #自定義欄位(數字)014
       psibud015 LIKE psib_t.psibud015, #自定義欄位(數字)015
       psibud016 LIKE psib_t.psibud016, #自定義欄位(數字)016
       psibud017 LIKE psib_t.psibud017, #自定義欄位(數字)017
       psibud018 LIKE psib_t.psibud018, #自定義欄位(數字)018
       psibud019 LIKE psib_t.psibud019, #自定義欄位(數字)019
       psibud020 LIKE psib_t.psibud020, #自定義欄位(數字)020
       psibud021 LIKE psib_t.psibud021, #自定義欄位(日期時間)021
       psibud022 LIKE psib_t.psibud022, #自定義欄位(日期時間)022
       psibud023 LIKE psib_t.psibud023, #自定義欄位(日期時間)023
       psibud024 LIKE psib_t.psibud024, #自定義欄位(日期時間)024
       psibud025 LIKE psib_t.psibud025, #自定義欄位(日期時間)025
       psibud026 LIKE psib_t.psibud026, #自定義欄位(日期時間)026
       psibud027 LIKE psib_t.psibud027, #自定義欄位(日期時間)027
       psibud028 LIKE psib_t.psibud028, #自定義欄位(日期時間)028
       psibud029 LIKE psib_t.psibud029, #自定義欄位(日期時間)029
       psibud030 LIKE psib_t.psibud030, #自定義欄位(日期時間)030
       #161109-00085#61 --e add
       psib013 LIKE psib_t.psib013  #保稅否
          END RECORD
#mod--161109-00085#16 By 08993--(e)

DEFINE l_current         DATETIME YEAR TO SECOND
DEFINE l_i               LIKE type_t.num5
DEFINE l_all_zero        LIKE type_t.num5
#160819-00015#2-s-add
DEFINE l_msg             STRING
DEFINE l_msg1            STRING
DEFINE l_msg2            STRING
DEFINE l_success         LIKE type_t.num5  
DEFINE l_psiastus        LIKE psia_t.psiastus
DEFINE l_psia005_max     LIKE psia_t.psia005
DEFINE l_psic006         LIKE psic_t.psic006
DEFINE l_psic007         LIKE psic_t.psic007
DEFINE l_psic012         LIKE psic_t.psic012
DEFINE l_psic013         LIKE psic_t.psic013
#160819-00015#2-e-add

   LET r_success = TRUE
   
   LET l_sql = "SELECT DISTINCT psib003,psib004 ",
               "  FROM apsp350_tmp ",
               " ORDER BY psib003,psib004 "
   PREPARE apsp350_tmp_group_pre FROM l_sql
   DECLARE apsp350_tmp_group_cs CURSOR FOR apsp350_tmp_group_pre
   
   #為了沒有該期資料時，要新增一筆數量=0的資料
   #160819-00015#2-s-add
   #LET l_sql = "SELECT DISTINCT psib006,psib007 ",
   #            "  FROM apsp350_tmp ",
   #            " WHERE psib003 = ? ",
   #            "   AND psib004 = ? ",
   #            " ORDER BY psib006,psib007 "
   LET l_sql = "SELECT DISTINCT psib006,psib007,psib012,psib013 ",
               "  FROM apsp350_tmp ",
               " WHERE psib003 = ? ",
               "   AND psib004 = ? ",
               " ORDER BY psib006,psib007 "
   #160819-00015#2-e-add
   PREPARE apsp350_tmp_item_pre FROM l_sql
   DECLARE apsp350_tmp_item_cs CURSOR FOR apsp350_tmp_item_pre
   
   #160819-00015#2-s-mod
   #LET l_sql = "SELECT psib009,psib010,psib011,psib012 ",
   #            "  FROM apsp350_tmp ",
   #            " WHERE psib003 = ? ",
   #            "   AND psib004 = ? ",
   #            "   AND psib006 = ? ",
   #            "   AND psib007 = ? ",
   #            "   AND psib008 = ? "
   LET l_sql = "SELECT psib009,psib010,SUM(psib011) ",
               "  FROM apsp350_tmp ",
               " WHERE psib003 = ? ",
               "   AND psib004 = ? ",
               "   AND psib006 = ? ",
               "   AND COALESCE(psib007,' ') = ? ",
               "   AND psib008 = ? ",
               "   AND psib013 = ? ",
               " GROUP BY psib009,psib010 "
   #160819-00015#2-e-mod
   PREPARE apsp350_tmp_pre FROM l_sql
   DECLARE apsp350_tmp_cs CURSOR FOR apsp350_tmp_pre
   
   #160819-00015#2-s-add
   #預測編號+預測起始日期,判斷是否有其他未確認的版本
   LET l_psia005_max = 0
   SELECT TO_NUMBER(psia005),psiastus INTO l_psia005_max,l_psiastus 
    FROM psia_t
    WHERE psiaent  = g_enterprise
      AND psiasite = g_site
      AND psia001  = g_master.psja001
      AND psia002  = g_master.psoz004
      AND ROWNUM   = 1
      AND psia005  = (SELECT MAX(TO_NUMBER(psia005)) FROM psia_t
                       WHERE psiaent  = g_enterprise
                         AND psiasite = g_site
                         AND psia001  = g_master.psja001
                         AND psia002  = g_master.psoz004)
      ORDER BY psiastus DESC
   
   IF cl_null(l_psia005_max) OR l_psia005_max=0 THEN
      LET l_psia005_max = 1
   ELSE
      IF l_psiastus = 'N' THEN
         #有未確認的版本，是否要刪掉，並重新產生？
         IF cl_ask_confirm("aps-00196") THEN 
            CALL apsp350_del_apt350(g_master.psja001,g_master.psoz004,l_psia005_max)
               RETURNING r_success
            IF NOT r_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            LET l_psia005_max = l_psia005_max - 1
         END IF
      END IF
      LET l_psia005_max = l_psia005_max + 1
   END IF
   LET l_psia005_max = l_psia005_max USING '<<<<<'
   #160819-00015#2-e-add
   
   #新增採購預測單頭檔(psia_t)
   FOREACH apsp350_tmp_group_cs INTO l_psia003,l_psia004
      
      INITIALIZE l_psia.* TO NULL
      LET l_psia.psiaent = g_enterprise
      LET l_psia.psiasite= g_site
      LET l_psia.psia001 = g_master.psja001
      LET l_psia.psia002 = g_master.psoz004
      LET l_psia.psia003 = l_psia003
      LET l_psia.psia004 = l_psia004
      LET l_psia.psia005 = l_psia005_max      #160819-00015#2-add
      IF l_psia.psia004 IS NULL THEN
         LET l_psia.psia004 = ' '
      END IF
      
      #160819-00015#2-s-mark 
      #SELECT MAX(psia005)+1 INTO l_psia.psia005 FROM psia_t
      # WHERE psiaent = l_psia.psiaent
      #   AND psiasite= l_psia.psiasite
      #   AND psia001 = l_psia.psia001
      #   AND psia002 = l_psia.psia002
      #   AND psia003 = l_psia.psia003
      #   AND psia004 = l_psia.psia004
      #IF cl_null(l_psia.psia005) THEN
      #   LET l_psia.psia005 = 1
      #END IF
      
      #LET l_psia.psia005 = l_psia.psia005 USING '<<<<<'
      #160819-00015#2-e-mark
      LET l_psia.psiaownid = g_user
      LET l_psia.psiaowndp = g_dept
      LET l_psia.psiacrtid = g_user
      LET l_psia.psiacrtdp = g_dept
      LET l_current = cl_get_current()
      LET l_psia.psiastus = 'N'
      
      INSERT INTO psia_t(psiaent,psiasite,psia001,psia002,psia003,psia004,psia005,
                         psiaownid,psiaowndp,psiacrtid,psiacrtdp,psiacrtdt,psiamodid,psiamoddt,
                         psiacnfid,psiacnfdt,psiastus)
         VALUES(l_psia.psiaent,l_psia.psiasite,
                l_psia.psia001,l_psia.psia002,l_psia.psia003,l_psia.psia004,l_psia.psia005,
                l_psia.psiaownid,l_psia.psiaowndp,l_psia.psiacrtid,l_psia.psiacrtdp,l_current,
                l_psia.psiamodid,l_psia.psiamoddt,l_psia.psiacnfid,l_psia.psiacnfdt,l_psia.psiastus)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins psia_t"
         LET g_errparam.popup = TRUE
         
         EXIT FOREACH
      END IF
      
      #新增採購預測單身檔(psib_t)
      INITIALIZE l_psib.* TO NULL
      LET l_psib.psibent = l_psia.psiaent
      LET l_psib.psibsite= l_psia.psiasite
      LET l_psib.psib001 = l_psia.psia001
      LET l_psib.psib002 = l_psia.psia002
      LET l_psib.psib003 = l_psia.psia003
      LET l_psib.psib004 = l_psia.psia004
      LET l_psib.psib005 = l_psia.psia005
      
      #160819-00015#2-s-mod
      #FOREACH apsp350_tmp_item_cs USING l_psia003,l_psia004 INTO l_psib.psib006,l_psib.psib007
      FOREACH apsp350_tmp_item_cs USING l_psia003,l_psia004 INTO l_psib.psib006,l_psib.psib007,l_psib.psib012,l_psib.psib013
      #160819-00015#2-e-mod
      
         #160819-00015#2-s-add
         IF l_psib.psib007 IS NULL THEN
            LET l_psib.psib007 = ' '
         END IF
         CALL apsp350_ins_psic(l_psib.psib001,l_psib.psib002,l_psib.psib003,l_psib.psib004,l_psib.psib005,
                               l_psib.psib006,l_psib.psib007,l_psib.psib012,l_psib.psib013)  RETURNING r_success
         IF NOT r_success THEN
            EXIT FOREACH
         END IF
         #160819-00015#2-e-add
         LET l_all_zero = TRUE
         #FOR l_i = 1 TO g_psja.psja002    #160819-00015#2-s-mod
         FOR l_i = 1 TO g_psja.psja002+1   #160819-00015#2-e-mod (N+1期)
         
            LET l_psib.psib008 = l_i
            #160819-00015#2-s-add
            LET l_psib.psib009 = ''
            LET l_psib.psib010 = ''
            LET l_psib.psib011 = 0
            #160819-00015#2-e-add
            
            #160819-00015#2-s-mod
            #OPEN apsp350_tmp_cs USING l_psia003,l_psia004,l_psib.psib006,l_psib.psib007,l_psib.psib008                
            #FETCH apsp350_tmp_cs INTO l_psib.psib009,l_psib.psib010,l_psib.psib011,l_psib.psib012
            OPEN apsp350_tmp_cs USING l_psia003,l_psia004,l_psib.psib006,l_psib.psib007,l_psib.psib008,l_psib.psib013  
            FETCH apsp350_tmp_cs INTO l_psib.psib009,l_psib.psib010,l_psib.psib011
            #160819-00015#2-e-mod
            
            IF SQLCA.sqlcode = 100 THEN
               SELECT bdate,edate INTO l_psib.psib009,l_psib.psib010
                 FROM apsp350_tmp01        #160727-00019#15 Mod   apsp350_period_tmp -->apsp350_tmp01
                WHERE period = l_psib.psib008
               
               #160819-00015#2-s-add #沒有日期的話，抓前一期的截止日+1              
               IF cl_null(l_psib.psib009) THEN
                  SELECT edate+1 INTO l_psib.psib009
                    FROM apsp350_tmp01       
                   WHERE period = l_psib.psib008-1
               END IF
               #160819-00015#2-e-add
               
               LET l_psib.psib011 = 0
               
               SELECT imaf143 INTO l_psib.psib012 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imafsite= g_site
                  AND imaf001 = l_psib.psib006
            ELSE
               IF l_psib.psib011 <> 0 THEN
                  LET l_all_zero = FALSE
               END IF
            END IF
            CLOSE apsp350_tmp_cs
            
            CALL s_aooi250_take_decimals(l_psib.psib012,l_psib.psib011)  RETURNING l_success,l_psib.psib011  #160819-00015#2-add
            #160819-00015#2-s-mod  多加psib013
            #INSERT INTO psib_t(psibent,psibsite,
            #                   psib001,psib002,psib003,psib004,psib005,psib006,psib007,psib008,psib009,psib010,
            #                   psib011,psib012)
            #   VALUES(l_psib.psibent,l_psib.psibsite,
            #          l_psib.psib001,l_psib.psib002,l_psib.psib003,l_psib.psib004,l_psib.psib005,
            #          l_psib.psib006,l_psib.psib007,l_psib.psib008,l_psib.psib009,l_psib.psib010,
            #          l_psib.psib011,l_psib.psib012)
            INSERT INTO psib_t(psibent,psibsite,
                               psib001,psib002,psib003,psib004,psib005,psib006,psib007,psib008,psib009,psib010,
                               psib011,psib012,psib013)
               VALUES(l_psib.psibent,l_psib.psibsite,
                      l_psib.psib001,l_psib.psib002,l_psib.psib003,l_psib.psib004,l_psib.psib005,
                      l_psib.psib006,l_psib.psib007,l_psib.psib008,l_psib.psib009,l_psib.psib010,
                      l_psib.psib011,l_psib.psib012,l_psib.psib013)
            #160819-00015#2-e-mod
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ins psib_t"
               LET g_errparam.popup = TRUE
               
               EXIT FOR
            END IF
         END FOR
         
         IF l_all_zero THEN
            DELETE FROM psib_t
             WHERE psibent = l_psib.psibent
               AND psibsite= l_psib.psibsite
               AND psib001 = l_psib.psib001
               AND psib002 = l_psib.psib002
               AND psib003 = l_psib.psib003
               AND psib004 = l_psib.psib004
               AND psib005 = l_psib.psib005
               AND psib006 = l_psib.psib006
               AND psib007 = l_psib.psib007
               AND psib013 = l_psib.psib013  #160819-00015#2-add
            #160819-00015#2-s-add
            #刪除pisc_t資料
            DELETE FROM psic_t
             WHERE psicent = l_psib.psibent  AND psicsite = l_psib.psibsite
               AND psic001 = l_psib.psib001  AND psic002  = l_psib.psib002
               AND psic003 = l_psib.psib003  AND psic004  = l_psib.psib004
               AND psic005 = l_psib.psib005  AND psic006  = l_psib.psib006
               AND psic007 = l_psib.psib007  AND psic008  = l_psib.psib013
            #160819-00015#2-e-add
         END IF
         IF NOT r_success THEN
            EXIT FOREACH
         END IF
      END FOREACH

      IF NOT r_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
   #160819-00015#2-s-add
   IF r_success AND g_master.l_chk = 'Y' THEN
      CALL apsp350_diff_data(l_psia005_max) RETURNING r_success
   END IF
   #--刪除多產生的單頭
   IF r_success THEN
      CALL apsp350_del_psia(l_psia005_max) RETURNING r_success
   END IF
   #160819-00015#2-e-add
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 考慮採購批量、最小採購量
# Memo...........:
# Usage..........: CALL apsp350_cal_psib011(p_psib006,p_psib011,p_psib012)
#                  RETURNING r_success,r_psib011
# Input parameter: p_psib006      料號
#                : p_psib011      數量
#                : p_psib012      單位
# Return code....: r_success      TRUE/FALSE
#                : r_psib011      數量
# Date & Author..: 2014/09/26 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_cal_psib011(p_psib006,p_psib011,p_psib012)
DEFINE p_psib006         LIKE psib_t.psib006
DEFINE p_psib011         LIKE psib_t.psib011
DEFINE p_psib012         LIKE psib_t.psib012
DEFINE r_success         LIKE type_t.num5
DEFINE r_psib011         LIKE psib_t.psib011
DEFINE l_imaf145         LIKE imaf_t.imaf145
DEFINE l_imaf146         LIKE imaf_t.imaf146
DEFINE l_carry           LIKE psib_t.psib011
DEFINE l_product         LIKE type_t.num5

   LET r_success = TRUE
   LET r_psib011 = 0
   
   #傳入料號不可為空
   IF cl_null(p_psib006) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00411'
      LET g_errparam.extend = p_psib006
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success,r_psib011
   END IF
   
   #傳入數量不可為空
   IF cl_null(p_psib011) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00516'
      LET g_errparam.extend = p_psib006
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success,r_psib011
   END IF
   
   #對數量進行取位
   CALL s_aooi250_take_decimals(p_psib012,p_psib011)
        RETURNING r_success,p_psib011
   IF p_psib011 = 0 THEN
      LET r_psib011 = p_psib011
      
      RETURN r_success,r_psib011
   END IF
   
   #採購單位批量、最小採購量
   LET l_imaf145 = ''
   LET l_imaf146 = ''
   SELECT imaf145,imaf146 INTO l_imaf145,l_imaf146 
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = p_psib006
   CASE 
      WHEN l_imaf145 = 0 AND l_imaf146 = 0   #都不控管
           LET r_psib011 = p_psib011
      WHEN l_imaf145 = 0 AND l_imaf146 > 0   #只控管最小採購量
           IF p_psib011 > l_imaf146 THEN
              LET r_psib011 = p_psib011
           ELSE
              LET r_psib011 = l_imaf146
           END IF
      WHEN l_imaf145 > 0 AND l_imaf146 = 0   #只控管採購批量
           CALL s_num_round('4',p_psib011/l_imaf145,0)
                RETURNING l_product
           LET r_psib011 = l_imaf145 * l_product
      WHEN l_imaf145 > 0 AND l_imaf146 > 0   #控管採購批量、最小採購量
           #依採購批量、最小採購量去計算最小採購量
           CALL s_num_round('4',l_imaf146/l_imaf145,0)
                RETURNING l_product
           LET l_carry = l_imaf145 * l_product
           
           #計算採購量
           IF p_psib011 <= l_carry THEN
              LET r_psib011 = l_carry
           ELSE
              LET l_product = 0
              CALL s_num_round('4',p_psib011/l_imaf145,0)
                   RETURNING l_product
              LET r_psib011 = l_imaf145 * l_product
           END IF
            
           #計算完後再對數量進行取位
           CALL s_aooi250_take_decimals(p_psib012,r_psib011)
                RETURNING r_success,r_psib011
   END CASE
   
   RETURN r_success,r_psib011
   
END FUNCTION

################################################################################
# Descriptions...: 預測編號說明
# Memo...........:
# Usage..........: CALL apsp350_psja001_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/09/29 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_psja001_ref()
DEFINE l_psjal003        LIKE psjal_t.psjal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.psja001
   CALL ap_ref_array2(g_ref_fields,"SELECT psjal003 FROM psjal_t WHERE psjalent = '"||g_enterprise||"' AND psjalsite = '"||g_site||"' AND psjal001 = ? AND psjal002 = '"||g_dlang||"'","")
        RETURNING g_rtn_fields
   LET l_psjal003 = '', g_rtn_fields[1] , ''
   
   DISPLAY l_psjal003 TO psja001_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查預測起始日期(apsp350)是否與預測起始日(apsi350)一致
# Memo...........:
# Usage..........: CALL apsp350_psoz004_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 20160823 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_psoz004_chk()
   DEFINE  l_psja003   LIKE  psja_t.psja003  #預測起始日
   DEFINE  l_psja009   LIKE  psja_t.psja009  #預測起始日指定方式
   DEFINE  l_psoz004   LIKE  psoz_t.psoz004  #調整過後的，預測起始日
   DEFINE  l_monday    LIKE  psoz_t.psoz004  #周一的日期
   DEFINE  l_day       LIKE  psja_t.psja003
   DEFINE  l_msg       STRING
   DEFINE  l_msg1      STRING
   DEFINE  r_success   LIKE  type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_master.psja001) AND NOT cl_null(g_master.psoz004) THEN
      #抓取預測起始日、預測起始日指定方式
      SELECT psja003,psja009 INTO l_psja003,l_psja009
        FROM psja_t
       WHERE psjaent = g_enterprise
         AND psjasite = g_site
         AND psja001 = g_master.psja001
      #起始日指定方式
      CASE l_psja009
         WHEN '1'  #指定日
            LET l_day = DAY(g_master.psoz004) #取得起始日 
            IF l_psja003 <> l_day THEN
               CALL cl_getmsg('axm-00247',g_dlang) RETURNING l_msg  #該預測代號的預測起始日期是：
               LET l_msg = l_msg CLIPPED,l_psja003
               LET l_psoz004 = MDY(MONTH(g_master.psoz004),l_psja003,YEAR(g_master.psoz004))
               LET r_success = FALSE
            END IF
          
         WHEN '2'  #指定週間
            CALL s_date_get_monday(g_master.psoz004) RETURNING l_monday  #取得傳入日期當周的星期一日期
            CASE l_psja003
               WHEN '0' #週日
                  LET l_monday = l_monday - 1
               WHEN '2' #周二
                  LET l_monday = l_monday + 1
               WHEN '3' #周三
                  LET l_monday = l_monday + 2
               WHEN '4' #周四
                  LET l_monday = l_monday + 3
               WHEN '5' #周五
                  LET l_monday = l_monday + 4
               WHEN '6' #周六
                  LET l_monday = l_monday + 5
            END CASE      
            IF l_monday <> g_master.psoz004 THEN
               CALL cl_getmsg('axm-00414',g_dlang) RETURNING l_msg  #該預測代號的預測周間是：
               LET l_msg = l_msg CLIPPED,l_psja003
               LET l_psoz004 = l_monday
               LET r_success = FALSE
            END IF
      END CASE
      #提示訊息
      IF NOT r_success THEN
         LET l_msg1 = cl_getmsg('aps-00194',g_dlang)  #起始日期的起始日需與採購預測編號的起始日一致！
         LET l_msg1 = l_msg1 CLIPPED,"\n",l_msg       #該預測代號的預測起始日期是：  或是    #該預測代號的預測周間是：
         LET l_msg1 = l_msg1 CLIPPED,"\n",cl_getmsg_parm('aps-00193',g_dlang,l_psoz004)   #預測起始日期將變為：%1
         CALL cl_ask_confirm3("",l_msg1)
         LET g_master.psoz004 = l_psoz004
         DISPLAY BY NAME g_master.psoz004
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得採購單or收貨單的供應商
# Memo...........:
# Usage..........: CALL apsp350_get_psia003(p_psph010)
#                  RETURNING r_psia003
# Input parameter: p_psph010      供給單號
# Return code....: r_psia003      供應商
# Date & Author..: 2016/08/24 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_get_psia003(p_psph010)
   DEFINE  p_psph010   LIKE  psph_t.psph010
   DEFINE  r_psia003   LIKE  psia_t.psia003
   
   SELECT pmdl004 INTO r_psia003
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdlsiet = g_site
      AND pmdldocno = p_psph010
   
   RETURN r_psia003
END FUNCTION

################################################################################
# Descriptions...: 抓採購結果檔中的保稅否
# Memo...........:
# Usage..........: CALL apsp350_get_psib013(p_psph016,p_psph010,p_psph038,p_psph039,p_psph024)
#                  RETURNING r_psib013
# Input parameter: p_psph016      供給類型
#                : p_psph010      供給單號
#                : p_psph038      料件編號
#                : p_psph039      產品特徵
#                : p_psph024      庫位
# Return code....: r_psib013      保稅否
# Date & Author..: 2016/08/24 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_get_psib013(p_psph016,p_psph010,p_psph038,p_psph039,p_psph024)
   DEFINE  p_psph016  LIKE psph_t.psph016
   DEFINE  p_psph010  LIKE psph_t.psph010
   DEFINE  p_psph038  LIKE psph_t.psph038
   DEFINE  p_psph039  LIKE psph_t.psph039
   DEFINE  p_psph024  LIKE psph_t.psph024
   DEFINE  r_psib013  LIKE psib_t.psib013
   
   LET r_psib013 = ''

   IF p_psph016 = 'I' THEN
      #dorislai-20160908-mod-(S)
      #SELECT inaa015 INTO r_psib013 FROM inaa_t
      # WHERE inaaent  = g_enterprise
      #   AND inaasite = g_site
      #   AND inaa001  = p_psph024
      SELECT pspt015 INTO r_psib013 FROM pspt_t
       WHERE psptent = g_enterprise
         AND psptsite = g_site
         AND pspt001 = g_psja.psja004
         AND pspt002 = g_psoz002
         AND pspt011 = p_psph038
         AND COALESCE(pspt012,' ') = COALESCE(p_psph039,' ')
         AND pspt005 = p_psph024
         AND ROWNUM = 1
      #dorislai-20160908-mod-(E)
   ELSE
      SELECT pspc062 INTO r_psib013 FROM pspc_t
       WHERE pspcent = g_enterprise
         AND pspcsite = g_site
         AND pspc001 = g_psja.psja004
         AND pspc002 = g_psoz002  
         AND pspc004 = p_psph010  #採購單編號
   END IF   
   
   RETURN r_psib013
   
END FUNCTION

################################################################################
# Descriptions...: 判斷供給類型P，其供給單號是哪個單據的
#                : 採購單or收貨單，需回抓單上的供應商
# Memo...........:
# Usage..........: CALL apsp350_get_doc(p_source,p_type,p_psph010)
#                  RETURNING r_num,r_psib003
# Input parameter: p_source       來源 (1.psph_t  2.pspa_t)
#                : p_type         類型 (當source='2'，P1:請購單.P2:採購單.P4:收貨單)
#                : p_psph010      供給單號
# Return code....: r_num          為哪個單據(1.請購單2.採購單3.收貨單)
#                : r_psib003      供應商
# Date & Author..: 2016/08/24 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_get_doc(p_source,p_type,p_psph010)
   DEFINE  p_source   LIKE  type_t.num5     
   DEFINE  p_type     LIKE  pspa_t.pspa020  
   DEFINE  p_psph010  LIKE  psph_t.psph010
   DEFINE  r_num      LIKE  type_t.num5
   DEFINE  r_psib003  LIKE  psib_t.psib003
   DEFINE  l_docno    LIKE  pmdl_t.pmdldocno
   
   LET l_docno = ''
   LET r_num = 0
   LET r_psib003 = ''
   
   #請購單
   IF (p_source = '1' AND p_type = 'P1') OR (p_source = '2' AND cl_null(l_docno)) THEN
      LET r_num = '1'
      SELECT pmdbdocno INTO l_docno
        FROM pmdb_t
       WHERE pmdbent = g_enterprise
         AND pmdbsite = g_site
         AND (pmdbdocno||'-'||pmdbseq) = p_psph010
   END IF
   #採購單
   IF (p_source = '1' AND p_type = 'P2') OR (p_source = '2' AND cl_null(l_docno)) THEN
      LET r_num = '2'
      SELECT pmdodocno INTO l_docno
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdosite = g_site
         AND (pmdodocno||'-'||pmdoseq||'-'||pmdoseq1||'-'||pmdoseq2) = p_psph010
   END IF
   
   #收貨單
   IF (p_source = '1' AND p_type = 'P4') OR (p_source = '2' AND cl_null(l_docno)) THEN
      LET r_num = '3'
      SELECT pmdtdocno INTO l_docno
       FROM  pmdt_t
       WHERE pmdtent = g_enterprise
         AND pmdtsite = g_site
         AND (pmdtdocno||'-'||pmdtseq||'-0-0') = p_psph010
   END IF
 
   IF cl_null(l_docno) THEN
      LET r_num = '0'
   END IF
   
   
   #抓取供應商
   CASE r_num
     WHEN '2' 
        SELECT pmdl004 INTO r_psib003 FROM pmdl_t
         WHERE pmdlent = g_enterprise
           AND pmdlsite = g_site
           AND pmdldocno = l_docno
     WHEN '3'
        SELECT pmds007 INTO r_psib003 FROM pmds_t
         WHERE pmdsent = g_enterprise
           AND pmdssite = g_site
           AND pmdsdocno = l_docno
     OTHERWISE
        LET r_psib003 = ''
   END CASE
   
   RETURN r_num,r_psib003
END FUNCTION

################################################################################
# Descriptions...: 新增資料至psic_t檔
# Memo...........:
# Usage..........: CALL apsp350_ins_psic(p_psib001,p_psib002,p_psib003,p_psib004,p_psib005,
#                       p_psib006,p_psib007,p_psib012,p_psib013)
#                  RETURNING r_success
# Input parameter: p_psib001      預測編號
#                : p_psib002      預測起始日期
#                : p_psib003      供應商
#                : p_psib004      計畫員
#                : p_pisb005      版本
#                : p_psib006      料件編號
#                : p_psib007      產品特徵
#                : p_psib012      單位
#                : p_psib013      保稅否
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/08/25 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_ins_psic(p_psib001,p_psib002,p_psib003,p_psib004,p_psib005,p_psib006,p_psib007,p_psib012,p_psib013)
   DEFINE  p_psib001   LIKE  psib_t.psib001
   DEFINE  p_psib002   LIKE  psib_t.psib002
   DEFINE  p_psib003   LIKE  psib_t.psib003
   DEFINE  p_psib004   LIKE  psib_t.psib004
   DEFINE  p_psib005   LIKE  psib_t.psib005
   DEFINE  p_psib006   LIKE  psib_t.psib006
   DEFINE  p_psib007   LIKE  psib_t.psib007
   DEFINE  p_psib012   LIKE  psib_t.psib012
   DEFINE  p_psib013   LIKE  psib_t.psib013
   DEFINE  l_psic009   LIKE  psic_t.psic009
   DEFINE  l_psic010   LIKE  psic_t.psic010
   DEFINE  l_psic011   LIKE  psic_t.psic011
   DEFINE  l_psic012   LIKE  psic_t.psic012
   DEFINE  l_psic013   LIKE  psic_t.psic013
   DEFINE  l_psph_sum  LIKE  psic_t.psic011
   DEFINE  l_pspa_sum  LIKE  psic_t.psic011
   DEFINE  l_success   LIKE  type_t.num5
   DEFINE  r_success   LIKE  type_t.num5
   
   LET l_psic009 = 0
   LET l_psic010 = 0
   LET l_psic011 = 0
   LET l_psic012 = 0
   LET l_psic013 = 0
   LET l_psph_sum = 0
   LET l_pspa_sum = 0
   LET r_success = TRUE
   
   #取採購未收量、採購在驗量
   SELECT SUM(psic011),SUM(psic012)
     INTO l_psic011,l_psic012
     FROM apsp350_tmp02 
    WHERE psic001 = p_psib001
      AND psic002 = p_psib002
      AND psic003 = p_psib003
      AND psic004 = p_psib004
      AND psic006 = p_psib006
      AND COALESCE(psic007,' ') = p_psib007
      AND psic008 = p_psib013
      
   
   IF cl_null(l_psic011) THEN LET l_psic011 = 0 END IF
   IF cl_null(l_psic012) THEN LET l_psic012 = 0 END IF
   
   #取庫存量、請購量
   SELECT SUM(psic009),SUM(psic010) INTO l_psic009,l_psic010
     FROM apsp350_tmp02
    WHERE psic001 = p_psib001
      AND psic002 = p_psib002
      AND psic006 = p_psib006
      AND COALESCE(psic007,' ') = p_psib007
      AND psic008 = p_psib013
   IF cl_null(l_psic009) THEN LET l_psic009 = 0 END IF
   IF cl_null(l_psic010) THEN LET l_psic010 = 0 END IF
   
   #計算"未分配計劃採購量"
   #---1.抓取pspa020的總量
   SELECT COALESCE(SUM(psic009),0) + COALESCE(SUM(psic010),0) + COALESCE(SUM(psic011),0) + 
          COALESCE(SUM(psic012),0) + COALESCE(SUM(psic013),0) 
     INTO l_pspa_sum 
     FROM apsp350_tmp02
    WHERE psic001 = p_psib001
      AND psic002 = p_psib002
      AND psic006 = p_psib006
      AND COALESCE(psic007,' ') = p_psib007
      AND psic008 = p_psib013
   IF cl_null(l_pspa_sum) THEN LET l_pspa_sum = 0 END IF
   #---2.抓取psph016的總量
   SELECT COALESCE(SUM(psib011),0) + COALESCE(SUM(psib011_i),0) INTO l_psph_sum
     FROM apsp350_tmp
    WHERE psib006 = p_psib006
      AND COALESCE(psib007,' ') = p_psib007
      AND psib013 = p_psib013
   IF cl_null(l_psph_sum) THEN LET l_psph_sum = 0 END IF
   #---3.取得未分配計劃採購量
   LET l_psic013 = l_pspa_sum - l_psph_sum  #[apsq500的供需數量(I,P0,P1,P2,P4)-psph供需配置檔(I,P,NP)]
   
   #庫存量
   CALL s_aooi250_take_decimals(p_psib012,l_psic009) RETURNING r_success,l_psic009
   #請購量
   CALL s_aooi250_take_decimals(p_psib012,l_psic010) RETURNING l_success,l_psic010
   #採購未收量
   CALL s_aooi250_take_decimals(p_psib012,l_psic011) RETURNING l_success,l_psic011 
   #採購在驗量
   CALL s_aooi250_take_decimals(p_psib012,l_psic012) RETURNING l_success,l_psic012 
   #未分配計劃採購量
   CALL s_aooi250_take_decimals(p_psib012,l_psic013) RETURNING l_success,l_psic013 
   
   #寫資料
   INSERT INTO psic_t(psicent,psicsite,psic001,psic002,psic003,psic004,psic005,psic006,
                      psic007,psic008,psic009,psic010,psic011,psic012,psic013)
      VALUES (g_enterprise,g_site,p_psib001,p_psib002,p_psib003,p_psib004,p_psib005,p_psib006,
              p_psib007,p_psib013,l_psic009,l_psic010,l_psic011,l_psic012,l_psic013)
   
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins psic_t"
      LET g_errparam.popup = TRUE
      
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除採購預測維護資料(apst350)
# Memo...........:
# Usage..........: apsp350_del_apt350(p_psia001,p_psia002,p_psia005)
#                  RETURNING r_success
# Input parameter: p_psia001      預測編號
#                : p_psia002      預測起始日期
#                : p_psia005      版本
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/08/30 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_del_apt350(p_psia001,p_psia002,p_psia005)
   DEFINE p_psia001   LIKE  psia_t.psia001
   DEFINE p_psia002   LIKE  psia_t.psia002
   DEFINE p_psia003   LIKE  psia_t.psia003
   DEFINE p_psia004   LIKE  psia_t.psia004
   DEFINE p_psia005   LIKE  psia_t.psia005
   DEFINE r_success   LIKE  type_t.num5
   
   LET r_success = TRUE
   LET p_psia005 = p_psia005 USING '<<<<<'
   
   #刪除單頭
   DELETE FROM psia_t
    WHERE psiaent = g_enterprise AND psiasite = g_site
      AND psia001 = p_psia001    AND psia002 = p_psia002
      AND psia005 = p_psia005 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "psia_t:",SQLERRMESSAGE  
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      LET r_success = FALSE
      CALL cl_err()
      RETURN r_success
   END IF
   
   #刪除單身-psib_t
   DELETE FROM psib_t
    WHERE psibent = g_enterprise AND psibsite = g_site
      AND psib001 = p_psia001    AND psib002 = p_psia002
      AND psib005 = p_psia005
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "psib_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      LET r_success = FALSE
      CALL cl_err()
      RETURN r_success
   END IF  
   
   #刪除單身-pisc_t
   DELETE FROM psic_t
    WHERE psicent = g_enterprise  AND psicsite = g_site
      AND psic001 = p_psia001     AND psic002 = p_psia002
      AND psic005 = p_psia005
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "psic_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      LET r_success = FALSE
      CALL cl_err()
      RETURN r_success
   END IF 
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取MRP供需明細檔(pspa_t)
# Memo...........:
# Usage..........: CALL apsp350_get_pspa()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/08/31 By dorislai (#160819-00015#2)
# Modify.........: 
################################################################################
PRIVATE FUNCTION apsp350_get_pspa()
   DEFINE l_sql             STRING
   DEFINE l_pspa006         LIKE pspa_t.pspa006  #來源單號
   DEFINE l_pspa009         LIKE pspa_t.pspa009  #數量
   DEFINE l_pspa012         LIKE pspa_t.pspa012  #品號
   DEFINE l_pspa013         LIKE pspa_t.pspa013  #特徵碼
   DEFINE l_pspa020         LIKE pspa_t.pspa020  #供需碼
   DEFINE l_pspa021         LIKE pspa_t.pspa021  #保稅否
   DEFINE r_success         LIKE type_t.num5      
   
   LET r_success = TRUE
   
   #抓取MRP供需明細檔(pspa_t)
   LET l_sql = " SELECT pspa006,SUM(pspa009),pspa012,COALESCE(pspa013,' '),pspa020,pspa021 ",
               "   FROM pspa_t ",
               "  WHERE pspaent = '",g_enterprise,"' AND pspasite = '",g_site,"' ",
               "    AND pspa001 = '",g_psja.psja004,"' AND pspa002 = '",g_psoz002,"' ",
               "    AND pspa020 IN ('I','P0','P1','P2','P4') ",
               #品號需存在於psph_t中
               #"    AND EXISTS (SELECT 1 FROM psph_t WHERE psphent = '",g_enterprise,"'",
               #"                   AND psphsite = '",g_site,"'    AND psph001 = '",g_psja.psja004,"'",
               #"                   AND psph002 = '",g_psoz002,"'  AND psph016 IN ('NP','P') ",  
               #"                   AND pspa012 = psph017  AND COALESCE(pspa013,' ') = COALESCE(psph039,' ') ) ",
               "  GROUP BY pspa006,pspa012,pspa013,pspa020,pspa021 ",
               "  ORDER BY pspa006,pspa012,pspa013,pspa020,pspa021 "
   PREPARE apsp350_pspa_pre FROM l_sql
   DECLARE apsp350_pspa_cs CURSOR FOR apsp350_pspa_pre
   
   FOREACH apsp350_pspa_cs INTO l_pspa006,l_pspa009,l_pspa012,l_pspa013,l_pspa020,l_pspa021
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_pspa_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #dorislai-20160906-mark-(S)
      #IF l_pspa020 = 'P1' THEN
      #   CALL apsp350_ins_tmp02_2(l_pspa020,l_pspa009,l_pspa012,l_pspa013,l_pspa021) RETURNING r_success
      #ELSE
      #   CALL apsp350_ins_tmp02_1(l_pspa020,l_pspa006,l_pspa009,l_pspa012,l_pspa013,l_pspa021) RETURNING r_success
      #END IF
      #dorislai-20160906-mark-(E)
      
      CALL apsp350_ins_tmp02_1(l_pspa020,l_pspa006,l_pspa009,l_pspa012,l_pspa013,l_pspa021) RETURNING r_success #dorislai-20160906-add
      
   END FOREACH
   
  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將'I','P0','P1','P2','P4'寫入tmp02
# Memo...........:
# Usage..........: CALL apsp350_ins_tmp02_1(p_pspa020,p_pspa006,p_pspa012,p_pspa013,p_pspa021)
#                  RETURNING r_success
# Input parameter: p_pspa020      供需碼 ('I':庫存,'P0':計畫採購量,'P1":請購量,'P2':採購未交量,'P4':採購在驗量)
#                : p_pspa006      來源單號
#                : p_pspa009      數量
#                : p_pspa012      品號
#                : p_pspa013      品號特徵碼
#                : p_pspa021      保稅否
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/09/01 By dorislai (#160819-00015#2)
# Modify.........: 
################################################################################
PRIVATE FUNCTION apsp350_ins_tmp02_1(p_pspa020,p_pspa006,p_pspa009,p_pspa012,p_pspa013,p_pspa021)
   DEFINE p_pspa020    LIKE  pspa_t.pspa020
   DEFINE p_pspa006    LIKE  pspa_t.pspa006
   DEFINE p_pspa009    LIKE  pspa_t.pspa009
   DEFINE p_pspa012    LIKE  pspa_t.pspa012
   DEFINE p_pspa013    LIKE  pspa_t.pspa013
   DEFINE p_pspa021    LIKE  pspa_t.pspa021
   DEFINE l_psic003    LIKE  psic_t.psic003   #供應商
   DEFINE l_doc        LIKE  type_t.num5      #為哪個單
   DEFINE l_psci003    LIKE  psic_t.psic003   #供應商
   DEFINE l_psic009    LIKE  psic_t.psic009   #庫存量 
   DEFINE l_psic010    LIKE  psic_t.psic010   #請購量
   DEFINE l_psic011    LIKE  psic_t.psic011   #採購未收量
   DEFINE l_psic012    LIKE  psic_t.psic012   #採購在驗量
   DEFINE l_psic013    LIKE  psic_t.psic013   #未分配計劃採購量
   DEFINE r_success    LIKE  type_t.num5
   
   LET r_success = TRUE
   LET l_doc = 0
   LET l_psic003 = ''
   
   LET l_psic009 = 0
   LET l_psic010 = 0
   LET l_psic011 = 0
   LET l_psic012 = 0
   LET l_psic013 = 0
   
   #---取得供應商(採購單、收貨單)
   IF p_pspa020 = 'P2' OR p_pspa020 = 'P4' THEN
      CALL apsp350_get_doc('1',p_pspa020,p_pspa006) RETURNING l_doc,l_psic003
      #dorislai-20160922-s-add
      #有可能在跑過計算後，單子又被改過，導致找不到其項次or單號
      IF l_doc = 0 THEN
         LET l_psic003 = "NOTDEFINED"
      END IF
      #dorislai-20160922-e-add
   END IF
   
   CASE p_pspa020
      WHEN 'I'  #庫存
         LET l_psic009 = p_pspa009
      WHEN 'P1' #請購單
         LET l_psic010 = p_pspa009
      WHEN 'P2' #採購單
         LET l_psic011 = p_pspa009
      WHEN 'P4' #收貨單
         LET l_psic012 = p_pspa009
      WHEN 'P0' #計劃採購量
         LET l_psic013 = p_pspa009
   END CASE
   
   #新增tmp02，psic_t的暫存檔
   INSERT INTO apsp350_tmp02(psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008,psic009,psic010,psic011,psic012,psic013)
      VALUES (g_master.psja001,g_master.psoz004,l_psic003,g_psib004,'0',p_pspa012,p_pspa013,
              p_pspa021,l_psic009,l_psic010,l_psic011,l_psic012,l_psic013)
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apsp350_tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將'P1'寫入tmp02
# Memo...........:
# Usage..........: CALL apsp350_ins_tmp02_2(p_pspa020,p_pspa009,p_pspa012,p_pspa013,p_pspa021)
#                  RETURNING r_success
# Input parameter: p_pspa020      供需碼('P1':請購量)
#                : p_pspa009      數量
#                : p_pspa012      品號
#                : p_pspa013      品號特徵碼
#                : p_pspa021      保稅否
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/09/01 By dorislai (#160819-00015#2) 
# Modify.........: 2016/09/06 mark P1不用供應商分配，這個FUNCTION暫時用不到
################################################################################
PRIVATE FUNCTION apsp350_ins_tmp02_2(p_pspa020,p_pspa009,p_pspa012,p_pspa013,p_pspa021)
   DEFINE p_pspa020      LIKE  pspa_t.pspa020
   DEFINE p_pspa006      LIKE  pspa_t.pspa006
   DEFINE p_pspa009      LIKE  pspa_t.pspa009
   DEFINE p_pspa012      LIKE  pspa_t.pspa012
   DEFINE p_pspa013      LIKE  pspa_t.pspa013
   DEFINE p_pspa021      LIKE  pspa_t.pspa021
   DEFINE l_psic003      LIKE  psic_t.psic003   #供應商
   DEFINE l_psja008      LIKE  psja_t.psja008   #分配限量
   DEFINE l_psja006      LIKE  psja_t.psja006   #供應商分配方式
   DEFINE l_imaf152      LIKE  imaf_t.imaf152   #供應商選擇方式
   DEFINE l_imaf154      LIKE  imaf_t.imaf154   #主供應商分配限量
   DEFINE l_psci003      LIKE  psic_t.psic003   #供應商
   DEFINE l_psic010      LIKE  psic_t.psic010   #請購量
   DEFINE l_margin       LIKE  pspa_t.pspa009   #紀錄剩餘數量
   DEFINE l_tot_qty      LIKE  pspa_t.pspa009
   DEFINE l_pmao001      LIKE  pmao_t.pmao001
   DEFINE l_pmao008      LIKE  pmao_t.pmao008
   DEFINE l_sql          STRING
   DEFINE l_pmao008_sum  LIKE  pmao_t.pmao008
   DEFINE r_success      LIKE  type_t.num5
   
   LET r_success = TRUE
   LET l_margin = 0
   
   #供應商指定方式=1:依料件主檔設定，先找出供應商選擇方式(imaf152)、分配限量(imaf154)
   #0→#主要供應商，無限量  1→#依供應商分配  2→#主要供應商分配優先，餘量分配  3→指定單一供應商
   IF g_psja.psja006 = '1' THEN
      SELECT imaf152,imaf154 INTO l_imaf152,l_imaf154
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite= g_site
         AND imaf001 = p_pspa012
      CASE l_imaf152
        WHEN '0' 
           LET l_psja006 = '2' 
        WHEN '1'
           LET l_psja006 = '3' 
        WHEN '2'
           LET l_psja006 = '4' 
        WHEN '3'  #人工選擇
           LET l_psja006 = '5' 
        OTHERWISE
           LET l_psja006 = '2' #主要供應商，無限量
      END CASE
   ELSE
      LET l_psja006 = g_psja.psja006
      LET l_imaf154 = g_psja.psja008
   END IF
   
   #主要供應商，無限量
   IF l_psja006 = '2' THEN
      SELECT imaf153 INTO l_psic003 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite= g_site
         AND imaf001 = p_pspa012
      IF SQLCA.sqlcode OR cl_null(l_psic003) THEN
         LET l_psic003 = "NONE"
      END IF
      LET l_psic010 = p_pspa009
   END IF
   
   #依廠商分配
   IF l_psja006 = '3' THEN
      LET l_psic010 = p_pspa009
   END IF
   #主要供應商分配優先，餘量分配
   IF l_psja006 = '4' THEN
      SELECT imaf153 INTO l_psic003 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite= g_site
         AND imaf001 = p_pspa012
      IF p_pspa009 > l_imaf154 THEN
         LET l_psja008 = l_imaf154
      ELSE
         LET l_psja008 = p_pspa009
      END IF
      LET l_margin = p_pspa009 - l_psja008
      LET l_psic010 = l_psja008
   END IF
   #指定單一供應商
   IF l_psja006 = '5' THEN
      LET l_psic003 = g_psja.psja007
      LET l_psic010 = p_pspa009
   END IF
   #新增tmp02，psic_t的暫存檔
   IF l_psja006 MATCHES '[245]' THEN
      INSERT INTO apsp350_tmp02(psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008,psic009,psic010,psic011,psic012,psic013)
         VALUES (g_master.psja001,g_master.psoz004,l_psic003,g_psib004,'0',p_pspa012,p_pspa013,p_pspa021,0,l_psic010,0,0,0)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins apsp350_tmp02'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
      END IF
   END IF
  
   #依廠商分配
   IF l_psja006 = '3' OR (l_psja006 = '4' AND l_margin > 0) THEN
      #先算出該料的總比率
      LET l_pmao008_sum = 0
      SELECT SUM(pmat004) INTO l_pmao008_sum FROM pmat_t,pmaa_t
       WHERE pmatent = g_enterprise
         AND pmatsite = g_site
         AND pmat002 = p_pspa012
         AND COALESCE(pmat003,' ') = COALESCE(p_pspa013,' ')
         AND pmatent = pmaaent
         AND pmat001 = pmaa001
         AND pmaa002 IN ('1','3')
         AND pmatstus = 'Y'
     
      IF cl_null(l_pmao008_sum) OR l_pmao008_sum = 0 THEN
         #沒有比率的直接給一個虛擬的供應商
         #新增tmp02，psic_t的暫存檔
         LET l_psic003 = "NONE"
         INSERT INTO apsp350_tmp02(psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008,psic009,psic010,psic011,psic012)
            VALUES (g_master.psja001,g_master.psoz004,l_psic003,g_psib004,'0',p_pspa012,p_pspa013,p_pspa021,0,l_psic010,0,0)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apsp350_tmp02'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success 
         END IF
         RETURN r_success
      END IF
      
      #依各供應商的分配比率進行分配
      LET l_sql = "SELECT pmat001,pmat004 FROM pmat_t,pmaa_t ",
                  " WHERE pmatent = '",g_enterprise,"'",
                  "   AND pmatsite = '",g_site,"'",
                  "   AND pmat002 = '",p_pspa012,"'",
                  "   AND COALESCE(pmat003,' ') = COALESCE('",p_pspa013,"',' ') ",
                  "   AND pmatent = pmaaent ",
                  "   AND pmat001 = pmaa001 ",
                  "   AND pmaa002 IN ('1','3') ",
                  "   AND pmatstus = 'Y' ",
                  " ORDER BY pmat004 DESC "
      #160819-00015#2-e-mod
      PREPARE apsp350_pmat_pre FROM l_sql
      DECLARE apsp350_pmat_cs CURSOR FOR apsp350_pmat_pre
      
      LET l_tot_qty = 0
      FOREACH apsp350_pmat_cs INTO l_pmao001,l_pmao008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:apsp350_pmat_cs"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #依比率分配
         LET l_psic010 = l_margin * l_pmao008 / l_pmao008_sum
         
         #若剩餘數量小於分配數量，則採購量=剩餘數量
         IF (l_margin - l_tot_qty) < l_psic010 THEN 
            LET l_psic010 = l_margin - l_tot_qty
         END IF
         LET l_tot_qty = l_tot_qty + l_psic010
         
         INSERT INTO apsp350_tmp02(psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008,psic009,psic010,psic011,psic012)
            VALUES (g_master.psja001,g_master.psoz004,l_pmao001,g_psib004,'0',p_pspa012,p_pspa013,p_pspa021,0,l_psic010,0,0)
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins apsp350_tmp'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            EXIT FOREACH
         END IF
         #總採購數量 >= 原採購數量，則不用再分配
         IF l_tot_qty >= l_margin THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得pspa_t料號不存在pspah裡的資料
#                : 條件1：pspa020 = 'P0','P1','P2','P4'(排除I)、psph016='NP','P'
#                : 條件2：料號+產品特徵+保稅否 → pspa_t <> pspa_t
# Memo...........:
# Usage..........: CALL apsp350_diff_data(p_psic005)
#                  RETURNING r_success
# Input parameter: psic005        版本
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/09/13 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_diff_data(p_psic005)
   DEFINE l_psic003   LIKE   psic_t.psic003
   DEFINE l_psic004   LIKE   psic_t.psic004
   DEFINE l_psic006   LIKE   psic_t.psic006
   DEFINE l_psic007   LIKE   psic_t.psic007
   DEFINE l_psic008   LIKE   psic_t.psic008
   DEFINE l_imaf143   LIKE   imaf_t.imaf143  #採購單位
   DEFINE l_i         LIKE   type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING
   #DEFINE l_where     STRING
   DEFINE l_cnt       LIKE   type_t.num5
   DEFINE l_sum       LIKE   type_t.num20_6   #紀錄採購未收量、採購在驗量的加總
   DEFINE l_current   DATETIME YEAR TO SECOND
   DEFINE p_psic005   LIKE   psic_t.psic005
   DEFINE r_success   LIKE   type_t.num5
   
   #先撈出料號、產品特徵、保稅否
   #dorislai-20160922-s-add
   ##LET l_sql = "SELECT DISTINCT psic003,psic004,psic006,COALESCE(psic007,' '),psic008 ",
   ##            "  FROM apsp350_tmp02 ",
   ##            " WHERE (psic010<>0  OR psic011<>0 OR psic012<>0 OR psic013<>0 ) ",
   ##            "   AND NOT EXISTS (SELECT (1) FROM apsp350_tmp ",
   ##            "                    WHERE  psic006= psib006 AND COALESCE(psic007,' ') = COALESCE(psib007,' ') AND psic008 = psib013 AND psib011_i=0) "
   #LET l_sql = "SELECT DISTINCT psic003,psic004,psic006,COALESCE(psic007,' '),psic008 ",
   #            "  FROM apsp350_tmp02 ",
   #            " WHERE (psic010<>0  OR psic011<>0 OR psic012<>0 OR psic013<>0 ) ",
   #            "   AND NOT EXISTS (SELECT (1) FROM apsp350_tmp ",
   #            "                    WHERE  psic006= psib006 AND COALESCE(psic007,' ') = COALESCE(psib007,' ') AND psic008 = psib013 ",
   #            "                      AND psib011_i=0 AND psic003 = psib003) "
   LET l_sql = "SELECT DISTINCT psic003,psic004,psic006,COALESCE(psic007,' '),psic008 ",
               "  FROM apsp350_tmp02 ",
               " WHERE (psic011<>0 OR psic012<>0 ) ",
               "   AND NOT EXISTS (SELECT (1) FROM apsp350_tmp ",
               "                    WHERE  psic006= psib006 AND COALESCE(psic007,' ') = COALESCE(psib007,' ') AND psic008 = psib013 ",
               "                      AND psib011_i=0 AND psic003 = psib003) ",
               " UNION ",
               "SELECT DISTINCT psic003,psic004,psic006,COALESCE(psic007,' '),psic008 ",
               "  FROM apsp350_tmp02 ",
               " WHERE (psic010<>0  OR psic013<>0 ) ",
               "   AND NOT EXISTS (SELECT (1) FROM apsp350_tmp ",
               "                    WHERE  psic006= psib006 AND COALESCE(psic007,' ') = COALESCE(psib007,' ') AND psic008 = psib013 ",
               "                      AND psib011_i=0 ) "
   #dorislai-20160922-e-add
   
   PREPARE apsp350_psic_pre_1 FROM l_sql
   DECLARE apsp350_psic_cs_1 CURSOR FOR apsp350_psic_pre_1
#   #----抓取pspa020=P1,P2,P4
#   LET l_sql1 = l_sql CLIPPED, " AND (psic010<>0  OR psic011<>0 OR psic012<>0 )  "
#   PREPARE apsp350_psic_pre_1 FROM l_sql1
#   DECLARE apsp350_psic_cs_1 CURSOR FOR apsp350_psic_pre_1
#   #----抓取psap020=P0
#   LET l_sql1 = l_sql CLIPPED, " AND (psic010=0  OR psic011=0 OR psic012=0 OR psic013<>0)  " #表示此料號僅有'P0'的資料
#   PREPARE apsp350_psic_pre_2 FROM l_sql1
#   DECLARE apsp350_psic_cs_2 CURSOR FOR apsp350_psic_pre_2   
   
   LET l_psic003 = ''
   LET l_psic004 = ''
   LET l_psic006 = ''
   LET l_psic007 = ''
   LET l_psic008 = ''
   LET r_success = TRUE
   
   FOREACH apsp350_psic_cs_1 INTO l_psic003,l_psic004,l_psic006,l_psic007,l_psic008
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_psic_cs_1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #若供應商為空，預給"NONE" (P1 OR P0供應商會為空)
      IF cl_null(l_psic003) THEN
         #dorislai-20160921-add-(S)
         #若採購單或收貨單，有供應商，這筆資料就不用寫入
         LET l_sum = 0
         SELECT COALESCE(SUM(psic011),0) + COALESCE(SUM(psic012),0) INTO l_sum
           FROM apsp350_tmp02
          WHERE psic001 = g_master.psja001
            AND psic002 = g_master.psoz004
            AND psic006 = l_psic006
            AND COALESCE(psic007,' ') = l_psic007
            AND psic008 = l_psic008
         IF l_sum > 0 THEN
            CONTINUE FOREACH
         END IF
         #dorislai-20160921-add-(E)
         LET l_psic003 = "NONE"
      END IF
      #抓取採購單位
      LET l_imaf143 = ''
      SELECT imaf143 INTO l_imaf143
        FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_psic006
      IF cl_null(l_imaf143) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-01105'
          LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()       
         EXIT FOREACH
      END IF
      #新增單頭
      LET l_cnt = 0 
      SELECT (1) INTO l_cnt FROM psia_t
       WHERE psiaent = g_enterprise     AND psiasite = g_site
         AND psia001 = g_master.psja001 AND psia002 = g_master.psoz004
         AND psia003 = l_psic003        AND psia004 = l_psic004
         AND psia005 = p_psic005
      IF l_cnt = 0 THEN
         INSERT INTO psia_t(psiaent,psiasite,psia001,psia002,psia003,psia004,psia005,
                            psiaownid,psiaowndp,psiacrtid,psiacrtdp,psiacrtdt,psiamodid,psiamoddt,
                            psiacnfid,psiacnfdt,psiastus)
            VALUES(g_enterprise,g_site,g_master.psja001,g_master.psoz004,l_psic003,l_psic004,p_psic005,
                   g_user,g_dept,g_user,g_dept,l_current,'','','','','N')
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins psia_t"
            LET g_errparam.popup = TRUE
            
            EXIT FOREACH
         END IF
      END IF
      
      #新增至pisc_t
      CALL apsp350_ins_psic(g_master.psja001,g_master.psoz004,l_psic003,l_psic004,p_psic005,l_psic006,l_psic007,l_imaf143,l_psic008)
         RETURNING r_success
      IF NOT r_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      FOR l_i = 1 TO g_psja.psja002
          #新增至psib_t
          INSERT INTO psib_t(psibent,psibsite,psib001,psib002,psib003,psib004,psib005,psib006,
                             psib007,psib008,psib009,psib010,psib011,psib012,psib013)
               VALUES(g_enterprise,g_site,g_master.psja001,g_master.psoz004,l_psic003,l_psic004,p_psic005,l_psic006,
                      l_psic007,l_i,'','',0,l_imaf143,l_psic008)
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "ins psib_t"
             LET g_errparam.popup = TRUE
             LET r_success = FALSE
             EXIT FOREACH
          END IF
      END FOR

   END FOREACH
   FREE apsp350_psic_pre_1
   
#   #寫入pspa020=P0的値(無供應商)
#   FOREACH apsp350_psic_cs_2 INTO l_psic003,l_psic004,l_psic006,l_psic007,l_psic008
#      IF SQLCA.sqlcode THEN
#         LET r_success = FALSE
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:apsp350_psic_cs_2"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#      FOREACH apsp350_tmp_group_cs INTO l_psic003,l_psic004
#         IF SQLCA.sqlcode THEN
#            LET r_success = FALSE
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH:apsp350_tmp_group_cs"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#         #抓取採購單位
#      LET l_imaf143 = ''
#      SELECT imaf143 INTO l_imaf143
#        FROM imaf_t
#       WHERE imafent  = g_enterprise
#         AND imafsite = g_site
#         AND imaf001  = l_psic006

#      IF cl_null(l_imaf143) THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'apm-01105'
#          LET g_errparam.extend = ""
#         LET g_errparam.popup = TRUE
#         CALL cl_err()       
#         EXIT FOREACH
#      END IF
#      
#      #新增至pisc_t
#      CALL apsp350_ins_psic(g_master.psja001,g_master.psoz004,l_psic003,l_psic004,p_psic005,l_psic006,l_psic007,l_imaf143,l_psic008)
#         RETURNING r_success
#      IF r_success THEN
#         #新增至psib_t
#         INSERT INTO psib_t(psibent,psibsite,psib001,psib002,psib003,psib004,psib005,psib006,
#                            psib007,psib008,psib009,psib010,psib011,psib012,psib013)
#              VALUES(g_enterprise,g_site,g_master.psja001,g_master.psoz004,l_psic003,l_psic004,p_psic005,l_psic006,
#                     l_psic007,0,'','',0,l_imaf143,l_psic008)
#         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#            LET r_success = FALSE
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "ins psib_t"
#            LET g_errparam.popup = TRUE
#            LET r_success = FALSE
#            EXIT FOREACH
#         END IF
#      ELSE
#         EXIT FOREACH
#      END IF
#      END FOREACH
#   END FOREACH
#   FREE apsp350_psic_pre_2

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 確認單身有沒有資料，沒的話，刪除單頭
# Memo...........:
# Usage..........: CALL apsp350_del_psia(l_psib005)
#                  RETURNING r_success
# Input parameter: l_psib005      版本
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/09/20 By dorislai (#160819-00015#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp350_del_psia(l_psib005)
   DEFINE   l_psia003    LIKE    psia_t.psia003
   DEFINE   l_psia004    LIKE    psia_t.psia004
   DEFINE   l_psib005    LIKE    psib_t.psib005
   DEFINE   l_cnt        LIKE    type_t.num5
   DEFINE   r_success    LIKE    type_t.num5
   
   LET l_psia003 = 0
   LET l_psia004 = 0
   LET r_success = TRUE
   
   FOREACH apsp350_tmp_group_cs INTO l_psia003,l_psia004
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp350_tmp_group_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #確認單身是否有資料
      LET l_cnt = 0  
      SELECT DISTINCT (1) INTO l_cnt FROM psib_t
       WHERE psibent = g_enterprise      AND psibsite = g_site
         AND psib001 = g_master.psja001  AND psib002 = g_master.psoz004
         AND psib003 = l_psia003         AND psib004 = l_psia004
         AND psib005 = l_psib005
      #刪除單頭   
      IF l_cnt = 0 THEN
         DELETE FROM psia_t
          WHERE psiaent = g_enterprise     AND psiasite = g_site
            AND psia001 = g_master.psja001 AND psia002  = g_master.psoz004
            AND psia003 = l_psia003        AND psia004  = l_psia004
            AND psia005 = l_psib005 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "psia_t:",SQLERRMESSAGE  
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            LET r_success = FALSE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 

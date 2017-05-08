#該程式未解開Section, 採用最新樣板產出!
{<section id="afap400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-10-14 10:52:42), PR版次:0002(2016-11-23 14:51:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: afap400
#+ Description: 列帳轉列管批次處理作業
#+ Creator....: 07900(2016-10-13 15:17:06)
#+ Modifier...: 07900 -SD/PR- 06189
 
{</section>}
 
{<section id="afap400.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161111-00028#6   2016/11/23  by 06189    标准程式定义采用宣告模式,弃用.*写
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
     sel             LIKE type_t.chr1,
     faah003         LIKE faah_t.faah003,
     faah001         LIKE faah_t.faah001,
     faah004         LIKE faah_t.faah004,
     faah006         LIKE faah_t.faah006,
     faah006_desc    LIKE type_t.chr80,
     faah007         LIKE faah_t.faah007,
     faah007_desc    LIKE type_t.chr80,
     faah005         LIKE faah_t.faah005,
     faah008         LIKE faah_t.faah008,
     faah008_desc    LIKE type_t.chr80,
     faah042         LIKE faah_t.faah042,
     faaj006         LIKE faaj_t.faaj006,
     faaj023         LIKE faaj_t.faaj023,
     faaj024         LIKE faaj_t.faaj024,
     faaj025         LIKE faaj_t.faaj025,
     faaj026         LIKE faaj_t.faaj026,
     faaj003         LIKE faaj_t.faaj003,
     faaj005         LIKE faaj_t.faaj005,
     faaj016         LIKE faaj_t.faaj016,
     faaj017         LIKE faaj_t.faaj017
END RECORD 
 TYPE type_master RECORD
     faarsite          LIKE faar_t.faarsite,
     faarsite_desc     LIKE type_t.chr80, 
     faarld            LIKE faar_t.faarld,
     faarld_desc       LIKE type_t.chr80,
     ooef017           LIKE ooef_t.ooef017,
     ooef017_desc      LIKE type_t.chr80,
     faar001           LIKE faar_t.faar001,
     faah001           LIKE faah_t.faah001,
     faah003           LIKE faah_t.faah003,
     faah004           LIKE faah_t.faah004,
     faah005           LIKE faah_t.faah005,
     faah006           LIKE faah_t.faah006,
     faah007           LIKE faah_t.faah007,
     faah008           LIKE faah_t.faah008,
     faah026           LIKE faah_t.faah026    
END RECORD 
DEFINE g_master    type_master 
DEFINE g_master_t  type_master
#DEFINE g_faah               DYNAMIC ARRAY OF RECORD LIKE faah_t.* #mark by geza 20161123 #161111-00028#6 
#DEFINE g_faaj               DYNAMIC ARRAY OF RECORD LIKE faaj_t.* #mark by geza 20161123 #161111-00028#6
#add by geza 20161123 #161111-00028#6(S)
PRIVATE TYPE g_faah_d RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企业编号
       faah000 LIKE faah_t.faah000, #生成批号
       faah001 LIKE faah_t.faah001, #卡片编号
       faah002 LIKE faah_t.faah002, #型态
       faah003 LIKE faah_t.faah003, #财产编号
       faah004 LIKE faah_t.faah004, #附号
       faah005 LIKE faah_t.faah005, #资产性质
       faah006 LIKE faah_t.faah006, #资产主要类型
       faah007 LIKE faah_t.faah007, #资产次要类型
       faah008 LIKE faah_t.faah008, #资产组
       faah009 LIKE faah_t.faah009, #供应供应商
       faah010 LIKE faah_t.faah010, #制造供应商
       faah011 LIKE faah_t.faah011, #产地
       faah012 LIKE faah_t.faah012, #名称
       faah013 LIKE faah_t.faah013, #规格型号
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #资产状态
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #单位
       faah018 LIKE faah_t.faah018, #数量
       faah019 LIKE faah_t.faah019, #在外数量
       faah020 LIKE faah_t.faah020, #币种
       faah021 LIKE faah_t.faah021, #原币单价
       faah022 LIKE faah_t.faah022, #原币金额
       faah023 LIKE faah_t.faah023, #本币单价
       faah024 LIKE faah_t.faah024, #本币金额
       faah025 LIKE faah_t.faah025, #保管人员
       faah026 LIKE faah_t.faah026, #保管部门
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放组织
       faah029 LIKE faah_t.faah029, #负责人员
       faah030 LIKE faah_t.faah030, #管理组织
       faah031 LIKE faah_t.faah031, #核算组织
       faah032 LIKE faah_t.faah032, #归属法人
       faah033 LIKE faah_t.faah033, #直接资本化
       faah034 LIKE faah_t.faah034, #保税
       faah035 LIKE faah_t.faah035, #保险
       faah036 LIKE faah_t.faah036, #免税
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #采购单号
       faah039 LIKE faah_t.faah039, #收货单号
       faah040 LIKE faah_t.faah040, #账款单号
       faah041 LIKE faah_t.faah041, #来源营运中心
       faah042 LIKE faah_t.faah042, #资产属性
       faah043 LIKE faah_t.faah043, #预计总工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #账款编号项次
       faahownid LIKE faah_t.faahownid, #资料所有者
       faahowndp LIKE faah_t.faahowndp, #资料所有部门
       faahcrtid LIKE faah_t.faahcrtid, #资料录入者
       faahcrtdp LIKE faah_t.faahcrtdp, #资料录入部门
       faahcrtdt LIKE faah_t.faahcrtdt, #资料创建日
       faahmodid LIKE faah_t.faahmodid, #资料更改者
       faahmoddt LIKE faah_t.faahmoddt, #最近更改日
       faahstus LIKE faah_t.faahstus, #状态码
       faah046 LIKE faah_t.faah046, #备注
       faah047 LIKE faah_t.faah047, #保税机器截取否
       faah048 LIKE faah_t.faah048, #投资抵减状态
       faah049 LIKE faah_t.faah049, #投资抵减合并码
       faah050 LIKE faah_t.faah050, #抵减率
       faah051 LIKE faah_t.faah051, #投资抵减用途
       faah052 LIKE faah_t.faah052, #抵减金额
       faah053 LIKE faah_t.faah053, #已抵减金额
       faah054 LIKE faah_t.faah054, #投资抵减否
       faah055 LIKE faah_t.faah055, #投资抵减年限
       faah056 LIKE faah_t.faah056 #免税状态
END RECORD
DEFINE g_faah          DYNAMIC ARRAY OF g_faah_d
PRIVATE TYPE g_faaj_d RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企业编码
       faajld LIKE faaj_t.faajld, #账套别编码
       faajsite LIKE faaj_t.faajsite, #营运据点
       faaj000 LIKE faaj_t.faaj000, #批号
       faaj001 LIKE faaj_t.faaj001, #财产编号
       faaj002 LIKE faaj_t.faaj002, #附号
       faaj003 LIKE faaj_t.faaj003, #折旧方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月数)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月数)
       faaj006 LIKE faaj_t.faaj006, #分摊方式
       faaj007 LIKE faaj_t.faaj007, #分摊类别
       faaj008 LIKE faaj_t.faaj008, #开始折旧年月
       faaj009 LIKE faaj_t.faaj009, #最近折旧年度
       faaj010 LIKE faaj_t.faaj010, #最近折旧期别
       faaj011 LIKE faaj_t.faaj011, #折毕再提
       faaj012 LIKE faaj_t.faaj012, #折毕再提预留残值
       faaj013 LIKE faaj_t.faaj013, #折毕再提预留年月（数）
       faaj014 LIKE faaj_t.faaj014, #币种
       faaj015 LIKE faaj_t.faaj015, #汇率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #预留残值
       faaj020 LIKE faaj_t.faaj020, #调整成本
       faaj021 LIKE faaj_t.faaj021, #已计提减值准备
       faaj022 LIKE faaj_t.faaj022, #年折旧额
       faaj023 LIKE faaj_t.faaj023, #资产科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折旧科目
       faaj026 LIKE faaj_t.faaj026, #减值准备科目
       faaj027 LIKE faaj_t.faaj027, #销账减值准备
       faaj028 LIKE faaj_t.faaj028, #未折减额
       faaj029 LIKE faaj_t.faaj029, #第一个月未折减额
       faaj030 LIKE faaj_t.faaj030, #账款编号
       faaj031 LIKE faaj_t.faaj031, #账款编号项次
       faaj032 LIKE faaj_t.faaj032, #本期处置累折
       faaj033 LIKE faaj_t.faaj033, #处置数量
       faaj034 LIKE faaj_t.faaj034, #处置成本
       faaj035 LIKE faaj_t.faaj035, #处置累折
       faaj036 LIKE faaj_t.faaj036, #交易价格差异
       faaj037 LIKE faaj_t.faaj037, #卡片编号
       faaj038 LIKE faaj_t.faaj038, #资产状态
       faaj039 LIKE faaj_t.faaj039, #部门
       faaj040 LIKE faaj_t.faaj040, #利润/成本中心
       faaj041 LIKE faaj_t.faaj041, #区域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #账款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #项目编号
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人员
       faaj101 LIKE faaj_t.faaj101, #本位币二币种
       faaj102 LIKE faaj_t.faaj102, #本位币二汇率
       faaj103 LIKE faaj_t.faaj103, #本位币二成本
       faaj104 LIKE faaj_t.faaj104, #本位币二累折
       faaj105 LIKE faaj_t.faaj105, #本位币二预留残值
       faaj106 LIKE faaj_t.faaj106, #本位币二折毕再提预留残值
       faaj107 LIKE faaj_t.faaj107, #本位币二年折旧额
       faaj108 LIKE faaj_t.faaj108, #本位币二未折减额
       faaj109 LIKE faaj_t.faaj109, #本位币二第一月未折减额
       faaj110 LIKE faaj_t.faaj110, #本位币二处置减值准备
       faaj111 LIKE faaj_t.faaj111, #本位币二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位币二已计提减值准备
       faaj113 LIKE faaj_t.faaj113, #本位币二处置成本
       faaj114 LIKE faaj_t.faaj114, #本位币二处置累折
       faaj115 LIKE faaj_t.faaj115, #本位币二本期处置累折
       faaj116 LIKE faaj_t.faaj116, #本位币二交易价格差异
       faaj117 LIKE faaj_t.faaj117, #本位币二调整成本
       faaj151 LIKE faaj_t.faaj151, #本位币三币种
       faaj152 LIKE faaj_t.faaj152, #本位币三汇率
       faaj153 LIKE faaj_t.faaj153, #本位币三成本
       faaj154 LIKE faaj_t.faaj154, #本位币三累折
       faaj155 LIKE faaj_t.faaj155, #本位币三预留残值
       faaj156 LIKE faaj_t.faaj156, #本位币三折毕再提预留残值
       faaj157 LIKE faaj_t.faaj157, #本位币三年折旧额
       faaj158 LIKE faaj_t.faaj158, #本位币三未折减额
       faaj159 LIKE faaj_t.faaj159, #本位币三第一月未折减额
       faaj160 LIKE faaj_t.faaj160, #本位币三处置减值准备
       faaj161 LIKE faaj_t.faaj161, #本位币三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位币三已计提减值准备
       faaj163 LIKE faaj_t.faaj163, #本位币三处置成本
       faaj164 LIKE faaj_t.faaj164, #本位币三处置累折
       faaj165 LIKE faaj_t.faaj165, #本位币三本期处置累折
       faaj166 LIKE faaj_t.faaj166, #本位币三交易价格差异
       faaj167 LIKE faaj_t.faaj167, #本位币三调整成本
       faajownid LIKE faaj_t.faajownid, #资料所有者
       faajowndp LIKE faaj_t.faajowndp, #资料所有部门
       faajcrtid LIKE faaj_t.faajcrtid, #资料录入者
       faajcrtdp LIKE faaj_t.faajcrtdp, #资料录入部门
       faajcrtdt LIKE faaj_t.faajcrtdt, #资料创建日
       faajmodid LIKE faaj_t.faajmodid, #资料更改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近更改日
       faajstus LIKE faaj_t.faajstus, #状态码
       faaj048 LIKE faaj_t.faaj048 #资产分类
END RECORD
DEFINE g_faaj          DYNAMIC ARRAY OF g_faaj_d
#add by geza 20161123 #161111-00028#6(E)
DEFINE g_wc_cs_ld          STRING     
DEFINE g_wc_cs_orga        STRING
DEFINE g_flag               LIKE type_t.chr1

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afap400.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap400 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap400_init()   
 
      #進入選單 Menu (="N")
      CALL afap400_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap400
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('b_faah005','9903')
   CALL cl_set_combo_scc('b_faah042','9917')
   CALL cl_set_combo_scc('b_faaj003','9904')
   CALL cl_set_combo_scc_part('b_faaj006','9912','1,2,4') 
   CALL cl_set_act_visible('filter,qbeclear',FALSE)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap400_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL afap400_ui_dialog_1()
   RETURN
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap400_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah005,faah006,faah007,faah008,faah026 
            BEFORE CONSTRUCT
             CALL cl_qbe_init() 
         
         END CONSTRUCT 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
            CALL afap400_filter()
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
            CALL afap400_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap400_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
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
 
{<section id="afap400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap400_query()
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
   CALL afap400_b_fill()
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
 
{<section id="afap400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_faarsite    LIKE faar_t.faarsite
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT faarsite FROM faar_t WHERE 1=2 AND faarent = ? "
   #end add-point
 
   PREPARE afap400_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap400_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   l_faarsite 
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
      
      CALL afap400_detail_show()      
 
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
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afap400_sel
   
   LET l_ac = 1
   CALL afap400_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap400_fetch()
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
 
{<section id="afap400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap400_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap400_filter()
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
   
   CALL afap400_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap400_filter_parser(ps_field)
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
 
{<section id="afap400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap400_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION afap400_ui_dialog_1()
  DEFINE li_idx     LIKE type_t.num10
  DEFINE l_count    LIKE type_t.num5
  DEFINE g_rec_b    LIKE type_t.num5              #單身筆數   
  DEFINE l_ooef207  LIKE ooef_t.ooef207 
  DEFINE l_sql      STRING 
  DEFINE l_origin_str  STRING
  
  
  
  LET g_flag = 'N'
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap400_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT BY NAME g_master.faarsite,g_master.faarld,g_master.faar001
          
            BEFORE INPUT 
              
               
            BEFORE FIELD faarsite 
              LET g_master_t.faarsite = g_master.faarsite
              
            AFTER FIELD faarsite 
              IF NOT cl_null(g_master.faarsite) THEN
                 #检查组织资料的合理性             
                 IF NOT s_afat502_site_chk(g_master.faarsite) THEN                                 
                       LET g_master.faarsite = g_master_t.faarsite
                       CALL afap400_faarsite_desc()
                       NEXT FIELD CURRENT
                 END IF 
                 #檢查是否資產組織                 
                 LET l_count = 0
                 SELECT COUNT(1) INTO l_count 
                   FROM ooef_t
                  WHERE ooefent = g_enterprise 
                    AND ooef001 = g_master.faarsite
                    AND ooef207 = 'Y'
                 IF l_count =0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'afa-00004'
                    LET g_errparam.extend = g_master.faarsite
                    LET g_errparam.popup = FALSE
                    CALL cl_err()                   
                    LET g_master.faarsite = g_master_t.faarsite
                    CALL afap400_faarsite_desc()
                    NEXT FIELD CURRENT
                 END IF       
                 #user需要檢查和資產中心的權限
                 IF NOT s_afat502_site_user_chk(g_master.faarsite,g_user) THEN
                    LET g_master.faarsite = g_master_t.faarsite
                    CALL afap400_faarsite_desc()
                    NEXT FIELD CURRENT  
                 END IF
                                                     
              END IF
              
              #法人
              SELECT ooef017 INTO g_master.ooef017
                FROM ooef_t
               WHERE ooefent = g_enterprise AND ooef001 = g_master.faarsite 
               IF cl_null(g_master.faarsite) THEN
                  LET g_master.ooef017 =''
               END IF
               #账套 
                CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_sql
                LET l_sql = " SELECT DISTINCT glaald ",
                            "   FROM glaa_t ",
                            "  WHERE glaaent = ",g_enterprise," AND glaacomp = '",g_master.ooef017,"'",
                            "    AND glaastus = 'Y' AND glaa014 = 'Y' AND ",l_sql  
                PREPARE glaald_pre_1 FROM l_sql
                EXECUTE glaald_pre_1 INTO g_master.faarld
                   FREE glaald_pre_1
               
                CALL afap400_faarld_desc() 
               CALL afap400_faarsite_desc()
               CALL afap400_ooef017_desc() 
             


            BEFORE FIELD faarld 
              LET g_master_t.faarld = g_master.faarld
            AFTER FIELD faarld 
              IF NOT cl_null(g_master.faarld) THEN
                
                 INITIALIZE g_chkparam.* TO NULL                
                 #設定g_chkparam.*的參數
                 LET g_chkparam.arg1= g_master.faarld
                
                 LET g_errshow = TRUE 
                 LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
             
                 #呼叫檢查存在並帶值的library
                 IF cl_chk_exist("v_glaald") THEN
                 
                 ELSE
                    LET g_master.faarld = g_master_t.faarld
                    CALL afap400_faarld_desc()
                    NEXT FIELD CURRENT                   
                 END IF               
                 IF NOT s_ld_chk_authorization(g_user,g_master.faarld) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'agl-00165'
                    LET g_errparam.extend = g_master.faarld
                    LET g_errparam.popup = FALSE
                    CALL cl_err()                   
                    LET g_master.faarld = g_master_t.faarld
                    CALL afap400_faarld_desc()
                    NEXT FIELD CURRENT
                 END IF
                 
                 #资产中心不为空时
                 IF NOT cl_null(g_master.faarsite) THEN
                    IF NOT s_afat502_site_ld_chk(g_master.faarsite,g_master.faarld) THEN
                       LET g_master.faarld = g_master_t.faarld
                       CALL afap400_faarld_desc()
                       NEXT FIELD CURRENT
                    END IF
                 END IF
                 
              END IF
              CALL afap400_faarld_desc()
              
            BEFORE FIELD faar001
            
            AFTER FIELD faar001
            
            ON ACTION controlp INFIELD faarsite 
            
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
             
              LET g_qryparam.default1 = g_master.faarsite           #給予default值
              LET g_qryparam.where = " ooef207 = 'Y' "
              #給予arg
              LET g_qryparam.arg1 = "" #                          
              
              CALL q_ooef001()                                #呼叫開窗
             
              LET g_master.faarsite = g_qryparam.return1              
             
              DISPLAY g_master.faarsite TO faarsite
              
              NEXT FIELD faarsite              
              
            ON ACTION controlp INFIELD faarld
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
              
               LET g_qryparam.default1 = g_master.faarld          #給予default值
              
               CALL s_fin_create_account_center_tmp()   
               #取得资产組織下所屬成員
               CALL s_fin_account_center_sons_query('5',g_master.faarsite,g_master.faar001,'1')
               #取得资产中心下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING l_origin_str
               #將取回的字串轉換為SQL條件
               CALL afap400_change_to_sql(l_origin_str) RETURNING l_origin_str  
               
               LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1)            
               LET g_qryparam.where = "  (glaa008 = 'Y' OR glaa014 = 'Y') " 
               #給予arg
               LET g_qryparam.arg1 = g_user #
               LET g_qryparam.arg2 = g_dept #
              
               #账套范围
               CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
               IF NOT cl_null(g_wc_cs_ld) THEN   
                  LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
               END IF
             
               
               CALL q_authorised_ld()                                #呼叫開窗
              
               LET g_master.faarld = g_qryparam.return1              
              
               DISPLAY g_master.faarld TO faarld  
               
               NEXT FIELD faarld 
               
            AFTER INPUT 
         
         END INPUT

         CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah005,faah006,faah007,faah008,faah026 
            BEFORE CONSTRUCT
             CALL cl_qbe_init() 
            
            ON ACTION controlp INFIELD faah001 
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        IF g_prog = "afap400" THEN
		           LET g_qryparam.where =" faaj048 = '2' "
		        END IF
		        IF g_prog = "afap401" THEN
		           LET g_qryparam.where =" faaj048 = '1' "
		        END IF
		        LET g_qryparam.arg1 = g_master.faarld
		        CALL q_faah001_03()           
              DISPLAY g_qryparam.return1 TO faah001 #顯示到畫面上           
              NEXT FIELD faah001  
              
           ON ACTION controlp INFIELD faah003 
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        IF g_prog = "afap400" THEN
		           LET g_qryparam.where =" faaj048 = '2' "
		        END IF
		        IF g_prog = "afap401" THEN
		           LET g_qryparam.where =" faaj048 = '1' "
		        END IF
		        LET g_qryparam.arg1 = g_master.faarld
		        CALL q_faah003_14()           
              DISPLAY g_qryparam.return1 TO faah003 #顯示到畫面上           
              NEXT FIELD faah003
              
           ON ACTION controlp INFIELD faah004 
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        IF g_prog = "afap400" THEN
		           LET g_qryparam.where =" faaj048 = '2' "
		        END IF
		        IF g_prog = "afap401" THEN
		           LET g_qryparam.where =" faaj048 = '1' "
		        END IF
		        LET g_qryparam.arg1 = g_master.faarld
		        CALL q_faah004_4()           
              DISPLAY g_qryparam.return1 TO faah004 #顯示到畫面上           
              NEXT FIELD faah004
              
           ON ACTION controlp INFIELD faah006
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        CALL q_faac001()           
              DISPLAY g_qryparam.return1 TO faah006 #顯示到畫面上           
              NEXT FIELD faah006
              
           ON ACTION controlp INFIELD faah007
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        CALL q_faad001()           
              DISPLAY g_qryparam.return1 TO faah007 #顯示到畫面上           
              NEXT FIELD faah007
              
           ON ACTION controlp INFIELD faah008     
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
		       LET g_qryparam.arg1 = '3903'
             CALL q_oocq002()                #呼叫開窗
             DISPLAY g_qryparam.return1 TO faah008 #顯示到畫面上
             NEXT FIELD faah008  
          ON ACTION controlp INFIELD faah026     
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        CALL q_ooeg001_4()           
              DISPLAY g_qryparam.return1 TO faah026 #顯示到畫面上           
              NEXT FIELD faah026
              
              
         END CONSTRUCT 
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
                  
             BEFORE INPUT
                LET g_rec_b = g_detail_d.getLength()
                CALL cl_set_comp_entry("b_faah003,b_faah001,b_faah004,b_faah006,b_faah007,b_faah005,b_faah008,b_faah042,b_faaj006,b_faaj023,b_faaj024,b_faaj025,b_faaj026,b_faaj003,b_faaj005,b_faaj016,b_faaj017",FALSE)
             
             BEFORE ROW
               LET l_ac = ARR_CURR()             
          
         END INPUT           
         
#         SUBDIALOG lib_cl_schedule.cl_schedule_setting
#         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
#         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
#         SUBDIALOG lib_cl_schedule.cl_schedule_show_history         
                
         BEFORE DIALOG
#            IF g_detail_d.getLength() > 0 THEN
#               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
#            ELSE
#               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#            END IF
            #add-point:ui_dialog段before_dialog2
             #资产中心、账套、法人及其说明预设
               SELECT ooef207 INTO l_ooef207
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_site 
                IF l_ooef207 = 'Y' THEN
                   LET g_master.faarsite = g_site
                ELSE
                   LET g_master.faarsite = '' 
                END IF 
                
                #法人
                SELECT ooef017 INTO g_master.ooef017
                  FROM ooef_t
                 WHERE ooefent = g_enterprise AND ooef001 = g_master.faarsite                
                IF cl_null(g_master.faarsite) THEN
                   LET g_master.ooef017 =''
                END IF
                CALL afap400_faarsite_desc()
                CALL afap400_ooef017_desc()
                
                #账套 
                CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_sql
                LET l_sql = " SELECT DISTINCT glaald ",
                            "   FROM glaa_t ",
                            "  WHERE glaaent = ",g_enterprise," AND glaacomp = '",g_master.ooef017,"'",
                            "    AND glaastus = 'Y' AND glaa014 = 'Y' AND ",l_sql  
                PREPARE glaald_pre FROM l_sql
                EXECUTE glaald_pre INTO g_master.faarld
                   FREE glaald_pre
               
                CALL afap400_faarld_desc() 
                
                #预设转换日期
                LET g_master.faar001 = g_today
                #預設资产性质
                DISPLAY '1' TO faah005
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall

            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel

            #end add-point
      
#         ON ACTION filter
#            LET g_action_choice="filter"
#            CALL afap400_filter()
#            #add-point:ON ACTION filter
#
#            #END add-point
#            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
         
           CALL afap400_b_fill_1(g_wc)
           IF g_detail_d.getLength() = 0  THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "" 
             LET g_errparam.code   = -100 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET INT_FLAG=FALSE   
             EXIT DIALOG           
          END IF
          
           NEXT FIELD sel
           
         ON ACTION batch_execute
         
            #单身没有选择资料，报错提示
            FOR li_idx = 1 TO g_detail_d.getLength()
                IF g_detail_d[li_idx].sel ='Y' THEN
                   LET g_flag ='Y' 
                   EXIT FOR
                END IF
            END FOR
            
            IF g_flag = 'N' THEN                                 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD sel
            ELSE        
              LET g_action_choice="batch_execute"
              ACCEPT DIALOG
           END IF
           
         # 條件清除
#         ON ACTION qbeclear
#            #add-point:ui_dialog段
#
#            #end add-point
# 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh

            #end add-point
            CALL afap400_b_fill_1(g_wc)
 
         #add-point:ui_dialog段action

         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF            
      IF g_action_choice = "batch_execute" THEN        
           CALL afap400_prosess()
      END IF
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
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
PRIVATE FUNCTION afap400_b_fill_1(p_wc)
 DEFINE p_wc          STRING 
 DEFINE l_sql         STRING
 DEFINE l_cnt         LIKE type_t.num5
 DEFINE l_year        LIKE type_t.num5
 DEFINE l_month       LIKE type_t.num5
 DEFINE l_num1        LIKE type_t.num5
 DEFINE l_num2        LIKE type_t.num5
 DEFINE l_str         STRING
 DEFINE l_str1        STRING
 DEFINE l_str2        STRING
 DEFINE l_fristdate   LIKE faah_t.faah014
 DEFINE l_faal005     LIKE faal_t.faal005
 
    CALL g_detail_d.clear()
    LET l_cnt = 1
    IF cl_null(p_wc) THEN
       LET p_wc = " 1=1" 
    END IF
    
    IF g_prog = "afap400" THEN
       LET l_sql = " SELECT '',faah003,faah001,faah004,faah006,faacl003,faah007,faadl003,faah005,",
                   #"   faah008,oocql004,faah042,faaj006,faaj023,faaj024,faaj025,faaj026,faaj003,faaj005,faaj016,faaj017,faaj_t.* ", #mark by geza 20161123 #161111-00028#6
                   "   faah008,oocql004,faah042,faaj006,faaj023,faaj024,faaj025,faaj026,faaj003,faaj005,faaj016,faaj017, ", #add by geza 20161123 #161111-00028#6
                   "   faajent,faajld,faajsite,faaj000,faaj001,
                       faaj002,faaj003,faaj004,faaj005,faaj006,
                       faaj007,faaj008,faaj009,faaj010,faaj011,
                       faaj012,faaj013,faaj014,faaj015,faaj016,
                       faaj017,faaj018,faaj019,faaj020,faaj021,
                       faaj022,faaj023,faaj024,faaj025,faaj026,
                       faaj027,faaj028,faaj029,faaj030,faaj031,
                       faaj032,faaj033,faaj034,faaj035,faaj036,
                       faaj037,faaj038,faaj039,faaj040,faaj041,
                       faaj042,faaj043,faaj044,faaj045,faaj046,
                       faaj047,faaj101,faaj102,faaj103,faaj104,
                       faaj105,faaj106,faaj107,faaj108,faaj109,
                       faaj110,faaj111,faaj112,faaj113,faaj114,
                       faaj115,faaj116,faaj117,faaj151,faaj152,
                       faaj153,faaj154,faaj155,faaj156,faaj157,
                       faaj158,faaj159,faaj160,faaj161,faaj162,
                       faaj163,faaj164,faaj165,faaj166,faaj167,
                       faajownid,faajowndp,faajcrtid,faajcrtdp,
                       faajcrtdt,faajmodid,faajmoddt,faajstus,
                       faaj048 ",  #add by geza 20161123 #161111-00028#6    
                   "   FROM faah_t LEFT JOIN faaj_t ON faahent = faajent AND faah000 = faaj000 AND faah001 = faaj037 ",
                   "    AND faah003 = faaj001  AND faah004 = faaj002 ",
                   "   LEFT JOIN faacl_t ON faahent = faaclent AND faah006 = faacl001 AND faacl002 = '"||g_dlang||"' ",
                   "   LEFT JOIN faadl_t ON faahent = faadlent AND faah007 = faadl001 AND faadl002 = '"||g_dlang||"' ",
                   "   LEFT JOIN oocql_t ON faahent = oocqlent AND faah008 = oocql002 AND oocql001 = '3903' AND oocql003 = '"||g_dlang||"' ",
                   "  WHERE faahent = ",g_enterprise," AND faajld = '",g_master.faarld,"'",
                   "    AND faah015 = '4' ",
                   "    AND faaj048 = '2' ",
                   "    AND faahstus = 'Y' ",                
                   "    AND ",p_wc CLIPPED                         
    END IF 
    IF g_prog = "afap401" THEN
       LET l_sql = " SELECT '',faah003,faah001,faah004,faah006,faacl003,faah007,faadl003,faah005,",
                   #"   faah008,oocql004,faah042,faaj006,faaj023,faaj024,faaj025,faaj026,faaj003,faaj005,faaj016,faaj017,faaj_t.* ", #mark by geza 20161123 #161111-00028#6
                   "   faah008,oocql004,faah042,faaj006,faaj023,faaj024,faaj025,faaj026,faaj003,faaj005,faaj016,faaj017, ", #add by geza 20161123 #161111-00028#6
                   "   faajent,faajld,faajsite,faaj000,faaj001,
                       faaj002,faaj003,faaj004,faaj005,faaj006,
                       faaj007,faaj008,faaj009,faaj010,faaj011,
                       faaj012,faaj013,faaj014,faaj015,faaj016,
                       faaj017,faaj018,faaj019,faaj020,faaj021,
                       faaj022,faaj023,faaj024,faaj025,faaj026,
                       faaj027,faaj028,faaj029,faaj030,faaj031,
                       faaj032,faaj033,faaj034,faaj035,faaj036,
                       faaj037,faaj038,faaj039,faaj040,faaj041,
                       faaj042,faaj043,faaj044,faaj045,faaj046,
                       faaj047,faaj101,faaj102,faaj103,faaj104,
                       faaj105,faaj106,faaj107,faaj108,faaj109,
                       faaj110,faaj111,faaj112,faaj113,faaj114,
                       faaj115,faaj116,faaj117,faaj151,faaj152,
                       faaj153,faaj154,faaj155,faaj156,faaj157,
                       faaj158,faaj159,faaj160,faaj161,faaj162,
                       faaj163,faaj164,faaj165,faaj166,faaj167,
                       faajownid,faajowndp,faajcrtid,faajcrtdp,
                       faajcrtdt,faajmodid,faajmoddt,faajstus,
                       faaj048 ",  #add by geza 20161123 #161111-00028#6  
                   "   FROM faah_t LEFT JOIN faaj_t ON faahent = faajent AND faah000 = faaj000 AND faah001 = faaj037 ",
                   "    AND faah003 = faaj001  AND faah004 = faaj002 ",
                   "   LEFT JOIN faacl_t ON faahent = faaclent AND faah006 = faacl001 AND faacl002 = '"||g_dlang||"' ",
                   "   LEFT JOIN faadl_t ON faahent = faadlent AND faah007 = faadl001 AND faadl002 = '"||g_dlang||"' ",
                   "   LEFT JOIN oocql_t ON faahent = oocqlent AND faah008 = oocql002 AND oocql001 = '3903' AND oocql003 = '"||g_dlang||"' ",
                   "  WHERE faahent = ",g_enterprise," AND faajld = '",g_master.faarld,"'",
                   "    AND faah015 NOT IN (0,10)",
                   "    AND faaj048 = '1' ",
                   "    AND faahstus = 'Y' ", 
                   "    AND ",p_wc CLIPPED                  
    END  IF    
    LET l_sql = l_sql CLIPPED," ORDER BY faah003 " 
    LET l_cnt = 1
    PREPARE afap400_bp_pre FROM l_sql
    DECLARE afap400_bp_cs CURSOR FOR afap400_bp_pre
    
    FOREACH afap400_bp_cs INTO g_detail_d[l_cnt].*,g_faaj[l_cnt].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_detail_d[l_cnt].sel = 'Y'
         IF g_prog = "afap401" THEN
            #开始折旧年月
            IF cl_null(g_faaj[l_cnt].faaj009) THEN
               #抓取本月入帳提列方式
               LET l_faal005 = ''          
               SELECT faal005 INTO l_faal005
                 FROM faal_t
                WHERE faalent = g_enterprise
                  AND faalld  = g_master.faarld
                  AND faal001 = g_detail_d[l_cnt].faah006
              LET l_year = YEAR(g_master.faar001)
              LET l_month = MONTH(g_master.faar001)  
               IF NOT cl_null(l_faal005) THEN 
                  IF l_faal005 = '1' THEN 
                     LET l_num2 = l_month + 1
                     IF l_num2 > 12 THEN 
                        LET l_num2 = 1
                        LET l_num1 = l_year + 1
                     ELSE
                        LET l_num2 = l_num2
                        LET l_num1 = l_year
                     END IF
                  END IF 
                  IF l_faal005 = '2' OR l_faal005 = '4' THEN 
                     LET l_num1 = l_year
                     LET l_num2 = l_month
                  END IF
                  IF l_faal005 = '3' THEN 
                     CALL s_date_get_first_date(g_master.faar001) RETURNING l_fristdate
                     LET l_fristdate = l_fristdate + 14
                     IF g_master.faar001 <= l_fristdate THEN 
                        LET l_num1 = l_year
                        LET l_num2 = l_month
                     ELSE
                        LET l_num2 = l_month + 1
                        IF l_num2 > 12 THEN 
                           LET l_num2 = 1
                           LET l_num1 = l_year + 1
                        ELSE
                           LET l_num2 = l_num2
                           LET l_num1 = l_year
                        END IF
                     END IF 
                  END IF 
                  LET l_str1 = l_num1
                  LET l_str2 = l_num2
                  IF l_num2 < 10 THEN 
                     LET l_str = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
                  ELSE
                     LET l_str = l_str1 CLIPPED,l_str2 CLIPPED
                  END IF
                  LET g_faaj[l_cnt].faaj008 = l_str.trim()
               END IF 
            ELSE
               LET g_faaj[l_cnt].faaj008 = g_faaj[l_cnt].faaj008
            END IF
         END IF
         
        LET l_cnt = l_cnt + 1
         IF l_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF 
         
    END FOREACH
    
   # LET l_cnt = g_detail_d.getLength()
    CALL g_detail_d.deleteElement(g_detail_d.getLength())
    
   # LET l_cnt = g_detail_d.getLength()
    
    CALL cl_err_collect_show()
  
END FUNCTION

################################################################################
# Descriptions...: 资产中心说明
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
PRIVATE FUNCTION afap400_faarsite_desc()
   
   #资产中心
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.faarsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.faarsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.faarsite,g_master.faarsite_desc
     
   
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
PRIVATE FUNCTION afap400_ooef017_desc()
   #法人
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.ooef017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.ooef017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.ooef017,g_master.ooef017_desc
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
PRIVATE FUNCTION afap400_faarld_desc()
   #帳套
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.faarld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.faarld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.faarld,g_master.faarld_desc
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
PRIVATE FUNCTION afap400_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
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
PRIVATE FUNCTION afap400_prosess()
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   DEFINE li_idx        LIKE type_t.num5
   
#   IF g_bgjob = "N" THEN
#   
#   END IF  
#      #单身没有选择资料，报错提示
#      FOR li_idx = 1 TO g_detail_d.getLength()
#          IF g_detail_d[li_idx].sel ="Y" THEN
#             LET g_flag ='Y' 
#             EXIT FOR
#          END IF
#      END FOR
#      IF li_idx = g_detail_d.getLength() AND g_flag ='N' THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "" 
#         LET g_errparam.code   = 'afa-01114'
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         RETURN
#      END IF   
   CALL afap400_upd_faaj()
   
    CALL afap400_b_fill_1(g_wc)
   CALL cl_ask_confirm3("std-00012","")
   
  
   
   INITIALIZE g_msgparam TO NULL 
   #action-id與狀態填寫
   LET g_msgparam.state = "process" 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
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
PRIVATE FUNCTION afap400_upd_faaj()
  DEFINE  l_cnt       LIKE type_t.num5
  DEFINE  l_year      STRING
  DEFINE  l_month     STRING
  DEFINE  l_str       STRING
  DEFINE  l_faar000   LIKE faar_t.faar000
  
  
   CALL cl_err_collect_init()   
   LET g_success = 'Y'
   CALL s_transaction_begin()
   
   FOR l_cnt = 1 TO g_detail_d.getLength()
     
     IF g_prog ="afap400" THEN #列账转列管 
       IF g_detail_d[l_cnt].sel = "Y" THEN
          #符合条件资料中选定的资料
          UPDATE faaj_t SET faaj048 = '1'
           WHERE faajent = g_enterprise AND faajld = g_master.faarld
             AND faaj000 = g_faaj[l_cnt].faaj000 AND faaj001 = g_faaj[l_cnt].faaj001 
             AND faaj002 = g_faaj[l_cnt].faaj002 AND faaj037 = g_faaj[l_cnt].faaj037                         
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN           
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'upd faaj_t'
             LET g_errparam.extend = 'faaj001：'||g_faaj[l_cnt].faaj001
             LET g_errparam.popup = TRUE
             CALL cl_err()           
             LET g_success='N'
             CONTINUE FOR
          ELSE          
             #批号 
             LET l_year = YEAR(g_today)
             LET l_month = MONTH(g_today)
             IF l_month < 10 THEN 
                LET l_month = '0' CLIPPED,l_month
             END IF
             
             LET l_str = l_year CLIPPED,l_month
             
             LET g_sql = "SELECT MAX(faar000) ",
                         "  FROM faar_t ",
                         " WHERE faarent = '",g_enterprise,"'",
                         "   AND faar000 LIKE '",l_str,"%'"
             PREPARE faar000_pre FROM g_sql
             EXECUTE faar000_pre INTO l_faar000
             IF cl_null(l_faar000) THEN 
                LET l_faar000 = l_str,'0001'
             ELSE
                LET g_sql = "SELECT lpad((lpad((substr(MAX(faar000),7,10) + 1),4,'0')),10,'",l_str,"')",
                            "  FROM faar_t ",
                            " WHERE faarent = '",g_enterprise,"'",
                            "   AND faar000 LIKE '",l_str,"%'"
                PREPARE faar000_pre1 FROM g_sql
                EXECUTE faar000_pre1 INTO l_faar000
             END IF 
             #更新成功,插入faar表 
             INSERT INTO faar_t(faarent,faarld,faarsite,faar000,faar001,
                                faar002,faar003,faar004,faar005,faar006)
                  VALUES(g_enterprise,g_master.faarld,g_site,l_faar000,g_master.faar001,
                         g_detail_d[l_cnt].faah003,g_detail_d[l_cnt].faah001,
                         g_detail_d[l_cnt].faah004,'2','1')
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ins faar_t'
                LET g_errparam.extend = 'faar002：'||g_detail_d[l_cnt].faah003
                LET g_errparam.popup = TRUE
                CALL cl_err()
               # LET g_cnt2 = g_cnt2 + 1
                LET g_success='N'
                CONTINUE FOR
             END IF                      
          END IF
       END IF       
     END IF
     IF g_prog ="afap401" THEN #列管转列账 
       IF g_detail_d[l_cnt].sel = "Y" THEN
       #符合条件资料中选定的+分摊方式、资产科目、累折科目、折旧科目、减值准备科目、折旧方式不为空
          UPDATE faaj_t SET faaj048 = '2',
                            faaj008 = g_faaj[l_cnt].faaj008 
           WHERE faajent = g_enterprise AND faajld = g_master.faarld
             AND faaj000 = g_faaj[l_cnt].faaj000 AND faaj001 = g_faaj[l_cnt].faaj001 
             AND faaj002 = g_faaj[l_cnt].faaj002 AND faaj037 = g_faaj[l_cnt].faaj037
             AND faaj006 IS NOT NULL AND faaj023 IS NOT NULL AND faaj024 IS NOT NULL
             AND faaj025 IS NOT NULL AND faaj026 IS NOT NULL AND faaj003 IS NOT NULL            
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN           
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'upd faaj_t'
             LET g_errparam.extend = 'faaj001：'||g_faaj[l_cnt].faaj001
             LET g_errparam.popup = TRUE
             CALL cl_err()           
             LET g_success='N'
             CONTINUE FOR
          ELSE 
             #批号 
             LET l_year = YEAR(g_today)
             LET l_month = MONTH(g_today)
             IF l_month < 10 THEN 
                LET l_month = '0' CLIPPED,l_month
             END IF
             
             LET l_str = l_year CLIPPED,l_month
             
             LET g_sql = "SELECT MAX(faar000) ",
                         "  FROM faar_t ",
                         " WHERE faarent = '",g_enterprise,"'",
                         "   AND faar000 LIKE '",l_str,"%'"
             PREPARE faar000_pre_1 FROM g_sql
             EXECUTE faar000_pre_1 INTO l_faar000
             IF cl_null(l_faar000) THEN 
                LET l_faar000 = l_str,'0001'
             ELSE
                LET g_sql = "SELECT lpad((lpad((substr(MAX(faar000),7,10) + 1),4,'0')),10,'",l_str,"')",
                            "  FROM faar_t ",
                            " WHERE faarent = '",g_enterprise,"'",
                            "   AND faar000 LIKE '",l_str,"%'"
                PREPARE faar000_pre2 FROM g_sql
                EXECUTE faar000_pre2 INTO l_faar000
             END IF 
             #更新成功,插入faar表 
             INSERT INTO faar_t(faarent,faarld,faarsite,faar000,faar001,
                                faar002,faar003,faar004,faar005,faar006)
                  VALUES(g_enterprise,g_master.faarld,g_site,l_faar000,g_master.faar001,
                         g_detail_d[l_cnt].faah003,g_detail_d[l_cnt].faah001,
                         g_detail_d[l_cnt].faah004,'1','2')
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ins faar_t'
                LET g_errparam.extend = 'faar002：'||g_detail_d[l_cnt].faah003
                LET g_errparam.popup = TRUE
                CALL cl_err()
               # LET g_cnt2 = g_cnt2 + 1
                LET g_success='N'
                CONTINUE FOR
             END IF                      
          END IF
       END IF
     END IF
         
   END FOR
    IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
    ELSE
      CALL s_transaction_end('N','0')
    END IF 
   CALL cl_err_collect_show()
     
END FUNCTION

#end add-point
 
{</section>}
 

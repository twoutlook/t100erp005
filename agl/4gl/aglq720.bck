#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq720.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000112
#+ 
#+ Filename...: aglq720
#+ Description: 科目核算項各期餘額查詢作業
#+ Creator....: 02599(2014/03/23)
#+ Modifier...: 02599(2014/03/25)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq720.global" >}
#151231-00004#1  2015/12/31  By 02599  期初金额算法错误，改成当破期时抓取年期金额 + 抓取起始年期第一天到起始日期前一天的凭证金额
#151204-00013#2  2016/01/12  By 02599  当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#160118-00012#1  2016/01/19  By 02599  修改合计，当勾选'显示统治科目'时，合计金额去除统治科目金额
#160225-00014#1  2016/02/25  By 03538  抓取期初金額時,借-貸金額剛好為0,不代表借貸方就都是0;所以另外分別抓取借貸方金額
#160302-00006#1  2016/03/02  By 07675  原本单身为可查询作业，增加二次筛选功能    
#160503-00037#2  2016/05/06  By 07900  本年累计数不应含期初第0期的数据
#160505-00007#14 2016/05/17  By 02599  程式优化
#160509-00004#104 2016/7/6   By 05948  營運據點默認值改為N
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq720_print_tmp -->aglq720_tmp01
#160804-00002#1  2016/08/04  By 02599  output函数中FOR循环INSERT语句中的数组下表错误给了l_ac应该是l_i
#160824-00004#2  2016/08/31  By 02599  排除XC凭证时限定科目费用类别glac010<>N.非费用科目
#160912-00013#1  2016/09/12  By 02599  抓取核算项说明SQL语句修正
#160913-00017#4  2016/09/21  By 07900  AGL模组调整交易客商开窗
#160824-00004#4  2016/09/23  By 02599  排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161011-00018#1  2016/10/14  By 02599  去除 first next last jump previous 这些action的权限检核
#161021-00037#1  2016/10/24  By 06821  組織類型與職能開窗調整
#161027-00022#1  2016/10/27  By 02599  含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型
#161031-00075#1  2016/11/03  By 01531  aglq720、730，单据状态选择：3.全部 的时候，一级科目数据没有合并 
#170106-00024#1  2017/01/12  By 02599  跨年查询时不可以串查到aglq750
 
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
   glar009 LIKE glar_t.glar009, 
   oyeard LIKE glaq_t.glaq003, 
   oyearc LIKE glaq_t.glaq003, 
   yeard LIKE glaq_t.glaq003, 
   yearc LIKE glaq_t.glaq003, 
   yeard2 LIKE glaq_t.glaq003, 
   yearc2 LIKE glaq_t.glaq003, 
   yeard3 LIKE glaq_t.glaq003, 
   yearc3 LIKE glaq_t.glaq003, 
   oqcd LIKE glaq_t.glaq003, 
   oqcc LIKE glaq_t.glaq003, 
   qcd LIKE glaq_t.glaq003, 
   qcc LIKE glaq_t.glaq003, 
   qcd2 LIKE glaq_t.glaq003, 
   qcc2 LIKE glaq_t.glaq003, 
   qcd3 LIKE glaq_t.glaq003, 
   qcc3 LIKE glaq_t.glaq003, 
   oqjd LIKE glaq_t.glaq003, 
   oqjc LIKE glaq_t.glaq003, 
   qjd LIKE glaq_t.glaq003, 
   qjc LIKE glaq_t.glaq003, 
   qjd2 LIKE glaq_t.glaq003, 
   qjc2 LIKE glaq_t.glaq003, 
   qjd3 LIKE glaq_t.glaq003, 
   qjc3 LIKE glaq_t.glaq003, 
   oqmd LIKE glaq_t.glaq003, 
   oqmc LIKE glaq_t.glaq003, 
   qmd LIKE glaq_t.glaq003, 
   qmc LIKE glaq_t.glaq003, 
   qmd2 LIKE glaq_t.glaq003, 
   qmc2 LIKE glaq_t.glaq003, 
   qmd3 LIKE glaq_t.glaq003, 
   qmc3 LIKE glaq_t.glaq003, 
   osumd LIKE glaq_t.glaq003, 
   osumc LIKE glaq_t.glaq003, 
   sumd LIKE glaq_t.glaq003, 
   sumc LIKE glaq_t.glaq003, 
   sumd2 LIKE glaq_t.glaq003, 
   sumc2 LIKE glaq_t.glaq003, 
   sumd3 LIKE glaq_t.glaq003, 
   sumc3 LIKE glaq_t.glaq003 
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
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       curr_o          LIKE type_t.chr1, 
       curr_p          LIKE type_t.chr1, 
       show_y          LIKE type_t.chr1, 
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad         LIKE type_t.chr1,
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
#       glad014         LIKE type_t.chr1,
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
DEFINE g_glar009       LIKE glar_t.glar009
DEFINE g_glar_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glar009         LIKE glar_t.glar009
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_xg_visible    STRING     #XG欄位隱藏條件
#160505-00007#14--add--str--
#多語言SQL
DEFINE g_get_sql   RECORD
       glar012     STRING,  #营运据点
       glar013     STRING,  #部门
       glar014     STRING,  #责任中心
       glar015     STRING,  #区域
       glar016     STRING,  #收付款客商
       glar017     STRING,  #账款客商
       glar018     STRING,  #客群
       glar019     STRING,  #产品类别
       glar020     STRING,  #人员
       glar022     STRING,  #专案编号
       glar023     STRING,  #WBS
       glar052     STRING,  #渠道
       glar053     STRING   #品牌  
                   END RECORD   
#160505-00007#14--add--end
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq720.main" >}
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
   DECLARE aglq720_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq720_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq720 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq720_init()   
 
      #進入選單 Menu (="N")
      CALL aglq720_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq720
      
   END IF 
   
   CLOSE aglq720_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq720_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq720.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq720_init()
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
   CALL aglq720_glaald_desc(g_glaald)
   CALL aglq720_set_default_value()
   #建立临时表
   CALL aglq720_create_temp_table()
   CALL cl_set_combo_scc('b_glar051','6013')
   
   #160505-00007#14--add--str--
   #核算项说明组成SQL
   #营运据点
   CALL s_fin_get_department_sql('ta3','glarent','glar012') RETURNING g_get_sql.glar012
   #部門
   CALL s_fin_get_department_sql('ta4','glarent','glar013') RETURNING g_get_sql.glar013
   #利润成本中心
   CALL s_fin_get_department_sql('ta5','glarent','glar014') RETURNING g_get_sql.glar014
   #区域
   CALL s_fin_get_acc_sql('ta6','glarent','287','glar015') RETURNING g_get_sql.glar015
   #收付款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta7','glarent','glar016') RETURNING g_get_sql.glar016
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','glarent','glar017') RETURNING g_get_sql.glar017
   #客群
   CALL s_fin_get_acc_sql('ta9','glarent','281','glar018') RETURNING g_get_sql.glar018
   #产品类别
   CALL s_fin_get_rtaxl003_sql('ta10','glarent','glar019') RETURNING g_get_sql.glar019
   #人员
   CALL s_fin_get_person_sql('ta11','glarent','glar020') RETURNING g_get_sql.glar020
   #专案
   CALL s_fin_get_project_sql('ta12','glarent','glar022') RETURNING g_get_sql.glar022
   #WBS
   CALL s_fin_get_wbs_sql('ta13','glarent','glar022','glar023') RETURNING g_get_sql.glar023
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','glarent','glar052') RETURNING g_get_sql.glar052
   #品牌
   CALL s_fin_get_acc_sql('ta15','glarent','2002','glar053') RETURNING g_get_sql.glar053
   #160505-00007#14--add--end
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq720.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq720_ui_dialog()
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
   
   CALL aglq720_query()
   
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
               CALL aglq720_fetch()
               #add-point:input段before row
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glar_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
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
      
         
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

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
               CALL aglq720_glaald_desc(g_glaald)
               CALL aglq720_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION first
 
            LET g_action_choice="fetch" #161011-00018#1 mod first-->fetch
#            IF cl_auth_chk_act("first") THEN  #161011-00018#1 mark
               #add-point:ON ACTION first
               CALL aglq720_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION jump
 
            LET g_action_choice="fetch" #161011-00018#1 mod jump-->fetch
#            IF cl_auth_chk_act("jump") THEN #161011-00018#1 mark
               #add-point:ON ACTION jump
               CALL aglq720_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION last
 
            LET g_action_choice="fetch" #161011-00018#1 mod last-->fetch
#            IF cl_auth_chk_act("last") THEN  #161011-00018#1 mark
               #add-point:ON ACTION last
               CALL aglq720_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION next
 
            LET g_action_choice="fetch" #161011-00018#1 mod next-->fetch
#            IF cl_auth_chk_act("next") THEN  #161011-00018#1 mark
               #add-point:ON ACTION next
               CALL aglq720_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               CALL aglq720_output()      #160505-00007#14 add
#               CALL aglq720_xg_visible() #160505-00007#14 mark
#               CALL aglq720_x01(' 1=1','aglq720_print_tmp',g_xg_visible) #160505-00007#14 mark
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION previous
 
            LET g_action_choice="fetch" #161011-00018#1 mod previous-->fetch
#            IF cl_auth_chk_act("previous") THEN  #161011-00018#1 mark
               #add-point:ON ACTION previous
               CALL aglq720_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq720_query()
               #add-point:ON ACTION query
               EXIT DIALOG
               #END add-point
            END IF
 
      
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
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  CALL aglq720_cmdrun() #串查aglq750總分類帳核算项資料                    
               END IF
               EXIT DIALOG
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq720_filter()
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
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq720_glaald_desc(g_glaald)
            CALL aglq720_set_default_value()
            CALL aglq720_query()
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL aglq720_b_fill()
            CALL aglq720_fetch()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum
 
            #END add-point
            CALL cl_user_overview()
 
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
 
{<section id="aglq720.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq720_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
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
   DEFINE l_cnt            LIKE type_t.num5
   
   #建立临时表
#   CALL aglq720_create_temp_table()  #160505-00007#14 mark
   LET  l_flag=TRUE
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
      CONSTRUCT g_wc_table ON glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019, 
          glar051,glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,
          glar027,glar028,glar029,glar030,glar031,glar032,glar033,glar009
           FROM s_detail1[1].b_glar001,s_detail1[1].b_glar012,s_detail1[1].b_glar013,s_detail1[1].b_glar014, 
               s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017,s_detail1[1].b_glar018, 
               s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,s_detail1[1].b_glar053,
               s_detail1[1].b_glar020,s_detail1[1].b_glar022,s_detail1[1].b_glar023,s_detail1[1].b_glar024,
               s_detail1[1].b_glar025,s_detail1[1].b_glar026,s_detail1[1].b_glar027,s_detail1[1].b_glar028,
               s_detail1[1].b_glar029,s_detail1[1].b_glar030,s_detail1[1].b_glar031,s_detail1[1].b_glar032,
               s_detail1[1].b_glar033,s_detail1[1].b_glar009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
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
            
 
         #----<<b_glar012>>----
         #Ctrlp:construct.c.page1.b_glar012
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#1 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD b_glar012                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar012
            #add-point:BEFORE FIELD b_glar012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar012
            
            #add-point:AFTER FIELD b_glar012

            #END add-point
            
 
         #----<<b_glar013>>----
         #Ctrlp:construct.c.page1.b_glar013
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

            NEXT FIELD b_glar013                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar013
            #add-point:BEFORE FIELD b_glar013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar013
            
            #add-point:AFTER FIELD b_glar013

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

            NEXT FIELD b_glar014                     #返回原欄位


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
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark    
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
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark    
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
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

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

            NEXT FIELD b_glar053                     #返回原欄位

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar052
            #add-point:BEFORE FIELD b_glar052

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar052
            
            #add-point:AFTER FIELD b_glar052

            #END add-point
            
 
         #----<<b_glar022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar022
            #add-point:BEFORE FIELD b_glar022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar022
            
            #add-point:AFTER FIELD b_glar022

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glar022
         ON ACTION controlp INFIELD b_glar022
            #add-point:ON ACTION controlp INFIELD b_glar022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022     #顯示到畫面上
            NEXT FIELD b_glar022
            #END add-point
 
         #----<<b_glar023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar023
            #add-point:BEFORE FIELD b_glar023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar023
            
            #add-point:AFTER FIELD b_glar023

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glar023
         ON ACTION controlp INFIELD b_glar023
            #add-point:ON ACTION controlp INFIELD b_glar023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上

            NEXT FIELD b_glar023                     #返回原欄位
            #END add-point
 
         #----<<b_glar009>>----
         #Ctrlp:construct.c.page1.b_glar009
         ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上

            NEXT FIELD b_glar009                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glar009
            #add-point:BEFORE FIELD b_glar009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glar009
            
            #add-point:AFTER FIELD b_glar009

            #END add-point
            
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      INPUT BY NAME tm.sdate,tm.edate,tm.ctype,tm.curr_o,tm.curr_p,tm.show_y,
                    tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,
                    tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,
                    tm.glad011,tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,tm.glad015,tm.glad016,
                    tm.glad017,tm.glad018,tm.glad019,tm.glad020,tm.glad021,tm.glad022,tm.glad023,
                    tm.glad024,tm.glad025,tm.glad026
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(tm.edate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD sdate
                  END IF
               END IF
               LET tm.syear=l_glav002
               LET tm.speriod=l_glav006
               DISPLAY tm.syear,tm.speriod TO syear,speriod 
            END IF
            
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD edate
               END IF
               IF NOT cl_null(tm.sdate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD edate
                  END IF
               END IF
               LET tm.eyear=l_glav002
               LET tm.eperiod=l_glav006
               DISPLAY tm.eyear,tm.eperiod TO eyear,eperiod 
            END IF
         
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq720_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         ON CHANGE curr_o 
            IF tm.curr_o MATCHES '[yYnN]' THEN
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('b_glar009,oqcd,oqcc,oqjd,oqjc,oqmd,oqmc,osumd,osumc',TRUE)
                  CALL aglq720_set_comp_entry('curr_p',TRUE)
                  IF tm.show_y='Y' THEN
                     CALL cl_set_comp_visible('oyeard,oyearc',TRUE)
                  END IF
               ELSE
                  CALL cl_set_comp_visible('b_glar009,oyeard,oyearc,oqcd,oqcc,oqjd,oqjc,oqmd,oqmc,osumd,osumc',FALSE)
                  CALL aglq720_set_comp_entry('curr_p',FALSE)
                  LET tm.curr_p='N'
                  DISPLAY tm.curr_p TO curr_p
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
            
         ON CHANGE curr_p
            IF tm.curr_p NOT MATCHES '[yYnN]' THEN
                NEXT FIELD curr_p
            END IF
            
         ON CHANGE show_y
            IF tm.show_y NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_y
            END IF
            IF tm.show_y='Y' THEN
               CALL cl_set_comp_visible('yeard,yearc',TRUE)
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('oyeard,oyearc',TRUE)
               END IF
               IF tm.ctype='1' OR tm.ctype='3' THEN
                  CALL cl_set_comp_visible('yeard2,yearc2',TRUE)
               END IF
               IF tm.ctype='2' OR tm.ctype='3' THEN
                  CALL cl_set_comp_visible('yeard3,yearc3',TRUE)
               END IF
            ELSE
               CALL cl_set_comp_visible('oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3',FALSE)
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
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL cl_set_comp_visible('group3',TRUE)
        CALL aglq720_show()
        LET g_glar_d[1].sel = ""
        DISPLAY ARRAY g_glar_d TO s_detail1.*
           BEFORE DISPLAY
              EXIT DISPLAY
        END DISPLAY
        
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #預設
         CALL aglq720_glaald_desc(g_glaald)
         CALL aglq720_set_default_value()
         CALL cl_set_comp_visible('group3',TRUE)
         CALL aglq720_show()
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
#      CALL aglq720_get_data() #160505-00007#14 mark
      CALL aglq720_get_data2() #160505-00007#14 add
      SELECT COUNT(*) INTO l_cnt FROM aglq720_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq720_set_page()
      CALL aglq720_fetch1('F')
   ELSE
      CALL aglq720_b_fill1()
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_glar_s.getLength() TO FORMONLY.h_count
      DISPLAY g_detail_idx TO FORMONLY.idx
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aglq720_b_fill()
   LET l_ac = g_master_idx
   CALL aglq720_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq720.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq720_b_fill()
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
       '',glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,glar023,glar009,'','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '' FROM glar_t",
 
 
               "",
               " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
  
   #add-point:b_fill段sql_after

   #end add-point
  
   PREPARE aglq720_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq720_pb
   
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
       g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar009,g_glar_d[l_ac].oyeard,g_glar_d[l_ac].oyearc,g_glar_d[l_ac].yeard, 
       g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2,g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3, 
       g_glar_d[l_ac].oqcd,g_glar_d[l_ac].oqcc,g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2, 
       g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3,g_glar_d[l_ac].qcc3,g_glar_d[l_ac].oqjd,g_glar_d[l_ac].oqjc, 
       g_glar_d[l_ac].qjd,g_glar_d[l_ac].qjc,g_glar_d[l_ac].qjd2,g_glar_d[l_ac].qjc2,g_glar_d[l_ac].qjd3, 
       g_glar_d[l_ac].qjc3,g_glar_d[l_ac].oqmd,g_glar_d[l_ac].oqmc,g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc, 
       g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2,g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3,g_glar_d[l_ac].osumd, 
       g_glar_d[l_ac].osumc,g_glar_d[l_ac].sumd,g_glar_d[l_ac].sumc,g_glar_d[l_ac].sumd2,g_glar_d[l_ac].sumc2, 
       g_glar_d[l_ac].sumd3,g_glar_d[l_ac].sumc3
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
      
      CALL aglq720_detail_show()      
 
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
   FREE aglq720_pb
   
   LET l_ac = 1
   CALL aglq720_fetch()
   
      CALL aglq720_filter_show('glar001','b_glar001')
   CALL aglq720_filter_show('glar012','b_glar012')
   CALL aglq720_filter_show('glar013','b_glar013')
   CALL aglq720_filter_show('glar014','b_glar014')
   CALL aglq720_filter_show('glar015','b_glar015')
   CALL aglq720_filter_show('glar016','b_glar016')
   CALL aglq720_filter_show('glar017','b_glar017')
   CALL aglq720_filter_show('glar018','b_glar018')
   CALL aglq720_filter_show('glar019','b_glar019')
   CALL aglq720_filter_show('glar051','b_glar051')
   CALL aglq720_filter_show('glar052','b_glar052')
   CALL aglq720_filter_show('glar053','b_glar053')
   CALL aglq720_filter_show('glar020','b_glar020')
   CALL aglq720_filter_show('glar022','b_glar022')
   CALL aglq720_filter_show('glar023','b_glar023')
   CALL aglq720_filter_show('glar009','b_glar009')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq720.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq720_fetch()
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
 
{<section id="aglq720.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq720_detail_show()
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
#160505-00007#14--mark--str--
#   #科目編號
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glar_d[l_ac].glar001
#   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glar_d[l_ac].glar001_desc=g_rtn_fields[1]
#   #營運據點
#   IF tm.comp='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] =g_glar_d[l_ac].glar012
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar012_desc=g_rtn_fields[1]
#   END IF
#   #部門
#   IF tm.glad007='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] =g_glar_d[l_ac].glar013
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar013_desc=g_rtn_fields[1]
#   END IF
#   #成本中心
#   IF tm.glad008='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] =g_glar_d[l_ac].glar014
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar014_desc=g_rtn_fields[1]
#   END IF
#   #區域
#   IF tm.glad009='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = '287'
#      LET g_ref_fields[2] = g_glar_d[l_ac].glar015
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar015_desc=g_rtn_fields[1] 
#   END IF
#   #交易客戶
#   IF tm.glad010='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_glar_d[l_ac].glar016
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar016_desc=g_rtn_fields[1]
#   END IF
#   #帳款客戶
#   IF tm.glad027='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_glar_d[l_ac].glar017
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar017_desc=g_rtn_fields[1]
#   END IF
#   #客群   
#   IF tm.glad011='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = '281'
#      LET g_ref_fields[2] = g_glar_d[l_ac].glar018
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar018_desc=g_rtn_fields[1] 
#   END IF
#   #產品類別
#   IF tm.glad012='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_glar_d[l_ac].glar019
#      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar019_desc=g_rtn_fields[1]
#   END IF
#   #人員編號
#   IF tm.glad013='Y' THEN
#      SELECT ooag011 INTO g_glar_d[l_ac].glar020_desc FROM ooag_t 
#      WHERE ooagent = g_enterprise AND ooag001 = g_glar_d[l_ac].glar020
#   END IF
##   #預算編號
##   IF tm.glad014='Y' THEN
##      INITIALIZE g_ref_fields TO NULL
##      LET g_ref_fields[1] = g_glar_d[l_ac].glar021
##      CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
##      LET g_glar_d[l_ac].glar021_desc=g_rtn_fields[1]
##   END IF
#   #渠道   
#   IF tm.glad032='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_glar_d[l_ac].glar052
#      CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar052_desc=g_rtn_fields[1] 
#   END IF
#   #品牌   
#   IF tm.glad033='Y' THEN
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = '2002'
#      LET g_ref_fields[2] = g_glar_d[l_ac].glar053
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_glar_d[l_ac].glar053_desc=g_rtn_fields[1] 
#   END IF
#   
#   #專案
#   IF tm.glad015='Y' THEN
#      CALL s_desc_get_project_desc(g_glar_d[l_ac].glar022) RETURNING g_glar_d[l_ac].glar022_desc
#   END IF
#   
#   #WBS
#   IF tm.glad016='Y' THEN
#      CALL s_desc_get_wbs_desc(g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar023) RETURNING g_glar_d[l_ac].glar023_desc
#   END IF
#160505-00007#14--mark--end
   
   #自由核算項
   SELECT glad0171,glad0181,glad0191,glad0201,glad0211,glad0221,
          glad0231,glad0221,glad0251,glad0261
    INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,l_glad0221,
          l_glad0231,l_glad0241,l_glad0251,l_glad0261
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_glaald
      AND glad001 = g_glar_d[l_ac].glar001
#   IF tm.glad017='Y'  THEN  #160505-00007#14 mark
   IF tm.glad017='Y' AND NOT cl_null(g_glar_d[l_ac].glar024) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0171,g_glar_d[l_ac].glar024) RETURNING g_glar_d[l_ac].glar024_desc
   END IF
#   IF tm.glad018='Y' THEN  #160505-00007#14 mark
   IF tm.glad018='Y' AND NOT cl_null(g_glar_d[l_ac].glar025) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0181,g_glar_d[l_ac].glar025) RETURNING g_glar_d[l_ac].glar025_desc
   END IF
#   IF tm.glad019='Y' THEN  #160505-00007#14 mark
   IF tm.glad019='Y' AND NOT cl_null(g_glar_d[l_ac].glar026) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0191,g_glar_d[l_ac].glar026) RETURNING g_glar_d[l_ac].glar026_desc
   END IF
#   IF tm.glad020='Y' THEN  #160505-00007#14 mark
   IF tm.glad020='Y' AND NOT cl_null(g_glar_d[l_ac].glar027) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0201,g_glar_d[l_ac].glar027) RETURNING g_glar_d[l_ac].glar027_desc
   END IF
#   IF tm.glad021='Y' THEN  #160505-00007#14 mark
   IF tm.glad021='Y' AND NOT cl_null(g_glar_d[l_ac].glar028) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0211,g_glar_d[l_ac].glar028) RETURNING g_glar_d[l_ac].glar028_desc
   END IF
#   IF tm.glad022='Y' THEN  #160505-00007#14 mark
   IF tm.glad022='Y' AND NOT cl_null(g_glar_d[l_ac].glar029) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0221,g_glar_d[l_ac].glar029) RETURNING g_glar_d[l_ac].glar029_desc
   END IF
#   IF tm.glad023='Y' THEN  #160505-00007#14 mark
   IF tm.glad023='Y' AND NOT cl_null(g_glar_d[l_ac].glar030) THEN #160505-00007#14 add 
      CALL s_voucher_free_account_desc(l_glad0231,g_glar_d[l_ac].glar030) RETURNING g_glar_d[l_ac].glar030_desc
   END IF
#   IF tm.glad024='Y' THEN  #160505-00007#14 mark
   IF tm.glad024='Y' AND NOT cl_null(g_glar_d[l_ac].glar031) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0241,g_glar_d[l_ac].glar031) RETURNING g_glar_d[l_ac].glar031_desc
   END IF
#   IF tm.glad025='Y' THEN  #160505-00007#14 mark
   IF tm.glad025='Y' AND NOT cl_null(g_glar_d[l_ac].glar032) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0251,g_glar_d[l_ac].glar032) RETURNING g_glar_d[l_ac].glar032_desc
   END IF
#   IF tm.glad026='Y' THEN  #160505-00007#14 mark
   IF tm.glad026='Y' AND NOT cl_null(g_glar_d[l_ac].glar033) THEN #160505-00007#14 add
      CALL s_voucher_free_account_desc(l_glad0261,g_glar_d[l_ac].glar033) RETURNING g_glar_d[l_ac].glar033_desc
   END IF
   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq720_filter()
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
      CONSTRUCT g_wc_filter ON glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019, 
          glar051,glar052,glar053,glar020,glar022,glar023,glar009
                          FROM s_detail1[1].b_glar001,s_detail1[1].b_glar012,s_detail1[1].b_glar013, 
                              s_detail1[1].b_glar014,s_detail1[1].b_glar015,s_detail1[1].b_glar016,s_detail1[1].b_glar017, 
                              s_detail1[1].b_glar018,s_detail1[1].b_glar019,s_detail1[1].b_glar051,s_detail1[1].b_glar052,
                              s_detail1[1].b_glar053,s_detail1[1].b_glar020,s_detail1[1].b_glar022,s_detail1[1].b_glar023, 
                              s_detail1[1].b_glar009
       #160302-00006#1  2016/03/02 By 07675  add -str
               
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
 
            NEXT FIELD b_glar001                     #返回原欄位
 
            #END add-point
 
     
         ON ACTION controlp INFIELD b_glar012
            #add-point:ON ACTION controlp INFIELD b_glar012
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#1 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar012  #顯示到畫面上
            #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 
 
            NEXT FIELD b_glar012                     #返回原欄位
 
             #END add-point
       
       
         ON ACTION controlp INFIELD b_glar013
            #add-point:ON ACTION controlp INFIELD b_glar013
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar013  #顯示到畫面上
             #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 
 
            NEXT FIELD b_glar013                     #返回原欄位
            
             #END add-point
 
         
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
 
            NEXT FIELD b_glar014                     #返回原欄位
 
 
            #END add-point
 
         
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
 
        
         ON ACTION controlp INFIELD b_glar016
            #add-point:ON ACTION controlp INFIELD b_glar016
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark    
            DISPLAY g_qryparam.return1 TO b_glar016  #顯示到畫面上
 
            NEXT FIELD b_glar016                     #返回原欄位
 
            #END add-point
 
 
          ON ACTION controlp INFIELD b_glar017
            #add-point:ON ACTION controlp INFIELD b_glar017
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark    
            DISPLAY g_qryparam.return1 TO b_glar017  #顯示到畫面上
 
            NEXT FIELD b_glar017                     #返回原欄位
 
            #END add-point
 
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
 
 
        ON ACTION controlp INFIELD b_glar020
            #add-point:ON ACTION controlp INFIELD b_glar020
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar020  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 
 
            NEXT FIELD b_glar020                     #返回原欄位
 
 
            #END add-point
 
      
 
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
 
            NEXT FIELD b_glar053                     #返回原欄位
 
            #END add-point
 
    
          ON ACTION controlp INFIELD b_glar022
            #add-point:ON ACTION controlp INFIELD b_glar022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar022     #顯示到畫面上
            NEXT FIELD b_glar022
            #END add-point
 
  
          ON ACTION controlp INFIELD b_glar023
            #add-point:ON ACTION controlp INFIELD b_glar023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar023  #顯示到畫面上
 
            NEXT FIELD b_glar023                     #返回原欄位
            
            #END add-point
 
       ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
 
            NEXT FIELD b_glar009                     #返回原欄位
 
 
            #END add-point
 
           #160302-00006#1  2016/03/02 By 07675  add -end
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            DISPLAY aglq720_filter_parser('glar001') TO s_detail1[1].b_glar001
            DISPLAY aglq720_filter_parser('glar012') TO s_detail1[1].b_glar012
            DISPLAY aglq720_filter_parser('glar013') TO s_detail1[1].b_glar013
            DISPLAY aglq720_filter_parser('glar014') TO s_detail1[1].b_glar014
            DISPLAY aglq720_filter_parser('glar015') TO s_detail1[1].b_glar015
            DISPLAY aglq720_filter_parser('glar016') TO s_detail1[1].b_glar016
            DISPLAY aglq720_filter_parser('glar017') TO s_detail1[1].b_glar017
            DISPLAY aglq720_filter_parser('glar018') TO s_detail1[1].b_glar018
            DISPLAY aglq720_filter_parser('glar019') TO s_detail1[1].b_glar019
            DISPLAY aglq720_filter_parser('glar051') TO s_detail1[1].b_glar051
            DISPLAY aglq720_filter_parser('glar052') TO s_detail1[1].b_glar052
            DISPLAY aglq720_filter_parser('glar053') TO s_detail1[1].b_glar053
            DISPLAY aglq720_filter_parser('glar020') TO s_detail1[1].b_glar020
            DISPLAY aglq720_filter_parser('glar022') TO s_detail1[1].b_glar022
            DISPLAY aglq720_filter_parser('glar023') TO s_detail1[1].b_glar023
            DISPLAY aglq720_filter_parser('glar009') TO s_detail1[1].b_glar009
 
 
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
   
      CALL aglq720_filter_show('glar001','b_glar001')
      CALL aglq720_filter_show('glar012','b_glar012')
      CALL aglq720_filter_show('glar013','b_glar013')
      CALL aglq720_filter_show('glar014','b_glar014')
      CALL aglq720_filter_show('glar015','b_glar015')
      CALL aglq720_filter_show('glar016','b_glar016')
      CALL aglq720_filter_show('glar017','b_glar017')
      CALL aglq720_filter_show('glar018','b_glar018')
      CALL aglq720_filter_show('glar019','b_glar019')
      CALL aglq720_filter_show('glar051','b_glar051')
      CALL aglq720_filter_show('glar052','b_glar052')
      CALL aglq720_filter_show('glar053','b_glar053')
      CALL aglq720_filter_show('glar020','b_glar020')
      CALL aglq720_filter_show('glar022','b_glar022')
      CALL aglq720_filter_show('glar023','b_glar023')
      CALL aglq720_filter_show('glar009','b_glar009')
 
    
   
    CALL aglq720_b_fill1() #160302-00006#1  ADD By 07675
  # CALL aglq720_b_fill()
  # CALL aglq720_fetch()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq720_filter_parser(ps_field)
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
 
{<section id="aglq720.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq720_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq720_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.insert" >}
#+ insert
PRIVATE FUNCTION aglq720_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq720.modify" >}
#+ modify
PRIVATE FUNCTION aglq720_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq720_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.delete" >}
#+ delete
PRIVATE FUNCTION aglq720_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq720.other_function" >}
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq720_create_temp_table()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_create_temp_table()
   DROP TABLE aglq720_tmp
   CREATE TEMP TABLE aglq720_tmp(
   glarent      LIKE glar_t.glarent,  #160505-00007#14 add
   glar001      LIKE glar_t.glar001,
   glar012      LIKE glar_t.glar012,
   glar013      LIKE glar_t.glar013,
   glar014      LIKE glar_t.glar014,
   glar015      LIKE glar_t.glar015,
   glar016      LIKE glar_t.glar016,
   glar017      LIKE glar_t.glar017,
   glar018      LIKE glar_t.glar018,
   glar019      LIKE glar_t.glar019,
   glar051      LIKE glar_t.glar051,
   glar052      LIKE glar_t.glar052,
   glar053      LIKE glar_t.glar053,
   glar020      LIKE glar_t.glar020,
   glar022      LIKE glar_t.glar022,
   glar023      LIKE glar_t.glar023,
   glar024      LIKE glar_t.glar024,
   glar025      LIKE glar_t.glar025,
   glar026      LIKE glar_t.glar026,
   glar027      LIKE glar_t.glar027,
   glar028      LIKE glar_t.glar028,
   glar029      LIKE glar_t.glar029,
   glar030      LIKE glar_t.glar030,
   glar031      LIKE glar_t.glar031,
   glar032      LIKE glar_t.glar032,
   glar033      LIKE glar_t.glar033,
   glar009      LIKE glar_t.glar009,
   oyeard       LIKE glaq_t.glaq003,
   oyearc       LIKE glaq_t.glaq003,
   yeard        LIKE glaq_t.glaq003,
   yearc        LIKE glaq_t.glaq003,
   yeard2       LIKE glaq_t.glaq003,
   yearc2       LIKE glaq_t.glaq003,
   yeard3       LIKE glaq_t.glaq003,
   yearc3       LIKE glaq_t.glaq003,
   oqcd         LIKE glaq_t.glaq003,
   oqcc         LIKE glaq_t.glaq003,
   qcd          LIKE glaq_t.glaq003,
   qcc          LIKE glaq_t.glaq003,
   qcd2         LIKE glaq_t.glaq003,
   qcc2         LIKE glaq_t.glaq003,
   qcd3         LIKE glaq_t.glaq003,
   qcc3         LIKE glaq_t.glaq003,
   oqjd         LIKE glaq_t.glaq003,
   oqjc         LIKE glaq_t.glaq003,
   qjd          LIKE glaq_t.glaq003,
   qjc          LIKE glaq_t.glaq003,
   qjd2         LIKE glaq_t.glaq003,
   qjc2         LIKE glaq_t.glaq003,
   qjd3         LIKE glaq_t.glaq003,
   qjc3         LIKE glaq_t.glaq003,
   oqmd         LIKE glaq_t.glaq003,
   oqmc         LIKE glaq_t.glaq003,
   qmd          LIKE glaq_t.glaq003,
   qmc          LIKE glaq_t.glaq003,
   qmd2         LIKE glaq_t.glaq003,
   qmc2         LIKE glaq_t.glaq003,
   qmd3         LIKE glaq_t.glaq003,
   qmc3         LIKE glaq_t.glaq003,
   osumd        LIKE glaq_t.glaq003,
   osumc        LIKE glaq_t.glaq003,
   sumd         LIKE glaq_t.glaq003,
   sumc         LIKE glaq_t.glaq003,
   sumd2        LIKE glaq_t.glaq003,
   sumc2        LIKE glaq_t.glaq003,
   sumd3        LIKE glaq_t.glaq003,
   sumc3        LIKE glaq_t.glaq003)
   
   DROP TABLE aglq720_tmp01              #160727-00019#3  Mod  aglq720_print_tmp -->aglq720_tmp01
   CREATE TEMP TABLE aglq720_tmp01(      #160727-00019#3  Mod  aglq720_print_tmp -->aglq720_tmp01
   glaald_desc LIKE type_t.chr500,
   glaacomp_desc LIKE type_t.chr500,
   glaa001_desc LIKE type_t.chr500,
   sdate LIKE type_t.chr500,
   edate LIKE type_t.chr500,
   ctype LIKE type_t.chr500,
   glac005 LIKE glac_t.glac005,
   stus LIKE type_t.chr500,
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
   glar051 LIKE type_t.chr500,
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
   glar009 LIKE glar_t.glar009, 
   oyeard LIKE glaq_t.glaq003, 
   oyearc LIKE glaq_t.glaq003, 
   yeard LIKE glaq_t.glaq003, 
   yearc LIKE glaq_t.glaq003, 
   yeard2 LIKE glaq_t.glaq003, 
   yearc2 LIKE glaq_t.glaq003, 
   yeard3 LIKE glaq_t.glaq003, 
   yearc3 LIKE glaq_t.glaq003, 
   oqcd LIKE glaq_t.glaq003, 
   oqcc LIKE glaq_t.glaq003, 
   qcd LIKE glaq_t.glaq003, 
   qcc LIKE glaq_t.glaq003, 
   qcd2 LIKE glaq_t.glaq003, 
   qcc2 LIKE glaq_t.glaq003, 
   qcd3 LIKE glaq_t.glaq003, 
   qcc3 LIKE glaq_t.glaq003, 
   oqjd LIKE glaq_t.glaq003, 
   oqjc LIKE glaq_t.glaq003, 
   qjd LIKE glaq_t.glaq003, 
   qjc LIKE glaq_t.glaq003, 
   qjd2 LIKE glaq_t.glaq003, 
   qjc2 LIKE glaq_t.glaq003, 
   qjd3 LIKE glaq_t.glaq003, 
   qjc3 LIKE glaq_t.glaq003, 
   oqmd LIKE glaq_t.glaq003, 
   oqmc LIKE glaq_t.glaq003, 
   qmd LIKE glaq_t.glaq003, 
   qmc LIKE glaq_t.glaq003, 
   qmd2 LIKE glaq_t.glaq003, 
   qmc2 LIKE glaq_t.glaq003, 
   qmd3 LIKE glaq_t.glaq003, 
   qmc3 LIKE glaq_t.glaq003, 
   osumd LIKE glaq_t.glaq003, 
   osumc LIKE glaq_t.glaq003, 
   sumd LIKE glaq_t.glaq003, 
   sumc LIKE glaq_t.glaq003, 
   sumd2 LIKE glaq_t.glaq003, 
   sumc2 LIKE glaq_t.glaq003, 
   sumd3 LIKE glaq_t.glaq003, 
   sumc3 LIKE glaq_t.glaq003
   )
END FUNCTION
################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq720_set_curr_show()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard2,yearc2",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard2,yearc2",FALSE)
      END IF
      CALL cl_set_comp_visible("qcd2,qcc2,qjd2,qjc2,qmd2,qmc2,sumd2,sumc2",TRUE)
   ELSE
      CALL cl_set_comp_visible("yeard2,yearc2,qcd2,qcc2,qjd2,qjc2,qmd2,qmc2,sumd2,sumc2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard3,yearc3",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard3,yearc3",FALSE)
      END IF
      CALL cl_set_comp_visible("qcd3,qcc3,qjd3,qjc3,qmd3,qmc3,sumd3,sumc3",TRUE)
   ELSE
      CALL cl_set_comp_visible("yeard3,yearc3,qcd3,qcc3,qjd3,qjc3,qmd3,qmc3,sumd3,sumc3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      IF tm.show_y='Y' THEN
         CALL cl_set_comp_visible("yeard2,yearc2,yeard3,yearc3",TRUE)
      ELSE
         CALL cl_set_comp_visible("yeard2,yearc2,yeard3,yearc3",FALSE)
      END IF
      CALL cl_set_comp_visible("qcd2,qcc2,qjd2,qjc2,qmd2,qmc2,sumd2,sumc2",TRUE)
      CALL cl_set_comp_visible("qcd3,qcc3,qjd3,qjc3,qmd3,qmc3,sumd3,sumc3",TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq720_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_glaald_desc(p_glaald)
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
   #年初數
   IF cl_null(tm.show_y) THEN
      LET tm.show_y='N'
   END IF
   CALL aglq720_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION
################################################################################
# Descriptions...: 抓取數據
# Memo...........:
# Usage..........: CALL aglq720_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc                  STRING 
   DEFINE l_glaq002        STRING
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
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_oyeard         LIKE type_t.num20_6
   DEFINE l_oyearc         LIKE type_t.num20_6
   DEFINE l_yeard          LIKE type_t.num20_6
   DEFINE l_yearc          LIKE type_t.num20_6
   DEFINE l_yeard2         LIKE type_t.num20_6
   DEFINE l_yearc2         LIKE type_t.num20_6
   DEFINE l_yeard3         LIKE type_t.num20_6
   DEFINE l_yearc3         LIKE type_t.num20_6
   DEFINE l_oqcd           LIKE type_t.num20_6
   DEFINE l_oqcc           LIKE type_t.num20_6
   DEFINE l_qcd            LIKE type_t.num20_6
   DEFINE l_qcc            LIKE type_t.num20_6
   DEFINE l_qcd2           LIKE type_t.num20_6
   DEFINE l_qcc2           LIKE type_t.num20_6
   DEFINE l_qcd3           LIKE type_t.num20_6
   DEFINE l_qcc3           LIKE type_t.num20_6
   DEFINE l_oqjd           LIKE type_t.num20_6
   DEFINE l_oqjc           LIKE type_t.num20_6
   DEFINE l_qjd            LIKE type_t.num20_6
   DEFINE l_qjc            LIKE type_t.num20_6
   DEFINE l_qjd2           LIKE type_t.num20_6
   DEFINE l_qjc2           LIKE type_t.num20_6
   DEFINE l_qjd3           LIKE type_t.num20_6
   DEFINE l_qjc3           LIKE type_t.num20_6
   DEFINE l_oqmd           LIKE type_t.num20_6
   DEFINE l_oqmc           LIKE type_t.num20_6
   DEFINE l_qmd            LIKE type_t.num20_6
   DEFINE l_qmc            LIKE type_t.num20_6
   DEFINE l_qmd2           LIKE type_t.num20_6
   DEFINE l_qmc2           LIKE type_t.num20_6
   DEFINE l_qmd3           LIKE type_t.num20_6
   DEFINE l_qmc3           LIKE type_t.num20_6
   DEFINE l_osumd          LIKE type_t.num20_6
   DEFINE l_osumc          LIKE type_t.num20_6
   DEFINE l_sumd           LIKE type_t.num20_6
   DEFINE l_sumc           LIKE type_t.num20_6
   DEFINE l_sumd2          LIKE type_t.num20_6
   DEFINE l_sumc2          LIKE type_t.num20_6
   DEFINE l_sumd3          LIKE type_t.num20_6
   DEFINE l_sumc3          LIKE type_t.num20_6
   DEFINE l_amt1           LIKE type_t.num20_6
   DEFINE l_amt2           LIKE type_t.num20_6
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6
   DEFINE l_amt5           LIKE type_t.num20_6
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_amt7           LIKE type_t.num20_6
   DEFINE l_amt8           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2  STRING
   DEFINE l_str3,l_str4        STRING
   DEFINE l_num,l_i        LIKE type_t.num5
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_flag2          LIKE type_t.num5
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_glac002_str    STRING              #151204-00013#2 add
   DEFINE l_str01,l_str02  STRING   #160505-00007#14 add
   
   #刪除臨時表中資料
   DELETE FROM aglq720_tmp
   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.speriod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.eperiod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   #判斷是否是整期間查詢
   IF tm.sdate=l_pdate_s1 AND tm.edate=l_pdate_e2 THEN
      LET l_flag=TRUE
   ELSE
      LET l_flag=FALSE
   END IF
   #核算項條件篩選
   LET l_wc=cl_replace_str(g_wc,'glar001','glaq002')
   LET l_wc=cl_replace_str(l_wc,'glar009','glaq005')
   LET l_wc=cl_replace_str(l_wc,'glar012','glaq017')
   LET l_wc=cl_replace_str(l_wc,'glar013','glaq018')
   LET l_wc=cl_replace_str(l_wc,'glar014','glaq019')
   LET l_wc=cl_replace_str(l_wc,'glar015','glaq020')
   LET l_wc=cl_replace_str(l_wc,'glar016','glaq021')
   LET l_wc=cl_replace_str(l_wc,'glar017','glaq022')
   LET l_wc=cl_replace_str(l_wc,'glar018','glaq023')
   LET l_wc=cl_replace_str(l_wc,'glar019','glaq024')
   LET l_wc=cl_replace_str(l_wc,'glar020','glaq025')
#   LET l_wc=cl_replace_str(l_wc,'glar021','glaq026')
   LET l_wc=cl_replace_str(l_wc,'glar022','glaq027')
   LET l_wc=cl_replace_str(l_wc,'glar023','glaq028')
   LET l_wc=cl_replace_str(l_wc,'glar051','glaq051')
   LET l_wc=cl_replace_str(l_wc,'glar052','glaq052')
   LET l_wc=cl_replace_str(l_wc,'glar053','glaq053')
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
   
   LET l_num =g_wc.getIndexOf('glar001',1)
   IF l_num>0 THEN
      LET l_i=g_wc.getIndexOf('and',1)
      IF l_i=0 THEN
         LET l_sql1=g_wc
         LET l_wc = " 1=1 "
      ELSE
         LET l_sql1=g_wc.substring(l_num,l_i-1) 
         LET l_wc = l_wc.substring(l_i+3,l_wc.getLength())
      END IF
      LET l_sql1=" AND ",cl_replace_str(l_sql1,'glar001','glac002')
   END IF
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
   
#151204-00013#2--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#2--mark--end

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
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   #核算項
   CALL aglq720_fix_acc_get_sql() RETURNING l_str,l_str1,l_str2,l_str01,l_str02  #160505-00007#14 add l_str01,l_str02
   
   #抓出所有符合條件的會計科目
   LET g_sql="SELECT DISTINCT glac002 FROM glac_t",
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' ",l_sql1,
             " ORDER BY glac002"
   PREPARE aglq720_sel_glac_pr FROM g_sql
   DECLARE aglq720_sel_glac_cs CURSOR FOR aglq720_sel_glac_pr
   
   #判斷是否勾選原幣或核算項等
   LET l_num =l_str.getIndexOf('g',1)
   IF l_num>0 THEN 
      LET l_flag2=TRUE #表示勾選了顯示原幣或核算項     
   ELSE
      #年初，期初
      LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                 " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                 "   AND glar001=? AND glar002=? AND glar003<=? "
       PREPARE aglq720_sel_pr01 FROM l_sql
       
       #本年累計
       LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                 "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                 " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                 "   AND glar001=? AND glar002=? AND glar003<=? AND glar003<>0 "  #160503-00037#2 By 07900 add "AND glar003<>0"
       PREPARE aglq720_sel_pr03 FROM l_sql
       
       
   END IF
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #抓取該年第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #抓取上一期最後一天
   LET l_period=tm.speriod-1 #上期
   SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=l_period
   #获取期初截止日期
   IF tm.sdate=l_pdate_s1 THEN
      LET l_glav004_e=l_glav004_m
   ELSE
      LET l_glav004_e=tm.sdate-1
   END IF
   
   #科目遍歷
   FOREACH aglq720_sel_glac_cs INTO l_glac002
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','FOREACH aglq720_sel_glac_cs','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq720_sel_glac_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #抓取科目对应的明细科目或者独立科目
      CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
      
      #151204-00013#2--add--str--
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
      END IF
      #151204-00013#2--add--end
      
      #当该统治科目没有下层明细科目时，抓取该科目本身资料
      IF cl_null(l_glaq002) THEN
         LET l_glaq002 = " AND glaq002='",l_glac002,"'"
      ELSE
         LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
      END IF
      
      #當勾選了顯示原幣或核算項等條件后，依勾選條件遍歷查詢資料
      IF l_flag2=TRUE THEN
         IF l_flag=TRUE AND tm.syear=tm.eyear THEN #表示查询范围是整期间
            LET l_sql="(SELECT DISTINCT ",l_str,
                      "   FROM glar_t",
                      "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' AND glar001='",l_glac002,"'",
                      "    AND glar002=",tm.syear,
                      "    AND glar003<=",tm.eperiod,
                      "    AND ",g_wc,")"  
            #單據狀態      
            IF tm.stus MATCHES '[23]' THEN
               LET l_sql=l_sql,
                         " UNION ALL ",
                         "(SELECT DISTINCT ",l_str2,
                         "   FROM glaq_t",
                         "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                         "    AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear #抓取大于等于起始年度且小于截止日期的所有核算项
               CASE
                   WHEN tm.stus='2'
                      LET l_sql=l_sql," AND glapstus='Y'"
                   WHEN tm.stus='3'
                      LET l_sql=l_sql," AND glapstus IN ('Y','N')"
               END CASE
               LET l_sql=l_sql,l_sql2," AND ",l_wc,")"
            END IF
            LET l_sql="SELECT DISTINCT ",l_str,
                      "  FROM (",l_sql,")",
                      " ORDER BY ",l_str
         ELSE 
            LET l_sql="SELECT DISTINCT ",l_str1,
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                      "    AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear #抓取大于等于起始年度且小于截止日期的所有核算项
            LET l_sql=l_sql,l_sql2,l_sql4," AND ",l_wc,
                      " ORDER BY ",l_str1
         END IF
         PREPARE aglq720_sel_pr FROM l_sql
         DECLARE aglq720_sel_cr CURSOR FOR aglq720_sel_pr
         #原幣及核算項遍歷
         FOREACH aglq720_sel_cr INTO l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,
                                     l_glar022,l_glar023,l_glar024,l_glar025,l_glar026,l_glar027,
                                     l_glar028,l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,
                                     l_glar009
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','FOREACH aglq720_sel_cr','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'FOREACH aglq720_sel_cr'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            CALL aglq720_fix_acc_sql(l_glar009,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar020,l_glar022,l_glar023,l_glar051,l_glar052,l_glar053,
                                     l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                                     l_glar031,l_glar032,l_glar033)
            RETURNING l_str3,l_str4
            #年初、期初
            LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                      " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "   AND glar001=? AND glar002=? AND glar003<=? ",
                      l_str3
            PREPARE aglq720_sel_pr1 FROM l_sql
            #160225-00014#1--s
            #年初、期初借貸方個別金額
            LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                      "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) ",
                      "  FROM glar_t",                
                      " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "   AND glar001=? AND glar002=? AND glar003<=? ",
                      l_str3
            PREPARE aglq720_sel_pr11 FROM l_sql
            #160225-00014#1--e             
            
            #期初：抓取YE、AD傳票金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                       "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                       "   AND glap002= ? AND glap004<=? ",
                       "   AND glapstus='S'",
                       l_glaq002,l_str4,
                       l_sql3
            PREPARE aglq720_sel_pr6 FROM l_sql
            
            #破期時年初、期初根據傳票狀態（1、2、3）抓取資料
            LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                       "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                       "   AND glapdocdt BETWEEN ? AND ? ",
                       l_glaq002,l_str4,
                       l_sql2,l_sql4
            PREPARE aglq720_sel_pr2 FROM l_sql 
            
            #本年累計
            LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                      "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                      " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "   AND glar001=? AND glar002=? AND glar003<=? AND glar003<>0", #160503-00037#2 By 07900 add "AND glar003<>0"
                      l_str3
            PREPARE aglq720_sel_pr3 FROM l_sql
            
            #本年累計：抓取YE、AD憑證金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",  
                      "   AND glapstus='S'",
                      l_glaq002,l_str4,
                      l_sql3
            PREPARE aglq720_sel_pr7 FROM l_sql
            
            #破期本年累計
            LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glapdocdt BETWEEN ? AND ?  ",                    
                      l_glaq002,l_str4,
                      l_sql2,l_sql4
            PREPARE aglq720_sel_pr4 FROM l_sql
            
            #期間異動
            #当整期间且不跨年时抓取glar_t
            IF l_flag = TRUE AND tm.syear = tm.eyear THEN
               LET l_sql="(SELECT glar010,glar011,glar005,",
                         "        glar006,glar034,glar035,glar036,glar037",
                         "   FROM glar_t",
                         "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' AND glar001=?",
                         "    AND glar002=",tm.syear,
                         "    AND glar003 BETWEEN ",tm.speriod," AND ",tm.eperiod,
                         l_str3," AND ",g_wc,")"  
               #單據狀態      
               IF tm.stus MATCHES '[23]' THEN
                  LET l_sql=l_sql,
                            " UNION ALL ",
                            "(SELECT (CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END) glar010,",
                            "        (CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END) glar011,",
                            "        glaq003 glar005,glaq004 glar006,glaq040 glar034,",
                            "        glaq041 glar035,glaq043 glar036,glaq044 glar037",
                            "   FROM glaq_t",
                            "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                            "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                            "    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
                  CASE
                      WHEN tm.stus='2'
                         LET l_sql=l_sql," AND glapstus='Y'"
                      WHEN tm.stus='3'
                         LET l_sql=l_sql," AND glapstus IN ('Y','N')"
                  END CASE
                  LET l_sql=l_sql,l_sql2,l_str4,")"
               END IF
               LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),",
                         "       SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)",
                         "  FROM (",l_sql,")"
            ELSE 
               LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                         "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                         "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                         "       SUM(glaq043),SUM(glaq044)",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                         "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         l_sql2,l_sql4,l_str4
            END IF 
            PREPARE aglq720_sel_pr5 FROM l_sql
            
            #期間異動：抓取YE、AD憑證金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044)",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                      "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                      "   AND glapstus='S'",
                      l_sql3,l_str4
            PREPARE aglq720_sel_pr8 FROM l_sql
            
            #151204-00013#2--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               #期初：抓取CE、XC傳票金額
               LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                          "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                          "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                          " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                          "   AND glap002= ? AND glap004<=? ",
                          l_glaq002,l_str4,l_sql4,
                          "   AND (",
                          "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                          "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                          "                                         AND glac007='6' ",l_glac002_str,"))",
                          "         OR ",
                          "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                          "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                          "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                          "                                         AND glac007='5' ",l_glac002_str,"))",
                          "       )"
               PREPARE aglq720_sel_pr6_1 FROM l_sql
               
               #本年累計：抓取CE、XC憑證金額
               LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                         "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                         "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                         "       SUM(glaq043),SUM(glaq044) ",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                         "   AND glap002= ? AND glap004<=? ",  
                         l_glaq002,l_str4,l_sql4,
                         "   AND (",
                         "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                         AND glac007='6' ",l_glac002_str,"))",
                         "         OR ",
                         "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                         "                                         AND glac007='5' ",l_glac002_str,"))",
                         "       )"
               PREPARE aglq720_sel_pr7_1 FROM l_sql
            
               #期間異動：抓取CE、XC憑證金額
               LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                         "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                         "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                         "       SUM(glaq043),SUM(glaq044)",
                         "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                         " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                         "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         l_str4,l_sql4,
                         "   AND (",
                         "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                         AND glac007='6' ",l_glac002_str,"))",
                         "         OR ",
                         "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                         "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                         "                                         AND glac007='5' ",l_glac002_str,"))",
                         "       )"
               PREPARE aglq720_sel_pr8_1 FROM l_sql
            END IF
            #151204-00013#2--add--end
            
            #年初金額
            IF tm.show_y='Y' THEN
               LET l_period=0
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               EXECUTE aglq720_sel_pr1 USING l_glac002,tm.syear,l_period
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr1','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF l_amt2>0 THEN
                  LET l_oyeard=l_amt1
                  LET l_oyearc=0
                  LET l_yeard =l_amt2
                  LET l_yearc =0
                  LET l_yeard2=l_amt3
                  LET l_yearc2=0
                  LET l_yeard3=l_amt4
                  LET l_yearc3=0
               ELSE
                  LET l_oyeard=0
                  LET l_oyearc=-1*l_amt1
                  LET l_yeard =0
                  LET l_yearc =-1*l_amt2
                  LET l_yeard2=0
                  LET l_yearc2=-1*l_amt3
                  LET l_yeard3=0
                  LET l_yearc3=-1*l_amt4
               END IF 
            ELSE
               LET l_oyeard=0
               LET l_oyearc=0
               LET l_yeard =0
               LET l_yearc =0
               LET l_yeard2=0
               LET l_yearc2=0
               LET l_yeard3=0
               LET l_yearc3=0
            END IF
      
            #期初金額
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            LET l_period=tm.speriod-1 #上期
            #當整期間且傳狀態為stus=1:已過帳時，抓取匯總glar_t,否則抓取資料來源為glaq_t
            IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
               EXECUTE aglq720_sel_pr1 USING l_glac002,tm.syear,l_period
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr1','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
#               IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  #151204-00013#2 add
                  EXECUTE aglq720_sel_pr6 USING tm.syear,l_period
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
#                     CALL cl_errmsg('','aglq720_sel_pr6','',SQLCA.sqlcode,1)
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq720_sel_pr6'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_amt1=l_amt1-l_amt5
                  LET l_amt2=l_amt2-l_amt6
                  LET l_amt3=l_amt3-l_amt7
                  LET l_amt4=l_amt4-l_amt8
               END IF
            #當為破期時，匯總該年第一天到查詢條件的起始日期tm.sdate的傳票資料
            ELSE
               #抓取年初金額
               LET l_period=0
               EXECUTE aglq720_sel_pr1 USING l_glac002,tm.syear,l_period
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr1','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               
#               LET l_period=tm.speriod-1 #上期  #151231-00004#1 mark
#               IF l_period>0 THEN               #151231-00004#1 mark
               #匯總該年第一天到起始日期前一天的傳票資料
               EXECUTE aglq720_sel_pr2 USING l_glav004,l_glav004_e
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr2','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr2'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1+l_amt5
               LET l_amt2=l_amt2+l_amt6
               LET l_amt3=l_amt3+l_amt7
               LET l_amt4=l_amt4+l_amt8
#               END IF #151231-00004#1 mark
            END IF
            
            #151204-00013#2--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt5=0 
               LET l_amt6=0 
               LET l_amt7=0 
               LET l_amt8=0
               EXECUTE aglq720_sel_pr6_1 USING tm.syear,l_period
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr6_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
            END IF
            #151204-00013#2--add--end
            
            IF l_amt2>0 THEN
               LET l_oqcd=l_amt1
               LET l_oqcc=0
               LET l_qcd =l_amt2
               LET l_qcc =0
               LET l_qcd2=l_amt3
               LET l_qcc2=0
               LET l_qcd3=l_amt4
               LET l_qcc3=0
            ELSE
               LET l_oqcd=0
               LET l_oqcc=-1*l_amt1
               LET l_qcd =0
               LET l_qcc =-1*l_amt2
               LET l_qcd2=0
               LET l_qcc2=-1*l_amt3
               LET l_qcd3=0
               LET l_qcc3=-1*l_amt4
            END IF 
            #160225-00014#1--s
            #借-貸金額剛好為0,不代表借貸就是給0;所以另外分別抓取值
            IF l_amt2=0 THEN
               EXECUTE aglq720_sel_pr11 USING l_glac002,tm.syear,l_period
                                        INTO l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3
               IF cl_null(l_oqcd) THEN LET l_oqcd = 0 END IF
               IF cl_null(l_oqcc) THEN LET l_oqcc = 0 END IF
               IF cl_null(l_qcd) THEN LET l_qcd = 0 END IF
               IF cl_null(l_qcc) THEN LET l_qcc = 0 END IF
               IF cl_null(l_qcd2) THEN LET l_qcd2 = 0 END IF
               IF cl_null(l_qcc2) THEN LET l_qcc2 = 0 END IF
               IF cl_null(l_qcd3) THEN LET l_qcd3 = 0 END IF
               IF cl_null(l_qcc3) THEN LET l_qcc3 = 0 END IF                                        
            END IF
            #160225-00014#1--e     

            #期間異動
            LET l_oqjd = 0
            LET l_oqjc = 0
            LET l_qjd  = 0
            LET l_qjc  = 0
            LET l_qjd2 = 0
            LET l_qjc2 = 0
            LET l_qjd3 = 0
            LET l_qjc3 = 0
            #当整期间且不跨年时抓取glar_t
            IF l_flag = TRUE AND tm.syear = tm.eyear THEN
               EXECUTE aglq720_sel_pr5 USING l_glac002 
                                       INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
            ELSE
               EXECUTE aglq720_sel_pr5 INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr5','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr5'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
            IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
            IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
            IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
            IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
            IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
            IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
            IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
            
            #当整期间且不跨年查询时，當不包含YE或AD憑證時，減去YE或AD傳票金額
            IF l_flag=TRUE AND tm.syear = tm.eyear
#               AND (tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
               AND (tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN  #151204-00013#2 add
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr8 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr8','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr8'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            
            #151204-00013#2--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr8_1 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr8_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            #151204-00013#2--add--end
            
            #期末金額=期初+期間異動
            #原幣
            LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
            IF l_amt1>0 THEN
               LET l_oqmd=l_amt1
               LET l_oqmc=0
            ELSE
               LET l_oqmd=0
               LET l_oqmc=l_amt1*-1
            END IF
            #本幣
            LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
            IF l_amt1>0 THEN
               LET l_qmd=l_amt1
               LET l_qmc=0
            ELSE
               LET l_qmd=0
               LET l_qmc=l_amt1*-1
            END IF
            #本幣二
            LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
            IF l_amt1>0 THEN
               LET l_qmd2=l_amt1
               LET l_qmc2=0
            ELSE
               LET l_qmd2=0
               LET l_qmc2=l_amt1*-1
            END IF
            #本幣三
            LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
            IF l_amt1>0 THEN
               LET l_qmd3=l_amt1
               LET l_qmc3=0
            ELSE
               LET l_qmd3=0
               LET l_qmc3=l_amt1*-1
            END IF  

            #本年累計金額
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            LET l_osumd = 0
            LET l_osumc = 0
            LET l_sumd  = 0
            LET l_sumc  = 0
            LET l_sumd2 = 0
            LET l_sumc2 = 0
            LET l_sumd3 = 0
            LET l_sumc3 = 0
            #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
            IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
               EXECUTE aglq720_sel_pr3 USING l_glac002,tm.eyear,tm.eperiod
                                        INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr3','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
               IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
               IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
               IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
               IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
               IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
               IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
               IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
#               IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN   #151204-00013#2 add
                  EXECUTE aglq720_sel_pr7 USING tm.eyear,tm.eperiod
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
                  IF SQLCA.sqlcode THEN
#                     CALL cl_errmsg('','aglq720_sel_pr7','',SQLCA.sqlcode,1)
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq720_sel_pr7'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8
               END IF
            ELSE
               #年初數
               #160503-00037#2  by 07900  mark
    #           LET l_period=0
     #          EXECUTE aglq720_sel_pr3 USING l_glac002,tm.syear,l_period
     #                                   INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
    #           IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr3','',SQLCA.sqlcode,1)
    #              INITIALIZE g_errparam TO NULL 
   #               LET g_errparam.extend = 'aglq720_sel_pr3'
   #               LET g_errparam.code   = SQLCA.sqlcode
    #              LET g_errparam.popup  = TRUE 
    #              CALL cl_err()
    #              LET l_success = FALSE
    #           END IF
              #160503-00037#2  by 07900  mark
               #匯總該年第一天到查詢截止日期tm.edate
               EXECUTE aglq720_sel_pr4 USING l_glav004,tm.edate
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr4','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr4'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
               IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
               IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
               IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
               IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
               IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
               IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
               IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
              #160503-00037#6 add by 07900--str-- 
              # LET l_osumd=l_osumd+l_amt1
               #LET l_osumc=l_osumc+l_amt2
               #LET l_sumd =l_sumd +l_amt3
               #LET l_sumc =l_sumc +l_amt4
               #LET l_sumd2=l_sumd2+l_amt5
               #LET l_sumc2=l_sumc2+l_amt6
               #LET l_sumd3=l_sumd3+l_amt7
               #LET l_sumc3=l_sumc3+l_amt8   
             #160503-00037#6 add by 07900--end--
             #160503-00037#6 add by 07900--str--
            LET l_osumd=l_amt1
            LET l_osumc=l_amt2
            LET l_sumd=l_amt3
            LET l_sumc=l_amt4
            LET l_sumd2=l_amt5
            LET l_sumc2=l_amt6
            LET l_sumd3=l_amt7
            LET l_sumc3=l_amt8
            #160503-00037#6 add by 07900--str--               
            END IF 
            
            #151204-00013#2--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr7_1 USING tm.eyear,tm.eperiod
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq720_sel_pr7_1'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8
            END IF
            #151204-00013#2--add--end
            
            IF l_yeard=0 AND l_yearc=0 AND  #年初數
               l_qcd=0 AND l_qcc=0 AND      #期初數
               l_qjd=0 AND l_qjc=0 AND      #期間異動
               l_qmd=0 AND l_qmc=0 AND      #期末
               l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
               CONTINUE FOREACH
            END IF
            INSERT INTO aglq720_tmp 
            VALUES(g_enterprise,l_glac002,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017, #160505-00007#14 add g_enterprise
                   l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                   l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                   l_glar031,l_glar032,l_glar033,l_glar009,
                   l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                   l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                   l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                   l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                   l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3)
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'insert'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
         END FOREACH
      ELSE
         #未勾选核算项或原币
         #期初：抓取YE、AD憑證金額
         LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                    "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002=？ AND glap004<=? ",l_glaq002,
                    l_sql3,l_sql4
         PREPARE aglq720_sel_pr06 FROM l_sql  
              
         #破期时年初、期初根據傳票狀態（1、2、3）抓取資料
         LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                    "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glapdocdt BETWEEN ? AND ? ",l_glaq002,
                    l_sql2,l_sql4
         PREPARE aglq720_sel_pr02 FROM l_sql  
       
         #本年累計：抓取YE、AD憑證金額
         LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                   "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                   "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   "       SUM(glaq043),SUM(glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "   AND glap002= ? AND glap004<=? ",l_glaq002,    
                   "   AND glapstus='S'",l_sql3
         PREPARE aglq720_sel_pr07 FROM l_sql
       
         #破期本年累計
         LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                   "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                   "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   "       SUM(glaq043),SUM(glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "   AND glapdocdt BETWEEN ? AND ? ",l_glaq002, 
                   l_sql2,l_sql4
         PREPARE aglq720_sel_pr04 FROM l_sql
       
          #期間異動
          IF l_flag = TRUE AND tm.syear = tm.eyear THEN
             LET l_sql="(SELECT glar010,glar011,glar005,",
                       "        glar006,glar034,glar035,glar036,glar037",
                       "   FROM glar_t",
                       "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' AND glar001=?",
                       "    AND glar002=",tm.syear,
                       "    AND glar003 BETWEEN ",tm.speriod," AND ",tm.eperiod,
                       "    AND ",g_wc,")"  
             #單據狀態      
             IF tm.stus MATCHES '[23]' THEN
                LET l_sql=l_sql,
                          " UNION ALL ",
                          "(SELECT (CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END) glar010,",
                          "        (CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END) glar011,",
                          "        glaq003 glar005,glaq004 glar006,glaq040 glar034,",
                          "        glaq041 glar035,glaq043 glar036,glaq044 glar037",
                          "   FROM glaq_t",
                          "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                          "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                          "    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
                CASE
                    WHEN tm.stus='2'
                       LET l_sql=l_sql," AND glapstus='Y'"
                    WHEN tm.stus='3'
                       LET l_sql=l_sql," AND glapstus IN ('Y','N')"
                END CASE
                LET l_sql=l_sql,l_sql2,")"
             END IF
             LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),",
                       "       SUM(glar006),SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)",
                       "  FROM (",l_sql,")"
          ELSE 
             LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                       "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                       "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                       "       SUM(glaq043),SUM(glaq044)",
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                       "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                       l_sql2,l_sql4
          END IF 
          PREPARE aglq720_sel_pr05 FROM l_sql
       
          #期間異動：抓取已过账的YE、AD憑證金額
          LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                    "       SUM(glaq043),SUM(glaq044)",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                    "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                    "   AND glapstus='S'",l_sql3
          PREPARE aglq720_sel_pr08 FROM l_sql
         
         #151204-00013#2--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            #期初：抓取CE、XC憑證金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                      "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002=？ AND glap004<=? ",l_glaq002,  
                      l_sql4,
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                      "                                         AND glac007='5' ",l_glac002_str,"))",
                      "       )"
            PREPARE aglq720_sel_pr06_1 FROM l_sql 
         
            #本年累計：抓取CE、XC憑證金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",l_glaq002,  
                      l_sql4,
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                      "                                         AND glac007='5' ",l_glac002_str,"))",
                      "       )"
            PREPARE aglq720_sel_pr07_1 FROM l_sql
            
            #期間異動：抓取已过账的CE、XC憑證金額
            LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044)",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",l_glaq002,
                      "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                      l_sql4,
                      "   AND (",
                      "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac007='6' ",l_glac002_str,"))",
                      "         OR ",
                      "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                      "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                      "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
                      "                                         AND glac007='5' ",l_glac002_str,"))",
                      "       )"
            PREPARE aglq720_sel_pr08_1 FROM l_sql
         END IF
         #151204-00013#2--add--end
         
         #年初金額
         IF tm.show_y='Y' THEN
            LET l_period=0
            LET l_amt1 = 0
            LET l_amt2 = 0
            LET l_amt3 = 0
            LET l_amt4 = 0
            EXECUTE aglq720_sel_pr01 USING l_glac002,tm.syear,l_period
                                     INTO l_amt1,l_amt2,l_amt3,l_amt4
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr01','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr01'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF l_amt2>0 THEN
               LET l_oyeard=l_amt1
               LET l_oyearc=0
               LET l_yeard =l_amt2
               LET l_yearc =0
               LET l_yeard2=l_amt3
               LET l_yearc2=0
               LET l_yeard3=l_amt4
               LET l_yearc3=0
            ELSE
               LET l_oyeard=0
               LET l_oyearc=-1*l_amt1
               LET l_yeard =0
               LET l_yearc =-1*l_amt2
               LET l_yeard2=0
               LET l_yearc2=-1*l_amt3
               LET l_yeard3=0
               LET l_yearc3=-1*l_amt4
            END IF 
         ELSE
            LET l_oyeard=0
            LET l_oyearc=0
            LET l_yeard =0
            LET l_yearc =0
            LET l_yeard2=0
            LET l_yearc2=0
            LET l_yeard3=0
            LET l_yearc3=0
         END IF
      
         #期初金額
         LET l_amt1=0
         LET l_amt2=0
         LET l_amt3=0
         LET l_amt4=0
         LET l_amt5=0
         LET l_amt6=0
         LET l_amt7=0
         LET l_amt8=0
         LET l_period=tm.speriod-1
         IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
            EXECUTE aglq720_sel_pr01 USING l_glac002,tm.syear,l_period
                                     INTO l_amt1,l_amt2,l_amt3,l_amt4
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr01','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr01'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
#            IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN   #151204-00013#2 add
               EXECUTE aglq720_sel_pr06 USING tm.syear,l_period
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr06','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr06'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
            END IF
         #當為破期時，匯總年初數+該年第一天到查詢開始前一天的傳票資料
         ELSE
            #年初數
            LET l_period=0
            EXECUTE aglq720_sel_pr01 USING l_glac002,tm.syear,l_period
                                     INTO l_amt1,l_amt2,l_amt3,l_amt4
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr01','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr01'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         
#            LET l_period=tm.speriod-1 #上期  #151231-00004#1 mark
#            IF l_period>0 THEN               #151231-00004#1 mark
            #匯總該年第一天到查詢開始前一天的傳票資料
            EXECUTE aglq720_sel_pr02 USING l_glav004,l_glav004_e
                                     INTO l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr02','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr02'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_amt1=l_amt1+l_amt5
            LET l_amt2=l_amt2+l_amt6
            LET l_amt3=l_amt3+l_amt7
            LET l_amt4=l_amt4+l_amt8
#            END IF  #151231-00004#1 mark
         END IF
         
         #151204-00013#2--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr06_1 USING tm.syear,l_period
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr06_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
         END IF
         #151204-00013#2--add--end
         
         IF l_amt2>0 THEN
            LET l_oqcd=l_amt1
            LET l_oqcc=0
            LET l_qcd =l_amt2
            LET l_qcc =0
            LET l_qcd2=l_amt3
            LET l_qcc2=0
            LET l_qcd3=l_amt4
            LET l_qcc3=0
         ELSE
            LET l_oqcd=0
            LET l_oqcc=-1*l_amt1
            LET l_qcd =0
            LET l_qcc =-1*l_amt2
            LET l_qcd2=0
            LET l_qcc2=-1*l_amt3
            LET l_qcd3=0
            LET l_qcc3=-1*l_amt4
         END IF 
      
         #期間異動
         LET l_oqjd = 0
         LET l_oqjc = 0
         LET l_qjd  = 0
         LET l_qjc  = 0
         LET l_qjd2 = 0
         LET l_qjc2 = 0
         LET l_qjd3 = 0
         LET l_qjc3 = 0
         #整期间且不跨年
         IF l_flag=TRUE AND tm.syear = tm.eyear THEN
            EXECUTE aglq720_sel_pr05 USING l_glac002 
                                     INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
         ELSE
            EXECUTE aglq720_sel_pr05 INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq720_sel_pr05','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'aglq720_sel_pr05'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
         END IF         
         IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
         IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
         IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
         IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
         IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
         IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
         IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
         IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
         
         #当整期间且不跨年查询时，當不包含YE或AD憑證時，減去YE或AD傳票金額
         IF l_flag=TRUE AND tm.syear = tm.eyear
#            AND (tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
            AND (tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN  #151204-00013#2 add
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr08 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr08','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr08'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
         
         #151204-00013#2--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr08_1 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr08_1'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
         #151204-00013#2--add--end
         
         #期末金額=期初+期間異動
         #原幣
         LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
         IF l_amt1>0 THEN
            LET l_oqmd=l_amt1
            LET l_oqmc=0
         ELSE
            LET l_oqmd=0
            LET l_oqmc=l_amt1*-1
         END IF
         #本幣
         LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
         IF l_amt1>0 THEN
            LET l_qmd=l_amt1
            LET l_qmc=0
         ELSE
            LET l_qmd=0
            LET l_qmc=l_amt1*-1
         END IF
         #本幣二
         LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
         IF l_amt1>0 THEN
            LET l_qmd2=l_amt1
            LET l_qmc2=0
         ELSE
            LET l_qmd2=0
            LET l_qmc2=l_amt1*-1
         END IF
         #本幣三
         LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
         IF l_amt1>0 THEN
            LET l_qmd3=l_amt1
            LET l_qmc3=0
         ELSE
            LET l_qmd3=0
            LET l_qmc3=l_amt1*-1
         END IF  

         #本年累計金額
         LET l_amt1=0
         LET l_amt2=0
         LET l_amt3=0
         LET l_amt4=0
         LET l_amt5=0
         LET l_amt6=0
         LET l_amt7=0
         LET l_amt8=0
         LET l_osumd = 0
         LET l_osumc = 0
         LET l_sumd  = 0
         LET l_sumc  = 0
         LET l_sumd2 = 0
         LET l_sumc2 = 0
         LET l_sumd3 = 0
         LET l_sumc3 = 0
         #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
            EXECUTE aglq720_sel_pr03 USING l_glac002,tm.eyear,tm.eperiod
                                     INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr03','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr03'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
            IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
            IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
            IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
            IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
            IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
            IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
            IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
#            IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#2 mark
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN   #151204-00013#2 add
               EXECUTE aglq720_sel_pr07 USING tm.eyear,tm.eperiod
                                         INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq720_sel_pr07','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr07'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8
            END IF
         ELSE
            #年初数
            #160503-00037#2 By 07900 mark --str
         #   LET l_period=0
          #  EXECUTE aglq720_sel_pr03 USING l_glac002,tm.syear,l_period
          #                           INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
          #  IF SQLCA.sqlcode THEN
#         #      CALL cl_errmsg('','aglq720_sel_pr03','',SQLCA.sqlcode,1)
          #     INITIALIZE g_errparam TO NULL 
          #     LET g_errparam.extend = 'aglq720_sel_pr03'
          #     LET g_errparam.code   = SQLCA.sqlcode
          #     LET g_errparam.popup  = TRUE 
          #     CALL cl_err()
          #     LET l_success = FALSE
          #  END IF
           
          #  IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
          #  IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
           # IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
           # IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
           # IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
           # IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
            #IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            #160503-00037#2 By 07900 mark --end
            #匯總該年第一天到查詢截止日期tm.edate
            EXECUTE aglq720_sel_pr04 USING l_glav004,tm.edate
                                     INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq720_sel_pr04','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr04'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
            #160503-00037#2 By 07900 mark --str
          #  LET l_osumd=l_osumd+l_amt1
           # LET l_osumc=l_osumc+l_amt2
            #LET l_sumd =l_sumd +l_amt3
            #LET l_sumc =l_sumc +l_amt4
            #LET l_sumd2=l_sumd2+l_amt5
            #LET l_sumc2=l_sumc2+l_amt6
            #LET l_sumd3=l_sumd3+l_amt7
            #LET l_sumc3=l_sumc3+l_amt8 
             #160503-00037#2 By 07900 mark --str    
           #160503-00037#6 add by 07900--str--
            LET l_osumd=l_amt1
            LET l_osumc=l_amt2
            LET l_sumd=l_amt3
            LET l_sumc=l_amt4
            LET l_sumd2=l_amt5
            LET l_sumc2=l_amt6
            LET l_sumd3=l_amt7
            LET l_sumc3=l_amt8
            #160503-00037#6 add by 07900--str--             
         END IF 
               
         #151204-00013#2--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1=0 
            LET l_amt2=0 
            LET l_amt3=0 
            LET l_amt4=0 
            LET l_amt5=0 
            LET l_amt6=0 
            LET l_amt7=0 
            LET l_amt8=0
            EXECUTE aglq720_sel_pr07_1 USING tm.eyear,tm.eperiod
                                         INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr07_1'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8
         END IF
         #151204-00013#2--add--end
         
         IF l_yeard=0 AND l_yearc=0 AND  #年初數
            l_qcd=0 AND l_qcc=0 AND      #期初數
            l_qjd=0 AND l_qjc=0 AND      #期間異動
            l_qmd=0 AND l_qmc=0 AND      #期末
            l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
            CONTINUE FOREACH
         END IF
            
         INSERT INTO aglq720_tmp 
         VALUES(g_enterprise,l_glac002,'','','','','','','','','','','','','','', #160505-00007#14 add g_enterprise
                '','','','','','','','','','','',
                l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'insert'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END IF
   END FOREACH
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq720_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq720_show()
# Date & Author..:  2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_show()
   DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.ctype,tm.curr_o,tm.curr_p,
           tm.show_y,tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,
           tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,tm.glad011,
           tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,tm.glad015,tm.glad016,
           tm.glad017,tm.glad018,tm.glad019,tm.glad020,tm.glad021,tm.glad022,
           tm.glad023,tm.glad024,tm.glad025,tm.glad026
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           sdate,syear,speriod,edate,eyear,eperiod,ctype,curr_o,curr_p,
           show_y,show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye,
           comp,glad007,glad008,glad009,glad010,glad027,glad011,
           glad012,glad031,glad032,glad033,glad013,glad015,glad016,
           glad017,glad018,glad019,glad020,glad021,glad022,glad023,
           glad024,glad025,glad026
END FUNCTION

################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq720_b_fill1()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_b_fill1()
#160505-00007#14--mark--str--
#DEFINE l_glaald_desc LIKE type_t.chr500,
#       l_glaacomp_desc LIKE type_t.chr500,
#       l_glaa001_desc LIKE type_t.chr500,
#       l_sdate LIKE type_t.chr500,
#       l_edate LIKE type_t.chr500,
#       l_ctype LIKE type_t.chr500,
#       l_stus LIKE type_t.chr500,
#       l_glar051 LIKE type_t.chr500
#160505-00007#14--mark--end

#160118-00012#1--add--str--
   DEFINE l_sum1      LIKE type_t.num20_6 
   DEFINE l_sum2      LIKE type_t.num20_6 
   DEFINE l_sum3      LIKE type_t.num20_6 
   DEFINE l_sum4      LIKE type_t.num20_6 
   DEFINE l_sum5      LIKE type_t.num20_6 
   DEFINE l_sum6      LIKE type_t.num20_6 
   DEFINE l_sum7      LIKE type_t.num20_6 
   DEFINE l_sum8      LIKE type_t.num20_6 
   DEFINE l_sum9      LIKE type_t.num20_6 
   DEFINE l_sum10     LIKE type_t.num20_6 
   DEFINE l_sum11     LIKE type_t.num20_6 
   DEFINE l_sum12     LIKE type_t.num20_6 
   DEFINE l_sum13     LIKE type_t.num20_6 
   DEFINE l_sum14     LIKE type_t.num20_6 
   DEFINE l_sum15     LIKE type_t.num20_6 
   DEFINE l_sum16     LIKE type_t.num20_6 
   DEFINE l_sum17     LIKE type_t.num20_6 
   DEFINE l_sum18     LIKE type_t.num20_6 
   DEFINE l_sum19     LIKE type_t.num20_6 
   DEFINE l_sum20     LIKE type_t.num20_6 
   DEFINE l_sum21     LIKE type_t.num20_6 
   DEFINE l_sum22     LIKE type_t.num20_6 
   DEFINE l_sum23     LIKE type_t.num20_6 
   DEFINE l_sum24     LIKE type_t.num20_6 
   DEFINE l_sum25     LIKE type_t.num20_6 
   DEFINE l_sum26     LIKE type_t.num20_6 
   DEFINE l_sum27     LIKE type_t.num20_6 
   DEFINE l_sum28     LIKE type_t.num20_6 
   DEFINE l_sum29     LIKE type_t.num20_6 
   DEFINE l_sum30     LIKE type_t.num20_6
#160118-00012#1--add--end
#160505-00007#14--add--str--
#多語言SQL
DEFINE l_get_sql   RECORD
       glar012     STRING,  #营运据点
       glar013     STRING,  #部门
       glar014     STRING,  #责任中心
       glar015     STRING,  #区域
       glar016     STRING,  #收付款客商
       glar017     STRING,  #账款客商
       glar018     STRING,  #客群
       glar019     STRING,  #产品类别
       glar020     STRING,  #人员
       glar022     STRING,  #专案编号
       glar023     STRING,  #WBS
       glar052     STRING,  #渠道
       glar053     STRING   #品牌  
                   END RECORD  
DEFINE l_hsx          LIKE type_t.num5                   
#160505-00007#14--add--end

#160505-00007#14--mark--str--
#   DELETE FROM aglq720_print_tmp
#   LET l_glaald_desc = g_glaald," ",g_glaald_desc
#   LET l_glaacomp_desc = g_glaacomp," ",g_glaacomp_desc
#   LET l_glaa001_desc = g_glaa001," ",g_glaa016," ",g_glaa020
#   LET l_sdate = tm.sdate," ",tm.syear," ",tm.speriod
#   LET l_edate = tm.edate," ",tm.eyear," ",tm.eperiod
#   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
#   LET l_stus = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
#160505-00007#14--mark--end

   
   
#160505-00007#14--add--end

#160505-00007#14--mod--str--
#   LET g_sql="SELECT UNIQUE glar001,'',glar012,'',glar013,'',glar014,'',glar015,'',glar016,'',glar017,'',",
#             "       glar018,'',glar019,'',glar051,glar052,'',glar053,'',glar020,'',glar022,'',glar023,'',",
#             "       glar024,glar025,glar026,glar027,glar028,glar029,glar030,",
#             "       glar031,glar032,glar033,glar009,",
#             "       oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3,",
#             "       oqcd,oqcc,qcd,qcc,qcd2,qcc2,qcd3,qcc3,",
#             "       oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,",
#             "       oqmd,oqmc,qmd,qmc,qmd2,qmc2,qmd3,qmc3,",
#             "       osumd,osumc,sumd,sumc,sumd2,sumc2,sumd3,sumc3 ",
#             "  FROM aglq720_tmp ",
#             "  WHERE 1=1 "#160302-00006#1 ADD by 07675
   #抓取说明的sql语句
   LET l_get_sql.*=g_get_sql.*
   #营运据点
   IF tm.comp <> 'Y' THEN
      LET l_get_sql.glar012 = "''"
   END IF
   
   #部门
   IF tm.glad007 <> 'Y' THEN 
      LET l_get_sql.glar013 = "''"
   END IF
   
   #利润/成本中心
   IF tm.glad008 <> 'Y' THEN 
      LET l_get_sql.glar014 = "''"
   END IF
   
   #区域
   IF tm.glad009 <> 'Y' THEN 
      LET l_get_sql.glar015 = "''"
   END IF
   
   #收付款客商
#   IF tm.glad010 = 'Y' THEN  #160912-00013#1 mark
   IF tm.glad010 <> 'Y' THEN  #160912-00013#1 add
      LET l_get_sql.glar016 = "''"
   END IF

   #账款客商
#   IF tm.glad027 = 'Y' THEN #160912-00013#1 mark
   IF tm.glad027 <> 'Y' THEN #160912-00013#1 add
      LET l_get_sql.glar017 = "''"
   END IF
   
   #客群
#   IF tm.glad011 = 'Y' THEN #160912-00013#1 mark
   IF tm.glad011 <> 'Y' THEN #160912-00013#1 add
      LET l_get_sql.glar018 = "''"
   END IF
   
   #产品类别
#   IF tm.glad012 = 'Y' THEN #160912-00013#1 mark
   IF tm.glad012 <> 'Y' THEN #160912-00013#1 add
      LET l_get_sql.glar019 = "''"
   END IF
   
   #渠道
   IF tm.glad032 <> 'Y' THEN 
      LET l_get_sql.glar052 = "''"
   END IF
   
   #品牌
   IF tm.glad033 <> 'Y' THEN 
      LET l_get_sql.glar053 = "''"
   END IF

   #人员
   IF tm.glad013 <> 'Y' THEN 
      LET l_get_sql.glar020 = "''"
   END IF
   
   #专案
   IF tm.glad015 <> 'Y' THEN 
      LET l_get_sql.glar022 = "''"
   END IF
   
   IF tm.glad016 <> 'Y' THEN 
#      LET l_get_sql.glar022 = "''" #160912-00013#1 mark
      LET l_get_sql.glar023 = "''"  #160912-00013#1 add
   END IF

   #判断是否勾选自由核算项项
   IF tm.glad017 = 'Y' OR tm.glad018 = 'Y' OR tm.glad019 = 'Y' OR tm.glad020 = 'Y' OR tm.glad021 = 'Y' OR
      tm.glad022 = 'Y' OR tm.glad023 = 'Y' OR tm.glad024 = 'Y' OR tm.glad025 = 'Y' OR tm.glad026 = 'Y' THEN
      LET l_hsx=TRUE
   ELSE
      LET l_hsx=FALSE
   END IF

   LET g_sql="SELECT UNIQUE glar001,t01.glacl004,glar012,",g_get_sql.glar012,",glar013,",g_get_sql.glar013,",",
             "       glar014,",g_get_sql.glar014,",glar015,",g_get_sql.glar015,",glar016,",g_get_sql.glar016,",",
             "       glar017,",g_get_sql.glar017,",glar018,",g_get_sql.glar018,",glar019,",g_get_sql.glar019,",",
             "       glar051,glar052,",g_get_sql.glar052,",glar053,",g_get_sql.glar053,",glar020,",g_get_sql.glar020,",",
             "       glar022,",g_get_sql.glar022,",glar023,",g_get_sql.glar023,",",
             "       glar024,glar025,glar026,glar027,glar028,glar029,glar030,",
             "       glar031,glar032,glar033,glar009,",
             "       oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3,",
             "       oqcd,oqcc,qcd,qcc,qcd2,qcc2,qcd3,qcc3,",
             "       oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,",
             "       oqmd,oqmc,qmd,qmc,qmd2,qmc2,qmd3,qmc3,",
             "       osumd,osumc,sumd,sumc,sumd2,sumc2,sumd3,sumc3 ",
             "  FROM aglq720_tmp ",
             "  LEFT JOIN glacl_t t01 ON glaclent=",g_enterprise," AND glacl001='",g_glaa004,"' AND glacl002=glar001 AND glacl003='",g_dlang,"'",
             "  WHERE 1=1 "
#160505-00007#14--mod--end

   #是否按照幣別分頁
   IF NOT cl_null(g_glar009) THEN
      LET g_sql=g_sql," AND glar009='",g_glar009,"'"#160302-00006#1 change 'WHERE' TO 'AND'
   END IF
   LET g_sql = g_sql, " AND ",g_wc_filter #160302-00006#1  ADD by 07675
   LET g_sql=g_sql," ORDER BY glar001,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019,",
                   "          glar051,glar052,glar053,glar020,glar022,glar023,glar024,glar025,glar026,",
                   "          glar027,glar028,glar029,glar030,glar031,glar032,glar033,glar009 "
   
  
   PREPARE aglq720_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq720_pb1
   OPEN b_fill_curs1
#160118-00012#1--unmark--str--
   #合计：
   LET g_sql="SELECT ",
             "       SUM(yeard),SUM(yearc),SUM(yeard2),SUM(yearc2),SUM(yeard3),SUM(yearc3),",
             "       SUM(qcd),SUM(qcc),SUM(qcd2),SUM(qcc2),SUM(qcd3),SUM(qcc3),",
             "       SUM(qjd),SUM(qjc),SUM(qjd2),SUM(qjc2),SUM(qjd3),SUM(qjc3),",
             "       SUM(qmd),SUM(qmc),SUM(qmd2),SUM(qmc2),SUM(qmd3),SUM(qmc3),",
             "       SUM(sumd),SUM(sumc),SUM(sumd2),SUM(sumc2),SUM(sumd3),SUM(sumc3) ",
             "  FROM aglq720_tmp"
   #160118-00012#1--mod--str--
   #勾选统治科目时，抓取最上次统治科目+独立科目金额。反之，抓取的是明细科目+独立科目金额
   IF tm.show_acc = 'Y' THEN
      LET g_sql=g_sql," WHERE glar001 IN (SELECT glac002 FROM glac_t ",
                      "                   WHERE glac002=glac004 AND glacent=",g_enterprise," AND glac001='",g_glaa004,"')"
   END IF
   #160118-00012#1--mod--end
   #是否按照幣別分頁
   IF NOT cl_null(g_glar009) THEN
      LET g_sql=g_sql," AND glar009='",g_glar009,"'"
   END IF 
   PREPARE aglq720_sum_pb1 FROM g_sql
#160118-00012#1--unmark--end

   CALL g_glar_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,
       g_glar_d[l_ac].glar012,g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,
       g_glar_d[l_ac].glar014,g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,
       g_glar_d[l_ac].glar016,g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,
       g_glar_d[l_ac].glar018,g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,
       g_glar_d[l_ac].glar051,g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,
       g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc,g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,
       g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar022_desc,g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar023_desc,
       g_glar_d[l_ac].glar024,g_glar_d[l_ac].glar025,g_glar_d[l_ac].glar026,g_glar_d[l_ac].glar027,
       g_glar_d[l_ac].glar028,g_glar_d[l_ac].glar029,g_glar_d[l_ac].glar030,g_glar_d[l_ac].glar031,
       g_glar_d[l_ac].glar032,g_glar_d[l_ac].glar033,g_glar_d[l_ac].glar009, 
       g_glar_d[l_ac].oyeard,g_glar_d[l_ac].oyearc,g_glar_d[l_ac].yeard,g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2, 
       g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3,g_glar_d[l_ac].oqcd,g_glar_d[l_ac].oqcc, 
       g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2,g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3, 
       g_glar_d[l_ac].qcc3,g_glar_d[l_ac].oqjd,g_glar_d[l_ac].oqjc,g_glar_d[l_ac].qjd,g_glar_d[l_ac].qjc, 
       g_glar_d[l_ac].qjd2,g_glar_d[l_ac].qjc2,g_glar_d[l_ac].qjd3,g_glar_d[l_ac].qjc3,g_glar_d[l_ac].oqmd, 
       g_glar_d[l_ac].oqmc,g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc,g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2, 
       g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3,g_glar_d[l_ac].osumd,g_glar_d[l_ac].osumc,g_glar_d[l_ac].sumd, 
       g_glar_d[l_ac].sumc,g_glar_d[l_ac].sumd2,g_glar_d[l_ac].sumc2,g_glar_d[l_ac].sumd3,g_glar_d[l_ac].sumc3 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
#      LET g_glar_d[l_ac].sel = "N" #160505-00007#14 mark
      #160505-00007#14--add--str--
      #勾选自由核算项时抓取说明
      IF l_hsx = TRUE THEN
      #160505-00007#14--add--end
      CALL aglq720_detail_show()
      END IF  #160505-00007#14 add
#160505-00007#14--mark--str--
#      #2015/6/2---XG用
#      LET l_glar051 = g_glar_d[l_ac].glar051,":",s_desc_gzcbl004_desc('6013',g_glar_d[l_ac].glar051)
#      INSERT INTO aglq720_print_tmp VALUES(l_glaald_desc,l_glaacomp_desc,l_glaa001_desc,l_sdate,l_edate,
#         l_ctype,tm.glac005,l_stus,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,
#         g_glar_d[l_ac].glar012,g_glar_d[l_ac].glar012_desc,g_glar_d[l_ac].glar013,g_glar_d[l_ac].glar013_desc,
#         g_glar_d[l_ac].glar014,g_glar_d[l_ac].glar014_desc,g_glar_d[l_ac].glar015,g_glar_d[l_ac].glar015_desc,
#         g_glar_d[l_ac].glar016,g_glar_d[l_ac].glar016_desc,g_glar_d[l_ac].glar017,g_glar_d[l_ac].glar017_desc,
#         g_glar_d[l_ac].glar018,g_glar_d[l_ac].glar018_desc,g_glar_d[l_ac].glar019,g_glar_d[l_ac].glar019_desc,
#         l_glar051,g_glar_d[l_ac].glar052,g_glar_d[l_ac].glar052_desc,
#         g_glar_d[l_ac].glar053,g_glar_d[l_ac].glar053_desc,g_glar_d[l_ac].glar020,g_glar_d[l_ac].glar020_desc,
#         g_glar_d[l_ac].glar022,g_glar_d[l_ac].glar022_desc,g_glar_d[l_ac].glar023,g_glar_d[l_ac].glar023_desc,
#         g_glar_d[l_ac].glar024,g_glar_d[l_ac].glar024_desc,g_glar_d[l_ac].glar025,g_glar_d[l_ac].glar025_desc,
#         g_glar_d[l_ac].glar026,g_glar_d[l_ac].glar026_desc,g_glar_d[l_ac].glar027,g_glar_d[l_ac].glar027_desc,
#         g_glar_d[l_ac].glar028,g_glar_d[l_ac].glar028_desc,g_glar_d[l_ac].glar029,g_glar_d[l_ac].glar029_desc,
#         g_glar_d[l_ac].glar030,g_glar_d[l_ac].glar030_desc,g_glar_d[l_ac].glar031,g_glar_d[l_ac].glar031_desc,
#         g_glar_d[l_ac].glar032,g_glar_d[l_ac].glar032_desc,g_glar_d[l_ac].glar033,g_glar_d[l_ac].glar033_desc,
#         g_glar_d[l_ac].glar009, 
#         g_glar_d[l_ac].oyeard,g_glar_d[l_ac].oyearc,g_glar_d[l_ac].yeard,g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2, 
#         g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3,g_glar_d[l_ac].oqcd,g_glar_d[l_ac].oqcc, 
#         g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2,g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3, 
#         g_glar_d[l_ac].qcc3,g_glar_d[l_ac].oqjd,g_glar_d[l_ac].oqjc,g_glar_d[l_ac].qjd,g_glar_d[l_ac].qjc, 
#         g_glar_d[l_ac].qjd2,g_glar_d[l_ac].qjc2,g_glar_d[l_ac].qjd3,g_glar_d[l_ac].qjc3,g_glar_d[l_ac].oqmd, 
#         g_glar_d[l_ac].oqmc,g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc,g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2, 
#         g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3,g_glar_d[l_ac].osumd,g_glar_d[l_ac].osumc,g_glar_d[l_ac].sumd, 
#         g_glar_d[l_ac].sumc,g_glar_d[l_ac].sumd2,g_glar_d[l_ac].sumc2,g_glar_d[l_ac].sumd3,g_glar_d[l_ac].sumc3)
#      #2015/6/2---XG用
#160505-00007#14--mark--end

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
#   #合计：
#   EXECUTE aglq720_sum_pb1 INTO 
#       g_glar_d[l_ac].yeard,g_glar_d[l_ac].yearc,g_glar_d[l_ac].yeard2,g_glar_d[l_ac].yearc2,g_glar_d[l_ac].yeard3,g_glar_d[l_ac].yearc3, 
#       g_glar_d[l_ac].qcd,g_glar_d[l_ac].qcc,g_glar_d[l_ac].qcd2,g_glar_d[l_ac].qcc2,g_glar_d[l_ac].qcd3,g_glar_d[l_ac].qcc3,
#       g_glar_d[l_ac].qjd,g_glar_d[l_ac].qjc, g_glar_d[l_ac].qjd2,g_glar_d[l_ac].qjc2,g_glar_d[l_ac].qjd3,g_glar_d[l_ac].qjc3, 
#       g_glar_d[l_ac].qmd,g_glar_d[l_ac].qmc,g_glar_d[l_ac].qmd2,g_glar_d[l_ac].qmc2,g_glar_d[l_ac].qmd3,g_glar_d[l_ac].qmc3, 
#       g_glar_d[l_ac].sumd,g_glar_d[l_ac].sumc,g_glar_d[l_ac].sumd2,g_glar_d[l_ac].sumc2,g_glar_d[l_ac].sumd3,g_glar_d[l_ac].sumc3
#   #合计说明  
#   LET g_glar_d[l_ac].glar001_desc = cl_getmsg('axc-00383',g_lang)  
   #160118-00012#1--add--str--
   #合计：
   EXECUTE aglq720_sum_pb1 INTO
       l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6, 
       l_sum7,l_sum8,l_sum9,l_sum10,l_sum11,l_sum12,
       l_sum13,l_sum14,l_sum15,l_sum16,l_sum17,l_sum18,
       l_sum19,l_sum20,l_sum21,l_sum22,l_sum23,l_sum24,
       l_sum25,l_sum26,l_sum27,l_sum28,l_sum29,l_sum30
   DISPLAY l_sum1 TO FORMONLY.sum1
   DISPLAY l_sum2 TO FORMONLY.sum2
   DISPLAY l_sum3 TO FORMONLY.sum3
   DISPLAY l_sum4 TO FORMONLY.sum4
   DISPLAY l_sum5 TO FORMONLY.sum5
   DISPLAY l_sum6 TO FORMONLY.sum6
   DISPLAY l_sum7 TO FORMONLY.sum7
   DISPLAY l_sum8 TO FORMONLY.sum8
   DISPLAY l_sum9 TO FORMONLY.sum9
   DISPLAY l_sum10 TO FORMONLY.sum10
   DISPLAY l_sum11 TO FORMONLY.sum11
   DISPLAY l_sum12 TO FORMONLY.sum12
   DISPLAY l_sum13 TO FORMONLY.sum13
   DISPLAY l_sum14 TO FORMONLY.sum14
   DISPLAY l_sum15 TO FORMONLY.sum15
   DISPLAY l_sum16 TO FORMONLY.sum16
   DISPLAY l_sum17 TO FORMONLY.sum17
   DISPLAY l_sum18 TO FORMONLY.sum18
   DISPLAY l_sum19 TO FORMONLY.sum19
   DISPLAY l_sum20 TO FORMONLY.sum20
   DISPLAY l_sum21 TO FORMONLY.sum21
   DISPLAY l_sum22 TO FORMONLY.sum22
   DISPLAY l_sum23 TO FORMONLY.sum23
   DISPLAY l_sum24 TO FORMONLY.sum24
   DISPLAY l_sum25 TO FORMONLY.sum25
   DISPLAY l_sum26 TO FORMONLY.sum26
   DISPLAY l_sum27 TO FORMONLY.sum27
   DISPLAY l_sum28 TO FORMONLY.sum28
   DISPLAY l_sum29 TO FORMONLY.sum29
   DISPLAY l_sum30 TO FORMONLY.sum30
   #160118-00012#1--add--end
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE aglq720_pb1
   
   LET l_ac = 1
   
   CALL aglq720_filter_show('glar001','b_glar001')
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq720_set_page()
# Date & Author..: 2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glar_s.clear()
   IF tm.curr_p <>'Y' THEN
      LET g_glar_s[1].glar009=''
      LET g_header_cnt = 1
      LET g_rec_b = 1
   ELSE      
      LET l_sql="SELECT DISTINCT glar009 FROM aglq720_tmp ORDER BY glar009 "
      PREPARE aglq720_sel_s_pr FROM l_sql
      DECLARE aglq720_sel_s_cr CURSOR FOR aglq720_sel_s_pr
      LET l_idx=1
      FOREACH aglq720_sel_s_cr INTO g_glar_s[l_idx].glar009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq720_sel_s_cr'
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
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq720_fix_acc_sql(p_glar009,p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053)
#                  RETURNING r_sql,r_sql1
# Input parameter: p_glar009,p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053  14組固定核算項   传入参数变量说明1
# Return code....: r_sql，r_sql1 組合SQL語句
# Date & Author..: 2014/03/25 By 02599
# Modify.........: 加10個自由核算項
################################################################################
PRIVATE FUNCTION aglq720_fix_acc_sql(p_glar009,p_glar012,p_glar013,p_glar014,p_glar015,p_glar016,p_glar017,p_glar018,p_glar019,p_glar020,p_glar022,p_glar023,p_glar051,p_glar052,p_glar053,p_glar024,p_glar025,p_glar026,p_glar027,p_glar028,p_glar029,p_glar030,p_glar031,p_glar032,p_glar033)
   DEFINE p_glar009            LIKE glar_t.glar009
   DEFINE p_glar012            LIKE glar_t.glar012
   DEFINE p_glar013            LIKE glar_t.glar013
   DEFINE p_glar014            LIKE glar_t.glar014
   DEFINE p_glar015            LIKE glar_t.glar015
   DEFINE p_glar016            LIKE glar_t.glar016
   DEFINE p_glar017            LIKE glar_t.glar017
   DEFINE p_glar018            LIKE glar_t.glar018
   DEFINE p_glar019            LIKE glar_t.glar019
   DEFINE p_glar020            LIKE glar_t.glar020
#   DEFINE p_glar021            LIKE glar_t.glar021
   DEFINE p_glar022            LIKE glar_t.glar022
   DEFINE p_glar023            LIKE glar_t.glar023
   DEFINE p_glar051            LIKE glar_t.glar051
   DEFINE p_glar052            LIKE glar_t.glar052
   DEFINE p_glar053            LIKE glar_t.glar053
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
   
   IF tm.curr_o='Y' THEN
      LET r_sql=r_sql," AND glar009='",p_glar009,"'"
      LET r_sql1=r_sql1," AND glaq005='",p_glar009,"'"
   END IF
   
   RETURN r_sql,r_sql1
END FUNCTION
################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq720_set_default_value()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_set_default_value()
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
   LET tm.sdate=l_pdate_s  #起始日期
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   LET tm.edate=l_pdate_e  #截止日期
   LET tm.eyear=l_glav002
   LET tm.eperiod=l_glav006
  
   #原幣顯示設置
   LET tm.curr_o='N'
   CALL cl_set_comp_visible('b_glar009,oyeard,oyearc,oqcd,oqcc,oqjd,oqjc,oqmd,oqmc,osumd,osumc',FALSE)
   
   LET tm.curr_p='N'
   CALL aglq720_set_comp_entry('curr_p',FALSE)
   #年初數
   LET tm.show_y='N'
   CALL cl_set_comp_visible('oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3',FALSE)
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
   #LET tm.comp='Y' #mark by liyan 160706
   LET tm.comp='N'  #add by liyan 160706
   LET tm.glad007='N'
   LET tm.glad008='N'
   LET tm.glad009='N'
   LET tm.glad010='N'
   LET tm.glad027='N'
   LET tm.glad011='N'
   LET tm.glad012='N'
   LET tm.glad013='N'
#   LET tm.glad014='N'
   LET tm.glad015='N'
   LET tm.glad016='N'
   LET tm.glad031='N'
   LET tm.glad032='N'
   LET tm.glad033='N'
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
   CALL cl_set_comp_visible("b_glar023,b_glar023_desc,b_glar024,b_glar024_desc,b_glar025,b_glar025_desc,b_glar026,b_glar026_desc,b_glar027,b_glar027_desc,b_glar028,b_glar028_desc",FALSE)
   CALL cl_set_comp_visible("b_glar029,b_glar029_desc,b_glar030,b_glar030_desc,b_glar031,b_glar031_desc,b_glar032,b_glar032_desc,b_glar033,b_glar033_desc",FALSE)
   
   
END FUNCTION

################################################################################
# Descriptions...: 根據核算項勾選組SQL語句
# Memo...........:
# Usage..........: CALL aglq720_fix_acc_get_sql()
#                  RETURNING r_sql,r_sql1
# Return code....: r_sql    關於glar_t的SQL語句
#                : r_sql1   關於glaq_t的SQL語句
# Date & Author..: 2014/03/24 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_fix_acc_get_sql()
   DEFINE r_sql,r_sql1,r_sql2   STRING 
   DEFINE r_sql3,r_sql4         STRING #160505-00007#14
   
   LET r_sql=''
   LET r_sql1=''
   LET r_sql2=''
   LET r_sql3=''  #160505-00007#14
   LET r_sql4=''  #160505-00007#14
   
   IF tm.comp='Y' THEN
      LET r_sql =r_sql,"glar012"
      LET r_sql1=r_sql1,"glaq017"
      LET r_sql2=r_sql2,"glaq017 glar012"
      LET r_sql3=r_sql3,",glar012"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq017 glar012"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,"''"
      LET r_sql1=r_sql1,"''"
      LET r_sql2=r_sql2,"''"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql =r_sql,",glar013"
      LET r_sql1=r_sql1,",glaq018"
      LET r_sql2=r_sql2,",glaq018 glar013"
      LET r_sql3=r_sql3,",glar013"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq018 glar013"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql =r_sql,",glar014"
      LET r_sql1=r_sql1,",glaq019"
      LET r_sql2=r_sql2,",glaq019 glar014"
      LET r_sql3=r_sql3,",glar014"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq019 glar014"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql =r_sql,",glar015"
      LET r_sql1=r_sql1,",glaq020"
      LET r_sql2=r_sql2,",glaq020 glar015"
      LET r_sql3=r_sql3,",glar015"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq020 glar015"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql =r_sql,",glar016"
      LET r_sql1=r_sql1,",glaq021"
      LET r_sql2=r_sql2,",glaq021 glar016"
      LET r_sql3=r_sql3,",glar016"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq021 glar016"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql =r_sql,",glar017"
      LET r_sql1=r_sql1,",glaq022"
      LET r_sql2=r_sql2,",glaq022 glar017"
      LET r_sql3=r_sql3,",glar017"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq022 glar017"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad011='Y' THEN
      LET r_sql =r_sql,",glar018"
      LET r_sql1=r_sql1,",glaq023"
      LET r_sql2=r_sql2,",glaq023 glar018"
      LET r_sql3=r_sql3,",glar018"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq023 glar018"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql =r_sql,",glar019"
      LET r_sql1=r_sql1,",glaq024"
      LET r_sql2=r_sql2,",glaq024 glar019"
      LET r_sql3=r_sql3,",glar019"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq024 glar019"   #160505-00007#14
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
      LET r_sql3=r_sql3,",glar051"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq051 glar051"   #160505-00007#14
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
      LET r_sql3=r_sql3,",glar052"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq052 glar052"   #160505-00007#14
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
      LET r_sql3=r_sql3,",glar053"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq053 glar053"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql =r_sql,",glar020"
      LET r_sql1=r_sql1,",glaq025"
      LET r_sql2=r_sql2,",glaq025 glar020"
      LET r_sql3=r_sql3,",glar020"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq025 glar020"   #160505-00007#14
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
      LET r_sql3=r_sql3,",glar022"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq027 glar022"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql =r_sql,",glar023"
      LET r_sql1=r_sql1,",glaq028"
      LET r_sql2=r_sql2,",glaq028 glar023"
      LET r_sql3=r_sql3,",glar023"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq028 glar023"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql =r_sql,",glar024"
      LET r_sql1=r_sql1,",glaq029"
      LET r_sql2=r_sql2,",glaq029 glar024"
      LET r_sql3=r_sql3,",glar024"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq029 glar024"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql =r_sql,",glar025"
      LET r_sql1=r_sql1,",glaq030"
      LET r_sql2=r_sql2,",glaq030 glar025"
      LET r_sql3=r_sql3,",glar025"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq030 glar025"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql =r_sql,",glar026"
      LET r_sql1=r_sql1,",glaq031"
      LET r_sql2=r_sql2,",glaq031 glar026"
      LET r_sql3=r_sql3,",glar026"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq031 glar026"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql =r_sql,",glar027"
      LET r_sql1=r_sql1,",glaq032"
      LET r_sql2=r_sql2,",glaq032 glar027"
      LET r_sql3=r_sql3,",glar027"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq032 glar027"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql =r_sql,",glar028"
      LET r_sql1=r_sql1,",glaq033"
      LET r_sql2=r_sql2,",glaq033 glar028"
      LET r_sql3=r_sql3,",glar028"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq033 glar028"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql =r_sql,",glar029"
      LET r_sql1=r_sql1,",glaq034"
      LET r_sql2=r_sql2,",glaq034 glar029"
      LET r_sql3=r_sql3,",glar029"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq034 glar029"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql =r_sql,",glar030"
      LET r_sql1=r_sql1,",glaq035"
      LET r_sql2=r_sql2,",glaq035 glar030"
      LET r_sql3=r_sql3,",glar030"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq035 glar030"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql =r_sql,",glar031"
      LET r_sql1=r_sql1,",glaq036"
      LET r_sql2=r_sql2,",glaq036 glar031"
      LET r_sql3=r_sql3,",glar031"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq036 glar031"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql =r_sql,",glar032"
      LET r_sql1=r_sql1,",glaq037"
      LET r_sql2=r_sql2,",glaq037 glar032"
      LET r_sql3=r_sql3,",glar032"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq037 glar032"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql =r_sql,",glar033"
      LET r_sql1=r_sql1,",glaq038"
      LET r_sql2=r_sql2,",glaq038 glar033"
      LET r_sql3=r_sql3,",glar033"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq038 glar033"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.curr_o='Y' THEN
      LET r_sql =r_sql,",glar009"
      LET r_sql1=r_sql1,",glaq005"
      LET r_sql2=r_sql2,",glaq005 glar009"
      LET r_sql3=r_sql3,",glar009"           #160505-00007#14
      LET r_sql4=r_sql4,",glaq005 glar009"   #160505-00007#14
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   RETURN r_sql,r_sql1,r_sql2,r_sql3,r_sql4 #160505-00007#14 add r_sql3,r_sql4
END FUNCTION

################################################################################
# Descriptions...: 動態設定元件是否需輸入值
# Memo...........:
# Usage..........: CALL aglq720_set_comp_entry(ps_fields,pi_entry)
# Input parameter: ps_fields   欄位名稱
#                : pi_entry    是否進入欄位
# Date & Author..: 2014/04/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq720_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/3/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_fetch1(p_flag)
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
   LET g_glar009 = g_glar_s[g_current_idx].glar009 
   CALL aglq720_b_fill1() 
END FUNCTION

################################################################################
# Descriptions...: 双击单身某一行串查aglq750总分类账核算项查询
# Memo...........:
# Usage..........: CALL aglq720_cmdrun()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   
   #170106-00024#1--add--str--
   #当跨年查询是不可以串查
   IF tm.syear <> tm.eyear THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00540'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #170106-00024#1--add--end
   
   #160509-00004#107--add--str--lujh
   IF g_glar_d[g_detail_idx].qcd = 0 AND g_glar_d[g_detail_idx].qcc = 0 AND g_glar_d[g_detail_idx].qjd = g_glar_d[g_detail_idx].qjc THEN
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'aglq770'
      LET la_param.param[1] = g_glaald    #帳別
      LET la_param.param[2] = tm.syear    #年度
      LET la_param.param[3] = tm.speriod  #起始期別
      LET la_param.param[4] = tm.eperiod  #截止期別
      LET la_param.param[5] = tm.ctype    #多本位幣顯示
      LET la_param.param[6] = 'N'         #顯示原幣
      LET la_param.param[7] = 'N'         #按幣別分頁
      LET la_param.param[8] = 'N'         #按科目分頁
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
   ELSE
   #160509-00004#107--add--end--lujh
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'aglq750'
      LET la_param.param[1] = g_glaald    #帳別
      LET la_param.param[2] = tm.syear    #年度   
      LET la_param.param[3] = tm.speriod  #起始期別
      LET la_param.param[4] = tm.eperiod  #截止期別
      LET la_param.param[5] = 'N'         #按科目分頁管理
      LET la_param.param[6] = tm.ctype    #多本位幣顯示
      LET la_param.param[7] = tm.show_acc #顯示統制科目
      LET la_param.param[8] = tm.glac005  #科目層級
      LET la_param.param[9] = tm.stus     #單據狀態
      LET la_param.param[10] = tm.glac009 #含內部管理
      LET la_param.param[11] = tm.show_ce #含月結
      LET la_param.param[12] = tm.show_ye #含年結
      LET la_param.param[13] = tm.comp    #营运据点
      LET la_param.param[14] = tm.glad007 #部门管理
      LET la_param.param[15] = tm.glad008 #利润成本
      LET la_param.param[16] = tm.glad009 #区域管理
      LET la_param.param[17] = tm.glad010 #交易客商
      LET la_param.param[18] = tm.glad027 #账款客商
      LET la_param.param[19] = tm.glad011 #客群
      LET la_param.param[20] = tm.glad012 #产品类别
      LET la_param.param[21] = tm.glad031 #经营方式
      LET la_param.param[22] = tm.glad032 #渠道
      LET la_param.param[23] = tm.glad033 #品牌
      LET la_param.param[24] = tm.glad013 #人员
      LET la_param.param[25] = tm.glad015 #专案
      LET la_param.param[26] = tm.glad016 #WBS
      LET la_param.param[27] = tm.glad017 #自由核算项一
      LET la_param.param[28] = tm.glad018 #自由核算项二
      LET la_param.param[29] = tm.glad019 #自由核算项三
      LET la_param.param[30] = tm.glad020 #自由核算项四
      LET la_param.param[31] = tm.glad021 #自由核算项五
      LET la_param.param[32] = tm.glad022 #自由核算项六
      LET la_param.param[33] = tm.glad023 #自由核算项七
      LET la_param.param[34] = tm.glad024 #自由核算项八
      LET la_param.param[35] = tm.glad025 #自由核算项九
      LET la_param.param[36] = tm.glad026 #自由核算项十
      LET la_param.param[37] = g_glar_d[g_detail_idx].glar001 #科目編號
      LET la_param.param[38] = g_glar_d[g_detail_idx].glar012 #营运据点
      LET la_param.param[39] = g_glar_d[g_detail_idx].glar013 #部门管理
      LET la_param.param[40] = g_glar_d[g_detail_idx].glar014 #利润成本
      LET la_param.param[41] = g_glar_d[g_detail_idx].glar015 #区域管理
      LET la_param.param[42] = g_glar_d[g_detail_idx].glar016 #交易客商
      LET la_param.param[43] = g_glar_d[g_detail_idx].glar017 #账款客商
      LET la_param.param[44] = g_glar_d[g_detail_idx].glar018 #客群
      LET la_param.param[45] = g_glar_d[g_detail_idx].glar019 #产品类别
      LET la_param.param[46] = g_glar_d[g_detail_idx].glar051 #经营方式
      LET la_param.param[47] = g_glar_d[g_detail_idx].glar052 #渠道
      LET la_param.param[48] = g_glar_d[g_detail_idx].glar053 #品牌
      LET la_param.param[49] = g_glar_d[g_detail_idx].glar020 #人员
      LET la_param.param[50] = g_glar_d[g_detail_idx].glar022 #专案
      LET la_param.param[51] = g_glar_d[g_detail_idx].glar023 #WBS
      LET la_param.param[52] = g_glar_d[g_detail_idx].glar024 #自由核算项一
      LET la_param.param[53] = g_glar_d[g_detail_idx].glar025 #自由核算项二
      LET la_param.param[54] = g_glar_d[g_detail_idx].glar026 #自由核算项三
      LET la_param.param[55] = g_glar_d[g_detail_idx].glar027 #自由核算项四
      LET la_param.param[56] = g_glar_d[g_detail_idx].glar028 #自由核算项五
      LET la_param.param[57] = g_glar_d[g_detail_idx].glar029 #自由核算项六
      LET la_param.param[58] = g_glar_d[g_detail_idx].glar030 #自由核算项七
      LET la_param.param[59] = g_glar_d[g_detail_idx].glar031 #自由核算项八
      LET la_param.param[60] = g_glar_d[g_detail_idx].glar032 #自由核算项九
      LET la_param.param[61] = g_glar_d[g_detail_idx].glar033 #自由核算项十 
      LET la_param.param[62] = tm.show_ad #含審計調整傳票 #150827-00036#2 add
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF     #160509-00004#107 add lujh 
END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_xg_visible()
   LET g_xg_visible = NULL

   IF tm.curr_o='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar009|l_oyeard|l_oyearc|l_oqcd|l_oqcc|l_oqjd|l_oqjc|l_oqmd|l_oqmc|l_osumd|l_osumc"
   END IF     

   #顯示本位幣三
   IF tm.ctype='2' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qcd2|l_qcc2|l_qjd2|l_qjc2|l_qmd2|l_qmc2|l_sumd2|l_sumc2"
   END IF
   #顯示本位幣二
   IF tm.ctype='1' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qcd3|l_qcc3|l_qjd3|l_qjc3|l_qmd3|l_qmc3|l_sumd3|l_sumc3"
   END IF
   #只顯示本位幣一
   IF tm.ctype='0' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_qcd2|l_qcc2|l_qjd2|l_qjc2|l_qmd2|l_qmc2|l_sumd2|l_sumc2|l_qcd3|l_qcc3|l_qjd3|l_qjc3|l_qmd3|l_qmc3|l_sumd3|l_sumc3"
   END IF
   
   #顯示年初數
   IF tm.show_y='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_yeard|l_yearc|l_yeard2|l_yearc2|l_yeard3|l_yearc3"
   ELSE
      CASE 
         WHEN tm.ctype='0' 
            IF NOT cl_null(g_xg_visible) THEN
               LET g_xg_visible = g_xg_visible CLIPPED,"|"
            END IF
            LET g_xg_visible = g_xg_visible CLIPPED,"l_yeard2|l_yearc2|l_yeard3|l_yearc3"
         WHEN tm.ctype='1' 
            IF NOT cl_null(g_xg_visible) THEN
               LET g_xg_visible = g_xg_visible CLIPPED,"|"
            END IF
            LET g_xg_visible = g_xg_visible CLIPPED,"l_yeard3|l_yearc3"
         WHEN tm.ctype='2' 
            IF NOT cl_null(g_xg_visible) THEN
               LET g_xg_visible = g_xg_visible CLIPPED,"|"
            END IF
            LET g_xg_visible = g_xg_visible CLIPPED,"l_yeard2|l_yearc2" 
      END CASE
   END IF


    IF tm.comp='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar012|l_glar012_desc"
   END IF
   
   IF tm.glad007='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar013|l_glar013_desc"
   END IF
   
   IF tm.glad008='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar014|l_glar014_desc"
   END IF
   
   IF tm.glad009='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar015|l_glar015_desc"
   END IF
   
   IF tm.glad010='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar016|l_glar016_desc"
   END IF
   
   IF tm.glad027='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar017|l_glar017_desc"
   END IF
   
   IF tm.glad011='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar018|l_glar018_desc"
   END IF
   
   IF tm.glad012='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar019|l_glar019_desc"
   END IF
   #經營方式
   IF tm.glad031='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glar051"
   END IF
   #渠道
   IF tm.glad032='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar052|l_glar052_desc"
   END IF
   #品牌
   IF tm.glad033='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar053|l_glar053_desc"
   END IF
   
   IF tm.glad013='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar020|l_glar020_desc"
   END IF 
    
   IF tm.glad015='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar022|l_glar022_desc"
   END IF
   
   IF tm.glad016='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar023|l_glar023_desc"
   END IF
   
   IF tm.glad017='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar024|l_glar024_desc"
   END IF
   
   IF tm.glad018='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar025|l_glar025_desc"
   END IF
   
   IF tm.glad019='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar026|l_glar026_desc"
   END IF
   
   IF tm.glad020='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar027|l_glar027_desc"
   END IF
   
   IF tm.glad021='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar028|l_glar028_desc"
   END IF
   
   IF tm.glad022='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar029|l_glar029_desc"
   END IF
   
   IF tm.glad023='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar030|l_glar030_desc"
   END IF
   
   IF tm.glad024='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar031|l_glar031_desc"
   END IF
   
   IF tm.glad025='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar032|l_glar032_desc"
   END IF
   
   IF tm.glad026='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"glar033|l_glar033_desc"
   END IF
END FUNCTION

################################################################################
# Descriptions...: 优化抓取数据代码
# Memo...........: #160505-00007#14 add
# Usage..........: CALL aglq720_get_data2()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_get_data2()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc                  STRING 
   DEFINE l_glaq002        STRING
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
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_oyeard         LIKE type_t.num20_6
   DEFINE l_oyearc         LIKE type_t.num20_6
   DEFINE l_yeard          LIKE type_t.num20_6
   DEFINE l_yearc          LIKE type_t.num20_6
   DEFINE l_yeard2         LIKE type_t.num20_6
   DEFINE l_yearc2         LIKE type_t.num20_6
   DEFINE l_yeard3         LIKE type_t.num20_6
   DEFINE l_yearc3         LIKE type_t.num20_6
   DEFINE l_oqcd           LIKE type_t.num20_6
   DEFINE l_oqcc           LIKE type_t.num20_6
   DEFINE l_qcd            LIKE type_t.num20_6
   DEFINE l_qcc            LIKE type_t.num20_6
   DEFINE l_qcd2           LIKE type_t.num20_6
   DEFINE l_qcc2           LIKE type_t.num20_6
   DEFINE l_qcd3           LIKE type_t.num20_6
   DEFINE l_qcc3           LIKE type_t.num20_6
   DEFINE l_oqjd           LIKE type_t.num20_6
   DEFINE l_oqjc           LIKE type_t.num20_6
   DEFINE l_qjd            LIKE type_t.num20_6
   DEFINE l_qjc            LIKE type_t.num20_6
   DEFINE l_qjd2           LIKE type_t.num20_6
   DEFINE l_qjc2           LIKE type_t.num20_6
   DEFINE l_qjd3           LIKE type_t.num20_6
   DEFINE l_qjc3           LIKE type_t.num20_6
   DEFINE l_oqmd           LIKE type_t.num20_6
   DEFINE l_oqmc           LIKE type_t.num20_6
   DEFINE l_qmd            LIKE type_t.num20_6
   DEFINE l_qmc            LIKE type_t.num20_6
   DEFINE l_qmd2           LIKE type_t.num20_6
   DEFINE l_qmc2           LIKE type_t.num20_6
   DEFINE l_qmd3           LIKE type_t.num20_6
   DEFINE l_qmc3           LIKE type_t.num20_6
   DEFINE l_osumd          LIKE type_t.num20_6
   DEFINE l_osumc          LIKE type_t.num20_6
   DEFINE l_sumd           LIKE type_t.num20_6
   DEFINE l_sumc           LIKE type_t.num20_6
   DEFINE l_sumd2          LIKE type_t.num20_6
   DEFINE l_sumc2          LIKE type_t.num20_6
   DEFINE l_sumd3          LIKE type_t.num20_6
   DEFINE l_sumc3          LIKE type_t.num20_6
   DEFINE l_amt1           LIKE type_t.num20_6
   DEFINE l_amt2           LIKE type_t.num20_6
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6
   DEFINE l_amt5           LIKE type_t.num20_6
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_amt7           LIKE type_t.num20_6
   DEFINE l_amt8           LIKE type_t.num20_6
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_str,l_str1,l_str2  STRING
   DEFINE l_str3,l_str4        STRING
   DEFINE l_num,l_i        LIKE type_t.num5
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_flag2          LIKE type_t.num5
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_glac002_str    STRING
   DEFINE l_sql_pr1        STRING
   DEFINE l_sql_pr6        STRING
   DEFINE l_sql_pr7        STRING
   DEFINE l_sql_pr8        STRING
   DEFINE l_sql_pr6_1      STRING
   DEFINE l_sql_pr7_1      STRING
   DEFINE l_sql_pr8_1      STRING
   DEFINE l_sql_hsx        STRING
   DEFINE l_glac002_o      LIKE glac_t.glac002
   DEFINE l_glac002_t      LIKE glac_t.glac002
   DEFINE l_glac003        LIKE glac_t.glac003
   DEFINE l_sql_t01        STRING  
   DEFINE l_sql_t02        STRING 
   DEFINE l_sql_t03        STRING 
   DEFINE l_sql_nch        STRING 
   DEFINE l_sql_qch        STRING 
   DEFINE l_sql_qj         STRING 
   DEFINE l_sql_lj         STRING
   DEFINE l_hsx_nch        STRING
   DEFINE l_str01,l_str02  STRING
   
   
   #刪除臨時表中資料
   DELETE FROM aglq720_tmp
   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.speriod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.eperiod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   #判斷是否是整期間查詢
   IF tm.sdate=l_pdate_s1 AND tm.edate=l_pdate_e2 THEN
      LET l_flag=TRUE
   ELSE
      LET l_flag=FALSE
   END IF
   #核算項條件篩選
   LET l_wc=cl_replace_str(g_wc,'glar001','glaq002')
   LET l_wc=cl_replace_str(l_wc,'glar009','glaq005')
   LET l_wc=cl_replace_str(l_wc,'glar012','glaq017')
   LET l_wc=cl_replace_str(l_wc,'glar013','glaq018')
   LET l_wc=cl_replace_str(l_wc,'glar014','glaq019')
   LET l_wc=cl_replace_str(l_wc,'glar015','glaq020')
   LET l_wc=cl_replace_str(l_wc,'glar016','glaq021')
   LET l_wc=cl_replace_str(l_wc,'glar017','glaq022')
   LET l_wc=cl_replace_str(l_wc,'glar018','glaq023')
   LET l_wc=cl_replace_str(l_wc,'glar019','glaq024')
   LET l_wc=cl_replace_str(l_wc,'glar020','glaq025')
#   LET l_wc=cl_replace_str(l_wc,'glar021','glaq026')
   LET l_wc=cl_replace_str(l_wc,'glar022','glaq027')
   LET l_wc=cl_replace_str(l_wc,'glar023','glaq028')
   LET l_wc=cl_replace_str(l_wc,'glar051','glaq051')
   LET l_wc=cl_replace_str(l_wc,'glar052','glaq052')
   LET l_wc=cl_replace_str(l_wc,'glar053','glaq053')
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
   
   LET l_num =g_wc.getIndexOf('glar001',1)
   IF l_num>0 THEN
      LET l_i=g_wc.getIndexOf('and',1)
      IF l_i=0 THEN
         LET l_sql1=g_wc
      ELSE
         LET l_sql1=g_wc.substring(l_num,l_i-1) 
      END IF
      LET l_sql1=" AND ",cl_replace_str(l_sql1,'glar001','glac002')
   END IF
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
   
#151204-00013#2--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#2--mark--end

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
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   #核算項
   CALL aglq720_fix_acc_get_sql() RETURNING l_str,l_str1,l_str2,l_str01,l_str02 
   
   #判斷是否勾選原幣或核算項等
   LET l_num =l_str.getIndexOf('g',1)
   IF l_num>0 THEN 
      LET l_flag2=TRUE #表示勾選了顯示原幣或核算項  
   END IF
   
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #抓取該年第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   
   #抓取上一期最後一天
   IF tm.speriod > 1 THEN
      LET l_period=tm.speriod-1 #上期
      SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=l_period
   ELSE
      #抓取上一年的最后一天
      SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear-1 
      IF cl_null(l_glav004_m) THEN
         LET l_glav004_m=MDY(12,31,tm.syear-1)
      END IF
   END IF
   #获取期初截止日期
   IF tm.sdate=l_pdate_s1 THEN
      LET l_glav004_e=l_glav004_m
   ELSE
      LET l_glav004_e=tm.sdate-1
   END IF
   
   #抓出所有符合條件的會計科目+核算项
   LET g_sql="SELECT DISTINCT glac002,glac003,",l_str,
             "  FROM glac_t "
   #當勾選了顯示原幣或核算項等條件后，依勾選條件遍歷查詢資料
   IF l_flag2=TRUE THEN
      IF l_flag=TRUE AND tm.syear=tm.eyear AND tm.stus='1' THEN #表示查询范围是整期间
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   "            SELECT glar001 ",l_str01,
                   "              FROM glar_t",
                   "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                   "               AND glar002=",tm.syear,
                   "               AND glar003<=",tm.eperiod,
                   "               AND ",g_wc,
                   "           ) hsx ON hsx.glar001=glac002" 
         
      ELSE 
         LET g_sql=g_sql,
                   " LEFT JOIN (",
                   "            SELECT glaq002 ",l_str02,
                   "              FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "             WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "               AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear, #抓取大于等于起始年度且小于截止日期的所有核算项
                   "               AND ",l_wc,l_sql2,l_sql4,
                   "            UNION ",  #年初余额
                   "            SELECT glar001 glaq002",l_str01,
                   "              FROM glar_t",
                   "             WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                   "               AND glar002=",tm.syear," AND glar003=0 ",
                   "               AND ",g_wc,
                   "           ) hsx ON hsx.glaq002=glac002"
      END IF
   END IF
   LET g_sql=g_sql,
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' AND glacstus='Y' ",l_sql1,
             " ORDER BY glac002,glac003,",l_str
   PREPARE aglq720_sel_glac_pr2 FROM g_sql
   DECLARE aglq720_sel_glac_cs2 CURSOR FOR aglq720_sel_glac_pr2     
   
   #當勾選了顯示原幣或核算項等條件后，依勾選條件遍歷查詢資料
   IF l_flag2=TRUE THEN
      IF l_flag=TRUE AND tm.syear=tm.eyear AND tm.stus='1' THEN #表示查询范围是整期间且單據狀態为1.已过账  
         LET l_sql_hsx="SELECT DISTINCT ",l_str,
                       "   FROM glar_t",
                       "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                       "    AND glar002=",tm.syear,
                       "    AND glar003<=",tm.eperiod,
                       "    AND ",g_wc
      ELSE
         LET l_hsx_nch="SELECT DISTINCT ",l_str,
                       "   FROM (",
                       "         SELECT ",l_str,
                       "            FROM glar_t",
                       "           WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                       "             AND glar002=",tm.syear," AND glar003=0",
                       "             AND ",g_wc     
         LET l_sql_hsx="SELECT ",l_str2,
                       "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                       " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                       "    AND glapdocdt <='",tm.edate,"' AND glap002>=",tm.syear, #抓取大于等于起始年度且小于截止日期的所有核算项
                       "    AND ",l_wc,l_sql2,l_sql4
      END IF
   END IF

   #年初數
   IF tm.show_y='Y' THEN 
                    #         原幣借-貸            /本幣借-貸
      LET l_sql_nch="  SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                    #         本幣二借-貸          /本幣三借-貸
                    "         SUM(glar034-glar035),SUM(glar036-glar037) ",
                    "    FROM glar_t",    
                    "   WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                    "     AND glar002=",tm.syear," AND glar003=0 "
   END IF
   #期初
   #當起始日期是該期別的第一天，且傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
   IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN 
      LET l_period=tm.speriod-1 #上期
                    #        原幣借-貸            /本幣借-貸
      LET l_sql_qch=" SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                    #        本幣二借-貸          /本幣三借-貸
                    "        SUM(glar034-glar035),SUM(glar036-glar037) ",
                    "   FROM glar_t",    
                    "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                    "    AND glar002=",tm.syear," AND glar003<=",l_period
   ELSE
                    #        原幣借-貸
      LET l_sql_qch=" SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                    #        本幣借-貸            /本幣二借-貸          /本幣三借-貸
                    "        SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044)",
                    "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "    AND glapdocdt BETWEEN '",l_glav004,"' AND '",l_glav004_e,"'",
                    l_sql2,l_sql4
   END IF
   #期間異動
   #当整期间且不跨年查询且傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
   IF l_flag=TRUE AND tm.syear = tm.eyear AND tm.stus='1' THEN
                   #        原幣借方金額  /原幣貸方金額 
      LET l_sql_qj=" SELECT SUM(glar010),SUM(glar011),",
                   #        本幣借方金額  /本幣貸方金額
                   "        SUM(glar005), SUM(glar006),",
                   #        本幣二借方金額 /本幣二貸方金額 /本幣三借方金額 /本幣三貸方金額
                   "        SUM(glar034), SUM(glar035), SUM(glar036), SUM(glar037)",
                   "   FROM glar_t",
                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"'",
                   "    AND glar002=",tm.syear,
                   "    AND glar003 BETWEEN ",tm.speriod," AND ",tm.eperiod,
                   "    AND ",g_wc
   ELSE
                   #        原幣借方金額
      LET l_sql_qj=" SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                   #        原幣貸方金額
                   "        SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                   #        本幣借方金額  /本幣貸方金額 /本幣二借方金額 /本幣二貸方金額 
                   "        SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   #        本幣三借方金額 /本幣三貸方金額
                   "        SUM(glaq043),SUM(glaq044)",
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                   l_sql2,l_sql4
   END IF
   #本年累計
   #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
   IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
                   #        原幣借方金額  /原幣貸方金額 /本幣借方金額 /本幣貸方金額
      LET l_sql_lj=" SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                   #        本幣二借方金額 /本幣二貸方金額 /本幣三借方金額 /本幣三貸方金額
                   "        SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037)",
                   "   FROM glar_t",    
                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                   "    AND glar002=",tm.eyear," AND glar003<= ",tm.eperiod,
                   "    AND glar003<>0 "
   ELSE            
                   #        原幣借方金額
      LET l_sql_lj=" SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                   #        原幣貸方金額
                   "        SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                   #        本幣借方金額 /本幣貸方金額 /本幣二借方金額 /本幣二貸方金額
                   "        SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   #        本幣三借方金額 /本幣三貸方金額
                   "        SUM(glaq043),SUM(glaq044)",
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "    AND glapdocdt BETWEEN '",l_glav004,"' AND '",tm.edate,"'",
                   l_sql2,l_sql4
   END IF
   
   #年初、期初
   LET l_sql_pr1="SELECT SUM(glar010-glar011),SUM(glar005-glar006),SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                 " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                 "   AND glar001=? AND glar002=? AND glar003<=? "
   
   IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN 
      #期初：抓取YE、AD傳票金額
      LET l_sql_pr6="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                    "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glap002= ? AND glap004<=? ",
                    "   AND glapstus='S'",
                    l_sql3
      
      #本年累計：抓取YE、AD憑證金額
      LET l_sql_pr7="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                     "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                     "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                     "       SUM(glaq043),SUM(glaq044) ",
                     "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                     " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                     "   AND glap002= ? AND glap004<=? ",  
                     "   AND glapstus='S'",
                     l_sql3
      
      #期間異動：抓取YE、AD憑證金額
      LET l_sql_pr8="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                    "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                    "       SUM(glaq043),SUM(glaq044)",
                    "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                    " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                    "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                    "   AND glapstus='S'",
                    l_sql3
   END IF
   
   #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
   IF tm.show_ce <> 'Y' THEN
      #期初：抓取CE、XC傳票金額
      LET l_sql_pr6_1="SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
                      "      SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",
                      l_sql4
      
      #本年累計：抓取CE、XC憑證金額
      LET l_sql_pr7_1="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044) ",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glap002= ? AND glap004<=? ",  
                      l_sql4
   
      #期間異動：抓取CE、XC憑證金額
      LET l_sql_pr8_1="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END ),",
                      "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                      "       SUM(glaq043),SUM(glaq044)",
                      "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                      l_sql4
   END IF
   #插入临时表
   LET l_sql="INSERT INTO aglq720_tmp ",
             "VALUES(",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?,?,?,?,",
             "   ?,?,?,?,?, ?,?)"
   PREPARE aglq720_ins_pr2 FROM l_sql
   
   LET l_glac002_o=NULL
   LET l_glac002_t=NULL
   #科目遍歷
   FOREACH aglq720_sel_glac_cs2 INTO l_glac002,l_glac003,
                                     l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,
                                     l_glar022,l_glar023,l_glar024,l_glar025,l_glar026,l_glar027,
                                     l_glar028,l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,
                                     l_glar009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'FOREACH aglq720_sel_glac_cs2'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      IF cl_null(l_glac002_o) OR l_glac002_o <> l_glac002 THEN
         #当科目是统治科目时，抓取下层明细科目
         LET l_glaq002 = '' #160824-00004#4 add
         IF l_glac003 = '1' THEN
            #抓取科目对应的明细科目或者独立科目
            CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002
         END IF #160824-00004#4 add
#         ELSE  #160824-00004#4 mark
         
         IF cl_null(l_glaq002) THEN #160824-00004#4 add
            LET l_glaq002 = "'",l_glac002,"'"
         END IF
         
         IF tm.show_ce <> 'Y' THEN
            LET l_glac002_str = " AND glac002 IN (",l_glaq002,")"
         END IF
         
         #当该统治科目没有下层明细科目时，抓取该科目本身资料
         IF cl_null(l_glaq002) THEN
            LET l_glaq002 = " AND glaq002='",l_glac002,"'"
         ELSE
            LET l_glaq002 = " AND glaq002 IN (",l_glaq002,")"
         END IF
         
         LET l_glac002_o = l_glac002 #记录旧值
      END IF
      #当一下条件时，直接根据科目、币别、核算项等条件抓取金额资料
      #1.当没有勾选原币或核算项
      #2.當勾選了顯示原幣或核算項等條件后，科目不是统制科目或者科目是统制科目但凭证状态=1.已过账
      IF l_flag2=FALSE OR l_glac003<>'1' OR (l_glac003='1' AND tm.stus='1') THEN
         IF l_flag2 = TRUE THEN
            CALL aglq720_fix_acc_sql(l_glar009,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar020,l_glar022,l_glar023,l_glar051,l_glar052,l_glar053,
                                     l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                                     l_glar031,l_glar032,l_glar033)
            RETURNING l_str3,l_str4
         ELSE
            LET l_str3=''
            LET l_str4=''
         END IF
         
         #年初數
         IF tm.show_y='Y' THEN 
            LET g_sql=l_sql_nch,
                      " AND glar001 = '",l_glac002,"'",l_str3
            PREPARE aglq720_sum_pr_nch FROM g_sql
         END IF
   
         #期初
         #當起始日期是該期別的第一天，且傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
            LET g_sql=l_sql_qch,
                      " AND glar001 = '",l_glac002,"'",
                      l_str3
         ELSE
            LET g_sql=l_sql_qch,
                      l_glaq002,
                      l_str4
         END IF
         PREPARE aglq720_sum_pr_qch FROM g_sql
         
         #期間異動
         #当整期间且不跨年查询且傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
         IF l_flag=TRUE AND tm.syear = tm.eyear AND tm.stus='1' THEN
            LET g_sql=l_sql_qj,
                      " AND glar001 = '",l_glac002,"'",
                      l_str3
         ELSE
            LET g_sql=l_sql_qj,
                      l_glaq002,
                      l_str4
         END IF
         PREPARE aglq720_sum_pr_qj FROM g_sql
         
         #本年累計
         #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
            LET g_sql=l_sql_lj,
                      " AND glar001 = '",l_glac002,"'",
                      l_str3
         ELSE
            LET g_sql=l_sql_lj,
                      l_glaq002,
                      l_str4
         END IF
         PREPARE aglq720_sum_pr_lj FROM g_sql

         #年初、期初
         LET l_sql=l_sql_pr1,l_str3
         PREPARE aglq720_sel_pr1_2 FROM l_sql
         
         IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN
            #期初：抓取YE、AD傳票金額
            LET l_sql=l_sql_pr6,l_glaq002,l_str4
            PREPARE aglq720_sel_pr6_2 FROM l_sql
            
            #本年累計：抓取YE、AD憑證金額
            LET l_sql=l_sql_pr7,l_glaq002,l_str4
            PREPARE aglq720_sel_pr7_2 FROM l_sql
            
            #期間異動：抓取YE、AD憑證金額
            LET l_sql=l_sql_pr8,l_glaq002,l_str4
            PREPARE aglq720_sel_pr8_2 FROM l_sql
         END IF
         
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            #期初：抓取CE、XC傳票金額
            LET l_sql=l_sql_pr6_1,
                      l_glaq002,l_str4,
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
#                      "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                      "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                      "                                               AND xcea001>='",l_glav004,"' AND xcea001<'",tm.sdate,"'",
                      "                                     )",
                      "        )",
                      #160824-00004#4--add--end
                      "       )"
            PREPARE aglq720_sel_pr6_21 FROM l_sql
            
            #本年累計：抓取CE、XC憑證金額
            LET l_sql=l_sql_pr7_1,
                      l_glaq002,l_str4,
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
#                      "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                      "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                      "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",tm.edate,"'",
                      "                                     )",
                      "        )",
                      #160824-00004#4--add--end
                      "       )"
            PREPARE aglq720_sel_pr7_21 FROM l_sql
         
            #期間異動：抓取CE、XC憑證金額
            LET l_sql=l_sql_pr8_1,
                      l_glaq002,l_str4,
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
#                      "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                      "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                      "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                      "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                      "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                      "                                               AND xcea001 BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                      "                                     )",
                      "        )",
                      #160824-00004#4--add--end
                      "       )"
            PREPARE aglq720_sel_pr8_21 FROM l_sql
         END IF
         
         #抓取金额  
         LET l_oyeard = 0  LET l_oyearc = 0
         LET l_yeard = 0   LET l_yearc = 0
         LET l_yeard2 = 0  LET l_yearc2 = 0
         LET l_yeard3 = 0  LET l_yearc3 = 0
         #是否显示年初数
         IF tm.show_y='Y' THEN
            #年初數
            EXECUTE aglq720_sum_pr_nch INTO l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3
            IF cl_null(l_oyeard) THEN LET l_oyeard = 0 END IF
            IF cl_null(l_oyearc) THEN LET l_oyearc = 0 END IF
            IF cl_null(l_yeard) THEN LET l_yeard = 0 END IF
            IF cl_null(l_yearc) THEN LET l_yearc = 0 END IF
            IF cl_null(l_yeard2) THEN LET l_yeard2 = 0 END IF
            IF cl_null(l_yearc2) THEN LET l_yearc2 = 0 END IF
            IF cl_null(l_yeard3) THEN LET l_yeard3 = 0 END IF
            IF cl_null(l_yearc3) THEN LET l_yearc3 = 0 END IF
         END IF
         
         #期初金額
         LET l_amt1=0
         LET l_amt2=0
         LET l_amt3=0
         LET l_amt4=0
         EXECUTE aglq720_sum_pr_qch INTO l_amt1,l_amt2,l_amt3,l_amt4
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         LET l_period=tm.speriod-1 #上期
         #當整期間且傳狀態為stus=1:已過帳時，抓取匯總glar_t,否則抓取資料來源為glaq_t
         IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr6_2 USING tm.syear,l_period
                                          INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr6_2'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
            END IF
         #當為破期時，匯總該年第一天到查詢條件的起始日期tm.sdate的傳票資料
         ELSE
            #抓取年初金額
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            LET l_period=0
            EXECUTE aglq720_sel_pr1_2 USING l_glac002,tm.syear,l_period
                                       INTO l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr1_2'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_amt1=l_amt1+l_amt5
            LET l_amt2=l_amt2+l_amt6
            LET l_amt3=l_amt3+l_amt7
            LET l_amt4=l_amt4+l_amt8
         END IF
         
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt5=0 
            LET l_amt6=0 
            LET l_amt7=0 
            LET l_amt8=0
            LET l_period=tm.speriod-1 #上期 #160824-00004#4 add
            EXECUTE aglq720_sel_pr6_21 USING tm.syear,l_period
                                        INTO l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr6_21'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_amt1=l_amt1-l_amt5
            LET l_amt2=l_amt2-l_amt6
            LET l_amt3=l_amt3-l_amt7
            LET l_amt4=l_amt4-l_amt8
         END IF
         
         IF l_amt2>=0 THEN
            LET l_oqcd=l_amt1
            LET l_oqcc=0
            LET l_qcd =l_amt2
            LET l_qcc =0
            LET l_qcd2=l_amt3
            LET l_qcc2=0
            LET l_qcd3=l_amt4
            LET l_qcc3=0
         ELSE
            LET l_oqcd=0
            LET l_oqcc=-1*l_amt1
            LET l_qcd =0
            LET l_qcc =-1*l_amt2
            LET l_qcd2=0
            LET l_qcc2=-1*l_amt3
            LET l_qcd3=0
            LET l_qcc3=-1*l_amt4
         END IF 
                 
         #期間異動
         LET l_oqjd = 0         LET l_oqjc = 0
         LET l_qjd  = 0         LET l_qjc  = 0
         LET l_qjd2 = 0         LET l_qjc2 = 0
         LET l_qjd3 = 0         LET l_qjc3 = 0
         EXECUTE aglq720_sum_pr_qj INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
         IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
         IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
         IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
         IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
         IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
         IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
         IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
         IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
         #当整期间且不跨年查询时，當不包含YE或AD憑證時，減去YE或AD傳票金額
         IF l_flag=TRUE AND tm.syear = tm.eyear
            AND (tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr8_2 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr8_2'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
            
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr8_21 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'aglq720_sel_pr8_21'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
            LET l_oqjd=l_oqjd-l_amt1
            LET l_oqjc=l_oqjc-l_amt2
            LET l_qjd =l_qjd -l_amt3
            LET l_qjc =l_qjc -l_amt4
            LET l_qjd2=l_qjd2-l_amt5
            LET l_qjc2=l_qjc2-l_amt6
            LET l_qjd3=l_qjd3-l_amt7
            LET l_qjc3=l_qjc3-l_amt8
         END IF
         
         #期末金額=期初+期間異動
         #原幣
         LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
         IF l_amt1>=0 THEN
            LET l_oqmd=l_amt1
            LET l_oqmc=0
         ELSE
            LET l_oqmd=0
            LET l_oqmc=l_amt1*-1
         END IF
         #本幣
         LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
         IF l_amt1>=0 THEN
            LET l_qmd=l_amt1
            LET l_qmc=0
         ELSE
            LET l_qmd=0
            LET l_qmc=l_amt1*-1
         END IF
         #本幣二
         LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
         IF l_amt1>=0 THEN
            LET l_qmd2=l_amt1
            LET l_qmc2=0
         ELSE
            LET l_qmd2=0
            LET l_qmc2=l_amt1*-1
         END IF
         #本幣三
         LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
         IF l_amt1>=0 THEN
            LET l_qmd3=l_amt1
            LET l_qmc3=0
         ELSE
            LET l_qmd3=0
            LET l_qmc3=l_amt1*-1
         END IF
      
         #本年累計金額
         LET l_osumd= 0         LET l_osumc= 0
         LET l_sumd = 0         LET l_sumc = 0
         LET l_sumd2= 0         LET l_sumc2= 0
         LET l_sumd3= 0         LET l_sumc3= 0
         EXECUTE aglq720_sum_pr_lj INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
         IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
         IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
         IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
         IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
         IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
         IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
         IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
         IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
         #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
         IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN 
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr7_2 USING tm.eyear,tm.eperiod
                                          INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr7_2'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8
            END IF       
         END IF 
            
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            LET l_amt5=0
            LET l_amt6=0
            LET l_amt7=0
            LET l_amt8=0
            EXECUTE aglq720_sel_pr7_21 USING tm.eyear,tm.eperiod
                                        INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr7_21'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
               LET l_osumd=l_osumd-l_amt1
               LET l_osumc=l_osumc-l_amt2
               LET l_sumd =l_sumd -l_amt3
               LET l_sumc =l_sumc -l_amt4
               LET l_sumd2=l_sumd2-l_amt5
               LET l_sumc2=l_sumc2-l_amt6
               LET l_sumd3=l_sumd3-l_amt7
               LET l_sumc3=l_sumc3-l_amt8
         END IF
         
         IF l_yeard=0 AND l_yearc=0 AND  #年初數
            l_qcd=0 AND l_qcc=0 AND      #期初數
            l_qjd=0 AND l_qjc=0 AND      #期間異動
            l_qmd=0 AND l_qmc=0 AND      #期末
            l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
            CONTINUE FOREACH
         END IF
#         INSERT INTO aglq720_tmp 
#         VALUES(g_enterprise,l_glac002,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
#                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
#                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
#                l_glar031,l_glar032,l_glar033,l_glar009,
#                l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
#                l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
#                l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
#                l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
#                l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3)
         EXECUTE aglq720_ins_pr2 USING
                g_enterprise,l_glac002,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                l_glar031,l_glar032,l_glar033,l_glar009,
                l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'insert'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
         END IF
      ELSE
         #当统制科目，且抓取的资料有未过账的凭证资料时，需要通过统制科目对应明细科目范围抓取核算项资料，
         #通过抓取的核算项资料遍历抓取对应金额，且一统制科目只可以遍历一遍
         IF cl_null(l_glac002_t) OR l_glac002_t <> l_glac002 THEN
            LET l_glac002_t = l_glac002
         ELSE
            CONTINUE FOREACH
         END IF
         #统制科目，且抓取资料来源是glaq_t时，需要通过统制科目对应明细科目抓取金额
         IF l_flag=TRUE AND tm.syear=tm.eyear AND tm.stus='1' THEN #表示查询范围是整期间且單據狀態为1.已过账 
            LET l_sql=l_sql_hsx," AND glar001='",l_glac002,"' ORDER BY ",l_str
         ELSE
            LET l_sql=l_hsx_nch," AND glar001='",l_glac002,"'",
                      " UNION ",
                      l_sql_hsx,l_glaq002,")",
                      " ORDER BY ",l_str
         END IF
         PREPARE aglq720_sel_pr_3 FROM l_sql
         DECLARE aglq720_sel_cr_3 CURSOR FOR aglq720_sel_pr_3
         #原幣及核算項遍歷
         FOREACH aglq720_sel_cr_3 INTO l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,
                                     l_glar022,l_glar023,l_glar024,l_glar025,l_glar026,l_glar027,
                                     l_glar028,l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,
                                     l_glar009
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'FOREACH aglq720_sel_cr_3'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            CALL aglq720_fix_acc_sql(l_glar009,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                                     l_glar018,l_glar019,l_glar020,l_glar022,l_glar023,l_glar051,l_glar052,l_glar053,
                                     l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                                     l_glar031,l_glar032,l_glar033)
            RETURNING l_str3,l_str4
            
            #年初數
            IF tm.show_y='Y' THEN 
               LET g_sql=l_sql_nch,
                         " AND glar001 = '",l_glac002,"'",l_str3
               PREPARE aglq720_sum_pr_nch_3 FROM g_sql
            END IF
            
            #期初
            #當起始日期是該期別的第一天，且傳票狀態是已過帳時抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
            IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
               LET g_sql=l_sql_qch,
                         " AND glar001 = '",l_glac002,"'",
                         l_str3
            ELSE
               LET g_sql=l_sql_qch,
                         l_glaq002,
                         l_str4
            END IF
            PREPARE aglq720_sum_pr_qch_3 FROM g_sql
            
            #期間異動
            #当整期间且不跨年查询且傳票狀態是已過帳时，抓取餘額當glar_t資料，否則抓取傳票當glaq_t資料
            IF l_flag=TRUE AND tm.syear = tm.eyear AND tm.stus='1' THEN
               LET g_sql=l_sql_qj,
                         " AND glar001 = '",l_glac002,"'",
                         l_str3
            ELSE
               LET g_sql=l_sql_qj,
                         l_glaq002,
                         l_str4
            END IF
            PREPARE aglq720_sum_pr_qj_3 FROM g_sql
            
            #本年累計
            #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
            IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
               LET g_sql=l_sql_lj,
                         " AND glar001 = '",l_glac002,"'",
                         l_str3
            ELSE
               LET g_sql=l_sql_lj,
                         l_glaq002,
                         l_str4
            END IF
            PREPARE aglq720_sum_pr_lj_3 FROM g_sql
         
            #年初、期初
            LET l_sql=l_sql_pr1,l_str3
            PREPARE aglq720_sel_pr1_3 FROM l_sql
            
            IF tm.show_ye <> 'Y' OR tm.show_ad <> 'Y' THEN
               #期初：抓取YE、AD傳票金額
               LET l_sql=l_sql_pr6,l_glaq002,l_str4
               PREPARE aglq720_sel_pr6_3 FROM l_sql
               
               #本年累計：抓取YE、AD憑證金額
               LET l_sql=l_sql_pr7,l_glaq002,l_str4
               PREPARE aglq720_sel_pr7_3 FROM l_sql
               
               #期間異動：抓取YE、AD憑證金額
               LET l_sql=l_sql_pr8,l_glaq002,l_str4
               PREPARE aglq720_sel_pr8_3 FROM l_sql
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               #期初：抓取CE、XC傳票金額
               LET l_sql=l_sql_pr6_1,
                         l_glaq002,l_str4,
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
#                         "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                         "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                         "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                         "                                               AND xcea001>='",l_glav004,"' AND xcea001<'",tm.sdate,"'",
                         "                                     )",
                         "        )",
                         #160824-00004#4--add--end
                         "       )"
               PREPARE aglq720_sel_pr6_31 FROM l_sql
               
               #本年累計：抓取CE、XC憑證金額
               LET l_sql=l_sql_pr7_1,
                         l_glaq002,l_str4,
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
#                         "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
                         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                         "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                         "                                               AND xcea002 = '9' AND xcea101 IS NOT NULL",  #161027-00022#1 add
                         "                                               AND xcea001>='",l_glav004,"' AND xcea001<='",tm.edate,"'",
                         "                                     )",
                         "        )",
                         #160824-00004#4--add--end
                         "       )"
               PREPARE aglq720_sel_pr7_31 FROM l_sql
            
               #期間異動：抓取CE、XC憑證金額
               LET l_sql=l_sql_pr8_1,
                         l_glaq002,l_str4,
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
#                         "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
                         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 add
                         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
#                         "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
                         "                                               AND xcea002 ='9' AND xcea101 IS NOT NULL", #161027-00022#1 add
                         "                                               AND xcea001 BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                         "                                     )",
                         "        )",
                         #160824-00004#4--add--end
                         "       )"
               PREPARE aglq720_sel_pr8_31 FROM l_sql
            END IF
            
            #抓取金额  
            LET l_oyeard = 0  LET l_oyearc = 0
            LET l_yeard = 0   LET l_yearc = 0
            LET l_yeard2 = 0  LET l_yearc2 = 0
            LET l_yeard3 = 0  LET l_yearc3 = 0
            #是否显示年初数
            IF tm.show_y='Y' THEN
               EXECUTE aglq720_sum_pr_nch_3 INTO l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3
               IF cl_null(l_oyeard) THEN LET l_oyeard = 0 END IF
               IF cl_null(l_oyearc) THEN LET l_oyearc = 0 END IF
               IF cl_null(l_yeard) THEN LET l_yeard = 0 END IF
               IF cl_null(l_yearc) THEN LET l_yearc = 0 END IF
               IF cl_null(l_yeard2) THEN LET l_yeard2 = 0 END IF
               IF cl_null(l_yearc2) THEN LET l_yearc2 = 0 END IF
               IF cl_null(l_yeard3) THEN LET l_yeard3 = 0 END IF
               IF cl_null(l_yearc3) THEN LET l_yearc3 = 0 END IF
            END IF
             
            #期初金額
            LET l_amt1=0
            LET l_amt2=0
            LET l_amt3=0
            LET l_amt4=0
            EXECUTE aglq720_sum_pr_qch_3 INTO l_amt1,l_amt2,l_amt3,l_amt4 
#161031-00075#1 mark s---            
#            LET l_amt1=l_oqcd
#            LET l_amt2=l_qcd
#            LET l_amt3=l_qcd2
#            LET l_amt4=l_qcd3
#161031-00075#1 mark e---
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            LET l_period=tm.speriod-1 #上期
            #當整期間且傳狀態為stus=1:已過帳時，抓取匯總glar_t,否則抓取資料來源為glaq_t
            IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  EXECUTE aglq720_sel_pr6_3 USING tm.syear,l_period
                                             INTO l_amt5,l_amt6,l_amt7,l_amt8
                  IF SQLCA.sqlcode THEN
                     LET g_errparam.extend = 'aglq720_sel_pr6_3'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
                  LET l_amt1=l_amt1-l_amt5
                  LET l_amt2=l_amt2-l_amt6
                  LET l_amt3=l_amt3-l_amt7
                  LET l_amt4=l_amt4-l_amt8
               END IF
            #當為破期時，匯總該年第一天到查詢條件的起始日期tm.sdate的傳票資料
            ELSE
               #抓取年初金額
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               LET l_period=0
               EXECUTE aglq720_sel_pr1_3 USING l_glac002,tm.syear,l_period
                                          INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr1_3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1+l_amt5
               LET l_amt2=l_amt2+l_amt6
               LET l_amt3=l_amt3+l_amt7
               LET l_amt4=l_amt4+l_amt8
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt5=0 
               LET l_amt6=0 
               LET l_amt7=0 
               LET l_amt8=0
               LET l_period=tm.speriod-1 #上期 #160824-00004#4 add
               EXECUTE aglq720_sel_pr6_31 USING tm.syear,l_period
                                           INTO l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr6_31'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_amt1=l_amt1-l_amt5
               LET l_amt2=l_amt2-l_amt6
               LET l_amt3=l_amt3-l_amt7
               LET l_amt4=l_amt4-l_amt8
            END IF
            
            IF l_amt2>=0 THEN
               LET l_oqcd=l_amt1
               LET l_oqcc=0
               LET l_qcd =l_amt2
               LET l_qcc =0
               LET l_qcd2=l_amt3
               LET l_qcc2=0
               LET l_qcd3=l_amt4
               LET l_qcc3=0
            ELSE
               LET l_oqcd=0
               LET l_oqcc=-1*l_amt1
               LET l_qcd =0
               LET l_qcc =-1*l_amt2
               LET l_qcd2=0
               LET l_qcc2=-1*l_amt3
               LET l_qcd3=0
               LET l_qcc3=-1*l_amt4
            END IF 
            
            #期間異動
            LET l_oqjd = 0         LET l_oqjc = 0
            LET l_qjd  = 0         LET l_qjc  = 0
            LET l_qjd2 = 0         LET l_qjc2 = 0
            LET l_qjd3 = 0         LET l_qjc3 = 0
            EXECUTE aglq720_sum_pr_qj_3 INTO l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3
            IF cl_null(l_oqjd) THEN LET l_oqjd=0 END IF
            IF cl_null(l_oqjc) THEN LET l_oqjc=0 END IF
            IF cl_null(l_qjd)  THEN LET l_qjd=0  END IF
            IF cl_null(l_qjc)  THEN LET l_qjc=0  END IF
            IF cl_null(l_qjd2) THEN LET l_qjd2=0 END IF
            IF cl_null(l_qjc2) THEN LET l_qjc2=0 END IF
            IF cl_null(l_qjd3) THEN LET l_qjd3=0 END IF
            IF cl_null(l_qjc3) THEN LET l_qjc3=0 END IF
            
            #当整期间且不跨年查询时，當不包含YE或AD憑證時，減去YE或AD傳票金額
            IF l_flag=TRUE AND tm.syear = tm.eyear
               AND (tm.show_ye<>'Y' OR tm.show_ad<>'Y') THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr8_3 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr8_3'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr8_31 INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'aglq720_sel_pr8_31'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
               IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
               IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
               IF cl_null(l_amt7) THEN LET l_amt7=0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8=0 END IF
               LET l_oqjd=l_oqjd-l_amt1
               LET l_oqjc=l_oqjc-l_amt2
               LET l_qjd =l_qjd -l_amt3
               LET l_qjc =l_qjc -l_amt4
               LET l_qjd2=l_qjd2-l_amt5
               LET l_qjc2=l_qjc2-l_amt6
               LET l_qjd3=l_qjd3-l_amt7
               LET l_qjc3=l_qjc3-l_amt8
            END IF
            
            #期末金額=期初+期間異動
            #原幣
            LET l_amt1=(l_oqcd+l_oqjd)-(l_oqcc+l_oqjc)
            IF l_amt1>=0 THEN
               LET l_oqmd=l_amt1
               LET l_oqmc=0
            ELSE
               LET l_oqmd=0
               LET l_oqmc=l_amt1*-1
            END IF
            #本幣
            LET l_amt1=(l_qcd+l_qjd)-(l_qcc+l_qjc)
            IF l_amt1>=0 THEN
               LET l_qmd=l_amt1
               LET l_qmc=0
            ELSE
               LET l_qmd=0
               LET l_qmc=l_amt1*-1
            END IF
            #本幣二
            LET l_amt1=(l_qcd2+l_qjd2)-(l_qcc2+l_qjc2)
            IF l_amt1>=0 THEN
               LET l_qmd2=l_amt1
               LET l_qmc2=0
            ELSE
               LET l_qmd2=0
               LET l_qmc2=l_amt1*-1
            END IF
            #本幣三
            LET l_amt1=(l_qcd3+l_qjd3)-(l_qcc3+l_qjc3)
            IF l_amt1>=0 THEN
               LET l_qmd3=l_amt1
               LET l_qmc3=0
            ELSE
               LET l_qmd3=0
               LET l_qmc3=l_amt1*-1
            END IF  

            #本年累計金額
            LET l_osumd= 0         LET l_osumc= 0
            LET l_sumd = 0         LET l_sumc = 0
            LET l_sumd2= 0         LET l_sumc2= 0
            LET l_sumd3= 0         LET l_sumc3= 0
            EXECUTE aglq720_sum_pr_lj_3 INTO l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
            IF cl_null(l_osumd) THEN LET l_osumd=0 END IF
            IF cl_null(l_osumc) THEN LET l_osumc=0 END IF
            IF cl_null(l_sumd)  THEN LET l_sumd=0  END IF
            IF cl_null(l_sumc)  THEN LET l_sumc=0  END IF
            IF cl_null(l_sumd2) THEN LET l_sumd2=0 END IF
            IF cl_null(l_sumc2) THEN LET l_sumc2=0 END IF
            IF cl_null(l_sumd3) THEN LET l_sumd3=0 END IF
            IF cl_null(l_sumc3) THEN LET l_sumc3=0 END IF
            #當截止日期為該期最後一天，且傳票狀態為1：已過帳時，抓取glar_t餘額當資料,否則，直接抓取glaq_t傳票資料
            IF tm.edate=l_pdate_e2 AND tm.stus='1' THEN
               #當不包含YE或AD傳票時，減去YE或AD傳票金額
               IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN
                  LET l_amt1=0
                  LET l_amt2=0
                  LET l_amt3=0
                  LET l_amt4=0
                  LET l_amt5=0
                  LET l_amt6=0
                  LET l_amt7=0
                  LET l_amt8=0
                  EXECUTE aglq720_sel_pr7_3 USING tm.eyear,tm.eperiod
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq720_sel_pr7_3'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8
               END IF     
            END IF
            
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               LET l_amt1=0
               LET l_amt2=0
               LET l_amt3=0
               LET l_amt4=0
               LET l_amt5=0
               LET l_amt6=0
               LET l_amt7=0
               LET l_amt8=0
               EXECUTE aglq720_sel_pr7_31 USING tm.eyear,tm.eperiod
                                           INTO l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'aglq720_sel_pr7_31'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success = FALSE
                  END IF
                  IF cl_null(l_amt1)  THEN LET l_amt1=0 END IF
                  IF cl_null(l_amt2)  THEN LET l_amt2=0 END IF
                  IF cl_null(l_amt3)  THEN LET l_amt3=0 END IF
                  IF cl_null(l_amt4)  THEN LET l_amt4=0 END IF
                  IF cl_null(l_amt5)  THEN LET l_amt5=0 END IF
                  IF cl_null(l_amt6)  THEN LET l_amt6=0 END IF
                  IF cl_null(l_amt7)  THEN LET l_amt7=0 END IF
                  IF cl_null(l_amt8)  THEN LET l_amt8=0 END IF
                  LET l_osumd=l_osumd-l_amt1
                  LET l_osumc=l_osumc-l_amt2
                  LET l_sumd =l_sumd -l_amt3
                  LET l_sumc =l_sumc -l_amt4
                  LET l_sumd2=l_sumd2-l_amt5
                  LET l_sumc2=l_sumc2-l_amt6
                  LET l_sumd3=l_sumd3-l_amt7
                  LET l_sumc3=l_sumc3-l_amt8
            END IF
            
            IF l_yeard=0 AND l_yearc=0 AND  #年初數
               l_qcd=0 AND l_qcc=0 AND      #期初數
               l_qjd=0 AND l_qjc=0 AND      #期間異動
               l_qmd=0 AND l_qmc=0 AND      #期末
               l_sumd=0 AND l_sumc=0 THEN   #本年累計，以上全部等於0時該筆科目資料不顯示
               CONTINUE FOREACH
            END IF
#            INSERT INTO aglq720_tmp 
#            VALUES(g_enterprise,l_glac002,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
#                   l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
#                   l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
#                   l_glar031,l_glar032,l_glar033,l_glar009,
#                   l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
#                   l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
#                   l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
#                   l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
#                   l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3)
            EXECUTE aglq720_ins_pr2 USING
                   g_enterprise,l_glac002,l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                   l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                   l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,l_glar029,l_glar030,
                   l_glar031,l_glar032,l_glar033,l_glar009,
                   l_oyeard,l_oyearc,l_yeard,l_yearc,l_yeard2,l_yearc2,l_yeard3,l_yearc3,
                   l_oqcd,l_oqcc,l_qcd,l_qcc,l_qcd2,l_qcc2,l_qcd3,l_qcc3,
                   l_oqjd,l_oqjc,l_qjd,l_qjc,l_qjd2,l_qjc2,l_qjd3,l_qjc3,
                   l_oqmd,l_oqmc,l_qmd,l_qmc,l_qmd2,l_qmc2,l_qmd3,l_qmc3,
                   l_osumd,l_osumc,l_sumd,l_sumc,l_sumd2,l_sumc2,l_sumd3,l_sumc3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'insert'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
         END FOREACH
      END IF
   END FOREACH
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq720_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........: #160505-00007#14 add
# Usage..........: CALL aglq720_output()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/05/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq720_output()
   DEFINE l_i,l_count      LIKE type_t.num5
   DEFINE l_glaald_desc    LIKE type_t.chr500,
          l_glaacomp_desc  LIKE type_t.chr500,
          l_glaa001_desc   LIKE type_t.chr500,
          l_sdate          LIKE type_t.chr500,
          l_edate          LIKE type_t.chr500,
          l_ctype          LIKE type_t.chr500,
          l_stus           LIKE type_t.chr500,
          l_glar051        LIKE type_t.chr500
       
   DELETE FROM aglq720_tmp01          #160727-00019#3  Mod  aglq720_print_tmp -->aglq720_tmp01
   LET l_count = g_glar_d.getLength()
   
   LET l_glaald_desc = g_glaald," ",g_glaald_desc
   LET l_glaacomp_desc = g_glaacomp," ",g_glaacomp_desc
   LET l_glaa001_desc = g_glaa001," ",g_glaa016," ",g_glaa020
   LET l_sdate = tm.sdate," ",tm.syear," ",tm.speriod
   LET l_edate = tm.edate," ",tm.eyear," ",tm.eperiod
   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
   LET l_stus = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
   
   FOR l_i = 1 TO l_count
      #160804-00002#1--mod--str-- 
      #output函数中FOR循环INSERT语句中的数组下表错误给了l_ac应该是l_i
      LET l_glar051 = g_glar_d[l_i].glar051,":",s_desc_gzcbl004_desc('6013',g_glar_d[l_i].glar051)
      INSERT INTO aglq720_tmp01       #160727-00019#3  Mod  aglq720_print_tmp -->aglq720_tmp01
      VALUES(l_glaald_desc,l_glaacomp_desc,l_glaa001_desc,l_sdate,l_edate,
         l_ctype,tm.glac005,l_stus,g_glar_d[l_i].glar001,g_glar_d[l_i].glar001_desc,
         g_glar_d[l_i].glar012,g_glar_d[l_i].glar012_desc,g_glar_d[l_i].glar013,g_glar_d[l_i].glar013_desc,
         g_glar_d[l_i].glar014,g_glar_d[l_i].glar014_desc,g_glar_d[l_i].glar015,g_glar_d[l_i].glar015_desc,
         g_glar_d[l_i].glar016,g_glar_d[l_i].glar016_desc,g_glar_d[l_i].glar017,g_glar_d[l_i].glar017_desc,
         g_glar_d[l_i].glar018,g_glar_d[l_i].glar018_desc,g_glar_d[l_i].glar019,g_glar_d[l_i].glar019_desc,
         l_glar051,g_glar_d[l_i].glar052,g_glar_d[l_i].glar052_desc,
         g_glar_d[l_i].glar053,g_glar_d[l_i].glar053_desc,g_glar_d[l_i].glar020,g_glar_d[l_i].glar020_desc,
         g_glar_d[l_i].glar022,g_glar_d[l_i].glar022_desc,g_glar_d[l_i].glar023,g_glar_d[l_i].glar023_desc,
         g_glar_d[l_i].glar024,g_glar_d[l_i].glar024_desc,g_glar_d[l_i].glar025,g_glar_d[l_i].glar025_desc,
         g_glar_d[l_i].glar026,g_glar_d[l_i].glar026_desc,g_glar_d[l_i].glar027,g_glar_d[l_i].glar027_desc,
         g_glar_d[l_i].glar028,g_glar_d[l_i].glar028_desc,g_glar_d[l_i].glar029,g_glar_d[l_i].glar029_desc,
         g_glar_d[l_i].glar030,g_glar_d[l_i].glar030_desc,g_glar_d[l_i].glar031,g_glar_d[l_i].glar031_desc,
         g_glar_d[l_i].glar032,g_glar_d[l_i].glar032_desc,g_glar_d[l_i].glar033,g_glar_d[l_i].glar033_desc,
         g_glar_d[l_i].glar009, 
         g_glar_d[l_i].oyeard,g_glar_d[l_i].oyearc,g_glar_d[l_i].yeard,g_glar_d[l_i].yearc,g_glar_d[l_i].yeard2, 
         g_glar_d[l_i].yearc2,g_glar_d[l_i].yeard3,g_glar_d[l_i].yearc3,g_glar_d[l_i].oqcd,g_glar_d[l_i].oqcc, 
         g_glar_d[l_i].qcd,g_glar_d[l_i].qcc,g_glar_d[l_i].qcd2,g_glar_d[l_i].qcc2,g_glar_d[l_i].qcd3, 
         g_glar_d[l_i].qcc3,g_glar_d[l_i].oqjd,g_glar_d[l_i].oqjc,g_glar_d[l_i].qjd,g_glar_d[l_i].qjc, 
         g_glar_d[l_i].qjd2,g_glar_d[l_i].qjc2,g_glar_d[l_i].qjd3,g_glar_d[l_i].qjc3,g_glar_d[l_i].oqmd, 
         g_glar_d[l_i].oqmc,g_glar_d[l_i].qmd,g_glar_d[l_i].qmc,g_glar_d[l_i].qmd2,g_glar_d[l_i].qmc2, 
         g_glar_d[l_i].qmd3,g_glar_d[l_i].qmc3,g_glar_d[l_i].osumd,g_glar_d[l_i].osumc,g_glar_d[l_i].sumd, 
         g_glar_d[l_i].sumc,g_glar_d[l_i].sumd2,g_glar_d[l_i].sumc2,g_glar_d[l_i].sumd3,g_glar_d[l_i].sumc3)
         
   END FOR
   CALL aglq720_xg_visible()
   CALL aglq720_x01(' 1=1','aglq720_tmp01',g_xg_visible)              #160727-00019#3  Mod  aglq720_print_tmp -->aglq720_tmp01
END FUNCTION

 
{</section>}
 

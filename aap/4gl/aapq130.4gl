#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq130.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:28(2017-01-06 09:59:13), PR版次:0028(2017-02-18 15:25:28)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000140
#+ Filename...: aapq130
#+ Description: 入庫未立帳查詢作業
#+ Creator....: 03538(2014-11-27 14:10:36)
#+ Modifier...: 03080 -SD/PR- 08729
 
{</section>}
 
{<section id="aapq130.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#141218-00011#11  2015/1/5    By albireo  1.依需求寫成aapq130/aapq140共用程式及對原程式ㄧ些微調/aapq130財務人員看立帳數量,aapq140看發票數量前端採購人員看的
#                                         2.補掃把qbe_clear
#                                         3.入庫單開窗與主FOREACH SQL除了原有的依單頭帳務中心下所屬法人以外,加上單頭法人限制條件,避免出現單頭選擇正確但內容跑不出來的狀況;
#                                         拿掉FOREACH中帳別限制條件,因單頭帳套可為帳務中心底下法人的任一帳套,不一定是主帳套
#150106-00011#2   20150105    By albireo  增加pmds001入庫扣帳日的單身欄位且要能二次查詢
#150123-00003#2   20150128    By albireo  1.增加數量:立帳數量,暫估數量,差異數量;金額
#                                         2.可勾選是否顯示依入庫單小計
#150127-00007#1   20150202    By Reanna   掃把清空&給預設值&拿掉sel&帳務中心、帳套設定成大寫
#150210-00009#3   20150210    By Reanna   若無資料則顯示"無符合的資料"
#150401-00010#1   20150421    By Belle    調整暫估數量取得(暫估數量改抓已沖暫估單的apcb007)
#150629-00038#1   20150630    By albireo  增加入庫單性質'20'委外採購入庫單;借貨相關性質
#150702-00001#1   20150703    By albireo  入庫單性質改用動態抓取
#150902-00001#3   20150904    By apo      增加採購單號/項次/發票號碼
#150924-00012#1   20151001    By Jessy    增加一欄應收帳款單號在單身的最後一欄位,XG報表輸出亦須增加列印
#151019-00009#1   20151021    By Jessy    增加暫估單號顯示,XG報表輸出亦須增加列印
#151102-00008#1   20151103    By Jessy    1.增加子件特性欄位,XG報表輸出亦須增加列印 2.單頭增加條件: 己立暫估未立帳款 3.aapq130:取帳款單號沒有排除作廢單, 增加成本分群,增加費用科目apcb021顯示,取單身原則:AND apcastus<>'X' AND apcb023<>'Y'
#151201           20151201    By 03538    因應pmds000之命名為l_pmds000,為可以二次篩選調整程式
#151231-00010#4   2016/01/11  By 02097    增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite 
#160414-00018#4   2016/05/03  By 03538    效能改善
#160705-00042#8   2016/07/12  By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160518-00075#16  2016/08/03  By Hans     使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160802-00036#2   2016/08/05  By Reanna   調整暫估計算
#160830-00008#1   2016/09/07  By 00768    不该出现采购性质为3的入库单(VMI采购入库单不应该立账)
#160909-00015#1   2016/09/18  By 01727    以查詢出來的未沖暫估數量 * 暫估單價 取暫估單上之稅別推算出上述三個金額
#161018-00037#1   2016/10/18  By Reanna   調整若無暫估時取數量會有問題的bug
#161011-00015#1   2016/10/19  By Reanna   修正160830-00008的bug，不该出现采购性质为3的入库单(VMI采购入库单不应该立账)修改SQL位置不對
#161006-00005#19  2016/10/24  By 08732    組織類型與職能開窗調整
#161014-00053#4   2016/10/24  By 08171    帳套權限調整
#161114-00017#1   2016/11/14  By Reanna   開窗權限調整
#161205-00025#18  161215      By albireo  列印效能調整
#161206-00017#2   170105      By albireo  增加欄位 立帳匯率,計價數量
#161229-00047#24  170109      By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170118-00052#1   170123      By 06694    aapq130_x02 新增六個欄位。
#170123-00045#1   170125      By 06821    SQL中撈取資料時使用 rownum 語法撰寫方式調整
#170203-00032#1   2017/02/07  By 06694    aapq140,l_field[4].f21給予pmdt066 
#170209-00025#1   2017/02/17  By 08729    處理總筆數一直為0問題
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
GLOBALS "../../cfg/top_report.inc"   #160802-00036#2
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_pmds_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdtsite LIKE pmdt_t.pmdtsite, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr500, 
   pmds001 LIKE pmds_t.pmds001, 
   l_pmds000 LIKE type_t.chr10, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   pmdt006_desc LIKE type_t.chr500, 
   pmdt006_desc_1 LIKE type_t.chr500, 
   pmdt005 LIKE pmdt_t.pmdt005, 
   imag011 LIKE imag_t.imag011, 
   imag011_desc LIKE type_t.chr500, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb021_desc LIKE type_t.chr500, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt050 LIKE pmdt_t.pmdt050, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds002_desc LIKE type_t.chr500, 
   pmds003 LIKE pmds_t.pmds003, 
   pmds003_desc LIKE type_t.chr500, 
   pmdt016 LIKE pmdt_t.pmdt016, 
   pmdt016_desc LIKE type_t.chr500, 
   pmdt020 LIKE pmdt_t.pmdt020, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   apcb007 LIKE apcb_t.apcb007, 
   pmdt056 LIKE pmdt_t.pmdt056, 
   pmdt066 LIKE pmdt_t.pmdt066, 
   pmdt069 LIKE pmdt_t.pmdt069, 
   l_diffqty LIKE type_t.num20_6, 
   pmds037 LIKE pmds_t.pmds037, 
   pmds038 LIKE pmds_t.pmds038, 
   pmdt046 LIKE pmdt_t.pmdt046, 
   pmdt037 LIKE pmdt_t.pmdt037, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   l_pmdt0383 LIKE type_t.num20_6, 
   l_pmdt0473 LIKE type_t.num20_6, 
   l_pmdt0393 LIKE type_t.num20_6, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   l_pmdt047 LIKE type_t.num20_6, 
   pmdt039 LIKE pmdt_t.pmdt039, 
   l_sumapcb103 LIKE type_t.num20_6, 
   l_sumapcb104 LIKE type_t.num20_6, 
   l_sumapcb105 LIKE type_t.num20_6, 
   l_sfapcb103 LIKE type_t.num20_6, 
   l_sfapcb104 LIKE type_t.num20_6, 
   l_sfapcb105 LIKE type_t.num20_6, 
   l_apca101 LIKE type_t.num26_10, 
   l_apcb113 LIKE type_t.num20_6, 
   l_apcb114 LIKE type_t.num20_6, 
   l_apcb115 LIKE type_t.num20_6, 
   l_dapcb103 LIKE type_t.num20_6, 
   l_dapcb104 LIKE type_t.num20_6, 
   l_dapcb105 LIKE type_t.num20_6, 
   l_pmdt0382 LIKE type_t.num20_6, 
   l_pmdt0472 LIKE type_t.num20_6, 
   l_pmdt0392 LIKE type_t.num20_6, 
   apcadocno LIKE apca_t.apcadocno, 
   apca2 LIKE type_t.chr20
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_master RECORD
        apcasite            LIKE apca_t.apcasite,
        apcasite_desc       LIKE type_t.chr80,
        apcald              LIKE apca_t.apcald,
        apcald_desc         LIKE type_t.chr80,
        l_apcacomp          STRING,
        type                LIKE type_t.chr1,
        type1               LIKE type_t.chr1,  #160802-00036#2
        wc                  STRING,
        wc2                 STRING,
        sumshow             LIKE type_t.chr1   #150123-00003#2  150128 By albireo 
       END RECORD
DEFINE g_apcacomp           LIKE apca_t.apcacomp

DEFINE g_input              type_master
DEFINE g_input_o            type_master        #albireo 150107 141218-00011#11 新舊值使用

DEFINE g_wc_apcasite        STRING
DEFINE g_wc_apcald          STRING
DEFINE g_output_wc          STRING
DEFINE g_aapq130_arg        LIKE type_t.chr1   #1:aapq130   #2:aapq140   #albireo 150105 141218-00011#11 
DEFINE g_ask                LIKE type_t.chr1   #150210-00009#3
DEFINE g_sql_ctrl          STRING      #151231-00010#4
DEFINE g_user_dept_wc      STRING      #160518-00075#16
DEFINE g_user_dept_wc_q    STRING      #160518-00075#16
DEFINE g_site_str          STRING      #161014-00053#4
DEFINE g_wc_cs_comp        STRING      #161229-00047#24 add
DEFINE g_comp_str          STRING      #161229-00047#24 add 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmds_d            DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t          type_g_pmds_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="aapq130.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_sql   STRING   #160414-00018#4
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   CALL aapq130_create_tmp()
   #151231-00010#4--(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161114-00017#1 mark
   #160414-00018#4--s
   #161114-00017#1 add ------
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#24 mark
   #161114-00017#1 add end---
   LET l_sql = "SELECT gzcb004 FROM gzcb_t ",
               " WHERE gzcb001 = '2060' ",
               "   AND gzcb002 = ? " 
   PREPARE pmds000_chk_pre FROM l_sql   
   
   LET l_sql = "INSERT INTO aapq130_tmp VALUES( ",
               " ?,?,?,?,?, ?,?,?,?,?,",
               " ?,?,?,?,?, ?,?,?,?,?,",
               " ?,?,?,?,?, ?,?,?,?,?,",
               " ?,?,?,?,?, ?,?,?,?,?,",
               " ?,?,?,?,?, ?,?,?,?,?,",
               " ?,?,?,?,?, ?,?,?,?,? ",
               " ,?,? ",     #161206-00017#2
               ") " 
   PREPARE aapq130_ins_tmp FROM l_sql      
   
   LET l_sql = "SELECT SUM(pmdt024),SUM(apcb007),SUM(pmdt066),SUM(pmdt069),SUM(pmdt038), ",
               "       SUM(l_pmdt047),SUM(pmdt039),SUM(l_pmdt0382),SUM(l_pmdt0472),SUM(l_pmdt0392), ",
               "       SUM(pmdt0562),SUM(l_pmdt0383),SUM(l_pmdt0473),SUM(l_pmdt0393), ",
               "       SUM(sumapcb103),SUM(sumapcb104),SUM(sumapcb105), ",                  
               "       SUM(sfapcb103),SUM(sfapcb104),SUM(sfapcb105), ",                     
               "       SUM(apcb113),SUM(apcb114),SUM(apcb115), ",                           
               "       SUM(dapcb103),SUM(dapcb104),SUM(dapcb105) ",                         
               "      FROM aapq130_tmp ",
               "     WHERE pmdtdocno = ? "
   PREPARE aapq130_sel_tmp FROM l_sql      
   
   LET l_sql = "SELECT pmds006 FROM pmds_t ",
               " WHERE pmdsent = '",g_enterprise,"' ",
               "   AND pmdsdocno ? "
   PREPARE aapq130_sel_pmds006 FROM l_sql
   
   LET l_sql = "SELECT pmdw010 FROM pmdw_t ",
               " WHERE pmdwent = '",g_enterprise,"' ",
               "   AND pmdwdocno = ? "   
   PREPARE aapq130_sel_pmdw010 FROM l_sql               
   #160414-00018#4--e   
   #151231-00010#4--(E)
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
   DECLARE aapq130_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq130_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq130_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq130 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq130_init()   
 
      #進入選單 Menu (="N")
      CALL aapq130_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq130
      
   END IF 
   
   CLOSE aapq130_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq130.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapq130_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_title      LIKE gzzd_t.gzzd005   #160802-00036#2
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_pmdt005','2055') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('l_pmds000','2060')   #151106-00002#4 151119 by sakura add
   CALL cl_set_combo_scc('pmds011','2052')
   #建立撈取帳務中心所屬範圍需使用的暫存檔
   CALL s_fin_create_account_center_tmp() 
   #161229-00047#24 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#24 --e add  

   CALL aapq130_qbe_clear()  #150127-00007#1
      
   #LET g_input.type = '1'
   #
   ##取預設帳務中心
   #CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_input.apcasite,g_input.apcald,g_input.l_apcacomp
   #CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
   ##取得帳務中心底下之組織範圍
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   #CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   ##取得帳務中心底下的帳套範圍   
   #CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   #CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   #
   #LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
   #LET g_input.apcasite_desc= s_desc_get_department_desc(g_input.apcasite)
   #LET g_apcacomp = g_input.l_apcacomp
   #LET g_input.l_apcacomp = s_desc_show1(g_input.l_apcacomp,s_desc_get_department_desc(g_input.l_apcacomp))
   #LET g_input_o.* = g_input.*    #albireo 150105 141218-00011#11    
   #DISPLAY BY NAME g_input.apcald  ,g_input.apcald_desc,
   #                g_input.apcasite,g_input.apcasite_desc,
   #                g_input.l_apcacomp
   #
   #albireo 150105 141218-00011#11 -----s
   #aapq130 aapq140 共用程式 所以用此參數分辨
   #
   #CALL cl_set_comp_visible('apcald,apcald_desc,b_pmdt066,l_apcacomp,b_pmdt056,b_pmdt066',TRUE)             #160802-00036#2 mark
   CALL cl_set_comp_visible('apcald,apcald_desc,b_pmdt066,lbl_apcacomp,l_apcacomp,b_pmdt056,b_pmdt066',TRUE) #160802-00036#2
   CALL cl_set_comp_visible('l_sfapcb103,l_sfapcb104,l_sfapcb105,l_apcb113,l_apcb114,l_apcb115',TRUE)
   LET g_aapq130_arg = g_argv[01]
   IF g_aapq130_arg = '2' THEN
      #CALL cl_set_comp_visible('apcald,apcald_desc,b_pmdt066,l_apcacomp,b_pmdt056,b_pmdt066',FALSE)             #160802-00036#2 mark
      CALL cl_set_comp_visible('apcald,apcald_desc,b_pmdt066,lbl_apcacomp,l_apcacomp,b_pmdt056,b_pmdt066',FALSE) #160802-00036#2
      CALL cl_set_comp_visible('l_sfapcb103,l_sfapcb104,l_sfapcb105,l_apcb113,l_apcb114,l_apcb115',FALSE)
   END IF
   #albireo 150105 141218-00011#11 -----e
   
   #160802-00036#2-s
   IF g_aapq130_arg = '1' THEN
      #axrq130
      CALL cl_set_comp_visible('grid_qbe',TRUE)
      CALL cl_set_comp_visible('grid_1',FALSE)
      #未匹配數量(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_apcb007'
      CALL cl_set_comp_att_text('b_apcb007',l_title)
      LET g_xg_fieldname[26] = l_title
      #未匹配未稅金額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt038'
      CALL cl_set_comp_att_text('b_pmdt038',l_title)
      LET g_xg_fieldname[39] = l_title
      #未匹配稅額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt047'
      CALL cl_set_comp_att_text('l_pmdt047',l_title)
      LET g_xg_fieldname[40] = l_title    
      #未匹配含稅金額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt039'
      CALL cl_set_comp_att_text('b_pmdt039',l_title)
      LET g_xg_fieldname[41] = l_title
      #未匹配本幣未稅金額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0382'
      CALL cl_set_comp_att_text('l_pmdt0382',l_title)
      LET g_xg_fieldname[54] = l_title
      #未匹配本幣稅額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0472'
      CALL cl_set_comp_att_text('l_pmdt0472',l_title)
      LET g_xg_fieldname[55] = l_title
      #未匹配本幣含稅金額(立帳)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0392'
      CALL cl_set_comp_att_text('l_pmdt0392',l_title)
      LET g_xg_fieldname[56] = l_title
   ELSE
      #axrq140
      CALL cl_set_comp_visible('grid_qbe',FALSE)
      CALL cl_set_comp_visible('grid_1',TRUE)
      #未匹配數量(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_apcb007'
      CALL cl_set_comp_att_text('b_apcb007',l_title)
      LET g_xg_fieldname[26] = l_title
      #未匹配未稅金額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt038'
      CALL cl_set_comp_att_text('b_pmdt038',l_title)
      LET g_xg_fieldname[39] = l_title
      #未匹配稅額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt047'
      CALL cl_set_comp_att_text('l_pmdt047',l_title)
      LET g_xg_fieldname[40] = l_title    
      #未匹配含稅金額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt039'
      CALL cl_set_comp_att_text('b_pmdt039',l_title)
      LET g_xg_fieldname[41] = l_title
      #未匹配本幣未稅金額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0382'
      CALL cl_set_comp_att_text('l_pmdt0382',l_title)
      LET g_xg_fieldname[54] = l_title
      #未匹配本幣稅額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0472'
      CALL cl_set_comp_att_text('l_pmdt0472',l_title)
      LET g_xg_fieldname[55] = l_title
      #未匹配本幣含稅金額(立帳)
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'aapq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_pmdt0392'
      CALL cl_set_comp_att_text('l_pmdt0392',l_title)
      LET g_xg_fieldname[56] = l_title
   END IF
   #160802-00036#2-d
   
   #160518-00075#16--s
   LET g_user_dept_wc = '' 
   CALL s_fin_get_user_dept_control('pmdssite','','pmdsent','pmdsdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #160518-00075#16--e 

   #end add-point
 
   CALL aapq130_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aapq130.default_search" >}
PRIVATE FUNCTION aapq130_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " pmdsdocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq130_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_str            STRING
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_date           LIKE glav_t.glav004
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   
   DEFINE l_pmds000_str1    STRING   #150702-00001#1 add
   DEFINE l_comp_wc         STRING  #161014-00053#4 add
   #161205-00025#18-----s
   DEFINE l_i              LIKE type_t.num10
   DEFINE l_x02_tmp        RECORD
      pmdtsite         LIKE pmdt_t.pmdtsite,
      pmds007          LIKE pmds_t.pmds007,
      l_pmds007_desc   LIKE type_t.chr100,
      pmds001          LIKE pmds_t.pmds001,
      l_pmds000        LIKE type_t.chr100,
      pmdtdocno        LIKE pmdt_t.pmdtdocno,
      pmdtseq          LIKE pmdt_t.pmdtseq,
      pmdt006          LIKE pmdt_t.pmdt006,
      l_pmdt006_desc   LIKE type_t.chr100,
      l_pmdt006_desc_1 LIKE type_t.chr100,
      l_pmdt005_desc   LIKE type_t.chr100,
      l_imag011        LIKE imag_t.imag011,
      l_imag011_desc   LIKE type_t.chr100,
      l_apcb021        LIKE apcb_t.apcb021,
      l_apcb021_desc   LIKE type_t.chr100,
      pmdt001          LIKE pmdt_t.pmdt001,
      pmdt002          LIKE pmdt_t.pmdt002,
      pmdt050          LIKE pmdt_t.pmdt050,
      pmds002          LIKE pmds_t.pmds002,
      l_pmds022_desc   LIKE type_t.chr100,
      pmds003          LIKE pmds_t.pmds002,
      l_pmds003_desc   LIKE type_t.chr100,
      pmdt016          LIKE pmdt_t.pmdt016,
      l_pmdt016_desc   LIKE type_t.chr100,
      pmdt024          LIKE pmdt_t.pmdt024,
      l_apcb007        LIKE apcb_t.apcb007,
      pmdt056          LIKE pmdt_t.pmdt056,
      pmdt066          LIKE pmdt_t.pmdt066,
      pmdt069          LIKE pmdt_t.pmdt069,
      l_diffqty        LIKE type_t.num20_6,
      pmds037          LIKE pmds_t.pmds037,
      pmds038          LIKE pmds_t.pmds038,
      pmdt046          LIKE pmdt_t.pmdt046,
      pmdt037          LIKE pmdt_t.pmdt037,
      pmdt036          LIKE pmdt_t.pmdt036,
      #170118-00052#1----(s)----
      pmdt038          LIKE pmdt_t.pmdt038, 
      l_pmdt047        LIKE type_t.num20_6,
      pmdt039          LIKE pmdt_t.pmdt039, 
      l_sumapcb103     LIKE type_t.num20_6, 
      l_sumapcb104     LIKE type_t.num20_6, 
      l_sumapcb105     LIKE type_t.num20_6,
      #170118-00052#1----(e)----      
      l_pmdt038_3      LIKE pmdt_t.pmdt038,
      l_pmdt047_3      LIKE pmdt_t.pmdt047,
      l_pmdt039_3      LIKE pmdt_t.pmdt039,
      l_sfapcb103      LIKE apcb_t.apcb103,
      l_sfapcb104      LIKE apcb_t.apcb104,
      l_sfapcb105      LIKE apcb_t.apcb105,
      l_apcb113        LIKE apcb_t.apcb113,
      l_apcb114        LIKE apcb_t.apcb114,
      l_apcb115        LIKE apcb_t.apcb115,
      l_dapcb103       LIKE apcb_t.apcb103,
      l_dapcb104       LIKE apcb_t.apcb104,
      l_dapcb105       LIKE apcb_t.apcb105,
      l_pmdt0382       LIKE pmdt_t.pmdt038,
      l_pmdt0472       LIKE pmdt_t.pmdt047,
      l_pmdt0392       LIKE pmdt_t.pmdt039,
      l_apcadocno      LIKE apca_t.apcadocno,
      l_apca2          LIKE apca_t.apcadocno
                           END RECORD
   #161205-00025#18-----e
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"(gzcb003 = 'Y' OR gzcb005 = '2')")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
   #150702-00001#1-----e
   #第一次開啟程式不顯示無資料的提示 #150210-00009#3
   LET g_ask = "N"
   
   #end add-point
 
   
   CALL aapq130_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmds_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aapq130_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
        #INPUT BY NAME g_input.apcasite,g_input.apcald,g_input.type,g_input.sumshow  #150123-00003#2 150128 By albireo #160802-00036#2 mark
         INPUT BY NAME g_input.apcasite,g_input.apcald,g_input.type,g_input.type1,g_input.sumshow  #160802-00036#2
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_wc = " 1=1 "
            

            AFTER FIELD apcasite
               #帳務中心
               #albireo 150106 141218-00011#11 MODIFY -----s
               #修改新增舊值的操作
               #操作模式變更成 帳務中心輸入且有變更後強制預帶出所屬主帳套及法人
               #詢問carol原因為:
               #操作者為作帳者的角度來看,先輸入作帳者是誰,再以作帳者當作出發點去選取帳務中心底下法人的帳套
               #因此不管如何都先重作預設
               IF NOT cl_null(g_input.apcasite) THEN
                  IF (g_input.apcasite != g_input_o.apcasite OR g_input_o.apcasite IS NULL) THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.apcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.apcasite = ''
                        LET g_input.apcasite_desc = ''
                        LET g_input.apcald = ''
                        LET g_input.apcald_desc = ''
                        LET g_input.l_apcacomp = ''
                        LET g_apcacomp = ''
                        LET g_wc_apcasite = ''
                        LET g_wc_apcald   = ''
                        DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc,g_input.apcald,g_input.apcald_desc,
                                        g_input.l_apcacomp
                        NEXT FIELD CURRENT
                     END IF
                     
                     #帳務中心預設主帳套及主帳套所屬法人及其他預設值
                     CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,g_input.l_apcacomp,g_input.apcald
                     LET g_apcacomp = g_input.l_apcacomp
                     LET g_input.l_apcacomp = s_desc_show1(g_input.l_apcacomp,s_desc_get_department_desc(g_input.l_apcacomp))
                     DISPLAY BY NAME g_input.l_apcacomp
                     CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str  #161229-00047#24 add 
                     CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#24 add 
                     #161114-00017#1 add ------ 
                     #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#24 mark
                     #161114-00017#1 add end---
                     
                     CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
                     #取得帳務中心底下之組織範圍
                     CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
                     CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
                     #取得帳務中心底下的帳套範圍
                     CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
                     CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
                     LET g_input.apcasite_desc= s_desc_get_department_desc(g_input.apcasite)
                     LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
                     DISPLAY BY NAME g_input.apcasite_desc,g_input.apcald,g_input.apcald_desc
                  END IF
               ELSE
                  LET g_input.apcasite_desc = ''
                  LET g_input.apcald = ''
                  LET g_input.apcald_desc = ''
                  LET g_input.l_apcacomp = ''
                  LET g_apcacomp = ''
                  LET g_wc_apcasite = ''
                  LET g_wc_apcald   = ''
                  DISPLAY BY NAME g_input.apcasite_desc,g_input.apcald,g_input.apcald_desc,
                                  g_input.l_apcacomp
               END IF
               LET g_input_o.apcasite = g_input.apcasite
               #161014-00053#4 --s add
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')  #依據正確的資料再重展一次結構
               #取得帳務中心底下的帳套範圍 
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               #161014-00053#4 --e add
#              LET g_input.apcasite_desc = ''
#              IF NOT cl_null(g_input.apcasite) THEN    
#                 CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
#                 IF NOT g_sub_success THEN
#                    #取得法人            
#                    CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,g_input.l_apcacomp,g_input.apcald
#                    LET g_apcacomp = g_input.l_apcacomp
#                    LET g_input.l_apcacomp = s_desc_show1(g_input.l_apcacomp,s_desc_get_department_desc(g_input.l_apcacomp))
#                    DISPLAY BY NAME g_input.l_apcacomp
#                 END IF
#              
#                 CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
#                 #取得帳務中心底下之組織範圍
#                 CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
#                 CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
#                 #取得帳務中心底下的帳套範圍               
#                 CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
#                 CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald      
#                                
#                 CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
#                 IF NOT g_sub_success THEN
#                    INITIALIZE g_errparam TO NULL
#                    LET g_errparam.code = g_errno
#                    LET g_errparam.extend = ''
#                    LET g_errparam.popup = TRUE
#                    CALL cl_err()
#                    LET g_input.apcasite = ''
#                    NEXT FIELD CURRENT
#                 END IF
#                 LET g_input.apcasite_desc= s_desc_get_department_desc(g_input.apcasite)
#                 LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
#                 DISPLAY BY NAME g_input.apcasite_desc,g_input.apcald,g_input.apcald_desc
#              END IF 
               #albireo 150106 141218-00011#11 MODIFY -----e
   
            AFTER FIELD apcald
               
               #add-point:AFTER FIELD apcald
               #帳套
               LET g_input.apcald_desc = ''
               IF NOT cl_null(g_input.apcald) THEN
                 #CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N',g_wc_apcald,g_today) #161014-00053#4 mark
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','Y',g_wc_apcald,g_today) #161014-00053#4 add
                     RETURNING g_sub_success,g_errno 
                     IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcald = ''
                     LET g_input.apcald_desc = ''
                     LET g_input.l_apcacomp = ''                                              #albireo 150106 141218-00011#11
                     DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.l_apcacomp    #albireo 150106 141218-00011#11
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_ld_carry(g_input.apcald,'') RETURNING g_sub_success,g_input.apcald,g_input.l_apcacomp,g_errno
               LET g_apcacomp = g_input.l_apcacomp
               LET g_input.l_apcacomp = s_desc_show1(g_input.l_apcacomp,s_desc_get_department_desc(g_input.l_apcacomp))
               LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
               DISPLAY BY NAME g_input.l_apcacomp,g_input.apcald_desc
               CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str  #161229-00047#24 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#24 add 
               #161114-00017#1 add ------
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#24 mark
               #161114-00017#1 add end---
               
            #160802-00036#2 -s
            ON CHANGE type1
               LET g_input.type = g_input.type1
            #160802-00036#2 -e
            
            ON ACTION controlp INFIELD apcasite
               #帳務中心
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcasite
               #CALL q_ooef001()     #161006-00005#19   mark
               CALL q_ooef001_46()   #161006-00005#19   add 
               LET g_input.apcasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
               DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc 
               NEXT FIELD apcasite
            
            ON ACTION controlp INFIELD apcald
               #帳套
               #161014-00053#4 --s add
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
               #將取回的字串轉換為SQL條件
               CALL aapq130_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
               #161014-00053#4 --e add
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcald
              #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald     #161014-00053#4 mark
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161014-00053#4 add
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()
               LET g_input.apcald = g_qryparam.return1
               LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc
               NEXT FIELD apcald
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_input.wc ON pmds007,pmds001,pmdtdocno,pmdt001,pmds011

         ON ACTION controlp INFIELD pmds007
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_input.apcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO pmds007
            NEXT FIELD pmds007
            
            
         ON ACTION controlp INFIELD pmdtdocno
            #albireo 150106 141218-00011#11 -----s
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = 
                                   #"pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','22','24','25','26','20') ", #150702-00001#1 mark  #150629-00038#1 add '2*'   #pmds000:SCC-2060排除收貨單
                                   " pmds000 IN ",l_pmds000_str1 CLIPPED,    #150702-00001#1 add
                                   " AND pmdssite IN ",g_wc_apcasite," ",
                                   " AND pmdsstus = 'S' ",
                                   " AND EXISTS( SELECT 1 FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno AND pmdt084 = 'Y') "
            #aapq130必須依顯示的法人去做限制,aapq140不用
            IF g_aapq130_arg = '1' THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND EXISTS( SELECT 1 FROM ooef_t WHERE ooefent = pmdsent AND ooef001 = pmdssite AND ooef017 = '",g_apcacomp,"') " 
            END IF
            #151231-00010#4--(S)
            LET g_qryparam.where = g_qryparam.where, " AND  pmds008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                                     " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_input.apcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where  ," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            #160518-00075#16--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF
            #160518-00075#16--e
            CALL q_pmdsdocno_6()
            DISPLAY g_qryparam.return1 TO pmdtdocno
            NEXT FIELD pmdtdocno
            #albireo 150106 141218-00011#11 -----e
            

         ON ACTION controlp INFIELD pmdt001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmdl004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_input.apcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmdl004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmdldocno()
            DISPLAY g_qryparam.return1 TO pmdt001
            NEXT FIELD pmdt001
         
         
         END CONSTRUCT
         
         
         CONSTRUCT BY NAME g_input.wc2 ON pmdl002
	         
	         ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmdl002
               NEXT FIELD pmdl002
            
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmds_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aapq130_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq130_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq130_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #150127-00007#1
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            IF NOT cl_null(g_input.apcald) THEN
               CALL s_ld_sel_glaa(g_input.apcald,'glaa003')
                    RETURNING g_sub_success,l_glaa003
               
               CALL s_get_accdate(l_glaa003,g_today,'','')
                        RETURNING g_sub_success,g_errno,l_num,
                                  l_num,l_date,l_date,
                                  l_num,l_pdate_s,l_pdate_e,
                                  l_num,l_date,l_date
               LET l_str = l_pdate_s,":",l_pdate_e
               DISPLAY l_str TO pmds001    #顯示到畫面上
               LET g_input.wc = " pmds001 between TO_DATE('",l_pdate_s," 00:00:00','YYYY-MM-DD HH24:MI:SS') and TO_DATE('",l_pdate_e,"','YYYY-MM-DD HH24:MI:SS')"
            END IF
            #end add-point
            NEXT FIELD apcasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
 
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
 
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL aapq130_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmds_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aapq130_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL aapq130_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq130_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq130_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq130_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmds_d.getLength()
               LET g_pmds_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
 
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmds_d.getLength()
               LET g_pmds_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmds_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmds_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmds_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmds_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapq130_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #150106-00011#2  150105 By albireo 二次查詢後sel會跑出來應該是樣版BUG
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL aapr130_x01(g_output_wc,g_input.apcald,g_apcacomp,g_input.type,g_aapq130_arg)   #161205-00025#18 mark
               #161205-00025#18-----s
               DELETE FROM aapq130_x02_tmp
               FOR l_i = 1 TO g_pmds_d.getLength()
                  INITIALIZE l_x02_tmp.* TO NULL
                  LET l_x02_tmp.pmdtsite         = g_pmds_d[l_i].pmdtsite       
                  LET l_x02_tmp.pmds007          = g_pmds_d[l_i].pmds007
                  LET l_x02_tmp.l_pmds007_desc   = g_pmds_d[l_i].pmds007_desc
                  LET l_x02_tmp.pmds001          = g_pmds_d[l_i].pmds001
                  LET l_x02_tmp.l_pmds000        = g_pmds_d[l_i].l_pmds000
                  LET l_x02_tmp.pmdtdocno        = g_pmds_d[l_i].pmdtdocno
                  LET l_x02_tmp.pmdtseq          = g_pmds_d[l_i].pmdtseq
                  LET l_x02_tmp.pmdt006          = g_pmds_d[l_i].pmdt006
                  LET l_x02_tmp.l_pmdt006_desc   = g_pmds_d[l_i].pmdt006_desc
                  LET l_x02_tmp.l_pmdt006_desc_1 = g_pmds_d[l_i].pmdt006_desc_1
                  LET l_x02_tmp.l_pmdt005_desc   = g_pmds_d[l_i].pmdt005
                  LET l_x02_tmp.l_imag011        = g_pmds_d[l_i].imag011       
                  LET l_x02_tmp.l_imag011_desc   = g_pmds_d[l_i].imag011_desc  
                  LET l_x02_tmp.l_apcb021        = g_pmds_d[l_i].apcb021       
                  LET l_x02_tmp.l_apcb021_desc   = g_pmds_d[l_i].apcb021_desc  
                  LET l_x02_tmp.pmdt001          = g_pmds_d[l_i].pmdt001         
                  LET l_x02_tmp.pmdt002          = g_pmds_d[l_i].pmdt002         
                  LET l_x02_tmp.pmdt050          = g_pmds_d[l_i].pmdt050         
                  LET l_x02_tmp.pmds002          = g_pmds_d[l_i].pmds002         
                  LET l_x02_tmp.l_pmds022_desc   = g_pmds_d[l_i].pmds002_desc  
                  LET l_x02_tmp.pmds003          = g_pmds_d[l_i].pmds003         
                  LET l_x02_tmp.l_pmds003_desc   = g_pmds_d[l_i].pmds003_desc  
                  LET l_x02_tmp.pmdt016          = g_pmds_d[l_i].pmdt016         
                  LET l_x02_tmp.l_pmdt016_desc   = g_pmds_d[l_i].pmdt016_desc  
                  LET l_x02_tmp.pmdt024          = g_pmds_d[l_i].pmdt024         
                  LET l_x02_tmp.l_apcb007        = g_pmds_d[l_i].apcb007       
                  LET l_x02_tmp.pmdt056          = g_pmds_d[l_i].pmdt056         
                  LET l_x02_tmp.pmdt066          = g_pmds_d[l_i].pmdt066         
                  LET l_x02_tmp.pmdt069          = g_pmds_d[l_i].pmdt069         
                  LET l_x02_tmp.l_diffqty        = g_pmds_d[l_i].l_diffqty       
                  LET l_x02_tmp.pmds037          = g_pmds_d[l_i].pmds037         
                  LET l_x02_tmp.pmds038          = g_pmds_d[l_i].pmds038         
                  LET l_x02_tmp.pmdt046          = g_pmds_d[l_i].pmdt046         
                  LET l_x02_tmp.pmdt037          = g_pmds_d[l_i].pmdt037         
                  LET l_x02_tmp.pmdt036          = g_pmds_d[l_i].pmdt036         
                  LET l_x02_tmp.l_pmdt038_3      = g_pmds_d[l_i].l_pmdt0383     
                  LET l_x02_tmp.l_pmdt047_3      = g_pmds_d[l_i].l_pmdt0473     
                  LET l_x02_tmp.l_pmdt039_3      = g_pmds_d[l_i].l_pmdt0393  
                  #170118-00052#1----(s)----
                  LET l_x02_tmp.pmdt038          = g_pmds_d[l_i].pmdt038
                  LET l_x02_tmp.l_pmdt047        = g_pmds_d[l_i].l_pmdt047
                  LET l_x02_tmp.pmdt039          = g_pmds_d[l_i].pmdt039
                  LET l_x02_tmp.l_sumapcb103     = g_pmds_d[l_i].l_sumapcb103
                  LET l_x02_tmp.l_sumapcb104     = g_pmds_d[l_i].l_sumapcb104
                  LET l_x02_tmp.l_sumapcb105     = g_pmds_d[l_i].l_sumapcb105
                  #170118-00052#1----(e)----
                  LET l_x02_tmp.l_sfapcb103      = g_pmds_d[l_i].l_sfapcb103     
                  LET l_x02_tmp.l_sfapcb104      = g_pmds_d[l_i].l_sfapcb104     
                  LET l_x02_tmp.l_sfapcb105      = g_pmds_d[l_i].l_sfapcb105     
                  LET l_x02_tmp.l_apcb113        = g_pmds_d[l_i].l_apcb113       
                  LET l_x02_tmp.l_apcb114        = g_pmds_d[l_i].l_apcb114       
                  LET l_x02_tmp.l_apcb115        = g_pmds_d[l_i].l_apcb115       
                  LET l_x02_tmp.l_dapcb103       = g_pmds_d[l_i].l_dapcb103      
                  LET l_x02_tmp.l_dapcb104       = g_pmds_d[l_i].l_dapcb104      
                  LET l_x02_tmp.l_dapcb105       = g_pmds_d[l_i].l_dapcb105      
                  LET l_x02_tmp.l_pmdt0382       = g_pmds_d[l_i].l_pmdt0382      
                  LET l_x02_tmp.l_pmdt0472       = g_pmds_d[l_i].l_pmdt0472      
                  LET l_x02_tmp.l_pmdt0392       = g_pmds_d[l_i].l_pmdt0392      
                  LET l_x02_tmp.l_apcadocno      = g_pmds_d[l_i].apcadocno     
                  LET l_x02_tmp.l_apca2          = g_pmds_d[l_i].apca2  

                   #170118-00052#1--mark--(s)----
#                  INSERT INTO aapq130_x02_tmp(
#                              pmdtsite      ,pmds007       ,l_pmds007_desc,pmds001       ,l_pmds000     ,
#                              pmdtdocno     ,pmdtseq       ,pmdt006       ,l_pmdt006_desc,l_pmdt006_desc_1,
#                              l_pmdt005_desc,l_imag011     ,l_imag011_desc,l_apcb021     ,l_apcb021_desc,
#                              pmdt001       ,pmdt002       ,pmdt050       ,pmds002       ,l_pmds022_desc,
#                              pmds003       ,l_pmds003_desc,pmdt016       ,l_pmdt016_desc,pmdt024       ,
#                              l_apcb007     ,pmdt056       ,pmdt066       ,pmdt069       ,l_diffqty     ,
#                              pmds037       ,pmds038       ,pmdt046       ,pmdt037       ,pmdt036       ,
#                              l_pmdt038_3   ,l_pmdt047_3   ,l_pmdt039_3   ,l_sfapcb103   ,l_sfapcb104   ,
#                              l_sfapcb105   ,l_apcb113     ,l_apcb114     ,l_apcb115     ,l_dapcb103    ,
#                              l_dapcb104    ,l_dapcb105    ,l_pmdt0382    ,l_pmdt0472    ,l_pmdt0392    ,
#                              pmdt020       ,l_apca101     ,      #161206-00017#2
#                              l_apcadocno   ,l_apca2)  
#                    VALUES(   g_pmds_d[l_i].pmdtsite      ,g_pmds_d[l_i].pmds007,g_pmds_d[l_i].pmds007_desc,g_pmds_d[l_i].pmds001,g_pmds_d[l_i].l_pmds000,
#                              g_pmds_d[l_i].pmdtdocno,g_pmds_d[l_i].pmdtseq,g_pmds_d[l_i].pmdt006,g_pmds_d[l_i].pmdt006_desc,g_pmds_d[l_i].pmdt006_desc_1,
#                              g_pmds_d[l_i].pmdt005,g_pmds_d[l_i].imag011       ,g_pmds_d[l_i].imag011_desc  ,g_pmds_d[l_i].apcb021       ,g_pmds_d[l_i].apcb021_desc  ,
#                              g_pmds_d[l_i].pmdt001       ,g_pmds_d[l_i].pmdt002       ,g_pmds_d[l_i].pmdt050       ,g_pmds_d[l_i].pmds002       ,g_pmds_d[l_i].pmds002_desc  ,
#                              g_pmds_d[l_i].pmds003       ,g_pmds_d[l_i].pmds003_desc  ,g_pmds_d[l_i].pmdt016       ,g_pmds_d[l_i].pmdt016_desc  ,g_pmds_d[l_i].pmdt024       ,
#                              g_pmds_d[l_i].apcb007       ,g_pmds_d[l_i].pmdt056       ,g_pmds_d[l_i].pmdt066       ,g_pmds_d[l_i].pmdt069       ,g_pmds_d[l_i].l_diffqty     ,
#                              g_pmds_d[l_i].pmds037       ,g_pmds_d[l_i].pmds038       ,cpmdt046       ,g_pmds_d[l_i].pmdt037       ,g_pmds_d[l_i].pmdt036       ,
#                              g_pmds_d[l_i].l_pmdt0383    ,g_pmds_d[l_i].l_pmdt0473    ,g_pmds_d[l_i].l_pmdt0393    ,g_pmds_d[l_i].l_sfapcb103   ,g_pmds_d[l_i].l_sfapcb104   ,
#                              g_pmds_d[l_i].l_sfapcb105   ,g_pmds_d[l_i].l_apcb113     ,g_pmds_d[l_i].l_apcb114     ,g_pmds_d[l_i].l_apcb115     ,g_pmds_d[l_i].l_dapcb103    ,
#                              g_pmds_d[l_i].l_dapcb104    ,g_pmds_d[l_i].l_dapcb105    ,g_pmds_d[l_i].l_pmdt0382    ,g_pmds_d[l_i].l_pmdt0472    ,g_pmds_d[l_i].l_pmdt0392    ,
#                              g_pmds_d[l_i].pmdt020       ,g_pmds_d[l_i].l_apca101     ,      #161206-00017#2
#                              g_pmds_d[l_i].apcadocno     ,g_pmds_d[l_i].apca2)
                  #170118-00052#1--mark--(e)----
                              
                  #170118-00052#1--add--(s)----
                  INSERT INTO aapq130_x02_tmp(
                              pmdtsite      ,pmds007       ,l_pmds007_desc,pmds001       ,l_pmds000     ,
                              pmdtdocno     ,pmdtseq       ,pmdt006       ,l_pmdt006_desc,l_pmdt006_desc_1,
                              l_pmdt005_desc,l_imag011     ,l_imag011_desc,l_apcb021     ,l_apcb021_desc,
                              pmdt001       ,pmdt002       ,pmdt050       ,pmds002       ,l_pmds022_desc,
                              pmds003       ,l_pmds003_desc,pmdt016       ,l_pmdt016_desc,pmdt024       ,
                              l_apcb007     ,pmdt056       ,pmdt066       ,pmdt069       ,l_diffqty     ,
                              pmds037       ,pmds038       ,pmdt046       ,pmdt037       ,pmdt036       ,
                              l_pmdt038_3   ,l_pmdt047_3   ,l_pmdt039_3   ,                              
                              pmdt038,l_pmdt047,pmdt039,l_sumapcb103,l_sumapcb104,l_sumapcb105,                             
                              l_sfapcb103   ,l_sfapcb104   ,
                              l_sfapcb105   ,l_apcb113     ,l_apcb114     ,l_apcb115     ,l_dapcb103    ,
                              l_dapcb104    ,l_dapcb105    ,l_pmdt0382    ,l_pmdt0472    ,l_pmdt0392    ,
                              pmdt020       ,l_apca101     ,      
                              l_apcadocno   ,l_apca2)  
                    VALUES(   g_pmds_d[l_i].pmdtsite      ,g_pmds_d[l_i].pmds007,g_pmds_d[l_i].pmds007_desc,g_pmds_d[l_i].pmds001,g_pmds_d[l_i].l_pmds000,
                              g_pmds_d[l_i].pmdtdocno,g_pmds_d[l_i].pmdtseq,g_pmds_d[l_i].pmdt006,g_pmds_d[l_i].pmdt006_desc,g_pmds_d[l_i].pmdt006_desc_1,
                              g_pmds_d[l_i].pmdt005,g_pmds_d[l_i].imag011       ,g_pmds_d[l_i].imag011_desc  ,g_pmds_d[l_i].apcb021       ,g_pmds_d[l_i].apcb021_desc  ,
                              g_pmds_d[l_i].pmdt001       ,g_pmds_d[l_i].pmdt002       ,g_pmds_d[l_i].pmdt050       ,g_pmds_d[l_i].pmds002       ,g_pmds_d[l_i].pmds002_desc  ,
                              g_pmds_d[l_i].pmds003       ,g_pmds_d[l_i].pmds003_desc  ,g_pmds_d[l_i].pmdt016       ,g_pmds_d[l_i].pmdt016_desc  ,g_pmds_d[l_i].pmdt024       ,
                              g_pmds_d[l_i].apcb007       ,g_pmds_d[l_i].pmdt056       ,g_pmds_d[l_i].pmdt066       ,g_pmds_d[l_i].pmdt069       ,g_pmds_d[l_i].l_diffqty     ,
                              g_pmds_d[l_i].pmds037       ,g_pmds_d[l_i].pmds038       ,g_pmds_d[l_i].pmdt046       ,g_pmds_d[l_i].pmdt037       ,g_pmds_d[l_i].pmdt036       ,
                              g_pmds_d[l_i].l_pmdt0383    ,g_pmds_d[l_i].l_pmdt0473    ,g_pmds_d[l_i].l_pmdt0393    ,                              
                              g_pmds_d[l_i].pmdt038,g_pmds_d[l_i].l_pmdt047,g_pmds_d[l_i].pmdt039,g_pmds_d[l_i].l_sumapcb103,g_pmds_d[l_i].l_sumapcb104,g_pmds_d[l_i].l_sumapcb105,                              
                              g_pmds_d[l_i].l_sfapcb103   ,g_pmds_d[l_i].l_sfapcb104   ,
                              g_pmds_d[l_i].l_sfapcb105   ,g_pmds_d[l_i].l_apcb113     ,g_pmds_d[l_i].l_apcb114     ,g_pmds_d[l_i].l_apcb115     ,g_pmds_d[l_i].l_dapcb103    ,
                              g_pmds_d[l_i].l_dapcb104    ,g_pmds_d[l_i].l_dapcb105    ,g_pmds_d[l_i].l_pmdt0382    ,g_pmds_d[l_i].l_pmdt0472    ,g_pmds_d[l_i].l_pmdt0392    ,
                              g_pmds_d[l_i].pmdt020       ,g_pmds_d[l_i].l_apca101     ,     
                              g_pmds_d[l_i].apcadocno     ,g_pmds_d[l_i].apca2)     
                     #170118-00052#1--add--(e)----                              
                              
                              
               END FOR
               CALL aapq130_x02(" 1=1","aapq130_x02_tmp" )
               #161205-00025#18-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL aapr130_x01(g_output_wc,g_input.apcald,g_apcacomp,g_input.type,g_aapq130_arg)   #161205-00025#18 mark
               #161205-00025#18-----s
               DELETE FROM aapq130_x02_tmp
               FOR l_i = 1 TO g_pmds_d.getLength()
                  INITIALIZE l_x02_tmp.* TO NULL
                  LET l_x02_tmp.pmdtsite         = g_pmds_d[l_i].pmdtsite       
                  LET l_x02_tmp.pmds007          = g_pmds_d[l_i].pmds007
                  LET l_x02_tmp.l_pmds007_desc   = g_pmds_d[l_i].pmds007_desc
                  LET l_x02_tmp.pmds001          = g_pmds_d[l_i].pmds001
                  LET l_x02_tmp.l_pmds000        = g_pmds_d[l_i].l_pmds000
                  LET l_x02_tmp.pmdtdocno        = g_pmds_d[l_i].pmdtdocno
                  LET l_x02_tmp.pmdtseq          = g_pmds_d[l_i].pmdtseq
                  LET l_x02_tmp.pmdt006          = g_pmds_d[l_i].pmdt006
                  LET l_x02_tmp.l_pmdt006_desc   = g_pmds_d[l_i].pmdt006_desc
                  LET l_x02_tmp.l_pmdt006_desc_1 = g_pmds_d[l_i].pmdt006_desc_1
                  LET l_x02_tmp.l_pmdt005_desc   = g_pmds_d[l_i].pmdt005
                  LET l_x02_tmp.l_imag011        = g_pmds_d[l_i].imag011       
                  LET l_x02_tmp.l_imag011_desc   = g_pmds_d[l_i].imag011_desc  
                  LET l_x02_tmp.l_apcb021        = g_pmds_d[l_i].apcb021       
                  LET l_x02_tmp.l_apcb021_desc   = g_pmds_d[l_i].apcb021_desc  
                  LET l_x02_tmp.pmdt001          = g_pmds_d[l_i].pmdt001         
                  LET l_x02_tmp.pmdt002          = g_pmds_d[l_i].pmdt002         
                  LET l_x02_tmp.pmdt050          = g_pmds_d[l_i].pmdt050         
                  LET l_x02_tmp.pmds002          = g_pmds_d[l_i].pmds002         
                  LET l_x02_tmp.l_pmds022_desc   = g_pmds_d[l_i].pmds002_desc  
                  LET l_x02_tmp.pmds003          = g_pmds_d[l_i].pmds003         
                  LET l_x02_tmp.l_pmds003_desc   = g_pmds_d[l_i].pmds003_desc  
                  LET l_x02_tmp.pmdt016          = g_pmds_d[l_i].pmdt016         
                  LET l_x02_tmp.l_pmdt016_desc   = g_pmds_d[l_i].pmdt016_desc  
                  LET l_x02_tmp.pmdt024          = g_pmds_d[l_i].pmdt024         
                  LET l_x02_tmp.l_apcb007        = g_pmds_d[l_i].apcb007       
                  LET l_x02_tmp.pmdt056          = g_pmds_d[l_i].pmdt056         
                  LET l_x02_tmp.pmdt066          = g_pmds_d[l_i].pmdt066         
                  LET l_x02_tmp.pmdt069          = g_pmds_d[l_i].pmdt069         
                  LET l_x02_tmp.l_diffqty        = g_pmds_d[l_i].l_diffqty       
                  LET l_x02_tmp.pmds037          = g_pmds_d[l_i].pmds037         
                  LET l_x02_tmp.pmds038          = g_pmds_d[l_i].pmds038         
                  LET l_x02_tmp.pmdt046          = g_pmds_d[l_i].pmdt046         
                  LET l_x02_tmp.pmdt037          = g_pmds_d[l_i].pmdt037         
                  LET l_x02_tmp.pmdt036          = g_pmds_d[l_i].pmdt036         
                  LET l_x02_tmp.l_pmdt038_3      = g_pmds_d[l_i].l_pmdt0383     
                  LET l_x02_tmp.l_pmdt047_3      = g_pmds_d[l_i].l_pmdt0473     
                  LET l_x02_tmp.l_pmdt039_3      = g_pmds_d[l_i].l_pmdt0393    
                  #170118-00052#1----(s)----
                  LET l_x02_tmp.pmdt038          = g_pmds_d[l_i].pmdt038
                  LET l_x02_tmp.l_pmdt047        = g_pmds_d[l_i].l_pmdt047
                  LET l_x02_tmp.pmdt039          = g_pmds_d[l_i].pmdt039
                  LET l_x02_tmp.l_sumapcb103     = g_pmds_d[l_i].l_sumapcb103
                  LET l_x02_tmp.l_sumapcb104     = g_pmds_d[l_i].l_sumapcb104
                  LET l_x02_tmp.l_sumapcb105     = g_pmds_d[l_i].l_sumapcb105
                  #170118-00052#1----(e)----                  
                  LET l_x02_tmp.l_sfapcb103      = g_pmds_d[l_i].l_sfapcb103     
                  LET l_x02_tmp.l_sfapcb104      = g_pmds_d[l_i].l_sfapcb104     
                  LET l_x02_tmp.l_sfapcb105      = g_pmds_d[l_i].l_sfapcb105     
                  LET l_x02_tmp.l_apcb113        = g_pmds_d[l_i].l_apcb113       
                  LET l_x02_tmp.l_apcb114        = g_pmds_d[l_i].l_apcb114       
                  LET l_x02_tmp.l_apcb115        = g_pmds_d[l_i].l_apcb115       
                  LET l_x02_tmp.l_dapcb103       = g_pmds_d[l_i].l_dapcb103      
                  LET l_x02_tmp.l_dapcb104       = g_pmds_d[l_i].l_dapcb104      
                  LET l_x02_tmp.l_dapcb105       = g_pmds_d[l_i].l_dapcb105      
                  LET l_x02_tmp.l_pmdt0382       = g_pmds_d[l_i].l_pmdt0382      
                  LET l_x02_tmp.l_pmdt0472       = g_pmds_d[l_i].l_pmdt0472      
                  LET l_x02_tmp.l_pmdt0392       = g_pmds_d[l_i].l_pmdt0392      
                  LET l_x02_tmp.l_apcadocno      = g_pmds_d[l_i].apcadocno     
                  LET l_x02_tmp.l_apca2          = g_pmds_d[l_i].apca2  
                  
                  #170118-00052#1--mark--(s)----
#                  INSERT INTO aapq130_x02_tmp(
#                              pmdtsite      ,pmds007       ,l_pmds007_desc,pmds001       ,l_pmds000     ,
#                              pmdtdocno     ,pmdtseq       ,pmdt006       ,l_pmdt006_desc,l_pmdt006_desc_1,
#                              l_pmdt005_desc,l_imag011     ,l_imag011_desc,l_apcb021     ,l_apcb021_desc,
#                              pmdt001       ,pmdt002       ,pmdt050       ,pmds002       ,l_pmds022_desc,
#                              pmds003       ,l_pmds003_desc,pmdt016       ,l_pmdt016_desc,pmdt024       ,
#                              l_apcb007     ,pmdt056       ,pmdt066       ,pmdt069       ,l_diffqty     ,
#                              pmds037       ,pmds038       ,pmdt046       ,pmdt037       ,pmdt036       ,
#                              l_pmdt038_3   ,l_pmdt047_3   ,l_pmdt039_3   , l_sfapcb103   ,l_sfapcb104   ,
#                              l_sfapcb105   ,l_apcb113     ,l_apcb114     ,l_apcb115     ,l_dapcb103    ,
#                              l_dapcb104    ,l_dapcb105    ,l_pmdt0382    ,l_pmdt0472    ,l_pmdt0392    ,
#                              pmdt020       ,l_apca101     ,      #161206-00017#2
#                              l_apcadocno   ,l_apca2)  
#                    VALUES(   g_pmds_d[l_i].pmdtsite      ,g_pmds_d[l_i].pmds007,g_pmds_d[l_i].pmds007_desc,g_pmds_d[l_i].pmds001,g_pmds_d[l_i].l_pmds000,
#                              g_pmds_d[l_i].pmdtdocno,g_pmds_d[l_i].pmdtseq,g_pmds_d[l_i].pmdt006,g_pmds_d[l_i].pmdt006_desc,g_pmds_d[l_i].pmdt006_desc_1,
#                              g_pmds_d[l_i].pmdt005,g_pmds_d[l_i].imag011       ,g_pmds_d[l_i].imag011_desc  ,g_pmds_d[l_i].apcb021       ,g_pmds_d[l_i].apcb021_desc  ,
#                              g_pmds_d[l_i].pmdt001       ,g_pmds_d[l_i].pmdt002       ,g_pmds_d[l_i].pmdt050       ,g_pmds_d[l_i].pmds002       ,g_pmds_d[l_i].pmds002_desc  ,
#                              g_pmds_d[l_i].pmds003       ,g_pmds_d[l_i].pmds003_desc  ,g_pmds_d[l_i].pmdt016       ,g_pmds_d[l_i].pmdt016_desc  ,g_pmds_d[l_i].pmdt024       ,
#                              g_pmds_d[l_i].apcb007       ,g_pmds_d[l_i].pmdt056       ,g_pmds_d[l_i].pmdt066       ,g_pmds_d[l_i].pmdt069       ,g_pmds_d[l_i].l_diffqty     ,
#                              g_pmds_d[l_i].pmds037       ,g_pmds_d[l_i].pmds038       ,g_pmds_d[l_i].pmdt046       ,g_pmds_d[l_i].pmdt037       ,g_pmds_d[l_i].pmdt036       ,
#                              g_pmds_d[l_i].l_pmdt0383    ,g_pmds_d[l_i].l_pmdt0473    ,g_pmds_d[l_i].l_pmdt0393    ,g_pmds_d[l_i].l_sfapcb103   ,g_pmds_d[l_i].l_sfapcb104   ,
#                              g_pmds_d[l_i].l_sfapcb105   ,g_pmds_d[l_i].l_apcb113     ,g_pmds_d[l_i].l_apcb114     ,g_pmds_d[l_i].l_apcb115     ,g_pmds_d[l_i].l_dapcb103    ,
#                              g_pmds_d[l_i].l_dapcb104    ,g_pmds_d[l_i].l_dapcb105    ,g_pmds_d[l_i].l_pmdt0382    ,g_pmds_d[l_i].l_pmdt0472    ,g_pmds_d[l_i].l_pmdt0392    ,
#                              g_pmds_d[l_i].pmdt020       ,g_pmds_d[l_i].l_apca101     ,      #161206-00017#2
#                              g_pmds_d[l_i].apcadocno     ,g_pmds_d[l_i].apca2)
                    #170118-00052#1--mark--(e)----
                   
                  #170118-00052#1--add--(s)----
                  INSERT INTO aapq130_x02_tmp(
                              pmdtsite      ,pmds007       ,l_pmds007_desc,pmds001       ,l_pmds000     ,
                              pmdtdocno     ,pmdtseq       ,pmdt006       ,l_pmdt006_desc,l_pmdt006_desc_1,
                              l_pmdt005_desc,l_imag011     ,l_imag011_desc,l_apcb021     ,l_apcb021_desc,
                              pmdt001       ,pmdt002       ,pmdt050       ,pmds002       ,l_pmds022_desc,
                              pmds003       ,l_pmds003_desc,pmdt016       ,l_pmdt016_desc,pmdt024       ,
                              l_apcb007     ,pmdt056       ,pmdt066       ,pmdt069       ,l_diffqty     ,
                              pmds037       ,pmds038       ,pmdt046       ,pmdt037       ,pmdt036       ,
                              l_pmdt038_3   ,l_pmdt047_3   ,l_pmdt039_3   ,                              
                              pmdt038,l_pmdt047,pmdt039,l_sumapcb103,l_sumapcb104,l_sumapcb105,                             
                              l_sfapcb103   ,l_sfapcb104   ,
                              l_sfapcb105   ,l_apcb113     ,l_apcb114     ,l_apcb115     ,l_dapcb103    ,
                              l_dapcb104    ,l_dapcb105    ,l_pmdt0382    ,l_pmdt0472    ,l_pmdt0392    ,
                              pmdt020       ,l_apca101     ,      
                              l_apcadocno   ,l_apca2)  
                    VALUES(   g_pmds_d[l_i].pmdtsite      ,g_pmds_d[l_i].pmds007,g_pmds_d[l_i].pmds007_desc,g_pmds_d[l_i].pmds001,g_pmds_d[l_i].l_pmds000,
                              g_pmds_d[l_i].pmdtdocno,g_pmds_d[l_i].pmdtseq,g_pmds_d[l_i].pmdt006,g_pmds_d[l_i].pmdt006_desc,g_pmds_d[l_i].pmdt006_desc_1,
                              g_pmds_d[l_i].pmdt005,g_pmds_d[l_i].imag011       ,g_pmds_d[l_i].imag011_desc  ,g_pmds_d[l_i].apcb021       ,g_pmds_d[l_i].apcb021_desc  ,
                              g_pmds_d[l_i].pmdt001       ,g_pmds_d[l_i].pmdt002       ,g_pmds_d[l_i].pmdt050       ,g_pmds_d[l_i].pmds002       ,g_pmds_d[l_i].pmds002_desc  ,
                              g_pmds_d[l_i].pmds003       ,g_pmds_d[l_i].pmds003_desc  ,g_pmds_d[l_i].pmdt016       ,g_pmds_d[l_i].pmdt016_desc  ,g_pmds_d[l_i].pmdt024       ,
                              g_pmds_d[l_i].apcb007       ,g_pmds_d[l_i].pmdt056       ,g_pmds_d[l_i].pmdt066       ,g_pmds_d[l_i].pmdt069       ,g_pmds_d[l_i].l_diffqty     ,
                              g_pmds_d[l_i].pmds037       ,g_pmds_d[l_i].pmds038       ,g_pmds_d[l_i].pmdt046       ,g_pmds_d[l_i].pmdt037       ,g_pmds_d[l_i].pmdt036       ,
                              g_pmds_d[l_i].l_pmdt0383    ,g_pmds_d[l_i].l_pmdt0473    ,g_pmds_d[l_i].l_pmdt0393    ,                              
                              g_pmds_d[l_i].pmdt038,g_pmds_d[l_i].l_pmdt047,g_pmds_d[l_i].pmdt039,g_pmds_d[l_i].l_sumapcb103,g_pmds_d[l_i].l_sumapcb104,g_pmds_d[l_i].l_sumapcb105,                              
                              g_pmds_d[l_i].l_sfapcb103   ,g_pmds_d[l_i].l_sfapcb104   ,
                              g_pmds_d[l_i].l_sfapcb105   ,g_pmds_d[l_i].l_apcb113     ,g_pmds_d[l_i].l_apcb114     ,g_pmds_d[l_i].l_apcb115     ,g_pmds_d[l_i].l_dapcb103    ,
                              g_pmds_d[l_i].l_dapcb104    ,g_pmds_d[l_i].l_dapcb105    ,g_pmds_d[l_i].l_pmdt0382    ,g_pmds_d[l_i].l_pmdt0472    ,g_pmds_d[l_i].l_pmdt0392    ,
                              g_pmds_d[l_i].pmdt020       ,g_pmds_d[l_i].l_apca101     ,     
                              g_pmds_d[l_i].apcadocno     ,g_pmds_d[l_i].apca2)     
                     #170118-00052#1--add--(e)----                      
                    
               END FOR
               CALL aapq130_x02(" 1=1","aapq130_x02_tmp" )
               #161205-00025#18-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
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
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         #150127-00007#1
         CALL aapq130_qbe_clear()
         IF NOT cl_null(g_input.apcald) THEN 
            CALL s_ld_sel_glaa(g_input.apcald,'glaa003')
                 RETURNING g_sub_success,l_glaa003
            
            CALL s_get_accdate(l_glaa003,g_today,'','')
                     RETURNING g_sub_success,g_errno,l_num,
                               l_num,l_date,l_date,
                               l_num,l_pdate_s,l_pdate_e,
                               l_num,l_date,l_date
            LET l_str = l_pdate_s,":",l_pdate_e
            DISPLAY l_str TO pmds001    #顯示到畫面上
         END IF
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq130_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_field         DYNAMIC ARRAY OF RECORD
                           f11       LIKE type_t.chr100,
                           f21       LIKE type_t.chr100,
                           f31       LIKE type_t.chr100,     #albireo 150129 add
                           f32       LIKE type_t.chr100,     #albireo 150129 add
                           f33       LIKE type_t.chr100,     #albireo 150129 add
                           f34       LIKE type_t.chr100      #albireo 150129 add   
                          END RECORD   
   DEFINE l_ld_type       LIKE type_t.chr1             
   DEFINE l_nouse         LIKE type_t.num20_6
   DEFINE l_glaa001       LIKE glaa_t.glaa001
   DEFINE l_wc            STRING 
   DEFINE l_pmdtcomp      LIKE apca_t.apcacomp    #入庫單據點所屬法人   
   DEFINE l_pmdtld        LIKE apca_t.apcald      #入庫單據點帳套   
   DEFINE l_pmdtdocno_t   LIKE pmdt_t.pmdtdocno   #前筆入庫單
   DEFINE l_tmp           type_g_pmds_d   
   DEFINE l_odr           LIKE type_t.num5
   DEFINE l_apcb007       LIKE apcf_t.apcf007     #150401-00010#1
   DEFINE l_pmds000_str1   STRING                 #150702-00001#1 add
   DEFINE l_pmdwdocno     LIKE pmdw_t.pmdwdocno   #150902-00001#3
   DEFINE l_msg1          STRING     #161205-00025#18 add
   DEFINE l_sql           STRING     #170123-00045#1 add
   DEFINE l_sql2          STRING     #170209-00025#1 add  算總筆數用
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #albireo 150107 141218-00011#11 Modify -----s
   IF g_wc <> " 1=2" THEN
      CASE 
         WHEN cl_null(g_input.apcasite)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'acr-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         WHEN cl_null(g_input.apcald) AND g_aapq130_arg = '1'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'acr-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
      END CASE
   END IF
   #albireo 150107 141218-00011#11 Modify-----e  

   DELETE FROM aapq130_tmp
   
   #albireo 150129-----s
   CALL cl_set_comp_visible('b_pmdt038,l_pmdt047,b_pmdt039,l_pmdt0382,l_pmdt0472,l_pmdt0392',TRUE)
   IF g_input.type = '2' THEN
      CALL cl_set_comp_visible('b_pmdt038,l_pmdt047,b_pmdt039,l_pmdt0382,l_pmdt0472,l_pmdt0392',FALSE)
   END IF
   #albireo 150129-----e
  
   #161205-00025#18-----s  
   LET l_msg1 =  cl_getmsg('aap-00287',g_lang)
   #161205-00025#18-----e
   
   #取得帳套類型
   #albireo 150105 141218-00011#11 modify-----s
   IF g_aapq130_arg = '2' THEN
      LET l_ld_type = 4      #抓發票數量 aapq140
   ELSE
      #依帳別抓立帳數量 aapq130
      CALL s_fin_get_ld_type(g_input.apcald) RETURNING l_ld_type
      IF l_ld_type = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00301'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()   
         RETURN
      END IF
   END IF  
   #albireo 150105 141218-00011#11 modify-----e
   CALL s_ld_sel_glaa(g_input.apcald,'glaa001')
        RETURNING  g_sub_success,l_glaa001
   #依據類型決定要串sql的數量欄位
   LET l_field[1].f11 = "pmdt056"    LET l_field[2].f11 = "pmdt057"    LET l_field[3].f11 = "pmdt058"     #請款數量
   LET l_field[1].f21 = "pmdt066"    LET l_field[2].f21 = "pmdt067"    LET l_field[3].f21 = "pmdt068"     #暫估數量
   #albireo 150105 141218-00011#11-----s
   LET l_field[1].f31 = "pmdt0562"   LET l_field[2].f31 = "pmdt0562"   LET l_field[3].f31 = "pmdt0562"    #立帳數
   LET l_field[1].f32 = "sumapcb103" LET l_field[2].f32 = "sumapcb103" LET l_field[3].f32 = "sumapcb103"  #立帳原幣未稅
   LET l_field[1].f33 = "sumapcb104" LET l_field[2].f33 = "sumapcb104" LET l_field[3].f33 = "sumapcb104"  #立帳原幣稅
   LET l_field[1].f34 = "sumapcb105" LET l_field[2].f34 = "sumapcb105" LET l_field[3].f34 = "sumapcb105"  #立帳原幣含稅
   #第4個放aapq130
  #LET l_field[4].f11 = "pmdt069" LET l_field[4].f21 = '0'          #170203-00032#1 mark  
   LET l_field[4].f11 = "pmdt069" LET l_field[4].f21 = "pmdt066"    #170203-00032#1 add   
   LET l_field[4].f31 = "apba010" LET l_field[4].f32 = 'apba103'
   LET l_field[4].f33 = "apba104" LET l_field[4].f34 = 'apba105'
   #albireo 150105 141218-00011#11-----e
   
   #170123-00045#1 --s add
   #費用科目
   LET l_sql = " SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",
               "  WHERE apcaent = ",g_enterprise," AND apcald = '",g_input.apcald,"' AND apcastus <> 'X'",
               "    AND apcb002 = ? AND apcb003 = ?  "
   PREPARE aapr130_apcb021p FROM l_sql
   DECLARE aapr130_apcb021c SCROLL CURSOR FOR aapr130_apcb021p      
   
   #科目說明
   LET l_sql = " SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = ",g_enterprise," AND glaaent  = glaclent AND glacl001 = glaa004  ",
               "    AND glacl002 = (SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",
               "                     WHERE apcaent = ",g_enterprise," AND apcald = '",g_input.apcald,"' AND apcastus <> 'X' AND apcb002 = ? AND apcb003 = ? ) ",
               "    AND glacl003 = '",g_dlang,"' AND glaald = '",g_input.apcald,"' "
   PREPARE aapr130_apcb021dp FROM l_sql
   DECLARE aapr130_apcb021dc SCROLL CURSOR FOR aapr130_apcb021dp    
   
   #應付帳款單號
   LET l_sql = " SELECT apcadocno FROM apca_t,apcb_t ",
               "  WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               "    AND apcald = '",g_input.apcald,"' AND apca001 NOT IN('01','02','03','04') ",
               "    AND apcb002 = ? AND apcb003 = ? AND apcastus <> 'X' "
   PREPARE aapr130_docno1p FROM l_sql
   DECLARE aapr130_docno1c SCROLL CURSOR FOR aapr130_docno1p       
   
   #暫估單號
   LET l_sql = " SELECT apcadocno FROM apca_t,apcb_t ",
               "  WHERE apcaent = ",g_enterprise," AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               "    AND apcald = '",g_input.apcald,"' AND apca001 IN ('01','02','03','04') ",
               "    AND apcb002 = ? AND apcb003 = ? AND apcastus <> 'X' "
   PREPARE aapr130_docno2p FROM l_sql
   DECLARE aapr130_docno2c SCROLL CURSOR FOR aapr130_docno2p       
   #170123-00045#1 --e add    
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_pmds_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_odr = 1
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','',pmds007,'',pmds001,'','','','','','','','','','','','','', 
       '',pmds002,'',pmds003,'','','','','','','','','','',pmds037,pmds038,'','','','','','','','','', 
       '','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY pmds_t.pmdsdocno) AS RANK FROM pmds_t", 
 
 
 
                     "",
                     " WHERE pmdsent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmds_t"),
                     " ORDER BY pmds_t.pmdsdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '','',pmds007,'',pmds001,'','','','','','','','','','','','','','',pmds002,'', 
       pmds003,'','','','','','','','','','',pmds037,pmds038,'','','','','','','','','','','','','', 
       '','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET l_wc =  g_input.wc CLIPPED
   IF cl_null(l_wc)THEN LET l_wc = ' 1=1' END IF
   IF cl_null(g_input.wc2)THEN LET g_input.wc2 = ' 1=1' END IF
   LET l_wc = l_wc CLIPPED, " AND pmdssite IN ",g_wc_apcasite
   LET ls_wc = ls_wc," AND ",g_user_dept_wc     #160518-00075#16
   LET ls_wc = ls_wc, " AND ",l_wc CLIPPED," "
   LET g_output_wc = ls_wc   

   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"(gzcb003 = 'Y' OR gzcb005 = '2')")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
   #150702-00001#1-----e
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc = ls_wc,"AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
   #LET g_sql = "SELECT '',pmdtsite,pmds007,'',pmds001,pmds000,pmdtdocno,pmdtseq,pmdt006,'','',pmdt001,pmdt024, ",   #150128-00005#9 mark   #150106-00011#2 albireo add pmds001 #150127-00007#1
   #--#150128-00005#9-str--
   #160414-00018#4 mark--s
   #LET g_sql = "SELECT '',pmdtsite,pmds007,'',pmds001,pmds000,pmdtdocno,pmdtseq,pmdt006,'','',pmdt005,'','','','',pmdt001,pmdt002,pmdt050, ",            #150902-00001#3 add pmdt002,pmdt050    #151102-00008#1 add pmdt005
   #            "       CASE WHEN pmdl002 IS NOT NULL THEN pmdl002 ELSE pmds002 END pmds002,'',",    #無採購單者改取入庫人員                                         
   #            "       CASE WHEN pmdl003 IS NOT NULL THEN pmdl003 ELSE pmds003 END pmds003,'',",    #無採購單者改取入庫部門    
   #            "       pmdt016,'',pmdt024, ",
   #160414-00018#4 mark--e
   #160414-00018#4--s
   LET g_sql = "SELECT '',pmdtsite,pmds007,(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=pmdtent AND pmaal001=pmds007 AND pmaal002='",g_dlang,"'),",  
               " pmds001,pmds000,pmdtdocno,pmdtseq,pmdt006,",
               #品名、規格
               " (SELECT imaal003 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='",g_dlang,"'), ",
               " (SELECT imaal004 FROM imaal_t WHERE imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='",g_dlang,"'), ",
               " pmdt005, ",
               #成本分群、成本分群說明
               " (SELECT imag011 FROM imag_t WHERE imagent = pmdtent AND imagsite = '",g_apcacomp,"' AND imag001 = pmdt006),",
               " (SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdtent AND oocql001 = '206' AND oocql002 = ((SELECT imag011 FROM imag_t WHERE imagent = pmdtent AND imagsite = '",g_apcacomp,"' AND imag001 = pmdt006)) ",
               " AND oocql003 = '",g_dlang,"'),",
               #170123-00045#1 --s mark
               ##費用科目
               #" (SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",
               #" WHERE apcaent = pmdtent AND apcald = '",g_input.apcald,"' AND apcastus <> 'X'",
               #" AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1), ",
               ##科目說明
               #" (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = pmdtent AND glacl001 = glaa004 ",
               #" AND glacl002 = ((SELECT apcb021 FROM apca_t LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'",
               #" WHERE apcaent = pmdtent AND apcald = '",g_input.apcald,"' AND apcastus <> 'X'",
               #" AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1)) ",
               #" AND glacl003 = '",g_dlang,"' AND glaald = '",g_input.apcald,"' AND glaaent  = glaclent),",
               #170123-00045#1 --e mark  
               " '','', ",   #170123-00045#1 add  
               " pmdt001,pmdt002,pmdt050, ",        
               " CASE WHEN pmdl002 IS NOT NULL THEN pmdl002 ELSE pmds002 END pmds002, ",    #無採購單者改取入庫人員    
               #人員說明
               " CASE WHEN pmdl002 IS NOT NULL THEN (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdtent AND ooag001 = pmdl002) ",               
               " ELSE (SELECT ooag011 FROM ooag_t WHERE ooagent = pmdtent AND ooag001 = pmds002) END, ",
               " CASE WHEN pmdl003 IS NOT NULL THEN pmdl003 ELSE pmds003 END pmds003, ",    #無採購單者改取入庫部門  
               #部門說明
               " CASE WHEN pmdl003 IS NOT NULL THEN (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdtent AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"') ",                   
               " ELSE (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdtent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"') END,",   
               " pmdt016, ",
               " (SELECT inayl003 FROM inay_t LEFT OUTER JOIN inayl_t ON inayent = inaylent AND inay001 = inayl001 AND inayl002 = '",g_dlang,"' ",
               "   WHERE inayent = pmdtent AND inay001 = pmdt016), ",
               " pmdt020, ",    #161206-00017#2
               " pmdt024, ",
   #160414-00018#4--e 
   #--#150128-00005#9-end--
               #" apcb007,pmdt0562,(pmdt066-apcfminus),pmdt069,0,pmds037,pmds038,",      #150123-00003#2 albireo add pmdt0562;diffqty=0;pmdt066 #160802-00036#2 mark
               #160802-00036#2 -s
               " apcb007,pmdt0562,",
               #未沖暫估數量
               " CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END pmdt066apcf,",
               #已開發票數量/差異數量/幣別/匯率
               " pmdt069,0,pmds037,pmds038,",
               #160802-00036#2 -e
               " pmdt046,pmdt037,pmdt036,pmdt038,pmdt047,pmdt039,pmdt038,0,pmdt039, ", #150123-00003#2 albireo add pmdt038,pmdt047,pmdt039 
               " sumapcb103,sumapcb104,sumapcb105,",                                   #150123-00003#2 albireo add
               #" sfapcb103,sfapcb104,sfapcb105,",                                     #150123-00003#2 albireo add #160909-00015#1 Mark
               #161018-00037#1 mark ------
               ##160909-00015#1 Add  ---(S)---
               #"CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / pmdt066 * sfapcb103,",
               #"CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / pmdt066 * sfapcb104,",
               #"CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / pmdt066 * sfapcb105,",
               ##160909-00015#1 Add  ---(E)---
               #161018-00037#1 mark end---
               #161018-00037#1 add ------
               "CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / (CASE WHEN pmdt066 = 0 THEN 1 ELSE pmdt066 END) * sfapcb103,",
               "CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / (CASE WHEN pmdt066 = 0 THEN 1 ELSE pmdt066 END) * sfapcb104,",
               "CASE WHEN (pmdt066-apcfminus) < 0 OR (pmdt066-apcfminus) IS NULL THEN 0 ELSE (pmdt066-apcfminus) END / (CASE WHEN pmdt066 = 0 THEN 1 ELSE pmdt066 END) * sfapcb105,",
               #161018-00037#1 add end---
               #161206-00017#2-----s
               " 0, ",   
               #161206-00017#2-----e
               " apcb113,apcb114,apcb115,",     #150123-00003#2 albireo add
               " 0,0,0,",                       #150123-00003#2 albireo add
               #" pmdt0382,0,pmdt0392,'','' ",  #160414-00018#4 mark #150924-00012#1 add apcadocno #151019-00009#1 add apca2
               #160414-00018#4--s
               "  pmdt0382,0,pmdt0392, ",
               #170123-00045#1 --s mark
               #" (SELECT apcadocno FROM apca_t,apcb_t ",
               #"   WHERE apcaent = pmdtent AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               #"     AND apcald = '",g_input.apcald,"' AND apca001 NOT IN('01','02','03','04') ",
               #"     AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1 ",
               #"     AND apcastus <> 'X'), ",
               #" (SELECT apcadocno FROM apca_t,apcb_t ",
               #"   WHERE apcaent = pmdtent AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno ",
               #"     AND apcald = '",g_input.apcald,"' AND apca001 IN ('01','02','03','04') ",
               #"     AND apcb002 = pmdtdocno AND apcb003 = pmdtseq AND rownum = 1 ",
               #"     AND apcastus <> 'X') ",
               #170123-00045#1 --e mark
               " '','' ", #170123-00045#1 add
               #160414-00018#4--e
               " FROM (",
               " SELECT pmdtsite,pmds007,pmds000,pmdtdocno,pmdtseq,pmdt006,pmdt005,pmdt001,pmdt002,pmdt050,pmdt024, ",   #150902-00001#3 add pmdt002,pmdt050   #151102-00008#1 add pmdt005
               " pmdl002,pmdl003,pmds002,pmds003,pmdt016, ",                              #150128-00005#9 add
               " pmds011, ",  #160830-00008#1 add 
               " COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) apcb007, ",
               " ",l_field[l_ld_type].f21," pmdt066, ",
               " pmdt069,pmds037,pmds038,pmdt046,pmdt037,pmdt036,pmdt038,pmdt039, ",
               " pmdt038*pmds038 pmdt0382,pmdt039*pmds038 pmdt0392,pmdtent, ",     
               " pmds001, ",    #150106-00011#2 albireo add pmds001
               #" COALESCE(",l_field[l_ld_type].f31,",0) pmdt0562,COALESCE(apcfminus,0) apcfminus, ", #160414-00018#4 mark #150123-00003#2 albireo add
               " COALESCE(",l_field[l_ld_type].f31,",0) pmdt0562,",                                   #160414-00018#4
               #--160414-00018#4--s
               #暫估數量
               " COALESCE((SELECT SUM(apcb007) ",
               "   FROM apcb_t,apca_t ",
               "  WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "    AND apcastus = 'Y' AND apca001 NOT IN('01','02','03','04') ",
               "    AND apcb023 = 'Y'  AND apcald = '",g_input.apcald,"'",
               "    AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               "  GROUP BY apcbent,apcb002,apcb003 ",
               " ),0) apcfminus, ",
               #--160414-00018#4--e
               " pmdt047,COALESCE(",l_field[l_ld_type].f32,",0) sumapcb103,",
               " COALESCE(",l_field[l_ld_type].f33,",0) sumapcb104, ",
               " COALESCE(",l_field[l_ld_type].f34,",0) sumapcb105, ", #150123-00003#2 albireo add  
               #160909-00015#1 Mark ---(S)---
               ##" (COALESCE(sfapcb103a,0)-COALESCE(sfapcb103b,0)) sfapcb103, ",    #160414-00018#4 mark
               ##160414-00018#4--s
               #" (",
               ##暫估金額取得
               #" COALESCE(",
               #" (SELECT SUM(apcb103) FROM apcb_t,apca_t ",
               #"   WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               #"     AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               #"     AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               #"   GROUP BY apcbent,apcb002,apcb003 ),0)",
               ##已沖暫估量/金額取得
               #" - COALESCE(",
               #" (SELECT sum(apcf103) FROM apca_t a,apcf_t,apca_t b,apcb_t ",
               #"   WHERE a.apcald = apcfld AND a.apcaent = apcfent AND a.apcadocno = apcfdocno ",
               #"     AND a.apcastus = 'Y' ",
               #"     AND b.apcadocno = apcf008 ",
               #"     AND apcbseq = apcf009 ",
               #"     AND b.apcald = apcfld ",
               #"     AND b.apcaent = apcfent ",
               #"     AND b.apcaent = apcbent ",
               #"     AND b.apcald = apcbld ",
               #"     AND b.apcadocno = apcbdocno ",
               #"     AND b.apcastus = 'Y' ",
               #"     AND b.apca001 IN ('01','02','03','04') ",
               #"     AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               #"   GROUP BY apcb002,apcb003,apcbent ),0) ",    
               #"   ) sfapcb103, ",
               ##160414-00018#4--e
               #"              (COALESCE(sfapcb104a,0)-COALESCE(sfapcb104b,0)) sfapcb104, ",   #160414-00018#4 mark
               ##160414-00018#4--s
               #" (",
               ##暫估金額取得
               #" COALESCE(",
               #"  (SELECT SUM(apcb104) FROM apcb_t,apca_t ",
               #"    WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               #"      AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               #"      AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",                
               #" GROUP BY apcbent,apcb002,apcb003 ),0)",                
               ##已沖暫估量/金額取得
               #" - COALESCE(",
               #"    (SELECT sum(apcf104) FROM apca_t a,apcf_t,apca_t b,apcb_t ",
               #"      WHERE a.apcald = apcfld AND a.apcaent = apcfent AND a.apcadocno = apcfdocno ",
               #"        AND a.apcastus = 'Y' ",
               #"        AND b.apcadocno = apcf008 ",
               #"        AND apcbseq = apcf009 ",
               #"        AND b.apcald = apcfld ",
               #"        AND b.apcaent = apcfent ",
               #"        AND b.apcaent = apcbent ",
               #"        AND b.apcald = apcbld ",
               #"        AND b.apcadocno = apcbdocno ",
               #"        AND b.apcastus = 'Y' ",
               #"        AND b.apca001 IN ('01','02','03','04') ",
               #"        AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               #"      GROUP BY apcb002,apcb003,apcbent ),0) ",           
               #"   ) sfapcb104, ",
               ##160414-00018#4--e                    
               #"              (COALESCE(sfapcb105a,0)-COALESCE(sfapcb105b,0)) sfapcb105,  ",   #160414-00018#4 mark
               ##160414-00018#4--s               
               #" (",
               ##暫估金額取得
               #" COALESCE(",
               #"  (SELECT SUM(apcb105) FROM apcb_t,apca_t ",
               #"    WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               #"      AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               #"      AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",                
               #" GROUP BY apcbent,apcb002,apcb003 ),0)",                
               ##已沖暫估量/金額取得
               #" - COALESCE(",
               #"    (SELECT sum(apcf105) FROM apca_t a,apcf_t,apca_t b,apcb_t ",
               #"      WHERE a.apcald = apcfld AND a.apcaent = apcfent AND a.apcadocno = apcfdocno ",
               #"        AND a.apcastus = 'Y' ",
               #"        AND b.apcadocno = apcf008 ",
               #"        AND apcbseq = apcf009 ",
               #"        AND b.apcald = apcfld ",
               #"        AND b.apcaent = apcfent ",
               #"        AND b.apcaent = apcbent ",
               #"        AND b.apcald = apcbld ",
               #"        AND b.apcadocno = apcbdocno ",
               #"        AND b.apcastus = 'Y' ",
               #"        AND b.apca001 IN ('01','02','03','04') ",
               #"        AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
               #"      GROUP BY apcb002,apcb003,apcbent ),0) ",              
               #"   ) sfapcb105, ",
               #160909-00015#1 Mark ---(E)---
               #160909-00015#1 Add  ---(S)---
               #暫估金額取得
               " COALESCE(",
               " (SELECT SUM(apcb103) FROM apcb_t,apca_t ",
               "   WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "     AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               "     AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",                
               "   GROUP BY apcbent,apcb002,apcb003 ),0) sfapcb103, ",
               " COALESCE(",
               "  (SELECT SUM(apcb104) FROM apcb_t,apca_t ",
               "    WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "      AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               "      AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",                
               "    GROUP BY apcbent,apcb002,apcb003 ),0) sfapcb104, ",
               " COALESCE(",
               "  (SELECT SUM(apcb105) FROM apcb_t,apca_t ",
               "    WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "      AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               "      AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",                
               "    GROUP BY apcbent,apcb002,apcb003 ),0) sfapcb105, ",
               #160909-00015#1 Add  ---(E)---
               #160414-00018#4--e                  
               " COALESCE(apcb113,0) apcb113,COALESCE(apcb114,0) apcb114,COALESCE(apcb115,0) apcb115 ",
               " ,pmdt020 ",     #161206-00017#2
               " FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
               #150123-00003#2 albireo add-----s
               #立帳數量/金額取得
               " LEFT OUTER JOIN( ",
               "    SELECT apcbent,apcb002,apcb003,SUM(apcb007) pmdt0562, ",
               "           SUM(apcb103) sumapcb103,SUM(apcb104) sumapcb104,SUM(apcb105) sumapcb105,",
               "           SUM(apcb113) apcb113,SUM(apcb114) apcb114,SUM(apcb115) apcb115 ",
               "      FROM apcb_t,apca_t ",
               "     WHERE apcbent = apcaent ",
               "       AND apcbld  = apcald  ",
               "       AND apcbdocno = apcadocno ",
               "       AND apca001 IN ('13','17','22') ",
               "       AND apcastus <> 'X' ",
               "     GROUP BY apcbent,apcb002,apcb003 ",
               "                ) ON apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq " #,  #160414-00018#4 mark ,
               #160414-00018#4 mark--s    
               # #已沖暫估量/金額取得
               # "         LEFT OUTER JOIN( ",
               ##"            SELECT apcbent,apcb002,apcb003,SUM(apcf007) apcfminus, ",                             #150401-00010#1 Mark 
               # "            SELECT apcbent,apcb002,apcb003,0 apcfminus1, ",                                        #150401-00010#1
               # "                   sum(apcf103) sfapcb103b,sum(apcf104) sfapcb104b,sum(apcf105) sfapcb105b ",
               # "              FROM apca_t a,apcf_t,apca_t b,apcb_t ",
               # "             WHERE a.apcald = apcfld AND a.apcaent = apcfent AND a.apcadocno = apcfdocno ",
               # "               AND a.apcastus = 'Y' ",
               # "               AND b.apcadocno = apcf008 ",
               # "               AND apcbseq = apcf009 ",
               # "               AND b.apcald = apcfld ",
               # "               AND b.apcaent = apcfent ",
               # "               AND b.apcaent = apcbent ",
               # "               AND b.apcald = apcbld ",
               # "               AND b.apcadocno = apcbdocno ",
               # "               AND b.apcastus = 'Y' ",
               # "               AND b.apca001 IN ('01','02','03','04') ",
               # "             GROUP BY apcb002,apcb003,apcbent ",
               # "                          ) s2 ON s2.apcbent = pmdtent AND s2.apcb002 = pmdtdocno AND s2.apcb003 = pmdtseq " #,   #160414-00018#4 mark ,
               #160414-00018#4 mark--e
               #160414-00018#4 mark--s
               ##暫估金額取得
               #"         LEFT OUTER JOIN( ",
               #"             SELECT apcbent,apcb002,apcb003,SUM(apcb103) sfapcb103a,SUM(apcb104) sfapcb104a,SUM(apcb105) sfapcb105a ",
               #"               FROM apcb_t,apca_t ",
               #"              WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               #"                AND apcastus = 'Y' AND apca001 IN('01','02','03','04') ",
               #"              GROUP BY apcbent,apcb002,apcb003 ",               
               #"                        ) s3 ON s3.apcbent = pmdtent AND s3.apcb002 = pmdtdocno AND s3.apcb003 = pmdtseq "  #,   #160414-00018#4 mark ,
               #160414-00018#4 mark--e
               #160414-00018#4--s
               #IF g_prog = 'aapq140' THEN        #160705-00042#8 160712 by sakura mark
               IF g_prog MATCHES 'aapq140' THEN   #160705-00042#8 160712 by sakura add
                  LET g_sql = g_sql CLIPPED,
                  #160414-00018#4--e
                  #aapq140的立帳數量立帳金額
                  " LEFT OUTER JOIN( ",
                  "     SELECT apbaent,apba005,apba006,",
                  "            SUM(apba010) apba010,SUM(apba103) apba103,SUM(apba104) apba104,SUM(apba105) apba105 ",
                  "       FROM apba_t,apbb_t " ,
                  "      WHERE apbaent = apbbent ",
                  "        AND apbbstus = 'Y' ",
                  "        AND apbadocno = apbbdocno ",
                  "      GROUP BY apbaent,apba005,apba006 ",
                  "                ) s4 ON s4.apbaent = pmdtent AND s4.apba005 = pmdtdocno AND s4.apba006 = pmdtseq "  #,   #160414-00018#4 mark ,
                  #160414-00018#4--s
               END IF   
               LET g_sql = g_sql CLIPPED,
               #160414-00018#4--e
               #150123-00003#2 albireo add-----e
               #--160414-00018#4 mark--s
               #150401-00010#1 belle add-----s
               ##暫估數量
               #"         LEFT OUTER JOIN( ",
               #"             SELECT apcbent,apcb002,apcb003,SUM(apcb007) apcfminus ",
               #"               FROM apcb_t,apca_t ",
               #"              WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               #"                AND apcastus = 'Y' AND apca001 NOT IN('01','02','03','04') ",
               #"                AND apcb023 = 'Y'  AND apcald = '",g_input.apcald,"'",
               #"              GROUP BY apcbent,apcb002,apcb003 ",               
               #"                        ) s5 ON s5.apcbent = pmdtent AND s5.apcb002 = pmdtdocno AND s5.apcb003 = pmdtseq ",
               #150401-00010#1 belle add-----e
               #--160414-00018#4 mark--e
               " WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = '",g_enterprise,"' ", 
               "   AND pmdsdocno = pmdtdocno ",
               #"   AND pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','17','18','19','20') ", #150702-00001#1 mark  #150629-00038#1       #pmds000:SCC-2060
               "   AND pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
               "   AND pmdsstus = 'S' ",                         #只抓入庫/且過帳
               "   AND pmdsent= ? ",
               "   AND pmds011 NOT IN ('3') ", #161011-00015#1
               "   AND ",ls_wc CLIPPED,") "
   CASE g_input.type
      #未匹配
      WHEN '1'
         LET g_sql = g_sql,"WHERE apcb007 <> 0 "
      #已匹配
      WHEN '2'
         LET g_sql = g_sql,"WHERE apcb007 = 0 " 
      #全部
      WHEN '3'
         LET g_sql = g_sql,"WHERE 1 = 1 " 
      #已立暫估未立帳款
      WHEN '4'
         LET g_sql = g_sql,"WHERE apcb007 <> 0 AND (pmdt066 - apcfminus) > 0 "    #151102-00008#1
      #160802-00036#2 -s
      #未立暫估且未立帳
      WHEN '5'
         IF g_prog MATCHES 'aapq130' THEN LET g_sql = g_sql," WHERE CASE WHEN pmdt0562 IS NULL THEN 0 ELSE pmdt0562 END = 0 AND CASE WHEN pmdt066 IS NULL THEN 0 ELSE pmdt066 END = 0 " END IF
         IF g_prog MATCHES 'aapq140' THEN LET g_sql = g_sql," WHERE CASE WHEN pmdt069 IS NULL THEN 0 ELSE pmdt069 END = 0 AND CASE WHEN pmdt066 IS NULL THEN 0 ELSE pmdt066 END = 0 " END IF
      #160802-00036#2 -e
   END CASE
   IF g_input.wc2 <> " 1=1" THEN
      LET g_sql = g_sql," AND EXISTS(SELECT 1 FROM pmdl_t ",
                        " WHERE pmdlent ='",g_enterprise,"' ",
                        "   AND pmdldocno = pmdt001 ",
                        "   AND ",g_input.wc2,") "
   END IF
   
   #albireo 150106 141218-00011#11 -----s
   #aapq130要依單頭預設法人抓資料
   IF g_aapq130_arg = '1' THEN
      LET g_sql = g_sql CLIPPED,
                  " AND EXISTS( SELECT 1 FROM ooef_t WHERE ooefent = pmdtent AND ooef001 = pmdtsite AND ooef017 = '",g_apcacomp,"') "
   END IF
   #albireo 150106 141218-00011#11 -----e
   
   LET g_sql = g_sql," AND pmdtsite IS NOT NULL ",
                    #" AND pmds011 NOT IN ('3') ", #160830-00008#1 add #161011-00015#1 mark
                     " ORDER BY pmds000,pmdtdocno,pmdtseq "
   #170209-00025#1 add(s)
   LET l_sql2 = "SELECT COUNT(1) FROM (",g_sql,")"
   PREPARE b_fill_cnt_pre1 FROM l_sql2  #總筆數
   EXECUTE b_fill_cnt_pre1 USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre1
   #170209-00025#1 add(e)  
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq130_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq130_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmds_d[l_ac].sel,g_pmds_d[l_ac].pmdtsite,g_pmds_d[l_ac].pmds007,g_pmds_d[l_ac].pmds007_desc, 
       g_pmds_d[l_ac].pmds001,g_pmds_d[l_ac].l_pmds000,g_pmds_d[l_ac].pmdtdocno,g_pmds_d[l_ac].pmdtseq, 
       g_pmds_d[l_ac].pmdt006,g_pmds_d[l_ac].pmdt006_desc,g_pmds_d[l_ac].pmdt006_desc_1,g_pmds_d[l_ac].pmdt005, 
       g_pmds_d[l_ac].imag011,g_pmds_d[l_ac].imag011_desc,g_pmds_d[l_ac].apcb021,g_pmds_d[l_ac].apcb021_desc, 
       g_pmds_d[l_ac].pmdt001,g_pmds_d[l_ac].pmdt002,g_pmds_d[l_ac].pmdt050,g_pmds_d[l_ac].pmds002,g_pmds_d[l_ac].pmds002_desc, 
       g_pmds_d[l_ac].pmds003,g_pmds_d[l_ac].pmds003_desc,g_pmds_d[l_ac].pmdt016,g_pmds_d[l_ac].pmdt016_desc, 
       g_pmds_d[l_ac].pmdt020,g_pmds_d[l_ac].pmdt024,g_pmds_d[l_ac].apcb007,g_pmds_d[l_ac].pmdt056,g_pmds_d[l_ac].pmdt066, 
       g_pmds_d[l_ac].pmdt069,g_pmds_d[l_ac].l_diffqty,g_pmds_d[l_ac].pmds037,g_pmds_d[l_ac].pmds038, 
       g_pmds_d[l_ac].pmdt046,g_pmds_d[l_ac].pmdt037,g_pmds_d[l_ac].pmdt036,g_pmds_d[l_ac].l_pmdt0383, 
       g_pmds_d[l_ac].l_pmdt0473,g_pmds_d[l_ac].l_pmdt0393,g_pmds_d[l_ac].pmdt038,g_pmds_d[l_ac].l_pmdt047, 
       g_pmds_d[l_ac].pmdt039,g_pmds_d[l_ac].l_sumapcb103,g_pmds_d[l_ac].l_sumapcb104,g_pmds_d[l_ac].l_sumapcb105, 
       g_pmds_d[l_ac].l_sfapcb103,g_pmds_d[l_ac].l_sfapcb104,g_pmds_d[l_ac].l_sfapcb105,g_pmds_d[l_ac].l_apca101, 
       g_pmds_d[l_ac].l_apcb113,g_pmds_d[l_ac].l_apcb114,g_pmds_d[l_ac].l_apcb115,g_pmds_d[l_ac].l_dapcb103, 
       g_pmds_d[l_ac].l_dapcb104,g_pmds_d[l_ac].l_dapcb105,g_pmds_d[l_ac].l_pmdt0382,g_pmds_d[l_ac].l_pmdt0472, 
       g_pmds_d[l_ac].l_pmdt0392,g_pmds_d[l_ac].apcadocno,g_pmds_d[l_ac].apca2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160414-00018#4 mark--s
      ##150924-00012#1-----s
      ##增加應付帳款單號
      #SELECT apcadocno INTO g_pmds_d[l_ac].apcadocno
      #  FROM apca_t,apcb_t 
      # WHERE apcaent = g_enterprise AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno
      #   AND apcald = g_input.apcald AND apca001 NOT IN('01','02','03','04')
      #   AND apcb002 = g_pmds_d[l_ac].pmdtdocno AND apcb003 = g_pmds_d[l_ac].pmdtseq AND rownum = 1
      #   AND apcastus <> 'X' #151019-00009#1 排除作廢單
      ##150924-00012#1-----e
      
      ##151019-00009#1-----s
      ##增加暫估單號
      #SELECT apcadocno INTO g_pmds_d[l_ac].apca2
      #  FROM apca_t,apcb_t 
      # WHERE apcaent = g_enterprise AND apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno
      #   AND apcald = g_input.apcald AND apca001 IN ('01','02','03','04')
      #   AND apcb002 = g_pmds_d[l_ac].pmdtdocno AND apcb003 = g_pmds_d[l_ac].pmdtseq AND rownum = 1
      #   AND apcastus <> 'X'
      ##151019-00009#1-----e
      
      ##151102-00008#1---s
      #LET g_pmds_d[l_ac].apcb021 = ''
      #LET g_pmds_d[l_ac].apcb021_desc = ''
      #SELECT apcb021 INTO g_pmds_d[l_ac].apcb021 FROM apca_t 
      #  LEFT OUTER JOIN apcb_t ON apcbent = apcaent AND apcbld = apcald AND apcbdocno = apcadocno AND apcb023 <> 'Y'
      # WHERE apcaent = g_enterprise AND apcald = g_input.apcald AND apcastus <> 'X'
      #   AND apcb002 = g_pmds_d[l_ac].pmdtdocno AND apcb003 = g_pmds_d[l_ac].pmdtseq AND rownum = 1
      #LET g_pmds_d[l_ac].apcb021_desc = s_desc_get_account_desc(g_input.apcald,g_pmds_d[l_ac].apcb021)      
      ##成本分群
      #SELECT imag011 INTO g_pmds_d[l_ac].imag011 FROM imag_t WHERE imagent = g_enterprise
      #   AND imagsite = g_apcacomp
      #   AND imag001 = g_pmds_d[l_ac].pmdt006
      #LET g_pmds_d[l_ac].imag011_desc = s_desc_get_acc_desc('206',g_pmds_d[l_ac].imag011)      
      ##151102-00008#1---e
      #160414-00018#4 mark--e

      
      
      
      
      #albireo 150106 141218-00011#11 MARK -----s
      ##入庫單所屬法人/帳套與帳務中心所屬法人/帳套不同者剔除
      #CALL s_fin_orga_get_comp_ld(g_pmds_d[l_ac].pmdtsite) RETURNING g_sub_success,g_errno,l_pmdtcomp,l_pmdtld
      #IF l_pmdtcomp <> g_apcacomp OR l_pmdtld <> g_input.apcald THEN
      #   CALL g_pmds_d.deleteElement(l_ac)
      #   CONTINUE FOREACH
      #END IF      
      
      #MARK原因
      #1.所屬法人必須依照單頭顯示法人抓取改到主sql與單頭單號中
      #2.不需比較帳別,因其可以設定為帳務中心底下法人的非主帳套
      #EX.
      #帳務中心X
      #    -A法人
      #          -A1帳(主帳套)
      #          -A2帳
      #    -B法人
      #          -B1
      #    -C法人
      #          -C1
      # 若aapq130設定  帳務中心X   A2帳    A法人
      # 此時會因為不為主帳套資料被篩掉
      #albireo 150106 141218-00011#11 MARK-----e
      
       #170123-00045#1 --s add
       #費用科目
       LET g_pmds_d[l_ac].apcb021 = ''
       OPEN aapr130_apcb021c USING g_pmds_d[l_ac].pmdtdocno,g_pmds_d[l_ac].pmdtseq
       FETCH FIRST aapr130_apcb021c INTO g_pmds_d[l_ac].apcb021
       CLOSE aapr130_apcb021c      
       
       #科目說明
       LET g_pmds_d[l_ac].apcb021_desc = ''
       OPEN aapr130_apcb021dc USING g_pmds_d[l_ac].pmdtdocno,g_pmds_d[l_ac].pmdtseq
       FETCH FIRST aapr130_apcb021dc INTO g_pmds_d[l_ac].apcb021_desc
       CLOSE aapr130_apcb021dc      
       
       #應付帳款單號
       LET g_pmds_d[l_ac].apcadocno = ''
       OPEN aapr130_docno1c USING g_pmds_d[l_ac].pmdtdocno,g_pmds_d[l_ac].pmdtseq
       FETCH FIRST aapr130_docno1c INTO g_pmds_d[l_ac].apcadocno
       CLOSE aapr130_docno1c      
       
       #帳款單號
       LET g_pmds_d[l_ac].apca2 = ''
       OPEN aapr130_docno2c USING g_pmds_d[l_ac].pmdtdocno,g_pmds_d[l_ac].pmdtseq
       FETCH FIRST aapr130_docno2c INTO g_pmds_d[l_ac].apca2
       CLOSE aapr130_docno2c         
       #170123-00045#1 --e add        
      
      #albireo 150129-----s
      #aapq140不用這些欄位所以給0,避免後續計算錯誤
      #立帳數量,暫估數量,暫估金額,立帳本幣額 = 0
      IF l_ld_type = 4 THEN
         LET g_pmds_d[l_ac].l_sfapcb103 = 0
         LET g_pmds_d[l_ac].l_sfapcb104 = 0
         LET g_pmds_d[l_ac].l_sfapcb105 = 0  
         LET g_pmds_d[l_ac].l_apcb113   = 0
         LET g_pmds_d[l_ac].l_apcb114   = 0
         LET g_pmds_d[l_ac].l_apcb115   = 0
         LET g_pmds_d[l_ac].pmdt056     = 0
         LET g_pmds_d[l_ac].pmdt066     = 0
      END IF
      #albireo 150129-----e
      
      #計價數量 <> 未匹配數量才重計金額
      IF g_pmds_d[l_ac].pmdt024 <> g_pmds_d[l_ac].apcb007 THEN
         #金額 = 數量 * 單價
         LET g_pmds_d[l_ac].pmdt038 = g_pmds_d[l_ac].apcb007 * g_pmds_d[l_ac].pmdt036
         CALL s_tax_count(g_apcacomp,g_pmds_d[l_ac].pmdt046,g_pmds_d[l_ac].pmdt038,g_pmds_d[l_ac].apcb007,g_pmds_d[l_ac].pmds037,g_pmds_d[l_ac].pmds038)
              RETURNING g_pmds_d[l_ac].pmdt038,l_nouse,g_pmds_d[l_ac].pmdt039,
                        g_pmds_d[l_ac].l_pmdt0382,l_nouse,g_pmds_d[l_ac].l_pmdt0392       
      END IF
      
      #albireo 150129-----s
      #SA提醒前端可能把尾差攤到單身去,因此要讓計算一致
      #所以當計價數量=未匹配數量時
      #要把入庫金額帶入未匹配金額
      IF g_pmds_d[l_ac].pmdt024 = g_pmds_d[l_ac].apcb007 THEN
         LET g_pmds_d[l_ac].pmdt038   =  g_pmds_d[l_ac].l_pmdt0383 
         LET g_pmds_d[l_ac].l_pmdt047 =  g_pmds_d[l_ac].l_pmdt0473
         LET g_pmds_d[l_ac].pmdt039   =  g_pmds_d[l_ac].l_pmdt0393
      END IF
      #albireo 150129-----e
   
      #本幣未稅金額取位
      IF cl_null(g_pmds_d[l_ac].l_pmdt0382) THEN LET g_pmds_d[l_ac].l_pmdt0382 = 0 END IF
      IF NOT cl_null(g_input.apcald) AND NOT cl_null(l_glaa001)THEN
         CALL s_curr_round_ld('1',g_input.apcald,l_glaa001,g_pmds_d[l_ac].l_pmdt0382,2) RETURNING g_sub_success,g_errno,g_pmds_d[l_ac].l_pmdt0382      
      END IF
      #本幣含稅金額取位
      IF cl_null(g_pmds_d[l_ac].l_pmdt0392) THEN LET g_pmds_d[l_ac].l_pmdt0392 = 0 END IF
      IF NOT cl_null(g_input.apcald) AND NOT cl_null(l_glaa001) THEN
         CALL s_curr_round_ld('1',g_input.apcald,l_glaa001,g_pmds_d[l_ac].l_pmdt0392,2) RETURNING g_sub_success,g_errno,g_pmds_d[l_ac].l_pmdt0392    
      END IF
 
      LET g_pmds_d[l_ac].l_pmdt047 = g_pmds_d[l_ac].pmdt039 - g_pmds_d[l_ac].pmdt038
      LET g_pmds_d[l_ac].l_pmdt0472 = g_pmds_d[l_ac].l_pmdt0392 - g_pmds_d[l_ac].l_pmdt0382
      #入庫單性質為7:倉退單者,數量及金額以負數呈現
     #IF g_pmds_d[l_ac].pmds000 = '7' OR g_pmds_d[l_ac].pmds000 MATCHES '1[459]' THEN   #150702-00001#1 mark  #albireo 150630 add 19
    #IF s_aap_pmds000_chk('3',g_pmds_d[l_ac].l_pmds000) THEN                            #160414-00018#4 mark   #150702-00001#1   #151106-00002#4 151119 by sakura pmds000-->l_pmds000
     IF aapq130_pmds000_chk('3',g_pmds_d[l_ac].l_pmds000) THEN                          #160414-00018#4 
         LET g_pmds_d[l_ac].pmdt024 = g_pmds_d[l_ac].pmdt024 * -1
         LET g_pmds_d[l_ac].apcb007 = g_pmds_d[l_ac].apcb007 * -1
         LET g_pmds_d[l_ac].pmdt066 = g_pmds_d[l_ac].pmdt066 * -1
         LET g_pmds_d[l_ac].pmdt069 = g_pmds_d[l_ac].pmdt069 * -1
         LET g_pmds_d[l_ac].pmdt038 = g_pmds_d[l_ac].pmdt038 * -1
         LET g_pmds_d[l_ac].l_pmdt047 = g_pmds_d[l_ac].l_pmdt047 * -1
         LET g_pmds_d[l_ac].pmdt039 = g_pmds_d[l_ac].pmdt039 * -1
         LET g_pmds_d[l_ac].l_pmdt0382 = g_pmds_d[l_ac].l_pmdt0382 * -1
         LET g_pmds_d[l_ac].l_pmdt0472 = g_pmds_d[l_ac].l_pmdt0472 * -1
         LET g_pmds_d[l_ac].l_pmdt0392 = g_pmds_d[l_ac].l_pmdt0392 * -1    
         #150123-00003#2 albireo add-----s
         LET g_pmds_d[l_ac].pmdt056    =  g_pmds_d[l_ac].pmdt056 * -1
         LET g_pmds_d[l_ac].l_pmdt0383 = g_pmds_d[l_ac].l_pmdt0383 * -1
         LET g_pmds_d[l_ac].l_pmdt0473 = g_pmds_d[l_ac].l_pmdt0473 * -1
         LET g_pmds_d[l_ac].l_pmdt0393 = g_pmds_d[l_ac].l_pmdt0393 * -1 
         LET g_pmds_d[l_ac].l_sumapcb103 = g_pmds_d[l_ac].l_sumapcb103 * -1
         LET g_pmds_d[l_ac].l_sumapcb104= g_pmds_d[l_ac].l_sumapcb104 * -1
        #LET g_pmds_d[l_ac].l_sumapcb105 = g_pmds_d[l_ac].l_sfapcb105 * -1  
         LET g_pmds_d[l_ac].l_sumapcb105 = g_pmds_d[l_ac].l_sumapcb105 * -1   #Belle 150215 Modi
         LET g_pmds_d[l_ac].l_sfapcb103 = g_pmds_d[l_ac].l_sfapcb103 * -1
         LET g_pmds_d[l_ac].l_sfapcb104= g_pmds_d[l_ac].l_sfapcb104 * -1
         LET g_pmds_d[l_ac].l_sfapcb105 = g_pmds_d[l_ac].l_sfapcb105 * -1  
         LET g_pmds_d[l_ac].l_apcb113 = g_pmds_d[l_ac].l_apcb113 * -1
         LET g_pmds_d[l_ac].l_apcb114= g_pmds_d[l_ac].l_apcb114 * -1
         LET g_pmds_d[l_ac].l_apcb115 = g_pmds_d[l_ac].l_apcb115 * -1          
         #150123-00003#2 albireo add-----e
      END IF 
      IF l_pmdtdocno_t <> g_pmds_d[l_ac].pmdtdocno AND g_input.sumshow = 'Y' THEN  #150123-00003#2  150128 By albireo add sumshow
         INITIALIZE l_tmp TO NULL
         #160414-00018#4 mark--s
         #SELECT SUM(pmdt024),SUM(apcb007),SUM(pmdt066),SUM(pmdt069),SUM(pmdt038),
         #       SUM(l_pmdt047),SUM(pmdt039),SUM(l_pmdt0382),SUM(l_pmdt0472),SUM(l_pmdt0392),
         #       SUM(pmdt0562),SUM(l_pmdt0383),SUM(l_pmdt0473),SUM(l_pmdt0393),     #150123-00003#2 albireo add
         #       SUM(sumapcb103),SUM(sumapcb104),SUM(sumapcb105),                   #150123-00003#2 albireo add
         #       SUM(sfapcb103),SUM(sfapcb104),SUM(sfapcb105),                      #150123-00003#2 albireo add
         #       SUM(apcb113),SUM(apcb114),SUM(apcb115),                            #150123-00003#2 albireo add
         #       SUM(dapcb103),SUM(dapcb104),SUM(dapcb105)                          #150123-00003#2 albireo add
         #160414-00018#4 mark--e
         EXECUTE aapq130_sel_tmp USING l_pmdtdocno_t   #160414-00018#4           
           INTO l_tmp.pmdt024,l_tmp.apcb007,l_tmp.pmdt066,l_tmp.pmdt069,l_tmp.pmdt038,
                l_tmp.l_pmdt047,l_tmp.pmdt039,l_tmp.l_pmdt0382,l_tmp.l_pmdt0472,l_tmp.l_pmdt0392,
                l_tmp.pmdt056,l_tmp.l_pmdt0383,l_tmp.l_pmdt0473,l_tmp.l_pmdt0393,  #150123-00003#2 albireo add
                l_tmp.l_sumapcb103,l_tmp.l_sumapcb104,l_tmp.l_sumapcb105,          #150123-00003#2 albireo add
                l_tmp.l_sfapcb103,l_tmp.l_sfapcb104,l_tmp.l_sfapcb105,             #150123-00003#2 albireo add
                l_tmp.l_apcb113,l_tmp.l_apcb114,l_tmp.l_apcb115,                   #150123-00003#2 albireo add
                l_tmp.l_dapcb103,l_tmp.l_dapcb104,l_tmp.l_dapcb105                 #150123-00003#2 albireo add
          # FROM aapq130_tmp                   #160414-00018#4 mark
          #WHERE pmdtdocno = l_pmdtdocno_t     #160414-00018#4 mark

           #LET l_tmp.pmdtdocno = cl_getmsg('aap-00287',g_lang)   #161205-00025#18 mark
           LET l_tmp.pmdtdocno = l_msg1     #161205-00025#18
           LET l_tmp.pmdtseq = ' '
         #160802-00036#2 mark ------
         ##150123-00003#2 albireo add-----s
         ##差異數量
         #LET l_tmp.l_diffqty = l_tmp.pmdt024 - l_tmp.apcb007 
         #                      - l_tmp.pmdt056 - l_tmp.pmdt066
         ##150123-00003#2 albireo add-----e
         #160802-00036#2 mark end---
        #INSERT INTO aapq130_tmp VALUES(l_tmp.*,l_odr)   #160414-00018#4 mark
         EXECUTE aapq130_ins_tmp USING l_tmp.*,l_odr     #160414-00018#4
         LET l_odr = l_odr + 1

      END IF
      #150123-00003#2 albireo add-----s
      #160802-00036#2 mark ------
      ##差異數量
      #LET g_pmds_d[l_ac].l_diffqty = g_pmds_d[l_ac].pmdt024 - g_pmds_d[l_ac].apcb007 
      #                               - g_pmds_d[l_ac].pmdt056 - g_pmds_d[l_ac].pmdt066
      #160802-00036#2 mark end---
      #160802-00036#2 add ------
      #差異數量
      CASE
         WHEN g_prog MATCHES 'aapq130'
            #aapq130 差異數量 = 計價數量(pmdt024)-立帳數量(pmdt056)-未沖暫估數量
            LET g_pmds_d[l_ac].l_diffqty = g_pmds_d[l_ac].pmdt024 - g_pmds_d[l_ac].pmdt056 - g_pmds_d[l_ac].pmdt066
         WHEN g_prog MATCHES 'aapq140'
            #aapq140 差異數量 = 計價數量(pmdt024)-對帳數量(pmdt069)-未沖暫估數量
            LET g_pmds_d[l_ac].l_diffqty = g_pmds_d[l_ac].pmdt024 - g_pmds_d[l_ac].pmdt069 - g_pmds_d[l_ac].pmdt066
      END CASE
      #160802-00036#2 add end---
      #差異金額
      #入库金额－未批配金额－正常立账金额－暂估立账金额
      LET g_pmds_d[l_ac].l_dapcb103 = g_pmds_d[l_ac].l_pmdt0383 - g_pmds_d[l_ac].pmdt038 
                                     - g_pmds_d[l_ac].l_sumapcb103 - g_pmds_d[l_ac].l_sfapcb103
      LET g_pmds_d[l_ac].l_dapcb104 = g_pmds_d[l_ac].l_pmdt0473 - g_pmds_d[l_ac].l_pmdt047 
                                     - g_pmds_d[l_ac].l_sumapcb104 - g_pmds_d[l_ac].l_sfapcb104
      LET g_pmds_d[l_ac].l_dapcb105 = g_pmds_d[l_ac].l_pmdt0393 - g_pmds_d[l_ac].pmdt039 
                                     - g_pmds_d[l_ac].l_sumapcb105 - g_pmds_d[l_ac].l_sfapcb105                                     
      #150123-00003#2 albireo add-----e
      #150902-00001#3--s
      #入庫情形取pmdw
     #IF s_aap_pmds000_chk('2',g_pmds_d[l_ac].l_pmds000) THEN   #160414-00018#4 mark   #151106-00002#4 151119 by sakura pmds000-->l_pmds000
      IF aapq130_pmds000_chk('2',g_pmds_d[l_ac].l_pmds000) THEN #160414-00018#4 
         IF g_pmds_d[l_ac].l_pmds000 MATCHES '[34]' OR g_pmds_d[l_ac].l_pmds000 = '20' THEN   #151106-00002#4 151119 by sakura pmds000-->l_pmds000
            LET l_pmdwdocno = g_pmds_d[l_ac].pmdtdocno
         ELSE
            #160414-00018#4 mark--s
            #SELECT pmds006 INTO l_pmdwdocno
            #  FROM pmds_t
            # WHERE pmdsent = g_enterprise
            #   AND pmdsdocno = g_pmds_d[l_ac].pmdtdocno
            #160414-00018#4 mark--e
            EXECUTE aapq130_sel_pmds006 USING g_pmds_d[l_ac].pmdtdocno INTO l_pmdwdocno   #160414-00018#4
         END IF         
         LET g_pmds_d[l_ac].pmdt050 = ''
         #160414-00018#4 mark--s
         #SELECT pmdw010 INTO g_pmds_d[l_ac].pmdt050
         #  FROM pmdw_t
         # WHERE pmdwent = g_enterprise
         #   AND pmdwdocno = l_pmdwdocno
         #160414-00018#4 mark--e
         EXECUTE aapq130_sel_pmdw010 USING l_pmdwdocno INTO g_pmds_d[l_ac].pmdt050   #160414-00018#4
      END IF
      #150902-00001#3--e      
 
      #161206-00017#2-----s
      IF NOT cl_null(g_pmds_d[l_ac].apcadocno)THEN
         SELECT DISTINCT apca101 INTO g_pmds_d[l_ac].l_apca101 FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcadocno = g_pmds_d[l_ac].apcadocno
      END IF
      #161206-00017#2-----e

 
     #INSERT INTO aapq130_tmp VALUES(g_pmds_d[l_ac].*,l_odr)   #160414-00018#4 mark
      EXECUTE aapq130_ins_tmp USING g_pmds_d[l_ac].*,l_odr     #160414-00018#4
      LET l_odr = l_odr + 1
      LET l_pmdtdocno_t = g_pmds_d[l_ac].pmdtdocno      
      
      #end add-point
 
      CALL aapq130_detail_show("'1'")
 
      CALL aapq130_pmds_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #最後一筆資料須在foreach外做小計
   IF l_ac > 1 AND g_input.sumshow = 'Y' THEN
      INITIALIZE l_tmp TO NULL
      SELECT SUM(pmdt024),SUM(apcb007),SUM(pmdt066),SUM(pmdt069),SUM(pmdt038),
             SUM(l_pmdt047),SUM(pmdt039),SUM(l_pmdt0382),SUM(l_pmdt0472),SUM(l_pmdt0392),
             SUM(pmdt0562),SUM(l_pmdt0383),SUM(l_pmdt0473),SUM(l_pmdt0393),     #150123-00003#2 albireo add
             SUM(sumapcb103),SUM(sumapcb104),SUM(sumapcb105),                   #150123-00003#2 albireo add
             SUM(sfapcb103),SUM(sfapcb104),SUM(sfapcb105),                      #150123-00003#2 albireo add
             SUM(apcb113),SUM(apcb114),SUM(apcb115),                            #150123-00003#2 albireo add
             SUM(dapcb103),SUM(dapcb104),SUM(dapcb105)                          #150123-00003#2 albireo add
        INTO l_tmp.pmdt024,l_tmp.apcb007,l_tmp.pmdt066,l_tmp.pmdt069,l_tmp.pmdt038,
             l_tmp.l_pmdt047,l_tmp.pmdt039,l_tmp.l_pmdt0382,l_tmp.l_pmdt0472,l_tmp.l_pmdt0392,
             l_tmp.pmdt056,l_tmp.l_pmdt0383,l_tmp.l_pmdt0473,l_tmp.l_pmdt0393,  #150123-00003#2 albireo add
             l_tmp.l_sumapcb103,l_tmp.l_sumapcb104,l_tmp.l_sumapcb105,          #150123-00003#2 albireo add
             l_tmp.l_sfapcb103,l_tmp.l_sfapcb104,l_tmp.l_sfapcb105,             #150123-00003#2 albireo add
             l_tmp.l_apcb113,l_tmp.l_apcb114,l_tmp.l_apcb115,                   #150123-00003#2 albireo add
             l_tmp.l_dapcb103,l_tmp.l_dapcb104,l_tmp.l_dapcb105                 #150123-00003#2 albireo add
        FROM aapq130_tmp
       WHERE pmdtdocno = l_pmdtdocno_t 
        LET l_tmp.pmdtdocno = cl_getmsg('aap-00287',g_lang)
        LET l_tmp.pmdtseq = ' '
      #150123-00003#2 albireo add-----s
      #差異數量
      LET l_tmp.l_diffqty = l_tmp.pmdt024 - l_tmp.apcb007 
                               - l_tmp.pmdt056 - l_tmp.pmdt066
      #150123-00003#2 albireo add-----e
     #INSERT INTO aapq130_tmp VALUES(l_tmp.*,l_odr)   #160414-00018#4 mark
      EXECUTE aapq130_ins_tmp USING l_tmp.*,l_odr     #160414-00018#4      
   END IF
   CALL g_pmds_d.clear()
   LET l_ac = 1

   LET g_sql = " SELECT * FROM aapq130_tmp ORDER BY odr"

   PREPARE aapq130_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aapq130_pb2
 
 
   FOREACH b_fill_curs2 INTO g_pmds_d[l_ac].*
      CALL aapq130_detail_show("'1'")
 
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
   #end add-point
 
   CALL g_pmds_d.deleteElement(g_pmds_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #若無資料則顯示訊息"無符合的資料" #150210-00009#3
   IF l_ac = 1  AND g_ask = "Y" THEN
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   LET g_ask = "Y"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmds_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aapq130_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq130_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq130_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmds_d.getLength() > 0 THEN
      CALL aapq130_b_fill2()
   END IF
 
      CALL aapq130_filter_show('pmds007','b_pmds007')
   CALL aapq130_filter_show('pmds001','b_pmds001')
   CALL aapq130_filter_show('pmdtdocno','b_pmdtdocno')
   CALL aapq130_filter_show('pmdtseq','b_pmdtseq')
   CALL aapq130_filter_show('pmdt006','b_pmdt006')
   CALL aapq130_filter_show('pmdt005','b_pmdt005')
   CALL aapq130_filter_show('imag011','b_imag011')
   CALL aapq130_filter_show('apcb021','b_apcb021')
   CALL aapq130_filter_show('pmdt001','b_pmdt001')
   CALL aapq130_filter_show('pmdt002','b_pmdt002')
   CALL aapq130_filter_show('pmdt050','b_pmdt050')
   CALL aapq130_filter_show('pmdt016','b_pmdt016')
   CALL aapq130_filter_show('pmdt020','b_pmdt020')
   CALL aapq130_filter_show('pmdt024','b_pmdt024')
   CALL aapq130_filter_show('apcb007','b_apcb007')
   CALL aapq130_filter_show('pmdt056','b_pmdt056')
   CALL aapq130_filter_show('pmdt066','b_pmdt066')
   CALL aapq130_filter_show('pmdt069','b_pmdt069')
   CALL aapq130_filter_show('pmds037','b_pmds037')
   CALL aapq130_filter_show('pmds038','b_pmds038')
   CALL aapq130_filter_show('pmdt046','b_pmdt046')
   CALL aapq130_filter_show('pmdt037','b_pmdt037')
   CALL aapq130_filter_show('pmdt036','b_pmdt036')
   CALL aapq130_filter_show('apcadocno','b_apcadocno')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq130_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq130_detail_show(ps_page)
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
           #160414-00018#4 mark--s
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_pmds_d[l_ac].pmds007
           #LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_pmds_d[l_ac].pmds007_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds007_desc
           

           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_pmds_d[l_ac].pmdt006
           #LET ls_sql = "SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_pmds_d[l_ac].pmdt006_desc = '', g_rtn_fields[1] , ''
           #LET g_pmds_d[l_ac].pmdt006_desc_1 = '', g_rtn_fields[2] , ''
           #DISPLAY BY NAME g_pmds_d[l_ac].pmdt006_desc,g_pmds_d[l_ac].pmdt006_desc_1
           #160414-00018#4 mark--e
            
            #150128-00005#9-str--
           #160414-00018#4 mark--s
           ##人員
           #CALL s_desc_get_person_desc(g_pmds_d[l_ac].pmds002) RETURNING g_pmds_d[l_ac].pmds002_desc
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds002_desc
           #
           ##部門
           #CALL s_desc_get_department_desc(g_pmds_d[l_ac].pmds003) RETURNING g_pmds_d[l_ac].pmds003_desc
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds003_desc    
           ##倉庫
           #LET g_pmds_d[l_ac].pmdt016_desc = s_desc_get_stock_desc(g_input.apcasite,g_pmds_d[l_ac].pmdt016)
           #DISPLAY BY NAME g_pmds_d[l_ac].pmdt016_desc           
           #160414-00018#4 mark--e            

            #150128-00005#9-end--

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aapq130_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_wc_form        STRING   #151201
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON pmds007,pmds001,pmdtdocno,pmdtseq,pmdt006,pmdt005,imag011,apcb021,pmdt001, 
          pmdt002,pmdt050,pmdt016,pmdt020,pmdt024,apcb007,pmdt056,pmdt066,pmdt069,pmds037,pmds038,pmdt046, 
          pmdt037,pmdt036,apcadocno
                          FROM s_detail1[1].b_pmds007,s_detail1[1].b_pmds001,s_detail1[1].b_pmdtdocno, 
                              s_detail1[1].b_pmdtseq,s_detail1[1].b_pmdt006,s_detail1[1].b_pmdt005,s_detail1[1].b_imag011, 
                              s_detail1[1].b_apcb021,s_detail1[1].b_pmdt001,s_detail1[1].b_pmdt002,s_detail1[1].b_pmdt050, 
                              s_detail1[1].b_pmdt016,s_detail1[1].b_pmdt020,s_detail1[1].b_pmdt024,s_detail1[1].b_apcb007, 
                              s_detail1[1].b_pmdt056,s_detail1[1].b_pmdt066,s_detail1[1].b_pmdt069,s_detail1[1].b_pmds037, 
                              s_detail1[1].b_pmds038,s_detail1[1].b_pmdt046,s_detail1[1].b_pmdt037,s_detail1[1].b_pmdt036, 
                              s_detail1[1].b_apcadocno
 
         BEFORE CONSTRUCT
                     DISPLAY aapq130_filter_parser('pmds007') TO s_detail1[1].b_pmds007
            DISPLAY aapq130_filter_parser('pmds001') TO s_detail1[1].b_pmds001
            DISPLAY aapq130_filter_parser('pmdtdocno') TO s_detail1[1].b_pmdtdocno
            DISPLAY aapq130_filter_parser('pmdtseq') TO s_detail1[1].b_pmdtseq
            DISPLAY aapq130_filter_parser('pmdt006') TO s_detail1[1].b_pmdt006
            DISPLAY aapq130_filter_parser('pmdt005') TO s_detail1[1].b_pmdt005
            DISPLAY aapq130_filter_parser('imag011') TO s_detail1[1].b_imag011
            DISPLAY aapq130_filter_parser('apcb021') TO s_detail1[1].b_apcb021
            DISPLAY aapq130_filter_parser('pmdt001') TO s_detail1[1].b_pmdt001
            DISPLAY aapq130_filter_parser('pmdt002') TO s_detail1[1].b_pmdt002
            DISPLAY aapq130_filter_parser('pmdt050') TO s_detail1[1].b_pmdt050
            DISPLAY aapq130_filter_parser('pmdt016') TO s_detail1[1].b_pmdt016
            DISPLAY aapq130_filter_parser('pmdt020') TO s_detail1[1].b_pmdt020
            DISPLAY aapq130_filter_parser('pmdt024') TO s_detail1[1].b_pmdt024
            DISPLAY aapq130_filter_parser('apcb007') TO s_detail1[1].b_apcb007
            DISPLAY aapq130_filter_parser('pmdt056') TO s_detail1[1].b_pmdt056
            DISPLAY aapq130_filter_parser('pmdt066') TO s_detail1[1].b_pmdt066
            DISPLAY aapq130_filter_parser('pmdt069') TO s_detail1[1].b_pmdt069
            DISPLAY aapq130_filter_parser('pmds037') TO s_detail1[1].b_pmds037
            DISPLAY aapq130_filter_parser('pmds038') TO s_detail1[1].b_pmds038
            DISPLAY aapq130_filter_parser('pmdt046') TO s_detail1[1].b_pmdt046
            DISPLAY aapq130_filter_parser('pmdt037') TO s_detail1[1].b_pmdt037
            DISPLAY aapq130_filter_parser('pmdt036') TO s_detail1[1].b_pmdt036
            DISPLAY aapq130_filter_parser('apcadocno') TO s_detail1[1].b_apcadocno
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdtsite>>----
         #----<<b_pmds007>>----
         #Ctrlp:construct.c.page1.b_pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds007
            #add-point:ON ACTION controlp INFIELD b_pmds007 name="construct.c.filter.page1.b_pmds007"
            #交易對象
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_input.apcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
            LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO b_pmds007
            NEXT FIELD b_pmds007
            #END add-point
 
 
         #----<<b_pmds007_desc>>----
         #----<<b_pmds001>>----
         #Ctrlp:construct.c.filter.page1.b_pmds001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds001
            #add-point:ON ACTION controlp INFIELD b_pmds001 name="construct.c.filter.page1.b_pmds001"
            
            #END add-point
 
 
         #----<<l_pmds000>>----
         #----<<b_pmdtdocno>>----
         #Ctrlp:construct.c.filter.page1.b_pmdtdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtdocno
            #add-point:ON ACTION controlp INFIELD b_pmdtdocno name="construct.c.filter.page1.b_pmdtdocno"
            
            #END add-point
 
 
         #----<<b_pmdtseq>>----
         #Ctrlp:construct.c.filter.page1.b_pmdtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdtseq
            #add-point:ON ACTION controlp INFIELD b_pmdtseq name="construct.c.filter.page1.b_pmdtseq"
            
            #END add-point
 
 
         #----<<b_pmdt006>>----
         #Ctrlp:construct.c.page1.b_pmdt006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt006
            #add-point:ON ACTION controlp INFIELD b_pmdt006 name="construct.c.filter.page1.b_pmdt006"
            #產品編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_imaf001() #161114-00017#1 mark
            #161114-00017#1 add ------
            LET g_qryparam.arg1 = g_apcacomp
            CALL q_imaf001_21()
            #161114-00017#1 add end---
            DISPLAY g_qryparam.return1 TO b_pmdt006
            NEXT FIELD b_pmdt006
            #END add-point
 
 
         #----<<b_pmdt006_desc>>----
         #----<<b_pmdt006_desc_1>>----
         #----<<b_pmdt005>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt005
            #add-point:ON ACTION controlp INFIELD b_pmdt005 name="construct.c.filter.page1.b_pmdt005"
            
            #END add-point
 
 
         #----<<b_imag011>>----
         #Ctrlp:construct.c.page1.b_imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imag011
            #add-point:ON ACTION controlp INFIELD b_imag011 name="construct.c.filter.page1.b_imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()
            DISPLAY g_qryparam.return1 TO b_imag011
            NEXT FIELD b_imag011
            #END add-point
 
 
         #----<<imag011_desc>>----
         #----<<b_apcb021>>----
         #Ctrlp:construct.c.filter.page1.b_apcb021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb021
            #add-point:ON ACTION controlp INFIELD b_apcb021 name="construct.c.filter.page1.b_apcb021"
            #費用科目
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161114-00017#1 add ------
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_input.apcald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161114-00017#1 add end---
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_apcb021
            NEXT FIELD b_apcb021
            #END add-point
 
 
         #----<<apcb021_desc>>----
         #----<<b_pmdt001>>----
         #Ctrlp:construct.c.page1.b_pmdt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt001
            #add-point:ON ACTION controlp INFIELD b_pmdt001 name="construct.c.filter.page1.b_pmdt001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmdl004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_input.apcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmdl004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmdldocno()
            DISPLAY g_qryparam.return1 TO b_pmdt001
            NEXT FIELD b_pmdt001
            #END add-point
 
 
         #----<<b_pmdt002>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt002
            #add-point:ON ACTION controlp INFIELD b_pmdt002 name="construct.c.filter.page1.b_pmdt002"
            
            #END add-point
 
 
         #----<<b_pmdt050>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt050
            #add-point:ON ACTION controlp INFIELD b_pmdt050 name="construct.c.filter.page1.b_pmdt050"
            
            #END add-point
 
 
         #----<<b_pmds002>>----
         #----<<b_pmds002_desc>>----
         #----<<b_pmds003>>----
         #----<<b_pmds003_desc>>----
         #----<<b_pmdt016>>----
         #Ctrlp:construct.c.page1.b_pmdt016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt016
            #add-point:ON ACTION controlp INFIELD b_pmdt016 name="construct.c.filter.page1.b_pmdt016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdt016  #顯示到畫面上
            NEXT FIELD b_pmdt016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdt016_desc>>----
         #----<<b_pmdt020>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt020
            #add-point:ON ACTION controlp INFIELD b_pmdt020 name="construct.c.filter.page1.b_pmdt020"
            
            #END add-point
 
 
         #----<<b_pmdt024>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt024
            #add-point:ON ACTION controlp INFIELD b_pmdt024 name="construct.c.filter.page1.b_pmdt024"
            
            #END add-point
 
 
         #----<<b_apcb007>>----
         #Ctrlp:construct.c.filter.page1.b_apcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb007
            #add-point:ON ACTION controlp INFIELD b_apcb007 name="construct.c.filter.page1.b_apcb007"
            
            #END add-point
 
 
         #----<<b_pmdt056>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt056
            #add-point:ON ACTION controlp INFIELD b_pmdt056 name="construct.c.filter.page1.b_pmdt056"
            
            #END add-point
 
 
         #----<<b_pmdt066>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt066
            #add-point:ON ACTION controlp INFIELD b_pmdt066 name="construct.c.filter.page1.b_pmdt066"
            
            #END add-point
 
 
         #----<<b_pmdt069>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt069
            #add-point:ON ACTION controlp INFIELD b_pmdt069 name="construct.c.filter.page1.b_pmdt069"
            
            #END add-point
 
 
         #----<<l_diffqty>>----
         #----<<b_pmds037>>----
         #Ctrlp:construct.c.page1.b_pmds037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds037
            #add-point:ON ACTION controlp INFIELD b_pmds037 name="construct.c.filter.page1.b_pmds037"
            #幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooaj002_1() #161114-00017#1 mark
            CALL q_ooai001()    #161114-00017#1
            DISPLAY g_qryparam.return1 TO b_pmds037
            NEXT FIELD b_pmds037
            #END add-point
 
 
         #----<<b_pmds038>>----
         #Ctrlp:construct.c.filter.page1.b_pmds038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds038
            #add-point:ON ACTION controlp INFIELD b_pmds038 name="construct.c.filter.page1.b_pmds038"
            
            #END add-point
 
 
         #----<<b_pmdt046>>----
         #Ctrlp:construct.c.page1.b_pmdt046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt046
            #add-point:ON ACTION controlp INFIELD b_pmdt046 name="construct.c.filter.page1.b_pmdt046"
            #稅別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()
            DISPLAY g_qryparam.return1 TO b_pmdt046
            NEXT FIELD b_pmdt046
            #END add-point
 
 
         #----<<b_pmdt037>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt037
            #add-point:ON ACTION controlp INFIELD b_pmdt037 name="construct.c.filter.page1.b_pmdt037"
            
            #END add-point
 
 
         #----<<b_pmdt036>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt036
            #add-point:ON ACTION controlp INFIELD b_pmdt036 name="construct.c.filter.page1.b_pmdt036"
            
            #END add-point
 
 
         #----<<l_pmdt0383>>----
         #----<<l_pmdt0473>>----
         #----<<l_pmdt0393>>----
         #----<<b_pmdt038>>----
         #----<<l_pmdt047>>----
         #----<<b_pmdt039>>----
         #----<<l_sumapcb103>>----
         #----<<l_sumapcb104>>----
         #----<<l_sumapcb105>>----
         #----<<l_sfapcb103>>----
         #----<<l_sfapcb104>>----
         #----<<l_sfapcb105>>----
         #----<<l_apca101>>----
         #----<<l_apcb113>>----
         #----<<l_apcb114>>----
         #----<<l_apcb115>>----
         #----<<l_dapcb103>>----
         #----<<l_dapcb104>>----
         #----<<l_dapcb105>>----
         #----<<l_pmdt0382>>----
         #----<<l_pmdt0472>>----
         #----<<l_pmdt0392>>----
         #----<<b_apcadocno>>----
         #Ctrlp:construct.c.page1.b_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocno
            #add-point:ON ACTION controlp INFIELD b_apcadocno name="construct.c.filter.page1.b_apcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcadocno  #顯示到畫面上
            NEXT FIELD b_apcadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apca2>>----
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      #151201--s
      CONSTRUCT l_wc_form ON l_pmds000 FROM s_detail1[1].l_pmds000
         BEFORE CONSTRUCT
                     DISPLAY aapq130_filter_parser('l_pmds000') TO s_detail1[1].l_pmds000
      END CONSTRUCT
      #151201--e
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   #151201--s
   LET l_wc_form = cl_replace_str(l_wc_form,'l_pmds', 'pmds')
   LET g_wc_filter = g_wc_filter," AND ",l_wc_form
   #151201--e   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL aapq130_filter_show('pmds007','b_pmds007')
   CALL aapq130_filter_show('pmds001','b_pmds001')
   CALL aapq130_filter_show('pmdtdocno','b_pmdtdocno')
   CALL aapq130_filter_show('pmdtseq','b_pmdtseq')
   CALL aapq130_filter_show('pmdt006','b_pmdt006')
   CALL aapq130_filter_show('pmdt005','b_pmdt005')
   CALL aapq130_filter_show('imag011','b_imag011')
   CALL aapq130_filter_show('apcb021','b_apcb021')
   CALL aapq130_filter_show('pmdt001','b_pmdt001')
   CALL aapq130_filter_show('pmdt002','b_pmdt002')
   CALL aapq130_filter_show('pmdt050','b_pmdt050')
   CALL aapq130_filter_show('pmdt016','b_pmdt016')
   CALL aapq130_filter_show('pmdt020','b_pmdt020')
   CALL aapq130_filter_show('pmdt024','b_pmdt024')
   CALL aapq130_filter_show('apcb007','b_apcb007')
   CALL aapq130_filter_show('pmdt056','b_pmdt056')
   CALL aapq130_filter_show('pmdt066','b_pmdt066')
   CALL aapq130_filter_show('pmdt069','b_pmdt069')
   CALL aapq130_filter_show('pmds037','b_pmds037')
   CALL aapq130_filter_show('pmds038','b_pmds038')
   CALL aapq130_filter_show('pmdt046','b_pmdt046')
   CALL aapq130_filter_show('pmdt037','b_pmdt037')
   CALL aapq130_filter_show('pmdt036','b_pmdt036')
   CALL aapq130_filter_show('apcadocno','b_apcadocno')
 
 
   CALL aapq130_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq130.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aapq130_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="aapq130.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq130_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapq130_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aapq130.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq130_detail_action_trans()
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
 
{<section id="aapq130.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq130_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
            IF g_pmds_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmds_d.getLength() AND g_pmds_d.getLength() > 0
            LET g_detail_idx = g_pmds_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmds_d.getLength() THEN
               LET g_detail_idx = g_pmds_d.getLength()
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
 
{<section id="aapq130.mask_functions" >}
 &include "erp/aap/aapq130_mask.4gl"
 
{</section>}
 
{<section id="aapq130.other_function" readonly="Y" >}

PRIVATE FUNCTION aapq130_create_tmp()
   DROP TABLE aapq130_tmp
   CREATE TEMP TABLE aapq130_tmp(
   sel LIKE type_t.chr1,
   pmdtsite       LIKE pmdt_t.pmdtsite,
   pmds007        LIKE pmds_t.pmds007,
   pmds007_desc   LIKE type_t.chr500,
   pmds001        LIKE pmds_t.pmds001,    #150106-00011#2
   pmds000        LIKE pmds_t.pmds000,
   pmdtdocno      LIKE pmdt_t.pmdtdocno,
   pmdtseq        LIKE pmdt_t.pmdtseq,
   pmdt006        LIKE pmdt_t.pmdt006,
   pmdt006_desc   LIKE type_t.chr500,
   pmdt006_desc_1 LIKE type_t.chr500,
   pmdt005        LIKE pmdt_t.pmdt005,    #151102-00008#1 add pmdt005
   imag011        LIKE imag_t.imag011,    #151102-00008#1
   imag011_desc   LIKE type_t.chr500,     #151102-00008#1
   apcb021        LIKE apcb_t.apcb021,    #151102-00008#1
   apcb021_desc   LIKE type_t.chr500,     #151102-00008#1
   pmdt001        LIKE pmdt_t.pmdt001,
   pmdt002        LIKE pmdt_t.pmdt002,    #150902-00001#3
   pmdt050        LIKE pmdt_t.pmdt050,    #150902-00001#3
   pmds002        LIKE pmds_t.pmds002,    #150128-00005#9
   pmds002_desc   LIKE type_t.chr500,     #150128-00005#9
   pmds003        LIKE pmds_t.pmds003,    #150128-00005#9
   pmds003_desc   LIKE type_t.chr500,     #150128-00005#9  
   pmdt016        LIKE pmdt_t.pmdt016,    #150128-00005#9
   pmdt016_desc   LIKE type_t.chr500,     #150128-00005#9
   pmdt020 LIKE pmdt_t.pmdt020,           #161206-00017#2
   pmdt024 LIKE pmdt_t.pmdt024,
   apcb007 LIKE apcb_t.apcb007,
   pmdt0562 LIKE pmdt_t.pmdt056,     #150123-00003#2 albireo add
   pmdt066 LIKE pmdt_t.pmdt066,
   pmdt069 LIKE pmdt_t.pmdt069,
   diffqty LIKE type_t.num20_6,      #150123-00003#2 albireo add
   pmds037 LIKE pmds_t.pmds037,
   pmds038 LIKE pmds_t.pmds038,
   pmdt046 LIKE pmdt_t.pmdt046,
   pmdt037 LIKE pmdt_t.pmdt037,
   pmdt036 LIKE pmdt_t.pmdt036,
   l_pmdt0383 LIKE pmdt_t.pmdt038,   #150123-00003#2 albireo add
   l_pmdt0473 LIKE pmdt_t.pmdt047,   #150123-00003#2 albireo add
   l_pmdt0393 LIKE pmdt_t.pmdt039,   #150123-00003#2 albireo add
   pmdt038 LIKE pmdt_t.pmdt038,
   l_pmdt047 LIKE type_t.num20_6,
   pmdt039 LIKE pmdt_t.pmdt039,
   sumapcb103 LIKE apcb_t.apcb103,   #150123-00003#2 albireo add
   sumapcb104 LIKE apcb_t.apcb104,   #150123-00003#2 albireo add
   sumapcb105 LIKE apcb_t.apcb105,   #150123-00003#2 albireo add
   sfapcb103 LIKE apcb_t.apcb103,    #150123-00003#2 albireo add
   sfapcb104 LIKE apcb_t.apcb104,    #150123-00003#2 albireo add
   sfapcb105 LIKE apcb_t.apcb105,    #150123-00003#2 albireo add
   l_apca101 LIKE apca_t.apca101,    #161206-00017#2
   apcb113   LIKE apcb_t.apcb113,    #150123-00003#2 albireo add
   apcb114   LIKE apcb_t.apcb114,    #150123-00003#2 albireo add
   apcb115   LIKE apcb_t.apcb115,    #150123-00003#2 albireo add
   dapcb103   LIKE apcb_t.apcb103,   #150123-00003#2 albireo add
   dapcb104   LIKE apcb_t.apcb104,   #150123-00003#2 albireo add
   dapcb105   LIKE apcb_t.apcb105,   #150123-00003#2 albireo add
   l_pmdt0382 LIKE type_t.num20_6,
   l_pmdt0472 LIKE type_t.num20_6,
   l_pmdt0392 LIKE type_t.num20_6,
   apcadocno  LIKE apca_t.apcadocno,   #150924-00012#1 add
   apca2      LIKE apca_t.apcadocno,   #151019-00009#1 add 
   odr     LIKE type_t.num5
   );
   CREATE UNIQUE INDEX aapq130_tmp_index ON aapq130_tmp(pmdtdocno,pmdtseq)   #160414-00018#4
   
   #161205-00025#18-----s
   DROP TABLE aapq130_x02_tmp;
   CREATE TEMP TABLE aapq130_x02_tmp(
      pmdtsite         LIKE pmdt_t.pmdtsite,
      pmds007          LIKE pmds_t.pmds007,
      l_pmds007_desc   LIKE type_t.chr100,
      pmds001          LIKE pmds_t.pmds001,
      l_pmds000        LIKE type_t.chr100,
      pmdtdocno        LIKE pmdt_t.pmdtdocno,
      pmdtseq          LIKE pmdt_t.pmdtseq,
      pmdt006          LIKE pmdt_t.pmdt006,
      l_pmdt006_desc   LIKE type_t.chr100,
      l_pmdt006_desc_1 LIKE type_t.chr100,
      l_pmdt005_desc   LIKE type_t.chr100,
      l_imag011        LIKE imag_t.imag011,
      l_imag011_desc   LIKE type_t.chr100,
      l_apcb021        LIKE apcb_t.apcb021,
      l_apcb021_desc   LIKE type_t.chr100,
      pmdt001          LIKE pmdt_t.pmdt001,
      pmdt002          LIKE pmdt_t.pmdt002,
      pmdt050          LIKE pmdt_t.pmdt050,
      pmds002          LIKE pmds_t.pmds002,
      l_pmds022_desc   LIKE type_t.chr100,
      pmds003          LIKE pmds_t.pmds002,
      l_pmds003_desc   LIKE type_t.chr100,
      pmdt016          LIKE pmdt_t.pmdt016,
      l_pmdt016_desc   LIKE type_t.chr100,
      pmdt020          LIKE pmdt_t.pmdt020,           #161206-00017#2
      pmdt024          LIKE pmdt_t.pmdt024,
      l_apcb007        LIKE apcb_t.apcb007,
      pmdt056          LIKE pmdt_t.pmdt056,
      pmdt066          LIKE pmdt_t.pmdt066,
      pmdt069          LIKE pmdt_t.pmdt069,
      l_diffqty        LIKE type_t.num20_6,
      pmds037          LIKE pmds_t.pmds037,
      pmds038          LIKE pmds_t.pmds038,
      pmdt046          LIKE pmdt_t.pmdt046,
      pmdt037          LIKE pmdt_t.pmdt037,
      pmdt036          LIKE pmdt_t.pmdt036,
      l_pmdt038_3      LIKE pmdt_t.pmdt038,
      l_pmdt047_3      LIKE pmdt_t.pmdt047,
      l_pmdt039_3      LIKE pmdt_t.pmdt039,      
      pmdt038          LIKE pmdt_t.pmdt038,      #170118-00052#1
      l_pmdt047        LIKE type_t.num20_6,      #170118-00052#1
      pmdt039          LIKE pmdt_t.pmdt039,      #170118-00052#1
      l_sumapcb103     LIKE type_t.num20_6,      #170118-00052#1
      l_sumapcb104     LIKE type_t.num20_6,      #170118-00052#1
      l_sumapcb105     LIKE type_t.num20_6,      #170118-00052#1
      l_sfapcb103      LIKE apcb_t.apcb103,
      l_sfapcb104      LIKE apcb_t.apcb104,
      l_sfapcb105      LIKE apcb_t.apcb105,
      l_apca101 LIKE apca_t.apca101,    #161206-00017#2
      l_apcb113        LIKE apcb_t.apcb113,
      l_apcb114        LIKE apcb_t.apcb114,
      l_apcb115        LIKE apcb_t.apcb115,
      l_dapcb103       LIKE apcb_t.apcb103,
      l_dapcb104       LIKE apcb_t.apcb104,
      l_dapcb105       LIKE apcb_t.apcb105,
      l_pmdt0382       LIKE pmdt_t.pmdt038,
      l_pmdt0472       LIKE pmdt_t.pmdt047,
      l_pmdt0392       LIKE pmdt_t.pmdt039,
      l_apcadocno      LIKE apca_t.apcadocno,
      l_apca2          LIKE apca_t.apcadocno
      )   
   #161205-00025#18-----e
END FUNCTION

################################################################################
# Descriptions...: 掃把清空&給預設值 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapq130_qbe_clear()

# Date & Author..: 2015/02/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq130_qbe_clear()

   LET g_input.type = '1'
   LET g_input.type1 = '1'   #160802-00036#2
   
   #取預設帳務中心
   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_input.apcasite,g_input.apcald,g_input.l_apcacomp
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   LET g_input.apcald_desc  = s_desc_get_ld_desc(g_input.apcald)
   LET g_input.apcasite_desc= s_desc_get_department_desc(g_input.apcasite)
   LET g_apcacomp = g_input.l_apcacomp
   LET g_input.l_apcacomp = s_desc_show1(g_input.l_apcacomp,s_desc_get_department_desc(g_input.l_apcacomp))
   CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str  #161229-00047#24 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#24 add 
   #161114-00017#1 add ------  
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#24 mark
   #161114-00017#1 add end--- 
   LET g_input.sumshow = 'N'
   
   DISPLAY BY NAME g_input.apcald  ,g_input.apcald_desc,
                   g_input.apcasite,g_input.apcasite_desc,
                   g_input.l_apcacomp,g_input.type1         #160802-00036#2 add g_input.type1
   
END FUNCTION
################################################################################
# Descriptions...: 判斷是否為符合條件的入庫單性質
# Memo...........: TRUE/FALSE   代表是符合條件或不符合
# Usage..........: aapq130_pmds000_chk(p_type,p_pmds000)
#                  RETURNING r_success
# Input parameter: p_type   1全入庫單性質 2入 3退 4倉退 5驗退 or 直接傳入條件式
#                : p_pmds000 要檢查的入庫單性質
# Return code....: r_success   符合否的布林值
#                : 
# Date & Author..: 160503 By 03538
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq130_pmds000_chk(p_type,p_pmds000)
   DEFINE p_type    STRING
   DEFINE p_pmds000 LIKE pmds_t.pmds000
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_gzcb004 LIKE gzcb_t.gzcb004

   WHENEVER ERROR CONTINUE
   
   LET r_success = FALSE
   
   EXECUTE pmds000_chk_pre USING p_pmds000 INTO l_gzcb004   
   
   CASE          
      WHEN p_type = '2'   #入
         IF l_gzcb004 = '1' THEN LET r_success = TRUE END IF
      WHEN p_type = '3'   #退
         IF l_gzcb004 = '-1' THEN LET r_success = TRUE END IF
   END CASE
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#4
# Usage..........: CALL aapq130_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161024 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq130_get_ooef001_wc(p_wc)
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
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

 
{</section>}
 

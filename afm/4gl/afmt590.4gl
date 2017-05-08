#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt590.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-01-08 11:01:54), PR版次:0015(2017-01-12 17:10:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: afmt590
#+ Description: 平倉出售維護
#+ Creator....: 03080(2015-04-30 09:25:16)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt590.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#150528-00006#1   2015/05/29  By Jessy    財務優化；單頭隱藏alt+s改為單頭固定
#150401-00001#13  2015/07/16  By RayHuang statechange段問題修正
#150820-00011#8   2015/09/02  By RayHuang 新增欄位現金變動碼、存提碼
#150820-00011#12  2015/09/09  By Reanna   增加"累計收息金額"頁籤
#150702-00003#4   2015/09/10  By Belle    增加計算最後一期利息
#150924-00006#4   2015/09/25  By Jessy    整單操作-費用維護有維護費用項目時，單據確認時一併寫入nmbc_t,glbc_t
#151012-00014#6   2015/10/26  By RayHuang nmbc_t新增三個欄位(nmbc014~nmbc016)
#151013-00016#6   2015/10/28  By RayHuang glbc_t新增狀態碼
#151029-00012#7   2015/10/30  By Jessy    1.平倉收入本幣(fmmy013 N202),利息收入本幣(fmmy014 N202) 2.匯率取法及本幣金額計算方式同於afmt595批次產生時邏輯
#151029-00012#12  2015/11/02  By albireo  1.增加 利息收入的匯率 2.增加 計算出售數量換算沖銷的購入成本,並計算出購入匯率與售出匯率的匯差損益3.增加 本幣金額顯示 4.增加 計算收益及收益金額顯示  
#151103-00016#4   2015/11/05  By albireo  1.afmt590明細查看合計  2.afmt590 明細信息原幣改本幣調整 3.根據afmi510的平倉出售匯率取出售時匯率參數修正計算公式
#151105-00008#5   2015/11/10  By albireo  收益計算方式變更,並新增欄位
#151112-00009#2   2015/11/16  By albireo  計息流程變更,改變利息相關計算方式及增加欄位,確認段afmt560回寫部分
#151126           2015/11/26  By kris     修改取值公式
#151203-00013#2   2015/12/04  By Jessy    1.afmt590確認時,銀存收入金額寫入nmbc有誤  2.金額相關用_o紀錄
#151130-00015#2   2015/12/22  BY Xiaozg   根据是否可以更改單據日期 設定開放單據日期修改
#151228-00008#1   2016/01/08  By sakura   "計提投資收益"頁箋, 增加當期本幣及累計計提本幣金額顯示
#160118-00007#4   2016/01/30  By Reanna   確認時檢核調整
#160122-00001#6   2016/02/22  By 07673    添加交易账户编号用户权限控管
#160218-00010#1   2016/03/04  By albireo  修改公式D  本金匯差fmmy020 修改公式=fmmy013-fmmy016-fmmy018
#160122-00001#6   2016/03/16  By 07900    添加交易账户编号用户权限控管,增加部门权限
#160122-00001#36  2016/03/30  By 02599    当支付方式为2或3时，只可以录入当前用户有权限的出款银行和出款账户
#160322-00025#20  2016/04/19  By 07673    nmbc_t增加nmbcorga来源组织栏位,新增是给该栏位赋值
#160318-00025#25  2016/04/26  BY 07900    校验代码重复错误讯息的修改
#160818-00017#13  2016/08/23  By 07900    删除修改未重新判断状态码
#160829-00004#3   2016/08/31  By 08729    處理取匯率但幣別取錯
#161006-00005#14  2016/10/19  By 08732    組織類型與職能開窗調整
#160822-00012#4   2016/10/31  By 08732    新舊值調整
#161026-00023#14  2016/11/09  By 08732    AFM模組,增加BPM簽核功能
#161104-00024#11  2016/11/09  By 08171    程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
#161104-00046#21  2017/01/12  By 08729    單別預設值;資料依照單別user dept權限過濾單號
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_fmmy_m RECORD
       fmmysite LIKE fmmy_t.fmmysite, 
   fmmysite_desc LIKE type_t.chr80, 
   fmmydocdt LIKE fmmy_t.fmmydocdt, 
   fmmydocno LIKE fmmy_t.fmmydocno, 
   fmmy001 LIKE fmmy_t.fmmy001, 
   l_fmmy001_1 LIKE type_t.chr500, 
   l_fmmy001_1_desc LIKE type_t.chr80, 
   l_fmmy001_2 LIKE type_t.chr100, 
   l_fmmy001_2_desc LIKE type_t.chr80, 
   l_fmmy001_3 LIKE type_t.chr100, 
   l_fmmy001_3_desc LIKE type_t.chr80, 
   l_fmmy001_4 LIKE type_t.chr100, 
   fmmy002 LIKE fmmy_t.fmmy002, 
   fmmy002_desc LIKE type_t.chr80, 
   fmmystus LIKE fmmy_t.fmmystus, 
   fmmy003 LIKE fmmy_t.fmmy003, 
   fmmy004 LIKE fmmy_t.fmmy004, 
   fmmy005 LIKE fmmy_t.fmmy005, 
   fmmy007 LIKE fmmy_t.fmmy007, 
   fmmy013 LIKE fmmy_t.fmmy013, 
   fmmy028 LIKE fmmy_t.fmmy028, 
   fmmy019 LIKE fmmy_t.fmmy019, 
   fmmy029 LIKE fmmy_t.fmmy029, 
   fmmy015 LIKE fmmy_t.fmmy015, 
   fmmy016 LIKE fmmy_t.fmmy016, 
   l_fmmz003 LIKE type_t.num20_6, 
   l_fmmz011 LIKE type_t.num20_6, 
   fmmy017 LIKE fmmy_t.fmmy017, 
   fmmy018 LIKE fmmy_t.fmmy018, 
   fmmy021 LIKE fmmy_t.fmmy021, 
   fmmy022 LIKE fmmy_t.fmmy022, 
   fmmy024 LIKE fmmy_t.fmmy024, 
   fmmy025 LIKE fmmy_t.fmmy025, 
   fmmy023 LIKE fmmy_t.fmmy023, 
   fmmy020 LIKE fmmy_t.fmmy020, 
   fmmy027 LIKE fmmy_t.fmmy027, 
   fmmy026 LIKE fmmy_t.fmmy026, 
   fmmy006 LIKE fmmy_t.fmmy006, 
   fmmy014 LIKE fmmy_t.fmmy014, 
   fmmy008 LIKE fmmy_t.fmmy008, 
   fmmy009 LIKE fmmy_t.fmmy009, 
   fmmy009_desc LIKE type_t.chr80, 
   fmmy010 LIKE fmmy_t.fmmy010, 
   fmmy010_desc LIKE type_t.chr80, 
   fmmy012 LIKE fmmy_t.fmmy012, 
   fmmy012_desc LIKE type_t.chr80, 
   fmmy011 LIKE fmmy_t.fmmy011, 
   fmmy011_desc LIKE type_t.chr80, 
   fmmyownid LIKE fmmy_t.fmmyownid, 
   fmmyownid_desc LIKE type_t.chr80, 
   fmmyowndp LIKE fmmy_t.fmmyowndp, 
   fmmyowndp_desc LIKE type_t.chr80, 
   fmmycrtid LIKE fmmy_t.fmmycrtid, 
   fmmycrtid_desc LIKE type_t.chr80, 
   fmmycrtdp LIKE fmmy_t.fmmycrtdp, 
   fmmycrtdp_desc LIKE type_t.chr80, 
   fmmycrtdt LIKE fmmy_t.fmmycrtdt, 
   fmmymodid LIKE fmmy_t.fmmymodid, 
   fmmymodid_desc LIKE type_t.chr80, 
   fmmymoddt LIKE fmmy_t.fmmymoddt, 
   fmmycnfid LIKE fmmy_t.fmmycnfid, 
   fmmycnfid_desc LIKE type_t.chr80, 
   fmmycnfdt LIKE fmmy_t.fmmycnfdt, 
   fmmypstid LIKE fmmy_t.fmmypstid, 
   fmmypstid_desc LIKE type_t.chr80, 
   fmmypstdt LIKE fmmy_t.fmmypstdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fmmydocno LIKE fmmy_t.fmmydocno,
      b_fmmy001 LIKE fmmy_t.fmmy001,
      b_fmmy002 LIKE fmmy_t.fmmy002,
      b_fmmy003 LIKE fmmy_t.fmmy003,
      b_fmmy004 LIKE fmmy_t.fmmy004,
      b_fmmy005 LIKE fmmy_t.fmmy005,
      b_fmmy006 LIKE fmmy_t.fmmy006,
      b_fmmy007 LIKE fmmy_t.fmmy007,
      b_fmmy008 LIKE fmmy_t.fmmy008,
      b_fmmy009 LIKE fmmy_t.fmmy009,
      b_fmmy010 LIKE fmmy_t.fmmy010,
      b_fmmydocdt LIKE fmmy_t.fmmydocdt,
      b_fmmysite LIKE fmmy_t.fmmysite
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald              LIKE glaa_t.glaald    #組織所屬法人主帳套
DEFINE g_glaa                RECORD
             glaacomp        LIKE glaa_t.glaacomp,
             glaa024         LIKE glaa_t.glaa024,
             glaa026         LIKE glaa_t.glaa026,
             glaa001         LIKE glaa_t.glaa001,
             glaa025         LIKE glaa_t.glaa025
                             END RECORD
DEFINE g_memo_afmt590   DYNAMIC ARRAY OF RECORD
                           l_type       LIKE type_t.chr1,                      
                           l_docno      LIKE type_t.chr80,
                           l_yy         LIKE type_t.num10,
                           l_mm         LIKE type_t.num5,
                           l_docdt      LIKE type_t.dat,                       
                           l_amount     LIKE type_t.num20_6,
                           l_curr       LIKE type_t.chr10,
                           l_account1   LIKE type_t.num20_6,
                           l_cost1      LIKE type_t.num20_6,
                           l_sumcost    LIKE type_t.num20_6,                       
                           l_account2   LIKE type_t.num20_6,
                           l_account3   LIKE type_t.num20_6,
                           l_cost2      LIKE type_t.num20_6,
                           l_sumaccount LIKE type_t.num20_6,
                           l_sumaccount2 LIKE type_t.num20_6,    #151103-00016#4 add
                           l_sumall     LIKE type_t.num20_6
                        END RECORD
#150820-00011#12 add ------
DEFINE g_memo_afmt5902  DYNAMIC ARRAY OF RECORD
                           l_fmmsdocno  LIKE fmms_t.fmmsdocno,
                           l_fmms001    LIKE fmms_t.fmms001,
                           l_fmms002    LIKE fmms_t.fmms002,
                           l_fmmt005    LIKE fmmt_t.fmmt005,
                           l_fmmt006    LIKE fmmt_t.fmmt006,
                           l_fmmt0101   LIKE fmmt_t.fmmt010,
                           l_fmmt0102   LIKE fmmt_t.fmmt010,
                           l_fmmt0141   LIKE fmmt_t.fmmt014,   #151228-00008#1
                           l_fmmt0142   LIKE fmmt_t.fmmt014    #151228-00008#1
                        END RECORD
#150820-00011#12 add end---
DEFINE g_rec_b2         LIKE type_t.num10  

#160122-00001#6 By 07900 add
DEFINE g_sql_bank       STRING                              
#160122-00001#6 By 07900 end
DEFINE g_user_dept_wc   STRING      #161104-00046#21
DEFINE g_user_dept_wc_q STRING      #161104-00046#21
DEFINE g_user_slip_wc   STRING      #161104-00046#21
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmmy_m        type_g_fmmy_m  #單頭變數宣告
DEFINE g_fmmy_m_t      type_g_fmmy_m  #單頭舊值宣告(系統還原用)
DEFINE g_fmmy_m_o      type_g_fmmy_m  #單頭舊值宣告(其他用途)
DEFINE g_fmmy_m_mask_o type_g_fmmy_m  #轉換遮罩前資料
DEFINE g_fmmy_m_mask_n type_g_fmmy_m  #轉換遮罩後資料
 
   DEFINE g_fmmydocno_t LIKE fmmy_t.fmmydocno
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt590.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#21-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fmmy_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmmysite','','fmmyent','fmmydocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#21-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmmysite,'',fmmydocdt,fmmydocno,fmmy001,'','','','','','','',fmmy002, 
       '',fmmystus,fmmy003,fmmy004,fmmy005,fmmy007,fmmy013,fmmy028,fmmy019,fmmy029,fmmy015,fmmy016,'', 
       '',fmmy017,fmmy018,fmmy021,fmmy022,fmmy024,fmmy025,fmmy023,fmmy020,fmmy027,fmmy026,fmmy006,fmmy014, 
       fmmy008,fmmy009,'',fmmy010,'',fmmy012,'',fmmy011,'',fmmyownid,'',fmmyowndp,'',fmmycrtid,'',fmmycrtdp, 
       '',fmmycrtdt,fmmymodid,'',fmmymoddt,fmmycnfid,'',fmmycnfdt,fmmypstid,'',fmmypstdt", 
                      " FROM fmmy_t",
                      " WHERE fmmyent= ? AND fmmydocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt590_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmmysite,t0.fmmydocdt,t0.fmmydocno,t0.fmmy001,t0.fmmy002,t0.fmmystus, 
       t0.fmmy003,t0.fmmy004,t0.fmmy005,t0.fmmy007,t0.fmmy013,t0.fmmy028,t0.fmmy019,t0.fmmy029,t0.fmmy015, 
       t0.fmmy016,t0.fmmy017,t0.fmmy018,t0.fmmy021,t0.fmmy022,t0.fmmy024,t0.fmmy025,t0.fmmy023,t0.fmmy020, 
       t0.fmmy027,t0.fmmy026,t0.fmmy006,t0.fmmy014,t0.fmmy008,t0.fmmy009,t0.fmmy010,t0.fmmy012,t0.fmmy011, 
       t0.fmmyownid,t0.fmmyowndp,t0.fmmycrtid,t0.fmmycrtdp,t0.fmmycrtdt,t0.fmmymodid,t0.fmmymoddt,t0.fmmycnfid, 
       t0.fmmycnfdt,t0.fmmypstid,t0.fmmypstdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooag011 ,t7.ooag011",
               " FROM fmmy_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.fmmyownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmmyowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmmycrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmmycrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmmymodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmmycnfid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmmypstid  ",
 
               " WHERE t0.fmmyent = " ||g_enterprise|| " AND t0.fmmydocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt590_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt590 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt590_init()   
 
      #進入選單 Menu (="N")
      CALL afmt590_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt590
      
   END IF 
   
   CLOSE afmt590_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt590.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt590_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('fmmystus','13','Y,N,X,A,D,R,W')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fmmy008','8867')
    CALL cl_set_combo_scc('l_type','8868')
   #160122-00001#6--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#6--add--end
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afmt590_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmt590_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afmt590_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_main_hidden = 1
                 CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmmy_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afmt590_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL afmt590_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt590_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmt590_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmt590_set_act_visible()
               CALL afmt590_set_act_no_visible()
               IF NOT (g_fmmy_m.fmmydocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmmyent = " ||g_enterprise|| " AND",
                                     " fmmydocno = '", g_fmmy_m.fmmydocno, "' "
 
                  #填到對應位置
                  CALL afmt590_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afmt590_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt590_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afmt590_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afmt590_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afmt590_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL afmt590_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt590_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt590_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt590_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt590_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt590_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/afm/afmt590_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/afm/afmt590_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt590_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt590_query()
               #add-point:ON ACTION query name="menu2.query"
              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt590_01
            LET g_action_choice="open_afmt590_01"
            IF cl_auth_chk_act("open_afmt590_01") THEN
               
               #add-point:ON ACTION open_afmt590_01 name="menu2.open_afmt590_01"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
               
               #add-point:ON ACTION touch_page1 name="menu2.touch_page1"
              
               #END add-point
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu2.bpm_status"
            
            #END add-point
 
 
 
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt590_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt590_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt590_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmy_m.fmmydocdt)
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL afmt590_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            DISPLAY ARRAY g_memo_afmt590 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b2)
               BEFORE ROW

            
               BEFORE DISPLAY
                  CALL afmt590_b_fill2(g_fmmy_m.fmmy001)
            
            END DISPLAY
            
            #150820-00011#12 add ------
            DISPLAY ARRAY g_memo_afmt5902 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)
               BEFORE ROW
               
               BEFORE DISPLAY
                  CALL afmt590_b_fill3(g_fmmy_m.fmmy001)
            END DISPLAY
            #150820-00011#12 add end---
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afmt590_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt590_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               CALL gfrm_curr.ensureFieldVisible("fmmy_t.fmmydocno")
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmt590_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmt590_set_act_visible()
               CALL afmt590_set_act_no_visible()
               IF NOT (g_fmmy_m.fmmydocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmmyent = " ||g_enterprise|| " AND",
                                     " fmmydocno = '", g_fmmy_m.fmmydocno, "' "
 
                  #填到對應位置
                  CALL afmt590_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL afmt590_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL afmt590_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt590_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afmt590_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afmt590_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afmt590_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL afmt590_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt590_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt590_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt590_modify()
               #add-point:ON ACTION modify name="menu.modify"
               NEXT FIELD b_fmmydocno
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt590_delete()
               #add-point:ON ACTION delete name="menu.delete"
               NEXT FIELD b_fmmydocno
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt590_insert()
               #add-point:ON ACTION insert name="menu.insert"
               NEXT FIELD b_fmmydocno
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " fmmyent = ",g_enterprise," AND fmmydocno = '",g_fmmy_m.fmmydocno,"'"   #151110-00004#1 151111 by sakura add
               #END add-point
               &include "erp/afm/afmt590_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " fmmyent = ",g_enterprise," AND fmmydocno = '",g_fmmy_m.fmmydocno,"'"   #151110-00004#1 151111 by sakura add
               #END add-point
               &include "erp/afm/afmt590_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt590_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt590_query()
               #add-point:ON ACTION query name="menu.query"
               NEXT FIELD b_fmmydocno
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt590_01
            LET g_action_choice="open_afmt590_01"
            IF cl_auth_chk_act("open_afmt590_01") THEN
               
               #add-point:ON ACTION open_afmt590_01 name="menu.open_afmt590_01"
               IF NOT cl_null(g_fmmy_m.fmmydocno)THEN
                  CALL s_transaction_begin()
                  OPEN afmt590_cl USING g_enterprise,g_fmmy_m.fmmydocno
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN afmt590_cl:" 
                     LET g_errparam.code   = 'afm-00101'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLOSE afmt590_cl
                     CALL s_transaction_end('N','0')
                  ELSE
                      CALL afmt590_01(g_fmmy_m.fmmydocno)
                      CALL afmt590_show_fmmz(g_fmmy_m.fmmydocno)     #151105-00008#5
                  END IF                 
                  CALL s_transaction_end('Y',0)
               END IF              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
               
               #add-point:ON ACTION touch_page1 name="menu.touch_page1"
                NEXT FIELD b_fmmydocno
               #END add-point
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt590_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt590_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt590_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmy_m.fmmydocdt)
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afmt590_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "fmmydocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fmmy_t ",
               "  ",
               "  ",
               " WHERE fmmyent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fmmy_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   #160122-00001#6 by 07900 --add---str
   LET g_sql = g_sql CLIPPED," AND (fmmy010 IN (",g_sql_bank,") 
                                OR TRIM(fmmy010) IS NULL)"        
   #160122-00001#6 by 07900 --add---end
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_fmmy_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.fmmystus,t0.fmmydocno,t0.fmmy001,t0.fmmy002,t0.fmmy003,t0.fmmy004,t0.fmmy005, 
       t0.fmmy006,t0.fmmy007,t0.fmmy008,t0.fmmy009,t0.fmmy010,t0.fmmydocdt,t0.fmmysite",
               " FROM fmmy_t t0 ",
               "  ",
               
               " WHERE t0.fmmyent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fmmy_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
     #160122-00001#6 add -- str
    LET g_sql = " SELECT t0.fmmystus,t0.fmmydocno,t0.fmmy001,t0.fmmy002,t0.fmmy003,t0.fmmy004,t0.fmmy005, 
       t0.fmmy006,t0.fmmy007,t0.fmmy008,t0.fmmy009,t0.fmmy010,t0.fmmydocdt,t0.fmmysite",
               " FROM fmmy_t t0 ",
               " WHERE t0.fmmyent = '" ||g_enterprise|| "'",
               " AND (t0.fmmy010 IN(",g_sql_bank,") OR TRIM(t0.fmmy010) IS NULL  ) ",    #160122-00001#6 By 07900 mod           
               " AND ", ls_wc, cl_sql_add_filter("fmmy_t")
    #160122-00001#6 add -- end    
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmmy_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmmydocno,g_browser[g_cnt].b_fmmy001, 
          g_browser[g_cnt].b_fmmy002,g_browser[g_cnt].b_fmmy003,g_browser[g_cnt].b_fmmy004,g_browser[g_cnt].b_fmmy005, 
          g_browser[g_cnt].b_fmmy006,g_browser[g_cnt].b_fmmy007,g_browser[g_cnt].b_fmmy008,g_browser[g_cnt].b_fmmy009, 
          g_browser[g_cnt].b_fmmy010,g_browser[g_cnt].b_fmmydocdt,g_browser[g_cnt].b_fmmysite
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         #遮罩相關處理
         CALL afmt590_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
 
      FREE browse_pre
 
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_fmmydocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt590.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt590_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_fmmy_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fmmysite,fmmydocdt,fmmydocno,fmmy001,fmmy002,fmmystus,fmmy003,fmmy004, 
          fmmy005,fmmy007,fmmy013,fmmy028,fmmy019,fmmy029,fmmy015,fmmy016,fmmy017,fmmy018,fmmy021,fmmy022, 
          fmmy024,fmmy025,fmmy023,fmmy020,fmmy027,fmmy026,fmmy006,fmmy014,fmmy008,fmmy009,fmmy010,fmmy012, 
          fmmy011,fmmyownid,fmmyowndp,fmmycrtid,fmmycrtdp,fmmycrtdt,fmmymodid,fmmymoddt,fmmycnfid,fmmycnfdt, 
          fmmypstid,fmmypstdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmmycrtdt>>----
         AFTER FIELD fmmycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmmymoddt>>----
         AFTER FIELD fmmymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmycnfdt>>----
         AFTER FIELD fmmycnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmypstdt>>----
         AFTER FIELD fmmypstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmysite
            #add-point:BEFORE FIELD fmmysite name="construct.b.fmmysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmysite
            
            #add-point:AFTER FIELD fmmysite name="construct.a.fmmysite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmysite
            #add-point:ON ACTION controlp INFIELD fmmysite name="construct.c.fmmysite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#14   mark                    
            CALL q_ooef001_33()   #161006-00005#14   add
            DISPLAY g_qryparam.return1 TO fmmysite
            NEXT FIELD fmmysite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmydocdt
            #add-point:BEFORE FIELD fmmydocdt name="construct.b.fmmydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmydocdt
            
            #add-point:AFTER FIELD fmmydocdt name="construct.a.fmmydocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmydocdt
            #add-point:ON ACTION controlp INFIELD fmmydocdt name="construct.c.fmmydocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmydocno
            #add-point:BEFORE FIELD fmmydocno name="construct.b.fmmydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmydocno
            
            #add-point:AFTER FIELD fmmydocno name="construct.a.fmmydocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmydocno
            #add-point:ON ACTION controlp INFIELD fmmydocno name="construct.c.fmmydocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161104-00046#21-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#21-----e
            CALL q_fmmydocno()
            DISPLAY g_qryparam.return1 TO fmmydocno
            NEXT FIELD fmmydocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy001
            #add-point:BEFORE FIELD fmmy001 name="construct.b.fmmy001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy001
            
            #add-point:AFTER FIELD fmmy001 name="construct.a.fmmy001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy001
            #add-point:ON ACTION controlp INFIELD fmmy001 name="construct.c.fmmy001"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmmjdocno()
            DISPLAY g_qryparam.return1 TO fmmy001
            NEXT FIELD fmmy001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy002
            #add-point:BEFORE FIELD fmmy002 name="construct.b.fmmy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy002
            
            #add-point:AFTER FIELD fmmy002 name="construct.a.fmmy002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy002
            #add-point:ON ACTION controlp INFIELD fmmy002 name="construct.c.fmmy002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO fmmy002  #顯示到畫面上
            NEXT FIELD fmmy002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmystus
            #add-point:BEFORE FIELD fmmystus name="construct.b.fmmystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmystus
            
            #add-point:AFTER FIELD fmmystus name="construct.a.fmmystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmystus
            #add-point:ON ACTION controlp INFIELD fmmystus name="construct.c.fmmystus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy003
            #add-point:BEFORE FIELD fmmy003 name="construct.b.fmmy003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy003
            
            #add-point:AFTER FIELD fmmy003 name="construct.a.fmmy003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy003
            #add-point:ON ACTION controlp INFIELD fmmy003 name="construct.c.fmmy003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy004
            #add-point:BEFORE FIELD fmmy004 name="construct.b.fmmy004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy004
            
            #add-point:AFTER FIELD fmmy004 name="construct.a.fmmy004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy004
            #add-point:ON ACTION controlp INFIELD fmmy004 name="construct.c.fmmy004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy005
            #add-point:BEFORE FIELD fmmy005 name="construct.b.fmmy005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy005
            
            #add-point:AFTER FIELD fmmy005 name="construct.a.fmmy005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy005
            #add-point:ON ACTION controlp INFIELD fmmy005 name="construct.c.fmmy005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy007
            #add-point:BEFORE FIELD fmmy007 name="construct.b.fmmy007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy007
            
            #add-point:AFTER FIELD fmmy007 name="construct.a.fmmy007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy007
            #add-point:ON ACTION controlp INFIELD fmmy007 name="construct.c.fmmy007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy013
            #add-point:BEFORE FIELD fmmy013 name="construct.b.fmmy013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy013
            
            #add-point:AFTER FIELD fmmy013 name="construct.a.fmmy013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy013
            #add-point:ON ACTION controlp INFIELD fmmy013 name="construct.c.fmmy013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy028
            #add-point:BEFORE FIELD fmmy028 name="construct.b.fmmy028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy028
            
            #add-point:AFTER FIELD fmmy028 name="construct.a.fmmy028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy028
            #add-point:ON ACTION controlp INFIELD fmmy028 name="construct.c.fmmy028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy019
            #add-point:BEFORE FIELD fmmy019 name="construct.b.fmmy019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy019
            
            #add-point:AFTER FIELD fmmy019 name="construct.a.fmmy019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy019
            #add-point:ON ACTION controlp INFIELD fmmy019 name="construct.c.fmmy019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy029
            #add-point:BEFORE FIELD fmmy029 name="construct.b.fmmy029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy029
            
            #add-point:AFTER FIELD fmmy029 name="construct.a.fmmy029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy029
            #add-point:ON ACTION controlp INFIELD fmmy029 name="construct.c.fmmy029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy015
            #add-point:BEFORE FIELD fmmy015 name="construct.b.fmmy015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy015
            
            #add-point:AFTER FIELD fmmy015 name="construct.a.fmmy015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy015
            #add-point:ON ACTION controlp INFIELD fmmy015 name="construct.c.fmmy015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy016
            #add-point:BEFORE FIELD fmmy016 name="construct.b.fmmy016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy016
            
            #add-point:AFTER FIELD fmmy016 name="construct.a.fmmy016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy016
            #add-point:ON ACTION controlp INFIELD fmmy016 name="construct.c.fmmy016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy017
            #add-point:BEFORE FIELD fmmy017 name="construct.b.fmmy017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy017
            
            #add-point:AFTER FIELD fmmy017 name="construct.a.fmmy017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy017
            #add-point:ON ACTION controlp INFIELD fmmy017 name="construct.c.fmmy017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy018
            #add-point:BEFORE FIELD fmmy018 name="construct.b.fmmy018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy018
            
            #add-point:AFTER FIELD fmmy018 name="construct.a.fmmy018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy018
            #add-point:ON ACTION controlp INFIELD fmmy018 name="construct.c.fmmy018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy021
            #add-point:BEFORE FIELD fmmy021 name="construct.b.fmmy021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy021
            
            #add-point:AFTER FIELD fmmy021 name="construct.a.fmmy021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy021
            #add-point:ON ACTION controlp INFIELD fmmy021 name="construct.c.fmmy021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy022
            #add-point:BEFORE FIELD fmmy022 name="construct.b.fmmy022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy022
            
            #add-point:AFTER FIELD fmmy022 name="construct.a.fmmy022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy022
            #add-point:ON ACTION controlp INFIELD fmmy022 name="construct.c.fmmy022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy024
            #add-point:BEFORE FIELD fmmy024 name="construct.b.fmmy024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy024
            
            #add-point:AFTER FIELD fmmy024 name="construct.a.fmmy024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy024
            #add-point:ON ACTION controlp INFIELD fmmy024 name="construct.c.fmmy024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy025
            #add-point:BEFORE FIELD fmmy025 name="construct.b.fmmy025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy025
            
            #add-point:AFTER FIELD fmmy025 name="construct.a.fmmy025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy025
            #add-point:ON ACTION controlp INFIELD fmmy025 name="construct.c.fmmy025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy023
            #add-point:BEFORE FIELD fmmy023 name="construct.b.fmmy023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy023
            
            #add-point:AFTER FIELD fmmy023 name="construct.a.fmmy023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy023
            #add-point:ON ACTION controlp INFIELD fmmy023 name="construct.c.fmmy023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy020
            #add-point:BEFORE FIELD fmmy020 name="construct.b.fmmy020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy020
            
            #add-point:AFTER FIELD fmmy020 name="construct.a.fmmy020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy020
            #add-point:ON ACTION controlp INFIELD fmmy020 name="construct.c.fmmy020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy027
            #add-point:BEFORE FIELD fmmy027 name="construct.b.fmmy027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy027
            
            #add-point:AFTER FIELD fmmy027 name="construct.a.fmmy027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy027
            #add-point:ON ACTION controlp INFIELD fmmy027 name="construct.c.fmmy027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy026
            #add-point:BEFORE FIELD fmmy026 name="construct.b.fmmy026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy026
            
            #add-point:AFTER FIELD fmmy026 name="construct.a.fmmy026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy026
            #add-point:ON ACTION controlp INFIELD fmmy026 name="construct.c.fmmy026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy006
            #add-point:BEFORE FIELD fmmy006 name="construct.b.fmmy006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy006
            
            #add-point:AFTER FIELD fmmy006 name="construct.a.fmmy006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy006
            #add-point:ON ACTION controlp INFIELD fmmy006 name="construct.c.fmmy006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy014
            #add-point:BEFORE FIELD fmmy014 name="construct.b.fmmy014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy014
            
            #add-point:AFTER FIELD fmmy014 name="construct.a.fmmy014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy014
            #add-point:ON ACTION controlp INFIELD fmmy014 name="construct.c.fmmy014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy008
            #add-point:BEFORE FIELD fmmy008 name="construct.b.fmmy008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy008
            
            #add-point:AFTER FIELD fmmy008 name="construct.a.fmmy008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy008
            #add-point:ON ACTION controlp INFIELD fmmy008 name="construct.c.fmmy008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy009
            #add-point:BEFORE FIELD fmmy009 name="construct.b.fmmy009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy009
            
            #add-point:AFTER FIELD fmmy009 name="construct.a.fmmy009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy009
            #add-point:ON ACTION controlp INFIELD fmmy009 name="construct.c.fmmy009"
            #160122-00001#36--add--str--
            #收款銀行
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t ",
                                   "              WHERE nmaaent=nmasent AND nmaa001=nmas001 ",
                                   "                AND nmaaent=",g_enterprise," AND nmaastus='Y'",
                                   "                AND nmas002 IN (",g_sql_bank,")",
                                   "             )"
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmy009  #顯示到畫面上
            NEXT FIELD fmmy009
            #160122-00001#36--add--end
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy010
            #add-point:BEFORE FIELD fmmy010 name="construct.b.fmmy010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy010
            
            #add-point:AFTER FIELD fmmy010 name="construct.a.fmmy010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy010
            #add-point:ON ACTION controlp INFIELD fmmy010 name="construct.c.fmmy010"
            #150820-00011#8---s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#6 add -- str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#6 By 07900 --mod
            #160122-00001#6 end -- end
            CALL q_nmas_01()
            DISPLAY  g_qryparam.return1 TO fmmy010
            NEXT FIELD fmmy010
            #150820-00011#8---e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy012
            #add-point:BEFORE FIELD fmmy012 name="construct.b.fmmy012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy012
            
            #add-point:AFTER FIELD fmmy012 name="construct.a.fmmy012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy012
            #add-point:ON ACTION controlp INFIELD fmmy012 name="construct.c.fmmy012"
            #150820-00011#8---s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "nmaj002 = '1' "
            CALL q_nmad002_1()                                 #呼叫開窗
            DISPLAY g_qryparam.return1 TO g_fmmy_m.fmmy012
            NEXT FIELD fmmy012                             #返回原欄位
            #150820-00011#8---e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy011
            #add-point:BEFORE FIELD fmmy011 name="construct.b.fmmy011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy011
            
            #add-point:AFTER FIELD fmmy011 name="construct.a.fmmy011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmy011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy011
            #add-point:ON ACTION controlp INFIELD fmmy011 name="construct.c.fmmy011"
            #150820-00011#8---s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO g_fmmy_m.fmmy011
            NEXT FIELD fmmy011                              #返回原欄位
            #150820-00011#8---e
            #END add-point
 
 
         #Ctrlp:construct.c.fmmyownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmyownid
            #add-point:ON ACTION controlp INFIELD fmmyownid name="construct.c.fmmyownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmyownid  #顯示到畫面上
            NEXT FIELD fmmyownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmyownid
            #add-point:BEFORE FIELD fmmyownid name="construct.b.fmmyownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmyownid
            
            #add-point:AFTER FIELD fmmyownid name="construct.a.fmmyownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmyowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmyowndp
            #add-point:ON ACTION controlp INFIELD fmmyowndp name="construct.c.fmmyowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmyowndp  #顯示到畫面上
            NEXT FIELD fmmyowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmyowndp
            #add-point:BEFORE FIELD fmmyowndp name="construct.b.fmmyowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmyowndp
            
            #add-point:AFTER FIELD fmmyowndp name="construct.a.fmmyowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmycrtid
            #add-point:ON ACTION controlp INFIELD fmmycrtid name="construct.c.fmmycrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmycrtid  #顯示到畫面上
            NEXT FIELD fmmycrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmycrtid
            #add-point:BEFORE FIELD fmmycrtid name="construct.b.fmmycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmycrtid
            
            #add-point:AFTER FIELD fmmycrtid name="construct.a.fmmycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmycrtdp
            #add-point:ON ACTION controlp INFIELD fmmycrtdp name="construct.c.fmmycrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmycrtdp  #顯示到畫面上
            NEXT FIELD fmmycrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmycrtdp
            #add-point:BEFORE FIELD fmmycrtdp name="construct.b.fmmycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmycrtdp
            
            #add-point:AFTER FIELD fmmycrtdp name="construct.a.fmmycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmycrtdt
            #add-point:BEFORE FIELD fmmycrtdt name="construct.b.fmmycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmymodid
            #add-point:ON ACTION controlp INFIELD fmmymodid name="construct.c.fmmymodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmymodid  #顯示到畫面上
            NEXT FIELD fmmymodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmymodid
            #add-point:BEFORE FIELD fmmymodid name="construct.b.fmmymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmymodid
            
            #add-point:AFTER FIELD fmmymodid name="construct.a.fmmymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmymoddt
            #add-point:BEFORE FIELD fmmymoddt name="construct.b.fmmymoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmycnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmycnfid
            #add-point:ON ACTION controlp INFIELD fmmycnfid name="construct.c.fmmycnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmycnfid  #顯示到畫面上
            NEXT FIELD fmmycnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmycnfid
            #add-point:BEFORE FIELD fmmycnfid name="construct.b.fmmycnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmycnfid
            
            #add-point:AFTER FIELD fmmycnfid name="construct.a.fmmycnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmycnfdt
            #add-point:BEFORE FIELD fmmycnfdt name="construct.b.fmmycnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmypstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmypstid
            #add-point:ON ACTION controlp INFIELD fmmypstid name="construct.c.fmmypstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmypstid  #顯示到畫面上
            NEXT FIELD fmmypstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmypstid
            #add-point:BEFORE FIELD fmmypstid name="construct.b.fmmypstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmypstid
            
            #add-point:AFTER FIELD fmmypstid name="construct.a.fmmypstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmypstdt
            #add-point:BEFORE FIELD fmmypstdt name="construct.b.fmmypstdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   #161104-00046#21-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#21-----e
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="afmt590.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt590_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON fmmydocno,fmmy001,fmmy002,fmmy003,fmmy004,fmmy005,fmmy006,fmmy007,fmmy008, 
          fmmy009,fmmy010,fmmydocdt,fmmysite
                          FROM s_browse[1].b_fmmydocno,s_browse[1].b_fmmy001,s_browse[1].b_fmmy002,s_browse[1].b_fmmy003, 
                              s_browse[1].b_fmmy004,s_browse[1].b_fmmy005,s_browse[1].b_fmmy006,s_browse[1].b_fmmy007, 
                              s_browse[1].b_fmmy008,s_browse[1].b_fmmy009,s_browse[1].b_fmmy010,s_browse[1].b_fmmydocdt, 
                              s_browse[1].b_fmmysite
 
         BEFORE CONSTRUCT
               DISPLAY afmt590_filter_parser('fmmydocno') TO s_browse[1].b_fmmydocno
            DISPLAY afmt590_filter_parser('fmmy001') TO s_browse[1].b_fmmy001
            DISPLAY afmt590_filter_parser('fmmy002') TO s_browse[1].b_fmmy002
            DISPLAY afmt590_filter_parser('fmmy003') TO s_browse[1].b_fmmy003
            DISPLAY afmt590_filter_parser('fmmy004') TO s_browse[1].b_fmmy004
            DISPLAY afmt590_filter_parser('fmmy005') TO s_browse[1].b_fmmy005
            DISPLAY afmt590_filter_parser('fmmy006') TO s_browse[1].b_fmmy006
            DISPLAY afmt590_filter_parser('fmmy007') TO s_browse[1].b_fmmy007
            DISPLAY afmt590_filter_parser('fmmy008') TO s_browse[1].b_fmmy008
            DISPLAY afmt590_filter_parser('fmmy009') TO s_browse[1].b_fmmy009
            DISPLAY afmt590_filter_parser('fmmy010') TO s_browse[1].b_fmmy010
            DISPLAY afmt590_filter_parser('fmmydocdt') TO s_browse[1].b_fmmydocdt
            DISPLAY afmt590_filter_parser('fmmysite') TO s_browse[1].b_fmmysite
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL afmt590_filter_show('fmmydocno')
   CALL afmt590_filter_show('fmmy001')
   CALL afmt590_filter_show('fmmy002')
   CALL afmt590_filter_show('fmmy003')
   CALL afmt590_filter_show('fmmy004')
   CALL afmt590_filter_show('fmmy005')
   CALL afmt590_filter_show('fmmy006')
   CALL afmt590_filter_show('fmmy007')
   CALL afmt590_filter_show('fmmy008')
   CALL afmt590_filter_show('fmmy009')
   CALL afmt590_filter_show('fmmy010')
   CALL afmt590_filter_show('fmmydocdt')
   CALL afmt590_filter_show('fmmysite')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt590_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="afmt590.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt590_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = afmt590_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt590_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_fmmy_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afmt590_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt590_browser_fill(g_wc,"F")
      CALL afmt590_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afmt590_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt590_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afmt590.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt590_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_fmmy_m.fmmydocno = g_browser[g_current_idx].b_fmmydocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
       g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
       g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
       g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
       g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
       g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
       g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
       g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
       g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
   
   #遮罩相關處理
   LET g_fmmy_m_mask_o.* =  g_fmmy_m.*
   CALL afmt590_fmmy_t_mask()
   LET g_fmmy_m_mask_n.* =  g_fmmy_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt590_set_act_visible()
   CALL afmt590_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fmmy_m_t.* = g_fmmy_m.*
   LET g_fmmy_m_o.* = g_fmmy_m.*
   
   LET g_data_owner = g_fmmy_m.fmmyownid      
   LET g_data_dept  = g_fmmy_m.fmmyowndp
   
   #重新顯示
   CALL afmt590_show()
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt590_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fmmy_m.* TO NULL             #DEFAULT 設定
   LET g_fmmydocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmy_m.fmmyownid = g_user
      LET g_fmmy_m.fmmyowndp = g_dept
      LET g_fmmy_m.fmmycrtid = g_user
      LET g_fmmy_m.fmmycrtdp = g_dept 
      LET g_fmmy_m.fmmycrtdt = cl_get_current()
      LET g_fmmy_m.fmmymodid = g_user
      LET g_fmmy_m.fmmymoddt = cl_get_current()
      LET g_fmmy_m.fmmystus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmmy_m.fmmy003 = "0"
      LET g_fmmy_m.fmmy004 = "0"
      LET g_fmmy_m.fmmy005 = "0"
      LET g_fmmy_m.fmmy007 = "0"
      LET g_fmmy_m.fmmy013 = "0"
      LET g_fmmy_m.fmmy028 = "0"
      LET g_fmmy_m.fmmy019 = "0"
      LET g_fmmy_m.fmmy029 = "0"
      LET g_fmmy_m.fmmy015 = "0"
      LET g_fmmy_m.fmmy016 = "0"
      LET g_fmmy_m.l_fmmz003 = "0"
      LET g_fmmy_m.l_fmmz011 = "0"
      LET g_fmmy_m.fmmy017 = "0"
      LET g_fmmy_m.fmmy018 = "0"
      LET g_fmmy_m.fmmy021 = "0"
      LET g_fmmy_m.fmmy022 = "0"
      LET g_fmmy_m.fmmy024 = "0"
      LET g_fmmy_m.fmmy025 = "0"
      LET g_fmmy_m.fmmy023 = "0"
      LET g_fmmy_m.fmmy020 = "0"
      LET g_fmmy_m.fmmy027 = "0"
      LET g_fmmy_m.fmmy026 = "0"
      LET g_fmmy_m.fmmy006 = "0"
      LET g_fmmy_m.fmmy014 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_fmmy_m.fmmydocdt = g_today
      LET g_fmmy_m.fmmy008 = '1'
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmy_m.fmmystus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL afmt590_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fmmy_m.* TO NULL
         CALL afmt590_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt590_set_act_visible()
   CALL afmt590_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmmydocno_t = g_fmmy_m.fmmydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmyent = " ||g_enterprise|| " AND",
                      " fmmydocno = '", g_fmmy_m.fmmydocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt590_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
       g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
       g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
       g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
       g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
       g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
       g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
       g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
       g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
   
   
   #遮罩相關處理
   LET g_fmmy_m_mask_o.* =  g_fmmy_m.*
   CALL afmt590_fmmy_t_mask()
   LET g_fmmy_m_mask_n.* =  g_fmmy_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001, 
       g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_1_desc,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_2_desc, 
       g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_3_desc,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmy002_desc, 
       g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013, 
       g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003, 
       g_fmmy_m.l_fmmz011,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024, 
       g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
       g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc, 
       g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc,g_fmmy_m.fmmyownid, 
       g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymodid_desc, 
       g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmycnfdt,g_fmmy_m.fmmypstid, 
       g_fmmy_m.fmmypstid_desc,g_fmmy_m.fmmypstdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_fmmy_m.fmmyownid      
   LET g_data_dept  = g_fmmy_m.fmmyowndp
 
   #功能已完成,通報訊息中心
   CALL afmt590_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt590.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt590_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmmy_m.fmmydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_fmmydocno_t = g_fmmy_m.fmmydocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afmt590_cl USING g_enterprise,g_fmmy_m.fmmydocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt590_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt590_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
       g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
       g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
       g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
       g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
       g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
       g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
       g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
       g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
 
   #檢查是否允許此動作
   IF NOT afmt590_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fmmy_m_mask_o.* =  g_fmmy_m.*
   CALL afmt590_fmmy_t_mask()
   LET g_fmmy_m_mask_n.* =  g_fmmy_m.*
   
   
 
   #顯示資料
   CALL afmt590_show()
   
   WHILE TRUE
      LET g_fmmy_m.fmmydocno = g_fmmydocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_fmmy_m.fmmymodid = g_user 
LET g_fmmy_m.fmmymoddt = cl_get_current()
LET g_fmmy_m.fmmymodid_desc = cl_get_username(g_fmmy_m.fmmymodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afmt590_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fmmy_m.* = g_fmmy_m_t.*
         CALL afmt590_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE fmmy_t SET (fmmymodid,fmmymoddt) = (g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt)
       WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmydocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt590_set_act_visible()
   CALL afmt590_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmmyent = " ||g_enterprise|| " AND",
                      " fmmydocno = '", g_fmmy_m.fmmydocno, "' "
 
   #填到對應位置
   CALL afmt590_browser_fill(g_wc,"")
 
   CLOSE afmt590_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt590_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afmt590.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt590_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_num1          LIKE type_t.num10
   DEFINE l_num2          LIKE type_t.num10
   DEFINE l_amount_fmmg   LIKE type_t.num20_6
   DEFINE l_amount_used   LIKE type_t.num20_6
   DEFINE l_glaa005       LIKE glaa_t.glaa005    #150820-00011#8
   
   #151029-00012#12-----s
   DEFINE l_fmmj006       LIKE fmmj_t.fmmj006
   #151029-00012#12-----e
   DEFINE l_fmma005       LIKE fmma_t.fmma005
   DEFINE l_fmmj009       LIKE fmmj_t.fmmj009
   #151105-00008#5-----s
   DEFINE l_fmmk     RECORD
                     fmmk004    LIKE fmmk_t.fmmk004,
                     fmmk005    LIKE fmmk_t.fmmk005,
                     fmmk013    LIKE fmmk_t.fmmk013
                     END RECORD                     
   DEFINE l_sum10x   LIKE type_t.num20_6
   DEFINE l_sql      STRING
   DEFINE l_10x      LIKE type_t.num20_6
   DEFINE l_rate     LIKE type_t.num20_6
   DEFINE l_fmma003  LIKE fmma_t.fmma003
   DEFINE l_sum11x   LIKE type_t.num20_6
   #151105-00008#5-----e
   DEFINE l_flag     LIKE type_t.num5      #161104-00046#21
   DEFINE l_slip     LIKE ooba_t.ooba002   #161104-00046#21
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001, 
       g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_1_desc,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_2_desc, 
       g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_3_desc,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmy002_desc, 
       g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013, 
       g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003, 
       g_fmmy_m.l_fmmz011,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024, 
       g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
       g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc, 
       g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc,g_fmmy_m.fmmyownid, 
       g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymodid_desc, 
       g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmycnfdt,g_fmmy_m.fmmypstid, 
       g_fmmy_m.fmmypstid_desc,g_fmmy_m.fmmypstdt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL afmt590_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt590_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   #150820-00011#8---s
   LET l_glaa005 = ''
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaald = g_glaald AND glaaent = g_enterprise
   IF g_fmmy_m.fmmy008 = '1' THEN
      CALL cl_set_comp_required("fmmy011,fmmy012",FALSE)
   ELSE
      CALL cl_set_comp_required("fmmy011,fmmy012",TRUE)
   END IF
   #150820-00011#8---e
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.l_fmmy001_1, 
          g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus, 
          g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028, 
          g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003,g_fmmy_m.l_fmmz011, 
          g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024,g_fmmy_m.fmmy025, 
          g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006,g_fmmy_m.fmmy014, 
          g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012,g_fmmy_m.fmmy011 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmysite
            
            #add-point:AFTER FIELD fmmysite name="input.a.fmmysite"
            LET g_fmmy_m.fmmysite_desc  = ' '
            DISPLAY BY NAME g_fmmy_m.fmmysite_desc 
            IF NOT cl_null(g_fmmy_m.fmmysite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmysite  != g_fmmy_m_t.fmmysite OR g_fmmy_m_t.fmmysite IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmysite  != g_fmmy_m_o.fmmysite OR cl_null(g_fmmy_m_o.fmmysite) THEN                                       #160822-00012#4   add
                  
                  CALL s_fin_account_center_chk(g_fmmy_m.fmmysite,'','6','')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmy_m.fmmysite  = g_fmmy_m_t.fmmysite   #160822-00012#4   mark
                     LET g_fmmy_m.fmmysite  = g_fmmy_m_o.fmmysite    #160822-00012#4   add
                     LET g_fmmy_m.fmmysite_desc = s_desc_get_department_desc(g_fmmy_m.fmmysite)
                     DISPLAY BY NAME g_fmmy_m.fmmysite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓組織所屬法人主帳套
                  SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
                   WHERE glaaent = ooefent
                     AND glaacomp = ooef017
                     AND ooef001 = g_fmmy_m.fmmysite
                     AND ooefent = g_enterprise
                     AND glaa014 = 'Y'
                  SELECT glaacomp,glaa024,glaa026,glaa001,glaa025
                    INTO g_glaa.*
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_glaald
#                  IF NOT cl_null(g_glaa.glaacomp) AND NOT cl_null(g_glaald) AND NOT cl_null(g_fmmy_m.fmmydocdt)
#                     AND NOT cl_null(g_fmmy_m.fmmy002)THEN
#                     CALL s_fin_get_curr_rate(g_glaa.glaacomp,g_glaald,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmy002,'')
#                             RETURNING g_fmmy_m.fmmy007,l_num1,l_num2
#                  END IF   


                  #151103-00016#4 modify-----s 
                  LET l_fmma005 = NULL
                  SELECT fmma005 INTO l_fmma005 FROM fmma_t
                   WHERE fmmaent = g_enterprise
                     AND fmma001 = g_fmmy_m.l_fmmy001_3
                     
                  IF l_fmma005 = 'N' THEN
                     IF NOT cl_null(g_fmmy_m.fmmysite) AND NOT cl_null(g_fmmy_m.fmmy002) AND NOT cl_null(g_fmmy_m.fmmydocdt) 
                        AND NOT cl_null(g_glaald) AND NOT cl_null(g_glaa.glaa001) AND NOT cl_null(g_glaa.glaa025) THEN
                        CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmy002,g_glaa.glaa001,0,g_glaa.glaa025)
                             RETURNING g_fmmy_m.fmmy007
                     END IF                 
                  ELSE     
                     LET l_fmmj009 = NULL
                     SELECT fmmj009 INTO l_fmmj009 FROM fmmj_t
                      WHERE fmmjent = g_enterprise
                        AND fmmjdocno = g_fmmy_m.fmmy001
                     IF cl_null(l_fmmj009)THEN LET l_fmmj009 = 0 END IF

                     LET g_fmmy_m.fmmy007 = l_fmmj009
                  END IF
                  DISPLAY BY NAME g_fmmy_m.fmmy007
                  #151103-00016#4 modify-----e
                  
               END IF
            END IF
            LET g_fmmy_m.fmmysite_desc = s_desc_get_department_desc(g_fmmy_m.fmmysite)
            DISPLAY BY NAME g_fmmy_m.fmmysite_desc
            #150820-00011#8---s
            LET l_glaa005 = ''
            SELECT glaa005 INTO l_glaa005
              FROM glaa_t
             WHERE glaald = g_glaald AND glaaent = g_enterprise
            #150820-00011#8---e
            
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmysite
            #add-point:BEFORE FIELD fmmysite name="input.b.fmmysite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmysite
            #add-point:ON CHANGE fmmysite name="input.g.fmmysite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmydocdt
            #add-point:BEFORE FIELD fmmydocdt name="input.b.fmmydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmydocdt
            
            #add-point:AFTER FIELD fmmydocdt name="input.a.fmmydocdt"
            IF NOT cl_null(g_fmmy_m.fmmydocdt) THEN
               #IF cl_null(g_fmmy_m_t.fmmydocdt) OR (g_fmmy_m_t.fmmydocdt <> g_fmmy_m.fmmydocdt)THEN   #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmydocdt) OR (g_fmmy_m.fmmydocdt != g_fmmy_m_o.fmmydocdt)THEN   #160822-00012#4   add
                  CALL afmt590_get_interest()      #150702-00003#4
                  CALL afmt590_fmmy_source_fmmt('3')RETURNING g_fmmy_m.fmmy021,g_fmmy_m.fmmy022   #albireo 151113 add
                  #151117-00001#4-----s
                  CALL afmt590_account_fomula('H1')
                  CALL afmt590_account_fomula('H2')
                  #151117-00001#4-----e
                  CALL afmt590_account_fomula('F1')   #151105-00008#5
               END IF
            END IF
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmydocdt
            #add-point:ON CHANGE fmmydocdt name="input.g.fmmydocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmydocno
            #add-point:BEFORE FIELD fmmydocno name="input.b.fmmydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmydocno
            
            #add-point:AFTER FIELD fmmydocno name="input.a.fmmydocno"
            IF NOT cl_null(g_fmmy_m.fmmydocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmydocno != g_fmmy_m_t.fmmydocno OR g_fmmy_m_t.fmmydocno IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmydocno != g_fmmy_m_o.fmmydocno OR cl_null(g_fmmy_m_o.fmmydocno) THEN                                       #160822-00012#4   add
                   IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_fmmy_m.fmmydocno,g_fmmy_m.fmmydocdt,g_prog) THEN
                     #LET g_fmmy_m.fmmydocno = g_fmmy_m_t.fmmydocno   #160822-00012#4   mark
                     LET g_fmmy_m.fmmydocno = g_fmmy_m_o.fmmydocno    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#21-----s
                  CALL s_control_chk_doc('1',g_fmmy_m.fmmydocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_fmmy_m.fmmydocno = g_fmmy_m_o.fmmydocno 
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL s_aooi200_fin_get_slip(g_fmmy_m.fmmydocno) RETURNING g_sub_success,l_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_fmmy_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_fmmy_m.fmmysite,'2',l_slip,'','',g_glaald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_fmmy_m.* FROM s_aooi200def1
                  #161104-00046#21-----e  
               END IF
            END IF
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmydocno
            #add-point:ON CHANGE fmmydocno name="input.g.fmmydocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy001
            #add-point:BEFORE FIELD fmmy001 name="input.b.fmmy001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy001
            
            #add-point:AFTER FIELD fmmy001 name="input.a.fmmy001"

            IF NOT cl_null(g_fmmy_m.fmmy001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy001 != g_fmmy_m_t.fmmy001 OR g_fmmy_m_t.fmmy001 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmy001 != g_fmmy_m_o.fmmy001 OR cl_null(g_fmmy_m_o.fmmy001) THEN                                       #160822-00012#4   add
                  CALL afmt590_fmmy001_chk(g_fmmy_m.fmmy001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmy_m.fmmy001 = g_fmmy_m_t.fmmy001   #160822-00012#4   mark
                     LET g_fmmy_m.fmmy001 = g_fmmy_m_o.fmmy001    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL afmt590_get_source_used_amount(g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,p_cmd)
                     RETURNING g_sub_success,g_errno,l_amount_fmmg,l_amount_used
                  IF l_amount_used <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmy_m.fmmy001 = g_fmmy_m_t.fmmy001   #160822-00012#4   mark
                     LET g_fmmy_m.fmmy001 = g_fmmy_m_o.fmmy001    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF   
                     
                  #151102 albireo-----s
                  LET g_fmmy_m.fmmy003 = 0
                  LET g_fmmy_m.fmmy004 = 0
                  LET g_fmmy_m.fmmy005 = 0
                  LET g_fmmy_m.fmmy006 = 0
                  LET g_fmmy_m.fmmy007 = 0
                  LET g_fmmy_m.fmmy019 = 0
                  LET g_fmmy_m.fmmy013 = 0
                  LET g_fmmy_m.fmmy014 = 0
                  LET g_fmmy_m.fmmy015 = 0
                  LET g_fmmy_m.fmmy016 = 0
                  LET g_fmmy_m.fmmy017 = 0   
                  LET g_fmmy_m.fmmy018 = 0
                  LET g_fmmy_m.fmmy019 = 0
                  LET g_fmmy_m.fmmy020 = 0
                  #151102 albireo-----e
                                    
                     
                     
                  LET g_fmmy_m.fmmy003 = l_amount_used
                  
                  CALL afmt590_fmmy001_desc(g_fmmy_m.fmmy001)    #albireo 151111 modify
                  IF NOT cl_null(g_fmmy_m.fmmy004)THEN
                     LET g_fmmy_m.fmmy005 = g_fmmy_m.fmmy004 * g_fmmy_m.fmmy003
                     CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,g_fmmy_m.fmmy005,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy005 #150924-00006#4
                     
                  END IF
                  

                  #151029-00012#7---s
                  IF NOT cl_null(g_fmmy_m.fmmy005)THEN
                     LET g_fmmy_m.fmmy013 = g_fmmy_m.fmmy005 * g_fmmy_m.fmmy007
                     CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy013,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy013
                  END IF
                  #151029-00012#7---e

                  
#                  IF NOT cl_null(g_glaa.glaacomp) AND NOT cl_null(g_glaald) AND NOT cl_null(g_fmmy_m.fmmydocdt)
#                     AND NOT cl_null(g_fmmy_m.fmmy002)THEN
#                     CALL s_fin_get_curr_rate(g_glaa.glaacomp,g_glaald,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmy002,'')
#                             RETURNING g_fmmy_m.fmmy007,l_num1,l_num2
#                  END IF   
#                  IF NOT cl_null(g_fmmy_m.fmmysite) AND NOT cl_null(g_fmmy_m.fmmy002) AND NOT cl_null(g_fmmy_m.fmmydocdt) 
#                     AND NOT cl_null(g_glaald) AND NOT cl_null(g_glaa.glaa001) AND NOT cl_null(g_glaa.glaa025) THEN
#                     CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmy002,g_glaa.glaa001,0,g_glaa.glaa025)
#                          RETURNING g_fmmy_m.fmmy007
#                  END IF                     
#                  DISPLAY BY NAME g_fmmy_m.fmmy007     

                  #151103-00016#4 modify-----s 
                  LET l_fmma005 = NULL
                  SELECT fmma005 INTO l_fmma005 FROM fmma_t
                   WHERE fmmaent = g_enterprise
                     AND fmma001 = g_fmmy_m.l_fmmy001_3
                     
                  IF l_fmma005 = 'N' THEN
                     IF NOT cl_null(g_fmmy_m.fmmysite) AND NOT cl_null(g_fmmy_m.fmmy002) AND NOT cl_null(g_fmmy_m.fmmydocdt) 
                        AND NOT cl_null(g_glaald) AND NOT cl_null(g_glaa.glaa001) AND NOT cl_null(g_glaa.glaa025) THEN
                        CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmy002,g_glaa.glaa001,0,g_glaa.glaa025)
                             RETURNING g_fmmy_m.fmmy007
                     END IF                 
                  ELSE     
                     LET l_fmmj009 = NULL
                     SELECT fmmj009 INTO l_fmmj009 FROM fmmj_t
                      WHERE fmmjent = g_enterprise
                        AND fmmjdocno = g_fmmy_m.fmmy001
                     IF cl_null(l_fmmj009)THEN LET l_fmmj009 = 0 END IF

                     LET g_fmmy_m.fmmy007 = l_fmmj009
                  END IF
                  DISPLAY BY NAME g_fmmy_m.fmmy007
                  #151103-00016#4 modify-----e
                  CALL afmt590_get_interest()      #150702-00003#4
                  
                  CALL afmt590_fmmy_source_fmmt('1')RETURNING g_fmmy_m.fmmy024,g_fmmy_m.fmmy026
                  CALL afmt590_fmmy_source_fmmt('2')RETURNING g_fmmy_m.fmmy025,g_fmmy_m.fmmy027
                  CALL afmt590_fmmy_source_fmmt('3')RETURNING g_fmmy_m.fmmy021,g_fmmy_m.fmmy022
                  
                  #151029-00012#12-----s
                  LET l_fmmj006 = NULL
                  SELECT fmmj006 INTO l_fmmj006 FROM fmmj_t
                   WHERE fmmjent = g_enterprise
                     AND fmmjdocno = g_fmmy_m.fmmy001
                     
                  IF NOT cl_null(g_fmmy_m.fmmysite) AND NOT cl_null(g_glaa.glaa001) AND NOT cl_null(g_fmmy_m.fmmydocdt) 
                     AND NOT cl_null(g_glaald) AND NOT cl_null(g_glaa.glaa025) THEN
                     CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,l_fmmj006,g_glaa.glaa001,0,g_glaa.glaa025)
                          RETURNING g_fmmy_m.fmmy019
                  END IF                  
                  DISPLAY BY NAME g_fmmy_m.fmmy019      
                  #151102 albireo
                  CALL afmt590_account_fomula('A1')
                  CALL afmt590_account_fomula('A2')
                  CALL afmt590_account_fomula('C1')
                  CALL afmt590_account_fomula('C2')                                            
                  #CALL afmt590_account_fomula('D')   160218-00010#1mark
                  #151117-00001#4-----s
                  CALL afmt590_account_fomula('H1')
                  CALL afmt590_account_fomula('H2')
                  #151117-00001#4-----e
                  CALL afmt590_account_fomula('F1')    #151105-00008#5 add
                  CALL afmt590_account_fomula('E1')
                  CALL afmt590_account_fomula('E2')
                  #151029-00012#12-----e
                  CALL afmt590_account_fomula('D')   #160218-00010#1 add
               END IF
            END IF
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add         

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy001
            #add-point:ON CHANGE fmmy001 name="input.g.fmmy001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmy001_1
            
            #add-point:AFTER FIELD l_fmmy001_1 name="input.a.l_fmmy001_1"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmy001_1
            #add-point:BEFORE FIELD l_fmmy001_1 name="input.b.l_fmmy001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmy001_1
            #add-point:ON CHANGE l_fmmy001_1 name="input.g.l_fmmy001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmy001_2
            
            #add-point:AFTER FIELD l_fmmy001_2 name="input.a.l_fmmy001_2"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmy001_2
            #add-point:BEFORE FIELD l_fmmy001_2 name="input.b.l_fmmy001_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmy001_2
            #add-point:ON CHANGE l_fmmy001_2 name="input.g.l_fmmy001_2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmy001_3
            
            #add-point:AFTER FIELD l_fmmy001_3 name="input.a.l_fmmy001_3"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmy001_3
            #add-point:BEFORE FIELD l_fmmy001_3 name="input.b.l_fmmy001_3"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmy001_3
            #add-point:ON CHANGE l_fmmy001_3 name="input.g.l_fmmy001_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmy001_4
            #add-point:BEFORE FIELD l_fmmy001_4 name="input.b.l_fmmy001_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmy001_4
            
            #add-point:AFTER FIELD l_fmmy001_4 name="input.a.l_fmmy001_4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmy001_4
            #add-point:ON CHANGE l_fmmy001_4 name="input.g.l_fmmy001_4"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy002
            
            #add-point:AFTER FIELD fmmy002 name="input.a.fmmy002"
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy002
            #add-point:BEFORE FIELD fmmy002 name="input.b.fmmy002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy002
            #add-point:ON CHANGE fmmy002 name="input.g.fmmy002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmystus
            #add-point:BEFORE FIELD fmmystus name="input.b.fmmystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmystus
            
            #add-point:AFTER FIELD fmmystus name="input.a.fmmystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmystus
            #add-point:ON CHANGE fmmystus name="input.g.fmmystus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy003
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy003 name="input.a.fmmy003"
            IF NOT cl_null(g_fmmy_m.fmmy003) THEN    #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy003) OR (g_fmmy_m_t.fmmy003 <> g_fmmy_m.fmmy003) THEN   #151203-00013#2   #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy003) OR (g_fmmy_m.fmmy003 != g_fmmy_m_o.fmmy003) THEN                      #160822-00012#4   add
                  IF NOT cl_null(g_fmmy_m.fmmy003)THEN
                     CALL afmt590_get_source_used_amount(g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,p_cmd)
                        RETURNING g_sub_success,g_errno,l_amount_fmmg,l_amount_used
                     IF g_fmmy_m.fmmy003 > l_amount_used THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code =  'afm-00082'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmmy_m.fmmy003 = g_fmmy_m.fmmy003
                        NEXT FIELD fmmy003
                     END IF
                     CALL afmt590_get_interest()      #150702-00003#4
                  END IF
                  
                  IF NOT cl_null(g_fmmy_m.fmmy003) AND NOT cl_null(g_fmmy_m.fmmy004) THEN 
                     LET g_fmmy_m.fmmy005 = g_fmmy_m.fmmy003 * g_fmmy_m.fmmy004
                     CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,g_fmmy_m.fmmy005,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy005 #150924-00006#4
                     #151029-00012#7---s
                     IF NOT cl_null(g_fmmy_m.fmmy005)THEN
                        LET g_fmmy_m.fmmy013 = g_fmmy_m.fmmy005 * g_fmmy_m.fmmy007
                        CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy013,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy013
                     END IF
                     #151029-00012#7---e
                     DISPLAY BY NAME g_fmmy_m.fmmy005,g_fmmy_m.fmmy013  #151029-00012#7 add fmmy013
                  END IF 
                  
                  CALL afmt590_fmmy_source_fmmt('3')RETURNING g_fmmy_m.fmmy021,g_fmmy_m.fmmy022   #albireo 151113
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy003)THEN
                     CALL afmt590_account_fomula('A1')
                     CALL afmt590_account_fomula('A2')
                     CALL afmt590_account_fomula('C1')
                     CALL afmt590_account_fomula('C2') 
                               
                     #CALL afmt590_account_fomula('D')   #160218-00010#1mark
                     CALL afmt590_account_fomula('E1')
                     CALL afmt590_account_fomula('E2')
                     #151117-00001#4-----s
                     CALL afmt590_account_fomula('H1')
                     CALL afmt590_account_fomula('H2')
                     #151117-00001#4-----e
                     CALL afmt590_account_fomula('F1')  #151105-00008#5 add
                     CALL afmt590_account_fomula('D')   #160218-00010#1
                  END IF
                  #151029-00012#12-----e
            #151203-00013#2 --s
               END IF                        
            END IF                                                      
            #LET g_fmmy_m_t.* = g_fmmy_m.*    #160822-00012#4   mark
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy003
            #add-point:BEFORE FIELD fmmy003 name="input.b.fmmy003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy003
            #add-point:ON CHANGE fmmy003 name="input.g.fmmy003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy004
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy004 name="input.a.fmmy004"
            IF NOT cl_null(g_fmmy_m.fmmy004)THEN  #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy004) OR (g_fmmy_m_t.fmmy004 <> g_fmmy_m.fmmy004) THEN  #151203-00013#2    #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy004) OR (g_fmmy_m.fmmy004 != g_fmmy_m_o.fmmy004) THEN                      #160822-00012#4   add
                  IF NOT cl_null(g_fmmy_m.fmmy003) AND NOT cl_null(g_fmmy_m.fmmy004) THEN 
                     LET g_fmmy_m.fmmy005 = g_fmmy_m.fmmy003 * g_fmmy_m.fmmy004
                     CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,g_fmmy_m.fmmy005,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy005 #150924-00006#4
                     #151029-00012#7---s
                     IF NOT cl_null(g_fmmy_m.fmmy005)THEN
                        LET g_fmmy_m.fmmy013 = g_fmmy_m.fmmy005 * g_fmmy_m.fmmy007
                        CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy013,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy013
                     END IF
                     #151029-00012#7---e
                     DISPLAY BY NAME g_fmmy_m.fmmy005,g_fmmy_m.fmmy013   #151029-00012#7 add fmmy013
                  END IF 
                  
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy004)THEN
                     CALL afmt590_account_fomula('A1')
                     CALL afmt590_account_fomula('A2')
                     CALL afmt590_account_fomula('E1')
                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('D')   #151105-00008#5 add
                  END IF
                  #151029-00012#12-----e
            #151203-00013#2 --s
               END IF   
            END IF       
            #LET g_fmmy_m_t.* = g_fmmy_m.*    #160822-00012#4   mark 
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy004
            #add-point:BEFORE FIELD fmmy004 name="input.b.fmmy004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy004
            #add-point:ON CHANGE fmmy004 name="input.g.fmmy004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy005
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy005 name="input.a.fmmy005"
            IF NOT cl_null(g_fmmy_m.fmmy005)THEN  #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy005) OR (g_fmmy_m_t.fmmy005 <> g_fmmy_m.fmmy005)THEN  #151203-00013#2     #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy005) OR (g_fmmy_m.fmmy005 != g_fmmy_m_o.fmmy005) THEN                      #160822-00012#4   add
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy005)THEN
                     CALL afmt590_account_fomula('A2')
                     CALL afmt590_account_fomula('E1')
                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('D')   #151105-00008#5 add
                  END IF
                  #151029-00012#12-----e
            #151203-00013#2 --s
               END IF   
            END IF       
            #LET g_fmmy_m_t.* = g_fmmy_m.*    #160822-00012#4   mark
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy005
            #add-point:BEFORE FIELD fmmy005 name="input.b.fmmy005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy005
            #add-point:ON CHANGE fmmy005 name="input.g.fmmy005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy007
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy007 name="input.a.fmmy007"
            IF NOT cl_null(g_fmmy_m.fmmy007) THEN  #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy007) OR (g_fmmy_m_t.fmmy007 <> g_fmmy_m.fmmy007)THEN  #151203-00013#2
                  #150924-00006#4-----s
                  IF NOT cl_null(g_fmmy_m.fmmy007) THEN
                     #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy007 != g_fmmy_m_t.fmmy007 OR g_fmmy_m_t.fmmy007 IS NULL )) THEN   #160822-00012   mark
                     IF g_fmmy_m.fmmy007 != g_fmmy_m_o.fmmy007 OR cl_null(g_fmmy_m_o.fmmy007) THEN                                       #160822-00012   add
                        #CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy007,3) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy007  #160829-00004#3 mark
                        CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,g_fmmy_m.fmmy007,3) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy007  #160829-00004#3
                        DISPLAY BY NAME g_fmmy_m.fmmy007                                       
                     END IF
                  END IF
                  #150924-00006#4-----e
                  
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy007)THEN
                     CALL afmt590_account_fomula('A2')
                                    
                     #CALL afmt590_account_fomula('D')
                     #CALL afmt590_account_fomula('E1')
                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('D')   #160218-00010#1
                  END IF
                  #151029-00012#12-----e   
            #151203-00013#2 --s                  
               END IF   
            END IF      
            #LET g_fmmy_m_t.* = g_fmmy_m.*    #160822-00012#4   mark
            #151203-00013#2 --e       
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy007
            #add-point:BEFORE FIELD fmmy007 name="input.b.fmmy007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy007
            #add-point:ON CHANGE fmmy007 name="input.g.fmmy007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy013
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy013 name="input.a.fmmy013"
            IF NOT cl_null(g_fmmy_m.fmmy013)THEN   #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy013) OR (g_fmmy_m.fmmy013 <> g_fmmy_m_t.fmmy013) THEN   #151203-00013#2   #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy013) OR (g_fmmy_m.fmmy013 != g_fmmy_m_o.fmmy013)THEN                       #160822-00012#4   add 
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy013)THEN
                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('D')   #160218-00010#1
                  END IF
                  #151029-00012#12-----e 
            #151203-00013#2 --s
               END IF   
            END IF   
            #LET g_fmmy_m_t.* = g_fmmy_m.* 
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*     #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy013
            #add-point:BEFORE FIELD fmmy013 name="input.b.fmmy013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy013
            #add-point:ON CHANGE fmmy013 name="input.g.fmmy013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy028
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy028,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy028
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy028 name="input.a.fmmy028"
            IF NOT cl_null(g_fmmy_m.fmmy028) THEN  #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy028) OR (g_fmmy_m_t.fmmy028 <> g_fmmy_m.fmmy028)THEN  #151203-00013#2
                  #151117-00001#4-----s
                  IF NOT cl_null(g_fmmy_m.fmmy028) THEN 
                     CALL afmt590_account_fomula('B2')
                     CALL afmt590_account_fomula('G1')
                     CALL afmt590_account_fomula('G2')
                     CALL afmt590_account_fomula('F1')               
                  END IF 
                  #151117-00001#4-----e
            #151203-00013#2 --s            
               END IF                     
            END IF                        
            LET g_fmmy_m_t.* = g_fmmy_m.* 
            #151203-00013#2 --e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy028
            #add-point:BEFORE FIELD fmmy028 name="input.b.fmmy028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy028
            #add-point:ON CHANGE fmmy028 name="input.g.fmmy028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy019,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy019
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy019 name="input.a.fmmy019"
            IF NOT cl_null(g_fmmy_m.fmmy019) THEN  #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy019) OR (g_fmmy_m_t.fmmy019 <> g_fmmy_m.fmmy019)THEN  #151203-00013#2
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy019)THEN
                     CALL afmt590_account_fomula('B2')
                     #151117-00001#4-----s
                     CALL afmt590_account_fomula('G2')
                     #151117-00001#4-----e
                     CALL afmt590_account_fomula('F1')   #151105-00008#5
                  END IF
                  #151029-00012#12-----e 
            #151203-00013#2 --s
               END IF                      
            END IF                         
            LET g_fmmy_m_t.* = g_fmmy_m.*  
            #151203-00013#2 --e            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy019
            #add-point:BEFORE FIELD fmmy019 name="input.b.fmmy019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy019
            #add-point:ON CHANGE fmmy019 name="input.g.fmmy019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy029,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy029
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy029 name="input.a.fmmy029"
            IF NOT cl_null(g_fmmy_m.fmmy029) THEN   #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy029) OR (g_fmmy_m_t.fmmy029 <> g_fmmy_m.fmmy029)THEN #151203-00013#2
                  IF NOT cl_null(g_fmmy_m.fmmy029) THEN 
                  #151117-00001#4-----s
                     CALL afmt590_account_fomula('G2')
                     CALL afmt590_account_fomula('F1')    
                  END IF                      
                  #151117-00001#4-----e   
            #151203-00013#2 --s
               END IF                       
            END IF                          
            LET g_fmmy_m_t.* = g_fmmy_m.*   
            #151203-00013#2 --e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy029
            #add-point:BEFORE FIELD fmmy029 name="input.b.fmmy029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy029
            #add-point:ON CHANGE fmmy029 name="input.g.fmmy029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy015,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy015
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy015 name="input.a.fmmy015"
            IF NOT cl_null(g_fmmy_m.fmmy015) THEN   #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy015) OR (g_fmmy_m_t.fmmy015 <> g_fmmy_m.fmmy015)THEN   #151203-00013#2
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy015)THEN
                     CALL afmt590_account_fomula('C2')
                     #CALL afmt590_account_fomula('D')   160218-00010#1 mark
                     CALL afmt590_account_fomula('E1')
                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('D')   #160218-00010#1
                  END IF
                  #151029-00012#12-----e 
            #151203-00013#2 --s
               END IF                       
            END IF                          
            LET g_fmmy_m_t.* = g_fmmy_m.*    
            #151203-00013#2 --e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy015
            #add-point:BEFORE FIELD fmmy015 name="input.b.fmmy015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy015
            #add-point:ON CHANGE fmmy015 name="input.g.fmmy015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy016,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy016
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy016 name="input.a.fmmy016"
            IF NOT cl_null(g_fmmy_m.fmmy016) THEN  #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy016) OR (g_fmmy_m_t.fmmy016 <> g_fmmy_m.fmmy016)THEN  #151203-00013#2
            #151029-00012#12-----s
            IF NOT cl_null(g_fmmy_m.fmmy016)THEN
               CALL afmt590_account_fomula('E2')
               CALL afmt590_account_fomula('D')   #160218-00010#1
            END IF
            #151029-00012#12-----e 
            #151203-00013#2 --s
               END IF                       
            END IF                          
            LET g_fmmy_m_t.* = g_fmmy_m.* 
            #151203-00013#2 --e            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy016
            #add-point:BEFORE FIELD fmmy016 name="input.b.fmmy016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy016
            #add-point:ON CHANGE fmmy016 name="input.g.fmmy016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmz003
            #add-point:BEFORE FIELD l_fmmz003 name="input.b.l_fmmz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmz003
            
            #add-point:AFTER FIELD l_fmmz003 name="input.a.l_fmmz003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmz003
            #add-point:ON CHANGE l_fmmz003 name="input.g.l_fmmz003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmz011
            #add-point:BEFORE FIELD l_fmmz011 name="input.b.l_fmmz011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmz011
            
            #add-point:AFTER FIELD l_fmmz011 name="input.a.l_fmmz011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmz011
            #add-point:ON CHANGE l_fmmz011 name="input.g.l_fmmz011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy017
            #add-point:BEFORE FIELD fmmy017 name="input.b.fmmy017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy017
            
            #add-point:AFTER FIELD fmmy017 name="input.a.fmmy017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy017
            #add-point:ON CHANGE fmmy017 name="input.g.fmmy017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy018
            #add-point:BEFORE FIELD fmmy018 name="input.b.fmmy018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy018
            
            #add-point:AFTER FIELD fmmy018 name="input.a.fmmy018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy018
            #add-point:ON CHANGE fmmy018 name="input.g.fmmy018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy021
            #add-point:BEFORE FIELD fmmy021 name="input.b.fmmy021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy021
            
            #add-point:AFTER FIELD fmmy021 name="input.a.fmmy021"
            IF NOT cl_null(g_fmmy_m.fmmy021) THEN   #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy021) OR (g_fmmy_m_t.fmmy021 <> g_fmmy_m.fmmy021)THEN   #151203-00013#2   #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy021) OR (g_fmmy_m.fmmy021 != g_fmmy_m_o.fmmy021)THEN                      #160822-00012#4   add
                  IF NOT cl_null(g_fmmy_m.fmmy021)THEN
                     #151117-00001#4-----s
                     CALL afmt590_account_fomula('G1')
                     CALL afmt590_account_fomula('G2')
                     #151117-00001#4-----e
                     CALL afmt590_account_fomula('F1')   #151105-00008#5
                  END IF
            #151203-00013#2 --s
               END IF                      
            END IF                         
            LET g_fmmy_m_t.* = g_fmmy_m.*  
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy021
            #add-point:ON CHANGE fmmy021 name="input.g.fmmy021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy022
            #add-point:BEFORE FIELD fmmy022 name="input.b.fmmy022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy022
            
            #add-point:AFTER FIELD fmmy022 name="input.a.fmmy022"
            IF NOT cl_null(g_fmmy_m.fmmy022) THEN  #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy022) OR (g_fmmy_m_t.fmmy022 <> g_fmmy_m.fmmy022)THEN  #151203-00013#2    #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy022) OR (g_fmmy_m.fmmy022 != g_fmmy_m_o.fmmy022)THEN                      #160822-00012#4   add
                  IF NOT cl_null(g_fmmy_m.fmmy022)THEN
                     #151117-00001#4-----s
                     CALL afmt590_account_fomula('G2')
                     #151117-00001#4-----e
                     CALL afmt590_account_fomula('F1')   #151105-00008#5
                  END IF
            #151203-00013#2 --s
               END IF                       
            END IF                          
            LET g_fmmy_m_t.* = g_fmmy_m.* 
            #151203-00013#2 --e       
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy022
            #add-point:ON CHANGE fmmy022 name="input.g.fmmy022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy024
            #add-point:BEFORE FIELD fmmy024 name="input.b.fmmy024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy024
            
            #add-point:AFTER FIELD fmmy024 name="input.a.fmmy024"
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy024
            #add-point:ON CHANGE fmmy024 name="input.g.fmmy024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy025
            #add-point:BEFORE FIELD fmmy025 name="input.b.fmmy025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy025
            
            #add-point:AFTER FIELD fmmy025 name="input.a.fmmy025"
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy025
            #add-point:ON CHANGE fmmy025 name="input.g.fmmy025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy023
            #add-point:BEFORE FIELD fmmy023 name="input.b.fmmy023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy023
            
            #add-point:AFTER FIELD fmmy023 name="input.a.fmmy023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy023
            #add-point:ON CHANGE fmmy023 name="input.g.fmmy023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy020,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy020
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy020 name="input.a.fmmy020"
            IF NOT cl_null(g_fmmy_m.fmmy020) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy020
            #add-point:BEFORE FIELD fmmy020 name="input.b.fmmy020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy020
            #add-point:ON CHANGE fmmy020 name="input.g.fmmy020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy027
            #add-point:BEFORE FIELD fmmy027 name="input.b.fmmy027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy027
            
            #add-point:AFTER FIELD fmmy027 name="input.a.fmmy027"
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy027
            #add-point:ON CHANGE fmmy027 name="input.g.fmmy027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy026
            #add-point:BEFORE FIELD fmmy026 name="input.b.fmmy026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy026
            
            #add-point:AFTER FIELD fmmy026 name="input.a.fmmy026"
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy026
            #add-point:ON CHANGE fmmy026 name="input.g.fmmy026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy006
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy006 name="input.a.fmmy006"
            #151029-00012#12 mark-----s
            #151029-00012#7---s
#            IF NOT cl_null(g_fmmy_m.fmmy006) THEN
#               LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy007
#               CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
#            END IF
#            DISPLAY BY NAME g_fmmy_m.fmmy014
            
            
            #151029-00012#7---e
            #151029-00012#12-----e
            
            IF NOT cl_null(g_fmmy_m.fmmy006) THEN  #151203-00013#2
               #IF cl_null(g_fmmy_m_t.fmmy006) OR (g_fmmy_m_t.fmmy006 <> g_fmmy_m.fmmy006)THEN   #151203-00013#2   #160822-00012#4   mark
               IF cl_null(g_fmmy_m_o.fmmy006) OR (g_fmmy_m.fmmy006 != g_fmmy_m_o.fmmy006)THEN                      #160822-00012#4   add        
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy006)THEN
                     CALL afmt590_account_fomula('B2')
#                     CALL afmt590_account_fomula('E1')
#                     CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('F1')   #151105-00008#5
                  END IF
                  #151029-00012#12-----e
            #151203-00013#2 --s
               END IF                       
            END IF                          
            #LET g_fmmy_m_t.* = g_fmmy_m.*   #160822-00012#4   mark     
            #151203-00013#2 --e
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy006
            #add-point:BEFORE FIELD fmmy006 name="input.b.fmmy006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy006
            #add-point:ON CHANGE fmmy006 name="input.g.fmmy006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmy_m.fmmy014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmy014
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmy014 name="input.a.fmmy014"
            IF NOT cl_null(g_fmmy_m.fmmy014) THEN  #151203-00013#2
               IF cl_null(g_fmmy_m_t.fmmy014) OR (g_fmmy_m_t.fmmy014 <> g_fmmy_m.fmmy014)THEN  #151203-00013#2
                  #151029-00012#12-----s
                  IF NOT cl_null(g_fmmy_m.fmmy014)THEN
                     #CALL afmt590_account_fomula('E2')
                     CALL afmt590_account_fomula('F1')   #151105-00008#5
                  END IF
                  #151029-00012#12-----e 
            #151203-00013#2 --s      
               END IF                        
            END IF                           
            LET g_fmmy_m_t.* = g_fmmy_m.*    
            #151203-00013#2 --e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy014
            #add-point:BEFORE FIELD fmmy014 name="input.b.fmmy014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy014
            #add-point:ON CHANGE fmmy014 name="input.g.fmmy014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy008
            #add-point:BEFORE FIELD fmmy008 name="input.b.fmmy008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy008
            
            #add-point:AFTER FIELD fmmy008 name="input.a.fmmy008"
               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy008
            #add-point:ON CHANGE fmmy008 name="input.g.fmmy008"
            CALL afmt590_set_entry(p_cmd)            
            CALL afmt590_set_no_entry(p_cmd)
            #150820-00011#8---s
            LET g_fmmy_m.fmmy009 = ''
            LET g_fmmy_m.fmmy009_desc = ''
            LET g_fmmy_m.fmmy010 = ''
            LET g_fmmy_m.fmmy010_desc = ''
            CASE g_fmmy_m.fmmy008
               WHEN '1'
                  CALL cl_set_comp_required("fmmy011,fmmy012",FALSE)
               WHEN '2'
                  IF NOT cl_null(g_fmmy_m.fmmysite) AND NOT cl_null(g_fmmy_m.fmmy001) THEN
                     SELECT fmmf003 INTO g_fmmy_m.fmmy010
                       FROM fmmj_t,fmmf_t
                      WHERE fmmjent = fmmfent AND fmmj002 = fmmf002 AND fmmf001 = g_fmmy_m.fmmysite
                        AND fmmjent = g_enterprise AND fmmjdocno = g_fmmy_m.fmmy001                      
                  END IF
                  #160122-00001#36--add--str--
                  #带出的交易账户要满足以下两点才可以使用
                  #1.交易账户对应币别=单头币别
                  #2.当前用户有权限使用此交易账户
                  #判断交易账户对应币别是否等于单头交易币别
                  LET l_cnt=0
                  SELECT COUNT(*) INTO l_cnt FROM nmas_t
                   WHERE nmasent=g_enterprise AND nmas002=g_fmmy_m.fmmy010
                     AND nmas003=g_fmmy_m.fmmy002
                  IF l_cnt > 0 THEN
                     #判断抓出的交易账户，当前用户是否有权限
                     LET l_cnt=0
                     SELECT COUNT(*) INTO l_cnt FROM nmll_t
                      WHERE nmllent=g_enterprise AND nmll001=g_fmmy_m.fmmy010 
                        AND nmll002=g_user AND nmllstus='Y'
                     IF l_cnt=0 THEN
                        SELECT COUNT(*) INTO l_cnt FROM nmlm_t
                         WHERE nmlment=g_enterprise AND nmlm001=g_fmmy_m.fmmy010
                           AND nmlm002=g_dept AND nmlmstus='Y'
                     END IF
                  END IF
                  #如果有权限，抓出开户银行编号等信息
                  IF l_cnt > 0 THEN
                  #160122-00001#36--add--end
                     SELECT nmaa004,nmabl004 INTO g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc
                       FROM nmas_t,nmaa_t LEFT OUTER JOIN nmabl_t ON nmablent = nmaaent  
                                                                 AND nmabl001 = nmaa004 
                                                                 AND nmabl002 = g_dlang
                      WHERE nmaaent = nmasent AND nmaaent = g_enterprise 
                       AND nmaa001 = nmas001  AND nmas002 = g_fmmy_m.fmmy010 
                       
                     #如果帳戶資料建錯 則改用投資組織+市場編號去串銀行
                     IF cl_null(g_fmmy_m.fmmy009) THEN
                        SELECT nmaa004,nmabl004 INTO g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc
                          FROM nmaa_t LEFT OUTER JOIN nmabl_t ON nmablent = nmaaent  
                                                             AND nmabl001 = nmaa004 
                                                             AND nmabl002 = g_dlang
                         WHERE nmaaent = g_enterprise AND nmaa001 = g_fmmy_m.l_fmmy001_2 
                           AND nmaa002 = g_fmmy_m.fmmysite
                     END IF
                   #160122-00001#36--mark--str--
#                   #160122-00001#6 by 07900 --add---str
#                     IF NOT s_anmi120_nmll002_chk(g_fmmy_m.fmmy010,g_user) THEN           
#                        LET g_fmmy_m.fmmy010 = ''
#                     END IF
#                  #160122-00001#6 by 07900 --add---end
                  #160122-00001#36--mark--end
                     CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc  
                  #160122-00001#36--add--str--
                  ELSE
                     #如果没有权限，开户银行编号和交易账户不带值
                     LET g_fmmy_m.fmmy010 = ''
                  END IF
                  #160122-00001#36--add--end   
                  CALL cl_set_comp_required("fmmy011,fmmy012",TRUE)
               WHEN '3'
                  CALL cl_set_comp_required("fmmy011,fmmy012",TRUE)
            END CASE
            DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
            #150820-00011#8---e
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy009
            
            #add-point:AFTER FIELD fmmy009 name="input.a.fmmy009"
            LET g_fmmy_m.fmmy009_desc = ''
            LET g_fmmy_m.fmmy010_desc = ''
            DISPLAY BY NAME g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
            IF NOT cl_null(g_fmmy_m.fmmy009) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy009 != g_fmmy_m_t.fmmy009 OR g_fmmy_m_t.fmmy009 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmy009 != g_fmmy_m_o.fmmy009 OR cl_null(g_fmmy_m_o.fmmy009) THEN                                       #160822-00012#4   add
                  #有修改就把帳戶清空重新帶入
#                  CALL s_afmt530_nmaa_nmas_chk(g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy002,g_fmmy_m.fmmysite)
#                     RETURNING g_sub_success,g_errno
                  CALL afmt590_nmaa_nmas_chk(g_fmmy_m.fmmy009,g_fmmy_m.fmmy010) RETURNING g_sub_success,g_errno #150820-00011#8
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     IF g_errno MATCHES 'afm-0008[348]' THEN
                        #LET g_fmmy_m.fmmy009 = g_fmmy_m_t.fmmy009   #160822-00012#4   mark
                        LET g_fmmy_m.fmmy009 = g_fmmy_m_o.fmmy009    #160822-00012#4   add
                        SELECT nmabl004 INTO g_fmmy_m.fmmy009_desc
                          FROM nmabl_t
                         WHERE nmablent = g_enterprise AND nmabl001 = g_fmmy_m.fmmy009
                           AND nmabl002 = g_dlang
                        #LET g_fmmy_m.fmmy010 = g_fmmy_m_t.fmmy010   #160822-00012#4   mark
                        LET g_fmmy_m.fmmy010 = g_fmmy_m_o.fmmy010    #160822-00012#4   add
                        CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
                     ELSE   
                        LET g_fmmy_m.fmmy010 = ''
                        CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
                     END IF
                     DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            SELECT nmabl004 INTO g_fmmy_m.fmmy009_desc
              FROM nmabl_t
             WHERE nmablent = g_enterprise AND nmabl001 = g_fmmy_m.fmmy009
               AND nmabl002 = g_dlang
            CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
            DISPLAY BY NAME g_fmmy_m.fmmy010,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy009
            #add-point:BEFORE FIELD fmmy009 name="input.b.fmmy009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy009
            #add-point:ON CHANGE fmmy009 name="input.g.fmmy009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy010
            
            #add-point:AFTER FIELD fmmy010 name="input.a.fmmy010"
            LET g_fmmy_m.fmmy009_desc = ''
            LET g_fmmy_m.fmmy010_desc = ''
            DISPLAY BY NAME g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
            IF NOT cl_null(g_fmmy_m.fmmy010) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy010 != g_fmmy_m_t.fmmy010 OR g_fmmy_m_t.fmmy010 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmy010 != g_fmmy_m_o.fmmy010 OR cl_null(g_fmmy_m_o.fmmy010) THEN                                       #160822-00012#4   add

                  #有修改就把帳戶清空重新帶入
                  CALL afmt590_nmaa_nmas_chk(g_fmmy_m.fmmy009,g_fmmy_m.fmmy010) RETURNING g_sub_success,g_errno #150820-00011#8
 
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     IF g_errno MATCHES 'afm-0008[348]' THEN
                        LET g_fmmy_m.fmmy009 = g_fmmy_m_t.fmmy009
                        SELECT nmabl004 INTO g_fmmy_m.fmmy009_desc
                          FROM nmabl_t
                         WHERE nmablent = g_enterprise AND nmabl001 = g_fmmy_m.fmmy009
                           AND nmabl002 = g_dlang
                        #LET g_fmmy_m.fmmy010 = g_fmmy_m_t.fmmy010   #160822-00012#4   mark
                        LET g_fmmy_m.fmmy010 = g_fmmy_m_o.fmmy010    #160822-00012#4   add
                        CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
                     ELSE   
                        LET g_fmmy_m.fmmy010 = ''
                        CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
                     END IF
                     DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc
                     NEXT FIELD CURRENT
                  END IF
                 #160122-00001#6--add---str
                  IF NOT s_anmi120_nmll002_chk(g_fmmy_m.fmmy010,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmmy_m.fmmy010
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmmy_m.fmmy010 = g_fmmy_m_t.fmmy010   #160822-00012#4   mark
                     LET g_fmmy_m.fmmy010 = g_fmmy_m_o.fmmy010    #160822-00012#4   add
                     CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#6--add---end
               END IF
            END IF
            SELECT nmabl004 INTO g_fmmy_m.fmmy009_desc
              FROM nmabl_t
             WHERE nmablent = g_enterprise AND nmabl001 = g_fmmy_m.fmmy009
               AND nmabl002 = g_dlang
            CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
            DISPLAY BY NAME g_fmmy_m.fmmy010,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy010
            #add-point:BEFORE FIELD fmmy010 name="input.b.fmmy010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy010
            #add-point:ON CHANGE fmmy010 name="input.g.fmmy010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy012
            
            #add-point:AFTER FIELD fmmy012 name="input.a.fmmy012"
            #150820-00011#8---s
            LET g_fmmy_m.fmmy012_desc = ''
            DISPLAY BY NAME g_fmmy_m.fmmy012_desc
            IF NOT cl_null(g_fmmy_m.fmmy012) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy012 != g_fmmy_m_t.fmmy012 OR g_fmmy_m_t.fmmy012 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmy012 != g_fmmy_m_o.fmmy012 OR cl_null(g_fmmy_m_o.fmmy012) THEN                                       #160822-00012#4   add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_glaa005
                  LET g_chkparam.arg2 = g_fmmy_m.fmmy012
                  LET g_chkparam.where = "nmaj002 = '1' "
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmad002_1") THEN                  
                     #LET g_fmmy_m.fmmy012 = g_fmmy_m_t.fmmy012   #160822-00012#4   mark
                     LET g_fmmy_m.fmmy012 = g_fmmy_m_o.fmmy012    #160822-00012#4   add
                     CALL s_desc_get_nmajl003_desc(g_fmmy_m.fmmy012)  RETURNING g_fmmy_m.fmmy012_desc
                     DISPLAY BY NAME g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc
                     NEXT FIELD CURRENT
                  END IF
                  #根據anmi172預帶現金變動碼
                  IF NOT cl_null(g_fmmy_m.fmmysite) THEN
                     LET g_fmmy_m.fmmy011 = ''
                     SELECT nmad003 INTO g_fmmy_m.fmmy011
                       FROM ooef_t,glaa_t,nmad_t
                      WHERE ooefent = glaaent AND nmadent = glaaent AND glaaent = g_enterprise
                        AND glaa014 = 'Y' AND nmadstus = 'Y' AND nmad001 = glaa005 AND glaacomp = ooef017 
                        AND ooef001 = g_fmmy_m.fmmysite AND nmad002 = g_fmmy_m.fmmy012  
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmajl003_desc(g_fmmy_m.fmmy012)  RETURNING g_fmmy_m.fmmy012_desc
            CALL s_desc_get_nmail004_desc(l_glaa005,g_fmmy_m.fmmy011) RETURNING g_fmmy_m.fmmy011_desc
            DISPLAY BY NAME g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc
            #150820-00011#8---e
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy012
            #add-point:BEFORE FIELD fmmy012 name="input.b.fmmy012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy012
            #add-point:ON CHANGE fmmy012 name="input.g.fmmy012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmy011
            
            #add-point:AFTER FIELD fmmy011 name="input.a.fmmy011"
            #150820-00011#8---s
            LET g_fmmy_m.fmmy011_desc = ''
            DISPLAY BY NAME g_fmmy_m.fmmy011_desc
            IF NOT cl_null(g_fmmy_m.fmmy011) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmy_m.fmmy011 != g_fmmy_m_t.fmmy011 OR g_fmmy_m_t.fmmy011 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmy_m.fmmy011 != g_fmmy_m_o.fmmy011 OR cl_null(g_fmmy_m_o.fmmy011) THEN                                       #160822-00012#4   add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_fmmy_m.fmmy011
                  LET g_chkparam.arg2 = l_glaa005
                  IF NOT cl_chk_exist("v_nmai002") THEN                      
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmmy_m.fmmy011 
                     LET g_errparam.code   = "" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmmy_m.fmmy011 = g_fmmy_m_t.fmmy011   #160822-00012#4   mark
                     LET g_fmmy_m.fmmy011 = g_fmmy_m_o.fmmy011    #160822-00012#4   add
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_fmmy_m.fmmy011) RETURNING g_fmmy_m.fmmy011_desc
                     DISPLAY BY NAME g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmail004_desc(l_glaa005,g_fmmy_m.fmmy011) RETURNING g_fmmy_m.fmmy011_desc
            DISPLAY BY NAME g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc
            #150820-00011#8---e
            LET g_fmmy_m_o.* = g_fmmy_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmy011
            #add-point:BEFORE FIELD fmmy011 name="input.b.fmmy011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmy011
            #add-point:ON CHANGE fmmy011 name="input.g.fmmy011"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmysite
            #add-point:ON ACTION controlp INFIELD fmmysite name="input.c.fmmysite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmy_m.fmmysite
            #LET g_qryparam.where = " ooef206 = 'Y' "   #161006-00005#14   mark 
            #CALL q_ooef001()     #161006-00005#14   mark                    
            CALL q_ooef001_33()   #161006-00005#14   add
            LET g_fmmy_m.fmmysite = g_qryparam.return1
            LET g_fmmy_m.fmmysite_desc = s_desc_get_department_desc(g_fmmy_m.fmmysite)
            DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc
            NEXT FIELD fmmysite
            #END add-point
 
 
         #Ctrlp:input.c.fmmydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmydocdt
            #add-point:ON ACTION controlp INFIELD fmmydocdt name="input.c.fmmydocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmydocno
            #add-point:ON ACTION controlp INFIELD fmmydocno name="input.c.fmmydocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmy_m.fmmydocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#21-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#21-----e
            CALL q_ooba002_1()
            LET g_fmmy_m.fmmydocno = g_qryparam.return1
            DISPLAY BY NAME g_fmmy_m.fmmydocno
            NEXT FIELD fmmydocno
            #END add-point
 
 
         #Ctrlp:input.c.fmmy001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy001
            #add-point:ON ACTION controlp INFIELD fmmy001 name="input.c.fmmy001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmy_m.fmmy001
            LET g_qryparam.where = "fmmjstus = 'Y' AND fmmjsite = '",g_fmmy_m.fmmysite,"' ",
                                   " AND fmmjdocno IN ( SELECT fmmjdocno ",
                                                       "  FROM fmmj_t ",
                                                       "  LEFT OUTER JOIN(SELECT fmmyent,fmmy001,SUM(fmmy003) fmmy003sum  ",
                                                       "  FROM fmmy_t  ",
                                                       " GROUP BY fmmy001,fmmyent ",
                                                    "  )ON fmmy001 = fmmjdocno AND fmmyent = fmmjent ",
                                                    " WHERE fmmj005 > COALESCE(fmmy003sum,0) ) "
            CALL q_fmmjdocno()
            LET g_fmmy_m.fmmy001 = g_qryparam.return1 
            DISPLAY BY NAME g_fmmy_m.fmmy001
            NEXT FIELD fmmy001
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmy001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmy001_1
            #add-point:ON ACTION controlp INFIELD l_fmmy001_1 name="input.c.l_fmmy001_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmy001_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmy001_2
            #add-point:ON ACTION controlp INFIELD l_fmmy001_2 name="input.c.l_fmmy001_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmy001_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmy001_3
            #add-point:ON ACTION controlp INFIELD l_fmmy001_3 name="input.c.l_fmmy001_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmy001_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmy001_4
            #add-point:ON ACTION controlp INFIELD l_fmmy001_4 name="input.c.l_fmmy001_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy002
            #add-point:ON ACTION controlp INFIELD fmmy002 name="input.c.fmmy002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmy_m.fmmy002
            LET g_qryparam.arg1 = g_glaa.glaacomp
            CALL q_ooaj002_1()
            LET g_fmmy_m.fmmy002 = g_qryparam.return1
            DISPLAY BY NAME g_fmmy_m.fmmy002
            NEXT FIELD fmmy002
            #END add-point
 
 
         #Ctrlp:input.c.fmmystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmystus
            #add-point:ON ACTION controlp INFIELD fmmystus name="input.c.fmmystus"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy003
            #add-point:ON ACTION controlp INFIELD fmmy003 name="input.c.fmmy003"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy004
            #add-point:ON ACTION controlp INFIELD fmmy004 name="input.c.fmmy004"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy005
            #add-point:ON ACTION controlp INFIELD fmmy005 name="input.c.fmmy005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy007
            #add-point:ON ACTION controlp INFIELD fmmy007 name="input.c.fmmy007"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy013
            #add-point:ON ACTION controlp INFIELD fmmy013 name="input.c.fmmy013"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy028
            #add-point:ON ACTION controlp INFIELD fmmy028 name="input.c.fmmy028"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy019
            #add-point:ON ACTION controlp INFIELD fmmy019 name="input.c.fmmy019"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy029
            #add-point:ON ACTION controlp INFIELD fmmy029 name="input.c.fmmy029"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy015
            #add-point:ON ACTION controlp INFIELD fmmy015 name="input.c.fmmy015"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy016
            #add-point:ON ACTION controlp INFIELD fmmy016 name="input.c.fmmy016"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmz003
            #add-point:ON ACTION controlp INFIELD l_fmmz003 name="input.c.l_fmmz003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmz011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmz011
            #add-point:ON ACTION controlp INFIELD l_fmmz011 name="input.c.l_fmmz011"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy017
            #add-point:ON ACTION controlp INFIELD fmmy017 name="input.c.fmmy017"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy018
            #add-point:ON ACTION controlp INFIELD fmmy018 name="input.c.fmmy018"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy021
            #add-point:ON ACTION controlp INFIELD fmmy021 name="input.c.fmmy021"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy022
            #add-point:ON ACTION controlp INFIELD fmmy022 name="input.c.fmmy022"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy024
            #add-point:ON ACTION controlp INFIELD fmmy024 name="input.c.fmmy024"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy025
            #add-point:ON ACTION controlp INFIELD fmmy025 name="input.c.fmmy025"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy023
            #add-point:ON ACTION controlp INFIELD fmmy023 name="input.c.fmmy023"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy020
            #add-point:ON ACTION controlp INFIELD fmmy020 name="input.c.fmmy020"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy027
            #add-point:ON ACTION controlp INFIELD fmmy027 name="input.c.fmmy027"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy026
            #add-point:ON ACTION controlp INFIELD fmmy026 name="input.c.fmmy026"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy006
            #add-point:ON ACTION controlp INFIELD fmmy006 name="input.c.fmmy006"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy014
            #add-point:ON ACTION controlp INFIELD fmmy014 name="input.c.fmmy014"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy008
            #add-point:ON ACTION controlp INFIELD fmmy008 name="input.c.fmmy008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmy009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy009
            #add-point:ON ACTION controlp INFIELD fmmy009 name="input.c.fmmy009"
            #150820-00011#8---MARKstart
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_fmmy_m.fmmy010
#            LET g_qryparam.default2 = g_fmmy_m.fmmy009
#            LET g_qryparam.arg1 = g_fmmy_m.fmmy002
#            LET g_qryparam.where = "nmaa002 = '",g_fmmy_m.fmmysite,"' "
#            CALL q_nmas002_12()
#            LET g_fmmy_m.fmmy009 = g_qryparam.return2
#            LET g_fmmy_m.fmmy010 = g_qryparam.return1
#            DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy010
#            NEXT FIELD fmmy009
            #150820-00011#8---MARKend
            #150820-00011#8---s
            IF NOT cl_null(g_fmmy_m.fmmysite) THEN         
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fmmy_m.fmmy010   
               LET g_qryparam.arg1 = g_fmmy_m.fmmysite
               LET g_qryparam.where = " nmas003 = '",g_fmmy_m.fmmy002,"' " #150820-00011#8
                                        #160122-00001#6 by 07900 --add-str
                                        ," AND nmas002  IN (",g_sql_bank,")"
                                        #160122-00001#6 by 07900 --add-end
               CALL q_nmas002_3()
               LET g_fmmy_m.fmmy010 = g_qryparam.return1
              
               SELECT nmaa004,nmabl004 INTO g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc
                 FROM nmas_t,nmaa_t LEFT OUTER JOIN nmabl_t ON nmablent = nmaaent  
                                                           AND nmabl001 = nmaa004 
                                                           AND nmabl002 = g_dlang
                WHERE nmaaent = nmasent AND  nmaaent = g_enterprise 
                 AND nmaa001 = nmas001  AND nmas002 = g_fmmy_m.fmmy010       
                  #160122-00001#6 by 07900 --add---str
                  IF NOT s_anmi120_nmll002_chk(g_fmmy_m.fmmy010,g_user) THEN
                     LET g_fmmy_m.fmmy010 = ''
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#6 by 07900 --add---end
               CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
               DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
               NEXT FIELD fmmy009
            END IF
            #150820-00011#8---e
            #END add-point
 
 
         #Ctrlp:input.c.fmmy010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy010
            #add-point:ON ACTION controlp INFIELD fmmy010 name="input.c.fmmy010"
            IF NOT cl_null(g_fmmy_m.fmmysite) THEN          #150820-00011#8
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fmmy_m.fmmy010   
               LET g_qryparam.arg1 = g_fmmy_m.fmmysite      #150820-00011#8
#               LET g_qryparam.where = " nmas003 = '",g_fmmy_m.fmmy002,"' ", #150820-00011#8  #160122-00001#6 mrak
#                                      " AND nmaa004 = '",g_fmmy_m.fmmy009,"' "   #160122-00001#6 mrak
                #160122-00001#6 add -- str
               LET g_qryparam.where = " nmas003 = '",g_fmmy_m.fmmy002,"' ", #150820-00011#8
                                      " AND nmaa004 = '",g_fmmy_m.fmmy009,"' ",
                                      " AND nmas002  IN (",g_sql_bank,")"     #160122-00001#6 By 07900--mod
                #160122-00001#6 add -- end                
               CALL q_nmas002_3()
               LET g_fmmy_m.fmmy010 = g_qryparam.return1
               CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
               DISPLAY BY NAME g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010_desc
               NEXT FIELD fmmy010
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.fmmy012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy012
            #add-point:ON ACTION controlp INFIELD fmmy012 name="input.c.fmmy012"
            #150820-00011#8---s
            IF NOT cl_null(g_fmmy_m.fmmysite) THEN
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fmmy_m.fmmy012             #給予default值
               LET g_qryparam.arg1 = l_glaa005
               LET g_qryparam.where = "nmaj002 = '1' "
               CALL q_nmad002_1()                                        #呼叫開窗
               LET g_fmmy_m.fmmy012 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_desc_get_nmajl003_desc(g_fmmy_m.fmmy012)  RETURNING g_fmmy_m.fmmy012_desc
               DISPLAY BY NAME g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc
               NEXT FIELD fmmy012                          #返回原欄位
            END IF
            #150820-00011#8---e
            #END add-point
 
 
         #Ctrlp:input.c.fmmy011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmy011
            #add-point:ON ACTION controlp INFIELD fmmy011 name="input.c.fmmy011"
            #150820-00011#8---s
            IF NOT cl_null(g_fmmy_m.fmmysite) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
               LET g_qryparam.default1 = g_fmmy_m.fmmy011             #給予default值
               CALL q_nmai002()                                #呼叫開窗
               LET g_fmmy_m.fmmy011 = g_qryparam.return1              
               CALL s_desc_get_nmail004_desc(l_glaa005,g_fmmy_m.fmmy011) RETURNING g_fmmy_m.fmmy011_desc
               DISPLAY BY NAME g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc
               NEXT FIELD fmmy011               #返回原欄位
            END IF
            #150820-00011#8---e
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM fmmy_t
                WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_fin_gen_docno(g_glaald,'','',g_fmmy_m.fmmydocno,g_fmmy_m.fmmydocdt,g_prog)
                       RETURNING g_sub_success,g_fmmy_m.fmmydocno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_fmmy_m.fmmydocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD fmmydocno
                  END IF
                  DISPLAY BY NAME g_fmmy_m.fmmydocno
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fmmy_t (fmmyent,fmmysite,fmmydocdt,fmmydocno,fmmy001,fmmy002,fmmystus, 
                      fmmy003,fmmy004,fmmy005,fmmy007,fmmy013,fmmy028,fmmy019,fmmy029,fmmy015,fmmy016, 
                      fmmy017,fmmy018,fmmy021,fmmy022,fmmy024,fmmy025,fmmy023,fmmy020,fmmy027,fmmy026, 
                      fmmy006,fmmy014,fmmy008,fmmy009,fmmy010,fmmy012,fmmy011,fmmyownid,fmmyowndp,fmmycrtid, 
                      fmmycrtdp,fmmycrtdt,fmmymodid,fmmymoddt,fmmycnfid,fmmycnfdt,fmmypstid,fmmypstdt) 
 
                  VALUES (g_enterprise,g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001, 
                      g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005, 
                      g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
                      g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021, 
                      g_fmmy_m.fmmy022,g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020, 
                      g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008, 
                      g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012,g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid, 
                      g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid, 
                      g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt,g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmy_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmmy_m.fmmydocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt590_fmmy_t_mask_restore('restore_mask_o')
               
               UPDATE fmmy_t SET (fmmysite,fmmydocdt,fmmydocno,fmmy001,fmmy002,fmmystus,fmmy003,fmmy004, 
                   fmmy005,fmmy007,fmmy013,fmmy028,fmmy019,fmmy029,fmmy015,fmmy016,fmmy017,fmmy018,fmmy021, 
                   fmmy022,fmmy024,fmmy025,fmmy023,fmmy020,fmmy027,fmmy026,fmmy006,fmmy014,fmmy008,fmmy009, 
                   fmmy010,fmmy012,fmmy011,fmmyownid,fmmyowndp,fmmycrtid,fmmycrtdp,fmmycrtdt,fmmymodid, 
                   fmmymoddt,fmmycnfid,fmmycnfdt,fmmypstid,fmmypstdt) = (g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
                   g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003, 
                   g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028, 
                   g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017, 
                   g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024,g_fmmy_m.fmmy025, 
                   g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
                   g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
                   g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
                   g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
                   g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt)
                WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmydocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmy_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmy_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afmt590_fmmy_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fmmy_m_t)
                     LET g_log2 = util.JSON.stringify(g_fmmy_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt590_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fmmy_t.fmmydocno 
   DEFINE l_oldno     LIKE fmmy_t.fmmydocno 
 
   DEFINE l_master    RECORD LIKE fmmy_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_fmmy_m.fmmydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fmmydocno_t = g_fmmy_m.fmmydocno
 
   
   #清空key值
   LET g_fmmy_m.fmmydocno = ""
 
    
   CALL afmt590_set_entry("a")
   CALL afmt590_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmy_m.fmmyownid = g_user
      LET g_fmmy_m.fmmyowndp = g_dept
      LET g_fmmy_m.fmmycrtid = g_user
      LET g_fmmy_m.fmmycrtdp = g_dept 
      LET g_fmmy_m.fmmycrtdt = cl_get_current()
      LET g_fmmy_m.fmmymodid = g_user
      LET g_fmmy_m.fmmymoddt = cl_get_current()
      LET g_fmmy_m.fmmystus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_fmmy_m.fmmy003 = 0
   LET g_fmmy_m.fmmy005 = 0 
   LET g_fmmy_m.fmmy013 = 0 #151029-00012#7
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmy_m.fmmystus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afmt590_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fmmy_m.* TO NULL
      CALL afmt590_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmmy_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt590_set_act_visible()
   CALL afmt590_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmmydocno_t = g_fmmy_m.fmmydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmyent = " ||g_enterprise|| " AND",
                      " fmmydocno = '", g_fmmy_m.fmmydocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt590_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_fmmy_m.fmmyownid      
   LET g_data_dept  = g_fmmy_m.fmmyowndp
              
   #功能已完成,通報訊息中心
   CALL afmt590_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afmt590_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa005       LIKE glaa_t.glaa005    #150820-00011#8
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   #150820-00011#8---s
   LET l_glaa005 = ''
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaald = g_glaald AND glaaent = g_enterprise
   LET g_fmmy_m.fmmy009_desc = ''
   LET g_fmmy_m.fmmy010_desc = ''
   LET g_fmmy_m.fmmy011_desc = ''
   LET g_fmmy_m.fmmy012_desc = ''
   #150820-00011#8---e   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt590_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
    WHERE glaaent = ooefent
      AND glaacomp = ooef017
      AND ooef001 = g_fmmy_m.fmmysite
      AND ooefent = g_enterprise
      AND glaa014 = 'Y'
   SELECT glaacomp,glaa024,glaa026,glaa001,glaa025
     INTO g_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
   SELECT nmabl004 INTO g_fmmy_m.fmmy009_desc
     FROM nmabl_t
    WHERE nmablent = g_enterprise AND nmabl001 = g_fmmy_m.fmmy009
      AND nmabl002 = g_dlang
   CALL s_desc_get_nmas002_desc(g_fmmy_m.fmmy010) RETURNING g_fmmy_m.fmmy010_desc
   CALL afmt590_fmmy001_desc(g_fmmy_m.fmmy001)
   CALL s_desc_get_nmajl003_desc(g_fmmy_m.fmmy012)  RETURNING g_fmmy_m.fmmy012_desc
   CALL s_desc_get_nmail004_desc(l_glaa005,g_fmmy_m.fmmy011) RETURNING g_fmmy_m.fmmy011_desc
   LET g_fmmy_m.fmmysite_desc = s_desc_get_department_desc(g_fmmy_m.fmmysite)
   CALL afmt590_b_fill2(g_fmmy_m.fmmy001)
   CALL afmt590_b_fill3(g_fmmy_m.fmmy001)  #150820-00011#12
   CALL afmt590_show_fmmz(g_fmmy_m.fmmydocno)     #151105-00008#5
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001, 
       g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_1_desc,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_2_desc, 
       g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_3_desc,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmy002_desc, 
       g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013, 
       g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003, 
       g_fmmy_m.l_fmmz011,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024, 
       g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
       g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc, 
       g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc,g_fmmy_m.fmmyownid, 
       g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymodid_desc, 
       g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmycnfdt,g_fmmy_m.fmmypstid, 
       g_fmmy_m.fmmypstid_desc,g_fmmy_m.fmmypstdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afmt590_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmy_m.fmmystus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afmt590_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_n              LIKE type_t.num5        #160122-00001#6 By 07900 add
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmmy_m.fmmydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fmmydocno_t = g_fmmy_m.fmmydocno
 
   
   
 
   OPEN afmt590_cl USING g_enterprise,g_fmmy_m.fmmydocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt590_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt590_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
       g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
       g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
       g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
       g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
       g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
       g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
       g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
       g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT afmt590_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmy_m_mask_o.* =  g_fmmy_m.*
   CALL afmt590_fmmy_t_mask()
   LET g_fmmy_m_mask_n.* =  g_fmmy_m.*
   
   #將最新資料顯示到畫面上
   CALL afmt590_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt590_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160122-00001#6 By 07900 - add -str
      LET l_n = 0 
      #单头存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM fmmy_t
       WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
         AND fmmy010 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')
         AND fmmy010 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')
         AND TRIM(fmmy010) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE afmt590_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#6 By 07900 -add -end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fmmy_t 
       WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmy_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM fmmz_t 
       WHERE fmmzent = g_enterprise AND fmmzdocno = g_fmmy_m.fmmydocno 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmz_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF       
       
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmmy_m.fmmydocno ,g_fmmy_m.fmmydocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmmy_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afmt590_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afmt590_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afmt590_browser_fill(g_wc,"")
         CALL afmt590_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt590_cl
 
   #功能已完成,通報訊息中心
   CALL afmt590_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt590_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_fmmydocno = g_fmmy_m.fmmydocno
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="afmt590.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt590_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fmmydocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("fmmysite,fmmy001",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("fmmy009,fmmy010",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt590_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmmydocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("fmmysite,fmmy001",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_fmmy_m.fmmy008 = '1' THEN              #150820-00011#8
      CALL cl_set_comp_entry("fmmy009,fmmy010",FALSE)
   END IF
   #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_fmmy_m.fmmydocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_fmmy_m.fmmydocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_glaald,g_glaa.glaacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("fmmydocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("fmmydocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt590_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt590.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt590_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_fmmy_m.fmmystus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt590.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt590_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fmmydocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt590.mask_functions" >}
&include "erp/afm/afmt590_mask.4gl"
 
{</section>}
 
{<section id="afmt590.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt590_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_count  LIKE type_t.num10
   DEFINE l_cnt1    LIKE type_t.num10    #150924-00006#4
   DEFINE l_date   DATETIME YEAR TO SECOND   #161026-00023#14   add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmmy_m.fmmydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt590_cl USING g_enterprise,g_fmmy_m.fmmydocno
   IF STATUS THEN
      CLOSE afmt590_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt590_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
       g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
       g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
       g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
       g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
       g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
       g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
       g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
       g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT afmt590_action_chk() THEN
      CLOSE afmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001, 
       g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_1_desc,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_2_desc, 
       g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_3_desc,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmy002_desc, 
       g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013, 
       g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003, 
       g_fmmy_m.l_fmmz011,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024, 
       g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
       g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010,g_fmmy_m.fmmy010_desc, 
       g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc,g_fmmy_m.fmmyownid, 
       g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtid_desc, 
       g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymodid_desc, 
       g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmycnfdt,g_fmmy_m.fmmypstid, 
       g_fmmy_m.fmmypstid_desc,g_fmmy_m.fmmypstdt
 
   CASE g_fmmy_m.fmmystus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
 
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fmmy_m.fmmystus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
     CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_fmmy_m.fmmystus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt590_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt590_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt590_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt590_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "X"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      g_fmmy_m.fmmystus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   #161026-00023#14   mark---s
   #IF lc_state = 'Y' THEN
   #   CALL cl_err_collect_init()
   #   IF g_fmmy_m.fmmy005 <= 0 THEN
   #      INITIALIZE g_errparam.* TO NULL
   #      LET g_errparam.code = 'afm-00123'
   #      LET g_errparam.extend = ''
   #      CALL cl_err()
   #      CALL s_transaction_end('N','0')
   #      CALL cl_err_collect_show()
   #      RETURN
   #   END IF
   #   
   #   #160118-00007#4 mark ------
   #   ##albireo 151210-----s
   #   ##判斷隱藏且為反推的最後一期利息用加總公式是否等於利息收入欄位,若不同,重新執行推算
   #   #IF g_fmmy_m.fmmy028 =  (g_fmmy_m.fmmy006 + g_fmmy_m.fmmy021 + g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025) THEN
   #   #ELSE
   #   #   LET g_fmmy_m.fmmy006 = g_fmmy_m.fmmy028 - (g_fmmy_m.fmmy021 + g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025)
   #   #END IF
   #   #IF g_fmmy_m.fmmy029 =  (g_fmmy_m.fmmy014 + g_fmmy_m.fmmy022 + g_fmmy_m.fmmy026 + g_fmmy_m.fmmy027) THEN
   #   #ELSE
   #   #   LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy029 - (g_fmmy_m.fmmy022 + g_fmmy_m.fmmy026 + g_fmmy_m.fmmy027)
   #   #END IF
   #   #UPDATE fmmy_t
   #   #   SET (fmmy006,fmmy014)
   #   #     = (g_fmmy_m.fmmy006 ,g_fmmy_m.fmmy014)
   #   #    WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
   #   ##albireo 151210-----e
   #   #160118-00007#4 mark end---
   #   #160118-00007#4 add ------
   #   #1.銀存利息收入原幣＝已宣告未發放股利＋已宣告未領取利息＋已計利息原幣＋最後一利息收入
   #   #  若有不合，　重計最後一期利息收入原幣
   #   #  最後一期利息本幣 = 最後一期利息原幣 * 利息匯率
   #   #  重推利息匯差
   #   #2.銀存利息收入本幣＝已宣告未發放股利本幣+已宣告未領取利息本幣+已計利息本幣+最後一利息收入本幣+利息匯差
   #   #  若有不合，　重計最後一期利息收入本幣 
   #   #  最後一期利息本幣 = 最後一期利息原幣 * 利息匯率 
   #   #  重推利息匯差
   #   IF g_fmmy_m.fmmy028 <> (g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025 + g_fmmy_m.fmmy021 + g_fmmy_m.fmmy006) THEN
   #      LET g_fmmy_m.fmmy006 = g_fmmy_m.fmmy028 - (g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025 + g_fmmy_m.fmmy021)
   #      LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy019
   #      CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
   #      #利息收入本幣-(已計利息本幣+已宣告未發放股利本幣+已宣告未領取利息本幣+最後一期利息本幣)
   #      LET g_fmmy_m.fmmy023 = g_fmmy_m.fmmy029-(g_fmmy_m.fmmy022+g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy014)
   #   END IF
   #   IF g_fmmy_m.fmmy029 <> (g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy022+g_fmmy_m.fmmy014+g_fmmy_m.fmmy023) THEN
   #      LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy019
   #      CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
   #      #利息收入本幣-(已計利息本幣+已宣告未發放股利本幣+已宣告未領取利息本幣+最後一期利息本幣)
   #      LET g_fmmy_m.fmmy023 = g_fmmy_m.fmmy029-(g_fmmy_m.fmmy022+g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy014)
   #   END IF
   #   
   #   UPDATE fmmy_t
   #      SET (fmmy006,fmmy014,fmmy023)
   #        = (g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy023)
   #       WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
   #   #160118-00007#4 add end---
   #   
   #   IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
   #      CALL s_transaction_end('N','0')
   #      CALL cl_err_collect_show()
   #      RETURN
   #   ELSE
   #      CALL afmt590_ins_fmmt('+')RETURNING g_sub_success   #151112-00009#2 add
   #      
   #      LET g_fmmy_m.fmmycnfdt = g_today
   #      LET g_fmmy_m.fmmycnfid = g_user
   #      UPDATE fmmy_t
   #      SET (fmmycnfdt,fmmycnfid)
   #        = (g_fmmy_m.fmmycnfdt ,g_fmmy_m.fmmycnfid)
   #       WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
   #   END IF
   #   #CALL s_transaction_end('Y','0')      #150401-00001#13
   #   CALL cl_err_collect_show()
   #END IF
   ##161026-00023#14   mark---e
   
   #161026-00023#14   add---s
   LET l_date = cl_get_current()
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_afmt590_conf_chk(g_fmmy_m.fmmydocno) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN                    
      END IF

      #160118-00007#4 add ------
      #1.銀存利息收入原幣＝已宣告未發放股利＋已宣告未領取利息＋已計利息原幣＋最後一利息收入
      #  若有不合，　重計最後一期利息收入原幣
      #  最後一期利息本幣 = 最後一期利息原幣 * 利息匯率
      #  重推利息匯差
      #2.銀存利息收入本幣＝已宣告未發放股利本幣+已宣告未領取利息本幣+已計利息本幣+最後一利息收入本幣+利息匯差
      #  若有不合，　重計最後一期利息收入本幣 
      #  最後一期利息本幣 = 最後一期利息原幣 * 利息匯率 
      #  重推利息匯差
      IF g_fmmy_m.fmmy028 <> (g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025 + g_fmmy_m.fmmy021 + g_fmmy_m.fmmy006) THEN
         LET g_fmmy_m.fmmy006 = g_fmmy_m.fmmy028 - (g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025 + g_fmmy_m.fmmy021)
         LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy019
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
         #利息收入本幣-(已計利息本幣+已宣告未發放股利本幣+已宣告未領取利息本幣+最後一期利息本幣)
         LET g_fmmy_m.fmmy023 = g_fmmy_m.fmmy029-(g_fmmy_m.fmmy022+g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy014)
      END IF
      IF g_fmmy_m.fmmy029 <> (g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy022+g_fmmy_m.fmmy014+g_fmmy_m.fmmy023) THEN
         LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy019
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
         #利息收入本幣-(已計利息本幣+已宣告未發放股利本幣+已宣告未領取利息本幣+最後一期利息本幣)
         LET g_fmmy_m.fmmy023 = g_fmmy_m.fmmy029-(g_fmmy_m.fmmy022+g_fmmy_m.fmmy026+g_fmmy_m.fmmy027+g_fmmy_m.fmmy014)
      END IF
      
      UPDATE fmmy_t
         SET (fmmy006,fmmy014,fmmy023)
           = (g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy023)
          WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
      #160118-00007#4 add end---
      
      IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         CALL s_transaction_begin()
         IF NOT s_afmt590_conf_upd(g_fmmy_m.fmmydocno) THEN
             CALL s_transaction_end('N','0')  
             CALL cl_err_collect_show()
             RETURN
          ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
         END IF  
      END IF
   END IF
   #161026-00023#14   add---e
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count
        FROM fmne_t,fmnf_t
       WHERE fmneent = fmnfent
         AND fmnedocno = fmnfdocno
         AND fmnestus <> 'X'
         AND fmnf002 = g_fmmy_m.fmmydocno
         AND fmnfent = g_enterprise
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'afm-00124'
         LET g_errparam.extend = ''
         CALL cl_err()
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      END IF
      
      IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         CALL afmt590_ins_fmmt('-')RETURNING g_sub_success   #151112-00009#2 add      
      
         LET g_fmmy_m.fmmycnfdt = ''
         LET g_fmmy_m.fmmycnfid = ''
         UPDATE fmmy_t
          SET (fmmycnfdt,fmmycnfid)
            = (g_fmmy_m.fmmycnfdt ,g_fmmy_m.fmmycnfid)
           WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
      END IF
      #CALL s_transaction_end('Y','0')      #150401-00001#13
      CALL cl_err_collect_show()
   END IF
   #作廢
   IF lc_state = 'X' THEN
      #詢問
      IF NOT cl_ask_confirm('aim-00109') THEN   #是否執作廢?
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      END IF
   END IF

   #end add-point
   
   LET g_fmmy_m.fmmymodid = g_user
   LET g_fmmy_m.fmmymoddt = cl_get_current()
   LET g_fmmy_m.fmmystus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmmy_t 
      SET (fmmystus,fmmymodid,fmmymoddt) 
        = (g_fmmy_m.fmmystus,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt)     
    WHERE fmmyent = g_enterprise AND fmmydocno = g_fmmy_m.fmmydocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afmt590_master_referesh USING g_fmmy_m.fmmydocno INTO g_fmmy_m.fmmysite,g_fmmy_m.fmmydocdt, 
          g_fmmy_m.fmmydocno,g_fmmy_m.fmmy001,g_fmmy_m.fmmy002,g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004, 
          g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013,g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029, 
          g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022, 
          g_fmmy_m.fmmy024,g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026, 
          g_fmmy_m.fmmy006,g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy010,g_fmmy_m.fmmy012, 
          g_fmmy_m.fmmy011,g_fmmy_m.fmmyownid,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmycrtid,g_fmmy_m.fmmycrtdp, 
          g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfdt, 
          g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstdt,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid_desc, 
          g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmypstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmmy_m.fmmysite,g_fmmy_m.fmmysite_desc,g_fmmy_m.fmmydocdt,g_fmmy_m.fmmydocno, 
          g_fmmy_m.fmmy001,g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_1_desc,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_2_desc, 
          g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_3_desc,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.fmmy002_desc, 
          g_fmmy_m.fmmystus,g_fmmy_m.fmmy003,g_fmmy_m.fmmy004,g_fmmy_m.fmmy005,g_fmmy_m.fmmy007,g_fmmy_m.fmmy013, 
          g_fmmy_m.fmmy028,g_fmmy_m.fmmy019,g_fmmy_m.fmmy029,g_fmmy_m.fmmy015,g_fmmy_m.fmmy016,g_fmmy_m.l_fmmz003, 
          g_fmmy_m.l_fmmz011,g_fmmy_m.fmmy017,g_fmmy_m.fmmy018,g_fmmy_m.fmmy021,g_fmmy_m.fmmy022,g_fmmy_m.fmmy024, 
          g_fmmy_m.fmmy025,g_fmmy_m.fmmy023,g_fmmy_m.fmmy020,g_fmmy_m.fmmy027,g_fmmy_m.fmmy026,g_fmmy_m.fmmy006, 
          g_fmmy_m.fmmy014,g_fmmy_m.fmmy008,g_fmmy_m.fmmy009,g_fmmy_m.fmmy009_desc,g_fmmy_m.fmmy010, 
          g_fmmy_m.fmmy010_desc,g_fmmy_m.fmmy012,g_fmmy_m.fmmy012_desc,g_fmmy_m.fmmy011,g_fmmy_m.fmmy011_desc, 
          g_fmmy_m.fmmyownid,g_fmmy_m.fmmyownid_desc,g_fmmy_m.fmmyowndp,g_fmmy_m.fmmyowndp_desc,g_fmmy_m.fmmycrtid, 
          g_fmmy_m.fmmycrtid_desc,g_fmmy_m.fmmycrtdp,g_fmmy_m.fmmycrtdp_desc,g_fmmy_m.fmmycrtdt,g_fmmy_m.fmmymodid, 
          g_fmmy_m.fmmymodid_desc,g_fmmy_m.fmmymoddt,g_fmmy_m.fmmycnfid,g_fmmy_m.fmmycnfid_desc,g_fmmy_m.fmmycnfdt, 
          g_fmmy_m.fmmypstid,g_fmmy_m.fmmypstid_desc,g_fmmy_m.fmmypstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #150820-00011#8---s
   LET g_success = 'Y'
   #161026-00023#14   mark---s
   #IF lc_state = 'Y' THEN 
   #   IF g_fmmy_m.fmmy008 MATCHES '[23]' THEN
   #      CALL afmt590_nmbc_insert()
   #      IF g_success = 'Y' THEN
   #         CALL afmt590_glbc_insert()
   #         IF g_success = 'Y' THEN
   #            CALL s_transaction_end('Y','1')
   #         ELSE
   #            CALL s_transaction_end('N','1')
   #            RETURN
   #         END IF 
   #      ELSE
   #         CALL s_transaction_end('N','1')
   #         RETURN
   #      END IF
   #   END IF
   #   #150924-00006#4-----s
   #   #維護費用則新增銀存收支異動檔
   #   LET l_cnt1 = 0
   #   SELECT COUNT(*) INTO l_cnt1 FROM fmmz_t WHERE fmmzent = g_enterprise AND fmmzdocno =  g_fmmy_m.fmmydocno AND fmmz008 IS NOT NULL
   #   IF l_cnt1 > 0 THEN     
   #      CALL afmt590_01_nmbc_insert()
   #      IF g_success = 'Y' THEN
   #         CALL afmt590_01_glbc_insert()
   #         IF g_success = 'Y' THEN
   #            CALL s_transaction_end('Y','1')
   #         ELSE
   #            CALL s_transaction_end('N','1')
   #            RETURN
   #         END IF 
   #      ELSE
   #         CALL s_transaction_end('N','1')
   #         RETURN
   #      END IF
   #   END IF
   #   #150924-00006#4-----e
   #END IF
   #161026-00023#14   mark---e
   IF lc_state = 'N' THEN  
      #150924-00006#4-----s
      LET l_cnt1 = 0
      SELECT COUNT(*) INTO l_cnt1 FROM fmmz_t WHERE fmmzent = g_enterprise AND fmmzdocno =  g_fmmy_m.fmmydocno AND fmmz008 IS NOT NULL
      #150924-00006#4-----e
      IF g_fmmy_m.fmmy008 MATCHES '[23]' OR l_cnt1 > 0 THEN  #150924-00006#4 add l_cnt
         CALL afmt590_nmbc_delete()      
         IF g_success = 'Y' THEN
            CALL afmt590_glbc_delete()
            IF g_sub_success THEN
               CALL s_transaction_end('Y','1')
            ELSE
               CALL s_transaction_end('N','1')
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','1')
            RETURN
         END IF
      END IF
   END IF
   #150820-00011#8---e
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt590_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt590_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt590.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt590_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
 
 
   CALL afmt590_show()
   CALL afmt590_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmmy_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL afmt590_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt590_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt590.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt590_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_fmmy_m.fmmydocno
   LET g_pk_array[1].column = 'fmmydocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt590.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afmt590.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt590_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL afmt590_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmmy_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt590.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt590_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
    #160818-00017#13  2016/08/23  By 07900  add --s -
    SELECT fmmystus INTO g_fmmy_m.fmmystus
     FROM fmmy_t
    WHERE fmmyent = g_enterprise
      AND fmmydocno = g_fmmy_m.fmmydocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmmy_m.fmmystus
        
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_fmmy_m.fmmydocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt590_set_act_visible()
        CALL afmt590_set_act_no_visible()
        CALL afmt590_show()
        RETURN FALSE
     END IF
   END IF
    
    #160818-00017#13  2016/08/23  By 07900  add --e-
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt590.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afmt590_b_fill2(p_docno)
   DEFINE p_docno   LIKE fmmj_t.fmmjdocno
   DEFINE l_sql     STRING
   DEFINE l_idx     LIKE type_t.num10
   DEFINE l_sumall  LIKE type_t.num20_6
   
   
   #151103-00016#4 modify-----s
#   LET l_sql = "SELECT 1,fmmjdocno,0,0,fmmjdocdt,fmmj005,fmmj006,",
#               "       fmmj008,COALESCE(fmmk005,0),0,0,0,0,0,0, ",
#               "       0 ",    #151103-00016#4 add
#               "  FROM fmmj_t ",
#               "       LEFT OUTER JOIN(",
#               "            SELECT fmmkent,fmmk001,SUM(fmmk005) fmmk005 ",
#               "              FROM fmmk_t ",
#               "             GROUP BY fmmkent,fmmk001 ",
#               "       ) ON fmmkent = fmmjent ",
#               "         AND fmmk001 = fmmjdocno ",
#               " WHERE fmmjent = ",g_enterprise," ",
#               "   AND fmmjdocno = '",p_docno,"' "
   LET l_sql = "SELECT 1,fmmjdocno,0,0,fmmjdocdt,fmmj005,fmmj006,",
               "       fmmj028,COALESCE(fmmk013,0),0,0,0,0,0,0, ",
               "       0 ",    
               "  FROM fmmj_t ",
               "       LEFT OUTER JOIN(",
               "            SELECT fmmkent,fmmk001,SUM(fmmk013) fmmk013 ",
               "              FROM fmmk_t ",
               "             GROUP BY fmmkent,fmmk001 ",
               "       ) ON fmmkent = fmmjent ",
               "         AND fmmk001 = fmmjdocno ",
               " WHERE fmmjent = ",g_enterprise," ",
               "   AND fmmjdocno = '",p_docno,"' "
   #151103-00016#4 modify-----e
   PREPARE sel_fmmjp1 FROM l_sql
   DECLARE sel_fmmjc1 CURSOR FOR sel_fmmjp1
  
   #151103-00016#4-----s  
#   LET l_sql = "SELECT 3,fmmvdocno,0,0,fmmvdocdt,0,fmmv004,",
#               "       0,0,0,fmmv005,0,COALESCE(fmnd003,0),0,0, ",
#               "       0 ", #151103-00016#4
#               "  FROM fmmv_t ",
#               "       LEFT OUTER JOIN(",
#               "       SELECT fmndent,fmnddocno,SUM(fmnd003) fmnd003 ",
#               "         FROM fmnd_t ",
#               "        GROUP BY fmndent,fmnddocno ",
#               "       )ON fmndent = fmmvent ",
#               "        AND fmnddocno = fmmvdocno ",
#               " WHERE fmmvent = ",g_enterprise," ",
#               "   AND fmmv001 = '",p_docno,"' "
   LET l_sql = "SELECT 3,fmmvdocno,0,0,fmmvdocdt,0,fmmv004,",
               "       0,0,0,fmmv014,0,COALESCE(fmnd011,0),0,0, ",
               "       0 ", 
               "  FROM fmmv_t ",
               "       LEFT OUTER JOIN(",
               "       SELECT fmndent,fmnddocno,SUM(fmnd011) fmnd011 ",
               "         FROM fmnd_t ",
               "        GROUP BY fmndent,fmnddocno ",
               "       )ON fmndent = fmmvent ",
               "        AND fmnddocno = fmmvdocno ",
               " WHERE fmmvent = ",g_enterprise," ",
               "   AND fmmv001 = '",p_docno,"' "               
   #151103-00016#4-----e
   PREPARE sel_fmmvp1 FROM l_sql
   DECLARE sel_fmmvc1 CURSOR FOR sel_fmmvp1
   
   #151103-00016#4-----s   
#   LET l_sql = "SELECT 2,fmmydocno,0,0,fmmydocdt,fmmy003,fmmy002,",
#               "       0,0,0,fmmy006,fmmy005,COALESCE(fmmz003,0),0,0, ",
#               "       0 ",    #151103-00016#4
#               "  FROM fmmy_t ",
#               "       LEFT OUTER JOIN(",
#               "       SELECT fmmzent,fmmzdocno,SUM(fmmz003) fmmz003 ",
#               "         FROM fmmz_t  ",
#               "        GROUP BY fmmzent,fmmzdocno ",
#                       ") ON fmmzent = fmmyent AND fmmzdocno = fmmydocno",
#               " WHERE fmmyent = ",g_enterprise," ",
#               "   AND fmmy001 = '",p_docno,"' "
   
   
   LET l_sql = "SELECT 2,fmmydocno,0,0,fmmydocdt,fmmy003,fmmy002,",
               "       0,0,0,fmmy014,fmmy013,COALESCE(fmmz011,0),0,0, ",
               "       0 ",    
               "  FROM fmmy_t ",
               "       LEFT OUTER JOIN(",
               "       SELECT fmmzent,fmmzdocno,SUM(fmmz011) fmmz011 ",
               "         FROM fmmz_t  ",
               "        GROUP BY fmmzent,fmmzdocno ",
                       ") ON fmmzent = fmmyent AND fmmzdocno = fmmydocno",
               " WHERE fmmyent = ",g_enterprise," ",
               "   AND fmmy001 = '",p_docno,"' "
   #151103-00016#4-----e
   PREPARE sel_fmmyp1 FROM l_sql
   DECLARE sel_fmmyc1 CURSOR FOR sel_fmmyp1
   
   CALL g_memo_afmt590.clear()
   LET l_idx = 1
   FOREACH sel_fmmjc1 INTO g_memo_afmt590[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmjc1'
         CALL cl_err()
      END IF
      LET g_memo_afmt590[l_idx].l_yy = YEAR(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_mm = MONTH(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_sumcost = g_memo_afmt590[l_idx].l_account1 + g_memo_afmt590[l_idx].l_cost1
      LET g_memo_afmt590[l_idx].l_sumaccount = g_memo_afmt590[l_idx].l_account2 +g_memo_afmt590[l_idx].l_account3 - g_memo_afmt590[l_idx].l_cost2
      LET g_memo_afmt590[l_idx].l_sumall =  g_memo_afmt590[l_idx].l_sumaccount - g_memo_afmt590[l_idx].l_sumcost
      LET g_memo_afmt590[l_idx].l_sumaccount2 =  g_memo_afmt590[l_idx].l_sumall   #151103-00016#4 add
      LET l_idx = l_idx + 1
   END FOREACH

   FOREACH sel_fmmvc1 INTO g_memo_afmt590[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmvc1'
         CALL cl_err()
      END IF
      LET g_memo_afmt590[l_idx].l_yy = YEAR(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_mm = MONTH(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_sumcost = g_memo_afmt590[l_idx].l_account1 + g_memo_afmt590[l_idx].l_cost1
      LET g_memo_afmt590[l_idx].l_sumaccount = g_memo_afmt590[l_idx].l_account2 +g_memo_afmt590[l_idx].l_account3 - g_memo_afmt590[l_idx].l_cost2
      LET g_memo_afmt590[l_idx].l_sumall =  g_memo_afmt590[l_idx].l_sumaccount - g_memo_afmt590[l_idx].l_sumcost 
      LET g_memo_afmt590[l_idx].l_sumaccount2 =  g_memo_afmt590[l_idx].l_sumall   #151103-00016#4 add
      LET l_idx = l_idx + 1
   END FOREACH

   FOREACH sel_fmmyc1 INTO g_memo_afmt590[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmyc1'
         CALL cl_err()
      END IF
      LET g_memo_afmt590[l_idx].l_yy = YEAR(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_mm = MONTH(g_memo_afmt590[l_idx].l_docdt)
      LET g_memo_afmt590[l_idx].l_sumcost = g_memo_afmt590[l_idx].l_account1 + g_memo_afmt590[l_idx].l_cost1
      LET g_memo_afmt590[l_idx].l_sumaccount = g_memo_afmt590[l_idx].l_account2 +g_memo_afmt590[l_idx].l_account3 - g_memo_afmt590[l_idx].l_cost2
      LET g_memo_afmt590[l_idx].l_sumall =  g_memo_afmt590[l_idx].l_sumaccount - g_memo_afmt590[l_idx].l_sumcost
      LET g_memo_afmt590[l_idx].l_sumaccount2 =  g_memo_afmt590[l_idx].l_sumall   #151103-00016#4 add
      LET l_idx = l_idx + 1
   END FOREACH
   CALL g_memo_afmt590.deleteElement(g_memo_afmt590.getLength())
   LET g_rec_b2 = l_idx - 1
   
   LET l_sumall = 0
   FOR l_idx = 1 TO g_memo_afmt590.getLength()
      LET l_sumall = l_sumall + (g_memo_afmt590[l_idx].l_sumaccount - g_memo_afmt590[l_idx].l_sumcost)
      LET g_memo_afmt590[l_idx].l_sumall = l_sumall
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
PRIVATE FUNCTION afmt590_fmmy001_desc(p_fmmy001)
   DEFINE p_fmmy001   LIKE fmmy_t.fmmy001
   
   
   LET g_fmmy_m.l_fmmy001_1 = NULL
   LET g_fmmy_m.l_fmmy001_2 = NULL
   LET g_fmmy_m.l_fmmy001_3 = NULL
   LET g_fmmy_m.l_fmmy001_4 = NULL
   LET g_fmmy_m.fmmy002 = NULL
   SELECT fmmj001,fmmj002,fmmj003,fmmj004,fmmj006
     INTO g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_2,
          g_fmmy_m.l_fmmy001_3,g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002
     FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = p_fmmy001
   CALL s_desc_fmme001_desc( g_fmmy_m.l_fmmy001_2) RETURNING g_fmmy_m.l_fmmy001_2_desc    
   DISPLAY BY NAME g_fmmy_m.l_fmmy001_1,g_fmmy_m.l_fmmy001_2,g_fmmy_m.l_fmmy001_3,
                   g_fmmy_m.l_fmmy001_4,g_fmmy_m.fmmy002,g_fmmy_m.l_fmmy001_2_desc
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
PRIVATE FUNCTION afmt590_get_source_used_amount(p_fmmydocno,p_fmmy001,p_cmd)
   DEFINE p_fmmydocno   LIKE fmmy_t.fmmydocno
   DEFINE p_fmmy001     LIKE fmmy_t.fmmy001
   DEFINE r_amount      LIKE type_t.num20_6
   DEFINE r_amount_used LIKE type_t.num20_6
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_errno       LIKE gzze_t.gzze001
   DEFINE l_amount_book LIKE type_t.num20_6
   DEFINE l_fmmy001     LIKE fmmy_t.fmmy001
   DEFINE p_cmd         LIKE type_t.chr1
   DEFINE l_sql         STRING
   
   LET r_amount      = NULL
   LET r_amount_used = NULL
   LET r_success     = TRUE
   LET r_errno       = NULL
   LET l_fmmy001     = NULL
#   SELECT fmmy001 INTO l_fmmy001 FROM fmmy_t
#    WHERE fmmyent = g_enterprise
#      AND fmmydocno = p_fmmydocno
   #

   LET l_sql = " SELECT SUM(fmmy003) FROM fmmy_t ",
               "   WHERE fmmyent = ", g_enterprise," ",
               "     AND fmmy001 = '",p_fmmy001,"' "
   IF p_cmd = 'u' THEN
      LET l_sql = "   AND NOT fmmydocno = '",p_fmmydocno,"' "
   END IF
   PREPARE sel_sumfmmyp1 FROM l_sql
   
   LET l_amount_book = NULL   
   EXECUTE sel_sumfmmyp1 INTO l_amount_book   
   IF cl_null(l_amount_book)THEN LET l_amount_book = 0 END IF
   
   FREE sel_sumfmmyp1
   
   SELECT fmmj005 INTO r_amount FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = p_fmmy001
   IF cl_null(r_amount)THEN LET r_amount = 0 END IF
   
   LET r_amount_used = r_amount - l_amount_book
   RETURN r_success,r_errno,r_amount,r_amount_used
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
PRIVATE FUNCTION afmt590_fmmy001_chk(p_fmmy001)
   DEFINE p_fmmy001   LIKE fmmy_t.fmmy001
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_fmmj      RECORD
                      fmmjstus   LIKE fmmj_t.fmmjstus
                      END RECORD
                      
   LET r_success = TRUE
   LET r_errno   = NULL
   
   INITIALIZE l_fmmj.* TO NULL
   SELECT fmmjstus INTO l_fmmj.* FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno  = p_fmmy001
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno  = 'afm-00079'
      WHEN l_fmmj.fmmjstus <> 'Y'
         LET r_errno  = 'afm-00080'
         LET r_success = FALSE
   END CASE
    
   RETURN r_success,r_errno
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
PRIVATE FUNCTION afmt590_nmaa_nmas_chk(p_fmmy009,p_fmmy010)
   DEFINE p_fmmy009   LIKE fmmy_t.fmmy009
   DEFINE p_fmmy010   LIKE fmmy_t.fmmy010
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_nmaa      RECORD
                      nmaastus   LIKE nmaa_t.nmaastus,
                      nmaa002    LIKE nmaa_t.nmaa002,
                      nmas003    LIKE nmas_t.nmas003
                      END RECORD
   DEFINE l_sql       STRING
   DEFINE l_count     LIKE type_t.num5   
                     
   LET r_success = TRUE
   LET r_errno   = ''
   
   LET l_sql = NULL
   
   IF NOT cl_null(p_fmmy009)THEN
      #存在單頭
      #LET l_sql   = "SELECT COUNT(*) FROM nmaa_t ",
      #              " WHERE nmaaent = ",g_enterprise," AND nmaa004 = '",p_fmmy009,"' "
      LET l_sql = "SELECT COUNT(*) FROM nmaa_t,nmas_t ",
                  " WHERE nmaaent = ",g_enterprise," ",
                  "   AND nmas001 = nmaa001 ",
                  "   AND nmaa004 = '",p_fmmy009,"' "
      PREPARE sel_nmaap01 FROM l_sql
      LET l_count = NULL
      EXECUTE sel_nmaap01 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00083'
         RETURN r_success,r_errno
      END IF
      #存在並有效
      LET l_sql   = l_sql,"  AND nmaastus = 'Y' "
      PREPARE sel_nmaap02 FROM l_sql
      LET l_count = NULL
      EXECUTE sel_nmaap02 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00084'
         RETURN r_success,r_errno
      END IF
      #單身有對應幣別
      LET l_sql = l_sql CLIPPED," AND nmas003 = '",g_fmmy_m.fmmy002,"' "
      PREPARE sel_nmaap06 FROM l_sql
      LET l_count = NULL
      EXECUTE sel_nmaap06 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00088'
         RETURN r_success,r_errno
      END IF      
      
      FREE sel_nmaap01
      FREE sel_nmaap02
      FREE sel_nmaap06
   END IF
   IF NOT cl_null(p_fmmy009) AND NOT cl_null(p_fmmy010)THEN
      #存在單頭+單身
      LET l_sql = "SELECT COUNT(*) FROM nmaa_t,nmas_t ",
                  " WHERE nmaaent = ",g_enterprise," ",
                  "   AND nmas001 = nmaa001 ",
                  "   AND nmaa004 = '",p_fmmy009,"' ",
                  "   AND nmas002 = '",p_fmmy010,"' "
      PREPARE sel_nmaap03 FROM l_sql            
      
      LET l_count = NULL
      EXECUTE sel_nmaap03 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00085'
         RETURN r_success,r_errno
      END IF
      #存在單頭+單身+有效
      LET l_sql = l_sql CLIPPED," AND nmaastus = 'Y' "
      PREPARE sel_nmaap04 FROM l_sql  
      LET l_count = NULL
      EXECUTE sel_nmaap04 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00086'
         RETURN r_success,r_errno
      END IF
      #存在單頭+單身+幣別
      LET l_sql = l_sql CLIPPED," AND nmas003 = '",g_fmmy_m.fmmy002,"' "
      PREPARE sel_nmaap05 FROM l_sql 
      LET l_count = NULL
      EXECUTE sel_nmaap05 INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'afm-00087'
         RETURN r_success,r_errno
      END IF      
      
      FREE sel_nmaap03
      FREE sel_nmaap04
      FREE sel_nmaap05
   END IF
  
   RETURN r_success,r_errno
END FUNCTION
################################################################################
# Descriptions...: 審核時將資料寫入nmbc_t
# Memo...........: #150820-00011#8
# Date & Author..: 150902 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_nmbc_insert()
#DEFINE l_nmbc   RECORD   LIKE nmbc_t.* #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbcud001 LIKE nmbc_t.nmbcud001, #自定義欄位(文字)001
       nmbcud002 LIKE nmbc_t.nmbcud002, #自定義欄位(文字)002
       nmbcud003 LIKE nmbc_t.nmbcud003, #自定義欄位(文字)003
       nmbcud004 LIKE nmbc_t.nmbcud004, #自定義欄位(文字)004
       nmbcud005 LIKE nmbc_t.nmbcud005, #自定義欄位(文字)005
       nmbcud006 LIKE nmbc_t.nmbcud006, #自定義欄位(文字)006
       nmbcud007 LIKE nmbc_t.nmbcud007, #自定義欄位(文字)007
       nmbcud008 LIKE nmbc_t.nmbcud008, #自定義欄位(文字)008
       nmbcud009 LIKE nmbc_t.nmbcud009, #自定義欄位(文字)009
       nmbcud010 LIKE nmbc_t.nmbcud010, #自定義欄位(文字)010
       nmbcud011 LIKE nmbc_t.nmbcud011, #自定義欄位(數字)011
       nmbcud012 LIKE nmbc_t.nmbcud012, #自定義欄位(數字)012
       nmbcud013 LIKE nmbc_t.nmbcud013, #自定義欄位(數字)013
       nmbcud014 LIKE nmbc_t.nmbcud014, #自定義欄位(數字)014
       nmbcud015 LIKE nmbc_t.nmbcud015, #自定義欄位(數字)015
       nmbcud016 LIKE nmbc_t.nmbcud016, #自定義欄位(數字)016
       nmbcud017 LIKE nmbc_t.nmbcud017, #自定義欄位(數字)017
       nmbcud018 LIKE nmbc_t.nmbcud018, #自定義欄位(數字)018
       nmbcud019 LIKE nmbc_t.nmbcud019, #自定義欄位(數字)019
       nmbcud020 LIKE nmbc_t.nmbcud020, #自定義欄位(數字)020
       nmbcud021 LIKE nmbc_t.nmbcud021, #自定義欄位(日期時間)021
       nmbcud022 LIKE nmbc_t.nmbcud022, #自定義欄位(日期時間)022
       nmbcud023 LIKE nmbc_t.nmbcud023, #自定義欄位(日期時間)023
       nmbcud024 LIKE nmbc_t.nmbcud024, #自定義欄位(日期時間)024
       nmbcud025 LIKE nmbc_t.nmbcud025, #自定義欄位(日期時間)025
       nmbcud026 LIKE nmbc_t.nmbcud026, #自定義欄位(日期時間)026
       nmbcud027 LIKE nmbc_t.nmbcud027, #自定義欄位(日期時間)027
       nmbcud028 LIKE nmbc_t.nmbcud028, #自定義欄位(日期時間)028
       nmbcud029 LIKE nmbc_t.nmbcud029, #自定義欄位(日期時間)029
       nmbcud030 LIKE nmbc_t.nmbcud030, #自定義欄位(日期時間)030
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
END RECORD
#161104-00024#11 --e add
DEFINE l_nmbc113         LIKE nmbc_t.nmbc113 
DEFINE l_glaa001         LIKE glaa_t.glaa001   
   #計算主帳套本幣金額
   #151029-00012#7---mark-s
   #LET l_nmbc113 = g_fmmy_m.fmmy007 * (g_fmmy_m.fmmy005 + g_fmmy_m.fmmy006)
   #IF cl_null(l_nmbc113) THEN LET l_nmbc113 = 0 END IF
   #SELECT glaa001 INTO l_glaa001
   #  FROM glaa_t
   # WHERE glaaent = g_enterprise AND glaaent = g_glaald
   #CALL s_curr_round_ld('1',g_glaald,l_glaa001,l_nmbc113,2) RETURNING g_sub_success,g_errno,l_nmbc113
   #151029-00012#7---mark-e
   
   #本金
   INITIALIZE l_nmbc.* TO NULL   #151117-00001#4 add
   LET l_nmbc.nmbcent   =  g_enterprise      
   LET l_nmbc.nmbccomp  =  g_glaa.glaacomp
   LET l_nmbc.nmbcsite  =  g_fmmy_m.fmmysite 
   LET l_nmbc.nmbcdocno =  g_fmmy_m.fmmydocno 
   #LET l_nmbc.nmbcseq   =  '0' #151117-00001#4 mark
   LET l_nmbc.nmbcseq   = 1     ##151117-00001#4 add
   LET l_nmbc.nmbc001   =  'afmt590' 
   LET l_nmbc.nmbc002   =  g_fmmy_m.fmmy010 
   LET l_nmbc.nmbc003   =  ''
   LET l_nmbc.nmbc004   =  ''
   LET l_nmbc.nmbc005   =  g_fmmy_m.fmmydocdt 
   LET l_nmbc.nmbc006   =  '1'
   LET l_nmbc.nmbc007   =  g_fmmy_m.fmmy012 
   LET l_nmbc.nmbc008   =  '' 
   LET l_nmbc.nmbc009   =  '' 
   LET l_nmbc.nmbc010   =  '' 
   LET l_nmbc.nmbc011   =  '' 
   LET l_nmbc.nmbc012   =  '' 
   LET l_nmbc.nmbc013   =  '' 
   LET l_nmbc.nmbc014   =  ''              #151012-00014#6
   LET l_nmbc.nmbc015   =  ''              #151012-00014#6
   LET l_nmbc.nmbc016   =  ''              #151012-00014#6
   LET l_nmbc.nmbc100   =  g_fmmy_m.fmmy002
   LET l_nmbc.nmbc101   =  g_fmmy_m.fmmy007
   #151117-00001#4-----s
#   LET l_nmbc.nmbc103   =  g_fmmy_m.fmmy005 + g_fmmy_m.fmmy006  
#   LET l_nmbc.nmbc113   =  g_fmmy_m.fmmy013 + g_fmmy_m.fmmy014   #151029-00012#7
#   #LET l_nmbc.nmbc113   =  l_nmbc113                            #151029-00012#7 mark
   LET l_nmbc.nmbc103   =  g_fmmy_m.fmmy005
   LET l_nmbc.nmbc113   =  g_fmmy_m.fmmy013
   #151117-00001#4-----e
   LET l_nmbc.nmbc121   = '0' 
   LET l_nmbc.nmbc123   = '0'
   LET l_nmbc.nmbc131   = '0'
   LET l_nmbc.nmbc133   = '0'   
   LET l_nmbc.nmbcownid = g_user
   LET l_nmbc.nmbcowndp = g_dept
   LET l_nmbc.nmbccrtid = g_user
   LET l_nmbc.nmbccrtdp = g_dept 
   LET l_nmbc.nmbccrtdt = cl_get_current()
   LET l_nmbc.nmbcorga  = g_fmmy_m.fmmysite  #160322-00025#20 add 
  #INSERT INTO nmbc_t VALUES(l_nmbc.*) #161104-00024#11 mark
   #161104-00024#11 --s add
   INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                      nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                      nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                      nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                      nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                      nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                      nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                      nmbc133,nmbcud001,nmbcud002,nmbcud003,nmbcud004,
                      nmbcud005,nmbcud006,nmbcud007,nmbcud008,nmbcud009,
                      nmbcud010,nmbcud011,nmbcud012,nmbcud013,nmbcud014,
                      nmbcud015,nmbcud016,nmbcud017,nmbcud018,nmbcud019,
                      nmbcud020,nmbcud021,nmbcud022,nmbcud023,nmbcud024,
                      nmbcud025,nmbcud026,nmbcud027,nmbcud028,nmbcud029,
                      nmbcud030,nmbc012,nmbc013,nmbc014,nmbc015,
                      nmbc016,nmbc017,nmbcorga)
   VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
          l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,
          l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,
          l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,
          l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,
          l_nmbc.nmbc009,l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,
          l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,
          l_nmbc.nmbc133,l_nmbc.nmbcud001,l_nmbc.nmbcud002,l_nmbc.nmbcud003,l_nmbc.nmbcud004,
          l_nmbc.nmbcud005,l_nmbc.nmbcud006,l_nmbc.nmbcud007,l_nmbc.nmbcud008,l_nmbc.nmbcud009,
          l_nmbc.nmbcud010,l_nmbc.nmbcud011,l_nmbc.nmbcud012,l_nmbc.nmbcud013,l_nmbc.nmbcud014,
          l_nmbc.nmbcud015,l_nmbc.nmbcud016,l_nmbc.nmbcud017,l_nmbc.nmbcud018,l_nmbc.nmbcud019,
          l_nmbc.nmbcud020,l_nmbc.nmbcud021,l_nmbc.nmbcud022,l_nmbc.nmbcud023,l_nmbc.nmbcud024,
          l_nmbc.nmbcud025,l_nmbc.nmbcud026,l_nmbc.nmbcud027,l_nmbc.nmbcud028,l_nmbc.nmbcud029,
          l_nmbc.nmbcud030,l_nmbc.nmbc012,l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,
          l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
   #161104-00024#11 --e add
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET g_success = 'N'                        
   END IF  
   
   #151117-00001#4-----s
   #利息
   INITIALIZE l_nmbc.* TO NULL   #151117-00001#4 add
   LET l_nmbc.nmbcent   =  g_enterprise      
   LET l_nmbc.nmbccomp  =  g_glaa.glaacomp
   LET l_nmbc.nmbcsite  =  g_fmmy_m.fmmysite 
   LET l_nmbc.nmbcdocno =  g_fmmy_m.fmmydocno 
   LET l_nmbc.nmbcseq   = 2   
   LET l_nmbc.nmbc001   =  'afmt590' 
   LET l_nmbc.nmbc002   =  g_fmmy_m.fmmy010 
   LET l_nmbc.nmbc003   =  ''
   LET l_nmbc.nmbc004   =  ''
   LET l_nmbc.nmbc005   =  g_fmmy_m.fmmydocdt 
   LET l_nmbc.nmbc006   =  '1'
   LET l_nmbc.nmbc007   =  g_fmmy_m.fmmy012 
   LET l_nmbc.nmbc008   =  '' 
   LET l_nmbc.nmbc009   =  '' 
   LET l_nmbc.nmbc010   =  '' 
   LET l_nmbc.nmbc011   =  '' 
   LET l_nmbc.nmbc012   =  '' 
   LET l_nmbc.nmbc013   =  '' 
   LET l_nmbc.nmbc014   =  ''              
   LET l_nmbc.nmbc015   =  ''              
   LET l_nmbc.nmbc016   =  ''              
   LET l_nmbc.nmbc100   =  g_fmmy_m.fmmy002
   LET l_nmbc.nmbc101   =  g_fmmy_m.fmmy007
   #151203-00013#2 --s
   #LET l_nmbc.nmbc103   =  g_fmmy_m.fmmy006  
   #LET l_nmbc.nmbc113   =  g_fmmy_m.fmmy014
   LET l_nmbc.nmbc103   =  g_fmmy_m.fmmy028  
   LET l_nmbc.nmbc113   =  g_fmmy_m.fmmy029  
   #151203-00013#2 --e
   LET l_nmbc.nmbc121   = '0' 
   LET l_nmbc.nmbc123   = '0'
   LET l_nmbc.nmbc131   = '0'
   LET l_nmbc.nmbc133   = '0'   
   LET l_nmbc.nmbcownid = g_user
   LET l_nmbc.nmbcowndp = g_dept
   LET l_nmbc.nmbccrtid = g_user
   LET l_nmbc.nmbccrtdp = g_dept 
   LET l_nmbc.nmbccrtdt = cl_get_current()
   LET l_nmbc.nmbcorga  = g_fmmy_m.fmmysite  #160322-00025#20 add
   
  #INSERT INTO nmbc_t VALUES(l_nmbc.*) #161104-00024#11 mark
   #161104-00024#11 --s add
   INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                      nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                      nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                      nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                      nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                      nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                      nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                      nmbc133,nmbcud001,nmbcud002,nmbcud003,nmbcud004,
                      nmbcud005,nmbcud006,nmbcud007,nmbcud008,nmbcud009,
                      nmbcud010,nmbcud011,nmbcud012,nmbcud013,nmbcud014,
                      nmbcud015,nmbcud016,nmbcud017,nmbcud018,nmbcud019,
                      nmbcud020,nmbcud021,nmbcud022,nmbcud023,nmbcud024,
                      nmbcud025,nmbcud026,nmbcud027,nmbcud028,nmbcud029,
                      nmbcud030,nmbc012,nmbc013,nmbc014,nmbc015,
                      nmbc016,nmbc017,nmbcorga)
   VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
          l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,
          l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,
          l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,
          l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,
          l_nmbc.nmbc009,l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,
          l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,
          l_nmbc.nmbc133,l_nmbc.nmbcud001,l_nmbc.nmbcud002,l_nmbc.nmbcud003,l_nmbc.nmbcud004,
          l_nmbc.nmbcud005,l_nmbc.nmbcud006,l_nmbc.nmbcud007,l_nmbc.nmbcud008,l_nmbc.nmbcud009,
          l_nmbc.nmbcud010,l_nmbc.nmbcud011,l_nmbc.nmbcud012,l_nmbc.nmbcud013,l_nmbc.nmbcud014,
          l_nmbc.nmbcud015,l_nmbc.nmbcud016,l_nmbc.nmbcud017,l_nmbc.nmbcud018,l_nmbc.nmbcud019,
          l_nmbc.nmbcud020,l_nmbc.nmbcud021,l_nmbc.nmbcud022,l_nmbc.nmbcud023,l_nmbc.nmbcud024,
          l_nmbc.nmbcud025,l_nmbc.nmbcud026,l_nmbc.nmbcud027,l_nmbc.nmbcud028,l_nmbc.nmbcud029,
          l_nmbc.nmbcud030,l_nmbc.nmbc012,l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,
          l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
   #161104-00024#11 --e add
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET g_success = 'N'                        
   END IF  
   #151117-00001#4-----e
END FUNCTION
################################################################################
# Descriptions...: 審核時將資料寫入glbc_t
# Memo...........: #150820-00011#8
# Date & Author..: 150902 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_glbc_insert()
#DEFINE l_glbc   RECORD   LIKE glbc_t.*  #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企業編號
       glbcld LIKE glbc_t.glbcld, #帳套
       glbccomp LIKE glbc_t.glbccomp, #營運據點
       glbcdocno LIKE glbc_t.glbcdocno, #傳票編號
       glbcseq LIKE glbc_t.glbcseq, #項次
       glbcseq1 LIKE glbc_t.glbcseq1, #序號
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期別
       glbc003 LIKE glbc_t.glbc003, #借貸別
       glbc004 LIKE glbc_t.glbc004, #現金變動碼
       glbc005 LIKE glbc_t.glbc005, #交易客商
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbcud001 LIKE glbc_t.glbcud001, #自定義欄位(文字)001
       glbcud002 LIKE glbc_t.glbcud002, #自定義欄位(文字)002
       glbcud003 LIKE glbc_t.glbcud003, #自定義欄位(文字)003
       glbcud004 LIKE glbc_t.glbcud004, #自定義欄位(文字)004
       glbcud005 LIKE glbc_t.glbcud005, #自定義欄位(文字)005
       glbcud006 LIKE glbc_t.glbcud006, #自定義欄位(文字)006
       glbcud007 LIKE glbc_t.glbcud007, #自定義欄位(文字)007
       glbcud008 LIKE glbc_t.glbcud008, #自定義欄位(文字)008
       glbcud009 LIKE glbc_t.glbcud009, #自定義欄位(文字)009
       glbcud010 LIKE glbc_t.glbcud010, #自定義欄位(文字)010
       glbcud011 LIKE glbc_t.glbcud011, #自定義欄位(數字)011
       glbcud012 LIKE glbc_t.glbcud012, #自定義欄位(數字)012
       glbcud013 LIKE glbc_t.glbcud013, #自定義欄位(數字)013
       glbcud014 LIKE glbc_t.glbcud014, #自定義欄位(數字)014
       glbcud015 LIKE glbc_t.glbcud015, #自定義欄位(數字)015
       glbcud016 LIKE glbc_t.glbcud016, #自定義欄位(數字)016
       glbcud017 LIKE glbc_t.glbcud017, #自定義欄位(數字)017
       glbcud018 LIKE glbc_t.glbcud018, #自定義欄位(數字)018
       glbcud019 LIKE glbc_t.glbcud019, #自定義欄位(數字)019
       glbcud020 LIKE glbc_t.glbcud020, #自定義欄位(數字)020
       glbcud021 LIKE glbc_t.glbcud021, #自定義欄位(日期時間)021
       glbcud022 LIKE glbc_t.glbcud022, #自定義欄位(日期時間)022
       glbcud023 LIKE glbc_t.glbcud023, #自定義欄位(日期時間)023
       glbcud024 LIKE glbc_t.glbcud024, #自定義欄位(日期時間)024
       glbcud025 LIKE glbc_t.glbcud025, #自定義欄位(日期時間)025
       glbcud026 LIKE glbc_t.glbcud026, #自定義欄位(日期時間)026
       glbcud027 LIKE glbc_t.glbcud027, #自定義欄位(日期時間)027
       glbcud028 LIKE glbc_t.glbcud028, #自定義欄位(日期時間)028
       glbcud029 LIKE glbc_t.glbcud029, #自定義欄位(日期時間)029
       glbcud030 LIKE glbc_t.glbcud030, #自定義欄位(日期時間)030
       glbc015 LIKE glbc_t.glbc015  #狀態碼
END RECORD
#161104-00024#11 --e add
DEFINE l_glbc009         LIKE glbc_t.glbc009   
DEFINE l_glaa001         LIKE glaa_t.glaa001   
   #計算主帳套本幣金額
   #151029-00012#7---mark-s
   #LET l_glbc009 = g_fmmy_m.fmmy007 * (g_fmmy_m.fmmy005 + g_fmmy_m.fmmy006)
   #IF cl_null(l_glbc009) THEN LET l_glbc009 = 0 END IF
   #SELECT glaa001 INTO l_glaa001
   #FROM glaa_t
   #WHERE glaaent = g_enterprise AND glaaent = g_glaald
   #CALL s_curr_round_ld('1',g_glaald,l_glaa001,l_glbc009,2) RETURNING g_sub_success,g_errno,l_glbc009
   #151029-00012#7---mark-e
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = g_glaald
   LET l_glbc.glbccomp  = g_fmmy_m.fmmysite
   LET l_glbc.glbcdocno = g_fmmy_m.fmmydocno
   LET l_glbc.glbcseq   = '0'
   LET l_glbc.glbcseq1  = '1'
   LET l_glbc.glbc001   = YEAR(g_fmmy_m.fmmydocdt)
   LET l_glbc.glbc002   = MONTH(g_fmmy_m.fmmydocdt)
   LET l_glbc.glbc003   = '1'
   LET l_glbc.glbc004   = g_fmmy_m.fmmy011 #現金變動碼
   LET l_glbc.glbc005   = ''               #付款對象
   LET l_glbc.glbc006   = g_fmmy_m.fmmy002
   LET l_glbc.glbc007   = g_fmmy_m.fmmy007
   LET l_glbc.glbc008   = g_fmmy_m.fmmy005 + g_fmmy_m.fmmy006
   LET l_glbc.glbc009   = g_fmmy_m.fmmy013 + g_fmmy_m.fmmy014   #151029-00012#7
   #LET l_glbc.glbc009   = l_glbc009                            #151029-00012#7 mark
   LET l_glbc.glbc010   ='2'
   LET l_glbc.glbc011   ='0'
   LET l_glbc.glbc012   ='0'
   LET l_glbc.glbc013   ='0'
   LET l_glbc.glbc014   ='0'
   LET l_glbc.glbc015   = g_fmmy_m.fmmystus #151013-00016#6  
   
  #INSERT INTO glbc_t VALUES(l_glbc.*) #161104-00024#11 mark
   #161104-00024#11 --s add
   INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,
                      glbcseq1,glbc001,glbc002,glbc003,glbc004,
                      glbc005,glbc006,glbc007,glbc008,glbc009,
                      glbc010,glbc011,glbc012,glbc013,glbc014,
                      glbcud001,glbcud002,glbcud003,glbcud004,glbcud005,
                      glbcud006,glbcud007,glbcud008,glbcud009,glbcud010,
                      glbcud011,glbcud012,glbcud013,glbcud014,glbcud015,
                      glbcud016,glbcud017,glbcud018,glbcud019,glbcud020,
                      glbcud021,glbcud022,glbcud023,glbcud024,glbcud025,
                      glbcud026,glbcud027,glbcud028,glbcud029,glbcud030,
                      glbc015)
   VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,
          l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
          l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,
          l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,
          l_glbc.glbcud001,l_glbc.glbcud002,l_glbc.glbcud003,l_glbc.glbcud004,l_glbc.glbcud005,
          l_glbc.glbcud006,l_glbc.glbcud007,l_glbc.glbcud008,l_glbc.glbcud009,l_glbc.glbcud010,
          l_glbc.glbcud011,l_glbc.glbcud012,l_glbc.glbcud013,l_glbc.glbcud014,l_glbc.glbcud015,
          l_glbc.glbcud016,l_glbc.glbcud017,l_glbc.glbcud018,l_glbc.glbcud019,l_glbc.glbcud020,
          l_glbc.glbcud021,l_glbc.glbcud022,l_glbc.glbcud023,l_glbc.glbcud024,l_glbc.glbcud025,
          l_glbc.glbcud026,l_glbc.glbcud027,l_glbc.glbcud028,l_glbc.glbcud029,l_glbc.glbcud030,
          l_glbc.glbc015)
   #161104-00024#11 --e add
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins glbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET g_success = 'N'                        
   END IF
END FUNCTION
################################################################################
# Descriptions...: 取消審核時刪除銀存收支
# Memo...........: #150820-00011#8
# Usage..........: CALL afmt590_nmbc_delete()
# Date & Author..: 150902 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_nmbc_delete()
 DELETE FROM nmbc_t
  WHERE nmbcent = g_enterprise AND nmbccomp = g_glaa.glaacomp
    AND nmbcdocno = g_fmmy_m.fmmydocno
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 取消審核時刪除現金變動碼明細資料
# Memo...........: #150820-00011#8
# Usage..........: CALL afmt590_glbc_delete()
# Date & Author..: 150902 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_glbc_delete()
   CALL s_cashflow_nm_del_glbc(g_fmmy_m.fmmydocdt,g_glaald,g_fmmy_m.fmmydocno,'') 
   RETURNING g_sub_success,g_errno  
END FUNCTION

################################################################################
# Descriptions...: "累計收息金額"頁籤
# Memo...........: #150820-00011#12
# Usage..........: CALL afmt590_b_fill3()
# Date & Author..: 2015/09/09 By Reanna
# Modify.........: 
################################################################################
PRIVATE FUNCTION afmt590_b_fill3(p_docno)
DEFINE p_docno   LIKE fmmj_t.fmmjdocno

DEFINE l_sql STRING
DEFINE l_idx         LIKE type_t.num10
DEFINE l_year        LIKE type_t.num10
DEFINE l_mon         LIKE type_t.num10
DEFINE l_date        LIKE type_t.num10
DEFINE l_fmmvdocno   LIKE fmmv_t.fmmvdocno
DEFINE l_date2       LIKE fmmv_t.fmmvdocdt
DEFINE l_fmmv002     LIKE fmmv_t.fmmv002
DEFINE l_fmmv003     LIKE fmmv_t.fmmv003
DEFINE l_fmmv005     LIKE fmmv_t.fmmv005
DEFINE l_glaa003     LIKE glaa_t.glaa003

   #LET l_year = YEAR(g_fmmv_m.fmmvdocdt)
   #LET l_mon  = MONTH(g_fmmv_m.fmmvdocdt)
   #LET l_date = l_year*12 + l_mon  #將日期轉換成 年*12+月
   #CALL s_ld_sel_glaa(g_glaa.glaald,'glaa003') RETURNING g_sub_success,l_glaa003
   #DELETE FROM afmt580_tmp
   #
   #計提
   LET l_sql = "SELECT fmmsdocno,fmms001,fmms002,fmmt005,fmmt006,fmmt010,0,fmmt014,0 ",   #151228-00008#1 add fmmt014,0
               "   FROM fmms_t,fmmt_t",
               "  WHERE fmmsent = fmmtent AND fmmtdocno = fmmsdocno",
               "    AND fmmsent = ",g_enterprise,
               "    AND fmmt002 = '",p_docno,"'",
               "    AND fmmsstus = 'Y'"
   PREPARE sel_fmmsp1 FROM l_sql
   DECLARE sel_fmmsc1 CURSOR FOR sel_fmmsp1
   CALL g_memo_afmt5902.clear()
   LET l_idx = 1
   FOREACH sel_fmmsc1 INTO g_memo_afmt5902[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:fmms_t'
         CALL cl_err()
      END IF
      
      #累計計提金額
      IF l_idx = 1 THEN
         LET g_memo_afmt5902[l_idx].l_fmmt0102 = g_memo_afmt5902[l_idx].l_fmmt0101
         LET g_memo_afmt5902[l_idx].l_fmmt0142 = g_memo_afmt5902[l_idx].l_fmmt0141   #151228-00008#1
      ELSE
         #151228-00008#1(S)
         #LET g_memo_afmt5902[l_idx].l_fmmt0102 = g_memo_afmt5902[l_idx].l_fmmt0102 + g_memo_afmt5902[l_idx-1].l_fmmt0101
         LET g_memo_afmt5902[l_idx].l_fmmt0102 = g_memo_afmt5902[l_idx-1].l_fmmt0102 + g_memo_afmt5902[l_idx].l_fmmt0101
         LET g_memo_afmt5902[l_idx].l_fmmt0142 = g_memo_afmt5902[l_idx-1].l_fmmt0142 + g_memo_afmt5902[l_idx].l_fmmt0141
         #151228-00008#1(E)
      END IF
      LET l_idx = l_idx + 1
   END FOREACH
   CALL g_memo_afmt5902.deleteElement(g_memo_afmt5902.getLength())
   
   DISPLAY ARRAY g_memo_afmt5902 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION
################################################################################
# Descriptions...: 取得最後一期利息
# Date & Author..: 2015/09/10 By Belle(150702-00003#4)
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_get_interest()
DEFINE l_fmmjdocdt      LIKE fmmj_t.fmmjdocdt
DEFINE l_fmmj005        LIKE fmmj_t.fmmj005
DEFINE l_fmmj006        LIKE fmmj_t.fmmj006
DEFINE l_fmmj017        LIKE fmmj_t.fmmj017
DEFINE l_fmmj018        LIKE fmmj_t.fmmj018
DEFINE l_fmmj022        LIKE fmmj_t.fmmj022
DEFINE l_fmmv005        LIKE fmmv_t.fmmv005
DEFINE l_interest_sum   LIKE fmmy_t.fmmy003  #全部利息
DEFINE l_interest_part  LIKE fmmy_t.fmmy003  #部分利息
DEFINE l_days           LIKE type_t.num5     #實際占用天數
DEFINE l_glaald         LIKE glaa_t.glaald
DEFINE l_ooef017        LIKE ooef_t.ooef017
DEFINE l_fmmv014        LIKE fmmv_t.fmmv014  ##151105-00008#5

   #afmt590帶最後一期利息收入的預設值，邏輯如下：
   #最後一期利息=全部應收到利息收入-已收到利息收入
   #  全部應收到利息收入=總面值fmmj017/購買數量fmmj005*出售數量fmmy003 *票面年利率fmmj018/計算天數fmmj022*實際佔用天數
   #  實際佔用天數=平倉日fmmydocdt-購買日期fmmjdocdt
   #  已收到利息收入=SUM(fmmv005)/購買數量fmmj005*出售數量fmmy003
   IF cl_null(g_fmmy_m.fmmy001) OR cl_null(g_fmmy_m.fmmy003) OR cl_null(g_fmmy_m.fmmydocdt) THEN
      RETURN
   END IF
  
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_fmmy_m.fmmysite
   CALL s_fin_get_major_ld(l_ooef017) RETURNING l_glaald
   
   SELECT fmmj005,fmmj006,fmmj017,fmmj018,fmmj022,
          fmmjdocdt
     INTO l_fmmj005,l_fmmj006,l_fmmj017,l_fmmj018,l_fmmj022,
          l_fmmjdocdt
     FROM fmmj_t
    WHERE fmmjent = g_enterprise AND fmmjdocno = g_fmmy_m.fmmy001
   
   #全部應收到利息收入=總面值fmmj017/購買數量fmmj005*出售數量fmmy003 *票面年利率fmmj018/計算天數fmmj022*實際佔用天數
   LET l_days = g_fmmy_m.fmmydocdt - l_fmmjdocdt      #實際佔用天數(平倉日fmmydocdt-購買日期fmmjdocdt)
   LET l_interest_sum = l_fmmj017 / l_fmmj005 * g_fmmy_m.fmmy003 * (l_fmmj018/100) / l_fmmj022 * l_days
   CALL s_curr_round_ld(1,l_glaald,l_fmmj006,l_interest_sum,2) RETURNING g_sub_success,g_errno,l_interest_sum
   #收息的币别在收息单没控卡与购买的币别一致。当初规划是在套期保值业务里处理这种不一致的状况。所以这时就当币别一致好了
   SELECT SUM(fmmv005) ,
          SUM(fmmv014)       #151105-00008#5
     INTO l_fmmv005,
          l_fmmv014          #151105-00008#5         
     FROM fmmv_t
    WHERE fmmvent = g_enterprise AND fmmv001 = g_fmmy_m.fmmy001
      AND fmmvdocdt <= g_fmmy_m.fmmydocdt AND fmmvstus = 'Y' 
   IF cl_null(l_fmmv005) THEN LET l_fmmv005 = 0 END IF
   LET l_interest_part = l_fmmv005/l_fmmj005*g_fmmy_m.fmmy003
   IF cl_null(l_interest_part) THEN LET l_interest_part = 0 END IF
                                           #已收到利息收入=SUM(fmmv005)/購買數量fmmj005*出售數量fmmy003
   #151105-00008#5-----s
   #LET g_fmmy_m.fmmy022 = l_fmmv014/l_fmmj005*g_fmmy_m.fmmy003   #albireo 151113 mark
   #IF cl_null(g_fmmy_m.fmmy022) THEN LET g_fmmy_m.fmmy022 = 0 END IF
   #CALL s_curr_round_ld(1,l_glaald,g_glaa.glaa001,g_fmmy_m.fmmy022,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy022
   #LET g_fmmy_m.fmmy021 = l_interest_part
   #CALL s_curr_round_ld(1,l_glaald,l_fmmj006,g_fmmy_m.fmmy021,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy021
   #151105-00008#5-----e
   LET g_fmmy_m.fmmy006 = l_interest_sum - l_interest_part 
   CALL s_curr_round_ld(1,l_glaald,l_fmmj006,g_fmmy_m.fmmy006,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy006
   
   #151029-00012#7---s
   IF NOT cl_null(g_fmmy_m.fmmy006) THEN
      LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy007
      CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
   END IF
   #151029-00012#7---e
   
   IF g_fmmy_m.fmmy006 < 0 THEN
      LET g_fmmy_m.fmmy006 = 0
      LET g_fmmy_m.fmmy014 = 0 #151029-00012#7
   END IF
   DISPLAY BY NAME g_fmmy_m.fmmy006,g_fmmy_m.fmmy014 #151029-00012#7 add fmmy014
END FUNCTION

################################################################################
# Descriptions...: 費用維護有維護費用項目,單據確認時一併寫入nmbc_t
# Memo...........: #150924-00006#4
# Usage..........: CALL afmt590_01_nmbc_insert()
# Date & Author..: 150925 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_01_nmbc_insert()
#DEFINE l_nmbc   RECORD   LIKE nmbc_t.* #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbcud001 LIKE nmbc_t.nmbcud001, #自定義欄位(文字)001
       nmbcud002 LIKE nmbc_t.nmbcud002, #自定義欄位(文字)002
       nmbcud003 LIKE nmbc_t.nmbcud003, #自定義欄位(文字)003
       nmbcud004 LIKE nmbc_t.nmbcud004, #自定義欄位(文字)004
       nmbcud005 LIKE nmbc_t.nmbcud005, #自定義欄位(文字)005
       nmbcud006 LIKE nmbc_t.nmbcud006, #自定義欄位(文字)006
       nmbcud007 LIKE nmbc_t.nmbcud007, #自定義欄位(文字)007
       nmbcud008 LIKE nmbc_t.nmbcud008, #自定義欄位(文字)008
       nmbcud009 LIKE nmbc_t.nmbcud009, #自定義欄位(文字)009
       nmbcud010 LIKE nmbc_t.nmbcud010, #自定義欄位(文字)010
       nmbcud011 LIKE nmbc_t.nmbcud011, #自定義欄位(數字)011
       nmbcud012 LIKE nmbc_t.nmbcud012, #自定義欄位(數字)012
       nmbcud013 LIKE nmbc_t.nmbcud013, #自定義欄位(數字)013
       nmbcud014 LIKE nmbc_t.nmbcud014, #自定義欄位(數字)014
       nmbcud015 LIKE nmbc_t.nmbcud015, #自定義欄位(數字)015
       nmbcud016 LIKE nmbc_t.nmbcud016, #自定義欄位(數字)016
       nmbcud017 LIKE nmbc_t.nmbcud017, #自定義欄位(數字)017
       nmbcud018 LIKE nmbc_t.nmbcud018, #自定義欄位(數字)018
       nmbcud019 LIKE nmbc_t.nmbcud019, #自定義欄位(數字)019
       nmbcud020 LIKE nmbc_t.nmbcud020, #自定義欄位(數字)020
       nmbcud021 LIKE nmbc_t.nmbcud021, #自定義欄位(日期時間)021
       nmbcud022 LIKE nmbc_t.nmbcud022, #自定義欄位(日期時間)022
       nmbcud023 LIKE nmbc_t.nmbcud023, #自定義欄位(日期時間)023
       nmbcud024 LIKE nmbc_t.nmbcud024, #自定義欄位(日期時間)024
       nmbcud025 LIKE nmbc_t.nmbcud025, #自定義欄位(日期時間)025
       nmbcud026 LIKE nmbc_t.nmbcud026, #自定義欄位(日期時間)026
       nmbcud027 LIKE nmbc_t.nmbcud027, #自定義欄位(日期時間)027
       nmbcud028 LIKE nmbc_t.nmbcud028, #自定義欄位(日期時間)028
       nmbcud029 LIKE nmbc_t.nmbcud029, #自定義欄位(日期時間)029
       nmbcud030 LIKE nmbc_t.nmbcud030, #自定義欄位(日期時間)030
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
END RECORD
#161104-00024#11 --e add
#DEFINE l_fmmz   RECORD   LIKE fmmz_t.* #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_fmmz RECORD  #平倉出售費用檔
       fmmzent LIKE fmmz_t.fmmzent, #企業編號
       fmmzownid LIKE fmmz_t.fmmzownid, #資料所有者
       fmmzowndp LIKE fmmz_t.fmmzowndp, #資料所屬部門
       fmmzcrtid LIKE fmmz_t.fmmzcrtid, #資料建立者
       fmmzcrtdp LIKE fmmz_t.fmmzcrtdp, #資料建立部門
       fmmzcrtdt LIKE fmmz_t.fmmzcrtdt, #資料創建日
       fmmzmodid LIKE fmmz_t.fmmzmodid, #資料修改者
       fmmzmoddt LIKE fmmz_t.fmmzmoddt, #最近修改日
       fmmzcnfid LIKE fmmz_t.fmmzcnfid, #資料確認者
       fmmzcnfdt LIKE fmmz_t.fmmzcnfdt, #資料確認日
       fmmzpstid LIKE fmmz_t.fmmzpstid, #資料過帳者
       fmmzpstdt LIKE fmmz_t.fmmzpstdt, #資料過帳日
       fmmzstus LIKE fmmz_t.fmmzstus, #狀態碼
       fmmzdocno LIKE fmmz_t.fmmzdocno, #單號
       fmmzseq LIKE fmmz_t.fmmzseq, #項次
       fmmz001 LIKE fmmz_t.fmmz001, #費用類型
       fmmz002 LIKE fmmz_t.fmmz002, #幣別
       fmmz003 LIKE fmmz_t.fmmz003, #金額
       fmmz004 LIKE fmmz_t.fmmz004, #匯率
       fmmz005 LIKE fmmz_t.fmmz005, #使用市場資金帳戶
       fmmz006 LIKE fmmz_t.fmmz006, #銀行收支單號
       fmmz007 LIKE fmmz_t.fmmz007, #收支單項次
       fmmzud001 LIKE fmmz_t.fmmzud001, #自定義欄位(文字)001
       fmmzud002 LIKE fmmz_t.fmmzud002, #自定義欄位(文字)002
       fmmzud003 LIKE fmmz_t.fmmzud003, #自定義欄位(文字)003
       fmmzud004 LIKE fmmz_t.fmmzud004, #自定義欄位(文字)004
       fmmzud005 LIKE fmmz_t.fmmzud005, #自定義欄位(文字)005
       fmmzud006 LIKE fmmz_t.fmmzud006, #自定義欄位(文字)006
       fmmzud007 LIKE fmmz_t.fmmzud007, #自定義欄位(文字)007
       fmmzud008 LIKE fmmz_t.fmmzud008, #自定義欄位(文字)008
       fmmzud009 LIKE fmmz_t.fmmzud009, #自定義欄位(文字)009
       fmmzud010 LIKE fmmz_t.fmmzud010, #自定義欄位(文字)010
       fmmzud011 LIKE fmmz_t.fmmzud011, #自定義欄位(數字)011
       fmmzud012 LIKE fmmz_t.fmmzud012, #自定義欄位(數字)012
       fmmzud013 LIKE fmmz_t.fmmzud013, #自定義欄位(數字)013
       fmmzud014 LIKE fmmz_t.fmmzud014, #自定義欄位(數字)014
       fmmzud015 LIKE fmmz_t.fmmzud015, #自定義欄位(數字)015
       fmmzud016 LIKE fmmz_t.fmmzud016, #自定義欄位(數字)016
       fmmzud017 LIKE fmmz_t.fmmzud017, #自定義欄位(數字)017
       fmmzud018 LIKE fmmz_t.fmmzud018, #自定義欄位(數字)018
       fmmzud019 LIKE fmmz_t.fmmzud019, #自定義欄位(數字)019
       fmmzud020 LIKE fmmz_t.fmmzud020, #自定義欄位(數字)020
       fmmzud021 LIKE fmmz_t.fmmzud021, #自定義欄位(日期時間)021
       fmmzud022 LIKE fmmz_t.fmmzud022, #自定義欄位(日期時間)022
       fmmzud023 LIKE fmmz_t.fmmzud023, #自定義欄位(日期時間)023
       fmmzud024 LIKE fmmz_t.fmmzud024, #自定義欄位(日期時間)024
       fmmzud025 LIKE fmmz_t.fmmzud025, #自定義欄位(日期時間)025
       fmmzud026 LIKE fmmz_t.fmmzud026, #自定義欄位(日期時間)026
       fmmzud027 LIKE fmmz_t.fmmzud027, #自定義欄位(日期時間)027
       fmmzud028 LIKE fmmz_t.fmmzud028, #自定義欄位(日期時間)028
       fmmzud029 LIKE fmmz_t.fmmzud029, #自定義欄位(日期時間)029
       fmmzud030 LIKE fmmz_t.fmmzud030, #自定義欄位(日期時間)030
       fmmz008 LIKE fmmz_t.fmmz008, #銀行帳戶
       fmmz009 LIKE fmmz_t.fmmz009, #現金變動碼
       fmmz010 LIKE fmmz_t.fmmz010, #存提碼
       fmmz011 LIKE fmmz_t.fmmz011  #本幣金額
END RECORD
#161104-00024#11 --e add
DEFINE l_nmbc113         LIKE nmbc_t.nmbc113    
DEFINE l_fmmj002         LIKE fmmj_t.fmmj002
DEFINE l_sql             STRING

   SELECT fmmj002 INTO l_fmmj002 FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmy_m.fmmy001

   LET l_sql = "SELECT * FROM fmmz_t",
               " WHERE fmmzent = '",g_enterprise,"'",
               "   AND fmmzdocno = '",g_fmmy_m.fmmydocno,"'",
               "   AND fmmz008 IS NOT NULL ",
               " ORDER BY fmmzseq "
   
   PREPARE afmt590_01_pre1 FROM l_sql
   DECLARE afmt590_01_cs1 CURSOR FOR afmt590_01_pre1
   
   FOREACH afmt590_01_cs1 INTO l_fmmz.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF

      #計算主帳套本幣金額
      #151029-00012#7---mark-s
      #LET l_nmbc113 = l_fmmz.fmmz003 * l_fmmz.fmmz004
      #IF cl_null(l_nmbc113) THEN LET l_nmbc113 = 0 END IF
      #CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,l_nmbc113,2) RETURNING g_sub_success,g_errno,l_nmbc113
      #151029-00012#7---mark-e
      
      LET l_nmbc.nmbcent   =  g_enterprise      
      LET l_nmbc.nmbccomp  =  g_glaa.glaacomp
      LET l_nmbc.nmbcsite  =  g_fmmy_m.fmmysite 
      LET l_nmbc.nmbcdocno =  l_fmmz.fmmzdocno 
      #LET l_nmbc.nmbcseq   =  l_fmmz.fmmzseq    #151117-00001#4 mark
      
      #151117-00001#4-----s
      SELECT MAX(nmbcseq)+1 INTO l_nmbc.nmbcseq FROM nmbc_t
       WHERE nmbcent = g_enterprise
         AND nmbccomp = l_nmbc.nmbccomp
         AND nmbcsite = l_nmbc.nmbcsite
         AND nmbcdocno = l_nmbc.nmbcdocno
      IF cl_null(l_nmbc.nmbcseq) OR l_nmbc.nmbcseq < 11 THEN
         LET l_nmbc.nmbcseq = 11
      END IF      
      #151117-00001#4------e
      
      #LET l_nmbc.nmbc001   =  'afmt590_01'    #151117-00001#4 mark
      LET l_nmbc.nmbc001 = 'afmt590'           #151117-00001#4 add
      LET l_nmbc.nmbc002   =  l_fmmz.fmmz008
      LET l_nmbc.nmbc003   =  l_fmmj002
      LET l_nmbc.nmbc004   =  ''
      LET l_nmbc.nmbc005   =  g_fmmy_m.fmmydocdt 
      LET l_nmbc.nmbc006   =  '2'
      LET l_nmbc.nmbc007   =  l_fmmz.fmmz010
      LET l_nmbc.nmbc008   =  '' 
      LET l_nmbc.nmbc009   =  '' 
      LET l_nmbc.nmbc010   =  '' 
      LET l_nmbc.nmbc011   =  '' 
      LET l_nmbc.nmbc012   =  '' 
      LET l_nmbc.nmbc013   =  '' 
      LET l_nmbc.nmbc014   =  ''              #151012-00014#6
      LET l_nmbc.nmbc015   =  ''              #151012-00014#6
      LET l_nmbc.nmbc016   =  ''              #151012-00014#6
      LET l_nmbc.nmbc100   =  l_fmmz.fmmz002
      LET l_nmbc.nmbc101   =  l_fmmz.fmmz004
      LET l_nmbc.nmbc103   =  l_fmmz.fmmz003
      LET l_nmbc.nmbc113   =  l_fmmz.fmmz011  #151029-00012#7
      #LET l_nmbc.nmbc113   =  l_nmbc113      #151029-00012#7 mark
      LET l_nmbc.nmbc121   =  '0' 
      LET l_nmbc.nmbc123   =  '0'
      LET l_nmbc.nmbc131   =  '0'
      LET l_nmbc.nmbc133   =  '0'   
      LET l_nmbc.nmbcownid =  g_user
      LET l_nmbc.nmbcowndp =  g_dept
      LET l_nmbc.nmbccrtid =  g_user
      LET l_nmbc.nmbccrtdp =  g_dept 
      LET l_nmbc.nmbccrtdt =  cl_get_current()
      LET l_nmbc.nmbcorga  = g_fmmy_m.fmmysite  #160322-00025#20 add
      
     #INSERT INTO nmbc_t VALUES(l_nmbc.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                         nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                         nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                         nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                         nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                         nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                         nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                         nmbc133,nmbcud001,nmbcud002,nmbcud003,nmbcud004,
                         nmbcud005,nmbcud006,nmbcud007,nmbcud008,nmbcud009,
                         nmbcud010,nmbcud011,nmbcud012,nmbcud013,nmbcud014,
                         nmbcud015,nmbcud016,nmbcud017,nmbcud018,nmbcud019,
                         nmbcud020,nmbcud021,nmbcud022,nmbcud023,nmbcud024,
                         nmbcud025,nmbcud026,nmbcud027,nmbcud028,nmbcud029,
                         nmbcud030,nmbc012,nmbc013,nmbc014,nmbc015,
                         nmbc016,nmbc017,nmbcorga)
      VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
             l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,
             l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,
             l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,
             l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,
             l_nmbc.nmbc009,l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,
             l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,
             l_nmbc.nmbc133,l_nmbc.nmbcud001,l_nmbc.nmbcud002,l_nmbc.nmbcud003,l_nmbc.nmbcud004,
             l_nmbc.nmbcud005,l_nmbc.nmbcud006,l_nmbc.nmbcud007,l_nmbc.nmbcud008,l_nmbc.nmbcud009,
             l_nmbc.nmbcud010,l_nmbc.nmbcud011,l_nmbc.nmbcud012,l_nmbc.nmbcud013,l_nmbc.nmbcud014,
             l_nmbc.nmbcud015,l_nmbc.nmbcud016,l_nmbc.nmbcud017,l_nmbc.nmbcud018,l_nmbc.nmbcud019,
             l_nmbc.nmbcud020,l_nmbc.nmbcud021,l_nmbc.nmbcud022,l_nmbc.nmbcud023,l_nmbc.nmbcud024,
             l_nmbc.nmbcud025,l_nmbc.nmbcud026,l_nmbc.nmbcud027,l_nmbc.nmbcud028,l_nmbc.nmbcud029,
             l_nmbc.nmbcud030,l_nmbc.nmbc012,l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,
             l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
      #161104-00024#11 --e add
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins01 nmbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET g_success = 'N'                        
      END IF
   END FOREACH   
   
END FUNCTION

################################################################################
# Descriptions...: 費用維護有維護費用項目,單據確認時一併寫入glbc_t
# Memo...........: #150924-00006#4
# Usage..........: CALL afmt590_01_glbc_insert()
# Date & Author..: 150925 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_01_glbc_insert()
#DEFINE l_glbc   RECORD   LIKE glbc_t.*  #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企業編號
       glbcld LIKE glbc_t.glbcld, #帳套
       glbccomp LIKE glbc_t.glbccomp, #營運據點
       glbcdocno LIKE glbc_t.glbcdocno, #傳票編號
       glbcseq LIKE glbc_t.glbcseq, #項次
       glbcseq1 LIKE glbc_t.glbcseq1, #序號
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期別
       glbc003 LIKE glbc_t.glbc003, #借貸別
       glbc004 LIKE glbc_t.glbc004, #現金變動碼
       glbc005 LIKE glbc_t.glbc005, #交易客商
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbcud001 LIKE glbc_t.glbcud001, #自定義欄位(文字)001
       glbcud002 LIKE glbc_t.glbcud002, #自定義欄位(文字)002
       glbcud003 LIKE glbc_t.glbcud003, #自定義欄位(文字)003
       glbcud004 LIKE glbc_t.glbcud004, #自定義欄位(文字)004
       glbcud005 LIKE glbc_t.glbcud005, #自定義欄位(文字)005
       glbcud006 LIKE glbc_t.glbcud006, #自定義欄位(文字)006
       glbcud007 LIKE glbc_t.glbcud007, #自定義欄位(文字)007
       glbcud008 LIKE glbc_t.glbcud008, #自定義欄位(文字)008
       glbcud009 LIKE glbc_t.glbcud009, #自定義欄位(文字)009
       glbcud010 LIKE glbc_t.glbcud010, #自定義欄位(文字)010
       glbcud011 LIKE glbc_t.glbcud011, #自定義欄位(數字)011
       glbcud012 LIKE glbc_t.glbcud012, #自定義欄位(數字)012
       glbcud013 LIKE glbc_t.glbcud013, #自定義欄位(數字)013
       glbcud014 LIKE glbc_t.glbcud014, #自定義欄位(數字)014
       glbcud015 LIKE glbc_t.glbcud015, #自定義欄位(數字)015
       glbcud016 LIKE glbc_t.glbcud016, #自定義欄位(數字)016
       glbcud017 LIKE glbc_t.glbcud017, #自定義欄位(數字)017
       glbcud018 LIKE glbc_t.glbcud018, #自定義欄位(數字)018
       glbcud019 LIKE glbc_t.glbcud019, #自定義欄位(數字)019
       glbcud020 LIKE glbc_t.glbcud020, #自定義欄位(數字)020
       glbcud021 LIKE glbc_t.glbcud021, #自定義欄位(日期時間)021
       glbcud022 LIKE glbc_t.glbcud022, #自定義欄位(日期時間)022
       glbcud023 LIKE glbc_t.glbcud023, #自定義欄位(日期時間)023
       glbcud024 LIKE glbc_t.glbcud024, #自定義欄位(日期時間)024
       glbcud025 LIKE glbc_t.glbcud025, #自定義欄位(日期時間)025
       glbcud026 LIKE glbc_t.glbcud026, #自定義欄位(日期時間)026
       glbcud027 LIKE glbc_t.glbcud027, #自定義欄位(日期時間)027
       glbcud028 LIKE glbc_t.glbcud028, #自定義欄位(日期時間)028
       glbcud029 LIKE glbc_t.glbcud029, #自定義欄位(日期時間)029
       glbcud030 LIKE glbc_t.glbcud030, #自定義欄位(日期時間)030
       glbc015 LIKE glbc_t.glbc015  #狀態碼
END RECORD
#161104-00024#11 --e add
DEFINE l_glbc009         LIKE glbc_t.glbc009 
DEFINE l_fmmj002         LIKE fmmj_t.fmmj002
DEFINE l_sql             STRING
#DEFINE l_fmmz   RECORD   LIKE fmmz_t.* #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE l_fmmz RECORD  #平倉出售費用檔
       fmmzent LIKE fmmz_t.fmmzent, #企業編號
       fmmzownid LIKE fmmz_t.fmmzownid, #資料所有者
       fmmzowndp LIKE fmmz_t.fmmzowndp, #資料所屬部門
       fmmzcrtid LIKE fmmz_t.fmmzcrtid, #資料建立者
       fmmzcrtdp LIKE fmmz_t.fmmzcrtdp, #資料建立部門
       fmmzcrtdt LIKE fmmz_t.fmmzcrtdt, #資料創建日
       fmmzmodid LIKE fmmz_t.fmmzmodid, #資料修改者
       fmmzmoddt LIKE fmmz_t.fmmzmoddt, #最近修改日
       fmmzcnfid LIKE fmmz_t.fmmzcnfid, #資料確認者
       fmmzcnfdt LIKE fmmz_t.fmmzcnfdt, #資料確認日
       fmmzpstid LIKE fmmz_t.fmmzpstid, #資料過帳者
       fmmzpstdt LIKE fmmz_t.fmmzpstdt, #資料過帳日
       fmmzstus LIKE fmmz_t.fmmzstus, #狀態碼
       fmmzdocno LIKE fmmz_t.fmmzdocno, #單號
       fmmzseq LIKE fmmz_t.fmmzseq, #項次
       fmmz001 LIKE fmmz_t.fmmz001, #費用類型
       fmmz002 LIKE fmmz_t.fmmz002, #幣別
       fmmz003 LIKE fmmz_t.fmmz003, #金額
       fmmz004 LIKE fmmz_t.fmmz004, #匯率
       fmmz005 LIKE fmmz_t.fmmz005, #使用市場資金帳戶
       fmmz006 LIKE fmmz_t.fmmz006, #銀行收支單號
       fmmz007 LIKE fmmz_t.fmmz007, #收支單項次
       fmmzud001 LIKE fmmz_t.fmmzud001, #自定義欄位(文字)001
       fmmzud002 LIKE fmmz_t.fmmzud002, #自定義欄位(文字)002
       fmmzud003 LIKE fmmz_t.fmmzud003, #自定義欄位(文字)003
       fmmzud004 LIKE fmmz_t.fmmzud004, #自定義欄位(文字)004
       fmmzud005 LIKE fmmz_t.fmmzud005, #自定義欄位(文字)005
       fmmzud006 LIKE fmmz_t.fmmzud006, #自定義欄位(文字)006
       fmmzud007 LIKE fmmz_t.fmmzud007, #自定義欄位(文字)007
       fmmzud008 LIKE fmmz_t.fmmzud008, #自定義欄位(文字)008
       fmmzud009 LIKE fmmz_t.fmmzud009, #自定義欄位(文字)009
       fmmzud010 LIKE fmmz_t.fmmzud010, #自定義欄位(文字)010
       fmmzud011 LIKE fmmz_t.fmmzud011, #自定義欄位(數字)011
       fmmzud012 LIKE fmmz_t.fmmzud012, #自定義欄位(數字)012
       fmmzud013 LIKE fmmz_t.fmmzud013, #自定義欄位(數字)013
       fmmzud014 LIKE fmmz_t.fmmzud014, #自定義欄位(數字)014
       fmmzud015 LIKE fmmz_t.fmmzud015, #自定義欄位(數字)015
       fmmzud016 LIKE fmmz_t.fmmzud016, #自定義欄位(數字)016
       fmmzud017 LIKE fmmz_t.fmmzud017, #自定義欄位(數字)017
       fmmzud018 LIKE fmmz_t.fmmzud018, #自定義欄位(數字)018
       fmmzud019 LIKE fmmz_t.fmmzud019, #自定義欄位(數字)019
       fmmzud020 LIKE fmmz_t.fmmzud020, #自定義欄位(數字)020
       fmmzud021 LIKE fmmz_t.fmmzud021, #自定義欄位(日期時間)021
       fmmzud022 LIKE fmmz_t.fmmzud022, #自定義欄位(日期時間)022
       fmmzud023 LIKE fmmz_t.fmmzud023, #自定義欄位(日期時間)023
       fmmzud024 LIKE fmmz_t.fmmzud024, #自定義欄位(日期時間)024
       fmmzud025 LIKE fmmz_t.fmmzud025, #自定義欄位(日期時間)025
       fmmzud026 LIKE fmmz_t.fmmzud026, #自定義欄位(日期時間)026
       fmmzud027 LIKE fmmz_t.fmmzud027, #自定義欄位(日期時間)027
       fmmzud028 LIKE fmmz_t.fmmzud028, #自定義欄位(日期時間)028
       fmmzud029 LIKE fmmz_t.fmmzud029, #自定義欄位(日期時間)029
       fmmzud030 LIKE fmmz_t.fmmzud030, #自定義欄位(日期時間)030
       fmmz008 LIKE fmmz_t.fmmz008, #銀行帳戶
       fmmz009 LIKE fmmz_t.fmmz009, #現金變動碼
       fmmz010 LIKE fmmz_t.fmmz010, #存提碼
       fmmz011 LIKE fmmz_t.fmmz011  #本幣金額
END RECORD
#161104-00024#11 --e add

   SELECT fmmj002 INTO l_fmmj002 FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmy_m.fmmy001

   LET l_sql = "SELECT * FROM fmmz_t",
               " WHERE fmmzent = '",g_enterprise,"'",
               "   AND fmmzdocno = '",g_fmmy_m.fmmydocno,"'",
               "   AND fmmz008 IS NOT NULL ",
               " ORDER BY fmmzseq "
   
   PREPARE afmt590_01_pre2 FROM l_sql
   DECLARE afmt590_01_cs2 CURSOR FOR afmt590_01_pre2
   
   FOREACH afmt590_01_cs2 INTO l_fmmz.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF

      #計算主帳套本幣金額
      #151029-00012#7---mark-s
      #LET l_glbc009 = l_fmmz.fmmz003 * l_fmmz.fmmz004
      #IF cl_null(l_glbc009) THEN LET l_glbc009 = 0 END IF
      #CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,l_glbc009,2) RETURNING g_sub_success,g_errno,l_glbc009
      #151029-00012#7---mark-e
      
      LET l_glbc.glbcent   = g_enterprise
      LET l_glbc.glbcld    = g_glaald
      LET l_glbc.glbccomp  = g_glaa.glaacomp
      LET l_glbc.glbcdocno = l_fmmz.fmmzdocno
      LET l_glbc.glbcseq   = l_fmmz.fmmzseq
      LET l_glbc.glbcseq1  = '1'
      LET l_glbc.glbc001   = YEAR(g_fmmy_m.fmmydocdt)
      LET l_glbc.glbc002   = MONTH(g_fmmy_m.fmmydocdt)
      LET l_glbc.glbc003   = '1'
      LET l_glbc.glbc004   = l_fmmz.fmmz009   #現金變動碼
      LET l_glbc.glbc005   = l_fmmj002        #付款對象
      LET l_glbc.glbc006   = l_fmmz.fmmz002
      LET l_glbc.glbc007   = l_fmmz.fmmz004
      LET l_glbc.glbc008   = l_fmmz.fmmz003
      LET l_glbc.glbc009   = l_fmmz.fmmz011   #151029-00012#7
      #LET l_glbc.glbc009   = l_glbc009       #151029-00012#7 mark
      LET l_glbc.glbc010   = '2'
      LET l_glbc.glbc011   = '0'
      LET l_glbc.glbc012   = '0'
      LET l_glbc.glbc013   = '0'
      LET l_glbc.glbc014   = '0'
      LET l_glbc.glbc015   = g_fmmy_m.fmmystus #151013-00016#6
      
     #INSERT INTO glbc_t VALUES(l_glbc.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,
                         glbcseq1,glbc001,glbc002,glbc003,glbc004,
                         glbc005,glbc006,glbc007,glbc008,glbc009,
                         glbc010,glbc011,glbc012,glbc013,glbc014,
                         glbcud001,glbcud002,glbcud003,glbcud004,glbcud005,
                         glbcud006,glbcud007,glbcud008,glbcud009,glbcud010,
                         glbcud011,glbcud012,glbcud013,glbcud014,glbcud015,
                         glbcud016,glbcud017,glbcud018,glbcud019,glbcud020,
                         glbcud021,glbcud022,glbcud023,glbcud024,glbcud025,
                         glbcud026,glbcud027,glbcud028,glbcud029,glbcud030,
                         glbc015)
      VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,
             l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
             l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,
             l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,
             l_glbc.glbcud001,l_glbc.glbcud002,l_glbc.glbcud003,l_glbc.glbcud004,l_glbc.glbcud005,
             l_glbc.glbcud006,l_glbc.glbcud007,l_glbc.glbcud008,l_glbc.glbcud009,l_glbc.glbcud010,
             l_glbc.glbcud011,l_glbc.glbcud012,l_glbc.glbcud013,l_glbc.glbcud014,l_glbc.glbcud015,
             l_glbc.glbcud016,l_glbc.glbcud017,l_glbc.glbcud018,l_glbc.glbcud019,l_glbc.glbcud020,
             l_glbc.glbcud021,l_glbc.glbcud022,l_glbc.glbcud023,l_glbc.glbcud024,l_glbc.glbcud025,
             l_glbc.glbcud026,l_glbc.glbcud027,l_glbc.glbcud028,l_glbc.glbcud029,l_glbc.glbcud030,
             l_glbc.glbc015)
      #161104-00024#11 --e add
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins01 glbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET g_success = 'N'                        
      END IF
   END FOREACH
   
END FUNCTION

PRIVATE FUNCTION afmt590_account_fomula(p_fomula)
   DEFINE p_fomula   LIKE type_t.chr10
   DEFINE l_fmmj     RECORD
                     fmmj007    LIKE fmmj_t.fmmj007,
                     fmmj009    LIKE fmmj_t.fmmj009,
                     fmmjdocno  LIKE fmmj_t.fmmjdocno,
                     fmmj005    LIKE fmmj_t.fmmj005   #151105-00008#5 add
                     END RECORD
   DEFINE l_fmmz     RECORD
                     fmmz002    LIKE fmmz_t.fmmz002,
                     fmmz003    LIKE fmmz_t.fmmz003,
                     fmmz011    LIKE fmmz_t.fmmz011
                     END RECORD
   DEFINE l_fmmk     RECORD
                     fmmk004    LIKE fmmk_t.fmmk004,
                     fmmk005    LIKE fmmk_t.fmmk005,
                     fmmk013    LIKE fmmk_t.fmmk013
                     END RECORD                     
   DEFINE l_sum10x   LIKE type_t.num20_6
   DEFINE l_sql      STRING
   DEFINE l_10x      LIKE type_t.num20_6
   DEFINE l_rate     LIKE type_t.num20_6
   DEFINE l_fmma003  LIKE fmma_t.fmma003
   DEFINE l_sum11x   LIKE type_t.num20_6
   
   #151103 albireo memo-----s
   #carol 收益原幣異動時 不推本幣
   #      因分錄會不平
   #151103             -----e
   
   INITIALIZE l_fmmj.* TO NULL
   SELECT fmmj007,fmmj009,fmmjdocno,
          fmmj005     #151105-00008#5
     INTO l_fmmj.*
     FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmy_m.fmmy001
   IF cl_null(l_fmmj.fmmj007)THEN LET l_fmmj.fmmj007 = 0  END IF
   IF cl_null(l_fmmj.fmmj009)THEN LET l_fmmj.fmmj009 = 0  END IF
      
   #151105-00008#5-----s
   LET l_fmma003 = NULL
   SELECT fmma003 INTO l_fmma003 FROM fmma_t
    WHERE fmmaent = g_enterprise
      AND fmma001 = g_fmmy_m.l_fmmy001_3
   LET l_sum10x = 0
   LET l_sum11x = 0
   IF l_fmma003 = '1' THEN   #費用納入成本

      LET l_sql　= "SELECT fmmk004,SUM(fmmk005),SUM(fmmk013) FROM fmmk_t ",
                   " WHERE fmmkent = ",g_enterprise," ",
                   "   AND fmmk001 = '",g_fmmy_m.fmmy001,"' ",
                   " GROUP BY fmmk004"
                   
      PREPARE sel_fmmkp13 FROM l_sql
      DECLARE sel_fmmkc13 CURSOR FOR sel_fmmkp13
      FOREACH sel_fmmkc13 INTO l_fmmk.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         
         #fmmk004幣別轉成fmmy002幣別
         #取今日匯率
         CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,l_fmmk.fmmk004,g_fmmy_m.fmmy002,0,g_glaa.glaa025)
                       RETURNING l_rate
         IF cl_null(l_rate)THEN LET l_rate = 0 END IF
         LET l_10x = l_fmmk.fmmk005 * l_rate
         #fmmy002取位 
         LET l_sum11x = l_sum11x + l_fmmk.fmmk013
         LET l_sum10x = l_sum10x + l_10x
      END FOREACH
      LET l_sum11x = l_sum11x * g_fmmy_m.fmmy003/l_fmmj.fmmj005
      LET l_sum10x = l_sum10x * g_fmmy_m.fmmy003/l_fmmj.fmmj005
      CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,l_sum10x,2) RETURNING g_sub_success,g_errno,l_sum10x
      CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,l_sum11x,2) RETURNING g_sub_success,g_errno,l_sum11x
         
      
      
      
   END IF
   #151105-00008#5-----e 
   
   
   
   CASE
      WHEN p_fomula = 'A1'
         #平倉數*單價=平倉收入原幣
         LET g_fmmy_m.fmmy005 = g_fmmy_m.fmmy004 * g_fmmy_m.fmmy003

#         IF l_fmma003 = '1' THEN   #費用納入成本
#            LET l_sum10x = 0
#            LET l_sql　= "SELECT fmmk004,SUM(fmmk005),SUM(fmmk013) FROM fmmk_t ",
#                         " WHERE fmmkent = ",g_enterprise," ",
#                         "   AND fmmk001 = '",g_fmmy_m.fmmy001,"' ",
#                         " GROUP BY fmmk004"
#            PREPARE sel_fmmkp1 FROM l_sql
#            DECLARE sel_fmmkc1 CURSOR FOR sel_fmmkp1  
#            FOREACH sel_fmmkc1 INTO l_fmmk.*
#               IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
#               
#               #fmmk004幣別轉成fmmy002幣別
#               #取今日匯率
#               CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,l_fmmk.fmmk004,g_fmmy_m.fmmy002,0,g_glaa.glaa025)
#                             RETURNING l_rate
#               IF cl_null(l_rate)THEN LET l_rate = 0 END IF
#               LET l_10x = l_fmmk.fmmk005 * l_rate
#               #fmmy002取位 
#               
#               LET l_sum10x = l_sum10x + l_10x
#            END FOREACH
#            CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,l_sum10x,2) RETURNING g_sub_success,g_errno,l_sum10x
#            LET g_fmmy_m.fmmy005 = g_fmmy_m.fmmy005 - l_sum10x
#         END IF
#         
         
         DISPLAY BY NAME g_fmmy_m.fmmy005
         
      WHEN p_fomula = 'A2'
         #平倉收入原幣*匯率=平倉收入本幣
         LET g_fmmy_m.fmmy013 = g_fmmy_m.fmmy005 * g_fmmy_m.fmmy007
         
         #主帳別本幣取位
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy013,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy013
         DISPLAY BY NAME g_fmmy_m.fmmy013
         
      WHEN p_fomula = 'B2'
         #利息收入原幣*利息匯率=利息收入本幣
         LET g_fmmy_m.fmmy029 = g_fmmy_m.fmmy028 * g_fmmy_m.fmmy019
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy029,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy029
         DISPLAY BY NAME g_fmmy_m.fmmy029
         
      WHEN p_fomula = 'C1'
         #平倉數*購買時單價 = 出售成本原幣
         LET g_fmmy_m.fmmy015 = l_fmmj.fmmj007 * g_fmmy_m.fmmy003               
         LET g_fmmy_m.fmmy015 = g_fmmy_m.fmmy015 + l_sum10x
 
         DISPLAY BY NAME g_fmmy_m.fmmy015
      WHEN p_fomula = 'C2'
         #出售成本原幣 * 購買時匯率 = 出售成本本幣
         LET g_fmmy_m.fmmy016 = g_fmmy_m.fmmy015 * l_fmmj.fmmj009
          LET g_fmmy_m.fmmy016 = g_fmmy_m.fmmy016 + l_sum11x
         #主帳別本幣取位
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy016,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy016
         DISPLAY BY NAME g_fmmy_m.fmmy016
         
         
      WHEN p_fomula = 'D'
          
         #160218-00010#1-----s
         LET g_fmmy_m.fmmy020 = g_fmmy_m.fmmy013-g_fmmy_m.fmmy016-g_fmmy_m.fmmy018
         DISPLAY BY NAME g_fmmy_m.fmmy020 
         #160218-00010#1-----e
      
         #151105-00008#5-----s
          # kris modify 
          
          #160218-00010#1 mark-----s
#          #出售成本原幣 * (平倉匯率-購買匯率) = 匯差
#          LET g_fmmy_m.fmmy020 = g_fmmy_m.fmmy015 * (g_fmmy_m.fmmy007-l_fmmj.fmmj009)
#          CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy020,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy020
#          DISPLAY BY NAME g_fmmy_m.fmmy020
          #160218-00010#1 mark-----e
          
#         #出售成本原幣 * (平倉匯率-購買匯率) = 匯差
#         LET g_fmmy_m.fmmy020 = g_fmmy_m.fmmy015 * (g_fmmy_m.fmmy007-l_fmmj.fmmj009)
#         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy020,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy020
#         DISPLAY BY NAME g_fmmy_m.fmmy020
        
         #(收入原幣-成本原幣)*(平倉匯率-購買匯率)
         #LET g_fmmy_m.fmmy020 = (g_fmmy_m.fmmy005-g_fmmy_m.fmmy015) * (g_fmmy_m.fmmy007-l_fmmj.fmmj009)  # kris modify 
         # CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy020,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy020
         # DISPLAY BY NAME g_fmmy_m.fmmy020
         #151105-00008#5-----e
         
         
      WHEN p_fomula = 'E1'
          #151105-00008#5-----s
#         #平倉收入原幣+利息收入原幣-平倉費用原幣(原幣轉原幣) -出售成本原幣
#        
#         #算平倉費用原幣(原幣轉原幣)
#         LET l_sum10x = 0
#         LET l_sql　= "SELECT fmmz002,SUM(fmmz003) FROM fmmz_t ",
#                      " WHERE fmmzent = ",g_enterprise," ",
#                      "   AND fmmzdocno = '",g_fmmy_m.fmmydocno,"' "
#         PREPARE sel_fmmzp1 FROM l_sql
#         DECLARE sel_fmmzc1 CURSOR FOR sel_fmmzp1
#         FOREACH sel_fmmzc1 INTO l_fmmz.*
#            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
#            
#            #fmmz002幣別轉成fmmy002幣別
#            #取今日匯率
#            CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,l_fmmz.fmmz002,g_fmmy_m.fmmy002,0,g_glaa.glaa025)
#                          RETURNING l_rate
#            IF cl_null(l_rate)THEN LET l_rate = 0 END IF
#            LET l_10x = l_fmmz.fmmz003 * l_rate
#            #fmmy002取位 
#            
#            LET l_sum10x = l_sum10x + l_10x
#         END FOREACH
#         CALL s_curr_round_ld('1',g_glaald,g_fmmy_m.fmmy002,l_sum10x,2) RETURNING g_sub_success,g_errno,l_sum10x
#                          
#         #平倉收入原幣+利息收入原幣-平倉費用原幣(原幣轉原幣) -出售成本原幣
#         LET g_fmmy_m.fmmy017 = g_fmmy_m.fmmy005 + g_fmmy_m.fmmy006 -l_sum10x - g_fmmy_m.fmmy015         
#         
#         DISPLAY BY NAME g_fmmy_m.fmmy017


          #平倉收益原幣
          #平倉收入原幣-出售費用原幣
          LET g_fmmy_m.fmmy017 = g_fmmy_m.fmmy005 - g_fmmy_m.fmmy015
          DISPLAY BY NAME g_fmmy_m.fmmy017
          #151105-00008#5-----e
      WHEN p_fomula = 'E2'
         #151105-00008#5-----s
#         #平倉收入本幣=平倉收入本幣+利息收入本幣-出售成本本幣-平倉費用本幣(子作業本幣和)
#         #先算本幣平倉費用
#         LET l_fmmz.fmmz011 = NULL
#         SELECT SUM(fmmz011) INTO l_fmmz.fmmz011 FROM fmmz_t
#          WHERE fmmzent = g_enterprise
#            AND fmmzdocno = g_fmmy_fmmydocno
#            
#         IF cl_null(l_fmmz.fmmz011)THEN LET l_fmmz.fmmz011= 0 END IF
#         
#         #平倉收入本幣=平倉收入本幣+利息收入本幣-出售成本本幣-平倉費用本幣(子作業本幣和)-投資匯差
#         LET g_fmmy_m.fmmy018 = g_fmmy_m.fmmy013 + g_fmmy_m.fmmy014 -l_fmmz.fmmz011 - g_fmmy_m.fmmy016 - g_fmmy_m.fmmy020
#         DISPLAY BY NAME g_fmmy_m.fmmy018

         #平倉收益本幣
         #平倉收益原幣*平倉匯率
         LET g_fmmy_m.fmmy018 = g_fmmy_m.fmmy017 * g_fmmy_m.fmmy007
         
         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy018,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy018   #albireo 160223 remark  改回用乘匯率應取位
         DISPLAY BY NAME g_fmmy_m.fmmy018
         #151105-00008#5-----e
         
      #151105-00008#5-----s
      WHEN p_fomula = 'F1'
         #利息匯差
         
         #151117-00001#4-----s
#         #(利息收入原幣+已計利息原幣)*利息匯率 - (利息收入本幣+已計利息本幣)
#         LET g_fmmy_m.fmmy023 = (g_fmmy_m.fmmy006+g_fmmy_m.fmmy021+g_fmmy_m.fmmy024+g_fmmy_m.fmmy025)*g_fmmy_m.fmmy019 - (g_fmmy_m.fmmy014+g_fmmy_m.fmmy022+g_fmmy_m.fmmy026+g_fmmy_m.fmmy027)
#         CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy023,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy023
#         DISPLAY BY NAME g_fmmy_m.fmmy023         
         
         #利息收入本幣-(已收利息本幣+已宣告未發放利息本幣+已宣告未發放股利本幣+最後一期利息本幣)
         LET g_fmmy_m.fmmy023 = g_fmmy_m.fmmy029 - (g_fmmy_m.fmmy022 + g_fmmy_m.fmmy026 + g_fmmy_m.fmmy027 + g_fmmy_m.fmmy014)
         #151117-00001#4-----e
      #151105-00008#5-----e      
      
      #151117-00001#4-----s
      WHEN p_fomula = 'G1'
          #最後一期利息原幣
          #利息收入原幣-(已收利息原幣+已收未發放股利原幣+已收未發放利息原幣)
          LET g_fmmy_m.fmmy006 = g_fmmy_m.fmmy028 - (g_fmmy_m.fmmy021 + g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025)

      WHEN p_fomula = 'G2'
          #最後一期利息本幣
          #最後一期利息原幣 * 利息匯率
          LET g_fmmy_m.fmmy014 = g_fmmy_m.fmmy006 * g_fmmy_m.fmmy019 
          CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_fmmy_m.fmmy014,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy014
          
      WHEN p_fomula = 'H1'
          #利息收入原幣
          LET g_fmmy_m.fmmy028 =  g_fmmy_m.fmmy006 + g_fmmy_m.fmmy021 + g_fmmy_m.fmmy024 + g_fmmy_m.fmmy025

      WHEN p_fomula = 'H2'
          #利息收入本幣
          LET g_fmmy_m.fmmy029 =  g_fmmy_m.fmmy014 + g_fmmy_m.fmmy022 + g_fmmy_m.fmmy026 + g_fmmy_m.fmmy027
      #151117-00001#4-----e
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 抓平倉費用單總合
# Memo...........:
# Date & Author..: 151111  #151105-00008#5 By albireo  
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_show_fmmz(p_fmmydocno)
   DEFINE p_fmmydocno     LIKE fmmy_t.fmmydocno
   DEFINE l_sql           STRING
   DEFINE l_sum10x        LIKE type_t.num20_6
   DEFINE l_sum11x        LIKE type_t.num20_6
   DEFINE l_fmmz     RECORD
                     fmmz002    LIKE fmmz_t.fmmz002,
                     fmmz003    LIKE fmmz_t.fmmz003,
                     fmmz011    LIKE fmmz_t.fmmz011
                     END RECORD
   DEFINE l_rate           LIKE type_t.num20_6
   DEFINE l_10x      LIKE type_t.num20_6
   LET l_sum10x = 0
   LET l_sum11x = 0
   LET l_sql　= "SELECT fmmz002,SUM(fmmz003),SUM(fmmz011) FROM fmmz_t ",
                " WHERE fmmzent = ",g_enterprise," ",
                "   AND fmmzdocno = '",p_fmmydocno,"' ",
                " GROUP BY fmmz002 "
   PREPARE sel_fmmzp1 FROM l_sql
   DECLARE sel_fmmzc1 CURSOR FOR sel_fmmzp1
   FOREACH sel_fmmzc1 INTO l_fmmz.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #fmmz002幣別轉成fmmy002幣別
      #取今日匯率
      #CALL s_aooi160_get_exrate('2',g_glaald,g_fmmy_m.fmmydocdt,l_fmmz.fmmz002,g_fmmy_m.fmmy002,0,g_glaa.glaa025)
      #              RETURNING l_rate
      LET l_rate = 1     #151111  kris:因現行案例未考量費用與平倉幣不同的狀況,所以先拿掉此邏輯
                         #        避免翻頁時取不到匯率等顯示的問題
      IF cl_null(l_rate)THEN LET l_rate = 0 END IF
      LET l_10x = l_fmmz.fmmz003 * l_rate
      #fmmy002取位 
      
      LET l_sum10x = l_sum10x + l_10x
      LET l_sum11x = l_sum11x + l_fmmz.fmmz011
   END FOREACH   
   
   LET g_fmmy_m.l_fmmz003 = l_sum10x
   LET g_fmmy_m.l_fmmz011 = l_sum11x
   DISPLAY BY NAME g_fmmy_m.l_fmmz003,g_fmmy_m.l_fmmz011 
   
END FUNCTION

################################################################################
# Descriptions...: 已計利息
# Memo...........:
# Date & Author..: #151112-00009#2 151113 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_fmmy_source_fmmt(p_type)
   DEFINE p_type    LIKE type_t.chr10
   DEFINE r_10x     LIKE type_t.num20_6
   DEFINE r_11x     LIKE type_t.num20_6
   DEFINE l_fmmj005 LIKE fmmj_t.fmmj005
                   
   LET l_fmmj005 = NULL
   SELECT fmmj005 INTO l_fmmj005 FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmy_m.fmmy001    
     
   LET r_10x = NULL
   LET r_11x = NULL
   SELECT SUM(fmmt012-fmmt018),SUM(fmmt014-fmmt019)
    INTO r_10x,r_11x
    FROM fmmt_t ,fmms_t
   WHERE fmmt012 > fmmt018  # 有未沖金額 
     AND fmmtdocno = fmmsdocno 
     AND fmmt017 = p_type 
     AND fmmsstus ='Y'
     AND fmmt002 = g_fmmy_m.fmmy001
   IF cl_null(r_10x)THEN LET r_10x = 0 END IF
   IF cl_null(r_11x)THEN LET r_11x = 0 END IF
   
   IF p_type = '3' THEN
      LET r_10x = r_10x /l_fmmj005*g_fmmy_m.fmmy003
      LET r_11x = r_11x /l_fmmj005*g_fmmy_m.fmmy003
#      CALL s_curr_round_ld(1,l_glaald,g_glaa.glaa001,g_fmmy_m.fmmy022,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy022
#      CALL s_curr_round_ld(1,l_glaald,l_fmmj006,g_fmmy_m.fmmy021,2) RETURNING g_sub_success,g_errno,g_fmmy_m.fmmy021
   END IF
   
   RETURN r_10x,r_11x
END FUNCTION

################################################################################
# Descriptions...: 確認取消確認回寫fmmt及產生fmmn
# Memo...........:
# Usage..........: 
# Date & Author..: #151112-00009#2 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt590_ins_fmmt(p_type)
   DEFINE p_type   LIKE type_t.chr1   #+-
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_fmmt    RECORD
                    fmmtdocno   LIKE fmmt_t.fmmtdocno,
                    fmmtseq     LIKE fmmt_t.fmmtseq,
                    fmmt10x     LIKE fmmt_t.fmmt012,
                    fmmt11x     LIKE fmmt_t.fmmt014
                    END RECORD
   DEFINE l_fmmn2    RECORD
                    fmmndocno   LIKE fmmn_t.fmmndocno,
                    fmmn001     LIKE fmmn_t.fmmn001,
                    fmmn002     LIKE fmmn_t.fmmn002,
                    fmmn003     LIKE fmmn_t.fmmn003,
                    fmmn005     LIKE fmmn_t.fmmn005,
                    fmmn006     LIKE fmmn_t.fmmn006
                    END RECORD
   DEFINE l_all10x     LIKE type_t.num20_6
   DEFINE l_all11x     LIKE type_t.num20_6
   DEFINE l_do10x      LIKE type_t.num20_6
   DEFINE l_do11x      LIKE type_t.num20_6
   #DEFINE l_fmmn       RECORD LIKE fmmn_t.* #161104-00024#11 mark
   #161104-00024#11 --s add
   DEFINE l_fmmn RECORD  # 沖銷利息子檔
          fmmnent LIKE fmmn_t.fmmnent, #企業編號
          fmmndocno LIKE fmmn_t.fmmndocno, #計息單號
          fmmn001 LIKE fmmn_t.fmmn001, #投資購買單號
          fmmn002 LIKE fmmn_t.fmmn002, #收息來源
          fmmn003 LIKE fmmn_t.fmmn003, #收息單號
          fmmn004 LIKE fmmn_t.fmmn004, #收息日期
          fmmn005 LIKE fmmn_t.fmmn005, #沖銷原幣
          fmmn006 LIKE fmmn_t.fmmn006, #沖銷本幣
          fmmnud001 LIKE fmmn_t.fmmnud001, #自定義欄位(文字)001
          fmmnud002 LIKE fmmn_t.fmmnud002, #自定義欄位(文字)002
          fmmnud003 LIKE fmmn_t.fmmnud003, #自定義欄位(文字)003
          fmmnud004 LIKE fmmn_t.fmmnud004, #自定義欄位(文字)004
          fmmnud005 LIKE fmmn_t.fmmnud005, #自定義欄位(文字)005
          fmmnud006 LIKE fmmn_t.fmmnud006, #自定義欄位(文字)006
          fmmnud007 LIKE fmmn_t.fmmnud007, #自定義欄位(文字)007
          fmmnud008 LIKE fmmn_t.fmmnud008, #自定義欄位(文字)008
          fmmnud009 LIKE fmmn_t.fmmnud009, #自定義欄位(文字)009
          fmmnud010 LIKE fmmn_t.fmmnud010, #自定義欄位(文字)010
          fmmnud011 LIKE fmmn_t.fmmnud011, #自定義欄位(數字)011
          fmmnud012 LIKE fmmn_t.fmmnud012, #自定義欄位(數字)012
          fmmnud013 LIKE fmmn_t.fmmnud013, #自定義欄位(數字)013
          fmmnud014 LIKE fmmn_t.fmmnud014, #自定義欄位(數字)014
          fmmnud015 LIKE fmmn_t.fmmnud015, #自定義欄位(數字)015
          fmmnud016 LIKE fmmn_t.fmmnud016, #自定義欄位(數字)016
          fmmnud017 LIKE fmmn_t.fmmnud017, #自定義欄位(數字)017
          fmmnud018 LIKE fmmn_t.fmmnud018, #自定義欄位(數字)018
          fmmnud019 LIKE fmmn_t.fmmnud019, #自定義欄位(數字)019
          fmmnud020 LIKE fmmn_t.fmmnud020, #自定義欄位(數字)020
          fmmnud021 LIKE fmmn_t.fmmnud021, #自定義欄位(日期時間)021
          fmmnud022 LIKE fmmn_t.fmmnud022, #自定義欄位(日期時間)022
          fmmnud023 LIKE fmmn_t.fmmnud023, #自定義欄位(日期時間)023
          fmmnud024 LIKE fmmn_t.fmmnud024, #自定義欄位(日期時間)024
          fmmnud025 LIKE fmmn_t.fmmnud025, #自定義欄位(日期時間)025
          fmmnud026 LIKE fmmn_t.fmmnud026, #自定義欄位(日期時間)026
          fmmnud027 LIKE fmmn_t.fmmnud027, #自定義欄位(日期時間)027
          fmmnud028 LIKE fmmn_t.fmmnud028, #自定義欄位(日期時間)028
          fmmnud029 LIKE fmmn_t.fmmnud029, #自定義欄位(日期時間)029
          fmmnud030 LIKE fmmn_t.fmmnud030  #自定義欄位(日期時間)030
   END RECORD
   #161104-00024#11 --e add
 
   LET r_success = TRUE
   
   
   IF p_type = '+' THEN
      #先抓出有餘額的afmt560
      #比小  UPDATE全額
      #INSERT 同單號的fmmt
      LET l_sql = "SELECT fmmtdocno,fmmtseq,(fmmt012-fmmt018),(fmmt014-fmmt019) ",
               "  FROM fmmt_t,fmms_t ",
               " WHERE fmmtent = ",g_enterprise," ",
               "   AND fmmt017 = ? ",
               "   AND fmmsstus ='Y' ",
               "   AND fmmt002 = '",g_fmmy_m.fmmy001,"' ",
               "   AND fmmtent = fmmsent AND fmmtdocno = fmmsdocno ",
               " ORDER BY fmms001,fmms002,fmmtdocno,fmmtseq"
      PREPARE sel_fmmtp1 FROM l_sql
      DECLARE sel_fmmtc1 CURSOR FOR sel_fmmtp1
      
      LET l_all10x = g_fmmy_m.fmmy024
      LET l_all11x = g_fmmy_m.fmmy026
      IF l_all10x > 0 THEN      
      FOREACH sel_fmmtc1 USING '1' INTO l_fmmt.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         
         IF l_fmmt.fmmt10x > l_all10x THEN
            LET l_do10x = l_all10x         
         ELSE
            LET l_do10x = l_fmmt.fmmt10x
         END IF
         
         IF l_fmmt.fmmt11x > l_all11x THEN
            LET l_do11x = l_all11x         
         ELSE
            LET l_do11x = l_fmmt.fmmt11x
         END IF
         
         #INSERT l_fmmn
         INITIALIZE l_fmmn.* TO NULL
         LET l_fmmn.fmmnent = g_enterprise
         LET l_fmmn.fmmndocno = l_fmmt.fmmtdocno
         LET l_fmmn.fmmn001   = g_fmmy_m.fmmy001
         LET l_fmmn.fmmn002   = '2'
         LET l_fmmn.fmmn003   = g_fmmy_m.fmmydocno
         LET l_fmmn.fmmn004   = g_today
         LET l_fmmn.fmmn005   = l_do10x
         LET l_fmmn.fmmn006   = l_do11x
        #INSERT INTO fmmn_t VALUES(l_fmmn.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO fmmn_t(fmmnent,fmmndocno,fmmn001,fmmn002,fmmn003,
                            fmmn004,fmmn005,fmmn006,fmmnud001,fmmnud002,
                            fmmnud003,fmmnud004,fmmnud005,fmmnud006,fmmnud007,
                            fmmnud008,fmmnud009,fmmnud010,fmmnud011,fmmnud012,
                            fmmnud013,fmmnud014,fmmnud015,fmmnud016,fmmnud017,
                            fmmnud018,fmmnud019,fmmnud020,fmmnud021,fmmnud022,
                            fmmnud023,fmmnud024,fmmnud025,fmmnud026,fmmnud027,
                            fmmnud028,fmmnud029,fmmnud030)
         VALUES(l_fmmn.fmmnent,l_fmmn.fmmndocno,l_fmmn.fmmn001,l_fmmn.fmmn002,l_fmmn.fmmn003,
                l_fmmn.fmmn004,l_fmmn.fmmn005,l_fmmn.fmmn006,l_fmmn.fmmnud001,l_fmmn.fmmnud002,
                l_fmmn.fmmnud003,l_fmmn.fmmnud004,l_fmmn.fmmnud005,l_fmmn.fmmnud006,l_fmmn.fmmnud007,
                l_fmmn.fmmnud008,l_fmmn.fmmnud009,l_fmmn.fmmnud010,l_fmmn.fmmnud011,l_fmmn.fmmnud012,
                l_fmmn.fmmnud013,l_fmmn.fmmnud014,l_fmmn.fmmnud015,l_fmmn.fmmnud016,l_fmmn.fmmnud017,
                l_fmmn.fmmnud018,l_fmmn.fmmnud019,l_fmmn.fmmnud020,l_fmmn.fmmnud021,l_fmmn.fmmnud022,
                l_fmmn.fmmnud023,l_fmmn.fmmnud024,l_fmmn.fmmnud025,l_fmmn.fmmnud026,l_fmmn.fmmnud027,
                l_fmmn.fmmnud028,l_fmmn.fmmnud029,l_fmmn.fmmnud030)
         #161104-00024#11 --e add
         #UPDATE fmmt
         UPDATE fmmt_t SET fmmt018 = fmmt018 + l_do10x,
                           fmmt019 = fmmt019 + l_do11x
          WHERE fmmtent = g_enterprise
            AND fmmtdocno = l_fmmt.fmmtdocno
            AND fmmtseq   = l_fmmt.fmmtseq
          
         
         LET l_all10x = l_all10x - l_do10x
         LET l_all11x = l_all11x - l_do11x
      END FOREACH
      END IF
      
      
      LET l_all10x = g_fmmy_m.fmmy025
      LET l_all11x = g_fmmy_m.fmmy027   
      IF l_all10x > 0 THEN
      FOREACH sel_fmmtc1 USING '2' INTO l_fmmt.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         
         IF l_fmmt.fmmt10x > l_all10x THEN
            LET l_do10x = l_all10x         
         ELSE
            LET l_do10x = l_fmmt.fmmt10x
         END IF
         
         IF l_fmmt.fmmt11x > l_all11x THEN
            LET l_do11x = l_all11x         
         ELSE
            LET l_do11x = l_fmmt.fmmt11x
         END IF
         
         #INSERT l_fmmn
         INITIALIZE l_fmmn.* TO NULL
         LET l_fmmn.fmmnent = g_enterprise
         LET l_fmmn.fmmndocno = l_fmmt.fmmtdocno
         LET l_fmmn.fmmn001   = g_fmmy_m.fmmy001
         LET l_fmmn.fmmn002   = '2'
         LET l_fmmn.fmmn003   = g_fmmy_m.fmmydocno
         LET l_fmmn.fmmn004   = g_today
         LET l_fmmn.fmmn005   = l_do10x
         LET l_fmmn.fmmn006   = l_do11x
        #INSERT INTO fmmn_t VALUES(l_fmmn.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO fmmn_t(fmmnent,fmmndocno,fmmn001,fmmn002,fmmn003,
                            fmmn004,fmmn005,fmmn006,fmmnud001,fmmnud002,
                            fmmnud003,fmmnud004,fmmnud005,fmmnud006,fmmnud007,
                            fmmnud008,fmmnud009,fmmnud010,fmmnud011,fmmnud012,
                            fmmnud013,fmmnud014,fmmnud015,fmmnud016,fmmnud017,
                            fmmnud018,fmmnud019,fmmnud020,fmmnud021,fmmnud022,
                            fmmnud023,fmmnud024,fmmnud025,fmmnud026,fmmnud027,
                            fmmnud028,fmmnud029,fmmnud030)
         VALUES(l_fmmn.fmmnent,l_fmmn.fmmndocno,l_fmmn.fmmn001,l_fmmn.fmmn002,l_fmmn.fmmn003,
                l_fmmn.fmmn004,l_fmmn.fmmn005,l_fmmn.fmmn006,l_fmmn.fmmnud001,l_fmmn.fmmnud002,
                l_fmmn.fmmnud003,l_fmmn.fmmnud004,l_fmmn.fmmnud005,l_fmmn.fmmnud006,l_fmmn.fmmnud007,
                l_fmmn.fmmnud008,l_fmmn.fmmnud009,l_fmmn.fmmnud010,l_fmmn.fmmnud011,l_fmmn.fmmnud012,
                l_fmmn.fmmnud013,l_fmmn.fmmnud014,l_fmmn.fmmnud015,l_fmmn.fmmnud016,l_fmmn.fmmnud017,
                l_fmmn.fmmnud018,l_fmmn.fmmnud019,l_fmmn.fmmnud020,l_fmmn.fmmnud021,l_fmmn.fmmnud022,
                l_fmmn.fmmnud023,l_fmmn.fmmnud024,l_fmmn.fmmnud025,l_fmmn.fmmnud026,l_fmmn.fmmnud027,
                l_fmmn.fmmnud028,l_fmmn.fmmnud029,l_fmmn.fmmnud030)
         #161104-00024#11 --e add
         
         #UPDATE fmmt
         UPDATE fmmt_t SET fmmt018 = fmmt018 + l_do10x,
                           fmmt019 = fmmt019 + l_do11x
          WHERE fmmtent = g_enterprise
            AND fmmtdocno = l_fmmt.fmmtdocno
            AND fmmtseq   = l_fmmt.fmmtseq
          
         
         LET l_all10x = l_all10x - l_do10x
         LET l_all11x = l_all11x - l_do11x
      END FOREACH
      END IF
      
      
      LET l_all10x = g_fmmy_m.fmmy021
      LET l_all11x = g_fmmy_m.fmmy022   
      IF l_all10x > 0 THEN
      FOREACH sel_fmmtc1 USING '3' INTO l_fmmt.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         
         IF l_fmmt.fmmt10x > l_all10x THEN
            LET l_do10x = l_all10x         
         ELSE
            LET l_do10x = l_fmmt.fmmt10x
         END IF
         
         IF l_fmmt.fmmt11x > l_all11x THEN
            LET l_do11x = l_all11x         
         ELSE
            LET l_do11x = l_fmmt.fmmt11x
         END IF
         
         #INSERT l_fmmn
         INITIALIZE l_fmmn.* TO NULL
         LET l_fmmn.fmmnent = g_enterprise         
         LET l_fmmn.fmmndocno = l_fmmt.fmmtdocno
         LET l_fmmn.fmmn001   = g_fmmy_m.fmmy001
         LET l_fmmn.fmmn002   = '2'
         LET l_fmmn.fmmn003   = g_fmmy_m.fmmydocno
         LET l_fmmn.fmmn004   = g_today
         LET l_fmmn.fmmn005   = l_do10x
         LET l_fmmn.fmmn006   = l_do11x
        #INSERT INTO fmmn_t VALUES(l_fmmn.*) #161104-00024#11 mark
         #161104-00024#11 --s add
         INSERT INTO fmmn_t(fmmnent,fmmndocno,fmmn001,fmmn002,fmmn003,
                            fmmn004,fmmn005,fmmn006,fmmnud001,fmmnud002,
                            fmmnud003,fmmnud004,fmmnud005,fmmnud006,fmmnud007,
                            fmmnud008,fmmnud009,fmmnud010,fmmnud011,fmmnud012,
                            fmmnud013,fmmnud014,fmmnud015,fmmnud016,fmmnud017,
                            fmmnud018,fmmnud019,fmmnud020,fmmnud021,fmmnud022,
                            fmmnud023,fmmnud024,fmmnud025,fmmnud026,fmmnud027,
                            fmmnud028,fmmnud029,fmmnud030)
         VALUES(l_fmmn.fmmnent,l_fmmn.fmmndocno,l_fmmn.fmmn001,l_fmmn.fmmn002,l_fmmn.fmmn003,
                l_fmmn.fmmn004,l_fmmn.fmmn005,l_fmmn.fmmn006,l_fmmn.fmmnud001,l_fmmn.fmmnud002,
                l_fmmn.fmmnud003,l_fmmn.fmmnud004,l_fmmn.fmmnud005,l_fmmn.fmmnud006,l_fmmn.fmmnud007,
                l_fmmn.fmmnud008,l_fmmn.fmmnud009,l_fmmn.fmmnud010,l_fmmn.fmmnud011,l_fmmn.fmmnud012,
                l_fmmn.fmmnud013,l_fmmn.fmmnud014,l_fmmn.fmmnud015,l_fmmn.fmmnud016,l_fmmn.fmmnud017,
                l_fmmn.fmmnud018,l_fmmn.fmmnud019,l_fmmn.fmmnud020,l_fmmn.fmmnud021,l_fmmn.fmmnud022,
                l_fmmn.fmmnud023,l_fmmn.fmmnud024,l_fmmn.fmmnud025,l_fmmn.fmmnud026,l_fmmn.fmmnud027,
                l_fmmn.fmmnud028,l_fmmn.fmmnud029,l_fmmn.fmmnud030)
         #161104-00024#11 --e add
         
         #UPDATE fmmt
         UPDATE fmmt_t SET fmmt018 = fmmt018 + l_do10x,
                           fmmt019 = fmmt019 + l_do11x
          WHERE fmmtent = g_enterprise
            AND fmmtdocno = l_fmmt.fmmtdocno
            AND fmmtseq   = l_fmmt.fmmtseq
          
         
         LET l_all10x = l_all10x - l_do10x
         LET l_all11x = l_all11x - l_do11x
      END FOREACH
      END IF
   ELSE
      LET l_sql = "SELECT fmmndocno,fmmn001,fmmn002,fmmn003,fmmn005,fmmn006 FROM fmmn_t,fmms_t ",
                  " WHERE fmmndocno = fmmsdocno ",
                  "   AND fmmnent   = fmmsent ",
                  "   AND fmmnent = ",g_enterprise," ",
                  "   AND fmmn003 = '",g_fmmy_m.fmmydocno,"' "
      PREPARE sel_fmmnp1 FROM l_sql
      DECLARE sel_fmmnc1 CURSOR FOR sel_fmmnp1 
      
      FOREACH sel_fmmnc1 INTO l_fmmn2.*
         IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
         
         UPDATE fmmt_t SET fmmt018 = fmmt018 - l_fmmn2.fmmn005,
                           fmmt019 = fmmt019 - l_fmmn2.fmmn006
          WHERE fmmtent = g_enterprise
            AND fmmtdocno = l_fmmn2.fmmndocno
            AND fmmt002   = g_fmmy_m.fmmy001
            #AND fmmt017   = l_fmmn.fmmn002
         DELETE FROM fmmn_t
          WHERE fmmnent = g_enterprise
            AND fmmndocno = l_fmmn2.fmmndocno
            AND fmmn001   = l_fmmn2.fmmn001
            AND fmmn003   = l_fmmn2.fmmn003
      END FOREACH
   END IF
               
   RETURN r_success
   
END FUNCTION

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="artt300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0042(2016-08-05 10:26:27), PR版次:0042(2017-02-20 14:37:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000662
#+ Filename...: artt300
#+ Description: 商品准入申請作業
#+ Creator....: 01752(2013-07-18 15:47:28)
#+ Modifier...: 06814 -SD/PR- 09042
 
{</section>}
 
{<section id="artt300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#18    2016/04/13    BY 07900    校验代码重复错误讯息的修改
#160512-00003#10    2016/05/24    By 08172    商品种类，条码分类，补货规格新增修改
#160518-00046#1     2016/05/24    By 08172    商品属性页签栏位控管报错修改
#160529-00002#1     2016/05/31    By 03538    臨期管理畫面欄位調整:臨時控管方式/ 保質期(月)/ 保質期(天)/ 臨期比例/ 臨期天數;方式為不控管時,比例與天數不控卡必輸
#160604-00009#91    2016/06/21    By dongsz   条码类型加上8.商户商品，9.专柜商品，10.物料
#160604-00009#108   2016/06/27    By geza     自动编号调整
#160705-00013#3     2016/07/12    By 02749    增加觸屏分類(imaa161)
#160705-00042#11    2016/07/14    By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160720-00007#1     2016/07/20    By geza     insert前如果只有一笔自动编码的规则，才再次取号
#160725-00016#1     2016/07/26    by 08172    修改时带出商品类别
#160801-00017#4     2016/08/05    By 06814    1.单身多条码页签增加产品特征字段，管控当前料件的条码分类(imay002)为3.款色，且料件特征组不为空时，此字段必填。
#                                               可手动录入或开窗选填，参照apmt500采购单身修改状态时的产品特征字段
#                                             2.画面位置：产品特征字段放在条码类型与商品条码之间。
#160803-00008#3     2016/08/11    By 06814    1.條碼分類為3.款色，且料件特徵組不為空時，
#                                               新增資料時可開窗二維勾選多個特徵(參照apmt500採購單身產品特徵字段，
#                                               但需將二維開窗中的數量字段變為勾選字段),
#                                               根據勾選的特徵自動生成多筆條碼資料(商品條碼=料號+產品特徵值(無下劃線))。
#                                             2.當條碼分類為3.款色時,不走條碼校驗
#160728-00034#1     2016/08/16    by 08172    BPM修改
#160816-00068#10    2016/08/17    By 08209    調整transaction
#160822-00036#3     2016/08/24    By 06814    1.產品特徵開窗完畢後,馬上顯示出所有產出筆數
#                                             2.aoos020 若不使用產品特徵,將產品特徵隱藏
#160905-00007#14    2016/09/05    By 07900    调整系统中无ENT的SQL条件增加ent
#161111-00028#3     2016/11/14    BY 02481    标准程式定义采用宣告模式,弃用.*写法
#160824-00007#162   2016/11/25    By 06814    新舊值相關
#170207-00018#8     2016/02/09    By 09042    ROWNUM整批调整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aim_aimm200_01   #lori522612  150126 add---嵌入產品特徵值
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aim/4gl/aimm200_01.inc"   #lori522612  150126 add---嵌入產品特徵值
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_imba_m        RECORD
       imba000 LIKE imba_t.imba000, 
   imbadocno LIKE imba_t.imbadocno, 
   imbadocdt LIKE imba_t.imbadocdt, 
   imba001 LIKE imba_t.imba001, 
   imbal002 LIKE imbal_t.imbal002, 
   imbal003 LIKE imbal_t.imbal003, 
   imbal004 LIKE imbal_t.imbal004, 
   imba003 LIKE imba_t.imba003, 
   imba003_desc LIKE type_t.chr80, 
   imba108 LIKE imba_t.imba108, 
   imba004 LIKE imba_t.imba004, 
   imba100 LIKE imba_t.imba100, 
   imba109 LIKE imba_t.imba109, 
   imba014 LIKE imba_t.imba014, 
   imba002 LIKE imba_t.imba002, 
   imba006 LIKE imba_t.imba006, 
   imba006_desc LIKE type_t.chr80, 
   imba105 LIKE imba_t.imba105, 
   imba105_desc LIKE type_t.chr80, 
   imba104 LIKE imba_t.imba104, 
   imba104_desc LIKE type_t.chr80, 
   imba107 LIKE imba_t.imba107, 
   imba107_desc LIKE type_t.chr80, 
   imba106 LIKE imba_t.imba106, 
   imba106_desc LIKE type_t.chr80, 
   imba145 LIKE imba_t.imba145, 
   imba145_desc LIKE type_t.chr80, 
   imba146 LIKE imba_t.imba146, 
   imba146_desc LIKE type_t.chr80, 
   imba113 LIKE imba_t.imba113, 
   imba005 LIKE imba_t.imba005, 
   imba005_desc LIKE type_t.chr80, 
   imba142 LIKE imba_t.imba142, 
   imba142_desc LIKE type_t.chr80, 
   imbaacti LIKE imba_t.imbaacti, 
   imba019 LIKE imba_t.imba019, 
   imba020 LIKE imba_t.imba020, 
   imba021 LIKE imba_t.imba021, 
   imba022 LIKE imba_t.imba022, 
   imba022_desc LIKE type_t.chr80, 
   imba025 LIKE imba_t.imba025, 
   imba026 LIKE imba_t.imba026, 
   imba026_desc LIKE type_t.chr80, 
   imba016 LIKE imba_t.imba016, 
   imba018 LIKE imba_t.imba018, 
   imba018_desc LIKE type_t.chr80, 
   imba010 LIKE imba_t.imba010, 
   imbastus LIKE imba_t.imbastus, 
   imbaownid LIKE imba_t.imbaownid, 
   imbaownid_desc LIKE type_t.chr80, 
   imbaowndp LIKE imba_t.imbaowndp, 
   imbaowndp_desc LIKE type_t.chr80, 
   imbacrtid LIKE imba_t.imbacrtid, 
   imbacrtid_desc LIKE type_t.chr80, 
   imbacrtdp LIKE imba_t.imbacrtdp, 
   imbacrtdp_desc LIKE type_t.chr80, 
   imbacrtdt LIKE imba_t.imbacrtdt, 
   imbamodid LIKE imba_t.imbamodid, 
   imbamodid_desc LIKE type_t.chr80, 
   imbamoddt LIKE imba_t.imbamoddt, 
   imbacnfid LIKE imba_t.imbacnfid, 
   imbacnfid_desc LIKE type_t.chr80, 
   imbacnfdt LIKE imba_t.imbacnfdt, 
   imba009 LIKE imba_t.imba009, 
   imba009_desc LIKE type_t.chr80, 
   imba161 LIKE imba_t.imba161, 
   imba161_desc LIKE type_t.chr80, 
   imba101 LIKE imba_t.imba101, 
   imba101_desc LIKE type_t.chr80, 
   imba118 LIKE imba_t.imba118, 
   imba119 LIKE imba_t.imba119, 
   imba120 LIKE imba_t.imba120, 
   imba114 LIKE imba_t.imba114, 
   imba114_desc LIKE type_t.chr80, 
   imba115 LIKE imba_t.imba115, 
   imba116 LIKE imba_t.imba116, 
   imba117 LIKE imba_t.imba117, 
   imba124 LIKE imba_t.imba124, 
   imba124_desc LIKE type_t.chr80, 
   imbf122 LIKE type_t.chr10, 
   imbf115 LIKE type_t.num20_6, 
   imbf114 LIKE type_t.num20_6, 
   imbf116 LIKE type_t.chr10, 
   imba110 LIKE imba_t.imba110, 
   imba111 LIKE imba_t.imba111, 
   imba112 LIKE imba_t.imba112, 
   imba125 LIKE imba_t.imba125, 
   imba121 LIKE imba_t.imba121, 
   imba144 LIKE imba_t.imba144, 
   imba122 LIKE imba_t.imba122, 
   imba122_desc LIKE type_t.chr80, 
   imba123 LIKE imba_t.imba123, 
   imba131 LIKE imba_t.imba131, 
   imba131_desc LIKE type_t.chr80, 
   imba126 LIKE imba_t.imba126, 
   imba126_desc LIKE type_t.chr80, 
   imba127 LIKE imba_t.imba127, 
   imba127_desc LIKE type_t.chr80, 
   imba128 LIKE imba_t.imba128, 
   imba128_desc LIKE type_t.chr80, 
   imba129 LIKE imba_t.imba129, 
   imba129_desc LIKE type_t.chr80, 
   imba143 LIKE imba_t.imba143, 
   imba143_desc LIKE type_t.chr80, 
   imba130 LIKE imba_t.imba130, 
   imba150 LIKE imba_t.imba150, 
   imba151 LIKE imba_t.imba151, 
   imba152 LIKE imba_t.imba152, 
   imba153 LIKE imba_t.imba153, 
   imba132 LIKE imba_t.imba132, 
   imba132_desc LIKE type_t.chr80, 
   imba133 LIKE imba_t.imba133, 
   imba133_desc LIKE type_t.chr80, 
   imba134 LIKE imba_t.imba134, 
   imba134_desc LIKE type_t.chr80, 
   imba135 LIKE imba_t.imba135, 
   imba135_desc LIKE type_t.chr80, 
   imba136 LIKE imba_t.imba136, 
   imba136_desc LIKE type_t.chr80, 
   imba137 LIKE imba_t.imba137, 
   imba137_desc LIKE type_t.chr80, 
   imba138 LIKE imba_t.imba138, 
   imba138_desc LIKE type_t.chr80, 
   imba139 LIKE imba_t.imba139, 
   imba139_desc LIKE type_t.chr80, 
   imba140 LIKE imba_t.imba140, 
   imba140_desc LIKE type_t.chr80, 
   imba141 LIKE imba_t.imba141, 
   imba141_desc LIKE type_t.chr80, 
   imbf061 LIKE imbf_t.imbf061, 
   imbf062 LIKE imbf_t.imbf062, 
   imbf063 LIKE imbf_t.imbf063, 
   imbf063_desc LIKE type_t.chr80, 
   imbf064 LIKE imbf_t.imbf064, 
   imba149 LIKE imba_t.imba149, 
   imba102 LIKE imba_t.imba102, 
   imba103 LIKE imba_t.imba103, 
   imba147 LIKE imba_t.imba147, 
   imba148 LIKE imba_t.imba148
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imby_d        RECORD
       imby001 LIKE imby_t.imby001, 
   imbystus LIKE imby_t.imbystus, 
   imby002 LIKE imby_t.imby002, 
   imby019 LIKE imby_t.imby019, 
   imby019_desc LIKE type_t.chr500, 
   imby003 LIKE imby_t.imby003, 
   imby004 LIKE imby_t.imby004, 
   imby004_desc LIKE type_t.chr500, 
   imby005 LIKE imby_t.imby005, 
   imby006 LIKE imby_t.imby006, 
   imby018 LIKE imby_t.imby018, 
   imby007 LIKE imby_t.imby007, 
   imby008 LIKE imby_t.imby008, 
   imby009 LIKE imby_t.imby009, 
   imby015 LIKE imby_t.imby015, 
   imby015_desc LIKE type_t.chr500, 
   imby010 LIKE imby_t.imby010, 
   imby016 LIKE imby_t.imby016, 
   imby016_desc LIKE type_t.chr500, 
   imby011 LIKE imby_t.imby011, 
   imby017 LIKE imby_t.imby017, 
   imby017_desc LIKE type_t.chr500, 
   imby012 LIKE imby_t.imby012, 
   imby013 LIKE imby_t.imby013, 
   imby014 LIKE imby_t.imby014
       END RECORD
PRIVATE TYPE type_g_imby2_d RECORD
       imbz001 LIKE imbz_t.imbz001, 
   imbz002 LIKE imbz_t.imbz002, 
   imbz003 LIKE imbz_t.imbz003, 
   imbz006 LIKE imbz_t.imbz006, 
   imbz004 LIKE imbz_t.imbz004, 
   imbz004_desc LIKE type_t.chr500, 
   imbz005 LIKE imbz_t.imbz005
       END RECORD
PRIVATE TYPE type_g_imby3_d RECORD
       imbo002 LIKE imbo_t.imbo002, 
   imbo002_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imbadocno LIKE imba_t.imbadocno,
      b_imba000 LIKE imba_t.imba000,
      b_imba001 LIKE imba_t.imba001,
   b_imbadocno_desc LIKE type_t.chr80,
   b_imbadocno_desc_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_ooef005      LIKE ooef_t.ooef005
DEFINE g_assign_no    LIKE type_t.chr1
#ken---add---s 需求單號：150209-00006 項次：1
GLOBALS
TYPE type_g_imak_d        RECORD
       imak001 LIKE imak_t.imak001, 
   imak002 LIKE imak_t.imak002, 
   imak002_desc LIKE type_t.chr500, 
   imak003 LIKE imak_t.imak003, 
   imak003_desc LIKE type_t.chr500
       END RECORD
DEFINE global_g_imak_d          DYNAMIC ARRAY OF type_g_imak_d
END GLOBALS
#ken---add---e
DEFINE g_touch        LIKE type_t.num5   #150915-00006#1 20150915 add by beckxie
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imba_m          type_g_imba_m
DEFINE g_imba_m_t        type_g_imba_m
DEFINE g_imba_m_o        type_g_imba_m
DEFINE g_imba_m_mask_o   type_g_imba_m #轉換遮罩前資料
DEFINE g_imba_m_mask_n   type_g_imba_m #轉換遮罩後資料
 
   DEFINE g_imbadocno_t LIKE imba_t.imbadocno
 
 
DEFINE g_imby_d          DYNAMIC ARRAY OF type_g_imby_d
DEFINE g_imby_d_t        type_g_imby_d
DEFINE g_imby_d_o        type_g_imby_d
DEFINE g_imby_d_mask_o   DYNAMIC ARRAY OF type_g_imby_d #轉換遮罩前資料
DEFINE g_imby_d_mask_n   DYNAMIC ARRAY OF type_g_imby_d #轉換遮罩後資料
DEFINE g_imby2_d          DYNAMIC ARRAY OF type_g_imby2_d
DEFINE g_imby2_d_t        type_g_imby2_d
DEFINE g_imby2_d_o        type_g_imby2_d
DEFINE g_imby2_d_mask_o   DYNAMIC ARRAY OF type_g_imby2_d #轉換遮罩前資料
DEFINE g_imby2_d_mask_n   DYNAMIC ARRAY OF type_g_imby2_d #轉換遮罩後資料
DEFINE g_imby3_d          DYNAMIC ARRAY OF type_g_imby3_d
DEFINE g_imby3_d_t        type_g_imby3_d
DEFINE g_imby3_d_o        type_g_imby3_d
DEFINE g_imby3_d_mask_o   DYNAMIC ARRAY OF type_g_imby3_d #轉換遮罩前資料
DEFINE g_imby3_d_mask_n   DYNAMIC ARRAY OF type_g_imby3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      imbaldocno LIKE imbal_t.imbaldocno,
      imbal002 LIKE imbal_t.imbal002,
      imbal003 LIKE imbal_t.imbal003,
      imbal004 LIKE imbal_t.imbal004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artt300.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#3 150529 by s983961 add(s) 
   #IF g_prog="adbt300" THEN          #160705-00042#11 160714 by sakura mark
   IF g_prog MATCHES 'adbt300' THEN   #160705-00042#11 160714 by sakura add
      IF cl_get_para(g_enterprise,g_site,'E-CIR-0017') ='N' THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'adb-00429'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()    
          CALL cl_ap_exitprogram("0")
      END IF
   END IF        
   
   #IF g_prog="artt300" THEN          #160705-00042#11 160714 by sakura mark
   IF g_prog MATCHES 'artt300' THEN   #160705-00042#11 160714 by sakura add
     IF cl_get_para(g_enterprise,g_site,'E-CIR-0017') ='N' THEN    
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'art-00578'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()    
       CALL cl_ap_exitprogram("0")
   END IF
     END IF  
   #150424-00018#3 150529 by s983961 add(e) 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT imba000,imbadocno,imbadocdt,imba001,'','','',imba003,'',imba108,imba004, 
       imba100,imba109,imba014,imba002,imba006,'',imba105,'',imba104,'',imba107,'',imba106,'',imba145, 
       '',imba146,'',imba113,imba005,'',imba142,'',imbaacti,imba019,imba020,imba021,imba022,'',imba025, 
       imba026,'',imba016,imba018,'',imba010,imbastus,imbaownid,'',imbaowndp,'',imbacrtid,'',imbacrtdp, 
       '',imbacrtdt,imbamodid,'',imbamoddt,imbacnfid,'',imbacnfdt,imba009,'',imba161,'',imba101,'',imba118, 
       imba119,imba120,imba114,'',imba115,imba116,imba117,imba124,'','','','','',imba110,imba111,imba112, 
       imba125,imba121,imba144,imba122,'',imba123,imba131,'',imba126,'',imba127,'',imba128,'',imba129, 
       '',imba143,'',imba130,imba150,imba151,imba152,imba153,imba132,'',imba133,'',imba134,'',imba135, 
       '',imba136,'',imba137,'',imba138,'',imba139,'',imba140,'',imba141,'','','','','','',imba149,imba102, 
       imba103,imba147,imba148", 
                      " FROM imba_t",
                      " WHERE imbaent= ? AND imbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imba000,t0.imbadocno,t0.imbadocdt,t0.imba001,t0.imba003,t0.imba108, 
       t0.imba004,t0.imba100,t0.imba109,t0.imba014,t0.imba002,t0.imba006,t0.imba105,t0.imba104,t0.imba107, 
       t0.imba106,t0.imba145,t0.imba146,t0.imba113,t0.imba005,t0.imba142,t0.imbaacti,t0.imba019,t0.imba020, 
       t0.imba021,t0.imba022,t0.imba025,t0.imba026,t0.imba016,t0.imba018,t0.imba010,t0.imbastus,t0.imbaownid, 
       t0.imbaowndp,t0.imbacrtid,t0.imbacrtdp,t0.imbacrtdt,t0.imbamodid,t0.imbamoddt,t0.imbacnfid,t0.imbacnfdt, 
       t0.imba009,t0.imba161,t0.imba101,t0.imba118,t0.imba119,t0.imba120,t0.imba114,t0.imba115,t0.imba116, 
       t0.imba117,t0.imba124,t0.imba110,t0.imba111,t0.imba112,t0.imba125,t0.imba121,t0.imba144,t0.imba122, 
       t0.imba123,t0.imba131,t0.imba126,t0.imba127,t0.imba128,t0.imba129,t0.imba143,t0.imba130,t0.imba150, 
       t0.imba151,t0.imba152,t0.imba153,t0.imba132,t0.imba133,t0.imba134,t0.imba135,t0.imba136,t0.imba137, 
       t0.imba138,t0.imba139,t0.imba140,t0.imba141,t0.imba149,t0.imba102,t0.imba103,t0.imba147,t0.imba148, 
       t1.imckl003 ,t2.oocal003 ,t3.oocal003 ,t4.oocal003 ,t5.oocal003 ,t6.oocal003 ,t7.oocal003 ,t8.oocal003 , 
       t9.imeal003 ,t10.ooefl003 ,t11.oocal003 ,t12.oocal003 ,t13.oocal003 ,t14.ooag011 ,t15.ooefl003 , 
       t16.ooag011 ,t17.ooefl003 ,t18.ooag011 ,t19.ooag011 ,t20.rtaxl003 ,t21.pcbal003 ,t22.pmaal004 , 
       t23.ooail003 ,t24.oocql004 ,t25.oocql004 ,t26.oocql004 ,t27.oocql004 ,t28.oocql004 ,t29.oocql004 , 
       t30.dbbal003 ,t31.oocql004 ,t32.oocql004 ,t33.oocql004 ,t34.oocql004 ,t35.oocql004 ,t36.oocql004 , 
       t37.oocql004 ,t38.oocql004 ,t39.oocql004 ,t40.oocql004",
               " FROM imba_t t0",
                              " LEFT JOIN imckl_t t1 ON t1.imcklent="||g_enterprise||" AND t1.imckl001=t0.imba003 AND t1.imckl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imba006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imba105 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imba104 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.imba107 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=t0.imba106 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=t0.imba145 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=t0.imba146 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t9 ON t9.imealent="||g_enterprise||" AND t9.imeal001=t0.imba005 AND t9.imeal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.imba142 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent="||g_enterprise||" AND t11.oocal001=t0.imba022 AND t11.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=t0.imba026 AND t12.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t13 ON t13.oocalent="||g_enterprise||" AND t13.oocal001=t0.imba018 AND t13.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.imbaownid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.imbaowndp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.imbacrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.imbacrtdp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.imbamodid  ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.imbacnfid  ",
               " LEFT JOIN rtaxl_t t20 ON t20.rtaxlent="||g_enterprise||" AND t20.rtaxl001=t0.imba009 AND t20.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN pcbal_t t21 ON t21.pcbalent="||g_enterprise||" AND t21.pcbal001=t0.imba161 AND t21.pcbal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t22 ON t22.pmaalent="||g_enterprise||" AND t22.pmaal001=t0.imba101 AND t22.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t23 ON t23.ooailent="||g_enterprise||" AND t23.ooail001=t0.imba114 AND t23.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t24 ON t24.oocqlent="||g_enterprise||" AND t24.oocql001='2000' AND t24.oocql002=t0.imba122 AND t24.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t25 ON t25.oocqlent="||g_enterprise||" AND t25.oocql001='2001' AND t25.oocql002=t0.imba131 AND t25.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t26 ON t26.oocqlent="||g_enterprise||" AND t26.oocql001='2002' AND t26.oocql002=t0.imba126 AND t26.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t27 ON t27.oocqlent="||g_enterprise||" AND t27.oocql001='2003' AND t27.oocql002=t0.imba127 AND t27.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t28 ON t28.oocqlent="||g_enterprise||" AND t28.oocql001='2004' AND t28.oocql002=t0.imba128 AND t28.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t29 ON t29.oocqlent="||g_enterprise||" AND t29.oocql001='2005' AND t29.oocql002=t0.imba129 AND t29.oocql003='"||g_dlang||"' ",
               " LEFT JOIN dbbal_t t30 ON t30.dbbalent="||g_enterprise||" AND t30.dbbal001=t0.imba143 AND t30.dbbal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t31 ON t31.oocqlent="||g_enterprise||" AND t31.oocql001='2006' AND t31.oocql002=t0.imba132 AND t31.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t32 ON t32.oocqlent="||g_enterprise||" AND t32.oocql001='2007' AND t32.oocql002=t0.imba133 AND t32.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t33 ON t33.oocqlent="||g_enterprise||" AND t33.oocql001='2008' AND t33.oocql002=t0.imba134 AND t33.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t34 ON t34.oocqlent="||g_enterprise||" AND t34.oocql001='2009' AND t34.oocql002=t0.imba135 AND t34.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t35 ON t35.oocqlent="||g_enterprise||" AND t35.oocql001='2010' AND t35.oocql002=t0.imba136 AND t35.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t36 ON t36.oocqlent="||g_enterprise||" AND t36.oocql001='2011' AND t36.oocql002=t0.imba137 AND t36.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t37 ON t37.oocqlent="||g_enterprise||" AND t37.oocql001='2012' AND t37.oocql002=t0.imba138 AND t37.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t38 ON t38.oocqlent="||g_enterprise||" AND t38.oocql001='2013' AND t38.oocql002=t0.imba139 AND t38.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t39 ON t39.oocqlent="||g_enterprise||" AND t39.oocql001='2014' AND t39.oocql002=t0.imba140 AND t39.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t40 ON t40.oocqlent="||g_enterprise||" AND t40.oocql001='2015' AND t40.oocql002=t0.imba141 AND t40.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imbaent = " ||g_enterprise|| " AND t0.imbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt300 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt300_init()   
 
      #進入選單 Menu (="N")
      CALL artt300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi390_drop_tmp_table()   #add by Ken 20150522     添加編碼功能
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt300
      
   END IF 
   
   CLOSE artt300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_values        STRING             #ComboBox values
   DEFINE l_items         STRING             #ComboBox items
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002     
   DEFINE l_success       LIKE type_t.num5   #150308-00001#3 150309 pomelo add   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
 
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('imbastus','13','N,W,A,Y,D,R,X')
 
      CALL cl_set_combo_scc('imba000','32') 
   CALL cl_set_combo_scc('imba108','2002') 
   CALL cl_set_combo_scc('imba004','1001') 
   CALL cl_set_combo_scc('imba100','2003') 
   CALL cl_set_combo_scc('imba109','2004') 
   CALL cl_set_combo_scc('imbf061','1012') 
   CALL cl_set_combo_scc('imbf064','1014') 
   CALL cl_set_combo_scc('imba149','6799') 
   CALL cl_set_combo_scc('imby002','2003') 
   CALL cl_set_combo_scc('imby018','6749') 
   CALL cl_set_combo_scc('imbz002','2005') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow  = 1 
#   CALL cl_set_combo_scc('l_imbf061','1012')#150324-00006#15 150408 by lori522612 add #150614-00020#1 20150617 mark by beckxie
   CALL cl_set_combo_scc('imbf061','1012')   #150614-00020#1 20150617 add by beckxie
   #150122-00013#1 150304 pomelo add (s)
   CALL cl_set_combo_scc('imbf122','2027')
   CALL cl_set_combo_scc('imbf116','2025')
   IF g_argv[1] = '1' THEN
      CALL cl_set_comp_visible("lbl_imbf114,imbf114",FALSE)
      CALL cl_set_comp_visible("lbl_imbf115,imbf115",FALSE)
      CALL cl_set_comp_visible("lbl_imbf116,imbf116",FALSE)
      CALL cl_set_comp_visible("lbl_imbf122,imbf122",FALSE)
      CALL cl_set_comp_visible("lbl_imba143,imba143,imba143_desc",FALSE)  #160513-00009#1 Add By Ken 160513
   #150404-00001#1 150408 pomelo add(s)
   ELSE
      CALL cl_set_comp_visible("lbl_imba113,imba113",FALSE)
      CALL cl_set_comp_visible("page_4",FALSE)
   #150404-00001#1 150408 pomelo add(e)
   END IF
   #150122-00013#1 150304 pomelo add (e)
   
   #160408-00021#1 Modify By Ken 160411(S) 原本的傳秤因子只取編號，改取編號加說明
   ##ken---add---s 需求單號：141224-00014 項次：1
   #LET l_values = NULL
   #LET l_items = NULL
   #LET l_gzcb002 = NULL
   #
   #DECLARE i110_gzcb_cs CURSOR FOR
   # SELECT gzcb002 FROM gzcb_t
   #  WHERE gzcb001 = '6749'  
   #  ORDER BY gzcb002
   #FOREACH i110_gzcb_cs INTO l_gzcb002
   #   LET l_values = l_values CLIPPED ,",",l_gzcb002
   #   LET l_items  = l_items CLIPPED ,",",l_gzcb002
   #END FOREACH
   #CALL cl_set_combo_items("imba113",l_values,l_items)
   #CALL cl_set_combo_items("imby018",l_values,l_items)
   ##ken---add---e
   CALL cl_set_combo_scc('imba113','6749')
   CALL cl_set_combo_scc('imby018','6749')   
   #160408-00021#1 Modify By Ken 160411(E)
   
   
   CALL cl_set_combo_scc_part('imba004','1001','E,M')  #ken---add 20150302
   CALL cl_set_combo_scc('b_imba000','32') 
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aim", "aimm200_01"), "grid_feature", "Table", "s_detail1_aimm200_01")   #lori522612  150126 add---嵌入產品特徵值
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #CALL s_display_rtda001(g_prog,'imba010') #Mark By Ken 150318
   CALL s_life_cycle_display(g_prog,'imba010','1') #Add By Ken 150318 
#   CALL cl_set_combo_scc('l_imbf064','1014') #150427-00001#2 Add By Ken 150506 #150614-00020#1 20150617 mark by beckxie
   CALL cl_set_combo_scc('imbf064','1014')   #150614-00020#1 20150617 add by beckxie
   #CALL cl_set_combo_scc_part('imba109','6553','1,4,5')#Add By geza 150401   #160604-00009#91 dongsz mark
   CALL cl_set_combo_scc_part('imba109','6553','1,4,5,8,9,10')     #160604-00009#91 dongsz add
   CALL s_aooi390_cre_tmp_table() RETURNING l_success  #add by ken 20150522 增加編碼功能
   #160801-00017#4 20160805 mark by beckxie---S
   #CALL cl_set_combo_scc_part('imba100','2003','1,2') #add by geza 20160607 
   #CALL cl_set_combo_scc_part('imby002','2003','1,2') #add by geza 20160607 
   #160801-00017#4 20160805 mark by beckxie---E
   #160801-00017#4 20160805 add by beckxie---S
   CALL artt300_set_comp_visible_b()
   CALL artt300_set_comp_no_visible_b()
   #160801-00017#4 20160805 add by beckxie---E
   #end add-point
   
   #初始化搜尋條件
   CALL artt300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt300_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
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
            CALL artt300_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            IF NOT g_master_insert THEN
              #如aimt300_01 子程式尚未修正 均需做這項操作
              DISPLAY "imbadocno:",g_imba_m.imbadocno
              DELETE FROM imbk_t
               WHERE imbkent = g_enterprise
                 AND imbkdocno = g_imba_m.imbadocno 
            END IF 
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
            
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_touch = 1   #150915-00006#1 20150915 add by beckxie
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imba_m.* TO NULL
         CALL g_imby_d.clear()
         CALL g_imby2_d.clear()
         CALL g_imby3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt300_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL artt300_fetch('') # reload data
               LET l_ac = 1
               CALL artt300_ui_detailshow() #Setting the current row 
         
               CALL artt300_idx_chk()
               #NEXT FIELD imby003
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imby_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt300_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL artt300_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                              
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_imby2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL artt300_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imby3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL artt300_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG aim_aimm200_01.aimm200_01_display   #lori522612  150126 add---嵌入產品特徵值         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL artt300_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL artt300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                        
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt300_set_act_visible()   
            CALL artt300_set_act_no_visible()
            IF NOT (g_imba_m.imbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                                  " imbadocno = '", g_imba_m.imbadocno, "' "
 
               #填到對應位置
               CALL artt300_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imby_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbz_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbo_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL artt300_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imby_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbz_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbo_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL artt300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt300_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL artt300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt300_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_imby_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imby2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_imby3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[4] = base.typeInfo.create(global_g_imak_d)
                  LET g_export_id[4]   = "s_detail1_aimm200_01"                                                    
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD imby003
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL artt300_modify()
               #add-point:ON ACTION modify name="menu.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page5
            LET g_action_choice="touch_page5"
            IF cl_auth_chk_act("touch_page5") THEN
               
               #add-point:ON ACTION touch_page5 name="menu.touch_page5"
               LET g_touch = 5   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt300_delete()
               #add-point:ON ACTION delete name="menu.delete"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               IF NOT g_master_insert THEN
                 #如aimt300_01 子程式尚未修正 均需做這項操作
                 DISPLAY "imbadocno:",g_imba_m.imbadocno
                 DELETE FROM imbk_t
                  WHERE imbkent = g_enterprise
                    AND imbkdocno = g_imba_m.imbadocno 
               END IF          
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_imba001
            LET g_action_choice="modify_imba001"
            IF cl_auth_chk_act("modify_imba001") THEN
               
               #add-point:ON ACTION modify_imba001 name="menu.modify_imba001"
               CALL artt300_input1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                              
               #END add-point
               &include "erp/art/artt300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                              
               #END add-point
               &include "erp/art/artt300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt300_query()
               #add-point:ON ACTION query name="menu.query"
                              
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page2
            LET g_action_choice="touch_page2"
            IF cl_auth_chk_act("touch_page2") THEN
               
               #add-point:ON ACTION touch_page2 name="menu.touch_page2"
               LET g_touch = 2   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt300_01
            LET g_action_choice="open_aimt300_01"
            IF cl_auth_chk_act("open_aimt300_01") THEN
               
               #add-point:ON ACTION open_aimt300_01 name="menu.open_aimt300_01"
               IF NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imba_m.imba001) AND NOT cl_null(g_imba_m.imba005) THEN
                  IF NOT artt300_ins_imbk() THEN
                     LET g_imba_m.imba005 = g_imba_m_o.imba005
                  END IF
                  CALL aimt300_01(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba005)
                  IF INT_FLAG THEN
                     LET INT_FLAG = 0
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_next
            LET g_action_choice="image_next"
               
               #add-point:ON ACTION image_next name="menu.image_next"
               DISPLAY cl_doc_set_pic_seq(TRUE) TO ffimage   #lori522612  150126 add
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
            IF cl_auth_chk_act("touch_page1") THEN
               
               #add-point:ON ACTION touch_page1 name="menu.touch_page1"
               LET g_touch = 1   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page4
            LET g_action_choice="touch_page4"
            IF cl_auth_chk_act("touch_page4") THEN
               
               #add-point:ON ACTION touch_page4 name="menu.touch_page4"
               LET g_touch = 4   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_previous
            LET g_action_choice="image_previous"
               
               #add-point:ON ACTION image_previous name="menu.image_previous"
               DISPLAY cl_doc_set_pic_seq(FALSE) TO ffimage   #lori522612  150126 add
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page3
            LET g_action_choice="touch_page3"
            IF cl_auth_chk_act("touch_page3") THEN
               
               #add-point:ON ACTION touch_page3 name="menu.touch_page3"
               LET g_touch = 3   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page6
            LET g_action_choice="touch_page6"
            IF cl_auth_chk_act("touch_page6") THEN
               
               #add-point:ON ACTION touch_page6 name="menu.touch_page6"
               LET g_touch = 6   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page7
            LET g_action_choice="touch_page7"
            IF cl_auth_chk_act("touch_page7") THEN
               
               #add-point:ON ACTION touch_page7 name="menu.touch_page7"
               LET g_touch = 7   #150915-00006#1 20150915 add by beckxie
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_imba_m.imbadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="artt300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt300_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_join_sql        STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #lori522612  150126 add -----------------------(S)
   #清除嵌入子單身:產品特徵值
   IF cl_null(g_add_browse) THEN
      CALL aimm200_01_clear_detail()  
   END IF
   #lori522612  150126 add -----------------------(E)
   
   #150122-00013#1 150304 pomelo add (s)
#   LET l_join_sql = "   "     #150614-00020#1 20150617 mark by beckxie
#   IF g_argv[01] = '2' THEN   #150614-00020#1 20150617 mark by beckxie
      LET l_join_sql = " LEFT OUTER JOIN imbf_t ON imbfent = imbaent",
                       "                       AND imbfsite = 'ALL'",
                       "                       AND imbfdocno = imbadocno"
#   END IF                     #150614-00020#1 20150617 add by beckxie
   #150122-00013#1 150304 pomelo add (e)
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT imbadocno ",
                      " FROM imba_t ",
                      " ",
                      " LEFT JOIN imby_t ON imbyent = imbaent AND imbadocno = imbydocno ", "  ",
                      #add-point:browser_fill段sql(imby_t1) name="browser_fill.cnt.join.}"
 
                      #end add-point
                      " LEFT JOIN imbz_t ON imbzent = imbaent AND imbadocno = imbzdocno", "  ",
                      #add-point:browser_fill段sql(imbz_t1) name="browser_fill.cnt.join.imbz_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imbo_t ON imboent = imbaent AND imbadocno = imbodocno", "  ",
                      #add-point:browser_fill段sql(imbo_t1) name="browser_fill.cnt.join.imbo_t1"
                      #150122-00013#1 150304 pomelo add (s)
                      l_join_sql,
                      #150122-00013#1 150304 pomelo add (e)
                      #end add-point
 
 
 
                      " LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE imbaent = " ||g_enterprise|| " AND imbyent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imbadocno ",
                      " FROM imba_t ", 
                      "  ",
                      "  LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
                      " WHERE imbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imba_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
 
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
      
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_imba_m.* TO NULL
      CALL g_imby_d.clear()        
      CALL g_imby2_d.clear() 
      CALL g_imby3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imbadocno,t0.imba000,t0.imba001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imbastus,t0.imbadocno,t0.imba000,t0.imba001,t1.imbal002 ",
                  " FROM imba_t t0",
                  "  ",
                  "  LEFT JOIN imby_t ON imbyent = imbaent AND imbadocno = imbydocno ", "  ", 
                  #add-point:browser_fill段sql(imby_t1) name="browser_fill.join.imby_t1"
                  
                  #end add-point
                  "  LEFT JOIN imbz_t ON imbzent = imbaent AND imbadocno = imbzdocno", "  ", 
                  #add-point:browser_fill段sql(imbz_t1) name="browser_fill.join.imbz_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imbo_t ON imboent = imbaent AND imbadocno = imbodocno", "  ", 
                  #add-point:browser_fill段sql(imbo_t1) name="browser_fill.join.imbo_t1"
               #150122-00013#1 150304 pomelo add (s)
               l_join_sql,
               #150122-00013#1 150304 pomelo add (e)
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN imbal_t t1 ON t1.imbalent="||g_enterprise||" AND t1.imbaldocno=t0.imbadocno AND t1.imbal001='"||g_dlang||"' ",
 
                  " WHERE t0.imbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imbastus,t0.imbadocno,t0.imba000,t0.imba001,t1.imbal002 ",
                  " FROM imba_t t0",
                  "  ",
                                 " LEFT JOIN imbal_t t1 ON t1.imbalent="||g_enterprise||" AND t1.imbaldocno=t0.imbadocno AND t1.imbal001='"||g_dlang||"' ",
 
                  " WHERE t0.imbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
 
   #end add-point
   LET g_sql = g_sql, " ORDER BY imbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
      
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imbadocno,g_browser[g_cnt].b_imba000, 
          g_browser[g_cnt].b_imba001,g_browser[g_cnt].b_imbadocno_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      #150311-00014#2 Add-S By Ken 150318 原browser的規格欄位是reference 改為FORMONLY再抓值
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imbadocno
      CALL ap_ref_array2(g_ref_fields," SELECT imbal003 FROM imbal_t WHERE imbalent = '"||g_enterprise||"' AND  imbaldocno = ? AND imbal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields  #160905-00007#14 add  imbalent = '"||g_enterprise||"'
      LET g_browser[g_cnt].b_imbadocno_desc_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_imbadocno_desc_desc
      #150311-00014#2 Add-E            
         #end add-point
      
         #遮罩相關處理
         CALL artt300_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
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
   
   IF cl_null(g_browser[g_cnt].b_imbadocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
      
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imba_m.imbadocno = g_browser[g_current_idx].b_imbadocno   
 
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
   CALL artt300_imba_t_mask()
   CALL artt300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt300_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
      
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
      
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
      
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt300_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_imbadocno = g_imba_m.imbadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt300_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_imba_m.* TO NULL
   CALL g_imby_d.clear()        
   CALL g_imby2_d.clear() 
   CALL g_imby3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL aimm200_01_clear_detail()   #lori522612  150126 add---嵌入產品特徵值    
   #查询时生命周期下拉框
   CALL s_life_cycle_display('ALL','imba010','1') #Add By geza 150323 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON imba000,imbadocno,imbadocdt,imba001,imbal002,imbal003,imbal004,imba003, 
          imba108,imba004,imba100,imba109,imba014,imba002,imba006,imba105,imba104,imba107,imba106,imba145, 
          imba146,imba113,imba005,imba142,imbaacti,imba019,imba020,imba021,imba022,imba025,imba026,imba016, 
          imba018,imba010,imbastus,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid,imbamoddt, 
          imbacnfid,imbacnfdt,imba009,imba161,imba101,imba118,imba119,imba120,imba114,imba115,imba116, 
          imba117,imba124,imba124_desc,imbf122,imbf115,imbf114,imbf116,imba110,imba111,imba112,imba125, 
          imba121,imba144,imba122,imba123,imba131,imba126,imba127,imba128,imba129,imba143,imba130,imba150, 
          imba151,imba152,imba153,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140, 
          imba141,imbf061,imbf062,imbf063,imbf064,imba149,imba102,imba103,imba147,imba148
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imbacrtdt>>----
         AFTER FIELD imbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imbamoddt>>----
         AFTER FIELD imbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbacnfdt>>----
         AFTER FIELD imbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba000
            #add-point:BEFORE FIELD imba000 name="construct.b.imba000"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba000
            
            #add-point:AFTER FIELD imba000 name="construct.a.imba000"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba000
            #add-point:ON ACTION controlp INFIELD imba000 name="construct.c.imba000"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocno
            #add-point:ON ACTION controlp INFIELD imbadocno name="construct.c.imbadocno"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbadocno  #顯示到畫面上

            NEXT FIELD imbadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocno
            #add-point:BEFORE FIELD imbadocno name="construct.b.imbadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocno
            
            #add-point:AFTER FIELD imbadocno name="construct.a.imbadocno"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocdt
            #add-point:BEFORE FIELD imbadocdt name="construct.b.imbadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocdt
            
            #add-point:AFTER FIELD imbadocdt name="construct.a.imbadocdt"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocdt
            #add-point:ON ACTION controlp INFIELD imbadocdt name="construct.c.imbadocdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="construct.c.imba001"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba001  #顯示到畫面上

            NEXT FIELD imba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="construct.b.imba001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="construct.a.imba001"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="construct.b.imbal002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="construct.a.imbal002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="construct.c.imbal002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="construct.b.imbal003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="construct.a.imbal003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="construct.c.imbal003"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="construct.b.imbal004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="construct.a.imbal004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="construct.c.imbal004"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba003
            #add-point:ON ACTION controlp INFIELD imba003 name="construct.c.imba003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imck001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba003  #顯示到畫面上

            NEXT FIELD imba003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba003
            #add-point:BEFORE FIELD imba003 name="construct.b.imba003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba003
            
            #add-point:AFTER FIELD imba003 name="construct.a.imba003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba108
            #add-point:BEFORE FIELD imba108 name="construct.b.imba108"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba108
            
            #add-point:AFTER FIELD imba108 name="construct.a.imba108"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba108
            #add-point:ON ACTION controlp INFIELD imba108 name="construct.c.imba108"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba004
            #add-point:BEFORE FIELD imba004 name="construct.b.imba004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba004
            
            #add-point:AFTER FIELD imba004 name="construct.a.imba004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba004
            #add-point:ON ACTION controlp INFIELD imba004 name="construct.c.imba004"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba100
            #add-point:BEFORE FIELD imba100 name="construct.b.imba100"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba100
            
            #add-point:AFTER FIELD imba100 name="construct.a.imba100"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba100
            #add-point:ON ACTION controlp INFIELD imba100 name="construct.c.imba100"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba109
            #add-point:BEFORE FIELD imba109 name="construct.b.imba109"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba109
            
            #add-point:AFTER FIELD imba109 name="construct.a.imba109"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba109
            #add-point:ON ACTION controlp INFIELD imba109 name="construct.c.imba109"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba014
            #add-point:BEFORE FIELD imba014 name="construct.b.imba014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba014
            
            #add-point:AFTER FIELD imba014 name="construct.a.imba014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba014
            #add-point:ON ACTION controlp INFIELD imba014 name="construct.c.imba014"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="construct.b.imba002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            
            #add-point:AFTER FIELD imba002 name="construct.a.imba002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="construct.c.imba002"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba006
            #add-point:ON ACTION controlp INFIELD imba006 name="construct.c.imba006"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba006  #顯示到畫面上

            NEXT FIELD imba006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba006
            #add-point:BEFORE FIELD imba006 name="construct.b.imba006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba006
            
            #add-point:AFTER FIELD imba006 name="construct.a.imba006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba105
            #add-point:ON ACTION controlp INFIELD imba105 name="construct.c.imba105"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba105  #顯示到畫面上

            NEXT FIELD imba105                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba105
            #add-point:BEFORE FIELD imba105 name="construct.b.imba105"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba105
            
            #add-point:AFTER FIELD imba105 name="construct.a.imba105"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba104
            #add-point:ON ACTION controlp INFIELD imba104 name="construct.c.imba104"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba104  #顯示到畫面上

            NEXT FIELD imba104                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba104
            #add-point:BEFORE FIELD imba104 name="construct.b.imba104"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba104
            
            #add-point:AFTER FIELD imba104 name="construct.a.imba104"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba107
            #add-point:ON ACTION controlp INFIELD imba107 name="construct.c.imba107"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba107  #顯示到畫面上

            NEXT FIELD imba107                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba107
            #add-point:BEFORE FIELD imba107 name="construct.b.imba107"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba107
            
            #add-point:AFTER FIELD imba107 name="construct.a.imba107"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba106
            #add-point:ON ACTION controlp INFIELD imba106 name="construct.c.imba106"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba106  #顯示到畫面上

            NEXT FIELD imba106                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba106
            #add-point:BEFORE FIELD imba106 name="construct.b.imba106"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba106
            
            #add-point:AFTER FIELD imba106 name="construct.a.imba106"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba145
            #add-point:ON ACTION controlp INFIELD imba145 name="construct.c.imba145"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba145  #顯示到畫面上
            NEXT FIELD imba145                     #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba145
            #add-point:BEFORE FIELD imba145 name="construct.b.imba145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba145
            
            #add-point:AFTER FIELD imba145 name="construct.a.imba145"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba146
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba146
            #add-point:ON ACTION controlp INFIELD imba146 name="construct.c.imba146"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba146  #顯示到畫面上
            NEXT FIELD imba146                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba146
            #add-point:BEFORE FIELD imba146 name="construct.b.imba146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba146
            
            #add-point:AFTER FIELD imba146 name="construct.a.imba146"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba113
            #add-point:BEFORE FIELD imba113 name="construct.b.imba113"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba113
            
            #add-point:AFTER FIELD imba113 name="construct.a.imba113"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba113
            #add-point:ON ACTION controlp INFIELD imba113 name="construct.c.imba113"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba005
            #add-point:ON ACTION controlp INFIELD imba005 name="construct.c.imba005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_imea001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba005  #顯示到畫面上
            NEXT FIELD imba005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba005
            #add-point:BEFORE FIELD imba005 name="construct.b.imba005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba005
            
            #add-point:AFTER FIELD imba005 name="construct.a.imba005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba142
            #add-point:ON ACTION controlp INFIELD imba142 name="construct.c.imba142"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba142
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'imbaunit',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO imba142          #顯示到畫面上
            NEXT FIELD imba142                             #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba142
            #add-point:BEFORE FIELD imba142 name="construct.b.imba142"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba142
            
            #add-point:AFTER FIELD imba142 name="construct.a.imba142"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaacti
            #add-point:BEFORE FIELD imbaacti name="construct.b.imbaacti"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaacti
            
            #add-point:AFTER FIELD imbaacti name="construct.a.imbaacti"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaacti
            #add-point:ON ACTION controlp INFIELD imbaacti name="construct.c.imbaacti"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba019
            #add-point:BEFORE FIELD imba019 name="construct.b.imba019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba019
            
            #add-point:AFTER FIELD imba019 name="construct.a.imba019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba019
            #add-point:ON ACTION controlp INFIELD imba019 name="construct.c.imba019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba020
            #add-point:BEFORE FIELD imba020 name="construct.b.imba020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba020
            
            #add-point:AFTER FIELD imba020 name="construct.a.imba020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba020
            #add-point:ON ACTION controlp INFIELD imba020 name="construct.c.imba020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba021
            #add-point:BEFORE FIELD imba021 name="construct.b.imba021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba021
            
            #add-point:AFTER FIELD imba021 name="construct.a.imba021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba021
            #add-point:ON ACTION controlp INFIELD imba021 name="construct.c.imba021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba022
            #add-point:ON ACTION controlp INFIELD imba022 name="construct.c.imba022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba022  #顯示到畫面上
            NEXT FIELD imba022                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba022
            #add-point:BEFORE FIELD imba022 name="construct.b.imba022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba022
            
            #add-point:AFTER FIELD imba022 name="construct.a.imba022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba025
            #add-point:BEFORE FIELD imba025 name="construct.b.imba025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba025
            
            #add-point:AFTER FIELD imba025 name="construct.a.imba025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba025
            #add-point:ON ACTION controlp INFIELD imba025 name="construct.c.imba025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba026
            #add-point:ON ACTION controlp INFIELD imba026 name="construct.c.imba026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba026  #顯示到畫面上
            NEXT FIELD imba026                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba026
            #add-point:BEFORE FIELD imba026 name="construct.b.imba026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba026
            
            #add-point:AFTER FIELD imba026 name="construct.a.imba026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba016
            #add-point:BEFORE FIELD imba016 name="construct.b.imba016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba016
            
            #add-point:AFTER FIELD imba016 name="construct.a.imba016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba016
            #add-point:ON ACTION controlp INFIELD imba016 name="construct.c.imba016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba018
            #add-point:ON ACTION controlp INFIELD imba018 name="construct.c.imba018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba018  #顯示到畫面上
            NEXT FIELD imba018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba018
            #add-point:BEFORE FIELD imba018 name="construct.b.imba018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba018
            
            #add-point:AFTER FIELD imba018 name="construct.a.imba018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba010
            #add-point:ON ACTION controlp INFIELD imba010 name="construct.c.imba010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba010  #顯示到畫面上
            NEXT FIELD imba010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba010
            #add-point:BEFORE FIELD imba010 name="construct.b.imba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba010
            
            #add-point:AFTER FIELD imba010 name="construct.a.imba010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbastus
            #add-point:BEFORE FIELD imbastus name="construct.b.imbastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbastus
            
            #add-point:AFTER FIELD imbastus name="construct.a.imbastus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbastus
            #add-point:ON ACTION controlp INFIELD imbastus name="construct.c.imbastus"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaownid
            #add-point:ON ACTION controlp INFIELD imbaownid name="construct.c.imbaownid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbaownid  #顯示到畫面上

            NEXT FIELD imbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaownid
            #add-point:BEFORE FIELD imbaownid name="construct.b.imbaownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaownid
            
            #add-point:AFTER FIELD imbaownid name="construct.a.imbaownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaowndp
            #add-point:ON ACTION controlp INFIELD imbaowndp name="construct.c.imbaowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbaowndp  #顯示到畫面上

            NEXT FIELD imbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaowndp
            #add-point:BEFORE FIELD imbaowndp name="construct.b.imbaowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaowndp
            
            #add-point:AFTER FIELD imbaowndp name="construct.a.imbaowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacrtid
            #add-point:ON ACTION controlp INFIELD imbacrtid name="construct.c.imbacrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacrtid  #顯示到畫面上

            NEXT FIELD imbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtid
            #add-point:BEFORE FIELD imbacrtid name="construct.b.imbacrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacrtid
            
            #add-point:AFTER FIELD imbacrtid name="construct.a.imbacrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacrtdp
            #add-point:ON ACTION controlp INFIELD imbacrtdp name="construct.c.imbacrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacrtdp  #顯示到畫面上

            NEXT FIELD imbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtdp
            #add-point:BEFORE FIELD imbacrtdp name="construct.b.imbacrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacrtdp
            
            #add-point:AFTER FIELD imbacrtdp name="construct.a.imbacrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtdt
            #add-point:BEFORE FIELD imbacrtdt name="construct.b.imbacrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbamodid
            #add-point:ON ACTION controlp INFIELD imbamodid name="construct.c.imbamodid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbamodid  #顯示到畫面上

            NEXT FIELD imbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbamodid
            #add-point:BEFORE FIELD imbamodid name="construct.b.imbamodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbamodid
            
            #add-point:AFTER FIELD imbamodid name="construct.a.imbamodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbamoddt
            #add-point:BEFORE FIELD imbamoddt name="construct.b.imbamoddt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacnfid
            #add-point:ON ACTION controlp INFIELD imbacnfid name="construct.c.imbacnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacnfid  #顯示到畫面上

            NEXT FIELD imbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacnfid
            #add-point:BEFORE FIELD imbacnfid name="construct.b.imbacnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacnfid
            
            #add-point:AFTER FIELD imbacnfid name="construct.a.imbacnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacnfdt
            #add-point:BEFORE FIELD imbacnfdt name="construct.b.imbacnfdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba009
            #add-point:ON ACTION controlp INFIELD imba009 name="construct.c.imba009"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba009  #顯示到畫面上

            NEXT FIELD imba009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba009
            #add-point:BEFORE FIELD imba009 name="construct.b.imba009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba009
            
            #add-point:AFTER FIELD imba009 name="construct.a.imba009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba161
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba161
            #add-point:ON ACTION controlp INFIELD imba161 name="construct.c.imba161"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160705-00013#3 160712 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_pcba001()
            
            DISPLAY g_qryparam.return1 TO imba161  
            NEXT FIELD imba161   
            #160705-00013#3 160712 by lori add---(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba161
            #add-point:BEFORE FIELD imba161 name="construct.b.imba161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba161
            
            #add-point:AFTER FIELD imba161 name="construct.a.imba161"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba101
            #add-point:ON ACTION controlp INFIELD imba101 name="construct.c.imba101"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba101  #顯示到畫面上

            NEXT FIELD imba101                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba101
            #add-point:BEFORE FIELD imba101 name="construct.b.imba101"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba101
            
            #add-point:AFTER FIELD imba101 name="construct.a.imba101"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba118
            #add-point:BEFORE FIELD imba118 name="construct.b.imba118"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba118
            
            #add-point:AFTER FIELD imba118 name="construct.a.imba118"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba118
            #add-point:ON ACTION controlp INFIELD imba118 name="construct.c.imba118"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba119
            #add-point:BEFORE FIELD imba119 name="construct.b.imba119"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba119
            
            #add-point:AFTER FIELD imba119 name="construct.a.imba119"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba119
            #add-point:ON ACTION controlp INFIELD imba119 name="construct.c.imba119"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba120
            #add-point:BEFORE FIELD imba120 name="construct.b.imba120"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba120
            
            #add-point:AFTER FIELD imba120 name="construct.a.imba120"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba120
            #add-point:ON ACTION controlp INFIELD imba120 name="construct.c.imba120"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba114
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba114
            #add-point:ON ACTION controlp INFIELD imba114 name="construct.c.imba114"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba114  #顯示到畫面上

            NEXT FIELD imba114                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba114
            #add-point:BEFORE FIELD imba114 name="construct.b.imba114"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba114
            
            #add-point:AFTER FIELD imba114 name="construct.a.imba114"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba115
            #add-point:BEFORE FIELD imba115 name="construct.b.imba115"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba115
            
            #add-point:AFTER FIELD imba115 name="construct.a.imba115"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba115
            #add-point:ON ACTION controlp INFIELD imba115 name="construct.c.imba115"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba116
            #add-point:BEFORE FIELD imba116 name="construct.b.imba116"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba116
            
            #add-point:AFTER FIELD imba116 name="construct.a.imba116"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba116
            #add-point:ON ACTION controlp INFIELD imba116 name="construct.c.imba116"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba117
            #add-point:BEFORE FIELD imba117 name="construct.b.imba117"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba117
            
            #add-point:AFTER FIELD imba117 name="construct.a.imba117"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba117
            #add-point:ON ACTION controlp INFIELD imba117 name="construct.c.imba117"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba124
            #add-point:ON ACTION controlp INFIELD imba124 name="construct.c.imba124"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba124  #顯示到畫面上

            NEXT FIELD imba124                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba124
            #add-point:BEFORE FIELD imba124 name="construct.b.imba124"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba124
            
            #add-point:AFTER FIELD imba124 name="construct.a.imba124"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba124_desc
            #add-point:BEFORE FIELD imba124_desc name="construct.b.imba124_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba124_desc
            
            #add-point:AFTER FIELD imba124_desc name="construct.a.imba124_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba124_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba124_desc
            #add-point:ON ACTION controlp INFIELD imba124_desc name="construct.c.imba124_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf122
            #add-point:BEFORE FIELD imbf122 name="construct.b.imbf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf122
            
            #add-point:AFTER FIELD imbf122 name="construct.a.imbf122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf122
            #add-point:ON ACTION controlp INFIELD imbf122 name="construct.c.imbf122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf115
            #add-point:BEFORE FIELD imbf115 name="construct.b.imbf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf115
            
            #add-point:AFTER FIELD imbf115 name="construct.a.imbf115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf115
            #add-point:ON ACTION controlp INFIELD imbf115 name="construct.c.imbf115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf114
            #add-point:BEFORE FIELD imbf114 name="construct.b.imbf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf114
            
            #add-point:AFTER FIELD imbf114 name="construct.a.imbf114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf114
            #add-point:ON ACTION controlp INFIELD imbf114 name="construct.c.imbf114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf116
            #add-point:BEFORE FIELD imbf116 name="construct.b.imbf116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf116
            
            #add-point:AFTER FIELD imbf116 name="construct.a.imbf116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf116
            #add-point:ON ACTION controlp INFIELD imbf116 name="construct.c.imbf116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba110
            #add-point:BEFORE FIELD imba110 name="construct.b.imba110"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba110
            
            #add-point:AFTER FIELD imba110 name="construct.a.imba110"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba110
            #add-point:ON ACTION controlp INFIELD imba110 name="construct.c.imba110"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba111
            #add-point:BEFORE FIELD imba111 name="construct.b.imba111"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba111
            
            #add-point:AFTER FIELD imba111 name="construct.a.imba111"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba111
            #add-point:ON ACTION controlp INFIELD imba111 name="construct.c.imba111"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba112
            #add-point:BEFORE FIELD imba112 name="construct.b.imba112"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba112
            
            #add-point:AFTER FIELD imba112 name="construct.a.imba112"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba112
            #add-point:ON ACTION controlp INFIELD imba112 name="construct.c.imba112"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba125
            #add-point:BEFORE FIELD imba125 name="construct.b.imba125"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba125
            
            #add-point:AFTER FIELD imba125 name="construct.a.imba125"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba125
            #add-point:ON ACTION controlp INFIELD imba125 name="construct.c.imba125"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba121
            #add-point:BEFORE FIELD imba121 name="construct.b.imba121"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba121
            
            #add-point:AFTER FIELD imba121 name="construct.a.imba121"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba121
            #add-point:ON ACTION controlp INFIELD imba121 name="construct.c.imba121"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba144
            #add-point:BEFORE FIELD imba144 name="construct.b.imba144"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba144
            
            #add-point:AFTER FIELD imba144 name="construct.a.imba144"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba144
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba144
            #add-point:ON ACTION controlp INFIELD imba144 name="construct.c.imba144"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba122
            #add-point:ON ACTION controlp INFIELD imba122 name="construct.c.imba122"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2000'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba122  #顯示到畫面上

            NEXT FIELD imba122                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba122
            #add-point:BEFORE FIELD imba122 name="construct.b.imba122"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba122
            
            #add-point:AFTER FIELD imba122 name="construct.a.imba122"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba123
            #add-point:BEFORE FIELD imba123 name="construct.b.imba123"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba123
            
            #add-point:AFTER FIELD imba123 name="construct.a.imba123"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba123
            #add-point:ON ACTION controlp INFIELD imba123 name="construct.c.imba123"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba131
            #add-point:ON ACTION controlp INFIELD imba131 name="construct.c.imba131"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2001'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba131  #顯示到畫面上

            NEXT FIELD imba131                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba131
            #add-point:BEFORE FIELD imba131 name="construct.b.imba131"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba131
            
            #add-point:AFTER FIELD imba131 name="construct.a.imba131"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba126
            #add-point:ON ACTION controlp INFIELD imba126 name="construct.c.imba126"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba126  #顯示到畫面上

            NEXT FIELD imba126                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba126
            #add-point:BEFORE FIELD imba126 name="construct.b.imba126"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba126
            
            #add-point:AFTER FIELD imba126 name="construct.a.imba126"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba127
            #add-point:ON ACTION controlp INFIELD imba127 name="construct.c.imba127"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2003'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba127  #顯示到畫面上

            NEXT FIELD imba127                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba127
            #add-point:BEFORE FIELD imba127 name="construct.b.imba127"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba127
            
            #add-point:AFTER FIELD imba127 name="construct.a.imba127"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba128
            #add-point:ON ACTION controlp INFIELD imba128 name="construct.c.imba128"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2004'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba128  #顯示到畫面上

            NEXT FIELD imba128                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba128
            #add-point:BEFORE FIELD imba128 name="construct.b.imba128"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba128
            
            #add-point:AFTER FIELD imba128 name="construct.a.imba128"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba129
            #add-point:ON ACTION controlp INFIELD imba129 name="construct.c.imba129"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2005'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba129  #顯示到畫面上

            NEXT FIELD imba129                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba129
            #add-point:BEFORE FIELD imba129 name="construct.b.imba129"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba129
            
            #add-point:AFTER FIELD imba129 name="construct.a.imba129"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba143
            #add-point:ON ACTION controlp INFIELD imba143 name="construct.c.imba143"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba143  #顯示到畫面上
            NEXT FIELD imba143                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba143
            #add-point:BEFORE FIELD imba143 name="construct.b.imba143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba143
            
            #add-point:AFTER FIELD imba143 name="construct.a.imba143"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba130
            #add-point:BEFORE FIELD imba130 name="construct.b.imba130"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba130
            
            #add-point:AFTER FIELD imba130 name="construct.a.imba130"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba130
            #add-point:ON ACTION controlp INFIELD imba130 name="construct.c.imba130"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba150
            #add-point:BEFORE FIELD imba150 name="construct.b.imba150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba150
            
            #add-point:AFTER FIELD imba150 name="construct.a.imba150"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba150
            #add-point:ON ACTION controlp INFIELD imba150 name="construct.c.imba150"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba151
            #add-point:BEFORE FIELD imba151 name="construct.b.imba151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba151
            
            #add-point:AFTER FIELD imba151 name="construct.a.imba151"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba151
            #add-point:ON ACTION controlp INFIELD imba151 name="construct.c.imba151"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba152
            #add-point:BEFORE FIELD imba152 name="construct.b.imba152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba152
            
            #add-point:AFTER FIELD imba152 name="construct.a.imba152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba152
            #add-point:ON ACTION controlp INFIELD imba152 name="construct.c.imba152"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba153
            #add-point:BEFORE FIELD imba153 name="construct.b.imba153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba153
            
            #add-point:AFTER FIELD imba153 name="construct.a.imba153"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba153
            #add-point:ON ACTION controlp INFIELD imba153 name="construct.c.imba153"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba132
            #add-point:ON ACTION controlp INFIELD imba132 name="construct.c.imba132"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2006'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba132  #顯示到畫面上

            NEXT FIELD imba132                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba132
            #add-point:BEFORE FIELD imba132 name="construct.b.imba132"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba132
            
            #add-point:AFTER FIELD imba132 name="construct.a.imba132"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba133
            #add-point:ON ACTION controlp INFIELD imba133 name="construct.c.imba133"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2007'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba133  #顯示到畫面上

            NEXT FIELD imba133                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba133
            #add-point:BEFORE FIELD imba133 name="construct.b.imba133"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba133
            
            #add-point:AFTER FIELD imba133 name="construct.a.imba133"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba134
            #add-point:ON ACTION controlp INFIELD imba134 name="construct.c.imba134"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2008'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba134  #顯示到畫面上

            NEXT FIELD imba134                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba134
            #add-point:BEFORE FIELD imba134 name="construct.b.imba134"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba134
            
            #add-point:AFTER FIELD imba134 name="construct.a.imba134"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba135
            #add-point:ON ACTION controlp INFIELD imba135 name="construct.c.imba135"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2009'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba135  #顯示到畫面上

            NEXT FIELD imba135                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba135
            #add-point:BEFORE FIELD imba135 name="construct.b.imba135"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba135
            
            #add-point:AFTER FIELD imba135 name="construct.a.imba135"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba136
            #add-point:ON ACTION controlp INFIELD imba136 name="construct.c.imba136"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2010'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba136  #顯示到畫面上

            NEXT FIELD imba136                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba136
            #add-point:BEFORE FIELD imba136 name="construct.b.imba136"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba136
            
            #add-point:AFTER FIELD imba136 name="construct.a.imba136"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba137
            #add-point:ON ACTION controlp INFIELD imba137 name="construct.c.imba137"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2011'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba137  #顯示到畫面上

            NEXT FIELD imba137                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba137
            #add-point:BEFORE FIELD imba137 name="construct.b.imba137"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba137
            
            #add-point:AFTER FIELD imba137 name="construct.a.imba137"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba138
            #add-point:ON ACTION controlp INFIELD imba138 name="construct.c.imba138"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2012'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba138  #顯示到畫面上

            NEXT FIELD imba138                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba138
            #add-point:BEFORE FIELD imba138 name="construct.b.imba138"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba138
            
            #add-point:AFTER FIELD imba138 name="construct.a.imba138"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba139
            #add-point:ON ACTION controlp INFIELD imba139 name="construct.c.imba139"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2013'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba139  #顯示到畫面上

            NEXT FIELD imba139                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba139
            #add-point:BEFORE FIELD imba139 name="construct.b.imba139"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba139
            
            #add-point:AFTER FIELD imba139 name="construct.a.imba139"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba140
            #add-point:ON ACTION controlp INFIELD imba140 name="construct.c.imba140"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2014'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba140  #顯示到畫面上

            NEXT FIELD imba140                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba140
            #add-point:BEFORE FIELD imba140 name="construct.b.imba140"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba140
            
            #add-point:AFTER FIELD imba140 name="construct.a.imba140"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba141
            #add-point:ON ACTION controlp INFIELD imba141 name="construct.c.imba141"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2015'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba141  #顯示到畫面上

            NEXT FIELD imba141                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba141
            #add-point:BEFORE FIELD imba141 name="construct.b.imba141"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba141
            
            #add-point:AFTER FIELD imba141 name="construct.a.imba141"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf061
            #add-point:BEFORE FIELD imbf061 name="construct.b.imbf061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf061
            
            #add-point:AFTER FIELD imbf061 name="construct.a.imbf061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf061
            #add-point:ON ACTION controlp INFIELD imbf061 name="construct.c.imbf061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf062
            #add-point:BEFORE FIELD imbf062 name="construct.b.imbf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf062
            
            #add-point:AFTER FIELD imbf062 name="construct.a.imbf062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf062
            #add-point:ON ACTION controlp INFIELD imbf062 name="construct.c.imbf062"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imbf063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf063
            #add-point:ON ACTION controlp INFIELD imbf063 name="construct.c.imbf063"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "6"
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbf063  #顯示到畫面上
            NEXT FIELD imbf063                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf063
            #add-point:BEFORE FIELD imbf063 name="construct.b.imbf063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf063
            
            #add-point:AFTER FIELD imbf063 name="construct.a.imbf063"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf064
            #add-point:BEFORE FIELD imbf064 name="construct.b.imbf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf064
            
            #add-point:AFTER FIELD imbf064 name="construct.a.imbf064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf064
            #add-point:ON ACTION controlp INFIELD imbf064 name="construct.c.imbf064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba149
            #add-point:BEFORE FIELD imba149 name="construct.b.imba149"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba149
            
            #add-point:AFTER FIELD imba149 name="construct.a.imba149"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba149
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba149
            #add-point:ON ACTION controlp INFIELD imba149 name="construct.c.imba149"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba102
            #add-point:BEFORE FIELD imba102 name="construct.b.imba102"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba102
            
            #add-point:AFTER FIELD imba102 name="construct.a.imba102"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba102
            #add-point:ON ACTION controlp INFIELD imba102 name="construct.c.imba102"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba103
            #add-point:BEFORE FIELD imba103 name="construct.b.imba103"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba103
            
            #add-point:AFTER FIELD imba103 name="construct.a.imba103"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba103
            #add-point:ON ACTION controlp INFIELD imba103 name="construct.c.imba103"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba147
            #add-point:BEFORE FIELD imba147 name="construct.b.imba147"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba147
            
            #add-point:AFTER FIELD imba147 name="construct.a.imba147"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba147
            #add-point:ON ACTION controlp INFIELD imba147 name="construct.c.imba147"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba148
            #add-point:BEFORE FIELD imba148 name="construct.b.imba148"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba148
            
            #add-point:AFTER FIELD imba148 name="construct.a.imba148"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba148
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba148
            #add-point:ON ACTION controlp INFIELD imba148 name="construct.c.imba148"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imby001,imbystus,imby002,imby019,imby019_desc,imby003,imby004,imby005, 
          imby006,imby018,imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012,imby013, 
          imby014
           FROM s_detail1[1].imby001,s_detail1[1].imbystus,s_detail1[1].imby002,s_detail1[1].imby019, 
               s_detail1[1].imby019_desc,s_detail1[1].imby003,s_detail1[1].imby004,s_detail1[1].imby005, 
               s_detail1[1].imby006,s_detail1[1].imby018,s_detail1[1].imby007,s_detail1[1].imby008,s_detail1[1].imby009, 
               s_detail1[1].imby015,s_detail1[1].imby010,s_detail1[1].imby016,s_detail1[1].imby011,s_detail1[1].imby017, 
               s_detail1[1].imby012,s_detail1[1].imby013,s_detail1[1].imby014
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imbycrtdt>>----
 
         #----<<imbymoddt>>----
         
         #----<<imbycnfdt>>----
         
         #----<<imbypstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby001
            #add-point:BEFORE FIELD imby001 name="construct.b.page1.imby001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby001
            
            #add-point:AFTER FIELD imby001 name="construct.a.page1.imby001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby001
            #add-point:ON ACTION controlp INFIELD imby001 name="construct.c.page1.imby001"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbystus
            #add-point:BEFORE FIELD imbystus name="construct.b.page1.imbystus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbystus
            
            #add-point:AFTER FIELD imbystus name="construct.a.page1.imbystus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imbystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbystus
            #add-point:ON ACTION controlp INFIELD imbystus name="construct.c.page1.imbystus"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby002
            #add-point:BEFORE FIELD imby002 name="construct.b.page1.imby002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby002
            
            #add-point:AFTER FIELD imby002 name="construct.a.page1.imby002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby002
            #add-point:ON ACTION controlp INFIELD imby002 name="construct.c.page1.imby002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby019
            #add-point:BEFORE FIELD imby019 name="construct.b.page1.imby019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby019
            
            #add-point:AFTER FIELD imby019 name="construct.a.page1.imby019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby019
            #add-point:ON ACTION controlp INFIELD imby019 name="construct.c.page1.imby019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby019_desc
            #add-point:BEFORE FIELD imby019_desc name="construct.b.page1.imby019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby019_desc
            
            #add-point:AFTER FIELD imby019_desc name="construct.a.page1.imby019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby019_desc
            #add-point:ON ACTION controlp INFIELD imby019_desc name="construct.c.page1.imby019_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imby003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby003
            #add-point:ON ACTION controlp INFIELD imby003 name="construct.c.page1.imby003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imby003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imby003  #顯示到畫面上

            NEXT FIELD imby003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby003
            #add-point:BEFORE FIELD imby003 name="construct.b.page1.imby003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby003
            
            #add-point:AFTER FIELD imby003 name="construct.a.page1.imby003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby004
            #add-point:ON ACTION controlp INFIELD imby004 name="construct.c.page1.imby004"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imby004  #顯示到畫面上

            NEXT FIELD imby004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby004
            #add-point:BEFORE FIELD imby004 name="construct.b.page1.imby004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby004
            
            #add-point:AFTER FIELD imby004 name="construct.a.page1.imby004"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby005
            #add-point:BEFORE FIELD imby005 name="construct.b.page1.imby005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby005
            
            #add-point:AFTER FIELD imby005 name="construct.a.page1.imby005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby005
            #add-point:ON ACTION controlp INFIELD imby005 name="construct.c.page1.imby005"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby006
            #add-point:BEFORE FIELD imby006 name="construct.b.page1.imby006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby006
            
            #add-point:AFTER FIELD imby006 name="construct.a.page1.imby006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby006
            #add-point:ON ACTION controlp INFIELD imby006 name="construct.c.page1.imby006"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby018
            #add-point:BEFORE FIELD imby018 name="construct.b.page1.imby018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby018
            
            #add-point:AFTER FIELD imby018 name="construct.a.page1.imby018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby018
            #add-point:ON ACTION controlp INFIELD imby018 name="construct.c.page1.imby018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby007
            #add-point:BEFORE FIELD imby007 name="construct.b.page1.imby007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby007
            
            #add-point:AFTER FIELD imby007 name="construct.a.page1.imby007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby007
            #add-point:ON ACTION controlp INFIELD imby007 name="construct.c.page1.imby007"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby008
            #add-point:BEFORE FIELD imby008 name="construct.b.page1.imby008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby008
            
            #add-point:AFTER FIELD imby008 name="construct.a.page1.imby008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby008
            #add-point:ON ACTION controlp INFIELD imby008 name="construct.c.page1.imby008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby009
            #add-point:BEFORE FIELD imby009 name="construct.b.page1.imby009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby009
            
            #add-point:AFTER FIELD imby009 name="construct.a.page1.imby009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby009
            #add-point:ON ACTION controlp INFIELD imby009 name="construct.c.page1.imby009"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imby015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby015
            #add-point:ON ACTION controlp INFIELD imby015 name="construct.c.page1.imby015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imby015  #顯示到畫面上
            NEXT FIELD imby015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby015
            #add-point:BEFORE FIELD imby015 name="construct.b.page1.imby015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby015
            
            #add-point:AFTER FIELD imby015 name="construct.a.page1.imby015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby010
            #add-point:BEFORE FIELD imby010 name="construct.b.page1.imby010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby010
            
            #add-point:AFTER FIELD imby010 name="construct.a.page1.imby010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby010
            #add-point:ON ACTION controlp INFIELD imby010 name="construct.c.page1.imby010"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imby016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby016
            #add-point:ON ACTION controlp INFIELD imby016 name="construct.c.page1.imby016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imby016  #顯示到畫面上
            NEXT FIELD imby016                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby016
            #add-point:BEFORE FIELD imby016 name="construct.b.page1.imby016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby016
            
            #add-point:AFTER FIELD imby016 name="construct.a.page1.imby016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby011
            #add-point:BEFORE FIELD imby011 name="construct.b.page1.imby011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby011
            
            #add-point:AFTER FIELD imby011 name="construct.a.page1.imby011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby011
            #add-point:ON ACTION controlp INFIELD imby011 name="construct.c.page1.imby011"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imby017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby017
            #add-point:ON ACTION controlp INFIELD imby017 name="construct.c.page1.imby017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imby017  #顯示到畫面上
            NEXT FIELD imby017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby017
            #add-point:BEFORE FIELD imby017 name="construct.b.page1.imby017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby017
            
            #add-point:AFTER FIELD imby017 name="construct.a.page1.imby017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby012
            #add-point:BEFORE FIELD imby012 name="construct.b.page1.imby012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby012
            
            #add-point:AFTER FIELD imby012 name="construct.a.page1.imby012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby012
            #add-point:ON ACTION controlp INFIELD imby012 name="construct.c.page1.imby012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby013
            #add-point:BEFORE FIELD imby013 name="construct.b.page1.imby013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby013
            
            #add-point:AFTER FIELD imby013 name="construct.a.page1.imby013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby013
            #add-point:ON ACTION controlp INFIELD imby013 name="construct.c.page1.imby013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby014
            #add-point:BEFORE FIELD imby014 name="construct.b.page1.imby014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby014
            
            #add-point:AFTER FIELD imby014 name="construct.a.page1.imby014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imby014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby014
            #add-point:ON ACTION controlp INFIELD imby014 name="construct.c.page1.imby014"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON imbz001,imbz002,imbz003,imbz006,imbz004,imbz005
           FROM s_detail2[1].imbz001,s_detail2[1].imbz002,s_detail2[1].imbz003,s_detail2[1].imbz006, 
               s_detail2[1].imbz004,s_detail2[1].imbz005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz001
            #add-point:BEFORE FIELD imbz001 name="construct.b.page2.imbz001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz001
            
            #add-point:AFTER FIELD imbz001 name="construct.a.page2.imbz001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imbz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz001
            #add-point:ON ACTION controlp INFIELD imbz001 name="construct.c.page2.imbz001"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz002
            #add-point:BEFORE FIELD imbz002 name="construct.b.page2.imbz002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz002
            
            #add-point:AFTER FIELD imbz002 name="construct.a.page2.imbz002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz002
            #add-point:ON ACTION controlp INFIELD imbz002 name="construct.c.page2.imbz002"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imbz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz003
            #add-point:ON ACTION controlp INFIELD imbz003 name="construct.c.page2.imbz003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imby003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbz003  #顯示到畫面上

            NEXT FIELD imbz003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz003
            #add-point:BEFORE FIELD imbz003 name="construct.b.page2.imbz003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz003
            
            #add-point:AFTER FIELD imbz003 name="construct.a.page2.imbz003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz006
            #add-point:BEFORE FIELD imbz006 name="construct.b.page2.imbz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz006
            
            #add-point:AFTER FIELD imbz006 name="construct.a.page2.imbz006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imbz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz006
            #add-point:ON ACTION controlp INFIELD imbz006 name="construct.c.page2.imbz006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imbz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz004
            #add-point:ON ACTION controlp INFIELD imbz004 name="construct.c.page2.imbz004"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbz004  #顯示到畫面上

            NEXT FIELD imbz004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz004
            #add-point:BEFORE FIELD imbz004 name="construct.b.page2.imbz004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz004
            
            #add-point:AFTER FIELD imbz004 name="construct.a.page2.imbz004"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz005
            #add-point:BEFORE FIELD imbz005 name="construct.b.page2.imbz005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz005
            
            #add-point:AFTER FIELD imbz005 name="construct.a.page2.imbz005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imbz005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz005
            #add-point:ON ACTION controlp INFIELD imbz005 name="construct.c.page2.imbz005"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON imbo002
           FROM s_detail3[1].imbo002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.imbo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbo002
            #add-point:ON ACTION controlp INFIELD imbo002 name="construct.c.page3.imbo002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbo002  #顯示到畫面上
            NEXT FIELD imbo002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbo002
            #add-point:BEFORE FIELD imbo002 name="construct.b.page3.imbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbo002
            
            #add-point:AFTER FIELD imbo002 name="construct.a.page3.imbo002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aim_aimm200_01.aimm200_01_construct   #lori522612  150126 add---嵌入產品特徵值      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         NEXT FIELD imba001   #lori522612  150126 add         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "imba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imby_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imbz_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imbo_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
      
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt300_filter()
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
      CONSTRUCT g_wc_filter ON imbadocno,imba000,imba001
                          FROM s_browse[1].b_imbadocno,s_browse[1].b_imba000,s_browse[1].b_imba001
 
         BEFORE CONSTRUCT
               DISPLAY artt300_filter_parser('imbadocno') TO s_browse[1].b_imbadocno
            DISPLAY artt300_filter_parser('imba000') TO s_browse[1].b_imba000
            DISPLAY artt300_filter_parser('imba001') TO s_browse[1].b_imba001
      
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
 
      CALL artt300_filter_show('imbadocno')
   CALL artt300_filter_show('imba000')
   CALL artt300_filter_show('imba001')
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt300_filter_parser(ps_field)
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
 
{<section id="artt300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt300_filter_show(ps_field)
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
   LET ls_condition = artt300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt300_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
      
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_imby_d.clear()
   CALL g_imby2_d.clear()
   CALL g_imby3_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aimm200_01_clear_detail()   #lori522612  150126 add---嵌入產品特徵值 
   #重新定义栏位combobox开窗  geza 2015/04/01 add
   CALL cl_set_combo_scc('imba100','2003')
   #CALL cl_set_combo_scc_part('imba109','6553','1,4,5')   #160604-00009#91 dongsz mark
   CALL cl_set_combo_scc_part('imba109','6553','1,4,5,8,9,10')   #160604-00009#91 dongsz add 
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt300_browser_fill("")
      CALL artt300_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL artt300_filter_show('imbadocno')
   CALL artt300_filter_show('imba000')
   CALL artt300_filter_show('imba001')
   CALL artt300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt300_fetch("F") 
      #顯示單身筆數
      CALL artt300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt300_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
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
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_imba_m.imbadocno = g_browser[g_current_idx].b_imbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL artt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt300_set_act_visible()   
   CALL artt300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF cl_null(g_imba_m.imbadocno) THEN
      CALL cl_set_act_visible("modify_imba001",FALSE)
   ELSE
      CALL cl_set_act_visible("modify_imba001",TRUE)
   END IF

   IF g_imba_m.imba000 != 'I' THEN
      CALL cl_set_act_visible("modify_imba001",FALSE)
   END IF

   #IF g_imba_m.imbastus = 'N' THEN
   # N未確認/D抽單/R已拒絕允許修改
   IF g_imba_m.imbastus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail,modify_imba001,open_aimt300_01",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail,modify_imba001,open_aimt300_01",FALSE)
   END IF 
 
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
      
   #end add-point
   
   #保存單頭舊值
   LET g_imba_m_t.* = g_imba_m.*
   LET g_imba_m_o.* = g_imba_m.*
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #重新顯示   
   CALL artt300_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5     
   DEFINE l_insert      LIKE type_t.num5
   DEFINE l_imbf062     LIKE imbf_t.imbf062
   DEFINE l_imbf063     LIKE imbf_t.imbf063
   DEFINE l_imbf064     LIKE imbf_t.imbf064   
   DEFINE  l_cnt        LIKE type_t.num10   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imby_d.clear()   
   CALL g_imby2_d.clear()  
   CALL g_imby3_d.clear()  
 
 
   INITIALIZE g_imba_m.* TO NULL             #DEFAULT 設定
   
   LET g_imbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   #重新定义栏位combobox开窗  geza 2015/04/01 add
   CALL cl_set_combo_scc('imba100','2003')
   #商品品类默认值为1，条码类型combobox默认为1 
   #CALL cl_set_combo_scc_part('imba109','6553','1')   #160604-00009#91 dongsz mark
   CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')   #160604-00009#91 dongsz add
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imba_m.imbaownid = g_user
      LET g_imba_m.imbaowndp = g_dept
      LET g_imba_m.imbacrtid = g_user
      LET g_imba_m.imbacrtdp = g_dept 
      LET g_imba_m.imbacrtdt = cl_get_current()
      LET g_imba_m.imbamodid = g_user
      LET g_imba_m.imbamoddt = cl_get_current()
      LET g_imba_m.imbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imba_m.imba000 = "I"
      LET g_imba_m.imba108 = "1"
      LET g_imba_m.imba004 = "M"
      LET g_imba_m.imba100 = "1"
      LET g_imba_m.imba109 = "1"
      LET g_imba_m.imba113 = "1"
      LET g_imba_m.imbaacti = "Y"
      LET g_imba_m.imba019 = "0"
      LET g_imba_m.imba020 = "0"
      LET g_imba_m.imba021 = "0"
      LET g_imba_m.imba025 = "0"
      LET g_imba_m.imbastus = "N"
      LET g_imba_m.imba118 = "0"
      LET g_imba_m.imba119 = "0"
      LET g_imba_m.imba120 = "0"
      LET g_imba_m.imba115 = "0"
      LET g_imba_m.imba116 = "0"
      LET g_imba_m.imba117 = "0"
      LET g_imba_m.imbf122 = "0"
      LET g_imba_m.imbf115 = "0"
      LET g_imba_m.imbf114 = "0"
      LET g_imba_m.imbf116 = "1"
      LET g_imba_m.imba110 = "N"
      LET g_imba_m.imba125 = "N"
      LET g_imba_m.imba121 = "N"
      LET g_imba_m.imba144 = "N"
      LET g_imba_m.imbf061 = "1"
      LET g_imba_m.imbf062 = "N"
      LET g_imba_m.imbf064 = "3"
      LET g_imba_m.imba149 = "1"
      LET g_imba_m.imba102 = "0"
      LET g_imba_m.imba103 = "0"
      LET g_imba_m.imba147 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #150122-00013#1 150304 pomelo add (s)
      DISPLAY 'g_argv[01] = ',g_argv[01]
      DISPLAY 'g_argv[1] = ',g_argv[1]
      IF g_argv[01] = '2' THEN
         LET g_imba_m.imbf122 = '0'       #銷售子件拆解方式
         LET g_imba_m.imbf115 = 1         #最小銷售數量
         LET g_imba_m.imbf114 = 1         #銷售單位批量
         LET g_imba_m.imbf116 = '3'       #銷售批量控制方式
         DISPLAY 'imbf116= ',g_imba_m.imbf116
      END IF
      #150122-00013#1 150304 pomelo add (e)
      
      LET g_ooef004 = ''
      LET g_ooef005 = ''
      SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF 
      IF cl_null(g_ooef005) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00008'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF  
      LET g_imba_m.imbadocno = g_today
      
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
         RETURNING l_success,g_imba_m.imbadocno
         
      CALL s_aooi500_default(g_prog,'imbaunit',g_site)
       RETURNING l_insert,g_imba_m.imba142
      IF NOT l_insert THEN
        RETURN
      END IF
      
      CALL artt300_imba142_ref()
      LET g_imba_m.imbadocdt = g_today
      LET g_imba_m_t.* = g_imba_m.*
      LET g_imba_m_o.* = g_imba_m.*                               
      LET g_assign_no = 'N'  

      CALL aimm200_01_clear_detail()   #lori522612  150126 add---嵌入產品特徵值
      #LET g_imba_m.imba010 = s_default_rtda001(g_prog)  #生命周期栏位赋值 #Mark By Ken 150319
      LET g_imba_m.imba010 = s_life_cycle_default(g_prog,'1')  #生命周期栏位赋值 #Add By Ken 150319
      
      #add by geza 20160315(S)
      #计价币别默认值抓取组织的主币别
      SELECT ooef016 INTO g_imba_m.imba114
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL artt300_imba114_ref()   
      #add by geza 20160315(E)
      #add by geza 20160606 160604-00009#1(S)
      IF g_imba_m.imba108 <> '4' THEN 
         LET g_imba_m.imbf061 = '1'
         LET g_imba_m.imbf062 = 'Y'
         LET g_imba_m.imbf064 = '1'
         LET l_cnt = 0
         SELECT COUNT(distinct oofg001) INTO l_cnt
           FROM oofg_t
          WHERE oofgent = g_enterprise
            AND oofg002 = '6'
            AND oofgstus = 'Y'
         IF l_cnt = 1 THEN
            SELECT distinct oofg001 INTO g_imba_m.imbf063
              FROM oofg_t
             WHERE oofgent = g_enterprise
               AND oofg002 = '6'
               AND oofgstus = 'Y'
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbf063
            CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=' ' AND oofgl002=? AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbf063_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imba_m.imbf063_desc   
         END IF
      END IF
      #add by geza 20160606 160604-00009#1((E)
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imba_m_t.* = g_imba_m.*
      LET g_imba_m_o.* = g_imba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL artt300_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
            
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_imba_m.* TO NULL
         INITIALIZE g_imby_d TO NULL
         INITIALIZE g_imby2_d TO NULL
         INITIALIZE g_imby3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imby_d.clear()
      #CALL g_imby2_d.clear()
      #CALL g_imby3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt300_set_act_visible()   
   CALL artt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt300_cl
   
   CALL artt300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL artt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
       g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba108,g_imba_m.imba004, 
       g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba006_desc, 
       g_imba_m.imba105,g_imba_m.imba105_desc,g_imba_m.imba104,g_imba_m.imba104_desc,g_imba_m.imba107, 
       g_imba_m.imba107_desc,g_imba_m.imba106,g_imba_m.imba106_desc,g_imba_m.imba145,g_imba_m.imba145_desc, 
       g_imba_m.imba146,g_imba_m.imba146_desc,g_imba_m.imba113,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba142,g_imba_m.imba142_desc,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba026_desc, 
       g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamodid_desc, 
       g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba009_desc,g_imba_m.imba161,g_imba_m.imba161_desc,g_imba_m.imba101,g_imba_m.imba101_desc, 
       g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba114_desc,g_imba_m.imba115, 
       g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba124_desc,g_imba_m.imbf122,g_imba_m.imbf115, 
       g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125, 
       g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba123,g_imba_m.imba131, 
       g_imba_m.imba131_desc,g_imba_m.imba126,g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba143, 
       g_imba_m.imba143_desc,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf063_desc,g_imba_m.imbf064,g_imba_m.imba149, 
       g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148
   
   #add-point:新增結束後 name="insert.after"
   ##150613 by lori mod---(S)
   #150324-00006#15 150408 by lori522612 add---(S) 
   #元件增加傳單號,回傳imaf062/imaf063/imaf064
   CALL s_artt300_get_imbf061(g_imba_m.imbadocno,g_imba_m.imba001)
       #150614-00020#1 20150617 mark by beckxie---S
#      RETURNING g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064  
#   DISPLAY BY NAME g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064 
       #150614-00020#1 20150617 mark by beckxie---E
   #150614-00020#1 20150617 add  by beckxie---S
       RETURNING g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                 g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
   DISPLAY BY NAME g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                   g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
   #150614-00020#1 20150617 add by beckxie---E
    #150324-00006#15 150408 by lori522612 add---(E)
   ##150613 by lori mod---(E)  
   
   ##150613 by lori mark---(S)
   ##150427-00001#2 Add-S By Ken 150506 
   #CALL s_artt300_get_imbf062(g_imba_m.imba001)
   #   RETURNING l_imbf062,l_imbf063,l_imbf064
   #LET g_imba_m.l_imbf062 = l_imbf062
   #LET g_imba_m.l_imbf063 = l_imbf063
   #LET g_imba_m.l_imbf064 = l_imbf064
   #DISPLAY BY NAME g_imba_m.l_imbf062   
   #DISPLAY BY NAME g_imba_m.l_imbf063   
   #DISPLAY BY NAME g_imba_m.l_imbf064 
   ##150427-00001#2 Add-E By Ken 150506 
   ##150613 by lori mark---(D)
   #end add-point 
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #功能已完成,通報訊息中心
   CALL artt300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imba_m_t.* = g_imba_m.*
   LET g_imba_m_o.* = g_imba_m.*
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   CALL s_transaction_begin()
   
   OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
   #檢查是否允許此動作
   IF NOT artt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL artt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL artt300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_imbadocno_t = g_imba_m.imbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imba_m.imbamodid = g_user 
LET g_imba_m.imbamoddt = cl_get_current()
LET g_imba_m.imbamodid_desc = cl_get_username(g_imba_m.imbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_imba_m_o.* = g_imba_m_t.*
      
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_imba_m.imbastus MATCHES "[DR]" THEN 
         LET g_imba_m.imbastus = "N"
      END IF
      
      IF g_imba_m.imbastus != 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00030'
         LET g_errparam.extend = g_imba_m.imbadocno
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CLOSE artt300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      LET g_assign_no = 'Y'
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imba_t SET (imbamodid,imbamoddt) = (g_imba_m.imbamodid,g_imba_m.imbamoddt)
          WHERE imbaent = g_enterprise AND imbadocno = g_imbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imba_m.* = g_imba_m_t.*
            CALL artt300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imba_m.imbadocno != g_imba_m_t.imbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                  
         #end add-point
         
         #更新單身key值
         UPDATE imby_t SET imbydocno = g_imba_m.imbadocno
 
          WHERE imbyent = g_enterprise AND imbydocno = g_imba_m_t.imbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imby_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
                  
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
                  
         #end add-point
         
         UPDATE imbz_t
            SET imbzdocno = g_imba_m.imbadocno
 
          WHERE imbzent = g_enterprise AND
                imbzdocno = g_imbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbz_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
                  
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE imbo_t
            SET imbodocno = g_imba_m.imbadocno
 
          WHERE imboent = g_enterprise AND
                imbodocno = g_imbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt300_set_act_visible()   
   CALL artt300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
   #填到對應位置
   CALL artt300_browser_fill("")
 
   CLOSE artt300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt300.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt300_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_msg                  STRING
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_success              LIKE type_t.num5
   DEFINE r_errno                LIKE type_t.chr10
   DEFINE r_rtax001              LIKE rtax_t.rtax001
   DEFINE l_slip                 LIKE type_t.chr10
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_imby005              LIKE imby_t.imby005 #150602-00072#1 Add By Ken 150603
   #add--2015/05/19 By geza--(S)
   DEFINE l_oofg_return   DYNAMIC ARRAY OF RECORD
         oofg019       LIKE oofg_t.oofg019,  #field
         oofg020       LIKE oofg_t.oofg020   #value
                        END RECORD
   #add--2015/05/19 By geza--(E)
   DEFINE  l_str             STRING #add by geza 20150805
   #160512-00003#10   by 08172
   DEFINE  l_oocal003        LIKE oocal_t.oocal003
   #160803-00008#3 20160811 add by beckxie---S
   DEFINE  l_inam            DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001           LIKE inam_t.inam001,  #料號
           inam002           LIKE inam_t.inam002,  #產品特徵
           inam004           LIKE inam_t.inam004   #nouse
                             END RECORD
   #160803-00008#3 20160811 add by beckxie---E
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
       g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba108,g_imba_m.imba004, 
       g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba006_desc, 
       g_imba_m.imba105,g_imba_m.imba105_desc,g_imba_m.imba104,g_imba_m.imba104_desc,g_imba_m.imba107, 
       g_imba_m.imba107_desc,g_imba_m.imba106,g_imba_m.imba106_desc,g_imba_m.imba145,g_imba_m.imba145_desc, 
       g_imba_m.imba146,g_imba_m.imba146_desc,g_imba_m.imba113,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba142,g_imba_m.imba142_desc,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba026_desc, 
       g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamodid_desc, 
       g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba009_desc,g_imba_m.imba161,g_imba_m.imba161_desc,g_imba_m.imba101,g_imba_m.imba101_desc, 
       g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba114_desc,g_imba_m.imba115, 
       g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba124_desc,g_imba_m.imbf122,g_imba_m.imbf115, 
       g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125, 
       g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba123,g_imba_m.imba131, 
       g_imba_m.imba131_desc,g_imba_m.imba126,g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba143, 
       g_imba_m.imba143_desc,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf063_desc,g_imba_m.imbf064,g_imba_m.imba149, 
       g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
 
   #end add-point 
   LET g_forupd_sql = "SELECT imby001,imbystus,imby002,imby019,imby003,imby004,imby005,imby006,imby018, 
       imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012,imby013,imby014 FROM  
       imby_t WHERE imbyent=? AND imbydocno=? AND imby003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt300_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
      
   #end add-point    
   LET g_forupd_sql = "SELECT imbz001,imbz002,imbz003,imbz006,imbz004,imbz005 FROM imbz_t WHERE imbzent=?  
       AND imbzdocno=? AND imbz002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt300_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imbo002 FROM imbo_t WHERE imboent=? AND imbodocno=? AND imbo002=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt300_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
      
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
         CALL artt300_set_no_required(p_cmd)
   CALL artt300_set_required(p_cmd)
   #新增修改时生命周期下拉框
   CALL s_life_cycle_display(g_prog,'imba010','1') #Add By geza 150323 
   #end add-point
   CALL artt300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
       g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imba009,g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120, 
       g_imba_m.imba114,g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imbf122, 
       g_imba_m.imbf115,g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112, 
       g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba131, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143,g_imba_m.imba130, 
       g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132,g_imba_m.imba133, 
       g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139, 
       g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064, 
       g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_slip = ''   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt300.input.head" >}
      #單頭段
      INPUT BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
          g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
          g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
          g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
          g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
          g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
          g_imba_m.imba009,g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120, 
          g_imba_m.imba114,g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imbf122, 
          g_imba_m.imbf115,g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112, 
          g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba131, 
          g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143,g_imba_m.imba130, 
          g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132,g_imba_m.imba133, 
          g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139, 
          g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064, 
          g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                CALL n_imbal(g_imba_m.imbadocno)    
                INITIALIZE g_ref_fields TO NULL
                LET g_ref_fields[1] = g_imba_m.imbadocno
                CALL ap_ref_array2(g_ref_fields," SELECT imbal002,imbal003,imbal004 FROM imbal_t WHERE imbalent = '"||g_enterprise||"' AND imbaldocno = ? AND imbal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                LET g_imba_m.imbal002 = g_rtn_fields[1]
                LET g_imba_m.imbal003 = g_rtn_fields[2]
                LET g_imba_m.imbal004 = g_rtn_fields[3]                
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.imbaldocno = g_imba_m.imbadocno
LET g_master_multi_table_t.imbal002 = g_imba_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imba_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imba_m.imbal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.imbaldocno = ''
LET g_master_multi_table_t.imbal002 = ''
LET g_master_multi_table_t.imbal003 = ''
LET g_master_multi_table_t.imbal004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_showmsg_init()                        
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_required(p_cmd)            
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            #end add-point
            CALL artt300_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba000
            #add-point:BEFORE FIELD imba000 name="input.b.imba000"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba000
            
            #add-point:AFTER FIELD imba000 name="input.a.imba000"
                                    CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_required(p_cmd)            
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba000
            #add-point:ON CHANGE imba000 name="input.g.imba000"
                                    LET g_imba_m.imba001 = ''
            DISPLAY BY NAME g_imba_m.imba001
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocno
            #add-point:BEFORE FIELD imbadocno name="input.b.imbadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocno
            
            #add-point:AFTER FIELD imbadocno name="input.a.imbadocno"
            IF NOT s_aooi200_chk_slip(g_site,'',g_imba_m.imbadocno,g_prog) THEN
               LET g_imba_m.imbadocno = ''
               NEXT FIELD CURRENT
            END IF                       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbadocno
            #add-point:ON CHANGE imbadocno name="input.g.imbadocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocdt
            #add-point:BEFORE FIELD imbadocdt name="input.b.imbadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocdt
            
            #add-point:AFTER FIELD imbadocdt name="input.a.imbadocdt"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbadocdt
            #add-point:ON CHANGE imbadocdt name="input.g.imbadocdt"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="input.b.imba001"
            #add--2015/05/19 By geza--(S)
            IF g_imba_m.imba000 = 'I' AND cl_null(g_imba_m.imba001) THEN    
               CALL s_aooi390_gen('1') RETURNING l_success,g_imba_m.imba001,l_oofg_return
               DISPLAY BY NAME g_imba_m.imba001
            END IF      
            #add--2015/05/19 By geza--(E)            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="input.a.imba001"
            IF NOT cl_null(g_imba_m.imba001) THEN
#               IF g_imba_m.imba001 != g_imba_m_o.imba001 OR g_imba_m_o.imba001 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imba_m.imba001 != g_imba_m_o.imba001 OR cl_null(g_imba_m_o.imba001) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba001 = g_imba_m_o.imba001
                     NEXT FIELD CURRENT
                  ELSE
                     CASE g_imba_m.imba000 
                        WHEN 'U' 
                           CALL artt300_carry_imaa()
                           #根据商品种类值判断条码类型条码分类的值  geza 2015/04/01  add
                           IF NOT cl_null(g_imba_m.imba108) THEN   
                              IF g_imba_m.imba108 = '1'  THEN 
                                 #CALL cl_set_combo_scc_part('imba109','6553','1')   #160604-00009#91 dongsz mark
                                 CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')   #160604-00009#91 dongsz add
                                 LET  g_imba_m.imba109 = '1' 
                                 CALL cl_set_combo_scc('imba100','2003')  
                                 CALL cl_set_combo_scc('imby002','2003')  
                                 LET  g_imba_m.imba113 = 1                  
                              END IF
                              IF g_imba_m.imba108 = '3' THEN 
                                 CALL cl_set_combo_scc_part('imba100','2003','2')
                                 LET  g_imba_m.imba100 = '2'
                                 CALL cl_set_combo_scc_part('imby002','2003','2')
                                 CALL cl_set_combo_scc_part('imba109','6553','4,5')
                                 IF g_imba_m.imba109 != '4' AND g_imba_m.imba109 != '5' THEN 
                                    LET  g_imba_m.imba109 = '4'
                                 END IF       
                                 LET  g_imba_m.imba113 = 1000  
                             
                              END IF 
                              IF g_imba_m.imba108 = '4' THEN 
                                 CALL cl_set_combo_scc_part('imba100','2003','2')
                                 LET  g_imba_m.imba100 = '2'
                                 CALL cl_set_combo_scc_part('imby002','2003','2')
                                 #CALL cl_set_combo_scc_part('imba109','6553','1')    #160604-00009#91 dongsz mark
                                 CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')    #160604-00009#91 dongsz add
                                 #LET  g_imba_m.imba109 = '1'    #160604-00009#91 dongsz mark
                                 LET  g_imba_m.imba109 = '8'    #160604-00009#91 dongsz add
                                 LET  g_imba_m.imba113 = 1                  
                              END IF
                              IF g_imba_m.imba108 = '2' THEN 
                                 CALL cl_set_combo_scc('imba100','2003')
                                 CALL cl_set_combo_scc('imby002','2003')
                                 CALL cl_set_combo_scc_part('imba109','6553','1')    
                                 LET  g_imba_m.imba109 = '1' 
                                 LET  g_imba_m.imba113 = 1                  
                              END IF                
                           END IF 
                        WHEN 'I'
                           LET g_imba_m.imba002 = 1
                           DISPLAY BY NAME g_imba_m.imba002                           
                     END CASE                    
                  END IF
                  #add--2015/05/19 By geza--(S)
                  IF NOT s_aooi390_chk('1',g_imba_m.imba001) THEN
                     LET g_imba_m.imba001 = g_imba_m_t.imba001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/19 By geza--(E)
               END IF
            END IF
            LET g_imba_m_o.imba001 = g_imba_m.imba001
            #add by geza 20150820(S)
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            #add by geza 20150820(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba001
            #add-point:ON CHANGE imba001 name="input.g.imba001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="input.b.imbal002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="input.a.imbal002"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal002
            #add-point:ON CHANGE imbal002 name="input.g.imbal002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="input.b.imbal003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="input.a.imbal003"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal003
            #add-point:ON CHANGE imbal003 name="input.g.imbal003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="input.b.imbal004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="input.a.imbal004"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal004
            #add-point:ON CHANGE imbal004 name="input.g.imbal004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba003
            
            #add-point:AFTER FIELD imba003 name="input.a.imba003"
                                    LET g_imba_m.imba003_desc = ''
            DISPLAY BY NAME g_imba_m.imba003_desc
            IF NOT cl_null(g_imba_m.imba003) THEN
#               IF g_imba_m.imba003 != g_imba_m_o.imba003 OR g_imba_m_o.imba003 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imba_m.imba003 != g_imba_m_o.imba003 OR cl_null(g_imba_m_o.imba003) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba003
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'arti305'
                           LET g_errparam.replace[2] = cl_get_progname('arti305',g_lang,"2")
                           LET g_errparam.exeprog = 'arti305'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba003 = g_imba_m_o.imba003
                     CALL artt300_imba003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF g_imba_m.imba000 = 'I' THEN
                     CALL artt300_carry_imck()
                     #根据商品种类值判断条码类型条码分类的值  geza 2015/04/01  add
                     IF NOT cl_null(g_imba_m.imba108) THEN   
                        IF g_imba_m.imba108 = '1'  THEN 
                           #CALL cl_set_combo_scc_part('imba109','6553','1')   #160604-00009#91 dongsz mark
                           CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')   #160604-00009#91 dongsz add
                           LET  g_imba_m.imba109 = '1' 
                           CALL cl_set_combo_scc('imba100','2003')  
                           CALL cl_set_combo_scc('imby002','2003')  
                           LET  g_imba_m.imba113 = 1                  
                        END IF
                        IF g_imba_m.imba108 = '3' THEN 
                           CALL cl_set_combo_scc_part('imba100','2003','2')
                           LET  g_imba_m.imba100 = '2'
                           CALL cl_set_combo_scc_part('imby002','2003','2')
                           CALL cl_set_combo_scc_part('imba109','6553','4,5')
                           IF g_imba_m.imba109 != '4' AND g_imba_m.imba109 != '5' THEN 
                              LET  g_imba_m.imba109 = '4'
                           END IF       
                           LET  g_imba_m.imba113 = 1000  
                       
                        END IF 
                        IF g_imba_m.imba108 = '4' THEN 
                           CALL cl_set_combo_scc_part('imba100','2003','2')
                           LET  g_imba_m.imba100 = '2'
                           CALL cl_set_combo_scc_part('imby002','2003','2')
                           #CALL cl_set_combo_scc_part('imba109','6553','1')   #160604-00009#91 dongsz mark
                           CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')   #160604-00009#91 dongsz add
                           #LET  g_imba_m.imba109 = '1'     #160604-00009#91 dongsz mark
                           LET  g_imba_m.imba109 = '8'    #160604-00009#91 dongsz add
                           LET  g_imba_m.imba113 = 1                  
                        END IF
                        IF g_imba_m.imba108 = '2' THEN 
                           CALL cl_set_combo_scc('imba100','2003')
                           CALL cl_set_combo_scc('imby002','2003')
                           CALL cl_set_combo_scc_part('imba109','6553','1')    
                           LET  g_imba_m.imba109 = '1' 
                           LET  g_imba_m.imba113 = 1                  
                        END IF                
                     END IF                      
                  END IF
               END IF
               IF g_imba_m.imba108 != g_imba_m_o.imba108 OR g_imba_m.imba100 != g_imba_m_o.imba100 OR 
                  g_imba_m.imba109 != g_imba_m_o.imba109 THEN
                  LET g_imba_m.imba014 = '' 
               END IF 
            END IF
            CALL artt300_imba003_ref()  
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)            
            LET g_imba_m_o.imba003 = g_imba_m.imba003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba003
            #add-point:BEFORE FIELD imba003 name="input.b.imba003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba003
            #add-point:ON CHANGE imba003 name="input.g.imba003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba108
            #add-point:BEFORE FIELD imba108 name="input.b.imba108"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba108
            
            #add-point:AFTER FIELD imba108 name="input.a.imba108"
#            150417   mark  geza    搬到 ON CHANGE imba108 中            
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            LET g_imba_m_o.* = g_imba_m.* 
            
            
            
            #150629-00016#22   add by mapf 2015/8/4  商品种类=4-专柜时，默认赋值
            #mark by geza 2016060 8搬到 ON CHANGE imba108 中        (S)
#            IF  g_imba_m.imba108=4 THEN
#                LET  g_imba_m.imbf061=3  
#                LET  g_imba_m.imbf062='N'  
#                LET  g_imba_m.imbf064=3
#                LET  g_imba_m.imba149=1
#            END IF
            #mark by geza 20160608(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba108
            #add-point:ON CHANGE imba108 name="input.g.imba108"
            IF g_imba_m.imba108 = 1 OR g_imba_m.imba108 = '2' THEN
               #判断单身的条码分类与单头修改之后的条码分类是否一致
               LET  l_cnt = 0                            
               SELECT COUNT(*) INTO l_cnt
                 FROM imby_t 
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno  
               #IF l_cnt > 0 AND (g_imba_m.imba109 = 4 OR g_imba_m.imba109 =5 ) THEN    #160604-00009#91 dongsz mark
               IF l_cnt > 0 AND g_imba_m.imba109 <> '1' THEN    #160604-00009#91 dongsz add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00528'
                  LET g_errparam.extend ='' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_imba_m.imba108 = g_imba_m_o.imba108
                  NEXT FIELD CURRENT
               END IF 
               IF l_cnt = 0 AND ((g_imba_m.imba100 != 1 AND g_imba_m.imba100 != 2 AND  g_imba_m.imba100 != 3 ) OR g_imba_m.imba109 !=1 ) THEN
                  LET g_imba_m.imba014 = ''
               END IF               
            END IF
            IF g_imba_m.imba108 = 3  THEN
               #判断单身的条码分类与单头修改之后的条码分类是否一致
               LET  l_cnt = 0                            
               SELECT COUNT(*) INTO l_cnt
                 FROM imby_t 
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno  
                  AND imby002 IN ('1','3')
               IF l_cnt > 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00528'
                  LET g_errparam.extend ='' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_imba_m.imba108 = g_imba_m_o.imba108
                  NEXT FIELD CURRENT
               END IF 
               LET  l_cnt = 0                            
               SELECT COUNT(*) INTO l_cnt
                 FROM imby_t 
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno  
               #IF l_cnt > 0 AND  g_imba_m.imba109 = 1 THEN     #160604-00009#91 dongsz mark
               IF l_cnt > 0 AND (g_imba_m.imba109 <> '4' AND g_imba_m.imba109 <> '5') THEN     #160604-00009#91 dongsz add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00528'
                  LET g_errparam.extend ='' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_imba_m.imba108 = g_imba_m_o.imba108
                  NEXT FIELD CURRENT
               END IF               
               IF l_cnt = 0 AND ( g_imba_m.imba100 != 2  OR (g_imba_m.imba109 !=4 AND g_imba_m.imba109 !=5 ) ) THEN
                  LET g_imba_m.imba014 = ''
               END IF               
            END IF
            IF g_imba_m.imba108 = 4  THEN
               #判断单身的条码分类与单头修改之后的条码分类是否一致
               LET  l_cnt = 0                            
               SELECT COUNT(*) INTO l_cnt
                 FROM imby_t 
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno  
                  AND imby002 IN ('1','3')
               IF l_cnt > 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00528'
                  LET g_errparam.extend ='' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_imba_m.imba108 = g_imba_m_o.imba108
                  NEXT FIELD CURRENT
               END IF
               LET  l_cnt = 0                            
               SELECT COUNT(*) INTO l_cnt
                 FROM imby_t 
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno  
               IF l_cnt > 0 AND  (g_imba_m.imba109 = 4 OR g_imba_m.imba109 =5 )THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00528'
                  LET g_errparam.extend ='' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_imba_m.imba108 = g_imba_m_o.imba108
                  NEXT FIELD CURRENT
               END IF                
               IF l_cnt = 0 AND ((g_imba_m.imba100 != 2 ) OR g_imba_m.imba109 !=1 ) THEN
                  LET g_imba_m.imba014 = ''
               END IF               
            END IF 
            #根据商品种类值判断条码类型条码分类的值  geza 2015/04/01  add
            IF NOT cl_null(g_imba_m.imba108) THEN   
               IF g_imba_m.imba108 = '1'  THEN 
                  #CALL cl_set_combo_scc_part('imba109','6553','1')    #160604-00009#91 dongsz mark
                  CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')    #160604-00009#91 dongsz add
                  LET  g_imba_m.imba109 = '1' 
                  CALL cl_set_combo_scc('imba100','2003')  
                  CALL cl_set_combo_scc('imby002','2003')  
                  LET  g_imba_m.imba113 = 1                  
               END IF
               IF g_imba_m.imba108 = '3' THEN 
                  CALL cl_set_combo_scc_part('imba100','2003','2')
                  LET  g_imba_m.imba100 = '2'
                  CALL cl_set_combo_scc_part('imby002','2003','2')
                  CALL cl_set_combo_scc_part('imba109','6553','4,5')
                  IF g_imba_m.imba109 != '4' AND g_imba_m.imba109 != '5' THEN 
                     LET  g_imba_m.imba109 = '4'
                  END IF       
                  LET  g_imba_m.imba113 = 1000  
#                  LET  g_imby_d[l_ac].imby018 = 1000                  
               END IF
               #160512-00003#10  by 08172               
               IF g_imba_m.imba108 = '4' THEN 
                  CALL cl_set_combo_scc_part('imba100','2003','1,2')
                  LET  g_imba_m.imba100 = '1'
                  CALL artt300_set_entry(l_cmd)
                  CALL cl_set_combo_scc_part('imby002','2003','1,2')
                  #CALL cl_set_combo_scc_part('imba109','6553','1')    #160604-00009#91 dongsz mark
                  CALL cl_set_combo_scc_part('imba109','6553','1,8,9,10')    #160604-00009#91 dongsz add
                  #LET  g_imba_m.imba109 = '1'      #160604-00009#91 dongsz mark
                  LET  g_imba_m.imba109 = '8'      #160604-00009#91 dongsz add             
                  LET  g_imba_m.imba113 = 1                  
               END IF
               #
               IF g_imba_m.imba108 = '2' THEN 
                  CALL cl_set_combo_scc('imba100','2003')
                  CALL cl_set_combo_scc('imby002','2003')
                  CALL cl_set_combo_scc_part('imba109','6553','1')    
                  LET  g_imba_m.imba109 = '1' 
                  LET  g_imba_m.imba113 = 1                  
               END IF                
            END IF    
            #add by geza 20160606 160604-00009#1(S)
            IF g_imba_m.imba108 <> '4' THEN 
               LET g_imba_m.imbf061 = '1'
               LET g_imba_m.imbf062 = 'Y'
               LET g_imba_m.imbf064 = '1'
               LET l_cnt = 0
               SELECT COUNT(distinct oofg001) INTO l_cnt
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '6'
                  AND oofgstus = 'Y'
               IF l_cnt = 1 THEN
                  SELECT distinct oofg001 INTO g_imba_m.imbf063
                    FROM oofg_t
                   WHERE oofgent = g_enterprise
                     AND oofg002 = '6'
                     AND oofgstus = 'Y'
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imba_m.imbf063
                  CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=' ' AND oofgl002=? AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imba_m.imbf063_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_imba_m.imbf063_desc   
               END IF
               CALL artt300_set_no_required(p_cmd)
               CALL artt300_set_required(p_cmd)
            END IF
            IF g_imba_m.imba108=4 THEN
               LET g_imba_m.imbf061=3  
               LET g_imba_m.imbf062='N'  
               LET g_imba_m.imbf064=3
               LET g_imba_m.imbf063=''
               LET g_imba_m.imba149=1
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_imba_m.imbf063
               CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=' ' AND oofgl002=? AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_imba_m.imbf063_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_imba_m.imbf063_desc  
            END IF
            #add by geza 20160606 160604-00009#1((E)
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            LET g_imba_m_o.* = g_imba_m.*            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba004
            #add-point:BEFORE FIELD imba004 name="input.b.imba004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba004
            
            #add-point:AFTER FIELD imba004 name="input.a.imba004"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba004
            #add-point:ON CHANGE imba004 name="input.g.imba004"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba100
            #add-point:BEFORE FIELD imba100 name="input.b.imba100"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba100
            
            #add-point:AFTER FIELD imba100 name="input.a.imba100"
#            150417   mark  geza    搬到 ON CHANGE imba100 中 
#            IF p_cmd = 'a' THEN    
#               IF g_imba_m.imba100 = '1' AND NOT cl_null(g_imba_m.imba014) THEN
#                  CALL s_chk_barcode(g_imba_m.imba014) RETURNING g_success
#                  IF g_success = 'N' THEN
#                     LET g_imba_m.imba100 = g_imba_m_o.imba100
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#            #dongsz--add--str---
#            IF g_imba_m.imba100 <> g_imba_m_o.imba100 OR cl_null(g_imba_m_o.imba100) THEN
#               SELECT imby003 INTO g_imba_m.imba014
#                 FROM imby_t
#                WHERE imbyent = g_enterprise
#                  AND imbydocno = g_imba_m.imbadocno
#                  AND imby002 = g_imba_m.imba100
#                  AND ROWNUM = 1
#                ORDER BY imby003
#               IF SQLCA.sqlcode = 100 THEN
#                  LET g_imba_m.imba014 = ""
#               END IF
#               DISPLAY BY NAME g_imba_m.imba014
#            END IF
#            #dongsz--add--end---
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            LET g_imba_m_o.imba100 = g_imba_m.imba100
            LET g_imba_m_o.imba014 = g_imba_m.imba014            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba100
            #add-point:ON CHANGE imba100 name="input.g.imba100"
            IF p_cmd = 'a' THEN
               IF g_imba_m.imba100 = '1' AND NOT cl_null(g_imba_m.imba014) THEN
                  CALL s_chk_barcode(g_imba_m.imba014) RETURNING g_success   
                  IF g_success = 'N' THEN
                     LET g_imba_m.imba100 = g_imba_m_o.imba100
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #dongsz--add--str---
            IF g_imba_m.imba100 <> g_imba_m_o.imba100 OR cl_null(g_imba_m_o.imba100) THEN
               # 170207-00018#8  2017/02/09 By 09042 mark(S)
               #SELECT imby003 INTO g_imba_m.imba014
               #  FROM imby_t
               # WHERE imbyent = g_enterprise
               #   AND imbydocno = g_imba_m.imbadocno
               #   AND imby002 = g_imba_m.imba100
               #   AND ROWNUM = 1
               # ORDER BY imby003
               # 170207-00018#8  2017/02/09 By 09042 mark(E)
               
               # 170207-00018#8  2017/02/09 By 09042 add(S)   
               SELECT a.imby003 INTO g_imba_m.imba014
                 FROM (
                        SELECT imby003
                          FROM imby_t
                         WHERE imbyent = g_enterprise
                           AND imbydocno = g_imba_m.imbadocno
                           AND imay002 = g_imaa_m.imaa100
                         ORDER BY imby003
                       ) a
               WHERE ROWNUM = 1;
               # 170207-00018#8  2017/02/09 By 09042 add(E)                
               IF SQLCA.sqlcode = 100 THEN
                  LET g_imba_m.imba014 = ""
               END IF
               DISPLAY BY NAME g_imba_m.imba014
            END IF
            #dongsz--add--end---
            CALL artt300_set_entry(p_cmd)
            CALL artt300_set_no_entry(p_cmd)
            LET g_imba_m_o.imba100 = g_imba_m.imba100
            LET g_imba_m_o.imba014 = g_imba_m.imba014                  
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba109
            #add-point:BEFORE FIELD imba109 name="input.b.imba109"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba109
            
            #add-point:AFTER FIELD imba109 name="input.a.imba109"
            LET g_imba_m_o.imba109 = g_imba_m.imba109            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba109
            #add-point:ON CHANGE imba109 name="input.g.imba109"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba014
            #add-point:BEFORE FIELD imba014 name="input.b.imba014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba014
            
            #add-point:AFTER FIELD imba014 name="input.a.imba014"
            #20140514--dongsz--add---
            IF NOT cl_null(g_imba_m.imba014) THEN
#               IF g_imba_m.imba014 != g_imba_m_o.imba014 OR g_imba_m_o.imba014 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imba_m.imba014 != g_imba_m_o.imba014 OR cl_null(g_imba_m_o.imba014) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_barcode(g_imba_m.imba014)
                  IF NOT cl_null(g_errno) THEN
                     IF g_imba_m.imba000 = 'U' AND g_errno = 'art-00032' THEN
                        SELECT imay001 INTO g_imba_m.imba001 FROM imay_t
                         WHERE imayent = g_enterprise
                           AND imay003 = g_imba_m.imba014
                        IF NOT cl_null(g_imba_m.imba001) THEN
                           CALL artt300_carry_imaa()
                        END IF
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_imba_m.imba014
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                       #Mark&Add By 150204-00001#28 -- Begin --
                       #LET g_imba_m.imba014 = g_imba_m_o.imba014
                        IF NOT cl_null(g_imba_m_o.imba014) THEN
                           LET g_imba_m.imba014 = g_imba_m_o.imba014
                        END IF
                       #Mark&Add By 150204-00001#28 -- End   --
                        NEXT FIELD CURRENT
                     END IF
                   
                  END IF
               END IF
               IF g_imba_m.imba100 = '1' THEN
                  CALL s_chk_barcode(g_imba_m.imba014) RETURNING g_success
                  IF g_success = 'N' THEN
                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imba_m.imba014 = g_imba_m_o.imba014
                     IF NOT cl_null(g_imba_m_o.imba014) THEN
                        LET g_imba_m.imba014 = g_imba_m_o.imba014
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #150906-00005#2 20151126 add by beckxie---S
               IF NOT s_artt300_chk_imba014(g_imba_m.imba014) THEN
                  IF NOT cl_null(g_imba_m_o.imba014) THEN
                     LET g_imba_m.imba014 = g_imba_m_o.imba014
                  END IF
                  NEXT FIELD CURRENT
               END IF
               #150906-00005#2 20151126 add by beckxie---E
            END IF
            LET g_imba_m_o.imba014 = g_imba_m.imba014
            #20140514--dongsz--add---            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba014
            #add-point:ON CHANGE imba014 name="input.g.imba014"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="input.b.imba002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            
            #add-point:AFTER FIELD imba002 name="input.a.imba002"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba002
            #add-point:ON CHANGE imba002 name="input.g.imba002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba006
            
            #add-point:AFTER FIELD imba006 name="input.a.imba006"
                                    LET g_imba_m.imba006_desc = ' '
            DISPLAY BY NAME g_imba_m.imba006_desc
            IF NOT cl_null(g_imba_m.imba006) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba006 != g_imba_m_t.imba006 OR g_imba_m_t.imba006 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               #160824-00007#162 20161125 modify by beckxie---S
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba006 != g_imba_m_t.imba006 OR cl_null(g_imba_m_t.imba006))) THEN   #150427-00012#6 20150707 add by beckxie   
               IF g_imba_m.imba006 != g_imba_m_o.imba006 OR cl_null(g_imba_m_o.imba006) THEN   #150427-00012#6 20150707 add by beckxie   
               #160824-00007#162 20161125 modify by beckxie---E
                  CALL artt300_chk_unit(g_imba_m.imba006) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba006
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_imba_m.imba006 = g_imba_m_t.imba006   #160824-00007#162 20161125 mark by beckxie
                     #160824-00007#162 20161125 add by beckxie---S
                     LET g_imba_m.imba006 = g_imba_m_o.imba006
                     LET g_imba_m.imba104 = g_imba_m_o.imba006
                     CALL artt300_imba104_ref()
                     LET g_imba_m.imba105 = g_imba_m_o.imba006   
                     CALL artt300_imba105_ref()
                     LET g_imba_m.imba107 = g_imba_m_o.imba006   
                     CALL artt300_imba107_ref()
                     LET g_imba_m.imba145 = g_imba_m_o.imba006   
                     CALL artt300_imba145_ref()
                     LET g_imba_m.imba146 = g_imba_m_o.imba006   
                     CALL artt300_imba146_ref()
                     #160824-00007#162 20161125 add by beckxie---E
                     CALL artt300_imba006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_imba_m.imba104) THEN
                     LET g_imba_m.imba104 = g_imba_m.imba006
                     CALL artt300_imba104_ref()
                  END IF
                  #add--2015/05/19 By geza--(S)
                  IF cl_null(g_imba_m.imba105) THEN
                     LET g_imba_m.imba105 = g_imba_m.imba006
                     CALL artt300_imba105_ref()
                  END IF
                  IF cl_null(g_imba_m.imba107) THEN
                     LET g_imba_m.imba107 = g_imba_m.imba006
                     CALL artt300_imba107_ref()
                  END IF
                  IF cl_null(g_imba_m.imba106) THEN
                     LET g_imba_m.imba106 = g_imba_m.imba006
                     CALL artt300_imba106_ref()
                  END IF
                  IF cl_null(g_imba_m.imba145) THEN
                     LET g_imba_m.imba145 = g_imba_m.imba006
                     CALL artt300_imba145_ref()
                  END IF
                  IF cl_null(g_imba_m.imba146) THEN
                     LET g_imba_m.imba146 = g_imba_m.imba006
                     CALL artt300_imba146_ref()
                  END IF
                  #add--2015/05/19 By geza--(E)
               END IF
            END IF
            CALL artt300_imba006_ref()
            LET g_imba_m_o.* = g_imba_m.*   #160824-00007#162 20161125 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba006
            #add-point:BEFORE FIELD imba006 name="input.b.imba006"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba006
            #add-point:ON CHANGE imba006 name="input.g.imba006"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba105
            
            #add-point:AFTER FIELD imba105 name="input.a.imba105"
                                    LET g_imba_m.imba105_desc = ' '
            DISPLAY BY NAME g_imba_m.imba105_desc
            IF NOT cl_null(g_imba_m.imba105) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba105 != g_imba_m_t.imba105 OR g_imba_m_t.imba105 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba105 != g_imba_m_t.imba105 OR cl_null(g_imba_m_t.imba105))) THEN   #150427-00012#6 20150707 add by beckxie
                  #150507-00009#1 Add-S By Ken 150525 檢查庫存單位與銷售單位之間是否存在換算率
                  IF NOT cl_null(g_imba_m.imba104) THEN
                     IF NOT artt300_chk_imba105() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba105
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 銷售單位[",g_imba_m.imba105,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba105 = g_imba_m_t.imba105
                        CALL artt300_imba105_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF
                  #150507-00009#1 Add-E By Ken 150525
                  CALL artt300_chk_unit(g_imba_m.imba105) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba105
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba105 = g_imba_m_t.imba105
                     CALL artt300_imba105_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba105_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba105
            #add-point:BEFORE FIELD imba105 name="input.b.imba105"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba105
            #add-point:ON CHANGE imba105 name="input.g.imba105"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba104
            
            #add-point:AFTER FIELD imba104 name="input.a.imba104"
                                    LET g_imba_m.imba104_desc = ' '
            DISPLAY BY NAME g_imba_m.imba104_desc
            IF NOT cl_null(g_imba_m.imba104) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba104 != g_imba_m_t.imba104 OR g_imba_m_t.imba104 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba104 != g_imba_m_t.imba104 OR cl_null(g_imba_m_t.imba104))) THEN   #150427-00012#6 20150707 add by beckxie
                  #150507-00009#1 Add-S By Ken 150525 檢查庫存單位與銷售、銷售計價、採購單位之間是否存在換算率
                  IF NOT cl_null(g_imba_m.imba105) THEN
                     IF NOT artt300_chk_imba105() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba104
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 銷售單位[",g_imba_m.imba105,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba104 = g_imba_m_t.imba104
                        CALL artt300_imba104_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF
                  
                  IF NOT cl_null(g_imba_m.imba106) THEN
                     IF NOT artt300_chk_imba106() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba104
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 計價單位[",g_imba_m.imba106,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba104 = g_imba_m_t.imba104
                        CALL artt300_imba104_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF

                  IF NOT cl_null(g_imba_m.imba107) THEN
                     IF NOT artt300_chk_imba107() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba104
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 採購單位[",g_imba_m.imba107,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba104 = g_imba_m_t.imba104
                        CALL artt300_imba104_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF
                  #150507-00009#1 Add-E By Ken 150525 
                  
                  CALL artt300_chk_unit(g_imba_m.imba104) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba104
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba104 = g_imba_m_t.imba104
                     CALL artt300_imba104_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba104_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba104
            #add-point:BEFORE FIELD imba104 name="input.b.imba104"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba104
            #add-point:ON CHANGE imba104 name="input.g.imba104"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba107
            
            #add-point:AFTER FIELD imba107 name="input.a.imba107"
                                    LET g_imba_m.imba107_desc = ' '
            DISPLAY BY NAME g_imba_m.imba107_desc
            IF NOT cl_null(g_imba_m.imba107) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba107 != g_imba_m_t.imba107 OR g_imba_m_t.imba107 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba107 != g_imba_m_t.imba107 OR cl_null(g_imba_m_t.imba107))) THEN   #150427-00012#6 20150707 add by beckxie
                  #150507-00009#1 Add-S By Ken 150525 檢查庫存單位與採購單位之間是否存在換算率
                  IF NOT cl_null(g_imba_m.imba104) THEN
                     IF NOT artt300_chk_imba107() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba107
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 採購單位[",g_imba_m.imba107,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba107 = g_imba_m_t.imba107
                        CALL artt300_imba107_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF
                  #150507-00009#1 Add-E By Ken 150525                  
                  
                  CALL artt300_chk_unit(g_imba_m.imba107) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba107
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba107 = g_imba_m_t.imba107
                     CALL artt300_imba107_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba107_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba107
            #add-point:BEFORE FIELD imba107 name="input.b.imba107"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba107
            #add-point:ON CHANGE imba107 name="input.g.imba107"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba106
            
            #add-point:AFTER FIELD imba106 name="input.a.imba106"
                                    LET g_imba_m.imba106_desc = ' '
            DISPLAY BY NAME g_imba_m.imba106_desc
            IF NOT cl_null(g_imba_m.imba106) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba106 != g_imba_m_t.imba106 OR g_imba_m_t.imba106 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba106 != g_imba_m_t.imba106 OR cl_null(g_imba_m_t.imba106))) THEN   #150427-00012#6 20150707 add by beckxie
                  #150507-00009#1 Add-S By Ken 150525 檢查庫存單位與銷售計價單位之間是否存在換算率
                  IF NOT cl_null(g_imba_m.imba104) THEN
                     IF NOT artt300_chk_imba106() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'sub-00015'
                        LET g_errparam.extend = g_imba_m.imba106
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = " 庫存單位[",g_imba_m.imba104,"]"
                        LET g_errparam.replace[2] = " 計價單位[",g_imba_m.imba106,"]"
                        CALL cl_err()
                     
                        LET g_imba_m.imba106 = g_imba_m_t.imba106
                        CALL artt300_imba106_ref()
                        NEXT FIELD CURRENT
                     END IF                         
                  END IF
                  #150507-00009#1 Add-E By Ken 150525                     
                  
                  CALL artt300_chk_unit(g_imba_m.imba106) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba106
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba106 = g_imba_m_o.imba106
                     CALL artt300_imba106_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_artt300_unit_trans_chk(g_imba_m.imbadocno,g_imba_m.imba106) THEN
                     LET g_imba_m.imba106 = g_imba_m_t.imba106
                     CALL artt300_imba106_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba106_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba106
            #add-point:BEFORE FIELD imba106 name="input.b.imba106"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba106
            #add-point:ON CHANGE imba106 name="input.g.imba106"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba145
            
            #add-point:AFTER FIELD imba145 name="input.a.imba145"
            LET g_imba_m.imba145_desc = ' '
            DISPLAY BY NAME g_imba_m.imba145_desc
            IF NOT cl_null(g_imba_m.imba145) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba145 != g_imba_m_t.imba145 OR g_imba_m_t.imba145 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba145 != g_imba_m_t.imba145 OR cl_null(g_imba_m_t.imba145))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imba_m.imba145) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba145
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba145 = g_imba_m_t.imba145
                     CALL artt300_imba145_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba145_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba145
            #add-point:BEFORE FIELD imba145 name="input.b.imba145"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba145
            #add-point:ON CHANGE imba145 name="input.g.imba145"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba146
            
            #add-point:AFTER FIELD imba146 name="input.a.imba146"
            LET g_imba_m.imba146_desc = ' '
            DISPLAY BY NAME g_imba_m.imba146_desc
            IF NOT cl_null(g_imba_m.imba146) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba146 != g_imba_m_t.imba146 OR g_imba_m_t.imba146 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba146 != g_imba_m_t.imba146 OR cl_null(g_imba_m_t.imba146))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imba_m.imba146) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba146
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba146 = g_imba_m_t.imba146
                     CALL artt300_imba146_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba146_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba146
            #add-point:BEFORE FIELD imba146 name="input.b.imba146"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba146
            #add-point:ON CHANGE imba146 name="input.g.imba146"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba113
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba113,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba113
            END IF 
 
 
 
            #add-point:AFTER FIELD imba113 name="input.a.imba113"
            IF cl_null(g_imba_m.imba113) THEN 
               LET g_imba_m.imba113 = 1
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba113
            #add-point:BEFORE FIELD imba113 name="input.b.imba113"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba113
            #add-point:ON CHANGE imba113 name="input.g.imba113"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba005
            
            #add-point:AFTER FIELD imba005 name="input.a.imba005"
            LET g_imba_m.imba005_desc = ''
            DISPLAY BY NAME g_imba_m.imba005_desc 
            IF NOT cl_null(g_imba_m.imba005) THEN
               #150427-00012#6 150529 mark by beckxie
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_imba_m_o.imba005) OR g_imba_m.imba005 <> g_imba_m_o.imba005)) THEN
               IF cl_null(g_imba_m_o.imba005) OR g_imba_m.imba005 <> g_imba_m_o.imba005 THEN   #150427-00012#6 150529 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imba_m.imba005
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00159:sub-01302|aimi092|",cl_get_progname("aimi092",g_lang,"2"),"|:EXEPROGaimi092"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_imea001") THEN
                     LET g_imba_m.imba005 = g_imba_m_o.imba005
                     CALL artt300_imba005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF p_cmd = 'u' AND g_imba_m.imba005 <> g_imba_m_o.imba005 THEN
                  DELETE FROM imbk_t WHERE imbkent = g_enterprise AND imbk001 = g_imba_m.imba001
               END IF
               #150427-00012#6 150529 mark by beckxie
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_imba_m_o.imba005) OR g_imba_m.imba005 <> g_imba_m_o.imba005)) THEN
               IF cl_null(g_imba_m_o.imba005) OR g_imba_m.imba005 <> g_imba_m_o.imba005 THEN   #150427-00012#6 150529 add by beckxie
                  IF NOT artt300_ins_imbk() THEN
                     LET g_imba_m.imba005 = g_imba_m_o.imba005
                     CALL artt300_imba005_ref()
                     NEXT FIELD imba005
                  END IF
                  CALL aimt300_01(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba005)
                  IF INT_FLAG THEN
                     LET INT_FLAG = 0
                  END IF
               END IF
            END IF
            LET g_imba_m_o.imba005 = g_imba_m.imba005
            CALL artt300_imba005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba005
            #add-point:BEFORE FIELD imba005 name="input.b.imba005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba005
            #add-point:ON CHANGE imba005 name="input.g.imba005"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba142
            
            #add-point:AFTER FIELD imba142 name="input.a.imba142"
            LET g_imba_m.imba142_desc = NULL
            DISPLAY BY NAME g_imba_m.imba142_desc
            IF NOT cl_null(g_imba_m.imba142) THEN
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imba_m.imba142 != g_imba_m_t.imba142 OR g_imba_m_t.imba142 IS null)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imba_m.imba142 != g_imba_m_t.imba142 OR cl_null(g_imba_m_t.imba142))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL s_aooi500_chk(g_prog,'imbaunit',g_imba_m.imba142,g_site)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_imba_m.imba142
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_imba_m.imba142 = g_imba_m_t.imba142
                     CALL artt300_imba142_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba142_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba142
            #add-point:BEFORE FIELD imba142 name="input.b.imba142"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba142
            #add-point:ON CHANGE imba142 name="input.g.imba142"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaacti
            #add-point:BEFORE FIELD imbaacti name="input.b.imbaacti"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaacti
            
            #add-point:AFTER FIELD imbaacti name="input.a.imbaacti"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbaacti
            #add-point:ON CHANGE imbaacti name="input.g.imbaacti"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba019
            END IF 
 
 
 
            #add-point:AFTER FIELD imba019 name="input.a.imba019"
            IF NOT cl_null(g_imba_m.imba019) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba019
            #add-point:BEFORE FIELD imba019 name="input.b.imba019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba019
            #add-point:ON CHANGE imba019 name="input.g.imba019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba020
            END IF 
 
 
 
            #add-point:AFTER FIELD imba020 name="input.a.imba020"
            IF NOT cl_null(g_imba_m.imba020) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba020
            #add-point:BEFORE FIELD imba020 name="input.b.imba020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba020
            #add-point:ON CHANGE imba020 name="input.g.imba020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba021
            END IF 
 
 
 
            #add-point:AFTER FIELD imba021 name="input.a.imba021"
            IF NOT cl_null(g_imba_m.imba021) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba021
            #add-point:BEFORE FIELD imba021 name="input.b.imba021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba021
            #add-point:ON CHANGE imba021 name="input.g.imba021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba022
            
            #add-point:AFTER FIELD imba022 name="input.a.imba022"
            LET g_imba_m.imba022_desc = ' '
            DISPLAY BY NAME g_imba_m.imba022_desc
            IF NOT cl_null(g_imba_m.imba022) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba022 != g_imba_m_t.imba022 OR g_imba_m_t.imba022 IS NULL)) THEN   #150427-00012#6 20150707 add by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba022 != g_imba_m_t.imba022 OR cl_null(g_imba_m_t.imba022))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imba_m.imba022) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba022
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba022 = g_imba_m_t.imba022
                     CALL artt300_imba022_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba022_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba022
            #add-point:BEFORE FIELD imba022 name="input.b.imba022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba022
            #add-point:ON CHANGE imba022 name="input.g.imba022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba025
            END IF 
 
 
 
            #add-point:AFTER FIELD imba025 name="input.a.imba025"
            IF NOT cl_null(g_imba_m.imba025) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba025
            #add-point:BEFORE FIELD imba025 name="input.b.imba025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba025
            #add-point:ON CHANGE imba025 name="input.g.imba025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba026
            
            #add-point:AFTER FIELD imba026 name="input.a.imba026"
            LET g_imba_m.imba026_desc = ' '
            DISPLAY BY NAME g_imba_m.imba026_desc
            IF NOT cl_null(g_imba_m.imba026) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba026 != g_imba_m_t.imba026 OR g_imba_m_t.imba026 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba026 != g_imba_m_t.imba026 OR cl_null(g_imba_m_t.imba026))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imba_m.imba026) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba026
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba026 = g_imba_m_t.imba026
                     CALL artt300_imba026_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba026_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba026
            #add-point:BEFORE FIELD imba026 name="input.b.imba026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba026
            #add-point:ON CHANGE imba026 name="input.g.imba026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba016,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba016
            END IF 
 
 
 
            #add-point:AFTER FIELD imba016 name="input.a.imba016"
            IF NOT cl_null(g_imba_m.imba016) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba016
            #add-point:BEFORE FIELD imba016 name="input.b.imba016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba016
            #add-point:ON CHANGE imba016 name="input.g.imba016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba018
            
            #add-point:AFTER FIELD imba018 name="input.a.imba018"
            LET g_imba_m.imba018_desc = ' '
            DISPLAY BY NAME g_imba_m.imba018_desc
            IF NOT cl_null(g_imba_m.imba018) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba018 != g_imba_m_t.imba018 OR g_imba_m_t.imba018 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba018 != g_imba_m_t.imba018 OR cl_null(g_imba_m_t.imba018))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imba_m.imba018) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba018
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba018 = g_imba_m_t.imba018
                     CALL artt300_imba018_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba018_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba018
            #add-point:BEFORE FIELD imba018 name="input.b.imba018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba018
            #add-point:ON CHANGE imba018 name="input.g.imba018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba010
            #add-point:BEFORE FIELD imba010 name="input.b.imba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba010
            
            #add-point:AFTER FIELD imba010 name="input.a.imba010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba010
            #add-point:ON CHANGE imba010 name="input.g.imba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbastus
            #add-point:BEFORE FIELD imbastus name="input.b.imbastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbastus
            
            #add-point:AFTER FIELD imbastus name="input.a.imbastus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbastus
            #add-point:ON CHANGE imbastus name="input.g.imbastus"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba009
            
            #add-point:AFTER FIELD imba009 name="input.a.imba009"
            LET g_imba_m.imba009_desc = ' '
            DISPLAY BY NAME g_imba_m.imba009_desc
            IF NOT cl_null(g_imba_m.imba009) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba009 != g_imba_m_t.imba009 OR g_imba_m_t.imba009 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF (g_imba_m.imba009 != g_imba_m_o.imba009) OR cl_null(g_imba_m_o.imba009) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba009() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba009 = g_imba_m_o.imba009
                     LET g_imba_m.imba147 = g_imba_m_o.imba147
                     LET g_imba_m.imba149 = g_imba_m_o.imba149
                     CALL artt300_imba009_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #150507-00001#2 Add By Ken 150521
                  CALL artt300_get_rtax010(g_imba_m.imba009) RETURNING g_imba_m.imba147,g_imba_m.imba149
                  #150507-00001#2 Add By Ken 150521                  
               END IF
            END IF
            IF NOT cl_null(g_imba_m.imba143) THEN
               CALL artt300_chk_imba143('2')
               IF NOT cl_null(g_errno) THEN
                  IF cl_ask_confirm('art-00379') THEN
                     LET g_imba_m.imba143 = ''
                     LET g_imba_m.imba143_desc = ''
                     DISPLAY BY NAME g_imba_m.imba143,g_imba_m.imba143_desc
                  ELSE
                     LET g_imba_m.imba009 = g_imba_m_o.imba009
                     LET g_imba_m.imba147 = g_imba_m_o.imba147
                     LET g_imba_m.imba149 = g_imba_m_o.imba149                     
                     CALL artt300_imba009_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_imba_m_o.imba009 = g_imba_m.imba009
            LET g_imba_m_o.imba147 = g_imba_m.imba147
            LET g_imba_m_o.imba149 = g_imba_m.imba149
            CALL artt300_imba009_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba009
            #add-point:BEFORE FIELD imba009 name="input.b.imba009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba009
            #add-point:ON CHANGE imba009 name="input.g.imba009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba161
            
            #add-point:AFTER FIELD imba161 name="input.a.imba161"
            #160705-00013#3 160712 by lori add---(S)
            LET g_imba_m.imba161_desc = ' '
            DISPLAY BY NAME g_imba_m.imba161_desc
            IF NOT cl_null(g_imba_m.imba161) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba161 != g_imba_m_t.imba161 OR g_imba_m_t.imba161 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imba_m.imba161
                  IF NOT cl_chk_exist("v_pcba001") THEN
                     LET g_imba_m.imba161 = g_imba_m_t.imba161
                     LET g_imba_m.imba161_desc = s_desc_pcba001_desc(g_imba_m.imba161)
                     DISPLAY BY NAME g_imba_m.imba161,g_imba_m.imba161_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_imba_m.imba161_desc = s_desc_pcba001_desc(g_imba_m.imba161)
            DISPLAY BY NAME g_imba_m.imba161_desc
            #160705-00013#3 160712 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba161
            #add-point:BEFORE FIELD imba161 name="input.b.imba161"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba161
            #add-point:ON CHANGE imba161 name="input.g.imba161"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba101
            
            #add-point:AFTER FIELD imba101 name="input.a.imba101"
                                    LET g_imba_m.imba101_desc = ' '
            DISPLAY BY NAME g_imba_m.imba101_desc
            IF NOT cl_null(g_imba_m.imba101) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba101 != g_imba_m_t.imba101 OR g_imba_m_t.imba101 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba101 != g_imba_m_t.imba101 OR cl_null(g_imba_m_t.imba101))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba101() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba101
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba101 = g_imba_m_t.imba101
                     CALL artt300_imba101_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba101_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba101
            #add-point:BEFORE FIELD imba101 name="input.b.imba101"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba101
            #add-point:ON CHANGE imba101 name="input.g.imba101"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba118
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba118,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba118
            END IF 
 
 
 
            #add-point:AFTER FIELD imba118 name="input.a.imba118"
            IF cl_null(g_imba_m.imba118) THEN
               LET g_imba_m.imba118 = 0
            END IF
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba118
            #add-point:BEFORE FIELD imba118 name="input.b.imba118"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba118
            #add-point:ON CHANGE imba118 name="input.g.imba118"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba119,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba119
            END IF 
 
 
 
            #add-point:AFTER FIELD imba119 name="input.a.imba119"
                                    IF cl_null(g_imba_m.imba119) THEN
               LET g_imba_m.imba119 = 0
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba119
            #add-point:BEFORE FIELD imba119 name="input.b.imba119"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba119
            #add-point:ON CHANGE imba119 name="input.g.imba119"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba120
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba120,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba120
            END IF 
 
 
 
            #add-point:AFTER FIELD imba120 name="input.a.imba120"
                                    IF cl_null(g_imba_m.imba120) THEN
               LET g_imba_m.imba120 = 0
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba120
            #add-point:BEFORE FIELD imba120 name="input.b.imba120"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba120
            #add-point:ON CHANGE imba120 name="input.g.imba120"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba114
            
            #add-point:AFTER FIELD imba114 name="input.a.imba114"
                                    LET g_imba_m.imba114_desc = ' '
            DISPLAY BY NAME g_imba_m.imba114_desc
            IF NOT cl_null(g_imba_m.imba114) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba114 != g_imba_m_t.imba114 OR g_imba_m_t.imba114 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba114 != g_imba_m_t.imba114 OR cl_null(g_imba_m_t.imba114))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba114() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba114
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi140'
                           LET g_errparam.replace[2] = cl_get_progname('aooi140',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi140'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba114 = g_imba_m_t.imba114
                     CALL artt300_imba114_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba114_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba114
            #add-point:BEFORE FIELD imba114 name="input.b.imba114"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba114
            #add-point:ON CHANGE imba114 name="input.g.imba114"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba115
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba115,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba115
            END IF 
 
 
 
            #add-point:AFTER FIELD imba115 name="input.a.imba115"
                                    IF cl_null(g_imba_m.imba115) THEN
               LET g_imba_m.imba115 = 0
            END IF
            CALL artt300_cal_imba117()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba115
            #add-point:BEFORE FIELD imba115 name="input.b.imba115"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba115
            #add-point:ON CHANGE imba115 name="input.g.imba115"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba116
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba116,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba116
            END IF 
 
 
 
            #add-point:AFTER FIELD imba116 name="input.a.imba116"
                                    IF cl_null(g_imba_m.imba116) THEN
               LET g_imba_m.imba116 = 0
            END IF
            CALL artt300_cal_imba117()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba116
            #add-point:BEFORE FIELD imba116 name="input.b.imba116"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba116
            #add-point:ON CHANGE imba116 name="input.g.imba116"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba117
            #add-point:BEFORE FIELD imba117 name="input.b.imba117"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba117
            
            #add-point:AFTER FIELD imba117 name="input.a.imba117"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba117
            #add-point:ON CHANGE imba117 name="input.g.imba117"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba124
            
            #add-point:AFTER FIELD imba124 name="input.a.imba124"
                                    LET g_imba_m.imba124_desc = ' '
            DISPLAY BY NAME g_imba_m.imba124_desc
            IF NOT cl_null(g_imba_m.imba124) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba124 != g_imba_m_t.imba124 OR g_imba_m_t.imba124 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba124 != g_imba_m_t.imba124 OR cl_null(g_imba_m_t.imba124))) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_imba124() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba124
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba124 = g_imba_m_t.imba124
                     CALL artt300_imba124_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba124_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba124
            #add-point:BEFORE FIELD imba124 name="input.b.imba124"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba124
            #add-point:ON CHANGE imba124 name="input.g.imba124"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf122
            #add-point:BEFORE FIELD imbf122 name="input.b.imbf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf122
            
            #add-point:AFTER FIELD imbf122 name="input.a.imbf122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf122
            #add-point:ON CHANGE imbf122 name="input.g.imbf122"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf115
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imbf115,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD imbf115
            END IF 
 
 
 
            #add-point:AFTER FIELD imbf115 name="input.a.imbf115"
            IF NOT cl_null(g_imba_m.imbf115) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf115
            #add-point:BEFORE FIELD imbf115 name="input.b.imbf115"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf115
            #add-point:ON CHANGE imbf115 name="input.g.imbf115"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf114
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imbf114,"1","1","","","azz-00079",1) THEN
               NEXT FIELD imbf114
            END IF 
 
 
 
            #add-point:AFTER FIELD imbf114 name="input.a.imbf114"
            IF NOT cl_null(g_imba_m.imbf114) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf114
            #add-point:BEFORE FIELD imbf114 name="input.b.imbf114"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf114
            #add-point:ON CHANGE imbf114 name="input.g.imbf114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf116
            #add-point:BEFORE FIELD imbf116 name="input.b.imbf116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf116
            
            #add-point:AFTER FIELD imbf116 name="input.a.imbf116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf116
            #add-point:ON CHANGE imbf116 name="input.g.imbf116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba110
            #add-point:BEFORE FIELD imba110 name="input.b.imba110"
                                    CALL artt300_set_entry(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba110
            
            #add-point:AFTER FIELD imba110 name="input.a.imba110"
                                    IF g_imba_m.imba110 = 'N' THEN
               LET g_imba_m.imba111 = ''
               LET g_imba_m.imba112 = ''               
            ELSE
               LET g_imba_m.imba111 = g_imba_m_t.imba111
               LET g_imba_m.imba112 = g_imba_m_t.imba112               
            END IF
            DISPLAY BY NAME g_imba_m.imba111,g_imba_m.imba112
            CALL artt300_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba110
            #add-point:ON CHANGE imba110 name="input.g.imba110"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba111
            #add-point:BEFORE FIELD imba111 name="input.b.imba111"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba111
            
            #add-point:AFTER FIELD imba111 name="input.a.imba111"
                                    IF NOT cl_null(g_imba_m.imba111) AND NOT cl_null(g_imba_m.imba112) THEN
               IF g_imba_m.imba111 > g_imba_m.imba112 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = g_imba_m.imba111
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba111 = g_imba_m_t.imba111
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba111
            #add-point:ON CHANGE imba111 name="input.g.imba111"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba112
            #add-point:BEFORE FIELD imba112 name="input.b.imba112"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba112
            
            #add-point:AFTER FIELD imba112 name="input.a.imba112"
                                    IF NOT cl_null(g_imba_m.imba111) AND NOT cl_null(g_imba_m.imba112) THEN
               IF g_imba_m.imba111 > g_imba_m.imba112 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = g_imba_m.imba111
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba112 = g_imba_m_t.imba112
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba112
            #add-point:ON CHANGE imba112 name="input.g.imba112"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba125
            #add-point:BEFORE FIELD imba125 name="input.b.imba125"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba125
            
            #add-point:AFTER FIELD imba125 name="input.a.imba125"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba125
            #add-point:ON CHANGE imba125 name="input.g.imba125"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba121
            #add-point:BEFORE FIELD imba121 name="input.b.imba121"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba121
            
            #add-point:AFTER FIELD imba121 name="input.a.imba121"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba121
            #add-point:ON CHANGE imba121 name="input.g.imba121"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba144
            #add-point:BEFORE FIELD imba144 name="input.b.imba144"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba144
            
            #add-point:AFTER FIELD imba144 name="input.a.imba144"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba144
            #add-point:ON CHANGE imba144 name="input.g.imba144"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba122
            
            #add-point:AFTER FIELD imba122 name="input.a.imba122"
                                    LET g_imba_m.imba122_desc = ' '
            DISPLAY BY NAME g_imba_m.imba122_desc
            IF NOT cl_null(g_imba_m.imba122) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba122 != g_imba_m_t.imba122 OR g_imba_m_t.imba122 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba122 != g_imba_m_t.imba122 OR cl_null(g_imba_m_t.imba122))) THEN   #150427-00012#6 20150707 add by beckxie
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2000',g_imba_m.imba122) THEN
                     LET g_imba_m.imba122 = g_imba_m_t.imba122
                     CALL artt300_imba122_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba122_ref()          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba122
            #add-point:BEFORE FIELD imba122 name="input.b.imba122"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba122
            #add-point:ON CHANGE imba122 name="input.g.imba122"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba123
            #add-point:BEFORE FIELD imba123 name="input.b.imba123"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba123
            
            #add-point:AFTER FIELD imba123 name="input.a.imba123"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba123
            #add-point:ON CHANGE imba123 name="input.g.imba123"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba131
            
            #add-point:AFTER FIELD imba131 name="input.a.imba131"
                                    LET g_imba_m.imba131_desc = ' '
            DISPLAY BY NAME g_imba_m.imba131_desc
            IF NOT cl_null(g_imba_m.imba131) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba131 != g_imba_m_t.imba131 OR g_imba_m_t.imba131 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba131 != g_imba_m_t.imba131 OR cl_null(g_imba_m_t.imba131))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2001',g_imba_m.imba131) THEN
                     LET g_imba_m.imba131 = g_imba_m_t.imba131
                     CALL artt300_imba131_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba131_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba131
            #add-point:BEFORE FIELD imba131 name="input.b.imba131"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba131
            #add-point:ON CHANGE imba131 name="input.g.imba131"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba126
            
            #add-point:AFTER FIELD imba126 name="input.a.imba126"
            LET g_imba_m.imba126_desc = ' '
            DISPLAY BY NAME g_imba_m.imba126_desc
            IF NOT cl_null(g_imba_m.imba126) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba126 != g_imba_m_t.imba126 OR g_imba_m_t.imba126 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba126 != g_imba_m_t.imba126 OR cl_null(g_imba_m_t.imba126))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2002',g_imba_m.imba126) THEN
                     LET g_imba_m.imba126 = g_imba_m_t.imba126
                     CALL artt300_imba126_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imba_m.imba143) THEN
               CALL artt300_chk_imba143('2')
               IF NOT cl_null(g_errno) THEN
                  IF cl_ask_confirm('art-00379') THEN
                     LET g_imba_m.imba143 = ''
                     LET g_imba_m.imba143_desc = ''
                     DISPLAY BY NAME g_imba_m.imba143,g_imba_m.imba143_desc
                  ELSE
                     LET g_imba_m.imba126 = g_imba_m_t.imba126
                     CALL artt300_imba126_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba126_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba126
            #add-point:BEFORE FIELD imba126 name="input.b.imba126"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba126
            #add-point:ON CHANGE imba126 name="input.g.imba126"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba127
            
            #add-point:AFTER FIELD imba127 name="input.a.imba127"
                                    LET g_imba_m.imba127_desc = ' '
            DISPLAY BY NAME g_imba_m.imba127_desc
            IF NOT cl_null(g_imba_m.imba127) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba127 != g_imba_m_t.imba127 OR g_imba_m_t.imba127 IS NULL)) THEN   #150427-00012#6 20150707 add by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba127 != g_imba_m_t.imba127 OR cl_null(g_imba_m_t.imba127))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2003',g_imba_m.imba127) THEN
                     LET g_imba_m.imba127 = g_imba_m_t.imba127
                     CALL artt300_imba127_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba127_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba127
            #add-point:BEFORE FIELD imba127 name="input.b.imba127"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba127
            #add-point:ON CHANGE imba127 name="input.g.imba127"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba128
            
            #add-point:AFTER FIELD imba128 name="input.a.imba128"
                                    LET g_imba_m.imba128_desc = ' '
            DISPLAY BY NAME g_imba_m.imba128_desc
            IF NOT cl_null(g_imba_m.imba128) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba128 != g_imba_m_t.imba105 OR g_imba_m_t.imba128 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba128 != g_imba_m_t.imba105 OR cl_null(g_imba_m_t.imba128))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2004',g_imba_m.imba128) THEN
                     LET g_imba_m.imba128 = g_imba_m_t.imba128
                     CALL artt300_imba128_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba128_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba128
            #add-point:BEFORE FIELD imba128 name="input.b.imba128"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba128
            #add-point:ON CHANGE imba128 name="input.g.imba128"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba129
            
            #add-point:AFTER FIELD imba129 name="input.a.imba129"
                                    LET g_imba_m.imba129_desc = ' '
            DISPLAY BY NAME g_imba_m.imba129_desc
            IF NOT cl_null(g_imba_m.imba129) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba129 != g_imba_m_t.imba129 OR g_imba_m_t.imba129 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba129 != g_imba_m_t.imba129 OR cl_null(g_imba_m_t.imba129))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2005',g_imba_m.imba129) THEN
                     LET g_imba_m.imba129 = g_imba_m_t.imba129
                     CALL artt300_imba129_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba129_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba129
            #add-point:BEFORE FIELD imba129 name="input.b.imba129"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba129
            #add-point:ON CHANGE imba129 name="input.g.imba129"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba143
            
            #add-point:AFTER FIELD imba143 name="input.a.imba143"
            LET g_imba_m.imba143_desc = ' '
            DISPLAY BY NAME g_imba_m.imba143_desc
            IF NOT cl_null(g_imba_m.imba143) THEN
               #150427-00012#6 150529 mark by beckxie
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_imba_m.imba143 != g_imba_m_o.imba143 OR g_imba_m_o.imba143 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imba_m.imba143 != g_imba_m_o.imba143 OR cl_null(g_imba_m_o.imba143) THEN   #150427-00012#6 150529 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imba_m.imba143
                  IF NOT cl_chk_exist("v_dbba001") THEN
                     LET g_imba_m.imba143 = g_imba_m_o.imba143
                     CALL artt300_imba143_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL artt300_chk_imba143('1')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imba_m.imba143 = g_imba_m_o.imba143
                     CALL artt300_imba143_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba143_ref()
            LET g_imba_m_o.imba143 = g_imba_m.imba143
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba143
            #add-point:BEFORE FIELD imba143 name="input.b.imba143"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba143
            #add-point:ON CHANGE imba143 name="input.g.imba143"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba130
            #add-point:BEFORE FIELD imba130 name="input.b.imba130"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba130
            
            #add-point:AFTER FIELD imba130 name="input.a.imba130"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba130
            #add-point:ON CHANGE imba130 name="input.g.imba130"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba150
            #add-point:BEFORE FIELD imba150 name="input.b.imba150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba150
            
            #add-point:AFTER FIELD imba150 name="input.a.imba150"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba150
            #add-point:ON CHANGE imba150 name="input.g.imba150"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba151
            #add-point:BEFORE FIELD imba151 name="input.b.imba151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba151
            
            #add-point:AFTER FIELD imba151 name="input.a.imba151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba151
            #add-point:ON CHANGE imba151 name="input.g.imba151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba152
            #add-point:BEFORE FIELD imba152 name="input.b.imba152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba152
            
            #add-point:AFTER FIELD imba152 name="input.a.imba152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba152
            #add-point:ON CHANGE imba152 name="input.g.imba152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba153
            #add-point:BEFORE FIELD imba153 name="input.b.imba153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba153
            
            #add-point:AFTER FIELD imba153 name="input.a.imba153"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba153
            #add-point:ON CHANGE imba153 name="input.g.imba153"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba132
            
            #add-point:AFTER FIELD imba132 name="input.a.imba132"
                                    LET g_imba_m.imba132_desc = ' '
            DISPLAY BY NAME g_imba_m.imba132_desc
            IF NOT cl_null(g_imba_m.imba132) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba132 != g_imba_m_t.imba132 OR g_imba_m_t.imba132 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba132 != g_imba_m_t.imba132 OR cl_null(g_imba_m_t.imba132))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2006',g_imba_m.imba132) THEN
                     LET g_imba_m.imba132 = g_imba_m_t.imba132
                     CALL artt300_imba132_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba132_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba132
            #add-point:BEFORE FIELD imba132 name="input.b.imba132"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba132
            #add-point:ON CHANGE imba132 name="input.g.imba132"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba133
            
            #add-point:AFTER FIELD imba133 name="input.a.imba133"
                                    LET g_imba_m.imba133_desc = ' '
            DISPLAY BY NAME g_imba_m.imba133_desc
            IF NOT cl_null(g_imba_m.imba133) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba133 != g_imba_m_t.imba133 OR g_imba_m_t.imba133 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba133 != g_imba_m_t.imba133 OR cl_null(g_imba_m_t.imba133))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2007',g_imba_m.imba133) THEN
                     LET g_imba_m.imba133 = g_imba_m_t.imba133
                     CALL artt300_imba133_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba133_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba133
            #add-point:BEFORE FIELD imba133 name="input.b.imba133"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba133
            #add-point:ON CHANGE imba133 name="input.g.imba133"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba134
            
            #add-point:AFTER FIELD imba134 name="input.a.imba134"
                                    LET g_imba_m.imba134_desc = ' '
            DISPLAY BY NAME g_imba_m.imba134_desc
            IF NOT cl_null(g_imba_m.imba134) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba134 != g_imba_m_t.imba134 OR g_imba_m_t.imba134 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba134 != g_imba_m_t.imba134 OR cl_null(g_imba_m_t.imba134))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2008',g_imba_m.imba134) THEN
                     LET g_imba_m.imba134 = g_imba_m_t.imba134
                     CALL artt300_imba134_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba134_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba134
            #add-point:BEFORE FIELD imba134 name="input.b.imba134"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba134
            #add-point:ON CHANGE imba134 name="input.g.imba134"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba135
            
            #add-point:AFTER FIELD imba135 name="input.a.imba135"
                                    LET g_imba_m.imba135_desc = ' '
            DISPLAY BY NAME g_imba_m.imba135_desc
            IF NOT cl_null(g_imba_m.imba135) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba135 != g_imba_m_t.imba135 OR g_imba_m_t.imba135 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba135 != g_imba_m_t.imba135 OR cl_null(g_imba_m_t.imba135))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2009',g_imba_m.imba135) THEN
                     LET g_imba_m.imba135 = g_imba_m_t.imba135
                     CALL artt300_imba135_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba135_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba135
            #add-point:BEFORE FIELD imba135 name="input.b.imba135"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba135
            #add-point:ON CHANGE imba135 name="input.g.imba135"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba136
            
            #add-point:AFTER FIELD imba136 name="input.a.imba136"
                                    LET g_imba_m.imba136_desc = ' '
            DISPLAY BY NAME g_imba_m.imba136_desc
            IF NOT cl_null(g_imba_m.imba136) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba136 != g_imba_m_t.imba136 OR g_imba_m_t.imba136 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba136 != g_imba_m_t.imba136 OR cl_null(g_imba_m_t.imba136))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2010',g_imba_m.imba136) THEN
                     LET g_imba_m.imba136 = g_imba_m_t.imba136
                     CALL artt300_imba136_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba136_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba136
            #add-point:BEFORE FIELD imba136 name="input.b.imba136"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba136
            #add-point:ON CHANGE imba136 name="input.g.imba136"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba137
            
            #add-point:AFTER FIELD imba137 name="input.a.imba137"
                                    LET g_imba_m.imba137_desc = ' '
            DISPLAY BY NAME g_imba_m.imba137_desc
            IF NOT cl_null(g_imba_m.imba137) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u'AND (g_imba_m.imba137 != g_imba_m_t.imba137 OR g_imba_m_t.imba137 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u'AND (g_imba_m.imba137 != g_imba_m_t.imba137 OR cl_null(g_imba_m_t.imba137))) THEN   #150427-00012#6 20150707 add by beckxie
                 
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2011',g_imba_m.imba137) THEN
                     LET g_imba_m.imba137 = g_imba_m_t.imba137
                     CALL artt300_imba137_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba137_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba137
            #add-point:BEFORE FIELD imba137 name="input.b.imba137"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba137
            #add-point:ON CHANGE imba137 name="input.g.imba137"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba138
            
            #add-point:AFTER FIELD imba138 name="input.a.imba138"
                                    LET g_imba_m.imba138_desc = ' '
            DISPLAY BY NAME g_imba_m.imba138_desc
            IF NOT cl_null(g_imba_m.imba138) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba138 != g_imba_m_t.imba138 OR g_imba_m_t.imba138 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba138 != g_imba_m_t.imba138 OR cl_null(g_imba_m_t.imba138))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2012',g_imba_m.imba138) THEN
                     LET g_imba_m.imba138 = g_imba_m_t.imba138
                     CALL artt300_imba138_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba138_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba138
            #add-point:BEFORE FIELD imba138 name="input.b.imba138"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba138
            #add-point:ON CHANGE imba138 name="input.g.imba138"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba139
            
            #add-point:AFTER FIELD imba139 name="input.a.imba139"
                                    LET g_imba_m.imba139_desc = ' '
            DISPLAY BY NAME g_imba_m.imba139_desc
            IF NOT cl_null(g_imba_m.imba139) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba139 != g_imba_m_t.imba139 OR g_imba_m_t.imba139 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba139 != g_imba_m_t.imba139 OR cl_null(g_imba_m_t.imba139))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2013',g_imba_m.imba139) THEN
                     LET g_imba_m.imba139 = g_imba_m_t.imba139
                     CALL artt300_imba139_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba139_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba139
            #add-point:BEFORE FIELD imba139 name="input.b.imba139"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba139
            #add-point:ON CHANGE imba139 name="input.g.imba139"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba140
            
            #add-point:AFTER FIELD imba140 name="input.a.imba140"
                                    LET g_imba_m.imba140_desc = ' '
            DISPLAY BY NAME g_imba_m.imba140_desc
            IF NOT cl_null(g_imba_m.imba140) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba140 != g_imba_m_t.imba140 OR g_imba_m_t.imba140 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba140 != g_imba_m_t.imba140 OR cl_null(g_imba_m_t.imba140))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2014',g_imba_m.imba140) THEN
                     LET g_imba_m.imba140 = g_imba_m_t.imba140
                     CALL artt300_imba140_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba140_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba140
            #add-point:BEFORE FIELD imba140 name="input.b.imba140"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba140
            #add-point:ON CHANGE imba140 name="input.g.imba140"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba141
            
            #add-point:AFTER FIELD imba141 name="input.a.imba141"
                                    LET g_imba_m.imba141_desc = ' '
            DISPLAY BY NAME g_imba_m.imba141_desc
            IF NOT cl_null(g_imba_m.imba141) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba141 != g_imba_m_t.imba141 OR g_imba_m_t.imba141 IS NULL)) THEN   #150427-00012#6 20150707 mark by beckxie
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba141 != g_imba_m_t.imba141 OR cl_null(g_imba_m_t.imba141))) THEN   #150427-00012#6 20150707 add by beckxie
                  
                  #160518-00046#1  by 08172
                  IF NOT s_azzi650_chk_exist('2015',g_imba_m.imba141) THEN
                     LET g_imba_m.imba141 = g_imba_m_t.imba141
                     CALL artt300_imba141_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt300_imba141_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba141
            #add-point:BEFORE FIELD imba141 name="input.b.imba141"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba141
            #add-point:ON CHANGE imba141 name="input.g.imba141"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf061
            #add-point:BEFORE FIELD imbf061 name="input.b.imbf061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf061
            
            #add-point:AFTER FIELD imbf061 name="input.a.imbf061"
            IF g_imba_m.imbf061 = '2' THEN
               LET g_imba_m.imbf062 = 'N'
               LET g_imba_m.imbf063 = ''
               LET g_imba_m.imbf063_desc = ''
               DISPLAY g_imba_m.imbf063_desc TO imbf063_desc
            END IF
            CALL artt300_set_entry(p_cmd)  
            CALL artt300_set_no_required(p_cmd)
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf061
            #add-point:ON CHANGE imbf061 name="input.g.imbf061"
            IF g_imba_m.imbf061 = '2' THEN
               LET g_imba_m.imbf062 = 'N'
               LET g_imba_m.imbf063 = ''
               LET g_imba_m.imbf063_desc = ''
               DISPLAY g_imba_m.imbf063_desc TO imbf063_desc
            END IF
            CALL artt300_set_entry(p_cmd)  
            CALL artt300_set_no_required(p_cmd)
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd) 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf062
            #add-point:BEFORE FIELD imbf062 name="input.b.imbf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf062
            
            #add-point:AFTER FIELD imbf062 name="input.a.imbf062"
            IF g_imba_m.imbf062 = 'N' THEN
               LET g_imba_m.imbf063 = ''
               LET g_imba_m.imbf063_desc = ''
               DISPLAY g_imba_m.imbf063_desc TO imbf063_desc
            END IF
            CALL artt300_set_entry(p_cmd)  
            CALL artt300_set_no_required(p_cmd)
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd)  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf062
            #add-point:ON CHANGE imbf062 name="input.g.imbf062"
            IF g_imba_m.imbf062 = 'N' THEN
               LET g_imba_m.imbf063 = ''
               LET g_imba_m.imbf063_desc = ''
               DISPLAY g_imba_m.imbf063_desc TO imbf063_desc
            END IF
            CALL artt300_set_entry(p_cmd)  
            CALL artt300_set_no_required(p_cmd)
            CALL artt300_set_required(p_cmd)
            CALL artt300_set_no_entry(p_cmd)  
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf063
            
            #add-point:AFTER FIELD imbf063 name="input.a.imbf063"
            IF NOT cl_null(g_imba_m.imbf063) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imba_m.imbf063

               #160318-00025#18  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#18  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofg001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbf063
            CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=' ' AND oofgl002=? AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbf063_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imba_m.imbf063_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf063
            #add-point:BEFORE FIELD imbf063 name="input.b.imbf063"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf063
            #add-point:ON CHANGE imbf063 name="input.g.imbf063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbf064
            #add-point:BEFORE FIELD imbf064 name="input.b.imbf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbf064
            
            #add-point:AFTER FIELD imbf064 name="input.a.imbf064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbf064
            #add-point:ON CHANGE imbf064 name="input.g.imbf064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba149
            #add-point:BEFORE FIELD imba149 name="input.b.imba149"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba149
            
            #add-point:AFTER FIELD imba149 name="input.a.imba149"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba149
            #add-point:ON CHANGE imba149 name="input.g.imba149"
            CALL artt300_set_no_required(p_cmd)    #160529-00002#1         
            CALL artt300_set_required(p_cmd)       #160529-00002#1
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba102,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba102
            END IF 
 
 
 
            #add-point:AFTER FIELD imba102 name="input.a.imba102"
            IF cl_null(g_imba_m.imba102) THEN
               LET g_imba_m.imba102 = 0
            END IF
            #150507-00001#2 Add By Ken 150521
            IF NOT cl_null(g_imba_m.imba102) THEN
               IF g_imba_m.imba102 != g_imba_m_o.imba102 OR cl_null(g_imba_m_o.imba102) THEN            
                  CALL artt300_get_imba148() RETURNING g_imba_m.imba148
               END IF
            END IF
            LET g_imba_m_o.imba102 = g_imba_m.imba102
            #150507-00001#2 Add By Ken 150521
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba102
            #add-point:BEFORE FIELD imba102 name="input.b.imba102"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba102
            #add-point:ON CHANGE imba102 name="input.g.imba102"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba103
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba103,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba103
            END IF 
 
 
 
            #add-point:AFTER FIELD imba103 name="input.a.imba103"
            IF cl_null(g_imba_m.imba103) THEN
               LET g_imba_m.imba103 = 0
            END IF
            #150507-00001#2 Add By Ken 150521
            IF NOT cl_null(g_imba_m.imba103) THEN
               IF g_imba_m.imba103 != g_imba_m_o.imba103 OR cl_null(g_imba_m_o.imba103) THEN            
                  CALL artt300_get_imba148() RETURNING g_imba_m.imba148
               END IF
            END IF
            LET g_imba_m_o.imba103 = g_imba_m.imba103            
            #150507-00001#2 Add By Ken 150521
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba103
            #add-point:BEFORE FIELD imba103 name="input.b.imba103"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba103
            #add-point:ON CHANGE imba103 name="input.g.imba103"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba147
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba147,"","","100","1","azz-00080",1) THEN
               NEXT FIELD imba147
            END IF 
 
 
 
            #add-point:AFTER FIELD imba147 name="input.a.imba147"
            #150507-00001#2 Add By Ken 150521
            IF NOT cl_null(g_imba_m.imba147) THEN
               IF g_imba_m.imba147 != g_imba_m_o.imba147 OR cl_null(g_imba_m_o.imba147) THEN            
                  CALL artt300_get_imba148() RETURNING g_imba_m.imba148
               END IF
            END IF
            LET g_imba_m_o.imba147 = g_imba_m.imba147
            #150507-00001#2 Add By Ken 150521
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba147
            #add-point:BEFORE FIELD imba147 name="input.b.imba147"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba147
            #add-point:ON CHANGE imba147 name="input.g.imba147"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba148
            #add-point:BEFORE FIELD imba148 name="input.b.imba148"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba148
            
            #add-point:AFTER FIELD imba148 name="input.a.imba148"
            LET g_imba_m_o.imba148 = g_imba_m.imba148  #150507-00001#2 Add By Ken 150521

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba148
            #add-point:ON CHANGE imba148 name="input.g.imba148"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba000
            #add-point:ON ACTION controlp INFIELD imba000 name="input.c.imba000"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocno
            #add-point:ON ACTION controlp INFIELD imbadocno name="input.c.imbadocno"
                                    #此段落由子樣板a07產生            
            #開窗i段
            IF p_cmd = 'a' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_imba_m.imbadocno             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = g_ooef004  #參照表編號
               LET g_qryparam.arg2 = g_prog
               
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_imba_m.imbadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_imba_m.imbadocno TO imbadocno           #顯示到畫面上
               NEXT FIELD imbadocno                              #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.imbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocdt
            #add-point:ON ACTION controlp INFIELD imbadocdt name="input.c.imbadocdt"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="input.c.imba001"
                                    #此段落由子樣板a07產生            
            #開窗i段
            IF g_imba_m.imba000 = 'U' THEN  #申請類型為修改時,才提供開窗
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_imba_m.imba001      #給予default值
               CALL q_imaa001_5()                                #呼叫開窗
               LET g_imba_m.imba001 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_imba_m.imba001 TO imba001             #顯示到畫面上
               NEXT FIELD imba001                              #返回原欄位 
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="input.c.imbal002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="input.c.imbal003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="input.c.imbal004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba003
            #add-point:ON ACTION controlp INFIELD imba003 name="input.c.imba003"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba003             #給予default值

            #給予arg

            CALL q_imck001()                                #呼叫開窗

            LET g_imba_m.imba003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba003 TO imba003              #顯示到畫面上
            CALL artt300_imba003_ref()
            NEXT FIELD imba003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba108
            #add-point:ON ACTION controlp INFIELD imba108 name="input.c.imba108"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba004
            #add-point:ON ACTION controlp INFIELD imba004 name="input.c.imba004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba100
            #add-point:ON ACTION controlp INFIELD imba100 name="input.c.imba100"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba109
            #add-point:ON ACTION controlp INFIELD imba109 name="input.c.imba109"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba014
            #add-point:ON ACTION controlp INFIELD imba014 name="input.c.imba014"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="input.c.imba002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba006
            #add-point:ON ACTION controlp INFIELD imba006 name="input.c.imba006"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba006 TO imba006              #顯示到畫面上

            NEXT FIELD imba006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba105
            #add-point:ON ACTION controlp INFIELD imba105 name="input.c.imba105"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba105             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba105 = g_qryparam.return1              #將開窗取得的值回傳到變數
     
            DISPLAY g_imba_m.imba105 TO imba105              #顯示到畫面上
            CALL artt300_imba105_ref()
            NEXT FIELD imba105                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba104
            #add-point:ON ACTION controlp INFIELD imba104 name="input.c.imba104"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba104             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba104 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba104 TO imba104              #顯示到畫面上
            CALL artt300_imba104_ref()
            NEXT FIELD imba104                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba107
            #add-point:ON ACTION controlp INFIELD imba107 name="input.c.imba107"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba107             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba107 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba107 TO imba107              #顯示到畫面上
            CALL artt300_imba107_ref()
            NEXT FIELD imba107                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba106
            #add-point:ON ACTION controlp INFIELD imba106 name="input.c.imba106"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba106             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba106 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba106 TO imba106              #顯示到畫面上
            CALL artt300_imba106_ref()
            NEXT FIELD imba106                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba145
            #add-point:ON ACTION controlp INFIELD imba145 name="input.c.imba145"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba145        #給予default值
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imba_m.imba145 = g_qryparam.return1              
            DISPLAY g_imba_m.imba145 TO imba145             
            CALL artt300_imba145_ref()
            NEXT FIELD imba145                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba146
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba146
            #add-point:ON ACTION controlp INFIELD imba146 name="input.c.imba146"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba146     #給予default值
            CALL q_ooca001_1()                             #呼叫開窗
            LET g_imba_m.imba146 = g_qryparam.return1 
            DISPLAY g_imba_m.imba146 TO imba146             
            CALL artt300_imba146_ref()
            NEXT FIELD imba146                             #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba113
            #add-point:ON ACTION controlp INFIELD imba113 name="input.c.imba113"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba005
            #add-point:ON ACTION controlp INFIELD imba005 name="input.c.imba005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba005      #給予default值
            CALL q_imea001()                                #呼叫開窗
            LET g_imba_m.imba005 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_imba_m.imba005 TO imba005             #顯示到畫面上
            CALL artt300_imba005_ref()
            NEXT FIELD imba005                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba142
            #add-point:ON ACTION controlp INFIELD imba142 name="input.c.imba142"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba142
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'imbaunit',g_site,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()
            LET g_imba_m.imba142 = g_qryparam.return1           #將開窗取得的值回傳到變數
            DISPLAY g_imba_m.imba142 TO imba142                 #顯示到畫面上
            CALL artt300_imba142_ref()
            NEXT FIELD imba142                                  #返回原欄位    
            #END add-point
 
 
         #Ctrlp:input.c.imbaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaacti
            #add-point:ON ACTION controlp INFIELD imbaacti name="input.c.imbaacti"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba019
            #add-point:ON ACTION controlp INFIELD imba019 name="input.c.imba019"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba020
            #add-point:ON ACTION controlp INFIELD imba020 name="input.c.imba020"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba021
            #add-point:ON ACTION controlp INFIELD imba021 name="input.c.imba021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba022
            #add-point:ON ACTION controlp INFIELD imba022 name="input.c.imba022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba022        #給予default值
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imba_m.imba022 = g_qryparam.return1              
            DISPLAY g_imba_m.imba022 TO imba022              #
            CALL artt300_imba022_ref()
            NEXT FIELD imba022                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba025
            #add-point:ON ACTION controlp INFIELD imba025 name="input.c.imba025"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba026
            #add-point:ON ACTION controlp INFIELD imba026 name="input.c.imba026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba026             #給予default值  
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imba_m.imba026 = g_qryparam.return1              
            DISPLAY g_imba_m.imba026 TO imba026              
            CALL artt300_imba026_ref()
            NEXT FIELD imba026                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba016
            #add-point:ON ACTION controlp INFIELD imba016 name="input.c.imba016"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba018
            #add-point:ON ACTION controlp INFIELD imba018 name="input.c.imba018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba018        #給予default值     
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imba_m.imba018 = g_qryparam.return1              
            DISPLAY g_imba_m.imba018 TO imba018               #
            CALL artt300_imba018_ref()
            NEXT FIELD imba018                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba010
            #add-point:ON ACTION controlp INFIELD imba010 name="input.c.imba010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba010             #給予default值
            LET g_qryparam.default2 = "" #g_imba_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba010 = g_qryparam.return1              
            #LET g_imba_m.oocq002 = g_qryparam.return2 
            DISPLAY g_imba_m.imba010 TO imba010              #
            #DISPLAY g_imba_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD imba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbastus
            #add-point:ON ACTION controlp INFIELD imbastus name="input.c.imbastus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba009
            #add-point:ON ACTION controlp INFIELD imba009 name="input.c.imba009"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba009             #給予default值

            #給予arg
            
            #CALL q_rtax001()   #160615-00028#2 20160628 mark by beckxie
            #160615-00028#2 20160628 add by beckxie---S
            IF g_argv[1] = '2' THEN
               LET g_qryparam.arg1 = '1'
            ELSE
               LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            END IF
            CALL q_rtax001_10()
            #160615-00028#2 20160628 add by beckxie---E
            LET g_imba_m.imba009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba009 TO imba009              #顯示到畫面上
            CALL artt300_imba009_ref()
            NEXT FIELD imba009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba161
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba161
            #add-point:ON ACTION controlp INFIELD imba161 name="input.c.imba161"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160705-00013#3 160712 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba161  
            
            CALL q_pcba001()  
            
            LET g_imba_m.imba161 = g_qryparam.return1              
            DISPLAY g_imba_m.imba161 TO imba161    
            
            LET g_imba_m.imba161_desc = s_desc_pcba001_desc(g_imba_m.imba161)
            DISPLAY g_imba_m.imba161_desc TO imba161_desc
            
            NEXT FIELD imba161 
            #160705-00013#3 160712 by lori add---(E)
            #END add-point
 
 
         #Ctrlp:input.c.imba101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba101
            #add-point:ON ACTION controlp INFIELD imba101 name="input.c.imba101"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba101             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_imba_m.imba101 = g_qryparam.return1              #將開窗取得的值回傳到變數
 
            DISPLAY g_imba_m.imba101 TO imba101              #顯示到畫面上
            CALL artt300_imba101_ref()
            NEXT FIELD imba101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba118
            #add-point:ON ACTION controlp INFIELD imba118 name="input.c.imba118"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba119
            #add-point:ON ACTION controlp INFIELD imba119 name="input.c.imba119"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba120
            #add-point:ON ACTION controlp INFIELD imba120 name="input.c.imba120"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba114
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba114
            #add-point:ON ACTION controlp INFIELD imba114 name="input.c.imba114"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba114             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_imba_m.imba114 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba114 TO imba114              #顯示到畫面上
            CALL artt300_imba114_ref()
            NEXT FIELD imba114                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba115
            #add-point:ON ACTION controlp INFIELD imba115 name="input.c.imba115"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba116
            #add-point:ON ACTION controlp INFIELD imba116 name="input.c.imba116"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba117
            #add-point:ON ACTION controlp INFIELD imba117 name="input.c.imba117"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba124
            #add-point:ON ACTION controlp INFIELD imba124 name="input.c.imba124"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba124             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_1()                                #呼叫開窗

            LET g_imba_m.imba124 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba124 TO imba124              #顯示到畫面上
            CALL artt300_imba124_ref()
            NEXT FIELD imba124                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf122
            #add-point:ON ACTION controlp INFIELD imbf122 name="input.c.imbf122"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf115
            #add-point:ON ACTION controlp INFIELD imbf115 name="input.c.imbf115"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf114
            #add-point:ON ACTION controlp INFIELD imbf114 name="input.c.imbf114"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbf116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf116
            #add-point:ON ACTION controlp INFIELD imbf116 name="input.c.imbf116"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba110
            #add-point:ON ACTION controlp INFIELD imba110 name="input.c.imba110"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba111
            #add-point:ON ACTION controlp INFIELD imba111 name="input.c.imba111"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba112
            #add-point:ON ACTION controlp INFIELD imba112 name="input.c.imba112"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba125
            #add-point:ON ACTION controlp INFIELD imba125 name="input.c.imba125"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba121
            #add-point:ON ACTION controlp INFIELD imba121 name="input.c.imba121"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba144
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba144
            #add-point:ON ACTION controlp INFIELD imba144 name="input.c.imba144"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba122
            #add-point:ON ACTION controlp INFIELD imba122 name="input.c.imba122"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba122             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2000" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba122 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba122 TO imba122              #顯示到畫面上
            CALL artt300_imba122_ref()
            NEXT FIELD imba122                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba123
            #add-point:ON ACTION controlp INFIELD imba123 name="input.c.imba123"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba131
            #add-point:ON ACTION controlp INFIELD imba131 name="input.c.imba131"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba131             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2001" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba131 = g_qryparam.return1              #將開窗取得的值回傳到變數
           
            DISPLAY g_imba_m.imba131 TO imba131              #顯示到畫面上
            CALL artt300_imba131_ref()
            NEXT FIELD imba131                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba126
            #add-point:ON ACTION controlp INFIELD imba126 name="input.c.imba126"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba126             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2002" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba126 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba126 TO imba126              #顯示到畫面上
            CALL artt300_imba126_ref()
            NEXT FIELD imba126                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba127
            #add-point:ON ACTION controlp INFIELD imba127 name="input.c.imba127"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba127             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2003" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba127 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba127 TO imba127              #顯示到畫面上
            CALL artt300_imba127_ref()
            NEXT FIELD imba127                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba128
            #add-point:ON ACTION controlp INFIELD imba128 name="input.c.imba128"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba128             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2004" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba128 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba128 TO imba128              #顯示到畫面上
            CALL artt300_imba128_ref()
            NEXT FIELD imba128                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba129
            #add-point:ON ACTION controlp INFIELD imba129 name="input.c.imba129"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba129             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2005" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba129 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba129 TO imba129              #顯示到畫面上
            CALL artt300_imba129_ref()
            NEXT FIELD imba129                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba143
            #add-point:ON ACTION controlp INFIELD imba143 name="input.c.imba143"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imba_m.imba143             #給予default值

            #給予arg
            #給予arg
            LET g_sql = ""
            IF NOT cl_null(g_imba_m.imba009) THEN
               LET r_success = ''
               LET r_errno = ''
               LET r_rtax001 = ''
               CALL s_arti202_search_manage_level(g_imba_m.imba009) 
                  RETURNING r_success,r_errno,r_rtax001
               IF r_success = FALSE THEN LET r_rtax001 = '' END IF
            END IF
            CASE
               WHEN cl_null(g_imba_m.imba009) AND NOT cl_null(g_imba_m.imba126)
                  LET g_sql = " (dbbb002 = '2' AND dbbb003 = '",g_imba_m.imba126,"')"
               WHEN NOT cl_null(g_imba_m.imba009) AND cl_null(g_imba_m.imba126)
                  LET g_sql = " (dbbb002 = '1' AND dbbb003 = '",r_rtax001,"')"
               WHEN NOT cl_null(g_imba_m.imba009) AND NOT cl_null(g_imba_m.imba126)
                  LET g_sql = " ((dbbb002 = '1' AND dbbb003 = '",r_rtax001,"') OR (dbbb002 = '2' AND dbbb003 = '",g_imba_m.imba126,"'))"
            END CASE
            LET g_qryparam.where = g_sql
            CALL q_dbba001_1()                                #呼叫開窗
            LET g_imba_m.imba143 = g_qryparam.return1    
            DISPLAY g_imba_m.imba143 TO imba143
            CALL artt300_imba143_ref()
            NEXT FIELD imba143 
            #END add-point
 
 
         #Ctrlp:input.c.imba130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba130
            #add-point:ON ACTION controlp INFIELD imba130 name="input.c.imba130"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba150
            #add-point:ON ACTION controlp INFIELD imba150 name="input.c.imba150"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba151
            #add-point:ON ACTION controlp INFIELD imba151 name="input.c.imba151"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba152
            #add-point:ON ACTION controlp INFIELD imba152 name="input.c.imba152"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba153
            #add-point:ON ACTION controlp INFIELD imba153 name="input.c.imba153"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba132
            #add-point:ON ACTION controlp INFIELD imba132 name="input.c.imba132"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba132             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2006" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba132 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba132 TO imba132              #顯示到畫面上
            CALL artt300_imba132_ref()
            NEXT FIELD imba132                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba133
            #add-point:ON ACTION controlp INFIELD imba133 name="input.c.imba133"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba133             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2007" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba133 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba133 TO imba133              #顯示到畫面上
            CALL artt300_imba133_ref()
            NEXT FIELD imba133                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba134
            #add-point:ON ACTION controlp INFIELD imba134 name="input.c.imba134"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba134             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2008" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba134 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba134 TO imba134              #顯示到畫面上
            CALL artt300_imba134_ref()
            NEXT FIELD imba134                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba135
            #add-point:ON ACTION controlp INFIELD imba135 name="input.c.imba135"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba135             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2009" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba135 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba135 TO imba135              #顯示到畫面上
            CALL artt300_imba135_ref()
            NEXT FIELD imba135                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba136
            #add-point:ON ACTION controlp INFIELD imba136 name="input.c.imba136"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba136             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2010" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba136 = g_qryparam.return1              #將開窗取得的值回傳到變數
 
            DISPLAY g_imba_m.imba136 TO imba136              #顯示到畫面上
            CALL artt300_imba136_ref()
            NEXT FIELD imba136                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba137
            #add-point:ON ACTION controlp INFIELD imba137 name="input.c.imba137"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba137             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2011" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba137 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba137 TO imba137              #顯示到畫面上
            CALL artt300_imba137_ref()
            NEXT FIELD imba137                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba138
            #add-point:ON ACTION controlp INFIELD imba138 name="input.c.imba138"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba138             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2012" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba138 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba138 TO imba138              #顯示到畫面上
            CALL artt300_imba138_ref()
            NEXT FIELD imba138                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba139
            #add-point:ON ACTION controlp INFIELD imba139 name="input.c.imba139"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba139             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2013" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba139 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba139 TO imba139              #顯示到畫面上
            CALL artt300_imba139_ref()
            NEXT FIELD imba139                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba140
            #add-point:ON ACTION controlp INFIELD imba140 name="input.c.imba140"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba140             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2014" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba140 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba140 TO imba140              #顯示到畫面上
            CALL artt300_imba140_ref()
            NEXT FIELD imba140                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba141
            #add-point:ON ACTION controlp INFIELD imba141 name="input.c.imba141"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba141             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2015" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba141 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba141 TO imba141              #顯示到畫面上
            CALL artt300_imba141_ref()
            NEXT FIELD imba141                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbf061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf061
            #add-point:ON ACTION controlp INFIELD imbf061 name="input.c.imbf061"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf062
            #add-point:ON ACTION controlp INFIELD imbf062 name="input.c.imbf062"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbf063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf063
            #add-point:ON ACTION controlp INFIELD imbf063 name="input.c.imbf063"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imbf063             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "6" #s


            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imba_m.imbf063 = g_qryparam.return1              

            DISPLAY g_imba_m.imbf063 TO imbf063              #

            NEXT FIELD imbf063                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbf064
            #add-point:ON ACTION controlp INFIELD imbf064 name="input.c.imbf064"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba149
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba149
            #add-point:ON ACTION controlp INFIELD imba149 name="input.c.imba149"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba102
            #add-point:ON ACTION controlp INFIELD imba102 name="input.c.imba102"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba103
            #add-point:ON ACTION controlp INFIELD imba103 name="input.c.imba103"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba147
            #add-point:ON ACTION controlp INFIELD imba147 name="input.c.imba147"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba148
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba148
            #add-point:ON ACTION controlp INFIELD imba148 name="input.c.imba148"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imba_m.imbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            #150629-00016#22 add by mapf  2015/8/4  商品种类=4-专柜时，商品临期比例为非必输
           #IF g_imba_m.imba108 !=4  AND g_imba_m.imba147 IS NULL THEN                               #160529-00002#1 mark
            IF g_imba_m.imba108 !=4  AND g_imba_m.imba147 IS NULL AND g_imba_m.imba149 <> '1' THEN   #160529-00002#1
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "art-00692" 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               NEXT FIELD imba147
            END IF
            #150629-00016#22 add by mapf  2015/8/4  商品种类=4-专柜时，商品临期天数为非必输
           #IF g_imba_m.imba108 !=4  AND g_imba_m.imba148 IS NULL THEN                               #160529-00002#1 mark
            IF g_imba_m.imba108 !=4  AND g_imba_m.imba148 IS NULL AND g_imba_m.imba149 <> '1' THEN   #160529-00002#1 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "art-00693" 
               LET g_errparam.popup  = FALSE   
               CALL cl_err()
               NEXT FIELD imba148
            END IF
            #150629-00016#22 add by mapf  2015/8/4  商品种类=4-专柜时，临期管控方式为非必输
            IF g_imba_m.imba108 !=4  AND g_imba_m.imba149 IS NULL THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "art-00694" 
               LET g_errparam.popup  = FALSE   
               CALL cl_err()
               NEXT FIELD imba149
            END IF            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #160704-00026#1 20160721 mark by beckxie---S 
               #IF NOT s_aooi200_chk_slip(g_site,'',g_imba_m.imbadocno,g_prog) THEN
               #   LET g_imba_m.imbadocno = ''
               #   NEXT FIELD imbadocno
               #END IF  
               #
               #LET l_slip = g_imba_m.imbadocno
               #
               #CALL s_aooi200_gen_docno(g_site,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_prog) RETURNING l_flag,g_imba_m.imbadocno
               #IF NOT l_flag THEN
               #   NEXT FIELD imbadocno
               #END IF
               #160704-00026#1 20160721 mark by beckxie---E
               
#               #20140515--add--dongsz--- 20150517--add--geza---     
#               IF g_imba_m.imba100 = '2' THEN
#                  IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#                     CALL s_auto_barcode('1') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '2' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '3' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF NOT l_success THEN
#                     CALL s_transaction_end('N','0')
#                     CONTINUE DIALOG
#                  END IF
#               END IF
#               #20140515--add--dongsz---
               #20150517--add--geza---     
               IF g_imba_m.imba000 ='I' THEN   #150614-00020#1 20150617 add by beckxie
                  IF g_imba_m.imba100 = '2' THEN
                     #160604-00009#91--dongsz mark--s
#                     IF g_imba_m.imba109 = '1' THEN
#                        CALL s_auto_barcode('1') RETURNING g_imba_m.imba014,l_success
#                     END IF
#                     IF g_imba_m.imba109 = '4' THEN
#                        CALL s_auto_barcode('4') RETURNING g_imba_m.imba014,l_success
#                     END IF
#                     IF g_imba_m.imba109 = '5' THEN
#                        CALL s_auto_barcode('5') RETURNING g_imba_m.imba014,l_success
#                     END IF
                     #160604-00009#91--dongsz mark--e
                     #160604-00009#91--dongsz add--s
                     CALL s_auto_barcode(g_imba_m.imba109) RETURNING g_imba_m.imba014,l_success
                     #160604-00009#91--dongsz add--e
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        #CONTINUE DIALOG     #160125-00004#1 dongsz mark
                        NEXT FIELD CURRENT   #160125-00004#1 dongsz add
                     END IF
                  END IF
                  #20140515--add--geza---
                  #add by geza 20160627 #160604-00009#108(S)
                  #有设置自动编号的话就重新取值
                  DISPLAY BY NAME g_imba_m.imba014
                  LET l_cnt = 0
                  SELECT COUNT(distinct oofg001) INTO l_cnt
                    FROM oofg_t
                   WHERE oofgent = g_enterprise
                     AND oofg002 = '1'
                     AND oofgstus = 'Y'
                  #IF l_cnt > 0 THEN #mark by geza 20160720 #160720-00007#1
                  #insert前如果只有一笔自动编码的规则，才再次取号
                  IF l_cnt = 1 THEN #add by geza 20160720 #160720-00007#1
                     CALL s_aooi390_gen('1') RETURNING l_success,g_imba_m.imba001,l_oofg_return
                  END IF
                  #add by geza 20160627 #160604-00009#108(E)
                  #150601-00026#2 ming 20150601 add --------------(S)
                  CALL s_aooi390_get_auto_no('1',g_imba_m.imba001) RETURNING l_success,g_imba_m.imba001
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  #150601-00026#2 ming 20150601 add --------------(E)
                  #判断自动编出来的号里面有&，不能编号
                  #add by geza 20150805(S)               
                  LET l_str = g_imba_m.imba001
                  IF l_str.getIndexOf('&',1) > 0 THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF               
                  #add by geza 20150805(E)    
                  CALL s_aooi390_oofi_upd('1',g_imba_m.imba001) RETURNING l_success   #150601-00026#2 150601 Sarah add
                  #add by geza 20160627 #160604-00009#108(S)
                  IF g_imba_m.imba001 IS NULL OR g_imba_m.imba001 = ' '  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'sub-00515'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                      
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF 
               #add by geza 20160627 #160604-00009#108(E)
               END IF   #150614-00020#1 20150617 add by beckxie
               
               #160704-00026#1 20160721 add by beckxie---S 
               IF NOT s_aooi200_chk_slip(g_site,'',g_imba_m.imbadocno,g_prog) THEN
                  LET g_imba_m.imbadocno = ''
                  NEXT FIELD imbadocno
               END IF  
               
               LET l_slip = g_imba_m.imbadocno
               
               CALL s_aooi200_gen_docno(g_site,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_prog) RETURNING l_flag,g_imba_m.imbadocno
               IF NOT l_flag THEN
                  NEXT FIELD imbadocno
               END IF
               #更新開窗維護多語言單號key值 
               UPDATE imbal_t SET imbaldocno = g_imba_m.imbadocno
                WHERE imbalent = g_enterprise
                  AND imbaldocno = l_slip
               LET g_master_multi_table_t.imbaldocno = g_imba_m.imbadocno
               #160704-00026#1 20160721 add by beckxie---E
               #end add-point
               
               INSERT INTO imba_t (imbaent,imba000,imbadocno,imbadocdt,imba001,imba003,imba108,imba004, 
                   imba100,imba109,imba014,imba002,imba006,imba105,imba104,imba107,imba106,imba145,imba146, 
                   imba113,imba005,imba142,imbaacti,imba019,imba020,imba021,imba022,imba025,imba026, 
                   imba016,imba018,imba010,imbastus,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt, 
                   imbamodid,imbamoddt,imbacnfid,imbacnfdt,imba009,imba161,imba101,imba118,imba119,imba120, 
                   imba114,imba115,imba116,imba117,imba124,imba110,imba111,imba112,imba125,imba121,imba144, 
                   imba122,imba123,imba131,imba126,imba127,imba128,imba129,imba143,imba130,imba150,imba151, 
                   imba152,imba153,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140, 
                   imba141,imba149,imba102,imba103,imba147,imba148)
               VALUES (g_enterprise,g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001, 
                   g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100,g_imba_m.imba109, 
                   g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
                   g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113, 
                   g_imba_m.imba005,g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020, 
                   g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016, 
                   g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
                   g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
                   g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009,g_imba_m.imba161,g_imba_m.imba101, 
                   g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba115, 
                   g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
                   g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122, 
                   g_imba_m.imba123,g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128, 
                   g_imba_m.imba129,g_imba_m.imba143,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151, 
                   g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134, 
                   g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139, 
                   g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
                   g_imba_m.imba147,g_imba_m.imba148) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imba_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
                IF g_imba_m.imba000 = 'U' THEN
                  CALL artt300_carry_detail()
                  IF NOT cl_null(g_errno) THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF   
               END IF
               
               CALL artt300_refresh_main_imby()
               IF NOT cl_null(g_errno) THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               
               #UPDATE 單身的庫存單位與計價單位               
               UPDATE imby_t SET imby012 = g_imba_m.imba106,
                                 imby014 = g_imba_m.imba104
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno
                  
               #Update 產品特徵值的相關資料(因為自動編號在後來才產生的)
               UPDATE imbk_t SET imbkdocno = g_imba_m.imbadocno
                WHERE imbkent = g_enterprise
                  AND imbkdocno = l_slip
               
                  
               #整批更新單身的 包裝單位與計價單位的 單位換算率
               IF NOT s_artt300_unit_trans_upd(g_imba_m.imbadocno,g_imba_m.imba106) THEN             
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #150122-00013#1 150304 pomelo add (s)
               #IF g_argv[01] = '2' THEN                                         #150324-00006#15 150408 by lori522612 mark 
                  LET l_cnt = 0
                  SELECT COUNT(imbfdocno) INTO l_cnt
                    FROM imbf_t
                   WHERE imbfent = g_enterprise
                     AND imbfsite = 'ALL'
                     AND imbfdocno = g_imba_m.imbadocno #150604-00023#1 Add By Ken 150611
                     #AND imbfdocno = g_imbadocno_t  #Mark By Ken 150611
                     
                  
                  IF l_cnt > 0 THEN
                     UPDATE imbf_t      
                        SET imbf001   = g_imba_m.imba001,
                            imbf011   = g_imba_m.imba003  ,   
                            imbf031   = g_imba_m.imba102  ,   
                            imbf032   = g_imba_m.imba103  ,   
                            imbf053   = g_imba_m.imba104  ,  
                            imbf054   = g_imba_m.imba144  ,   
#                            imbf061   = g_imba_m.l_imbf061,   #150614-00020#1 20150617 mark by beckxie
                            imbf061   = g_imba_m.imbf061,      #150614-00020#1 20150617 add  by beckxie
                            #150427-00001#2 Add-S By Ken 150513
#                            imbf062   = g_imba_m.l_imbf062,   #150614-00020#1 20150617 mark by beckxie
#                            imbf063   = g_imba_m.l_imbf063,   #150614-00020#1 20150617 mark by beckxie
#                            imbf064   = g_imba_m.l_imbf064,   #150614-00020#1 20150617 mark by beckxie
                            imbf062   = g_imba_m.imbf062,      #150614-00020#1 20150617 add  by beckxie
                            imbf063   = g_imba_m.imbf063,      #150614-00020#1 20150617 add  by beckxie
                            imbf064   = g_imba_m.imbf064,      #150614-00020#1 20150617 add  by beckxie
                            #150427-00001#2 Add-E By Ken 150513
                            imbf112   = g_imba_m.imba105  ,   
                            imbf113   = g_imba_m.imba106  ,  
                            imbf114   = g_imba_m.imbf114  ,   
                            imbf115   = g_imba_m.imbf115  ,   
                            imbf116   = g_imba_m.imbf116  ,   
                            imbf122   = g_imba_m.imbf122,
                            imbf143   = g_imba_m.imba107  ,   
                            imbf144   = g_imba_m.imba145  ,                        
                            imbfownid = g_imba_m.imbaownid, 
                            imbfowndp = g_imba_m.imbaowndp, 
                            imbfcrtid = g_imba_m.imbacrtid, 
                            imbfcrtdp = g_imba_m.imbacrtdp,
                            imbfcrtdt = g_imba_m.imbacrtdt, 
                            imbfmodid = g_imba_m.imbamodid, 
                            imbfmoddt = g_imba_m.imbamoddt, 
                            imbfcnfid = g_imba_m.imbacnfid,
                            imbfcnfdt = g_imba_m.imbacnfdt, 
                            imbfstus  = g_imba_m.imbastus
                       WHERE imbfent = g_enterprise       
                         AND imbfsite = 'ALL'
                         AND imbfdocno = g_imbadocno_t     
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "Upd imbf_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF                  
                  ELSE
                     INSERT INTO imbf_t(imbfent,   imbfsite,  imbfdocno, imbf001,
                                        imbf011,   imbf031,   imbf032,   imbf053,   #150324-00006#15 150408 by lori522612 add
                                        imbf054,   imbf061,   imbf112,   imbf113,   #150324-00006#15 150408 by lori522612 add
                                        imbf114,   imbf115,   imbf116,   imbf122,
                                        imbf143,   imbf144,                         #150324-00006#15 150408 by lori522612 add  
                                        imbf062,   imbf063,   imbf064,              #150427-00001#2  Add By Ken 150513                                         
                                        imbfownid, imbfowndp, imbfcrtid, imbfcrtdp,
                                        imbfcrtdt, imbfmodid, imbfmoddt, imbfcnfid,
                                        imbfcnfdt, imbfstus)
                         #150614-00020#1 20150617 mark by beckxie---S
#                        VALUES(g_enterprise,      'ALL',             g_imba_m.imbadocno,g_imba_m.imba001,
#                               g_imba_m.imba003,  g_imba_m.imba102,  g_imba_m.imba103,  g_imba_m.imba104,   #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.imba144,  g_imba_m.l_imbf061,g_imba_m.imba105,  g_imba_m.imba106,   #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.imbf114,  g_imba_m.imbf115,  g_imba_m.imbf116,  g_imba_m.imbf122,
#                               g_imba_m.imba107,  g_imba_m.imba145,                                         #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064,                    #150427-00001#2  Add By Ken 150513                                 
#                               g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,
#                               g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,
#                               g_imba_m.imbacnfdt,g_imba_m.imbastus)
                         #150614-00020#1 20150617 mark by beckxie---E
                         #150614-00020#1 20150617 add  by beckxie---S
                         VALUES(g_enterprise,      'ALL',             g_imba_m.imbadocno,g_imba_m.imba001,
                               g_imba_m.imba003,  g_imba_m.imba102,  g_imba_m.imba103,  g_imba_m.imba104,   #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imba144,  g_imba_m.imbf061,g_imba_m.imba105,  g_imba_m.imba106,   #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imbf114,  g_imba_m.imbf115,  g_imba_m.imbf116,  g_imba_m.imbf122,
                               g_imba_m.imba107,  g_imba_m.imba145,                                         #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,                        #150427-00001#2  Add By Ken 150513                                 
                               g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,
                               g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,
                               g_imba_m.imbacnfdt,g_imba_m.imbastus)
                         #150614-00020#1 20150617 mark  by beckxie---E
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "Ins imbf_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
               #END IF   #150324-00006#15 150408 by lori522612 mark
               #150122-00013#1 150304 pomelo add (e)
               
               #UPDATE 單身的传秤因子          150417 geza add       
               IF g_imba_m.imba108 = '3' THEN  
                  UPDATE imby_t SET imby018 = '1000'
                   WHERE imbyent = g_enterprise
                     AND imbydocno = g_imba_m.imbadocno
               END IF
               IF g_imba_m.imba000 = 'I' THEN   #160528-00002#3 20160528 add by beckxie
                  #160512-00003#10  by 08172
                  LET l_oocal003=''
                  LET l_n=0
                  SELECT oocal003 INTO l_oocal003 FROM oocal_t WHERE oocalent=g_enterprise AND oocal001=g_imba_m.imba104 AND oocal002=g_dlang
                  FOR l_i=0 TO 2
                     LET l_n=l_n+1
                     #160528-00002#3 20160528 mark by beckxie---S
                     #INSERT INTO imbz_t(imbzent,imbzdocno,imbz002,imbz006,imbz004,imbz005)#企业编号，申请单号，补货规格，补货规格说明，补货单位，件装数
                     #            VALUES(g_enterprise,g_imba_m.imbadocno,l_n,l_oocal003,g_imba_m.imba104,1)
                     #160528-00002#3 20160528 mark by beckxie---E
                     #160528-00002#3 20160528 add by beckxie---S
                     INSERT INTO imbz_t(imbzent,imbzdocno,imbz001,imbz002,imbz006,imbz004,imbz005)#企业编号，申请单号，补货规格，补货规格说明，补货单位，件装数
                                 VALUES(g_enterprise,g_imba_m.imbadocno,g_imba_m.imba001,l_n,l_oocal003,g_imba_m.imba104,1)
                     #160528-00002#3 20160528 add by beckxie---E
                     IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "Ins imbz_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                  END FOR
               END IF    #160528-00002#3 20160528 add by beckxie
               #
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imba_m.imbadocno = g_master_multi_table_t.imbaldocno AND
         g_imba_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imba_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imba_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imba_m.imbadocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imba_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imba_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imba_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #150629-00021#1 20150629 add by beckxie---S
               CALL s_artt300_ins_imbo(g_imba_m.imbadocno) RETURNING l_success
               CALL artt300_b_fill()
               #150629-00021#1 20150629 add by beckxie---E
               LET g_assign_no = 'Y'                  
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artt300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt300_b_fill()
                  CALL artt300_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #20140515--add--dongsz--- 20150417--add--geza---
#               IF cl_null(g_imba_m.imba014) AND g_imba_m.imba100 = '2' THEN
##               IF g_imba_m.imba100 = '2' AND 
##                  (g_imba_m.imba100 <> g_imba_m_t.imba100 OR g_imba_m.imba109 <> g_imba_m_t.imba109) THEN
#                  IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#                     CALL s_auto_barcode('1') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '2' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '3' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF NOT l_success THEN
#                     CALL s_transaction_end('N','0')
#                     CONTINUE DIALOG
#                  END IF
#               END IF
#               #20140515--add--dongsz--- 
               #20150417--add--geza---
               IF cl_null(g_imba_m.imba014) AND g_imba_m.imba100 = '2' THEN
#               IF g_imba_m.imba100 = '2' AND 
#                  (g_imba_m.imba100 <> g_imba_m_t.imba100 OR g_imba_m.imba109 <> g_imba_m_t.imba109) THEN
                  #160604-00009#91--dongsz mark--s
#                  IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#                     CALL s_auto_barcode('1') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '4' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imba_m.imba014,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '5' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imba_m.imba014,l_success
#                  END IF
                  #160604-00009#91--dongsz mark--e
                  #160604-00009#91--dongsz add--s
                  CALL s_auto_barcode(g_imba_m.imba109) RETURNING g_imba_m.imba014,l_success
                  #160604-00009#91--dongsz add--e
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #20150417--add--geza---                 
               #end add-point
               
               #將遮罩欄位還原
               CALL artt300_imba_t_mask_restore('restore_mask_o')
               
               UPDATE imba_t SET (imba000,imbadocno,imbadocdt,imba001,imba003,imba108,imba004,imba100, 
                   imba109,imba014,imba002,imba006,imba105,imba104,imba107,imba106,imba145,imba146,imba113, 
                   imba005,imba142,imbaacti,imba019,imba020,imba021,imba022,imba025,imba026,imba016, 
                   imba018,imba010,imbastus,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid, 
                   imbamoddt,imbacnfid,imbacnfdt,imba009,imba161,imba101,imba118,imba119,imba120,imba114, 
                   imba115,imba116,imba117,imba124,imba110,imba111,imba112,imba125,imba121,imba144,imba122, 
                   imba123,imba131,imba126,imba127,imba128,imba129,imba143,imba130,imba150,imba151,imba152, 
                   imba153,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140,imba141, 
                   imba149,imba102,imba103,imba147,imba148) = (g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt, 
                   g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
                   g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105, 
                   g_imba_m.imba104,g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146, 
                   g_imba_m.imba113,g_imba_m.imba005,g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019, 
                   g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba025,g_imba_m.imba026, 
                   g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid, 
                   g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
                   g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009,g_imba_m.imba161, 
                   g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
                   g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110, 
                   g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144, 
                   g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127, 
                   g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143,g_imba_m.imba130,g_imba_m.imba150, 
                   g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132,g_imba_m.imba133, 
                   g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
                   g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102, 
                   g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148)
                WHERE imbaent = g_enterprise AND imbadocno = g_imbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF g_imba_m.imba000 = 'U' THEN
                  CALL artt300_carry_detail()
                  IF NOT cl_null(g_errno) THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF  
               END IF
               CALL artt300_refresh_main_imby()
               IF NOT cl_null(g_errno) THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               
               #UPDATE 單身的庫存單位與計價單位               
               UPDATE imby_t SET imby012 = g_imba_m.imba106,
                                 imby014 = g_imba_m.imba104
                WHERE imbyent = g_enterprise
                  AND imbydocno = g_imba_m.imbadocno
                  
               #整批更新單身的 包裝單位與計價單位的 單位換算率
               IF NOT s_artt300_unit_trans_upd(g_imba_m.imbadocno,g_imba_m.imba106) THEN             
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF              
               IF NOT artt300_upd_detail_imba001() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #150122-00013#1 150304 pomelo add (s)
               #IF g_argv[01] = '2' THEN   #150324-00006#15 150408 by lori522612 mark
                  LET l_cnt = 0
                  SELECT COUNT(imbfdocno) INTO l_cnt
                    FROM imbf_t
                   WHERE imbfent = g_enterprise
                     AND imbfsite = 'ALL'
                     AND imbfdocno = g_imba_m.imbadocno #150604-00023#1 Add By Ken 150611
                     #AND imbfdocno = g_imbadocno_t #Mark By Ken 156011
                  
                  IF l_cnt > 0 THEN
                     #150324-00006#15 150408 by lori522612 mark---(S)
                     #UPDATE imbf_t
                     #   SET (imbf001,   imbf114,   imbf115,   imbf116,
                     #        imbf122,   imbfownid, imbfowndp, imbfcrtid,
                     #        imbfcrtdp, imbfcrtdt, imbfmodid, imbfmoddt,
                     #        imbfcnfid, imbfcnfdt, imbfstus)
                     #     = (g_imba_m.imba001,   g_imba_m.imbf114,   g_imba_m.imbf115,   g_imba_m.imbf116,
                     #        g_imba_m.imbf122,   g_imba_m.imbaownid, g_imba_m.imbaowndp, g_imba_m.imbacrtid,
                     #        g_imba_m.imbacrtdp, g_imba_m.imbacrtdt, g_imba_m.imbamodid, g_imba_m.imbamoddt,
                     #        g_imba_m.imbacnfid, g_imba_m.imbacnfdt, g_imba_m.imbastus) 
                     #  WHERE imbfent = g_enterprise
                     #    AND imbfsite = 'ALL'
                     #    AND imbfdocno = g_imbadocno_t
                     #150324-00006#15 150408 by lori522612 mark---(E)
                     
                     #150324-00006#15 150408 by lori522612 add---(S)  
                     UPDATE imbf_t      
                        SET imbf001   = g_imba_m.imba001,
                            imbf011   = g_imba_m.imba003  ,   
                            imbf031   = g_imba_m.imba102  ,   
                            imbf032   = g_imba_m.imba103  ,   
                            imbf053   = g_imba_m.imba104  ,  
                            imbf054   = g_imba_m.imba144  ,   
#                            imbf061   = g_imba_m.l_imbf061,   #150614-00020#1 20150617 mark by beckxie
                            imbf061   = g_imba_m.imbf061,      #150614-00020#1 20150617 add  by beckxie
                            #150427-00001#2 Add-S By Ken 150513
#                            imbf062   = g_imba_m.l_imbf062,   #150614-00020#1 20150617 mark by beckxie
#                            imbf063   = g_imba_m.l_imbf063,   #150614-00020#1 20150617 mark by beckxie
#                            imbf064   = g_imba_m.l_imbf064,   #150614-00020#1 20150617 mark by beckxie
                            imbf062   = g_imba_m.imbf062,      #150614-00020#1 20150617 add  by beckxie
                            imbf063   = g_imba_m.imbf063,      #150614-00020#1 20150617 add  by beckxie
                            imbf064   = g_imba_m.imbf064,      #150614-00020#1 20150617 add  by beckxie
                            #150427-00001#2 Add-E By Ken 150513
                            imbf112   = g_imba_m.imba105  ,   
                            imbf113   = g_imba_m.imba106  ,  
                            imbf114   = g_imba_m.imbf114  ,   
                            imbf115   = g_imba_m.imbf115  ,   
                            imbf116   = g_imba_m.imbf116  ,   
                            imbf122   = g_imba_m.imbf122,
                            imbf143   = g_imba_m.imba107  ,   
                            imbf144   = g_imba_m.imba145  ,                        
                            imbfownid = g_imba_m.imbaownid, 
                            imbfowndp = g_imba_m.imbaowndp, 
                            imbfcrtid = g_imba_m.imbacrtid, 
                            imbfcrtdp = g_imba_m.imbacrtdp,
                            imbfcrtdt = g_imba_m.imbacrtdt, 
                            imbfmodid = g_imba_m.imbamodid, 
                            imbfmoddt = g_imba_m.imbamoddt, 
                            imbfcnfid = g_imba_m.imbacnfid,
                            imbfcnfdt = g_imba_m.imbacnfdt, 
                            imbfstus  = g_imba_m.imbastus
                       WHERE imbfent = g_enterprise       
                         AND imbfsite = 'ALL'
                         AND imbfdocno = g_imbadocno_t
                     #150324-00006#15 150408 by lori522612 add---(E)     
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "Upd imbf_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  ELSE
                     INSERT INTO imbf_t(imbfent,   imbfsite,  imbfdocno, imbf001,
                                        imbf011,   imbf031,   imbf032,   imbf053,   #150324-00006#15 150408 by lori522612 add
                                        imbf054,   imbf061,   imbf112,   imbf113,   #150324-00006#15 150408 by lori522612 add
                                        imbf114,   imbf115,   imbf116,   imbf122,
                                        imbf143,   imbf144,                         #150324-00006#15 150408 by lori522612 add
                                        imbf062,   imbf063,   imbf064,              #150427-00001#2  Add By Ken 150513                                        
                                        imbfownid, imbfowndp, imbfcrtid, imbfcrtdp,
                                        imbfcrtdt, imbfmodid, imbfmoddt, imbfcnfid,
                                        imbfcnfdt, imbfstus)
                         #150614-00020#1 20150617 mark by beckxie---S
#                        VALUES(g_enterprise,      'ALL',             g_imba_m.imbadocno,g_imba_m.imba001,
#                               g_imba_m.imba003,  g_imba_m.imba102,  g_imba_m.imba103,  g_imba_m.imba104,   #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.imba144,  g_imba_m.l_imbf061,g_imba_m.imba105,  g_imba_m.imba106,   #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.imbf114,  g_imba_m.imbf115,  g_imba_m.imbf116,  g_imba_m.imbf122,
#                               g_imba_m.imba107,  g_imba_m.imba145,                                         #150324-00006#15 150408 by lori522612 add
#                               g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064,                    #150427-00001#2  Add By Ken 150513  
#                               g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,
#                               g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,
#                               g_imba_m.imbacnfdt,g_imba_m.imbastus)
                        #150614-00020#1 20150617 mark by beckxie---E
                        #150614-00020#1 20150617 add by beckxie---S
                        VALUES(g_enterprise,      'ALL',             g_imba_m.imbadocno,g_imba_m.imba001,
                               g_imba_m.imba003,  g_imba_m.imba102,  g_imba_m.imba103,  g_imba_m.imba104,   #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imba144,  g_imba_m.imbf061,  g_imba_m.imba105,  g_imba_m.imba106,   #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imbf114,  g_imba_m.imbf115,  g_imba_m.imbf116,  g_imba_m.imbf122,
                               g_imba_m.imba107,  g_imba_m.imba145,                                         #150324-00006#15 150408 by lori522612 add
                               g_imba_m.imbf062,  g_imba_m.imbf063,  g_imba_m.imbf064,                      #150427-00001#2  Add By Ken 150513  
                               g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,
                               g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,
                               g_imba_m.imbacnfdt,g_imba_m.imbastus)
                        #150614-00020#1 20150617 add by beckxie---E
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "Ins imbf_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
               #END IF   #150324-00006#15 150408 by lori522612 mark
               #150122-00013#1 150304 pomelo add (e)
               
               #UPDATE 單身的传秤因子          150417 geza add       
               IF g_imba_m.imba108 = '3' THEN  
                  UPDATE imby_t SET imby018 = '1000'
                   WHERE imbyent = g_enterprise
                     AND imbydocno = g_imba_m.imbadocno
               END IF 
               #150629-00021#1 20150629 add by beckxie---S
               CALL s_artt300_ins_imbo(g_imba_m.imbadocno) RETURNING l_success
               CALL artt300_b_fill()
               #150629-00021#1 20150629 add by beckxie---E        
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imba_m.imbadocno = g_master_multi_table_t.imbaldocno AND
         g_imba_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imba_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imba_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imba_m.imbadocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imba_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imba_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imba_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL artt300_imba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imba_m_t)
               LET g_log2 = util.JSON.stringify(g_imba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                    
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imbadocno_t = g_imba_m.imbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imby_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imby_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imby_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
                        
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imby_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imby_d[l_ac].imby003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imby_d_t.* = g_imby_d[l_ac].*  #BACKUP
               LET g_imby_d_o.* = g_imby_d[l_ac].*  #BACKUP
               CALL artt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                              
               #end add-point  
               CALL artt300_set_no_entry_b(l_cmd)
               IF NOT artt300_lock_b("imby_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt300_bcl INTO g_imby_d[l_ac].imby001,g_imby_d[l_ac].imbystus,g_imby_d[l_ac].imby002, 
                      g_imby_d[l_ac].imby019,g_imby_d[l_ac].imby003,g_imby_d[l_ac].imby004,g_imby_d[l_ac].imby005, 
                      g_imby_d[l_ac].imby006,g_imby_d[l_ac].imby018,g_imby_d[l_ac].imby007,g_imby_d[l_ac].imby008, 
                      g_imby_d[l_ac].imby009,g_imby_d[l_ac].imby015,g_imby_d[l_ac].imby010,g_imby_d[l_ac].imby016, 
                      g_imby_d[l_ac].imby011,g_imby_d[l_ac].imby017,g_imby_d[l_ac].imby012,g_imby_d[l_ac].imby013, 
                      g_imby_d[l_ac].imby014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imby_d_t.imby003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imby_d_mask_o[l_ac].* =  g_imby_d[l_ac].*
                  CALL artt300_imby_t_mask()
                  LET g_imby_d_mask_n[l_ac].* =  g_imby_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_imby2_d_t.* = g_imby2_d[l_ac].* 
            CALL artt300_set_entry_b(l_cmd)
            CALL artt300_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imby_d[l_ac].* TO NULL 
            INITIALIZE g_imby_d_t.* TO NULL 
            INITIALIZE g_imby_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imby_d[l_ac].imbystus = 'N'
 
 
 
            #自定義預設值
                  LET g_imby_d[l_ac].imbystus = "Y"
      LET g_imby_d[l_ac].imby005 = "0"
      LET g_imby_d[l_ac].imby006 = "N"
      LET g_imby_d[l_ac].imby018 = "1"
      LET g_imby_d[l_ac].imby007 = "0"
      LET g_imby_d[l_ac].imby008 = "0"
      LET g_imby_d[l_ac].imby009 = "0"
      LET g_imby_d[l_ac].imby010 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #传秤因子赋值  150417  geza  add
            IF g_imba_m.imba108 = '3' THEN 
               LET  g_imby_d[l_ac].imby018 = 1000                  
            END IF 
            #条码赋值  150417  geza  add
            LET g_imby_d[l_ac].imby005 = "1" #件装数赋值  150518  geza  add
            LET  g_imby_d[l_ac].imby002 =  g_imba_m.imba100 
                
            #end add-point
            LET g_imby_d_t.* = g_imby_d[l_ac].*     #新輸入資料
            LET g_imby_d_o.* = g_imby_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                    
            #end add-point
            CALL artt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imby_d[li_reproduce_target].* = g_imby_d[li_reproduce].*
 
               LET g_imby_d[li_reproduce_target].imby003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_imby_d[l_ac].imby001 = g_imba_m.imba001
            LET g_imby_d[l_ac].imby012 = g_imba_m.imba106
            LET g_imby_d[l_ac].imby014 = g_imba_m.imba104
            LET g_imby_d[l_ac].imby007 = g_imba_m.imba019
            LET g_imby_d[l_ac].imby008 = g_imba_m.imba020
            LET g_imby_d[l_ac].imby009 = g_imba_m.imba021
            LET g_imby_d[l_ac].imby015 = g_imba_m.imba022
            LET g_imby_d[l_ac].imby010 = g_imba_m.imba025
            LET g_imby_d[l_ac].imby016 = g_imba_m.imba026
            LET g_imby_d[l_ac].imby011 = g_imba_m.imba016
            LET g_imby_d[l_ac].imby017 = g_imba_m.imba018   
            CALL artt300_imby015_ref()    
            CALL artt300_imby016_ref()   
            CALL artt300_imby017_ref()   
            LET g_imby_d[l_ac].imbystus = "Y"
            LET g_imby_d_t.* = g_imby_d[l_ac].*
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
                        
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imby_t 
             WHERE imbyent = g_enterprise AND imbydocno = g_imba_m.imbadocno
 
               AND imby003 = g_imby_d[l_ac].imby003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
#               #20140515--add--dongsz--- 20150417--geza--geza---
#               IF g_imby_d[l_ac].imby002 = '2' THEN
#                  IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#                     IF g_imby_d[l_ac].imby005 = 1 THEN
#                        CALL s_auto_barcode('1') RETURNING g_imby_d[l_ac].imby003,l_success
#                     END IF
#                     IF g_imby_d[l_ac].imby005 > 1 THEN
#                        CALL s_auto_barcode('2') RETURNING g_imby_d[l_ac].imby003,l_success
#                     END IF
#                  END IF
#                  IF g_imba_m.imba109 = '2' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imby_d[l_ac].imby003,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '3' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imby_d[l_ac].imby003,l_success
#                  END IF
#                  IF NOT l_success THEN
#                     INITIALIZE g_imby_d[l_ac].* TO NULL
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  END IF
#               END IF
               #20150417--add--geza---  
               IF g_imby_d[l_ac].imby002 = '2' THEN
                  #IF g_imba_m.imba109 = '1' THEN     #160604-00009#91 dongsz mark
                  IF g_imba_m.imba109 <> '4' AND g_imba_m.imba109 <> '5' THEN   #160604-00009#91 dongsz add
                     IF g_imby_d[l_ac].imby005 = 1 THEN
                        #CALL s_auto_barcode('1') RETURNING g_imby_d[l_ac].imby003,l_success   #160604-00009#91 dongsz mark
                        CALL s_auto_barcode(g_imba_m.imba109) RETURNING g_imby_d[l_ac].imby003,l_success  #160604-00009#91 dongsz add
                     END IF
                     IF g_imby_d[l_ac].imby005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imby_d[l_ac].imby003,l_success
                     END IF
                  END IF
                  IF g_imba_m.imba109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imby_d[l_ac].imby003,l_success
                  END IF
                  IF g_imba_m.imba109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imby_d[l_ac].imby003,l_success
                  END IF
                  IF NOT l_success THEN
                     INITIALIZE g_imby_d[l_ac].* TO NULL
                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
               END IF
               #20150417--add--geza--- 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imby_d[g_detail_idx].imby003
               CALL artt300_insert_b('imby_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imby_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt300_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #160822-00036#3 20160824 mark by beckxie---S
               ##160803-00008#3 20160811 add by beckxie---S
               #IF l_inam.getlength() >1 THEN
               #   #根據選的特徵自動生成多筆條碼資料
               #   CALL cl_err_collect_init()
               #   CALL s_transaction_begin()
               #   IF NOT artt300_ins_imby(l_inam) THEN
               #      CALL s_transaction_end('N','0')
               #   ELSE
               #      CALL s_transaction_end('Y','0')
               #   END IF
               #   CALL cl_err_collect_show()
               #   CALL artt300_b_fill()
               #END IF           
               ##160803-00008#3 20160811 add by beckxie---E
               #160822-00036#3 20160824 mark by beckxie---E
               CALL artt300_upd_imbz()                                             
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
                              
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imba_m.imbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_imby_d_t.imby003
 
            
               #刪除同層單身
               IF NOT artt300_delete_b('imby_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt300_key_delete_b(gs_keys,'imby_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                             
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  CALL artt300_upd_imbz()
                  #dongsz--add--str---
                  IF g_imby_d[l_ac].imby006 = 'Y' THEN
#                     LET g_imba_m.imba100 = ""   #geza--add--mark---
                     LET g_imba_m.imba014 = ""
                     UPDATE imba_t SET imba100 = g_imba_m.imba100,
                                       imba014 = g_imba_m.imba014
                      WHERE imbaent = g_enterprise
                        AND imbadocno = g_imba_m.imbadocno
                     DISPLAY BY NAME g_imba_m.imba100,g_imba_m.imba014
                     LET g_imba_m_o.imba100 = g_imba_m.imba100
                     LET g_imba_m_o.imba014 = g_imba_m.imba014
                  END IF
                  #dongsz--add--end---
               #end add-point
               LET l_count = g_imby_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                        
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imby_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby001
            #add-point:BEFORE FIELD imby001 name="input.b.page1.imby001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby001
            
            #add-point:AFTER FIELD imby001 name="input.a.page1.imby001"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby001
            #add-point:ON CHANGE imby001 name="input.g.page1.imby001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbystus
            #add-point:BEFORE FIELD imbystus name="input.b.page1.imbystus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbystus
            
            #add-point:AFTER FIELD imbystus name="input.a.page1.imbystus"
            IF g_imby_d[l_ac].imbystus = 'Y' THEN
               IF g_imba_m.imba104 = g_imby_d[l_ac].imby004 THEN
                  LET g_imby_d[l_ac].imby005 = 1
                  #DISPLAY BY NAME g_imby_d[l_ac].imby005 #150504-00038#1 Mark By Ken 150506
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbystus
            #add-point:ON CHANGE imbystus name="input.g.page1.imbystus"
            IF g_imby_d[l_ac].imbystus = 'Y' AND NOT cl_null(g_imby_d[l_ac].imby004) THEN
#2014/06/20 By pomelo mark start------
#               IF cl_null(g_imby_d[l_ac].imby003) THEN
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt FROM imby_t
#                   WHERE imbyent = g_enterprise
#                     AND imbydocno = g_imba_m.imbadocno
#                     AND imby004 = g_imby_d[l_ac].imby004
#                     AND imbystus = 'Y'
#                  IF l_cnt > 0 THEN
#                     CALL cl_err(g_imby_d[l_ac].imby004,'art-00029',1)
#                     LET g_imby_d[l_ac].imbystus = 'N'
#                     NEXT FIELD CURRENT
#                  END IF
#               ELSE
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt FROM imby_t
#                   WHERE imbyent = g_enterprise
#                     AND imbydocno = g_imba_m.imbadocno
#                     AND imby003 != g_imby_d[l_ac].imby003
#                     AND imby004  = g_imby_d[l_ac].imby004
#                     AND imbystus = 'Y'
#                  IF l_cnt > 0 THEN
#                     CALL cl_err(g_imby_d[l_ac].imby004,'art-00029',1)
#                     LET g_imby_d[l_ac].imbystus = 'N'
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#2014/06/20 By pomelo mark end------
               #150507-00009# Mark-S By Ken 150525 取消單身包裝單位與計價單位檢查是否有轉換率，改到單頭
               #IF NOT artt300_chk_imby004_1() THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = 'art-00272'
               #   LET g_errparam.extend = g_imby_d[l_ac].imby004
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #
               #   LET g_imby_d[l_ac].imbystus = 'N'
               #   NEXT FIELD CURRENT
               #END IF
               #150507-00009# Mark-E
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby002
            #add-point:BEFORE FIELD imby002 name="input.b.page1.imby002"
                           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby002
            
            #add-point:AFTER FIELD imby002 name="input.a.page1.imby002"
            #dongsz--add--str---
            IF NOT cl_null(g_imby_d[l_ac].imby002) THEN
               #160604-00009#91--dongsz mark--s
#               IF g_imba_m.imba109 <> '1' AND g_imby_d[l_ac].imby002 = '1' THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'art-00399'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_imby_d[l_ac].imby002 = g_imby_d_t.imby002
#                  NEXT FIELD imby002
#               END IF
               #160604-00009#91--dongsz mark--e
            END IF
            #dongsz--add--end---
            IF l_cmd = 'a' THEN
               IF g_imby_d[l_ac].imby002 = '1' AND NOT cl_null(g_imby_d[l_ac].imby003) THEN
                  CALL s_chk_barcode(g_imby_d[l_ac].imby003) RETURNING g_success
                  IF g_success = 'N' THEN
                     LET g_imby_d[l_ac].imby002 = g_imby_d_t.imby002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF g_imby_d[l_ac].imby002 = '1' AND g_imby_d_t.imby002 = '2' THEN
                  LET g_imby_d[l_ac].imby003 = ""
               END IF
            END IF
            CALL artt300_set_entry_b(l_cmd)
            #160801-00017#4 20160805 add by beckxie---S
            CALL artt300_set_no_required_b(l_cmd)
            CALL artt300_set_required_b(l_cmd)
            #160801-00017#4 20160805 add by beckxie---E 
            CALL artt300_set_no_entry_b(l_cmd)           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby002
            #add-point:ON CHANGE imby002 name="input.g.page1.imby002"
            #160801-00017#4 20160805 add by beckxie---S
            CALL artt300_set_no_required_b(l_cmd)
            CALL artt300_set_required_b(l_cmd)
            #160801-00017#4 20160805 add by beckxie---E      
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby019
            
            #add-point:AFTER FIELD imby019 name="input.a.page1.imby019"
            #160801-00017#4 20160805 add by beckxie---S
            LET g_imby_d[l_ac].imby019_desc=''
            IF NOT cl_null(g_imby_d[l_ac].imby019) THEN
               IF NOT s_feature_check_t('1',g_imba_m.imbadocno,g_imba_m.imba001,g_imby_d[l_ac].imby019) THEN
                  LET g_imby_d[l_ac].imby019 = g_imby_d_o.imby019
                  CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
                       RETURNING l_success,g_imby_d[l_ac].imby019_desc
                  NEXT FIELD CURRENT
               ELSE
                  LET g_imby_d_o.imby019 = g_imby_d[l_ac].imby019 
                  CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
                       RETURNING l_success,g_imby_d[l_ac].imby019_desc
                  DISPLAY BY NAME g_imby_d[l_ac].imby019,g_imby_d[l_ac].imby019_desc     
               END IF
            END IF
            #160801-00017#4 20160805 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby019
            #add-point:BEFORE FIELD imby019 name="input.b.page1.imby019"
            #160801-00017#4 20160805 add by beckxie---S
            CALL artt300_set_no_required_b(l_cmd)
            CALL artt300_set_required_b(l_cmd)
            #160801-00017#4 20160805 add by beckxie---E
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby019
            #add-point:ON CHANGE imby019 name="input.g.page1.imby019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby019_desc
            #add-point:BEFORE FIELD imby019_desc name="input.b.page1.imby019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby019_desc
            
            #add-point:AFTER FIELD imby019_desc name="input.a.page1.imby019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby019_desc
            #add-point:ON CHANGE imby019_desc name="input.g.page1.imby019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby003
            #add-point:BEFORE FIELD imby003 name="input.b.page1.imby003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby003
            
            #add-point:AFTER FIELD imby003 name="input.a.page1.imby003"
                                    #此段落由子樣板a05產生
            IF NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imby_d[l_ac].imby003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imby_d[l_ac].imby003 != g_imby_d_t.imby003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imby_t WHERE "||"imbyent = '" ||g_enterprise|| "' AND "||"imbydocno = '"||g_imba_m.imbadocno ||"' AND "|| "imby003 = '"||g_imby_d[l_ac].imby003 ||"'",'std-00004',0) THEN 
                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     IF NOT cl_null(g_imby_d_t.imby003) THEN
                        LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
                  CALL artt300_chk_barcode(g_imby_d[l_ac].imby003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby_d[l_ac].imby003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     IF NOT cl_null(g_imby_d_t.imby003) THEN
                        LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF 
               END IF
               #20140513--add--dongsz---
               IF g_imby_d[l_ac].imby002 = '1' THEN
                  CALL s_chk_barcode(g_imby_d[l_ac].imby003) RETURNING g_success
                  IF g_success = 'N' THEN
                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     IF NOT cl_null(g_imby_d_t.imby003) THEN
                        LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
               END IF                     
               #20140513--add--dongsz---
               
               IF g_imby_d[l_ac].imby002 != 3 THEN   #160803-00008#3 20160811 add by beckxie
                  #150906-00005#2 20151126 add by beckxie---S
                  IF NOT s_artt300_chk_imba014(g_imby_d[l_ac].imby003) THEN   
                     IF NOT cl_null(g_imby_d_t.imby003) THEN
                        LET g_imby_d[l_ac].imby003 = g_imby_d_t.imby003
                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  #150906-00005#2 20151126 add by beckxie---E
               END IF  #160803-00008#3 20160811 add by beckxie
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby003
            #add-point:ON CHANGE imby003 name="input.g.page1.imby003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby004
            
            #add-point:AFTER FIELD imby004 name="input.a.page1.imby004"
            LET g_imby_d[l_ac].imby004_desc = ''
            IF NOT cl_null(g_imby_d[l_ac].imby004) THEN
#               IF g_imby_d[l_ac].imby004 != g_imby_d_o.imby004 OR g_imby_d_o.imby004 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imby_d[l_ac].imby004 != g_imby_d_o.imby004 OR cl_null(g_imby_d_o.imby004) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imby_d[l_ac].imby004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby_d[l_ac].imby004
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imby_d[l_ac].imby004 = g_imby_d_o.imby004
                     CALL artt300_imby004_ref()
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
               #150518-00035#1 geza add(S)
               IF g_imby_d[l_ac].imby005 IS NULL OR g_imby_d[l_ac].imby005 = '0' THEN
                  LET g_imby_d[l_ac].imby005 = 1                
               END IF  
               IF NOT cl_null(g_imby_d[l_ac].imby005) THEN   
                  #IF g_imba_m.imba109 = '1' AND g_imba_m.imba100 = '2' AND  g_imby_d[l_ac].imby002 = '2' THEN  #160604-00009#91 dongsz mark
                  IF (g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '8' OR g_imba_m.imba109 = '9' OR g_imba_m.imba109 = '10') AND  #160604-00009#91 dongsz add
                     g_imba_m.imba100 = '2' AND  g_imby_d[l_ac].imby002 = '2' THEN  #160604-00009#91 dongsz add
                     IF NOT artt300_imby005_chk() THEN
                        LET g_imby_d[l_ac].imby005 =g_imby_d_o.imby005
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF
               #150518-00035#1 geza add(S)  
            END IF
            
            IF g_imby_d[l_ac].imbystus = 'Y' AND NOT cl_null(g_imby_d[l_ac].imby004) THEN
               #在原校驗前,先行檢查 此包裝單位與計價單位之間 是否存在換算率 對應關係
               #150507-00009# Mark-S By Ken 150525 取消單身包裝單位與計價單位檢查是否有轉換率，改到單頭
               #IF NOT artt300_chk_imby004_1() THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = 'art-00272'
               #   LET g_errparam.extend = g_imby_d[l_ac].imby004
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #
               #   LET g_imby_d[l_ac].imby004 = g_imby_d_t.imby004
               #   CALL artt300_imby004_ref()
               #   NEXT FIELD CURRENT
               #END IF   
               #150507-00009# Mark-E
               
               #150602-00072#1 Add-S By Ken 150602
               CALL artt300_imby005_chk_1() RETURNING l_success,l_imby005
               IF l_success THEN  #商品的多條碼包裝單位已存在時，預帶申請單中的同包裝單位件裝數
                  LET g_imby_d[l_ac].imby005 = l_imby005
               #ELSE               #商品多條碼包裝單位不存在時，預帶轉換率中的包裝單位件裝數 
               #150602-00072#1 Add-E By Ken 150602
               ##150703 pomelo mark(S)               
               #   CALL artt300_chk_imby004()
               #   IF NOT cl_null(g_errno) THEN
               #      INITIALIZE g_errparam TO NULL
               #         LET g_errparam.code = g_errno
               #         LET g_errparam.extend = g_imby_d[l_ac].imby004
               #         LET g_errparam.popup = TRUE
               #         CALL cl_err()
               #   
               #      LET g_imby_d[l_ac].imby004 = g_imby_d_o.imby004
               #      CALL artt300_imby004_ref()
               #      NEXT FIELD CURRENT
               #   END IF
               ##150703 pomelo mark(E)
               END IF 

               #150602-00072#1 Add-S By Ken 150602
               IF NOT artt300_imby005_chk_2() THEN
                 INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'art-00591'
                    LET g_errparam.extend = '輸入件裝數：',g_imby_d[l_ac].imby005
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = g_imby_d[l_ac].imby001
                    LET g_errparam.replace[2] = g_imby_d[l_ac].imby004
                    LET g_errparam.replace[3] = g_imby_d_o.imby005                
                    CALL cl_err()
                 
                 LET g_imby_d[l_ac].imby004 = g_imby_d_o.imby004
                 CALL artt300_imby004_ref()
                 NEXT FIELD CURRENT            
               END IF
               #150602-00072#1 Add-E By Ken 150602
            END IF  
            LET g_imby_d_o.imby004 = g_imby_d[l_ac].imby004
            LET g_imby_d_o.imby005 = g_imby_d[l_ac].imby005
            CALL artt300_imby004_ref()
            CALL artt300_set_entry_b(l_cmd)
            CALL artt300_set_no_entry_b(l_cmd)           
            
#            IF g_imby_d[l_ac].imbystus = 'Y' AND NOT cl_null(g_imby_d[l_ac].imby004) THEN
#               IF NOT cl_null(g_imby_d[l_ac].imby003) THEN
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt FROM imby_t
#                   WHERE imbyent = g_enterprise
#                     AND imbydocno = g_imba_m.imbadocno
#                     AND imby004 = g_imby_d[l_ac].imby004
#                     AND imby003 != g_imby_d[l_ac].imby003
#                     AND imbystus = 'Y'
#                  IF l_cnt >= 1 THEN
#                     CALL cl_err(g_imby_d[l_ac].imby004,'art-00028',1)
#                     LET g_imby_d[l_ac].imby004 = g_imby_d_t.imby004
#                     NEXT FIELD CURRENT
#                  END IF
#               ELSE
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt FROM imby_t
#                   WHERE imbyent = g_enterprise
#                     AND imbydocno = g_imba_m.imbadocno
#                     AND imby004 = g_imby_d[l_ac].imby004
#                     AND imbystus = 'Y'
#                  IF l_cnt >= 1 THEN
#                     CALL cl_err(g_imby_d[l_ac].imby004,'art-00028',1)
#                     LET g_imby_d[l_ac].imby004 = g_imby_d_t.imby004
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby004
            #add-point:BEFORE FIELD imby004 name="input.b.page1.imby004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby004
            #add-point:ON CHANGE imby004 name="input.g.page1.imby004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby005
            END IF 
 
 
 
            #add-point:AFTER FIELD imby005 name="input.a.page1.imby005"
            IF NOT cl_null(g_imby_d[l_ac].imby005) THEN   
               #IF g_imba_m.imba109 = '1' AND g_imba_m.imba100 = '2' AND  g_imby_d[l_ac].imby002 = '2'  THEN  #160604-00009#91 dongsz mark
               IF (g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '8' OR g_imba_m.imba109 = '9' OR g_imba_m.imba109 = '10') AND  #160604-00009#91 dongsz add
                  g_imba_m.imba100 = '2' AND  g_imby_d[l_ac].imby002 = '2'  THEN   #160604-00009#91 dongsz add
                  IF NOT artt300_imby005_chk() THEN
                     LET g_imby_d[l_ac].imby005 =g_imby_d_t.imby005
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               #150710-00016#1 20150713 mark by beckxie---S
               #150602-00072#1 Add-S By Ken 150602
#               IF NOT artt300_imby005_chk_2() THEN
#                  INITIALIZE g_errparam TO NULL
#                    LET g_errparam.code = 'art-00591'
#                    LET g_errparam.extend = '輸入件裝數：',g_imby_d[l_ac].imby005
#                    LET g_errparam.popup = TRUE
#                    LET g_errparam.replace[1] = g_imby_d[l_ac].imby001
#                    LET g_errparam.replace[2] = g_imby_d[l_ac].imby004
#                    LET g_errparam.replace[3] = g_imby_d_o.imby005                
#                    CALL cl_err()
#                  
#                  LET g_imby_d[l_ac].imby005 = g_imby_d_o.imby005
#                  NEXT FIELD CURRENT            
#               END IF   
               #150602-00072#1 Add-E By Ken 150602          
               #150710-00016#1 20150713 mark by beckxie---E
            END IF            
            LET  g_imby_d_o.imby005 = g_imby_d[l_ac].imby005 #150602-00072#1 By Ken 150602 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby005
            #add-point:BEFORE FIELD imby005 name="input.b.page1.imby005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby005
            #add-point:ON CHANGE imby005 name="input.g.page1.imby005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby006
            #add-point:BEFORE FIELD imby006 name="input.b.page1.imby006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby006
            
            #add-point:AFTER FIELD imby006 name="input.a.page1.imby006"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby006
            #add-point:ON CHANGE imby006 name="input.g.page1.imby006"
            IF g_imby_d[l_ac].imby006 = 'Y' AND g_imby_d[l_ac].imbystus = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00033'
               LET g_errparam.extend = g_imby_d[l_ac].imby006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imby_d[l_ac].imby006 = 'N'
               NEXT FIELD CURRENT
            END IF
            
            IF g_imby_d[l_ac].imby006 = 'Y' AND g_imby_d[l_ac].imby004 != g_imba_m.imba104 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00401'
               LET g_errparam.extend = g_imby_d[l_ac].imby006
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_imby_d[l_ac].imby006 = 'N'
               NEXT FIELD CURRENT
            END IF   
            #20140527--dongsz--add---
            IF NOT cl_null(g_imby_d[l_ac].imby003) AND g_imby_d[l_ac].imby006 = 'Y' 
               AND g_imby_d[l_ac].imby002 = '2' THEN
               IF NOT artt300_imby006_chk() THEN
                  LET g_imby_d[l_ac].imby006 = 'N'
                  NEXT FIELD CURRENT
               END IF
            END IF
            #20140527--dongsz--add---
            IF NOT cl_null(g_imby_d[l_ac].imby003) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imby_t
                WHERE imbydocno = g_imba_m.imbadocno
                  AND imby003 != g_imby_d[l_ac].imby003
                  AND imby006 = 'Y'
                  AND imbyent = g_enterprise
               IF l_cnt != 0 AND g_imby_d[l_ac].imby006 = 'Y' THEN
                  IF cl_ask_confirm('art-00026') THEN
                     UPDATE imby_t SET imby006 = 'N'
                      WHERE imbydocno = g_imba_m.imbadocno
                        AND imby003 != g_imby_d[l_ac].imby003
                        AND imby006 = 'Y'
                        AND imbyent = g_enterprise
                     FOR l_i = 1 TO g_imby_d.getLength()
                        IF l_i != l_ac THEN
                           LET g_imby_d[l_i].imby006 = 'N'
                        END IF
                     END FOR
                  ELSE
                     LET g_imby_d[l_ac].imby006 = 'N'
                  END IF
               END IF
            ELSE
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imby_t
                WHERE imbydocno = g_imba_m.imbadocno                  
                  AND imby006 = 'Y'
                  AND imbyent = g_enterprise
               IF l_cnt != 0 AND g_imby_d[l_ac].imby006 = 'Y' THEN
                  IF cl_ask_confirm('art-00026') THEN
                     UPDATE imby_t SET imby006 = 'N'
                      WHERE imbydocno = g_imba_m.imbadocno
                        AND imby006 = 'Y'
                        AND imbyent = g_enterprise
                     FOR l_i = 1 TO g_imby_d.getLength()
                        IF l_i != l_ac THEN
                           LET g_imby_d[l_i].imby006 = 'N'
                        END IF
                     END FOR
                  ELSE
                     LET g_imby_d[l_ac].imby006 = 'N'
                  END IF
               END IF
            END IF
            #dongsz--add--str---
            IF g_imby_d[l_ac].imby006 = 'Y' THEN
               LET g_imba_m.imba100 = g_imby_d[l_ac].imby002
               LET g_imba_m.imba014 = g_imby_d[l_ac].imby003
               LET g_imba_m.imba113 = g_imby_d[l_ac].imby018 #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
               #160604-00009#91--dongsz mark--s
#               IF g_imba_m.imba100 = '1' THEN
#                  LET g_imba_m.imba109 = '1'
#               END IF                  
               #160604-00009#91--dongsz mark--e
               UPDATE imba_t SET imba100 = g_imby_d[l_ac].imby002,
                                 imba014 = g_imby_d[l_ac].imby003,
                                 imba113 = g_imby_d[l_ac].imby018, #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
                                 imba109 = g_imba_m.imba109
                WHERE imbaent = g_enterprise
                  AND imbadocno = g_imba_m.imbadocno
               DISPLAY BY NAME g_imba_m.imba100,g_imba_m.imba014,g_imba_m.imba109
               LET g_imba_m_o.imba100 = g_imba_m.imba100
               LET g_imba_m_o.imba014 = g_imba_m.imba014
               LET g_imba_m_o.imba113 = g_imba_m.imba113 #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
            END IF
            #dongsz--add--end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby018
            #add-point:BEFORE FIELD imby018 name="input.b.page1.imby018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby018
            
            #add-point:AFTER FIELD imby018 name="input.a.page1.imby018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby018
            #add-point:ON CHANGE imby018 name="input.g.page1.imby018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby007
            END IF 
 
 
 
            #add-point:AFTER FIELD imby007 name="input.a.page1.imby007"
                                    IF NOT cl_null(g_imby_d[l_ac].imby007) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby007
            #add-point:BEFORE FIELD imby007 name="input.b.page1.imby007"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby007
            #add-point:ON CHANGE imby007 name="input.g.page1.imby007"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby008
            END IF 
 
 
 
            #add-point:AFTER FIELD imby008 name="input.a.page1.imby008"
                                    IF NOT cl_null(g_imby_d[l_ac].imby008) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby008
            #add-point:BEFORE FIELD imby008 name="input.b.page1.imby008"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby008
            #add-point:ON CHANGE imby008 name="input.g.page1.imby008"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby009
            END IF 
 
 
 
            #add-point:AFTER FIELD imby009 name="input.a.page1.imby009"
                                    IF NOT cl_null(g_imby_d[l_ac].imby009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby009
            #add-point:BEFORE FIELD imby009 name="input.b.page1.imby009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby009
            #add-point:ON CHANGE imby009 name="input.g.page1.imby009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby015
            
            #add-point:AFTER FIELD imby015 name="input.a.page1.imby015"
            LET g_imby_d[l_ac].imby015_desc = ''
            IF NOT cl_null(g_imby_d[l_ac].imby015) THEN
#               IF g_imby_d[l_ac].imby015 != g_imby_d_t.imby015 OR g_imby_d_t.imby015 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imby_d[l_ac].imby015 != g_imby_d_t.imby015 OR cl_null(g_imby_d_t.imby015) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imby_d[l_ac].imby015)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby_d[l_ac].imby015
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imby_d[l_ac].imby015 = g_imby_d_t.imby015
                     CALL artt300_imby015_ref()
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
            END IF
            CALL artt300_imby015_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby015
            #add-point:BEFORE FIELD imby015 name="input.b.page1.imby015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby015
            #add-point:ON CHANGE imby015 name="input.g.page1.imby015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby010
            END IF 
 
 
 
            #add-point:AFTER FIELD imby010 name="input.a.page1.imby010"
                                    IF NOT cl_null(g_imby_d[l_ac].imby010) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby010
            #add-point:BEFORE FIELD imby010 name="input.b.page1.imby010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby010
            #add-point:ON CHANGE imby010 name="input.g.page1.imby010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby016
            
            #add-point:AFTER FIELD imby016 name="input.a.page1.imby016"
            LET g_imby_d[l_ac].imby016_desc = ''
            IF NOT cl_null(g_imby_d[l_ac].imby016) THEN
#               IF g_imby_d[l_ac].imby016 != g_imby_d_t.imby016 OR g_imby_d_t.imby016 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imby_d[l_ac].imby016 != g_imby_d_t.imby016 OR cl_null(g_imby_d_t.imby016) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imby_d[l_ac].imby016)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby_d[l_ac].imby016
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imby_d[l_ac].imby016 = g_imby_d_t.imby016
                     CALL artt300_imby016_ref()
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
            END IF
            CALL artt300_imby016_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby016
            #add-point:BEFORE FIELD imby016 name="input.b.page1.imby016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby016
            #add-point:ON CHANGE imby016 name="input.g.page1.imby016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby_d[l_ac].imby011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imby011
            END IF 
 
 
 
            #add-point:AFTER FIELD imby011 name="input.a.page1.imby011"
                                    IF NOT cl_null(g_imby_d[l_ac].imby011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby011
            #add-point:BEFORE FIELD imby011 name="input.b.page1.imby011"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby011
            #add-point:ON CHANGE imby011 name="input.g.page1.imby011"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby017
            
            #add-point:AFTER FIELD imby017 name="input.a.page1.imby017"
            LET g_imby_d[l_ac].imby017_desc = ''
            IF NOT cl_null(g_imby_d[l_ac].imby017) THEN
#               IF g_imby_d[l_ac].imby017 != g_imby_d_t.imby017 OR g_imby_d_t.imby017 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imby_d[l_ac].imby017 != g_imby_d_t.imby017 OR cl_null(g_imby_d_t.imby017) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imby_d[l_ac].imby017)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby_d[l_ac].imby017
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imby_d[l_ac].imby017 = g_imby_d_t.imby017
                     CALL artt300_imby017_ref()
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
            END IF
            CALL artt300_imby017_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby017
            #add-point:BEFORE FIELD imby017 name="input.b.page1.imby017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby017
            #add-point:ON CHANGE imby017 name="input.g.page1.imby017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby012
            #add-point:BEFORE FIELD imby012 name="input.b.page1.imby012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby012
            
            #add-point:AFTER FIELD imby012 name="input.a.page1.imby012"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby012
            #add-point:ON CHANGE imby012 name="input.g.page1.imby012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby013
            #add-point:BEFORE FIELD imby013 name="input.b.page1.imby013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby013
            
            #add-point:AFTER FIELD imby013 name="input.a.page1.imby013"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby013
            #add-point:ON CHANGE imby013 name="input.g.page1.imby013"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imby014
            #add-point:BEFORE FIELD imby014 name="input.b.page1.imby014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imby014
            
            #add-point:AFTER FIELD imby014 name="input.a.page1.imby014"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imby014
            #add-point:ON CHANGE imby014 name="input.g.page1.imby014"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imby001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby001
            #add-point:ON ACTION controlp INFIELD imby001 name="input.c.page1.imby001"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imbystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbystus
            #add-point:ON ACTION controlp INFIELD imbystus name="input.c.page1.imbystus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby002
            #add-point:ON ACTION controlp INFIELD imby002 name="input.c.page1.imby002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby019
            #add-point:ON ACTION controlp INFIELD imby019 name="input.c.page1.imby019"
            #160801-00017#4 20160805 add by beckxie---S
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(g_imba_m.imba005) THEN
               #160803-00008#3 20160811 add by beckxie---S
               IF l_cmd = 'a' AND g_imby_d[l_ac].imby002 = '3' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature_1(l_cmd,'1',g_imba_m.imba001,'',g_site,g_imba_m.imbadocno) 
                       RETURNING l_success,l_inam
                  LET g_imby_d[l_ac].imby019 = l_inam[1].inam002
                   CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
                        RETURNING l_success,g_imby_d[l_ac].imby019_desc
                  IF NOT cl_null(l_inam[1].inam002) THEN
                     LET g_imby_d[l_ac].imby003 = g_imba_m.imba001,s_feature_get_feature_str(g_imby_d[l_ac].imby019)
                  END IF
                  #160822-00036#3 20160824 add by beckxie---S
                  IF l_inam.getlength() >1 THEN
                     #根據選的特徵自動生成多筆條碼資料
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF NOT artt300_ins_imby(l_inam) THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                     CALL cl_err_collect_show()
                     CALL artt300_show()
                     #因為可能會修改此筆資料,顯示後需刪除
                     DELETE FROM imby_t 
                      WHERE imbyent = g_enterprise 
                        AND imbydocno = g_imba_m.imbadocno
                        AND imby003 = g_imby_d[l_ac].imby003
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "DELETE FROM :"
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     END IF
                  END IF           
                  #160822-00036#3 20160824 add by beckxie---E
               ELSE
               #160803-00008#3 20160811 add by beckxie---E
                  CALL s_feature_single_t(g_imba_m.imba001,g_imby_d[l_ac].imby019,g_site,g_imba_m.imbadocno)
                       RETURNING l_success,g_imby_d[l_ac].imby019
                  CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
                        RETURNING l_success,g_imby_d[l_ac].imby019_desc
               END IF   #160803-00008#3 20160811 add by beckxie
            END IF     
            DISPLAY BY NAME g_imby_d[l_ac].imby019,g_imby_d[l_ac].imby019_desc
            #160801-00017#4 20160805 add by beckxie---E
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby019_desc
            #add-point:ON ACTION controlp INFIELD imby019_desc name="input.c.page1.imby019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby003
            #add-point:ON ACTION controlp INFIELD imby003 name="input.c.page1.imby003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby004
            #add-point:ON ACTION controlp INFIELD imby004 name="input.c.page1.imby004"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imby_d[l_ac].imby004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imby_d[l_ac].imby004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imby_d[l_ac].imby004 TO imby004              #顯示到畫面上
            CALL artt300_imby004_ref()
            NEXT FIELD imby004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imby005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby005
            #add-point:ON ACTION controlp INFIELD imby005 name="input.c.page1.imby005"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby006
            #add-point:ON ACTION controlp INFIELD imby006 name="input.c.page1.imby006"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby018
            #add-point:ON ACTION controlp INFIELD imby018 name="input.c.page1.imby018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby007
            #add-point:ON ACTION controlp INFIELD imby007 name="input.c.page1.imby007"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby008
            #add-point:ON ACTION controlp INFIELD imby008 name="input.c.page1.imby008"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby009
            #add-point:ON ACTION controlp INFIELD imby009 name="input.c.page1.imby009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby015
            #add-point:ON ACTION controlp INFIELD imby015 name="input.c.page1.imby015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imby_d[l_ac].imby015             #給予default值      
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imby_d[l_ac].imby015 = g_qryparam.return1              
            DISPLAY g_imby_d[l_ac].imby015 TO imby015              
            CALL artt300_imby015_ref()
            NEXT FIELD imby015                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby010
            #add-point:ON ACTION controlp INFIELD imby010 name="input.c.page1.imby010"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby016
            #add-point:ON ACTION controlp INFIELD imby016 name="input.c.page1.imby016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imby_d[l_ac].imby016             #給予default值
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imby_d[l_ac].imby016 = g_qryparam.return1              
            DISPLAY g_imby_d[l_ac].imby016 TO imby016              #
            CALL artt300_imby016_ref()
            NEXT FIELD imby016                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby011
            #add-point:ON ACTION controlp INFIELD imby011 name="input.c.page1.imby011"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby017
            #add-point:ON ACTION controlp INFIELD imby017 name="input.c.page1.imby017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imby_d[l_ac].imby017             #給予default值           
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imby_d[l_ac].imby017 = g_qryparam.return1              
            DISPLAY g_imby_d[l_ac].imby017 TO imby017              #
            CALL artt300_imby017_ref()
            NEXT FIELD imby017                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby012
            #add-point:ON ACTION controlp INFIELD imby012 name="input.c.page1.imby012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby013
            #add-point:ON ACTION controlp INFIELD imby013 name="input.c.page1.imby013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imby014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imby014
            #add-point:ON ACTION controlp INFIELD imby014 name="input.c.page1.imby014"
                        
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imby_d[l_ac].* = g_imby_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imby_d[l_ac].imby003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imby_d[l_ac].* = g_imby_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_imby_d[l_ac].imbystus = 'N' THEN
                  LET g_imby_d[l_ac].imby006 = 'N'
               END IF
#               #20140515--add--dongsz--- #20150417--mark--geza---
#               IF g_imby_d[l_ac].imby002 = '2' AND g_imby_d_t.imby002 = '1' THEN
#                  IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#                     IF g_imby_d[l_ac].imby005 = 1 THEN
#                        CALL s_auto_barcode('1') RETURNING g_imby_d[l_ac].imby003,l_success
#                     END IF
#                     IF g_imby_d[l_ac].imby005 > 1 THEN
#                        CALL s_auto_barcode('2') RETURNING g_imby_d[l_ac].imby003,l_success
#                     END IF
#                  END IF
#                  IF g_imba_m.imba109 = '2' THEN
#                     CALL s_auto_barcode('4') RETURNING g_imby_d[l_ac].imby003,l_success
#                  END IF
#                  IF g_imba_m.imba109 = '3' THEN
#                     CALL s_auto_barcode('5') RETURNING g_imby_d[l_ac].imby003,l_success
#                  END IF
#                  IF NOT l_success THEN
#                     LET g_imby_d[l_ac].* = g_imby_d_t.*                     
#                     CALL s_transaction_end('N','0')
#                  END IF
#               END IF
#               #20140515--add--dongsz---  

               #20150417--add--geza---
               IF g_imby_d[l_ac].imby002 = '2' AND g_imby_d_t.imby002 = '1' THEN
                  #IF g_imba_m.imba109 = '1'  THEN     #160604-00009#91 dongsz mark
                  IF g_imba_m.imba109 <> '4' AND g_imba_m.imba109 <> '5' THEN     #160604-00009#91 dongsz add
                     IF g_imby_d[l_ac].imby005 = 1 THEN
                        #CALL s_auto_barcode('1') RETURNING g_imby_d[l_ac].imby003,l_success   #160604-00009#91 dongsz mark
                        CALL s_auto_barcode(g_imba_m.imba109) RETURNING g_imby_d[l_ac].imby003,l_success   #160604-00009#91 dongsz add
                     END IF
                     IF g_imby_d[l_ac].imby005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imby_d[l_ac].imby003,l_success
                     END IF
                  END IF
                  IF g_imba_m.imba109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imby_d[l_ac].imby003,l_success
                  END IF
                  IF g_imba_m.imba109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imby_d[l_ac].imby003,l_success
                  END IF
                  IF NOT l_success THEN
                     LET g_imby_d[l_ac].* = g_imby_d_t.*                     
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #20150417--add--geza---
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL artt300_imby_t_mask_restore('restore_mask_o')
      
               UPDATE imby_t SET (imbydocno,imby001,imbystus,imby002,imby019,imby003,imby004,imby005, 
                   imby006,imby018,imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012, 
                   imby013,imby014) = (g_imba_m.imbadocno,g_imby_d[l_ac].imby001,g_imby_d[l_ac].imbystus, 
                   g_imby_d[l_ac].imby002,g_imby_d[l_ac].imby019,g_imby_d[l_ac].imby003,g_imby_d[l_ac].imby004, 
                   g_imby_d[l_ac].imby005,g_imby_d[l_ac].imby006,g_imby_d[l_ac].imby018,g_imby_d[l_ac].imby007, 
                   g_imby_d[l_ac].imby008,g_imby_d[l_ac].imby009,g_imby_d[l_ac].imby015,g_imby_d[l_ac].imby010, 
                   g_imby_d[l_ac].imby016,g_imby_d[l_ac].imby011,g_imby_d[l_ac].imby017,g_imby_d[l_ac].imby012, 
                   g_imby_d[l_ac].imby013,g_imby_d[l_ac].imby014)
                WHERE imbyent = g_enterprise AND imbydocno = g_imba_m.imbadocno 
 
                  AND imby003 = g_imby_d_t.imby003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imby_d[l_ac].* = g_imby_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imby_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imby_d[l_ac].* = g_imby_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imby_d[g_detail_idx].imby003
               LET gs_keys_bak[2] = g_imby_d_t.imby003
               CALL artt300_update_b('imby_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt300_imby_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imby_d[g_detail_idx].imby003 = g_imby_d_t.imby003 
 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imby_d_t.imby003
 
                  CALL artt300_key_update_b(gs_keys,'imby_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imby_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imby_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                             CALL artt300_upd_imbz()                                  
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                        
            #end add-point
            CALL artt300_unlock_b("imby_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            FOR l_i = 1 TO g_imby_d.getLength()
               CALL artt300_chk_barcode(g_imby_d[l_i].imby003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imby_d[l_i].imby003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD imby003
               END IF 
            END FOR
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM imby_t
             WHERE imbydocno = g_imba_m.imbadocno
               AND imbyent   = g_enterprise
               AND imby006   = 'Y'
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00025'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

#               NEXT FIELD imby006
               #dongsz--add--str---             
#               LET g_imba_m.imba100 = ""  #geza--mark--20150417---
               LET g_imba_m.imba014 = ""
               LET g_imba_m.imba019 = ""
               LET g_imba_m.imba020 = ""
               LET g_imba_m.imba021 = ""
               LET g_imba_m.imba022 = ""
               LET g_imba_m.imba025 = ""
               LET g_imba_m.imba026 = ""
               LET g_imba_m.imba016 = ""
               LET g_imba_m.imba018 = ""
               UPDATE imba_t SET imba100 = g_imba_m.imba100,
                                 imba014 = g_imba_m.imba014,
                                 imba019 = g_imba_m.imba019,
                                 imba020 = g_imba_m.imba020,
                                 imba021 = g_imba_m.imba021,
                                 imba022 = g_imba_m.imba022,
                                 imba025 = g_imba_m.imba025,
                                 imba026 = g_imba_m.imba026,
                                 imba016 = g_imba_m.imba016,
                                 imba018 = g_imba_m.imba018                                 
                WHERE imbaent = g_enterprise
                  AND imbadocno = g_imba_m.imbadocno
               DISPLAY BY NAME g_imba_m.imba100,g_imba_m.imba014,g_imba_m.imba019,g_imba_m.imba020,
                               g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba025,g_imba_m.imba026,
                               g_imba_m.imba016,g_imba_m.imba018
               #dongsz--add--end---
              CALL artt300_imba022_ref()
              CALL artt300_imba026_ref()
              CALL artt300_imba018_ref()
            ELSE
               IF l_cnt = 1 THEN
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt FROM imby_t
                   WHERE imbyent = g_enterprise
                     AND imbydocno = g_imba_m.imbadocno
                     AND imby006 = 'Y'
                     AND imbystus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD imby006
                  END IF
                  SELECT imby002,imby003,
                         imby007,imby008,imby009,imby015,
                         imby010,imby016,
                         imby011,imby017
                    INTO g_imba_m.imba100,g_imba_m.imba014,
                         g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,
                         g_imba_m.imba025,g_imba_m.imba026,
                         g_imba_m.imba016,g_imba_m.imba018
                    FROM imby_t
                   WHERE imbyent = g_enterprise
                     AND imbydocno = g_imba_m.imbadocno
                     AND imby006 = 'Y'
                  
                  UPDATE imba_t SET imba100 = g_imba_m.imba100,
                                    imba014 = g_imba_m.imba014,
                                    imba019 = g_imba_m.imba019,
                                    imba020 = g_imba_m.imba020,
                                    imba021 = g_imba_m.imba021,
                                    imba022 = g_imba_m.imba022,
                                    imba025 = g_imba_m.imba025,
                                    imba026 = g_imba_m.imba026,
                                    imba016 = g_imba_m.imba016,
                                    imba018 = g_imba_m.imba018                                    
                   WHERE imbaent = g_enterprise
                     AND imbadocno = g_imba_m.imbadocno
                  DISPLAY BY NAME g_imba_m.imba100,g_imba_m.imba014,g_imba_m.imba019,g_imba_m.imba020,
                                  g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba025,g_imba_m.imba026,
                                  g_imba_m.imba016,g_imba_m.imba018   
                  CALL artt300_imba022_ref()
                  CALL artt300_imba026_ref()
                  CALL artt300_imba018_ref()    
                  #160604-00009#91--dongsz mark--s                  
#                  IF g_imba_m.imba100 = '1' THEN
#                     UPDATE imba_t SET imba109 = '1'
#                      WHERE imbaent = g_enterprise
#                        AND imbadocno = g_imba_m.imbadocno
#                     DISPLAY BY NAME g_imba_m.imba109
#                  END IF
                  #160604-00009#91--dongsz mark--e
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00024'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imby006
               END IF
            END IF
            #150629-00021#1 20150629 add by beckxie---S
            CALL s_transaction_begin()
            CALL s_artt300_ins_imbo(g_imba_m.imbadocno) RETURNING l_success
            CALL artt300_b_fill()
            CALL s_transaction_end('Y',0)
            #150629-00021#1 20150629 add by beckxie---E
            LET g_imba_m_o.imba100 = g_imba_m.imba100
            LET g_imba_m_o.imba014 = g_imba_m.imba014  
            LET g_imba_m_o.imba019 = g_imba_m.imba019            
            LET g_imba_m_o.imba020 = g_imba_m.imba020  
            LET g_imba_m_o.imba021 = g_imba_m.imba021  
            LET g_imba_m_o.imba022 = g_imba_m.imba022  
            LET g_imba_m_o.imba025 = g_imba_m.imba025  
            LET g_imba_m_o.imba026 = g_imba_m.imba026  
            LET g_imba_m_o.imba016 = g_imba_m.imba016 
            LET g_imba_m_o.imba018 = g_imba_m.imba018  
            LET g_imba_m_t.imba100 = g_imba_m.imba100
            LET g_imba_m_t.imba014 = g_imba_m.imba014  
            LET g_imba_m_t.imba019 = g_imba_m.imba019            
            LET g_imba_m_t.imba020 = g_imba_m.imba020  
            LET g_imba_m_t.imba021 = g_imba_m.imba021  
            LET g_imba_m_t.imba022 = g_imba_m.imba022  
            LET g_imba_m_t.imba025 = g_imba_m.imba025  
            LET g_imba_m_t.imba026 = g_imba_m.imba026  
            LET g_imba_m_t.imba016 = g_imba_m.imba016 
            LET g_imba_m_t.imba018 = g_imba_m.imba018
            LET g_assign_no = 'Y'                             
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imby_d[li_reproduce_target].* = g_imby_d[li_reproduce].*
 
               LET g_imby_d[li_reproduce_target].imby003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imby_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imby_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_imby2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imby2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imby2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
                        
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imby2_d[l_ac].* TO NULL 
            INITIALIZE g_imby2_d_t.* TO NULL 
            INITIALIZE g_imby2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_imby2_d[l_ac].imbz005 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_imby2_d_t.* = g_imby2_d[l_ac].*     #新輸入資料
            LET g_imby2_d_o.* = g_imby2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
                        
            #end add-point
            CALL artt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imby2_d[li_reproduce_target].* = g_imby2_d[li_reproduce].*
 
               LET g_imby2_d[li_reproduce_target].imbz002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
                                    LET g_imby2_d[l_ac].imbz001 = g_imba_m.imba001
            LET g_imby2_d_t.* = g_imby2_d[l_ac].*
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imby2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imby2_d[l_ac].imbz002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imby2_d_t.* = g_imby2_d[l_ac].*  #BACKUP
               LET g_imby2_d_o.* = g_imby2_d[l_ac].*  #BACKUP
               CALL artt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
                              
               #end add-point  
               CALL artt300_set_no_entry_b(l_cmd)
               IF NOT artt300_lock_b("imbz_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt300_bcl2 INTO g_imby2_d[l_ac].imbz001,g_imby2_d[l_ac].imbz002,g_imby2_d[l_ac].imbz003, 
                      g_imby2_d[l_ac].imbz006,g_imby2_d[l_ac].imbz004,g_imby2_d[l_ac].imbz005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imby2_d_mask_o[l_ac].* =  g_imby2_d[l_ac].*
                  CALL artt300_imbz_t_mask()
                  LET g_imby2_d_mask_n[l_ac].* =  g_imby2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
                        
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
                              
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imba_m.imbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_imby2_d_t.imbz002
            
               #刪除同層單身
               IF NOT artt300_delete_b('imbz_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt300_key_delete_b(gs_keys,'imbz_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
                              
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE artt300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                                    
               #end add-point
               LET l_count = g_imby_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
                        
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imby2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
                        
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imbz_t 
             WHERE imbzent = g_enterprise AND imbzdocno = g_imba_m.imbadocno
               AND imbz002 = g_imby2_d[l_ac].imbz002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imby2_d[g_detail_idx].imbz002
               CALL artt300_insert_b('imbz_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_imby_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt300_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
                              
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imby2_d[l_ac].* = g_imby2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt300_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imby2_d[l_ac].* = g_imby2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL artt300_imbz_t_mask_restore('restore_mask_o')
                              
               UPDATE imbz_t SET (imbzdocno,imbz001,imbz002,imbz003,imbz006,imbz004,imbz005) = (g_imba_m.imbadocno, 
                   g_imby2_d[l_ac].imbz001,g_imby2_d[l_ac].imbz002,g_imby2_d[l_ac].imbz003,g_imby2_d[l_ac].imbz006, 
                   g_imby2_d[l_ac].imbz004,g_imby2_d[l_ac].imbz005) #自訂欄位頁簽
                WHERE imbzent = g_enterprise AND imbzdocno = g_imba_m.imbadocno
                  AND imbz002 = g_imby2_d_t.imbz002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imby2_d[l_ac].* = g_imby2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbz_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imby2_d[l_ac].* = g_imby2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imby2_d[g_detail_idx].imbz002
               LET gs_keys_bak[2] = g_imby2_d_t.imbz002
               CALL artt300_update_b('imbz_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL artt300_imbz_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imby2_d[g_detail_idx].imbz002 = g_imby2_d_t.imbz002 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_imby2_d_t.imbz002
                  CALL artt300_key_update_b(gs_keys,'imbz_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imby2_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imby2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
                              
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz001
            #add-point:BEFORE FIELD imbz001 name="input.b.page2.imbz001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz001
            
            #add-point:AFTER FIELD imbz001 name="input.a.page2.imbz001"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz001
            #add-point:ON CHANGE imbz001 name="input.g.page2.imbz001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz002
            #add-point:BEFORE FIELD imbz002 name="input.b.page2.imbz002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz002
            
            #add-point:AFTER FIELD imbz002 name="input.a.page2.imbz002"
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imby2_d[l_ac].imbz002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imby2_d[l_ac].imbz002 != g_imby2_d_t.imbz002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imbz_t WHERE "||"imbzent = '" ||g_enterprise|| "' AND "||"imbzdocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbz002 = '"||g_imby2_d[l_ac].imbz002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz002
            #add-point:ON CHANGE imbz002 name="input.g.page2.imbz002"
                                 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz003
            #add-point:BEFORE FIELD imbz003 name="input.b.page2.imbz003"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz003
            
            #add-point:AFTER FIELD imbz003 name="input.a.page2.imbz003"
                                    IF NOT cl_null(g_imby2_d[l_ac].imbz003) THEN
               CALL artt300_chk_imbz003()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imby2_d[l_ac].imbz003
                   #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'artt300'
                           LET g_errparam.replace[2] = cl_get_progname('artt300',g_lang,"2")
                           LET g_errparam.exeprog = 'artt300'
                     END CASE
                     #160318-00005#43 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imby2_d[l_ac].imbz003 = g_imby2_d_t.imbz003  
                  DISPLAY BY NAME g_imby2_d[l_ac].imbz003
                                    
                  NEXT FIELD CURRENT
               END IF
            END IF            

            CALL artt300_set_entry_b(l_cmd)
            CALL artt300_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz003
            #add-point:ON CHANGE imbz003 name="input.g.page2.imbz003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz006
            #add-point:BEFORE FIELD imbz006 name="input.b.page2.imbz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz006
            
            #add-point:AFTER FIELD imbz006 name="input.a.page2.imbz006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz006
            #add-point:ON CHANGE imbz006 name="input.g.page2.imbz006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz004
            
            #add-point:AFTER FIELD imbz004 name="input.a.page2.imbz004"
                                    LET g_imby2_d[l_ac].imbz004_desc = ''
            IF NOT cl_null(g_imby2_d[l_ac].imbz004) THEN
#               IF g_imby2_d[l_ac].imbz004 != g_imby2_d_t.imbz004 OR g_imby2_d_t.imbz004 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imby2_d[l_ac].imbz004 != g_imby2_d_t.imbz004 OR cl_null(g_imby2_d_t.imbz004) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt300_chk_unit(g_imby2_d[l_ac].imbz004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imby2_d[l_ac].imbz004
                     #160318-00005#43 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#43 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imby2_d[l_ac].imbz004 = g_imby2_d_t.imbz004
                     CALL artt300_imbz004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  SELECT imby005 INTO g_imby2_d[l_ac].imbz005 FROM imby_t
                   WHERE imbyent = g_enterprise
                     AND imbydocno = g_imba_m.imbadocno
                     AND imby004 = g_imby2_d[l_ac].imbz004
                     AND imbystus = 'Y'
               END IF
            END IF
            CALL artt300_imbz004_ref()
            CALL artt300_set_entry_b(l_cmd)   
            CALL artt300_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz004
            #add-point:BEFORE FIELD imbz004 name="input.b.page2.imbz004"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz004
            #add-point:ON CHANGE imbz004 name="input.g.page2.imbz004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbz005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imby2_d[l_ac].imbz005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD imbz005
            END IF 
 
 
 
            #add-point:AFTER FIELD imbz005 name="input.a.page2.imbz005"
                                    IF cl_null(g_imby2_d[l_ac].imbz005) THEN 
               LET g_imby2_d[l_ac].imbz005 = 1
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbz005
            #add-point:BEFORE FIELD imbz005 name="input.b.page2.imbz005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbz005
            #add-point:ON CHANGE imbz005 name="input.g.page2.imbz005"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.imbz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz001
            #add-point:ON ACTION controlp INFIELD imbz001 name="input.c.page2.imbz001"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page2.imbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz002
            #add-point:ON ACTION controlp INFIELD imbz002 name="input.c.page2.imbz002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page2.imbz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz003
            #add-point:ON ACTION controlp INFIELD imbz003 name="input.c.page2.imbz003"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imby2_d[l_ac].imbz003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_imba_m.imbadocno #申請單號

            CALL q_imby003()                                #呼叫開窗

            LET g_imby2_d[l_ac].imbz003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imby2_d[l_ac].imbz003 TO imbz003              #顯示到畫面上

            NEXT FIELD imbz003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.imbz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz006
            #add-point:ON ACTION controlp INFIELD imbz006 name="input.c.page2.imbz006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.imbz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz004
            #add-point:ON ACTION controlp INFIELD imbz004 name="input.c.page2.imbz004"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imby2_d[l_ac].imbz004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imby2_d[l_ac].imbz004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imby2_d[l_ac].imbz004 TO imbz004              #顯示到畫面上
            CALL artt300_imbz004_ref()
            NEXT FIELD imbz004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.imbz005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbz005
            #add-point:ON ACTION controlp INFIELD imbz005 name="input.c.page2.imbz005"
                        
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
                        
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imby2_d[l_ac].* = g_imby2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt300_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL artt300_unlock_b("imbz_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            #150629-00021#1 20150629 add by beckxie---S
            CALL s_transaction_begin()
            CALL s_artt300_ins_imbo(g_imba_m.imbadocno) RETURNING l_success
            CALL artt300_b_fill()
            CALL s_transaction_end('Y',0)
            #150629-00021#1 20150629 add by beckxie---E
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imby2_d[li_reproduce_target].* = g_imby2_d[li_reproduce].*
 
               LET g_imby2_d[li_reproduce_target].imbz002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imby2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imby2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_imby3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt300_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL artt300_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="artt300.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aim_aimm200_01.aimm200_01_input   #lori522612  150126 add---嵌入產品特徵值      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #lori522612  150126 add -----------------------(S)
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #NEXT FIELD imbadocno    #150122-00013#1 151103 By pomelo mark
            NEXT FIELD imba000       #150122-00013#1 151103 By pomelo add
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imby001
               WHEN "s_detail2"
                  NEXT FIELD imbz001
               WHEN "s_detail3"
                  NEXT FIELD imbo002
               WHEN "s_detail1_aimm200_01"
                  #判斷當前料號的產品特徵是否可以維護，如果不可以維護，進入其他欄位
                  IF NOT artt300_imak003_enrty_chk() THEN
                     NEXT FIELD imba011
                  ELSE
                     NEXT FIELD imak003
                  END IF
            OTHERWISE
               IF NOT artt300_imak003_enrty_chk() THEN
                  NEXT FIELD imba002
               ELSE
                  NEXT FIELD imak003                  
               END IF                   
            END CASE
         END IF         
         #lori522612  150126 add -----------------------(E)         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD imbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imby001
               WHEN "s_detail2"
                  NEXT FIELD imbz001
               WHEN "s_detail3"
                  NEXT FIELD imbo002
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_imbf062    LIKE imbf_t.imbf062
   DEFINE l_imbf063    LIKE imbf_t.imbf063
   DEFINE l_imbf064    LIKE imbf_t.imbf064      
   DEFINE l_success    LIKE type_t.num5   #160801-00017#4 20160805 add by beckxie
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #150122-00013#1 150304 pomelo add (s)
   IF g_argv[01] = '2' THEN
      LET g_imba_m.imbf114 = ''
      LET g_imba_m.imbf115 = ''
      LET g_imba_m.imbf116 = ''
      LET g_imba_m.imbf122 = ''
      IF NOT cl_null(g_imba_m.imbadocno) THEN
         SELECT imbf114, imbf115, imbf116, imbf122
           INTO g_imba_m.imbf114, g_imba_m.imbf115, g_imba_m.imbf116, g_imba_m.imbf122
           FROM imbf_t
          WHERE imbfent = g_enterprise
            AND imbfsite = 'ALL'
            AND imbfdocno = g_imba_m.imbadocno
      END IF
   END IF
   #150122-00013#1 150304 pomelo add (e)
   
   #150324-00006#15 150408 by lori522612 add---(S) 
   ##150613 by lori mod---(S)
   #元件增加傳單號,回傳imaf062/imaf063/imaf064
   CALL s_artt300_get_imbf061(g_imba_m.imbadocno,g_imba_m.imba001)
       #150614-00020#1 20150617 mark by beckxie---S
#      RETURNING g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064 
#   DISPLAY BY NAME g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064 
      #150614-00020#1 20150617 mark by beckxie---E
      #150614-00020#1 20150617 add  by beckxie---S
      RETURNING g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
   DISPLAY BY NAME g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                   g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
      #150614-00020#1 20150617 add by  beckxie---E
   #150324-00006#15 150408 by lori522612 add---(E) 
   ##150613 by lori mod---(E)
   
   ##150613 by lori mark---(S)
   ##150427-00001#2 Add-S By Ken 150513 
   #CALL s_artt300_get_imbf062(g_imba_m.imba001)
   #   RETURNING l_imbf062,l_imbf063,l_imbf064
   #LET g_imba_m.l_imbf062 = l_imbf062
   #LET g_imba_m.l_imbf063 = l_imbf063
   #LET g_imba_m.l_imbf064 = l_imbf064
   #DISPLAY BY NAME g_imba_m.l_imbf062   
   #DISPLAY BY NAME g_imba_m.l_imbf063   
   #DISPLAY BY NAME g_imba_m.l_imbf064      
   ##150427-00001#2 Add-E By Ken 150513
   ##150613 by lori mark---(E)
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt300_b_fill() #單身填充
      CALL artt300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imbadocno
   CALL ap_ref_array2(g_ref_fields," SELECT imbal002,imbal003,imbal004 FROM imbal_t WHERE imbalent = '"||g_enterprise||"' AND imbaldocno = ? AND imbal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_imba_m.imbal002 = g_rtn_fields[1]
   LET g_imba_m.imbal003 = g_rtn_fields[2]
   LET g_imba_m.imbal004 = g_rtn_fields[3]
      
   DISPLAY BY NAME g_imba_m.imbal002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbaownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbaowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbacrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbacrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbamodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbacnfid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbacnfid_desc
   #150614-00020#1 20150617 mark by beckxie
#   CALL artt300_imbf063_ref(g_imba_m.l_imbf063) RETURNING  g_imba_m.l_imbf063_desc  #150427-00001#2 Add By Ken 150513
   #150614-00020#1 20150617 add  by beckxie
   CALL artt300_imbf063_ref(g_imba_m.imbf063) RETURNING  g_imba_m.imbf063_desc   
   CALL artt300_imba003_ref()
   CALL artt300_imba105_ref()
   CALL artt300_imba104_ref()
   CALL artt300_imba107_ref()
   CALL artt300_imba106_ref()   
   CALL artt300_imba142_ref()   
   CALL artt300_imba009_ref()
   CALL artt300_imba101_ref()
   CALL artt300_imba114_ref()
   CALL artt300_imba124_ref()
   CALL artt300_imba122_ref()
   CALL artt300_imba131_ref()
   CALL artt300_imba126_ref()
   CALL artt300_imba127_ref()
   CALL artt300_imba128_ref()
   CALL artt300_imba129_ref()
   CALL artt300_imba132_ref()
   CALL artt300_imba133_ref()
   CALL artt300_imba134_ref()
   CALL artt300_imba135_ref()
   CALL artt300_imba136_ref()
   CALL artt300_imba137_ref()
   CALL artt300_imba138_ref()
   CALL artt300_imba139_ref()
   CALL artt300_imba140_ref()
   CALL artt300_imba141_ref()  
   CALL artt300_imba006_ref() 
   CALL artt300_imba143_ref()
   #end add-point
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL artt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
       g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba108,g_imba_m.imba004, 
       g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba006_desc, 
       g_imba_m.imba105,g_imba_m.imba105_desc,g_imba_m.imba104,g_imba_m.imba104_desc,g_imba_m.imba107, 
       g_imba_m.imba107_desc,g_imba_m.imba106,g_imba_m.imba106_desc,g_imba_m.imba145,g_imba_m.imba145_desc, 
       g_imba_m.imba146,g_imba_m.imba146_desc,g_imba_m.imba113,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba142,g_imba_m.imba142_desc,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba026_desc, 
       g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamodid_desc, 
       g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba009_desc,g_imba_m.imba161,g_imba_m.imba161_desc,g_imba_m.imba101,g_imba_m.imba101_desc, 
       g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba114_desc,g_imba_m.imba115, 
       g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba124_desc,g_imba_m.imbf122,g_imba_m.imbf115, 
       g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125, 
       g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba123,g_imba_m.imba131, 
       g_imba_m.imba131_desc,g_imba_m.imba126,g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba143, 
       g_imba_m.imba143_desc,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf063_desc,g_imba_m.imbf064,g_imba_m.imba149, 
       g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imby_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                  CALL artt300_imby004_ref()
      #160801-00017#4 20160805 add by beckxie---S
      CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
      RETURNING l_success,g_imby_d[l_ac].imby019_desc   
      #160801-00017#4 20160805 add by beckxie---E
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_imby2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
                  CALL artt300_imbz004_ref()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imby3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt300_detail_show()
 
   #add-point:show段之後 name="show.after"
   DISPLAY cl_doc_get_pic() TO ffimage   #lori522612  150126 add   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt300_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
      
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
      
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imba_t.imbadocno 
   DEFINE l_oldno     LIKE imba_t.imbadocno 
 
   DEFINE l_master    RECORD LIKE imba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imby_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imbz_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imbo_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success     LIKE type_t.num5     
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imbadocno_t = g_imba_m.imbadocno
 
    
   LET g_imba_m.imbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imba_m.imbaownid = g_user
      LET g_imba_m.imbaowndp = g_dept
      LET g_imba_m.imbacrtid = g_user
      LET g_imba_m.imbacrtdp = g_dept 
      LET g_imba_m.imbacrtdt = cl_get_current()
      LET g_imba_m.imbamodid = g_user
      LET g_imba_m.imbamoddt = cl_get_current()
      LET g_imba_m.imbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #150122-00013#1 150304 pomelo add (s)
   IF g_argv[01] = '2' THEN
      LET g_imba_m.imbf122 = '0'       #銷售子件拆解方式
      LET g_imba_m.imbf115 = 1         #最小銷售數量
      LET g_imba_m.imbf114 = 1         #銷售單位批量
      LET g_imba_m.imbf116 = '3'       #銷售批量控制方式
   END IF
   #150122-00013#1 150304 pomelo add (e)
   
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF    
   
   LET g_imba_m.imbastus = 'N'
   LET g_imba_m.imba014 = ''
   LET g_imba_m.imba001 = ''
   #160120-00001#4 20160130 add by beckxie---S
   LET g_imba_m.imbal002 = ''
   LET g_imba_m.imbal003 = ''
   LET g_imba_m.imbal004 = ''
   #160120-00001#4 20160130 add by beckxie---E
   CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
      RETURNING l_success,g_imba_m.imbadocno

#   LET g_imba_m.imbadocno = g_today

   #160120-00001#4 20160121 add by beckxie---S
   #複製時 申請類別(imba000)均為 I.新增
   LET g_imba_m.imba000 = 'I'
   #160120-00001#4 20160121 add by beckxie---E
   
   LET g_imba_m.imba142 = g_site
   LET g_imba_m.imbadocdt = g_today
   LET g_imba_m_t.* = g_imba_m.*
   LET g_imba_m_o.* = g_imba_m.*                               
   LET g_assign_no = 'N'     
   #160120-00001#4 20160121 add by beckxie---S
   CALL g_imby_d.clear()
   CALL g_imby2_d.clear()
   CALL g_imby3_d.clear()
   CALL aimm200_01_clear_detail()   #產品特徵值  
   #160120-00001#4 20160121 add by beckxie---E
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL artt300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imba_m.* TO NULL
      INITIALIZE g_imby_d TO NULL
      INITIALIZE g_imby2_d TO NULL
      INITIALIZE g_imby3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt300_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt300_set_act_visible()   
   CALL artt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
   
   CALL artt300_idx_chk()
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #功能已完成,通報訊息中心
   CALL artt300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imby_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imbz_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imbo_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   #單身資料不進行複製
   CALL s_transaction_end('Y','0')
   RETURN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imby_t
    WHERE imbyent = g_enterprise AND imbydocno = g_imbadocno_t
 
    INTO TEMP artt300_detail
 
   #將key修正為調整後   
   UPDATE artt300_detail 
      #更新key欄位
      SET imbydocno = g_imba_m.imbadocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, imbystus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imby_t SELECT * FROM artt300_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbz_t 
    WHERE imbzent = g_enterprise AND imbzdocno = g_imbadocno_t
 
    INTO TEMP artt300_detail
 
   #將key修正為調整後   
   UPDATE artt300_detail SET imbzdocno = g_imba_m.imbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imbz_t SELECT * FROM artt300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbo_t 
    WHERE imboent = g_enterprise AND imbodocno = g_imbadocno_t
 
    INTO TEMP artt300_detail
 
   #將key修正為調整後   
   UPDATE artt300_detail SET imbodocno = g_imba_m.imbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imbo_t SELECT * FROM artt300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt300_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.imbaldocno = g_imba_m.imbadocno
LET g_master_multi_table_t.imbal002 = g_imba_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imba_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imba_m.imbal004
 
   
   CALL s_transaction_begin()
 
   OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
   
   #檢查是否允許此動作
   IF NOT artt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL artt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   CALL artt300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   LET g_imba_m_o.* = g_imba_m_t.*
   #IF g_imba_m.imbastus != 'N' THEN               #151109-00006#11 151223 mark TT.Jessica
   IF g_imba_m.imbastus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許刪除  #151109-00006#11 151223 add TT.Jessica  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00031'
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
  
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imbadocno_t = g_imba_m.imbadocno
 
 
      DELETE FROM imba_t
       WHERE imbaent = g_enterprise AND imbadocno = g_imba_m.imbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
            
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imba_m.imbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
            
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      IF NOT s_aooi200_del_docno(g_imba_m.imbadocno,g_imba_m.imbadocdt) THEN  
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #150122-00013#1 150304 pomelo add (s)
      DELETE FROM imbf_t
       WHERE imbfent = g_enterprise
         AND imbfsite = 'ALL'
         AND imbfdocno = g_imba_m.imbadocno
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Del imbf_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF  
      #150122-00013#1 150304 pomelo add (e)
      
      DELETE FROM imbk_t
       WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imby_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
      #end add-point
      
      DELETE FROM imby_t
       WHERE imbyent = g_enterprise AND imbydocno = g_imba_m.imbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
            
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
            
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
            
      #end add-point
      DELETE FROM imbz_t
       WHERE imbzent = g_enterprise AND
             imbzdocno = g_imba_m.imbadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
            
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM imbo_t
       WHERE imboent = g_enterprise AND
             imbodocno = g_imba_m.imbadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
       CALL aimm200_01_clear_detail()   #lori522612  150126 add---嵌入產品特徵值
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imby_d.clear() 
      CALL g_imby2_d.clear()       
      CALL g_imby3_d.clear()       
 
     
      CALL artt300_ui_browser_refresh()  
      #CALL artt300_ui_headershow()  
      #CALL artt300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imbalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
   LET l_field_keys[02] = 'imbaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imbal_t')
 
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt300_browser_fill("")
         CALL artt300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt300_cl
 
   #功能已完成,通報訊息中心
   CALL artt300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5   #160801-00017#4 20160805 add by beckxie
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imby_d.clear()
   CALL g_imby2_d.clear()
   CALL g_imby3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
      
   #end add-point
   
   #判斷是否填充
   IF artt300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imby001,imbystus,imby002,imby019,imby003,imby004,imby005,imby006, 
             imby018,imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012,imby013, 
             imby014 ,t1.oocal003 ,t2.oocal003 ,t3.oocal003 ,t4.oocal003 FROM imby_t",   
                     " INNER JOIN imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbydocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=imby004 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=imby015 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imby016 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=imby017 AND t4.oocal002='"||g_dlang||"' ",
 
                     " WHERE imbyent=? AND imbydocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imby_t.imby003"
         
         #add-point:單身填充控制 name="b_fill.sql"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imba_m.imbadocno INTO g_imby_d[l_ac].imby001,g_imby_d[l_ac].imbystus, 
          g_imby_d[l_ac].imby002,g_imby_d[l_ac].imby019,g_imby_d[l_ac].imby003,g_imby_d[l_ac].imby004, 
          g_imby_d[l_ac].imby005,g_imby_d[l_ac].imby006,g_imby_d[l_ac].imby018,g_imby_d[l_ac].imby007, 
          g_imby_d[l_ac].imby008,g_imby_d[l_ac].imby009,g_imby_d[l_ac].imby015,g_imby_d[l_ac].imby010, 
          g_imby_d[l_ac].imby016,g_imby_d[l_ac].imby011,g_imby_d[l_ac].imby017,g_imby_d[l_ac].imby012, 
          g_imby_d[l_ac].imby013,g_imby_d[l_ac].imby014,g_imby_d[l_ac].imby004_desc,g_imby_d[l_ac].imby015_desc, 
          g_imby_d[l_ac].imby016_desc,g_imby_d[l_ac].imby017_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #160801-00017#4 20160805 add by beckxie---S
         CALL s_feature_description_t(g_imba_m.imbadocno,g_imby_d[l_ac].imby019) 
         RETURNING l_success,g_imby_d[l_ac].imby019_desc   
         #160801-00017#4 20160805 add by beckxie---E
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF artt300_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbz001,imbz002,imbz003,imbz006,imbz004,imbz005 ,t5.oocal003 FROM imbz_t", 
                
                     " INNER JOIN  imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbzdocno ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=imbz004 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE imbzent=? AND imbzdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbz_t.imbz002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt300_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR artt300_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_imba_m.imbadocno INTO g_imby2_d[l_ac].imbz001,g_imby2_d[l_ac].imbz002, 
          g_imby2_d[l_ac].imbz003,g_imby2_d[l_ac].imbz006,g_imby2_d[l_ac].imbz004,g_imby2_d[l_ac].imbz005, 
          g_imby2_d[l_ac].imbz004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
                  
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF artt300_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbo002 ,t6.oocal003 FROM imbo_t",   
                     " INNER JOIN  imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbodocno ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=imbo002 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE imboent=? AND imbodocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbo_t.imbo002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt300_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR artt300_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_imba_m.imbadocno INTO g_imby3_d[l_ac].imbo002,g_imby3_d[l_ac].imbo002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   #lori522612  150126 add -----------------------(S)
   #嵌入產品特徵值
   LET g_imaa001_d = g_imba_m.imba001
   CALL aimm200_01_b_fill(g_imaa001_d)
   #lori522612  150126 add -----------------------(E)   
   #end add-point
   
   CALL g_imby_d.deleteElement(g_imby_d.getLength())
   CALL g_imby2_d.deleteElement(g_imby2_d.getLength())
   CALL g_imby3_d.deleteElement(g_imby3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt300_pb
   FREE artt300_pb2
 
   FREE artt300_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imby_d.getLength()
      LET g_imby_d_mask_o[l_ac].* =  g_imby_d[l_ac].*
      CALL artt300_imby_t_mask()
      LET g_imby_d_mask_n[l_ac].* =  g_imby_d[l_ac].*
   END FOR
   
   LET g_imby2_d_mask_o.* =  g_imby2_d.*
   FOR l_ac = 1 TO g_imby2_d.getLength()
      LET g_imby2_d_mask_o[l_ac].* =  g_imby2_d[l_ac].*
      CALL artt300_imbz_t_mask()
      LET g_imby2_d_mask_n[l_ac].* =  g_imby2_d[l_ac].*
   END FOR
   LET g_imby3_d_mask_o.* =  g_imby3_d.*
   FOR l_ac = 1 TO g_imby3_d.getLength()
      LET g_imby3_d_mask_o[l_ac].* =  g_imby3_d[l_ac].*
      CALL artt300_imbo_t_mask()
      LET g_imby3_d_mask_n[l_ac].* =  g_imby3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt300_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
            
      #end add-point    
      DELETE FROM imby_t
       WHERE imbyent = g_enterprise AND
         imbydocno = ps_keys_bak[1] AND imby003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imby_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
            
      #end add-point    
      DELETE FROM imbz_t
       WHERE imbzent = g_enterprise AND
             imbzdocno = ps_keys_bak[1] AND imbz002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imby2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
            
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM imbo_t
       WHERE imboent = g_enterprise AND
             imbodocno = ps_keys_bak[1] AND imbo002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imby3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt300_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
            
      #end add-point 
      INSERT INTO imby_t
                  (imbyent,
                   imbydocno,
                   imby003
                   ,imby001,imbystus,imby002,imby019,imby004,imby005,imby006,imby018,imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012,imby013,imby014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imby_d[g_detail_idx].imby001,g_imby_d[g_detail_idx].imbystus,g_imby_d[g_detail_idx].imby002, 
                       g_imby_d[g_detail_idx].imby019,g_imby_d[g_detail_idx].imby004,g_imby_d[g_detail_idx].imby005, 
                       g_imby_d[g_detail_idx].imby006,g_imby_d[g_detail_idx].imby018,g_imby_d[g_detail_idx].imby007, 
                       g_imby_d[g_detail_idx].imby008,g_imby_d[g_detail_idx].imby009,g_imby_d[g_detail_idx].imby015, 
                       g_imby_d[g_detail_idx].imby010,g_imby_d[g_detail_idx].imby016,g_imby_d[g_detail_idx].imby011, 
                       g_imby_d[g_detail_idx].imby017,g_imby_d[g_detail_idx].imby012,g_imby_d[g_detail_idx].imby013, 
                       g_imby_d[g_detail_idx].imby014)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
            
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imby_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
            
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
            
      #end add-point 
      INSERT INTO imbz_t
                  (imbzent,
                   imbzdocno,
                   imbz002
                   ,imbz001,imbz003,imbz006,imbz004,imbz005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imby2_d[g_detail_idx].imbz001,g_imby2_d[g_detail_idx].imbz003,g_imby2_d[g_detail_idx].imbz006, 
                       g_imby2_d[g_detail_idx].imbz004,g_imby2_d[g_detail_idx].imbz005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imby2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
            
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO imbo_t
                  (imboent,
                   imbodocno,
                   imbo002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imby3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
      
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
      
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imby_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
            
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt300_imby_t_mask_restore('restore_mask_o')
               
      UPDATE imby_t 
         SET (imbydocno,
              imby003
              ,imby001,imbystus,imby002,imby019,imby004,imby005,imby006,imby018,imby007,imby008,imby009,imby015,imby010,imby016,imby011,imby017,imby012,imby013,imby014) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imby_d[g_detail_idx].imby001,g_imby_d[g_detail_idx].imbystus,g_imby_d[g_detail_idx].imby002, 
                  g_imby_d[g_detail_idx].imby019,g_imby_d[g_detail_idx].imby004,g_imby_d[g_detail_idx].imby005, 
                  g_imby_d[g_detail_idx].imby006,g_imby_d[g_detail_idx].imby018,g_imby_d[g_detail_idx].imby007, 
                  g_imby_d[g_detail_idx].imby008,g_imby_d[g_detail_idx].imby009,g_imby_d[g_detail_idx].imby015, 
                  g_imby_d[g_detail_idx].imby010,g_imby_d[g_detail_idx].imby016,g_imby_d[g_detail_idx].imby011, 
                  g_imby_d[g_detail_idx].imby017,g_imby_d[g_detail_idx].imby012,g_imby_d[g_detail_idx].imby013, 
                  g_imby_d[g_detail_idx].imby014) 
         WHERE imbyent = g_enterprise AND imbydocno = ps_keys_bak[1] AND imby003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
            
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imby_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imby_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt300_imby_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
            
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbz_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt300_imbz_t_mask_restore('restore_mask_o')
               
      UPDATE imbz_t 
         SET (imbzdocno,
              imbz002
              ,imbz001,imbz003,imbz006,imbz004,imbz005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imby2_d[g_detail_idx].imbz001,g_imby2_d[g_detail_idx].imbz003,g_imby2_d[g_detail_idx].imbz006, 
                  g_imby2_d[g_detail_idx].imbz004,g_imby2_d[g_detail_idx].imbz005) 
         WHERE imbzent = g_enterprise AND imbzdocno = ps_keys_bak[1] AND imbz002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt300_imbz_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt300_imbo_t_mask_restore('restore_mask_o')
               
      UPDATE imbo_t 
         SET (imbodocno,
              imbo002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imboent = g_enterprise AND imbodocno = ps_keys_bak[1] AND imbo002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt300_imbo_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt300_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt300_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt300_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
      
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL artt300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imby_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt300_bcl USING g_enterprise,
                                       g_imba_m.imbadocno,g_imby_d[g_detail_idx].imby003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "imbz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt300_bcl2 USING g_enterprise,
                                             g_imba_m.imbadocno,g_imby2_d[g_detail_idx].imbz002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt300_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "imbo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt300_bcl3 USING g_enterprise,
                                             g_imba_m.imbadocno,g_imby3_d[g_detail_idx].imbo002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt300_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
      
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt300_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt300_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt300_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt300_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
         
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("imbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imbadocno",TRUE)
      CALL cl_set_comp_entry("imbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                  CALL cl_set_comp_entry("imbadocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("imba111,imba112,imbaacti",TRUE)
   CALL cl_set_comp_entry("imba014",TRUE)
   CALL cl_set_comp_entry("imba100,imba109",TRUE)
   CALL cl_set_comp_entry("imba142",TRUE)
   IF g_imba_m.imba100 = '1' THEN
      CALL cl_set_comp_required("imba014",TRUE)
   END IF
   #150427-00010#1 Add-S By geza 150428
   CALL cl_set_comp_entry("imba003",TRUE)
   #150427-00010#1 Add-E
   #150614-00020#1 20150617 mark by beckxie
#   CALL cl_set_comp_entry("l_imbf062,l_imbf063,l_imbf064",TRUE) #150427-00001#2 Add By Ken 150513
   CALL cl_set_comp_entry("imbf062,imbf063,imbf064",TRUE)   #150614-00020#1 20150617 add by beckxie
   CALL cl_set_comp_entry("imba009",TRUE)  #add by geza 20150820

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   DEFINE l_cnt   LIKE type_t.num10  #add by geza 20150820
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
#      SELECT COUNT(*) INTO l_n      # Mark  geza 2015/04/12
#        FROM imby_t
#       WHERE imbyent = g_enterprise
#         AND imbydocno = g_imba_m.imbadocno
#         AND imby002 = '2'
#      IF l_n > 0 THEN      
#         CALL cl_set_comp_entry("imba109",FALSE)
#         IF g_imba_m.imba109 <> '1' THEN
#            CALL cl_set_comp_entry("imba100",FALSE)
#         END IF
#      END IF


      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("imbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("imbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
         IF g_imba_m.imba000 = 'I' THEN
      CALL cl_set_comp_entry("imbaacti",FALSE)
   END IF   
   IF g_imba_m.imba110 = 'N' THEN
      CALL cl_set_comp_entry("imba111,imba112",FALSE)
   END IF
   IF g_assign_no = 'Y' THEN
      CALL cl_set_comp_entry("imbadocno,imbadocdt",FALSE)
   END IF
   #160604-00009#91--dongsz mark--s
#   IF g_imba_m.imba100 = '1' THEN
##      CALL cl_set_comp_entry("imba109",FALSE)  # Mark  geza 2015/04/12
#      LET g_imba_m.imba109 = "1"
#   END IF
   #160604-00009#91--dongsz mark--e
   IF g_imba_m.imba100 = '2' THEN
      CALL cl_set_comp_entry("imba014",FALSE)
   END IF

   IF NOT s_aooi500_comp_entry(g_prog,'imbaunit') THEN
      CALL cl_set_comp_entry("imba142",FALSE)
   END IF
   #多条码单身有资料关闭条码类型，条码分类，商品条码栏位   add   geza 2015/04/15
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imby_t 
    WHERE imbyent = g_enterprise 
      AND imbydocno = g_imba_m.imbadocno
   IF  l_n > 0 THEN
      CALL cl_set_comp_entry("imba100",FALSE)
      CALL cl_set_comp_entry("imba109",FALSE) 
      CALL cl_set_comp_entry("imba014",FALSE)
   END IF 
   #150427-00010#1 Add-S By geza 150428
   IF p_cmd = 'u' OR g_imba_m.imba000 = 'U' THEN
      CALL cl_set_comp_entry("imba003",FALSE)
   END IF  
   #150427-00010#1 Add-E
   
   #150427-00001#2 Add-S By Ken 150513
#   IF g_imba_m.l_imbf061 = '2' THEN                                 #150614-00020#1 20150617 mark by beckxie
#      CALL cl_set_comp_entry("l_imbf062,l_imbf063,l_imbf064",FALSE) #150614-00020#1 20150617 mark by beckxie
   #150614-00020#1 20150617 add by beckxie---S
   IF g_imba_m.imbf061 = '2' THEN                                      
      CALL cl_set_comp_entry("imbf062,imbf063,imbf064",FALSE)        
   END IF
   
   IF g_imba_m.imbf062 = 'N' THEN
      CALL cl_set_comp_entry("imbf063",FALSE)
   END IF
   #150614-00020#1 20150617 add by beckxie---E
   #150427-00001#2 Add-E By Ken 150513
   #add by geza 20150820(S)
   #存在于门店清单的商品不可以修改商品品类
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt            
     FROM rtdx_t
    WHERE rtdxent=g_enterprise
      AND rtdx001=g_imba_m.imba001
   IF l_cnt > 0 THEN   
      CALL cl_set_comp_entry("imba009",FALSE)
   END IF
   #add by geza 20150820(S)   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt300_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
         CALL cl_set_comp_entry("imby003,imby005",TRUE)   
   CALL cl_set_comp_entry("imbz003,imbz004,imbz005",TRUE)
   CALL cl_set_comp_entry("imby002",TRUE)
   CALL cl_set_comp_entry("imby019",TRUE)   #160801-00017#1 20160810 add by beckxie
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt300_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_imby006    LIKE imby_t.imby006    
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
#150518-00035#1  mark geza (S)
#   IF p_cmd = 'u' THEN
#      IF g_imby_d[l_ac].imby002 = '2' AND NOT cl_null(g_imby_d[l_ac].imby003) THEN
#         CALL cl_set_comp_entry("imby005",FALSE)
#      END IF
#   END IF
#150518-00035#1  mark geza (E)
   IF g_imby_d[l_ac].imby002 = '2' THEN
      CALL cl_set_comp_entry("imby003",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("imby003",FALSE)
     #CALL cl_set_comp_entry("imbz002",FALSE)
   END IF
   IF g_imby_d[l_ac].imby004 = g_imba_m.imba104 THEN
      CALL cl_set_comp_entry("imby005",FALSE)
   END IF
   #20150720 mark by beckxie---S
#   IF NOT cl_null(g_imby2_d[l_ac].imbz003) THEN
#      CALL cl_set_comp_entry("imbz004,imbz005",FALSE)
#   END IF
   #20150720 mark by beckxie---E

   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imby_t
    WHERE imbyent = g_enterprise
      AND imbydocno = g_imba_m.imbadocno
      AND imby004 = g_imby2_d[l_ac].imbz004
      AND imbystus = 'Y'
   IF l_cnt != 0 THEN
      CALL cl_set_comp_entry("imbz005",FALSE)
   END IF
   #多条码单身维护的时候，判断如果是主条码,关闭单身条码分类栏位  add geza 2015/04/12
   LET l_cnt = 0
   SELECT imby006 INTO l_imby006 FROM imby_t
    WHERE imbyent = g_enterprise
      AND imbydocno = g_imba_m.imbadocno
      AND imby003 = g_imby_d[l_ac].imby003
   IF l_imby006 = 'Y' THEN
      CALL cl_set_comp_entry("imby002",FALSE)
   END IF
   
   #160801-00017#1 20160810 add by beckxie---S
   IF cl_null(g_imba_m.imba005) THEN
      CALL cl_set_comp_entry("imby019",FALSE)   
   END IF
   #160801-00017#1 20160810 add by beckxie---E
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_imba_m.imbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt300_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
      
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
      
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " imbadocno = '", g_argv[02], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "imba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imby_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imbz_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imbo_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="artt300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
         DEFINE l_success      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
         IF g_imba_m.imbastus = 'Y' OR g_imba_m.imbastus = 'X' THEN
      RETURN
   END IF 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF STATUS THEN
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
       g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
       g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
       g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
       g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
       g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
       g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
       g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
       g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
       g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
       g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
       g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
       g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
       g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
       g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
       g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
       g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc,g_imba_m.imba101_desc, 
       g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc, 
       g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc, 
       g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
   
 
   #檢查是否允許此動作
   IF NOT artt300_action_chk() THEN
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
       g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba108,g_imba_m.imba004, 
       g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba006_desc, 
       g_imba_m.imba105,g_imba_m.imba105_desc,g_imba_m.imba104,g_imba_m.imba104_desc,g_imba_m.imba107, 
       g_imba_m.imba107_desc,g_imba_m.imba106,g_imba_m.imba106_desc,g_imba_m.imba145,g_imba_m.imba145_desc, 
       g_imba_m.imba146,g_imba_m.imba146_desc,g_imba_m.imba113,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba142,g_imba_m.imba142_desc,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba026_desc, 
       g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid, 
       g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamodid_desc, 
       g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt,g_imba_m.imba009, 
       g_imba_m.imba009_desc,g_imba_m.imba161,g_imba_m.imba161_desc,g_imba_m.imba101,g_imba_m.imba101_desc, 
       g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba114_desc,g_imba_m.imba115, 
       g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba124_desc,g_imba_m.imbf122,g_imba_m.imbf115, 
       g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125, 
       g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba123,g_imba_m.imba131, 
       g_imba_m.imba131_desc,g_imba_m.imba126,g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba143, 
       g_imba_m.imba143_desc,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf063_desc,g_imba_m.imbf064,g_imba_m.imba149, 
       g_imba_m.imba102,g_imba_m.imba103,g_imba_m.imba147,g_imba_m.imba148
 
   CASE g_imba_m.imbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
 
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imba_m.imbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      
      CASE g_imba_m.imbastus
         WHEN "N"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"     
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"   
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"  
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"   
            CALL cl_set_act_visible("withdraw",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            
         #151109-00006#11 151223 add TT.Jessica   ---S---
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         #151109-00006#11 151223 add TT.Jessica   ---E---
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt300_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt300_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt300_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt300_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
                  
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
 
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
            
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "W"
      AND lc_state <> "A"
      AND lc_state <> "Y"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "X"
      ) OR 
      g_imba_m.imbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'        
         CALL s_artt300_conf_chk(g_argv[01],g_imba_m.imbadocno) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('art-00023') THEN
               CALL s_transaction_begin()
               CALL s_artt300_carry_upd(g_argv[01],g_imba_m.imbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_artt300_conf_upd(g_argv[01],g_imba_m.imbadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                     CALL cl_err_collect_show()
                  END IF
               END IF
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
               RETURN            
            END IF
         ELSE
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_artt300_void_chk(g_argv[01],g_imba_m.imbadocno) RETURNING l_success 
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_artt300_void_upd(g_argv[01],g_imba_m.imbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
               RETURN
            END IF
         ELSE
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN    
         END IF
   END CASE
   #end add-point
   
   LET g_imba_m.imbamodid = g_user
   LET g_imba_m.imbamoddt = cl_get_current()
   LET g_imba_m.imbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imba_t 
      SET (imbastus,imbamodid,imbamoddt) 
        = (g_imba_m.imbastus,g_imba_m.imbamodid,g_imba_m.imbamoddt)     
    WHERE imbaent = g_enterprise AND imbadocno = g_imba_m.imbadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE artt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imba000,g_imba_m.imbadocno, 
          g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imba003,g_imba_m.imba108,g_imba_m.imba004,g_imba_m.imba100, 
          g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006,g_imba_m.imba105,g_imba_m.imba104, 
          g_imba_m.imba107,g_imba_m.imba106,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba113,g_imba_m.imba005, 
          g_imba_m.imba142,g_imba_m.imbaacti,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022, 
          g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba010,g_imba_m.imbastus, 
          g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt, 
          g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba009, 
          g_imba_m.imba161,g_imba_m.imba101,g_imba_m.imba118,g_imba_m.imba119,g_imba_m.imba120,g_imba_m.imba114, 
          g_imba_m.imba115,g_imba_m.imba116,g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba110,g_imba_m.imba111, 
          g_imba_m.imba112,g_imba_m.imba125,g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba123, 
          g_imba_m.imba131,g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba143, 
          g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151,g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132, 
          g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138, 
          g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
          g_imba_m.imba147,g_imba_m.imba148,g_imba_m.imba003_desc,g_imba_m.imba006_desc,g_imba_m.imba105_desc, 
          g_imba_m.imba104_desc,g_imba_m.imba107_desc,g_imba_m.imba106_desc,g_imba_m.imba145_desc,g_imba_m.imba146_desc, 
          g_imba_m.imba005_desc,g_imba_m.imba142_desc,g_imba_m.imba022_desc,g_imba_m.imba026_desc,g_imba_m.imba018_desc, 
          g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc, 
          g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba009_desc,g_imba_m.imba161_desc, 
          g_imba_m.imba101_desc,g_imba_m.imba114_desc,g_imba_m.imba122_desc,g_imba_m.imba131_desc,g_imba_m.imba126_desc, 
          g_imba_m.imba127_desc,g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba143_desc,g_imba_m.imba132_desc, 
          g_imba_m.imba133_desc,g_imba_m.imba134_desc,g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc, 
          g_imba_m.imba138_desc,g_imba_m.imba139_desc,g_imba_m.imba140_desc,g_imba_m.imba141_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imba_m.imba000,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba001,g_imba_m.imbal002, 
          g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba108, 
          g_imba_m.imba004,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba014,g_imba_m.imba002,g_imba_m.imba006, 
          g_imba_m.imba006_desc,g_imba_m.imba105,g_imba_m.imba105_desc,g_imba_m.imba104,g_imba_m.imba104_desc, 
          g_imba_m.imba107,g_imba_m.imba107_desc,g_imba_m.imba106,g_imba_m.imba106_desc,g_imba_m.imba145, 
          g_imba_m.imba145_desc,g_imba_m.imba146,g_imba_m.imba146_desc,g_imba_m.imba113,g_imba_m.imba005, 
          g_imba_m.imba005_desc,g_imba_m.imba142,g_imba_m.imba142_desc,g_imba_m.imbaacti,g_imba_m.imba019, 
          g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba025, 
          g_imba_m.imba026,g_imba_m.imba026_desc,g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba018_desc, 
          g_imba_m.imba010,g_imba_m.imbastus,g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp, 
          g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid,g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc, 
          g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid, 
          g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt,g_imba_m.imba009,g_imba_m.imba009_desc,g_imba_m.imba161, 
          g_imba_m.imba161_desc,g_imba_m.imba101,g_imba_m.imba101_desc,g_imba_m.imba118,g_imba_m.imba119, 
          g_imba_m.imba120,g_imba_m.imba114,g_imba_m.imba114_desc,g_imba_m.imba115,g_imba_m.imba116, 
          g_imba_m.imba117,g_imba_m.imba124,g_imba_m.imba124_desc,g_imba_m.imbf122,g_imba_m.imbf115, 
          g_imba_m.imbf114,g_imba_m.imbf116,g_imba_m.imba110,g_imba_m.imba111,g_imba_m.imba112,g_imba_m.imba125, 
          g_imba_m.imba121,g_imba_m.imba144,g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba123, 
          g_imba_m.imba131,g_imba_m.imba131_desc,g_imba_m.imba126,g_imba_m.imba126_desc,g_imba_m.imba127, 
          g_imba_m.imba127_desc,g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc, 
          g_imba_m.imba143,g_imba_m.imba143_desc,g_imba_m.imba130,g_imba_m.imba150,g_imba_m.imba151, 
          g_imba_m.imba152,g_imba_m.imba153,g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133, 
          g_imba_m.imba133_desc,g_imba_m.imba134,g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc, 
          g_imba_m.imba136,g_imba_m.imba136_desc,g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138, 
          g_imba_m.imba138_desc,g_imba_m.imba139,g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc, 
          g_imba_m.imba141,g_imba_m.imba141_desc,g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063, 
          g_imba_m.imbf063_desc,g_imba_m.imbf064,g_imba_m.imba149,g_imba_m.imba102,g_imba_m.imba103, 
          g_imba_m.imba147,g_imba_m.imba148
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL artt300_fetch('')
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE artt300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imby_d.getLength() THEN
         LET g_detail_idx = g_imby_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imby_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imby_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imby2_d.getLength() THEN
         LET g_detail_idx = g_imby2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imby2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imby2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_imby3_d.getLength() THEN
         LET g_detail_idx = g_imby3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imby3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imby3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #150915-00006#1 20150915 add by beckxie---S
   CASE g_touch
     WHEN 1
        CALL gfrm_curr.ensureFieldVisible("imba_t.imba009")
     WHEN 2
        CALL gfrm_curr.ensureFieldVisible("imby_t.imby001")
     WHEN 3
        CALL gfrm_curr.ensureFieldVisible("imbz_t.imbz001")
     WHEN 4
        CALL gfrm_curr.ensureFieldVisible("imba_t.imba122")
     WHEN 5
        CALL gfrm_curr.ensureFieldVisible("imbo_t.imbo002")
     WHEN 6
        CALL gfrm_curr.ensureElementVisible("page_6") 
     WHEN 7
        CALL gfrm_curr.ensureFieldVisible("imbf_t.imbf061")
   END CASE
   #150915-00006#1 20150915 add by beckxie---E
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt300_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
      
   #end add-point
    
   LET l_ac = li_ac
   
   CALL artt300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt300_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
      
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
            
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artt300.status_show" >}
PRIVATE FUNCTION artt300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt300.mask_functions" >}
&include "erp/art/artt300_mask.4gl"
 
{</section>}
 
{<section id="artt300.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt300_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL artt300_show()
   CALL artt300_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   LET l_success = TRUE
   #確認前檢核段
   CALL s_artt300_conf_chk(g_argv[01],g_imba_m.imbadocno) RETURNING l_success
   IF NOT l_success THEN
      CLOSE artt300_cl
      CALL s_transaction_end('N','0')
#      RETURN        #160728-00034#1  by 08172
      RETURN FALSE   #160728-00034#1  by 08172
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_imba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_imby_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_imby2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_imby3_d))
 
 
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
   #CALL artt300_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt300_ui_headershow()
   CALL artt300_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt300_draw_out()
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
   CALL artt300_ui_headershow()  
   CALL artt300_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt300_set_pk_array()
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
   LET g_pk_array[1].values = g_imba_m.imbadocno
   LET g_pk_array[1].column = 'imbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt300_msgcentre_notify(lc_state)
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
   CALL artt300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt300.other_function" readonly="Y" >}
#+
PUBLIC FUNCTION artt300_chk_acc_code(p_acc_type,p_acc_code)
DEFINE p_acc_type  LIKE oocq_t.oocq001
DEFINE p_acc_code  LIKE oocq_t.oocq002
DEFINE l_stus     LIKE type_t.chr1

   LET g_errno = '' LET l_stus = ''

   SELECT oocqstus INTO l_stus FROM oocq_t
    WHERE oocq001 = p_acc_type
      AND oocq002 = p_acc_code
      AND oocqent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00081'
        WHEN l_stus='N'            LET g_errno = 'aoo-00082'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#當申請類型為'I'時,輸入主分群碼,即自動帶出 商品主分群碼檔 imck_t的相關資料
PUBLIC FUNCTION artt300_carry_imck()
DEFINE l_imck  RECORD
          imck108 LIKE imck_t.imck108,
          imck004 LIKE imck_t.imck004, #150424-00004#1 Add By Ken 150506   
          imck100 LIKE imck_t.imck100,
          imck109 LIKE imck_t.imck109,
          imck105 LIKE imck_t.imck105,
          imck104 LIKE imck_t.imck104,
          imck107 LIKE imck_t.imck107,
          imck106 LIKE imck_t.imck106,
          imck113 LIKE imck_t.imck113,
          imck009 LIKE imck_t.imck009,
          imck101 LIKE imck_t.imck101,
          imck102 LIKE imck_t.imck102,
          imck103 LIKE imck_t.imck103,
          imck118 LIKE imck_t.imck118,
          imck119 LIKE imck_t.imck119,
          imck120 LIKE imck_t.imck120,
          imck114 LIKE imck_t.imck114,
          imck124 LIKE imck_t.imck124,
          imck125 LIKE imck_t.imck125,
          imck121 LIKE imck_t.imck121,
          imck110 LIKE imck_t.imck110,
          imck111 LIKE imck_t.imck111,
          imck112 LIKE imck_t.imck112,
          imck122 LIKE imck_t.imck122,
          imck123 LIKE imck_t.imck123,
          imck131 LIKE imck_t.imck131,
          imck126 LIKE imck_t.imck126,
          imck127 LIKE imck_t.imck127,
          imck128 LIKE imck_t.imck128,
          imck129 LIKE imck_t.imck129,
          imck130 LIKE imck_t.imck130,
          imck132 LIKE imck_t.imck132,
          imck133 LIKE imck_t.imck133,
          imck134 LIKE imck_t.imck134,
          imck135 LIKE imck_t.imck135,
          imck136 LIKE imck_t.imck136,
          imck137 LIKE imck_t.imck137,
          imck138 LIKE imck_t.imck138,
          imck139 LIKE imck_t.imck139,
          imck140 LIKE imck_t.imck140,
          imck141 LIKE imck_t.imck141,
          imck006 LIKE imck_t.imck006,
          imck143 LIKE imck_t.imck143,
          imck144 LIKE imck_t.imck144,
          imck145 LIKE imck_t.imck145,
          imck146 LIKE imck_t.imck146       
               END RECORD 

   SELECT imck108, imck004, imck100, imck109, imck105, #150424-00004#1 Add By Ken 150506
          imck104, imck107, imck106, imck113, imck009,
          imck101, imck102, imck103, imck118, imck119,
          imck120, imck114, imck124, imck125, imck121,
          imck110, imck111, imck112, imck122, imck123,
          imck131, imck126, imck127, imck128, imck129,
          imck130, imck132, imck133, imck134, imck135,
          imck136, imck137, imck138, imck139, imck140,
          imck141, imck006, imck143, imck144, imck145,
          imck146
     INTO l_imck.*
     FROM imck_t
    WHERE imck001 = g_imba_m.imba003
      AND imckent = g_enterprise
      
   IF cl_null(l_imck.imck144) THEN
      LET l_imck.imck144 = 'N'
   END IF
   #dongsz--add--str---
#   IF g_imba_m.imba100 = '1' THEN
#      LET l_imck.imck100 = g_imba_m.imba100
#      LET l_imck.imck109 = g_imba_m.imba109
#   END IF
#   IF l_imck.imck100 = '1' THEN
#      LET l_imck.imck109 = '1'
#   END IFS
   #dongsz--add--end---

   LET g_imba_m.imba108 = l_imck.imck108
   LET g_imba_m.imba004 = l_imck.imck004 #150424-00004#1 Add By Ken 150506
   LET g_imba_m.imba100 = l_imck.imck100
   LET g_imba_m.imba109 = l_imck.imck109
   LET g_imba_m.imba105 = l_imck.imck105
   LET g_imba_m.imba104 = l_imck.imck104
   LET g_imba_m.imba107 = l_imck.imck107
   LET g_imba_m.imba106 = l_imck.imck106
   LET g_imba_m.imba113 = l_imck.imck113
   LET g_imba_m.imba009 = l_imck.imck009
   LET g_imba_m.imba101 = l_imck.imck101
   LET g_imba_m.imba102 = l_imck.imck102
   LET g_imba_m.imba103 = l_imck.imck103
   LET g_imba_m.imba118 = l_imck.imck118
   LET g_imba_m.imba119 = l_imck.imck119
   LET g_imba_m.imba120 = l_imck.imck120
   LET g_imba_m.imba114 = l_imck.imck114
   LET g_imba_m.imba124 = l_imck.imck124
   LET g_imba_m.imba125 = l_imck.imck125
   LET g_imba_m.imba121 = l_imck.imck121
   LET g_imba_m.imba110 = l_imck.imck110
   LET g_imba_m.imba111 = l_imck.imck111
   LET g_imba_m.imba112 = l_imck.imck112
   LET g_imba_m.imba122 = l_imck.imck122
   LET g_imba_m.imba123 = l_imck.imck123
   LET g_imba_m.imba131 = l_imck.imck131
   LET g_imba_m.imba126 = l_imck.imck126
   LET g_imba_m.imba127 = l_imck.imck127
   LET g_imba_m.imba128 = l_imck.imck128
   LET g_imba_m.imba129 = l_imck.imck129
   LET g_imba_m.imba130 = l_imck.imck130
   LET g_imba_m.imba132 = l_imck.imck132
   LET g_imba_m.imba133 = l_imck.imck133
   LET g_imba_m.imba134 = l_imck.imck134
   LET g_imba_m.imba135 = l_imck.imck135
   LET g_imba_m.imba136 = l_imck.imck136
   LET g_imba_m.imba137 = l_imck.imck137
   LET g_imba_m.imba138 = l_imck.imck138
   LET g_imba_m.imba139 = l_imck.imck139
   LET g_imba_m.imba140 = l_imck.imck140
   LET g_imba_m.imba141 = l_imck.imck141
   LET g_imba_m.imba006 = l_imck.imck006
   LET g_imba_m.imba143 = l_imck.imck143
   LET g_imba_m.imba144 = l_imck.imck144
   LET g_imba_m.imba145 = l_imck.imck145
   LET g_imba_m.imba146 = l_imck.imck146
   
   #當產品組資料 有異常的情況時，將產品組資料清空
   CALL artt300_chk_imba143('2') 
   IF NOT cl_null(g_errno) THEN
      LET g_imba_m.imba143 = ''
      LET l_imck.imck143 = ''
   END IF
   
   LET g_imba_m_t.imba108 = l_imck.imck108
   LET g_imba_m_t.imba004 = l_imck.imck004 #150424-00004#1 Add By Ken 150506   
   LET g_imba_m_t.imba100 = l_imck.imck100
   LET g_imba_m_t.imba109 = l_imck.imck109
   LET g_imba_m_t.imba105 = l_imck.imck105
   LET g_imba_m_t.imba104 = l_imck.imck104
   LET g_imba_m_t.imba107 = l_imck.imck107
   LET g_imba_m_t.imba106 = l_imck.imck106
   LET g_imba_m_t.imba113 = l_imck.imck113
   LET g_imba_m_t.imba009 = l_imck.imck009
   LET g_imba_m_t.imba101 = l_imck.imck101
   LET g_imba_m_t.imba102 = l_imck.imck102
   LET g_imba_m_t.imba103 = l_imck.imck103
   LET g_imba_m_t.imba118 = l_imck.imck118
   LET g_imba_m_t.imba119 = l_imck.imck119
   LET g_imba_m_t.imba120 = l_imck.imck120
   LET g_imba_m_t.imba114 = l_imck.imck114
   LET g_imba_m_t.imba124 = l_imck.imck124
   LET g_imba_m_t.imba125 = l_imck.imck125
   LET g_imba_m_t.imba121 = l_imck.imck121
   LET g_imba_m_t.imba110 = l_imck.imck110
   LET g_imba_m_t.imba111 = l_imck.imck111
   LET g_imba_m_t.imba112 = l_imck.imck112
   LET g_imba_m_t.imba122 = l_imck.imck122
   LET g_imba_m_t.imba123 = l_imck.imck123
   LET g_imba_m_t.imba131 = l_imck.imck131
   LET g_imba_m_t.imba126 = l_imck.imck126
   LET g_imba_m_t.imba127 = l_imck.imck127
   LET g_imba_m_t.imba128 = l_imck.imck128
   LET g_imba_m_t.imba129 = l_imck.imck129
   LET g_imba_m_t.imba130 = l_imck.imck130
   LET g_imba_m_t.imba132 = l_imck.imck132
   LET g_imba_m_t.imba133 = l_imck.imck133
   LET g_imba_m_t.imba134 = l_imck.imck134
   LET g_imba_m_t.imba135 = l_imck.imck135
   LET g_imba_m_t.imba136 = l_imck.imck136
   LET g_imba_m_t.imba137 = l_imck.imck137
   LET g_imba_m_t.imba138 = l_imck.imck138
   LET g_imba_m_t.imba139 = l_imck.imck139
   LET g_imba_m_t.imba140 = l_imck.imck140
   LET g_imba_m_t.imba141 = l_imck.imck141
   LET g_imba_m_t.imba006 = l_imck.imck006
   LET g_imba_m_t.imba143 = l_imck.imck143
   LET g_imba_m_t.imba144 = l_imck.imck144
   LET g_imba_m_t.imba145 = l_imck.imck145
   LET g_imba_m_t.imba146 = l_imck.imck146
   
   DISPLAY BY NAME g_imba_m.imba108, g_imba_m.imba004, g_imba_m.imba100, g_imba_m.imba109, g_imba_m.imba105,  #150424-00004#1 Add By Ken 150506 加imba004
                   g_imba_m.imba104, g_imba_m.imba107, g_imba_m.imba106, g_imba_m.imba113,
                   g_imba_m.imba142, g_imba_m.imba009, g_imba_m.imba101, g_imba_m.imba102,
                   g_imba_m.imba103, g_imba_m.imba118, g_imba_m.imba119, g_imba_m.imba120,
                   g_imba_m.imba114, g_imba_m.imba124, g_imba_m.imba125, g_imba_m.imba121,
                   g_imba_m.imba110, g_imba_m.imba111, g_imba_m.imba112, g_imba_m.imba122,
                   g_imba_m.imba123, g_imba_m.imba131, g_imba_m.imba126, g_imba_m.imba127,
                   g_imba_m.imba128, g_imba_m.imba129, g_imba_m.imba130, g_imba_m.imba132,
                   g_imba_m.imba133, g_imba_m.imba134, g_imba_m.imba135, g_imba_m.imba136,
                   g_imba_m.imba137, g_imba_m.imba138, g_imba_m.imba139, g_imba_m.imba140,
                   g_imba_m.imba141, g_imba_m.imba006, g_imba_m.imba143, g_imba_m.imba144,
                   g_imba_m.imba145, g_imba_m.imba146
                   
   CALL artt300_imba105_ref()
   CALL artt300_imba104_ref()
   CALL artt300_imba107_ref()
   CALL artt300_imba106_ref()   
   CALL artt300_imba142_ref()   
   CALL artt300_imba009_ref()
   CALL artt300_imba101_ref()
   CALL artt300_imba114_ref()
   CALL artt300_imba124_ref()
   CALL artt300_imba122_ref()
   CALL artt300_imba131_ref()
   CALL artt300_imba126_ref()
   CALL artt300_imba127_ref()
   CALL artt300_imba128_ref()
   CALL artt300_imba129_ref()
   CALL artt300_imba132_ref()
   CALL artt300_imba133_ref()
   CALL artt300_imba134_ref()
   CALL artt300_imba135_ref()
   CALL artt300_imba136_ref()
   CALL artt300_imba137_ref()
   CALL artt300_imba138_ref()
   CALL artt300_imba139_ref()
   CALL artt300_imba140_ref()
   CALL artt300_imba141_ref()
   CALL artt300_imba006_ref()   
   CALL artt300_imba143_ref()
   CALL artt300_imba145_ref()
   CALL artt300_imba146_ref()
END FUNCTION
#+檢查商品編號輸入的正確性
PUBLIC FUNCTION artt300_chk_imba001()
DEFINE l_cnt    LIKE type_t.num5

   LET g_errno = ''
   CASE g_imba_m.imba000
      WHEN 'I'
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_imba_m.imba001
         IF l_cnt > 0 THEN 
            LET g_errno = 'art-00010'
         END IF
         
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imba_t
          WHERE imbaent = g_enterprise
            AND imba001 = g_imba_m.imba001
         IF l_cnt > 0 THEN 
            LET g_errno = 'art-00015'
         END IF
         
      WHEN 'U'
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_imba_m.imba001            
         IF l_cnt = 0 THEN 
            LET g_errno = 'art-00016'
         END IF
         
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imba_t
          WHERE imbaent = g_enterprise
            AND imbadocno != g_imba_m.imbadocno
            AND imba001 = g_imba_m.imba001
            AND imbastus = 'N'
         IF l_cnt > 0 THEN 
            LET g_errno = 'art-00017'
         END IF
         
      OTHERWISE              
         LET g_errno = 'art-00013'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imba009()
DEFINE l_stus        LIKE type_t.chr1
DEFINE l_rtax005     LIKE rtax_t.rtax005

   LET g_errno = '' LET l_stus = ''

   SELECT rtaxstus,rtax005 INTO l_stus,l_rtax005 FROM rtax_t
    WHERE rtax001 = g_imba_m.imba009
      AND rtaxent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00002'
        WHEN l_stus='N'            LET g_errno = 'art-00048'
        WHEN l_rtax005 != 0        LET g_errno = 'art-00003'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#檢查主分群碼輸入的正確性
PUBLIC FUNCTION artt300_chk_imba003()
DEFINE l_stus     LIKE type_t.chr10

   LET g_errno = ''
   LET l_stus = ''
   SELECT imckstus INTO l_stus FROM imck_t
    WHERE imck001 = g_imba_m.imba003 AND imckent = g_enterprise #160905-00007#14 add  imckent = g_enterprise
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00019'
#        WHEN l_stus='N'            LET g_errno = 'art-00018'      #160318-00005#43  mark
        WHEN l_stus='N'            LET g_errno = 'sub-01302'      #160318-00005#43  add
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE 
END FUNCTION
#當申請類型為'U'時,輸入商品編號,即自動帶出 商品/料件主檔 imaa_t的相關資料
PUBLIC FUNCTION artt300_carry_imaa()
DEFINE l_imaa  RECORD
          imaa001  LIKE imaa_t.imaa001, 
          imaa003  LIKE imaa_t.imaa003,
          imaa004  LIKE imaa_t.imaa004,         #160725-00016#1     by 08172
          imaa108  LIKE imaa_t.imaa108, 
          imaa100  LIKE imaa_t.imaa100, 
          imaa014  LIKE imaa_t.imaa014, 
          imaa005  LIKE imaa_t.imaa005,
          imaa002  LIKE imaa_t.imaa002, 
          imaa105  LIKE imaa_t.imaa105, 
          imaa104  LIKE imaa_t.imaa104, 
          imaa107  LIKE imaa_t.imaa107, 
          imaa106  LIKE imaa_t.imaa106, 
          imaa113  LIKE imaa_t.imaa113, 
          imaa109  LIKE imaa_t.imaa109, 
          imaa142  LIKE imaa_t.imaa142, 
          imaa009  LIKE imaa_t.imaa009, 
          imaa101  LIKE imaa_t.imaa101, 
          imaa102  LIKE imaa_t.imaa102, 
          imaa103  LIKE imaa_t.imaa103, 
          imaa118  LIKE imaa_t.imaa118, 
          imaa119  LIKE imaa_t.imaa119, 
          imaa120  LIKE imaa_t.imaa120, 
          imaa114  LIKE imaa_t.imaa114, 
          imaa115  LIKE imaa_t.imaa115, 
          imaa116  LIKE imaa_t.imaa116, 
          imaa117  LIKE imaa_t.imaa117, 
          imaa124  LIKE imaa_t.imaa124, 
          imaa110  LIKE imaa_t.imaa110, 
          imaa111  LIKE imaa_t.imaa111, 
          imaa112  LIKE imaa_t.imaa112, 
          imaa125  LIKE imaa_t.imaa125, 
          imaa121  LIKE imaa_t.imaa121, 
          imaa122  LIKE imaa_t.imaa122, 
          imaa123  LIKE imaa_t.imaa123, 
          imaa131  LIKE imaa_t.imaa131, 
          imaa126  LIKE imaa_t.imaa126, 
          imaa127  LIKE imaa_t.imaa127, 
          imaa128  LIKE imaa_t.imaa128, 
          imaa129  LIKE imaa_t.imaa129, 
          imaa130  LIKE imaa_t.imaa130, 
          imaa132  LIKE imaa_t.imaa132, 
          imaa133  LIKE imaa_t.imaa133, 
          imaa134  LIKE imaa_t.imaa134, 
          imaa135  LIKE imaa_t.imaa135, 
          imaa136  LIKE imaa_t.imaa136, 
          imaa137  LIKE imaa_t.imaa137, 
          imaa138  LIKE imaa_t.imaa138, 
          imaa139  LIKE imaa_t.imaa139, 
          imaa140  LIKE imaa_t.imaa140, 
          imaa141  LIKE imaa_t.imaa141,
          imaa006  LIKE imaa_t.imaa006,
          imaa143  LIKE imaa_t.imaa143,
          imaa144  LIKE imaa_t.imaa144,
          imaa145  LIKE imaa_t.imaa145,
          imaa146  LIKE imaa_t.imaa146,
          imaa019  LIKE imaa_t.imaa019,
          imaa020  LIKE imaa_t.imaa020,
          imaa021  LIKE imaa_t.imaa021,
          imaa022  LIKE imaa_t.imaa022,
          imaa025  LIKE imaa_t.imaa025,
          imaa026  LIKE imaa_t.imaa026,
          imaa016  LIKE imaa_t.imaa016,
          imaa018  LIKE imaa_t.imaa018,
          imaastus LIKE imaa_t.imaastus,
          imaa010  LIKE imaa_t.imaa010,
          imaa147  LIKE imaa_t.imaa147,   #150507-00001#2 Add By Ken 1505021
          imaa148  LIKE imaa_t.imaa148,   #150507-00001#2 Add By Ken 1505021
          imaa149  LIKE imaa_t.imaa149,   #150507-00001#2 Add By Ken 1505021 
          imaa161  LIKE imaa_t.imaa161    #160705-00013#3 160712 by lori add            
               END RECORD
DEFINE l_imbal RECORD
          imbal002  LIKE imbal_t.imbal002,
          imbal003  LIKE imbal_t.imbal003,
          imbal004  LIKE imbal_t.imbal004
               END RECORD
DEFINE l_sql        STRING
   
   INITIALIZE l_imaa.* TO NULL
   
#   SELECT imaa001, imaa003, imaa108, imaa100, imaa014, imaa005,        #160725-00016#1     by 08172
   SELECT imaa001, imaa003, imaa004,imaa108, imaa100, imaa014, imaa005,  #160725-00016#1     by 08172
          imaa002, imaa105, imaa104, imaa107, imaa106, imaa113,
          imaa109, imaa142, imaa009, imaa101, imaa102, imaa103,
          imaa118, imaa119, imaa120, imaa114, imaa115, imaa116,
          imaa117, imaa124, imaa110, imaa111, imaa112, imaa125,
          imaa121, imaa122, imaa123, imaa131, imaa126, imaa127,
          imaa128, imaa129, imaa130, imaa132, imaa133, imaa134,
          imaa135, imaa136, imaa137, imaa138, imaa139, imaa140,
          imaa141, imaa006, imaa143, imaa144, imaa145, imaa146,
          imaa019, imaa020, imaa021, imaa022, imaa025, imaa026, 
          imaa016, imaa018, imaastus,imaa010, imaa147, imaa148,       #150507-00001#2 Add By Ken 1505021 加imaa147,imaa148
          imaa149, imaa161                                            #150507-00001#2 Add By Ken 1505021 加imaa149    #160705-00013#3 160712 by lori add imaa161         
#     INTO l_imaa.imaa001, l_imaa.imaa003, l_imaa.imaa108, l_imaa.imaa100, l_imaa.imaa014, l_imaa.imaa005,       #160725-00016#1     by 08172
     INTO l_imaa.imaa001, l_imaa.imaa003, l_imaa.imaa004,l_imaa.imaa108, l_imaa.imaa100, l_imaa.imaa014, l_imaa.imaa005,    #160725-00016#1     by 08172
          l_imaa.imaa002, l_imaa.imaa105, l_imaa.imaa104, l_imaa.imaa107, l_imaa.imaa106, l_imaa.imaa113,
          l_imaa.imaa109, l_imaa.imaa142, l_imaa.imaa009, l_imaa.imaa101, l_imaa.imaa102, l_imaa.imaa103,
          l_imaa.imaa118, l_imaa.imaa119, l_imaa.imaa120, l_imaa.imaa114, l_imaa.imaa115, l_imaa.imaa116,
          l_imaa.imaa117, l_imaa.imaa124, l_imaa.imaa110, l_imaa.imaa111, l_imaa.imaa112, l_imaa.imaa125,
          l_imaa.imaa121, l_imaa.imaa122, l_imaa.imaa123, l_imaa.imaa131, l_imaa.imaa126, l_imaa.imaa127,
          l_imaa.imaa128, l_imaa.imaa129, l_imaa.imaa130, l_imaa.imaa132, l_imaa.imaa133, l_imaa.imaa134,
          l_imaa.imaa135, l_imaa.imaa136, l_imaa.imaa137, l_imaa.imaa138, l_imaa.imaa139, l_imaa.imaa140,
          l_imaa.imaa141, l_imaa.imaa006, l_imaa.imaa143, l_imaa.imaa144, l_imaa.imaa145, l_imaa.imaa146,
          l_imaa.imaa019, l_imaa.imaa020, l_imaa.imaa021, l_imaa.imaa022, l_imaa.imaa025, l_imaa.imaa026, 
          l_imaa.imaa016, l_imaa.imaa018, l_imaa.imaastus,l_imaa.imaa010, l_imaa.imaa147, l_imaa.imaa148,       #150507-00001#2 Add By Ken 1505021 加imaa147,imaa148
          l_imaa.imaa149, l_imaa.imaa161                                                                        #150507-00001#2 Add By Ken 1505021 加imaa149    #160705-00013#3 160712 by lori add imaa161         
     FROM imaa_t
    WHERE imaa001 = g_imba_m.imba001
      AND imaaent = g_enterprise
   IF cl_null(l_imaa.imaa002) THEN
      LET l_imaa.imaa002 = 0
   END IF

   LET g_imba_m.imba003 = l_imaa.imaa003
   LET g_imba_m.imba004 = l_imaa.imaa004      #160725-00016#1     by 08172
   LET g_imba_m.imba108 = l_imaa.imaa108
   LET g_imba_m.imba100 = l_imaa.imaa100
   LET g_imba_m.imba014 = l_imaa.imaa014
   LET g_imba_m.imba005 = l_imaa.imaa005
   LET g_imba_m.imba002 = l_imaa.imaa002 + 1 USING "<<<<<<<<<#"
   LET g_imba_m.imba105 = l_imaa.imaa105
   LET g_imba_m.imba104 = l_imaa.imaa104
   LET g_imba_m.imba107 = l_imaa.imaa107
   LET g_imba_m.imba106 = l_imaa.imaa106
   LET g_imba_m.imba113 = l_imaa.imaa113
   LET g_imba_m.imba109 = l_imaa.imaa109
   LET g_imba_m.imba142 = l_imaa.imaa142
   LET g_imba_m.imba009 = l_imaa.imaa009
   LET g_imba_m.imba161 = l_imaa.imaa161   #160705-00013#3 160712 by lori add
   LET g_imba_m.imba101 = l_imaa.imaa101
   LET g_imba_m.imba102 = l_imaa.imaa102
   LET g_imba_m.imba103 = l_imaa.imaa103
   LET g_imba_m.imba118 = l_imaa.imaa118
   LET g_imba_m.imba119 = l_imaa.imaa119
   LET g_imba_m.imba120 = l_imaa.imaa120
   LET g_imba_m.imba114 = l_imaa.imaa114
   LET g_imba_m.imba115 = l_imaa.imaa115
   LET g_imba_m.imba116 = l_imaa.imaa116
   LET g_imba_m.imba117 = l_imaa.imaa117
   LET g_imba_m.imba124 = l_imaa.imaa124
   LET g_imba_m.imba110 = l_imaa.imaa110
   LET g_imba_m.imba111 = l_imaa.imaa111
   LET g_imba_m.imba112 = l_imaa.imaa112
   LET g_imba_m.imba125 = l_imaa.imaa125
   LET g_imba_m.imba121 = l_imaa.imaa121
   LET g_imba_m.imba122 = l_imaa.imaa122
   LET g_imba_m.imba123 = l_imaa.imaa123
   LET g_imba_m.imba131 = l_imaa.imaa131
   LET g_imba_m.imba126 = l_imaa.imaa126
   LET g_imba_m.imba127 = l_imaa.imaa127
   LET g_imba_m.imba128 = l_imaa.imaa128
   LET g_imba_m.imba129 = l_imaa.imaa129
   LET g_imba_m.imba130 = l_imaa.imaa130
   LET g_imba_m.imba132 = l_imaa.imaa132
   LET g_imba_m.imba133 = l_imaa.imaa133
   LET g_imba_m.imba134 = l_imaa.imaa134
   LET g_imba_m.imba135 = l_imaa.imaa135
   LET g_imba_m.imba136 = l_imaa.imaa136
   LET g_imba_m.imba137 = l_imaa.imaa137
   LET g_imba_m.imba138 = l_imaa.imaa138
   LET g_imba_m.imba139 = l_imaa.imaa139
   LET g_imba_m.imba140 = l_imaa.imaa140
   LET g_imba_m.imba141 = l_imaa.imaa141
   LET g_imba_m.imba006 = l_imaa.imaa006
   LET g_imba_m.imba143 = l_imaa.imaa143
   LET g_imba_m.imba144 = l_imaa.imaa144
   LET g_imba_m.imba145 = l_imaa.imaa145
   LET g_imba_m.imba146 = l_imaa.imaa146
   LET g_imba_m.imba019 = l_imaa.imaa019
   LET g_imba_m.imba020 = l_imaa.imaa020
   LET g_imba_m.imba021 = l_imaa.imaa021
   LET g_imba_m.imba022 = l_imaa.imaa022
   LET g_imba_m.imba025 = l_imaa.imaa025
   LET g_imba_m.imba026 = l_imaa.imaa026
   LET g_imba_m.imba016 = l_imaa.imaa016
   LET g_imba_m.imba018 = l_imaa.imaa018
   LET g_imba_m.imba010 = l_imaa.imaa010
   LET g_imba_m.imba147 = l_imaa.imaa147 #150507-00001#2 Add By Ken 1505021
   LET g_imba_m.imba148 = l_imaa.imaa148 #150507-00001#2 Add By Ken 1505021
   LET g_imba_m.imba149 = l_imaa.imaa149 #150507-00001#2 Add By Ken 1505021
   
   LET g_imba_m_t.imba003 = l_imaa.imaa003
   LET g_imba_m_t.imba004 = l_imaa.imaa004      #160725-00016#1     by 08172
   LET g_imba_m_t.imba108 = l_imaa.imaa108
   LET g_imba_m_t.imba100 = l_imaa.imaa100
   LET g_imba_m_t.imba014 = l_imaa.imaa014
   LET g_imba_m_t.imba005 = l_imaa.imaa005
   LET g_imba_m_t.imba002 = l_imaa.imaa002 + 1 USING "<<<<<<<<<#"
   LET g_imba_m_t.imba105 = l_imaa.imaa105
   LET g_imba_m_t.imba104 = l_imaa.imaa104
   LET g_imba_m_t.imba107 = l_imaa.imaa107
   LET g_imba_m_t.imba106 = l_imaa.imaa106
   LET g_imba_m_t.imba113 = l_imaa.imaa113
   LET g_imba_m_t.imba109 = l_imaa.imaa109
   LET g_imba_m_t.imba142 = l_imaa.imaa142
   LET g_imba_m_t.imba009 = l_imaa.imaa009
   LET g_imba_m_t.imba161 = l_imaa.imaa161   #160705-00013#3 160712 by lori add   
   LET g_imba_m_t.imba101 = l_imaa.imaa101
   LET g_imba_m_t.imba102 = l_imaa.imaa102
   LET g_imba_m_t.imba103 = l_imaa.imaa103
   LET g_imba_m_t.imba118 = l_imaa.imaa118
   LET g_imba_m_t.imba119 = l_imaa.imaa119
   LET g_imba_m_t.imba120 = l_imaa.imaa120
   LET g_imba_m_t.imba114 = l_imaa.imaa114
   LET g_imba_m_t.imba115 = l_imaa.imaa115
   LET g_imba_m_t.imba116 = l_imaa.imaa116
   LET g_imba_m_t.imba117 = l_imaa.imaa117
   LET g_imba_m_t.imba124 = l_imaa.imaa124
   LET g_imba_m_t.imba110 = l_imaa.imaa110
   LET g_imba_m_t.imba111 = l_imaa.imaa111
   LET g_imba_m_t.imba112 = l_imaa.imaa112
   LET g_imba_m_t.imba125 = l_imaa.imaa125
   LET g_imba_m_t.imba121 = l_imaa.imaa121
   LET g_imba_m_t.imba122 = l_imaa.imaa122
   LET g_imba_m_t.imba123 = l_imaa.imaa123
   LET g_imba_m_t.imba131 = l_imaa.imaa131
   LET g_imba_m_t.imba126 = l_imaa.imaa126
   LET g_imba_m_t.imba127 = l_imaa.imaa127
   LET g_imba_m_t.imba128 = l_imaa.imaa128
   LET g_imba_m_t.imba129 = l_imaa.imaa129
   LET g_imba_m_t.imba130 = l_imaa.imaa130
   LET g_imba_m_t.imba132 = l_imaa.imaa132
   LET g_imba_m_t.imba133 = l_imaa.imaa133
   LET g_imba_m_t.imba134 = l_imaa.imaa134
   LET g_imba_m_t.imba135 = l_imaa.imaa135
   LET g_imba_m_t.imba136 = l_imaa.imaa136
   LET g_imba_m_t.imba137 = l_imaa.imaa137
   LET g_imba_m_t.imba138 = l_imaa.imaa138
   LET g_imba_m_t.imba139 = l_imaa.imaa139
   LET g_imba_m_t.imba140 = l_imaa.imaa140
   LET g_imba_m_t.imba141 = l_imaa.imaa141
   LET g_imba_m_t.imba006 = l_imaa.imaa006
   LET g_imba_m_t.imba143 = l_imaa.imaa143
   LET g_imba_m_t.imba144 = l_imaa.imaa144
   LET g_imba_m_t.imba145 = l_imaa.imaa145
   LET g_imba_m_t.imba146 = l_imaa.imaa146
   LET g_imba_m_t.imba019 = l_imaa.imaa019
   LET g_imba_m_t.imba020 = l_imaa.imaa020
   LET g_imba_m_t.imba021 = l_imaa.imaa021
   LET g_imba_m_t.imba022 = l_imaa.imaa022
   LET g_imba_m_t.imba025 = l_imaa.imaa025
   LET g_imba_m_t.imba026 = l_imaa.imaa026
   LET g_imba_m_t.imba016 = l_imaa.imaa016
   LET g_imba_m_t.imba018 = l_imaa.imaa018
   LET g_imba_m_t.imba010 = l_imaa.imaa010
   LET g_imba_m_t.imba147 = l_imaa.imaa147 #150507-00001#2 Add By Ken 1505021
   LET g_imba_m_t.imba148 = l_imaa.imaa148 #150507-00001#2 Add By Ken 1505021
   LET g_imba_m_t.imba149 = l_imaa.imaa149 #150507-00001#2 Add By Ken 1505021
   IF l_imaa.imaastus = 'X' THEN
      LET g_imba_m.imbaacti = 'N'
   ELSE
      LET g_imba_m.imbaacti = 'Y'
   END IF
   
   #151029-00011#13 20151127 add by beckxie---S
   IF (NOT cl_null(g_imba_m.imba115)) AND (NOT cl_null(g_imba_m.imba116)) AND (cl_null(g_imba_m.imba117))THEN
      
      CALL artt300_cal_imba117()
      #異動imba117後，需再做一次
      LET g_imba_m_t.imba117 = g_imba_m.imba117
      
   END IF
   #151029-00011#13 20151127 add by beckxie---E
   DISPLAY BY NAME g_imba_m.imba001, g_imba_m.imba003, g_imba_m.imba108, g_imba_m.imba100,
                   g_imba_m.imba004,                                                          #160725-00016#1     by 08172
                   g_imba_m.imba014, g_imba_m.imba005, g_imba_m.imba002, g_imba_m.imba105,
                   g_imba_m.imba104, g_imba_m.imba107, g_imba_m.imba106, g_imba_m.imba113,
                   g_imba_m.imba109, g_imba_m.imba142, g_imba_m.imba009, g_imba_m.imba101,
                   g_imba_m.imba102, g_imba_m.imba103, g_imba_m.imba118, g_imba_m.imba119,
                   g_imba_m.imba120, g_imba_m.imba114, g_imba_m.imba115, g_imba_m.imba116,
                   g_imba_m.imba117, g_imba_m.imba124, g_imba_m.imba110, g_imba_m.imba111,
                   g_imba_m.imba112, g_imba_m.imba125, g_imba_m.imba121, g_imba_m.imba122,
                   g_imba_m.imba123, g_imba_m.imba131, g_imba_m.imba126, g_imba_m.imba127,
                   g_imba_m.imba128, g_imba_m.imba129, g_imba_m.imba130, g_imba_m.imba132,
                   g_imba_m.imba133, g_imba_m.imba134, g_imba_m.imba135, g_imba_m.imba136,
                   g_imba_m.imba137, g_imba_m.imba138, g_imba_m.imba139, g_imba_m.imba140,
                   g_imba_m.imba141, g_imba_m.imba006, g_imba_m.imba143, g_imba_m.imbaacti,
                   g_imba_m.imba144, g_imba_m.imba145, g_imba_m.imba019, g_imba_m.imba020,
                   g_imba_m.imba021, g_imba_m.imba022, g_imba_m.imba025, g_imba_m.imba026, 
                   g_imba_m.imba016, g_imba_m.imba018, g_imba_m.imba146, g_imba_m.imba010,
                   g_imba_m.imba147, g_imba_m.imba148, g_imba_m.imba149, g_imba_m.imba161    #150507-00001#2 By Ken 1505021 Add imaa147-imaa149  #160705-00013#3 160712 by lori add  imaa161
   
   INITIALIZE l_imbal.* TO NULL                
   SELECT imaal003,imaal004,imaal005 INTO l_imbal.* FROM imaal_t
    WHERE imaal001 = g_imba_m.imba001
      AND imaal002 = g_dlang
      AND imaalent = g_enterprise
      
   LET g_imba_m.imbal002 = l_imbal.imbal002
   LET g_imba_m.imbal003 = l_imbal.imbal003
   LET g_imba_m.imbal004 = l_imbal.imbal004
   
   LET g_imba_m_t.imbal002 = l_imbal.imbal002
   LET g_imba_m_t.imbal003 = l_imbal.imbal003
   LET g_imba_m_t.imbal004 = l_imbal.imbal004
   
   ##150613 by lori mod---(S)
   CALL s_artt300_get_imbf061(g_imba_m.imbadocno,g_imba_m.imba001)
   #150614-00020#1 20150617 mark by beckxie---S
#      RETURNING g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064 
#   DISPLAY BY NAME g_imba_m.l_imbf061,g_imba_m.l_imbf062,g_imba_m.l_imbf063,g_imba_m.l_imbf064 
   #150614-00020#1 20150617 mark by beckxie---E
   #150614-00020#1 20150617 add  by beckxie---S
       RETURNING g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                 g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
   DISPLAY BY NAME g_imba_m.imbf061,g_imba_m.imbf062,g_imba_m.imbf063,g_imba_m.imbf064,
                   g_imba_m.imbf114,g_imba_m.imbf115,g_imba_m.imbf116,g_imba_m.imbf122   #150122-00013#1 151028 By pomelo add
   #150614-00020#1 20150617 add  by beckxie---E
   ##150613 by lori mod---(E) 

   DISPLAY BY NAME g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004
   CALL artt300_imba003_ref()
   CALL artt300_imba105_ref()
   CALL artt300_imba104_ref()
   CALL artt300_imba107_ref()
   CALL artt300_imba106_ref()   
   CALL artt300_imba142_ref()   
   CALL artt300_imba009_ref()
   CALL artt300_imba101_ref()
   CALL artt300_imba114_ref()
   CALL artt300_imba124_ref()
   CALL artt300_imba122_ref()
   CALL artt300_imba131_ref()
   CALL artt300_imba126_ref()
   CALL artt300_imba127_ref()
   CALL artt300_imba128_ref()
   CALL artt300_imba129_ref()
   CALL artt300_imba132_ref()
   CALL artt300_imba133_ref()
   CALL artt300_imba134_ref()
   CALL artt300_imba135_ref()
   CALL artt300_imba136_ref()
   CALL artt300_imba137_ref()
   CALL artt300_imba138_ref()
   CALL artt300_imba139_ref()
   CALL artt300_imba140_ref()
   CALL artt300_imba141_ref()  
   CALL artt300_imba006_ref() 
   CALL artt300_imba143_ref()
   CALL artt300_imba145_ref()
   CALL artt300_imba146_ref()
   CALL artt300_imba022_ref()
   CALL artt300_imba026_ref()
   CALL artt300_imba018_ref()
   
   LET g_imba_m.imba161_desc = s_desc_pcba001_desc(g_imba_m.imba161)   #160705-00013#3 1607132 by lori add
   DISPLAY BY NAME g_imba_m.imba161_desc                               #160705-00013#3 1607132 by lori add
   
   LET l_sql = "INSERT INTO imbk_t (imbkent,imbkdocno,imbk001,imbk002,imbk003)",
               " SELECT imakent,'",g_imba_m.imbadocno,"',imak001,imak002,imak003",
               "   FROM imak_t",
               "  WHERE imakent = ",g_enterprise,
               "    AND imak001 = '",g_imba_m.imba001,"'"
   PREPARE artt300_ins_imbk FROM l_sql
   EXECUTE artt300_ins_imbk
   
   LET g_imba_m_o.* = g_imba_m_t.*
END FUNCTION
#+
PUBLIC FUNCTION artt300_carry_detail()
   DEFINE l_imby       type_g_imby_d
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_Sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   
   LET g_errno = ''
   IF g_imba_m.imba000 = 'I' THEN
      RETURN
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM imby_t
    WHERE imbyent = g_enterprise
      AND imbydocno = g_imba_m.imbadocno
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO imby_t( ",
                  "        imby001 , imbystus, imby002 , imby003 , imby004 , ",
                  "        imby005 , imby006 , imby007 , imby008 , imby009 , ",
                  "        imby010 , imby011 , imby012 , imby013 , imby014 , ",
                  "        imby015 , imby016 , imby017 , imby018 , imby019 , ",   #160801-00017#4 20160812 add(imby018,imby019) by beckxie
                  "        imbydocno,imbyent)",
                  " SELECT imay001 , imaystus, imay002 , imay003 , imay004 , ",
                  "        imay005 , imay006 , imay007 , imay008 , imay009 , ",
                  "        imay010 , imay011,  imay012 , imay013 , imay014 , ",
                  "        imay015 , imay016,  imay017 , imay018 , imay019 , ",   #160801-00017#4 20160812 add(imay018,imay019) by beckxie
                  "'",g_imba_m.imbadocno,"',imayent",
                  "   FROM imay_t ",
                  "  WHERE imayent = ",g_enterprise," AND imay001 = '",g_imba_m.imba001,"'"     
      PREPARE ins_imby_pre FROM l_sql
      EXECUTE ins_imby_pre 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins imby_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF  
   ELSE
      UPDATE imby_t SET imby001 = g_imba_m.imba001
       WHERE imbydocno = g_imba_m.imbadocno
         AND imbyent   = g_enterprise
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd imby_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF 
   END IF
   
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM imbz_t
    WHERE imbzent = g_enterprise
      AND imbzdocno = g_imba_m.imbadocno
   IF l_cnt = 0 THEN
      LET l_sql = " INSERT INTO imbz_t( ",
#                  "        imbz001 , imbz002 , imbz003 , imbz004 , imbz005 , imbzdocno,imbzent)",   #150710-00016#1 20150714 mark by beckxie
#                  " SELECT imaz001 , imaz002 , imaz003 , imaz004 , imaz005 , '",g_imba_m.imbadocno,"',imazent",   #150710-00016#1 20150714 mark by beckxie
                  "        imbz001 , imbz002 , imbz003 , imbz004 , imbz005 , imbz006,imbzdocno,imbzent)",   #150710-00016#1 20150714 add by beckxie
                  " SELECT imaz001 , imaz002 , imaz003 , imaz004 , imaz005 , imaz006,'",g_imba_m.imbadocno,"',imazent",   #150710-00016#1 20150714 add by beckxie
                  "   FROM imaz_t ",
                  "  WHERE imazent = ",g_enterprise," AND imaz001 = '",g_imba_m.imba001,"'"     
      PREPARE ins_imbz_pre FROM l_sql
      EXECUTE ins_imbz_pre 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins imbz_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF   
   ELSE
      UPDATE imbz_t SET imbz001 = g_imba_m.imba001
       WHERE imbzdocno = g_imba_m.imbadocno
         AND imbzent   = g_enterprise
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd imbz_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_errno = SQLCA.sqlcode
      END IF    
   END IF
  
END FUNCTION
#+
PUBLIC FUNCTION artt300_cal_imba117()
   IF g_imba_m.imba115 = 0 OR g_imba_m.imba116 = 0 THEN
      LET g_imba_m.imba117 = 0
   ELSE
      LET g_imba_m.imba117 = (g_imba_m.imba116 - g_imba_m.imba115)/g_imba_m.imba115 * 100
   END IF
   DISPLAY BY NAME g_imba_m.imba117
END FUNCTION
#+
PUBLIC FUNCTION artt300_set_required(p_cmd)
   DEFINE p_cmd    LIKE type_t.chr1
   
   #IF g_imba_m.imba000 = 'U'  OR  'I' THEN #mark by geza 20160627 #160604-00009#108
   #新增的时候商品可以不必输
   IF g_imba_m.imba000 = 'U'  THEN #add by geza 20160627 #160604-00009#108
      CALL cl_set_comp_required("imba001",TRUE)
   END IF
   #150317-00002#2 Add-S By Ken 150319
   IF g_argv[1] = '2' THEN
      CALL cl_set_comp_required("imba143",TRUE)
   END IF  
   #150317-00002#2 Add-E
   
   #150427-00001#2 Add-S By Ken 150513
   #150614-00020#1 20150617 mark by beckxie---S
#   CALL cl_set_comp_required("imbf062",TRUE)
#   IF g_imba_m.l_imbf062 = 'Y' THEN
#     CALL cl_set_comp_required("l_imbf063",TRUE)
   #150614-00020#1 20150617 mark by beckxie---E
   #150614-00020#1 20150617 add  by beckxie---S
   IF g_imba_m.imbf062 = 'Y' THEN
      CALL cl_set_comp_required("imbf063",TRUE)
   #150614-00020#1 20150617 add by beckxie---E
   END IF   
   #150427-00001#2 Add-E By Ken 150513
   #160529-00002#1--s
   IF g_imba_m.imba149 <> '1' THEN
      CALL cl_set_comp_required("imba147,imba148",TRUE)   
   END IF
   #160529-00002#1--e
END FUNCTION
#+
PUBLIC FUNCTION artt300_set_no_required(p_cmd)
   DEFINE p_cmd    LIKE type_t.chr1
   
   CALL cl_set_comp_required("imba001",FALSE)
   #150317-00002#2 Add-S By Ken 150319
   CALL cl_set_comp_required("imba143",FALSE)
   #150317-00002#2 Add-E
   #150614-00020#1 20150617 mark by beckxie---S
#   CALL cl_set_comp_required("imbf062",FALSE)
#   CALL cl_set_comp_required("l_imbf063",FALSE) #150427-00001#2 Add By Ken 150513
   #150614-00020#1 20150617 mark by beckxie---E
   CALL cl_set_comp_required("imbf063",FALSE) #150427-00001#2 Add By Ken 150513 #150614-00020#1 20150617 add by beckxie
   CALL cl_set_comp_required("imba147,imba148",FALSE)   #160529-00002#1

END FUNCTION
#+
PUBLIC FUNCTION artt300_upd_imbz()
   DEFINE l_cnt    LIKE type_t.num5
   
   #如果多條碼同時存在2筆以上的條碼資料時,將imbz_t裡 有用這樣子的條碼資料都update成null
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imby_t
    WHERE imbydocno = g_imba_m.imbadocno
      AND imbyent = g_enterprise
      AND imby003 = g_imby_d[l_ac].imby003
      AND imbystus = 'Y'
   IF l_cnt > 1 THEN
      UPDATE imbz_t SET imbz003 = ''
       WHERE imbzdocno = g_imba_m.imbadocno
         AND imbzent = g_enterprise
         AND imbz003 = g_imby_d[l_ac].imby003
   ELSE
      IF l_cnt = 0 THEN      
         SELECT COUNT(*) INTO l_cnt FROM imby_t
          WHERE imbydocno = g_imba_m.imbadocno
            AND imbyent = g_enterprise
            AND imby003 = g_imby_d_t.imby003
            AND imbystus = 'Y'
         IF l_cnt = 0 THEN
            UPDATE imbz_t SET imbz003 = ''
             WHERE imbzdocno = g_imba_m.imbadocno
               AND imbzent = g_enterprise
               AND imbz003 = g_imby_d_t.imby003
         END IF
      END IF
   END IF
   
   #單imby_t的條碼資料改變,也一併將imbz_t中有使用imby_t的舊值資料的條碼改變
   IF cl_null(g_imby_d[l_ac].imby003) OR g_imby_d[l_ac].imby003 != g_imby_d_t.imby003 THEN
      IF NOT cl_null(g_imby_d_t.imby003) THEN
         UPDATE imbz_t SET imbz003 = g_imby_d[l_ac].imby003
          WHERE imbzdocno = g_imba_m.imbadocno
            AND imbzent = g_enterprise
            AND imbz003 = g_imby_d_t.imby003
      END IF  
   END IF
   IF g_imby_d[l_ac].imbystus = 'N' THEN
      UPDATE imbz_t SET imbz003 = ''
       WHERE imbzdocno = g_imba_m.imbadocno
         AND imbzent = g_enterprise
         AND imbz003 = g_imby_d[l_ac].imby003
   ELSE
      #將imbz_t 包裝單位與整包裝數資料 與imby_t的資料同步
      UPDATE imbz_t SET imbz004 = g_imby_d[l_ac].imby004,
                        imbz005 = g_imby_d[l_ac].imby005
       WHERE imbzdocno = g_imba_m.imbadocno
         AND imbzent = g_enterprise
         AND imbz003 = g_imby_d[l_ac].imby003
         
      UPDATE imbz_t SET imbz005 = g_imby_d[l_ac].imby005
       WHERE imbzdocno = g_imba_m.imbadocno
         AND imbzent = g_enterprise
         AND imbz004 = g_imby_d[l_ac].imby004  
   END IF   

END FUNCTION
#+
PUBLIC FUNCTION artt300_refresh_main_imby()
DEFINE l_cnt      LIKE type_t.num5
  
   IF cl_null(g_imba_m.imba014) THEN
      RETURN
   END IF
   LET g_errno = ''
   UPDATE imby_t SET imby006 = 'N',
                     imby001 = g_imba_m.imba001
    WHERE imbydocno = g_imba_m.imbadocno
      AND imbyent = g_enterprise
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imby_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imby_t
    WHERE imbydocno = g_imba_m.imbadocno
      AND imby003 = g_imba_m.imba014
      AND imbyent = g_enterprise
   IF l_cnt > 0 THEN
      UPDATE imby_t SET imby006 = 'Y',
                        imby002 = g_imba_m.imba100,
                        imby007 = g_imba_m.imba019,
                        imby008 = g_imba_m.imba020,
                        imby009 = g_imba_m.imba021,
                        imby015 = g_imba_m.imba022,
                        imby010 = g_imba_m.imba025,
                        imby016 = g_imba_m.imba026,
                        imby011 = g_imba_m.imba016,
                        imby017 = g_imba_m.imba018
       WHERE imbydocno = g_imba_m.imbadocno
         AND imby003 = g_imba_m.imba014
         AND imbyent = g_enterprise
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imby_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF 
   ELSE
      INSERT INTO imby_t(imbyent,imbydocno,imby001,imby002,
                         imby003,imby004,imby005,imby006,
                         imby007,imby008,imby009,imby015,
                         imby010,imby016,
                         imby011,imby017,imby018, #ken---add 加imby018
                         imbystus)
                  VALUES(g_enterprise,g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba100,
                         g_imba_m.imba014,g_imba_m.imba104,1,'Y',
                         g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,
                         g_imba_m.imba025,g_imba_m.imba026,
                         g_imba_m.imba016,g_imba_m.imba018,g_imba_m.imba113, #ken---add 加imba113
                         'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins imby_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF 
   END IF
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imba114()
DEFINE l_stus        LIKE type_t.chr1

   LET g_errno = '' LET l_stus = ''

   SELECT ooaistus INTO l_stus FROM ooai_t
    WHERE ooai001 = g_imba_m.imba114
      AND ooaient = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00028'
#        WHEN l_stus='N'            LET g_errno = 'aoo-00011'      #160318-00005#43  mark
        WHEN l_stus='N'            LET g_errno = 'sub-01302'      #160318-00005#43  add
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#檢查 供應商編號 輸入的正確性
PUBLIC FUNCTION artt300_chk_imba101()
DEFINE l_stus        LIKE type_t.chr1
DEFINE l_pmaa002     LIKE pmaa_t.pmaa002
   LET g_errno = '' LET l_stus = ''
   LET l_pmaa002 = ''
   SELECT pmaastus,pmaa002 INTO l_stus,l_pmaa002 FROM pmaa_t
    WHERE pmaa001 = g_imba_m.imba101
      AND pmaaent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00016'
        WHEN l_stus='N'            LET g_errno = 'aoo-00017'
        WHEN l_pmaa002 = '2'       LET g_errno = 'apm-00081'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imba124()
   DEFINE l_stus        LIKE type_t.chr1
   DEFINE l_ooef019     LIKE ooef_t.ooef019

   LET g_errno = '' LET l_stus = ''
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   IF cl_null(l_ooef019) THEN
      LET g_errno = 'art-00111'
   END IF
   
   SELECT oodbstus INTO l_stus FROM oodb_t
    WHERE oodb002 = g_imba_m.imba124
      AND oodb004 = '1'
      AND oodb001 = l_ooef019
      AND oodbent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00074'
        WHEN l_stus='N'            LET g_errno = 'art-00075'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_unit(p_unit)
DEFINE p_unit     LIKE type_t.chr10
DEFINE l_stus     LIKE type_t.chr10

   LET g_errno = '' LET l_stus = ''

   SELECT oocastus INTO l_stus FROM ooca_t
    WHERE ooca001 = p_unit
      AND oocaent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00003'
#        WHEN l_stus='N'            LET g_errno = 'aim-00005'      #160318-00005#43  mark
        WHEN l_stus='N'            LET g_errno = 'sub-01302'      #160318-00005#43  add
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imbz003()
   DEFINE l_stus      LIKE type_t.chr10
   DEFINE l_unit      LIKE type_t.chr10
   DEFINE l_num       LIKE imby_t.imby005
   DEFINE l_cnt       LIKE type_t.num5
   
   LET g_errno = '' 
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM imby_t
    WHERE imbyent = g_enterprise
      AND imbydocno = g_imba_m.imbadocno
      AND imby003 = g_imby2_d[l_ac].imbz003 
     
   IF l_cnt <= 1 THEN
      LET l_stus = ''   LET l_unit = ''   LET l_num = ''
         
      SELECT imbystus,imby004,imby005 INTO l_stus,l_unit,l_num FROM imby_t
       WHERE imbyent = g_enterprise
         AND imbydocno = g_imba_m.imbadocno
         AND imby003 = g_imby2_d[l_ac].imbz003
         
      CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00021'
                                      LET l_unit = ''
                                      LET l_num = ''
#           WHEN l_stus='N'            LET g_errno = 'art-00022'      #160318-00005#43  mark
           WHEN l_stus='N'            LET g_errno = 'sub-01302'      #160318-00005#43  add
                                      LET l_unit = ''
                                      LET l_num = ''
           OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
                                      LET g_imby2_d[l_ac].imbz004 = l_unit
                                      LET g_imby2_d[l_ac].imbz005 = l_num
                                      
      END CASE
      
      DISPLAY BY NAME g_imby2_d[l_ac].imbz004,g_imby2_d[l_ac].imbz005
      CALL artt300_imbz004_ref()
   ELSE
      LET g_errno = 'art-00027' 
   END IF
   
   
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba142_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba142
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba142_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba142_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba107_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba107
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba107_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba107_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba009_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba009_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba114_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba114
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba114_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba114_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba101_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba101
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba101_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba101_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba106_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba106
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba106_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba106_desc      
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba104_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba104
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba104_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba104_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba105_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba105
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba105_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba105_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba133_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba133
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2007' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba133_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba133_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba132_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba132
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2006' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba132_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba132_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba129_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba129
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2005' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba129_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba129_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba136_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba136
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2010' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba136_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba136_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba135_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba135
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2009' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba135_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba135_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba134_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba134
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2008' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba134_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba134_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba131_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba131
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba131_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba131_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba122_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba122
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba122_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba122_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba124_ref()
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   INITIALIZE g_ref_fields TO NULL
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   IF NOT cl_null(l_ooef019) THEN
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_imba_m.imba124      
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imba_m.imba124_desc = '', g_rtn_fields[1] , ''
   END IF
   DISPLAY BY NAME g_imba_m.imba124_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba128_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba128
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2004' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba128_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba128_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba127_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba127
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2003' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba127_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba127_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba126_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba126
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba126_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba126_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba138_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba138
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2012' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba138_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba138_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba137_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba137
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2011' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba137_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba137_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba139_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba139
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2013' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba139_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba139_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba141_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba141
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2015' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba141_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba141_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_imba140_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba140
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2014' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba140_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba140_desc
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_barcode(p_barcode)
   DEFINE p_barcode  LIKE imaa_t.imaa014
   DEFINE l_cnt      LIKE type_t.num5
   
   LET g_errno = ''
   LET l_cnt = 0
   
   IF NOT cl_null(g_imba_m.imba001) THEN
      SELECT COUNT(*) INTO l_cnt FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 != g_imba_m.imba001 
         AND imay003 = p_barcode  
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM imay_t
       WHERE imayent = g_enterprise
         AND imay003 = p_barcode 
   END IF
   #dongsz--add--str---
   IF l_cnt = 0 AND NOT cl_null(g_imba_m.imba001) THEN
      SELECT COUNT(*) INTO l_cnt FROM imby_t
       WHERE imbyent = g_enterprise
         AND imby001 != g_imba_m.imba001
         AND imby003 = p_barcode
   END IF
   #dongsz--add--end---
   
   IF l_cnt > 0 THEN
      LET g_errno = 'art-00032'
   END IF
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imbadocno()
   DEFINE l_stus        LIKE type_t.chr1

   LET g_errno = ''
   SELECT oobastus INTO l_stus  FROM ooba_t,oobl_t 
    WHERE oobaent = ooblent  AND ooba001 = oobl001
      AND ooba002 = oobl002   AND oobl003 = 'artt300'
      AND oobl001 = g_ooef004 AND oobl002= g_imba_m.imbadocno
      AND ooblent = g_enterprise
      
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aim-00056'
        WHEN l_stus='N'            LET g_errno = 'aoo-00102'       
   END CASE
   
END FUNCTION
#+
PUBLIC FUNCTION artt300_chk_imby004()
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_unit_o   LIKE imby_t.imby003
   DEFINE l_num_o    LIKE imby_t.imby004   
   DEFINE l_unit_t   LIKE imby_t.imby003
   DEFINE l_num_t    LIKE imby_t.imby004
   
   LET g_errno = ''
   
#2014/06/20 By pomelo mark start------ 
#   IF NOT cl_null(g_imby_d[l_ac].imby003) THEN
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt FROM imby_t
#       WHERE imbyent = g_enterprise
#         AND imbydocno = g_imba_m.imbadocno
#         AND imby004 = g_imby_d[l_ac].imby004
#         AND imby003 != g_imby_d[l_ac].imby003
#         AND imbystus = 'Y'
#      IF l_cnt >= 1 THEN
#         LET g_errno = 'art-00028' 
#      END IF
#   ELSE
#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt FROM imby_t
#       WHERE imbyent = g_enterprise
#         AND imbydocno = g_imba_m.imbadocno
#         AND imby004 = g_imby_d[l_ac].imby004
#         AND imbystus = 'Y'
#      IF l_cnt >= 1 THEN
#         LET g_errno = 'art-00028'
#      END IF      
#   END IF
#   IF NOT cl_null(g_errno) THEN
#      RETURN
#   END IF
#2014/06/20 By pomelo mark end------
#   IF NOT (g_imby_d[l_ac].imby004 != g_imby_d_o.imby004 OR g_imby_d_o.imby004 IS NULL) THEN   #150427-00012#6 20150707 mark by beckxie
   IF NOT (g_imby_d[l_ac].imby004 != g_imby_d_o.imby004 OR cl_null(g_imby_d_o.imby004)) THEN   #150427-00012#6 20150707 add by beckxie
      RETURN
   END IF
#   150518-00035#1  mark by geza   (S)   
#   IF g_imby_d[l_ac].imby004 = g_imba_m.imba104 THEN
#
#      LET g_imby_d[l_ac].imby005 = 1
#      #DISPLAY BY NAME g_imby_d[l_ac].imby005 #150504-00038#1 Mark By Ken 150506
#      RETURN
#        
#   END IF   
#   150518-00035#1  mark by geza   (E)
   LET l_unit_o = ''   LET l_num_o = ''
   LET l_unit_t = ''   LET l_num_t = ''
   
   SELECT imad002,imad003,imad004,imad005 
     INTO l_unit_o,l_num_o,l_unit_t,l_num_t
     FROM imad_t
    WHERE imadent = g_enterprise
      AND imad001 = g_imba_m.imba001
      AND imad002 = g_imba_m.imba104
      AND imad004 = g_imby_d[l_ac].imby004
      AND imadstus = 'Y'
   IF SQLCA.sqlcode = 100 THEN
      LET l_unit_o = ''   LET l_num_o = ''
      LET l_unit_t = ''   LET l_num_t = ''
      SELECT imad002,imad003,imad004,imad005 
        INTO l_unit_t,l_num_t,l_unit_o,l_num_o
        FROM imad_t
       WHERE imadent = g_enterprise
         AND imad001 = g_imba_m.imba001
         AND imad002 = g_imby_d[l_ac].imby004
         AND imad004 = g_imba_m.imba104
         AND imadstus = 'Y'
   END IF
   
   IF NOT cl_null(l_unit_o) AND NOT cl_null(l_num_o) AND 
      NOT cl_null(l_unit_t) AND NOT cl_null(l_num_t) THEN
      LET l_num_o = l_num_o / l_num_t
      LET g_imby_d[l_ac].imby005 = l_num_o       
   END IF  
END FUNCTION

PUBLIC FUNCTION artt300_imby004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imby_d[l_ac].imby004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imby_d[l_ac].imby004_desc = '', g_rtn_fields[1] , ''
  #DISPLAY BY NAME g_imby_d[l_ac].imby004
END FUNCTION

PUBLIC FUNCTION artt300_imbz004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imby2_d[l_ac].imbz004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imby2_d[l_ac].imbz004_desc = '', g_rtn_fields[1] , ''
  #DISPLAY BY NAME g_imby2_d[l_ac].imbz004
END FUNCTION

PUBLIC FUNCTION artt300_imba003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba003
   CALL ap_ref_array2(g_ref_fields,"SELECT imckl003 FROM imckl_t WHERE imcklent='"||g_enterprise||"' AND imckl001=? AND imckl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba003_desc
END FUNCTION
#檢查此包裝單位與計價單位之間是否存在換算率
PUBLIC FUNCTION artt300_chk_imby004_1()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014

   LET l_rate = ''

   LET l_success = TRUE
   IF g_imby_d[l_ac].imby004 = g_imba_m.imba106 THEN
      LET g_imby_d[l_ac].imby013 = 1
      #DISPLAY BY NAME g_imby_d[l_ac].imby013 #150504-00038#1 Mark By Ken 150506
      RETURN l_success
   END IF

   CALL s_aimi190_get_convert(g_imba_m.imba001,g_imby_d[l_ac].imby004,g_imba_m.imba106)
      RETURNING l_success,l_rate

   IF l_success THEN
      LET g_imby_d[l_ac].imby013 = l_rate
      #DISPLAY BY NAME g_imby_d[l_ac].imby013 #150504-00038#1 Mark By Ken 150506
   END IF

   RETURN l_success
END FUNCTION

PUBLIC FUNCTION artt300_imba006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba006_desc 
END FUNCTION

################################################################################
# Descriptions...: 確認產品組的條件編號(品類/品牌)是否符合條件
# Memo...........:
# Usage..........: CALL artt300_chk_imba143(p_type)
# Input parameter: p_type    1.imba143 2.其他欄位檢查
# Return code....: 無
# Date & Author..: 2014/05/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION artt300_chk_imba143(p_type)
DEFINE p_type          LIKE type_t.chr1
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         LIKE type_t.chr10
DEFINE r_rtax001       LIKE rtax_t.rtax001
DEFINE l_dbbastus      LIKE dbba_t.dbbastus
DEFINE l_dbbbstus      LIKE dbbb_t.dbbbstus
   
   LET g_errno = ''
   IF p_type = '2' THEN
      LET l_dbbastus = ''
      SELECT dbbastus INTO l_dbbastus
        FROM dbba_t
       WHERE dbbaent = g_enterprise
         AND dbba001 = g_imba_m.imba143
      CASE
         WHEN SQLCA.sqlcode = 100
            LET g_errno = 'adb-00030'
            RETURN
         WHEN l_dbbastus = 'N'
            LET g_errno = 'adb-00031'
            RETURN
      END CASE
   END IF
   
   IF NOT cl_null(g_imba_m.imba009) THEN
      LET r_success = ''
      LET r_errno = ''
      LET r_rtax001 = ''
      CALL s_arti202_search_manage_level(g_imba_m.imba009) 
         RETURNING r_success,r_errno,r_rtax001
      IF r_success = FALSE THEN LET r_rtax001 = '' END IF
   END IF
   
   LET l_dbbbstus = ''
   SELECT dbbbstus INTO l_dbbbstus
     FROM dbbb_t
    WHERE dbbbent = g_enterprise
      AND dbbb001 = g_imba_m.imba143
      AND ((dbbb002 = '1' AND dbbb003 = r_rtax001)
       OR ( dbbb002 = '2' AND dbbb003 = g_imba_m.imba126))
   
   CASE
      WHEN SQLCA.sqlcode = 100
         #此產品組下沒有符合條件的資料！
         LET g_errno = 'adb-00037'
      WHEN l_dbbbstus = 'N'
         LET g_errno = 'adb-00038'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 帶出產品組說明说明
# Memo...........:
# Usage..........: CALL artt300_imba143_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/02 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION artt300_imba143_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba143
   CALL ap_ref_array2(g_ref_fields," SELECT dbbal003 FROM dbbal_t WHERE dbbalent = '"||g_enterprise||"' AND dbbal001 = ? AND dbbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba143_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba143_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查單身及單頭條碼類型是否一致
# Memo...........:
# Usage..........: CALL artt300_imby006_chk()
# Date & Author..: 20140527 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION artt300_imby006_chk()
DEFINE l_rtaj001      LIKE rtaj_t.rtaj001
DEFINE l_rtaj002      LIKE rtaj_t.rtaj002
DEFINE l_rtaj003      LIKE rtaj_t.rtaj003
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE l_str          LIKE type_t.chr2
DEFINE l_len          LIKE type_t.num5
DEFINE l_str1         LIKE type_t.chr2
DEFINE l_len1         LIKE type_t.num5
#   150518-00034#1  mark by geza   (S)
#   IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '4' THEN
#      IF g_imby_d[l_ac].imby005 = 1 THEN
#         LET l_rtaj001 = '1'
#      ELSE
#         LET l_rtaj001 = '2'
#      END IF
#   END IF
#   IF g_imba_m.imba109 = '2' THEN
#      LET l_rtaj001 = '4'
#   END IF
#   IF g_imba_m.imba109 = '3' THEN
#      LET l_rtaj001 = '5'
#   END IF
#   150518-00034#1  mark by geza   (E)
#   150518-00034#1  add by geza   (S)
   #IF g_imba_m.imba109 = '1'  THEN    #160604-00009#91--dongsz mark
   IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '8' OR g_imba_m.imba109 = '9' OR g_imba_m.imba109 = '10' THEN    #160604-00009#91--dongsz add
      IF g_imby_d[l_ac].imby005 = 1 THEN
         LET l_rtaj001 = '1'
      ELSE
         LET l_rtaj001 = '2'
      END IF
   END IF
   IF g_imba_m.imba109 = '4' THEN
      LET l_rtaj001 = '4'
   END IF
   IF g_imba_m.imba109 = '5' THEN
      LET l_rtaj001 = '5'
   END IF
#   150518-00034#1  add by geza   (E)

   SELECT rtaj002,rtaj003 INTO l_rtaj002,l_rtaj003 FROM rtaj_t
    WHERE rtajent = g_enterprise 
      AND rtaj001 = l_rtaj001
   SELECT gzcbl004 INTO l_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = '6554'
      AND gzcbl002 = l_rtaj002
      AND gzcbl003 = g_dlang
   LET l_str = l_gzcbl004
   SELECT gzcbl004 INTO l_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = '6555'
      AND gzcbl002 = l_rtaj003
      AND gzcbl003 = g_dlang
   LET l_len = l_gzcbl004
   
   LET l_str1 = g_imby_d[l_ac].imby003[1,2]
   LET l_len1 = LENGTH(g_imby_d[l_ac].imby003)
   IF l_str <> l_str1 OR l_len <> l_len1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00391'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
 
   RETURN TRUE 
END FUNCTION
#補商品編號
PUBLIC FUNCTION artt300_input1()
   
   LET INT_FLAG = 0 
   
   IF cl_null(g_imba_m.imbadocno) THEN
      RETURN
   END IF

   IF g_imba_m.imba000 = 'U' THEN
      RETURN
   END IF

   LET g_imba_m_o.* = g_imba_m.*
   LET g_imba_m.imbamodid = g_user
   LET g_imba_m.imbamoddt = cl_get_current()

   DISPLAY BY NAME g_imba_m.imba001
   CALL s_transaction_begin()
   INPUT BY NAME g_imba_m.imba001   WITHOUT DEFAULTS
      BEFORE INPUT

      AFTER FIELD imba001
         IF NOT cl_null(g_imba_m.imba001) THEN
#            IF g_imba_m.imba001 != g_imba_m_o.imba001 OR g_imba_m_o.imba001 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie
            IF g_imba_m.imba001 != g_imba_m_o.imba001 OR cl_null(g_imba_m_o.imba001) THEN   #150427-00012#6 20150707 add by beckxie
               CALL artt300_chk_imba001()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba001 = g_imba_m_o.imba001
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
         LET g_imba_m_o.imba001 = g_imba_m.imba001

      AFTER INPUT
         IF INT_FLAG THEN
            CALL s_transaction_end('N','0')
            EXIT INPUT
         END IF
         
         UPDATE imba_t SET imba001   = g_imba_m.imba001,
                           imbamodid = g_imba_m.imbamodid,
                           imbamoddt = g_imba_m.imbamoddt
          WHERE imbaent = g_enterprise
            AND imbadocno = g_imba_m.imbadocno

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "imba_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE INPUT
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imba_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE INPUT
         END CASE
         
         IF NOT artt300_upd_detail_imba001() THEN
            CALL s_transaction_end('N','0')
            CONTINUE INPUT
         END IF
         CALL s_transaction_end('Y','0')

   END INPUT

END FUNCTION

PUBLIC FUNCTION artt300_upd_detail_imba001()
   DEFINE l_success    LIKE type_t.num5

   LET l_success = FALSE

   UPDATE imby_t SET imby001 = g_imba_m.imba001
    WHERE imbyent = g_enterprise AND imbydocno = g_imba_m.imbadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imby001"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_success
   END IF

   UPDATE imbz_t SET imbz001 = g_imba_m.imba001
    WHERE imbzent = g_enterprise AND imbzdocno = g_imba_m.imbadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imbz001"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_success
   END IF
   
   UPDATE imbk_t SET imbk001 = g_imba_m.imba001
    WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imbk001"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_success
   END IF

   LET l_success = TRUE
   RETURN l_success
END FUNCTION

PUBLIC FUNCTION artt300_imba005_ref()
   #150305-00005#1 Modify By Ken 150324 原特徵組別說明抓取aimi013  改抓aimi092
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_imba_m.imba005
   #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='211' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_imba_m.imba005_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_imba_m.imba005_desc
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba005
   CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba005_desc
   #150305-00005#1 Modify
END FUNCTION
#新增特征值资料
PUBLIC FUNCTION artt300_ins_imbk()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5
#161111-00028#3--modify---begin-----------
#DEFINE l_imeb           RECORD LIKE imeb_t.*
#DEFINE l_imbk           RECORD LIKE imbk_t.*
DEFINE l_imeb RECORD  #料件特徵群組單身檔
       imebent LIKE imeb_t.imebent, #企業編號
       imeb001 LIKE imeb_t.imeb001, #特徵群組編號
       imeb002 LIKE imeb_t.imeb002, #項次
       imeb003 LIKE imeb_t.imeb003, #歸屬層級
       imeb004 LIKE imeb_t.imeb004, #類型
       imeb005 LIKE imeb_t.imeb005, #賦值方式
       imeb006 LIKE imeb_t.imeb006, #屬性類型
       imeb007 LIKE imeb_t.imeb007, #碼長
       imeb008 LIKE imeb_t.imeb008, #小數位數
       imeb009 LIKE imeb_t.imeb009, #預設值
       imeb010 LIKE imeb_t.imeb010, #最小限制
       imeb011 LIKE imeb_t.imeb011, #最大限制
       imeb012 LIKE imeb_t.imeb012, #二維輸入
       imeb013 LIKE imeb_t.imeb013  #限定資料來源
       END RECORD
DEFINE l_imbk RECORD  #料件申請料號特徵檔
       imbkent LIKE imbk_t.imbkent, #企業編號
       imbk001 LIKE imbk_t.imbk001, #料件編號
       imbk002 LIKE imbk_t.imbk002, #特徵類型
       imbk003 LIKE imbk_t.imbk003, #特徵值
       imbkdocno LIKE imbk_t.imbkdocno#申請編號
       END RECORD
#161111-00028#3--modify---end-------------
DEFINE l_n              LIKE type_t.num5
DEFINE l_n1             LIKE type_t.num5

   LET r_success = TRUE
  #LET l_sql = " SELECT * FROM imeb_t", #161111-00028#3--mark
  #161111-00028#3----add----begin-----------
   LET l_sql = " SELECT imebent,imeb001,imeb002,imeb003,imeb004,imeb005,imeb006,imeb007,imeb008,",
               "imeb009,imeb010,imeb011,imeb012,imeb013 FROM imeb_t",
  #161111-00028#3----add----end-------------
               "  WHERE imebent = '",g_enterprise,"'",
               "    AND imeb001 = ? ",
               "    AND imeb003 = '1' "
   PREPARE aimt300_sel_imeb_p FROM l_sql
   DECLARE aimt300_sel_imeb_c CURSOR FOR aimt300_sel_imeb_p

   LET l_n = 0
   SELECT COUNT(*) INTO l_n1
     FROM imbk_t
    WHERE imbkent = g_enterprise
      AND imbkdocno = g_imba_m.imbadocno
   IF g_imba_m_o.imba005 = g_imba_m.imba005  THEN
      IF l_n1 >0 THEN
         RETURN r_success
      END IF
   END IF

   IF g_imba_m_o.imba005 <> g_imba_m.imba005 THEN
      INITIALIZE l_imeb.* TO NULL
      FOREACH aimt300_sel_imeb_c USING g_imba_m_o.imba005 INTO l_imeb.*
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel_imeb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
         INITIALIZE l_imbk.* TO NULL
         LET l_imbk.imbkent = g_enterprise
         LET l_imbk.imbk002 = l_imeb.imeb004

         DELETE FROM imbk_t 
          WHERE imbkent = g_enterprise 
            AND imbkdocno = g_imba_m.imbadocno
            AND imbk002 = l_imbk.imbk002
      END FOREACH
   END IF

   FOREACH aimt300_sel_imeb_c USING g_imba_m.imba005 INTO l_imeb.*
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel_imeb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

         RETURN r_success
      END IF
      INITIALIZE l_imbk.* TO NULL
      LET l_imbk.imbkent = g_enterprise
      LET l_imbk.imbkdocno = g_imba_m.imbadocno
      LET l_imbk.imbk001 = g_imba_m.imba001
      LET l_imbk.imbk002 = l_imeb.imeb004
      LET l_imbk.imbk003 = l_imeb.imeb009
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imbk_t
       WHERE imbkent = l_imbk.imbkent
         AND imbkdocno = l_imbk.imbkdocno
         AND imbk002 = l_imbk.imbk002
      IF l_n = 0 THEN
       # INSERT INTO imbk_t VALUES(l_imbk.*)  #161111-00028#3--mark
       #161111-00028#3--add---begin-------
         INSERT INTO imbk_t (imbkent,imbk001,imbk002,imbk003,imbkdocno)
           VALUES (l_imbk.imbkent,l_imbk.imbk001,l_imbk.imbk002,l_imbk.imbk003,l_imbk.imbkdocno)
       #161111-00028#3--add---end---------
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins_imbk'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      ELSE
        CONTINUE FOREACH
        #UPDATE imbk_t SET imbk001= l_imbk.imbk001,
        #                  imbk003 = l_imbk.imbk003
        # WHERE imbkent = l_imbk.imbkent
        #   AND imbk001 = l_imbk.imbk001
        #   AND imbk002 = l_imbk.imbk002
        #IF SQLCA.sqlcode THEN
        #   LET r_success = FALSE
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = SQLCA.sqlcode
        #   LET g_errparam.extend = 'upd_imbk'
        #   LET g_errparam.popup = TRUE
        #   CALL cl_err()

        #   RETURN r_success
        #END IF
      END IF
   END FOREACH
   RETURN r_success

END FUNCTION

PUBLIC FUNCTION artt300_imba145_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba145
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba145_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba145_desc
END FUNCTION

PUBLIC FUNCTION artt300_imba022_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba022
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba022_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba022_desc
END FUNCTION

PUBLIC FUNCTION artt300_imba026_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba026
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba026_desc
END FUNCTION

PUBLIC FUNCTION artt300_imba018_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba018
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba018_desc
END FUNCTION

PUBLIC FUNCTION artt300_imby015_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imby_d[l_ac].imby015
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imby_d[l_ac].imby015_desc = '', g_rtn_fields[1] , ''
  #DISPLAY BY NAME g_imby_d[l_ac].imby015
END FUNCTION

PUBLIC FUNCTION artt300_imby016_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imby_d[l_ac].imby016
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imby_d[l_ac].imby016_desc = '', g_rtn_fields[1] , ''
  #DISPLAY BY NAME g_imby_d[l_ac].imby016
END FUNCTION

PUBLIC FUNCTION artt300_imby017_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imby_d[l_ac].imby017
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imby_d[l_ac].imby017_desc = '', g_rtn_fields[1] , ''
  #DISPLAY BY NAME g_imby_d[l_ac].imby017
END FUNCTION

PUBLIC FUNCTION artt300_imba146_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba146
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba146_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imba_m.imba146_desc
END FUNCTION

################################################################################
# Descriptions...: 判斷當前料號的產品特徵是否可以維護，如果不可以維護，進入其他欄位
# Memo...........:
# Usage..........: CALL artt300_imak003_enrty_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 20150126 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_imak003_enrty_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_imak002   LIKE imak_t.imak002
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_cn        LIKE type_t.num5
   DEFINE l_imeb005   LIKE imeb_t.imeb005
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   
     LET r_success = TRUE

     DECLARE imak003_chk_cs CURSOR FOR
         SELECT imak002                     #特徵類型
           FROM imak_t 
          WHERE imakent = g_enterprise 
            AND imak001 = g_imba_m.imba001

     SELECT imaa005 INTO l_imaa005 
       FROM imaa_t 
      WHERE imaaent = g_enterprise 
        AND imaa001 = g_imba_m.imba001
        
     LET l_cn = 0

     FOREACH imak003_chk_cs INTO l_imak002
        SELECT imeb005 INTO l_imeb005      #賦值方式
          FROM imeb_t
         WHERE imebent = g_enterprise
           AND imeb001 = l_imaa005
           AND imeb003 = '1'
           AND imeb004 =  l_imak002
        IF l_imeb005 <> '4' THEN
           LET l_cn = l_cn + 1
           EXIT FOREACH
        END IF
     END FOREACH

     IF l_cn = 0 THEN
        LET r_success = FALSE
     END IF
     
     RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 取得批號編碼方式說明
# Memo...........:
# Usage..........: CALL artt300_imbf063_ref(p_imbf063)
#                : RETURNING r_oofgl004
# Input parameter: p_imbf063      批號編碼方式
# Return code....: r_oofgl004     批碼編碼方式說明
# Date & Author..: 2015-05-13 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_imbf063_ref(p_imbf063)
DEFINE p_imbf063         LIKE imbf_t.imbf063
DEFINE r_oofgl004        LIKE oofgl_t.oofgl004

   LET r_oofgl004 = ''
   
   SELECT oofgl004 INTO r_oofgl004
     FROM oofgl_t 
    WHERE oofglent = g_enterprise
      AND oofgl001 = p_imbf063
      AND oofgl002 = ' '
      AND oofgl003 = g_dlang
   
   RETURN r_oofgl004
END FUNCTION

################################################################################
# Descriptions...:件装数检查
# Date & Author..: 2015/05/18 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_imby005_chk()
DEFINE l_rtaj001      LIKE rtaj_t.rtaj001
DEFINE l_rtaj002      LIKE rtaj_t.rtaj002
DEFINE l_rtaj003      LIKE rtaj_t.rtaj003
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE l_str          LIKE type_t.chr2
DEFINE l_str1         LIKE type_t.chr2
   
   #IF g_imba_m.imba109 = '1'  THEN    #160604-00009#91 dongsz mark
   IF g_imba_m.imba109 = '1' OR g_imba_m.imba109 = '8' OR g_imba_m.imba109 = '9' OR g_imba_m.imba109 = '10' THEN    #160604-00009#91 dongsz add
      IF g_imby_d[l_ac].imby005 = 1 THEN
         #LET l_rtaj001 = '1'       #160604-00009#91 dongsz mark
         LET l_rtaj001 = g_imba_m.imba109      #160604-00009#91 dongsz add
      ELSE
         LET l_rtaj001 = '2'
      END IF
   END IF

   SELECT rtaj002,rtaj003 INTO l_rtaj002,l_rtaj003 FROM rtaj_t
    WHERE rtajent = g_enterprise 
      AND rtaj001 = l_rtaj001
   SELECT gzcbl004 INTO l_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = '6554'
      AND gzcbl002 = l_rtaj002
      AND gzcbl003 = g_dlang
   LET l_str = l_gzcbl004
  
   LET l_str1 = g_imby_d[l_ac].imby003[1,2]
   IF l_str <> l_str1  THEN
      INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'art-00573'   #160604-00009#91 dongsz mark
      LET g_errparam.code = 'art-00790'    #160604-00009#91 dongsz add
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
 
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 取得商品臨期比例、商品臨期控管方式
# Memo...........:
# Usage..........: CALL artt300_get_rtax010(p_imba009)
#                  RETURNING r_rtax010,rtax011
# Input parameter: p_imba009      品類編號
# Return code....: r_rtax010      商品臨期比例
#                : r_rtax011      臨期控管方式 
# Date & Author..: 2015/05/21 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_get_rtax010(p_imba009)
DEFINE p_imba009        LIKE imba_t.imba009
DEFINE r_rtax010        LIKE rtax_t.rtax010
DEFINE r_rtax011        LIKE rtax_t.rtax011

   LET r_rtax010 = ''
   LET r_rtax011 = ''   

   SELECT rtax010,rtax011 INTO r_rtax010,r_rtax011
     FROM rtax_t
    WHERE rtaxent = g_enterprise
      AND rtax001 = p_imba009
      
   IF r_rtax010 = '' THEN
      LET r_rtax010 = 0
   END IF
   IF r_rtax011 = '' THEN
      LET r_rtax011 = 1
   END IF
   
   RETURN r_rtax010,r_rtax011
END FUNCTION

################################################################################
# Descriptions...: 使用保質月、日*臨期比例來推算出臨期天數
# Memo...........:
# Usage..........: CALL artt300_get_imba148()
#                  RETURNING r_day
# Input parameter: 
# Return code....: r_day       臨期天數
# Date & Author..: 2015/05/21 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_get_imba148()
DEFINE l_day          LIKE type_t.num5
DEFINE r_day          LIKE type_t.num5

  LET r_day = 0
  LET r_day = ((g_imba_m.imba102 * 30) + g_imba_m.imba103) * g_imba_m.imba147/100
    
  #CALL s_num_rounding('4',((g_imba_m.imba102 * 30) + g_imba_m.imba103) * g_imba_m.imba147/100,0) RETURNING r_day
  RETURN r_day
END FUNCTION

################################################################################
# Descriptions...: 檢查此庫存單位與銷售計價單位之間是否存在換算率
# Memo...........:
# Usage..........: CALL artt300_chk_imba106()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2015/05/25 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_chk_imba106()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014

   LET l_rate = ''

   LET r_success = TRUE
   IF g_imba_m.imba104 = g_imba_m.imba106 THEN
      RETURN r_success
   END IF

   CALL s_aimi190_get_convert(g_imba_m.imba001,g_imba_m.imba104,g_imba_m.imba106)
      RETURNING r_success,l_rate

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查此庫存單位與銷售單位之間是否存在換算率
# Memo...........:
# Usage..........: CALL artt300_chk_imba105()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2015/05/25 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_chk_imba105()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014

   LET l_rate = ''

   LET r_success = TRUE
   IF g_imba_m.imba104 = g_imba_m.imba105 THEN
      RETURN r_success
   END IF

   CALL s_aimi190_get_convert(g_imba_m.imba001,g_imba_m.imba104,g_imba_m.imba105)
      RETURNING r_success,l_rate

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查此庫存單位與採購單位之間是否存在換算率
# Memo...........:
# Usage..........: CALL artt300_chk_imba107()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
# Date & Author..: 2015/05/25 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_chk_imba107()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_rate        LIKE inaj_t.inaj014

   LET l_rate = ''

   LET r_success = TRUE
   IF g_imba_m.imba104 = g_imba_m.imba107 THEN
      RETURN r_success
   END IF

   CALL s_aimi190_get_convert(g_imba_m.imba001,g_imba_m.imba104,g_imba_m.imba107)
      RETURNING r_success,l_rate

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有多條碼的包裝單位已相同
# Memo...........:
# Usage..........: CALL artt300_imby005_chk_1()
#                  RETURNING r_success,l_imay005
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
#                  l_imby005       件裝數
# Date & Author..: 2015/06/02 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_imby005_chk_1()
DEFINE l_cnt        LIKE type_t.num5 
DEFINE l_imby005    LIKE imby_t.imby005
DEFINE r_success    LIKE type_t.num5

   LET l_imby005 = 0
   LET l_cnt = 0
   LET r_success = FALSE
   SELECT COUNT(*) INTO l_cnt 
     FROM imby_t
    WHERE imbyent = g_enterprise
      AND imby001 = g_imba_m.imba001
      AND imby004 = g_imby_d[l_ac].imby004      
      
   IF l_cnt != 0 THEN
      SELECT imby005 INTO l_imby005
        FROM imby_t
       WHERE imbyent = g_enterprise
         AND imby001 = g_imba_m.imba001
         AND imby004 = g_imby_d[l_ac].imby004       
      LET r_success = TRUE
   END IF
   
   RETURN r_success,l_imby005   
END FUNCTION

################################################################################
# Descriptions...: 檢查多條碼中的包裝單位是否已存在，且輸入的件裝數不等於已存在的件裝數
# Memo...........:
# Usage..........: CALL artt300_imby005_chk_2()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/03 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_imby005_chk_2()
DEFINE l_cnt        LIKE type_t.num5 
DEFINE r_success    LIKE type_t.num5

   LET l_cnt = 0
   LET r_success = TRUE
   SELECT COUNT(*) INTO l_cnt 
     FROM imby_t
    WHERE imbyent = g_enterprise
      AND imby001 = g_imba_m.imba001
      AND imby004 = g_imby_d[l_ac].imby004 
      AND imby005!= g_imby_d[l_ac].imby005      
      AND COALESCE(imby003,'-1') != COALESCE(g_imby_d[l_ac].imby003,'-1')   ##150703 pomelo add
   IF l_cnt != 0 THEN     
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 欄位顯示
# Memo...........: #160801-00017#4 20160805 add by beckxie
# Usage..........: CALL artt300_set_comp_visible_b()
# Date & Author..: 20160805 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION artt300_set_comp_visible_b()
   CALL cl_set_comp_visible("imby019,imby019_desc",TRUE)   #160801-00017#4 20160805 add by beckxie
END FUNCTION

################################################################################
# Descriptions...: 欄位不顯示
# Memo...........: #160801-00017#4 20160805 add by beckxie
# Usage..........: CALL artt300_set_comp_no_visible_b()
# Date & Author..: 20160805 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION artt300_set_comp_no_visible_b()
   #160801-00017#4 20160804 add by beckxie---S
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("imby019,imby019_desc",FALSE)
   END IF
   #160801-00017#4 20160804 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位為必填
# Memo...........: #160801-00017#4 20160805 add by beckxie
# Usage..........: CALL artt300_set_required_b(p_cmd)
# Date & Author..: 20160805 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_set_required_b(p_cmd)
   #160801-00017#4 20160804 add by beckxie---S
   DEFINE p_cmd LIKE type_t.chr1
   IF l_ac > 0 THEN
      #IF (NOT cl_null(g_imaa_m.imaa005)) AND g_imay_d[l_ac].imay002 = '3' THEN   #160822-00036#3 20160824 mark by beckxie
      IF (NOT cl_null(g_imba_m.imba005)) AND g_imby_d[l_ac].imby002 = '3'   #160822-00036#3 20160824 add by beckxie
          AND cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN      #160822-00036#3 20160824 add by beckxie
         CALL cl_set_comp_required("imby019",TRUE)
      END IF
   END IF
   #160801-00017#4 20160804 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位不為必填
# Memo...........: #160801-00017#4 20160805 add by beckxie
# Usage..........: CALL artt300_set_no_required_b(p_cmd)
# Date & Author..: 20160805 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_set_no_required_b(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   CALL cl_set_comp_required("imby019",FALSE)   #160801-00017#4 20160804 add by beckxie
END FUNCTION

################################################################################
# Descriptions...: 根據勾選的特徵自動生成多筆條碼資料
# Memo...........:
# Usage..........: CALL artt300_ins_imby(p_inam)
#                  RETURNING l_success
# Input parameter: p_inam         
# Return code....: l_success     TRUE/FALSE
# Date & Author..: #160803-00008#3 20160811 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION artt300_ins_imby(p_inam)
   DEFINE p_inam            DYNAMIC ARRAY OF RECORD   #記錄產品特徵
          inam001           LIKE inam_t.inam001,
          inam002           LIKE inam_t.inam002,
          inam004           LIKE inam_t.inam004
                            END RECORD
   DEFINE tok               base.StringTokenizer
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5 
   DEFINE l_imba016         LIKE imba_t.imba016
   DEFINE l_imba019         LIKE imba_t.imba019
   DEFINE l_imba020         LIKE imba_t.imba020
   DEFINE l_imba021         LIKE imba_t.imba021
   DEFINE l_imba025         LIKE imba_t.imba025
   DEFINE l_imby003         LIKE imby_t.imby003
   DEFINE l_imby018         LIKE imby_t.imby018
   DEFINE l_feature         STRING
   DEFINE l_sql             STRING
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = TRUE
   
   #預設值
   IF g_imba_m.imba108 = '3' THEN 
      LET l_imby018 = 1000
   ELSE    
      LET l_imby018 = 1
   END IF 
   
   #insert into imby_t
   LET l_sql = " INSERT INTO imby_t (imbyent , imbydocno, imby001 , imby002 , imby003 , ",
               "                     imby004 , imby005  , imby006 , imby007 , imby008 , ",
               "                     imby009 , imby010  , imby011 , imby012 , imby013 , ",
               "                     imby014 , imby015  , imby016 , imby017 , imbystus, ",
               "                     imby018 , imby019) ",
               " VALUES (",g_enterprise," , '",g_imba_m.imbadocno,"' , '",g_imby_d[l_ac].imby001,"' , '3', ?, ",
               "         '",g_imba_m.imba006,"' , 1 , 'N' ,?, ? , ",
               "         ? , ? , ? , '",g_imba_m.imba106,"' , '', ",
               "         '",g_imba_m.imba104,"' , '",g_imba_m.imba022,"' , '",g_imba_m.imba026,"' , '",g_imba_m.imba018,"' , 'Y', ",
               "         '",l_imby018,"' , ?) "
   DISPLAY "l_sql :",l_sql
   PREPARE artt300_ins_imby_pre FROM l_sql
   
   #FOR l_i = 2 TO p_inam.getLength()   #160822-00036#3 20160824 mark by beckxie
   FOR l_i = 1 TO p_inam.getLength()   #160822-00036#3 20160824 add by beckxie
      
      
      #特徵值去除底線
      CALL s_feature_get_feature_str(p_inam[l_i].inam002) RETURNING l_feature
      #組條碼(商品編號+特徵值)
      LET l_imby003 = g_imby_d[l_ac].imby001,l_feature
      
      #insert檢查是否重複
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM imby_t
       WHERE imbyent = g_enterprise
         AND imbydocno = g_imba_m.imbadocno
         AND imby003 = l_imby003
      IF l_cnt > 0 THEN
         #重複不insert
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00812'
         LET g_errparam.replace[1] = l_imby003
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOR
      END IF
      #insert into imby_t
      EXECUTE artt300_ins_imby_pre USING l_imby003       ,g_imba_m.imba019  ,g_imba_m.imba020, g_imba_m.imba021 , g_imba_m.imba025,
                                         g_imba_m.imba016,p_inam[l_i].inam002
      IF SQLCA.sqlcode THEN
        LET r_success = FALSE
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "EXECUTE:artt300_ins_imby_pre"
        LET g_errparam.popup = TRUE
        CALL cl_err()
      END IF
      
   END FOR
   
   RETURN r_success
END FUNCTION

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="afai100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0047(2017-02-04 09:22:03), PR版次:0047(2017-02-09 09:44:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000863
#+ Filename...: afai100
#+ Description: 固定資產維護作業
#+ Creator....: 02114(2014-02-20 14:33:00)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="afai100.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#150825 By albireo 整測追回:faaj019  預留殘值不論狀況開放修改; 修正部分欄位開關位置到標準位置呼叫
#150923 15/09/28   By 03538      更改耐用年限時,重新推算殘值率,並以殘值率推算預留殘值
#150916-00015#1  2015/12/7 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160328-00001#1  2016/03/28 By 07673   查询状态下，显示的笔数不对
#160406-00003#1  2016/04/07 By 07673   查询状态下，显示的笔数不对
#160318-00025#4  2016/04/12 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160415-00009#1  2016/04/15 By Dido    取消資產性質為 5.費用的數量限制
#160408-00020#1  2016/04/22 By 01531   新增栏位faah050,faah054,faah055
#160426-00014#8  2016/07/22 By 01531   增加列管与列帐,scc-9897，默认值为2：列账
#160426-00014#5  2016/08/01 By 01531   SCC-9912增加4：依标签部门分摊
#160812-00017#6  2016/08/19  By 06814  在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 
#                                      造成transaction沒有結束就直接RETURN
#160905-00007#1  2016-09-05  By08734   ent调整
#160826-00013#1  2016/09/20 By 01531   1:修改折毕再提Y-->N时，清空折毕再提年月和折毕再提预留残值
#160922-00040#1  2016/09/23 By lujh    作废按钮无法作废
#160923-00019#1  2016/09/27 By lujh    afap200抛转产生afai100的资料,要开放faah017栏位供修改
#160918-00015#1  2016/10/10 By lujh    查询时有些资料会提示错误讯息：取汇率元件的第二参数：营运据点或账套编号为空
#161009-00006#1  2016/10/12 By 02114   1、afai100：1）卡编自动编码时，抓取max（卡编）要按归属法人来抓；
#                                                  2）如果修改所有组织栏位导致归属法人变化，
#                                                     要按照新的归属法人在aooi020中设置的卡编编码规则重新处理卡编。
#                                      2、afai100：管理组织需限定为资产组织(ooef207=Y)，核算组织不需限定为法人（去掉ooef003=Y的条件）。
#161024-00008#1  2016/10/24 By Hans    AFA組織類型與職能開窗清單調整。
#161017-00023#1  2016/10/26 By 02114   权限调整
#161108-00038#1  2016/11/08 By 01727   单头账款单号串联增加账套条件(主财务账套） 单身(faaj)账款单号增加串联
#161111-00049#5  2016/11/12 By 01531   一阶段FA问题7~14 调整作业:afai100/afai120/afat509/afaq110/afaq120/afaq130/afaq150/afaq151/afaq152
#161104-00048#1  2016/11/21 By 01531   画面在[账套折旧信息]页签下新增‘资产状态’栏位，放在‘分摊方式’上面。新增时，default 单头的资产状态faah015。
#161121-00003#3  2016/11/23 By 01531   当列管/列账=1.列管时，折旧方式固定为5:不计提折旧，只读
#161104-00048#9  2016/11/24 By 01531   审核更新资产状态faah015=1.资本化时要一并更新faaj038=1.资本化。
#161129-00055#1  2016/11/30 By 01531   问题： 新增固定资产卡片时，如果币种faah020为外币，则自动编码会报错，流水号无法生成。
#161116-00036#1  2016/11/30 By 02599   删除时一并删除faai中对应的数据。
#161129-00046#1  2016/12/02 By 02599   修正：当类型为主机 && 参数'S-FIN-9010'財编自动编号否=Y && 'S-FIN-9002'参数财产编号预设是否与卡片编号一致=N时，财产编号才可自动编码
#161205-00051#1  2016/12/06 By 02114   核算项页签的营运据点栏位检查不存在于账套法人下,其实是存在的
#161208-00075#1  2016/12/12 By 02114   1.单头汇率显示账套折旧信息主账套的汇率
#                                      2.汇率按取得日期抓取
#161230-00018#1  2017/01/04 By 02114   新增完单头与账套折旧信息后,不点确认,再回单头栏位
#170117-00026#1  2017/01/17 By 01531   afai100 资产科目、累折科目、折旧科目、减值准备科目 改成site的主账套取科目表 
#160426-00014#15 2017/02/04 By 01531   新增雜發單號faah057
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
PRIVATE TYPE type_g_faah_m RECORD
       faah001 LIKE faah_t.faah001, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah002 LIKE faah_t.faah002, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr80, 
   faah007 LIKE faah_t.faah007, 
   faah007_desc LIKE type_t.chr80, 
   faah005 LIKE faah_t.faah005, 
   faahstus LIKE faah_t.faahstus, 
   faah014 LIKE faah_t.faah014, 
   faah015 LIKE faah_t.faah015, 
   faah016 LIKE faah_t.faah016, 
   faah017 LIKE faah_t.faah017, 
   faah017_desc LIKE type_t.chr80, 
   faah018 LIKE faah_t.faah018, 
   faah019 LIKE faah_t.faah019, 
   faah020 LIKE faah_t.faah020, 
   faah020_desc LIKE type_t.chr80, 
   faah021 LIKE faah_t.faah021, 
   faah022 LIKE faah_t.faah022, 
   faaj015_desc LIKE type_t.num26_10, 
   faah023 LIKE faah_t.faah023, 
   faah024 LIKE faah_t.faah024, 
   faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr80, 
   faah026 LIKE faah_t.faah026, 
   faah026_desc LIKE type_t.chr80, 
   faah027 LIKE faah_t.faah027, 
   faah027_desc LIKE type_t.chr80, 
   faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr80, 
   faah030 LIKE faah_t.faah030, 
   faah030_desc LIKE type_t.chr80, 
   faah031 LIKE faah_t.faah031, 
   faah031_desc LIKE type_t.chr80, 
   faah032 LIKE faah_t.faah032, 
   faah032_desc LIKE type_t.chr80, 
   faah029 LIKE faah_t.faah029, 
   faah029_desc LIKE type_t.chr80, 
   faah009 LIKE faah_t.faah009, 
   faah009_desc LIKE type_t.chr80, 
   faah000 LIKE faah_t.faah000, 
   faah010 LIKE faah_t.faah010, 
   faah010_desc LIKE type_t.chr80, 
   faah011 LIKE faah_t.faah011, 
   faah011_desc LIKE type_t.chr80, 
   faah046 LIKE faah_t.faah046, 
   faah033 LIKE faah_t.faah033, 
   faah008 LIKE faah_t.faah008, 
   faah008_desc LIKE type_t.chr80, 
   faah042 LIKE faah_t.faah042, 
   faah035 LIKE faah_t.faah035, 
   faah036 LIKE faah_t.faah036, 
   faah037 LIKE faah_t.faah037, 
   faah043 LIKE faah_t.faah043, 
   faah044 LIKE faah_t.faah044, 
   faah041 LIKE faah_t.faah041, 
   faah041_desc LIKE type_t.chr80, 
   faah038 LIKE faah_t.faah038, 
   faah039 LIKE faah_t.faah039, 
   faah040 LIKE faah_t.faah040, 
   faah057 LIKE faah_t.faah057, 
   faah050 LIKE faah_t.faah050, 
   faah054 LIKE faah_t.faah054, 
   faah055 LIKE faah_t.faah055, 
   faahownid LIKE faah_t.faahownid, 
   faahownid_desc LIKE type_t.chr80, 
   faahowndp LIKE faah_t.faahowndp, 
   faahowndp_desc LIKE type_t.chr80, 
   faahcrtid LIKE faah_t.faahcrtid, 
   faahcrtid_desc LIKE type_t.chr80, 
   faahcrtdt LIKE faah_t.faahcrtdt, 
   faahcrtdp LIKE faah_t.faahcrtdp, 
   faahcrtdp_desc LIKE type_t.chr80, 
   faahmodid LIKE faah_t.faahmodid, 
   faahmodid_desc LIKE type_t.chr80, 
   faahmoddt LIKE faah_t.faahmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_faah000 LIKE faah_t.faah000,
      b_faah003 LIKE faah_t.faah003,
      b_faah004 LIKE faah_t.faah004,
      b_faah001 LIKE faah_t.faah001,
      b_faah002 LIKE faah_t.faah002,
      b_faah012 LIKE faah_t.faah012,
      b_faah013 LIKE faah_t.faah013,
      b_faah021 LIKE faah_t.faah021,
      b_faah022 LIKE faah_t.faah022,
      b_faah024 LIKE faah_t.faah024,
   b_faaj017 LIKE faaj_t.faaj017,
   b_faaj019 LIKE faaj_t.faaj019,
   b_faaj028 LIKE faaj_t.faaj028,
      b_faah028 LIKE faah_t.faah028,
   b_faah028_desc LIKE type_t.chr80,
      b_faah032 LIKE faah_t.faah032,
   b_faah032_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef017        LIKE ooef_t.ooef017
DEFINE g_ooef011        LIKE ooef_t.ooef011   #150923
DEFINE g_glaald         LIKE glaa_t.glaald
DEFINE g_para_data      LIKE type_t.chr80     #卡片編號是否自動編號
DEFINE g_para_data1     LIKE type_t.chr80     #折舊費用科目取值
DEFINE g_para_data2     LIKE type_t.chr80 
DEFINE g_para_data3     LIKE type_t.chr80 
DEFINE g_ooan005        LIKE ooan_t.ooan005
DEFINE g_wc3            STRING
 type type_g_faaj_m        RECORD
        faajld              LIKE faaj_t.faajld,
        faajld_desc         LIKE type_t.chr80,
        faaj000             LIKE faaj_t.faaj000,
        faaj001             LIKE faaj_t.faaj001,
        faaj002             LIKE faaj_t.faaj002,
        faaj037             LIKE faaj_t.faaj037,
        glaacomp            LIKE glaa_t.glaacomp,
        glaacomp_desc       LIKE type_t.chr80,    
        glaa004             LIKE glaa_t.glaa004,
        glaa004_desc        LIKE type_t.chr80,
        faaj006             LIKE faaj_t.faaj006,
        faaj007             LIKE faaj_t.faaj007,
        faaj007_desc        LIKE type_t.chr80,
        faaj023             LIKE faaj_t.faaj023,
        faaj023_desc        LIKE type_t.chr80,
        faaj024             LIKE faaj_t.faaj024,
        faaj024_desc        LIKE type_t.chr80,
        faaj025             LIKE faaj_t.faaj025,
        faaj025_desc        LIKE type_t.chr80,
        faaj026             LIKE faaj_t.faaj026,
        faaj026_desc        LIKE type_t.chr80,
        faaj003             LIKE faaj_t.faaj003,
        faaj004             LIKE faaj_t.faaj004,
        faaj005             LIKE faaj_t.faaj005,
        faaj038             LIKE faaj_t.faaj038,
        faaj008             LIKE faaj_t.faaj008,
        faaj009             LIKE faaj_t.faaj009,
        faaj010             LIKE faaj_t.faaj010,
        faaj014             LIKE faaj_t.faaj014,
        faaj015             LIKE faaj_t.faaj015,
        faaj016             LIKE faaj_t.faaj016,
        faaj017             LIKE faaj_t.faaj017,
        faaj018             LIKE faaj_t.faaj018,
        faaj019             LIKE faaj_t.faaj019,
        faaj020             LIKE faaj_t.faaj020,
        faaj022             LIKE faaj_t.faaj022,
        faaj033             LIKE faaj_t.faaj033,
        faaj034             LIKE faaj_t.faaj034,
        faaj035             LIKE faaj_t.faaj035,
        faaj032             LIKE faaj_t.faaj032,
        faaj027             LIKE faaj_t.faaj027,
        faaj021             LIKE faaj_t.faaj021,
        faaj029             LIKE faaj_t.faaj029,
        faaj028             LIKE faaj_t.faaj028,
        faaj011             LIKE faaj_t.faaj011,
        faaj013             LIKE faaj_t.faaj013,
        faaj012             LIKE faaj_t.faaj012,
        faaj106             LIKE faaj_t.faaj106,
        faaj156             LIKE faaj_t.faaj156,
        faaj042             LIKE faaj_t.faaj042,
        faaj042_desc        LIKE type_t.chr80,
        faaj043             LIKE faaj_t.faaj043,
        faaj043_desc        LIKE type_t.chr80,
        faaj045             LIKE faaj_t.faaj045,
        faaj045_desc        LIKE type_t.chr80,
        faaj046             LIKE faaj_t.faaj046,
        faaj046_desc        LIKE type_t.chr80,
        faaj030             LIKE faaj_t.faaj030,
        faajsite            LIKE faaj_t.faajsite,
        faajsite_desc       LIKE type_t.chr80,
        faaj101             LIKE faaj_t.faaj101,
        faaj102             LIKE faaj_t.faaj102,
        faaj103             LIKE faaj_t.faaj103,
        faaj104             LIKE faaj_t.faaj104,
        faaj111             LIKE faaj_t.faaj111,
        faaj105             LIKE faaj_t.faaj105,
        faaj117             LIKE faaj_t.faaj117,
        faaj107             LIKE faaj_t.faaj107,
        faaj109             LIKE faaj_t.faaj109,
        faaj108             LIKE faaj_t.faaj108,
        faaj113             LIKE faaj_t.faaj113,
        faaj114             LIKE faaj_t.faaj114,
        faaj115             LIKE faaj_t.faaj115,
        faaj110             LIKE faaj_t.faaj110,
        faaj112             LIKE faaj_t.faaj112,
        faaj151             LIKE faaj_t.faaj151,
        faaj152             LIKE faaj_t.faaj152,
        faaj153             LIKE faaj_t.faaj153,
        faaj154             LIKE faaj_t.faaj154,
        faaj161             LIKE faaj_t.faaj161,
        faaj155             LIKE faaj_t.faaj155,
        faaj167             LIKE faaj_t.faaj167,
        faaj157             LIKE faaj_t.faaj157,
        faaj159             LIKE faaj_t.faaj159,
        faaj158             LIKE faaj_t.faaj158,
        faaj163             LIKE faaj_t.faaj163,
        faaj164             LIKE faaj_t.faaj164,
        faaj165             LIKE faaj_t.faaj165,
        faaj160             LIKE faaj_t.faaj160,
        faaj162             LIKE faaj_t.faaj162,
        faaj048             LIKE faaj_t.faaj048  #160426-00014#8
       END RECORD
DEFINE g_faaj_m             type_g_faaj_m
DEFINE g_faaj_m_t           type_g_faaj_m
DEFINE g_faaj_m_o           type_g_faaj_m     #add by huangtao
DEFINE g_faajld_t           LIKE faaj_t.faajld
DEFINE g_faaj001_t          LIKE faaj_t.faaj001
DEFINE g_faaj002_t          LIKE faaj_t.faaj002
DEFINE g_browser_cnt1       LIKE type_t.num5
DEFINE g_browser_idx1       LIKE type_t.num5
DEFINE g_header_cnt1        LIKE type_t.num5
DEFINE g_current_idx1       LIKE type_t.num10    
DEFINE g_current_cnt1       LIKE type_t.num10
DEFINE g_current_row1       LIKE type_t.num5
DEFINE g_jump1              LIKE type_t.num10        
DEFINE g_no_ask1            LIKE type_t.num5   
DEFINE g_page_action1       STRING
DEFINE g_pagestart1         LIKE type_t.num5

DEFINE g_glaa001            LIKE glaa_t.glaa001
DEFINE g_glaa015            LIKE glaa_t.glaa015
DEFINE g_glaa016            LIKE glaa_t.glaa016
DEFINE g_glaa017            LIKE glaa_t.glaa017
DEFINE g_glaa018            LIKE glaa_t.glaa018
DEFINE g_glaa019            LIKE glaa_t.glaa019
DEFINE g_glaa020            LIKE glaa_t.glaa020
DEFINE g_glaa021            LIKE glaa_t.glaa021
DEFINE g_glaa022            LIKE glaa_t.glaa022
DEFINE g_glaa025            LIKE glaa_t.glaa025

DEFINE g_glaa001_1          LIKE glaa_t.glaa001
DEFINE g_glaa025_1          LIKE glaa_t.glaa025

DEFINE g_faac016            LIKE faac_t.faac016
DEFINE g_faac003            LIKE faac_t.faac003
DEFINE g_faac004            LIKE faac_t.faac004

DEFINE g_faal005            LIKE faal_t.faal005
DEFINE g_browser1    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
         b_statepic     LIKE type_t.chr50,
         b_faajld       LIKE faaj_t.faajld,
         b_faaj000 LIKE faaj_t.faaj000,
         b_faaj001 LIKE faaj_t.faaj001,
         b_faaj002 LIKE faaj_t.faaj002,
         b_faaj037 LIKE faaj_t.faaj037
         #,rank           LIKE type_t.num10
      END RECORD 
      
DEFINE gs_act_visible_on   STRING                    #是否維護g_act_visible array
DEFINE g_act_visible       DYNAMIC ARRAY OF RECORD   #記錄哪些action要隱藏或顯示
             name          STRING,
             value         LIKE type_t.num5
                           END RECORD

DEFINE g_faaj019           LIKE faaj_t.faaj019 

 TYPE type_g_faai_d_1        RECORD
   faai000 LIKE faai_t.faai000,
   faai001 LIKE faai_t.faai001,
   faai002 LIKE faai_t.faai002,
   faai003 LIKE faai_t.faai003,
   faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai010 LIKE faai_t.faai010, 
   faai009 LIKE faai_t.faai009, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai016 LIKE faai_t.faai016, 
   faai017 LIKE faai_t.faai017, 
   faai018 LIKE faai_t.faai018, 
   faai019 LIKE faai_t.faai019, 
   faai020 LIKE faai_t.faai020, 
   faai021 LIKE faai_t.faai021, 
   faai022 LIKE faai_t.faai022, 
   faai023 LIKE faai_t.faai023
       END RECORD
       
DEFINE g_faai_d_1          DYNAMIC ARRAY OF type_g_faai_d_1
DEFINE g_faai_d_1_t        type_g_faai_d_1
DEFINE g_faai_d_1_o        type_g_faai_d_1
DEFINE g_comp              LIKE ooef_t.ooef017
DEFINE g_wc2               STRING 
DEFINE g_detail_cnt        LIKE type_t.num10
DEFINE g_insert            LIKE type_t.chr1
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE gs_keys             DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak         DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_loc               LIKE type_t.chr1
DEFINE g_current_page      LIKE type_t.num5 
DEFINE g_update            BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_wc4               STRING 
DEFINE g_wc_cs_ld          STRING           #161017-00023#1 add lujh
#end add-point
 
#模組變數(Module Variables)
DEFINE g_faah_m        type_g_faah_m  #單頭變數宣告
DEFINE g_faah_m_t      type_g_faah_m  #單頭舊值宣告(系統還原用)
DEFINE g_faah_m_o      type_g_faah_m  #單頭舊值宣告(其他用途)
DEFINE g_faah_m_mask_o type_g_faah_m  #轉換遮罩前資料
DEFINE g_faah_m_mask_n type_g_faah_m  #轉換遮罩後資料
 
   DEFINE g_faah001_t LIKE faah_t.faah001
DEFINE g_faah003_t LIKE faah_t.faah003
DEFINE g_faah004_t LIKE faah_t.faah004
DEFINE g_faah000_t LIKE faah_t.faah000
 
   
 
   
 
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
 
{<section id="afai100.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success    LIKE type_t.num5   #add--2015/03/20 By shiun
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT faah001,faah003,faah004,faah002,faah012,faah013,faah006,'',faah007,'', 
       faah005,faahstus,faah014,faah015,faah016,faah017,'',faah018,faah019,faah020,'',faah021,faah022, 
       '',faah023,faah024,faah025,'',faah026,'',faah027,'',faah028,'',faah030,'',faah031,'',faah032, 
       '',faah029,'',faah009,'',faah000,faah010,'',faah011,'',faah046,faah033,faah008,'',faah042,faah035, 
       faah036,faah037,faah043,faah044,faah041,'',faah038,faah039,faah040,faah057,faah050,faah054,faah055, 
       faahownid,'',faahowndp,'',faahcrtid,'',faahcrtdt,faahcrtdp,'',faahmodid,'',faahmoddt", 
                      " FROM faah_t",
                      " WHERE faahent= ? AND faah000=? AND faah001=? AND faah003=? AND faah004=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afai100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.faah001,t0.faah003,t0.faah004,t0.faah002,t0.faah012,t0.faah013,t0.faah006, 
       t0.faah007,t0.faah005,t0.faahstus,t0.faah014,t0.faah015,t0.faah016,t0.faah017,t0.faah018,t0.faah019, 
       t0.faah020,t0.faah021,t0.faah022,t0.faah023,t0.faah024,t0.faah025,t0.faah026,t0.faah027,t0.faah028, 
       t0.faah030,t0.faah031,t0.faah032,t0.faah029,t0.faah009,t0.faah000,t0.faah010,t0.faah011,t0.faah046, 
       t0.faah033,t0.faah008,t0.faah042,t0.faah035,t0.faah036,t0.faah037,t0.faah043,t0.faah044,t0.faah041, 
       t0.faah038,t0.faah039,t0.faah040,t0.faah057,t0.faah050,t0.faah054,t0.faah055,t0.faahownid,t0.faahowndp, 
       t0.faahcrtid,t0.faahcrtdt,t0.faahcrtdp,t0.faahmodid,t0.faahmoddt,t1.faacl003 ,t2.faadl003 ,t3.oocal003 , 
       t4.ooail003 ,t5.ooag011 ,t6.ooefl003 ,t7.oocql004 ,t8.ooefl003 ,t9.ooefl003 ,t10.ooefl003 ,t11.ooefl003 , 
       t12.ooag011 ,t13.pmaal004 ,t14.pmaal004 ,t15.oocgl003 ,t16.oocql004 ,t17.ooefl003 ,t18.ooag011 , 
       t19.ooefl003 ,t20.ooag011 ,t21.ooefl003 ,t22.ooag011",
               " FROM faah_t t0",
                              " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=t0.faah006 AND t1.faacl002='"||g_dlang||"' ",
               " LEFT JOIN faadl_t t2 ON t2.faadlent="||g_enterprise||" AND t2.faadl001=t0.faah007 AND t2.faadl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.faah017 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.faah020 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.faah025  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.faah026 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='3900' AND t7.oocql002=t0.faah027 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.faah028 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.faah030 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.faah031 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.faah032 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.faah029  ",
               " LEFT JOIN pmaal_t t13 ON t13.pmaalent="||g_enterprise||" AND t13.pmaal001=t0.faah009 AND t13.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.faah010 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t15 ON t15.oocglent="||g_enterprise||" AND t15.oocgl001=t0.faah011 AND t15.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='3903' AND t16.oocql002=t0.faah008 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.faah041 AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.faahownid  ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=t0.faahowndp AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.faahcrtid  ",
               " LEFT JOIN ooefl_t t21 ON t21.ooeflent="||g_enterprise||" AND t21.ooefl001=t0.faahcrtdp AND t21.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t22 ON t22.ooagent="||g_enterprise||" AND t22.ooag001=t0.faahmodid  ",
 
               " WHERE t0.faahent = " ||g_enterprise|| " AND t0.faah000 = ? AND t0.faah001 = ? AND t0.faah003 = ? AND t0.faah004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afai100_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afai100 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afai100_init()   
 
      #進入選單 Menu (="N")
      CALL afai100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afai100
      
   END IF 
   
   CLOSE afai100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afai100.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afai100_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
      DEFINE l_ooag004       LIKE ooag_t.ooag004
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('faahstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('faah002','9911') 
   CALL cl_set_combo_scc('faah005','9903') 
   CALL cl_set_combo_scc('faah015','9914') 
   CALL cl_set_combo_scc('faah016','9913') 
   CALL cl_set_combo_scc('faah042','9917') 
   CALL cl_set_combo_scc('faah035','9906') 
   CALL cl_set_combo_scc('faah036','9907') 
   CALL cl_set_combo_scc('faah037','9908') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
      CALL cl_set_combo_scc('faah002','9911') 
   CALL cl_set_combo_scc('faah005','9903')
   CALL cl_set_combo_scc('faah015','9914') 
   CALL cl_set_combo_scc('faah016','9913') 
   CALL cl_set_combo_scc('faah042','9917') 
#   CALL cl_set_combo_scc('faah034','9905')
   CALL cl_set_combo_scc('faah035','9906')
   CALL cl_set_combo_scc('faah036','9907')
   #CALL cl_set_combo_scc('faah037','9908')                 #151202-00004#3 mark lujh
   CALL cl_set_combo_scc_part('faah037','9908','1,2,3,4')   #151202-00004#3 add lujh
  #CALL cl_set_combo_scc('faaj006','9912')   #yangtt 2015/6/3 取消分攤方式3.被分攤
   CALL cl_set_combo_scc_part('faaj006','9912','1,2,4') #160426-00014#5 add 4
   CALL cl_set_combo_scc('faaj003','9904') 
   CALL cl_set_combo_scc('faai023','9914')
   CALL cl_set_combo_scc('faaj038','9914')
   CALL cl_set_combo_scc('b_faah002','9911') 
   CALL cl_set_combo_scc('faah054','9909')   #160408-00020#1 
   LET g_faah_m.faah054 = '0'                #160408-00020#1
   CALL cl_set_combo_scc('faaj048','9897')   #160426-00014#8 
   #CALL cl_set_combo_scc_part('faaj038','9914','0,2,4,7,9') #161104-00048#1 add #161104-00048#9 mark
   CALL cl_set_combo_scc_part('faaj038','9914','0,1,2,4,7,9')#161104-00048#9 add
   
   LET g_faaj_m.faaj038 = '0'     #161104-00048#1 add 
   
   SELECT ooag004 INTO l_ooag004
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_user
   
   SELECT ooef017 INTO g_ooef017 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
#      AND ooef001 = l_ooag004
   
   SELECT glaa001,glaald,glaa025
     INTO g_glaa001,g_glaald,g_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_ooef017
      AND glaa014 = 'Y'
#   mark by yangxf
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9010') RETURNING g_para_data3
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
#   mark by yangxf
#  add by yangxf
   #########################mark by huangtao
   #取归属法人
   #SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
   #CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
   #CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
   #CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9010') RETURNING g_para_data3  #財编自动编号否
   #########################mark by huangtao
   CALL afai100_init_para()
#  add by yangxf
   CALL cl_set_comp_entry("faah032","FALSE")
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afai100_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afai100_ui_dialog() 
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
   DEFINE l_apca001 LIKE apca_t.apca001
   DEFINE l_glaald  LIKE glaa_t.glaald   #161108-00038#1 Add
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
            CALL afai100_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_faah_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afai100_init()
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
               CALL afai100_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afai100_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"

            ON ACTION first1
               CALL afai100_fetch1("F") 
               LET g_current_row1 = g_current_idx1
            
            ON ACTION next1
               CALL afai100_fetch1("N")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION jump1
               CALL afai100_fetch1("/")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION previous1
               CALL afai100_fetch1("P")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION last1
               CALL afai100_fetch1("L")  
               LET g_current_row1 = g_current_idx1
               
            ON ACTION first2
               CALL afai100_fetch1("F") 
               LET g_current_row1 = g_current_idx1
            
            ON ACTION next2
               CALL afai100_fetch1("N")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION jump2
               CALL afai100_fetch1("/")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION previous2
               CALL afai100_fetch1("P")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION last2
               CALL afai100_fetch1("L")  
               LET g_current_row1 = g_current_idx1
               
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afai100_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afai100_set_act_visible()
               CALL afai100_set_act_no_visible()
               IF NOT (g_faah_m.faah000 IS NULL
                 OR g_faah_m.faah001 IS NULL
                 OR g_faah_m.faah003 IS NULL
                 OR g_faah_m.faah004 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " faahent = " ||g_enterprise|| " AND",
                                     " faah000 = '", g_faah_m.faah000, "' "
                                     ," AND faah001 = '", g_faah_m.faah001, "' "
                                     ," AND faah003 = '", g_faah_m.faah003, "' "
                                     ," AND faah004 = '", g_faah_m.faah004, "' "
 
                  #填到對應位置
                  CALL afai100_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afai100_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afai100_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afai100_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afai100_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afai100_fetch("L")  
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
                  CALL afai100_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afai100_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afai100_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai100_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afai100_03
            LET g_action_choice="afai100_03"
            IF cl_auth_chk_act("afai100_03") THEN
               
               #add-point:ON ACTION afai100_03 name="menu2.afai100_03"
               CALL afai100_ui_dialog_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afai100_04
            LET g_action_choice="afai100_04"
            IF cl_auth_chk_act("afai100_04") THEN
               
               #add-point:ON ACTION afai100_04 name="menu2.afai100_04"
               IF g_faah_m.faahstus = 'Y' THEN 
                  LET la_param.prog = 'afaq120'
                  LET la_param.param[1] = g_faah_m.faah000
                  LET la_param.param[2] = g_faah_m.faah001
                  LET la_param.param[3] = g_faah_m.faah003
                  LET la_param.param[4] = g_faah_m.faah004  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afai100_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afai100_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_del
            LET g_action_choice="depreciation_del"
            IF cl_auth_chk_act("depreciation_del") THEN
               
               #add-point:ON ACTION depreciation_del name="menu2.depreciation_del"
               IF NOT cl_null(g_faaj_m.faajld) THEN 
                  CALL afai100_faaj_del()
                  CALL afai100_browser_fill1('F')
                  IF g_browser_cnt1 <> 0 THEN 
                     CALL afai100_fetch1('F')         
                  END IF
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_ins
            LET g_action_choice="depreciation_ins"
            IF cl_auth_chk_act("depreciation_ins") THEN
               
               #add-point:ON ACTION depreciation_ins name="menu2.depreciation_ins"
               IF NOT cl_null(g_faah_m.faah003) THEN 
                  CALL afai100_depreciation('a')
                  CALL afai100_browser_fill1('F')
                  IF g_browser_cnt1 <> 0 THEN 
                     CALL afai100_fetch1('F')        
                  END IF                      
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               IF NOT cl_null(g_faah_m.faah003) THEN 
                  CALL afar100_g01(' 1=1',g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah001)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afai100_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_upd
            LET g_action_choice="depreciation_upd"
            IF cl_auth_chk_act("depreciation_upd") THEN
               
               #add-point:ON ACTION depreciation_upd name="menu2.depreciation_upd"
               IF NOT cl_null(g_faaj_m.faajld) THEN 
                  CALL afai100_depreciation('u')
                  CALL afai100_browser_fill1('F')
                  IF g_browser_cnt1 <> 0 THEN 
                     CALL afai100_fetch1('F')         
                  END IF
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afai100_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah025
            LET g_action_choice="prog_faah025"
            IF cl_auth_chk_act("prog_faah025") THEN
               
               #add-point:ON ACTION prog_faah025 name="menu2.prog_faah025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faah_m.faah025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah029
            LET g_action_choice="prog_faah029"
            IF cl_auth_chk_act("prog_faah029") THEN
               
               #add-point:ON ACTION prog_faah029 name="menu2.prog_faah029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faah_m.faah025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah038
            LET g_action_choice="prog_faah038"
            IF cl_auth_chk_act("prog_faah038") THEN
               
               #add-point:ON ACTION prog_faah038 name="menu2.prog_faah038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_faah_m.faah038

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah039
            LET g_action_choice="prog_faah039"
            IF cl_auth_chk_act("prog_faah039") THEN
               
               #add-point:ON ACTION prog_faah039 name="menu2.prog_faah039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_faah_m.faah039

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah040
            LET g_action_choice="prog_faah040"
            IF cl_auth_chk_act("prog_faah040") THEN
               
               #add-point:ON ACTION prog_faah040 name="menu2.prog_faah040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #161108-00038#1 Add  ---(S)---
               SELECT glaald INTO l_glaald FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaa014 = 'Y'
                  AND glaacomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = g_enterprise
                                      AND ooef001 = g_faah_m.faah028)
               #161108-00038#1 Add  ---(E)---
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent   = g_enterprise
                  AND apcadocno = g_faah_m.faah040
                  AND apcald    = l_glaald   #161108-00038#1 Add
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faah_m.faah040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faah_m.faah040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--str
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--end
               END CASE 
               #150803-00012#1 20150806--add--str
               IF cl_null(l_apca001) THEN 
                  SELECT faba003 INTO l_apca001
                    FROM faba_t
                   WHERE fabaent = g_enterprise
                     AND fabadocno = g_faah_m.faah040
               END IF
               IF l_apca001 = '20' THEN
                  #應用 a41 樣板自動產生(Version:2)
                  #使用JSON格式組合參數與作業編號(串查)
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'afat460'
                  LET la_param.param[1] = g_faah_m.faah040
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #150803-00012#1 20150806--add--end 
            END IF 

         ON ACTION prog_faaj030
            LET g_action_choice="prog_faaj030"
            IF cl_auth_chk_act("prog_faaj030") THEN
               
               #add-point:ON ACTION prog_faaj030
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_faaj_m.faaj030
                  AND apcald    = g_faaj_m.faajld                   #161108-00038#1 Add
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [3]
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [3]
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #161108-00038#1 Add  ---(S)---
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #161108-00038#1 Add ---(E)---
               END CASE
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah057
            LET g_action_choice="prog_faah057"
            IF cl_auth_chk_act("prog_faah057") THEN
               
               #add-point:ON ACTION prog_faah057 name="menu2.prog_faah057"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint301'
               LET la_param.param[1] = g_faah_m.faah057

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afai100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afai100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afai100_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
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
                  CALL afai100_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afai100_browser_fill(g_wc,"")
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
                  CALL afai100_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afai100_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afai100_set_act_visible()
               CALL afai100_set_act_no_visible()
               IF NOT (g_faah_m.faah000 IS NULL
                 OR g_faah_m.faah001 IS NULL
                 OR g_faah_m.faah003 IS NULL
                 OR g_faah_m.faah004 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " faahent = " ||g_enterprise|| " AND",
                                     " faah000 = '", g_faah_m.faah000, "' "
                                     ," AND faah001 = '", g_faah_m.faah001, "' "
                                     ," AND faah003 = '", g_faah_m.faah003, "' "
                                     ," AND faah004 = '", g_faah_m.faah004, "' "
 
                  #填到對應位置
                  CALL afai100_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL afai100_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL afai100_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afai100_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afai100_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afai100_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afai100_fetch("L")  
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
                  CALL afai100_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afai100_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afai100_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai100_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afai100_03
            LET g_action_choice="afai100_03"
            IF cl_auth_chk_act("afai100_03") THEN
               
               #add-point:ON ACTION afai100_03 name="menu.afai100_03"
               CALL afai100_ui_dialog_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION afai100_04
            LET g_action_choice="afai100_04"
            IF cl_auth_chk_act("afai100_04") THEN
               
               #add-point:ON ACTION afai100_04 name="menu.afai100_04"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afai100_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afai100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_del
            LET g_action_choice="depreciation_del"
            IF cl_auth_chk_act("depreciation_del") THEN
               
               #add-point:ON ACTION depreciation_del name="menu.depreciation_del"
               CALL afai100_faaj_del()
               CALL afai100_browser_fill1('F')
               IF g_browser_cnt1 <> 0 THEN 
                  CALL afai100_fetch1('F')         
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_ins
            LET g_action_choice="depreciation_ins"
            IF cl_auth_chk_act("depreciation_ins") THEN
               
               #add-point:ON ACTION depreciation_ins name="menu.depreciation_ins"
               CALL afai100_depreciation('a')
               CALL afai100_browser_fill1('F')
               IF g_browser_cnt1 <> 0 THEN 
                  CALL afai100_fetch1('F')         
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               IF NOT cl_null(g_faah_m.faah003) THEN 
                  CALL afar100_g01(' 1=1',g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah001)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               IF NOT cl_null(g_faah_m.faah003) THEN 
                  CALL afar100_g01(' 1=1',g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah001)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afai100_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION depreciation_upd
            LET g_action_choice="depreciation_upd"
            IF cl_auth_chk_act("depreciation_upd") THEN
               
               #add-point:ON ACTION depreciation_upd name="menu.depreciation_upd"
               CALL afai100_depreciation('u')
               CALL afai100_browser_fill1('F')
               IF g_browser_cnt1 <> 0 THEN 
                  CALL afai100_fetch1('F')         
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afai100_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah025
            LET g_action_choice="prog_faah025"
            IF cl_auth_chk_act("prog_faah025") THEN
               
               #add-point:ON ACTION prog_faah025 name="menu.prog_faah025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faah_m.faah025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah029
            LET g_action_choice="prog_faah029"
            IF cl_auth_chk_act("prog_faah029") THEN
               
               #add-point:ON ACTION prog_faah029 name="menu.prog_faah029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faah_m.faah025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah038
            LET g_action_choice="prog_faah038"
            IF cl_auth_chk_act("prog_faah038") THEN
               
               #add-point:ON ACTION prog_faah038 name="menu.prog_faah038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_faah_m.faah038

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah039
            LET g_action_choice="prog_faah039"
            IF cl_auth_chk_act("prog_faah039") THEN
               
               #add-point:ON ACTION prog_faah039 name="menu.prog_faah039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_faah_m.faah039

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah040
            LET g_action_choice="prog_faah040"
            IF cl_auth_chk_act("prog_faah040") THEN
               
               #add-point:ON ACTION prog_faah040 name="menu.prog_faah040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #161108-00038#1 Add  ---(S)---
               SELECT glaald INTO l_glaald FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaa014 = 'Y'
                  AND glaacomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = g_enterprise
                                      AND ooef001 = g_faah_m.faah028)
               #161108-00038#1 Add  ---(E)---
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent   = g_enterprise
                  AND apcadocno = g_faah_m.faah040
                  AND apcald    = l_glaald   #161108-00038#1 Add
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faah_m.faah040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faah_m.faah040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faah_m.faah040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--str
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] =g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faah_m.faah040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--end
               END CASE 
               #150803-00012#1 20150806--add--str
               IF cl_null(l_apca001) THEN 
                  SELECT faba003 INTO l_apca001
                    FROM faba_t
                   WHERE fabaent = g_enterprise
                     AND fabadocno = g_faah_m.faah040
               END IF
               IF l_apca001 = '20' THEN
                  #應用 a41 樣板自動產生(Version:2)
                  #使用JSON格式組合參數與作業編號(串查)
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'afat460'
                  LET la_param.param[1] = g_faah_m.faah040
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #150803-00012#1 20150806--add--end 
            END IF 
               
               
         ON ACTION prog_faaj030
            LET g_action_choice="prog_faaj030"
            IF cl_auth_chk_act("prog_faaj030") THEN
               
               #add-point:ON ACTION prog_faaj030
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_faaj_m.faaj030
                  AND apcald    = g_faaj_m.faajld   #161108-00038#1 Add
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [3]
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [2]
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faaj_m.faaj030      #161108-00038#1 Mod [1] --> [3]
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #161108-00038#1 Add  ---(S)---
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faaj_m.faaj030
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #161108-00038#1 Add ---(E)---
               END CASE
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faah057
            LET g_action_choice="prog_faah057"
            IF cl_auth_chk_act("prog_faah057") THEN
               
               #add-point:ON ACTION prog_faah057 name="menu.prog_faah057"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint301'
               LET la_param.param[1] = g_faah_m.faah057

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afai100_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afai100_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afai100_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            CALL cl_user_overview_follow('')
            
            ON ACTION first1
               CALL afai100_fetch1("F") 
               LET g_current_row1 = g_current_idx1
            
            ON ACTION next1
               CALL afai100_fetch1("N")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION jump1
               CALL afai100_fetch1("/")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION previous1
               CALL afai100_fetch1("P")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION last1
               CALL afai100_fetch1("L")  
               LET g_current_row1 = g_current_idx1
               
            ON ACTION first2
               CALL afai100_fetch1("F") 
               LET g_current_row1 = g_current_idx1
            
            ON ACTION next2
               CALL afai100_fetch1("N")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION jump2
               CALL afai100_fetch1("/")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION previous2
               CALL afai100_fetch1("P")
               LET g_current_row1 = g_current_idx1
            
            ON ACTION last2
               CALL afai100_fetch1("L")  
               LET g_current_row1 = g_current_idx1

            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
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
 
{<section id="afai100.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afai100_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_sub_sql         STRING
   DEFINE l_glaald          LIKE glaa_t.glaald

   
   CALL afai100_browser_fill_1(p_wc,ps_page_action)
   RETURN 
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "faah000,faah001,faah003,faah004"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   IF cl_null(g_wc4) THEN 
      LET g_wc4 = " 1=1"
   END IF 
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM faah_t ",
               "  ",
               "  ",
               " WHERE faahent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("faah_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET l_sub_sql = " SELECT UNIQUE faah000,faah001,faah003,faah004 FROM faah_t ",
                   "  LEFT JOIN faaj_t ON faajent = faahent AND faaj000 = faah000 AND faaj001 = faah003 AND faaj002 = faah004 AND faaj037 = faah001",
                   "  ",
                   "  ",
                   " WHERE faahent = '" ||g_enterprise|| "' AND ",p_wc CLIPPED, cl_sql_add_filter("faah_t")
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_faah_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.faahstus,t0.faah000,t0.faah003,t0.faah004,t0.faah001,t0.faah002,t0.faah012, 
       t0.faah013,t0.faah021,t0.faah022,t0.faah024,t0.faah028,t0.faah032,t1.ooefl003 ,t2.ooefl003",
               " FROM faah_t t0 ",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.faah028 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.faah032 AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.faahent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("faah_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT DISTINCT t0.faahstus,t0.faah000,t0.faah003,t0.faah004,t0.faah001,t0.faah002,t0.faah012, 
       t0.faah013,t0.faah021,t0.faah022,t0.faah024,t0.faah028,t0.faah032,t1.ooefl003 ,t2.ooefl003",
               " FROM faah_t t0 ",
               " LEFT JOIN faaj_t ON faajent = faahent AND faaj000 = faah000 AND faaj001 = faah003 AND faaj002 = faah004 AND faaj037 = faah001",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.faah028 AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.faah032 AND t2.ooefl002='"||g_lang||"' ",
               " WHERE t0.faahent = '" ||g_enterprise|| "' AND ",g_wc4 CLIPPED ," AND ", ls_wc,cl_sql_add_filter("faah_t")
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"faah_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_faah000,g_browser[g_cnt].b_faah003, 
          g_browser[g_cnt].b_faah004,g_browser[g_cnt].b_faah001,g_browser[g_cnt].b_faah002,g_browser[g_cnt].b_faah012, 
          g_browser[g_cnt].b_faah013,g_browser[g_cnt].b_faah021,g_browser[g_cnt].b_faah022,g_browser[g_cnt].b_faah024, 
          g_browser[g_cnt].b_faah028,g_browser[g_cnt].b_faah032,g_browser[g_cnt].b_faah028_desc,g_browser[g_cnt].b_faah032_desc 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      #獲取法人對應的主帳套
      SELECT glaald INTO l_glaald
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_browser[g_cnt].b_faah032
         AND glaa014 = 'Y'
      #根據財編+卡片編號+附號+批號+主帳套抓取累折、預殘留值、減值準備
      SELECT faaj017,faaj019,faaj028
        INTO g_browser[g_cnt].b_faaj017,g_browser[g_cnt].b_faaj019,g_browser[g_cnt].b_faaj028
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faajld = l_glaald
         AND faaj000 = g_browser[g_cnt].b_faah000
         AND faaj001 = g_browser[g_cnt].b_faah003
         AND faaj002 = g_browser[g_cnt].b_faah004
         AND faaj037 = g_browser[g_cnt].b_faah001
         #end add-point
         
         #遮罩相關處理
         CALL afai100_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_faah000) THEN
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
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai100.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afai100_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_comp_str     STRING       #161017-00023#1 add lujh
   DEFINE l_ld_str       STRING #161111-00049#5
   DEFINE l_ooef017      LIKE ooef_t.ooef017 #170117-00026#1 
   DEFINE l_glaald       LIKE glaa_t.glaald  #170117-00026#1
   DEFINE l_glaa004      LIKE glaa_t.glaa004 #170117-00026#1
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_faah_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON faah001,faah003,faah004,faah002,faah012,faah013,faah006,faah007,faah005, 
          faahstus,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,faah022,faah023,faah024, 
          faah025,faah026,faah027,faah028,faah030,faah031,faah032,faah029,faah009,faah000,faah010,faah011, 
          faah046,faah033,faah008,faah042,faah035,faah036,faah037,faah043,faah044,faah041,faah038,faah039, 
          faah040,faah057,faah050,faah054,faah055,faahownid,faahowndp,faahcrtid,faahcrtdt,faahcrtdp, 
          faahmodid,faahmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            CALL cl_set_combo_scc('faah015','9914') 
            #170117-00026#1 add s--
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
		      SELECT glaald,glaa004 INTO l_glaald,l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise 
		         AND glaacomp = l_ooef017 AND glaa014 = 'Y'   
		      #170117-00026#1 add e---   
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<faahcrtdt>>----
         AFTER FIELD faahcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<faahmoddt>>----
         AFTER FIELD faahmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faahcnfdt>>----
         
         #----<<faahpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="construct.c.faah001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah001  #顯示到畫面上

            NEXT FIELD faah001                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="construct.b.faah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="construct.a.faah001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="construct.c.faah003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 			
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah003  #顯示到畫面上

            NEXT FIELD faah003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="construct.b.faah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="construct.a.faah003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="construct.c.faah004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 			   
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah004  #顯示到畫面上

            NEXT FIELD faah004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="construct.b.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="construct.a.faah004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah002
            #add-point:BEFORE FIELD faah002 name="construct.b.faah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah002
            
            #add-point:AFTER FIELD faah002 name="construct.a.faah002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah002
            #add-point:ON ACTION controlp INFIELD faah002 name="construct.c.faah002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="construct.b.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="construct.a.faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="construct.c.faah012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="construct.b.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="construct.a.faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="construct.c.faah013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="construct.c.faah006"
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#5 add e---            
            #CALL q_faac001()    #呼叫開窗 #161111-00049#5 mark
            
            DISPLAY g_qryparam.return1 TO faah006  #顯示到畫面上

            NEXT FIELD faah006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="construct.b.faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="construct.a.faah006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="construct.c.faah007"
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#5 add e---
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah007  #顯示到畫面上

            NEXT FIELD faah007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="construct.b.faah007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="construct.a.faah007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah005
            #add-point:BEFORE FIELD faah005 name="construct.b.faah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah005
            
            #add-point:AFTER FIELD faah005 name="construct.a.faah005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah005
            #add-point:ON ACTION controlp INFIELD faah005 name="construct.c.faah005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahstus
            #add-point:BEFORE FIELD faahstus name="construct.b.faahstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahstus
            
            #add-point:AFTER FIELD faahstus name="construct.a.faahstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahstus
            #add-point:ON ACTION controlp INFIELD faahstus name="construct.c.faahstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah014
            #add-point:BEFORE FIELD faah014 name="construct.b.faah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah014
            
            #add-point:AFTER FIELD faah014 name="construct.a.faah014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah014
            #add-point:ON ACTION controlp INFIELD faah014 name="construct.c.faah014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah015
            #add-point:BEFORE FIELD faah015 name="construct.b.faah015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah015
            
            #add-point:AFTER FIELD faah015 name="construct.a.faah015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah015
            #add-point:ON ACTION controlp INFIELD faah015 name="construct.c.faah015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah016
            #add-point:BEFORE FIELD faah016 name="construct.b.faah016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah016
            
            #add-point:AFTER FIELD faah016 name="construct.a.faah016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah016
            #add-point:ON ACTION controlp INFIELD faah016 name="construct.c.faah016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah017
            #add-point:ON ACTION controlp INFIELD faah017 name="construct.c.faah017"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah017  #顯示到畫面上

            NEXT FIELD faah017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah017
            #add-point:BEFORE FIELD faah017 name="construct.b.faah017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah017
            
            #add-point:AFTER FIELD faah017 name="construct.a.faah017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah018
            #add-point:BEFORE FIELD faah018 name="construct.b.faah018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah018
            
            #add-point:AFTER FIELD faah018 name="construct.a.faah018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah018
            #add-point:ON ACTION controlp INFIELD faah018 name="construct.c.faah018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah019
            #add-point:BEFORE FIELD faah019 name="construct.b.faah019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah019
            
            #add-point:AFTER FIELD faah019 name="construct.a.faah019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah019
            #add-point:ON ACTION controlp INFIELD faah019 name="construct.c.faah019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah020
            #add-point:ON ACTION controlp INFIELD faah020 name="construct.c.faah020"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah020  #顯示到畫面上

            NEXT FIELD faah020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah020
            #add-point:BEFORE FIELD faah020 name="construct.b.faah020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah020
            
            #add-point:AFTER FIELD faah020 name="construct.a.faah020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah021
            #add-point:BEFORE FIELD faah021 name="construct.b.faah021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah021
            
            #add-point:AFTER FIELD faah021 name="construct.a.faah021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah021
            #add-point:ON ACTION controlp INFIELD faah021 name="construct.c.faah021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah022
            #add-point:BEFORE FIELD faah022 name="construct.b.faah022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah022
            
            #add-point:AFTER FIELD faah022 name="construct.a.faah022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah022
            #add-point:ON ACTION controlp INFIELD faah022 name="construct.c.faah022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah023
            #add-point:BEFORE FIELD faah023 name="construct.b.faah023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah023
            
            #add-point:AFTER FIELD faah023 name="construct.a.faah023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah023
            #add-point:ON ACTION controlp INFIELD faah023 name="construct.c.faah023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah024
            #add-point:BEFORE FIELD faah024 name="construct.b.faah024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah024
            
            #add-point:AFTER FIELD faah024 name="construct.a.faah024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah024
            #add-point:ON ACTION controlp INFIELD faah024 name="construct.c.faah024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="construct.c.faah025"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah025  #顯示到畫面上

            NEXT FIELD faah025                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="construct.b.faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="construct.a.faah025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="construct.c.faah026"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上

            NEXT FIELD faah026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="construct.b.faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="construct.a.faah026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah027
            #add-point:ON ACTION controlp INFIELD faah027 name="construct.c.faah027"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '3900'
			LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') OR oocq004 IS NULL)" #161111-00049#5 1116 add 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah027  #顯示到畫面上

            NEXT FIELD faah027                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah027
            #add-point:BEFORE FIELD faah027 name="construct.b.faah027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah027
            
            #add-point:AFTER FIELD faah027 name="construct.a.faah027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah028
            #add-point:ON ACTION controlp INFIELD faah028 name="construct.c.faah028"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah028  #顯示到畫面上

            NEXT FIELD faah028                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah028
            #add-point:BEFORE FIELD faah028 name="construct.b.faah028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah028
            
            #add-point:AFTER FIELD faah028 name="construct.a.faah028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah030
            #add-point:ON ACTION controlp INFIELD faah030 name="construct.c.faah030"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str     #161009-00006#1 add lujh    #161017-00023#1 add l_comp_str lujh 
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah030  #顯示到畫面上

            NEXT FIELD faah030                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah030
            #add-point:BEFORE FIELD faah030 name="construct.b.faah030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah030
            
            #add-point:AFTER FIELD faah030 name="construct.a.faah030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah031
            #add-point:ON ACTION controlp INFIELD faah031 name="construct.c.faah031"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.where = " ooef204 = 'Y' OR ooef003 = 'Y'"   #161009-00006#1 mark lujh
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str     #161009-00006#1 add lujh   #161017-00023#1 add l_comp_str lujh
            #CALL q_ooef001_10()                           #呼叫開窗     #161009-00006#1 mark lujh
            CALL q_ooef001()                                            #161009-00006#1 add lujh
            DISPLAY g_qryparam.return1 TO faah031  #顯示到畫面上

            NEXT FIELD faah031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah031
            #add-point:BEFORE FIELD faah031 name="construct.b.faah031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah031
            
            #add-point:AFTER FIELD faah031 name="construct.a.faah031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032 name="construct.c.faah032"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#1  ---mark---
            CALL q_ooef001_2()                                   #161024-00008#1 ---add---
            DISPLAY g_qryparam.return1 TO faah032  #顯示到畫面上

            NEXT FIELD faah032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah032
            #add-point:BEFORE FIELD faah032 name="construct.b.faah032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah032
            
            #add-point:AFTER FIELD faah032 name="construct.a.faah032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah029
            #add-point:ON ACTION controlp INFIELD faah029 name="construct.c.faah029"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah029  #顯示到畫面上

            NEXT FIELD faah029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah029
            #add-point:BEFORE FIELD faah029 name="construct.b.faah029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah029
            
            #add-point:AFTER FIELD faah029 name="construct.a.faah029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah009
            #add-point:ON ACTION controlp INFIELD faah009 name="construct.c.faah009"
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #161111-00049#5 mod s--
            #CALL q_pmaa001_10()              #呼叫開窗                                #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--            
            DISPLAY g_qryparam.return1 TO faah009  #顯示到畫面上

            NEXT FIELD faah009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah009
            #add-point:BEFORE FIELD faah009 name="construct.b.faah009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah009
            
            #add-point:AFTER FIELD faah009 name="construct.a.faah009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah000
            #add-point:BEFORE FIELD faah000 name="construct.b.faah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah000
            
            #add-point:AFTER FIELD faah000 name="construct.a.faah000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah000
            #add-point:ON ACTION controlp INFIELD faah000 name="construct.c.faah000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah010
            #add-point:ON ACTION controlp INFIELD faah010 name="construct.c.faah010"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #161111-00049#5 mod s--
            #CALL q_pmaa001_5()                           #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--              
            DISPLAY g_qryparam.return1 TO faah010  #顯示到畫面上

            NEXT FIELD faah010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah010
            #add-point:BEFORE FIELD faah010 name="construct.b.faah010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah010
            
            #add-point:AFTER FIELD faah010 name="construct.a.faah010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah011
            #add-point:ON ACTION controlp INFIELD faah011 name="construct.c.faah011"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah011  #顯示到畫面上

            NEXT FIELD faah011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah011
            #add-point:BEFORE FIELD faah011 name="construct.b.faah011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah011
            
            #add-point:AFTER FIELD faah011 name="construct.a.faah011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah046
            #add-point:BEFORE FIELD faah046 name="construct.b.faah046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah046
            
            #add-point:AFTER FIELD faah046 name="construct.a.faah046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah046
            #add-point:ON ACTION controlp INFIELD faah046 name="construct.c.faah046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah033
            #add-point:BEFORE FIELD faah033 name="construct.b.faah033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah033
            
            #add-point:AFTER FIELD faah033 name="construct.a.faah033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah033
            #add-point:ON ACTION controlp INFIELD faah033 name="construct.c.faah033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="construct.c.faah008"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '3903' 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah008  #顯示到畫面上

            NEXT FIELD faah008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="construct.b.faah008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="construct.a.faah008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah042
            #add-point:BEFORE FIELD faah042 name="construct.b.faah042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah042
            
            #add-point:AFTER FIELD faah042 name="construct.a.faah042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah042
            #add-point:ON ACTION controlp INFIELD faah042 name="construct.c.faah042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah035
            #add-point:BEFORE FIELD faah035 name="construct.b.faah035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah035
            
            #add-point:AFTER FIELD faah035 name="construct.a.faah035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah035
            #add-point:ON ACTION controlp INFIELD faah035 name="construct.c.faah035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah036
            #add-point:BEFORE FIELD faah036 name="construct.b.faah036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah036
            
            #add-point:AFTER FIELD faah036 name="construct.a.faah036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah036
            #add-point:ON ACTION controlp INFIELD faah036 name="construct.c.faah036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah037
            #add-point:BEFORE FIELD faah037 name="construct.b.faah037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah037
            
            #add-point:AFTER FIELD faah037 name="construct.a.faah037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah037
            #add-point:ON ACTION controlp INFIELD faah037 name="construct.c.faah037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah043
            #add-point:BEFORE FIELD faah043 name="construct.b.faah043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah043
            
            #add-point:AFTER FIELD faah043 name="construct.a.faah043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah043
            #add-point:ON ACTION controlp INFIELD faah043 name="construct.c.faah043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah044
            #add-point:BEFORE FIELD faah044 name="construct.b.faah044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah044
            
            #add-point:AFTER FIELD faah044 name="construct.a.faah044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah044
            #add-point:ON ACTION controlp INFIELD faah044 name="construct.c.faah044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faah041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah041
            #add-point:ON ACTION controlp INFIELD faah041 name="construct.c.faah041"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#1
            CALL q_ooef001_12()                                   #161024-00008#1 
            DISPLAY g_qryparam.return1 TO faah041  #顯示到畫面上

            NEXT FIELD faah041                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah041
            #add-point:BEFORE FIELD faah041 name="construct.b.faah041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah041
            
            #add-point:AFTER FIELD faah041 name="construct.a.faah041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah038
            #add-point:ON ACTION controlp INFIELD faah038 name="construct.c.faah038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah038  #顯示到畫面上

            NEXT FIELD faah038                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah038
            #add-point:BEFORE FIELD faah038 name="construct.b.faah038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah038
            
            #add-point:AFTER FIELD faah038 name="construct.a.faah038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah039
            #add-point:ON ACTION controlp INFIELD faah039 name="construct.c.faah039"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
            CALL q_pmdsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah039  #顯示到畫面上

            NEXT FIELD faah039                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah039
            #add-point:BEFORE FIELD faah039 name="construct.b.faah039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah039
            
            #add-point:AFTER FIELD faah039 name="construct.a.faah039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah040
            #add-point:ON ACTION controlp INFIELD faah040 name="construct.c.faah040"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah040  #顯示到畫面上

            NEXT FIELD faah040                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah040
            #add-point:BEFORE FIELD faah040 name="construct.b.faah040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah040
            
            #add-point:AFTER FIELD faah040 name="construct.a.faah040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah057
            #add-point:ON ACTION controlp INFIELD faah057 name="construct.c.faah057"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inba001 = '1' " #160426-00014#15 add
            CALL q_inbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah057  #顯示到畫面上
            NEXT FIELD faah057                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah057
            #add-point:BEFORE FIELD faah057 name="construct.b.faah057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah057
            
            #add-point:AFTER FIELD faah057 name="construct.a.faah057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah050
            #add-point:BEFORE FIELD faah050 name="construct.b.faah050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah050
            
            #add-point:AFTER FIELD faah050 name="construct.a.faah050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah050
            #add-point:ON ACTION controlp INFIELD faah050 name="construct.c.faah050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah054
            #add-point:BEFORE FIELD faah054 name="construct.b.faah054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah054
            
            #add-point:AFTER FIELD faah054 name="construct.a.faah054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah054
            #add-point:ON ACTION controlp INFIELD faah054 name="construct.c.faah054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah055
            #add-point:BEFORE FIELD faah055 name="construct.b.faah055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah055
            
            #add-point:AFTER FIELD faah055 name="construct.a.faah055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faah055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah055
            #add-point:ON ACTION controlp INFIELD faah055 name="construct.c.faah055"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faahownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahownid
            #add-point:ON ACTION controlp INFIELD faahownid name="construct.c.faahownid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahownid  #顯示到畫面上

            NEXT FIELD faahownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahownid
            #add-point:BEFORE FIELD faahownid name="construct.b.faahownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahownid
            
            #add-point:AFTER FIELD faahownid name="construct.a.faahownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faahowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahowndp
            #add-point:ON ACTION controlp INFIELD faahowndp name="construct.c.faahowndp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahowndp  #顯示到畫面上

            NEXT FIELD faahowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahowndp
            #add-point:BEFORE FIELD faahowndp name="construct.b.faahowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahowndp
            
            #add-point:AFTER FIELD faahowndp name="construct.a.faahowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faahcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahcrtid
            #add-point:ON ACTION controlp INFIELD faahcrtid name="construct.c.faahcrtid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtid  #顯示到畫面上

            NEXT FIELD faahcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtid
            #add-point:BEFORE FIELD faahcrtid name="construct.b.faahcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahcrtid
            
            #add-point:AFTER FIELD faahcrtid name="construct.a.faahcrtid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtdt
            #add-point:BEFORE FIELD faahcrtdt name="construct.b.faahcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faahcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahcrtdp
            #add-point:ON ACTION controlp INFIELD faahcrtdp name="construct.c.faahcrtdp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahcrtdp  #顯示到畫面上

            NEXT FIELD faahcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahcrtdp
            #add-point:BEFORE FIELD faahcrtdp name="construct.b.faahcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahcrtdp
            
            #add-point:AFTER FIELD faahcrtdp name="construct.a.faahcrtdp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faahmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahmodid
            #add-point:ON ACTION controlp INFIELD faahmodid name="construct.c.faahmodid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faahmodid  #顯示到畫面上

            NEXT FIELD faahmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahmodid
            #add-point:BEFORE FIELD faahmodid name="construct.b.faahmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahmodid
            
            #add-point:AFTER FIELD faahmodid name="construct.a.faahmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahmoddt
            #add-point:BEFORE FIELD faahmoddt name="construct.b.faahmoddt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT BY NAME g_wc4 ON  faajld,faaj000,faaj001,faaj002,faaj037,    
                 glaacomp,glaa004,faaj006,faaj007,      
                 faaj023,faaj024,faaj025,faaj026,
                 faaj003,faaj004,faaj005,faaj038,
                 faaj008,faaj009,faaj010,faaj014,
                 faaj015,faaj016,faaj017,faaj018,
                 faaj019,faaj020,faaj022,faaj033,
                 faaj034,faaj035,faaj032,faaj027,
                 faaj021,faaj029,faaj028,faaj011,faaj013,faaj012,
                 faaj106,faaj156,faaj042,faaj043,
                 faaj045,faaj046,faaj030,faajsite,
                 faaj101,faaj102,faaj103,faaj104,
                 faaj111,faaj105,faaj117,faaj107,faaj109,faaj108,
                 faaj113,faaj114,faaj115,faaj110,
                 faaj112,faaj151,faaj152,faaj153,
                 faaj154,faaj161,faaj155,faaj167,faaj157,
                 faaj159,faaj158,faaj163,faaj164,faaj165,
                 faaj160,faaj162,
                 faaj048 #160426-00014#8

         ON ACTION controlp INFIELD faajld
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               #161017-00023#1--mark--str--lujh
		      	#LET g_qryparam.reqry = FALSE
               #CALL q_glaald()
               #161017-00023#1--mark--end--lujh
               #161017-00023#1--add--str--lujh
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               #账套范围
               CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
               IF NOT cl_null(g_wc_cs_ld) THEN   
                  LET g_qryparam.where = g_wc_cs_ld
               END IF
               CALL q_authorised_ld()
               #161017-00023#1--add--end--lujh
               LET g_faaj_m.faajld = g_qryparam.return1
               DISPLAY g_qryparam.return1 TO faajld
               NEXT FIELD faajld
         
         
         ON ACTION controlp INFIELD faajsite
		      	CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str #161111-00049#5 add
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()  #161024-00008#1
               LET g_qryparam.where = l_comp_str   #161111-00049#5 add
               CALL q_ooef001_12() #161024-00008#1
               DISPLAY g_qryparam.return1 TO faajsite 
               NEXT FIELD faajsite                          #返回原欄位
         
         
         ON ACTION controlp INFIELD faaj007
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
               #CALL q_ooef001() #161024-00008#1 ---mark---
               SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site #161111-00049#5 add 
               LET g_qryparam.where = " ooeg009 = '",g_ooef017,"'"  #161111-00049#5 add 
               CALL q_ooeg001_4()#161024-00008#1 ---add---
               DISPLAY g_qryparam.return1 TO faajsite 
               NEXT FIELD faaj007                         #返回原欄位
         
         ON ACTION controlp INFIELD faaj023
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
		      	#170117-00026#1 add s---
               LET g_qryparam.where = " glac001 = '",l_glaa004,"'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                      " AND gladld='",l_glaald,"' AND gladent='",g_enterprise,"'",
                                      " AND gladstus = 'Y')"
		      	#170117-00026#1 add e---
               CALL aglt310_04()                                #呼叫開窗
               DISPLAY g_qryparam.return1 TO faaj023
               NEXT FIELD faaj023                          #返回原欄位
         
         
         ON ACTION controlp INFIELD faaj024
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
		      	#170117-00026#1 add s---
               LET g_qryparam.where = " glac001 = '",l_glaa004,"'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                      " AND gladld='",l_glaald,"' AND gladent='",g_enterprise,"'",
                                      " AND gladstus = 'Y')"
		      	#170117-00026#1 add e---		      	
               CALL aglt310_04()            
               DISPLAY g_qryparam.return1 TO faaj024
               NEXT FIELD faaj024                          #返回原欄位
         
         
         ON ACTION controlp INFIELD faaj025
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		      	#170117-00026#1 add s---
               LET g_qryparam.where = " glac001 = '",l_glaa004,"'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                      " AND gladld='",l_glaald,"' AND gladent='",g_enterprise,"'",
                                      " AND gladstus = 'Y')"
		      	#170117-00026#1 add e---		   	   
               CALL aglt310_04()                           
               DISPLAY g_qryparam.return1 TO faaj025
               NEXT FIELD faaj025                          #返回原欄位
         
         
         ON ACTION controlp INFIELD faaj026
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE
		      	#170117-00026#1 add s---
               LET g_qryparam.where = " glac001 = '",l_glaa004,"'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                      " AND gladld='",l_glaald,"' AND gladent='",g_enterprise,"'",
                                      " AND gladstus = 'Y')"
		      	#170117-00026#1 add e---		      	
               CALL aglt310_04()
               DISPLAY g_qryparam.return1 TO faaj026
               NEXT FIELD faaj026                          #返回原欄位
               
         
         ON ACTION controlp INFIELD faaj014
               #add-point:ON ACTION controlp INFIELD faaj014
               #此段落由子樣板a07產生            
               #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
         
               LET g_qryparam.default1 = g_faaj_m.faaj014             #給予default值
         
               #給予arg
         
               CALL q_aooi001_1()                                #呼叫開窗
         
               LET g_faaj_m.faaj014 = g_qryparam.return1              #將開窗取得的值回傳到變數
         
               DISPLAY g_faaj_m.faaj014 TO faaj014              #顯示到畫面上
               NEXT FIELD faaj014                          #返回原欄位
               
               
         ON ACTION controlp INFIELD faaj042
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pmaastus = 'Y'"
               CALL q_pmaa001_5()   
               DISPLAY g_qryparam.return1 TO faaj042      
               NEXT FIELD faaj042                          #返回原欄位
         
         ON ACTION controlp INFIELD faaj043
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_5()                                #呼叫開窗
               DISPLAY g_qryparam.return1 TO faaj043 
               NEXT FIELD faaj043                          #返回原欄位
               
          ON ACTION controlp INFIELD faaj045
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_pjba001()
               DISPLAY g_qryparam.return1 TO faaj045 
               NEXT FIELD faaj045                          #返回原欄位
               
          ON ACTION controlp INFIELD faaj046
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_pjbb002_1()
               DISPLAY g_qryparam.return1 TO faaj046
               NEXT FIELD faaj046                          #返回原欄位
      END CONSTRUCT
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
   IF cl_null(g_wc3) THEN 
      LET g_wc3 = " 1=1 "
   END IF
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="afai100.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afai100_filter()
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
      CONSTRUCT g_wc_filter ON faah000,faah003,faah004,faah001,faah002,faah012,faah013,faah021,faah022, 
          faah024,faah028,faah032
                          FROM s_browse[1].b_faah000,s_browse[1].b_faah003,s_browse[1].b_faah004,s_browse[1].b_faah001, 
                              s_browse[1].b_faah002,s_browse[1].b_faah012,s_browse[1].b_faah013,s_browse[1].b_faah021, 
                              s_browse[1].b_faah022,s_browse[1].b_faah024,s_browse[1].b_faah028,s_browse[1].b_faah032 
 
 
         BEFORE CONSTRUCT
               DISPLAY afai100_filter_parser('faah000') TO s_browse[1].b_faah000
            DISPLAY afai100_filter_parser('faah003') TO s_browse[1].b_faah003
            DISPLAY afai100_filter_parser('faah004') TO s_browse[1].b_faah004
            DISPLAY afai100_filter_parser('faah001') TO s_browse[1].b_faah001
            DISPLAY afai100_filter_parser('faah002') TO s_browse[1].b_faah002
            DISPLAY afai100_filter_parser('faah012') TO s_browse[1].b_faah012
            DISPLAY afai100_filter_parser('faah013') TO s_browse[1].b_faah013
            DISPLAY afai100_filter_parser('faah021') TO s_browse[1].b_faah021
            DISPLAY afai100_filter_parser('faah022') TO s_browse[1].b_faah022
            DISPLAY afai100_filter_parser('faah024') TO s_browse[1].b_faah024
            DISPLAY afai100_filter_parser('faah028') TO s_browse[1].b_faah028
            DISPLAY afai100_filter_parser('faah032') TO s_browse[1].b_faah032
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         DISPLAY '' TO s_browse[1].b_faaj017
         DISPLAY '' TO s_browse[1].b_faaj019
         DISPLAY '' TO s_browse[1].b_faaj028
         DISPLAY '' TO s_browse[1].b_faah028_desc
         DISPLAY '' TO s_browse[1].b_faah032_desc
         
         ON ACTION controlp INFIELD b_faah001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah001  #顯示到畫面上
            NEXT FIELD b_faah001                     #返回原欄位

         ON ACTION controlp INFIELD b_faah003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
            NEXT FIELD b_faah003                     #返回原欄位
            #END add-point

         ON ACTION controlp INFIELD b_faah004
            #add-point:ON ACTION controlp INFIELD faah004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah004  #顯示到畫面上
            NEXT FIELD b_faah004                     #返回原欄位
            #END add-point

         ON ACTION controlp INFIELD b_faah028
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah028  #顯示到畫面上
            NEXT FIELD b_faah028                     #返回原欄位


         ON ACTION controlp INFIELD b_faah032
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah032  #顯示到畫面上
            NEXT FIELD b_faah032                     #返回原欄位

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
 
      CALL afai100_filter_show('faah000')
   CALL afai100_filter_show('faah003')
   CALL afai100_filter_show('faah004')
   CALL afai100_filter_show('faah001')
   CALL afai100_filter_show('faah002')
   CALL afai100_filter_show('faah012')
   CALL afai100_filter_show('faah013')
   CALL afai100_filter_show('faah021')
   CALL afai100_filter_show('faah022')
   CALL afai100_filter_show('faah024')
   CALL afai100_filter_show('faah028')
   CALL afai100_filter_show('faah032')
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afai100_filter_parser(ps_field)
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
 
{<section id="afai100.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afai100_filter_show(ps_field)
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
   LET ls_condition = afai100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afai100_query()
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
 
   INITIALIZE g_faah_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afai100_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afai100_browser_fill(g_wc,"F")
      CALL afai100_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afai100_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afai100_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afai100.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afai100_fetch(p_fl)
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
   LET g_faah_m.faah000 = g_browser[g_current_idx].b_faah000
   LET g_faah_m.faah001 = g_browser[g_current_idx].b_faah001
   LET g_faah_m.faah003 = g_browser[g_current_idx].b_faah003
   LET g_faah_m.faah004 = g_browser[g_current_idx].b_faah004
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
       g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
       g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
       g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
       g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
       g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
       g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
       g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
       g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
       g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
       g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
       g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
       g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
       g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
       g_faah_m.faahmodid_desc
   
   #遮罩相關處理
   LET g_faah_m_mask_o.* =  g_faah_m.*
   CALL afai100_faah_t_mask()
   LET g_faah_m_mask_n.* =  g_faah_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL afai100_browser_fill1('F')
   IF g_browser_cnt1 <> 0 THEN 
      CALL afai100_fetch1('F')         
   END IF
   CALL afai100_show2()
   IF g_faah_m.faahstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL afai100_navigator_setting(g_browser_idx1, g_browser_cnt1 )
   DISPLAY g_browser_idx  TO FORMONLY.h_index         #當下筆數
   DISPLAY g_browser_cnt  TO FORMONLY.h_count         #總筆數
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_faah_m_t.* = g_faah_m.*
   LET g_faah_m_o.* = g_faah_m.*
   
   LET g_data_owner = g_faah_m.faahownid      
   LET g_data_dept  = g_faah_m.faahowndp
   
   #重新顯示
   CALL afai100_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.insert" >}
#+ 資料新增
PRIVATE FUNCTION afai100_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_faah_m.* TO NULL             #DEFAULT 設定
   LET g_faah000_t = NULL
   LET g_faah001_t = NULL
   LET g_faah003_t = NULL
   LET g_faah004_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faah_m.faahownid = g_user
      LET g_faah_m.faahowndp = g_dept
      LET g_faah_m.faahcrtid = g_user
      LET g_faah_m.faahcrtdp = g_dept 
      LET g_faah_m.faahcrtdt = cl_get_current()
      LET g_faah_m.faahmodid = g_user
      LET g_faah_m.faahmoddt = cl_get_current()
      LET g_faah_m.faahstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_faah_m.faah002 = "1"
      LET g_faah_m.faah005 = "1"
      LET g_faah_m.faahstus = "N"
      LET g_faah_m.faah015 = "0"
      LET g_faah_m.faah016 = "1"
      LET g_faah_m.faah018 = "0"
      LET g_faah_m.faah019 = "0"
      LET g_faah_m.faah021 = "0"
      LET g_faah_m.faah022 = "0"
      LET g_faah_m.faah023 = "0"
      LET g_faah_m.faah024 = "0"
      LET g_faah_m.faah033 = "Y"
      LET g_faah_m.faah042 = "1"
      LET g_faah_m.faah043 = "0"
      LET g_faah_m.faah044 = "0"
      LET g_faah_m.faah054 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      CALL afai100_init_para()
      LET g_faah_m.faah004 = ' '
      LET g_faah_m.faah014 = g_today
      LET g_faah_m.faah020 = g_glaa001
      LET g_faah_m.faah025 = g_user
      LET g_faah_m.faah028 = g_site
      LET g_faah_m.faah029 = g_user
      LET g_faah_m.faah030 = g_site
      LET g_faah_m.faah031 = g_site
      SELECT ooef017 INTO g_ooef017 
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_faah_m.faah028
      LET g_faah_m.faah032 = g_ooef017
      LET g_faah_m.faah041 = g_site
      CALL afai100_faaj015_desc_get()
#      IF g_para_data = 'Y' THEN 
#         SELECT lpad((MAX(faah001) + 1),10,'0') INTO g_faah_m.faah001
#           FROM faah_t
#          WHERE faahent = g_enterprise
#         IF cl_null(g_faah_m.faah001) THEN 
#            LET g_faah_m.faah001 = 1
#         END IF
#      END IF      
#mark by yangxf
#      SELECT ooag003,ooag004 INTO g_faah_m.faah026,g_faah_m.faah030
#        FROM ooag_t
#       WHERE ooagent = g_enterprise
#         AND ooag001 = g_faah_m.faah025
#mark by yangxf
#add by yangxf
      SELECT ooag003 INTO g_faah_m.faah026
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_faah_m.faah025
#add by yangxf

      CALL afai100_get_exrate(g_glaald,g_faah_m.faah020,g_glaa001,g_glaa025)
      CALL afai100_ref_show()
      
      CALL cl_set_combo_scc_part('faah015','9914','0,4')
      LET g_faah_m_t.* = g_faah_m.*
      LET g_faaj_m_o.* = g_faaj_m_t.*
      LET g_faah_m_o.* = g_faah_m_t.* #161111-00049#1 add
      INITIALIZE g_faaj_m.* TO NULL
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faah_m.faahstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL afai100_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL cl_set_combo_scc('faah015','9914') 
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_faah_m.* TO NULL
         CALL afai100_show()
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
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_faah000_t = g_faah_m.faah000
   LET g_faah001_t = g_faah_m.faah001
   LET g_faah003_t = g_faah_m.faah003
   LET g_faah004_t = g_faah_m.faah004
 
   
   #組合新增資料的條件
   LET g_add_browse = " faahent = " ||g_enterprise|| " AND",
                      " faah000 = '", g_faah_m.faah000, "' "
                      ," AND faah001 = '", g_faah_m.faah001, "' "
                      ," AND faah003 = '", g_faah_m.faah003, "' "
                      ," AND faah004 = '", g_faah_m.faah004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai100_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
       g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
       g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
       g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
       g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
       g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
       g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
       g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
       g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
       g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
       g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
       g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
       g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
       g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
       g_faah_m.faahmodid_desc
   
   
   #遮罩相關處理
   LET g_faah_m_mask_o.* =  g_faah_m.*
   CALL afai100_faah_t_mask()
   LET g_faah_m_mask_n.* =  g_faah_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
       g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah006_desc,g_faah_m.faah007,g_faah_m.faah007_desc, 
       g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
       g_faah_m.faah017_desc,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah020_desc, 
       g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faaj015_desc,g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025, 
       g_faah_m.faah025_desc,g_faah_m.faah026,g_faah_m.faah026_desc,g_faah_m.faah027,g_faah_m.faah027_desc, 
       g_faah_m.faah028,g_faah_m.faah028_desc,g_faah_m.faah030,g_faah_m.faah030_desc,g_faah_m.faah031, 
       g_faah_m.faah031_desc,g_faah_m.faah032,g_faah_m.faah032_desc,g_faah_m.faah029,g_faah_m.faah029_desc, 
       g_faah_m.faah009,g_faah_m.faah009_desc,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah010_desc, 
       g_faah_m.faah011,g_faah_m.faah011_desc,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah008_desc, 
       g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044, 
       g_faah_m.faah041,g_faah_m.faah041_desc,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057, 
       g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahownid_desc, 
       g_faah_m.faahowndp,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahcrtdp_desc,g_faah_m.faahmodid,g_faah_m.faahmodid_desc,g_faah_m.faahmoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_faah_m.faahownid      
   LET g_data_dept  = g_faah_m.faahowndp
 
   #功能已完成,通報訊息中心
   CALL afai100_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afai100.modify" >}
#+ 資料修改
PRIVATE FUNCTION afai100_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_faac003   LIKE faac_t.faac003
   DEFINE l_faac004   LIKE faac_t.faac004
   DEFINE l_faac016   LIKE faac_t.faac016
   DEFINE l_n         LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_faah_m.faah000 IS NULL
 
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
   LET g_faah000_t = g_faah_m.faah000
   LET g_faah001_t = g_faah_m.faah001
   LET g_faah003_t = g_faah_m.faah003
   LET g_faah004_t = g_faah_m.faah004
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afai100_cl USING g_enterprise,g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afai100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
       g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
       g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
       g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
       g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
       g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
       g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
       g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
       g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
       g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
       g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
       g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
       g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
       g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
       g_faah_m.faahmodid_desc
 
   #檢查是否允許此動作
   IF NOT afai100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_faah_m_mask_o.* =  g_faah_m.*
   CALL afai100_faah_t_mask()
   LET g_faah_m_mask_n.* =  g_faah_m.*
   
   
 
   #顯示資料
   CALL afai100_show()
   
   WHILE TRUE
      LET g_faah_m.faah000 = g_faah000_t
      LET g_faah_m.faah001 = g_faah001_t
      LET g_faah_m.faah003 = g_faah003_t
      LET g_faah_m.faah004 = g_faah004_t
 
      
      #寫入修改者/修改日期資訊
      LET g_faah_m.faahmodid = g_user 
LET g_faah_m.faahmoddt = cl_get_current()
LET g_faah_m.faahmodid_desc = cl_get_username(g_faah_m.faahmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afai100_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_faah_m.* = g_faah_m_t.*
         LET g_faaj_m.* = g_faaj_m_t.* #160826-00013#1 add
         LET g_faah_m_o.* = g_faah_m.* #161009-00006#1 add lujh
         CALL afai100_show()           
         CALL afai100_show2()          #160826-00013#1 add 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
       SELECT faac003,faac004,faac016
         INTO l_faac003,l_faac004,l_faac016
         FROM faac_t
        WHERE faacent = g_enterprise
          AND faac001 = g_faah_m.faah006
      IF g_faah_m.faah006 != g_faah_m_t.faah006 THEN 
      
         UPDATE faaj_t SET faaj003 = l_faac003,
                           faaj004 = l_faac004,
                           faaj005 = l_faac004,
                           faaj019 = faaj016 * (l_faac016/100)
          WHERE faajent = g_enterprise
            ###################################mark by huangtao
            #AND faajld = g_faaj_m.faajld
            #AND faaj000 = g_faaj_m.faaj000
            #AND faaj001 = g_faaj_m.faaj001
            #AND faaj002 = g_faaj_m.faaj002
            AND faajld = g_glaald
            AND faaj037 = g_faah_m.faah001
            AND faaj001 = g_faah_m.faah003
            AND faaj002 = g_faah_m.faah004  
            ###################################mark by huangtao
      END IF 
      ########################add by huangtao\更新主帐套的成本、预留残值、未折减额
      SELECT count(*) INTO l_n FROM faaj_t
       WHERE faajent = g_enterprise AND faajld = g_glaald

      IF l_n > 0 AND (g_faah_m.faah021 != g_faah_m_t.faah021 OR g_faah_m.faah022 != g_faah_m_t.faah022 
                      OR  g_faah_m.faah023 != g_faah_m_t.faah023 OR g_faah_m.faah024 != g_faah_m_t.faah024) THEN
         UPDATE faaj_t SET faaj016 = g_faah_m.faah024,
                           faaj019 = g_faah_m.faah024 * (l_faac016/100),
                           faaj028 = g_faah_m.faah024 - faaj017    
          WHERE faajent = g_enterprise
            AND faajld = g_glaald
            AND faaj037 = g_faah_m.faah001
            AND faaj001 = g_faah_m.faah003
            AND faaj002 = g_faah_m.faah004                              
      END IF    

  
      ########################add by huangtao
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_faah_m.* = g_faah_m_t.*
         CALL afai100_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE faah_t SET (faahmodid,faahmoddt) = (g_faah_m.faahmodid,g_faah_m.faahmoddt)
       WHERE faahent = g_enterprise AND faah000 = g_faah000_t
         AND faah001 = g_faah001_t
         AND faah003 = g_faah003_t
         AND faah004 = g_faah004_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " faahent = " ||g_enterprise|| " AND",
                      " faah000 = '", g_faah_m.faah000, "' "
                      ," AND faah001 = '", g_faah_m.faah001, "' "
                      ," AND faah003 = '", g_faah_m.faah003, "' "
                      ," AND faah004 = '", g_faah_m.faah004, "' "
 
   #填到對應位置
   CALL afai100_browser_fill(g_wc,"")
 
   CLOSE afai100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai100_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afai100.input" >}
#+ 資料輸入
PRIVATE FUNCTION afai100_input(p_cmd)
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
   DEFINE  l_faai007_sum         LIKE faai_t.faai007
   DEFINE  l_year                STRING
   DEFINE  l_month               STRING
   DEFINE  l_str                 STRING
   DEFINE  l_faah000             LIKE faah_t.faah000
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_ooef017_t           LIKE ooef_t.ooef017
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_glaa001_t           LIKE glaa_t.glaa001
   DEFINE  l_glaald              LIKE glaa_t.glaald
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_fristdate           LIKE faah_t.faah014
   DEFINE  l_num1                LIKE type_t.num5
   DEFINE  l_num2                LIKE type_t.num5
   DEFINE  l_str1                STRING
   DEFINE  l_str2                STRING
   DEFINE  l_cnt1                LIKE type_t.num5  #20141111
   DEFINE  l_ooef003             LIKE ooef_t.ooef003
   DEFINE  l_sys                 LIKE type_t.chr1
   DEFINE  l_success             LIKE type_t.num5   
   DEFINE  l_sql                 STRING
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd_b               LIKE type_t.chr1
   DEFINE  l_glaacomp            LIKE glaa_t.glaacomp
   DEFINE  l_comp_str            STRING       #161017-00023#1 add lujh
   DEFINE  l_str3                STRING
   DEFINE  l_ooef207             LIKE ooef_t.ooef207    #161009-00006#1
   DEFINE  l_ld_str              STRING              #161111-00049#5 
   DEFINE  l_faad002             LIKE faad_t.faad002 #161111-00049#5
   
   #150311---earl---add---s
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #150311---earl---add---e   
   DEFINE l_faac004    LIKE faac_t.faac004   #150923
   DEFINE l_faac016    LIKE faac_t.faac016   #150923   
   #ADD BY XZG20151203 B

   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
   END IF 
   

   
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
   DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
       g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah006_desc,g_faah_m.faah007,g_faah_m.faah007_desc, 
       g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
       g_faah_m.faah017_desc,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah020_desc, 
       g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faaj015_desc,g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025, 
       g_faah_m.faah025_desc,g_faah_m.faah026,g_faah_m.faah026_desc,g_faah_m.faah027,g_faah_m.faah027_desc, 
       g_faah_m.faah028,g_faah_m.faah028_desc,g_faah_m.faah030,g_faah_m.faah030_desc,g_faah_m.faah031, 
       g_faah_m.faah031_desc,g_faah_m.faah032,g_faah_m.faah032_desc,g_faah_m.faah029,g_faah_m.faah029_desc, 
       g_faah_m.faah009,g_faah_m.faah009_desc,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah010_desc, 
       g_faah_m.faah011,g_faah_m.faah011_desc,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah008_desc, 
       g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044, 
       g_faah_m.faah041,g_faah_m.faah041_desc,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057, 
       g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahownid_desc, 
       g_faah_m.faahowndp,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahcrtdp_desc,g_faah_m.faahmodid,g_faah_m.faahmodid_desc,g_faah_m.faahmoddt 
 
   
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
   CALL afai100_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afai100_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   IF l_cmd_t = 'r' THEN
      LET g_faah_m.faahstus = "N"      
      LET g_faah_m.faah015 = '0' 
      LET g_faaj_m.faaj038 = '0'     #161104-00048#1 add      
   END IF
   LET g_faaj_m_o.* = g_faaj_m_t.*
   LET g_faah_m_o.* = g_faah_m_t.* #161111-00049#1 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
          g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014, 
          g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020, 
          g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026, 
          g_faah_m.faah027,g_faah_m.faah028,g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029, 
          g_faah_m.faah009,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033, 
          g_faah_m.faah008,g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043, 
          g_faah_m.faah044,g_faah_m.faah041,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057, 
          g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            #161230-00018#1--add--str--lujh
            LET l_count = 0
            SELECT COUNT(1) INTO l_count FROM faah_t
             WHERE faahent = g_enterprise AND faah000 = g_faah_m.faah000
               AND faah001 = g_faah_m.faah001
               AND faah003 = g_faah_m.faah003
               AND faah004 = g_faah_m.faah004

            IF l_count > 0 THEN
               LET p_cmd = 'u'
               LET g_faah000_t = g_faah_m.faah000
               LET g_faah001_t = g_faah_m.faah001
               LET g_faah003_t = g_faah_m.faah003
               LET g_faah004_t = g_faah_m.faah004
            END IF
            #161230-00018#1--add--end--lujh
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah001
            #add-point:BEFORE FIELD faah001 name="input.b.faah001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah001
            
            #add-point:AFTER FIELD faah001 name="input.a.faah001"
#                        #此段落由子樣板a05產生
             #add by yangxf
             #卡片编号手动输入时，自动更新为十位编码
             IF g_para_data = 'N' AND p_cmd = 'a' THEN
                SELECT lpad(g_faah_m.faah001,10,'0') INTO g_faah_m.faah001
                  FROM faah_t
                 WHERE faahent = g_enterprise
                
                DISPLAY BY NAME g_faah_m.faah001
             END IF 
             IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
                CALL cl_set_comp_entry("faah003",FALSE)               
                LET g_faah_m.faah003 = g_faah_m.faah001
                DISPLAY BY NAME g_faah_m.faah003
             ELSE
                CALL cl_set_comp_entry("faah003",TRUE)  
             END IF
             #add by yangxf
#            IF NOT cl_null(g_faah_m.faah001) THEN    #mark by yangxf
             IF NOT cl_null(g_faah_m.faah001) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL THEN        #add by yangxf
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_faah_m.faah001 != g_faah001_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "'  AND "|| "faah001 = '"||g_faah_m.faah001 ||"'",'std-00004',0) THEN     #mark by yangxf
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || "faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN   #add by yangxf
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #20141111 add--str--
               #卡片编号手动输入时，自动更新为十位编码
#               IF g_para_data = 'N' AND p_cmd = 'a' THEN
#                  LET g_faah_m.faah001 = g_faah_m.faah001 USING '&&&&&&&&&&' 
#                  SELECT COUNT(*) INTO l_cnt1 FROM faah_t
#                   WHERE faahent = g_enterprise
#                     AND faah001 = g_faah_m.faah001
#                  DISPLAY BY NAME g_faah_m.faah001
#                  IF l_cnt1 >= 1 THEN 
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_faah_m.faah001 
#                     LET g_errparam.code   = "afa-00174" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     NEXT FIELD faah001
#                  END IF                  
#               END IF
               #20141111 add--end--

            END IF
            
            



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah001
            #add-point:ON CHANGE faah001 name="input.g.faah001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah003
            #add-point:BEFORE FIELD faah003 name="input.b.faah003"
            IF g_para_data2 <> 'Y' THEN 
               IF cl_null(g_faah_m.faah003) AND g_faah_m.faah002 = '1' THEN
                  IF g_para_data3 = 'Y' AND g_para_data2 ='N' THEN 
                     #150311---earl---mod---s
                     #CALL s_aooi390('3') RETURNING l_success,g_faah_m.faah003
#                     CALL s_aooi390_auto_no('3') RETURNING l_success,g_faah_m.faah003,l_oofg_return
                     CALL s_aooi390_gen('3') RETURNING l_success,g_faah_m.faah003,l_oofg_return   #add--2015/07/01 By shiun
                     #150311---earl---mod---e
                     DISPLAY BY NAME g_faah_m.faah003
                  END IF 
               END IF
            END IF 

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah003
            
            #add-point:AFTER FIELD faah003 name="input.a.faah003"
                        #此段落由子樣板a05產生
#            IF NOT cl_null(g_faah_m.faah003) AND NOT cl_null(g_faah_m.faah004) THEN    #mark by yangxf
             IF NOT cl_null(g_faah_m.faah001) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL THEN        #add by yangxf
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_faah_m.faah003 != g_faah003_t) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF g_para_data3 = 'Y' AND g_para_data2 ='N' AND g_faah_m.faah002 = '1'THEN  #161129-00046#1 add
                  #add--2015/07/01 By shiun--(S)
                  IF NOT s_aooi390_chk('3',g_faah_m.faah003) THEN
                     LET g_faah_m.faah003 = g_faah003_t
                     DISPLAY BY NAME g_faah_m.faah003
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/07/01 By shiun--(E)
                  END IF #161129-00046#1 add
               END IF
            END IF
#modify by yangxf
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_faah_m.faah003 != g_faah003_t) THEN 
               IF NOT afai100_faah003_chk() THEN 
                  NEXT FIELD faah003
               END IF
            END IF 
#modify by yangxf
            #2015/02/15 Add By 01727 客戶家財編為Key值,重複需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF NOT cl_null(g_faah_m.faah003) AND NOT cl_null(g_faah_m.faah002) AND g_faah_m.faah002 = '1' THEN  #类型为主件时候才需要判断
               LET l_count = 0
               SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                  AND faah003 = g_faah_m.faah003
               IF cl_null(l_count) THEN lET l_count = 0 END IF
               IF p_cmd = 'u' AND g_faah_m.faah003 = g_faah_m_t.faah003 AND l_count > 0 THEN    #修改狀態下把當前筆資料的計數去掉
                  LET l_count = l_count - 1
               END IF
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00449'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT   #150923
               END IF
            END IF
            #2015/02/15 Add ---(E)---
            #END add-point
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah003
            #add-point:ON CHANGE faah003 name="input.g.faah003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah004
            #add-point:BEFORE FIELD faah004 name="input.b.faah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah004
            
            #add-point:AFTER FIELD faah004 name="input.a.faah004"
             #此段落由子樣板a05產生
#            IF NOT cl_null(g_faah_m.faah003) AND NOT cl_null(g_faah_m.faah004) THEN    #mark by yangxf
             IF NOT cl_null(g_faah_m.faah001) AND NOT cl_null(g_faah_m.faah003) AND NOT cl_null(g_faah_m.faah004) THEN        #add by yangxf
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_faah_m.faah004 != g_faah004_t) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || "faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            IF NOT cl_null(g_faah_m.faah003) THEN
#               LET l_n = 0
#               SELECT count(*) INTO l_n 
#                 FROM faah_t
#                WHERE faahent = g_enterprise
#                  AND faah003 = g_faah_m.faah003
#                  AND faah004 = g_faah_m.faah004
#                  
#               IF l_n = 0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00252'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#           
#                  NEXT FIELD faah004
#               END IF 
#            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah004
            #add-point:ON CHANGE faah004 name="input.g.faah004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah002
            #add-point:BEFORE FIELD faah002 name="input.b.faah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah002
            
            #add-point:AFTER FIELD faah002 name="input.a.faah002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah002
            #add-point:ON CHANGE faah002 name="input.g.faah002"
            
            IF g_faah_m.faah002 = '1' THEN
               LET g_faah_m.faah004 = ' '
               CALL cl_set_comp_entry("faah004",FALSE)
            ELSE
               LET g_faah_m.faah004 = ''
               CALL cl_set_comp_entry("faah004",TRUE)
            END IF
            IF NOT cl_null(g_faah_m.faah003) THEN 
               LET l_n = 0
               SELECT count(*) INTO l_n 
                 FROM faah_t
                WHERE faahent = g_enterprise
                  AND faah003 = g_faah_m.faah003
                  AND faah002 = '1'
                  
               IF l_n = 0 THEN 
                  LET g_faah_m.faah003 = ''
                  DISPLAY BY NAME g_faah_m.faah003
               END IF 
            END IF
            IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
               CALL cl_set_comp_entry("faah003",FALSE)               
               LET g_faah_m.faah003 = g_faah_m.faah001
               DISPLAY BY NAME g_faah_m.faah003
               IF NOT cl_null(g_faah_m.faah001) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_faah_m.faah002 != g_faah_m_t.faah002 )) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || "faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN  
                        LET g_faah_m.faah002 = ''
                        NEXT FIELD faah002
                     END IF
                  END IF
               END IF
            ELSE
               CALL cl_set_comp_entry("faah003",TRUE)    
            END IF
            IF g_faah_m.faah002 != '1' THEN 
               IF cl_null(g_faah_m.faah003) THEN 
                  NEXT FIELD faah003
               END IF 
               IF cl_null(g_faah_m.faah004) THEN 
                  NEXT FIELD faah004
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="input.b.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="input.a.faah012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah012
            #add-point:ON CHANGE faah012 name="input.g.faah012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="input.b.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="input.a.faah013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah013
            #add-point:ON CHANGE faah013 name="input.g.faah013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah006
            
            #add-point:AFTER FIELD faah006 name="input.a.faah006"
                        CALL afai100_ref_show()
            CALL afai100_faah006_get()
            IF NOT cl_null(g_faah_m.faah006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah006
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,g_faah_m.faah032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str ," AND faal001 = '",g_faah_m.faah006,"'"
                  PREPARE afai100_faah006_count FROM g_sql
                  EXECUTE afai100_faah006_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01123'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah006 = g_faah_m_t.faah006
                     CALL afai100_depreciation_ref()
                     CALL afai100_faah006_get()
                     NEXT FIELD CURRENT  
                  ELSE
                     IF NOT cl_null(g_faah_m.faah006) THEN
                        LET l_cnt = 0 
                        SELECT COUNT(1) INTO l_cnt FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_faah_m.faah007 AND faad002 = g_faah_m.faah006
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        IF l_cnt = 0 THEN 
                           LET g_faah_m.faah007 = NULL
                           LET g_faah_m.faah007_desc = NULL                         
                        ELSE   
                           LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",g_faah_m.faah006,"'" 
                           PREPARE afai100_faah007_count1 FROM g_sql
                           EXECUTE afai100_faah007_count1 INTO l_cnt   
                           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                           IF l_cnt = 0 THEN 
                              LET g_faah_m.faah007 = NULL
                              LET g_faah_m.faah007_desc = NULL
                           END IF
                       END IF                          
                     END IF                     
                  END IF
                  #161111-00049#5 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah006 = g_faah_m_t.faah006
                  CALL afai100_ref_show()
                  CALL afai100_faah006_get()
                  NEXT FIELD CURRENT
               END IF
               
               #160426-00014#8 add s---
               IF NOT cl_null(g_faaj_m.faajld) AND NOT cl_null(g_faah_m.faah006) THEN
                  #抓取资产分类          
                  SELECT faal006 INTO g_faaj_m.faaj048
                    FROM faal_t
                   WHERE faalent = g_enterprise
                     AND faalld  = g_faaj_m.faajld
                     AND faal001 = g_faah_m.faah006 
                  DISPLAY g_faaj_m.faaj048 TO faaj048
                  #161121-00003#3 add s---
                  IF g_faaj_m.faaj048 = '1' THEN 
                     LET g_faaj_m.faaj003 = '5'
                     CALL cl_set_comp_entry("faaj003",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("faaj003",TRUE)
                  END IF
                  #161121-00003#3 add e---
               END IF      
               #160426-00014#8 add e---                
               
               CALL afai100_faah006_ref()
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah006
            #add-point:BEFORE FIELD faah006 name="input.b.faah006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah006
            #add-point:ON CHANGE faah006 name="input.g.faah006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah007
            
            #add-point:AFTER FIELD faah007 name="input.a.faah007"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah007  
               LET g_chkparam.arg2 = g_faah_m.faah006 #161111-00049#5 add
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#4--add--end
                   
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_faad001") THEN #161111-00049#5 mark
               IF cl_chk_exist("v_faad001_1") THEN #161111-00049#5 add
               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #20150623--add--str--lujh
                  #20150824--mark---s---
#                  IF NOT cl_null(g_faah_m.faah006) THEN 
#                     SELECT COUNT(*) INTO l_n
#                       FROM faad_t
#                      WHERE faadent = g_enterprise
#                        AND faad001 = g_faah_m.faah007
#                        AND faad002 = g_faah_m.faah006
#                        
#                     IF l_n = 0 THEN 
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = g_faah_m.faah007
#                        LET g_errparam.code   = 'afa-01028' 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        LET g_faah_m.faah007 = g_faah_m_t.faah007
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
                  #20150824--mark---e---
                  #20150623--add--str--lujh
                  #161111-00049#5 add s---
                  LET l_faad002 = NULL
                  IF cl_null(g_faah_m.faah006) THEN 
                     SELECT faad002 INTO l_faad002 FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_faah_m.faah007
                  ELSE
                     LET l_faad002 = g_faah_m.faah006                  
                  END IF   
                  CALL s_axrt300_get_site(g_user,g_faah_m.faah032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",l_faad002,"'" 
                  PREPARE afai100_faah007_count FROM g_sql
                  EXECUTE afai100_faah007_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01124'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah007 = g_faah_m_t.faah007
                     CALL afai100_ref_show()
                     NEXT FIELD CURRENT                   
                  END IF
                  #161111-00049#5 add e---                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah007 = g_faah_m_t.faah007
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah007
            #add-point:BEFORE FIELD faah007 name="input.b.faah007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah007
            #add-point:ON CHANGE faah007 name="input.g.faah007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah005
            #add-point:BEFORE FIELD faah005 name="input.b.faah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah005
            
            #add-point:AFTER FIELD faah005 name="input.a.faah005"

            #-160415-00009-mark- 
            IF g_faah_m.faah005 = '5' THEN
               LET g_faah_m.faah018 = 1 
            END IF
            #-160415-00009-end-
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah005
            #add-point:ON CHANGE faah005 name="input.g.faah005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faahstus
            #add-point:BEFORE FIELD faahstus name="input.b.faahstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faahstus
            
            #add-point:AFTER FIELD faahstus name="input.a.faahstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faahstus
            #add-point:ON CHANGE faahstus name="input.g.faahstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah014
            #add-point:BEFORE FIELD faah014 name="input.b.faah014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah014
            
            #add-point:AFTER FIELD faah014 name="input.a.faah014"

            IF NOT cl_null(g_faaj_m.faajld) AND NOT cl_null(g_faah_m.faah014) AND NOT cl_null(g_faah_m.faah006) THEN
               #抓取本月入帳提列方式
               LET g_faal005 = ''          #160126-00006#1 add lujh 
               SELECT faal005 INTO g_faal005
                 FROM faal_t
                WHERE faalent = g_enterprise
                  AND faalld  = g_faaj_m.faajld
                  AND faal001 = g_faah_m.faah006
               
               LET l_year = YEAR(g_faah_m.faah014)
               LET l_month = MONTH(g_faah_m.faah014)
               IF NOT cl_null(g_faal005) THEN 
                  IF g_faal005 = '1' THEN 
                     LET l_num2 = l_month + 1
                     IF l_num2 > 12 THEN 
                        LET l_num2 = 1
                        LET l_num1 = l_year + 1
                     ELSE
                        LET l_num2 = l_num2
                        LET l_num1 = l_year
                     END IF
                  END IF 
                  IF g_faal005 = '2' OR g_faal005 = '4' THEN 
                     LET l_num1 = l_year
                     LET l_num2 = l_month
                  END IF
                  IF g_faal005 = '3' THEN
                     CALL s_date_get_first_date(g_faah_m.faah014) RETURNING l_fristdate
                     LET l_fristdate = l_fristdate + 14
                     IF g_faah_m.faah014 <= l_fristdate THEN 
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
                  LET g_faaj_m.faaj008 = l_str.trim()
                  IF NOT cl_null(g_faaj_m.faajld) THEN 
                     DISPLAY g_faaj_m.faaj008 TO faaj008
                  END IF
                  UPDATE faaj_t SET (faaj008) = (g_faaj_m.faaj008)
                   WHERE faajent = g_enterprise
                     AND faajld = g_faaj_m.faajld
                     AND faaj000 = g_faaj_m.faaj000
                     AND faaj001 = g_faaj_m.faaj001
                     AND faaj002 = g_faaj_m.faaj002 
                     AND faaj037 = g_faaj_m.faaj037  
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah014
            #add-point:ON CHANGE faah014 name="input.g.faah014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah015
            #add-point:BEFORE FIELD faah015 name="input.b.faah015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah015
            
            #add-point:AFTER FIELD faah015 name="input.a.faah015"
            #161104-00048#1 add s---
            IF NOT cl_null(g_faah_m.faah015) THEN
               LET g_faaj_m.faaj038 = g_faah_m.faah015   
            END IF
            #161104-00048#1 add e---           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah015
            #add-point:ON CHANGE faah015 name="input.g.faah015"
            #161104-00048#1 add s---
            IF NOT cl_null(g_faah_m.faah015) THEN
               LET g_faaj_m.faaj038 = g_faah_m.faah015   
            END IF
            #161104-00048#1 add e---              
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah016
            #add-point:BEFORE FIELD faah016 name="input.b.faah016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah016
            
            #add-point:AFTER FIELD faah016 name="input.a.faah016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah016
            #add-point:ON CHANGE faah016 name="input.g.faah016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah017
            
            #add-point:AFTER FIELD faah017 name="input.a.faah017"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah017
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  CALL afai100_ref_show()
                  LET g_faah_m.faah017 = g_faah_m_t.faah017
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah017
            #add-point:BEFORE FIELD faah017 name="input.b.faah017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah017
            #add-point:ON CHANGE faah017 name="input.g.faah017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah018,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah018
            END IF 
 
 
 
            #add-point:AFTER FIELD faah018 name="input.a.faah018"
            IF NOT cl_null(g_faah_m.faah018) THEN 
               ###########################add by huangtao\faah005=5费用时，数量只能为1
              #-160415-00009-mark- 
              #IF g_faah_m.faah005 = '5' THEN
              #   IF g_faah_m.faah018 <> 1 THEN
              #      INITIALIZE g_errparam TO NULL
              #      LET g_errparam.code = 'afa-00383'
              #      LET g_errparam.extend = ''
              #      LET g_errparam.popup = TRUE
              #      CALL cl_err()
              #      LET g_faah_m.faah018 = g_faah_m_t.faah018
              #      NEXT FIELD faah018
              #   END IF
              #END IF
              #-160415-00009-end-
               ###########################add by huangtao
               LET l_faai007_sum = 0
               SELECT SUM(faai007) INTO l_faai007_sum
                 FROM faai_t
                WHERE faaient = g_enterprise
                  AND faai001 = g_faah_m.faah001
                  AND faai002 = g_faah_m.faah003
                  AND faai003 = g_faah_m.faah004       
               IF l_faai007_sum > g_faah_m.faah018 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00019'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faah_m.faah018 = g_faah_m_t.faah018
                  NEXT FIELD faah018
               END IF
               
             #########################add by huangtao \在外数量不能大于总数量
               IF NOT cl_null(g_faah_m.faah019) THEN
                  IF g_faah_m.faah019 > g_faah_m.faah018 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00204'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah018 = g_faah_m_t.faah018
                     NEXT FIELD faah018
                  END IF
               END IF
            #########################add by huangtao
            END IF 
            IF NOT cl_null(g_faah_m.faah021) THEN 
               LET g_faah_m.faah022 = g_faah_m.faah018 * g_faah_m.faah021
            END IF 
            IF NOT cl_null(g_faah_m.faah023) THEN 
               LET g_faah_m.faah024 = g_faah_m.faah018 * g_faah_m.faah023
            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah018
            #add-point:BEFORE FIELD faah018 name="input.b.faah018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah018
            #add-point:ON CHANGE faah018 name="input.g.faah018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah019,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah019
            END IF 
 
 
 
            #add-point:AFTER FIELD faah019 name="input.a.faah019"
            #########################add by huangtao \在外数量不能大于总数量
            IF NOT cl_null(g_faah_m.faah019) AND NOT cl_null(g_faah_m.faah018) THEN
               IF g_faah_m.faah019 > g_faah_m.faah018 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00204'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faah_m.faah019 = g_faah_m_t.faah019
                  NEXT FIELD faah019
               END IF
            END IF
            #########################add by huangtao
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah019
            #add-point:BEFORE FIELD faah019 name="input.b.faah019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah019
            #add-point:ON CHANGE faah019 name="input.g.faah019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah020
            
            #add-point:AFTER FIELD faah020 name="input.a.faah020"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah020
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL afai100_get_exrate(g_glaald,g_faah_m.faah020,g_glaa001,g_glaa025)
                  IF NOT cl_null(g_faah_m.faah021) AND NOT cl_null(g_faah_m.faah018) THEN 
                     LET g_faah_m.faah022 = g_faah_m.faah018 * g_faah_m.faah021
                     IF g_faah_m.faah018 <> g_faah_m_t.faah018 OR g_faah_m.faah021 <> g_faah_m_t.faah021 OR g_faah_m.faah020 <> g_faah_m_t.faah020 THEN 
                        LET g_faah_m.faah023 = g_faah_m.faah021 * g_ooan005
                        LET g_faah_m.faah024 = g_faah_m.faah018 * g_faah_m.faah023
                     END IF
                     DISPLAY g_faah_m.faah022 TO faah022
                     DISPLAY g_faah_m.faah023 TO faah023
                     DISPLAY g_faah_m.faah024 TO faah024
                  END IF
                  #单头“币别”栏位更改后，其他本位币页签下的金额汇率重新获取。
                 
                  #IF g_faah_m.faah020 <> g_faah_m_t.faah020 THEN  #161129-00055#1 mark
                  IF g_faah_m.faah020 <> g_faah_m_t.faah020 AND p_cmd = 'u' THEN #161129-00055#1 add
                     CALL afai100_update_exrate()
                  END IF
 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah020 = g_faah_m_t.faah020
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            
               #獲取匯率
               CALL afai100_faaj015_desc_get()
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah020
            #add-point:BEFORE FIELD faah020 name="input.b.faah020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah020
            #add-point:ON CHANGE faah020 name="input.g.faah020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah021,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah021
            END IF 
 
 
 
            #add-point:AFTER FIELD faah021 name="input.a.faah021"
            CALL afai100_get_exrate(g_glaald,g_faah_m.faah020,g_glaa001,g_glaa025)
            IF NOT cl_null(g_faah_m.faah021) AND NOT cl_null(g_faah_m.faah018) THEN 
               LET g_faah_m.faah022 = g_faah_m.faah018 * g_faah_m.faah021
               IF g_faah_m.faah018 <> g_faah_m_t.faah018 OR g_faah_m.faah021 <> g_faah_m_t.faah021 THEN 
                  LET g_faah_m.faah023 = g_faah_m.faah021 * g_ooan005
                  LET g_faah_m.faah024 = g_faah_m.faah018 * g_faah_m.faah023
               END IF
               
               DISPLAY g_faah_m.faah022 TO faah022
               DISPLAY g_faah_m.faah023 TO faah023
               DISPLAY g_faah_m.faah024 TO faah024
            END IF 
            
            
            IF NOT cl_null(g_faah_m.faah021) AND NOT cl_null(g_faah_m.faah023) AND g_faah_m.faah020 = g_glaa001 THEN 
               IF g_faah_m.faah021 <> g_faah_m.faah023 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faah_m.faah021 = g_faah_m_t.faah021
                  NEXT FIELD faah021
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah021
            #add-point:BEFORE FIELD faah021 name="input.b.faah021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah021
            #add-point:ON CHANGE faah021 name="input.g.faah021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah022,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah022
            END IF 
 
 
 
            #add-point:AFTER FIELD faah022 name="input.a.faah022"
#            IF NOT cl_null(g_faah_m.faah018) AND NOT cl_null(g_faah_m.faah022) AND g_faah_m.faah018 <> 0 THEN
#               IF cl_null(g_faah_m.faah021) OR g_faah_m.faah021 = 0 THEN 
#                  LET g_faah_m.faah021 = g_faah_m.faah022 / g_faah_m.faah018
#               END IF
#            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah022
            #add-point:BEFORE FIELD faah022 name="input.b.faah022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah022
            #add-point:ON CHANGE faah022 name="input.g.faah022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah023,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah023
            END IF 
 
 
 
            #add-point:AFTER FIELD faah023 name="input.a.faah023"
            IF NOT cl_null(g_faah_m.faah021) AND NOT cl_null(g_faah_m.faah023) AND g_faah_m.faah020 = g_glaa001 THEN 
               IF g_faah_m.faah021 <> g_faah_m.faah023 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faah_m.faah023 = g_faah_m_t.faah023
                  NEXT FIELD faah023
               END IF
            END IF
            IF NOT cl_null(g_faah_m.faah023) AND NOT cl_null(g_faah_m.faah018) THEN 
               LET g_faah_m.faah024 = g_faah_m.faah018 * g_faah_m.faah023
               DISPLAY BY NAME g_faah_m.faah024
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah023
            #add-point:BEFORE FIELD faah023 name="input.b.faah023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah023
            #add-point:ON CHANGE faah023 name="input.g.faah023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah024,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah024
            END IF 
 
 
 
            #add-point:AFTER FIELD faah024 name="input.a.faah024"

#            IF NOT cl_null(g_faah_m.faah018) AND NOT cl_null(g_faah_m.faah024) AND g_faah_m.faah018 <> 0  THEN 
#               IF cl_null(g_faah_m.faah023) OR g_faah_m.faah023 = 0 THEN 
#                  LET g_faah_m.faah023 = g_faah_m.faah024 / g_faah_m.faah018
#               END IF 
#            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah024
            #add-point:BEFORE FIELD faah024 name="input.b.faah024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah024
            #add-point:ON CHANGE faah024 name="input.g.faah024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="input.a.faah025"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah025) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah025
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT ooag003 INTO g_faah_m.faah026 
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_faah_m.faah025
                  CALL afai100_ref_show()
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah025 = g_faah_m_t.faah025
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="input.b.faah025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah025
            #add-point:ON CHANGE faah025 name="input.g.faah025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="input.a.faah026"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah026) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah026
               LET g_chkparam.arg2 = g_today
			      #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
			   
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah026 = g_faah_m_t.faah026
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
         

            END IF   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="input.b.faah026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah026
            #add-point:ON CHANGE faah026 name="input.g.faah026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah027
            
            #add-point:AFTER FIELD faah027 name="input.a.faah027"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah027) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah027

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  LET l_cnt = 0
                  #161111-00049#5 add s---
                  SELECT COUNT(1) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '3900' 
                     AND oocq002 = g_faah_m.faah027 AND (oocq004 = g_faah_m.faah032 OR oocq004 IS NULL) #161111-00049#5 1116
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01120'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah027 = g_faah_m_t.faah027
                     CALL afai100_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF  
                  #161111-00049#5 add e---                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah027 = g_faah_m_t.faah027
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah027
            #add-point:BEFORE FIELD faah027 name="input.b.faah027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah027
            #add-point:ON CHANGE faah027 name="input.g.faah027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah028
            
            #add-point:AFTER FIELD faah028 name="input.a.faah028"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah028) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah028
               LET g_chkparam.arg2 = g_site
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_faab002") THEN
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faah_m.faah028,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah028 = g_faah_m_t.faah028
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---
                  
                  IF g_faah_m.faah028 <> g_faah_m_o.faah028 OR cl_null(g_faah_m_o.faah028) THEN  
                     LET l_ooef017 = ''  LET l_ooef017_t = ''    
                     SELECT ooef017 INTO l_ooef017
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_faah_m.faah028
                     SELECT ooef017 INTO l_ooef017_t
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_faah_m_o.faah028 
                     SELECT glaa001,glaald INTO l_glaa001,l_glaald,g_glaa025
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = l_ooef017
                        AND glaa014 = 'Y'
                        
                     LET g_glaald = l_glaald
                     LET g_glaa001 = l_glaa001
                           
#                     CALL cl_get_para(g_enterprise,g_site,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號    #mark by yangxf
#   
#                     CALL cl_get_para(g_enterprise,g_site,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值        #mark by yangxf
                     CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
                     CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
                     SELECT glaa001 INTO l_glaa001_t
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = l_ooef017_t
                        AND glaa014 = 'Y'
                        
                     IF l_ooef017 <> l_ooef017_t AND l_glaa001_t <> l_glaa001 THEN
                        CALL afai100_get_exrate(l_glaald,g_faah_m.faah020,l_glaa001,g_glaa025)
                        LET g_faah_m.faah023 = g_faah_m.faah021 * g_ooan005
                        LET g_faah_m.faah024 = g_faah_m.faah018 * g_faah_m.faah023
                        DISPLAY g_faah_m.faah023 TO faah023
                        DISPLAY g_faah_m.faah024 TO faah024
                     END IF
                     IF l_ooef017 <> l_ooef017_t THEN
                        CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
                        CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
                        CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
                        CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9010') RETURNING g_para_data3  #財编自动编号否
                        
                        #161009-00006#1--add--str--lujh
                        SELECT ooef017 INTO g_faah_m.faah032
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_faah_m.faah028
                        #161111-00049#5 add s---
                        #檢查主要類型是不在此所有組織下
                        IF NOT cl_null(g_faah_m.faah006) THEN 
                           CALL s_axrt300_get_site(g_user,g_faah_m.faah032,'2') RETURNING l_ld_str 
                           LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                           LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str ," AND faal001 = '",g_faah_m.faah006,"'"
                           PREPARE afai100_faah006_count1 FROM g_sql
                           EXECUTE afai100_faah006_count1 INTO l_cnt   
                           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                           IF l_cnt = 0 THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'afa-01123'
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              NEXT FIELD faah006  
                           END IF 
                        END IF                        
                        #161111-00049#5 add e---                        
                        IF g_para_data = 'Y' THEN   #卡片編號自動編號,按新的法人重新编号
                           LET l_sql =  " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0))) + 1),10,'0') FROM faah_t ",
                                        "  WHERE faahent ='",g_enterprise,"'",
                                        "    AND regexp_substr(faah001,'[0-9]+') IS NOT NULL",
                                        "    AND faah032 = '",g_faah_m.faah032,"'"                 
                           PREPARE sel_faah001_1 FROM l_sql
                           EXECUTE sel_faah001_1 INTO g_faah_m.faah001
                        ELSE  #卡片編號不自動編號,清空卡片编号让用户重新输入
                           LET g_faah_m.faah001 = ''
                        END IF
                        
                        IF g_para_data2 = 'Y' THEN 
                           LET g_faah_m.faah003 = g_faah_m.faah001
                        ELSE
                           LET g_faah_m.faah003 = g_faah_m_t.faah003
                        END IF
                        #161009-00006#1--add--end--lujh
                     END IF 
                  
                     ################################add by huangtao
                     CALL afai100_set_entry(p_cmd)
                     CALL afai100_set_no_entry(p_cmd)
                     LET g_faah_m_o.faah028 = g_faah_m.faah028
                     ################################add by huangtao
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah028 = g_faah_m_t.faah028
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            IF NOT cl_null(g_faah_m.faah028) THEN 
              SELECT ooef017 INTO g_faah_m.faah032
                FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = g_faah_m.faah028
              DISPLAY g_faah_m.faah032 TO faah032
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah028
            #add-point:BEFORE FIELD faah028 name="input.b.faah028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah028
            #add-point:ON CHANGE faah028 name="input.g.faah028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah030
            
            #add-point:AFTER FIELD faah030 name="input.a.faah030"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah030
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161009-00006#1--add--str--lujh
                  SELECT ooef207 INTO l_ooef207
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_faah_m.faah030
                     
                  IF l_ooef207 <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "afa-00277" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_faah_m.faah030 = g_faah_m_t.faah030
                     CALL afai100_ref_show()
                     NEXT FIELD CURRENT
                  END IF
                  #161009-00006#1--add--end--lujh
                  
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faah_m.faah030,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah030 = g_faah_m_t.faah030
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah030 = g_faah_m_t.faah030
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
#               SELECT ooag004 INTO l_ooag004
#                 FROM ooag_t
#                WHERE ooagent = g_enterprise
#                  AND ooag001 = g_user
#               IF l_ooag004 != g_faah_m.faah030 THEN 
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = "afa-00286" 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  LET g_faah_m.faah030 = g_faah_m_t.faah030
#                  CALL afai100_ref_show()
#                  NEXT FIELD CURRENT
#               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah030
            #add-point:BEFORE FIELD faah030 name="input.b.faah030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah030
            #add-point:ON CHANGE faah030 name="input.g.faah030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah031
            
            #add-point:AFTER FIELD faah031 name="input.a.faah031"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah031) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah031
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_faah_m.faah031
                     
                  #IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN     #161009-00006#1 mark lujh
                  IF l_ooef204 = 'N' THEN                          #161009-00006#1 add lujh
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     #LET g_errparam.code   = "afa-00325"    #161009-00006#1 mark lujh
                     LET g_errparam.code   = "afa-00120"     #161009-00006#1 add lujh
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_faah_m.faah031 = g_faah_m_t.faah031
                     CALL afai100_ref_show()
                  END IF
                  
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faah_m.faah031,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah031 = g_faah_m_t.faah031
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah031 = g_faah_m_t.faah031
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah031
            #add-point:BEFORE FIELD faah031 name="input.b.faah031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah031
            #add-point:ON CHANGE faah031 name="input.g.faah031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah032
            
            #add-point:AFTER FIELD faah032 name="input.a.faah032"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah032) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah032
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN #161024-00008#1
               IF cl_chk_exist("v_ooef001_1") THEN #161024-00008#1
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah032 = g_faah_m_t.faah032
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
               #獲取匯率
               CALL afai100_faaj015_desc_get()
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah032
            #add-point:BEFORE FIELD faah032 name="input.b.faah032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah032
            #add-point:ON CHANGE faah032 name="input.g.faah032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah029
            
            #add-point:AFTER FIELD faah029 name="input.a.faah029"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah029) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah029
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah029 = g_faah_m_t.faah029
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah029
            #add-point:BEFORE FIELD faah029 name="input.b.faah029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah029
            #add-point:ON CHANGE faah029 name="input.g.faah029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah009
            
            #add-point:AFTER FIELD faah009 name="input.a.faah009"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  
                  #161111-00049#5 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_faah_m.faah032 AND pmab001 = g_faah_m.faah009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah009 = g_faah_m_t.faah009
                     CALL afai100_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---
                  LET g_faah_m.faah010 = g_faah_m.faah009
                  CALL afai100_ref_show()
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah009 = g_faah_m_t.faah009
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah009
            #add-point:BEFORE FIELD faah009 name="input.b.faah009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah009
            #add-point:ON CHANGE faah009 name="input.g.faah009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah000
            #add-point:BEFORE FIELD faah000 name="input.b.faah000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah000
            
            #add-point:AFTER FIELD faah000 name="input.a.faah000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah000
            #add-point:ON CHANGE faah000 name="input.g.faah000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah010
            
            #add-point:AFTER FIELD faah010 name="input.a.faah010"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah010
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_faah_m.faah032 AND pmab001 = g_faah_m.faah009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faah_m.faah010 = g_faah_m_t.faah010
                     CALL afai100_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e--- 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah010 = g_faah_m_t.faah010
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah010
            #add-point:BEFORE FIELD faah010 name="input.b.faah010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah010
            #add-point:ON CHANGE faah010 name="input.g.faah010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah011
            
            #add-point:AFTER FIELD faah011 name="input.a.faah011"
            CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah011 = g_faah_m_t.faah011
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah011
            #add-point:BEFORE FIELD faah011 name="input.b.faah011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah011
            #add-point:ON CHANGE faah011 name="input.g.faah011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah046
            #add-point:BEFORE FIELD faah046 name="input.b.faah046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah046
            
            #add-point:AFTER FIELD faah046 name="input.a.faah046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah046
            #add-point:ON CHANGE faah046 name="input.g.faah046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah033
            #add-point:BEFORE FIELD faah033 name="input.b.faah033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah033
            
            #add-point:AFTER FIELD faah033 name="input.a.faah033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah033
            #add-point:ON CHANGE faah033 name="input.g.faah033"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah008
            
            #add-point:AFTER FIELD faah008 name="input.a.faah008"
                        CALL afai100_ref_show()
            IF NOT cl_null(g_faah_m.faah008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah008
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00011:sub-01302|afai110|",cl_get_progname("afai110",g_lang,"2"),"|:EXEPROGafai110"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3903") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah008 = g_faah_m_t.faah008
                  CALL afai100_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah008
            #add-point:BEFORE FIELD faah008 name="input.b.faah008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah008
            #add-point:ON CHANGE faah008 name="input.g.faah008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah042
            #add-point:BEFORE FIELD faah042 name="input.b.faah042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah042
            
            #add-point:AFTER FIELD faah042 name="input.a.faah042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah042
            #add-point:ON CHANGE faah042 name="input.g.faah042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah035
            #add-point:BEFORE FIELD faah035 name="input.b.faah035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah035
            
            #add-point:AFTER FIELD faah035 name="input.a.faah035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah035
            #add-point:ON CHANGE faah035 name="input.g.faah035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah036
            #add-point:BEFORE FIELD faah036 name="input.b.faah036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah036
            
            #add-point:AFTER FIELD faah036 name="input.a.faah036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah036
            #add-point:ON CHANGE faah036 name="input.g.faah036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah037
            #add-point:BEFORE FIELD faah037 name="input.b.faah037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah037
            
            #add-point:AFTER FIELD faah037 name="input.a.faah037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah037
            #add-point:ON CHANGE faah037 name="input.g.faah037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah043
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah043,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah043
            END IF 
 
 
 
            #add-point:AFTER FIELD faah043 name="input.a.faah043"
                        IF NOT cl_null(g_faah_m.faah043) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah043
            #add-point:BEFORE FIELD faah043 name="input.b.faah043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah043
            #add-point:ON CHANGE faah043 name="input.g.faah043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah044,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faah044
            END IF 
 
 
 
            #add-point:AFTER FIELD faah044 name="input.a.faah044"
                        IF NOT cl_null(g_faah_m.faah044) AND NOT cl_null(g_faah_m.faah043) THEN 
               IF g_faah_m.faah044 > g_faah_m.faah043 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00018'
                  LET g_errparam.extend = g_faah_m.faah044
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faah_m.faah044 = g_faah_m_t.faah044
                  NEXT FIELD faah044
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah044
            #add-point:BEFORE FIELD faah044 name="input.b.faah044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah044
            #add-point:ON CHANGE faah044 name="input.g.faah044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah041
            
            #add-point:AFTER FIELD faah041 name="input.a.faah041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah041
            #add-point:BEFORE FIELD faah041 name="input.b.faah041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah041
            #add-point:ON CHANGE faah041 name="input.g.faah041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah038
            #add-point:BEFORE FIELD faah038 name="input.b.faah038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah038
            
            #add-point:AFTER FIELD faah038 name="input.a.faah038"
            IF NOT cl_null(g_faah_m.faah038) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah038
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00337:sub-01302|apmt500|",cl_get_progname("apmt500",g_lang,"2"),"|:EXEPROGapmt500"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmdldocno") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah038 = g_faah_m_t.faah038
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah038
            #add-point:ON CHANGE faah038 name="input.g.faah038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah039
            #add-point:BEFORE FIELD faah039 name="input.b.faah039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah039
            
            #add-point:AFTER FIELD faah039 name="input.a.faah039"
            IF NOT cl_null(g_faah_m.faah039) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah039
               
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmdsdocno_10") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah039 = g_faah_m_t.faah039
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah039
            #add-point:ON CHANGE faah039 name="input.g.faah039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah040
            #add-point:BEFORE FIELD faah040 name="input.b.faah040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah040
            
            #add-point:AFTER FIELD faah040 name="input.a.faah040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah040
            #add-point:ON CHANGE faah040 name="input.g.faah040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah057
            #add-point:BEFORE FIELD faah057 name="input.b.faah057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah057
            
            #add-point:AFTER FIELD faah057 name="input.a.faah057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah057
            #add-point:ON CHANGE faah057 name="input.g.faah057"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah050
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faah_m.faah050,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD faah050
            END IF 
 
 
 
            #add-point:AFTER FIELD faah050 name="input.a.faah050"
            IF NOT cl_null(g_faah_m.faah050) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah050
            #add-point:BEFORE FIELD faah050 name="input.b.faah050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah050
            #add-point:ON CHANGE faah050 name="input.g.faah050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah054
            #add-point:BEFORE FIELD faah054 name="input.b.faah054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah054
            
            #add-point:AFTER FIELD faah054 name="input.a.faah054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah054
            #add-point:ON CHANGE faah054 name="input.g.faah054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah055
            #add-point:BEFORE FIELD faah055 name="input.b.faah055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah055
            
            #add-point:AFTER FIELD faah055 name="input.a.faah055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah055
            #add-point:ON CHANGE faah055 name="input.g.faah055"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.faah001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah001
            #add-point:ON ACTION controlp INFIELD faah001 name="input.c.faah001"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah003
            #add-point:ON ACTION controlp INFIELD faah003 name="input.c.faah003"
            IF g_faah_m.faah002 = '2' OR g_faah_m.faah002 = '3' THEN
               #此段落由子樣板a07產生            
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_faah_m.faah003             #給予default值
               IF NOT cl_null(g_faah_m.faah004) THEN
                  LET g_qryparam.where = " faah004 = '",g_faah_m.faah004,"'"
               END IF
               #############################add by huangtao
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND faah015 = '10' AND faah002 = '1'"
               ELSE
                  LET g_qryparam.where = "faah015 = '10' AND faah002 = '1'"
               END IF
               #############################add by huangtao
               
               #給予arg
               
               CALL q_faah003()                                #呼叫開窗
               
               LET g_faah_m.faah003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_qryparam.where = " "
               
               DISPLAY g_faah_m.faah003 TO faah003              #顯示到畫面上

               NEXT FIELD faah003                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah004
            #add-point:ON ACTION controlp INFIELD faah004 name="input.c.faah004"
            IF g_faah_m.faah002 = '2' THEN
               #此段落由子樣板a07產生            
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_faah_m.faah004             #給予default值
               IF NOT cl_null(g_faah_m.faah003) THEN
                  LET g_qryparam.where = " faah003 = '",g_faah_m.faah003,"'"
               END IF
               
               #給予arg
               
               CALL q_faah004()                                #呼叫開窗
               
               LET g_faah_m.faah004 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               LET g_qryparam.where = " "
               
               DISPLAY g_faah_m.faah004 TO faah004              #顯示到畫面上

               NEXT FIELD faah004                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.faah002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah002
            #add-point:ON ACTION controlp INFIELD faah002 name="input.c.faah002"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="input.c.faah012"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="input.c.faah013"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006 name="input.c.faah006"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah006             #給予default值

            #給予arg
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_faah_m.faah032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#5 add e--- 
            #CALL q_faac001()                    #呼叫開窗 #161111-00049#5 mark

            LET g_faah_m.faah006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah006 TO faah006              #顯示到畫面上
            CALL afai100_ref_show()
            CALL afai100_faah006_get()
            NEXT FIELD faah006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007 name="input.c.faah007"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah007             #給予default值
            #20150623--add--str--lujh
            #20150824--mark---s---
#            IF NOT cl_null(g_faah_m.faah006) THEN 
#               LET g_qryparam.where = " faad002 = '",g_faah_m.faah006,"'"
#            END IF
            #20150824--mark---e---
            #20150623--add--end--lujh
            #給予arg
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_faah_m.faah032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 = '",g_faah_m.faah006,"' AND faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#5 add e---
            CALL q_faad001()                                #呼叫開窗

            LET g_faah_m.faah007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah007 TO faah007              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah005
            #add-point:ON ACTION controlp INFIELD faah005 name="input.c.faah005"
            
            #END add-point
 
 
         #Ctrlp:input.c.faahstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faahstus
            #add-point:ON ACTION controlp INFIELD faahstus name="input.c.faahstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah014
            #add-point:ON ACTION controlp INFIELD faah014 name="input.c.faah014"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah015
            #add-point:ON ACTION controlp INFIELD faah015 name="input.c.faah015"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah016
            #add-point:ON ACTION controlp INFIELD faah016 name="input.c.faah016"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah017
            #add-point:ON ACTION controlp INFIELD faah017 name="input.c.faah017"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah017             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_faah_m.faah017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah017 TO faah017              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah018
            #add-point:ON ACTION controlp INFIELD faah018 name="input.c.faah018"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah019
            #add-point:ON ACTION controlp INFIELD faah019 name="input.c.faah019"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah020
            #add-point:ON ACTION controlp INFIELD faah020 name="input.c.faah020"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah020             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_faah_m.faah020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah020 TO faah020              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah021
            #add-point:ON ACTION controlp INFIELD faah021 name="input.c.faah021"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah022
            #add-point:ON ACTION controlp INFIELD faah022 name="input.c.faah022"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah023
            #add-point:ON ACTION controlp INFIELD faah023 name="input.c.faah023"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah024
            #add-point:ON ACTION controlp INFIELD faah024 name="input.c.faah024"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="input.c.faah025"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah025             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faah_m.faah025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah025 TO faah025              #顯示到畫面上
            SELECT ooag003 INTO g_faah_m.faah026 
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_faah_m.faah025
            CALL afai100_ref_show()
            NEXT FIELD faah025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="input.c.faah026"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_faah_m.faah026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah026 TO faah026              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah027
            #add-point:ON ACTION controlp INFIELD faah027 name="input.c.faah027"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah027             #給予default值
            LET g_qryparam.where = " (oocq004 = '",g_faah_m.faah032,"' OR oocq004 IS NULL)" #161111-00049#5 1116 add

            #給予arg
            LET g_qryparam.arg1 = '3900'

            CALL q_oocq002()                                #呼叫開窗

            LET g_faah_m.faah027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah027 TO faah027              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah028
            #add-point:ON ACTION controlp INFIELD faah028 name="input.c.faah028"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah028             #給予default值
            #LET g_qryparam.where = " faab004 = '",g_site,"'"
            
            LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            #給予arg

            #CALL q_faab001()                                #呼叫開窗
            CALL q_ooef001()

            LET g_faah_m.faah028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah028 TO faah028              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah030
            #add-point:ON ACTION controlp INFIELD faah030 name="input.c.faah030"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah030             #給予default值
            
            LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str     #161009-00006#1 add lujh    #161017-00023#1 add l_comp_str lujh  
            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_faah_m.faah030 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah030 TO faah030              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah031
            #add-point:ON ACTION controlp INFIELD faah031 name="input.c.faah031"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah031             #給予default值
            #LET g_qryparam.where = " ooef204 = 'Y' OR ooef003 = 'Y'"   #161009-00006#1 mark lujh
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str     #161009-00006#1 add lujh     #161017-00023#1 add l_comp_str lujh  
            #給予arg

            CALL q_ooef001()                               #呼叫開窗

            LET g_faah_m.faah031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah031 TO faah031              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah032
            #add-point:ON ACTION controlp INFIELD faah032 name="input.c.faah032"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah032             #給予default值

            #給予arg

            #CALL q_ooef001()                                #呼叫開窗  #161024-00008#1---mark
            CALL q_ooef001_2()                                          #161024-00008#1---add---

            LET g_faah_m.faah032 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah032 TO faah032              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah029
            #add-point:ON ACTION controlp INFIELD faah029 name="input.c.faah029"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah029             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faah_m.faah029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah029 TO faah029              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah009
            #add-point:ON ACTION controlp INFIELD faah009 name="input.c.faah009"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah009             #給予default值

            #給予arg
            #161111-00049#5 mod s--
            #CALL q_pmaa001_10()   #呼叫開窗  
            LET g_qryparam.arg1 = "('1','3')"
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_faah_m.faah032,"')  "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--
            LET g_faah_m.faah009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah009 TO faah009              #顯示到畫面上
            LET g_faah_m.faah010 = g_faah_m.faah009
            CALL afai100_ref_show()
            NEXT FIELD faah009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah000
            #add-point:ON ACTION controlp INFIELD faah000 name="input.c.faah000"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah010
            #add-point:ON ACTION controlp INFIELD faah010 name="input.c.faah010"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah010             #給予default值
            LET g_qryparam.where = " pmaastus = 'Y'"
            #給予arg

            #161111-00049#5 mod s--
            #CALL q_pmaa001_5()                                #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_faah_m.faah032,"')  "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--
            LET g_faah_m.faah010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah010 TO faah010              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah011
            #add-point:ON ACTION controlp INFIELD faah011 name="input.c.faah011"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah011             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_faah_m.faah011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah011 TO faah011              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah046
            #add-point:ON ACTION controlp INFIELD faah046 name="input.c.faah046"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah033
            #add-point:ON ACTION controlp INFIELD faah033 name="input.c.faah033"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah008
            #add-point:ON ACTION controlp INFIELD faah008 name="input.c.faah008"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '3903' #

            CALL q_oocq002()                                #呼叫開窗

            LET g_faah_m.faah008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah008 TO faah008              #顯示到畫面上
            CALL afai100_ref_show()
            NEXT FIELD faah008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faah042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah042
            #add-point:ON ACTION controlp INFIELD faah042 name="input.c.faah042"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah035
            #add-point:ON ACTION controlp INFIELD faah035 name="input.c.faah035"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah036
            #add-point:ON ACTION controlp INFIELD faah036 name="input.c.faah036"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah037
            #add-point:ON ACTION controlp INFIELD faah037 name="input.c.faah037"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah043
            #add-point:ON ACTION controlp INFIELD faah043 name="input.c.faah043"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah044
            #add-point:ON ACTION controlp INFIELD faah044 name="input.c.faah044"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah041
            #add-point:ON ACTION controlp INFIELD faah041 name="input.c.faah041"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah038
            #add-point:ON ACTION controlp INFIELD faah038 name="input.c.faah038"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah038             #給予default值
            #給予arg

            CALL q_pmdldocno()

            LET g_faah_m.faah038 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah038 TO faah038              #顯示到畫面上

            NEXT FIELD faah038   
            #END add-point
 
 
         #Ctrlp:input.c.faah039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah039
            #add-point:ON ACTION controlp INFIELD faah039 name="input.c.faah039"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah039             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '1'
            CALL q_pmdsdocno()                           #呼叫開窗

            LET g_faah_m.faah039 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah039 TO faah039              #顯示到畫面上

            NEXT FIELD faah039  
            #END add-point
 
 
         #Ctrlp:input.c.faah040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah040
            #add-point:ON ACTION controlp INFIELD faah040 name="input.c.faah040"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah057
            #add-point:ON ACTION controlp INFIELD faah057 name="input.c.faah057"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah050
            #add-point:ON ACTION controlp INFIELD faah050 name="input.c.faah050"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah054
            #add-point:ON ACTION controlp INFIELD faah054 name="input.c.faah054"
            
            #END add-point
 
 
         #Ctrlp:input.c.faah055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah055
            #add-point:ON ACTION controlp INFIELD faah055 name="input.c.faah055"
            
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
               SELECT COUNT(1) INTO l_count FROM faah_t
                WHERE faahent = g_enterprise AND faah000 = g_faah_m.faah000
                  AND faah001 = g_faah_m.faah001
                  AND faah003 = g_faah_m.faah003
                  AND faah004 = g_faah_m.faah004
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
               IF g_para_data = 'Y' THEN 
                  #####################################mark by huangtao
                  #SELECT lpad((MAX(faah001) + 1),10,'0') INTO g_faah_m.faah001
                  #  FROM faah_t
                  # WHERE faahent = g_enterprise
                  LET l_sql =  " SELECT lpad((MAX(CAST(faah001 AS NUMBER(10,0))) + 1),10,'0') FROM faah_t ",
                               "  WHERE faahent ='",g_enterprise,"'",
                               "    AND regexp_substr(faah001,'[0-9]+') IS NOT NULL",
                               "    AND faah032 = '",g_faah_m.faah032,"'"     #161009-00006#1 add lujh                         
                  PREPARE sel_faah001 FROM l_sql
                  EXECUTE sel_faah001 INTO g_faah_m.faah001
                  ######################################mark by huangtao
                  
                  IF cl_null(g_faah_m.faah001) THEN 
                    #SELECT lpad(1,10,'0') INTO g_faah_m.faah001
                    #  FROM faah_t
                    # WHERE faahent = g_enterprise
                     LET g_faah_m.faah001 = '0000000001'
                  END IF
               END IF
               IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN          
                  LET g_faah_m.faah003 = g_faah_m.faah001
                  DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003
               END IF
               LET l_year = YEAR(g_today)
               LET l_month = MONTH(g_today)
               IF l_month < 10 THEN 
                  LET l_month = '0' CLIPPED,l_month
               END IF
               
               LET l_str = l_year CLIPPED,l_month
               
               LET g_sql = "SELECT MAX(faah000) ",
                           "  FROM faah_t ",
                           " WHERE faahent = '",g_enterprise,"'",
                           "   AND faah000 LIKE '",l_str,"%'"
               PREPARE faah000_pre FROM g_sql
               EXECUTE faah000_pre INTO l_faah000
               IF cl_null(l_faah000) THEN 
                  LET g_faah_m.faah000 = l_str,'0001'
               ELSE
                  LET g_sql = "SELECT lpad((lpad((substr(MAX(faah000),7,10) + 1),4,'0')),10,'",l_str,"')",
                              "  FROM faah_t ",
                              " WHERE faahent = '",g_enterprise,"'",
                              "   AND faah000 LIKE '",l_str,"%'"
                  PREPARE faah000_pre1 FROM g_sql
                  EXECUTE faah000_pre1 INTO g_faah_m.faah000
               END IF
               
               IF cl_null(g_faah_m.faah004) THEN 
                  LET g_faah_m.faah004 = ' ' 
               END IF
               IF g_para_data3 = 'Y' AND g_para_data2 ='N' AND g_faah_m.faah002 = '1'THEN  #161129-00046#1 add
               #add--2015/07/01 By shiun--(S) 編碼功能修改
               CALL s_aooi390_get_auto_no('3',g_faah_m.faah003) RETURNING l_success,g_faah_m.faah003         
               DISPLAY BY NAME g_faah_m.faah003
               #add--2015/07/01 By shiun--(E)
               CALL s_aooi390_oofi_upd('3',g_faah_m.faah003) RETURNING l_success  #add--2015/05/18 By shiun 增加編碼功能
               END IF #161129-00046#1 add 
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO faah_t (faahent,faah001,faah003,faah004,faah002,faah012,faah013,faah006, 
                      faah007,faah005,faahstus,faah014,faah015,faah016,faah017,faah018,faah019,faah020, 
                      faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah030,faah031, 
                      faah032,faah029,faah009,faah000,faah010,faah011,faah046,faah033,faah008,faah042, 
                      faah035,faah036,faah037,faah043,faah044,faah041,faah038,faah039,faah040,faah057, 
                      faah050,faah054,faah055,faahownid,faahowndp,faahcrtid,faahcrtdt,faahcrtdp,faahmodid, 
                      faahmoddt)
                  VALUES (g_enterprise,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002, 
                      g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah007,g_faah_m.faah005, 
                      g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
                      g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
                      g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027, 
                      g_faah_m.faah028,g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029, 
                      g_faah_m.faah009,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046, 
                      g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036, 
                      g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041,g_faah_m.faah038, 
                      g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
                      g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
                      g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
               
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
     
                  IF l_cmd_t = 'r'  THEN
                     CALL afai100_detail_reproduce1()
                  END IF 
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_faah_m.faah000
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afai100_faah_t_mask_restore('restore_mask_o')
               
               UPDATE faah_t SET (faah001,faah003,faah004,faah002,faah012,faah013,faah006,faah007,faah005, 
                   faahstus,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,faah022, 
                   faah023,faah024,faah025,faah026,faah027,faah028,faah030,faah031,faah032,faah029,faah009, 
                   faah000,faah010,faah011,faah046,faah033,faah008,faah042,faah035,faah036,faah037,faah043, 
                   faah044,faah041,faah038,faah039,faah040,faah057,faah050,faah054,faah055,faahownid, 
                   faahowndp,faahcrtid,faahcrtdt,faahcrtdp,faahmodid,faahmoddt) = (g_faah_m.faah001, 
                   g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013, 
                   g_faah_m.faah006,g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014, 
                   g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019, 
                   g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faah023,g_faah_m.faah024, 
                   g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028,g_faah_m.faah030, 
                   g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
                   g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008, 
                   g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043, 
                   g_faah_m.faah044,g_faah_m.faah041,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040, 
                   g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055,g_faah_m.faahownid, 
                   g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt,g_faah_m.faahcrtdp,g_faah_m.faahmodid, 
                   g_faah_m.faahmoddt)
                WHERE faahent = g_enterprise AND faah000 = g_faah000_t #
                  AND faah001 = g_faah001_t
                  AND faah003 = g_faah003_t
                  AND faah004 = g_faah004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               #若單頭key欄位有變更
               IF g_faah_m.faah000 != g_faah000_t 
               OR g_faah_m.faah001 != g_faah001_t 
               OR g_faah_m.faah003 != g_faah003_t 
               OR g_faah_m.faah004 != g_faah004_t 
               
               THEN
                  #更新單身key值
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM faai_t 
                   WHERE faaient = g_enterprise AND faai001 = g_faah001_t
                     AND faai002 = g_faah003_t
                     AND faai003 = g_faah004_t
                     AND faai000 = g_faah000_t
                  IF l_n >0 THEN
                     UPDATE faai_t SET faai000 = g_faah_m.faah000
                                      ,faai001 = g_faah_m.faah001
                                      ,faai002 = g_faah_m.faah003
                                      ,faai003 = g_faah_m.faah004
                     
                      WHERE faaient = g_enterprise AND faai000 = g_faah000_t
                        AND faai001 = g_faah001_t
                        AND faai002 = g_faah003_t
                        AND faai003 = g_faah004_t
                  END IF
                     
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM faaj_t 
                   WHERE faajent = g_enterprise AND faaj000 = g_faah000_t
                        AND faaj037 = g_faah001_t
                        AND faaj001 = g_faah003_t
                        AND faaj002 = g_faah004_t
                  IF l_n >0 THEN 
                     #更新單身key值
                     UPDATE faaj_t SET faaj000 = g_faah_m.faah000
                                      ,faaj037 = g_faah_m.faah001
                                      ,faaj001 = g_faah_m.faah003
                                      ,faaj002 = g_faah_m.faah004
                     
                      WHERE faajent = g_enterprise AND faaj000 = g_faah000_t
                        AND faaj037 = g_faah001_t
                        AND faaj001 = g_faah003_t
                        AND faaj002 = g_faah004_t   
                     END IF                     
               END IF
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faah_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afai100_faah_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
             
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_faah_m_t)
                     LET g_log2 = util.JSON.stringify(g_faah_m)
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
  INPUT BY NAME  g_faaj_m.faajld  ,g_faaj_m.faaj000,g_faaj_m.faaj001,g_faaj_m.faaj002,g_faaj_m.faaj037,    
                 g_faaj_m.glaacomp,g_faaj_m.glaa004,g_faaj_m.faaj006,g_faaj_m.faaj007,      
                 g_faaj_m.faaj023 ,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
                 g_faaj_m.faaj003 ,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
                 g_faaj_m.faaj008 ,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
                 g_faaj_m.faaj015 ,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
                 g_faaj_m.faaj019 ,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
                 g_faaj_m.faaj034 ,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
                 g_faaj_m.faaj021 ,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
                 g_faaj_m.faaj106 ,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
                 g_faaj_m.faaj045 ,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
                 g_faaj_m.faaj101 ,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
                 g_faaj_m.faaj111 ,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
                 g_faaj_m.faaj113 ,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
                 g_faaj_m.faaj112 ,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
                 g_faaj_m.faaj154 ,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
                 g_faaj_m.faaj159 ,g_faaj_m.faaj158 ,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
                 g_faaj_m.faaj160 ,g_faaj_m.faaj162 ,
                 g_faaj_m.faaj048 #160426-00014#8 add                 
                           
         ATTRIBUTE(WITHOUT DEFAULTS)
      
     #161121-00003#3 add s---
     BEFORE FIELD faajld 
        LET g_faaj_m_o.faajld = g_faaj_m.faajld
     #161121-00003#3 add e---
      
      AFTER FIELD faajld
         IF  NOT cl_null(g_faaj_m.faajld) THEN 
           IF l_cmd_b = 'a' THEN
              IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faaj_t WHERE "||"faajent = '" ||g_enterprise|| "'  AND "||"faajld = '"||g_faaj_m.faajld ||"' AND "||"faaj001 = '"||g_faah_m.faah003 ||"' AND "||"faaj000 = '"||g_faah_m.faah001 ||"' AND "||" faaj002 = '"||g_faah_m.faah004 ||"' ",'std-00004',0) THEN 
                 LET g_faaj_m.faajld = ''
                 LET g_faaj_m.faaj014 = ''
                 LET g_faaj_m.faaj015 = '' 
                 LET g_faaj_m.faaj101 = ''
                 LET g_faaj_m.faaj102 = ''
                 LET g_faaj_m.faaj151 = ''
                 LET g_faaj_m.faaj152 = ''                 
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF
           END IF
        END IF

        CALL afai100_faajld_desc()
        IF NOT cl_null(g_faaj_m.faajld) THEN 
#此段落由子樣板a19產生
           #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           INITIALIZE g_chkparam.* TO NULL
           
           #設定g_chkparam.*的參數
           LET g_chkparam.arg1 = g_faaj_m.faajld
           #160318-00025#4--add--str
           LET g_errshow = TRUE 
           LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
           #160318-00025#4--add--end
              
           #呼叫檢查存在並帶值的library
           IF cl_chk_exist("v_glaald") THEN
              #檢查成功時後續處理
              #LET  = g_chkparam.return1
              #DISPLAY BY NAME 
              CALL s_ld_chk_authorization(g_user,g_faaj_m.faajld) RETURNING l_success
              IF l_success = FALSE THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axr-00022'
                 LET g_errparam.extend = g_faaj_m.faajld
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_faaj_m.faajld = ''
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF 
              
              #【帐套折旧信息】帐套开窗，需要限定【所有组织】归属在同一个法人下的帐套
              SELECT glaacomp INTO l_glaacomp
                FROM glaa_t
               WHERE glaaent = g_enterprise
                 AND glaald = g_faaj_m.faajld
              IF l_glaacomp <> l_ooef017 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00101'
                 LET g_errparam.extend = g_faaj_m.faajld
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_faaj_m.faajld = ''
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF 

              IF l_cmd_b = 'a' THEN 
                 CALL afai100_faajld_get()
              END IF
              #161121-00003#3 add s---   
              IF l_cmd_b = 'u' THEN   
                 IF NOT cl_null(g_faaj_m.faajld) AND (g_faaj_m.faajld <> g_faaj_m_o.faajld OR cl_null(g_faaj_m_o.faajld)) THEN 
                   SELECT faal006 INTO g_faaj_m.faaj048  
                   FROM faal_t
                  WHERE faalent = g_enterprise
                    AND faalld  = g_faaj_m.faajld
                    AND faal001 = g_faah_m.faah006   
                 END IF  
              END IF   
              DISPLAY g_faaj_m.faaj048 TO faaj048                 
              #161121-00003#3 add e---
               
           ELSE
              #檢查失敗時後續處理
              LET g_faaj_m.faajld = g_faaj_m_t.faajld
              CALL afai100_faajld_desc()
              NEXT FIELD CURRENT
           END IF
        
        END IF 
        
        
     AFTER FIELD faajsite
        CALL afai100_depreciation_ref()
        IF NOT cl_null(g_faaj_m.faajsite) THEN 
#此段落由子樣板a19產生
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           INITIALIZE g_chkparam.* TO NULL
           
           #設定g_chkparam.*的參數
           LET g_chkparam.arg1 = g_faaj_m.faajsite
#           LET g_chkparam.arg2 = g_site
           #160318-00025#4--add--str
           LET g_errshow = TRUE 
           LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
           #160318-00025#4--add--end
              
           #呼叫檢查存在並帶值的library
#          IF cl_chk_exist("v_faab002") THEN
           #IF cl_chk_exist("v_ooef001") THEN             #161024-00008#1   
           IF cl_chk_exist("v_ooef001_13") THEN           #161024-00008#1   
              #檢查成功時後續處理
              #LET  = g_chkparam.return1
              #DISPLAY BY NAME 
              #161111-00049#5 add s---
              CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
              IF s_chr_get_index_of(l_comp_str,g_faaj_m.faajsite,1) = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-01121'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
                 CALL afai100_depreciation_ref()
                 NEXT FIELD CURRENT                  
              END IF
              IF NOT cl_null(g_faaj_m.faajld) THEN 
                 LET l_cnt = 0
                 #LET g_sql = " SELECT COUNT(1) FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 IN '",l_comp_str,"' AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaa001 = '",g_faaj_m.faajld,"')"   #161205-00051#1 mark lujh
                 LET g_sql = " SELECT COUNT(1) FROM ooef_t WHERE ooefent = ",g_enterprise," AND ",l_comp_str," AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_faaj_m.faajld,"')"   #161205-00051#1 add lujh
                 PREPARE afai100_faajsite_count1 FROM g_sql
                 EXECUTE afai100_faajsite_count1 INTO l_cnt   
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 0 THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'afa-01122'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
                    CALL afai100_depreciation_ref()
                    NEXT FIELD CURRENT                      
                 END IF
              END IF              
              #161111-00049#5 add e--- 
           ELSE
              #檢查失敗時後續處理
              LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
              CALL afai100_depreciation_ref()
              NEXT FIELD CURRENT
           END IF
        

        END IF 


      #160426-00014#5 add s---
      AFTER FIELD faaj006
         IF NOT cl_null(g_faaj_m.faaj006) THEN 
            IF g_faaj_m.faaj006 = '4' THEN 
               CALL cl_set_comp_entry("faaj007","FALSE")
               LET g_faaj_m.faaj007 = g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004
            END IF
         END IF
 
      #160426-00014#5 add e---
       
      AFTER FIELD faaj023
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj023) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj023,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj023
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj023
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj023 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj023 TO faaj023              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj023,'N') THEN
                   LET g_faaj_m.faaj023 = g_faaj_m_t.faaj023
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj023
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj023 = g_faaj_m_t.faaj023
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj024
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj024) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj024,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj024
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj024
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj024 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj024 TO faaj024              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj024,'N') THEN
                   LET g_faaj_m.faaj024 = g_faaj_m_t.faaj024
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj024
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj024 = g_faaj_m_t.faaj024
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj025
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj025) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj025,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj025
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj025
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj025 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj025 TO faaj025              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj025,'N') THEN
                   LET g_faaj_m.faaj025 = g_faaj_m_t.faaj025
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj025
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj025 = g_faaj_m_t.faaj025
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj026
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj026) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj026,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj026
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj026
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj026 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj026 TO faaj026              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj026,'N') THEN
                   LET g_faaj_m.faaj026 = g_faaj_m_t.faaj026
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj026
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj026 = g_faaj_m_t.faaj026
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
        
         END IF   
         
      ON CHANGE faaj003
         IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
            IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
               IF g_faaj_m.faaj022 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00192'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD faaj022
               END IF
            END IF
         END IF
         
      #161121-00003#3 add s---
      ON CHANGE faaj048 
         IF g_faaj_m.faaj048 = '1' THEN 
            LET g_faaj_m.faaj003 = '5'
            CALL cl_set_comp_entry("faaj003",FALSE) 
         ELSE
            CALL cl_set_comp_entry("faaj003",TRUE)          
         END IF
      #161121-00003#3 add e---  
      
      ON CHANGE faaj006
         LET g_faaj_m.faaj007 = NULL
#         LET g_faaj_m.faaj025 = NULL    #mark by yangxf 
         DISPLAY g_faaj_m.faaj007 TO faaj007
         DISPLAY g_faaj_m.faaj025 TO faaj025
         CALL afai100_depreciation_ref()
         IF g_faaj_m.faaj006 = '2' OR g_faaj_m.faaj006 = '1' THEN
            CALL cl_set_comp_required('faaj007',TRUE)
         ELSE
            CALL cl_set_comp_required('faaj007',FALSE)
            LET g_faaj_m.faaj007 = g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 #160426-00014#5
         END IF
         
         #折舊科目 
         IF cl_null(g_faaj_m.faaj025) THEN 
            IF g_para_data1 = '1' THEN    #依部門
               IF g_faaj_m.faaj006 = '1' THEN   #單一部門    afai050
                  LET g_faaj_m.faaj007 = g_faah_m.faah026
                  SELECT faae003 INTO g_faaj_m.faaj025
                    FROM faae_t
                   WHERE faaeent = g_enterprise
                     AND faaeld = g_faaj_m.faajld
                     AND faae001 = g_faaj_m.faaj007
                     AND faae002 = g_faah_m.faah006  
               END IF
               IF g_faaj_m.faaj006 = '2' THEN   #多部門   afai021
                  LET g_faaj_m.faaj025 = '' 
               END IF 
               DISPLAY g_faaj_m.faaj007 TO faaj007
               DISPLAY g_faaj_m.faaj025 TO faaj025
               CALL afai100_depreciation_ref()   
            END IF
         END IF

      AFTER FIELD faaj007
         IF g_faaj_m.faaj006 = '1' THEN 
            CALL afai100_depreciation_ref()
            IF NOT cl_null(g_faaj_m.faaj007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faaj_m.faaj007
               LET g_chkparam.arg2 = g_today
			      #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
                  ####################################add by huangtao\根据归属法人的部门来过滤
#161111-00049#5 mod s---                  
#                  SELECT COUNT(*) INTO l_n FROM ooeg_t
#                   WHERE ooeg001 = g_faaj_m.faaj007 AND ooeg009 = g_faah_m.faah032 AND ooegent=g_enterprise #160905-00007#1 add
                  IF NOT cl_null(g_faaj_m.faajld) THEN 
                     SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise
                        AND glaald = g_faaj_m.faajld                  
                     SELECT COUNT(1) INTO l_n FROM ooeg_t WHERE ooeg001 = g_faaj_m.faaj007  
                         AND ooegent=g_enterprise AND ooeg009 = l_glaacomp        
                  ELSE
                     #根据归属法人的部门来过滤
                     SELECT COUNT(1) INTO l_n FROM ooeg_t
                        WHERE ooeg001 = g_faaj_m.faaj007 AND ooeg009 = g_faah_m.faah032 AND ooegent=g_enterprise                  
                  END IF                  
#161111-00049#5 mod e---   
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'afa-00384'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                     NEXT FIELD faaj007
                     CALL afai100_depreciation_ref()
                  END IF                  
                  ####################################add by huangtao
			      #折舊科目 
			      IF cl_null(g_faaj_m.faaj025) THEN 
                     IF g_para_data1 = '1' THEN    #依部門
                        IF g_faaj_m.faaj006 = '1' THEN   #單一部門
                           SELECT faae003 INTO g_faaj_m.faaj025
                             FROM faae_t
                            WHERE faaeent = g_enterprise
                              AND faaeld = g_faaj_m.faajld
                              AND faae001 = g_faaj_m.faaj007
                              AND faae002 = g_faah_m.faah006
                        END IF
                        IF g_faaj_m.faaj006 = '2' THEN   #多部門
                           LET g_faaj_m.faaj025 = ''
                        END IF 
                        DISPLAY g_faaj_m.faaj025 TO faaj025
                        CALL afai100_depreciation_ref()   
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                  CALL afai100_depreciation_ref()
                  NEXT FIELD CURRENT
               END IF
         

            END IF   
         END IF
         
         IF g_faaj_m.faaj006 = '2' THEN 
            CALL afai100_depreciation_ref()
            IF NOT cl_null(g_faaj_m.faaj007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faaj_m.faajld
               LET g_chkparam.arg2 = g_faaj_m.faaj007
			   
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faaf003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
			   
               ELSE
                  #檢查失敗時後續處理
                  LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                  CALL afai100_depreciation_ref()
                  NEXT FIELD CURRENT
               END IF
         

            END IF   
         END IF
      
     
      AFTER FIELD faaj004     
         IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_faaj_m.faaj004 != g_faaj_m_t.faaj004 OR cl_null(g_faaj_m_t.faaj004))) THEN      
            IF NOT cl_null(g_faaj_m.faaj004) THEN 
               #150923--s
               #取得狀態下,直接將未用年限=耐用年限
               IF g_faah_m.faah015 = '0' THEN
                  LET g_faaj_m.faaj005 = g_faaj_m.faaj004
               END IF
               #150923--e         
               IF g_faaj_m.faaj004 < g_faaj_m.faaj005 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00030'
                  LET g_errparam.extend = g_faaj_m.faaj004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_faaj_m.faaj004 = g_faaj_m_t.faaj004
                  NEXT FIELD faaj004
               END IF
               #150923--s
               IF g_ooef011 = 'TW' THEN
                  IF p_cmd = 'u' AND ( g_faaj_m.faaj004 != g_faaj_m_t.faaj004 OR cl_null(g_faaj_m_t.faaj004)) THEN
                     #重新推算殘值率與預留殘值:1/耐用年限(年)+1 *100
                     LET l_faac016 = (1/(g_faaj_m.faaj004/12+1))*100
                     IF NOT cl_null(g_faaj_m.faaj016) THEN
                        LET g_faaj_m.faaj019 = g_faaj_m.faaj016 * l_faac016/100
                        LET g_faaj_m.faaj019 = s_curr_round(g_faaj_m.glaacomp,g_faaj_m.faaj014,g_faaj_m.faaj019,2)
                        DISPLAY BY NAME g_faaj_m.faaj019
                     END IF
                  END IF
               END IF
               #150923--e             
            END IF 
            LET g_faaj_m.faaj005 = g_faaj_m.faaj004
            DISPLAY g_faaj_m.faaj005 TO faaj005
            
            IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
               IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
                  IF g_faaj_m.faaj022 <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00192'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     NEXT FIELD faaj022
                  END IF
               END IF
            END IF
         END IF
      
      AFTER FIELD faaj005     
         IF NOT cl_null(g_faaj_m.faaj005) THEN 
            IF g_faaj_m.faaj005 > g_faaj_m.faaj004 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00031'
               LET g_errparam.extend = g_faaj_m.faaj005
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_faaj_m.faaj005 = g_faaj_m_t.faaj005
               NEXT FIELD faaj005
            END IF
         END IF
         
      AFTER FIELD faaj008   
         IF NOT cl_null(g_faaj_m.faaj008) THEN 
            LET l_str = g_faaj_m.faaj008
            IF l_str.getLength() != 6 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00309'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF 
            LET l_month = l_str.subString(5,6)
            IF l_month > 12 OR l_month < 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00309'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF
            IF NOT cl_null(g_faaj_m.faaj009) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               IF g_faaj_m.faaj009 < l_year THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00312'
                  LET g_errparam.extend = g_faaj_m.faaj008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
                  NEXT FIELD faaj008
               END IF
               IF NOT cl_null(g_faaj_m.faaj010) THEN
                  LET l_month = g_faaj_m.faaj008[5,6]
                  IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00313'
                     LET g_errparam.extend = g_faaj_m.faaj008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
                     NEXT FIELD faaj008
                  END IF
               END IF  
            END IF 
            LET l_year = YEAR(g_faah_m.faah014)
            LET l_month = MONTH(g_faah_m.faah014)
            LET l_str1 = l_year
            LET l_str2 = l_month
            IF l_month < 10 THEN
               LET l_str3 = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
            ELSE
               LET l_str3 = l_str1 CLIPPED,l_str2 CLIPPED
            END IF        
            IF l_str < l_str3 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00322'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF 
         END IF
         
      AFTER FIELD faaj009
         IF NOT cl_null(g_faaj_m.faaj009) THEN 
            LET l_str = g_faaj_m.faaj009
            IF l_str.getLength() != 4 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00310'
               LET g_errparam.extend = g_faaj_m.faaj009
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
               NEXT FIELD faaj009
            END IF 
            IF NOT cl_null(g_faaj_m.faaj008) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               IF g_faaj_m.faaj009 < l_year THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00312'
                  LET g_errparam.extend = g_faaj_m.faaj009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
                  NEXT FIELD faaj009
               END IF
               IF NOT cl_null(g_faaj_m.faaj010) THEN
                  LET l_month = g_faaj_m.faaj008[5,6]
                  IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00313'
                     LET g_errparam.extend = g_faaj_m.faaj009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
                     NEXT FIELD faaj009
                  END IF
               END IF 
            END IF                
         END IF
         
      AFTER FIELD faaj010
         IF NOT cl_null(g_faaj_m.faaj010) THEN 
            LET l_str = g_faaj_m.faaj010
            IF l_str.getLength() > 2 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00311'
               LET g_errparam.extend = g_faaj_m.faaj010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
               NEXT FIELD faaj010
            END IF
            IF g_faaj_m.faaj010 < 1 OR g_faaj_m.faaj010 > 12 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00314'
               LET g_errparam.extend = g_faaj_m.faaj010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
               NEXT FIELD faaj010
            END IF 
            IF NOT cl_null(g_faaj_m.faaj008) AND NOT cl_null(g_faaj_m.faaj009) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               LET l_month = g_faaj_m.faaj008[5,6]
               IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00313'
                  LET g_errparam.extend = g_faaj_m.faaj010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
                  NEXT FIELD faaj010
               END IF
            END IF                
         END IF
 
      
      AFTER FIELD faaj014
         IF NOT cl_null(g_faaj_m.faaj014) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj014
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
            #160318-00025#4--add--end
                 
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_ooai001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               IF NOT cl_null(g_glaa001_1) AND NOT cl_null(g_glaa025_1) THEN 
                  CALL afai100_get_exrate(g_faaj_m.faajld,g_faaj_m.faaj014,g_glaa001_1,g_glaa025_1) 
               END IF
               LET g_faaj_m.faaj015 = g_ooan005
               DISPLAY g_faaj_m.faaj015 TO faaj015
            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj014 = g_faaj_m_t.faaj014
               NEXT FIELD CURRENT
            END IF
          

         END IF 

      AFTER FIELD faaj015
         IF NOT cl_null(g_faaj_m.faaj015) AND g_faaj_m.faaj015 <> g_faaj_m_t.faaj015 THEN 
            LET g_faaj_m.faaj016 = g_faaj_m.faaj015 * g_faah_m.faah022
         END IF
         
      AFTER FIELD faaj016
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj019) THEN 
            IF g_faaj_m.faaj016 < g_faaj_m.faaj019 THEN 
               LET g_faaj_m.faaj016 = g_faaj_m_t.faaj016
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00099'
               LET g_errparam.extend = g_faaj_m.faaj016
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD faaj016
            END IF
            #150923--s
            IF g_ooef011 = 'TW' THEN
               LET g_faaj_m.faaj019 = g_faaj_m.faaj016 * l_faac016/100
               DISPLAY BY NAME g_faaj_m.faaj019
            END IF
            #150923--e              
         END IF
         
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj017) THEN 
            ##############################mark by huangtao
            #IF g_faaj_m.faaj016 <> g_faaj_m_t.faaj016 OR cl_null(g_faaj_m_t.faaj016) THEN 
            #   LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
            #   DISPLAY g_faaj_m.faaj028 TO faaj028
            #END IF
            IF g_faaj_m.faaj016 <> g_faaj_m_o.faaj016 OR cl_null(g_faaj_m_o.faaj016) THEN 
               LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
               DISPLAY g_faaj_m.faaj028 TO faaj028
            END IF
            ##############################mark by huangtao
         END IF
         LET g_faaj_m_o.faaj016 = g_faaj_m.faaj016
         
      AFTER FIELD faaj017
         IF NOT cl_null(g_faaj_m.faaj017) AND (g_faaj_m.faaj017 <> g_faaj_m_t.faaj017 OR cl_null(g_faaj_m_t.faaj017)) THEN 
            IF g_glaa015 = 'Y' THEN    
               #-----本位币二-------
               LET g_faaj_m.faaj104 = g_faaj_m.faaj017 * g_faaj_m.faaj102
            
               DISPLAY g_faaj_m.faaj104 TO faaj104
            END IF
            IF g_glaa019 = 'Y' THEN      
               #-----本位币三-------
               LET g_faaj_m.faaj154 = g_faaj_m.faaj017 * g_faaj_m.faaj152
            
               DISPLAY g_faaj_m.faaj154 TO faaj154
            END IF
         END IF
         
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj017) THEN 
            IF g_faaj_m.faaj017 <> g_faaj_m_t.faaj017 OR cl_null(g_faaj_m_t.faaj017) THEN 
               LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
               DISPLAY g_faaj_m.faaj028 TO faaj028
               IF g_glaa015 = 'Y' THEN    
                  #-----本位币二-------
                  LET g_faaj_m.faaj108 = g_faaj_m.faaj028 * g_faaj_m.faaj102
               
                  DISPLAY g_faaj_m.faaj108 TO faaj108
               END IF
               IF g_glaa019 = 'Y' THEN      
                  #-----本位币三-------
                  LET g_faaj_m.faaj158 = g_faaj_m.faaj028 * g_faaj_m.faaj152
               
                  DISPLAY g_faaj_m.faaj158 TO faaj158
               END IF  
            END IF
         END IF
         
      AFTER FIELD faaj018
         IF NOT cl_null(g_faaj_m.faaj018) AND (g_faaj_m.faaj018 <> g_faaj_m_t.faaj018 OR cl_null(g_faaj_m_t.faaj018)) THEN 
            IF g_glaa015 = 'Y' THEN    
               #-----本位币二-------
               LET g_faaj_m.faaj111 = g_faaj_m.faaj018 * g_faaj_m.faaj102
            
               DISPLAY g_faaj_m.faaj111 TO faaj111
            END IF
            IF g_glaa019 = 'Y' THEN      
               #-----本位币三-------
               LET g_faaj_m.faaj161 = g_faaj_m.faaj018 * g_faaj_m.faaj152
            
               DISPLAY g_faaj_m.faaj161 TO faaj161
            END IF
         END IF
         
      AFTER FIELD faaj019
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj019) THEN 
            IF g_faaj_m.faaj019 > g_faaj_m.faaj016 THEN 
               LET g_faaj_m.faaj019 = g_faaj_m_t.faaj019
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00100'
               LET g_errparam.extend = g_faaj_m.faaj019
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD faaj019
            END IF
         END IF
         
      AFTER FIELD faaj022
          ############################add by huangtao
         IF NOT cl_ap_chk_range(g_faaj_m.faaj022,"0","1","","","azz-00079",1) THEN
             NEXT FIELD faaj022
         END IF 
          ############################add by huangtao
         IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
            IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
               IF g_faaj_m.faaj022 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00192'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD faaj022
               END IF
            END IF
         END IF
         
      ON CHANGE faaj011
         IF g_faaj_m.faaj011 = 'Y' THEN 
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
         ELSE
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
            LET g_faaj_m.faaj012 = ''  #160826-00013#1 
            LET g_faaj_m.faaj013 = ''  #160826-00013#1            
         END IF
      
      #########################add by huangtao
      AFTER FIELD faaj013  #faaj011预留年月不可为0
         IF g_faaj_m.faaj011 = 'Y'  THEN
            IF NOT cl_null(g_faaj_m.faaj013) THEN
               IF g_faaj_m.faaj013 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00381'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD faaj013
               END IF       
            END IF        
         END IF
      
     AFTER FIELD faaj012
        IF g_faaj_m.faaj011 = 'Y'  THEN 
           IF cl_null(g_faaj_m.faaj012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00382'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj012 
            END IF        
         END IF
     
     AFTER FIELD faaj106
     
     
     AFTER FIELD faaj156
      #########################add by huangtao
      
      
      AFTER FIELD faaj042
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj042) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj042
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pmaa001_2") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj042 = g_faaj_m_t.faaj042
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF
         
      AFTER FIELD faaj043
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj043) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj043
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pmaa001_2") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj043 = g_faaj_m_t.faaj043
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  

      AFTER FIELD faaj045
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj045) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj045
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pjba001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj045 = g_faaj_m_t.faaj045
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  
         
      AFTER FIELD faaj046
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj046) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj045
            LET g_chkparam.arg2 = g_faaj_m.faaj046

               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pjbb002") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj046 = g_faaj_m_t.faaj046
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  
         
         
      AFTER FIELD faaj102
         IF NOT cl_null(g_faaj_m.faaj102) OR (l_cmd_b = 'u' AND g_faaj_m.faaj102 <> g_faaj_m_t.faaj102) THEN 
            LET g_faaj_m.faaj103 = g_faaj_m.faaj102 * g_faah_m.faah022
         END IF
         
      AFTER FIELD faaj152
         IF NOT cl_null(g_faaj_m.faaj152) OR (l_cmd_b = 'u' AND g_faaj_m.faaj152 <> g_faaj_m_t.faaj152) THEN 
            LET g_faaj_m.faaj153 = g_faaj_m.faaj152 * g_faah_m.faah022
         END IF
         
         
      
      ON ACTION controlp INFIELD faajld
            #add-point:ON ACTION controlp INFIELD glabld
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faajld             #給予default值
            LET g_qryparam.where  = " glaacomp in (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                    " AND ooef001 = '",g_faah_m.faah028,"')"
            #給予arg

            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_faaj_m.faajld = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_glab_m.glaald = g_qryparam.return2 #帳別編號

            DISPLAY g_faaj_m.faajld TO faajld              #顯示到畫面上
            #DISPLAY g_glab_m.glaald TO glaald #帳別編號
            CALL afai100_faajld_desc()
            NEXT FIELD faajld                          #返回原欄位

      
      ON ACTION controlp INFIELD faajsite
            #add-point:ON ACTION controlp INFIELD faah028
#此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str #161111-00049#5 add
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faajsite             #給予default值
#            LET g_qryparam.where = " faab004 = '",g_site,"'"
            #給予arg

#            CALL q_faab001()                                #呼叫開窗
            #CALL q_ooef001()   #161024-00008#1
            #161111-00049#5 add s---
            LET g_qryparam.where = l_comp_str 
            IF NOT cl_null(g_faaj_m.faajld) THEN 
               LET g_qryparam.where =g_qryparam.where," AND ", l_comp_str," AND ooef017 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_faaj_m.faajld ,"'  )"  
            END IF
            #161111-00049#5 add e---            
            CALL q_ooef001_12() #161024-00008#1
            LET g_faaj_m.faajsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faajsite TO faajsite              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faajsite                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj023
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj023             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
               
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj023 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj023 TO faaj023              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj023                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj024
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj024             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj024 TO faaj024              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj024                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj025
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj025             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj025 TO faaj025              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj025                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj026
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj026             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                 " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj026 TO faaj026              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj026                          #返回原欄位
            
      
      ON ACTION controlp INFIELD faaj007
            #add-point:ON ACTION controlp INFIELD faag005
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj007             #給予default值
            IF g_faaj_m.faaj006 = '1' THEN 
               #給予arg
               LET g_qryparam.arg1 = g_today
               IF cl_null(g_faaj_m.faajld) THEN  #161111-00049#5 add
                  ########################################add by huangtao
                  LET g_qryparam.where = "ooeg009 = '",g_faah_m.faah032,"'"
                  ########################################add by huangtao
               #161111-00049#5 add s---  
               ELSE
                  SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_faaj_m.faajld
                  LET g_qryparam.where = "ooeg009 = '",l_glaacomp,"'"
               END IF               
               #161111-00049#5 add e---
               CALL q_ooeg001_4()                                #呼叫開窗
            END IF
            IF g_faaj_m.faaj006 = '2' THEN
               #給予arg
               LET g_qryparam.arg1 = g_faaj_m.faajld

               CALL q_faaf003()                                #呼叫開窗
            END IF

            LET g_faaj_m.faaj007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj007 TO faaj007              #顯示到畫面上

            CALL afai100_depreciation_ref()

            NEXT FIELD faaj007                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj014
            #add-point:ON ACTION controlp INFIELD faaj014
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj014             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_faaj_m.faaj014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj014 TO faaj014              #顯示到畫面上
            NEXT FIELD faaj014                          #返回原欄位
            
            
      ON ACTION controlp INFIELD faaj042
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj042             #給予default值
            LET g_qryparam.where = " pmaastus = 'Y'"
            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faaj_m.faaj042 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj042 TO faaj042              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj042                          #返回原欄位
      
      ON ACTION controlp INFIELD faaj043
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj043             #給予default值
            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faaj_m.faaj043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj043 TO faaj043              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj043                          #返回原欄位
            
       ON ACTION controlp INFIELD faaj045
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj045             #給予default值
            #給予arg

            CALL q_pjba001()                                #呼叫開窗

            LET g_faaj_m.faaj045 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj045 TO faaj045              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj045                          #返回原欄位
            
       ON ACTION controlp INFIELD faaj046
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj046             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_faaj_m.faaj045

            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_faaj_m.faaj046 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj046 TO faaj046              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj046                          #返回原欄位
         
      BEFORE INPUT
         IF cl_null(g_faaj_m.faajld) THEN 
            LET l_cmd_b = 'a' 
            INITIALIZE g_faaj_m.* LIKE faaj_t.*  
            CALL afai100_faajld_desc()
            CALL afai100_depreciation_ref()
            #從afai020中帶折畢再提預設值
            SELECT faac004,faac005,faac006 INTO g_faaj_m.faaj004,g_faaj_m.faaj011,g_faaj_m.faaj013 
              FROM faac_t
             WHERE faacent = g_enterprise 
               AND faac001 = g_faah_m.faah006
               AND faacstus = 'Y'
            LET g_faaj_m.faaj005 = g_faaj_m.faaj004
            DISPLAY BY NAME g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj011,g_faaj_m.faaj013
         
            CALL cl_set_comp_entry("faajld",TRUE)
            IF g_faaj_m.faaj011 = 'Y' THEN 
               CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
            ELSE
               CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
            END IF
            SELECT faac003 INTO g_faaj_m.faaj003 FROM faac_t
             WHERE faacent = g_enterprise AND faac001 = g_faah_m.faah006
            DISPLAY BY NAME g_faaj_m.faaj003
         ELSE
            LET l_cmd_b = 'u'
         END IF 
         IF l_cmd_b = 'a' THEN 
            LET g_faaj_m.faaj000 = g_faah_m.faah000
            LET g_faaj_m.faaj001 = g_faah_m.faah003
            LET g_faaj_m.faaj002 = g_faah_m.faah004
            LET g_faaj_m.faaj037 = g_faah_m.faah001
            LET g_faaj_m.faajsite = g_faah_m.faah028
            SELECT faac003,faac004,faac005,faac006 
              INTO g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj011,g_faaj_m.faaj013
              FROM faac_t
             WHERE faacent = g_enterprise
               AND faac001 = g_faah_m.faah006
               AND faacstus = 'Y'
            LET g_faaj_m.faaj005 = g_faaj_m.faaj004
            #LET g_faaj_m.faaj011 = 'Y'    #2015/02/15 Mark By 01727
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
            LET g_faaj_m.faaj042 = g_faah_m.faah009
            LET g_faaj_m.faaj038 = g_faah_m.faah015
            LET g_faaj_m.faaj016 = 0
            LET g_faaj_m.faaj017 = 0
            LET g_faaj_m.faaj018 = 0
            LET g_faaj_m.faaj019 = 0
            LET g_faaj_m.faaj020 = 0
            LET g_faaj_m.faaj022 = 0
            LET g_faaj_m.faaj033 = 0
            LET g_faaj_m.faaj034 = 0
            LET g_faaj_m.faaj035 = 0
            LET g_faaj_m.faaj032 = 0
            LET g_faaj_m.faaj027 = 0
            LET g_faaj_m.faaj021 = 0
            LET g_faaj_m.faaj029 = 0
            LET g_faaj_m.faaj028 = 0
            LET g_faaj_m.faaj103 = 0
            LET g_faaj_m.faaj104 = 0
            LET g_faaj_m.faaj111 = 0
            LET g_faaj_m.faaj105 = 0
            LET g_faaj_m.faaj117 = 0
            LET g_faaj_m.faaj107 = 0
            LET g_faaj_m.faaj109 = 0
            LET g_faaj_m.faaj108 = 0
            LET g_faaj_m.faaj113 = 0
            LET g_faaj_m.faaj114 = 0
            LET g_faaj_m.faaj115 = 0
            LET g_faaj_m.faaj110 = 0
            LET g_faaj_m.faaj112 = 0
            LET g_faaj_m.faaj153 = 0
            LET g_faaj_m.faaj154 = 0
            LET g_faaj_m.faaj161 = 0
            LET g_faaj_m.faaj155 = 0
            LET g_faaj_m.faaj167 = 0
            LET g_faaj_m.faaj157 = 0
            LET g_faaj_m.faaj159 = 0
            LET g_faaj_m.faaj158 = 0
            LET g_faaj_m.faaj163 = 0
            LET g_faaj_m.faaj164 = 0
            LET g_faaj_m.faaj165 = 0
            LET g_faaj_m.faaj160 = 0
            LET g_faaj_m.faaj162 = 0
            LET g_faaj_m.faaj048 = '2' #160426-00014#8
            DISPLAY g_faaj_m.faajsite TO faajsite
            DISPLAY g_faaj_m.faaj042 TO faaj042
            DISPLAY g_faaj_m.faaj003 TO faaj003
            DISPLAY g_faaj_m.faaj004 TO faaj004
            DISPLAY g_faaj_m.faaj038 TO faaj038
            DISPLAY g_faaj_m.faaj016 TO faaj016
            DISPLAY g_faaj_m.faaj017 TO faaj017
            DISPLAY g_faaj_m.faaj107 TO faaj107
            DISPLAY g_faaj_m.faaj109 TO faaj109
            DISPLAY g_faaj_m.faaj108 TO faaj108
            DISPLAY g_faaj_m.faaj018 TO faaj018
            DISPLAY g_faaj_m.faaj019 TO faaj019
            DISPLAY g_faaj_m.faaj020 TO faaj020
            DISPLAY g_faaj_m.faaj022 TO faaj022
            DISPLAY g_faaj_m.faaj033 TO faaj033
            DISPLAY g_faaj_m.faaj034 TO faaj034
            DISPLAY g_faaj_m.faaj035 TO faaj035
            DISPLAY g_faaj_m.faaj032 TO faaj032
            DISPLAY g_faaj_m.faaj027 TO faaj027
            DISPLAY g_faaj_m.faaj021 TO faaj021
            DISPLAY g_faaj_m.faaj029 TO faaj029
            DISPLAY g_faaj_m.faaj028 TO faaj028
            
            DISPLAY g_faaj_m.faaj103 TO faaj103
            DISPLAY g_faaj_m.faaj104 TO faaj104
            DISPLAY g_faaj_m.faaj111 TO faaj111
            DISPLAY g_faaj_m.faaj105 TO faaj105
            DISPLAY g_faaj_m.faaj117 TO faaj117
            DISPLAY g_faaj_m.faaj113 TO faaj113
            DISPLAY g_faaj_m.faaj114 TO faaj114
            DISPLAY g_faaj_m.faaj115 TO faaj115
            DISPLAY g_faaj_m.faaj110 TO faaj110
            DISPLAY g_faaj_m.faaj112 TO faaj112
            
            DISPLAY g_faaj_m.faaj153 TO faaj153
            DISPLAY g_faaj_m.faaj154 TO faaj154
            DISPLAY g_faaj_m.faaj161 TO faaj161
            DISPLAY g_faaj_m.faaj155 TO faaj155
            DISPLAY g_faaj_m.faaj167 TO faaj167
            DISPLAY g_faaj_m.faaj157 TO faaj157
            DISPLAY g_faaj_m.faaj159 TO faaj159
            DISPLAY g_faaj_m.faaj158 TO faaj158
            DISPLAY g_faaj_m.faaj163 TO faaj163
            DISPLAY g_faaj_m.faaj164 TO faaj164
            DISPLAY g_faaj_m.faaj165 TO faaj165
            DISPLAY g_faaj_m.faaj160 TO faaj160
            DISPLAY g_faaj_m.faaj162 TO faaj162
            DISPLAY g_faaj_m.faaj048 TO faaj048 #160426-00014#8
            CALL afai100_depreciation_ref()
         END IF
         IF g_faaj_m.faaj011 = 'Y' THEN 
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
         ELSE
            LET g_faaj_m.faaj012 = ''
            LET g_faaj_m.faaj013 = ''
            LET g_faaj_m.faaj106 = ''
            LET g_faaj_m.faaj156 = ''
            DISPLAY BY NAME g_faaj_m.faaj012,g_faaj_m.faaj013,g_faaj_m.faaj106,g_faaj_m.faaj156
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
         END IF
         IF l_cmd_b = 'u' THEN
            IF g_faaj_m.faaj011 = 'Y' THEN 
               CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
            ELSE
               CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
            END IF
         END IF 
         #albireo 150825-----s
         
#         IF NOT cl_null(g_faaj_m.faaj030) THEN 
#            CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj019,faaj028,
#                                         faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
#                                         faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",FALSE)
#         ELSE
#            CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj019,faaj028,
#                                         faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
#                                         faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",TRUE)
#         END IF

         #拿掉預留殘值
         IF NOT cl_null(g_faaj_m.faaj030) THEN 
            CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj028,
                                         faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                         faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",FALSE)
         ELSE
            CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj028,
                                         faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                         faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",TRUE)
         END IF
         #albireo 150825-----e
         #150923--s
         IF g_ooef011 = 'TW' THEN
            SELECT faac004,faac016
              INTO l_faac004,l_faac016
              FROM faac_t
             WHERE faacent = g_enterprise
               AND faac001 = g_faah_m.faah006
               AND faacstus = 'Y'
            IF l_faac004 <> g_faaj_m.faaj004 THEN
               #耐用年限與afai020不同時,重新推算殘值率與預留殘值:1/耐用年限(年)+1 *100
               LET l_faac016 = (1/(g_faaj_m.faaj004/12+1))*100
            END IF
         END IF
         #150923--e             
         
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
          #########################add by huangtao
         IF g_faaj_m.faaj011 = 'Y'  THEN
            IF cl_null(g_faaj_m.faaj013) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00381'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj013
            END IF   
            IF cl_null(g_faaj_m.faaj012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00382'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj012    
            END IF 
         END IF
     
      #########################add by huangtao
         
         CALL s_transaction_begin()
         
         IF l_cmd_b = 'a' THEN 
            CALL afai100_faaj_ins()
         ELSE
            CALL afai100_faaj_upd()
         END IF
      
   END INPUT
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
         CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
         CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
         CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
         CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9010') RETURNING g_para_data3  #財编自动编号否
         
          IF p_cmd = 'a' THEN
#            NEXT FIELD faah001
            IF g_para_data = 'N' THEN 
               NEXT FIELD faah001
            END IF
            IF g_para_data2 = 'N' THEN
               NEXT FIELD faah003
            END IF
            IF g_faah_m.faah002 != '1' THEN 
               NEXT FIELD faah004
            END IF
         ELSE
            CASE DIALOG.getCurrentItem()
               WHEN "s_detail1"
                  RETURN "faaiseq"
 
            END CASE
         END IF
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
 
      SELECT SUM(faai007) INTO l_faai007_sum
        FROM faai_t
       WHERE faaient = g_enterprise
         AND faai001 = g_faah_m.faah001
         AND faai002 = g_faah_m.faah003
         AND faai003 = g_faah_m.faah004
         
      IF l_faai007_sum > g_faah_m.faah018 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00019'
         LET g_errparam.extend = l_faai007_sum
         LET g_errparam.popup = TRUE
#         LET g_faai_d[l_ac].faai007 = g_faai_d_t.faai007
         CALL cl_err()
      END IF

   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afai100_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE faah_t.faah000 
   DEFINE l_oldno     LIKE faah_t.faah000 
   DEFINE l_newno02     LIKE faah_t.faah001 
   DEFINE l_oldno02     LIKE faah_t.faah001 
   DEFINE l_newno03     LIKE faah_t.faah003 
   DEFINE l_oldno03     LIKE faah_t.faah003 
   DEFINE l_newno04     LIKE faah_t.faah004 
   DEFINE l_oldno04     LIKE faah_t.faah004 
 
   DEFINE l_master    RECORD LIKE faah_t.* #此變數樣板目前無使用
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
   IF g_faah_m.faah000 IS NULL
      OR g_faah_m.faah001 IS NULL
      OR g_faah_m.faah003 IS NULL
      OR g_faah_m.faah004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_faah000_t = g_faah_m.faah000
   LET g_faah001_t = g_faah_m.faah001
   LET g_faah003_t = g_faah_m.faah003
   LET g_faah004_t = g_faah_m.faah004
 
   
   #清空key值
   LET g_faah_m.faah000 = ""
   LET g_faah_m.faah001 = ""
   LET g_faah_m.faah003 = ""
   LET g_faah_m.faah004 = ""
 
    
   CALL afai100_set_entry("a")
   CALL afai100_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faah_m.faahownid = g_user
      LET g_faah_m.faahowndp = g_dept
      LET g_faah_m.faahcrtid = g_user
      LET g_faah_m.faahcrtdp = g_dept 
      LET g_faah_m.faahcrtdt = cl_get_current()
      LET g_faah_m.faahmodid = g_user
      LET g_faah_m.faahmoddt = cl_get_current()
      LET g_faah_m.faahstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
#   IF g_para_data = 'Y' THEN 
#      SELECT lpad((MAX(faah001) + 1),10,'0') INTO g_faah_m.faah001
#        FROM faah_t
#       WHERE faahent = g_enterprise
#      IF cl_null(g_faah_m.faah001) THEN 
#         LET g_faah_m.faah001 = 1
#      END IF
#   END IF 
   CALL afai100_init_para()
   IF g_faah_m.faah002 = '1' THEN 
      LET g_faah_m.faah004 = ' '
   ELSE
      LET g_faah_m.faah004 = ''
   END IF
   LET g_faah_m.faah040 = ''
   LET g_faah_m.faah057 = '' #160426-00014#15 add
   LET g_faaj_m.faaj030 = ''
   DISPLAY BY NAME g_faaj_m.faaj030
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faah_m.faahstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afai100_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_faah_m.* TO NULL
      CALL afai100_show()
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
      LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
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
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_faah000_t = g_faah_m.faah000
   LET g_faah001_t = g_faah_m.faah001
   LET g_faah003_t = g_faah_m.faah003
   LET g_faah004_t = g_faah_m.faah004
 
   
   #組合新增資料的條件
   LET g_add_browse = " faahent = " ||g_enterprise|| " AND",
                      " faah000 = '", g_faah_m.faah000, "' "
                      ," AND faah001 = '", g_faah_m.faah001, "' "
                      ," AND faah003 = '", g_faah_m.faah003, "' "
                      ," AND faah004 = '", g_faah_m.faah004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai100_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
              
   LET g_data_owner = g_faah_m.faahownid      
   LET g_data_dept  = g_faah_m.faahowndp
              
   #功能已完成,通報訊息中心
   CALL afai100_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afai100.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afai100_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef017  LIKE ooef_t.ooef017
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   CALL cl_set_combo_scc('faah015','9914') 
   IF g_faah_m.faahstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #CALL cl_set_act_visible("reproduce", FALSE)
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_faah_m.faah028
      
   SELECT glaald INTO g_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'
      
#   IF NOT cl_null(g_faah_m.faah002) THEN 
#      IF g_faah_m.faah002 = '1' THEN 
#         CALL cl_set_comp_entry("faah004",FALSE)
#      ELSE
#         CALL cl_set_comp_entry("faah004",TRUE)
#      END IF
#   END IF 

   #161121-00003#3 add s---
   IF g_faaj_m.faaj048 = '1' THEN 
      CALL cl_set_comp_entry("faaj003",FALSE)
   ELSE
      CALL cl_set_comp_entry("faaj003",TRUE)
   END IF
   #161121-00003#3 add e---
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afai100_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #獲取匯率
   CALL afai100_faaj015_desc_get()
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
      
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
       g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah006_desc,g_faah_m.faah007,g_faah_m.faah007_desc, 
       g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
       g_faah_m.faah017_desc,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah020_desc, 
       g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faaj015_desc,g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025, 
       g_faah_m.faah025_desc,g_faah_m.faah026,g_faah_m.faah026_desc,g_faah_m.faah027,g_faah_m.faah027_desc, 
       g_faah_m.faah028,g_faah_m.faah028_desc,g_faah_m.faah030,g_faah_m.faah030_desc,g_faah_m.faah031, 
       g_faah_m.faah031_desc,g_faah_m.faah032,g_faah_m.faah032_desc,g_faah_m.faah029,g_faah_m.faah029_desc, 
       g_faah_m.faah009,g_faah_m.faah009_desc,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah010_desc, 
       g_faah_m.faah011,g_faah_m.faah011_desc,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah008_desc, 
       g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044, 
       g_faah_m.faah041,g_faah_m.faah041_desc,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057, 
       g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahownid_desc, 
       g_faah_m.faahowndp,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahcrtdp_desc,g_faah_m.faahmodid,g_faah_m.faahmodid_desc,g_faah_m.faahmoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afai100_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faah_m.faahstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afai100_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_sql           STRING
   DEFINE  l_n             LIKE type_t.num5  
   DEFINE  l_faap001       LIKE faap_t.faap001
   DEFINE  l_faap002       LIKE faap_t.faap002
   DEFINE  l_faap003       LIKE faap_t.faap003
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_faah_m.faah000 IS NULL
   OR g_faah_m.faah001 IS NULL
   OR g_faah_m.faah003 IS NULL
   OR g_faah_m.faah004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_faah000_t = g_faah_m.faah000
   LET g_faah001_t = g_faah_m.faah001
   LET g_faah003_t = g_faah_m.faah003
   LET g_faah004_t = g_faah_m.faah004
 
   
   
 
   OPEN afai100_cl USING g_enterprise,g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai100_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afai100_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
       g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
       g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
       g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
       g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
       g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
       g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
       g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
       g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
       g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
       g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
       g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
       g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
       g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
       g_faah_m.faahmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT afai100_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faah_m_mask_o.* =  g_faah_m.*
   CALL afai100_faah_t_mask()
   LET g_faah_m_mask_n.* =  g_faah_m.*
   
   #將最新資料顯示到畫面上
   CALL afai100_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afai100_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM faah_t 
       WHERE faahent = g_enterprise AND faah000 = g_faah_m.faah000 
         AND faah001 = g_faah_m.faah001 
         AND faah003 = g_faah_m.faah003 
         AND faah004 = g_faah_m.faah004 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM faaj_t 
       WHERE faajent = g_enterprise 
         AND faaj001 = g_faah_m.faah003 
         AND faaj002 = g_faah_m.faah004 
         AND faaj037 = g_faah_m.faah001 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faaj_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF 
      #150731-00008 1 若財編是由分錄底稿產生，需將更新碼還原為N，且刪除faap_t的資料
      SELECT COUNT(*) INTO l_n FROM faap_t
       WHERE faapent = g_enterprise AND faap007 = g_faah_m.faah001
         AND faap008 = g_faah_m.faah003 AND faap009 = g_faah_m.faah004
         
      IF l_n > 0 THEN
         LET l_sql = " SELECT faap001,faap002,faap003 FROM faap_t ",
                     "  WHERE faapent = ",g_enterprise," AND faap007 = '",g_faah_m.faah001,"'",
                     "    AND faap008 = '",g_faah_m.faah003,"' AND faap009 = '",g_faah_m.faah004,"'"
         PREPARE faap_prep FROM l_sql
         DECLARE faap_curs CURSOR FOR faap_prep
         FOREACH faap_curs INTO l_faap001,l_faap002,l_faap003 
            UPDATE faak_t SET faak043 = 'N'
             WHERE faakent = g_enterprise AND faak001 = l_faap001 
               AND faak003 = l_faap002 AND faak004 =l_faap003 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faak_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
            END IF 
            
            DELETE FROM faap_t
             WHERE faapent = g_enterprise AND faap001 = l_faap001 
               AND faap002 = l_faap002 AND faap003 =l_faap003 
               AND faap007 = g_faah_m.faah001 AND faap008 = g_faah_m.faah003
               AND faap009 = g_faah_m.faah004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faap_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
            END IF 
         END FOREACH
      END IF
      #150731-00008 1 
      
      #161116-00036#1--add--str--
      #同步删除faai_t资产标签资料
      DELETE FROM faai_t 
       WHERE faaient = g_enterprise
         AND faai000 = g_faah_m.faah000       
         AND faai001 = g_faah_m.faah001 
         AND faai002 = g_faah_m.faah003 
         AND faai003 = g_faah_m.faah004 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faaj_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF 
      #161116-00036#1--add--end
      
      IF g_para_data3 = 'Y' AND g_para_data2 ='N' AND g_faah_m.faah002 = '1'THEN  #161129-00046#1 add
      #151006-----s
      #自動編碼更新
      CALL s_aooi390_oofi_del('3',g_faah_m.faah003)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "s_aooi390_oofi_del:" 
         LET g_errparam.code   = '100'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF 
      #151006-----e
      END IF #161129-00046#1 add
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_faah_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afai100_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afai100_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afai100_browser_fill(g_wc,"")
         CALL afai100_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afai100_cl
 
   #功能已完成,通報訊息中心
   CALL afai100_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afai100_ui_browser_refresh()
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
      IF g_browser[l_i].b_faah000 = g_faah_m.faah000
         AND g_browser[l_i].b_faah001 = g_faah_m.faah001
         AND g_browser[l_i].b_faah003 = g_faah_m.faah003
         AND g_browser[l_i].b_faah004 = g_faah_m.faah004
 
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
 
{<section id="afai100.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afai100_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("faah000,faah001,faah003,faah004",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #albireo 150825-----s
   #修正部分欄位開關位置   到標準位置呼叫
   CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj019,faaj028,
                                faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",TRUE)
    
   #albireo 150825----e

   IF g_para_data = 'N' THEN 
      CALL cl_set_comp_entry("faah001",TRUE)
   END IF
   IF g_faah_m.faah002 = '1' THEN 
      CALL cl_set_comp_entry("faah004",FALSE)
   ELSE
      CALL cl_set_comp_entry("faah004",TRUE)
   END IF
   IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
      CALL cl_set_comp_entry("faah003",FALSE)               
      LET g_faah_m.faah003 = g_faah_m.faah001
      DISPLAY BY NAME g_faah_m.faah003
   ELSE
      CALL cl_set_comp_entry("faah003",TRUE)  
   END IF
   #add by yangxf ---
   #IF NOT cl_null(g_faah_m.faah040) THEN     #160426-00014#15 mark
   IF NOT cl_null(g_faah_m.faah040) OR NOT cl_null(g_faah_m.faah057) THEN  #160426-00014#15 add   
      #CALL cl_set_comp_entry("faah017,faah018,faah020,faah021,faah023,faah028",FALSE)    #160923-00019#1 mark lujh
      CALL cl_set_comp_entry("faah018,faah020,faah021,faah023,faah028",FALSE)             #160923-00019#1 add lujh
   ELSE
      #CALL cl_set_comp_entry("faah017,faah018,faah020,faah021,faah023,faah028",TRUE)     #160923-00019#1 mark lujh
      CALL cl_set_comp_entry("faah018,faah020,faah021,faah023,faah028",TRUE)              #160923-00019#1 add lujh
   END IF
   #add by yangxf ---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afai100_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("faah000,faah001,faah003,faah004",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      IF g_faah_m.faah002 = '1' THEN
         CALL cl_set_comp_entry("faah003",TRUE)
      ELSE
         CALL cl_set_comp_entry("faah003,faah004",TRUE)
      END IF
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'u' THEN 
      CALL cl_set_comp_entry("faah002,faah003,faah015",FALSE)   #160819-00041#1 add faah015 lujh
   ELSE
      CALL cl_set_comp_entry("faah002,faah015",TRUE)            #160819-00041#1 add faah015 lujh
   END IF 
   IF g_para_data = 'Y' THEN 
      IF p_cmd = 'a' THEN LET g_faah_m.faah001 = '' END IF
      CALL cl_set_comp_entry("faah001",FALSE)
   ELSE 
      CALL cl_set_comp_entry("faah001",TRUE)
   END IF
   
   #albireo 150825-----s
   #修正部分欄位開關位置到標準位置
   IF NOT cl_null(g_faaj_m.faaj030) THEN 
      CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj028,
                                   faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                   faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",FALSE)
   END IF
   #albireo 150825-----e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afai100_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_faah_m.faahstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afai100.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afai100_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afai100.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afai100_default_search()
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
      LET ls_wc = ls_wc, " faah000 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " faah001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faah003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " faah004 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #底稿抛转参数（afap200）
   IF NOT cl_null(g_argv[05]) THEN 
      LET ls_wc = ls_wc, " (faah040 = ", g_argv[05], " AND "
      
   END IF
   IF NOT cl_null(g_argv[06]) THEN 
      LET ls_wc = ls_wc, " faah040 = '", g_argv[06], "' AND "
      
   END IF
   #160426-00014#15 add s---
   IF NOT cl_null(g_argv[07]) THEN 
      LET ls_wc = ls_wc, "( faah057 = ", g_argv[07], " AND "
   END IF
   #160426-00014#15 add e---
   
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
#   IF g_wc = " 1=2" THEN LET g_wc = " 1=1" END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="afai100.mask_functions" >}
&include "erp/afa/afai100_mask.4gl"
 
{</section>}
 
{<section id="afai100.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afai100_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_n                   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_faah_m.faah000 IS NULL
      OR g_faah_m.faah001 IS NULL      OR g_faah_m.faah003 IS NULL      OR g_faah_m.faah004 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afai100_cl USING g_enterprise,g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004
   IF STATUS THEN
      CLOSE afai100_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai100_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
       g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
       g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
       g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
       g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
       g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
       g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
       g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
       g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
       g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
       g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
       g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
       g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
       g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
       g_faah_m.faahmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT afai100_action_chk() THEN
      CLOSE afai100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
       g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah006_desc,g_faah_m.faah007,g_faah_m.faah007_desc, 
       g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
       g_faah_m.faah017_desc,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah020_desc, 
       g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faaj015_desc,g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025, 
       g_faah_m.faah025_desc,g_faah_m.faah026,g_faah_m.faah026_desc,g_faah_m.faah027,g_faah_m.faah027_desc, 
       g_faah_m.faah028,g_faah_m.faah028_desc,g_faah_m.faah030,g_faah_m.faah030_desc,g_faah_m.faah031, 
       g_faah_m.faah031_desc,g_faah_m.faah032,g_faah_m.faah032_desc,g_faah_m.faah029,g_faah_m.faah029_desc, 
       g_faah_m.faah009,g_faah_m.faah009_desc,g_faah_m.faah000,g_faah_m.faah010,g_faah_m.faah010_desc, 
       g_faah_m.faah011,g_faah_m.faah011_desc,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah008_desc, 
       g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044, 
       g_faah_m.faah041,g_faah_m.faah041_desc,g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057, 
       g_faah_m.faah050,g_faah_m.faah054,g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahownid_desc, 
       g_faah_m.faahowndp,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdt, 
       g_faah_m.faahcrtdp,g_faah_m.faahcrtdp_desc,g_faah_m.faahmodid,g_faah_m.faahmodid_desc,g_faah_m.faahmoddt 
 
 
   CASE g_faah_m.faahstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   LET l_success = TRUE    #160922-00040#1 add lujh
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_faah_m.faahstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_err_collect_init()
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
         #20150506--mark--str--lujh  拿到sub里去了 改成call sub
         #IF g_faah_m.faahstus = 'X' THEN 
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = 'afa-00023'
         #   LET g_errparam.extend = ''
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #
         #   RETURN
         #END IF
         ##检查是否存在与异动档中
         #LET l_n = 0
         #SELECT COUNT(*) INTO l_n
         #  FROM fabb_t
         # WHERE fabb001 = g_faah_m.faah003
         #   AND fabb000 = g_faah_m.faah001
         #   AND fabb002 = g_faah_m.faah004
         #IF l_n > 0 THEN 
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = 'afa-00326'
         #   LET g_errparam.extend = ''
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   RETURN
         #END IF 
         #LET l_n = 0
         #SELECT COUNT(*) INTO l_n
         #  FROM fabh_t
         # WHERE fabh001 = g_faah_m.faah003
         #   AND fabh000 = g_faah_m.faah001
         #   AND fabh002 = g_faah_m.faah004
         #IF l_n > 0 THEN 
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = 'afa-00326'
         #   LET g_errparam.extend = ''
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   RETURN
         #END IF 
         #IF g_faah_m.faah015 <> '0' THEN 
         #   IF g_faah_m.faah033 = 'Y' AND g_faah_m.faah015 = '1' THEN 
         #      UPDATE faah_t SET faah015 = '0' 
         #       WHERE faahent = g_enterprise AND faah000 = g_faah_m.faah000
         #         AND faah001 = g_faah_m.faah001
         #         AND faah003 = g_faah_m.faah003
         #         AND faah004 = g_faah_m.faah004
         #      
         #      IF SQLCA.sqlcode THEN
         #         INITIALIZE g_errparam TO NULL 
         #         LET g_errparam.extend = "" 
         #         LET g_errparam.code   = SQLCA.sqlcode 
         #         LET g_errparam.popup  = FALSE 
         #         CALL cl_err()
         #      ELSE
         #         LET g_faah_m.faah015 = '0'
         #         DISPLAY BY NAME g_faah_m.faah015
         #      END IF
         #   ELSE 
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.code = 'afa-00102'
         #      LET g_errparam.extend = ''
         #      LET g_errparam.popup = TRUE
         #      CALL cl_err()
         #      RETURN
         #   END IF 
         #END IF
         #20150506--mark--end--lujh  拿到sub里去了 改成call sub
         
         #20150506--add--str--lujh 
         CALL s_afai100_unconfirm_chk(g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004)
         RETURNING l_success
         
         IF l_success = TRUE THEN 
            CALL s_afai100_unconfirm(g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004)
            RETURNING l_success
         END IF
         #20150506--add--end--lujh 
        #DISPLAY BY NAME g_faah_m.faah015 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            #20150506--mark--str--lujh  拿到sub里去了 改成call sub
            #CALL afai100_confirm() RETURNING l_success
            #
            #IF l_success = FALSE THEN 
            #   RETURN
            #END IF
            #DISPLAY BY NAME g_faah_m.faah015            
            #20150506--mark--end--lujh  拿到sub里去了 改成call sub
            
            #20150506--add--str--lujh 
            CALL s_afai100_confirm_chk(g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004)
            RETURNING l_success
            
            IF l_success = TRUE THEN 
               CALL s_afai100_confirm(g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004)
               RETURNING l_success
            END IF
            #20150506--add--end--lujh 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
         IF g_faah_m.faahstus = 'Y' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00045'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
            RETURN
         END IF
        #DISPLAY BY NAME g_faah_m.faah015 
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_faah_m.faahstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afai100_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   LET g_faah_m.faahmodid = g_user
   LET g_faah_m.faahmoddt = cl_get_current()
   LET g_faah_m.faahstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE faah_t 
      SET (faahstus,faahmodid,faahmoddt) 
        = (g_faah_m.faahstus,g_faah_m.faahmodid,g_faah_m.faahmoddt)     
    WHERE faahent = g_enterprise AND faah000 = g_faah_m.faah000
      AND faah001 = g_faah_m.faah001      AND faah003 = g_faah_m.faah003      AND faah004 = g_faah_m.faah004
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afai100_master_referesh USING g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004 INTO g_faah_m.faah001, 
          g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012,g_faah_m.faah013,g_faah_m.faah006, 
          g_faah_m.faah007,g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016, 
          g_faah_m.faah017,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah021,g_faah_m.faah022, 
          g_faah_m.faah023,g_faah_m.faah024,g_faah_m.faah025,g_faah_m.faah026,g_faah_m.faah027,g_faah_m.faah028, 
          g_faah_m.faah030,g_faah_m.faah031,g_faah_m.faah032,g_faah_m.faah029,g_faah_m.faah009,g_faah_m.faah000, 
          g_faah_m.faah010,g_faah_m.faah011,g_faah_m.faah046,g_faah_m.faah033,g_faah_m.faah008,g_faah_m.faah042, 
          g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041, 
          g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
          g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahowndp,g_faah_m.faahcrtid,g_faah_m.faahcrtdt, 
          g_faah_m.faahcrtdp,g_faah_m.faahmodid,g_faah_m.faahmoddt,g_faah_m.faah006_desc,g_faah_m.faah007_desc, 
          g_faah_m.faah017_desc,g_faah_m.faah020_desc,g_faah_m.faah025_desc,g_faah_m.faah026_desc,g_faah_m.faah027_desc, 
          g_faah_m.faah028_desc,g_faah_m.faah030_desc,g_faah_m.faah031_desc,g_faah_m.faah032_desc,g_faah_m.faah029_desc, 
          g_faah_m.faah009_desc,g_faah_m.faah010_desc,g_faah_m.faah011_desc,g_faah_m.faah008_desc,g_faah_m.faah041_desc, 
          g_faah_m.faahownid_desc,g_faah_m.faahowndp_desc,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdp_desc, 
          g_faah_m.faahmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah002,g_faah_m.faah012, 
          g_faah_m.faah013,g_faah_m.faah006,g_faah_m.faah006_desc,g_faah_m.faah007,g_faah_m.faah007_desc, 
          g_faah_m.faah005,g_faah_m.faahstus,g_faah_m.faah014,g_faah_m.faah015,g_faah_m.faah016,g_faah_m.faah017, 
          g_faah_m.faah017_desc,g_faah_m.faah018,g_faah_m.faah019,g_faah_m.faah020,g_faah_m.faah020_desc, 
          g_faah_m.faah021,g_faah_m.faah022,g_faah_m.faaj015_desc,g_faah_m.faah023,g_faah_m.faah024, 
          g_faah_m.faah025,g_faah_m.faah025_desc,g_faah_m.faah026,g_faah_m.faah026_desc,g_faah_m.faah027, 
          g_faah_m.faah027_desc,g_faah_m.faah028,g_faah_m.faah028_desc,g_faah_m.faah030,g_faah_m.faah030_desc, 
          g_faah_m.faah031,g_faah_m.faah031_desc,g_faah_m.faah032,g_faah_m.faah032_desc,g_faah_m.faah029, 
          g_faah_m.faah029_desc,g_faah_m.faah009,g_faah_m.faah009_desc,g_faah_m.faah000,g_faah_m.faah010, 
          g_faah_m.faah010_desc,g_faah_m.faah011,g_faah_m.faah011_desc,g_faah_m.faah046,g_faah_m.faah033, 
          g_faah_m.faah008,g_faah_m.faah008_desc,g_faah_m.faah042,g_faah_m.faah035,g_faah_m.faah036, 
          g_faah_m.faah037,g_faah_m.faah043,g_faah_m.faah044,g_faah_m.faah041,g_faah_m.faah041_desc, 
          g_faah_m.faah038,g_faah_m.faah039,g_faah_m.faah040,g_faah_m.faah057,g_faah_m.faah050,g_faah_m.faah054, 
          g_faah_m.faah055,g_faah_m.faahownid,g_faah_m.faahownid_desc,g_faah_m.faahowndp,g_faah_m.faahowndp_desc, 
          g_faah_m.faahcrtid,g_faah_m.faahcrtid_desc,g_faah_m.faahcrtdt,g_faah_m.faahcrtdp,g_faah_m.faahcrtdp_desc, 
          g_faah_m.faahmodid,g_faah_m.faahmodid_desc,g_faah_m.faahmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   UPDATE faaj_t 
      SET (faajstus,faajmodid,faajmoddt) 
        = (g_faah_m.faahstus,g_faah_m.faahmodid,g_faah_m.faahmoddt)     
    WHERE faajent = g_enterprise AND faaj000 = g_faah_m.faah000
      AND faaj037 = g_faah_m.faah001      
      AND faaj001 = g_faah_m.faah003
      AND faaj002 = g_faah_m.faah004
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afai100_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai100_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai100.signature" >}
   
 
{</section>}
 
{<section id="afai100.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afai100_set_pk_array()
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
   LET g_pk_array[1].values = g_faah_m.faah000
   LET g_pk_array[1].column = 'faah000'
   LET g_pk_array[2].values = g_faah_m.faah001
   LET g_pk_array[2].column = 'faah001'
   LET g_pk_array[3].values = g_faah_m.faah003
   LET g_pk_array[3].column = 'faah003'
   LET g_pk_array[4].values = g_faah_m.faah004
   LET g_pk_array[4].column = 'faah004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai100.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afai100.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afai100_msgcentre_notify(lc_state)
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
   CALL afai100_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_faah_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai100.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afai100_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afai100.other_function" readonly="Y" >}
# 抓取匯率
PRIVATE FUNCTION afai100_get_exrate(p_ld,p_ooan002,p_glaa001,p_glaa025)
   DEFINE p_ld           LIKE glaa_t.glaald
   DEFINE p_glaa001      LIKE glaa_t.glaa001
   DEFINE p_glaa025      LIKE glaa_t.glaa025
   DEFINE p_ooan002      LIKE ooan_t.ooan002
   
   LET g_ooan005 = NULL
   IF NOT cl_null(p_ld) AND NOT cl_null(p_ooan002) AND NOT cl_null(p_glaa001) AND NOT cl_null(p_glaa025) AND NOT cl_null(g_faah_m.faah014) THEN   #160918-00015#1 add lujh   #161208-00075#1 add AND NOT cl_null(g_faah_m.faah014) lujh
                               #     帳套; 日期;       來源幣別
      CALL s_aooi160_get_exrate('2',p_ld,g_faah_m.faah014,p_ooan002,     #161208-00075#1 change g_today to g_faah_m.faah014
                            #目的幣別;  交易金額;              匯類類型
                             p_glaa001,0,p_glaa025)
      RETURNING g_ooan005
   #160918-00015#1--add--str--lujh
   ELSE
      LET g_ooan005 = 1
   END IF
   #160918-00015#1--add--end--lujh
END FUNCTION
# faah003財產編號檢查
PRIVATE FUNCTION afai100_faah003_chk()
   DEFINE l_n      LIKE type_t.num5
   
   IF NOT cl_null(g_faah_m.faah002) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah002 <> '1' THEN 
      SELECT count(*) INTO l_n 
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = g_faah_m.faah003
         AND faah002 = '1'
         
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00016'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
   END IF
  
#   IF NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah002 = '1' THEN
#      SELECT count(*) INTO l_n 
#        FROM faah_t
#       WHERE faahent = g_enterprise
#         AND faah003 = g_faah_m.faah003
#         AND faah002 = '1'
#         
#      IF l_n > 0 THEN 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'afa-00252'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN FALSE
#      END IF 
#   END IF
   RETURN TRUE
END FUNCTION
# faah006主要類型帶值
PRIVATE FUNCTION afai100_faah006_get()
   DEFINE l_faaj023  LIKE faaj_t.faaj023
   DEFINE l_faaj024  LIKE faaj_t.faaj024
   DEFINE l_faaj025  LIKE faaj_t.faaj025
   DEFINE l_faaj026  LIKE faaj_t.faaj026
   DEFINE l_faajld   LIKE faaj_t.faajld
   DEFINE l_sql      STRING 
   DEFINE l_faal005  LIKE faal_t.faal005
   DEFINE l_num1     LIKE type_t.num5
   DEFINE l_num2     LIKE type_t.num5
   DEFINE l_str1     STRING
   DEFINE l_str2     STRING
   DEFINE l_year     STRING
   DEFINE l_month    STRING
   DEFINE l_str      STRING
   DEFINE l_fristdate LIKE faah_t.faah014
   DEFINE l_faaj008  LIKE faaj_t.faaj008
   
#   SELECT faac002,faac007,faac008,faac009,faac010,faac011,faac016,faac003,faac004
   SELECT faac002,faac007,faac009,faac010,faac011,faac016,faac003,faac004,faac012,faac013,faac015  #160408-00020#1 add faac012,faac013,faac015
     INTO g_faah_m.faah005,g_faah_m.faah033,
#          g_faah_m.faah034,g_faah_m.faah035,
          g_faah_m.faah035,
          g_faah_m.faah036,g_faah_m.faah037,
          g_faac016,g_faac003,g_faac004,
          g_faah_m.faah054,g_faah_m.faah050,g_faah_m.faah055     #160408-00020#1 add  
     FROM faac_t
    WHERE faacent = g_enterprise
      AND faac001 = g_faah_m.faah006
      
  
   
  #DISPLAY g_faah_m.faah005 TO faah005 #yangtt 2015/6/3
  #DISPLAY g_faah_m.faah033 TO faah033   #yangtt 2015/6/3
#   DISPLAY g_faah_m.faah034 TO faah034
  #DISPLAY g_faah_m.faah035 TO faah035   #yangtt 2015/6/3
  #DISPLAY g_faah_m.faah036 TO faah036   #yangtt 2015/6/3
  #DISPLAY g_faah_m.faah037 TO faah037   #yangtt 2015/6/3
   DISPLAY BY NAME g_faah_m.faah005,g_faah_m.faah035,g_faah_m.faah036,g_faah_m.faah037,   #yangtt 2015/6/3
                   g_faah_m.faah054,g_faah_m.faah050,g_faah_m.faah055     #160408-00020#1 add 
   LET g_faaj019 = g_faac016 * (g_faaj_m.faaj016 /100)
   IF NOT cl_null(g_faaj_m.faajld) THEN 
     #DISPLAY g_faac003 TO faaj003       #yangtt 2015/6/3
     #DISPLAY g_faac004 TO faaj004       #yangtt 2015/6/3
     #DISPLAY g_faac004 TO faaj005       #yangtt 2015/6/3
     #DISPLAY g_faaj019 TO faaj019       #yangtt 2015/6/3
      LET g_faaj_m.faaj003 = g_faac003   #yangtt 2015/6/3
      LET g_faaj_m.faaj004 = g_faac004   #yangtt 2015/6/3
      LET g_faaj_m.faaj005 = g_faac004   #yangtt 2015/6/3
      LET g_faaj_m.faaj019 = g_faaj019   #yangtt 2015/6/3
      DISPLAY BY NAME g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj019 #yangtt 2015/6/3
   END IF 

   LET l_sql = "SELECT faajld FROM faaj_t ",
               " WHERE faaj000 = '",g_faah_m.faah000,"'",
               "   AND faaj001 = '",g_faah_m.faah003,"'",
               "   AND faaj037 = '",g_faah_m.faah001,"'",
               "   AND faaj002 = '",g_faah_m.faah004,"'"
   PREPARE sel_faajld FROM l_sql
   DECLARE sel_faajcs CURSOR FOR sel_faajld
   FOREACH sel_faajcs INTO l_faajld
      LET l_faaj023 = ''
      LET l_faaj024 = ''
      LET l_faaj025 = ''
      LET l_faaj026 = ''
      SELECT glab005 INTO l_faaj023
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = l_faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_01'
      #累折科目
      SELECT glab005 INTO l_faaj024
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = l_faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_02'   
      
      #折舊科目 
      SELECT glab005 INTO l_faaj025
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = l_faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_03'   
   
      #減值準備科目   
      SELECT glab005 INTO l_faaj026
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = l_faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_04'   
         
      #抓取本月入帳提列方式
      SELECT faal005 INTO l_faal005
        FROM faal_t
       WHERE faalent = g_enterprise
         AND faalld  = l_faajld
         AND faal001 = g_faah_m.faah006
      
      LET l_year = YEAR(g_faah_m.faah014)
      LET l_month = MONTH(g_faah_m.faah014)
      IF NOT cl_null(g_faal005) THEN
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
            CALL s_date_get_first_date(g_faah_m.faah014) RETURNING l_fristdate
            LET l_fristdate = l_fristdate + 14
            IF g_faah_m.faah014 <= l_fristdate THEN 
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
         LET l_faaj008 = l_str.trim()
         IF l_faajld = g_faaj_m.faajld THEN 
            LET g_faaj_m.faaj008 = l_faaj008
         END IF
         UPDATE faaj_t SET faaj023 = l_faaj023,
                           faaj024 = l_faaj024,
                           faaj025 = l_faaj025,
                           faaj026 = l_faaj026,
                           faaj008 = l_faaj008
          WHERE faajent = g_enterprise
            AND faajld = l_faajld
            AND faaj000 = g_faah_m.faah000
            AND faaj001 = g_faah_m.faah003
            AND faaj002 = g_faah_m.faah004
            AND faaj037 = g_faah_m.faah001
         IF l_faajld = g_faaj_m.faajld THEN 
            LET g_faaj_m.faaj023 = l_faaj023
            LET g_faaj_m.faaj024 = l_faaj024
            LET g_faaj_m.faaj025 = l_faaj025
            LET g_faaj_m.faaj026 = l_faaj026
         END IF 
      END IF 
   END FOREACH 
   IF NOT cl_null(g_faaj_m.faajld) THEN 
      DISPLAY g_faaj_m.faaj023 TO faaj023
      DISPLAY g_faaj_m.faaj024 TO faaj024
      DISPLAY g_faaj_m.faaj025 TO faaj025
      DISPLAY g_faaj_m.faaj026 TO faaj026
      DISPLAY g_faaj_m.faaj008 TO faaj008
      CALL afai100_depreciation_ref()  
   END IF 
  
   
END FUNCTION
# 帳套折舊信息頁簽顯示
PRIVATE FUNCTION afai100_show2()
    #add-point:show段define

   #end add-point  
   
   #add-point:show段之前
   
   
    #######################################add by huangtao
    #需要添加select faaj显示一下最好
    #######################################add by huangtao    
  CALL afai100_faajld_desc()
   CALL afai100_depreciation_ref()
   CALL afai100_visible()
  
#   IF g_faaj_m.faaj011 = 'Y' THEN 
#      CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
#   ELSE
#      CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
#   END IF
   
   #抓取本月入帳提列方式
   SELECT faal005 INTO g_faal005 
     FROM faal_t
    WHERE faalent = g_enterprise
      AND faalld  = g_faaj_m.faajld
      AND faal001 = g_faah_m.faah006
      
   IF g_faal005 <> '4' THEN 
      CALL cl_set_comp_visible('faaj029,faaj109,faaj159',FALSE) 
   ELSE 
      CALL cl_set_comp_visible('faaj029,faaj109,faaj159',TRUE) 
   END IF
   
   IF g_faaj_m.faaj006 = '2' OR g_faaj_m.faaj006 = '1' THEN
      CALL cl_set_comp_required('faaj007',TRUE)
   ELSE
      CALL cl_set_comp_required('faaj007',FALSE)
   END IF
   #end add-point
   
   
   
   LET g_faaj_m_t.* = g_faaj_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference


   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faaj_m.faajld  ,g_faaj_m.faaj000,g_faaj_m.faaj001,g_faaj_m.faaj002,g_faaj_m.faaj037,    
                   g_faaj_m.glaacomp,g_faaj_m.glaa004,g_faaj_m.faaj006,g_faaj_m.faaj007,      
                   g_faaj_m.faaj023 ,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
                   g_faaj_m.faaj003 ,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
                   g_faaj_m.faaj008 ,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
                   g_faaj_m.faaj015 ,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
                   g_faaj_m.faaj019 ,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
                   g_faaj_m.faaj034 ,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
                   g_faaj_m.faaj021 ,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
                   g_faaj_m.faaj106 ,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
                   g_faaj_m.faaj045 ,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
                   g_faaj_m.faaj101 ,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
                   g_faaj_m.faaj111 ,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
                   g_faaj_m.faaj113 ,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
                   g_faaj_m.faaj112 ,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
                   g_faaj_m.faaj154 ,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
                   g_faaj_m.faaj159 ,g_faaj_m.faaj158 ,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
                   g_faaj_m.faaj160 ,g_faaj_m.faaj162,g_faaj_m.faaj048 #160426-00014#8 add faaj048                 

   
   #顯示狀態(stus)圖片
   
 
   #add-point:show段之後

   #end add-point
END FUNCTION
# 上下笔功能
PRIVATE FUNCTION afai100_fetch1(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
 
   #add-point:fetch段define

   #end add-point  
   
   CASE p_fl
      WHEN "F" LET g_current_idx1 = 1
      WHEN "P"
         IF g_current_idx1 > 1 THEN               
            LET g_current_idx1 = g_current_idx1 - 1
         END IF 
      WHEN "N"
         IF g_current_idx1 < g_header_cnt1 THEN
            LET g_current_idx1 =  g_current_idx1 + 1
         END IF        
      WHEN "L" 
         LET g_current_idx1 = g_header_cnt1        
      WHEN "/"
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump1
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump1> 0 THEN
            LET g_current_idx1 = g_jump1
         END IF
         LET g_no_ask = FALSE     
   END CASE
   
   LET g_browser_cnt1 = g_browser1.getLength()
 
   #瀏覽頁筆數顯示
   LET g_browser_idx1 = g_pagestart1+g_current_idx1-1
   #DISPLAY g_browser_idx1 TO FORMONLY.b_index         #當下筆數
   #DISPLAY g_browser_cnt1 TO FORMONLY.b_count         #總筆數
   
   
   DISPLAY g_browser_idx1 TO FORMONLY.h_index1        #當下筆數
   DISPLAY g_browser_cnt1 TO FORMONLY.h_count1        #總筆數
   DISPLAY g_browser_idx1 TO FORMONLY.h_index2        #當下筆數
   DISPLAY g_browser_cnt1 TO FORMONLY.h_count2        #總筆數
  #CALL ui.Interface.refresh()
   
   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數
   
   
   
   IF g_current_idx1 > g_browser1.getLength() THEN
      LET g_current_idx1 = g_browser1.getLength()
   END IF
   
   # 設定browse索引
 
   CALL afai100_navigator_setting(g_browser_idx1, g_browser_cnt1 )
   #CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx1 = 0 THEN
      RETURN
   END IF
 
   LET g_faaj_m.faajld = g_browser1[g_current_idx1].b_faajld
   LET g_faaj_m.faaj000 = g_browser1[g_current_idx1].b_faaj000
   LET g_faaj_m.faaj001 = g_browser1[g_current_idx1].b_faaj001
   LET g_faaj_m.faaj002 = g_browser1[g_current_idx1].b_faaj002
   LET g_faaj_m.faaj037 = g_browser1[g_current_idx1].b_faaj037
 
                       
   #重讀DB,因TEMP有不被更新特性
   SELECT UNIQUE faajld ,faaj000,faaj001,faaj002,    
                 faaj037,faaj006,faaj007,      
                 faaj023,faaj024,faaj025,faaj026,
                 faaj003,faaj004,faaj005,faaj038,
                 faaj008,faaj009,faaj010,faaj014,
                 faaj015,faaj016,faaj017,faaj018,
                 faaj019,faaj020,faaj022,faaj033,
                 faaj034,faaj035,faaj032,faaj027,
                 faaj021,faaj029,faaj028,faaj011,faaj013,faaj012,
                 faaj106,faaj156,faaj042,faaj043,
                 faaj045,faaj046,faaj030,faajsite,
                 faaj101,faaj102,faaj103,faaj104,
                 faaj111,faaj105,faaj117,faaj107,faaj109,faaj108,
                 faaj113,faaj114,faaj115,faaj110,
                 faaj112,faaj151,faaj152,faaj153,
                 faaj154,faaj161,faaj155,faaj167,faaj157,
                 faaj159,faaj158,faaj163,faaj164,faaj165,
                 faaj160,faaj162,faaj048 #160426-00014#8 add faaj048            
 INTO g_faaj_m.faajld ,g_faaj_m.faaj000,g_faaj_m.faaj001,g_faaj_m.faaj002,    
      g_faaj_m.faaj037,g_faaj_m.faaj006,g_faaj_m.faaj007,      
      g_faaj_m.faaj023,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
      g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
      g_faaj_m.faaj008,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
      g_faaj_m.faaj015,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
      g_faaj_m.faaj019,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
      g_faaj_m.faaj034,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
      g_faaj_m.faaj021,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
      g_faaj_m.faaj106,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
      g_faaj_m.faaj045,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
      g_faaj_m.faaj101,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
      g_faaj_m.faaj111,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
      g_faaj_m.faaj113,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
      g_faaj_m.faaj112,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
      g_faaj_m.faaj154,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
      g_faaj_m.faaj159,g_faaj_m.faaj158,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
      g_faaj_m.faaj160,g_faaj_m.faaj162,g_faaj_m.faaj048  #160426-00014#8 add faaj048   
 FROM faaj_t
 WHERE faajent = g_enterprise 
   AND faaj000 = g_faaj_m.faaj000 
   AND faajld = g_faaj_m.faajld 
   AND faaj001 = g_faaj_m.faaj001 
   AND faaj002 = g_faaj_m.faaj002
   AND faaj037 = g_faaj_m.faaj037
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "faaj_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_faaj_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #重新顯示
   CALL afai100_show2()

END FUNCTION
# 帳套折舊
PRIVATE FUNCTION afai100_depreciation(p_cmd)
  DEFINE p_cmd        LIKE type_t.chr1
  DEFINE l_ooef017    LIKE ooef_t.ooef017
  DEFINE l_glaacomp   LIKE glaa_t.glaacomp
  DEFINE l_success    LIKE type_t.num5
  DEFINE l_month      LIKE type_t.num5
  DEFINE l_str        STRING 
  DEFINE l_year       LIKE type_t.num5
  DEFINE l_str1       STRING
  DEFINE l_str2       STRING
  DEFINE l_str3       STRING
  DEFINE l_n          LIKE type_t.num5
  DEFINE l_comp_str   STRING            #161111-00049#5 add 
  DEFINE l_cnt        LIKE type_t.num10 #161111-00049#5 add 
#ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 

   #ADD BY XZG20151203 e

  
  IF g_faah_m.faahstus = 'Y' THEN 
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'afa-00103'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
     CALL cl_err()

     RETURN
  END IF
  
  LET g_faaj_m_t.* = g_faaj_m.*
  
 #CALL cl_set_comp_visible('faaj029,faaj108,faaj158',TRUE) 

  IF p_cmd = 'a' THEN  
     INITIALIZE g_faaj_m.* LIKE faaj_t.*  
     CALL afai100_faajld_desc()
     CALL afai100_depreciation_ref()
     #從afai020中帶折畢再提預設值
     SELECT faac004,faac005,faac006 INTO g_faaj_m.faaj004,g_faaj_m.faaj011,g_faaj_m.faaj013 
       FROM faac_t
      WHERE faacent = g_enterprise 
        AND faac001 = g_faah_m.faah006
        AND faacstus = 'Y'
     LET g_faaj_m.faaj005 = g_faaj_m.faaj004
     DISPLAY BY NAME g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj011,g_faaj_m.faaj013
     DISPLAY '' TO FORMONLY.h_index1        #當下筆數
     DISPLAY '' TO FORMONLY.h_count1        #總筆數
     DISPLAY '' TO FORMONLY.h_index2        #當下筆數
     DISPLAY '' TO FORMONLY.h_count2        #總筆數
     CALL cl_set_comp_entry("faajld",TRUE)
     IF g_faaj_m.faaj011 = 'Y' THEN 
        CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
     ELSE
        CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
     END IF
  ########################需求单号141110-00041 项次1 mod by huangtao 
     SELECT faac003 INTO g_faaj_m.faaj003 FROM faac_t
      WHERE faacent = g_enterprise AND faac001 = g_faah_m.faah006
     DISPLAY BY NAME g_faaj_m.faaj003
  ###########################################################
  END IF
  IF p_cmd = 'u' THEN
     IF g_faaj_m.faajld IS NULL THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = "std-00003"
        LET g_errparam.extend = ""
        LET g_errparam.popup = FALSE
        CALL cl_err()

        RETURN
     END IF
    #############################mark by huangtao
    # IF NOT cl_null(g_faah_m.faah040) THEN
    #    CALL cl_set_comp_entry("faajld",TRUE)
    # ELSE
    #    CALL cl_set_comp_entry("faajld",FALSE)
    # END IF
    #############################mark by huangtao
     IF g_faaj_m.faaj011 = 'Y' THEN 
        CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
     ELSE
        CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
     END IF
  END IF 
  #add by yangxf ---
  #albireo 150825-----s
#  IF NOT cl_null(g_faaj_m.faaj030) THEN 
#     CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj019,faaj028,
#                                  faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
#                                  faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",FALSE)
#  ELSE
#     CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj019,faaj028,
#                                  faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
#                                  faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",TRUE)
#  END IF
  #拿掉預留殘值
  IF NOT cl_null(g_faaj_m.faaj030) THEN 
     CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj028,
                                  faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                  faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",FALSE)
  ELSE
     CALL afai100_set_comp_entry("faaj015,faaj016,faaj017,faaj018,faaj028,
                                  faaj102,faaj103,faaj104,faaj105,faaj111,faaj108,
                                  faaj152,faaj153,faaj154,faaj155,faaj161,faaj158",TRUE)
  END IF
  #albireo 150825-----e
  #add by yangxf ---
  LET g_errshow = 1
  
  #所有組織歸屬法人
  SELECT ooef017 INTO l_ooef017
    FROM ooef_t 
   WHERE ooefent = g_enterprise
     AND ooef001 = g_faah_m.faah028
    
  INPUT BY NAME  g_faaj_m.faajld  ,g_faaj_m.faaj000,g_faaj_m.faaj001,g_faaj_m.faaj002,g_faaj_m.faaj037,    
                 g_faaj_m.glaacomp,g_faaj_m.glaa004,g_faaj_m.faaj006,g_faaj_m.faaj007,      
                 g_faaj_m.faaj023 ,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
                 g_faaj_m.faaj003 ,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
                 g_faaj_m.faaj008 ,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
                 g_faaj_m.faaj015 ,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
                 g_faaj_m.faaj019 ,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
                 g_faaj_m.faaj034 ,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
                 g_faaj_m.faaj021 ,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
                 g_faaj_m.faaj106 ,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
                 g_faaj_m.faaj045 ,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
                 g_faaj_m.faaj101 ,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
                 g_faaj_m.faaj111 ,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
                 g_faaj_m.faaj113 ,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
                 g_faaj_m.faaj112 ,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
                 g_faaj_m.faaj154 ,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
                 g_faaj_m.faaj159 ,g_faaj_m.faaj158 ,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
                 g_faaj_m.faaj160 ,g_faaj_m.faaj162 , g_faaj_m.faaj048 #160426-00014#8 add faaj048              
                           
         ATTRIBUTE(WITHOUT DEFAULTS)
      
      
      
      AFTER FIELD faajld
         IF  NOT cl_null(g_faaj_m.faajld) THEN 
           #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faaj_m.faajld != g_faajld_t )) THEN 
           IF p_cmd = 'a' THEN
              IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faaj_t WHERE "||"faajent = '" ||g_enterprise|| "'  AND "||"faajld = '"||g_faaj_m.faajld ||"' AND "||"faaj001 = '"||g_faah_m.faah003 ||"' AND "||"faaj037 = '"||g_faah_m.faah001 ||"' AND "||" faaj002 = '"||g_faah_m.faah004 ||"' ",'std-00004',0) THEN 
                 LET g_faaj_m.faajld = ''
                 LET g_faaj_m.faaj014 = ''
                 LET g_faaj_m.faaj015 = '' 
                 LET g_faaj_m.faaj101 = ''
                 LET g_faaj_m.faaj102 = ''
                 LET g_faaj_m.faaj151 = ''
                 LET g_faaj_m.faaj152 = ''                 
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF
           END IF
        END IF

        CALL afai100_faajld_desc()
        IF NOT cl_null(g_faaj_m.faajld) THEN 
#此段落由子樣板a19產生
           #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           INITIALIZE g_chkparam.* TO NULL
           
           #設定g_chkparam.*的參數
           LET g_chkparam.arg1 = g_faaj_m.faajld
           #160318-00025#4--add--str
           LET g_errshow = TRUE 
           LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
          #160318-00025#4--add--end
              
           #呼叫檢查存在並帶值的library
           IF cl_chk_exist("v_glaald") THEN
              #檢查成功時後續處理
              #LET  = g_chkparam.return1
              #DISPLAY BY NAME 
              CALL s_ld_chk_authorization(g_user,g_faaj_m.faajld) RETURNING l_success
              IF l_success = FALSE THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axr-00022'
                 LET g_errparam.extend = g_faaj_m.faajld
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_faaj_m.faajld = ''
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF 
              
              #【帐套折旧信息】帐套开窗，需要限定【所有组织】归属在同一个法人下的帐套
              SELECT glaacomp INTO l_glaacomp
                FROM glaa_t
               WHERE glaaent = g_enterprise
                 AND glaald = g_faaj_m.faajld
              IF l_glaacomp <> l_ooef017 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00101'
                 LET g_errparam.extend = g_faaj_m.faajld
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_faaj_m.faajld = ''
                 CALL afai100_faajld_desc()
                 NEXT FIELD CURRENT
              END IF 

              IF p_cmd = 'a' THEN 
                 CALL afai100_faajld_get()
              END IF
           ELSE
              #檢查失敗時後續處理
              LET g_faaj_m.faajld = g_faaj_m_t.faajld
              CALL afai100_faajld_desc()
              NEXT FIELD CURRENT
           END IF
        
        END IF 
        
        
     AFTER FIELD faajsite
        CALL afai100_depreciation_ref()
        IF NOT cl_null(g_faaj_m.faajsite) THEN 
#此段落由子樣板a19產生
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           INITIALIZE g_chkparam.* TO NULL
           
           #設定g_chkparam.*的參數
           LET g_chkparam.arg1 = g_faaj_m.faajsite
#           LET g_chkparam.arg2 = g_site
           #160318-00025#4--add--str
           LET g_errshow = TRUE 
           LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
           #160318-00025#4--add--end
              
           #呼叫檢查存在並帶值的library
#           IF cl_chk_exist("v_faab002") THEN
            #IF cl_chk_exist("v_ooef001") THEN             #161024-00008#1 
            IF cl_chk_exist("v_ooef001_13") THEN           #161024-00008#1           
              #檢查成功時後續處理
              #LET  = g_chkparam.return1
              #DISPLAY BY NAME 
              #161111-00049#5 add s---
              CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
              IF s_chr_get_index_of(l_comp_str,g_faaj_m.faajsite,1) = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-01121'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
                 CALL afai100_depreciation_ref()
                 NEXT FIELD CURRENT                  
              END IF
              IF NOT cl_null(g_faaj_m.faajld) THEN 
                 LET l_cnt = 0
                 #LET g_sql = " SELECT COUNT(1) FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 IN '",l_comp_str,"' AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaa001 = '",g_faaj_m.faajld,"')"  #161205-00051#1 mark lujh
                 LET g_sql = " SELECT COUNT(1) FROM ooef_t WHERE ooefent = ",g_enterprise," AND ",l_comp_str," AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_faaj_m.faajld,"')"   #161205-00051#1 add lujh
                 PREPARE afai100_faajsite_count FROM g_sql
                 EXECUTE afai100_faajsite_count INTO l_cnt   
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 0 THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'afa-01122'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
                    CALL afai100_depreciation_ref()
                    NEXT FIELD CURRENT                      
                 END IF
              END IF              
              #161111-00049#5 add e---              
           ELSE
              #檢查失敗時後續處理
              LET g_faaj_m.faajsite = g_faaj_m_t.faajsite
              CALL afai100_depreciation_ref()
              NEXT FIELD CURRENT
           END IF
        

        END IF 
      
      
      AFTER FIELD faaj023
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj023) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj023,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj023
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj023
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj023 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj023 TO faaj023              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj023,'N') THEN
                   LET g_faaj_m.faaj023 = g_faaj_m_t.faaj023
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj023
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj023 = g_faaj_m_t.faaj023
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj024
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj024) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj024,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj024
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj024
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj024 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj024 TO faaj024              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj024,'N') THEN
                   LET g_faaj_m.faaj024 = g_faaj_m_t.faaj024
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj024
           #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj024 = g_faaj_m_t.faaj024
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj025
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj025) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj025,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj025
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj025
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj025 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj025 TO faaj025              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj025,'N') THEN
                   LET g_faaj_m.faaj025 = g_faaj_m_t.faaj025
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj025
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj025 = g_faaj_m_t.faaj025
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
         

         END IF 
      
      
      AFTER FIELD faaj026
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj026) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj026,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faaj_m.faajld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_faaj_m.faaj026
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_faaj_m.faaj026
                LET g_qryparam.arg3 = g_faaj_m.faajld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_faaj_m.faaj026 = g_qryparam.return1              #將開窗取得的值回傳到變數
             
               DISPLAY g_faaj_m.faaj026 TO faaj026              #顯示到畫面上
               CALL afai100_depreciation_ref()
              END IF
               IF  NOT s_aglt310_lc_subject(g_faaj_m.faajld,g_faaj_m.faaj026,'N') THEN
                   LET g_faaj_m.faaj026 = g_faaj_m_t.faaj026
                   CALL afai100_depreciation_ref()
                   NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.glaa004
            LET g_chkparam.arg2 = g_faaj_m.faaj026
             #160318-00025#4--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
             #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_glac002_3") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj026 = g_faaj_m_t.faaj026
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF
        
         END IF   
         
      ON CHANGE faaj003
         IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
            IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
               IF g_faaj_m.faaj022 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00192'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD faaj022
               END IF
            END IF
         END IF
         
      ON CHANGE faaj006
         LET g_faaj_m.faaj007 = NULL
#         LET g_faaj_m.faaj025 = NULL    #mark by yangxf 
         DISPLAY g_faaj_m.faaj007 TO faaj007
         DISPLAY g_faaj_m.faaj025 TO faaj025
         CALL afai100_depreciation_ref()
         IF g_faaj_m.faaj006 = '2' OR g_faaj_m.faaj006 = '1' THEN
            CALL cl_set_comp_required('faaj007',TRUE)
         ELSE
            CALL cl_set_comp_required('faaj007',FALSE)
         END IF
         
         #折舊科目 
         IF cl_null(g_faaj_m.faaj025) THEN 
            IF g_para_data1 = '1' THEN    #依部門
               IF g_faaj_m.faaj006 = '1' THEN   #單一部門    afai050
                  LET g_faaj_m.faaj007 = g_faah_m.faah026
                  SELECT faae003 INTO g_faaj_m.faaj025
                    FROM faae_t
                   WHERE faaeent = g_enterprise
                     AND faaeld = g_faaj_m.faajld
                     AND faae001 = g_faaj_m.faaj007
                     AND faae002 = g_faah_m.faah006  
               END IF
               IF g_faaj_m.faaj006 = '2' THEN   #多部門   afai021
                  LET g_faaj_m.faaj025 = '' 
               END IF 
               DISPLAY g_faaj_m.faaj007 TO faaj007
               DISPLAY g_faaj_m.faaj025 TO faaj025
               CALL afai100_depreciation_ref()   
            END IF
         END IF

      AFTER FIELD faaj007
         IF g_faaj_m.faaj006 = '1' THEN 
            CALL afai100_depreciation_ref()
            IF NOT cl_null(g_faaj_m.faaj007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faaj_m.faaj007
               LET g_chkparam.arg2 = g_today
			      #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
                  ####################################add by huangtao\根据归属法人的部门来过滤
#161111-00049#5 mod s---                  
#                  SELECT COUNT(*) INTO l_n FROM ooeg_t
#                   WHERE ooeg001 = g_faaj_m.faaj007 AND ooeg009 = g_faah_m.faah032 AND ooegent=g_enterprise #160905-00007#1 add
                  IF NOT cl_null(g_faaj_m.faajld) THEN 
                     SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise
                        AND glaald = g_faaj_m.faajld                  
                     SELECT COUNT(1) INTO l_n FROM ooeg_t WHERE ooeg001 = g_faaj_m.faaj007  
                         AND ooegent=g_enterprise AND ooeg009 = l_glaacomp        
                  ELSE
                     #根据归属法人的部门来过滤
                     SELECT COUNT(1) INTO l_n FROM ooeg_t
                        WHERE ooeg001 = g_faaj_m.faaj007 AND ooeg009 = g_faah_m.faah032 AND ooegent=g_enterprise                  
                  END IF                  
#161111-00049#5 mod e---                  
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'afa-00384'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                     NEXT FIELD faaj007
                     CALL afai100_depreciation_ref()
                  END IF                  
                  ####################################add by huangtao
			      #折舊科目 
			      IF cl_null(g_faaj_m.faaj025) THEN 
                     IF g_para_data1 = '1' THEN    #依部門
                        IF g_faaj_m.faaj006 = '1' THEN   #單一部門
                           SELECT faae003 INTO g_faaj_m.faaj025
                             FROM faae_t
                            WHERE faaeent = g_enterprise
                              AND faaeld = g_faaj_m.faajld
                              AND faae001 = g_faaj_m.faaj007
                              AND faae002 = g_faah_m.faah006
                        END IF
                        IF g_faaj_m.faaj006 = '2' THEN   #多部門
                           LET g_faaj_m.faaj025 = ''
                        END IF 
                        DISPLAY g_faaj_m.faaj025 TO faaj025
                        CALL afai100_depreciation_ref()   
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                  CALL afai100_depreciation_ref()
                  NEXT FIELD CURRENT
               END IF
         

            END IF   
         END IF
         
         IF g_faaj_m.faaj006 = '2' THEN 
            CALL afai100_depreciation_ref()
            IF NOT cl_null(g_faaj_m.faaj007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faaj_m.faajld
               LET g_chkparam.arg2 = g_faaj_m.faaj007
			   
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faaf003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
			   
               ELSE
                  #檢查失敗時後續處理
                  LET g_faaj_m.faaj007 = g_faaj_m_t.faaj007
                  CALL afai100_depreciation_ref()
                  NEXT FIELD CURRENT
               END IF
         

            END IF   
         END IF
      
     
      AFTER FIELD faaj004    
         IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_faaj_m.faaj004 != g_faaj_m_t.faaj004 OR cl_null(g_faaj_m_t.faaj004))) THEN      
            IF NOT cl_null(g_faaj_m.faaj004) THEN 
               IF g_faaj_m.faaj004 < g_faaj_m.faaj005 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00030'
                  LET g_errparam.extend = g_faaj_m.faaj004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_faaj_m.faaj004 = g_faaj_m_t.faaj004
                  NEXT FIELD faaj004
               END IF
            END IF 
            LET g_faaj_m.faaj005 = g_faaj_m.faaj004
            DISPLAY g_faaj_m.faaj005 TO faaj005
            
            IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
               IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
                  IF g_faaj_m.faaj022 <= 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00192'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     NEXT FIELD faaj022
                  END IF
               END IF
            END IF
         END IF
      
      AFTER FIELD faaj005     
         IF NOT cl_null(g_faaj_m.faaj005) THEN 
            IF g_faaj_m.faaj005 > g_faaj_m.faaj004 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00031'
               LET g_errparam.extend = g_faaj_m.faaj005
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_faaj_m.faaj005 = g_faaj_m_t.faaj005
               NEXT FIELD faaj005
            END IF
         END IF
         
      AFTER FIELD faaj008   
         IF NOT cl_null(g_faaj_m.faaj008) THEN 
            LET l_str = g_faaj_m.faaj008
            IF l_str.getLength() != 6 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00309'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF 
            LET l_month = l_str.subString(5,6)
            IF l_month > 12 OR l_month < 1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00309'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF
            IF NOT cl_null(g_faaj_m.faaj009) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               IF g_faaj_m.faaj009 < l_year THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00312'
                  LET g_errparam.extend = g_faaj_m.faaj008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
                  NEXT FIELD faaj008
               END IF
               IF NOT cl_null(g_faaj_m.faaj010) THEN
                  LET l_month = g_faaj_m.faaj008[5,6]
                  IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00313'
                     LET g_errparam.extend = g_faaj_m.faaj008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
                     NEXT FIELD faaj008
                  END IF
               END IF  
            END IF 
            LET l_year = YEAR(g_faah_m.faah014)
            LET l_month = MONTH(g_faah_m.faah014)
            LET l_str1 = l_year
            LET l_str2 = l_month
            IF l_month < 10 THEN
               LET l_str3 = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
            ELSE
               LET l_str3 = l_str1 CLIPPED,l_str2 CLIPPED
            END IF        
            IF l_str < l_str3 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00322'
               LET g_errparam.extend = g_faaj_m.faaj008
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj008 = g_faaj_m_t.faaj008
               NEXT FIELD faaj008
            END IF 
         END IF
         
      AFTER FIELD faaj009
         IF NOT cl_null(g_faaj_m.faaj009) THEN 
            LET l_str = g_faaj_m.faaj009
            IF l_str.getLength() != 4 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00310'
               LET g_errparam.extend = g_faaj_m.faaj009
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
               NEXT FIELD faaj009
            END IF 
            IF NOT cl_null(g_faaj_m.faaj008) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               IF g_faaj_m.faaj009 < l_year THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00312'
                  LET g_errparam.extend = g_faaj_m.faaj009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
                  NEXT FIELD faaj009
               END IF
               IF NOT cl_null(g_faaj_m.faaj010) THEN
                  LET l_month = g_faaj_m.faaj008[5,6]
                  IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00313'
                     LET g_errparam.extend = g_faaj_m.faaj009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faaj_m.faaj009 = g_faaj_m_t.faaj009
                     NEXT FIELD faaj009
                  END IF
               END IF 
            END IF                
         END IF
         
      AFTER FIELD faaj010
         IF NOT cl_null(g_faaj_m.faaj010) THEN 
            LET l_str = g_faaj_m.faaj010
            IF l_str.getLength() > 2 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00311'
               LET g_errparam.extend = g_faaj_m.faaj010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
               NEXT FIELD faaj010
            END IF
            IF g_faaj_m.faaj010 < 1 OR g_faaj_m.faaj010 > 12 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00314'
               LET g_errparam.extend = g_faaj_m.faaj010
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
               NEXT FIELD faaj010
            END IF 
            IF NOT cl_null(g_faaj_m.faaj008) AND NOT cl_null(g_faaj_m.faaj009) THEN 
               LET l_year = g_faaj_m.faaj008[1,4]
               LET l_month = g_faaj_m.faaj008[5,6]
               IF g_faaj_m.faaj009 = l_year  AND g_faaj_m.faaj010 < l_month THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00313'
                  LET g_errparam.extend = g_faaj_m.faaj010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faaj_m.faaj010 = g_faaj_m_t.faaj010
                  NEXT FIELD faaj010
               END IF
            END IF                
         END IF

      
      
      AFTER FIELD faaj014
         IF NOT cl_null(g_faaj_m.faaj014) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj014
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_ooai001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               IF NOT cl_null(g_glaa001_1) AND NOT cl_null(g_glaa025_1) THEN 
                  CALL afai100_get_exrate(g_faaj_m.faajld,g_faaj_m.faaj014,g_glaa001_1,g_glaa025_1) 
               END IF
               LET g_faaj_m.faaj015 = g_ooan005
               DISPLAY g_faaj_m.faaj015 TO faaj015
            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj014 = g_faaj_m_t.faaj014
               NEXT FIELD CURRENT
            END IF
          

         END IF 

      AFTER FIELD faaj015
         IF NOT cl_null(g_faaj_m.faaj015) AND g_faaj_m.faaj015 <> g_faaj_m_t.faaj015 THEN 
            LET g_faaj_m.faaj016 = g_faaj_m.faaj015 * g_faah_m.faah022
         END IF
         
      AFTER FIELD faaj016
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj019) THEN 
            IF g_faaj_m.faaj016 < g_faaj_m.faaj019 THEN 
               LET g_faaj_m.faaj016 = g_faaj_m_t.faaj016
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00099'
               LET g_errparam.extend = g_faaj_m.faaj016
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD faaj016
            END IF
         END IF
         
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj017) THEN 
            ##############################mark by huangtao
            #IF g_faaj_m.faaj016 <> g_faaj_m_t.faaj016 OR cl_null(g_faaj_m_t.faaj016) THEN 
            #   LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
            #   DISPLAY g_faaj_m.faaj028 TO faaj028
            #END IF
            IF g_faaj_m.faaj016 <> g_faaj_m_o.faaj016 OR cl_null(g_faaj_m_o.faaj016) THEN 
               LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
               DISPLAY g_faaj_m.faaj028 TO faaj028
            END IF
            ##############################mark by huangtao
         END IF
         LET g_faaj_m_o.faaj016 = g_faaj_m.faaj016
         
      AFTER FIELD faaj017
         IF NOT cl_null(g_faaj_m.faaj017) AND (g_faaj_m.faaj017 <> g_faaj_m_t.faaj017 OR cl_null(g_faaj_m_t.faaj017)) THEN 
            IF g_glaa015 = 'Y' THEN    
               #-----本位币二-------
               LET g_faaj_m.faaj104 = g_faaj_m.faaj017 * g_faaj_m.faaj102
            
               DISPLAY g_faaj_m.faaj104 TO faaj104
            END IF
            IF g_glaa019 = 'Y' THEN      
               #-----本位币三-------
               LET g_faaj_m.faaj154 = g_faaj_m.faaj017 * g_faaj_m.faaj152
            
               DISPLAY g_faaj_m.faaj154 TO faaj154
            END IF
         END IF
         
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj017) THEN 
            IF g_faaj_m.faaj017 <> g_faaj_m_t.faaj017 OR cl_null(g_faaj_m_t.faaj017) THEN 
               LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
               DISPLAY g_faaj_m.faaj028 TO faaj028
               IF g_glaa015 = 'Y' THEN    
                  #-----本位币二-------
                  LET g_faaj_m.faaj108 = g_faaj_m.faaj028 * g_faaj_m.faaj102
               
                  DISPLAY g_faaj_m.faaj108 TO faaj108
               END IF
               IF g_glaa019 = 'Y' THEN      
                  #-----本位币三-------
                  LET g_faaj_m.faaj158 = g_faaj_m.faaj028 * g_faaj_m.faaj152
               
                  DISPLAY g_faaj_m.faaj158 TO faaj158
               END IF  
            END IF
         END IF
         
      AFTER FIELD faaj018
         IF NOT cl_null(g_faaj_m.faaj018) AND (g_faaj_m.faaj018 <> g_faaj_m_t.faaj018 OR cl_null(g_faaj_m_t.faaj018)) THEN 
            IF g_glaa015 = 'Y' THEN    
               #-----本位币二-------
               LET g_faaj_m.faaj111 = g_faaj_m.faaj018 * g_faaj_m.faaj102
            
               DISPLAY g_faaj_m.faaj111 TO faaj111
            END IF
            IF g_glaa019 = 'Y' THEN      
               #-----本位币三-------
               LET g_faaj_m.faaj161 = g_faaj_m.faaj018 * g_faaj_m.faaj152
            
               DISPLAY g_faaj_m.faaj161 TO faaj161
            END IF
         END IF
         
      AFTER FIELD faaj019
         IF NOT cl_null(g_faaj_m.faaj016) AND NOT cl_null(g_faaj_m.faaj019) THEN 
            IF g_faaj_m.faaj019 > g_faaj_m.faaj016 THEN 
               LET g_faaj_m.faaj019 = g_faaj_m_t.faaj019
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00100'
               LET g_errparam.extend = g_faaj_m.faaj019
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD faaj019
            END IF
         END IF
         
      AFTER FIELD faaj022
          ############################add by huangtao
         IF NOT cl_ap_chk_range(g_faaj_m.faaj022,"0","1","","","azz-00079",1) THEN
             NEXT FIELD faaj022
         END IF 
          ############################add by huangtao
         IF NOT cl_null(g_faaj_m.faaj003) AND NOT cl_null(g_faaj_m.faaj004) THEN 
            IF g_faaj_m.faaj003 = '2' AND g_faaj_m.faaj004 < 24 THEN 
               IF g_faaj_m.faaj022 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00192'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD faaj022
               END IF
            END IF
         END IF
         
      ON CHANGE faaj011
         IF g_faaj_m.faaj011 = 'Y' THEN 
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
         ELSE
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
            LET g_faaj_m.faaj012 = ''  #160826-00013#1 
            LET g_faaj_m.faaj013 = ''  #160826-00013#1              
         END IF
      
      #########################add by huangtao
      AFTER FIELD faaj013  #faaj011预留年月不可为0
         IF g_faaj_m.faaj011 = 'Y'  THEN
            IF NOT cl_null(g_faaj_m.faaj013) THEN
               IF g_faaj_m.faaj013 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00381'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD faaj013
               END IF       
            END IF        
         END IF
      
     AFTER FIELD faaj012
        IF g_faaj_m.faaj011 = 'Y'  THEN 
           IF cl_null(g_faaj_m.faaj012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00382'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj012 
            END IF        
         END IF
     
     AFTER FIELD faaj106
     
     
     AFTER FIELD faaj156
      #########################add by huangtao
      
      
      AFTER FIELD faaj042
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj042) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj042
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pmaa001_2") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj042 = g_faaj_m_t.faaj042
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF
         
      AFTER FIELD faaj043
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj043) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj043
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pmaa001_2") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj043 = g_faaj_m_t.faaj043
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  

      AFTER FIELD faaj045
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj045) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj045
            #160318-00025#4--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
            #160318-00025#4--add--end
               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pjba001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj045 = g_faaj_m_t.faaj045
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  
         
      AFTER FIELD faaj046
         CALL afai100_depreciation_ref()
         IF NOT cl_null(g_faaj_m.faaj046) THEN 
#此段落由子樣板a19產生
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_faaj_m.faaj045
            LET g_chkparam.arg2 = g_faaj_m.faaj046

               
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_pjbb002") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 

            ELSE
               #檢查失敗時後續處理
               LET g_faaj_m.faaj046 = g_faaj_m_t.faaj046
               CALL afai100_depreciation_ref()
               NEXT FIELD CURRENT
            END IF         
         END IF  
         
         
      AFTER FIELD faaj102
         IF NOT cl_null(g_faaj_m.faaj102) OR (p_cmd = 'u' AND g_faaj_m.faaj102 <> g_faaj_m_t.faaj102) THEN 
            LET g_faaj_m.faaj103 = g_faaj_m.faaj102 * g_faah_m.faah022
         END IF
         
      AFTER FIELD faaj152
         IF NOT cl_null(g_faaj_m.faaj152) OR (p_cmd = 'u' AND g_faaj_m.faaj152 <> g_faaj_m_t.faaj152) THEN 
            LET g_faaj_m.faaj153 = g_faaj_m.faaj152 * g_faah_m.faah022
         END IF
         
         
      
      ON ACTION controlp INFIELD faajld
            #add-point:ON ACTION controlp INFIELD glabld
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faajld             #給予default值
            LET g_qryparam.where  = " glaacomp in (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                    " AND ooef001 = '",g_faah_m.faah028,"')"
            #給予arg

            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_faaj_m.faajld = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_glab_m.glaald = g_qryparam.return2 #帳別編號

            DISPLAY g_faaj_m.faajld TO faajld              #顯示到畫面上
            #DISPLAY g_glab_m.glaald TO glaald #帳別編號
            CALL afai100_faajld_desc()
            NEXT FIELD faajld                          #返回原欄位

      
      ON ACTION controlp INFIELD faajsite
            #add-point:ON ACTION controlp INFIELD faah028
#此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str #161111-00049#5 add   
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faajsite             #給予default值
#            LET g_qryparam.where = " faab004 = '",g_site,"'"
            #給予arg

#            CALL q_faab001()                                #呼叫開窗
            #CALL q_ooef001()   #161024-00008#1
            #161111-00049#5 add s---
            LET g_qryparam.where = l_comp_str 
            IF NOT cl_null(g_faaj_m.faajld) THEN 
               LET g_qryparam.where =g_qryparam.where," AND ", l_comp_str," AND ooef017 IN(SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_faaj_m.faajld ,"'  )"  
            END IF
            #161111-00049#5 add e---
            CALL q_ooef001_12() #161024-00008#1
            LET g_faaj_m.faajsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faajsite TO faajsite              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faajsite                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj023
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj023             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj023 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj023 TO faaj023              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj023                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj024
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj024             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj024 TO faaj024              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj024                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj025
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj025             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                 " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj025 TO faaj025              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj025                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj026
            #add-point:ON ACTION controlp INFIELD glab005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj026             #給予default值
            LET g_qryparam.where = " glac001 = '",g_faaj_m.glaa004,"' AND glac003 <> '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faaj_m.faajld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_faaj_m.faaj026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj026 TO faaj026              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj026                          #返回原欄位
            
      
      ON ACTION controlp INFIELD faaj007
            #add-point:ON ACTION controlp INFIELD faag005
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj007             #給予default值
            IF g_faaj_m.faaj006 = '1' THEN 
               #給予arg
               LET g_qryparam.arg1 = g_today
               IF cl_null(g_faaj_m.faajld) THEN  #161111-00049#5 add
                  ########################################add by huangtao
                  LET g_qryparam.where = "ooeg009 = '",g_faah_m.faah032,"'"
                  ########################################add by huangtao
               #161111-00049#5 add s---  
               ELSE
                  SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_faaj_m.faajld
                  LET g_qryparam.where = "ooeg009 = '",l_glaacomp,"'"
               END IF               
               #161111-00049#5 add e---
               
               CALL q_ooeg001_4()                                #呼叫開窗
            END IF
            IF g_faaj_m.faaj006 = '2' THEN
               #給予arg
               LET g_qryparam.arg1 = g_faaj_m.faajld

               CALL q_faaf003()                                #呼叫開窗
            END IF

            LET g_faaj_m.faaj007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj007 TO faaj007              #顯示到畫面上

            CALL afai100_depreciation_ref()

            NEXT FIELD faaj007                          #返回原欄位
      
      
      ON ACTION controlp INFIELD faaj014
            #add-point:ON ACTION controlp INFIELD faaj014
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj014             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_faaj_m.faaj014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj014 TO faaj014              #顯示到畫面上
            NEXT FIELD faaj014                          #返回原欄位
            
            
      ON ACTION controlp INFIELD faaj042
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj042             #給予default值
            LET g_qryparam.where = " pmaastus = 'Y'"
            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faaj_m.faaj042 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj042 TO faaj042              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj042                          #返回原欄位
      
      ON ACTION controlp INFIELD faaj043
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj043             #給予default值
            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faaj_m.faaj043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj043 TO faaj043              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj043                          #返回原欄位
            
       ON ACTION controlp INFIELD faaj045
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj045             #給予default值
            #給予arg

            CALL q_pjba001()                                #呼叫開窗

            LET g_faaj_m.faaj045 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj045 TO faaj045              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj045                          #返回原欄位
            
       ON ACTION controlp INFIELD faaj046
            #add-point:ON ACTION controlp INFIELD faah009
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faaj_m.faaj046             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_faaj_m.faaj045

            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_faaj_m.faaj046 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faaj_m.faaj046 TO faaj046              #顯示到畫面上
            CALL afai100_depreciation_ref()
            NEXT FIELD faaj046                          #返回原欄位
         
      BEFORE INPUT
         IF p_cmd = 'a' THEN 
            LET g_faaj_m.faaj000 = g_faah_m.faah000
            LET g_faaj_m.faaj001 = g_faah_m.faah003
            LET g_faaj_m.faaj002 = g_faah_m.faah004
            LET g_faaj_m.faaj037 = g_faah_m.faah001
            LET g_faaj_m.faajsite = g_faah_m.faah028
            SELECT faac003,faac004,faac005,faac006 
              INTO g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj011,g_faaj_m.faaj013
              FROM faac_t
             WHERE faacent = g_enterprise
               AND faac001 = g_faah_m.faah006
               AND faacstus = 'Y'
            LET g_faaj_m.faaj005 = g_faaj_m.faaj004
            LET g_faaj_m.faaj011 = 'Y'
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
            LET g_faaj_m.faaj042 = g_faah_m.faah009
            LET g_faaj_m.faaj038 = g_faah_m.faah015
            LET g_faaj_m.faaj016 = 0
            LET g_faaj_m.faaj017 = 0
            LET g_faaj_m.faaj018 = 0
            LET g_faaj_m.faaj019 = 0
            LET g_faaj_m.faaj020 = 0
            LET g_faaj_m.faaj022 = 0
            LET g_faaj_m.faaj033 = 0
            LET g_faaj_m.faaj034 = 0
            LET g_faaj_m.faaj035 = 0
            LET g_faaj_m.faaj032 = 0
            LET g_faaj_m.faaj027 = 0
            LET g_faaj_m.faaj021 = 0
            LET g_faaj_m.faaj029 = 0
            LET g_faaj_m.faaj028 = 0
            
            
            LET g_faaj_m.faaj103 = 0
            LET g_faaj_m.faaj104 = 0
            LET g_faaj_m.faaj111 = 0
            LET g_faaj_m.faaj105 = 0
            LET g_faaj_m.faaj117 = 0
            LET g_faaj_m.faaj107 = 0
            LET g_faaj_m.faaj109 = 0
            LET g_faaj_m.faaj108 = 0
            LET g_faaj_m.faaj113 = 0
            LET g_faaj_m.faaj114 = 0
            LET g_faaj_m.faaj115 = 0
            LET g_faaj_m.faaj110 = 0
            LET g_faaj_m.faaj112 = 0
            
            
            LET g_faaj_m.faaj153 = 0
            LET g_faaj_m.faaj154 = 0
            LET g_faaj_m.faaj161 = 0
            LET g_faaj_m.faaj155 = 0
            LET g_faaj_m.faaj167 = 0
            LET g_faaj_m.faaj157 = 0
            LET g_faaj_m.faaj159 = 0
            LET g_faaj_m.faaj158 = 0
            LET g_faaj_m.faaj163 = 0
            LET g_faaj_m.faaj164 = 0
            LET g_faaj_m.faaj165 = 0
            LET g_faaj_m.faaj160 = 0
            LET g_faaj_m.faaj162 = 0
            LET g_faaj_m.faaj048 = '2'  #160426-00014#8
            
            DISPLAY g_faaj_m.faajsite TO faajsite
            DISPLAY g_faaj_m.faaj042 TO faaj042
            DISPLAY g_faaj_m.faaj003 TO faaj003
            DISPLAY g_faaj_m.faaj004 TO faaj004
            DISPLAY g_faaj_m.faaj038 TO faaj038
            DISPLAY g_faaj_m.faaj016 TO faaj016
            DISPLAY g_faaj_m.faaj017 TO faaj017
            DISPLAY g_faaj_m.faaj107 TO faaj107
            DISPLAY g_faaj_m.faaj109 TO faaj109
            DISPLAY g_faaj_m.faaj108 TO faaj108
            DISPLAY g_faaj_m.faaj018 TO faaj018
            DISPLAY g_faaj_m.faaj019 TO faaj019
            DISPLAY g_faaj_m.faaj020 TO faaj020
            DISPLAY g_faaj_m.faaj022 TO faaj022
            DISPLAY g_faaj_m.faaj033 TO faaj033
            DISPLAY g_faaj_m.faaj034 TO faaj034
            DISPLAY g_faaj_m.faaj035 TO faaj035
            DISPLAY g_faaj_m.faaj032 TO faaj032
            DISPLAY g_faaj_m.faaj027 TO faaj027
            DISPLAY g_faaj_m.faaj021 TO faaj021
            DISPLAY g_faaj_m.faaj029 TO faaj029
            DISPLAY g_faaj_m.faaj028 TO faaj028
            
            DISPLAY g_faaj_m.faaj103 TO faaj103
            DISPLAY g_faaj_m.faaj104 TO faaj104
            DISPLAY g_faaj_m.faaj111 TO faaj111
            DISPLAY g_faaj_m.faaj105 TO faaj105
            DISPLAY g_faaj_m.faaj117 TO faaj117
            DISPLAY g_faaj_m.faaj113 TO faaj113
            DISPLAY g_faaj_m.faaj114 TO faaj114
            DISPLAY g_faaj_m.faaj115 TO faaj115
            DISPLAY g_faaj_m.faaj110 TO faaj110
            DISPLAY g_faaj_m.faaj112 TO faaj112
            
            DISPLAY g_faaj_m.faaj153 TO faaj153
            DISPLAY g_faaj_m.faaj154 TO faaj154
            DISPLAY g_faaj_m.faaj161 TO faaj161
            DISPLAY g_faaj_m.faaj155 TO faaj155
            DISPLAY g_faaj_m.faaj167 TO faaj167
            DISPLAY g_faaj_m.faaj157 TO faaj157
            DISPLAY g_faaj_m.faaj159 TO faaj159
            DISPLAY g_faaj_m.faaj158 TO faaj158
            DISPLAY g_faaj_m.faaj163 TO faaj163
            DISPLAY g_faaj_m.faaj164 TO faaj164
            DISPLAY g_faaj_m.faaj165 TO faaj165
            DISPLAY g_faaj_m.faaj160 TO faaj160
            DISPLAY g_faaj_m.faaj162 TO faaj162
            DISPLAY g_faaj_m.faaj048 TO faaj048 #160426-00014#8
            CALL afai100_depreciation_ref()
         END IF
         IF g_faaj_m.faaj011 = 'Y' THEN 
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",TRUE)
         ELSE
            LET g_faaj_m.faaj012 = ''
            LET g_faaj_m.faaj013 = ''
            LET g_faaj_m.faaj106 = ''
            LET g_faaj_m.faaj156 = ''
            DISPLAY BY NAME g_faaj_m.faaj012,g_faaj_m.faaj013,g_faaj_m.faaj106,g_faaj_m.faaj156
            CALL afai100_set_comp_entry("faaj012,faaj013,faaj106,faaj156",FALSE)
         END IF
         
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
          #########################add by huangtao
         #faaj011预留年月不可为0
         IF g_faaj_m.faaj011 = 'Y'  THEN
            IF cl_null(g_faaj_m.faaj013) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00381'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj013
            END IF   
            IF cl_null(g_faaj_m.faaj012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00382'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faaj012
            END IF 
         END IF
     
      #########################add by huangtao
         
         CALL s_transaction_begin()
         
         IF p_cmd = 'a' THEN 
            CALL afai100_faaj_ins()
         ELSE
            CALL afai100_faaj_upd()
         END IF

         RETURN
 
      ON ACTION accept
         ACCEPT INPUT

 
      ON ACTION cancel
         LET INT_FLAG = 1
         RETURN 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT

      
   END INPUT
END FUNCTION
# 資料填充
PRIVATE FUNCTION afai100_browser_fill1(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   {</Local define>}
   #add-point:browser_fill段define

   #end add-point
   
  #CLEAR FORM
   INITIALIZE g_faaj_m.* TO NULL
   #INITIALIZE g_wc TO NULL
   CALL g_browser1.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "faajld"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET g_wc3 = g_wc3.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(g_wc3) THEN  #p_wc 查詢條件
      LET g_wc3 = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制

   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM faaj_t ",
               "  ",
               "  ",
               " WHERE faajent = '" ||g_enterprise|| "' AND ", 
               g_wc3 CLIPPED,
               "   AND faaj000 = '",g_faah_m.faah000,"'",
               "   AND faaj001 = '",g_faah_m.faah003,"'",
               "   AND faaj002 = '",g_faah_m.faah004,"'",
               "   AND faaj037 = '",g_faah_m.faah001,"'"
                
   #add-point:browser_fill段cnt_sql

   #end add-point
				
   PREPARE header_cnt_pre1 FROM g_sql
   EXECUTE header_cnt_pre1 INTO g_browser_cnt1
   FREE header_cnt_pre1
   
   #IF g_browser_cnt1 = 0 THEN 
   #   RETURN
   #END IF
   
   #若超過最大顯示筆數
   
   DISPLAY g_browser_cnt1 TO FORMONLY.b_count1
   DISPLAY g_browser_cnt1 TO FORMONLY.h_count1
   DISPLAY g_browser_cnt1 TO FORMONLY.b_count2
   DISPLAY g_browser_cnt1 TO FORMONLY.h_count2
   
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action1 = ps_page_action
   END IF
 
   CASE ps_page_action
      
      WHEN "F" 
         LET g_pagestart1 = 1
      
      WHEN "P"  
         LET g_pagestart1 = g_pagestart1 - g_max_browse
         IF g_pagestart1 < 1 THEN
            LET g_pagestart1 = 1
         END IF
      
      WHEN "N"  
         LET g_pagestart1 = g_pagestart1 + g_max_browse
         IF g_pagestart1 > g_browser_cnt THEN
            LET g_pagestart1 = g_browser_cnt1 - (g_browser_cnt1 mod g_max_browse) + 1
            WHILE g_pagestart1 > g_browser_cnt1 
               LET g_pagestart1 = g_pagestart1 - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart1 = g_browser_cnt1 - (g_browser_cnt1 mod g_max_browse) + 1
         WHILE g_pagestart1 > g_browser_cnt1 
            LET g_pagestart1 = g_pagestart1 - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart1 = g_jump1
         IF g_pagestart1 > g_browser_cnt1 THEN
            LET g_pagestart1 = 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump1
            LET g_errparam.popup = FALSE
            CALL cl_err()

         END IF
         
      OTHERWISE
         
   END CASE
   
   LET l_sql_rank = "SELECT faajstus,faajld,faaj000,faaj001,faaj002,faaj037,RANK() OVER(ORDER BY faajld ",
                    ",faaj001 ",
                    ",faaj002 ",
 
                    g_order,
                    ") AS RANK ",
                    " FROM faaj_t ",
                    "  ",
                    "  ",
                    " WHERE faajent = '" ||g_enterprise|| "' AND ", g_wc3,
                    "   AND faaj000 = '",g_faah_m.faah000,"'",
                    "   AND faaj001 = '",g_faah_m.faah003,"'",
                    "   AND faaj002 = '",g_faah_m.faah004,"'",
                    "   AND faaj037 = '",g_faah_m.faah001,"'"
 
   #add-point:browser_fill段before_pre

   #end add-point					
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT faajstus,faajld,faaj000,faaj001,faaj002,faaj037 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart1,
              "    AND RANK <  ", (g_pagestart1 + g_max_browse) , 
              "  ORDER BY ",l_searchcol," ",g_order
 
   PREPARE browse_pre1 FROM g_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1
 
   CALL g_browser1.clear()
   LET g_cnt = 1
   FOREACH browse_cur1 INTO g_browser1[g_cnt].b_statepic,g_browser1[g_cnt].b_faajld,g_browser1[g_cnt].b_faaj000, 
       g_browser1[g_cnt].b_faaj001,g_browser1[g_cnt].b_faaj002,g_browser1[g_cnt].b_faaj037
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point
      
      LET g_browser1[g_cnt].b_statepic = cl_get_actipic(g_browser1[g_cnt].b_statepic)
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser1.deleteElement(g_cnt)
   LET g_header_cnt1 = g_browser_cnt1
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt1 = g_browser_cnt1
   LET g_cnt = 0
   
   
   FREE browse_pre1
 
   
END FUNCTION
############################################################
#+ @code
#+ 函式目的  設定ToolBar上瀏覽上下筆資料的按鈕狀態.
#+ @param    pi_curr_index  NUMBER(10)  目前Cursor索引值
#+ @param    pi_row_count   NUMBER(10)  資料筆數
############################################################
PRIVATE FUNCTION afai100_navigator_setting(pi_curr_index,pi_row_count)
   DEFINE pi_curr_index   LIKE type_t.num10
   DEFINE pi_row_count    LIKE type_t.num10
   DEFINE li_cnt          LIKE type_t.num5
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE lnode_button    om.DomNode
   DEFINE ls_btn_name     STRING
   DEFINE ls_btn_hidden   STRING
   DEFINE lnode_frm       om.DomNode
   DEFINE ls_formName     STRING
   DEFINE ls_btn_unhidden STRING
   DEFINE ls_act_visible_list_true  STRING #要顯示的action list
   DEFINE ls_act_visible_list_false STRING #要隱藏的action list

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN
      RETURN
   END IF

   #一開始預設為全部顯現.
   CALL cl_navigator_reset_local_action("first1,previous1,jump1,next1,last1", TRUE)
   CALL cl_navigator_reset_local_action("first2,previous2,jump2,next2,last2", TRUE)
   CASE
      WHEN pi_row_count <= 1
         CALL cl_navigator_reset_local_action("first1,previous1,jump1,next1,last1", FALSE)
         CALL cl_navigator_reset_local_action("first2,previous2,jump2,next2,last2", FALSE)
      WHEN pi_row_count > 1 AND pi_curr_index = 1
         CALL cl_navigator_reset_local_action("first1,previous1", FALSE)
         CALL cl_navigator_reset_local_action("first2,previous2", FALSE)
      WHEN pi_row_count > 1 AND pi_curr_index = pi_row_count
         CALL cl_navigator_reset_local_action("next1,last1", FALSE)
         CALL cl_navigator_reset_local_action("next2,last2", FALSE)
   END CASE

   # 根據g_act_visible再重跑一次cl_set_act_visible確保有效
   LET gs_act_visible_on = "N"  #此次呼叫cl_set_act_visible並不需要維護g_act_visible,所以將gs_act_visible_on設為N
   LET ls_act_visible_list_true = ''
   LET ls_act_visible_list_false = ''
   FOR li_cnt = 1 TO g_act_visible.getLength()
       IF g_act_visible[li_cnt].value = TRUE THEN
          IF cl_null(ls_act_visible_list_true) THEN
             LET ls_act_visible_list_true = g_act_visible[li_cnt].name
          ELSE
             LET ls_act_visible_list_true = ls_act_visible_list_true || "," || g_act_visible[li_cnt].name
          END IF
       ELSE
          IF cl_null(ls_act_visible_list_false) THEN
             LET ls_act_visible_list_false = g_act_visible[li_cnt].name
          ELSE
             LET ls_act_visible_list_false = ls_act_visible_list_false || "," || g_act_visible[li_cnt].name
          END IF
       END IF
   END FOR
   CALL cl_set_act_visible(ls_act_visible_list_true,TRUE)
   CALL cl_set_act_visible(ls_act_visible_list_false,FALSE)
   LET gs_act_visible_on = "Y"   #將gs_act_visible_on設為Y,讓之後程式若呼叫cl_set_act_visible時自動維護g_act_visible
END FUNCTION
# 修改faaj_t固定資產帳套折舊明細資料檔
PRIVATE FUNCTION afai100_faaj_upd()
   UPDATE faaj_t SET (faajld ,faaj000,faaj001,faaj002,    
                      faaj037,faaj006,faaj007,      
                      faaj023,faaj024,faaj025,faaj026,
                      faaj003,faaj004,faaj005,faaj038,
                      faaj008,faaj009,faaj010,faaj014,
                      faaj015,faaj016,faaj017,faaj018,
                      faaj019,faaj020,faaj022,faaj033,
                      faaj034,faaj035,faaj032,faaj027,
                      faaj021,faaj029,faaj028,faaj011,faaj013,faaj012,
                      faaj106,faaj156,faaj042,faaj043,
                      faaj045,faaj046,faaj030,faajsite,
                      faaj101,faaj102,faaj103,faaj104,
                      faaj111,faaj105,faaj117,faaj107,faaj109,faaj108,
                      faaj113,faaj114,faaj115,faaj110,
                      faaj112,faaj151,faaj152,faaj153,
                      faaj154,faaj161,faaj155,faaj167,faaj157,
                      faaj159,faaj158,faaj163,faaj164,faaj165,
                      faaj160,faaj162,faaj048) #160426-00014#8 add faaj048
                      = (g_faaj_m.faajld  ,g_faaj_m.faaj000,g_faaj_m.faaj001,g_faaj_m.faaj002,    
                      g_faaj_m.faaj037,g_faaj_m.faaj006,g_faaj_m.faaj007,      
                      g_faaj_m.faaj023,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
                      g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
                      g_faaj_m.faaj008,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
                      g_faaj_m.faaj015,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
                      g_faaj_m.faaj019,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
                      g_faaj_m.faaj034,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
                      g_faaj_m.faaj021,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
                      g_faaj_m.faaj106,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
                      g_faaj_m.faaj045,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
                      g_faaj_m.faaj101,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
                      g_faaj_m.faaj111,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
                      g_faaj_m.faaj113,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
                      g_faaj_m.faaj112,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
                      g_faaj_m.faaj154,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
                      g_faaj_m.faaj159,g_faaj_m.faaj158,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
                      g_faaj_m.faaj160,g_faaj_m.faaj162,
                      g_faaj_m.faaj048) #160426-00014#8 add faaj048
                WHERE faajent = g_enterprise AND faajld = g_faaj_m_t.faajld
                  AND faaj000 = g_faaj_m.faaj000
                  AND faaj001 = g_faaj_m.faaj001
                  AND faaj002 = g_faaj_m.faaj002 
                  AND faaj037 = g_faaj_m.faaj037                  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE error!'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF 
END FUNCTION
# 插入faaj_t固定資產帳套折舊明細資料檔
PRIVATE FUNCTION afai100_faaj_ins()
   
   LET g_faajld_t = NULL
   
   INSERT INTO faaj_t(faajent,faajld ,faaj000,faaj001,    
                      faaj002,faaj037,faaj006,faaj007,      
                      faaj023,faaj024,faaj025,faaj026,
                      faaj003,faaj004,faaj005,faaj038,
                      faaj008,faaj009,faaj010,faaj014,
                      faaj015,faaj016,faaj017,faaj018,
                      faaj019,faaj020,faaj022,faaj033,
                      faaj034,faaj035,faaj032,faaj027,
                      faaj021,faaj029,faaj028,faaj011,faaj013,faaj012,
                      faaj106,faaj156,faaj042,faaj043,
                      faaj045,faaj046,faaj030,faajsite,
                      faaj101,faaj102,faaj103,faaj104,
                      faaj111,faaj105,faaj117,faaj107,faaj109,faaj108,
                      faaj113,faaj114,faaj115,faaj110,
                      faaj112,faaj151,faaj152,faaj153,
                      faaj154,faaj161,faaj155,faaj167,faaj157,
                      faaj159,faaj158,faaj163,faaj164,faaj165,
                      faaj160,faaj162,
                      faaj048 ) #160426-00014#8 add faaj048
   VALUES (g_enterprise,    g_faaj_m.faajld ,g_faaj_m.faaj000,g_faaj_m.faaj001,    
           g_faaj_m.faaj002,g_faaj_m.faaj037,g_faaj_m.faaj006,g_faaj_m.faaj007,      
           g_faaj_m.faaj023,g_faaj_m.faaj024,g_faaj_m.faaj025,g_faaj_m.faaj026,
           g_faaj_m.faaj003,g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj038,
           g_faaj_m.faaj008,g_faaj_m.faaj009,g_faaj_m.faaj010,g_faaj_m.faaj014,
           g_faaj_m.faaj015,g_faaj_m.faaj016,g_faaj_m.faaj017,g_faaj_m.faaj018,
           g_faaj_m.faaj019,g_faaj_m.faaj020,g_faaj_m.faaj022,g_faaj_m.faaj033,
           g_faaj_m.faaj034,g_faaj_m.faaj035,g_faaj_m.faaj032,g_faaj_m.faaj027,
           g_faaj_m.faaj021,g_faaj_m.faaj029,g_faaj_m.faaj028,g_faaj_m.faaj011,g_faaj_m.faaj013,g_faaj_m.faaj012,
           g_faaj_m.faaj106,g_faaj_m.faaj156,g_faaj_m.faaj042,g_faaj_m.faaj043,
           g_faaj_m.faaj045,g_faaj_m.faaj046,g_faaj_m.faaj030,g_faaj_m.faajsite,
           g_faaj_m.faaj101,g_faaj_m.faaj102,g_faaj_m.faaj103,g_faaj_m.faaj104,
           g_faaj_m.faaj111,g_faaj_m.faaj105,g_faaj_m.faaj117,g_faaj_m.faaj107,g_faaj_m.faaj109,g_faaj_m.faaj108,
           g_faaj_m.faaj113,g_faaj_m.faaj114,g_faaj_m.faaj115,g_faaj_m.faaj110,
           g_faaj_m.faaj112,g_faaj_m.faaj151,g_faaj_m.faaj152,g_faaj_m.faaj153,
           g_faaj_m.faaj154,g_faaj_m.faaj161,g_faaj_m.faaj155,g_faaj_m.faaj167,g_faaj_m.faaj157,
           g_faaj_m.faaj159,g_faaj_m.faaj158,g_faaj_m.faaj163,g_faaj_m.faaj164,g_faaj_m.faaj165,
           g_faaj_m.faaj160,g_faaj_m.faaj162,
           g_faaj_m.faaj048)   #160426-00014#8 add faaj048             
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT error!'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   
   LET g_faajld_t = g_faaj_m.faajld
END FUNCTION
# 帳套帶值
PRIVATE FUNCTION afai100_faajld_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faajld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faajld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faajld_desc
   
   LET g_faaj_m.glaacomp = NULL
   LET g_faaj_m.glaa004 = NULL
   
   SELECT glaacomp,glaa004
     INTO g_faaj_m.glaacomp,g_faaj_m.glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_faaj_m.faajld
   DISPLAY BY NAME g_faaj_m.glaacomp,g_faaj_m.glaa004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.glaacomp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaa004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='0' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.glaa004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.glaa004_desc
   
   #150923--s
   #取得所屬地區
   SELECT ooef011 INTO g_ooef011
     FROM ooef_t 
    WHERE ooefent = g_enterprise
      AND ooef001 = g_faaj_m.glaacomp
   #150923--e   
END FUNCTION
# 折舊頁簽帶值
PRIVATE FUNCTION afai100_depreciation_ref()

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faajsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faajsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faajsite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaa004
   LET g_ref_fields[2] = g_faaj_m.faaj023
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj023_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_faaj_m.faaj023_desc TO faaj023_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaa004
   LET g_ref_fields[2] = g_faaj_m.faaj024
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj024_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_faaj_m.faaj024_desc TO faaj024_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaa004
   LET g_ref_fields[2] = g_faaj_m.faaj025
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj025_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_faaj_m.faaj025_desc TO faaj025_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.glaa004
   LET g_ref_fields[2] = g_faaj_m.faaj026
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj026_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_faaj_m.faaj026_desc TO faaj026_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faaj042
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj042_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faaj042_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faaj043
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj043_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faaj043_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faaj045
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj045_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faaj045_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faaj045
   LET g_ref_fields[2] = g_faaj_m.faaj046
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj046_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faaj046_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faaj_m.faaj007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faaj_m.faaj007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faaj_m.faaj007_desc
END FUNCTION
# faajld抓取相應科目
PRIVATE FUNCTION afai100_faajld_get()
   DEFINE l_ooam003     LIKE ooam_t.ooam003
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_num1        LIKE type_t.num5
   DEFINE l_num2        LIKE type_t.num5
   DEFINE l_str         STRING
   DEFINE l_str1        STRING
   DEFINE l_str2        STRING
   DEFINE l_fristdate   LIKE faah_t.faah014
   
   LET g_faaj_m.faaj023 = NULL
   LET g_faaj_m.faaj024 = NULL
   LET g_faaj_m.faaj025 = NULL
   LET g_faaj_m.faaj026 = NULL
   
   #抓取本月入帳提列方式
   LET g_faal005 = ''          #160126-00006#1 add lujh 
   SELECT faal005 INTO g_faal005                         #160426-00014#8  mark 161121-00003#3 remark
   #SELECT faal005,faal006 INTO g_faal005,g_faaj_m.faaj048 #160426-00014#8  add 161121-00003#3  mark
     FROM faal_t
    WHERE faalent = g_enterprise
      AND faalld  = g_faaj_m.faajld
      AND faal001 = g_faah_m.faah006
   #161121-00003#3 add s---   
   IF NOT cl_null(g_faaj_m.faajld) AND (g_faaj_m.faajld <> g_faaj_m_o.faajld OR cl_null(g_faaj_m_o.faajld)) THEN 
     SELECT faal006 INTO g_faaj_m.faaj048  
     FROM faal_t
    WHERE faalent = g_enterprise
      AND faalld  = g_faaj_m.faajld
      AND faal001 = g_faah_m.faah006   
   END IF   
   #161121-00003#3 add e---
   DISPLAY g_faaj_m.faaj048 TO faaj048  #160426-00014#8  add

   #161121-00003#3 add s---
   IF g_faaj_m.faaj048 = '1' THEN 
      LET g_faaj_m.faaj003 = '5'
      CALL cl_set_comp_entry("faaj003",FALSE)
   ELSE   
      CALL cl_set_comp_entry("faaj003",TRUE)
   END IF
   #161121-00003#3 add e---
                  
   LET l_year = YEAR(g_faah_m.faah014)
   LET l_month = MONTH(g_faah_m.faah014)
   IF NOT cl_null(g_faal005) THEN 
      IF g_faal005 = '1' THEN 
         LET l_num2 = l_month + 1
         IF l_num2 > 12 THEN 
            LET l_num2 = 1
            LET l_num1 = l_year + 1
         ELSE
            LET l_num2 = l_num2
            LET l_num1 = l_year
         END IF
      END IF 
      IF g_faal005 = '2' OR g_faal005 = '4' THEN 
         LET l_num1 = l_year
         LET l_num2 = l_month
      END IF
      IF g_faal005 = '3' THEN 
         CALL s_date_get_first_date(g_faah_m.faah014) RETURNING l_fristdate
         LET l_fristdate = l_fristdate + 14
         IF g_faah_m.faah014 <= l_fristdate THEN 
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
      LET g_faaj_m.faaj008 = l_str.trim()
      DISPLAY g_faaj_m.faaj008 TO faaj008
   END IF 
   IF g_faal005 <> '4' THEN 
      CALL cl_set_comp_visible('faaj029,faaj109,faaj159',FALSE) 
   ELSE 
      CALL cl_set_comp_visible('faaj029,faaj109,faaj159',TRUE) 
   END IF
   
   #資產科目
   IF cl_null(g_faaj_m.faaj023) THEN 
      SELECT glab005 INTO g_faaj_m.faaj023
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = g_faaj_m.faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_01'
   END IF
      
   #累折科目
   IF cl_null(g_faaj_m.faaj024) THEN 
      SELECT glab005 INTO g_faaj_m.faaj024
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = g_faaj_m.faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_02'   
   END IF
      
   #折舊科目 
   IF cl_null(g_faaj_m.faaj025) THEN 
#      IF g_para_data1 = '2' THEN    #依資產    #mark by yangxf
         SELECT glab005 INTO g_faaj_m.faaj025
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_faaj_m.faajld
            AND glab001 = '91'
            AND glab002 = g_faah_m.faah006
            AND glab003 = '9901_03'   
#      END IF                                  #mark by yangxf
   END IF
   
   #減值準備科目   
   IF cl_null(g_faaj_m.faaj026) THEN 
      SELECT glab005 INTO g_faaj_m.faaj026
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld = g_faaj_m.faajld
         AND glab001 = '91'
         AND glab002 = g_faah_m.faah006
         AND glab003 = '9901_04'   
   END IF      
   
   DISPLAY g_faaj_m.faaj023 TO faaj023
   DISPLAY g_faaj_m.faaj024 TO faaj024
   DISPLAY g_faaj_m.faaj025 TO faaj025
   DISPLAY g_faaj_m.faaj026 TO faaj026
   CALL afai100_depreciation_ref()   
   
   CALL afai100_visible()
      
   LET g_faaj_m.faaj014 = g_glaa001_1
   
   IF NOT cl_null(g_glaa001_1) AND NOT cl_null(g_glaa025_1) THEN 
      CALL afai100_get_exrate(g_faaj_m.faajld,g_faah_m.faah020,g_faaj_m.faaj014,g_glaa025_1) 
   END IF
   LET g_faaj_m.faaj015 = g_ooan005
   DISPLAY g_faaj_m.faaj014 TO faaj014
   DISPLAY g_faaj_m.faaj015 TO faaj015
   
   LET g_faaj_m.faaj016 = g_faaj_m.faaj015 * g_faah_m.faah022
   IF cl_null(g_faaj_m.faaj017) THEN LET g_faaj_m.faaj017 = 0 END IF 
   LET g_faaj_m.faaj028 = g_faaj_m.faaj016 - g_faaj_m.faaj017
   SELECT faac016 INTO  g_faac016
     FROM faac_t
    WHERE faacent = g_enterprise
      AND faac001 = g_faah_m.faah006
   LET g_faaj_m.faaj019 = g_faaj_m.faaj016 * g_faac016/100
   
   DISPLAY g_faaj_m.faaj016 TO faaj016
   DISPLAY g_faaj_m.faaj019 TO faaj019
   DISPLAY g_faaj_m.faaj028 TO faaj028
   IF NOT cl_null(g_faaj_m.faajld) THEN 
      IF g_glaa015 = 'Y' THEN    
         #-----本位币二-------
         #來源幣別
         LET l_ooam003 = ''
         IF g_glaa017 = '1' THEN
            LET l_ooam003 = g_faah_m.faah020
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001_1            #帳套使用幣別
         END IF
         
         LET g_faaj_m.faaj101 = g_glaa016
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_faaj_m.faajld,g_today,l_ooam003,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_faaj_m.faaj101,0,g_glaa018)
         RETURNING g_faaj_m.faaj102   
         
         LET g_faaj_m.faaj103 = g_faah_m.faah022 * g_faaj_m.faaj102
         LET g_faaj_m.faaj105 = g_faaj_m.faaj103 * g_faac016/100
         ############################add by huangtao
         LET g_faaj_m.faaj108 =  g_faaj_m.faaj103 -  g_faaj_m.faaj104
         DISPLAY g_faaj_m.faaj108 TO faaj108
         ############################add by huangtao
         DISPLAY g_faaj_m.faaj101 TO faaj101
         DISPLAY g_faaj_m.faaj102 TO faaj102
         DISPLAY g_faaj_m.faaj103 TO faaj103
         
      END IF
      IF g_glaa019 = 'Y' THEN      
         #-----本位币三-------
         LET l_ooam003 = ''
         IF g_glaa021 = '1' THEN
            LET l_ooam003 = g_faah_m.faah020
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001_1            #帳套使用幣別
         END IF
         LET g_faaj_m.faaj151 = g_glaa020
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_faaj_m.faajld,g_today,l_ooam003,
                                   #目的幣別;      交易金額; 匯類類型
                                   g_faaj_m.faaj151,0,g_glaa022)
         RETURNING g_faaj_m.faaj152   
      
         LET g_faaj_m.faaj153 = g_faah_m.faah022 * g_faaj_m.faaj152
         LET g_faaj_m.faaj155 = g_faaj_m.faaj153 * g_faac016/100
         ############################add by huangtao
         LET g_faaj_m.faaj158 =  g_faaj_m.faaj153 -  g_faaj_m.faaj154
         DISPLAY g_faaj_m.faaj158 TO faaj158
         ############################add by huangtao
         DISPLAY g_faaj_m.faaj151 TO faaj151
         DISPLAY g_faaj_m.faaj152 TO faaj152
         DISPLAY g_faaj_m.faaj153 TO faaj153
      END IF
   END IF
   
END FUNCTION
# 刪除faaj_t固定資產帳套折舊明細資料檔
PRIVATE FUNCTION afai100_faaj_del()
   IF g_faaj_m.faajld IS NULL THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   IF g_faah_m.faahstus = 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00103'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   IF cl_ask_confirm('afa-00096') THEN
      DELETE FROM faaj_t 
       WHERE faajent = g_enterprise 
         AND faajld = g_faaj_m.faajld
         AND faaj000 = g_faaj_m.faaj000
         AND faaj001 = g_faaj_m.faaj001
         AND faaj002 = g_faaj_m.faaj002
         AND faaj037 = g_faaj_m.faaj037
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'DELETE error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')
      END IF

   END IF

END FUNCTION
# 单头“币别”栏位更改后，其他本位币页签下的金额汇率重新获取。
PRIVATE FUNCTION afai100_update_exrate()
   DEFINE l_faajld          LIKE faaj_t.faajld
   DEFINE l_faaj101         LIKE faaj_t.faaj101
   DEFINE l_faaj102         LIKE faaj_t.faaj102
   DEFINE l_faaj103         LIKE faaj_t.faaj103
   DEFINE l_faaj151         LIKE faaj_t.faaj151
   DEFINE l_faaj152         LIKE faaj_t.faaj152
   DEFINE l_faaj153         LIKE faaj_t.faaj153
   
#   CALL s_transaction_begin()  #161129-00055#1 mark
#   LET g_success = 'Y'         #161129-00055#1 mark
   
   LET g_sql = "SELECT faajld,faaj101,faaj151 ",
               "  FROM faaj_t ",
               " WHERE faajent = '",g_enterprise,"'",
               "   AND faaj000 = '",g_faah_m.faah000,"'",
               "   AND faaj001 = '",g_faah_m.faah003,"'",
               "   AND faaj002 = '",g_faah_m.faah004,"'",
               "   AND faaj037 = '",g_faah_m.faah001,"'"
   PREPARE faaj_pre FROM g_sql
   DECLARE faaj_cur CURSOR FOR faaj_pre
   FOREACH faaj_cur INTO l_faajld,l_faaj101,l_faaj151
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
       
      IF g_glaa015 = 'Y' AND g_glaa017 = '1' THEN    
         #-----本位币二-------
                                  #     帳套;       日期;  來源幣別
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,g_faah_m.faah020,
                                   #目的幣別;      交易金額; 匯類類型
                                   l_faaj101,0,g_glaa018)
         RETURNING l_faaj102  
         
         LET l_faaj103 = g_faah_m.faah022 * l_faaj102
         
      END IF
      IF g_glaa019 = 'Y' AND g_glaa021 = '1' THEN      
         #-----本位币三-------

                                  #      帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,g_faah_m.faah020,
                                   #目的幣別;      交易金額; 匯類類型
                                   l_faaj151,0,g_glaa022)
         RETURNING l_faaj152   
      
         LET l_faaj153 = g_faah_m.faah022 * l_faaj152

      END IF
      
      UPDATE faaj_t SET faaj102 = l_faaj102,
                        faaj103 = l_faaj103,
                        faaj152 = l_faaj152,
                        faaj153 = l_faaj153
       WHERE faajent = g_enterprise
         AND faaj000 = g_faah_m.faah000
         AND faaj001 = g_faah_m.faah003
         AND faaj002 = g_faah_m.faah004
         AND faaj037 = g_faah_m.faah001
         AND faajld =  l_faajld  

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd faaj'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN  #161129-00055#1 add
         #LET g_success = 'N'       #161129-00055#1 mark
      END IF
   END FOREACH 

#161129-00055#1 mark s---
#   IF g_success = 'Y' THEN
#      CALL s_transaction_end('Y','1')
#   ELSE
#      CALL s_transaction_end('N','1')
#   END IF
#161129-00055#1 mark e---
END FUNCTION
# 本位幣二，本位幣三的顯示
PRIVATE FUNCTION afai100_visible()
   
   LET g_glaa001_1 = ''
   LET g_glaa015 = ''
   LET g_glaa016 = ''
   LET g_glaa017 = ''
   LET g_glaa018 = ''
   LET g_glaa019 = ''
   LET g_glaa020 = ''
   LET g_glaa021 = ''
   LET g_glaa022 = ''
   LET g_glaa025_1 = ''
   SELECT glaa001,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa025
     INTO g_glaa001_1,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa025_1
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_faaj_m.faajld
   
   IF g_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('group12',TRUE)
      CALL cl_set_comp_visible('faaj106',TRUE)
   ELSE
      CALL cl_set_comp_visible('group12',FALSE)
      CALL cl_set_comp_visible('faaj106',FALSE)
   END IF
   
   IF g_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('group13',TRUE)
      CALL cl_set_comp_visible('faaj156',TRUE)
   ELSE
      CALL cl_set_comp_visible('group13',FALSE)
      CALL cl_set_comp_visible('faaj156',FALSE)
   END IF
   IF NOT cl_null(g_glaa015) AND NOT cl_null(g_glaa019) THEN 
      IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN 
         CALL cl_set_comp_visible('page2',FALSE)
      ELSE  
         CALL cl_set_comp_visible('page2',TRUE)
      END IF 
   ELSE
      CALL cl_set_comp_visible('page2',FALSE)
   END IF 
END FUNCTION
# 動態設定元件開啟與關閉
PRIVATE FUNCTION afai100_set_comp_entry(ps_fields,pi_entry)
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
# 确认
PRIVATE FUNCTION afai100_confirm()
   DEFINE  l_faai007_sum         LIKE faai_t.faai007
   DEFINE  l_n                   LIKE type_t.num5
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef003             LIKE ooef_t.ooef003
   DEFINE  l_year                STRING
   DEFINE  l_month               STRING
   DEFINE  l_str                 STRING
   DEFINE  l_faaj008             LIKE faaj_t.faaj008
   
   LET l_success = TRUE
   
   IF g_faah_m.faahstus = 'X' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00023'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET l_success = FALSE
      RETURN l_success
   END IF
   #检查必输栏位是否为空
   IF cl_null(g_faah_m.faah005) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah005'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   IF cl_null(g_faah_m.faah006) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah006'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah014) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah014'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah015) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah015'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah016) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah016'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   IF cl_null(g_faah_m.faah017) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah017'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   IF cl_null(g_faah_m.faah018) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah018'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   IF cl_null(g_faah_m.faah020) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah020'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 

   IF cl_null(g_faah_m.faah021) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah021'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah022) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah022'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah023) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah023'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah024) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah024'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah025) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah025'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah026) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah026'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah027) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah027'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah028) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah028'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah029) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah029'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah030) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah030'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   IF cl_null(g_faah_m.faah031) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faah031'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查是否存在主键重复的资料
   LET l_n = 0
   SELECT COUNT(*) INTO l_n 
     FROM faah_t 
    WHERE faahent = g_enterprise
      AND faah001 = g_faah_m.faah001
      AND faah003 = g_faah_m.faah003 
      AND faah004 = g_faah_m.faah004
   IF l_n > 1 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00364'
      LET g_errparam.extend = g_faah_m.faah001||g_faah_m.faah003||g_faah_m.faah004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   #检查保管人员
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faah_m.faah025
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooag001") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查保管部门是否存在部门档中
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faah_m.faah026
   LET g_chkparam.arg2 = g_today
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooeg001_3") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查存放位置
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faah_m.faah027
   IF NOT cl_chk_exist("v_oocq002_3900") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查所属组织
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faah_m.faah028
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooef001") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查负责人
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faah_m.faah029
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
   #160318-00025#4--add--end
   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_ooag001") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查管理组织
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faah_m.faah030
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooef001") THEN
      LET l_success = FALSE
      RETURN l_success
   END IF 
   #检查核算组织
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faah_m.faah031
    #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   #呼叫檢查存在並帶值的library
   IF cl_chk_exist("v_ooef001") THEN   
      #錄入的核算組織職能類型非核算組織,請檢查！   
      SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_faah_m.faah031
         
      IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00325'
         LET g_errparam.extend = g_faah_m.faah031
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         RETURN l_success
      END IF
   ELSE 
      LET l_success = FALSE
      RETURN l_success
   END IF
   
   #单身数量总和不可大于单头数量
   SELECT SUM(faai007) INTO l_faai007_sum
     FROM faai_t
    WHERE faaient = g_enterprise
      AND faai001 = g_faah_m.faah001
      AND faai002 = g_faah_m.faah003
      AND faai003 = g_faah_m.faah004
      
   IF l_faai007_sum > g_faah_m.faah018 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00019'
      LET g_errparam.extend = l_faai007_sum
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_success = FALSE
      RETURN l_success
   END IF

   SELECT ooef017 INTO g_ooef017 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_faah_m.faah028
   #获取归属法人对应的主帐套
   SELECT glaa001,glaald,glaa025
     INTO g_glaa001,g_glaald,g_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_ooef017
      AND glaa014 = 'Y'
      
   #检查折旧年月不可小于取得日期
   LET l_year = YEAR(g_faah_m.faah014)
   LET l_month = MONTH(g_faah_m.faah014)
   IF l_month < 10 THEN 
      LET l_str = l_year CLIPPED,'0' CLIPPED,l_month CLIPPED
   ELSE
      LET l_str = l_year CLIPPED,l_month CLIPPED
   END IF 
   LET l_faaj008 = l_str.trim()
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faaj000 = g_faah_m.faah000
      AND faaj001 = g_faah_m.faah003
      AND faaj002 = g_faah_m.faah004
      AND faaj037 = g_faah_m.faah001
      AND faaj008 < l_faaj008
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00322'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success
   END IF
   #無主帳套的帳套折舊信息,不可確認！
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faajld  = g_glaald
      AND faaj000 = g_faah_m.faah000
      AND faaj001 = g_faah_m.faah003
      AND faaj002 = g_faah_m.faah004
      AND faaj037 = g_faah_m.faah001
   
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00121'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_success = FALSE
      RETURN l_success
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faaj000 = g_faah_m.faah000
      AND faaj001 = g_faah_m.faah003
      AND faaj002 = g_faah_m.faah004
      AND faaj037 = g_faah_m.faah001 
      AND ((faaj003 IS NULL 
       OR  faaj006 IS NULL
       OR  faaj023 IS NULL
       OR  faaj024 IS NULL
       OR  faaj026 IS NULL
       OR  faajsite IS NULL)
       OR (faaj006 IN ('1','2') AND faaj007 IS NULL))
    IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00279'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN l_success 
   END IF 

   #如果勾選了直接資本化並且狀態是取得時,確認時直接更新資產狀態為資本化
   IF g_faah_m.faah033 = 'Y' AND g_faah_m.faah015 = '0' THEN 
      UPDATE faah_t SET faah015 = '1' 
       WHERE faahent = g_enterprise
         AND faah000 = g_faah_m.faah000
         AND faah001 = g_faah_m.faah001
         AND faah003 = g_faah_m.faah003
         AND faah004 = g_faah_m.faah004
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET l_success = FALSE
         RETURN l_success       
      END IF
      
      LET g_faah_m.faah015 = '1'
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM faai_t
       WHERE faaient = g_enterprise AND faai000 = g_faah_m.faah000
         AND faai001 = g_faah_m.faah001 AND faai002 = g_faah_m.faah003
         AND faai003 = g_faah_m.faah004
         
      IF l_n != 0 THEN
         UPDATE faai_t SET faai023 = '1' 
          WHERE faaient = g_enterprise
            AND faai000 = g_faah_m.faah000
            AND faai001 = g_faah_m.faah001
            AND faai002 = g_faah_m.faah003
            AND faai003 = g_faah_m.faah004
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET l_success = FALSE
            RETURN l_success       
         END IF
      END IF
   END IF
   
   RETURN l_success
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
PRIVATE FUNCTION afai100_faah006_ref()
   #從afai020中帶折畢再提預設值
   SELECT faac004,faac005,faac006 INTO g_faaj_m.faaj004,g_faaj_m.faaj011,g_faaj_m.faaj013 FROM faac_t
    WHERE faacent = g_enterprise AND faac001 = g_faah_m.faah006
      AND faacstus = 'Y'
   LET g_faaj_m.faaj005 = g_faaj_m.faaj004
   IF NOT cl_null(g_faaj_m.faajld) THEN 
      DISPLAY BY NAME g_faaj_m.faaj004,g_faaj_m.faaj005,g_faaj_m.faaj011,g_faaj_m.faaj013
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 標籤檔刪除
# Memo...........:
# Usage..........: CALL afai100_faai_del()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_faai_del()

   IF g_faah_m.faah000 IS NULL
   OR g_faah_m.faah001 IS NULL
   OR g_faah_m.faah003 IS NULL
   OR g_faah_m.faah004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faah_m.faahstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   IF NOT cl_ask_confirm('afa-00285') THEN 
      RETURN 
   END IF 
   DELETE FROM faai_t 
    WHERE faaient = g_enterprise
      AND faai000 = g_faah_m.faah000
      AND faai001 = g_faah_m.faah001
      AND faai002 = g_faah_m.faah003
      AND faai003 = g_faah_m.faah004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE faai_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL g_faai_d_1.clear() 
      CALL afai100_s01_display() 
   END IF 
  
END FUNCTION

################################################################################
# Descriptions...: 自动产生标签明细
# Memo...........:
# Usage..........: CALL afai100_faai_ins()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/11/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_faai_ins(p_type)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE l_n             LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE l_fagl          LIKE type_t.num5
   DEFINE l_fagl2         LIKE type_t.num5
   DEFINE l_faai          RECORD LIKE faai_t.*
   DEFINE l_n1            LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str1          LIKE type_t.chr10
   DEFINE l_str2          LIKE type_t.chr10
   DEFINE l_sql           STRING 
   DEFINE l_faai004_str   STRING
   DEFINE l_faai004_str2  LIKE type_t.chr10
   DEFINE l_faai004_str3  LIKE type_t.chr10
   DEFINE l_faai005_str   STRING
   DEFINE l_faai005_str2  LIKE type_t.chr10
   DEFINE l_faai005_str3  LIKE type_t.chr10
   DEFINE l_faai004       LIKE faai_t.faai004
   DEFINE l_faai005       LIKE faai_t.faai005
   
   IF g_faah_m.faah000 IS NULL
   OR g_faah_m.faah001 IS NULL
   OR g_faah_m.faah003 IS NULL
   OR g_faah_m.faah004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faah_m.faahstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faai_t
    WHERE faaient = g_enterprise
      AND faai000 = g_faah_m.faah000
      AND faai001 = g_faah_m.faah001
      AND faai002 = g_faah_m.faah003
      AND faai003 = g_faah_m.faah004
   IF l_n > 0 THEN 
      IF p_type = '1' THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'afa-00288'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF 
      RETURN 
   END IF
   IF cl_null(g_faah_m.faah018) OR g_faah_m.faah018 = 0 THEN 
      RETURN 
   END IF 
   IF p_type = '2' THEN 
      IF NOT cl_ask_confirm('afa-00281') THEN 
         RETURN 
      END IF
   END IF       
   LET l_str = g_faah_m.faah018
   LET l_n1 = l_str.getIndexOf('.',1) 
   LET l_sql = " SELECT lpad(1,'",l_n1,"','0') FROM dual "
   PREPARE getnum_prepare1 FROM l_sql
   EXECUTE getnum_prepare1 INTO l_str1
   LET l_faai004 = g_faah_m.faah003,l_str1
   LET l_faai005 = g_faah_m.faah003,l_str1   
   CALL afai100_01(l_faai005,l_faai005,l_n1,g_faah_m.faah018) RETURNING l_faai004,l_faai005,l_fagl,l_fagl2
   
   INITIALIZE l_faai.* TO NULL
   LET l_faai.faaient = g_enterprise
   LET l_faai.faai000 = g_faah_m.faah000
   LET l_faai.faai001 = g_faah_m.faah001
   LET l_faai.faai002 = g_faah_m.faah003
   LET l_faai.faai003 = g_faah_m.faah004
   LET l_faai.faai006 = g_faah_m.faah017
   LET l_faai.faai009 = g_faah_m.faah009
   LET l_faai.faai010 = g_faah_m.faah010
   LET l_faai.faai011 = g_faah_m.faah011
   LET l_faai.faai012 = g_faah_m.faah012
   LET l_faai.faai013 = g_faah_m.faah013
   LET l_faai.faai014 = g_faah_m.faah014
   LET l_faai.faai015 = g_faah_m.faah025
   LET l_faai.faai016 = g_faah_m.faah026
   LET l_faai.faai017 = g_faah_m.faah027
   LET l_faai.faai018 = g_faah_m.faah028
   LET l_faai.faai019 = g_faah_m.faah029
   LET l_faai.faai020 = g_faah_m.faah030
   LET l_faai.faai021 = g_faah_m.faah031
   LET l_faai.faai022 = g_faah_m.faah032
   LET l_faai.faai023 = g_faah_m.faah015
   LET l_faai.faai008 = 0
   LET l_faai004_str = l_faai004
   LET l_faai005_str = l_faai005
   LET l_faai004_str2 = l_faai004_str.subString(1,l_faai004_str.getLength()-l_n1+1)
   LET l_faai004_str3 = l_faai004_str.subString(l_faai004_str.getLength()-l_n1+2,l_faai004_str.getLength())
   LET l_faai005_str2 = l_faai005_str.subString(1,l_faai005_str.getLength()-l_n1+1)
   LET l_faai005_str3 = l_faai005_str.subString(l_faai005_str.getLength()-l_n1+2,l_faai005_str.getLength())
   FOR i = 1 TO g_faah_m.faah018
      LET l_faai.faaiseq = i
      IF l_fagl THEN 
         LET l_str1 = ''
         LET l_sql = " SELECT lpad(",l_faai004_str3," +",i-1,",'",l_n1-1,"','0') FROM dual "
         PREPARE getnum_prepare FROM l_sql
         EXECUTE getnum_prepare INTO l_str1
         LET l_faai.faai004 = l_faai004_str2,l_str1
      ELSE
         LET l_faai.faai004 = l_faai004
      END IF 
      
      IF l_fagl2 THEN 
         LET l_str1 = ''
         LET l_sql = " SELECT lpad(",l_faai005_str3," +",i-1,",'",l_n1-1,"','0') FROM dual "
         PREPARE getnum_prepare2 FROM l_sql
         EXECUTE getnum_prepare2 INTO l_str2
         LET l_faai.faai005 = l_faai005_str2,l_str2
      ELSE
         LET l_faai.faai005 = l_faai005
      END IF 
      
      LET l_faai.faai007 = 1
      INSERT INTO faai_t VALUES(l_faai.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO faai_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOR 
      END IF 
   END FOR 
   CALL afai100_s01_display()  
END FUNCTION

################################################################################
# Descriptions...: 标签明细
# Memo...........:
# Usage..........: CALL afai100_s01()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_s01()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   DEFINE  l_faai007_sum         LIKE faai_t.faai007
   DEFINE  l_year                STRING
   DEFINE  l_month               STRING
   DEFINE  l_str                 STRING
   DEFINE  l_faah000             LIKE faah_t.faah000
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_ooef017_t           LIKE ooef_t.ooef017
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_glaa001_t           LIKE glaa_t.glaa001
   DEFINE  l_glaald              LIKE glaa_t.glaald
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_num1                LIKE type_t.num5
   DEFINE  l_num2                LIKE type_t.num5
   DEFINE  l_str1                STRING
   DEFINE  l_str2                STRING
   DEFINE  l_cnt1                LIKE type_t.num5  
   DEFINE  l_ooef003             LIKE ooef_t.ooef003
  
  
   IF g_faah_m.faah000 IS NULL
   OR g_faah_m.faah001 IS NULL
   OR g_faah_m.faah003 IS NULL
   OR g_faah_m.faah004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faah_m.faahstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   LET g_action_choice = ""
   LET g_forupd_sql = "SELECT faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010, 
       faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023 FROM  
       faai_t WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=? AND faaiseq=?  
       FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              
   DECLARE afai100_bcl_1 CURSOR FROM g_forupd_sql
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_faai_d_1 FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         BEFORE INPUT
            #如果单身没有资料提示是否自动产生
            CALL afai100_faai_ins('2')
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faai_d_1.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afai100_s01_display()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_faai_d_1.getLength()
         
         BEFORE ROW
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afai100_cl USING g_enterprise,g_faah_m.faah000,g_faah_m.faah001,
                                  g_faah_m.faah003,g_faah_m.faah004
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afai100_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE afai100_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_faai_d_1.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faai_d_1[l_ac].faaiseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_faai_d_1_t.* = g_faai_d_1[l_ac].*  
               LET g_faai_d_1_o.* = g_faai_d_1[l_ac].* 
               IF NOT afai100_lock_b_1("faai_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afai100_bcl_1 INTO g_faai_d_1[l_ac].faai000,g_faai_d_1[l_ac].faai001,g_faai_d_1[l_ac].faai002,g_faai_d_1[l_ac].faai003,
                      g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012, 
                      g_faai_d_1[l_ac].faai013,g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007, 
                      g_faai_d_1[l_ac].faai008,g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014, 
                      g_faai_d_1[l_ac].faai015,g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018, 
                      g_faai_d_1[l_ac].faai019,g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022, 
                      g_faai_d_1[l_ac].faai023
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_faai_d_1_t.faaiseq 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faai_d_1[l_ac].* TO NULL 
            INITIALIZE g_faai_d_1_t.* TO NULL 
            INITIALIZE g_faai_d_1_o.* TO NULL 
            LET g_faai_d_1_t.* = g_faai_d_1[l_ac].*     #新輸入資料
            LET g_faai_d_1_o.* = g_faai_d_1[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faai_d_1[li_reproduce_target].* = g_faai_d_1[li_reproduce].*
 
               LET g_faai_d_1[li_reproduce_target].faaiseq = NULL
 
            END IF
            
            #add-point:modify段before insert
            IF l_cmd = 'a' THEN 
               IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                  SELECT MAX(faaiseq) INTO g_faai_d_1[g_detail_idx].faaiseq
                    FROM faai_t
                   WHERE faaient = g_enterprise
                     AND faai001 = g_faah_m.faah001
                     AND faai002 = g_faah_m.faah003
                     AND faai003 = g_faah_m.faah004
                     
                  IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                     LET g_faai_d_1[g_detail_idx].faaiseq = 1
                  ELSE
                     LET g_faai_d_1[g_detail_idx].faaiseq = g_faai_d_1[g_detail_idx].faaiseq + 1
                  END IF
               END IF
            END IF
            LET g_faai_d_1[l_ac].faai012 = g_faah_m.faah012
            LET g_faai_d_1[l_ac].faai013 = g_faah_m.faah013
            LET g_faai_d_1[l_ac].faai006 = g_faah_m.faah017
            LET g_faai_d_1[l_ac].faai007 = 0
            LET g_faai_d_1[l_ac].faai008 = 0
            LET g_faai_d_1[l_ac].faai014 = g_today
            LET g_faai_d_1[l_ac].faai015 = g_faah_m.faah025
            LET g_faai_d_1[l_ac].faai016 = g_faah_m.faah026
            LET g_faai_d_1[l_ac].faai017 = g_faah_m.faah027
            LET g_faai_d_1[l_ac].faai018 = g_faah_m.faah028
            LET g_faai_d_1[l_ac].faai019 = g_faah_m.faah029
            LET g_faai_d_1[l_ac].faai020 = g_faah_m.faah030
            LET g_faai_d_1[l_ac].faai021 = g_faah_m.faah031
            LET g_faai_d_1[l_ac].faai022 = g_faah_m.faah032
            LET g_faai_d_1[l_ac].faai009 = g_faah_m.faah009
            LET g_faai_d_1[l_ac].faai010 = g_faah_m.faah010
            LET g_faai_d_1[l_ac].faai014 = g_faah_m.faah014
            LET g_faai_d_1[l_ac].faai023 = g_faah_m.faah015
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM faai_t 
             WHERE faaient = g_enterprise AND faai000 = g_faah_m.faah000
               AND faai001 = g_faah_m.faah001
               AND faai002 = g_faah_m.faah003
               AND faai003 = g_faah_m.faah004
 
               AND faaiseq = g_faai_d_1[l_ac].faaiseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_m.faah000
               LET gs_keys[2] = g_faah_m.faah001
               LET gs_keys[3] = g_faah_m.faah003
               LET gs_keys[4] = g_faah_m.faah004
               LET gs_keys[5] = g_faai_d_1[g_detail_idx].faaiseq
               CALL afai100_insert_b('faai_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_faai_d_1[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faai_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               DELETE FROM faai_t
                WHERE faaient = g_enterprise AND faai000 = g_faah_m.faah000 AND
                                          faai001 = g_faah_m.faah001 AND
                                          faai002 = g_faah_m.faah003 AND
                                          faai003 = g_faah_m.faah004 AND
                      faaiseq = g_faai_d_1_t.faaiseq
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faai_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afai100_bcl_1
            END IF 
              
         AFTER DELETE 
            IF l_cmd = 'd' THEN 
               #add-point:單身刪除後(=d)

               #end add-point
            ELSE
               #add-point:單身刪除後(<>d)
            
               #end add-point

            END IF
            #如果是最後一筆
            IF l_ac = (g_faai_d_1.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD faaiseq
            #add-point:BEFORE FIELD faaiseq
            IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
               SELECT MAX(faaiseq) INTO g_faai_d_1[g_detail_idx].faaiseq
                 FROM faai_t
                WHERE faaient = g_enterprise
                  AND faai001 = g_faah_m.faah001
                  AND faai002 = g_faah_m.faah002
                  AND faai003 = g_faah_m.faah003
                  
               IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                  LET g_faai_d_1[g_detail_idx].faaiseq = 1
               ELSE
                  LET g_faai_d_1[g_detail_idx].faaiseq = g_faai_d_1[g_detail_idx].faaiseq + 1
               END IF
            END IF
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faaiseq
            
            #add-point:AFTER FIELD faaiseq
                        #此段落由子樣板a05產生
            IF g_faah_m.faah001 IS NOT NULL AND g_faah_m.faah003 IS NOT NULL AND g_faah_m.faah004 IS NOT NULL AND g_faai_d_1[g_detail_idx].faaiseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faah_m.faah001 != g_faah001_t OR g_faah_m.faah003 != g_faah003_t OR g_faah_m.faah004 != g_faah004_t OR g_faai_d_1[g_detail_idx].faaiseq != g_faai_d_1_t.faaiseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faai_t WHERE "||"faaient = '" ||g_enterprise|| "' AND "|| "faai001 = '"||g_faah_m.faah001 ||"' AND "|| "faai002 = '"||g_faah_m.faah003 ||"' AND "|| "faai003 = '"||g_faah_m.faah004 ||"' AND "|| "faaiseq = '"||g_faai_d_1[g_detail_idx].faaiseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai007
            #應用 a15 樣板自動產生(Version:1)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faai_d_1[l_ac].faai007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faai007
            END IF
 
 
            #add-point:AFTER FIELD faai007
            IF NOT cl_null(g_faai_d_1[l_ac].faai007) THEN 
               LET l_faai007_sum = 0
               SELECT SUM(faai007) INTO l_faai007_sum
                 FROM faai_t
                WHERE faaient = g_enterprise
                  AND faai001 = g_faah_m.faah001
                  AND faai002 = g_faah_m.faah003
                  AND faai003 = g_faah_m.faah004
               
               IF (l_cmd = 'a' AND l_faai007_sum + g_faai_d_1[l_ac].faai007 > g_faah_m.faah018) 
               OR (l_cmd = 'u' AND l_faai007_sum + g_faai_d_1[l_ac].faai007 - g_faai_d_1_t.faai007> g_faah_m.faah018) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00019'
                  LET g_errparam.extend = g_faai_d_1[l_ac].faai007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faai_d_1[l_ac].faai007 = g_faai_d_1_t.faai007
                  NEXT FIELD faai007
               
               END IF
            END IF 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai010
            
            #add-point:AFTER FIELD faai010
                        IF NOT cl_null(g_faai_d_1[l_ac].faai010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai010
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai009
            
            #add-point:AFTER FIELD faai009
                        IF NOT cl_null(g_faai_d_1[l_ac].faai009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai009
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai015
            
            #add-point:AFTER FIELD faai015
                        IF NOT cl_null(g_faai_d_1[l_ac].faai015) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai015
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai016
            
            #add-point:AFTER FIELD faai016
                        IF NOT cl_null(g_faai_d_1[l_ac].faai016) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai016
               LET g_chkparam.arg2 = g_today
			      #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai016 = g_faai_d_1_t.faai016
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai017
            
            #add-point:AFTER FIELD faai017
                        IF NOT cl_null(g_faai_d_1[l_ac].faai017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai017

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai017 = g_faai_d_1_t.faai017
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai018
            
            #add-point:AFTER FIELD faai018
                        IF NOT cl_null(g_faai_d_1[l_ac].faai018) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai018
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
               IF cl_chk_exist("v_ooef001") THEN
               
               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai018 = g_faai_d_1_t.faai018
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            IF NOT cl_null(g_faai_d_1[l_ac].faai018) THEN 
              SELECT ooef017 INTO g_faai_d_1[l_ac].faai022
                FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = g_faai_d_1[l_ac].faai018
              DISPLAY g_faai_d_1[l_ac].faai022 TO s_detail1[l_ac].faai022
            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai019
            
            #add-point:AFTER FIELD faai019
                        IF NOT cl_null(g_faai_d_1[l_ac].faai019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai019
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai019 = g_faai_d_1_t.faai019
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai020
            
            #add-point:AFTER FIELD faai020
                        IF NOT cl_null(g_faai_d_1[l_ac].faai020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai020
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN #161024-00008#1
               IF cl_chk_exist("v_ooef001_26") THEN#161024-00008#1               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai020 = g_faai_d_1_t.faai020
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai021
            IF NOT cl_null(g_faai_d_1[l_ac].faai021) THEN 
            
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai021
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end  
               #呼叫檢查存在並帶值的library
               #161024-00008#1---s---
               #IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME                
                  #SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
                  #  FROM ooef_t
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_faai_d_1[l_ac].faai021
                  #   
                  #IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN 
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "" 
                  #   LET g_errparam.code   = "afa-00325" 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   LET g_faai_d_1[l_ac].faai021 = g_faai_d_1_t.faai021
                  #   NEXT FIELD CURRENT
                  #END IF
                  IF cl_chk_exist("v_ooef001_23") THEN
                  #161024-00008#1---e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai021 = g_faai_d_1_t.faai021
                  NEXT FIELD CURRENT
               END IF
            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai022
            
            #add-point:AFTER FIELD faai022
                        IF NOT cl_null(g_faai_d_1[l_ac].faai022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai022
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN  #161024-00008#1
               IF cl_chk_exist("v_ooef001_1") THEN #161024-00008#1
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai022 = g_faai_d_1_t.faai022
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

         #Ctrlp:input.c.page1.faai010
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai010
            #add-point:ON ACTION controlp INFIELD faai010
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai010             #給予default值

            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai010 TO faai010              #顯示到畫面上

            NEXT FIELD faai010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai009
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai009
            #add-point:ON ACTION controlp INFIELD faai009
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai009             #給予default值

            #給予arg

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai009 TO faai009              #顯示到畫面上

            NEXT FIELD faai009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai014
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai014
            #add-point:ON ACTION controlp INFIELD faai014
            
            #END add-point
 
         #Ctrlp:input.c.page1.faai015
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai015
            #add-point:ON ACTION controlp INFIELD faai015
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai015             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai015 TO faai015              #顯示到畫面上

            NEXT FIELD faai015                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai016
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai016
            #add-point:ON ACTION controlp INFIELD faai016
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001_4()                                  #呼叫開窗

            LET g_faai_d_1[l_ac].faai016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai016 TO faai016              #顯示到畫面上

            NEXT FIELD faai016
 
         #Ctrlp:input.c.page1.faai017
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai017
            #add-point:ON ACTION controlp INFIELD faai017
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai017

            #給予arg
            LET g_qryparam.arg1 = "" 

            CALL q_oocq002()

            LET g_faai_d_1[l_ac].faai017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai017 TO faai017              #顯示到畫面上

            NEXT FIELD faai017
 
         #Ctrlp:input.c.page1.faai018
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai018
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai018
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai018 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai018 TO faai018
            NEXT FIELD faai018 
         #Ctrlp:input.c.page1.faai019
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai019
            #add-point:ON ACTION controlp INFIELD faai019
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai019
            CALL q_ooag001()
            LET g_faai_d_1[l_ac].faai019 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai019 TO faai019   
            NEXT FIELD faai019
 
         #Ctrlp:input.c.page1.faai020
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai020
            #add-point:ON ACTION controlp INFIELD faai020
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai020
            LET g_qryparam.where = " ooef207 = 'Y'"     #161024-00008#1   
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai020 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai020 TO faai020
            NEXT FIELD faai020
 
         #Ctrlp:input.c.page1.faai021
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai021
            #add-point:ON ACTION controlp INFIELD faai021
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai021
            #LET g_qryparam.where = " ooef003 = 'Y' OR ooef204 = 'Y' "  #161024-00008#1
            LET g_qryparam.where = " ooef204 = 'Y' "                    #161024-00008#1
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai021 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai021 TO faai021
            NEXT FIELD faai021
 
         #Ctrlp:input.c.page1.faai022
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai022
            #add-point:ON ACTION controlp INFIELD faai022
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai022 
            #CALL q_ooef001()  #161024-00008#1
            CALL q_ooef001_2() #161024-00008#1
            LET g_faai_d_1[l_ac].faai022 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai022 TO faai022
            NEXT FIELD faai022                         

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
               CLOSE afai100_bcl_1
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_faai_d_1[l_ac].faaiseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
            ELSE
      
               UPDATE faai_t SET (faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005, 
                   faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019, 
                   faai020,faai021,faai022,faai023) = (g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003, 
                   g_faah_m.faah004,g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012, 
                   g_faai_d_1[l_ac].faai013,g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007, 
                   g_faai_d_1[l_ac].faai008,g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014, 
                   g_faai_d_1[l_ac].faai015,g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018, 
                   g_faai_d_1[l_ac].faai019,g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022, 
                   g_faai_d_1[l_ac].faai023)
                WHERE faaient = g_enterprise AND faai000 = g_faah_m.faah000 
                  AND faai001 = g_faah_m.faah001 
                  AND faai002 = g_faah_m.faah003 
                  AND faai003 = g_faah_m.faah004 
 
                  AND faaiseq = g_faai_d_1_t.faaiseq #項次   
 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faah_m.faah000
               LET gs_keys_bak[1] = g_faah000_t
               LET gs_keys[2] = g_faah_m.faah001
               LET gs_keys_bak[2] = g_faah001_t
               LET gs_keys[3] = g_faah_m.faah003
               LET gs_keys_bak[3] = g_faah003_t
               LET gs_keys[4] = g_faah_m.faah004
               LET gs_keys_bak[4] = g_faah004_t
               LET gs_keys[5] = g_faai_d_1[g_detail_idx].faaiseq
               LET gs_keys_bak[5] = g_faai_d_1_t.faaiseq
               CALL afai100_update_b('faai_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_faah_m),util.JSON.stringify(g_faai_d_1_t)
               LET g_log2 = util.JSON.stringify(g_faah_m),util.JSON.stringify(g_faai_d_1[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
 
            END IF
            
         AFTER ROW
            CALL afai100_unlock_b("faai_t","'1'")
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
            LET l_faai007_sum = 0
            SELECT SUM(faai007) INTO l_faai007_sum
              FROM faai_t
             WHERE faaient = g_enterprise
               AND faai001 = g_faah_m.faah001
               AND faai002 = g_faah_m.faah003
               AND faai003 = g_faah_m.faah004       
            IF l_faai007_sum > g_faah_m.faah018 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faai007
            END IF
            IF l_faai007_sum < g_faah_m.faah018 THEN
               IF NOT cl_ask_confirm('afa-00282') THEN 
                  NEXT FIELD faai007
               END IF 
            END IF 
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_faai_d_1.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_faai_d_1.getLength()+1
            
 
      END INPUT

    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

   CALL afai100_s01_display()
END FUNCTION

################################################################################
# Descriptions...: 显示单身
# Memo...........:
# Usage..........: CALL afai100_s01_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_s01_display()
   CALL g_faai_d_1.clear()   
   LET g_sql = "SELECT  UNIQUE faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008, 
                               faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022, 
                               faai023  FROM faai_t",   
               " INNER JOIN faah_t ON faah000 = faai000 ",
               " AND faah001 = faai001 ",
               " AND faah003 = faai002 ",
               " AND faah004 = faai003 ",
               " WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=?"
   LET g_sql = cl_sql_add_mask(g_sql)
   LET g_sql = g_sql, " ORDER BY faai_t.faaiseq"
   LET g_sql = cl_sql_add_mask(g_sql)            
   PREPARE afai100_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR afai100_pb_1
   LET g_cnt = l_ac
   LET l_ac = 1
   OPEN b_fill_cs_1 USING g_enterprise,g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004                           
   FOREACH b_fill_cs_1 INTO g_faai_d_1[l_ac].faai000,g_faai_d_1[l_ac].faai001,g_faai_d_1[l_ac].faai002,g_faai_d_1[l_ac].faai003,
       g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012,g_faai_d_1[l_ac].faai013, 
       g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007,g_faai_d_1[l_ac].faai008, 
       g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014,g_faai_d_1[l_ac].faai015, 
       g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018,g_faai_d_1[l_ac].faai019, 
       g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022,g_faai_d_1[l_ac].faai023 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_faai_d_1.deleteElement(g_faai_d_1.getLength())
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afai100_pb_1

END FUNCTION

################################################################################
# Descriptions...: 标签明细显示
# Memo...........:
# Usage..........: CALL afai100_ui_dialog_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_ui_dialog_1()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   #畫面開啟 (identifier)
   OPEN WINDOW w_afai100_s01 WITH FORM cl_ap_formpath("afa","afai100_s01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CALL cl_set_combo_scc('faai023','9914') 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   LET g_qryparam.state = "i"
   CALL afai100_s01_display()
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET lb_first = TRUE
   WHILE TRUE 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faai_d_1 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL afai100_idx_chk_1()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               

            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afai100_idx_chk_1()
               
         END DISPLAY
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #筆數顯示
            LET g_current_page = 1

         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION afai100_02
            LET g_action_choice="afai100_02"
            IF cl_auth_chk_act("afai100_02") THEN
               CALL afai100_faai_del()
               CALL afai100_idx_chk_1()
            END IF
 
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai100_s01()
               
            END IF
            
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afai100_s01()
               CALL afai100_idx_chk_1()
            END IF

         ON ACTION afai100_01
            LET g_action_choice="afai100_01"
            IF cl_auth_chk_act("afai100_01") THEN
               CALL afai100_faai_ins('1')
               CALL afai100_idx_chk_1()
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
   #畫面關閉
   CLOSE WINDOW w_afai100_s01  
   LET g_action_choice = "afai100_03"   
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
PRIVATE FUNCTION afai100_lock_b_1(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING

   LET ls_group = "faai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afai100_bcl_1 USING g_enterprise,
                               g_faah_m.faah000,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004, 
                               g_faai_d_1[g_detail_idx].faaiseq     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afai100_bcl_1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
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
PRIVATE FUNCTION afai100_idx_chk_1()

   LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
   IF g_detail_idx > g_faai_d_1.getLength() THEN
      LET g_detail_idx = g_faai_d_1.getLength()
   END IF
   IF g_detail_idx = 0 AND g_faai_d_1.getLength() <> 0 THEN
      LET g_detail_idx = 1
   END IF
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_faai_d_1.getLength() TO FORMONLY.cnt
   
END FUNCTION

################################################################################
# Descriptions...: 獲取匯率
# Memo...........:
# Usage..........: CALL afai100_faaj015_desc_get()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/12 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_faaj015_desc_get()
   DEFINE l_glaald   LIKE glaa_t.glaald
   DEFINE l_glaa001  LIKE glaa_t.glaa001
   DEFINE l_glaa025  LIKE glaa_t.glaa025
   DEFINE l_faaj015  LIKE faaj_t.faaj015  #161208-00075#1 add lujh  
   
   IF cl_null(g_faah_m.faah032) OR cl_null(g_faah_m.faah020) THEN 
      LET g_faah_m.faaj015_desc = ''
      DISPLAY BY NAME g_faah_m.faaj015_desc
      RETURN 
   END IF 
   SELECT glaald,glaa001,glaa025 INTO l_glaald,l_glaa001,l_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_faah_m.faah032
      AND glaa014 = 'Y'

   CALL afai100_get_exrate(l_glaald,g_faah_m.faah020,l_glaa001,l_glaa025) 
   LET g_faah_m.faaj015_desc = g_ooan005
   
   #161208-00075#1--add--str--lujh
   SELECT faaj015 INTO l_faaj015
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faajld = l_glaald
      AND faaj001 = g_faah_m.faah003
      AND faaj002 = g_faah_m.faah004
      AND faaj037 = g_faah_m.faah001
   
   IF NOT cl_null(l_faaj015) THEN 
      LET g_faah_m.faaj015_desc = l_faaj015 
   END IF
   #161208-00075#1--add--end--lujh
      
   DISPLAY BY NAME g_faah_m.faaj015_desc
      
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
PRIVATE FUNCTION afai100_init_para()
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9009') RETURNING g_para_data1  #折舊費用科目取值
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9010') RETURNING g_para_data3  #財编自动编号否
END FUNCTION
# 单头参考栏位带值
PRIVATE FUNCTION afai100_ref_show()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah006
   CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah006_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah007
   CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah007_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah017
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah017_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah020
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah020_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah025
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_faah_m.faah025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah025_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah026_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah027
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah027_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah028_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah029
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_faah_m.faah029_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah029_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah030
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah030_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah031_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah032
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah032_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah009
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah009_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah011_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_m.faah041
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faah_m.faah041_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faah_m.faah041_desc
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL PRIVATE FUNCTION afai100_insert_b(ps_table,ps_keys,ps_page)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afai100_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num5
   
   LET g_update = TRUE  
   
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN

      INSERT INTO faai_t
                  (faaient,
                   faai000,faai001,faai002,faai003,
                   faaiseq
                   ,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_faai_d_1[g_detail_idx].faai004,g_faai_d_1[g_detail_idx].faai012,g_faai_d_1[g_detail_idx].faai013, 
                       g_faai_d_1[g_detail_idx].faai005,g_faai_d_1[g_detail_idx].faai006,g_faai_d_1[g_detail_idx].faai007, 
                       g_faai_d_1[g_detail_idx].faai008,g_faai_d_1[g_detail_idx].faai010,g_faai_d_1[g_detail_idx].faai009, 
                       g_faai_d_1[g_detail_idx].faai014,g_faai_d_1[g_detail_idx].faai015,g_faai_d_1[g_detail_idx].faai016, 
                       g_faai_d_1[g_detail_idx].faai017,g_faai_d_1[g_detail_idx].faai018,g_faai_d_1[g_detail_idx].faai019, 
                       g_faai_d_1[g_detail_idx].faai020,g_faai_d_1[g_detail_idx].faai021,g_faai_d_1[g_detail_idx].faai022, 
                       g_faai_d_1[g_detail_idx].faai023)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faai_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_faai_d_1.insertElement(li_idx) 
      END IF 
 
   END IF
   
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afai100_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "faai_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE faai_t 
         SET (faai000,faai001,faai002,faai003,
              faaiseq
              ,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_faai_d_1[g_detail_idx].faai004,g_faai_d_1[g_detail_idx].faai012,g_faai_d_1[g_detail_idx].faai013, 
                  g_faai_d_1[g_detail_idx].faai005,g_faai_d_1[g_detail_idx].faai006,g_faai_d_1[g_detail_idx].faai007, 
                  g_faai_d_1[g_detail_idx].faai008,g_faai_d_1[g_detail_idx].faai010,g_faai_d_1[g_detail_idx].faai009, 
                  g_faai_d_1[g_detail_idx].faai014,g_faai_d_1[g_detail_idx].faai015,g_faai_d_1[g_detail_idx].faai016, 
                  g_faai_d_1[g_detail_idx].faai017,g_faai_d_1[g_detail_idx].faai018,g_faai_d_1[g_detail_idx].faai019, 
                  g_faai_d_1[g_detail_idx].faai020,g_faai_d_1[g_detail_idx].faai021,g_faai_d_1[g_detail_idx].faai022, 
                  g_faai_d_1[g_detail_idx].faai023) 
         WHERE faaient = g_enterprise AND faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]

      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
   END IF
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afai100_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afai100_bcl_1
   END IF
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afai100_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num5
   
   
   LET g_update = TRUE  

   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
 
      DELETE FROM faai_t
       WHERE faaient = g_enterprise AND
         faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afai100_detail_reproduce1()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND

#   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afai100_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE afai100_detail AS ",
                "SELECT * FROM faaj_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
   INSERT INTO afai100_detail SELECT * FROM faaj_t 
                                      WHERE faajent = g_enterprise 
                                        AND faaj000 = g_faah000_t
                                        AND faaj001 = g_faah003_t
                                        AND faaj002 = g_faah004_t
                                        AND faaj037 = g_faah001_t

   #將key修正為調整後   
   UPDATE afai100_detail 
      #更新key欄位
      SET faaj000 = g_faah_m.faah000,
          faaj001 = g_faah_m.faah003,
          faaj002 = g_faah_m.faah004,
          faaj037 = g_faah_m.faah001
 
   #將資料塞回原table   
   INSERT INTO faaj_t SELECT * FROM afai100_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #yangtt  2015/6/3 複製時，不需要複製faai_t 
   ##刪除TEMP TABLE
   #DROP TABLE afai100_detail
   ##CREATE TEMP TABLE
   #LET ls_sql = 
   #   "CREATE GLOBAL TEMPORARY TABLE afai100_detail AS ",
   #   "SELECT * FROM faai_t "
   #PREPARE repro_tbl2 FROM ls_sql
   #EXECUTE repro_tbl2
   #FREE repro_tbl2
   ##將符合條件的資料丟入TEMP TABLE
   #INSERT INTO afai100_detail SELECT * FROM faai_t
   #                                   WHERE faaient = g_enterprise 
   #                                     AND faai000 = g_faah000_t
   #                                     AND faai001 = g_faah001_t
   #                                     AND faai002 = g_faah003_t
   #                                     AND faai003 = g_faah004_t
   #
   ##將key修正為調整後   
   #UPDATE afai100_detail SET faai000 = g_faah_m.faah000,
   #       faai001 = g_faah_m.faah001,
   #       faai002 = g_faah_m.faah003,
   #       faai003 = g_faah_m.faah004
   #
   ##將資料塞回原table   
   #INSERT INTO faai_t SELECT * FROM afai100_detail
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "reproduce" 
   #   LET g_errparam.code   = SQLCA.sqlcode 
   #   LET g_errparam.popup  = TRUE 
   #   CALL cl_err()
   #   RETURN
   #END IF
   #
   #yangtt  2015/6/3 複製時，不需要複製faai_t 
   DROP TABLE afai100_detail
   
   
   LET g_faaj_m.faaj000 = g_faah_m.faah000
   LET g_faaj_m.faaj001 = g_faah_m.faah003
   LET g_faaj_m.faaj002 = g_faah_m.faah004
   LET g_faaj_m.faaj037 = g_faah_m.faah001
#   CALL s_transaction_end('Y','0')
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
PRIVATE FUNCTION afai100_browser_fill_1(p_wc,ps_page_action)
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_glaald          LIKE glaa_t.glaald
   DEFINE l_comp_str        STRING  #161111-00049#5 add 
      
   LET l_searchcol = "faah000,faah001,faah003,faah004"
   
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   IF cl_null(g_wc4) THEN 
      LET g_wc4 = " 1=1"
   END IF 
   
   #161111-00049#5 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","faah032")
   LET p_wc = p_wc," AND ",l_comp_str 

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faah028")
   LET p_wc = p_wc," AND ",l_comp_str
   
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faah030")
   LET p_wc = p_wc," AND ",l_comp_str  

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faah031")
   LET p_wc = p_wc," AND ",l_comp_str
   #161111-00049#5 add e---      
 
   LET g_sql = " SELECT COUNT(*) FROM faah_t ",
               "  ",
               "  ",
               " WHERE faahent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("faah_t")
                
   #add-point:browser_fill段cnt_sql
   LET l_sub_sql = " SELECT UNIQUE faah000,faah001,faah003,faah004 FROM faah_t ",
                   "  LEFT JOIN faaj_t ON faajent = faahent AND faaj000 = faah000 AND faaj001 = faah003 AND faaj002 = faah004 AND faaj037 = faah001",
                   "  ",
                   "  ",
                   " WHERE faahent = '" ||g_enterprise|| "' AND ",p_wc CLIPPED, cl_sql_add_filter("faah_t")
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   PREPARE header_cnt_pre2 FROM g_sql
   EXECUTE header_cnt_pre2 INTO g_browser_cnt
   FREE header_cnt_pre2 
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
      INITIALIZE g_faah_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   LET g_sql = " SELECT DISTINCT t0.faahstus,t0.faah000,t0.faah003,t0.faah004,t0.faah001,t0.faah002,t0.faah012, 
       t0.faah013,t0.faah021,t0.faah022,t0.faah024,t0.faah028,t0.faah032,t1.ooefl003 ,t2.ooefl003",
               " FROM faah_t t0 ",
               " LEFT JOIN faaj_t ON faajent = faahent AND faaj000 = faah000 AND faaj001 = faah003 AND faaj002 = faah004 AND faaj037 = faah001",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.faah028 AND t1.ooefl002='"||g_lang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.faah032 AND t2.ooefl002='"||g_lang||"' ",
               " WHERE t0.faahent = '" ||g_enterprise|| "' AND ",g_wc4 CLIPPED," AND ", ls_wc,cl_sql_add_filter("faah_t")

   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre2 FROM g_sql
   DECLARE browse_cur2 CURSOR FOR browse_pre2
   FOREACH browse_cur2 INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_faah000,g_browser[g_cnt].b_faah003, 
       g_browser[g_cnt].b_faah004,g_browser[g_cnt].b_faah001,g_browser[g_cnt].b_faah002,g_browser[g_cnt].b_faah012, 
       g_browser[g_cnt].b_faah013,g_browser[g_cnt].b_faah021,g_browser[g_cnt].b_faah022,g_browser[g_cnt].b_faah024, 
       g_browser[g_cnt].b_faah028,g_browser[g_cnt].b_faah032,g_browser[g_cnt].b_faah028_desc,g_browser[g_cnt].b_faah032_desc 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      #獲取法人對應的主帳套
      SELECT glaald INTO l_glaald
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_browser[g_cnt].b_faah032
         AND glaa014 = 'Y'
      #根據財編+卡片編號+附號+批號+主帳套抓取累折、預殘留值、減值準備
      SELECT faaj017,faaj019,faaj028
        INTO g_browser[g_cnt].b_faaj017,g_browser[g_cnt].b_faaj019,g_browser[g_cnt].b_faaj028
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faajld = l_glaald
         AND faaj000 = g_browser[g_cnt].b_faah000
         AND faaj001 = g_browser[g_cnt].b_faah003
         AND faaj002 = g_browser[g_cnt].b_faah004
         AND faaj037 = g_browser[g_cnt].b_faah001
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         
      END CASE
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   IF cl_null(g_browser[g_cnt].b_faah001) THEN 
      CALL g_browser.deleteElement(g_cnt)
   END IF 
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   LET g_browser_cnt = g_browser.getLength()  #160328-00001#1 add  
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
      
   
   CALL afai100_fetch("") 
   
   FREE browse_pre2
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", TRUE)
   END IF
   
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afai100_set_act_visible()
   CALL afai100_set_act_no_visible()
END FUNCTION

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="aslm200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-10-29 17:21:12), PR版次:0013(2017-01-23 09:18:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aslm200
#+ Description: 料件主檔維護作業
#+ Creator....: 03247(2016-06-15 18:20:14)
#+ Modifier...: 06189 -SD/PR- 02749
 
{</section>}
 
{<section id="aslm200.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141231-00010#1   2016/03/18  By lixiang  統計分類頁簽欄位帶出相應的說明
#150317-00006#1   2016/03/21  By lixiang  1.维护不存在的生命周期会报错：
#                                         输入的资料不存在于应用分类为%1的[应用分类码档]中！
#                                         此报错讯息不准确，让使用者不知道该怎样处理，需明确去哪支作业处理及作业代码
#                                         2.维护无效的生命周期时的报错也需要一并修改
#                                         3.统计分类页签中的栏位，成分与物质页签中的类型和成份/物质，产品标签页签中的产品标签，录入无效和不存在资料时的报错，也需要一并修改
#                                         4.统计分类页签中的资料没有带出对应的说明
#                                         5.超量容差，超重容差后有两个%
#                                         6.成份与物质页签中的成份/物质没有控管必须是对应类型(imaj002）的成份/物质
#                                         7.点击整单操作中的产品特征值按钮，录入特征值后，没有带出对应的说明
#                                         8.产品特征值页签，没有带出特征值对应的说明。
#                                         9.整单操作中，成本据点数据，点击没有反应。
#160321-00016#32  2016/03/25   By Jessy   修正azzi920重複定義之錯誤訊息
#160318-00025#40  2016/04/22   By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160402-00001#1   2016/04/25   By fionchen新增可用單位imao_t時,多判斷p_cmd<> 'r'時,才可以新增
#160511-00040#3   2016/05/24   By shiun   新增欄位預設
#160801-00017#3   2016/08/03   By 06814    1.单身增加产品特征字段，
#                                          管控当前料件的条码分类(imay002)为3.款色，且料件特征组不为空时，此字段必填。
#                                          特征组为空時，产品特征不可输
#                                          可手动录入或开窗选填，参照apmt500采购单身修改状态时的产品特征字段
#160803-00008#4   2016/08/11   By 06814    1.條碼分類為3.款色，且料件特徵組不為空時，
#                                            新增資料時可開窗二維勾選多個特徵(參照apmt500採購單身產品特徵字段，
#                                            但需將二維開窗中的數量字段變為勾選字段),
#                                            根據勾選的特徵自動生成多筆條碼資料(商品條碼=料號+產品特徵值(無下劃線))。
#                                          2.當條碼分類為3.款色時,不走條碼校驗
#160805-00028#1   2016/08/10   By lori     1.新增產品特徵(庫存)頁簽,當產品特徵為二維時,特徵值橫向展開
#                                          2.新增子畫面-產品特徵選擇,提供勾選特徵值並將結果寫入imas_t
#                                          3.條碼類型=3.款色時,依產品特徵(庫存)頁簽,產生多條碼資料,自動編條碼原則為「商品+產品特徵(不含底線)」
#160816-00042#1   2016/08/18   By xianghui s_azzi610_check检查时增加据点参数
#160822-00036#1   2016/08/24   By 06814    1.產品特徵開窗完畢後,馬上顯示出所有產出筆數
#                                          2.aoos020 若不使用產品特徵,將產品特徵隱藏
#161008-00007#1   2016/10/08   By tangyi   增加ima143,逻辑参考adbm300
#161101-00024#1   2016/11/01   by 08172    产品特征(库存)页签中的‘产品特征选择’按钮现管控为当料件为已审核状态时无法使用，去掉此控制允许已审核状态也可使用。
#161111-00028#10  2016/11/25   by 02481    标准程式定义采用宣告模式,弃用.*写法
#161228-00033#4   2016/12/30   By lori     ROWNUM語法改為Scrolling CURSOR
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aim_aimm200_01
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_imaa_m        RECORD
       imaa001 LIKE imaa_t.imaa001, 
   imaa002 LIKE imaa_t.imaa002, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaal005 LIKE imaal_t.imaal005, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr80, 
   imaa003 LIKE imaa_t.imaa003, 
   imaa003_desc LIKE type_t.chr80, 
   imaa004 LIKE imaa_t.imaa004, 
   imaa005 LIKE imaa_t.imaa005, 
   imaa005_desc LIKE type_t.chr80, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr80, 
   imaa010 LIKE imaa_t.imaa010, 
   imaa010_desc LIKE type_t.chr80, 
   imaastus LIKE imaa_t.imaastus, 
   imaa126 LIKE imaa_t.imaa126, 
   imaa126_desc LIKE type_t.chr80, 
   imaa127 LIKE imaa_t.imaa127, 
   imaa127_desc LIKE type_t.chr80, 
   imaa131 LIKE imaa_t.imaa131, 
   imaa131_desc LIKE type_t.chr80, 
   imaa128 LIKE imaa_t.imaa128, 
   imaa128_desc LIKE type_t.chr80, 
   imaa129 LIKE imaa_t.imaa129, 
   imaa129_desc LIKE type_t.chr80, 
   imaa130 LIKE imaa_t.imaa130, 
   imaa132 LIKE imaa_t.imaa132, 
   imaa132_desc LIKE type_t.chr80, 
   imaa133 LIKE imaa_t.imaa133, 
   imaa133_desc LIKE type_t.chr80, 
   imaa134 LIKE imaa_t.imaa134, 
   imaa134_desc LIKE type_t.chr80, 
   imaa135 LIKE imaa_t.imaa135, 
   imaa135_desc LIKE type_t.chr80, 
   imaa136 LIKE imaa_t.imaa136, 
   imaa136_desc LIKE type_t.chr80, 
   imaa137 LIKE imaa_t.imaa137, 
   imaa137_desc LIKE type_t.chr80, 
   imaa138 LIKE imaa_t.imaa138, 
   imaa138_desc LIKE type_t.chr80, 
   imaa139 LIKE imaa_t.imaa139, 
   imaa139_desc LIKE type_t.chr80, 
   imaa140 LIKE imaa_t.imaa140, 
   imaa140_desc LIKE type_t.chr80, 
   imaa141 LIKE imaa_t.imaa141, 
   imaa141_desc LIKE type_t.chr80, 
   imaaownid LIKE imaa_t.imaaownid, 
   imaaownid_desc LIKE type_t.chr80, 
   imaaowndp LIKE imaa_t.imaaowndp, 
   imaaowndp_desc LIKE type_t.chr80, 
   imaacrtid LIKE imaa_t.imaacrtid, 
   imaacrtid_desc LIKE type_t.chr80, 
   imaacrtdp LIKE imaa_t.imaacrtdp, 
   imaacrtdp_desc LIKE type_t.chr80, 
   imaacrtdt LIKE imaa_t.imaacrtdt, 
   imaamodid LIKE imaa_t.imaamodid, 
   imaamodid_desc LIKE type_t.chr80, 
   imaamoddt LIKE imaa_t.imaamoddt, 
   imaacnfid LIKE imaa_t.imaacnfid, 
   imaacnfid_desc LIKE type_t.chr80, 
   imaacnfdt LIKE imaa_t.imaacnfdt, 
   imaa011 LIKE imaa_t.imaa011, 
   imaa012 LIKE imaa_t.imaa012, 
   imaa013 LIKE imaa_t.imaa013, 
   imaa014 LIKE imaa_t.imaa014, 
   imaa100 LIKE imaa_t.imaa100, 
   imaa109 LIKE imaa_t.imaa109, 
   imaa154 LIKE imaa_t.imaa154, 
   imaa155 LIKE imaa_t.imaa155, 
   imaa156 LIKE imaa_t.imaa156, 
   imaa116 LIKE imaa_t.imaa116, 
   imaa158 LIKE imaa_t.imaa158, 
   imaa143 LIKE imaa_t.imaa143, 
   imaa143_desc LIKE type_t.chr80, 
   imaa142 LIKE imaa_t.imaa142, 
   imaa142_desc LIKE type_t.chr80, 
   imaa108 LIKE imaa_t.imaa108, 
   imaa110 LIKE imaa_t.imaa110, 
   imaa111 LIKE imaa_t.imaa111, 
   imaa112 LIKE imaa_t.imaa112, 
   imaa121 LIKE imaa_t.imaa121, 
   imaa124 LIKE imaa_t.imaa124, 
   imaa124_desc LIKE type_t.chr80, 
   imaa016 LIKE imaa_t.imaa016, 
   imaa017 LIKE imaa_t.imaa017, 
   imaa018 LIKE imaa_t.imaa018, 
   imaa018_desc LIKE type_t.chr80, 
   imaa159 LIKE imaa_t.imaa159, 
   imaa160 LIKE imaa_t.imaa160, 
   imaa019 LIKE imaa_t.imaa019, 
   imaa020 LIKE imaa_t.imaa020, 
   imaa021 LIKE imaa_t.imaa021, 
   imaa022 LIKE imaa_t.imaa022, 
   imaa022_desc LIKE type_t.chr80, 
   imaa023 LIKE imaa_t.imaa023, 
   imaa024 LIKE imaa_t.imaa024, 
   imaa025 LIKE imaa_t.imaa025, 
   imaa026 LIKE imaa_t.imaa026, 
   imaa027 LIKE imaa_t.imaa027, 
   imaa028 LIKE imaa_t.imaa028, 
   imaa029 LIKE imaa_t.imaa029, 
   imaa029_desc LIKE type_t.chr80, 
   imaa030 LIKE imaa_t.imaa030, 
   imaa031 LIKE imaa_t.imaa031, 
   imaa032 LIKE imaa_t.imaa032, 
   imaa032_desc LIKE type_t.chr80, 
   imaa033 LIKE imaa_t.imaa033, 
   imaa034 LIKE imaa_t.imaa034, 
   imaa035 LIKE imaa_t.imaa035, 
   imaa036 LIKE imaa_t.imaa036, 
   imaa037 LIKE imaa_t.imaa037, 
   imaa043 LIKE imaa_t.imaa043, 
   imaa038 LIKE imaa_t.imaa038, 
   imaa039 LIKE imaa_t.imaa039, 
   imaa039_desc LIKE type_t.chr80, 
   imaa040 LIKE imaa_t.imaa040, 
   imaa041 LIKE imaa_t.imaa041, 
   imaa042 LIKE imaa_t.imaa042, 
   imaa044 LIKE imaa_t.imaa044, 
   ooff013 LIKE ooff_t.ooff013, 
   imaa122 LIKE imaa_t.imaa122, 
   imaa122_desc LIKE type_t.chr80, 
   imaa045 LIKE imaa_t.imaa045, 
   imaa045_desc LIKE type_t.chr80, 
   imaa123 LIKE imaa_t.imaa123, 
   imac002 LIKE imac_t.imac002, 
   imac003 LIKE imac_t.imac003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imaj_d        RECORD
       imaj002 LIKE imaj_t.imaj002, 
   imaj002_desc LIKE type_t.chr500, 
   imaj003 LIKE imaj_t.imaj003, 
   imaj003_desc LIKE type_t.chr500, 
   imaj004 LIKE imaj_t.imaj004, 
   imaj005 LIKE imaj_t.imaj005, 
   imaj005_desc LIKE type_t.chr500, 
   imaj006 LIKE imaj_t.imaj006, 
   imaj006_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imaj2_d RECORD
       imal002 LIKE imal_t.imal002, 
   imal002_desc LIKE type_t.chr500, 
   l_oocq005 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imaj3_d RECORD
       imam002 LIKE imam_t.imam002, 
   imam005 LIKE imam_t.imam005, 
   imam003 LIKE imam_t.imam003, 
   imam006 LIKE imam_t.imam006, 
   imam004 LIKE imam_t.imam004
       END RECORD
PRIVATE TYPE type_g_imaj4_d RECORD
       imao002 LIKE imao_t.imao002, 
   imao002_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imaj5_d RECORD
       imaystus LIKE imay_t.imaystus, 
   imay002 LIKE imay_t.imay002, 
   imay019 LIKE imay_t.imay019, 
   imay019_desc LIKE type_t.chr500, 
   imay003 LIKE imay_t.imay003, 
   imay004 LIKE imay_t.imay004, 
   imay004_desc LIKE type_t.chr500, 
   imay005 LIKE imay_t.imay005, 
   imay006 LIKE imay_t.imay006, 
   imay018 LIKE imay_t.imay018, 
   imay007 LIKE imay_t.imay007, 
   imay008 LIKE imay_t.imay008, 
   imay009 LIKE imay_t.imay009, 
   imay015 LIKE imay_t.imay015, 
   imay015_desc LIKE type_t.chr500, 
   imay010 LIKE imay_t.imay010, 
   imay016 LIKE imay_t.imay016, 
   imay016_desc LIKE type_t.chr500, 
   imay011 LIKE imay_t.imay011, 
   imay017 LIKE imay_t.imay017, 
   imay017_desc LIKE type_t.chr500, 
   imay012 LIKE imay_t.imay012, 
   imay013 LIKE imay_t.imay013, 
   imay014 LIKE imay_t.imay014
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imaa001 LIKE imaa_t.imaa001,
   b_imaa001_desc LIKE type_t.chr80,
   b_imaa001_desc_desc LIKE type_t.chr80,
      b_imaa009 LIKE imaa_t.imaa009,
   b_imaa009_desc LIKE type_t.chr80,
      b_imaa003 LIKE imaa_t.imaa003,
   b_imaa003_desc LIKE type_t.chr80,
      b_imaa004 LIKE imaa_t.imaa004,
      b_imaa005 LIKE imaa_t.imaa005,
   b_imaa005_desc LIKE type_t.chr80,
      b_imaa006 LIKE imaa_t.imaa006,
   b_imaa006_desc LIKE type_t.chr80,
      b_imaa010 LIKE imaa_t.imaa010,
   b_imaa010_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success         LIKE type_t.num5
DEFINE g_con             LIKE type_t.chr1
DEFINE g_flag            LIKE type_t.chr1

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_m20001      STRING            
   DEFINE g_d_idx_m20001    LIKE type_t.num5   
   DEFINE g_d_cnt_m20001    LIKE type_t.num5   
   DEFINE g_imaa001_d       LIKE imaa_t.imaa001
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   #2015/03/02 by stellar add ----- (S)
   TYPE type_g_imak_d        RECORD
            imak001       LIKE imak_t.imak001,
            imak002       LIKE imak_t.imak002,
            imak002_desc  LIKE type_t.chr500,
            imak003       LIKE imak_t.imak003,
            imak003_desc  LIKE type_t.chr500
                          END RECORD

   DEFINE global_g_imak_d    DYNAMIC ARRAY OF type_g_imak_d
   #2015/03/02 by stellar add ----- (E)
END GLOBALS
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
DEFINE g_field              STRING
DEFINE ga_field             DYNAMIC ARRAY OF VARCHAR(500)   #2015/06/30 by stellar add
#160805-00028#1 160811 by lori add---(S)
DEFINE g_imec_1             DYNAMIC ARRAY OF RECORD
          l_sel_1          LIKE type_t.chr1,
          imec003_1        LIKE imec_t.imec003,
          imec003_1_desc   LIKE imecl_t.imecl005
          
                            END RECORD

DEFINE g_imec_2             DYNAMIC ARRAY OF RECORD
          l_sel_2          LIKE type_t.chr1,
          imec003_2        LIKE imec_t.imec003,
          imec003_2_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_3             DYNAMIC ARRAY OF RECORD
          l_sel_3          LIKE type_t.chr1,
          imec003_3        LIKE imec_t.imec003,
          imec003_3_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_4             DYNAMIC ARRAY OF RECORD
          l_sel_4          LIKE type_t.chr1,
          imec003_4        LIKE imec_t.imec003,
          imec003_4_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_5             DYNAMIC ARRAY OF RECORD
          l_sel_5          LIKE type_t.chr1,
          imec003_5        LIKE imec_t.imec003,
          imec003_5_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_6             DYNAMIC ARRAY OF RECORD
          l_sel_6          LIKE type_t.chr1,
          imec003_6        LIKE imec_t.imec003,
          imec003_6_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_7             DYNAMIC ARRAY OF RECORD
          l_sel_7          LIKE type_t.chr1,
          imec003_7        LIKE imec_t.imec003,
          imec003_7_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_8             DYNAMIC ARRAY OF RECORD
          l_sel_8          LIKE type_t.chr1,
          imec003_8        LIKE imec_t.imec003,
          imec003_8_desc   LIKE imecl_t.imecl005
                            END RECORD
                            
DEFINE g_imec_9             DYNAMIC ARRAY OF RECORD
          l_sel_9          LIKE type_t.chr1,
          imec003_9        LIKE imec_t.imec003,
          imec003_9_desc   LIKE imecl_t.imecl005
                            END RECORD

DEFINE g_imec_10            DYNAMIC ARRAY OF RECORD
          l_sel_10         LIKE type_t.chr1,
          imec003_10       LIKE imec_t.imec003,
          imec003_10_desc  LIKE imecl_t.imecl005
                            END RECORD
                            
DEFINE g_imeb               DYNAMIC ARRAY OF RECORD
          imeb002      LIKE imeb_t.imeb002, 
          imeb004      LIKE imeb_t.imeb004, 
          oocql004     LIKE oocql_t.oocql004
                            END RECORD
                            
DEFINE g_tmp1               DYNAMIC ARRAY OF RECORD
          seq           LIKE type_t.num5,      #臨時表項次
          spec_seq      LIKE imeb_t.imeb002,   #特徵值項次
          spec          LIKE imas_t.imas002,   #一維:特徵值類型/二維:特徵值
          spec_desc     LIKE oocql_t.oocql004  #一維:特徵值類型說明/二維:特徵值說明
                            END RECORD      

DEFINE g_tmp2               DYNAMIC ARRAY OF RECORD
          seq           LIKE type_t.num5,      #臨時表項次
          spec_seq      LIKE imeb_t.imeb002,   #特徵值項次
          spec          LIKE imas_t.imas002,   #一維:特徵值類型/二維:特徵值
          spec_desc     LIKE oocql_t.oocql004  #一維:特徵值類型說明/二維:特徵值說明
                            END RECORD  
                            
DEFINE g_imas_d             DYNAMIC ARRAY OF RECORD   
          imas003_1        LIKE imas_t.imas003,
          imas003_1_desc   LIKE oocql_t.oocql004,
          imas003_2        LIKE imas_t.imas003,
          imas003_2_desc   LIKE oocql_t.oocql004,
          imas003_3        LIKE imas_t.imas003,
          imas003_3_desc   LIKE oocql_t.oocql004,
          imas003_4        LIKE imas_t.imas003,
          imas003_4_desc   LIKE oocql_t.oocql004,
          imas003_5        LIKE imas_t.imas003,
          imas003_5_desc   LIKE oocql_t.oocql004,
          imas003_6        LIKE imas_t.imas003,
          imas003_6_desc   LIKE oocql_t.oocql004,
          imas003_7        LIKE imas_t.imas003,
          imas003_7_desc   LIKE oocql_t.oocql004,
          imas003_8        LIKE imas_t.imas003,
          imas003_8_desc   LIKE oocql_t.oocql004,
          imas003_9        LIKE imas_t.imas003,
          imas003_9_desc   LIKE oocql_t.oocql004,
          imas003_10       LIKE imas_t.imas003,
          imas003_11       LIKE imas_t.imas003,
          imas003_12       LIKE imas_t.imas003,
          imas003_13       LIKE imas_t.imas003,
          imas003_14       LIKE imas_t.imas003,
          imas003_15       LIKE imas_t.imas003,
          imas003_16       LIKE imas_t.imas003,
          imas003_17       LIKE imas_t.imas003,
          imas003_18       LIKE imas_t.imas003,
          imas003_19       LIKE imas_t.imas003,
          imas003_20       LIKE imas_t.imas003
                            END RECORD    
                            
DEFINE gdig_curr ui.Dialog   
DEFINE g_imas_flag         LIKE type_t.num5   #是否異動imas_t
DEFINE g_imaa014_flag      LIKE type_t.num5   #是否有更新主條碼
#160805-00028#1 160811 by lori add---(E)                            
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imaa_m          type_g_imaa_m
DEFINE g_imaa_m_t        type_g_imaa_m
DEFINE g_imaa_m_o        type_g_imaa_m
DEFINE g_imaa_m_mask_o   type_g_imaa_m #轉換遮罩前資料
DEFINE g_imaa_m_mask_n   type_g_imaa_m #轉換遮罩後資料
 
   DEFINE g_imaa001_t LIKE imaa_t.imaa001
 
 
DEFINE g_imaj_d          DYNAMIC ARRAY OF type_g_imaj_d
DEFINE g_imaj_d_t        type_g_imaj_d
DEFINE g_imaj_d_o        type_g_imaj_d
DEFINE g_imaj_d_mask_o   DYNAMIC ARRAY OF type_g_imaj_d #轉換遮罩前資料
DEFINE g_imaj_d_mask_n   DYNAMIC ARRAY OF type_g_imaj_d #轉換遮罩後資料
DEFINE g_imaj2_d          DYNAMIC ARRAY OF type_g_imaj2_d
DEFINE g_imaj2_d_t        type_g_imaj2_d
DEFINE g_imaj2_d_o        type_g_imaj2_d
DEFINE g_imaj2_d_mask_o   DYNAMIC ARRAY OF type_g_imaj2_d #轉換遮罩前資料
DEFINE g_imaj2_d_mask_n   DYNAMIC ARRAY OF type_g_imaj2_d #轉換遮罩後資料
DEFINE g_imaj3_d          DYNAMIC ARRAY OF type_g_imaj3_d
DEFINE g_imaj3_d_t        type_g_imaj3_d
DEFINE g_imaj3_d_o        type_g_imaj3_d
DEFINE g_imaj3_d_mask_o   DYNAMIC ARRAY OF type_g_imaj3_d #轉換遮罩前資料
DEFINE g_imaj3_d_mask_n   DYNAMIC ARRAY OF type_g_imaj3_d #轉換遮罩後資料
DEFINE g_imaj4_d          DYNAMIC ARRAY OF type_g_imaj4_d
DEFINE g_imaj4_d_t        type_g_imaj4_d
DEFINE g_imaj4_d_o        type_g_imaj4_d
DEFINE g_imaj4_d_mask_o   DYNAMIC ARRAY OF type_g_imaj4_d #轉換遮罩前資料
DEFINE g_imaj4_d_mask_n   DYNAMIC ARRAY OF type_g_imaj4_d #轉換遮罩後資料
DEFINE g_imaj5_d          DYNAMIC ARRAY OF type_g_imaj5_d
DEFINE g_imaj5_d_t        type_g_imaj5_d
DEFINE g_imaj5_d_o        type_g_imaj5_d
DEFINE g_imaj5_d_mask_o   DYNAMIC ARRAY OF type_g_imaj5_d #轉換遮罩前資料
DEFINE g_imaj5_d_mask_n   DYNAMIC ARRAY OF type_g_imaj5_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      imaal001 LIKE imaal_t.imaal001,
      imaal003 LIKE imaal_t.imaal003,
      imaal004 LIKE imaal_t.imaal004,
      imaal005 LIKE imaal_t.imaal005
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
 
 
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
 
{<section id="aslm200.main" >}
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
   CALL cl_ap_init("asl","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_auto_item_desc_cre_tmp_table() RETURNING l_success
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   CALL s_aimm200_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imaa001,imaa002,'','','',imaa009,'',imaa003,'',imaa004,imaa005,'',imaa006, 
       '',imaa010,'',imaastus,imaa126,'',imaa127,'',imaa131,'',imaa128,'',imaa129,'',imaa130,imaa132, 
       '',imaa133,'',imaa134,'',imaa135,'',imaa136,'',imaa137,'',imaa138,'',imaa139,'',imaa140,'',imaa141, 
       '',imaaownid,'',imaaowndp,'',imaacrtid,'',imaacrtdp,'',imaacrtdt,imaamodid,'',imaamoddt,imaacnfid, 
       '',imaacnfdt,imaa011,imaa012,imaa013,imaa014,imaa100,imaa109,imaa154,imaa155,imaa156,imaa116, 
       imaa158,imaa143,'',imaa142,'',imaa108,imaa110,imaa111,imaa112,imaa121,imaa124,'',imaa016,imaa017, 
       imaa018,'',imaa159,imaa160,imaa019,imaa020,imaa021,imaa022,'',imaa023,imaa024,imaa025,imaa026, 
       imaa027,imaa028,imaa029,'',imaa030,imaa031,imaa032,'',imaa033,imaa034,imaa035,imaa036,imaa037, 
       imaa043,imaa038,imaa039,'',imaa040,imaa041,imaa042,imaa044,'',imaa122,'',imaa045,'',imaa123,'', 
       ''", 
                      " FROM imaa_t",
                      " WHERE imaaent= ? AND imaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imaa001,t0.imaa002,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005,t0.imaa006, 
       t0.imaa010,t0.imaastus,t0.imaa126,t0.imaa127,t0.imaa131,t0.imaa128,t0.imaa129,t0.imaa130,t0.imaa132, 
       t0.imaa133,t0.imaa134,t0.imaa135,t0.imaa136,t0.imaa137,t0.imaa138,t0.imaa139,t0.imaa140,t0.imaa141, 
       t0.imaaownid,t0.imaaowndp,t0.imaacrtid,t0.imaacrtdp,t0.imaacrtdt,t0.imaamodid,t0.imaamoddt,t0.imaacnfid, 
       t0.imaacnfdt,t0.imaa011,t0.imaa012,t0.imaa013,t0.imaa014,t0.imaa100,t0.imaa109,t0.imaa154,t0.imaa155, 
       t0.imaa156,t0.imaa116,t0.imaa158,t0.imaa143,t0.imaa142,t0.imaa108,t0.imaa110,t0.imaa111,t0.imaa112, 
       t0.imaa121,t0.imaa124,t0.imaa016,t0.imaa017,t0.imaa018,t0.imaa159,t0.imaa160,t0.imaa019,t0.imaa020, 
       t0.imaa021,t0.imaa022,t0.imaa023,t0.imaa024,t0.imaa025,t0.imaa026,t0.imaa027,t0.imaa028,t0.imaa029, 
       t0.imaa030,t0.imaa031,t0.imaa032,t0.imaa033,t0.imaa034,t0.imaa035,t0.imaa036,t0.imaa037,t0.imaa043, 
       t0.imaa038,t0.imaa039,t0.imaa040,t0.imaa041,t0.imaa042,t0.imaa044,t0.imaa122,t0.imaa045,t0.imaa123, 
       t1.rtaxl003 ,t2.oocql004 ,t3.imeal003 ,t4.oocal003 ,t5.oocql004 ,t6.oocql004 ,t7.oocql004 ,t8.oocql004 , 
       t9.oocql004 ,t10.oocql004 ,t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.oocql004 ,t15.oocql004 , 
       t16.oocql004 ,t17.oocql004 ,t18.oocql004 ,t19.oocql004 ,t20.oocql004 ,t21.ooag011 ,t22.ooefl003 , 
       t23.ooag011 ,t24.ooefl003 ,t25.ooag011 ,t26.ooag011 ,t27.dbbal003 ,t28.ooefl003 ,t29.oodbl004 , 
       t30.oocal003 ,t31.oocal003 ,t32.oocal003 ,t33.oocal003 ,t34.oocql004 ,t35.oocgl003",
               " FROM imaa_t t0",
                              " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.imaa009 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='200' AND t2.oocql002=t0.imaa003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t3 ON t3.imealent="||g_enterprise||" AND t3.imeal001=t0.imaa005 AND t3.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imaa006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='210' AND t5.oocql002=t0.imaa010 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2002' AND t6.oocql002=t0.imaa126 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2003' AND t7.oocql002=t0.imaa127 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2001' AND t8.oocql002=t0.imaa131 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='2004' AND t9.oocql002=t0.imaa128 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='2005' AND t10.oocql002=t0.imaa129 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='2006' AND t11.oocql002=t0.imaa132 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='2007' AND t12.oocql002=t0.imaa133 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='2008' AND t13.oocql002=t0.imaa134 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t14 ON t14.oocqlent="||g_enterprise||" AND t14.oocql001='2009' AND t14.oocql002=t0.imaa135 AND t14.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t15 ON t15.oocqlent="||g_enterprise||" AND t15.oocql001='2010' AND t15.oocql002=t0.imaa136 AND t15.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='2011' AND t16.oocql002=t0.imaa137 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent="||g_enterprise||" AND t17.oocql001='2012' AND t17.oocql002=t0.imaa138 AND t17.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='2013' AND t18.oocql002=t0.imaa139 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='2014' AND t19.oocql002=t0.imaa140 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t20 ON t20.oocqlent="||g_enterprise||" AND t20.oocql001='2015' AND t20.oocql002=t0.imaa141 AND t20.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t21 ON t21.ooagent="||g_enterprise||" AND t21.ooag001=t0.imaaownid  ",
               " LEFT JOIN ooefl_t t22 ON t22.ooeflent="||g_enterprise||" AND t22.ooefl001=t0.imaaowndp AND t22.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t23 ON t23.ooagent="||g_enterprise||" AND t23.ooag001=t0.imaacrtid  ",
               " LEFT JOIN ooefl_t t24 ON t24.ooeflent="||g_enterprise||" AND t24.ooefl001=t0.imaacrtdp AND t24.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t25 ON t25.ooagent="||g_enterprise||" AND t25.ooag001=t0.imaamodid  ",
               " LEFT JOIN ooag_t t26 ON t26.ooagent="||g_enterprise||" AND t26.ooag001=t0.imaacnfid  ",
               " LEFT JOIN dbbal_t t27 ON t27.dbbalent="||g_enterprise||" AND t27.dbbal001=t0.imaa143 AND t27.dbbal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t28 ON t28.ooeflent="||g_enterprise||" AND t28.ooefl001=t0.imaa142 AND t28.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oodbl_t t29 ON t29.oodblent="||g_enterprise||" AND t29.oodbl002=t0.imaa124 AND t29.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t30 ON t30.oocalent="||g_enterprise||" AND t30.oocal001=t0.imaa018 AND t30.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t31 ON t31.oocalent="||g_enterprise||" AND t31.oocal001=t0.imaa022 AND t31.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t32 ON t32.oocalent="||g_enterprise||" AND t32.oocal001=t0.imaa029 AND t32.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t33 ON t33.oocalent="||g_enterprise||" AND t33.oocal001=t0.imaa032 AND t33.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t34 ON t34.oocqlent="||g_enterprise||" AND t34.oocql001='2000' AND t34.oocql002=t0.imaa122 AND t34.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t35 ON t35.oocglent="||g_enterprise||" AND t35.oocgl001=t0.imaa045 AND t35.oocgl002='"||g_dlang||"' ",
 
               " WHERE t0.imaaent = " ||g_enterprise|| " AND t0.imaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aslm200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslm200 WITH FORM cl_ap_formpath("asl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aslm200_init()   
 
      #進入選單 Menu (="N")
      CALL aslm200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aslm200
      
   END IF 
   
   CLOSE aslm200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_auto_item_desc_drop_tmp_table()
   CALL s_aooi390_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aslm200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aslm200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('imaastus','50','N,Y,X')
 
      CALL cl_set_combo_scc('imaa004','1001') 
   CALL cl_set_combo_scc('imaa011','1002') 
   CALL cl_set_combo_scc('imaa100','2003') 
   CALL cl_set_combo_scc('imaa109','2004') 
   CALL cl_set_combo_scc('imaa155','6940') 
   CALL cl_set_combo_scc('imaa156','6941') 
   CALL cl_set_combo_scc('imaa108','2002') 
   CALL cl_set_combo_scc('imaa034','1003') 
   CALL cl_set_combo_scc('imaa044','1004') 
   CALL cl_set_combo_scc('imam002','1006') 
   CALL cl_set_combo_scc('imay002','2003') 
   CALL cl_set_combo_scc('imay018','6749') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_imaa004','1001') 
   CALL aslm200_crt_tmp()
   
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aim", "aimm200_01"), "grid_feature", "Table", "s_detail1_aimm200_01")
   CALL cl_set_combo_scc_part('imaa109','6553','1,4,5')   #add--160511-00040#3 By shiun
   CALL cl_set_combo_scc('imay002','2003')
   #160801-00017#3 20160804 add by beckxie---S
   CALL aslm200_set_comp_visible_b()
   CALL aslm200_set_comp_no_visible_b()
   #160801-00017#3 20160804 add by beckxie---E
   #end add-point
   
   #初始化搜尋條件
   CALL aslm200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aslm200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aslm200_ui_dialog()
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
   DEFINE l_n       LIKE type_t.num5 
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
            CALL aslm200_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imaa_m.* TO NULL
         CALL g_imaj_d.clear()
         CALL g_imaj2_d.clear()
         CALL g_imaj3_d.clear()
         CALL g_imaj4_d.clear()
         CALL g_imaj5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aslm200_init()
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
               
               CALL aslm200_fetch('') # reload data
               LET l_ac = 1
               CALL aslm200_ui_detailshow() #Setting the current row 
         
               CALL aslm200_idx_chk()
               #NEXT FIELD imaj002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imaj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aslm200_idx_chk()
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
               CALL aslm200_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_imaj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aslm200_idx_chk()
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
               CALL aslm200_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imaj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aslm200_idx_chk()
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
               CALL aslm200_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imaj4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aslm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL aslm200_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imaj5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aslm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL aslm200_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
 
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160805-00028#1 160812 by lori add---(S)
         DISPLAY ARRAY g_imas_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
              ##顯示單身筆數
              CALL aslm200_idx_chk()
              #確定當下選擇的筆數
              LET l_ac = DIALOG.getCurrentRow("s_detail6")
              LET g_detail_idx = l_ac
              LET g_detail_idx_list[6] = l_ac
              CALL g_idx_group.addAttribute("'6',",l_ac)
               
            BEFORE DISPLAY
               ##如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL aslm200_idx_chk()
         END DISPLAY
         #160805-00028#1 160812 by lori add---(E)
   
         #嵌入子單身顯示
         SUBDIALOG aim_aimm200_01.aimm200_01_display
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aslm200_browser_fill("")
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
               CALL aslm200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aslm200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aslm200_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.ensureFieldVisible("imaa_t.imaa011")
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aslm200_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aslm200_set_act_visible()   
            CALL aslm200_set_act_no_visible()
            IF NOT (g_imaa_m.imaa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                                  " imaa001 = '", g_imaa_m.imaa001, "' "
 
               #填到對應位置
               CALL aslm200_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imaj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imal_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imam_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imao_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imay_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aslm200_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imaj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imal_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imam_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imao_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imay_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aslm200_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aslm200_fetch("F")
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
               CALL aslm200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aslm200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aslm200_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aslm200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aslm200_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aslm200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aslm200_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aslm200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aslm200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aslm200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aslm200_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_imaj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imaj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_imaj3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_imaj4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_imaj5_d)
                  LET g_export_id[5]   = "s_detail5"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #2015/03/02 by stellar add ----- (S)
                  LET g_export_node[1] = base.typeInfo.create(g_imaj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imaj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(global_g_imak_d)
                  LET g_export_id[3]   = "s_detail1_aimm200_01"
                  LET g_export_node[4] = base.typeInfo.create(g_imaj3_d)
                  LET g_export_id[4]   = "s_detail3"
                  LET g_export_node[5] = base.typeInfo.create(g_imaj4_d)
                  LET g_export_id[5]   = "s_detail4"
                  #2015/03/02 by stellar add ----- (E)
                  
                  LET g_export_node[6] = base.typeInfo.create(g_imas_d)   #160805-00028#1 160812 by lori add
                  LET g_export_id[6]   = "s_detail6"                      #160805-00028#1 160812 by lori add
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
               NEXT FIELD imaj002
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
               CALL aslm200_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL gfrm_curr.ensureFieldVisible(g_field)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aslm200_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm220
            LET g_action_choice="open_aimm220"
            IF cl_auth_chk_act("open_aimm220") THEN
               
               #add-point:ON ACTION open_aimm220 name="menu.open_aimm220"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm220'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js) 
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimp400
            LET g_action_choice="open_aimp400"
            IF cl_auth_chk_act("open_aimp400") THEN
               
               #add-point:ON ACTION open_aimp400 name="menu.open_aimp400"
               #2015/06/30 by stellar add ----- (S)
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog = 'aimp400'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify(la_param )
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #2015/06/30 by stellar add ----- (E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ljzx
            LET g_action_choice="open_ljzx"
            IF cl_auth_chk_act("open_ljzx") THEN
               
               #add-point:ON ACTION open_ljzx name="menu.open_ljzx"
                              CALL cl_set_comp_entry("imac002,imac003",TRUE)
               INPUT BY NAME g_imaa_m.imac002,g_imaa_m.imac003
                  BEFORE INPUT
                  AFTER INPUT
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM imac_t 
                      WHERE imacent = g_enterprise AND imac001 = g_imaa_m.imaa001
                     IF l_n = 0 THEN
                        INSERT INTO imac_t (imacent,imac001,imac002,imac003) VALUES (g_enterprise,g_imaa_m.imaa001,g_imaa_m.imac002,g_imaa_m.imac003)  
                     ELSE                        
                        UPDATE imac_t SET imac002 = g_imaa_m.imac002,
                                          imac003 = g_imaa_m.imac003
                        WHERE imacent = g_enterprise AND imac001 = g_imaa_m.imaa001
                     END IF                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "imac_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                     END IF 
               END INPUT
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cggd
            LET g_action_choice="open_cggd"
            IF cl_auth_chk_act("open_cggd") THEN
               
               #add-point:ON ACTION open_cggd name="menu.open_cggd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm214'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)                                            
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cpgd
            LET g_action_choice="open_cpgd"
            IF cl_auth_chk_act("open_cpgd") THEN
               
               #add-point:ON ACTION open_cpgd name="menu.open_cpgd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm211'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)  
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_kcgd
            LET g_action_choice="open_kcgd"
            IF cl_auth_chk_act("open_kcgd") THEN
               
               #add-point:ON ACTION open_kcgd name="menu.open_kcgd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm212'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)                     
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pgjd
            LET g_action_choice="open_pgjd"
            IF cl_auth_chk_act("open_pgjd") THEN
               
               #add-point:ON ACTION open_pgjd name="menu.open_pgjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm206'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xsjd
            LET g_action_choice="open_xsjd"
            IF cl_auth_chk_act("open_xsjd") THEN
               
               #add-point:ON ACTION open_xsjd name="menu.open_xsjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm203'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)                    
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimm221
            LET g_action_choice="aimm221"
            IF cl_auth_chk_act("aimm221") THEN
               
               #add-point:ON ACTION aimm221 name="menu.aimm221"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm221'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aslm200_delete()
               #add-point:ON ACTION delete name="menu.delete"
               CALL gfrm_curr.ensureFieldVisible("imaa_t.imaa011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aslm200_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL gfrm_curr.ensureFieldVisible("imaa_t.imaa011")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu.open_aimm210"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm210'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cpjd
            LET g_action_choice="open_cpjd"
            IF cl_auth_chk_act("open_cpjd") THEN
               
               #add-point:ON ACTION open_cpjd name="menu.open_cpjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm201'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="menu.open_s_carry_query"
               #2015/06/30 by stellar add ----- (S)
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET ga_field[1] = g_imaa_m.imaa001
                  CALL s_carry_query('1',ga_field)
               END IF
               #2015/06/30 by stellar add ----- (E)
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aslm200_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimm200_01
            LET g_action_choice="aimm200_01"
            IF cl_auth_chk_act("aimm200_01") THEN
               
               #add-point:ON ACTION aimm200_01 name="menu.aimm200_01"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xsgd
            LET g_action_choice="open_xsgd"
            IF cl_auth_chk_act("open_xsgd") THEN
               
               #add-point:ON ACTION open_xsgd name="menu.open_xsgd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm213'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aslm200_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.ensureFieldVisible("imaa_t.imaa011")
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cbjd
            LET g_action_choice="open_cbjd"
            IF cl_auth_chk_act("open_cbjd") THEN
               
               #add-point:ON ACTION open_cbjd name="menu.open_cbjd"
                #150520 by whitney add start
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm207'
                  LET la_param.param[1] = g_site
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
                #150520 by whitney add end
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_sggd
            LET g_action_choice="open_sggd"
            IF cl_auth_chk_act("open_sggd") THEN
               
               #add-point:ON ACTION open_sggd name="menu.open_sggd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm215'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_next
            LET g_action_choice="image_next"
               
               #add-point:ON ACTION image_next name="menu.image_next"
               DISPLAY cl_doc_set_pic_seq(TRUE) TO ffimage
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm208
            LET g_action_choice="open_aimm208"
            IF cl_auth_chk_act("open_aimm208") THEN
               
               #add-point:ON ACTION open_aimm208 name="menu.open_aimm208"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm208'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_kcjd
            LET g_action_choice="open_kcjd"
            IF cl_auth_chk_act("open_kcjd") THEN
               
               #add-point:ON ACTION open_kcjd name="menu.open_kcjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm202'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)     
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pggd
            LET g_action_choice="open_pggd"
            IF cl_auth_chk_act("open_pggd") THEN
               
               #add-point:ON ACTION open_pggd name="menu.open_pggd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm216'
                  LET la_param.param[1] = ' '
                  LET la_param.param[2] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_previous
            LET g_action_choice="image_previous"
               
               #add-point:ON ACTION image_previous name="menu.image_previous"
               DISPLAY cl_doc_set_pic_seq(FALSE) TO ffimage
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimi190
            LET g_action_choice="open_aimi190"
            IF cl_auth_chk_act("open_aimi190") THEN
               
               #add-point:ON ACTION open_aimi190 name="menu.open_aimi190"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimi190'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun_wait(ls_js)
               END IF    
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aslm200_s01
            LET g_action_choice="open_aslm200_s01"
            IF cl_auth_chk_act("open_aslm200_s01") THEN
               
               #add-point:ON ACTION open_aslm200_s01 name="menu.open_aslm200_s01"
               LET g_imas_flag = FALSE
               CALL aslm200_open_alsm200_s01()
               IF g_imaa014_flag THEN
                  CALL aslm200_ui_headershow()
               ELSE
                  CALL aslm200_b_fill()               
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_cgjd
            LET g_action_choice="open_cgjd"
            IF cl_auth_chk_act("open_cgjd") THEN
               
               #add-point:ON ACTION open_cgjd name="menu.open_cgjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm204'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)   
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_sgjd
            LET g_action_choice="open_sgjd"
            IF cl_auth_chk_act("open_sgjd") THEN
               
               #add-point:ON ACTION open_sgjd name="menu.open_sgjd"
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET la_param.prog = 'aimm205'
                  LET la_param.param[1] = g_imaa_m.imaa001
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)         
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu.prog_imaa009"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu.prog_imaa003"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aslm200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aslm200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aslm200_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="aslm200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aslm200_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      CALL aimm200_01_clear_detail()   #清除嵌入子單身
   END IF
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
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ",
                      " ",
                      " LEFT JOIN imaj_t ON imajent = imaaent AND imaa001 = imaj001 ", "  ",
                      #add-point:browser_fill段sql(imaj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN imal_t ON imalent = imaaent AND imaa001 = imal001", "  ",
                      #add-point:browser_fill段sql(imal_t1) name="browser_fill.cnt.join.imal_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imam_t ON imament = imaaent AND imaa001 = imam001", "  ",
                      #add-point:browser_fill段sql(imam_t1) name="browser_fill.cnt.join.imam_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imao_t ON imaoent = imaaent AND imaa001 = imao001", "  ",
                      #add-point:browser_fill段sql(imao_t1) name="browser_fill.cnt.join.imao_t1"
                      " LEFT JOIN imac_t ON imacent = imaaent AND imac001 = imaa001"," ",
                      #end add-point
 
                      " LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001", "  ",
                      #add-point:browser_fill段sql(imay_t1) name="browser_fill.cnt.join.imay_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN imaal_t ON imaalent = "||g_enterprise||" AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE imaaent = " ||g_enterprise|| " AND imajent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imaa001 ",
                      " FROM imaa_t ", 
                      "  ",
                      "  LEFT JOIN imaal_t ON imaalent = "||g_enterprise||" AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ",
                      " WHERE imaaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   IF g_wc2 <> " 1=1" THEN
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE imaa001 ",
                      " FROM imaa_t ",
                      "  LEFT JOIN imac_t ON imacent = imaaent AND imac001 = imaa001"," ",
                      "  LEFT JOIN imaal_t ON imaalent = '"||g_enterprise||"' AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ",
                      " WHERE imaaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("imaa_t")
   END IF
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
      INITIALIZE g_imaa_m.* TO NULL
      CALL g_imaj_d.clear()        
      CALL g_imaj2_d.clear() 
      CALL g_imaj3_d.clear() 
      CALL g_imaj4_d.clear() 
      CALL g_imaj5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imaa001,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005,t0.imaa006,t0.imaa010 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005, 
          t0.imaa006,t0.imaa010,t1.imaal003 ,t2.rtaxl003 ,t3.oocql004 ,t4.imeal003 ,t5.oocal003 ,t6.oocql004 ", 
 
                  " FROM imaa_t t0",
                  "  ",
                  "  LEFT JOIN imaj_t ON imajent = imaaent AND imaa001 = imaj001 ", "  ", 
                  #add-point:browser_fill段sql(imaj_t1) name="browser_fill.join.imaj_t1"
                  
                  #end add-point
                  "  LEFT JOIN imal_t ON imalent = imaaent AND imaa001 = imal001", "  ", 
                  #add-point:browser_fill段sql(imal_t1) name="browser_fill.join.imal_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imam_t ON imament = imaaent AND imaa001 = imam001", "  ", 
                  #add-point:browser_fill段sql(imam_t1) name="browser_fill.join.imam_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imao_t ON imaoent = imaaent AND imaa001 = imao001", "  ", 
                  #add-point:browser_fill段sql(imao_t1) name="browser_fill.join.imao_t1"
               " LEFT JOIN imac_t ON imacent = imaaent AND imac001 = imaa001"," ",
                  #end add-point
 
                  "  LEFT JOIN imay_t ON imayent = imaaent AND imaa001 = imay001", "  ", 
                  #add-point:browser_fill段sql(imay_t1) name="browser_fill.join.imay_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.imaa009 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='200' AND t3.oocql002=t0.imaa003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t4 ON t4.imealent="||g_enterprise||" AND t4.imeal001=t0.imaa005 AND t4.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.imaa006 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='210' AND t6.oocql002=t0.imaa010 AND t6.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imaastus,t0.imaa001,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005, 
          t0.imaa006,t0.imaa010,t1.imaal003 ,t2.rtaxl003 ,t3.oocql004 ,t4.imeal003 ,t5.oocal003 ,t6.oocql004 ", 
 
                  " FROM imaa_t t0",
                  "  ",
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.imaa009 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='200' AND t3.oocql002=t0.imaa003 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t4 ON t4.imealent="||g_enterprise||" AND t4.imeal001=t0.imaa005 AND t4.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.imaa006 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='210' AND t6.oocql002=t0.imaa010 AND t6.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.imaaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
       
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
   
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imaa001,g_browser[g_cnt].b_imaa009, 
          g_browser[g_cnt].b_imaa003,g_browser[g_cnt].b_imaa004,g_browser[g_cnt].b_imaa005,g_browser[g_cnt].b_imaa006, 
          g_browser[g_cnt].b_imaa010,g_browser[g_cnt].b_imaa001_desc,g_browser[g_cnt].b_imaa009_desc, 
          g_browser[g_cnt].b_imaa003_desc,g_browser[g_cnt].b_imaa005_desc,g_browser[g_cnt].b_imaa006_desc, 
          g_browser[g_cnt].b_imaa010_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_imaa001
      CALL ap_ref_array2(g_ref_fields," SELECT imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_browser[g_cnt].b_imaa001_desc_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_imaa001_desc_desc
         #end add-point
      
         #遮罩相關處理
         CALL aslm200_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_imaa001) THEN
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
 
{<section id="aslm200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aslm200_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001   
 
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
   CALL aslm200_imaa_t_mask()
   CALL aslm200_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aslm200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aslm200_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aslm200_ui_browser_refresh()
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
      IF g_browser[l_i].b_imaa001 = g_imaa_m.imaa001 
 
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
 
{<section id="aslm200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aslm200_construct()
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
   INITIALIZE g_imaa_m.* TO NULL
   CALL g_imaj_d.clear()        
   CALL g_imaj2_d.clear() 
   CALL g_imaj3_d.clear() 
   CALL g_imaj4_d.clear() 
   CALL g_imaj5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL aimm200_01_clear_detail()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON imaa001,imaa002,imaal003,imaal004,imaal005,imaa009,imaa003,imaa004,imaa005, 
          imaa006,imaa010,imaastus,imaa126,imaa127,imaa131,imaa128,imaa129,imaa130,imaa132,imaa133,imaa134, 
          imaa135,imaa136,imaa137,imaa138,imaa139,imaa140,imaa141,imaaownid,imaaowndp,imaacrtid,imaacrtdp, 
          imaacrtdt,imaamodid,imaamoddt,imaacnfid,imaacnfdt,imaa011,imaa012,imaa013,imaa014,imaa100, 
          imaa109,imaa154,imaa155,imaa156,imaa116,imaa158,imaa143,imaa142,imaa108,imaa110,imaa111,imaa112, 
          imaa121,imaa124,imaa016,imaa017,imaa018,imaa159,imaa160,imaa019,imaa020,imaa021,imaa022,imaa023, 
          imaa024,imaa025,imaa026,imaa027,imaa028,imaa029,imaa030,imaa031,imaa032,imaa033,imaa034,imaa035, 
          imaa036,imaa037,imaa043,imaa038,imaa039,imaa040,imaa041,imaa042,imaa044,imaa122,imaa045,imaa123, 
          imac002,imac003
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaacrtdt>>----
         AFTER FIELD imaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imaamoddt>>----
         AFTER FIELD imaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imaacnfdt>>----
         AFTER FIELD imaacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上

            NEXT FIELD imaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="construct.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="construct.a.imaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="construct.c.imaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="construct.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="construct.a.imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="construct.c.imaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="construct.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="construct.a.imaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="construct.c.imaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="construct.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="construct.a.imaal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="construct.c.imaal005"
            
            #END add-point
 
 
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
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上

            NEXT FIELD imaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="construct.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="construct.a.imaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="construct.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="construct.c.imaa005"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa005  #顯示到畫面上

            NEXT FIELD imaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="construct.b.imaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="construct.a.imaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="construct.c.imaa006"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上

            NEXT FIELD imaa006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="construct.b.imaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="construct.a.imaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="construct.c.imaa010"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上

            NEXT FIELD imaa010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="construct.b.imaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="construct.a.imaa010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaastus
            #add-point:BEFORE FIELD imaastus name="construct.b.imaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaastus
            
            #add-point:AFTER FIELD imaastus name="construct.a.imaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaastus
            #add-point:ON ACTION controlp INFIELD imaastus name="construct.c.imaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD imaa126 name="construct.c.imaa126"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上

            NEXT FIELD imaa126                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa126
            #add-point:BEFORE FIELD imaa126 name="construct.b.imaa126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa126
            
            #add-point:AFTER FIELD imaa126 name="construct.a.imaa126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa127
            #add-point:ON ACTION controlp INFIELD imaa127 name="construct.c.imaa127"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2003" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上

            NEXT FIELD imaa127                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa127
            #add-point:BEFORE FIELD imaa127 name="construct.b.imaa127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa127
            
            #add-point:AFTER FIELD imaa127 name="construct.a.imaa127"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa131
            #add-point:ON ACTION controlp INFIELD imaa131 name="construct.c.imaa131"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2001" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa131  #顯示到畫面上

            NEXT FIELD imaa131                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa131
            #add-point:BEFORE FIELD imaa131 name="construct.b.imaa131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa131
            
            #add-point:AFTER FIELD imaa131 name="construct.a.imaa131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa128
            #add-point:ON ACTION controlp INFIELD imaa128 name="construct.c.imaa128"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2004" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa128  #顯示到畫面上

            NEXT FIELD imaa128                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa128
            #add-point:BEFORE FIELD imaa128 name="construct.b.imaa128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa128
            
            #add-point:AFTER FIELD imaa128 name="construct.a.imaa128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa129
            #add-point:ON ACTION controlp INFIELD imaa129 name="construct.c.imaa129"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2005" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa129  #顯示到畫面上

            NEXT FIELD imaa129                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa129
            #add-point:BEFORE FIELD imaa129 name="construct.b.imaa129"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa129
            
            #add-point:AFTER FIELD imaa129 name="construct.a.imaa129"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa130
            #add-point:BEFORE FIELD imaa130 name="construct.b.imaa130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa130
            
            #add-point:AFTER FIELD imaa130 name="construct.a.imaa130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa130
            #add-point:ON ACTION controlp INFIELD imaa130 name="construct.c.imaa130"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="construct.c.imaa132"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2006" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa132  #顯示到畫面上

            NEXT FIELD imaa132                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="construct.b.imaa132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="construct.a.imaa132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa133
            #add-point:ON ACTION controlp INFIELD imaa133 name="construct.c.imaa133"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2007" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa133  #顯示到畫面上

            NEXT FIELD imaa133                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa133
            #add-point:BEFORE FIELD imaa133 name="construct.b.imaa133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa133
            
            #add-point:AFTER FIELD imaa133 name="construct.a.imaa133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa134
            #add-point:ON ACTION controlp INFIELD imaa134 name="construct.c.imaa134"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2008" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa134  #顯示到畫面上

            NEXT FIELD imaa134                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa134
            #add-point:BEFORE FIELD imaa134 name="construct.b.imaa134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa134
            
            #add-point:AFTER FIELD imaa134 name="construct.a.imaa134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa135
            #add-point:ON ACTION controlp INFIELD imaa135 name="construct.c.imaa135"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2009" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa135  #顯示到畫面上

            NEXT FIELD imaa135                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa135
            #add-point:BEFORE FIELD imaa135 name="construct.b.imaa135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa135
            
            #add-point:AFTER FIELD imaa135 name="construct.a.imaa135"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa136
            #add-point:ON ACTION controlp INFIELD imaa136 name="construct.c.imaa136"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2010" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa136  #顯示到畫面上

            NEXT FIELD imaa136                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa136
            #add-point:BEFORE FIELD imaa136 name="construct.b.imaa136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa136
            
            #add-point:AFTER FIELD imaa136 name="construct.a.imaa136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa137
            #add-point:ON ACTION controlp INFIELD imaa137 name="construct.c.imaa137"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2011" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa137  #顯示到畫面上

            NEXT FIELD imaa137                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa137
            #add-point:BEFORE FIELD imaa137 name="construct.b.imaa137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa137
            
            #add-point:AFTER FIELD imaa137 name="construct.a.imaa137"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa138
            #add-point:ON ACTION controlp INFIELD imaa138 name="construct.c.imaa138"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2012" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa138  #顯示到畫面上

            NEXT FIELD imaa138                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa138
            #add-point:BEFORE FIELD imaa138 name="construct.b.imaa138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa138
            
            #add-point:AFTER FIELD imaa138 name="construct.a.imaa138"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa139
            #add-point:ON ACTION controlp INFIELD imaa139 name="construct.c.imaa139"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2013" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa139  #顯示到畫面上

            NEXT FIELD imaa139                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa139
            #add-point:BEFORE FIELD imaa139 name="construct.b.imaa139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa139
            
            #add-point:AFTER FIELD imaa139 name="construct.a.imaa139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa140
            #add-point:ON ACTION controlp INFIELD imaa140 name="construct.c.imaa140"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2014" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa140  #顯示到畫面上

            NEXT FIELD imaa140                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa140
            #add-point:BEFORE FIELD imaa140 name="construct.b.imaa140"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa140
            
            #add-point:AFTER FIELD imaa140 name="construct.a.imaa140"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa141
            #add-point:ON ACTION controlp INFIELD imaa141 name="construct.c.imaa141"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2015" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa141  #顯示到畫面上

            NEXT FIELD imaa141                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa141
            #add-point:BEFORE FIELD imaa141 name="construct.b.imaa141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa141
            
            #add-point:AFTER FIELD imaa141 name="construct.a.imaa141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaaownid
            #add-point:ON ACTION controlp INFIELD imaaownid name="construct.c.imaaownid"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaaownid  #顯示到畫面上

            NEXT FIELD imaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaaownid
            #add-point:BEFORE FIELD imaaownid name="construct.b.imaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaaownid
            
            #add-point:AFTER FIELD imaaownid name="construct.a.imaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaaowndp
            #add-point:ON ACTION controlp INFIELD imaaowndp name="construct.c.imaaowndp"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaaowndp  #顯示到畫面上

            NEXT FIELD imaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaaowndp
            #add-point:BEFORE FIELD imaaowndp name="construct.b.imaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaaowndp
            
            #add-point:AFTER FIELD imaaowndp name="construct.a.imaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaacrtid
            #add-point:ON ACTION controlp INFIELD imaacrtid name="construct.c.imaacrtid"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaacrtid  #顯示到畫面上

            NEXT FIELD imaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtid
            #add-point:BEFORE FIELD imaacrtid name="construct.b.imaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaacrtid
            
            #add-point:AFTER FIELD imaacrtid name="construct.a.imaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaacrtdp
            #add-point:ON ACTION controlp INFIELD imaacrtdp name="construct.c.imaacrtdp"
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaacrtdp  #顯示到畫面上

            NEXT FIELD imaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtdp
            #add-point:BEFORE FIELD imaacrtdp name="construct.b.imaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaacrtdp
            
            #add-point:AFTER FIELD imaacrtdp name="construct.a.imaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacrtdt
            #add-point:BEFORE FIELD imaacrtdt name="construct.b.imaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaamodid
            #add-point:ON ACTION controlp INFIELD imaamodid name="construct.c.imaamodid"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaamodid  #顯示到畫面上

            NEXT FIELD imaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaamodid
            #add-point:BEFORE FIELD imaamodid name="construct.b.imaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaamodid
            
            #add-point:AFTER FIELD imaamodid name="construct.a.imaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaamoddt
            #add-point:BEFORE FIELD imaamoddt name="construct.b.imaamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaacnfid
            #add-point:ON ACTION controlp INFIELD imaacnfid name="construct.c.imaacnfid"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaacnfid  #顯示到畫面上

            NEXT FIELD imaacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacnfid
            #add-point:BEFORE FIELD imaacnfid name="construct.b.imaacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaacnfid
            
            #add-point:AFTER FIELD imaacnfid name="construct.a.imaacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaacnfdt
            #add-point:BEFORE FIELD imaacnfdt name="construct.b.imaacnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa011
            #add-point:BEFORE FIELD imaa011 name="construct.b.imaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa011
            
            #add-point:AFTER FIELD imaa011 name="construct.a.imaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa011
            #add-point:ON ACTION controlp INFIELD imaa011 name="construct.c.imaa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa012
            #add-point:BEFORE FIELD imaa012 name="construct.b.imaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa012
            
            #add-point:AFTER FIELD imaa012 name="construct.a.imaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa012
            #add-point:ON ACTION controlp INFIELD imaa012 name="construct.c.imaa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa013
            #add-point:BEFORE FIELD imaa013 name="construct.b.imaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa013
            
            #add-point:AFTER FIELD imaa013 name="construct.a.imaa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa013
            #add-point:ON ACTION controlp INFIELD imaa013 name="construct.c.imaa013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa014
            #add-point:BEFORE FIELD imaa014 name="construct.b.imaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa014
            
            #add-point:AFTER FIELD imaa014 name="construct.a.imaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa014
            #add-point:ON ACTION controlp INFIELD imaa014 name="construct.c.imaa014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa100
            #add-point:BEFORE FIELD imaa100 name="construct.b.imaa100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa100
            
            #add-point:AFTER FIELD imaa100 name="construct.a.imaa100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa100
            #add-point:ON ACTION controlp INFIELD imaa100 name="construct.c.imaa100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa109
            #add-point:BEFORE FIELD imaa109 name="construct.b.imaa109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa109
            
            #add-point:AFTER FIELD imaa109 name="construct.a.imaa109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa109
            #add-point:ON ACTION controlp INFIELD imaa109 name="construct.c.imaa109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="construct.b.imaa154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            
            #add-point:AFTER FIELD imaa154 name="construct.a.imaa154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="construct.c.imaa154"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa155
            #add-point:BEFORE FIELD imaa155 name="construct.b.imaa155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa155
            
            #add-point:AFTER FIELD imaa155 name="construct.a.imaa155"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa155
            #add-point:ON ACTION controlp INFIELD imaa155 name="construct.c.imaa155"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa156
            #add-point:BEFORE FIELD imaa156 name="construct.b.imaa156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa156
            
            #add-point:AFTER FIELD imaa156 name="construct.a.imaa156"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa156
            #add-point:ON ACTION controlp INFIELD imaa156 name="construct.c.imaa156"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa116
            #add-point:BEFORE FIELD imaa116 name="construct.b.imaa116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa116
            
            #add-point:AFTER FIELD imaa116 name="construct.a.imaa116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa116
            #add-point:ON ACTION controlp INFIELD imaa116 name="construct.c.imaa116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa158
            #add-point:BEFORE FIELD imaa158 name="construct.b.imaa158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa158
            
            #add-point:AFTER FIELD imaa158 name="construct.a.imaa158"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa158
            #add-point:ON ACTION controlp INFIELD imaa158 name="construct.c.imaa158"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa143
            #add-point:ON ACTION controlp INFIELD imaa143 name="construct.c.imaa143"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa143  #顯示到畫面上
            NEXT FIELD imaa143                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa143
            #add-point:BEFORE FIELD imaa143 name="construct.b.imaa143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa143
            
            #add-point:AFTER FIELD imaa143 name="construct.a.imaa143"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa142
            #add-point:ON ACTION controlp INFIELD imaa142 name="construct.c.imaa142"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa142  #顯示到畫面上

            NEXT FIELD imaa142                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa142
            #add-point:BEFORE FIELD imaa142 name="construct.b.imaa142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa142
            
            #add-point:AFTER FIELD imaa142 name="construct.a.imaa142"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa108
            #add-point:BEFORE FIELD imaa108 name="construct.b.imaa108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa108
            
            #add-point:AFTER FIELD imaa108 name="construct.a.imaa108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa108
            #add-point:ON ACTION controlp INFIELD imaa108 name="construct.c.imaa108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa110
            #add-point:BEFORE FIELD imaa110 name="construct.b.imaa110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa110
            
            #add-point:AFTER FIELD imaa110 name="construct.a.imaa110"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa110
            #add-point:ON ACTION controlp INFIELD imaa110 name="construct.c.imaa110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa111
            #add-point:BEFORE FIELD imaa111 name="construct.b.imaa111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa111
            
            #add-point:AFTER FIELD imaa111 name="construct.a.imaa111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa111
            #add-point:ON ACTION controlp INFIELD imaa111 name="construct.c.imaa111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa112
            #add-point:BEFORE FIELD imaa112 name="construct.b.imaa112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa112
            
            #add-point:AFTER FIELD imaa112 name="construct.a.imaa112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa112
            #add-point:ON ACTION controlp INFIELD imaa112 name="construct.c.imaa112"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa121
            #add-point:BEFORE FIELD imaa121 name="construct.b.imaa121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa121
            
            #add-point:AFTER FIELD imaa121 name="construct.a.imaa121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa121
            #add-point:ON ACTION controlp INFIELD imaa121 name="construct.c.imaa121"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa124
            #add-point:ON ACTION controlp INFIELD imaa124 name="construct.c.imaa124"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa124  #顯示到畫面上

            NEXT FIELD imaa124                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa124
            #add-point:BEFORE FIELD imaa124 name="construct.b.imaa124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa124
            
            #add-point:AFTER FIELD imaa124 name="construct.a.imaa124"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa016
            #add-point:BEFORE FIELD imaa016 name="construct.b.imaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa016
            
            #add-point:AFTER FIELD imaa016 name="construct.a.imaa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa016
            #add-point:ON ACTION controlp INFIELD imaa016 name="construct.c.imaa016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa017
            #add-point:BEFORE FIELD imaa017 name="construct.b.imaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa017
            
            #add-point:AFTER FIELD imaa017 name="construct.a.imaa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa017
            #add-point:ON ACTION controlp INFIELD imaa017 name="construct.c.imaa017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa018
            #add-point:ON ACTION controlp INFIELD imaa018 name="construct.c.imaa018"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa018  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imaa018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa018
            #add-point:BEFORE FIELD imaa018 name="construct.b.imaa018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa018
            
            #add-point:AFTER FIELD imaa018 name="construct.a.imaa018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa159
            #add-point:BEFORE FIELD imaa159 name="construct.b.imaa159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa159
            
            #add-point:AFTER FIELD imaa159 name="construct.a.imaa159"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa159
            #add-point:ON ACTION controlp INFIELD imaa159 name="construct.c.imaa159"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa160
            #add-point:BEFORE FIELD imaa160 name="construct.b.imaa160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa160
            
            #add-point:AFTER FIELD imaa160 name="construct.a.imaa160"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa160
            #add-point:ON ACTION controlp INFIELD imaa160 name="construct.c.imaa160"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa019
            #add-point:BEFORE FIELD imaa019 name="construct.b.imaa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa019
            
            #add-point:AFTER FIELD imaa019 name="construct.a.imaa019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa019
            #add-point:ON ACTION controlp INFIELD imaa019 name="construct.c.imaa019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa020
            #add-point:BEFORE FIELD imaa020 name="construct.b.imaa020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa020
            
            #add-point:AFTER FIELD imaa020 name="construct.a.imaa020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa020
            #add-point:ON ACTION controlp INFIELD imaa020 name="construct.c.imaa020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa021
            #add-point:BEFORE FIELD imaa021 name="construct.b.imaa021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa021
            
            #add-point:AFTER FIELD imaa021 name="construct.a.imaa021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa021
            #add-point:ON ACTION controlp INFIELD imaa021 name="construct.c.imaa021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa022
            #add-point:ON ACTION controlp INFIELD imaa022 name="construct.c.imaa022"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '2'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa022  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imaa022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa022
            #add-point:BEFORE FIELD imaa022 name="construct.b.imaa022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa022
            
            #add-point:AFTER FIELD imaa022 name="construct.a.imaa022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa023
            #add-point:BEFORE FIELD imaa023 name="construct.b.imaa023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa023
            
            #add-point:AFTER FIELD imaa023 name="construct.a.imaa023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa023
            #add-point:ON ACTION controlp INFIELD imaa023 name="construct.c.imaa023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa024
            #add-point:ON ACTION controlp INFIELD imaa024 name="construct.c.imaa024"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa024  #顯示到畫面上

            NEXT FIELD imaa024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa024
            #add-point:BEFORE FIELD imaa024 name="construct.b.imaa024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa024
            
            #add-point:AFTER FIELD imaa024 name="construct.a.imaa024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa025
            #add-point:BEFORE FIELD imaa025 name="construct.b.imaa025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa025
            
            #add-point:AFTER FIELD imaa025 name="construct.a.imaa025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa025
            #add-point:ON ACTION controlp INFIELD imaa025 name="construct.c.imaa025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa026
            #add-point:ON ACTION controlp INFIELD imaa026 name="construct.c.imaa026"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa026  #顯示到畫面上

            NEXT FIELD imaa026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa026
            #add-point:BEFORE FIELD imaa026 name="construct.b.imaa026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa026
            
            #add-point:AFTER FIELD imaa026 name="construct.a.imaa026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa027
            #add-point:BEFORE FIELD imaa027 name="construct.b.imaa027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa027
            
            #add-point:AFTER FIELD imaa027 name="construct.a.imaa027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa027
            #add-point:ON ACTION controlp INFIELD imaa027 name="construct.c.imaa027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa028
            #add-point:BEFORE FIELD imaa028 name="construct.b.imaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa028
            
            #add-point:AFTER FIELD imaa028 name="construct.a.imaa028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa028
            #add-point:ON ACTION controlp INFIELD imaa028 name="construct.c.imaa028"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa029
            #add-point:ON ACTION controlp INFIELD imaa029 name="construct.c.imaa029"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '5'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa029  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imaa029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa029
            #add-point:BEFORE FIELD imaa029 name="construct.b.imaa029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa029
            
            #add-point:AFTER FIELD imaa029 name="construct.a.imaa029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa030
            #add-point:BEFORE FIELD imaa030 name="construct.b.imaa030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa030
            
            #add-point:AFTER FIELD imaa030 name="construct.a.imaa030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa030
            #add-point:ON ACTION controlp INFIELD imaa030 name="construct.c.imaa030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa031
            #add-point:BEFORE FIELD imaa031 name="construct.b.imaa031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa031
            
            #add-point:AFTER FIELD imaa031 name="construct.a.imaa031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa031
            #add-point:ON ACTION controlp INFIELD imaa031 name="construct.c.imaa031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa032
            #add-point:ON ACTION controlp INFIELD imaa032 name="construct.c.imaa032"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa032  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imaa032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa032
            #add-point:BEFORE FIELD imaa032 name="construct.b.imaa032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa032
            
            #add-point:AFTER FIELD imaa032 name="construct.a.imaa032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa033
            #add-point:BEFORE FIELD imaa033 name="construct.b.imaa033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa033
            
            #add-point:AFTER FIELD imaa033 name="construct.a.imaa033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa033
            #add-point:ON ACTION controlp INFIELD imaa033 name="construct.c.imaa033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa034
            #add-point:BEFORE FIELD imaa034 name="construct.b.imaa034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa034
            
            #add-point:AFTER FIELD imaa034 name="construct.a.imaa034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa034
            #add-point:ON ACTION controlp INFIELD imaa034 name="construct.c.imaa034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa035
            #add-point:BEFORE FIELD imaa035 name="construct.b.imaa035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa035
            
            #add-point:AFTER FIELD imaa035 name="construct.a.imaa035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa035
            #add-point:ON ACTION controlp INFIELD imaa035 name="construct.c.imaa035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa036
            #add-point:BEFORE FIELD imaa036 name="construct.b.imaa036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa036
            
            #add-point:AFTER FIELD imaa036 name="construct.a.imaa036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa036
            #add-point:ON ACTION controlp INFIELD imaa036 name="construct.c.imaa036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa037
            #add-point:BEFORE FIELD imaa037 name="construct.b.imaa037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa037
            
            #add-point:AFTER FIELD imaa037 name="construct.a.imaa037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa037
            #add-point:ON ACTION controlp INFIELD imaa037 name="construct.c.imaa037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa043
            #add-point:BEFORE FIELD imaa043 name="construct.b.imaa043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa043
            
            #add-point:AFTER FIELD imaa043 name="construct.a.imaa043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa043
            #add-point:ON ACTION controlp INFIELD imaa043 name="construct.c.imaa043"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa043  #顯示到畫面上

            NEXT FIELD imaa043                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa038
            #add-point:BEFORE FIELD imaa038 name="construct.b.imaa038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa038
            
            #add-point:AFTER FIELD imaa038 name="construct.a.imaa038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa038
            #add-point:ON ACTION controlp INFIELD imaa038 name="construct.c.imaa038"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa039
            #add-point:ON ACTION controlp INFIELD imaa039 name="construct.c.imaa039"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa039()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa039  #顯示到畫面上

            NEXT FIELD imaa039                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa039
            #add-point:BEFORE FIELD imaa039 name="construct.b.imaa039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa039
            
            #add-point:AFTER FIELD imaa039 name="construct.a.imaa039"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa040
            #add-point:BEFORE FIELD imaa040 name="construct.b.imaa040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa040
            
            #add-point:AFTER FIELD imaa040 name="construct.a.imaa040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa040
            #add-point:ON ACTION controlp INFIELD imaa040 name="construct.c.imaa040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa041
            #add-point:BEFORE FIELD imaa041 name="construct.b.imaa041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa041
            
            #add-point:AFTER FIELD imaa041 name="construct.a.imaa041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa041
            #add-point:ON ACTION controlp INFIELD imaa041 name="construct.c.imaa041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa042
            #add-point:BEFORE FIELD imaa042 name="construct.b.imaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa042
            
            #add-point:AFTER FIELD imaa042 name="construct.a.imaa042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa042
            #add-point:ON ACTION controlp INFIELD imaa042 name="construct.c.imaa042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa044
            #add-point:BEFORE FIELD imaa044 name="construct.b.imaa044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa044
            
            #add-point:AFTER FIELD imaa044 name="construct.a.imaa044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa044
            #add-point:ON ACTION controlp INFIELD imaa044 name="construct.c.imaa044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa122
            #add-point:ON ACTION controlp INFIELD imaa122 name="construct.c.imaa122"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'

            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2000" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa122  #顯示到畫面上

            NEXT FIELD imaa122                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa122
            #add-point:BEFORE FIELD imaa122 name="construct.b.imaa122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa122
            
            #add-point:AFTER FIELD imaa122 name="construct.a.imaa122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa045
            #add-point:ON ACTION controlp INFIELD imaa045 name="construct.c.imaa045"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa045  #顯示到畫面上

            NEXT FIELD imaa045                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa045
            #add-point:BEFORE FIELD imaa045 name="construct.b.imaa045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa045
            
            #add-point:AFTER FIELD imaa045 name="construct.a.imaa045"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa123
            #add-point:BEFORE FIELD imaa123 name="construct.b.imaa123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa123
            
            #add-point:AFTER FIELD imaa123 name="construct.a.imaa123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa123
            #add-point:ON ACTION controlp INFIELD imaa123 name="construct.c.imaa123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imac002
            #add-point:BEFORE FIELD imac002 name="construct.b.imac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imac002
            
            #add-point:AFTER FIELD imac002 name="construct.a.imac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imac002
            #add-point:ON ACTION controlp INFIELD imac002 name="construct.c.imac002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imac003
            #add-point:BEFORE FIELD imac003 name="construct.b.imac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imac003
            
            #add-point:AFTER FIELD imac003 name="construct.a.imac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imac003
            #add-point:ON ACTION controlp INFIELD imac003 name="construct.c.imac003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imaj002,imaj003,imaj004,imaj005,imaj006
           FROM s_detail1[1].imaj002,s_detail1[1].imaj003,s_detail1[1].imaj004,s_detail1[1].imaj005, 
               s_detail1[1].imaj006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.imaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj002
            #add-point:ON ACTION controlp INFIELD imaj002 name="construct.c.page1.imaj002"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "270" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaj002  #顯示到畫面上

            NEXT FIELD imaj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj002
            #add-point:BEFORE FIELD imaj002 name="construct.b.page1.imaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj002
            
            #add-point:AFTER FIELD imaj002 name="construct.a.page1.imaj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj003
            #add-point:ON ACTION controlp INFIELD imaj003 name="construct.c.page1.imaj003"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "271" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaj003  #顯示到畫面上

            NEXT FIELD imaj003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj003
            #add-point:BEFORE FIELD imaj003 name="construct.b.page1.imaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj003
            
            #add-point:AFTER FIELD imaj003 name="construct.a.page1.imaj003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj004
            #add-point:BEFORE FIELD imaj004 name="construct.b.page1.imaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj004
            
            #add-point:AFTER FIELD imaj004 name="construct.a.page1.imaj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj004
            #add-point:ON ACTION controlp INFIELD imaj004 name="construct.c.page1.imaj004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imaj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj005
            #add-point:ON ACTION controlp INFIELD imaj005 name="construct.c.page1.imaj005"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaj005  #顯示到畫面上

            NEXT FIELD imaj005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj005
            #add-point:BEFORE FIELD imaj005 name="construct.b.page1.imaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj005
            
            #add-point:AFTER FIELD imaj005 name="construct.a.page1.imaj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj006
            #add-point:ON ACTION controlp INFIELD imaj006 name="construct.c.page1.imaj006"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "272" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaj006  #顯示到畫面上

            NEXT FIELD imaj006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj006
            #add-point:BEFORE FIELD imaj006 name="construct.b.page1.imaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj006
            
            #add-point:AFTER FIELD imaj006 name="construct.a.page1.imaj006"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON imal002
           FROM s_detail2[1].imal002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.imal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imal002
            #add-point:ON ACTION controlp INFIELD imal002 name="construct.c.page2.imal002"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "213" #應用分類
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imal002  #顯示到畫面上

            NEXT FIELD imal002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imal002
            #add-point:BEFORE FIELD imal002 name="construct.b.page2.imal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imal002
            
            #add-point:AFTER FIELD imal002 name="construct.a.page2.imal002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON imam002,imam005,imam003,imam006,imam004
           FROM s_detail3[1].imam002,s_detail3[1].imam005,s_detail3[1].imam003,s_detail3[1].imam006, 
               s_detail3[1].imam004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam002
            #add-point:BEFORE FIELD imam002 name="construct.b.page3.imam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam002
            
            #add-point:AFTER FIELD imam002 name="construct.a.page3.imam002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imam002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam002
            #add-point:ON ACTION controlp INFIELD imam002 name="construct.c.page3.imam002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam005
            #add-point:BEFORE FIELD imam005 name="construct.b.page3.imam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam005
            
            #add-point:AFTER FIELD imam005 name="construct.a.page3.imam005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam005
            #add-point:ON ACTION controlp INFIELD imam005 name="construct.c.page3.imam005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam003
            #add-point:BEFORE FIELD imam003 name="construct.b.page3.imam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam003
            
            #add-point:AFTER FIELD imam003 name="construct.a.page3.imam003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam003
            #add-point:ON ACTION controlp INFIELD imam003 name="construct.c.page3.imam003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam006
            #add-point:BEFORE FIELD imam006 name="construct.b.page3.imam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam006
            
            #add-point:AFTER FIELD imam006 name="construct.a.page3.imam006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam006
            #add-point:ON ACTION controlp INFIELD imam006 name="construct.c.page3.imam006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam004
            #add-point:BEFORE FIELD imam004 name="construct.b.page3.imam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam004
            
            #add-point:AFTER FIELD imam004 name="construct.a.page3.imam004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imam004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam004
            #add-point:ON ACTION controlp INFIELD imam004 name="construct.c.page3.imam004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON imao002
           FROM s_detail4[1].imao002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.imao002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imao002
            #add-point:ON ACTION controlp INFIELD imao002 name="construct.c.page4.imao002"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imao002  #顯示到畫面上

            NEXT FIELD imao002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imao002
            #add-point:BEFORE FIELD imao002 name="construct.b.page4.imao002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imao002
            
            #add-point:AFTER FIELD imao002 name="construct.a.page4.imao002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON imaystus,imay002,imay019,imay019_desc,imay003,imay004,imay005,imay006, 
          imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014 
 
           FROM s_detail5[1].imaystus,s_detail5[1].imay002,s_detail5[1].imay019,s_detail5[1].imay019_desc, 
               s_detail5[1].imay003,s_detail5[1].imay004,s_detail5[1].imay005,s_detail5[1].imay006,s_detail5[1].imay018, 
               s_detail5[1].imay007,s_detail5[1].imay008,s_detail5[1].imay009,s_detail5[1].imay015,s_detail5[1].imay010, 
               s_detail5[1].imay016,s_detail5[1].imay011,s_detail5[1].imay017,s_detail5[1].imay012,s_detail5[1].imay013, 
               s_detail5[1].imay014
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaycrtdt>>----
 
         #----<<imaymoddt>>----
         
         #----<<imaycnfdt>>----
         
         #----<<imaypstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="construct.b.page5.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="construct.a.page5.imaystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="construct.c.page5.imaystus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="construct.b.page5.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="construct.a.page5.imay002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="construct.c.page5.imay002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019
            #add-point:BEFORE FIELD imay019 name="construct.b.page5.imay019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019
            
            #add-point:AFTER FIELD imay019 name="construct.a.page5.imay019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019
            #add-point:ON ACTION controlp INFIELD imay019 name="construct.c.page5.imay019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019_desc
            #add-point:BEFORE FIELD imay019_desc name="construct.b.page5.imay019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019_desc
            
            #add-point:AFTER FIELD imay019_desc name="construct.a.page5.imay019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019_desc
            #add-point:ON ACTION controlp INFIELD imay019_desc name="construct.c.page5.imay019_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.imay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="construct.c.page5.imay003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay003  #顯示到畫面上

            NEXT FIELD imay003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="construct.b.page5.imay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="construct.a.page5.imay003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="construct.c.page5.imay004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay004  #顯示到畫面上

            NEXT FIELD imay004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="construct.b.page5.imay004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="construct.a.page5.imay004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="construct.b.page5.imay005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            
            #add-point:AFTER FIELD imay005 name="construct.a.page5.imay005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="construct.c.page5.imay005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="construct.b.page5.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="construct.a.page5.imay006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="construct.c.page5.imay006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="construct.b.page5.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="construct.a.page5.imay018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="construct.c.page5.imay018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="construct.b.page5.imay007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            
            #add-point:AFTER FIELD imay007 name="construct.a.page5.imay007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="construct.c.page5.imay007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="construct.b.page5.imay008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            
            #add-point:AFTER FIELD imay008 name="construct.a.page5.imay008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="construct.c.page5.imay008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="construct.b.page5.imay009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            
            #add-point:AFTER FIELD imay009 name="construct.a.page5.imay009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="construct.c.page5.imay009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="construct.c.page5.imay015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay015  #顯示到畫面上
            NEXT FIELD imay015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="construct.b.page5.imay015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="construct.a.page5.imay015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="construct.b.page5.imay010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            
            #add-point:AFTER FIELD imay010 name="construct.a.page5.imay010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="construct.c.page5.imay010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="construct.c.page5.imay016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay016  #顯示到畫面上
            NEXT FIELD imay016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="construct.b.page5.imay016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="construct.a.page5.imay016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="construct.b.page5.imay011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            
            #add-point:AFTER FIELD imay011 name="construct.a.page5.imay011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="construct.c.page5.imay011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="construct.c.page5.imay017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imay017  #顯示到畫面上
            NEXT FIELD imay017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="construct.b.page5.imay017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="construct.a.page5.imay017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="construct.b.page5.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="construct.a.page5.imay012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="construct.c.page5.imay012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="construct.b.page5.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="construct.a.page5.imay013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="construct.c.page5.imay013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="construct.b.page5.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="construct.a.page5.imay014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="construct.c.page5.imay014"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aim_aimm200_01.aimm200_01_construct
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         NEXT FIELD imaa001
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
 
            INITIALIZE g_wc2_table4 TO NULL
 
            INITIALIZE g_wc2_table5 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "imaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imaj_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imal_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imam_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imao_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imay_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aslm200_filter()
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
      CONSTRUCT g_wc_filter ON imaa001,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010
                          FROM s_browse[1].b_imaa001,s_browse[1].b_imaa009,s_browse[1].b_imaa003,s_browse[1].b_imaa004, 
                              s_browse[1].b_imaa005,s_browse[1].b_imaa006,s_browse[1].b_imaa010
 
         BEFORE CONSTRUCT
               DISPLAY aslm200_filter_parser('imaa001') TO s_browse[1].b_imaa001
            DISPLAY aslm200_filter_parser('imaa009') TO s_browse[1].b_imaa009
            DISPLAY aslm200_filter_parser('imaa003') TO s_browse[1].b_imaa003
            DISPLAY aslm200_filter_parser('imaa004') TO s_browse[1].b_imaa004
            DISPLAY aslm200_filter_parser('imaa005') TO s_browse[1].b_imaa005
            DISPLAY aslm200_filter_parser('imaa006') TO s_browse[1].b_imaa006
            DISPLAY aslm200_filter_parser('imaa010') TO s_browse[1].b_imaa010
      
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
 
      CALL aslm200_filter_show('imaa001')
   CALL aslm200_filter_show('imaa009')
   CALL aslm200_filter_show('imaa003')
   CALL aslm200_filter_show('imaa004')
   CALL aslm200_filter_show('imaa005')
   CALL aslm200_filter_show('imaa006')
   CALL aslm200_filter_show('imaa010')
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aslm200_filter_parser(ps_field)
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
 
{<section id="aslm200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aslm200_filter_show(ps_field)
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
   LET ls_condition = aslm200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aslm200_query()
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
   CALL g_imaj_d.clear()
   CALL g_imaj2_d.clear()
   CALL g_imaj3_d.clear()
   CALL g_imaj4_d.clear()
   CALL g_imaj5_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aimm200_01_clear_detail()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aslm200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aslm200_browser_fill("")
      CALL aslm200_fetch("")
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aslm200_filter_show('imaa001')
   CALL aslm200_filter_show('imaa009')
   CALL aslm200_filter_show('imaa003')
   CALL aslm200_filter_show('imaa004')
   CALL aslm200_filter_show('imaa005')
   CALL aslm200_filter_show('imaa006')
   CALL aslm200_filter_show('imaa010')
   CALL aslm200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aslm200_fetch("F") 
      #顯示單身筆數
      CALL aslm200_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aslm200_fetch(p_flag)
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
   
   LET g_imaa_m.imaa001 = g_browser[g_current_idx].b_imaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aslm200_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aslm200_set_act_visible()   
   CALL aslm200_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #重新顯示   
   CALL aslm200_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.insert" >}
#+ 資料新增
PRIVATE FUNCTION aslm200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
      DEFINE l_sys     LIKE type_t.chr1
   DEFINE l_success LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imaj_d.clear()   
   CALL g_imaj2_d.clear()  
   CALL g_imaj3_d.clear()  
   CALL g_imaj4_d.clear()  
   CALL g_imaj5_d.clear()  
 
 
   INITIALIZE g_imaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_imaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL g_imas_d.clear()   #160805-00028#1 160810 by lori add
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaaownid = g_user
      LET g_imaa_m.imaaowndp = g_dept
      LET g_imaa_m.imaacrtid = g_user
      LET g_imaa_m.imaacrtdp = g_dept 
      LET g_imaa_m.imaacrtdt = cl_get_current()
      LET g_imaa_m.imaamodid = g_user
      LET g_imaa_m.imaamoddt = cl_get_current()
      LET g_imaa_m.imaastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imaa_m.imaa004 = "M"
      LET g_imaa_m.imaastus = "N"
      LET g_imaa_m.imaa011 = "0"
      LET g_imaa_m.imaa012 = "Y"
      LET g_imaa_m.imaa155 = "0"
      LET g_imaa_m.imaa156 = "X"
      LET g_imaa_m.imaa116 = "0"
      LET g_imaa_m.imaa110 = "N"
      LET g_imaa_m.imaa121 = "N"
      LET g_imaa_m.imaa019 = "0"
      LET g_imaa_m.imaa020 = "0"
      LET g_imaa_m.imaa021 = "0"
      LET g_imaa_m.imaa023 = "0"
      LET g_imaa_m.imaa025 = "0"
      LET g_imaa_m.imaa027 = "N"
      LET g_imaa_m.imaa028 = "0"
      LET g_imaa_m.imaa030 = "0"
      LET g_imaa_m.imaa031 = "0"
      LET g_imaa_m.imaa033 = "0"
      LET g_imaa_m.imaa034 = "0"
      LET g_imaa_m.imaa043 = "N"
      LET g_imaa_m.imaa044 = "3"
 
  
      #add-point:單頭預設值 name="insert.default"
            LET g_imaa001_t = NULL
      INITIALIZE g_imaa_m_t.* TO NULL
      INITIALIZE g_imaa_m_o.* TO NULL
      LET g_imaa_m.imaa002 = NULL
      LET g_imaa_m.imaa142 = g_site
      LET g_imaa_m.imaa036 = "N"
      LET g_imaa_m.imaa037 = "N"
      LET g_imaa_m.imaa038 = "N"
      #add--160511-00040#3 By shiun--(S)
      LET g_imaa_m.imaa100 = '1'
      LET g_imaa_m.imaa108 = '1'
      LET g_imaa_m.imaa109 = '1'
      #add--160511-00040#3 By shiun--(E)
     # CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
     # IF l_sys = 'Y' THEN
     #     CALL s_aooi390('1') RETURNING l_success,g_imaa_m.imaa001
     #     DISPLAY BY NAME g_imaa_m.imaa001
     # END IF   
     
      INITIALIZE g_imaa001_d TO NULL
      CALL aimm200_01_clear_detail()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imaa_m_t.* = g_imaa_m.*
      LET g_imaa_m_o.* = g_imaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL aslm200_input("a")
      
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
         INITIALIZE g_imaa_m.* TO NULL
         INITIALIZE g_imaj_d TO NULL
         INITIALIZE g_imaj2_d TO NULL
         INITIALIZE g_imaj3_d TO NULL
         INITIALIZE g_imaj4_d TO NULL
         INITIALIZE g_imaj5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aslm200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imaj_d.clear()
      #CALL g_imaj2_d.clear()
      #CALL g_imaj3_d.clear()
      #CALL g_imaj4_d.clear()
      #CALL g_imaj5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aslm200_set_act_visible()   
   CALL aslm200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aslm200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aslm200_cl
   
   CALL aslm200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aslm200_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa126_desc,g_imaa_m.imaa127, 
       g_imaa_m.imaa127_desc,g_imaa_m.imaa131,g_imaa_m.imaa131_desc,g_imaa_m.imaa128,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129,g_imaa_m.imaa129_desc,g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa132_desc, 
       g_imaa_m.imaa133,g_imaa_m.imaa133_desc,g_imaa_m.imaa134,g_imaa_m.imaa134_desc,g_imaa_m.imaa135, 
       g_imaa_m.imaa135_desc,g_imaa_m.imaa136,g_imaa_m.imaa136_desc,g_imaa_m.imaa137,g_imaa_m.imaa137_desc, 
       g_imaa_m.imaa138,g_imaa_m.imaa138_desc,g_imaa_m.imaa139,g_imaa_m.imaa139_desc,g_imaa_m.imaa140, 
       g_imaa_m.imaa140_desc,g_imaa_m.imaa141,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfid_desc,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
       g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
       g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaa142, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121, 
       g_imaa_m.imaa124,g_imaa_m.imaa124_desc,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa018_desc, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa022_desc,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027, 
       g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa029_desc,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
       g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa039_desc,g_imaa_m.imaa040,g_imaa_m.imaa041, 
       g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa122_desc,g_imaa_m.imaa045, 
       g_imaa_m.imaa045_desc,g_imaa_m.imaa123,g_imaa_m.imac002,g_imaa_m.imac003
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #功能已完成,通報訊息中心
   CALL aslm200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.modify" >}
#+ 資料修改
PRIVATE FUNCTION aslm200_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imaa_m_t.* = g_imaa_m.*
   LET g_imaa_m_o.* = g_imaa_m.*
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imaa001_t = g_imaa_m.imaa001
 
   CALL s_transaction_begin()
   
   OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aslm200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
   #檢查是否允許此動作
   IF NOT aslm200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aslm200_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
 
 
   
   CALL aslm200_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
 
 
    
   WHILE TRUE
      LET g_imaa001_t = g_imaa_m.imaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imaa_m.imaamodid = g_user 
LET g_imaa_m.imaamoddt = cl_get_current()
LET g_imaa_m.imaamodid_desc = cl_get_username(g_imaa_m.imaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
            LET g_imaa_m.imaamoddt = cl_get_current()
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aslm200_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imaa_t SET (imaamodid,imaamoddt) = (g_imaa_m.imaamodid,g_imaa_m.imaamoddt)
          WHERE imaaent = g_enterprise AND imaa001 = g_imaa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imaa_m.* = g_imaa_m_t.*
            CALL aslm200_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imaa_m.imaa001 != g_imaa_m_t.imaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE imaj_t SET imaj001 = g_imaa_m.imaa001
 
          WHERE imajent = g_enterprise AND imaj001 = g_imaa_m_t.imaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imaj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
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
         
         UPDATE imal_t
            SET imal001 = g_imaa_m.imaa001
 
          WHERE imalent = g_enterprise AND
                imal001 = g_imaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imal_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
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
         
         UPDATE imam_t
            SET imam001 = g_imaa_m.imaa001
 
          WHERE imament = g_enterprise AND
                imam001 = g_imaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imam_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE imao_t
            SET imao001 = g_imaa_m.imaa001
 
          WHERE imaoent = g_enterprise AND
                imao001 = g_imaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imao_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE imay_t
            SET imay001 = g_imaa_m.imaa001
 
          WHERE imayent = g_enterprise AND
                imay001 = g_imaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imay_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aslm200_set_act_visible()   
   CALL aslm200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到對應位置
   CALL aslm200_browser_fill("")
 
   CLOSE aslm200_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aslm200_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aslm200.input" >}
#+ 資料輸入
PRIVATE FUNCTION aslm200_input(p_cmd)
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
   DEFINE p_req_data       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE l_imaa003        LIKE imaa_t.imaa003
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_sys            LIKE type_t.chr1
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_n1             LIKE type_t.num5
   DEFINE l_imaa001        STRING
   DEFINE l_imaal003       STRING
   DEFINE l_imaal004       STRING
   DEFINE l_para           LIKE type_t.chr1
   DEFINE l_dlang          LIKE type_t.chr10
   DEFINE l_imaal003_trn   LIKE imaal_t.imaal003
   DEFINE l_imaal004_trn   LIKE imaal_t.imaal004
   DEFINE l_imaal005_trn   LIKE imaal_t.imaal005
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_count_chk      LIKE type_t.num5
   DEFINE l_qty1           LIKE imad_t.imad003   #add by lixiang 2015/12/04
   DEFINE l_qty2           LIKE imad_t.imad005   #add by lixiang 2015/12/04
   DEFINE l_use            LIKE type_t.num5      #add by lixiang 2015/12/04
   DEFINE l_oocq004        LIKE oocq_t.oocq004   #150317-00006#1 add
   DEFINE l_imay005              LIKE imay_t.imay005
   DEFINE l_time        DATETIME YEAR TO SECOND
   #160803-00008#4 20160811 add by beckxie---S
   DEFINE  l_inam            DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001           LIKE inam_t.inam001,  #料號
           inam002           LIKE inam_t.inam002,  #產品特徵
           inam004           LIKE inam_t.inam004   #nouse
                             END RECORD
   #160803-00008#4 20160811 add by beckxie---E
   #add by tangyi 161008-str-
   DEFINE r_success              LIKE type_t.num5
   DEFINE r_errno                LIKE type_t.chr10
   DEFINE r_rtax001              LIKE rtax_t.rtax001
   #add by tangyi 161008-end- 
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
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa126_desc,g_imaa_m.imaa127, 
       g_imaa_m.imaa127_desc,g_imaa_m.imaa131,g_imaa_m.imaa131_desc,g_imaa_m.imaa128,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129,g_imaa_m.imaa129_desc,g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa132_desc, 
       g_imaa_m.imaa133,g_imaa_m.imaa133_desc,g_imaa_m.imaa134,g_imaa_m.imaa134_desc,g_imaa_m.imaa135, 
       g_imaa_m.imaa135_desc,g_imaa_m.imaa136,g_imaa_m.imaa136_desc,g_imaa_m.imaa137,g_imaa_m.imaa137_desc, 
       g_imaa_m.imaa138,g_imaa_m.imaa138_desc,g_imaa_m.imaa139,g_imaa_m.imaa139_desc,g_imaa_m.imaa140, 
       g_imaa_m.imaa140_desc,g_imaa_m.imaa141,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfid_desc,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
       g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
       g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaa142, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121, 
       g_imaa_m.imaa124,g_imaa_m.imaa124_desc,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa018_desc, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa022_desc,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027, 
       g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa029_desc,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
       g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa039_desc,g_imaa_m.imaa040,g_imaa_m.imaa041, 
       g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa122_desc,g_imaa_m.imaa045, 
       g_imaa_m.imaa045_desc,g_imaa_m.imaa123,g_imaa_m.imac002,g_imaa_m.imac003
   
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
   LET g_forupd_sql = "SELECT imaj002,imaj003,imaj004,imaj005,imaj006 FROM imaj_t WHERE imajent=? AND  
       imaj001=? AND imaj002=? AND imaj003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imal002 FROM imal_t WHERE imalent=? AND imal001=? AND imal002=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imam002,imam005,imam003,imam006,imam004 FROM imam_t WHERE imament=? AND  
       imam001=? AND imam002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imao002 FROM imao_t WHERE imaoent=? AND imao001=? AND imao002=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018,imay007, 
       imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014 FROM imay_t WHERE  
       imayent=? AND imay001=? AND imay003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslm200_bcl5 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aslm200_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aslm200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010, 
       g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
       g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136, 
       g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaa011, 
       g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154, 
       g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142, 
       g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124, 
       g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019, 
       g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025, 
       g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031, 
       g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
       g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042, 
       g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123,g_imaa_m.imac002, 
       g_imaa_m.imac003
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1 
   LET g_con='N' 
   LET g_flag = 'N'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aslm200.input.head" >}
      #單頭段
      INPUT BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
          g_imaa_m.imaa009,g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010, 
          g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
          g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136, 
          g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaa011, 
          g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154, 
          g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142, 
          g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124, 
          g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019, 
          g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025, 
          g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031, 
          g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
          g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042, 
          g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123,g_imaa_m.imac002, 
          g_imaa_m.imac003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_imaa_m.imaa001)  THEN
                  CALL n_imaal(g_imaa_m.imaa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa001
                  CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent = '"
                      ||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaal003 = g_rtn_fields[1]
                  LET g_imaa_m.imaal004 = g_rtn_fields[2]
                  LET g_imaa_m.imaal005 = g_rtn_fields[3]

                  DISPLAY BY NAME g_imaa_m.imaal003
                  DISPLAY BY NAME g_imaa_m.imaal004
                  DISPLAY BY NAME g_imaa_m.imaal005
               END IF
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="input.master_input.open_s_carry_query"
               #2015/06/30 by stellar add ----- (S)
               IF NOT cl_null(g_imaa_m.imaa001) THEN
                  LET ga_field[1] = g_imaa_m.imaa001
                  CALL s_carry_query('1',ga_field)
               END IF
               #2015/06/30 by stellar add ----- (E)
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.imaal001 = g_imaa_m.imaa001
LET g_master_multi_table_t.imaal003 = g_imaa_m.imaal003
LET g_master_multi_table_t.imaal004 = g_imaa_m.imaal004
LET g_master_multi_table_t.imaal005 = g_imaa_m.imaal005
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.imaal001 = ''
LET g_master_multi_table_t.imaal003 = ''
LET g_master_multi_table_t.imaal004 = ''
LET g_master_multi_table_t.imaal005 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aslm200_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aslm200_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="input.b.imaa001"
            IF cl_null(g_imaa_m.imaa001) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
               IF l_sys = 'Y' THEN
               
                   #150302---earl---mod---s
                   #CALL s_aooi390('1') RETURNING l_success,g_imaa_m.imaa001
                   #DISPLAY BY NAME g_imaa_m.imaa001
                   
                   CALL aslm200_aooi390_default()
                   #150302---earl---mod---e

               END IF 
            END IF
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="input.a.imaa001"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaa_t WHERE "||"imaaent = '" ||g_enterprise|| "' AND "||"imaa001 = '"||g_imaa_m.imaa001 ||"'",'std-00004',0) THEN 
                     LET g_imaa_m.imaa001 = g_imaa001_t
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(S)
                  IF NOT s_aooi390_chk('1',g_imaa_m.imaa001) THEN
                     LET g_imaa_m.imaa001 = g_imaa001_t
                     DISPLAY BY NAME g_imaa_m.imaa001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(E)
               END IF
               
               LET l_imaa001 = g_imaa_m.imaa001
               LET l_n = l_imaa001.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0003') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00215'
                  LET g_errparam.extend = g_imaa_m.imaa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa001 = g_imaa001_t
                  NEXT FIELD CURRENT
               END IF
               
               #150312---earl---add---s
               CALL cl_err_collect_init()
               CALL s_aimm200_unit_chk(g_imaa_m.imaa001,g_imaa_m.imaa006,'') RETURNING l_success
               CALL cl_err_collect_show()
               IF NOT l_success THEN
                  LET g_imaa_m.imaa001 = g_imaa001_t
                  NEXT FIELD CURRENT
               END IF
               #150312---earl---add---e
               #add--2015/03/18--By shiun--(S)
               IF g_imaa_m_o.imaa001 != g_imaa_m.imaa001 AND NOT cl_null(g_imaa_m_o.imaa001) THEN
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imaal_t
                   WHERE imaalent = g_enterprise
                     AND imaal001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imaal_t 
                        SET imaal001 = g_imaa_m.imaa001
                      WHERE imaalent = g_enterprise
                        AND imaal001 = g_imaa_m_o.imaa001                      
                  END IF
               END IF  
            END IF
            LET g_imaa_m_o.imaa001 = g_imaa_m.imaa001
               #add--2015/03/18--By shiun--(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa001
            #add-point:ON CHANGE imaa001 name="input.g.imaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="input.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="input.a.imaa002"
                        IF g_imaa_m.imaa002 < 0  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00009'
               LET g_errparam.extend = g_imaa_m.imaa002
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET g_imaa_m.imaa002 = g_imaa_m_t.imaa002
               NEXT FIELD imaa002
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa002
            #add-point:ON CHANGE imaa002 name="input.g.imaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="input.b.imaal003"
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0017') RETURNING l_para
            IF l_para = 'Y' AND cl_null(g_imaa_m.imaal003) AND NOT cl_null(g_imaa_m.imaa001) THEN
               CALL s_auto_item_desc_auto_no() RETURNING l_success,g_imaa_m.imaal003
#               IF l_success THEN
#                  LET l_num = 0
#                  CASE g_dlang
#                     WHEN 'zh_TW'
#                        LET l_dlang = 'zh_CN'
#                     WHEN 'zh_CN'
#                        LET l_dlang = 'zh_TW'
#                  END CASE
#                  CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal003) RETURNING l_imaal003_trn
#                  CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal004) RETURNING l_imaal004_trn
#                  CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal005) RETURNING l_imaal005_trn
#                  SELECT COUNT(*) INTO l_num
#                    FROM imaal_t
#                   WHERE imaalent = g_enterprise
#                     AND imaal001 = g_imaa_m.imaa001
#                     AND imaal002 = l_dlang
#                  IF l_num = 0 THEN
#                     INSERT INTO imaal_t (imaalent,imaal001,imaal002,imaal003,imaal004,imaal005)
#                     VALUES(g_enterprise,g_imaa_m.imaa001,l_dlang,l_imaal003_trn,l_imaal004_trn,l_imaal005_trn)
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = "imaal_t" 
#                        LET g_errparam.code   = SQLCA.sqlcode 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        CALL s_transaction_end('N','0')
#                        NEXT FIELD CURRENT
#                     END IF
#                  ELSE
#                     UPDATE imaal_t SET imaal003 = l_imaal003_trn,
#                                        imaal004 = l_imaal004_trn,
#                                        imaal005 = l_imaal005_trn
#                      WHERE imaalent = g_enterprise 
#                        AND imaal001 = g_imaa_m.imaa001
#                        AND imaal002 = l_dlang
#                        
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = "imaal_t" 
#                        LET g_errparam.code   = SQLCA.sqlcode 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        CALL s_transaction_end('N','0')
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF
            END IF
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="input.a.imaal003"
            IF NOT cl_null(g_imaa_m.imaal003) THEN 
               LET l_imaal003 = g_imaa_m.imaal003
               LET l_n = l_imaal003.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0006') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00216'
                  LET g_errparam.extend = g_imaa_m.imaal003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaal003 = g_imaa_m_t.imaal003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal003
            #add-point:ON CHANGE imaal003 name="input.g.imaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="input.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="input.a.imaal004"
            IF NOT cl_null(g_imaa_m.imaal004) THEN 
               LET l_imaal004 = g_imaa_m.imaal004
               LET l_n = l_imaal004.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0007') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00217'
                  LET g_errparam.extend = g_imaa_m.imaal004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaal004 = g_imaa_m_t.imaal004
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal004
            #add-point:ON CHANGE imaal004 name="input.g.imaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="input.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="input.a.imaal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal005
            #add-point:ON CHANGE imaal005 name="input.g.imaal005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.imaa009"
                        IF NOT cl_null(g_imaa_m.imaa009) THEN 
               LET p_req_data[1] = g_imaa_m.imaa009
               CALL s_aimm200_fields_chk('imaa009',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa009
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aimi010'
                  LET g_errparam.replace[2] = cl_get_progname('aimi010',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi010'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa009 = g_imaa_m_t.imaa009
                  LET g_imaa_m.imaa009_desc = g_imaa_m_t.imaa009_desc
                  DISPLAY BY NAME g_imaa_m.imaa009_desc
                  NEXT FIELD imaa009
               END IF
            END IF
            IF cl_null(g_imaa_m.imaa003) THEN
               SELECT rtax007 INTO g_imaa_m.imaa003 
                 FROM rtax_t
                WHERE rtax001 = g_imaa_m.imaa009
                  AND rtaxent = g_enterprise
               DISPLAY BY NAME g_imaa_m.imaa003
            END IF
            IF p_cmd = 'a'AND l_cmd_t = 'a' THEN 
               LET g_con = 'Y'
               CALL aslm200_show_imca()
            END IF     
            IF p_cmd = 'u'  THEN 
               SELECT  rtax007 INTO l_imaa003 
                 FROM rtax_t
                WHERE rtax001 = g_imaa_m.imaa009
                  AND rtaxent = g_enterprise  
                IF g_imaa_m.imaa003 != l_imaa003 THEN                  
                   IF NOT cl_ask_confirm('aim-00120') THEN
                      LET g_con = 'N'
                   ELSE
                      LET g_con = 'Y'
                      LET g_imaa_m.imaa003 = l_imaa003
                      CALL aslm200_show_imca()                                               
                   END IF                               
               END IF
            END IF                
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa009_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa009_desc
            #add by tangyi -str
            IF NOT cl_null(g_imaa_m.imaa143) THEN
               CALL aslm200_chk_imaa143('2')
               IF NOT cl_null(g_errno) THEN
                  IF cl_ask_confirm('art-00379') THEN
                     LET g_imaa_m.imaa143 = ''
                     LET g_imaa_m.imaa143_desc = ''
                     DISPLAY BY NAME g_imaa_m.imaa143,g_imaa_m.imaa143_desc
                  ELSE                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #add by tangyi -end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.imaa009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.imaa003"
                        IF p_cmd = 'a' AND l_cmd_t = 'a' THEN
               CALL aslm200_show_imca()
            END IF   
            IF p_cmd = 'u' AND g_imaa_m.imaa003 != g_imaa_m_t.imaa003 THEN   
               IF NOT cl_ask_confirm('aim-00120') THEN
                  LET g_con = 'N'
               ELSE
                  LET g_con = 'Y'
                  CALL aslm200_show_imca()                  
               END IF
            END IF
            IF NOT cl_null(g_imaa_m.imaa003) THEN          
               LET p_req_data[1] = g_imaa_m.imaa003
               CALL s_aimm200_fields_chk('imaa003',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa003
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aimi100'
                  LET g_errparam.replace[2] = cl_get_progname('aimi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi100'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa003 = g_imaa_m_t.imaa003
                  LET g_imaa_m.imaa003_desc = g_imaa_m_t.imaa003_desc
                  DISPLAY BY NAME g_imaa_m.imaa003_desc
                  NEXT FIELD imaa003
               END IF
            END IF   
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa003_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.imaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.imaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="input.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="input.a.imaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa004
            #add-point:ON CHANGE imaa004 name="input.g.imaa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="input.a.imaa005"
            IF NOT cl_null(g_imaa_m.imaa005) THEN         
               LET p_req_data[1] = g_imaa_m.imaa005
               CALL s_aimm200_fields_chk('imaa005',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa005
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aimi092'
                  LET g_errparam.replace[2] = cl_get_progname('aimi092',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi092'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa005 = g_imaa_m_o.imaa005
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa005
                  CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaa005_desc =  g_rtn_fields[1] 
                  DISPLAY BY NAME g_imaa_m.imaa005_desc                      
                  NEXT FIELD imaa005
               END IF
              # LET g_imaa_m_o.imaa005 = g_imaa_m.imaa005
               #IF p_cmd = 'u' AND g_imaa_m.imaa005 <> g_imaa_m_o.imaa005 THEN
               IF p_cmd = 'u' AND g_imaa_m.imaa005 <> g_imaa_m_o.imaa005 THEN
                  DELETE FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001
               END IF  
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_imaa_m_o.imaa005) OR g_imaa_m.imaa005 <> g_imaa_m_o.imaa005)) THEN 
                  IF NOT aslm200_ins_imak() THEN
                     LET g_imaa_m.imaa005 = g_imaa_m_o.imaa005
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_imaa_m.imaa005
                     CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_imaa_m.imaa005_desc =  g_rtn_fields[1] 
                     DISPLAY BY NAME g_imaa_m.imaa005_desc                      
                     NEXT FIELD imaa005
                  END IF
                  #輸入特徵組別之後，如果特徵組別有料件層級的特徵，跳出維護產品特徵的視窗
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001   
                  IF l_n >0 THEN
                     CALL aimm200_01(g_imaa_m.imaa001,g_imaa_m.imaa005) 
                  END IF
                  LET g_flag = 'Y'    #2015/04/15 by stellar add
               END IF 
            --------2015-2-3 zj mod------           #如果产品特征为空，若单身不为空，则需清空单身   
            ELSE
               CALL aimm200_01_clear_detail()
               DELETE FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001
               LET g_imaa001_d = g_imaa_m.imaa001
               CALL aimm200_01_b_fill(g_imaa001_d)
            -------2015-2-3 zj mod------               
            END IF
            LET g_imaa_m_o.imaa005 = g_imaa_m.imaa005
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa005
            CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa005_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa005_desc                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="input.b.imaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa005
            #add-point:ON CHANGE imaa005 name="input.g.imaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="input.a.imaa006"
            IF NOT cl_null(g_imaa_m.imaa006) THEN 
               LET p_req_data[1] = g_imaa_m.imaa006
               CALL s_aimm200_fields_chk('imaa006',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa006
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi250'
                  LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi250'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa006 = g_imaa_m_t.imaa006
                  LET g_imaa_m.imaa006_desc = g_imaa_m_t.imaa006_desc
                  DISPLAY BY NAME g_imaa_m.imaa006_desc
                  NEXT FIELD imaa006
               END IF
               
               #add by lixiang 2015/12/04--begin---
               #單位修改時判斷，當前料號是否有在單據作業中使用，若有，則需判斷當前維護的單位與舊值單位是否存在換算
               IF g_imaa_m.imaa006 <> g_imaa_m_t.imaa006 THEN
                  #CALL s_azzi610_check('1',g_imaa_m.imaa001) RETURNING l_success,l_use  #160816-00042#1
                  CALL s_azzi610_check('1',g_imaa_m.imaa001,'') RETURNING l_success,l_use  #160816-00042#1
                  #該料號已使用
                  IF l_use THEN
                     CALL s_aimi190_get_convert1(g_imaa_m.imaa001,g_imaa_m.imaa006,g_imaa_m_t.imaa006) RETURNING l_success,l_qty1,l_qty2
                     IF NOT l_success THEN
                        LET g_imaa_m.imaa006 = g_imaa_m_t.imaa006
                        LET g_imaa_m.imaa006_desc = g_imaa_m_t.imaa006_desc
                        DISPLAY BY NAME g_imaa_m.imaa006_desc
                        NEXT FIELD imaa006
                     END IF
                  END IF
               END IF
               #add by lixiang 2015/12/04--end-----
               
               #150312---earl---add---s
               CALL cl_err_collect_init()
               CALL s_aimm200_unit_chk(g_imaa_m.imaa001,g_imaa_m.imaa006,'') RETURNING l_success
               CALL cl_err_collect_show()
               IF NOT l_success THEN
                  LET g_imaa_m.imaa006 = g_imaa_m_t.imaa006
                  LET g_imaa_m.imaa006_desc = g_imaa_m_t.imaa006_desc
                  DISPLAY BY NAME g_imaa_m.imaa006_desc
                  NEXT FIELD imaa006
               END IF
               #150312---earl---add---e
               
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa006_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_imaa_m.imaa006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="input.b.imaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa006
            #add-point:ON CHANGE imaa006 name="input.g.imaa006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="input.a.imaa010"
            IF NOT cl_null(g_imaa_m.imaa010) THEN 
               #mark by lixiang 2016/06/25 --s---
               #LET p_req_data[1] = 210
               #LET p_req_data[2] = g_imaa_m.imaa010
               #CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               #IF NOT l_success THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = g_errno
               #   LET g_errparam.extend = g_imaa_m.imaa010
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #mark by lixiang 2016/06/25 --e---
               
               #add by lixiang 2016/06/25 --s---
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaa_m.imaa010
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oocq002_210") THEN
               #add by lixiang 2016/06/25 --e---
                  LET g_imaa_m.imaa010 = g_imaa_m_t.imaa010
                  LET g_imaa_m.imaa010_desc = g_imaa_m_t.imaa010_desc
                  DISPLAY BY NAME g_imaa_m.imaa010_desc
                  NEXT FIELD imaa010
               END IF
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa010_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="input.b.imaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa010
            #add-point:ON CHANGE imaa010 name="input.g.imaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaastus
            #add-point:BEFORE FIELD imaastus name="input.b.imaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaastus
            
            #add-point:AFTER FIELD imaastus name="input.a.imaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaastus
            #add-point:ON CHANGE imaastus name="input.g.imaastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa126
            
            #add-point:AFTER FIELD imaa126 name="input.a.imaa126"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2002',g_imaa_m.imaa126) RETURNING g_imaa_m.imaa126_desc
            DISPLAY BY NAME g_imaa_m.imaa126_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa126) THEN 
               LET p_req_data[1] = 2002
               LET p_req_data[2] = g_imaa_m.imaa126
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa126
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imaa_m.imaa126 = g_imaa_m_t.imaa126
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2002',g_imaa_m.imaa126) RETURNING g_imaa_m.imaa126_desc
                  DISPLAY BY NAME g_imaa_m.imaa126_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa126
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa126
            #add-point:BEFORE FIELD imaa126 name="input.b.imaa126"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa126
            #add-point:ON CHANGE imaa126 name="input.g.imaa126"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa127
            
            #add-point:AFTER FIELD imaa127 name="input.a.imaa127"
            LET g_imaa_m.imaa127_desc = ''
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2003',g_imaa_m.imaa127) RETURNING g_imaa_m.imaa127_desc
            DISPLAY BY NAME g_imaa_m.imaa127_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa127) THEN 
               LET p_req_data[1] = 2003
               LET p_req_data[2] = g_imaa_m.imaa127
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa127
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa127 = g_imaa_m_t.imaa127
                  CALL s_desc_get_acc_desc('2003',g_imaa_m.imaa127)
                       RETURNING g_imaa_m.imaa127_desc
                  DISPLAY BY NAME g_imaa_m.imaa127_desc
                  NEXT FIELD imaa127
               END IF
            END IF
            CALL s_desc_get_acc_desc('2003',g_imaa_m.imaa127)
                 RETURNING g_imaa_m.imaa127_desc
            DISPLAY BY NAME g_imaa_m.imaa127_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa127
            #add-point:BEFORE FIELD imaa127 name="input.b.imaa127"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa127
            #add-point:ON CHANGE imaa127 name="input.g.imaa127"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa131
            
            #add-point:AFTER FIELD imaa131 name="input.a.imaa131"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2001',g_imaa_m.imaa131) RETURNING g_imaa_m.imaa131_desc
            DISPLAY BY NAME g_imaa_m.imaa131_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa131) THEN 
               LET p_req_data[1] = 2001
               LET p_req_data[2] = g_imaa_m.imaa131
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa131
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa131 = g_imaa_m_t.imaa131
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2001',g_imaa_m.imaa131) RETURNING g_imaa_m.imaa131_desc
                  DISPLAY BY NAME g_imaa_m.imaa131_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa131
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa131
            #add-point:BEFORE FIELD imaa131 name="input.b.imaa131"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa131
            #add-point:ON CHANGE imaa131 name="input.g.imaa131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa128
            
            #add-point:AFTER FIELD imaa128 name="input.a.imaa128"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2004',g_imaa_m.imaa128) RETURNING g_imaa_m.imaa128_desc
            DISPLAY BY NAME g_imaa_m.imaa128_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa128) THEN 
               LET p_req_data[1] = 2004
               LET p_req_data[2] = g_imaa_m.imaa128
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa128
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa128 = g_imaa_m_t.imaa128
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2004',g_imaa_m.imaa128) RETURNING g_imaa_m.imaa128_desc
                  DISPLAY BY NAME g_imaa_m.imaa128_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa128
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa128
            #add-point:BEFORE FIELD imaa128 name="input.b.imaa128"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa128
            #add-point:ON CHANGE imaa128 name="input.g.imaa128"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa129
            
            #add-point:AFTER FIELD imaa129 name="input.a.imaa129"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2005',g_imaa_m.imaa129) RETURNING g_imaa_m.imaa129_desc
            DISPLAY BY NAME g_imaa_m.imaa129_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa129) THEN 
               LET p_req_data[1] = 2005
               LET p_req_data[2] = g_imaa_m.imaa129
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa129
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa129 = g_imaa_m_t.imaa129
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2005',g_imaa_m.imaa129) RETURNING g_imaa_m.imaa129_desc
                  DISPLAY BY NAME g_imaa_m.imaa129_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa129
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa129
            #add-point:BEFORE FIELD imaa129 name="input.b.imaa129"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa129
            #add-point:ON CHANGE imaa129 name="input.g.imaa129"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa130
            #add-point:BEFORE FIELD imaa130 name="input.b.imaa130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa130
            
            #add-point:AFTER FIELD imaa130 name="input.a.imaa130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa130
            #add-point:ON CHANGE imaa130 name="input.g.imaa130"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="input.a.imaa132"
            LET g_imaa_m.imaa132_desc = ''
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2006',g_imaa_m.imaa132) RETURNING g_imaa_m.imaa132_desc
            DISPLAY BY NAME g_imaa_m.imaa132_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa132) THEN 
               LET p_req_data[1] = 2006
               LET p_req_data[2] = g_imaa_m.imaa132
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa132
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa132 = g_imaa_m_t.imaa132
                  CALL s_desc_get_acc_desc('2006',g_imaa_m.imaa132)
                       RETURNING g_imaa_m.imaa132_desc
                  DISPLAY BY NAME g_imaa_m.imaa132_desc
                  NEXT FIELD imaa132
               END IF
            END IF
            CALL s_desc_get_acc_desc('2006',g_imaa_m.imaa132)
                 RETURNING g_imaa_m.imaa132_desc
            DISPLAY BY NAME g_imaa_m.imaa132_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="input.b.imaa132"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa132
            #add-point:ON CHANGE imaa132 name="input.g.imaa132"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa133
            
            #add-point:AFTER FIELD imaa133 name="input.a.imaa133"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2007',g_imaa_m.imaa133) RETURNING g_imaa_m.imaa133_desc
            DISPLAY BY NAME g_imaa_m.imaa133_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa133) THEN 
               LET p_req_data[1] = 2007
               LET p_req_data[2] = g_imaa_m.imaa133
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa133
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa133 = g_imaa_m_t.imaa133
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2007',g_imaa_m.imaa133) RETURNING g_imaa_m.imaa133_desc
                  DISPLAY BY NAME g_imaa_m.imaa133_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa133
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa133
            #add-point:BEFORE FIELD imaa133 name="input.b.imaa133"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa133
            #add-point:ON CHANGE imaa133 name="input.g.imaa133"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa134
            
            #add-point:AFTER FIELD imaa134 name="input.a.imaa134"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2008',g_imaa_m.imaa134) RETURNING g_imaa_m.imaa134_desc
            DISPLAY BY NAME g_imaa_m.imaa134_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa134) THEN 
               LET p_req_data[1] = 2008
               LET p_req_data[2] = g_imaa_m.imaa134
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa134
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa134 = g_imaa_m_t.imaa134
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2008',g_imaa_m.imaa134) RETURNING g_imaa_m.imaa134_desc
                  DISPLAY BY NAME g_imaa_m.imaa134_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa134
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa134
            #add-point:BEFORE FIELD imaa134 name="input.b.imaa134"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa134
            #add-point:ON CHANGE imaa134 name="input.g.imaa134"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa135
            
            #add-point:AFTER FIELD imaa135 name="input.a.imaa135"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2009',g_imaa_m.imaa135) RETURNING g_imaa_m.imaa135_desc
            DISPLAY BY NAME g_imaa_m.imaa135_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa135) THEN 
               LET p_req_data[1] = 2009
               LET p_req_data[2] = g_imaa_m.imaa135
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa135
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa135 = g_imaa_m_t.imaa135
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2009',g_imaa_m.imaa135) RETURNING g_imaa_m.imaa135_desc
                  DISPLAY BY NAME g_imaa_m.imaa135_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa135
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa135
            #add-point:BEFORE FIELD imaa135 name="input.b.imaa135"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa135
            #add-point:ON CHANGE imaa135 name="input.g.imaa135"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa136
            
            #add-point:AFTER FIELD imaa136 name="input.a.imaa136"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2010',g_imaa_m.imaa136) RETURNING g_imaa_m.imaa136_desc
            DISPLAY BY NAME g_imaa_m.imaa136_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa136) THEN 
               LET p_req_data[1] = 2010
               LET p_req_data[2] = g_imaa_m.imaa136
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa136
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa136 = g_imaa_m_t.imaa136
                   #141231-00010#1--add--begin----
                   CALL s_desc_get_acc_desc('2010',g_imaa_m.imaa136) RETURNING g_imaa_m.imaa136_desc
                   DISPLAY BY NAME g_imaa_m.imaa136_desc
                   #141231-00010#1--add--end----
                  NEXT FIELD imaa136
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa136
            #add-point:BEFORE FIELD imaa136 name="input.b.imaa136"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa136
            #add-point:ON CHANGE imaa136 name="input.g.imaa136"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa137
            
            #add-point:AFTER FIELD imaa137 name="input.a.imaa137"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2011',g_imaa_m.imaa137) RETURNING g_imaa_m.imaa137_desc
            DISPLAY BY NAME g_imaa_m.imaa137_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa137) THEN 
               LET p_req_data[1] = 2011
               LET p_req_data[2] = g_imaa_m.imaa137
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa137
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa137 = g_imaa_m_t.imaa137
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2011',g_imaa_m.imaa137) RETURNING g_imaa_m.imaa137_desc
                  DISPLAY BY NAME g_imaa_m.imaa137_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa137
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa137
            #add-point:BEFORE FIELD imaa137 name="input.b.imaa137"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa137
            #add-point:ON CHANGE imaa137 name="input.g.imaa137"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa138
            
            #add-point:AFTER FIELD imaa138 name="input.a.imaa138"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2012',g_imaa_m.imaa138) RETURNING g_imaa_m.imaa138_desc
            DISPLAY BY NAME g_imaa_m.imaa138_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa138) THEN 
               LET p_req_data[1] = 2012
               LET p_req_data[2] = g_imaa_m.imaa138
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa138
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa138 = g_imaa_m_t.imaa138
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2012',g_imaa_m.imaa138) RETURNING g_imaa_m.imaa138_desc
                  DISPLAY BY NAME g_imaa_m.imaa138_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa138
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa138
            #add-point:BEFORE FIELD imaa138 name="input.b.imaa138"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa138
            #add-point:ON CHANGE imaa138 name="input.g.imaa138"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa139
            
            #add-point:AFTER FIELD imaa139 name="input.a.imaa139"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2013',g_imaa_m.imaa139) RETURNING g_imaa_m.imaa139_desc
            DISPLAY BY NAME g_imaa_m.imaa139_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa139) THEN 
               LET p_req_data[1] = 2013
               LET p_req_data[2] = g_imaa_m.imaa139
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa139
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa139 = g_imaa_m_t.imaa139
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2013',g_imaa_m.imaa139) RETURNING g_imaa_m.imaa139_desc
                  DISPLAY BY NAME g_imaa_m.imaa139_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa139
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa139
            #add-point:BEFORE FIELD imaa139 name="input.b.imaa139"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa139
            #add-point:ON CHANGE imaa139 name="input.g.imaa139"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa140
            
            #add-point:AFTER FIELD imaa140 name="input.a.imaa140"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2014',g_imaa_m.imaa140) RETURNING g_imaa_m.imaa140_desc
            DISPLAY BY NAME g_imaa_m.imaa140_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa140) THEN 
               LET p_req_data[1] = 2014
               LET p_req_data[2] = g_imaa_m.imaa140
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa140
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa140 = g_imaa_m_t.imaa140
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2014',g_imaa_m.imaa140) RETURNING g_imaa_m.imaa140_desc
                  DISPLAY BY NAME g_imaa_m.imaa140_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa140
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa140
            #add-point:BEFORE FIELD imaa140 name="input.b.imaa140"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa140
            #add-point:ON CHANGE imaa140 name="input.g.imaa140"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa141
            
            #add-point:AFTER FIELD imaa141 name="input.a.imaa141"
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2015',g_imaa_m.imaa141) RETURNING g_imaa_m.imaa141_desc
            DISPLAY BY NAME g_imaa_m.imaa141_desc
            #141231-00010#1--add--end----
            IF NOT cl_null(g_imaa_m.imaa141) THEN 
               LET p_req_data[1] = 2015
               LET p_req_data[2] = g_imaa_m.imaa141
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa141
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa141 = g_imaa_m_t.imaa141
                  #141231-00010#1--add--begin----
                  CALL s_desc_get_acc_desc('2015',g_imaa_m.imaa141) RETURNING g_imaa_m.imaa141_desc
                  DISPLAY BY NAME g_imaa_m.imaa141_desc
                  #141231-00010#1--add--end----
                  NEXT FIELD imaa141
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa141
            #add-point:BEFORE FIELD imaa141 name="input.b.imaa141"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa141
            #add-point:ON CHANGE imaa141 name="input.g.imaa141"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa011
            #add-point:BEFORE FIELD imaa011 name="input.b.imaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa011
            
            #add-point:AFTER FIELD imaa011 name="input.a.imaa011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa011
            #add-point:ON CHANGE imaa011 name="input.g.imaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa012
            #add-point:BEFORE FIELD imaa012 name="input.b.imaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa012
            
            #add-point:AFTER FIELD imaa012 name="input.a.imaa012"
                        IF NOT cl_null(g_imaa_m.imaa012) THEN 
               LET p_req_data[1] = g_imaa_m.imaa012
               CALL s_aimm200_fields_chk('imaa012',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa012 = g_imaa_m_t.imaa012
                  NEXT FIELD imaa012
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa012
            #add-point:ON CHANGE imaa012 name="input.g.imaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa013
            #add-point:BEFORE FIELD imaa013 name="input.b.imaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa013
            
            #add-point:AFTER FIELD imaa013 name="input.a.imaa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa013
            #add-point:ON CHANGE imaa013 name="input.g.imaa013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa014
            #add-point:BEFORE FIELD imaa014 name="input.b.imaa014"
            IF cl_null(g_imaa_m.imaa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00162'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD imaa001
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa014
            
            #add-point:AFTER FIELD imaa014 name="input.a.imaa014"
            IF NOT cl_null(g_imaa_m.imaa014) THEN
#               IF g_imaa_m.imaa014 != g_imaa_m_o.imaa014 OR g_imaa_m_o.imaa014 IS NULL THEN   #150427-00012#6 20150707 mark by beckxie 
               IF g_imaa_m.imaa014 != g_imaa_m_o.imaa014 OR cl_null(g_imaa_m_o.imaa014) THEN    #150427-00012#6 20150707 add by beckxie 
                  CALL aslm200_chk_barcode(g_imaa_m.imaa014)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imaa_m.imaa014
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imaa_m.imaa014 = g_imaa_m_o.imaa014
                     IF NOT cl_null(g_imaa_m_o.imaa014) THEN
                        LET g_imaa_m.imaa014 = g_imaa_m_o.imaa014
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #20140514--dongsz--add---
               IF g_imaa_m.imaa100 = '1' THEN
                  CALL s_chk_barcode(g_imaa_m.imaa014) RETURNING g_success
                  IF g_success = 'N' THEN
                    #Mark&Add By 150204-00001#28 -- Begin --
                    #LET g_imaa_m.imaa014 = g_imaa_m_o.imaa014
                     IF NOT cl_null(g_imaa_m_o.imaa014) THEN
                        LET g_imaa_m.imaa014 = g_imaa_m_o.imaa014
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #20140514--dongsz--add---
               IF g_imaa_m.imaa100<> '3' THEN   #add by tangyi 160818-为3款号时不判断-str-#160818-00039
               #150906-00005#2 20151126 add by beckxie---S
               IF NOT s_artt300_chk_imba014(g_imaa_m.imaa014) THEN
                  IF NOT cl_null(g_imaa_m_o.imaa014) THEN
                     LET g_imaa_m.imaa014 = g_imaa_m_o.imaa014
                  END IF
                  NEXT FIELD CURRENT
               END IF
               #150906-00005#2 20151126 add by beckxie---E
               END IF #add by tangyi 160818-end
            END IF
            LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa014
            #add-point:ON CHANGE imaa014 name="input.g.imaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa100
            #add-point:BEFORE FIELD imaa100 name="input.b.imaa100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa100
            
            #add-point:AFTER FIELD imaa100 name="input.a.imaa100"
            LET g_imaa_m_o.imaa100 = g_imaa_m.imaa100
            LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa100
            #add-point:ON CHANGE imaa100 name="input.g.imaa100"
            IF p_cmd = 'a' THEN
               IF g_imaa_m.imaa100 = '1' AND NOT cl_null(g_imaa_m.imaa014) THEN
                  CALL s_chk_barcode(g_imaa_m.imaa014) RETURNING g_success
                  IF g_success = 'N' THEN
                     LET g_imaa_m.imaa100 = g_imaa_m_o.imaa100
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #dongsz--add--str---
            IF g_imaa_m.imaa100 <> g_imaa_m_o.imaa100 OR cl_null(g_imaa_m_o.imaa100) THEN
              #161228-00033#4 161230 by lori mod---(S)
              #SELECT imay003 INTO g_imaa_m.imaa014
              #  FROM imay_t
              # WHERE imayent = g_enterprise
              #   AND imay001 = g_imaa_m.imaa001
              #   AND imay002 = g_imaa_m.imaa100
              #   AND ROWNUM = 1
              # ORDER BY imay003
              LET g_sql = "SELECT imay003 ",
                          "  FROM imay_t ",
                          " WHERE imayent = ",g_enterprise,
                          "   AND imay001 = '",g_imaa_m.imaa001,"' ",
                          "   AND imay002 = '",g_imaa_m.imaa100,"' ",
                          " ORDER BY imay003 "
               PREPARE aslm200_sel_imay003_pre FROM g_sql
               DECLARE aslm200_sel_imay003_cur SCROLL CURSOR FOR aslm200_sel_imay003_pre   
               OPEN aslm200_sel_imay003_cur   
               FETCH FIRST aslm200_sel_imay003_cur INTO g_imaa_m.imaa014  
               CLOSE aslm200_sel_imay003_cur               
               FREE aslm200_sel_imay003_pre
               #161228-00033#4 161230 by lori mod---(E) 
               IF SQLCA.sqlcode = 100 THEN
                  LET g_imaa_m.imaa014 = ""
               END IF
               DISPLAY BY NAME g_imaa_m.imaa014
            END IF
            #dongsz--add--end---
            
            CALL aslm200_set_entry(p_cmd)
            CALL aslm200_set_no_entry(p_cmd)
            
            LET g_imaa_m_o.imaa100 = g_imaa_m.imaa100
            LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa109
            #add-point:BEFORE FIELD imaa109 name="input.b.imaa109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa109
            
            #add-point:AFTER FIELD imaa109 name="input.a.imaa109"
            LET g_imaa_m_o.imaa109 = g_imaa_m.imaa109
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa109
            #add-point:ON CHANGE imaa109 name="input.g.imaa109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="input.b.imaa154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            
            #add-point:AFTER FIELD imaa154 name="input.a.imaa154"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa154
            #add-point:ON CHANGE imaa154 name="input.g.imaa154"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa155
            #add-point:BEFORE FIELD imaa155 name="input.b.imaa155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa155
            
            #add-point:AFTER FIELD imaa155 name="input.a.imaa155"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa155
            #add-point:ON CHANGE imaa155 name="input.g.imaa155"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa156
            #add-point:BEFORE FIELD imaa156 name="input.b.imaa156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa156
            
            #add-point:AFTER FIELD imaa156 name="input.a.imaa156"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa156
            #add-point:ON CHANGE imaa156 name="input.g.imaa156"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa116
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa116,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa116
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa116 name="input.a.imaa116"
            IF NOT cl_null(g_imaa_m.imaa116) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa116
            #add-point:BEFORE FIELD imaa116 name="input.b.imaa116"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa116
            #add-point:ON CHANGE imaa116 name="input.g.imaa116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa158
            #add-point:BEFORE FIELD imaa158 name="input.b.imaa158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa158
            
            #add-point:AFTER FIELD imaa158 name="input.a.imaa158"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa158
            #add-point:ON CHANGE imaa158 name="input.g.imaa158"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa143
            
            #add-point:AFTER FIELD imaa143 name="input.a.imaa143"
          #add by tangyi 161008-str-        
          LET g_imaa_m.imaa143_desc = ' '
            DISPLAY BY NAME g_imaa_m.imaa143_desc
            IF NOT cl_null(g_imaa_m.imaa143) THEN
               #150427-00012#6 150529 add by beckxie
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_imaa_m.imaa143 != g_imaa_m_o.imaa143 OR g_imaa_m_o.imaa143 IS NULL)) THEN
               IF g_imaa_m.imaa143 != g_imaa_m_o.imaa143 OR cl_null(g_imaa_m_o.imaa143) THEN   #150427-00012#6 150529 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imaa_m.imaa143
                  IF NOT cl_chk_exist("v_dbba001") THEN
                     LET g_imaa_m.imaa143 = g_imaa_m_o.imaa143
                     CALL aslm200_imaa143_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aslm200_chk_imaa143('1')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imaa_m.imaa143 = g_imaa_m_o.imaa143
                     CALL aslm200_imaa143_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aslm200_imaa143_ref()
            LET g_imaa_m_o.imaa143 = g_imaa_m.imaa143
           #add by tangyi 161008-end-
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa143
            #add-point:BEFORE FIELD imaa143 name="input.b.imaa143"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa143
            #add-point:ON CHANGE imaa143 name="input.g.imaa143"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa142
            
            #add-point:AFTER FIELD imaa142 name="input.a.imaa142"
                        IF NOT cl_null(g_imaa_m.imaa142) THEN 
               LET p_req_data[1] = g_imaa_m.imaa142
               CALL s_aimm200_fields_chk('imaa142',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa142
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa142 = g_imaa_m_t.imaa142
                  LET g_imaa_m.imaa142_desc = g_imaa_m_t.imaa142_desc
                  DISPLAY BY NAME g_imaa_m.imaa142_desc
                  NEXT FIELD imaa142
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa142
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa142_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa142_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa142
            #add-point:BEFORE FIELD imaa142 name="input.b.imaa142"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa142
            #add-point:ON CHANGE imaa142 name="input.g.imaa142"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa108
            #add-point:BEFORE FIELD imaa108 name="input.b.imaa108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa108
            
            #add-point:AFTER FIELD imaa108 name="input.a.imaa108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa108
            #add-point:ON CHANGE imaa108 name="input.g.imaa108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa110
            #add-point:BEFORE FIELD imaa110 name="input.b.imaa110"
            CALL aslm200_set_entry(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa110
            
            #add-point:AFTER FIELD imaa110 name="input.a.imaa110"
            IF g_imaa_m.imaa110 = 'N' THEN
               LET g_imaa_m.imaa111 = ''
               LET g_imaa_m.imaa112 = ''               
            ELSE
               LET g_imaa_m.imaa111 = g_imaa_m_t.imaa111
               LET g_imaa_m.imaa112 = g_imaa_m_t.imaa112               
            END IF
            DISPLAY BY NAME g_imaa_m.imaa111,g_imaa_m.imaa112
            
            CALL aslm200_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa110
            #add-point:ON CHANGE imaa110 name="input.g.imaa110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa111
            #add-point:BEFORE FIELD imaa111 name="input.b.imaa111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa111
            
            #add-point:AFTER FIELD imaa111 name="input.a.imaa111"
            IF NOT cl_null(g_imaa_m.imaa111) AND NOT cl_null(g_imaa_m.imaa112) THEN
               IF g_imaa_m.imaa111 > g_imaa_m.imaa112 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = g_imaa_m.imaa111
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa111 = g_imaa_m_t.imaa111
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa111
            #add-point:ON CHANGE imaa111 name="input.g.imaa111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa112
            #add-point:BEFORE FIELD imaa112 name="input.b.imaa112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa112
            
            #add-point:AFTER FIELD imaa112 name="input.a.imaa112"
            IF NOT cl_null(g_imaa_m.imaa111) AND NOT cl_null(g_imaa_m.imaa112) THEN
               IF g_imaa_m.imaa111 > g_imaa_m.imaa112 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = g_imaa_m.imaa111
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa112 = g_imaa_m_t.imaa112
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa112
            #add-point:ON CHANGE imaa112 name="input.g.imaa112"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa121
            #add-point:BEFORE FIELD imaa121 name="input.b.imaa121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa121
            
            #add-point:AFTER FIELD imaa121 name="input.a.imaa121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa121
            #add-point:ON CHANGE imaa121 name="input.g.imaa121"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa124
            
            #add-point:AFTER FIELD imaa124 name="input.a.imaa124"
            IF NOT cl_null(g_imaa_m.imaa124) THEN            
#               LET p_req_data[1] = g_imaa_m.imaa124
#               CALL s_aslm200_fields_chk('imaa124',p_req_data,'N') RETURNING l_success,g_errno
#               IF NOT l_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_imaa_m.imaa124
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_imaa_m.imaa124 = g_imaa_m_t.imaa124
#                  LET g_imaa_m.imaa124_desc = g_imaa_m_t.imaa124_desc
#                  DISPLAY BY NAME g_imaa_m.imaa124_desc 
#                  NEXT FIELD imaa124
#               END IF
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt
                  FROM oodb_t
                 WHERE oodbent = g_enterprise
                   AND oodb002 = g_imaa_m.imaa124
                   AND oodbstus = 'Y'
                IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00222'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa124 = g_imaa_m_t.imaa124
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa124
                  CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaa124_desc = '('|| g_rtn_fields[1] || ')'
                  DISPLAY BY NAME g_imaa_m.imaa124_desc
                  NEXT FIELD imaa124
               END IF   
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa124
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa124_desc = '('|| g_rtn_fields[1] || ')'
            DISPLAY BY NAME g_imaa_m.imaa124_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa124
            #add-point:BEFORE FIELD imaa124 name="input.b.imaa124"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa124
            #add-point:ON CHANGE imaa124 name="input.g.imaa124"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa016,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa016
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa016 name="input.a.imaa016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa016
            #add-point:BEFORE FIELD imaa016 name="input.b.imaa016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa016
            #add-point:ON CHANGE imaa016 name="input.g.imaa016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa017
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa017 name="input.a.imaa017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa017
            #add-point:BEFORE FIELD imaa017 name="input.b.imaa017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa017
            #add-point:ON CHANGE imaa017 name="input.g.imaa017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa018
            
            #add-point:AFTER FIELD imaa018 name="input.a.imaa018"
                        IF NOT cl_null(g_imaa_m.imaa018) THEN 
               LET p_req_data[1] = g_imaa_m.imaa018
               CALL s_aimm200_fields_chk('imaa018',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa018 = g_imaa_m_t.imaa018
                  LET g_imaa_m.imaa018_desc = g_imaa_m_t.imaa018_desc
                  DISPLAY BY NAME g_imaa_m.imaa018_desc
                  NEXT FIELD imaa018
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa018_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa018_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa018
            #add-point:BEFORE FIELD imaa018 name="input.b.imaa018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa018
            #add-point:ON CHANGE imaa018 name="input.g.imaa018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa159
            #add-point:BEFORE FIELD imaa159 name="input.b.imaa159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa159
            
            #add-point:AFTER FIELD imaa159 name="input.a.imaa159"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa159
            #add-point:ON CHANGE imaa159 name="input.g.imaa159"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa160
            #add-point:BEFORE FIELD imaa160 name="input.b.imaa160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa160
            
            #add-point:AFTER FIELD imaa160 name="input.a.imaa160"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa160
            #add-point:ON CHANGE imaa160 name="input.g.imaa160"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa019
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa019 name="input.a.imaa019"
                        IF NOT cl_null(g_imaa_m.imaa019) AND NOT cl_null(g_imaa_m.imaa020) THEN 
               LET g_imaa_m.imaa023 = g_imaa_m.imaa019*g_imaa_m.imaa020
               DISPLAY BY NAME g_imaa_m.imaa023
               IF NOT cl_null(g_imaa_m.imaa021) THEN
                  LET g_imaa_m.imaa025 = g_imaa_m.imaa023*g_imaa_m.imaa021
                  DISPLAY BY NAME g_imaa_m.imaa025
               END IF   
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa019
            #add-point:BEFORE FIELD imaa019 name="input.b.imaa019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa019
            #add-point:ON CHANGE imaa019 name="input.g.imaa019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa020
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa020 name="input.a.imaa020"
                        IF NOT cl_null(g_imaa_m.imaa019) AND NOT cl_null(g_imaa_m.imaa020) THEN 
               LET g_imaa_m.imaa023 = g_imaa_m.imaa019*g_imaa_m.imaa020
               DISPLAY BY NAME g_imaa_m.imaa023
               IF NOT cl_null(g_imaa_m.imaa021) THEN
                  LET g_imaa_m.imaa025 = g_imaa_m.imaa023*g_imaa_m.imaa021
                  DISPLAY BY NAME g_imaa_m.imaa025
               END IF   
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa020
            #add-point:BEFORE FIELD imaa020 name="input.b.imaa020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa020
            #add-point:ON CHANGE imaa020 name="input.g.imaa020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa021
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa021 name="input.a.imaa021"
                        IF NOT cl_null(g_imaa_m.imaa019) AND NOT cl_null(g_imaa_m.imaa020) THEN 
               LET g_imaa_m.imaa023 = g_imaa_m.imaa019*g_imaa_m.imaa020
               DISPLAY BY NAME g_imaa_m.imaa023
               IF NOT cl_null(g_imaa_m.imaa021) THEN
                  LET g_imaa_m.imaa025 = g_imaa_m.imaa023*g_imaa_m.imaa021
                  DISPLAY BY NAME g_imaa_m.imaa025
               END IF   
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa021
            #add-point:BEFORE FIELD imaa021 name="input.b.imaa021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa021
            #add-point:ON CHANGE imaa021 name="input.g.imaa021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa022
            
            #add-point:AFTER FIELD imaa022 name="input.a.imaa022"
                        IF NOT cl_null(g_imaa_m.imaa022) THEN
               LET p_req_data[1] = g_imaa_m.imaa022
               CALL s_aimm200_fields_chk('imaa022',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa022 = g_imaa_m_t.imaa022
                  LET g_imaa_m.imaa022_desc = g_imaa_m_t.imaa022_desc
                  DISPLAY BY NAME g_imaa_m.imaa022_desc
                  NEXT FIELD imaa022
               END IF
               SELECT ooca006,ooca007 INTO g_imaa_m.imaa024,g_imaa_m.imaa026 FROM ooca_t
                WHERE oocaent = g_enterprise
                  AND ooca001 = g_imaa_m.imaa022
               DISPLAY BY NAME g_imaa_m.imaa024,g_imaa_m.imaa026
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa022
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa022_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa022_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa022
            #add-point:BEFORE FIELD imaa022 name="input.b.imaa022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa022
            #add-point:ON CHANGE imaa022 name="input.g.imaa022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa023
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa023 name="input.a.imaa023"
                        IF NOT cl_null(g_imaa_m.imaa023) THEN
               LET p_req_data[1] = g_imaa_m.imaa023
               CALL s_aimm200_fields_chk('imaa023',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa023
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa023 = g_imaa_m_t.imaa023
                  NEXT FIELD imaa023
               END IF            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa023
            #add-point:BEFORE FIELD imaa023 name="input.b.imaa023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa023
            #add-point:ON CHANGE imaa023 name="input.g.imaa023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa024
            #add-point:BEFORE FIELD imaa024 name="input.b.imaa024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa024
            
            #add-point:AFTER FIELD imaa024 name="input.a.imaa024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa024
            #add-point:ON CHANGE imaa024 name="input.g.imaa024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa025
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa025 name="input.a.imaa025"
                        IF NOT cl_null(g_imaa_m.imaa025) THEN 
               LET p_req_data[1] = g_imaa_m.imaa025
               CALL s_aimm200_fields_chk('imaa025',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa025
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa025 = g_imaa_m_t.imaa025
                  NEXT FIELD imaa025
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa025
            #add-point:BEFORE FIELD imaa025 name="input.b.imaa025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa025
            #add-point:ON CHANGE imaa025 name="input.g.imaa025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa026
            #add-point:BEFORE FIELD imaa026 name="input.b.imaa026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa026
            
            #add-point:AFTER FIELD imaa026 name="input.a.imaa026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa026
            #add-point:ON CHANGE imaa026 name="input.g.imaa026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa027
            #add-point:BEFORE FIELD imaa027 name="input.b.imaa027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa027
            
            #add-point:AFTER FIELD imaa027 name="input.a.imaa027"
                        IF NOT cl_null(g_imaa_m.imaa027) THEN 
               LET p_req_data[1] = g_imaa_m.imaa027
               CALL s_aimm200_fields_chk('imaa027',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa027
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa027 = g_imaa_m_t.imaa027
                  NEXT FIELD imaa027
               END IF
               IF g_imaa_m.imaa027 = 'Y' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",TRUE)
               ELSE
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)                               
               END IF   
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa027
            #add-point:ON CHANGE imaa027 name="input.g.imaa027"
                         IF g_imaa_m.imaa027 = 'N' THEN     
                LET g_imaa_m.imaa028 = ""
                LET g_imaa_m.imaa029 = ""
                LET g_imaa_m.imaa030 = ""  
                LET g_imaa_m.imaa031 = ""
                LET g_imaa_m.imaa032 = "" 
                LET g_imaa_m.imaa033 = ""  
                LET g_imaa_m.imaa029_desc = ""
                LET g_imaa_m.imaa032_desc = "" 
                DISPLAY BY NAME g_imaa_m.imaa029_desc
                DISPLAY BY NAME g_imaa_m.imaa032_desc
             END IF                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa028
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa028,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa028
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa028 name="input.a.imaa028"
                        IF NOT cl_null(g_imaa_m.imaa028) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa028
            #add-point:BEFORE FIELD imaa028 name="input.b.imaa028"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa028
            #add-point:ON CHANGE imaa028 name="input.g.imaa028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa029
            
            #add-point:AFTER FIELD imaa029 name="input.a.imaa029"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa029
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa029_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa029_desc
            
            IF NOT cl_null(g_imaa_m.imaa029) THEN 
               LET p_req_data[1] = g_imaa_m.imaa029
               CALL s_aimm200_fields_chk('imaa029',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa029
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa029 = g_imaa_m_t.imaa029
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa029
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaa029_desc =  g_rtn_fields[1] 
                  DISPLAY BY NAME g_imaa_m.imaa029_desc
                  NEXT FIELD imaa029
               END IF
            END IF   
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa029
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa029_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa029_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa029
            #add-point:BEFORE FIELD imaa029 name="input.b.imaa029"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa029
            #add-point:ON CHANGE imaa029 name="input.g.imaa029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa030,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imaa030
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa030 name="input.a.imaa030"
                        IF NOT cl_null(g_imaa_m.imaa030) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa030
            #add-point:BEFORE FIELD imaa030 name="input.b.imaa030"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa030
            #add-point:ON CHANGE imaa030 name="input.g.imaa030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa031,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaa031
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa031 name="input.a.imaa031"
                        IF NOT cl_null(g_imaa_m.imaa031) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa031
            #add-point:BEFORE FIELD imaa031 name="input.b.imaa031"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa031
            #add-point:ON CHANGE imaa031 name="input.g.imaa031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa032
            
            #add-point:AFTER FIELD imaa032 name="input.a.imaa032"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa032
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa032_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa032_desc

            IF NOT cl_null(g_imaa_m.imaa032) THEN 
               LET p_req_data[1] = g_imaa_m.imaa032
               CALL s_aimm200_fields_chk('imaa032',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa032
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa032 = g_imaa_m_t.imaa032
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa032
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaa032_desc =  g_rtn_fields[1] 
                  DISPLAY BY NAME g_imaa_m.imaa032_desc
                  NEXT FIELD imaa032
               END IF
            END IF           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa032
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa032_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa032_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa032
            #add-point:BEFORE FIELD imaa032 name="input.b.imaa032"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa032
            #add-point:ON CHANGE imaa032 name="input.g.imaa032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaa_m.imaa033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imaa033
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa033 name="input.a.imaa033"
                        IF NOT cl_null(g_imaa_m.imaa033) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa033
            #add-point:BEFORE FIELD imaa033 name="input.b.imaa033"
                           IF g_imaa_m.imaa027 = 'N' THEN
                  CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033",FALSE)  
               END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa033
            #add-point:ON CHANGE imaa033 name="input.g.imaa033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa034
            #add-point:BEFORE FIELD imaa034 name="input.b.imaa034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa034
            
            #add-point:AFTER FIELD imaa034 name="input.a.imaa034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa034
            #add-point:ON CHANGE imaa034 name="input.g.imaa034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa035
            #add-point:BEFORE FIELD imaa035 name="input.b.imaa035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa035
            
            #add-point:AFTER FIELD imaa035 name="input.a.imaa035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa035
            #add-point:ON CHANGE imaa035 name="input.g.imaa035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa036
            #add-point:BEFORE FIELD imaa036 name="input.b.imaa036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa036
            
            #add-point:AFTER FIELD imaa036 name="input.a.imaa036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa036
            #add-point:ON CHANGE imaa036 name="input.g.imaa036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa037
            #add-point:BEFORE FIELD imaa037 name="input.b.imaa037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa037
            
            #add-point:AFTER FIELD imaa037 name="input.a.imaa037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa037
            #add-point:ON CHANGE imaa037 name="input.g.imaa037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa043
            #add-point:BEFORE FIELD imaa043 name="input.b.imaa043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa043
            
            #add-point:AFTER FIELD imaa043 name="input.a.imaa043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa043
            #add-point:ON CHANGE imaa043 name="input.g.imaa043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa038
            #add-point:BEFORE FIELD imaa038 name="input.b.imaa038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa038
            
            #add-point:AFTER FIELD imaa038 name="input.a.imaa038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa038
            #add-point:ON CHANGE imaa038 name="input.g.imaa038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa039
            
            #add-point:AFTER FIELD imaa039 name="input.a.imaa039"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa039
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa039_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa039_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa039
            #add-point:BEFORE FIELD imaa039 name="input.b.imaa039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa039
            #add-point:ON CHANGE imaa039 name="input.g.imaa039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa040
            #add-point:BEFORE FIELD imaa040 name="input.b.imaa040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa040
            
            #add-point:AFTER FIELD imaa040 name="input.a.imaa040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa040
            #add-point:ON CHANGE imaa040 name="input.g.imaa040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa041
            #add-point:BEFORE FIELD imaa041 name="input.b.imaa041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa041
            
            #add-point:AFTER FIELD imaa041 name="input.a.imaa041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa041
            #add-point:ON CHANGE imaa041 name="input.g.imaa041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa042
            #add-point:BEFORE FIELD imaa042 name="input.b.imaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa042
            
            #add-point:AFTER FIELD imaa042 name="input.a.imaa042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa042
            #add-point:ON CHANGE imaa042 name="input.g.imaa042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa044
            #add-point:BEFORE FIELD imaa044 name="input.b.imaa044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa044
            
            #add-point:AFTER FIELD imaa044 name="input.a.imaa044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa044
            #add-point:ON CHANGE imaa044 name="input.g.imaa044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.ooff013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa122
            
            #add-point:AFTER FIELD imaa122 name="input.a.imaa122"
                        IF NOT cl_null(g_imaa_m.imaa122) THEN  
               LET p_req_data[1] = 2000
               LET p_req_data[2] = g_imaa_m.imaa122
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa122
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa122 = g_imaa_m_t.imaa122
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaa_m.imaa122
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaa_m.imaa122_desc =  g_rtn_fields[1] 
                  DISPLAY BY NAME g_imaa_m.imaa122_desc
                  NEXT FIELD imaa122
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa122
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa122_desc =  g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa122_desc
                      

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa122
            #add-point:BEFORE FIELD imaa122 name="input.b.imaa122"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa122
            #add-point:ON CHANGE imaa122 name="input.g.imaa122"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa045
            
            #add-point:AFTER FIELD imaa045 name="input.a.imaa045"
                        IF NOT cl_null(g_imaa_m.imaa045) THEN            
               LET p_req_data[1] = g_imaa_m.imaa045
               CALL s_aimm200_fields_chk('imaa045',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaa_m.imaa045
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi020'
                  LET g_errparam.replace[2] = cl_get_progname('aooi020',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi020'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaa_m.imaa045 = g_imaa_m_t.imaa045
                  LET g_imaa_m.imaa045_desc = g_imaa_m_t.imaa045_desc
                  DISPLAY BY NAME g_imaa_m.imaa045_desc 
                  NEXT FIELD imaa045
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa045
            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaa_m.imaa045_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imaa_m.imaa045_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa045
            #add-point:BEFORE FIELD imaa045 name="input.b.imaa045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa045
            #add-point:ON CHANGE imaa045 name="input.g.imaa045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa123
            #add-point:BEFORE FIELD imaa123 name="input.b.imaa123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa123
            
            #add-point:AFTER FIELD imaa123 name="input.a.imaa123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa123
            #add-point:ON CHANGE imaa123 name="input.g.imaa123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imac002
            #add-point:BEFORE FIELD imac002 name="input.b.imac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imac002
            
            #add-point:AFTER FIELD imac002 name="input.a.imac002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imac002
            #add-point:ON CHANGE imac002 name="input.g.imac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imac003
            #add-point:BEFORE FIELD imac003 name="input.b.imac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imac003
            
            #add-point:AFTER FIELD imac003 name="input.a.imac003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imac003
            #add-point:ON CHANGE imac003 name="input.g.imac003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="input.c.imaa001"
            
            #150313---earl---add---s
            IF cl_null(g_imaa_m.imaa001) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
               IF l_sys = 'Y' THEN
                   CALL aslm200_aooi390_default()
               END IF 
            END IF
            #150313---earl---add---e
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="input.c.imaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="input.c.imaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="input.c.imaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="input.c.imaal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.imaa009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa009             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_imaa_m.imaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa009 TO imaa009              #顯示到畫面上

            NEXT FIELD imaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.imaa003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa003             #給予default值          

            CALL q_imca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa003 TO imaa003              #顯示到畫面上

            NEXT FIELD imaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="input.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="input.c.imaa005"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa005             #給予default值

            #給予arg

            CALL q_imea001()                                #呼叫開窗

            LET g_imaa_m.imaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa005 TO imaa005              #顯示到畫面上

            NEXT FIELD imaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="input.c.imaa006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa006 TO imaa006              #顯示到畫面上

            NEXT FIELD imaa006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="input.c.imaa010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "210" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa010 TO imaa010              #顯示到畫面上

            NEXT FIELD imaa010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaastus
            #add-point:ON ACTION controlp INFIELD imaastus name="input.c.imaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD imaa126 name="input.c.imaa126"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa126             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2002" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa126 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa126 TO imaa126              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2002',g_imaa_m.imaa126) RETURNING g_imaa_m.imaa126_desc
            DISPLAY BY NAME g_imaa_m.imaa126_desc
            #141231-00010#1--add--end----


            NEXT FIELD imaa126                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa127
            #add-point:ON ACTION controlp INFIELD imaa127 name="input.c.imaa127"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa127             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2003" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa127 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa127 TO imaa127              #顯示到畫面上
            CALL s_desc_get_acc_desc('2003',g_imaa_m.imaa127)
                 RETURNING g_imaa_m.imaa127_desc
            DISPLAY BY NAME g_imaa_m.imaa127_desc

            NEXT FIELD imaa127                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa131
            #add-point:ON ACTION controlp INFIELD imaa131 name="input.c.imaa131"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa131             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2001" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa131 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa131 TO imaa131              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2001',g_imaa_m.imaa131) RETURNING g_imaa_m.imaa131_desc
            DISPLAY BY NAME g_imaa_m.imaa131_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa131                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa128
            #add-point:ON ACTION controlp INFIELD imaa128 name="input.c.imaa128"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa128             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2004" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa128 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa128 TO imaa128              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2004',g_imaa_m.imaa128) RETURNING g_imaa_m.imaa128_desc
            DISPLAY BY NAME g_imaa_m.imaa128_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa128                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa129
            #add-point:ON ACTION controlp INFIELD imaa129 name="input.c.imaa129"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa129             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2005" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa129 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa129 TO imaa129              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2005',g_imaa_m.imaa129) RETURNING g_imaa_m.imaa129_desc
            DISPLAY BY NAME g_imaa_m.imaa129_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa129                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa130
            #add-point:ON ACTION controlp INFIELD imaa130 name="input.c.imaa130"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="input.c.imaa132"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa132             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2006" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa132 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa132 TO imaa132              #顯示到畫面上
            CALL s_desc_get_acc_desc('2006',g_imaa_m.imaa132)
                 RETURNING g_imaa_m.imaa132_desc
            DISPLAY BY NAME g_imaa_m.imaa132_desc

            NEXT FIELD imaa132                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa133
            #add-point:ON ACTION controlp INFIELD imaa133 name="input.c.imaa133"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa133             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2007" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa133 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa133 TO imaa133              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2007',g_imaa_m.imaa133) RETURNING g_imaa_m.imaa133_desc
            DISPLAY BY NAME g_imaa_m.imaa133_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa133                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa134
            #add-point:ON ACTION controlp INFIELD imaa134 name="input.c.imaa134"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa134             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2008" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa134 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa134 TO imaa134              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2008',g_imaa_m.imaa134) RETURNING g_imaa_m.imaa134_desc
            DISPLAY BY NAME g_imaa_m.imaa134_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa134                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa135
            #add-point:ON ACTION controlp INFIELD imaa135 name="input.c.imaa135"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa135             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2009" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa135 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa135 TO imaa135              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2009',g_imaa_m.imaa135) RETURNING g_imaa_m.imaa135_desc
            DISPLAY BY NAME g_imaa_m.imaa135_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa135                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa136
            #add-point:ON ACTION controlp INFIELD imaa136 name="input.c.imaa136"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa136             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2010" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa136 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa136 TO imaa136              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2010',g_imaa_m.imaa136) RETURNING g_imaa_m.imaa136_desc
            DISPLAY BY NAME g_imaa_m.imaa136_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa136                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa137
            #add-point:ON ACTION controlp INFIELD imaa137 name="input.c.imaa137"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa137             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2011" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa137 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa137 TO imaa137              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2011',g_imaa_m.imaa137) RETURNING g_imaa_m.imaa137_desc
            DISPLAY BY NAME g_imaa_m.imaa137_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa137                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa138
            #add-point:ON ACTION controlp INFIELD imaa138 name="input.c.imaa138"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa138             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2012" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa138 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa138 TO imaa138              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2012',g_imaa_m.imaa138) RETURNING g_imaa_m.imaa138_desc
            DISPLAY BY NAME g_imaa_m.imaa138_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa138                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa139
            #add-point:ON ACTION controlp INFIELD imaa139 name="input.c.imaa139"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa139             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2013" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa139 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa139 TO imaa139              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2013',g_imaa_m.imaa139) RETURNING g_imaa_m.imaa139_desc
            DISPLAY BY NAME g_imaa_m.imaa139_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa139                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa140
            #add-point:ON ACTION controlp INFIELD imaa140 name="input.c.imaa140"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa140             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2014" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa140 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa140 TO imaa140              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2014',g_imaa_m.imaa140) RETURNING g_imaa_m.imaa140_desc
            DISPLAY BY NAME g_imaa_m.imaa140_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa140                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa141
            #add-point:ON ACTION controlp INFIELD imaa141 name="input.c.imaa141"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa141             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2015" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa141 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa141 TO imaa141              #顯示到畫面上
            #141231-00010#1--add--begin----
            CALL s_desc_get_acc_desc('2015',g_imaa_m.imaa141) RETURNING g_imaa_m.imaa141_desc
            DISPLAY BY NAME g_imaa_m.imaa141_desc
            #141231-00010#1--add--end----

            NEXT FIELD imaa141                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa011
            #add-point:ON ACTION controlp INFIELD imaa011 name="input.c.imaa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa012
            #add-point:ON ACTION controlp INFIELD imaa012 name="input.c.imaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa013
            #add-point:ON ACTION controlp INFIELD imaa013 name="input.c.imaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa014
            #add-point:ON ACTION controlp INFIELD imaa014 name="input.c.imaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa100
            #add-point:ON ACTION controlp INFIELD imaa100 name="input.c.imaa100"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa109
            #add-point:ON ACTION controlp INFIELD imaa109 name="input.c.imaa109"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="input.c.imaa154"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa155
            #add-point:ON ACTION controlp INFIELD imaa155 name="input.c.imaa155"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa156
            #add-point:ON ACTION controlp INFIELD imaa156 name="input.c.imaa156"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa116
            #add-point:ON ACTION controlp INFIELD imaa116 name="input.c.imaa116"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa158
            #add-point:ON ACTION controlp INFIELD imaa158 name="input.c.imaa158"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa143
            #add-point:ON ACTION controlp INFIELD imaa143 name="input.c.imaa143"
            #應用 a07 樣板自動產生(Version:3)   
           #add by tangyi 161008-str-
             #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imaa_m.imaa143             #給予default值

            #給予arg
            #給予arg
            LET g_sql = ""
            IF NOT cl_null(g_imaa_m.imaa009) THEN
               LET r_success = ''
               LET r_errno = ''
               LET r_rtax001 = ''
               CALL s_arti202_search_manage_level(g_imaa_m.imaa009) 
                  RETURNING r_success,r_errno,r_rtax001
               IF r_success = FALSE THEN LET r_rtax001 = '' END IF
            END IF
            CASE
               WHEN cl_null(g_imaa_m.imaa009) AND NOT cl_null(g_imaa_m.imaa126)
                  LET g_sql = " (dbbb002 = '2' AND dbbb003 = '",g_imaa_m.imaa126,"')"
               WHEN NOT cl_null(g_imaa_m.imaa009) AND cl_null(g_imaa_m.imaa126)
                  LET g_sql = " (dbbb002 = '1' AND dbbb003 = '",r_rtax001,"')"
               WHEN NOT cl_null(g_imaa_m.imaa009) AND NOT cl_null(g_imaa_m.imaa126)
                  LET g_sql = " ((dbbb002 = '1' AND dbbb003 = '",r_rtax001,"') OR (dbbb002 = '2' AND dbbb003 = '",g_imaa_m.imaa126,"'))"
            END CASE
            LET g_qryparam.where = g_sql
            CALL q_dbba001_1()                                #呼叫開窗
            LET g_imaa_m.imaa143 = g_qryparam.return1    
            DISPLAY g_imaa_m.imaa143 TO imaa143
            CALL aslm200_imaa143_ref()
            NEXT FIELD imaa143                          #返回原欄位
           #add by tangyi 161008-end


            #END add-point
 
 
         #Ctrlp:input.c.imaa142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa142
            #add-point:ON ACTION controlp INFIELD imaa142 name="input.c.imaa142"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa142             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_imaa_m.imaa142 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa142 TO imaa142              #顯示到畫面上

            NEXT FIELD imaa142                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa108
            #add-point:ON ACTION controlp INFIELD imaa108 name="input.c.imaa108"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa110
            #add-point:ON ACTION controlp INFIELD imaa110 name="input.c.imaa110"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa111
            #add-point:ON ACTION controlp INFIELD imaa111 name="input.c.imaa111"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa112
            #add-point:ON ACTION controlp INFIELD imaa112 name="input.c.imaa112"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa121
            #add-point:ON ACTION controlp INFIELD imaa121 name="input.c.imaa121"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa124
            #add-point:ON ACTION controlp INFIELD imaa124 name="input.c.imaa124"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa124             #給予default值

            #給予arg

            CALL q_oodb002_4()                                #呼叫開窗

            LET g_imaa_m.imaa124 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa124 TO imaa124              #顯示到畫面上

            NEXT FIELD imaa124                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa016
            #add-point:ON ACTION controlp INFIELD imaa016 name="input.c.imaa016"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa017
            #add-point:ON ACTION controlp INFIELD imaa017 name="input.c.imaa017"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa018
            #add-point:ON ACTION controlp INFIELD imaa018 name="input.c.imaa018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            LET g_qryparam.default1 = g_imaa_m.imaa018             #給予default值
            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa018 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa018 TO imaa018              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imaa018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa159
            #add-point:ON ACTION controlp INFIELD imaa159 name="input.c.imaa159"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa160
            #add-point:ON ACTION controlp INFIELD imaa160 name="input.c.imaa160"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa019
            #add-point:ON ACTION controlp INFIELD imaa019 name="input.c.imaa019"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa020
            #add-point:ON ACTION controlp INFIELD imaa020 name="input.c.imaa020"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa021
            #add-point:ON ACTION controlp INFIELD imaa021 name="input.c.imaa021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa022
            #add-point:ON ACTION controlp INFIELD imaa022 name="input.c.imaa022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '2'"
            LET g_qryparam.default1 = g_imaa_m.imaa022             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa022 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_imaa_m.imaa022 TO imaa022              #顯示到畫面上

            NEXT FIELD imaa022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa023
            #add-point:ON ACTION controlp INFIELD imaa023 name="input.c.imaa023"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa024
            #add-point:ON ACTION controlp INFIELD imaa024 name="input.c.imaa024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa024             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa024 TO imaa024              #顯示到畫面上

            NEXT FIELD imaa024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa025
            #add-point:ON ACTION controlp INFIELD imaa025 name="input.c.imaa025"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa026
            #add-point:ON ACTION controlp INFIELD imaa026 name="input.c.imaa026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa026             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa026 TO imaa026              #顯示到畫面上

            NEXT FIELD imaa026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa027
            #add-point:ON ACTION controlp INFIELD imaa027 name="input.c.imaa027"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa028
            #add-point:ON ACTION controlp INFIELD imaa028 name="input.c.imaa028"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa029
            #add-point:ON ACTION controlp INFIELD imaa029 name="input.c.imaa029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '5'"
            LET g_qryparam.default1 = g_imaa_m.imaa029             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa029 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_imaa_m.imaa029 TO imaa029              #顯示到畫面上

            NEXT FIELD imaa029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa030
            #add-point:ON ACTION controlp INFIELD imaa030 name="input.c.imaa030"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa031
            #add-point:ON ACTION controlp INFIELD imaa031 name="input.c.imaa031"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa032
            #add-point:ON ACTION controlp INFIELD imaa032 name="input.c.imaa032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            LET g_qryparam.default1 = g_imaa_m.imaa032             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaa_m.imaa032 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_imaa_m.imaa032 TO imaa032              #顯示到畫面上

            NEXT FIELD imaa032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa033
            #add-point:ON ACTION controlp INFIELD imaa033 name="input.c.imaa033"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa034
            #add-point:ON ACTION controlp INFIELD imaa034 name="input.c.imaa034"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa035
            #add-point:ON ACTION controlp INFIELD imaa035 name="input.c.imaa035"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa036
            #add-point:ON ACTION controlp INFIELD imaa036 name="input.c.imaa036"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa037
            #add-point:ON ACTION controlp INFIELD imaa037 name="input.c.imaa037"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa043
            #add-point:ON ACTION controlp INFIELD imaa043 name="input.c.imaa043"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa043             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa043 TO imaa043              #顯示到畫面上

            NEXT FIELD imaa043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa038
            #add-point:ON ACTION controlp INFIELD imaa038 name="input.c.imaa038"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa039
            #add-point:ON ACTION controlp INFIELD imaa039 name="input.c.imaa039"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa040
            #add-point:ON ACTION controlp INFIELD imaa040 name="input.c.imaa040"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa041
            #add-point:ON ACTION controlp INFIELD imaa041 name="input.c.imaa041"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa042
            #add-point:ON ACTION controlp INFIELD imaa042 name="input.c.imaa042"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa044
            #add-point:ON ACTION controlp INFIELD imaa044 name="input.c.imaa044"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.ooff013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa122
            #add-point:ON ACTION controlp INFIELD imaa122 name="input.c.imaa122"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'

            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa122             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2000" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaa_m.imaa122 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa122 TO imaa122              #顯示到畫面上

            NEXT FIELD imaa122                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa045
            #add-point:ON ACTION controlp INFIELD imaa045 name="input.c.imaa045"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaa_m.imaa045             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_imaa_m.imaa045 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaa_m.imaa045 TO imaa045              #顯示到畫面上

            NEXT FIELD imaa045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa123
            #add-point:ON ACTION controlp INFIELD imaa123 name="input.c.imaa123"
            
            #END add-point
 
 
         #Ctrlp:input.c.imac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imac002
            #add-point:ON ACTION controlp INFIELD imac002 name="input.c.imac002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imac003
            #add-point:ON ACTION controlp INFIELD imac003 name="input.c.imac003"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imaa_m.imaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #20150417--add--geza---
               IF g_imaa_m.imaa100 = '2' THEN
                  IF g_imaa_m.imaa109 = '1' THEN
                     CALL s_auto_barcode('1') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     #CONTINUE DIALOG     #160125-00004#1 dongsz mark
                     NEXT FIELD CURRENT   #160125-00004#1 dongsz add
                  END IF
               END IF
               #20150417--add--geza---
               
               #ming 20150522 add ---------------------(S) 
               CALL s_aooi390_get_auto_no('1',g_imaa_m.imaa001) RETURNING l_success,g_imaa_m.imaa001

               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF

               #如果新的編碼與舊的不一樣 應該做更新 
               IF g_imaa_m_o.imaa001 != g_imaa_m.imaa001 AND NOT cl_null(g_imaa_m_o.imaa001) THEN
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imaal_t
                   WHERE imaalent = g_enterprise
                     AND imaal001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imaal_t SET imaal001 = g_imaa_m.imaa001
                      WHERE imaalent = g_enterprise
                        AND imaal001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imaal_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  
                  #15/06/30 Sarah add
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imao_t
                   WHERE imaoent = g_enterprise
                     AND imao001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imao_t SET imao001 = g_imaa_m.imaa001
                      WHERE imaoent = g_enterprise
                        AND imao001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imao_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imaj_t
                   WHERE imajent = g_enterprise
                     AND imaj001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imaj_t SET imaj001 = g_imaa_m.imaa001
                      WHERE imajent = g_enterprise
                        AND imaj001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imaj_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imak_t
                   WHERE imakent = g_enterprise
                     AND imak001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imak_t SET imak001 = g_imaa_m.imaa001
                      WHERE imakent = g_enterprise
                        AND imak001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imak_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imal_t
                   WHERE imalent = g_enterprise
                     AND imal001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imal_t SET imal001 = g_imaa_m.imaa001
                      WHERE imalent = g_enterprise
                        AND imal001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imal_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imam_t
                   WHERE imament = g_enterprise
                     AND imam001 = g_imaa_m_o.imaa001
                  IF l_count_chk > 0 THEN
                     UPDATE imam_t SET imam001 = g_imaa_m.imaa001
                      WHERE imament = g_enterprise
                        AND imam001 = g_imaa_m_o.imaa001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imam_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #15/06/30 Sarah add
               END IF
               #ming 20150522 add ---------------------(E) 
               
               CALL s_aooi390_oofi_upd('1',g_imaa_m.imaa001) RETURNING l_success  #add--2015/05/07 By shiun 增加編碼功能
               #end add-point
               
               INSERT INTO imaa_t (imaaent,imaa001,imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010, 
                   imaastus,imaa126,imaa127,imaa131,imaa128,imaa129,imaa130,imaa132,imaa133,imaa134, 
                   imaa135,imaa136,imaa137,imaa138,imaa139,imaa140,imaa141,imaaownid,imaaowndp,imaacrtid, 
                   imaacrtdp,imaacrtdt,imaamodid,imaamoddt,imaacnfid,imaacnfdt,imaa011,imaa012,imaa013, 
                   imaa014,imaa100,imaa109,imaa154,imaa155,imaa156,imaa116,imaa158,imaa143,imaa142,imaa108, 
                   imaa110,imaa111,imaa112,imaa121,imaa124,imaa016,imaa017,imaa018,imaa159,imaa160,imaa019, 
                   imaa020,imaa021,imaa022,imaa023,imaa024,imaa025,imaa026,imaa027,imaa028,imaa029,imaa030, 
                   imaa031,imaa032,imaa033,imaa034,imaa035,imaa036,imaa037,imaa043,imaa038,imaa039,imaa040, 
                   imaa041,imaa042,imaa044,imaa122,imaa045,imaa123)
               VALUES (g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003, 
                   g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
                   g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
                   g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135, 
                   g_imaa_m.imaa136,g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140, 
                   g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp, 
                   g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt,g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt, 
                   g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100, 
                   g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
                   g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110, 
                   g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016, 
                   g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019, 
                   g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024, 
                   g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029, 
                   g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
                   g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038, 
                   g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044, 
                   g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imaa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
                 IF p_cmd = 'a' AND l_cmd_t = 'a' THEN 
                    LET g_imaa001_t = g_imaa_m.imaa001
                 END IF 
                 
                 CALL aslm200_refresh_main_imay()
                 IF NOT cl_null(g_errno) THEN
                    CALL s_transaction_end('N','0')
                    CONTINUE DIALOG
                 END IF  
                 
                 #UPDATE 單身的庫存單位與計價單位               
                 UPDATE imay_t SET imay012 = g_imaa_m.imaa006,
                                   imay014 = g_imaa_m.imaa006
                  WHERE imayent = g_enterprise
                    AND imay001 = g_imaa_m.imaa001
                    
                 #整批更新單身的 包裝單位與計價單位的 單位換算率
                 IF NOT s_artm300_unit_trans_upd(g_imaa_m.imaa001,g_imaa_m.imaa006) THEN
                    CALL s_transaction_end('N','0')
                    CONTINUE DIALOG
                 END IF 
                 
                 LET l_flag = ""
                  ------2015-2-3 zj mod------               
                 IF g_con = 'Y' THEN        #若分群码有修改进行单身重填
                    CALL aslm200_ins_detail() RETURNING l_success
                    
                    IF l_success = "FALSE" THEN
                       LET l_flag = 'N'
                    END IF
                 END IF 
                 ------2015-2-3 zj mod------               
                 IF NOT cl_null(g_imaa_m.ooff013) THEN
                    CALL s_aooi360_gen('3',g_imaa_m.imaa001,'','','','','','','','','','4',g_imaa_m.ooff013) RETURNING l_success
                    IF l_success = "FALSE" THEN
                       LET l_flag = 'N'
                    END IF
                 ELSE
                    CALL s_aooi360_del('3',g_imaa_m.imaa001,'','','','','','','','','','4') RETURNING l_success
                    IF l_success = "FALSE" THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = "ooff_t"
                       LET g_errparam.popup = TRUE
                       CALL cl_err()

                       LET l_flag = 'N'  
                    END IF                                      
                 END IF                    
                  CALL s_aimm200_ins_item_site(g_imaa_m.imaa001,'1') RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imaa_m.imaa001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_flag = 'N'
                  END IF
                  SELECT imca003 INTO g_imaa_m.imac003 FROM imca_t WHERE imcaent = g_enterprise AND imca001 = g_imaa_m.imaa003 
                  INSERT INTO imac_t (imacent,imac001,imac002,imac003) VALUES (g_enterprise,g_imaa_m.imaa001,'N',g_imaa_m.imac003)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imac_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_flag = 'N'
                  END IF 
                  
                  #2015/03/05 by stellar modify ----- (S)
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM imao_t
#                   WHERE imaoent = g_enterprise
#                     AND imao001 = g_imaa_m.imaa001
                  #改成基礎單位(imaa006)不存在於料件允許使用單位(imao_t)時，新增一筆基礎單位到imao_t
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM imao_t
                   WHERE imaoent = g_enterprise
                     AND imao001 = g_imaa_m.imaa001
                     AND imao002 = g_imaa_m.imaa006
                  #2015/03/05 by stellar modify ----- (E)
                 #IF l_n1 = 0 THEN                            #160402-00001#1 mark
                  IF l_n1 = 0 AND (l_cmd_t <> 'r') THEN       #160402-00001#1 add
                     INSERT INTO imao_t(imaoent,imao001,imao002)
                              VALUES(g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa006)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins imao_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET l_flag = 'N'
                        RETURN
                     END IF
                     CALL aslm200_b_fill()   #重新顯示單身：允許使用單位刷新
                  END IF    
                  #add by lixh
#                  IF NOT s_log_imaa010_ins(g_site,g_imaa_m.imaa001,'',g_imaa_m.imaa010,'aslm200','') THEN
#                     LET l_flag = 'N'
#                  END IF                  
#                  IF l_flag = 'N' THEN
#                     CALL s_transaction_end('N','0')
#                     EXIT DIALOG
#                  END IF
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imaa_m.imaa001 = g_master_multi_table_t.imaal001 AND
         g_imaa_m.imaal003 = g_master_multi_table_t.imaal003 AND 
         g_imaa_m.imaal004 = g_master_multi_table_t.imaal004 AND 
         g_imaa_m.imaal005 = g_master_multi_table_t.imaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaa_m.imaa001
            LET l_field_keys[02] = 'imaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imaa_m.imaal003
            LET l_fields[01] = 'imaal003'
            LET l_vars[02] = g_imaa_m.imaal004
            LET l_fields[02] = 'imaal004'
            LET l_vars[03] = g_imaa_m.imaal005
            LET l_fields[03] = 'imaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imaal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               LET g_imaa001_d = g_imaa_m.imaa001
#               #add--2015/03/16--By shiun--(S)
#               LET l_num = 0
#               CASE g_dlang
#                  WHEN 'zh_TW'
#                     LET l_dlang = 'zh_CN'
#                  WHEN 'zh_CN'
#                     LET l_dlang = 'zh_TW'
#               END CASE
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal003) RETURNING l_imaal003_trn
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal004) RETURNING l_imaal004_trn
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal005) RETURNING l_imaal005_trn
#               SELECT COUNT(*) INTO l_num
#                 FROM imaal_t
#                WHERE imaalent = g_enterprise
#                  AND imaal001 = g_imaa_m.imaa001
#                  AND imaal002 = l_dlang
#               IF l_num = 0 THEN
#                  INSERT INTO imaal_t (imaalent,imaal001,imaal002,imaal003,imaal004,imaal005)
#                  VALUES(g_enterprise,g_imaa_m.imaa001,l_dlang,l_imaal003_trn,l_imaal004_trn,l_imaal005_trn)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "imaal_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     NEXT FIELD CURRENT
#                  END IF
#               ELSE
#                  UPDATE imaal_t SET imaal003 = l_imaal003_trn,
#                                     imaal004 = l_imaal004_trn,
#                                     imaal005 = l_imaal005_trn
#                   WHERE imaalent = g_enterprise 
#                     AND imaal001 = g_imaa_m.imaa001
#                     AND imaal002 = l_dlang
#               END IF
#               #add--2015/03/16--By shiun--(E)
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aslm200_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aslm200_b_fill()
                  CALL aslm200_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #20150417--add--geza---
               IF cl_null(g_imaa_m.imaa014) AND g_imaa_m.imaa100 = '2' THEN
                  IF g_imaa_m.imaa109 = '1'  THEN
                     CALL s_auto_barcode('1') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imaa_m.imaa014,l_success
                  END IF
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #20150417--add--geza---
               
               UPDATE imac_t SET imac002 = g_imaa_m.imac002,
                                 imac003 = g_imaa_m.imac003
                WHERE imacent = g_enterprise AND imac001 = g_imaa001_t                                 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "imac_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               END IF                                 
               #end add-point
               
               #將遮罩欄位還原
               CALL aslm200_imaa_t_mask_restore('restore_mask_o')
               
               UPDATE imaa_t SET (imaa001,imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010,imaastus, 
                   imaa126,imaa127,imaa131,imaa128,imaa129,imaa130,imaa132,imaa133,imaa134,imaa135,imaa136, 
                   imaa137,imaa138,imaa139,imaa140,imaa141,imaaownid,imaaowndp,imaacrtid,imaacrtdp,imaacrtdt, 
                   imaamodid,imaamoddt,imaacnfid,imaacnfdt,imaa011,imaa012,imaa013,imaa014,imaa100,imaa109, 
                   imaa154,imaa155,imaa156,imaa116,imaa158,imaa143,imaa142,imaa108,imaa110,imaa111,imaa112, 
                   imaa121,imaa124,imaa016,imaa017,imaa018,imaa159,imaa160,imaa019,imaa020,imaa021,imaa022, 
                   imaa023,imaa024,imaa025,imaa026,imaa027,imaa028,imaa029,imaa030,imaa031,imaa032,imaa033, 
                   imaa034,imaa035,imaa036,imaa037,imaa043,imaa038,imaa039,imaa040,imaa041,imaa042,imaa044, 
                   imaa122,imaa045,imaa123) = (g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003, 
                   g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
                   g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
                   g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135, 
                   g_imaa_m.imaa136,g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140, 
                   g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp, 
                   g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt,g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt, 
                   g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100, 
                   g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
                   g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110, 
                   g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016, 
                   g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019, 
                   g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024, 
                   g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029, 
                   g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
                   g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038, 
                   g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044, 
                   g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123)
                WHERE imaaent = g_enterprise AND imaa001 = g_imaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               CALL aslm200_refresh_main_imay()
               IF NOT cl_null(g_errno) THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF  
               
               #UPDATE 單身的庫存單位與計價單位               
               UPDATE imay_t SET imay012 = g_imaa_m.imaa006,
                                 imay014 = g_imaa_m.imaa006
                WHERE imayent = g_enterprise
                  AND imay001 = g_imaa_m.imaa001
                  
               #整批更新單身的 包裝單位與計價單位的 單位換算率
               IF NOT s_artm300_unit_trans_upd(g_imaa_m.imaa001,g_imaa_m.imaa006) THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               ------2015-2-3 zj mod------               
               LET l_flag = ""
                 IF g_con = 'Y' THEN
                    IF p_cmd = 'u' AND g_imaa_m.imaa003 != g_imaa_m_t.imaa003 THEN
                     ------2015-2-3 zj mod------ #若分群码有修改才进行单身重填-->现改为：分群码未修改也进行单身重填，∵ 产品特征为空              
                       CALL aslm200_ins_detail() RETURNING l_success         
                       IF l_success = "FALSE" THEN
                          LET l_flag = 'N'
                       END IF
                     ------2015-2-3 zj mod------               
                       IF g_imaa_m_t.imaastus = 'Y' THEN 
                          CALL s_aimm200_upd_item_site(g_imaa_m.imaa001,'2') RETURNING l_success,g_errno
                       ELSE
                          CALL s_aimm200_upd_item_site(g_imaa_m.imaa001,'1') RETURNING l_success,g_errno
                       END IF                          
                       IF NOT l_success THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = g_errno
                          LET g_errparam.extend = g_imaa_m.imaa001
                          LET g_errparam.popup = TRUE
                          CALL cl_err()

                          LET l_flag = 'N'
                       END IF                       
                    END IF   
                 END IF
                 IF NOT cl_null(g_imaa_m.ooff013) THEN
                    CALL s_aooi360_gen('3',g_imaa_m.imaa001,'','','','','','','','','','4',g_imaa_m.ooff013) RETURNING l_success
                    IF l_success = "FALSE" THEN
                       LET l_flag = 'N'
                    END IF
                 ELSE
                    CALL s_aooi360_del('3',g_imaa_m.imaa001,'','','','','','','','','','4') RETURNING l_success
                    IF l_success = "FALSE" THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = "ooff_t"
                       LET g_errparam.popup = TRUE
                       CALL cl_err()

                       LET l_flag = 'N'
                    END IF                                      
                 END IF 
                 
                 #2015/03/05 by stellar add ----- (S)
                 #增加功能：若基礎單位(imaa006)不存在於料件允許使用單位(imao_t)時，新增一筆基礎單位到imao_t
                 LET l_n1 = 0
                 SELECT COUNT(*) INTO l_n1
                   FROM imao_t
                  WHERE imaoent = g_enterprise
                    AND imao001 = g_imaa_m.imaa001
                    AND imao002 = g_imaa_m.imaa006
                #IF l_n1 = 0 THEN                           #160402-00001#1 mark
                 IF l_n1 = 0 AND (l_cmd_t <> 'r') THEN      #160402-00001#1 add
                    INSERT INTO imao_t(imaoent,imao001,imao002)
                             VALUES(g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa006)
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = "ins imao_t"
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       
                       LET l_flag = 'N'
                    ELSE
                       CALL aslm200_b_fill()   #重新顯示單身：允許使用單位刷新
                    END IF
                 END IF   
                 #2015/03/05 by stellar modify ----- (E) 
                 
                 #150312---earl---add---s
                 IF g_imaa_m.imaa006 <> g_imaa_m_t.imaa006 OR cl_null(g_imaa_m_t.imaa006) THEN
                    IF NOT aslm200_call_ainp100(g_imaa_m.imaa001) THEN
                       LET l_flag = 'N'
                    END IF
                 END IF
                 #150312---earl---add---e
                 
                 #add by lixh   
                 IF (g_imaa_m_t.imaa010 <> g_imaa_m.imaa010) OR (cl_null(g_imaa_m_t.imaa010) AND NOT cl_null(g_imaa_m.imaa010)) 
                    OR (cl_null(g_imaa_m.imaa010) AND NOT cl_null(g_imaa_m_t.imaa010)) THEN                
                    IF NOT s_log_imaa010_ins(g_site,g_imaa_m.imaa001,g_imaa_m_t.imaa010,g_imaa_m.imaa010,'aslm200','') THEN
                       LET l_flag = 'N'
                    END IF 
                  END IF                  
                  IF l_flag = 'N' THEN
                     CALL s_transaction_end('N','0')
                  END IF
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imaa_m.imaa001 = g_master_multi_table_t.imaal001 AND
         g_imaa_m.imaal003 = g_master_multi_table_t.imaal003 AND 
         g_imaa_m.imaal004 = g_master_multi_table_t.imaal004 AND 
         g_imaa_m.imaal005 = g_master_multi_table_t.imaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaa_m.imaa001
            LET l_field_keys[02] = 'imaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imaa_m.imaal003
            LET l_fields[01] = 'imaal003'
            LET l_vars[02] = g_imaa_m.imaal004
            LET l_fields[02] = 'imaal004'
            LET l_vars[03] = g_imaa_m.imaal005
            LET l_fields[03] = 'imaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imaal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aslm200_imaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
#               #add--2015/03/16--By shiun--(S)
#               CALL s_transaction_begin()
#               LET l_num = 0
#               CASE g_dlang
#                  WHEN 'zh_TW'
#                     LET l_dlang = 'zh_CN'
#                  WHEN 'zh_CN'
#                     LET l_dlang = 'zh_TW'
#               END CASE
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal003) RETURNING l_imaal003_trn
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal004) RETURNING l_imaal004_trn
#               CALL cl_trans_code_tw_cn(l_dlang,g_imaa_m.imaal005) RETURNING l_imaal005_trn
#               SELECT COUNT(*) INTO l_num
#                 FROM imaal_t
#                WHERE imaalent = g_enterprise
#                  AND imaal001 = g_imaa_m.imaa001
#                  AND imaal002 = l_dlang
#               IF l_num = 0 THEN
#                  INSERT INTO imaal_t (imaalent,imaal001,imaal002,imaal003,imaal004,imaal005)
#                  VALUES(g_enterprise,g_imaa_m.imaa001,l_dlang,l_imaal003_trn,l_imaal004_trn,l_imaal005_trn)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "imaal_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     NEXT FIELD CURRENT
#                  END IF
#               ELSE
#                  UPDATE imaal_t SET imaal003 = l_imaal003_trn,
#                                     imaal004 = l_imaal004_trn,
#                                     imaal005 = l_imaal005_trn
#                   WHERE imaalent = g_enterprise 
#                     AND imaal001 = g_imaa_m.imaa001
#                     AND imaal002 = l_dlang
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "imaal_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               CALL s_transaction_end('Y','0')
#               #add--2015/03/16--By shiun--(E)
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imaa001_t = g_imaa_m.imaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aslm200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imaj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aslm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imaj_d.getLength()
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
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imaj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imaj_d[l_ac].imaj002 IS NOT NULL
               AND g_imaj_d[l_ac].imaj003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imaj_d_t.* = g_imaj_d[l_ac].*  #BACKUP
               LET g_imaj_d_o.* = g_imaj_d[l_ac].*  #BACKUP
               CALL aslm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aslm200_set_no_entry_b(l_cmd)
               IF NOT aslm200_lock_b("imaj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aslm200_bcl INTO g_imaj_d[l_ac].imaj002,g_imaj_d[l_ac].imaj003,g_imaj_d[l_ac].imaj004, 
                      g_imaj_d[l_ac].imaj005,g_imaj_d[l_ac].imaj006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imaj_d_t.imaj002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaj_d_mask_o[l_ac].* =  g_imaj_d[l_ac].*
                  CALL aslm200_imaj_t_mask()
                  LET g_imaj_d_mask_n[l_ac].* =  g_imaj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aslm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
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
            INITIALIZE g_imaj_d[l_ac].* TO NULL 
            INITIALIZE g_imaj_d_t.* TO NULL 
            INITIALIZE g_imaj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_imaj_d_t.* = g_imaj_d[l_ac].*     #新輸入資料
            LET g_imaj_d_o.* = g_imaj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aslm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aslm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaj_d[li_reproduce_target].* = g_imaj_d[li_reproduce].*
 
               LET g_imaj_d[li_reproduce_target].imaj002 = NULL
               LET g_imaj_d[li_reproduce_target].imaj003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM imaj_t 
             WHERE imajent = g_enterprise AND imaj001 = g_imaa_m.imaa001
 
               AND imaj002 = g_imaj_d[l_ac].imaj002
               AND imaj003 = g_imaj_d[l_ac].imaj003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imaj_d[g_detail_idx].imaj002
               LET gs_keys[3] = g_imaj_d[g_detail_idx].imaj003
               CALL aslm200_insert_b('imaj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imaj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
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
               LET gs_keys[01] = g_imaa_m.imaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_imaj_d_t.imaj002
               LET gs_keys[gs_keys.getLength()+1] = g_imaj_d_t.imaj003
 
            
               #刪除同層單身
               IF NOT aslm200_delete_b('imaj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aslm200_key_delete_b(gs_keys,'imaj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aslm200_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_imaj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imaj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj002
            
            #add-point:AFTER FIELD imaj002 name="input.a.page1.imaj002"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) AND NOT cl_null(g_imaj_d[l_ac].imaj002) AND NOT cl_null(g_imaj_d[l_ac].imaj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj_d[l_ac].imaj002 != g_imaj_d_t.imaj002 OR g_imaj_d[l_ac].imaj003 != g_imaj_d_t.imaj003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaj_t WHERE "||"imajent = '" ||g_enterprise|| "' AND "||"imaj001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imaj002 = '"||g_imaj_d[l_ac].imaj002 ||"' AND "|| "imaj003 = '"||g_imaj_d[l_ac].imaj003 ||"'",'std-00004',0) THEN 
                     LET g_imaj_d[l_ac].imaj002 = g_imaj_d_t.imaj002
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_imaj_d[l_ac].imaj002
                     CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='270' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_imaj_d[l_ac].imaj002_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_imaj_d[l_ac].imaj002_desc                      
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imaj_d[l_ac].imaj002) THEN
               LET p_req_data[1] = 270
               LET p_req_data[2] = g_imaj_d[l_ac].imaj002
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaj_d[l_ac].imaj002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj_d[l_ac].imaj002 = g_imaj_d_t.imaj002
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaj_d[l_ac].imaj002
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='270' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaj_d[l_ac].imaj002_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_imaj_d[l_ac].imaj002_desc                  
                  NEXT FIELD imaj002
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='270' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj002_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj002
            #add-point:BEFORE FIELD imaj002 name="input.b.page1.imaj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaj002
            #add-point:ON CHANGE imaj002 name="input.g.page1.imaj002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj003
            
            #add-point:AFTER FIELD imaj003 name="input.a.page1.imaj003"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) AND NOT cl_null(g_imaj_d[l_ac].imaj002) AND NOT cl_null(g_imaj_d[l_ac].imaj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj_d[l_ac].imaj002 != g_imaj_d_t.imaj002 OR g_imaj_d[l_ac].imaj003 != g_imaj_d_t.imaj003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaj_t WHERE "||"imajent = '" ||g_enterprise|| "' AND "||"imaj001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imaj002 = '"||g_imaj_d[l_ac].imaj002 ||"' AND "|| "imaj003 = '"||g_imaj_d[l_ac].imaj003 ||"'",'std-00004',0) THEN 
                     LET g_imaj_d[l_ac].imaj003 = g_imaj_d_t.imaj003
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_imaj_d[l_ac].imaj003
                     CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='271' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_imaj_d[l_ac].imaj003_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_imaj_d[l_ac].imaj003_desc                      
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imaj_d[l_ac].imaj003) THEN
               LET p_req_data[1] = 271
               LET p_req_data[2] = g_imaj_d[l_ac].imaj003
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaj_d[l_ac].imaj003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj_d[l_ac].imaj003 = g_imaj_d_t.imaj003
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imaj_d[l_ac].imaj003
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='271' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imaj_d[l_ac].imaj003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_imaj_d[l_ac].imaj003_desc                   
                  NEXT FIELD imaj003
               END IF
               #150317-00006#1--add---begin----
               #判斷輸入的資料類型是否一致
               SELECT oocq004 INTO l_oocq004 FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '271' AND oocq002 = g_imaj_d[l_ac].imaj003
               IF l_oocq004 <> g_imaj_d[l_ac].imaj002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00249'
                  LET g_errparam.extend = g_imaj_d[l_ac].imaj003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imaj_d[l_ac].imaj003 = g_imaj_d_t.imaj003
                  CALL s_desc_get_acc_desc('271',g_imaj_d[l_ac].imaj003) RETURNING g_imaj_d[l_ac].imaj003_desc
                  DISPLAY BY NAME g_imaj_d[l_ac].imaj003_desc                   
                  NEXT FIELD imaj003
               END IF
               #150317-00006#1--add---end----
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='271' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj003_desc             

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj003
            #add-point:BEFORE FIELD imaj003 name="input.b.page1.imaj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaj003
            #add-point:ON CHANGE imaj003 name="input.g.page1.imaj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj_d[l_ac].imaj004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaj004
            END IF 
 
 
 
            #add-point:AFTER FIELD imaj004 name="input.a.page1.imaj004"
                        IF NOT cl_null(g_imaj_d[l_ac].imaj004) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj004
            #add-point:BEFORE FIELD imaj004 name="input.b.page1.imaj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaj004
            #add-point:ON CHANGE imaj004 name="input.g.page1.imaj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj005
            
            #add-point:AFTER FIELD imaj005 name="input.a.page1.imaj005"
                        IF NOT cl_null(g_imaj_d[l_ac].imaj005) THEN
               LET p_req_data[1] = g_imaj_d[l_ac].imaj005
               CALL s_aimm200_fields_chk('imaa018',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaj_d[l_ac].imaj005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj_d[l_ac].imaj005 = g_imaj_d_t.imaj005
                  LET g_imaj_d[l_ac].imaj005_desc = g_imaj_d_t.imaj005_desc
                  DISPLAY BY NAME g_imaj_d[l_ac].imaj006_desc
                  NEXT FIELD imaj005
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj005
            #add-point:BEFORE FIELD imaj005 name="input.b.page1.imaj005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaj005
            #add-point:ON CHANGE imaj005 name="input.g.page1.imaj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaj006
            
            #add-point:AFTER FIELD imaj006 name="input.a.page1.imaj006"
                        IF NOT cl_null(g_imaj_d[l_ac].imaj006) THEN
               LET p_req_data[1] = 272
               LET p_req_data[2] = g_imaj_d[l_ac].imaj006
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaj_d[l_ac].imaj006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj_d[l_ac].imaj006 = g_imaj_d_t.imaj006
                  LET g_imaj_d[l_ac].imaj006_desc = g_imaj_d_t.imaj006_desc
                  DISPLAY BY NAME g_imaj_d[l_ac].imaj006_desc
                  NEXT FIELD imaj006
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='272' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaj006
            #add-point:BEFORE FIELD imaj006 name="input.b.page1.imaj006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaj006
            #add-point:ON CHANGE imaj006 name="input.g.page1.imaj006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj002
            #add-point:ON ACTION controlp INFIELD imaj002 name="input.c.page1.imaj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaj_d[l_ac].imaj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "270" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaj_d[l_ac].imaj002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj_d[l_ac].imaj002 TO imaj002              #顯示到畫面上

            NEXT FIELD imaj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj003
            #add-point:ON ACTION controlp INFIELD imaj003 name="input.c.page1.imaj003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imaj_d[l_ac].imaj003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "271" #應用分類
            IF NOT cl_null(g_imaj_d[l_ac].imaj002) THEN
               LET g_qryparam.where = " oocq004 = '",g_imaj_d[l_ac].imaj002 CLIPPED,"'"
            END IF
            CALL q_oocq002()                                #呼叫開窗

            LET g_imaj_d[l_ac].imaj003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj_d[l_ac].imaj003 TO imaj003              #顯示到畫面上

            NEXT FIELD imaj003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj004
            #add-point:ON ACTION controlp INFIELD imaj004 name="input.c.page1.imaj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj005
            #add-point:ON ACTION controlp INFIELD imaj005 name="input.c.page1.imaj005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaj_d[l_ac].imaj005             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaj_d[l_ac].imaj005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj_d[l_ac].imaj005 TO imaj005              #顯示到畫面上

            NEXT FIELD imaj005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaj006
            #add-point:ON ACTION controlp INFIELD imaj006 name="input.c.page1.imaj006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaj_d[l_ac].imaj006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "272" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaj_d[l_ac].imaj006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj_d[l_ac].imaj006 TO imaj006              #顯示到畫面上

            NEXT FIELD imaj006                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imaj_d[l_ac].* = g_imaj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imaj_d[l_ac].imaj002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imaj_d[l_ac].* = g_imaj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aslm200_imaj_t_mask_restore('restore_mask_o')
      
               UPDATE imaj_t SET (imaj001,imaj002,imaj003,imaj004,imaj005,imaj006) = (g_imaa_m.imaa001, 
                   g_imaj_d[l_ac].imaj002,g_imaj_d[l_ac].imaj003,g_imaj_d[l_ac].imaj004,g_imaj_d[l_ac].imaj005, 
                   g_imaj_d[l_ac].imaj006)
                WHERE imajent = g_enterprise AND imaj001 = g_imaa_m.imaa001 
 
                  AND imaj002 = g_imaj_d_t.imaj002 #項次   
                  AND imaj003 = g_imaj_d_t.imaj003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imaj_d[l_ac].* = g_imaj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imaj_d[l_ac].* = g_imaj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imaj_d[g_detail_idx].imaj002
               LET gs_keys_bak[2] = g_imaj_d_t.imaj002
               LET gs_keys[3] = g_imaj_d[g_detail_idx].imaj003
               LET gs_keys_bak[3] = g_imaj_d_t.imaj003
               CALL aslm200_update_b('imaj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aslm200_imaj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imaj_d[g_detail_idx].imaj002 = g_imaj_d_t.imaj002 
                  AND g_imaj_d[g_detail_idx].imaj003 = g_imaj_d_t.imaj003 
 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj_d_t.imaj002
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj_d_t.imaj003
 
                  CALL aslm200_key_update_b(gs_keys,'imaj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aslm200_unlock_b("imaj_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imaj_d[li_reproduce_target].* = g_imaj_d[li_reproduce].*
 
               LET g_imaj_d[li_reproduce_target].imaj002 = NULL
               LET g_imaj_d[li_reproduce_target].imaj003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_imaj2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaj2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aslm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imaj2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imaj2_d[l_ac].* TO NULL 
            INITIALIZE g_imaj2_d_t.* TO NULL 
            INITIALIZE g_imaj2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_imaj2_d_t.* = g_imaj2_d[l_ac].*     #新輸入資料
            LET g_imaj2_d_o.* = g_imaj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aslm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aslm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaj2_d[li_reproduce_target].* = g_imaj2_d[li_reproduce].*
 
               LET g_imaj2_d[li_reproduce_target].imal002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
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
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imaj2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imaj2_d[l_ac].imal002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imaj2_d_t.* = g_imaj2_d[l_ac].*  #BACKUP
               LET g_imaj2_d_o.* = g_imaj2_d[l_ac].*  #BACKUP
               CALL aslm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aslm200_set_no_entry_b(l_cmd)
               IF NOT aslm200_lock_b("imal_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aslm200_bcl2 INTO g_imaj2_d[l_ac].imal002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaj2_d_mask_o[l_ac].* =  g_imaj2_d[l_ac].*
                  CALL aslm200_imal_t_mask()
                  LET g_imaj2_d_mask_n[l_ac].* =  g_imaj2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aslm200_show()
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
               LET gs_keys[01] = g_imaa_m.imaa001
               LET gs_keys[gs_keys.getLength()+1] = g_imaj2_d_t.imal002
            
               #刪除同層單身
               IF NOT aslm200_delete_b('imal_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aslm200_key_delete_b(gs_keys,'imal_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aslm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                  
               #end add-point
               LET l_count = g_imaj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imaj2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imal_t 
             WHERE imalent = g_enterprise AND imal001 = g_imaa_m.imaa001
               AND imal002 = g_imaj2_d[l_ac].imal002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imaj2_d[g_detail_idx].imal002
               CALL aslm200_insert_b('imal_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imaj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslm200_b_fill()
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
               LET g_imaj2_d[l_ac].* = g_imaj2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl2
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
               LET g_imaj2_d[l_ac].* = g_imaj2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aslm200_imal_t_mask_restore('restore_mask_o')
                              
               UPDATE imal_t SET (imal001,imal002) = (g_imaa_m.imaa001,g_imaj2_d[l_ac].imal002) #自訂欄位頁簽 
 
                WHERE imalent = g_enterprise AND imal001 = g_imaa_m.imaa001
                  AND imal002 = g_imaj2_d_t.imal002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imaj2_d[l_ac].* = g_imaj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imal_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imaj2_d[l_ac].* = g_imaj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imaj2_d[g_detail_idx].imal002
               LET gs_keys_bak[2] = g_imaj2_d_t.imal002
               CALL aslm200_update_b('imal_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aslm200_imal_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imaj2_d[g_detail_idx].imal002 = g_imaj2_d_t.imal002 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj2_d_t.imal002
                  CALL aslm200_key_update_b(gs_keys,'imal_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj2_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imal002
            
            #add-point:AFTER FIELD imal002 name="input.a.page2.imal002"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) AND NOT cl_null(g_imaj2_d[l_ac].imal002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj2_d[l_ac].imal002 != g_imaj2_d_t.imal002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imal_t WHERE "||"imalent = '" ||g_enterprise|| "' AND "||"imal001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imal002 = '"||g_imaj2_d[l_ac].imal002 ||"'",'std-00004',0) THEN 
                     LET g_imaj2_d[l_ac].imal002 = g_imaj2_d_t.imal002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_imaj2_d[l_ac].imal002) THEN
               LET p_req_data[1] = 213
               LET p_req_data[2] = g_imaj2_d[l_ac].imal002
               CALL s_aimm200_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imaj2_d[l_ac].imal002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj2_d[l_ac].imal002 = g_imaj2_d_t.imal002
                  LET g_imaj2_d[l_ac].imal002_desc = g_imaj2_d_t.imal002_desc
                  LET g_imaj2_d[l_ac].l_oocq005 = g_imaj2_d_t.l_oocq005
                  NEXT FIELD imal002
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='213' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj2_d[l_ac].imal002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj2_d[l_ac].imal002_desc
            
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
            CALL ap_ref_array2(g_ref_fields," SELECT oocq005 FROM oocq_t WHERE oocqent = '"||g_enterprise||"' AND oocq001 = '213' AND oocq002 = ? ","") RETURNING g_rtn_fields 
            LET g_imaj2_d[l_ac].l_oocq005 = g_rtn_fields[1]
            DISPLAY BY NAME g_imaj2_d[l_ac].l_oocq005           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imal002
            #add-point:BEFORE FIELD imal002 name="input.b.page2.imal002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imal002
            #add-point:ON CHANGE imal002 name="input.g.page2.imal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_oocq005
            #add-point:BEFORE FIELD l_oocq005 name="input.b.page2.l_oocq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_oocq005
            
            #add-point:AFTER FIELD l_oocq005 name="input.a.page2.l_oocq005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_oocq005
            #add-point:ON CHANGE l_oocq005 name="input.g.page2.l_oocq005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.imal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imal002
            #add-point:ON ACTION controlp INFIELD imal002 name="input.c.page2.imal002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaj2_d[l_ac].imal002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "213" #應用分類

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_imaj2_d[l_ac].imal002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj2_d[l_ac].imal002 TO imal002              #顯示到畫面上

            NEXT FIELD imal002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.l_oocq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_oocq005
            #add-point:ON ACTION controlp INFIELD l_oocq005 name="input.c.page2.l_oocq005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imaj2_d[l_ac].* = g_imaj2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aslm200_unlock_b("imal_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imaj2_d[li_reproduce_target].* = g_imaj2_d[li_reproduce].*
 
               LET g_imaj2_d[li_reproduce_target].imal002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaj2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaj2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imaj3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaj3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aslm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imaj3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imaj3_d[l_ac].* TO NULL 
            INITIALIZE g_imaj3_d_t.* TO NULL 
            INITIALIZE g_imaj3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_imaj3_d_t.* = g_imaj3_d[l_ac].*     #新輸入資料
            LET g_imaj3_d_o.* = g_imaj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aslm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aslm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaj3_d[li_reproduce_target].* = g_imaj3_d[li_reproduce].*
 
               LET g_imaj3_d[li_reproduce_target].imam002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imaj3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imaj3_d[l_ac].imam002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imaj3_d_t.* = g_imaj3_d[l_ac].*  #BACKUP
               LET g_imaj3_d_o.* = g_imaj3_d[l_ac].*  #BACKUP
               CALL aslm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aslm200_set_no_entry_b(l_cmd)
               IF NOT aslm200_lock_b("imam_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aslm200_bcl3 INTO g_imaj3_d[l_ac].imam002,g_imaj3_d[l_ac].imam005,g_imaj3_d[l_ac].imam003, 
                      g_imaj3_d[l_ac].imam006,g_imaj3_d[l_ac].imam004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaj3_d_mask_o[l_ac].* =  g_imaj3_d[l_ac].*
                  CALL aslm200_imam_t_mask()
                  LET g_imaj3_d_mask_n[l_ac].* =  g_imaj3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aslm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imaa_m.imaa001
               LET gs_keys[gs_keys.getLength()+1] = g_imaj3_d_t.imam002
            
               #刪除同層單身
               IF NOT aslm200_delete_b('imam_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aslm200_key_delete_b(gs_keys,'imam_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aslm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                  
               #end add-point
               LET l_count = g_imaj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imaj3_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imam_t 
             WHERE imament = g_enterprise AND imam001 = g_imaa_m.imaa001
               AND imam002 = g_imaj3_d[l_ac].imam002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imaj3_d[g_detail_idx].imam002
               CALL aslm200_insert_b('imam_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imaj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imaj3_d[l_ac].* = g_imaj3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl3
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
               LET g_imaj3_d[l_ac].* = g_imaj3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aslm200_imam_t_mask_restore('restore_mask_o')
                              
               UPDATE imam_t SET (imam001,imam002,imam005,imam003,imam006,imam004) = (g_imaa_m.imaa001, 
                   g_imaj3_d[l_ac].imam002,g_imaj3_d[l_ac].imam005,g_imaj3_d[l_ac].imam003,g_imaj3_d[l_ac].imam006, 
                   g_imaj3_d[l_ac].imam004) #自訂欄位頁簽
                WHERE imament = g_enterprise AND imam001 = g_imaa_m.imaa001
                  AND imam002 = g_imaj3_d_t.imam002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imaj3_d[l_ac].* = g_imaj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imam_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imaj3_d[l_ac].* = g_imaj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imaj3_d[g_detail_idx].imam002
               LET gs_keys_bak[2] = g_imaj3_d_t.imam002
               CALL aslm200_update_b('imam_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aslm200_imam_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imaj3_d[g_detail_idx].imam002 = g_imaj3_d_t.imam002 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj3_d_t.imam002
                  CALL aslm200_key_update_b(gs_keys,'imam_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj3_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam002
            #add-point:BEFORE FIELD imam002 name="input.b.page3.imam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam002
            
            #add-point:AFTER FIELD imam002 name="input.a.page3.imam002"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_imaa_m.imaa001) AND NOT cl_null(g_imaj3_d[l_ac].imam002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj3_d[l_ac].imam002 != g_imaj3_d_t.imam002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imam_t WHERE "||"imament = '" ||g_enterprise|| "' AND "||"imam001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imam002 = '"||g_imaj3_d[l_ac].imam002 ||"'",'std-00004',0) THEN 
                     LET g_imaj3_d[l_ac].imam002 = g_imaj3_d_t.imam002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imam002
            #add-point:ON CHANGE imam002 name="input.g.page3.imam002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam005
            #add-point:BEFORE FIELD imam005 name="input.b.page3.imam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam005
            
            #add-point:AFTER FIELD imam005 name="input.a.page3.imam005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imam005
            #add-point:ON CHANGE imam005 name="input.g.page3.imam005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam003
            #add-point:BEFORE FIELD imam003 name="input.b.page3.imam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam003
            
            #add-point:AFTER FIELD imam003 name="input.a.page3.imam003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imam003
            #add-point:ON CHANGE imam003 name="input.g.page3.imam003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam006
            #add-point:BEFORE FIELD imam006 name="input.b.page3.imam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam006
            
            #add-point:AFTER FIELD imam006 name="input.a.page3.imam006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imam006
            #add-point:ON CHANGE imam006 name="input.g.page3.imam006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imam004
            #add-point:BEFORE FIELD imam004 name="input.b.page3.imam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imam004
            
            #add-point:AFTER FIELD imam004 name="input.a.page3.imam004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imam004
            #add-point:ON CHANGE imam004 name="input.g.page3.imam004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.imam002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam002
            #add-point:ON ACTION controlp INFIELD imam002 name="input.c.page3.imam002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.imam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam005
            #add-point:ON ACTION controlp INFIELD imam005 name="input.c.page3.imam005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.imam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam003
            #add-point:ON ACTION controlp INFIELD imam003 name="input.c.page3.imam003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.imam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam006
            #add-point:ON ACTION controlp INFIELD imam006 name="input.c.page3.imam006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.imam004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imam004
            #add-point:ON ACTION controlp INFIELD imam004 name="input.c.page3.imam004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imaj3_d[l_ac].* = g_imaj3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aslm200_unlock_b("imam_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imaj3_d[li_reproduce_target].* = g_imaj3_d[li_reproduce].*
 
               LET g_imaj3_d[li_reproduce_target].imam002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaj3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaj3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imaj4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaj4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aslm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imaj4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imaj4_d[l_ac].* TO NULL 
            INITIALIZE g_imaj4_d_t.* TO NULL 
            INITIALIZE g_imaj4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_imaj4_d_t.* = g_imaj4_d[l_ac].*     #新輸入資料
            LET g_imaj4_d_o.* = g_imaj4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aslm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aslm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaj4_d[li_reproduce_target].* = g_imaj4_d[li_reproduce].*
 
               LET g_imaj4_d[li_reproduce_target].imao002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imaj4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imaj4_d[l_ac].imao002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imaj4_d_t.* = g_imaj4_d[l_ac].*  #BACKUP
               LET g_imaj4_d_o.* = g_imaj4_d[l_ac].*  #BACKUP
               CALL aslm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aslm200_set_no_entry_b(l_cmd)
               IF NOT aslm200_lock_b("imao_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aslm200_bcl4 INTO g_imaj4_d[l_ac].imao002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaj4_d_mask_o[l_ac].* =  g_imaj4_d[l_ac].*
                  CALL aslm200_imao_t_mask()
                  LET g_imaj4_d_mask_n[l_ac].* =  g_imaj4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aslm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imaa_m.imaa001
               LET gs_keys[gs_keys.getLength()+1] = g_imaj4_d_t.imao002
            
               #刪除同層單身
               IF NOT aslm200_delete_b('imao_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aslm200_key_delete_b(gs_keys,'imao_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aslm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
                  
               #end add-point
               LET l_count = g_imaj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imaj4_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imao_t 
             WHERE imaoent = g_enterprise AND imao001 = g_imaa_m.imaa001
               AND imao002 = g_imaj4_d[l_ac].imao002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imaj4_d[g_detail_idx].imao002
               CALL aslm200_insert_b('imao_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imaj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imaj4_d[l_ac].* = g_imaj4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl4
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
               LET g_imaj4_d[l_ac].* = g_imaj4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aslm200_imao_t_mask_restore('restore_mask_o')
                              
               UPDATE imao_t SET (imao001,imao002) = (g_imaa_m.imaa001,g_imaj4_d[l_ac].imao002) #自訂欄位頁簽 
 
                WHERE imaoent = g_enterprise AND imao001 = g_imaa_m.imaa001
                  AND imao002 = g_imaj4_d_t.imao002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imaj4_d[l_ac].* = g_imaj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imao_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imaj4_d[l_ac].* = g_imaj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imaj4_d[g_detail_idx].imao002
               LET gs_keys_bak[2] = g_imaj4_d_t.imao002
               CALL aslm200_update_b('imao_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aslm200_imao_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imaj4_d[g_detail_idx].imao002 = g_imaj4_d_t.imao002 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj4_d_t.imao002
                  CALL aslm200_key_update_b(gs_keys,'imao_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj4_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imao002
            
            #add-point:AFTER FIELD imao002 name="input.a.page4.imao002"
                        #此段落由子樣板a05產生
            CALL aslm200_imao002_desc()
            IF g_imaj4_d[l_ac].imao002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_imaj4_d[l_ac].imao002 != g_imaj4_d_t.imao002) THEN 
                  IF NOT ap_chk_notDup(g_imaj4_d[l_ac].imao002,"SELECT COUNT(*) FROM imao_t WHERE "||"imaoent = '" ||g_enterprise|| "' AND "||"imao001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imao002 = '"||g_imaj4_d[l_ac].imao002 ||"'",'std-00004',0) THEN 
                     LET g_imaj4_d[l_ac].imao002 = g_imaj4_d_t.imao002
                     CALL aslm200_imao002_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaj4_d[l_ac].imao002
               #160318-00025#40  2016/04/22  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#40  2016/04/22  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_imaj4_d[l_ac].imao002 = g_imaj4_d_t.imao002
                  CALL aslm200_imao002_desc()
                  NEXT FIELD CURRENT
               END IF               
               
               #150312---earl---add---s
               CALL cl_err_collect_init()
               CALL s_aimm200_unit_chk(g_imaa_m.imaa001,g_imaa_m.imaa006,g_imaj4_d[l_ac].imao002) RETURNING l_success
               CALL cl_err_collect_show()
               IF NOT l_success THEN
                  LET g_imaj4_d[l_ac].imao002 = g_imaj4_d_t.imao002
                  CALL aslm200_imao002_desc()
                  NEXT FIELD CURRENT
               END IF
               #150312---earl---add---e
               
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imao002
            #add-point:BEFORE FIELD imao002 name="input.b.page4.imao002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imao002
            #add-point:ON CHANGE imao002 name="input.g.page4.imao002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.imao002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imao002
            #add-point:ON ACTION controlp INFIELD imao002 name="input.c.page4.imao002"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaj4_d[l_ac].imao002             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaj4_d[l_ac].imao002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaj4_d[l_ac].imao002 TO imao002              #顯示到畫面上
            CALL aslm200_imao002_desc() 
            NEXT FIELD imao002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imaj4_d[l_ac].* = g_imaj4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aslm200_unlock_b("imao_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imaj4_d[li_reproduce_target].* = g_imaj4_d[li_reproduce].*
 
               LET g_imaj4_d[li_reproduce_target].imao002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaj4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaj4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imaj5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaj5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aslm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imaj5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imaj5_d[l_ac].* TO NULL 
            INITIALIZE g_imaj5_d_t.* TO NULL 
            INITIALIZE g_imaj5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaj5_d[l_ac].imaystus = 'N'
 
 
 
            #自定義預設值(單身5)
                  LET g_imaj5_d[l_ac].imay005 = "0"
      LET g_imaj5_d[l_ac].imay006 = "N"
      LET g_imaj5_d[l_ac].imay018 = "1"
      LET g_imaj5_d[l_ac].imay007 = "0"
      LET g_imaj5_d[l_ac].imay008 = "0"
      LET g_imaj5_d[l_ac].imay009 = "0"
      LET g_imaj5_d[l_ac].imay010 = "0"
 
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            #传秤因子赋值  150417  geza  add
            IF g_imaa_m.imaa108 = '3' THEN 
               LET  g_imaj5_d[l_ac].imay018 = 1000                  
            END IF 
            #条码赋值  150417  geza  add
            LET g_imaj5_d[l_ac].imay005 = 1 #件装  150815  geza  add
            LET  g_imaj5_d[l_ac].imay002 =  g_imaa_m.imaa100 
            #160801-00017#3 20160804 add by beckxie---S
            CALL aslm200_set_no_required_b(l_cmd)
            CALL aslm200_set_required_b(l_cmd)
            #160801-00017#3 20160804 add by beckxie---E
            #end add-point
            LET g_imaj5_d_t.* = g_imaj5_d[l_ac].*     #新輸入資料
            LET g_imaj5_d_o.* = g_imaj5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aslm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL aslm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaj5_d[li_reproduce_target].* = g_imaj5_d[li_reproduce].*
 
               LET g_imaj5_d[li_reproduce_target].imay003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            LET g_imaj5_d[l_ac].imay012 = g_imaa_m.imaa006
            LET g_imaj5_d[l_ac].imay014 = g_imaa_m.imaa006
            LET g_imaj5_d[l_ac].imay007 = g_imaa_m.imaa019
            LET g_imaj5_d[l_ac].imay008 = g_imaa_m.imaa020
            LET g_imaj5_d[l_ac].imay009 = g_imaa_m.imaa021            
            LET g_imaj5_d[l_ac].imay015 = g_imaa_m.imaa022
            LET g_imaj5_d[l_ac].imay010 = g_imaa_m.imaa025
            LET g_imaj5_d[l_ac].imay016 = g_imaa_m.imaa026
            LET g_imaj5_d[l_ac].imay011 = g_imaa_m.imaa016
            LET g_imaj5_d[l_ac].imay017 = g_imaa_m.imaa018    
            #CALL artm300_imay015_ref()    
            #CALL artm300_imay016_ref()   
            #CALL artm300_imay017_ref()               
            LET g_imaj5_d[l_ac].imaystus = 'Y'
            LET g_imaj5_d_t.* = g_imaj5_d[l_ac].*
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aslm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imaj5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imaj5_d[l_ac].imay003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imaj5_d_t.* = g_imaj5_d[l_ac].*  #BACKUP
               LET g_imaj5_d_o.* = g_imaj5_d[l_ac].*  #BACKUP
               CALL aslm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL aslm200_set_no_entry_b(l_cmd)
               IF NOT aslm200_lock_b("imay_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aslm200_bcl5 INTO g_imaj5_d[l_ac].imaystus,g_imaj5_d[l_ac].imay002,g_imaj5_d[l_ac].imay019, 
                      g_imaj5_d[l_ac].imay003,g_imaj5_d[l_ac].imay004,g_imaj5_d[l_ac].imay005,g_imaj5_d[l_ac].imay006, 
                      g_imaj5_d[l_ac].imay018,g_imaj5_d[l_ac].imay007,g_imaj5_d[l_ac].imay008,g_imaj5_d[l_ac].imay009, 
                      g_imaj5_d[l_ac].imay015,g_imaj5_d[l_ac].imay010,g_imaj5_d[l_ac].imay016,g_imaj5_d[l_ac].imay011, 
                      g_imaj5_d[l_ac].imay017,g_imaj5_d[l_ac].imay012,g_imaj5_d[l_ac].imay013,g_imaj5_d[l_ac].imay014 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaj5_d_mask_o[l_ac].* =  g_imaj5_d[l_ac].*
                  CALL aslm200_imay_t_mask()
                  LET g_imaj5_d_mask_n[l_ac].* =  g_imaj5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aslm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_imaa_m.imaa001
               LET gs_keys[gs_keys.getLength()+1] = g_imaj5_d_t.imay003
            
               #刪除同層單身
               IF NOT aslm200_delete_b('imay_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aslm200_key_delete_b(gs_keys,'imay_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aslm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aslm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               #dongsz--add--str---
               IF g_imaj5_d[l_ac].imay006 = 'Y' THEN
#                  LET g_imaa_m.imaa100 = ""   #geza--add--mark---
                  LET g_imaa_m.imaa014 = ""
                  UPDATE imaa_t SET imaa100 = g_imaa_m.imaa100,
                                    imaa014 = g_imaa_m.imaa014
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_imaa_m.imaa001
                  DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014
                  LET g_imaa_m_o.imaa100 = g_imaa_m.imaa100
                  LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014
               END IF
               #dongsz--add--end---
               #end add-point
               LET l_count = g_imaj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imaj5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM imay_t 
             WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
               AND imay003 = g_imaj5_d[l_ac].imay003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               #20150517--add--geza--- 
               IF g_imaj5_d[l_ac].imay002 = '2' THEN
                  IF g_imaa_m.imaa109 = '1' THEN
                     IF g_imaj5_d[l_ac].imay005 = 1 THEN
                        CALL s_auto_barcode('1') RETURNING g_imaj5_d[l_ac].imay003,l_success
                     END IF
                     IF g_imaj5_d[l_ac].imay005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imaj5_d[l_ac].imay003,l_success
                     END IF
                  END IF
                  IF g_imaa_m.imaa109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imaj5_d[l_ac].imay003,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imaj5_d[l_ac].imay003,l_success
                  END IF
                  IF NOT l_success THEN
                     INITIALIZE g_imaj5_d[l_ac].* TO NULL
                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
               END IF
               #20150517--add--geza--- 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys[2] = g_imaj5_d[g_detail_idx].imay003
               CALL aslm200_insert_b('imay_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imaj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               #160822-00036#1 20160823 mark by beckxie---S
               ##160803-00008#4 20160811 add by beckxie---S
               #IF l_inam.getlength() >1 THEN
               #   #根據選的特徵自動生成多筆條碼資料
               #   CALL cl_err_collect_init()
               #   CALL s_transaction_begin()
               #   IF NOT s_artm300_ins_imay(l_inam) THEN
               #      CALL s_transaction_end('N','0')
               #   ELSE
               #      CALL s_transaction_end('Y','0')
               #   END IF
               #   CALL cl_err_collect_show()
               #   CALL aslm200_b_fill()
               #END IF           
               ##160803-00008#4 20160811 add by beckxie---E
               #160822-00036#1 20160823 mark by beckxie---E
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl5
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
               LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               #20150517--add--geza---
               IF g_imaj5_d[l_ac].imay002 = '2' AND g_imaj5_d_t.imay002 = '1' THEN
                  IF g_imaa_m.imaa109 = '1' OR g_imaa_m.imaa109 = '4' THEN
                     IF g_imaj5_d[l_ac].imay005 = 1 THEN
                        CALL s_auto_barcode('1') RETURNING g_imaj5_d[l_ac].imay003,l_success
                     END IF
                     IF g_imaj5_d[l_ac].imay005 > 1 THEN
                        CALL s_auto_barcode('2') RETURNING g_imaj5_d[l_ac].imay003,l_success
                     END IF
                  END IF
                  IF g_imaa_m.imaa109 = '4' THEN
                     CALL s_auto_barcode('4') RETURNING g_imaj5_d[l_ac].imay003,l_success
                  END IF
                  IF g_imaa_m.imaa109 = '5' THEN
                     CALL s_auto_barcode('5') RETURNING g_imaj5_d[l_ac].imay003,l_success
                  END IF
                  IF NOT l_success THEN
                     LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*                     
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #20140515--add--dongsz---
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               #將遮罩欄位還原
               CALL aslm200_imay_t_mask_restore('restore_mask_o')
                              
               UPDATE imay_t SET (imay001,imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018, 
                   imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) = (g_imaa_m.imaa001, 
                   g_imaj5_d[l_ac].imaystus,g_imaj5_d[l_ac].imay002,g_imaj5_d[l_ac].imay019,g_imaj5_d[l_ac].imay003, 
                   g_imaj5_d[l_ac].imay004,g_imaj5_d[l_ac].imay005,g_imaj5_d[l_ac].imay006,g_imaj5_d[l_ac].imay018, 
                   g_imaj5_d[l_ac].imay007,g_imaj5_d[l_ac].imay008,g_imaj5_d[l_ac].imay009,g_imaj5_d[l_ac].imay015, 
                   g_imaj5_d[l_ac].imay010,g_imaj5_d[l_ac].imay016,g_imaj5_d[l_ac].imay011,g_imaj5_d[l_ac].imay017, 
                   g_imaj5_d[l_ac].imay012,g_imaj5_d[l_ac].imay013,g_imaj5_d[l_ac].imay014) #自訂欄位頁簽 
 
                WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
                  AND imay003 = g_imaj5_d_t.imay003 #項次 
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaa_m.imaa001
               LET gs_keys_bak[1] = g_imaa001_t
               LET gs_keys[2] = g_imaj5_d[g_detail_idx].imay003
               LET gs_keys_bak[2] = g_imaj5_d_t.imay003
               CALL aslm200_update_b('imay_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aslm200_imay_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imaj5_d[g_detail_idx].imay003 = g_imaj5_d_t.imay003 
                  ) THEN
                  LET gs_keys[01] = g_imaa_m.imaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_imaj5_d_t.imay003
                  CALL aslm200_key_update_b(gs_keys,'imay_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj5_d_t)
               LET g_log2 = util.JSON.stringify(g_imaa_m),util.JSON.stringify(g_imaj5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaystus
            #add-point:BEFORE FIELD imaystus name="input.b.page5.imaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaystus
            
            #add-point:AFTER FIELD imaystus name="input.a.page5.imaystus"
            IF g_imaj5_d[l_ac].imaystus = 'Y' THEN
               IF g_imaa_m.imaa006 = g_imaj5_d[l_ac].imay004 THEN
                  LET g_imaj5_d[l_ac].imay005 = 1
                  #DISPLAY BY NAME g_imay_d[l_ac].imay005 #150504-00039#1 Mark By Ken 150506
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaystus
            #add-point:ON CHANGE imaystus name="input.g.page5.imaystus"
            IF g_imaj5_d[l_ac].imaystus = 'Y' AND NOT cl_null(g_imaj5_d[l_ac].imay004) THEN
               IF NOT aslm200_chk_imay004_1() THEN
                  LET g_imaj5_d[l_ac].imaystus = 'N'
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay002
            #add-point:BEFORE FIELD imay002 name="input.b.page5.imay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay002
            
            #add-point:AFTER FIELD imay002 name="input.a.page5.imay002"
            #dongsz--add--str---
            IF NOT cl_null(g_imaj5_d[l_ac].imay002) THEN
               IF g_imaa_m.imaa109 <> '1' AND g_imaj5_d[l_ac].imay002 = '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00399'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imaj5_d[l_ac].imay002 = g_imaj5_d_t.imay002
                  NEXT FIELD imay002
               END IF
            END IF
            #dongsz--add--end---
            IF l_cmd = 'a' THEN
               IF g_imaj5_d[l_ac].imay002 = '1' AND NOT cl_null(g_imaj5_d[l_ac].imay003) THEN
                  CALL s_chk_barcode(g_imaj5_d[l_ac].imay003) RETURNING g_success
                  IF g_success = 'N' THEN
                     LET g_imaj5_d[l_ac].imay002 = g_imaj5_d_t.imay002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF g_imaj5_d[l_ac].imay002 = '1' AND g_imaj5_d_t.imay002 = '2' THEN
                  LET g_imaj5_d[l_ac].imay003 = ""
               END IF
            END IF
            CALL aslm200_set_entry_b(l_cmd)
            #160801-00017#3 20160804 add by beckxie---S
            CALL aslm200_set_no_required_b(l_cmd)
            CALL aslm200_set_required_b(l_cmd)
            #160801-00017#3 20160804 add by beckxie---E
            CALL aslm200_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay002
            #add-point:ON CHANGE imay002 name="input.g.page5.imay002"
            #160801-00017#3 20160804 add by beckxie---S
            CALL aslm200_set_no_required_b(l_cmd)
            CALL aslm200_set_required_b(l_cmd)
            #160801-00017#3 20160804 add by beckxie---E
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019
            
            #add-point:AFTER FIELD imay019 name="input.a.page5.imay019"
            #160801-00017#3 20160804 add by beckxie---S
            LET g_imaj5_d[l_ac].imay019_desc=''
            IF NOT cl_null(g_imaj5_d[l_ac].imay019) THEN
               IF NOT s_feature_check_t('2','',g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) THEN
                  LET g_imaj5_d[l_ac].imay019 = g_imaj5_d_o.imay019
                  CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                       RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
                  NEXT FIELD CURRENT
               ELSE
                  LET g_imaj5_d_o.imay019 = g_imaj5_d[l_ac].imay019 
                  CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                       RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
                  DISPLAY BY NAME g_imaj5_d[l_ac].imay019,g_imaj5_d[l_ac].imay019_desc     
               END IF
            END IF
            #160801-00017#3 20160804 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019
            #add-point:BEFORE FIELD imay019 name="input.b.page5.imay019"
            #160801-00017#3 20160804 add by beckxie---S
            CALL aslm200_set_no_required_b(l_cmd)
            CALL aslm200_set_required_b(l_cmd)
            #160801-00017#3 20160804 add by beckxie---E
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay019
            #add-point:ON CHANGE imay019 name="input.g.page5.imay019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay019_desc
            #add-point:BEFORE FIELD imay019_desc name="input.b.page5.imay019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay019_desc
            
            #add-point:AFTER FIELD imay019_desc name="input.a.page5.imay019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay019_desc
            #add-point:ON CHANGE imay019_desc name="input.g.page5.imay019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay003
            #add-point:BEFORE FIELD imay003 name="input.b.page5.imay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay003
            
            #add-point:AFTER FIELD imay003 name="input.a.page5.imay003"
            #應用 a05 樣板自動產生(Version:3)
#            #確認資料無重複
#            IF  g_imaa_m.imaa001 IS NOT NULL AND g_imaj5_d[g_detail_idx].imay003 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj5_d[g_detail_idx].imay003 != g_imaj5_d_t.imay003)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imay_t WHERE "||"imayent = '" ||g_enterprise|| "' AND "||"imay003 = '"||g_imaa_m.imaa001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            IF  NOT cl_null(g_imaa_m.imaa001) AND NOT cl_null(g_imaj5_d[l_ac].imay003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaa_m.imaa001 != g_imaa001_t OR g_imaj5_d[l_ac].imay003 != g_imaj5_d_t.imay003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imay_t WHERE "||"imayent = '" ||g_enterprise|| "' AND "||"imay001 = '"||g_imaa_m.imaa001 ||"' AND "|| "imay003 = '"||g_imaj5_d[l_ac].imay003 ||"'",'std-00004',0) THEN 
                    #Mark&Add By 150204-00001#28 -- Begin -- 
                    #LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     IF NOT cl_null(g_imaj5_d_t.imay003) THEN
                        LET g_imaj5_d[l_ac].imay003 = g_imaj5_d_t.imay003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
                  CALL aslm200_chk_barcode(g_imaj5_d[l_ac].imay003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imaj5_d[l_ac].imay003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #Mark&Add By 150204-00001#28 -- Begin -- 
                    #LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     IF NOT cl_null(g_imaj5_d_t.imay003) THEN
                        LET g_imaj5_d[l_ac].imay003 = g_imaj5_d_t.imay003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF                 
               END IF
               #20140513--add--dongsz---
               IF g_imaj5_d[l_ac].imay002 = '1' THEN
                  CALL s_chk_barcode(g_imaj5_d[l_ac].imay003) RETURNING g_success
                  IF g_success = 'N' THEN
                    #Mark&Add By 150204-00001#28 -- Begin -- 
                    #LET g_imay_d[l_ac].imay003 = g_imay_d_t.imay003
                     IF NOT cl_null(g_imaj5_d_t.imay003) THEN
                        LET g_imaj5_d[l_ac].imay003 = g_imaj5_d_t.imay003
                     END IF
                    #Mark&Add By 150204-00001#28 -- End   --
                     NEXT FIELD CURRENT
                  END IF
               END IF                     
               #20140513--add--dongsz--- 
               IF g_imaj5_d[l_ac].imay002 != 3 THEN   #160803-00008#4 20160812 add by beckxie
                  #150906-00005#2 20151126 add by beckxie---S
                  IF NOT s_artt300_chk_imba014(g_imaj5_d[l_ac].imay003) THEN
                     IF NOT cl_null(g_imaj5_d_t.imay003) THEN
                        LET g_imaj5_d[l_ac].imay003 = g_imaj5_d_t.imay003
                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  #150906-00005#2 20151126 add by beckxie---E
               END IF   #160803-00008#4 20160812 add by beckxie
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay003
            #add-point:ON CHANGE imay003 name="input.g.page5.imay003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay004
            
            #add-point:AFTER FIELD imay004 name="input.a.page5.imay004"
            LET g_imaj5_d[l_ac].imay004_desc = ''
            IF NOT cl_null(g_imaj5_d[l_ac].imay004) THEN
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imay_d[l_ac].imay004 != g_imay_d_o.imay004 OR g_imay_d_o.imay004 IS NULL ) THEN   #150427-00012#6 20150707 mark by beckxie
               IF g_imaj5_d[l_ac].imay004 != g_imaj5_d_o.imay004 OR cl_null(g_imaj5_d_o.imay004) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL aslm200_chk_unit(g_imaj5_d[l_ac].imay004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imaj5_d[l_ac].imay004
                     #160318-00005#42 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     #160318-00005#42 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imaj5_d[l_ac].imay004 = g_imaj5_d_o.imay004
                     CALL aslm200_imay004_ref()
                     NEXT FIELD CURRENT
                  END IF                
               END IF 
               #150518-00035#1 geza add(S)
               IF g_imaj5_d[l_ac].imay005 IS NULL OR g_imaj5_d[l_ac].imay005 = '0' THEN
                  LET g_imaj5_d[l_ac].imay005 = 1                
               END IF  
               IF NOT cl_null(g_imaj5_d[l_ac].imay005) THEN 
                  IF g_imaa_m.imaa109 = '1' AND g_imaa_m.imaa100 = '2' AND g_imaj5_d[l_ac].imay002 = '2' THEN
                     IF NOT aslm200_imay005_chk() THEN
                        LET g_imaj5_d[l_ac].imay005 =g_imaj5_d_o.imay005
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF
               #150518-00035#1 geza add(S)                 
            END IF            

            IF g_imaj5_d[l_ac].imaystus = 'Y' AND NOT cl_null(g_imaj5_d[l_ac].imay004) THEN              
               IF g_imaj5_d[l_ac].imay004 <> g_imaj5_d_o.imay004 OR cl_null(g_imaj5_d_o.imay004) THEN
                  #150602-00072#1 Add-S By Ken 150602
                  CALL aslm200_imay005_chk_1() RETURNING l_success,l_imay005
                  IF l_success THEN  #商品的多條碼包裝單位已存在時，預帶申請單中的同包裝單位件裝數
                     LET g_imaj5_d[l_ac].imay005 = l_imay005
                  END IF
               END IF
            END IF
            LET g_imaj5_d_o.imay004 = g_imaj5_d[l_ac].imay004
            LET g_imaj5_d_o.imay005 = g_imaj5_d[l_ac].imay005            
            CALL aslm200_imay004_ref()
            CALL aslm200_set_entry_b(l_cmd)
            CALL aslm200_set_no_entry_b(l_cmd)
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj5_d[l_ac].imay004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj5_d[l_ac].imay004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj5_d[l_ac].imay004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay004
            #add-point:BEFORE FIELD imay004 name="input.b.page5.imay004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay004
            #add-point:ON CHANGE imay004 name="input.g.page5.imay004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imay005
            END IF 
 
 
 
            #add-point:AFTER FIELD imay005 name="input.a.page5.imay005"
            IF NOT cl_null(g_imaj5_d[l_ac].imay005) THEN 
               IF g_imaa_m.imaa109 = '1' AND g_imaa_m.imaa100 = '2' AND g_imaj5_d[l_ac].imay002 = '2' THEN
                  IF NOT aslm200_imay005_chk() THEN
                     LET g_imaj5_d[l_ac].imay005 = g_imaj5_d_o.imay005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET  g_imaj5_d_o.imay005 = g_imaj5_d[l_ac].imay005 #150602-00072#1 By Ken 150602 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay005
            #add-point:BEFORE FIELD imay005 name="input.b.page5.imay005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay005
            #add-point:ON CHANGE imay005 name="input.g.page5.imay005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay006
            #add-point:BEFORE FIELD imay006 name="input.b.page5.imay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay006
            
            #add-point:AFTER FIELD imay006 name="input.a.page5.imay006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay006
            #add-point:ON CHANGE imay006 name="input.g.page5.imay006"
            IF g_imaj5_d[l_ac].imay006 = 'Y' AND g_imaj5_d[l_ac].imaystus = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00033'
               LET g_errparam.extend = g_imaj5_d[l_ac].imay006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imaj5_d[l_ac].imay006 = 'N'
               NEXT FIELD CURRENT
            END IF
            IF g_imaj5_d[l_ac].imay006 = 'Y' AND g_imaj5_d[l_ac].imay004 != g_imaa_m.imaa006 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asl-00001'
               LET g_errparam.extend = g_imaj5_d[l_ac].imay006
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_imaj5_d[l_ac].imay006 = 'N'
               NEXT FIELD CURRENT
            END IF   
            #20140527--dongsz--add---
            IF NOT cl_null(g_imaj5_d[l_ac].imay003) AND g_imaj5_d[l_ac].imay006 = 'Y' 
               AND g_imaj5_d[l_ac].imay002 = '2' THEN
               IF NOT aslm200_imay006_chk() THEN
                  LET g_imaj5_d[l_ac].imay006 = 'N'
                  NEXT FIELD CURRENT
               END IF
            END IF
            #20140527--dongsz--add---
            IF NOT cl_null(g_imaj5_d[l_ac].imay003) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imay_t
                WHERE imay001 = g_imaa_m.imaa001
                  AND imay003 != g_imaj5_d[l_ac].imay003
                  AND imay006 = 'Y'
                  AND imayent = g_enterprise
               IF l_cnt != 0 AND g_imaj5_d[l_ac].imay006 = 'Y' THEN
                  IF cl_ask_confirm('art-00026') THEN
                     UPDATE imay_t SET imay006 = 'N'
                      WHERE imay001 = g_imaa_m.imaa001
                        AND imay003 != g_imaj5_d[l_ac].imay003
                        AND imay006 = 'Y'
                        AND imayent = g_enterprise
                     FOR l_i = 1 TO g_imaj5_d.getLength()
                        IF l_i != l_ac THEN
                           LET g_imaj5_d[l_i].imay006 = 'N'
                        END IF
                     END FOR
                  ELSE
                     LET g_imaj5_d[l_ac].imay006 = 'N'
                  END IF
               END IF
            ELSE
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM imay_t
                WHERE imay001 = g_imaa_m.imaa001                  
                  AND imay006 = 'Y'
                  AND imayent = g_enterprise
               IF l_cnt != 0 AND g_imaj5_d[l_ac].imay006 = 'Y' THEN
                  IF cl_ask_confirm('art-00026') THEN
                     UPDATE imay_t SET imay006 = 'N'
                      WHERE imay001 = g_imaa_m.imaa001
                        AND imay006 = 'Y'
                        AND imayent = g_enterprise
                     FOR l_i = 1 TO g_imaj5_d.getLength()
                        IF l_i != l_ac THEN
                           LET g_imaj5_d[l_i].imay006 = 'N'
                        END IF
                     END FOR
                  ELSE
                     LET g_imaj5_d[l_ac].imay006 = 'N'
                  END IF
               END IF
            END IF
            #dongsz--add--str---
            IF g_imaj5_d[l_ac].imay006 = 'Y' THEN
               LET g_imaa_m.imaa100 = g_imaj5_d[l_ac].imay002
               LET g_imaa_m.imaa014 = g_imaj5_d[l_ac].imay003
               #LET g_imaa_m.imaa113 = g_imaj5_d[l_ac].imay018 #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
               IF g_imaa_m.imaa100 = '1' THEN
                  LET g_imaa_m.imaa109 = '1'
               END IF                  
               UPDATE imaa_t SET imaa100 = g_imaj5_d[l_ac].imay002,
                                 imaa014 = g_imaj5_d[l_ac].imay003,
                                 #imaa113 = g_imaj5_d[l_ac].imay018, #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
                                 imaa109 = g_imaa_m.imaa109
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_imaa_m.imaa001
               DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014,g_imaa_m.imaa109
               LET g_imaa_m_o.imaa100 = g_imaa_m.imaa100
               LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014
               #LET g_imaa_m_o.imaa113 = g_imaa_m.imaa113 #ken---add 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
            END IF
            #dongsz--add--end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay018
            #add-point:BEFORE FIELD imay018 name="input.b.page5.imay018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay018
            
            #add-point:AFTER FIELD imay018 name="input.a.page5.imay018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay018
            #add-point:ON CHANGE imay018 name="input.g.page5.imay018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay007
            END IF 
 
 
 
            #add-point:AFTER FIELD imay007 name="input.a.page5.imay007"
            IF NOT cl_null(g_imaj5_d[l_ac].imay007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay007
            #add-point:BEFORE FIELD imay007 name="input.b.page5.imay007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay007
            #add-point:ON CHANGE imay007 name="input.g.page5.imay007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay008
            END IF 
 
 
 
            #add-point:AFTER FIELD imay008 name="input.a.page5.imay008"
            IF NOT cl_null(g_imaj5_d[l_ac].imay008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay008
            #add-point:BEFORE FIELD imay008 name="input.b.page5.imay008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay008
            #add-point:ON CHANGE imay008 name="input.g.page5.imay008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay009
            END IF 
 
 
 
            #add-point:AFTER FIELD imay009 name="input.a.page5.imay009"
            IF NOT cl_null(g_imaj5_d[l_ac].imay009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay009
            #add-point:BEFORE FIELD imay009 name="input.b.page5.imay009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay009
            #add-point:ON CHANGE imay009 name="input.g.page5.imay009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay015
            
            #add-point:AFTER FIELD imay015 name="input.a.page5.imay015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj5_d[l_ac].imay015
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj5_d[l_ac].imay015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj5_d[l_ac].imay015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay015
            #add-point:BEFORE FIELD imay015 name="input.b.page5.imay015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay015
            #add-point:ON CHANGE imay015 name="input.g.page5.imay015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay010
            END IF 
 
 
 
            #add-point:AFTER FIELD imay010 name="input.a.page5.imay010"
            IF NOT cl_null(g_imaj5_d[l_ac].imay010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay010
            #add-point:BEFORE FIELD imay010 name="input.b.page5.imay010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay010
            #add-point:ON CHANGE imay010 name="input.g.page5.imay010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay016
            
            #add-point:AFTER FIELD imay016 name="input.a.page5.imay016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj5_d[l_ac].imay016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj5_d[l_ac].imay016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj5_d[l_ac].imay016_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay016
            #add-point:BEFORE FIELD imay016 name="input.b.page5.imay016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay016
            #add-point:ON CHANGE imay016 name="input.g.page5.imay016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaj5_d[l_ac].imay011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imay011
            END IF 
 
 
 
            #add-point:AFTER FIELD imay011 name="input.a.page5.imay011"
            IF NOT cl_null(g_imaj5_d[l_ac].imay011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay011
            #add-point:BEFORE FIELD imay011 name="input.b.page5.imay011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay011
            #add-point:ON CHANGE imay011 name="input.g.page5.imay011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay017
            
            #add-point:AFTER FIELD imay017 name="input.a.page5.imay017"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj5_d[l_ac].imay017
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj5_d[l_ac].imay017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj5_d[l_ac].imay017_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay017
            #add-point:BEFORE FIELD imay017 name="input.b.page5.imay017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay017
            #add-point:ON CHANGE imay017 name="input.g.page5.imay017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay012
            #add-point:BEFORE FIELD imay012 name="input.b.page5.imay012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay012
            
            #add-point:AFTER FIELD imay012 name="input.a.page5.imay012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay012
            #add-point:ON CHANGE imay012 name="input.g.page5.imay012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay013
            #add-point:BEFORE FIELD imay013 name="input.b.page5.imay013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay013
            
            #add-point:AFTER FIELD imay013 name="input.a.page5.imay013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay013
            #add-point:ON CHANGE imay013 name="input.g.page5.imay013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imay014
            #add-point:BEFORE FIELD imay014 name="input.b.page5.imay014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imay014
            
            #add-point:AFTER FIELD imay014 name="input.a.page5.imay014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imay014
            #add-point:ON CHANGE imay014 name="input.g.page5.imay014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaystus
            #add-point:ON ACTION controlp INFIELD imaystus name="input.c.page5.imaystus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay002
            #add-point:ON ACTION controlp INFIELD imay002 name="input.c.page5.imay002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019
            #add-point:ON ACTION controlp INFIELD imay019 name="input.c.page5.imay019"
            #160801-00017#3 20160804 add by beckxie---S
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(g_imaa_m.imaa005) THEN
               #160803-00008#4 20160811 add by beckxie---S
               IF l_cmd = 'a' AND g_imaj5_d[l_ac].imay002 = '3' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature_1(l_cmd,'2',g_imaa_m.imaa001,'',g_site,'') 
                       RETURNING l_success,l_inam
                  LET g_imaj5_d[l_ac].imay019 = l_inam[1].inam002
                  CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                       RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
                  IF NOT cl_null(l_inam[1].inam002) THEN
                     LET g_imaj5_d[l_ac].imay003 = g_imaa_m.imaa001,s_feature_get_feature_str(g_imaj5_d[l_ac].imay019)
                  END IF
                  #160822-00036#1 20160824 add by beckxie---S
                  IF l_inam.getlength() >1 THEN
                     #根據選的特徵自動生成多筆條碼資料
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF NOT s_artm300_ins_imay(l_inam) THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                     CALL cl_err_collect_show()
                     CALL aslm200_show()
                     #因為可能會修改此筆資料,顯示後需刪除
                     DELETE FROM imay_t WHERE imayent = g_enterprise AND imay003 = g_imaj5_d[l_ac].imay003
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "DELETE FROM :"
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     END IF
                  END IF           
                  #160822-00036#1 20160824 add by beckxie---E
               ELSE
               #160803-00008#4 20160811 add by beckxie---E
                  CALL s_feature_single(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019,g_site,'')
                       RETURNING l_success,g_imaj5_d[l_ac].imay019
                  CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                       RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
               END IF   #160803-00008#4 20160811 add by beckxie
            END IF
            DISPLAY BY NAME g_imaj5_d[l_ac].imay019,g_imaj5_d[l_ac].imay019_desc     
            #160801-00017#3 20160804 add by beckxie---E
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay019_desc
            #add-point:ON ACTION controlp INFIELD imay019_desc name="input.c.page5.imay019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay003
            #add-point:ON ACTION controlp INFIELD imay003 name="input.c.page5.imay003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay004
            #add-point:ON ACTION controlp INFIELD imay004 name="input.c.page5.imay004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imaj5_d[l_ac].imay004        #給予default值
            #給予arg
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_imaj5_d[l_ac].imay004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_imaj5_d[l_ac].imay004 TO imay004              #顯示到畫面上
            CALL aslm200_imay004_ref()
            NEXT FIELD imay004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay005
            #add-point:ON ACTION controlp INFIELD imay005 name="input.c.page5.imay005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay006
            #add-point:ON ACTION controlp INFIELD imay006 name="input.c.page5.imay006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay018
            #add-point:ON ACTION controlp INFIELD imay018 name="input.c.page5.imay018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay007
            #add-point:ON ACTION controlp INFIELD imay007 name="input.c.page5.imay007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay008
            #add-point:ON ACTION controlp INFIELD imay008 name="input.c.page5.imay008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay009
            #add-point:ON ACTION controlp INFIELD imay009 name="input.c.page5.imay009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay015
            #add-point:ON ACTION controlp INFIELD imay015 name="input.c.page5.imay015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaj5_d[l_ac].imay015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imaj5_d[l_ac].imay015 = g_qryparam.return1              

            DISPLAY g_imaj5_d[l_ac].imay015 TO imay015              #

            NEXT FIELD imay015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page5.imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay010
            #add-point:ON ACTION controlp INFIELD imay010 name="input.c.page5.imay010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay016
            #add-point:ON ACTION controlp INFIELD imay016 name="input.c.page5.imay016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaj5_d[l_ac].imay016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imaj5_d[l_ac].imay016 = g_qryparam.return1              

            DISPLAY g_imaj5_d[l_ac].imay016 TO imay016              #

            NEXT FIELD imay016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page5.imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay011
            #add-point:ON ACTION controlp INFIELD imay011 name="input.c.page5.imay011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay017
            #add-point:ON ACTION controlp INFIELD imay017 name="input.c.page5.imay017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaj5_d[l_ac].imay017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imaj5_d[l_ac].imay017 = g_qryparam.return1              

            DISPLAY g_imaj5_d[l_ac].imay017 TO imay017              #

            NEXT FIELD imay017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page5.imay012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay012
            #add-point:ON ACTION controlp INFIELD imay012 name="input.c.page5.imay012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay013
            #add-point:ON ACTION controlp INFIELD imay013 name="input.c.page5.imay013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.imay014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imay014
            #add-point:ON ACTION controlp INFIELD imay014 name="input.c.page5.imay014"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imaj5_d[l_ac].* = g_imaj5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aslm200_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aslm200_unlock_b("imay_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM imay_t
             WHERE imay001 = g_imaa_m.imaa001
               AND imayent   = g_enterprise
               AND imay006   = 'Y'
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00034'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #dongsz--add--str---
#               LET g_imaa_m.imaa100 = ""  #geza--mark--20150417---
               LET g_imaa_m.imaa014 = ""
               LET g_imaa_m.imaa019 = ""
               LET g_imaa_m.imaa020 = ""
               LET g_imaa_m.imaa021 = ""
               LET g_imaa_m.imaa022 = ""
               LET g_imaa_m.imaa025 = ""
               LET g_imaa_m.imaa026 = ""
               LET g_imaa_m.imaa016 = ""
               LET g_imaa_m.imaa018 = ""
               UPDATE imaa_t SET imaa100 = g_imaa_m.imaa100,
                                 imaa014 = g_imaa_m.imaa014,
                                 imaa019 = g_imaa_m.imaa019,
                                 imaa020 = g_imaa_m.imaa020,
                                 imaa021 = g_imaa_m.imaa021,
                                 imaa022 = g_imaa_m.imaa022,
                                 imaa025 = g_imaa_m.imaa025,
                                 imaa026 = g_imaa_m.imaa026,
                                 imaa016 = g_imaa_m.imaa016,
                                 imaa018 = g_imaa_m.imaa018                                 
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_imaa_m.imaa001
               DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014,g_imaa_m.imaa019,g_imaa_m.imaa020,
                               g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa025,g_imaa_m.imaa026,
                               g_imaa_m.imaa016,g_imaa_m.imaa018
               #dongsz--add--end---
               CALL aslm200_imaa022_ref()
               #CALL artm300_imaa026_ref()
               CALL aslm200_imaa018_ref()
            ELSE
               IF l_cnt = 1 THEN
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay001 = g_imaa_m.imaa001
                     AND imay006 = 'Y'
                     AND imaystus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD imay006
                  END IF
                  SELECT imay002,imay003,
                         imay007,imay008,imay009,imay015,
                         imay010,imay016,
                         imay011,imay017
                    INTO g_imaa_m.imaa100,g_imaa_m.imaa014,
                         g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,
                         g_imaa_m.imaa025,g_imaa_m.imaa026,
                         g_imaa_m.imaa016,g_imaa_m.imaa018
                    FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay001 = g_imaa_m.imaa001
                     AND imay006 = 'Y'
                  
                  UPDATE imaa_t SET imaa100 = g_imaa_m.imaa100,
                                    imaa014 = g_imaa_m.imaa014,
                                    imaa019 = g_imaa_m.imaa019,
                                    imaa020 = g_imaa_m.imaa020,
                                    imaa021 = g_imaa_m.imaa021,
                                    imaa022 = g_imaa_m.imaa022,
                                    imaa025 = g_imaa_m.imaa025,
                                    imaa026 = g_imaa_m.imaa026,
                                    imaa016 = g_imaa_m.imaa016,
                                    imaa018 = g_imaa_m.imaa018                                    
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_imaa_m.imaa001
                  DISPLAY BY NAME g_imaa_m.imaa100,g_imaa_m.imaa014,g_imaa_m.imaa019,g_imaa_m.imaa020,
                                  g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa025,g_imaa_m.imaa026,
                                  g_imaa_m.imaa016,g_imaa_m.imaa018       
                  CALL aslm200_imaa022_ref()
                  #CALL artm300_imaa026_ref()
                  CALL aslm200_imaa018_ref()                                  
                  IF g_imaa_m.imaa100 = '1' THEN
                     UPDATE imaa_t SET imaa109 = '1'
                      WHERE imaaent = g_enterprise
                        AND imaa001 = g_imaa_m.imaa001
                     DISPLAY BY NAME g_imaa_m.imaa109
                  END IF
                  #2014/06/20 By pomelo add start------
                  #更新商品的主條碼時，一併修改門店商品清單的主條碼資料
                  LET l_time = cl_get_current()
                  UPDATE rtdx_t
                     SET rtdx002 = g_imaa_m.imaa014,
                         rtdxmodid = g_user,
                         rtdxmoddt = l_time
                   WHERE rtdxent = g_enterprise
                     AND rtdx001 = g_imaa_m.imaa001
                  #2014/06/20 By pomelo add start------
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00035'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imay006
               END IF
            END IF
            #150629-00021#1 20150629 add by beckxie---S
            CALL s_transaction_begin()
            CALL s_artm300_ins_imao(g_imaa_m.imaa001) RETURNING l_success
            CALL aslm200_b_fill()
            CALL s_transaction_end('Y',0)
            #150629-00021#1 20150629 add by beckxie---E
            LET g_imaa_m_o.imaa100 = g_imaa_m.imaa100
            LET g_imaa_m_o.imaa014 = g_imaa_m.imaa014  
            LET g_imaa_m_o.imaa019 = g_imaa_m.imaa019            
            LET g_imaa_m_o.imaa020 = g_imaa_m.imaa020  
            LET g_imaa_m_o.imaa021 = g_imaa_m.imaa021  
            LET g_imaa_m_o.imaa022 = g_imaa_m.imaa022  
            LET g_imaa_m_o.imaa025 = g_imaa_m.imaa025  
            LET g_imaa_m_o.imaa026 = g_imaa_m.imaa026  
            LET g_imaa_m_o.imaa016 = g_imaa_m.imaa016 
            LET g_imaa_m_o.imaa018 = g_imaa_m.imaa018  
            LET g_imaa_m_t.imaa100 = g_imaa_m.imaa100
            LET g_imaa_m_t.imaa014 = g_imaa_m.imaa014  
            LET g_imaa_m_t.imaa019 = g_imaa_m.imaa019            
            LET g_imaa_m_t.imaa020 = g_imaa_m.imaa020  
            LET g_imaa_m_t.imaa021 = g_imaa_m.imaa021  
            LET g_imaa_m_t.imaa022 = g_imaa_m.imaa022  
            LET g_imaa_m_t.imaa025 = g_imaa_m.imaa025  
            LET g_imaa_m_t.imaa026 = g_imaa_m.imaa026  
            LET g_imaa_m_t.imaa016 = g_imaa_m.imaa016 
            LET g_imaa_m_t.imaa018 = g_imaa_m.imaa018 
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_imaj5_d[li_reproduce_target].* = g_imaj5_d[li_reproduce].*
 
               LET g_imaj5_d[li_reproduce_target].imay003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaj5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaj5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aslm200.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      #160805-00028#1 160812 by lori add---(S)
      DISPLAY ARRAY g_imas_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
           ##顯示單身筆數
           CALL aslm200_idx_chk()
           #確定當下選擇的筆數
           LET l_ac = DIALOG.getCurrentRow("s_detail6")
           LET g_detail_idx = l_ac
           
         BEFORE DISPLAY
            ##如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            LET g_current_page = 6
            #顯示單身筆數
            CALL aslm200_idx_chk()
      END DISPLAY
      #160805-00028#1 160812 by lori add---(E)
         
      SUBDIALOG aim_aimm200_01.aimm200_01_input
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aimm200_01"
                  #判斷當前料號的產品特徵是否可以維護，如果不可以維護，進入其他欄位
                  IF NOT aslm200_imak003_enrty_chk() THEN
                     NEXT FIELD imaa011
                  ELSE
                     NEXT FIELD imak003    
                  END IF                     
            END CASE
            ##判斷當前料號的產品特徵是否可以維護，如果不可以維護，進入其他欄位
            #IF NOT aslm200_imak003_enrty_chk() THEN
            #   NEXT FIELD imaal003 
            #END IF
            NEXT FIELD imaal003 
         END IF     
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
 
            #end add-point  
            NEXT FIELD imaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imaj002
               WHEN "s_detail2"
                  NEXT FIELD imal002
               WHEN "s_detail3"
                  NEXT FIELD imam002
               WHEN "s_detail4"
                  NEXT FIELD imao002
               WHEN "s_detail5"
                  NEXT FIELD imaystus
 
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
         LET g_field = DIALOG.getCurrentItem()
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aslm200_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5   #160801-00017#3 20160804 add by beckxie
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      LET g_imaa_m_o.* = g_imaa_m.*
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aslm200_b_fill() #單身填充
      CALL aslm200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aslm200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#               INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaaownid_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaaowndp_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaacrtid_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaacrtdp_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_imaa_m.imaacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaamodid_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_imaa_m.imaamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaacnfid_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaacnfid_desc
            
            CALL aslm200_imaa_desc()
            
            IF NOT cl_null(g_imaa_m.imaa001) THEN
               CALL s_aooi360_sel('3',g_imaa_m.imaa001,'','','','','','','','','','4') RETURNING l_success,g_imaa_m.ooff013
               IF l_success = 'TRUE' THEN
                  DISPLAY BY NAME g_imaa_m.ooff013
               END IF 
            END IF   
           SELECT imac002,imac003 INTO g_imaa_m.imac002,g_imaa_m.imac003 FROM imac_t WHERE imacent = g_enterprise AND imac001 = g_imaa_m.imaa001            
   #end add-point
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aslm200_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa126_desc,g_imaa_m.imaa127, 
       g_imaa_m.imaa127_desc,g_imaa_m.imaa131,g_imaa_m.imaa131_desc,g_imaa_m.imaa128,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129,g_imaa_m.imaa129_desc,g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa132_desc, 
       g_imaa_m.imaa133,g_imaa_m.imaa133_desc,g_imaa_m.imaa134,g_imaa_m.imaa134_desc,g_imaa_m.imaa135, 
       g_imaa_m.imaa135_desc,g_imaa_m.imaa136,g_imaa_m.imaa136_desc,g_imaa_m.imaa137,g_imaa_m.imaa137_desc, 
       g_imaa_m.imaa138,g_imaa_m.imaa138_desc,g_imaa_m.imaa139,g_imaa_m.imaa139_desc,g_imaa_m.imaa140, 
       g_imaa_m.imaa140_desc,g_imaa_m.imaa141,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfid_desc,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
       g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
       g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaa142, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121, 
       g_imaa_m.imaa124,g_imaa_m.imaa124_desc,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa018_desc, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa022_desc,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027, 
       g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa029_desc,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
       g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa039_desc,g_imaa_m.imaa040,g_imaa_m.imaa041, 
       g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa122_desc,g_imaa_m.imaa045, 
       g_imaa_m.imaa045_desc,g_imaa_m.imaa123,g_imaa_m.imac002,g_imaa_m.imac003
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imaj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                  INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='270' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj002_desc 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='271' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj003_desc 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj_d[l_ac].imaj006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='272' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj_d[l_ac].imaj006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj_d[l_ac].imaj006_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_imaj2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
                  INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='213' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj2_d[l_ac].imal002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj2_d[l_ac].imal002_desc
            
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
            CALL ap_ref_array2(g_ref_fields," SELECT oocq005 FROM oocq_t WHERE oocqent = '"||g_enterprise||"' AND oocq001 = '213' AND oocq002 = ? ","") RETURNING g_rtn_fields 
            LET g_imaj2_d[l_ac].l_oocq005 = g_rtn_fields[1]
            DISPLAY BY NAME g_imaj2_d[l_ac].l_oocq005           
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imaj3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imaj4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
                  INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaj4_d[l_ac].imao002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaj4_d[l_ac].imao002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaj4_d[l_ac].imao002_desc

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imaj5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      #160801-00017#3 20160804 add by beckxie---S
      CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                       RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
      DISPLAY BY NAME g_imaj5_d[l_ac].imay019_desc
      #160801-00017#3 20160804 add by beckxie---E
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aslm200_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aslm200_set_pk_array()
   DISPLAY cl_doc_get_pic() TO ffimage   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aslm200_detail_show()
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
 
{<section id="aslm200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aslm200_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imaa_t.imaa001 
   DEFINE l_oldno     LIKE imaa_t.imaa001 
 
   DEFINE l_master    RECORD LIKE imaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imaj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imal_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imam_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imao_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE  l_flag     LIKE type_t.chr1
   DEFINE  l_sys      LIKE type_t.chr1
   DEFINE  l_success  LIKE type_t.num5
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
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imaa001_t = g_imaa_m.imaa001
 
    
   LET g_imaa_m.imaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaa_m.imaaownid = g_user
      LET g_imaa_m.imaaowndp = g_dept
      LET g_imaa_m.imaacrtid = g_user
      LET g_imaa_m.imaacrtdp = g_dept 
      LET g_imaa_m.imaacrtdt = cl_get_current()
      LET g_imaa_m.imaamodid = g_user
      LET g_imaa_m.imaamoddt = cl_get_current()
      LET g_imaa_m.imaastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
         LET g_imaa_m.imaacnfid = ""
      LET g_imaa_m.imaacnfdt = ""
      LET g_imaa_m.imaa034 = '2'
      LET g_imaa_m.imaastus = 'N'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      LET g_imaa_m.imaa001 = ''      
      INITIALIZE g_imaa_m_o.* TO NULL   #add--2015/05/06 By shiun
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imaa_m.imaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aslm200_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imaa_m.* TO NULL
      INITIALIZE g_imaj_d TO NULL
      INITIALIZE g_imaj2_d TO NULL
      INITIALIZE g_imaj3_d TO NULL
      INITIALIZE g_imaj4_d TO NULL
      INITIALIZE g_imaj5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aslm200_show()
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
   CALL aslm200_set_act_visible()   
   CALL aslm200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaaent = " ||g_enterprise|| " AND",
                      " imaa001 = '", g_imaa_m.imaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aslm200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   #add by tangyi-增加产品特征(库存)复制-重新产生条码-str-#160818-00039
   CALL aslm200_imas_reproduce()
   CALL aslm200_show()
   #end add-point
   
   CALL aslm200_idx_chk()
   
   LET g_data_owner = g_imaa_m.imaaownid      
   LET g_data_dept  = g_imaa_m.imaaowndp
   
   #功能已完成,通報訊息中心
   CALL aslm200_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aslm200_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imaj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imal_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imam_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imao_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE imay_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aslm200_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imaj_t
    WHERE imajent = g_enterprise AND imaj001 = g_imaa001_t
 
    INTO TEMP aslm200_detail
 
   #將key修正為調整後   
   UPDATE aslm200_detail 
      #更新key欄位
      SET imaj001 = g_imaa_m.imaa001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, imaystus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imaj_t SELECT * FROM aslm200_detail
   
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
   DROP TABLE aslm200_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imal_t 
    WHERE imalent = g_enterprise AND imal001 = g_imaa001_t
 
    INTO TEMP aslm200_detail
 
   #將key修正為調整後   
   UPDATE aslm200_detail SET imal001 = g_imaa_m.imaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imal_t SELECT * FROM aslm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aslm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imam_t 
    WHERE imament = g_enterprise AND imam001 = g_imaa001_t
 
    INTO TEMP aslm200_detail
 
   #將key修正為調整後   
   UPDATE aslm200_detail SET imam001 = g_imaa_m.imaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imam_t SELECT * FROM aslm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aslm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imao_t 
    WHERE imaoent = g_enterprise AND imao001 = g_imaa001_t
 
    INTO TEMP aslm200_detail
 
   #將key修正為調整後   
   UPDATE aslm200_detail SET imao001 = g_imaa_m.imaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imao_t SELECT * FROM aslm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aslm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imay_t 
    WHERE imayent = g_enterprise AND imay001 = g_imaa001_t
 
    INTO TEMP aslm200_detail
 
   #將key修正為調整後   
   UPDATE aslm200_detail SET imay001 = g_imaa_m.imaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imay_t SELECT * FROM aslm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aslm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   #add by tangyi 160818-增加产品特征(库存)复制-str-#160818-00039
   SELECT * FROM imas_t
    WHERE imasent = g_enterprise AND imas001 = g_imaa001_t
    INTO TEMP aslm200_detail
   UPDATE aslm200_detail SET imas001 = g_imaa_m.imaa001
   INSERT INTO imas_t SELECT * FROM aslm200_detail
   DROP TABLE aslm200_detail
   #add by tangyi 160818-end
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imaa001_t = g_imaa_m.imaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aslm200_delete()
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
   
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.imaal001 = g_imaa_m.imaa001
LET g_master_multi_table_t.imaal003 = g_imaa_m.imaal003
LET g_master_multi_table_t.imaal004 = g_imaa_m.imaal004
LET g_master_multi_table_t.imaal005 = g_imaa_m.imaal005
 
   
   CALL s_transaction_begin()
 
   OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aslm200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aslm200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
   
   #檢查是否允許此動作
   IF NOT aslm200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaa_m_mask_o.* =  g_imaa_m.*
   CALL aslm200_imaa_t_mask()
   LET g_imaa_m_mask_n.* =  g_imaa_m.*
   
   CALL aslm200_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
            IF g_imaa_m.imaastus = 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aim-00201'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aslm200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imaa001_t = g_imaa_m.imaa001
 
 
      DELETE FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
           
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imaa_m.imaa001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
            DELETE FROM imaal_t
       WHERE imaalent = g_enterprise AND imaal001 = g_imaa_m.imaa001
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      DELETE FROM imab_t
       WHERE imabent = g_enterprise AND imab001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM imac_t
       WHERE imacent = g_enterprise AND imac001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      DELETE FROM imae_t
       WHERE imaeent = g_enterprise AND imae001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imae_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    

      DELETE FROM imaf_t
       WHERE imafent = g_enterprise AND imaf001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imaf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
      
      DELETE FROM imag_t
       WHERE imagent = g_enterprise AND imag001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imag_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
      #20150430--POLLY--imah_t改為iman_t--(S)
      #DELETE FROM imah_t
      # WHERE imahent = g_enterprise AND imah001 = g_imaa_m.imaa001
      DELETE FROM iman_t
       WHERE imanent = g_enterprise AND iman001 = g_imaa_m.imaa001       
     #20150430--POLLY--imah_t改為iman_t--(E)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "iman_t"
         LET g_errparam.popup = FALSE
         CALL cl_err() 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    

      DELETE FROM imai_t
       WHERE imaient = g_enterprise AND imai001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imai_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    

      DELETE FROM imak_t
       WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imak_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
      
      DELETE FROM imao_t
       WHERE imaoent = g_enterprise AND imao001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #160805-00028#1 160815 by lori add---(S) 
      DELETE FROM imas_t
       WHERE imasent = g_enterprise AND imas001 = g_imaa_m.imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imas_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #160805-00028#1 160815 by lori add---(E)
     
      #add by lixh
      IF NOT s_log_imaa010_del(g_site,g_imaa_m.imaa001,'aslm200','') THEN
         CALL s_transaction_end('N','0')
         RETURN          
      END IF
      CALL s_aooi360_del('3',g_imaa_m.imaa001,'','','','','','','','','','4') RETURNING l_success
      IF l_success = "FALSE" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')     
      END IF    
      #end add-point
      
      DELETE FROM imaj_t
       WHERE imajent = g_enterprise AND imaj001 = g_imaa_m.imaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
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
      DELETE FROM imal_t
       WHERE imalent = g_enterprise AND
             imal001 = g_imaa_m.imaa001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
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
      DELETE FROM imam_t
       WHERE imament = g_enterprise AND
             imam001 = g_imaa_m.imaa001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM imao_t
       WHERE imaoent = g_enterprise AND
             imao001 = g_imaa_m.imaa001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      CALL aimm200_01_clear_detail()
      #15/06/08 Sarah add
      #更新自動編碼最大流水號檔
      IF NOT cl_null(g_imaa_m.imaa001) THEN
         CALL s_aooi390_oofi_del('1',g_imaa_m.imaa001) RETURNING g_success
         IF NOT g_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #15/06/08 Sarah add
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND
             imay001 = g_imaa_m.imaa001
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aslm200_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imaj_d.clear() 
      CALL g_imaj2_d.clear()       
      CALL g_imaj3_d.clear()       
      CALL g_imaj4_d.clear()       
      CALL g_imaj5_d.clear()       
 
     
      CALL aslm200_ui_browser_refresh()  
      #CALL aslm200_ui_headershow()  
      #CALL aslm200_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imaalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
   LET l_field_keys[02] = 'imaal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imaal_t')
 
      
      #單身多語言刪除
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aslm200_browser_fill("")
         CALL aslm200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aslm200_cl
 
   #功能已完成,通報訊息中心
   CALL aslm200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aslm200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aslm200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5   #160801-00017#3 20160804 add by beckxie
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imaj_d.clear()
   CALL g_imaj2_d.clear()
   CALL g_imaj3_d.clear()
   CALL g_imaj4_d.clear()
   CALL g_imaj5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aslm200_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imaj002,imaj003,imaj004,imaj005,imaj006 ,t1.oocql004 ,t2.oocql004 , 
             t3.oocal003 ,t4.oocql004 FROM imaj_t",   
                     " INNER JOIN imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imaj001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='270' AND t1.oocql002=imaj002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='271' AND t2.oocql002=imaj003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imaj005 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='272' AND t4.oocql002=imaj006 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE imajent=? AND imaj001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imaj_t.imaj002,imaj_t.imaj003"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aslm200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aslm200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imaa_m.imaa001 INTO g_imaj_d[l_ac].imaj002,g_imaj_d[l_ac].imaj003, 
          g_imaj_d[l_ac].imaj004,g_imaj_d[l_ac].imaj005,g_imaj_d[l_ac].imaj006,g_imaj_d[l_ac].imaj002_desc, 
          g_imaj_d[l_ac].imaj003_desc,g_imaj_d[l_ac].imaj005_desc,g_imaj_d[l_ac].imaj006_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
   IF aslm200_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imal002 ,t5.oocql004 FROM imal_t",   
                     " INNER JOIN  imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imal001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='213' AND t5.oocql002=imal002 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE imalent=? AND imal001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imal_t.imal002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aslm200_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aslm200_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_imaa_m.imaa001 INTO g_imaj2_d[l_ac].imal002,g_imaj2_d[l_ac].imal002_desc  
            #(ver:78)
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
   IF aslm200_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imam002,imam005,imam003,imam006,imam004  FROM imam_t",   
                     " INNER JOIN  imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imam001 ",
 
                     "",
                     
                     
                     " WHERE imament=? AND imam001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imam_t.imam002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aslm200_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aslm200_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_imaa_m.imaa001 INTO g_imaj3_d[l_ac].imam002,g_imaj3_d[l_ac].imam005, 
          g_imaj3_d[l_ac].imam003,g_imaj3_d[l_ac].imam006,g_imaj3_d[l_ac].imam004   #(ver:78)
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
 
   #判斷是否填充
   IF aslm200_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imao002 ,t6.oocal003 FROM imao_t",   
                     " INNER JOIN  imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imao001 ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=imao002 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE imaoent=? AND imao001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imao_t.imao002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aslm200_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aslm200_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_imaa_m.imaa001 INTO g_imaj4_d[l_ac].imao002,g_imaj4_d[l_ac].imao002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
                  CALL aslm200_imao002_desc()
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
   IF aslm200_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imaystus,imay002,imay019,imay003,imay004,imay005,imay006,imay018, 
             imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014 , 
             t7.oocal003 ,t8.oocal003 ,t9.oocal003 FROM imay_t",   
                     " INNER JOIN  imaa_t ON imaaent = " ||g_enterprise|| " AND imaa001 = imay001 ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=imay004 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=imay015 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=imay016 AND t9.oocal002='"||g_dlang||"' ",
 
                     " WHERE imayent=? AND imay001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imay_t.imay003"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aslm200_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR aslm200_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_imaa_m.imaa001   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_imaa_m.imaa001 INTO g_imaj5_d[l_ac].imaystus,g_imaj5_d[l_ac].imay002, 
          g_imaj5_d[l_ac].imay019,g_imaj5_d[l_ac].imay003,g_imaj5_d[l_ac].imay004,g_imaj5_d[l_ac].imay005, 
          g_imaj5_d[l_ac].imay006,g_imaj5_d[l_ac].imay018,g_imaj5_d[l_ac].imay007,g_imaj5_d[l_ac].imay008, 
          g_imaj5_d[l_ac].imay009,g_imaj5_d[l_ac].imay015,g_imaj5_d[l_ac].imay010,g_imaj5_d[l_ac].imay016, 
          g_imaj5_d[l_ac].imay011,g_imaj5_d[l_ac].imay017,g_imaj5_d[l_ac].imay012,g_imaj5_d[l_ac].imay013, 
          g_imaj5_d[l_ac].imay014,g_imaj5_d[l_ac].imay004_desc,g_imaj5_d[l_ac].imay015_desc,g_imaj5_d[l_ac].imay016_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         #160801-00017#3 20160804 add by beckxie---S
         CALL s_feature_description(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay019) 
                          RETURNING l_success,g_imaj5_d[l_ac].imay019_desc
         DISPLAY BY NAME g_imaj5_d[l_ac].imay019_desc
         #160801-00017#3 20160804 add by beckxie---E
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
   CALL aslm200_imas_show()   #160805-00028#1 160812 by lori add
   LET g_imaa001_d = g_imaa_m.imaa001
   CALL aimm200_01_b_fill(g_imaa001_d)
   #end add-point
   
   CALL g_imaj_d.deleteElement(g_imaj_d.getLength())
   CALL g_imaj2_d.deleteElement(g_imaj2_d.getLength())
   CALL g_imaj3_d.deleteElement(g_imaj3_d.getLength())
   CALL g_imaj4_d.deleteElement(g_imaj4_d.getLength())
   CALL g_imaj5_d.deleteElement(g_imaj5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aslm200_pb
   FREE aslm200_pb2
 
   FREE aslm200_pb3
 
   FREE aslm200_pb4
 
   FREE aslm200_pb5
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imaj_d.getLength()
      LET g_imaj_d_mask_o[l_ac].* =  g_imaj_d[l_ac].*
      CALL aslm200_imaj_t_mask()
      LET g_imaj_d_mask_n[l_ac].* =  g_imaj_d[l_ac].*
   END FOR
   
   LET g_imaj2_d_mask_o.* =  g_imaj2_d.*
   FOR l_ac = 1 TO g_imaj2_d.getLength()
      LET g_imaj2_d_mask_o[l_ac].* =  g_imaj2_d[l_ac].*
      CALL aslm200_imal_t_mask()
      LET g_imaj2_d_mask_n[l_ac].* =  g_imaj2_d[l_ac].*
   END FOR
   LET g_imaj3_d_mask_o.* =  g_imaj3_d.*
   FOR l_ac = 1 TO g_imaj3_d.getLength()
      LET g_imaj3_d_mask_o[l_ac].* =  g_imaj3_d[l_ac].*
      CALL aslm200_imam_t_mask()
      LET g_imaj3_d_mask_n[l_ac].* =  g_imaj3_d[l_ac].*
   END FOR
   LET g_imaj4_d_mask_o.* =  g_imaj4_d.*
   FOR l_ac = 1 TO g_imaj4_d.getLength()
      LET g_imaj4_d_mask_o[l_ac].* =  g_imaj4_d[l_ac].*
      CALL aslm200_imao_t_mask()
      LET g_imaj4_d_mask_n[l_ac].* =  g_imaj4_d[l_ac].*
   END FOR
   LET g_imaj5_d_mask_o.* =  g_imaj5_d.*
   FOR l_ac = 1 TO g_imaj5_d.getLength()
      LET g_imaj5_d_mask_o[l_ac].* =  g_imaj5_d[l_ac].*
      CALL aslm200_imay_t_mask()
      LET g_imaj5_d_mask_n[l_ac].* =  g_imaj5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aslm200_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM imaj_t
       WHERE imajent = g_enterprise AND
         imaj001 = ps_keys_bak[1] AND imaj002 = ps_keys_bak[2] AND imaj003 = ps_keys_bak[3]
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
         CALL g_imaj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM imal_t
       WHERE imalent = g_enterprise AND
             imal001 = ps_keys_bak[1] AND imal002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imaj2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM imam_t
       WHERE imament = g_enterprise AND
             imam001 = ps_keys_bak[1] AND imam002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imaj3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM imao_t
       WHERE imaoent = g_enterprise AND
             imao001 = ps_keys_bak[1] AND imao002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imaj4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM imay_t
       WHERE imayent = g_enterprise AND
             imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_imaj5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aslm200_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO imaj_t
                  (imajent,
                   imaj001,
                   imaj002,imaj003
                   ,imaj004,imaj005,imaj006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_imaj_d[g_detail_idx].imaj004,g_imaj_d[g_detail_idx].imaj005,g_imaj_d[g_detail_idx].imaj006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imaj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO imal_t
                  (imalent,
                   imal001,
                   imal002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imaj2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO imam_t
                  (imament,
                   imam001,
                   imam002
                   ,imam005,imam003,imam006,imam004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imaj3_d[g_detail_idx].imam005,g_imaj3_d[g_detail_idx].imam003,g_imaj3_d[g_detail_idx].imam006, 
                       g_imaj3_d[g_detail_idx].imam004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imaj3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO imao_t
                  (imaoent,
                   imao001,
                   imao002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imaj4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO imay_t
                  (imayent,
                   imay001,
                   imay003
                   ,imaystus,imay002,imay019,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imaj5_d[g_detail_idx].imaystus,g_imaj5_d[g_detail_idx].imay002,g_imaj5_d[g_detail_idx].imay019, 
                       g_imaj5_d[g_detail_idx].imay004,g_imaj5_d[g_detail_idx].imay005,g_imaj5_d[g_detail_idx].imay006, 
                       g_imaj5_d[g_detail_idx].imay018,g_imaj5_d[g_detail_idx].imay007,g_imaj5_d[g_detail_idx].imay008, 
                       g_imaj5_d[g_detail_idx].imay009,g_imaj5_d[g_detail_idx].imay015,g_imaj5_d[g_detail_idx].imay010, 
                       g_imaj5_d[g_detail_idx].imay016,g_imaj5_d[g_detail_idx].imay011,g_imaj5_d[g_detail_idx].imay017, 
                       g_imaj5_d[g_detail_idx].imay012,g_imaj5_d[g_detail_idx].imay013,g_imaj5_d[g_detail_idx].imay014) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_imaj5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aslm200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imaj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aslm200_imaj_t_mask_restore('restore_mask_o')
               
      UPDATE imaj_t 
         SET (imaj001,
              imaj002,imaj003
              ,imaj004,imaj005,imaj006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_imaj_d[g_detail_idx].imaj004,g_imaj_d[g_detail_idx].imaj005,g_imaj_d[g_detail_idx].imaj006)  
 
         WHERE imajent = g_enterprise AND imaj001 = ps_keys_bak[1] AND imaj002 = ps_keys_bak[2] AND imaj003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imaj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imaj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aslm200_imaj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imal_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aslm200_imal_t_mask_restore('restore_mask_o')
               
      UPDATE imal_t 
         SET (imal001,
              imal002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imalent = g_enterprise AND imal001 = ps_keys_bak[1] AND imal002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imal_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imal_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aslm200_imal_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imam_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aslm200_imam_t_mask_restore('restore_mask_o')
               
      UPDATE imam_t 
         SET (imam001,
              imam002
              ,imam005,imam003,imam006,imam004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imaj3_d[g_detail_idx].imam005,g_imaj3_d[g_detail_idx].imam003,g_imaj3_d[g_detail_idx].imam006, 
                  g_imaj3_d[g_detail_idx].imam004) 
         WHERE imament = g_enterprise AND imam001 = ps_keys_bak[1] AND imam002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imam_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imam_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aslm200_imam_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imao_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aslm200_imao_t_mask_restore('restore_mask_o')
               
      UPDATE imao_t 
         SET (imao001,
              imao002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imaoent = g_enterprise AND imao001 = ps_keys_bak[1] AND imao002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imao_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imao_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aslm200_imao_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imay_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aslm200_imay_t_mask_restore('restore_mask_o')
               
      UPDATE imay_t 
         SET (imay001,
              imay003
              ,imaystus,imay002,imay019,imay004,imay005,imay006,imay018,imay007,imay008,imay009,imay015,imay010,imay016,imay011,imay017,imay012,imay013,imay014) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imaj5_d[g_detail_idx].imaystus,g_imaj5_d[g_detail_idx].imay002,g_imaj5_d[g_detail_idx].imay019, 
                  g_imaj5_d[g_detail_idx].imay004,g_imaj5_d[g_detail_idx].imay005,g_imaj5_d[g_detail_idx].imay006, 
                  g_imaj5_d[g_detail_idx].imay018,g_imaj5_d[g_detail_idx].imay007,g_imaj5_d[g_detail_idx].imay008, 
                  g_imaj5_d[g_detail_idx].imay009,g_imaj5_d[g_detail_idx].imay015,g_imaj5_d[g_detail_idx].imay010, 
                  g_imaj5_d[g_detail_idx].imay016,g_imaj5_d[g_detail_idx].imay011,g_imaj5_d[g_detail_idx].imay017, 
                  g_imaj5_d[g_detail_idx].imay012,g_imaj5_d[g_detail_idx].imay013,g_imaj5_d[g_detail_idx].imay014)  
 
         WHERE imayent = g_enterprise AND imay001 = ps_keys_bak[1] AND imay003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imay_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aslm200_imay_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aslm200_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aslm200.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aslm200_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aslm200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aslm200_lock_b(ps_table,ps_page)
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
   #CALL aslm200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imaj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aslm200_bcl USING g_enterprise,
                                       g_imaa_m.imaa001,g_imaj_d[g_detail_idx].imaj002,g_imaj_d[g_detail_idx].imaj003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "imal_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aslm200_bcl2 USING g_enterprise,
                                             g_imaa_m.imaa001,g_imaj2_d[g_detail_idx].imal002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "imam_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aslm200_bcl3 USING g_enterprise,
                                             g_imaa_m.imaa001,g_imaj3_d[g_detail_idx].imam002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "imao_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aslm200_bcl4 USING g_enterprise,
                                             g_imaa_m.imaa001,g_imaj4_d[g_detail_idx].imao002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "imay_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aslm200_bcl5 USING g_enterprise,
                                             g_imaa_m.imaa001,g_imaj5_d[g_detail_idx].imay003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_bcl5:",SQLERRMESSAGE 
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
 
{<section id="aslm200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aslm200_unlock_b(ps_table,ps_page)
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
      CLOSE aslm200_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aslm200_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aslm200_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aslm200_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aslm200_bcl5
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aslm200_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imaa001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("imaa028,imaa029,imaa030,imaa031,imaa032,imaa033,imaa005,imaa003,imaa009",TRUE)
   CALL cl_set_comp_entry("imaa111,imaa112",TRUE)
   CALL cl_set_comp_entry("imaa014",TRUE)
   CALL cl_set_comp_entry("imaa100,imaa109",TRUE)
   #IF g_imaa_m.imaa100 = '1' THEN
   #   CALL cl_set_comp_required("imaa014",TRUE)
   #END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aslm200_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imaa001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
#151116-00013 by whitney mark start
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM inag_t
#       WHERE inagent = g_enterprise
#         AND inagsite = g_site
#         AND inag001 = g_imaa_m.imaa001
#      IF l_n > 0 THEN
#         CALL cl_set_comp_entry("imaa005,imaa003,imaa009",FALSE)
#         LET  g_imaa_m.imaa005 = g_imaa_m_o.imaa005
#         DISPLAY g_imaa_m.imaa005
#      END IF
#151116-00013 by whitney mark end
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_imaa_m.imaa110 = 'N' THEN
      CALL cl_set_comp_entry("imaa111,imaa112",FALSE)
   END IF
   IF g_imaa_m.imaa100 = '1' THEN
      LET g_imaa_m.imaa109 = "1"
   END IF
   IF g_imaa_m.imaa100 = '2' THEN
      CALL cl_set_comp_entry("imaa014",FALSE)
   END IF
   #多条码单身有资料关闭条码类型，条码分类，商品条码栏位
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM imay_t 
    WHERE imayent = g_enterprise 
      AND imay001 = g_imaa_m.imaa001
   IF  l_n > 0 THEN
      CALL cl_set_comp_entry("imaa100",FALSE)
      CALL cl_set_comp_entry("imaa109",FALSE)
      CALL cl_set_comp_entry("imaa014",FALSE)      
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aslm200_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("imay003,imay005",TRUE)   
   CALL cl_set_comp_entry("imay002",TRUE)
   CALL cl_set_comp_entry("imay019",TRUE)   #160801-00017#3 20160804 add by beckxie
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aslm200_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_imay006    LIKE imay_t.imay006 
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_imaj5_d[l_ac].imay002 = '2' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("imay003",FALSE)
   END IF
   IF g_imaj5_d[l_ac].imay004 = g_imaa_m.imaa006 THEN
      CALL cl_set_comp_entry("imay005",FALSE)
   END IF
   #多条码单身维护的时候，判断如果是主条码,关闭单身条码分类栏位  add geza 2015/04/12
   LET l_cnt = 0
   SELECT imay006 INTO l_imay006 FROM imay_t
    WHERE imayent = g_enterprise
      AND imay003 = g_imaj5_d[l_ac].imay003
   IF l_imay006 = 'Y' THEN
      CALL cl_set_comp_entry("imay002",FALSE)
   END IF
   #160801-00017#3 20160804 add by beckxie---S
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   IF cl_null(g_imaa_m.imaa005) THEN
      CALL cl_set_comp_entry("imay019",FALSE)
   END IF
   #160801-00017#3 20160804 add by beckxie---E
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aslm200_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete",TRUE)
   CALL cl_set_act_visible("open_aslm200_s01",TRUE)   #160805-00028#1 160815 by lori add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aslm200_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_imaa_m.imaastus = 'X' THEN
      CALL cl_set_act_visible("modify,delete",FALSE)
      CALL cl_set_act_visible("open_aslm200_s01",FALSE)   #160805-00028#1 160815 by lori add  
   END IF
   IF g_imaa_m.imaastus = 'Y' THEN
      CALL cl_set_act_visible("delete",FALSE)
#      CALL cl_set_act_visible("open_aslm200_s01",FALSE)   #160805-00028#1 160815 by lori add  #161101-00024#1 2016/11/01 by 08172
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aslm200_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aslm200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aslm200_default_search()
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
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " imaa001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "imaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imaj_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imal_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imam_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imao_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imay_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
 
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
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
            END IF
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
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
 
{<section id="aslm200.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aslm200_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imaa_m.imaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
   IF STATUS THEN
      CLOSE aslm200_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aslm200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa116, 
       g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
       g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
       g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034, 
       g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
       g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122,g_imaa_m.imaa045, 
       g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc,g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc,g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc,g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc, 
       g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc,g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc, 
       g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
   
 
   #檢查是否允許此動作
   IF NOT aslm200_action_chk() THEN
      CLOSE aslm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
       g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
       g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
       g_imaa_m.imaa010_desc,g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa126_desc,g_imaa_m.imaa127, 
       g_imaa_m.imaa127_desc,g_imaa_m.imaa131,g_imaa_m.imaa131_desc,g_imaa_m.imaa128,g_imaa_m.imaa128_desc, 
       g_imaa_m.imaa129,g_imaa_m.imaa129_desc,g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa132_desc, 
       g_imaa_m.imaa133,g_imaa_m.imaa133_desc,g_imaa_m.imaa134,g_imaa_m.imaa134_desc,g_imaa_m.imaa135, 
       g_imaa_m.imaa135_desc,g_imaa_m.imaa136,g_imaa_m.imaa136_desc,g_imaa_m.imaa137,g_imaa_m.imaa137_desc, 
       g_imaa_m.imaa138,g_imaa_m.imaa138_desc,g_imaa_m.imaa139,g_imaa_m.imaa139_desc,g_imaa_m.imaa140, 
       g_imaa_m.imaa140_desc,g_imaa_m.imaa141,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
       g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
       g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfid_desc,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
       g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
       g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa143_desc,g_imaa_m.imaa142, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121, 
       g_imaa_m.imaa124,g_imaa_m.imaa124_desc,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa018_desc, 
       g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022, 
       g_imaa_m.imaa022_desc,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027, 
       g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa029_desc,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
       g_imaa_m.imaa032_desc,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037, 
       g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa039_desc,g_imaa_m.imaa040,g_imaa_m.imaa041, 
       g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122,g_imaa_m.imaa122_desc,g_imaa_m.imaa045, 
       g_imaa_m.imaa045_desc,g_imaa_m.imaa123,g_imaa_m.imac002,g_imaa_m.imac003
 
   CASE g_imaa_m.imaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imaa_m.imaastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("valid,void,invalid", TRUE)
      IF g_imaa_m.imaastus = 'Y' THEN
         CALL cl_set_act_visible("void,valid", FALSE)
      END IF 
      IF g_imaa_m.imaastus = 'X' THEN
         CALL cl_set_act_visible("valid,void", FALSE)
      END IF 
      IF g_imaa_m.imaastus = 'N' THEN
         CALL cl_set_act_visible("invalid", FALSE)
      END IF    
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
         
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
         
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
         
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
      g_imaa_m.imaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aslm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = "Y" THEN
      CALL s_aimm200_conf_chk(g_imaa_m.imaa001,g_imaa_m.imaastus) RETURNING l_success
      IF l_success = FALSE THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         #160801-00017#3 20160804 add by beckxie---S
         IF NOT s_artm300_imay_chk(g_imaa_m.imaa001) THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         #160801-00017#3 20160804 add by beckxie---E
         IF NOT cl_ask_confirm('aim-00108') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aimm200_conf_upd(g_imaa_m.imaa001) RETURNING l_success
            IF l_success = FALSE THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_imaa_m.imaacnfid = g_user
            LET g_imaa_m.imaacnfdt = cl_get_current()
            UPDATE imaa_t SET imaacnfid = g_imaa_m.imaacnfid,
                              imaacnfdt = g_imaa_m.imaacnfdt
            WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
            CALL s_aimm200_ins_item_site(g_imaa_m.imaa001,'2') RETURNING l_success,g_errno
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_imaa_m.imaa001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               RETURN
            END IF
            CALL s_aimm200_send_mail(g_imaa_m.imaa001,g_imaa_m.imaa003) #151119 earl mod
         END IF
      END IF
   END IF
   IF lc_state = "N" THEN
      CALL s_aimm200_unconf_chk(g_imaa_m.imaa001,g_imaa_m.imaastus) RETURNING l_success,g_errno
      IF l_success = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_imaa_m.imaastus
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF g_imaa_m.imaastus = 'Y' THEN
            IF NOT cl_ask_confirm('aim-00110') THEN 
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_aimm200_unconf_upd(g_imaa_m.imaa001) RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
         END IF   
         IF g_imaa_m.imaastus = 'X' THEN
            IF NOT cl_ask_confirm('aim-00200') THEN 
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_aimm200_unconf_upd(g_imaa_m.imaa001) RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF            
         END IF
      END IF
   END IF 
   IF lc_state = "X" THEN
      CALL s_aimm200_void_chk(g_imaa_m.imaa001,g_imaa_m.imaastus) RETURNING l_success
      IF l_success = FALSE THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('art-00039') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aimm200_void_upd(g_imaa_m.imaa001) RETURNING l_success
            IF l_success = FALSE THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF 
 
   CALL s_transaction_end('Y','0') 
   
   #end add-point
   
   LET g_imaa_m.imaamodid = g_user
   LET g_imaa_m.imaamoddt = cl_get_current()
   LET g_imaa_m.imaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imaa_t 
      SET (imaastus,imaamodid,imaamoddt) 
        = (g_imaa_m.imaastus,g_imaa_m.imaamodid,g_imaa_m.imaamoddt)     
    WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001
 
    
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
      EXECUTE aslm200_master_referesh USING g_imaa_m.imaa001 INTO g_imaa_m.imaa001,g_imaa_m.imaa002, 
          g_imaa_m.imaa009,g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010, 
          g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
          g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136, 
          g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid, 
          g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid, 
          g_imaa_m.imaamoddt,g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
          g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
          g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa142,g_imaa_m.imaa108, 
          g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa016, 
          g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa159,g_imaa_m.imaa160,g_imaa_m.imaa019,g_imaa_m.imaa020, 
          g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026, 
          g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
          g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043, 
          g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044, 
          g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc, 
          g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc,g_imaa_m.imaa126_desc,g_imaa_m.imaa127_desc, 
          g_imaa_m.imaa131_desc,g_imaa_m.imaa128_desc,g_imaa_m.imaa129_desc,g_imaa_m.imaa132_desc,g_imaa_m.imaa133_desc, 
          g_imaa_m.imaa134_desc,g_imaa_m.imaa135_desc,g_imaa_m.imaa136_desc,g_imaa_m.imaa137_desc,g_imaa_m.imaa138_desc, 
          g_imaa_m.imaa139_desc,g_imaa_m.imaa140_desc,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid_desc, 
          g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc, 
          g_imaa_m.imaacnfid_desc,g_imaa_m.imaa143_desc,g_imaa_m.imaa142_desc,g_imaa_m.imaa124_desc, 
          g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc,g_imaa_m.imaa032_desc,g_imaa_m.imaa122_desc, 
          g_imaa_m.imaa045_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005, 
          g_imaa_m.imaa009,g_imaa_m.imaa009_desc,g_imaa_m.imaa003,g_imaa_m.imaa003_desc,g_imaa_m.imaa004, 
          g_imaa_m.imaa005,g_imaa_m.imaa005_desc,g_imaa_m.imaa006,g_imaa_m.imaa006_desc,g_imaa_m.imaa010, 
          g_imaa_m.imaa010_desc,g_imaa_m.imaastus,g_imaa_m.imaa126,g_imaa_m.imaa126_desc,g_imaa_m.imaa127, 
          g_imaa_m.imaa127_desc,g_imaa_m.imaa131,g_imaa_m.imaa131_desc,g_imaa_m.imaa128,g_imaa_m.imaa128_desc, 
          g_imaa_m.imaa129,g_imaa_m.imaa129_desc,g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa132_desc, 
          g_imaa_m.imaa133,g_imaa_m.imaa133_desc,g_imaa_m.imaa134,g_imaa_m.imaa134_desc,g_imaa_m.imaa135, 
          g_imaa_m.imaa135_desc,g_imaa_m.imaa136,g_imaa_m.imaa136_desc,g_imaa_m.imaa137,g_imaa_m.imaa137_desc, 
          g_imaa_m.imaa138,g_imaa_m.imaa138_desc,g_imaa_m.imaa139,g_imaa_m.imaa139_desc,g_imaa_m.imaa140, 
          g_imaa_m.imaa140_desc,g_imaa_m.imaa141,g_imaa_m.imaa141_desc,g_imaa_m.imaaownid,g_imaa_m.imaaownid_desc, 
          g_imaa_m.imaaowndp,g_imaa_m.imaaowndp_desc,g_imaa_m.imaacrtid,g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp, 
          g_imaa_m.imaacrtdp_desc,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamodid_desc,g_imaa_m.imaamoddt, 
          g_imaa_m.imaacnfid,g_imaa_m.imaacnfid_desc,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012, 
          g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa100,g_imaa_m.imaa109,g_imaa_m.imaa154,g_imaa_m.imaa155, 
          g_imaa_m.imaa156,g_imaa_m.imaa116,g_imaa_m.imaa158,g_imaa_m.imaa143,g_imaa_m.imaa143_desc, 
          g_imaa_m.imaa142,g_imaa_m.imaa142_desc,g_imaa_m.imaa108,g_imaa_m.imaa110,g_imaa_m.imaa111, 
          g_imaa_m.imaa112,g_imaa_m.imaa121,g_imaa_m.imaa124,g_imaa_m.imaa124_desc,g_imaa_m.imaa016, 
          g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa018_desc,g_imaa_m.imaa159,g_imaa_m.imaa160, 
          g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa022_desc, 
          g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028, 
          g_imaa_m.imaa029,g_imaa_m.imaa029_desc,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
          g_imaa_m.imaa032_desc,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036, 
          g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa039_desc, 
          g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.ooff013,g_imaa_m.imaa122, 
          g_imaa_m.imaa122_desc,g_imaa_m.imaa045,g_imaa_m.imaa045_desc,g_imaa_m.imaa123,g_imaa_m.imac002, 
          g_imaa_m.imac003
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aslm200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aslm200_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aslm200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aslm200_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imaj_d.getLength() THEN
         LET g_detail_idx = g_imaj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imaj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imaj_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imaj2_d.getLength() THEN
         LET g_detail_idx = g_imaj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imaj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imaj2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_imaj3_d.getLength() THEN
         LET g_detail_idx = g_imaj3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imaj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imaj3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_imaj4_d.getLength() THEN
         LET g_detail_idx = g_imaj4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imaj4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imaj4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_imaj5_d.getLength() THEN
         LET g_detail_idx = g_imaj5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imaj5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imaj5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #160805-00028#1 160812 by lori add---(S)
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_imas_d.getLength() THEN
         LET g_detail_idx = g_imas_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imas_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imas_d.getLength() TO FORMONLY.cnt
   END IF   
   #160805-00028#1 160812 by lori add---(E)
   
   #若停留在嵌入的Page, 必須更新單身筆數顯示
   CASE g_detail_id
      WHEN "feature_page"
         DISPLAY g_d_idx_m20001, g_d_cnt_m20001 TO FORMONLY.idx, FORMONLY.cnt
   END CASE
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aslm200_b_fill2(pi_idx)
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
   
   CALL aslm200_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aslm200_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aslm200.status_show" >}
PRIVATE FUNCTION aslm200_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aslm200.mask_functions" >}
&include "erp/asl/aslm200_mask.4gl"
 
{</section>}
 
{<section id="aslm200.signature" >}
   
 
{</section>}
 
{<section id="aslm200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aslm200_set_pk_array()
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
   LET g_pk_array[1].values = g_imaa_m.imaa001
   LET g_pk_array[1].column = 'imaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aslm200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aslm200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aslm200_msgcentre_notify(lc_state)
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
   CALL aslm200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aslm200.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aslm200_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aslm200.other_function" readonly="Y" >}
#+ imaa_t 相關欄位的參考欄位帶值顯示
PRIVATE FUNCTION aslm200_imaa_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaa_m.imaa001
            CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_imaa_m.imaal003 = g_rtn_fields[1] 
            LET g_imaa_m.imaal004 = g_rtn_fields[2] 
            LET g_imaa_m.imaal005 = g_rtn_fields[3] 
            DISPLAY BY NAME g_imaa_m.imaal003,g_imaa_m.imaal004,g_imaa_m.imaal005
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa009
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa009_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaa009_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa003_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaa003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_m.imaa122
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_m.imaa122_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_imaa_m.imaa122_desc
          
#            CALL aslm200_imca_desc()
            
END FUNCTION
#+ 依據[C:主分群碼]的值抓主分群檔的各欄位值，帶回到本申請單相關欄位預設值
PRIVATE FUNCTION aslm200_show_imca()
   DEFINE l_n LIKE type_t.num5
   IF NOT cl_null(g_imaa_m.imaa003) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_site
         AND inag001 = g_imaa_m.imaa001
      IF l_n>0 THEN 
         LET  g_imaa_m.imaa005 = g_imaa_m_o.imaa005 
         LET g_flag = 'Y'
         DISPLAY BY NAME g_imaa_m.imaa005
      ELSE 
         SELECT imca005 INTO g_imaa_m.imaa005 FROM imca_t
          WHERE imca001 = g_imaa_m.imaa003
            AND imcaent = g_enterprise 
         LET g_flag = 'N' 
         DISPLAY BY NAME g_imaa_m.imaa005         
      END IF
      #SELECT imca003,imca004,imca006,imca010,imca011,imca012,imca013,imca014,     #160901-00041#1 dongsz mark
      SELECT imca003,imca004,imca006,imca010,imca011,imca012,imca013,       #160901-00041#1 dongsz add
             imca018,imca022,imca024,imca026,imca027,imca029,imca030,imca032,imca033,
             imca036,imca037,imca038,imca041,imca042,imca044,imca045,
             imca122,imca123,imca126,imca127,imca128,imca129,imca130,
             imca131,imca132,imca133,imca134,imca135,imca136,imca137,imca138,
             imca139,imca140,imca141,
             imca043,  #add by lixiang 2015/07/23
             imca154,imca155,imca156,imca100,imca109,
             imca110,imca111,imca112,imca121
        INTO g_imaa_m.imac003,g_imaa_m.imaa004,g_imaa_m.imaa006,g_imaa_m.imaa010,
             #g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,     #160901-00041#1 dongsz mark
             g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,        #160901-00041#1 dongsz add
             g_imaa_m.imaa018,g_imaa_m.imaa022,g_imaa_m.imaa024,g_imaa_m.imaa026,
             g_imaa_m.imaa027,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa032,g_imaa_m.imaa033,
             g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa038,g_imaa_m.imaa041,
             g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa045,
             g_imaa_m.imaa122,g_imaa_m.imaa123,g_imaa_m.imaa126,
             g_imaa_m.imaa127,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130,
             g_imaa_m.imaa131,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,
             g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137,g_imaa_m.imaa138,
             g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,
             g_imaa_m.imaa043, #add by lixiang 2015/07/23
             g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa100,g_imaa_m.imaa109,
             g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121
        FROM imca_t
       WHERE imca001 = g_imaa_m.imaa003
         AND imcaent = g_enterprise
      IF cl_null(g_imaa_m.imaa004) THEN LET g_imaa_m.imaa004 = "M" END IF
      IF cl_null(g_imaa_m.imaa011) THEN LET g_imaa_m.imaa011 = "0" END IF
      IF cl_null(g_imaa_m.imaa012) THEN LET g_imaa_m.imaa012 = "Y" END IF
      IF cl_null(g_imaa_m.imaa027) THEN LET g_imaa_m.imaa027 = "N" END IF
      IF cl_null(g_imaa_m.imaa034) THEN LET g_imaa_m.imaa034 = "1" END IF
      IF cl_null(g_imaa_m.imaa036) THEN LET g_imaa_m.imaa036 = "N" END IF
      IF cl_null(g_imaa_m.imaa037) THEN LET g_imaa_m.imaa037 = "N" END IF
      IF cl_null(g_imaa_m.imaa038) THEN LET g_imaa_m.imaa038 = "N" END IF
      IF cl_null(g_imaa_m.imaa044) THEN LET g_imaa_m.imaa044 = "3" END IF
         
      DISPLAY BY NAME g_imaa_m.imac003,g_imaa_m.imaa004,g_imaa_m.imaa006,g_imaa_m.imaa010,
                      g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,
                      g_imaa_m.imaa018,g_imaa_m.imaa022,g_imaa_m.imaa024,g_imaa_m.imaa026,
                      g_imaa_m.imaa027,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa032,g_imaa_m.imaa033,
                      g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa038,g_imaa_m.imaa041,
                      g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa045,
                      g_imaa_m.imaa122,g_imaa_m.imaa123,g_imaa_m.imaa126,
                      g_imaa_m.imaa127,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130,
                      g_imaa_m.imaa131,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,
                      g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137,g_imaa_m.imaa138,
                      g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,
                      g_imaa_m.imaa043, #add by lixiang 2015/07/23
                      g_imaa_m.imaa154,g_imaa_m.imaa155,g_imaa_m.imaa156,g_imaa_m.imaa100,g_imaa_m.imaa109,
                      g_imaa_m.imaa110,g_imaa_m.imaa111,g_imaa_m.imaa112,g_imaa_m.imaa121
      END IF                
      CALL aslm200_set_entry('a')
      CALL aslm200_set_no_entry('a')
      CALL aslm200_imca_desc()
      CALL aslm200_imca_b_fill()
END FUNCTION
#+ imaa003帶出預設值后顯示imaa相關欄位的參考欄位
PRIVATE FUNCTION aslm200_imca_desc()
            
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa005
   CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa005_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa005_desc            
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa006_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa006_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa010_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa142
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa142_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa142_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa018
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa018_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa018_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa022
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa022_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa022_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa029
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa029_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa029_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa032
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa032_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa032_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa039
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa039_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa039_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa122
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa122_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imaa_m.imaa122_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa045
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa045_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imaa_m.imaa045_desc
   
   #141231-00010#1--add--begin----
   #统计分类页签的栏位说明
   CALL s_desc_get_acc_desc('2002',g_imaa_m.imaa126) RETURNING g_imaa_m.imaa126_desc
   DISPLAY BY NAME g_imaa_m.imaa126_desc
   
   CALL s_desc_get_acc_desc('2003',g_imaa_m.imaa127) RETURNING g_imaa_m.imaa127_desc
   DISPLAY BY NAME g_imaa_m.imaa127_desc
   
   CALL s_desc_get_acc_desc('2001',g_imaa_m.imaa131) RETURNING g_imaa_m.imaa131_desc
   DISPLAY BY NAME g_imaa_m.imaa131_desc
   
   CALL s_desc_get_acc_desc('2004',g_imaa_m.imaa128) RETURNING g_imaa_m.imaa128_desc
   DISPLAY BY NAME g_imaa_m.imaa128_desc
   
   CALL s_desc_get_acc_desc('2005',g_imaa_m.imaa129) RETURNING g_imaa_m.imaa129_desc
   DISPLAY BY NAME g_imaa_m.imaa129_desc
   
   CALL s_desc_get_acc_desc('2006',g_imaa_m.imaa132) RETURNING g_imaa_m.imaa132_desc
   DISPLAY BY NAME g_imaa_m.imaa132_desc
   
   CALL s_desc_get_acc_desc('2007',g_imaa_m.imaa133) RETURNING g_imaa_m.imaa133_desc
   DISPLAY BY NAME g_imaa_m.imaa133_desc
   
   CALL s_desc_get_acc_desc('2008',g_imaa_m.imaa134) RETURNING g_imaa_m.imaa134_desc
   DISPLAY BY NAME g_imaa_m.imaa134_desc
   
   CALL s_desc_get_acc_desc('2009',g_imaa_m.imaa135) RETURNING g_imaa_m.imaa135_desc
   DISPLAY BY NAME g_imaa_m.imaa135_desc
   
   CALL s_desc_get_acc_desc('2010',g_imaa_m.imaa136) RETURNING g_imaa_m.imaa136_desc
   DISPLAY BY NAME g_imaa_m.imaa136_desc
   
   CALL s_desc_get_acc_desc('2011',g_imaa_m.imaa137) RETURNING g_imaa_m.imaa137_desc
   DISPLAY BY NAME g_imaa_m.imaa137_desc
   
   CALL s_desc_get_acc_desc('2012',g_imaa_m.imaa138) RETURNING g_imaa_m.imaa138_desc
   DISPLAY BY NAME g_imaa_m.imaa138_desc
   
   CALL s_desc_get_acc_desc('2013',g_imaa_m.imaa139) RETURNING g_imaa_m.imaa139_desc
   DISPLAY BY NAME g_imaa_m.imaa139_desc
   
   CALL s_desc_get_acc_desc('2014',g_imaa_m.imaa140) RETURNING g_imaa_m.imaa140_desc
   DISPLAY BY NAME g_imaa_m.imaa140_desc
   
   CALL s_desc_get_acc_desc('2015',g_imaa_m.imaa141) RETURNING g_imaa_m.imaa141_desc
   DISPLAY BY NAME g_imaa_m.imaa141_desc
   #141231-00010#1--add--end----

END FUNCTION
#將臨時表資料寫入實體表
PRIVATE FUNCTION aslm200_ins_detail()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   DELETE FROM imaj_t WHERE imajent = g_enterprise AND imaj001 = g_imaa_m.imaa001
   DELETE FROM imal_t WHERE imalent = g_enterprise AND imal001 = g_imaa_m.imaa001
   DELETE FROM imam_t WHERE imament = g_enterprise AND imam001 = g_imaa_m.imaa001
   DELETE FROM imao_t WHERE imaoent = g_enterprise AND imao001 = g_imaa_m.imaa001
   
   LET l_sql = "INSERT INTO imaj_t(imajent,imaj001,imaj002,imaj003,imaj004,imaj005,imaj006) ",
               "SELECT imajent,imaj001,imaj002,imaj003,imaj004,imaj005,imaj006 ",
               "  FROM imaj_tmp ",
               " WHERE imajent = '",g_enterprise,"' ",
               "   AND imaj001 = '",g_imaa_m.imaa001,"' "
   PREPARE detail_ins_imaj_pre FROM l_sql
   EXECUTE detail_ins_imaj_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imaa_m.imaa001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "INSERT INTO imal_t(imalent,imal001,imal002) ",
               "SELECT imalent,imal001,imal002 ",
               "  FROM imal_tmp ",
               " WHERE imalent = '",g_enterprise,"' ",
               "   AND imal001 = '",g_imaa_m.imaa001,"' "
   PREPARE detail_ins_imal_pre FROM l_sql
   EXECUTE detail_ins_imal_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imaa_m.imaa001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "INSERT INTO imam_t(imament,imam001,imam002,imam003,imam004,imam005,imam006) ",
               "SELECT imament,imam001,imam002,imam003,imam004,imam005,imam006 ",
               "  FROM imam_tmp ",
               " WHERE imament = '",g_enterprise,"' ",
               "   AND imam001 = '",g_imaa_m.imaa001,"' "
   PREPARE detail_ins_imam_pre FROM l_sql
   EXECUTE detail_ins_imam_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imaa_m.imaa001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   ------2015-2-3 zj mod------
   IF g_flag = 'N' THEN  
      DELETE FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001   
      IF NOT cl_null(g_imaa_m.imaa005) THEN
         LET l_sql = "INSERT INTO imak_t(imakent,imak001,imak002,imak003) ",
                     "SELECT imakent,imak001,imak002,imak003 ",
                     "  FROM imak_tmp ",
                     " WHERE imakent = '",g_enterprise,"' ",
                     "   AND imak001 = '",g_imaa_m.imaa001,"' "
         PREPARE detail_ins_imak_pre FROM l_sql
         EXECUTE detail_ins_imak_pre 
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_imaa_m.imaa001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF 
      END IF
   END IF      
   ------2015-2-3 zj mod------      


   LET l_sql = "INSERT INTO imao_t(imaoent,imao001,imao002) ",
               "SELECT imaoent,imao001,imao002 ",
               "  FROM imao_tmp ",
               " WHERE imaoent = '",g_enterprise,"' ",
               "   AND imao001 = '",g_imaa_m.imaa001,"' "
   PREPARE detail_ins_imao_pre FROM l_sql
   EXECUTE detail_ins_imao_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imaa_m.imaa001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   CALL aslm200_b_fill()

   RETURN r_success
END FUNCTION
#+ 創建臨時表
PRIVATE FUNCTION aslm200_crt_tmp()
#150309---earl---add---s
   DEFINE l_sql          STRING
   
   #建立temp table
   DROP TABLE aslm200_imaa_tmp
   
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE aslm200_imaa_tmp AS ",
               "SELECT * FROM imaa_t ",
               " WHERE imaaent = ",g_enterprise    #161228-00033#4 170123 by lori add:補ENT過濾條件
   PREPARE aslm200_aooi390_pre01 FROM l_sql
   EXECUTE aslm200_aooi390_pre01
   FREE aslm200_aooi390_pre01
#150309---earl---add---e
  
   CREATE TEMP TABLE imaj_tmp
   (
       imajent       INT,
       imaj001       VARCHAR(40),
       imaj002       VARCHAR(10),
       imaj003       VARCHAR(10),
       imaj004       INT,
       imaj005       VARCHAR(10),
       imaj006       VARCHAR(10)
   );
   
   CREATE TEMP TABLE imal_tmp
   (
       imalent       INT,
       imal001       VARCHAR(40),
       imal002       VARCHAR(10)
   );
   
    CREATE TEMP TABLE imam_tmp
   (
       imament       INT,
       imam001       VARCHAR(40),
       imam002       VARCHAR(10),
       imam003       VARCHAR(40),
       imam004       VARCHAR(255),
       imam005       VARCHAR(255),
       imam006       DATE
   );

    CREATE TEMP TABLE imak_tmp
   (
       imakent       INT,
       imak001       VARCHAR(40),
       imak002       VARCHAR(10),
       imak003       VARCHAR(30)
   );
   CREATE TEMP TABLE imao_tmp
   (
       imaoent       INT,
       imao001       VARCHAR(40),
       imao002       VARCHAR(10)
   );   
   
   #160805-00028#1 160812 by lori add---(S)
   DROP TABLE aslm200_tmp;
   CREATE TEMP TABLE aslm200_tmp(
      seq          SMALLINT,            #臨時表項次 
      spec_seq     INTEGER,         #特徵值項次
      spec         VARCHAR(10),         #一維:特徵值類型/二維:特徵值
      spec_desc    VARCHAR(500));      #一維:特徵值類型說明/二維:特徵值說明
   #160805-00028#1 160812 by lori add---(E)


END FUNCTION
#主分群碼帶單身
PRIVATE FUNCTION aslm200_imca_b_fill()
DEFINE l_sql      STRING


   DELETE FROM imaj_tmp WHERE imajent = g_enterprise AND imaj001 = g_imaa_m.imaa001
   DELETE FROM imal_tmp WHERE imalent = g_enterprise AND imal001 = g_imaa_m.imaa001
   DELETE FROM imam_tmp WHERE imament = g_enterprise AND imam001 = g_imaa_m.imaa001
   DELETE FROM imao_tmp WHERE imaoent = g_enterprise AND imao001 = g_imaa_m.imaa001
   
   LET l_sql = "INSERT INTO imaj_tmp(imajent,imaj001,imaj002,imaj003,imaj004,imaj005,imaj006) ",
               "SELECT '",g_enterprise,"','",g_imaa_m.imaa001,"',imcj002,imcj003,imcj004,imcj005,imcj006 ",
               "  FROM imcj_t ",
               " WHERE imcjent = '",g_enterprise,"' ",
               "   AND imcj001 = '",g_imaa_m.imaa003,"' "
   PREPARE imca_ins_imaj_pre FROM l_sql
   EXECUTE imca_ins_imaj_pre 
   
   LET l_sql = "INSERT INTO imal_tmp(imalent,imal001,imal002) ",
               "SELECT '",g_enterprise,"','",g_imaa_m.imaa001,"',imcl002 ",
               "  FROM imcl_t ",
               " WHERE imclent = '",g_enterprise,"' ",
               "   AND imcl001 = '",g_imaa_m.imaa003,"' "
   PREPARE imca_ins_imal_pre FROM l_sql
   EXECUTE imca_ins_imal_pre 
   
   LET l_sql = "INSERT INTO imam_tmp(imament,imam001,imam002,imam003,imam004,imam005,imam006) ",
               "SELECT '",g_enterprise,"','",g_imaa_m.imaa001,"',imcm002,imcm003,imcm004,imcm005,imcm006 ",
               "  FROM imcm_t ",
               " WHERE imcment = '",g_enterprise,"' ",
               "   AND imcm001 = '",g_imaa_m.imaa003,"' "
   PREPARE imca_ins_imam_pre FROM l_sql
   EXECUTE imca_ins_imam_pre 
 
   LET l_sql = "INSERT INTO imao_tmp(imaoent,imao001,imao002) ",
               "SELECT '",g_enterprise,"','",g_imaa_m.imaa001,"',imco002 ",
               "  FROM imco_t ",
               " WHERE imcoent = '",g_enterprise,"' ",
               "   AND imco001 = '",g_imaa_m.imaa003,"' "
   PREPARE imca_ins_imao_pre FROM l_sql
   EXECUTE imca_ins_imao_pre 
   
   IF g_flag = 'N' THEN
      DELETE FROM imak_tmp WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001
      LET l_sql = "INSERT INTO imak_tmp(imakent,imak001,imak002,imak003) ",
                  "SELECT '",g_enterprise,"','",g_imaa_m.imaa001,"',imcn002,imcn003 ",
                  "  FROM imcn_t ",
                  " WHERE imcnent = '",g_enterprise,"' ",
                  "   AND imcn001 = '",g_imaa_m.imaa003,"' "
      PREPARE imca_ins_imak_pre FROM l_sql
      EXECUTE imca_ins_imak_pre
   END IF   
   
   CALL aslm200_tmp_b_fill()
END FUNCTION
#臨時表資料顯示單身
PRIVATE FUNCTION aslm200_tmp_b_fill()
   CALL g_imaj_d.clear()  
   CALL g_imaj2_d.clear()
   CALL g_imaj3_d.clear()
   CALL g_imaj4_d.clear()

   LET g_sql = "SELECT UNIQUE imaj002,imaj003,imaj004,imaj005,'',imaj006,'' FROM imaj_tmp",    
               " WHERE imajent=? AND imaj001=?",
               " ORDER BY imaj002"

   PREPARE aslm200_tmp_pb FROM g_sql
   DECLARE b_fill_tmp_cs CURSOR FOR aslm200_tmp_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_tmp_cs USING g_enterprise,g_imaa_m.imaa001
                                            
   FOREACH b_fill_tmp_cs INTO g_imaj_d[l_ac].imaj002,g_imaj_d[l_ac].imaj003,g_imaj_d[l_ac].imaj004,g_imaj_d[l_ac].imaj005,g_imaj_d[l_ac].imaj005_desc,g_imaj_d[l_ac].imaj006,g_imaj_d[l_ac].imaj006_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaj_d[l_ac].imaj005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaj_d[l_ac].imaj005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_imaj_d[l_ac].imaj005_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaj_d[l_ac].imaj006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='272' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaj_d[l_ac].imaj006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_imaj_d[l_ac].imaj006_desc
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE imal002,'','' FROM imal_tmp",    
               " WHERE imalent=? AND imal001=?",
               " ORDER BY imal002"
   PREPARE aslm200_tmp_pb2 FROM g_sql
   DECLARE b_fill_tmp_cs2 CURSOR FOR aslm200_tmp_pb2
 
   LET l_ac = 1
   OPEN b_fill_tmp_cs2 USING g_enterprise,g_imaa_m.imaa001
   FOREACH b_fill_tmp_cs2 INTO g_imaj2_d[l_ac].imal002,g_imaj2_d[l_ac].imal002_desc,g_imaj2_d[l_ac].l_oocq005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='213' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaj2_d[l_ac].imal002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_imaj2_d[l_ac].imal002_desc
      
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_imaj2_d[l_ac].imal002
      CALL ap_ref_array2(g_ref_fields," SELECT oocq005 FROM oocq_t WHERE oocqent = '"||g_enterprise||"' AND oocq001 = '213' AND oocq002 = ? ","") RETURNING g_rtn_fields 
      LET g_imaj2_d[l_ac].l_oocq005 = g_rtn_fields[1]
      DISPLAY BY NAME g_imaj2_d[l_ac].l_oocq005  

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
   END FOREACH

   LET g_sql = "SELECT UNIQUE imam002,imam003,imam004,imam005,imam006 FROM imam_tmp",    
               " WHERE imament=? AND imam001=?",
               " ORDER BY imam002"
   PREPARE aslm200_tmp_pb3 FROM g_sql
   DECLARE b_fill_tmp_cs3 CURSOR FOR aslm200_tmp_pb3
 
   LET l_ac = 1
   OPEN b_fill_tmp_cs3 USING g_enterprise,g_imaa_m.imaa001
   FOREACH b_fill_tmp_cs3 INTO g_imaj3_d[l_ac].imam002,g_imaj3_d[l_ac].imam003,g_imaj3_d[l_ac].imam004,g_imaj3_d[l_ac].imam005,g_imaj3_d[l_ac].imam006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   LET g_sql = "SELECT UNIQUE imao002,'' FROM imao_tmp",    
               " WHERE imaoent=? AND imao001=?",
               " ORDER BY imao002"
 
   PREPARE aslm200_tmp_pb4 FROM g_sql
   DECLARE b_fill_tmp_cs4 CURSOR FOR aslm200_tmp_pb4
 
   LET l_ac = 1

   OPEN b_fill_tmp_cs4 USING g_enterprise,g_imaa_m.imaa001
                                            
   FOREACH b_fill_tmp_cs4 INTO g_imaj4_d[l_ac].imao002,g_imaj4_d[l_ac].imao002_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aslm200_imao002_desc()
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_imaj_d.deleteElement(g_imaj_d.getLength())
   CALL g_imaj2_d.deleteElement(g_imaj2_d.getLength())
   CALL g_imaj3_d.deleteElement(g_imaj3_d.getLength())
   CALL g_imaj4_d.deleteElement(g_imaj4_d.getLength())

   LET l_ac = g_cnt
   LET g_cnt = 0  
   FREE aslm200_tmp_pb
   FREE aslm200_tmp_pb2
   FREE aslm200_tmp_pb3
   FREE aslm200_tmp_pb4
END FUNCTION
################################################################################
# Descriptions...: 當特徵組別修改或新增時，新增料件特徵檔
# Memo...........:
# Usage..........: CALL aslm200_ins_imak()
#                  RETURNING r_success
# Date & Author..: 2013/12/28  By chenjing
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_ins_imak()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5
#161111-00028#10-----modify----begin-----------
#DEFINE l_imeb           RECORD LIKE imeb_t.*
#DEFINE l_imak           RECORD LIKE imak_t.*
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
DEFINE l_imak RECORD  #料件特徵檔
       imakent LIKE imak_t.imakent, #企業編號
       imak001 LIKE imak_t.imak001, #料件編號
       imak002 LIKE imak_t.imak002, #特徵類型
       imak003 LIKE imak_t.imak003  #特徵值
        END RECORD

#161111-00028#10-----modify----end-----------
DEFINE l_n              LIKE type_t.num5
DEFINE l_n1             LIKE type_t.num5

   LET r_success = TRUE
   #161111-00028#10-----modify----begin--------
   #LET l_sql = " SELECT * FROM imeb_t",
   LET l_sql = " SELECT imebent,imeb001,imeb002,imeb003,imeb004,imeb005,imeb006,imeb007,imeb008,",
               "imeb009,imeb010,imeb011,imeb012,imeb013 FROM imeb_t",
   #161111-00028#10-----modify----end----------
               "  WHERE imebent = '",g_enterprise,"'",
               "    AND imeb001 = ? ",
               "    AND imeb003 = '1' "
   PREPARE aslm200_sel_imeb_p FROM l_sql
   DECLARE aslm200_sel_imeb_c CURSOR FOR aslm200_sel_imeb_p   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n1
     FROM imak_t
    WHERE imakent = g_enterprise
      AND imak001 = g_imaa_m.imaa001   
   IF g_imaa_m_o.imaa005 = g_imaa_m.imaa005  THEN 
      IF l_n1 >0 THEN 
         RETURN r_success
      END IF 
   END IF 
   IF g_imaa_m_o.imaa005 <> g_imaa_m.imaa005 THEN  
      INITIALIZE l_imeb.* TO NULL
      FOREACH aslm200_sel_imeb_c USING g_imaa_m_o.imaa005 INTO l_imeb.* 
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel_imeb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
         INITIALIZE l_imak.* TO NULL
         LET l_imak.imakent = g_enterprise
         LET l_imak.imak001 = g_imaa_m.imaa001
         LET l_imak.imak002 = l_imeb.imeb004
         LET l_imak.imak003 = l_imeb.imeb009
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM imak_t
          WHERE imakent = l_imak.imakent
            AND imak001 = l_imak.imak001
            AND imak002 = l_imak.imak002
         IF l_n > 0 THEN 
            DELETE FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001
         END IF         
      END FOREACH
   END IF      
   FOREACH aslm200_sel_imeb_c USING g_imaa_m.imaa005 INTO l_imeb.* 
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel_imeb'
            LET g_errparam.popup = TRUE
            CALL cl_err()

         RETURN r_success
      END IF
      INITIALIZE l_imak.* TO NULL
      LET l_imak.imakent = g_enterprise
      LET l_imak.imak001 = g_imaa_m.imaa001
      LET l_imak.imak002 = l_imeb.imeb004
      LET l_imak.imak003 = l_imeb.imeb009
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imak_t
       WHERE imakent = l_imak.imakent
         AND imak001 = l_imak.imak001
         AND imak002 = l_imak.imak002
      IF l_n = 0 THEN
         #161111-00028#10-----modify----begin--------
         #INSERT INTO imak_t VALUES(l_imak.*)
         INSERT INTO imak_t (imakent,imak001,imak002,imak003)
           VALUES(l_imak.imakent,l_imak.imak001,l_imak.imak002,l_imak.imak003)
         #161111-00028#10-----modify----end--------
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins_imak'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      ELSE
         UPDATE imak_t SET imak001= l_imak.imak001,
                           imak003 = l_imak.imak003
          WHERE imakent = l_imak.imakent
            AND imak001 = l_imak.imak001
            AND imak002 = l_imak.imak002
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd_imak'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF
   END FOREACH
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aslm200_imao002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaj4_d[l_ac].imao002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaj4_d[l_ac].imao002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imaj4_d[l_ac].imao002_desc
END FUNCTION
#判斷當前料號的產品特徵是否可以維護，如果不可以維護，進入其他欄位
PRIVATE FUNCTION aslm200_imak003_enrty_chk()
DEFINE l_imak002   LIKE imak_t.imak002
DEFINE r_success   LIKE type_t.num5
DEFINE l_i         LIKE type_t.num5
DEFINE l_cn        LIKE type_t.num5
DEFINE l_imeb005   LIKE imeb_t.imeb005
DEFINE l_imaa005   LIKE imaa_t.imaa005

     LET r_success = TRUE
     
     DECLARE imak003_chk_cs CURSOR FOR
         SELECT imak002 FROM imak_t WHERE imakent = g_enterprise AND imak001 = g_imaa_m.imaa001
     
     SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_imaa_m.imaa001   
     LET l_cn = 0
     
     FOREACH imak003_chk_cs INTO l_imak002
        SELECT imeb005 INTO l_imeb005 FROM imeb_t
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
# Descriptions...: 自動編碼並預帶連動欄位值
# Memo...........:
# Usage..........: CALL aslm200_aooi390_default()
#                  RETURNING
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 150305 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_aooi390_default()
   DEFINE l_sql                STRING
   DEFINE l_str                STRING
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD

#   CALL s_aooi390_auto_no('1') RETURNING l_success,g_imaa_m.imaa001,l_oofg_return   #mark--2015/05/07 By shiun
   CALL s_aooi390_gen('1') RETURNING l_success,g_imaa_m.imaa001,l_oofg_return   #add--2015/05/07 By shiun
   DISPLAY BY NAME g_imaa_m.imaa001
   
   IF NOT l_success THEN
      RETURN
   END IF
   
#   CALL s_transaction_begin()   #因為s_aooi390_auto_no中有commit   #mark--2015/05/07 By shiun
   
   DELETE FROM aslm200_imaa_tmp

   INSERT INTO aslm200_imaa_tmp (imaaent,imaa001,imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010,
                                 imaastus,imaa126,imaa127,imaa131,imaa128,imaa129,imaa130,imaa132,imaa133,imaa134,
                                 imaa135,imaa136,imaa137,imaa138,imaa139,imaa140,imaa141,imaaownid,imaaowndp,imaacrtid,
                                 imaacrtdp,imaacrtdt,imaamodid,imaamoddt,imaacnfid,imaacnfdt,imaa011,imaa012,imaa013,
                                 imaa014,imaa142,imaa016,imaa017,imaa018,imaa019,imaa020,imaa021,imaa022,imaa023,imaa024,
                                 imaa025,imaa026,imaa027,imaa028,imaa029,imaa030,imaa031,imaa032,imaa033,imaa034,imaa035,
                                 imaa036,imaa037,imaa043,imaa038,imaa039,imaa040,imaa041,imaa042,imaa044,imaa122,imaa045,
                                 imaa123)
    VALUES (g_enterprise,g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009,g_imaa_m.imaa003, 
            g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
            g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129, 
            g_imaa_m.imaa130,g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135, 
            g_imaa_m.imaa136,g_imaa_m.imaa137,g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140, 
            g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp,g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp, 
            g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt,g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt, 
            g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014,g_imaa_m.imaa142, 
            g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa019,g_imaa_m.imaa020, 
            g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025, 
            g_imaa_m.imaa026,g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa030, 
            g_imaa_m.imaa031,g_imaa_m.imaa032,g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035, 
            g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043,g_imaa_m.imaa038,g_imaa_m.imaa039, 
            g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044,g_imaa_m.imaa122, 
            g_imaa_m.imaa045,g_imaa_m.imaa123)
       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "aslm200_imaa_tmp" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      RETURN
   END IF

   FOR l_i = 1 TO l_oofg_return.getLength()
      #無設定
      IF cl_null(l_oofg_return[l_i].oofg019) THEN
         CONTINUE FOR
      END IF
      
      #開頭為imba時，自動當成imaa
      LET l_str = l_oofg_return[l_i].oofg019
      CALL cl_str_replace_multistr(l_str,"imba","imaa") RETURNING l_str
      LET l_oofg_return[l_i].oofg019 = l_str

      LET l_sql = "UPDATE aslm200_imaa_tmp",
                  "   SET ",l_oofg_return[l_i].oofg019," = '",l_oofg_return[l_i].oofg020,"'"
      PREPARE aslm200_aooi390_pre02 FROM l_sql
      EXECUTE aslm200_aooi390_pre02
      FREE aslm200_aooi390_pre02

   END FOR
   
   LET l_sql = " SELECT UNIQUE t0.imaa001,t0.imaa002,t0.imaa009,t0.imaa003,t0.imaa004,t0.imaa005,t0.imaa006, 
                               t0.imaa010,t0.imaastus,t0.imaa126,t0.imaa127,t0.imaa131,t0.imaa128,t0.imaa129,t0.imaa130,t0.imaa132, 
                               t0.imaa133,t0.imaa134,t0.imaa135,t0.imaa136,t0.imaa137,t0.imaa138,t0.imaa139,t0.imaa140,t0.imaa141, 
                               t0.imaaownid,t0.imaaowndp,t0.imaacrtid,t0.imaacrtdp,t0.imaacrtdt,t0.imaamodid,t0.imaamoddt,t0.imaacnfid, 
                               t0.imaacnfdt,t0.imaa011,t0.imaa012,t0.imaa013,t0.imaa014,t0.imaa142,t0.imaa016,t0.imaa017,t0.imaa018, 
                               t0.imaa019,t0.imaa020,t0.imaa021,t0.imaa022,t0.imaa023,t0.imaa024,t0.imaa025,t0.imaa026,t0.imaa027, 
                               t0.imaa028,t0.imaa029,t0.imaa030,t0.imaa031,t0.imaa032,t0.imaa033,t0.imaa034,t0.imaa035,t0.imaa036, 
                               t0.imaa037,t0.imaa043,t0.imaa038,t0.imaa039,t0.imaa040,t0.imaa041,t0.imaa042,t0.imaa044,t0.imaa122, 
                               t0.imaa045,t0.imaa123,t1.rtaxl003 ,t2.oocql004 ,t3.imeal003 ,t4.oocal003 ,t5.oocql004 ,t6.ooag011 , 
                               t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooefl003 ,t13.oocal003 ,t14.oocal003 , 
                               t15.oocal003 ,t16.oocal003 ,t17.oocql004 ,t18.oocgl003",
               " FROM aslm200_imaa_tmp t0",
               " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent='"||g_enterprise||"' AND t1.rtaxl001=t0.imaa009 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='200' AND t2.oocql002=t0.imaa003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t3 ON t3.imealent='"||g_enterprise||"' AND t3.imeal001=t0.imaa005 AND t3.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=t0.imaa006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='210' AND t5.oocql002=t0.imaa010 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.imaaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.imaaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.imaacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.imaacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.imaamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.imaacnfid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent='"||g_enterprise||"' AND t12.ooefl001=t0.imaa142 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t13 ON t13.oocalent='"||g_enterprise||"' AND t13.oocal001=t0.imaa018 AND t13.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t14 ON t14.oocalent='"||g_enterprise||"' AND t14.oocal001=t0.imaa022 AND t14.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t15 ON t15.oocalent='"||g_enterprise||"' AND t15.oocal001=t0.imaa029 AND t15.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t16 ON t16.oocalent='"||g_enterprise||"' AND t16.oocal001=t0.imaa032 AND t16.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent='"||g_enterprise||"' AND t17.oocql001='2000' AND t17.oocql002=t0.imaa122 AND t17.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t18 ON t18.oocglent='"||g_enterprise||"' AND t18.oocgl001=t0.imaa045 AND t18.oocgl002='"||g_dlang||"' "
   PREPARE aslm200_aooi390_pre03 FROM l_sql
   
   EXECUTE aslm200_aooi390_pre03 INTO g_imaa_m.imaa001,g_imaa_m.imaa002,g_imaa_m.imaa009, 
       g_imaa_m.imaa003,g_imaa_m.imaa004,g_imaa_m.imaa005,g_imaa_m.imaa006,g_imaa_m.imaa010,g_imaa_m.imaastus, 
       g_imaa_m.imaa126,g_imaa_m.imaa127,g_imaa_m.imaa131,g_imaa_m.imaa128,g_imaa_m.imaa129,g_imaa_m.imaa130, 
       g_imaa_m.imaa132,g_imaa_m.imaa133,g_imaa_m.imaa134,g_imaa_m.imaa135,g_imaa_m.imaa136,g_imaa_m.imaa137, 
       g_imaa_m.imaa138,g_imaa_m.imaa139,g_imaa_m.imaa140,g_imaa_m.imaa141,g_imaa_m.imaaownid,g_imaa_m.imaaowndp, 
       g_imaa_m.imaacrtid,g_imaa_m.imaacrtdp,g_imaa_m.imaacrtdt,g_imaa_m.imaamodid,g_imaa_m.imaamoddt, 
       g_imaa_m.imaacnfid,g_imaa_m.imaacnfdt,g_imaa_m.imaa011,g_imaa_m.imaa012,g_imaa_m.imaa013,g_imaa_m.imaa014, 
       g_imaa_m.imaa142,g_imaa_m.imaa016,g_imaa_m.imaa017,g_imaa_m.imaa018,g_imaa_m.imaa019,g_imaa_m.imaa020, 
       g_imaa_m.imaa021,g_imaa_m.imaa022,g_imaa_m.imaa023,g_imaa_m.imaa024,g_imaa_m.imaa025,g_imaa_m.imaa026, 
       g_imaa_m.imaa027,g_imaa_m.imaa028,g_imaa_m.imaa029,g_imaa_m.imaa030,g_imaa_m.imaa031,g_imaa_m.imaa032, 
       g_imaa_m.imaa033,g_imaa_m.imaa034,g_imaa_m.imaa035,g_imaa_m.imaa036,g_imaa_m.imaa037,g_imaa_m.imaa043, 
       g_imaa_m.imaa038,g_imaa_m.imaa039,g_imaa_m.imaa040,g_imaa_m.imaa041,g_imaa_m.imaa042,g_imaa_m.imaa044, 
       g_imaa_m.imaa122,g_imaa_m.imaa045,g_imaa_m.imaa123,g_imaa_m.imaa009_desc,g_imaa_m.imaa003_desc, 
       g_imaa_m.imaa005_desc,g_imaa_m.imaa006_desc,g_imaa_m.imaa010_desc,g_imaa_m.imaaownid_desc,g_imaa_m.imaaowndp_desc, 
       g_imaa_m.imaacrtid_desc,g_imaa_m.imaacrtdp_desc,g_imaa_m.imaamodid_desc,g_imaa_m.imaacnfid_desc, 
       g_imaa_m.imaa142_desc,g_imaa_m.imaa018_desc,g_imaa_m.imaa022_desc,g_imaa_m.imaa029_desc,g_imaa_m.imaa032_desc, 
       g_imaa_m.imaa122_desc,g_imaa_m.imaa045_desc
       
   FREE aslm200_aooi390_pre03
   #modify--2015/05/06 By shiun--(S)
   DISPLAY BY NAME g_imaa_m.*
   #CALL aslm200_show()
   #modify--2015/05/06 By shiun--(E)
END FUNCTION

################################################################################
# Descriptions...: 基礎單位變更跑ainp100
# Memo...........:
# Usage..........: CALL aslm200_call_ainp100(p_imaa001)
#                  RETURNING r_success
# Input parameter: p_imaa001  料件編號
#                : 
# Return code....: r_success  執行結果
#                : 
# Date & Author..: 150312 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_call_ainp100(p_imaa001)
   DEFINE p_imaa001      LIKE imaa_t.imaa001
   DEFINE r_success      LIKE type_t.num5
   
   DEFINE l_sql          STRING
   DEFINE l_imafsite     LIKE imaf_t.imafsite
   DEFINE l_site         LIKE imaf_t.imafsite
   DEFINE l_date         LIKE type_t.dat
   DEFINE l_year         LIKE type_t.num5
   DEFINE l_month        LIKE type_t.num5
   
   DEFINE la_param       RECORD
             prog        STRING,
             param       DYNAMIC ARRAY OF STRING
                         END RECORD
   DEFINE ls_js          STRING
   
   LET r_success = TRUE
   
   LET l_sql = "SELECT imafsite",
               "  FROM imaf_t",
               " WHERE imafent = ",g_enterprise,
               "   AND imaf001 = '",p_imaa001,"'"
   PREPARE aslm200_imaf_pre FROM l_sql
   DECLARE aslm200_imaf_cs CURSOR FOR aslm200_imaf_pre
   
   LET l_site = g_site   #備份g_site   
   
   FOREACH aslm200_imaf_cs INTO l_imafsite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aslm200_imaf_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET g_site = l_imafsite
      
      #成本關帳日期
      LET l_date = ''
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6012') RETURNING l_date
      IF cl_null(l_date) THEN
         CONTINUE FOREACH
      END IF
      
      LET l_year = YEAR(l_date)
      LET l_month = MONTH(l_date)
      
      #呼叫ainp100
      INITIALIZE la_param.* TO NULL
      LET la_param.prog = 'ainp100'
      LET la_param.param[1] = "inag001 = '",p_imaa001,"'"
      LET la_param.param[2] = l_year
      LET la_param.param[3] = l_month
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)

   END FOREACH
   
   LET g_site = l_site   #還原g_site
      
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aslm200_chk_barcode(p_barcode)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160616 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_chk_barcode(p_barcode)
DEFINE p_barcode  LIKE imaa_t.imaa014
DEFINE l_cnt      LIKE type_t.num5
   
   LET g_errno = ''
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 != g_imaa_m.imaa001 
      AND imay003 = p_barcode
   #dongsz--add--str---
   IF l_cnt = 0 THEN
      SELECT COUNT(*) INTO l_cnt FROM imby_t
       WHERE imbyent = g_enterprise
         AND imby001 != g_imaa_m.imaa001
         AND imby003 = p_barcode
   END IF
   #dongsz--add--end---   
   IF l_cnt > 0 THEN
      LET g_errno = 'art-00032'
   END IF
END FUNCTION

################################################################################
# Descriptions...: #檢查包裝單位與計價單位之間的單位換算率 並帶出 換算率
# Memo...........:
# Usage..........: CALL aslm200_chk_imay004_1()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160616 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_chk_imay004_1()
DEFINE l_success     LIKE type_t.num5
DEFINE l_rate        LIKE inaj_t.inaj014 

   LET l_rate = ''

   LET l_success = TRUE
   IF g_imaj5_d[l_ac].imay004 = g_imaa_m.imaa006 THEN
      LET g_imaj5_d[l_ac].imay013 = 1
      #DISPLAY BY NAME g_imay_d[l_ac].imay013 #150504-00039#1 Mark By Ken 150506
      RETURN l_success
   END IF
   
   CALL s_aimi190_get_convert(g_imaa_m.imaa001,g_imaj5_d[l_ac].imay004,g_imaa_m.imaa006)
      RETURNING l_success,l_rate

   IF l_success THEN
      LET g_imaj5_d[l_ac].imay013 = l_rate
      #DISPLAY BY NAME g_imay_d[l_ac].imay013 #150504-00039#1 Mark By Ken 150506
   END IF
   
   RETURN l_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aslm200_chk_unit(p_unit)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160616 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_chk_unit(p_unit)
DEFINE p_unit     LIKE type_t.chr10
DEFINE l_stus     LIKE type_t.chr10

   LET g_errno = '' LET l_stus = ''

   SELECT oocastus INTO l_stus FROM ooca_t
    WHERE ooca001 = p_unit
      AND oocaent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00003'
#        WHEN l_stus='N'            LET g_errno = 'aim-00005'     #160318-00005#42 mark
        WHEN l_stus='N'            LET g_errno = 'sub-01302'      #160318-00005#42 add
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aslm200_imay004_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imay004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaj5_d[l_ac].imay004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaj5_d[l_ac].imay004_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 件装数检查
# Date & Author..: 2016/06/16 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imay005_chk()
DEFINE l_rtaj001      LIKE rtaj_t.rtaj001
DEFINE l_rtaj002      LIKE rtaj_t.rtaj002
DEFINE l_rtaj003      LIKE rtaj_t.rtaj003
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE l_str          LIKE type_t.chr2
DEFINE l_str1         LIKE type_t.chr2


   IF g_imaa_m.imaa109 = '1'  THEN
      IF g_imaj5_d[l_ac].imay005 = 1 THEN
         LET l_rtaj001 = '1'
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
  
   LET l_str1 = g_imaj5_d[l_ac].imay003[1,2]
   IF l_str <> l_str1  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00573'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
 
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有多條碼的包裝單位已相同
# Memo...........:
# Usage..........: CALL aslm200_imay005_chk_1()
#                  RETURNING r_success,l_imay005
# Input parameter: 
# Return code....: r_success       TRUE/FALSE
#                  l_imay005       件裝數
# Date & Author..: 2016/06/16 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imay005_chk_1()
DEFINE l_cnt        LIKE type_t.num5 
DEFINE l_imay005    LIKE imay_t.imay005
DEFINE r_success    LIKE type_t.num5

   LET l_imay005 = 0
   LET l_cnt = 0
   LET r_success = FALSE
   SELECT COUNT(*) INTO l_cnt 
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_imaa_m.imaa001
      AND imay004 = g_imaj5_d[l_ac].imay004      
      
   IF l_cnt != 0 THEN
      SELECT DISTINCT imay005 INTO l_imay005
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_imaa_m.imaa001
         AND imay004 = g_imaj5_d[l_ac].imay004       
      LET r_success = TRUE
   END IF
   
   RETURN r_success,l_imay005  
END FUNCTION

################################################################################
# Descriptions...: 檢查單身和單頭條碼類型是否一致
# Memo...........:
# Usage..........: CALL aslm200_imay006_chk()
# Date & Author..: 20160616 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imay006_chk()
DEFINE l_rtaj001      LIKE rtaj_t.rtaj001
DEFINE l_rtaj002      LIKE rtaj_t.rtaj002
DEFINE l_rtaj003      LIKE rtaj_t.rtaj003
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE l_str          LIKE type_t.chr2
DEFINE l_len          LIKE type_t.num5
DEFINE l_str1         LIKE type_t.chr2
DEFINE l_len1         LIKE type_t.num5

   IF g_imaa_m.imaa109 = '1'  THEN
      IF g_imaj5_d[l_ac].imay005 = 1 THEN
         LET l_rtaj001 = '1'
      ELSE
         LET l_rtaj001 = '2'
      END IF
   END IF
   IF g_imaa_m.imaa109 = '4' THEN
      LET l_rtaj001 = '4'
   END IF
   IF g_imaa_m.imaa109 = '5' THEN
      LET l_rtaj001 = '5'
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
   SELECT gzcbl004 INTO l_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = '6555'
      AND gzcbl002 = l_rtaj003
      AND gzcbl003 = g_dlang
   LET l_len = l_gzcbl004
   
   LET l_str1 = g_imaj5_d[l_ac].imay003[1,2]
   LET l_len1 = LENGTH(g_imaj5_d[l_ac].imay003)
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

################################################################################

################################################################################
PRIVATE FUNCTION aslm200_imaa022_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa022
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa022_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imaa_m.imaa022_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aslm200_imaa018_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa018
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_imaa_m.imaa018_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aslm200_refresh_main_imay()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160616 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_refresh_main_imay()
DEFINE l_cnt      LIKE type_t.num5
  
   IF cl_null(g_imaa_m.imaa014) THEN
      RETURN
   END IF
   LET g_errno = ''
   UPDATE imay_t SET imay006 = 'N'
    WHERE imay001 = g_imaa_m.imaa001
      AND imayent = g_enterprise
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imay_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imay_t
    WHERE imay001 = g_imaa_m.imaa001
      AND imay003 = g_imaa_m.imaa014
      AND imayent = g_enterprise
   IF l_cnt > 0 THEN
      UPDATE imay_t SET imay006 = 'Y',
                        imay002 = g_imaa_m.imaa100,
                        imay007 = g_imaa_m.imaa019,
                        imay008 = g_imaa_m.imaa020,
                        imay009 = g_imaa_m.imaa021,
                        imay015 = g_imaa_m.imaa022,
                        imay010 = g_imaa_m.imaa025,
                        imay016 = g_imaa_m.imaa026,
                        imay011 = g_imaa_m.imaa016,
                        imay017 = g_imaa_m.imaa018
       WHERE imay001 = g_imaa_m.imaa001
         AND imay003 = g_imaa_m.imaa014
         AND imayent = g_enterprise
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd imay_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF 
   ELSE
      INSERT INTO imay_t(imayent,imay001,imay002,
                         imay003,imay004,imay005,imay006,
                         imay007,imay008,imay009,imay015,
                         imay010,imay016,
                         imay011,imay017,imay018, #ken---add 加imay018 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
                         imaystus)
                  VALUES(g_enterprise,g_imaa_m.imaa001,
                         g_imaa_m.imaa100,g_imaa_m.imaa014,g_imaa_m.imaa006,1,'Y',
                         g_imaa_m.imaa019,g_imaa_m.imaa020,g_imaa_m.imaa021,g_imaa_m.imaa022,
                         g_imaa_m.imaa025,g_imaa_m.imaa026,
                         g_imaa_m.imaa016,g_imaa_m.imaa018,1, #ken---add 加imaa113 需求單號：141224-00014 項次：2 加傳秤因子更新單頭
                         'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins imay_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 欄位顯示
# Memo...........: #160801-00017#3 20160804 add by beckxie
# Usage..........: CALL aslm200_set_comp_visible_b()
# Date & Author..: 20160804 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION aslm200_set_comp_visible_b()
   CALL cl_set_comp_visible("imay019,imay019_desc",TRUE)   #160801-00017#3 20160804 add by beckxie
END FUNCTION

################################################################################
# Descriptions...: 欄位不顯示
# Memo...........: #160801-00017#3 20160804 add by beckxie
# Usage..........: CALL aslm200_set_comp_no_visible_b()
# Date & Author..: 20160804 add by beckxie
# Modify.........:   
################################################################################
PRIVATE FUNCTION aslm200_set_comp_no_visible_b()
   #160801-00017#3 20160804 add by beckxie---S
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("imay019,imay019_desc",FALSE)
   END IF
   #160801-00017#3 20160804 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位為必填
# Memo...........: #160801-00017#3 20160804 add by beckxie
# Usage..........: CALL aslm200_set_required_b(p_cmd)
# Date & Author..: 20160804 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_set_required_b(p_cmd)
   #160801-00017#3 20160804 add by beckxie---S
   DEFINE p_cmd   LIKE type_t.chr1
   IF l_ac > 0 THEN
      #IF (NOT cl_null(g_imaa_m.imaa005)) AND g_imaj5_d[l_ac].imay002 = '3' THEN   #160822-00036#1 20160824 mark by beckxie
      IF (NOT cl_null(g_imaa_m.imaa005)) AND g_imaj5_d[l_ac].imay002 = '3'  #160822-00036#1 20160824 add by beckxie
          AND cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN      #160822-00036#1 20160824 add by beckxie
         CALL cl_set_comp_required("imay019",TRUE)
      END IF
   END IF
   #160801-00017#3 20160804 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 設定欄位不為必填
# Memo...........: #160801-00017#3 20160804 add by beckxie
# Usage..........: CALL aslm200_set_no_required_b(p_cmd)
# Date & Author..: 20160804 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_set_no_required_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_required("imay019",FALSE)   #160801-00017#3 20160804 add by beckxie
END FUNCTION

################################################################################
# Descriptions...: 開啟產品特徵選擇子畫面
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_open_alsm200_s01
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/08/10 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_open_alsm200_s01()
   DEFINE l_cnt    LIKE type_t.num5
   
   IF cl_null(g_imaa_m.imaa001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00159"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      RETURN
   END IF
   
   IF cl_null(g_imaa_m.imaa005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "asl-00006"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      RETURN   
   END IF

   OPEN WINDOW w_aslm200_s01 WITH FORM cl_ap_formpath("asl","aslm200_s01")
   CALL cl_ui_init()   #畫面初始化
   CALL aslm200_s01_init()
   CALL aslm200_s01_b_fill()
   
  DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_imec_1 FROM s_detail1.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_2 FROM s_detail2.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_3 FROM s_detail3.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_4 FROM s_detail4.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_5 FROM s_detail5.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_6 FROM s_detail6.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_7 FROM s_detail7.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_8 FROM s_detail8.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_9 FROM s_detail9.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      INPUT ARRAY g_imec_10 FROM s_detail10.* ATTRIBUTES(INSERT ROW=FALSE, APPEND ROW=FALSE, DELETE ROW=FALSE)
         BEFORE INPUT
            CALL aslm200_s01_set_focus()
      END INPUT
      
      BEFORE DIALOG
         LET gdig_curr = ui.Dialog.getCurrent()
         
      ON ACTION select_all   #全選
         #勾選目前focus的Table內所有資料
         CALL aslm200_s01_set_value('Y')
         
      ON ACTION select_none   #全取消
         #取消勾選目前focus的Table內所有資料
         CALL aslm200_s01_set_value('N')
         
      ON ACTION accept   #確認
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt 
           FROM inag_t WHERE inagent = g_enterprise AND inag001 = g_imaa_m.imaa001
         IF l_cnt > 0 THEN 
            IF NOT cl_ask_confirm('asl-00009') THEN
               NEXT FIELD imec003_1 
            END IF
         END IF            
         
         IF NOT aslm200_s01_imas('1') THEN
            CALL DIALOG.setCurrentRow("s_detail",1)
            NEXT FIELD imec003_1 
         ELSE
            IF NOT aslm200_s01_imas('2') THEN
               NEXT FIELD imec003_1 
            END IF         
         END IF
         EXIT DIALOG 
      
      ON ACTION export_excel   #匯出excel
         CALL g_export_node.clear()
         IF g_imec_1.getLength() > 0 THEN
            LET g_export_node[1] = base.typeInfo.create(g_imec_1)
            LET g_export_id[1]   = "s_detail1"
         END IF
         
         IF g_imec_2.getLength() > 0 THEN
            LET g_export_node[2] = base.typeInfo.create(g_imec_2)
            LET g_export_id[2]   = "s_detail2"
         END IF 

         IF g_imec_3.getLength() > 0 THEN
            LET g_export_node[3] = base.typeInfo.create(g_imec_3)
            LET g_export_id[3]   = "s_detail3"
         END IF 

         IF g_imec_4.getLength() > 0 THEN
            LET g_export_node[4] = base.typeInfo.create(g_imec_4)
            LET g_export_id[4]   = "s_detail4"
         END IF 

         IF g_imec_5.getLength() > 0 THEN
            LET g_export_node[5] = base.typeInfo.create(g_imec_5)
            LET g_export_id[5]   = "s_detail5"
         END IF 
 
         IF g_imec_6.getLength() > 0 THEN
            LET g_export_node[6] = base.typeInfo.create(g_imec_6)
            LET g_export_id[6]   = "s_detail6"
         END IF 

         IF g_imec_7.getLength() > 0 THEN
            LET g_export_node[7] = base.typeInfo.create(g_imec_7)
            LET g_export_id[7]   = "s_detail7"
         END IF 

         IF g_imec_8.getLength() > 0 THEN
            LET g_export_node[8] = base.typeInfo.create(g_imec_8)
            LET g_export_id[8]   = "s_detail8"
         END IF 

         IF g_imec_9.getLength() > 0 THEN
            LET g_export_node[9] = base.typeInfo.create(g_imec_9)
            LET g_export_id[9]   = "s_detail9"
         END IF 

         IF g_imec_10.getLength() > 0 THEN
            LET g_export_node[10] = base.typeInfo.create(g_imec_10)
            LET g_export_id[10]   = "s_detail10"
         END IF 
         CALL cl_export_to_excel()         
         
      ON ACTION cancel   #取消
         EXIT DIALOG
         
      ON ACTION close   #關閉
         EXIT DIALOG   
         
      ON ACTION exit    #離開
         EXIT DIALOG  
  END DIALOG
   
   CLOSE WINDOW w_aslm200_s01
END FUNCTION

################################################################################
# Descriptions...: 依照imas_t資料動態組出顯示imas_t的SQL,或動態組出寫入條碼暫存檔的SQL
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_imas_show(p_type)
# Input parameter: p_type   1.組出顯示imas_t的SQL 2.組出寫入條碼暫存檔的SQL
# Return code....: 無
# Date & Author..: 2016/08/12 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imas_sql(p_type)
   DEFINE p_type        LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_sel_sql_1   STRING
   DEFINE l_sel_sql_2   STRING   #組條碼值
   DEFINE l_sel_sql_3   STRING   #組產品特徵值
   DEFINE l_sour_sql    STRING
   DEFINE l_from_sql    STRING
   DEFINE l_where_sql   STRING
   DEFINE l_order_sql   STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_comp_sn     STRING
   DEFINE l_title1      STRING
   DEFINE l_title2      STRING
   DEFINE l_barcode     LIKE imay_t.imay003
   DEFINE l_prod_spec   LIKE imay_t.imay019
   DEFINE l_date        DATETIME YEAR TO SECOND
   DEFINE l_imaa019     LIKE imaa_t.imaa019
   DEFINE l_imaa020     LIKE imaa_t.imaa020
   DEFINE l_imaa021     LIKE imaa_t.imaa021
   DEFINE l_imaa025     LIKE imaa_t.imaa025
   DEFINE l_imaa016     LIKE imaa_t.imaa016   
   DEFINE l_session_id  LIKE type_t.num20

   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id
   
   IF cl_null(g_imaa_m.imaa001) THEN
      RETURN
   END IF
   
   DELETE FROM aslm200_tmp;
   CALL g_tmp1.clear()
   CALL g_tmp2.clear()
   
   #取料件產品特徵選項
   #非二維(imeb012<>Y)預設9欄(seq1~9),二維(imeb012=Y)預設11欄(seq10~20)
   LET l_sql = "INSERT INTO aslm200_tmp(seq,spec_seq,spec,spec_desc) ",
               "SELECT ROW_NUMBER() OVER (ORDER BY imeb002 ) seq,imeb002 spec_seq,imas002 spec,oocql004 spec_desc ",
               "  FROM (SELECT UNIQUE imas002,imaaent,imaa005 ",
               "          FROM imas_t, imaa_t ",
               "         WHERE imasent = imaaent AND imas001 = imaa001 ",
               "           AND imasent = ",g_enterprise,
               "           AND imas001 = '",g_imaa_m.imaa001,"'), ",
               "       imeb_t LEFT JOIN oocql_t ON oocqlent = imebent AND oocql001 = '273' AND oocql002 = imeb004 AND oocql003 = '",g_dlang,"' ",
               " WHERE imaaent = imebent AND imaa005 = imeb001 AND imas002 = imeb004 ",
               "   AND imeb005 <> '3' AND imeb012 <> 'Y' ",
               "UNION ALL ",
               "SELECT ROW_NUMBER() OVER (ORDER BY imas003 ) +9 seq,imeb002 spec_seq,imas003 spec,imecl005 spec_desc ",
               "  FROM (SELECT UNIQUE imas002,imas003,imaaent,imaa005 ",
               "          FROM imas_t,imaa_t ",
               "         WHERE imasent = imaaent AND imas001 = imaa001 ",
               "           AND imasent = ",g_enterprise,
               "           AND imas001 = '",g_imaa_m.imaa001,"') , ",
               "       (SELECT imecent,imec001,imec002,imec003,imebent,imeb001,imeb002,imeb004 ",
               "          FROM imec_t,imeb_t ",
               "          WHERE imecent = imebent AND imec001 = imeb001 AND imec002 = imeb002 ",
               "            AND imeb005 <> '3' AND imeb012 = 'Y') ",
               "        LEFT JOIN imecl_t ON imeclent= imecent AND imecl001 = imec001 AND imecl002 = imec002 AND imecl003=imec003 AND imecl004 = '",g_dlang,"' ",
               " WHERE imaaent = imebent AND imaa005 = imeb001 AND imas002 = imeb004 AND imas003 = imec003 "
   PREPARE aslm200_ins_tmp FROM l_sql
   EXECUTE aslm200_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Insert aslm200_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()   

      DISPLAY "aslm200_ins_tmp SQL:",l_sql
      RETURN   
   END IF   
   
   #畫面欄位顯隱-非二維
   LET l_sql = "SELECT seq,spec,spec_desc FROM aslm200_tmp WHERE seq < 10 ORDER BY seq"
   PREPARE aslm200_sel_tmp_pre1 FROM l_sql
   DECLARE aslm200_sel_tmp_cur1 CURSOR FOR aslm200_sel_tmp_pre1
   
   LET l_i = 1   
   FOREACH aslm200_sel_tmp_cur1 INTO g_tmp1[l_i].seq, g_tmp1[l_i].spec, g_tmp1[l_i].spec_desc
      LET l_i = l_i + 1     
   END FOREACH   
   CALL g_tmp1.deleteElement(l_i) 

   #畫面欄位顯隱-二維
   LET l_sql = "SELECT seq,spec,spec_desc FROM aslm200_tmp WHERE seq >= 10 ORDER BY seq"
   PREPARE aslm200_sel_tmp_pre2 FROM l_sql
   DECLARE aslm200_sel_tmp_cur2 CURSOR FOR aslm200_sel_tmp_pre2
   
   LET l_i = 1   
   FOREACH aslm200_sel_tmp_cur2 INTO g_tmp2[l_i].seq, g_tmp2[l_i].spec, g_tmp2[l_i].spec_desc
      LET l_i = l_i + 1     
   END FOREACH   
   CALL g_tmp2.deleteElement(l_i) 

   #畫面欄位顯隱-非二維
   FOR l_i = 1 TO 9
      LET l_comp_sn = l_i
      LET l_comp_sn = l_comp_sn.trim()
      LET l_title1 = "imas003_"||l_comp_sn            #特徵值欄位,須設定title及顯隱
      LET l_title2 = "imas003_"||l_comp_sn||"_desc"   #說明欄位,只做顯隱
      IF l_comp_sn = g_tmp1[l_i].seq AND g_tmp1[l_i].spec IS NOT NULL THEN           
         IF p_type = 1 THEN
            #設定title
            CALL cl_set_comp_att_text(l_title1, g_tmp1[l_i].spec_desc)
            CALL cl_set_comp_visible(l_title1,TRUE)
            CALL cl_set_comp_visible(l_title2,TRUE)
         END IF
         
         IF l_comp_sn = 1 THEN
            LET l_sel_sql_1 = "t"||l_comp_sn||".imas003,"||"s"||l_comp_sn||".imecl005 "
            LET l_sel_sql_2 = "t"||l_comp_sn||".imas003"
            LET l_sel_sql_3 = "t"||l_comp_sn||".imas003"
            
            LET l_from_sql = "(SELECT  imasent,imas001,imas002,imas003,spec_seq "||
                             "   FROM imas_t,aslm200_tmp "||
                             "  WHERE imas002 = spec AND seq = "||l_comp_sn||" ) "||"t"||l_comp_sn|| 
                             " LEFT JOIN imecl_t s"||l_comp_sn||" ON imeclent = imasent AND imecl001 = '"||g_imaa_m.imaa005||"' "||
                             "                                   AND imecl002 = spec_seq AND imecl003 = imas003 AND imecl004 = '"||g_dlang||"' "
                             
   
            LET l_where_sql = " WHERE t1.imasent = "||g_enterprise||" AND t1.imas001 = '"||g_imaa_m.imaa001||"' "
            
            LET l_order_sql = " ORDER BY t"||l_comp_sn||".imas003"
         ELSE
            LET l_sel_sql_1 = l_sel_sql_1||","||"t"||l_comp_sn||".imas003,"||"s"||l_comp_sn||".imecl005 "
            LET l_sel_sql_2 = l_sel_sql_2||"||"||"t"||l_comp_sn||".imas003"
            LET l_sel_sql_3 = l_sel_sql_3||"||'_'||"||"t"||l_comp_sn||".imas003"
            
            LET l_from_sql = l_from_sql||","||
                             "(SELECT  imasent,imas001,imas002,imas003,spec_seq "||
                             "   FROM imas_t,aslm200_tmp "||
                             "  WHERE imas002 = spec AND seq = "||l_comp_sn||" ) "||"t"||l_comp_sn|| 
                             " LEFT JOIN imecl_t s"||l_comp_sn||" ON imeclent = imasent AND imecl001 = '"||g_imaa_m.imaa005||"' "||
                             "                                   AND imecl002 = spec_seq AND imecl003 = imas003 AND imecl004 = '"||g_dlang||"' "
   
            LET l_where_sql = l_where_sql,
                              " AND t1.imasent = "||"t"||l_comp_sn||".imasent AND t1.imas001 = "||"t"||l_comp_sn||".imas001 "
                              
            LET l_order_sql = l_order_sql||", t"||l_comp_sn||".imas003"                
         END IF         
      ELSE
         IF p_type = 1 THEN
            #欄位隱藏
            CALL cl_set_comp_visible(l_title1,FALSE)
            CALL cl_set_comp_visible(l_title2,FALSE)
            
            IF cl_null(l_sel_sql_1) THEN
               LET l_sel_sql_1 = " '','' "
            ELSE            
               LET l_sel_sql_1 = l_sel_sql_1,", '','' "
            END IF  
         END IF
      END IF 
   END FOR 
   
   IF p_type = 1 THEN
      #畫面欄位顯隱-二維  
      FOR l_i = 1 TO 11
         LET l_comp_sn = l_i+9
         LET l_comp_sn = l_comp_sn.trim()      
         LET l_title1 = "imas003_"||l_comp_sn            #特徵值欄位,須設定title及顯隱
         IF l_comp_sn = g_tmp2[l_i].seq AND g_tmp2[l_i].spec IS NOT NULL THEN   
            #設定title            
            CALL cl_set_comp_att_text(l_title1, g_tmp2[l_i].spec_desc)
            CALL cl_set_comp_visible(l_title1,TRUE)
            IF cl_null(l_sel_sql_1) THEN
               LET l_sel_sql_1 = " 'Y' "
            ELSE            
               LET l_sel_sql_1 = l_sel_sql_1,", 'Y' "
            END IF 
         ELSE
           #欄位隱藏
            CALL cl_set_comp_visible(l_title1,FALSE)
            
            IF cl_null(l_sel_sql_1) THEN
               LET l_sel_sql_1 = " '' "
            ELSE            
               LET l_sel_sql_1 = l_sel_sql_1,", '' "
            END IF
         END IF   
      END FOR 
      
      #組出顯示imas_t的SQL   
      LET l_sql = "SELECT ",l_sel_sql_1," FROM ",l_from_sql," ",l_where_sql," ",l_order_sql
      
      PREPARE aslm200_imas_fill_pre FROM l_sql
      DECLARE aslm200_imas_fill_cur CURSOR FOR aslm200_imas_fill_pre      
      IF SQLCA.sqlcode THEN
         LET l_sql = cl_replace_str(l_sql,'aslm200_tmp','TT'||l_session_id||'_aslm200_tmp')
         DISPLAY "aslm200_imas_fill_cur SQL: ",l_sql   
      END IF      
   ELSE
      LET l_imaa019 = g_imaa_m.imaa019
      LET l_imaa020 = g_imaa_m.imaa020
      LET l_imaa021 = g_imaa_m.imaa021
      LET l_imaa025 = g_imaa_m.imaa025
      LET l_imaa016 = g_imaa_m.imaa016
      
      IF cl_null(l_imaa019) THEN   LET l_imaa019 = 0    END IF 
      IF cl_null(l_imaa020) THEN   LET l_imaa020 = 0    END IF 
      IF cl_null(l_imaa021) THEN   LET l_imaa021 = 0    END IF 
      IF cl_null(l_imaa025) THEN   LET l_imaa025 = 0    END IF 
      IF cl_null(l_imaa016) THEN   LET l_imaa016 = 0    END IF 
      
      #組入二維的部分, 將資料展開
      LET l_sel_sql_2 = "'"||g_imaa_m.imaa001||"'||"||l_sel_sql_2||"||spec"   #需組入料號
      LET l_sel_sql_3 = l_sel_sql_3||"||'_'||spec"
      IF cl_null(l_from_sql) THEN
         LET l_from_sql = " FROM aslm200_tmp "
      ELSE
         LET l_from_sql = " FROM "||l_from_sql || " , aslm200_tmp"      
      END IF
      
      IF cl_null(l_where_sql) THEN 
         LET l_where_sql = " WHERE seq >= 10 "
      ELSE
         LET l_where_sql = l_where_sql ||" AND seq >= 10 " 
      END IF
      
      #組出寫入條碼暫存檔的SQL
      LET l_sour_sql = "SELECT (",l_sel_sql_2,") barcode, (",l_sel_sql_3,") prod_spec ",l_from_sql,l_where_sql
     #LET l_sour_sql = cl_replace_str(l_sour_sql,'aslm200_tmp','TT'||l_session_id||'_aslm200_tmp')
     #DISPLAY "Source SQL: ",l_sour_sql
      
      LET l_sql = "DELETE FROM imay_t ",
                  " WHERE imayent = ",g_enterprise," AND imay001 = '",g_imaa_m.imaa001,"' AND imay002 = '3' ",
                  "   AND imay003 NOT IN (SELECT barcode FROM (",l_sour_sql,")) "  
      PREPARE aslm200_del_imay FROM l_sql
     #LET l_sql = cl_replace_str(l_sql,'aslm200_tmp','TT'||l_session_id||'_aslm200_tmp')
     #DISPLAY "aslm200_del_imay SQL: ",l_sql 
     
      LET l_date = cl_get_current() 
      LET l_sql = "MERGE INTO imay_t ",
                  "USING (SELECT barcode,prod_spec FROM (",l_sour_sql,")) t2 ",  
                  "   ON (imayent = ",g_enterprise," AND imay001 = '",g_imaa_m.imaa001,"' ",
                  "    AND imay002 = '3' AND imay003 = barcode) ",
                  " WHEN NOT MATCHED THEN ",
                  "   INSERT VALUES (",g_enterprise,", ",
                  "                 '",g_imaa_m.imaa001,"', ",
                  "                   '3', ",                       #條碼分類
                  "                    barcode, ",                  #條碼分類
                  "                 '",g_imaa_m.imaa006,"', ",      #包裝單位
                  "                   1,",                          #件裝數
                  "                   'N', ",                       #主條碼否
                  "                  ",l_imaa019,", ",              #陳列規格(深)
                  "                  ",l_imaa020,", ",              #陳列規格(寬)
                  "                  ",l_imaa021,", ",              #陳列規格(高)
                  "                  ",l_imaa025,", ",              #體積
                  "                  ",l_imaa016,", ",              #重量
                  "                 '",g_imaa_m.imaa006,"', ",      #計價單位
                  "                   1, ",                         #計價單位換算率
                  "                 '",g_imaa_m.imaa006,"', ",      #庫存單位
                  "                 '",g_imaa_m.imaa022,"', ",      #長度單位
                  "                 '",g_imaa_m.imaa026,"', ",      #體積單位
                  "                 '",g_imaa_m.imaa018,"', ",      #重量單位
                  "                 '",g_user,"', ",                #資料所有者
                  "                 '",g_dept,"', ",                #資料所屬部門
                  "                 '",g_user,"', ",                #資料建立者
                  "                 '",g_dept,"', ",                #資料建立部門
                  "         TO_DATE('",l_date,"','YYYY/MM/DD HH24:MI:SS'), ",    #資料創建日   
                  "                   '', ",                        #資料修改者
                  "                   '', ",                        #最近修改日
                  "                   'Y', ",                       #狀態碼
                  "                    '','','','','', '','','','','', ",
                  "                    '','','','','', '','','','','', ",
                  "                    '','','','','', '','','','','', ",
                  "                  (CASE WHEN '",g_imaa_m.imaa108,"'='3' THEN 1000 ELSE 1 END),",     #傳秤因子
                  "                   prod_spec) "                  #產品特徵
      PREPARE aslm200_merge_imay FROM l_sql
     #LET l_sql = cl_replace_str(l_sql,'aslm200_tmp','TT'||l_session_id||'_aslm200_tmp')
     #DISPLAY "aslm200_merge_imay SQL: ",l_sql  
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 產品特徵(庫存)頁簽資料顯示
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, Record須調整
# Usage..........: CALL aslm200_imas_show()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/08/12 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imas_show()
   DEFINE l_i           LIKE type_t.num5
   
   CALL aslm200_imas_sql(1)
   CALL g_imas_d.clear()
   
   LET l_i = 1
   FOREACH aslm200_imas_fill_cur INTO g_imas_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach:aslm200_imas_fill_cur"
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         
         RETURN
      END IF
      
      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_i
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF      
   END FOREACH
   CALL g_imas_d.deleteElement(l_i)   
   
END FUNCTION

################################################################################
# Descriptions...: 子畫面：初始化
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_aslm200_s01_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/8/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_init()
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_title       STRING
   DEFINE l_comp_sn     STRING
   DEFINE l_sql         STRING
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   CALL g_imeb.clear() 
   
   #將缺少的Style: aimi092_focustable, 動態加入原匯入的StyleList中
   CALL aslm200_s01_add_style()

   #取得特徵值內容
   LET l_sql = "SELECT imeb002, imeb004, t1.oocql004 ",
               "  FROM imeb_t ",
               "       LEFT JOIN oocql_t t1 ON t1.oocqlent = imebent AND t1.oocql001 = '273' ",
               "                           AND t1.oocql002=imeb004   AND t1.oocql003 = '",g_dlang,"' ",
               " WHERE imebent = ",g_enterprise,
               "   AND imeb001 = '",g_imaa_m.imaa005,"' ",
               "   AND imeb005 <> '3' ",   #賦值方式先不處理3.限制範圍
               " ORDER BY imeb002 "
   PREPARE aslm200_sel_imeb_pre FROM l_sql
   DECLARE aslm200_sel_imeb_cur CURSOR FOR aslm200_sel_imeb_pre
   
   LET l_i = 1
   FOREACH aslm200_sel_imeb_cur INTO g_imeb[l_i].imeb002, g_imeb[l_i].imeb004, g_imeb[l_i].oocql004
      LET l_i = l_i + 1     
   END FOREACH
   CALL g_imeb.deleteElement(l_i)
   
   #子畫面元件預設10個table
   FOR l_i = 1 TO 10
      LET l_comp_sn = l_i
      LET l_comp_sn = l_comp_sn.trim()
      
      IF g_imeb[l_i].imeb004 IS NOT NULL THEN           
         #設定title
         LET l_title = "formonly.imec003_"||l_comp_sn
         CALL gfrm_curr.setElementText(l_title, g_imeb[l_i].oocql004)
      ELSE
         #表格隱藏
         CALL gfrm_curr.setElementHidden("s_detail"||l_comp_sn, TRUE)
      END IF 
   END FOR   
END FUNCTION

################################################################################
# Descriptions...: 子畫面:欄位屬性處理
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_s01_add_style()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/08/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_add_style()
   DEFINE lnode_root   om.DomNode
   DEFINE lnode_item   om.DomNode
   DEFINE lnode_child  om.DomNode
   DEFINE lnode_att    om.DomNode
   DEFINE llst_styles  om.NodeList
   DEFINE l_i          LIKE type_t.num5

   LET lnode_root = ui.Interface.getRootNode()
   LET llst_styles = lnode_root.selectByTagName("StyleList")
   FOR l_i = 1 TO llst_styles.getLength()
       LET lnode_item = llst_styles.item(l_i)
       LET lnode_child = lnode_item.createChild("Style")
       CALL lnode_child.setAttribute("name", ".aimi092_focustable")
       
       LET lnode_att = lnode_child.createChild("StyleAttribute")
       CALL lnode_att.setAttribute("name", "backgroundColor")
       CALL lnode_att.setAttribute("value", "#CDDAE8")   #色碼可以自選
       
       EXIT FOR
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 子畫面:特徵值資料填充
# Memo...........:
# Usage..........: CALL aslm200_s01_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/8/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_b_fill()
   DEFINE l_i    LIKE type_t.num5
   DEFINE l_j    LIKE type_t.num5
   DEFINE l_sql  STRING
   
   CALL g_imec_1.clear()
   CALL g_imec_2.clear()
   CALL g_imec_3.clear()
   CALL g_imec_4.clear()
   CALL g_imec_5.clear()
   CALL g_imec_6.clear()
   CALL g_imec_7.clear()
   CALL g_imec_8.clear()
   CALL g_imec_9.clear()
   CALL g_imec_10.clear()
   

   #定義共用抓取類型下的特徵項目SQL
   LET l_sql = "SELECT COALESCE((SELECT UNIQUE 'Y' FROM imas_t ",
               "                  WHERE imasent = imecent AND imas001 = '",g_imaa_m.imaa001,"' ",
               "                    AND imas002 = imeb004 AND imas003 = imec003), ",
               "                'N'), ",
               "       imec003, imecl005 ",
               "  FROM imec_t",
               "       LEFT JOIN imecl_t ON imecent = imeclent AND imec001 = imecl001 AND imec002 = imecl002 ",
               "                        AND imec003 = imecl003 AND imecl004 = '",g_dlang,"', ",
               "       imeb_t",
               " WHERE imecent = imebent AND imec001 = imeb001 AND imec002 = imeb002 ",
               "   AND imecent = ",g_enterprise,
               "   AND imec001 = '",g_imaa_m.imaa005,"' ",
               "   AND imec002 = ? ",
               " ORDER BY imec003 "
   PREPARE aslm200_sel_imec_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE:aslm200_sel_imec_pre"
      LET g_errparam.popup = TRUE
      CALL cl_err()   

      DISPLAY "aslm200_sel_imec_pre SQL:",l_sql
      RETURN   
   END IF   
   DECLARE aslm200_sel_imec_cur CURSOR FOR aslm200_sel_imec_pre
   
   FOR l_i = 1 TO g_imeb.getLength()
       #傳入不同的類型取得特徵, 依照l_i放入不同的array呈現
       LET l_j = 1
       CASE l_i                                                              
          WHEN 1                                                             
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002          
                                           INTO g_imec_1[l_j].l_sel_1,g_imec_1[l_j].imec003_1,g_imec_1[l_j].imec003_1_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_1.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 2                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_2[l_j].l_sel_2,g_imec_2[l_j].imec003_2,g_imec_2[l_j].imec003_2_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_2.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 3                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_3[l_j].l_sel_3,g_imec_3[l_j].imec003_3,g_imec_3[l_j].imec003_3_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_3.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 4                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_4[l_j].l_sel_4,g_imec_4[l_j].imec003_4,g_imec_4[l_j].imec003_4_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_4.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 5                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_5[l_j].l_sel_5,g_imec_5[l_j].imec003_5,g_imec_5[l_j].imec003_5_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_5.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 6                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_6[l_j].l_sel_6,g_imec_6[l_j].imec003_6,g_imec_6[l_j].imec003_6_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_6.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 7                                                                                   
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_7[l_j].l_sel_7,g_imec_7[l_j].imec003_7,g_imec_7[l_j].imec003_7_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_7.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 8
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_8[l_j].l_sel_8,g_imec_8[l_j].imec003_8,g_imec_8[l_j].imec003_8_desc
                LET l_j = l_j + 1                                                                  
             END FOREACH                                                                           
             CALL g_imec_8.deleteElement(l_j)                                                     
                                                                                                   
          WHEN 9                                                                                  
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002                                
                                           INTO g_imec_9[l_j].l_sel_9,g_imec_9[l_j].imec003_9,g_imec_9[l_j].imec003_9_desc
                LET l_j = l_j + 1              
             END FOREACH
             CALL g_imec_9.deleteElement(l_j)

          WHEN 10
             FOREACH aslm200_sel_imec_cur USING g_imeb[l_i].imeb002 
                                           INTO g_imec_10[l_j].l_sel_10,g_imec_10[l_j].imec003_10,g_imec_10[l_j].imec003_10_desc
                LET l_j = l_j + 1                                            
             END FOREACH                                                     
             CALL g_imec_10.deleteElement(l_j)    
       END CASE
   END FOR
      
END FUNCTION

################################################################################
# Descriptions...: 子畫面：游標所在的Table變更顏色
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_s01_set_focus()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/08/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_set_focus()
   DEFINE l_focus     STRING
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_comp      STRING
   DEFINE l_comp_sn   STRING
   DEFINE l_col1      STRING
   DEFINE l_col2      STRING
   DEFINE l_col3      STRING
   
   LET l_focus = gdig_curr.getCurrentItem()
   IF l_focus.getIndexOf(".", 1) THEN
      LET l_focus = l_focus.subString(1, l_focus.getIndexOf(".", 1) -1)
   END IF
   
   FOR l_i = 1 TO 10
       LET l_comp_sn = l_i
       LET l_comp_sn = l_comp_sn.trim()
       LET l_col2 = "imec003_",l_comp_sn,"_desc"
       LET l_col3 = "l_sel"||l_comp_sn
       IF l_comp = l_focus THEN
          CALL gfrm_curr.setFieldStyle(l_col1, "aimi092_focustable")
          CALL gfrm_curr.setFieldStyle(l_col2, "aimi092_focustable")
          CALL gfrm_curr.setFieldStyle(l_col3, "aimi092_focustable")
       ELSE 
          CALL gfrm_curr.setFieldStyle(l_col1, "")       
          CALL gfrm_curr.setFieldStyle(l_col2, "")
          CALL gfrm_curr.setFieldStyle(l_col3, "")
       END IF
   END FOR   
END FUNCTION

################################################################################
# Descriptions...: 子畫面：全選或全取消處理
# Memo...........: 此處處理與畫面元件數相關, 如畫面有調整, SQL與迴圈均須調整
# Usage..........: CALL aslm200_s01_set_value(p_sel)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/08/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_set_value(p_sel)
   DEFINE p_sel      LIKE type_t.chr10
   DEFINE l_focus    STRING
   DEFINE l_i        LIKE type_t.num5

   LET l_focus = gdig_curr.getCurrentItem()
   IF l_focus.getIndexOf(".", 1) THEN
      LET l_focus = l_focus.subString(1, l_focus.getIndexOf(".", 1) -1)
   END IF
   CASE l_focus
      WHEN "s_detail1"
         FOR l_i = 1 TO g_imec_1.getLength()
             LET g_imec_1[l_i].l_sel_1 = p_sel
         END FOR
         
      WHEN "s_detail2"
         FOR l_i = 1 TO g_imec_2.getLength()
             LET g_imec_2[l_i].l_sel_2 = p_sel
         END FOR
         
      WHEN "s_detail3"
         FOR l_i = 1 TO g_imec_3.getLength()
             LET g_imec_3[l_i].l_sel_3 = p_sel
         END FOR
         
      WHEN "s_detail4"
         FOR l_i = 1 TO g_imec_4.getLength()
             LET g_imec_4[l_i].l_sel_4 = p_sel
         END FOR
         
      WHEN "s_detail5"
         FOR l_i = 1 TO g_imec_5.getLength()
             LET g_imec_5[l_i].l_sel_5 = p_sel
         END FOR
         
      WHEN "s_detail6"
         FOR l_i = 1 TO g_imec_6.getLength()
             LET g_imec_6[l_i].l_sel_6 = p_sel
         END FOR
         
      WHEN "s_detail7"
         FOR l_i = 1 TO g_imec_7.getLength()
             LET g_imec_7[l_i].l_sel_7 = p_sel
         END FOR
         
      WHEN "s_detail8"
         FOR l_i = 1 TO g_imec_8.getLength()
             LET g_imec_8[l_i].l_sel_8 = p_sel
         END FOR
         
      WHEN "s_detail9"
         FOR l_i = 1 TO g_imec_9.getLength()
             LET g_imec_9[l_i].l_sel_9 = p_sel
         END FOR
         
      WHEN "s_detail10"
         FOR l_i = 1 TO g_imec_10.getLength()
             LET g_imec_10[l_i].l_sel_10 = p_sel
         END FOR
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 子畫面:資料存檔處理
# Memo...........:
# Usage..........: CALL aslm200_s01_imas(p_state)
#                  RETURNING r_success
# Input parameter: p_state      處理方式:1.檢查是否每個類型都有勾選 2.存檔
# Return code....: r_success    處理結果(TRUEFALSE)
# Date & Author..: 2016/08/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_s01_imas(p_state)
   DEFINE p_state      LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_txn_flag   LIKE type_t.num5
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_j          LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_err_cnt    LIKE type_t.num5   #失敗筆數
   DEFINE l_msg        STRING
   DEFINE l_imay003    LIKE imay_t.imay003
   
   LET r_success = TRUE
   LET l_txn_flag = ''
   LET l_msg = ""
   LET l_err_cnt = 0
   LET g_imaa014_flag = FALSE
      
   IF p_state = 2 THEN
     CALL s_transaction_begin()
   END IF

   LET l_sql = "MERGE INTO imas_t ",
               "USING (SELECT imecent,imec001,imec002,imec003 FROM imec_t ",
               "        WHERE imecent = ",g_enterprise," AND imec001 = '",g_imaa_m.imaa005,"' ",
               "          AND imec002 = ? AND imec003 = ? ) t2 ",  #特徵項次,特徵值
               "   ON (imasent = imecent AND imas001 = '",g_imaa_m.imaa001,"' ",
               "  AND  imas002 = ?       AND imas003 = ? )",   #特徵類型,特徵值
               " WHEN NOT MATCHED THEN ",
               "   INSERT VALUES (",g_enterprise,", ",
               "                 '",g_imaa_m.imaa001,"', ",
               "                    ? ,?,'', ",   #特徵類型,特徵值(起),特徵值(迄)
               "                    '','','','','', '','','','','', ",
               "                    '','','','','', '','','','','', ",
               "                    '','','','','', '','','','','') "
   PREPARE aslm200_merge_imas FROM l_sql
   
   LET l_sql = "DELETE FROM imas_t WHERE imasent = ",g_enterprise," AND imas001 = '",g_imaa_m.imaa001,"' ",
               "                     AND imas002 = ? AND imas003 = ? "
   PREPARE aslm200_del_imas FROM l_sql
  
   FOR l_i = 1 TO g_imeb.getLength()
      CASE l_i
         WHEN 1
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_1.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_1[l_j].l_sel_1 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_1[l_j].l_sel_1 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_1[l_j].imec003_1,
                                                      g_imeb[l_i].imeb004,g_imec_1[l_j].imec003_1,
                                                      g_imeb[l_i].imeb004,g_imec_1[l_j].imec003_1
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_1[l_j].imec003_1
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 2
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_2.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_2[l_j].l_sel_2 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_2[l_j].l_sel_2 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_2[l_j].imec003_2,
                                                      g_imeb[l_i].imeb004,g_imec_2[l_j].imec003_2,
                                                      g_imeb[l_i].imeb004,g_imec_2[l_j].imec003_2
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_2[l_j].imec003_2
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 3
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_3.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_3[l_j].l_sel_3 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_3[l_j].l_sel_3 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_3[l_j].imec003_3,
                                                      g_imeb[l_i].imeb004,g_imec_3[l_j].imec003_3,
                                                      g_imeb[l_i].imeb004,g_imec_3[l_j].imec003_3
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_3[l_j].imec003_3
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 4
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_4.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_4[l_j].l_sel_4 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_4[l_j].l_sel_4 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_4[l_j].imec003_4,
                                                      g_imeb[l_i].imeb004,g_imec_4[l_j].imec003_4,
                                                      g_imeb[l_i].imeb004,g_imec_4[l_j].imec003_4
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_4[l_j].imec003_4
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                  
                  END IF                  
               END IF
            END FOR
            
         WHEN 5
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_5.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_5[l_j].l_sel_5 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF                  
               ELSE
                  IF g_imec_5[l_j].l_sel_5 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_5[l_j].imec003_5,
                                                      g_imeb[l_i].imeb004,g_imec_5[l_j].imec003_5,
                                                      g_imeb[l_i].imeb004,g_imec_5[l_j].imec003_5
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_5[l_j].imec003_5
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 6
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_6.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_6[l_j].l_sel_6 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_6[l_j].l_sel_6 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_6[l_j].imec003_6,
                                                      g_imeb[l_i].imeb004,g_imec_6[l_j].imec003_6,
                                                      g_imeb[l_i].imeb004,g_imec_6[l_j].imec003_6
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_6[l_j].imec003_6
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 7
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_7.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_7[l_j].l_sel_7 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_7[l_j].l_sel_7 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_7[l_j].imec003_7,
                                                      g_imeb[l_i].imeb004,g_imec_7[l_j].imec003_7,
                                                      g_imeb[l_i].imeb004,g_imec_7[l_j].imec003_7
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_7[l_j].imec003_7
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                
                  END IF                  
               END IF
            END FOR
            
         WHEN 8
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_8.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_8[l_j].l_sel_8 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
                  IF l_cnt = 0 THEN
                     IF cl_null(l_msg) THEN
                        LET l_msg = g_imeb[l_i].oocql004
                     ELSE
                        LET l_msg = l_msg,"/",g_imeb[l_i].oocql004
                     END IF                     
                  END IF
               ELSE
                  IF g_imec_8[l_j].l_sel_8 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_8[l_j].imec003_8,
                                                      g_imeb[l_i].imeb004,g_imec_8[l_j].imec003_8,
                                                      g_imeb[l_i].imeb004,g_imec_8[l_j].imec003_8
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_8[l_j].imec003_8
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 9
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_9.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_9[l_j].l_sel_9 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_9[l_j].l_sel_9 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_9[l_j].imec003_9,
                                                      g_imeb[l_i].imeb004,g_imec_9[l_j].imec003_9,
                                                      g_imeb[l_i].imeb004,g_imec_9[l_j].imec003_9
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_9[l_j].imec003_9
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
         WHEN 10
            LET l_cnt = 0
            FOR l_j = 1 TO g_imec_10.getLength()
               IF p_state = 1 THEN
                  #檢查是否至少有一筆勾選
                  IF g_imec_10[l_j].l_sel_10 = 'Y' THEN
                     LET l_cnt = l_cnt + 1
                  END IF
               ELSE
                  IF g_imec_10[l_j].l_sel_10 = 'Y' THEN
                     #存檔
                     EXECUTE aslm200_merge_imas USING g_imeb[l_i].imeb002,g_imec_10[l_j].imec003_10,
                                                      g_imeb[l_i].imeb004,g_imec_10[l_j].imec003_10,
                                                      g_imeb[l_i].imeb004,g_imec_10[l_j].imec003_10
                  ELSE
                     EXECUTE aslm200_del_imas USING g_imeb[l_i].imeb004,g_imec_10[l_j].imec003_10
                  END IF                  
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     EXIT FOR                 
                  END IF                  
               END IF
            END FOR
            
      END CASE      

      IF p_state = 1 AND 
       ((l_i = 1  AND g_imec_1.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 2  AND g_imec_2.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 3  AND g_imec_3.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 4  AND g_imec_4.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 5  AND g_imec_5.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 6  AND g_imec_6.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 7  AND g_imec_7.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 8  AND g_imec_8.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 9  AND g_imec_9.getLength() > 0  AND l_cnt = 0) OR
        (l_i = 10 AND g_imec_10.getLength() > 0 AND l_cnt = 0)) THEN
         IF cl_null(l_msg) THEN
            LET l_msg = g_imeb[l_i].oocql004
         ELSE
            LET l_msg = l_msg,"/",g_imeb[l_i].oocql004
         END IF                     
      END IF
            
      IF p_state = 2 AND l_err_cnt > 0 THEN 
         EXIT FOR
      END IF      
   END FOR
   
   IF (p_state = 1 AND NOT cl_null(l_msg)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asl-00007'
      LET g_errparam.replace[1] = l_msg
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
   END IF
   
   IF p_state = 2 THEN
      IF l_err_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         CALL s_transaction_end('N',0)
      ELSE
         IF g_imaa_m.imaa100 = '3' AND NOT cl_null(g_imaa_m.imaa005) THEN
            CALL aslm200_imas_sql(2)
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt FROM imay_t WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
            IF l_cnt > 0 THEN
               EXECUTE aslm200_del_imay
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aslm200_del_imay"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                 
                  LET r_success = FALSE
                  CALL s_transaction_end('N',0) 
                  RETURN r_success            
               END IF
            END IF
            
            EXECUTE aslm200_merge_imay
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "aslm200_merge_imay"
               LET g_errparam.popup = TRUE
               CALL cl_err()
              
               LET r_success = FALSE
               CALL s_transaction_end('N',0) 
               RETURN r_success            
            END IF
            
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM imay_t 
             WHERE imayent = g_enterprise
               AND imay001 = g_imaa_m.imaa001
               AND imay006 = 'Y' 
            IF l_cnt = 0 THEN  
               OPEN aslm200_cl USING g_enterprise,g_imaa_m.imaa001
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aslm200_cl:" 
                  LET g_errparam.code   = STATUS 
                  LET g_errparam.popup  = TRUE 
                  CLOSE aslm200_cl
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF           
               
               LET l_sql = "SELECT imay003 FROM imay_t ",
                           " WHERE imayent = ",g_enterprise," AND imay001 = '",g_imaa_m.imaa001,"' ",
                           " ORDER BY imay003 "
               PREPARE aslm200_sel_imay_pre FROM l_sql
               DECLARE aslm200_sel_imay_cur CURSOR FOR aslm200_sel_imay_pre
               FOREACH aslm200_sel_imay_cur INTO l_imay003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "aslm200_sel_imay_cur"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     LET r_success = FALSE
                     CALL s_transaction_end('N',0) 
                     RETURN r_success 
                  END IF 
                  
                  UPDATE imay_t
                     SET imay006 = 'Y'
                  WHERE imayent = g_enterprise
                    AND imay001 = g_imaa_m.imaa001
                    AND imay003 = l_imay003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "Update imay_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     LET r_success = FALSE
                     CALL s_transaction_end('N',0) 
                     RETURN r_success 
                  END IF                    
                    
                  UPDATE imaa_t
                     SET imaa014 = l_imay003
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_imaa_m.imaa001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "Update imaa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     LET r_success = FALSE
                     CALL s_transaction_end('N',0) 
                     RETURN r_success            
                  ELSE
                     LET g_imaa014_flag = TRUE
                     EXIT FOREACH
                  END IF                    
                     
               END FOREACH               
            END IF             
         END IF
         
         LET g_imas_flag = TRUE 
         CALL s_transaction_end('Y',0)         
      END IF
   END IF  
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 复制imas后重新产生条码
# Memo...........: #160818-00039
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imas_reproduce()
DEFINE l_sql        STRING,
       l_cnt        LIKE type_t.num5,
       l_imay003    LIKE imay_t.imay003
       
       
    IF g_imaa_m.imaa100 = '3' AND NOT cl_null(g_imaa_m.imaa005) THEN
       CALL aslm200_imas_sql(2)
       LET l_cnt = 0 
       SELECT COUNT(*) INTO l_cnt FROM imay_t WHERE imayent = g_enterprise AND imay001 = g_imaa_m.imaa001
       IF l_cnt > 0 THEN
           
          EXECUTE aslm200_del_imay
          IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "aslm200_del_imay"
            LET g_errparam.popup = TRUE
            CALL cl_err()              
            CALL s_transaction_end('N',0)            
          END IF
       END IF 
       EXECUTE aslm200_merge_imay
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "aslm200_merge_imay"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N',0)            
         END IF
         
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM imay_t 
          WHERE imayent = g_enterprise
            AND imay001 = g_imaa_m.imaa001
            AND imay006 = 'Y' 
         IF l_cnt = 0 THEN  
            LET l_sql = "SELECT imay003 FROM imay_t ",
                        " WHERE imayent = ",g_enterprise," AND imay001 = '",g_imaa_m.imaa001,"' ",
                        " ORDER BY imay003 "
            PREPARE aslm200_sel_imay_pre_rep FROM l_sql
            DECLARE aslm200_sel_imay_cur_rep CURSOR FOR aslm200_sel_imay_pre_rep
            FOREACH aslm200_sel_imay_cur_rep INTO l_imay003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aslm200_sel_imay_cur"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0) 
               END IF 
               
               UPDATE imay_t
                  SET imay006 = 'Y'
               WHERE imayent = g_enterprise
                 AND imay001 = g_imaa_m.imaa001
                 AND imay003 = l_imay003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Update imay_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0) 
               END IF                    
                 
               UPDATE imaa_t
                  SET imaa014 = l_imay003
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_imaa_m.imaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "Update imaa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)         
               ELSE
                  LET g_imaa014_flag = TRUE
                  LET g_imaa_m.imaa014=l_imay003
                  EXIT FOREACH
               END IF                                     
            END FOREACH   
         END IF             
   END IF             
   #add by tangyi-end-
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: 161008-00007#1
# Usage..........:aslm200_imaa143_ref(传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20161008 By tangyi
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_imaa143_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaa_m.imaa143
   CALL ap_ref_array2(g_ref_fields," SELECT dbbal003 FROM dbbal_t WHERE dbbalent = '"||g_enterprise||"' AND dbbal001 = ? AND dbbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaa_m.imaa143_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imaa_m.imaa143_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: 161008-00007#1
# Usage..........: CALL aslm200_chk_imaa143(传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20161008 By tangyi
# Modify.........:
################################################################################
PRIVATE FUNCTION aslm200_chk_imaa143(p_type)
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
         AND dbba001 = g_imaa_m.imaa143
      CASE
         WHEN SQLCA.sqlcode = 100
            LET g_errno = 'adb-00030'
            RETURN
         WHEN l_dbbastus = 'N'
            LET g_errno = 'adb-00031'
            RETURN
      END CASE
   END IF
   
   IF NOT cl_null(g_imaa_m.imaa009) THEN
      LET r_success = ''
      LET r_errno = ''
      LET r_rtax001 = ''
      CALL s_arti202_search_manage_level(g_imaa_m.imaa009) 
         RETURNING r_success,r_errno,r_rtax001
      IF r_success = FALSE THEN LET r_rtax001 = '' END IF
   END IF
   
   LET l_dbbbstus = ''
   SELECT dbbbstus INTO l_dbbbstus
     FROM dbbb_t
    WHERE dbbbent = g_enterprise
      AND dbbb001 = g_imaa_m.imaa143
      AND ((dbbb002 = '1' AND dbbb003 = r_rtax001)
       OR ( dbbb002 = '2' AND dbbb003 = g_imaa_m.imaa126))
   
   CASE
      WHEN SQLCA.sqlcode = 100
         #此產品組下沒有符合條件的資料！
         LET g_errno = 'adb-00037'
      WHEN l_dbbbstus = 'N'
         LET g_errno = 'adb-00038'
   END CASE
END FUNCTION

 
{</section>}
 

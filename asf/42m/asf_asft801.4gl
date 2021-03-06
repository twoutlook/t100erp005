#該程式未解開Section, 採用最新樣板產出!
{<section id="asft801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0032(2014-10-11 11:01:22), PR版次:0032(2017-04-06 10:07:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000108
#+ Filename...: asft801
#+ Description: 工單製程變更維護作業
#+ Creator....: 01258(2014-08-24 00:00:00)
#+ Modifier...: 01258 -SD/PR- 02294
 
{</section>}
 
{<section id="asft801.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151110-00030#1  2015/11/11  By Shiun     'ON ACTION unconf'少了權限控管
#151125-00001#4  2015/11/25  By 06948     增加作廢時詢問「是否作廢」
#160113-00001#1  2016/01/14  By Sarah      1.在原有兩個作業中插入一個新的作業時，下站作業與作業序的更新會有錯
#                                          2.如果本站作業已經有報工過,就不可以變更
#                                          3.變更了本站作業,要把其他項次的上站作業=修改前本站作業的資料也更新成新的本站作業
#160222-00017#1  2016/02/23  By Sarah      變更版本sfoa002=工單製程單頭檔的變更版本sfca002加1
#160318-00025#4  2016/04/12  By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160719-00005#1  2016/08/07  By Sarah      sfob013的開窗一開始少了INITIALIZE g_qryparam.* TO NULL,其他欄位也一併檢查
#160812-00017#4  2016/08/15  By 06814      在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160727-00025#3  2016/08/16  By lixh       asft301串查asft801,模具工单且单身只有一笔资料允许修改
#160816-00001#9  2016/08/19  By 08734      抓取理由碼改CALL sub
#161108-00013#1  2016/11/08  By 07024      與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161108-00023#3  2016/11/14  By Whitney    調整作業及作業序後更新對應上下站
#161109-00085#36 2016/11/16  By lienjunqi  整批調整系統星號寫法
#161116-00063#1  2016/11/18  By 00768      非工艺工单无需做变更
#161214-00062#1  2016/12/14  By Sarah      browser_fill()增加呼叫權限過濾器lib
#160824-00007#251 2016/12/19 By sakura     新舊值備份處理
#161221-00052#1  2016/12/22  By Jessica    修正BPM整合功能:
#                                          1.按鈕須點第二次才會顯示提交
#                                          2.提交失敗，狀態仍變成W送簽中
#                                          3.從T100抽單失敗，狀態仍變成D抽單
#                                          4.已抽單、已拒絕狀態，修改/刪除時報錯: 非未確認不能修改/刪除
#170104-00066#2  2017/01/06  By Rainy      筆數相關變數由num5放大至num10
#170109-00038#1  2017/01/09  By shiun      修正"asft801_gen_sfoa()8823行，执行后会报错，inset into sfoa_t错误"
#170118-00024#1  2017/01/23  By dujuan     asft801工单工艺变更，删除两笔及多笔工序时，sfcc_t没有删除光，会有数据没有删除
#170123-00041#1  2017/01/23  By dujuan     点击新增，输完单号和run card编号之后，按tab键，就直接有左下方的提示的问题,修改了作业序对应的上一站作业序在sfcc_t中没有更新,修改了作业序对应的上一站作业序在sfcc_t中没有更新
#170120-00050#1  2017/02/08  By shiun      新增時，單號開窗需製程(sfaa061)='Y'
#170111-00015#3  2017/03/31  By lixiang    1.首站制程删除时，自动将下站工艺的上站作业更新为INIT，上站作业序更新为0
#                                          2.中间新增一笔制程时，下站作业、下站作业序自动带下一个项次的作业编号、下站作业序
#170405-00021#1  2017/04/05  By Whitney    原l_flag2='Y'點選儲存會直接跳過UPDATE，調整用comp_entry控卡
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_sfoa_m        RECORD
       sfoadocno LIKE sfoa_t.sfoadocno,
   sfoa002 LIKE sfoa_t.sfoa002,
   sfaa010 LIKE sfaa_t.sfaa010,
   sfaa011 LIKE sfaa_t.sfaa011,
   sfaa017 LIKE sfaa_t.sfaa017,
   sfaa017_desc LIKE type_t.chr80,
   oobal004 LIKE type_t.chr80,
   sfaa010_desc LIKE type_t.chr80,
   sfaa019 LIKE sfaa_t.sfaa019,
   sfoastus LIKE sfoa_t.sfoastus,
   sfoa001 LIKE sfoa_t.sfoa001,
   sfoa005 LIKE sfoa_t.sfoa005,
   sfaa010_desc1 LIKE type_t.chr80,
   sfaa020 LIKE sfaa_t.sfaa020,
   sfaa003 LIKE sfaa_t.sfaa003,
   sfoa003 LIKE sfoa_t.sfoa003,
   sfaa013 LIKE sfaa_t.sfaa013,
   sfaa005 LIKE sfaa_t.sfaa005,
   sfaa016 LIKE sfaa_t.sfaa016,
   sfaa016_desc LIKE type_t.chr80,
   sfoa004 LIKE sfoa_t.sfoa004,
   sfaa006 LIKE sfaa_t.sfaa006,
   sfaa007 LIKE sfaa_t.sfaa007,
   sfaa008 LIKE sfaa_t.sfaa008,
   sfaa063 LIKE sfaa_t.sfaa063,
   sfoasite LIKE sfoa_t.sfoasite,
   sfaa009 LIKE sfaa_t.sfaa009,
   sfaa009_desc LIKE type_t.chr80,
   sfoa900 LIKE sfoa_t.sfoa900,
   sfoa902 LIKE sfoa_t.sfoa902,
   sfoa905 LIKE sfoa_t.sfoa905,
   sfoa905_desc LIKE type_t.chr80,
   sfoa906 LIKE sfoa_t.sfoa906,
   sfoaownid LIKE sfoa_t.sfoaownid, 
   sfoaownid_desc LIKE type_t.chr80, 
   sfoaowndp LIKE sfoa_t.sfoaowndp, 
   sfoaowndp_desc LIKE type_t.chr80, 
   sfoacrtid LIKE sfoa_t.sfoacrtid, 
   sfoacrtid_desc LIKE type_t.chr80, 
   sfoacrtdp LIKE sfoa_t.sfoacrtdp, 
   sfoacrtdp_desc LIKE type_t.chr80, 
   sfoacrtdt DATETIME YEAR TO SECOND, 
   sfoamodid LIKE sfoa_t.sfoamodid, 
   sfoamodid_desc LIKE type_t.chr80, 
   sfoamoddt DATETIME YEAR TO SECOND, 
   sfoacnfid LIKE sfoa_t.sfoacnfid, 
   sfoacnfid_desc LIKE type_t.chr80, 
   sfoacnfdt DATETIME YEAR TO SECOND
       END RECORD

#單身 type 宣告
 TYPE type_g_sfob_d        RECORD
       sfob002 LIKE sfob_t.sfob002,
   sfob003 LIKE sfob_t.sfob003,
   sfob003_desc LIKE type_t.chr500,
   sfob004 LIKE sfob_t.sfob004,
   sfob005 LIKE sfob_t.sfob005,
   sfob006 LIKE sfob_t.sfob006,
   sfob007 LIKE sfob_t.sfob007,
   sfob007_desc LIKE type_t.chr500,
   sfob008 LIKE sfob_t.sfob008,
   sfob009 LIKE sfob_t.sfob009,
   sfob009_desc LIKE type_t.chr500,
   sfob010 LIKE sfob_t.sfob010,
   sfob011 LIKE sfob_t.sfob011,
   sfob011_desc LIKE type_t.chr500,
   sfob023 LIKE sfob_t.sfob023,
   sfob024 LIKE sfob_t.sfob024,
   sfob025 LIKE sfob_t.sfob025,
   sfob026 LIKE sfob_t.sfob026,
   sfob044 LIKE sfob_t.sfob044,
   sfob045 LIKE sfob_t.sfob045,
   sfob012 LIKE sfob_t.sfob012,
   sfob013 LIKE sfob_t.sfob013,
   sfob013_desc LIKE type_t.chr500,
   sfob014 LIKE sfob_t.sfob014,
   sfob015 LIKE sfob_t.sfob015,
   sfob016 LIKE sfob_t.sfob016,
   sfob017 LIKE sfob_t.sfob017,
   sfob018 LIKE sfob_t.sfob018,
   sfob019 LIKE sfob_t.sfob019,
   sfob052 LIKE sfob_t.sfob052,
   sfob052_desc LIKE type_t.chr80,
   sfob053 LIKE sfob_t.sfob053,
   sfob054 LIKE sfob_t.sfob054,
   sfob020 LIKE sfob_t.sfob020,
   sfob020_desc LIKE type_t.chr80,
   sfob021 LIKE sfob_t.sfob021,
   sfob022 LIKE sfob_t.sfob022,
   sfob055 LIKE sfob_t.sfob055,
   ooff013 LIKE ooff_t.ooff013,
   sfob901 LIKE sfob_t.sfob901,
   sfob905 LIKE sfob_t.sfob905,
   sfob905_desc LIKE type_t.chr80,
   sfob906 LIKE sfob_t.sfob906,
   sfob902 LIKE sfob_t.sfob902,
   sfobsite LIKE sfob_t.sfobsite
       END RECORD
 TYPE type_g_sfob2_d RECORD
       sfob002 LIKE sfob_t.sfob002,
   sfob027 LIKE sfob_t.sfob027,
   sfob050 LIKE sfob_t.sfob050,
   sfob028 LIKE sfob_t.sfob028,
   sfob029 LIKE sfob_t.sfob029,
   sfob030 LIKE sfob_t.sfob030,
   sfob031 LIKE sfob_t.sfob031,
   sfob032 LIKE sfob_t.sfob032,
   sfob033 LIKE sfob_t.sfob033,
   sfob034 LIKE sfob_t.sfob034,
   sfob035 LIKE sfob_t.sfob035,
   sfob036 LIKE sfob_t.sfob036,
   sfob037 LIKE sfob_t.sfob037,
   sfob038 LIKE sfob_t.sfob038,
   sfob039 LIKE sfob_t.sfob039,
   sfob040 LIKE sfob_t.sfob040,
   sfob041 LIKE sfob_t.sfob041,
   sfob042 LIKE sfob_t.sfob042,
   sfob043 LIKE sfob_t.sfob043,
   sfob046 LIKE sfob_t.sfob046,
   sfob047 LIKE sfob_t.sfob047,
   sfob048 LIKE sfob_t.sfob048,
   sfob049 LIKE sfob_t.sfob049,
   sfob051 LIKE sfob_t.sfob051
       END RECORD



#模組變數(Module Variables)
DEFINE g_sfoa_m          type_g_sfoa_m
DEFINE g_sfoa_m_t        type_g_sfoa_m

   DEFINE g_sfoadocno_t LIKE sfoa_t.sfoadocno
DEFINE g_sfoa001_t LIKE sfoa_t.sfoa001
DEFINE g_sfoa900_t LIKE sfoa_t.sfoa900

DEFINE g_sfob_d          DYNAMIC ARRAY OF type_g_sfob_d
DEFINE g_sfob_d_t        type_g_sfob_d
DEFINE g_sfob_d_o        type_g_sfob_d   #160824-00007#251 by sakura add
DEFINE g_sfob2_d   DYNAMIC ARRAY OF type_g_sfob2_d
DEFINE g_sfob2_d_t type_g_sfob2_d



DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
    #     b_statepic     LIKE type_t.chr50,
            b_sfoadocno LIKE sfoa_t.sfoadocno,
      b_sfoa001 LIKE sfoa_t.sfoa001,
      b_sfoa900 LIKE sfoa_t.sfoa900
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_browser_f  RECORD    #資料瀏覽之欄位
     #    b_statepic     LIKE type_t.chr50,
            b_sfoadocno LIKE sfoa_t.sfoadocno,
      b_sfoa001 LIKE sfoa_t.sfoa001,
      b_sfoa900 LIKE sfoa_t.sfoa900
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義
DEFINE g_detail_multi_table_t    RECORD
      ooff001 LIKE ooff_t.ooff001,
      ooff002 LIKE ooff_t.ooff002,
      ooff003 LIKE ooff_t.ooff003,
      ooff004 LIKE ooff_t.ooff004,
      ooff005 LIKE ooff_t.ooff005,
      ooff006 LIKE ooff_t.ooff006,
      ooff007 LIKE ooff_t.ooff007,
      ooff008 LIKE ooff_t.ooff008,
      ooff009 LIKE ooff_t.ooff009,
      ooff010 LIKE ooff_t.ooff010,
      ooff011 LIKE ooff_t.ooff011,
      ooff012 LIKE ooff_t.ooff012,
      ooff013 LIKE ooff_t.ooff013
      END RECORD

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING


DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
#161108-00013#1-s-mod
#DEFINE g_rec_b               LIKE type_t.num5
#DEFINE l_ac                  LIKE type_t.num5
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
#
#DEFINE g_pagestart           LIKE type_t.num5
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_state               STRING
#
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
#
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序欄位
#
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
#161108-00013#1-e-mod
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身

{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_sfoasite_t          LIKE sfoa_t.sfoasite
DEFINE g_acc                 LIKE gzcb_t.gzcb007
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
DEFINE g_sfoe003             LIKE sfoe_t.sfoe003
DEFINE g_sfoe007             LIKE sfoe_t.sfoe007
DEFINE g_sfob_d_color        DYNAMIC ARRAY OF RECORD
       sfob002               STRING,
       sfob003               STRING,
       sfob003_desc          STRING,
       sfob004               STRING,
       sfob005               STRING,
       sfob006               STRING,
       sfob007               STRING,
       sfob007_desc          STRING,
       sfob008               STRING,
       sfob009               STRING,
       sfob009_desc          STRING,
       sfob010               STRING,
       sfob011               STRING,
       sfob011_desc          STRING,
       sfob023               STRING,
       sfob024               STRING,
       sfob025               STRING,
       sfob026               STRING,
       sfob044               STRING,
       sfob045               STRING,
       sfob012               STRING,
       sfob013               STRING,
       sfob013_desc          STRING,
       sfob014               STRING,
       sfob015               STRING,
       sfob016               STRING,
       sfob017               STRING,
       sfob018               STRING,
       sfob019               STRING,
       sfob052               STRING,
       sfob052_desc          STRING,
       sfob053               STRING,
       sfob054               STRING,
       sfob020               STRING,
       sfob020_desc          STRING,
       sfob021               STRING,
       sfob022               STRING,
       sfob055               STRING,
       ooff013               STRING,
       sfob901               STRING,
       sfob905               STRING,
       sfob905_desc          STRING,
       sfob906               STRING,
       sfob902               STRING,
       sfobsite              STRING
                             END RECORD
DEFINE g_sfob2_d_color       DYNAMIC ARRAY OF RECORD
       sfob002               STRING,
       sfob027               STRING,
       sfob050               STRING,
       sfob028               STRING,
       sfob029               STRING,
       sfob030               STRING,
       sfob031               STRING,
       sfob032               STRING,
       sfob033               STRING,
       sfob034               STRING,
       sfob035               STRING,
       sfob036               STRING,
       sfob037               STRING,
       sfob038               STRING,
       sfob039               STRING,
       sfob040               STRING,
       sfob041               STRING,
       sfob042               STRING,
       sfob043               STRING,
       sfob046               STRING,
       sfob047               STRING,
       sfob048               STRING,
       sfob049               STRING,
       sfob051               STRING
                             END RECORD

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="asft801.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化 name="main.init"
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog  #160816-00001#9  2016/08/19  By 08734 Mark 
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#9  2016/08/19  By 08734 add  
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT sfoadocno,sfoa002,'','','','','','','',sfoastus,sfoa001,sfoa005,'','','',sfoa003,'','','','',sfoa004,'','','',sfoasite,'','',sfoa900,sfoa902,sfoa905,'',sfoa906,",
                      " sfoaownid,'',sfoaowndp,'',sfoacrtid,'',sfoacrtdp,'',sfoacrtdt,sfoamodid,'',sfoamoddt,sfoacnfid,'',sfoacnfdt   FROM sfoa_t",
                      " WHERE sfoaent=? AND sfoasite='",g_site,"' AND sfoadocno=? AND sfoa001=? AND sfoa900=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE asft801_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asft801 WITH FORM cl_ap_formpath("asf",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL asft801_init()
 
      #進入選單 Menu (='N')
      CALL asft801_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_asft801
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="asft801.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asft801_init()
   #add-point:init段define

   #end add-point

   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   CALL cl_set_combo_scc_part('sfoastus','13','A,D,N,R,W,Y,X')
   CALL cl_set_combo_scc('sfaa003','4007')
   CALL cl_set_combo_scc('sfaa005','4009')
   CALL cl_set_combo_scc('sfoa005','4054')
   CALL cl_set_combo_scc('sfob005','1202')
   CALL cl_set_combo_scc('sfob901','5448')
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   #add-point:畫面資料初始化
   #{<point name="init.init"/>}
   #end add-point

   CALL asft801_default_search()

END FUNCTION

PRIVATE FUNCTION asft801_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num10       #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_flag        LIKE type_t.chr1
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   CALL cl_set_act_visible("accept,cancel", FALSE)


   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   
   #end add-point

   WHILE TRUE
      
      CALL asft801_browser_fill("")
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_sfoadocno = g_sfoadocno_t AND
               g_browser[li_idx].b_sfoa001 = g_sfoa001_t AND
               g_browser[li_idx].b_sfoa900 = g_sfoa900_t
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         DISPLAY ARRAY g_sfob_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               CALL asft801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

               #add-point:page1, before row動作
               {<point name="ui_dialog.page1.before_row"/>}
               CALL s_hint_show('sfoe_t','sfob_t','sfcb_t',g_sfoa_m.sfoadocno,g_sfoa_m.sfoa900,g_sfoa_m.sfoa001,g_sfob_d[g_detail_idx].sfob002,0)
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL asft801_idx_chk()
               #add-point:page1自定義行為
               {<point name="ui_dialog.page1.before_display"/>}
               CALL DIALOG.setCellAttributes(g_sfob_d_color)
               #end add-point

            #自訂ACTION(detail_show,page_1)


            #add-point:page1自定義行為
            {<point name="ui_dialog.page1.action"/>}
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_sfob2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL asft801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作
               {<point name="ui_dialog.body2.before_row"/>}
               CALL s_hint_show('sfoe_t','sfob_t','sfcb_t',g_sfoa_m.sfoadocno,g_sfoa_m.sfoa900,g_sfoa_m.sfoa001,g_sfob2_d[g_detail_idx].sfob002,0)
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
			   LET g_current_page = 2
               CALL asft801_idx_chk()
               #add-point:page2自定義行為
               {<point name="ui_dialog.body2.before_display"/>}
               CALL DIALOG.setCellAttributes(g_sfob2_d_color)
               #end add-point

            #自訂ACTION(detail_show,page_2)


            #add-point:page2自定義行為
            {<point name="ui_dialog.body2.action"/>}
            #end add-point

         END DISPLAY



         #add-point:ui_dialog段自定義display array
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point


         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE

            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF

            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL asft801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asft801_ui_detailshow() #Setting the current row

            #筆數顯示
            LET g_current_page = 1
            CALL asft801_idx_chk()
            
            CALL cl_set_act_visible("gen_checkin,gen_checkout",FALSE)
            LET l_flag = 'N'
            IF NOT cl_null(g_sfoa_m.sfaa016) AND NOT cl_null(g_sfoa_m.sfaa010) THEN
               CALL cl_set_act_visible("gen_checkin,gen_checkout", TRUE)
               LET l_flag = 'Y' 
            END IF


            #add-point:ui_dialog段before_dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point

            #NEXT FIELD sfob002

        ON ACTION statechange
           LET g_action_choice = "statechange"  #161221-00052#1
           CALL asft801_statechange()
           #LET g_action_choice = "statechange"  #161221-00052#1
           EXIT DIALOG

         #此段落由子樣板a32產生
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status
            {<point name="menu.bpm_status" />}
            #END add-point





         #ACTION表單列

         ON ACTION first
            CALL asft801_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft801_idx_chk()

         ON ACTION previous
            CALL asft801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft801_idx_chk()

         ON ACTION jump
            CALL asft801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft801_idx_chk()

         ON ACTION next
            CALL asft801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft801_idx_chk()

         ON ACTION last
            CALL asft801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft801_idx_chk()

         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF


         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF

         ON ACTION delete
      
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL asft801_delete()
               #add-point:ON ACTION delete
	   
               #END add-point
               EXIT DIALOG
            END IF
      
      
         ON ACTION insert
      
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL asft801_insert()
               #add-point:ON ACTION insert
	   
               #END add-point
               EXIT DIALOG
            END IF

         ON ACTION modify
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL asft801_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION modify_detail
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               CALL asft801_modify()
               #add-point:ON ACTION modify_detail
               {<point name="menu.modify_detail" />}
               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
               EXIT DIALOG
            END IF

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_browser)
               LET g_export_id[1]   = "s_browse"
               LET g_export_node[2] = base.typeInfo.create(g_sfob_d)
               LET g_export_id[2]   = "s_detail1"
               LET g_export_node[3] = base.typeInfo.create(g_sfob2_d)
               LET g_export_id[3]   = "s_detail2"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asft801_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
            
         ON ACTION gen_sfoc
            LET g_action_choice="gen_sfoc"
            IF cl_auth_chk_act("gen_sfoc") THEN
               IF l_ac > 0 THEN
                  CALL asft801_01(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'N')
               END IF
            END IF
            
         ON ACTION gen_checkin
            LET g_action_choice="gen_checkin"
            IF cl_auth_chk_act("gen_checkin") THEN
               IF l_ac > 0 AND l_flag = 'Y' THEN
                  CALL asft801_02(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'1','N')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00139'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
         
         ON ACTION gen_checkout
            LET g_action_choice="gen_checkout"
            IF cl_auth_chk_act("gen_checkout") THEN
               IF l_ac > 0 AND l_flag = 'Y' THEN
                  CALL asft801_02(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'2','N')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00139'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            

     #   ON ACTION reproduce
     #
     #      LET g_action_choice="reproduce"
     #      IF cl_auth_chk_act("reproduce") THEN 
     #         CALL asft801_reproduce()
     #         #add-point:ON ACTION reproduce
	 #
     #         #END add-point
     #         EXIT DIALOG
     #      END IF

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

PRIVATE FUNCTION asft801_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point

   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00005"
      LET g_errparam.extend = "searchcol"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF

   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1 "
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY sfoadocno"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF

   CALL asft801_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION asft801_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_sfoa_m.* TO NULL
   CALL g_sfob_d.clear()
   CALL g_sfob2_d.clear()


   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "sfoadocno"
                        ,",sfoa001,sfoa900 "


   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET g_wc = g_wc," AND sfoasite = '",g_site,"'"
   
   LET l_wc  = g_wc.trim()
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   #add-point:browser_fill,foreach前
   {<point name="browser_fill.before_foreach"/>}
   #end add-point

   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE sfoadocno ",
                                    ",sfoa001,sfoa900 ",


                        " FROM sfoa_t ",
                              " ",
                              " LEFT JOIN sfob_t ON sfobent = sfoaent AND sfoadocno = sfobdocno AND sfoa001 = sfob001 ",
                              " WHERE sfoaent = '" ||g_enterprise|| "' AND sfobent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
                              , cl_sql_add_filter("sfoa_t")   #161214-00062#1 add

   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE sfoadocno ",
                                    ",sfoa001,sfoa900 ",


                        " FROM sfoa_t ",
                              " ",
                              " ",
                        "WHERE sfoaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
                        , cl_sql_add_filter("sfoa_t")   #161214-00062#1 add

   END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   #add-point:browser_fill,count前
   {<point name="browser_fill.before_count"/>}
   #end add-point

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #LET g_page_action = ps_page_action          # Keep Action

   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF

   CASE ps_page_action
      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - 1
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + 1
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - 1
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - 1
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF

   END CASE

   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #依照sfoadocno,sfoa001 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT sfoadocno,sfoa001,sfoa900,DENSE_RANK() OVER(ORDER BY sfoadocno,sfoa001,sfoa900 ",g_order,") AS RANK ",
                        " FROM sfoa_t ",
                              " ",
                              " LEFT JOIN sfob_t ON sfobent = sfoaent AND sfoadocno = sfobdocno AND sfoa001 = sfob001 AND sfoa900 = sfob900 ",

                       " WHERE sfoaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
                       , cl_sql_add_filter("sfoa_t")   #161214-00062#1 add
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT sfoadocno,sfoa001,sfoa900,DENSE_RANK() OVER(ORDER BY sfoadocno,sfoa001,sfoa900 ",g_order,") AS RANK ",
                       " FROM sfoa_t ",
                            "  ",
                            "  ",
                       " WHERE sfoaent = '" ||g_enterprise|| "' AND ", g_wc
                       , cl_sql_add_filter("sfoa_t")   #161214-00062#1 add
   END IF

   #定義翻頁CURSOR
   LET g_sql= "SELECT sfoadocno,sfoa001,sfoa900 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order

   #add-point:browser_fill,before_prepare
   {<point name="browser_fill.before_prepare"/>}
   #end add-point

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   #add-point:browser_fill,open
   {<point name="browser_fill.open"/>}
   #end add-point

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_sfoadocno,g_browser[g_cnt].b_sfoa001,g_browser[g_cnt].b_sfoa900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF



      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
      #end add-point

            #此段落由子樣板a24產生
#      CASE g_browser[g_cnt].b_statepic
#         WHEN "C"
#            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
#         WHEN "D"
#            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
#
#         WHEN "E"
#            LET g_browser[g_cnt].b_statepic = "stus/16/closed_irregular.png"
#
#         WHEN "F"
#            LET g_browser[g_cnt].b_statepic = "stus/16/released.png"
#
#         WHEN "M"
#            LET g_browser[g_cnt].b_statepic = "stus/16/costing_closed.png"
#
#         WHEN "N"
#            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
#
#         WHEN "R"
#            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
#
#         WHEN "W"
#            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
#
#         WHEN "X"
#            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
#
#         WHEN "Y"
#            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
#
#
#		
#      END CASE


      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()

   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

   FREE browse_pre

   #add-point:browser_fill段結束前
   {<point name="browser_fill.after"/>}
   #end add-point

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION asft801_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point

   LET g_sfoa_m.sfoadocno = g_browser[g_current_idx].b_sfoadocno
   LET g_sfoa_m.sfoa001 = g_browser[g_current_idx].b_sfoa001
   LET g_sfoa_m.sfoa900 = g_browser[g_current_idx].b_sfoa900

    SELECT UNIQUE sfoadocno,sfoa002,sfoa001,sfoa005,sfoa003,sfoa004,sfoasite,sfoastus,sfoa900,sfoa902,sfoa905,sfoa906,
     sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,sfoacnfdt
 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa003,g_sfoa_m.sfoa004,
     g_sfoa_m.sfoasite,g_sfoa_m.sfoastus,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa906,
     g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,
     g_sfoa_m.sfoamodid,g_sfoa_m.sfoamoddt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt
 FROM sfoa_t
 WHERE sfoaent = g_enterprise AND sfoadocno = g_sfoa_m.sfoadocno AND sfoa001 = g_sfoa_m.sfoa001
   AND sfoa900 = g_sfoa_m.sfoa900
   CALL asft801_show()

END FUNCTION

PRIVATE FUNCTION asft801_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point

   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)


   END IF

   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_sfoadocno = g_sfoa_m.sfoadocno
         AND g_browser[l_i].b_sfoa001 = g_sfoa_m.sfoa001
         AND g_browser[l_i].b_sfoa900 = g_sfoa_m.sfoa900

         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR

   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF

   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION asft801_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_sfoa_m.* TO NULL
   CALL g_sfob_d.clear()
   CALL g_sfob2_d.clear()



   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc2_table1 TO NULL


   LET g_qryparam.state = 'c'

   #add-point:cs段開始前
   {<point name="cs.before_construct"/>}
   #end add-point

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT BY NAME g_wc ON sfoadocno,sfoa002,sfoa001,sfoa005,sfoa003,sfoa004,sfoastus,sfoa900,sfoa902,sfoa905,sfoa906,
                                sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,sfoacnfdt

         BEFORE CONSTRUCT
#saki            CALL cl_qbe_init()
            #add-point:cs段before_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point

         #公用欄位開窗相關處理


         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         #----<<sfoadocno>>----
         #Ctrlp:construct.c.sfoadocno
         ON ACTION controlp INFIELD sfoadocno
            #add-point:ON ACTION controlp INFIELD sfoadocno
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_sfoadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoadocno  #顯示到畫面上
            NEXT FIELD sfoadocno                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfoadocno
            #add-point:BEFORE FIELD sfoadocno
            {<point name="construct.b.sfoadocno" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoadocno

            #add-point:AFTER FIELD sfoadocno
            {<point name="construct.a.sfoadocno" />}
            #END add-point


         #----<<sfoa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfoa002
            #add-point:BEFORE FIELD sfoa002
            {<point name="construct.b.sfoa002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoa002

            #add-point:AFTER FIELD sfoa002
            {<point name="construct.a.sfoa002" />}
            #END add-point


         #Ctrlp:construct.c.sfoa002
#         ON ACTION controlp INFIELD sfoa002
            #add-point:ON ACTION controlp INFIELD sfoa002
            {<point name="construct.c.sfoa002" />}
            #END add-point

         #----<<sfoa001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfoa001
            #add-point:BEFORE FIELD sfoa001
            {<point name="construct.b.sfoa001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoa001

            #add-point:AFTER FIELD sfoa001
            {<point name="construct.a.sfoa001" />}
            #END add-point


         #Ctrlp:construct.c.sfoa001
         ON ACTION controlp INFIELD sfoa001
            #add-point:ON ACTION controlp INFIELD sfoa001
            {<point name="construct.c.sfoa001" />}
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_sfoadocno_1()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoa001  #顯示到畫面上
            NEXT FIELD sfoa001                     #返回原欄位
            #END add-point

         #----<<sfoa005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfoa005
            #add-point:BEFORE FIELD sfoa005
            {<point name="construct.b.sfoa005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoa005

            #add-point:AFTER FIELD sfoa005
            {<point name="construct.a.sfoa005" />}
            #END add-point


         #Ctrlp:construct.c.sfoa005
#         ON ACTION controlp INFIELD sfoa005
            #add-point:ON ACTION controlp INFIELD sfoa005
            {<point name="construct.c.sfoa005" />}
            #END add-point

         #----<<sfoa003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfoa003
            #add-point:BEFORE FIELD sfoa003
            {<point name="construct.b.sfoa003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoa003

            #add-point:AFTER FIELD sfoa003
            {<point name="construct.a.sfoa003" />}
            #END add-point


         #Ctrlp:construct.c.sfoa003
#         ON ACTION controlp INFIELD sfoa003
            #add-point:ON ACTION controlp INFIELD sfoa003
            {<point name="construct.c.sfoa003" />}
            #END add-point

         #----<<sfoa004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfoa004
            #add-point:BEFORE FIELD sfoa004
            {<point name="construct.b.sfoa004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfoa004

            #add-point:AFTER FIELD sfoa004
            {<point name="construct.a.sfoa004" />}
            #END add-point


         #Ctrlp:construct.c.sfoa004
#         ON ACTION controlp INFIELD sfoa004
            #add-point:ON ACTION controlp INFIELD sfoa004
            {<point name="construct.c.sfoa004" />}
            
            #END add-point
            
         ON ACTION controlp INFIELD sfoa905
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc         
            CALL q_oocq002()                                #呼叫開窗   
            DISPLAY g_qryparam.return1 TO sfoa905    
            NEXT FIELD sfoa905                          #返回原欄位
            
         ON ACTION controlp INFIELD sfoaownid
            #add-point:ON ACTION controlp INFIELD sfoaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoaownid  #顯示到畫面上
            NEXT FIELD sfoaownid                     #返回原欄位

         ON ACTION controlp INFIELD sfoaowndp
            #add-point:ON ACTION controlp INFIELD sfoaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoaowndp  #顯示到畫面上
            NEXT FIELD sfoaowndp                     #返回原欄位

         ON ACTION controlp INFIELD sfoacrtid
            #add-point:ON ACTION controlp INFIELD sfoacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoacrtid  #顯示到畫面上
            NEXT FIELD sfoacrtid                     #返回原欄位

         ON ACTION controlp INFIELD sfoacrtdp
            #add-point:ON ACTION controlp INFIELD sfoacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoacrtdp  #顯示到畫面上
            NEXT FIELD sfoacrtdp                     #返回原欄位

         ON ACTION controlp INFIELD sfoamodid
            #add-point:ON ACTION controlp INFIELD sfoamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoamodid  #顯示到畫面上
            NEXT FIELD sfoamodid                     #返回原欄位
    
         ON ACTION controlp INFIELD sfoacnfid
            #add-point:ON ACTION controlp INFIELD sfoacnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfoacnfid  #顯示到畫面上
            NEXT FIELD sfoacnfid                     #返回原欄位



      END CONSTRUCT

      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sfob002,sfob003,sfob004,sfob005,sfob006,sfob007,sfob008,sfob009,sfob010,
          sfob011,sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012,sfob013,sfob014,sfob015,sfob016,
          sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055,sfob027,sfob050,
          sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,sfob037,sfob038,sfob039,
          sfob040,sfob041,sfob042,sfob043,sfob046,sfob047,sfob048,sfob049,sfob051
           FROM s_detail1[1].sfob002,s_detail1[1].sfob003,s_detail1[1].sfob004,s_detail1[1].sfob005,
               s_detail1[1].sfob006,s_detail1[1].sfob007,s_detail1[1].sfob008,s_detail1[1].sfob009,s_detail1[1].sfob010,
               s_detail1[1].sfob011,s_detail1[1].sfob023,s_detail1[1].sfob024,s_detail1[1].sfob025,s_detail1[1].sfob026,
               s_detail1[1].sfob044,s_detail1[1].sfob045,s_detail1[1].sfob012,s_detail1[1].sfob013,s_detail1[1].sfob014,
               s_detail1[1].sfob015,s_detail1[1].sfob016,s_detail1[1].sfob017,s_detail1[1].sfob018,s_detail1[1].sfob019,
               s_detail1[1].sfob052,s_detail1[1].sfob053,s_detail1[1].sfob054,s_detail1[1].sfob020,s_detail1[1].sfob021,
               s_detail1[1].sfob022,s_detail1[1].sfob055,s_detail2[1].sfob027,s_detail2[1].sfob050,s_detail2[1].sfob028,
               s_detail2[1].sfob029,s_detail2[1].sfob030,s_detail2[1].sfob031,s_detail2[1].sfob032,s_detail2[1].sfob033,
               s_detail2[1].sfob034,s_detail2[1].sfob035,s_detail2[1].sfob036,s_detail2[1].sfob037,s_detail2[1].sfob038,
               s_detail2[1].sfob039,s_detail2[1].sfob040,s_detail2[1].sfob041,s_detail2[1].sfob042,s_detail2[1].sfob043,
               s_detail2[1].sfob046,s_detail2[1].sfob047,s_detail2[1].sfob048,s_detail2[1].sfob049,s_detail2[1].sfob051


         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<sfob002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob002
            #add-point:BEFORE FIELD sfob002
            {<point name="construct.b.page1.sfob002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob002

            #add-point:AFTER FIELD sfob002
            {<point name="construct.a.page1.sfob002" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob002
#         ON ACTION controlp INFIELD sfob002
            #add-point:ON ACTION controlp INFIELD sfob002
            {<point name="construct.c.page1.sfob002" />}
            #END add-point

         #----<<sfob003>>----
         #Ctrlp:construct.c.page1.sfob003
         ON ACTION controlp INFIELD sfob003
            #add-point:ON ACTION controlp INFIELD sfob003
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
		    	LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob003  #顯示到畫面上
            NEXT FIELD sfob003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob003
            #add-point:BEFORE FIELD sfob003
            {<point name="construct.b.page1.sfob003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob003

            #add-point:AFTER FIELD sfob003
            {<point name="construct.a.page1.sfob003" />}
            #END add-point


         #----<<sfob004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob004
            #add-point:BEFORE FIELD sfob004
            {<point name="construct.b.page1.sfob004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob004

            #add-point:AFTER FIELD sfob004
            {<point name="construct.a.page1.sfob004" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob004
#         ON ACTION controlp INFIELD sfob004
            #add-point:ON ACTION controlp INFIELD sfob004
            {<point name="construct.c.page1.sfob004" />}
            #END add-point

         #----<<sfob005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob005
            #add-point:BEFORE FIELD sfob005
            {<point name="construct.b.page1.sfob005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob005

            #add-point:AFTER FIELD sfob005
            {<point name="construct.a.page1.sfob005" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob005
#         ON ACTION controlp INFIELD sfob005
            #add-point:ON ACTION controlp INFIELD sfob005
            {<point name="construct.c.page1.sfob005" />}
            #END add-point

         #----<<sfob006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob006
            #add-point:BEFORE FIELD sfob006
            {<point name="construct.b.page1.sfob006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob006

            #add-point:AFTER FIELD sfob006
            {<point name="construct.a.page1.sfob006" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob006
#         ON ACTION controlp INFIELD sfob006
            #add-point:ON ACTION controlp INFIELD sfob006
            {<point name="construct.c.page1.sfob006" />}
            #END add-point

         #----<<sfob007>>----
         #Ctrlp:construct.c.page1.sfob007
         ON ACTION controlp INFIELD sfob007
            #add-point:ON ACTION controlp INFIELD sfob007
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob007  #顯示到畫面上

            NEXT FIELD sfob007                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob007
            #add-point:BEFORE FIELD sfob007
            {<point name="construct.b.page1.sfob007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob007

            #add-point:AFTER FIELD sfob007
            {<point name="construct.a.page1.sfob007" />}
            #END add-point


         #----<<sfob008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob008
            #add-point:BEFORE FIELD sfob008
            {<point name="construct.b.page1.sfob008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob008

            #add-point:AFTER FIELD sfob008
            {<point name="construct.a.page1.sfob008" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob008
#         ON ACTION controlp INFIELD sfob008
            #add-point:ON ACTION controlp INFIELD sfob008
            {<point name="construct.c.page1.sfob008" />}
            #END add-point

         #----<<sfob009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob009
            #add-point:BEFORE FIELD sfob009
            {<point name="construct.b.page1.sfob009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob009

            #add-point:AFTER FIELD sfob009
            {<point name="construct.a.page1.sfob009" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob009
         ON ACTION controlp INFIELD sfob009
            #add-point:ON ACTION controlp INFIELD sfob009
            {<point name="construct.c.page1.sfob009" />}
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob009  #顯示到畫面上

            NEXT FIELD sfob009                     #返回原欄位
            #END add-point

         #----<<sfob010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob010
            #add-point:BEFORE FIELD sfob010
            {<point name="construct.b.page1.sfob010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob010

            #add-point:AFTER FIELD sfob010
            {<point name="construct.a.page1.sfob010" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob010
#         ON ACTION controlp INFIELD sfob010
            #add-point:ON ACTION controlp INFIELD sfob010
            {<point name="construct.c.page1.sfob010" />}
            #END add-point

         #----<<sfob011>>----
         #Ctrlp:construct.c.page1.sfob011
         ON ACTION controlp INFIELD sfob011
            #add-point:ON ACTION controlp INFIELD sfob011
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob011  #顯示到畫面上
            NEXT FIELD sfob011                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob011
            #add-point:BEFORE FIELD sfob011
            {<point name="construct.b.page1.sfob011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob011

            #add-point:AFTER FIELD sfob011
            {<point name="construct.a.page1.sfob011" />}
            #END add-point


         #----<<sfob023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob023
            #add-point:BEFORE FIELD sfob023
            {<point name="construct.b.page1.sfob023" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob023

            #add-point:AFTER FIELD sfob023
            {<point name="construct.a.page1.sfob023" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob023
#         ON ACTION controlp INFIELD sfob023
            #add-point:ON ACTION controlp INFIELD sfob023
            {<point name="construct.c.page1.sfob023" />}
            #END add-point

         #----<<sfob024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob024
            #add-point:BEFORE FIELD sfob024
            {<point name="construct.b.page1.sfob024" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob024

            #add-point:AFTER FIELD sfob024
            {<point name="construct.a.page1.sfob024" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob024
#         ON ACTION controlp INFIELD sfob024
            #add-point:ON ACTION controlp INFIELD sfob024
            {<point name="construct.c.page1.sfob024" />}
            #END add-point

         #----<<sfob025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob025
            #add-point:BEFORE FIELD sfob025
            {<point name="construct.b.page1.sfob025" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob025

            #add-point:AFTER FIELD sfob025
            {<point name="construct.a.page1.sfob025" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob025
#         ON ACTION controlp INFIELD sfob025
            #add-point:ON ACTION controlp INFIELD sfob025
            {<point name="construct.c.page1.sfob025" />}
            #END add-point

         #----<<sfob026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob026
            #add-point:BEFORE FIELD sfob026
            {<point name="construct.b.page1.sfob026" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob026

            #add-point:AFTER FIELD sfob026
            {<point name="construct.a.page1.sfob026" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob026
#         ON ACTION controlp INFIELD sfob026
            #add-point:ON ACTION controlp INFIELD sfob026
            {<point name="construct.c.page1.sfob026" />}
            #END add-point

         #----<<sfob044>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob044
            #add-point:BEFORE FIELD sfob044
            {<point name="construct.b.page1.sfob044" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob044

            #add-point:AFTER FIELD sfob044
            {<point name="construct.a.page1.sfob044" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob044
#         ON ACTION controlp INFIELD sfob044
            #add-point:ON ACTION controlp INFIELD sfob044
            {<point name="construct.c.page1.sfob044" />}
            #END add-point

         #----<<sfob045>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob045
            #add-point:BEFORE FIELD sfob045
            {<point name="construct.b.page1.sfob045" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob045

            #add-point:AFTER FIELD sfob045
            {<point name="construct.a.page1.sfob045" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob045
#         ON ACTION controlp INFIELD sfob045
            #add-point:ON ACTION controlp INFIELD sfob045
            {<point name="construct.c.page1.sfob045" />}
            #END add-point

         #----<<sfob012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob012
            #add-point:BEFORE FIELD sfob012
            {<point name="construct.b.page1.sfob012" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob012

            #add-point:AFTER FIELD sfob012
            {<point name="construct.a.page1.sfob012" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob012
#         ON ACTION controlp INFIELD sfob012
            #add-point:ON ACTION controlp INFIELD sfob012
            {<point name="construct.c.page1.sfob012" />}
            #END add-point

         #----<<sfob013>>----
         #Ctrlp:construct.c.page1.sfob013
         ON ACTION controlp INFIELD sfob013
            #add-point:ON ACTION controlp INFIELD sfob013
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob013  #顯示到畫面上
            NEXT FIELD sfob013                     #返回原欄位
          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob013
            #add-point:BEFORE FIELD sfob013
            {<point name="construct.b.page1.sfob013" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob013

            #add-point:AFTER FIELD sfob013
            {<point name="construct.a.page1.sfob013" />}
            #END add-point


         #----<<sfob014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob014
            #add-point:BEFORE FIELD sfob014
            {<point name="construct.b.page1.sfob014" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob014

            #add-point:AFTER FIELD sfob014
            {<point name="construct.a.page1.sfob014" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob014
#         ON ACTION controlp INFIELD sfob014
            #add-point:ON ACTION controlp INFIELD sfob014
            {<point name="construct.c.page1.sfob014" />}
            #END add-point

         #----<<sfob015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob015
            #add-point:BEFORE FIELD sfob015
            {<point name="construct.b.page1.sfob015" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob015

            #add-point:AFTER FIELD sfob015
            {<point name="construct.a.page1.sfob015" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob015
#         ON ACTION controlp INFIELD sfob015
            #add-point:ON ACTION controlp INFIELD sfob015
            {<point name="construct.c.page1.sfob015" />}
            #END add-point

         #----<<sfob016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob016
            #add-point:BEFORE FIELD sfob016
            {<point name="construct.b.page1.sfob016" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob016

            #add-point:AFTER FIELD sfob016
            {<point name="construct.a.page1.sfob016" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob016
#         ON ACTION controlp INFIELD sfob016
            #add-point:ON ACTION controlp INFIELD sfob016
            {<point name="construct.c.page1.sfob016" />}
            #END add-point

         #----<<sfob017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob017
            #add-point:BEFORE FIELD sfob017
            {<point name="construct.b.page1.sfob017" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob017

            #add-point:AFTER FIELD sfob017
            {<point name="construct.a.page1.sfob017" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob017
#         ON ACTION controlp INFIELD sfob017
            #add-point:ON ACTION controlp INFIELD sfob017
            {<point name="construct.c.page1.sfob017" />}
            #END add-point

         #----<<sfob018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob018
            #add-point:BEFORE FIELD sfob018
            {<point name="construct.b.page1.sfob018" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob018

            #add-point:AFTER FIELD sfob018
            {<point name="construct.a.page1.sfob018" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob018
#         ON ACTION controlp INFIELD sfob018
            #add-point:ON ACTION controlp INFIELD sfob018
            {<point name="construct.c.page1.sfob018" />}
            #END add-point

         #----<<sfob019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob019
            #add-point:BEFORE FIELD sfob019
            {<point name="construct.b.page1.sfob019" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob019

            #add-point:AFTER FIELD sfob019
            {<point name="construct.a.page1.sfob019" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob019
#         ON ACTION controlp INFIELD sfob019
            #add-point:ON ACTION controlp INFIELD sfob019
            {<point name="construct.c.page1.sfob019" />}
            #END add-point

         #----<<sfob052>>----
         #Ctrlp:construct.c.page1.sfob052
         ON ACTION controlp INFIELD sfob052
            #add-point:ON ACTION controlp INFIELD sfob052
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob052  #顯示到畫面上
            NEXT FIELD sfob052                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob052
            #add-point:BEFORE FIELD sfob052
            {<point name="construct.b.page1.sfob052" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob052

            #add-point:AFTER FIELD sfob052
            {<point name="construct.a.page1.sfob052" />}
            #END add-point


         #----<<sfob053>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob053
            #add-point:BEFORE FIELD sfob053
            {<point name="construct.b.page1.sfob053" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob053

            #add-point:AFTER FIELD sfob053
            {<point name="construct.a.page1.sfob053" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob053
#         ON ACTION controlp INFIELD sfob053
            #add-point:ON ACTION controlp INFIELD sfob053
            {<point name="construct.c.page1.sfob053" />}
            #END add-point

         #----<<sfob054>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob054
            #add-point:BEFORE FIELD sfob054
            {<point name="construct.b.page1.sfob054" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob054

            #add-point:AFTER FIELD sfob054
            {<point name="construct.a.page1.sfob054" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob054
#         ON ACTION controlp INFIELD sfob054
            #add-point:ON ACTION controlp INFIELD sfob054
            {<point name="construct.c.page1.sfob054" />}
            #END add-point

         #----<<sfob020>>----
         #Ctrlp:construct.c.page1.sfob020
         ON ACTION controlp INFIELD sfob020
            #add-point:ON ACTION controlp INFIELD sfob020
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfob020  #顯示到畫面上
            NEXT FIELD sfob020                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfob020
            #add-point:BEFORE FIELD sfob020
            {<point name="construct.b.page1.sfob020" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob020

            #add-point:AFTER FIELD sfob020
            {<point name="construct.a.page1.sfob020" />}
            #END add-point


         #----<<sfob021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob021
            #add-point:BEFORE FIELD sfob021
            {<point name="construct.b.page1.sfob021" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob021

            #add-point:AFTER FIELD sfob021
            {<point name="construct.a.page1.sfob021" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob021
#         ON ACTION controlp INFIELD sfob021
            #add-point:ON ACTION controlp INFIELD sfob021
            {<point name="construct.c.page1.sfob021" />}
            #END add-point

         #----<<sfob022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob022
            #add-point:BEFORE FIELD sfob022
            {<point name="construct.b.page1.sfob022" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob022

            #add-point:AFTER FIELD sfob022
            {<point name="construct.a.page1.sfob022" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob022
#         ON ACTION controlp INFIELD sfob022
            #add-point:ON ACTION controlp INFIELD sfob022
            {<point name="construct.c.page1.sfob022" />}
            #END add-point

         #----<<sfob055>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob055
            #add-point:BEFORE FIELD sfob055
            {<point name="construct.b.page1.sfob055" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob055

            #add-point:AFTER FIELD sfob055
            {<point name="construct.a.page1.sfob055" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfob055
#         ON ACTION controlp INFIELD sfob055
            #add-point:ON ACTION controlp INFIELD sfob055
            {<point name="construct.c.page1.sfob055" />}
            #END add-point

#---------------------<  Detail: page2  >---------------------
         #----<<sfob027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob027
            #add-point:BEFORE FIELD sfob027
            {<point name="construct.b.page2.sfob027" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob027

            #add-point:AFTER FIELD sfob027
            {<point name="construct.a.page2.sfob027" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob027
#         ON ACTION controlp INFIELD sfob027
            #add-point:ON ACTION controlp INFIELD sfob027
            {<point name="construct.c.page2.sfob027" />}
            #END add-point

         #----<<sfob050>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob050
            #add-point:BEFORE FIELD sfob050
            {<point name="construct.b.page2.sfob050" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob050

            #add-point:AFTER FIELD sfob050
            {<point name="construct.a.page2.sfob050" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob050
#         ON ACTION controlp INFIELD sfob050
            #add-point:ON ACTION controlp INFIELD sfob050
            {<point name="construct.c.page2.sfob050" />}
            #END add-point

         #----<<sfob028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob028
            #add-point:BEFORE FIELD sfob028
            {<point name="construct.b.page2.sfob028" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob028

            #add-point:AFTER FIELD sfob028
            {<point name="construct.a.page2.sfob028" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob028
#         ON ACTION controlp INFIELD sfob028
            #add-point:ON ACTION controlp INFIELD sfob028
            {<point name="construct.c.page2.sfob028" />}
            #END add-point

         #----<<sfob029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob029
            #add-point:BEFORE FIELD sfob029
            {<point name="construct.b.page2.sfob029" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob029

            #add-point:AFTER FIELD sfob029
            {<point name="construct.a.page2.sfob029" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob029
#         ON ACTION controlp INFIELD sfob029
            #add-point:ON ACTION controlp INFIELD sfob029
            {<point name="construct.c.page2.sfob029" />}
            #END add-point

         #----<<sfob030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob030
            #add-point:BEFORE FIELD sfob030
            {<point name="construct.b.page2.sfob030" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob030

            #add-point:AFTER FIELD sfob030
            {<point name="construct.a.page2.sfob030" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob030
#         ON ACTION controlp INFIELD sfob030
            #add-point:ON ACTION controlp INFIELD sfob030
            {<point name="construct.c.page2.sfob030" />}
            #END add-point

         #----<<sfob031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob031
            #add-point:BEFORE FIELD sfob031
            {<point name="construct.b.page2.sfob031" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob031

            #add-point:AFTER FIELD sfob031
            {<point name="construct.a.page2.sfob031" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob031
#         ON ACTION controlp INFIELD sfob031
            #add-point:ON ACTION controlp INFIELD sfob031
            {<point name="construct.c.page2.sfob031" />}
            #END add-point

         #----<<sfob032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob032
            #add-point:BEFORE FIELD sfob032
            {<point name="construct.b.page2.sfob032" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob032

            #add-point:AFTER FIELD sfob032
            {<point name="construct.a.page2.sfob032" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob032
#         ON ACTION controlp INFIELD sfob032
            #add-point:ON ACTION controlp INFIELD sfob032
            {<point name="construct.c.page2.sfob032" />}
            #END add-point

         #----<<sfob033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob033
            #add-point:BEFORE FIELD sfob033
            {<point name="construct.b.page2.sfob033" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob033

            #add-point:AFTER FIELD sfob033
            {<point name="construct.a.page2.sfob033" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob033
#         ON ACTION controlp INFIELD sfob033
            #add-point:ON ACTION controlp INFIELD sfob033
            {<point name="construct.c.page2.sfob033" />}
            #END add-point

         #----<<sfob034>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob034
            #add-point:BEFORE FIELD sfob034
            {<point name="construct.b.page2.sfob034" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob034

            #add-point:AFTER FIELD sfob034
            {<point name="construct.a.page2.sfob034" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob034
#         ON ACTION controlp INFIELD sfob034
            #add-point:ON ACTION controlp INFIELD sfob034
            {<point name="construct.c.page2.sfob034" />}
            #END add-point

         #----<<sfob035>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob035
            #add-point:BEFORE FIELD sfob035
            {<point name="construct.b.page2.sfob035" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob035

            #add-point:AFTER FIELD sfob035
            {<point name="construct.a.page2.sfob035" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob035
#         ON ACTION controlp INFIELD sfob035
            #add-point:ON ACTION controlp INFIELD sfob035
            {<point name="construct.c.page2.sfob035" />}
            #END add-point

         #----<<sfob036>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob036
            #add-point:BEFORE FIELD sfob036
            {<point name="construct.b.page2.sfob036" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob036

            #add-point:AFTER FIELD sfob036
            {<point name="construct.a.page2.sfob036" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob036
#         ON ACTION controlp INFIELD sfob036
            #add-point:ON ACTION controlp INFIELD sfob036
            {<point name="construct.c.page2.sfob036" />}
            #END add-point

         #----<<sfob037>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob037
            #add-point:BEFORE FIELD sfob037
            {<point name="construct.b.page2.sfob037" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob037

            #add-point:AFTER FIELD sfob037
            {<point name="construct.a.page2.sfob037" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob037
#         ON ACTION controlp INFIELD sfob037
            #add-point:ON ACTION controlp INFIELD sfob037
            {<point name="construct.c.page2.sfob037" />}
            #END add-point

         #----<<sfob038>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob038
            #add-point:BEFORE FIELD sfob038
            {<point name="construct.b.page2.sfob038" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob038

            #add-point:AFTER FIELD sfob038
            {<point name="construct.a.page2.sfob038" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob038
#         ON ACTION controlp INFIELD sfob038
            #add-point:ON ACTION controlp INFIELD sfob038
            {<point name="construct.c.page2.sfob038" />}
            #END add-point

         #----<<sfob039>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob039
            #add-point:BEFORE FIELD sfob039
            {<point name="construct.b.page2.sfob039" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob039

            #add-point:AFTER FIELD sfob039
            {<point name="construct.a.page2.sfob039" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob039
#         ON ACTION controlp INFIELD sfob039
            #add-point:ON ACTION controlp INFIELD sfob039
            {<point name="construct.c.page2.sfob039" />}
            #END add-point

         #----<<sfob040>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob040
            #add-point:BEFORE FIELD sfob040
            {<point name="construct.b.page2.sfob040" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob040

            #add-point:AFTER FIELD sfob040
            {<point name="construct.a.page2.sfob040" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob040
#         ON ACTION controlp INFIELD sfob040
            #add-point:ON ACTION controlp INFIELD sfob040
            {<point name="construct.c.page2.sfob040" />}
            #END add-point

         #----<<sfob041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob041
            #add-point:BEFORE FIELD sfob041
            {<point name="construct.b.page2.sfob041" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob041

            #add-point:AFTER FIELD sfob041
            {<point name="construct.a.page2.sfob041" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob041
#         ON ACTION controlp INFIELD sfob041
            #add-point:ON ACTION controlp INFIELD sfob041
            {<point name="construct.c.page2.sfob041" />}
            #END add-point

         #----<<sfob042>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob042
            #add-point:BEFORE FIELD sfob042
            {<point name="construct.b.page2.sfob042" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob042

            #add-point:AFTER FIELD sfob042
            {<point name="construct.a.page2.sfob042" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob042
#         ON ACTION controlp INFIELD sfob042
            #add-point:ON ACTION controlp INFIELD sfob042
            {<point name="construct.c.page2.sfob042" />}
            #END add-point

         #----<<sfob043>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob043
            #add-point:BEFORE FIELD sfob043
            {<point name="construct.b.page2.sfob043" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob043

            #add-point:AFTER FIELD sfob043
            {<point name="construct.a.page2.sfob043" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob043
#         ON ACTION controlp INFIELD sfob043
            #add-point:ON ACTION controlp INFIELD sfob043
            {<point name="construct.c.page2.sfob043" />}
            #END add-point

         #----<<sfob046>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob046
            #add-point:BEFORE FIELD sfob046
            {<point name="construct.b.page2.sfob046" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob046

            #add-point:AFTER FIELD sfob046
            {<point name="construct.a.page2.sfob046" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob046
#         ON ACTION controlp INFIELD sfob046
            #add-point:ON ACTION controlp INFIELD sfob046
            {<point name="construct.c.page2.sfob046" />}
            #END add-point

         #----<<sfob047>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob047
            #add-point:BEFORE FIELD sfob047
            {<point name="construct.b.page2.sfob047" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob047

            #add-point:AFTER FIELD sfob047
            {<point name="construct.a.page2.sfob047" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob047
#         ON ACTION controlp INFIELD sfob047
            #add-point:ON ACTION controlp INFIELD sfob047
            {<point name="construct.c.page2.sfob047" />}
            #END add-point

         #----<<sfob048>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob048
            #add-point:BEFORE FIELD sfob048
            {<point name="construct.b.page2.sfob048" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob048

            #add-point:AFTER FIELD sfob048
            {<point name="construct.a.page2.sfob048" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob048
#         ON ACTION controlp INFIELD sfob048
            #add-point:ON ACTION controlp INFIELD sfob048
            {<point name="construct.c.page2.sfob048" />}
            #END add-point

         #----<<sfob049>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob049
            #add-point:BEFORE FIELD sfob049
            {<point name="construct.b.page2.sfob049" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob049

            #add-point:AFTER FIELD sfob049
            {<point name="construct.a.page2.sfob049" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob049
#         ON ACTION controlp INFIELD sfob049
            #add-point:ON ACTION controlp INFIELD sfob049
            {<point name="construct.c.page2.sfob049" />}
            #END add-point

         #----<<sfob051>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob051
            #add-point:BEFORE FIELD sfob051
            {<point name="construct.b.page2.sfob051" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfob051

            #add-point:AFTER FIELD sfob051
            {<point name="construct.a.page2.sfob051" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfob051
#         ON ACTION controlp INFIELD sfob051
            #add-point:ON ACTION controlp INFIELD sfob051
            {<point name="construct.c.page2.sfob051" />}
            #END add-point



      END CONSTRUCT





      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      {<point name="cs.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:cs段b_dialog
         {<point name="cs.b_dialog"/>}
         #end add-point

      ON ACTION qbe_select     #條件查詢
#saki         CALL cl_qbe_list() RETURNING lc_qbe_sn
#saki         CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
#saki         CALL cl_qbe_save()

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




   #add-point:cs段結束前
   {<point name="cs.after_construct"/>}
   #end add-point

   IF INT_FLAG THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION asft801_filter()










      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point







END FUNCTION

PRIVATE FUNCTION asft801_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}




END FUNCTION

PRIVATE FUNCTION asft801_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   #切換畫面

   LET ls_wc = g_wc

   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_sfob_d.clear()
   CALL g_sfob2_d.clear()



   #add-point:query段other
   {<point name="query.other"/>}
   #end add-point

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL asft801_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL asft801_browser_fill("")
      CALL asft801_fetch("")
      RETURN
   END IF

   #搜尋後資料初始化
   LET g_detail_cnt = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
   LET g_wc_filter = ""
   CALL FGL_SET_ARR_CURR(1)
   LET g_error_show = 1
   CALL asft801_browser_fill("F")

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL asft801_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION asft801_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

   IF g_browser_cnt = 0 THEN
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

         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE

   CALL asft801_browser_fill(p_flag)


   LET g_detail_cnt = g_header_cnt

   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數

   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET g_sfoa_m.sfoadocno = g_browser[g_current_idx].b_sfoadocno
   LET g_sfoa_m.sfoa001 = g_browser[g_current_idx].b_sfoa001
   LET g_sfoa_m.sfoa900 = g_browser[g_current_idx].b_sfoa900


   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE sfoadocno,sfoa002,sfoa001,sfoa005,sfoa003,sfoa004,sfoasite,sfoastus,sfoa900,sfoa902,sfoa905,sfoa906,
     sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,sfoacnfdt
 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa003,g_sfoa_m.sfoa004,
     g_sfoa_m.sfoasite,g_sfoa_m.sfoastus,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa906,
     g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,
     g_sfoa_m.sfoamodid,g_sfoa_m.sfoamoddt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt
 FROM sfoa_t
 WHERE sfoaent = g_enterprise AND sfoadocno = g_sfoa_m.sfoadocno AND sfoa001 = g_sfoa_m.sfoa001
   AND sfoa900 = g_sfoa_m.sfoa900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sfoa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_sfoa_m.* TO NULL
      RETURN
   END IF

   #add-point:fetch段action控制
   IF g_sfoa_m.sfoastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   {<point name="fetch.action_control"/>}
   #end add-point



   #add-point:fetch結束前
   {<point name="fetch.after" />}
   #end add-point

   #LET g_data_owner =
   #LET g_data_group =

   #重新顯示
   CALL asft801_show()

END FUNCTION

PRIVATE FUNCTION asft801_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
    DEFINE l_sql     STRING    #170123-00041#1---add
   {<point name="modify.define"/>}
   #end add-point

   IF g_sfoa_m.sfoadocno IS NULL
   OR g_sfoa_m.sfoa001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE sfoadocno,sfoa002,sfoa001,sfoa005,sfoa003,sfoa004,sfoasite,sfoastus,sfoa900,sfoa902,sfoa905,sfoa906,
     sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,sfoacnfdt
 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa003,g_sfoa_m.sfoa004,
     g_sfoa_m.sfoasite,g_sfoa_m.sfoastus,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa906,
     g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,
     g_sfoa_m.sfoamodid,g_sfoa_m.sfoamoddt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt
     FROM sfoa_t
 WHERE sfoaent = g_enterprise AND sfoadocno = g_sfoa_m.sfoadocno AND sfoa001 = g_sfoa_m.sfoa001
   AND sfoasite = g_site AND sfoa900 = g_sfoa_m.sfoa900
 
   ERROR ""

   LET g_sfoadocno_t = g_sfoa_m.sfoadocno
   LET g_sfoa001_t = g_sfoa_m.sfoa001
   LET g_sfoa900_t = g_sfoa_m.sfoa900

   CALL s_transaction_begin()

   OPEN asft801_cl USING g_enterprise,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft801_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

##170123-00041#1---add----str 
   LET l_sql = "SELECT sfoadocno,sfoa002,'','','','','','','',sfoastus,sfoa001,sfoa005,'','','',sfoa003,'','','','',sfoa004,'','','',sfoasite,'','',sfoa900,sfoa902,sfoa905,'',sfoa906,",
                      " sfoaownid,'',sfoaowndp,'',sfoacrtid,'',sfoacrtdp,'',sfoacrtdt,sfoamodid,'',sfoamoddt,sfoacnfid,'',sfoacnfdt   FROM sfoa_t",
                      " WHERE sfoaent=? AND sfoasite='",g_site,"' AND sfoadocno=? AND sfoa001=? AND sfoa900=? "
   PREPARE asft801_referesh FROM l_sql                   
   
   EXECUTE asft801_referesh USING g_enterprise,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt
  ##170123-00041#1---add----end
  ##170123-00041#1---mark----str   
#   #鎖住將被更改或取消的資料
#   FETCH asft801_cl INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
#       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
#       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
#       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
#       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
#       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
#       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
#       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
#       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt
  ##170123-00041#1---mark----end
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfoa_m.sfoadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161221-00052#1-S
   #IF g_sfoa_m.sfoastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'apm-00035'
   #   LET g_errparam.extend = g_sfoa_m.sfoastus
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE asft801_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #161221-00052#1-E

   CALL asft801_show()
   WHILE TRUE
      LET g_sfoadocno_t = g_sfoa_m.sfoadocno
      LET g_sfoa001_t = g_sfoa_m.sfoa001
      LET g_sfoa900_t = g_sfoa_m.sfoa900


      #寫入修改者/修改日期資訊(單頭)
      LET g_sfoa_m.sfoamodid = g_user
      LET g_sfoa_m.sfoamoddt = cl_get_current()

      #add-point:modify段修改前
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_sfoa_m.sfoastus MATCHES "[DR]" THEN
         LET g_sfoa_m.sfoastus = "N"
      END IF
      {<point name="modify.before_input"/>}
      #end add-point

      CALL asft801_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_sfoa_m.* = g_sfoa_m_t.*
         CALL asft801_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_sfoa_m.sfoadocno != g_sfoadocno_t
      OR g_sfoa_m.sfoa001 != g_sfoa001_t
      OR g_sfoa_m.sfoa900 != g_sfoa900_t


      THEN
         CALL s_transaction_begin()

         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update" mark="Y"/>}
         #end add-point

         #更新單身key值
         UPDATE sfob_t SET sfobdocno = g_sfoa_m.sfoadocno
                                      ,sfob001 = g_sfoa_m.sfoa001
                                      ,sfob900 = g_sfoa_m.sfoa900

          WHERE sfobent = g_enterprise AND sfobdocno = g_sfoadocno_t
            AND sfob001 = g_sfoa001_t
            AND sfob900 = g_sfoa900_t


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "sfob_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfob_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update"/>}
         #end add-point





         #UPDATE 多語言table key值




         CALL s_transaction_end('Y','0')
      END IF

      EXIT WHILE
   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_sfoa_m.sfoadocno,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE asft801_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_sfoa_m.sfoadocno,'U')

END FUNCTION

PRIVATE FUNCTION asft801_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_success LIKE type_t.num5
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point

   
   
   
   LET g_sfoa_m_t.* = g_sfoa_m.*      #保存單頭舊值

   IF g_bfill = "Y" THEN
      CALL asft801_b_fill() #單身填充
      CALL asft801_b_fill2('0') #單身填充
   END IF

   #帶出公用欄位reference值


   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:show段reference
   {<point name="show.head.reference"/>}
   #end add-point
   
   CALL asft801_desc()
   #將資料輸出到畫面上
   DISPLAY BY NAME g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_sfoa_m.sfoastus
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")

         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed_irregular.png")

         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")

         WHEN "M"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/costing_closed.png")

         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")

         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")

         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")

         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")


		
      END CASE



   #讀入ref值(單身)
   FOR l_ac = 1 TO g_sfob_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob009_desc

            CALL asft801_sfob011_ref(g_sfob_d[l_ac].sfob011) RETURNING g_sfob_d[l_ac].sfob011_desc  #160822-00017#1

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob013_desc
            
            IF NOT cl_null(g_sfob_d[l_ac].sfob002) THEN
               CALL s_aooi360_sel('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,'','','','','','','4') RETURNING l_success,g_sfob_d[l_ac].ooff013
            END IF
         {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_sfob2_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
      {<point name="show.body2.reference"/>}
      #end add-point
   END FOR





   #add-point:show段other
   {<point name="show.other"/>}
   #end add-point

   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   CALL asft801_detail_show()

   #add-point:show段之後
   {<point name="show.after"/>}

   IF g_detail_idx > 0 THEN
      CALL s_hint_show('sfoe_t','sfob_t','sfcb_t',g_sfoa_m.sfoadocno,g_sfoa_m.sfoa900,g_sfoa_m.sfoa001,g_sfob2_d[g_detail_idx].sfob002,0)
   END IF
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_detail_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   {</Local define>}
   #add-point:detail_show段define
   {<point name="detail_show.define"/>}
   #end add-point

   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point

   LET l_ac_t = l_ac

   LET l_ac = l_ac_t

   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE sfoa_t.sfoadocno
   DEFINE l_oldno     LIKE sfoa_t.sfoadocno
   DEFINE l_newno02     LIKE sfoa_t.sfoa001
   DEFINE l_oldno02     LIKE sfoa_t.sfoa001


   DEFINE l_master    RECORD LIKE sfoa_t.*
   DEFINE l_detail    RECORD LIKE sfob_t.*


   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面

   IF g_sfoa_m.sfoadocno IS NULL
   OR g_sfoa_m.sfoa001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_sfoadocno_t = g_sfoa_m.sfoadocno
   LET g_sfoa001_t = g_sfoa_m.sfoa001
   LET g_sfoa900_t = g_sfoa_m.sfoa900


   LET g_sfoa_m.sfoadocno = ""
   LET g_sfoa_m.sfoa001 = ""



   CALL asft801_set_entry('a')
   CALL asft801_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

   #公用欄位給予預設值


   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point

   CALL asft801_input("r")



   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " sfoadocno = '", g_sfoa_m.sfoadocno CLIPPED, "' "
              ," AND sfoa001 = '", g_sfoa_m.sfoa001 CLIPPED, "' "


              , ") "

   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sfob_t.*


   {</Local define>}
   #add-point:delete段define
   {<point name="detail_reproduce.define"/>}
   #end add-point

   CALL s_transaction_begin()

   LET ld_date = cl_get_current()

   DROP TABLE asft801_detail

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.table1.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE asft801_detail AS ",
                "SELECT * FROM sfob_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asft801_detail SELECT * FROM sfob_t
                                         WHERE sfobent = g_enterprise AND sfobdocno = g_sfoadocno_t
                                         AND sfob001 = g_sfoa001_t
                                         AND sfob900 = g_sfoa900_t


   #將key修正為調整後
   UPDATE asft801_detail
      #更新key欄位
      SET sfobdocno = g_sfoa_m.sfoadocno
          , sfob001 = g_sfoa_m.sfoa001
          , sfob900 = g_sfoa_m.sfoa900

      #更新共用欄位



   #將資料塞回原table
   INSERT INTO sfob_t SELECT * FROM asft801_detail

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #add-point:單身複製中1
   {<point name="detail_reproduce.body.table1.m_insert"/>}
   #end add-point

   #刪除TEMP TABLE
   DROP TABLE asft801_detail

   #add-point:單身複製後1
   {<point name="detail_reproduce.body.table1.a_insert"/>}
   #end add-point





   #多語言複製段落
      #此段落由子樣板a38產生
   DROP TABLE asft801_detail_lang

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.lang0.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE asft801_detail_lang AS ",
                "SELECT * FROM ooff_t "
   PREPARE repro_ooff_t FROM ls_sql
   EXECUTE repro_ooff_t
   FREE repro_ooff_t

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asft801_detail_lang SELECT * FROM ooff_t
                                             WHERE ooffent = g_enterprise AND ooff001 = g_sfoadocno_t
                                             AND ooff002 = g_sfoa001_t


   #將key修正為調整後
   UPDATE asft801_detail_lang
      #更新key欄位
      SET ooff001 = g_sfoa_m.sfoadocno
          , ooff002 = g_sfoa_m.sfoa001


   #將資料塞回原table
   INSERT INTO ooff_t SELECT * FROM asft801_detail_lang

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #add-point:單身複製中1
   {<point name="detail_reproduce.lang0.table1.m_insert"/>}
   #end add-point

   #刪除TEMP TABLE
   DROP TABLE asft801_detail_lang

   #add-point:單身複製後1
   {<point name="detail_reproduce.lang0.table1.a_insert"/>}
   #end add-point



   CALL s_transaction_end('Y','0')

   #已新增完, 調整資料內容(修改時使用)
   LET g_sfoadocno_t = g_sfoa_m.sfoadocno
   LET g_sfoa001_t = g_sfoa_m.sfoa001
   LET g_sfoa900_t = g_sfoa_m.sfoa900


   DROP TABLE asft801_detail

END FUNCTION

PRIVATE FUNCTION asft801_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   DEFINE l_success  LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   CALL g_sfob_d.clear()    #g_sfob_d 單頭及單身
   CALL g_sfob2_d.clear()



   #add-point:b_fill段sql_before
   {<point name="b_fill.sql_before"/>}
   #end add-point

   #判斷是否填充
   IF asft801_fill_chk(1) THEN

      LET g_sql = "SELECT  UNIQUE sfob002,sfob003,'',sfob004,sfob005,sfob006,sfob007,'',sfob008,sfob009,",
          "'',sfob010,sfob011,'',sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012,sfob013,'',sfob014,",
          "sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,'',sfob053,sfob054,sfob020,'',sfob021,sfob022,sfob055,",
          "'',sfob901,sfob905,'',sfob906,",
          "sfob002,sfob027,sfob050,sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,",
          "sfob037,sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob046,sfob047,sfob048,sfob049,sfob051 FROM sfob_t",

                  " INNER JOIN sfoa_t ON sfoaent = sfobent AND sfoadocno = sfobdocno AND sfoa001 = sfob001 ",
                  " WHERE sfobent=? AND sfobdocno=? AND sfob001=? AND sfob900=? AND sfobsite='",g_site,"'"
      #add-point:b_fill段sql_before
      {<point name="b_fill.body.fill_sql"/>}
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF

      #子單身的WC


      LET g_sql = g_sql, " ORDER BY sfob_t.sfob002"

      #add-point:單身填充控制
      {<point name="b_fill.sql"/>}
      #end add-point

      PREPARE asft801_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR asft801_pb

      LET g_cnt = l_ac
      LET l_ac = 1

      OPEN b_fill_cs USING g_enterprise,g_sfoa_m.sfoadocno
                                               ,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900



      FOREACH b_fill_cs INTO g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob003_desc,
          g_sfob_d[l_ac].sfob004,g_sfob_d[l_ac].sfob005,g_sfob_d[l_ac].sfob006,g_sfob_d[l_ac].sfob007,
          g_sfob_d[l_ac].sfob007_desc,g_sfob_d[l_ac].sfob008,g_sfob_d[l_ac].sfob009,g_sfob_d[l_ac].sfob009_desc,
          g_sfob_d[l_ac].sfob010,g_sfob_d[l_ac].sfob011,g_sfob_d[l_ac].sfob011_desc,g_sfob_d[l_ac].sfob023,
          g_sfob_d[l_ac].sfob024,g_sfob_d[l_ac].sfob025,g_sfob_d[l_ac].sfob026,g_sfob_d[l_ac].sfob044,
          g_sfob_d[l_ac].sfob045,g_sfob_d[l_ac].sfob012,g_sfob_d[l_ac].sfob013,g_sfob_d[l_ac].sfob013_desc,
          g_sfob_d[l_ac].sfob014,g_sfob_d[l_ac].sfob015,g_sfob_d[l_ac].sfob016,g_sfob_d[l_ac].sfob017,
          g_sfob_d[l_ac].sfob018,g_sfob_d[l_ac].sfob019,g_sfob_d[l_ac].sfob052,g_sfob_d[l_ac].sfob052_desc,g_sfob_d[l_ac].sfob053,
          g_sfob_d[l_ac].sfob054,g_sfob_d[l_ac].sfob020,g_sfob_d[l_ac].sfob020_desc,g_sfob_d[l_ac].sfob021,g_sfob_d[l_ac].sfob022,
          g_sfob_d[l_ac].sfob055,g_sfob_d[l_ac].ooff013,g_sfob_d[l_ac].sfob901,g_sfob_d[l_ac].sfob905,g_sfob_d[l_ac].sfob905_desc,g_sfob_d[l_ac].sfob906,g_sfob2_d[l_ac].sfob002,g_sfob2_d[l_ac].sfob027,
          g_sfob2_d[l_ac].sfob050,g_sfob2_d[l_ac].sfob028,g_sfob2_d[l_ac].sfob029,g_sfob2_d[l_ac].sfob030,
          g_sfob2_d[l_ac].sfob031,g_sfob2_d[l_ac].sfob032,g_sfob2_d[l_ac].sfob033,g_sfob2_d[l_ac].sfob034,
          g_sfob2_d[l_ac].sfob035,g_sfob2_d[l_ac].sfob036,g_sfob2_d[l_ac].sfob037,g_sfob2_d[l_ac].sfob038,
          g_sfob2_d[l_ac].sfob039,g_sfob2_d[l_ac].sfob040,g_sfob2_d[l_ac].sfob041,g_sfob2_d[l_ac].sfob042,
          g_sfob2_d[l_ac].sfob043,g_sfob2_d[l_ac].sfob046,g_sfob2_d[l_ac].sfob047,g_sfob2_d[l_ac].sfob048,
          g_sfob2_d[l_ac].sfob049,g_sfob2_d[l_ac].sfob051
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         #add-point:b_fill段資料填充
         {<point name="b_fill.fill"/>}
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob009_desc

            CALL asft801_sfob011_ref(g_sfob_d[l_ac].sfob011) RETURNING g_sfob_d[l_ac].sfob011_desc  #160822-00017#1

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob013_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob052
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob052_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob052_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob020_desc

            IF NOT cl_null(g_sfob_d[l_ac].sfob002) THEN
               CALL s_aooi360_sel('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,'','','','','','','4') RETURNING l_success,g_sfob_d[l_ac].ooff013
            END IF          {#ADP版次:1#}
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob905
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob905_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob905_desc
            
            CALL asft801_sfob_color()
         #end add-point

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

      END FOREACH
      LET g_error_show = 0

   END IF



   #add-point:browser_fill段其他table處理
   {<point name="browser_fill.other_fill"/>}
   #end add-point

   CALL g_sfob_d.deleteElement(g_sfob_d.getLength())
   CALL g_sfob2_d.deleteElement(g_sfob2_d.getLength())




   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE asft801_pb


END FUNCTION

PRIVATE FUNCTION asft801_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete" mark="Y"/>}
      #end add-point
      DELETE FROM sfob_t
       WHERE sfobent = g_enterprise AND
         sfobdocno = ps_keys_bak[1] AND sfob001 = ps_keys_bak[2] AND sfob002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete"/>}
      #end add-point
   END IF





   #add-point:delete_b段other
   {<point name="delete_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      {<point name="insert_b.before_insert" mark="Y"/>}
      #end add-point
      INSERT INTO sfob_t
                  (sfobent,
                   sfobdocno,sfob001,sfob900,
                   sfob002,sfobsite
                   ,sfob003,sfob004,sfob005,sfob006,sfob007,sfob008,sfob009,sfob010,sfob011,sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012,sfob013,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055,sfob901,sfob905,sfob906,sfob902,sfob027,sfob050,sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,sfob037,sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob046,sfob047,sfob048,sfob049,sfob051)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],g_site
                   ,g_sfob_d[g_detail_idx].sfob003,g_sfob_d[g_detail_idx].sfob004,g_sfob_d[g_detail_idx].sfob005,
                       g_sfob_d[g_detail_idx].sfob006,g_sfob_d[g_detail_idx].sfob007,g_sfob_d[g_detail_idx].sfob008,
                       g_sfob_d[g_detail_idx].sfob009,g_sfob_d[g_detail_idx].sfob010,g_sfob_d[g_detail_idx].sfob011,
                       g_sfob_d[g_detail_idx].sfob023,g_sfob_d[g_detail_idx].sfob024,g_sfob_d[g_detail_idx].sfob025,
                       g_sfob_d[g_detail_idx].sfob026,g_sfob_d[g_detail_idx].sfob044,g_sfob_d[g_detail_idx].sfob045,
                       g_sfob_d[g_detail_idx].sfob012,g_sfob_d[g_detail_idx].sfob013,g_sfob_d[g_detail_idx].sfob014,
                       g_sfob_d[g_detail_idx].sfob015,g_sfob_d[g_detail_idx].sfob016,g_sfob_d[g_detail_idx].sfob017,
                       g_sfob_d[g_detail_idx].sfob018,g_sfob_d[g_detail_idx].sfob019,g_sfob_d[g_detail_idx].sfob052,
                       g_sfob_d[g_detail_idx].sfob053,g_sfob_d[g_detail_idx].sfob054,g_sfob_d[g_detail_idx].sfob020,
                       g_sfob_d[g_detail_idx].sfob021,g_sfob_d[g_detail_idx].sfob022,g_sfob_d[g_detail_idx].sfob055,
                       g_sfob_d[g_detail_idx].sfob901,g_sfob_d[g_detail_idx].sfob905,g_sfob_d[g_detail_idx].sfob906,g_sfob_d[g_detail_idx].sfob902,
                       g_sfob2_d[g_detail_idx].sfob027,g_sfob2_d[g_detail_idx].sfob050,g_sfob2_d[g_detail_idx].sfob028,
                       g_sfob2_d[g_detail_idx].sfob029,g_sfob2_d[g_detail_idx].sfob030,g_sfob2_d[g_detail_idx].sfob031,
                       g_sfob2_d[g_detail_idx].sfob032,g_sfob2_d[g_detail_idx].sfob033,g_sfob2_d[g_detail_idx].sfob034,
                       g_sfob2_d[g_detail_idx].sfob035,g_sfob2_d[g_detail_idx].sfob036,g_sfob2_d[g_detail_idx].sfob037,
                       g_sfob2_d[g_detail_idx].sfob038,g_sfob2_d[g_detail_idx].sfob039,g_sfob2_d[g_detail_idx].sfob040,
                       g_sfob2_d[g_detail_idx].sfob041,g_sfob2_d[g_detail_idx].sfob042,g_sfob2_d[g_detail_idx].sfob043,
                       g_sfob2_d[g_detail_idx].sfob046,g_sfob2_d[g_detail_idx].sfob047,g_sfob2_d[g_detail_idx].sfob048,
                       g_sfob2_d[g_detail_idx].sfob049,g_sfob2_d[g_detail_idx].sfob051)
      #add-point:insert_b段資料新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sfob_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      {<point name="insert_b.after_insert"/>}
      #end add-point
   END IF





   #add-point:insert_b段other
   {<point name="insert_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10        #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
   #end add-point

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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sfob_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.before_update" mark="Y"/>}
      #end add-point
      UPDATE sfob_t
         SET (sfobdocno,sfob001,
              sfob002
              ,sfob003,sfob004,sfob005,sfob006,sfob007,sfob008,sfob009,sfob010,sfob011,sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012,sfob013,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055,sfob027,sfob050,sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,sfob037,sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob046,sfob047,sfob048,sfob049,sfob051)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_sfob_d[g_detail_idx].sfob003,g_sfob_d[g_detail_idx].sfob004,g_sfob_d[g_detail_idx].sfob005,
                  g_sfob_d[g_detail_idx].sfob006,g_sfob_d[g_detail_idx].sfob007,g_sfob_d[g_detail_idx].sfob008,
                  g_sfob_d[g_detail_idx].sfob009,g_sfob_d[g_detail_idx].sfob010,g_sfob_d[g_detail_idx].sfob011,
                  g_sfob_d[g_detail_idx].sfob023,g_sfob_d[g_detail_idx].sfob024,g_sfob_d[g_detail_idx].sfob025,
                  g_sfob_d[g_detail_idx].sfob026,g_sfob_d[g_detail_idx].sfob044,g_sfob_d[g_detail_idx].sfob045,
                  g_sfob_d[g_detail_idx].sfob012,g_sfob_d[g_detail_idx].sfob013,g_sfob_d[g_detail_idx].sfob014,
                  g_sfob_d[g_detail_idx].sfob015,g_sfob_d[g_detail_idx].sfob016,g_sfob_d[g_detail_idx].sfob017,
                  g_sfob_d[g_detail_idx].sfob018,g_sfob_d[g_detail_idx].sfob019,g_sfob_d[g_detail_idx].sfob052,
                  g_sfob_d[g_detail_idx].sfob053,g_sfob_d[g_detail_idx].sfob054,g_sfob_d[g_detail_idx].sfob020,
                  g_sfob_d[g_detail_idx].sfob021,g_sfob_d[g_detail_idx].sfob022,g_sfob_d[g_detail_idx].sfob055,
                  g_sfob2_d[g_detail_idx].sfob027,g_sfob2_d[g_detail_idx].sfob050,g_sfob2_d[g_detail_idx].sfob028,
                  g_sfob2_d[g_detail_idx].sfob029,g_sfob2_d[g_detail_idx].sfob030,g_sfob2_d[g_detail_idx].sfob031,
                  g_sfob2_d[g_detail_idx].sfob032,g_sfob2_d[g_detail_idx].sfob033,g_sfob2_d[g_detail_idx].sfob034,
                  g_sfob2_d[g_detail_idx].sfob035,g_sfob2_d[g_detail_idx].sfob036,g_sfob2_d[g_detail_idx].sfob037,
                  g_sfob2_d[g_detail_idx].sfob038,g_sfob2_d[g_detail_idx].sfob039,g_sfob2_d[g_detail_idx].sfob040,
                  g_sfob2_d[g_detail_idx].sfob041,g_sfob2_d[g_detail_idx].sfob042,g_sfob2_d[g_detail_idx].sfob043,
                  g_sfob2_d[g_detail_idx].sfob046,g_sfob2_d[g_detail_idx].sfob047,g_sfob2_d[g_detail_idx].sfob048,
                  g_sfob2_d[g_detail_idx].sfob049,g_sfob2_d[g_detail_idx].sfob051)
         WHERE sfobent = g_enterprise AND sfobdocno = ps_keys_bak[1] AND sfob001 = ps_keys_bak[2] AND sfob002 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "sfob_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "sfob_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.after_update"/>}
      #end add-point
   END IF







   #add-point:update_b段other
   {<point name="update_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("sfoadocno,sfoa001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("sfoadocno,sfoa001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point
   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   CALL cl_set_comp_entry("sfob006,sfob008",TRUE)
   CALL cl_set_comp_entry("sfob003,sfob005,sfob007,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055",TRUE)

   #end add-poin
END FUNCTION

PRIVATE FUNCTION asft801_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE l_n     LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point
   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b"/>}
   IF g_sfob_d[l_ac].sfob005 = '1' THEN
      LET g_sfob_d[l_ac].sfob006=''
      CALL cl_set_comp_entry("sfob006",FALSE)
   END IF
   IF g_sfob_d[l_ac].sfob007 = 'INIT' OR g_sfob_d[l_ac].sfob007 = 'MULT' THEN
      LET g_sfob_d[l_ac].sfob008= 0
      CALL cl_set_comp_entry("sfob008",FALSE)
   END IF
   
   SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
      AND sfob001=g_sfoa_m.sfoa001 AND sfob006=g_sfob_d[l_ac].sfob007
      AND sfob900=g_sfoa_m.sfoa900
   IF l_n > 0 THEN
      LET g_sfob_d[l_ac].sfob008 = 0
      CALL cl_set_comp_entry("sfob008",FALSE)
   END IF
   
   #170405-00021#1-s
   IF g_sfob2_d[l_ac].sfob050 > 0 OR g_sfob2_d[l_ac].sfob046 > 0 OR g_sfob2_d[l_ac].sfob047 > 0 OR g_sfob2_d[l_ac].sfob048 > 0 OR
      g_sfob2_d[l_ac].sfob049 > 0 OR g_sfob2_d[l_ac].sfob033 > 0 OR g_sfob2_d[l_ac].sfob034 > 0 OR g_sfob2_d[l_ac].sfob035 > 0 OR
      g_sfob2_d[l_ac].sfob036 > 0 OR g_sfob2_d[l_ac].sfob037 > 0 OR g_sfob2_d[l_ac].sfob051 > 0 OR g_sfob2_d[l_ac].sfob042 > 0 THEN
      IF g_sfoa_m.sfaa003 = '5' THEN  #模具工单
         LET l_n = 0
         SELECT COUNT(1) INTO l_n FROM sfob_t
          WHERE sfobent = g_enterprise
            AND sfobdocno = g_sfoa_m.sfoadocno
            AND sfob001 = g_sfoa_m.sfoa001
         IF cl_null(l_n) THEN LET l_n = 0 END IF
         IF l_n = 1 THEN
         ELSE
            CALL cl_set_comp_entry("sfob003,sfob005,sfob006,sfob007,sfob008,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055",FALSE)
         END IF
      ELSE
         CALL cl_set_comp_entry("sfob003,sfob005,sfob006,sfob007,sfob008,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055",FALSE)
      END IF
   END IF
   #170405-00021#1-e
   
   #end add-point
END FUNCTION

PRIVATE FUNCTION asft801_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1

   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " sfoadocno = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sfoa001 = '", g_argv[02], "' AND "
   END IF

#160727-00025#3-s
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " sfoa900 = '", g_argv[03], "' AND "
   END IF
#160727-00025#3-e

   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
   {<point name="statechange.define"/>}
   #end add-point

   #add-point:statechange段開始前
   {<point name="statechange.before"/>}
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_sfoa_m.sfoadocno IS NULL
      #key2
      OR g_sfoa_m.sfoa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00003'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()   #160812-00017#4 20160815 add by beckxie
   
   IF g_sfoa_m.sfoastus MATCHES '[XY]' THEN
      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_sfoa_m.sfoastus
            WHEN "D"
               HIDE OPTION "withdraw"
               
            WHEN "N"
               HIDE OPTION "unconfirmed"

            WHEN "R"
               HIDE OPTION "rejection"

            WHEN "W"
               HIDE OPTION "signing"

            WHEN "Y"
               HIDE OPTION "confirmed"

            WHEN "X"
               HIDE OPTION "invalid"
			
         END CASE

      #add-point:menu前
      {<point name="statechange.before_menu"/>}
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_sfoa_m.sfoastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,closed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         #只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

      END CASE
      #end add-point

      ON ACTION unconfirmed
         #modify--151110-00030#1--By shiun--(S)
         LET g_action_choice = "unconfirmed"
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
         #add-point:action控制
         {<point name="statechange.open"/>}
         #end add-point
         END IF
         #modify--151110-00030#1--By shiun--(E)
         EXIT MENU

      ON ACTION rejection
         LET lc_state = "R"
         #add-point:action控制
         {<point name="statechange.rejection"/>}
         #end add-point
         EXIT MENU

      ON ACTION confirmed
         LET lc_state = "Y"
         #add-point:action控制
         {<point name="statechange.confirmed"/>}
         #CALL s_transaction_begin()   #160812-00017#4 20160815 mark by beckxie
         IF NOT s_asft801_confirm_chk(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900) THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT s_asft801_confirm_upd(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900) THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
         #end add-point
         EXIT MENU


	
	  #此段落由子樣板a36產生
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            #161221-00052#1-S
            #CALL asft801_send()
            IF NOT asft801_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asft801_cl
            RETURN
            #161221-00052#1-S
         END IF
         #LET lc_state = 'W'   #161221-00052#1
         EXIT MENU

      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            #161221-00052#1-S
            #CALL asft801_draw_out()
            IF NOT asft801_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asft801_cl
            RETURN
            #161221-00052#1-S
         END IF
         #LET lc_state = 'D'   #161221-00052#1
         EXIT MENU

      ON ACTION invalid
         LET lc_state = "X"
         #add-point:action控制
         
         #end add-point
         EXIT MENU


	
      #add-point:stus控制
      {<point name="statechange.more_control"/>}
      #end add-point
	
   END MENU

   IF (lc_state <> "C"
      AND lc_state <> "D"

      AND lc_state <> "E"

      AND lc_state <> "F"

      AND lc_state <> "M"

      AND lc_state <> "N"

      AND lc_state <> "R"

      AND lc_state <> "W"

      AND lc_state <> "Y"

      AND lc_state <> "X"


      ) OR
      cl_null(lc_state) THEN
      CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
      RETURN
   END IF

   #add-point:stus修改前
   {<point name="statechange.b_update"/>}
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---   
   #end add-point

   UPDATE sfoa_t SET sfoastus = lc_state
    WHERE sfoaent = g_enterprise AND sfoadocno = g_sfoa_m.sfoadocno
      #key2
      AND sfoa001 = g_sfoa_m.sfoa001
      AND sfoa900 = g_sfoa_m.sfoa900

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
   ELSE
      CASE lc_state
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
            
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")

         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")

         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")

         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")


		
      END CASE
      CALL s_transaction_end('Y','0')   #160812-00017#4 20160815 add by beckxie
      LET g_sfoa_m.sfoastus = lc_state
      DISPLAY BY NAME g_sfoa_m.sfoastus
   END IF

   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point

   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_idx_chk()
   #add-point:idx_chk段define
   {<point name="idx_chk.define"/>}
   #end add-point

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sfob_d.getLength() THEN
         LET g_detail_idx = g_sfob_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfob_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfob_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_sfob2_d.getLength() THEN
         LET g_detail_idx = g_sfob2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfob2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfob2_d.getLength() TO FORMONLY.cnt
   END IF



   #add-point:idx_chk段other
   {<point name="idx_chk.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft801_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE ls_chk          LIKE type_t.chr1
   {</Local define>}
   #add-point:b_fill2段define
   {<point name="b_fill2.define"/>}
   #end add-point

   LET li_ac = l_ac



   #add-point:單身填充後
   {<point name="b_fill2.after_fill" />}
   #end add-point

   LET l_ac = li_ac

   CALL asft801_detail_show()

END FUNCTION

PRIVATE FUNCTION asft801_fill_chk(ps_idx)
   {<Local define>}
   DEFINE ps_idx        LIKE type_t.chr10
   {</Local define>}
   #add-point:fill_chk段define
   {<point name="fill_chk.define"/>}
   #end add-point

   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段define
      {<point name="fill_chk.other_chk"/>}
      #end add-point
      RETURN TRUE
   END IF

   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   #根據wc判定是否需要填充


   RETURN FALSE

END FUNCTION

PRIVATE FUNCTION asft801_modify_detail_chk(ps_record)
   {<Local define>}
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   {</Local define>}
   #add-point:modify_detail_chk段define
   {<point name="modify_detail_chk.define"/>}
   #end add-point

   #add-point:modify_detail_chk段開始前
   {<point name="modify_detail_chk.before"/>}
   #end add-point

   CASE ps_record
      WHEN "s_detail1"
         LET ls_return = "sfob002"
      WHEN "s_detail2"
         LET ls_return = "sfob002_2"


      #add-point:modify_detail_chk段自訂page控制
      {<point name="modify_detail_chk.page_control"/>}
      #end add-point
   END CASE

   #add-point:modify_detail_chk段結束前
   {<point name="modify_detail_chk.after"/>}
   #end add-point

   RETURN ls_return

END FUNCTION

PRIVATE FUNCTION asft801_send()
   #add-point:send段define
   DEFINE l_success  LIKE type_t.num5
   {<point name="send.define"/>}
   #end add-point

   IF g_sfoa_m.sfoadocno IS NULL
   OR g_sfoa_m.sfoa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   #重新取得與顯示完整單據資料(最新單據資料)
    SELECT UNIQUE sfoadocno,sfoa002,sfoa001,sfoa005,sfoa003,sfoa004,sfoasite,sfoastus,sfoa900,sfoa902,sfoa905,sfoa906,
     sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,sfoacnfdt
 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa003,g_sfoa_m.sfoa004,
     g_sfoa_m.sfoasite,g_sfoa_m.sfoastus,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa906,
     g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,
     g_sfoa_m.sfoamodid,g_sfoa_m.sfoamoddt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt
 FROM sfoa_t
 WHERE sfoaent = g_enterprise AND sfoadocno = g_sfoa_m.sfoadocno AND sfoa001 = g_sfoa_m.sfoa001
   AND sfoa900 = g_sfoa_m.sfoa900

   ERROR ""

   CALL s_transaction_begin()

   OPEN asft801_cl USING g_enterprise,g_sfoa_m.sfoadocno
                                                       ,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft801_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改的資料
   FETCH asft801_cl INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfoa_m.sfoadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"


   CALL asft801_show()

   #add-point: 提交前的ADP
   CALL s_asft801_confirm_chk(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900) RETURNING l_success
   IF NOT l_success THEN
      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF

   {<point name="send.before_send" />}
   #end add-point

   #公用變數初始化
   CALL cl_bpm_data_init()

   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data()
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_sfoa_m))

   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sfob_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_sfob2_d))


   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功

   #開單失敗
   IF NOT cl_bpm_cli() THEN
      #161221-00052#1-S
      #CLOSE asft801_cl
      #CALL s_transaction_end('N','0')
      #RETURN
      RETURN FALSE
      #161221-00052#1-E
   END IF

   #add-point: 提交後的ADP
   {<point name="send.after_send" />}
   #end add-point

   #完成狀態更新
   CLOSE asft801_cl
   CALL s_transaction_end('Y','0')

   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL asft801_ui_browser_refresh()

   #重新指定此筆單據資料狀態圖片=>送簽中
  # LET g_browser[g_current_row].b_statepic = "stus/16/signing.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asft801_ui_headershow()
   CALL asft801_ui_detailshow()

   RETURN TRUE   #161221-00052#1
END FUNCTION

PRIVATE FUNCTION asft801_draw_out()
   #add-point:draw段define
   {<point name="draw.define"/>}
   #end add-point

   #檢查資料是否存在
   IF g_sfoa_m.sfoadocno IS NULL
   OR g_sfoa_m.sfoa001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   #LOCK主檔資料
   CALL s_transaction_begin()

   #進行BPM抽單功能
   OPEN asft801_cl USING g_enterprise,g_sfoa_m.sfoadocno
                                                       ,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft801_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改的資料
   FETCH asft801_cl INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfoa_m.sfoadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN
      #161221-00052#1-S
      #CLOSE asft801_cl
      #CALL s_transaction_end('N','0')
      #RETURN
      RETURN FALSE
      #161221-00052#1-E
   END IF

   #完成狀態更新
   CLOSE asft801_cl
   CALL s_transaction_end('Y','0')

   #重新指定此筆單據資料狀態圖片=>抽單
 #  LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asft801_ui_headershow()
   CALL asft801_ui_detailshow()

   RETURN TRUE   #161221-00052#1
END FUNCTION
#+ 資料新增
PRIVATE FUNCTION asft801_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sfob_d.clear()   
   CALL g_sfob2_d.clear()  
 
 
 
   INITIALIZE g_sfoa_m.* LIKE sfoa_t.*             #DEFAULT 設定
   
   LET g_sfoadocno_t = NULL
   LET g_sfoa001_t = NULL
   LET g_sfoa900_t = NULL
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
      LET g_sfoa_m.sfoa005 = "1"
      LET g_sfoa_m.sfoastus = 'N'
      LET g_sfoa_m.sfoaownid = g_user
      LET g_sfoa_m.sfoaowndp = g_dept
      LET g_sfoa_m.sfoacrtid = g_user
      LET g_sfoa_m.sfoacrtdp = g_dept 
      LET g_sfoa_m.sfoacrtdt = cl_get_current()
      LET g_sfoa_m.sfoamodid = ""
      LET g_sfoa_m.sfoamoddt = ""
      LET g_sfoa_m.sfoasite = g_site
  
      #add-point:單頭預設值

      #end add-point 
     
      CALL asft801_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         LET INT_FLAG = 0
         LET g_sfoa_m.* = g_sfoa_m_t.*
         CALL asft801_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CALL g_sfob_d.clear()
      CALL g_sfob2_d.clear()
 
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_sfoadocno_t = g_sfoa_m.sfoadocno
   LET g_sfoa001_t = g_sfoa_m.sfoa001
   LET g_sfoa900_t = g_sfoa_m.sfoa900
 
   
   LET g_wc = g_wc,  
              " OR ( sfoaent = '" ||g_enterprise|| "' AND",
              " sfoadocno = '", g_sfoa_m.sfoadocno CLIPPED, "' "
              ," AND sfoa001 = '", g_sfoa_m.sfoa001 CLIPPED, "' "
              ," AND sfoa900 = '", g_sfoa_m.sfoa900 CLIPPED,"'"
 
 
              , ") "
   
   CLOSE asft801_cl
END FUNCTION
#资料输入
PRIVATE FUNCTION asft801_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用         #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用        #170104-00066#2 num5->num10  17/01/06 mod by rainy 
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
   DEFINE  l_sys                 LIKE type_t.num5 
   DEFINE  l_sql                 STRING
   DEFINE  l_flag                LIKE type_t.chr1
   DEFINE  l_j                   LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   {</Local define>}
   #add-point:input段define
   DEFINE  l_flag1               LIKE type_t.chr1
   DEFINE  l_sfaadocdt           LIKE sfaa_t.sfaadocdt
   DEFINE  l_sfodseq             LIKE sfod_t.sfodseq
   DEFINE  l_sfob002_1           LIKE sfob_t.sfob002
   DEFINE  l_sfob002_2           LIKE sfob_t.sfob002
   DEFINE  l_n2                  LIKE type_t.num10 #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE  l_n3                  LIKE type_t.num10 #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE  l_sfocseq             LIKE sfoc_t.sfocseq
   DEFINE  l_flag2               LIKE type_t.chr1     #该行可否修改删除标志位
   #170111-00015#3---add---s
   DEFINE  l_sfoc002             LIKE sfoc_t.sfoc002
   DEFINE  l_sfoc003             LIKE sfoc_t.sfoc004
   DEFINE  l_sfoc004             LIKE sfoc_t.sfoc004
   DEFINE  l_sfob007             LIKE sfob_t.sfob007
   DEFINE  l_sfob008             LIKE sfob_t.sfob008
   DEFINE  l_sfoc901             LIKE sfoc_t.sfoc901
   DEFINE  l_sfoc905             LIKE sfoc_t.sfoc905
   DEFINE  l_sfoc906             LIKE sfoc_t.sfoc906
   DEFINE  l_pre                 LIKE type_t.num10
   DEFINE  l_next                LIKE type_t.num10
   #170111-00015#3---add---e
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT sfob002,sfob003,'',sfob004,sfob005,sfob006,sfob007,'',sfob008,sfob009,", 
       "'',sfob010,sfob011,sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012,sfob013,'',sfob014,", 
       "sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020,sfob021,sfob022,sfob055,", 
       "'',sfob027,sfob050,sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,sfob037,", 
       "sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob046,sfob047,sfob048,sfob049,sfob051",  
       " FROM sfob_t WHERE sfobent=? AND sfobdocno=? AND sfob001=? AND sfob900=? AND sfob002=?  FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asft801_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql

   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asft801_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL asft801_set_no_entry(p_cmd)
 
 #  DISPLAY BY NAME g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa003, 
 #      g_sfoa_m.sfoa004,g_sfoa_m.sfoasite
   DISPLAY BY NAME g_sfoa_m.*
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
#  IF g_sfoa_m.sfoastus != 'N' THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code = 'apm-00035'
#     LET g_errparam.extend = g_sfoa_m.sfoadocno
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#
#     RETURN
#  END IF
#  
#  CALL s_aooi200_get_slip(g_sfoa_m.sfoadocno) RETURNING l_success,l_ooba002
#  IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0023') = 'N' THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code = 'asf-00333'
#     LET g_errparam.extend = g_sfoa_m.sfoadocno
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#
#     RETURN
#  END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
   
      INPUT BY NAME g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfoa002,g_sfoa_m.sfoa003,g_sfoa_m.sfoa004,
                    g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa906
                    ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
         AFTER FIELD sfoadocno
            IF NOT cl_null(g_sfoa_m.sfoadocno) AND (cl_null(g_sfoadocno_t) OR g_sfoa_m.sfoadocno != g_sfoadocno_t) THEN
                             
               #工单单号检查
               IF NOT asft801_sfoadocno_chk() THEN
                  LET g_sfoa_m.sfoadocno = g_sfoadocno_t
                  NEXT FIELD CURRENT
               END IF               
               #根据工单单号带出工单相关资料
               CALL asft801_desc()
               #根据工单单号、RUNCARD 带出制程相关资料
               IF NOT cl_null(g_sfoa_m.sfoa001) THEN
                  IF NOT asft801_gen() THEN
                     LET g_sfoa_m.sfoadocno = g_sfoadocno_t
                     NEXT FIELD CURRENT
                  END IF
                  LET l_flag1 = 'N'
                  EXIT DIALOG
               END IF
            END IF
            
         BEFORE FIELD sfoa001
            IF cl_null(g_sfoa_m.sfoadocno) THEN
               NEXT FIELD sfoadocno
            END IF               
         
         AFTER FIELD sfoa001
            IF NOT cl_null(g_sfoa_m.sfoa001) AND (cl_null(g_sfoa001_t) OR g_sfoa_m.sfoa001 != g_sfoa001_t) THEN
               #工单单号检查
               IF NOT asft801_sfoadocno_chk() THEN
                  LET g_sfoa_m.sfoa001 = g_sfoa001_t
                  NEXT FIELD CURRENT
               END IF
               #根据工单单号带出工单相关资料
               CALL asft801_desc()
               #根据工单单号、RUNCARD 带出制程相关资料
               IF NOT cl_null(g_sfoa_m.sfoadocno) THEN
                  IF NOT asft801_gen() THEN
                     LET g_sfoa_m.sfoa001 = g_sfoa001_t
                     NEXT FIELD CURRENT
                  END IF
                  LET l_flag1 = 'N'
                  EXIT DIALOG
               END IF
            END IF
            
         AFTER FIELD sfoa902
            IF NOT cl_null(g_sfoa_m.sfoa902) AND (cl_null(g_sfoa_m_t.sfoa902) OR g_sfoa_m.sfoa902 != g_sfoa_m_t.sfoa902) THEN
               IF g_sfoa_m.sfoa902 > g_sfoa_m.sfaa019 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00426'
                  LET g_errparam.extend = g_sfoa_m.sfoa902
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sfoa_m.sfoa902 = g_sfoa_m_t.sfoa902
                  NEXT FIELD CURRENT
               END IF
               SELECT sfaadocdt INTO l_sfaadocdt FROM sfaa_t
                WHERE sfaaent = g_enterprise AND sfaasite = g_site 
                  AND sfaadocno = g_sfoa_m.sfoadocno
               IF g_sfoa_m.sfoa902 < l_sfaadocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00426'
                  LET g_errparam.extend = g_sfoa_m.sfoa902
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sfoa_m.sfoa902 = g_sfoa_m_t.sfoa902
                  NEXT FIELD CURRENT
               END IF
            END IF
         
         AFTER FIELD sfoa905
            IF NOT cl_null(g_sfoa_m.sfoa905) AND (cl_null(g_sfoa_m_t.sfoa905) OR g_sfoa_m.sfoa905 != g_sfoa_m_t.sfoa905) THEN
               IF NOT asft801_sfoa905_chk(g_sfoa_m.sfoa905) THEN
                  LET g_sfoa_m.sfoa905 = g_sfoa_m_t.sfoa905
                  CALL asft801_sfoa905_desc(g_sfoa_m.sfoa905) RETURNING g_sfoa_m.sfoa905_desc
                  DISPLAY BY NAME g_sfoa_m.sfoa905_desc
                  NEXT FIELD sfoa905
               END IF
               CALL asft801_sfoa905_desc(g_sfoa_m.sfoa905) RETURNING g_sfoa_m.sfoa905_desc
               DISPLAY BY NAME g_sfoa_m.sfoa905_desc
            END IF
            
         ON ACTION controlp INFIELD sfoadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfoa_m.sfoadocno             #給予default值
            #170120-00050#1-s-mod
#            LET g_qryparam.where = " sfaasite = '",g_site,"' AND (sfaastus = 'Y' OR sfaastus = 'F') AND sfaadocno IN(",
            LET g_qryparam.where = " sfaasite = '",g_site,"' AND (sfaastus = 'Y' OR sfaastus = 'F') AND sfaa061 = 'Y' AND sfaadocno IN(",
            #170120-00050#1-s-mod
                                   "SELECT sfcadocno FROM sfca_t WHERE sfcaent=",g_enterprise," AND sfcasite='",g_site,"'"
                                   
                                   
            IF NOT cl_null(g_sfoa_m.sfoa001) THEN
               LET g_qryparam.where = g_qryparam.where," AND sfca001 = ",g_sfoa_m.sfoa001,")"
            ELSE
               LET g_qryparam.where = g_qryparam.where,")"
            END IF           
            CALL q_sfaadocno_3()                                #呼叫開窗
            LET g_sfoa_m.sfoadocno = g_qryparam.return1              
            DISPLAY g_sfoa_m.sfoadocno TO sfoadocno              #
            NEXT FIELD sfoadocno 
         
         ON ACTION controlp INFIELD sfoa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfoa_m.sfoa001           #給予default值
            IF NOT cl_null(g_sfoa_m.sfoadocno) THEN
               LET g_qryparam.where = " sfcadocno = '",g_sfoa_m.sfoadocno,"' AND sfcasite = '",g_site,"'"
            ELSE
               LET g_qryparam.where = " sfcasite = '",g_site,"'"
            END IF 
            CALL q_sfca001_2()
            LET g_sfoa_m.sfoa001 = g_qryparam.return1              
            DISPLAY g_sfoa_m.sfoa001 TO sfoa001              #
            NEXT FIELD sfoa001
            
            
         ON ACTION controlp INFIELD sfoa905
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfoa_m.sfoa905             #給予default值

            LET g_qryparam.arg1 =g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_sfoa_m.sfoa905 = g_qryparam.return1    
            DISPLAY g_sfoa_m.sfoa905 TO sfoa905    
            NEXT FIELD sfoa905                          #返回原欄位
            
         AFTER INPUT 
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示

            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()

               INSERT INTO sfoa_t (sfoaent,sfoasite,sfoadocno,sfoa001,sfoa002,sfoa003,sfoa004,sfoa005, 
                   sfoa900,sfoa902,sfoa905,sfoa906,sfoastus,sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt, 
                   sfoacnfid,sfoacnfdt)
               VALUES (g_enterprise,g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa002,g_sfoa_m.sfoa003, 
                   g_sfoa_m.sfoa004,g_sfoa_m.sfoa005,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905, 
                   g_sfoa_m.sfoa906,g_sfoa_m.sfoastus,g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid, 
                   g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_sfoa_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               CALL s_transaction_end('Y','0') 
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
               UPDATE sfoa_t SET (sfoadocno,sfoa001,sfoa002,sfoa003,sfoa004,sfoa005, 
                   sfoa900,sfoa902,sfoa905,sfoa906,sfoastus,sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid, 
                   sfoacnfdt) = (g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa002,g_sfoa_m.sfoa003, 
                   g_sfoa_m.sfoa004,g_sfoa_m.sfoa005,g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905, 
                   g_sfoa_m.sfoa906,g_sfoa_m.sfoastus,g_sfoa_m.sfoaownid,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoacrtid, 
                   g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamoddt,g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfdt)
                WHERE sfoaent = g_enterprise AND sfoasite = g_site
                  AND sfoadocno = g_sfoadocno_t AND sfoa001 = g_sfoa001_t
                  AND sfoa900 = g_sfoa900_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sfoa_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_sfoa_m_t)
               LET g_log2 = util.JSON.stringify(g_sfoa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            
            LET g_sfoa001_t = g_sfoa_m.sfoa001
            LET g_sfoadocno_t = g_sfoa_m.sfoadocno
            LET g_sfoa900_t = g_sfoa_m.sfoa900        
      END INPUT
      
      #Page1 預設值產生於此處
      INPUT ARRAY g_sfob_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfob_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asft801_b_fill()
            LET g_rec_b = g_sfob_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asft801_cl USING g_enterprise,g_sfoa_m.sfoadocno
                                                                ,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900
 
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN asft801_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE asft801_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_sfob_d.getLength()
            LET l_flag2 = 'Y'
            
            IF g_rec_b >= l_ac 
               AND g_sfob_d[l_ac].sfob002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sfob_d_t.* = g_sfob_d[l_ac].*  #BACKUP
               LET g_sfob_d_o.* = g_sfob_d[l_ac].*  #BACKUP   #160824-00007#251 by sakura add
               CALL asft801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL asft801_set_no_entry_b(l_cmd)
               IF NOT asft801_lock_b("sfob_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft801_bcl INTO g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob003_desc, 
                      g_sfob_d[l_ac].sfob004,g_sfob_d[l_ac].sfob005,g_sfob_d[l_ac].sfob006,g_sfob_d[l_ac].sfob007, 
                      g_sfob_d[l_ac].sfob007_desc,g_sfob_d[l_ac].sfob008,g_sfob_d[l_ac].sfob009,g_sfob_d[l_ac].sfob009_desc, 
                      g_sfob_d[l_ac].sfob010,g_sfob_d[l_ac].sfob011,g_sfob_d[l_ac].sfob023,g_sfob_d[l_ac].sfob024, 
                      g_sfob_d[l_ac].sfob025,g_sfob_d[l_ac].sfob026,g_sfob_d[l_ac].sfob044,g_sfob_d[l_ac].sfob045, 
                      g_sfob_d[l_ac].sfob012,g_sfob_d[l_ac].sfob013,g_sfob_d[l_ac].sfob013_desc,g_sfob_d[l_ac].sfob014, 
                      g_sfob_d[l_ac].sfob015,g_sfob_d[l_ac].sfob016,g_sfob_d[l_ac].sfob017,g_sfob_d[l_ac].sfob018, 
                      g_sfob_d[l_ac].sfob019,g_sfob_d[l_ac].sfob052,g_sfob_d[l_ac].sfob053,g_sfob_d[l_ac].sfob054, 
                      g_sfob_d[l_ac].sfob020,g_sfob_d[l_ac].sfob021,g_sfob_d[l_ac].sfob022,g_sfob_d[l_ac].sfob055, 
                      g_sfob2_d[l_ac].sfob002,g_sfob2_d[l_ac].sfob027,g_sfob2_d[l_ac].sfob050,g_sfob2_d[l_ac].sfob028, 
                      g_sfob2_d[l_ac].sfob029,g_sfob2_d[l_ac].sfob030,g_sfob2_d[l_ac].sfob031,g_sfob2_d[l_ac].sfob032, 
                      g_sfob2_d[l_ac].sfob033,g_sfob2_d[l_ac].sfob034,g_sfob2_d[l_ac].sfob035,g_sfob2_d[l_ac].sfob036, 
                      g_sfob2_d[l_ac].sfob037,g_sfob2_d[l_ac].sfob038,g_sfob2_d[l_ac].sfob039,g_sfob2_d[l_ac].sfob040, 
                      g_sfob2_d[l_ac].sfob041,g_sfob2_d[l_ac].sfob042,g_sfob2_d[l_ac].sfob043,g_sfob2_d[l_ac].sfob046, 
                      g_sfob2_d[l_ac].sfob047,g_sfob2_d[l_ac].sfob048,g_sfob2_d[l_ac].sfob049,g_sfob2_d[l_ac].sfob051
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_sfob_d_t.sfob002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL asft801_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
               NEXT FIELD sfob002
            END IF
            #add-point:modify段before row
            #修改、刪除限制：
            # a.在制量、待Check in、待Check out數量大於0，該行不可修改或刪除
            # b.良品轉出、重工轉出、當站報廢、當站下線大於0，該行不可修改或刪除
            # c.待Move in、待Move out、待PQC數量大於0，該行不可修改或刪除
            # d.委外完工數量大於0，該行不可修改或刪除
            IF g_sfob2_d[l_ac].sfob050 > 0 OR g_sfob2_d[l_ac].sfob046 > 0 OR g_sfob2_d[l_ac].sfob047 > 0 OR g_sfob2_d[l_ac].sfob048 > 0 OR
               g_sfob2_d[l_ac].sfob049 > 0 OR g_sfob2_d[l_ac].sfob033 > 0 OR g_sfob2_d[l_ac].sfob034 > 0 OR g_sfob2_d[l_ac].sfob035 > 0 OR 
               g_sfob2_d[l_ac].sfob036 > 0 OR g_sfob2_d[l_ac].sfob037 > 0 OR g_sfob2_d[l_ac].sfob051 > 0 OR g_sfob2_d[l_ac].sfob042 > 0 THEN

               #160727-00025#3-s  
               IF g_sfoa_m.sfaa003 = '5' THEN  #模具工单
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM sfob_t
                   WHERE sfobent = g_enterprise
                     AND sfobdocno = g_sfoa_m.sfoadocno
                     AND sfob001 = g_sfoa_m.sfoa001
                     
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 1 THEN
                     LET l_flag2 = 'Y'    
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00440'
                     LET g_errparam.extend = g_sfob_d_t.sfob002
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET l_flag2 = 'N'                  
                  END IF                                   
               ELSE
               #160727-00025#3-e  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00440'
                  LET g_errparam.extend = g_sfob_d_t.sfob002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET l_flag2 = 'N'      
               END IF   #160727-00025
            END IF

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            #170111-00015#3--add-s
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #170111-00015#3--add-e
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sfob_d[l_ac].* TO NULL 
                  LET g_sfob_d[l_ac].sfob005 = "1"
      LET g_sfob_d[l_ac].sfob023 = "0"
      LET g_sfob_d[l_ac].sfob024 = "0"
      LET g_sfob_d[l_ac].sfob025 = "0"
      LET g_sfob_d[l_ac].sfob026 = "0"
      LET g_sfob_d[l_ac].sfob012 = "N"
      LET g_sfob_d[l_ac].sfob014 = "N"
      LET g_sfob_d[l_ac].sfob015 = "N"
      LET g_sfob_d[l_ac].sfob016 = "Y"
      LET g_sfob_d[l_ac].sfob017 = "N"
      LET g_sfob_d[l_ac].sfob018 = "N"
      LET g_sfob_d[l_ac].sfob019 = "N"
      LET g_sfob_d[l_ac].sfob053 = "1"
      LET g_sfob_d[l_ac].sfob054 = "1"
      LET g_sfob_d[l_ac].sfob021 = "1"
      LET g_sfob_d[l_ac].sfob022 = "1"
      LET g_sfob_d[l_ac].sfob055 = "N"
      LET g_sfob_d[l_ac].sfob045 = g_sfoa_m.sfaa020
      LET g_sfob_d[l_ac].sfob020 = g_sfoa_m.sfaa013
      LET g_sfob_d[l_ac].sfob052 = g_sfoa_m.sfaa013
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfob_d[l_ac].sfob052
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfob_d[l_ac].sfob052_desc = '', g_rtn_fields[1] , ''
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfob_d[l_ac].sfob020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfob_d[l_ac].sfob020_desc = '', g_rtn_fields[1] , ''
      LET g_sfob_d[l_ac].sfob901 = '3'
      LET g_sfob_d[l_ac].sfobsite = g_site
      
      LET g_sfob2_d[l_ac].sfob028 = "0"
      LET g_sfob2_d[l_ac].sfob029 = "0"
      LET g_sfob2_d[l_ac].sfob030 = "0"
      LET g_sfob2_d[l_ac].sfob031 = "0"
      LET g_sfob2_d[l_ac].sfob032 = "0"
      LET g_sfob2_d[l_ac].sfob033 = "0"
      LET g_sfob2_d[l_ac].sfob034 = "0"
      LET g_sfob2_d[l_ac].sfob035 = "0"
      LET g_sfob2_d[l_ac].sfob036 = "0"
      LET g_sfob2_d[l_ac].sfob037 = "0"
      LET g_sfob2_d[l_ac].sfob038 = "0"
      LET g_sfob2_d[l_ac].sfob039 = "0"
      LET g_sfob2_d[l_ac].sfob040 = "0"
      LET g_sfob2_d[l_ac].sfob041 = "0"
      LET g_sfob2_d[l_ac].sfob042 = "0"
      LET g_sfob2_d[l_ac].sfob043 = "0"
      LET g_sfob2_d[l_ac].sfob046 = "0"
      LET g_sfob2_d[l_ac].sfob047 = "0"
      LET g_sfob2_d[l_ac].sfob048 = "0"
      LET g_sfob2_d[l_ac].sfob049 = "0"
      LET g_sfob2_d[l_ac].sfob051 = "0"
      LET g_sfob2_d[l_ac].sfob027 = g_sfoa_m.sfoa003 * g_sfob_d[l_ac].sfob021 / g_sfob_d[l_ac].sfob022 
      LET g_sfob2_d[l_ac].sfob050 = 0
      

            LET g_sfob_d_t.* = g_sfob_d[l_ac].*     #新輸入資料
            LET g_sfob_d_o.* = g_sfob_d[l_ac].*     #新輸入資料    #160824-00007#251 by sakura add
            CALL cl_show_fld_cont()
            CALL asft801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL asft801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sfob_d[li_reproduce_target].* = g_sfob_d[li_reproduce].*
               LET g_sfob2_d[li_reproduce_target].* = g_sfob2_d[li_reproduce].*
 
               LET g_sfob_d[li_reproduce_target].sfob002 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
            #170111-00015#3--add-s
            IF cl_null(g_sfob_d[l_ac].sfob002) THEN 
               SELECT MAX(sfob002) INTO l_sfob002_1 FROM sfob_t
                WHERE sfobent = g_enterprise
                  AND sfobsite = g_site
                  AND sfobdocno = g_sfoa_m.sfoadocno
                  AND sfob001 = g_sfoa_m.sfoa001
                  AND sfob900 = g_sfoa_m.sfoa900
                  AND sfob901 != 4
               SELECT MAX(sfob002) INTO l_sfob002_2 FROM sfob_t
                WHERE sfobent = g_enterprise
                  AND sfobsite = g_site
                  AND sfobdocno = g_sfoa_m.sfoadocno
                  AND sfob001 = g_sfoa_m.sfoa001
                  AND sfob900 = g_sfoa_m.sfoa900
               CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
               IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF    
               IF cl_null(l_sfob002_1) THEN 
                  IF NOT cl_null(l_sfob002_2) THEN
                     LET g_sfob_d[l_ac].sfob002 = l_sfob002_2 + l_sys
                  ELSE
                     LET g_sfob_d[l_ac].sfob002 = l_sys 
                  END IF
                  LET g_sfob_d[l_ac].sfob007 = 'INIT'
                  LET g_sfob_d[l_ac].sfob008 = '0'                  
               ELSE
                  IF l_ac > 1 THEN
                     CALL asft801_get_previous() RETURNING l_pre
                     IF l_pre > 0 THEN
                        IF (NOT cl_null(g_sfob_d[l_pre].sfob003)) AND (NOT cl_null(g_sfob_d[l_pre].sfob004)) THEN
                           LET g_sfob_d[l_ac].sfob007 = g_sfob_d[l_pre].sfob003
                           LET g_sfob_d[l_ac].sfob008 = g_sfob_d[l_pre].sfob004
                        ELSE
                           LET g_sfob_d[l_ac].sfob007 = 'INIT'
                           LET g_sfob_d[l_ac].sfob008 = '0'  
                        END IF
                     ELSE
                        LET g_sfob_d[l_ac].sfob007 = 'INIT'
                        LET g_sfob_d[l_ac].sfob008 = '0'  
                     END IF
                  ELSE
                     LET g_sfob_d[l_ac].sfob007 = 'INIT'
                     LET g_sfob_d[l_ac].sfob008 = '0'  
                  END IF
                  
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = '221'
                  LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob007
                  CALL cl_ref_val("v_oocql002")
                  LET g_sfob_d[l_ac].sfob007_desc = g_chkparam.return1
                  DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc                     
                  LET g_sfob_d[l_ac].sfob002 = l_sfob002_2+l_sys
                  LET g_sfob2_d[l_ac].sfob002 = g_sfob_d[l_ac].sfob002
               END IF
               CALL asft801_def_sfob044(g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008)                
            END IF 
            #170111-00015#3--add-e
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
               
            #add-point:單身新增
            #所属同一个替代群组的本站作业，有其中一站5个步骤(move in,check in,报工站,check out,move out)有勾选的话，另外的站，必须至少也勾选一个
            IF g_sfob_d[l_ac].sfob005 = '2' AND NOT cl_null(g_sfob_d[l_ac].sfob006) THEN
               IF g_sfob_d[l_ac].sfob014 = 'N' AND g_sfob_d[l_ac].sfob015 = 'N' AND g_sfob_d[l_ac].sfob016 = 'N' AND g_sfob_d[l_ac].sfob018 = 'N' AND g_sfob_d[l_ac].sfob019 = 'N' THEN
                  SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob005 = '2' AND sfob006 = g_sfob_d[l_ac].sfob006 
                     AND sfob014 ='Y' AND sfob015 = 'Y' AND sfob016 = 'Y' AND sfob018 = 'Y' AND sfob019 = 'Y'
                     AND sfob002 != g_sfob_d[l_ac].sfob002
                     AND sfob900 = g_sfoa_m.sfoa900
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD sfob014
                  END IF
               END IF
               IF g_sfob_d[l_ac].sfob014 = 'Y' AND g_sfob_d[l_ac].sfob015 = 'Y' AND g_sfob_d[l_ac].sfob016 = 'Y' AND g_sfob_d[l_ac].sfob018 = 'Y' AND g_sfob_d[l_ac].sfob019 = 'Y' THEN
                  SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob005 = '2' AND sfob006 = g_sfob_d[l_ac].sfob006 
                     AND sfob014 ='N' AND sfob015 = 'N' AND sfob016 = 'N' AND sfob018 = 'N' AND sfob019 = 'N'
                     AND sfob002 != g_sfob_d[l_ac].sfob002
                     AND sfob900 = g_sfoa_m.sfoa900
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD sfob014
                  END IF
               END IF
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM sfob_t 
             WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
               AND sfob001 = g_sfoa_m.sfoa001
               AND sfob900 = g_sfoa_m.sfoa900
 
               AND sfob002 = g_sfob_d[l_ac].sfob002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfoa_m.sfoadocno
               LET gs_keys[2] = g_sfoa_m.sfoa001
               LET gs_keys[3] = g_sfoa_m.sfoa900
               LET gs_keys[4] = g_sfob_d[g_detail_idx].sfob002
               CALL asft801_insert_b('sfob_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               IF g_sfob_d[l_ac].sfob055 = 'Y' THEN
                  UPDATE sfob_t SET sfob055 = 'N' WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob002 != g_sfob_d[l_ac].sfob002
                     AND sfob900 = g_sfoa_m.sfoa900
               END IF
               
               #新增制程上站作业资料
               IF g_sfob_d[l_ac].sfob007 <> 'MULT' THEN
                  DELETE FROM sfoc_t
                   WHERE sfocent = g_enterprise AND sfocsite = g_site AND sfocdocno=g_sfoa_m.sfoadocno
                     AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc002 = g_sfob_d[l_ac].sfob002
                     AND sfoc900 = g_sfoa_m.sfoa900
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del_sfoc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
                  INSERT INTO sfoc_t(sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc905,sfoc906,sfocseq)                
                     VALUES(g_enterprise,g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob901,g_sfob_d[l_ac].sfob905,g_sfob_d[l_ac].sfob906,1)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins_sfoc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  ELSE
                     IF NOT asft801_upd_sfoc_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,1,g_sfoa_m.sfoa900) THEN 
                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                     END IF
                  END IF
                  
               END IF 
               
               IF NOT cl_null(g_sfob_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,' ',' ',' ',' ',' ',' ','4',g_sfob_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               #170111-00015#3--add-s
               #单身新增时，询问是否预设下站为下一行作业编号（单一线性流程时才询问[插入那一笔的上站和下站原先是互为上下站的时候]）
               #如果点是，原制程为A-B-C，现在B、C之间要拆入D，D的上站为B，则D录入完保存的时候，C的上站要由B变为D，若原本C有多上站，须将multi档中的上站由B变为D
               #原制程为A-B-C，在A之前插入D，则D的上站为INIT，A的上站为D
               IF l_ac > 1 THEN
                  CALL asft801_get_previous() RETURNING l_pre
                  CALL asft801_get_next() RETURNING l_next
                  IF l_pre > 0 AND l_next > 0 THEN
                     IF (NOT cl_null(g_sfob_d[l_pre].sfob003)) AND (NOT cl_null(g_sfob_d[l_pre].sfob004)) AND
                        (NOT cl_null(g_sfob_d[l_next].sfob003)) AND (NOT cl_null(g_sfob_d[l_next].sfob004)) AND
                        g_sfob_d[l_ac].sfob007 = g_sfob_d[l_pre].sfob003 AND g_sfob_d[l_ac].sfob008 = g_sfob_d[l_pre].sfob004 AND
                        g_sfob_d[l_pre].sfob003 = g_sfob_d[l_next].sfob007 AND g_sfob_d[l_pre].sfob004 = g_sfob_d[l_next].sfob008 THEN
                        IF cl_ask_confirm('asf-00846') THEN
                           #更新sfob
                           UPDATE sfob_t SET sfob007 = g_sfob_d[l_ac].sfob003,
                                             sfob008 = g_sfob_d[l_ac].sfob004,
                                             sfob901 = (CASE sfob901 WHEN '3' THEN '3' ELSE '2' END),
                                             sfob902= g_sfob_d[l_ac].sfob902
                                     WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
                                       AND sfob001 = g_sfoa_m.sfoa001 AND sfob900 = g_sfoa_m.sfoa900
                                       AND sfob007 = g_sfob_d[l_pre].sfob003
                                       AND sfob008 = g_sfob_d[l_pre].sfob004
                                       AND sfob002 <> g_sfob_d[l_ac].sfob002
                                       AND sfob901 <> '4'  #排除变更类型是单身删除的
                           IF SQLCA.sqlcode THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = SQLCA.sqlcode
                              LET g_errparam.extend = "sfob_t"
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              CALL s_transaction_end('N','0')
                           END IF        
                           #更新sfoc
                           DECLARE upd_sofc_cs CURSOR FOR
                               SELECT sfocseq,sfoc002,sfoc901 FROM sfoc_t
                                     WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                       AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                       AND sfoc003 = g_sfob_d[l_pre].sfob003
                                       AND sfoc004 = g_sfob_d[l_pre].sfob004
                                       AND sfoc002 <> g_sfob_d[l_ac].sfob002
                                       AND sfoc901 <> '4'  #排除变更类型是单身删除的
                           FOREACH upd_sofc_cs INTO l_sfocseq,l_sfoc002,l_sfoc901  
                              IF l_sfoc901 <> '3' THEN
                                 LET l_sfoc901 = '2'
                              END IF   
                              UPDATE sfoc_t SET sfoc003 = g_sfob_d[l_ac].sfob003,
                                                sfoc004 = g_sfob_d[l_ac].sfob004,
                                                sfoc901 = l_sfoc901,
                                                sfoc902= g_sfob_d[l_ac].sfob902
                                        WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                          AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                          AND sfoc003 = g_sfob_d[l_pre].sfob003
                                          AND sfoc004 = g_sfob_d[l_pre].sfob004
                                          AND sfoc002 = l_sfoc002
                                          AND sfocseq = l_sfocseq
                              IF SQLCA.sqlcode THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = SQLCA.sqlcode
                                 LET g_errparam.extend = "sfoc_t"
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()
                                 CALL s_transaction_end('N','0')
                              END IF               
                              IF NOT asft801_upd_sfoc_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,l_sfoc002,l_sfocseq,g_sfoa_m.sfoa900) THEN 
                                 CALL s_transaction_end('N','0')
                              END IF
                           END FOREACH
                        END IF                        
                     END IF
                  END IF
               ELSE
                  #当前为第一行，且当前站的上一站是INIT,则把原先上站是INIT更新为当前站
                  #更新sfob
                  IF g_sfob_d[l_ac].sfob007 = 'INIT' AND g_sfob_d[l_ac].sfob008 = '0' AND (NOT cl_null(g_sfob_d[l_ac+1].sfob003)) AND (NOT cl_null(g_sfob_d[l_ac+1].sfob004)) THEN
                     IF cl_ask_confirm('asf-00846') THEN
                        UPDATE sfob_t SET sfob007 = g_sfob_d[l_ac].sfob003,
                                          sfob008 = g_sfob_d[l_ac].sfob004,
                                          sfob901 = '2',
                                          sfob902= g_sfob_d[l_ac].sfob902
                                  WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
                                    AND sfob001 = g_sfoa_m.sfoa001 AND sfob900 = g_sfoa_m.sfoa900
                                    AND sfob007 = 'INIT'
                                    AND sfob008 = '0'
                                    AND sfob002 <> g_sfob_d[l_ac].sfob002
                                    AND sfob901 <> '4'
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "sfob_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                        END IF        

                        #更新sfoc
                        DECLARE upd_sofc_cs2 CURSOR FOR
                            SELECT sfocseq,sfoc002,sfoc901 FROM sfoc_t
                                  WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                    AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                    AND sfoc003 = 'INIT'
                                    AND sfoc004 = '0'
                                    AND sfoc002 <> g_sfob_d[l_ac].sfob002
                                    AND sfoc901 <> '4'  #排除变更类型是单身删除的
                        FOREACH upd_sofc_cs2 INTO l_sfocseq,l_sfoc002,l_sfoc901
                           IF l_sfoc901 <> '3' THEN
                              LET l_sfoc901 = '2'
                           END IF   
                           UPDATE sfoc_t SET sfoc003 = g_sfob_d[l_ac].sfob003,
                                             sfoc004 = g_sfob_d[l_ac].sfob004,
                                             sfoc901 = l_sfoc901,
                                             sfoc902= g_sfob_d[l_ac].sfob902
                                     WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                       AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                       AND sfoc003 = 'INIT'
                                       AND sfoc004 = '0'
                                       AND sfoc002 = l_sfoc002
                                       AND sfocseq = l_sfocseq
                           IF SQLCA.sqlcode THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = SQLCA.sqlcode
                              LET g_errparam.extend = "sfoc_t"
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              CALL s_transaction_end('N','0')
                           END IF               
                           IF NOT asft801_upd_sfoc_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,l_sfoc002,l_sfocseq,g_sfoa_m.sfoa900) THEN 
                              CALL s_transaction_end('N','0')
                           END IF
                        END FOREACH
                     END IF                        
                  END IF
               END IF
               #170111-00015#3--add-e
   
               #update 下站作业+制程序
               IF NOT asft801_upd_sfob009() THEN
                  CALL s_transaction_end('N','0')
               END IF     

               #Check in/Check out项目资料
               IF NOT cl_null(g_sfoa_m.sfaa016) AND NOT cl_null(g_sfoa_m.sfaa010) THEN
                  LET l_sql = "INSERT INTO sfod_t(sfodent,sfodsite,sfoddocno,sfod001,sfod002,sfod003,sfod004,sfod005,sfod006,sfod007,sfod008,sfod009,sfod900,sfod901,sfod905,sfod906,sfodseq) ",
                              " SELECT ecbfent,ecbfsite,'",g_sfoa_m.sfoadocno,"',",g_sfoa_m.sfoa001,",ecbf003,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010,ecbf004,",g_sfoa_m.sfoa900,",'",g_sfob_d[l_ac].sfob901,"','",g_sfob_d[l_ac].sfob905,"','",g_sfob_d[l_ac].sfob906,"',ecbfseq*(-1) FROM ecbf_t",
                              "  WHERE ecbfent='",g_enterprise,"' AND ecbfsite='",g_site,"' AND ecbf001='",g_sfoa_m.sfaa010,"' AND ecbf002='",g_sfoa_m.sfaa016,"' AND ecbf003=",g_sfob_d[l_ac].sfob002
                  PREPARE asft801_ins_sfcd_pre FROM l_sql
                  EXECUTE asft801_ins_sfcd_pre 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins_sfod_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  ELSE
                     DECLARE asft801_ins_sfod_cs CURSOR FOR
                      SELECT sfodseq FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site 
                         AND sfoddocno = g_sfoa_m.sfoadocno AND sfod001 = g_sfoa_m.sfoa001 AND sfod900 = g_sfoa_m.sfoa900
                         AND sfod002 = g_sfob_d[l_ac].sfob002
                     FOREACH asft801_ins_sfod_cs INTO l_sfodseq
                        IF NOT asft801_upd_sfod_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,l_sfodseq,g_sfoa_m.sfoa900) THEN 
                           CALL s_transaction_end('N','0')
                           CANCEL INSERT
                        END IF
                     END FOREACH
                  END IF
               END IF
                                    
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_sfob_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfob_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               CALL asft801_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_sfob_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_sfob_d.deleteElement(l_ac)
               NEXT FIELD sfob002
            END IF
         
            IF l_flag2 = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00440'
               LET g_errparam.extend = g_sfob_d_t.sfob002
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CANCEL DELETE      
            END IF
           
            IF g_sfob_d[l_ac].sfob002 IS NOT NULL
 
               THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               
               #add-point:單身刪除前
               #变更类型是已删除的，则不可再次删除
               IF g_sfob_d[l_ac].sfob901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_sfob_d[l_ac].sfob002
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               #170111-00015#3---add---s
               #首站制程删除时，自动将下站工艺的上站作业更新为INIT，上站作业序更新为0
               #如果删除是中间站，A-B-C,删除B后，调整为A-C 
               IF g_sfob_d_t.sfob009 <> 'END' THEN
                  #抓取上一站为当前站的资料
                  DECLARE upd_sfoc CURSOR FOR
                      SELECT sfoc002 FROM sfoc_t WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                                   AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                                   AND sfoc003 = g_sfob_d_t.sfob003
                                                   AND sfoc004 = g_sfob_d_t.sfob004
                                                   AND sfoc901 <> '4'
                  DECLARE sel_sfoc CURSOR FOR
                      SELECT sfocseq,sfoc003,sfoc004 FROM sfoc_t 
                          WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                             AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc002 = g_sfob_d_t.sfob002
                             AND sfoc901 <> '4'
                             
                  FOREACH upd_sfoc INTO l_sfoc002
                     #更新上一站为当前站的资料，变更类型更新为'4':单身删除
                     DECLARE sel_sfoc2 CURSOR FOR
                        SELECT sfocseq FROM sfoc_t WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                                                   AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                                                   AND sfoc003 = g_sfob_d_t.sfob003
                                                   AND sfoc004 = g_sfob_d_t.sfob004
                                                   AND sfoc002 = l_sfoc002
                                                   AND sfoc901 <> '4'
                     FOREACH sel_sfoc2 INTO l_sfocseq
                        IF NOT asft801_sfoc_delete(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,l_sfoc002,l_sfocseq) THEN
                           CANCEL DELETE
                        END IF
                     END FOREACH
                     
                     #抓取当前站的上一站资料
                     FOREACH sel_sfoc INTO l_sfocseq,l_sfoc003,l_sfoc004,l_sfoc901,l_sfoc905,l_sfoc906
                        
                        LET l_sfoc901 = '3'
                        SELECT MAX(sfocseq) INTO l_sfocseq FROM sfoc_t 
                         WHERE sfocent = g_enterprise AND sfocsite = g_site
                           AND sfocdocno = g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                           AND sfoc002 = l_sfoc002 
                        IF cl_null(l_sfocseq) THEN
                           LET l_sfocseq = 1
                        ELSE
                           LET l_sfocseq = l_sfocseq + 1
                        END IF
                        SELECT COUNT(1) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                                  AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002
                                  AND sfoc003 = l_sfoc003 AND sfoc004 = l_sfoc004 AND sfoc901 <> '4'
                        IF l_n = 0 OR cl_null(l_n) THEN
                           INSERT INTO sfoc_t(sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc905,sfoc906,sfocseq)                            
                               VALUES(g_enterprise,g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,l_sfoc002,l_sfoc003,l_sfoc004,g_sfoa_m.sfoa900,l_sfoc901,l_sfoc905,l_sfoc906,l_sfocseq)
                           
                           IF NOT asft801_upd_sfoc_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,l_sfoc002,l_sfocseq,g_sfoa_m.sfoa900) THEN 
                              CANCEL DELETE
                           END IF       
                        END IF                           
                     END FOREACH
                     SELECT COUNT(1) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                        AND sfoc001=g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002 AND sfoc901 <> '4'
                     IF l_n = 0 THEN
                        LET l_sfob007 = ''
                        LET l_sfob008 = ''
                     END IF
                     IF l_n = 1 THEN
                        SELECT sfoc003,sfoc004 INTO l_sfob007,l_sfob008 FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                           AND sfoc001=g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002 AND sfoc901 <> '4'
                     END IF 
                     IF l_n > 1 THEN
                        #判断有多站时，是否有一站是INIT
                        #如有A-B-C,D-C,此时删除D,会把D的上站INIT也写入作为C的上站，需要把这一笔删掉
                        SELECT sfocseq INTO l_sfocseq FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                           AND sfoc001=g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002 AND sfoc003 = 'INIT' AND sfoc004 = '0'
                           AND sfoc901 <> '4'
                        IF NOT asft801_sfoc_delete(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,l_sfoc002,l_sfocseq) THEN
                           CANCEL DELETE
                        END IF   
                        SELECT COUNT(1) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                           AND sfoc001=g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002 AND sfoc901 <> '4'
                        IF l_n = 1 THEN
                           SELECT sfoc003,sfoc004 INTO l_sfob007,l_sfob008 FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                              AND sfoc001=g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc002=l_sfoc002 AND sfoc901 <> '4'
                        ELSE                         
                           LET l_sfob007 = 'MULT'
                           LET l_sfob008 = 0
                        END IF
                     END IF
                     UPDATE sfob_t SET sfob007 = l_sfob007,
                                       sfob008 = l_sfob008
                         WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
                           AND sfob001 = g_sfoa_m.sfoa001 AND sfob900 = g_sfoa_m.sfoa900 AND sfob002 = l_sfoc002 AND sfob901 <> '4'
                           
                  END FOREACH
               END IF
               #170111-00015#3---add---e
               
               IF NOT asft801_return_sfob(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT asft801_sfob_delete(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT asft801_upd_sfob009() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               CALL s_transaction_end('Y','0')
            END IF
               #end add-point 
               
          #    DELETE FROM sfob_t
          #     WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno AND
          #                               sfob001 = g_sfoa_m.sfoa001 AND
          #
          #
          #           sfob002 = g_sfob_d_t.sfob002
          #
          #       
          #    #add-point:單身刪除中
          #    
          #    #end add-point 
          #    
          #    IF SQLCA.sqlcode THEN
          #       INITIALIZE g_errparam TO NULL
          #    LET g_errparam.code = SQLCA.sqlcode
          #    LET g_errparam.extend = "sfob_t"
          #    LET g_errparam.popup = TRUE
          #    CALL cl_err()
          #
          #       CALL s_transaction_end('N','0')
          #       CANCEL DELETE   
          #    ELSE
          #       LET g_rec_b = g_rec_b-1
          #       
          #       #add-point:單身刪除後
          #       DELETE FROM sfoc_t
          #        WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
          #          AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc002 = g_sfob_d_t.sfob002
          #       IF SQLCA.sqlcode THEN
          #          INITIALIZE g_errparam TO NULL
          #          LET g_errparam.code = SQLCA.sqlcode
          #          LET g_errparam.extend = "sfoc_t"
          #          LET g_errparam.popup = TRUE
          #          CALL cl_err()
          #
          #          CALL s_transaction_end('N','0')
          #       END IF
          #       DELETE FROM sfcd_t
          #        WHERE sfcdent = g_enterprise AND sfcddocno = g_sfoa_m.sfoadocno
          #          AND sfcd001 = g_sfoa_m.sfoa001 AND sfcd002 = g_sfob_d_t.sfob002
          #       IF SQLCA.sqlcode THEN
          #          INITIALIZE g_errparam TO NULL
          #          LET g_errparam.code = SQLCA.sqlcode
          #          LET g_errparam.extend = "sfcd_t"
          #          LET g_errparam.popup = TRUE
          #          CALL cl_err()
          #
          #          CALL s_transaction_end('N','0')
          #       END IF
          #       
          #       CALL s_aooi360_del('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,' ',' ',' ',' ',' ',' ','4')
          #          RETURNING l_success
          #       IF NOT l_success THEN
          #          CALL s_transaction_end('N','0')
          #       END IF
          #       #更新下站作业+作业序
          #       IF NOT asft801_upd_sfob009() THEN
          #          CALL s_transaction_end('N','0')
          #       END IF
          #       
          #       #end add-point
          #       CALL s_transaction_end('Y','0')
          #    END IF 
          #    CLOSE asft801_bcl
          #    LET l_count = g_sfob_d.getLength()
          # END IF 
          # 
          #                INITIALIZE gs_keys TO NULL 
          #    LET gs_keys[1] = g_sfoa_m.sfoadocno
          #    LET gs_keys[2] = g_sfoa_m.sfoa001
          #    LET gs_keys[3] = g_sfob_d[g_detail_idx].sfob002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                         #  CALL asft801_delete_b('sfob_t',gs_keys,"'1'")
                           CALL asft801_b_fill()
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sfob002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob002
            #add-point:BEFORE FIELD sfob002
            IF cl_null(g_sfob_d[l_ac].sfob002) THEN 
               SELECT MAX(sfob002) INTO l_sfob002_1 FROM sfob_t
                WHERE sfobent = g_enterprise
                  AND sfobsite = g_site
                  AND sfobdocno = g_sfoa_m.sfoadocno
                  AND sfob001 = g_sfoa_m.sfoa001
                  AND sfob900 = g_sfoa_m.sfoa900
                  AND sfob901 != 4
               SELECT MAX(sfob002) INTO l_sfob002_2 FROM sfob_t
                WHERE sfobent = g_enterprise
                  AND sfobsite = g_site
                  AND sfobdocno = g_sfoa_m.sfoadocno
                  AND sfob001 = g_sfoa_m.sfoa001
                  AND sfob900 = g_sfoa_m.sfoa900
               CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
               IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF    
               IF cl_null(l_sfob002_1) THEN 
                  IF NOT cl_null(l_sfob002_2) THEN
                     LET g_sfob_d[l_ac].sfob002 = l_sfob002_2 + l_sys
                  ELSE
                     LET g_sfob_d[l_ac].sfob002 = l_sys 
                  END IF
                  LET g_sfob_d[l_ac].sfob007 = 'INIT'
                  LET g_sfob_d[l_ac].sfob008 = '0'                  
               ELSE
                  #170111-00015#3--modify-s
                  #单身新增时，当前站的上一站预设为画面上当前行的上一行作业编号、作业序，不以项次来抓资料，若当前是第一行，上一站则预设为INIT
                  #SELECT sfob003,sfob004 INTO g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008 FROM sfob_t
                  # WHERE sfobent = g_enterprise
                  #   AND sfobsite = g_site
                  #   AND sfobdocno = g_sfoa_m.sfoadocno
                  #   AND sfob001 = g_sfoa_m.sfoa001 
                  #   AND sfob900 = g_sfoa_m.sfoa900
                  #   AND sfob002 = l_sfob002_1  
                  IF l_ac > 1 THEN
                     CALL asft801_get_previous() RETURNING l_pre
                     IF l_pre > 0 THEN
                        IF (NOT cl_null(g_sfob_d[l_pre].sfob003)) AND (NOT cl_null(g_sfob_d[l_pre].sfob004)) THEN
                           LET g_sfob_d[l_ac].sfob007 = g_sfob_d[l_pre].sfob003
                           LET g_sfob_d[l_ac].sfob008 = g_sfob_d[l_pre].sfob004
                        ELSE
                           LET g_sfob_d[l_ac].sfob007 = 'INIT'
                           LET g_sfob_d[l_ac].sfob008 = '0'  
                        END IF
                     ELSE
                        LET g_sfob_d[l_ac].sfob007 = 'INIT'
                        LET g_sfob_d[l_ac].sfob008 = '0'  
                     END IF
                  ELSE
                     LET g_sfob_d[l_ac].sfob007 = 'INIT'
                     LET g_sfob_d[l_ac].sfob008 = '0'  
                  END IF
                  #170111-00015#3--modify-e
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = '221'
                  LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob007
                  CALL cl_ref_val("v_oocql002")
                  LET g_sfob_d[l_ac].sfob007_desc = g_chkparam.return1
                  DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc                     
                  LET g_sfob_d[l_ac].sfob002 = l_sfob002_2+l_sys
                  LET g_sfob2_d[l_ac].sfob002 = g_sfob_d[l_ac].sfob002
               END IF
               CALL asft801_def_sfob044(g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008)                
             END IF 
             
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob002
            
            #add-point:AFTER FIELD sfob002
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob002,"0","0","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob002 = g_sfob_d_t.sfob002
               NEXT FIELD sfob002
            END IF

            #此段落由子樣板a05產生
            IF NOT cl_null(g_sfoa_m.sfoadocno) AND NOT cl_null(g_sfoa_m.sfoa001) AND 
               NOT cl_null(g_sfob_d[l_ac].sfob002) THEN
               IF l_cmd = 'a' OR 
                ( l_cmd = 'u' AND (g_sfoa_m.sfoadocno != g_sfoadocno_t OR 
                                   g_sfoa_m.sfoa001 != g_sfoa001_t OR 
                                   g_sfob_d[l_ac].sfob002 != g_sfob_d_t.sfob002)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfob_t WHERE "||"sfobent = '" ||g_enterprise|| "' AND sfobsite = '" ||g_site|| "' AND "||"sfobdocno = '"||g_sfoa_m.sfoadocno ||"' AND "|| "sfob001 = '"||g_sfoa_m.sfoa001 ||"' AND sfob900 = '"||g_sfoa_m.sfoa900||"' AND sfob002 = '"||g_sfob_d[l_ac].sfob002 ||"'",'std-00004',0) THEN
                     LET g_sfob_d[l_ac].sfob002 = g_sfob_d_t.sfob002
                     NEXT FIELD CURRENT
                  END IF
               END IF
              #160113-00001#1 add str 
              #如果修改了項次，先把原本項次的sfoc_t複製成新項次的sfoc_t，然後再把舊項次的sfoc_t刪掉
               IF g_sfob_d[l_ac].sfob002 != g_sfob_d_t.sfob002 THEN
                  INSERT INTO sfoc_t (sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc905,sfoc906,sfocseq)
                  SELECT sfocent,sfocsite,sfocdocno,sfoc001,g_sfob_d[l_ac].sfob002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc905,sfoc906,sfocseq
                    FROM sfoc_t
                   WHERE sfocent = g_enterprise AND sfocsite = g_site
                     AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001 
                     AND sfoc002 = g_sfob_d_t.sfob002
                     AND sfoc900 = g_sfoa_m.sfoa900
                     
                  DELETE FROM sfoc_t
                   WHERE sfocent = g_enterprise AND sfocsite = g_site
                     AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001 
                     AND sfoc002 = g_sfob_d_t.sfob002
                     AND sfoc900 = g_sfoa_m.sfoa900
               END IF
              #160113-00001#1 add end 
            END IF
            LET g_sfob2_d[l_ac].sfob002 = g_sfob_d[l_ac].sfob002
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob002
            #add-point:ON CHANGE sfob002

            #END add-point
 
         #----<<sfob003>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob003
            
            #add-point:AFTER FIELD sfob003
            IF NOT cl_null(g_sfob_d[l_ac].sfob003) THEN
               IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfob_d[l_ac].sfob003<>　g_sfob_d_t.sfob003) THEN
                  IF NOT s_azzi650_chk_exist('221',g_sfob_d[l_ac].sfob003) THEN
                     LET g_sfob_d[l_ac].sfob003 = g_sfob_d_t.sfob003
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = '221'
                     LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob003
                     CALL cl_ref_val("v_oocql002")
                     LET g_sfob_d[l_ac].sfob003_desc = g_chkparam.return1
                     DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc                     
                     NEXT FIELD sfob003
                  END IF
                 #160113-00001#1 add str
                 #若要修改本站作業，需先判斷有沒有報工過，如果有的話則不可修改
                 IF l_cmd = 'u' AND g_sfob_d[l_ac].sfob003 <> g_sfob_d_t.sfob003 THEN
                    LET l_n = 0
                    SELECT COUNT(*) INTO l_n FROM sffb_t
                     WHERE sffbent = g_enterprise
                       AND sffb005 = g_sfoa_m.sfoadocno
                       AND sffb006 = g_sfoa_m.sfoa001 
                       AND sffb007 = g_sfob_d_t.sfob003
                       AND sffbstus <> 'X'
                    IF l_n > 0 THEN  #表示有報工過
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = ''
                       #工單單號+RUN CARD編號+本站作業已存在報工資料，不可異動！
                       LET g_errparam.code   = 'asf-00482'
                       LET g_errparam.popup  = TRUE 
                       CALL cl_err()

                       LET g_sfob_d[l_ac].sfob003 = g_sfob_d_t.sfob003
                       INITIALIZE g_chkparam.* TO NULL
                       LET g_chkparam.arg1 = '221'
                       LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob003
                       CALL cl_ref_val("v_oocql002")
                       LET g_sfob_d[l_ac].sfob003_desc = g_chkparam.return1
                       DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc                     
                       NEXT FIELD sfob003
                    #161108-00023#3-s
                    #ELSE   #表示沒有報工過，可以修改
                    #   #把sffb_t其他項次的上站作業=修改前的本站作業的資料換成新的
                    #   UPDATE sfob_t SET sfob007 = g_sfob_d[l_ac].sfob003
                    #    WHERE sfobent = g_enterprise
                    #      AND sfobdocno = g_sfoa_m.sfoadocno 
                    #      AND sfob001 = g_sfoa_m.sfoa001
                    #      AND sfob002 != g_sfob_d[l_ac].sfob002
                    #      AND sfob007 = g_sfob_d_t.sfob003  #上站作業=修改前的本站作業
                    #      AND sfob008 = g_sfob_d_t.sfob004  #160726-00043#1
                    #      AND sfob900 = g_sfoa_m.sfoa900
                    #  
                    #   #把sfoc_t中上站作業=修改前的本站作業的資料換成新的
                    #   UPDATE sfoc_t SET sfoc003 = g_sfob_d[l_ac].sfob003
                    #    WHERE sfocent = g_enterprise AND sfocsite = g_site
                    #      AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001 
                    #      AND sfoc003 = g_sfob_d_t.sfob003  #上站作業=修改前的本站作業
                    #      AND sfoc004 = g_sfob_d_t.sfob004  #160726-00043#1
                    #      AND sfoc900 = g_sfoa_m.sfoa900
                    #161108-00023#3-e
                    END IF
                 END IF
                 #160113-00001#1 add end
                  CALL asft801_def_sfob004(g_sfob_d[l_ac].sfob003)
                  IF NOT asft801_sfob003(g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004) THEN
                     NEXT FIELD sfob003
                  END IF
               END IF
               
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '221'
               LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob003
               CALL cl_ref_val("v_oocql002")
               LET g_sfob_d[l_ac].sfob003_desc = g_chkparam.return1
               DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob003
            #add-point:BEFORE FIELD sfob003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob003
            #add-point:ON CHANGE sfob003

            #END add-point
 
         #----<<sfob004>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob004
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sfob004
            END IF
           
 
            #add-point:AFTER FIELD sfob004
            IF NOT cl_null(g_sfob_d[l_ac].sfob004) THEN
               IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfob_d[l_ac].sfob004<>　g_sfob_d_t.sfob004) THEN
                  IF NOT asft801_sfob003(g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004) THEN
                     NEXT FIELD sfob003
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob004
            #add-point:BEFORE FIELD sfob004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob004
            #add-point:ON CHANGE sfob004

            #END add-point
 
         #----<<sfob005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob005
            #add-point:BEFORE FIELD sfob005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob005
            
            #add-point:AFTER FIELD sfob005
            CALL asft801_set_entry_b(p_cmd)
            CALL asft801_set_no_entry_b(p_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob005
            #add-point:ON CHANGE sfob005

            #END add-point
 
         #----<<sfob006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob006
            #add-point:BEFORE FIELD sfob006
            CALL asft801_set_entry_b(p_cmd)
            CALL asft801_set_no_entry_b(p_cmd)
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob006
            
            #add-point:AFTER FIELD sfob006
            IF g_sfob_d[l_ac].sfob005 = '2' OR g_sfob_d[l_ac].sfob005 = '3' THEN
               IF cl_null(g_sfob_d[l_ac].sfob006) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00130'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD sfob006
               END IF
            END IF 
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob006
            #add-point:ON CHANGE sfob006

            #END add-point
 
         #----<<sfob007>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob007
            
            #add-point:AFTER FIELD sfob007
            IF NOT cl_null(g_sfob_d[l_ac].sfob007) THEN
              #IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfob_d[l_ac].sfob007<>　g_sfob_d_t.sfob007) THEN   #160824-00007#251 by sakura mark
               IF g_sfob_d[l_ac].sfob007 <> g_sfob_d_o.sfob007 OR cl_null(g_sfob_d_o.sfob007) THEN      #160824-00007#251 by sakura add
                  IF NOT asft801_sfob007() THEN
                     LET g_sfob_d[l_ac].sfob007 = g_sfob_d_o.sfob007   #160824-00007#251 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL asft801_def_sfob044(g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008)
               END IF
               IF g_sfob_d[l_ac].sfob007 = 'MULT' THEN
                  SELECT COUNT(*) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                     AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
                  IF l_n <= 1 THEN
                     CALL asft801_01(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'Y')
                     SELECT COUNT(*) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                        AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
                     IF l_n = 0 THEN
                        LET g_sfob_d[l_ac].sfob007 = ''
                        LET g_sfob_d[l_ac].sfob008 = ''
                     END IF
                     IF l_n = 1 THEN
                        SELECT sfoc003,sfoc004 INTO g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008 FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                           AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
                     END IF 
                     IF l_n > 1 THEN
                        LET g_sfob_d[l_ac].sfob007 = 'MULT'
                        LET g_sfob_d[l_ac].sfob008 = 0
                     END IF
                  END IF
               END IF
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '221'
               LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob007
               CALL cl_ref_val("v_oocql002")
               LET g_sfob_d[l_ac].sfob007_desc = g_chkparam.return1
               DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc
            END IF
            LET g_sfob_d_o.* = g_sfob_d[l_ac].*   #160824-00007#251 by sakura add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob007
            #add-point:BEFORE FIELD sfob007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob007
            #add-point:ON CHANGE sfob007

            #END add-point
 
         #----<<sfob008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob008
            #add-point:BEFORE FIELD sfob008
            CALL asft801_set_entry_b(p_cmd)
            CALL asft801_set_no_entry_b(p_cmd)
            IF cl_null(g_sfob_d[l_ac].sfob007) THEN
               NEXT FIELD sfob007
            END IF 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob008
            
            #add-point:AFTER FIELD sfob008
            IF NOT cl_null(g_sfob_d[l_ac].sfob008) THEN
              #IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfob_d[l_ac].sfob008<>　g_sfob_d_t.sfob008) THEN   #160824-00007#251 by sakura mark
               IF g_sfob_d[l_ac].sfob008 <> g_sfob_d_o.sfob008 OR cl_null(g_sfob_d_o.sfob008) THEN      #160824-00007#251 by sakura add
                  IF NOT asft801_sfob007() THEN
                     LET g_sfob_d[l_ac].sfob008 = g_sfob_d_o.sfob008   #160824-00007#251 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL asft801_def_sfob044(g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008)
               END IF
            END IF
            LET g_sfob_d_o.* = g_sfob_d[l_ac].*   #160824-00007#251 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob008
            #add-point:ON CHANGE sfob008

            #END add-point
 
         #----<<sfob009>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob009
            
            #add-point:AFTER FIELD sfob009

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob009
            #add-point:BEFORE FIELD sfob009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob009
            #add-point:ON CHANGE sfob009

            #END add-point
 
         #----<<sfob010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob010
            #add-point:BEFORE FIELD sfob010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob010
            
            #add-point:AFTER FIELD sfob010

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob010
            #add-point:ON CHANGE sfob010

            #END add-point
 
         #----<<sfob011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob011
            #add-point:BEFORE FIELD sfob011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob011
            
            #add-point:AFTER FIELD sfob011
            IF NOT cl_null(g_sfob_d[l_ac].sfob011) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfob_d[l_ac].sfob011
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ecaa001_1") THEN
                  LET g_sfob_d[l_ac].sfob011 = g_sfob_d_t.sfob011
                  CALL asft801_sfob011_ref(g_sfob_d[l_ac].sfob011) RETURNING g_sfob_d[l_ac].sfob011_desc  #160822-00017#1
                  NEXT FIELD sfob011
               END IF
               CALL asft801_sfob011_ref(g_sfob_d[l_ac].sfob011) RETURNING g_sfob_d[l_ac].sfob011_desc  #160822-00017#1
           END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob011
            #add-point:ON CHANGE sfob011

            #END add-point
 
         #----<<sfob023>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob023
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob023,"0.000","1","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob023 = g_sfob_d_t.sfob023
               NEXT FIELD sfob023
            END IF
 
 
            #add-point:AFTER FIELD sfob023

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob023
            #add-point:BEFORE FIELD sfob023

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob023
            #add-point:ON CHANGE sfob023

            #END add-point
 
         #----<<sfob024>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob024
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob024,"0.000","1","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob024 = g_sfob_d_t.sfob024
               NEXT FIELD sfob024
            END IF
 
 
            #add-point:AFTER FIELD sfob024

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob024
            #add-point:BEFORE FIELD sfob024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob024
            #add-point:ON CHANGE sfob024

            #END add-point
 
         #----<<sfob025>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob025
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob025,"0.000","1","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob025 = g_sfob_d_t.sfob025
               NEXT FIELD sfob025
            END IF
 
 
            #add-point:AFTER FIELD sfob025

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob025
            #add-point:BEFORE FIELD sfob025

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob025
            #add-point:ON CHANGE sfob025

            #END add-point
 
         #----<<sfob026>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob026
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob026,"0.000","1","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob026 = g_sfob_d_t.sfob026
               NEXT FIELD sfob026
            END IF
 
 
            #add-point:AFTER FIELD sfob026

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob026
            #add-point:BEFORE FIELD sfob026

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob026
            #add-point:ON CHANGE sfob026

            #END add-point
 
         #----<<sfob044>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob044
            #add-point:BEFORE FIELD sfob044

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob044
            
            #add-point:AFTER FIELD sfob044
            IF NOT cl_null(g_sfob_d[l_ac].sfob044) AND NOT cl_null(g_sfob_d[l_ac].sfob045) THEN 
               IF g_sfob_d[l_ac].sfob044 > g_sfob_d[l_ac].sfob045 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00058'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfob_d[l_ac].sfob044 = g_sfob_d_t.sfob044
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob044
            #add-point:ON CHANGE sfob044

            #END add-point
 
         #----<<sfob045>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob045
            #add-point:BEFORE FIELD sfob045

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob045
            
            #add-point:AFTER FIELD sfob045
            IF NOT cl_null(g_sfob_d[l_ac].sfob044) AND NOT cl_null(g_sfob_d[l_ac].sfob045) THEN 
               IF g_sfob_d[l_ac].sfob044 > g_sfob_d[l_ac].sfob045 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00058'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfob_d[l_ac].sfob045 = g_sfob_d_t.sfob045
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob045
            #add-point:ON CHANGE sfob045

            #END add-point
 
         #----<<sfob012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob012
            #add-point:BEFORE FIELD sfob012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob012
            
            #add-point:AFTER FIELD sfob012
            CALL cl_set_comp_entry('sfob013',TRUE)
            IF g_sfob_d[l_ac].sfob012 = 'N' THEN
               CALL cl_set_comp_entry('sfob013',FALSE)
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob012
            #add-point:ON CHANGE sfob012

            #END add-point
 
         #----<<sfob013>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob013
            
            #add-point:AFTER FIELD sfob013
            IF NOT cl_null(g_sfob_d[l_ac].sfob013) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfob_d[l_ac].sfob013
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_sfob_d[l_ac].sfob013 = g_sfob_d_t.sfob013
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_sfob_d[l_ac].sfob013
                  CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_sfob_d[l_ac].sfob013_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_sfob_d[l_ac].sfob013_desc
                  NEXT FIELD sfob013
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfob_d[l_ac].sfob013
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfob_d[l_ac].sfob013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfob_d[l_ac].sfob013_desc          
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob013
            #add-point:BEFORE FIELD sfob013
            CALL cl_set_comp_entry('sfob013',TRUE)
            IF g_sfob_d[l_ac].sfob012 = 'N' THEN
               CALL cl_set_comp_entry('sfob013',FALSE)
            END IF
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob013
            #add-point:ON CHANGE sfob013

            #END add-point
 
         #----<<sfob014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob014
            #add-point:BEFORE FIELD sfob014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob014
            
            #add-point:AFTER FIELD sfob014

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob014
            #add-point:ON CHANGE sfob014

            #END add-point
 
         #----<<sfob015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob015
            #add-point:BEFORE FIELD sfob015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob015
            
            #add-point:AFTER FIELD sfob015

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob015
            #add-point:ON CHANGE sfob015

            #END add-point
 
         #----<<sfob016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob016
            #add-point:BEFORE FIELD sfob016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob016
            
            #add-point:AFTER FIELD sfob016

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob016
            #add-point:ON CHANGE sfob016

            #END add-point
 
         #----<<sfob017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob017
            #add-point:BEFORE FIELD sfob017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob017
            
            #add-point:AFTER FIELD sfob017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob017
            #add-point:ON CHANGE sfob017

            #END add-point
 
         #----<<sfob018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob018
            #add-point:BEFORE FIELD sfob018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob018
            
            #add-point:AFTER FIELD sfob018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob018
            #add-point:ON CHANGE sfob018

            #END add-point
 
         #----<<sfob019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob019
            #add-point:BEFORE FIELD sfob019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob019
            
            #add-point:AFTER FIELD sfob019

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob019
            #add-point:ON CHANGE sfob019

            #END add-point
 
         #----<<sfob052>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob052
            #add-point:BEFORE FIELD sfob052

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob052
            
            #add-point:AFTER FIELD sfob052
            IF NOT cl_null(g_sfob_d[l_ac].sfob052) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL             
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfob_d[l_ac].sfob052 
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_sfob_d[l_ac].sfob052 = g_sfob_d_t.sfob052
                  NEXT FIELD sfob052
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfob_d[l_ac].sfob052
               CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfob_d[l_ac].sfob052_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfob_d[l_ac].sfob052_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob052
            #add-point:ON CHANGE sfob052

            #END add-point
 
         #----<<sfob053>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob053
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob053,"0.000","0","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob053 = g_sfob_d_t.sfob053
               NEXT FIELD sfob053
            END IF
 
 
            #add-point:AFTER FIELD sfob053

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob053
            #add-point:BEFORE FIELD sfob053

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob053
            #add-point:ON CHANGE sfob053

            #END add-point
 
         #----<<sfob054>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob054
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob054,"0.000","0","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob054 = g_sfob_d_t.sfob054
               NEXT FIELD sfob054
            END IF
 
 
            #add-point:AFTER FIELD sfob054

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob054
            #add-point:BEFORE FIELD sfob054

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob054
            #add-point:ON CHANGE sfob054

            #END add-point
 
         #----<<sfob020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob020
            #add-point:BEFORE FIELD sfob020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob020
            
            #add-point:AFTER FIELD sfob020
            IF NOT cl_null(g_sfob_d[l_ac].sfob020) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL             
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfob_d[l_ac].sfob020 
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_sfob_d[l_ac].sfob020 = g_sfob_d_t.sfob020
                  NEXT FIELD sfob020
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfob_d[l_ac].sfob020
               CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfob_d[l_ac].sfob020_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfob_d[l_ac].sfob020_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob020
            #add-point:ON CHANGE sfob020

            #END add-point
 
         #----<<sfob021>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob021
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob021,"0.000","0","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob021 = g_sfob_d_t.sfob021
               NEXT FIELD sfob021
            END IF
            IF NOT cl_null(g_sfob_d[l_ac].sfob021) AND NOT cl_null(g_sfob_d[l_ac].sfob022)  THEN
               LET g_sfob2_d[l_ac].sfob027 = g_sfoa_m.sfoa003 * g_sfob_d[l_ac].sfob021 / g_sfob_d[l_ac].sfob022 
            END IF
 
 
            #add-point:AFTER FIELD sfob021

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob021
            #add-point:BEFORE FIELD sfob021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob021
            #add-point:ON CHANGE sfob021

            #END add-point
 
         #----<<sfob022>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfob022
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfob_d[l_ac].sfob022,"0.000","0","","","azz-00079",1) THEN
               LET g_sfob_d[l_ac].sfob022 = g_sfob_d_t.sfob022
               NEXT FIELD sfob022
            END IF
            IF NOT cl_null(g_sfob_d[l_ac].sfob021) AND NOT cl_null(g_sfob_d[l_ac].sfob022)  THEN
               LET g_sfob2_d[l_ac].sfob027 = g_sfoa_m.sfoa003 * g_sfob_d[l_ac].sfob021 / g_sfob_d[l_ac].sfob022 
            END IF
 
 
            #add-point:AFTER FIELD sfob022

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfob022
            #add-point:BEFORE FIELD sfob022

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfob022
            #add-point:ON CHANGE sfob022

            #END add-point
 
         #----<<sfob055>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfob055
            #add-point:BEFORE FIELD sfob055

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfob055
            
            #add-point:AFTER FIELD sfob055

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfob055
            #add-point:ON CHANGE sfob055
            IF g_sfob_d[l_ac].sfob055 = 'Y' THEN
               SELECT count(*) INTO l_n FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno 
                  AND sfob001=g_sfoa_m.sfoa001 AND sfob055='Y'
                  AND sfob900=g_sfoa_m.sfoa900
               IF l_n > 0 THEN
                  IF NOT cl_ask_confirm('asf-00134') THEN
                     LET g_sfob_d[l_ac].sfob055 = 'N'
                  ELSE
                     FOR l_j = 1 TO g_rec_b
                        IF g_sfob_d[l_j].sfob055 = 'Y' THEN
                           LET g_sfob_d[l_j].sfob055 = 'N'
                           DISPLAY BY NAME g_sfob_d[l_j].sfob055
                           EXIT FOR
                        END IF
                     END FOR
                  END IF
               END IF
            END IF
                  
               
            #END add-point
            
         AFTER FIELD sfob905
            IF NOT cl_null(g_sfob_d[l_ac].sfob905) AND (cl_null(g_sfob_d_t.sfob905) OR g_sfob_d[l_ac].sfob905 != g_sfob_d_t.sfob905) THEN
               IF NOT asft801_sfoa905_chk(g_sfob_d[l_ac].sfob905) THEN
                  LET g_sfob_d[l_ac].sfob905 = g_sfob_d_t.sfob905
                  CALL asft801_sfoa905_desc(g_sfob_d[l_ac].sfob905) RETURNING g_sfob_d[l_ac].sfob905_desc
                  DISPLAY BY NAME g_sfob_d[l_ac].sfob905_desc
                  NEXT FIELD sfob905
               END IF
               CALL asft801_sfoa905_desc(g_sfob_d[l_ac].sfob905) RETURNING g_sfob_d[l_ac].sfob905_desc
               DISPLAY BY NAME g_sfob_d[l_ac].sfob905_desc
            END IF
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sfob002>>----
         #Ctrlp:input.c.page1.sfob002
         ON ACTION controlp INFIELD sfob002
            #add-point:ON ACTION controlp INFIELD sfob002

            #END add-point
 
         #----<<sfob003>>----
         #Ctrlp:input.c.page1.sfob003
         ON ACTION controlp INFIELD sfob003
            #add-point:ON ACTION controlp INFIELD sfob003
            INITIALIZE g_qryparam.* TO NULL                        #151113-00010#1 add
            LET g_qryparam.state = 'i'                             #160113-00001#1 add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob003       #給予default值
            #給予arg
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                                       #呼叫開窗
            LET g_sfob_d[l_ac].sfob003 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_sfob_d[l_ac].sfob003_desc = g_qryparam.return2   #160113-00001#1 add
#160113-00001#1 mark str
#            DISPLAY g_sfob_d[l_ac].sfob003 TO sfob003              #顯示到畫面上
#            INITIALIZE g_chkparam.* TO NULL
#            LET g_chkparam.arg1 = '221'
#            LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob003
#            CALL cl_ref_val("v_oocql002")
#            LET g_sfob_d[l_ac].sfob003_desc = g_chkparam.return1
#            DISPLAY BY NAME g_sfob_d[l_ac].sfob003_desc
#160113-00001#1 mark end
            NEXT FIELD sfob003 
            #END add-point
 
         #----<<sfob004>>----
         #Ctrlp:input.c.page1.sfob004
         ON ACTION controlp INFIELD sfob004
            #add-point:ON ACTION controlp INFIELD sfob004

            #END add-point
 
         #----<<sfob005>>----
         #Ctrlp:input.c.page1.sfob005
         ON ACTION controlp INFIELD sfob005
            #add-point:ON ACTION controlp INFIELD sfob005

            #END add-point
 
         #----<<sfob006>>----
         #Ctrlp:input.c.page1.sfob006
         ON ACTION controlp INFIELD sfob006
            #add-point:ON ACTION controlp INFIELD sfob006

            #END add-point
 
         #----<<sfob007>>----
         #Ctrlp:input.c.page1.sfob007
         ON ACTION controlp INFIELD sfob007
            #add-point:ON ACTION controlp INFIELD sfob007
            INITIALIZE g_qryparam.* TO NULL   #160719-00005#1 add
            LET g_qryparam.state = 'i'        #160719-00005#1 add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob007             #給予default值
            #給予arg
            LET g_qryparam.arg1=g_site
            LET g_qryparam.arg2=g_sfoa_m.sfoadocno
            LET g_qryparam.arg3=g_sfoa_m.sfoa001
            LET g_qryparam.where=" sfob900=",g_sfoa_m.sfoa900
            CALL q_sfob003()                                             #呼叫開窗
            LET g_sfob_d[l_ac].sfob007  = g_qryparam.return1             #將開窗取得的值回傳到變數
            LET g_sfob_d[l_ac].sfob008  = g_qryparam.return2
            DISPLAY g_sfob_d[l_ac].sfob007  TO sfob007                   #顯示到畫面上
            DISPLAY g_sfob_d[l_ac].sfob008  TO sfob008  
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = '221'
            LET g_chkparam.arg2 = g_sfob_d[l_ac].sfob007
            CALL cl_ref_val("v_oocql002")
            LET g_sfob_d[l_ac].sfob007_desc = g_chkparam.return1
            DISPLAY BY NAME g_sfob_d[l_ac].sfob007_desc
            LET g_qryparam.where = ""
            NEXT FIELD sfob007                         #返回原欄位
            #END add-point
 
         #----<<sfob008>>----
         #Ctrlp:input.c.page1.sfob008
         ON ACTION controlp INFIELD sfob008
            #add-point:ON ACTION controlp INFIELD sfob008

            #END add-point
 
         #----<<sfob009>>----
         #Ctrlp:input.c.page1.sfob009
         ON ACTION controlp INFIELD sfob009
            #add-point:ON ACTION controlp INFIELD sfob009

            #END add-point
 
         #----<<sfob010>>----
         #Ctrlp:input.c.page1.sfob010
         ON ACTION controlp INFIELD sfob010
            #add-point:ON ACTION controlp INFIELD sfob010

            #END add-point
 
         #----<<sfob011>>----
         #Ctrlp:input.c.page1.sfob011
         ON ACTION controlp INFIELD sfob011
            #add-point:ON ACTION controlp INFIELD sfob011
            INITIALIZE g_qryparam.* TO NULL   #160719-00005#1 add
            LET g_qryparam.state = 'i'        #160719-00005#1 add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob011             #給予default值
            CALL q_ecaa001_1()                                           #呼叫開窗
            LET g_sfob_d[l_ac].sfob011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_sfob_d[l_ac].sfob011 TO sfob011                    #顯示到畫面上
            CALL asft801_sfob011_ref(g_sfob_d[l_ac].sfob011) RETURNING g_sfob_d[l_ac].sfob011_desc  #160822-00017#1
            NEXT FIELD sfob011                                           #返回原欄位
            #END add-point
 
         #----<<sfob023>>----
         #Ctrlp:input.c.page1.sfob023
         ON ACTION controlp INFIELD sfob023
            #add-point:ON ACTION controlp INFIELD sfob023
            
            #END add-point
 
         #----<<sfob024>>----
         #Ctrlp:input.c.page1.sfob024
         ON ACTION controlp INFIELD sfob024
            #add-point:ON ACTION controlp INFIELD sfob024
            
            #END add-point
 
         #----<<sfob025>>----
         #Ctrlp:input.c.page1.sfob025
         ON ACTION controlp INFIELD sfob025
            #add-point:ON ACTION controlp INFIELD sfob025
            
            #END add-point
 
         #----<<sfob026>>----
         #Ctrlp:input.c.page1.sfob026
         ON ACTION controlp INFIELD sfob026
            #add-point:ON ACTION controlp INFIELD sfob026
            
            #END add-point
 
         #----<<sfob044>>----
         #Ctrlp:input.c.page1.sfob044
         ON ACTION controlp INFIELD sfob044
            #add-point:ON ACTION controlp INFIELD sfob044

            #END add-point
 
         #----<<sfob045>>----
         #Ctrlp:input.c.page1.sfob045
         ON ACTION controlp INFIELD sfob045
            #add-point:ON ACTION controlp INFIELD sfob045

            #END add-point
 
         #----<<sfob012>>----
         #Ctrlp:input.c.page1.sfob012
         ON ACTION controlp INFIELD sfob012
            #add-point:ON ACTION controlp INFIELD sfob012

            #END add-point
 
         #----<<sfob013>>----
         #Ctrlp:input.c.page1.sfob013
         ON ACTION controlp INFIELD sfob013
            #add-point:ON ACTION controlp INFIELD sfob013
            INITIALIZE g_qryparam.* TO NULL   #160719-00005#1 add
            LET g_qryparam.state = 'i'        #160719-00005#1 add        
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob013             #給予default值
            #給予arg
            LET g_qryparam.arg1 = " ('1','3')"                           #交易對象類型
            CALL q_pmaa001_1()                                           #呼叫開窗
            LET g_sfob_d[l_ac].sfob013 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_sfob_d[l_ac].sfob013 TO sfob013                    #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfob_d[l_ac].sfob013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfob_d[l_ac].sfob013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfob_d[l_ac].sfob013_desc
            NEXT FIELD sfob013                                           #返回原欄位
            #END add-point
 
         #----<<sfob014>>----
         #Ctrlp:input.c.page1.sfob014
         ON ACTION controlp INFIELD sfob014
            #add-point:ON ACTION controlp INFIELD sfob014

            #END add-point
 
         #----<<sfob015>>----
         #Ctrlp:input.c.page1.sfob015
         ON ACTION controlp INFIELD sfob015
            #add-point:ON ACTION controlp INFIELD sfob015

            #END add-point
 
         #----<<sfob016>>----
         #Ctrlp:input.c.page1.sfob016
         ON ACTION controlp INFIELD sfob016
            #add-point:ON ACTION controlp INFIELD sfob016

            #END add-point
 
         #----<<sfob017>>----
         #Ctrlp:input.c.page1.sfob017
         ON ACTION controlp INFIELD sfob017
            #add-point:ON ACTION controlp INFIELD sfob017

            #END add-point
 
         #----<<sfob018>>----
         #Ctrlp:input.c.page1.sfob018
         ON ACTION controlp INFIELD sfob018
            #add-point:ON ACTION controlp INFIELD sfob018

            #END add-point
 
         #----<<sfob019>>----
         #Ctrlp:input.c.page1.sfob019
         ON ACTION controlp INFIELD sfob019
            #add-point:ON ACTION controlp INFIELD sfob019

            #END add-point
 
         #----<<sfob052>>----
         #Ctrlp:input.c.page1.sfob052
         ON ACTION controlp INFIELD sfob052
            #add-point:ON ACTION controlp INFIELD sfob052
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob052            #給予default值
            #給予arg
            CALL q_ooca001()                                            #呼叫開窗
            LET g_sfob_d[l_ac].sfob052 = g_qryparam.return1             #將開窗取得的值回傳到變數
            DISPLAY g_sfob_d[l_ac].sfob052 TO sfob052                   #顯示到畫面上
            NEXT FIELD sfob052                                          #返回原欄位
            #END add-point
 
         #----<<sfob053>>----
         #Ctrlp:input.c.page1.sfob053
         ON ACTION controlp INFIELD sfob053
            #add-point:ON ACTION controlp INFIELD sfob053

            #END add-point
 
         #----<<sfob054>>----
         #Ctrlp:input.c.page1.sfob054
         ON ACTION controlp INFIELD sfob054
            #add-point:ON ACTION controlp INFIELD sfob054

            #END add-point
 
         #----<<sfob020>>----
         #Ctrlp:input.c.page1.sfob020
         ON ACTION controlp INFIELD sfob020
            #add-point:ON ACTION controlp INFIELD sfob020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob020            #給予default值
            #給予arg
            CALL q_ooca001()                                            #呼叫開窗
            LET g_sfob_d[l_ac].sfob020 = g_qryparam.return1             #將開窗取得的值回傳到變數
            DISPLAY g_sfob_d[l_ac].sfob020 TO sfob020                   #顯示到畫面上
            NEXT FIELD sfob020                                          #返回原欄位
            #END add-point
 
         #----<<sfob021>>----
         #Ctrlp:input.c.page1.sfob021
         ON ACTION controlp INFIELD sfob021
            #add-point:ON ACTION controlp INFIELD sfob021

            #END add-point
 
         #----<<sfob022>>----
         #Ctrlp:input.c.page1.sfob022
         ON ACTION controlp INFIELD sfob022
            #add-point:ON ACTION controlp INFIELD sfob022

            #END add-point
 
         #----<<sfob055>>----
         #Ctrlp:input.c.page1.sfob055
         ON ACTION controlp INFIELD sfob055
            #add-point:ON ACTION controlp INFIELD sfob055

            #END add-point
         ON ACTION controlp INFIELD ooff013
            IF NOT cl_null(g_sfob_d[l_ac].sfob002) THEN
               CALL aooi360_02('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,'','','','','','','4')
               CALL s_aooi360_sel('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,'','','','','','','4') RETURNING l_success,g_sfob_d[l_ac].ooff013
            END IF
            
         ON ACTION controlp INFIELD sfob905
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfob_d[l_ac].sfob905             #給予default值
            LET g_qryparam.arg1 = g_acc            
            CALL q_oocq002()                                             #呼叫開窗
            LET g_sfob_d[l_ac].sfob905 = g_qryparam.return1    
            DISPLAY g_sfob_d[l_ac].sfob905 TO sfob905    
            NEXT FIELD sfob905                                           #返回原欄位
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_sfob_d[l_ac].* = g_sfob_d_t.*
               CLOSE asft801_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_sfob_d[l_ac].sfob002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_sfob_d[l_ac].* = g_sfob_d_t.*
            ELSE
               #IF l_flag2 = 'Y' THEN  #170405-00021#1 mark
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               
               #add-point:單身修改前
               #所属同一个替代群组的本站作业，有其中一站5个步骤(move in,check in,报工站,check out,move out)有勾选的话，另外的站，必须至少也勾选一个
               IF g_sfob_d[l_ac].sfob005 = '2' AND NOT cl_null(g_sfob_d[l_ac].sfob006) THEN
                  IF g_sfob_d[l_ac].sfob014 = 'N' AND g_sfob_d[l_ac].sfob015 = 'N' AND g_sfob_d[l_ac].sfob016 = 'N' AND g_sfob_d[l_ac].sfob018 = 'N' AND g_sfob_d[l_ac].sfob019 = 'N' THEN
                     SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                        AND sfob001 = g_sfoa_m.sfoa001 AND sfob005 = '2' AND sfob006 = g_sfob_d[l_ac].sfob006 
                        AND sfob014 ='Y' AND sfob015 = 'Y' AND sfob016 = 'Y' AND sfob018 = 'Y' AND sfob019 = 'Y'
                        AND sfob002 != g_sfob_d[l_ac].sfob002
                        AND sfob900 = g_sfoa_m.sfoa900
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00196'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD sfob014
                     END IF
                  END IF
                  IF g_sfob_d[l_ac].sfob014 = 'Y' AND g_sfob_d[l_ac].sfob015 = 'Y' AND g_sfob_d[l_ac].sfob016 = 'Y' AND g_sfob_d[l_ac].sfob018 = 'Y' AND g_sfob_d[l_ac].sfob019 = 'Y' THEN
                     SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                        AND sfob001 = g_sfoa_m.sfoa001 AND sfob005 = '2' AND sfob006 = g_sfob_d[l_ac].sfob006 
                        AND sfob014 ='N' AND sfob015 = 'N' AND sfob016 = 'N' AND sfob018 = 'N' AND sfob019 = 'N'
                        AND sfob002 != g_sfob_d[l_ac].sfob002
                        AND sfob900 = g_sfoa_m.sfoa900
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00196'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD sfob014
                     END IF
                  END IF
               END IF
               
               IF g_sfob_d[l_ac].sfob901 = '1' THEN
                  LET g_sfob_d[l_ac].sfob901 = '2' 
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE sfob_t SET (sfobdocno,sfob001,sfob002,sfob003,sfob004,sfob005,sfob006,sfob007, 
                   sfob008,sfob009,sfob010,sfob011,sfob023,sfob024,sfob025,sfob026,sfob044,sfob045,sfob012, 
                   sfob013,sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052,sfob053,sfob054,sfob020, 
                   sfob021,sfob022,sfob055,sfob901,sfob905,sfob906,sfob027,sfob050,sfob028,sfob029,sfob030,sfob031,sfob032,sfob033, 
                   sfob034,sfob035,sfob036,sfob037,sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob046, 
                   sfob047,sfob048,sfob049,sfob051,sfobsite) = (g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001, 
                   g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,g_sfob_d[l_ac].sfob005, 
                   g_sfob_d[l_ac].sfob006,g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008,g_sfob_d[l_ac].sfob009, 
                   g_sfob_d[l_ac].sfob010,g_sfob_d[l_ac].sfob011,g_sfob_d[l_ac].sfob023,g_sfob_d[l_ac].sfob024, 
                   g_sfob_d[l_ac].sfob025,g_sfob_d[l_ac].sfob026,g_sfob_d[l_ac].sfob044,g_sfob_d[l_ac].sfob045, 
                   g_sfob_d[l_ac].sfob012,g_sfob_d[l_ac].sfob013,g_sfob_d[l_ac].sfob014,g_sfob_d[l_ac].sfob015, 
                   g_sfob_d[l_ac].sfob016,g_sfob_d[l_ac].sfob017,g_sfob_d[l_ac].sfob018,g_sfob_d[l_ac].sfob019, 
                   g_sfob_d[l_ac].sfob052,g_sfob_d[l_ac].sfob053,g_sfob_d[l_ac].sfob054,g_sfob_d[l_ac].sfob020, 
                   g_sfob_d[l_ac].sfob021,g_sfob_d[l_ac].sfob022,g_sfob_d[l_ac].sfob055,g_sfob_d[l_ac].sfob901,g_sfob_d[l_ac].sfob905,g_sfob_d[l_ac].sfob906,g_sfob2_d[l_ac].sfob027, 
                   g_sfob2_d[l_ac].sfob050,g_sfob2_d[l_ac].sfob028,g_sfob2_d[l_ac].sfob029,g_sfob2_d[l_ac].sfob030, 
                   g_sfob2_d[l_ac].sfob031,g_sfob2_d[l_ac].sfob032,g_sfob2_d[l_ac].sfob033,g_sfob2_d[l_ac].sfob034, 
                   g_sfob2_d[l_ac].sfob035,g_sfob2_d[l_ac].sfob036,g_sfob2_d[l_ac].sfob037,g_sfob2_d[l_ac].sfob038, 
                   g_sfob2_d[l_ac].sfob039,g_sfob2_d[l_ac].sfob040,g_sfob2_d[l_ac].sfob041,g_sfob2_d[l_ac].sfob042, 
                   g_sfob2_d[l_ac].sfob043,g_sfob2_d[l_ac].sfob046,g_sfob2_d[l_ac].sfob047,g_sfob2_d[l_ac].sfob048, 
                   g_sfob2_d[l_ac].sfob049,g_sfob2_d[l_ac].sfob051,g_site)
                WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                  AND sfob001 = g_sfoa_m.sfoa001 
                  AND sfob900 = g_sfoa_m.sfoa900
 
                  AND sfob002 = g_sfob_d_t.sfob002 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "sfob_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_sfob_d[l_ac].* = g_sfob_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfob_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                     LET g_sfob_d[l_ac].* = g_sfob_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfoa_m.sfoadocno
               LET gs_keys_bak[1] = g_sfoadocno_t
               LET gs_keys[2] = g_sfoa_m.sfoa001
               LET gs_keys_bak[2] = g_sfoa001_t
               LET gs_keys[3] = g_sfoa_m.sfoa900
               LET gs_keys_bak[3] = g_sfoa900_t
               LET gs_keys[4] = g_sfob_d[g_detail_idx].sfob002
               LET gs_keys_bak[4] = g_sfob_d_t.sfob002
               CALL asft801_update_b('sfob_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #161108-00023#3-s
               IF g_sfob_d[l_ac].sfob003 <> g_sfob_d_t.sfob003 OR 
                  g_sfob_d[l_ac].sfob004 <> g_sfob_d_t.sfob004 THEN
                  UPDATE sfob_t
                     SET sfob007 = g_sfob_d[l_ac].sfob003,
                         sfob008 = g_sfob_d[l_ac].sfob004
                          ,sfob901 = 2 #170123-00041#1---add
                   WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob900 = g_sfoa_m.sfoa900
                     AND sfob007 = g_sfob_d_t.sfob003 AND sfob008 = g_sfob_d_t.sfob004
                  UPDATE sfob_t
                     SET sfob009 = g_sfob_d[l_ac].sfob003,
                         sfob010 = g_sfob_d[l_ac].sfob004
                   WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob900 = g_sfoa_m.sfoa900
                     AND sfob009 = g_sfob_d_t.sfob003 AND sfob010 = g_sfob_d_t.sfob004
                  UPDATE sfoc_t
                     SET sfoc003 = g_sfob_d[l_ac].sfob003,
                         sfoc004 = g_sfob_d[l_ac].sfob004
                          ,sfoc901 = 2 #170123-00041#1---add
                   WHERE sfocent = g_enterprise AND sfocdocno = g_sfoa_m.sfoadocno
                     AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc900 = g_sfoa_m.sfoa900
                     AND sfoc003 = g_sfob_d_t.sfob003 AND sfoc004 = g_sfob_d_t.sfob004
               END IF
               #161108-00023#3-e
               
               IF g_sfob_d[l_ac].sfob055 = 'Y' THEN
                  UPDATE sfob_t SET sfob055 = 'N' WHERE sfobent = g_enterprise AND sfobdocno = g_sfoa_m.sfoadocno 
                     AND sfob001 = g_sfoa_m.sfoa001 AND sfob002 != g_sfob_d[l_ac].sfob002
                     AND sfob900 = g_sfoa_m.sfoa900
               END IF
               
               IF g_sfob_d[l_ac].sfob007 <> 'MULT' AND (g_sfob_d[l_ac].sfob007!=g_sfob_d_t.sfob007 OR g_sfob_d[l_ac].sfob008!=g_sfob_d_t.sfob008) THEN
                  #新增的上站作业删除
                  DELETE FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site AND sfocdocno=g_sfoa_m.sfoadocno
                     AND sfoc001 = g_sfoa_m.sfoa001 AND sfoc002 = g_sfob_d[l_ac].sfob002
                     AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc901 = '3'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del_sfoc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF  

                  SELECT COUNT(*) INTO l_n2 FROM sfoc_t 
                   WHERE sfocent = g_enterprise
                     AND sfocsite = g_site
                     AND sfocdocno = g_sfoa_m.sfoadocno
                     AND sfoc001 = g_sfoa_m.sfoa001
                     AND sfoc900 = g_sfoa_m.sfoa900
                     AND sfoc002 = g_sfob_d[l_ac].sfob002
                     AND sfoc003 = g_sfob_d_t.sfob007
                     AND sfoc004 = g_sfob_d_t.sfob008
                     AND sfoc901 != '3'
                  IF l_n2 > 0 THEN
                     #存在的话，旧值肯定不是MULT，且上站作业仅仅是一笔资料
                     UPDATE sfoc_t SET sfoc003 = g_sfob_d[l_ac].sfob007,
                                       sfoc004 = g_sfob_d[l_ac].sfob008,
                                       sfoc901 = '2'
                      WHERE sfocent = g_enterprise
                        AND sfocsite = g_site
                        AND sfocdocno = g_sfoa_m.sfoadocno
                        AND sfoc001 = g_sfoa_m.sfoa001
                        AND sfoc900 = g_sfoa_m.sfoa900
                        AND sfoc002 = g_sfob_d[l_ac].sfob002
                        AND sfoc003 = g_sfob_d_t.sfob007
                        AND sfoc004 = g_sfob_d_t.sfob008
                        AND sfoc901 != '3'
                  ELSE
                     #不存在的话，旧值肯定是MULT
                     SELECT COUNT(*) INTO l_n3 FROM sfoc_t 
                      WHERE sfocent = g_enterprise
                        AND sfocsite = g_site
                        AND sfocdocno = g_sfoa_m.sfoadocno
                        AND sfoc001 = g_sfoa_m.sfoa001
                        AND sfoc900 = g_sfoa_m.sfoa900
                        AND sfoc002 = g_sfob_d[l_ac].sfob002
                        AND sfoc003 = g_sfob_d[l_ac].sfob007
                        AND sfoc004 = g_sfob_d[l_ac].sfob008
                     IF l_n3 > 0 THEN
                        UPDATE sfoc_t SET sfoc901 = '4'
                         WHERE sfocent = g_enterprise
                           AND sfocsite = g_site
                           AND sfocdocno = g_sfoa_m.sfoadocno
                           AND sfoc001 = g_sfoa_m.sfoa001
                           AND sfoc900 = g_sfoa_m.sfoa900
                           AND sfoc002 = g_sfob_d[l_ac].sfob002
                           AND sfoc003 != g_sfob_d[l_ac].sfob007
                           AND sfoc004 != g_sfob_d[l_ac].sfob008
                           AND sfoc901 != '3'
                     ELSE
                        UPDATE sfoc_t SET sfoc901 = '4'
                         WHERE sfocent = g_enterprise
                           AND sfocsite = g_site
                           AND sfocdocno = g_sfoa_m.sfoadocno
                           AND sfoc001 = g_sfoa_m.sfoa001
                           AND sfoc900 = g_sfoa_m.sfoa900
                           AND sfoc002 = g_sfob_d[l_ac].sfob002
                           AND sfoc901 != '3'
                        SELECT MAX(sfocseq)+1 INTO l_sfocseq FROM sfoc_t
                         WHERE sfocent = g_enterprise
                           AND sfocsite = g_site
                           AND sfocdocno = g_sfoa_m.sfoadocno
                           AND sfoc001 = g_sfoa_m.sfoa001
                           AND sfoc900 = g_sfoa_m.sfoa900
                           AND sfoc002 = g_sfob_d[l_ac].sfob002
                        IF cl_null(l_sfocseq) THEN
                           LET l_sfocseq = 1
                        END IF
                        INSERT INTO sfoc_t(sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc905,sfoc906,sfocseq)
                           VALUES(g_enterprise,g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008,g_sfoa_m.sfoa900,'3',g_sfob_d[l_ac].sfob905,g_sfob_d[l_ac].sfob906,l_sfocseq)
                     END IF
                  END IF
               

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins_sfoc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
               END IF 
               
               IF NOT cl_null(g_sfob_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,' ',' ',' ',' ',' ',' ','4',g_sfob_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfob_d[l_ac].sfob002,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               #update 下站作业+制程序
               IF NOT asft801_upd_sfob009() THEN
                  CALL s_transaction_end('N','0')
               END IF 
               CALL asft801_b_fill()
               #end add-point
               END IF
            #END IF  #170405-00021#1 mark
            
         AFTER ROW
            #add-point:單身after_row

                         
            #end add-point
            CALL asft801_unlock_b("sfob_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
            
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_sfob_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_sfob_d.getLength()+1
         
         ON ACTION gen_sfoc
            IF l_ac > 0 THEN
               CALL asft801_01(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'Y')
               SELECT COUNT(*) INTO l_n FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                  AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
                  AND sfoc900=g_sfoa_m.sfoa900 AND sfoc901!='4'
               IF l_n = 0 THEN
                  LET g_sfob_d[l_ac].sfob007 = ''
                  LET g_sfob_d[l_ac].sfob008 = ''
               END IF
               IF l_n = 1 THEN
                  SELECT sfoc003,sfoc004 INTO g_sfob_d[l_ac].sfob007,g_sfob_d[l_ac].sfob008 FROM sfoc_t WHERE sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
                     AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
                     AND sfoc900=g_sfoa_m.sfoa900
               END IF 
               IF l_n > 1 THEN
                  LET g_sfob_d[l_ac].sfob007 = 'MULT'
                  LET g_sfob_d[l_ac].sfob008 = 0
               END IF
               UPDATE sfob_t SET sfob007=g_sfob_d[l_ac].sfob007,sfob008=g_sfob_d[l_ac].sfob008
                WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
                  AND sfob001=g_sfoa_m.sfoa001 AND sfob002=g_sfob_d[l_ac].sfob002
               #update 下站作业+制程序
               IF NOT asft801_upd_sfob009() THEN
               END IF
             # CALL asft801_b_fill()
            END IF
         
         ON ACTION gen_checkin
            IF l_ac > 0 AND l_flag = 'Y' THEN
               CALL asft801_02(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'1','Y')
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00139'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         ON ACTION gen_checkout
            IF l_ac > 0 AND l_flag = 'Y' THEN
               CALL asft801_02(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[l_ac].sfob002,g_sfob_d[l_ac].sfob003,g_sfob_d[l_ac].sfob004,'2','Y')
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00139'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      #add-point:自定義input

      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         CALL cl_set_act_visible("gen_checkin,gen_checkout",FALSE)
         LET l_flag = 'N' 
         IF NOT cl_null(g_sfoa_m.sfaa016) AND NOT cl_null(g_sfoa_m.sfaa010) THEN
            CALL cl_set_act_visible("gen_checkin,gen_checkout", TRUE)
            LET l_flag = 'Y'
         END IF 
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD sfoadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sfob002
               WHEN "s_detail2"
                  NEXT FIELD sfob002
            END CASE
         END IF
    
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
    
   #add-point:input段after input 
   IF l_flag1 = 'N' THEN
      LET l_flag1 = 'Y'
      CALL asft801_modify()
   END IF
   #end add-point    
END FUNCTION

PRIVATE FUNCTION asft801_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point

   #先刷新資料
   #CALL asft801_b_fill()

   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "sfob_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN asft801_bcl USING g_enterprise,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900,g_sfob_d[g_detail_idx].sfob002


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "asft801_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF





   #add-point:lock_b段other
   {<point name="lock_b.other"/>}
   #end add-point

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION asft801_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point

   LET ls_group = "'1','2',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asft801_bcl
   END IF





   #add-point:unlock_b段other
   {<point name="unlock_b.other"/>}
   #end add-point

END FUNCTION
#检查作业+制程序不可重复
PRIVATE FUNCTION asft801_sfob003(p_sfob003,p_sfob004)
DEFINE p_sfob003         LIKE sfob_t.sfob003
DEFINE p_sfob004         LIKE sfob_t.sfob004
DEFINE l_n               LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 

   IF cl_null(p_sfob003) OR cl_null(p_sfob004) THEN
      RETURN TRUE
   END IF 
   SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
      AND sfob001=g_sfoa_m.sfoa001 AND sfob003=p_sfob003 AND sfob004=p_sfob004
      AND sfob900 = g_sfoa_m.sfoa900
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00129'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#预设制程序
PRIVATE FUNCTION asft801_def_sfob004(p_sfob003)
DEFINE p_sfob003         LIKE sfob_t.sfob003
DEFINE l_sfob004         LIKE type_t.num5

   IF cl_null(p_sfob003) THEN
      RETURN
   END IF
   SELECT MAX(sfob004) INTO l_sfob004 FROM sfob_t
    WHERE sfobent = g_enterprise
      AND sfobsite = g_site
      AND sfobdocno = g_sfoa_m.sfoadocno
      AND sfob001 = g_sfoa_m.sfoa001
      AND sfob003 = p_sfob003
      AND sfob900 = g_sfoa_m.sfoa900
   LET l_sfob004 = l_sfob004 + 1
   LET g_sfob_d[l_ac].sfob004 = l_sfob004
   IF cl_null(g_sfob_d[l_ac].sfob004) THEN
      LET g_sfob_d[l_ac].sfob004 = 1
   END IF
   DISPLAY BY NAME g_sfob_d[l_ac].sfob004
END FUNCTION
#上站作业+制程序 检查
PRIVATE FUNCTION asft801_sfob007()
DEFINE l_n       LIKE type_t.num10             #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_sql     STRING
   CALL cl_set_comp_entry("sfob008",TRUE)
   IF cl_null(g_sfob_d[l_ac].sfob007) THEN
      RETURN FALSE
   END IF
   IF g_sfob_d[l_ac].sfob007 = 'INIT' OR g_sfob_d[l_ac].sfob007 = 'MULT' THEN
      LET g_sfob_d[l_ac].sfob008 = 0
      CALL cl_set_comp_entry("sfob008",FALSE)
      RETURN TRUE
   END IF 
   SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
      AND sfob001=g_sfoa_m.sfoa001 AND sfob006=g_sfob_d[l_ac].sfob007
      AND sfob900 = g_sfoa_m.sfoa900
   IF l_n > 0 THEN
      LET g_sfob_d[l_ac].sfob008 = 0
      CALL cl_set_comp_entry("sfob008",FALSE)
      RETURN TRUE
   END IF
   #上站作业非“INIT”，“MULT","群组”，若作业序为0，则清空作业序
   IF g_sfob_d[l_ac].sfob008 = '0' THEN
      CALL cl_set_comp_entry("sfob008",TRUE)
      LET g_sfob_d[l_ac].sfob008 = ''
   END IF 
   
   LET l_sql ="SELECT COUNT(*) FROM sfob_t WHERE sfobent='",g_enterprise,"' AND sfobsite='",g_site,"' AND sfobdocno='",g_sfoa_m.sfoadocno,"'",
              "   AND sfob001='",g_sfoa_m.sfoa001,"' AND sfob003='",g_sfob_d[l_ac].sfob007,"'",
              "   AND sfob900='",g_sfoa_m.sfoa900,"'"
   IF NOT cl_null(g_sfob_d[l_ac].sfob008) THEN
      LET l_sql=l_sql," AND sfob004='",g_sfob_d[l_ac].sfob008,"'"
   END IF
   PREPARE asft801_sfob007_pre FROM l_sql
   EXECUTE asft801_sfob007_pre INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00132'
      LET g_errparam.extend = g_sfob_d[l_ac].sfob007
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF NOT cl_null(g_sfob_d[l_ac].sfob003) AND NOT cl_null(g_sfob_d[l_ac].sfob004) AND NOT cl_null(g_sfob_d[l_ac].sfob008) THEN
         IF g_sfob_d[l_ac].sfob003 = g_sfob_d[l_ac].sfob007 AND g_sfob_d[l_ac].sfob004 = g_sfob_d[l_ac].sfob008 THEN
            INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00132'
      LET g_errparam.extend = g_sfob_d[l_ac].sfob007
      LET g_errparam.popup = TRUE
      CALL cl_err()

            RETURN FALSE        
         END IF
      END IF
      RETURN TRUE
   END IF
              
END FUNCTION
#预设预计开工日
PRIVATE FUNCTION asft801_def_sfob044(p_sfob007,p_sfob008)
DEFINE p_sfob007         LIKE sfob_t.sfob007
DEFINE p_sfob008         LIKE sfob_t.sfob008
DEFINE l_n               LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy 

   IF cl_null(p_sfob007) THEN
      RETURN
   END IF
   
   IF p_sfob007 = 'INIT' THEN
      LET g_sfob_d[l_ac].sfob044 = g_sfoa_m.sfaa019
   END IF
   
   IF p_sfob007 = 'MULT' THEN      
      SELECT MAX(sfob045) INTO g_sfob_d[l_ac].sfob044 FROM sfob_t,sfoc_t WHERE sfobent=sfocent AND sfobsite=sfocsite AND sfobdocno=sfocdocno
         AND sfob001=sfoc001 AND sfob002=sfoc002 AND sfob003=sfoc003 AND sfob004=sfoc004 AND sfob900=sfoc900
         AND sfocent=g_enterprise AND sfocsite=g_site AND sfocdocno=g_sfoa_m.sfoadocno
         AND sfoc001=g_sfoa_m.sfoa001 AND sfoc002=g_sfob_d[l_ac].sfob002
         AND sfoc900=g_sfoa_m.sfoa900
   END IF
   
   #群组
   SELECT COUNT(*) INTO l_n FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
      AND sfob001=g_sfoa_m.sfoa001 AND sfob006=g_sfob_d[l_ac].sfob007
      AND sfob900 = g_sfoa_m.sfoa900
   IF l_n > 0 THEN
      SELECT MAX(sfob045) INTO g_sfob_d[l_ac].sfob044 FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site
         AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 AND sfob006=g_sfob_d[l_ac].sfob007
         AND sfob900 = g_sfoa_m.sfoa900
   ELSE
      SELECT sfob045 INTO g_sfob_d[l_ac].sfob044 FROM sfob_t WHERE sfobent=g_enterprise AND sfobsite=g_site
         AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
         AND sfob003=g_sfob_d[l_ac].sfob007 AND sfob004=g_sfob_d[l_ac].sfob008
         AND sfob900 = g_sfoa_m.sfoa900
   END IF
   
END FUNCTION
#回写下站作业+制程序
PRIVATE FUNCTION asft801_upd_sfob009()
DEFINE l_sql          STRING
#161109-00085#36-s
#DEFINE l_sfoc         RECORD LIKE sfoc_t.*
DEFINE l_sfoc RECORD  #工單製程變更上站作業資料
       sfocent LIKE sfoc_t.sfocent, #企業編號
       sfocsite LIKE sfoc_t.sfocsite, #營運據點
       sfocdocno LIKE sfoc_t.sfocdocno, #工單單號
       sfoc001 LIKE sfoc_t.sfoc001, #RUN CARD
       sfoc002 LIKE sfoc_t.sfoc002, #項次
       sfoc003 LIKE sfoc_t.sfoc003, #上站作業
       sfoc004 LIKE sfoc_t.sfoc004, #上站製程式
       sfoc900 LIKE sfoc_t.sfoc900, #變更序
       sfoc901 LIKE sfoc_t.sfoc901, #變更類型
       sfoc902 LIKE sfoc_t.sfoc902, #變更日期
       sfoc905 LIKE sfoc_t.sfoc905, #變更理由
       sfoc906 LIKE sfoc_t.sfoc906, #變更備註
       sfocseq LIKE sfoc_t.sfocseq  #項序
END RECORD
#161109-00085#36-e
DEFINE l_n            LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_n1           LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_n2           LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_n3           LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE r_success      LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
#161109-00085#36-s
#DEFINE l_sfob         RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       sfob055 LIKE sfob_t.sfob055  #回收站
END RECORD
#161109-00085#36-e
DEFINE l_n0           LIKE type_t.num5
DEFINE l_sfob009      LIKE sfob_t.sfob009
DEFINE l_sfob010      LIKE sfob_t.sfob010
DEFINE l_n4           LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   
   LET r_success = FALSE
   LET l_n = 0 
   LET l_sql = 
               #161109-00085#36-s
               #"SELECT * FROM sfob_t",
               "SELECT sfobent,sfobsite,sfobdocno,sfob001,sfob002,
                       sfob003,sfob004,sfob005,sfob006,sfob007,
                       sfob008,sfob009,sfob010,sfob011,sfob012,
                       sfob013,sfob014,sfob015,sfob016,sfob017,
                       sfob018,sfob019,sfob020,sfob021,sfob022,
                       sfob023,sfob024,sfob025,sfob026,sfob027,
                       sfob028,sfob029,sfob030,sfob031,sfob032,
                       sfob033,sfob034,sfob035,sfob036,sfob037,
                       sfob038,sfob039,sfob040,sfob041,sfob042,
                       sfob043,sfob044,sfob045,sfob046,sfob047,
                       sfob048,sfob049,sfob050,sfob051,sfob052,
                       sfob053,sfob054,sfob900,sfob901,sfob902,
                       sfob905,sfob906,sfob055 FROM sfob_t",
               #161109-00085#36-e
               " WHERE sfobent=",g_enterprise," AND sfobsite='",g_site,"'",
               "   AND sfobdocno='",g_sfoa_m.sfoadocno,"' AND sfob001='",g_sfoa_m.sfoa001,"'",
               "   AND sfob900=",g_sfoa_m.sfoa900," AND sfob901 != '4'"
   PREPARE asft801_upd_sfob009_pre0 FROM l_sql
   DECLARE asft801_upd_sfob009_cs0 CURSOR FOR asft801_upd_sfob009_pre0
   #161109-00085#36-s
   #FOREACH asft801_upd_sfob009_cs0 INTO l_sfob.*
   FOREACH asft801_upd_sfob009_cs0 
   INTO l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
        l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
        l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
        l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
        l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
        l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
        l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
        l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
        l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
        l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
        l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
        l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
        l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055
   #161109-00085#36-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #当前作业、作业序，不存在其他站的 上站作业 中，
      #当前群組 也不存在其他站的 上站作业 中，
      #则更新本站对应下站为END,0
      SELECT COUNT(*) INTO l_n4 FROM sfoc_t 
       WHERE sfocent = g_enterprise AND sfocsite = g_site
         AND sfocdocno = g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001
         AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc901 != '4'
         AND sfoc003 = l_sfob.sfob003 AND sfoc004 = l_sfob.sfob004
      IF NOT cl_null(l_sfob.sfob006) AND l_n4 = 0 THEN 
         SELECT COUNT(*) INTO l_n4 FROM sfoc_t 
          WHERE sfocent = g_enterprise AND sfocsite = g_site
            AND sfocdocno = g_sfoa_m.sfoadocno AND sfoc001 = g_sfoa_m.sfoa001
            AND sfoc900 = g_sfoa_m.sfoa900 AND sfoc901 != '4'
            AND sfoc003 = l_sfob.sfob006 AND sfoc004 = 0
      END IF
      IF l_n4 = 0 THEN
         UPDATE sfob_t SET sfob009 = 'END',sfob010 = 0
          WHERE sfobent = g_enterprise AND sfobsite = g_site
            AND sfobdocno = g_sfoa_m.sfoadocno AND sfob001 = g_sfoa_m.sfoa001
            AND sfob900 = g_sfoa_m.sfoa900 AND sfob002 = l_sfob.sfob002
      END IF
      #161109-00085#36-s
      #LET l_sql = "SELECT * FROM sfoc_t",
      LET l_sql = "SELECT sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,
                          sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,
                          sfoc905,sfoc906,sfocseq
                   FROM sfoc_t",
      #161109-00085#36-e
                  " WHERE sfocent='",g_enterprise,"' AND sfocsite='",g_site,"'",
                  "   AND sfocdocno='",g_sfoa_m.sfoadocno,"' AND sfoc001='",g_sfoa_m.sfoa001,"'",
                  "   AND sfoc900=",g_sfoa_m.sfoa900," AND sfoc901 != '4'",
                  "   AND sfoc002=",l_sfob.sfob002
      PREPARE asft801_upd_sfob009_pre FROM l_sql
      DECLARE asft801_upd_sfob009_cs CURSOR FOR asft801_upd_sfob009_pre
      #161109-00085#36-s
      #FOREACH asft801_upd_sfob009_cs INTO l_sfoc.*
      FOREACH asft801_upd_sfob009_cs 
      INTO l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
           l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
           l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq
      #161109-00085#36-e
         #計算一下抓到的上站作業+作業序  是其他幾筆資料的 上站作業+作業序
         SELECT COUNT(*) INTO l_n FROM sfoc_t
          WHERE sfocent=g_enterprise AND sfocsite=g_site
            AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001=g_sfoa_m.sfoa001 
            AND sfoc003=l_sfoc.sfoc003 AND sfoc004=l_sfoc.sfoc004
            AND sfoc900=g_sfoa_m.sfoa900 AND sfoc901 != '4'
        #IF l_n = 1 THEN  #160113-00001#1 mark
        #160113-00001#1 mod str
         CASE
            WHEN l_n = 1  #抓到一筆作業+作業序的上站資料
        #160113-00001#1 mod end            
               IF NOT cl_null(l_sfob.sfob006) THEN   #有維護群組
                  #更新上站作業+上站作業序且無維護群組或群組不一樣的資料
                  #對應下站程序+下站制程序為本資料的群組+本站               
                  UPDATE sfob_t SET sfob009=l_sfob.sfob006,sfob010=0
                   WHERE sfobent=g_enterprise AND sfobsite=g_site 
                     AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                     AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
                     AND (sfob006 IS NULL OR sfob006!=l_sfob.sfob006)
                     AND sfob901 != '4'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "sfob_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     RETURN r_success
                  END IF
                  #更新上站作業+上站制程序且有維護群組(相同群組)的資料
                  #對應下站程序+下站制程序為本資料的本站程序+本站制程序
                  UPDATE sfob_t SET sfob009=l_sfob.sfob003,sfob010=l_sfob.sfob004
                   WHERE sfobent=g_enterprise AND sfobsite=g_site 
                     AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                     AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
                     AND sfob006=l_sfob.sfob006
                     AND sfob901 != '4'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "sfob_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     RETURN r_success
                  END IF
               ELSE    #無維護群組
                  #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
                  UPDATE sfob_t SET sfob009=l_sfob.sfob003,sfob010=l_sfob.sfob004
                   WHERE sfobent=g_enterprise AND sfobsite=g_site 
                     AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
                     AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
                     AND sfob901 != '4'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "sfob_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     RETURN r_success
                  END IF
               END IF
        #160113-00001#1 add str
           WHEN l_n > 1  #抓到多筆作業+作業序的上站資料               
               IF NOT cl_null(l_sfob.sfob006) THEN
                  UPDATE sfob_t SET sfob009=l_sfob.sfob006,sfob010=0
                   WHERE sfobent=g_enterprise AND sfobsite=g_site
                     AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                     AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
                     AND sfob901 != '4'               
               ELSE
                  UPDATE sfob_t SET sfob009='MULT',sfob010=0
                   WHERE sfobent=g_enterprise AND sfobsite=g_site
                     AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                     AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
                     AND sfob901 != '4'
               END IF
            WHEN l_n = 0  #都不是別人的上站
               UPDATE sfob_t SET sfob009 = 'END',sfob010 = 0
                WHERE sfobent = g_enterprise AND sfobsite = g_site
                  AND sfobdocno = g_sfoa_m.sfoadocno AND sfob001 = g_sfoa_m.sfoa001
                  AND sfob002 = l_sfob.sfob002
                  AND sfob901 != '4'
                  AND sfob900=g_sfoa_m.sfoa900
         END CASE
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "sfob_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
        #160113-00001#1 add end         
        #160113-00001#1 mark str
         #ELSE
         #   SELECT COUNT(DISTINCT sfoc003) INTO l_n2 FROM sfoc_t
         #    WHERE sfocent=g_enterprise AND sfocsite=g_site
         #      AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001=g_sfoa_m.sfoa001 
         #      AND sfoc003=l_sfoc.sfoc003 AND sfoc004=l_sfoc.sfoc004
         #      AND sfoc900=g_sfoa_m.sfoa900 AND sfoc901 != '4'
         #   SELECT COUNT(DISTINCT sfoc004) INTO l_n3 FROM sfoc_t
         #    WHERE sfocent=g_enterprise AND sfocsite=g_site
         #      AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001=g_sfoa_m.sfoa001 
         #      AND sfoc003=l_sfoc.sfoc003 AND sfoc004=l_sfoc.sfoc004
         #      AND sfoc900=g_sfoa_m.sfoa900 AND sfoc901 != '4'
         #   IF l_n2 = 1 AND l_n3 = 1 THEN         
         #      UPDATE sfob_t SET sfob009='MULT',sfob010=0
         #       WHERE sfobent=g_enterprise AND sfobsite=g_site 
         #         AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
         #         AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
         #         AND sfob901 != '4'
         #   ELSE
         #      UPDATE sfob_t SET sfob009=l_sfob.sfob006,sfob010=0
         #       WHERE sfobent=g_enterprise AND sfobsite=g_site 
         #         AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
         #         AND sfob003=l_sfoc.sfoc003 AND sfob004=l_sfoc.sfoc004
         #         AND sfob901 != '4'
         #   END IF
         #   IF SQLCA.sqlcode THEN
         #         INITIALIZE g_errparam TO NULL
         #         LET g_errparam.code = SQLCA.sqlcode
         #         LET g_errparam.extend = "sfob_t"
         #         LET g_errparam.popup = TRUE
         #         CALL cl_err()
         #         RETURN r_success
         #   END IF
         #END IF
        #160113-00001#1 mark end
        
         SELECT COUNT(*) INTO l_n1 FROM sfob_t
          WHERE sfobent=g_enterprise AND sfobsite=g_site 
            AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
            AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003
            AND (sfob003 NOT IN (SELECT sfob007 FROM sfob_t 
                                  WHERE sfobent=g_enterprise AND sfobsite=g_site
                                    AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                                    AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003 
                                    AND sfob901 != '4') OR
                 sfob004 NOT IN (SELECT sfob008 FROM sfob_t 
                                  WHERE sfobent=g_enterprise AND sfobsite=g_site
                                    AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
                                    AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003
                                    AND sfob901 != '4'))
            AND sfob901 != '4'
         IF l_n1 > 0 THEN
            IF NOT cl_null(l_sfob.sfob006) THEN
               UPDATE sfob_t SET sfob009=l_sfob.sfob006,sfob010='0'
                WHERE sfobent=g_enterprise AND sfobsite=g_site 
                  AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                  AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003
                  AND (sfob003 NOT IN (SELECT sfob007 FROM sfob_t
                                        WHERE sfobent=g_enterprise AND sfobsite=g_site
                                          AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                                          AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003 
                                          AND sfob901 != '4') OR
                       sfob004 NOT IN (SELECT sfob008 FROM sfob_t
                                        WHERE sfobent=g_enterprise AND sfobsite=g_site
                                          AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
                                          AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003
                                          AND sfob901 != '4'))
                  AND sfob901 != '4'                 
            ELSE
               UPDATE sfob_t SET sfob009=l_sfob.sfob003,sfob010=l_sfob.sfob004
                WHERE sfobent=g_enterprise AND sfobsite=g_site AND sfobdocno=g_sfoa_m.sfoadocno
                  AND sfob001=g_sfoa_m.sfoa001 AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003
                  AND (sfob003 NOT IN (SELECT sfob007 FROM sfob_t
                                        WHERE sfobent=g_enterprise AND sfobsite=g_site
                                          AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
                                          AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003 
                                          AND sfob901 != '4') OR
                       sfob004 NOT IN (SELECT sfob008 FROM sfob_t 
                                        WHERE sfobent=g_enterprise AND sfobsite=g_site
                                          AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
                                          AND sfob900=g_sfoa_m.sfoa900 AND sfob006=l_sfoc.sfoc003 
                                          AND sfob901 != '4'))
                  AND sfob901 != '4'
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfob_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN r_success
            END IF
         END IF
      END FOREACH
      
     #160113-00001#1 mark str
      ##若当站对应下站不存在或者为空，则更新下站作业+下站作业序END+0
      #SELECT sfob009,sfob010 INTO l_sfob009,l_sfob010 FROM sfob_t 
      # WHERE sfobent=g_enterprise AND sfobsite=g_site
      #   AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
      #   AND sfob002=l_sfob.sfob002
      #   AND sfob901 != '4' AND sfob900=g_sfoa_m.sfoa900
      #IF NOT cl_null(l_sfob009) AND NOT cl_null(l_sfob010) THEN
      #   SELECT COUNT(*) INTO l_n0 FROM sfoc_t
      #    WHERE sfocent=g_enterprise AND sfocsite=g_site
      #      AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001=g_sfoa_m.sfoa001 
      #      AND sfoc003=l_sfob009 AND sfoc004=l_sfob010
      #      AND sfoc901 != '4' AND sfoc900=g_sfoa_m.sfoa900
      #   IF l_n0 = 0 THEN
      #      IF l_sfob.sfob009 = 'MULT' THEN
      #         SELECT COUNT(*) INTO l_n0 FROM sfoc_t
      #          WHERE sfocent=g_enterprise AND sfocsite=g_site
      #            AND sfocdocno=g_sfoa_m.sfoadocno AND sfoc001=g_sfoa_m.sfoa001 
      #            AND sfoc003=l_sfob.sfob003 AND sfoc004=l_sfob.sfob004
      #            AND sfoc901 != '4' AND sfoc900=g_sfoa_m.sfoa900
      #      ELSE
      #         #群组
      #         SELECT COUNT(*) INTO l_n0 FROM sfob_t
      #          WHERE sfobent=g_enterprise AND sfobsite=g_site 
      #            AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001                   
      #            AND sfob007=l_sfob.sfob003 AND sfob008=l_sfob.sfob004 AND sfob006=l_sfob009
      #            AND sfob901 != '4' AND sfob900=g_sfoa_m.sfoa900
      #         IF l_n0 = 0 THEN
      #            SELECT COUNT(*) INTO l_n0 FROM sfob_t
      #             WHERE sfobent=g_enterprise AND sfobsite=g_site
      #               AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001 
      #               AND sfob003=l_sfob009 AND sfob004=l_sfob010 AND sfob007=l_sfob.sfob006
      #               AND sfob901 != '4' AND sfob900=g_sfoa_m.sfoa900
      #            IF l_n0 = 0 THEN
      #               SELECT COUNT(*) INTO l_n0 FROM sfob_t
      #                WHERE sfobent=g_enterprise AND sfobsite=g_site
      #                  AND sfobdocno=g_sfoa_m.sfoadocno AND sfob001=g_sfoa_m.sfoa001
      #                  AND sfob006=l_sfob009 AND sfob007=l_sfob.sfob006
      #                  AND sfob901 != '4' AND sfob900=g_sfoa_m.sfoa900
      #            END IF
      #         END IF
      #      END IF
      #   END IF
      #END IF
      #IF cl_null(l_sfob009) OR l_n0 = 0 THEN           
      #   UPDATE sfob_t SET sfob009 = 'END',sfob010 = 0
      #    WHERE sfobent = g_enterprise
      #      AND sfobsite = g_site
      #      AND sfobdocno = g_sfoa_m.sfoadocno
      #      AND sfob001 = g_sfoa_m.sfoa001
      #      AND sfob002 = l_sfob.sfob002
      #      AND sfob901 != '4'
      #      AND sfob900=g_sfoa_m.sfoa900
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "UPDATE sfob_t"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN r_success
      #   END IF
      #END IF
     #160113-00001#1 mark end
      INITIALIZE l_sfob.* TO NULL
   END FOREACH
   
   #写入变更历程档，新增、修改、删除的时候可能会异动到其他资料，例如上下站资料，故重新抓取资料进行写入
   INITIALIZE l_sfob.* TO NULL
   #161109-00085#36-s
   #FOREACH asft801_upd_sfob009_cs0 INTO l_sfob.*
   FOREACH asft801_upd_sfob009_cs0 
   INTO l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
        l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
        l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
        l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
        l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
        l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
        l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
        l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
        l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
        l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
        l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
        l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
        l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055
   #161109-00085#36-e
      IF l_sfob.sfob901 = '1' THEN
         UPDATE sfob_t SET sfob901 = '2' 
          WHERE sfobent = g_enterprise AND sfobsite = g_site
            AND sfobdocno = g_sfoa_m.sfoadocno AND sfob001 = g_sfoa_m.sfoa001
            AND sfob002 = l_sfob.sfob002 AND sfob900 = g_sfoa_m.sfoa900
      END IF
      IF NOT asft801_upd_sfob_sfoe(g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,l_sfob.sfob002,g_sfoa_m.sfoa900) THEN 
         RETURN r_success
      END IF
      INITIALIZE l_sfob.* TO NULL   
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#工单单号、RunCard 检查
PRIVATE FUNCTION asft801_sfoadocno_chk()
DEFINE r_success                   LIKE type_t.num5
DEFINE l_sql                       STRING
DEFINE l_n                         LIKE type_t.num5
DEFINE l_success                   LIKE type_t.num5
DEFINE l_ooba002                   LIKE ooba_t.ooba002
DEFINE l_sfcb003                   LIKE sfcb_t.sfcb003
DEFINE l_sfcb004                   LIKE sfcb_t.sfcb003
DEFINE l_cnt                       LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_sfaa061                   LIKE sfaa_t.sfaa061  #工艺工单否 161116-00063#1 add

   LET r_success = FALSE
   IF cl_null(g_sfoa_m.sfoadocno) AND cl_null(g_sfoa_m.sfoa001) THEN
      RETURN r_success
   END IF
   
   IF NOT cl_null(g_sfoa_m.sfoadocno) THEN
      #161116-00063#1 add--s
      SELECT sfaa061 INTO l_sfaa061 FROM sfaa_t
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = g_sfoa_m.sfoadocno
      IF l_sfaa061 = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00793'
         LET g_errparam.extend = g_sfoa_m.sfoadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN r_success
      END IF
      #161116-00063#1 add--e
      LET l_sql = "SELECT COUNT(*) FROM sfca_t,sfaa_t ", 
                  " WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno ",
                  "   AND sfaaent = ",g_enterprise," AND sfaasite = '",g_site,"'",
                  "   AND sfaadocno = '",g_sfoa_m.sfoadocno,"' AND (sfaastus = 'Y' OR sfaastus = 'F')"
      IF NOT cl_null(g_sfoa_m.sfoa001) THEN
         LET l_sql = l_sql," AND sfca001 = ",g_sfoa_m.sfoa001
      END IF
      PREPARE asft801_sfoadocno_chk_pre FROM l_sql
      EXECUTE asft801_sfoadocno_chk_pre INTO l_n
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00427'
         LET g_errparam.extend = g_sfoa_m.sfoadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN r_success
      END IF

#160419-00036 by whitney mark start
#      CALL s_aooi200_get_slip(g_sfoa_m.sfoadocno) RETURNING l_success,l_ooba002
#      IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0023') = 'N' THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00333'
#         LET g_errparam.extend = g_sfoa_m.sfoadocno
#         LET g_errparam.popup = TRUE
#         CALL cl_err()   
#         RETURN r_success
#      END IF
#160419-00036 by whitney mark end
      
      #同一张制程单不可有多张未确认的变更单
      IF NOT cl_null(g_sfoa_m.sfoa001) THEN
      
         #變更的時候增加判斷如果是製程最終站已報工，就不能再變更
         ##160727-00025#3-s               
         SELECT DISTINCT sfcb003,sfcb004 INTO l_sfcb003,l_sfcb004 FROM sfcb_t
          WHERE sfcbent = g_enterprise
            AND sfcbsite = g_site
            AND sfcbdocno = g_sfoa_m.sfoadocno
            AND sfcb001 = g_sfoa_m.sfoa001
            AND sfcb009 = 'END'
         SELECT COUNT(1) INTO l_cnt FROM sffb_t
          WHERE sffbent = g_enterprise
            AND sffb001 = '3' #報工
            AND sffb005 = g_sfoa_m.sfoadocno
            AND sffb006 = g_sfoa_m.sfoa001  
            AND sffb007 = l_sfcb003
            AND sffb008 = l_sfcb004
            AND sffbstus = 'Y'
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00795'
            LET g_errparam.extend = g_sfoa_m.sfoadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()    
            RETURN r_success            
         END IF               
         ##160727-00025#3-e       
         SELECT COUNT(*) INTO l_n FROM sfoa_t 
          WHERE sfoaent=g_enterprise AND sfoadocno=g_sfoa_m.sfoadocno
            AND sfoa001=g_sfoa_m.sfoa001 AND sfoastus='N'
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00425'
            LET g_errparam.extend = g_sfoa_m.sfoadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()    
            RETURN r_success
         END IF
         
         #變更序=變更單的變更序最大值+1
         SELECT MAX(sfoa900)+1 INTO g_sfoa_m.sfoa900 FROM sfoa_t
          WHERE sfoaent = g_enterprise
            AND sfoadocno = g_sfoa_m.sfoadocno
            AND sfoa001 = g_sfoa_m.sfoa001
         IF cl_null(g_sfoa_m.sfoa900) OR g_sfoa_m.sfoa900 = 0 THEN
            LET g_sfoa_m.sfoa900 = 1
         END IF
         DISPLAY BY NAME g_sfoa_m.sfoa900
      END IF
   END IF
         
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#单头相关栏位显示
PRIVATE FUNCTION asft801_desc()
#161109-00085#36-s
#DEFINE l_sfaa    RECORD LIKE sfaa_t.*
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
END RECORD
#161109-00085#36-e
DEFINE l_success   LIKE type_t.num5                 
DEFINE l_slip      STRING
   #161109-00085#36-s
   #SELECT * INTO l_sfaa.* FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site AND sfaadocno=g_sfoa_m.sfoadocno
   SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,
          sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
          sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,
          sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
          sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,
          sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
          sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,
          sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
          sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,
          sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
          sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,
          sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
          sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,
          sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
          sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,
          sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
          sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,
          sfaa070,sfaa071,sfaa072
     INTO l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,
          l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,
          l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,l_sfaa.sfaadocno,
          l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,
          l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,
          l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
          l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,
          l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,l_sfaa.sfaa023,l_sfaa.sfaa024,
          l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,
          l_sfaa.sfaa030,l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,
          l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,l_sfaa.sfaa039,
          l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,
          l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,
          l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
          l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,
          l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,l_sfaa.sfaa063,l_sfaa.sfaa064,
          l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,
          l_sfaa.sfaa070,l_sfaa.sfaa071,l_sfaa.sfaa072
     FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site AND sfaadocno=g_sfoa_m.sfoadocno
   #161109-00085#36-e
   LET g_sfoa_m.sfaa003 = l_sfaa.sfaa003
   LET g_sfoa_m.sfaa005 = l_sfaa.sfaa005
   LET g_sfoa_m.sfaa006 = l_sfaa.sfaa006
   LET g_sfoa_m.sfaa007 = l_sfaa.sfaa007
   LET g_sfoa_m.sfaa008 = l_sfaa.sfaa008
   LET g_sfoa_m.sfaa063 = l_sfaa.sfaa063
   LET g_sfoa_m.sfaa009 = l_sfaa.sfaa009
   LET g_sfoa_m.sfaa010 = l_sfaa.sfaa010
   LET g_sfoa_m.sfaa011 = l_sfaa.sfaa011
   LET g_sfoa_m.sfaa013 = l_sfaa.sfaa013
   LET g_sfoa_m.sfaa016 = l_sfaa.sfaa016
   LET g_sfoa_m.sfaa017 = l_sfaa.sfaa017
   LET g_sfoa_m.sfaa019 = l_sfaa.sfaa019
   LET g_sfoa_m.sfaa020 = l_sfaa.sfaa020
   DISPLAY BY NAME g_sfoa_m.sfaa003,g_sfoa_m.sfaa005,g_sfoa_m.sfaa006,g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfaa063,g_sfoa_m.sfaa009,
                   g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa013,g_sfoa_m.sfaa016,g_sfoa_m.sfaa017,g_sfoa_m.sfaa019,g_sfoa_m.sfaa020
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfaa010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfaa010_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfaa010_desc1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfaa010_desc1
            
   IF NOT cl_null(g_sfoa_m.sfaa009) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfoa_m.sfaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfoa_m.sfaa009_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_sfoa_m.sfaa009_desc
   END IF

   IF NOT cl_null(g_sfoa_m.sfaa010) AND NOT cl_null(g_sfoa_m.sfaa016) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfoa_m.sfaa010
      LET g_ref_fields[2] = g_sfoa_m.sfaa016
      CALL ap_ref_array2(g_ref_fields,"SELECT ecba003 FROM ecba_t WHERE ecbaent='"||g_enterprise||"' AND ecba001=? AND ecba002=? ","") RETURNING g_rtn_fields
      LET g_sfoa_m.sfaa016_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_sfoa_m.sfaa016_desc
   END IF
   
   IF l_sfaa.sfaa057 = '2' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_sfoa_m.sfaa017
      CALL cl_ref_val("v_pmaal004")
      LET g_sfoa_m.sfaa017_desc = g_chkparam.return1
      DISPLAY BY NAME g_sfoa_m.sfaa017_desc
   ELSE
      CALL s_desc_get_department_desc(g_sfoa_m.sfaa017) RETURNING g_sfoa_m.sfaa017_desc
      DISPLAY BY NAME g_sfoa_m.sfaa017_desc
   END IF
   
   CALL s_aooi200_get_slip(g_sfoa_m.sfoadocno) RETURNING l_success,l_slip
   CALL s_aooi200_get_slip_desc(l_slip)
     RETURNING g_sfoa_m.oobal004
   DISPLAY BY NAME g_sfoa_m.oobal004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoa905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoa905_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoa905_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoaownid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoaowndp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoacrtid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoacrtdp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoamodid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfoa_m.sfoacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_sfoa_m.sfoacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfoa_m.sfoacnfid_desc
 
END FUNCTION

#根据工单制程资料带出全部资料
PRIVATE FUNCTION asft801_gen()
DEFINE r_success              LIKE type_t.num5

   LET r_success = FALSE
   #变更单单头资料，sfoa_t
   IF NOT asft801_gen_sfoa() THEN
      RETURN r_success
   END IF
   
   #变更单制程资料
   IF NOT asft801_gen_sfob() THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生制程变更单单头资料
PRIVATE FUNCTION asft801_gen_sfoa()
DEFINE r_success              LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfca                 RECORD LIKE sfca_t.*
DEFINE l_sfca RECORD  #工單製程單頭檔
       sfcaent LIKE sfca_t.sfcaent, #企業編號
       sfcasite LIKE sfca_t.sfcasite, #營運據點
       sfcadocno LIKE sfca_t.sfcadocno, #單號
       sfca001 LIKE sfca_t.sfca001, #RUN CARD編號
       sfca002 LIKE sfca_t.sfca002, #變更版本
       sfca003 LIKE sfca_t.sfca003, #生產數量
       sfca004 LIKE sfca_t.sfca004, #完工數量
       sfca005 LIKE sfca_t.sfca005  #RUN CARD類型
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfoa                 RECORD LIKE sfoa_t.*
DEFINE l_sfoa RECORD  #工單製程變更單頭檔
       sfoaent LIKE sfoa_t.sfoaent, #企業編號
       sfoasite LIKE sfoa_t.sfoasite, #營運據點
       sfoadocno LIKE sfoa_t.sfoadocno, #工單單號
       sfoa001 LIKE sfoa_t.sfoa001, #RUN CARD編號
       sfoa002 LIKE sfoa_t.sfoa002, #變更版本
       sfoa003 LIKE sfoa_t.sfoa003, #生產數量
       sfoa004 LIKE sfoa_t.sfoa004, #完工數量
       sfoa900 LIKE sfoa_t.sfoa900, #變更序
       sfoa901 LIKE sfoa_t.sfoa901, #變更類型
       sfoa902 LIKE sfoa_t.sfoa902, #變更日期
       sfoa905 LIKE sfoa_t.sfoa905, #變更理由
       sfoa906 LIKE sfoa_t.sfoa906, #變更備註
       sfoaownid LIKE sfoa_t.sfoaownid, #資料所有者
       sfoaowndp LIKE sfoa_t.sfoaowndp, #資料所屬部門
       sfoacrtid LIKE sfoa_t.sfoacrtid, #資料建立者
       sfoacrtdp LIKE sfoa_t.sfoacrtdp, #資料建立部門
       sfoacrtdt LIKE sfoa_t.sfoacrtdt, #資料創建日
       sfoamodid LIKE sfoa_t.sfoamodid, #資料修改者
       sfoamoddt LIKE sfoa_t.sfoamoddt, #最近修改日
       sfoacnfid LIKE sfoa_t.sfoacnfid, #資料確認者
       sfoacnfdt LIKE sfoa_t.sfoacnfdt, #資料確認日
       sfoapstid LIKE sfoa_t.sfoapstid, #資料過帳者
       sfoapstdt LIKE sfoa_t.sfoapstdt, #資料過帳日
       sfoastus LIKE sfoa_t.sfoastus, #狀態碼
       sfoa005 LIKE sfoa_t.sfoa005, #RUN CARD類型
       sfoaud001 LIKE sfoa_t.sfoaud001, #自定義欄位(文字)001
       sfoaud002 LIKE sfoa_t.sfoaud002, #自定義欄位(文字)002
       sfoaud003 LIKE sfoa_t.sfoaud003, #自定義欄位(文字)003
       sfoaud004 LIKE sfoa_t.sfoaud004, #自定義欄位(文字)004
       sfoaud005 LIKE sfoa_t.sfoaud005, #自定義欄位(文字)005
       sfoaud006 LIKE sfoa_t.sfoaud006, #自定義欄位(文字)006
       sfoaud007 LIKE sfoa_t.sfoaud007, #自定義欄位(文字)007
       sfoaud008 LIKE sfoa_t.sfoaud008, #自定義欄位(文字)008
       sfoaud009 LIKE sfoa_t.sfoaud009, #自定義欄位(文字)009
       sfoaud010 LIKE sfoa_t.sfoaud010, #自定義欄位(文字)010
       sfoaud011 LIKE sfoa_t.sfoaud011, #自定義欄位(數字)011
       sfoaud012 LIKE sfoa_t.sfoaud012, #自定義欄位(數字)012
       sfoaud013 LIKE sfoa_t.sfoaud013, #自定義欄位(數字)013
       sfoaud014 LIKE sfoa_t.sfoaud014, #自定義欄位(數字)014
       sfoaud015 LIKE sfoa_t.sfoaud015, #自定義欄位(數字)015
       sfoaud016 LIKE sfoa_t.sfoaud016, #自定義欄位(數字)016
       sfoaud017 LIKE sfoa_t.sfoaud017, #自定義欄位(數字)017
       sfoaud018 LIKE sfoa_t.sfoaud018, #自定義欄位(數字)018
       sfoaud019 LIKE sfoa_t.sfoaud019, #自定義欄位(數字)019
       sfoaud020 LIKE sfoa_t.sfoaud020, #自定義欄位(數字)020
       sfoaud021 LIKE sfoa_t.sfoaud021, #自定義欄位(日期時間)021
       sfoaud022 LIKE sfoa_t.sfoaud022, #自定義欄位(日期時間)022
       sfoaud023 LIKE sfoa_t.sfoaud023, #自定義欄位(日期時間)023
       sfoaud024 LIKE sfoa_t.sfoaud024, #自定義欄位(日期時間)024
       sfoaud025 LIKE sfoa_t.sfoaud025, #自定義欄位(日期時間)025
       sfoaud026 LIKE sfoa_t.sfoaud026, #自定義欄位(日期時間)026
       sfoaud027 LIKE sfoa_t.sfoaud027, #自定義欄位(日期時間)027
       sfoaud028 LIKE sfoa_t.sfoaud028, #自定義欄位(日期時間)028
       sfoaud029 LIKE sfoa_t.sfoaud029, #自定義欄位(日期時間)029
       sfoaud030 LIKE sfoa_t.sfoaud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#36-e
DEFINE l_sfoacrtdt            DATETIME YEAR TO SECOND  #资料建立日期

   LET r_success = FALSE
   #161109-00085#36-s
   #SELECT * INTO l_sfca.* FROM sfca_t 
   SELECT sfcaent,sfcasite,sfcadocno,sfca001,sfca002,
          sfca003,sfca004,sfca005
     INTO l_sfca.sfcaent,l_sfca.sfcasite,l_sfca.sfcadocno,l_sfca.sfca001,l_sfca.sfca002,
          l_sfca.sfca003,l_sfca.sfca004,l_sfca.sfca005 
     FROM sfca_t 
   #161109-00085#36-e
    WHERE sfcaent = g_enterprise
      AND sfcadocno = g_sfoa_m.sfoadocno
      AND sfca001 = g_sfoa_m.sfoa001
   
   LET l_sfoa.sfoaent = g_enterprise
   LET l_sfoa.sfoasite = g_site
   LET l_sfoa.sfoadocno = l_sfca.sfcadocno
   LET l_sfoa.sfoa001 = l_sfca.sfca001
   LET l_sfoa.sfoa002 = l_sfca.sfca002 + 1  #變更版本=[T:工單製程單頭檔].[C:變更版本]加1  #160222-00017#1 mod
   LET l_sfoa.sfoa003 = l_sfca.sfca003
   LET l_sfoa.sfoa004 = l_sfca.sfca004
   LET l_sfoa.sfoa005 = l_sfca.sfca005
   LET l_sfoa.sfoa900 = g_sfoa_m.sfoa900
   LET l_sfoa.sfoa901 = 'N'
   LET l_sfoa.sfoa902 = cl_get_current()
   LET l_sfoa.sfoaownid =  g_user
   LET l_sfoa.sfoaowndp =  g_dept
   LET l_sfoa.sfoacrtid =  g_user
   LET l_sfoa.sfoacrtdp =  g_dept 
   LET l_sfoa.sfoacrtdt =  ""
   LET l_sfoa.sfoamodid =  ""
   LET l_sfoa.sfoamoddt =  ""
   LET l_sfoa.sfoacnfid =  ""
   LET l_sfoa.sfoacnfdt =  ""
   LET l_sfoa.sfoapstid =  ""
   LET l_sfoa.sfoapstdt =  ""
   LET l_sfoa.sfoastus  =  "N"
   
   #161109-00085#36-s
   #INSERT INTO sfoa_t VALUES l_sfoa.*
   INSERT INTO sfoa_t( sfoaent,sfoasite,sfoadocno,sfoa001,sfoa002,
                       sfoa003,sfoa004,sfoa900,sfoa901,sfoa902,
                       sfoa905,sfoa906,sfoaownid,sfoaowndp,sfoacrtid,
                       sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,
                       sfoacnfdt,sfoapstid,sfoapstdt,sfoastus,sfoa005,
                       sfoaud001,sfoaud002,sfoaud003,sfoaud004,sfoaud005,
                       sfoaud006,sfoaud007,sfoaud008,sfoaud009,sfoaud010,
                       sfoaud011,sfoaud012,sfoaud013,sfoaud014,sfoaud015,
                       sfoaud016,sfoaud017,sfoaud018,sfoaud019,sfoaud020,
                       sfoaud021,sfoaud022,sfoaud023,sfoaud024,sfoaud025,
                       sfoaud026,sfoaud027,sfoaud028,sfoaud029,sfoaud030)
              VALUES (l_sfoa.sfoaent,l_sfoa.sfoasite,l_sfoa.sfoadocno,l_sfoa.sfoa001,l_sfoa.sfoa002,
                      l_sfoa.sfoa003,l_sfoa.sfoa004,l_sfoa.sfoa900,l_sfoa.sfoa901,l_sfoa.sfoa902,
                      #170109-00038#1-s-mod
#                      l_sfoa.sfoa905,l_sfoa.sfoa906,l_sfoa.sfoaownid,sfoaowndp,sfoacrtid,
                      l_sfoa.sfoa905,l_sfoa.sfoa906,l_sfoa.sfoaownid,l_sfoa.sfoaowndp,l_sfoa.sfoacrtid,
                      #170109-00038#1-e-mod
                      l_sfoa.sfoacrtdp,l_sfoa.sfoacrtdt,l_sfoa.sfoamodid,l_sfoa.sfoamoddt,l_sfoa.sfoacnfid,
                      l_sfoa.sfoacnfdt,l_sfoa.sfoapstid,l_sfoa.sfoapstdt,l_sfoa.sfoastus,l_sfoa.sfoa005,
                      l_sfoa.sfoaud001,l_sfoa.sfoaud002,l_sfoa.sfoaud003,l_sfoa.sfoaud004,l_sfoa.sfoaud005,
                      l_sfoa.sfoaud006,l_sfoa.sfoaud007,l_sfoa.sfoaud008,l_sfoa.sfoaud009,l_sfoa.sfoaud010,
                      l_sfoa.sfoaud011,l_sfoa.sfoaud012,l_sfoa.sfoaud013,l_sfoa.sfoaud014,l_sfoa.sfoaud015,
                      l_sfoa.sfoaud016,l_sfoa.sfoaud017,l_sfoa.sfoaud018,l_sfoa.sfoaud019,l_sfoa.sfoaud020,
                      l_sfoa.sfoaud021,l_sfoa.sfoaud022,l_sfoa.sfoaud023,l_sfoa.sfoaud024,l_sfoa.sfoaud025,
                      l_sfoa.sfoaud026,l_sfoa.sfoaud027,l_sfoa.sfoaud028,l_sfoa.sfoaud029,l_sfoa.sfoaud030)   
   #161109-00085#36-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT sfoa_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   LET l_sfoacrtdt =  cl_get_current()
   UPDATE sfoa_t SET sfoacrtdt = l_sfoacrtdt 
    WHERE sfoaent = g_enterprise AND sfoasite = g_site
      AND sfoadocno = l_sfoa.sfoadocno AND sfoa001 = l_sfoa.sfoa001
      AND sfoa900 = l_sfoa.sfoa900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE sfoa_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生单身制程资料
PRIVATE FUNCTION asft801_gen_sfob()
DEFINE r_success              LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcb                 RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfob         RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       sfob055 LIKE sfob_t.sfob055, #回收站
       sfobud001 LIKE sfob_t.sfobud001, #自定義欄位(文字)001
       sfobud002 LIKE sfob_t.sfobud002, #自定義欄位(文字)002
       sfobud003 LIKE sfob_t.sfobud003, #自定義欄位(文字)003
       sfobud004 LIKE sfob_t.sfobud004, #自定義欄位(文字)004
       sfobud005 LIKE sfob_t.sfobud005, #自定義欄位(文字)005
       sfobud006 LIKE sfob_t.sfobud006, #自定義欄位(文字)006
       sfobud007 LIKE sfob_t.sfobud007, #自定義欄位(文字)007
       sfobud008 LIKE sfob_t.sfobud008, #自定義欄位(文字)008
       sfobud009 LIKE sfob_t.sfobud009, #自定義欄位(文字)009
       sfobud010 LIKE sfob_t.sfobud010, #自定義欄位(文字)010
       sfobud011 LIKE sfob_t.sfobud011, #自定義欄位(數字)011
       sfobud012 LIKE sfob_t.sfobud012, #自定義欄位(數字)012
       sfobud013 LIKE sfob_t.sfobud013, #自定義欄位(數字)013
       sfobud014 LIKE sfob_t.sfobud014, #自定義欄位(數字)014
       sfobud015 LIKE sfob_t.sfobud015, #自定義欄位(數字)015
       sfobud016 LIKE sfob_t.sfobud016, #自定義欄位(數字)016
       sfobud017 LIKE sfob_t.sfobud017, #自定義欄位(數字)017
       sfobud018 LIKE sfob_t.sfobud018, #自定義欄位(數字)018
       sfobud019 LIKE sfob_t.sfobud019, #自定義欄位(數字)019
       sfobud020 LIKE sfob_t.sfobud020, #自定義欄位(數字)020
       sfobud021 LIKE sfob_t.sfobud021, #自定義欄位(日期時間)021
       sfobud022 LIKE sfob_t.sfobud022, #自定義欄位(日期時間)022
       sfobud023 LIKE sfob_t.sfobud023, #自定義欄位(日期時間)023
       sfobud024 LIKE sfob_t.sfobud024, #自定義欄位(日期時間)024
       sfobud025 LIKE sfob_t.sfobud025, #自定義欄位(日期時間)025
       sfobud026 LIKE sfob_t.sfobud026, #自定義欄位(日期時間)026
       sfobud027 LIKE sfob_t.sfobud027, #自定義欄位(日期時間)027
       sfobud028 LIKE sfob_t.sfobud028, #自定義欄位(日期時間)028
       sfobud029 LIKE sfob_t.sfobud029, #自定義欄位(日期時間)029
       sfobud030 LIKE sfob_t.sfobud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#36-e

   LET r_success = FALSE
   DECLARE asft801_gen_sfob CURSOR FOR
   #161109-00085#36-s
   #SELECT * FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
   SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
          sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
          sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
          sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
          sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
          sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
          sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
          sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
          sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
          sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
          sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
          sfcb053,sfcb054,sfcb055
     FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
   #161109-00085#36-e 
       AND sfcbdocno = g_sfoa_m.sfoadocno AND sfcb001 = g_sfoa_m.sfoa001
   #161109-00085#36-s       
   #FOREACH asft801_gen_sfob INTO l_sfcb.*
   FOREACH asft801_gen_sfob 
   INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
        l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
        l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
        l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
        l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
        l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
        l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
        l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
        l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
        l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
        l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
        l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
   #161109-00085#36-e   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfob.sfobent = g_enterprise 
      LET l_sfob.sfobsite = g_site
      LET l_sfob.sfobdocno = l_sfcb.sfcbdocno
      LET l_sfob.sfob001 = l_sfcb.sfcb001
      LET l_sfob.sfob002 = l_sfcb.sfcb002
      LET l_sfob.sfob003 = l_sfcb.sfcb003
      LET l_sfob.sfob004 = l_sfcb.sfcb004
      LET l_sfob.sfob005 = l_sfcb.sfcb005
      LET l_sfob.sfob006 = l_sfcb.sfcb006
      LET l_sfob.sfob007 = l_sfcb.sfcb007
      LET l_sfob.sfob008 = l_sfcb.sfcb008
      LET l_sfob.sfob009 = l_sfcb.sfcb009
      LET l_sfob.sfob010 = l_sfcb.sfcb010
      LET l_sfob.sfob011 = l_sfcb.sfcb011
      LET l_sfob.sfob012 = l_sfcb.sfcb012
      LET l_sfob.sfob013 = l_sfcb.sfcb013
      LET l_sfob.sfob014 = l_sfcb.sfcb014
      LET l_sfob.sfob015 = l_sfcb.sfcb015
      LET l_sfob.sfob016 = l_sfcb.sfcb016
      LET l_sfob.sfob017 = l_sfcb.sfcb017
      LET l_sfob.sfob018 = l_sfcb.sfcb018
      LET l_sfob.sfob019 = l_sfcb.sfcb019
      LET l_sfob.sfob020 = l_sfcb.sfcb020
      LET l_sfob.sfob021 = l_sfcb.sfcb021
      LET l_sfob.sfob022 = l_sfcb.sfcb022
      LET l_sfob.sfob023 = l_sfcb.sfcb023
      LET l_sfob.sfob024 = l_sfcb.sfcb024
      LET l_sfob.sfob025 = l_sfcb.sfcb025
      LET l_sfob.sfob026 = l_sfcb.sfcb026
      LET l_sfob.sfob027 = l_sfcb.sfcb027
      LET l_sfob.sfob028 = l_sfcb.sfcb028
      LET l_sfob.sfob029 = l_sfcb.sfcb029
      LET l_sfob.sfob030 = l_sfcb.sfcb030
      LET l_sfob.sfob031 = l_sfcb.sfcb031
      LET l_sfob.sfob032 = l_sfcb.sfcb032
      LET l_sfob.sfob033 = l_sfcb.sfcb033
      LET l_sfob.sfob034 = l_sfcb.sfcb034
      LET l_sfob.sfob035 = l_sfcb.sfcb035
      LET l_sfob.sfob036 = l_sfcb.sfcb036
      LET l_sfob.sfob037 = l_sfcb.sfcb037
      LET l_sfob.sfob038 = l_sfcb.sfcb038
      LET l_sfob.sfob039 = l_sfcb.sfcb039
      LET l_sfob.sfob040 = l_sfcb.sfcb040
      LET l_sfob.sfob041 = l_sfcb.sfcb041
      LET l_sfob.sfob042 = l_sfcb.sfcb042
      LET l_sfob.sfob043 = l_sfcb.sfcb043
      LET l_sfob.sfob044 = l_sfcb.sfcb044
      LET l_sfob.sfob045 = l_sfcb.sfcb045
      LET l_sfob.sfob046 = l_sfcb.sfcb046
      LET l_sfob.sfob047 = l_sfcb.sfcb047
      LET l_sfob.sfob048 = l_sfcb.sfcb048
      LET l_sfob.sfob049 = l_sfcb.sfcb049
      LET l_sfob.sfob050 = l_sfcb.sfcb050
      LET l_sfob.sfob051 = l_sfcb.sfcb051
      LET l_sfob.sfob052 = l_sfcb.sfcb052
      LET l_sfob.sfob053 = l_sfcb.sfcb053
      LET l_sfob.sfob054 = l_sfcb.sfcb054
      LET l_sfob.sfob055 = l_sfcb.sfcb055     
      LET l_sfob.sfob900 = g_sfoa_m.sfoa900
      LET l_sfob.sfob901 = '1'
      #161109-00085#36-s
      #INSERT INTO sfob_t VALUES l_sfob.*
      INSERT INTO sfob_t( sfobent,sfobsite,sfobdocno,sfob001,sfob002,
                          sfob003,sfob004,sfob005,sfob006,sfob007,
                          sfob008,sfob009,sfob010,sfob011,sfob012,
                          sfob013,sfob014,sfob015,sfob016,sfob017,
                          sfob018,sfob019,sfob020,sfob021,sfob022,
                          sfob023,sfob024,sfob025,sfob026,sfob027,
                          sfob028,sfob029,sfob030,sfob031,sfob032,
                          sfob033,sfob034,sfob035,sfob036,sfob037,
                          sfob038,sfob039,sfob040,sfob041,sfob042,
                          sfob043,sfob044,sfob045,sfob046,sfob047,
                          sfob048,sfob049,sfob050,sfob051,sfob052,
                          sfob053,sfob054,sfob900,sfob901,sfob902,
                          sfob905,sfob906,sfob055,sfobud001,sfobud002,
                          sfobud003,sfobud004,sfobud005,sfobud006,sfobud007,
                          sfobud008,sfobud009,sfobud010,sfobud011,sfobud012,
                          sfobud013,sfobud014,sfobud015,sfobud016,sfobud017,
                          sfobud018,sfobud019,sfobud020,sfobud021,sfobud022,
                          sfobud023,sfobud024,sfobud025,sfobud026,sfobud027,
                          sfobud028,sfobud029,sfobud030)
                  VALUES (l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
                          l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
                          l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
                          l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
                          l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
                          l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
                          l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
                          l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
                          l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
                          l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
                          l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
                          l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
                          l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055,l_sfob.sfobud001,l_sfob.sfobud002,
                          l_sfob.sfobud003,l_sfob.sfobud004,l_sfob.sfobud005,l_sfob.sfobud006,l_sfob.sfobud007,
                          l_sfob.sfobud008,l_sfob.sfobud009,l_sfob.sfobud010,l_sfob.sfobud011,l_sfob.sfobud012,
                          l_sfob.sfobud013,l_sfob.sfobud014,l_sfob.sfobud015,l_sfob.sfobud016,l_sfob.sfobud017,
                          l_sfob.sfobud018,l_sfob.sfobud019,l_sfob.sfobud020,l_sfob.sfobud021,l_sfob.sfobud022,
                          l_sfob.sfobud023,l_sfob.sfobud024,l_sfob.sfobud025,l_sfob.sfobud026,l_sfob.sfobud027,
                          l_sfob.sfobud028,l_sfob.sfobud029,l_sfob.sfobud030)
      #161109-00085#36-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfob_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      
      #变更单多上站资料
      IF NOT asft801_gen_sfoc(l_sfcb.sfcb002) THEN
         RETURN r_success
      END IF
      
      #变更单check in/out资料
      IF NOT asft801_gen_sfod(l_sfcb.sfcb002) THEN
         RETURN r_success
      END IF
      INITIALIZE l_sfcb.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生制程多上站资料
PRIVATE FUNCTION asft801_gen_sfoc(p_sfoc002)
DEFINE p_sfoc002              LIKE sfoc_t.sfoc002
DEFINE r_success              LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcc                 RECORD LIKE sfcc_t.*
DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
       sfcc004 LIKE sfcc_t.sfcc004  #上站作業序
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfoc         RECORD LIKE sfoc_t.*
DEFINE l_sfoc RECORD  #工單製程變更上站作業資料
       sfocent LIKE sfoc_t.sfocent, #企業編號
       sfocsite LIKE sfoc_t.sfocsite, #營運據點
       sfocdocno LIKE sfoc_t.sfocdocno, #工單單號
       sfoc001 LIKE sfoc_t.sfoc001, #RUN CARD
       sfoc002 LIKE sfoc_t.sfoc002, #項次
       sfoc003 LIKE sfoc_t.sfoc003, #上站作業
       sfoc004 LIKE sfoc_t.sfoc004, #上站製程式
       sfoc900 LIKE sfoc_t.sfoc900, #變更序
       sfoc901 LIKE sfoc_t.sfoc901, #變更類型
       sfoc902 LIKE sfoc_t.sfoc902, #變更日期
       sfoc905 LIKE sfoc_t.sfoc905, #變更理由
       sfoc906 LIKE sfoc_t.sfoc906, #變更備註
       sfocseq LIKE sfoc_t.sfocseq, #項序
       sfocud001 LIKE sfoc_t.sfocud001, #自定義欄位(文字)001
       sfocud002 LIKE sfoc_t.sfocud002, #自定義欄位(文字)002
       sfocud003 LIKE sfoc_t.sfocud003, #自定義欄位(文字)003
       sfocud004 LIKE sfoc_t.sfocud004, #自定義欄位(文字)004
       sfocud005 LIKE sfoc_t.sfocud005, #自定義欄位(文字)005
       sfocud006 LIKE sfoc_t.sfocud006, #自定義欄位(文字)006
       sfocud007 LIKE sfoc_t.sfocud007, #自定義欄位(文字)007
       sfocud008 LIKE sfoc_t.sfocud008, #自定義欄位(文字)008
       sfocud009 LIKE sfoc_t.sfocud009, #自定義欄位(文字)009
       sfocud010 LIKE sfoc_t.sfocud010, #自定義欄位(文字)010
       sfocud011 LIKE sfoc_t.sfocud011, #自定義欄位(數字)011
       sfocud012 LIKE sfoc_t.sfocud012, #自定義欄位(數字)012
       sfocud013 LIKE sfoc_t.sfocud013, #自定義欄位(數字)013
       sfocud014 LIKE sfoc_t.sfocud014, #自定義欄位(數字)014
       sfocud015 LIKE sfoc_t.sfocud015, #自定義欄位(數字)015
       sfocud016 LIKE sfoc_t.sfocud016, #自定義欄位(數字)016
       sfocud017 LIKE sfoc_t.sfocud017, #自定義欄位(數字)017
       sfocud018 LIKE sfoc_t.sfocud018, #自定義欄位(數字)018
       sfocud019 LIKE sfoc_t.sfocud019, #自定義欄位(數字)019
       sfocud020 LIKE sfoc_t.sfocud020, #自定義欄位(數字)020
       sfocud021 LIKE sfoc_t.sfocud021, #自定義欄位(日期時間)021
       sfocud022 LIKE sfoc_t.sfocud022, #自定義欄位(日期時間)022
       sfocud023 LIKE sfoc_t.sfocud023, #自定義欄位(日期時間)023
       sfocud024 LIKE sfoc_t.sfocud024, #自定義欄位(日期時間)024
       sfocud025 LIKE sfoc_t.sfocud025, #自定義欄位(日期時間)025
       sfocud026 LIKE sfoc_t.sfocud026, #自定義欄位(日期時間)026
       sfocud027 LIKE sfoc_t.sfocud027, #自定義欄位(日期時間)027
       sfocud028 LIKE sfoc_t.sfocud028, #自定義欄位(日期時間)028
       sfocud029 LIKE sfoc_t.sfocud029, #自定義欄位(日期時間)029
       sfocud030 LIKE sfoc_t.sfocud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#36-e
DEFINE l_i                    LIKE type_t.num5

   LET r_success = FALSE
   DECLARE asft801_gen_sfcc CURSOR FOR
   #161109-00085#36-s
   #SELECT * FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site
   SELECT  sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,
           sfcc003,sfcc004
   FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site
   #161109-00085#36-e
       AND sfccdocno = g_sfoa_m.sfoadocno AND sfcc001 = g_sfoa_m.sfoa001
       AND sfcc002 = p_sfoc002 
       ORDER BY sfcc003,sfcc004
   LET l_i = 1
   #161109-00085#36-s
   #FOREACH asft801_gen_sfcc INTO l_sfcc.*
   FOREACH asft801_gen_sfcc 
   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
        l_sfcc.sfcc003,l_sfcc.sfcc004
   #161109-00085#36-e   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfoc.sfocent = g_enterprise 
      LET l_sfoc.sfocsite = g_site
      LET l_sfoc.sfocdocno = l_sfcc.sfccdocno
      LET l_sfoc.sfoc001 = l_sfcc.sfcc001
      LET l_sfoc.sfoc002 = l_sfcc.sfcc002
      LET l_sfoc.sfoc003 = l_sfcc.sfcc003
      LET l_sfoc.sfoc004 = l_sfcc.sfcc004
      LET l_sfoc.sfoc900 = g_sfoa_m.sfoa900
      LET l_sfoc.sfoc901 = '1'
      LET l_sfoc.sfocseq = l_i
      #161109-00085#36-s
      #INSERT INTO sfoc_t VALUES l_sfoc.*
      INSERT INTO sfoc_t( sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,
                          sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,
                          sfoc905,sfoc906,sfocseq,sfocud001,sfocud002,
                          sfocud003,sfocud004,sfocud005,sfocud006,sfocud007,
                          sfocud008,sfocud009,sfocud010,sfocud011,sfocud012,
                          sfocud013,sfocud014,sfocud015,sfocud016,sfocud017,
                          sfocud018,sfocud019,sfocud020,sfocud021,sfocud022,
                          sfocud023,sfocud024,sfocud025,sfocud026,sfocud027,
                          sfocud028,sfocud029,sfocud030)
          VALUES (l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
                  l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
                  l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq,l_sfoc.sfocud001,l_sfoc.sfocud002,
                  l_sfoc.sfocud003,l_sfoc.sfocud004,l_sfoc.sfocud005,l_sfoc.sfocud006,l_sfoc.sfocud007,
                  l_sfoc.sfocud008,l_sfoc.sfocud009,l_sfoc.sfocud010,l_sfoc.sfocud011,l_sfoc.sfocud012,
                  l_sfoc.sfocud013,l_sfoc.sfocud014,l_sfoc.sfocud015,l_sfoc.sfocud016,l_sfoc.sfocud017,
                  l_sfoc.sfocud018,l_sfoc.sfocud019,l_sfoc.sfocud020,l_sfoc.sfocud021,l_sfoc.sfocud022,
                  l_sfoc.sfocud023,l_sfoc.sfocud024,l_sfoc.sfocud025,l_sfoc.sfocud026,l_sfoc.sfocud027,
                  l_sfoc.sfocud028,l_sfoc.sfocud029,l_sfoc.sfocud030)
      #161109-00085#36-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfoc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_sfcc.* TO NULL   #清空数组
      LET l_i = l_i + 1
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生制程check in/out资料
PRIVATE FUNCTION asft801_gen_sfod(p_sfod002)
DEFINE p_sfod002              LIKE sfod_t.sfod002
DEFINE r_success              LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcd                 RECORD LIKE sfcd_t.*
DEFINE l_sfcd RECORD  #工單製程check in/out專案資料
       sfcdent LIKE sfcd_t.sfcdent, #企業編號
       sfcdsite LIKE sfcd_t.sfcdsite, #營運據點
       sfcddocno LIKE sfcd_t.sfcddocno, #單號
       sfcd001 LIKE sfcd_t.sfcd001, #RUN CARD
       sfcd002 LIKE sfcd_t.sfcd002, #項次
       sfcd003 LIKE sfcd_t.sfcd003, #專案
       sfcd004 LIKE sfcd_t.sfcd004, #型態
       sfcd005 LIKE sfcd_t.sfcd005, #下限
       sfcd006 LIKE sfcd_t.sfcd006, #上限
       sfcd007 LIKE sfcd_t.sfcd007, #預設值
       sfcd008 LIKE sfcd_t.sfcd008, #必要
       sfcd009 LIKE sfcd_t.sfcd009 #check in/check 
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfod                 RECORD LIKE sfod_t.*
DEFINE l_sfod RECORD  #工單製程變更check in/out項目資料
       sfodent LIKE sfod_t.sfodent, #企業編號
       sfodsite LIKE sfod_t.sfodsite, #營運據點
       sfoddocno LIKE sfod_t.sfoddocno, #工單單號
       sfod001 LIKE sfod_t.sfod001, #RUN CARD
       sfod002 LIKE sfod_t.sfod002, #項次
       sfod003 LIKE sfod_t.sfod003, #項目
       sfod004 LIKE sfod_t.sfod004, #型態
       sfod005 LIKE sfod_t.sfod005, #下限
       sfod006 LIKE sfod_t.sfod006, #上限
       sfod007 LIKE sfod_t.sfod007, #預設值
       sfod008 LIKE sfod_t.sfod008, #必要
       sfod900 LIKE sfod_t.sfod900, #變更序
       sfod901 LIKE sfod_t.sfod901, #變更類型
       sfod902 LIKE sfod_t.sfod902, #變更時間
       sfod905 LIKE sfod_t.sfod905, #變更理由
       sfod906 LIKE sfod_t.sfod906, #變更備註
       sfod009 LIKE sfod_t.sfod009, #Check in/out
       sfodseq LIKE sfod_t.sfodseq, #項序
       sfodud001 LIKE sfod_t.sfodud001, #自定義欄位(文字)001
       sfodud002 LIKE sfod_t.sfodud002, #自定義欄位(文字)002
       sfodud003 LIKE sfod_t.sfodud003, #自定義欄位(文字)003
       sfodud004 LIKE sfod_t.sfodud004, #自定義欄位(文字)004
       sfodud005 LIKE sfod_t.sfodud005, #自定義欄位(文字)005
       sfodud006 LIKE sfod_t.sfodud006, #自定義欄位(文字)006
       sfodud007 LIKE sfod_t.sfodud007, #自定義欄位(文字)007
       sfodud008 LIKE sfod_t.sfodud008, #自定義欄位(文字)008
       sfodud009 LIKE sfod_t.sfodud009, #自定義欄位(文字)009
       sfodud010 LIKE sfod_t.sfodud010, #自定義欄位(文字)010
       sfodud011 LIKE sfod_t.sfodud011, #自定義欄位(數字)011
       sfodud012 LIKE sfod_t.sfodud012, #自定義欄位(數字)012
       sfodud013 LIKE sfod_t.sfodud013, #自定義欄位(數字)013
       sfodud014 LIKE sfod_t.sfodud014, #自定義欄位(數字)014
       sfodud015 LIKE sfod_t.sfodud015, #自定義欄位(數字)015
       sfodud016 LIKE sfod_t.sfodud016, #自定義欄位(數字)016
       sfodud017 LIKE sfod_t.sfodud017, #自定義欄位(數字)017
       sfodud018 LIKE sfod_t.sfodud018, #自定義欄位(數字)018
       sfodud019 LIKE sfod_t.sfodud019, #自定義欄位(數字)019
       sfodud020 LIKE sfod_t.sfodud020, #自定義欄位(數字)020
       sfodud021 LIKE sfod_t.sfodud021, #自定義欄位(日期時間)021
       sfodud022 LIKE sfod_t.sfodud022, #自定義欄位(日期時間)022
       sfodud023 LIKE sfod_t.sfodud023, #自定義欄位(日期時間)023
       sfodud024 LIKE sfod_t.sfodud024, #自定義欄位(日期時間)024
       sfodud025 LIKE sfod_t.sfodud025, #自定義欄位(日期時間)025
       sfodud026 LIKE sfod_t.sfodud026, #自定義欄位(日期時間)026
       sfodud027 LIKE sfod_t.sfodud027, #自定義欄位(日期時間)027
       sfodud028 LIKE sfod_t.sfodud028, #自定義欄位(日期時間)028
       sfodud029 LIKE sfod_t.sfodud029, #自定義欄位(日期時間)029
       sfodud030 LIKE sfod_t.sfodud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#36-e
DEFINE l_i                    LIKE type_t.num5

   LET r_success = FALSE
   DECLARE asft801_gen_sfod CURSOR FOR
   #161109-00085#36-s
   #SELECT * FROM sfcd_t WHERE sfcdent = g_enterprise AND sfcdsite = g_site    
   SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,
          sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,
          sfcd008,sfcd009
     FROM sfcd_t WHERE sfcdent = g_enterprise AND sfcdsite = g_site
   #161109-00085#36-e
       AND sfcddocno = g_sfoa_m.sfoadocno AND sfcd001 = g_sfoa_m.sfoa001
       AND sfcd002 = p_sfod002
       ORDER BY sfcd003,sfcd004
   LET l_i = -1
   #161109-00085#36-s
   #FOREACH asft801_gen_sfod INTO l_sfcd.*
   FOREACH asft801_gen_sfod 
   INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
        l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
        l_sfcd.sfcd008,l_sfcd.sfcd009
   #161109-00085#36-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfod.sfodent = g_enterprise 
      LET l_sfod.sfodsite = g_site
      LET l_sfod.sfoddocno = l_sfcd.sfcddocno
      LET l_sfod.sfod001 = l_sfcd.sfcd001
      LET l_sfod.sfod002 = l_sfcd.sfcd002
      LET l_sfod.sfod003 = l_sfcd.sfcd003
      LET l_sfod.sfod004 = l_sfcd.sfcd004
      LET l_sfod.sfod005 = l_sfcd.sfcd005
      LET l_sfod.sfod006 = l_sfcd.sfcd006
      LET l_sfod.sfod007 = l_sfcd.sfcd007
      LET l_sfod.sfod008 = l_sfcd.sfcd008
      LET l_sfod.sfod009 = l_sfcd.sfcd009
      LET l_sfod.sfod900 = g_sfoa_m.sfoa900
      LET l_sfod.sfod901 = '1'
      LET l_sfod.sfodseq = l_i
      #161109-00085#36-s
      #INSERT INTO sfod_t VALUES l_sfod.*
      INSERT INTO sfod_t( sfodent,sfodsite,sfoddocno,sfod001,sfod002,
                          sfod003,sfod004,sfod005,sfod006,sfod007,
                          sfod008,sfod900,sfod901,sfod902,sfod905,
                          sfod906,sfod009,sfodseq,sfodud001,sfodud002,
                          sfodud003,sfodud004,sfodud005,sfodud006,sfodud007,
                          sfodud008,sfodud009,sfodud010,sfodud011,sfodud012,
                          sfodud013,sfodud014,sfodud015,sfodud016,sfodud017,
                          sfodud018,sfodud019,sfodud020,sfodud021,sfodud022,
                          sfodud023,sfodud024,sfodud025,sfodud026,sfodud027,
                          sfodud028,sfodud029,sfodud030)
           VALUES (l_sfod.sfodent,l_sfod.sfodsite,l_sfod.sfoddocno,l_sfod.sfod001,l_sfod.sfod002,
                   l_sfod.sfod003,l_sfod.sfod004,l_sfod.sfod005,l_sfod.sfod006,l_sfod.sfod007,
                   l_sfod.sfod008,l_sfod.sfod900,l_sfod.sfod901,l_sfod.sfod902,l_sfod.sfod905,
                   l_sfod.sfod906,l_sfod.sfod009,l_sfod.sfodseq,l_sfod.sfodud001,l_sfod.sfodud002,
                   l_sfod.sfodud003,l_sfod.sfodud004,l_sfod.sfodud005,l_sfod.sfodud006,l_sfod.sfodud007,
                   l_sfod.sfodud008,l_sfod.sfodud009,l_sfod.sfodud010,l_sfod.sfodud011,l_sfod.sfodud012,
                   l_sfod.sfodud013,l_sfod.sfodud014,l_sfod.sfodud015,l_sfod.sfodud016,l_sfod.sfodud017,
                   l_sfod.sfodud018,l_sfod.sfodud019,l_sfod.sfodud020,l_sfod.sfodud021,l_sfod.sfodud022,
                   l_sfod.sfodud023,l_sfod.sfodud024,l_sfod.sfodud025,l_sfod.sfodud026,l_sfod.sfodud027,
                   l_sfod.sfodud028,l_sfod.sfodud029,l_sfod.sfodud030)
      #161109-00085#36-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfod_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_sfcd.* TO NULL   #清空数组
      LET l_i = l_i - 1
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更理由检查
PRIVATE FUNCTION asft801_sfoa905_chk(p_sfoa905)
DEFINE p_sfoa905                 LIKE sfoa_t.sfoa905
DEFINE r_success                 LIKE type_t.num5
DEFINE l_success                 LIKE type_t.num5
DEFINE l_flag                    LIKE type_t.num5

   LET r_success = FALSE
   IF cl_null(p_sfoa905) THEN
      RETURN r_success
   END IF
   
   CALL s_azzi650_chk_exist(g_acc,p_sfoa905) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   #檢核輸入的理由碼是否在單據別限制範圍內，若不在限制內則不允許使用此理由碼
   CALL s_control_chk_doc('8',g_sfoa_m.sfoadocno,p_sfoa905,'','','','') RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN r_success
   ELSE
      IF NOT l_flag THEN
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#理由码说明
PRIVATE FUNCTION asft801_sfoa905_desc(p_sfoa905)
DEFINE p_sfoa905         LIKE sfoa_t.sfoa905
DEFINE r_sfoa905_desc    LIKE type_t.chr80
   IF cl_null(p_sfoa905) THEN
      RETURN ''
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_sfoa905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_sfoa905_desc = '', g_rtn_fields[1] , ''
   RETURN r_sfoa905_desc
END FUNCTION

#工单制程单身发生变更时写入变更历程档
PRIVATE FUNCTION asft801_upd_sfob_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoe001)
DEFINE p_sfoedocno           LIKE sfoe_t.sfoedocno    #工单单号
DEFINE p_sfoeseq             LIKE sfoe_t.sfoeseq      #RunCard
DEFINE p_sfoeseq1            LIKE sfoe_t.sfoeseq1     #项次
DEFINE p_sfoe001             LIKE sfoe_t.sfoe001      #变更序
DEFINE r_success             LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcb                 RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfob         RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       sfob055 LIKE sfob_t.sfob055  #回收站
END RECORD
#161109-00085#36-e
DEFINE l_flag                LIKE type_t.chr1
DEFINE l_ooff013             LIKE ooff_t.ooff013
DEFINE l_success             LIKE type_t.num5

   LET r_success = FALSE
   LET l_flag = 'N'
   
   IF cl_null(p_sfoedocno) OR cl_null(p_sfoeseq) OR cl_null(p_sfoeseq1) OR cl_null(p_sfoe001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_sfcb.* TO NULL
   INITIALIZE l_sfob.* TO NULL
   #161109-00085#36-s
   #SELECT * INTO l_sfob.* FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   SELECT sfobent,sfobsite,sfobdocno,sfob001,sfob002,
          sfob003,sfob004,sfob005,sfob006,sfob007,
          sfob008,sfob009,sfob010,sfob011,sfob012,
          sfob013,sfob014,sfob015,sfob016,sfob017,
          sfob018,sfob019,sfob020,sfob021,sfob022,
          sfob023,sfob024,sfob025,sfob026,sfob027,
          sfob028,sfob029,sfob030,sfob031,sfob032,
          sfob033,sfob034,sfob035,sfob036,sfob037,
          sfob038,sfob039,sfob040,sfob041,sfob042,
          sfob043,sfob044,sfob045,sfob046,sfob047,
          sfob048,sfob049,sfob050,sfob051,sfob052,
          sfob053,sfob054,sfob900,sfob901,sfob902,
          sfob905,sfob906,sfob055
     INTO l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
          l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
          l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
          l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
          l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
          l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
          l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
          l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
          l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
          l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
          l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
          l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
          l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055 
   FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   #161109-00085#36-e
      AND sfobdocno = p_sfoedocno AND sfob001 = p_sfoeseq AND sfob002 = p_sfoeseq1
      AND sfob900 = p_sfoe001
      
   IF l_sfob.sfob901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_sfob.sfob901 = '2' OR l_sfob.sfob901 = '4' THEN
   #161109-00085#36-s
   #SELECT * INTO l_sfcb.* FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
   SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
          sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
          sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
          sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
          sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
          sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
          sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
          sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
          sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
          sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
          sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
          sfcb053,sfcb054,sfcb055
     INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
          l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
          l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
          l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
          l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
          l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
          l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
          l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
          l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
          l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
          l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
          l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055 
     FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
   #161109-00085#36-e   
         AND sfcbdocno = p_sfoedocno AND sfcb001 = p_sfoeseq AND sfcb002 = p_sfoeseq1
   END IF
   
   LET g_sfoe003 = ''
   IF l_sfob.sfob901 = '2' THEN
      LET g_sfoe003 = '1'
   END IF
   IF l_sfob.sfob901 = '3' THEN
      LET g_sfoe003 = '2'
   END IF
   IF l_sfob.sfob901 = '4' THEN
      INITIALIZE l_sfob.* TO NULL
      LET g_sfoe003 = '3'
   END IF
   
   #项次
   IF (NOT cl_null(l_sfob.sfob002) AND (l_sfob.sfob002 != l_sfcb.sfcb002 OR l_sfcb.sfcb002 IS NULL)) OR (cl_null(l_sfob.sfob002) AND l_sfcb.sfcb002 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb002',g_sfoe003,l_sfcb.sfcb002,l_sfob.sfob002,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb002') THEN
         RETURN r_success
      END IF
   END IF
   
   #本站作业
   IF (NOT cl_null(l_sfob.sfob003) AND (l_sfob.sfob003 != l_sfcb.sfcb003 OR l_sfcb.sfcb003 IS NULL)) OR (cl_null(l_sfob.sfob003) AND l_sfcb.sfcb003 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocql003 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_sfcb.sfcb003||"' AND oocql003=? "
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb003',g_sfoe003,l_sfcb.sfcb003,l_sfob.sfob003,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb003') THEN
         RETURN r_success
      END IF
   END IF
   
   #作业序
   IF (NOT cl_null(l_sfob.sfob004) AND (l_sfob.sfob004 != l_sfcb.sfcb004 OR l_sfcb.sfcb004 IS NULL)) OR (cl_null(l_sfob.sfob004) AND l_sfcb.sfcb004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb004',g_sfoe003,l_sfcb.sfcb004,l_sfob.sfob004,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb004') THEN
         RETURN r_success
      END IF
   END IF
   
   #群组性质
   IF (NOT cl_null(l_sfob.sfob005) AND (l_sfob.sfob005 != l_sfcb.sfcb005 OR l_sfcb.sfcb005 IS NULL)) OR (cl_null(l_sfob.sfob005) AND l_sfcb.sfcb005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb005',g_sfoe003,l_sfcb.sfcb005,l_sfob.sfob005,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb005') THEN
         RETURN r_success
      END IF
   END IF

   #群组
   IF (NOT cl_null(l_sfob.sfob006) AND (l_sfob.sfob006 != l_sfcb.sfcb006 OR l_sfcb.sfcb006 IS NULL)) OR (cl_null(l_sfob.sfob006) AND l_sfcb.sfcb006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb006',g_sfoe003,l_sfcb.sfcb006,l_sfob.sfob006,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb006') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业
   IF (NOT cl_null(l_sfob.sfob007) AND (l_sfob.sfob007 != l_sfcb.sfcb007 OR l_sfcb.sfcb007 IS NULL)) OR (cl_null(l_sfob.sfob007) AND l_sfcb.sfcb007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_sfcb.sfcb008||"' AND oocql003=? "
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb007',g_sfoe003,l_sfcb.sfcb007,l_sfob.sfob007,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb007') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业序
   IF (NOT cl_null(l_sfob.sfob008) AND (l_sfob.sfob008 != l_sfcb.sfcb008 OR l_sfcb.sfcb008 IS NULL)) OR (cl_null(l_sfob.sfob008) AND l_sfcb.sfcb008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb008',g_sfoe003,l_sfcb.sfcb008,l_sfob.sfob008,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb008') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业
   IF (NOT cl_null(l_sfob.sfob009) AND (l_sfob.sfob009 != l_sfcb.sfcb009 OR l_sfcb.sfcb009 IS NULL)) OR (cl_null(l_sfob.sfob009) AND l_sfcb.sfcb009 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_sfcb.sfcb010||"' AND oocql003=? "
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb009',g_sfoe003,l_sfcb.sfcb009,l_sfob.sfob009,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb009') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业序
   IF (NOT cl_null(l_sfob.sfob010) AND (l_sfob.sfob010 != l_sfcb.sfcb010 OR l_sfcb.sfcb010 IS NULL)) OR (cl_null(l_sfob.sfob010) AND l_sfcb.sfcb010 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = " "
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb010',g_sfoe003,l_sfcb.sfcb010,l_sfob.sfob010,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb010') THEN
         RETURN r_success
      END IF
   END IF
   
   #工作站
   IF (NOT cl_null(l_sfob.sfob011) AND (l_sfob.sfob011 != l_sfcb.sfcb011 OR l_sfcb.sfcb011 IS NULL)) OR (cl_null(l_sfob.sfob011) AND l_sfcb.sfcb011 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001='"||l_sfcb.sfcb012||"'"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb011',g_sfoe003,l_sfcb.sfcb011,l_sfob.sfob011,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb011') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外
   IF (NOT cl_null(l_sfob.sfob012) AND (l_sfob.sfob012 != l_sfcb.sfcb012 OR l_sfcb.sfcb012 IS NULL)) OR (cl_null(l_sfob.sfob012) AND l_sfcb.sfcb012 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb012',g_sfoe003,l_sfcb.sfcb012,l_sfob.sfob012,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb012') THEN
         RETURN r_success
      END IF
   END IF
   
   #主要加工厂
   IF (NOT cl_null(l_sfob.sfob013) AND (l_sfob.sfob013 != l_sfcb.sfcb013 OR l_sfcb.sfcb013 IS NULL)) OR (cl_null(l_sfob.sfob013) AND l_sfcb.sfcb013 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_sfcb.sfcb014||"' AND pmaal002=?"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb013',g_sfoe003,l_sfcb.sfcb013,l_sfob.sfob013,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb013') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move in
   IF (NOT cl_null(l_sfob.sfob014) AND (l_sfob.sfob014 != l_sfcb.sfcb014 OR l_sfcb.sfcb014 IS NULL)) OR (cl_null(l_sfob.sfob014) AND l_sfcb.sfcb014 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb014',g_sfoe003,l_sfcb.sfcb014,l_sfob.sfob014,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb014') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check in
   IF (NOT cl_null(l_sfob.sfob015) AND (l_sfob.sfob015 != l_sfcb.sfcb015 OR l_sfcb.sfcb015 IS NULL)) OR (cl_null(l_sfob.sfob015) AND l_sfcb.sfcb015 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb015',g_sfoe003,l_sfcb.sfcb015,l_sfob.sfob015,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb015') THEN
         RETURN r_success
      END IF
   END IF
   
   #报工站
   IF (NOT cl_null(l_sfob.sfob016) AND (l_sfob.sfob016 != l_sfcb.sfcb016 OR l_sfcb.sfcb016 IS NULL)) OR (cl_null(l_sfob.sfob016) AND l_sfcb.sfcb016 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb016',g_sfoe003,l_sfcb.sfcb016,l_sfob.sfob016,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb016') THEN
         RETURN r_success
      END IF
   END IF
   
   #PQC
   IF (NOT cl_null(l_sfob.sfob017) AND (l_sfob.sfob017 != l_sfcb.sfcb017 OR l_sfcb.sfcb017 IS NULL)) OR (cl_null(l_sfob.sfob017) AND l_sfcb.sfcb017 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb017',g_sfoe003,l_sfcb.sfcb017,l_sfob.sfob017,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb017') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check out
   IF (NOT cl_null(l_sfob.sfob018) AND (l_sfob.sfob018 != l_sfcb.sfcb018 OR l_sfcb.sfcb018 IS NULL)) OR (cl_null(l_sfob.sfob018) AND l_sfcb.sfcb018 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb018',g_sfoe003,l_sfcb.sfcb018,l_sfob.sfob018,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb018') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move out
   IF (NOT cl_null(l_sfob.sfob019) AND (l_sfob.sfob019 != l_sfcb.sfcb019 OR l_sfcb.sfcb019 IS NULL)) OR (cl_null(l_sfob.sfob019) AND l_sfcb.sfcb019 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb019',g_sfoe003,l_sfcb.sfcb019,l_sfob.sfob019,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb019') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位
   IF (NOT cl_null(l_sfob.sfob020) AND (l_sfob.sfob020 != l_sfcb.sfcb020 OR l_sfcb.sfcb020 IS NULL)) OR (cl_null(l_sfob.sfob020) AND l_sfcb.sfcb020 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_sfcb.sfcb021||"' AND oocal002=?"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb020',g_sfoe003,l_sfcb.sfcb020,l_sfob.sfob020,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb020') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分子
   IF (NOT cl_null(l_sfob.sfob021) AND (l_sfob.sfob021 != l_sfcb.sfcb021 OR l_sfcb.sfcb021 IS NULL)) OR (cl_null(l_sfob.sfob021) AND l_sfcb.sfcb021 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb021',g_sfoe003,l_sfcb.sfcb021,l_sfob.sfob021,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb021') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分母
   IF (NOT cl_null(l_sfob.sfob022) AND (l_sfob.sfob022 != l_sfcb.sfcb022 OR l_sfcb.sfcb022 IS NULL)) OR (cl_null(l_sfob.sfob022) AND l_sfcb.sfcb022 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb022',g_sfoe003,l_sfcb.sfcb022,l_sfob.sfob022,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb022') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定工时
   IF (NOT cl_null(l_sfob.sfob023) AND (l_sfob.sfob023 != l_sfcb.sfcb023 OR l_sfcb.sfcb023 IS NULL)) OR (cl_null(l_sfob.sfob023) AND l_sfcb.sfcb023 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb023',g_sfoe003,l_sfcb.sfcb023,l_sfob.sfob023,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb023') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准工时
   IF (NOT cl_null(l_sfob.sfob024) AND (l_sfob.sfob024 != l_sfcb.sfcb024 OR l_sfcb.sfcb024 IS NULL)) OR (cl_null(l_sfob.sfob024) AND l_sfcb.sfcb024 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb024',g_sfoe003,l_sfcb.sfcb024,l_sfob.sfob024,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb024') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定机时
   IF (NOT cl_null(l_sfob.sfob025) AND (l_sfob.sfob025 != l_sfcb.sfcb025 OR l_sfcb.sfcb025 IS NULL)) OR (cl_null(l_sfob.sfob025) AND l_sfcb.sfcb025 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb025',g_sfoe003,l_sfcb.sfcb025,l_sfob.sfob025,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb025') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准机时
   IF (NOT cl_null(l_sfob.sfob026) AND (l_sfob.sfob026 != l_sfcb.sfcb026 OR l_sfcb.sfcb026 IS NULL)) OR (cl_null(l_sfob.sfob026) AND l_sfcb.sfcb026 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb026',g_sfoe003,l_sfcb.sfcb026,l_sfob.sfob026,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb026') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准产出量
   IF (NOT cl_null(l_sfob.sfob027) AND (l_sfob.sfob027 != l_sfcb.sfcb027 OR l_sfcb.sfcb027 IS NULL)) OR (cl_null(l_sfob.sfob027) AND l_sfcb.sfcb027 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb027',g_sfoe003,l_sfcb.sfcb027,l_sfob.sfob027,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb027') THEN
         RETURN r_success
      END IF
   END IF
   
   #良品转入
   IF (NOT cl_null(l_sfob.sfob028) AND (l_sfob.sfob028 != l_sfcb.sfcb028 OR l_sfcb.sfcb028 IS NULL)) OR (cl_null(l_sfob.sfob028) AND l_sfcb.sfcb028 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb028',g_sfoe003,l_sfcb.sfcb028,l_sfob.sfob028,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb028') THEN
         RETURN r_success
      END IF
   END IF
   
   #重工轉入
   IF (NOT cl_null(l_sfob.sfob029) AND (l_sfob.sfob029 != l_sfcb.sfcb029 OR l_sfcb.sfcb029 IS NULL)) OR (cl_null(l_sfob.sfob029) AND l_sfcb.sfcb029 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb029',g_sfoe003,l_sfcb.sfcb029,l_sfob.sfob029,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb029') THEN
         RETURN r_success
      END IF
   END IF
   
   #回收轉入
   IF (NOT cl_null(l_sfob.sfob030) AND (l_sfob.sfob030 != l_sfcb.sfcb030 OR l_sfcb.sfcb030 IS NULL)) OR (cl_null(l_sfob.sfob030) AND l_sfcb.sfcb030 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_sfcb.sfcb030||"' AND oocal002=?"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb030',g_sfoe003,l_sfcb.sfcb030,l_sfob.sfob030,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb030') THEN
         RETURN r_success
      END IF
   END IF
   
   #分割轉入
   IF (NOT cl_null(l_sfob.sfob031) AND (l_sfob.sfob031 != l_sfcb.sfcb031 OR l_sfcb.sfcb031 IS NULL)) OR (cl_null(l_sfob.sfob031) AND l_sfcb.sfcb031 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb031',g_sfoe003,l_sfcb.sfcb031,l_sfob.sfob031,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb031') THEN
         RETURN r_success
      END IF
   END IF
   
   #合併轉入
   IF (NOT cl_null(l_sfob.sfob032) AND (l_sfob.sfob032 != l_sfcb.sfcb032 OR l_sfcb.sfcb032 IS NULL)) OR (cl_null(l_sfob.sfob032) AND l_sfcb.sfcb032 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb032',g_sfoe003,l_sfcb.sfcb032,l_sfob.sfob032,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb032') THEN
         RETURN r_success
      END IF
   END IF
   
   #良品轉出
   IF (NOT cl_null(l_sfob.sfob033) AND (l_sfob.sfob033 != l_sfcb.sfcb033 OR l_sfcb.sfcb033 IS NULL)) OR (cl_null(l_sfob.sfob033) AND l_sfcb.sfcb033 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb033',g_sfoe003,l_sfcb.sfcb033,l_sfob.sfob033,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb033') THEN
         RETURN r_success
      END IF
   END IF
   
   #重工轉出
   IF (NOT cl_null(l_sfob.sfob034) AND (l_sfob.sfob034 != l_sfcb.sfcb034 OR l_sfcb.sfcb034 IS NULL)) OR (cl_null(l_sfob.sfob034) AND l_sfcb.sfcb034 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb034',g_sfoe003,l_sfcb.sfcb034,l_sfob.sfob034,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb034') THEN
         RETURN r_success
      END IF
   END IF
   
   #回收轉出
   IF (NOT cl_null(l_sfob.sfob035) AND (l_sfob.sfob035 != l_sfcb.sfcb035 OR l_sfcb.sfcb035 IS NULL)) OR (cl_null(l_sfob.sfob035) AND l_sfcb.sfcb035 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb035',g_sfoe003,l_sfcb.sfcb035,l_sfob.sfob035,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb035') THEN
         RETURN r_success
      END IF
   END IF
   
   #當站報廢
   IF (NOT cl_null(l_sfob.sfob036) AND (l_sfob.sfob036 != l_sfcb.sfcb036 OR l_sfcb.sfcb036 IS NULL)) OR (cl_null(l_sfob.sfob036) AND l_sfcb.sfcb036 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb036',g_sfoe003,l_sfcb.sfcb036,l_sfob.sfob036,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb036') THEN
         RETURN r_success
      END IF
   END IF
   
   #当站下线
   IF (NOT cl_null(l_sfob.sfob037) AND (l_sfob.sfob037 != l_sfcb.sfcb037 OR l_sfcb.sfcb037 IS NULL)) OR (cl_null(l_sfob.sfob037) AND l_sfcb.sfcb037 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb037',g_sfoe003,l_sfcb.sfcb037,l_sfob.sfob037,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb037') THEN
         RETURN r_success
      END IF
   END IF
   
   #分割转出
   IF (NOT cl_null(l_sfob.sfob038) AND (l_sfob.sfob038 != l_sfcb.sfcb038 OR l_sfcb.sfcb038 IS NULL)) OR (cl_null(l_sfob.sfob038) AND l_sfcb.sfcb038 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb038',g_sfoe003,l_sfcb.sfcb038,l_sfob.sfob038,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb038') THEN
         RETURN r_success
      END IF
   END IF
   
   #合拼转出
   IF (NOT cl_null(l_sfob.sfob039) AND (l_sfob.sfob039 != l_sfcb.sfcb039 OR l_sfcb.sfcb039 IS NULL)) OR (cl_null(l_sfob.sfob039) AND l_sfcb.sfcb039 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb039',g_sfoe003,l_sfcb.sfcb039,l_sfob.sfob039,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb039') THEN
         RETURN r_success
      END IF
   END IF
   
   #Bonus
   IF (NOT cl_null(l_sfob.sfob040) AND (l_sfob.sfob040 != l_sfcb.sfcb040 OR l_sfcb.sfcb040 IS NULL)) OR (cl_null(l_sfob.sfob040) AND l_sfcb.sfcb040 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb040',g_sfoe003,l_sfcb.sfcb040,l_sfob.sfob040,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb040') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外加工数
   IF (NOT cl_null(l_sfob.sfob041) AND (l_sfob.sfob041 != l_sfcb.sfcb041 OR l_sfcb.sfcb041 IS NULL)) OR (cl_null(l_sfob.sfob041) AND l_sfcb.sfcb041 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb041',g_sfoe003,l_sfcb.sfcb041,l_sfob.sfob041,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb041') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外完工数
   IF (NOT cl_null(l_sfob.sfob042) AND (l_sfob.sfob042 != l_sfcb.sfcb042 OR l_sfcb.sfcb042 IS NULL)) OR (cl_null(l_sfob.sfob042) AND l_sfcb.sfcb042 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb042',g_sfoe003,l_sfcb.sfcb042,l_sfob.sfob042,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb042') THEN
         RETURN r_success
      END IF
   END IF
   
   #盘点数
   IF (NOT cl_null(l_sfob.sfob043) AND (l_sfob.sfob043 != l_sfcb.sfcb043 OR l_sfcb.sfcb043 IS NULL)) OR (cl_null(l_sfob.sfob043) AND l_sfcb.sfcb043 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb043',g_sfoe003,l_sfcb.sfcb043,l_sfob.sfob043,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb043') THEN
         RETURN r_success
      END IF
   END IF
   
   #预计开工日
   IF (NOT cl_null(l_sfob.sfob044) AND (l_sfob.sfob044 != l_sfcb.sfcb044 OR l_sfcb.sfcb044 IS NULL)) OR (cl_null(l_sfob.sfob044) AND l_sfcb.sfcb044 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb044',g_sfoe003,l_sfcb.sfcb044,l_sfob.sfob044,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb044') THEN
         RETURN r_success
      END IF
   END IF
   
   #预计完工日
   IF (NOT cl_null(l_sfob.sfob045) AND (l_sfob.sfob045 != l_sfcb.sfcb045 OR l_sfcb.sfcb045 IS NULL)) OR (cl_null(l_sfob.sfob045) AND l_sfcb.sfcb045 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb045',g_sfoe003,l_sfcb.sfcb045,l_sfob.sfob045,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb045') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Move in数
   IF (NOT cl_null(l_sfob.sfob046) AND (l_sfob.sfob046 != l_sfcb.sfcb046 OR l_sfcb.sfcb046 IS NULL)) OR (cl_null(l_sfob.sfob046) AND l_sfcb.sfcb046 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb046',g_sfoe003,l_sfcb.sfcb046,l_sfob.sfob046,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb046') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Check in数
   IF (NOT cl_null(l_sfob.sfob047) AND (l_sfob.sfob047 != l_sfcb.sfcb047 OR l_sfcb.sfcb047 IS NULL)) OR (cl_null(l_sfob.sfob047) AND l_sfcb.sfcb047 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb047',g_sfoe003,l_sfcb.sfcb047,l_sfob.sfob047,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb047') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Check out数
   IF (NOT cl_null(l_sfob.sfob048) AND (l_sfob.sfob048 != l_sfcb.sfcb048 OR l_sfcb.sfcb048 IS NULL)) OR (cl_null(l_sfob.sfob048) AND l_sfcb.sfcb048 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb048',g_sfoe003,l_sfcb.sfcb048,l_sfob.sfob048,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb048') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Move out数
   IF (NOT cl_null(l_sfob.sfob049) AND (l_sfob.sfob049 != l_sfcb.sfcb049 OR l_sfcb.sfcb049 IS NULL)) OR (cl_null(l_sfob.sfob049) AND l_sfcb.sfcb049 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb049',g_sfoe003,l_sfcb.sfcb049,l_sfob.sfob049,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb049') THEN
         RETURN r_success
      END IF
   END IF
   
   #在制数
   IF (NOT cl_null(l_sfob.sfob050) AND (l_sfob.sfob050 != l_sfcb.sfcb050 OR l_sfcb.sfcb050 IS NULL)) OR (cl_null(l_sfob.sfob050) AND l_sfcb.sfcb050 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb050',g_sfoe003,l_sfcb.sfcb050,l_sfob.sfob050,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb050') THEN
         RETURN r_success
      END IF
   END IF
   
   #待PQC数
   IF (NOT cl_null(l_sfob.sfob051) AND (l_sfob.sfob051 != l_sfcb.sfcb051 OR l_sfcb.sfcb051 IS NULL)) OR (cl_null(l_sfob.sfob051) AND l_sfcb.sfcb051 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb051',g_sfoe003,l_sfcb.sfcb051,l_sfob.sfob051,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb051') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位
   IF (NOT cl_null(l_sfob.sfob052) AND (l_sfob.sfob052 != l_sfcb.sfcb052 OR l_sfcb.sfcb052 IS NULL)) OR (cl_null(l_sfob.sfob052) AND l_sfcb.sfcb052 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_sfcb.sfcb052||"' AND oocal002=?"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb052',g_sfoe003,l_sfcb.sfcb052,l_sfob.sfob052,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb052') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分子
   IF (NOT cl_null(l_sfob.sfob053) AND (l_sfob.sfob053 != l_sfcb.sfcb053 OR l_sfcb.sfcb053 IS NULL)) OR (cl_null(l_sfob.sfob053) AND l_sfcb.sfcb053 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb053',g_sfoe003,l_sfcb.sfcb053,l_sfob.sfob053,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb053') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分母
   IF (NOT cl_null(l_sfob.sfob054) AND (l_sfob.sfob054 != l_sfcb.sfcb054 OR l_sfcb.sfcb054 IS NULL)) OR (cl_null(l_sfob.sfob054) AND l_sfcb.sfcb054 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb054',g_sfoe003,l_sfcb.sfcb054,l_sfob.sfob054,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb054') THEN
         RETURN r_success
      END IF
   END IF
   
   #回收站
   IF (NOT cl_null(l_sfob.sfob055) AND (l_sfob.sfob055 != l_sfcb.sfcb055 OR l_sfcb.sfcb055 IS NULL)) OR (cl_null(l_sfob.sfob055) AND l_sfcb.sfcb055 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb055',g_sfoe003,l_sfcb.sfcb055,l_sfob.sfob055,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'sfcb055') THEN
         RETURN r_success
      END IF
   END IF
   
   #备注
   CALL s_aooi360_sel('7',g_site,p_sfoedocno,p_sfoeseq,p_sfoeseq1,'','','','','','','4')
           RETURNING l_success,l_ooff013
   IF l_sfob.sfob901 = '3' THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'ooff013',g_sfoe003,'',l_ooff013,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   END IF
   IF l_sfob.sfob901 = '4' THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,0,p_sfoe001,'ooff013',g_sfoe003,l_ooff013,'',g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   END IF
   
   #制程单身未有发生变更，则更新sfob901
   IF l_flag = 'N' THEN
      UPDATE sfob_t SET sfob901 = '1' WHERE sfobent = g_enterprise AND sfobsite = g_site 
         AND sfobdocno =p_sfoedocno AND sfob001 = p_sfoeseq AND sfob002 = p_sfoeseq1
         AND sfob900 = g_sfoa_m.sfoa900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd sfob901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#工单制程单身颜色显示
PRIVATE FUNCTION asft801_sfob_color()
DEFINE l_sfoe002         LIKE sfoe_t.sfoe002

   CALL asft801_sfob_color_init()
   
   DECLARE sel_sfob_sfoe_cs CURSOR FOR
    SELECT sfoe002 FROM sfoe_t
     WHERE sfoeent   = g_enterprise AND sfoesite = g_site
       AND sfoedocno = g_sfoa_m.sfoadocno
       AND sfoeseq   = g_sfoa_m.sfoa001
       AND sfoeseq1  = g_sfob_d[l_ac].sfob002
       AND sfoeseq2  = 0 
       AND sfoe001   = g_sfoa_m.sfoa900
       AND (sfoe002 LIKE 'sfcb%' OR sfoe002 = 'ooff013')        
   FOREACH sel_sfob_sfoe_cs INTO l_sfoe002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_sfoe002 = cl_replace_str(l_sfoe002,'sfcb','sfob')

      CASE l_sfoe002
         WHEN 'sfob002' 
            LET g_sfob_d_color[l_ac].sfob002       = 'red'
            LET g_sfob2_d_color[l_ac].sfob002       = 'red'
         WHEN 'sfob003' 
            LET g_sfob_d_color[l_ac].sfob003       = 'red'
            LET g_sfob_d_color[l_ac].sfob003_desc  = 'red'
         WHEN 'sfob004' 
            LET g_sfob_d_color[l_ac].sfob004       = 'red'           
         WHEN 'sfob005' 
            LET g_sfob_d_color[l_ac].sfob005       = 'red'
         WHEN 'sfob006' 
            LET g_sfob_d_color[l_ac].sfob006       = 'red'
         WHEN 'sfob007' 
            LET g_sfob_d_color[l_ac].sfob007       = 'red'
            LET g_sfob_d_color[l_ac].sfob007_desc  = 'red'
         WHEN 'sfob008' 
            LET g_sfob_d_color[l_ac].sfob008       = 'red'          
         WHEN 'sfob009' 
            LET g_sfob_d_color[l_ac].sfob009       = 'red'
            LET g_sfob_d_color[l_ac].sfob009_desc  = 'red'
         WHEN 'sfob010' 
            LET g_sfob_d_color[l_ac].sfob010       = 'red'           
         WHEN 'sfob011' 
            LET g_sfob_d_color[l_ac].sfob011       = 'red'
            LET g_sfob_d_color[l_ac].sfob011_desc  = 'red'
         WHEN 'sfob012' 
            LET g_sfob_d_color[l_ac].sfob012       = 'red'        
         WHEN 'sfob013' 
            LET g_sfob_d_color[l_ac].sfob013       = 'red'
            LET g_sfob_d_color[l_ac].sfob013_desc  = 'red'
         WHEN 'sfob014' 
            LET g_sfob_d_color[l_ac].sfob014       = 'red'            
         WHEN 'sfob015' 
            LET g_sfob_d_color[l_ac].sfob015       = 'red'
         WHEN 'sfob016' 
            LET g_sfob_d_color[l_ac].sfob016       = 'red'
         WHEN 'sfob017' 
            LET g_sfob_d_color[l_ac].sfob017       = 'red'
         WHEN 'sfob018' 
            LET g_sfob_d_color[l_ac].sfob018       = 'red'
         WHEN 'sfob019' 
            LET g_sfob_d_color[l_ac].sfob019       = 'red'
         WHEN 'sfob020' 
            LET g_sfob_d_color[l_ac].sfob020       = 'red'
            LET g_sfob_d_color[l_ac].sfob020_desc  = 'red'
         WHEN 'sfob021' 
            LET g_sfob_d_color[l_ac].sfob021       = 'red'            
         WHEN 'sfob022' 
            LET g_sfob_d_color[l_ac].sfob022       = 'red'
         WHEN 'sfob023' 
            LET g_sfob_d_color[l_ac].sfob023       = 'red'
         WHEN 'sfob024' 
            LET g_sfob_d_color[l_ac].sfob024       = 'red'
         WHEN 'sfob025' 
            LET g_sfob_d_color[l_ac].sfob025       = 'red'
         WHEN 'sfob026' 
            LET g_sfob_d_color[l_ac].sfob026       = 'red'
         WHEN 'sfob044' 
            LET g_sfob_d_color[l_ac].sfob044       = 'red'   
         WHEN 'sfob045' 
            LET g_sfob_d_color[l_ac].sfob045       = 'red'   
         WHEN 'sfob052' 
            LET g_sfob_d_color[l_ac].sfob052       = 'red'
            LET g_sfob_d_color[l_ac].sfob052_desc  = 'red'
         WHEN 'sfob053' 
            LET g_sfob_d_color[l_ac].sfob053       = 'red'            
         WHEN 'sfob054' 
            LET g_sfob_d_color[l_ac].sfob054       = 'red'
         WHEN 'sfob055' 
            LET g_sfob_d_color[l_ac].sfob055       = 'red'
   
            
         WHEN 'sfob027' 
            LET g_sfob2_d_color[l_ac].sfob027       = 'red'
         WHEN 'sfob028' 
            LET g_sfob2_d_color[l_ac].sfob028       = 'red'
         WHEN 'sfob029' 
            LET g_sfob2_d_color[l_ac].sfob029       = 'red'
         WHEN 'sfob030' 
            LET g_sfob2_d_color[l_ac].sfob030       = 'red'
         WHEN 'sfob031' 
            LET g_sfob2_d_color[l_ac].sfob031       = 'red'
         WHEN 'sfob032' 
            LET g_sfob2_d_color[l_ac].sfob032       = 'red'
         WHEN 'sfob033' 
            LET g_sfob2_d_color[l_ac].sfob033       = 'red'
         WHEN 'sfob034' 
            LET g_sfob2_d_color[l_ac].sfob034       = 'red'
         WHEN 'sfob035' 
            LET g_sfob2_d_color[l_ac].sfob035       = 'red'
         WHEN 'sfob036' 
            LET g_sfob2_d_color[l_ac].sfob036       = 'red'
         WHEN 'sfob037' 
            LET g_sfob2_d_color[l_ac].sfob037       = 'red'
         WHEN 'sfob038' 
            LET g_sfob2_d_color[l_ac].sfob038       = 'red'
         WHEN 'sfob039' 
            LET g_sfob2_d_color[l_ac].sfob039       = 'red'
         WHEN 'sfob040' 
            LET g_sfob2_d_color[l_ac].sfob040       = 'red'
         WHEN 'sfob041' 
            LET g_sfob2_d_color[l_ac].sfob041       = 'red'
         WHEN 'sfob042' 
            LET g_sfob2_d_color[l_ac].sfob042       = 'red'
         WHEN 'sfob043' 
            LET g_sfob2_d_color[l_ac].sfob043       = 'red'
         WHEN 'sfob046' 
            LET g_sfob2_d_color[l_ac].sfob046       = 'red'
         WHEN 'sfob047' 
            LET g_sfob2_d_color[l_ac].sfob047       = 'red'
         WHEN 'sfob048' 
            LET g_sfob2_d_color[l_ac].sfob048       = 'red'
         WHEN 'sfob049' 
            LET g_sfob2_d_color[l_ac].sfob049       = 'red'
         WHEN 'sfob050' 
            LET g_sfob2_d_color[l_ac].sfob050       = 'red'
         WHEN 'sfob051' 
            LET g_sfob2_d_color[l_ac].sfob051       = 'red'
      END CASE
   END FOREACH
END FUNCTION

#工单制程单身颜色初始化
PRIVATE FUNCTION asft801_sfob_color_init()
   LET g_sfob_d_color[l_ac].sfob002       = 'black'
   LET g_sfob2_d_color[l_ac].sfob002      = 'black'
   LET g_sfob_d_color[l_ac].sfob003       = 'black'
   LET g_sfob_d_color[l_ac].sfob003_desc  = 'black' 
   LET g_sfob_d_color[l_ac].sfob004       = 'black'           
   LET g_sfob_d_color[l_ac].sfob005       = 'black'
   LET g_sfob_d_color[l_ac].sfob006       = 'black'
   LET g_sfob_d_color[l_ac].sfob007       = 'black'
   LET g_sfob_d_color[l_ac].sfob007_desc  = 'black'
   LET g_sfob_d_color[l_ac].sfob008       = 'black'          
   LET g_sfob_d_color[l_ac].sfob009       = 'black'
   LET g_sfob_d_color[l_ac].sfob009_desc  = 'black'
   LET g_sfob_d_color[l_ac].sfob010       = 'black'           
   LET g_sfob_d_color[l_ac].sfob011       = 'black'
   LET g_sfob_d_color[l_ac].sfob011_desc  = 'black' 
   LET g_sfob_d_color[l_ac].sfob012       = 'black'        
   LET g_sfob_d_color[l_ac].sfob013       = 'black'
   LET g_sfob_d_color[l_ac].sfob013_desc  = 'black'
   LET g_sfob_d_color[l_ac].sfob014       = 'black'            
   LET g_sfob_d_color[l_ac].sfob015       = 'black'
   LET g_sfob_d_color[l_ac].sfob016       = 'black'
   LET g_sfob_d_color[l_ac].sfob017       = 'black' 
   LET g_sfob_d_color[l_ac].sfob018       = 'black'
   LET g_sfob_d_color[l_ac].sfob019       = 'black'
   LET g_sfob_d_color[l_ac].sfob020       = 'black'
   LET g_sfob_d_color[l_ac].sfob020_desc  = 'black'
   LET g_sfob_d_color[l_ac].sfob021       = 'black'            
   LET g_sfob_d_color[l_ac].sfob022       = 'black'
   LET g_sfob_d_color[l_ac].sfob023       = 'black'
   LET g_sfob_d_color[l_ac].sfob024       = 'black'
   LET g_sfob_d_color[l_ac].sfob025       = 'black'
   LET g_sfob_d_color[l_ac].sfob026       = 'black'
   LET g_sfob_d_color[l_ac].sfob044       = 'black'   
   LET g_sfob_d_color[l_ac].sfob045       = 'black'   
   LET g_sfob_d_color[l_ac].sfob052       = 'black'
   LET g_sfob_d_color[l_ac].sfob052_desc  = 'black'
   LET g_sfob_d_color[l_ac].sfob053       = 'black'            
   LET g_sfob_d_color[l_ac].sfob054       = 'black' 
   LET g_sfob_d_color[l_ac].sfob055       = 'black'
 
    
   LET g_sfob2_d_color[l_ac].sfob027       = 'black'
   LET g_sfob2_d_color[l_ac].sfob028       = 'black'
   LET g_sfob2_d_color[l_ac].sfob029       = 'black'
   LET g_sfob2_d_color[l_ac].sfob030       = 'black'
   LET g_sfob2_d_color[l_ac].sfob031       = 'black'
   LET g_sfob2_d_color[l_ac].sfob032       = 'black' 
   LET g_sfob2_d_color[l_ac].sfob033       = 'black'
   LET g_sfob2_d_color[l_ac].sfob034       = 'black'
   LET g_sfob2_d_color[l_ac].sfob035       = 'black'
   LET g_sfob2_d_color[l_ac].sfob036       = 'black'
   LET g_sfob2_d_color[l_ac].sfob037       = 'black'
   LET g_sfob2_d_color[l_ac].sfob038       = 'black'
   LET g_sfob2_d_color[l_ac].sfob039       = 'black'
   LET g_sfob2_d_color[l_ac].sfob040       = 'black'
   LET g_sfob2_d_color[l_ac].sfob041       = 'black'
   LET g_sfob2_d_color[l_ac].sfob042       = 'black'
   LET g_sfob2_d_color[l_ac].sfob043       = 'black' 
   LET g_sfob2_d_color[l_ac].sfob046       = 'black'
   LET g_sfob2_d_color[l_ac].sfob047       = 'black'
   LET g_sfob2_d_color[l_ac].sfob048       = 'black'
   LET g_sfob2_d_color[l_ac].sfob049       = 'black'
   LET g_sfob2_d_color[l_ac].sfob050       = 'black'
   LET g_sfob2_d_color[l_ac].sfob051       = 'black'
END FUNCTION

#删除资料时，更新关联资料的上站作业
PRIVATE FUNCTION asft801_return_sfob(p_sfobdocno,p_sfob001,p_sfob900,p_sfob002)
DEFINE p_sfobdocno                   LIKE sfob_t.sfobdocno
DEFINE p_sfob001                     LIKE sfob_t.sfob001
DEFINE p_sfob002                     LIKE sfob_t.sfob002
DEFINE p_sfob900                     LIKE sfob_t.sfob900
DEFINE r_success                     LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfob         RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       sfob055 LIKE sfob_t.sfob055  #回收站
END RECORD
#161109-00085#36-e
DEFINE l_sfoc002                     LIKE sfoc_t.sfoc002
DEFINE l_sfoc003                     LIKE sfoc_t.sfoc003
DEFINE l_sfoc004                     LIKE sfoc_t.sfoc004
DEFINE l_sfocseq                     LIKE sfoc_t.sfocseq
DEFINE l_sfocseq_max                 LIKE sfoc_t.sfocseq
DEFINE l_n                           LIKE type_t.num5
DEFINE l_n1                          LIKE type_t.num5  ##170118-00024#1-----add

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF cl_null(p_sfobdocno) OR cl_null(p_sfob001) OR cl_null(p_sfob002) OR cl_null(p_sfob900) THEN                 
      RETURN r_success
   END IF
   
   #161109-00085#36-s
   #SELECT * INTO l_sfob.* FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   SELECT sfobent,sfobsite,sfobdocno,sfob001,sfob002,
          sfob003,sfob004,sfob005,sfob006,sfob007,
          sfob008,sfob009,sfob010,sfob011,sfob012,
          sfob013,sfob014,sfob015,sfob016,sfob017,
          sfob018,sfob019,sfob020,sfob021,sfob022,
          sfob023,sfob024,sfob025,sfob026,sfob027,
          sfob028,sfob029,sfob030,sfob031,sfob032,
          sfob033,sfob034,sfob035,sfob036,sfob037,
          sfob038,sfob039,sfob040,sfob041,sfob042,
          sfob043,sfob044,sfob045,sfob046,sfob047,
          sfob048,sfob049,sfob050,sfob051,sfob052,
          sfob053,sfob054,sfob900,sfob901,sfob902,
          sfob905,sfob906,sfob055
     INTO l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
          l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
          l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
          l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
          l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
          l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
          l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
          l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
          l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
          l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
          l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
          l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
          l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055 
   FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   #161109-00085#36-e
      AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001 
      AND sfob002 = p_sfob002 AND sfob900 = p_sfob900
   IF l_sfob.sfob009 = 'END' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF      
   
   DECLARE asft801_return_sfcb_cs1 CURSOR FOR
    SELECT sfoc003,sfoc004 FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
       AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900
       AND sfoc002 = p_sfob002 AND sfoc901 != '4'
   
   DECLARE asft801_return_sfcb_cs2 CURSOR FOR
    SELECT sfoc002,sfocseq FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
       AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900 
       AND sfoc003 = l_sfob.sfob003 AND sfoc004 = l_sfob.sfob004
       AND sfoc901 != '4'
   FOREACH asft801_return_sfcb_cs2 INTO l_sfoc002,l_sfocseq
      IF NOT asft801_sfoc_delete(p_sfobdocno,p_sfob001,p_sfob900,l_sfoc002,l_sfocseq) THEN
         RETURN r_success
      END IF
      
      FOREACH asft801_return_sfcb_cs1 INTO l_sfoc003,l_sfoc004
         IF l_sfoc003 = 'INIT' THEN
            SELECT COUNT(*) INTO l_n FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
               AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900
               AND sfoc002 = l_sfoc002 AND sfoc901 != '4'
            IF l_n > 0 THEN
               EXIT FOREACH
            END IF
         END IF
        
         SELECT MAX(sfocseq) INTO l_sfocseq_max FROM ecce_t
          WHERE sfocent = g_enterprise AND sfocsite = g_site AND sfocdocno = p_sfobdocno
            AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900 AND sfoc002 = l_sfoc002
         IF cl_null(l_sfocseq_max) THEN
            LET l_sfocseq_max = 1
         ELSE
            LET l_sfocseq_max = l_sfocseq_max + 1
         END IF
         INSERT INTO sfoc_t(sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,sfocseq)
                VALUES(g_enterprise,g_site,p_sfobdocno,p_sfob001,l_sfoc002,l_sfoc003,l_sfoc004,p_sfob900,'3',l_sfob.sfob902,l_sfocseq_max)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins sfoc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
         IF NOT asft801_upd_sfoc_sfoe(p_sfobdocno,p_sfob001,p_sfob002,l_sfocseq_max,p_sfob900) THEN
            RETURN r_success
         END IF
      END FOREACH
      SELECT COUNT(*) INTO l_n FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
         AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900
         AND sfoc002 = l_sfoc002 AND sfoc901 != '4'
      IF l_n > 1 THEN
         UPDATE sfob_t SET sfob007 = 'MULT',sfob008 = '0'
          WHERE sfobent = g_enterprise AND sfobsite = g_site
            AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001 AND sfob900 = p_sfob900
            AND sfob002 = l_sfoc002 AND sfob901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd sfob_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      IF l_n = 1 THEN
         UPDATE sfob_t 
            SET sfob007 = (SELECT sfoc003 FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900 AND sfoc002 = l_sfoc002 AND sfoc901 != '4'),
                sfob008 = (SELECT sfoc004 FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900 AND sfoc002 = l_sfoc002 AND sfoc901 != '4')
          WHERE sfobent = g_enterprise AND sfobsite = g_site
            AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001 AND sfob900 = p_sfob900 
            AND sfob002 = l_sfoc002 AND sfob901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd sfob_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      
     ##170118-00024#1 -----add-----str-----要删除本站在上一次新增的数据，不删的话会导致sfcc_t删的还有多余数据
      LET l_n1 = 0
       SELECT COUNT(*) INTO l_n1 FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
               AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900
               AND sfoc002 = p_sfob002  AND sfoc901 = '3'
         IF l_n1 <> 0 THEN
            DELETE FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
               AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 AND sfoc900 = p_sfob900
               AND sfoc002 = p_sfob002  AND sfoc901 = '3'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "DEL sfoc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()                 
               RETURN r_success
            END IF
         END IF

      ##170118-00024#1 -----add-----end-----
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success     
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION asft801_sfob_delete(p_sfobdocno,p_sfob001,p_sfob900,p_sfob002)
DEFINE p_sfobdocno            LIKE sfob_t.sfobdocno
DEFINE p_sfob001              LIKE sfob_t.sfob001
DEFINE p_sfob002              LIKE sfob_t.sfob002
DEFINE p_sfob900              LIKE sfob_t.sfob900
DEFINE r_success              LIKE type_t.num5
DEFINE l_date                 LIKE sfob_t.sfob902
#161109-00085#36-s
#DEFINE l_sfob         RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       sfob055 LIKE sfob_t.sfob055  #回收站
END RECORD
#161109-00085#36-e
DEFINE l_success              LIKE type_t.num5
DEFINE l_sfocseq              LIKE sfoc_t.sfocseq
DEFINE l_sfodseq              LIKE sfod_t.sfodseq

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF cl_null(p_sfobdocno) OR cl_null(p_sfob001) OR cl_null(p_sfob900) OR cl_null(p_sfob002) THEN                 
      RETURN r_success
   END IF
   
   #161109-00085#36-s
   #SELECT * INTO l_sfob.* FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   SELECT sfobent,sfobsite,sfobdocno,sfob001,sfob002,
          sfob003,sfob004,sfob005,sfob006,sfob007,
          sfob008,sfob009,sfob010,sfob011,sfob012,
          sfob013,sfob014,sfob015,sfob016,sfob017,
          sfob018,sfob019,sfob020,sfob021,sfob022,
          sfob023,sfob024,sfob025,sfob026,sfob027,
          sfob028,sfob029,sfob030,sfob031,sfob032,
          sfob033,sfob034,sfob035,sfob036,sfob037,
          sfob038,sfob039,sfob040,sfob041,sfob042,
          sfob043,sfob044,sfob045,sfob046,sfob047,
          sfob048,sfob049,sfob050,sfob051,sfob052,
          sfob053,sfob054,sfob900,sfob901,sfob902,
          sfob905,sfob906,sfob055
     INTO l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
          l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
          l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
          l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
          l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
          l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
          l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
          l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
          l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
          l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
          l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
          l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
          l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055 
   FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
   #161109-00085#36-e
      AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001 AND sfob900 = p_sfob900 AND sfob002 = p_sfob002 
   #原来的制程资料，删除时不做DELETE，只更新变更类型，且对应的关联表更新
   IF l_sfob.sfob901 = '1' OR l_sfob.sfob901 = '2' THEN 
      LET l_date = cl_get_today()               
      UPDATE sfob_t SET sfob901 = '4',sfob902 = l_date
       WHERE sfobent = g_enterprise AND sfobsite = g_site 
         AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001
         AND sfob900 = p_sfob900 AND sfob002 = p_sfob002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD sfob_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF

      IF NOT asft801_upd_sfob_sfoe(p_sfobdocno,p_sfob001,p_sfob002,p_sfob900) THEN
         RETURN r_success
      END IF
            
      DECLARE asft801_sfob_delete_cs1 CURSOR FOR
       SELECT sfocseq FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
          AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001
          AND sfoc900 = p_sfob900  AND sfoc002 = p_sfob002
      FOREACH asft801_sfob_delete_cs1 INTO l_sfocseq
         IF NOT asft801_sfoc_delete(p_sfobdocno,p_sfob001,p_sfob900,p_sfob002,l_sfocseq) THEN
            RETURN r_success
         END IF
      END FOREACH
      
      DECLARE asft801_sfob_delete_cs2 CURSOR FOR
       SELECT sfodseq FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
          AND sfoddocno = p_sfobdocno AND sfod001 = p_sfob001
          AND sfod900 = p_sfob900 AND sfod002 = p_sfob002
      FOREACH asft801_sfob_delete_cs2 INTO l_sfodseq
         IF NOT asft801_sfod_delete(p_sfobdocno,p_sfob001,p_sfob900,p_sfob002,l_sfodseq) THEN
            RETURN r_success
         END IF
      END FOREACH      
   END IF
   
   IF g_sfob_d[l_ac].sfob901 = '3' THEN
      DELETE FROM sfob_t WHERE sfobent = g_enterprise AND sfobsite = g_site
         AND sfobdocno = p_sfobdocno AND sfob001 = p_sfob001 
         AND sfob900 = p_sfob900 AND sfob002 = p_sfob002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfob_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      CALL s_aooi360_del('7',g_site,p_sfobdocno,p_sfob001,p_sfob900,p_sfob002,' ',' ',' ',' ',' ','4')
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF
      
      DELETE FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
         AND sfocdocno = p_sfobdocno AND sfoc001 = p_sfob001 
         AND sfoc900 = p_sfob900 AND sfoc002 = p_sfob002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfoc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
         AND sfoddocno = p_sfobdocno AND sfod001 = p_sfob001 
         AND sfod900 = p_sfob900 AND sfod002 = p_sfob002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfod_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档，包括sfob、eccc、eccd、sfoc、sfod、eccg对应的
      DELETE FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfobdocno AND sfoeseq = p_sfob001 
         AND sfoe001 = p_sfob900 AND sfoeseq1 = p_sfob002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfoe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION asft801_sfoc_delete(p_sfocdocno,p_sfoc001,p_sfoc900,p_sfoc002,p_sfocseq)
DEFINE p_sfocdocno                  LIKE sfoc_t.sfocdocno
DEFINE p_sfoc001                    LIKE sfoc_t.sfoc001
DEFINE p_sfoc900                    LIKE sfoc_t.sfoc900
DEFINE p_sfoc002                    LIKE sfoc_t.sfoc002
DEFINE p_sfocseq                    LIKE sfoc_t.sfocseq
DEFINE r_success                    LIKE type_t.num5
DEFINE l_date                       LIKE sfoc_t.sfoc902
#161109-00085#36-s
#DEFINE l_sfoc         RECORD LIKE sfoc_t.*
DEFINE l_sfoc RECORD  #工單製程變更上站作業資料
       sfocent LIKE sfoc_t.sfocent, #企業編號
       sfocsite LIKE sfoc_t.sfocsite, #營運據點
       sfocdocno LIKE sfoc_t.sfocdocno, #工單單號
       sfoc001 LIKE sfoc_t.sfoc001, #RUN CARD
       sfoc002 LIKE sfoc_t.sfoc002, #項次
       sfoc003 LIKE sfoc_t.sfoc003, #上站作業
       sfoc004 LIKE sfoc_t.sfoc004, #上站製程式
       sfoc900 LIKE sfoc_t.sfoc900, #變更序
       sfoc901 LIKE sfoc_t.sfoc901, #變更類型
       sfoc902 LIKE sfoc_t.sfoc902, #變更日期
       sfoc905 LIKE sfoc_t.sfoc905, #變更理由
       sfoc906 LIKE sfoc_t.sfoc906, #變更備註
       sfocseq LIKE sfoc_t.sfocseq
END RECORD
#161109-00085#36-e

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_sfocdocno) OR cl_null(p_sfoc001) OR cl_null(p_sfoc900) OR cl_null(p_sfoc002) OR cl_null(p_sfocseq) THEN                 
      RETURN r_success
   END IF
   #161109-00085#36-s   
   #SELECT * INTO l_sfoc.* FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
   SELECT sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,
          sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,
          sfoc905,sfoc906,sfocseq
     INTO l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
          l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
          l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq 
     FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
   #161109-00085#36-e
      AND sfocdocno = p_sfocdocno AND sfoc001 = p_sfoc001 AND sfoc900 = p_sfoc900
      AND sfoc002 = p_sfoc002 AND sfocseq = p_sfocseq
   IF l_sfoc.sfoc901 = '1' OR l_sfoc.sfoc901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE sfoc_t SET sfoc901 = '4',sfoc902 = l_date
       WHERE sfocent = g_enterprise AND sfocsite = g_site 
         AND sfocdocno = p_sfocdocno AND sfoc001 = p_sfoc001 AND sfoc900 = p_sfoc900
         AND sfoc002 = p_sfoc002 AND sfocseq = p_sfocseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD sfoc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT asft801_upd_sfoc_sfoe(p_sfocdocno,p_sfoc001,p_sfoc002,p_sfocseq,p_sfoc900) THEN
         RETURN r_success
      END IF
   END IF
   
   IF l_sfoc.sfoc901 = '3' THEN
      DELETE FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
         AND sfocdocno = p_sfocdocno AND sfoc001 = p_sfoc001 AND sfoc900 = p_sfoc900
         AND sfoc002 = p_sfoc002 AND sfocseq = p_sfocseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfoc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfocdocno AND sfoeseq = p_sfoc001 AND sfoeseq1 = p_sfoc002
         AND sfoeseq2 = p_sfocseq AND sfoe001 = p_sfoc900 AND sfoe002 LIKE 'sfcc%'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfoe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION asft801_sfod_delete(p_sfoddocno,p_sfod001,p_sfod900,p_sfod002,p_sfodseq)
DEFINE p_sfoddocno                  LIKE sfod_t.sfoddocno
DEFINE p_sfod001                    LIKE sfod_t.sfod001
DEFINE p_sfod900                    LIKE sfod_t.sfod900
DEFINE p_sfod002                    LIKE sfod_t.sfod002
DEFINE p_sfodseq                    LIKE sfod_t.sfodseq
DEFINE r_success                    LIKE type_t.num5
DEFINE l_date                       LIKE sfod_t.sfod902
#161109-00085#36-s
#DEFINE l_sfod                 RECORD LIKE sfod_t.*
DEFINE l_sfod RECORD  #工單製程變更check in/out項目資料
       sfodent LIKE sfod_t.sfodent, #企業編號
       sfodsite LIKE sfod_t.sfodsite, #營運據點
       sfoddocno LIKE sfod_t.sfoddocno, #工單單號
       sfod001 LIKE sfod_t.sfod001, #RUN CARD
       sfod002 LIKE sfod_t.sfod002, #項次
       sfod003 LIKE sfod_t.sfod003, #項目
       sfod004 LIKE sfod_t.sfod004, #型態
       sfod005 LIKE sfod_t.sfod005, #下限
       sfod006 LIKE sfod_t.sfod006, #上限
       sfod007 LIKE sfod_t.sfod007, #預設值
       sfod008 LIKE sfod_t.sfod008, #必要
       sfod900 LIKE sfod_t.sfod900, #變更序
       sfod901 LIKE sfod_t.sfod901, #變更類型
       sfod902 LIKE sfod_t.sfod902, #變更時間
       sfod905 LIKE sfod_t.sfod905, #變更理由
       sfod906 LIKE sfod_t.sfod906, #變更備註
       sfod009 LIKE sfod_t.sfod009, #Check in/out
       sfodseq LIKE sfod_t.sfodseq  #項序
END RECORD
#161109-00085#36-e

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_sfoddocno) OR cl_null(p_sfod001) OR cl_null(p_sfod900) OR cl_null(p_sfod002) OR cl_null(p_sfodseq) THEN                 
      RETURN r_success
   END IF
   #161109-00085#36-s
   #SELECT * INTO l_sfod.* FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
   SELECT sfodent,sfodsite,sfoddocno,sfod001,sfod002,
          sfod003,sfod004,sfod005,sfod006,sfod007,
          sfod008,sfod900,sfod901,sfod902,sfod905,
          sfod906,sfod009,sfodseq
   INTO l_sfod.sfodent,l_sfod.sfodsite,l_sfod.sfoddocno,l_sfod.sfod001,l_sfod.sfod002,
        l_sfod.sfod003,l_sfod.sfod004,l_sfod.sfod005,l_sfod.sfod006,l_sfod.sfod007,
        l_sfod.sfod008,l_sfod.sfod900,l_sfod.sfod901,l_sfod.sfod902,l_sfod.sfod905,
        l_sfod.sfod906,l_sfod.sfod009,l_sfod.sfodseq
   FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
   #161109-00085#36-e
      AND sfoddocno = p_sfoddocno AND sfod001 = p_sfod001 AND sfod900 = p_sfod900
      AND sfod002 = p_sfod002 AND sfodseq = p_sfodseq
   IF l_sfod.sfod901 = '1' OR l_sfod.sfod901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE sfod_t SET sfod901 = '4',sfod902 = l_date
       WHERE sfodent = g_enterprise AND sfodsite = g_site 
         AND sfoddocno = p_sfoddocno AND sfod001 = p_sfod001 AND sfod900 = p_sfod900
         AND sfod002 = p_sfod002 AND sfodseq = p_sfodseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD sfod_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT asft801_upd_sfod_sfoe(p_sfoddocno,p_sfod001,p_sfod002,p_sfodseq,p_sfod900) THEN
         RETURN r_success
      END IF
   END IF
   
   IF l_sfod.sfod901 = '3' THEN
      DELETE FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
         AND sfoddocno = p_sfoddocno AND sfod001 = p_sfod001 AND sfod900 = p_sfod900
         AND sfod002 = p_sfod002 AND sfodseq = p_sfodseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfod_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoddocno AND sfoeseq = p_sfod001 AND sfoeseq1 = p_sfod002
         AND sfoeseq2 = p_sfodseq AND sfoe001 = p_sfod900 AND sfoe002 LIKE 'sfcd%'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL sfoe_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#工单制程上站作业发生变更时写入变更历程档
PUBLIC FUNCTION asft801_upd_sfoc_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001)
DEFINE p_sfoedocno                LIKE sfoe_t.sfoedocno
DEFINE p_sfoeseq                  LIKE sfoe_t.sfoeseq
DEFINE p_sfoeseq1                 LIKE sfoe_t.sfoeseq1
DEFINE p_sfoeseq2                 LIKE sfoe_t.sfoeseq2
DEFINE p_sfoe001                  LIKE sfoe_t.sfoe001
DEFINE r_success                  LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcc                 RECORD LIKE sfcc_t.*
DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
       sfcc004 LIKE sfcc_t.sfcc004  #上站作業序
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfoc         RECORD LIKE sfoc_t.*
DEFINE l_sfoc RECORD  #工單製程變更上站作業資料
       sfocent LIKE sfoc_t.sfocent, #企業編號
       sfocsite LIKE sfoc_t.sfocsite, #營運據點
       sfocdocno LIKE sfoc_t.sfocdocno, #工單單號
       sfoc001 LIKE sfoc_t.sfoc001, #RUN CARD
       sfoc002 LIKE sfoc_t.sfoc002, #項次
       sfoc003 LIKE sfoc_t.sfoc003, #上站作業
       sfoc004 LIKE sfoc_t.sfoc004, #上站製程式
       sfoc900 LIKE sfoc_t.sfoc900, #變更序
       sfoc901 LIKE sfoc_t.sfoc901, #變更類型
       sfoc902 LIKE sfoc_t.sfoc902, #變更日期
       sfoc905 LIKE sfoc_t.sfoc905, #變更理由
       sfoc906 LIKE sfoc_t.sfoc906, #變更備註
       sfocseq LIKE sfoc_t.sfocseq
END RECORD
#161109-00085#36-e
DEFINE l_sfcc003                  LIKE sfcc_t.sfcc003
DEFINE l_sfcc004                  LIKE sfcc_t.sfcc004
DEFINE l_flag                     LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'

   IF cl_null(p_sfoedocno) OR cl_null(p_sfoeseq) OR cl_null(p_sfoeseq1) OR cl_null(p_sfoeseq2) OR cl_null(p_sfoe001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_sfcc.* TO NULL
   INITIALIZE l_sfoc.* TO NULL
   #161109-00085#36-s   
   #SELECT * INTO l_sfoc.* FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
   SELECT sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,
          sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,
          sfoc905,sfoc906,sfocseq
     INTO l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
          l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
          l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq 
     FROM sfoc_t WHERE sfocent = g_enterprise AND sfocsite = g_site
   #161109-00085#36-e
      AND sfocdocno = p_sfoedocno AND sfoc001 = p_sfoeseq AND sfoc002 = p_sfoeseq1
      AND sfocseq = p_sfoeseq2 AND sfoc900 = p_sfoe001
      
   IF l_sfoc.sfoc901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_sfoc.sfoc901 = '2' OR l_sfoc.sfoc901 = '4' THEN
      #抓取原值
      SELECT sfoe004 INTO l_sfcc003 FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno AND sfoeseq = p_sfoeseq AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2 AND sfoe001 = p_sfoe001 AND sfoe002 = 'sfcc003'
      SELECT sfoe004 INTO l_sfcc004 FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno AND sfoeseq = p_sfoeseq AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2 AND sfoe001 = p_sfoe001 AND sfoe002 = 'sfcc004'
      IF cl_null(l_sfcc003) THEN
         LET l_sfcc003 = l_sfoc.sfoc003
      END IF
      IF cl_null(l_sfcc004) THEN
         LET l_sfcc004 = l_sfoc.sfoc004
      END IF
      #161109-00085#36-s
      #SELECT * INTO l_sfcc.* FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site
      SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,
             sfcc003,sfcc004
        INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
             l_sfcc.sfcc003,l_sfcc.sfcc004
        FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site
      #161109-00085#36-e
         AND sfccdocno = p_sfoedocno AND sfcc001 = p_sfoeseq AND sfcc002 = p_sfoeseq1
         AND sfcc003 = l_sfcc003 AND sfcc004 = l_sfcc004
   END IF
   
   LET g_sfoe003 = ''
   IF l_sfoc.sfoc901 = '2' THEN
      LET g_sfoe003 = '10'
   END IF
   IF l_sfoc.sfoc901 = '3' THEN
      LET g_sfoe003 = '11'
   END IF
   IF l_sfoc.sfoc901 = '4' THEN
      INITIALIZE l_sfoc.* TO NULL
      LET g_sfoe003 = '12'
   END IF

   #上站作业
   IF (NOT cl_null(l_sfoc.sfoc003) AND (l_sfoc.sfoc003 != l_sfcc.sfcc003 OR l_sfcc.sfcc003 IS NULL)) OR (cl_null(l_sfoc.sfoc003) AND l_sfcc.sfcc003 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_sfcc.sfcc003||"' AND oocql003=?"
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcc003',g_sfoe003,l_sfcc.sfcc003,l_sfoc.sfoc003,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcc003') THEN
         RETURN r_success
      END IF
   END IF

   #上站作业序
   IF (NOT cl_null(l_sfoc.sfoc004) AND (l_sfoc.sfoc004 != l_sfcc.sfcc004 OR l_sfcc.sfcc004 IS NULL)) OR (cl_null(l_sfoc.sfoc004) AND l_sfcc.sfcc004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcc004',g_sfoe003,l_sfcc.sfcc004,l_sfoc.sfoc004,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcc004') THEN
         RETURN r_success
      END IF
   END IF

   
   #未有发生变更，则更新sfoc901
   IF l_flag = 'N' THEN
      UPDATE sfoc_t SET sfoc901 = '1' WHERE sfocent = g_enterprise AND sfocsite = g_site
         AND sfocdocno = p_sfoedocno AND sfoc001 = p_sfoeseq AND sfoc002 = p_sfoeseq1
         AND sfoc900 = p_sfoe001 AND sfocseq = p_sfoeseq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd sfoc901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#工单制程check in/out发生变更时写入变更历程档
PUBLIC FUNCTION asft801_upd_sfod_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001)
DEFINE p_sfoedocno                LIKE sfoe_t.sfoedocno
DEFINE p_sfoeseq                  LIKE sfoe_t.sfoeseq
DEFINE p_sfoeseq1                 LIKE sfoe_t.sfoeseq1
DEFINE p_sfoeseq2                 LIKE sfoe_t.sfoeseq2
DEFINE p_sfoe001                  LIKE sfoe_t.sfoe001
DEFINE r_success                  LIKE type_t.num5
#161109-00085#36-s
#DEFINE l_sfcd                 RECORD LIKE sfcd_t.*
DEFINE l_sfcd RECORD  #工單製程check in/out專案資料
       sfcdent LIKE sfcd_t.sfcdent, #企業編號
       sfcdsite LIKE sfcd_t.sfcdsite, #營運據點
       sfcddocno LIKE sfcd_t.sfcddocno, #單號
       sfcd001 LIKE sfcd_t.sfcd001, #RUN CARD
       sfcd002 LIKE sfcd_t.sfcd002, #項次
       sfcd003 LIKE sfcd_t.sfcd003, #專案
       sfcd004 LIKE sfcd_t.sfcd004, #型態
       sfcd005 LIKE sfcd_t.sfcd005, #下限
       sfcd006 LIKE sfcd_t.sfcd006, #上限
       sfcd007 LIKE sfcd_t.sfcd007, #預設值
       sfcd008 LIKE sfcd_t.sfcd008, #必要
       sfcd009 LIKE sfcd_t.sfcd009 #check in/check 
END RECORD
#161109-00085#36-e
#161109-00085#36-s
#DEFINE l_sfod                 RECORD LIKE sfod_t.*
DEFINE l_sfod RECORD  #工單製程變更check in/out項目資料
       sfodent LIKE sfod_t.sfodent, #企業編號
       sfodsite LIKE sfod_t.sfodsite, #營運據點
       sfoddocno LIKE sfod_t.sfoddocno, #工單單號
       sfod001 LIKE sfod_t.sfod001, #RUN CARD
       sfod002 LIKE sfod_t.sfod002, #項次
       sfod003 LIKE sfod_t.sfod003, #項目
       sfod004 LIKE sfod_t.sfod004, #型態
       sfod005 LIKE sfod_t.sfod005, #下限
       sfod006 LIKE sfod_t.sfod006, #上限
       sfod007 LIKE sfod_t.sfod007, #預設值
       sfod008 LIKE sfod_t.sfod008, #必要
       sfod900 LIKE sfod_t.sfod900, #變更序
       sfod901 LIKE sfod_t.sfod901, #變更類型
       sfod902 LIKE sfod_t.sfod902, #變更時間
       sfod905 LIKE sfod_t.sfod905, #變更理由
       sfod906 LIKE sfod_t.sfod906, #變更備註
       sfod009 LIKE sfod_t.sfod009, #Check in/out
       sfodseq LIKE sfod_t.sfodseq  #項序
END RECORD
#161109-00085#36-e
DEFINE l_flag                     LIKE type_t.chr1
DEFINE l_sfcd003                  LIKE sfcd_t.sfcd003
DEFINE l_sfcd004                  LIKE sfcd_t.sfcd004
DEFINE l_sfcd009                  LIKE sfcd_t.sfcd009

   LET r_success = FALSE
   LET l_flag = 'N'
   IF cl_null(p_sfoedocno) OR cl_null(p_sfoeseq) OR cl_null(p_sfoeseq1) OR cl_null(p_sfoeseq2) OR cl_null(p_sfoe001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_sfcd.* TO NULL
   INITIALIZE l_sfod.* TO NULL
   #161109-00085#36-s
   #SELECT * INTO l_sfod.* FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
   SELECT sfodent,sfodsite,sfoddocno,sfod001,sfod002,
          sfod003,sfod004,sfod005,sfod006,sfod007,
          sfod008,sfod900,sfod901,sfod902,sfod905,
          sfod906,sfod009,sfodseq
   INTO l_sfod.sfodent,l_sfod.sfodsite,l_sfod.sfoddocno,l_sfod.sfod001,l_sfod.sfod002,
        l_sfod.sfod003,l_sfod.sfod004,l_sfod.sfod005,l_sfod.sfod006,l_sfod.sfod007,
        l_sfod.sfod008,l_sfod.sfod900,l_sfod.sfod901,l_sfod.sfod902,l_sfod.sfod905,
        l_sfod.sfod906,l_sfod.sfod009,l_sfod.sfodseq
   FROM sfod_t WHERE sfodent = g_enterprise AND sfodsite = g_site
   #161109-00085#36-e
      AND sfoddocno = p_sfoedocno AND sfod001 = p_sfoeseq AND sfod002 = p_sfoeseq1
      AND sfodseq = p_sfoeseq2 AND sfod900 = p_sfoe001
   
   IF l_sfod.sfod901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_sfod.sfod901 = '2' OR l_sfod.sfod901 = '4' THEN
      #抓取原值
      SELECT sfoe004 INTO l_sfcd003 FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno AND sfoeseq = p_sfoeseq AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2 AND sfoe001 = p_sfoe001 AND sfoe002 = 'sfcd003'
      SELECT sfoe004 INTO l_sfcd004 FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno AND sfoeseq = p_sfoeseq AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2 AND sfoe001 = p_sfoe001 AND sfoe002 = 'sfcd004'
      SELECT sfoe004 INTO l_sfcd009 FROM sfoe_t WHERE sfoeent = g_enterprise AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno AND sfoeseq = p_sfoeseq AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2 AND sfoe001 = p_sfoe001 AND sfoe002 = 'sfcd009'
      IF cl_null(l_sfcd003) THEN
         LET l_sfcd003 = l_sfod.sfod003
      END IF
      IF cl_null(l_sfcd004) THEN
         LET l_sfcd004 = l_sfod.sfod004
      END IF
      IF cl_null(l_sfcd009) THEN
         LET l_sfcd009 = l_sfod.sfod009
      END IF
      #161109-00085#36-s
      #SELECT * INTO l_sfcd.* FROM sfcd_t WHERE sfcdent = g_enterprise AND sfcdsite = g_site
      SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,
             sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,
             sfcd008,sfcd009 
        INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
             l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
             l_sfcd.sfcd008,l_sfcd.sfcd009
        FROM sfcd_t WHERE sfcdent = g_enterprise AND sfcdsite = g_site     
      #161109-00085#36-e
         AND sfcddocno = p_sfoedocno AND sfcd001 = p_sfoeseq AND sfcd002 = p_sfoeseq1
         AND sfcd003 = l_sfcd003 AND sfcd004 = l_sfcd004 AND sfcd009 = l_sfcd009
   END IF
   
   LET g_sfoe003 = ''
   IF l_sfod.sfod901 = '2' THEN
      IF l_sfod.sfod009 = '1' THEN
         LET g_sfoe003 = '4'
      END IF
      IF l_sfod.sfod009 = '2' THEN
         LET g_sfoe003 = '7'
      END IF
   END IF
   IF l_sfod.sfod901 = '3' THEN
      IF l_sfod.sfod009 = '1' THEN
         LET g_sfoe003 = '5'
      END IF
      IF l_sfod.sfod009 = '2' THEN
         LET g_sfoe003 = '8'
      END IF
   END IF
   IF l_sfod.sfod901 = '4' THEN      
      IF l_sfod.sfod009 = '1' THEN
         LET g_sfoe003 = '6'
      END IF
      IF l_sfod.sfod009 = '2' THEN
         LET g_sfoe003 = '9'
      END IF
      INITIALIZE l_sfod.* TO NULL
   END IF

   #项目
   IF (NOT cl_null(l_sfod.sfod003) AND (l_sfod.sfod003 != l_sfcd.sfcd003 OR l_sfcd.sfcd003 IS NULL)) OR (cl_null(l_sfod.sfod003) AND l_sfcd.sfcd003 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '223' AND oocql002='"||l_sfcd.sfcd003||"' AND oocql003=? "
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd003',g_sfoe003,l_sfcd.sfcd003,l_sfod.sfod003,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd003') THEN
         RETURN r_success
      END IF
   END IF

   #形态
   IF (NOT cl_null(l_sfod.sfod004) AND (l_sfod.sfod004 != l_sfcd.sfcd004 OR l_sfcd.sfcd004 IS NULL)) OR (cl_null(l_sfod.sfod004) AND l_sfcd.sfcd004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd004',g_sfoe003,l_sfcd.sfcd004,l_sfod.sfod004,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd004') THEN
         RETURN r_success
      END IF
   END IF
   
   #下限
   IF (NOT cl_null(l_sfod.sfod005) AND (l_sfod.sfod005 != l_sfcd.sfcd005 OR l_sfcd.sfcd005 IS NULL)) OR (cl_null(l_sfod.sfod005) AND l_sfcd.sfcd005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd005',g_sfoe003,l_sfcd.sfcd005,l_sfod.sfod005,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd005') THEN
         RETURN r_success
      END IF
   END IF
   
   #上限
   IF (NOT cl_null(l_sfod.sfod006) AND (l_sfod.sfod006 != l_sfcd.sfcd006 OR l_sfcd.sfcd006 IS NULL)) OR (cl_null(l_sfod.sfod006) AND l_sfcd.sfcd006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd006',g_sfoe003,l_sfcd.sfcd006,l_sfod.sfod006,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd006') THEN
         RETURN r_success
      END IF
   END IF
   
   #预设值
   IF (NOT cl_null(l_sfod.sfod007) AND (l_sfod.sfod007 != l_sfcd.sfcd007 OR l_sfcd.sfcd007 IS NULL)) OR (cl_null(l_sfod.sfod007) AND l_sfcd.sfcd007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd007',g_sfoe003,l_sfcd.sfcd007,l_sfod.sfod007,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd007') THEN
         RETURN r_success
      END IF
   END IF
   
   #必要
   IF (NOT cl_null(l_sfod.sfod008) AND (l_sfod.sfod008 != l_sfcd.sfcd008 OR l_sfcd.sfcd008 IS NULL)) OR (cl_null(l_sfod.sfod008) AND l_sfcd.sfcd008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_sfoe007 = ""
      IF NOT s_asft801_ins_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd008',g_sfoe003,l_sfcd.sfcd008,l_sfod.sfod008,g_sfoe007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asft801_del_sfoe(p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,'sfcd008') THEN
         RETURN r_success
      END IF
   END IF
   
   #未有发生变更，则更新sfod901
   IF l_flag = 'N' THEN
      UPDATE sfod_t SET sfod901 = '1' WHERE sfodent = g_enterprise AND sfodsite = g_site
         AND sfoddocno = p_sfoedocno AND sfod001 = p_sfoeseq AND sfod002 = p_sfoeseq1
         AND sfod900 = p_sfoe900 AND sfodseq = p_sfoeseq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd sfod901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除
PRIVATE FUNCTION asft801_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_sql           STRING  #170123-00041#1---add   
   
   IF g_sfoa_m.sfoadocno IS NULL
   OR g_sfoa_m.sfoa001 IS NULL
   OR g_sfoa_m.sfoa900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   
 
   CALL asft801_show()
   
   CALL s_transaction_begin()
 
   OPEN asft801_cl USING g_enterprise,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asft801_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE asft801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 ##170123-00041#1---add----str 
   LET l_sql = "SELECT sfoadocno,sfoa002,'','','','','','','',sfoastus,sfoa001,sfoa005,'','','',sfoa003,'','','','',sfoa004,'','','',sfoasite,'','',sfoa900,sfoa902,sfoa905,'',sfoa906,",
                      " sfoaownid,'',sfoaowndp,'',sfoacrtid,'',sfoacrtdp,'',sfoacrtdt,sfoamodid,'',sfoamoddt,sfoacnfid,'',sfoacnfdt   FROM sfoa_t",
                      " WHERE sfoaent=? AND sfoasite='",g_site,"' AND sfoadocno=? AND sfoa001=? AND sfoa900=? "
   PREPARE asft801_referesh_d FROM l_sql                   
   
   EXECUTE asft801_referesh_d USING g_enterprise,g_sfoa_m.sfoadocno,g_sfoa_m.sfoa001,g_sfoa_m.sfoa900 INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt
  ##170123-00041#1---add----end
##170123-00041#1---mark----str 
   #鎖住將被更改或取消的資料
#   FETCH asft801_cl INTO g_sfoa_m.sfoadocno,g_sfoa_m.sfoa002,g_sfoa_m.sfaa010,g_sfoa_m.sfaa011,g_sfoa_m.sfaa017,
#       g_sfoa_m.sfaa017_desc,g_sfoa_m.oobal004,g_sfoa_m.sfaa010_desc,g_sfoa_m.sfaa019,g_sfoa_m.sfoastus,
#       g_sfoa_m.sfoa001,g_sfoa_m.sfoa005,g_sfoa_m.sfaa010_desc1,g_sfoa_m.sfaa020,g_sfoa_m.sfaa003,g_sfoa_m.sfoa003,
#       g_sfoa_m.sfaa013,g_sfoa_m.sfaa005,g_sfoa_m.sfaa016,g_sfoa_m.sfaa016_desc,g_sfoa_m.sfoa004,g_sfoa_m.sfaa006,
#       g_sfoa_m.sfaa007,g_sfoa_m.sfaa008,g_sfoa_m.sfoasite,g_sfoa_m.sfaa009,g_sfoa_m.sfaa009_desc,
#       g_sfoa_m.sfoa900,g_sfoa_m.sfoa902,g_sfoa_m.sfoa905,g_sfoa_m.sfoa905_desc,g_sfoa_m.sfoa906,
#       g_sfoa_m.sfoaownid,g_sfoa_m.sfoaownid_desc,g_sfoa_m.sfoaowndp,g_sfoa_m.sfoaowndp_desc,g_sfoa_m.sfoacrtid,g_sfoa_m.sfoacrtid_desc, 
#       g_sfoa_m.sfoacrtdp,g_sfoa_m.sfoacrtdp_desc,g_sfoa_m.sfoacrtdt,g_sfoa_m.sfoamodid,g_sfoa_m.sfoamodid_desc,g_sfoa_m.sfoamoddt,
#       g_sfoa_m.sfoacnfid,g_sfoa_m.sfoacnfid_desc,g_sfoa_m.sfoacnfdt
##170123-00041#1---mark----end 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_sfoa_m.sfoadocno 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask
   #161221-00052#1-S
   #IF g_sfoa_m.sfoastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'apm-00034'
   #   LET g_errparam.extend = g_sfoa_m.sfoastus
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #161221-00052#1-E
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_sfoadocno_t = g_sfoa_m.sfoadocno
      LET g_sfoa001_t = g_sfoa_m.sfoa001
      LET g_sfoa900_t = g_sfoa_m.sfoa900
 
      DELETE FROM sfoa_t
       WHERE sfoaent = g_enterprise AND sfoasite = g_site
         AND sfoadocno = g_sfoa_m.sfoadocno
         AND sfoa001 = g_sfoa_m.sfoa001
         AND sfoa900 = g_sfoa_m.sfoa900
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_sfoa_m.sfoadocno 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
  
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM sfob_t
       WHERE sfobent = g_enterprise AND sfobsite = g_site
         AND sfobdocno = g_sfoa_m.sfoadocno
         AND sfob001 = g_sfoa_m.sfoa001
         AND sfob900 = g_sfoa_m.sfoa900
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfob_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      
      DELETE FROM sfoc_t
       WHERE sfocent = g_enterprise AND sfocsite = g_site 
         AND sfocdocno = g_sfoa_m.sfoadocno
         AND sfoc001 = g_sfoa_m.sfoa001
         AND sfoc900 = g_sfoa_m.sfoa900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sfoc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN   
      END IF
      
      DELETE FROM sfod_t
       WHERE sfodent = g_enterprise 
         AND sfodsite = g_site 
         AND sfoddocno = g_sfoa_m.sfoadocno
         AND sfod001 = g_sfoa_m.sfoa001
         AND sfod900 = g_sfoa_m.sfoa900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sfod_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      
      DELETE FROM sfoe_t
       WHERE sfoeent = g_enterprise 
         AND sfoesite = g_site 
         AND sfoedocno = g_sfoa_m.sfoadocno
         AND sfoeseq = g_sfoa_m.sfoa001
         AND sfoe001 = g_sfoa_m.sfoa900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sfoe_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
                                                               
      CLEAR FORM
      CALL g_sfob_d.clear()     
 
      CALL asft801_ui_headershow()  
      CALL asft801_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL asft801_browser_fill("")
         CALL asft801_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL asft801_browser_fill("F")
      END IF
 
      #add-point:多語言刪除

      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
      
 
 
   
      #add-point:多語言刪除

      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE asft801_cl

END FUNCTION

################################################################################
# Descriptions...: 工作站名稱
# Memo...........:
# Usage..........: CALL asft801_sfob011_ref(p_ecaa001)
#                  RETURNING r_ecaa002
# Input parameter: 
# Return code....: 
# Date & Author..: 160822-00017 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asft801_sfob011_ref(p_ecaa001)
DEFINE p_ecaa001    LIKE ecaa_t.ecaa001
DEFINE r_ecaa002    LIKE ecaa_t.ecaa002

   LET r_ecaa002 = ''
   SELECT ecaa002 INTO r_ecaa002
     FROM ecaa_t
    WHERE ecaaent = g_enterprise
      AND ecaasite = g_site
      AND ecaa001 = p_ecaa001

   RETURN r_ecaa002
END FUNCTION
#170111-00015#3 add
#往上退，单身变更类型不是单身删除的资料
PRIVATE FUNCTION asft801_get_previous()
DEFINE l_i    LIKE type_t.num5
DEFINE r_i    LIKE type_t.num5

   LET r_i = 0
   IF l_ac > 1 THEN
      FOR l_i = l_ac-1 TO 1 STEP -1
        IF g_sfob_d[l_i].sfob901 <> '4' THEN
           LET r_i = l_i
           EXIT FOR
        END IF
      END FOR
   END IF
   RETURN r_i
   
END FUNCTION

#170111-00015#3 add
#往下退，单身变更类型不是单身删除的资料
PRIVATE FUNCTION asft801_get_next()
DEFINE l_i    LIKE type_t.num5
DEFINE r_i    LIKE type_t.num5

   LET r_i = 0
   IF l_ac > 1 THEN
      FOR l_i = l_ac+1 TO g_sfob_d.getLength()
        IF g_sfob_d[l_i].sfob901 <> '4' THEN
           LET r_i = l_i
           EXIT FOR
        END IF
      END FOR
   END IF
   RETURN r_i
   
END FUNCTION

#end add-point
 
{</section>}
 

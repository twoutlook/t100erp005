#該程式未解開Section, 採用最新樣板產出!
{<section id="afat505_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-10-31 10:01:52), PR版次:0006(2016-11-28 13:45:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000092
#+ Filename...: afat505_01
#+ Description: 帳務明細
#+ Creator....: 02114(2014-08-05 13:54:01)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="afat505_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150916-00015#1  2015/12/7  By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00025#13 2016/04/15 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#2  2016/09/05 by 08742    调整系统中无ENT的SQL条件增加ent
#160913-00017#1  2016/09/19 By 07900    AFA模组调整交易客商开窗\
#161111-00028#8  2016/11/28 by 02481    标准程式定义采用宣告模式,弃用.*写法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_fabo_d RECORD
       fabodocno LIKE fabo_t.fabodocno, 
   fabold LIKE fabo_t.fabold, 
   faboseq LIKE fabo_t.faboseq, 
   fabo008 LIKE fabo_t.fabo008, 
   fabo009 LIKE fabo_t.fabo009, 
   fabo010 LIKE fabo_t.fabo010, 
   fabo006 LIKE fabo_t.fabo006, 
   fabo012 LIKE fabo_t.fabo012, 
   fabo013 LIKE fabo_t.fabo013, 
   fabo014 LIKE fabo_t.fabo014, 
   fabo015 LIKE fabo_t.fabo015, 
   fabo016 LIKE fabo_t.fabo016, 
   fabo017 LIKE fabo_t.fabo017, 
   fabo049 LIKE fabo_t.fabo049, 
   fabo011 LIKE fabo_t.fabo011, 
   fabo018 LIKE fabo_t.fabo018, 
   fabo019 LIKE fabo_t.fabo019, 
   fabo020 LIKE fabo_t.fabo020, 
   fabo021 LIKE fabo_t.fabo021, 
   fabo022 LIKE fabo_t.fabo022
       END RECORD
PRIVATE TYPE type_g_fabo2_d RECORD
       fabodocno LIKE fabo_t.fabodocno, 
   fabold LIKE fabo_t.fabold, 
   faboseq LIKE fabo_t.faboseq, 
   fabo024 LIKE fabo_t.fabo024, 
   fabo024_desc LIKE type_t.chr500, 
   fabo042 LIKE fabo_t.fabo042, 
   fabo031 LIKE fabo_t.fabo031, 
   fabo031_desc LIKE type_t.chr500, 
   fabo032 LIKE fabo_t.fabo032, 
   fabo032_desc LIKE type_t.chr500, 
   fabo033 LIKE fabo_t.fabo033, 
   fabo033_desc LIKE type_t.chr500, 
   fabo034 LIKE fabo_t.fabo034, 
   fabo034_desc LIKE type_t.chr500, 
   fabo035 LIKE fabo_t.fabo035, 
   fabo035_desc LIKE type_t.chr500, 
   fabo036 LIKE fabo_t.fabo036, 
   fabo036_desc LIKE type_t.chr500, 
   fabo037 LIKE fabo_t.fabo037, 
   fabo037_desc LIKE type_t.chr500, 
   fabo038 LIKE fabo_t.fabo038, 
   fabo038_desc LIKE type_t.chr500, 
   fabo039 LIKE fabo_t.fabo039, 
   fabo039_desc LIKE type_t.chr500, 
   fabo040 LIKE fabo_t.fabo040, 
   fabo040_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_fabo7_d RECORD
       fabodocno LIKE fabo_t.fabodocno, 
   fabold LIKE fabo_t.fabold, 
   faboseq LIKE fabo_t.faboseq, 
   fabo107 LIKE fabo_t.fabo107, 
   fabo101 LIKE fabo_t.fabo101, 
   fabo102 LIKE fabo_t.fabo102, 
   fabo111 LIKE fabo_t.fabo111, 
   fabo103 LIKE fabo_t.fabo103, 
   fabo104 LIKE fabo_t.fabo104, 
   fabo105 LIKE fabo_t.fabo105, 
   fabo106 LIKE fabo_t.fabo106, 
   fabo108 LIKE fabo_t.fabo108, 
   fabo109 LIKE fabo_t.fabo109, 
   fabo110 LIKE fabo_t.fabo110, 
   fabo156 LIKE fabo_t.fabo156, 
   fabo150 LIKE fabo_t.fabo150, 
   fabo151 LIKE fabo_t.fabo151, 
   fabo160 LIKE fabo_t.fabo160, 
   fabo152 LIKE fabo_t.fabo152, 
   fabo153 LIKE fabo_t.fabo153, 
   fabo154 LIKE fabo_t.fabo154, 
   fabo155 LIKE fabo_t.fabo155, 
   fabo157 LIKE fabo_t.fabo157, 
   fabo158 LIKE fabo_t.fabo158, 
   fabo159 LIKE fabo_t.fabo159
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_fabo3_d RECORD
   fabudocno LIKE fabu_t.fabudocno, 
   fabuld    LIKE fabu_t.fabuld, 
   fabuseq   LIKE fabu_t.fabuseq, 
   fabu009   LIKE fabu_t.fabu009,  
   fabu010   LIKE fabu_t.fabu010,
   fabu006   LIKE fabu_t.fabu006,    
   fabu012   LIKE fabu_t.fabu012, 
   fabu013   LIKE fabu_t.fabu013, 
   fabu014   LIKE fabu_t.fabu014, 
   fabu015   LIKE fabu_t.fabu015, 
   fabu016   LIKE fabu_t.fabu016, 
   fabu017   LIKE fabu_t.fabu017,
   fabu011   LIKE fabu_t.fabu011
       END RECORD
 TYPE type_g_fabo4_d RECORD
   fabudocno    LIKE fabu_t.fabudocno, 
   fabuld       LIKE fabu_t.fabuld, 
   fabuseq      LIKE fabu_t.fabuseq, 
   fabu022      LIKE fabu_t.fabu022, 
   fabu022_desc LIKE type_t.chr80, 
   fabu035      LIKE fabu_t.fabu035, 
   fabu024      LIKE fabu_t.fabu024,
   fabu024_desc LIKE type_t.chr80,
   fabu025      LIKE fabu_t.fabu025,
   fabu025_desc LIKE type_t.chr80,   
   fabu026      LIKE fabu_t.fabu026, 
   fabu026_desc LIKE type_t.chr80,
   fabu027      LIKE fabu_t.fabu027, 
   fabu027_desc LIKE type_t.chr80,
   fabu028      LIKE fabu_t.fabu028, 
   fabu028_desc LIKE type_t.chr80,
   fabu029      LIKE fabu_t.fabu029, 
   fabu029_desc LIKE type_t.chr80,
   fabu030      LIKE fabu_t.fabu030, 
   fabu030_desc LIKE type_t.chr80,
   fabu031      LIKE fabu_t.fabu031, 
   fabu031_desc LIKE type_t.chr80,
   fabu032      LIKE fabu_t.fabu032, 
   fabu032_desc LIKE type_t.chr80,
   fabu033      LIKE fabu_t.fabu033,
   fabu033_desc LIKE type_t.chr80
       END RECORD
 TYPE type_g_fabo5_d RECORD
   xrcddocno LIKE xrcd_t.xrcddocno, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd001 LIKE xrcd_t.xrcd001, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   fabo001 LIKE fabo_t.fabo001, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_5_desc LIKE type_t.chr80, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd103 LIKE xrcd_t.xrcd103, 
   xrcd104 LIKE xrcd_t.xrcd104, 
   xrcd105 LIKE xrcd_t.xrcd105, 
   xrcd113 LIKE xrcd_t.xrcd113,
   xrcd114 LIKE xrcd_t.xrcd114,
   xrcd115 LIKE xrcd_t.xrcd115,
   xrcd009 LIKE xrcd_t.xrcd009, 
   xrcd009_5_desc LIKE type_t.chr80
       END RECORD
 TYPE type_g_fabo6_d RECORD
   xrcddocno LIKE xrcd_t.xrcddocno, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd001 LIKE xrcd_t.xrcd001, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   fabo001 LIKE fabo_t.fabo001, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_6_desc LIKE type_t.chr80, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd103 LIKE xrcd_t.xrcd103, 
   xrcd104 LIKE xrcd_t.xrcd104, 
   xrcd105 LIKE xrcd_t.xrcd105, 
   xrcd113 LIKE xrcd_t.xrcd113,
   xrcd114 LIKE xrcd_t.xrcd114,
   xrcd115 LIKE xrcd_t.xrcd115,
   xrcd009 LIKE xrcd_t.xrcd009, 
   xrcd009_6_desc LIKE type_t.chr80
       END RECORD
 TYPE type_g_fabo8_d RECORD
   fabudocno LIKE fabu_t.fabudocno, 
   fabuld     LIKE fabu_t.fabuld, 
   fabuseq    LIKE fabu_t.fabuseq, 
   fabu106    LIKE fabu_t.fabu106, 
   fabu101    LIKE fabu_t.fabu101, 
   fabu102    LIKE fabu_t.fabu102, 
   fabu107    LIKE fabu_t.fabu107, 
   fabu103    LIKE fabu_t.fabu103, 
   fabu104    LIKE fabu_t.fabu104, 
   fabu105    LIKE fabu_t.fabu105, 
   fabu155    LIKE fabu_t.fabu155, 
   fabu150    LIKE fabu_t.fabu150, 
   fabu151    LIKE fabu_t.fabu151, 
   fabu156    LIKE fabu_t.fabu156, 
   fabu152    LIKE fabu_t.fabu152, 
   fabu153    LIKE fabu_t.fabu153, 
   fabu154    LIKE fabu_t.fabu154
       END RECORD
DEFINE g_fabo3_d   DYNAMIC ARRAY OF type_g_fabo3_d
DEFINE g_fabo3_d_t type_g_fabo3_d
DEFINE g_fabo3_d_o type_g_fabo3_d
DEFINE g_fabo4_d   DYNAMIC ARRAY OF type_g_fabo4_d
DEFINE g_fabo4_d_t type_g_fabo4_d
DEFINE g_fabo4_d_o type_g_fabo4_d
DEFINE g_fabo5_d   DYNAMIC ARRAY OF type_g_fabo5_d
DEFINE g_fabo5_d_t type_g_fabo5_d
DEFINE g_fabo5_d_o type_g_fabo5_d
DEFINE g_fabo6_d   DYNAMIC ARRAY OF type_g_fabo6_d
DEFINE g_fabo6_d_t type_g_fabo6_d
DEFINE g_fabo6_d_o type_g_fabo6_d
DEFINE g_fabo8_d   DYNAMIC ARRAY OF type_g_fabo8_d
DEFINE g_fabo8_d_t type_g_fabo8_d
DEFINE g_fabo8_d_o type_g_fabo8_d

#end add-point
 
#模組變數(Module Variables)
DEFINE g_fabo_d          DYNAMIC ARRAY OF type_g_fabo_d #單身變數
DEFINE g_fabo_d_t        type_g_fabo_d                  #單身備份
DEFINE g_fabo_d_o        type_g_fabo_d                  #單身備份
DEFINE g_fabo_d_mask_o   DYNAMIC ARRAY OF type_g_fabo_d #單身變數
DEFINE g_fabo_d_mask_n   DYNAMIC ARRAY OF type_g_fabo_d #單身變數
DEFINE g_fabo2_d   DYNAMIC ARRAY OF type_g_fabo2_d
DEFINE g_fabo2_d_t type_g_fabo2_d
DEFINE g_fabo2_d_o type_g_fabo2_d
DEFINE g_fabo2_d_mask_o DYNAMIC ARRAY OF type_g_fabo2_d
DEFINE g_fabo2_d_mask_n DYNAMIC ARRAY OF type_g_fabo2_d
DEFINE g_fabo7_d   DYNAMIC ARRAY OF type_g_fabo7_d
DEFINE g_fabo7_d_t type_g_fabo7_d
DEFINE g_fabo7_d_o type_g_fabo7_d
DEFINE g_fabo7_d_mask_o DYNAMIC ARRAY OF type_g_fabo7_d
DEFINE g_fabo7_d_mask_n DYNAMIC ARRAY OF type_g_fabo7_d
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
DEFINE g_fabgld            LIKE fabg_t.fabgld
DEFINE g_fabgdocno         LIKE fabg_t.fabgdocno
DEFINE g_faboseq           LIKE fabo_t.faboseq  
DEFINE g_fabo001           LIKE fabo_t.fabo001
DEFINE g_fabo002           LIKE fabo_t.fabo002
DEFINE g_fabo003           LIKE fabo_t.fabo003
DEFINE g_ooef019           LIKE ooef_t.ooef019
DEFINE g_faah021           LIKE faah_t.faah021
DEFINE g_fabo006           LIKE fabo_t.fabo006
DEFINE g_fabo007           LIKE fabo_t.fabo007
DEFINE g_glaacomp          LIKE glaa_t.glaacomp
DEFINE g_fabgdocdt         LIKE fabg_t.fabgdocdt
DEFINE g_faaj016           LIKE faaj_t.faaj016
DEFINE g_faaj028           LIKE faaj_t.faaj028
DEFINE g_glaa001           LIKE glaa_t.glaa001
DEFINE g_glaa004           LIKE glaa_t.glaa004
DEFINE g_glaa015           LIKE glaa_t.glaa015
DEFINE g_glaa016           LIKE glaa_t.glaa016
DEFINE g_glaa017           LIKE glaa_t.glaa017
DEFINE g_glaa018           LIKE glaa_t.glaa018
DEFINE g_glaa019           LIKE glaa_t.glaa019
DEFINE g_glaa020           LIKE glaa_t.glaa020
DEFINE g_glaa021           LIKE glaa_t.glaa021
DEFINE g_glaa022           LIKE glaa_t.glaa022
DEFINE g_glaa024           LIKE glaa_t.glaa024
DEFINE g_glaa025           LIKE glaa_t.glaa025

DEFINE g_para_data         LIKE type_t.chr80
DEFINE g_faah000           LIKE faah_t.faah000
DEFINE g_faah001           LIKE faah_t.faah001
DEFINE g_fabgstus          LIKE fabg_t.fabgstus
DEFINE g_faah018           LIKE faah_t.faah018
DEFINE g_fabo044           LIKE fabo_t.fabo044 #20141113 add
DEFINE g_fabo047           LIKE fabo_t.fabo047 #20141113 add
#end add-point
 
{</section>}
 
{<section id="afat505_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afat505_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fabgld,p_fabgdocno,p_faboseq,p_fabo001,p_fabo002,p_fabo003,p_fabo007,p_fabgdocdt,p_fabo044,p_fabo047 #20141113 add p_fabo044,p_fabo047 by chenying
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_fabgld            LIKE fabg_t.fabgld
   DEFINE p_fabgdocno         LIKE fabg_t.fabgdocno
   DEFINE p_faboseq           LIKE fabo_t.faboseq   
   DEFINE p_fabo001           LIKE fabo_t.fabo001
   DEFINE p_fabo002           LIKE fabo_t.fabo002
   DEFINE p_fabo003           LIKE fabo_t.fabo003
   DEFINE p_fabo007           LIKE fabo_t.fabo007
   DEFINE p_fabgdocdt         LIKE fabg_t.fabgdocdt
   DEFINE l_ld                LIKE glaa_t.glaald
   DEFINE l_errno             LIKE gzze_t.gzze001
   DEFINE l_success           LIKE type_t.num10
   DEFINE p_fabo044           LIKE fabo_t.fabo044   #20141113 add 
   DEFINE p_fabo047           LIKE fabo_t.fabo047   #20141113 add

   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_fabgld    = p_fabgld   
   LET g_fabgdocno = p_fabgdocno
   LET g_faboseq   = p_faboseq  
   LET g_fabo007   = p_fabo007
   LET g_fabgdocdt = p_fabgdocdt
   LET g_fabo001   = p_fabo001
   LET g_fabo002   = p_fabo002
   LET g_fabo003   = p_fabo003
   LET g_fabo044   = p_fabo044 #20141113 add  
   LET g_fabo047   = p_fabo047 #20141113 add 
   
   SELECT faah018 INTO g_fabo006
     FROM faah_t
    WHERE faahent = g_enterprise  
      AND faah003 = g_fabo001   
      AND faah004 = g_fabo002
      AND faah001 = g_fabo003 
      
   SELECT glaa001,glaa004,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa024,glaa025 
     INTO g_glaa001,g_glaa004,g_glaa015,g_glaa016,g_glaa017,g_glaa018,
          g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa024,g_glaa025          
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_fabgld
   
   #抓取法人
   CALL s_fin_ld_carry(p_fabgld,'') RETURNING l_success,l_ld,g_glaacomp,l_errno
   
   #所屬稅區
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_glaacomp
      
   #抓取成本和未折減額 
   SELECT faaj016,faaj028 INTO g_faaj016,g_faaj028
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faajld  = p_fabgld
      AND faaj001 = p_fabo001   
      AND faaj002 = p_fabo002
      AND faaj037 = p_fabo003
      
   CALL cl_get_para(g_enterprise,g_glaacomp,'S-FIN-9016') RETURNING g_para_data   
   
   #獲取單據狀態
   SELECT fabgstus INTO g_fabgstus FROM fabg_t
    WHERE fabgent = g_enterprise AND fabgld = g_fabgld
      AND fabgdocno = g_fabgdocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   LET g_forupd_sql = "SELECT fabudocno,fabuld,fabuseq,fabu009,fabu010,fabu006,fabu012,fabu013,fabu014,fabu015, 
       fabu016,fabu017,fabu011,fabudocno,fabuld,fabuseq,fabu022,fabu035,fabu024,fabu025,fabu026,fabu027,fabu028, 
       fabu029,fabu030,fabu031,fabu032,fabu033,fabudocno,fabuld,fabuseq,fabu106,fabu101,fabu102,fabu107, 
       fabu103,fabu104,fabu105,fabu155,fabu150,fabu151,fabu156,fabu152,fabu153,fabu154
       FROM fabu_t WHERE fabuent=? AND fabuld=? AND fabudocno=? AND fabuseq=?  
       FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_01_bcl2 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT xrcddocno,xrcdld,xrcdseq2,xrcd001,xrcdseq,xrcd007,xrcd002,xrcd003,xrcd006, 
       xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd009 FROM xrcd_t WHERE xrcdent=? AND xrcdld=? AND xrcddocno=?  
       AND xrcdseq=? AND xrcdseq2=? AND xrcd007=? FOR UPDATE"
       
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_01_bcl3 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT xrcddocno,xrcdld,xrcdseq2,xrcd001,xrcdseq,xrcd007,xrcd002,xrcd003,xrcd006, 
       xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd009 FROM xrcd_t WHERE xrcdent=? AND xrcdld=? AND xrcddocno=?  
       AND xrcdseq=? AND xrcdseq2=? AND xrcd007=? FOR UPDATE"
       
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_01_bcl4 CURSOR FROM g_forupd_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabodocno,fabold,faboseq,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013, 
       fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022,fabodocno, 
       fabold,faboseq,fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038, 
       fabo039,fabo040,fabodocno,fabold,faboseq,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105, 
       fabo106,fabo108,fabo109,fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155, 
       fabo157,fabo158,fabo159 FROM fabo_t WHERE faboent=? AND fabold=? AND fabodocno=? AND faboseq=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat505_01 WITH FORM cl_ap_formpath("afa","afat505_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afat505_01_init()   
 
   #進入選單 Menu (="N")
   CALL afat505_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afat505_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat505_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afat505_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
 
   #end add-point
   
   CALL afat505_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afat505_01_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fabo_d.clear()
         CALL g_fabo2_d.clear()
         CALL g_fabo7_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL afat505_01_init()
      END IF
   
      CALL afat505_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fabo_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat505_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_fabo2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat505_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_fabo7_d TO s_detail7.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body7.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body7.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat505_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row7"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_fabo3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
               CALL afat505_01_set_pk_array()
               #add-point:ON ACTION agendum
               
               #END add-point
               CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_fabo4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
               CALL afat505_01_set_pk_array()
               #add-point:ON ACTION agendum
               
               #END add-point
               CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
         DISPLAY ARRAY g_fabo5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
               CALL afat505_01_set_pk_array()
               #add-point:ON ACTION agendum
               
               #END add-point
               CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
               
            #自訂ACTION(detail_show,page_5)
            
               
         END DISPLAY
         DISPLAY ARRAY g_fabo6_d TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
               CALL afat505_01_set_pk_array()
               #add-point:ON ACTION agendum
               
               #END add-point
               CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
               
            #自訂ACTION(detail_show,page_6)
            
               
         END DISPLAY
         DISPLAY ARRAY g_fabo8_d TO s_detail8.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail8")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #+ 此段落由子樣板a48產生
               CALL afat505_01_set_pk_array()
               #add-point:ON ACTION agendum
               
               #END add-point
               CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row

               #end add-point
               
            #自訂ACTION(detail_show,page_8)
            
               
         END DISPLAY
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL DIALOG.setSelectionMode("s_detail7", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            CALL DIALOG.setSelectionMode("s_detail3", 1)
            CALL DIALOG.setSelectionMode("s_detail4", 1)
            CALL DIALOG.setSelectionMode("s_detail5", 1)
            CALL DIALOG.setSelectionMode("s_detail6", 1)
            CALL DIALOG.setSelectionMode("s_detail8", 1)
            
            IF g_fabgstus = 'N' THEN
               CALL cl_set_act_visible("insert,modify,modify_detail,delete", TRUE)
            ELSE
               CALL cl_set_act_visible("insert,modify,modify_detail,delete", FALSE)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL afat505_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat505_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL afat505_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat505_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
               CALL afat505_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
 
 
 
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
               CALL afat505_01_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL afat505_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat505_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fabo_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_fabo2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_fabo7_d)
               LET g_export_id[3]   = "s_detail7"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat505_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat505_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat505_01_set_pk_array()
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         LET g_action_choice = ''
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat505_01_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_fabo_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON fabodocno,fabold,faboseq,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013,fabo014, 
          fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022,fabo024,fabo024_desc, 
          fabo042,fabo031,fabo031_desc,fabo032,fabo032_desc,fabo033,fabo033_desc,fabo034,fabo034_desc, 
          fabo035,fabo035_desc,fabo036,fabo036_desc,fabo037,fabo037_desc,fabo038,fabo038_desc,fabo039, 
          fabo039_desc,fabo040,fabo040_desc,fabo108,fabo109,fabo110,fabo157,fabo158,fabo159 
 
         FROM s_detail1[1].fabodocno,s_detail1[1].fabold,s_detail1[1].faboseq,s_detail1[1].fabo008,s_detail1[1].fabo009, 
             s_detail1[1].fabo010,s_detail1[1].fabo006,s_detail1[1].fabo012,s_detail1[1].fabo013,s_detail1[1].fabo014, 
             s_detail1[1].fabo015,s_detail1[1].fabo016,s_detail1[1].fabo017,s_detail1[1].fabo049,s_detail1[1].fabo011, 
             s_detail1[1].fabo018,s_detail1[1].fabo019,s_detail1[1].fabo020,s_detail1[1].fabo021,s_detail1[1].fabo022, 
             s_detail2[1].fabo024,s_detail2[1].fabo024_desc,s_detail2[1].fabo042,s_detail2[1].fabo031, 
             s_detail2[1].fabo031_desc,s_detail2[1].fabo032,s_detail2[1].fabo032_desc,s_detail2[1].fabo033, 
             s_detail2[1].fabo033_desc,s_detail2[1].fabo034,s_detail2[1].fabo034_desc,s_detail2[1].fabo035, 
             s_detail2[1].fabo035_desc,s_detail2[1].fabo036,s_detail2[1].fabo036_desc,s_detail2[1].fabo037, 
             s_detail2[1].fabo037_desc,s_detail2[1].fabo038,s_detail2[1].fabo038_desc,s_detail2[1].fabo039, 
             s_detail2[1].fabo039_desc,s_detail2[1].fabo040,s_detail2[1].fabo040_desc,s_detail7[1].fabo108, 
             s_detail7[1].fabo109,s_detail7[1].fabo110,s_detail7[1].fabo157,s_detail7[1].fabo158,s_detail7[1].fabo159  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabodocno
            #add-point:BEFORE FIELD fabodocno name="query.b.page1.fabodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabodocno
            
            #add-point:AFTER FIELD fabodocno name="query.a.page1.fabodocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabodocno
            #add-point:ON ACTION controlp INFIELD fabodocno name="query.c.page1.fabodocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabold
            #add-point:BEFORE FIELD fabold name="query.b.page1.fabold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabold
            
            #add-point:AFTER FIELD fabold name="query.a.page1.fabold"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabold
            #add-point:ON ACTION controlp INFIELD fabold name="query.c.page1.fabold"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="query.b.page1.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="query.a.page1.faboseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="query.c.page1.faboseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo008
            #add-point:BEFORE FIELD fabo008 name="query.b.page1.fabo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo008
            
            #add-point:AFTER FIELD fabo008 name="query.a.page1.fabo008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo008
            #add-point:ON ACTION controlp INFIELD fabo008 name="query.c.page1.fabo008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo009
            #add-point:ON ACTION controlp INFIELD fabo009 name="construct.c.page1.fabo009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo009  #顯示到畫面上
            NEXT FIELD fabo009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo009
            #add-point:BEFORE FIELD fabo009 name="query.b.page1.fabo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo009
            
            #add-point:AFTER FIELD fabo009 name="query.a.page1.fabo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo010
            #add-point:ON ACTION controlp INFIELD fabo010 name="construct.c.page1.fabo010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo010  #顯示到畫面上
            NEXT FIELD fabo010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo010
            #add-point:BEFORE FIELD fabo010 name="query.b.page1.fabo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo010
            
            #add-point:AFTER FIELD fabo010 name="query.a.page1.fabo010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo006
            #add-point:BEFORE FIELD fabo006 name="query.b.page1.fabo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo006
            
            #add-point:AFTER FIELD fabo006 name="query.a.page1.fabo006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo006
            #add-point:ON ACTION controlp INFIELD fabo006 name="query.c.page1.fabo006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo012
            #add-point:BEFORE FIELD fabo012 name="query.b.page1.fabo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo012
            
            #add-point:AFTER FIELD fabo012 name="query.a.page1.fabo012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo012
            #add-point:ON ACTION controlp INFIELD fabo012 name="query.c.page1.fabo012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo013
            #add-point:BEFORE FIELD fabo013 name="query.b.page1.fabo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo013
            
            #add-point:AFTER FIELD fabo013 name="query.a.page1.fabo013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo013
            #add-point:ON ACTION controlp INFIELD fabo013 name="query.c.page1.fabo013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo014
            #add-point:BEFORE FIELD fabo014 name="query.b.page1.fabo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo014
            
            #add-point:AFTER FIELD fabo014 name="query.a.page1.fabo014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo014
            #add-point:ON ACTION controlp INFIELD fabo014 name="query.c.page1.fabo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo015
            #add-point:BEFORE FIELD fabo015 name="query.b.page1.fabo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo015
            
            #add-point:AFTER FIELD fabo015 name="query.a.page1.fabo015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo015
            #add-point:ON ACTION controlp INFIELD fabo015 name="query.c.page1.fabo015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo016
            #add-point:BEFORE FIELD fabo016 name="query.b.page1.fabo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo016
            
            #add-point:AFTER FIELD fabo016 name="query.a.page1.fabo016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo016
            #add-point:ON ACTION controlp INFIELD fabo016 name="query.c.page1.fabo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo017
            #add-point:BEFORE FIELD fabo017 name="query.b.page1.fabo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo017
            
            #add-point:AFTER FIELD fabo017 name="query.a.page1.fabo017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo017
            #add-point:ON ACTION controlp INFIELD fabo017 name="query.c.page1.fabo017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo049
            #add-point:BEFORE FIELD fabo049 name="query.b.page1.fabo049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo049
            
            #add-point:AFTER FIELD fabo049 name="query.a.page1.fabo049"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo049
            #add-point:ON ACTION controlp INFIELD fabo049 name="query.c.page1.fabo049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo011
            #add-point:BEFORE FIELD fabo011 name="query.b.page1.fabo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo011
            
            #add-point:AFTER FIELD fabo011 name="query.a.page1.fabo011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo011
            #add-point:ON ACTION controlp INFIELD fabo011 name="query.c.page1.fabo011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo018
            #add-point:BEFORE FIELD fabo018 name="query.b.page1.fabo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo018
            
            #add-point:AFTER FIELD fabo018 name="query.a.page1.fabo018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo018
            #add-point:ON ACTION controlp INFIELD fabo018 name="query.c.page1.fabo018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo019
            #add-point:BEFORE FIELD fabo019 name="query.b.page1.fabo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo019
            
            #add-point:AFTER FIELD fabo019 name="query.a.page1.fabo019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo019
            #add-point:ON ACTION controlp INFIELD fabo019 name="query.c.page1.fabo019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo020
            #add-point:BEFORE FIELD fabo020 name="query.b.page1.fabo020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo020
            
            #add-point:AFTER FIELD fabo020 name="query.a.page1.fabo020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo020
            #add-point:ON ACTION controlp INFIELD fabo020 name="query.c.page1.fabo020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo021
            #add-point:BEFORE FIELD fabo021 name="query.b.page1.fabo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo021
            
            #add-point:AFTER FIELD fabo021 name="query.a.page1.fabo021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo021
            #add-point:ON ACTION controlp INFIELD fabo021 name="query.c.page1.fabo021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo022
            #add-point:BEFORE FIELD fabo022 name="query.b.page1.fabo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo022
            
            #add-point:AFTER FIELD fabo022 name="query.a.page1.fabo022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo022
            #add-point:ON ACTION controlp INFIELD fabo022 name="query.c.page1.fabo022"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.fabo024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo024
            #add-point:ON ACTION controlp INFIELD fabo024 name="construct.c.page2.fabo024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo024  #顯示到畫面上
            NEXT FIELD fabo024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo024
            #add-point:BEFORE FIELD fabo024 name="query.b.page2.fabo024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo024
            
            #add-point:AFTER FIELD fabo024 name="query.a.page2.fabo024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo024_desc
            #add-point:BEFORE FIELD fabo024_desc name="query.b.page2.fabo024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo024_desc
            
            #add-point:AFTER FIELD fabo024_desc name="query.a.page2.fabo024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.fabo024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo024_desc
            #add-point:ON ACTION controlp INFIELD fabo024_desc name="query.c.page2.fabo024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo042
            #add-point:BEFORE FIELD fabo042 name="query.b.page2.fabo042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo042
            
            #add-point:AFTER FIELD fabo042 name="query.a.page2.fabo042"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.fabo042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo042
            #add-point:ON ACTION controlp INFIELD fabo042 name="query.c.page2.fabo042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabo031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031
            #add-point:ON ACTION controlp INFIELD fabo031 name="construct.c.page2.fabo031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo031  #顯示到畫面上
            NEXT FIELD fabo031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031
            #add-point:BEFORE FIELD fabo031 name="query.b.page2.fabo031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031
            
            #add-point:AFTER FIELD fabo031 name="query.a.page2.fabo031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031_desc
            #add-point:ON ACTION controlp INFIELD fabo031_desc name="construct.c.page2.fabo031_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo031_desc  #顯示到畫面上
            NEXT FIELD fabo031_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031_desc
            #add-point:BEFORE FIELD fabo031_desc name="query.b.page2.fabo031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031_desc
            
            #add-point:AFTER FIELD fabo031_desc name="query.a.page2.fabo031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032
            #add-point:ON ACTION controlp INFIELD fabo032 name="construct.c.page2.fabo032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo032  #顯示到畫面上
            NEXT FIELD fabo032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032
            #add-point:BEFORE FIELD fabo032 name="query.b.page2.fabo032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032
            
            #add-point:AFTER FIELD fabo032 name="query.a.page2.fabo032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032_desc
            #add-point:ON ACTION controlp INFIELD fabo032_desc name="construct.c.page2.fabo032_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo032_desc  #顯示到畫面上
            NEXT FIELD fabo032_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032_desc
            #add-point:BEFORE FIELD fabo032_desc name="query.b.page2.fabo032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032_desc
            
            #add-point:AFTER FIELD fabo032_desc name="query.a.page2.fabo032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033
            #add-point:ON ACTION controlp INFIELD fabo033 name="construct.c.page2.fabo033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo033  #顯示到畫面上
            NEXT FIELD fabo033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033
            #add-point:BEFORE FIELD fabo033 name="query.b.page2.fabo033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033
            
            #add-point:AFTER FIELD fabo033 name="query.a.page2.fabo033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033_desc
            #add-point:ON ACTION controlp INFIELD fabo033_desc name="construct.c.page2.fabo033_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo033_desc  #顯示到畫面上
            NEXT FIELD fabo033_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033_desc
            #add-point:BEFORE FIELD fabo033_desc name="query.b.page2.fabo033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033_desc
            
            #add-point:AFTER FIELD fabo033_desc name="query.a.page2.fabo033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034
            #add-point:ON ACTION controlp INFIELD fabo034 name="construct.c.page2.fabo034"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo034  #顯示到畫面上
            NEXT FIELD fabo034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034
            #add-point:BEFORE FIELD fabo034 name="query.b.page2.fabo034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034
            
            #add-point:AFTER FIELD fabo034 name="query.a.page2.fabo034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034_desc
            #add-point:ON ACTION controlp INFIELD fabo034_desc name="construct.c.page2.fabo034_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo034_desc  #顯示到畫面上
            NEXT FIELD fabo034_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034_desc
            #add-point:BEFORE FIELD fabo034_desc name="query.b.page2.fabo034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034_desc
            
            #add-point:AFTER FIELD fabo034_desc name="query.a.page2.fabo034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035
            #add-point:ON ACTION controlp INFIELD fabo035 name="construct.c.page2.fabo035"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo035  #顯示到畫面上
            NEXT FIELD fabo035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035
            #add-point:BEFORE FIELD fabo035 name="query.b.page2.fabo035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035
            
            #add-point:AFTER FIELD fabo035 name="query.a.page2.fabo035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035_desc
            #add-point:ON ACTION controlp INFIELD fabo035_desc name="construct.c.page2.fabo035_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo035_desc  #顯示到畫面上
            NEXT FIELD fabo035_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035_desc
            #add-point:BEFORE FIELD fabo035_desc name="query.b.page2.fabo035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035_desc
            
            #add-point:AFTER FIELD fabo035_desc name="query.a.page2.fabo035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036
            #add-point:ON ACTION controlp INFIELD fabo036 name="construct.c.page2.fabo036"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo036  #顯示到畫面上
            NEXT FIELD fabo036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036
            #add-point:BEFORE FIELD fabo036 name="query.b.page2.fabo036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036
            
            #add-point:AFTER FIELD fabo036 name="query.a.page2.fabo036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036_desc
            #add-point:ON ACTION controlp INFIELD fabo036_desc name="construct.c.page2.fabo036_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo036_desc  #顯示到畫面上
            NEXT FIELD fabo036_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036_desc
            #add-point:BEFORE FIELD fabo036_desc name="query.b.page2.fabo036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036_desc
            
            #add-point:AFTER FIELD fabo036_desc name="query.a.page2.fabo036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037
            #add-point:ON ACTION controlp INFIELD fabo037 name="construct.c.page2.fabo037"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo037  #顯示到畫面上
            NEXT FIELD fabo037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037
            #add-point:BEFORE FIELD fabo037 name="query.b.page2.fabo037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037
            
            #add-point:AFTER FIELD fabo037 name="query.a.page2.fabo037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037_desc
            #add-point:ON ACTION controlp INFIELD fabo037_desc name="construct.c.page2.fabo037_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo037_desc  #顯示到畫面上
            NEXT FIELD fabo037_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037_desc
            #add-point:BEFORE FIELD fabo037_desc name="query.b.page2.fabo037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037_desc
            
            #add-point:AFTER FIELD fabo037_desc name="query.a.page2.fabo037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038
            #add-point:ON ACTION controlp INFIELD fabo038 name="construct.c.page2.fabo038"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo038  #顯示到畫面上
            NEXT FIELD fabo038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038
            #add-point:BEFORE FIELD fabo038 name="query.b.page2.fabo038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038
            
            #add-point:AFTER FIELD fabo038 name="query.a.page2.fabo038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038_desc
            #add-point:ON ACTION controlp INFIELD fabo038_desc name="construct.c.page2.fabo038_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo038_desc  #顯示到畫面上
            NEXT FIELD fabo038_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038_desc
            #add-point:BEFORE FIELD fabo038_desc name="query.b.page2.fabo038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038_desc
            
            #add-point:AFTER FIELD fabo038_desc name="query.a.page2.fabo038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039
            #add-point:ON ACTION controlp INFIELD fabo039 name="construct.c.page2.fabo039"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo039  #顯示到畫面上
            NEXT FIELD fabo039                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039
            #add-point:BEFORE FIELD fabo039 name="query.b.page2.fabo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039
            
            #add-point:AFTER FIELD fabo039 name="query.a.page2.fabo039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039_desc
            #add-point:ON ACTION controlp INFIELD fabo039_desc name="construct.c.page2.fabo039_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo039_desc  #顯示到畫面上
            NEXT FIELD fabo039_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039_desc
            #add-point:BEFORE FIELD fabo039_desc name="query.b.page2.fabo039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039_desc
            
            #add-point:AFTER FIELD fabo039_desc name="query.a.page2.fabo039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040
            #add-point:ON ACTION controlp INFIELD fabo040 name="construct.c.page2.fabo040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo040  #顯示到畫面上
            NEXT FIELD fabo040                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040
            #add-point:BEFORE FIELD fabo040 name="query.b.page2.fabo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040
            
            #add-point:AFTER FIELD fabo040 name="query.a.page2.fabo040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabo040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040_desc
            #add-point:ON ACTION controlp INFIELD fabo040_desc name="construct.c.page2.fabo040_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo040_desc  #顯示到畫面上
            NEXT FIELD fabo040_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040_desc
            #add-point:BEFORE FIELD fabo040_desc name="query.b.page2.fabo040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040_desc
            
            #add-point:AFTER FIELD fabo040_desc name="query.a.page2.fabo040_desc"
            
            #END add-point
            
 
 
  
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo108
            #add-point:BEFORE FIELD fabo108 name="query.b.page7.fabo108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo108
            
            #add-point:AFTER FIELD fabo108 name="query.a.page7.fabo108"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo108
            #add-point:ON ACTION controlp INFIELD fabo108 name="query.c.page7.fabo108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo109
            #add-point:BEFORE FIELD fabo109 name="query.b.page7.fabo109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo109
            
            #add-point:AFTER FIELD fabo109 name="query.a.page7.fabo109"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo109
            #add-point:ON ACTION controlp INFIELD fabo109 name="query.c.page7.fabo109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo110
            #add-point:BEFORE FIELD fabo110 name="query.b.page7.fabo110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo110
            
            #add-point:AFTER FIELD fabo110 name="query.a.page7.fabo110"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo110
            #add-point:ON ACTION controlp INFIELD fabo110 name="query.c.page7.fabo110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo157
            #add-point:BEFORE FIELD fabo157 name="query.b.page7.fabo157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo157
            
            #add-point:AFTER FIELD fabo157 name="query.a.page7.fabo157"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo157
            #add-point:ON ACTION controlp INFIELD fabo157 name="query.c.page7.fabo157"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo158
            #add-point:BEFORE FIELD fabo158 name="query.b.page7.fabo158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo158
            
            #add-point:AFTER FIELD fabo158 name="query.a.page7.fabo158"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo158
            #add-point:ON ACTION controlp INFIELD fabo158 name="query.c.page7.fabo158"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo159
            #add-point:BEFORE FIELD fabo159 name="query.b.page7.fabo159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo159
            
            #add-point:AFTER FIELD fabo159 name="query.a.page7.fabo159"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page7.fabo159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo159
            #add-point:ON ACTION controlp INFIELD fabo159 name="query.c.page7.fabo159"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG 
   END DIALOG
 
   #add-point:query段after_construct name="query.after_construct"
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL afat505_01_b_fill(g_wc2)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat505_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL afat505_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat505_01_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE r_xrcd103  LIKE xrcd_t.xrcd103
   DEFINE r_xrcd104  LIKE xrcd_t.xrcd104
   DEFINE r_xrcd105  LIKE xrcd_t.xrcd105
   DEFINE r_xrcd113  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115  LIKE xrcd_t.xrcd115
   DEFINE r_xrcd123  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125  LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135  LIKE xrcd_t.xrcd115
   DEFINE l_ooam003  LIKE ooam_t.ooam003
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_oodbl004 LIKE oodbL_t.oodbl004
   DEFINE l_oodb005  LIKE oodb_t.oodb005
   DEFINE l_oodb006  LIKE oodb_t.oodb006
   DEFINE l_oodb011  LIKE oodb_t.oodb011
   DEFINE l_money    LIKE xrcd_t.xrcd102
   DEFINE l_glab005  LIKE glab_t.glab005
   DEFINE la_param   RECORD
             prog    STRING,
             param   DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_js      STRING
   DEFINE l_faaj033    LIKE faaj_t.faaj033
   DEFINE l_faah018    LIKE faah_t.faah018
   DEFINE l_fabo029   LIKE fabo_t.fabo029
   DEFINE l_faaj026   LIKE faaj_t.faaj026
   DEFINE l_faaj023   LIKE faaj_t.faaj023
   DEFINE l_faaj024   LIKE faaj_t.faaj024
   DEFINE l_fabgcomp  LIKE fabg_t.fabgcomp
   DEFINE l_ooef016   LIKE ooef_t.ooef016
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   #20151202   B
   DEFINE l_sql                  STRING 
   DEFINE l_glaa004              LIKE  glaa_t.glaa004
   #20151202   e
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   LET g_errshow = 1
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_fabo_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo_d[l_ac].fabold IS NOT NULL
               AND g_fabo_d[l_ac].fabodocno IS NOT NULL
               AND g_fabo_d[l_ac].faboseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabo_d_t.* = g_fabo_d[l_ac].*  #BACKUP
               LET g_fabo_d_o.* = g_fabo_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("fabo_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl INTO g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                      g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                      g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                      g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                      g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                      g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabodocno,g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].faboseq, 
                      g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031,g_fabo2_d[l_ac].fabo032, 
                      g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035,g_fabo2_d[l_ac].fabo036, 
                      g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040, 
                      g_fabo7_d[l_ac].fabodocno,g_fabo7_d[l_ac].fabold,g_fabo7_d[l_ac].faboseq,g_fabo7_d[l_ac].fabo107, 
                      g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103, 
                      g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105,g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108, 
                      g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110,g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150, 
                      g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160,g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153, 
                      g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155,g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158, 
                      g_fabo7_d[l_ac].fabo159
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabo_d_t.fabold,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabo_d_mask_o[l_ac].* =  g_fabo_d[l_ac].*
                  CALL afat505_01_fabo_t_mask()
                  LET g_fabo_d_mask_n[l_ac].* =  g_fabo_d[l_ac].*
                  
                  CALL afat505_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            #20141113 add--str--by chenying 
            #预设调入/调出所有组织默认税别，币别
            IF cl_null(g_fabo_d[l_ac].fabo010) AND l_ac > 0 THEN 
               SELECT ooef016 INTO g_fabo_d[l_ac].fabo010 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo044 
            END IF
            
            IF cl_null(g_fabo_d[l_ac].fabo009) AND l_ac > 0 THEN
               LET l_ooef019 = NULL            
               SELECT ooef019 INTO l_ooef019 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo044 
               SELECT oodb002 INTO g_fabo_d[l_ac].fabo009 FROM oodb_t
                WHERE oodbent = g_enterprise AND oodb001 = l_ooef019               
            END IF            
            #20141113 add--end--             
            
            LET g_fabo_d[l_ac].fabo008 = g_faaj016 / g_fabo006 * g_fabo007
            LET g_fabo_d[l_ac].fabo022 = g_faaj028 / g_fabo006 * g_fabo007
            
            SELECT faah018 INTO l_faah018 FROM faah_t
                WHERE faahent=g_enterprise AND faah001=g_fabo003
                  AND faah003=g_fabo001 AND faah004=g_fabo002
                  
               SELECT faaj033 INTO l_faaj033 FROM faaj_t
                WHERE faajent=g_enterprise AND faajld=g_fabgld
                  AND faaj001=g_fabo001 AND faaj002=g_fabo002
                  AND faaj037=g_fabo003
               
               IF cl_null(l_faaj033) THEN LET l_faaj033=0 END IF   #已出售數量
               IF cl_null(l_faah018) THEN LET l_faah018=0 END IF   #總數量
               
               #數量=總數量 - 已出售數量
               LET g_faah018 =l_faah018-l_faaj033
               CALL afat505_01_get_amt(g_faah018,g_fabo007)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo_d_t.* TO NULL
            INITIALIZE g_fabo_d_o.* TO NULL
            INITIALIZE g_fabo_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_fabo_d_t.* = g_fabo_d[l_ac].*     #新輸入資料
            LET g_fabo_d_o.* = g_fabo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo_d[g_fabo_d.getLength()].fabold = NULL
               LET g_fabo_d[g_fabo_d.getLength()].fabodocno = NULL
               LET g_fabo_d[g_fabo_d.getLength()].faboseq = NULL
 
            END IF
            
 
 
 
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fabo_t 
             WHERE faboent = g_enterprise AND fabold = g_fabo_d[l_ac].fabold
                                       AND fabodocno = g_fabo_d[l_ac].fabodocno
                                       AND faboseq = g_fabo_d[l_ac].faboseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo_d[g_detail_idx].fabold
               LET gs_keys[2] = g_fabo_d[g_detail_idx].fabodocno
               LET gs_keys[3] = g_fabo_d[g_detail_idx].faboseq
               CALL afat505_01_insert_b('fabo_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabo_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (fabold = '", g_fabo_d[l_ac].fabold, "' "
                                  ," AND fabodocno = '", g_fabo_d[l_ac].fabodocno, "' "
                                  ," AND faboseq = '", g_fabo_d[l_ac].faboseq, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
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
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point   
               
               DELETE FROM fabo_t
                WHERE faboent = g_enterprise AND 
                      fabold = g_fabo_d_t.fabold
                      AND fabodocno = g_fabo_d_t.fabodocno
                      AND faboseq = g_fabo_d_t.faboseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL afat505_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fabo_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afat505_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_fabo_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo_d_t.fabold
               LET gs_keys[2] = g_fabo_d_t.fabodocno
               LET gs_keys[3] = g_fabo_d_t.faboseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL afat505_01_delete_b('fabo_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabodocno
            #add-point:BEFORE FIELD fabodocno name="input.b.page1.fabodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabodocno
            
            #add-point:AFTER FIELD fabodocno name="input.a.page1.fabodocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabo_d[g_detail_idx].fabold IS NOT NULL AND g_fabo_d[g_detail_idx].fabodocno IS NOT NULL AND g_fabo_d[g_detail_idx].faboseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabo_d[g_detail_idx].fabold != g_fabo_d_t.fabold OR g_fabo_d[g_detail_idx].fabodocno != g_fabo_d_t.fabodocno OR g_fabo_d[g_detail_idx].faboseq != g_fabo_d_t.faboseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_d[g_detail_idx].fabold ||"' AND "|| "fabodocno = '"||g_fabo_d[g_detail_idx].fabodocno ||"' AND "|| "faboseq = '"||g_fabo_d[g_detail_idx].faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabodocno
            #add-point:ON CHANGE fabodocno name="input.g.page1.fabodocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabold
            #add-point:BEFORE FIELD fabold name="input.b.page1.fabold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabold
            
            #add-point:AFTER FIELD fabold name="input.a.page1.fabold"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabo_d[g_detail_idx].fabold IS NOT NULL AND g_fabo_d[g_detail_idx].fabodocno IS NOT NULL AND g_fabo_d[g_detail_idx].faboseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabo_d[g_detail_idx].fabold != g_fabo_d_t.fabold OR g_fabo_d[g_detail_idx].fabodocno != g_fabo_d_t.fabodocno OR g_fabo_d[g_detail_idx].faboseq != g_fabo_d_t.faboseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_d[g_detail_idx].fabold ||"' AND "|| "fabodocno = '"||g_fabo_d[g_detail_idx].fabodocno ||"' AND "|| "faboseq = '"||g_fabo_d[g_detail_idx].faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabold
            #add-point:ON CHANGE fabold name="input.g.page1.fabold"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="input.b.page1.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="input.a.page1.faboseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabo_d[g_detail_idx].fabold IS NOT NULL AND g_fabo_d[g_detail_idx].fabodocno IS NOT NULL AND g_fabo_d[g_detail_idx].faboseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabo_d[g_detail_idx].fabold != g_fabo_d_t.fabold OR g_fabo_d[g_detail_idx].fabodocno != g_fabo_d_t.fabodocno OR g_fabo_d[g_detail_idx].faboseq != g_fabo_d_t.faboseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabo_d[g_detail_idx].fabold ||"' AND "|| "fabodocno = '"||g_fabo_d[g_detail_idx].fabodocno ||"' AND "|| "faboseq = '"||g_fabo_d[g_detail_idx].faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faboseq
            #add-point:ON CHANGE faboseq name="input.g.page1.faboseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo008
            #add-point:BEFORE FIELD fabo008 name="input.b.page1.fabo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo008
            
            #add-point:AFTER FIELD fabo008 name="input.a.page1.fabo008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo008
            #add-point:ON CHANGE fabo008 name="input.g.page1.fabo008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo009
            
            #add-point:AFTER FIELD fabo009 name="input.a.page1.fabo009"
            IF NOT cl_null(g_fabo_d[l_ac].fabo009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_fabo_d[l_ac].fabo009
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_tax_chk(g_glaacomp,g_fabo_d[l_ac].fabo009)
                  RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
                  
                  IF g_para_data = '1' THEN  #成本
                     LET l_money = g_fabo_d[l_ac].fabo008
                  ELSE   #未折減額
                     LET l_money = g_fabo_d[l_ac].fabo022
                  END IF
                  
                  IF l_oodb005 = 'Y' THEN 
                     LET g_fabo_d[l_ac].fabo014 = l_money
                  ELSE
                     LET g_fabo_d[l_ac].fabo012 = l_money
                  END IF
                  CALL afat505_01_fabo009_set_entry(l_oodb005)
                  
                  #20141114 add--str-- by chenying
                                              #日期;            來源幣別      目的幣別; 匯類類型
                  CALL afat505_01_get_exrate(g_fabgdocdt,g_fabo_d[l_ac].fabo010,g_glaa001,g_glaa025) 
                  RETURNING g_fabo_d[l_ac].fabo011

                  #本位幣二匯率
                  IF g_glaa015 = 'Y' THEN
                     IF g_glaa017 = '1' THEN 
                        LET l_ooam003 = g_fabo_d[l_ac].fabo010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                        
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa016,g_glaa018) 
                     RETURNING g_fabo7_d[l_ac].fabo102
                  ELSE
                     LET g_fabo7_d[l_ac].fabo102 = 0
                  END IF
                     
                  #本位幣三匯率
                  IF g_glaa019 = 'Y' THEN  
                     IF g_glaa021 = '1' THEN 
                        LET l_ooam003 = g_fabo_d[l_ac].fabo010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                     
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa020,g_glaa022) 
                     RETURNING g_fabo7_d[l_ac].fabo151                               
                  ELSE
                     LET g_fabo7_d[l_ac].fabo151 = 0
                  END IF 
                  #20141114 add--end--                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo009 = g_fabo_d_t.fabo009
                  NEXT FIELD CURRENT
               END IF

            END IF 
            
            IF NOT cl_null(g_fabo_d[l_ac].fabo009) AND NOT cl_null(g_fabo_d[l_ac].fabo010) THEN
               IF NOT cl_null(l_money) AND NOT cl_null(g_fabo007) THEN 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo009 <> g_fabo_d_t.fabo009 OR cl_null(g_fabo_d_t.fabo009))) THEN           
#                     IF l_oodb005 = 'Y' THEN 
#                        CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
#                                       g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo009,
#                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
#                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
#                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135     
#                     ELSE
#                        CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
#                                       g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo009,
#                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
#                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
#                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135     
#                     END IF

                     IF cl_null(g_fabo_d[l_ac].fabo006) THEN LET g_fabo_d[l_ac].fabo006 = 0 END IF
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
                                       g_fabo_d[l_ac].fabo006*g_fabo007,g_fabo_d[l_ac].fabo009,
                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135    
                     
                     #抓取交易稅明細檔的科目
                     LET l_glab005 = ''
                     SELECT glab005 INTO l_glab005 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_fabgld
                        AND glab001 = '14' 
                        AND glab002 = '2'   #-销項
                        AND glab003 =  g_fabo_d[l_ac].fabo009  #--稅別
                   
                     IF cl_null(l_glab005) THEN   #取不到會科時表示以常用會科設定 (agli160) 
                        SELECT glab005 INTO l_glab005 FROM glab_t 
                         WHERE glabent = g_enterprise
                           and glabld  = g_fabgld
                           AND glab001 = '12' 
                           AND glab002 = '9711' 
                           AND glab003 = '9711_91' 
                     END IF 
                      
                     LET g_fabo5_d[l_ac].xrcd009 = l_glab005
                     
                     UPDATE xrcd_t SET xrcd009 = g_fabo5_d[l_ac].xrcd009
                      WHERE xrcdent   = g_enterprise
                        AND xrcdld    = g_fabgld
                        AND xrcddocno = g_fabgdocno
                        AND xrcdseq   = g_faboseq
                        AND xrcdseq2  = 1

                     LET g_fabo_d[l_ac].fabo012 = r_xrcd103
                     LET g_fabo_d[l_ac].fabo013 = r_xrcd104
                     LET g_fabo_d[l_ac].fabo014 = r_xrcd105
                     LET g_fabo_d[l_ac].fabo015 = r_xrcd113
                     LET g_fabo_d[l_ac].fabo016 = r_xrcd114
                     LET g_fabo_d[l_ac].fabo017 = r_xrcd115
                     LET g_fabo7_d[l_ac].fabo103 = r_xrcd123
                     LET g_fabo7_d[l_ac].fabo104 = r_xrcd124
                     LET g_fabo7_d[l_ac].fabo105 = r_xrcd125
                     LET g_fabo7_d[l_ac].fabo152 = r_xrcd133
                     LET g_fabo7_d[l_ac].fabo153 = r_xrcd134
                     LET g_fabo7_d[l_ac].fabo154 = r_xrcd135
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld   #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld AND fabgent = g_enterprise  #160905-00007#2 add
                  END IF
                  LET g_fabo_d[l_ac].fabo012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo012,2)
                  LET g_fabo_d[l_ac].fabo013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo013,2)
                  LET g_fabo_d[l_ac].fabo014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo014,2)
                  LET g_fabo_d[l_ac].fabo015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo015,2)
                  LET g_fabo_d[l_ac].fabo016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo016,2)
                  LET g_fabo_d[l_ac].fabo017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo017,2) 
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo103) THEN
                     LET g_fabo7_d[l_ac].fabo103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo103,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo104) THEN
                     LET g_fabo7_d[l_ac].fabo104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo104,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo105) THEN               
                     LET g_fabo7_d[l_ac].fabo105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo105,2) 
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo152,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo153,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo154) THEN
                     LET g_fabo7_d[l_ac].fabo154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo154,2)
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo009
            #add-point:BEFORE FIELD fabo009 name="input.b.page1.fabo009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo009
            #add-point:ON CHANGE fabo009 name="input.g.page1.fabo009"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo010
            
            #add-point:AFTER FIELD fabo010 name="input.a.page1.fabo010"
            IF NOT cl_null(g_fabo_d[l_ac].fabo010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo010

               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                                              #日期;            來源幣別      目的幣別; 匯類類型
                  CALL afat505_01_get_exrate(g_fabgdocdt,g_fabo_d[l_ac].fabo010,g_glaa001,g_glaa025) 
                  RETURNING g_fabo_d[l_ac].fabo011

                  #本位幣二匯率
                  IF g_glaa015 = 'Y' THEN
                     IF g_glaa017 = '1' THEN 
                        LET l_ooam003 = g_fabo_d[l_ac].fabo010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                        
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa016,g_glaa018) 
                     RETURNING g_fabo7_d[l_ac].fabo102
                  ELSE
                     LET g_fabo7_d[l_ac].fabo102 = 0
                  END IF
                     
                  #本位幣三匯率
                  IF g_glaa019 = 'Y' THEN  
                     IF g_glaa021 = '1' THEN 
                        LET l_ooam003 = g_fabo_d[l_ac].fabo010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                     
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa020,g_glaa022) 
                     RETURNING g_fabo7_d[l_ac].fabo151                               
                  ELSE
                     LET g_fabo7_d[l_ac].fabo151 = 0
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo010 = g_fabo_d_t.fabo010
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            IF NOT cl_null(g_fabo_d[l_ac].fabo009) AND NOT cl_null(g_fabo_d[l_ac].fabo010) THEN
               IF NOT cl_null(l_money) AND NOT cl_null(g_fabo007) THEN 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo010 <> g_fabo_d_t.fabo010 OR cl_null(g_fabo_d_t.fabo010))) THEN           
#                     IF l_oodb005 = 'Y' THEN 
#                        CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
#                                       g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo009,
#                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
#                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
#                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135  
#                     ELSE
#                        CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
#                                       g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo009,
#                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
#                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
#                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
#                     END IF

                     IF cl_null(g_fabo_d[l_ac].fabo006) THEN LET g_fabo_d[l_ac].fabo006 = 0 END IF 
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
                                       g_fabo_d[l_ac].fabo006*g_fabo007,g_fabo_d[l_ac].fabo009,
                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135    

                     LET g_fabo_d[l_ac].fabo012 = r_xrcd103
                     LET g_fabo_d[l_ac].fabo013 = r_xrcd104
                     LET g_fabo_d[l_ac].fabo014 = r_xrcd105
                     LET g_fabo_d[l_ac].fabo015 = r_xrcd113
                     LET g_fabo_d[l_ac].fabo016 = r_xrcd114
                     LET g_fabo_d[l_ac].fabo017 = r_xrcd115
                     LET g_fabo7_d[l_ac].fabo103 = r_xrcd123
                     LET g_fabo7_d[l_ac].fabo104 = r_xrcd124
                     LET g_fabo7_d[l_ac].fabo105 = r_xrcd125
                     LET g_fabo7_d[l_ac].fabo152 = r_xrcd133
                     LET g_fabo7_d[l_ac].fabo153 = r_xrcd134
                     LET g_fabo7_d[l_ac].fabo154 = r_xrcd135
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp  FROM glaa_t WHERE glaald = g_fabgld   #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp  FROM glaa_t WHERE glaald = g_fabgld   AND glaaent = g_enterprise  #160905-00007#2 add
                  END IF
                  LET g_fabo_d[l_ac].fabo012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo012,2)
                  LET g_fabo_d[l_ac].fabo013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo013,2)
                  LET g_fabo_d[l_ac].fabo014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo014,2)
                  LET g_fabo_d[l_ac].fabo015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo015,2)
                  LET g_fabo_d[l_ac].fabo016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo016,2)
                  LET g_fabo_d[l_ac].fabo017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo017,2) 
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo103) THEN
                     LET g_fabo7_d[l_ac].fabo103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo103,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo104) THEN
                     LET g_fabo7_d[l_ac].fabo104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo104,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo105) THEN               
                     LET g_fabo7_d[l_ac].fabo105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo105,2) 
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo152,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo153,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo154) THEN
                     LET g_fabo7_d[l_ac].fabo154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo154,2)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo010
            #add-point:BEFORE FIELD fabo010 name="input.b.page1.fabo010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo010
            #add-point:ON CHANGE fabo010 name="input.g.page1.fabo010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo006
            #add-point:BEFORE FIELD fabo006 name="input.b.page1.fabo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo006
            
            #add-point:AFTER FIELD fabo006 name="input.a.page1.fabo006"
            IF NOT cl_null(g_fabo_d[l_ac].fabo006) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo006 <> g_fabo_d_t.fabo006 OR cl_null(g_fabo_d_t.fabo006))) THEN
                  IF NOT cl_null(g_fabo_d[l_ac].fabo009) THEN 
                     IF cl_null(g_fabo_d[l_ac].fabo006) THEN LET g_fabo_d[l_ac].fabo006 = 0 END IF     
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
                                       g_fabo_d[l_ac].fabo006*g_fabo007,g_fabo_d[l_ac].fabo009,
                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                  
                     LET g_fabo_d[l_ac].fabo012 = r_xrcd103
                     LET g_fabo_d[l_ac].fabo013 = r_xrcd104
                     LET g_fabo_d[l_ac].fabo014 = r_xrcd105
                     LET g_fabo_d[l_ac].fabo015 = r_xrcd113
                     LET g_fabo_d[l_ac].fabo016 = r_xrcd114
                     LET g_fabo_d[l_ac].fabo017 = r_xrcd115
                     LET g_fabo7_d[l_ac].fabo103 = r_xrcd123
                     LET g_fabo7_d[l_ac].fabo104 = r_xrcd124
                     LET g_fabo7_d[l_ac].fabo105 = r_xrcd125
                     LET g_fabo7_d[l_ac].fabo152 = r_xrcd133
                     LET g_fabo7_d[l_ac].fabo153 = r_xrcd134
                     LET g_fabo7_d[l_ac].fabo154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld AND glaaent = g_enterprise  #160905-00007#2 add
                  END IF
                  LET g_fabo_d[l_ac].fabo012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo012,2)
                  LET g_fabo_d[l_ac].fabo013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo013,2)
                  LET g_fabo_d[l_ac].fabo014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo014,2)
                  LET g_fabo_d[l_ac].fabo015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo015,2)
                  LET g_fabo_d[l_ac].fabo016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo016,2)
                  LET g_fabo_d[l_ac].fabo017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo017,2) 
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo103) THEN
                     LET g_fabo7_d[l_ac].fabo103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo103,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo104) THEN
                     LET g_fabo7_d[l_ac].fabo104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo104,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo105) THEN               
                     LET g_fabo7_d[l_ac].fabo105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo105,2) 
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo152,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo153,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo154) THEN
                     LET g_fabo7_d[l_ac].fabo154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo154,2)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo006
            #add-point:ON CHANGE fabo006 name="input.g.page1.fabo006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo012
            #add-point:BEFORE FIELD fabo012 name="input.b.page1.fabo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo012
            
            #add-point:AFTER FIELD fabo012 name="input.a.page1.fabo012"
            IF NOT cl_null(g_fabo_d[l_ac].fabo012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo012 <> g_fabo_d_t.fabo012 OR cl_null(g_fabo_d_t.fabo012))) THEN
                  IF NOT cl_null(g_fabo_d[l_ac].fabo009) THEN          
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
                                       g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo009,
                                       g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                  
                     LET g_fabo_d[l_ac].fabo012 = r_xrcd103
                     LET g_fabo_d[l_ac].fabo013 = r_xrcd104
                     LET g_fabo_d[l_ac].fabo014 = r_xrcd105
                     LET g_fabo_d[l_ac].fabo015 = r_xrcd113
                     LET g_fabo_d[l_ac].fabo016 = r_xrcd114
                     LET g_fabo_d[l_ac].fabo017 = r_xrcd115
                     LET g_fabo7_d[l_ac].fabo103 = r_xrcd123
                     LET g_fabo7_d[l_ac].fabo104 = r_xrcd124
                     LET g_fabo7_d[l_ac].fabo105 = r_xrcd125
                     LET g_fabo7_d[l_ac].fabo152 = r_xrcd133
                     LET g_fabo7_d[l_ac].fabo153 = r_xrcd134
                     LET g_fabo7_d[l_ac].fabo154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld   #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  AND glaaent = g_enterprise  #160905-00007#2 add
                  END IF
                  LET g_fabo_d[l_ac].fabo012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo012,2)
                  LET g_fabo_d[l_ac].fabo013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo013,2)
                  LET g_fabo_d[l_ac].fabo014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo014,2)
                  LET g_fabo_d[l_ac].fabo015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo015,2)
                  LET g_fabo_d[l_ac].fabo016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo016,2)
                  LET g_fabo_d[l_ac].fabo017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo017,2) 
                 IF NOT cl_null(g_fabo7_d[l_ac].fabo103) THEN
                     LET g_fabo7_d[l_ac].fabo103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo103,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo104) THEN
                     LET g_fabo7_d[l_ac].fabo104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo104,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo105) THEN               
                     LET g_fabo7_d[l_ac].fabo105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo105,2) 
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo152,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo153,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo154) THEN
                     LET g_fabo7_d[l_ac].fabo154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo154,2)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo012
            #add-point:ON CHANGE fabo012 name="input.g.page1.fabo012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo013
            #add-point:BEFORE FIELD fabo013 name="input.b.page1.fabo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo013
            
            #add-point:AFTER FIELD fabo013 name="input.a.page1.fabo013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo013
            #add-point:ON CHANGE fabo013 name="input.g.page1.fabo013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo014
            #add-point:BEFORE FIELD fabo014 name="input.b.page1.fabo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo014
            
            #add-point:AFTER FIELD fabo014 name="input.a.page1.fabo014"
            IF NOT cl_null(g_fabo_d[l_ac].fabo014) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo014 <> g_fabo_d_t.fabo014 OR cl_null(g_fabo_d_t.fabo014))) THEN
                 #CALL afat505_01_amt_chk()
                  IF NOT cl_null(g_fabo_d[l_ac].fabo009) THEN          
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,1,g_glaacomp,
                                    g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo009,
                                    g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
                          RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                  
                     LET g_fabo_d[l_ac].fabo012 = r_xrcd103
                     LET g_fabo_d[l_ac].fabo013 = r_xrcd104
                     LET g_fabo_d[l_ac].fabo014 = r_xrcd105
                     LET g_fabo_d[l_ac].fabo015 = r_xrcd113
                     LET g_fabo_d[l_ac].fabo016 = r_xrcd114
                     LET g_fabo_d[l_ac].fabo017 = r_xrcd115
                     LET g_fabo7_d[l_ac].fabo103 = r_xrcd123
                     LET g_fabo7_d[l_ac].fabo104 = r_xrcd124
                     LET g_fabo7_d[l_ac].fabo105 = r_xrcd125
                     LET g_fabo7_d[l_ac].fabo152 = r_xrcd133
                     LET g_fabo7_d[l_ac].fabo153 = r_xrcd134
                     LET g_fabo7_d[l_ac].fabo154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  AND glaaent = g_enterprise  #160905-00007#2 add
                     
                  END IF
                  LET g_fabo_d[l_ac].fabo012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo012,2)
                  LET g_fabo_d[l_ac].fabo013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo013,2)
                  LET g_fabo_d[l_ac].fabo014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo014,2)
                  LET g_fabo_d[l_ac].fabo015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo015,2)
                  LET g_fabo_d[l_ac].fabo016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo016,2)
                  LET g_fabo_d[l_ac].fabo017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo_d[l_ac].fabo017,2) 
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo103) THEN
                     LET g_fabo7_d[l_ac].fabo103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo103,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo104) THEN
                     LET g_fabo7_d[l_ac].fabo104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo104,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo105) THEN               
                     LET g_fabo7_d[l_ac].fabo105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo105,2) 
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo152,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo153) THEN
                     LET g_fabo7_d[l_ac].fabo153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo153,2)
                  END IF
                  IF NOT cl_null(g_fabo7_d[l_ac].fabo154) THEN
                     LET g_fabo7_d[l_ac].fabo154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo7_d[l_ac].fabo154,2)
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo014
            #add-point:ON CHANGE fabo014 name="input.g.page1.fabo014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo015
            #add-point:BEFORE FIELD fabo015 name="input.b.page1.fabo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo015
            
            #add-point:AFTER FIELD fabo015 name="input.a.page1.fabo015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo015
            #add-point:ON CHANGE fabo015 name="input.g.page1.fabo015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo016
            #add-point:BEFORE FIELD fabo016 name="input.b.page1.fabo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo016
            
            #add-point:AFTER FIELD fabo016 name="input.a.page1.fabo016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo016
            #add-point:ON CHANGE fabo016 name="input.g.page1.fabo016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo017
            #add-point:BEFORE FIELD fabo017 name="input.b.page1.fabo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo017
            
            #add-point:AFTER FIELD fabo017 name="input.a.page1.fabo017"
           #CALL afat505_01_amt_chk()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo017
            #add-point:ON CHANGE fabo017 name="input.g.page1.fabo017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo049
            #add-point:BEFORE FIELD fabo049 name="input.b.page1.fabo049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo049
            
            #add-point:AFTER FIELD fabo049 name="input.a.page1.fabo049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo049
            #add-point:ON CHANGE fabo049 name="input.g.page1.fabo049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo011
            #add-point:BEFORE FIELD fabo011 name="input.b.page1.fabo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo011
            
            #add-point:AFTER FIELD fabo011 name="input.a.page1.fabo011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo011
            #add-point:ON CHANGE fabo011 name="input.g.page1.fabo011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo018
            #add-point:BEFORE FIELD fabo018 name="input.b.page1.fabo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo018
            
            #add-point:AFTER FIELD fabo018 name="input.a.page1.fabo018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo018
            #add-point:ON CHANGE fabo018 name="input.g.page1.fabo018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo019
            #add-point:BEFORE FIELD fabo019 name="input.b.page1.fabo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo019
            
            #add-point:AFTER FIELD fabo019 name="input.a.page1.fabo019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo019
            #add-point:ON CHANGE fabo019 name="input.g.page1.fabo019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo020
            #add-point:BEFORE FIELD fabo020 name="input.b.page1.fabo020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo020
            
            #add-point:AFTER FIELD fabo020 name="input.a.page1.fabo020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo020
            #add-point:ON CHANGE fabo020 name="input.g.page1.fabo020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo021
            #add-point:BEFORE FIELD fabo021 name="input.b.page1.fabo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo021
            
            #add-point:AFTER FIELD fabo021 name="input.a.page1.fabo021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo021
            #add-point:ON CHANGE fabo021 name="input.g.page1.fabo021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo022
            #add-point:BEFORE FIELD fabo022 name="input.b.page1.fabo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo022
            
            #add-point:AFTER FIELD fabo022 name="input.a.page1.fabo022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo022
            #add-point:ON CHANGE fabo022 name="input.g.page1.fabo022"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fabodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabodocno
            #add-point:ON ACTION controlp INFIELD fabodocno name="input.c.page1.fabodocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabold
            #add-point:ON ACTION controlp INFIELD fabold name="input.c.page1.fabold"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="input.c.page1.faboseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo008
            #add-point:ON ACTION controlp INFIELD fabo008 name="input.c.page1.fabo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo009
            #add-point:ON ACTION controlp INFIELD fabo009 name="input.c.page1.fabo009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo009             #給予default值
            LET g_qryparam.where = " oodb004 = '1'"
            #給予arg
            LET g_qryparam.arg1 = g_ooef019

            
            CALL q_oodb002_5()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo009 = g_qryparam.return1              

            DISPLAY g_fabo_d[l_ac].fabo009 TO fabo009              #

            NEXT FIELD fabo009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo010
            #add-point:ON ACTION controlp INFIELD fabo010 name="input.c.page1.fabo010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo010 = g_qryparam.return1              

            DISPLAY g_fabo_d[l_ac].fabo010 TO fabo010              #

            NEXT FIELD fabo010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo006
            #add-point:ON ACTION controlp INFIELD fabo006 name="input.c.page1.fabo006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo012
            #add-point:ON ACTION controlp INFIELD fabo012 name="input.c.page1.fabo012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo013
            #add-point:ON ACTION controlp INFIELD fabo013 name="input.c.page1.fabo013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo014
            #add-point:ON ACTION controlp INFIELD fabo014 name="input.c.page1.fabo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo015
            #add-point:ON ACTION controlp INFIELD fabo015 name="input.c.page1.fabo015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo016
            #add-point:ON ACTION controlp INFIELD fabo016 name="input.c.page1.fabo016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo017
            #add-point:ON ACTION controlp INFIELD fabo017 name="input.c.page1.fabo017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo049
            #add-point:ON ACTION controlp INFIELD fabo049 name="input.c.page1.fabo049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo011
            #add-point:ON ACTION controlp INFIELD fabo011 name="input.c.page1.fabo011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo018
            #add-point:ON ACTION controlp INFIELD fabo018 name="input.c.page1.fabo018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo019
            #add-point:ON ACTION controlp INFIELD fabo019 name="input.c.page1.fabo019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo020
            #add-point:ON ACTION controlp INFIELD fabo020 name="input.c.page1.fabo020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo021
            #add-point:ON ACTION controlp INFIELD fabo021 name="input.c.page1.fabo021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo022
            #add-point:ON ACTION controlp INFIELD fabo022 name="input.c.page1.fabo022"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE afat505_01_bcl
               LET INT_FLAG = 0
               LET g_fabo_d[l_ac].* = g_fabo_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabo_d[l_ac].fabold 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo_d[l_ac].* = g_fabo_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               SELECT faah018 INTO l_faah018 FROM faah_t
                WHERE faahent=g_enterprise AND faah001=g_fabo003
                  AND faah003=g_fabo001 AND faah004=g_fabo002
                  
               SELECT faaj033 INTO l_faaj033 FROM faaj_t
                WHERE faajent=g_enterprise AND faajld=g_fabgld
                  AND faaj001=g_fabo001 AND faaj002=g_fabo002
                  AND faaj037=g_fabo003
               
               IF cl_null(l_faaj033) THEN LET l_faaj033=0 END IF   #已出售數量
               IF cl_null(l_faah018) THEN LET l_faah018=0 END IF   #總數量
               
               #數量=總數量 - 已出售數量
               LET g_faah018 =l_faah018-l_faaj033
               CALL afat505_01_get_amt(g_faah018,g_fabo007)
               #end add-point
               
               #將遮罩欄位還原
               CALL afat505_01_fabo_t_mask_restore('restore_mask_o')
 
               UPDATE fabo_t SET (fabodocno,fabold,faboseq,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013, 
                   fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022, 
                   fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039, 
                   fabo040,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105,fabo106,fabo108,fabo109, 
                   fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155,fabo157,fabo158, 
                   fabo159) = (g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                   g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                   g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                   g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                   g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                   g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031, 
                   g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035, 
                   g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039, 
                   g_fabo2_d[l_ac].fabo040,g_fabo7_d[l_ac].fabo107,g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102, 
                   g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103,g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105, 
                   g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108,g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110, 
                   g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150,g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160, 
                   g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153,g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155, 
                   g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158,g_fabo7_d[l_ac].fabo159)
                WHERE faboent = g_enterprise AND
                  fabold = g_fabo_d_t.fabold #項次   
                  AND fabodocno = g_fabo_d_t.fabodocno  
                  AND faboseq = g_fabo_d_t.faboseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               #產生出售單
               CALL afat505_01_fabo_4_ins()
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo_d[g_detail_idx].fabold
               LET gs_keys_bak[1] = g_fabo_d_t.fabold
               LET gs_keys[2] = g_fabo_d[g_detail_idx].fabodocno
               LET gs_keys_bak[2] = g_fabo_d_t.fabodocno
               LET gs_keys[3] = g_fabo_d[g_detail_idx].faboseq
               LET gs_keys_bak[3] = g_fabo_d_t.faboseq
               CALL afat505_01_update_b('fabo_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fabo_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat505_01_fabo_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afat505_01_unlock_b("fabo_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo_d[l_ac].* = g_fabo_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo_d[li_reproduce_target].fabold = NULL
               LET g_fabo_d[li_reproduce_target].fabodocno = NULL
               LET g_fabo_d[li_reproduce_target].faboseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabo_d.getLength()+1
            END IF
            
      END INPUT
      
      INPUT ARRAY g_fabo2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabold
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo2_d[l_ac].* TO NULL 
            INITIALIZE g_fabo2_d_t.* TO NULL
            INITIALIZE g_fabo2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.before_bak"
            
            #end add-point
            LET g_fabo2_d_t.* = g_fabo2_d[l_ac].*     #新輸入資料
            LET g_fabo2_d_o.* = g_fabo2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo2_d[li_reproduce_target].fabold = NULL
               LET g_fabo2_d[li_reproduce_target].fabodocno = NULL
               LET g_fabo2_d[li_reproduce_target].faboseq = NULL
            END IF
            
 
 
 
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body2.before_insert"
           
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo2_d[l_ac].fabold IS NOT NULL
               AND g_fabo2_d[l_ac].fabodocno IS NOT NULL
               AND g_fabo2_d[l_ac].faboseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo2_d_t.* = g_fabo2_d[l_ac].*  #BACKUP
               LET g_fabo2_d_o.* = g_fabo2_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("fabo_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl INTO g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                      g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                      g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                      g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                      g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                      g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabodocno,g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].faboseq, 
                      g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031,g_fabo2_d[l_ac].fabo032, 
                      g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035,g_fabo2_d[l_ac].fabo036, 
                      g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040, 
                      g_fabo7_d[l_ac].fabodocno,g_fabo7_d[l_ac].fabold,g_fabo7_d[l_ac].faboseq,g_fabo7_d[l_ac].fabo107, 
                      g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103, 
                      g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105,g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108, 
                      g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110,g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150, 
                      g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160,g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153, 
                      g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155,g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158, 
                      g_fabo7_d[l_ac].fabo159
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH afat505_01_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabo2_d_mask_o[l_ac].* =  g_fabo2_d[l_ac].*
                  CALL afat505_01_fabo_t_mask()
                  LET g_fabo2_d_mask_n[l_ac].* =  g_fabo2_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            IF cl_null(g_fabo2_d[l_ac].fabo024) AND l_ac > 0 THEN 
               CALL afat505_01_set_fabo024(g_fabgdocno,g_fabgld,g_fabo_d[l_ac].faboseq)  
            END IF 

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point 
               
               DELETE FROM fabo_t
                WHERE faboent = g_enterprise AND
                  fabold = g_fabo2_d_t.fabold
                  AND fabodocno = g_fabo2_d_t.fabodocno
                  AND faboseq = g_fabo2_d_t.faboseq
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL afat505_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fabo2_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afat505_01_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"
               
               #end add-point
               LET l_count = g_fabo_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo2_d_t.fabold
               LET gs_keys[2] = g_fabo2_d_t.fabodocno
               LET gs_keys[3] = g_fabo2_d_t.faboseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"
               
               #end add-point
                              CALL afat505_01_delete_b('fabo_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body2.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fabo_t 
             WHERE faboent = g_enterprise AND
                   fabold = g_fabo2_d[l_ac].fabold
                   AND fabodocno = g_fabo2_d[l_ac].fabodocno
                   AND faboseq = g_fabo2_d[l_ac].faboseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo2_d[g_detail_idx].fabold
               LET gs_keys[2] = g_fabo2_d[g_detail_idx].fabodocno
               LET gs_keys[3] = g_fabo2_d[g_detail_idx].faboseq
               CALL afat505_01_insert_b('fabo_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabo_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (fabold = '", g_fabo2_d[l_ac].fabold, "' "
                                  ," AND fabodocno = '", g_fabo2_d[l_ac].fabodocno, "' "
                                  ," AND faboseq = '", g_fabo2_d[l_ac].faboseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo2_d[l_ac].* = g_fabo2_d_t.*
               CLOSE afat505_01_bcl
               #add-point:單身page2取消後 name="input.body2.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo2_d[l_ac].* = g_fabo2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat505_01_fabo_t_mask_restore('restore_mask_o')
               
               UPDATE fabo_t SET (fabodocno,fabold,faboseq,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013, 
                   fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022, 
                   fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039, 
                   fabo040,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105,fabo106,fabo108,fabo109, 
                   fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155,fabo157,fabo158, 
                   fabo159) = (g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                   g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                   g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                   g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                   g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                   g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031, 
                   g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035, 
                   g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039, 
                   g_fabo2_d[l_ac].fabo040,g_fabo7_d[l_ac].fabo107,g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102, 
                   g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103,g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105, 
                   g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108,g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110, 
                   g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150,g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160, 
                   g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153,g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155, 
                   g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158,g_fabo7_d[l_ac].fabo159) #自訂欄位頁簽 
 
                WHERE faboent = g_enterprise AND
                  fabold = g_fabo2_d_t.fabold #項次 
                  AND fabodocno = g_fabo2_d_t.fabodocno
                  AND faboseq = g_fabo2_d_t.faboseq
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
              SELECT glab005 INTO l_fabo029 FROM glab_t
               WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='4' AND glab003='9902_05'
              SELECT faaj023,faaj024,faaj026 INTO l_faaj023,l_faaj024,l_faaj026 FROM faaj_t
               WHERE faajent = g_enterprise AND faajld = g_fabgld
                 AND faaj001 = g_fabo001 AND faaj002 = g_fabo002
                 AND faaj037 = g_fabo003
              UPDATE fabo_t SET fabo029=l_fabo029,
                                fabo026=l_faaj024,
                                fabo027=l_faaj026,
                                fabo028=l_faaj023
                          WHERE faboent=g_enterprise AND fabold=g_fabgld
                            AND fabodocno=g_fabgdocno AND faboseq=g_fabo_d[l_ac].faboseq
               #產生出售單
               CALL afat505_01_fabo_4_ins()
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo2_d[g_detail_idx].fabold
               LET gs_keys_bak[1] = g_fabo2_d_t.fabold
               LET gs_keys[2] = g_fabo2_d[g_detail_idx].fabodocno
               LET gs_keys_bak[2] = g_fabo2_d_t.fabodocno
               LET gs_keys[3] = g_fabo2_d[g_detail_idx].faboseq
               LET gs_keys_bak[3] = g_fabo2_d_t.faboseq
               CALL afat505_01_update_b('fabo_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fabo2_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat505_01_fabo_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo024
            
            #add-point:AFTER FIELD fabo024 name="input.a.page2.fabo024"
            CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
            DISPLAY g_fabo2_d[l_ac].fabo024_desc TO s_detail2[l_ac].fabo024_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo024) THEN 
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql =" "
              IF  s_aglt310_getlike_lc_subject(g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].fabo024,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabo2_d[l_ac].fabold
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo024
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabo2_d[l_ac].fabo024
                LET g_qryparam.arg3 = g_fabo2_d[l_ac].fabold
                LET g_qryparam.arg4 = "1 AND glac001 = '",g_glaa004,"'"
                CALL q_glac002_6()
                LET g_fabo2_d[l_ac].fabo024 = g_qryparam.return1              
                CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
                DISPLAY g_fabo2_d[l_ac].fabo024_desc TO s_detail2[l_ac].fabo024_desc
                DISPLAY g_fabo2_d[l_ac].fabo024 TO fabo024  
                
              END IF
              IF NOT  s_aglt310_lc_subject(g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].fabo024,'N') THEN
                  LET g_fabo2_d[l_ac].fabo024 = g_fabo2_d_t.fabo024
                  CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
                  DISPLAY g_fabo2_d[l_ac].fabo024_desc TO s_detail2[l_ac].fabo024_desc
                  NEXT FIELD CURRENT
              END IF
              #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabo2_d[l_ac].fabo024
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo024 = g_fabo2_d_t.fabo024
                  CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
                  DISPLAY g_fabo2_d[l_ac].fabo024_desc TO s_detail2[l_ac].fabo024_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo024
            #add-point:BEFORE FIELD fabo024 name="input.b.page2.fabo024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo024
            #add-point:ON CHANGE fabo024 name="input.g.page2.fabo024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo024_desc
            #add-point:BEFORE FIELD fabo024_desc name="input.b.page2.fabo024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo024_desc
            
            #add-point:AFTER FIELD fabo024_desc name="input.a.page2.fabo024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo024_desc
            #add-point:ON CHANGE fabo024_desc name="input.g.page2.fabo024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo042
            #add-point:BEFORE FIELD fabo042 name="input.b.page2.fabo042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo042
            
            #add-point:AFTER FIELD fabo042 name="input.a.page2.fabo042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo042
            #add-point:ON CHANGE fabo042 name="input.g.page2.fabo042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031
            #add-point:BEFORE FIELD fabo031 name="input.b.page2.fabo031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031
            
            #add-point:AFTER FIELD fabo031 name="input.a.page2.fabo031"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo031
            #add-point:ON CHANGE fabo031 name="input.g.page2.fabo031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo031_desc
            #add-point:BEFORE FIELD fabo031_desc name="input.b.page2.fabo031_desc"
            LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo031_desc
            
            #add-point:AFTER FIELD fabo031_desc name="input.a.page2.fabo031_desc"
            LET g_fabo2_d[l_ac].fabo031 = g_fabo2_d[l_ac].fabo031_desc
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo031) RETURNING g_fabo2_d[l_ac].fabo031_desc
            LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031 CLIPPED,g_fabo2_d[l_ac].fabo031_desc
            DISPLAY g_fabo2_d[l_ac].fabo031_desc TO s_detail2[l_ac].fabo031_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo031   
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo031 = g_fabo2_d_t.fabo031
                  LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d_t.fabo031_desc
                  CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo031) RETURNING g_fabo2_d[l_ac].fabo031_desc
                  LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031 CLIPPED,g_fabo2_d[l_ac].fabo031_desc
                  DISPLAY g_fabo2_d[l_ac].fabo031_desc TO s_detail2[l_ac].fabo031_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo031_desc
            #add-point:ON CHANGE fabo031_desc name="input.g.page2.fabo031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032
            #add-point:BEFORE FIELD fabo032 name="input.b.page2.fabo032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032
            
            #add-point:AFTER FIELD fabo032 name="input.a.page2.fabo032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo032
            #add-point:ON CHANGE fabo032 name="input.g.page2.fabo032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo032_desc
            #add-point:BEFORE FIELD fabo032_desc name="input.b.page2.fabo032_desc"
            LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo032_desc
            
            #add-point:AFTER FIELD fabo032_desc name="input.a.page2.fabo032_desc"
            LET g_fabo2_d[l_ac].fabo032 = g_fabo2_d[l_ac].fabo032_desc
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo032) RETURNING g_fabo2_d[l_ac].fabo032_desc
            LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032 CLIPPED,g_fabo2_d[l_ac].fabo032_desc
            DISPLAY g_fabo2_d[l_ac].fabo032_desc TO s_detail2[l_ac].fabo032_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo032) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo032
               LET g_chkparam.arg2 = g_today   
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
               LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo032 = g_fabo2_d_t.fabo032
                  LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d_t.fabo032_desc
                  CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo032) RETURNING g_fabo2_d[l_ac].fabo032_desc
                  LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032 CLIPPED,g_fabo2_d[l_ac].fabo032_desc
                  DISPLAY g_fabo2_d[l_ac].fabo032_desc TO s_detail2[l_ac].fabo032_desc
                  NEXT FIELD CURRENT
               END IF          
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo032_desc
            #add-point:ON CHANGE fabo032_desc name="input.g.page2.fabo032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033
            #add-point:BEFORE FIELD fabo033 name="input.b.page2.fabo033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033
            
            #add-point:AFTER FIELD fabo033 name="input.a.page2.fabo033"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo033
            #add-point:ON CHANGE fabo033 name="input.g.page2.fabo033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo033_desc
            #add-point:BEFORE FIELD fabo033_desc name="input.b.page2.fabo033_desc"
            LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo033_desc
            
            #add-point:AFTER FIELD fabo033_desc name="input.a.page2.fabo033_desc"
            LET g_fabo2_d[l_ac].fabo033 = g_fabo2_d[l_ac].fabo033_desc
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo033) RETURNING g_fabo2_d[l_ac].fabo033_desc
            LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033 CLIPPED,g_fabo2_d[l_ac].fabo033_desc
            DISPLAY g_fabo2_d[l_ac].fabo033_desc TO s_detail2[l_ac].fabo033_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo033) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo033
               LET g_chkparam.arg2 = g_today 
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
               LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo033 = g_fabo2_d_t.fabo033
                  LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d_t.fabo033_desc
                  CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo033) RETURNING g_fabo2_d[l_ac].fabo033_desc
                  LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033 CLIPPED,g_fabo2_d[l_ac].fabo033_desc
                  DISPLAY g_fabo2_d[l_ac].fabo033_desc TO s_detail2[l_ac].fabo033_desc
                  NEXT FIELD CURRENT
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo033_desc
            #add-point:ON CHANGE fabo033_desc name="input.g.page2.fabo033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034
            #add-point:BEFORE FIELD fabo034 name="input.b.page2.fabo034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034
            
            #add-point:AFTER FIELD fabo034 name="input.a.page2.fabo034"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo034
            #add-point:ON CHANGE fabo034 name="input.g.page2.fabo034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo034_desc
            #add-point:BEFORE FIELD fabo034_desc name="input.b.page2.fabo034_desc"
            LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo034_desc
            
            #add-point:AFTER FIELD fabo034_desc name="input.a.page2.fabo034_desc"
            LET g_fabo2_d[l_ac].fabo034 = g_fabo2_d[l_ac].fabo034_desc
            CALL afat505_01_fabo034_desc('287',g_fabo2_d[l_ac].fabo034) RETURNING g_fabo2_d[l_ac].fabo034_desc
            LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034 CLIPPED,g_fabo2_d[l_ac].fabo034_desc
            DISPLAY g_fabo2_d[l_ac].fabo034_desc TO s_detail2[l_ac].fabo034_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo034) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL            
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo034
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"    #160318-00025#13               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_287") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo034 = g_fabo2_d_t.fabo034
                  LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d_t.fabo034_desc
                  CALL afat505_01_fabo034_desc('287',g_fabo2_d[l_ac].fabo034) RETURNING g_fabo2_d[l_ac].fabo034_desc
                  LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034 CLIPPED,g_fabo2_d[l_ac].fabo034_desc
                  DISPLAY g_fabo2_d[l_ac].fabo034_desc TO s_detail2[l_ac].fabo034_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo034_desc
            #add-point:ON CHANGE fabo034_desc name="input.g.page2.fabo034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035
            #add-point:BEFORE FIELD fabo035 name="input.b.page2.fabo035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035
            
            #add-point:AFTER FIELD fabo035 name="input.a.page2.fabo035"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo035
            #add-point:ON CHANGE fabo035 name="input.g.page2.fabo035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo035_desc
            #add-point:BEFORE FIELD fabo035_desc name="input.b.page2.fabo035_desc"
            LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo035_desc
            
            #add-point:AFTER FIELD fabo035_desc name="input.a.page2.fabo035_desc"
            LET g_fabo2_d[l_ac].fabo035 = g_fabo2_d[l_ac].fabo035_desc
            CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo035) RETURNING g_fabo2_d[l_ac].fabo035_desc
            LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035 CLIPPED,g_fabo2_d[l_ac].fabo035_desc
            DISPLAY g_fabo2_d[l_ac].fabo035_desc TO s_detail2[l_ac].fabo035_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo035) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo035
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo035 = g_fabo2_d_t.fabo035
                  LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d_t.fabo035_desc
                  CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo035) RETURNING g_fabo2_d[l_ac].fabo035_desc
                  LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035 CLIPPED,g_fabo2_d[l_ac].fabo035_desc
                  DISPLAY g_fabo2_d[l_ac].fabo035_desc TO s_detail2[l_ac].fabo035_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo035_desc
            #add-point:ON CHANGE fabo035_desc name="input.g.page2.fabo035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036
            #add-point:BEFORE FIELD fabo036 name="input.b.page2.fabo036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036
            
            #add-point:AFTER FIELD fabo036 name="input.a.page2.fabo036"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo036
            #add-point:ON CHANGE fabo036 name="input.g.page2.fabo036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo036_desc
            #add-point:BEFORE FIELD fabo036_desc name="input.b.page2.fabo036_desc"
            LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo036_desc
            
            #add-point:AFTER FIELD fabo036_desc name="input.a.page2.fabo036_desc"
            LET g_fabo2_d[l_ac].fabo036 = g_fabo2_d[l_ac].fabo036_desc
            CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo036) RETURNING g_fabo2_d[l_ac].fabo036_desc
            LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036 CLIPPED,g_fabo2_d[l_ac].fabo036_desc
            DISPLAY g_fabo2_d[l_ac].fabo036_desc TO s_detail2[l_ac].fabo036_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo036) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo036
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo036 = g_fabo2_d_t.fabo036
                  LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d_t.fabo036_desc
                  CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo036) RETURNING g_fabo2_d[l_ac].fabo036_desc
                  LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036 CLIPPED,g_fabo2_d[l_ac].fabo036_desc
                  DISPLAY g_fabo2_d[l_ac].fabo036_desc TO s_detail2[l_ac].fabo036_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo036_desc
            #add-point:ON CHANGE fabo036_desc name="input.g.page2.fabo036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037
            #add-point:BEFORE FIELD fabo037 name="input.b.page2.fabo037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037
            
            #add-point:AFTER FIELD fabo037 name="input.a.page2.fabo037"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo037
            #add-point:ON CHANGE fabo037 name="input.g.page2.fabo037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo037_desc
            #add-point:BEFORE FIELD fabo037_desc name="input.b.page2.fabo037_desc"
            LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo037_desc
            
            #add-point:AFTER FIELD fabo037_desc name="input.a.page2.fabo037_desc"
            LET g_fabo2_d[l_ac].fabo037 = g_fabo2_d[l_ac].fabo037_desc
            CALL afat505_01_fabo034_desc('281',g_fabo2_d[l_ac].fabo037) RETURNING g_fabo2_d[l_ac].fabo037_desc
            LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037 CLIPPED,g_fabo2_d[l_ac].fabo037_desc
            DISPLAY g_fabo2_d[l_ac].fabo037_desc TO s_detail2[l_ac].fabo037_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo037) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo037  
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"    #160318-00025#13
               LET g_chkparam.err_str[2] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"    #160318-00025#13                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo037 = g_fabo2_d_t.fabo037
                  LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d_t.fabo037_desc
                  CALL afat505_01_fabo034_desc('281',g_fabo2_d[l_ac].fabo037) RETURNING g_fabo2_d[l_ac].fabo037_desc
                  LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037 CLIPPED,g_fabo2_d[l_ac].fabo037_desc
                  DISPLAY g_fabo2_d[l_ac].fabo037_desc TO s_detail2[l_ac].fabo037_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo037_desc
            #add-point:ON CHANGE fabo037_desc name="input.g.page2.fabo037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038
            #add-point:BEFORE FIELD fabo038 name="input.b.page2.fabo038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038
            
            #add-point:AFTER FIELD fabo038 name="input.a.page2.fabo038"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo038
            #add-point:ON CHANGE fabo038 name="input.g.page2.fabo038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo038_desc
            #add-point:BEFORE FIELD fabo038_desc name="input.b.page2.fabo038_desc"
            LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo038_desc
            
            #add-point:AFTER FIELD fabo038_desc name="input.a.page2.fabo038_desc"
            LET g_fabo2_d[l_ac].fabo038 = g_fabo2_d[l_ac].fabo038_desc
            CALL afat505_01_fabo038_desc(g_fabo2_d[l_ac].fabo038) RETURNING g_fabo2_d[l_ac].fabo038_desc
            LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038 CLIPPED,g_fabo2_d[l_ac].fabo038_desc
            DISPLAY g_fabo2_d[l_ac].fabo038_desc TO s_detail2[l_ac].fabo038_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo038) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo038
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13
              
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo038 = g_fabo2_d_t.fabo038
                  LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d_t.fabo038_desc
                  CALL afat505_01_fabo038_desc(g_fabo2_d[l_ac].fabo038) RETURNING g_fabo2_d[l_ac].fabo038_desc
                  LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038 CLIPPED,g_fabo2_d[l_ac].fabo038_desc
                  DISPLAY g_fabo2_d[l_ac].fabo038_desc TO s_detail2[l_ac].fabo038_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo038_desc
            #add-point:ON CHANGE fabo038_desc name="input.g.page2.fabo038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039
            #add-point:BEFORE FIELD fabo039 name="input.b.page2.fabo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039
            
            #add-point:AFTER FIELD fabo039 name="input.a.page2.fabo039"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo039
            #add-point:ON CHANGE fabo039 name="input.g.page2.fabo039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo039_desc
            #add-point:BEFORE FIELD fabo039_desc name="input.b.page2.fabo039_desc"
            LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo039_desc
            
            #add-point:AFTER FIELD fabo039_desc name="input.a.page2.fabo039_desc"
            LET g_fabo2_d[l_ac].fabo039 = g_fabo2_d[l_ac].fabo039_desc
            CALL afat505_01_fabo039_desc(g_fabo2_d[l_ac].fabo039) RETURNING g_fabo2_d[l_ac].fabo039_desc
            LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039 CLIPPED,g_fabo2_d[l_ac].fabo039_desc
            DISPLAY g_fabo2_d[l_ac].fabo039_desc TO s_detail2[l_ac].fabo039_desc
            IF NOT cl_null(g_fabo2_d[l_ac].fabo039) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo039 
            
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo039 = g_fabo2_d_t.fabo039
                  LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d_t.fabo039_desc
                  CALL afat505_01_fabo039_desc(g_fabo2_d[l_ac].fabo039) RETURNING g_fabo2_d[l_ac].fabo039_desc
                  LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039 CLIPPED,g_fabo2_d[l_ac].fabo039_desc
                  DISPLAY g_fabo2_d[l_ac].fabo039_desc TO s_detail2[l_ac].fabo039_desc
                  NEXT FIELD CURRENT
               END IF         
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo039_desc
            #add-point:ON CHANGE fabo039_desc name="input.g.page2.fabo039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040
            #add-point:BEFORE FIELD fabo040 name="input.b.page2.fabo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040
            
            #add-point:AFTER FIELD fabo040 name="input.a.page2.fabo040"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo040
            #add-point:ON CHANGE fabo040 name="input.g.page2.fabo040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo040_desc
            #add-point:BEFORE FIELD fabo040_desc name="input.b.page2.fabo040_desc"
            LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo040_desc
            
            #add-point:AFTER FIELD fabo040_desc name="input.a.page2.fabo040_desc"
            LET g_fabo2_d[l_ac].fabo040 = g_fabo2_d[l_ac].fabo040_desc
            CALL afat505_01_fabo040_desc(g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040) RETURNING g_fabo2_d[l_ac].fabo040_desc
            LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040 CLIPPED,g_fabo2_d[l_ac].fabo040_desc
            DISPLAY g_fabo2_d[l_ac].fabo040_desc TO s_detail2[l_ac].fabo040_desc 
            IF NOT cl_null(g_fabo2_d[l_ac].fabo040) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo2_d[l_ac].fabo039
               LET g_chkparam.arg2 = g_fabo2_d[l_ac].fabo040
            
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo2_d[l_ac].fabo040 = g_fabo2_d_t.fabo040
                  LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d_t.fabo040_desc
                  CALL afat505_01_fabo040_desc(g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040) RETURNING g_fabo2_d[l_ac].fabo040_desc
                  LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040 CLIPPED,g_fabo2_d[l_ac].fabo040_desc
                  DISPLAY g_fabo2_d[l_ac].fabo040_desc TO s_detail2[l_ac].fabo040_desc 
                  NEXT FIELD CURRENT
               END IF         
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo040_desc
            #add-point:ON CHANGE fabo040_desc name="input.g.page2.fabo040_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fabo024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo024
            #add-point:ON ACTION controlp INFIELD fabo024 name="input.c.page2.fabo024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo024             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'",
                                     " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabo2_d[l_ac].fabold,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo024 = g_qryparam.return1              
            CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
            DISPLAY g_fabo2_d[l_ac].fabo024_desc TO s_detail2[l_ac].fabo024_desc
            DISPLAY g_fabo2_d[l_ac].fabo024 TO fabo024              #

            NEXT FIELD fabo024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo024_desc
            #add-point:ON ACTION controlp INFIELD fabo024_desc name="input.c.page2.fabo024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo042
            #add-point:ON ACTION controlp INFIELD fabo042 name="input.c.page2.fabo042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031
            #add-point:ON ACTION controlp INFIELD fabo031 name="input.c.page2.fabo031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo031 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo031 TO fabo031              #

            NEXT FIELD fabo031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo031_desc
            #add-point:ON ACTION controlp INFIELD fabo031_desc name="input.c.page2.fabo031_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo031 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo031) RETURNING g_fabo2_d[l_ac].fabo031_desc
            LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031 CLIPPED,g_fabo2_d[l_ac].fabo031_desc
            DISPLAY g_fabo2_d[l_ac].fabo031_desc TO fabo031_desc              #

            NEXT FIELD fabo031_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032
            #add-point:ON ACTION controlp INFIELD fabo032 name="input.c.page2.fabo032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo032 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo032 TO fabo032              #

            NEXT FIELD fabo032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo032_desc
            #add-point:ON ACTION controlp INFIELD fabo032_desc name="input.c.page2.fabo032_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo032 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo032) RETURNING g_fabo2_d[l_ac].fabo032_desc
            LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032 CLIPPED,g_fabo2_d[l_ac].fabo032_desc
            DISPLAY g_fabo2_d[l_ac].fabo032_desc TO fabo032_desc              #

            NEXT FIELD fabo032_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033
            #add-point:ON ACTION controlp INFIELD fabo033 name="input.c.page2.fabo033"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo033 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo033 TO fabo033              #

            NEXT FIELD fabo033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo033_desc
            #add-point:ON ACTION controlp INFIELD fabo033_desc name="input.c.page2.fabo033_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo033             #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo033 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo033) RETURNING g_fabo2_d[l_ac].fabo033_desc
            LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033 CLIPPED,g_fabo2_d[l_ac].fabo033_desc
            DISPLAY g_fabo2_d[l_ac].fabo033_desc TO fabo033_desc              #

            NEXT FIELD fabo033_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034
            #add-point:ON ACTION controlp INFIELD fabo034 name="input.c.page2.fabo034"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo034             #給予default值
            LET g_qryparam.default2 = "" #g_fabo2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo034 = g_qryparam.return1              
            #LET g_fabo2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabo2_d[l_ac].fabo034 TO fabo034              #
            #DISPLAY g_fabo2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabo034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo034_desc
            #add-point:ON ACTION controlp INFIELD fabo034_desc name="input.c.page2.fabo034_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '287'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo034 = g_qryparam.return1              
            CALL afat505_01_fabo034_desc('287',g_fabo2_d[l_ac].fabo034) RETURNING g_fabo2_d[l_ac].fabo034_desc
            LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034 CLIPPED,g_fabo2_d[l_ac].fabo034_desc
            DISPLAY g_fabo2_d[l_ac].fabo034_desc TO fabo034_desc              #

            NEXT FIELD fabo034_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035
            #add-point:ON ACTION controlp INFIELD fabo035 name="input.c.page2.fabo035"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo2_d[l_ac].fabo035 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo035 TO fabo035              #

            NEXT FIELD fabo035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo035_desc
            #add-point:ON ACTION controlp INFIELD fabo035_desc name="input.c.page2.fabo035_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo035            #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo2_d[l_ac].fabo035 = g_qryparam.return1              
            CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo035) RETURNING g_fabo2_d[l_ac].fabo035_desc
            LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035 CLIPPED,g_fabo2_d[l_ac].fabo035_desc
            DISPLAY g_fabo2_d[l_ac].fabo035_desc TO fabo035_desc              #

            NEXT FIELD fabo035_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036
            #add-point:ON ACTION controlp INFIELD fabo036 name="input.c.page2.fabo036"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo2_d[l_ac].fabo036 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo036 TO fabo036              #

            NEXT FIELD fabo036                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo036_desc
            #add-point:ON ACTION controlp INFIELD fabo036_desc name="input.c.page2.fabo036_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo2_d[l_ac].fabo036 = g_qryparam.return1              
            CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo036) RETURNING g_fabo2_d[l_ac].fabo036_desc
            LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036 CLIPPED,g_fabo2_d[l_ac].fabo036_desc
            DISPLAY g_fabo2_d[l_ac].fabo036_desc TO fabo036_desc              #

            NEXT FIELD fabo036_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037
            #add-point:ON ACTION controlp INFIELD fabo037 name="input.c.page2.fabo037"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo037             #給予default值
            LET g_qryparam.default2 = "" #g_fabo2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo037 = g_qryparam.return1              
            #LET g_fabo2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabo2_d[l_ac].fabo037 TO fabo037              #
            #DISPLAY g_fabo2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabo037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo037_desc
            #add-point:ON ACTION controlp INFIELD fabo037_desc name="input.c.page2.fabo037_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo037             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '281'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo037 = g_qryparam.return1              
            CALL afat505_01_fabo034_desc('281',g_fabo2_d[l_ac].fabo037) RETURNING g_fabo2_d[l_ac].fabo037_desc
            LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037 CLIPPED,g_fabo2_d[l_ac].fabo037_desc
            DISPLAY g_fabo2_d[l_ac].fabo037_desc TO fabo037_desc              #

            NEXT FIELD fabo037_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038
            #add-point:ON ACTION controlp INFIELD fabo038 name="input.c.page2.fabo038"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo038             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo038 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo038 TO fabo038              #

            NEXT FIELD fabo038                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo038_desc
            #add-point:ON ACTION controlp INFIELD fabo038_desc name="input.c.page2.fabo038_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo038             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_2()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo038 = g_qryparam.return1              
            CALL afat505_01_fabo038_desc(g_fabo2_d[l_ac].fabo038) RETURNING g_fabo2_d[l_ac].fabo038_desc
            LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038 CLIPPED,g_fabo2_d[l_ac].fabo038_desc
            DISPLAY g_fabo2_d[l_ac].fabo038_desc TO fabo038_desc              #

            NEXT FIELD fabo038_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039
            #add-point:ON ACTION controlp INFIELD fabo039 name="input.c.page2.fabo039"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo039             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo039 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo039 TO fabo039              #

            NEXT FIELD fabo039                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo039_desc
            #add-point:ON ACTION controlp INFIELD fabo039_desc name="input.c.page2.fabo039_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo039             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo039 = g_qryparam.return1              
            CALL afat505_01_fabo039_desc(g_fabo2_d[l_ac].fabo039) RETURNING g_fabo2_d[l_ac].fabo039_desc
            LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039 CLIPPED,g_fabo2_d[l_ac].fabo039_desc
            DISPLAY g_fabo2_d[l_ac].fabo039_desc TO fabo039_desc              #

            NEXT FIELD fabo039_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040
            #add-point:ON ACTION controlp INFIELD fabo040 name="input.c.page2.fabo040"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo040             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo040 = g_qryparam.return1              

            DISPLAY g_fabo2_d[l_ac].fabo040 TO fabo040              #

            NEXT FIELD fabo040                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabo040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo040_desc
            #add-point:ON ACTION controlp INFIELD fabo040_desc name="input.c.page2.fabo040_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo2_d[l_ac].fabo040             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fabo2_d[l_ac].fabo039

            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_fabo2_d[l_ac].fabo040 = g_qryparam.return1              
            CALL afat505_01_fabo040_desc(g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040) RETURNING g_fabo2_d[l_ac].fabo040_desc
            LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040 CLIPPED,g_fabo2_d[l_ac].fabo040_desc
            DISPLAY g_fabo2_d[l_ac].fabo040_desc TO fabo040_desc              #

            NEXT FIELD fabo040_desc                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo2_d[l_ac].* = g_fabo2_d_t.*
               END IF
               CLOSE afat505_01_bcl
               #add-point:單身after row name="input.body2.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("fabo_t")
            #add-point:單身after row name="input.body2.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo2_d[li_reproduce_target].fabold = NULL
               LET g_fabo2_d[li_reproduce_target].fabodocno = NULL
               LET g_fabo2_d[li_reproduce_target].faboseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabo2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabo2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_fabo7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo7_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabold
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo7_d[l_ac].* TO NULL 
            INITIALIZE g_fabo7_d_t.* TO NULL
            INITIALIZE g_fabo7_d_o.* TO NULL
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body7.before_bak"
            
            #end add-point
            LET g_fabo7_d_t.* = g_fabo7_d[l_ac].*     #新輸入資料
            LET g_fabo7_d_o.* = g_fabo7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo7_d[li_reproduce_target].fabold = NULL
               LET g_fabo7_d[li_reproduce_target].fabodocno = NULL
               LET g_fabo7_d[li_reproduce_target].faboseq = NULL
            END IF
            
 
 
 
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body7.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body7.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail7")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo7_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo7_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo7_d[l_ac].fabold IS NOT NULL
               AND g_fabo7_d[l_ac].fabodocno IS NOT NULL
               AND g_fabo7_d[l_ac].faboseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo7_d_t.* = g_fabo7_d[l_ac].*  #BACKUP
               LET g_fabo7_d_o.* = g_fabo7_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("fabo_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl INTO g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                      g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                      g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                      g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                      g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                      g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabodocno,g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].faboseq, 
                      g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031,g_fabo2_d[l_ac].fabo032, 
                      g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035,g_fabo2_d[l_ac].fabo036, 
                      g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040, 
                      g_fabo7_d[l_ac].fabodocno,g_fabo7_d[l_ac].fabold,g_fabo7_d[l_ac].faboseq,g_fabo7_d[l_ac].fabo107, 
                      g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103, 
                      g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105,g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108, 
                      g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110,g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150, 
                      g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160,g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153, 
                      g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155,g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158, 
                      g_fabo7_d[l_ac].fabo159
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH afat505_01_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabo7_d_mask_o[l_ac].* =  g_fabo7_d[l_ac].*
                  CALL afat505_01_fabo_t_mask()
                  LET g_fabo7_d_mask_n[l_ac].* =  g_fabo7_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat505_01_set_entry_b(l_cmd)
            CALL afat505_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body7.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身3ask刪除前 name="input.body7.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身3刪除前 name="input.body7.b_delete"
               
               #end add-point 
               
               DELETE FROM fabo_t
                WHERE faboent = g_enterprise AND
                  fabold = g_fabo7_d_t.fabold
                  AND fabodocno = g_fabo7_d_t.fabodocno
                  AND faboseq = g_fabo7_d_t.faboseq
                  
               #add-point:單身3刪除中 name="input.body7.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身3刪除後 name="input.body7.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL afat505_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fabo7_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afat505_01_bcl
               #add-point:單身3刪除關閉bcl name="input.body7.close"
               
               #end add-point
               LET l_count = g_fabo_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo7_d_t.fabold
               LET gs_keys[2] = g_fabo7_d_t.fabodocno
               LET gs_keys[3] = g_fabo7_d_t.faboseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body7.after_delete"
               
               #end add-point
                              CALL afat505_01_delete_b('fabo_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo7_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body7.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fabo_t 
             WHERE faboent = g_enterprise AND
                   fabold = g_fabo7_d[l_ac].fabold
                   AND fabodocno = g_fabo7_d[l_ac].fabodocno
                   AND faboseq = g_fabo7_d[l_ac].faboseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body7.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo7_d[g_detail_idx].fabold
               LET gs_keys[2] = g_fabo7_d[g_detail_idx].fabodocno
               LET gs_keys[3] = g_fabo7_d[g_detail_idx].faboseq
               CALL afat505_01_insert_b('fabo_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body7.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabo_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body7.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (fabold = '", g_fabo7_d[l_ac].fabold, "' "
                                  ," AND fabodocno = '", g_fabo7_d[l_ac].fabodocno, "' "
                                  ," AND faboseq = '", g_fabo7_d[l_ac].faboseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo7_d[l_ac].* = g_fabo7_d_t.*
               CLOSE afat505_01_bcl
               #add-point:單身page3取消後 name="input.body7.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo7_d[l_ac].* = g_fabo7_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body7.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat505_01_fabo_t_mask_restore('restore_mask_o')
               
               UPDATE fabo_t SET (fabodocno,fabold,faboseq,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013, 
                   fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022, 
                   fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039, 
                   fabo040,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105,fabo106,fabo108,fabo109, 
                   fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155,fabo157,fabo158, 
                   fabo159) = (g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq, 
                   g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                   g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                   g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                   g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                   g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031, 
                   g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035, 
                   g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039, 
                   g_fabo2_d[l_ac].fabo040,g_fabo7_d[l_ac].fabo107,g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102, 
                   g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103,g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105, 
                   g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108,g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110, 
                   g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150,g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160, 
                   g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153,g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155, 
                   g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158,g_fabo7_d[l_ac].fabo159) #自訂欄位頁簽 
 
                WHERE faboent = g_enterprise AND
                  fabold = g_fabo7_d_t.fabold #項次 
                  AND fabodocno = g_fabo7_d_t.fabodocno
                  AND faboseq = g_fabo7_d_t.faboseq
                  
               #add-point:單身page3修改中 name="input.body7.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo7_d[g_detail_idx].fabold
               LET gs_keys_bak[1] = g_fabo7_d_t.fabold
               LET gs_keys[2] = g_fabo7_d[g_detail_idx].fabodocno
               LET gs_keys_bak[2] = g_fabo7_d_t.fabodocno
               LET gs_keys[3] = g_fabo7_d[g_detail_idx].faboseq
               LET gs_keys_bak[3] = g_fabo7_d_t.faboseq
               CALL afat505_01_update_b('fabo_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fabo7_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo7_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat505_01_fabo_t_mask_restore('restore_mask_n')
               
               #add-point:單身page3修改後 name="input.body7.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo108
            #add-point:BEFORE FIELD fabo108 name="input.b.page7.fabo108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo108
            
            #add-point:AFTER FIELD fabo108 name="input.a.page7.fabo108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo108
            #add-point:ON CHANGE fabo108 name="input.g.page7.fabo108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo109
            #add-point:BEFORE FIELD fabo109 name="input.b.page7.fabo109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo109
            
            #add-point:AFTER FIELD fabo109 name="input.a.page7.fabo109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo109
            #add-point:ON CHANGE fabo109 name="input.g.page7.fabo109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo110
            #add-point:BEFORE FIELD fabo110 name="input.b.page7.fabo110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo110
            
            #add-point:AFTER FIELD fabo110 name="input.a.page7.fabo110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo110
            #add-point:ON CHANGE fabo110 name="input.g.page7.fabo110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo157
            #add-point:BEFORE FIELD fabo157 name="input.b.page7.fabo157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo157
            
            #add-point:AFTER FIELD fabo157 name="input.a.page7.fabo157"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo157
            #add-point:ON CHANGE fabo157 name="input.g.page7.fabo157"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo158
            #add-point:BEFORE FIELD fabo158 name="input.b.page7.fabo158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo158
            
            #add-point:AFTER FIELD fabo158 name="input.a.page7.fabo158"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo158
            #add-point:ON CHANGE fabo158 name="input.g.page7.fabo158"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo159
            #add-point:BEFORE FIELD fabo159 name="input.b.page7.fabo159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo159
            
            #add-point:AFTER FIELD fabo159 name="input.a.page7.fabo159"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo159
            #add-point:ON CHANGE fabo159 name="input.g.page7.fabo159"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page7.fabo108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo108
            #add-point:ON ACTION controlp INFIELD fabo108 name="input.c.page7.fabo108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.fabo109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo109
            #add-point:ON ACTION controlp INFIELD fabo109 name="input.c.page7.fabo109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.fabo110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo110
            #add-point:ON ACTION controlp INFIELD fabo110 name="input.c.page7.fabo110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.fabo157
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo157
            #add-point:ON ACTION controlp INFIELD fabo157 name="input.c.page7.fabo157"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.fabo158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo158
            #add-point:ON ACTION controlp INFIELD fabo158 name="input.c.page7.fabo158"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.fabo159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo159
            #add-point:ON ACTION controlp INFIELD fabo159 name="input.c.page7.fabo159"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo7_d[l_ac].* = g_fabo7_d_t.*
               END IF
               CLOSE afat505_01_bcl
               #add-point:單身after row name="input.body7.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("fabo_t")
            #add-point:單身after row name="input.body7.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身3input後 name="input.body7.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
               LET g_fabo2_d[li_reproduce_target].* = g_fabo2_d[li_reproduce].*
               LET g_fabo7_d[li_reproduce_target].* = g_fabo7_d[li_reproduce].*
 
               LET g_fabo7_d[li_reproduce_target].fabold = NULL
               LET g_fabo7_d[li_reproduce_target].fabodocno = NULL
               LET g_fabo7_d[li_reproduce_target].faboseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabo7_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabo7_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      INPUT ARRAY g_fabo3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo3_d.getLength()
            
            
 
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabuld
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo3_d[l_ac].* TO NULL 
            INITIALIZE g_fabo3_d_t.* TO NULL
            INITIALIZE g_fabo3_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份

            #end add-point
            LET g_fabo3_d_t.* = g_fabo3_d[l_ac].*     #新輸入資料
            LET g_fabo3_d_o.* = g_fabo3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat505_01_set_entry_b("a")
            CALL afat505_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo3_d[li_reproduce_target].* = g_fabo3_d[li_reproduce].*
               LET g_fabo4_d[li_reproduce_target].* = g_fabo4_d[li_reproduce].*
               LET g_fabo8_d[li_reproduce_target].* = g_fabo8_d[li_reproduce].*
 
               LET g_fabo3_d[li_reproduce_target].fabuld = NULL
               LET g_fabo3_d[li_reproduce_target].fabudocno = NULL
               LET g_fabo3_d[li_reproduce_target].fabuseq = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo3_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo3_d[l_ac].fabuld IS NOT NULL
               AND g_fabo3_d[l_ac].fabudocno IS NOT NULL
               AND g_fabo3_d[l_ac].fabuseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo3_d_t.* = g_fabo3_d[l_ac].*  #BACKUP
               LET g_fabo3_d_o.* = g_fabo3_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("fabu_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl2 INTO g_fabo3_d[l_ac].fabudocno,g_fabo3_d[l_ac].fabuld,g_fabo3_d[l_ac].fabuseq,g_fabo3_d[l_ac].fabu009,
                                             g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu006,g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu013,g_fabo3_d[l_ac].fabu014,
                                             g_fabo3_d[l_ac].fabu015,g_fabo3_d[l_ac].fabu016,g_fabo3_d[l_ac].fabu017,g_fabo3_d[l_ac].fabu011,
                                             g_fabo4_d[l_ac].fabudocno,g_fabo4_d[l_ac].fabuld,g_fabo4_d[l_ac].fabuseq,g_fabo4_d[l_ac].fabu022,
                                             g_fabo4_d[l_ac].fabu035,g_fabo4_d[l_ac].fabu024,g_fabo4_d[l_ac].fabu025,g_fabo4_d[l_ac].fabu026,
                                             g_fabo4_d[l_ac].fabu027,g_fabo4_d[l_ac].fabu028,g_fabo4_d[l_ac].fabu029,g_fabo4_d[l_ac].fabu030,
                                             g_fabo4_d[l_ac].fabu031,g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033,
                                             g_fabo8_d[l_ac].fabudocno,g_fabo8_d[l_ac].fabuld,g_fabo8_d[l_ac].fabuseq,g_fabo8_d[l_ac].fabu106,
                                             g_fabo8_d[l_ac].fabu101,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu107,g_fabo8_d[l_ac].fabu103,
                                             g_fabo8_d[l_ac].fabu104,g_fabo8_d[l_ac].fabu105,g_fabo8_d[l_ac].fabu155,g_fabo8_d[l_ac].fabu150,
                                             g_fabo8_d[l_ac].fabu151,g_fabo8_d[l_ac].fabu156,g_fabo8_d[l_ac].fabu152,g_fabo8_d[l_ac].fabu153,
                                             g_fabo8_d[l_ac].fabu154
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            #20141113 add--str--by chenying  
            #预设调入/调出所有组织默认税别，币别
            IF cl_null(g_fabo3_d[l_ac].fabu010) AND l_ac > 0 THEN 
               SELECT ooef016 INTO g_fabo3_d[l_ac].fabu010 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo047 
            END IF
            
            IF cl_null(g_fabo3_d[l_ac].fabu009) AND l_ac > 0 THEN
               LET l_ooef019 = NULL            
               SELECT ooef019 INTO l_ooef019 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo047 
               SELECT oodb002 INTO g_fabo3_d[l_ac].fabu009 FROM oodb_t
                WHERE oodbent = g_enterprise AND oodb001 = l_ooef019               
            END IF            
            #20141113 add--end-- 
            
            IF cl_null(g_fabo3_d[l_ac].fabu014) THEN 
               LET g_fabo3_d[l_ac].fabu014 = g_fabo_d[l_ac].fabo014
            END IF          
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前

               #end add-point 
            
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
               
               #add-point:單身2刪除前

               #end add-point 
               
               DELETE FROM fabu_t
                WHERE fabuent = g_enterprise 
                  AND fabuld = g_fabo3_d_t.fabuld
                  AND fabudocno = g_fabo3_d_t.fabudocno
                  AND fabuseq = g_fabo3_d_t.fabuseq
                  
               #add-point:單身2刪除中

               #end add-point 
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabu_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat505_01_bcl2
               LET l_count = g_fabo3_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo3_d[g_detail_idx].fabuld
               LET gs_keys[2] = g_fabo3_d[g_detail_idx].fabudocno
               LET gs_keys[3] = g_fabo3_d[g_detail_idx].fabuseq
 
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
               CALL afat505_01_delete_b('fabu_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM fabu_t 
             WHERE fabuent = g_enterprise 
               AND fabuld = g_fabo3_d[l_ac].fabuld
               AND fabudocno = g_fabo3_d[l_ac].fabudocno
               AND fabuseq = g_fabo3_d[l_ac].fabuseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo3_d[g_detail_idx].fabuld
               LET gs_keys[2] = g_fabo3_d[g_detail_idx].fabudocno
               LET gs_keys[3] = g_fabo3_d[g_detail_idx].fabuseq
               CALL afat505_01_insert_b('fabu_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabo3_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabu_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (fabuld = '", g_fabo3_d[l_ac].fabuld, "' "
                                  ," AND fabudocno = '", g_fabo3_d[l_ac].fabudocno, "' "
                                  ," AND fabuseq = '", g_fabo3_d[l_ac].fabuseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo3_d[l_ac].* = g_fabo3_d_t.*
               CLOSE afat505_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo3_d[l_ac].* = g_fabo3_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前
              #CALL afat505_01_amt_chk()
               #end add-point
               
               UPDATE fabu_t SET (fabudocno,fabuld,fabuseq,fabu009,fabu006,fabu010,fabu012,fabu013,fabu014,fabu015, 
                   fabu016,fabu017,fabu011,fabu022,fabu035,fabu024,fabu025,fabu026,fabu027,fabu028, 
                   fabu029,fabu030,fabu031,fabu032,fabu033,fabu106,fabu101,fabu102,fabu107, 
                   fabu103,fabu104,fabu105,fabu155,fabu150,fabu151,fabu156,fabu152,fabu153,fabu154) 
                   = (g_fabo3_d[l_ac].fabudocno,g_fabo3_d[l_ac].fabuld,g_fabo3_d[l_ac].fabuseq,g_fabo3_d[l_ac].fabu009,g_fabo3_d[l_ac].fabu006,
                   g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu013,g_fabo3_d[l_ac].fabu014,
                   g_fabo3_d[l_ac].fabu015,g_fabo3_d[l_ac].fabu016,g_fabo3_d[l_ac].fabu017,g_fabo3_d[l_ac].fabu011,
                   g_fabo4_d[l_ac].fabu022,g_fabo4_d[l_ac].fabu035,g_fabo4_d[l_ac].fabu024,g_fabo4_d[l_ac].fabu025,
                   g_fabo4_d[l_ac].fabu026,g_fabo4_d[l_ac].fabu027,g_fabo4_d[l_ac].fabu028,g_fabo4_d[l_ac].fabu029,
                   g_fabo4_d[l_ac].fabu030,g_fabo4_d[l_ac].fabu031,g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033,
                   g_fabo8_d[l_ac].fabu106,g_fabo8_d[l_ac].fabu101,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu107,
                   g_fabo8_d[l_ac].fabu103,g_fabo8_d[l_ac].fabu104,g_fabo8_d[l_ac].fabu105,g_fabo8_d[l_ac].fabu155,
                   g_fabo8_d[l_ac].fabu150,g_fabo8_d[l_ac].fabu151,g_fabo8_d[l_ac].fabu156,g_fabo8_d[l_ac].fabu152,
                   g_fabo8_d[l_ac].fabu153,g_fabo8_d[l_ac].fabu154) #自訂欄位頁簽
                WHERE fabuent = g_enterprise AND
                  fabuld = g_fabo3_d_t.fabuld #項次 
                  AND fabudocno = g_fabo3_d_t.fabudocno
                  AND fabuseq = g_fabo3_d_t.fabuseq
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabu_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                  #INITIALIZE gs_keys TO NULL 
                  #LET gs_keys[1] = g_fabo3_d[g_detail_idx].fabuld
                  #LET gs_keys_bak[1] = g_fabo3_d_t.fabuld
                  #LET gs_keys[2] = g_fabo3_d[g_detail_idx].fabudocno
                  #LET gs_keys_bak[2] = g_fabo3_d_t.fabudocno
                  #LET gs_keys[3] = g_fabo3_d[g_detail_idx].fabuseq
                  #LET gs_keys_bak[3] = g_fabo3_d_t.fabuseq
                  #CALL afat505_01_update_b('fabu_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄
                     LET g_log1 = util.JSON.stringify(g_fabo3_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後
               #產生新的卡片資料
               CALL afat505_01_faah_ins()
#               LET la_param.prog = 'afai100'
#               LET la_param.param[1] = g_faah000
#               LET la_param.param[2] = g_faah001
#               LET la_param.param[3] = g_fabo001
#               LET la_param.param[4] = g_fabo002
#               LET ls_js = util.JSON.stringify(la_param)
#               CALL cl_cmdrun(ls_js)
               #end add-point
            END IF
         
         
         #此段落由子樣板a02產生
         AFTER FIELD fabu006
            IF NOT cl_null(g_fabo3_d[l_ac].fabu006) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo3_d[l_ac].fabu006 <> g_fabo3_d_t.fabu006 OR cl_null(g_fabo3_d_t.fabu006))) THEN
                  IF NOT cl_null(g_fabo3_d[l_ac].fabu009) THEN          
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                                    g_fabo3_d[l_ac].fabu006 * g_fabo007,g_fabo3_d[l_ac].fabu009,
                                    g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
                       RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                     
                     LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
                     LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
                     LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
                     LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
                     LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
                     LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
                     LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
                     LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
                     LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
                     LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
                     LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
                     LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld AND glaaent = g_enterprise #160905-00007#2 add
                  END IF
                  LET g_fabo3_d[l_ac].fabu012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu012,2)
                  LET g_fabo3_d[l_ac].fabu013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu013,2)
                  LET g_fabo3_d[l_ac].fabu014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu014,2)
                  LET g_fabo3_d[l_ac].fabu015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu015,2)
                  LET g_fabo3_d[l_ac].fabu016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu016,2)
                  LET g_fabo3_d[l_ac].fabu017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu017,2) 
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu103) THEN
                     LET g_fabo8_d[l_ac].fabu103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu103,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu104) THEN
                     LET g_fabo8_d[l_ac].fabu104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu104,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu105) THEN
                     LET g_fabo8_d[l_ac].fabu105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu105,2) 
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu152) THEN
                     LET g_fabo8_d[l_ac].fabu152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu152,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu153) THEN
                     LET g_fabo8_d[l_ac].fabu153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu153,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu154) THEN
                     LET g_fabo8_d[l_ac].fabu154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu154,2)
                  END IF
               END IF
            END IF
            
         AFTER FIELD fabu012
            IF NOT cl_null(g_fabo3_d[l_ac].fabu012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo3_d[l_ac].fabu012 <> g_fabo3_d_t.fabu012 OR cl_null(g_fabo3_d_t.fabu012))) THEN
                  IF NOT cl_null(g_fabo3_d[l_ac].fabu009) THEN          
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                                    g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu009,
                                    g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
                       RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                     
                     LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
                     LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
                     LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
                     LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
                     LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
                     LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
                     LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
                     LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
                     LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
                     LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
                     LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
                     LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld   #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld AND glaaent = g_enterprise #160905-00007#2 add
                  END IF
                  LET g_fabo3_d[l_ac].fabu012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu012,2)
                  LET g_fabo3_d[l_ac].fabu013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu013,2)
                  LET g_fabo3_d[l_ac].fabu014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu014,2)
                  LET g_fabo3_d[l_ac].fabu015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu015,2)
                  LET g_fabo3_d[l_ac].fabu016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu016,2)
                  LET g_fabo3_d[l_ac].fabu017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu017,2) 
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu103) THEN
                     LET g_fabo8_d[l_ac].fabu103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu103,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu104) THEN
                     LET g_fabo8_d[l_ac].fabu104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu104,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu105) THEN
                     LET g_fabo8_d[l_ac].fabu105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu105,2) 
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu152) THEN
                     LET g_fabo8_d[l_ac].fabu152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu152,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu153) THEN
                     LET g_fabo8_d[l_ac].fabu153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu153,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu154) THEN
                     LET g_fabo8_d[l_ac].fabu154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu154,2)
                  END IF
               END IF
            END IF
            
         AFTER FIELD fabu014
            IF NOT cl_null(g_fabo3_d[l_ac].fabu014) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo3_d[l_ac].fabu014 <> g_fabo3_d_t.fabu014 OR cl_null(g_fabo3_d_t.fabu014))) THEN
                 #CALL afat505_01_amt_chk()
                  IF NOT cl_null(g_fabo3_d[l_ac].fabu009) THEN          
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                                    g_fabo3_d[l_ac].fabu014,g_fabo3_d[l_ac].fabu009,
                                    g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
                       RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135 
                     LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
                     LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
                     LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
                     LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
                     LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
                     LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
                     LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
                     LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
                     LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
                     LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
                     LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
                     LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
                  
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp  FROM glaa_t WHERE glaald = g_fabgld  #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp  FROM glaa_t WHERE glaald = g_fabgld AND glaaent = g_enterprise #160905-00007#2 add
                  END IF
                  LET g_fabo3_d[l_ac].fabu012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu012,2)
                  LET g_fabo3_d[l_ac].fabu013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu013,2)
                  LET g_fabo3_d[l_ac].fabu014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu014,2)
                  LET g_fabo3_d[l_ac].fabu015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu015,2)
                  LET g_fabo3_d[l_ac].fabu016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu016,2)
                  LET g_fabo3_d[l_ac].fabu017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu017,2) 
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu103) THEN
                     LET g_fabo8_d[l_ac].fabu103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu103,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu104) THEN
                     LET g_fabo8_d[l_ac].fabu104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu104,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu105) THEN
                     LET g_fabo8_d[l_ac].fabu105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu105,2) 
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu152) THEN
                     LET g_fabo8_d[l_ac].fabu152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu152,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu153) THEN
                     LET g_fabo8_d[l_ac].fabu153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu153,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu154) THEN
                     LET g_fabo8_d[l_ac].fabu154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu154,2)
                  END IF
               END IF
            END IF
         
         AFTER FIELD fabu017
           #CALL afat505_01_amt_chk()
         
         AFTER FIELD fabu009
            
            #add-point:AFTER FIELD fabu009
            IF NOT cl_null(g_fabo3_d[l_ac].fabu009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_fabo3_d[l_ac].fabu009
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"    #160318-00025#13      
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #20141114 add--str-- by chenying 
                                              #日期;            來源幣別          目的幣別; 匯類類型
                  CALL afat505_01_get_exrate(g_fabgdocdt,g_fabo3_d[l_ac].fabu010,g_glaa001,g_glaa025) 
                  RETURNING g_fabo3_d[l_ac].fabu011

                  #本位幣二匯率
                  IF g_glaa015 = 'Y' THEN
                     IF g_glaa017 = '1' THEN 
                        LET l_ooam003 = g_fabo3_d[l_ac].fabu010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                        
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa016,g_glaa018) 
                     RETURNING g_fabo8_d[l_ac].fabu102
                  ELSE
                     LET g_fabo8_d[l_ac].fabu102 = 0
                  END IF
                     
                  #本位幣三匯率
                  IF g_glaa019 = 'Y' THEN  
                     IF g_glaa021 = '1' THEN 
                        LET l_ooam003 = g_fabo3_d[l_ac].fabu010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                     
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa020,g_glaa022) 
                     RETURNING g_fabo8_d[l_ac].fabu151                               
                  ELSE
                     LET g_fabo8_d[l_ac].fabu151 = 0
                  END IF 
                  #20141114 add--end--                  
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo3_d[l_ac].fabu009 = g_fabo3_d_t.fabu009
                  NEXT FIELD CURRENT
               END IF
               
              
               CALL s_tax_chk(g_glaacomp,g_fabo3_d[l_ac].fabu009)
                RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
               
               CALL afat505_01_fabu009_set_entry(l_oodb005)

            END IF 
            
            IF NOT cl_null(g_fabo3_d[l_ac].fabu009) AND NOT cl_null(g_fabo3_d[l_ac].fabu010) THEN
               IF NOT cl_null(g_fabo3_d[l_ac].fabu014) AND NOT cl_null(g_fabo007) THEN 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo3_d[l_ac].fabu009 <> g_fabo3_d_t.fabu009 OR cl_null(g_fabo3_d_t.fabu009))) THEN           
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                                    g_fabo3_d[l_ac].fabu006 * g_fabo007,g_fabo3_d[l_ac].fabu009,
                                    g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
                       RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135         

                     #抓取交易稅明細檔的科目
                     LET l_glab005 = ''
                     SELECT glab005 INTO l_glab005 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_fabgld
                        AND glab001 = '14' 
                        AND glab002 = '1'   #-进項
                        AND glab003 =  g_fabo3_d[l_ac].fabu009  #--稅別
                   
                     IF cl_null(l_glab005) THEN   #取不到會科時表示以常用會科設定 (agli160) 
                        SELECT glab005 INTO l_glab005 FROM glab_t 
                         WHERE glabent = g_enterprise
                           and glabld  = g_fabgld
                           AND glab001 = '12' 
                           AND glab002 = '9711' 
                           AND glab003 = '9711_91' 
                     END IF 
                      
                     LET g_fabo6_d[l_ac].xrcd009 = l_glab005
                     
                     UPDATE xrcd_t SET xrcd009 = g_fabo6_d[l_ac].xrcd009
                      WHERE xrcdent   = g_enterprise
                        AND xrcdld    = g_fabgld
                        AND xrcddocno = g_fabgdocno
                        AND xrcdseq   = g_faboseq
                        AND xrcdseq2  = 2
                     
                     LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
                     LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
                     LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
                     LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
                     LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
                     LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
                     LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
                     LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
                     LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
                     LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
                     LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
                     LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
                  END IF
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  AND glaaent = g_enterprise #160905-00007#2 add
                  END IF
                  LET g_fabo3_d[l_ac].fabu012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu012,2)
                  LET g_fabo3_d[l_ac].fabu013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu013,2)
                  LET g_fabo3_d[l_ac].fabu014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu014,2)
                  LET g_fabo3_d[l_ac].fabu015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu015,2)
                  LET g_fabo3_d[l_ac].fabu016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu016,2)
                  LET g_fabo3_d[l_ac].fabu017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu017,2) 
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu103) THEN
                     LET g_fabo8_d[l_ac].fabu103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu103,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu104) THEN
                     LET g_fabo8_d[l_ac].fabu104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu104,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu105) THEN
                     LET g_fabo8_d[l_ac].fabu105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu105,2) 
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu152) THEN
                     LET g_fabo8_d[l_ac].fabu152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu152,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu153) THEN
                     LET g_fabo8_d[l_ac].fabu153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu153,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu154) THEN
                     LET g_fabo8_d[l_ac].fabu154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu154,2)
                  END IF
               END IF
            END IF
            #END add-point   
            
         #此段落由子樣板a02產生
         AFTER FIELD fabu010
            
            #add-point:AFTER FIELD fabu010
            IF NOT cl_null(g_fabo3_d[l_ac].fabu010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"    #160318-00025#13   
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo3_d[l_ac].fabu010

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                                              #日期;            來源幣別          目的幣別; 匯類類型
                  CALL afat505_01_get_exrate(g_fabgdocdt,g_fabo3_d[l_ac].fabu010,g_glaa001,g_glaa025) 
                  RETURNING g_fabo3_d[l_ac].fabu011

                  #本位幣二匯率
                  IF g_glaa015 = 'Y' THEN
                     IF g_glaa017 = '1' THEN 
                        LET l_ooam003 = g_fabo3_d[l_ac].fabu010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                        
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa016,g_glaa018) 
                     RETURNING g_fabo8_d[l_ac].fabu102
                  ELSE
                     LET g_fabo8_d[l_ac].fabu102 = 0
                  END IF
                     
                  #本位幣三匯率
                  IF g_glaa019 = 'Y' THEN  
                     IF g_glaa021 = '1' THEN 
                        LET l_ooam003 = g_fabo3_d[l_ac].fabu010
                     ELSE
                        LET l_ooam003 = g_glaa001
                     END IF
                     
                                                    #日期;  來源幣別    目的幣別; 匯類類型
                     CALL afat505_01_get_exrate(g_fabgdocdt,l_ooam003,g_glaa020,g_glaa022) 
                     RETURNING g_fabo8_d[l_ac].fabu151                               
                  ELSE
                     LET g_fabo8_d[l_ac].fabu151 = 0
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo3_d[l_ac].fabu010 = g_fabo3_d_t.fabu010
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            IF NOT cl_null(g_fabo3_d[l_ac].fabu009) AND NOT cl_null(g_fabo3_d[l_ac].fabu010) THEN
               IF NOT cl_null(g_fabo3_d[l_ac].fabu014) AND NOT cl_null(g_fabo007) THEN 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo3_d[l_ac].fabu010 <> g_fabo3_d_t.fabu010 OR cl_null(g_fabo3_d_t.fabu010))) THEN           
                     IF cl_null(g_fabo3_d[l_ac].fabu006) THEN LET g_fabo3_d[l_ac].fabu006 = 0 END IF 
                     CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                                    g_fabo3_d[l_ac].fabu006 * g_fabo007,g_fabo3_d[l_ac].fabu009,
                                    g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
                       RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135  

                       LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
                       LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
                       LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
                       LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
                       LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
                       LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
                       LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
                       LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
                       LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
                       LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
                       LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
                       LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
                       

                  END IF
                  CALL afat505_01_amt_chk()
                  #若傳入帳別，表示是由財務端再引用元件，因此 應該以財務端的帳套本幣為取用基準
                  IF NOT cl_null( g_fabgld) THEN
                     #SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld   #160905-00007#2 mark
                     SELECT glaa001,glaacomp INTO l_ooef016,l_fabgcomp FROM glaa_t WHERE glaald = g_fabgld  AND glaaent = g_enterprise #160905-00007#2 add
                  END IF
                  LET g_fabo3_d[l_ac].fabu012 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu012,2)
                  LET g_fabo3_d[l_ac].fabu013 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu013,2)
                  LET g_fabo3_d[l_ac].fabu014 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu014,2)
                  LET g_fabo3_d[l_ac].fabu015 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu015,2)
                  LET g_fabo3_d[l_ac].fabu016 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu016,2)
                  LET g_fabo3_d[l_ac].fabu017 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo3_d[l_ac].fabu017,2) 
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu103) THEN
                     LET g_fabo8_d[l_ac].fabu103 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu103,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu104) THEN
                     LET g_fabo8_d[l_ac].fabu104 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu104,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu105) THEN
                     LET g_fabo8_d[l_ac].fabu105 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu105,2) 
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu152) THEN
                     LET g_fabo8_d[l_ac].fabu152 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu152,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu153) THEN
                     LET g_fabo8_d[l_ac].fabu153 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu153,2)
                  END IF
                  IF NOT cl_null(g_fabo8_d[l_ac].fabu154) THEN
                     LET g_fabo8_d[l_ac].fabu154 = s_curr_round(l_fabgcomp,l_ooef016,g_fabo8_d[l_ac].fabu154,2)
                  END IF
               END IF
               
            END IF
            
            #END add-point   
         
         #Ctrlp:input.c.page1.fabu009
         ON ACTION controlp INFIELD fabu009
            #add-point:ON ACTION controlp INFIELD fabu009
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo3_d[l_ac].fabu009             #給予default值
            LET g_qryparam.where = " oodb004 = '1'"
            #給予arg
            LET g_qryparam.arg1 = g_ooef019

            
            CALL q_oodb002_5()                                #呼叫開窗

            LET g_fabo3_d[l_ac].fabu009 = g_qryparam.return1              

            DISPLAY g_fabo3_d[l_ac].fabu009 TO fabu009              #

            NEXT FIELD fabu009                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page1.fabu010
         ON ACTION controlp INFIELD fabu010
            #add-point:ON ACTION controlp INFIELD fabu010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo3_d[l_ac].fabu010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_fabo3_d[l_ac].fabu010 = g_qryparam.return1              

            DISPLAY g_fabo3_d[l_ac].fabu010 TO fabu010              #

            NEXT FIELD fabu010                          #返回原欄位


            #END add-point
         
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo3_d[l_ac].* = g_fabo3_d_t.*
               END IF
               CLOSE afat505_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("fabu_t")
            CALL s_transaction_end('Y','0')
            #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後

            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_fabo3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabo3_d.getLength()+1
 
      END INPUT   
      
      INPUT ARRAY g_fabo4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo4_d.getLength()
 
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabuld
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo4_d[l_ac].* TO NULL 
            INITIALIZE g_fabo4_d_t.* TO NULL
            INITIALIZE g_fabo4_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份

            #end add-point
            LET g_fabo4_d_t.* = g_fabo4_d[l_ac].*     #新輸入資料
            LET g_fabo4_d_o.* = g_fabo4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat505_01_set_entry_b("a")
            CALL afat505_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo3_d[li_reproduce_target].* = g_fabo3_d[li_reproduce].*
               LET g_fabo4_d[li_reproduce_target].* = g_fabo4_d[li_reproduce].*
               LET g_fabo8_d[li_reproduce_target].* = g_fabo8_d[li_reproduce].*
 
               LET g_fabo4_d[li_reproduce_target].fabuld = NULL
               LET g_fabo4_d[li_reproduce_target].fabudocno = NULL
               LET g_fabo4_d[li_reproduce_target].fabuseq = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo4_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo4_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo4_d[l_ac].fabuld IS NOT NULL
               AND g_fabo4_d[l_ac].fabudocno IS NOT NULL
               AND g_fabo4_d[l_ac].fabuseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo4_d_t.* = g_fabo4_d[l_ac].*  #BACKUP
               LET g_fabo4_d_o.* = g_fabo4_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("fabu_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl2 INTO g_fabo3_d[l_ac].fabudocno,g_fabo3_d[l_ac].fabuld,g_fabo3_d[l_ac].fabuseq,g_fabo3_d[l_ac].fabu009,
                                             g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu006,g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu013,g_fabo3_d[l_ac].fabu014,
                                             g_fabo3_d[l_ac].fabu015,g_fabo3_d[l_ac].fabu016,g_fabo3_d[l_ac].fabu017,g_fabo3_d[l_ac].fabu011,
                                             g_fabo4_d[l_ac].fabudocno,g_fabo4_d[l_ac].fabuld,g_fabo4_d[l_ac].fabuseq,g_fabo4_d[l_ac].fabu022,
                                             g_fabo4_d[l_ac].fabu035,g_fabo4_d[l_ac].fabu024,g_fabo4_d[l_ac].fabu025,g_fabo4_d[l_ac].fabu026,
                                             g_fabo4_d[l_ac].fabu027,g_fabo4_d[l_ac].fabu028,g_fabo4_d[l_ac].fabu029,g_fabo4_d[l_ac].fabu030,
                                             g_fabo4_d[l_ac].fabu031,g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033,
                                             g_fabo8_d[l_ac].fabudocno,g_fabo8_d[l_ac].fabuld,g_fabo8_d[l_ac].fabuseq,g_fabo8_d[l_ac].fabu106,
                                             g_fabo8_d[l_ac].fabu101,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu107,g_fabo8_d[l_ac].fabu103,
                                             g_fabo8_d[l_ac].fabu104,g_fabo8_d[l_ac].fabu105,g_fabo8_d[l_ac].fabu155,g_fabo8_d[l_ac].fabu150,
                                             g_fabo8_d[l_ac].fabu151,g_fabo8_d[l_ac].fabu156,g_fabo8_d[l_ac].fabu152,g_fabo8_d[l_ac].fabu153,
                                             g_fabo8_d[l_ac].fabu154
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            #20141113 add--str--by chenying 
            #预设调入/调出所有组织默认税别，币别
            IF cl_null(g_fabo3_d[l_ac].fabu010) AND l_ac > 0 THEN 
               SELECT ooef016 INTO g_fabo3_d[l_ac].fabu010 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo047 
            END IF
            
            IF cl_null(g_fabo3_d[l_ac].fabu009) AND l_ac > 0 THEN
               LET l_ooef019 = NULL            
               SELECT ooef019 INTO l_ooef019 FROM ooef_t 
                WHERE ooefent = g_enterprise 
                  AND ooef001 = g_fabo047 
               SELECT oodb002 INTO g_fabo3_d[l_ac].fabu009 FROM oodb_t
                WHERE oodbent = g_enterprise AND oodb001 = l_ooef019               
            END IF            
            #20141113 add--end--  
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前

               #end add-point 
            
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
               
               #add-point:單身2刪除前

               #end add-point 
               
               DELETE FROM fabu_t
                WHERE fabuent = g_enterprise 
                  AND fabuld = g_fabo4_d_t.fabuld
                  AND fabudocno = g_fabo4_d_t.fabudocno
                  AND fabuseq = g_fabo4_d_t.fabuseq
                  
               #add-point:單身2刪除中

               #end add-point 
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabu_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat505_01_bcl2
               LET l_count = g_fabo3_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo4_d[g_detail_idx].fabuld
               LET gs_keys[2] = g_fabo4_d[g_detail_idx].fabudocno
               LET gs_keys[3] = g_fabo4_d[g_detail_idx].fabuseq
 
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
               CALL afat505_01_delete_b('fabu_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM fabu_t 
             WHERE fabuent = g_enterprise 
               AND fabuld = g_fabo4_d[l_ac].fabuld
               AND fabudocno = g_fabo4_d[l_ac].fabudocno
               AND fabuseq = g_fabo4_d[l_ac].fabuseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo4_d[g_detail_idx].fabuld
               LET gs_keys[2] = g_fabo4_d[g_detail_idx].fabudocno
               LET gs_keys[3] = g_fabo4_d[g_detail_idx].fabuseq
               CALL afat505_01_insert_b('fabu_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabo4_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabu_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (fabuld = '", g_fabo4_d[l_ac].fabuld, "' "
                                  ," AND fabudocno = '", g_fabo4_d[l_ac].fabudocno, "' "
                                  ," AND fabuseq = '", g_fabo4_d[l_ac].fabuseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo4_d[l_ac].* = g_fabo4_d_t.*
               CLOSE afat505_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo4_d[l_ac].* = g_fabo4_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前
              #CALL afat505_01_amt_chk()
               #end add-point
               
               UPDATE fabu_t SET (fabudocno,fabuld,fabuseq,fabu009,fabu006,fabu010,fabu012,fabu013,fabu014,fabu015, 
                   fabu016,fabu017,fabu011,fabu022,fabu035,fabu024,fabu025,fabu026,fabu027,fabu028, 
                   fabu029,fabu030,fabu031,fabu032,fabu033,fabu106,fabu101,fabu102,fabu107, 
                   fabu103,fabu104,fabu105,fabu155,fabu150,fabu151,fabu156,fabu152,fabu153,fabu154) 
                   = (g_fabo3_d[l_ac].fabudocno,g_fabo3_d[l_ac].fabuld,g_fabo3_d[l_ac].fabuseq,g_fabo3_d[l_ac].fabu009,g_fabo3_d[l_ac].fabu006,
                   g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu013,g_fabo3_d[l_ac].fabu014,
                   g_fabo3_d[l_ac].fabu015,g_fabo3_d[l_ac].fabu016,g_fabo3_d[l_ac].fabu017,g_fabo3_d[l_ac].fabu011,
                   g_fabo4_d[l_ac].fabu022,g_fabo4_d[l_ac].fabu035,g_fabo4_d[l_ac].fabu024,g_fabo4_d[l_ac].fabu025,
                   g_fabo4_d[l_ac].fabu026,g_fabo4_d[l_ac].fabu027,g_fabo4_d[l_ac].fabu028,g_fabo4_d[l_ac].fabu029,
                   g_fabo4_d[l_ac].fabu030,g_fabo4_d[l_ac].fabu031,g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033,
                   g_fabo8_d[l_ac].fabu106,g_fabo8_d[l_ac].fabu101,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu107,
                   g_fabo8_d[l_ac].fabu103,g_fabo8_d[l_ac].fabu104,g_fabo8_d[l_ac].fabu105,g_fabo8_d[l_ac].fabu155,
                   g_fabo8_d[l_ac].fabu150,g_fabo8_d[l_ac].fabu151,g_fabo8_d[l_ac].fabu156,g_fabo8_d[l_ac].fabu152,
                   g_fabo8_d[l_ac].fabu153,g_fabo8_d[l_ac].fabu154) #自訂欄位頁簽
                WHERE fabuent = g_enterprise AND
                  fabuld = g_fabo4_d_t.fabuld #項次 
                  AND fabudocno = g_fabo4_d_t.fabudocno
                  AND fabuseq = g_fabo4_d_t.fabuseq
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabu_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                  #INITIALIZE gs_keys TO NULL 
                  #LET gs_keys[1] = g_fabo4_d[g_detail_idx].fabuld
                  #LET gs_keys_bak[1] = g_fabo4_d_t.fabuld
                  #LET gs_keys[2] = g_fabo4_d[g_detail_idx].fabudocno
                  #LET gs_keys_bak[2] = g_fabo4_d_t.fabudocno
                  #LET gs_keys[3] = g_fabo4_d[g_detail_idx].fabuseq
                  #LET gs_keys_bak[3] = g_fabo4_d_t.fabuseq
                  #CALL afat505_01_update_b('fabu_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄
                     LET g_log1 = util.JSON.stringify(g_fabo4_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後
               #產生新的卡片資料
               CALL afat505_01_faah_ins()
               LET la_param.prog = 'afai100'
#               LET la_param.param[1] = g_faah000
#               LET la_param.param[2] = g_faah001
#               LET la_param.param[3] = g_fabo001
#               LET la_param.param[4] = g_fabo002
#               LET ls_js = util.JSON.stringify(la_param)
#               CALL cl_cmdrun(ls_js)
               #end add-point
            END IF
            
         
         
         #此段落由子樣板a02產生
         AFTER FIELD fabu022
            
            #add-point:AFTER FIELD fabu024
            CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
            DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu022) THEN 
                 #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject( g_fabo3_d[l_ac].fabuld,g_fabo4_d[l_ac].fabu022,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald =  g_fabo3_d[l_ac].fabuld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 =g_fabo4_d[l_ac].fabu022
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabo4_d[l_ac].fabu022
                LET g_qryparam.arg3 =  g_fabo3_d[l_ac].fabuld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fabo4_d[l_ac].fabu022 = g_qryparam.return1              
                CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
                DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
                DISPLAY g_fabo4_d[l_ac].fabu022 TO fabu022
                
              END IF
                IF  NOT s_aglt310_lc_subject( g_fabo3_d[l_ac].fabuld,g_fabo4_d[l_ac].fabu022,'N') THEN
                       LET g_fabo4_d[l_ac].fabu022 = g_fabo4_d_t.fabu022
                  CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
                  DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
                  NEXT FIELD CURRENT
                END IF
              #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabo4_d[l_ac].fabu022
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu022 = g_fabo4_d_t.fabu022
                  CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
                  DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabu022
            #add-point:BEFORE FIELD fabu024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE fabu022
            #add-point:ON CHANGE fabu024

            #END add-point
 
         
        #此段落由子樣板a01產生
         BEFORE FIELD fabu024_desc
            #add-point:BEFORE FIELD fabo031_desc
            LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d[l_ac].fabu024
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu024_desc
            
            #add-point:AFTER FIELD fabo031_desc
            LET g_fabo4_d[l_ac].fabu024 = g_fabo4_d[l_ac].fabu024_desc
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu024) RETURNING g_fabo4_d[l_ac].fabu024_desc
            LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d[l_ac].fabu024 CLIPPED,g_fabo4_d[l_ac].fabu024_desc
            DISPLAY g_fabo4_d[l_ac].fabu024_desc TO s_detail4[l_ac].fabu024_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu024) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu024   
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu024 = g_fabo4_d_t.fabu024
                  LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d_t.fabu024_desc
                  CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu024) RETURNING g_fabo4_d[l_ac].fabu024_desc
                  LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d[l_ac].fabu024 CLIPPED,g_fabo4_d[l_ac].fabu024_desc
                  DISPLAY g_fabo4_d[l_ac].fabu024_desc TO s_detail2[l_ac].fabu024_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu025_desc
            #add-point:BEFORE FIELD fabu025_desc
            LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d[l_ac].fabu025
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu025_desc
            
            #add-point:AFTER FIELD fabu025_desc
            LET g_fabo4_d[l_ac].fabu025 = g_fabo4_d[l_ac].fabu025_desc
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu025) RETURNING g_fabo4_d[l_ac].fabu025_desc
            LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d[l_ac].fabu025 CLIPPED,g_fabo4_d[l_ac].fabu025_desc
            DISPLAY g_fabo4_d[l_ac].fabu025_desc TO s_detail4[l_ac].fabu025_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu025) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu025
               LET g_chkparam.arg2 = g_today  
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
               LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu025 = g_fabo4_d_t.fabu025
                  LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d_t.fabu025_desc
                  CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu025) RETURNING g_fabo4_d[l_ac].fabu025_desc
                  LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d[l_ac].fabu025 CLIPPED,g_fabo4_d[l_ac].fabu025_desc
                  DISPLAY g_fabo4_d[l_ac].fabu025_desc TO s_detail4[l_ac].fabu025_desc
                  NEXT FIELD CURRENT
               END IF          
            END IF
            #END add-point
            
        #此段落由子樣板a01產生
         BEFORE FIELD fabu026_desc
            #add-point:BEFORE FIELD fabu026_desc
            LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d[l_ac].fabu026
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu026_desc
            
            #add-point:AFTER FIELD fabu026_desc
            LET g_fabo4_d[l_ac].fabu026 = g_fabo4_d[l_ac].fabu026_desc
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu026) RETURNING g_fabo4_d[l_ac].fabu026_desc
            LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d[l_ac].fabu026 CLIPPED,g_fabo4_d[l_ac].fabu026_desc
            DISPLAY g_fabo4_d[l_ac].fabu026_desc TO s_detail4[l_ac].fabu026_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu026) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu026
               LET g_chkparam.arg2 = g_today  
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
               LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu026 = g_fabo4_d_t.fabu026
                  LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d_t.fabu026_desc
                  CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu026) RETURNING g_fabo4_d[l_ac].fabu026_desc
                  LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d[l_ac].fabu026 CLIPPED,g_fabo4_d[l_ac].fabu026_desc
                  DISPLAY g_fabo4_d[l_ac].fabu026_desc TO s_detail4[l_ac].fabu026_desc
                  NEXT FIELD CURRENT
               END IF
            END IF   
            #END add-point
            
        #此段落由子樣板a01產生
         BEFORE FIELD fabu027_desc
            #add-point:BEFORE FIELD fabu027_desc
            LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d[l_ac].fabu027
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu027_desc
            
            #add-point:AFTER FIELD fabu027_desc
            LET g_fabo4_d[l_ac].fabu027 = g_fabo4_d[l_ac].fabu027_desc
            CALL afat505_01_fabo034_desc('287',g_fabo4_d[l_ac].fabu027) RETURNING g_fabo4_d[l_ac].fabu027_desc
            LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d[l_ac].fabu027 CLIPPED,g_fabo4_d[l_ac].fabu027_desc
            DISPLAY g_fabo4_d[l_ac].fabu027_desc TO s_detail4[l_ac].fabu027_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu027) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL            
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu027   
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"    #160318-00025#13                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_287") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu027 = g_fabo4_d_t.fabu027
                  LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d_t.fabu027_desc
                  CALL afat505_01_fabo034_desc('287',g_fabo4_d[l_ac].fabu027) RETURNING g_fabo4_d[l_ac].fabu027_desc
                  LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d[l_ac].fabu027 CLIPPED,g_fabo4_d[l_ac].fabu027_desc
                  DISPLAY g_fabo4_d[l_ac].fabu027_desc TO s_detail4[l_ac].fabu027_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu028_desc
            #add-point:BEFORE FIELD fabu028_desc
            LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d[l_ac].fabu028
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu028_desc
            
            #add-point:AFTER FIELD fabu028_desc
            LET g_fabo4_d[l_ac].fabu028 = g_fabo4_d[l_ac].fabu028_desc
            CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu028) RETURNING g_fabo4_d[l_ac].fabu028_desc
            LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d[l_ac].fabu028 CLIPPED,g_fabo4_d[l_ac].fabu028_desc
            DISPLAY g_fabo4_d[l_ac].fabu028_desc TO s_detail4[l_ac].fabu028_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu028) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu028
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu028 = g_fabo4_d_t.fabu028
                  LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d_t.fabu028_desc
                  CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu028) RETURNING g_fabo4_d[l_ac].fabu028_desc
                  LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d[l_ac].fabu028 CLIPPED,g_fabo4_d[l_ac].fabu028_desc
                  DISPLAY g_fabo4_d[l_ac].fabu028_desc TO s_detail4[l_ac].fabu028_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu029_desc
            #add-point:BEFORE FIELD fabu029_desc
            LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d[l_ac].fabu029
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu029_desc
            
            #add-point:AFTER FIELD fabu029_desc
            LET g_fabo4_d[l_ac].fabu029 = g_fabo4_d[l_ac].fabu029_desc
            CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu029) RETURNING g_fabo4_d[l_ac].fabu029_desc
            LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d[l_ac].fabu029 CLIPPED,g_fabo4_d[l_ac].fabu029_desc
            DISPLAY g_fabo4_d[l_ac].fabu029_desc TO s_detail4[l_ac].fabu029_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu029) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu029
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu029 = g_fabo4_d_t.fabu029
                  LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d_t.fabu029_desc
                  CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu029) RETURNING g_fabo4_d[l_ac].fabu029_desc
                  LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d[l_ac].fabu029 CLIPPED,g_fabo4_d[l_ac].fabu029_desc
                  DISPLAY g_fabo4_d[l_ac].fabu029_desc TO s_detail4[l_ac].fabu029_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu030_desc
            #add-point:BEFORE FIELD fabu030_desc
            LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d[l_ac].fabu030
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu030_desc
            
            #add-point:AFTER FIELD fabu030_desc
            LET g_fabo4_d[l_ac].fabu030 = g_fabo4_d[l_ac].fabu030_desc
            CALL afat505_01_fabo034_desc('281',g_fabo4_d[l_ac].fabu030) RETURNING g_fabo4_d[l_ac].fabu030_desc
            LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d[l_ac].fabu030 CLIPPED,g_fabo4_d[l_ac].fabu030_desc
            DISPLAY g_fabo4_d[l_ac].fabu030_desc TO s_detail4[l_ac].fabu030_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu030) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu030   
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"    #160318-00025#13
               LET g_chkparam.err_str[2] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"    #160318-00025#13                               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu030 = g_fabo4_d_t.fabu030
                  LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d_t.fabu030_desc
                  CALL afat505_01_fabo034_desc('281',g_fabo4_d[l_ac].fabu030) RETURNING g_fabo4_d[l_ac].fabu030_desc
                  LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d[l_ac].fabu030 CLIPPED,g_fabo4_d[l_ac].fabu030_desc
                  DISPLAY g_fabo4_d[l_ac].fabu030_desc TO s_detail4[l_ac].fabu030_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu031_desc
            #add-point:BEFORE FIELD fabu031_desc
            LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d[l_ac].fabu031
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu031_desc
            
            #add-point:AFTER FIELD fabu031_desc
            LET g_fabo4_d[l_ac].fabu031 = g_fabo4_d[l_ac].fabu031_desc
            CALL afat505_01_fabo038_desc(g_fabo4_d[l_ac].fabu031) RETURNING g_fabo4_d[l_ac].fabu031_desc
            LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d[l_ac].fabu031 CLIPPED,g_fabo4_d[l_ac].fabu031_desc
            DISPLAY g_fabo4_d[l_ac].fabu031_desc TO s_detail4[l_ac].fabu031_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu031
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu031 = g_fabo4_d_t.fabu031
                  LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d_t.fabu031_desc
                  CALL afat505_01_fabo038_desc(g_fabo4_d[l_ac].fabu031) RETURNING g_fabo4_d[l_ac].fabu031_desc
                  LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d[l_ac].fabu031 CLIPPED,g_fabo4_d[l_ac].fabu031_desc
                  DISPLAY g_fabo4_d[l_ac].fabu031_desc TO s_detail4[l_ac].fabu031_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu032_desc
            #add-point:BEFORE FIELD fabu032_desc
            LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d[l_ac].fabu032
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu032_desc
            
            #add-point:AFTER FIELD fabu032_desc
            LET g_fabo4_d[l_ac].fabu032 = g_fabo4_d[l_ac].fabu032_desc
            CALL afat505_01_fabo039_desc(g_fabo4_d[l_ac].fabu032) RETURNING g_fabo4_d[l_ac].fabu032_desc
            LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d[l_ac].fabu032 CLIPPED,g_fabo4_d[l_ac].fabu032_desc
            DISPLAY g_fabo4_d[l_ac].fabu032_desc TO s_detail4[l_ac].fabu032_desc
            IF NOT cl_null(g_fabo4_d[l_ac].fabu032) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu032 
            
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"    #160318-00025#13      
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu032 = g_fabo4_d_t.fabu032
                  LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d_t.fabu032_desc
                  CALL afat505_01_fabo039_desc(g_fabo4_d[l_ac].fabu032) RETURNING g_fabo4_d[l_ac].fabu032_desc
                  LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d[l_ac].fabu032 CLIPPED,g_fabo4_d[l_ac].fabu032_desc
                  DISPLAY g_fabo4_d[l_ac].fabu032_desc TO s_detail4[l_ac].fabu032_desc
                  NEXT FIELD CURRENT
               END IF         
            END IF 
            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabu033_desc
            #add-point:BEFORE FIELD fabu033_desc
            LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d[l_ac].fabu033
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabu033_desc
            
            #add-point:AFTER FIELD fabu033_desc
            LET g_fabo4_d[l_ac].fabu033 = g_fabo4_d[l_ac].fabu033_desc
            CALL afat505_01_fabo040_desc(g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033) RETURNING g_fabo4_d[l_ac].fabu033_desc
            LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d[l_ac].fabu033 CLIPPED,g_fabo4_d[l_ac].fabu033_desc
            DISPLAY g_fabo4_d[l_ac].fabu033_desc TO s_detail4[l_ac].fabu033_desc 
            IF NOT cl_null(g_fabo4_d[l_ac].fabu033) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo4_d[l_ac].fabu032
               LET g_chkparam.arg2 = g_fabo4_d[l_ac].fabu033
            
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo4_d[l_ac].fabu033 = g_fabo4_d_t.fabu033
                  LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d_t.fabu033_desc
                  CALL afat505_01_fabo040_desc(g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033) RETURNING g_fabo4_d[l_ac].fabu033_desc
                  LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d[l_ac].fabu033 CLIPPED,g_fabo4_d[l_ac].fabu033_desc
                  DISPLAY g_fabo4_d[l_ac].fabu033_desc TO s_detail4[l_ac].fabu033_desc 
                  NEXT FIELD CURRENT
               END IF         
            END IF  
            #END add-point
            
         
         #Ctrlp:input.c.page2.fabu022
         ON ACTION controlp INFIELD fabu022
            #add-point:ON ACTION controlp INFIELD fabu022
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu022             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'",
                                     " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabo2_d[l_ac].fabold,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu022 = g_qryparam.return1              
            CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
            DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
            DISPLAY g_fabo4_d[l_ac].fabu022 TO fabu022              #

            NEXT FIELD fabu022                          #返回原欄位


            #END add-point
         
         #Ctrlp:input.c.page2.fabu024_desc
         ON ACTION controlp INFIELD fabu024_desc
            #add-point:ON ACTION controlp INFIELD fabu024_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu024 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu024) RETURNING g_fabo4_d[l_ac].fabu024_desc
            LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d[l_ac].fabu024 CLIPPED,g_fabo4_d[l_ac].fabu024_desc
            DISPLAY g_fabo4_d[l_ac].fabu024_desc TO fabu024_desc              #

            NEXT FIELD fabu024_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu025_desc
         ON ACTION controlp INFIELD fabu025_desc
            #add-point:ON ACTION controlp INFIELD fabu025_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu025 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu025) RETURNING g_fabo4_d[l_ac].fabu025_desc
            LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d[l_ac].fabu025 CLIPPED,g_fabo4_d[l_ac].fabu025_desc
            DISPLAY g_fabo4_d[l_ac].fabu025_desc TO fabu025_desc              #

            NEXT FIELD fabu025_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu026_desc
         ON ACTION controlp INFIELD fabu026_desc
            #add-point:ON ACTION controlp INFIELD fabu026_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu026             #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu026 = g_qryparam.return1              
            CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu026) RETURNING g_fabo4_d[l_ac].fabu026_desc
            LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d[l_ac].fabu026 CLIPPED,g_fabo4_d[l_ac].fabu026_desc
            DISPLAY g_fabo4_d[l_ac].fabu026_desc TO fabu026_desc              #

            NEXT FIELD fabu026_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu027_desc
         ON ACTION controlp INFIELD fabu027_desc
            #add-point:ON ACTION controlp INFIELD fabu027_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '287'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu027 = g_qryparam.return1              
            CALL afat505_01_fabo034_desc('287',g_fabo4_d[l_ac].fabu027) RETURNING g_fabo4_d[l_ac].fabu027_desc
            LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d[l_ac].fabu027 CLIPPED,g_fabo4_d[l_ac].fabu027_desc
            DISPLAY g_fabo4_d[l_ac].fabu027_desc TO fabu027_desc              #

            NEXT FIELD fabu027_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu028_desc
         ON ACTION controlp INFIELD fabu028_desc
            #add-point:ON ACTION controlp INFIELD fabu028_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu028            #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo4_d[l_ac].fabu028 = g_qryparam.return1              
            CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu028) RETURNING g_fabo4_d[l_ac].fabu028_desc
            LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d[l_ac].fabu028 CLIPPED,g_fabo4_d[l_ac].fabu028_desc
            DISPLAY g_fabo4_d[l_ac].fabu028_desc TO fabu028_desc              #

            NEXT FIELD fabu028_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu029_desc
         ON ACTION controlp INFIELD fabu029_desc
            #add-point:ON ACTION controlp INFIELD fabu029_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD
         #  CALL q_pmaa001()           #160913-00017#1  mark          #呼叫開窗

            LET g_fabo4_d[l_ac].fabu029 = g_qryparam.return1              
            CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu029) RETURNING g_fabo4_d[l_ac].fabu029_desc
            LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d[l_ac].fabu029 CLIPPED,g_fabo4_d[l_ac].fabu029_desc
            DISPLAY g_fabo4_d[l_ac].fabu029_desc TO fabu029_desc              #

            NEXT FIELD fabu029_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu030_desc
         ON ACTION controlp INFIELD fabu030_desc
            #add-point:ON ACTION controlp INFIELD fabu030_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '281'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu030 = g_qryparam.return1              
            CALL afat505_01_fabo034_desc('281',g_fabo4_d[l_ac].fabu030) RETURNING g_fabo4_d[l_ac].fabu030_desc
            LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d[l_ac].fabu030 CLIPPED,g_fabo4_d[l_ac].fabu030_desc
            DISPLAY g_fabo4_d[l_ac].fabu030_desc TO fabu030_desc              #

            NEXT FIELD fabu030_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu031_desc
         ON ACTION controlp INFIELD fabu031_desc
            #add-point:ON ACTION controlp INFIELD fabu031_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_2()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu031 = g_qryparam.return1              
            CALL afat505_01_fabo038_desc(g_fabo4_d[l_ac].fabu031) RETURNING g_fabo4_d[l_ac].fabu031_desc
            LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d[l_ac].fabu031 CLIPPED,g_fabo4_d[l_ac].fabu031_desc
            DISPLAY g_fabo4_d[l_ac].fabu031_desc TO fabu031_desc              #

            NEXT FIELD fabu031_desc                          #返回原欄位


            #END add-point
            
         #Ctrlp:input.c.page2.fabu032_desc
         ON ACTION controlp INFIELD fabu032_desc
            #add-point:ON ACTION controlp INFIELD fabu032_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu032 = g_qryparam.return1              
            CALL afat505_01_fabo039_desc(g_fabo4_d[l_ac].fabu032) RETURNING g_fabo4_d[l_ac].fabu032_desc
            LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d[l_ac].fabu032 CLIPPED,g_fabo4_d[l_ac].fabu032_desc
            DISPLAY g_fabo4_d[l_ac].fabu032_desc TO fabu032_desc              #

            NEXT FIELD fabu032_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.fabu033_desc
         ON ACTION controlp INFIELD fabu033_desc
            #add-point:ON ACTION controlp INFIELD fabu033_desc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo4_d[l_ac].fabu033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fabo4_d[l_ac].fabu032

            
            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_fabo4_d[l_ac].fabu033 = g_qryparam.return1              
            CALL afat505_01_fabo040_desc(g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033) RETURNING g_fabo4_d[l_ac].fabu033_desc
            LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d[l_ac].fabu033 CLIPPED,g_fabo4_d[l_ac].fabu033_desc
            DISPLAY g_fabo4_d[l_ac].fabu033_desc TO fabu033_desc              #

            NEXT FIELD fabu033_desc                          #返回原欄位


            #END add-point
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo4_d[l_ac].* = g_fabo4_d_t.*
               END IF
               CLOSE afat505_01_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("fabu_t")
            CALL s_transaction_end('Y','0')
            #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後

            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_fabo4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabo4_d.getLength()+1
 
      END INPUT   
      
      INPUT ARRAY g_fabo5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo5_d.getLength()
 
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabuld
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo5_d[l_ac].* TO NULL 
            INITIALIZE g_fabo5_d_t.* TO NULL
            INITIALIZE g_fabo5_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            LET g_fabo5_d[l_ac].xrcd006 = "N"
            #add-point:modify段before備份

            #end add-point
            LET g_fabo5_d_t.* = g_fabo5_d[l_ac].*     #新輸入資料
            LET g_fabo5_d_o.* = g_fabo5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat505_01_set_entry_b("a")
            CALL afat505_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo5_d[li_reproduce_target].* = g_fabo5_d[li_reproduce].*
 
               LET g_fabo5_d[li_reproduce_target].xrcdld = NULL
               LET g_fabo5_d[li_reproduce_target].xrcddocno = NULL
               LET g_fabo5_d[li_reproduce_target].xrcdseq = NULL
               LET g_fabo5_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_fabo5_d[li_reproduce_target].xrcd007 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo5_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo5_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo5_d[l_ac].xrcdld IS NOT NULL
               AND g_fabo5_d[l_ac].xrcddocno IS NOT NULL
               AND g_fabo5_d[l_ac].xrcdseq IS NOT NULL
               AND g_fabo5_d[l_ac].xrcdseq2 IS NOT NULL
               AND g_fabo5_d[l_ac].xrcd007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo5_d_t.* = g_fabo5_d[l_ac].*  #BACKUP
               LET g_fabo5_d_o.* = g_fabo5_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("xrcd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl3 INTO g_fabo5_d[l_ac].xrcddocno,g_fabo5_d[l_ac].xrcdld,g_fabo5_d[l_ac].xrcdseq2,
                                             g_fabo5_d[l_ac].xrcd001,g_fabo5_d[l_ac].xrcdseq,g_fabo5_d[l_ac].xrcd007,
                                             g_fabo5_d[l_ac].xrcd002,g_fabo5_d[l_ac].xrcd003,g_fabo5_d[l_ac].xrcd006,
                                             g_fabo5_d[l_ac].xrcd103,g_fabo5_d[l_ac].xrcd104,g_fabo5_d[l_ac].xrcd105,
                                             g_fabo5_d[l_ac].xrcd113,g_fabo5_d[l_ac].xrcd114,g_fabo5_d[l_ac].xrcd115,
                                             g_fabo5_d[l_ac].xrcd009
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前

               #end add-point 
            
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
               
               #add-point:單身2刪除前

               #end add-point 
               
               DELETE FROM xrcd_t
                WHERE xrcdent = g_enterprise 
                  AND xrcddocno = g_fabo5_d_t.xrcddocno
                  AND xrcdld = g_fabo5_d_t.xrcdld
                  AND xrcdseq = g_fabo5_d_t.xrcdseq
                  AND xrcdseq2 = g_fabo5_d_t.xrcdseq2
                  AND xrcd007 = g_fabo5_d_t.xrcd007
                  
               #add-point:單身2刪除中

               #end add-point 
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcd_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat505_01_bcl3
               LET l_count = g_fabo5_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo5_d[g_detail_idx].xrcdld
               LET gs_keys[2] = g_fabo5_d[g_detail_idx].xrcddocno
               LET gs_keys[3] = g_fabo5_d[g_detail_idx].xrcdseq
 
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
               CALL afat505_01_delete_b('xrcd_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo5_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
               
            SELECT COUNT(*) INTO l_count FROM xrcd_t 
             WHERE xrcdent = g_enterprise 
               AND xrcddocno = g_fabo5_d[l_ac].xrcddocno
               AND xrcdld = g_fabo5_d[l_ac].xrcdld
               AND xrcdseq = g_fabo5_d[l_ac].xrcdseq
               AND xrcdseq2 = g_fabo5_d[l_ac].xrcdseq2
               AND xrcd007 = g_fabo5_d[l_ac].xrcd007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo5_d[g_detail_idx].xrcdld
               LET gs_keys[2] = g_fabo5_d[g_detail_idx].xrcddocno
               LET gs_keys[3] = g_fabo5_d[g_detail_idx].xrcdseq
               CALL afat505_01_insert_b('xrcd_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabo5_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcdld = '", g_fabo5_d[l_ac].xrcdld, "' "
                                  ," AND xrcddocno = '", g_fabo5_d[l_ac].xrcddocno, "' "
                                  ," AND xrcdseq = '", g_fabo5_d[l_ac].xrcdseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo5_d[l_ac].* = g_fabo5_d_t.*
               CLOSE afat505_01_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo5_d[l_ac].* = g_fabo5_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前

               #end add-point
               
               UPDATE xrcd_t SET (xrcddocno,xrcdld,xrcdseq2,xrcd001,xrcdseq,xrcd007,xrcd002,xrcd003,xrcd006, 
                                  xrcd103,xrcd104,xrcd105,xrcd009) 
                   = (g_fabo5_d[l_ac].xrcddocno,g_fabo5_d[l_ac].xrcdld,g_fabo5_d[l_ac].xrcdseq2,
                      g_fabo5_d[l_ac].xrcd001,g_fabo5_d[l_ac].xrcdseq,g_fabo5_d[l_ac].xrcd007,
                      g_fabo5_d[l_ac].xrcd002,g_fabo5_d[l_ac].xrcd003,g_fabo5_d[l_ac].xrcd006,
                      g_fabo5_d[l_ac].xrcd103,g_fabo5_d[l_ac].xrcd104,g_fabo5_d[l_ac].xrcd105,
                      g_fabo5_d[l_ac].xrcd009) #自訂欄位頁簽      
               WHERE xrcdent = g_enterprise 
                 AND xrcddocno = g_fabo5_d_t.xrcddocno
                 AND xrcdld = g_fabo5_d_t.xrcdld
                 AND xrcdseq = g_fabo5_d_t.xrcdseq
                 AND xrcdseq2 = g_fabo5_d_t.xrcdseq2
                 AND xrcd007 = g_fabo5_d_t.xrcd007
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                  #INITIALIZE gs_keys TO NULL 
                  #LET gs_keys[1] = g_fabo5_d[g_detail_idx].xrcdld
                  #LET gs_keys_bak[1] = g_fabo5_d_t.xrcdld
                  #LET gs_keys[2] = g_fabo5_d[g_detail_idx].xrcddocno
                  #LET gs_keys_bak[2] = g_fabo5_d_t.xrcddocno
                  #LET gs_keys[3] = g_fabo5_d[g_detail_idx].xrcdseq
                  #LET gs_keys_bak[3] = g_fabo5_d_t.xrcdseq
                  #CALL afat505_01_update_b('xrcd_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄
                     LET g_log1 = util.JSON.stringify(g_fabo5_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo5_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
         #此段落由子樣板a02產生
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD fabu024

     

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD fabu024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xrcd104
            #add-point:ON CHANGE fabu024

            #END add-point
            
         AFTER FIELD xrcd009_5
            CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
            DISPLAY g_fabo5_d[l_ac].xrcd009_5_desc TO s_detail5[l_ac].xrcd009_5_desc
            IF NOT cl_null(g_fabo5_d[l_ac].xrcd009) THEN 
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_fabo5_d[l_ac].xrcdld,g_fabo5_d[l_ac].xrcd009,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabo5_d[l_ac].xrcdld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 =g_fabo5_d[l_ac].xrcd009
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabo5_d[l_ac].xrcd009
                LET g_qryparam.arg3 =g_fabo5_d[l_ac].xrcdld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fabo5_d[l_ac].xrcd009 = g_qryparam.return1              
                CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
                DISPLAY g_fabo5_d[l_ac].xrcd009_5_desc TO s_detail5[l_ac].xrcd009_5_desc
                DISPLAY g_fabo5_d[l_ac].xrcd009 TO xrcd009 
              END IF
               IF  NOT s_aglt310_lc_subject(g_fabo5_d[l_ac].xrcdld,g_fabo5_d[l_ac].xrcd009,'N') THEN
                    LET g_fabo5_d[l_ac].xrcd009 = g_fabo5_d_t.xrcd009
                  CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
                  DISPLAY g_fabo5_d[l_ac].xrcd009_5_desc TO s_detail5[l_ac].xrcd009_5_desc
                  NEXT FIELD CURRENT 
               END IF
              #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabo5_d[l_ac].xrcd009
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo5_d[l_ac].xrcd009 = g_fabo5_d_t.xrcd009
                  CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
                  DISPLAY g_fabo5_d[l_ac].xrcd009_5_desc TO s_detail5[l_ac].xrcd009_5_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
 
 
         #Ctrlp:input.c.page2.fabu024
         ON ACTION controlp INFIELD xrcd009_5
            #add-point:ON ACTION controlp INFIELD fabu024
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo5_d[l_ac].xrcd009             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'",
                                  " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabo2_d[l_ac].fabold,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabo5_d[l_ac].xrcd009 = g_qryparam.return1              
            CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
            DISPLAY g_fabo5_d[l_ac].xrcd009_5_desc TO s_detail5[l_ac].xrcd009_5_desc
            DISPLAY g_fabo5_d[l_ac].xrcd009 TO xrcd009              #

            NEXT FIELD xrcd009_5                          #返回原欄位


            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo5_d[l_ac].* = g_fabo5_d_t.*
               END IF
               CLOSE afat505_01_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("xrcd_t")
            CALL s_transaction_end('Y','0')
            #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後

            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_fabo5_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabo5_d.getLength()+1
 
      END INPUT  
      
      INPUT ARRAY g_fabo6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            CALL afat505_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabo6_d.getLength()
 
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabuld
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo6_d[l_ac].* TO NULL 
            INITIALIZE g_fabo6_d_t.* TO NULL
            INITIALIZE g_fabo6_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            LET g_fabo5_d[l_ac].xrcd006 = "N"
            #add-point:modify段before備份

            #end add-point
            LET g_fabo6_d_t.* = g_fabo6_d[l_ac].*     #新輸入資料
            LET g_fabo6_d_o.* = g_fabo6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat505_01_set_entry_b("a")
            CALL afat505_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo6_d[li_reproduce_target].* = g_fabo6_d[li_reproduce].*
 
               LET g_fabo6_d[li_reproduce_target].xrcdld = NULL
               LET g_fabo6_d[li_reproduce_target].xrcddocno = NULL
               LET g_fabo6_d[li_reproduce_target].xrcdseq = NULL
               LET g_fabo6_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_fabo6_d[li_reproduce_target].xrcd007 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_fabo6_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_fabo6_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabo6_d[l_ac].xrcdld IS NOT NULL
               AND g_fabo6_d[l_ac].xrcddocno IS NOT NULL
               AND g_fabo6_d[l_ac].xrcdseq IS NOT NULL
               AND g_fabo6_d[l_ac].xrcdseq2 IS NOT NULL
               AND g_fabo6_d[l_ac].xrcd007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabo6_d_t.* = g_fabo6_d[l_ac].*  #BACKUP
               LET g_fabo6_d_o.* = g_fabo6_d[l_ac].*  #BACKUP
               IF NOT afat505_01_lock_b("xrcd_t2") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_01_bcl4 INTO g_fabo6_d[l_ac].xrcddocno,g_fabo6_d[l_ac].xrcdld,g_fabo6_d[l_ac].xrcdseq2,
                                             g_fabo6_d[l_ac].xrcd001,g_fabo6_d[l_ac].xrcdseq,g_fabo6_d[l_ac].xrcd007,
                                             g_fabo6_d[l_ac].xrcd002,g_fabo6_d[l_ac].xrcd003,g_fabo6_d[l_ac].xrcd006,
                                             g_fabo6_d[l_ac].xrcd103,g_fabo6_d[l_ac].xrcd104,g_fabo6_d[l_ac].xrcd105,
                                             g_fabo6_d[l_ac].xrcd113,g_fabo6_d[l_ac].xrcd114,g_fabo6_d[l_ac].xrcd115,
                                             g_fabo6_d[l_ac].xrcd009
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
                  CALL afat505_01_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前

               #end add-point 
            
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
               
               #add-point:單身2刪除前

               #end add-point 
               
               DELETE FROM xrcd_t
                WHERE xrcdent = g_enterprise 
                  AND xrcddocno = g_fabo6_d_t.xrcddocno
                  AND xrcdld = g_fabo6_d_t.xrcdld
                  AND xrcdseq = g_fabo6_d_t.xrcdseq
                  AND xrcdseq2 = g_fabo6_d_t.xrcdseq2
                  AND xrcd007 = g_fabo6_d_t.xrcd007
                  
               #add-point:單身2刪除中

               #end add-point 
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcd_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat505_01_bcl4
               LET l_count = g_fabo6_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo6_d[g_detail_idx].xrcdld
               LET gs_keys[2] = g_fabo6_d[g_detail_idx].xrcddocno
               LET gs_keys[3] = g_fabo6_d[g_detail_idx].xrcdseq
 
               #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
               CALL afat505_01_delete_b('xrcd_t2',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabo6_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
               
            SELECT COUNT(*) INTO l_count FROM xrcd_t 
             WHERE xrcdent = g_enterprise 
               AND xrcddocno = g_fabo6_d[l_ac].xrcddocno
               AND xrcdld = g_fabo6_d[l_ac].xrcdld
               AND xrcdseq = g_fabo6_d[l_ac].xrcdseq
               AND xrcdseq2 = g_fabo6_d[l_ac].xrcdseq2
               AND xrcd007 = g_fabo6_d[l_ac].xrcd007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo6_d[g_detail_idx].xrcdld
               LET gs_keys[2] = g_fabo6_d[g_detail_idx].xrcddocno
               LET gs_keys[3] = g_fabo6_d[g_detail_idx].xrcdseq
               CALL afat505_01_insert_b('xrcd_t2',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabo6_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t2" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcdld = '", g_fabo6_d[l_ac].xrcdld, "' "
                                  ," AND xrcddocno = '", g_fabo6_d[l_ac].xrcddocno, "' "
                                  ," AND xrcdseq = '", g_fabo6_d[l_ac].xrcdseq, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabo6_d[l_ac].* = g_fabo6_d_t.*
               CLOSE afat505_01_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabo6_d[l_ac].* = g_fabo6_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前

               #end add-point
               
               UPDATE xrcd_t SET (xrcddocno,xrcdld,xrcdseq2,xrcd001,xrcdseq,xrcd007,xrcd002,xrcd003,xrcd006, 
                                  xrcd103,xrcd104,xrcd105,xrcd009) 
                   = (g_fabo6_d[l_ac].xrcddocno,g_fabo6_d[l_ac].xrcdld,g_fabo6_d[l_ac].xrcdseq2,
                      g_fabo6_d[l_ac].xrcd001,g_fabo6_d[l_ac].xrcdseq,g_fabo6_d[l_ac].xrcd007,
                      g_fabo6_d[l_ac].xrcd002,g_fabo6_d[l_ac].xrcd003,g_fabo6_d[l_ac].xrcd006,
                      g_fabo6_d[l_ac].xrcd103,g_fabo6_d[l_ac].xrcd104,g_fabo6_d[l_ac].xrcd105,
                      g_fabo6_d[l_ac].xrcd009) #自訂欄位頁簽      
               WHERE xrcdent = g_enterprise 
                 AND xrcddocno = g_fabo6_d_t.xrcddocno
                 AND xrcdld = g_fabo6_d_t.xrcdld
                 AND xrcdseq = g_fabo6_d_t.xrcdseq
                 AND xrcdseq2 = g_fabo6_d_t.xrcdseq2
                 AND xrcd007 = g_fabo6_d_t.xrcd007
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t2" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t2" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                  #INITIALIZE gs_keys TO NULL 
                  #LET gs_keys[1] = g_fabo5_d[g_detail_idx].xrcdld
                  #LET gs_keys_bak[1] = g_fabo5_d_t.xrcdld
                  #LET gs_keys[2] = g_fabo5_d[g_detail_idx].xrcddocno
                  #LET gs_keys_bak[2] = g_fabo5_d_t.xrcddocno
                  #LET gs_keys[3] = g_fabo5_d[g_detail_idx].xrcdseq
                  #LET gs_keys_bak[3] = g_fabo5_d_t.xrcdseq
                  #CALL afat505_01_update_b('xrcd_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄
                     LET g_log1 = util.JSON.stringify(g_fabo6_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabo6_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page2修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a02產生
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD fabu024
            


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD fabu024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xrcd104
            #add-point:ON CHANGE fabu024

            #END add-point
 
 
         AFTER FIELD xrcd009_6
            CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
            DISPLAY g_fabo6_d[l_ac].xrcd009_6_desc TO s_detail6[l_ac].xrcd009_6_desc
            IF NOT cl_null(g_fabo6_d[l_ac].xrcd009) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_fabo6_d[l_ac].xrcdld,g_fabo6_d[l_ac].xrcd009,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabo6_d[l_ac].xrcdld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 =g_fabo6_d[l_ac].xrcd009
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabo6_d[l_ac].xrcd009
                LET g_qryparam.arg3 =g_fabo6_d[l_ac].xrcdld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fabo6_d[l_ac].xrcd009 = g_qryparam.return1              
                CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
                DISPLAY g_fabo6_d[l_ac].xrcd009_6_desc TO s_detail6[l_ac].xrcd009_6_desc
                DISPLAY g_fabo6_d[l_ac].xrcd009 TO xrcd009
                
              END IF
                IF NOT s_aglt310_lc_subject(g_fabo6_d[l_ac].xrcdld,g_fabo6_d[l_ac].xrcd009,'N') THEN
                    LET g_fabo6_d[l_ac].xrcd009 = g_fabo6_d_t.xrcd009
                  CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
                  DISPLAY g_fabo6_d[l_ac].xrcd009_6_desc TO s_detail6[l_ac].xrcd009_6_desc
                  NEXT FIELD CURRENT 
                END IF
              #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabo6_d[l_ac].xrcd009
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo6_d[l_ac].xrcd009 = g_fabo6_d_t.xrcd009
                  CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
                  DISPLAY g_fabo6_d[l_ac].xrcd009_6_desc TO s_detail6[l_ac].xrcd009_6_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
 
         #Ctrlp:input.c.page2.fabu024
         ON ACTION controlp INFIELD xrcd009_6
            #add-point:ON ACTION controlp INFIELD fabu024
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo6_d[l_ac].xrcd009             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'",
                                  " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabo2_d[l_ac].fabold,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabo6_d[l_ac].xrcd009 = g_qryparam.return1              
            CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
            DISPLAY g_fabo6_d[l_ac].xrcd009_6_desc TO s_detail6[l_ac].xrcd009_6_desc
            DISPLAY g_fabo6_d[l_ac].xrcd009 TO xrcd009              #

            NEXT FIELD xrcd009_6                          #返回原欄位


            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabo6_d[l_ac].* = g_fabo6_d_t.*
               END IF
               CLOSE afat505_01_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL afat505_01_unlock_b("xrcd_t2")
            CALL s_transaction_end('Y','0')
            #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後

            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_fabo6_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabo6_d.getLength()+1
 
      END INPUT 
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD fabodocno
            WHEN "s_detail2"
               NEXT FIELD fabodocno_2
            WHEN "s_detail3"
               NEXT FIELD fabudocno
            WHEN "s_detail4"
               NEXT FIELD fabudocno_4
            WHEN "s_detail5"
               NEXT FIELD xrcddocno_5
            WHEN "s_detail6"
               NEXT FIELD xrcddocno_6
            WHEN "s_detail7"
               NEXT FIELD fabodocno_7
            WHEN "s_detail8"
               NEXT FIELD fabudocno_8
         END CASE
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD fabodocno
            WHEN "s_detail2"
               NEXT FIELD fabodocno_2
            WHEN "s_detail7"
               NEXT FIELD fabodocno_3
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_fabo_d[g_detail_idx].fabold) THEN
         CALL g_fabo_d.deleteElement(g_detail_idx)
         CALL g_fabo2_d.deleteElement(g_detail_idx)
         CALL g_fabo7_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_fabo_d[g_detail_idx].* = g_fabo_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   LET la_param.prog = 'afai100'
   LET la_param.param[1] = g_faah000
   LET la_param.param[2] = g_faah001
   LET la_param.param[3] = g_fabo001
   LET la_param.param[4] = g_fabo002
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun(ls_js)
   #end add-point
 
   CLOSE afat505_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat505_01_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_fabo_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT afat505_01_lock_b("fabo_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("fabo_t","") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_fabo_d.getLength()
      IF g_fabo_d[li_idx].fabold IS NOT NULL
         AND g_fabo_d[li_idx].fabodocno IS NOT NULL
         AND g_fabo_d[li_idx].faboseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM fabo_t
          WHERE faboent = g_enterprise AND 
                fabold = g_fabo_d[li_idx].fabold
                AND fabodocno = g_fabo_d[li_idx].fabodocno
                AND faboseq = g_fabo_d[li_idx].faboseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
 
            
 
 
 
            
 
 
 
 
            
 
 
 
            
 
 
 
            
 
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabo_d_t.fabold
               LET gs_keys[2] = g_fabo_d_t.fabodocno
               LET gs_keys[3] = g_fabo_d_t.faboseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL afat505_01_delete_b('fabo_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat505_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL afat505_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat505_01_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_oodbl004 LIKE oodbL_t.oodbl004
   DEFINE l_oodb005  LIKE oodb_t.oodb005
   DEFINE l_oodb006  LIKE oodb_t.oodb006
   DEFINE l_oodb011  LIKE oodb_t.oodb011
   DEFINE l_ooef019  LIKE ooef_t.ooef019 #20141113
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   CALL afat505_01_visible() 
   
   #先看下fabu有沒有資料,若沒有資料,先把主鍵的值插進去,以便b_fill時可以查到資料修改
   SELECT COUNT(*) INTO l_n
     FROM fabu_t
    WHERE fabuent = g_enterprise
      AND fabuld  = g_fabgld
      AND fabudocno = g_fabgdocno
      
   IF l_n = 0 THEN 
      CALL s_transaction_begin()
      INSERT INTO fabu_t(fabuent,fabudocno,fabuld,fabuseq) 
                  VALUES(g_enterprise,g_fabgdocno,g_fabgld,g_faboseq) 
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins fabu" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()    
         CALL s_transaction_end('N','0') 
      ELSE
         CALL s_transaction_end('Y','0')       
      END IF
   END IF
   
   LET p_wc2 = "     fabold    = '",g_fabgld,"'",
               " AND fabodocno = '",g_fabgdocno,"'",
               " AND faboseq   = '",g_faboseq,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.fabodocno,t0.fabold,t0.faboseq,t0.fabo008,t0.fabo009,t0.fabo010, 
       t0.fabo006,t0.fabo012,t0.fabo013,t0.fabo014,t0.fabo015,t0.fabo016,t0.fabo017,t0.fabo049,t0.fabo011, 
       t0.fabo018,t0.fabo019,t0.fabo020,t0.fabo021,t0.fabo022,t0.fabodocno,t0.fabold,t0.faboseq,t0.fabo024, 
       t0.fabo042,t0.fabo031,t0.fabo032,t0.fabo033,t0.fabo034,t0.fabo035,t0.fabo036,t0.fabo037,t0.fabo038, 
       t0.fabo039,t0.fabo040,t0.fabodocno,t0.fabold,t0.faboseq,t0.fabo107,t0.fabo101,t0.fabo102,t0.fabo111, 
       t0.fabo103,t0.fabo104,t0.fabo105,t0.fabo106,t0.fabo108,t0.fabo109,t0.fabo110,t0.fabo156,t0.fabo150, 
       t0.fabo151,t0.fabo160,t0.fabo152,t0.fabo153,t0.fabo154,t0.fabo155,t0.fabo157,t0.fabo158,t0.fabo159  FROM fabo_t t0", 
 
               "",
               
               " WHERE t0.faboent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("fabo_t"),
                      " ORDER BY t0.fabold,t0.fabodocno,t0.faboseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabo_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat505_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afat505_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fabo_d.clear()
   CALL g_fabo2_d.clear()   
   CALL g_fabo7_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_fabo_d[l_ac].fabodocno,g_fabo_d[l_ac].fabold,g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo008, 
       g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006,g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013, 
       g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015,g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049, 
       g_fabo_d[l_ac].fabo011,g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
       g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabodocno,g_fabo2_d[l_ac].fabold,g_fabo2_d[l_ac].faboseq, 
       g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031,g_fabo2_d[l_ac].fabo032, 
       g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035,g_fabo2_d[l_ac].fabo036, 
       g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040, 
       g_fabo7_d[l_ac].fabodocno,g_fabo7_d[l_ac].fabold,g_fabo7_d[l_ac].faboseq,g_fabo7_d[l_ac].fabo107, 
       g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103, 
       g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105,g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108, 
       g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110,g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150, 
       g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160,g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153, 
       g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155,g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158, 
       g_fabo7_d[l_ac].fabo159
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #20141113 add--str--by chenying 
      #预设调入/调出所有组织默认税别，币别
      IF cl_null(g_fabo_d[l_ac].fabo010) AND l_ac > 0 THEN 
         SELECT ooef016 INTO g_fabo_d[l_ac].fabo010 FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_fabo044 
      END IF
      
      IF cl_null(g_fabo_d[l_ac].fabo009) AND l_ac > 0 THEN
         LET l_ooef019 = NULL            
         SELECT ooef019 INTO l_ooef019 FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_fabo044 
         SELECT oodb002 INTO g_fabo_d[l_ac].fabo009 FROM oodb_t
          WHERE oodbent = g_enterprise AND oodb001 = l_ooef019               
      END IF            
      #20141113 add--end--        
      
      IF NOT cl_null(g_fabo_d[l_ac].fabo009) THEN
         CALL s_tax_chk(g_glaacomp,g_fabo_d[l_ac].fabo009)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         
         CALL afat505_01_fabo009_set_entry(l_oodb005)
      END IF
      LET g_fabo_d[l_ac].fabo008 = g_faaj016 / g_fabo006 * g_fabo007
      LET g_fabo_d[l_ac].fabo022 = g_faaj028 / g_fabo006 * g_fabo007
       
      
      CALL afat505_01_fabo024_desc(g_fabo2_d[l_ac].fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
      CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo031) RETURNING g_fabo2_d[l_ac].fabo031_desc
      LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031 CLIPPED,g_fabo2_d[l_ac].fabo031_desc
      CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo032) RETURNING g_fabo2_d[l_ac].fabo032_desc
      LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032 CLIPPED,g_fabo2_d[l_ac].fabo032_desc
      CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo033) RETURNING g_fabo2_d[l_ac].fabo033_desc
      LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033 CLIPPED,g_fabo2_d[l_ac].fabo033_desc
      CALL afat505_01_fabo034_desc('287',g_fabo2_d[l_ac].fabo034) RETURNING g_fabo2_d[l_ac].fabo034_desc
      LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034 CLIPPED,g_fabo2_d[l_ac].fabo034_desc
      CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo035) RETURNING g_fabo2_d[l_ac].fabo035_desc
      LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035 CLIPPED,g_fabo2_d[l_ac].fabo035_desc
      CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo036) RETURNING g_fabo2_d[l_ac].fabo036_desc
      LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036 CLIPPED,g_fabo2_d[l_ac].fabo036_desc
      CALL afat505_01_fabo034_desc('281',g_fabo2_d[l_ac].fabo037) RETURNING g_fabo2_d[l_ac].fabo037_desc
      LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037 CLIPPED,g_fabo2_d[l_ac].fabo037_desc
      CALL afat505_01_fabo038_desc(g_fabo2_d[l_ac].fabo038) RETURNING g_fabo2_d[l_ac].fabo038_desc
      LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038 CLIPPED,g_fabo2_d[l_ac].fabo038_desc
      CALL afat505_01_fabo039_desc(g_fabo2_d[l_ac].fabo039) RETURNING g_fabo2_d[l_ac].fabo039_desc
      LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039 CLIPPED,g_fabo2_d[l_ac].fabo039_desc
      CALL afat505_01_fabo040_desc(g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040) RETURNING g_fabo2_d[l_ac].fabo040_desc
      LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040 CLIPPED,g_fabo2_d[l_ac].fabo040_desc
      
  
      #end add-point
      
      CALL afat505_01_detail_show()      
 
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
 
   LET g_error_show = 0
   
 
   
   CALL g_fabo_d.deleteElement(g_fabo_d.getLength())   
   CALL g_fabo2_d.deleteElement(g_fabo2_d.getLength())
   CALL g_fabo7_d.deleteElement(g_fabo7_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabo_d.getLength()
      LET g_fabo2_d[l_ac].fabold = g_fabo_d[l_ac].fabold 
      LET g_fabo2_d[l_ac].fabodocno = g_fabo_d[l_ac].fabodocno 
      LET g_fabo2_d[l_ac].faboseq = g_fabo_d[l_ac].faboseq 
      LET g_fabo7_d[l_ac].fabold = g_fabo_d[l_ac].fabold 
      LET g_fabo7_d[l_ac].fabodocno = g_fabo_d[l_ac].fabodocno 
      LET g_fabo7_d[l_ac].faboseq = g_fabo_d[l_ac].faboseq 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_fabo_d.getLength() THEN
      LET l_ac = g_fabo_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabo_d.getLength()
      LET g_fabo_d_mask_o[l_ac].* =  g_fabo_d[l_ac].*
      CALL afat505_01_fabo_t_mask()
      LET g_fabo_d_mask_n[l_ac].* =  g_fabo_d[l_ac].*
   END FOR
   
   LET g_fabo2_d_mask_o.* =  g_fabo2_d.*
   FOR l_ac = 1 TO g_fabo2_d.getLength()
      LET g_fabo2_d_mask_o[l_ac].* =  g_fabo2_d[l_ac].*
      CALL afat505_01_fabo_t_mask()
      LET g_fabo2_d_mask_n[l_ac].* =  g_fabo2_d[l_ac].*
   END FOR
   LET g_fabo7_d_mask_o.* =  g_fabo7_d.*
   FOR l_ac = 1 TO g_fabo7_d.getLength()
      LET g_fabo7_d_mask_o[l_ac].* =  g_fabo7_d[l_ac].*
      CALL afat505_01_fabo_t_mask()
      LET g_fabo7_d_mask_n[l_ac].* =  g_fabo7_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL g_fabo3_d.clear()   
   CALL g_fabo4_d.clear()   
   CALL g_fabo5_d.clear()   
   CALL g_fabo6_d.clear()    
   CALL g_fabo8_d.clear()
   
   LET g_sql = "SELECT  UNIQUE t0.fabudocno,t0.fabuld,t0.fabuseq,t0.fabu009,t0.fabu010,t0.fabu006,t0.fabu012,t0.fabu013, 
                               t0.fabu014,t0.fabu015,t0.fabu016,t0.fabu017,t0.fabu011,t0.fabudocno,t0.fabuld,
                               t0.fabuseq,t0.fabu022,t0.fabu035,t0.fabu024,t0.fabu025,t0.fabu026,t0.fabu027,
                               t0.fabu028,t0.fabu029,t0.fabu030,t0.fabu031,t0.fabu032,t0.fabu033,t0.fabu106,
                               t0.fabu101,t0.fabu102,t0.fabu107,t0.fabu103,t0.fabu104,t0.fabu105,t0.fabu155,
                               t0.fabu150,t0.fabu151,t0.fabu156,t0.fabu152,t0.fabu153,t0.fabu154 FROM fabu_t t0",
                                   
               " WHERE t0.fabuent = ? ",
               "   AND t0.fabuld  = '",g_fabgld,"'",   
               "   AND t0.fabudocno = '",g_fabgdocno,"'",
               "   AND t0.fabuseq   = '",g_faboseq,"'"
   LET g_sql = g_sql, cl_sql_add_filter("fabo_t"),
                      " ORDER BY t0.fabuld,t0.fabudocno,t0.fabuseq"
                      
   
   

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat505_01_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afat505_01_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 

   FOREACH b_fill_curs2 INTO g_fabo3_d[l_ac].fabudocno,g_fabo3_d[l_ac].fabuld,g_fabo3_d[l_ac].fabuseq, 
          g_fabo3_d[l_ac].fabu009,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu006,g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu013, 
          g_fabo3_d[l_ac].fabu014,g_fabo3_d[l_ac].fabu015,g_fabo3_d[l_ac].fabu016,g_fabo3_d[l_ac].fabu017,
          g_fabo3_d[l_ac].fabu011,          
          g_fabo4_d[l_ac].fabudocno,g_fabo4_d[l_ac].fabuld,g_fabo4_d[l_ac].fabuseq,g_fabo4_d[l_ac].fabu022, 
          g_fabo4_d[l_ac].fabu035,g_fabo4_d[l_ac].fabu024,g_fabo4_d[l_ac].fabu025,g_fabo4_d[l_ac].fabu026, 
          g_fabo4_d[l_ac].fabu027,g_fabo4_d[l_ac].fabu028,g_fabo4_d[l_ac].fabu029,g_fabo4_d[l_ac].fabu030, 
          g_fabo4_d[l_ac].fabu031,g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033,g_fabo8_d[l_ac].fabu106, 
          g_fabo8_d[l_ac].fabu101,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu107,g_fabo8_d[l_ac].fabu103, 
          g_fabo8_d[l_ac].fabu104,g_fabo8_d[l_ac].fabu105,g_fabo8_d[l_ac].fabu155,g_fabo8_d[l_ac].fabu150, 
          g_fabo8_d[l_ac].fabu151,g_fabo8_d[l_ac].fabu156,g_fabo8_d[l_ac].fabu152,g_fabo8_d[l_ac].fabu153, 
          g_fabo8_d[l_ac].fabu154
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      CALL afat505_01_fabo024_desc(g_fabo4_d[l_ac].fabu022) RETURNING g_fabo4_d[l_ac].fabu022_desc
      DISPLAY g_fabo4_d[l_ac].fabu022_desc TO s_detail4[l_ac].fabu022_desc
      CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu024) RETURNING g_fabo4_d[l_ac].fabu024_desc
      LET g_fabo4_d[l_ac].fabu024_desc = g_fabo4_d[l_ac].fabu024 CLIPPED,g_fabo4_d[l_ac].fabu024_desc
      CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu025) RETURNING g_fabo4_d[l_ac].fabu025_desc
      LET g_fabo4_d[l_ac].fabu025_desc = g_fabo4_d[l_ac].fabu025 CLIPPED,g_fabo4_d[l_ac].fabu025_desc
      CALL afat505_01_fabo031_desc(g_fabo4_d[l_ac].fabu026) RETURNING g_fabo4_d[l_ac].fabu026_desc
      LET g_fabo4_d[l_ac].fabu026_desc = g_fabo4_d[l_ac].fabu026 CLIPPED,g_fabo4_d[l_ac].fabu026_desc
      CALL afat505_01_fabo034_desc('287',g_fabo4_d[l_ac].fabu027) RETURNING g_fabo4_d[l_ac].fabu027_desc
      LET g_fabo4_d[l_ac].fabu027_desc = g_fabo4_d[l_ac].fabu027 CLIPPED,g_fabo4_d[l_ac].fabu027_desc
      CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu028) RETURNING g_fabo4_d[l_ac].fabu028_desc
      LET g_fabo4_d[l_ac].fabu028_desc = g_fabo4_d[l_ac].fabu028 CLIPPED,g_fabo4_d[l_ac].fabu028_desc
      CALL afat505_01_fabo035_desc(g_fabo4_d[l_ac].fabu029) RETURNING g_fabo4_d[l_ac].fabu029_desc
      LET g_fabo4_d[l_ac].fabu029_desc = g_fabo4_d[l_ac].fabu029 CLIPPED,g_fabo4_d[l_ac].fabu029_desc
      CALL afat505_01_fabo034_desc('281',g_fabo4_d[l_ac].fabu030) RETURNING g_fabo4_d[l_ac].fabu030_desc
      LET g_fabo4_d[l_ac].fabu030_desc = g_fabo4_d[l_ac].fabu030 CLIPPED,g_fabo4_d[l_ac].fabu030_desc
      CALL afat505_01_fabo038_desc(g_fabo4_d[l_ac].fabu031) RETURNING g_fabo4_d[l_ac].fabu031_desc
      LET g_fabo4_d[l_ac].fabu031_desc = g_fabo4_d[l_ac].fabu031 CLIPPED,g_fabo4_d[l_ac].fabu031_desc
      CALL afat505_01_fabo039_desc(g_fabo4_d[l_ac].fabu032) RETURNING g_fabo4_d[l_ac].fabu032_desc
      LET g_fabo4_d[l_ac].fabu032_desc = g_fabo4_d[l_ac].fabu032 CLIPPED,g_fabo4_d[l_ac].fabu032_desc
      CALL afat505_01_fabo040_desc(g_fabo4_d[l_ac].fabu032,g_fabo4_d[l_ac].fabu033) RETURNING g_fabo4_d[l_ac].fabu033_desc
      LET g_fabo4_d[l_ac].fabu033_desc = g_fabo4_d[l_ac].fabu033 CLIPPED,g_fabo4_d[l_ac].fabu033_desc
      
      #20141113 add--str--by chenying 
      #预设调入/调出所有组织默认税别，币别
      IF cl_null(g_fabo3_d[l_ac].fabu010) AND l_ac > 0 THEN 
         SELECT ooef016 INTO g_fabo3_d[l_ac].fabu010 FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_fabo047 
      END IF
      
      IF cl_null(g_fabo3_d[l_ac].fabu009) AND l_ac > 0 THEN
         LET l_ooef019 = NULL            
         SELECT ooef019 INTO l_ooef019 FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = g_fabo047 
         SELECT oodb002 INTO g_fabo3_d[l_ac].fabu009 FROM oodb_t
          WHERE oodbent = g_enterprise AND oodb001 = l_ooef019               
      END IF            
      #20141113 add--end--      
      
      IF NOT cl_null(g_fabo3_d[l_ac].fabu009) THEN
         CALL s_tax_chk(g_glaacomp,g_fabo3_d[l_ac].fabu009)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
     
         CALL afat505_01_fabu009_set_entry(l_oodb005)
      END IF
      
      
      #end add-point
      
      CALL afat505_01_detail_show()      
 
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
 
   LET g_error_show = 0
   
 
   
   CALL g_fabo3_d.deleteElement(g_fabo3_d.getLength())   
   CALL g_fabo4_d.deleteElement(g_fabo4_d.getLength())
   CALL g_fabo8_d.deleteElement(g_fabo8_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabo_d.getLength()
      LET g_fabo4_d[l_ac].fabuld    = g_fabo3_d[l_ac].fabuld 
      LET g_fabo4_d[l_ac].fabudocno = g_fabo3_d[l_ac].fabudocno 
      LET g_fabo4_d[l_ac].fabuseq   = g_fabo3_d[l_ac].fabuseq 
      LET g_fabo8_d[l_ac].fabuld    = g_fabo3_d[l_ac].fabuld 
      LET g_fabo8_d[l_ac].fabudocno = g_fabo3_d[l_ac].fabudocno 
      LET g_fabo8_d[l_ac].fabuseq   = g_fabo3_d[l_ac].fabuseq 
 
   END FOR
   
   IF g_cnt > g_fabo3_d.getLength() THEN
      LET l_ac = g_fabo3_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
   
   CLOSE b_fill_curs2
   FREE afat505_01_pb2
   
   LET g_sql = "SELECT UNIQUE t0.xrcddocno,t0.xrcdld,t0.xrcdseq2,t0.xrcd001,t0.xrcdseq,t0.xrcd007,t0.xrcd002, 
                              t0.xrcd003,t0.xrcd006,t0.xrcd103,t0.xrcd104,t0.xrcd105,t0.xrcd009",    
               "  FROM xrcd_t t0",
               " WHERE t0.xrcdent= ?  AND  1=1"  ,
               "   AND t0.xrcdld = '",g_fabgld,"'",
               "   AND t0.xrcddocno = '",g_fabgdocno,"'",
               "   AND t0.xrcdseq = '",g_faboseq,"'",
               "   AND t0.xrcdseq2 = 1 "
               
   LET g_sql = g_sql, cl_sql_add_filter("xrcd_t"),
                      " ORDER BY t0.xrcdld,t0.xrcddocno,t0.xrcdseq,t0.xrcdseq2"
                      
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat505_01_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR afat505_01_pb3
   
   OPEN b_fill_curs3 USING g_enterprise
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs3 INTO g_fabo5_d[l_ac].xrcddocno,g_fabo5_d[l_ac].xrcdld,g_fabo5_d[l_ac].xrcdseq2,
                             g_fabo5_d[l_ac].xrcd001,g_fabo5_d[l_ac].xrcdseq,g_fabo5_d[l_ac].xrcd007,
                             g_fabo5_d[l_ac].xrcd002,g_fabo5_d[l_ac].xrcd003,g_fabo5_d[l_ac].xrcd006,
                             g_fabo5_d[l_ac].xrcd103,g_fabo5_d[l_ac].xrcd104,g_fabo5_d[l_ac].xrcd105,
                             g_fabo5_d[l_ac].xrcd009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      CALL afat505_01_xrcd002_desc(g_fabo5_d[l_ac].xrcd002) RETURNING g_fabo5_d[l_ac].xrcd002_5_desc
      CALL afat505_01_fabo024_desc(g_fabo5_d[l_ac].xrcd009) RETURNING g_fabo5_d[l_ac].xrcd009_5_desc
      LET g_fabo5_d[l_ac].fabo001 = g_fabo001
      #end add-point
      
      CALL afat505_01_detail_show()      
 
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
 
   LET g_error_show = 0
   
 
   
   CALL g_fabo5_d.deleteElement(g_fabo5_d.getLength())   
   
   IF g_cnt > g_fabo5_d.getLength() THEN
      LET l_ac = g_fabo5_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
   
   CLOSE b_fill_curs3
   FREE afat505_01_pb3
   
   
   LET g_sql = "SELECT UNIQUE t0.xrcddocno,t0.xrcdld,t0.xrcdseq2,t0.xrcd001,t0.xrcdseq,t0.xrcd007,t0.xrcd002, 
                              t0.xrcd003,t0.xrcd006,t0.xrcd103,t0.xrcd104,t0.xrcd105,t0.xrcd009",    
               "  FROM xrcd_t t0",
               " WHERE t0.xrcdent= ?  AND  1=1"  ,
               "   AND t0.xrcdld = '",g_fabgld,"'",
               "   AND t0.xrcddocno = '",g_fabgdocno,"'",
               "   AND t0.xrcdseq = '",g_faboseq,"'",
               "   AND t0.xrcdseq2 = 2 "
               
   LET g_sql = g_sql, cl_sql_add_filter("xrcd_t"),
                      " ORDER BY t0.xrcdld,t0.xrcddocno,t0.xrcdseq,t0.xrcdseq2"
                      
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat505_01_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR afat505_01_pb4
   
   OPEN b_fill_curs4 USING g_enterprise
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs4 INTO g_fabo6_d[l_ac].xrcddocno,g_fabo6_d[l_ac].xrcdld,g_fabo6_d[l_ac].xrcdseq2,
                             g_fabo6_d[l_ac].xrcd001,g_fabo6_d[l_ac].xrcdseq,g_fabo6_d[l_ac].xrcd007,
                             g_fabo6_d[l_ac].xrcd002,g_fabo6_d[l_ac].xrcd003,g_fabo6_d[l_ac].xrcd006,
                             g_fabo6_d[l_ac].xrcd103,g_fabo6_d[l_ac].xrcd104,g_fabo6_d[l_ac].xrcd105,
                             g_fabo6_d[l_ac].xrcd009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      CALL afat505_01_xrcd002_desc(g_fabo6_d[l_ac].xrcd002) RETURNING g_fabo6_d[l_ac].xrcd002_6_desc
      CALL afat505_01_fabo024_desc(g_fabo6_d[l_ac].xrcd009) RETURNING g_fabo6_d[l_ac].xrcd009_6_desc
      LET g_fabo6_d[l_ac].fabo001 = g_fabo001
      #end add-point
      
      CALL afat505_01_detail_show()      
 
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
 
   LET g_error_show = 0
   
 
   
   CALL g_fabo6_d.deleteElement(g_fabo6_d.getLength())   
   
   IF g_cnt > g_fabo6_d.getLength() THEN
      LET l_ac = g_fabo6_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
   
   CLOSE b_fill_curs4
   FREE afat505_01_pb4
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fabo_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE afat505_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afat505_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body7.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat505_01_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="afat505_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat505_01_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat505_01_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fabold = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabodocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faboseq = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat505_01_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "fabo_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'fabo_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM fabo_t
          WHERE faboent = g_enterprise AND
            fabold = ps_keys_bak[1] AND fabodocno = ps_keys_bak[2] AND faboseq = ps_keys_bak[3]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabo_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fabo2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fabo7_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat505_01_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "fabo_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO fabo_t
                  (faboent,
                   fabold,fabodocno,faboseq
                   ,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022,fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105,fabo106,fabo108,fabo109,fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155,fabo157,fabo158,fabo159) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                       g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                       g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                       g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                       g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031, 
                       g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035, 
                       g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039, 
                       g_fabo2_d[l_ac].fabo040,g_fabo7_d[l_ac].fabo107,g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102, 
                       g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103,g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105, 
                       g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108,g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110, 
                       g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150,g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160, 
                       g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153,g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155, 
                       g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158,g_fabo7_d[l_ac].fabo159)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat505_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "fabo_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "fabo_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE fabo_t 
         SET (fabold,fabodocno,faboseq
              ,fabo008,fabo009,fabo010,fabo006,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo049,fabo011,fabo018,fabo019,fabo020,fabo021,fabo022,fabo024,fabo042,fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo107,fabo101,fabo102,fabo111,fabo103,fabo104,fabo105,fabo106,fabo108,fabo109,fabo110,fabo156,fabo150,fabo151,fabo160,fabo152,fabo153,fabo154,fabo155,fabo157,fabo158,fabo159) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabo_d[l_ac].fabo008,g_fabo_d[l_ac].fabo009,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo006, 
                  g_fabo_d[l_ac].fabo012,g_fabo_d[l_ac].fabo013,g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo015, 
                  g_fabo_d[l_ac].fabo016,g_fabo_d[l_ac].fabo017,g_fabo_d[l_ac].fabo049,g_fabo_d[l_ac].fabo011, 
                  g_fabo_d[l_ac].fabo018,g_fabo_d[l_ac].fabo019,g_fabo_d[l_ac].fabo020,g_fabo_d[l_ac].fabo021, 
                  g_fabo_d[l_ac].fabo022,g_fabo2_d[l_ac].fabo024,g_fabo2_d[l_ac].fabo042,g_fabo2_d[l_ac].fabo031, 
                  g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,g_fabo2_d[l_ac].fabo035, 
                  g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,g_fabo2_d[l_ac].fabo039, 
                  g_fabo2_d[l_ac].fabo040,g_fabo7_d[l_ac].fabo107,g_fabo7_d[l_ac].fabo101,g_fabo7_d[l_ac].fabo102, 
                  g_fabo7_d[l_ac].fabo111,g_fabo7_d[l_ac].fabo103,g_fabo7_d[l_ac].fabo104,g_fabo7_d[l_ac].fabo105, 
                  g_fabo7_d[l_ac].fabo106,g_fabo7_d[l_ac].fabo108,g_fabo7_d[l_ac].fabo109,g_fabo7_d[l_ac].fabo110, 
                  g_fabo7_d[l_ac].fabo156,g_fabo7_d[l_ac].fabo150,g_fabo7_d[l_ac].fabo151,g_fabo7_d[l_ac].fabo160, 
                  g_fabo7_d[l_ac].fabo152,g_fabo7_d[l_ac].fabo153,g_fabo7_d[l_ac].fabo154,g_fabo7_d[l_ac].fabo155, 
                  g_fabo7_d[l_ac].fabo157,g_fabo7_d[l_ac].fabo158,g_fabo7_d[l_ac].fabo159) 
         WHERE faboent = g_enterprise AND fabold = ps_keys_bak[1] AND fabodocno = ps_keys_bak[2] AND faboseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat505_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   #鎖定整組table
   #LET ls_group = "fabu_t,"
   #僅鎖定自身table
   LET ls_group = "fabu_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat505_01_bcl2 USING g_enterprise,
                                             g_fabo3_d[g_detail_idx].fabuld,g_fabo3_d[g_detail_idx].fabudocno, 
                                                 g_fabo3_d[g_detail_idx].fabuseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat505_01_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   
   LET ls_group = "xrcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat505_01_bcl3 USING g_enterprise,g_fabo5_d[g_detail_idx].xrcdld,g_fabo5_d[g_detail_idx].xrcddocno, 
                                              g_fabo5_d[g_detail_idx].xrcdseq,'1', 
                                              g_fabo5_d[g_detail_idx].xrcd007
                                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat505_01_bcl3" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   
   LET ls_group = "xrcd_t2"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat505_01_bcl4 USING g_enterprise,g_fabo6_d[g_detail_idx].xrcdld,g_fabo6_d[g_detail_idx].xrcddocno, 
                                              g_fabo6_d[g_detail_idx].xrcdseq,'2', 
                                              g_fabo6_d[g_detail_idx].xrcd007
                                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat505_01_bcl4" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL afat505_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "fabo_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat505_01_bcl USING g_enterprise,
                                       g_fabo_d[g_detail_idx].fabold,g_fabo_d[g_detail_idx].fabodocno, 
                                           g_fabo_d[g_detail_idx].faboseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat505_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat505_01_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   LET ls_group = ""
   
   CLOSE afat505_01_bcl2
   CLOSE afat505_01_bcl3
   CLOSE afat505_01_bcl4
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE afat505_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION afat505_01_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "fabodocno"
      WHEN "s_detail2"
         LET ls_return = "fabodocno_2"
      WHEN "s_detail7"
         LET ls_return = "fabodocno_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      WHEN "s_detail3"
         LET ls_return = "fabudocno_3"
      WHEN "s_detail4"
         LET ls_return = "fabudocno_4"
      WHEN "s_detail5"
         LET ls_return = "xrcddocno_5"
      WHEN "s_detail6"
         LET ls_return = "xrcddocno_6"
      WHEN "s_detail8"
         LET ls_return = "fabudocno_8"
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afat505_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION afat505_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="afat505_01.mask_functions" >}
&include "erp/afa/afat505_01_mask.4gl"
 
{</section>}
 
{<section id="afat505_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat505_01_set_pk_array()
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
   LET g_pk_array[1].values = g_fabo_d[l_ac].fabold
   LET g_pk_array[1].column = 'fabold'
   LET g_pk_array[2].values = g_fabo_d[l_ac].fabodocno
   LET g_pk_array[2].column = 'fabodocno'
   LET g_pk_array[3].values = g_fabo_d[l_ac].faboseq
   LET g_pk_array[3].column = 'faboseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat505_01.state_change" >}
   
 
{</section>}
 
{<section id="afat505_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat505_01.other_function" readonly="Y" >}
# 營運據點、部門、利潤/成本中心名稱
PRIVATE FUNCTION afat505_01_fabo031_desc(p_ooef001)
   DEFINE p_ooef001       LIKE ooef_t.ooef001
   DEFINE r_fabo031_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_fabo031_desc = '', g_rtn_fields[1] , ''

   RETURN r_fabo031_desc
END FUNCTION
# 區域名稱
PRIVATE FUNCTION afat505_01_fabo034_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001  LIKE oocq_t.oocq001
   DEFINE p_oocq002  LIKE oocq_t.oocq002
   DEFINE r_oocql004 LIKE oocql_t.oocql004 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocq001
   LET g_ref_fields[2] = p_oocq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   
   RETURN r_oocql004
END FUNCTION
# 交易客商/帳款客商名稱
PRIVATE FUNCTION afat505_01_fabo035_desc(p_pmaa001)
   DEFINE p_pmaa001  LIKE pmaa_t.pmaa001
   DEFINE r_pmaal004 LIKE pmaal_t.pmaal004    
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , '' 

   RETURN r_pmaal004
END FUNCTION
# 人員名稱
PRIVATE FUNCTION afat505_01_fabo038_desc(p_fabo038)
   DEFINE p_fabo038         LIKE fabo_t.fabo038
   DEFINE r_fabo038_desc    LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabo038
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET r_fabo038_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_fabo038_desc
END FUNCTION
# 專案編號名稱
PRIVATE FUNCTION afat505_01_fabo039_desc(p_fabo039)
   DEFINE p_fabo039          LIKE fabo_t.fabo039
   DEFINE r_fabo039_desc     LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabo039
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_fabo039_desc = '', g_rtn_fields[1] , ''

   RETURN r_fabo039_desc
END FUNCTION
# WBS名稱
PRIVATE FUNCTION afat505_01_fabo040_desc(p_fabo039,p_fabo040)
   DEFINE p_fabo039             LIKE fabo_t.fabo039
   DEFINE p_fabo040             LIKE fabo_t.fabo040
   DEFINE r_fabo040_desc        LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabo039
   LET g_ref_fields[2] = p_fabo040
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_fabo040_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_fabo040_desc
END FUNCTION
# 科目名稱
PRIVATE FUNCTION afat505_01_fabo024_desc(p_fabo024)
   DEFINE p_fabo024       LIKE fabo_t.fabo024
   DEFINE r_fabo024_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = p_fabo024
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_fabo024_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_fabo024_desc
END FUNCTION
# 稅別名稱
PRIVATE FUNCTION afat505_01_xrcd002_desc(p_xrcd002)
   DEFINE p_xrcd002         LIKE xrcd_t.xrcd002
   DEFINE r_xrcd002_desc    LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = p_xrcd002
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_xrcd002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_xrcd002_desc
END FUNCTION
# 抓取匯率
PRIVATE FUNCTION afat505_01_get_exrate(p_date,p_ooam003,p_ooan002,p_type)
   DEFINE p_date       LIKE nmbs_t.nmbsdocdt
   DEFINE p_ooam003    LIKE ooam_t.ooam003
   DEFINE p_ooan002    LIKE ooan_t.ooan002
   DEFINE p_type       LIKE glaa_t.glaa018
   DEFINE r_exrate     LIKE nmbt_t.nmbt121
   
                          #匯率參照表;帳套;         日期;  來源幣別
   CALL s_aooi160_get_exrate('2',g_fabgld,p_date,p_ooam003,
                             #目的幣別; 交易金額; 匯類類型
                             p_ooan002,0,p_type)
   RETURNING r_exrate  
   
   RETURN r_exrate  
END FUNCTION
#本位幣二三欄位顯示
PRIVATE FUNCTION afat505_01_visible()
   
   CALL cl_set_comp_visible('lbl_page7,lbl_page8',TRUE) 
   IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('lbl_page7,lbl_page8',FALSE)
   END IF 
   
   IF g_glaa015 = 'N' THEN 
      CALL cl_set_comp_visible('fabo107_7,fabo101_7,fabo102_7,fabo111_7,fabo103_7,fabo104_7,fabo105_7,fabo106_7,fabo108,fabo109,fabo110',FALSE)
      CALL cl_set_comp_visible('fabu106_8,fabu101_8,fabu102_8,fabu107_8,fabu103_8,fabu104_8,fabu105_8',FALSE)
   ELSE
      CALL cl_set_comp_visible('fabo107_7,fabo101_7,fabo102_7,fabo111_7,fabo103_7,fabo104_7,fabo105_7,fabo106_7,fabo108,fabo109,fabo110',TRUE)
      CALL cl_set_comp_visible('fabu106_8,fabu101_8,fabu102_8,fabu107_8,fabu103_8,fabu104_8,fabu105_8',TRUE)
   END IF
   
   IF g_glaa019 = 'N' THEN 
      CALL cl_set_comp_visible('fabo156_7,fabo150_7,fabo151_7,fabo160_7,fabo152_7,fabo153_7,fabo154_7,fabo155_7,fabo157,fabo158,fabo159',FALSE)
      CALL cl_set_comp_visible('fabu155_8,fabu150_8,fabu151_8,fabu156_8,fabu152_8,fabu153_8,fabu154_8',FALSE)
   ELSE
      CALL cl_set_comp_visible('fabo156_7,fabo150_7,fabo151_7,fabo160_7,fabo152_7,fabo153_7,fabo154_7,fabo155_7,fabo157,fabo158,fabo159',TRUE)
      CALL cl_set_comp_visible('fabu155_8,fabu150_8,fabu151_8,fabu156_8,fabu152_8,fabu153_8,fabu154_8',TRUE)
   END IF
END FUNCTION
# 撥出所有組織產生出售單
PRIVATE FUNCTION afat505_01_fabo_4_ins()
   #161111-00028#8----modify----begin---------
   #DEFINE l_fabg       RECORD LIKE fabg_t.*
   #DEFINE l_fabo       RECORD LIKE fabo_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabg020 LIKE fabg_t.fabg020    #資產性質
       END RECORD
DEFINE l_fabo RECORD  #資產出售單身檔
       faboent LIKE fabo_t.faboent, #企業編碼
       fabold LIKE fabo_t.fabold, #帳套
       fabodocno LIKE fabo_t.fabodocno, #異動單號
       faboseq LIKE fabo_t.faboseq, #項次
       fabo000 LIKE fabo_t.fabo000, #資產類型
       fabo001 LIKE fabo_t.fabo001, #財產編號
       fabo002 LIKE fabo_t.fabo002, #附號
       fabo003 LIKE fabo_t.fabo003, #卡片編號
       fabo004 LIKE fabo_t.fabo004, #未折減額
       fabo005 LIKE fabo_t.fabo005, #單位
       fabo006 LIKE fabo_t.fabo006, #單價
       fabo007 LIKE fabo_t.fabo007, #調撥/出售數量
       fabo008 LIKE fabo_t.fabo008, #成本
       fabo009 LIKE fabo_t.fabo009, #稅別
       fabo010 LIKE fabo_t.fabo010, #交易幣別
       fabo011 LIKE fabo_t.fabo011, #原幣匯率
       fabo012 LIKE fabo_t.fabo012, #原幣未稅金額
       fabo013 LIKE fabo_t.fabo013, #原幣稅額
       fabo014 LIKE fabo_t.fabo014, #原幣應收金額
       fabo015 LIKE fabo_t.fabo015, #本幣未稅金額
       fabo016 LIKE fabo_t.fabo016, #本幣稅額
       fabo017 LIKE fabo_t.fabo017, #本幣應收金額
       fabo018 LIKE fabo_t.fabo018, #處置成本
       fabo019 LIKE fabo_t.fabo019, #處置累折
       fabo020 LIKE fabo_t.fabo020, #處置減值準備
       fabo021 LIKE fabo_t.fabo021, #處置本期折舊
       fabo022 LIKE fabo_t.fabo022, #處置未折減額
       fabo023 LIKE fabo_t.fabo023, #異動原因
       fabo024 LIKE fabo_t.fabo024, #異動科目
       fabo025 LIKE fabo_t.fabo025, #處置預留殘值
       fabo026 LIKE fabo_t.fabo026, #累折科目
       fabo027 LIKE fabo_t.fabo027, #減值準備科目
       fabo028 LIKE fabo_t.fabo028, #資產科目
       fabo029 LIKE fabo_t.fabo029, #應收帳款科目
       fabo030 LIKE fabo_t.fabo030, #稅額科目
       fabo031 LIKE fabo_t.fabo031, #營運據點
       fabo032 LIKE fabo_t.fabo032, #部門
       fabo033 LIKE fabo_t.fabo033, #利潤/成本中心
       fabo034 LIKE fabo_t.fabo034, #區域
       fabo035 LIKE fabo_t.fabo035, #交易客商
       fabo036 LIKE fabo_t.fabo036, #帳款客商
       fabo037 LIKE fabo_t.fabo037, #客群
       fabo038 LIKE fabo_t.fabo038, #人員
       fabo039 LIKE fabo_t.fabo039, #專案編號
       fabo040 LIKE fabo_t.fabo040, #WBS
       fabo041 LIKE fabo_t.fabo041, #帳款編號
       fabo042 LIKE fabo_t.fabo042, #摘要
       fabo043 LIKE fabo_t.fabo043, #調出管理組織
       fabo044 LIKE fabo_t.fabo044, #調出所有組織
       fabo045 LIKE fabo_t.fabo045, #調出核算組織
       fabo046 LIKE fabo_t.fabo046, #調入管理組織
       fabo047 LIKE fabo_t.fabo047, #調入所有組織
       fabo048 LIKE fabo_t.fabo048, #調入核算組織
       fabo049 LIKE fabo_t.fabo049, #處分損益
       fabo050 LIKE fabo_t.fabo050, #應收帳款單號
       fabo051 LIKE fabo_t.fabo051, #交易價格差異
       fabo052 LIKE fabo_t.fabo052, #應付帳款單號
       fabo053 LIKE fabo_t.fabo053, #已計提減值準備
       fabo054 LIKE fabo_t.fabo054, #經營方式
       fabo055 LIKE fabo_t.fabo055, #通路
       fabo056 LIKE fabo_t.fabo056, #品牌
       fabo060 LIKE fabo_t.fabo060, #自由核算項一
       fabo061 LIKE fabo_t.fabo061, #自由核算項二
       fabo062 LIKE fabo_t.fabo062, #自由核算項三
       fabo063 LIKE fabo_t.fabo063, #自由核算項四
       fabo064 LIKE fabo_t.fabo064, #自由核算項五
       fabo065 LIKE fabo_t.fabo065, #自由核算項六
       fabo066 LIKE fabo_t.fabo066, #自由核算項七
       fabo067 LIKE fabo_t.fabo067, #自由核算項八
       fabo068 LIKE fabo_t.fabo068, #自由核算項九
       fabo069 LIKE fabo_t.fabo069, #自由核算項十
       fabo101 LIKE fabo_t.fabo101, #本位幣二幣別
       fabo102 LIKE fabo_t.fabo102, #本位幣二匯率
       fabo103 LIKE fabo_t.fabo103, #本位幣二未稅金額
       fabo104 LIKE fabo_t.fabo104, #本位幣二稅額
       fabo105 LIKE fabo_t.fabo105, #本位幣二應收金額
       fabo106 LIKE fabo_t.fabo106, #本位幣二處份損益
       fabo107 LIKE fabo_t.fabo107, #本位幣二處置成本
       fabo108 LIKE fabo_t.fabo108, #本位幣二處置累折
       fabo109 LIKE fabo_t.fabo109, #本位幣二處置減值準備
       fabo110 LIKE fabo_t.fabo110, #本位幣二本期處置折舊
       fabo111 LIKE fabo_t.fabo111, #本位幣二處置後未折減額
       fabo150 LIKE fabo_t.fabo150, #本位幣三幣別
       fabo151 LIKE fabo_t.fabo151, #本位幣三匯率
       fabo152 LIKE fabo_t.fabo152, #本位幣三未稅金額
       fabo153 LIKE fabo_t.fabo153, #本位幣三稅額
       fabo154 LIKE fabo_t.fabo154, #本位幣三應收金額
       fabo155 LIKE fabo_t.fabo155, #本位幣三處份損益
       fabo156 LIKE fabo_t.fabo156, #本位幣三處置成本
       fabo157 LIKE fabo_t.fabo157, #本位幣三處置累折
       fabo158 LIKE fabo_t.fabo158, #本位幣三處置減值準備
       fabo159 LIKE fabo_t.fabo159, #本位幣三本期處置折舊
       fabo160 LIKE fabo_t.fabo160, #本位幣三處置後未折減額
       fabo112 LIKE fabo_t.fabo112, #本位幣二處置預留殘值
       fabo161 LIKE fabo_t.fabo161  #本位幣三處置預留殘值
       END RECORD
   #161111-00028#8----modify----end-----------
   DEFINE l_fabgdocno  LIKE fabg_t.fabgdocno
   DEFINE l_fabo047    LIKE fabo_t.fabo047
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_oodbl004   LIKE oodbL_t.oodbl004
   DEFINE l_oodb005    LIKE oodb_t.oodb005
   DEFINE l_oodb006    LIKE oodb_t.oodb006
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_lisp       LIKE ooba_t.ooba002
   DEFINE l_sql        STRING
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE r_xrcd103    LIKE xrcd_t.xrcd103
   DEFINE r_xrcd104    LIKE xrcd_t.xrcd104
   DEFINE r_xrcd105    LIKE xrcd_t.xrcd105
   DEFINE r_xrcd113    LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114    LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115    LIKE xrcd_t.xrcd115
   DEFINE r_xrcd123    LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124    LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125    LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133    LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134    LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135    LIKE xrcd_t.xrcd115
   
   SELECT fabgdocno INTO l_fabgdocno
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgld  = g_fabgld
      AND fabg019 = g_fabgdocno
      
   CALL s_tax_chk(g_glaacomp,g_fabo_d[l_ac].fabo009)
      RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
   
   SELECT fabo047 INTO l_fabo047 FROM fabo_t
    WHERE faboent = g_enterprise AND fabold = g_fabgld
      AND fabodocno = g_fabgdocno AND faboseq = g_faboseq
   
   IF NOT cl_null(l_fabgdocno) THEN 
      #刪除單身
      DELETE FROM fabo_t 
       WHERE faboent   = g_enterprise
         AND fabold    = g_fabgld
         AND fabodocno = l_fabgdocno 
         AND faboseq   = g_faboseq
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del fabo_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #刪除交易稅明細檔
      DELETE FROM xrcd_t
       WHERE xrcdent   = g_enterprise
         AND xrcdld    = g_fabgld
         AND xrcddocno = l_fabgdocno
         AND xrcdseq   = g_faboseq
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del xrcd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      UPDATE fabg_t SET fabg006 = l_fabo047, 
                        fabg007 = l_fabo047,
                        fabg013 = g_fabo_d[l_ac].fabo009,
                        fabg014 = l_oodb006,
                        fabg015 = g_fabo_d[l_ac].fabo010,
                        fabg016 = g_fabo_d[l_ac].fabo011
       WHERE fabgent = g_enterprise
         AND fabgld  = g_fabgld
         AND fabgdocno = l_fabgdocno
                        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd fabg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   ELSE
      #161111-00028#8----modify----begin---------
      #SELECT * INTO l_fabg.*
      SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,fabg006,
             fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,fabg018,fabg019,
             fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,
             fabgpstdt,fabgud001,fabgud002,fabgud003,fabgud004,fabgud005,fabgud006,fabgud007,fabgud008,fabgud009,fabgud010,
             fabgud011,fabgud012,fabgud013,fabgud014,fabgud015,fabgud016,fabgud017,fabgud018,fabgud019,fabgud020,fabgud021,
             fabgud022,fabgud023,fabgud024,fabgud025,fabgud026,fabgud027,fabgud028,fabgud029,fabgud030,fabg020 INTO l_fabg.*
      #161111-00028#8----modify----end---------
        FROM fabg_t 
       WHERE fabgent   = g_enterprise
         AND fabgld    = g_fabgld
         AND fabgdocno = g_fabgdocno
         
      LET l_fabg.fabg005 = '4'
      LET l_fabg.fabg006 = l_fabo047
      LET l_fabg.fabg007 = l_fabo047
      LET l_fabg.fabg013 = g_fabo_d[l_ac].fabo009
      LET l_fabg.fabg014 = l_oodb006
      LET l_fabg.fabg015 = g_fabo_d[l_ac].fabo010
      LET l_fabg.fabg016 = g_fabo_d[l_ac].fabo011
      LET l_fabg.fabg019 = g_fabgdocno
      
      #抓取單別
      CALL s_aooi200_get_slip(g_fabgdocno) RETURNING l_success,l_lisp
                  
      SELECT oobn003 INTO l_ooba002
        FROM oobn_t
       WHERE oobnent = g_enterprise
         AND oobn001 = 'afat504'
         AND oobn002 = l_lisp
         
      IF cl_null(l_ooba002) THEN 
         LET l_sql = "SELECT ooba002 FROM ooba_t,oobl_t ",
                     " WHERE oobaent = '",g_enterprise,"'",
                     "   AND oobaent = ooblent ",
                     "   AND ooba002 = oobl001 ",
                     "   AND oobl002 = 'afat504'"
         PREPARE ooba002_pre FROM l_sql
         DECLARE ooba002_cur CURSOR FOR ooba002_pre
         OPEN ooba002_cur
         FETCH ooba002_cur INTO l_ooba002
      END IF
      
      CALL s_aooi200_gen_docno(g_glaacomp,l_ooba002,l_fabg.fabgdocdt,'afat504')
      RETURNING l_success,l_fabgdocno
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_fabg.fabgdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF 
      LET l_fabg.fabgdocno = l_fabgdocno
      
      #插入單頭檔
      #161111-00028#8----modify----begin---------
      #INSERT INTO fabg_t VALUES(l_fabg.*)
      INSERT INTO fabg_t (fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,fabg005,
                          fabg006,fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,fabg017,
                          fabg018,fabg019,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,
                          fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt,fabg020)
        VALUES(l_fabg.fabgent,l_fabg.fabgcomp,l_fabg.fabgld,l_fabg.fabgdocno,l_fabg.fabgdocdt,l_fabg.fabgsite,l_fabg.fabg001,l_fabg.fabg002,l_fabg.fabg003,l_fabg.fabg004,l_fabg.fabg005,
               l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg008,l_fabg.fabg009,l_fabg.fabg010,l_fabg.fabg011,l_fabg.fabg012,l_fabg.fabg013,l_fabg.fabg014,l_fabg.fabg015,l_fabg.fabg016,l_fabg.fabg017,
               l_fabg.fabg018,l_fabg.fabg019,l_fabg.fabgstus,l_fabg.fabgownid,l_fabg.fabgowndp,l_fabg.fabgcrtid,l_fabg.fabgcrtdp,l_fabg.fabgcrtdt,l_fabg.fabgmodid,l_fabg.fabgmoddt,
               l_fabg.fabgcnfid,l_fabg.fabgcnfdt,l_fabg.fabgpstid,l_fabg.fabgpstdt,l_fabg.fabg020)
      #161111-00028#8----modify----end---------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins fabg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   
   #插入單身檔
  #161111-00028#8----modify----begin--------- 
  #SELECT * INTO l_fabo.*
   SELECT faboent,fabold,fabodocno,faboseq,fabo000,fabo001,fabo002,fabo003,fabo004,fabo005,fabo006,fabo007,
          fabo008,fabo009,fabo010,fabo011,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo018,fabo019,
          fabo020,fabo021,fabo022,fabo023,fabo024,fabo025,fabo026,fabo027,fabo028,fabo029,fabo030,fabo031,
          fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo041,fabo042,fabo043,
          fabo044,fabo045,fabo046,fabo047,fabo048,fabo049,fabo050,fabo051,fabo052,fabo053,fabo054,fabo055,
          fabo056,fabo060,fabo061,fabo062,fabo063,fabo064,fabo065,fabo066,fabo067,fabo068,fabo069,fabo101,
          fabo102,fabo103,fabo104,fabo105,fabo106,fabo107,fabo108,fabo109,fabo110,fabo111,fabo150,fabo151,
          fabo152,fabo153,fabo154,fabo155,fabo156,fabo157,fabo158,fabo159,fabo160,fabo112,fabo161 INTO l_fabo.*
  #161111-00028#8----modify----end---------
     FROM fabo_t    
    WHERE faboent   = g_enterprise
      AND fabold    = g_fabgld
      AND fabodocno = g_fabgdocno 
      AND faboseq   = g_faboseq
      
   LET l_fabo.fabodocno = l_fabgdocno
   
   #161111-00028#8----modify----begin---------    
   #INSERT INTO fabo_t VALUES(l_fabo.*)
   INSERT INTO fabo_t (faboent,fabold,fabodocno,faboseq,fabo000,fabo001,fabo002,fabo003,fabo004,fabo005,fabo006,fabo007,
                       fabo008,fabo009,fabo010,fabo011,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo018,fabo019,
                       fabo020,fabo021,fabo022,fabo023,fabo024,fabo025,fabo026,fabo027,fabo028,fabo029,fabo030,fabo031,
                       fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo041,fabo042,fabo043,
                       fabo044,fabo045,fabo046,fabo047,fabo048,fabo049,fabo050,fabo051,fabo052,fabo053,fabo054,fabo055,
                       fabo056,fabo060,fabo061,fabo062,fabo063,fabo064,fabo065,fabo066,fabo067,fabo068,fabo069,fabo101,
                       fabo102,fabo103,fabo104,fabo105,fabo106,fabo107,fabo108,fabo109,fabo110,fabo111,fabo150,fabo151,
                       fabo152,fabo153,fabo154,fabo155,fabo156,fabo157,fabo158,fabo159,fabo160,fabo112,fabo161) 
    VALUES(l_fabo.faboent,l_fabo.fabold,l_fabo.fabodocno,l_fabo.faboseq,l_fabo.fabo000,l_fabo.fabo001,l_fabo.fabo002,l_fabo.fabo003,l_fabo.fabo004,l_fabo.fabo005,l_fabo.fabo006,l_fabo.fabo007,
           l_fabo.fabo008,l_fabo.fabo009,l_fabo.fabo010,l_fabo.fabo011,l_fabo.fabo012,l_fabo.fabo013,l_fabo.fabo014,l_fabo.fabo015,l_fabo.fabo016,l_fabo.fabo017,l_fabo.fabo018,l_fabo.fabo019,
           l_fabo.fabo020,l_fabo.fabo021,l_fabo.fabo022,l_fabo.fabo023,l_fabo.fabo024,l_fabo.fabo025,l_fabo.fabo026,l_fabo.fabo027,l_fabo.fabo028,l_fabo.fabo029,l_fabo.fabo030,l_fabo.fabo031,
           l_fabo.fabo032,l_fabo.fabo033,l_fabo.fabo034,l_fabo.fabo035,l_fabo.fabo036,l_fabo.fabo037,l_fabo.fabo038,l_fabo.fabo039,l_fabo.fabo040,l_fabo.fabo041,l_fabo.fabo042,l_fabo.fabo043,
           l_fabo.fabo044,l_fabo.fabo045,l_fabo.fabo046,l_fabo.fabo047,l_fabo.fabo048,l_fabo.fabo049,l_fabo.fabo050,l_fabo.fabo051,l_fabo.fabo052,l_fabo.fabo053,l_fabo.fabo054,l_fabo.fabo055,
           l_fabo.fabo056,l_fabo.fabo060,l_fabo.fabo061,l_fabo.fabo062,l_fabo.fabo063,l_fabo.fabo064,l_fabo.fabo065,l_fabo.fabo066,l_fabo.fabo067,l_fabo.fabo068,l_fabo.fabo069,l_fabo.fabo101,
           l_fabo.fabo102,l_fabo.fabo103,l_fabo.fabo104,l_fabo.fabo105,l_fabo.fabo106,l_fabo.fabo107,l_fabo.fabo108,l_fabo.fabo109,l_fabo.fabo110,l_fabo.fabo111,l_fabo.fabo150,l_fabo.fabo151,
           l_fabo.fabo152,l_fabo.fabo153,l_fabo.fabo154,l_fabo.fabo155,l_fabo.fabo156,l_fabo.fabo157,l_fabo.fabo158,l_fabo.fabo159,l_fabo.fabo160,l_fabo.fabo112,l_fabo.fabo161)
   #161111-00028#8----modify----end--------- 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins fabo_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #插入交易稅明細檔
   CALL s_tax_ins(l_fabgdocno,g_faboseq,0,g_glaacomp,
                  g_fabo_d[l_ac].fabo014,g_fabo_d[l_ac].fabo009,
                  g_fabo007,g_fabo_d[l_ac].fabo010,g_fabo_d[l_ac].fabo011,g_fabgld,g_fabo7_d[l_ac].fabo102,g_fabo7_d[l_ac].fabo151)
     RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
               r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
   
END FUNCTION
# 撥入所有組織產生新的卡片資料
PRIVATE FUNCTION afat505_01_faah_ins()
   #161111-00028#8----modify----begin-----------
   #DEFINE l_fabo       RECORD  LIKE fabo_t.*
   DEFINE l_fabo RECORD  #資產出售單身檔
       faboent LIKE fabo_t.faboent, #企業編碼
       fabold LIKE fabo_t.fabold, #帳套
       fabodocno LIKE fabo_t.fabodocno, #異動單號
       faboseq LIKE fabo_t.faboseq, #項次
       fabo000 LIKE fabo_t.fabo000, #資產類型
       fabo001 LIKE fabo_t.fabo001, #財產編號
       fabo002 LIKE fabo_t.fabo002, #附號
       fabo003 LIKE fabo_t.fabo003, #卡片編號
       fabo004 LIKE fabo_t.fabo004, #未折減額
       fabo005 LIKE fabo_t.fabo005, #單位
       fabo006 LIKE fabo_t.fabo006, #單價
       fabo007 LIKE fabo_t.fabo007, #調撥/出售數量
       fabo008 LIKE fabo_t.fabo008, #成本
       fabo009 LIKE fabo_t.fabo009, #稅別
       fabo010 LIKE fabo_t.fabo010, #交易幣別
       fabo011 LIKE fabo_t.fabo011, #原幣匯率
       fabo012 LIKE fabo_t.fabo012, #原幣未稅金額
       fabo013 LIKE fabo_t.fabo013, #原幣稅額
       fabo014 LIKE fabo_t.fabo014, #原幣應收金額
       fabo015 LIKE fabo_t.fabo015, #本幣未稅金額
       fabo016 LIKE fabo_t.fabo016, #本幣稅額
       fabo017 LIKE fabo_t.fabo017, #本幣應收金額
       fabo018 LIKE fabo_t.fabo018, #處置成本
       fabo019 LIKE fabo_t.fabo019, #處置累折
       fabo020 LIKE fabo_t.fabo020, #處置減值準備
       fabo021 LIKE fabo_t.fabo021, #處置本期折舊
       fabo022 LIKE fabo_t.fabo022, #處置未折減額
       fabo023 LIKE fabo_t.fabo023, #異動原因
       fabo024 LIKE fabo_t.fabo024, #異動科目
       fabo025 LIKE fabo_t.fabo025, #處置預留殘值
       fabo026 LIKE fabo_t.fabo026, #累折科目
       fabo027 LIKE fabo_t.fabo027, #減值準備科目
       fabo028 LIKE fabo_t.fabo028, #資產科目
       fabo029 LIKE fabo_t.fabo029, #應收帳款科目
       fabo030 LIKE fabo_t.fabo030, #稅額科目
       fabo031 LIKE fabo_t.fabo031, #營運據點
       fabo032 LIKE fabo_t.fabo032, #部門
       fabo033 LIKE fabo_t.fabo033, #利潤/成本中心
       fabo034 LIKE fabo_t.fabo034, #區域
       fabo035 LIKE fabo_t.fabo035, #交易客商
       fabo036 LIKE fabo_t.fabo036, #帳款客商
       fabo037 LIKE fabo_t.fabo037, #客群
       fabo038 LIKE fabo_t.fabo038, #人員
       fabo039 LIKE fabo_t.fabo039, #專案編號
       fabo040 LIKE fabo_t.fabo040, #WBS
       fabo041 LIKE fabo_t.fabo041, #帳款編號
       fabo042 LIKE fabo_t.fabo042, #摘要
       fabo043 LIKE fabo_t.fabo043, #調出管理組織
       fabo044 LIKE fabo_t.fabo044, #調出所有組織
       fabo045 LIKE fabo_t.fabo045, #調出核算組織
       fabo046 LIKE fabo_t.fabo046, #調入管理組織
       fabo047 LIKE fabo_t.fabo047, #調入所有組織
       fabo048 LIKE fabo_t.fabo048, #調入核算組織
       fabo049 LIKE fabo_t.fabo049, #處分損益
       fabo050 LIKE fabo_t.fabo050, #應收帳款單號
       fabo051 LIKE fabo_t.fabo051, #交易價格差異
       fabo052 LIKE fabo_t.fabo052, #應付帳款單號
       fabo053 LIKE fabo_t.fabo053, #已計提減值準備
       fabo054 LIKE fabo_t.fabo054, #經營方式
       fabo055 LIKE fabo_t.fabo055, #通路
       fabo056 LIKE fabo_t.fabo056, #品牌
       fabo060 LIKE fabo_t.fabo060, #自由核算項一
       fabo061 LIKE fabo_t.fabo061, #自由核算項二
       fabo062 LIKE fabo_t.fabo062, #自由核算項三
       fabo063 LIKE fabo_t.fabo063, #自由核算項四
       fabo064 LIKE fabo_t.fabo064, #自由核算項五
       fabo065 LIKE fabo_t.fabo065, #自由核算項六
       fabo066 LIKE fabo_t.fabo066, #自由核算項七
       fabo067 LIKE fabo_t.fabo067, #自由核算項八
       fabo068 LIKE fabo_t.fabo068, #自由核算項九
       fabo069 LIKE fabo_t.fabo069, #自由核算項十
       fabo101 LIKE fabo_t.fabo101, #本位幣二幣別
       fabo102 LIKE fabo_t.fabo102, #本位幣二匯率
       fabo103 LIKE fabo_t.fabo103, #本位幣二未稅金額
       fabo104 LIKE fabo_t.fabo104, #本位幣二稅額
       fabo105 LIKE fabo_t.fabo105, #本位幣二應收金額
       fabo106 LIKE fabo_t.fabo106, #本位幣二處份損益
       fabo107 LIKE fabo_t.fabo107, #本位幣二處置成本
       fabo108 LIKE fabo_t.fabo108, #本位幣二處置累折
       fabo109 LIKE fabo_t.fabo109, #本位幣二處置減值準備
       fabo110 LIKE fabo_t.fabo110, #本位幣二本期處置折舊
       fabo111 LIKE fabo_t.fabo111, #本位幣二處置後未折減額
       fabo150 LIKE fabo_t.fabo150, #本位幣三幣別
       fabo151 LIKE fabo_t.fabo151, #本位幣三匯率
       fabo152 LIKE fabo_t.fabo152, #本位幣三未稅金額
       fabo153 LIKE fabo_t.fabo153, #本位幣三稅額
       fabo154 LIKE fabo_t.fabo154, #本位幣三應收金額
       fabo155 LIKE fabo_t.fabo155, #本位幣三處份損益
       fabo156 LIKE fabo_t.fabo156, #本位幣三處置成本
       fabo157 LIKE fabo_t.fabo157, #本位幣三處置累折
       fabo158 LIKE fabo_t.fabo158, #本位幣三處置減值準備
       fabo159 LIKE fabo_t.fabo159, #本位幣三本期處置折舊
       fabo160 LIKE fabo_t.fabo160, #本位幣三處置後未折減額
       fabo112 LIKE fabo_t.fabo112, #本位幣二處置預留殘值
       fabo161 LIKE fabo_t.fabo161  #本位幣三處置預留殘值
       END RECORD
   #161111-00028#8----modify----end-----------
   DEFINE l_faah000    LIKE faah_t.faah000
   DEFINE l_faah001    LIKE faah_t.faah001
   DEFINE l_faah001_1  LIKE faah_t.faah001
   DEFINE l_year       STRING
   DEFINE l_month      STRING
   DEFINE l_str        STRING
   DEFINE ls_sql       STRING
   DEFINE l_ooab002    LIKE ooab_t.ooab002
   DEFINE l_ooef017    LIKE ooef_t.ooef017
   DEFINE l_fabiseq1   LIKE fabi_t.fabiseq1
   DEFINE l_fabi004    LIKE fabi_t.fabi004
   DEFINE l_fabi007    LIKE fabi_t.fabi007
   DEFINE l_sql        STRING
   
   DROP TABLE afat505_tmp
   DROP TABLE afat505_tmp1
   DROP TABLE afat505_tmp2
   
   #161111-00028#8----modify----begin--------- 
  #SELECT * INTO l_fabo.*
   SELECT faboent,fabold,fabodocno,faboseq,fabo000,fabo001,fabo002,fabo003,fabo004,fabo005,fabo006,fabo007,
          fabo008,fabo009,fabo010,fabo011,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo018,fabo019,
          fabo020,fabo021,fabo022,fabo023,fabo024,fabo025,fabo026,fabo027,fabo028,fabo029,fabo030,fabo031,
          fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo041,fabo042,fabo043,
          fabo044,fabo045,fabo046,fabo047,fabo048,fabo049,fabo050,fabo051,fabo052,fabo053,fabo054,fabo055,
          fabo056,fabo060,fabo061,fabo062,fabo063,fabo064,fabo065,fabo066,fabo067,fabo068,fabo069,fabo101,
          fabo102,fabo103,fabo104,fabo105,fabo106,fabo107,fabo108,fabo109,fabo110,fabo111,fabo150,fabo151,
          fabo152,fabo153,fabo154,fabo155,fabo156,fabo157,fabo158,fabo159,fabo160,fabo112,fabo161 INTO l_fabo.*
  #161111-00028#8----modify----end---------
     FROM fabo_t
    WHERE faboent   = g_enterprise
      AND fabold    = g_fabgld
      AND fabodocno = g_fabgdocno
      AND faboseq   = g_faboseq
   
   #根據財編，附號和調撥單號抓取需刪除的卡片編號
   SELECT UNIQUE faah001 INTO l_faah001_1 FROM faah_t 
    WHERE faahent = g_enterprise AND faah003 = g_fabo001 AND faah004 = g_fabo002 
      AND faah001 <> g_fabo003 AND faah040 = g_fabgdocno   
   
   DELETE FROM faah_t WHERE faahent = g_enterprise AND faah003 = g_fabo001 AND faah004 = g_fabo002 AND faah001 <> g_fabo003 AND faah040 = g_fabgdocno
   DELETE FROM faai_t WHERE faaient = g_enterprise AND faai002 = g_fabo001 AND faai003 = g_fabo002 AND faai001 <> g_fabo003 AND faai001 = l_faah001_1
   DELETE FROM faaj_t WHERE faajent = g_enterprise AND faaj001 = g_fabo001 AND faaj002 = g_fabo002 AND faaj037 <> g_fabo003 AND faaj037 = l_faah001_1
   
   #重新產生一筆新的faah_t資料
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE afat505_tmp AS ",
                "SELECT * FROM faah_t "
   PREPARE afat505_tmp_pre FROM ls_sql
   EXECUTE afat505_tmp_pre
   FREE afat505_tmp_pre
   
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO afat505_tmp SELECT * FROM faah_t 
                            WHERE faahent = g_enterprise 
                              AND faah003 = g_fabo001
                              AND faah004 = g_fabo002
                              AND faah001 = g_fabo003
   
   #卡片編號,生成批號自動+1
   SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_faah001
     FROM faah_t
    WHERE faahent = g_enterprise
   
   IF cl_null(l_faah001) THEN 
      LET l_faah001 = 1
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
      LET l_faah000 = l_str,'0001'
   ELSE
      LET g_sql = "SELECT lpad((lpad((substr(MAX(faah000),7,10) + 1),4,'0')),10,'",l_str,"')",
                  "  FROM faah_t ",
                  " WHERE faahent = '",g_enterprise,"'",
                  "   AND faah000 LIKE '",l_str,"%'"
      PREPARE faah000_pre1 FROM g_sql
      EXECUTE faah000_pre1 INTO l_faah000
   END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = l_fabo.fabo047
   #將財產編號,附號修改為正式財產編號,正式附號,其他欄位以單身信息為準
   UPDATE afat505_tmp 
      SET faah000 = l_faah000,
          faah001 = l_faah001,
          faah018 = l_fabo.fabo007,
          faah019 = 0,
          faah028 = l_fabo.fabo047,
          faah030 = l_fabo.fabo046,
          faah031 = l_fabo.fabo048,
          faah032 = l_ooef017,
          faah040 = g_fabgdocno,
          faah015 = '0',
          faahstus = 'N'          
   
   LET g_faah000 = l_faah000
   LET g_faah001 = l_faah001
   #將資料塞回原table   
   INSERT INTO faah_t SELECT * FROM afat505_tmp
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins faah_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #重新產生新的faai_t資料
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE afat505_tmp1 AS ",
                "SELECT * FROM faai_t "
   PREPARE afat505_tmp_pre1 FROM ls_sql
   EXECUTE afat505_tmp_pre1
   FREE afat505_tmp_pre1
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO afat505_tmp1 SELECT * FROM faai_t 
                            WHERE faaient = g_enterprise 
                              AND faai002 = g_fabo001
                              AND faai003 = g_fabo002
                              AND faai001 = g_fabo003
   
   DELETE FROM afat505_tmp1 WHERE faaient = g_enterprise
                              AND faai002 = g_fabo001
                              AND faai003 = g_fabo002
                              AND faai001 = g_fabo003
                              AND faai004 NOT IN( SELECT fabi004 FROM fabi_t WHERE fabient = g_enterprise
                              AND fabidocno = g_fabgdocno 
                              AND fabi002 = g_fabo001
                              AND fabi003 = g_fabo002
                              AND fabi001 = g_fabo003
                              AND fabi000 = '17')
                              
   LET l_sql = " SELECT fabiseq1,fabi004,fabi007 FROM fabi_t ",
               "  WHERE fabient = ",g_enterprise," AND fabidocno = '",g_fabgdocno,"'",
               "    AND fabi002 = '",g_fabo001,"' AND fabi003 = '",g_fabo002,"'",
               "    AND fabi001 = '",g_fabo003,"' AND fabi000 = '17' "
   PREPARE afat505_fabi_prep FROM l_sql
   DECLARE afat505_fabi_curs CURSOR FOR afat505_fabi_prep
   
   FOREACH afat505_fabi_curs INTO l_fabiseq1,l_fabi004,l_fabi007
      UPDATE afat505_tmp1 SET faai007 = l_fabi007,
                              faai008 = 0
                        WHERE faaient = g_enterprise
                              AND faai002 = g_fabo001
                              AND faai003 = g_fabo002
                              AND faai001 = g_fabo003
                              AND faai004 = l_fabi004
                              AND faaiseq1 = l_fabiseq1
   END FOREACH
   
   
   #將財產編號,附號修改為正式財產編號,正式附號,其他欄位以單身信息為準
   UPDATE afat505_tmp1 
      SET faai000 = l_faah000,
          faai001 = l_faah001,
          faai023 = '0'                
   
   #將資料塞回原table   
   INSERT INTO faai_t SELECT * FROM afat505_tmp1
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins faai_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #重新產生新的faaj_t資料
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE afat505_tmp2 AS ",
                "SELECT * FROM faaj_t "
   PREPARE afat505_tmp_pre2 FROM ls_sql
   EXECUTE afat505_tmp_pre2
   FREE afat505_tmp_pre2
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO afat505_tmp2 SELECT * FROM faaj_t 
                            WHERE faajent = g_enterprise 
                              AND faaj001 = g_fabo001
                              AND faaj002 = g_fabo002
                              AND faaj037 = g_fabo003
   
   

   #將財產編號,附號修改為正式財產編號,正式附號,其他欄位以單身信息為準
   UPDATE afat505_tmp2 
      SET faaj000 = l_faah000,
          faaj037 = l_faah001,
          faaj016 = g_fabo3_d[l_ac].fabu017                  
   
   #根絕撥入所有組織取資產調撥價格設定
   CALL cl_get_para(g_enterprise,l_fabo.fabo047,'S-FIN-9016') RETURNING l_ooab002
   IF l_ooab002 = '1' THEN
      UPDATE afat505_tmp2 
         SET faajld = ' ',
             faaj036 = faaj016 - l_fabo.fabo017,
             faaj116 = faaj116 - l_fabo.fabo105,
             faaj166 = faaj166 - l_fabo.fabo154,
             faaj016 = l_fabo.fabo018,
             faaj028 = l_fabo.fabo022,
             faaj017 = l_fabo.fabo019,
             faaj018 = l_fabo.fabo021,
             faaj103 = l_fabo.fabo107,
             faaj104 = l_fabo.fabo108,
             faaj108 = l_fabo.fabo111,
             faaj111 = l_fabo.fabo110,
             faaj153 = l_fabo.fabo156,
             faaj154 = l_fabo.fabo157,
             faaj158 = l_fabo.fabo160,
             faaj161 = l_fabo.fabo159
   ELSE
      #以未折减额调拨，新生成财编的成本和未折减额为拨出处置未折减额值
      UPDATE afat505_tmp2 
         SET faajld = ' ',
             faaj016 = l_fabo.fabo022,
             faaj028 = l_fabo.fabo022,
             faaj017 = 0,
             faaj018 = 0,
             faaj103 = l_fabo.fabo111,
             faaj108 = l_fabo.fabo111,
             faaj104 = 0,
             faaj111 = 0,
             faaj153 = l_fabo.fabo160,
             faaj158 = l_fabo.fabo160,
             faaj154 = 0,
             faaj036 = 0,
             faaj116 = 0,
             faaj161 = 0,
             faaj166 = 0
   END IF
   
   #將資料塞回原table   
   INSERT INTO faaj_t SELECT * FROM afat505_tmp2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins faaj_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   #刪除TEMP TABLE
   DROP TABLE afat505_tmp
   DROP TABLE afat505_tmp1
   DROP TABLE afat505_tmp2
   
   
   
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
PRIVATE FUNCTION afat505_01_fabo009_set_entry(p_oodb005)
DEFINE p_oodb005     LIKE oodb_t.oodb005

   CALL cl_set_comp_entry("fabo012,fabo014",TRUE)
   IF p_oodb005 = 'Y' THEN
#      CALL cl_set_comp_entry("fabo014",FALSE)  #20141113 mark by chenying
      CALL cl_set_comp_entry("fabo014",TRUE)    #20141113 add  by chenying
      CALL cl_set_comp_entry("fabo012",FALSE)   #20141113 add  by chenying        
   ELSE
#      CALL cl_set_comp_entry("fabo012",FALSE)  #20141113 mark by chenying
      CALL cl_set_comp_entry("fabo014",FALSE)   #20141113 add  by chenying 
      CALL cl_set_comp_entry("fabo012",TRUE)    #20141113 add  by chenying       
   END IF
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
PRIVATE FUNCTION afat505_01_fabu009_set_entry(p_oodb005)
DEFINE p_oodb005     LIKE oodb_t.oodb005

   CALL cl_set_comp_entry("fabu012,fabu014",TRUE)
   IF p_oodb005 = 'Y' THEN
      CALL cl_set_comp_entry("fabu014",FALSE)
   ELSE
      CALL cl_set_comp_entry("fabu012",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 計算處置相關金額
# Memo...........:
# Usage..........: CALL afat505_get_amt(p_fah018,p_fabo007)
# Input parameter: p_faah018      未出售數量
#                : p_fabo007      出售數量
# Modify.........:
################################################################################
PRIVATE FUNCTION afat505_01_get_amt(p_faah018,p_fabo007)
   DEFINE p_faah018              LIKE faah_t.faah018
   DEFINE p_fabo007              LIKE fabo_t.fabo007
   DEFINE l_faah005              LIKE faah_t.faah005
   DEFINE l_faaj020              LIKE faaj_t.faaj020
   DEFINE l_faaj021              LIKE faaj_t.faaj021
   DEFINE l_faaj034              LIKE faaj_t.faaj034
   DEFINE l_faaj017              LIKE faaj_t.faaj017
   DEFINE l_faaj035              LIKE faaj_t.faaj035
   DEFINE l_faaj027              LIKE faaj_t.faaj027
   DEFINE l_faaj018              LIKE faaj_t.faaj018
   DEFINE l_faaj032              LIKE faaj_t.faaj032
   DEFINE l_faaj028              LIKE faaj_t.faaj028
   DEFINE l_faaj117              LIKE faaj_t.faaj117
   DEFINE l_faaj113              LIKE faaj_t.faaj113
   DEFINE l_faaj104              LIKE faaj_t.faaj104
   DEFINE l_faaj103              LIKE faaj_t.faaj103
   DEFINE l_faaj114              LIKE faaj_t.faaj114
   DEFINE l_faaj112              LIKE faaj_t.faaj112
   DEFINE l_faaj110              LIKE faaj_t.faaj110
   DEFINE l_faaj111              LIKE faaj_t.faaj111
   DEFINE l_faaj115              LIKE faaj_t.faaj115
   DEFINE l_faaj108              LIKE faaj_t.faaj108
   DEFINE l_faaj167              LIKE faaj_t.faaj167
   DEFINE l_faaj163              LIKE faaj_t.faaj163
   DEFINE l_faaj153              LIKE faaj_t.faaj153
   DEFINE l_faaj154              LIKE faaj_t.faaj154
   DEFINE l_faaj164              LIKE faaj_t.faaj164
   DEFINE l_faaj162              LIKE faaj_t.faaj162
   DEFINE l_faaj160              LIKE faaj_t.faaj160
   DEFINE l_faaj161              LIKE faaj_t.faaj161
   DEFINE l_faaj165              LIKE faaj_t.faaj165
   DEFINE l_faaj158              LIKE faaj_t.faaj158
   DEFINE l_fabo049              LIKE fabo_t.fabo049
   DEFINE l_fabo106              LIKE fabo_t.fabo106
   DEFINE l_fabo155              LIKE fabo_t.fabo155
   
   SELECT faah005 INTO l_faah005
     FROM faah_t
    WHERE faahent=g_enterprise AND faah001=g_fabo003
      AND faah003=g_fabo001 AND faah004=g_fabo002
      
   SELECT faaj016,faaj020,faaj034,faaj017,faaj035,faaj021,
          faaj027,faaj018,faaj032,faaj028,
          faaj103,faaj117,faaj113,faaj104,faaj114,faaj112,
          faaj110,faaj111,faaj115,faaj108,
          faaj153,faaj167,faaj163,faaj154,faaj164,faaj162,
          faaj160,faaj161,faaj165,faaj158
     INTO g_fabo_d[l_ac].fabo008,l_faaj020,l_faaj034,l_faaj017,l_faaj035,l_faaj021,
          l_faaj027,l_faaj018,l_faaj032,l_faaj028,
          l_faaj103,l_faaj117,l_faaj113,l_faaj104,l_faaj114,l_faaj112,
          l_faaj110,l_faaj111,l_faaj115,l_faaj108,
          l_faaj153,l_faaj167,l_faaj163,l_faaj154,l_faaj164,l_faaj162,
          l_faaj160,l_faaj161,l_faaj165,l_faaj158
     FROM faaj_t
    WHERE faajent=g_enterprise AND faajld=g_fabgld
      AND faaj001=g_fabo001 AND faaj002=g_fabo002
      AND faaj037=g_fabo003
   
   IF cl_null(g_fabo_d[l_ac].fabo008) THEN LET g_fabo_d[l_ac].fabo008=0 END IF #成本
   IF cl_null(l_faaj020) THEN LET l_faaj020=0 END IF   #调整成本
   IF cl_null(l_faaj034) THEN LET l_faaj034=0 END IF   #处置成本
   IF cl_null(l_faaj017) THEN LET l_faaj017=0 END IF   #累折
   IF cl_null(l_faaj035) THEN LET l_faaj035=0 END IF   #处置累折
   IF cl_null(l_faaj021) THEN LET l_faaj021=0 END IF #已提列減值準備
   IF cl_null(l_faaj027) THEN LET l_faaj027=0 END IF   #處置減值準備
   IF cl_null(l_faaj018) THEN LET l_faaj018=0 END IF   #本年累折
   IF cl_null(l_faaj032) THEN LET l_faaj032=0 END IF   #本年处置折舊
   IF cl_null(l_faaj028) THEN LET l_faaj028=0 END IF   #未折減額
   
   #处置成本=(本幣成本 + 調整成本 -处置成本)/(數量-处置數量) * 單據出售量
   LET g_fabo_d[l_ac].fabo018=(g_fabo_d[l_ac].fabo008 + l_faaj020 - l_faaj034) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo107=(l_faaj103 + l_faaj117 - l_faaj113) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo156=(l_faaj153 + l_faaj167 - l_faaj163) / p_faah018 *p_fabo007
   
   #处置累折=(累折 - 处置累折) / (數量-处置數量) * 單據出售量
   LET g_fabo_d[l_ac].fabo019=(l_faaj017 - l_faaj035) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo108=(l_faaj104 - l_faaj114) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo157=(l_faaj154 - l_faaj164) / p_faah018 *p_fabo007
   
   #处置減值準備= (已提列減值準備 - 处置減值準備) / (faah總數量-处置數量) * 單據出售量
   LET g_fabo_d[l_ac].fabo020=(l_faaj021 - l_faaj027) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo109=(l_faaj112 - l_faaj110) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo158=(l_faaj162 - l_faaj160) / p_faah018 *p_fabo007
   
   #本年处置折舊=(本年累折-本年处置折舊)/(數量-处置數量)*處份量
   LET g_fabo_d[l_ac].fabo021=(l_faaj018 - l_faaj032) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo110=(l_faaj018 - l_faaj115) / p_faah018 *p_fabo007
   LET g_fabo7_d[l_ac].fabo159=(l_faaj018 - l_faaj165) / p_faah018 *p_fabo007
   
   #未折減額=（未折減額/（faah總 數量-faaj处置数量) * 出售量
   LET g_fabo_d[l_ac].fabo022=l_faaj028 / p_faah018 *p_fabo007
   
   #本位币二
   IF g_glaa015='Y' THEN
      IF cl_null(l_faaj103) THEN LET l_faaj103=0 END IF
      IF cl_null(l_faaj117) THEN LET l_faaj117=0 END IF
      IF cl_null(l_faaj113) THEN LET l_faaj113=0 END IF
      IF cl_null(l_faaj104) THEN LET l_faaj104=0 END IF
      IF cl_null(l_faaj114) THEN LET l_faaj114=0 END IF
      IF cl_null(l_faaj112) THEN LET l_faaj112=0 END IF
      IF cl_null(l_faaj110) THEN LET l_faaj110=0 END IF
      IF cl_null(l_faaj111) THEN LET l_faaj111=0 END IF
      IF cl_null(l_faaj115) THEN LET l_faaj115=0 END IF
      IF cl_null(l_faaj108) THEN LET l_faaj108=0 END IF
      
      LET g_fabo7_d[l_ac].fabo107= (l_faaj103 + l_faaj117 - l_faaj113) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo108= (l_faaj104 - l_faaj114) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo109= (l_faaj112 - l_faaj110) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo110= (l_faaj111 - l_faaj115) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo111= l_faaj108 / p_faah018 *p_fabo007
   END IF
   
   #本位三
   IF g_glaa019='Y' THEN
      IF cl_null(l_faaj153) THEN LET l_faaj153=0 END IF
      IF cl_null(l_faaj167) THEN LET l_faaj167=0 END IF
      IF cl_null(l_faaj163) THEN LET l_faaj163=0 END IF
      IF cl_null(l_faaj154) THEN LET l_faaj154=0 END IF
      IF cl_null(l_faaj164) THEN LET l_faaj164=0 END IF
      IF cl_null(l_faaj162) THEN LET l_faaj162=0 END IF
      IF cl_null(l_faaj160) THEN LET l_faaj160=0 END IF
      IF cl_null(l_faaj161) THEN LET l_faaj161=0 END IF
      IF cl_null(l_faaj165) THEN LET l_faaj165=0 END IF
      IF cl_null(l_faaj158) THEN LET l_faaj158=0 END IF
      
      LET g_fabo7_d[l_ac].fabo156= (l_faaj153 + l_faaj167 - l_faaj163) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo157= (l_faaj154 - l_faaj164) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo158= (l_faaj162 - l_faaj160) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo159= (l_faaj161 - l_faaj165) / p_faah018 *p_fabo007
      LET g_fabo7_d[l_ac].fabo160= l_faaj158 / p_faah018 *p_fabo007
   END IF
   IF cl_null(g_fabo_d[l_ac].fabo015) THEN LET g_fabo_d[l_ac].fabo015 = 0 END IF
   IF cl_null(g_fabo_d[l_ac].fabo019) THEN LET g_fabo_d[l_ac].fabo019 = 0 END IF
   IF cl_null(g_fabo_d[l_ac].fabo020) THEN LET g_fabo_d[l_ac].fabo020 = 0 END IF
   IF cl_null(g_fabo_d[l_ac].fabo008) THEN LET g_fabo_d[l_ac].fabo008 = 0 END IF
   #處置損益
   IF l_faah005 <> '5' THEN #資產性質不為5：費用
      #處置損益=(本币成本-处置成本)/(数量-处置数量)* 单身出售数量
      LET l_fabo049=(g_fabo_d[l_ac].fabo008 - l_faaj034) / p_faah018 *p_fabo007
      #处置累折=(累计折旧faaj017-处置累折faaj035)/(数量-处置数量)*出售数量
      LET g_fabo_d[l_ac].fabo049 = g_fabo_d[l_ac].fabo015 + g_fabo_d[l_ac].fabo019 - l_fabo049 + g_fabo_d[l_ac].fabo020
      
      #本位幣二
      IF g_glaa015='Y' THEN
         LET l_fabo106=(l_faaj103 - l_faaj113) / p_faah018 *p_fabo007
         LET g_fabo7_d[l_ac].fabo106 = g_fabo7_d[l_ac].fabo103 + g_fabo7_d[l_ac].fabo108 - l_fabo106 + g_fabo7_d[l_ac].fabo109
      END IF
      
      #本位幣三
      IF g_glaa019='Y' THEN
         LET l_fabo155=(l_faaj153 - l_faaj163) / p_faah018 *p_fabo007
         LET g_fabo7_d[l_ac].fabo155 = g_fabo7_d[l_ac].fabo152 + g_fabo7_d[l_ac].fabo157 - l_fabo155 + g_fabo7_d[l_ac].fabo158
      END IF
   ELSE #費用類計算時不抓本幣成本
      #處置損益=(调整成本-处置成本)/(数量-处置数量)* 单身出售数量
      LET l_fabo049=(l_faaj020 - l_faaj034) / p_faah018 *p_fabo007
      #处置累折=(累计折旧faaj017-处置累折faaj035)/(数量-处置数量)*出售数量
      LET g_fabo_d[l_ac].fabo049 = g_fabo_d[l_ac].fabo015 + g_fabo_d[l_ac].fabo019 - l_fabo049 + g_fabo_d[l_ac].fabo020
      #本位幣二
      IF g_glaa015='Y' THEN
         LET l_fabo106=(l_faaj117 - l_faaj113) / p_faah018 *p_fabo007
         LET g_fabo7_d[l_ac].fabo106 = g_fabo7_d[l_ac].fabo103 + g_fabo7_d[l_ac].fabo108 - l_fabo106 + g_fabo7_d[l_ac].fabo109
      END IF
      
      #本位幣三
      IF g_glaa019='Y' THEN
        LET l_fabo155=(l_faaj167 - l_faaj163) / p_faah018 *p_fabo007
        LET g_fabo7_d[l_ac].fabo155 = g_fabo7_d[l_ac].fabo152 + g_fabo7_d[l_ac].fabo157 - l_fabo155 + g_fabo7_d[l_ac].fabo158
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 若原币与本币的应收<>应付,提示是否相等
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
PRIVATE FUNCTION afat505_01_amt_chk()
   DEFINE l_oodbl004 LIKE oodbL_t.oodbl004
   DEFINE l_oodb005  LIKE oodb_t.oodb005
   DEFINE l_oodb006  LIKE oodb_t.oodb006
   DEFINE l_oodb011  LIKE oodb_t.oodb011
   DEFINE r_xrcd103  LIKE xrcd_t.xrcd103
   DEFINE r_xrcd104  LIKE xrcd_t.xrcd104
   DEFINE r_xrcd105  LIKE xrcd_t.xrcd105
   DEFINE r_xrcd113  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115  LIKE xrcd_t.xrcd115
   DEFINE r_xrcd123  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125  LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133  LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134  LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135  LIKE xrcd_t.xrcd115
   DEFINE l_success  LIKE type_t.num5
   
   CALL afat505_01_set_entry("fabu010,fabu012,fabu013,fabu014,fabu015,fabu016,fabu017",TRUE)
   IF NOT cl_null(g_fabo_d[l_ac].fabo014) AND NOT cl_null(g_fabo_d[l_ac].fabo017) AND
      NOT cl_null(g_fabo3_d[l_ac].fabu014) AND NOT cl_null(g_fabo3_d[l_ac].fabu017) AND 
      (g_fabo_d[l_ac].fabo014<>g_fabo3_d[l_ac].fabu014 OR g_fabo_d[l_ac].fabo017<>g_fabo3_d[l_ac].fabu017) THEN
      IF cl_ask_confirm('afa-00263') THEN
         CALL s_tax_chk(g_glaacomp,g_fabo3_d[l_ac].fabu009)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
#        IF l_oodb005 = 'Y' THEN   #20141113 mark by chenying 
         IF l_oodb005 = 'N' THEN   #20141113 add by chenying
            LET g_fabo3_d[l_ac].fabu012 = g_fabo_d[l_ac].fabo012
            CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                         g_fabo3_d[l_ac].fabu012,g_fabo3_d[l_ac].fabu009,
                         g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
            RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                      r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135  

            LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
            LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
            LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
            LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
            LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
            LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
            LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
            LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
            LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
            LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
            LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
            LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
            #20141113 add by chenying重新推算拨入账务明细的单价
            LET g_fabo3_d[l_ac].fabu006 = g_fabo3_d[l_ac].fabu012/g_fabo007
         ELSE
            LET g_fabo3_d[l_ac].fabu014 = g_fabo_d[l_ac].fabo014
            CALL s_tax_ins(g_fabgdocno,g_faboseq,2,g_glaacomp,
                         g_fabo3_d[l_ac].fabu014,g_fabo3_d[l_ac].fabu009,
                         g_fabo007,g_fabo3_d[l_ac].fabu010,g_fabo3_d[l_ac].fabu011,g_fabgld,g_fabo8_d[l_ac].fabu102,g_fabo8_d[l_ac].fabu151)
            RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115,
                      r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135  

            LET g_fabo3_d[l_ac].fabu012 = r_xrcd103
            LET g_fabo3_d[l_ac].fabu013 = r_xrcd104
            LET g_fabo3_d[l_ac].fabu014 = r_xrcd105
            LET g_fabo3_d[l_ac].fabu015 = r_xrcd113
            LET g_fabo3_d[l_ac].fabu016 = r_xrcd114
            LET g_fabo3_d[l_ac].fabu017 = r_xrcd115
            LET g_fabo8_d[l_ac].fabu103 = r_xrcd123
            LET g_fabo8_d[l_ac].fabu104 = r_xrcd124
            LET g_fabo8_d[l_ac].fabu105 = r_xrcd125
            LET g_fabo8_d[l_ac].fabu152 = r_xrcd133
            LET g_fabo8_d[l_ac].fabu153 = r_xrcd134
            LET g_fabo8_d[l_ac].fabu154 = r_xrcd135
            #20141113 add by chenying重新推算拨入账务明细的单价
            LET g_fabo3_d[l_ac].fabu006 = g_fabo3_d[l_ac].fabu014/g_fabo007             

         END IF
       
         CALL afat505_01_set_entry("fabu010,fabu012,fabu013,fabu014,fabu015,fabu016,fabu017",FALSE)
      END IF
   END IF
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
PRIVATE FUNCTION afat505_01_set_fabo024(p_fabgdocno,p_fabold,p_faboseq)
DEFINE p_fabgdocno     LIKE fabg_t.fabgdocno
DEFINE p_fabold        LIKE fabo_t.fabold
DEFINE p_faboseq       LIKE fabo_t.faboseq
DEFINE l_faah006       LIKE faah_t.faah006
DEFINE l_faal004       LIKE faal_t.faal004
DEFINE l_faboseq       LIKE fabo_t.faboseq
DEFINE l_fabo001       LIKE fabo_t.fabo001
DEFINE l_fabo002       LIKE fabo_t.fabo002
DEFINE l_fabo003       LIKE fabo_t.fabo003
DEFINE l_fabo049       LIKE fabo_t.fabo049
DEFINE l_fabo024       LIKE fabo_t.fabo024
DEFINE l_scccode       LIKE fabo_t.fabo024   #科目SCC码
DEFINE l_glab002       LIKE glab_t.glab002   
DEFINE l_ooab002       LIKE ooab_t.ooab002   #20141111
DEFINE l_glaacomp      LIKE glaa_t.glaacomp  #20141111

   LET g_fabgdocno=p_fabgdocno
   LET g_fabgld=p_fabold
   LET l_faboseq=p_faboseq


   SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
   SELECT  fabo024 INTO l_fabo024 FROM fabo_t WHERE fabold=g_fabgld AND fabodocno=g_fabgdocno AND faboseq=l_faboseq AND faboent=g_enterprise
   IF cl_null(l_fabo024) THEN 

      SELECT fabo001,fabo002,fabo003,fabo049 INTO l_fabo001,l_fabo002,l_fabo003,l_fabo049 FROM fabo_t WHERE faboent=g_enterprise
      AND fabodocno=g_fabgdocno AND  faboseq=l_faboseq
       #根据财编+卡片编号+附号获取资产主类别
      SELECT faah006 INTO l_faah006 FROM faah_t WHERE faahent=g_enterprise AND faah001=l_fabo001 AND faah003=l_fabo002 AND faah004=l_fabo003
#20141111 mod--str--              
#      #根据帐套+资产主类别判断是否转入清理科目
#      SELECT faal004 INTO l_faal004 FROM faal_t WHERE faalent=g_enterprise AND faalld=g_fabgld AND faal001=l_faah006
#      IF l_faal004='Y' THEN               #资产处置转入清理科目，则取资产清理科目（afai071）作为异动科目
      SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabold
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_ooab002  
      IF l_ooab002 = 'Y' THEN
#20141111 mod--end---
         LET l_scccode='9902_12'
         LET l_glab002='25'
      ELSE 
         #资产处置不转入清理科目，判断‘处分损益fabo049’是否大于零 如果大于零，
         #则取出售收益科目作为异动科目，否则取出售损失科目作为异动科目
         IF l_fabo049>0 THEN  
            LET l_scccode='9902_06' 
            LET l_glab002='41'            
         ELSE 
            LET l_scccode='9902_07'
            LET l_glab002='42'            
         END IF                     
      END IF
              
      SELECT glab005 INTO l_fabo024 FROM glab_t
      WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002=l_glab002 AND glab003=l_scccode
      LET l_ac=l_faboseq
      IF l_ac > 0 THEN 
         LET g_fabo2_d[l_ac].fabo024=l_fabo024
         CALL afat505_01_fabo024_desc(l_fabo024) RETURNING g_fabo2_d[l_ac].fabo024_desc
      END IF 
   END IF
   
   SELECT faajsite,faaj039,faaj040,faaj041,faaj042,
          faaj043,faaj044,faaj047,faaj045,faaj046
     INTO g_fabo2_d[l_ac].fabo031,g_fabo2_d[l_ac].fabo032,g_fabo2_d[l_ac].fabo033,g_fabo2_d[l_ac].fabo034,
          g_fabo2_d[l_ac].fabo035,g_fabo2_d[l_ac].fabo036,g_fabo2_d[l_ac].fabo037,g_fabo2_d[l_ac].fabo038,
          g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040
     FROM fabo_t,faaj_t  
    WHERE faaj001=fabo001 AND faaj002=fabo002 AND faaj037=fabo003 AND faajent=faboent
      AND faboent=g_enterprise AND fabold=g_fabgld AND fabodocno=g_fabgdocno AND faboseq=l_faboseq
   CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo031) RETURNING g_fabo2_d[l_ac].fabo031_desc
   LET g_fabo2_d[l_ac].fabo031_desc = g_fabo2_d[l_ac].fabo031 CLIPPED,g_fabo2_d[l_ac].fabo031_desc
   
   CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo032) RETURNING g_fabo2_d[l_ac].fabo032_desc
   LET g_fabo2_d[l_ac].fabo032_desc = g_fabo2_d[l_ac].fabo032 CLIPPED,g_fabo2_d[l_ac].fabo032_desc
   
   CALL afat505_01_fabo031_desc(g_fabo2_d[l_ac].fabo033) RETURNING g_fabo2_d[l_ac].fabo033_desc
   LET g_fabo2_d[l_ac].fabo033_desc = g_fabo2_d[l_ac].fabo033 CLIPPED,g_fabo2_d[l_ac].fabo033_desc
   
   CALL afat505_01_fabo034_desc('287',g_fabo2_d[l_ac].fabo034) RETURNING g_fabo2_d[l_ac].fabo034_desc
   LET g_fabo2_d[l_ac].fabo034_desc = g_fabo2_d[l_ac].fabo034 CLIPPED,g_fabo2_d[l_ac].fabo034_desc
   
   CALL afat505_01_fabo034_desc('281',g_fabo2_d[l_ac].fabo037) RETURNING g_fabo2_d[l_ac].fabo037_desc
   LET g_fabo2_d[l_ac].fabo037_desc = g_fabo2_d[l_ac].fabo037 CLIPPED,g_fabo2_d[l_ac].fabo037_desc
   
   CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo035) RETURNING g_fabo2_d[l_ac].fabo035_desc
   LET g_fabo2_d[l_ac].fabo035_desc = g_fabo2_d[l_ac].fabo035 CLIPPED,g_fabo2_d[l_ac].fabo035_desc
   
   CALL afat505_01_fabo035_desc(g_fabo2_d[l_ac].fabo036) RETURNING g_fabo2_d[l_ac].fabo036_desc
   LET g_fabo2_d[l_ac].fabo036_desc = g_fabo2_d[l_ac].fabo036 CLIPPED,g_fabo2_d[l_ac].fabo036_desc
   
   CALL afat505_01_fabo038_desc(g_fabo2_d[l_ac].fabo038) RETURNING g_fabo2_d[l_ac].fabo038_desc
   LET g_fabo2_d[l_ac].fabo038_desc = g_fabo2_d[l_ac].fabo038 CLIPPED,g_fabo2_d[l_ac].fabo038_desc
   
   CALL afat505_01_fabo039_desc(g_fabo2_d[l_ac].fabo039) RETURNING g_fabo2_d[l_ac].fabo039_desc
   LET g_fabo2_d[l_ac].fabo039_desc = g_fabo2_d[l_ac].fabo039 CLIPPED,g_fabo2_d[l_ac].fabo039_desc
   
   CALL afat505_01_fabo040_desc(g_fabo2_d[l_ac].fabo039,g_fabo2_d[l_ac].fabo040) RETURNING g_fabo2_d[l_ac].fabo040_desc
   LET g_fabo2_d[l_ac].fabo040_desc = g_fabo2_d[l_ac].fabo040 CLIPPED,g_fabo2_d[l_ac].fabo040_desc
   
   DISPLAY BY NAME g_fabo2_d[l_ac].fabo031_desc,g_fabo2_d[l_ac].fabo032_desc,g_fabo2_d[l_ac].fabo033_desc,g_fabo2_d[l_ac].fabo034_desc,
                   g_fabo2_d[l_ac].fabo035_desc,g_fabo2_d[l_ac].fabo036_desc,g_fabo2_d[l_ac].fabo037_desc,g_fabo2_d[l_ac].fabo038_desc,
                   g_fabo2_d[l_ac].fabo039_desc,g_fabo2_d[l_ac].fabo040_desc
END FUNCTION

################################################################################
# #動態設定元件是否可輸入
################################################################################
PRIVATE FUNCTION afat505_01_set_entry(ps_fields,pi_entry)
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

 
{</section>}
 

#該程式未解開Section, 採用最新樣板產出!
{<section id="aisi050_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-07-07 11:17:43), PR版次:0004(2016-04-27 09:20:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000326
#+ Filename...: aisi050_02
#+ Description: 發票簿拆分
#+ Creator....: 05016(2014-06-19 15:09:47)
#+ Modifier...: 05016 -SD/PR- 07959
 
{</section>}
 
{<section id="aisi050_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160223-00002#2  2016/04/07  By Reanna 增加aisi056流通發票簿處理
#160318-00025#44 2016/04/26  By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"
 
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_isae_m        RECORD
       isaesite LIKE isae_t.isaesite, 
   isaesite_desc LIKE type_t.chr80, 
   isae016 LIKE isae_t.isae016, 
   isae017 LIKE isae_t.isae017, 
   isae018 LIKE isae_t.isae018, 
   isae001 LIKE isae_t.isae001, 
   isae004 LIKE isae_t.isae004, 
   isae004_desc LIKE type_t.chr80, 
   isae009 LIKE isae_t.isae009, 
   isae010 LIKE isae_t.isae010, 
   isae011 LIKE isae_t.isae011, 
   chr LIKE type_t.chr500, 
   num LIKE type_t.chr500, 
   sheet LIKE type_t.chr500, 
   isae002 LIKE isae_t.isae002, 
   isae003 LIKE isae_t.isae003, 
   isae018_desc LIKE type_t.chr80, 
   isaecomp LIKE isae_t.isaecomp, 
   isaecomp_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_type LIKE type_t.num5
DEFINE g_sql           STRING
DEFINE l_ac            LIKE type_t.num5 
DEFINE l_i             LIKE type_t.num5 #終止條件
DEFINE l_flag          LIKE type_t.num5
DEFINE g_isae_d DYNAMIC ARRAY OF RECORD      
   isae001 LIKE isae_t.isae001,    
   isae002 LIKE isae_t.isae002, 
   isae003 LIKE isae_t.isae003, 
   isae005 LIKE isae_t.isae005, 
   isae006 LIKE isae_t.isae006,
   isae007 LIKE isae_t.isae007,    
   isae008 LIKE isae_t.isae008, 
   isae009 LIKE isae_t.isae009, 
   isae010 LIKE isae_t.isae010, 
   isae011 LIKE isae_t.isae011 
       END RECORD

#end add-point
 
DEFINE g_isae_m        type_g_isae_m
 
   DEFINE g_isaesite_t LIKE isae_t.isaesite
DEFINE g_isae016_t LIKE isae_t.isae016
DEFINE g_isae017_t LIKE isae_t.isae017
DEFINE g_isae018_t LIKE isae_t.isae018
DEFINE g_isae001_t LIKE isae_t.isae001
DEFINE g_isae004_t LIKE isae_t.isae004
DEFINE g_isae002_t LIKE isae_t.isae002
DEFINE g_isae003_t LIKE isae_t.isae003
DEFINE g_isaecomp_t LIKE isae_t.isaecomp
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisi050_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aisi050_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type 
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_type          LIKE type_t.num5
   DEFINE l_pc            LIKE type_t.num5       #切分次數
 
   DEFINE l_j             LIKE type_t.num5       #計算字串長度
   DEFINE l_isae001       LIKE type_t.num20
   DEFINE l_isae005       LIKE isae_t.isae005    #電子發票否
   DEFINE l_isae006       LIKE isae_t.isae006
   DEFINE l_isae007       LIKE isae_t.isae007
   DEFINE l_isae008       LIKE isae_t.isae008
   DEFINE l_isae009       LIKE type_t.num20      #起始號碼
   DEFINE l_isae010       LIKE type_t.num20      #結束號碼
   DEFINE l_isae010_1     LIKE type_t.chr80      #最後一筆結束號碼
   DEFINE l_isae011       LIKE type_t.num20      #發票張數
   DEFINE l_isae019       LIKE isae_t.isae019
   DEFINE l_isaeownid     LIKE isae_t.isaeownid
   DEFINE l_isaeowndp     LIKE isae_t.isaeowndp
   DEFINE l_isaecrtid     LIKE isae_t.isaecrtid
   DEFINE l_isaecrtdp     LIKE isae_t.isaecrtdp
   DEFINE l_isaecrtdt     LIKE isae_t.isaecrtdt
   DEFINE l_num           LIKE type_t.num20      #起始號碼
   DEFINE l_sheet         LIKE type_t.num20
   DEFINE l_mod           LIKE type_t.num20      #餘數
   DEFINE l_num_str       STRING
   DEFINE l_isae009_str   STRING
   DEFINE l_format        STRING
   DEFINE l_format1       STRING
   DEFINE l_osae001_1     LIKE isae_t.isae001    #原本簿號 刪除用
   DEFINE l_isac008       LIKE isac_t.isac008    #160223-00002#2
   DEFINE l_isae022       LIKE isae_t.isae022    #160223-00002#2
   DEFINE l_ooef019       LIKE ooef_t.ooef019    #160223-00002#2
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aisi050_02 WITH FORM cl_ap_formpath("ais","aisi050_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_type = p_type
   LET  l_flag = 1
   INITIALIZE g_isae_m.* TO NULL
   
   CALL aisi050_02_set_combo_scc('isae016','43')
   CALL aisi050_02_set_combo_scc('isae017','39')
   CALL aisi050_02_set_combo_scc('isae018','39')
   CALL cl_set_combo_scc('b_isae006','9713') 
   CALL aisi050_02_isaecomp_ref() RETURNING g_isae_m.isaecomp
   IF g_type = 1 THEN
      LET g_isae_m.isae016 = '2014'
      LET g_isae_m.isae017 = '11'
      LET g_isae_m.isae018 = '12'
      CALL cl_set_comp_visible('isae016',FALSE)
      CALL cl_set_comp_visible('isae017',FALSE) 
      CALL cl_set_comp_visible('isae018',FALSE)
      CALL cl_set_comp_visible('b_isae007',FALSE)
   ELSE
      CALL cl_set_comp_visible('b_isae002',FALSE)
      CALL cl_set_comp_visible('b_isae003',FALSE)
      CALL cl_set_comp_visible('b_isae008',FALSE)
   END IF
    
   WHILE TRUE
 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_isae_m.isaesite,g_isae_m.isae016,g_isae_m.isae017,g_isae_m.isae018,g_isae_m.isae001, 
          g_isae_m.isae010,g_isae_m.isae011,g_isae_m.chr,g_isae_m.num,g_isae_m.sheet,g_isae_m.isae002, 
          g_isae_m.isae003,g_isae_m.isaecomp ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
        
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CLEAR FORM
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaesite
            
            #add-point:AFTER FIELD isaesite name="input.a.isaesite"
            LET g_isae_m.isaesite_desc = ' '
            DISPLAY BY NAME g_isae_m.isaesite_desc
            IF NOT cl_null(g_isae_m.isaesite) THEN
               IF p_cmd = 'a' THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_isae_m.isaesite
                  #160318-00025#44  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#44  2016/04/26  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_isae_m.isaesite = ''
                     LET g_isae_m.isaesite_desc  = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isae_m.isaesite) RETURNING g_isae_m.isaesite_desc
            DISPLAY g_isae_m.isaesite_desc TO isaesite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaesite
            #add-point:BEFORE FIELD isaesite name="input.b.isaesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaesite
            #add-point:ON CHANGE isaesite name="input.g.isaesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae016
            #add-point:BEFORE FIELD isae016 name="input.b.isae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae016
            
            #add-point:AFTER FIELD isae016 name="input.a.isae016"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_isae_m.isaecomp) AND NOT cl_null(g_isae_m.isaesite) AND NOT cl_null(g_isae_m.isae001) AND NOT cl_null(g_isae_m.isae002) AND NOT cl_null(g_isae_m.isae003) AND NOT cl_null(g_isae_m.isae004) AND NOT cl_null(g_isae_m.isae016) AND NOT cl_null(g_isae_m.isae017) AND NOT cl_null(g_isae_m.isae018) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_isae_m.isaecomp != g_isaecomp_t  OR g_isae_m.isaesite != g_isaesite_t  OR g_isae_m.isae001 != g_isae001_t  OR g_isae_m.isae002 != g_isae002_t  OR g_isae_m.isae003 != g_isae003_t  OR g_isae_m.isae004 != g_isae004_t  OR g_isae_m.isae016 != g_isae016_t  OR g_isae_m.isae017 != g_isae017_t  OR g_isae_m.isae018 != g_isae018_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "' AND "||"isaecomp = '"||g_isae_m.isaecomp ||"' AND "|| "isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_m.isae001 ||"' AND "|| "isae002 = '"||g_isae_m.isae002 ||"' AND "|| "isae003 = '"||g_isae_m.isae003 ||"' AND "|| "isae004 = '"||g_isae_m.isae004 ||"' AND "|| "isae016 = '"||g_isae_m.isae016 ||"' AND "|| "isae017 = '"||g_isae_m.isae017 ||"' AND "|| "isae018 = '"||g_isae_m.isae018 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae016
            #add-point:ON CHANGE isae016 name="input.g.isae016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae017
            #add-point:BEFORE FIELD isae017 name="input.b.isae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae017
            
            #add-point:AFTER FIELD isae017 name="input.a.isae017"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_isae_m.isaecomp) AND NOT cl_null(g_isae_m.isaesite) AND NOT cl_null(g_isae_m.isae001) AND NOT cl_null(g_isae_m.isae002) AND NOT cl_null(g_isae_m.isae003) AND NOT cl_null(g_isae_m.isae004) AND NOT cl_null(g_isae_m.isae016) AND NOT cl_null(g_isae_m.isae017) AND NOT cl_null(g_isae_m.isae018) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_isae_m.isaecomp != g_isaecomp_t  OR g_isae_m.isaesite != g_isaesite_t  OR g_isae_m.isae001 != g_isae001_t  OR g_isae_m.isae002 != g_isae002_t  OR g_isae_m.isae003 != g_isae003_t  OR g_isae_m.isae004 != g_isae004_t  OR g_isae_m.isae016 != g_isae016_t  OR g_isae_m.isae017 != g_isae017_t  OR g_isae_m.isae018 != g_isae018_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isae_t WHERE "||"isaeent = '" ||g_enterprise|| "' AND "||"isaecomp = '"||g_isae_m.isaecomp ||"' AND "|| "isaesite = '"||g_isae_m.isaesite ||"' AND "|| "isae001 = '"||g_isae_m.isae001 ||"' AND "|| "isae002 = '"||g_isae_m.isae002 ||"' AND "|| "isae003 = '"||g_isae_m.isae003 ||"' AND "|| "isae004 = '"||g_isae_m.isae004 ||"' AND "|| "isae016 = '"||g_isae_m.isae016 ||"' AND "|| "isae017 = '"||g_isae_m.isae017 ||"' AND "|| "isae018 = '"||g_isae_m.isae018 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae017
            #add-point:ON CHANGE isae017 name="input.g.isae017"
            LET g_isae_m.isae018 = g_isae_m.isae017+1 #160223-00002#2
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae018
            
            #add-point:AFTER FIELD isae018 name="input.a.isae018"
            #160223-00002#2 add ------
            IF g_isae_m.isae018 < g_isae_m.isae017 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00147"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD isae018
            END IF
            #160223-00002#2 add end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae018
            #add-point:BEFORE FIELD isae018 name="input.b.isae018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae018
            #add-point:ON CHANGE isae018 name="input.g.isae018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae001
            #add-point:BEFORE FIELD isae001 name="input.b.isae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae001
            
            #add-point:AFTER FIELD isae001 name="input.a.isae001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_isae_m.isae001) THEN
               CASE
                  WHEN g_type = 1
                      CALL aisi050_02_isae001_1_chk(g_isae_m.isae001) RETURNING  g_success,g_errno
                  WHEN g_type = 2
                     #CALL aisi050_02_isae001_2_chk(g_isae_m.isae001) RETURNING g_success,g_errno #160223-00002#2
                  #160223-00002#2 add ------
                      CALL aisi050_02_isae001_2_chk(g_isae_m.isae001,g_type) RETURNING g_success,g_errno
                  WHEN g_type = 3
                      CALL aisi050_02_isae001_2_chk(g_isae_m.isae001,g_type) RETURNING g_success,g_errno
                  #160223-00002#2 add end---
               END CASE
               IF NOT g_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err() 
                  LET g_isae_m.isae004 =''
                  LET g_isae_m.isae009 =''
                  LET g_isae_m.isae010 =''
                  LET g_isae_m.isae011 =''
                  NEXT FIELD isae001
               END IF
            END IF
            SELECT isae004,isae009,isae010,isae011,isaecomp
              INTO g_isae_m.isae004,g_isae_m.isae009,g_isae_m.isae010,g_isae_m.isae011,g_isae_m.isaecomp
              FROM isae_t
             WHERE isaesite = g_isae_m.isaesite
               AND isae001 = g_isae_m.isae001
               AND isaeent = g_enterprise        #160223-00002#2
            CALL aisi050_02_isae004_ref()
            DISPLAY g_isae_m.isae004 TO isae004
            DISPLAY g_isae_m.isae009 TO isae009
            DISPLAY g_isae_m.isae010 TO isae010
            DISPLAY g_isae_m.isae011 TO isae011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae001
            #add-point:ON CHANGE isae001 name="input.g.isae001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae010
            #add-point:BEFORE FIELD isae010 name="input.b.isae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae010
            
            #add-point:AFTER FIELD isae010 name="input.a.isae010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae010
            #add-point:ON CHANGE isae010 name="input.g.isae010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_isae_m.isae011,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD isae011
            END IF 
 
 
 
            #add-point:AFTER FIELD isae011 name="input.a.isae011"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae011
            #add-point:BEFORE FIELD isae011 name="input.b.isae011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae011
            #add-point:ON CHANGE isae011 name="input.g.isae011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chr
            #add-point:BEFORE FIELD chr name="input.b.chr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chr
            
            #add-point:AFTER FIELD chr name="input.a.chr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chr
            #add-point:ON CHANGE chr name="input.g.chr"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD num
            #add-point:BEFORE FIELD num name="input.b.num"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD num
            
            #add-point:AFTER FIELD num name="input.a.num"
            LET l_num_str = g_isae_m.num
            
            FOR l_i =1 TO 80
               IF cl_null(g_isae_m.num[l_i,l_i]) THEN
                  EXIT FOR
               END IF                  
               IF (g_isae_m.num[l_i,l_i] NOT MATCHES '[0-9]') THEN                
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00147"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD num               
               END IF
            END FOR 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE num
            #add-point:ON CHANGE num name="input.g.num"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sheet
            #add-point:BEFORE FIELD sheet name="input.b.sheet"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sheet
            
            #add-point:AFTER FIELD sheet name="input.a.sheet"
            
            
            IF g_isae_m.sheet > g_isae_m.isae011 THEN #大於張數
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ais-00141"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD sheet
            END IF
           
            LET l_mod = g_isae_m.isae011 mod g_isae_m.sheet     #餘數                 
            IF l_mod != 0 THEN     
               IF NOT cl_ask_confirm('ais-00142') THEN
                  LET l_flag = 2
                  NEXT FIELD sheet
               ELSE 
                  LET l_flag = 1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sheet
            #add-point:ON CHANGE sheet name="input.g.sheet"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae002
            #add-point:BEFORE FIELD isae002 name="input.b.isae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae002
            
            #add-point:AFTER FIELD isae002 name="input.a.isae002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae002
            #add-point:ON CHANGE isae002 name="input.g.isae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae003
            #add-point:BEFORE FIELD isae003 name="input.b.isae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae003
            
            #add-point:AFTER FIELD isae003 name="input.a.isae003"
   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae003
            #add-point:ON CHANGE isae003 name="input.g.isae003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaecomp
            
            #add-point:AFTER FIELD isaecomp name="input.a.isaecomp"
       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaecomp
            #add-point:BEFORE FIELD isaecomp name="input.b.isaecomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaecomp
            #add-point:ON CHANGE isaecomp name="input.g.isaecomp"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaesite
            #add-point:ON ACTION controlp INFIELD isaesite name="input.c.isaesite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_isae_m.isaesite
            #160223-00002#2 mark ------
            #IF g_type = 1 THEN
            #   LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isae019 = 'aisi050' "
            #ELSE
            #   LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isae019 = 'aisi055' "
            #END IF
            #160223-00002#2 mark end---
            #160223-00002#2 add ------
            CASE g_type
               WHEN "1"
                  LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isae019 = 'aisi050' "
               WHEN "2"
                  LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isae019 = 'aisi055' "
               WHEN "3"
                  LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isae019 = 'aisi056' "
            END CASE
            #160223-00002#2 add end---
            CALL q_isaesite()
            LET g_isae_m.isaesite = g_qryparam.return1
            DISPLAY g_isae_m.isaesite TO isaesite
            CALL s_desc_get_department_desc(g_isae_m.isaesite) RETURNING g_isae_m.isaesite_desc
            DISPLAY g_isae_m.isaesite_desc TO isaesite_desc
            NEXT FIELD isaesite
            #END add-point
 
 
         #Ctrlp:input.c.isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae016
            #add-point:ON ACTION controlp INFIELD isae016 name="input.c.isae016"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae017
            #add-point:ON ACTION controlp INFIELD isae017 name="input.c.isae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae018
            #add-point:ON ACTION controlp INFIELD isae018 name="input.c.isae018"
          
            #END add-point
 
 
         #Ctrlp:input.c.isae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae001
            #add-point:ON ACTION controlp INFIELD isae001 name="input.c.isae001"
            IF g_type = 1 THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isae001
               LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isaesite = '",g_isae_m.isaesite,"' AND isae019 = 'aisi050' " 
               CALL q_isae001()
               LET g_isae_m.isae001 = g_qryparam.return1
               SELECT isae004,isae009,isae010,isae011,isaecomp
                 INTO g_isae_m.isae004,g_isae_m.isae009,g_isae_m.isae010,g_isae_m.isae011,g_isae_m.isaecomp
                 FROM isae_t
                WHERE isaesite = g_isae_m.isaesite
                  AND isae001 = g_isae_m.isae001
                  AND isaeent = g_enterprise        #160223-00002#2
               CALL aisi050_02_isae004_ref()
               DISPLAY g_isae_m.isae004 TO isae004
               DISPLAY g_isae_m.isae009 TO isae009
               DISPLAY g_isae_m.isae010 TO isae010
               DISPLAY g_isae_m.isae011 TO isae011
               DISPLAY g_isae_m.isae001 TO isae001
               NEXT FIELD isae001
            ELSE
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_isae_m.isae001
               IF g_type = 2 THEN #160223-00002#2
                  LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isaesite = '",g_isae_m.isaesite,"' ",
                                        " AND isae016 = '",g_isae_m.isae016,"' ",
                                        " AND isae017 BETWEEN  '",g_isae_m.isae017,"' AND '",g_isae_m.isae018,"'",
                                        " AND isae013 = 0",  #160223-00002#2 #已開張數=0
                                        " AND isae019 = 'aisi055' "
               #160223-00002#2 add ------
               ELSE
                  LET g_qryparam.where =" isaecomp = '",g_isae_m.isaecomp,"' AND isaesite = '",g_isae_m.isaesite,"' ",
                                        " AND isae016 = '",g_isae_m.isae016,"' ",
                                        " AND isae017 BETWEEN  '",g_isae_m.isae017,"' AND '",g_isae_m.isae018,"'",
                                        " AND isae013 = 0 ", #已開張數=0
                                        " AND ((isae005 = 'Y' AND isae022 IS NULL) OR isae005='N') ",#電子發票若已被取用也不可拆
                                        " AND isae019 = 'aisi056' "
               END IF
               #160223-00002#2 add end---
         
               CALL q_isae001()
               LET g_isae_m.isae001 = g_qryparam.return1
               SELECT isae009,isae010,isae011 INTO g_isae_m.isae009,g_isae_m.isae010,g_isae_m.isae011 
                 FROM isae_t
                WHERE isaesite = g_isae_m.isaesite
                  AND isae001 =  g_isae_m.isae001
                  AND isae016 =  g_isae_m.isae016
                  AND isae017 =  g_isae_m.isae017
                  AND isae018 =  g_isae_m.isae018
                  AND isaeent = g_enterprise        #160223-00002#2
               CALL aisi050_02_isae004_ref()
               DISPLAY g_isae_m.isae004 TO isae004
               DISPLAY g_isae_m.isae009 TO isae009
               DISPLAY g_isae_m.isae010 TO isae010
               DISPLAY g_isae_m.isae011 TO isae011
               DISPLAY g_isae_m.isae001 TO isae001
               NEXT FIELD isae001
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.isae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae010
            #add-point:ON ACTION controlp INFIELD isae010 name="input.c.isae010"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae011
            #add-point:ON ACTION controlp INFIELD isae011 name="input.c.isae011"
            
            #END add-point
 
 
         #Ctrlp:input.c.chr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chr
            #add-point:ON ACTION controlp INFIELD chr name="input.c.chr"
            
            #END add-point
 
 
         #Ctrlp:input.c.num
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD num
            #add-point:ON ACTION controlp INFIELD num name="input.c.num"
            
            #END add-point
 
 
         #Ctrlp:input.c.sheet
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sheet
            #add-point:ON ACTION controlp INFIELD sheet name="input.c.sheet"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae002
            #add-point:ON ACTION controlp INFIELD isae002 name="input.c.isae002"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae003
            #add-point:ON ACTION controlp INFIELD isae003 name="input.c.isae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaecomp
            #add-point:ON ACTION controlp INFIELD isaecomp name="input.c.isaecomp"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
           
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION query
         CLEAR FORM
         LET l_flag =1
         CALL g_isae_d.clear()
         INITIALIZE g_isae_m.* TO NULL              
      #end add-point
    
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
 
   #add-point:畫面關閉前 name="input.before_close"
  
   IF NOT INT_FLAG THEN
      LET l_osae001_1  = g_isae_m.isae001
      LET l_i = 1
      LET l_j = 1
      LET l_ac = 1
      LET l_isae011 = g_isae_m.isae011       #發票張數
      LET l_sheet   = g_isae_m.sheet         #切分張數
      LET l_isae009 = g_isae_m.isae009       #起始號碼
      LET l_mod = l_isae011 mod l_sheet      #餘數
      LET l_pc =  l_isae011/l_sheet          #切分次數
      LET l_isaeownid = g_user
      LET l_isaeowndp = g_dept
      LET l_isaecrtid = g_user
      LET l_isaecrtdp = g_dept
     #LET l_isaecrtdt = g_today           #160223-00002#2 mark
      LET l_isaecrtdt = cl_get_current()  #160223-00002#2
      
      IF l_mod != 0 THEN
         LET l_pc = l_pc +1
      END IF
      LET l_isae001 = g_isae_m.num      #簿號 流水號
      LET l_isae010_1 = g_isae_m.isae010
      
      SELECT isae002,isae003,isae005,isae006,isae007,
             isae008,isae016,isae017,isae018,isae019
        INTO g_isae_m.isae002,g_isae_m.isae003,l_isae005,l_isae006,l_isae007,
             l_isae008,g_isae_m.isae016,g_isae_m.isae017,g_isae_m.isae018,l_isae019
        FROM isae_t
       WHERE isaeent  = g_enterprise
         AND isaesite = g_isae_m.isaesite
         AND isae001  = g_isae_m.isae001
      LET l_num_str = ''
      LET l_format = ''
      LET g_isae_m.isae001 = g_isae_m.num    #簿號
      LET l_num_str = g_isae_m.num 
      FOR l_j = 1 TO l_num_str.getLength()
         LET l_format = l_format,'&'
      END FOR
      
      LET l_isae009_str = ''
      LET l_format1 = ''
      LET l_isae009_str = g_isae_m.isae009    #起始號碼
      FOR l_j = 1 TO l_isae009_str.getLength()
         LET l_format1 = l_format1,'&'
      END FOR
      
      IF l_flag = 1 THEN
         CALL s_transaction_end('Y','0')
         WHILE TRUE
            IF l_i > l_pc THEN
               EXIT WHILE
            END IF
            
            IF cl_null(l_isae007) THEN LET l_isae007 = ' ' END IF
            
            LET g_isae_m.isae001  = l_isae001  USING l_format  #簿號
            IF NOT cl_null(g_isae_m.chr) THEN
               LET g_isae_m.isae001  = g_isae_m.chr,g_isae_m.isae001
            END IF
            CALL aisi050_02_isaeupdate_chk(g_isae_m.isae001) RETURNING  g_success,g_errno
            IF NOT g_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               LET l_flag = 1
               EXIT WHILE
            END IF
          
            LET l_isae001 =l_isae001 +1
            
            IF l_i != 1 THEN # 起始號碼
               LET l_isae009 = l_isae009 + g_isae_m.sheet
               LET g_isae_m.isae009 = l_isae009 USING l_format1
            END IF
            
            IF l_i != l_pc THEN
               LET l_isae010 = l_isae009 + g_isae_m.sheet-1 # 結束號碼
               LET g_isae_m.isae010 = l_isae010 USING l_format1
            ELSE
               LET g_isae_m.isae010 = l_isae010_1
            END IF
            LET l_isae011 = g_isae_m.isae010 - g_isae_m.isae009 +1  #發票張數
            
            #160223-00002#2 add ------
            IF g_type = 3 THEN
               LET l_isae022 = ""
               IF l_isae005 = "N" THEN LET l_isae022 = g_isae_m.isaesite END IF
               INSERT INTO isae_t(isaeent,isaecomp,isaesite,
                                  isae001,isae002,isae003,isae004,isae005,
                                  isae006,isae007,isae008,isae009,isae010,
                                  isae011,isae012,isae013,isae015,isae016,
                                  isae017,isae018,isae019,isae021,isae022,
                                  isaestus,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt)
               VALUES (g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite,
                       g_isae_m.isae001,g_isae_m.isae002,g_isae_m.isae003,g_isae_m.isae004,l_isae005,
                       l_isae006,l_isae007,l_isae008,g_isae_m.isae009,g_isae_m.isae010,
                       l_isae011,g_isae_m.isae009,'0','1',g_isae_m.isae016,
                       g_isae_m.isae017,g_isae_m.isae018,l_isae019,'3',l_isae022,
                       'Y',l_isaeownid,l_isaeowndp,l_isaecrtid,l_isaecrtdp,l_isaecrtdt)
            ELSE
            #160223-00002#2 add end---
               INSERT INTO isae_t(isaeent,isaecomp,isaesite,
                                  isae001,isae002,isae003,isae004,isae005,
                                  isae006,isae007,isae008,isae009,isae010,
                                  isae011,isae012,isae013,isae015,isae016,
                                  isae017,isae018,isae019,
                                  isaestus,isaeownid,isaeowndp,isaecrtid,isaecrtdp,isaecrtdt)
               VALUES (g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite,
                       g_isae_m.isae001,g_isae_m.isae002,g_isae_m.isae003,g_isae_m.isae004,l_isae005,
                       l_isae006,l_isae007,l_isae008,g_isae_m.isae009,g_isae_m.isae010,
                       l_isae011,g_isae_m.isae009,'0','N',g_isae_m.isae016,
                       g_isae_m.isae017,g_isae_m.isae018,l_isae019,
                       'Y',l_isaeownid,l_isaeowndp,l_isaecrtid,l_isaecrtdp,l_isaecrtdt)
            END IF #160223-00002#2
            CALL aisi050_02_b_fill()
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0')
            END IF
            #160223-00002#2 add ------
            IF g_type = 3 THEN
               #拆分也要新增isay_t
               #取得新據點的法人&稅區
               SELECT ooef019 INTO l_ooef019
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_isae_m.isaecomp
               #發票聯別(依發票類型取聯別)
               SELECT isac008 INTO l_isac008
                 FROM isac_t
                WHERE isacent = g_enterprise
                  AND isac001 = l_ooef019
                  AND isac002 = g_isae_m.isae004
               INSERT INTO isay_t
                          (isayent,isaycomp,isaysite,
                           isay001,isay002,isay003,isay004,isay005,
                           isay006,isay007,isay008,isay009,isay010,
                           isay011,isay012,isay013,isay014,isay015,
                           isay016,isay017,isay018,isay019,isay020,
                           isay021,isaystus)
                    VALUES(g_enterprise,g_isae_m.isaecomp,g_isae_m.isaesite,
                           g_isae_m.isae001,g_isae_m.isae002,g_isae_m.isae003,g_isae_m.isae004,l_isac008,
                           l_isae006,l_isae005,l_isae007,l_isae008,g_isae_m.isae009,
                           g_isae_m.isae010,l_isae011,'0','1',l_isaecrtdt,
                           '','',g_isae_m.isae016,g_isae_m.isae017,g_isae_m.isae018,
                           '1','Y')
               IF SQLCA.SQLcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "ins isay_t:",SQLERRMESSAGE
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #160223-00002#2 add end---
            LET l_i = l_i+1
            LET l_flag = 2
         END WHILE
         IF l_flag = 2 THEN
            DELETE FROM isae_t
             WHERE isaesite = g_isae_m.isaesite
               AND isae001 = l_osae001_1 
               AND isae002 = g_isae_m.isae002
               AND isae003 = g_isae_m.isae003
               AND isaeent = g_enterprise        #160223-00002#2
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del isae_t:",SQLERRMESSAGE
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0')
            END IF
            #160223-00002#2 add ------
            IF g_type = 3 THEN
               DELETE FROM isay_t
                WHERE isayent = g_enterprise
                  AND isaycomp = g_isae_m.isaecomp
                  AND isaysite = g_isae_m.isaesite
                  AND isay001 = l_osae001_1
                  AND isay002 = g_isae_m.isae002
                  AND isay003 = g_isae_m.isae003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "del isay_t:",SQLERRMESSAGE
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF
            END IF
         END IF
         CALL s_transaction_end('Y','0')
         DISPLAY ARRAY g_isae_d TO s_detail1.*
         
         ON ACTION query
            CLEAR FORM
            LET l_flag =1
            CALL g_isae_d.clear() 
            INITIALIZE g_isae_m.* TO NULL
            EXIT DISPLAY
         END DISPLAY
      END IF
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      EXIT WHILE
   END IF
END WHILE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aisi050_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisi050_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aisi050_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 年月下拉
# Memo...........:
# Usage..........: CALL aisi050_02_set_combo_scc(p_field,p_scc)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_set_combo_scc(p_field,p_scc)
DEFINE p_field        LIKE type_t.chr80
DEFINE p_scc          LIKE type_t.num5
DEFINE l_gzcb002      LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004     LIKE gzcbl_t.gzcbl004
DEFINE comb_value     STRING
DEFINE comb_item      STRING
DEFINE l_str          STRING

    DECLARE gzcb_cs CURSOR FOR
     SELECT gzcb002,gzcbl004
       FROM gzcb_t
       LEFT OUTER join gzcbl_t ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003 = g_dlang
      WHERE gzcb001 = p_scc
      ORDER BY gzcb002  #160223-00002#2
    FOREACH gzcb_cs INTO l_gzcb002,l_gzcbl004
        LET l_str = l_gzcb002
        LET l_str = l_str.substring(1,1)
        IF l_str = '0' THEN
           LET l_str = l_gzcb002
           LET l_gzcb002 = l_str.substring(2,2)
        END IF
        LET comb_value = comb_value CLIPPED,',',l_gzcb002
        LET comb_item  = comb_item  CLIPPED,',',l_gzcb002
    END FOREACH
    CALL cl_set_combo_items(p_field,comb_value,comb_item)
END FUNCTION

################################################################################
# Descriptions...: 使用者所屬法人
# Memo...........:
# Usage..........: CALL aisi050_02_isaecomp_ref()
# Date & Author..: 日期 By 作者
################################################################################
PRIVATE FUNCTION aisi050_02_isaecomp_ref()
DEFINE l_success     BOOLEAN
DEFINE l_lsaeld      LIKE glaa_t.glaald
DEFINE l_isaecomp    LIKE isae_t.isaecomp
DEFINE l_errno       LIKE type_t.num5
   
  #CALL s_fin_ld_carry('',g_user) RETURNING l_success,l_lsaeld,l_isaecomp,l_errno #160223-00002#2 mark
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_isaecomp,l_lsaeld #160223-00002#2
   
   RETURN l_isaecomp
END FUNCTION

################################################################################
# Descriptions...: 發票類型說明
# Memo...........:
# Usage..........: aisi050_02_isae004_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_isae004_ref()
DEFINE l_ooef019   LIKE ooef_t.ooef019 #所屬稅區

   LET l_ooef019 = ''
   SELECT DISTINCT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooef017 = g_isae_m.isaecomp
      AND ooefent = g_enterprise
      AND ooef001 = g_isae_m.isaesite
   
   SELECT DISTINCT isacl004 INTO g_isae_m.isae004_desc
     FROM isac_t
     LEFT OUTER JOIN isacl_t ON isacent = isaclent AND isac001 = isacl001 AND isac002 = isacl002 AND isacl003 = g_dlang
    WHERE isacent = g_enterprise
      AND isac001 = l_ooef019
      AND isac002 = g_isae_m.isae004
    ORDER BY isac002
   DISPLAY g_isae_m.isae004_desc TO isae004_desc

END FUNCTION

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: aisi050_02_b_fill()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_b_fill()

   LET g_sql = "SELECT isae001,isae002,isae003,isae005,isae006,",
               "       isae007,isae008,isae009,isae010,isae011",
               "  FROM isae_t",
               " WHERE isaesite = '",g_isae_m.isaesite,"'",      #使用者所屬營運據點
               "   AND isae001 = '",g_isae_m.isae001,"'",
               "   AND isaeent = ",g_enterprise #160223-00002#2
   PREPARE aisi050_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisi050_sel
   FOREACH b_fill_curs INTO g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003,g_isae_d[l_ac].isae005,
                            g_isae_d[l_ac].isae006,g_isae_d[l_ac].isae007,g_isae_d[l_ac].isae008,g_isae_d[l_ac].isae009,
                            g_isae_d[l_ac].isae010,g_isae_d[l_ac].isae011
      LET l_ac = l_ac+1
   
   END FOREACH
   CALL g_isae_d.deleteElement(g_isae_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 檢查簿號存在
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_isaeupdate_chk(p_isae001)
  DEFINE p_isae001   LIKE isae_t.isae001
   DEFINE l_count     LIKE type_t.num10  # 錯誤數目     
   DEFINE r_success   BOOLEAN
   DEFINE r_errno     LIKE gzze_t.gzze001
   LET r_success = TRUE
   LET r_errno =''

   LET l_count = ''
   SELECT COUNT(*) INTO l_count
     FROM isae_t
    WHERE isaeent  = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae001  = p_isae001

   IF cl_null(l_count) THEN
      LET l_count = 0
   END IF

    IF l_count > 0  THEN
       LET r_success = FALSE
       LET r_errno ='ais-00146'
    END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 簿號是否存在
# Memo...........:
# Usage..........: CALL aisi050_02_isae001_1_chk
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_isae001_1_chk(p_isae001)
DEFINE p_isae001     LIKE isae_t.isae001
DEFINE l_count       LIKE type_t.num10  # 錯誤數目
DEFINE r_success     BOOLEAN
DEFINE r_errno       LIKE gzze_t.gzze001
   
   LET r_success = TRUE
   LET r_errno =''
   LET l_count = ''
   
   SELECT COUNT(*) INTO l_count
     FROM isae_t
    WHERE isaeent  = g_enterprise
      AND isaesite = g_isae_m.isaesite
      AND isae001  = p_isae001
      AND isae019  = 'aisi050'
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0  THEN
      LET r_success = FALSE
      LET r_errno ='ais-00145'
   END IF

   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 確認簿號是否存在此期間(FOR aisi055)
# Memo...........:
# Usage..........: CALL aisi050_02_isae001_chk()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aisi050_02_isae001_2_chk(p_isae001,p_type)
DEFINE p_isae001     LIKE isae_t.isae001
DEFINE p_type        LIKE type_t.num5    #160223-00002#2
DEFINE l_count       LIKE type_t.num10   # 錯誤數目
DEFINE r_success     BOOLEAN
DEFINE r_errno       LIKE gzze_t.gzze001
   
   LET r_success = TRUE
   LET r_errno =''
   LET l_count = ''
   IF p_type = 2 THEN #160223-00002#2
      SELECT COUNT(*) INTO l_count
        FROM isae_t
       WHERE isaeent  = g_enterprise
         AND isaestus = 'Y'
         AND isaecomp = g_isae_m.isaecomp
         AND isaesite = g_isae_m.isaesite
         AND isae001  = p_isae001
         AND isae016 =  g_isae_m.isae016
         AND isae017 BETWEEN g_isae_m.isae017 AND g_isae_m.isae018
         AND isae013 = 0  #已開張數=0 #160223-00002#2
         AND isae019  = 'aisi055'
   #160223-00002#2 add ------
   ELSE
      SELECT COUNT(*) INTO l_count
        FROM isae_t
       WHERE isaeent  = g_enterprise
         AND isaestus = 'Y'
         AND isaecomp = g_isae_m.isaecomp
         AND isaesite = g_isae_m.isaesite
         AND isae001  = p_isae001
         AND isae016 =  g_isae_m.isae016
         AND isae017 BETWEEN g_isae_m.isae017 AND g_isae_m.isae018
         AND isae013 = 0  #已開張數=0
         AND ((isae005 = 'Y' AND isae022 IS NULL) OR isae005='N') #電子發票若已被取用也不可拆
         AND isae019  = 'aisi056'
   END IF
   #160223-00002#2 add end---
   
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno ='ais-00145'
   END IF

   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 

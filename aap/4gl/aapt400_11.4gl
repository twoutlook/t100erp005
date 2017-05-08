#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt400_11.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-12-04 17:10:07), PR版次:0005(2016-09-05 16:40:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000104
#+ Filename...: aapt400_11
#+ Description: 單身其他資訊維護
#+ Creator....: 03080(2014-04-07 17:36:28)
#+ Modifier...: 01727 -SD/PR- 04152
 
{</section>}
 
{<section id="aapt400_11.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150916-00015#1   2015/12/7  By Xiaozg   当有账套时，科目检查改为检查是否存在于glad_t中
#160321-00016#20  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#25  2016/04/26 BY 07900    校验代码重复错误讯息的修改
#160905-00002#1   2016/09/05 By Reanna   SQL條件少ENT補上
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
PRIVATE type type_g_apce_m        RECORD
       apceseq LIKE apce_t.apceseq, 
   apce009 LIKE type_t.chr1, 
   apce002 LIKE apce_t.apce002, 
   apce015 LIKE apce_t.apce015, 
   apcedocno LIKE apce_t.apcedocno, 
   apceld LIKE apce_t.apceld, 
   apce008 LIKE apce_t.apce008, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce024 LIKE apce_t.apce024, 
   apce025 LIKE apce_t.apce025, 
   apce017 LIKE apce_t.apce017, 
   apce017_desc LIKE type_t.chr80, 
   apce018 LIKE apce_t.apce018, 
   apce018_desc LIKE type_t.chr80, 
   apce019 LIKE apce_t.apce019, 
   apce019_desc LIKE type_t.chr80, 
   apce020 LIKE apce_t.apce020, 
   apce020_desc LIKE type_t.chr80, 
   apce011 LIKE apce_t.apce011, 
   apce011_desc LIKE type_t.chr80, 
   apce012 LIKE apce_t.apce012, 
   apce012_desc LIKE type_t.chr80, 
   apce026 LIKE apce_t.apce026, 
   apce026_desc LIKE type_t.chr80, 
   apce016 LIKE apce_t.apce016, 
   apce016_desc LIKE type_t.chr80, 
   apce021 LIKE apce_t.apce021, 
   apce021_desc LIKE type_t.chr80, 
   apce022 LIKE apce_t.apce022, 
   apce022_desc LIKE type_t.chr80, 
   apce023 LIKE apce_t.apce023, 
   apce023_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_array         DYNAMIC ARRAY OF RECORD
                 chr      LIKE type_t.chr500,
                 dat      LIKE type_t.dat
                          END RECORD
DEFINE g_apce_m_t      type_g_apce_m
DEFINE g_success1      LIKE type_t.num5
DEFINE g_docdt         LIKE type_t.dat 
#ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
#end add-point
 
DEFINE g_apce_m        type_g_apce_m
 
   DEFINE g_apceseq_t LIKE apce_t.apceseq
DEFINE g_apcedocno_t LIKE apce_t.apcedocno
DEFINE g_apceld_t LIKE apce_t.apceld
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt400_11.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt400_11(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_array,p_type
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
   DEFINE p_array         DYNAMIC ARRAY OF RECORD
                 chr      LIKE type_t.chr500,
                 dat      LIKE type_t.dat
                          END RECORD 
   DEFINE p_type          LIKE type_t.chr1
   DEFINE l_glaa004       LIKE glaa_t.glaa004

   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt400_11 WITH FORM cl_ap_formpath("aap","aapt400_11")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL aapt400_11_init()
   CALL aapt400_11_move_to_g_apce()
   LET g_array.* = p_array.*
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apce_m.apceseq,g_apce_m.apce009,g_apce_m.apce002,g_apce_m.apce015,g_apce_m.apcedocno, 
          g_apce_m.apceld,g_apce_m.apce008,g_apce_m.apce003,g_apce_m.apce004,g_apce_m.apce024,g_apce_m.apce025, 
          g_apce_m.apce017,g_apce_m.apce018,g_apce_m.apce019,g_apce_m.apce020,g_apce_m.apce011,g_apce_m.apce012, 
          g_apce_m.apce026,g_apce_m.apce016,g_apce_m.apce021,g_apce_m.apce022,g_apce_m.apce023 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_m.apceseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apceseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apceseq name="input.a.apceseq"
            IF NOT cl_null(g_apce_m.apceseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceseq
            #add-point:BEFORE FIELD apceseq name="input.b.apceseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceseq
            #add-point:ON CHANGE apceseq name="input.g.apceseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce009
            #add-point:BEFORE FIELD apce009 name="input.b.apce009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce009
            
            #add-point:AFTER FIELD apce009 name="input.a.apce009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce009
            #add-point:ON CHANGE apce009 name="input.g.apce009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce002
            #add-point:BEFORE FIELD apce002 name="input.b.apce002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce002
            
            #add-point:AFTER FIELD apce002 name="input.a.apce002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce002
            #add-point:ON CHANGE apce002 name="input.g.apce002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce015
            #add-point:BEFORE FIELD apce015 name="input.b.apce015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce015
            
            #add-point:AFTER FIELD apce015 name="input.a.apce015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce015
            #add-point:ON CHANGE apce015 name="input.g.apce015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcedocno
            #add-point:BEFORE FIELD apcedocno name="input.b.apcedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcedocno
            
            #add-point:AFTER FIELD apcedocno name="input.a.apcedocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcedocno
            #add-point:ON CHANGE apcedocno name="input.g.apcedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceld
            #add-point:BEFORE FIELD apceld name="input.b.apceld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceld
            
            #add-point:AFTER FIELD apceld name="input.a.apceld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceld
            #add-point:ON CHANGE apceld name="input.g.apceld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce008
            #add-point:BEFORE FIELD apce008 name="input.b.apce008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce008
            
            #add-point:AFTER FIELD apce008 name="input.a.apce008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce008
            #add-point:ON CHANGE apce008 name="input.g.apce008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce003
            #add-point:BEFORE FIELD apce003 name="input.b.apce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce003
            
            #add-point:AFTER FIELD apce003 name="input.a.apce003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce003
            #add-point:ON CHANGE apce003 name="input.g.apce003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce004
            #add-point:BEFORE FIELD apce004 name="input.b.apce004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce004
            
            #add-point:AFTER FIELD apce004 name="input.a.apce004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce004
            #add-point:ON CHANGE apce004 name="input.g.apce004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce024
            #add-point:BEFORE FIELD apce024 name="input.b.apce024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce024
            
            #add-point:AFTER FIELD apce024 name="input.a.apce024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce024
            #add-point:ON CHANGE apce024 name="input.g.apce024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce025
            #add-point:BEFORE FIELD apce025 name="input.b.apce025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce025
            
            #add-point:AFTER FIELD apce025 name="input.a.apce025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce025
            #add-point:ON CHANGE apce025 name="input.g.apce025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce017
            
            #add-point:AFTER FIELD apce017 name="input.a.apce017"
            #業務人員
            LET g_apce_m.apce017_desc = ''
            DISPLAY BY NAME g_apce_m.apce017_desc
            IF NOT cl_null(g_apce_m.apce017)THEN
               IF cl_null(g_apce_m_t.apce017) OR (g_apce_m_t.apce017 <> g_apce_m.apce017)THEN
                  CALL s_aap_ooag001_chk(g_apce_m.apce017)RETURNING g_success1,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = 'apce017'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apce_m.apce017 = g_apce_m_t.apce017
                     CALL s_desc_get_person_desc(g_apce_m.apce017) RETURNING g_apce_m.apce017_desc
                     DISPLAY BY NAME g_apce_m.apce017_desc,g_apce_m.apce017
                     NEXT FIELD apce017
                  END IF
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_apce_m.apce017) RETURNING g_apce_m.apce017_desc
            DISPLAY BY NAME g_apce_m.apce017_desc,g_apce_m.apce017

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce017
            #add-point:BEFORE FIELD apce017 name="input.b.apce017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce017
            #add-point:ON CHANGE apce017 name="input.g.apce017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce018
            
            #add-point:AFTER FIELD apce018 name="input.a.apce018"
            #業務部門
            LET g_apce_m.apce018_desc = ''
            DISPLAY BY NAME g_apce_m.apce018_desc
            IF NOT cl_null(g_apce_m.apce018)THEN
               IF cl_null(g_apce_m_t.apce018) OR (g_apce_m_t.apce018 <> g_apce_m.apce018)THEN
                  CALL s_aap_ooag001_chk(g_apce_m.apce018)RETURNING g_success1,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = 'apce018'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apce_m.apce018 = g_apce_m_t.apce018
                     CALL s_desc_get_department_desc(g_apce_m.apce018) RETURNING g_apce_m.apce018_desc
                     DISPLAY BY NAME g_apce_m.apce018_desc,g_apce_m.apce018
                     NEXT FIELD apce018
                  END IF
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_apce_m.apce018) RETURNING g_apce_m.apce018_desc
            DISPLAY BY NAME g_apce_m.apce018_desc,g_apce_m.apce018

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce018
            #add-point:BEFORE FIELD apce018 name="input.b.apce018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce018
            #add-point:ON CHANGE apce018 name="input.g.apce018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce019
            
            #add-point:AFTER FIELD apce019 name="input.a.apce019"
             #責任中心
            LET g_apce_m.apce019_desc = ' '
            IF NOT cl_null(g_apce_m.apce019) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_m.apce019 != g_apce_m_t.apce019 OR g_apce_m_t.apce019 IS NULL )) THEN
                  CALL s_department_chk(g_apce_m.apce019,g_docdt) RETURNING g_success1
                  IF NOT g_success1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apce_m.apce019 = g_apce_m_t.apce019
                     CALL s_desc_get_department_desc(g_apce_m.apce019) RETURNING g_apce_m.apce019_desc
                     DISPLAY BY NAME g_apce_m.apce019_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apce_m.apce019) RETURNING g_apce_m.apce019_desc
            DISPLAY BY NAME g_apce_m.apce019_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce019
            #add-point:BEFORE FIELD apce019 name="input.b.apce019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce019
            #add-point:ON CHANGE apce019 name="input.g.apce019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce020
            
            #add-point:AFTER FIELD apce020 name="input.a.apce020"
            #產品類別
            LET g_apce_m.apce020_desc = ' '
            DISPLAY BY NAME g_apce_m.apce020_desc
            IF NOT cl_null(g_apce_m.apce020) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apce_m.apce020 != g_apce_m_t.apce020 OR g_apce_m_t.apce020 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce_m.apce020
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_rtax001") THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apce_m.apce020 = g_apce_m_t.apce020
                     CALL s_desc_get_rtaxl003_desc(g_apce_m.apce020) RETURNING g_apce_m.apce020_desc
                     DISPLAY BY NAME g_apce_m.apce020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_rtaxl003_desc(g_apce_m.apce020) RETURNING g_apce_m.apce020_desc
            DISPLAY BY NAME g_apce_m.apce020_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce020
            #add-point:BEFORE FIELD apce020 name="input.b.apce020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce020
            #add-point:ON CHANGE apce020 name="input.g.apce020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce011
            
            #add-point:AFTER FIELD apce011 name="input.a.apce011"
            IF NOT cl_null(g_apce_m.apce011)THEN
               IF cl_null(g_apce_m_t.apce011) OR (g_apce_m_t.apce011 <> g_apce_m.apce011)THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce_m.apce011 
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmaj001") THEN
                     LET g_apce_m.apce011 = g_apce_m_t.apce011
                     DISPLAY BY NAME g_apce_m.apce011
                     NEXT FIELD apce011
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce011
            #add-point:BEFORE FIELD apce011 name="input.b.apce011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce011
            #add-point:ON CHANGE apce011 name="input.g.apce011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce012
            
            #add-point:AFTER FIELD apce012 name="input.a.apce012"
            IF NOT cl_null(g_apce_m.apce012)THEN
               IF cl_null(g_apce_m_t.apce012) OR (g_apce_m_t.apce012 <> g_apce_m.apce012)THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apce_m.apce012 
                  IF NOT aapt400_11_apce012_chk() THEN
                     LET g_apce_m.apce012 = g_apce_m_t.apce012
                     DISPLAY BY NAME g_apce_m.apce012
                     NEXT FIELD apce012
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce012
            #add-point:BEFORE FIELD apce012 name="input.b.apce012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce012
            #add-point:ON CHANGE apce012 name="input.g.apce012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce026
            
            #add-point:AFTER FIELD apce026 name="input.a.apce026"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce026
            #add-point:BEFORE FIELD apce026 name="input.b.apce026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce026
            #add-point:ON CHANGE apce026 name="input.g.apce026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce016
            
            #add-point:AFTER FIELD apce016 name="input.a.apce016"
            #沖銷科目
            LET g_apce_m.apce016_desc = ''
            IF NOT cl_null(g_apce_m.apce016) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_apce_m.apceld,g_apce_m.apce016,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_apce_m.apceld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_apce_m.apce016
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_apce_m.apce016
                LET g_qryparam.arg3 = g_apce_m.apceld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_apce_m.apce016 = g_qryparam.return1
                #CALL s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021) RETURNING g_apcb_m.apcb021_desc
           #DISPLAY BY NAME g_apcb_m.apcb021,g_apcb_m.apcb021_desc
              END IF
              IF NOT s_aglt310_getlike_lc_subject(g_apce_m.apceld,g_apce_m.apce016,'N') THEN
                  LET g_apce_m.apce016 = g_apce_m_t.apce016
                     CALL s_desc_get_account_desc(g_apce_m.apceld,g_apce_m.apce016) RETURNING g_apce_m.apce016_desc
                     DISPLAY BY NAME g_apce_m.apce016_desc
                     NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               IF g_apce_m.apce016 != g_apce_m_t.apce016 OR g_apce_m.apce016 IS NULL THEN
                  CALL s_aap_glac002_chk(g_apce_m.apce016,g_apce_m.apceld) RETURNING g_success1,g_errno
                  IF NOT g_success1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#20 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#20 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apce_m.apce016 = g_apce_m_t.apce016
                     CALL s_desc_get_account_desc(g_apce_m.apceld,g_apce_m.apce016) RETURNING g_apce_m.apce016_desc
                     DISPLAY BY NAME g_apce_m.apce016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_account_desc(g_apce_m.apceld,g_apce_m.apce016)  RETURNING g_apce_m.apce016_desc
            DISPLAY BY NAME g_apce_m.apce016_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce016
            #add-point:BEFORE FIELD apce016 name="input.b.apce016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce016
            #add-point:ON CHANGE apce016 name="input.g.apce016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce021
            
            #add-point:AFTER FIELD apce021 name="input.a.apce021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce021
            #add-point:BEFORE FIELD apce021 name="input.b.apce021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce021
            #add-point:ON CHANGE apce021 name="input.g.apce021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce022
            
            #add-point:AFTER FIELD apce022 name="input.a.apce022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce022
            #add-point:BEFORE FIELD apce022 name="input.b.apce022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce022
            #add-point:ON CHANGE apce022 name="input.g.apce022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce023
            
            #add-point:AFTER FIELD apce023 name="input.a.apce023"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce023
            #add-point:BEFORE FIELD apce023 name="input.b.apce023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce023
            #add-point:ON CHANGE apce023 name="input.g.apce023"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apceseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceseq
            #add-point:ON ACTION controlp INFIELD apceseq name="input.c.apceseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce009
            #add-point:ON ACTION controlp INFIELD apce009 name="input.c.apce009"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce002
            #add-point:ON ACTION controlp INFIELD apce002 name="input.c.apce002"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce015
            #add-point:ON ACTION controlp INFIELD apce015 name="input.c.apce015"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcedocno
            #add-point:ON ACTION controlp INFIELD apcedocno name="input.c.apcedocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.apceld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceld
            #add-point:ON ACTION controlp INFIELD apceld name="input.c.apceld"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce008
            #add-point:ON ACTION controlp INFIELD apce008 name="input.c.apce008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce003
            #add-point:ON ACTION controlp INFIELD apce003 name="input.c.apce003"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce004
            #add-point:ON ACTION controlp INFIELD apce004 name="input.c.apce004"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce024
            #add-point:ON ACTION controlp INFIELD apce024 name="input.c.apce024"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce025
            #add-point:ON ACTION controlp INFIELD apce025 name="input.c.apce025"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce017
            #add-point:ON ACTION controlp INFIELD apce017 name="input.c.apce017"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce018
            #add-point:ON ACTION controlp INFIELD apce018 name="input.c.apce018"
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_apce_m.apce018        #給予default值
             LET g_qryparam.arg1 = g_docdt
             CALL q_ooeg001_4()                                #呼叫開窗
             LET g_apce_m.apce018 = g_qryparam.return1         #將開窗取得的值回傳到變數
            #CALL s_desc_get_department_desc(g_apcb_m.apcb010) RETURNING g_apcb_m.apcb010_desc
            #DISPLAY BY NAME g_apcb_m.apcb010,g_apcb_m.apcb010_desc       
             DISPLAY BY NAME g_apce_m.apce018
             NEXT FIELD apce018            
            #END add-point
 
 
         #Ctrlp:input.c.apce019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce019
            #add-point:ON ACTION controlp INFIELD apce019 name="input.c.apce019"
	         #         責任中心
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce019        #給予default值
            CALL q_ooeg001_2()                                #呼叫開窗
            LET g_apce_m.apce019 = g_qryparam.return1         #將開窗取得的值回傳到變數
           #CALL s_desc_get_department_desc(g_apcb_m.apcb011) RETURNING g_apcb_m.apcb011_desc
           #DISPLAY BY NAME g_apcb_m.apcb011,g_apcb_m.apcb011_desc            
            NEXT FIELD apce019 
            #END add-point
 
 
         #Ctrlp:input.c.apce020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce020
            #add-point:ON ACTION controlp INFIELD apce020 name="input.c.apce020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce020         #給予default值
            CALL q_rtax001()                                   #呼叫開窗
            LET g_apce_m.apce020 = g_qryparam.return1          #將開窗取得的值回傳到變數
           #CALL s_desc_get_rtaxl003_desc(g_apcb_m.apcb012) RETURNING g_apcb_m.apcb012_desc
           #DISPLAY BY NAME g_apcb_m.apcb012,g_apcb_m.apcb012_desc       
            DISPLAY BY NAME g_apce_m.apce020
            NEXT FIELD apce020            
            #END add-point
 
 
         #Ctrlp:input.c.apce011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce011
            #add-point:ON ACTION controlp INFIELD apce011 name="input.c.apce011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce011
            LET g_qryparam.default2 = g_apce_m.apce012
            CALL q_nmad003()
            LET g_apce_m.apce011 = g_qryparam.return1     
            LET g_apce_m.apce012 = g_qryparam.return2
            DISPLAY BY NAME g_apce_m.apce011,g_apce_m.apce012
            NEXT FIELD apce011 
            #END add-point
 
 
         #Ctrlp:input.c.apce012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce012
            #add-point:ON ACTION controlp INFIELD apce012 name="input.c.apce012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce011
            LET g_qryparam.default2 = g_apce_m.apce012
            IF NOT cl_null(g_apce_m.apce011)THEN
               LET g_qryparam.where = " nmad002 = '",g_apce_m.apce011,"' "
            END IF
            CALL q_nmad003()                             #呼叫開窗
            LET g_apce_m.apce011 = g_qryparam.return1          #將開窗取得的值回傳到變數
            LET g_apce_m.apce012 = g_qryparam.return2
            DISPLAY BY NAME g_apce_m.apce011,g_apce_m.apce012        #顯示到畫面上
           #CALL aapq400_01_apce012_ref()
           #CALL aapq400_01_nmad002_ref()                         #返回原欄位
            NEXT FIELD apce012
            #END add-point
 
 
         #Ctrlp:input.c.apce026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce026
            #add-point:ON ACTION controlp INFIELD apce026 name="input.c.apce026"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce016
            #add-point:ON ACTION controlp INFIELD apce016 name="input.c.apce016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce016       #給予default值
            LET l_glaa004 = NULL
            SELECT glaa004 INTO l_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_apce_m.apceld 
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_apce_m.apceld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                #呼叫開窗
            LET g_apce_m.apce016 = g_qryparam.return1        #將開窗取得的值回傳到變數
           #CALL s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021) RETURNING g_apcb_m.apcb021_desc
           #DISPLAY BY NAME g_apcb_m.apcb021,g_apcb_m.apcb021_desc
            NEXT FIELD apce016                                     
            #END add-point
 
 
         #Ctrlp:input.c.apce021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce021
            #add-point:ON ACTION controlp INFIELD apce021 name="input.c.apce021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce021      #給予default值
            CALL q_bgaa001()                                #呼叫開窗
            LET g_apce_m.apce021 = g_qryparam.return1       #將開窗取得的值回傳到變數
           #CALL s_desc_get_budget_desc(g_apcb_m.apcb017) RETURNING g_apcb_m.apcb017_desc
           #DISPLAY BY NAME g_apcb_m.apcb017,g_apcb_m.apcb017_desc
            DISPLAY BY NAME g_apce_m.apce021
            NEXT FIELD apce021
            #END add-point
 
 
         #Ctrlp:input.c.apce022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce022
            #add-point:ON ACTION controlp INFIELD apce022 name="input.c.apce022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apce_m.apce022         #給予default值
            CALL q_pjba001()                                   #呼叫開窗
            LET g_apce_m.apce022 = g_qryparam.return1          #將開窗取得的值回傳到變數
           #CALL s_desc_get_project_desc(g_apcb_m.apcb015) RETURNING g_apcb_m.apcb015_desc
           #DISPLAY BY NAME g_apcb_m.apcb015,g_apcb_m.apcb015_desc
            DISPLAY BY NAME g_apce_m.apce022
            NEXT FIELD apce022 
            #END add-point
 
 
         #Ctrlp:input.c.apce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce023
            #add-point:ON ACTION controlp INFIELD apce023 name="input.c.apce023"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt400_11 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
   ELSE
      CALL aapt400_11_move_to_array()
   END IF
      
   RETURN g_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt400_11.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt400_11.other_function" readonly="Y" >}

################################################################################
# Date & Author..: 140502 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_11_move_to_g_apce()
LET g_apce_m.apceseq = g_array[1].chr
   LET g_apce_m.apce009 = g_array[2].chr
   LET g_apce_m.apce002 = g_array[3].chr
   LET g_apce_m.apce015 = g_array[4].chr
   LET g_apce_m.apcedocno = g_array[5].chr
   LET g_apce_m.apceld  = g_array[6].chr
   LET g_apce_m.apce008 = g_array[7].chr 
   LET g_apce_m.apce003 = g_array[8].chr 
   LET g_apce_m.apce004 = g_array[9].chr 
   LET g_apce_m.apce024 = g_array[10].chr 
   LET g_apce_m.apce025 = g_array[11].chr 
   LET g_apce_m.apce017 = g_array[12].chr 
   LET g_apce_m.apce018 = g_array[13].chr 
   LET g_apce_m.apce019 = g_array[14].chr 
   LET g_apce_m.apce020 = g_array[15].chr 
   LET g_apce_m.apce011 = g_array[16].chr 
   LET g_apce_m.apce012 = g_array[17].chr 
   LET g_apce_m.apce026 = g_array[18].chr 
   LET g_apce_m.apce016 = g_array[19].chr 
   LET g_apce_m.apce021 = g_array[20].chr 
   LET g_apce_m.apce022 = g_array[21].chr 
   LET g_apce_m.apce023 = g_array[22].chr
   LET g_docdt          = g_array[23].dat

   LET g_apce_m_t.* = g_apce_m.*
END FUNCTION

################################################################################
# Date & Author..: 140502 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_11_move_to_array()
  LET g_array[1].chr = g_apce_m.apceseq 
  LET g_array[2].chr = g_apce_m.apce009
  LET g_array[3].chr = g_apce_m.apce002
  LET g_array[4].chr = g_apce_m.apce015
  LET g_array[5].chr = g_apce_m.apcedocno 
  LET g_array[6].chr = g_apce_m.apceld  
  LET g_array[7].chr = g_apce_m.apce008 
  LET g_array[8].chr = g_apce_m.apce003 
  LET g_array[9].chr = g_apce_m.apce004 
  LET g_array[10].chr = g_apce_m.apce024 
  LET g_array[11].chr = g_apce_m.apce025 
  LET g_array[12].chr = g_apce_m.apce017 
  LET g_array[13].chr = g_apce_m.apce018 
  LET g_array[14].chr = g_apce_m.apce019 
  LET g_array[15].chr = g_apce_m.apce020 
  LET g_array[16].chr = g_apce_m.apce011 
  LET g_array[17].chr = g_apce_m.apce012 
  LET g_array[18].chr = g_apce_m.apce026 
  LET g_array[19].chr = g_apce_m.apce016 
  LET g_array[20].chr = g_apce_m.apce021 
  LET g_array[21].chr = g_apce_m.apce022 
  LET g_array[22].chr = g_apce_m.apce023 
  LET g_array[23].dat = g_docdt
END FUNCTION

################################################################################
# Date & Author..: 140503 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_11_init()
   CALL cl_set_combo_scc_part('apce002','8506','10,11,12,13,14,15,16,19,20,21,22,41,30,31')
END FUNCTION

################################################################################
# Date & Author..: 140512 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_11_apce012_chk()
 DEFINE r_success   LIKE type_t.num10
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_glaa005   LIKE glaa_t.glaa005

   LET r_success = TRUE

   LET l_glaa005 = NULL
   SELECT glaa005 INTO l_glaa005 FROM glaa_t
    WHERE glaald  = g_apce_m.apceld
      AND glaaent = g_enterprise

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_apce_m.apce012
   LET g_chkparam.arg2 = l_glaa005
   IF NOT cl_chk_exist("v_nmai002") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF NOT cl_null(g_apce_m.apce012)
      AND NOT cl_null(g_apce_m.apce011)THEN

      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM nmad_t
       WHERE nmad002 = g_apce_m.apce011
         AND nmad003 = g_apce_m.apce012
         AND nmadent = g_enterprise   #160905-00002#1
      IF cl_null(l_count)THEN LET l_count = 0 END IF

      IF l_count = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00079'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 

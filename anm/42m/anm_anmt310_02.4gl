#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt310_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-09-29 14:55:43), PR版次:0001(2016-10-31 10:33:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000005
#+ Filename...: anmt310_02
#+ Description: 零用金撥補申請單處理
#+ Creator....: 01531(2016-09-29 14:54:53)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="anmt310_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE type type_g_nmba_m        RECORD
       nmbasite LIKE nmba_t.nmbasite, 
   nmbasite_desc LIKE type_t.chr80, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   nmba002 LIKE nmba_t.nmba002, 
   nmba002_desc LIKE type_t.chr80, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb003_desc LIKE type_t.chr80, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb002_desc LIKE type_t.chr80, 
   nmbb010 LIKE nmbb_t.nmbb010, 
   nmbb010_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa002             LIKE glaa_t.glaa002
DEFINE g_glaa005             LIKE glaa_t.glaa005
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_glaa026             LIKE glaa_t.glaa026
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_sql_bank            STRING
DEFINE g_nmbb029             LIKE nmbb_t.nmbb029
DEFINE g_nmbb004             LIKE nmbb_t.nmbb004
DEFINE g_nmbb005             LIKE nmbb_t.nmbb005
DEFINE g_ooef001             LIKE ooef_t.ooef001
DEFINE g_nmbadocno           LIKE nmba_t.nmbadocno
DEFINE g_ooef017             LIKE ooef_t.ooef017
DEFINE g_wc1                 STRING
#end add-point
 
DEFINE g_nmba_m        type_g_nmba_m
 
   DEFINE g_nmbacomp_t LIKE nmba_t.nmbacomp
DEFINE g_nmbadocno_t LIKE nmba_t.nmbadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt310_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt310_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE l_glaa005       LIKE glaa_t.glaa005
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt310_02 WITH FORM cl_ap_formpath("anm","anmt310_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   INITIALIZE g_nmba_m.* TO NULL
   CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_nmba_m.nmbasite,g_errno
   CALL anmt310_02_get_nmbacomp()
   CALL anmt310_02_get_glaa()   
   CALL anmt310_02_nmbasite_desc()
   LET g_nmba_m.nmba002 = g_user
   CALL anmt310_02_nmba002_desc()
   LET g_nmba_m.nmbadocdt = g_today
   LET g_sql_bank=NULL
   LET g_nmbadocno=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank   
   #WHILE TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
          g_nmba_m.nmbb003,g_nmba_m.nmbb002,g_nmba_m.nmbb010 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbasite
            
            #add-point:AFTER FIELD nmbasite name="input.a.nmbasite"
            IF NOT cl_null(g_nmba_m.nmbasite) THEN 
               CALL anmt310_02_nmbasite_desc()
               CALL anmt310_02_get_nmbacomp()
               CALL anmt310_02_get_glaa()
            END IF   
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbasite
            #add-point:BEFORE FIELD nmbasite name="input.b.nmbasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbasite
            #add-point:ON CHANGE nmbasite name="input.g.nmbasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacomp
            #add-point:BEFORE FIELD nmbacomp name="input.b.nmbacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacomp
            
            #add-point:AFTER FIELD nmbacomp name="input.a.nmbacomp"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t  OR g_nmba_m.nmbadocno != g_nmbadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmba_t WHERE "||"nmbaent = " ||g_enterprise|| " AND "||"nmbacomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbadocno = '"||g_nmba_m.nmbadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbacomp
            #add-point:ON CHANGE nmbacomp name="input.g.nmbacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba002
            
            #add-point:AFTER FIELD nmba002 name="input.a.nmba002"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba002
            #add-point:BEFORE FIELD nmba002 name="input.b.nmba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba002
            #add-point:ON CHANGE nmba002 name="input.g.nmba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocno
            #add-point:BEFORE FIELD nmbadocno name="input.b.nmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno
            
            #add-point:AFTER FIELD nmbadocno name="input.a.nmbadocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t  OR g_nmba_m.nmbadocno != g_nmbadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmba_t WHERE "||"nmbaent = " ||g_enterprise|| " AND "||"nmbacomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbadocno = '"||g_nmba_m.nmbadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocno
            #add-point:ON CHANGE nmbadocno name="input.g.nmbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocdt
            #add-point:BEFORE FIELD nmbadocdt name="input.b.nmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocdt
            
            #add-point:AFTER FIELD nmbadocdt name="input.a.nmbadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocdt
            #add-point:ON CHANGE nmbadocdt name="input.g.nmbadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb003
            
            #add-point:AFTER FIELD nmbb003 name="input.a.nmbb003"
            IF NOT cl_null(g_nmba_m.nmbb003) THEN 
               CALL anmt310_02_nmbb003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmba_m.nmbb003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()       
                  LET g_nmba_m.nmbb003 = ''
                  LET g_nmba_m.nmbb003_desc = ''   
                  DISPLAY g_nmba_m.nmbb003 TO nmbb003
                  DISPLAY g_nmba_m.nmbb003_desc TO nmbb003_desc
               END IF  

               IF NOT s_anmi120_nmll002_chk(g_nmba_m.nmbb003,g_user) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_nmba_m.nmbb003
                  LET g_errparam.code   = 'anm-00574' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_nmba_m.nmbb003 = ''
                  LET g_nmba_m.nmbb003_desc = ''
                  LET g_nmbb004 = '' 
                  NEXT FIELD CURRENT
               END IF
               CALL anmt310_02_nmbb003_desc()
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb003
            #add-point:BEFORE FIELD nmbb003 name="input.b.nmbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb003
            #add-point:ON CHANGE nmbb003 name="input.g.nmbb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="input.a.nmbb002"
            IF NOT cl_null(g_nmba_m.nmbb002) THEN 
               CALL anmt310_02_nmbb002_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmba_m.nmbb002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()       
                  LET g_nmba_m.nmbb002 = ''
                  LET g_nmba_m.nmbb002_desc = ''   
                  DISPLAY g_nmba_m.nmbb002 TO nmbb002
                  DISPLAY g_nmba_m.nmbb002_desc TO nmbb002_desc
               ELSE  
                  IF cl_null(g_nmba_m.nmbb010) THEN 
                     SELECT nmad003 INTO g_nmba_m.nmbb010
                       FROM nmad_t
                      WHERE nmadent = g_enterprise
                        AND nmad001 = g_glaa005
                        AND nmad002 = g_nmba_m.nmbb002    
                     DISPLAY g_nmba_m.nmbb010 TO nmbb010  
                     CALL anmt310_02_nmbb010_desc()  
                   END IF 
               END IF    
               CALL anmt310_02_nmbb002_desc()   
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="input.b.nmbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb002
            #add-point:ON CHANGE nmbb002 name="input.g.nmbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010
            
            #add-point:AFTER FIELD nmbb010 name="input.a.nmbb010"
            IF NOT cl_null(g_nmba_m.nmbb010) THEN 
               CALL anmt310_02_nmbb010_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmba_m.nmbb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                   
                  LET g_nmba_m.nmbb010 = ''
                  LET g_nmba_m.nmbb010_desc = ''   
                  DISPLAY g_nmba_m.nmbb010 TO nmbb010
                  DISPLAY g_nmba_m.nmbb010_desc TO nmbb010_desc
               END IF
               CALL anmt310_02_nmbb010_desc()               
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb010
            #add-point:BEFORE FIELD nmbb010 name="input.b.nmbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb010
            #add-point:ON CHANGE nmbb010 name="input.g.nmbb010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbasite
            #add-point:ON ACTION controlp INFIELD nmbasite name="input.c.nmbasite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmbasite             #給予default值
            LET g_qryparam.where = " ooef206 = 'Y'"
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_nmba_m.nmbasite = g_qryparam.return1    
            CALL anmt310_02_nmbasite_desc()            
            DISPLAY g_nmba_m.nmbasite TO nmbasite              #
            CALL anmt310_02_get_nmbacomp()   
            NEXT FIELD nmbasite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacomp
            #add-point:ON ACTION controlp INFIELD nmbacomp name="input.c.nmbacomp"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002
            #add-point:ON ACTION controlp INFIELD nmba002 name="input.c.nmba002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmba002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001_2()                                #呼叫開窗
 
            LET g_nmba_m.nmba002 = g_qryparam.return1              
            CALL anmt310_02_nmba002_desc()
            DISPLAY g_nmba_m.nmba002 TO nmba002              #

            NEXT FIELD nmba002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="input.c.nmbadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmbadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt310'"
 
            CALL q_ooba002_4()                                #呼叫開窗
 
            LET g_nmba_m.nmbadocno = g_qryparam.return1              

            DISPLAY g_nmba_m.nmbadocno TO nmbadocno              #

            NEXT FIELD nmbadocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocdt
            #add-point:ON ACTION controlp INFIELD nmbadocdt name="input.c.nmbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb003
            #add-point:ON ACTION controlp INFIELD nmbb003 name="input.c.nmbb003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmbb003             #給予default值
            LET g_qryparam.default2 = g_nmbb004

            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")",
                                   " AND  nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmba_m.nmbacomp,"')"
            CALL q_nmas001_2()                                #呼叫開窗 
            LET g_nmba_m.nmbb003 = g_qryparam.return1              
            LET g_nmbb004 = g_qryparam.return2  
            CALL anmt310_02_nmbb003_desc()
            DISPLAY g_nmba_m.nmbb003 TO nmbb003              #
            DISPLAY g_nmba_m.nmbb003_desc TO nmbb003_desc 
            NEXT FIELD nmbb003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002
            #add-point:ON ACTION controlp INFIELD nmbb002 name="input.c.nmbb002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmbb002             #給予default值

            LET g_qryparam.where = " nmaj002 = '2'"

            CALL q_nmaj001()                                #呼叫開窗
 
            LET g_nmba_m.nmbb002 = g_qryparam.return1              
            CALL anmt310_02_nmbb002_desc()
            DISPLAY g_nmba_m.nmbb002 TO nmbb002              #
            DISPLAY g_nmba_m.nmbb002_desc TO nmbb002_desc
            NEXT FIELD nmbb002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010
            #add-point:ON ACTION controlp INFIELD nmbb010 name="input.c.nmbb010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmbb010             #給予default值

            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaacomp = g_nmba_m.nmbacomp AND glaa014 = 'Y'
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
 
            CALL q_nmai002()                                #呼叫開窗
 
            LET g_nmba_m.nmbb010 = g_qryparam.return1              
            CALL anmt310_02_nmbb010_desc()
            DISPLAY g_nmba_m.nmbb010 TO nmbb010              #
            DISPLAY g_nmba_m.nmbb010_desc TO nmbb010_desc 
            NEXT FIELD nmbb010                          #返回原欄位



            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON apagdocno,apahseq,apagdocdt,apag001
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD apagdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apag003 = 'N' AND apagstus = 'Y' AND apah001 IN (",g_sql_bank,")"
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND apagdocno NOT IN (SELECT DISTINCT nmbb071 FROM nmbb_t WHERE nmbbent = ",g_enterprise," AND nmbb071 IS NOT NULL)"
            IF NOT cl_null(g_nmba_m.nmbasite) THEN 
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND apagcomp = '",g_nmba_m.nmbacomp,"'"
            END IF
            CALL q_apagdocno()
            DISPLAY g_qryparam.return1 TO apagdocno      #顯示到畫面上
            DISPLAY g_qryparam.return2 TO apahseq
            NEXT FIELD apagdocno                         #返回原欄位
            
         ON ACTION controlp INFIELD apag001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apac001_1()
            DISPLAY g_qryparam.return1 TO apag001       #顯示到畫面上
            NEXT FIELD apag001                          #返回原欄位            
      END CONSTRUCT        
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
   CLOSE WINDOW w_anmt310_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = TRUE 
   ELSE
      CALL cl_err_collect_init()
      LET g_success = TRUE
      LET g_nmbadocno = NULL
      CALL s_transaction_begin()
      CALL anmt310_02_ins_nmba() RETURNING g_success,g_nmbadocno
      IF g_success = TRUE THEN
         CALL s_transaction_end('Y','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00322'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()           
      ELSE
         CALL s_transaction_end('N','0') 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'aoo-00146'
         LET g_errparam.popup = TRUE
         CALL cl_err()          
      END IF
      CALL cl_err_collect_show()      
   END IF
     
   RETURN g_nmbadocno
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt310_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbasite_desc()
# Date & Author..: 2016/09/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbasite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbasite_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmba002_desc()
# Date & Author..: 2016/09/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmba002_desc()
   LET g_nmba_m.nmba002_desc = ''
   SELECT oofa011 INTO g_nmba_m.nmba002_desc
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa001 IN (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = g_nmba_m.nmba002)
   DISPLAY g_nmba_m.nmba002_desc TO nmba002_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_get_glaa()
# Date & Author..: 2016/09/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_get_glaa()
   LET g_glaald  = ''
   LET g_glaa001 = ''
   LET g_glaa002 = ''
   LET g_glaa005 = ''
   LET g_glaa015 = ''
   LET g_glaa016 = ''
   LET g_glaa017 = ''
   LET g_glaa018 = ''
   LET g_glaa019 = ''
   LET g_glaa020 = ''
   LET g_glaa021 = ''
   LET g_glaa022 = ''
   LET g_glaa003 = ''
   LET g_glaa024 = ''
   
   SELECT glaald,glaa001,glaa002,glaa005,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa003,glaa024                           #2014/12/26 liuym add glaa003,glaa024
          ,glaa026       
     INTO g_glaald,g_glaa001,g_glaa002,g_glaa005,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa003,g_glaa024 #2014/12/26 liuym add g_glaa003,g_glaa024
          ,g_glaa026      
     FROM glaa_t
    WHERE glaaent = g_enterprise   
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmt310_02_nmbacomp()
# Date & Author..: 2016/09/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_get_nmbacomp()
   SELECT ooef017 INTO g_nmba_m.nmbacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbasite 
      AND ooefstus = 'Y'
      AND ooef206 = 'Y'      
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_ins_nmba()
# Date & Author..: 2016/09/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_ins_nmba()
DEFINE l_n          LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5
DEFINE l_ooab002    LIKE ooab_t.ooab002
DEFINE l_ooam003    LIKE ooam_t.ooam003
DEFINE l_nmba RECORD  #銀存收支主檔
       nmbaent LIKE nmba_t.nmbaent, #企業編號
       nmbaownid LIKE nmba_t.nmbaownid, #資料所有者
       nmbaowndp LIKE nmba_t.nmbaowndp, #資料所有部門
       nmbacrtid LIKE nmba_t.nmbacrtid, #資料建立者
       nmbacrtdp LIKE nmba_t.nmbacrtdp, #資料建立部門
       nmbacrtdt LIKE nmba_t.nmbacrtdt, #資料創建日
       nmbamodid LIKE nmba_t.nmbamodid, #資料修改者
       nmbamoddt LIKE nmba_t.nmbamoddt, #最近修改日
       nmbacnfid LIKE nmba_t.nmbacnfid, #資料確認者
       nmbacnfdt LIKE nmba_t.nmbacnfdt, #資料確認日
       nmbastus LIKE nmba_t.nmbastus, #確認碼
       nmbacomp LIKE nmba_t.nmbacomp, #法人
       nmbadocno LIKE nmba_t.nmbadocno, #收支單號
       nmbadocdt LIKE nmba_t.nmbadocdt, #收支日期
       nmbasite LIKE nmba_t.nmbasite, #資金中心
       nmba001 LIKE nmba_t.nmba001, #繳款部門
       nmba002 LIKE nmba_t.nmba002, #帳務人員
       nmba003 LIKE nmba_t.nmba003, #來源作業類型
       nmba004 LIKE nmba_t.nmba004, #交易對象
       nmba005 LIKE nmba_t.nmba005, #一次性交易對象識別碼
       nmba006 LIKE nmba_t.nmba006, #暫收否
       nmba007 LIKE nmba_t.nmba007, #帳務單號
       nmba008 LIKE nmba_t.nmba008, #繳款人員
       nmba009 LIKE nmba_t.nmba009, #核准日期
       nmba010 LIKE nmba_t.nmba010, #帳套二帳務單號
       nmba011 LIKE nmba_t.nmba011, #帳套三帳務單號
       nmba012 LIKE nmba_t.nmba012, #立帳否(for流通)
       nmba013 LIKE nmba_t.nmba013, #起始日期
       nmba014 LIKE nmba_t.nmba014, #截止日期
       nmba015 LIKE nmba_t.nmba015  #往來據點
END RECORD
DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企业编号
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支单号
       nmbbseq LIKE nmbb_t.nmbbseq, #项次
       nmbborga LIKE nmbb_t.nmbborga, #来源组织
       nmbblegl LIKE nmbb_t.nmbblegl, #核算组织
       nmbb001 LIKE nmbb_t.nmbb001, #异动别
       nmbb002 LIKE nmbb_t.nmbb002, #存提码
       nmbb003 LIKE nmbb_t.nmbb003, #交易账户编码
       nmbb004 LIKE nmbb_t.nmbb004, #币种
       nmbb005 LIKE nmbb_t.nmbb005, #汇率
       nmbb006 LIKE nmbb_t.nmbb006, #主账套原币金额
       nmbb007 LIKE nmbb_t.nmbb007, #主账套本币金额
       nmbb008 LIKE nmbb_t.nmbb008, #主账套已冲原币金额
       nmbb009 LIKE nmbb_t.nmbb009, #主账套已冲本币金额
       nmbb010 LIKE nmbb_t.nmbb010, #现金变动码
       nmbb011 LIKE nmbb_t.nmbb011, #本位币二币种
       nmbb012 LIKE nmbb_t.nmbb012, #本位币二汇率
       nmbb013 LIKE nmbb_t.nmbb013, #本位币二金额
       nmbb014 LIKE nmbb_t.nmbb014, #本位币二已冲金额
       nmbb015 LIKE nmbb_t.nmbb015, #本位币三币种
       nmbb016 LIKE nmbb_t.nmbb016, #本位币三汇率
       nmbb017 LIKE nmbb_t.nmbb017, #本位币三金额
       nmbb018 LIKE nmbb_t.nmbb018, #本位币三已冲金额
       nmbb019 LIKE nmbb_t.nmbb019, #辅助账套一汇率
       nmbb020 LIKE nmbb_t.nmbb020, #辅助账套一原币已冲
       nmbb021 LIKE nmbb_t.nmbb021, #辅助账套一本币已冲
       nmbb022 LIKE nmbb_t.nmbb022, #辅助账套二汇率
       nmbb023 LIKE nmbb_t.nmbb023, #辅助账套二原币已冲
       nmbb024 LIKE nmbb_t.nmbb024, #辅助账套二本币已冲
       nmbb025 LIKE nmbb_t.nmbb025, #备注
       nmbb026 LIKE nmbb_t.nmbb026, #交易对象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易对象识别码
       nmbb028 LIKE nmbb_t.nmbb028, #款别编码
       nmbb029 LIKE nmbb_t.nmbb029, #款别分类
       nmbb030 LIKE nmbb_t.nmbb030, #票据号码
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有价券数量
       nmbb033 LIKE nmbb_t.nmbb033, #有价券面额
       nmbb034 LIKE nmbb_t.nmbb034, #有价券起始编号
       nmbb035 LIKE nmbb_t.nmbb035, #有价券结束编号
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡银行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡号
       nmbb038 LIKE nmbb_t.nmbb038, #手续费
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收机构
       nmbb040 LIKE nmbb_t.nmbb040, #背书转入
       nmbb041 LIKE nmbb_t.nmbb041, #发票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票况
       nmbb043 LIKE nmbb_t.nmbb043, #票据付款银行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率种类
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #转付交易对象
       nmbb047 LIKE nmbb_t.nmbb047, #票据流通期间
       nmbb048 LIKE nmbb_t.nmbb048, #贴现利率种类
       nmbb049 LIKE nmbb_t.nmbb049, #贴现利率
       nmbb050 LIKE nmbb_t.nmbb050, #贴现期间
       nmbb051 LIKE nmbb_t.nmbb051, #贴现拨款原币金额
       nmbb052 LIKE nmbb_t.nmbb052, #贴现拨款本币金额
       nmbb053 LIKE nmbb_t.nmbb053, #缴款人员
       nmbb054 LIKE nmbb_t.nmbb054, #缴款部门
       nmbb055 LIKE nmbb_t.nmbb055, #POS缴款单号
       nmbb056 LIKE nmbb_t.nmbb056, #入账汇率
       nmbb057 LIKE nmbb_t.nmbb057, #入账原币金额
       nmbb058 LIKE nmbb_t.nmbb058, #入账主账套本币金额
       nmbb059 LIKE nmbb_t.nmbb059, #入账主账套本位币二汇率
       nmbb060 LIKE nmbb_t.nmbb060, #入账主账套本位币二金额
       nmbb061 LIKE nmbb_t.nmbb061, #入账主账套本位币三汇率
       nmbb062 LIKE nmbb_t.nmbb062, #入账主账套本位币三金额
       nmbb063 LIKE nmbb_t.nmbb063, #对方会科
       nmbb064 LIKE nmbb_t.nmbb064, #差异处理状态
       nmbb065 LIKE nmbb_t.nmbb065, #开票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重评后本币金额
       nmbb067 LIKE nmbb_t.nmbb067, #重评后本位币二金额
       nmbb068 LIKE nmbb_t.nmbb068, #重评后本位币三金额
       nmbb069 LIKE nmbb_t.nmbb069, #质押否
       nmbb070 LIKE nmbb_t.nmbb070, #往来据点
       nmbb071 LIKE nmbb_t.nmbb071,
       nmbb072 LIKE nmbb_t.nmbb072
END RECORD   
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企业编号
       glbcld LIKE glbc_t.glbcld, #账套
       glbccomp LIKE glbc_t.glbccomp, #营运据点
       glbcdocno LIKE glbc_t.glbcdocno, #凭证编号
       glbcseq LIKE glbc_t.glbcseq, #项次
       glbcseq1 LIKE glbc_t.glbcseq1, #序号
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期别
       glbc003 LIKE glbc_t.glbc003, #借贷别
       glbc004 LIKE glbc_t.glbc004, #现金变动码
       glbc005 LIKE glbc_t.glbc005, #关系人
       glbc006 LIKE glbc_t.glbc006, #交易币种
       glbc007 LIKE glbc_t.glbc007, #汇率
       glbc008 LIKE glbc_t.glbc008, #原币金额
       glbc009 LIKE glbc_t.glbc009, #本币金额
       glbc010 LIKE glbc_t.glbc010, #数据源
       glbc011 LIKE glbc_t.glbc011, #汇率(本位币二)
       glbc012 LIKE glbc_t.glbc012, #金额(本位币二)
       glbc013 LIKE glbc_t.glbc013, #汇率(本位币三)
       glbc014 LIKE glbc_t.glbc014, #金额(本位币三)
       glbc015 LIKE glbc_t.glbc015  #状态码
END RECORD 
DEFINE l_apag RECORD  #零用金撥補申請主檔
       apagent LIKE apag_t.apagent, #集團碼
       apagsite LIKE apag_t.apagsite, #資金中心
       apagcomp LIKE apag_t.apagcomp, #法人組織
       apagdocno LIKE apag_t.apagdocno, #撥補單號
       apag001 LIKE apag_t.apag001, #零用金帳戶
       apag002 LIKE apag_t.apag002, #申請人員
       apag003 LIKE apag_t.apag003, #結案否
       apagownid LIKE apag_t.apagownid, #資料所有者
       apagowndp LIKE apag_t.apagowndp, #資料所屬部門
       apagcrtid LIKE apag_t.apagcrtid, #資料建立者
       apagcrtdp LIKE apag_t.apagcrtdp, #資料建立部門
       apagcrtdt LIKE apag_t.apagcrtdt, #資料創建日
       apagmodid LIKE apag_t.apagmodid, #資料修改者
       apagmoddt LIKE apag_t.apagmoddt, #最近修改日
       apagcnfid LIKE apag_t.apagcnfid, #資料確認者
       apagcnfdt LIKE apag_t.apagcnfdt, #資料確認日
       apagstus LIKE apag_t.apagstus  #狀態碼
END RECORD
DEFINE l_apah RECORD  #零用金撥補申請明細檔
       apahent LIKE apah_t.apahent, #集團碼
       apahsite LIKE apah_t.apahsite, #資金中心
       apahcomp LIKE apah_t.apahcomp, #法人組織
       apahdocno LIKE apah_t.apahdocno, #撥補單號
       apahseq LIKE apah_t.apahseq, #項次
       apah001 LIKE apah_t.apah001, #交易帳戶編號
       apah002 LIKE apah_t.apah002, #存提碼
       apah003 LIKE apah_t.apah003, #備註
       apah004 LIKE apah_t.apah004, #申請入帳日期
       apah005 LIKE apah_t.apah005, #銀存收支單號
       apah006 LIKE apah_t.apah006, #銀存收支項次
       apah100 LIKE apah_t.apah100, #幣別
       apah103 LIKE apah_t.apah103, #申請撥補金額
       apah104 LIKE apah_t.apah104  #銀存入帳金額
END RECORD
DEFINE l_apagcomp   LIKE apag_t.apagcomp
DEFINE l_apagdocno  LIKE apag_t.apagdocno
DEFINE l_cnt        LIKE type_t.num5 
DEFINE l_n1         LIKE type_t.num5 
DEFINE l_cnt1       LIKE type_t.num5
DEFINE l_nmbb071    LIKE nmbb_t.nmbb071

    LET r_success = TRUE
    LET l_n = 0
    LET l_n1 = 0
    LET g_wc1 = cl_replace_str(g_wc,'apagdocno','nmbb071')
    LET g_wc1 = cl_replace_str(g_wc1,'apahseq','nmbb072')
    #检查是否有存在的资料
    LET g_sql = " SELECT COUNT(1) FROM apag_t LEFT OUTER JOIN apah_t ON apagent = apahent AND apagdocno = apahdocno AND apagcomp = apahcomp ",
                "  WHERE apagent = ",g_enterprise," AND ",g_wc CLIPPED,
                "    AND apag003 = 'N' AND apagstus = 'Y' ",
                "    AND (apah005 IS NULL OR apah104 = 0 )",  #銀存收支單號空白或入帳金額  = 0   
                "    AND apah001 IN (",g_sql_bank,")",
                "    AND apagcomp = '",g_nmba_m.nmbacomp,"'"                
    PREPARE anmt310_02_pre2 FROM g_sql
    EXECUTE anmt310_02_pre2 INTO l_n1
    IF l_n1 = 0 THEN 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = ""
       LET g_errparam.code   = "agl-00167"   
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       LET r_success = FALSE
    END IF   
    
    IF l_n1 > 0 THEN 
       #检查是否已存在anmt310
       LET l_cnt1 = 1
       LET g_sql = " SELECT DISTINCT nmbb071 FROM nmbb_t WHERE nmbbent = ",g_enterprise," AND ",g_wc1 CLIPPED,
                   "    AND nmbb071 IN (SELECT apagdocno FROM apag_t LEFT OUTER JOIN apah_t ",
                   "     ON apagent = apahent AND apagdocno = apahdocno AND apagcomp = apahcomp ",
                   "    WHERE apagent = ",g_enterprise," AND ",g_wc CLIPPED,
                   "    AND apagstus <> 'X' ", 
                   "    AND apah001 IN (",g_sql_bank,"))",
                   "    AND nmbbcomp = '",g_nmba_m.nmbacomp,"'"                    
       PREPARE anmt310_02_pre3 FROM g_sql 
       DECLARE anmt310_02_cur3 CURSOR FOR anmt310_02_pre3
       FOREACH anmt310_02_cur3 INTO l_nmbb071
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF   
         IF NOT cl_null(l_nmbb071) THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_nmbb071
            LET g_errparam.code   = "anm-03032"
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE            
         END IF         
       END FOREACH    
    END IF
    
    #检查是否同法人
    LET l_cnt = 1
    LET g_sql = " SELECT DISTINCT apagcomp,apagdocno FROM apag_t LEFT OUTER JOIN apah_t ",
                "     ON apagent = apahent AND apagdocno = apahdocno AND apagcomp = apahcomp ",
                "  WHERE apagent = ",g_enterprise," AND ",g_wc CLIPPED,
                "    AND apag003 = 'N' AND apagstus = 'Y' ",
                "    AND (apah005 IS NULL OR apah104 = 0)",  #銀存收支單號空白或入帳金額  = 0   
                "    AND apah001 IN (",g_sql_bank,")",
                "    AND apagdocno NOT IN(SELECT nmbb071 FROM nmbb_t WHERE nmbbent = ",g_enterprise," AND ",g_wc1 CLIPPED ," AND nmbbcomp = '",g_nmba_m.nmbacomp,"' AND nmbb071 IS NOT NULL) "                
    PREPARE anmt310_02_pre1 FROM g_sql 
    DECLARE anmt310_02_cur1 CURSOR FOR anmt310_02_pre1
    FOREACH anmt310_02_cur1 INTO l_apagcomp,l_apagdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH apag1:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF     
      IF l_apagcomp <> g_nmba_m.nmbacomp THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-03030'
         LET g_errparam.extend = l_apagdocno
         LET g_errparam.popup = FALSE
         LET r_success = FALSE
         CALL cl_err()         
      END IF
      IF l_apagcomp = g_nmba_m.nmbacomp THEN
         LET r_success = TRUE
         LET l_cnt = l_cnt + 1
      END IF
    END FOREACH  
    


    IF l_cnt > 1 AND l_n1 <> 0 THEN #有同法人资料才新增单头
       #INS nmba_t
       CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,'anmt310')  
          RETURNING r_success,l_nmba.nmbadocno 
          
       LET l_nmba.nmbaent = g_enterprise
       LET l_nmba.nmbaownid = g_user
       LET l_nmba.nmbaowndp = g_dept
       LET l_nmba.nmbacrtdp = g_dept
       LET l_nmba.nmbacrtid = g_user
       LET l_nmba.nmbacrtdt = cl_get_current()
       LET l_nmba.nmbastus  = 'N'
       LET l_nmba.nmbacomp = g_nmba_m.nmbacomp
       LET l_nmba.nmbadocdt = g_nmba_m.nmbadocdt
       LET l_nmba.nmbasite = g_nmba_m.nmbasite
       #申请人员归属部门
       SELECT ooag003 INTO l_nmba.nmba001 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = l_apag.apag002 
       LET l_nmba.nmba002 = g_nmba_m.nmba002 
       LET l_nmba.nmba003 = 'aapt352'
       LET l_nmba.nmba004 = 'MISC'
       LET l_nmba.nmba006 = 'N'
       LET l_nmba.nmba012 = 'N'      
       LET l_nmba.nmba015 = 'N' 
       LET l_nmba.nmba006 = 'Y'
       INSERT INTO nmba_t(nmbaent,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,
                          nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt,
                          nmbastus,nmbacomp,nmbadocno,nmbadocdt,nmbasite,
                          nmba001,nmba002,nmba003,nmba004,nmba005,
                          nmba006,nmba007,nmba008,nmba009,nmba010,
                          nmba011,nmba012,nmba013,nmba014,nmba015) VALUES
                         (l_nmba.nmbaent,  l_nmba.nmbaownid,l_nmba.nmbaowndp,l_nmba.nmbacrtid,l_nmba.nmbacrtdp,
                          l_nmba.nmbacrtdt,l_nmba.nmbamodid,l_nmba.nmbamoddt,l_nmba.nmbacnfid,l_nmba.nmbacnfdt,
                          l_nmba.nmbastus, l_nmba.nmbacomp, l_nmba.nmbadocno,l_nmba.nmbadocdt,l_nmba.nmbasite,
                          l_nmba.nmba001,  l_nmba.nmba002,  l_nmba.nmba003,  l_nmba.nmba004,  l_nmba.nmba005,
                          l_nmba.nmba006,  l_nmba.nmba007,  l_nmba.nmba008,  l_nmba.nmba009,  l_nmba.nmba010,
                          l_nmba.nmba011,  l_nmba.nmba012,  l_nmba.nmba013,  l_nmba.nmba014,  l_nmba.nmba015)
                          
            IF SQLCA.sqlcode THEN 
               LET r_success = FALSE   
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ins nmba"
               LET g_errparam.popup = FALSE
               LET r_success = FALSE
               CALL cl_err()
            END IF  
    
    #INS nmbb_t                    
 
                                   #申请人员 #交易账户  #交易币别  #申请拨补金额 #存提码
                                            #（拨入的零佣金账户）
    LET g_sql = " SELECT DISTINCT apahdocno,apahseq,apag002, apah001,   apah100  ,apah103 ,    apah002 ",
                "   FROM apag_t LEFT OUTER JOIN apah_t ON apagent = apahent AND apagdocno = apahdocno AND apagcomp = apahcomp ",
                "  WHERE apagent = ",g_enterprise," AND ",g_wc CLIPPED," AND apagcomp = '",g_nmba_m.nmbacomp,"'",
                "    AND apag003 = 'N' AND apagstus = 'Y' ",
                "    AND (apah005 IS NULL OR apah104 = 0 )",  #銀存收支單號空白或入帳金額  = 0   
                "    AND apah001 IN (",g_sql_bank,")"              
    PREPARE anmt310_02_pre FROM g_sql 
    DECLARE anmt310_02_cur CURSOR FOR anmt310_02_pre
    FOREACH anmt310_02_cur INTO l_apah.apahdocno,l_apah.apahseq,l_apag.apag002,l_apah.apah001,l_apah.apah100,l_apah.apah103,l_apah.apah002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH apag:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF 
      #零佣金账户存入
      LET l_nmbb.nmbbdocno = l_nmba.nmbadocno
      LET l_nmbb.nmbbent = g_enterprise
      LET l_nmbb.nmbbcomp = g_nmba_m.nmbacomp
      SELECT MAX(nmbbseq) INTO l_n FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp AND nmbbdocno = l_nmba.nmbadocno 
         IF cl_null(l_n) THEN LET l_n = 1 ELSE LET l_n = l_n + 1 END IF 
      LET l_nmbb.nmbbseq = l_n  
      LET l_nmbb.nmbborga = g_nmba_m.nmbasite      
      LET l_nmbb.nmbblegl = g_nmba_m.nmbasite
      LET l_nmbb.nmbb003 = l_apah.apah001  #零佣金账户
      LET l_nmbb.nmbb071 = l_apah.apahdocno #来源单号
      LET l_nmbb.nmbb072 = l_apah.apahseq   #项次
      LET l_nmbb.nmbb001 = '1'             #拨入
      LET l_nmbb.nmbb002 = l_apah.apah002  #存提码
      LET l_nmbb.nmbb004 = l_apah.apah100  #币别
      LET l_nmbb.nmbb031 = g_today
      LET l_nmbb.nmbb026 = 'MISC'
      LET l_nmbb.nmbb070 = 'N'
      
      #现金变动码
      SELECT nmad003 INTO l_nmbb.nmbb010 FROM nmad_t
       WHERE nmadent = g_enterprise
         AND nmad001 = g_glaa005
         AND nmad002 = l_nmbb.nmbb002   
   
      CALL anmt310_02_get_exrate('1',l_nmbb.nmbb003,l_nmbb.nmbb004)
      LET l_nmbb.nmbb005 = g_nmbb005
      LET l_nmbb.nmbb006 = l_apah.apah103 
      LET l_nmbb.nmbb007 = l_nmbb.nmbb006*l_nmbb.nmbb005
      
      LET l_nmbb.nmbb011 = g_glaa016
      IF g_glaa015 = 'Y' THEN 
         #來源幣別
         LET l_ooam003 = ''
         IF g_glaa017 = '1' THEN
            LET l_ooam003 = l_nmbb.nmbb004
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001           #帳套使用幣別
         END IF
                    #     帳套;       日期;           來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   g_glaa016,0,g_glaa018)
         RETURNING l_nmbb.nmbb012
         IF g_glaa017 = '1' THEN #原幣
            LET l_nmbb.nmbb013 = l_nmbb.nmbb006 * l_nmbb.nmbb012
         ELSE #本幣
            LET l_nmbb.nmbb013 = l_nmbb.nmbb007 * l_nmbb.nmbb012
         END IF
      END IF
  
      LET l_nmbb.nmbb015 = g_glaa020
      #本位幣三  
      IF g_glaa019 = 'Y' THEN 
         #來源幣別
         LET l_ooam003 = ''
         IF g_glaa021 = '1' THEN
            LET l_ooam003 = l_nmbb.nmbb004
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001           #帳套使用幣別
         END IF
                #     帳套;       日期;           來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   g_glaa020,0,g_glaa022)
         RETURNING l_nmbb.nmbb016
         IF g_glaa021 = '1' THEN
            LET l_nmbb.nmbb017 = l_nmbb.nmbb006 * l_nmbb.nmbb016
         ELSE
            LET l_nmbb.nmbb017 = l_nmbb.nmbb007 * l_nmbb.nmbb016
         END IF
      END IF      
      LET l_nmbb.nmbb053 = g_user
      LET l_nmbb.nmbb054 = g_dept
      LET l_nmbb.nmbb056 = l_nmbb.nmbb005	     #繳款匯率            
      LET l_nmbb.nmbb057 = l_nmbb.nmbb006	     #主帳套原幣金額(繳款)
      LET l_nmbb.nmbb058 = l_nmbb.nmbb007	     #主帳套本幣金額(繳款)
      LET l_nmbb.nmbb059 = l_nmbb.nmbb012	     #主帳套本位幣二匯率(繳款)
      LET l_nmbb.nmbb060 = l_nmbb.nmbb013	     #主帳套本位幣二金額(繳款)
      LET l_nmbb.nmbb061 = l_nmbb.nmbb016	     #主帳套本位幣三匯率(繳款)
      LET l_nmbb.nmbb062 = l_nmbb.nmbb017	     #主帳套本位幣三金額(繳款) 
      
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb007,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb007
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb006,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb006
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb012,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb012
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb013,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb013
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb016,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb016
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb017,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb017   
       
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb057,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb057
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb058,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb058
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb059,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb059
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb060,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb060
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb061,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb061
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb062,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb062  
           
      #零佣金账户存入            
      INSERT INTO nmbb_t(nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,
                         nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,
                         nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,
                         nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,
                         nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,
                         nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,
                         nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,
                         nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,
                         nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,
                         nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,
                         nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,
                         nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,
                         nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,
                         nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,
                         nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,
                         nmbb070,nmbb071,nmbb072) VALUES
                        (l_nmbb.nmbbent, l_nmbb.nmbbcomp,l_nmbb.nmbbdocno,l_nmbb.nmbbseq,l_nmbb.nmbborga,
                         l_nmbb.nmbblegl,l_nmbb.nmbb001, l_nmbb.nmbb002,  l_nmbb.nmbb003,l_nmbb.nmbb004,
                         l_nmbb.nmbb005, l_nmbb.nmbb006, l_nmbb.nmbb007,  l_nmbb.nmbb008,l_nmbb.nmbb009,
                         l_nmbb.nmbb010, l_nmbb.nmbb011, l_nmbb.nmbb012,  l_nmbb.nmbb013,l_nmbb.nmbb014,
                         l_nmbb.nmbb015, l_nmbb.nmbb016, l_nmbb.nmbb017,  l_nmbb.nmbb018,l_nmbb.nmbb019,
                         l_nmbb.nmbb020, l_nmbb.nmbb021, l_nmbb.nmbb022,  l_nmbb.nmbb023,l_nmbb.nmbb024,
                         l_nmbb.nmbb025, l_nmbb.nmbb026, l_nmbb.nmbb027,  l_nmbb.nmbb028,l_nmbb.nmbb029,
                         l_nmbb.nmbb030, l_nmbb.nmbb031, l_nmbb.nmbb032,  l_nmbb.nmbb033,l_nmbb.nmbb034,
                         l_nmbb.nmbb035, l_nmbb.nmbb036, l_nmbb.nmbb037,  l_nmbb.nmbb038,l_nmbb.nmbb039,
                         l_nmbb.nmbb040, l_nmbb.nmbb041, l_nmbb.nmbb042,  l_nmbb.nmbb043,l_nmbb.nmbb044,
                         l_nmbb.nmbb045, l_nmbb.nmbb046, l_nmbb.nmbb047,  l_nmbb.nmbb048,l_nmbb.nmbb049,
                         l_nmbb.nmbb050, l_nmbb.nmbb051, l_nmbb.nmbb052,  l_nmbb.nmbb053,l_nmbb.nmbb054,
                         l_nmbb.nmbb055, l_nmbb.nmbb056, l_nmbb.nmbb057,  l_nmbb.nmbb058,l_nmbb.nmbb059,
                         l_nmbb.nmbb060, l_nmbb.nmbb061, l_nmbb.nmbb062,  l_nmbb.nmbb063,l_nmbb.nmbb064,
                         l_nmbb.nmbb065, l_nmbb.nmbb066, l_nmbb.nmbb067,  l_nmbb.nmbb068,l_nmbb.nmbb069,
                         l_nmbb.nmbb070, l_nmbb.nmbb071, l_nmbb.nmbb072)
         IF SQLCA.sqlcode THEN 
            LET r_success = FALSE   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbb1"
            LET g_errparam.popup = FALSE
            LET r_success = FALSE
            CALL cl_err()
         END IF
      CALL anmt310_02_ins_glbc(l_nmbb.*) RETURNING r_success
      
      #拨出账户提出
      LET l_n = 0          
      SELECT MAX(nmbbseq) INTO l_n FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp AND nmbbdocno = l_nmba.nmbadocno 
         IF cl_null(l_n) THEN LET l_n = 1 ELSE LET l_n = l_n + 1 END IF 
      LET l_nmbb.nmbbseq = l_n   
      LET l_nmbb.nmbb001 = '2'             #拨入
      LET l_nmbb.nmbb002 = g_nmba_m.nmbb002  #存提码
      LET l_nmbb.nmbb010 = g_nmba_m.nmbb010  #現金變動碼
      LET l_nmbb.nmbb003 = g_nmba_m.nmbb003 #撥出帳戶
      CALL anmt310_02_get_nmbb004()
      LET l_nmbb.nmbb004 = g_nmbb004      #幣別
      CALL anmt310_02_get_exrate('2',l_nmbb.nmbb003,l_nmbb.nmbb004)
      LET l_nmbb.nmbb005 = g_nmbb005
      LET l_nmbb.nmbb006 = l_nmbb.nmbb007/l_nmbb.nmbb005 
      LET l_nmbb.nmbb007 = l_nmbb.nmbb007
       
      LET l_nmbb.nmbb011 = g_glaa016
      IF g_glaa015 = 'Y' THEN 
         #來源幣別
         LET l_ooam003 = ''
         IF g_glaa017 = '1' THEN
            LET l_ooam003 = l_nmbb.nmbb004
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001           #帳套使用幣別
         END IF
                    #     帳套;       日期;           來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   g_glaa016,0,g_glaa018)
         RETURNING l_nmbb.nmbb012
         IF g_glaa017 = '1' THEN #原幣
            LET l_nmbb.nmbb013 = l_nmbb.nmbb006 * l_nmbb.nmbb012
         ELSE #本幣
            LET l_nmbb.nmbb013 = l_nmbb.nmbb007 * l_nmbb.nmbb012
         END IF
      END IF
  
      LET l_nmbb.nmbb015 = g_glaa020
      #本位幣三  
      IF g_glaa019 = 'Y' THEN 
         #來源幣別
         LET l_ooam003 = ''
         IF g_glaa021 = '1' THEN
            LET l_ooam003 = l_nmbb.nmbb004
         ELSE   #表示帳簿幣別 
            LET l_ooam003 = g_glaa001           #帳套使用幣別
         END IF
                #     帳套;       日期;           來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別; 交易金額; 匯類類型
                                   g_glaa020,0,g_glaa022)
         RETURNING l_nmbb.nmbb016
         IF g_glaa021 = '1' THEN
            LET l_nmbb.nmbb017 = l_nmbb.nmbb006 * l_nmbb.nmbb016
         ELSE
            LET l_nmbb.nmbb017 = l_nmbb.nmbb007 * l_nmbb.nmbb016
         END IF
      END IF      
      LET l_nmbb.nmbb053 = g_user
      LET l_nmbb.nmbb054 = g_dept
      LET l_nmbb.nmbb056 = l_nmbb.nmbb005	     #繳款匯率            
      LET l_nmbb.nmbb057 = l_nmbb.nmbb006	     #主帳套原幣金額(繳款)
      LET l_nmbb.nmbb058 = l_nmbb.nmbb007	     #主帳套本幣金額(繳款)
      LET l_nmbb.nmbb059 = l_nmbb.nmbb012	     #主帳套本位幣二匯率(繳款)
      LET l_nmbb.nmbb060 = l_nmbb.nmbb013	     #主帳套本位幣二金額(繳款)
      LET l_nmbb.nmbb061 = l_nmbb.nmbb016	     #主帳套本位幣三匯率(繳款)
      LET l_nmbb.nmbb062 = l_nmbb.nmbb017	     #主帳套本位幣三金額(繳款) 
      
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb007,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb007
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb006,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb006
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb012,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb012
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb013,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb013
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb016,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb016
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb017,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb017   
       
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb057,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb057
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb058,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb058
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb059,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb059
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb060,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb060
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb061,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb061
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmbb.nmbb062,2)
         RETURNING l_success,g_errno,l_nmbb.nmbb062        
      
      #拨出账户提出           
      INSERT INTO nmbb_t(nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,
                         nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,
                         nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,
                         nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,
                         nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,
                         nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,
                         nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,
                         nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,
                         nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,
                         nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,
                         nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,
                         nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,
                         nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,
                         nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,
                         nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,
                         nmbb070,nmbb071,nmbb072) VALUES
                        (l_nmbb.nmbbent, l_nmbb.nmbbcomp,l_nmbb.nmbbdocno,l_nmbb.nmbbseq,l_nmbb.nmbborga,
                         l_nmbb.nmbblegl,l_nmbb.nmbb001, l_nmbb.nmbb002,  l_nmbb.nmbb003,l_nmbb.nmbb004,
                         l_nmbb.nmbb005, l_nmbb.nmbb006, l_nmbb.nmbb007,  l_nmbb.nmbb008,l_nmbb.nmbb009,
                         l_nmbb.nmbb010, l_nmbb.nmbb011, l_nmbb.nmbb012,  l_nmbb.nmbb013,l_nmbb.nmbb014,
                         l_nmbb.nmbb015, l_nmbb.nmbb016, l_nmbb.nmbb017,  l_nmbb.nmbb018,l_nmbb.nmbb019,
                         l_nmbb.nmbb020, l_nmbb.nmbb021, l_nmbb.nmbb022,  l_nmbb.nmbb023,l_nmbb.nmbb024,
                         l_nmbb.nmbb025, l_nmbb.nmbb026, l_nmbb.nmbb027,  l_nmbb.nmbb028,l_nmbb.nmbb029,
                         l_nmbb.nmbb030, l_nmbb.nmbb031, l_nmbb.nmbb032,  l_nmbb.nmbb033,l_nmbb.nmbb034,
                         l_nmbb.nmbb035, l_nmbb.nmbb036, l_nmbb.nmbb037,  l_nmbb.nmbb038,l_nmbb.nmbb039,
                         l_nmbb.nmbb040, l_nmbb.nmbb041, l_nmbb.nmbb042,  l_nmbb.nmbb043,l_nmbb.nmbb044,
                         l_nmbb.nmbb045, l_nmbb.nmbb046, l_nmbb.nmbb047,  l_nmbb.nmbb048,l_nmbb.nmbb049,
                         l_nmbb.nmbb050, l_nmbb.nmbb051, l_nmbb.nmbb052,  l_nmbb.nmbb053,l_nmbb.nmbb054,
                         l_nmbb.nmbb055, l_nmbb.nmbb056, l_nmbb.nmbb057,  l_nmbb.nmbb058,l_nmbb.nmbb059,
                         l_nmbb.nmbb060, l_nmbb.nmbb061, l_nmbb.nmbb062,  l_nmbb.nmbb063,l_nmbb.nmbb064,
                         l_nmbb.nmbb065, l_nmbb.nmbb066, l_nmbb.nmbb067,  l_nmbb.nmbb068,l_nmbb.nmbb069,
                         l_nmbb.nmbb070, l_nmbb.nmbb071, l_nmbb.nmbb072)
         IF SQLCA.sqlcode THEN 
            LET r_success = FALSE   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbb2"
            LET g_errparam.popup = FALSE
            LET r_success = FALSE
            CALL cl_err()
         END IF         
         CALL anmt310_02_ins_glbc(l_nmbb.*) RETURNING r_success
    END FOREACH
    END IF
    RETURN r_success,l_nmba.nmbadocno
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb002_desc()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbb002
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent="||g_enterprise||" AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbb002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbb002_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb003_desc()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbb003
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent="||g_enterprise||" AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbb003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbb003_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb010_desc()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb010_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbb010
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent="||g_enterprise||" AND nmail002=? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbb010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbb010_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb002_chk()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb002_chk()
DEFINE l_nmajstus LIKE nmaj_t.nmajstus
   
   LET g_errno = ''
   
   SELECT nmajstus INTO l_nmajstus
     FROM nmaj_t
    WHERE nmajent = g_enterprise
      AND nmaj001 = g_nmba_m.nmbb002
      AND nmaj002 = '2'
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00017'
      WHEN l_nmajstus = 'N'       LET g_errno = 'anm-00016'
   END CASE      
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb003_chk()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb003_chk()
   DEFINE l_nmaastus            LIKE nmaa_t.nmaastus
   DEFINE l_nmaa003             LIKE nmaa_t.nmaa003
   DEFINE l_nmag002             LIKE nmag_t.nmag002
   DEFINE l_ooab002             LIKE ooab_t.ooab002

   LET g_errno = ''
   
   SELECT nmaastus,nmaa003,nmas003 INTO l_nmaastus,l_nmaa003,g_nmbb004
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmba_m.nmbb003
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef017 = g_nmba_m.nmbacomp)
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00026'
      WHEN l_nmaastus = 'N'       LET g_errno = 'sub-01302'  
   END CASE

   SELECT nmag002 INTO l_nmag002
     FROM nmag_t 
    WHERE nmagent = g_enterprise   
      AND nmag001 = l_nmaa003 
      AND nmagstus = 'Y'
    
   IF l_nmag002 = '5' THEN
      LET g_nmbb029 = '10'  #現金
   ELSE
      LET g_nmbb029 = '20'  #電匯
   END IF 
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_get_nmbb004()
# Input parameter: 
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_get_nmbb004()
   SELECT nmas003 INTO g_nmbb004
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmba_m.nmbb003
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_get_exrate(p_nmbb001,p_nmbb003,p_nmbb004)
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_get_exrate(p_nmbb001,p_nmbb003,p_nmbb004)
DEFINE l_ooab002        LIKE ooab_t.ooab002
DEFINE p_nmbb003        LIKE nmbb_t.nmbb003
DEFINE p_nmbb004        LIKE nmbb_t.nmbb004
DEFINE p_nmbb001        LIKE nmbb_t.nmbb001

   SELECT ooag004 INTO g_ooef001 FROM ooag_t
    WHERE ooagent = g_enterprise   
      AND ooag001 = g_user
      
   IF p_nmbb001 = '2' THEN  
      #銀存支出匯率來源
      CALL cl_get_para(g_enterprise,g_ooef001,'S-FIN-4012') RETURNING l_ooab002 
   ELSE
      SELECT ooab002 INTO l_ooab002 FROM ooab_t
       WHERE ooabent = g_enterprise
         AND ooabsite= g_ooef001
         AND ooab001 = 'S-FIN-4004'      
   END IF   
 
   IF l_ooab002 = '23' THEN
      #銀行日平均匯率
      CALL s_anm_get_exrate(g_glaald,g_nmba_m.nmbacomp,p_nmbb003,p_nmbb004,g_glaa001,g_nmba_m.nmbadocdt) RETURNING g_nmbb005
   ELSE                               #匯率參照表;帳套;           日期;               來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,p_nmbb004,
                               #目的幣別;  交易金額;              匯類類型
                                g_glaa001,0,l_ooab002)
         RETURNING g_nmbb005                    
   END IF                     
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_nmbb010_chk()
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_nmbb010_chk()
   DEFINE l_nmaistus         LIKE nmai_t.nmaistus
   DEFINE l_glaa005          LIKE glaa_t.glaa005
   
   LET g_errno = ''
    #帶值
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
      
   SELECT nmaistus INTO l_nmaistus
     FROM nmai_t
    WHERE nmaient = g_enterprise
      AND nmai001 = l_glaa005
      AND nmai002 = g_nmba_m.nmbb010
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00034'
      WHEN l_nmaistus = 'N'       LET g_errno = 'anm-00035'
   END CASE
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt310_02_ins_glbc(l_nmbb)
# Date & Author..: 2016/09/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_02_ins_glbc(l_nmbb)
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
       glbc005 LIKE glbc_t.glbc005, #關係人
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbc015 LIKE glbc_t.glbc015  #狀態碼
END RECORD
DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企业编号
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支单号
       nmbbseq LIKE nmbb_t.nmbbseq, #项次
       nmbborga LIKE nmbb_t.nmbborga, #来源组织
       nmbblegl LIKE nmbb_t.nmbblegl, #核算组织
       nmbb001 LIKE nmbb_t.nmbb001, #异动别
       nmbb002 LIKE nmbb_t.nmbb002, #存提码
       nmbb003 LIKE nmbb_t.nmbb003, #交易账户编码
       nmbb004 LIKE nmbb_t.nmbb004, #币种
       nmbb005 LIKE nmbb_t.nmbb005, #汇率
       nmbb006 LIKE nmbb_t.nmbb006, #主账套原币金额
       nmbb007 LIKE nmbb_t.nmbb007, #主账套本币金额
       nmbb008 LIKE nmbb_t.nmbb008, #主账套已冲原币金额
       nmbb009 LIKE nmbb_t.nmbb009, #主账套已冲本币金额
       nmbb010 LIKE nmbb_t.nmbb010, #现金变动码
       nmbb011 LIKE nmbb_t.nmbb011, #本位币二币种
       nmbb012 LIKE nmbb_t.nmbb012, #本位币二汇率
       nmbb013 LIKE nmbb_t.nmbb013, #本位币二金额
       nmbb014 LIKE nmbb_t.nmbb014, #本位币二已冲金额
       nmbb015 LIKE nmbb_t.nmbb015, #本位币三币种
       nmbb016 LIKE nmbb_t.nmbb016, #本位币三汇率
       nmbb017 LIKE nmbb_t.nmbb017, #本位币三金额
       nmbb018 LIKE nmbb_t.nmbb018, #本位币三已冲金额
       nmbb019 LIKE nmbb_t.nmbb019, #辅助账套一汇率
       nmbb020 LIKE nmbb_t.nmbb020, #辅助账套一原币已冲
       nmbb021 LIKE nmbb_t.nmbb021, #辅助账套一本币已冲
       nmbb022 LIKE nmbb_t.nmbb022, #辅助账套二汇率
       nmbb023 LIKE nmbb_t.nmbb023, #辅助账套二原币已冲
       nmbb024 LIKE nmbb_t.nmbb024, #辅助账套二本币已冲
       nmbb025 LIKE nmbb_t.nmbb025, #备注
       nmbb026 LIKE nmbb_t.nmbb026, #交易对象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易对象识别码
       nmbb028 LIKE nmbb_t.nmbb028, #款别编码
       nmbb029 LIKE nmbb_t.nmbb029, #款别分类
       nmbb030 LIKE nmbb_t.nmbb030, #票据号码
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有价券数量
       nmbb033 LIKE nmbb_t.nmbb033, #有价券面额
       nmbb034 LIKE nmbb_t.nmbb034, #有价券起始编号
       nmbb035 LIKE nmbb_t.nmbb035, #有价券结束编号
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡银行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡号
       nmbb038 LIKE nmbb_t.nmbb038, #手续费
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收机构
       nmbb040 LIKE nmbb_t.nmbb040, #背书转入
       nmbb041 LIKE nmbb_t.nmbb041, #发票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票况
       nmbb043 LIKE nmbb_t.nmbb043, #票据付款银行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率种类
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #转付交易对象
       nmbb047 LIKE nmbb_t.nmbb047, #票据流通期间
       nmbb048 LIKE nmbb_t.nmbb048, #贴现利率种类
       nmbb049 LIKE nmbb_t.nmbb049, #贴现利率
       nmbb050 LIKE nmbb_t.nmbb050, #贴现期间
       nmbb051 LIKE nmbb_t.nmbb051, #贴现拨款原币金额
       nmbb052 LIKE nmbb_t.nmbb052, #贴现拨款本币金额
       nmbb053 LIKE nmbb_t.nmbb053, #缴款人员
       nmbb054 LIKE nmbb_t.nmbb054, #缴款部门
       nmbb055 LIKE nmbb_t.nmbb055, #POS缴款单号
       nmbb056 LIKE nmbb_t.nmbb056, #入账汇率
       nmbb057 LIKE nmbb_t.nmbb057, #入账原币金额
       nmbb058 LIKE nmbb_t.nmbb058, #入账主账套本币金额
       nmbb059 LIKE nmbb_t.nmbb059, #入账主账套本位币二汇率
       nmbb060 LIKE nmbb_t.nmbb060, #入账主账套本位币二金额
       nmbb061 LIKE nmbb_t.nmbb061, #入账主账套本位币三汇率
       nmbb062 LIKE nmbb_t.nmbb062, #入账主账套本位币三金额
       nmbb063 LIKE nmbb_t.nmbb063, #对方会科
       nmbb064 LIKE nmbb_t.nmbb064, #差异处理状态
       nmbb065 LIKE nmbb_t.nmbb065, #开票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重评后本币金额
       nmbb067 LIKE nmbb_t.nmbb067, #重评后本位币二金额
       nmbb068 LIKE nmbb_t.nmbb068, #重评后本位币三金额
       nmbb069 LIKE nmbb_t.nmbb069, #质押否
       nmbb070 LIKE nmbb_t.nmbb070, #往来据点
       nmbb071 LIKE nmbb_t.nmbb071,
       nmbb072 LIKE nmbb_t.nmbb072
END RECORD  

DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
   
   LET r_success = TRUE   
   LET l_year = YEAR(g_nmba_m.nmbadocdt)
   LET l_month = MONTH(g_nmba_m.nmbadocdt)
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = g_glaald
   LET l_glbc.glbccomp  = g_nmba_m.nmbacomp
   LET l_glbc.glbcdocno = l_nmbb.nmbbdocno
   LET l_glbc.glbcseq   = l_nmbb.nmbbseq
   LET l_glbc.glbc001   = l_year
   LET l_glbc.glbc002   = l_month
   
   SELECT MAX(glbcseq1) + 1 INTO l_glbc.glbcseq1
     FROM glbc_t
    WHERE glbcent = g_enterprise
      AND glbcld =  l_glbc.glbcld
      AND glbcdocno = l_glbc.glbcdocno
      AND glbcseq = l_glbc.glbcseq
      AND glbc001 = l_glbc.glbc001
      AND glbc002 = l_glbc.glbc002   
   IF cl_null(l_glbc.glbcseq1) THEN 
      LET l_glbc.glbcseq1 = 1
   END IF
   
   LET l_glbc.glbc003 = l_nmbb.nmbb001
   LET l_glbc.glbc004 = l_nmbb.nmbb010 
   LET l_glbc.glbc005 = l_nmbb.nmbb026
   LET l_glbc.glbc006 = l_nmbb.nmbb004
   LET l_glbc.glbc007 = l_nmbb.nmbb005
   LET l_glbc.glbc008 = l_nmbb.nmbb006
   LET l_glbc.glbc009 = l_nmbb.nmbb007
   LET l_glbc.glbc010 = '2' 
   #--以下視主帳套有無啟用本位幣
   IF g_glaa015 = 'Y' THEN 
      LET l_glbc.glbc011 = l_nmbb.nmbb012
      LET l_glbc.glbc012 = l_nmbb.nmbb013
   END IF
   IF g_glaa019 = 'Y' THEN 
      LET l_glbc.glbc013 = l_nmbb.nmbb016
      LET l_glbc.glbc014 = l_nmbb.nmbb017
   END IF
   
   LET l_glbc.glbc015 = 'N'  
   
   INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,
                      glbcseq1,glbc001,glbc002,glbc003,glbc004,
                      glbc005,glbc006,glbc007,glbc008,glbc009,
                      glbc010,glbc011,glbc012,glbc013,glbc014,
                      glbc015) 
               VALUES 
                     (l_glbc.glbcent, l_glbc.glbcld, l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,
                      l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002, l_glbc.glbc003,  l_glbc.glbc004,
                      l_glbc.glbc005, l_glbc.glbc006,l_glbc.glbc007, l_glbc.glbc008,  l_glbc.glbc009,
                      l_glbc.glbc010, l_glbc.glbc011,l_glbc.glbc012, l_glbc.glbc013,  l_glbc.glbc014,
                      l_glbc.glbc015)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins glbc_t'
      LET g_errparam.popup = TRUE
      LET r_success = FALSE
      CALL cl_err()
   END IF 
   RETURN r_success   
END FUNCTION

 
{</section>}
 

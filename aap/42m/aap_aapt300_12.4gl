#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_12.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-07-24 15:35:32), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000164
#+ Filename...: aapt300_12
#+ Description: 其他信息
#+ Creator....: 03080(2014-03-17 17:32:20)
#+ Modifier...: 03080 -SD/PR- 00000
 
{</section>}
 
{<section id="aapt300_12.global" >}
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
PRIVATE type type_g_apcb_m        RECORD
       apcb004 LIKE apcb_t.apcb004, 
   ffspace1 LIKE type_t.chr80, 
   apcb005 LIKE apcb_t.apcb005, 
   ffspace2 LIKE type_t.chr80, 
   apcb002 LIKE apcb_t.apcb002, 
   apcb003 LIKE apcb_t.apcb003, 
   ffspace3 LIKE type_t.chr80, 
   apcb008 LIKE apcb_t.apcb008, 
   apcb009 LIKE apcb_t.apcb009, 
   apcb023 LIKE apcb_t.apcb023, 
   apcbdocno LIKE apcb_t.apcbdocno, 
   apcbld LIKE apcb_t.apcbld, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb010_desc LIKE type_t.chr80, 
   apcb011 LIKE apcb_t.apcb011, 
   apcb011_desc LIKE type_t.chr80, 
   apcblegl LIKE apcb_t.apcblegl, 
   apcblegl_desc LIKE type_t.chr80, 
   apcb012 LIKE apcb_t.apcb012, 
   apcb012_desc LIKE type_t.chr80, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb014_desc LIKE type_t.chr80, 
   apcb024 LIKE apcb_t.apcb024, 
   apcb024_desc LIKE type_t.chr80, 
   apcb021 LIKE apcb_t.apcb021, 
   apcb021_desc LIKE type_t.chr80, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb015_desc LIKE type_t.chr80, 
   apcb016 LIKE apcb_t.apcb016, 
   apcb017 LIKE apcb_t.apcb017, 
   apcb017_desc LIKE type_t.chr80, 
   apcb028 LIKE apcb_t.apcb028
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_array         DYNAMIC ARRAY OF RECORD
                 chr      LIKE type_t.chr500,
                 dat      LIKE type_t.dat
                          END RECORD
DEFINE g_apcb_m_t      type_g_apcb_m
DEFINE g_glaa004       LIKE glaa_t.glaa004      #科目參照表
DEFINE g_apcadocdt     LIKE apca_t.apcadocdt    #立帳日期
#end add-point
 
DEFINE g_apcb_m        type_g_apcb_m
 
   DEFINE g_apcbdocno_t LIKE apcb_t.apcbdocno
DEFINE g_apcbld_t LIKE apcb_t.apcbld
DEFINE g_apcbseq_t LIKE apcb_t.apcbseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt300_12.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt300_12(--)
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
   ####################################################
   DEFINE p_array         DYNAMIC ARRAY OF RECORD
                 chr      LIKE type_t.chr500,
                 dat      LIKE type_t.dat
                          END RECORD

   #p_array[1]  apcadocno 應付單號
   #p_array[2]  apcald    帳別
   #p_array[3]  apcb004   產品編號
   #p_array[4]  apcb005   品名規格
   #p_array[5]  apcb002   來源單號
   #p_array[6]  apcb003   來源項次
   #p_array[7]  apcb008   參考單據
   #p_array[8]  apcb009   參考單據項次
   #p_array[9]  apcb023   沖暫估
   #p_array[10] apcb010   業務部門
   #p_array[11] apcb011   責任中心
   #p_array[12] apcblegl  核算組織
   #p_array[13] apcb012   產品類別
   #p_array[14] apcb014   理由碼
   #p_array[15] apcb028   發票號碼
   #p_array[16] apcb021   費用會科
   #p_array[17] apcb015   專案代號
   #p_array[18] apcb016   WBS
   #p_array[19] apcb017   預算項目
   #p_array[20] apcb024   發票號碼
   ####################################################
   DEFINE p_type          LIKE type_t.chr1        #p_type         類型   1:應收 2:應付 3:資金 4:資產
   DEFINE l_apcadocdt     LIKE apca_t.apcadocdt
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_12 WITH FORM cl_ap_formpath("aap","aapt300_12")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_array = p_array
   CALL aapt300_12_move_to_g_apcb()

   LET l_apcadocdt = NULL
   SELECT apcadocdt INTO l_apcadocdt FROM apca_t
    WHERE apcadocno = g_apcb_m.apcbdocno
      AND apcald    = g_apcb_m.apcbld
      AND apcaent   = g_enterprise
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apcb_m.apcb004,g_apcb_m.apcb005,g_apcb_m.apcb002,g_apcb_m.apcb003,g_apcb_m.apcb008, 
          g_apcb_m.apcb009,g_apcb_m.apcb023,g_apcb_m.apcbdocno,g_apcb_m.apcbld,g_apcb_m.apcbseq,g_apcb_m.apcb010, 
          g_apcb_m.apcb011,g_apcb_m.apcblegl,g_apcb_m.apcb012,g_apcb_m.apcb014,g_apcb_m.apcb024,g_apcb_m.apcb021, 
          g_apcb_m.apcb015,g_apcb_m.apcb016,g_apcb_m.apcb017,g_apcb_m.apcb028 ATTRIBUTE(WITHOUT DEFAULTS) 
 
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb004
            #add-point:BEFORE FIELD apcb004 name="input.b.apcb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb004
            
            #add-point:AFTER FIELD apcb004 name="input.a.apcb004"
            IF NOT cl_null(g_apcb_m.apcb004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apcb_m.apcb004 != g_apcb_m_t.apcb004 OR g_apcb_m_t.apcb004 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apcb_m.apcb004
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imaa001") THEN
                     NEXT FIELD CURRENT
                  END IF
                  
                  #抓料件的進貨科目給科目
                  CALL s_get_item_acc(g_apcb_m.apcbld,'2',g_apcb_m.apcb004,'','','','')
                     RETURNING g_sub_success,g_apcb_m.apcb021
                  DISPLAY BY NAME g_apcb_m.apcb021
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb004
            #add-point:ON CHANGE apcb004 name="input.g.apcb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb005
            #add-point:BEFORE FIELD apcb005 name="input.b.apcb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb005
            
            #add-point:AFTER FIELD apcb005 name="input.a.apcb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb005
            #add-point:ON CHANGE apcb005 name="input.g.apcb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb002
            #add-point:BEFORE FIELD apcb002 name="input.b.apcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb002
            
            #add-point:AFTER FIELD apcb002 name="input.a.apcb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb002
            #add-point:ON CHANGE apcb002 name="input.g.apcb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb003
            #add-point:BEFORE FIELD apcb003 name="input.b.apcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb003
            
            #add-point:AFTER FIELD apcb003 name="input.a.apcb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb003
            #add-point:ON CHANGE apcb003 name="input.g.apcb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb008
            #add-point:BEFORE FIELD apcb008 name="input.b.apcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb008
            
            #add-point:AFTER FIELD apcb008 name="input.a.apcb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb008
            #add-point:ON CHANGE apcb008 name="input.g.apcb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb009
            #add-point:BEFORE FIELD apcb009 name="input.b.apcb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb009
            
            #add-point:AFTER FIELD apcb009 name="input.a.apcb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb009
            #add-point:ON CHANGE apcb009 name="input.g.apcb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb023
            #add-point:BEFORE FIELD apcb023 name="input.b.apcb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb023
            
            #add-point:AFTER FIELD apcb023 name="input.a.apcb023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb023
            #add-point:ON CHANGE apcb023 name="input.g.apcb023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbdocno
            #add-point:BEFORE FIELD apcbdocno name="input.b.apcbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbdocno
            
            #add-point:AFTER FIELD apcbdocno name="input.a.apcbdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apcb_m.apcbld) AND NOT cl_null(g_apcb_m.apcbdocno) AND NOT cl_null(g_apcb_m.apcbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apcb_m.apcbld != g_apcbld_t  OR g_apcb_m.apcbdocno != g_apcbdocno_t  OR g_apcb_m.apcbseq != g_apcbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcb_t WHERE "||"apcbent = '" ||g_enterprise|| "' AND "||"apcbld = '"||g_apcb_m.apcbld ||"' AND "|| "apcbdocno = '"||g_apcb_m.apcbdocno ||"' AND "|| "apcbseq = '"||g_apcb_m.apcbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbdocno
            #add-point:ON CHANGE apcbdocno name="input.g.apcbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbld
            #add-point:BEFORE FIELD apcbld name="input.b.apcbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbld
            
            #add-point:AFTER FIELD apcbld name="input.a.apcbld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apcb_m.apcbld) AND NOT cl_null(g_apcb_m.apcbdocno) AND NOT cl_null(g_apcb_m.apcbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apcb_m.apcbld != g_apcbld_t  OR g_apcb_m.apcbdocno != g_apcbdocno_t  OR g_apcb_m.apcbseq != g_apcbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcb_t WHERE "||"apcbent = '" ||g_enterprise|| "' AND "||"apcbld = '"||g_apcb_m.apcbld ||"' AND "|| "apcbdocno = '"||g_apcb_m.apcbdocno ||"' AND "|| "apcbseq = '"||g_apcb_m.apcbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbld
            #add-point:ON CHANGE apcbld name="input.g.apcbld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apcb_m.apcbseq,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD apcbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apcbseq name="input.a.apcbseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apcb_m.apcbld) AND NOT cl_null(g_apcb_m.apcbdocno) AND NOT cl_null(g_apcb_m.apcbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apcb_m.apcbld != g_apcbld_t  OR g_apcb_m.apcbdocno != g_apcbdocno_t  OR g_apcb_m.apcbseq != g_apcbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcb_t WHERE "||"apcbent = '" ||g_enterprise|| "' AND "||"apcbld = '"||g_apcb_m.apcbld ||"' AND "|| "apcbdocno = '"||g_apcb_m.apcbdocno ||"' AND "|| "apcbseq = '"||g_apcb_m.apcbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_apcb_m.apcbseq) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcbseq
            #add-point:BEFORE FIELD apcbseq name="input.b.apcbseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcbseq
            #add-point:ON CHANGE apcbseq name="input.g.apcbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb010
            
            #add-point:AFTER FIELD apcb010 name="input.a.apcb010"
            #業務部門
            LET g_apcb_m.apcb010_desc = ''
            IF NOT cl_null(g_apcb_m.apcb010) THEN
               IF (g_apcb_m.apcb010 != g_apcb_m_t.apcb010 OR g_apcb_m_t.apcb010 IS NULL ) THEN
                  CALL s_department_chk(g_apcb_m.apcb010,g_apcadocdt) RETURNING g_success
                  IF NOT g_success THEN
                     #CALL cl_err('',g_errno,1)
                     LET g_apcb_m.apcb010 = g_apcb_m_t.apcb010
                     CALL s_desc_get_department_desc(g_apcb_m.apcb010) RETURNING g_apcb_m.apcb010_desc
                     DISPLAY BY NAME g_apcb_m.apcb010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apcb_m.apcb010) RETURNING g_apcb_m.apcb010_desc
            DISPLAY BY NAME g_apcb_m.apcb010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb010
            #add-point:BEFORE FIELD apcb010 name="input.b.apcb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb010
            #add-point:ON CHANGE apcb010 name="input.g.apcb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb011
            
            #add-point:AFTER FIELD apcb011 name="input.a.apcb011"
            #責任中心
            LET g_apcb_m.apcb011_desc = ' '
            IF NOT cl_null(g_apcb_m.apcb011) THEN
               IF g_apcb_m.apcb011 != g_apcb_m_t.apcb011 OR g_apcb_m.apcb011 IS NULL THEN
                  CALL s_department_chk(g_apcb_m.apcb011,g_apcadocdt) RETURNING g_success
                  IF NOT g_success THEN
                     #CALL cl_err('',g_errno,1)
                     LET g_apcb_m.apcb011 = g_apcb_m_t.apcb011
                     CALL s_desc_get_department_desc(g_apcb_m.apcb011) RETURNING g_apcb_m.apcb011_desc
                     DISPLAY BY NAME g_apcb_m.apcb011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apcb_m.apcb011) RETURNING g_apcb_m.apcb011_desc
            DISPLAY BY NAME g_apcb_m.apcb011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb011
            #add-point:BEFORE FIELD apcb011 name="input.b.apcb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb011
            #add-point:ON CHANGE apcb011 name="input.g.apcb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcblegl
            
            #add-point:AFTER FIELD apcblegl name="input.a.apcblegl"
            #核算組織
            LET g_apcb_m.apcblegl_desc = ''
            IF NOT cl_null(g_apcb_m.apcblegl) THEN
               IF g_apcb_m.apcblegl != g_apcb_m_t.apcblegl OR g_apcb_m.apcblegl IS NULL THEN
                  CALL s_fin_account_legl_chk(g_apcb_m.apcblegl) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcb_m.apcblegl = g_apcb_m_t.apcblegl
                     CALL s_desc_get_department_desc(g_apcb_m.apcblegl) RETURNING g_apcb_m.apcblegl_desc
                     DISPLAY BY NAME g_apcb_m.apcblegl_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apcb_m.apcblegl) RETURNING g_apcb_m.apcblegl_desc
            DISPLAY BY NAME g_apcb_m.apcblegl_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcblegl
            #add-point:BEFORE FIELD apcblegl name="input.b.apcblegl"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcblegl
            #add-point:ON CHANGE apcblegl name="input.g.apcblegl"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb012
            
            #add-point:AFTER FIELD apcb012 name="input.a.apcb012"
            
            LET g_apcb_m.apcb012_desc = ' '
            IF NOT cl_null(g_apcb_m.apcb012) THEN
               IF g_apcb_m.apcb012 != g_apcb_m_t.apcb012 OR g_apcb_m_t.apcb012 IS NULL THEN
                  ##Belle產品類別
                  #IF NOT s_azzi650_chk_exist('3211',g_apcb_m.apcb012) THEN
                  #   LET g_apcb_m.apcb012  = g_apcb_m_t.apcb012
                  #   CALL s_desc_get_rtaxl003_desc(g_apcb_m.apcb012) RETURNING g_apcb_m.apcb012_desc
                  #   DISPLAY BY NAME g_apcb_m.apcb012_desc
                  #   NEXT FIELD CURRENT
                  #END IF
               END IF
            END IF   
            CALL s_desc_get_rtaxl003_desc(g_apcb_m.apcb012) RETURNING g_apcb_m.apcb012_desc
            DISPLAY BY NAME g_apcb_m.apcb012_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb012
            #add-point:BEFORE FIELD apcb012 name="input.b.apcb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb012
            #add-point:ON CHANGE apcb012 name="input.g.apcb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb014
            
            #add-point:AFTER FIELD apcb014 name="input.a.apcb014"
            #理由碼
            LET g_apcb_m.apcb014_desc = ' '
            IF NOT cl_null(g_apcb_m.apcb014) THEN
               IF g_apcb_m.apcb014 != g_apcb_m_t.apcb014 OR g_apcb_m_t.apcb014 IS NULL THEN
                  IF NOT s_azzi650_chk_exist('3211',g_apcb_m.apcb014) THEN
                     LET g_apcb_m.apcb014  = g_apcb_m_t.apcb014
                     CALL s_desc_get_acc_desc('3212',g_apcb_m.apcb014) RETURNING g_apcb_m.apcb014_desc
                     DISPLAY BY NAME g_apcb_m.apcb014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            CALL s_desc_get_acc_desc('3212',g_apcb_m.apcb014) RETURNING g_apcb_m.apcb014_desc
            DISPLAY BY NAME g_apcb_m.apcb014_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb014
            #add-point:BEFORE FIELD apcb014 name="input.b.apcb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb014
            #add-point:ON CHANGE apcb014 name="input.g.apcb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb024
            
            #add-point:AFTER FIELD apcb024 name="input.a.apcb024"
            #區域
            LET g_apcb_m.apcb024_desc = ''
            IF NOT cl_null(g_apcb_m.apcb024) THEN
               IF g_apcb_m.apcb024 != g_apcb_m_t.apcb024 OR g_apcb_m_t.apcb024 IS NULL THEN
                  IF NOT s_azzi650_chk_exist('2082',g_apcb_m.apcb024) THEN
                     LET g_apcb_m.apcb024  = g_apcb_m_t.apcb024
                     CALL s_desc_get_acc_desc('2082',g_apcb_m.apcb024) RETURNING g_apcb_m.apcb024_desc
                     DISPLAY BY NAME g_apcb_m.apcb024_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            CALL s_desc_get_acc_desc('2082',g_apcb_m.apcb024) RETURNING g_apcb_m.apcb024_desc
            DISPLAY BY NAME g_apcb_m.apcb024_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb024
            #add-point:BEFORE FIELD apcb024 name="input.b.apcb024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb024
            #add-point:ON CHANGE apcb024 name="input.g.apcb024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb021
            
            #add-point:AFTER FIELD apcb021 name="input.a.apcb021"
            #費用會計科目
            LET g_apcb_m.apcb021_desc = ''
            IF NOT cl_null(g_apcb_m.apcb021) THEN
               IF g_apcb_m.apcb021 != g_apcb_m_t.apcb021 OR g_apcb_m.apcb021 IS NULL THEN
                  CALL s_aap_glac002_chk(g_apcb_m.apcb021,g_apcb_m.apcbld) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcb_m.apcb021 = g_apcb_m_t.apcb021
                     CALL s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021) RETURNING g_apcb_m.apcb021_desc
                     DISPLAY BY NAME g_apcb_m.apcb021_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021)  RETURNING g_apcb_m.apcb021_desc
            DISPLAY BY NAME g_apcb_m.apcb021_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb021
            #add-point:BEFORE FIELD apcb021 name="input.b.apcb021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb021
            #add-point:ON CHANGE apcb021 name="input.g.apcb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb015
            
            #add-point:AFTER FIELD apcb015 name="input.a.apcb015"
            #專案編號
            LET g_apcb_m.apcb015_desc = ' '
            IF NOT cl_null(g_apcb_m.apcb015) THEN
               IF g_apcb_m.apcb015 != g_apcb_m_t.apcb015 OR g_apcb_m_t.apcb015 IS NULL THEN
                  CALL s_aap_project_chk(g_apcb_m.apcb015) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcb_m.apcb015 = g_apcb_m_t.apcb015
                     CALL s_desc_get_project_desc(g_apcb_m.apcb015) RETURNING　g_apcb_m.apcb015_desc
                     DISPLAY BY NAME g_apcb_m.apcb015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            CALL s_desc_get_project_desc(g_apcb_m.apcb015) RETURNING　g_apcb_m.apcb015_desc
            DISPLAY BY NAME g_apcb_m.apcb015_desc  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb015
            #add-point:BEFORE FIELD apcb015 name="input.b.apcb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb015
            #add-point:ON CHANGE apcb015 name="input.g.apcb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb016
            #add-point:BEFORE FIELD apcb016 name="input.b.apcb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb016
            
            #add-point:AFTER FIELD apcb016 name="input.a.apcb016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb016
            #add-point:ON CHANGE apcb016 name="input.g.apcb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb017
            
            #add-point:AFTER FIELD apcb017 name="input.a.apcb017"
            #預算項目
            LET g_apcb_m.apcb017_desc = ''
            IF NOT cl_null(g_apcb_m.apcb017) THEN
               IF g_apcb_m.apcb017 != g_apcb_m_t.apcb017 OR g_apcb_m_t.apcb017 IS NULL THEN
                  CALL s_fin_budget_chk(g_apcb_m.apcb017) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apcb_m.apcb017 = g_apcb_m_t.apcb017
                     CALL s_desc_get_budget_desc(g_apcb_m.apcb017) RETURNING g_apcb_m.apcb017_desc
                     DISPLAY BY NAME g_apcb_m.apcb017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_budget_desc(g_apcb_m.apcb017) RETURNING g_apcb_m.apcb017_desc
            DISPLAY BY NAME g_apcb_m.apcb017_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb017
            #add-point:BEFORE FIELD apcb017 name="input.b.apcb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb017
            #add-point:ON CHANGE apcb017 name="input.g.apcb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb028
            #add-point:BEFORE FIELD apcb028 name="input.b.apcb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb028
            
            #add-point:AFTER FIELD apcb028 name="input.a.apcb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb028
            #add-point:ON CHANGE apcb028 name="input.g.apcb028"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apcb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb004
            #add-point:ON ACTION controlp INFIELD apcb004 name="input.c.apcb004"
            #產品編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb004       #給予default值
            CALL q_imaa001_14()                              #呼叫開窗
            LET g_apcb_m.apcb004 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_apcb_m.apcb004 TO apcb004              #顯示到畫面上
            NEXT FIELD apcb004                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb005
            #add-point:ON ACTION controlp INFIELD apcb005 name="input.c.apcb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb002
            #add-point:ON ACTION controlp INFIELD apcb002 name="input.c.apcb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb003
            #add-point:ON ACTION controlp INFIELD apcb003 name="input.c.apcb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb008
            #add-point:ON ACTION controlp INFIELD apcb008 name="input.c.apcb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb009
            #add-point:ON ACTION controlp INFIELD apcb009 name="input.c.apcb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb023
            #add-point:ON ACTION controlp INFIELD apcb023 name="input.c.apcb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbdocno
            #add-point:ON ACTION controlp INFIELD apcbdocno name="input.c.apcbdocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbld
            #add-point:ON ACTION controlp INFIELD apcbld name="input.c.apcbld"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcbseq
            #add-point:ON ACTION controlp INFIELD apcbseq name="input.c.apcbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb010
            #add-point:ON ACTION controlp INFIELD apcb010 name="input.c.apcb010"
            #業務部門
 		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb010        #給予default值
            #給予arg
            SELECT apcadocdt INTO l_apcadocdt FROM apca_t
             WHERE apcaent  = g_enterprise
               AND apcadocno= g_apcb_m.apcbdocno
               AND apcald   = g_apcb_m.apcbld
            LET g_qryparam.arg1 = l_apcadocdt
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_apcb_m.apcb010 = g_qryparam.return1         #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apcb_m.apcb010) RETURNING g_apcb_m.apcb010_desc
            DISPLAY BY NAME g_apcb_m.apcb010,g_apcb_m.apcb010_desc       
            NEXT FIELD apcb010                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb011
            #add-point:ON ACTION controlp INFIELD apcb011 name="input.c.apcb011"
			#責任中心
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb011        #給予default值
            CALL q_ooeg001_2()                                #呼叫開窗
            LET g_apcb_m.apcb011 = g_qryparam.return1         #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apcb_m.apcb011) RETURNING g_apcb_m.apcb011_desc
            DISPLAY BY NAME g_apcb_m.apcb011,g_apcb_m.apcb011_desc            
            NEXT FIELD apcb011 
            #END add-point
 
 
         #Ctrlp:input.c.apcblegl
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcblegl
            #add-point:ON ACTION controlp INFIELD apcblegl name="input.c.apcblegl"
            #核算組織            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcblegl       #給予default值
            CALL q_ooef001()                                  #呼叫開窗
            LET g_apcb_m.apcblegl = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apcb_m.apcblegl) RETURNING g_apcb_m.apcblegl_desc 
            DISPLAY BY NAME g_apcb_m.apcblegl,g_apcb_m.apcblegl_desc            
            NEXT FIELD apcblegl                               #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apcb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb012
            #add-point:ON ACTION controlp INFIELD apcb012 name="input.c.apcb012"
		    #產品類別
		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb012         #給予default值
            CALL q_rtax001()                                   #呼叫開窗
            LET g_apcb_m.apcb012 = g_qryparam.return1          #將開窗取得的值回傳到變數
            CALL s_desc_get_rtaxl003_desc(g_apcb_m.apcb012) RETURNING g_apcb_m.apcb012_desc
            DISPLAY BY NAME g_apcb_m.apcb012,g_apcb_m.apcb012_desc       
            NEXT FIELD apcb012                                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb014
            #add-point:ON ACTION controlp INFIELD apcb014 name="input.c.apcb014"
            #理由碼            
            #開窗i段
		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb014      #給予default值
            LET g_qryparam.arg1 = "3212" 
            CALL q_oocq002()                                #呼叫開窗
            LET g_apcb_m.apcb014 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_acc_desc('3212',g_apcb_m.apcb014) RETURNING g_apcb_m.apcb014_desc
            DISPLAY BY NAME g_apcb_m.apcb014,g_apcb_m.apcb014_desc
            NEXT FIELD apcb014  
            #END add-point
 
 
         #Ctrlp:input.c.apcb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb024
            #add-point:ON ACTION controlp INFIELD apcb024 name="input.c.apcb024"
            #區域
            #開窗i段
		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb024      #給予default值
            LET g_qryparam.arg1 = "2082" 
            CALL q_oocq002()                                #呼叫開窗
            LET g_apcb_m.apcb024 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_acc_desc('2082',g_apcb_m.apcb024) RETURNING g_apcb_m.apcb024_desc
            DISPLAY BY NAME g_apcb_m.apcb024,g_apcb_m.apcb024_desc
            NEXT FIELD apcb024  
            #END add-point
 
 
         #Ctrlp:input.c.apcb021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb021
            #add-point:ON ACTION controlp INFIELD apcb021 name="input.c.apcb021"
            #費用會計科目            
		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb021       #給予default值
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科目類型)
            CALL aglt310_04()                                #呼叫開窗
            LET g_apcb_m.apcb021 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021) RETURNING g_apcb_m.apcb021_desc
            DISPLAY BY NAME g_apcb_m.apcb021,g_apcb_m.apcb021_desc
            NEXT FIELD apcb021                                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb015
            #add-point:ON ACTION controlp INFIELD apcb015 name="input.c.apcb015"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb015         #給予default值
            CALL q_pjba001()                                   #呼叫開窗
            LET g_apcb_m.apcb015 = g_qryparam.return1          #將開窗取得的值回傳到變數
            CALL s_desc_get_project_desc(g_apcb_m.apcb015) RETURNING g_apcb_m.apcb015_desc
            DISPLAY BY NAME g_apcb_m.apcb015,g_apcb_m.apcb015_desc
            NEXT FIELD apcb015        　　　　                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb016
            #add-point:ON ACTION controlp INFIELD apcb016 name="input.c.apcb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb017
            #add-point:ON ACTION controlp INFIELD apcb017 name="input.c.apcb017"
            #預算編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apcb_m.apcb017      #給予default值
            CALL q_bgaa001()                                #呼叫開窗
            LET g_apcb_m.apcb017 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_budget_desc(g_apcb_m.apcb017) RETURNING g_apcb_m.apcb017_desc
            DISPLAY BY NAME g_apcb_m.apcb017,g_apcb_m.apcb017_desc
            #END add-point
 
 
         #Ctrlp:input.c.apcb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb028
            #add-point:ON ACTION controlp INFIELD apcb028 name="input.c.apcb028"
		    #發票號碼
		    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1  = g_apcb_m.apcbdocno
            LET g_qryparam.default1 = g_apcb_m.apcb028        #給予default值
            LET g_qryparam.where = " isam001 = 'aapt300' "
            CALL q_isam010_2()                                #呼叫開窗
            LET g_apcb_m.apcb028 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_apcb_m.apcb028 TO apcb028               #顯示到畫面上
            NEXT FIELD apcb028                                #返回原欄位
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
   CLOSE WINDOW w_aapt300_12 
   
   #add-point:input段after input name="input.post_input"
   CALL aapt300_12_move_to_array()
   RETURN p_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_12.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt300_12.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 把傳入的ARRAY值分配到g_apcb_m中
# Memo...........:
# Usage..........: CALL aapt300_12_move_to_g_apcb()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/03/17 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_12_move_to_g_apcb()
   LET g_apcb_m.apcbdocno = g_array[1].chr 
   LET g_apcb_m.apcbld    = g_array[2].chr
   LET g_apcb_m.apcb004   = g_array[3].chr  
   LET g_apcb_m.apcb005   = g_array[4].chr  
   LET g_apcb_m.apcb002   = g_array[5].chr  
   LET g_apcb_m.apcb003   = g_array[6].chr  
   LET g_apcb_m.apcb008   = g_array[7].chr  
   LET g_apcb_m.apcb009   = g_array[8].chr  
   LET g_apcb_m.apcb023   = g_array[9].chr  
   LET g_apcb_m.apcb010   = g_array[10].chr
   LET g_apcb_m.apcb011   = g_array[11].chr
   LET g_apcb_m.apcblegl  = g_array[12].chr
   LET g_apcb_m.apcb012   = g_array[13].chr
   LET g_apcb_m.apcb014   = g_array[14].chr
   LET g_apcb_m.apcb028   = g_array[15].chr
   LET g_apcb_m.apcb021   = g_array[16].chr
   LET g_apcb_m.apcb015   = g_array[17].chr
   LET g_apcb_m.apcb016   = g_array[18].chr
   LET g_apcb_m.apcb017   = g_array[19].chr
   LET g_apcb_m.apcb024   = g_array[20].chr
   
   CALL s_ld_sel_glaa(g_apcb_m.apcbld,'glaa004') RETURNING  g_success,g_glaa004
   SELECT apcadocdt INTO g_apcadocdt
     FROM apca_t
    WHERE apcaent = g_enterprise AND apcald = g_apcb_m.apcbld
      AND apcadocno = g_apcb_m.apcbdocno
   LET g_apcb_m.apcblegl_desc= s_desc_get_department_desc(g_apcb_m.apcblegl)    #核算組織
   LET g_apcb_m.apcb010_desc = s_desc_get_department_desc(g_apcb_m.apcb010)      #業務部門
   LET g_apcb_m.apcb011_desc = s_desc_get_department_desc(g_apcb_m.apcb011)      #責任中心
   LET g_apcb_m.apcb012_desc = s_desc_get_rtaxl003_desc(g_apcb_m.apcb012)        #產品類別
   LET g_apcb_m.apcb014_desc = s_desc_get_acc_desc('3212',g_apcb_m.apcb014)      #理由碼
   LET g_apcb_m.apcb015_desc = s_desc_get_project_desc(g_apcb_m.apcb015)         #專案代碼
   LET g_apcb_m.apcb017_desc = s_desc_get_budget_desc(g_apcb_m.apcb017)          #預算項目
   LET g_apcb_m.apcb021_desc = s_desc_get_account_desc(g_apcb_m.apcbld,g_apcb_m.apcb021)   #會計科目 
   LET g_apcb_m.apcb024_desc = s_desc_get_acc_desc('2082',g_apcb_m.apcb024)      #區域
   LET g_apcb_m_t.* = g_apcb_m.*
   DISPLAY BY NAME g_apcb_m.apcblegl_desc,g_apcb_m.apcb010_desc,g_apcb_m.apcb011_desc,g_apcb_m.apcb012_desc,
                   g_apcb_m.apcb014_desc, g_apcb_m.apcb015_desc,g_apcb_m.apcb017_desc,g_apcb_m.apcb021_desc,
                   g_apcb_m.apcb024_desc

END FUNCTION
################################################################################
# Descriptions...: 把g_apca_m的東西移到要傳出的array中
# Memo...........:
# Usage..........: CALL aapt300_12_move_to_array()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/03/17 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_12_move_to_array()
   LET g_array[1].chr  = g_apcb_m.apcbdocno 
   LET g_array[2].chr  = g_apcb_m.apcbld    
   LET g_array[3].chr  = g_apcb_m.apcb004    
   LET g_array[4].chr  = g_apcb_m.apcb005    
   LET g_array[5].chr  = g_apcb_m.apcb002    
   LET g_array[6].chr  = g_apcb_m.apcb003    
   LET g_array[7].chr  = g_apcb_m.apcb008    
   LET g_array[8].chr  = g_apcb_m.apcb009    
   LET g_array[9].chr  = g_apcb_m.apcb023    
   LET g_array[10].chr = g_apcb_m.apcb010   
   LET g_array[11].chr = g_apcb_m.apcb011   
   LET g_array[12].chr = g_apcb_m.apcblegl  
   LET g_array[13].chr = g_apcb_m.apcb012   
   LET g_array[14].chr = g_apcb_m.apcb014   
   LET g_array[15].chr = g_apcb_m.apcb028   
   LET g_array[16].chr = g_apcb_m.apcb021   
   LET g_array[17].chr = g_apcb_m.apcb015   
   LET g_array[18].chr = g_apcb_m.apcb016   
   LET g_array[19].chr = g_apcb_m.apcb017   
   LET g_array[20].chr = g_apcb_m.apcb024   
END FUNCTION

 
{</section>}
 

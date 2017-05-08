#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt460_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-09-28 14:07:54), PR版次:0003(2016-12-05 13:16:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: axrt460_01
#+ Description: 差異處理
#+ Creator....: 02599(2014-09-24 16:02:30)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="axrt460_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161128-00061#5   2016/12/05  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xrfb_d        RECORD
       xrfbdocno LIKE xrfb_t.xrfbdocno, 
   xrfbseq LIKE xrfb_t.xrfbseq, 
   xrfb001 LIKE xrfb_t.xrfb001, 
   xrfb001_desc LIKE type_t.chr500, 
   xrfbld LIKE xrfb_t.xrfbld, 
   xrfb100 LIKE xrfb_t.xrfb100, 
   curr LIKE type_t.chr500, 
   xrfb103 LIKE xrfb_t.xrfb103, 
   xrfb101 LIKE xrfb_t.xrfb101, 
   xrfb104 LIKE xrfb_t.xrfb104
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD
       chk_esc        LIKE type_t.chr1,
       flag1          LIKE type_t.chr2,
       flag2          LIKE type_t.chr2
       END RECORD
DEFINE g_xrfacomp     LIKE xrfa_t.xrfacomp
DEFINE g_xrfald       LIKE xrfa_t.xrfald
DEFINE g_xrfadocdt    LIKE xrfa_t.xrfadocdt
DEFINE g_xrfa002       LIKE xrfa_t.xrfa002
DEFINE g_glaa001      LIKE glaa_t.glaa001
DEFINE g_glaa025      LIKE glaa_t.glaa025
#end add-point
 
DEFINE g_xrfb_d          DYNAMIC ARRAY OF type_g_xrfb_d
DEFINE g_xrfb_d_t        type_g_xrfb_d
 
 
DEFINE g_xrfbdocno_t   LIKE xrfb_t.xrfbdocno    #Key值備份
DEFINE g_xrfbseq_t      LIKE xrfb_t.xrfbseq    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="axrt460_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt460_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xrfadocno,p_flag,p_amt
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_xrfadocno     LIKE xrfa_t.xrfadocno
   DEFINE p_flag          LIKE type_t.chr1
   DEFINE p_amt           LIKE xrfb_t.xrfb103
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sum           LIKE xrfb_t.xrfb104
   DEFINE l_xrfb001       LIKE xrfb_t.xrfb001
   DEFINE l_xrfbld        LIKE xrfb_t.xrfbld
   DEFINE l_max_seq       LIKE xrfb_t.xrfbseq
   DEFINE l_rate1         LIKE xrfb_t.xrfb201
   DEFINE l_rate2         LIKE xrfb_t.xrfb201
   DEFINE ls_js           STRING
   DEFINE lc_param        RECORD
            type          LIKE type_t.chr1,
            apca004       LIKE apca_t.apca004
                      END RECORD
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt460_01 WITH FORM cl_ap_formpath("axr","axrt460_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc_part('flag1','8306','12,91')
   CALL cl_set_combo_scc_part('flag2','8306','11,13,14,15,92')
   LET g_input.chk_esc='N'
   IF p_flag='1' THEN
      CALL cl_set_comp_entry('flag1',TRUE)
      CALL cl_set_comp_entry('flag2',FALSE)
      LET g_input.flag1='12'
   ELSE
      CALL cl_set_comp_entry('flag1',FALSE)
      CALL cl_set_comp_entry('flag2',TRUE)
      LET g_input.flag2='11'
   END IF
   DISPLAY BY NAME g_input.chk_esc,g_input.flag1,g_input.flag2
   #單頭法人、帳別
   SELECT xrfacomp,xrfald,xrfadocdt,xrfa002 
   INTO g_xrfacomp,g_xrfald,g_xrfadocdt,g_xrfa002
   FROM xrfa_t
   WHERE xrfaent=g_enterprise AND xrfadocno=p_xrfadocno
   #帳別對用幣別
   SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t
   WHERE glaaent=g_enterprise AND glaald=g_xrfald
   
   CALL g_xrfb_d.clear()
   LET l_ac=0
   LET l_max_seq=0 #記錄最大項次
   SELECT MAX(xrfbseq) INTO l_max_seq
     FROM xrfb_t
    WHERE xrfbent = g_enterprise 
      AND xrfbdocno = p_xrfadocno
   IF cl_null(l_max_seq) THEN 
      LET l_max_seq = 1
   ELSE
      LET l_max_seq = l_max_seq +1               
   END IF
#   #判斷是否存在與單頭相同的法人，如果存在插入第一筆
#   SELECT DISTINCT xrfc001,xrfc002 
#     INTO l_xrfb001,l_xrfbld 
#     FROM xrfc_t
#    WHERE xrfcent=g_enterprise AND xrfcdocno=p_xrfadocno AND xrfc001=g_xrfacomp
#   IF NOT cl_null(l_xrfb001) AND NOT cl_null(l_xrfbld) THEN
   #預設第一筆帶單頭法人組織,單頭法人帳套,幣別,差異處理金額,匯率,本幣處理金額
   LET l_ac=1
   LET g_xrfb_d[l_ac].xrfb001=g_xrfacomp
   LET g_xrfb_d[l_ac].xrfbld=g_xrfald
   #幣別
   SELECT glaa001 INTO g_xrfb_d[l_ac].xrfb100
     FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald=g_xrfb_d[l_ac].xrfbld
   LET g_xrfb_d[l_ac].curr=g_glaa001
   #匯率
#   CALL s_aooi160_get_exrate('2',g_xrfald,g_xrfadocdt,g_xrfb_d[l_ac].xrfb100,g_glaa001,0,g_glaa025)
#   RETURNING g_xrfb_d[l_ac].xrfb101
   LET lc_param.type    = '1'
   LET lc_param.apca004 = g_xrfa002
   LET ls_js = util.JSON.stringify(lc_param)
   CALL s_fin_get_curr_rate(g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
   RETURNING g_xrfb_d[l_ac].xrfb101,l_rate1,l_rate2
   #金額
   LET g_xrfb_d[l_ac].xrfb104=p_amt
   LET g_xrfb_d[l_ac].xrfb103=g_xrfb_d[l_ac].xrfb104/g_xrfb_d[l_ac].xrfb101
   CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb103,2) 
       RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb103
   #單號
   LET g_xrfb_d[l_ac].xrfbdocno=p_xrfadocno
   #項次
   IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN
      LET g_xrfb_d[l_ac].xrfbseq=l_max_seq
      LET l_max_seq=l_max_seq+1
   END IF
   LET g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_ac].xrfb001
   CALL axrt460_01_xrfb001_desc()
   DISPLAY BY NAME g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfb001_desc,g_xrfb_d[l_ac].xrfbld,
                   g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfb101,g_xrfb_d[l_ac].xrfb103,
                   g_xrfb_d[l_ac].xrfb104
#   END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xrfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            DISPLAY l_ac TO FORMONLY.idx
#            #項次
#            IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN
#               LET g_xrfb_d[l_ac].xrfbseq=l_max_seq
#               LET l_max_seq=l_max_seq+1
#            END IF
#            #單頭帳套幣別
#            LET g_xrfb_d[l_ac].curr=g_glaa001
#            #單號
#            LET g_xrfb_d[l_ac].xrfbdocno=p_xrfadocno
#            DISPLAY BY NAME g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfbdocno
         
         BEFORE INSERT
            
         BEFORE DELETE
            IF g_xrfb_d[l_ac].xrfbseq=l_max_seq -1 THEN
               LET l_max_seq=l_max_seq-1
            END IF
            CALL g_xrfb_d.deleteElement(l_ac) 
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbdocno
            #add-point:BEFORE FIELD xrfbdocno name="input.b.page1.xrfbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbdocno
            
            #add-point:AFTER FIELD xrfbdocno name="input.a.page1.xrfbdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrfb_d[g_detail_idx].xrfbdocno IS NOT NULL AND g_xrfb_d[g_detail_idx].xrfbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrfb_d[g_detail_idx].xrfbdocno != g_xrfb_d_t.xrfbdocno OR g_xrfb_d[g_detail_idx].xrfbseq != g_xrfb_d_t.xrfbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrfb_t WHERE "||"xrfbent = '" ||g_enterprise|| "' AND "||"xrfbdocno = '"||g_xrfb_d[g_detail_idx].xrfbdocno ||"' AND "|| "xrfbseq = '"||g_xrfb_d[g_detail_idx].xrfbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfbdocno
            #add-point:ON CHANGE xrfbdocno name="input.g.page1.xrfbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbseq
            #add-point:BEFORE FIELD xrfbseq name="input.b.page1.xrfbseq"
            IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN
               LET g_xrfb_d[l_ac].xrfbseq=l_max_seq
               LET l_max_seq=l_max_seq+1
               #單頭帳套幣別
               LET g_xrfb_d[l_ac].curr=g_glaa001
               #單號
               LET g_xrfb_d[l_ac].xrfbdocno=p_xrfadocno
               DISPLAY BY NAME g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfbdocno
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbseq
            
            #add-point:AFTER FIELD xrfbseq name="input.a.page1.xrfbseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrfb_d[g_detail_idx].xrfbdocno IS NOT NULL AND g_xrfb_d[g_detail_idx].xrfbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrfb_d[g_detail_idx].xrfbdocno != g_xrfb_d_t.xrfbdocno OR g_xrfb_d[g_detail_idx].xrfbseq != g_xrfb_d_t.xrfbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrfb_t WHERE "||"xrfbent = '" ||g_enterprise|| "' AND "||"xrfbdocno = '"||g_xrfb_d[g_detail_idx].xrfbdocno ||"' AND "|| "xrfbseq = '"||g_xrfb_d[g_detail_idx].xrfbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfbseq
            #add-point:ON CHANGE xrfbseq name="input.g.page1.xrfbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001
            #add-point:BEFORE FIELD xrfb001 name="input.b.page1.xrfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001
            
            #add-point:AFTER FIELD xrfb001 name="input.a.page1.xrfb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb001
            #add-point:ON CHANGE xrfb001 name="input.g.page1.xrfb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001_desc
            #add-point:BEFORE FIELD xrfb001_desc name="input.b.page1.xrfb001_desc"
            LET g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_ac].xrfb001
            IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN
               LET g_xrfb_d[l_ac].xrfbseq=l_max_seq
               LET l_max_seq=l_max_seq+1
               #單頭帳套幣別
               LET g_xrfb_d[l_ac].curr=g_glaa001
               #單號
               LET g_xrfb_d[l_ac].xrfbdocno=p_xrfadocno
               DISPLAY BY NAME g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfbdocno
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001_desc
            
            #add-point:AFTER FIELD xrfb001_desc name="input.a.page1.xrfb001_desc"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb001_desc) THEN
               SELECT COUNT(*) INTO l_cnt FROM xrfc_t
               WHERE xrfcent=g_enterprise AND xrfcdocno=p_xrfadocno AND xrfc001=g_xrfb_d[l_ac].xrfb001_desc
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrfb_d[l_ac].xrfb001_desc
                  LET g_errparam.code   = 'axr-00202'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                  NEXT FIELD CURRENT
               END IF
               LET l_cnt=g_xrfb_d.getLength()
               FOR l_i=1 TO l_cnt
                   IF l_ac <> l_i AND g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_i].xrfb001 THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xrfb_d[l_ac].xrfb001_desc
                      LET g_errparam.code   = 'axr-00203'
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                      NEXT FIELD CURRENT
                      EXIT FOR
                   END IF
               END FOR
               LET l_i=1
               IF g_xrfb_d.getLength() > l_cnt THEN 
                  CALL g_xrfb_d.deleteElement(g_xrfb_d.getLength()) 
               END IF
               #帳套
               SELECT DISTINCT xrfc002 INTO g_xrfb_d[l_ac].xrfbld FROM xrfc_t
               WHERE xrfcent=g_enterprise AND xrfcdocno=p_xrfadocno AND xrfc001=g_xrfb_d[l_ac].xrfb001_desc
               #匯率
               SELECT glaa001 INTO g_xrfb_d[l_ac].xrfb100
                 FROM glaa_t
                WHERE glaaent=g_enterprise AND glaald=g_xrfb_d[l_ac].xrfbld
               
#               CALL s_aooi160_get_exrate('2',g_xrfald,g_xrfadocdt,g_xrfb_d[l_ac].xrfb100,g_glaa001,0,g_glaa025)
#               RETURNING g_xrfb_d[l_ac].xrfb101
               LET lc_param.type    = '1'
               LET lc_param.apca004 = g_xrfa002
               LET ls_js = util.JSON.stringify(lc_param)
               CALL s_fin_get_curr_rate(g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
               RETURNING g_xrfb_d[l_ac].xrfb101,l_rate1,l_rate2
               IF NOT cl_null(g_xrfb_d[l_ac].xrfb103) THEN
                  LET g_xrfb_d[l_ac].xrfb104=g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb101
                  CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfb104,2) 
                      RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb104
               ELSE
                  LET l_sum=0
                  LET l_cnt=g_xrfb_d.getLength()
                  FOR l_i=1 TO l_cnt
                     IF l_ac <> l_i THEN
                        IF cl_null(g_xrfb_d[l_i].xrfb104) THEN LET g_xrfb_d[l_i].xrfb104=0 END IF
                        LET l_sum=l_sum + g_xrfb_d[l_i].xrfb104
                     END IF
                  END FOR
                  LET l_i= 1
                  IF g_xrfb_d.getLength() > l_cnt THEN 
                     CALL g_xrfb_d.deleteElement(g_xrfb_d.getLength()) 
                  END IF
                  #可分配金額=總差異金額 - 已分配金額
                  LET g_xrfb_d[l_ac].xrfb104=p_amt - l_sum
                  LET g_xrfb_d[l_ac].xrfb103=g_xrfb_d[l_ac].xrfb104 / g_xrfb_d[l_ac].xrfb101
                  CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb103,2) 
                      RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb103
               END IF
               DISPLAY BY NAME g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb101,
                               g_xrfb_d[l_ac].xrfb103,g_xrfb_d[l_ac].xrfb104
            END IF
            LET g_xrfb_d[l_ac].xrfb001=g_xrfb_d[l_ac].xrfb001_desc
            CALL axrt460_01_xrfb001_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb001_desc
            #add-point:ON CHANGE xrfb001_desc name="input.g.page1.xrfb001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbld
            #add-point:BEFORE FIELD xrfbld name="input.b.page1.xrfbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbld
            
            #add-point:AFTER FIELD xrfbld name="input.a.page1.xrfbld"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfbld
            #add-point:ON CHANGE xrfbld name="input.g.page1.xrfbld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb100
            #add-point:BEFORE FIELD xrfb100 name="input.b.page1.xrfb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb100
            
            #add-point:AFTER FIELD xrfb100 name="input.a.page1.xrfb100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb100
            #add-point:ON CHANGE xrfb100 name="input.g.page1.xrfb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD curr
            #add-point:BEFORE FIELD curr name="input.b.page1.curr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD curr
            
            #add-point:AFTER FIELD curr name="input.a.page1.curr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE curr
            #add-point:ON CHANGE curr name="input.g.page1.curr"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb103
            #add-point:BEFORE FIELD xrfb103 name="input.b.page1.xrfb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb103
            
            #add-point:AFTER FIELD xrfb103 name="input.a.page1.xrfb103"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb103) THEN
               LET g_xrfb_d[l_ac].xrfb104=g_xrfb_d[l_ac].xrfb103*g_xrfb_d[l_ac].xrfb101
               CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].curr,g_xrfb_d[l_ac].xrfb104,2) 
                      RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb104
               DISPLAY BY NAME g_xrfb_d[l_ac].xrfb104
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb103
            #add-point:ON CHANGE xrfb103 name="input.g.page1.xrfb103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb101
            #add-point:BEFORE FIELD xrfb101 name="input.b.page1.xrfb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb101
            
            #add-point:AFTER FIELD xrfb101 name="input.a.page1.xrfb101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb101
            #add-point:ON CHANGE xrfb101 name="input.g.page1.xrfb101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb104
            #add-point:BEFORE FIELD xrfb104 name="input.b.page1.xrfb104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb104
            
            #add-point:AFTER FIELD xrfb104 name="input.a.page1.xrfb104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb104
            #add-point:ON CHANGE xrfb104 name="input.g.page1.xrfb104"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrfbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbdocno
            #add-point:ON ACTION controlp INFIELD xrfbdocno name="input.c.page1.xrfbdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbseq
            #add-point:ON ACTION controlp INFIELD xrfbseq name="input.c.page1.xrfbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001
            #add-point:ON ACTION controlp INFIELD xrfb001 name="input.c.page1.xrfb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb001             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb001 = g_qryparam.return1              
            #LET g_xrfb_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_xrfb_d[l_ac].xrfb001 TO xrfb001              #
            #DISPLAY g_xrfb_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xrfb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001_desc
            #add-point:ON ACTION controlp INFIELD xrfb001_desc name="input.c.page1.xrfb001_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb001             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
             LET g_qryparam.where = " ooef003='Y' AND ooef017 IN (SELECT DISTINCT xrfc001 FROM xrfc_t ",
                                    " WHERE xrfcent=",g_enterprise," AND xrfcdocno='",p_xrfadocno,"' ",
                                    " )"
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb001_desc = g_qryparam.return1              
            #LET g_xrfb_d[l_ac].ooefl003 = g_qryparam.return2 
            LET g_xrfb_d[l_ac].xrfb001 = g_xrfb_d[l_ac].xrfb001_desc
            CALL axrt460_01_xrfb001_desc()
            DISPLAY g_xrfb_d[l_ac].xrfb001_desc TO xrfb001_desc              #
            #DISPLAY g_xrfb_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xrfb001_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbld
            #add-point:ON ACTION controlp INFIELD xrfbld name="input.c.page1.xrfbld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb100
            #add-point:ON ACTION controlp INFIELD xrfb100 name="input.c.page1.xrfb100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb100 = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].xrfb100 TO xrfb100              #

            NEXT FIELD xrfb100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.curr
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD curr
            #add-point:ON ACTION controlp INFIELD curr name="input.c.page1.curr"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].curr             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_xrfb_d[l_ac].curr = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].curr TO curr              #

            NEXT FIELD curr                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb103
            #add-point:ON ACTION controlp INFIELD xrfb103 name="input.c.page1.xrfb103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb101
            #add-point:ON ACTION controlp INFIELD xrfb101 name="input.c.page1.xrfb101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb104
            #add-point:ON ACTION controlp INFIELD xrfb104 name="input.c.page1.xrfb104"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         AFTER ROW
#            IF cl_null(g_xrfb_d[l_ac].xrfb001_desc) THEN
#               NEXT FIELD xrfb001_desc
#            END IF
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            LET l_sum = 0
            LET l_cnt=g_xrfb_d.getLength()
            FOR l_i=1 TO l_cnt
               IF cl_null(g_xrfb_d[l_i].xrfb104) THEN LET g_xrfb_d[l_i].xrfb104=0 END IF
               LET l_sum = l_sum + g_xrfb_d[l_i].xrfb104
            END FOR
            LET l_i=1
            IF g_xrfb_d.getLength() > l_cnt THEN 
               CALL g_xrfb_d.deleteElement(g_xrfb_d.getLength()) 
            END IF
            IF l_sum <> p_amt THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrfb_d[l_ac].xrfb001_desc
               LET g_errparam.code   = 'axr-00204'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD xrfb103
            END IF
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      INPUT BY NAME g_input.chk_esc,g_input.flag1,g_input.flag2 ATTRIBUTE(WITHOUT DEFAULTS)
         
         ON CHANGE chk_esc
            IF g_input.chk_esc='Y' THEN
               LET INT_FLAG = TRUE
               EXIT DIALOG
            END IF
         
      END INPUT
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
   IF INT_FLAG THEN
      LET INT_FLAG=FALSE
      CLOSE WINDOW w_axrt460_01 
      RETURN FALSE
   END IF
   CALL axrt460_01_ins_xrfb(p_flag) RETURNING l_success
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrt460_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN l_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt460_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取法人說明
# Memo...........:
# Usage..........: CALL axrt460_01_xrfb001_desc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_01_xrfb001_desc()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_xrfb_d[l_ac].xrfb001
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d[l_ac].xrfb001,'', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_xrfb_d[l_ac].xrfb001_desc
END FUNCTION

################################################################################
# Descriptions...: 將單身差異分配寫入xrfb_t表中
# Memo...........:
# Usage..........: CALL axrt460_01_ins_xrfb(p_flag)
#                  RETURNING r_success
# Input parameter: p_flag         差異類型1：收款>帳款；2：收款<帳款
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      執行結果（TURE/FALSE）
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_01_ins_xrfb(p_flag)
   DEFINE p_flag           LIKE type_t.chr1
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrfb           RECORD LIKE xrfb_t.*
   DEFINE l_xrfb RECORD  #集團收款核銷單收款明細檔
       xrfbent LIKE xrfb_t.xrfbent, #企業編碼
       xrfbdocno LIKE xrfb_t.xrfbdocno, #集團代收單號
       xrfbld LIKE xrfb_t.xrfbld, #帳套
       xrfbseq LIKE xrfb_t.xrfbseq, #項次
       xrfb001 LIKE xrfb_t.xrfb001, #來源組織
       xrfb002 LIKE xrfb_t.xrfb002, #繳款單號
       xrfb003 LIKE xrfb_t.xrfb003, #繳款單項次
       xrfb004 LIKE xrfb_t.xrfb004, #款別
       xrfb005 LIKE xrfb_t.xrfb005, #銀行存提碼
       xrfb006 LIKE xrfb_t.xrfb006, #類型
       xrfb007 LIKE xrfb_t.xrfb007, #借貸別
       xrfb100 LIKE xrfb_t.xrfb100, #收款幣別
       xrfb101 LIKE xrfb_t.xrfb101, #匯率
       xrfb103 LIKE xrfb_t.xrfb103, #收款原幣金額
       xrfb104 LIKE xrfb_t.xrfb104, #收款本幣金額
       xrfb201 LIKE xrfb_t.xrfb201, #對應代收方當日匯率
       xrfb204 LIKE xrfb_t.xrfb204  #對應代收方本幣金額
       END RECORD

   #161128-00061#5---modify----end------------- 
   DEFINE l_xrfb006        LIKE xrfb_t.xrfb006
   DEFINE l_xrfb007        LIKE xrfb_t.xrfb007
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_seq            LIKE xrfb_t.xrfbseq
   
   LET r_success = TRUE
   #類型
   IF p_flag='1' THEN
      LET l_xrfb006=g_input.flag1
   ELSE
      LET l_xrfb006=g_input.flag2
   END IF
   #借貸別
   SELECT gzcb003 INTO l_xrfb007 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=l_xrfb006
   LET l_cnt=g_xrfb_d.getLength()
   FOR l_i=1 TO l_cnt
      IF cl_null(g_xrfb_d[l_i].xrfbseq) OR cl_null(g_xrfb_d[l_i].xrfbdocno) OR cl_null(g_xrfb_d[l_i].xrfbld) THEN
         CONTINUE FOR
      END IF
      INITIALIZE l_xrfb.* TO NULL
      LET l_xrfb.xrfbent=g_enterprise
      LET l_xrfb.xrfbdocno=g_xrfb_d[l_i].xrfbdocno
      LET l_xrfb.xrfbld=g_xrfb_d[l_i].xrfbld
      #項次
      SELECT COUNT(*) INTO l_n FROM xrfb_t
      WHERE xrfbent=g_enterprise AND xrfbdocno=g_xrfb_d[l_i].xrfbdocno AND xrfbseq=g_xrfb_d[l_i].xrfbseq
      IF l_n >0 THEN
         SELECT MAX(xrfbseq)+1 INTO l_seq FROM xrfb_t
          WHERE xrfbent=g_enterprise AND xrfbdocno=g_xrfb_d[l_i].xrfbdocno
         IF cl_null(l_seq) THEN LET l_seq=1 END IF
         LET l_xrfb.xrfbseq=l_seq
      ELSE
         LET l_xrfb.xrfbseq=g_xrfb_d[l_i].xrfbseq
      END IF
      LET l_xrfb.xrfb001=g_xrfb_d[l_i].xrfb001
      LET l_xrfb.xrfb006=l_xrfb006
      LET l_xrfb.xrfb007=l_xrfb007
      LET l_xrfb.xrfb100=g_xrfb_d[l_i].xrfb100
      LET l_xrfb.xrfb101=g_xrfb_d[l_i].xrfb101
      LET l_xrfb.xrfb103=g_xrfb_d[l_i].xrfb103
      LET l_xrfb.xrfb104=g_xrfb_d[l_i].xrfb104
      LET l_xrfb.xrfb201=l_xrfb.xrfb101
      LET l_xrfb.xrfb204=l_xrfb.xrfb104
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrfb_t VALUES(l_xrfb.*)
      INSERT INTO xrfb_t (xrfbent,xrfbdocno,xrfbld,xrfbseq,xrfb001,xrfb002,xrfb003,xrfb004,xrfb005,xrfb006,
                          xrfb007,xrfb100,xrfb101,xrfb103,xrfb104,xrfb201,xrfb204)
       VALUES(l_xrfb.xrfbent,l_xrfb.xrfbdocno,l_xrfb.xrfbld,l_xrfb.xrfbseq,l_xrfb.xrfb001,l_xrfb.xrfb002,l_xrfb.xrfb003,l_xrfb.xrfb004,l_xrfb.xrfb005,l_xrfb.xrfb006,
              l_xrfb.xrfb007,l_xrfb.xrfb100,l_xrfb.xrfb101,l_xrfb.xrfb103,l_xrfb.xrfb104,l_xrfb.xrfb201,l_xrfb.xrfb204)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success=FALSE
         EXIT FOR
      END IF
   END FOR
   RETURN r_success
END FUNCTION

 
{</section>}
 

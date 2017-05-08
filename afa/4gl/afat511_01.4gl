#該程式未解開Section, 採用最新樣板產出!
{<section id="afat511_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-04-30 09:32:32), PR版次:0007(2017-02-20 10:25:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: afat511_01
#+ Description: 科目與核算項明細
#+ Creator....: 02003(2015-04-29 10:36:03)
#+ Modifier...: 02003 -SD/PR- 07900
 
{</section>}
 
{<section id="afat511_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#26   2016/03/24  By Jessy         修正azzi920重複定義之錯誤訊息
#160318-00025#48   2016/04/29  By 07959         將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160913-00017#1    2016/09/21  By 07900         AFA模组调整交易客商开窗
#161111-00028#8    2016/11/28  by 02481         标准程式定义采用宣告模式,弃用.*写法
#161221-00054#4    2017/02/17  By 07900         相關單身(會計科目+部門) 及傳票預覽( 會計科目+部門), 要擋<<科目拒絕部門>> 參照agli060擋拒絕部門設定 
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
PRIVATE TYPE type_g_fabp_d        RECORD
       fabpld LIKE type_t.chr5, 
   fabpdocno LIKE type_t.chr20, 
   fabpseq LIKE fabp_t.fabpseq, 
   fabp037 LIKE fabp_t.fabp037, 
   fabp027 LIKE fabp_t.fabp027, 
   fabp027_desc LIKE type_t.chr500, 
   fabp028 LIKE fabp_t.fabp028, 
   fabp028_desc LIKE type_t.chr500, 
   fabp029 LIKE fabp_t.fabp029, 
   fabp029_desc LIKE type_t.chr500, 
   fabp030 LIKE fabp_t.fabp030, 
   fabp030_desc LIKE type_t.chr500, 
   fabp031 LIKE fabp_t.fabp031, 
   fabp031_desc LIKE type_t.chr500, 
   fabp032 LIKE fabp_t.fabp032, 
   fabp032_desc LIKE type_t.chr500, 
   fabp033 LIKE fabp_t.fabp033, 
   fabp033_desc LIKE type_t.chr500, 
   fabp034 LIKE fabp_t.fabp034, 
   fabp034_desc LIKE type_t.chr500, 
   fabp035 LIKE fabp_t.fabp035, 
   fabp035_desc LIKE type_t.chr500, 
   fabp036 LIKE fabp_t.fabp036, 
   fabp036_desc LIKE type_t.chr500, 
   fabp038 LIKE fabp_t.fabp038, 
   fabp039 LIKE fabp_t.fabp039, 
   fabp039_desc LIKE type_t.chr500, 
   fabp040 LIKE fabp_t.fabp040, 
   fabp040_desc LIKE type_t.chr500, 
   fabp041 LIKE fabp_t.fabp041, 
   fabp041_desc LIKE type_t.chr500, 
   fabp042 LIKE fabp_t.fabp042, 
   fabp042_desc LIKE type_t.chr500, 
   fabp043 LIKE fabp_t.fabp043, 
   fabp043_desc LIKE type_t.chr500, 
   fabp044 LIKE fabp_t.fabp044, 
   fabp044_desc LIKE type_t.chr500, 
   fabp045 LIKE fabp_t.fabp045, 
   fabp045_desc LIKE type_t.chr500, 
   fabp046 LIKE fabp_t.fabp046, 
   fabp046_desc LIKE type_t.chr500, 
   fabp047 LIKE fabp_t.fabp047, 
   fabp047_desc LIKE type_t.chr500, 
   fabp048 LIKE fabp_t.fabp048, 
   fabp048_desc LIKE type_t.chr500, 
   fabp049 LIKE fabp_t.fabp049, 
   fabp049_desc LIKE type_t.chr500, 
   fabp050 LIKE fabp_t.fabp050, 
   fabp050_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_loc                 LIKE type_t.chr5 
DEFINE g_fabp2_d             DYNAMIC ARRAY OF type_g_fabp_d
DEFINE g_fabp2_d_t           type_g_fabp_d
GLOBALS
   DEFINE p_prog             LIKE type_t.chr20
   DEFINE g_wc_subject       STRING
   DEFINE g_wc_d             STRING
   DEFINE g_fabgld           LIKE fabg_t.fabgld
   DEFINE g_fabgdocno        LIKE fabg_t.fabgdocno
   DEFINE g_fabpseq          LIKE fabp_t.fabpseq
   DEFINE g_fabgld_o         LIKE fabg_t.fabgld
   DEFINE g_fabgdocno_o      LIKE fabg_t.fabgdocno
   DEFINE g_fabpseq_o        LIKE fabp_t.fabpseq
   DEFINE g_detail_insert    LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete    LIKE type_t.num5   #單身的刪除權限
   DEFINE g_fabp_d2          DYNAMIC ARRAY OF type_g_fabp_d
END GLOBALS
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_sql                 STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_error_show          LIKE type_t.num5              #
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數   
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL  
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE l_insert              BOOLEAN
DEFINE l_cmd                 LIKE type_t.chr1
DEFINE l_n                   LIKE type_t.num5              #檢查重複用
DEFINE l_count               LIKE type_t.num5
DEFINE l_lock_sw             LIKE type_t.chr1              #單身鎖住否
DEFINE lb_reproduce          BOOLEAN
DEFINE li_reproduce          LIKE type_t.num5
DEFINE li_reproduce_target   LIKE type_t.num5
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_fabgdocdt           LIKE fabg_t.fabgdocdt
DEFINE g_faaj001             LIKE faaj_t.faaj001           #核算项财产编号
DEFINE g_faaj002             LIKE faaj_t.faaj002           #核算项附号
DEFINE g_faaj037             LIKE faaj_t.faaj037           #核算项卡片编号
#end add-point
 
DEFINE g_fabp_d          DYNAMIC ARRAY OF type_g_fabp_d
DEFINE g_fabp_d_t        type_g_fabp_d
 
 
DEFINE g_fabpld_t   LIKE fabp_t.fabpld    #Key值備份
DEFINE g_fabpdocno_t      LIKE fabp_t.fabpdocno    #Key值備份
DEFINE g_fabpseq_t      LIKE fabp_t.fabpseq    #Key值備份
 
 
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
 
{<section id="afat511_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat511_01(--)
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
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat511_01 WITH FORM cl_ap_formpath("afa","afat511_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('fabp038','6013') #20150114 add by chenying
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_fabp_d FROM s_detail1_afat511_01.*
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
           
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabpld
            #add-point:BEFORE FIELD fabpld name="input.b.page1_afat511_01.fabpld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabpld
            
            #add-point:AFTER FIELD fabpld name="input.a.page1_afat511_01.fabpld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabpld
            #add-point:ON CHANGE fabpld name="input.g.page1_afat511_01.fabpld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabpdocno
            #add-point:BEFORE FIELD fabpdocno name="input.b.page1_afat511_01.fabpdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabpdocno
            
            #add-point:AFTER FIELD fabpdocno name="input.a.page1_afat511_01.fabpdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabpdocno
            #add-point:ON CHANGE fabpdocno name="input.g.page1_afat511_01.fabpdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabpseq_2
            #add-point:BEFORE FIELD fabpseq_2 name="input.b.page1_afat511_01.fabpseq_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabpseq_2
            
            #add-point:AFTER FIELD fabpseq_2 name="input.a.page1_afat511_01.fabpseq_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabpseq_2
            #add-point:ON CHANGE fabpseq_2 name="input.g.page1_afat511_01.fabpseq_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp037
            #add-point:BEFORE FIELD fabp037 name="input.b.page1_afat511_01.fabp037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp037
            
            #add-point:AFTER FIELD fabp037 name="input.a.page1_afat511_01.fabp037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp037
            #add-point:ON CHANGE fabp037 name="input.g.page1_afat511_01.fabp037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp027
            #add-point:BEFORE FIELD fabp027 name="input.b.page1_afat511_01.fabp027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp027
            
            #add-point:AFTER FIELD fabp027 name="input.a.page1_afat511_01.fabp027"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp027
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp027_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp027
            #add-point:ON CHANGE fabp027 name="input.g.page1_afat511_01.fabp027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp027_desc
            #add-point:BEFORE FIELD fabp027_desc name="input.b.page1_afat511_01.fabp027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp027_desc
            
            #add-point:AFTER FIELD fabp027_desc name="input.a.page1_afat511_01.fabp027_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp027_desc
            #add-point:ON CHANGE fabp027_desc name="input.g.page1_afat511_01.fabp027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp028
            #add-point:BEFORE FIELD fabp028 name="input.b.page1_afat511_01.fabp028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp028
            
            #add-point:AFTER FIELD fabp028 name="input.a.page1_afat511_01.fabp028"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp028
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp028_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp028
            #add-point:ON CHANGE fabp028 name="input.g.page1_afat511_01.fabp028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp028_desc
            #add-point:BEFORE FIELD fabp028_desc name="input.b.page1_afat511_01.fabp028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp028_desc
            
            #add-point:AFTER FIELD fabp028_desc name="input.a.page1_afat511_01.fabp028_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp028_desc
            #add-point:ON CHANGE fabp028_desc name="input.g.page1_afat511_01.fabp028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp029
            #add-point:BEFORE FIELD fabp029 name="input.b.page1_afat511_01.fabp029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp029
            
            #add-point:AFTER FIELD fabp029 name="input.a.page1_afat511_01.fabp029"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp029
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp029_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp029
            #add-point:ON CHANGE fabp029 name="input.g.page1_afat511_01.fabp029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp029_desc
            #add-point:BEFORE FIELD fabp029_desc name="input.b.page1_afat511_01.fabp029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp029_desc
            
            #add-point:AFTER FIELD fabp029_desc name="input.a.page1_afat511_01.fabp029_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp029_desc
            #add-point:ON CHANGE fabp029_desc name="input.g.page1_afat511_01.fabp029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp030
            #add-point:BEFORE FIELD fabp030 name="input.b.page1_afat511_01.fabp030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp030
            
            #add-point:AFTER FIELD fabp030 name="input.a.page1_afat511_01.fabp030"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp030
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp030_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp030
            #add-point:ON CHANGE fabp030 name="input.g.page1_afat511_01.fabp030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp030_desc
            #add-point:BEFORE FIELD fabp030_desc name="input.b.page1_afat511_01.fabp030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp030_desc
            
            #add-point:AFTER FIELD fabp030_desc name="input.a.page1_afat511_01.fabp030_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp030_desc
            #add-point:ON CHANGE fabp030_desc name="input.g.page1_afat511_01.fabp030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp031
            #add-point:BEFORE FIELD fabp031 name="input.b.page1_afat511_01.fabp031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp031
            
            #add-point:AFTER FIELD fabp031 name="input.a.page1_afat511_01.fabp031"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp031
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp031_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp031
            #add-point:ON CHANGE fabp031 name="input.g.page1_afat511_01.fabp031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp031_desc
            #add-point:BEFORE FIELD fabp031_desc name="input.b.page1_afat511_01.fabp031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp031_desc
            
            #add-point:AFTER FIELD fabp031_desc name="input.a.page1_afat511_01.fabp031_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp031_desc
            #add-point:ON CHANGE fabp031_desc name="input.g.page1_afat511_01.fabp031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp032
            #add-point:BEFORE FIELD fabp032 name="input.b.page1_afat511_01.fabp032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp032
            
            #add-point:AFTER FIELD fabp032 name="input.a.page1_afat511_01.fabp032"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp032
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp032_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp032
            #add-point:ON CHANGE fabp032 name="input.g.page1_afat511_01.fabp032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp032_desc
            #add-point:BEFORE FIELD fabp032_desc name="input.b.page1_afat511_01.fabp032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp032_desc
            
            #add-point:AFTER FIELD fabp032_desc name="input.a.page1_afat511_01.fabp032_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp032_desc
            #add-point:ON CHANGE fabp032_desc name="input.g.page1_afat511_01.fabp032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp033
            #add-point:BEFORE FIELD fabp033 name="input.b.page1_afat511_01.fabp033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp033
            
            #add-point:AFTER FIELD fabp033 name="input.a.page1_afat511_01.fabp033"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabp2_d[l_ac].fabp033
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabp2_d[l_ac].fabp033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp033_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp033
            #add-point:ON CHANGE fabp033 name="input.g.page1_afat511_01.fabp033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp033_desc
            #add-point:BEFORE FIELD fabp033_desc name="input.b.page1_afat511_01.fabp033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp033_desc
            
            #add-point:AFTER FIELD fabp033_desc name="input.a.page1_afat511_01.fabp033_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp033_desc
            #add-point:ON CHANGE fabp033_desc name="input.g.page1_afat511_01.fabp033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp034
            #add-point:BEFORE FIELD fabp034 name="input.b.page1_afat511_01.fabp034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp034
            
            #add-point:AFTER FIELD fabp034 name="input.a.page1_afat511_01.fabp034"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp034
            #add-point:ON CHANGE fabp034 name="input.g.page1_afat511_01.fabp034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp034_desc
            #add-point:BEFORE FIELD fabp034_desc name="input.b.page1_afat511_01.fabp034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp034_desc
            
            #add-point:AFTER FIELD fabp034_desc name="input.a.page1_afat511_01.fabp034_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp034_desc
            #add-point:ON CHANGE fabp034_desc name="input.g.page1_afat511_01.fabp034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp035
            #add-point:BEFORE FIELD fabp035 name="input.b.page1_afat511_01.fabp035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp035
            
            #add-point:AFTER FIELD fabp035 name="input.a.page1_afat511_01.fabp035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp035
            #add-point:ON CHANGE fabp035 name="input.g.page1_afat511_01.fabp035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp035_desc
            #add-point:BEFORE FIELD fabp035_desc name="input.b.page1_afat511_01.fabp035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp035_desc
            
            #add-point:AFTER FIELD fabp035_desc name="input.a.page1_afat511_01.fabp035_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp035_desc
            #add-point:ON CHANGE fabp035_desc name="input.g.page1_afat511_01.fabp035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp036
            #add-point:BEFORE FIELD fabp036 name="input.b.page1_afat511_01.fabp036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp036
            
            #add-point:AFTER FIELD fabp036 name="input.a.page1_afat511_01.fabp036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp036
            #add-point:ON CHANGE fabp036 name="input.g.page1_afat511_01.fabp036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp036_desc
            #add-point:BEFORE FIELD fabp036_desc name="input.b.page1_afat511_01.fabp036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp036_desc
            
            #add-point:AFTER FIELD fabp036_desc name="input.a.page1_afat511_01.fabp036_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp036_desc
            #add-point:ON CHANGE fabp036_desc name="input.g.page1_afat511_01.fabp036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp038
            #add-point:BEFORE FIELD fabp038 name="input.b.page1_afat511_01.fabp038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp038
            
            #add-point:AFTER FIELD fabp038 name="input.a.page1_afat511_01.fabp038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp038
            #add-point:ON CHANGE fabp038 name="input.g.page1_afat511_01.fabp038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp039
            #add-point:BEFORE FIELD fabp039 name="input.b.page1_afat511_01.fabp039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp039
            
            #add-point:AFTER FIELD fabp039 name="input.a.page1_afat511_01.fabp039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp039
            #add-point:ON CHANGE fabp039 name="input.g.page1_afat511_01.fabp039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp039_desc
            #add-point:BEFORE FIELD fabp039_desc name="input.b.page1_afat511_01.fabp039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp039_desc
            
            #add-point:AFTER FIELD fabp039_desc name="input.a.page1_afat511_01.fabp039_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp039_desc
            #add-point:ON CHANGE fabp039_desc name="input.g.page1_afat511_01.fabp039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp040
            #add-point:BEFORE FIELD fabp040 name="input.b.page1_afat511_01.fabp040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp040
            
            #add-point:AFTER FIELD fabp040 name="input.a.page1_afat511_01.fabp040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp040
            #add-point:ON CHANGE fabp040 name="input.g.page1_afat511_01.fabp040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp040_desc
            #add-point:BEFORE FIELD fabp040_desc name="input.b.page1_afat511_01.fabp040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp040_desc
            
            #add-point:AFTER FIELD fabp040_desc name="input.a.page1_afat511_01.fabp040_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp040_desc
            #add-point:ON CHANGE fabp040_desc name="input.g.page1_afat511_01.fabp040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp041
            #add-point:BEFORE FIELD fabp041 name="input.b.page1_afat511_01.fabp041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp041
            
            #add-point:AFTER FIELD fabp041 name="input.a.page1_afat511_01.fabp041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp041
            #add-point:ON CHANGE fabp041 name="input.g.page1_afat511_01.fabp041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp041_desc
            #add-point:BEFORE FIELD fabp041_desc name="input.b.page1_afat511_01.fabp041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp041_desc
            
            #add-point:AFTER FIELD fabp041_desc name="input.a.page1_afat511_01.fabp041_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp041_desc
            #add-point:ON CHANGE fabp041_desc name="input.g.page1_afat511_01.fabp041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp042
            #add-point:BEFORE FIELD fabp042 name="input.b.page1_afat511_01.fabp042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp042
            
            #add-point:AFTER FIELD fabp042 name="input.a.page1_afat511_01.fabp042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp042
            #add-point:ON CHANGE fabp042 name="input.g.page1_afat511_01.fabp042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp042_desc
            #add-point:BEFORE FIELD fabp042_desc name="input.b.page1_afat511_01.fabp042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp042_desc
            
            #add-point:AFTER FIELD fabp042_desc name="input.a.page1_afat511_01.fabp042_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp042_desc
            #add-point:ON CHANGE fabp042_desc name="input.g.page1_afat511_01.fabp042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp043
            #add-point:BEFORE FIELD fabp043 name="input.b.page1_afat511_01.fabp043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp043
            
            #add-point:AFTER FIELD fabp043 name="input.a.page1_afat511_01.fabp043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp043
            #add-point:ON CHANGE fabp043 name="input.g.page1_afat511_01.fabp043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp043_desc
            #add-point:BEFORE FIELD fabp043_desc name="input.b.page1_afat511_01.fabp043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp043_desc
            
            #add-point:AFTER FIELD fabp043_desc name="input.a.page1_afat511_01.fabp043_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp043_desc
            #add-point:ON CHANGE fabp043_desc name="input.g.page1_afat511_01.fabp043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp044
            #add-point:BEFORE FIELD fabp044 name="input.b.page1_afat511_01.fabp044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp044
            
            #add-point:AFTER FIELD fabp044 name="input.a.page1_afat511_01.fabp044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp044
            #add-point:ON CHANGE fabp044 name="input.g.page1_afat511_01.fabp044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp044_desc
            #add-point:BEFORE FIELD fabp044_desc name="input.b.page1_afat511_01.fabp044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp044_desc
            
            #add-point:AFTER FIELD fabp044_desc name="input.a.page1_afat511_01.fabp044_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp044_desc
            #add-point:ON CHANGE fabp044_desc name="input.g.page1_afat511_01.fabp044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp045
            #add-point:BEFORE FIELD fabp045 name="input.b.page1_afat511_01.fabp045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp045
            
            #add-point:AFTER FIELD fabp045 name="input.a.page1_afat511_01.fabp045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp045
            #add-point:ON CHANGE fabp045 name="input.g.page1_afat511_01.fabp045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp045_desc
            #add-point:BEFORE FIELD fabp045_desc name="input.b.page1_afat511_01.fabp045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp045_desc
            
            #add-point:AFTER FIELD fabp045_desc name="input.a.page1_afat511_01.fabp045_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp045_desc
            #add-point:ON CHANGE fabp045_desc name="input.g.page1_afat511_01.fabp045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp046
            #add-point:BEFORE FIELD fabp046 name="input.b.page1_afat511_01.fabp046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp046
            
            #add-point:AFTER FIELD fabp046 name="input.a.page1_afat511_01.fabp046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp046
            #add-point:ON CHANGE fabp046 name="input.g.page1_afat511_01.fabp046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp046_desc
            #add-point:BEFORE FIELD fabp046_desc name="input.b.page1_afat511_01.fabp046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp046_desc
            
            #add-point:AFTER FIELD fabp046_desc name="input.a.page1_afat511_01.fabp046_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp046_desc
            #add-point:ON CHANGE fabp046_desc name="input.g.page1_afat511_01.fabp046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp047
            #add-point:BEFORE FIELD fabp047 name="input.b.page1_afat511_01.fabp047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp047
            
            #add-point:AFTER FIELD fabp047 name="input.a.page1_afat511_01.fabp047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp047
            #add-point:ON CHANGE fabp047 name="input.g.page1_afat511_01.fabp047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp047_desc
            #add-point:BEFORE FIELD fabp047_desc name="input.b.page1_afat511_01.fabp047_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp047_desc
            
            #add-point:AFTER FIELD fabp047_desc name="input.a.page1_afat511_01.fabp047_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp047_desc
            #add-point:ON CHANGE fabp047_desc name="input.g.page1_afat511_01.fabp047_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp048
            #add-point:BEFORE FIELD fabp048 name="input.b.page1_afat511_01.fabp048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp048
            
            #add-point:AFTER FIELD fabp048 name="input.a.page1_afat511_01.fabp048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp048
            #add-point:ON CHANGE fabp048 name="input.g.page1_afat511_01.fabp048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp048_desc
            #add-point:BEFORE FIELD fabp048_desc name="input.b.page1_afat511_01.fabp048_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp048_desc
            
            #add-point:AFTER FIELD fabp048_desc name="input.a.page1_afat511_01.fabp048_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp048_desc
            #add-point:ON CHANGE fabp048_desc name="input.g.page1_afat511_01.fabp048_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp049
            #add-point:BEFORE FIELD fabp049 name="input.b.page1_afat511_01.fabp049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp049
            
            #add-point:AFTER FIELD fabp049 name="input.a.page1_afat511_01.fabp049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp049
            #add-point:ON CHANGE fabp049 name="input.g.page1_afat511_01.fabp049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp049_desc
            #add-point:BEFORE FIELD fabp049_desc name="input.b.page1_afat511_01.fabp049_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp049_desc
            
            #add-point:AFTER FIELD fabp049_desc name="input.a.page1_afat511_01.fabp049_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp049_desc
            #add-point:ON CHANGE fabp049_desc name="input.g.page1_afat511_01.fabp049_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp050
            #add-point:BEFORE FIELD fabp050 name="input.b.page1_afat511_01.fabp050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp050
            
            #add-point:AFTER FIELD fabp050 name="input.a.page1_afat511_01.fabp050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp050
            #add-point:ON CHANGE fabp050 name="input.g.page1_afat511_01.fabp050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabp050_desc
            #add-point:BEFORE FIELD fabp050_desc name="input.b.page1_afat511_01.fabp050_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabp050_desc
            
            #add-point:AFTER FIELD fabp050_desc name="input.a.page1_afat511_01.fabp050_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabp050_desc
            #add-point:ON CHANGE fabp050_desc name="input.g.page1_afat511_01.fabp050_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_afat511_01.fabpld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabpld
            #add-point:ON ACTION controlp INFIELD fabpld name="input.c.page1_afat511_01.fabpld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabpdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabpdocno
            #add-point:ON ACTION controlp INFIELD fabpdocno name="input.c.page1_afat511_01.fabpdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabpseq_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabpseq_2
            #add-point:ON ACTION controlp INFIELD fabpseq_2 name="input.c.page1_afat511_01.fabpseq_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp037
            #add-point:ON ACTION controlp INFIELD fabp037 name="input.c.page1_afat511_01.fabp037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp027
            #add-point:ON ACTION controlp INFIELD fabp027 name="input.c.page1_afat511_01.fabp027"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooed004_1()                                #呼叫開窗 #161024-00008#4
            CALL q_ooef001_1()                                         #161024-00008#4 

            LET g_fabp2_d[l_ac].fabp027 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp027 TO fabp027              #

            NEXT FIELD fabp027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp027_desc
            #add-point:ON ACTION controlp INFIELD fabp027_desc name="input.c.page1_afat511_01.fabp027_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp027_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooed004_1()                                        #161024-00008#4 
            CALL q_ooef001_1()                                         #161024-00008#4 
            
            LET g_fabp2_d[l_ac].fabp027_desc = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp027_desc TO fabp027_desc              #

            NEXT FIELD fabp027_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp028
            #add-point:ON ACTION controlp INFIELD fabp028 name="input.c.page1_afat511_01.fabp028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp028             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp028 = g_qryparam.return1              
            #LET g_fabp2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp028 TO fabp028              #
            #DISPLAY g_fabp2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabp028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp028_desc
            #add-point:ON ACTION controlp INFIELD fabp028_desc name="input.c.page1_afat511_01.fabp028_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp028_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp028_desc = g_qryparam.return1              
            #LET g_fabp2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp028_desc TO fabp028_desc              #
            #DISPLAY g_fabp2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabp028_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp029
            #add-point:ON ACTION controlp INFIELD fabp029 name="input.c.page1_afat511_01.fabp029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp029 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp029 TO fabp029              #

            NEXT FIELD fabp029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp029_desc
            #add-point:ON ACTION controlp INFIELD fabp029_desc name="input.c.page1_afat511_01.fabp029_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp029_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp029_desc = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp029_desc TO fabp029_desc              #

            NEXT FIELD fabp029_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp030
            #add-point:ON ACTION controlp INFIELD fabp030 name="input.c.page1_afat511_01.fabp030"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp030             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp030 = g_qryparam.return1              
            #LET g_fabp2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp030 TO fabp030              #
            #DISPLAY g_fabp2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp030_desc
            #add-point:ON ACTION controlp INFIELD fabp030_desc name="input.c.page1_afat511_01.fabp030_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp030_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp030_desc = g_qryparam.return1              
            #LET g_fabp2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp030_desc TO fabp030_desc              #
            #DISPLAY g_fabp2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp030_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp031
            #add-point:ON ACTION controlp INFIELD fabp031 name="input.c.page1_afat511_01.fabp031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp2_d[l_ac].fabp031 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp031 TO fabp031              #

            NEXT FIELD fabp031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp031_desc
            #add-point:ON ACTION controlp INFIELD fabp031_desc name="input.c.page1_afat511_01.fabp031_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp031_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp2_d[l_ac].fabp031_desc = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp031_desc TO fabp031_desc              #

            NEXT FIELD fabp031_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp032
            #add-point:ON ACTION controlp INFIELD fabp032 name="input.c.page1_afat511_01.fabp032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp2_d[l_ac].fabp032 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp032 TO fabp032              #

            NEXT FIELD fabp032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp032_desc
            #add-point:ON ACTION controlp INFIELD fabp032_desc name="input.c.page1_afat511_01.fabp032_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp_d[l_ac].fabp032_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp_d[l_ac].fabp032_desc = g_qryparam.return1              

            DISPLAY g_fabp_d[l_ac].fabp032_desc TO fabp032_desc              #

            NEXT FIELD fabp032_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp033
            #add-point:ON ACTION controlp INFIELD fabp033 name="input.c.page1_afat511_01.fabp033"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp033             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp033 = g_qryparam.return1              
            #LET g_fabp2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp033 TO fabp033              #
            #DISPLAY g_fabp2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp033_desc
            #add-point:ON ACTION controlp INFIELD fabp033_desc name="input.c.page1_afat511_01.fabp033_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp_d[l_ac].fabp033_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabp_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabp_d[l_ac].fabp033_desc = g_qryparam.return1              
            #LET g_fabp_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp_d[l_ac].fabp033_desc TO fabp033_desc              #
            #DISPLAY g_fabp_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp033_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp034
            #add-point:ON ACTION controlp INFIELD fabp034 name="input.c.page1_afat511_01.fabp034"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp034 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp034 TO fabp034              #

            NEXT FIELD fabp034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp034_desc
            #add-point:ON ACTION controlp INFIELD fabp034_desc name="input.c.page1_afat511_01.fabp034_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp034_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp034_desc = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp034_desc TO fabp034_desc              #

            NEXT FIELD fabp034_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp035
            #add-point:ON ACTION controlp INFIELD fabp035 name="input.c.page1_afat511_01.fabp035"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp035 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp035 TO fabp035              #

            NEXT FIELD fabp035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp035_desc
            #add-point:ON ACTION controlp INFIELD fabp035_desc name="input.c.page1_afat511_01.fabp035_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp_d[l_ac].fabp035_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabp_d[l_ac].fabp035_desc = g_qryparam.return1              

            DISPLAY g_fabp_d[l_ac].fabp035_desc TO fabp035_desc              #

            NEXT FIELD fabp035_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp036
            #add-point:ON ACTION controlp INFIELD fabp036 name="input.c.page1_afat511_01.fabp036"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp036 = g_qryparam.return1              

            DISPLAY g_fabp2_d[l_ac].fabp036 TO fabp036              #

            NEXT FIELD fabp036                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp036_desc
            #add-point:ON ACTION controlp INFIELD fabp036_desc name="input.c.page1_afat511_01.fabp036_desc"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp_d[l_ac].fabp036_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabp_d[l_ac].fabp036_desc = g_qryparam.return1              

            DISPLAY g_fabp_d[l_ac].fabp036_desc TO fabp036_desc              #

            NEXT FIELD fabp036_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp038
            #add-point:ON ACTION controlp INFIELD fabp038 name="input.c.page1_afat511_01.fabp038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp039
            #add-point:ON ACTION controlp INFIELD fabp039 name="input.c.page1_afat511_01.fabp039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp039_desc
            #add-point:ON ACTION controlp INFIELD fabp039_desc name="input.c.page1_afat511_01.fabp039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp040
            #add-point:ON ACTION controlp INFIELD fabp040 name="input.c.page1_afat511_01.fabp040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp040_desc
            #add-point:ON ACTION controlp INFIELD fabp040_desc name="input.c.page1_afat511_01.fabp040_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp041
            #add-point:ON ACTION controlp INFIELD fabp041 name="input.c.page1_afat511_01.fabp041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp041_desc
            #add-point:ON ACTION controlp INFIELD fabp041_desc name="input.c.page1_afat511_01.fabp041_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp042
            #add-point:ON ACTION controlp INFIELD fabp042 name="input.c.page1_afat511_01.fabp042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp042_desc
            #add-point:ON ACTION controlp INFIELD fabp042_desc name="input.c.page1_afat511_01.fabp042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp043
            #add-point:ON ACTION controlp INFIELD fabp043 name="input.c.page1_afat511_01.fabp043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp043_desc
            #add-point:ON ACTION controlp INFIELD fabp043_desc name="input.c.page1_afat511_01.fabp043_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp044
            #add-point:ON ACTION controlp INFIELD fabp044 name="input.c.page1_afat511_01.fabp044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp044_desc
            #add-point:ON ACTION controlp INFIELD fabp044_desc name="input.c.page1_afat511_01.fabp044_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp045
            #add-point:ON ACTION controlp INFIELD fabp045 name="input.c.page1_afat511_01.fabp045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp045_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp045_desc
            #add-point:ON ACTION controlp INFIELD fabp045_desc name="input.c.page1_afat511_01.fabp045_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp046
            #add-point:ON ACTION controlp INFIELD fabp046 name="input.c.page1_afat511_01.fabp046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp046_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp046_desc
            #add-point:ON ACTION controlp INFIELD fabp046_desc name="input.c.page1_afat511_01.fabp046_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp047
            #add-point:ON ACTION controlp INFIELD fabp047 name="input.c.page1_afat511_01.fabp047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp047_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp047_desc
            #add-point:ON ACTION controlp INFIELD fabp047_desc name="input.c.page1_afat511_01.fabp047_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp048
            #add-point:ON ACTION controlp INFIELD fabp048 name="input.c.page1_afat511_01.fabp048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp048_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp048_desc
            #add-point:ON ACTION controlp INFIELD fabp048_desc name="input.c.page1_afat511_01.fabp048_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp049
            #add-point:ON ACTION controlp INFIELD fabp049 name="input.c.page1_afat511_01.fabp049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp049_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp049_desc
            #add-point:ON ACTION controlp INFIELD fabp049_desc name="input.c.page1_afat511_01.fabp049_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp050
            #add-point:ON ACTION controlp INFIELD fabp050 name="input.c.page1_afat511_01.fabp050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat511_01.fabp050_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabp050_desc
            #add-point:ON ACTION controlp INFIELD fabp050_desc name="input.c.page1_afat511_01.fabp050_desc"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afat511_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat511_01.other_dialog" readonly="Y" >}

################################################################################
# Descriptions...: 顯示科目與核算項
# Memo...........:
# Usage..........: CALL afat511_01_display()
# Modify.........:
################################################################################
DIALOG afat511_01_display()
   DISPLAY ARRAY g_fabp2_d TO s_detail1_afat511_01.* ATTRIBUTES(COUNT=g_rec_b) 
      
      BEFORE ROW
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afat511_01")
         LET g_detail_idx = l_ac
               
      BEFORE DISPLAY
         IF g_loc = 'm' THEN
            CALL FGL_SET_ARR_CURR(g_detail_idx)
         END IF
         LET g_loc = 'm'
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afat511_01")
         LET g_current_page = 2  

      AFTER DISPLAY
         LET g_fabp_d2.* = g_fabp2_d.*
   END DISPLAY
END DIALOG

################################################################################
# Descriptions...: 录入科目與核算項
# Memo...........:
# Usage..........: CALL afat511_01_input()
# Modify.........:
################################################################################
DIALOG afat511_01_input()
   DEFINE l_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL  
   DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
   DEFINE l_insert              BOOLEAN
   DEFINE l_cmd                 LIKE type_t.chr1
   DEFINE l_n                   LIKE type_t.num5              #檢查重複用
   DEFINE l_count               LIKE type_t.num5
   DEFINE l_lock_sw             LIKE type_t.chr1              #單身鎖住否
   DEFINE lb_reproduce          BOOLEAN
   DEFINE li_reproduce          LIKE type_t.num5
   DEFINE li_reproduce_target   LIKE type_t.num5
   DEFINE l_success             LIKE type_t.num5 
   DEFINE l_errno               LIKE type_t.chr80   
   DEFINE l_desc                LIKE type_t.chr80     #接受s_get_orga返回值
   DEFINE l_date                LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_fabg005             LIKE fabg_t.fabg005   #單據性質 
   DEFINE l_glaacomp            LIKE glaa_t.glaacomp  #20141109
   DEFINE l_para_data           STRING
   #161111-00028#8----modify----begin---------
   #DEFINE g_glad                RECORD LIKE glad_t.*
   DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161111-00028#8----modify----end---------
   DEFINE l_glae009             LIKE glae_t.glae009
   #161221-00054#4--add--s--xul
   DEFINE l_fabp023             LIKE fabp_t.fabp023
   DEFINE l_fabp024             LIKE fabp_t.fabp024
   DEFINE l_fabp025             LIKE fabp_t.fabp025
   DEFINE l_fabp026             LIKE fabp_t.fabp026
   DEFINE l_wc                   STRING
   DEFINE l_glak_sql             STRING
   #161221-00054#4--add--e--xul
   INPUT ARRAY g_fabp2_d FROM s_detail1_afat511_01.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = g_detail_delete,
                 APPEND ROW = g_detail_delete)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
           
            CALL afat511_01_b_fill()
            LET g_rec_b = g_fabp2_d.getLength()
            CALL cl_set_combo_scc('fabp038','6013')
            LET g_forupd_sql = " SELECT fabgsite,'',fabg001,'',fabgld,'',fabg002,'',fabg003,'',fabg004,fabg005, 
            fabgdocno,fabgdocdt,fabg008,fabg009,fabg015,fabg016,fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid, 
            '',fabgcrtdp,'',fabgcrtdt,fabgmodid,'',fabgmoddt,fabgcnfid,'',fabgcnfdt,fabgpstid,'',fabgpstdt", 
             
                           " FROM fabg_t",
                           " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   
            LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
            LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
            DECLARE afat511_01_cl CURSOR FROM g_forupd_sql      
            
            LET g_forupd_sql = "SELECT fabpld,fabpdocno,fabpseq,fabp037,fabp027,'',fabp028,'',fabp029,'',
                                       fabp030,'',fabp031,'',fabp032,'',fabp033,'',fabp034,'',fabp035,'',
                                       fabp036,'',fabp038,fabp039,'',fabp040,'',fabp041,'',fabp042,'',
                                       fabp043,'',fabp044,'',fabp045,'',fabp046,'',fabp047,'',fabp048,'',
                                       fabp049,'',fabp050,''
                               FROM fabp_t  
                               WHERE fabpent=? AND fabpld=? AND fabpdocno=? AND fabpseq=? FOR UPDATE"
            LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
            LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
            DECLARE afat511_01_bcl CURSOR FROM g_forupd_sql
            
            SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
            SELECT fabgdocdt INTO g_fabgdocdt FROM fabg_t 
            WHERE fabgent=g_enterprise AND fabgld=g_fabgld AND fabgdocno=g_fabgdocno
            
            #end add-point
            
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabpseq_2
 
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabp2_d[l_ac].* TO NULL 
            INITIALIZE g_fabp2_d_t.* TO NULL 
            
            #add-point:modify段before備份

            #end add-point
            LET g_fabp2_d_t.* = g_fabp2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            #add-point:modify段after_set_entry_b

            #end add-point
    
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabp2_d[li_reproduce_target].* = g_fabp2_d[li_reproduce].*
               LET g_fabp2_d[li_reproduce_target].fabpseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert

            #end add-point  
            
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
            OPEN afat511_01_cl USING g_enterprise,g_fabgld,g_fabgdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat503_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE afat511_01_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b = g_fabp2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabp2_d[l_ac].fabpseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabp2_d_t.* = g_fabp2_d[l_ac].*  #BACKUP
               #add-point:modify段after_set_entry_b

               #end add-point  
               IF NOT afat511_01_lock_b("fabp_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat511_01_bcl INTO  g_fabp2_d[l_ac].fabpld,g_fabp2_d[l_ac].fabpdocno,g_fabp2_d[l_ac].fabpseq,  
                                             g_fabp2_d[l_ac].fabp037,g_fabp2_d[l_ac].fabp027,g_fabp2_d[l_ac].fabp027_desc,
                                             g_fabp2_d[l_ac].fabp028,g_fabp2_d[l_ac].fabp028_desc,g_fabp2_d[l_ac].fabp029,
                                             g_fabp2_d[l_ac].fabp029_desc,g_fabp2_d[l_ac].fabp030,g_fabp2_d[l_ac].fabp030_desc,
                                             g_fabp2_d[l_ac].fabp031,g_fabp2_d[l_ac].fabp031_desc,g_fabp2_d[l_ac].fabp032,
                                             g_fabp2_d[l_ac].fabp032_desc,g_fabp2_d[l_ac].fabp033,g_fabp2_d[l_ac].fabp033_desc,
                                             g_fabp2_d[l_ac].fabp034,g_fabp2_d[l_ac].fabp034_desc,g_fabp2_d[l_ac].fabp035,
                                             g_fabp2_d[l_ac].fabp035_desc,g_fabp2_d[l_ac].fabp036,g_fabp2_d[l_ac].fabp036_desc,
                                             g_fabp2_d[l_ac].fabp038,g_fabp2_d[l_ac].fabp039,g_fabp2_d[l_ac].fabp039_desc,
                                             g_fabp2_d[l_ac].fabp040,g_fabp2_d[l_ac].fabp040_desc,g_fabp2_d[l_ac].fabp041,
                                             g_fabp2_d[l_ac].fabp041_desc,g_fabp2_d[l_ac].fabp042,g_fabp2_d[l_ac].fabp042_desc,
                                             g_fabp2_d[l_ac].fabp043,g_fabp2_d[l_ac].fabp043_desc,g_fabp2_d[l_ac].fabp044,
                                             g_fabp2_d[l_ac].fabp044_desc,g_fabp2_d[l_ac].fabp045,g_fabp2_d[l_ac].fabp045_desc,
                                             g_fabp2_d[l_ac].fabp046,g_fabp2_d[l_ac].fabp046_desc,g_fabp2_d[l_ac].fabp047,
                                             g_fabp2_d[l_ac].fabp047_desc,g_fabp2_d[l_ac].fabp048,g_fabp2_d[l_ac].fabp048_desc,
                                             g_fabp2_d[l_ac].fabp049,g_fabp2_d[l_ac].fabp049_desc,g_fabp2_d[l_ac].fabp050,
                                             g_fabp2_d[l_ac].fabp050_desc           
                      
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
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
            #add-point:modify段before row
            #161221-00054#4--add--s--xul
            LET l_fabp023 =''
            LET l_fabp024 =''
            LET l_fabp025 =''
            LET l_fabp026 =''
            
            SELECT fabp023,fabp024,fabp025,fabp026 INTO l_fabp023,l_fabp024,l_fabp025,l_fabp026 
              FROM fabp_t,faaj_t  
             WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
               AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
               AND fabpld = faajld 
            LET l_wc = l_fabp023,",",l_fabp024,",",l_fabp025,",",l_fabp026 
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul
            SELECT fabp037 INTO g_fabp2_d[l_ac].fabp037   
              FROM fabp_t,faaj_t  
             WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
               AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
               AND fabpld = faajld               

            IF cl_null(g_fabp2_d[l_ac].fabp027) THEN 
               SELECT faajsite,'' INTO g_fabp2_d[l_ac].fabp027,g_fabp2_d[l_ac].fabp027_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF
            
            IF cl_null(g_fabp2_d[l_ac].fabp028) THEN 
               SELECT faaj039,'' INTO g_fabp2_d[l_ac].fabp028,g_fabp2_d[l_ac].fabp028_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF

            IF cl_null(g_fabp2_d[l_ac].fabp029) THEN 
               SELECT faaj040,'' INTO g_fabp2_d[l_ac].fabp029,g_fabp2_d[l_ac].fabp029_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF
            
            IF cl_null(g_fabp2_d[l_ac].fabp030) THEN 
               SELECT faaj041,'' INTO g_fabp2_d[l_ac].fabp030,g_fabp2_d[l_ac].fabp030_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF

            IF cl_null(g_fabp2_d[l_ac].fabp031) THEN 
               SELECT faaj042,'' INTO g_fabp2_d[l_ac].fabp031,g_fabp2_d[l_ac].fabp031_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF
            
            IF cl_null(g_fabp2_d[l_ac].fabp032) THEN 
               SELECT faaj043,'' INTO g_fabp2_d[l_ac].fabp032,g_fabp2_d[l_ac].fabp032_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF 

            IF cl_null(g_fabp2_d[l_ac].fabp033) THEN 
               SELECT faaj044,'' INTO g_fabp2_d[l_ac].fabp033,g_fabp2_d[l_ac].fabp033_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF
            
            IF cl_null(g_fabp2_d[l_ac].fabp034) THEN 
               SELECT faaj047,'' INTO g_fabp2_d[l_ac].fabp034,g_fabp2_d[l_ac].fabp034_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF            
 
            IF cl_null(g_fabp2_d[l_ac].fabp035) THEN 
               SELECT faaj045,'' INTO g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp035_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF
            
            IF cl_null(g_fabp2_d[l_ac].fabp036) THEN 
               SELECT faaj046,'' INTO g_fabp2_d[l_ac].fabp036,g_fabp2_d[l_ac].fabp036_desc   
                 FROM fabp_t,faaj_t  
                WHERE faaj001=fabp001 AND faaj002=fabp002 AND faaj037=fabp000 AND faajent=fabpent
                  AND fabpent=g_enterprise AND fabpld=g_fabgld AND fabpdocno=g_fabgdocno AND fabpseq=g_fabp2_d[l_ac].fabpseq 
                  AND fabpld = faajld                          
            END IF 
            
            LET g_fabp2_d[l_ac].fabp027_desc=g_fabp2_d[l_ac].fabp027
            LET g_fabp2_d[l_ac].fabp028_desc=g_fabp2_d[l_ac].fabp028
            LET g_fabp2_d[l_ac].fabp029_desc=g_fabp2_d[l_ac].fabp029
            LET g_fabp2_d[l_ac].fabp030_desc=g_fabp2_d[l_ac].fabp030
            LET g_fabp2_d[l_ac].fabp031_desc=g_fabp2_d[l_ac].fabp031
            LET g_fabp2_d[l_ac].fabp032_desc=g_fabp2_d[l_ac].fabp032
            LET g_fabp2_d[l_ac].fabp033_desc=g_fabp2_d[l_ac].fabp033
            LET g_fabp2_d[l_ac].fabp034_desc=g_fabp2_d[l_ac].fabp034
            LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d[l_ac].fabp035
            LET g_fabp2_d[l_ac].fabp036_desc=g_fabp2_d[l_ac].fabp036
            LET g_fabp2_d[l_ac].fabp039_desc=g_fabp2_d[l_ac].fabp039
            LET g_fabp2_d[l_ac].fabp040_desc=g_fabp2_d[l_ac].fabp040 
            LET g_fabp2_d[l_ac].fabp041_desc=g_fabp2_d[l_ac].fabp041
            LET g_fabp2_d[l_ac].fabp042_desc=g_fabp2_d[l_ac].fabp042
            LET g_fabp2_d[l_ac].fabp043_desc=g_fabp2_d[l_ac].fabp043
            LET g_fabp2_d[l_ac].fabp044_desc=g_fabp2_d[l_ac].fabp044
            LET g_fabp2_d[l_ac].fabp045_desc=g_fabp2_d[l_ac].fabp045
            LET g_fabp2_d[l_ac].fabp046_desc=g_fabp2_d[l_ac].fabp046
            LET g_fabp2_d[l_ac].fabp047_desc=g_fabp2_d[l_ac].fabp047
            LET g_fabp2_d[l_ac].fabp048_desc=g_fabp2_d[l_ac].fabp048 
            LET g_fabp2_d[l_ac].fabp049_desc=g_fabp2_d[l_ac].fabp049
            LET g_fabp2_d[l_ac].fabp050_desc=g_fabp2_d[l_ac].fabp050             
            CALL afat511_01_b_ref()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前

               #end add-point    
               
               DELETE FROM fabp_t
                WHERE fabpent = g_enterprise AND fabpld = g_fabgld AND
                                          fabpdocno = g_fabgdocno AND
                      fabpseq = g_fabp2_d_t.fabpseq
                  
               #add-point:單身2刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabp_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat511_01_bcl
#               LET l_count = g_fabp_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys[3] = g_fabp2_d[g_detail_idx].fabpseq
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL afat511_01_delete_b('fabp_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabp2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
#               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM fabp_t 
             WHERE fabpent = g_enterprise AND fabpld = g_fabgld
               AND fabpdocno = g_fabgdocno
               AND fabpseq = g_fabp2_d[l_ac].fabpseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys[3] = g_fabp2_d[g_detail_idx].fabpseq
#               CALL afat511_01_insert_b('fabp_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabp2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
#               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabp_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat503_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabp2_d[l_ac].* = g_fabp2_d_t.*
               CLOSE afat511_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabp2_d[l_ac].* = g_fabp2_d_t.*
            ELSE
               #add-point:單身page2修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE fabp_t SET (fabp037,fabp027,fabp028,fabp029,fabp030,fabp031,fabp032,fabp033,fabp034,fabp035,fabp036,fabp038,fabp039,
                   fabp040,fabp041,fabp042,fabp043,fabp044,fabp045,fabp046,fabp047,fabp048,fabp049,fabp050
                   ) = (g_fabp2_d[l_ac].fabp037,g_fabp2_d[l_ac].fabp027,g_fabp2_d[l_ac].fabp028,g_fabp2_d[l_ac].fabp029, 
                   g_fabp2_d[l_ac].fabp030,g_fabp2_d[l_ac].fabp031,g_fabp2_d[l_ac].fabp032,g_fabp2_d[l_ac].fabp033, 
                   g_fabp2_d[l_ac].fabp034,g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp036,g_fabp2_d[l_ac].fabp038,
                   g_fabp2_d[l_ac].fabp039,g_fabp2_d[l_ac].fabp040,g_fabp2_d[l_ac].fabp041,g_fabp2_d[l_ac].fabp042,
                   g_fabp2_d[l_ac].fabp043,g_fabp2_d[l_ac].fabp044,g_fabp2_d[l_ac].fabp045,g_fabp2_d[l_ac].fabp046,
                   g_fabp2_d[l_ac].fabp047,g_fabp2_d[l_ac].fabp048,g_fabp2_d[l_ac].fabp049,g_fabp2_d[l_ac].fabp050
                   ) #自訂欄位頁簽 

                WHERE fabpent = g_enterprise AND fabpld = g_fabgld
                  AND fabpdocno = g_fabgdocno
                  AND fabpseq = g_fabp2_d_t.fabpseq #項次 
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabp_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabp2_d[l_ac].* = g_fabp2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabp_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabp2_d[l_ac].* = g_fabp2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys_bak[1] = g_fabgld_o
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_o
               LET gs_keys[3] = g_fabp2_d[g_detail_idx].fabpseq
               LET gs_keys_bak[3] = g_fabp2_d_t.fabpseq
               CALL afat511_01_update_b('fabp_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_fabp2_d_t)
               LET g_log2 = util.JSON.stringify(g_fabp2_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後

               #end add-point
            END IF
         

         #此段落由子樣板a01產生
         BEFORE FIELD fabp037
            #add-point:BEFORE FIELD fabp037

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp037
            
            #add-point:AFTER FIELD fabp037

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp037
            #add-point:ON CHANGE fabp037

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp027
            #add-point:BEFORE FIELD fabp027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp027
            
            #add-point:AFTER FIELD fabp027
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp027
            #add-point:ON CHANGE fabp027

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp027_desc
            #add-point:BEFORE FIELD fabp027_desc
            LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d[l_ac].fabp027
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp027_desc
            
            #add-point:AFTER FIELD fabp027_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp027_desc) THEN
#20150114 mod by chenying
#               CALL s_get_orga('2',g_fabp2_d[l_ac].fabp027_desc,'',g_fabgdocdt) 
#               RETURNING l_success,g_fabp2_d[l_ac].fabp027_desc,l_desc,l_desc,l_date,l_date,l_errno
#               IF l_success = FALSE THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = l_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp027_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
#                  NEXT FIELD fabp027_desc
#               END IF 
               CALL s_voucher_glaq017_chk(g_fabp2_d[l_ac].fabp027_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
                  
                  LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                  NEXT FIELD fabp027_desc
               END IF   
#20150114 mod by chenying
  #161024-00008#4---s---
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabp2_d[l_ac].fabp027_desc
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_20") THEN
                  #161221-00054#4--add--s--xul
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_fabgld,'01',l_fabp023,g_fabp2_d[l_ac].fabp027_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                    LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                    NEXT FIELD fabp027_desc
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_fabgld,'01',l_fabp024,g_fabp2_d[l_ac].fabp027_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                    LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                    NEXT FIELD fabp027_desc
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_fabgld,'01',l_fabp025,g_fabp2_d[l_ac].fabp027_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                    LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                    NEXT FIELD fabp027_desc
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_fabgld,'01',l_fabp026,g_fabp2_d[l_ac].fabp027_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                    LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                    NEXT FIELD fabp027_desc
                  END IF
                  #161221-00054#4--add--e--xul
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabp2_d[l_ac].fabp027_desc = g_fabp2_d_t.fabp027
                  NEXT FIELD fabp027_desc
               END IF
               #161024-00008#4---e--- 
            END IF
            LET g_fabp2_d[l_ac].fabp027 = g_fabp2_d[l_ac].fabp027_desc
            CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp027_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp027_desc=g_fabp2_d[l_ac].fabp027_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp027_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp027_desc
            #add-point:ON CHANGE fabp027_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp028
            #add-point:BEFORE FIELD fabp028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp028
            
            #add-point:AFTER FIELD fabp028
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp028
            #add-point:ON CHANGE fabp028

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp028_desc
            #add-point:BEFORE FIELD fabp028_desc
            LET g_fabp2_d[l_ac].fabp028_desc = g_fabp2_d[l_ac].fabp028
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp028_desc
            
            #add-point:AFTER FIELD fabp028_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp028_desc) THEN
#20150114 add by chenying     
#               CALL afat511_01_fabp028_chk(g_fabp2_d[l_ac].fabp028_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp028_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#
#                  LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028
#                  NEXT FIELD fabp028_desc                  
#               END IF
               CALL s_department_chk(g_fabp2_d[l_ac].fabp028_desc,g_fabgdocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028 
                  NEXT FIELD fabp028_desc                  
               END IF
#20150114 add by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'02',l_fabp023,g_fabp2_d[l_ac].fabp028_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028 
                  NEXT FIELD fabp028_desc   
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'02',l_fabp024,g_fabp2_d[l_ac].fabp028_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028 
                  NEXT FIELD fabp028_desc   
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'02',l_fabp025,g_fabp2_d[l_ac].fabp028_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028 
                  NEXT FIELD fabp028_desc   
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'02',l_fabp026,g_fabp2_d[l_ac].fabp028_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp028_desc = g_fabp_d_t.fabp028 
                  NEXT FIELD fabp028_desc   
               END IF
               #161221-00054#4--add--e--xul               
            END IF
            LET g_fabp2_d[l_ac].fabp028 = g_fabp2_d[l_ac].fabp028_desc
            CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp028_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp028_desc=g_fabp2_d[l_ac].fabp028_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp028_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp028_desc
            #add-point:ON CHANGE fabp028_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp029
            #add-point:BEFORE FIELD fabp029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp029
            
            #add-point:AFTER FIELD fabp029
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp029
            #add-point:ON CHANGE fabp029

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp029_desc
            #add-point:BEFORE FIELD fabp029_desc
            LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d[l_ac].fabp029
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp029_desc
            
            #add-point:AFTER FIELD fabp029_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp029_desc) THEN
               CALL s_voucher_glaq019_chk(g_fabp2_d[l_ac].fabp029_desc,g_fabgdocdt) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp029_desc
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d_t.fabp029
                  NEXT FIELD fabp029_desc
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'03',l_fabp023,g_fabp2_d[l_ac].fabp029_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d_t.fabp029
                  NEXT FIELD fabp029_desc  
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'03',l_fabp024,g_fabp2_d[l_ac].fabp029_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d_t.fabp029
                  NEXT FIELD fabp029_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'03',l_fabp025,g_fabp2_d[l_ac].fabp029_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d_t.fabp029
                  NEXT FIELD fabp029_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'03',l_fabp026,g_fabp2_d[l_ac].fabp029_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d_t.fabp029
                  NEXT FIELD fabp029_desc  
               END IF
               #161221-00054#4--add--e--xul      
                              
            END IF
            LET g_fabp2_d[l_ac].fabp029 = g_fabp2_d[l_ac].fabp029_desc
            CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp029_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp029_desc=g_fabp2_d[l_ac].fabp029_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp029_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp029_desc
            #add-point:ON CHANGE fabp029_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp030
            #add-point:BEFORE FIELD fabp030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp030
            
            #add-point:AFTER FIELD fabp030
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp030
            #add-point:ON CHANGE fabp030

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp030_desc
            #add-point:BEFORE FIELD fabp030_desc
            LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d[l_ac].fabp030
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp030_desc
            
            #add-point:AFTER FIELD fabp030_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp030_desc) THEN
#20150114 add by chenying
#               CALL afat511_01_fabp030_chk('287',g_fabp2_d[l_ac].fabp030_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp030_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
#                  NEXT FIELD fabp030_desc
#               END IF
               IF NOT s_azzi650_chk_exist('287',g_fabp2_d[l_ac].fabp030_desc) THEN
                  LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
                  NEXT FIELD fabp030_desc               
               END IF
#20150114 add by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'04',l_fabp023,g_fabp2_d[l_ac].fabp030_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
                  NEXT FIELD fabp030_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'04',l_fabp024,g_fabp2_d[l_ac].fabp030_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
                  NEXT FIELD fabp030_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'04',l_fabp025,g_fabp2_d[l_ac].fabp030_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
                  NEXT FIELD fabp030_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'04',l_fabp026,g_fabp2_d[l_ac].fabp030_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
               LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d_t.fabp030
                  NEXT FIELD fabp030_desc  
               END IF
               #161221-00054#4--add--e--xul                
            END IF
            LET g_fabp2_d[l_ac].fabp030 = g_fabp2_d[l_ac].fabp030_desc
            CALL afat511_01_fabp040_desc('287',g_fabp2_d[l_ac].fabp030_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp030_desc=g_fabp2_d[l_ac].fabp030_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp030_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp030_desc
            #add-point:ON CHANGE fabp030_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp031
            #add-point:BEFORE FIELD fabp031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp031
            
            #add-point:AFTER FIELD fabp031
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp031
            #add-point:ON CHANGE fabp031

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp031_desc
            #add-point:BEFORE FIELD fabp031_desc
            LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d[l_ac].fabp031
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp031_desc
            
            #add-point:AFTER FIELD fabp031_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp031_desc) THEN
#20150114 mod by chenying            
#               CALL afat511_01_fabp031_chk(g_fabp2_d[l_ac].fabp031_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp031_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
#                  NEXT FIELD fabp031_desc
#               END IF
               CALL s_voucher_glaq021_chk(g_fabp2_d[l_ac].fabp031_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
                  NEXT FIELD fabp031_desc
               END IF
#20150114 mod by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'05',l_fabp023,g_fabp2_d[l_ac].fabp031_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
                  NEXT FIELD fabp031_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'05',l_fabp024,g_fabp2_d[l_ac].fabp031_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
                  NEXT FIELD fabp031_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'05',l_fabp025,g_fabp2_d[l_ac].fabp031_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
                  NEXT FIELD fabp031_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'05',l_fabp026,g_fabp2_d[l_ac].fabp031_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d_t.fabp031
                 NEXT FIELD fabp031_desc
               END IF
               #161221-00054#4--add--e--xul                    
            END IF
            LET g_fabp2_d[l_ac].fabp031 = g_fabp2_d[l_ac].fabp031_desc
            CALL afat511_01_fabp031_desc(g_fabp2_d[l_ac].fabp031_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp031_desc=g_fabp2_d[l_ac].fabp031_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp031_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp031_desc
            #add-point:ON CHANGE fabp031_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp032
            #add-point:BEFORE FIELD fabp032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp032
            
            #add-point:AFTER FIELD fabp032
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp032
            #add-point:ON CHANGE fabp032

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp032_desc
            #add-point:BEFORE FIELD fabp032_desc
            LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d[l_ac].fabp032
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp032_desc
            
            #add-point:AFTER FIELD fabp032_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp032_desc) THEN
#20150114 mod by chenying  
#               CALL afat511_01_fabp031_chk(g_fabp2_d[l_ac].fabp032_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp032_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
#                  NEXT FIELD fabp032_desc
#               END IF
               CALL s_voucher_glaq021_chk(g_fabp2_d[l_ac].fabp032_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
                  NEXT FIELD fabp032_desc
               END IF
#20150114 mod by chenying                 
                #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'06',l_fabp023,g_fabp2_d[l_ac].fabp032_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
                  NEXT FIELD fabp032_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'06',l_fabp024,g_fabp2_d[l_ac].fabp032_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
                  NEXT FIELD fabp032_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'06',l_fabp025,g_fabp2_d[l_ac].fabp032_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
                  NEXT FIELD fabp032_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'06',l_fabp026,g_fabp2_d[l_ac].fabp032_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d_t.fabp032
                  NEXT FIELD fabp032_desc
               END IF
               #161221-00054#4--add--e--xul                      
            END IF
            LET g_fabp2_d[l_ac].fabp032 = g_fabp2_d[l_ac].fabp032_desc
            CALL afat511_01_fabp031_desc(g_fabp2_d[l_ac].fabp032_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp032_desc=g_fabp2_d[l_ac].fabp032_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp032_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp032_desc
            #add-point:ON CHANGE fabp032_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp033
            #add-point:BEFORE FIELD fabp033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp033
            
            #add-point:AFTER FIELD fabp033
            
           
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp033
            #add-point:ON CHANGE fabp033

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp033_desc
            #add-point:BEFORE FIELD fabp033_desc
            LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d[l_ac].fabp033
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp033_desc
            
            #add-point:AFTER FIELD fabp033_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp033_desc) THEN
#20150114 mod by chenying              
#               CALL afat511_01_fabp030_chk('281',g_fabp2_d[l_ac].fabp033_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp033_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
#                  NEXT FIELD fabp033_desc
#               END IF 
               IF NOT s_azzi650_chk_exist('281',g_fabp2_d[l_ac].fabp033_desc) THEN
                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
                  NEXT FIELD fabp033_desc               
               END IF
#20150114 mod by chenying  
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'07',l_fabp023,g_fabp2_d[l_ac].fabp033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
                  NEXT FIELD fabp033_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'07',l_fabp024,g_fabp2_d[l_ac].fabp033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
                  NEXT FIELD fabp033_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'07',l_fabp025,g_fabp2_d[l_ac].fabp033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
                  NEXT FIELD fabp033_desc 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'07',l_fabp026,g_fabp2_d[l_ac].fabp033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d_t.fabp033
                  NEXT FIELD fabp033_desc 
               END IF
               #161221-00054#4--add--e--xul      
            END IF
            LET g_fabp2_d[l_ac].fabp033 = g_fabp2_d[l_ac].fabp033_desc
            CALL afat511_01_fabp040_desc('281',g_fabp2_d[l_ac].fabp033_desc) RETURNING l_desc 
            LET g_fabp2_d[l_ac].fabp033_desc=g_fabp2_d[l_ac].fabp033_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp033_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp033_desc
            #add-point:ON CHANGE fabp033_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp034
            #add-point:BEFORE FIELD fabp034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp034
            
            #add-point:AFTER FIELD fabp034
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp034
            #add-point:ON CHANGE fabp034

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp034_desc
            #add-point:BEFORE FIELD fabp034_desc
            LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d[l_ac].fabp034
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp034_desc
            
            #add-point:AFTER FIELD fabp034_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp034_desc) THEN
#20150114 mod by chenying 
#               CALL afat511_01_fabp034_chk(g_fabp2_d[l_ac].fabp034_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabp2_d[l_ac].fabp034_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
#                  NEXT FIELD fabp034_desc
#               END IF
               CALL s_employee_chk(g_fabp2_d[l_ac].fabp034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN 
                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
                  NEXT FIELD fabp034_desc
               END IF
#20150114 mod by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'12',l_fabp023,g_fabp2_d[l_ac].fabp034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
                  NEXT FIELD fabp034_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'12',l_fabp024,g_fabp2_d[l_ac].fabp034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
                  NEXT FIELD fabp034_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'12',l_fabp025,g_fabp2_d[l_ac].fabp034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
                  NEXT FIELD fabp034_desc
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'12',l_fabp026,g_fabp2_d[l_ac].fabp034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d_t.fabp034
                  NEXT FIELD fabp034_desc
               END IF
               #161221-00054#4--add--e--xul                    
            END IF
            LET g_fabp2_d[l_ac].fabp034 = g_fabp2_d[l_ac].fabp034_desc
            CALL afat511_01_fabp034_desc(g_fabp2_d[l_ac].fabp034_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp034_desc=g_fabp2_d[l_ac].fabp034_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp034_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp034_desc
            #add-point:ON CHANGE fabp034_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp035
            #add-point:BEFORE FIELD fabp035

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp035
            
            #add-point:AFTER FIELD fabp035

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp035
            #add-point:ON CHANGE fabp035

            #END add-point
         BEFORE FIELD fabp035_desc
            LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d[l_ac].fabp035
            
         AFTER FIELD fabp035_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp035_desc) THEN 
#20150114 mod by chenying            
#               #此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabp2_d[l_ac].fabp035_desc
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pjba001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#                  LET g_fabp2_d[l_ac].fabp035=g_fabp2_d[l_ac].fabp035_desc
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aap_project_chk(g_fabp2_d[l_ac].fabp035_desc) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apjm200'
                  LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                  LET g_errparam.exeprog = 'apjm200'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
                  NEXT FIELD CURRENT
               END IF 
                               
#20150114 mod by chenying  
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'13',l_fabp023,g_fabp2_d[l_ac].fabp035_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'13',l_fabp024,g_fabp2_d[l_ac].fabp035_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'13',l_fabp025,g_fabp2_d[l_ac].fabp035_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'13',l_fabp026,g_fabp2_d[l_ac].fabp035_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d_t.fabp035
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul   
            END IF 
            LET g_fabp2_d[l_ac].fabp035=g_fabp2_d[l_ac].fabp035_desc
            CALL afat511_01_fabp035_desc(g_fabp2_d[l_ac].fabp035_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d[l_ac].fabp035_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp035_desc
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabp036
            #add-point:BEFORE FIELD fabp036

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp036
            
            #add-point:AFTER FIELD fabp036

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabp036
            #add-point:ON CHANGE fabp036

            #END add-point
 
         #20150114 add by chenying
         BEFORE FIELD fabp036_desc
            LET g_fabp2_d[l_ac].fabp036_desc=g_fabp2_d[l_ac].fabp036
            
         AFTER FIELD fabp036_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp036_desc) THEN 
               CALL s_voucher_glaq028_chk(g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp036_desc)
               IF NOT cl_null(g_errno) THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d_t.fabp036
                  NEXT FIELD CURRENT
               END IF    
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'14',l_fabp023,g_fabp2_d[l_ac].fabp036_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d_t.fabp036
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'14',l_fabp024,g_fabp2_d[l_ac].fabp036_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d_t.fabp036
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'14',l_fabp025,g_fabp2_d[l_ac].fabp036_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d_t.fabp036
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'14',l_fabp026,g_fabp2_d[l_ac].fabp036_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d_t.fabp036
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul   
           
            END IF
            LET g_fabp2_d[l_ac].fabp036=g_fabp2_d[l_ac].fabp036_desc            
            CALL afat511_01_fabp036_desc(g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp036_desc) RETURNING l_desc
            LET g_fabp2_d[l_ac].fabp036_desc=g_fabp2_d[l_ac].fabp036_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp036_desc            
            
         AFTER FIELD fabp038
            IF NOT cl_null(g_fabp2_d[l_ac].fabp038) THEN
               CALL s_voucher_glaq051_chk(g_fabp2_d[l_ac].fabp038)
               IF NOT cl_null(g_errno) THEN
                  LET g_fabp2_d[l_ac].fabp038 = g_fabp2_d_t.fabp038
                  NEXT FIELD CURRENT                 
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'09',l_fabp023,g_fabp2_d[l_ac].fabp038) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp038 = g_fabp2_d_t.fabp038
                  NEXT FIELD CURRENT 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'09',l_fabp024,g_fabp2_d[l_ac].fabp038) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp038 = g_fabp2_d_t.fabp038
                  NEXT FIELD CURRENT 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'09',l_fabp025,g_fabp2_d[l_ac].fabp038) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp038 = g_fabp2_d_t.fabp038
                  NEXT FIELD CURRENT 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'09',l_fabp026,g_fabp2_d[l_ac].fabp038) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp038 = g_fabp2_d_t.fabp038
                  NEXT FIELD CURRENT 
               END IF
               #161221-00054#4--add--e--xul   
            END IF  
            
         BEFORE FIELD fabp039_desc
            LET g_fabp2_d[l_ac].fabp039_desc=g_fabp2_d[l_ac].fabp039
            
         AFTER FIELD fabp039_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp039_desc) THEN
               CALL s_voucher_glaq052_chk(g_fabp2_d[l_ac].fabp039_desc)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d_t.fabp039
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'10',l_fabp023,g_fabp2_d[l_ac].fabp039_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d_t.fabp039
                  NEXT FIELD CURRENT 
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'10',l_fabp024,g_fabp2_d[l_ac].fabp039_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d_t.fabp039
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'10',l_fabp025,g_fabp2_d[l_ac].fabp039_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d_t.fabp039
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'10',l_fabp026,g_fabp2_d[l_ac].fabp039_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d_t.fabp039
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul   
            END IF 
            LET g_fabp2_d[l_ac].fabp039 = g_fabp2_d[l_ac].fabp039_desc
            CALL afat511_01_fabp039_desc(g_fabp2_d[l_ac].fabp039_desc)  RETURNING l_desc     
            LET g_fabp2_d[l_ac].fabp039_desc=g_fabp2_d[l_ac].fabp039_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp039_desc   

         BEFORE FIELD fabp040_desc
            LET g_fabp2_d[l_ac].fabp040_desc=g_fabp2_d[l_ac].fabp040
            
         AFTER FIELD fabp040_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp040_desc) THEN
               IF NOT s_azzi650_chk_exist('2002',g_fabp2_d[l_ac].fabp040_desc) THEN
                  LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d_t.fabp040
                  NEXT FIELD CURRENT
               END IF
                #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'11',l_fabp023,g_fabp2_d[l_ac].fabp040_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d_t.fabp040
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'11',l_fabp024,g_fabp2_d[l_ac].fabp040_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d_t.fabp040
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'11',l_fabp025,g_fabp2_d[l_ac].fabp040_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d_t.fabp040
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabgld,'11',l_fabp026,g_fabp2_d[l_ac].fabp040_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d_t.fabp040
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul   
            END IF 
            LET g_fabp2_d[l_ac].fabp040 = g_fabp2_d[l_ac].fabp040_desc
            CALL afat511_01_fabp040_desc('2002',g_fabp2_d[l_ac].fabp040_desc)  RETURNING l_desc     
            LET g_fabp2_d[l_ac].fabp040_desc=g_fabp2_d[l_ac].fabp040_desc,l_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp040_desc     

         #自由核算项
         #自由核算項一
         BEFORE FIELD fabp041_desc
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp041_desc=g_fabp2_d[l_ac].fabp041
         
         AFTER FIELD fabp041_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp041_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp041_desc != g_fabp2_d_t.fabp041_desc OR g_fabp2_d_t.fabp041_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp041 = g_fabp2_d[l_ac].fabp041_desc
 
                     CALL s_voucher_free_account_chk(g_glad.glad0171,g_fabp2_d[l_ac].fabp041_desc,g_glad.glad0172) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp041        = g_fabp2_d_t.fabp041
                        LET g_fabp2_d[l_ac].fabp041_desc = g_fabp2_d_t.fabp041_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp041,g_fabp2_d[l_ac].fabp041_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
         LET g_fabp2_d[l_ac].fabp041 = g_fabp2_d[l_ac].fabp041_desc   
         LET g_fabp2_d[l_ac].fabp041_desc = s_desc_show1(g_fabp2_d[l_ac].fabp041,s_fin_get_accting_desc(g_glad.glad0171,g_fabp2_d[l_ac].fabp041))
         LET g_fabp2_d_t.fabp041_desc = g_fabp2_d[l_ac].fabp041_desc
         DISPLAY BY NAME g_fabp2_d[l_ac].fabp041,g_fabp2_d[l_ac].fabp041_desc 

         #自由核算項二
         BEFORE FIELD fabp042_desc
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp042_desc=g_fabp2_d[l_ac].fabp042
            
         AFTER FIELD fabp042_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp042_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp042_desc != g_fabp2_d_t.fabp042_desc OR g_fabp2_d_t.fabp042_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp042 = g_fabp2_d[l_ac].fabp042_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0181,g_fabp2_d[l_ac].fabp042_desc,g_glad.glad0182) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp042        = g_fabp2_d_t.fabp042
                        LET g_fabp2_d[l_ac].fabp042_desc = g_fabp2_d_t.fabp042_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp042,g_fabp2_d[l_ac].fabp042_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp042 = g_fabp2_d[l_ac].fabp042_desc
            LET g_fabp2_d[l_ac].fabp042_desc = s_desc_show1(g_fabp2_d[l_ac].fabp042,s_fin_get_accting_desc(g_glad.glad0181,g_fabp2_d[l_ac].fabp042))
            LET g_fabp2_d_t.fabp042_desc = g_fabp2_d[l_ac].fabp042_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp042,g_fabp2_d[l_ac].fabp042_desc

   
         
         #自由核算項三
         BEFORE FIELD fabp043_desc
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp043_desc=g_fabp2_d[l_ac].fabp043

         
         AFTER FIELD fabp043_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp043_desc)  THEN
               IF ( g_fabp2_d[l_ac].fabp043_desc != g_fabp2_d_t.fabp043_desc OR g_fabp2_d_t.fabp043_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp043 = g_fabp2_d[l_ac].fabp043_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0191,g_fabp2_d[l_ac].fabp043_desc,g_glad.glad0192) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp043        = g_fabp2_d_t.fabp043
                        LET g_fabp2_d[l_ac].fabp043_desc = g_fabp2_d_t.fabp043_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp043,g_fabp2_d[l_ac].fabp043_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp043 = g_fabp2_d[l_ac].fabp043_desc
            LET g_fabp2_d[l_ac].fabp043_desc = s_desc_show1(g_fabp2_d[l_ac].fabp043,s_fin_get_accting_desc(g_glad.glad0191,g_fabp2_d[l_ac].fabp043))
            LET g_fabp2_d_t.fabp043_desc = g_fabp2_d[l_ac].fabp043_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp043,g_fabp2_d[l_ac].fabp043_desc

 
            
         #自由核算項四
         BEFORE FIELD fabp044_desc
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp044_desc=g_fabp2_d[l_ac].fabp044

         
         AFTER FIELD fabp044_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp044_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp044_desc != g_fabp2_d_t.fabp044_desc OR g_fabp2_d_t.fabp044_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp044 = g_fabp2_d[l_ac].fabp044_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0201,g_fabp2_d[l_ac].fabp044_desc,g_glad.glad0202) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp044        = g_fabp2_d_t.fabp044
                        LET g_fabp2_d[l_ac].fabp044_desc = g_fabp2_d_t.fabp044_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp044,g_fabp2_d[l_ac].fabp044_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp044 = g_fabp2_d[l_ac].fabp044_desc
            LET g_fabp2_d[l_ac].fabp044_desc = s_desc_show1(g_fabp2_d[l_ac].fabp044,s_fin_get_accting_desc(g_glad.glad0201,g_fabp2_d[l_ac].fabp044))
            LET g_fabp2_d_t.fabp044_desc = g_fabp2_d[l_ac].fabp044_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp044,g_fabp2_d[l_ac].fabp044_desc

  
         
         #自由核算項五
         BEFORE FIELD fabp045_desc
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp045_desc=g_fabp2_d[l_ac].fabp045

         AFTER FIELD fabp045_desc 
            IF NOT cl_null(g_fabp2_d[l_ac].fabp045_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp045_desc != g_fabp2_d_t.fabp045_desc OR g_fabp2_d_t.fabp045_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp045 = g_fabp2_d[l_ac].fabp045_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0211,g_fabp2_d[l_ac].fabp045_desc,g_glad.glad0212) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp045        = g_fabp2_d_t.fabp045
                        LET g_fabp2_d[l_ac].fabp045_desc = g_fabp2_d_t.fabp045_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp045,g_fabp2_d[l_ac].fabp045_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp045 = g_fabp2_d[l_ac].fabp045_desc
            LET g_fabp2_d[l_ac].fabp045_desc = s_desc_show1(g_fabp2_d[l_ac].fabp045,s_fin_get_accting_desc(g_glad.glad0211,g_fabp2_d[l_ac].fabp045))
            LET g_fabp2_d_t.fabp045_desc = g_fabp2_d[l_ac].fabp045_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp045,g_fabp2_d[l_ac].fabp045_desc

            

         #自由核算項六
         BEFORE FIELD fabp046_desc
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp046_desc=g_fabp2_d[l_ac].fabp046
            
         AFTER FIELD fabp046_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp046_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp046_desc != g_fabp2_d_t.fabp046_desc OR g_fabp2_d_t.fabp046_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp046 = g_fabp2_d[l_ac].fabp046_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0221,g_fabp2_d[l_ac].fabp046_desc,g_glad.glad0222) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp046        = g_fabp2_d_t.fabp046
                        LET g_fabp2_d[l_ac].fabp046_desc = g_fabp2_d_t.fabp046_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp046,g_fabp2_d[l_ac].fabp046_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp046 = g_fabp2_d[l_ac].fabp046_desc
            LET g_fabp2_d[l_ac].fabp046_desc = s_desc_show1(g_fabp2_d[l_ac].fabp046,s_fin_get_accting_desc(g_glad.glad0221,g_fabp2_d[l_ac].fabp046))
            LET g_fabp2_d_t.fabp046_desc = g_fabp2_d[l_ac].fabp046_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp046,g_fabp2_d[l_ac].fabp046_desc

 
         
         #自由核算項七
         BEFORE FIELD fabp047_desc
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp047_desc=g_fabp2_d[l_ac].fabp047
         AFTER FIELD fabp047_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp047_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp047_desc != g_fabp2_d_t.fabp047_desc OR g_fabp2_d_t.fabp047_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp047 = g_fabp2_d[l_ac].fabp047_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0231,g_fabp2_d[l_ac].fabp047_desc,g_glad.glad0232) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp047        = g_fabp2_d_t.fabp047
                        LET g_fabp2_d[l_ac].fabp047_desc = g_fabp2_d_t.fabp047_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp047,g_fabp2_d[l_ac].fabp047_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp047 = g_fabp2_d[l_ac].fabp047_desc
            LET g_fabp2_d[l_ac].fabp047_desc = s_desc_show1(g_fabp2_d[l_ac].fabp047,s_fin_get_accting_desc(g_glad.glad0231,g_fabp2_d[l_ac].fabp047))
            LET g_fabp2_d_t.fabp047_desc = g_fabp2_d[l_ac].fabp047_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp047,g_fabp2_d[l_ac].fabp047_desc

   
         
         #自由核算項八
         BEFORE FIELD fabp048_desc
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp048_desc=g_fabp2_d[l_ac].fabp048
         AFTER FIELD fabp048_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp048_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp048_desc != g_fabp2_d_t.fabp048_desc OR g_fabp2_d_t.fabp048_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp048 = g_fabp2_d[l_ac].fabp048_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0241,g_fabp2_d[l_ac].fabp048_desc,g_glad.glad0242) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp048        = g_fabp2_d_t.fabp048
                        LET g_fabp2_d[l_ac].fabp048_desc = g_fabp2_d_t.fabp048_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp048,g_fabp2_d[l_ac].fabp048_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp048 = g_fabp2_d[l_ac].fabp048_desc
            LET g_fabp2_d[l_ac].fabp048_desc = s_desc_show1(g_fabp2_d[l_ac].fabp048,s_fin_get_accting_desc(g_glad.glad0241,g_fabp2_d[l_ac].fabp048))
            LET g_fabp2_d_t.fabp048_desc = g_fabp2_d[l_ac].fabp048_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp048,g_fabp2_d[l_ac].fabp048_desc

 
            
         #自由核算項九
         BEFORE FIELD fabp049_desc
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp049_desc=g_fabp2_d[l_ac].fabp049
         AFTER FIELD fabp049_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp049_desc) THEN
               IF ( g_fabp2_d[l_ac].fabp049_desc != g_fabp2_d_t.fabp049_desc OR g_fabp2_d_t.fabp049_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp049 = g_fabp2_d[l_ac].fabp049_desc
                
                     CALL s_voucher_free_account_chk(g_glad.glad0251,g_fabp2_d[l_ac].fabp049_desc,g_glad.glad0252) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp049        = g_fabp2_d_t.fabp049
                        LET g_fabp2_d[l_ac].fabp049_desc = g_fabp2_d_t.fabp049_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp049,g_fabp2_d[l_ac].fabp049_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp049 = g_fabp2_d[l_ac].fabp049_desc
            LET g_fabp2_d[l_ac].fabp049_desc = s_desc_show1(g_fabp2_d[l_ac].fabp049,s_fin_get_accting_desc(g_glad.glad0251,g_fabp2_d[l_ac].fabp049))
            LET g_fabp2_d_t.fabp049_desc = g_fabp2_d[l_ac].fabp049_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp049,g_fabp2_d[l_ac].fabp049_desc

   
         
         #自由核算項十
         BEFORE FIELD fabp050_desc
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_fabp2_d[l_ac].fabp050_desc=g_fabp2_d[l_ac].fabp050
         AFTER FIELD fabp050_desc
            IF NOT cl_null(g_fabp2_d[l_ac].fabp050_desc)  THEN
               IF ( g_fabp2_d[l_ac].fabp050_desc != g_fabp2_d_t.fabp050_desc OR g_fabp2_d_t.fabp050_desc IS NULL ) THEN
                  LET g_fabp2_d[l_ac].fabp050 = g_fabp2_d[l_ac].fabp050_desc
               
                     CALL s_voucher_free_account_chk(g_glad.glad0261,g_fabp2_d[l_ac].fabp050_desc,g_glad.glad0262) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabp2_d[l_ac].fabp050        = g_fabp2_d_t.fabp050
                        LET g_fabp2_d[l_ac].fabp050_desc = g_fabp2_d_t.fabp050_desc
                        DISPLAY BY NAME g_fabp2_d[l_ac].fabp050,g_fabp2_d[l_ac].fabp050_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabp2_d[l_ac].fabp050 = g_fabp2_d[l_ac].fabp050_desc
            LET g_fabp2_d[l_ac].fabp050_desc = s_desc_show1(g_fabp2_d[l_ac].fabp050,s_fin_get_accting_desc(g_glad.glad0261,g_fabp2_d[l_ac].fabp050))
            LET g_fabp2_d_t.fabp050_desc = g_fabp2_d[l_ac].fabp050_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp050,g_fabp2_d[l_ac].fabp050_desc

         #Ctrlp:input.c.page1_afat511_01.fabp037
         ON ACTION controlp INFIELD fabp037
            #add-point:ON ACTION controlp INFIELD fabp037

            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp027
         ON ACTION controlp INFIELD fabp027
         
         ON ACTION controlp INFIELD fabp027_desc
            #add-point:ON ACTION controlp INFIELD fabp027
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
#20150113 mod by chenying            
#            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_fabgdocdt,"' AND (ooed007 IS NULL OR ooed007 >='",g_fabgdocdt,"')"
#            CALL q_ooed004_1()                                #呼叫開窗
            LET g_qryparam.where ="ooefstus='Y'"
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'01',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            #CALL q_ooef001()                                           #161024-00008#4 
            CALL q_ooef001_1()                                         #161024-00008#4 
#20150113 mod by chenying               
            LET g_fabp2_d[l_ac].fabp027_desc = g_qryparam.return1              
 
            LET g_fabp2_d[l_ac].fabp027 = g_fabp2_d[l_ac].fabp027_desc
            DISPLAY BY NAME g_fabp2_d[l_ac].fabp027_desc               #

            NEXT FIELD fabp027_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp028
         ON ACTION controlp INFIELD fabp028
         
         ON ACTION controlp INFIELD fabp028_desc
            #add-point:ON ACTION controlp INFIELD fabp028
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp028             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_fabgdocdt
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
#            CALL q_ooeg001()   #20150113 mark by chenying                 
            CALL q_ooeg001_4()  #20150113 add by chenying
            
            LET g_fabp2_d[l_ac].fabp028 = g_qryparam.return1  
            LET g_fabp2_d[l_ac].fabp028_desc = g_fabp2_d[l_ac].fabp028            
            #LET g_fabp2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp028_desc TO fabp028_desc              #
            #DISPLAY g_fabp2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabp028_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp029
         ON ACTION controlp INFIELD fabp029
         
         ON ACTION controlp INFIELD fabp029_desc
            #add-point:ON ACTION controlp INFIELD fabp029
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
#20150113 mod by chenying            
#            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_fabgdocdt,"' AND (ooed007 IS NULL OR ooed007 >='",g_fabgdocdt,"')"
#            
#            CALL q_ooed004_1()  
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            LET g_qryparam.arg1 = g_fabgdocdt
            #CALL q_ooeg001_5()                #呼叫開窗   #161221-00054#4 MARK xul
            CALL q_ooeg001_15()       #161221-00054#4 add xul      
#20150113 mod by chenying 
            LET g_fabp2_d[l_ac].fabp029 = g_qryparam.return1              
            LET g_fabp2_d[l_ac].fabp029_desc = g_fabp2_d[l_ac].fabp029
            DISPLAY g_fabp2_d[l_ac].fabp029_desc TO fabp029_desc              #

            NEXT FIELD fabp029_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp030
         ON ACTION controlp INFIELD fabp030
         
         ON ACTION controlp INFIELD fabp030_desc
            #add-point:ON ACTION controlp INFIELD fabp030
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp030             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].oocq002 #應用分類碼
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#20150113 mod by chenying            
#            LET g_qryparam.arg1 = "287" #
#            CALL q_oocq002()                                #呼叫開窗
            CALL q_oocq002_287()
#20150113 mod by chenying 
            LET g_fabp2_d[l_ac].fabp030 = g_qryparam.return1
            LET g_fabp2_d[l_ac].fabp030_desc = g_fabp2_d[l_ac].fabp030            
            #LET g_fabp2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp030_desc TO fabp030_desc              #
            #DISPLAY g_fabp2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp030_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp031
         ON ACTION controlp INFIELD fabp031
         
         ON ACTION controlp INFIELD fabp031_desc
            #add-point:ON ACTION controlp INFIELD fabp031
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp2_d[l_ac].fabp031 = g_qryparam.return1              
            LET g_fabp2_d[l_ac].fabp031_desc = g_fabp2_d[l_ac].fabp031 
            DISPLAY g_fabp2_d[l_ac].fabp031_desc TO fabp031_desc              #

            NEXT FIELD fabp031_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp032
         ON ACTION controlp INFIELD fabp032
         
         ON ACTION controlp INFIELD fabp032_desc
            #add-point:ON ACTION controlp INFIELD fabp032
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
           CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗

            LET g_fabp2_d[l_ac].fabp032 = g_qryparam.return1              
            LET g_fabp2_d[l_ac].fabp032_desc = g_fabp2_d[l_ac].fabp032
            DISPLAY g_fabp2_d[l_ac].fabp032_desc TO fabp032_desc              #

            NEXT FIELD fabp032_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp033
         ON ACTION controlp INFIELD fabp033
         
         ON ACTION controlp INFIELD fabp033_desc
            #add-point:ON ACTION controlp INFIELD fabp033
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp033             #給予default值
            LET g_qryparam.default2 = "" #g_fabp2_d[l_ac].oocq002 #應用分類碼
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#            LET g_qryparam.arg1 = "281"  #20150113 mark by chenying
#            CALL q_oocq002()             #20150113 mark by chenying                    
            CALL q_oocq002_281()          #20150113 add by chenying
            LET g_fabp2_d[l_ac].fabp033 = g_qryparam.return1 
            LET g_fabp2_d[l_ac].fabp033_desc = g_fabp2_d[l_ac].fabp033            
            #LET g_fabp2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabp2_d[l_ac].fabp033_desc TO fabp033_desc              #
            #DISPLAY g_fabp2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabp033_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp034
         ON ACTION controlp INFIELD fabp034
         
         ON ACTION controlp INFIELD fabp034_desc
            #add-point:ON ACTION controlp INFIELD fabp034
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
#            CALL q_ooag001()   #20150113 mark by chenying                            #呼叫開窗
            CALL q_ooag001_8()  #20150113 add by chenying
            
            LET g_fabp2_d[l_ac].fabp034 = g_qryparam.return1              
            LET g_fabp2_d[l_ac].fabp034_desc = g_fabp2_d[l_ac].fabp034
            DISPLAY g_fabp2_d[l_ac].fabp034_desc TO fabp034_desc              #

            NEXT FIELD fabp034_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp035
         ON ACTION controlp INFIELD fabp035
         
         ON ACTION controlp INFIELD fabp035_desc 
            #add-point:ON ACTION controlp INFIELD fabp035
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp035             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabp2_d[l_ac].fabp035 = g_qryparam.return1   
            LET g_fabp2_d[l_ac].fabp035_desc = g_fabp2_d[l_ac].fabp035            
            DISPLAY g_fabp2_d[l_ac].fabp035_desc TO fabp035_desc              #

            NEXT FIELD fabp035_desc                        #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat511_01.fabp036
         ON ACTION controlp INFIELD fabp036
         
         #20150113 add by chenying
         ON ACTION controlp INFIELD fabp036_desc
            #add-point:ON ACTION controlp INFIELD fabp036
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp036             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_fabp2_d[l_ac].fabp035

            
#            CALL q_pjbb002_2()                                #呼叫開窗

            IF NOT cl_null(g_fabp2_d[l_ac].fabp035) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fabp2_d[l_ac].fabp035,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_pjbb002()             #呼叫開窗

            LET g_fabp2_d[l_ac].fabp036 = g_qryparam.return1              
            LET g_fabp2_d[l_ac].fabp036_desc = g_fabp2_d[l_ac].fabp036 
            DISPLAY g_fabp2_d[l_ac].fabp036_desc TO fabp036_desc            #

            NEXT FIELD fabp036_desc                
         
         
         ON ACTION controlp INFIELD fabp039_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp039
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_oojd001_2()
            LET g_fabp2_d[l_ac].fabp039 = g_qryparam.return1
            LET g_fabp2_d[l_ac].fabp039_desc = g_fabp2_d[l_ac].fabp039
            DISPLAY g_fabp2_d[l_ac].fabp039_desc TO fabp039_desc
            NEXT FIELD fabp039_desc 

         ON ACTION controlp INFIELD fabp040_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp040
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_oocq002_2002()
            LET g_fabp2_d[l_ac].fabp040 = g_qryparam.return1
            LET g_fabp2_d[l_ac].fabp040_desc = g_fabp2_d[l_ac].fabp040
            DISPLAY g_fabp2_d[l_ac].fabp040_desc TO fabp040_desc
            NEXT FIELD fabp040_desc 
          
         #自由核算项（一~十）
         ON ACTION controlp INFIELD fabp041_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp041_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp041        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp041_desc = g_fabp2_d[l_ac].fabp041
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp041 ,g_fabp2_d[l_ac].fabp041_desc
               NEXT FIELD fabp041_desc
            END IF  
            
         ON ACTION controlp INFIELD fabp042_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp042_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp042        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp042_desc = g_fabp2_d[l_ac].fabp042
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp042 ,g_fabp2_d[l_ac].fabp042_desc
               NEXT FIELD fabp042_desc
            END IF   

         ON ACTION controlp INFIELD fabp043_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp043_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp043        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp043_desc = g_fabp2_d[l_ac].fabp043
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp043 ,g_fabp2_d[l_ac].fabp043_desc
               NEXT FIELD fabp043_desc
            END IF  
            
         ON ACTION controlp INFIELD fabp044_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp044_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp044        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp044_desc = g_fabp2_d[l_ac].fabp044
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp044 ,g_fabp2_d[l_ac].fabp044_desc
               NEXT FIELD fabp044_desc
            END IF   

         ON ACTION controlp INFIELD fabp045_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp045_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp045        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp045_desc = g_fabp2_d[l_ac].fabp045
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp045 ,g_fabp2_d[l_ac].fabp045_desc
               NEXT FIELD fabp045_desc
            END IF  
            
         ON ACTION controlp INFIELD fabp046_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp046_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp046        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp046_desc = g_fabp2_d[l_ac].fabp046
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp046 ,g_fabp2_d[l_ac].fabp046_desc
               NEXT FIELD fabp046_desc
            END IF 

         ON ACTION controlp INFIELD fabp047_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp047_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp047        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp047_desc = g_fabp2_d[l_ac].fabp047
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp047 ,g_fabp2_d[l_ac].fabp047_desc
               NEXT FIELD fabp047_desc
            END IF  

         ON ACTION controlp INFIELD fabp048_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp048_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp048        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp048_desc = g_fabp2_d[l_ac].fabp048
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp048 ,g_fabp2_d[l_ac].fabp048_desc
               NEXT FIELD fabp048_desc
            END IF

         ON ACTION controlp INFIELD fabp049_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp049_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp049        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp049_desc = g_fabp2_d[l_ac].fabp049
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp049 ,g_fabp2_d[l_ac].fabp049_desc
               NEXT FIELD fabp049_desc
            END IF 

         ON ACTION controlp INFIELD fabp050_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabp2_d[l_ac].fabp050_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabp2_d[l_ac].fabp050        = g_qryparam.return1
               LET g_fabp2_d[l_ac].fabp050_desc = g_fabp2_d[l_ac].fabp050
               DISPLAY BY NAME g_fabp2_d[l_ac].fabp050 ,g_fabp2_d[l_ac].fabp050_desc
               NEXT FIELD fabp050_desc
            END IF      
         #20150113 add by chenying
         
         
         AFTER ROW
            #add-point:單身page2 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabp2_d[l_ac].* = g_fabp2_d_t.*
               END IF
               CLOSE afat511_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            IF cl_null(g_fabp2_d[l_ac].fabp027) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afa-00451' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()   
               NEXT FIELD fabp027
            END IF 
            #其他table進行unlock
            
            CALL afat511_01_unlock_b("fabp_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input
            IF cl_null(g_fabp2_d[l_ac].fabp027) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afa-00451' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()   
               NEXT FIELD fabp027
            END IF 
            LET g_fabp_d2.* = g_fabp2_d.*
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_fabp2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabp2_d.getLength()+1
 
      END INPUT
END DIALOG

################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL afat511_01_construct()
# Modify.........:
################################################################################
DIALOG afat511_01_construct()

   CONSTRUCT g_wc_subject ON fabp037,fabp027,fabp027_desc,fabp028,fabp028_desc,fabp029,fabp029_desc,
                             fabp030,fabp030_desc,fabp031,fabp031_desc,fabp032,fabp032_desc,
                             fabp033,fabp033_desc,fabp034,fabp034_desc,fabp035,fabp035_desc,fabp036,fabp036_desc,
                             fabp038,fabp039,fabp039_desc,fabp040,fabp040_desc
                       

        FROM s_detail1_afat511_01[1].fabp037,
             s_detail1_afat511_01[1].fabp027,s_detail1_afat511_01[1].fabp027_desc,
             s_detail1_afat511_01[1].fabp028,s_detail1_afat511_01[1].fabp028_desc,
             s_detail1_afat511_01[1].fabp029,s_detail1_afat511_01[1].fabp029_desc,
             s_detail1_afat511_01[1].fabp030,s_detail1_afat511_01[1].fabp030_desc,
             s_detail1_afat511_01[1].fabp031,s_detail1_afat511_01[1].fabp031_desc,
             s_detail1_afat511_01[1].fabp032,s_detail1_afat511_01[1].fabp032_desc,
             s_detail1_afat511_01[1].fabp033,s_detail1_afat511_01[1].fabp033_desc,
             s_detail1_afat511_01[1].fabp034,s_detail1_afat511_01[1].fabp034_desc,
             s_detail1_afat511_01[1].fabp035,s_detail1_afat511_01[1].fabp035_desc,
             s_detail1_afat511_01[1].fabp036,s_detail1_afat511_01[1].fabp036_desc,
             s_detail1_afat511_01[1].fabp038, 
             s_detail1_afat511_01[1].fabp039,s_detail1_afat511_01[1].fabp039_desc,
             s_detail1_afat511_01[1].fabp040,s_detail1_afat511_01[1].fabp040_desc
             
      BEFORE CONSTRUCT
         SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
         
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp037
            #add-point:BEFORE FIELD fabp037

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp037
            
            #add-point:AFTER FIELD fabp037

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp037
         ON ACTION controlp INFIELD fabp037
            #add-point:ON ACTION controlp INFIELD fabp037

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp027
            #add-point:BEFORE FIELD fabp027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp027
            
            #add-point:AFTER FIELD fabp027

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp027
         ON ACTION controlp INFIELD fabp027
         
         ON ACTION controlp INFIELD fabp027_desc
            #add-point:ON ACTION controlp INFIELD fabp027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()
            CALL q_ooef001_1()                                         #161024-00008#4 
            DISPLAY g_qryparam.return1 TO fabp027_desc  #顯示到畫面上
            NEXT FIELD fabp027_desc                     #返回原欄位            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp028
            #add-point:BEFORE FIELD fabp028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp028
            
            #add-point:AFTER FIELD fabp028

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp028
         ON ACTION controlp INFIELD fabp028
         
         ON ACTION controlp INFIELD fabp028_desc
            #add-point:ON ACTION controlp INFIELD fabp028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying            
#            CALL q_ooeg001()
            LET g_qryparam.arg1 = g_today    
            CALL q_ooeg001_4()
#20150113 mod by chenying                
            DISPLAY g_qryparam.return1 TO fabp028_desc  #顯示到畫面上
            NEXT FIELD fabp028_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp029
            #add-point:BEFORE FIELD fabp029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp029
            
            #add-point:AFTER FIELD fabp029

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp029
         ON ACTION controlp INFIELD fabp029
         
         ON ACTION controlp INFIELD fabp029_desc
            #add-point:ON ACTION controlp INFIELD fabp029
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying              
#            CALL q_ooef001()
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            LET g_qryparam.arg1 = g_today
            #CALL q_ooeg001_5()                #呼叫開窗   #161221-00054#4 MARK xul
            CALL q_ooeg001_15()       #161221-00054#4 add xul      
#20150113 mod by chenying             
            DISPLAY g_qryparam.return1 TO fabp029_desc  #顯示到畫面上
            NEXT FIELD fabp029_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp030
            #add-point:BEFORE FIELD fabp030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp030
            
            #add-point:AFTER FIELD fabp030

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp030
         ON ACTION controlp INFIELD fabp030
         
         ON ACTION controlp INFIELD fabp030_desc
            #add-point:ON ACTION controlp INFIELD fabp030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying            
#            LET g_qryparam.arg1 = "287"  
#            CALL q_oocq002()                                
            CALL q_oocq002_287()
#20150113 mod by chenying 
            DISPLAY g_qryparam.return1 TO fabp030_desc  #顯示到畫面上
            NEXT FIELD fabp030_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp031
            #add-point:BEFORE FIELD fabp031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp031
            
            #add-point:AFTER FIELD fabp031

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp031
         ON ACTION controlp INFIELD fabp031
         
         ON ACTION controlp INFIELD fabp031_desc
            #add-point:ON ACTION controlp INFIELD fabp031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabp031_desc  #顯示到畫面上
            NEXT FIELD fabp031_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp032
            #add-point:BEFORE FIELD fabp032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp032
            
            #add-point:AFTER FIELD fabp032

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp032
         ON ACTION controlp INFIELD fabp032
         
         ON ACTION controlp INFIELD fabp032_desc
            #add-point:ON ACTION controlp INFIELD fabp032
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#1  ADD 
           # CALL q_pmaa001()      #160913-00017#1 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabp032_desc  #顯示到畫面上
            NEXT FIELD fabp032_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp033
            #add-point:BEFORE FIELD fabp033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp033
            
            #add-point:AFTER FIELD fabp033

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp033
         ON ACTION controlp INFIELD fabp033
         
         ON ACTION controlp INFIELD fabp033_desc
            #add-point:ON ACTION controlp INFIELD fabp033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = "281"  #20150113 mark by chenying
#            CALL q_oocq002()             #20150113 mark by chenying                    
            CALL q_oocq002_281()          #20150113 add by chenying
            DISPLAY g_qryparam.return1 TO fabp033_desc  #顯示到畫面上
            NEXT FIELD fabp033_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp034
            #add-point:BEFORE FIELD fabp034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp034
            
            #add-point:AFTER FIELD fabp034

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp034
         ON ACTION controlp INFIELD fabp034
         
         ON ACTION controlp INFIELD fabp034_desc
            #add-point:ON ACTION controlp INFIELD fabp034
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooag001()   #20150113 mark by chenying                            #呼叫開窗
            CALL q_ooag001_8()  #20150113 add by chenying
            DISPLAY g_qryparam.return1 TO fabp034_desc  #顯示到畫面上
            NEXT FIELD fabp034_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp035
            #add-point:BEFORE FIELD fabp035

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp035
            
            #add-point:AFTER FIELD fabp035

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabp035
         ON ACTION controlp INFIELD fabp035
         
         ON ACTION controlp INFIELD fabp035_desc
            #add-point:ON ACTION controlp INFIELD fabp035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO fabp035_desc  #顯示到畫面上
            NEXT FIELD fabp035_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabp036
            #add-point:BEFORE FIELD fabp036

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabp036
            
            #add-point:AFTER FIELD fabp036

            #END add-point
            
         #20150113 add by chenying
         #Ctrlp:construct.c.page2.fabp036
         ON ACTION controlp INFIELD fabp036_desc
            #add-point:ON ACTION controlp INFIELD fabp036
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_2()
            DISPLAY g_qryparam.return1 TO fabp036_desc  #顯示到畫面上
            NEXT FIELD fabp036_desc
            #END add-point

         ON ACTION controlp INFIELD fabp039_desc
            #add-point:ON ACTION controlp INFIELD fabp039
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO fabp039_desc  #顯示到畫面上
            NEXT FIELD fabp039_desc
            #END add-point
 
         ON ACTION controlp INFIELD fabp040_desc
            #add-point:ON ACTION controlp INFIELD fabp040
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO fabp040_desc  #顯示到畫面上
            NEXT FIELD fabp040_desc
            #END add-point 
         #20150113 add by chenying   
   END CONSTRUCT            
END DIALOG

 
{</section>}
 
{<section id="afat511_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 顯示單身
# Memo...........:
# Usage..........: CALL afat511_01_b_fill()
# Modify.........:
################################################################################
PUBLIC FUNCTION afat511_01_b_fill()
   DEFINE p_wc2      STRING
   #161111-00028#8----modify----begin---------
   #DEFINE g_glad                RECORD LIKE glad_t.*
   DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161111-00028#8----modify----end---------
   
   SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
   CALL g_fabp2_d.clear()
      
   LET g_sql = "SELECT  UNIQUE fabpseq,fabp037,fabp027, 
               fabp028,fabp029,fabp030,fabp031,fabp032,fabp033,fabp034,fabp035,fabp036,
               fabp038,fabp039,fabp040,fabp041,fabp042,fabp043,fabp044,fabp045,fabp046,
               fabp047,fabp048,fabp049,fabp050
               FROM fabp_t",   
               " INNER JOIN fabg_t ON fabgld = fabpld AND fabgent = fabpent ",#161221-00054#4 add AND fabgent = fabpent
               " AND fabgdocno = fabpdocno ",
               " WHERE fabpent=? AND fabpld=? AND fabpdocno=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF NOT cl_null(g_wc_d) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_d CLIPPED
   END IF
   
   #子單身的WC
   
   LET g_sql = g_sql, " ORDER BY fabp_t.fabpseq"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat511_01_pb2 FROM g_sql
   DECLARE b_fill2_cs CURSOR FOR afat511_01_pb2
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill2_cs USING g_enterprise,g_fabgld,g_fabgdocno
                                            
   FOREACH b_fill2_cs INTO g_fabp2_d[l_ac].fabpseq,g_fabp2_d[l_ac].fabp037, 
       g_fabp2_d[l_ac].fabp027,g_fabp2_d[l_ac].fabp028,g_fabp2_d[l_ac].fabp029,g_fabp2_d[l_ac].fabp030, 
       g_fabp2_d[l_ac].fabp031,g_fabp2_d[l_ac].fabp032,g_fabp2_d[l_ac].fabp033,g_fabp2_d[l_ac].fabp034, 
       g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp036,g_fabp2_d[l_ac].fabp038,
       g_fabp2_d[l_ac].fabp039,g_fabp2_d[l_ac].fabp040, g_fabp2_d[l_ac].fabp041,g_fabp2_d[l_ac].fabp042,
       g_fabp2_d[l_ac].fabp043,g_fabp2_d[l_ac].fabp044, g_fabp2_d[l_ac].fabp045,g_fabp2_d[l_ac].fabp046,
       g_fabp2_d[l_ac].fabp047,g_fabp2_d[l_ac].fabp048,g_fabp2_d[l_ac].fabp049,g_fabp2_d[l_ac].fabp050
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      CALL afat511_01_b_ref()
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   LET l_ac=l_ac-1
   CALL g_fabp2_d.deleteElement(g_fabp2_d.getLength())
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   LET g_fabp_d2.* = g_fabp2_d.*
   FREE afat511_01_pb2
END FUNCTION

################################################################################
# Descriptions...: 連動lock其他單身table資料
# Memo...........:
# Usage..........: CALL afat511_01_lock_b(ps_table,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "fabp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat511_01_bcl USING g_enterprise,
                                       g_fabgld,g_fabgdocno,g_fabp2_d[g_detail_idx].fabpseq 
#      OPEN afat511_01_bcl USING g_enterprise,
#                                       g_fabgld,g_fafaaj001,g_faaj002,g_faaj037
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat511_01_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 刪除單身後其他table連動
# Memo...........:
# Usage..........: CALL afat511_01_delete_b(ps_table,ps_keys_bak,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
 
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
    
      DELETE FROM fabp_t
       WHERE fabpent = g_enterprise AND
         fabpld = ps_keys_bak[1] AND fabpdocno = ps_keys_bak[2] AND fabpseq = ps_keys_bak[3]
         
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
# Descriptions...: 修改單身後其他table連動
# Memo...........:
# Usage..........: CALL afat511_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabp_t" THEN
      
      UPDATE fabp_t 
         SET (fabpld,fabpdocno,
              fabpseq
              ,fabp037,fabp027,fabp028,fabp029,fabp030,fabp031,fabp032,fabp033,fabp034,fabp035,fabp036,
              fabp038,fabp039,fabp040,fabp041,fabp042,fabp043,fabp044,fabp045,fabp046,fabp047,fabp048,fabp049,fabp050) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabp2_d[g_detail_idx].fabp037, 
                  g_fabp2_d[g_detail_idx].fabp027,g_fabp2_d[g_detail_idx].fabp028,g_fabp2_d[g_detail_idx].fabp029, 
                  g_fabp2_d[g_detail_idx].fabp030,g_fabp2_d[g_detail_idx].fabp031,g_fabp2_d[g_detail_idx].fabp032, 
                  g_fabp2_d[g_detail_idx].fabp033,g_fabp2_d[g_detail_idx].fabp034,g_fabp2_d[g_detail_idx].fabp035, 
                  g_fabp2_d[g_detail_idx].fabp036,g_fabp2_d[g_detail_idx].fabp038,g_fabp2_d[g_detail_idx].fabp039,
                  g_fabp2_d[g_detail_idx].fabp040,g_fabp2_d[g_detail_idx].fabp041,g_fabp2_d[g_detail_idx].fabp042,
                  g_fabp2_d[g_detail_idx].fabp043,g_fabp2_d[g_detail_idx].fabp044,g_fabp2_d[g_detail_idx].fabp045,
                  g_fabp2_d[g_detail_idx].fabp046,g_fabp2_d[g_detail_idx].fabp047,g_fabp2_d[g_detail_idx].fabp048,
                  g_fabp2_d[g_detail_idx].fabp049,g_fabp2_d[g_detail_idx].fabp050
                  ) 
         WHERE fabpent = g_enterprise AND fabpld = ps_keys_bak[1] AND fabpdocno = ps_keys_bak[2] AND fabpseq = ps_keys_bak[3]
      
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabp_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabp_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 連動unlock其他單身table資料
# Memo...........:
# Usage..........: CALL afat511_01_unlock_b(ps_table,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   
   
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat511_01_bcl
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 部門檢查
# Memo...........:
# Usage..........: CALL afat511_01_fabp028_chk(p_fabp028)
#                  RETURNING g_errno
# Input parameter: p_fabp028    部門編號
# Return code....: g_errno      錯誤代碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp028_chk(p_fabp028)
   DEFINE p_fabp028      LIKE fabp_t.fabp028
   DEFINE l_ooegstus     LIKE ooeg_t.ooegstus
   
   LET g_errno = ''
   
   SELECT ooegstus INTO l_ooegstus FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = p_fabp028
      AND ooeg006 <= g_fabgdocdt
      AND (ooeg007 IS NULL OR ooeg007 >= g_fabgdocdt ) 
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'abm-00006'
      WHEN l_ooegstus = 'N'       LET g_errno = 'sub-01302'  #'abm-00007'#160318-00005#11 mod
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 區域/客群編號檢核
# Memo...........:
# Usage..........: CALL afat511_01_fabp030_chk(p_oocq001,p_oocq002)
# Input parameter: p_oocq001      應用分類類型
#                : p_oocq002      應用分類碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp030_chk(p_oocq001,p_oocq002)
   DEFINE p_oocq001     LIKE oocq_t.oocq001
   DEFINE p_oocq002     LIKE oocq_t.oocq002
   DEFINE l_oocqstus     LIKE oocq_t.oocqstus
   
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002
   CASE
     WHEN SQLCA.SQLCODE = 100 
        IF p_oocq001 = '287' THEN      
           LET g_errno = 'sub-01302' #'apm-00092'#160318-00005#11 mod 
        ELSE
           LET g_errno = 'axm-00003'  
        END IF 
     
     WHEN l_oocqstus = 'N'
        IF p_oocq001 = '287' THEN    
           LET g_errno = 'sub-01302' #'apm-00093' #160318-00005#11 mod
        ELSE
           LET g_errno = 'sub-01302' #'axm-00004' #160318-00005#11 mod
        END IF       
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 客商編號檢查
# Memo...........:
# Usage..........: CALL afat511_01_fabp031_chk(p_pmaa001)
# Input parameter: p_pmaa001     客商編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp031_chk(p_pmaa001)
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   LET g_errno = ''
   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_pmaa001

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00028'
      WHEN l_pmaastus = 'N'      LET g_errno = 'sub-01302'  #'apm-00029'#160318-00005#11 mod 
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 人員編號檢查
# Memo...........:
# Usage..........: CALL afat511_01_fabp034_chk(p_fabp034)
# Input parameter: p_fabp034     人員編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp034_chk(p_fabp034)
   DEFINE p_fabp034    LIKE fabp_t.fabp034
   DEFINE l_ooagstus   LIKE ooag_t.ooagstus


   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_fabp034

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302' #'aoo-00071'#160318-00005#11 mod  
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 組織說明
# Memo...........:
# Usage..........: CALL afat511_01_ooefl003(p_ooefl001)
# Input parameter: p_ooefl001     組織編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp027_desc(p_ooefl001)
   DEFINE p_ooefl001       LIKE ooefl_t.ooefl001
   DEFINE r_desc           LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooefl001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 區域/客群說明
# Memo...........:
# Usage..........: CALL afat511_01_fabp030_desc(p_oocql001,p_oocql002)
#                  RETURNING 回传参数
# Input parameter: p_oocql001     應用分類
#                : p_oocql002     應用分類碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp030_desc(p_oocql001,p_oocql002)
   DEFINE p_oocql001         LIKE oocql_t.oocql001
   DEFINE p_oocql002         LIKE oocql_t.oocql002
   DEFINE r_desc             LIKE oocql_t.oocql004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocql001
   LET g_ref_fields[1] = p_oocql002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= ? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 客戶名稱
# Memo...........:
# Usage..........: CALL afat511_01_fabp031_desc(p_pmaal001)
# Input parameter: p_pmaal001     客戶編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp031_desc(p_pmaal001)
   DEFINE p_pmaal001     LIKE pmaal_t.pmaal001
   DEFINE r_desc         LIKE pmaal_t.pmaal004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaal001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 姓名
# Memo...........:
# Usage..........: CALL afat511_01_fabp034_desc(p_fabp034)
# Input parameter: p_fabp034      與昂編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp034_desc(p_fabp034)
   DEFINE p_fabp034     LIKE fabp_t.fabp034
   DEFINE r_ooag011     LIKE ooag_t.ooag011
   
   SELECT ooag011 INTO r_ooag011 FROM ooag_t
   WHERE ooagent=g_enterprise AND ooag001=p_fabp034
   
   RETURN r_ooag011
END FUNCTION

#+欄位說明
PRIVATE FUNCTION afat511_01_b_ref()
#161111-00028#8----modify----begin---------
   #DEFINE g_glad                RECORD LIKE glad_t.*
   DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161111-00028#8----modify----end---------

   #營運中心
   CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp027) RETURNING g_fabp2_d[l_ac].fabp027_desc
   LET g_fabp2_d[l_ac].fabp027_desc=g_fabp2_d[l_ac].fabp027,g_fabp2_d[l_ac].fabp027_desc
   #部門
   CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp028) RETURNING g_fabp2_d[l_ac].fabp028_desc
   LET g_fabp2_d[l_ac].fabp028_desc=g_fabp2_d[l_ac].fabp028,g_fabp2_d[l_ac].fabp028_desc
   #利潤中心
   CALL afat511_01_fabp027_desc(g_fabp2_d[l_ac].fabp029) RETURNING g_fabp2_d[l_ac].fabp029_desc
   LET g_fabp2_d[l_ac].fabp029_desc=g_fabp2_d[l_ac].fabp029,g_fabp2_d[l_ac].fabp029_desc
   #區域
   CALL afat511_01_fabp040_desc("287",g_fabp2_d[l_ac].fabp030) RETURNING g_fabp2_d[l_ac].fabp030_desc
   LET g_fabp2_d[l_ac].fabp030_desc=g_fabp2_d[l_ac].fabp030,g_fabp2_d[l_ac].fabp030_desc
   #交易客戶
   CALL afat511_01_fabp031_desc(g_fabp2_d[l_ac].fabp031) RETURNING g_fabp2_d[l_ac].fabp031_desc
   LET g_fabp2_d[l_ac].fabp031_desc=g_fabp2_d[l_ac].fabp031,g_fabp2_d[l_ac].fabp031_desc
   #帳款客戶
   CALL afat511_01_fabp031_desc(g_fabp2_d[l_ac].fabp032) RETURNING g_fabp2_d[l_ac].fabp032_desc
   LET g_fabp2_d[l_ac].fabp032_desc=g_fabp2_d[l_ac].fabp032,g_fabp2_d[l_ac].fabp032_desc
   #客群
   CALL afat511_01_fabp040_desc("281",g_fabp2_d[l_ac].fabp033) RETURNING g_fabp2_d[l_ac].fabp033_desc
   LET g_fabp2_d[l_ac].fabp033_desc=g_fabp2_d[l_ac].fabp033,g_fabp2_d[l_ac].fabp033_desc
   #人員
   CALL afat511_01_fabp034_desc(g_fabp2_d[l_ac].fabp034) RETURNING g_fabp2_d[l_ac].fabp034_desc
   LET g_fabp2_d[l_ac].fabp034_desc=g_fabp2_d[l_ac].fabp034,g_fabp2_d[l_ac].fabp034_desc
   #專案編號
   CALL afat511_01_fabp035_desc(g_fabp2_d[l_ac].fabp035) RETURNING g_fabp2_d[l_ac].fabp035_desc
   LET g_fabp2_d[l_ac].fabp035_desc=g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp035_desc
   #20150113 add by chenying
   #WBS
   CALL afat511_01_fabp036_desc(g_fabp2_d[l_ac].fabp035,g_fabp2_d[l_ac].fabp036) RETURNING g_fabp2_d[l_ac].fabp036_desc
   LET g_fabp2_d[l_ac].fabp036_desc=g_fabp2_d[l_ac].fabp036,g_fabp2_d[l_ac].fabp036_desc  
   #渠道
   CALL afat511_01_fabp039_desc(g_fabp2_d[l_ac].fabp039)  RETURNING g_fabp2_d[l_ac].fabp039_desc
   LET g_fabp2_d[l_ac].fabp039_desc=g_fabp2_d[l_ac].fabp039,g_fabp2_d[l_ac].fabp039_desc  
   #品牌
   CALL afat511_01_fabp040_desc('2002',g_fabp2_d[l_ac].fabp040) RETURNING g_fabp2_d[l_ac].fabp040_desc
   LET g_fabp2_d[l_ac].fabp040_desc=g_fabp2_d[l_ac].fabp040,g_fabp2_d[l_ac].fabp040_desc   
   CALL cl_set_combo_scc('fabp038','6013')
   
   IF g_glad.glad017 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp041) THEN
      LET g_fabp2_d[l_ac].fabp041_desc = s_desc_show1(g_fabp2_d[l_ac].fabp041,s_fin_get_accting_desc(g_glad.glad0171,g_fabp2_d[l_ac].fabp041))
   END IF
   IF g_glad.glad018 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp042) THEN
      LET g_fabp2_d[l_ac].fabp042_desc = s_desc_show1(g_fabp2_d[l_ac].fabp042,s_fin_get_accting_desc(g_glad.glad0181,g_fabp2_d[l_ac].fabp042))
   END IF
   IF g_glad.glad019 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp043) THEN
      LET g_fabp2_d[l_ac].fabp043_desc = s_desc_show1(g_fabp2_d[l_ac].fabp043,s_fin_get_accting_desc(g_glad.glad0191,g_fabp2_d[l_ac].fabp043))
   END IF
   IF g_glad.glad020 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp044) THEN
      LET g_fabp2_d[l_ac].fabp044_desc = s_desc_show1(g_fabp2_d[l_ac].fabp044,s_fin_get_accting_desc(g_glad.glad0201,g_fabp2_d[l_ac].fabp044))
   END IF
   IF g_glad.glad021 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp045) THEN
      LET g_fabp2_d[l_ac].fabp045_desc = s_desc_show1(g_fabp2_d[l_ac].fabp045,s_fin_get_accting_desc(g_glad.glad0211,g_fabp2_d[l_ac].fabp045))
   END IF
   IF g_glad.glad022 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp046) THEN   
      LET g_fabp2_d[l_ac].fabp046_desc = s_desc_show1(g_fabp2_d[l_ac].fabp046,s_fin_get_accting_desc(g_glad.glad0221,g_fabp2_d[l_ac].fabp046))
   END IF
   IF g_glad.glad023 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp047) THEN
      LET g_fabp2_d[l_ac].fabp047_desc = s_desc_show1(g_fabp2_d[l_ac].fabp047,s_fin_get_accting_desc(g_glad.glad0231,g_fabp2_d[l_ac].fabp047))
   END IF
   IF g_glad.glad024 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp048) THEN   
      LET g_fabp2_d[l_ac].fabp048_desc = s_desc_show1(g_fabp2_d[l_ac].fabp048,s_fin_get_accting_desc(g_glad.glad0241,g_fabp2_d[l_ac].fabp048))
   END IF
   IF g_glad.glad025 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp049) THEN   
      LET g_fabp2_d[l_ac].fabp049_desc = s_desc_show1(g_fabp2_d[l_ac].fabp049,s_fin_get_accting_desc(g_glad.glad0251,g_fabp2_d[l_ac].fabp049))
   END IF
   IF g_glad.glad026 = 'Y' AND NOT cl_null(g_fabp2_d[l_ac].fabp050) THEN   
      LET g_fabp2_d[l_ac].fabp050_desc = s_desc_show1(g_fabp2_d[l_ac].fabp050,s_fin_get_accting_desc(g_glad.glad0261,g_fabp2_d[l_ac].fabp050))
   END IF   
   #20150113 add by chenying
   
   DISPLAY BY NAME g_fabp2_d[l_ac].fabp027_desc,g_fabp2_d[l_ac].fabp028_desc,
      g_fabp2_d[l_ac].fabp029_desc,g_fabp2_d[l_ac].fabp030_desc,g_fabp2_d[l_ac].fabp031_desc,
      g_fabp2_d[l_ac].fabp032_desc,g_fabp2_d[l_ac].fabp033_desc,g_fabp2_d[l_ac].fabp034_desc,
      g_fabp2_d[l_ac].fabp035_desc,
      g_fabp2_d[l_ac].fabp038,g_fabp2_d[l_ac].fabp036_desc,g_fabp2_d[l_ac].fabp039_desc,g_fabp2_d[l_ac].fabp040_desc #20150113 add by chenying
END FUNCTION

################################################################################
# Descriptions...: 專案說明
# Memo...........:
# Usage..........: CALL afat511_01_fabp035_desc(p_fabp035)
#                  RETURNING r_desc
# Input parameter: p_fabp035   專案編號
# Return code....: r_desc      說明
# Date & Author..: 2014/8/7 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp035_desc(p_fabp035)
   DEFINE p_fabp035      LIKE fabp_t.fabp035
   DEFINE r_desc         LIKE pjbal_t.pjbal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabp035
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat511_01_fabp036_desc(p_fabp035,p_fabp036)
# Input parameter:  
# Date & Author..: 20150113 By chenying
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp036_desc(p_fabp035,p_fabp036)
   DEFINE p_fabp035      LIKE fabp_t.fabp035
   DEFINE p_fabp036      LIKE fabp_t.fabp036
   DEFINE r_desc         LIKE pjbal_t.pjbal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabp035
   LET g_ref_fields[2] = p_fabp036
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat511_01_fabp039_desc(p_fabp039) 
# Input parameter:  
# Date & Author..: 20150114 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp039_desc(p_fabp039)
   DEFINE p_fabp039        LIKE fabp_t.fabp039
   DEFINE r_desc           LIKE oojdl_t.oojdl003
   
   LET r_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabp039 
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afat511_01_fabp040_desc(p_oocq001,p_oocq002)
# Input parameter:  
# Date & Author..: 20150114 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat511_01_fabp040_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001   LIKE oocq_t.oocq001
   DEFINE p_oocq002   LIKE oocq_t.oocq002
   DEFINE r_ref       LIKE type_t.chr500
   WHENEVER ERROR CONTINUE

   LET r_ref = NULL

   SELECT oocql004 INTO r_ref FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = p_oocq001
      AND oocql002 = p_oocq002
      AND oocql003 = g_dlang

   RETURN r_ref
END FUNCTION

 
{</section>}
 

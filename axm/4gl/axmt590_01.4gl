#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt590_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-07-14 15:16:47), PR版次:0007(2016-07-14 15:43:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000171
#+ Filename...: axmt590_01
#+ Description: 多庫儲批驗退
#+ Creator....: 04543(2014-04-20 16:03:35)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axmt590_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#50  2016/03/23 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#22  2016/04/21 BY 07900    校验代码重复错误讯息的修改
#160519-00022#13  2016/07/14 By 02040    借貨還量單需依料號控卡批號是否可以輸入，簽退單批號不可輸入
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdm_d        RECORD
       xmdmdocno LIKE xmdm_t.xmdmdocno, 
   xmdmseq LIKE xmdm_t.xmdmseq, 
   xmdmseq1 LIKE xmdm_t.xmdmseq1, 
   xmdm001 LIKE xmdm_t.xmdm001, 
   xmdm002 LIKE xmdm_t.xmdm002, 
   xmdm003 LIKE xmdm_t.xmdm003, 
   xmdm004 LIKE xmdm_t.xmdm004, 
   xmdm005 LIKE xmdm_t.xmdm005, 
   xmdm005_desc LIKE type_t.chr500, 
   xmdm006 LIKE xmdm_t.xmdm006, 
   xmdm006_desc LIKE type_t.chr500, 
   xmdm007 LIKE xmdm_t.xmdm007, 
   xmdm008 LIKE xmdm_t.xmdm008, 
   xmdm008_desc LIKE type_t.chr500, 
   xmdm009 LIKE xmdm_t.xmdm009, 
   xmdm031 LIKE xmdm_t.xmdm031, 
   xmdm010 LIKE xmdm_t.xmdm010, 
   xmdm010_desc LIKE type_t.chr500, 
   xmdm011 LIKE xmdm_t.xmdm011, 
   xmdm032 LIKE xmdm_t.xmdm032
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xmdm_data      RECORD
   xmdment   LIKE xmdm_t.xmdment,
   xmdmsite  LIKE xmdm_t.xmdmsite,
   xmdmdocno LIKE xmdm_t.xmdmdocno, 
   xmdmseq   LIKE xmdm_t.xmdmseq, 
   xmdmseq1  LIKE xmdm_t.xmdmseq1, 
   xmdm001   LIKE xmdm_t.xmdm001, 
   xmdm002   LIKE xmdm_t.xmdm002, 
   xmdm003   LIKE xmdm_t.xmdm003, 
   xmdm004   LIKE xmdm_t.xmdm004, 
   xmdm005   LIKE xmdm_t.xmdm005, 
   xmdm006   LIKE xmdm_t.xmdm006, 
   xmdm007   LIKE xmdm_t.xmdm007, 
   xmdm008   LIKE xmdm_t.xmdm008, 
   xmdm009   LIKE xmdm_t.xmdm009, 
   xmdm010   LIKE xmdm_t.xmdm010, 
   xmdm011   LIKE xmdm_t.xmdm011, 
   xmdm012   LIKE xmdm_t.xmdm012, 
   xmdm013   LIKE xmdm_t.xmdm013, 
   xmdm014   LIKE xmdm_t.xmdm014, 
   xmdm031   LIKE xmdm_t.xmdm031, 
   xmdm032   LIKE xmdm_t.xmdm032
       END RECORD

DEFINE g_xmdl    RECORD   #單頭display欄位
   xmdldocno LIKE xmdl_t.xmdldocno,
   xmdlseq   LIKE xmdl_t.xmdlseq,
   xmdl008   LIKE xmdl_t.xmdl008,
   xmdl009   LIKE xmdl_t.xmdl009,
   xmdl011   LIKE xmdl_t.xmdl011,
   xmdl012   LIKE xmdl_t.xmdl012,
   xmdl017   LIKE xmdl_t.xmdl017,
   xmdl018   LIKE xmdl_t.xmdl018,
   xmdl001   LIKE xmdl_t.xmdl001,
   xmdl002   LIKE xmdl_t.xmdl002,
   xmdl019   LIKE xmdl_t.xmdl019,
   xmdl020   LIKE xmdl_t.xmdl020,
   xmdl081   LIKE xmdl_t.xmdl081,
   xmdl082   LIKE xmdl_t.xmdl082
                 END RECORD

#end add-point
 
DEFINE g_xmdm_d          DYNAMIC ARRAY OF type_g_xmdm_d
DEFINE g_xmdm_d_t        type_g_xmdm_d
 
 
DEFINE g_xmdmdocno_t   LIKE xmdm_t.xmdmdocno    #Key值備份
DEFINE g_xmdmseq_t      LIKE xmdm_t.xmdmseq    #Key值備份
DEFINE g_xmdmseq1_t      LIKE xmdm_t.xmdmseq1    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
#p_xmdkdocno     #單據單號
#p_xmdmseq       #項次
#p_xmdl008       #料件編號
#p_xmdl009       #產品特徵
#p_xmdl011       #作業編號
#p_xmdl012       #製程序
#p_xmdl017       #出貨單位
#p_xmdl018       #簽收數量
#p_xmdl001       #出貨單號
#p_xmdl002       #出貨項次
#p_xmdl019       #參考數量
#p_xmdl020       #計價單位
#p_xmdl081       #驗退數量
#p_xmdl082       #驗退參考數量
#end add-point    
 
{</section>}
 
{<section id="axmt590_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt590_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdmdocno,
   p_xmdmseq,
   p_xmdl008,
   p_xmdl009,
   p_xmdl011,
   p_xmdl012,
   p_xmdl017,
   p_xmdl018,
   p_xmdl001,
   p_xmdl002,
   p_xmdl019,
   p_xmdl020,
   p_xmdl081,
   p_xmdl082
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
   DEFINE p_xmdmdocno     LIKE xmdm_t.xmdmdocno
   DEFINE p_xmdmseq       LIKE xmdm_t.xmdmseq
   DEFINE p_xmdl008       LIKE xmdl_t.xmdl008
   DEFINE p_xmdl009       LIKE xmdl_t.xmdl009
   DEFINE p_xmdl011       LIKE xmdl_t.xmdl011
   DEFINE p_xmdl012       LIKE xmdl_t.xmdl012
   DEFINE p_xmdl017       LIKE xmdl_t.xmdl017
   DEFINE p_xmdl018       LIKE xmdl_t.xmdl018
   DEFINE p_xmdl001       LIKE xmdl_t.xmdl001
   DEFINE p_xmdl002       LIKE xmdl_t.xmdl002
   DEFINE p_xmdl019       LIKE xmdl_t.xmdl019
   DEFINE p_xmdl020       LIKE xmdl_t.xmdl020
   DEFINE p_xmdl081       LIKE xmdl_t.xmdl081
   DEFINE p_xmdl082       LIKE xmdl_t.xmdl082
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_forupd_sql    STRING
   DEFINE l_para_data     LIKE type_t.chr80          #接參數用
   DEFINE l_xmdm009       LIKE xmdm_t.xmdm009
   DEFINE l_xmdm011       LIKE xmdm_t.xmdm011
   DEFINE l_xmdm031       LIKE xmdm_t.xmdm031
   DEFINE l_xmdm032       LIKE xmdm_t.xmdm032
   DEFINE l_type          LIKE type_t.chr1
   DEFINE l_xmdm005       LIKE xmdm_t.xmdm005
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt590_01 WITH FORM cl_ap_formpath("axm","axmt590_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   WHENEVER ERROR CONTINUE
   
   #不允許新增修改
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   
   LET r_success = TRUE
   LET g_errno = ''
   
   CASE
      WHEN cl_null(p_xmdmdocno)
         LET g_errno = 'adb-00015'
      WHEN cl_null(p_xmdmseq)
         LET g_errno = 'sub-00406'
      WHEN cl_null(p_xmdl008)
         LET g_errno = 'sub-00123'
      WHEN cl_null(p_xmdl017)
         LET g_errno = 'axm-00199'
      WHEN cl_null(p_xmdl018)
         LET g_errno = 'axm-00200'
   END CASE
          
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_axmt590_01
      LET r_success = FALSE
      RETURN r_success
   END IF

   INITIALIZE g_xmdl.* TO NULL

   #將主程式的資訊帶入
   LET g_xmdl.xmdldocno = p_xmdmdocno   #單據單號
   LET g_xmdl.xmdlseq = p_xmdmseq       #項次
   LET g_xmdl.xmdl008 = p_xmdl008       #料件編號
   LET g_xmdl.xmdl009 = p_xmdl009       #產品特徵
   LET g_xmdl.xmdl011 = p_xmdl011       #作業編號
   LET g_xmdl.xmdl012 = p_xmdl012       #製程序
   LET g_xmdl.xmdl017 = p_xmdl017       #出貨單位
   LET g_xmdl.xmdl018 = p_xmdl018       #數量
   LET g_xmdl.xmdl001 = p_xmdl001       #出貨單號
   LET g_xmdl.xmdl002 = p_xmdl002       #出貨項次
   LET g_xmdl.xmdl019 = p_xmdl019       #參考單位
   LET g_xmdl.xmdl020 = p_xmdl020       #參考數量
   LET g_xmdl.xmdl081 = p_xmdl081       #驗退數量
   LET g_xmdl.xmdl082 = p_xmdl082       #驗退參考數量

   CALL axmt590_01_display_xmdl()        #單頭display   
   
   #檢查有無多庫儲批資料
   IF NOT axmt590_01_xmdm_count() THEN
      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'axm-00239'     #160318-00005#50  mark
      LET g_errparam.code = 'axm-00239'
      LET g_errparam.extend = ''
      #160318-00005#50 --s add
      LET g_errparam.replace[1] = 'axmt540'
      LET g_errparam.replace[2] = cl_get_progname('axmt540',g_lang,"2")
      LET g_errparam.exeprog = 'axmt540'
      #160318-00005#50 --e add
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #建立temp_table
   CALL axmt590_01_create_temp_table()
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_axmt590_01
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL s_transaction_begin()
   
   #塞temp_table
   CALL axmt590_01_insert_temp_table() RETURNING r_success
   
   IF NOT r_success THEN
      CALL s_transaction_end('N','0')
      CALL axmt590_01_drop_temp_table()
      CLOSE WINDOW w_axmt590_01
      RETURN r_success
   END IF
   
   #顯示單身
   CALL axmt590_01_b_fill()
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdm_d FROM s_detail1.*
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
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx                        
            
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               LET g_xmdm_d_t.* = g_xmdm_d[l_ac].*  #BACKUP        
            ELSE
               LET l_cmd='a'
            END IF   
            CALL axmt590_01_set_entry_b(l_cmd)
            CALL axmt590_01_set_no_entry_b(l_cmd)            
            
         BEFORE INSERT                                 
            
         AFTER INSERT                       
            
         BEFORE DELETE                                
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xmdm_d[l_ac].* = g_xmdm_d_t.*
               EXIT DIALOG
            END IF

            UPDATE axmt590_01_temp SET xmdm001 = g_xmdm_d[l_ac].xmdm001,
                                       xmdm002 = g_xmdm_d[l_ac].xmdm002,
                                       xmdm003 = g_xmdm_d[l_ac].xmdm003,
                                       xmdm004 = g_xmdm_d[l_ac].xmdm004,
                                       xmdm005 = g_xmdm_d[l_ac].xmdm005,
                                       xmdm006 = g_xmdm_d[l_ac].xmdm006,
                                       xmdm007 = g_xmdm_d[l_ac].xmdm007,
                                       xmdm008 = g_xmdm_d[l_ac].xmdm008,
                                       xmdm009 = g_xmdm_d[l_ac].xmdm009,
                                       xmdm031 = g_xmdm_d[l_ac].xmdm031,
                                       xmdm010 = g_xmdm_d[l_ac].xmdm010,
                                       xmdm011 = g_xmdm_d[l_ac].xmdm011,
                                       xmdm032 = g_xmdm_d[l_ac].xmdm032
             WHERE xmdment = g_enterprise
               AND xmdmdocno = g_xmdm_d_t.xmdmdocno
               AND xmdmseq = g_xmdm_d_t.xmdmseq
               AND xmdmseq1 = g_xmdm_d_t.xmdmseq1
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdv_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xmdm_d[l_ac].* = g_xmdm_d_t.*
            END IF
               
               
         AFTER ROW
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmdocno
            #add-point:BEFORE FIELD xmdmdocno name="input.b.page1.xmdmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmdocno
            
            #add-point:AFTER FIELD xmdmdocno name="input.a.page1.xmdmdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmdocno
            #add-point:ON CHANGE xmdmdocno name="input.g.page1.xmdmdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdmseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdmseq
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdmseq name="input.a.page1.xmdmseq"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq
            #add-point:BEFORE FIELD xmdmseq name="input.b.page1.xmdmseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmseq
            #add-point:ON CHANGE xmdmseq name="input.g.page1.xmdmseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdmseq1,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdmseq1
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdmseq1 name="input.a.page1.xmdmseq1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq1
            #add-point:BEFORE FIELD xmdmseq1 name="input.b.page1.xmdmseq1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdmseq1
            #add-point:ON CHANGE xmdmseq1 name="input.g.page1.xmdmseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm001
            #add-point:BEFORE FIELD xmdm001 name="input.b.page1.xmdm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm001
            
            #add-point:AFTER FIELD xmdm001 name="input.a.page1.xmdm001"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm001
            #add-point:ON CHANGE xmdm001 name="input.g.page1.xmdm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm002
            #add-point:BEFORE FIELD xmdm002 name="input.b.page1.xmdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm002
            
            #add-point:AFTER FIELD xmdm002 name="input.a.page1.xmdm002"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm002
            #add-point:ON CHANGE xmdm002 name="input.g.page1.xmdm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm003
            #add-point:BEFORE FIELD xmdm003 name="input.b.page1.xmdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm003
            
            #add-point:AFTER FIELD xmdm003 name="input.a.page1.xmdm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm003
            #add-point:ON CHANGE xmdm003 name="input.g.page1.xmdm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm004
            #add-point:BEFORE FIELD xmdm004 name="input.b.page1.xmdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm004
            
            #add-point:AFTER FIELD xmdm004 name="input.a.page1.xmdm004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm004
            #add-point:ON CHANGE xmdm004 name="input.g.page1.xmdm004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm005
            
            #add-point:AFTER FIELD xmdm005 name="input.a.page1.xmdm005"
            CALL axmt590_01_xmdm005_ref()            
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm005) THEN
               IF g_xmdm_d[l_ac].xmdm005 <> g_xmdm_d_t.xmdm005 OR
                  cl_null(g_xmdm_d_t.xmdm005) THEN

                  IF NOT axmt590_01_xmdm005_chk() THEN
                     LET g_xmdm_d[l_ac].xmdm005 = g_xmdm_d_t.xmdm005
                     CALL axmt590_01_xmdm005_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF            

            IF NOT axmt590_01_xmdm006_chk() THEN
               NEXT FIELD xmdm006
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm005
            #add-point:BEFORE FIELD xmdm005 name="input.b.page1.xmdm005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm005
            #add-point:ON CHANGE xmdm005 name="input.g.page1.xmdm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm006
            
            #add-point:AFTER FIELD xmdm006 name="input.a.page1.xmdm006"
            CALL axmt590_01_xmdm006_ref()            
            IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN
               IF g_xmdm_d[l_ac].xmdm006 <> g_xmdm_d_t.xmdm006 OR
                  cl_null(g_xmdm_d_t.xmdm006) THEN

                  IF NOT axmt590_01_xmdm006_chk() THEN
                     LET g_xmdm_d[l_ac].xmdm006 = g_xmdm_d_t.xmdm006
                     CALL axmt590_01_xmdm006_ref()
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm006
            #add-point:BEFORE FIELD xmdm006 name="input.b.page1.xmdm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm006
            #add-point:ON CHANGE xmdm006 name="input.g.page1.xmdm006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm007
            #add-point:BEFORE FIELD xmdm007 name="input.b.page1.xmdm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm007
            
            #add-point:AFTER FIELD xmdm007 name="input.a.page1.xmdm007"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm007
            #add-point:ON CHANGE xmdm007 name="input.g.page1.xmdm007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm008
            
            #add-point:AFTER FIELD xmdm008 name="input.a.page1.xmdm008"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm008
            #add-point:BEFORE FIELD xmdm008 name="input.b.page1.xmdm008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm008
            #add-point:ON CHANGE xmdm008 name="input.g.page1.xmdm008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm009
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm009 name="input.a.page1.xmdm009"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm009
            #add-point:BEFORE FIELD xmdm009 name="input.b.page1.xmdm009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm009
            #add-point:ON CHANGE xmdm009 name="input.g.page1.xmdm009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm031,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm031
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm031 name="input.a.page1.xmdm031"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm031
            #add-point:BEFORE FIELD xmdm031 name="input.b.page1.xmdm031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm031
            #add-point:ON CHANGE xmdm031 name="input.g.page1.xmdm031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm010
            
            #add-point:AFTER FIELD xmdm010 name="input.a.page1.xmdm010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm010
            #add-point:BEFORE FIELD xmdm010 name="input.b.page1.xmdm010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm010
            #add-point:ON CHANGE xmdm010 name="input.g.page1.xmdm010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm011
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm011 name="input.a.page1.xmdm011"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm011
            #add-point:BEFORE FIELD xmdm011 name="input.b.page1.xmdm011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm011
            #add-point:ON CHANGE xmdm011 name="input.g.page1.xmdm011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdm_d[l_ac].xmdm032,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmdm032
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdm032 name="input.a.page1.xmdm032"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm032
            #add-point:BEFORE FIELD xmdm032 name="input.b.page1.xmdm032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdm032
            #add-point:ON CHANGE xmdm032 name="input.g.page1.xmdm032"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdmdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmdocno
            #add-point:ON ACTION controlp INFIELD xmdmdocno name="input.c.page1.xmdmdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq
            #add-point:ON ACTION controlp INFIELD xmdmseq name="input.c.page1.xmdmseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdmseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq1
            #add-point:ON ACTION controlp INFIELD xmdmseq1 name="input.c.page1.xmdmseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm001
            #add-point:ON ACTION controlp INFIELD xmdm001 name="input.c.page1.xmdm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm002
            #add-point:ON ACTION controlp INFIELD xmdm002 name="input.c.page1.xmdm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm003
            #add-point:ON ACTION controlp INFIELD xmdm003 name="input.c.page1.xmdm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm004
            #add-point:ON ACTION controlp INFIELD xmdm004 name="input.c.page1.xmdm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm005
            #add-point:ON ACTION controlp INFIELD xmdm005 name="input.c.page1.xmdm005"
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			
			   LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm005
                          
            #出貨單庫位、成本庫否
            CALL axmt590_01_get_type(g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdmdocno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1)
            RETURNING l_type,l_xmdm005             
            
            LET g_qryparam.where = "inaa010 = '",l_type,"'"      #非成本庫

            CALL q_inaa001_2()                                           #呼叫開窗

            LET g_xmdm_d[l_ac].xmdm005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdm_d[l_ac].xmdm005 TO xmdm005              #顯示到畫面上
            
            CALL axmt590_01_xmdm005_ref()

            NEXT FIELD xmdm005                        #返回原欄位
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm006
            #add-point:ON ACTION controlp INFIELD xmdm006 name="input.c.page1.xmdm006"
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	   		LET g_qryparam.reqry = FALSE
			
	   		LET g_qryparam.arg1 = g_xmdm_d[l_ac].xmdm005
			
			   LET g_qryparam.default1 = g_xmdm_d[l_ac].xmdm006
            
            CALL q_inab002_5()                                           #呼叫開窗

            LET g_xmdm_d[l_ac].xmdm006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdm_d[l_ac].xmdm006 TO xmdm006              #顯示到畫面上
            
            CALL axmt590_01_xmdm006_ref() 

            NEXT FIELD xmdm006                          #返回原欄位
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm007
            #add-point:ON ACTION controlp INFIELD xmdm007 name="input.c.page1.xmdm007"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm008
            #add-point:ON ACTION controlp INFIELD xmdm008 name="input.c.page1.xmdm008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm009
            #add-point:ON ACTION controlp INFIELD xmdm009 name="input.c.page1.xmdm009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm031
            #add-point:ON ACTION controlp INFIELD xmdm031 name="input.c.page1.xmdm031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm010
            #add-point:ON ACTION controlp INFIELD xmdm010 name="input.c.page1.xmdm010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm011
            #add-point:ON ACTION controlp INFIELD xmdm011 name="input.c.page1.xmdm011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdm032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm032
            #add-point:ON ACTION controlp INFIELD xmdm032 name="input.c.page1.xmdm032"
            
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
   IF NOT INT_FLAG THEN
      IF axmt590_01_xmdm_t_insert() THEN
         LET r_success = TRUE   #完成insert
      END IF
   ELSE
      LET INT_FLAG = FALSE
      LET r_success = FALSE
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axmt590_01 
   
   #add-point:input段after input name="input.post_input"
   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF   
      
   CALL axmt590_01_drop_temp_table()
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt590_01.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt590_01_insert_temp_table()
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
         
   LET l_sql = "SELECT xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm012,xmdm013,xmdm014,xmdm031,",
               "       xmdm032",
               "  FROM xmdm_t",
               " WHERE xmdment = '",g_enterprise,"'",
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'"
   
   PREPARE axmt590_01_temp_pre1 FROM l_sql
   DECLARE axmt590_01_temp_cs1 CURSOR FOR axmt590_01_temp_pre1
   
   FOREACH axmt590_01_temp_cs1 INTO l_xmdm.xmdment,l_xmdm.xmdmsite,l_xmdm.xmdmdocno,l_xmdm.xmdmseq,l_xmdm.xmdmseq1,
                                    l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                                    l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                                    l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,l_xmdm.xmdm031,
                                    l_xmdm.xmdm032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INSERT INTO axmt590_01_temp(xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                                  xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                                  xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                                  xmdm011,xmdm012,xmdm013,xmdm014,xmdm031,
                                  xmdm032)
           VALUES(l_xmdm.xmdment,l_xmdm.xmdmsite,l_xmdm.xmdmdocno,l_xmdm.xmdmseq,l_xmdm.xmdmseq1,
                  l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                  l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                  l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,l_xmdm.xmdm031,
                  l_xmdm.xmdm032)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF                  
   END FOREACH
   
   CLOSE axmt590_01_temp_cs1
   FREE axmt590_01_temp_pre1 
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmt590_01_display_xmdl()
   DEFINE l_imaal003   LIKE imaal_t.imaal003
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   DEFINE l_oocal003   LIKE oocal_t.oocal003
   
   DISPLAY BY NAME g_xmdl.xmdlseq
   DISPLAY BY NAME g_xmdl.xmdl008
   DISPLAY BY NAME g_xmdl.xmdl009
   DISPLAY BY NAME g_xmdl.xmdl011
   DISPLAY BY NAME g_xmdl.xmdl012
   DISPLAY BY NAME g_xmdl.xmdl017
   DISPLAY BY NAME g_xmdl.xmdl018
   DISPLAY BY NAME g_xmdl.xmdl019
   DISPLAY BY NAME g_xmdl.xmdl020   
   DISPLAY BY NAME g_xmdl.xmdl081
   DISPLAY BY NAME g_xmdl.xmdl082   
   
   #品名、規格desc
   LET l_imaal003 = ''
   LET l_imaal004 = ''
   CALL s_desc_get_item_desc(g_xmdl.xmdl008) RETURNING l_imaal003,l_imaal004
   DISPLAY l_imaal003 TO FORMONLY.xmdl008_desc
   DISPLAY l_imaal004 TO FORMONLY.xmdl008_desc1
   
   #單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl017) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl017_display
   
   #參考單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_xmdl.xmdl019) RETURNING l_oocal003
   DISPLAY l_oocal003 TO FORMONLY.xmdl019_display
END FUNCTION

PRIVATE FUNCTION axmt590_01_create_temp_table()
      
   CREATE TEMP TABLE axmt590_01_temp
          (xmdment     LIKE xmdm_t.xmdment,
           xmdmsite    LIKE xmdm_t.xmdmsite,
           xmdmdocno   LIKE xmdm_t.xmdmdocno,
           xmdmseq     LIKE xmdm_t.xmdmseq,
           xmdmseq1    LIKE xmdm_t.xmdmseq1,
           xmdm001     LIKE xmdm_t.xmdm001,
           xmdm002     LIKE xmdm_t.xmdm002,
           xmdm003     LIKE xmdm_t.xmdm003,
           xmdm004     LIKE xmdm_t.xmdm004,
           xmdm005     LIKE xmdm_t.xmdm005,
           xmdm006     LIKE xmdm_t.xmdm006,
           xmdm007     LIKE xmdm_t.xmdm007,
           xmdm008     LIKE xmdm_t.xmdm008,
           xmdm009     LIKE xmdm_t.xmdm009,
           xmdm010     LIKE xmdm_t.xmdm010,
           xmdm011     LIKE xmdm_t.xmdm011,
           xmdm012     LIKE xmdm_t.xmdm012,
           xmdm013     LIKE xmdm_t.xmdm013,
           xmdm014     LIKE xmdm_t.xmdm014,
           xmdm031     LIKE xmdm_t.xmdm031,
           xmdm032     LIKE xmdm_t.xmdm032);   
END FUNCTION

PRIVATE FUNCTION axmt590_01_b_fill()
   DEFINE l_sql        STRING
   
   LET l_sql = "SELECT xmdmdocno,xmdmseq,xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011",
               "       xmdm031,xmdm032",
               "  FROM axmt590_01_temp",
               " WHERE xmdment = '",g_enterprise,"'",
               "   AND xmdmsite = '",g_site,"'",
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'"

   PREPARE axmt590_01_b_pre FROM l_sql
   DECLARE axmt590_01_b_cs CURSOR FOR axmt590_01_b_pre

   CALL g_xmdm_d.clear()
   LET l_ac = 1
   FOREACH axmt590_01_b_cs INTO g_xmdm_d[l_ac].xmdmdocno,g_xmdm_d[l_ac].xmdmseq,
                                g_xmdm_d[l_ac].xmdmseq1,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm003,
                                g_xmdm_d[l_ac].xmdm004,g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,
                                g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdm009,g_xmdm_d[l_ac].xmdm010,g_xmdm_d[l_ac].xmdm011,
                                g_xmdm_d[l_ac].xmdm031,g_xmdm_d[l_ac].xmdm032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL axmt590_01_xmdm005_ref()
      CALL axmt590_01_xmdm006_ref()
      CALL axmt590_01_xmdm008_ref()
      CALL axmt590_01_xmdm010_ref()

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_xmdm_d.deleteElement(g_xmdm_d.getLength())
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE axmt590_01_b_cs
   FREE axmt590_01_b_pre
END FUNCTION

PRIVATE FUNCTION axmt590_01_drop_temp_table()
   DROP TABLE axmt590_01_temp
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_site
   LET g_ref_fields[2] = g_xmdm_d[l_ac].xmdm005
   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? ","") RETURNING g_rtn_fields
   LET g_xmdm_d[l_ac].xmdm005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdm_d[l_ac].xmdm005_desc
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm006_ref()
INITIALIZE g_ref_fields TO NULL
   IF cl_null(g_xmdm_d[l_ac].xmdm006) THEN  #儲位
      LET g_xmdm_d[l_ac].xmdm006 = ' '
   END IF
   
   LET g_ref_fields[1] = g_site
   LET g_ref_fields[2] = g_xmdm_d[l_ac].xmdm005
   LET g_ref_fields[3] = g_xmdm_d[l_ac].xmdm006
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   LET g_xmdm_d[l_ac].xmdm006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdm_d[l_ac].xmdm006_desc
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm_t_insert()
   DEFINE l_sql        STRING
   DEFINE l_xmdm       type_g_xmdm_data   
   
   DELETE FROM xmdm_t
    WHERE xmdment = g_enterprise
      AND xmdmsite = g_site
      AND xmdmdocno = g_xmdl.xmdldocno
      AND xmdmseq = g_xmdl.xmdlseq
          
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF   
   
   LET l_sql = "SELECT xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,",
               "       xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,",
               "       xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,",
               "       xmdm011,xmdm012,xmdm013,xmdm014,xmdm031,",
               "       xmdm032",
               "  FROM axmt590_01_temp",
               " WHERE xmdment = '",g_enterprise,"'",
               "   AND xmdmsite = '",g_site,"'",
               "   AND xmdmdocno = '",g_xmdl.xmdldocno,"'",
               "   AND xmdmseq = '",g_xmdl.xmdlseq,"'"
   PREPARE axmt590_01_pre1 FROM l_sql
   DECLARE axmt590_01_cs1 CURSOR FOR axmt590_01_pre1   
   
   FOREACH axmt590_01_cs1 INTO l_xmdm.xmdment,l_xmdm.xmdmsite,l_xmdm.xmdmdocno,l_xmdm.xmdmseq,l_xmdm.xmdmseq1,
                               l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                               l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                               l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,l_xmdm.xmdm031,
                               l_xmdm.xmdm032
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET INT_FLAG = TRUE
         EXIT FOREACH
      END IF
      
      IF cl_null(l_xmdm.xmdm009) OR 
         l_xmdm.xmdm009 = 0 THEN
         CONTINUE FOREACH
      END IF

      LET l_xmdm.xmdment = g_enterprise
      LET l_xmdm.xmdmsite = g_site
      
      CALL axmt590_01_seq1_max(l_xmdm.xmdmdocno,l_xmdm.xmdmseq) RETURNING l_xmdm.xmdmseq1               
         
      INSERT INTO xmdm_t(xmdment,xmdmsite,xmdmdocno,xmdmseq,xmdmseq1,
                         xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,
                         xmdm006,xmdm007,xmdm008,xmdm009,xmdm010,
                         xmdm011,xmdm012,xmdm013,xmdm014,xmdm031,
                         xmdm032)
           VALUES (l_xmdm.xmdment,l_xmdm.xmdmsite,l_xmdm.xmdmdocno,l_xmdm.xmdmseq,l_xmdm.xmdmseq1,
                   l_xmdm.xmdm001,l_xmdm.xmdm002,l_xmdm.xmdm003,l_xmdm.xmdm004,l_xmdm.xmdm005,
                   l_xmdm.xmdm006,l_xmdm.xmdm007,l_xmdm.xmdm008,l_xmdm.xmdm009,l_xmdm.xmdm010,
                   l_xmdm.xmdm011,l_xmdm.xmdm012,l_xmdm.xmdm013,l_xmdm.xmdm014,l_xmdm.xmdm031,
                   l_xmdm.xmdm032)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET INT_FLAG = TRUE
         EXIT FOREACH
      END IF
   END FOREACH

   CLOSE axmt590_01_cs1
   FREE axmt590_01_pre1

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN FALSE
   ELSE
      RETURN TRUE      
   END IF
   
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm008_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdm_d[l_ac].xmdm008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdm_d[l_ac].xmdm008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdm_d[l_ac].xmdm008_desc
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm010_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmdm_d[l_ac].xmdm010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdm_d[l_ac].xmdm010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdm_d[l_ac].xmdm010_desc
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm_count()
   DEFINE l_n     LIKE type_t.num5
   
   LET l_n = 0
   SELECT COUNT(xmdmseq1) INTO l_n
     FROM xmdm_t
    WHERE xmdment = g_enterprise
      AND xmdmdocno = g_xmdl.xmdldocno
      AND xmdmseq = g_xmdl.xmdlseq
     
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm005_chk()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_xmdm005      LIKE xmdm_t.xmdm005
   DEFINE l_type1        LIKE type_t.chr1
   DEFINE l_type2        LIKE type_t.chr1
   
   LET r_success = TRUE
   
   #庫位
   IF NOT cl_null(g_xmdm_d[l_ac].xmdm005)THEN     
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005    #庫位
      #160318-00025#22  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
       #160318-00025#22  by 07900 --add-end                   
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inaa001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #出貨單庫位
      CALL axmt590_01_get_type(g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008,g_xmdm_d[l_ac].xmdmdocno,g_xmdm_d[l_ac].xmdmseq,g_xmdm_d[l_ac].xmdmseq1)
      RETURNING l_type1,l_xmdm005
            
      #新輸入庫位
      CALL s_axmt540_inag012_chk(g_site,g_xmdm_d[l_ac].xmdm001,g_xmdm_d[l_ac].xmdm002,' ',g_xmdm_d[l_ac].xmdm005,g_xmdm_d[l_ac].xmdm006,g_xmdm_d[l_ac].xmdm007,g_xmdm_d[l_ac].xmdm008)
      RETURNING l_type2
      
      IF l_type1 <> l_type2 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00250'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_xmdm005 
         LET g_errparam.replace[2] =  g_xmdm_d[l_ac].xmdm005
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 找單身項序最大值+1
# Memo...........:
# Usage..........: CALL axmt580_01_seq1_max(p_xmdldocno,p_xmdlseq)
#                  RETURNING r_xmdmseq1
# Input parameter: p_xmdldocno    單據單號
#                : p_xmdlseq      單身項次
# Return code....: r_xmdmseq1     項序最大值+1
#                :
# Date & Author..: 140327 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_01_seq1_max(p_xmdldocno,p_xmdlseq)
   DEFINE p_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE p_xmdlseq       LIKE xmdl_t.xmdlseq
   DEFINE r_xmdmseq1      LIKE xmdm_t.xmdmseq1

   LET r_xmdmseq1 = ''

   SELECT MAX(xmdmseq1) + 1 INTO r_xmdmseq1
     FROM xmdm_t
    WHERE xmdment = g_enterprise
      AND xmdmsite = g_site
      AND xmdmdocno = p_xmdldocno
      AND xmdmseq = p_xmdlseq 
   
   IF cl_null(r_xmdmseq1) THEN
      LET r_xmdmseq1 = 1
   END IF
   
   RETURN r_xmdmseq1
END FUNCTION

PRIVATE FUNCTION axmt590_01_xmdm006_chk()
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_xmdm_d[l_ac].xmdm006) THEN     #儲位       
   
      IF cl_null(g_xmdm_d[l_ac].xmdm005) THEN         #庫位
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00126'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success   
      END IF
      
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_xmdm_d[l_ac].xmdm005
      LET g_chkparam.arg3 = g_xmdm_d[l_ac].xmdm006
      #160318-00025#22  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
      #160318-00025#22  by 07900 --add-end            
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inab002") THEN
         LET r_success = FALSE
         RETURN r_success  
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 檢查來源出貨單是否為成本庫
# Memo...........:
# Usage..........: CALL s_axmt540_inag012_chk(p_xmdm001,p_xmdm002,p_xmdm007,p_xmdm008,p_xmdmdocno,p_xmdmseq,p_xmdmseq1)
#                  RETURNING 回传参数
# Input parameter: p_xmdm001   料件編號
#                : p_xmdm002   產品特徵
#                : p_xmdm007   批號
#                : p_xmdm008   庫存單位
#                : p_xmdmdocno 單據單號
#                : p_xmdmseq   項次
#                : p_xmdmseq1  項序
# Return code....: r_type      Y(成本庫)/N(非成本庫)
#                : r_xmdm005   出貨單庫位
# Date & Author..: 140619 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_01_get_type(p_xmdm001,p_xmdm002,p_xmdm007,p_xmdm008,p_xmdmdocno,p_xmdmseq,p_xmdmseq1)
   DEFINE p_xmdm001     LIKE xmdm_t.xmdm001
   DEFINE p_xmdm002     LIKE xmdm_t.xmdm002
   DEFINE p_xmdm007     LIKE xmdm_t.xmdm007
   DEFINE p_xmdm008     LIKE xmdm_t.xmdm008
   DEFINE p_xmdmdocno   LIKE xmdm_t.xmdmdocno
   DEFINE p_xmdmseq     LIKE xmdm_t.xmdmseq
   DEFINE p_xmdmseq1    LIKE xmdm_t.xmdmseq1    
   DEFINE r_xmdm005     LIKE xmdm_t.xmdm005   
   DEFINE r_type        LIKE type_t.chr1
   
   DEFINE l_xmdm006     LIKE xmdm_t.xmdm006
   
   WHENEVER ERROR CONTINUE
   
   LET r_type = ''   
   
   #原始出貨單庫位
   LET r_xmdm005 = ''
   LET l_xmdm006 = ''
   SELECT xmdm005,xmdm006   
     INTO r_xmdm005,l_xmdm006
     FROM xmdl_t,xmdm_t
    WHERE xmdment = xmdlent
      AND xmdlent = g_enterprise
      AND xmdmdocno = xmdl001
      AND xmdldocno = p_xmdmdocno
      AND xmdmseq = xmdl002
      AND xmdlseq = p_xmdmseq
      AND xmdmseq1 = p_xmdmseq1         
   
   #出貨單庫位
   CALL s_axmt540_inag012_chk(g_site,p_xmdm001,p_xmdm002,' ',r_xmdm005,l_xmdm006,p_xmdm007,p_xmdm008)
   RETURNING r_type
   
   RETURN r_type,r_xmdm005
END FUNCTION

################################################################################
# Descriptions...: 欄位控卡
# Memo...........:
# Usage..........: CALL axmt590_01_set_entry_b(p_cmd)
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160519-00022#13 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_01_set_entry_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
  CALL cl_set_comp_entry("xmdm007",TRUE)       

END FUNCTION
################################################################################
# Descriptions...: 欄位控卡
# Memo...........:
# Usage..........: CALL axmt590_01_set_no_entry_b(p_cmd)
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160519-00022#13 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_01_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE l_imaf055    LIKE imaf_t.imaf055  
   DEFINE l_imaf061    LIKE imaf_t.imaf061  


   IF g_argv[01] = '1' THEN
      CALL s_axmt540_get_imaf(g_xmdl.xmdl008) RETURNING l_imaf055,l_imaf061
      #檢查料件是否使用批號
      CASE l_imaf061
         WHEN '1'  #必須有批號
            CALL cl_set_comp_required("xmdm007",TRUE)
         WHEN '2'  #不可有批號
            CALL cl_set_comp_entry("xmdm007",FALSE)
      END CASE
   ELSE
      CALL cl_set_comp_entry("xmdm007",FALSE)
   END IF   

END FUNCTION

 
{</section>}
 

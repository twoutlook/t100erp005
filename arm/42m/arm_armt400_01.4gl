#該程式未解開Section, 採用最新樣板產出!
{<section id="armt400_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-08-13 10:13:06), PR版次:0003(2016-05-30 17:10:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: armt400_01
#+ Description: 多庫儲批資料維護
#+ Creator....: 05423(2015-08-07 17:06:02)
#+ Modifier...: 05423 -SD/PR- 02295
 
{</section>}
 
{<section id="armt400_01.global" >}
#應用 c03b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160202-00019#5  2016/04/08 By xianghui 增加制造批序号管理
#160318-00025#21 2016/04/20 BY 07900    校验代码重复错误讯息的修改
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
 
#單頭 type 宣告
PRIVATE type type_g_rmdb_m        RECORD
       rmdbdocno LIKE rmdb_t.rmdbdocno, 
   rmdbseq LIKE rmdb_t.rmdbseq, 
   rmdbsite LIKE rmdb_t.rmdbsite, 
   rmdb003 LIKE rmdb_t.rmdb003, 
   rmdb003_desc LIKE type_t.chr500, 
   rmdb003_desc1 LIKE type_t.chr500, 
   rmdb004 LIKE rmdb_t.rmdb004, 
   rmdb004_desc LIKE type_t.chr80, 
   rmdb005 LIKE rmdb_t.rmdb005, 
   rmdb005_desc LIKE type_t.chr80, 
   rmdb006 LIKE rmdb_t.rmdb006
       END RECORD
DEFINE g_rmdb_m        type_g_rmdb_m
 
   DEFINE g_rmdbdocno_t LIKE rmdb_t.rmdbdocno
DEFINE g_rmdbseq_t LIKE rmdb_t.rmdbseq
 
 
#單身 type 宣告
PRIVATE TYPE type_g_rmdc_d        RECORD
       rmdcseq1 LIKE rmdc_t.rmdcseq1, 
   rmdc001 LIKE rmdc_t.rmdc001, 
   rmdc002 LIKE rmdc_t.rmdc002, 
   rmdc005 LIKE rmdc_t.rmdc005, 
   rmdc005_desc LIKE type_t.chr500, 
   rmdc006 LIKE rmdc_t.rmdc006, 
   rmdc006_desc LIKE type_t.chr500, 
   rmdc007 LIKE rmdc_t.rmdc007, 
   rmdc008 LIKE rmdc_t.rmdc008, 
   rmdc003 LIKE rmdc_t.rmdc003, 
   rmdc003_desc LIKE type_t.chr500, 
   rmdc004 LIKE rmdc_t.rmdc004, 
   rmdcsite LIKE rmdc_t.rmdcsite
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_idx          LIKE type_t.num10
DEFINE g_rmdbdocno    LIKE rmdb_t.rmdbdocno
DEFINE g_rmdbseq      LIKE rmdb_t.rmdbseq
DEFINE g_rmdb003      LIKE rmdb_t.rmdb003
DEFINE g_rmdb004      LIKE rmdb_t.rmdb004
DEFINE g_rmdb005      LIKE rmdb_t.rmdb005
DEFINE g_rmdb006      LIKE rmdb_t.rmdb006
DEFINE g_rmdbsite     LIKE rmdb_t.rmdbsite
DEFINE g_rmdc_d_o     type_g_rmdc_d          #160202-00019#5
#end add-point
 
DEFINE g_rmdc_d          DYNAMIC ARRAY OF type_g_rmdc_d
DEFINE g_rmdc_d_t        type_g_rmdc_d
 
 
DEFINE g_rmdcseq1_t   LIKE rmdc_t.rmdcseq1    #Key值備份
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
     
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="armt400_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION armt400_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_rmdbdocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb005,p_rmdb006,p_rmdbsite,p_rmdb001,p_rmdb002
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
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"

   DEFINE p_rmdbdocno     LIKE rmdb_t.rmdbdocno
   DEFINE p_rmdbseq       LIKE rmdb_t.rmdbseq
   DEFINE p_rmdb003       LIKE rmdb_t.rmdb003
   DEFINE p_rmdb004       LIKE rmdb_t.rmdb004
   DEFINE p_rmdb005       LIKE rmdb_t.rmdb005
   DEFINE p_rmdb006       LIKE rmdb_t.rmdb006   
   DEFINE p_rmdbsite      LIKE rmdb_t.rmdbsite
   DEFINE p_rmdb001       LIKE rmdb_t.rmdb001   #160202-00019#5
   DEFINE p_rmdb002       LIKE rmdb_t.rmdb002   #160202-00019#5
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_rollback      LIKE type_t.num5
   
   DEFINE r_rmdb007       LIKE rmdb_t.rmdb007
   DEFINE r_rmdb008       LIKE rmdb_t.rmdb008
   DEFINE r_rmdb009       LIKE rmdb_t.rmdb009
   DEFINE r_rmdb010       LIKE rmdb_t.rmdb010
   
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ship          LIKE ooba_t.ooba001
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5   #160202-00019#5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_armt400_01 WITH FORM cl_ap_formpath("arm","armt400_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET r_rollback = FALSE
   LET r_rmdb007 = ''
   LET r_rmdb008 = ''
   LET r_rmdb009 = ''
   LET r_rmdb010 = ''

   #必須包在transaction裡面
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE

      RETURN r_success,r_rollback,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   END IF
   
   LET l_num = 0
   IF NOT cl_null(p_rmdb006) THEN #覆出數量
      LET l_num = p_rmdb006
   END IF
   
   LET g_errno = ''
   CASE
      WHEN cl_null(p_rmdbsite)
         LET g_errno = 'sub-00280'  #傳入參數為空或傳入值不正確!
      WHEN cl_null(p_rmdbdocno)
         LET g_errno = 'adb-00015'  #單據編號欄位無資料！
      WHEN cl_null(p_rmdbseq)
         LET g_errno = 'sub-00406'  #傳入的項次為空!
      WHEN cl_null(p_rmdb003)
         LET g_errno = 'sub-00123'  #料件編號不可為空
      WHEN cl_null(p_rmdb005)
         LET g_errno = 'axm-00199'  #單位不可為空！
      WHEN cl_null(p_rmdb006)
         LET g_errno = 'axm-00200'  #數量不可為空！
   END CASE
          
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE WINDOW w_armt400_01
      LET r_success = FALSE

      RETURN r_success,r_rollback,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   END IF

   INITIALIZE g_rmdb_m.* TO NULL
   #將主程式的資訊帶入
   LET g_rmdb_m.rmdbsite = p_rmdbsite          #營運據點
   LET g_rmdb_m.rmdbdocno = p_rmdbdocno   #單據單號
   LET g_rmdb_m.rmdbseq = p_rmdbseq       #項次
   LET g_rmdb_m.rmdb003 = p_rmdb003       #料件編號
   LET g_rmdb_m.rmdb004 = p_rmdb004       #產品特徵
   LET g_rmdb_m.rmdb005 = p_rmdb005       #出貨單位
   IF NOT cl_null(p_rmdb006) THEN
      LET g_rmdb_m.rmdb006 = p_rmdb006       #數量
   ELSE
      LET g_rmdb_m.rmdb006 = 0
   END IF

   #產品特徵為Null要補' '
   IF cl_null(g_rmdb_m.rmdb004) THEN LET g_rmdb_m.rmdb004 = ' ' END IF

   CALL armt400_01_display_rmdb()        #單頭display      

   #清空temp_table
   DELETE FROM armt400_01_temp

   #塞temp_table
   IF armt400_01_rmdc_count() THEN       #檢查是否已有多庫儲批資料
      CALL armt400_01_insert_temp_table() RETURNING r_success   #僅列出已輸入資料
   ELSE
      CALL armt400_01_insert_temp_table1() RETURNING r_success  #將來源、庫存列出
   END IF
   
   IF NOT r_success THEN
      CLOSE WINDOW w_armt400_01

      RETURN r_success,r_rollback,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   END IF

   #顯示單身
   CALL armt400_01_b_fill()

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdb_m.rmdb003,g_rmdb_m.rmdb004,g_rmdb_m.rmdb005, 
          g_rmdb_m.rmdb006 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.head.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.head.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbdocno
            #add-point:BEFORE FIELD rmdbdocno name="input.b.rmdbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbdocno
            
            #add-point:AFTER FIELD rmdbdocno name="input.a.rmdbdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmdb_m.rmdbdocno) AND NOT cl_null(g_rmdb_m.rmdbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmdb_m.rmdbdocno != g_rmdbdocno_t  OR g_rmdb_m.rmdbseq != g_rmdbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmdb_t WHERE "||"rmdbent = '" ||g_enterprise|| "' AND "||"rmdbdocno = '"||g_rmdb_m.rmdbdocno ||"' AND "|| "rmdbseq = '"||g_rmdb_m.rmdbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdbdocno
            #add-point:ON CHANGE rmdbdocno name="input.g.rmdbdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdbseq
            #add-point:BEFORE FIELD rmdbseq name="input.b.rmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdbseq
            
            #add-point:AFTER FIELD rmdbseq name="input.a.rmdbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmdb_m.rmdbdocno) AND NOT cl_null(g_rmdb_m.rmdbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmdb_m.rmdbdocno != g_rmdbdocno_t  OR g_rmdb_m.rmdbseq != g_rmdbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmdb_t WHERE "||"rmdbent = '" ||g_enterprise|| "' AND "||"rmdbdocno = '"||g_rmdb_m.rmdbdocno ||"' AND "|| "rmdbseq = '"||g_rmdb_m.rmdbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdbseq
            #add-point:ON CHANGE rmdbseq name="input.g.rmdbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb003
            
            #add-point:AFTER FIELD rmdb003 name="input.a.rmdb003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb003
            #add-point:BEFORE FIELD rmdb003 name="input.b.rmdb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb003
            #add-point:ON CHANGE rmdb003 name="input.g.rmdb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb004
            
            #add-point:AFTER FIELD rmdb004 name="input.a.rmdb004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb004
            #add-point:BEFORE FIELD rmdb004 name="input.b.rmdb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb004
            #add-point:ON CHANGE rmdb004 name="input.g.rmdb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb005
            
            #add-point:AFTER FIELD rmdb005 name="input.a.rmdb005"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb005
            #add-point:BEFORE FIELD rmdb005 name="input.b.rmdb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb005
            #add-point:ON CHANGE rmdb005 name="input.g.rmdb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmdb_m.rmdb006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmdb006
            END IF 
 
 
 
            #add-point:AFTER FIELD rmdb006 name="input.a.rmdb006"
            IF NOT cl_null(g_rmdb_m.rmdb006) THEN 
            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdb006
            #add-point:BEFORE FIELD rmdb006 name="input.b.rmdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdb006
            #add-point:ON CHANGE rmdb006 name="input.g.rmdb006"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rmdbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbdocno
            #add-point:ON ACTION controlp INFIELD rmdbdocno name="input.c.rmdbdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdbseq
            #add-point:ON ACTION controlp INFIELD rmdbseq name="input.c.rmdbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb003
            #add-point:ON ACTION controlp INFIELD rmdb003 name="input.c.rmdb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb004
            #add-point:ON ACTION controlp INFIELD rmdb004 name="input.c.rmdb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb005
            #add-point:ON ACTION controlp INFIELD rmdb005 name="input.c.rmdb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdb006
            #add-point:ON ACTION controlp INFIELD rmdb006 name="input.c.rmdb006"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.head.after_input"
 
            #end add-point
            
      END INPUT
   
      INPUT ARRAY g_rmdc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.body.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.body.before_input"
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx

            IF g_rec_b >= l_ac THEN
               LET l_cmd = 'u'
               LET g_rmdc_d_t.* = g_rmdc_d[l_ac].*  #BACKUP
               LET g_rmdc_d_t.* = g_rmdc_d[l_ac].*
               LET g_rmdc_d_o.* = g_rmdc_d[l_ac].*  #160202-00019#5
            ELSE
               LET l_cmd = 'a'
            END IF

            CALL armt400_01_set_entry()
            CALL armt400_01_set_no_entry()
                        
         BEFORE INSERT                  
            LET l_cmd = 'a'
            INITIALIZE g_rmdc_d_t.* TO NULL
            INITIALIZE g_rmdc_d_t.* TO NULL
            INITIALIZE g_rmdc_d[l_ac].* TO NULL
            
            LET g_rmdc_d[l_ac].rmdc001 = g_rmdb_m.rmdb003   #料件編號
            LET g_rmdc_d[l_ac].rmdc002 = g_rmdb_m.rmdb004   #產品特徵

            LET g_rmdc_d[l_ac].rmdc003 = g_rmdb_m.rmdb005   #單位
            LET g_rmdc_d[l_ac].rmdc004 = 0   #数量
            LET g_rmdc_d[l_ac].rmdcsite = g_rmdb_m.rmdbsite

            #单位说明
            CALL s_desc_get_unit_desc(g_rmdc_d[l_ac].rmdc003) RETURNING g_rmdc_d[l_ac].rmdc003_desc   
                        
            SELECT MAX(rmdcseq1)+1 INTO g_rmdc_d[l_ac].rmdcseq1
              FROM armt400_01_temp
             WHERE rmdcent = g_enterprise
               AND rmdcdocno = g_rmdb_m.rmdbdocno
               AND rmdcseq = g_rmdb_m.rmdbseq

            IF cl_null(g_rmdc_d[l_ac].rmdcseq1) THEN
               LET g_rmdc_d[l_ac].rmdcseq1 = 1
            END IF

            LET g_rmdc_d_t.* = g_rmdc_d[l_ac].*
            LET g_rmdc_d_t.* = g_rmdc_d[l_ac].*
            LET g_rmdc_d_o.* = g_rmdc_d[l_ac].*  #160202-00019#5
            CALL cl_show_fld_cont()
            
            CALL armt400_01_set_entry()
            CALL armt400_01_set_no_entry()            
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '9001'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF  

            #庫儲批補空格及資料重複輸入檢查
            IF NOT armt400_01_repeat_chk() THEN
               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF

            #批號檢查
            IF NOT armt400_01_rmdc007_chk() THEN               
               LET INT_FLAG = FALSE
               CANCEL INSERT
            END IF

            INSERT INTO armt400_01_temp(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,
                                        rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,
                                        rmdc006,rmdc007,rmdc008)
                 VALUES (g_enterprise,g_rmdbsite,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,
                         g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,g_rmdc_d[l_ac].rmdc005,
                         g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc008)
                 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INSERT:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CANCEL INSERT
            ELSE
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                     
            IF NOT cl_null(g_rmdb_m.rmdbdocno) AND
               NOT cl_null(g_rmdb_m.rmdbseq) AND
               NOT cl_null(g_rmdc_d[l_ac].rmdcseq1) THEN
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               
               DELETE FROM armt400_01_temp
               WHERE rmdcent = g_enterprise
                 AND rmdcdocno = g_rmdb_m.rmdbdocno
                 AND rmdcseq = g_rmdb_m.rmdbseq
                 AND rmdcseq1 = g_rmdc_d_t.rmdcseq1

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "DELETE:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b - 1
               END IF
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_rmdc_d[l_ac].* = g_rmdc_d_t.*
               EXIT DIALOG
            END IF

            #庫儲批補空格及資料重複輸入檢查
            IF NOT armt400_01_repeat_chk() THEN
               NEXT FIELD rmdc004
            END IF

            #批號檢查
            IF NOT armt400_01_rmdc007_chk() THEN               
               NEXT FIELD rmdc007
            END IF

            UPDATE armt400_01_temp SET rmdc001 = g_rmdc_d[l_ac].rmdc001,
                                       rmdc002 = g_rmdc_d[l_ac].rmdc002,
                                       rmdc003 = g_rmdc_d[l_ac].rmdc003,
                                       rmdc004 = g_rmdc_d[l_ac].rmdc004,
                                       rmdc005 = g_rmdc_d[l_ac].rmdc005,
                                       rmdc006 = g_rmdc_d[l_ac].rmdc006,
                                       rmdc007 = g_rmdc_d[l_ac].rmdc007,
                                       rmdc008 = g_rmdc_d[l_ac].rmdc008
             WHERE rmdcent = g_enterprise
               AND rmdcdocno = g_rmdb_m.rmdbdocno
               AND rmdcseq = g_rmdb_m.rmdbseq
               AND rmdcseq1 = g_rmdc_d_t.rmdcseq1
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "UPDATE:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_rmdc_d[l_ac].* = g_rmdc_d_t.*
            END IF

         AFTER ROW
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdcseq1
            #add-point:BEFORE FIELD rmdcseq1 name="input.b.page1.rmdcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdcseq1
            
            #add-point:AFTER FIELD rmdcseq1 name="input.a.page1.rmdcseq1"
            #應用 a05 樣板自動產生(Version:2)
            IF NOT cl_ap_chk_range(g_rmdc_d[l_ac].rmdcseq1,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdmseq1
            END IF 
 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdcseq1
            #add-point:ON CHANGE rmdcseq1 name="input.g.page1.rmdcseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc005
            
            #add-point:AFTER FIELD rmdc005 name="input.a.page1.rmdc005"
            CALL s_desc_get_stock_desc(g_rmdbsite,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
            
            IF NOT cl_null(g_rmdc_d[l_ac].rmdc005) THEN
               IF g_rmdc_d[l_ac].rmdc005 <> g_rmdc_d_t.rmdc005 OR cl_null(g_rmdc_d_t.rmdc005) THEN 
                  
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rmdc_d[l_ac].rmdc005

                  #160318-00025#21  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                 #160318-00025#21  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001_20") THEN
                     #檢查成功時後續處理
                     IF g_rmdc_d[l_ac].rmdc005 <> g_rmdc_d_t.rmdc005 THEN
                        LET g_rmdc_d[l_ac].rmdc006 = NULL
                        LET g_rmdc_d[l_ac].rmdc006_desc = NULL
                     END IF
                     #库存量check
                     CALL armt400_01_rmdc005_chk(g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,
                                                 g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,
                                                 g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,
                                                 g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc008)
                                                 RETURNING r_success
                     IF NOT r_success THEN   #庫存量不足
                        LET g_rmdc_d[l_ac].rmdc005 = g_rmdc_d_t.rmdc005
                        CALL s_desc_get_stock_desc(g_site,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
                        NEXT FIELD CURRENT
                     END IF       
                     #儲位控管若為5.不使用儲位控管  
                     IF NOT s_axmt540_inaa007_chk(g_rmdc_d[l_ac].rmdc005) THEN
                        LET g_rmdc_d[l_ac].rmdc006 = ' '
                        LET g_rmdc_d_t.rmdc006 = g_rmdc_d[l_ac].rmdc006      
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_rmdc_d[l_ac].rmdc005 = g_rmdc_d_t.rmdc005
                     LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
                     DISPLAY BY NAME g_rmdc_d[l_ac].rmdc005
                     DISPLAY BY NAME g_rmdc_d[l_ac].rmdc006
                     NEXT FIELD CURRENT
                  END IF
               END IF
#               #160202-00019#5---add---begin
#               IF g_rmdc_d[l_ac].rmdc005 <> g_rmdc_d_o.rmdc005 OR cl_null(g_rmdc_d_o.rmdc005) 
#                  OR g_rmdc_d[l_ac].rmdc006 <> g_rmdc_d_o.rmdc006 OR cl_null(g_rmdc_d_o.rmdc006)
#                  OR g_rmdc_d[l_ac].rmdc007 <> g_rmdc_d_o.rmdc007 OR cl_null(g_rmdc_d_o.rmdc007) THEN
#                  IF s_lot_batch_number_1n3(g_rmdc_d[l_ac].rmdc001,g_site) THEN 
#                     CALL s_lot_inao_chk(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,'2',g_site) RETURNING l_success,l_cnt
#                     IF l_cnt > 0 THEN 
#                        IF l_success THEN 
#                           #刪除資料                              
#                           DELETE FROM inao_t 
#                            WHERE inaoent = g_enterprise 
#                              AND inaosite = g_site
#                              AND inaodocno = g_rmdb_m.rmdbdocno
#                              AND inaoseq = g_rmdb_m.rmdbseq
#                              AND inaoseq1 = g_rmdc_d[l_ac].rmdcseq1
#                              AND inao000 = '2'
#                              AND inao013 = '-1'                       
#                           CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                         RETURNING l_success 
#                        ELSE
#                           LET g_rmdc_d[l_ac].rmdc005 = g_rmdc_d_t.rmdc005                            
#                           CALL s_desc_get_stock_desc(g_site,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
#                           LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
#                           CALL s_desc_get_locator_desc(g_site,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc                     
#                           LET g_rmdc_d[l_ac].rmdc007 = g_rmdc_d_t.rmdc007
#                        END IF
#                     ELSE
#                        CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                      RETURNING l_success
#                     END IF
#                  END IF    
#               END IF                     
#               #160202-00019#5---add---end                     
            END IF
            LET g_rmdc_d_t.rmdc005 = g_rmdc_d[l_ac].rmdc005

            CALL armt400_01_set_entry()
            CALL armt400_01_set_no_entry()

            
            IF NOT armt400_01_num_chk() THEN
               LET g_rmdc_d_t.rmdc004 = ''
               NEXT FIELD rmdc004
            END IF
            LET g_rmdc_d_o.rmdc005 = g_rmdc_d[l_ac].rmdc005  #160202-00019#5
            LET g_rmdc_d_o.rmdc006 = g_rmdc_d[l_ac].rmdc006  #160202-00019#5
            LET g_rmdc_d_o.rmdc007 = g_rmdc_d[l_ac].rmdc007  #160202-00019#5
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc005
            #add-point:BEFORE FIELD rmdc005 name="input.b.page1.rmdc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdc005
            #add-point:ON CHANGE rmdc005 name="input.g.page1.rmdc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc006
            
            #add-point:AFTER FIELD rmdc006 name="input.a.page1.rmdc006"
            CALL s_desc_get_locator_desc(g_rmdbsite,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc
            #160202-00019#5---mod---begin
            #IF NOT cl_null(g_rmdc_d[l_ac].rmdc006) THEN
            IF g_rmdc_d[l_ac].rmdc006 IS NULL THEN 
               LET g_rmdc_d[l_ac].rmdc006 = ' '
            END IF
            IF g_rmdc_d[l_ac].rmdc006 IS NOT NULL THEN
            #160202-00019#5---mod---end
               IF g_rmdc_d[l_ac].rmdc006 <> g_rmdc_d_t.rmdc006 OR cl_null(g_rmdc_d_t.rmdc006) THEN 

                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_rmdc_d[l_ac].rmdc005
                  LET g_chkparam.arg3 = g_rmdc_d[l_ac].rmdc006
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inab002_1") THEN
                     #檢查成功時後續處理
                     #库存量check
                     CALL armt400_01_rmdc005_chk(g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,
                                                 g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,
                                                 g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,
                                                 g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc008)
                                                 RETURNING r_success
                     IF NOT r_success THEN   #庫存量不足
                        LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
                        CALL s_desc_get_locator_desc(g_rmdbsite,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc
                        NEXT FIELD CURRENT
                     END IF       
                  ELSE
                     #檢查失敗時後續處理
                     LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
                     CALL s_desc_get_locator_desc(g_rmdbsite,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc

                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
#               #160202-00019#5---add---begin
#               IF g_rmdc_d[l_ac].rmdc005 <> g_rmdc_d_o.rmdc005 OR cl_null(g_rmdc_d_o.rmdc005) 
#                  OR g_rmdc_d[l_ac].rmdc006 <> g_rmdc_d_o.rmdc006 OR cl_null(g_rmdc_d_o.rmdc006)
#                  OR g_rmdc_d[l_ac].rmdc007 <> g_rmdc_d_o.rmdc007 OR cl_null(g_rmdc_d_o.rmdc007) THEN
#                  IF s_lot_batch_number_1n3(g_rmdc_d[l_ac].rmdc001,g_site) THEN 
#                     CALL s_lot_inao_chk(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,'2',g_site) RETURNING l_success,l_cnt
#                     IF l_cnt > 0 THEN 
#                        IF l_success THEN 
#                           #刪除資料                              
#                           DELETE FROM inao_t 
#                            WHERE inaoent = g_enterprise 
#                              AND inaosite = g_site
#                              AND inaodocno = g_rmdb_m.rmdbdocno
#                              AND inaoseq = g_rmdb_m.rmdbseq
#                              AND inaoseq1 = g_rmdc_d[l_ac].rmdcseq1
#                              AND inao000 = '2'
#                              AND inao013 = '-1'                       
#                           CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                         RETURNING l_success 
#                        ELSE
#                           LET g_rmdc_d[l_ac].rmdc005 = g_rmdc_d_t.rmdc005                            
#                           CALL s_desc_get_stock_desc(g_site,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
#                           LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
#                           CALL s_desc_get_locator_desc(g_site,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc                     
#                           LET g_rmdc_d[l_ac].rmdc007 = g_rmdc_d_t.rmdc007
#                        END IF
#                     ELSE
#                        CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                      RETURNING l_success
#                     END IF
#                  END IF    
#               END IF                     
#               #160202-00019#5---add---end                
            END IF
            
            LET g_rmdc_d_t.rmdc006 = g_rmdc_d[l_ac].rmdc006

            IF NOT armt400_01_num_chk() THEN
               LET g_rmdc_d_t.rmdc004 = ''
               NEXT FIELD rmdc004
            END IF
            LET g_rmdc_d_o.rmdc005 = g_rmdc_d[l_ac].rmdc005  #160202-00019#5
            LET g_rmdc_d_o.rmdc006 = g_rmdc_d[l_ac].rmdc006  #160202-00019#5
            LET g_rmdc_d_o.rmdc007 = g_rmdc_d[l_ac].rmdc007  #160202-00019#5            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc006
            #add-point:BEFORE FIELD rmdc006 name="input.b.page1.rmdc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdc006
            #add-point:ON CHANGE rmdc006 name="input.g.page1.rmdc006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc007
            
            #add-point:AFTER FIELD rmdc007 name="input.a.page1.rmdc007"
            #160202-00019#5---mod---begin
            #IF NOT cl_null(g_rmdc_d[l_ac].rmdc007) THEN
            IF g_rmdc_d[l_ac].rmdc007 IS NULL THEN 
               LET g_rmdc_d[l_ac].rmdc007 = ' '
            END IF
            IF g_rmdc_d[l_ac].rmdc007 IS NOT NULL THEN
            #160202-00019#5---mod---end
               IF g_rmdc_d[l_ac].rmdc007 <> g_rmdc_d_t.rmdc007 OR cl_null(g_rmdc_d_t.rmdc007) THEN 
               
                  IF NOT armt400_01_rmdc007_chk() THEN
                     LET g_rmdc_d[l_ac].rmdc007 = g_rmdc_d_t.rmdc007
                     NEXT FIELD CURRENT
                  END IF
 
               END IF
#               #160202-00019#5---add---begin
#               IF g_rmdc_d[l_ac].rmdc005 <> g_rmdc_d_o.rmdc005 OR cl_null(g_rmdc_d_o.rmdc005) 
#                  OR g_rmdc_d[l_ac].rmdc006 <> g_rmdc_d_o.rmdc006 OR cl_null(g_rmdc_d_o.rmdc006)
#                  OR g_rmdc_d[l_ac].rmdc007 <> g_rmdc_d_o.rmdc007 OR cl_null(g_rmdc_d_o.rmdc007) THEN
#                  IF s_lot_batch_number_1n3(g_rmdc_d[l_ac].rmdc001,g_site) THEN 
#                     CALL s_lot_inao_chk(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,'2',g_site) RETURNING l_success,l_cnt
#                     IF l_cnt > 0 THEN 
#                        IF l_success THEN 
#                           #刪除資料                              
#                           DELETE FROM inao_t 
#                            WHERE inaoent = g_enterprise 
#                              AND inaosite = g_site
#                              AND inaodocno = g_rmdb_m.rmdbdocno
#                              AND inaoseq = g_rmdb_m.rmdbseq
#                              AND inaoseq1 = g_rmdc_d[l_ac].rmdcseq1
#                              AND inao000 = '2'
#                              AND inao013 = '-1'                       
#                           CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                         RETURNING l_success
#                        ELSE
#                           LET g_rmdc_d[l_ac].rmdc005 = g_rmdc_d_t.rmdc005                            
#                           CALL s_desc_get_stock_desc(g_site,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
#                           LET g_rmdc_d[l_ac].rmdc006 = g_rmdc_d_t.rmdc006
#                           CALL s_desc_get_locator_desc(g_site,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc                     
#                           LET g_rmdc_d[l_ac].rmdc007 = g_rmdc_d_t.rmdc007
#                        END IF
#                     ELSE
#                        CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                      RETURNING l_success
#                     END IF
#                  END IF    
#               END IF                     
#               #160202-00019#5---add---end                
            END IF
            
            LET g_rmdc_d_t.rmdc007 = g_rmdc_d[l_ac].rmdc007
            IF NOT armt400_01_num_chk() THEN
               LET g_rmdc_d_t.rmdc004 = ''
               NEXT FIELD rmdc004
            END IF
            LET g_rmdc_d_o.rmdc005 = g_rmdc_d[l_ac].rmdc005  #160202-00019#5
            LET g_rmdc_d_o.rmdc006 = g_rmdc_d[l_ac].rmdc006  #160202-00019#5
            LET g_rmdc_d_o.rmdc007 = g_rmdc_d[l_ac].rmdc007  #160202-00019#5            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc007
            #add-point:BEFORE FIELD rmdc007 name="input.b.page1.rmdc007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdc007
            #add-point:ON CHANGE rmdc007 name="input.g.page1.rmdc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc008
            #add-point:BEFORE FIELD rmdc008 name="input.b.page1.rmdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc008
            
            #add-point:AFTER FIELD rmdc008 name="input.a.page1.rmdc008"
#            #160202-00019#5---add---begin
#            IF g_rmdc_d[l_ac].rmdc008 IS NULL THEN 
#               LET g_rmdc_d[l_ac].rmdc008 = ' '
#            END IF
#            IF g_rmdc_d[l_ac].rmdc008 IS NOT NULL THEN
#               IF g_rmdc_d[l_ac].rmdc008 <> g_rmdc_d_o.rmdc008 OR cl_null(g_rmdc_d_o.rmdc008) THEN
#                  IF s_lot_batch_number_1n3(g_rmdc_d[l_ac].rmdc001,g_site) THEN 
#                     CALL s_lot_inao_chk(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,'2',g_site) RETURNING l_success,l_cnt
#                     IF l_cnt > 0 THEN 
#                        IF l_success THEN 
#                           #刪除資料                              
#                           DELETE FROM inao_t 
#                            WHERE inaoent = g_enterprise 
#                              AND inaosite = g_site
#                              AND inaodocno = g_rmdb_m.rmdbdocno
#                              AND inaoseq = g_rmdb_m.rmdbseq
#                              AND inaoseq1 = g_rmdc_d[l_ac].rmdcseq1
#                              AND inao000 = '2'
#                              AND inao013 = '-1'                       
#                           CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                         RETURNING l_success
#                        ELSE
#                           LET g_rmdc_d_t.rmdc008 = g_rmdc_d[l_ac].rmdc008
#                        END IF
#                     ELSE
#                        CALL s_lot_sel('1','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
#                                      RETURNING l_success
#                     END IF
#                  END IF    
#               END IF 
#            END IF               
#            #160202-00019#5---add---end 

            LET g_rmdc_d_t.rmdc008 = g_rmdc_d[l_ac].rmdc008
            IF NOT armt400_01_num_chk() THEN
               LET g_rmdc_d_t.rmdc004 = ''
               NEXT FIELD rmdc004
            END IF
#            LET g_rmdc_d_o.rmdc008 = g_rmdc_d[l_ac].rmdc008 #160202-00019#5
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdc008
            #add-point:ON CHANGE rmdc008 name="input.g.page1.rmdc008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdc004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmdc_d[l_ac].rmdc004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmdc004
            END IF 
 
 
 
            #add-point:AFTER FIELD rmdc004 name="input.a.page1.rmdc004"
            IF NOT cl_null(g_rmdc_d[l_ac].rmdc004) THEN 
               IF NOT armt400_01_num_chk() THEN
                  LET g_rmdc_d[l_ac].rmdc004 = g_rmdc_d_t.rmdc004
                  NEXT FIELD CURRENT
               END IF
               #160202-00019#5---add---begin
               IF g_rmdc_d[l_ac].rmdc004 <> g_rmdc_d_o.rmdc004 OR cl_null(g_rmdc_d_o.rmdc004) THEN 
                  IF s_lot_batch_number_1n3(g_rmdc_d[l_ac].rmdc001,g_site) THEN                 
                     CALL s_axmt540_inao_copy(p_rmdb001,p_rmdb002,'2',g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,'1','Y','1') RETURNING l_success
                  
                     CALL s_lot_sel('2','2',g_site,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc008,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,'-1','armt400','','','','','0')
                                   RETURNING l_success
                     IF l_success THEN     
                        CALL s_axmt540_update_inao(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,g_rmdc_d[l_ac].rmdcseq1,p_rmdb001,p_rmdb002,'1','1') RETURNING l_success 
                     END IF  
                     #刪除申請資料                              
                     DELETE FROM inao_t 
                      WHERE inaoent = g_enterprise 
                        AND inaosite = g_site
                        AND inaodocno = g_rmdb_m.rmdbdocno
                        AND inaoseq = g_rmdb_m.rmdbseq
                        AND inaoseq1 = g_rmdc_d[l_ac].rmdcseq1
                        AND inao000 = '1'
                        AND inao013 = '-1'                                 
                  END IF
               END IF   
               #160202-00019#5---add---end
               #取位
               CALL s_aooi250_take_decimals(g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004) RETURNING l_success,g_rmdc_d[l_ac].rmdc004
               
               
            END IF

            LET g_rmdc_d_t.rmdc004 = g_rmdc_d[l_ac].rmdc004
            LET g_rmdc_d_o.rmdc004 = g_rmdc_d[l_ac].rmdc004   #160202-00019#5
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdc004
            #add-point:BEFORE FIELD rmdc004 name="input.b.page1.rmdc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdc004
            #add-point:ON CHANGE rmdc004 name="input.g.page1.rmdc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdcsite
            #add-point:BEFORE FIELD rmdcsite name="input.b.page1.rmdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdcsite
            
            #add-point:AFTER FIELD rmdcsite name="input.a.page1.rmdcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmdcsite
            #add-point:ON CHANGE rmdcsite name="input.g.page1.rmdcsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rmdcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdcseq1
            #add-point:ON ACTION controlp INFIELD rmdcseq1 name="input.c.page1.rmdcseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc005
            #add-point:ON ACTION controlp INFIELD rmdc005 name="input.c.page1.rmdc005"
            CALL armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry('1')
            NEXT FIELD rmdc005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc006
            #add-point:ON ACTION controlp INFIELD rmdc006 name="input.c.page1.rmdc006"
            CALL armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry('2')
            NEXT FIELD rmdc006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc007
            #add-point:ON ACTION controlp INFIELD rmdc007 name="input.c.page1.rmdc007"
            CALL armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry('3')
            NEXT FIELD rmdc007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc008
            #add-point:ON ACTION controlp INFIELD rmdc008 name="input.c.page1.rmdc008"
            CALL armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry('4')
            NEXT FIELD rmdc008                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdc004
            #add-point:ON ACTION controlp INFIELD rmdc004 name="input.c.page1.rmdc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdcsite
            #add-point:ON ACTION controlp INFIELD rmdcsite name="input.c.page1.rmdcsite"
            
            #END add-point
 
 
 
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.body.after_input"
            IF NOT armt400_01_sum_chk('2') THEN
               NEXT FIELD rmdc004
            END IF
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
   CLOSE WINDOW w_armt400_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL armt400_01_rmdc_t_insert() RETURNING r_success,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
      IF NOT r_success THEN
         LET r_rollback = TRUE  #多庫儲批資料出現錯誤必須rollback
      END IF
   ELSE
      LET INT_FLAG = FALSE
      LET r_success = FALSE
   END IF    
   
   RETURN r_success,r_rollback,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="armt400_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="armt400_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 单头display
# Memo...........:
# Usage..........: CALL armt400_01_display_rmdb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_display_rmdb()
   DEFINE l_imaal003   LIKE imaal_t.imaal003
   DEFINE l_imaal004   LIKE imaal_t.imaal004
   DEFINE l_oocal003   LIKE oocal_t.oocal003
   DEFINE r_success    LIKE type_t.num5
   
   DISPLAY BY NAME g_rmdb_m.rmdbseq
   DISPLAY BY NAME g_rmdb_m.rmdb003
   DISPLAY BY NAME g_rmdb_m.rmdb004
   DISPLAY BY NAME g_rmdb_m.rmdb005
   DISPLAY BY NAME g_rmdb_m.rmdb006
   
   #品名、規格desc
   LET l_imaal003 = ''
   LET l_imaal004 = ''
   CALL s_desc_get_item_desc(g_rmdb_m.rmdb003) RETURNING l_imaal003,l_imaal004
   DISPLAY l_imaal003 TO g_rmdb_m.rmdb003_desc
   DISPLAY l_imaal004 TO g_rmdb_m.rmdb003_desc1
   
   #产品特征说明
   IF NOT cl_null(g_rmdb_m.rmdb004) THEN
      CALL s_feature_description(g_rmdb_m.rmdb003,g_rmdb_m.rmdb004) RETURNING r_success,g_rmdb_m.rmdb004_desc
      DISPLAY BY NAME g_rmdb_m.rmdb004_desc
   END IF
   
   #單位說明
   LET l_oocal003 = ''
   CALL s_desc_get_unit_desc(g_rmdb_m.rmdb005) RETURNING l_oocal003
   DISPLAY l_oocal003 TO g_rmdb_m.rmdb005_desc
   
END FUNCTION

################################################################################
# Descriptions...: 检查是否已有多库储批资料
# Memo...........:
# Usage..........: armt400_01_rmdc_count())
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_rmdc_count()
DEFINE l_n          LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE   
   LET l_n = 0
   
   SELECT COUNT(rmdcseq1) INTO l_n
     FROM rmdc_t
    WHERE rmdcent = g_enterprise
      AND rmdcdocno = g_rmdb_m.rmdbdocno
      AND rmdcseq = g_rmdb_m.rmdbseq

   IF l_n < 2 THEN   #一筆也視作無多庫儲批
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 列出已输入多库储批资料
# Memo...........:
# Usage..........: CALL armt400_01_insert_temp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_insert_temp_table()
   DEFINE l_sql        STRING
   DEFINE l_rmdc       type_g_rmdc_d
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
            
   LET l_sql = "SELECT rmdcseq1,",
               "       rmdc001,rmdc002,rmdc003,rmdc005,'',rmdc006,'',",
               "       rmdc007,rmdc008,rmdc003,'',rmdc004,rmdcsite",
               "  FROM rmdc_t",
               " WHERE rmdcent = '",g_enterprise,"'",
               "   AND rmdcdocno = '",g_rmdb_m.rmdbdocno,"'",
               "   AND rmdcseq = '",g_rmdb_m.rmdbseq,"'",
               " ORDER BY rmdcseq1"
   
   PREPARE armt400_01_temp_pre FROM l_sql
   DECLARE armt400_01_temp_cs CURSOR FOR armt400_01_temp_pre
   
   INITIALIZE l_rmdc.* TO NULL

   FOREACH armt400_01_temp_cs INTO l_rmdc.rmdcseq1,
                                   l_rmdc.rmdc001,l_rmdc.rmdc002,l_rmdc.rmdc003,l_rmdc.rmdc005,l_rmdc.rmdc005_desc,
                                   l_rmdc.rmdc006,l_rmdc.rmdc006_desc,l_rmdc.rmdc007,l_rmdc.rmdc008,l_rmdc.rmdc003,
                                   l_rmdc.rmdc003_desc,l_rmdc.rmdc004,l_rmdc.rmdcsite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
      CALL s_desc_get_stock_desc(l_rmdc.rmdcsite,l_rmdc.rmdc005) RETURNING l_rmdc.rmdc005_desc
      CALL s_desc_get_locator_desc(l_rmdc.rmdcsite,l_rmdc.rmdc005,l_rmdc.rmdc006) RETURNING l_rmdc.rmdc006_desc
      CALL s_desc_get_unit_desc(l_rmdc.rmdc003) RETURNING l_rmdc.rmdc003_desc
      
      INSERT INTO armt400_01_temp(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,
                                  rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,
                                  rmdc006,rmdc007,rmdc008)
           VALUES(g_enterprise,l_rmdc.rmdcsite,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,l_rmdc.rmdcseq1,
                  l_rmdc.rmdc001,l_rmdc.rmdc002,l_rmdc.rmdc003,l_rmdc.rmdc004,l_rmdc.rmdc005,
                  l_rmdc.rmdc006,l_rmdc.rmdc007,l_rmdc.rmdc008)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   CLOSE armt400_01_temp_cs
   FREE armt400_01_temp_pre
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 列出可选库存
# Memo...........:
# Usage..........: CALL armt400_01_insert_temp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_insert_temp_table1()
   DEFINE l_sql        STRING
   DEFINE l_rmdc       type_g_rmdc_d
   DEFINE r_success    LIKE type_t.num5
   
   DEFINE l_rmdc004    LIKE rmdc_t.rmdc004
   DEFINE l_seq        LIKE type_t.num5
   DEFINE l_num        LIKE type_t.num5
   
   LET r_success = TRUE
   #先列出所有庫存庫儲批，之後再替換上已輸入的資料
   LET l_sql = "SELECT DISTINCT inag004,inag005,inag006,inag003",
               "  FROM inag_t LEFT OUTER JOIN inaa_t ON inag004 = inaa001 AND inagsite = inaasite AND inagent = inaaent ",
               " WHERE inagent = '",g_enterprise,"'",
               "   AND inagsite = '",g_rmdb_m.rmdbsite,"'",
               "   AND inag001 = '",g_rmdb_m.rmdb003,"'",
               "   AND inag002 = '",g_rmdb_m.rmdb004,"'",
               "   AND inag007 = '",g_rmdb_m.rmdb005,"'",
               "   AND inag008 > 0 ",  #2016-5-30 zhujing add
               "   AND inaa010 = 'N' "
                          
   LET l_sql = l_sql," ORDER BY inag004,inag005,inag006,inag003"
  
   PREPARE armt400_01_temp_pre1 FROM l_sql
   DECLARE armt400_01_temp_cs1 CURSOR FOR armt400_01_temp_pre1
   LET l_sql = "SELECT rmdc004 ",
               "  FROM rmdc_t",
               " WHERE rmdcent = '",g_enterprise,"'",
               "   AND rmdcsite = '",g_site,"'",
               "   AND rmdcdocno = '",g_rmdb_m.rmdbdocno,"'",
               "   AND rmdcseq = '",g_rmdb_m.rmdbseq,"'",
               "   AND COALESCE(rmdc005,' ') = COALESCE(?,' ')",
               "   AND COALESCE(rmdc006,' ') = COALESCE(?,' ')",
               "   AND COALESCE(rmdc007,' ') = COALESCE(?,' ')"
 
   PREPARE armt400_01_temp_pre2 FROM l_sql

#   LET l_sql = "SELECT COUNT(rmdcseq1)",
#               "  FROM armt400_01_temp",
#               " WHERE COALESCE(rmdc007,' ') = COALESCE(?,' ')"
#   PREPARE armt400_01_temp_pre4 FROM l_sql
#
   LET l_seq = 0
   INITIALIZE l_rmdc.* TO NULL
   
   FOREACH armt400_01_temp_cs1 INTO l_rmdc.rmdc005,l_rmdc.rmdc006,l_rmdc.rmdc007,l_rmdc.rmdc008  #來源庫儲批

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

#      EXECUTE armt400_01_temp_pre4 USING l_rmdc.rmdc007 INTO l_num
#         
#      IF l_num > 0 THEN
#         CONTINUE FOREACH
#      END IF
#
      LET l_seq = l_seq + 1

      LET l_rmdc.rmdcseq1 = l_seq #項序
      LET l_rmdc.rmdc001 = g_rmdb_m.rmdb003  #料件編號
      LET l_rmdc.rmdc002 = g_rmdb_m.rmdb004  #產品特徵
      LET l_rmdc.rmdc003 = g_rmdb_m.rmdb005  #單位
      
      #替代上已輸入的值
      LET l_rmdc004 = 0
      EXECUTE armt400_01_temp_pre2 USING l_rmdc.rmdc005,l_rmdc.rmdc006,l_rmdc.rmdc007
      INTO l_rmdc004
      
      IF cl_null(l_rmdc004) THEN
         LET l_rmdc004 = 0
      END IF
      LET l_rmdc.rmdc004 = l_rmdc004  #數量
      
      INSERT INTO armt400_01_temp(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,
                                  rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,
                                  rmdc006,rmdc007,rmdc008)
           VALUES(g_enterprise,l_rmdc.rmdcsite,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,l_rmdc.rmdcseq1,
                  l_rmdc.rmdc001,l_rmdc.rmdc002,l_rmdc.rmdc003,l_rmdc.rmdc004,l_rmdc.rmdc005,
                  l_rmdc.rmdc006,l_rmdc.rmdc007,l_rmdc.rmdc008)
                  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   CLOSE armt400_01_temp_cs1
   FREE armt400_01_temp_pre1 
   FREE armt400_01_temp_pre2
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 单身填充
# Memo...........:
# Usage..........: armt400_01_b_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_b_fill()
DEFINE p_control    LIKE type_t.chr5
   DEFINE l_sql        STRING
   
   LET l_sql = "SELECT rmdcseq1,rmdcsite,",
               "       rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,",
               "       rmdc006,rmdc007,rmdc008",
               "  FROM armt400_01_temp",
               " WHERE rmdcent = '",g_enterprise,"'",
               "   AND rmdcdocno = '",g_rmdb_m.rmdbdocno,"'",
               "   AND rmdcseq = '",g_rmdb_m.rmdbseq,"'",
               " ORDER BY rmdcseq1,rmdc004 DESC"

   PREPARE armt400_01_b_pre FROM l_sql
   DECLARE armt400_01_b_cs CURSOR FOR armt400_01_b_pre

   CALL g_rmdc_d.clear()
   LET l_ac = 1
   FOREACH armt400_01_b_cs INTO g_rmdc_d[l_ac].rmdcseq1,g_rmdc_d[l_ac].rmdcsite,
                                g_rmdc_d[l_ac].rmdc001,g_rmdc_d[l_ac].rmdc002,g_rmdc_d[l_ac].rmdc003,g_rmdc_d[l_ac].rmdc004,g_rmdc_d[l_ac].rmdc005,
                                g_rmdc_d[l_ac].rmdc006,g_rmdc_d[l_ac].rmdc007,g_rmdc_d[l_ac].rmdc008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_desc_get_stock_desc(g_rmdb_m.rmdbsite,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
      CALL s_desc_get_locator_desc(g_rmdb_m.rmdbsite,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc
      CALL s_desc_get_unit_desc(g_rmdc_d[l_ac].rmdc003) RETURNING g_rmdc_d[l_ac].rmdc003_desc
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   LET l_ac = l_ac - 1
   CALL g_rmdc_d.deleteElement(g_rmdc_d.getLength())
   LET g_rec_b = l_ac
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE armt400_01_b_cs
   FREE armt400_01_b_pre
END FUNCTION

################################################################################
# Usage..........: CALL armt400_01_set_entry()
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_set_entry()
   CALL cl_set_comp_entry("rmdc006,rmdc007",TRUE)
END FUNCTION

################################################################################
# Usage..........: CALL armt400_01_set_no_entry()
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_set_no_entry()

   #檢查料件是否使用批號
   IF NOT s_axmt540_imaf061_chk(g_rmdc_d[l_ac].rmdc001) THEN
      CALL cl_set_comp_entry("rmdc007",FALSE)
   END IF

   #儲位控管若為5.不使用儲位控管
   IF NOT s_axmt540_inaa007_chk(g_rmdc_d[l_ac].rmdc005) THEN
      CALL cl_set_comp_entry("rmdc006",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 库储批重复检查
# Memo...........:
# Usage..........: CALL armt400_01_repeat_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_repeat_chk()
   DEFINE l_n        LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE

   #可能為Null的欄位
   #產品特徵
   IF cl_null(g_rmdc_d[l_ac].rmdc002) THEN LET g_rmdc_d[l_ac].rmdc002 = ' ' END IF   
   #庫位
   IF cl_null(g_rmdc_d[l_ac].rmdc005) THEN LET g_rmdc_d[l_ac].rmdc005 = ' ' END IF   
   #儲位
   IF cl_null(g_rmdc_d[l_ac].rmdc006) THEN LET g_rmdc_d[l_ac].rmdc006 = ' ' END IF   
   #批號
   IF cl_null(g_rmdc_d[l_ac].rmdc007) THEN LET g_rmdc_d[l_ac].rmdc007 = ' ' END IF
   #庫存管理特徵
   IF cl_null(g_rmdc_d[l_ac].rmdc008) THEN LET g_rmdc_d[l_ac].rmdc008 = ' ' END IF
   
   #重複輸入檢查
   LET l_n = 0
   SELECT COUNT(rmdcseq1) INTO l_n
     FROM armt400_01_temp
    WHERE rmdc005 = g_rmdc_d[l_ac].rmdc005
      AND rmdc006 = g_rmdc_d[l_ac].rmdc006
      AND rmdc007 = g_rmdc_d[l_ac].rmdc007
      AND rmdc008 = g_rmdc_d[l_ac].rmdc008
      AND rmdcseq1 <> g_rmdc_d_t.rmdcseq1   #排除當下這筆
   
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00095'  #庫儲批不可以重複輸入！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 批号检查
# Memo...........:
# Usage..........: CALL armt400_01_rmdc007_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_rmdc007_chk()
   DEFINE r_success    LIKE type_t.num5 
   DEFINE l_n          LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(g_rmdc_d[l_ac].rmdc007) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_rmdc_d[l_ac].rmdc001
      LET g_chkparam.arg3 = g_rmdc_d[l_ac].rmdc002
      LET g_chkparam.arg4 = g_rmdc_d[l_ac].rmdc007

      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inad001_1") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 覆出数量检查
# Memo...........:
# Usage..........: CALL armt400_01_num_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-11 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_num_chk()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_num      LIKE xmdl_t.xmdl018
   DEFINE l_enter    LIKE type_t.num5    #輸入的數量
   DEFINE l_total    LIKE type_t.num5    #輸入該庫儲批總數量
   DEFINE l_rmdc004  LIKE rmdc_t.rmdc004 #數量
   
   LET r_success = TRUE
   
   IF (NOT cl_null(g_rmdc_d[l_ac].rmdc004) AND g_rmdc_d[l_ac].rmdc004 <> 0) THEN

      LET l_enter = 0
      IF NOT cl_null(g_rmdc_d[l_ac].rmdc004) THEN LET l_enter = l_enter + g_rmdc_d[l_ac].rmdc004 END IF
      
      #總數量與項次檢查
      IF NOT armt400_01_sum_chk('1') THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
     
      #檢查是否超過前張單據可輸入值
      #計算庫儲批排除該項序總數
      LET l_total = 0
      LET l_num = 0
      LET l_rmdc004 = 0
      SELECT SUM(rmdc004) INTO l_rmdc004
        FROM armt400_01_temp
       WHERE rmdcent = g_enterprise
         AND rmdcdocno = g_rmdb_m.rmdbdocno
         AND rmdcseq = g_rmdb_m.rmdbseq
         AND rmdcseq1 <> g_rmdc_d_t.rmdcseq1
       
      IF NOT cl_null(l_rmdc004) THEN LET l_num = l_num + l_rmdc004 END IF           
      
      #加上項序數量
      LET l_total = l_enter + l_num
     
      IF l_total > g_rmdb_m.rmdb006 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'arm-00026'  #覆出数量不可大于申请退货数量-已销退数量！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
  END IF
  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt400_01_rmdc_t_insert()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_rmdc_t_insert()
   DEFINE r_rmdb007    LIKE rmdb_t.rmdb007
   DEFINE r_rmdb008    LIKE rmdb_t.rmdb008
   DEFINE r_rmdb009    LIKE rmdb_t.rmdb009
   DEFINE r_rmdb010    LIKE rmdb_t.rmdb010  
   
   DEFINE l_sql        STRING
   DEFINE l_rmdc       type_g_rmdc_d
   DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   LET r_rmdb007 = ''
   LET r_rmdb008 = ''
   LET r_rmdb009 = ''
   LET r_rmdb010 = ''

   #先將原有資料清除
   DELETE FROM rmdc_t
    WHERE rmdcent = g_enterprise
      AND rmdcdocno = g_rmdb_m.rmdbdocno
      AND rmdcseq = g_rmdb_m.rmdbseq


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   END IF
           
   LET l_sql = "SELECT rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,",
               "       rmdc006,rmdc007,rmdc008",
               "  FROM armt400_01_temp",
               " WHERE rmdcent = ",g_enterprise,
               "   AND rmdcdocno = '",g_rmdb_m.rmdbdocno,"'",
               "   AND rmdcseq = '",g_rmdb_m.rmdbseq,"'",
               "   AND COALESCE(rmdc004,0) > 0"
   PREPARE armt400_01_pre1 FROM l_sql
   DECLARE armt400_01_cs1 CURSOR FOR armt400_01_pre1   
   
   INITIALIZE l_rmdc.* TO NULL
   
   FOREACH armt400_01_cs1 INTO l_rmdc.rmdc001,l_rmdc.rmdc002,l_rmdc.rmdc003,l_rmdc.rmdc004,l_rmdc.rmdc005,
                               l_rmdc.rmdc006,l_rmdc.rmdc007,l_rmdc.rmdc008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #要被回寫的欄位預設為0
      IF cl_null(l_rmdc.rmdc004) THEN LET l_rmdc.rmdc004 = 0 END IF  #數量
      
      CALL armt400_01_seq1_max(g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq) RETURNING l_rmdc.rmdcseq1
      
      INSERT INTO rmdc_t(rmdcent,rmdcsite,rmdcdocno,rmdcseq,rmdcseq1,
                         rmdc001,rmdc002,rmdc003,rmdc004,rmdc005,
                         rmdc006,rmdc007,rmdc008)
           VALUES (g_enterprise,g_rmdb_m.rmdbsite,g_rmdb_m.rmdbdocno,g_rmdb_m.rmdbseq,l_rmdc.rmdcseq1,
                   l_rmdc.rmdc001,l_rmdc.rmdc002,l_rmdc.rmdc003,l_rmdc.rmdc004,l_rmdc.rmdc005,
                   l_rmdc.rmdc006,l_rmdc.rmdc007,l_rmdc.rmdc008)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   CLOSE armt400_01_cs1
   FREE armt400_01_pre1

   IF l_rmdc.rmdcseq1 = 1 THEN  #只有一筆
      LET r_rmdb007 = l_rmdc.rmdc005
      LET r_rmdb008 = l_rmdc.rmdc006
      LET r_rmdb009 = l_rmdc.rmdc007
      LET r_rmdb010 = l_rmdc.rmdc008
   END IF

   RETURN r_success,r_rmdb007,r_rmdb008,r_rmdb009,r_rmdb010
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt400_01_seq1_max()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_seq1_max(p_rmdbdocno,p_rmdbseq)
   DEFINE p_rmdbdocno     LIKE rmdb_t.rmdbdocno
   DEFINE p_rmdbseq       LIKE rmdb_t.rmdbseq
   DEFINE r_rmdcseq1      LIKE rmdc_t.rmdcseq1

   LET r_rmdcseq1 = ''

   SELECT MAX(rmdcseq1) + 1 INTO r_rmdcseq1
     FROM rmdc_t
    WHERE rmdcent = g_enterprise
      AND rmdcdocno = p_rmdbdocno
      AND rmdcseq = p_rmdbseq         
   
   IF cl_null(r_rmdcseq1) THEN
      LET r_rmdcseq1 = 1
   END IF
   
   RETURN r_rmdcseq1
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt400_01_create_temp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION armt400_01_create_temp_table()
DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   CALL armt400_01_drop_temp_table()          

   CREATE TEMP TABLE armt400_01_temp
          (rmdcent      SMALLINT,
           rmdcsite     VARCHAR(10),
           rmdcdocno    VARCHAR(20),
           rmdcseq      INTEGER,
           rmdcseq1     INTEGER,
           rmdc001      VARCHAR(40),
           rmdc002      VARCHAR(256),
           rmdc003      VARCHAR(10),
           rmdc004      DECIMAL(20,6),
           rmdc005      VARCHAR(10),
           rmdc006      VARCHAR(10),
           rmdc007      VARCHAR(30),
           rmdc008      VARCHAR(30));
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt400_01_drop_temp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION armt400_01_drop_temp_table()
   DROP TABLE armt400_01_temp
END FUNCTION

################################################################################
# Descriptions...: 多庫儲批資料修改及新增
# Memo...........:
# Usage..........: CALL armt400_01_rmdc_modify(p_rmdcseq,p_rmdasite,p_rmdadocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010,p_rmdb005,p_rmdb006)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION armt400_01_rmdc_modify(p_rmdcseq,p_rmdasite,p_rmdadocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010,p_rmdb005,p_rmdb006)
   DEFINE p_rmdcseq     LIKE rmdc_t.rmdcseq
   DEFINE p_rmdasite    LIKE rmda_t.rmdasite
   DEFINE p_rmdadocno   LIKE rmda_t.rmdadocno
   DEFINE p_rmdbseq     LIKE rmdb_t.rmdbseq      
   DEFINE p_rmdb003     LIKE rmdb_t.rmdb003
   DEFINE p_rmdb004     LIKE rmdb_t.rmdb004
   
   DEFINE p_rmdb007     LIKE rmdb_t.rmdb007
   DEFINE p_rmdb008     LIKE rmdb_t.rmdb008
   DEFINE p_rmdb009     LIKE rmdb_t.rmdb009
   DEFINE p_rmdb010     LIKE rmdb_t.rmdb010
   DEFINE p_rmdb005     LIKE rmdb_t.rmdb005
   DEFINE p_rmdb006     LIKE rmdb_t.rmdb006
   
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(p_rmdadocno) AND NOT cl_null(p_rmdcseq) THEN
      #檢查有無多庫儲批資料
      LET l_n = 0
      SELECT COUNT(rmdcseq1) INTO l_n
        FROM rmdc_t
       WHERE rmdcent = g_enterprise
         AND rmdcdocno = p_rmdadocno
         AND rmdcseq = p_rmdcseq
      
      CASE l_n
         WHEN 0   #無多庫儲批資料，新增一筆                                     
            CALL armt400_01_rmdc_insert(p_rmdasite,p_rmdadocno,p_rmdbseq,                                        
                                        p_rmdb003,p_rmdb004,p_rmdb007,p_rmdb008,
                                        p_rmdb009,p_rmdb010,p_rmdb005,p_rmdb006) 
                 RETURNING r_success
            IF NOT r_success THEN
               RETURN r_success
            END IF
                                    
         WHEN 1   #已有資料，但非多庫儲批出貨
            UPDATE rmdc_t
               SET rmdcseq = p_rmdbseq,  #項次
                   rmdc001 = p_rmdb003,  #料件編號
                   rmdc002 = p_rmdb004,  #產品特徵
                   rmdc003 = p_rmdb005,  #单位
                   rmdc004 = p_rmdb006,  #数量                   
                   rmdc005 = p_rmdb007,  #庫位
                   rmdc006 = p_rmdb008,  #儲位
                   rmdc007 = p_rmdb009,  #批號
                   rmdc008 = p_rmdb010   #庫存管理特徵
             WHERE rmdcent = g_enterprise
               AND rmdcdocno = p_rmdadocno
               AND rmdcseq = p_rmdcseq
                 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "rmdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
                 
               LET r_success = FALSE
               RETURN r_success            
            END IF
            

         OTHERWISE  #已有資料，且為多庫儲批出貨
            UPDATE rmdc_t
               SET rmdcseq = p_rmdbseq  #項次
             WHERE rmdcent = g_enterprise
               AND rmdcdocno = p_rmdadocno
               AND rmdcseq = p_rmdcseq     
                     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "rmdc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
              
               LET r_success = FALSE
               RETURN r_success            
            END IF           
            
      END CASE      
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增多库储批资料
# Memo...........:
# Usage..........: CALL armt400_01_rmdc_insert(p_rmdasite,p_rmdadocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010,p_rmdb005,p_rmdb006)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_rmdc_insert(p_rmdasite,p_rmdadocno,p_rmdbseq,p_rmdb003,p_rmdb004,p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010,p_rmdb005,p_rmdb006)
   DEFINE p_rmdasite  LIKE rmda_t.rmdasite
   DEFINE p_rmdadocno LIKE rmda_t.rmdadocno   
   DEFINE p_rmdbseq   LIKE rmdb_t.rmdbseq
   DEFINE p_rmdb003   LIKE rmdb_t.rmdb003
   DEFINE p_rmdb004   LIKE rmdb_t.rmdb004
   DEFINE p_rmdb005   LIKE rmdb_t.rmdb005
   DEFINE p_rmdb006   LIKE rmdb_t.rmdb006
   DEFINE p_rmdb007   LIKE rmdb_t.rmdb007
   DEFINE p_rmdb008   LIKE rmdb_t.rmdb008
   DEFINE p_rmdb009   LIKE rmdb_t.rmdb009
   DEFINE p_rmdb010   LIKE rmdb_t.rmdb010
   
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE

   INSERT INTO rmdc_t(rmdcent,rmdcsite,rmdcdocno,
                      rmdcseq,rmdcseq1,
                      rmdc001,rmdc002,rmdc003,rmdc004,
                      rmdc005,rmdc006,rmdc007,rmdc008)
        VALUES (g_enterprise,p_rmdasite,p_rmdadocno,
                p_rmdbseq,1,
                p_rmdb003,p_rmdb004,p_rmdb005,p_rmdb006,
                p_rmdb007,p_rmdb008,p_rmdb009,p_rmdb010)                      
                      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "rmdc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success            
   END IF                
                
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除多库储批资料
# Memo...........:
# Usage..........: CALL armt400_01_rmdc_delete(p_rmdadocno,p_rmdbseq,p_pop)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION armt400_01_rmdc_delete(p_rmdadocno,p_rmdbseq,p_pop)
   DEFINE p_rmdadocno   LIKE rmda_t.rmdadocno
   DEFINE p_rmdbseq     LIKE rmdb_t.rmdbseq
   DEFINE p_pop         LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   
   LET r_success = TRUE

   IF NOT cl_null(p_rmdbseq) AND NOT cl_null(p_rmdadocno) THEN
   
      #檢查有無多庫儲批資料
      LET l_n = 0      
      SELECT COUNT(rmdcseq1) INTO l_n
        FROM rmdc_t
       WHERE rmdcent = g_enterprise
         AND rmdcdocno = p_rmdadocno
         AND rmdcseq = p_rmdbseq
   
      #詢問是否刪除多庫儲批
      IF p_pop = 'Y' AND l_n > 1 THEN
         IF NOT cl_ask_confirm('apm-00559') THEN   #是否取消多库储批管理，且删除对应的多库储批明细档？
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      DELETE FROM rmdc_t
       WHERE rmdcent = g_enterprise
         AND rmdcdocno = p_rmdadocno
         AND rmdcseq = p_rmdbseq
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "rmdc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
        
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 覆出总量检查
# Memo...........:
# Usage..........: CALL armt400_01_sum_chk(p_type)
#                  RETURNING 回传参数
# Input parameter: p_type   1.AFTER FIELD 2.AFTER INPUT
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-8-13 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_sum_chk(p_type)
   DEFINE p_type          LIKE type_t.chr1  #1.AFTER FIELD檢查  2.AFTER INPUT檢查
   DEFINE r_success       LIKE type_t.num5

   DEFINE l_rmdc004       LIKE rmdc_t.rmdc004
   DEFINE l_rmdcseq1      LIKE rmdc_t.rmdcseq1
   DEFINE l_sql           STRING
   
   LET r_success = TRUE

   LET l_rmdc004 = ''
   LET l_rmdcseq1 = ''
   
   LET l_sql = "SELECT SUM(COALESCE(rmdc004,0)),COUNT(rmdcseq1)",     
               "  FROM armt400_01_temp",
               " WHERE rmdcent = '",g_enterprise,"'",
               "   AND rmdcdocno = '",g_rmdb_m.rmdbdocno,"'",
               "   AND rmdcseq = '",g_rmdb_m.rmdbseq,"'",
               "   AND (rmdc004 > 0 )"
               
   IF p_type = '1' THEN
      LET l_sql = l_sql," AND rmdcseq1 <> '",g_rmdc_d[l_ac].rmdcseq1,"'"
   END IF

   PREPARE armt400_01_temp_pre3 FROM l_sql
   
   EXECUTE armt400_01_temp_pre3 INTO l_rmdc004,l_rmdcseq1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'EXECUTE'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_rmdc004) THEN LET l_rmdc004 = 0 END IF
   IF cl_null(l_rmdcseq1) THEN LET l_rmdcseq1 = 0 END IF

   CASE p_type
      WHEN '1'  #AFTER FIELD
         IF NOT cl_null(g_rmdc_d[l_ac].rmdc004) THEN LET l_rmdc004 = l_rmdc004 + g_rmdc_d[l_ac].rmdc004 END IF
            
         IF l_rmdc004 > g_rmdb_m.rmdb006 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'arm-00012'   #多庫儲批覆出數量合計不可大於對應項次覆出數量！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

      WHEN '2'  #AFTER INPUT
         IF l_rmdc004 <> g_rmdb_m.rmdb006 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'arm-00030'   #多库储批覆出数量合计不可不等于对应项次覆出数量！
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF

   END CASE
        
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 開窗查詢庫位、儲位、批號及庫存管理特征
# Memo...........:
# Usage..........: CALL armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry(p_type)
#                  RETURNING 回传参数
# p_type 1.庫位2.儲位3.批號4.庫存管理特徵
# Date & Author..: 2015-9-14 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION armt400_01_rmdb007_rmdb008_rmdb009_rmdb010_qry(p_type)
   DEFINE p_type            LIKE type_t.chr1

   
   #開窗i段
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'i'
   LET g_qryparam.reqry = FALSE
   
   LET g_qryparam.default1 = g_rmdc_d[l_ac].rmdc005             #給予default值
   LET g_qryparam.default2 = g_rmdc_d[l_ac].rmdc006
   LET g_qryparam.default3 = g_rmdc_d[l_ac].rmdc007
   LET g_qryparam.default4 = g_rmdc_d[l_ac].rmdc008
     
   #給予arg
   LET g_qryparam.where = "inag007 = '",g_rmdb_m.rmdb005,"' AND inaa010 = 'N' "
   #給予arg
   LET g_qryparam.arg1 = g_rmdb_m.rmdb003
   LET g_qryparam.arg2 = g_rmdb_m.rmdb004
   
   CALL q_inag004_13()          #呼叫開窗
   
   #庫位
   LET g_rmdc_d[l_ac].rmdc005 = g_qryparam.return1              
   DISPLAY g_rmdc_d[l_ac].rmdc005 TO rmdc005
   CALL s_desc_get_stock_desc(g_rmdc_d[l_ac].rmdcsite,g_rmdc_d[l_ac].rmdc005) RETURNING g_rmdc_d[l_ac].rmdc005_desc
      
   #儲位
   LET g_rmdc_d[l_ac].rmdc006 = g_qryparam.return2
   DISPLAY g_rmdc_d[l_ac].rmdc006 TO rmdc006
   CALL s_desc_get_locator_desc(g_rmdc_d[l_ac].rmdcsite,g_rmdc_d[l_ac].rmdc005,g_rmdc_d[l_ac].rmdc006) RETURNING g_rmdc_d[l_ac].rmdc006_desc
   
   #批號
   LET g_rmdc_d[l_ac].rmdc007 = g_qryparam.return3
   DISPLAY g_rmdc_d[l_ac].rmdc007 TO rmdb007
    
   #庫存管理特徵
   LET g_rmdc_d[l_ac].rmdc008 = g_qryparam.return4
   DISPLAY g_rmdc_d[l_ac].rmdc008 TO rmdc008


END FUNCTION

################################################################################
# Descriptions...: 库存量检查
################################################################################
PRIVATE FUNCTION armt400_01_rmdc005_chk(p_rmdc001,p_rmdc002,p_rmdc003,p_rmdc004,p_rmdc005,p_rmdc006,p_rmdc007,p_rmdc008)
DEFINE p_rmdc001     LIKE rmdc_t.rmdc001
DEFINE p_rmdc002     LIKE rmdc_t.rmdc002
DEFINE p_rmdc003     LIKE rmdc_t.rmdc003
DEFINE p_rmdc004     LIKE rmdc_t.rmdc004
DEFINE p_rmdc005     LIKE rmdc_t.rmdc005
DEFINE p_rmdc006     LIKE rmdc_t.rmdc006
DEFINE p_rmdc007     LIKE rmdc_t.rmdc007
DEFINE p_rmdc008     LIKE rmdc_t.rmdc008
DEFINE l_inag008     LIKE inag_t.inag008
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_rmdc002) THEN LET p_rmdc002 = ' ' END IF
   IF cl_null(p_rmdc003) THEN LET p_rmdc003 = ' ' END IF
   IF cl_null(p_rmdc005) THEN LET p_rmdc005 = ' ' END IF
   IF cl_null(p_rmdc004) THEN LET p_rmdc004 = 0 END IF
   IF cl_null(p_rmdc006) THEN LET p_rmdc006 = ' ' END IF
   IF cl_null(p_rmdc007) THEN LET p_rmdc007 = ' ' END IF
   IF cl_null(p_rmdc008) THEN LET p_rmdc008 = ' ' END IF
   
   SELECT inag008 INTO l_inag008
     FROM inag_t
    WHERE inag001 = p_rmdc001
      AND inag002 = p_rmdc002
      AND inag003 = p_rmdc008
      AND inag004 = p_rmdc005
      AND inag005 = p_rmdc006
      AND inag006 = p_rmdc007
      AND inag007 = p_rmdc003
      AND inag008 > 0
      AND inagent = g_enterprise
      AND inagsite = g_site
   IF cl_null(l_inag008) OR l_inag008 < p_rmdc004 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00270'      #当前库存量不足！
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 

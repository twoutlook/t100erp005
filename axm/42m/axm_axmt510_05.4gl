#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt510_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-21 00:31:57), PR版次:0001(2016-11-22 18:23:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axmt510_05
#+ Description: 維護訂單變更單附屬零件明細子作業
#+ Creator....: 02040(2016-11-15 17:26:51)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axmt510_05.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
 
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
PRIVATE TYPE type_g_xmfw_d        RECORD
       xmfw900 LIKE xmfw_t.xmfw900, 
   xmfw901 LIKE xmfw_t.xmfw901, 
   xmfwdocno LIKE xmfw_t.xmfwdocno, 
   xmfwseq LIKE xmfw_t.xmfwseq, 
   xmfwseq1 LIKE xmfw_t.xmfwseq1, 
   sel LIKE type_t.chr500, 
   xmfw012 LIKE xmfw_t.xmfw012, 
   xmfw001 LIKE xmfw_t.xmfw001, 
   xmfw001_desc LIKE type_t.chr500, 
   imaal0041 LIKE type_t.chr500, 
   xmfw010 LIKE xmfw_t.xmfw010, 
   xmfw011 LIKE xmfw_t.xmfw011, 
   xmfw006 LIKE xmfw_t.xmfw006, 
   xmfw007 LIKE xmfw_t.xmfw007, 
   xmfw008 LIKE xmfw_t.xmfw008, 
   xmfw008_desc LIKE type_t.chr500, 
   xmfw009 LIKE xmfw_t.xmfw009, 
   xmfw002 LIKE xmfw_t.xmfw002, 
   xmfw002_desc LIKE type_t.chr500, 
   imaal0042 LIKE type_t.chr500, 
   xmfw004 LIKE xmfw_t.xmfw004, 
   xmfw005 LIKE xmfw_t.xmfw005, 
   xmfw902 LIKE xmfw_t.xmfw902, 
   xmfw902_desc LIKE type_t.chr500, 
   xmfw903 LIKE xmfw_t.xmfw903
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmeg900    LIKE xmeg_t.xmeg900
DEFINE g_xmegdocno  LIKE xmeg_t.xmegdocno
DEFINE g_xmegseq    LIKE xmeg_t.xmegseq
DEFINE g_xmeg001    LIKE xmeg_t.xmeg001      #料件編號
DEFINE g_xmeg011    LIKE xmeg_t.xmeg001      #數量
DEFINE g_xmegunit   LIKE xmeg_t.xmegunit     #出貨據點
DEFINE g_imae037    LIKE imae_t.imae037      #預設BOM特性
DEFINE g_acc2       LIKE gzcb_t.gzcb007      #變更理由碼
#end add-point
 
DEFINE g_xmfw_d          DYNAMIC ARRAY OF type_g_xmfw_d
DEFINE g_xmfw_d_t        type_g_xmfw_d
 
 
DEFINE g_xmfwdocno_t   LIKE xmfw_t.xmfwdocno    #Key值備份
DEFINE g_xmfwseq_t      LIKE xmfw_t.xmfwseq    #Key值備份
DEFINE g_xmfwseq1_t      LIKE xmfw_t.xmfwseq1    #Key值備份
DEFINE g_xmfw900_t      LIKE xmfw_t.xmfw900    #Key值備份
 
 
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
 
{<section id="axmt510_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt510_05(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmeg900,p_xmegdocno,p_xmegseq,p_xmeg001,p_xmeg062,p_xmeg011,p_xmegunit    
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
   DEFINE p_xmeg900       LIKE xmeg_t.xmeg900
   DEFINE p_xmegdocno     LIKE xmeg_t.xmegdocno
   DEFINE p_xmegseq       LIKE xmeg_t.xmegseq  
   DEFINE p_xmeg001       LIKE xmeg_t.xmeg001
   DEFINE p_xmeg062       LIKE xmeg_t.xmeg062   
   DEFINE p_xmeg011       LIKE xmeg_t.xmeg011   #計價數量   
   DEFINE p_xmegunit      LIKE xmeg_t.xmegunit  #出貨據點   
   DEFINE l_forupd_sql    STRING   
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5   
   DEFINE r_success       LIKE type_t.num5
 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt510_05 WITH FORM cl_ap_formpath("axm","axmt510_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE 
   
   IF cl_null(p_xmeg900) THEN
      #傳入參數為空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00110'
      LET g_errparam.extend = p_xmegdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(p_xmegdocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_xmegdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_xmegseq) THEN
      #傳入的項次為空！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00279'
      LET g_errparam.extend = p_xmegseq
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   CALL cl_set_combo_scc_part('xmfw012','2055','4,5')      #子件特性：4可選件 5附屬零件
   LET g_xmeg900 = p_xmeg900
   LET g_xmegdocno = p_xmegdocno
   LET g_xmegseq = p_xmegseq    
   LET g_xmeg001 = p_xmeg001  
   LET g_imae037 = p_xmeg062  
   LET g_xmeg011 = p_xmeg011
   LET g_xmegunit = p_xmegunit
   IF cl_null(g_xmeg011) THEN LET g_xmeg011 = 0 END IF 
   IF cl_null(g_xmegunit) THEN LET g_xmegunit = g_site END IF 
   LET g_acc2 = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
    
   SELECT gzcb008 INTO g_acc2
     FROM gzcb_t,gzzz_t 
    WHERE gzcb001 = '24' 
      AND gzcb002 = gzzz006 
      AND gzzz001 = g_prog
   
   CALL axmt510_05_b_fill() 
    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmfw_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            DISPLAY l_ac TO FORMONLY.idx 
            LET g_xmfw_d_t.* = g_xmfw_d[l_ac].*             

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            LET g_rec_b = g_xmfw_d.getLength()
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfw006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfw_d[l_ac].xmfw006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmfw006
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfw006 name="input.a.page1.xmfw006"
            IF NOT cl_null(g_xmfw_d[l_ac].xmfw006) AND (g_xmfw_d[l_ac].xmfw006 <> g_xmfw_d_t.xmfw006) THEN 
               #重新推算數量：數量 * 組成用量 / 主件底數
               LET g_xmfw_d[l_ac].xmfw009 = g_xmeg011 * g_xmfw_d[l_ac].xmfw006 / g_xmfw_d[l_ac].xmfw007
               LET g_xmfw_d_t.xmfw006 = g_xmfw_d[l_ac].xmfw006
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfw006
            #add-point:BEFORE FIELD xmfw006 name="input.b.page1.xmfw006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfw006
            #add-point:ON CHANGE xmfw006 name="input.g.page1.xmfw006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfw007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfw_d[l_ac].xmfw007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmfw007
            END IF 
 
 
 
            #add-point:AFTER FIELD xmfw007 name="input.a.page1.xmfw007"
            IF NOT cl_null(g_xmfw_d[l_ac].xmfw007) AND (g_xmfw_d[l_ac].xmfw007 <> g_xmfw_d_t.xmfw007) THEN 
               #重新推算數量：數量 * 組成用量 / 主件底數
               LET g_xmfw_d[l_ac].xmfw009 = g_xmeg011 * g_xmfw_d[l_ac].xmfw006 / g_xmfw_d[l_ac].xmfw007
               LET g_xmfw_d_t.xmfw007 = g_xmfw_d[l_ac].xmfw007               
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfw007
            #add-point:BEFORE FIELD xmfw007 name="input.b.page1.xmfw007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfw007
            #add-point:ON CHANGE xmfw007 name="input.g.page1.xmfw007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfw902
            
            #add-point:AFTER FIELD xmfw902 name="input.a.page1.xmfw902"
            
            LET g_xmfw_d[l_ac].xmfw902_desc = ''
            DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc                     
            IF NOT cl_null(g_xmfw_d[l_ac].xmfw902) THEN
               IF NOT s_azzi650_chk_exist(g_acc2,g_xmfw_d[l_ac].xmfw902) THEN
                  LET g_xmfw_d[l_ac].xmfw902 = g_xmfw_d_t.xmfw902
                  CALL s_desc_get_acc_desc(g_acc2,g_xmfw_d[l_ac].xmfw902) RETURNING g_xmfw_d[l_ac].xmfw902_desc
                  DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc  
                  NEXT FIELD CURRENT
               END IF             
               #檢核輸入的理由碼是否在單據別限制範圍內，若不在限制內則不允許使用此理由碼
               CALL s_control_chk_doc('8',g_xmegdocno,g_xmfw_d[l_ac].xmfw902,'','','','') 
                 RETURNING l_success,l_flag
               IF NOT l_success THEN
                  LET g_xmfw_d[l_ac].xmfw902 = g_xmfw_d_t.xmfw902
                  CALL s_desc_get_acc_desc(g_acc2,g_xmfw_d[l_ac].xmfw902) RETURNING g_xmfw_d[l_ac].xmfw902_desc
                  DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc  
                  NEXT FIELD CURRENT
               ELSE
                  IF NOT l_flag THEN
                     LET g_xmfw_d[l_ac].xmfw902 = g_xmfw_d_t.xmfw902
                     CALL s_desc_get_acc_desc(g_acc2,g_xmfw_d[l_ac].xmfw902) RETURNING g_xmfw_d[l_ac].xmfw902_desc
                     DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc  
                     NEXT FIELD CURRENT
                  END IF
               END IF            
            END IF
            CALL s_desc_get_acc_desc(g_acc2,g_xmfw_d[l_ac].xmfw902) RETURNING g_xmfw_d[l_ac].xmfw902_desc
            DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfw902
            #add-point:BEFORE FIELD xmfw902 name="input.b.page1.xmfw902"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfw902
            #add-point:ON CHANGE xmfw902 name="input.g.page1.xmfw902"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfw903
            #add-point:BEFORE FIELD xmfw903 name="input.b.page1.xmfw903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfw903
            
            #add-point:AFTER FIELD xmfw903 name="input.a.page1.xmfw903"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfw903
            #add-point:ON CHANGE xmfw903 name="input.g.page1.xmfw903"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfw006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfw006
            #add-point:ON ACTION controlp INFIELD xmfw006 name="input.c.page1.xmfw006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfw007
            #add-point:ON ACTION controlp INFIELD xmfw007 name="input.c.page1.xmfw007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfw902
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfw902
            #add-point:ON ACTION controlp INFIELD xmfw902 name="input.c.page1.xmfw902"
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfw_d[l_ac].xmfw902             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_acc2            
            CALL q_oocq002()                               #呼叫開窗
            LET g_xmfw_d[l_ac].xmfw902 = g_qryparam.return1              
            DISPLAY g_xmfw_d[l_ac].xmfw902 TO xmfw902              #
            CALL s_desc_get_acc_desc(g_acc2,g_xmfw_d[l_ac].xmfw902) RETURNING g_xmfw_d[l_ac].xmfw902_desc
            DISPLAY BY NAME g_xmfw_d[l_ac].xmfw902_desc
            NEXT FIELD xmfw902                          #返回原欄位
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfw903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfw903
            #add-point:ON ACTION controlp INFIELD xmfw903 name="input.c.page1.xmfw903"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               EXIT DIALOG
            ELSE          
               IF NOT axmt510_05_ins_xmfw() THEN
                  LET r_success = FALSE
                  CONTINUE DIALOG                
               END IF                            
            END IF              
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
   CLOSE WINDOW w_axmt510_05 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = 0
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt510_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt510_05.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt510_05_b_fill()
DEFINE l_sql      STRING
DEFINE i          LIKE type_t.num5
DEFINE l_ac       LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_bmba020  LIKE bmba_t.bmba020    #可選件
DEFINE l_bmba025  LIKE bmba_t.bmba025    #附屬零件
DEFINE l_xmfw006  LIKE xmfw_t.xmfw006
DEFINE l_xmfw007  LIKE xmfw_t.xmfw007


   LET l_sql = "SELECT xmfw900,xmfw901,xmfwdocno,xmfwseq,xmfwseq1, ",
               "           'Y',xmfw012,  xmfw001,xmfw010, xmfw011, ",
               "       xmfw006,xmfw007,  xmfw008,xmfw009, xmfw002, ",
               "       xmfw004,xmfw005,  xmfw902,xmfw903 ",
               "  FROM xmfw_t ",
               " WHERE xmfwent = ",g_enterprise,
               "   AND xmfw900 = '",g_xmeg900,"'",
               "   AND xmfwdocno = '",g_xmegdocno,"'",
               "   AND xmfwseq = '",g_xmegseq,"'"
   PREPARE axmt510_05_xmfw_sel FROM l_sql
   DECLARE axmt510_05_xmfw_curs CURSOR FOR axmt510_05_xmfw_sel
   CALL g_xmfw_d.clear() 
   LET l_ac = 1
   FOREACH axmt510_05_xmfw_curs INTO g_xmfw_d[l_ac].xmfw900,g_xmfw_d[l_ac].xmfw901,g_xmfw_d[l_ac].xmfwdocno,g_xmfw_d[l_ac].xmfwseq,g_xmfw_d[l_ac].xmfwseq1,
                                     g_xmfw_d[l_ac].sel,g_xmfw_d[l_ac].xmfw012,g_xmfw_d[l_ac].xmfw001,g_xmfw_d[l_ac].xmfw010,g_xmfw_d[l_ac].xmfw011,
                                     g_xmfw_d[l_ac].xmfw006,g_xmfw_d[l_ac].xmfw007,g_xmfw_d[l_ac].xmfw008,g_xmfw_d[l_ac].xmfw009,g_xmfw_d[l_ac].xmfw002,
                                     g_xmfw_d[l_ac].xmfw004,g_xmfw_d[l_ac].xmfw005,g_xmfw_d[l_ac].xmfw902,g_xmfw_d[l_ac].xmfw903
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:axmt510_05_xmfw_curs"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT FOREACH
        END IF
        # [C:數量] = 訂單數量*標準組成用量/標準主件底數
        LET g_xmfw_d[l_ac].xmfw009 = g_xmeg011 * g_xmfw_d[l_ac].xmfw010 / g_xmfw_d[l_ac].xmfw011
        
        CALL axmt510_05_xmfw001_ref(g_xmfw_d[l_ac].xmfw001) RETURNING g_xmfw_d[l_ac].xmfw001_desc,g_xmfw_d[l_ac].imaal0041
        CALL axmt510_05_xmfw001_ref(g_xmfw_d[l_ac].xmfw002) RETURNING g_xmfw_d[l_ac].xmfw002_desc,g_xmfw_d[l_ac].imaal0042
        CALL axmt510_05_unit_ref(g_xmfw_d[l_ac].xmfw008) RETURNING g_xmfw_d[l_ac].xmfw008_desc         
        LET l_ac = l_ac + 1 

   END FOREACH                               
          
   LET l_sql = "SELECT bmba003,bmba011,bmba012,bmba010,bmba001,bmba007,bmba008,bmba020,bmba025 FROM ( ",  
               "   SELECT DISTINCT bmba003,bmba011,bmba012,bmba010,bmba001,bmba007,bmba008,bmba020,bmba025 FROM bmaa_t,bmba_t ",  #161013-00031#1 add
               "    WHERE bmaa001 = bmba001 AND bmaa002 = bmba002 ",
               "      AND bmaaent = bmbaent AND bmaasite = bmbasite ",
               "      AND bmba005 <= SYSDATE ",    
               "      AND (bmba006 >= SYSDATE OR bmba006 IS NULL) ",
               "   Connect by bmba001 = prior bmba003  AND bmba002 = prior bmba002 ",
               "              AND bmbasite = prior bmbasite ",     
               "   Start with bmaa001 = '",g_xmeg001,"' ",
               "          AND bmaa002 = '",g_imae037,"' ",
               "          AND bmbasite = '",g_xmegunit,"' ",
               "   ) ", 
               " WHERE (bmba025 = 'Y' OR bmba020 = 'Y') ",
               "   AND NOT EXISTS ( ",
               "                    SELECT 1 FROM xmfw_t ",
               "                     WHERE xmfwent = ",g_enterprise,
               "                       AND xmfw900 = '",g_xmeg900,"'",
               "                       AND xmfwdocno = '",g_xmegdocno,"'",
               "                       AND xmfwseq = '",g_xmegseq,"'",
               "                       AND xmfw001 = bmba003 AND xmfw002 = bmba001 ",
              #"                       AND xmfw003 = bmba004 ",           #部位編號    
               "                       AND xmfw004 = bmba007 AND xmfw005 = bmba008 ",
               "                   )"
   PREPARE axmt510_05_bmba_sel FROM l_sql
   DECLARE axmt510_05_bmba_curs CURSOR FOR axmt510_05_bmba_sel   

   FOREACH axmt510_05_bmba_curs INTO g_xmfw_d[l_ac].xmfw001,g_xmfw_d[l_ac].xmfw010,g_xmfw_d[l_ac].xmfw011,g_xmfw_d[l_ac].xmfw008,
                                     g_xmfw_d[l_ac].xmfw002,g_xmfw_d[l_ac].xmfw004,g_xmfw_d[l_ac].xmfw005,l_bmba020,l_bmba025
                            
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:axmt510_05_bmba_curs"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT FOREACH
        END IF
      
        LET g_xmfw_d[l_ac].sel = 'N'
        IF l_bmba020 = 'Y' AND l_bmba025 = 'Y' THEN
           LET g_xmfw_d[l_ac].xmfw012 = '4'
        ELSE
           IF l_bmba020 = 'Y'  THEN
              LET g_xmfw_d[l_ac].xmfw012 = '4'
           ELSE
              IF l_bmba025 = 'Y' THEN
                 LET g_xmfw_d[l_ac].xmfw012 = '5'
              END IF
           END IF
        END IF
        LET g_xmfw_d[l_ac].xmfw900 = g_xmeg900      #變更序
        LET g_xmfw_d[l_ac].xmfw901 = '3'            #變更類型3單身新增
        LET g_xmfw_d[l_ac].xmfwdocno = g_xmegdocno
        LET g_xmfw_d[l_ac].xmfwseq = g_xmegseq
        LET g_xmfw_d[l_ac].xmfwseq1 = l_ac
        LET g_xmfw_d[l_ac].xmfw006 = g_xmfw_d[l_ac].xmfw010 
        LET g_xmfw_d[l_ac].xmfw007 = g_xmfw_d[l_ac].xmfw011 
        
        # [C:數量] = 訂單數量*標準組成用量/標準主件底數
        LET g_xmfw_d[l_ac].xmfw009 = g_xmeg011 * g_xmfw_d[l_ac].xmfw010 / g_xmfw_d[l_ac].xmfw011
        
        CALL axmt510_05_xmfw001_ref(g_xmfw_d[l_ac].xmfw001) RETURNING g_xmfw_d[l_ac].xmfw001_desc,g_xmfw_d[l_ac].imaal0041
        CALL axmt510_05_xmfw001_ref(g_xmfw_d[l_ac].xmfw002) RETURNING g_xmfw_d[l_ac].xmfw002_desc,g_xmfw_d[l_ac].imaal0042
        CALL axmt510_05_unit_ref(g_xmfw_d[l_ac].xmfw008) RETURNING g_xmfw_d[l_ac].xmfw008_desc       
        LET l_ac = l_ac + 1       
   END FOREACH
   CALL g_xmfw_d.deleteElement(g_xmfw_d.getLength())
   
   LET g_rec_b = l_ac - 1   
 

   DISPLAY g_max_rec TO FORMONLY.h_count

   CLOSE axmt510_05_xmfw_curs
   FREE axmt510_05_xmfw_sel

   CLOSE axmt510_05_bmba_curs
   FREE axmt510_05_bmba_sel

      
END FUNCTION
#單位名稱顯示
PRIVATE FUNCTION axmt510_05_unit_ref(p_xmfw008)
DEFINE p_xmfw008      LIKE xmfw_t.xmfw008
DEFINE r_xmfw008_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmfw008
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_xmfw008_desc = '', g_rtn_fields[1] , ''
       RETURN r_xmfw008_desc
       
END FUNCTION
#品名、規格說明
PRIVATE FUNCTION axmt510_05_xmfw001_ref(p_xmfw001)
DEFINE p_xmfw001     LIKE xmfw_t.xmfw001
DEFINE r_imaal003    LIKE imaal_t.imaal003
DEFINE r_imaal004    LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmfw001
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields 
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
END FUNCTION

################################################################################
# Descriptions...: INSERT INTO xmfw_t
# Memo...........:
# Usage..........: CALL axmt510_05_ins_xmfw()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: 161119 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt510_05_ins_xmfw()
DEFINE l_xmfwseq1 LIKE xmfw_t.xmfwseq1
DEFINE l_xmdq006  LIKE xmdq_t.xmdq006
DEFINE l_xmdq007  LIKE xmdq_t.xmdq007
DEFINE l_cnt      LIKE type_t.num5
DEFINE i          LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt
     FROM xmfw_t 
    WHERE xmfwent = g_enterprise
      AND xmfw900 = g_xmeg900
      AND xmfwdocno = g_xmegdocno
      AND xmfwseq = g_xmegseq
   IF l_cnt > 0 THEN
      DELETE FROM xmfw_t
       WHERE xmfwent = g_enterprise
         AND xmfw900 = g_xmeg900
         AND xmfwdocno = g_xmegdocno
         AND xmfwseq = g_xmegseq
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DELETE xmfw_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success                                      
      END IF         
   END IF
    
   FOR i = 1 TO g_xmfw_d.getLength() 
       IF g_xmfw_d[i].sel = 'N' THEN
          CONTINUE FOR
       END IF
       LET l_xmdq006 = ''
       LET l_xmdq007 = ''
       SELECT xmdq006,xmdq007 INTO l_xmdq006,l_xmdq007
         FROM xmdq_t
        WHERE xmdqent = g_enterprise
          AND xmdqdocno = g_xmegdocno
          AND xmdqseq = g_xmegseq
          AND xmdq001 = g_xmfw_d[i].xmfw001  #附屬零件料號
          AND xmdq002 = g_xmfw_d[i].xmfw002  #主件料號
         #AND xmdq003 = g_xmfw_d[i].xmfw003  #部位編號
          AND xmdq004 = g_xmfw_d[i].xmfw004  #作業編號
          AND xmdq005 = g_xmfw_d[i].xmfw005  #作業序     
       IF SQLCA.sqlcode = 100 THEN
          LET g_xmfw_d[i].xmfw901 = '3'   #單身新增     
          
       ELSE           
          IF l_xmdq006 <> g_xmfw_d[i].xmfw006 OR l_xmdq007 <> g_xmfw_d[i].xmfw007 THEN
             LET g_xmfw_d[i].xmfw901 = '2'   #單身修改
          ELSE
             LET g_xmfw_d[i].xmfw901 = 'N'   
          END IF
       END IF    

       SELECT MAX(xmfwseq1) + 1 INTO l_xmfwseq1
         FROM xmfw_t
        WHERE xmfwent = g_enterprise
          AND xmfw900 = g_xmeg900
          AND xmfwdocno = g_xmegdocno
          AND xmfwseq = g_xmegseq
       IF cl_null(l_xmfwseq1) OR l_xmfwseq1 = 0 THEN
          LET l_xmfwseq1 = 1
       END IF  
         
       INSERT INTO xmfw_t (xmfwent,xmfwsite,xmfwdocno,xmfwseq,xmfwseq1,
                           xmfw001,xmfw002,xmfw004,xmfw005,xmfw006,
                           xmfw007,xmfw008,xmfw009,xmfw010,xmfw011,
                           xmfw012,xmfw900,xmfw901,xmfw902,xmfw903)
           VALUES (g_enterprise,g_site,g_xmegdocno,g_xmegseq,l_xmfwseq1,
                   g_xmfw_d[i].xmfw001,g_xmfw_d[i].xmfw002,g_xmfw_d[i].xmfw004,g_xmfw_d[i].xmfw005,g_xmfw_d[i].xmfw006,
                   g_xmfw_d[i].xmfw007,g_xmfw_d[i].xmfw008,g_xmfw_d[i].xmfw009,g_xmfw_d[i].xmfw010,g_xmfw_d[i].xmfw011,
                   g_xmfw_d[i].xmfw012,g_xmfw_d[i].xmfw900,g_xmfw_d[i].xmfw901,g_xmfw_d[i].xmfw902,g_xmfw_d[i].xmfw903) 
       IF SQLCA.SQLcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "INSERT INTO xmfw_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success                                      
       END IF
       CASE g_xmfw_d[i].xmfw901              
         WHEN '2'  #單身修改
           IF l_xmdq006 <> g_xmfw_d[i].xmfw006 THEN
              IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw006",g_xmfw_d[i].xmfw901,l_xmdq006,g_xmfw_d[i].xmfw006,g_xmegdocno,g_xmeg900) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           IF l_xmdq007 <> g_xmfw_d[i].xmfw007 THEN
              IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw007",g_xmfw_d[i].xmfw901,l_xmdq007,g_xmfw_d[i].xmfw007,g_xmegdocno,g_xmeg900) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF             
           END IF          
         WHEN '3'  #新增
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw001",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw001,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF            
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw006",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw006,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw007",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw007,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF             
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw008",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw008,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw009",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw009,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF  
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw002",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw002,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw004",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw004,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
            IF NOT s_axmt510_ins_xmek(g_xmegseq,l_xmfwseq1,0,"xmfw005",g_xmfw_d[i].xmfw901,'',g_xmfw_d[i].xmfw005,g_xmegdocno,g_xmeg900) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF            
       END CASE    
       
   END FOR  
   RETURN r_success   
END FUNCTION

 
{</section>}
 
